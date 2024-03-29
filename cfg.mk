# Customize maint.mk                           -*- makefile -*-
# Copyright (C) 2003-2012 Free Software Foundation, Inc.

# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.

# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.

# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

# Used in maint.mk's web-manual rule
manual_title = Core GNU utilities

# Use the direct link.  This is guaranteed to work immediately, while
# it can take a while for the faster mirror links to become usable.
url_dir_list = http://ftp.gnu.org/gnu/$(PACKAGE)

# Tests not to run as part of "make distcheck".
local-checks-to-skip = \
  sc_proper_name_utf8_requires_ICONV

# Tools used to bootstrap this package, used for "announcement".
bootstrap-tools = autoconf,automake,gnulib,bison

# Now that we have better tests, make this the default.
export VERBOSE = yes

# Comparing tarball sizes compressed using different xz presets, we see that
# an -8e-compressed tarball is only 9KiB larger than the -9e-compressed one.
# Using -8e is preferred, since that lets the decompression process use half
# the memory (32MiB rather than 64MiB).
# $ for i in {7,8,9}{e,}; do \
#     (n=$(xz -$i < coreutils-8.15*.tar|wc -c);echo $n $i) & done |sort -nr
# 5129388 7
# 5036524 7e
# 5017476 8
# 5010604 9
# 4923016 8e
# 4914152 9e
export XZ_OPT = -8e

old_NEWS_hash = a99128b9985b2e76bdcabf3e5d95ca1a

# Add an exemption for sc_makefile_at_at_check.
_makefile_at_at_check_exceptions = ' && !/^cu_install_program =/'

# Our help-version script is in a slightly different location.
_hv_file ?= $(srcdir)/tests/misc/help-version

# Ensure that the list of O_ symbols used to compute O_FULLBLOCK is complete.
dd = $(srcdir)/src/dd.c
sc_dd_O_FLAGS:
	@rm -f $@.1 $@.2
	@{ echo O_FULLBLOCK; echo O_NOCACHE;				\
	  perl -nle '/^ +\| (O_\w*)$$/ and print $$1' $(dd); } | sort > $@.1
	@{ echo O_NOFOLLOW; perl -nle '/{"[a-z]+",\s*(O_\w+)},/ and print $$1' \
	  $(dd); } | sort > $@.2
	@diff -u $@.1 $@.2 || diff=1 || diff=;				\
	rm -f $@.1 $@.2;						\
	test "$$diff"							\
	  && { echo '$(ME): $(dd) has inconsistent O_ flag lists'>&2;	\
	       exit 1; } || :

# Ensure that dd's definition of LONGEST_SYMBOL stays in sync
# with the strings from the two affected variables.
dd_c = $(srcdir)/src/dd.c
sc_dd_max_sym_length:
ifneq ($(wildcard $(dd_c)),)
	@len=$$( (sed -n '/conversions\[\] =$$/,/^};/p' $(dd_c);\
		 sed -n '/flags\[\] =$$/,/^};/p' $(dd_c) )	\
		|sed -n '/"/s/^[^"]*"\([^"]*\)".*/\1/p'		\
	      | wc --max-line-length);				\
	max=$$(sed -n '/^#define LONGEST_SYMBOL /s///p' $(dd_c)	\
	      |tr -d '"' | wc --max-line-length);		\
	if test "$$len" = "$$max"; then :; else			\
	  echo 'dd.c: LONGEST_SYMBOL is not longest' 1>&2;	\
	  exit 1;						\
	fi
endif

# Many m4 macros names once began with 'jm_'.
# On 2004-04-13, they were all changed to start with gl_ instead.
# Make sure that none are inadvertently reintroduced.
sc_prohibit_jm_in_m4:
	@grep -nE 'jm_[A-Z]'						\
		$$($(VC_LIST) m4 |grep '\.m4$$'; echo /dev/null) &&	\
	    { echo '$(ME): do not use jm_ in m4 macro names'		\
	      1>&2; exit 1; } || :

# Ensure that each root-requiring test is run via the "check-root" rule.
sc_root_tests:
	@t1=sc-root.expected; t2=sc-root.actual;			\
	grep -nl '^ *require_root_$$' `$(VC_LIST) tests` | sort > $$t1;	\
	for t in $(all_root_tests); do echo $$t; done | sort > $$t2;	\
	st=0; diff -u $$t1 $$t2 || st=1;				\
	rm -f $$t1 $$t2;						\
	exit $$st

