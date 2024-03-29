# -*- autoconf -*-
# Process this file with autoconf to produce a configure script.

# Copyright (C) 1991-2012 Free Software Foundation, Inc.

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

dnl Written by Jim Meyering.

AC_PREREQ([2.64])

# Make inter-release version strings look like, e.g., v6.9-219-g58ddd, which
# indicates that it is built from the 219th delta (in _some_ repository)
# following the v6.9 tag, and that 58ddd is a prefix of the commit SHA1.
AC_INIT([GNU coreutils],
        m4_esyscmd([build-aux/git-version-gen .tarball-version]),
        [bug-coreutils@gnu.org])

AC_CONFIG_SRCDIR([src/ls.c])

AC_CONFIG_AUX_DIR([build-aux])
AC_CONFIG_HEADERS([lib/config.h:lib/config.hin])

AM_INIT_AUTOMAKE([1.11.2 no-dist-gzip dist-xz color-tests parallel-tests
                  subdir-objects])
AM_SILENT_RULES([yes]) # make --enable-silent-rules the default.

dnl POSIXCHECK is worthwhile for maintainers, but adds several seconds
dnl (more than 10% execution time) to ./configure, with no benefit for
dnl most users.  Using it to look for bugs requires:
dnl   GNULIB_POSIXCHECK=1 autoreconf -f
dnl   ./configure
dnl   make
dnl   make -C src clean
dnl   make CFLAGS=-DGNULIB_POSIXCHECK=1
dnl FIXME: Once we figure out how to avoid false positives, we should
dnl have 'make my-distcheck' in dist-check.mk exercise this.
m4_syscmd([test "${GNULIB_POSIXCHECK+set}" = set])
m4_if(m4_sysval, [0], [], [dnl
gl_ASSERT_NO_GNULIB_POSIXCHECK])

AC_PROG_CC_STDC
AM_PROG_CC_C_O
AC_PROG_CPP
AC_PROG_GCC_TRADITIONAL
AC_PROG_RANLIB
AC_PROG_LN_S
gl_EARLY
gl_INIT
coreutils_MACROS

# The test suite needs to know if we have a working perl.
# FIXME: this is suboptimal.  Ideally, we would be able to call gl_PERL
# with an ACTION-IF-NOT-FOUND argument ...
cu_have_perl=yes
case $PERL in *"/missing "*) cu_have_perl=no;; esac
AM_CONDITIONAL([HAVE_PERL], [test $cu_have_perl = yes])

AC_ARG_ENABLE([gcc-warnings],
  [AS_HELP_STRING([--enable-gcc-warnings],
     [turn on many GCC warnings (for developers; best with GNU make)])],
  [case $enableval in
     yes|no) ;;
     *)      AC_MSG_ERROR([bad value $enableval for gcc-warnings option]) ;;
   esac
   gl_gcc_warnings=$enableval],
  [if test -d "$srcdir"/.git; then
     gl_gcc_warnings=yes
   else
     gl_gcc_warnings=no
   fi]
)

# gl_GCC_VERSION_IFELSE([major], [minor], [run-if-found], [run-if-not-found])
# ------------------------------------------------
# If $CPP is gcc-MAJOR.MINOR or newer, then run RUN-IF-FOUND.
# Otherwise, run RUN-IF-NOT-FOUND.
AC_DEFUN([gl_GCC_VERSION_IFELSE],
  [AC_PREPROC_IFELSE(
    [AC_LANG_PROGRAM(
      [[
#if ($1) < __GNUC__ || (($1) == __GNUC__ && ($2) <= __GNUC_MINOR__)
/* ok */
#else
# error "your version of gcc is older than $1.$2"
#endif
      ]]),
    ], [$3], [$4])
  ]
)

if test "$gl_gcc_warnings" = yes; then
  gl_WARN_ADD([-Werror], [WERROR_CFLAGS])
  AC_SUBST([WERROR_CFLAGS])

  nw=
  # This, $nw, is the list of warnings we disable.
  nw="$nw -Wdeclaration-after-statement" # too useful to forbid
  nw="$nw -Waggregate-return"       # anachronistic
  nw="$nw -Wlong-long"              # C90 is anachronistic (lib/gethrxtime.h)
  nw="$nw -Wc++-compat"             # We don't care about C++ compilers
  nw="$nw -Wundef"                  # Warns on '#if GNULIB_FOO' etc in gnulib
  nw="$nw -Wtraditional"            # Warns on #elif which we use often
  nw="$nw -Wcast-qual"              # Too many warnings for now
  nw="$nw -Wconversion"             # Too many warnings for now
  nw="$nw -Wsystem-headers"         # Don't let system headers trigger warnings
  nw="$nw -Wsign-conversion"        # Too many warnings for now
  nw="$nw -Wtraditional-conversion" # Too many warnings for now
  nw="$nw -Wunreachable-code"       # Too many warnings for now
  nw="$nw -Wpadded"                 # Our structs are not padded
  nw="$nw -Wredundant-decls"        # openat.h declares e.g., mkdirat
  nw="$nw -Wlogical-op"             # any use of fwrite provokes this
  nw="$nw -Wformat-nonliteral"      # who.c and pinky.c strftime uses
  nw="$nw -Wvla"                    # warnings in gettext.h
  nw="$nw -Wnested-externs"         # use of XARGMATCH/verify_function__
  nw="$nw -Wswitch-enum"            # Too many warnings for now
  nw="$nw -Wswitch-default"         # Too many warnings for now
  nw="$nw -Wstack-protector"        # not worth working around
  # things I might fix soon:
  nw="$nw -Wfloat-equal"            # sort.c, seq.c
  nw="$nw -Wmissing-format-attribute" # copy.c
  nw="$nw -Wunsafe-loop-optimizations" # a few src/*.c
  nw="$nw -Winline"                 # system.h's readdir_ignoring_dot_and_dotdot
  nw="$nw -Wsuggest-attribute=format" # warns about copy.c and factor.c

  # Using -Wstrict-overflow is a pain, but the alternative is worse.
  # For an example, see the code that provoked this report:
  # http://gcc.gnu.org/bugzilla/show_bug.cgi?id=33498
  # Code like that still infloops with gcc-4.6.0 and -O2.  Scary indeed.

  gl_MANYWARN_ALL_GCC([ws])
  gl_MANYWARN_COMPLEMENT([ws], [$ws], [$nw])
  for w in $ws; do
    gl_WARN_ADD([$w])
  done
  gl_WARN_ADD([-Wno-sign-compare])     # Too many warnings for now
  gl_WARN_ADD([-Wno-unused-parameter]) # Too many warnings for now
  gl_WARN_ADD([-Wsuggest-attribute=const])
  gl_WARN_ADD([-Wsuggest-attribute=noreturn])
  gl_WARN_ADD([-Wno-format-nonliteral])

  # Enable this warning only with gcc-4.7 and newer.  With 4.6.2 20111027,
  # it suggests test.c's advance function may be pure, even though it
  # increments a global variable.  Oops.
  # Normally we'd write code to test for the precise failure, but that
  # requires a relatively large input to make gcc exhibit the failure.
  gl_GCC_VERSION_IFELSE([4], [7], [gl_WARN_ADD([-Wsuggest-attribute=pure])])

  # In spite of excluding -Wlogical-op above, it is enabled, as of
  # gcc 4.5.0 20090517, and it provokes warnings in cat.c, dd.c, truncate.c
  gl_WARN_ADD([-Wno-logical-op])

  gl_WARN_ADD([-fdiagnostics-show-option])
  gl_WARN_ADD([-funit-at-a-time])

  AC_SUBST([WARN_CFLAGS])

  AC_DEFINE([lint], [1], [Define to 1 if the compiler is checking for lint.])
  AH_VERBATIM([FORTIFY_SOURCE],
  [/* Enable compile-time and run-time bounds-checking, and some warnings,
      without upsetting glibc 2.15+. */
   #if defined __OPTIMIZE__ && __OPTIMIZE__
   # define _FORTIFY_SOURCE 2
   #endif
  ])
  AC_DEFINE([GNULIB_PORTCHECK], [1], [enable some gnulib portability checks])

  # We use a slightly smaller set of warning options for lib/.
  # Remove the following and save the result in GNULIB_WARN_CFLAGS.
  nw=
  nw="$nw -Wstrict-overflow"
  nw="$nw -Wuninitialized"
  nw="$nw -Wunused-macros"
  nw="$nw -Wmissing-prototypes"
  nw="$nw -Wold-style-definition"
  # FIXME: it may be easy to remove this, since it affects only one file:
  # the snprintf call at ftoastr.c:132.
  nw="$nw -Wdouble-promotion"
  gl_MANYWARN_COMPLEMENT([GNULIB_WARN_CFLAGS], [$WARN_CFLAGS], [$nw])
  AC_SUBST([GNULIB_WARN_CFLAGS])

  # For gnulib-tests, the set is slightly smaller still.
  nw=
  nw="$nw -Wstrict-prototypes"
  # It's not worth being this picky about test programs.
  nw="$nw -Wsuggest-attribute=const"
  nw="$nw -Wsuggest-attribute=pure"
  gl_MANYWARN_COMPLEMENT([GNULIB_TEST_WARN_CFLAGS],
                         [$GNULIB_WARN_CFLAGS], [$nw])
  AC_SUBST([GNULIB_TEST_WARN_CFLAGS])