# Ensure that all version-controlled test cases are listed in $(all_tests).
sc_tests_list_consistency:
	@bs="\\";							\
	test_extensions_rx=`echo $(TEST_EXTENSIONS)			\
	  | sed -e "s/ /|/g" -e "s/$$bs./$$bs$$bs./g"`;			\
	{								\
	  for t in $(all_tests); do echo $$t; done;			\
	  cd $(top_srcdir);						\
	  $(SHELL) build-aux/vc-list-files tests			\
	    | grep -Ev '^tests/(factor/run|init)\.sh$$'			\
	    | $(EGREP) "$$test_extensions_rx\$$";			\
	} | sort | uniq -u | grep . && exit 1; :

# Create a list of regular expressions matching the names
# of files included from system.h.  Exclude a couple.
.re-list:
	@sed -n '/^# *include /s///p' $(srcdir)/src/system.h \
	  | grep -Ev 'sys/(param|file)\.h' \
	  | sed 's/ .*//;;s/^["<]/^# *include [<"]/;s/\.h[">]$$/\\.h[">]/' \
	  > $@-t
	@mv $@-t $@

define gl_trap_
  Exit () { set +e; (exit $$1); exit $$1; };				\
  for sig in 1 2 3 13 15; do						\
    eval "trap 'Exit $$(expr $$sig + 128)' $$sig";			\
  done
endef

# Files in src/ should not include directly any of
# the headers already included via system.h.
sc_system_h_headers: .re-list
	@if test -f $(srcdir)/src/system.h; then			\
	  trap 'rc=$$?; rm -f .re-list; exit $$rc' 0;			\
	  $(gl_trap_);							\
	  grep -nE -f .re-list						\
	      $$($(VC_LIST_EXCEPT) | grep '^\($(srcdir)/\)\?src/')	\
	    && { echo '$(ME): the above are already included via system.h'\
		  1>&2;  exit 1; } || :;				\
	fi

sc_sun_os_names:
	@grep -nEi \
	    'solaris[^[:alnum:]]*2\.(7|8|9|[1-9][0-9])|sunos[^[:alnum:]][6-9]' \
	    $$($(VC_LIST_EXCEPT)) &&					\
	  { echo '$(ME): found misuse of Sun OS version numbers' 1>&2;	\
	    exit 1; } || :

# Ensure that the list of programs and author names is accurate.
# We need a UTF8 locale.  If a lack of locale support or a missing
# translation inhibits printing of UTF-8 names, just skip this test.
au_dotdot = authors-dotdot
au_actual = authors-actual
sc_check-AUTHORS: $(all_programs)
	@locale=en_US.UTF-8;				\
	LC_ALL=$$locale ./src/cat --version		\
	    | grep ' Torbjorn '	> /dev/null		\
	  && { echo "$@: skipping this check"; exit 0; }; \
	rm -f $(au_actual) $(au_dotdot);		\
	for i in `ls $(all_programs)			\
	    | sed -e 's,^src/,,' -e 's,$(EXEEXT)$$,,'	\
	    | sed /libstdbuf/d				\
	    | $(ASSORT) -u`; do				\
	  test "$$i" = '[' && continue;			\
	  exe=$$i;					\
	  if test "$$i" = install; then			\
	    exe=ginstall;				\
	  elif test "$$i" = test; then			\
	    exe='[';					\
	  fi;						\
	  LC_ALL=$$locale ./src/$$exe --version		\
	    | perl -0 -pi -e 's/,\n/, /gm'		\
	    | sed -n -e '/Written by /{ s//'"$$i"': /;'	\
		  -e 's/,* and /, /; s/\.$$//; p; }';	\
	done > $(au_actual) &&				\
	sed -n '/^[^ ][^ ]*:/p' $(srcdir)/AUTHORS > $(au_dotdot) \
	  && diff $(au_actual) $(au_dotdot) \
	  && rm -f $(au_actual) $(au_dotdot)