fi

AC_FUNC_FORK

optional_bin_progs=
AC_CHECK_FUNCS([chroot],
        gl_ADD_PROG([optional_bin_progs], [chroot]))
AC_CHECK_FUNCS([gethostid],
        gl_ADD_PROG([optional_bin_progs], [hostid]))

gl_WINSIZE_IN_PTEM

AC_MSG_CHECKING([whether localtime caches TZ])
AC_CACHE_VAL([utils_cv_localtime_cache],
[if test x$ac_cv_func_tzset = xyes; then
AC_RUN_IFELSE([AC_LANG_SOURCE([[#include <time.h>
#if STDC_HEADERS
# include <stdlib.h>
#endif
extern char **environ;
void unset_TZ (void)
{
  char **from, **to;
  for (to = from = environ; (*to = *from); from++)
    if (! (to[0][0] == 'T' && to[0][1] == 'Z' && to[0][2] == '='))
      to++;
}
int main()
{
  time_t now = time ((time_t *) 0);
  int hour_GMT0, hour_unset;
  if (putenv ("TZ=GMT0") != 0)
    return 1;
  hour_GMT0 = localtime (&now)->tm_hour;
  unset_TZ ();
  hour_unset = localtime (&now)->tm_hour;
  if (putenv ("TZ=PST8") != 0)
    return 1;
  if (localtime (&now)->tm_hour == hour_GMT0)
    return 1;
  unset_TZ ();
  if (localtime (&now)->tm_hour != hour_unset)
    return 1;
  return 0;
}]])],
[utils_cv_localtime_cache=no],
[utils_cv_localtime_cache=yes],
[# If we have tzset, assume the worst when cross-compiling.
utils_cv_localtime_cache=yes])
else
        # If we lack tzset, report that localtime does not cache TZ,
        # since we can't invalidate the cache if we don't have tzset.
        utils_cv_localtime_cache=no
fi])dnl
AC_MSG_RESULT([$utils_cv_localtime_cache])
if test $utils_cv_localtime_cache = yes; then
  AC_DEFINE([LOCALTIME_CACHE], [1], [FIXME])
fi

# SCO-ODT-3.0 is reported to need -los to link programs using initgroups
AC_CHECK_FUNCS([initgroups])
if test $ac_cv_func_initgroups = no; then
  AC_CHECK_LIB([os], [initgroups])
fi

AC_CHECK_FUNCS([syslog])
if test $ac_cv_func_syslog = no; then
  # syslog is not in the default libraries.  See if it's in some other.
  for lib in bsd socket inet; do
    AC_CHECK_LIB([$lib], [syslog], [AC_DEFINE([HAVE_SYSLOG], [1], [FIXME])
      LIBS="$LIBS -l$lib"; break])
  done
fi

AC_CACHE_CHECK([for 3-argument setpriority function],
  [utils_cv_func_setpriority],
  [AC_LINK_IFELSE(
    [AC_LANG_PROGRAM(
       [[#include <sys/time.h>
         #include <sys/resource.h>
       ]],
       [[setpriority (0, 0, 0);]])],
    [utils_cv_func_setpriority=yes],
    [utils_cv_func_setpriority=no])])
if test $utils_cv_func_setpriority = no; then
  AC_CHECK_FUNCS([nice])
fi
case $utils_cv_func_setpriority,$ac_cv_func_nice in
*yes*)
  gl_ADD_PROG([optional_bin_progs], [nice])
esac

AC_DEFUN([coreutils_DUMMY_1],
[
  AC_REQUIRE([gl_READUTMP])
  if test $ac_cv_header_utmp_h = yes || test $ac_cv_header_utmpx_h = yes; then
    gl_ADD_PROG([optional_bin_progs], [who])
    gl_ADD_PROG([optional_bin_progs], [users])
    gl_ADD_PROG([optional_bin_progs], [pinky])
  fi
])
coreutils_DUMMY_1