# Look for lines longer than 80 characters, except omit:
# - program-generated long lines in diff headers,
# - tests involving long checksum lines, and
# - the 'pr' test cases.
LINE_LEN_MAX = 80
FILTER_LONG_LINES =						\
  /^[^:]*\.diff:[^:]*:@@ / d;					\
  \|^[^:]*tests/misc/sha[0-9]*sum.*\.pl[-:]| d;			\
  \|^[^:]*tests/pr/|{ \|^[^:]*tests/pr/pr-tests:| !d; };
sc_long_lines:
	@files=$$($(VC_LIST_EXCEPT))					\
	halt='line(s) with more than $(LINE_LEN_MAX) characters; reindent'; \
	for file in $$files; do						\
	  expand $$file | grep -nE '^.{$(LINE_LEN_MAX)}.' |		\
	  sed -e "s|^|$$file:|" -e '$(FILTER_LONG_LINES)';		\
	done | grep . && { msg="$$halt" $(_sc_say_and_exit) } || :

# Option descriptions should not start with a capital letter.
# One could grep source directly as follows:
# grep -E " {2,6}-.*[^.]  [A-Z][a-z]" $$($(VC_LIST_EXCEPT) | grep '\.c$$')
# but that would miss descriptions not on the same line as the -option.
sc_option_desc_uppercase: $(ALL_MANS)
	@grep '^\\fB\\-' -A1 man/*.1 | LC_ALL=C grep '\.1.[A-Z][a-z]'	\
	  && { echo 1>&2 '$@: found initial capitals in --help'; exit 1; } || :

# Ensure all man/*.[1x] files are present.
sc_man_file_correlation: check-x-vs-1 check-programs-vs-x

# Ensure that for each .x file in the 'man/' subdirectory, there is a
# corresponding .1 file in the definition of $(EXTRA_MANS).
# But since that expansion usually lacks programs like arch and hostname,
# add them here manually.
.PHONY: check-x-vs-1
check-x-vs-1:
	@PATH=./src$(PATH_SEPARATOR)$$PATH; export PATH;		\
	t=$@-t;								\
	(cd $(srcdir)/man && ls -1 *.x)					\
	  | sed 's/\.x$$//' | $(ASSORT) > $$t;				\
	(echo $(patsubst man/%,%,$(ALL_MANS))				\
	  | tr -s ' ' '\n' | sed 's/\.1$$//')				\
	  | $(ASSORT) -u | diff - $$t || { rm $$t; exit 1; };		\
	rm $$t

# Writing a portable rule to generate a manpage like '[.1' would be
# a nightmare, so filter that out.
all-progs-but-lbracket = $(filter-out [,$(patsubst src/%,%,$(all_programs)))

# Ensure that for each coreutils program there is a corresponding
# '.x' file in the 'man/' subdirectory.
.PHONY: check-programs-vs-x
check-programs-vs-x:
	@status=0;					\
	for p in dummy $(all-progs-but-lbracket); do	\
	  case $$p in *.so) continue;; esac;		\
	  test $$p = dummy && continue;			\
	  test $$p = ginstall && p=install || : ;	\
	  test -f $(srcdir)/man/$$p.x			\
	    || { echo missing $$p.x 1>&2; status=1; };	\
	done;						\
	exit $$status

# Ensure that the end of each release's section is marked by two empty lines.
sc_NEWS_two_empty_lines:
	@sed -n 4,/Noteworthy/p $(srcdir)/NEWS				\
	    | perl -n0e '/(^|\n)\n\n\* Noteworthy/ or exit 1'		\
	  || { echo '$(ME): use two empty lines to separate NEWS sections' \
		 1>&2; exit 1; } || :

# With split lines, don't leave an operator at end of line.
# Instead, put it on the following line, where it is more apparent.
# Don't bother checking for "*" at end of line, since it provokes
# far too many false positives, matching constructs like "TYPE *".
# Similarly, omit "=" (initializers).
binop_re_ ?= [-/+^!<>]|[-/+*^!<>=]=|&&?|\|\|?|<<=?|>>=?
sc_prohibit_operator_at_end_of_line:
	@prohibit='. ($(binop_re_))$$'					\
	in_vc_files='\.[chly]$$'					\
	halt='found operator at end of line'				\
	  $(_sc_search_regexp)

# Don't use "readlink" or "readlinkat" directly
sc_prohibit_readlink:
	@prohibit='\<readlink(at)? \('					\
	halt='do not use readlink(at); use via xreadlink or areadlink*'	\
	  $(_sc_search_regexp)

# Don't use address of "stat" or "lstat" functions
sc_prohibit_stat_macro_address:
	@prohibit='\<l?stat '':|&l?stat\>'				\
	halt='stat() and lstat() may be function-like macros'		\
	  $(_sc_search_regexp)

# Ensure that date's --help output stays in sync with the info
# documentation for GNU strftime.  The only exception is %N,
# which date accepts but GNU strftime does not.
extract_char = sed 's/^[^%][^%]*%\(.\).*/\1/'
sc_strftime_check:
	@if test -f $(srcdir)/src/date.c; then				\
	  grep '^  %.  ' $(srcdir)/src/date.c | sort			\
	    | $(extract_char) > $@-src;					\
	  { echo N;							\
	    info libc date calendar format 2>/dev/null|grep '^    `%.'\'\
	      | $(extract_char); } | sort > $@-info;			\
	  if test $$(stat --format %s $@-info) != 2; then		\
	    diff -u $@-src $@-info || exit 1;				\
	  else								\
	    echo '$(ME): skipping $@: libc info not installed' 1>&2;	\
	  fi;								\
	  rm -f $@-src $@-info;						\
	fi

# Indent only with spaces.
sc_prohibit_tab_based_indentation:
	@prohibit='^ *	'						\
	halt='TAB in indentation; use only spaces'			\
	  $(_sc_search_regexp)

# The SEE ALSO section of a man page should not be terminated with
# a period.  Check the first line after each "SEE ALSO" line in man/*.x:
sc_prohibit_man_see_also_period:
	@grep -nB1 '\.$$' $$($(VC_LIST_EXCEPT) | grep 'man/.*\.x$$')	\
	    | grep -A1 -e '-\[SEE ALSO\]' | grep '\.$$' &&		\
	  { echo '$(ME): do not end "SEE ALSO" section with a period'	\
	      1>&2; exit 1; } || :

# Don't use "indent-tabs-mode: nil" anymore.  No longer needed.
sc_prohibit_emacs__indent_tabs_mode__setting:
	@prohibit='^( *[*#] *)?indent-tabs-mode:'			\
	halt='use of emacs indent-tabs-mode: setting'			\
	  $(_sc_search_regexp)

# Ensure that tests don't include a redundant fail=0.
sc_prohibit_fail_0:
	@prohibit='\<fail=0\>'						\
	halt='fail=0 initialization'					\
	  $(_sc_search_regexp)

# The mode part of a setfacl -m option argument must be three bytes long.
# I.e., an argument of user:bin:rw or user:bin:r will make Solaris 10's
# setfacl reject it with: "Unrecognized character found in mode field".
# Use hyphens to give it a length of 3: "...:rw-" or "...:r--".
sc_prohibit_short_facl_mode_spec:
	@prohibit='\<setfacl .*-m.*:.*:[rwx-]{1,2} '			\
	halt='setfacl mode string length < 3; extend with hyphen(s)'	\
	  $(_sc_search_regexp)

# Ensure that "stdio--.h" is used where appropriate.
sc_require_stdio_safer:
	@if $(VC_LIST_EXCEPT) | grep -l '\.[ch]$$' > /dev/null; then	\
	  files=$$(grep -l '\bfreopen \?(' $$($(VC_LIST_EXCEPT)		\
	      | grep '\.[ch]$$'));					\
	  test -n "$$files" && grep -LE 'include "stdio--.h"' $$files	\
	      | grep . &&						\
	  { echo '$(ME): the above files should use "stdio--.h"'	\
		1>&2; exit 1; } || :;					\
	else :;								\
	fi

sc_prohibit_perl_hash_quotes:
	@prohibit="\{'[A-Z_]+' *[=}]"					\
	halt="in Perl code, write \$$hash{KEY}, not \$$hash{'K''EY'}"	\
	  $(_sc_search_regexp)

# Prefer xnanosleep over other less-precise sleep methods
sc_prohibit_sleep:
	@prohibit='\<(nano|u)?sleep \('					\
	halt='prefer xnanosleep over other sleep interfaces'		\
	  $(_sc_search_regexp)

# Use print_ver_ (from init.cfg), not open-coded $VERBOSE check.
sc_prohibit_verbose_version:
	@prohibit='test "\$$VERBOSE" = yes && .* --version'		\
	halt='use the print_ver_ function instead...'			\
	  $(_sc_search_regexp)

# Use framework_failure_, not the old name without the trailing underscore.
sc_prohibit_framework_failure:
	@prohibit='\<framework_''failure\>'				\
	halt='use framework_failure_ instead'				\
	  $(_sc_search_regexp)

# Prohibit the use of `...` in tests/.  Use $(...) instead.
sc_prohibit_test_backticks:
	@prohibit='`' in_vc_files='^tests/'				\
	halt='use $$(...), not `...` in tests/'				\
	  $(_sc_search_regexp)

# Programs like sort, ls, expr use PROG_FAILURE in place of EXIT_FAILURE.
# Others, use the EXIT_CANCELED, EXIT_ENOENT, etc. macros defined in system.h.
# In those programs, ensure that EXIT_FAILURE is not used by mistake.
sc_some_programs_must_avoid_exit_failure:
	@grep -nw EXIT_FAILURE						\
	    $$(git grep -El '[^T]_FAILURE|EXIT_CANCELED' src)		\
	  | grep -vE '= EXIT_FAILURE|exit \(.* \?' | grep .		\
	    && { echo '$(ME): do not use EXIT_FAILURE in the above'	\
		  1>&2; exit 1; } || :

# Ensure that tests call the print_ver_ function for programs which are
# actually used in that test.
sc_prohibit_test_calls_print_ver_with_irrelevant_argument:
	@git grep -w print_ver_ tests					\
	  | sed 's#:print_ver_##'					\
	  | { fail=0;							\
	      while read file name; do					\
		for i in $$name; do					\
		  case "$$i" in install) i=ginstall;; esac;		\
		  grep -w "$$i" $$file|grep -vw print_ver_|grep -q .	\
		    || { fail=1;					\
			 echo "*** Test: $$file, offending: $$i." 1>&2; };\
		done;							\
	      done;							\
	      test $$fail = 0 || exit 1;				\
	    } || { echo "$(ME): the above test(s) call print_ver_ for"	\
		    "program(s) they don't use" 1>&2; exit 1; }