AC_MSG_CHECKING([ut_host in struct utmp])
AC_CACHE_VAL([su_cv_func_ut_host_in_utmp],
[AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <sys/types.h>
#include <utmp.h>]], [[struct utmp ut; return !sizeof ut.ut_host;]])],
  [su_cv_func_ut_host_in_utmp=yes],
  [su_cv_func_ut_host_in_utmp=no])])
AC_MSG_RESULT([$su_cv_func_ut_host_in_utmp])
if test $su_cv_func_ut_host_in_utmp = yes; then
  have_ut_host=1
  AC_DEFINE([HAVE_UT_HOST], [1], [FIXME])
fi

if test -z "$have_ut_host"; then
  AC_MSG_CHECKING([ut_host in struct utmpx])
  AC_CACHE_VAL([su_cv_func_ut_host_in_utmpx],
  [AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <sys/types.h>
#include <utmpx.h>]], [[struct utmpx ut; return !sizeof ut.ut_host;]])],
    [su_cv_func_ut_host_in_utmpx=yes],
    [su_cv_func_ut_host_in_utmpx=no])])
  AC_MSG_RESULT([$su_cv_func_ut_host_in_utmpx])
  if test $su_cv_func_ut_host_in_utmpx = yes; then
    AC_DEFINE([HAVE_UTMPX_H], [1], [FIXME])
    AC_DEFINE([HAVE_UT_HOST], [1], [FIXME])
  fi
fi

GNULIB_BOOT_TIME([gl_ADD_PROG([optional_bin_progs], [uptime])])

AC_SYS_POSIX_TERMIOS()
gl_HEADER_TIOCGWINSZ_NEEDS_SYS_IOCTL

if test $ac_cv_sys_posix_termios = yes; then
  gl_ADD_PROG([optional_bin_progs], [stty])

  AC_MSG_CHECKING([whether termios.h needs _XOPEN_SOURCE])
  AC_CACHE_VAL([su_cv_sys_termios_needs_xopen_source],
  [AC_EGREP_CPP([yes], [#include <termios.h>
#ifdef IUCLC
yes
#endif], su_cv_sys_termios_needs_xopen_source=no,
   AC_EGREP_CPP([yes], [#define _XOPEN_SOURCE
#include <termios.h>
#ifdef IUCLC
yes
#endif], su_cv_sys_termios_needs_xopen_source=yes,
   su_cv_sys_termios_needs_xopen_source=no))])
  AC_MSG_RESULT([$su_cv_sys_termios_needs_xopen_source])
  test $su_cv_sys_termios_needs_xopen_source = yes &&
    AC_DEFINE([TERMIOS_NEEDS_XOPEN_SOURCE], [1], [FIXME])

  AC_MSG_CHECKING([c_line in struct termios])
  AC_CACHE_VAL([su_cv_sys_c_line_in_termios],
  [AC_LINK_IFELSE([AC_LANG_PROGRAM([[#if TERMIOS_NEEDS_XOPEN_SOURCE
#define _XOPEN_SOURCE
#endif
#include <sys/types.h>
#include <termios.h>]], [[struct termios t; return !sizeof t.c_line;]])],
    [su_cv_sys_c_line_in_termios=yes],
    [su_cv_sys_c_line_in_termios=no])])
  AC_MSG_RESULT([$su_cv_sys_c_line_in_termios])
  test $su_cv_sys_c_line_in_termios = yes \
    && AC_DEFINE([HAVE_C_LINE], [1], [FIXME])
fi

# FIXME: note that this macro appears above, too.
# I'm leaving it here for now.  This whole thing needs to be modernized...
gl_WINSIZE_IN_PTEM

gl_HEADER_TIOCGWINSZ_IN_TERMIOS_H

if test $gl_cv_sys_tiocgwinsz_needs_termios_h = no && \
   test $gl_cv_sys_tiocgwinsz_needs_sys_ioctl_h = no; then
  AC_MSG_CHECKING([TIOCGWINSZ in sys/pty.h])
  AC_CACHE_VAL([su_cv_sys_tiocgwinsz_in_sys_pty_h],
  [AC_LINK_IFELSE([AC_LANG_PROGRAM([[#include <sys/types.h>
#ifdef WINSIZE_IN_PTEM
# include <sys/stream.h>
# include <sys/ptem.h>
#endif
#include <sys/ioctl.h>
#include <sys/tty.h>
#include <sys/pty.h>]], [[int x = TIOCGWINSZ;]])],
    [su_cv_sys_tiocgwinsz_in_sys_pty_h=yes],
    [su_cv_sys_tiocgwinsz_in_sys_pty_h=no])])
  AC_MSG_RESULT([$su_cv_sys_tiocgwinsz_in_sys_pty_h])

  test $su_cv_sys_tiocgwinsz_in_sys_pty_h = yes \
      && AC_DEFINE([GWINSZ_IN_SYS_PTY], [1],
                   [Define if your system defines TIOCGWINSZ in sys/pty.h.])
fi

# For src/kill.c.
AC_CHECK_DECLS([strsignal, sys_siglist, _sys_siglist, __sys_siglist], , ,
  [AC_INCLUDES_DEFAULT
#include <signal.h>])

cu_GMP

# Build df only if there's a point to it.
if test $gl_cv_list_mounted_fs = yes && test $gl_cv_fs_space = yes; then
  gl_ADD_PROG([optional_bin_progs], [df])
fi

# Limit stdbuf to ELF systems with GCC
AC_MSG_CHECKING([whether this is an ELF system])
AC_EGREP_CPP([yes], [#if __ELF__
yes
#endif], [elf_sys=yes], [elf_sys=no])
AC_MSG_RESULT([$elf_sys])
if test "$elf_sys" = "yes" && \
   test "$GCC" = "yes"; then
  gl_ADD_PROG([optional_bin_progs], [stdbuf])
fi

############################################################################

dnl Autogenerated by the 'gen-lists-of-programs.sh' auxiliary script.
dnl Issue proper calls to the macros gl_INCLUDE_EXCLUDE_PROG and
dnl gl_ADD_PROG (updating $optional_bin_progs), and generate the list
dnl of coreutils programs to be built only upon explicit user request,
dnl saving that list in the $no_install_progs_default shell variable.
m4_include([m4/cu-progs.m4])

# Now that we know which programs will actually be built, determine
# which optional helper progs should be compiled.
case " $optional_bin_progs " in
  *' stdbuf '*) pkglibexec_PROGRAMS='src/libstdbuf.so';;
  *) pkglibexec_PROGRAMS='';;
esac

man1_MANS=`
  for p in $optional_bin_progs; do
    # Change "ginstall.1" to "install.1".
    test $p = ginstall && p=install
    # Ignore the "[" program, since writing a portable make rule to
    # generate its manpage is not practical.
    dnl Use the autoconf-provided quadrigraph to represent "[",
    dnl otherwise we will incur in dreadful quoting issues.
    test x$p = x'@<:@' && continue
    echo "man/$p.1"
  done`

# Not installed by "make install", but must be built when creating
# a distribution tarball.
EXTRA_MANS=`for p in $no_install_progs_default; do echo man/$p.1; done`

# The programs built and installed by "make && make install".
# Since this is AC_SUBST'd, Automake won't be able to perform rewrite
# with $(EXEEXT) appending on it, so we have to do it ourselves -- in
# this case, only for $(bin_PROGRAMS).
bin_PROGRAMS=`
  for p in $optional_bin_progs; do echo src/"$p"'$(EXEEXT)'; done`

# Normalize whitespace.
man1_MANS=`echo $man1_MANS`
EXTRA_MANS=`echo $EXTRA_MANS`
bin_PROGRAMS=`echo $bin_PROGRAMS`
pkglibexec_PROGS=`echo $pkglibexec_PROGRAMS`

AC_SUBST([bin_PROGRAMS])        AM_SUBST_NOTMAKE([bin_PROGRAMS])
AC_SUBST([pkglibexec_PROGRAMS]) AM_SUBST_NOTMAKE([pkglibexec_PROGRAMS])
AC_SUBST([man1_MANS])           AM_SUBST_NOTMAKE([man1_MANS])
AC_SUBST([EXTRA_MANS])          AM_SUBST_NOTMAKE([EXTRA_MANS])

AC_SUBST([built_programs], [$optional_bin_progs])

AM_CONDITIONAL([CROSS_COMPILING], [test "$cross_compiling" = yes])

############################################################################

# As long as "grep 'PRI[diouxX]' po/*.pot" reports matches in
# translatable strings, we must use need-formatstring-macros here.
AM_GNU_GETTEXT([external], [need-formatstring-macros])
AM_GNU_GETTEXT_VERSION([0.18.1])

# For a test of uniq: it uses the $LOCALE_FR envvar.
gt_LOCALE_FR

AC_CONFIG_FILES(
  Makefile
  po/Makefile.in
  gnulib-tests/Makefile
  )
AC_OUTPUT