# Exempt the contents of any usage function from the following.
_continued_string_col_1 = \
s/^usage .*?\n}//ms;/\\\n\w/ and print ("$$ARGV\n"),$$e=1;END{$$e||=0;exit $$e}
# Ding any source file that has a continued string with an alphabetic in the
# first column of the following line.  We prohibit them because they usually
# trigger false positives in tools that try to map an arbitrary line number
# to the enclosing function name.  Of course, very many strings do precisely
# this, *when they are part of the usage function*.  That is why we exempt
# the contents of any function named "usage".
sc_prohibit_continued_string_alpha_in_column_1:
	@perl -0777 -ne '$(_continued_string_col_1)' \
	    $$($(VC_LIST_EXCEPT) | grep '\.[ch]$$') \
	  || { echo '$(ME): continued string with word in first column' \
		1>&2; exit 1; } || :
# Use this to list offending lines:
# git ls-files |grep '\.[ch]$' | xargs \
#   perl -n -0777 -e 's/^usage.*?\n}//ms;/\\\n\w/ and print "$ARGV\n"' \
#     | xargs grep -A1 '\\$'|grep '\.[ch][:-][_a-zA-Z]'


###########################################################
_p0 = \([^"'/]\|"\([^\"]\|[\].\)*"\|'\([^\']\|[\].\)*'
_pre = $(_p0)\|[/][^"'/*]\|[/]"\([^\"]\|[\].\)*"\|[/]'\([^\']\|[\].\)*'\)*
_pre_anchored = ^\($(_pre)\)
_comment_and_close = [^*]\|[*][^/*]\)*[*][*]*/
# help font-lock mode: '

# A sed expression that removes ANSI C and ISO C99 comments.
# Derived from the one in GNU gettext's 'moopp' preprocessor.
_sed_remove_comments =					\
/[/][/*]/{						\
  ta;							\
  :a;							\
  s,$(_pre_anchored)//.*,\1,;				\
  te;							\
  s,$(_pre_anchored)/[*]\($(_comment_and_close),\1 ,;	\
  ta;							\
  /^$(_pre)[/][*]/{					\
    s,$(_pre_anchored)/[*].*,\1 ,;			\
    tu;							\
    :u;							\
    n;							\
    s,^\($(_comment_and_close),,;			\
    tv;							\
    s,^.*$$,,;						\
    bu;							\
    :v;							\
  };							\
  :e;							\
}
# Quote all single quotes.
_sed_rm_comments_q = $(subst ','\'',$(_sed_remove_comments))
# help font-lock mode: '

_space_before_paren_exempt =? \\n\\$$
_space_before_paren_exempt = \
  (^ *\#|\\n\\$$|%s\(to %s|(date|group|character)\(s\))
# Ensure that there is a space before each open parenthesis in C code.
sc_space_before_open_paren:
	@if $(VC_LIST_EXCEPT) | grep -l '\.[ch]$$' > /dev/null; then	\
	  fail=0;							\
	  for c in $$($(VC_LIST_EXCEPT) | grep '\.[ch]$$'); do		\
	    sed '$(_sed_rm_comments_q)' $$c 2>/dev/null			\
	      | grep -i '[[:alnum:]]('					\
	      | grep -vE '$(_space_before_paren_exempt)'		\
	      | grep . && { fail=1; echo "*** $$c"; };			\
	  done;								\
	  test $$fail = 1 &&						\
	    { echo '$(ME): the above files lack a space-before-open-paren' \
		1>&2; exit 1; } || :;					\
	else :;								\
	fi

# Similar to the gnulib maint.mk rule for sc_prohibit_strcmp
# Use STREQ_LEN or STRPREFIX rather than comparing strncmp == 0, or != 0.
sc_prohibit_strncmp:
	@grep -nE '! *str''ncmp *\(|\<str''ncmp *\(.+\) *[!=]='		\
	    $$($(VC_LIST_EXCEPT))					\
	  | grep -vE ':# *define STR(N?EQ_LEN|PREFIX)\(' &&		\
	  { echo '$(ME): use STREQ_LEN or STRPREFIX instead of str''ncmp' \
		1>&2; exit 1; } || :

# Enforce recommended preprocessor indentation style.
sc_preprocessor_indentation:
	@if cppi --version >/dev/null 2>&1; then			\
	  $(VC_LIST_EXCEPT) | grep '\.[ch]$$' | xargs cppi -a -c	\
	    || { echo '$(ME): incorrect preprocessor indentation' 1>&2;	\
		exit 1; };						\
	else								\
	  echo '$(ME): skipping test $@: cppi not installed' 1>&2;	\
	fi

# THANKS.in is a list of name/email pairs for people who are mentioned in
# commit logs (and generated ChangeLog), but who are not also listed as an
# author of a commit.  Name/email pairs of commit authors are automatically
# extracted from the repository.  As a very minor factorization, when
# someone who was initially listed only in THANKS.in later authors a commit,
# this rule detects that their pair may now be removed from THANKS.in.
sc_THANKS_in_duplicates:
	@{ git log --pretty=format:%aN | sort -u;			\
	    cut -b-36 THANKS.in | sed '/^$$/d;s/  *$$//'; }		\
	  | sort | uniq -d | grep .					\
	    && { echo '$(ME): remove the above names from THANKS.in'	\
		  1>&2; exit 1; } || :

# Override the default Cc: used in generating an announcement.
announcement_Cc_ = $(translation_project_), \
  coreutils@gnu.org, coreutils-announce@gnu.org

-include $(srcdir)/dist-check.mk

update-copyright-env = \
  UPDATE_COPYRIGHT_FORCE=1 \
  UPDATE_COPYRIGHT_USE_INTERVALS=2 \
  UPDATE_COPYRIGHT_MAX_LINE_LENGTH=79

# List syntax-check exemptions.
exclude_file_name_regexp--sc_space_tab = \
  ^(tests/pr/|tests/misc/nl\.sh$$|gl/.*\.diff$$)
exclude_file_name_regexp--sc_bindtextdomain = \
  ^(gl/.*|lib/euidaccess-stat|src/make-prime-list)\.c$$
exclude_file_name_regexp--sc_trailing_blank = ^tests/pr/
exclude_file_name_regexp--sc_system_h_headers = \
  ^src/((system|copy)\.h|libstdbuf\.c|make-prime-list\.c)$$

_src = (false|lbracket|ls-(dir|ls|vdir)|tac-pipe|uname-(arch|uname))
exclude_file_name_regexp--sc_require_config_h_first = \
  (^lib/buffer-lcm\.c|src/$(_src)\.c)$$
exclude_file_name_regexp--sc_require_config_h = \
  $(exclude_file_name_regexp--sc_require_config_h_first)

exclude_file_name_regexp--sc_po_check = ^gl/
exclude_file_name_regexp--sc_prohibit_always-defined_macros = \
  ^src/(seq|remove)\.c$$
exclude_file_name_regexp--sc_prohibit_empty_lines_at_EOF = ^tests/pr/
exclude_file_name_regexp--sc_program_name = \
  ^(gl/.*|lib/euidaccess-stat|src/make-prime-list)\.c$$
exclude_file_name_regexp--sc_file_system = \
  NEWS|^(init\.cfg|src/df\.c|tests/df/df-P\.sh)$$
exclude_file_name_regexp--sc_prohibit_always_true_header_tests = \
  ^m4/stat-prog\.m4$$
exclude_file_name_regexp--sc_prohibit_fail_0 = \
  (^.*/git-hooks/commit-msg|^tests/init\.sh|Makefile\.am|\.mk|.*\.texi)$$
exclude_file_name_regexp--sc_prohibit_atoi_atof = ^lib/euidaccess-stat\.c$$

# longlong.h is maintained elsewhere.
_ll = ^src/longlong\.h$$
exclude_file_name_regexp--sc_useless_cpp_parens = $(_ll)
exclude_file_name_regexp--sc_long_lines = $(_ll)
exclude_file_name_regexp--sc_space_before_open_paren = $(_ll)

tbi_1 = ^tests/pr/|(^gl/lib/reg.*\.c\.diff|\.mk|^man/help2man)$$
tbi_2 = ^scripts/git-hooks/(pre-commit|pre-applypatch|applypatch-msg)$$
tbi_3 = (GNU)?[Mm]akefile(\.am)?$$|$(_ll)
exclude_file_name_regexp--sc_prohibit_tab_based_indentation = \
  $(tbi_1)|$(tbi_2)|$(tbi_3)

exclude_file_name_regexp--sc_preprocessor_indentation = \
  ^(gl/lib/rand-isaac\.[ch]|gl/tests/test-rand-isaac\.c)$$|$(__ll)
exclude_file_name_regexp--sc_prohibit_stat_st_blocks = \
  ^(src/system\.h|tests/du/2g\.sh)$$

exclude_file_name_regexp--sc_prohibit_continued_string_alpha_in_column_1 = \
  ^src/(system\.h|od\.c|printf\.c)$$

exclude_file_name_regexp--sc_prohibit_test_backticks = \
  ^tests/(init\.sh|local.mk|misc/stdbuf\.sh)$$

# Exempt test.c, since it's nominally shared, and relatively static.
exclude_file_name_regexp--sc_prohibit_operator_at_end_of_line = \
  ^src/(ptx|test|head)\.c$$

exclude_file_name_regexp--sc_error_message_uppercase = ^src/factor\.c$$
exclude_file_name_regexp--sc_prohibit_atoi_atof = ^src/make-prime-list\.c$$

# Augment AM_CFLAGS to include our per-directory options:
AM_CFLAGS += $($(@D)_CFLAGS)

src_CFLAGS = $(WARN_CFLAGS)
lib_CFLAGS = $(GNULIB_WARN_CFLAGS)
gnulib-tests_CFLAGS = $(GNULIB_TEST_WARN_CFLAGS)

# Configuration to make the tight-scope syntax-check rule work with
# non-recursive make.
export _gl_TS_headers = $(srcdir)/cfg.mk
_gl_TS_dir = .
_gl_TS_obj_files = src/*.$(OBJEXT)
_gl_TS_other_headers = src/*.h
