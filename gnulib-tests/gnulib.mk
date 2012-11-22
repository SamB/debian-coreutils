## DO NOT EDIT! GENERATED AUTOMATICALLY!
## Process this file with automake to produce Makefile.in.
# Copyright (C) 2002-2009 Free Software Foundation, Inc.
#
# This file is free software, distributed under the terms of the GNU
# General Public License.  As a special exception to the GNU General
# Public License, this file may be distributed as part of a program
# that contains a configuration script generated by Autoconf, under
# the same distribution terms as the rest of that program.
#
# Generated by gnulib-tool.

AUTOMAKE_OPTIONS = 1.5 foreign

SUBDIRS =
TESTS =
TESTS_ENVIRONMENT =
noinst_PROGRAMS =
check_PROGRAMS =
noinst_HEADERS =
noinst_LIBRARIES =
check_LIBRARIES = libtests.a
EXTRA_DIST =
BUILT_SOURCES =
SUFFIXES =
MOSTLYCLEANFILES = core *.stackdump
MOSTLYCLEANDIRS =
CLEANFILES =
DISTCLEANFILES =
MAINTAINERCLEANFILES =

AM_CPPFLAGS = \
  -I. -I$(srcdir) \
  -I.. -I$(srcdir)/.. \
  -I../lib -I$(srcdir)/../lib

LDADD = libtests.a ../lib/libcoreutils.a libtests.a $(LIBTESTS_LIBDEPS)

libtests_a_SOURCES =
libtests_a_LIBADD = $(gltests_LIBOBJS)
libtests_a_DEPENDENCIES = $(gltests_LIBOBJS)
EXTRA_libtests_a_SOURCES =
AM_LIBTOOLFLAGS = --preserve-dup-deps

## begin gnulib module accept


EXTRA_DIST += accept.c w32sock.h

EXTRA_libtests_a_SOURCES += accept.c

## end   gnulib module accept

## begin gnulib module acl-tests

TESTS += test-file-has-acl.sh test-set-mode-acl.sh test-copy-acl.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' USE_ACL=$(USE_ACL)
check_PROGRAMS += test-file-has-acl test-set-mode-acl test-copy-acl test-sameacls
test_file_has_acl_LDADD = $(LDADD) $(LIB_ACL)
test_set_mode_acl_LDADD = $(LDADD) $(LIB_ACL) @LIBINTL@
test_copy_acl_LDADD = $(LDADD) $(LIB_ACL) @LIBINTL@
test_sameacls_LDADD = $(LDADD) $(LIB_ACL) @LIBINTL@
EXTRA_DIST += test-file-has-acl.sh test-set-mode-acl.sh test-copy-acl.sh test-file-has-acl.c test-set-mode-acl.c test-copy-acl.c test-sameacls.c

## end   gnulib module acl-tests

## begin gnulib module alloca-opt-tests

TESTS += test-alloca-opt
check_PROGRAMS += test-alloca-opt

EXTRA_DIST += test-alloca-opt.c

## end   gnulib module alloca-opt-tests

## begin gnulib module argmatch-tests

TESTS += test-argmatch
check_PROGRAMS += test-argmatch
test_argmatch_LDADD = $(LDADD) @LIBINTL@

EXTRA_DIST += test-argmatch.c

## end   gnulib module argmatch-tests

## begin gnulib module argv-iter-tests

TESTS += test-argv-iter
check_PROGRAMS += test-argv-iter
EXTRA_DIST += test-argv-iter.c

## end   gnulib module argv-iter-tests

## begin gnulib module arpa_inet-tests

TESTS += test-arpa_inet
check_PROGRAMS += test-arpa_inet

EXTRA_DIST += test-arpa_inet.c

## end   gnulib module arpa_inet-tests

## begin gnulib module atexit-tests

TESTS += test-atexit.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-atexit
EXTRA_DIST += test-atexit.sh test-atexit.c

## end   gnulib module atexit-tests

## begin gnulib module base64-tests

TESTS += test-base64
check_PROGRAMS += test-base64
EXTRA_DIST += test-base64.c

## end   gnulib module base64-tests

## begin gnulib module binary-io

libtests_a_SOURCES += binary-io.h

## end   gnulib module binary-io

## begin gnulib module binary-io-tests

TESTS += test-binary-io.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-binary-io

EXTRA_DIST += test-binary-io.sh test-binary-io.c

## end   gnulib module binary-io-tests

## begin gnulib module bind


EXTRA_DIST += bind.c w32sock.h

EXTRA_libtests_a_SOURCES += bind.c

## end   gnulib module bind

## begin gnulib module btowc-tests

TESTS += test-btowc1.sh test-btowc2.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' LOCALE_FR='@LOCALE_FR@' LOCALE_FR_UTF8='@LOCALE_FR_UTF8@'
check_PROGRAMS += test-btowc

EXTRA_DIST += test-btowc1.sh test-btowc2.sh test-btowc.c

## end   gnulib module btowc-tests

## begin gnulib module c-ctype-tests

TESTS += test-c-ctype
check_PROGRAMS += test-c-ctype

EXTRA_DIST += test-c-ctype.c

## end   gnulib module c-ctype-tests

## begin gnulib module c-strcase-tests

TESTS += test-c-strcase.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' LOCALE_FR='@LOCALE_FR@' LOCALE_TR_UTF8='@LOCALE_TR_UTF8@'
check_PROGRAMS += test-c-strcasecmp test-c-strncasecmp
EXTRA_DIST += test-c-strcase.sh test-c-strcasecmp.c test-c-strncasecmp.c

## end   gnulib module c-strcase-tests

## begin gnulib module canonicalize-tests

TESTS += test-canonicalize.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-canonicalize
test_canonicalize_LDADD = $(LDADD) @LIBINTL@
EXTRA_DIST += test-canonicalize.sh test-canonicalize.c

## end   gnulib module canonicalize-tests

## begin gnulib module closein-tests

TESTS += test-closein.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-closein
test_closein_LDADD = $(LDADD) @LIBINTL@
EXTRA_DIST += test-closein.sh test-closein.c

## end   gnulib module closein-tests

## begin gnulib module connect


EXTRA_DIST += connect.c w32sock.h

EXTRA_libtests_a_SOURCES += connect.c

## end   gnulib module connect

## begin gnulib module crypto/md5-tests

TESTS += test-md5
check_PROGRAMS += test-md5
EXTRA_DIST += test-md5.c

## end   gnulib module crypto/md5-tests

## begin gnulib module crypto/sha1-tests

TESTS += test-sha1
check_PROGRAMS += test-sha1
EXTRA_DIST += test-sha1.c

## end   gnulib module crypto/sha1-tests

## begin gnulib module dirname-tests

TESTS += test-dirname
check_PROGRAMS += test-dirname
test_dirname_LDADD = $(LDADD) @LIBINTL@
EXTRA_DIST += test-dirname.c

## end   gnulib module dirname-tests

## begin gnulib module environ-tests

TESTS += test-environ
check_PROGRAMS += test-environ

EXTRA_DIST += test-environ.c

## end   gnulib module environ-tests

## begin gnulib module errno-tests

TESTS += test-errno
check_PROGRAMS += test-errno

EXTRA_DIST += test-errno.c

## end   gnulib module errno-tests

## begin gnulib module fcntl-tests

TESTS += test-fcntl
check_PROGRAMS += test-fcntl

EXTRA_DIST += test-fcntl.c

## end   gnulib module fcntl-tests

## begin gnulib module fflush-tests

TESTS += test-fflush test-fflush2.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-fflush test-fflush2
MOSTLYCLEANFILES += test-fflush.txt
EXTRA_DIST += test-fflush.c test-fflush2.sh test-fflush2.c

## end   gnulib module fflush-tests

## begin gnulib module filenamecat-tests

TESTS += test-filenamecat
check_PROGRAMS += test-filenamecat
test_filenamecat_LDADD = $(LDADD) @LIBINTL@
EXTRA_DIST += test-filenamecat.c

## end   gnulib module filenamecat-tests

## begin gnulib module filevercmp-tests

TESTS += test-filevercmp
check_PROGRAMS += test-filevercmp
EXTRA_DIST += test-filevercmp.c

## end   gnulib module filevercmp-tests

## begin gnulib module fpending-tests

TESTS += test-fpending.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-fpending
MOSTLYCLEANFILES += test-fpending.t
EXTRA_DIST += test-fpending.c test-fpending.sh

## end   gnulib module fpending-tests

## begin gnulib module fpurge-tests

TESTS += test-fpurge
check_PROGRAMS += test-fpurge
MOSTLYCLEANFILES += t-fpurge.tmp
EXTRA_DIST += test-fpurge.c

## end   gnulib module fpurge-tests

## begin gnulib module freadahead-tests

TESTS += test-freadahead.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-freadahead
EXTRA_DIST += test-freadahead.c test-freadahead.sh

## end   gnulib module freadahead-tests

## begin gnulib module freading-tests

TESTS += test-freading
check_PROGRAMS += test-freading
MOSTLYCLEANFILES += t-freading.tmp
EXTRA_DIST += test-freading.c

## end   gnulib module freading-tests

## begin gnulib module freadptr-tests

TESTS += test-freadptr.sh test-freadptr2.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-freadptr test-freadptr2
EXTRA_DIST += test-freadptr.c test-freadptr.sh test-freadptr2.c test-freadptr2.sh

## end   gnulib module freadptr-tests

## begin gnulib module freadseek-tests

TESTS += test-freadseek.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-freadseek
EXTRA_DIST += test-freadseek.c test-freadseek.sh

## end   gnulib module freadseek-tests

## begin gnulib module frexp-nolibm-tests

TESTS += test-frexp-nolibm
check_PROGRAMS += test-frexp-nolibm
test_frexp_nolibm_SOURCES = test-frexp.c

EXTRA_DIST += test-frexp.c

## end   gnulib module frexp-nolibm-tests

## begin gnulib module frexpl-nolibm-tests

TESTS += test-frexpl-nolibm
check_PROGRAMS += test-frexpl-nolibm
test_frexpl_nolibm_SOURCES = test-frexpl.c

EXTRA_DIST += test-frexpl.c

## end   gnulib module frexpl-nolibm-tests

## begin gnulib module fseeko-tests

TESTS += test-fseeko.sh test-fseeko2.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-fseeko
EXTRA_DIST += test-fseeko.c test-fseeko.sh test-fseeko2.sh

## end   gnulib module fseeko-tests

## begin gnulib module fseterr-tests

TESTS += test-fseterr
check_PROGRAMS += test-fseterr

EXTRA_DIST += test-fseterr.c

## end   gnulib module fseterr-tests

## begin gnulib module ftello-tests

TESTS += test-ftello.sh test-ftello2.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-ftello
EXTRA_DIST += test-ftello.c test-ftello.sh test-ftello2.sh

## end   gnulib module ftello-tests

## begin gnulib module getaddrinfo-tests

TESTS += test-getaddrinfo
check_PROGRAMS += test-getaddrinfo
test_getaddrinfo_LDADD = $(LDADD) @GETADDRINFO_LIB@ @LIBINTL@

EXTRA_DIST += test-getaddrinfo.c

## end   gnulib module getaddrinfo-tests

## begin gnulib module getdate-tests

TESTS += test-getdate
check_PROGRAMS += test-getdate
test_getdate_LDADD = $(LDADD) @LIBINTL@ $(LIB_CLOCK_GETTIME)
EXTRA_DIST += test-getdate.c

## end   gnulib module getdate-tests

## begin gnulib module getdelim-tests

TESTS += test-getdelim
check_PROGRAMS += test-getdelim
MOSTLYCLEANFILES += test-getdelim.txt
EXTRA_DIST += test-getdelim.c

## end   gnulib module getdelim-tests

## begin gnulib module gethostname-tests

TESTS += test-gethostname
check_PROGRAMS += test-gethostname
EXTRA_DIST += test-gethostname.c

## end   gnulib module gethostname-tests

## begin gnulib module getline-tests

TESTS += test-getline
check_PROGRAMS += test-getline
MOSTLYCLEANFILES += test-getline.txt
EXTRA_DIST += test-getline.c

## end   gnulib module getline-tests

## begin gnulib module getndelim2-tests

TESTS += test-getndelim2
check_PROGRAMS += test-getndelim2
MOSTLYCLEANFILES += test-getndelim2.txt
EXTRA_DIST += test-getndelim2.c

## end   gnulib module getndelim2-tests

## begin gnulib module gettimeofday-tests

TESTS += test-gettimeofday
check_PROGRAMS += test-gettimeofday

EXTRA_DIST += test-gettimeofday.c

## end   gnulib module gettimeofday-tests

## begin gnulib module i-ring-tests

TESTS += test-i-ring
check_PROGRAMS += test-i-ring
EXTRA_DIST += test-i-ring.c

## end   gnulib module i-ring-tests

## begin gnulib module iconv-tests

TESTS += test-iconv
check_PROGRAMS += test-iconv
test_iconv_LDADD = $(LDADD) @LIBICONV@

EXTRA_DIST += test-iconv.c

## end   gnulib module iconv-tests

## begin gnulib module inet_pton


EXTRA_DIST += inet_pton.c

EXTRA_libtests_a_SOURCES += inet_pton.c

## end   gnulib module inet_pton

## begin gnulib module inttypes-tests

TESTS += test-inttypes
check_PROGRAMS += test-inttypes

EXTRA_DIST += test-inttypes.c

## end   gnulib module inttypes-tests

## begin gnulib module ioctl


EXTRA_DIST += ioctl.c w32sock.h

EXTRA_libtests_a_SOURCES += ioctl.c

## end   gnulib module ioctl

## begin gnulib module isnand-nolibm-tests

TESTS += test-isnand-nolibm
check_PROGRAMS += test-isnand-nolibm

EXTRA_DIST += test-isnand-nolibm.c test-isnand.h nan.h

## end   gnulib module isnand-nolibm-tests

## begin gnulib module isnanf-nolibm-tests

TESTS += test-isnanf-nolibm
check_PROGRAMS += test-isnanf-nolibm

EXTRA_DIST += test-isnanf-nolibm.c test-isnanf.h nan.h

## end   gnulib module isnanf-nolibm-tests

## begin gnulib module isnanl-nolibm-tests

TESTS += test-isnanl-nolibm
check_PROGRAMS += test-isnanl-nolibm

EXTRA_DIST += test-isnanl-nolibm.c test-isnanl.h nan.h

## end   gnulib module isnanl-nolibm-tests

## begin gnulib module listen


EXTRA_DIST += listen.c w32sock.h

EXTRA_libtests_a_SOURCES += listen.c

## end   gnulib module listen

## begin gnulib module lseek-tests

TESTS += test-lseek.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-lseek
EXTRA_DIST += test-lseek.c test-lseek.sh

## end   gnulib module lseek-tests

## begin gnulib module lstat-tests

TESTS += test-lstat
check_PROGRAMS += test-lstat
EXTRA_DIST += test-lstat.c

## end   gnulib module lstat-tests

## begin gnulib module malloca-tests

TESTS += test-malloca
check_PROGRAMS += test-malloca

EXTRA_DIST += test-malloca.c

## end   gnulib module malloca-tests

## begin gnulib module math-tests

TESTS += test-math
check_PROGRAMS += test-math

EXTRA_DIST += test-math.c

## end   gnulib module math-tests

## begin gnulib module mbrtowc-tests

TESTS += test-mbrtowc1.sh test-mbrtowc2.sh test-mbrtowc3.sh test-mbrtowc4.sh
TESTS_ENVIRONMENT += \
  EXEEXT='@EXEEXT@' \
  LOCALE_FR='@LOCALE_FR@' \
  LOCALE_FR_UTF8='@LOCALE_FR_UTF8@' \
  LOCALE_JA='@LOCALE_JA@' \
  LOCALE_ZH_CN='@LOCALE_ZH_CN@'
check_PROGRAMS += test-mbrtowc

EXTRA_DIST += test-mbrtowc1.sh test-mbrtowc2.sh test-mbrtowc3.sh test-mbrtowc4.sh test-mbrtowc.c

## end   gnulib module mbrtowc-tests

## begin gnulib module mbscasecmp-tests

TESTS += test-mbscasecmp.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' LOCALE_TR_UTF8='@LOCALE_TR_UTF8@'
check_PROGRAMS += test-mbscasecmp

EXTRA_DIST += test-mbscasecmp.sh test-mbscasecmp.c

## end   gnulib module mbscasecmp-tests

## begin gnulib module mbsinit-tests

TESTS += test-mbsinit.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' LOCALE_FR_UTF8='@LOCALE_FR_UTF8@'
check_PROGRAMS += test-mbsinit

EXTRA_DIST += test-mbsinit.sh test-mbsinit.c

## end   gnulib module mbsinit-tests

## begin gnulib module mbsstr-tests

TESTS += test-mbsstr1 test-mbsstr2.sh test-mbsstr3.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' LOCALE_FR_UTF8='@LOCALE_FR_UTF8@' LOCALE_ZH_CN='@LOCALE_ZH_CN@'
check_PROGRAMS += test-mbsstr1 test-mbsstr2 test-mbsstr3

EXTRA_DIST += test-mbsstr1.c test-mbsstr2.sh test-mbsstr2.c test-mbsstr3.sh test-mbsstr3.c

## end   gnulib module mbsstr-tests

## begin gnulib module memchr-tests

TESTS += test-memchr
check_PROGRAMS += test-memchr
EXTRA_DIST += test-memchr.c

## end   gnulib module memchr-tests

## begin gnulib module memchr2-tests

TESTS += test-memchr2
check_PROGRAMS += test-memchr2
EXTRA_DIST += test-memchr2.c

## end   gnulib module memchr2-tests

## begin gnulib module memcmp-tests

TESTS += test-memcmp
check_PROGRAMS += test-memcmp
EXTRA_DIST += test-memcmp.c

## end   gnulib module memcmp-tests

## begin gnulib module memrchr-tests

TESTS += test-memrchr
check_PROGRAMS += test-memrchr
EXTRA_DIST += test-memrchr.c

## end   gnulib module memrchr-tests

## begin gnulib module netdb-tests

TESTS += test-netdb
check_PROGRAMS += test-netdb

EXTRA_DIST += test-netdb.c

## end   gnulib module netdb-tests

## begin gnulib module netinet_in-tests

TESTS += test-netinet_in
check_PROGRAMS += test-netinet_in

EXTRA_DIST += test-netinet_in.c

## end   gnulib module netinet_in-tests

## begin gnulib module open-tests

TESTS += test-open
check_PROGRAMS += test-open

EXTRA_DIST += test-open.c

## end   gnulib module open-tests

## begin gnulib module perror


EXTRA_DIST += perror.c

EXTRA_libtests_a_SOURCES += perror.c

## end   gnulib module perror

## begin gnulib module perror-tests

TESTS += test-perror.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-perror
EXTRA_DIST += test-perror.c test-perror.sh

## end   gnulib module perror-tests

## begin gnulib module printf-frexp-tests

TESTS += test-printf-frexp
check_PROGRAMS += test-printf-frexp

EXTRA_DIST += test-printf-frexp.c

## end   gnulib module printf-frexp-tests

## begin gnulib module printf-frexpl-tests

TESTS += test-printf-frexpl
check_PROGRAMS += test-printf-frexpl

EXTRA_DIST += test-printf-frexpl.c

## end   gnulib module printf-frexpl-tests

## begin gnulib module quotearg-tests

TESTS += test-quotearg.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)' LOCALE_FR='@LOCALE_FR@' LOCALE_FR_UTF8='@LOCALE_FR_UTF8@'
check_PROGRAMS += test-quotearg
test_quotearg_LDADD = $(LDADD) @LIBINTL@
EXTRA_DIST += test-quotearg.sh test-quotearg.c locale/fr/LC_MESSAGES/test-quotearg.po locale/fr/LC_MESSAGES/test-quotearg.mo

## end   gnulib module quotearg-tests

## begin gnulib module read-file


EXTRA_DIST += read-file.c read-file.h

EXTRA_libtests_a_SOURCES += read-file.c

## end   gnulib module read-file

## begin gnulib module read-file-tests

TESTS += test-read-file
check_PROGRAMS += test-read-file
EXTRA_DIST += test-read-file.c

## end   gnulib module read-file-tests

## begin gnulib module select-tests

TESTS += test-select test-select-in.sh test-select-out.sh
# test-select-stdin has to be run by hand.
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-select test-select-fd test-select-stdin
test_select_LDADD = $(LDADD) @LIBSOCKET@
test_select_fd_LDADD = $(LDADD) @LIBSOCKET@
test_select_stdin_LDADD = $(LDADD) @LIBSOCKET@

EXTRA_DIST += test-select.c test-select-fd.c test-select-in.sh test-select-out.sh test-select-stdin.c

## end   gnulib module select-tests

## begin gnulib module setsockopt


EXTRA_DIST += setsockopt.c w32sock.h

EXTRA_libtests_a_SOURCES += setsockopt.c

## end   gnulib module setsockopt

## begin gnulib module sigaction-tests

TESTS += test-sigaction
check_PROGRAMS += test-sigaction
EXTRA_DIST += test-sigaction.c

## end   gnulib module sigaction-tests

## begin gnulib module signal-tests

TESTS += test-signal
check_PROGRAMS += test-signal

EXTRA_DIST += test-signal.c

## end   gnulib module signal-tests

## begin gnulib module signbit-tests

TESTS += test-signbit
check_PROGRAMS += test-signbit

EXTRA_DIST += test-signbit.c

## end   gnulib module signbit-tests

## begin gnulib module sleep


EXTRA_DIST += sleep.c

EXTRA_libtests_a_SOURCES += sleep.c

## end   gnulib module sleep

## begin gnulib module sleep-tests

TESTS += test-sleep
check_PROGRAMS += test-sleep

EXTRA_DIST += test-sleep.c

## end   gnulib module sleep-tests

## begin gnulib module snprintf-tests

TESTS += test-snprintf
check_PROGRAMS += test-snprintf

EXTRA_DIST += test-snprintf.c

## end   gnulib module snprintf-tests

## begin gnulib module socket


EXTRA_DIST += socket.c w32sock.h

EXTRA_libtests_a_SOURCES += socket.c

## end   gnulib module socket

## begin gnulib module sockets

libtests_a_SOURCES += sockets.h sockets.c

EXTRA_DIST += w32sock.h

## end   gnulib module sockets

## begin gnulib module sockets-tests

TESTS += test-sockets
check_PROGRAMS += test-sockets
test_sockets_LDADD = $(LDADD) @LIBSOCKET@
EXTRA_DIST += test-sockets.c

## end   gnulib module sockets-tests

## begin gnulib module stat-time-tests

TESTS += test-stat-time
check_PROGRAMS += test-stat-time
EXTRA_DIST += test-stat-time.c

## end   gnulib module stat-time-tests

## begin gnulib module stdbool-tests

TESTS += test-stdbool
check_PROGRAMS += test-stdbool

EXTRA_DIST += test-stdbool.c

## end   gnulib module stdbool-tests

## begin gnulib module stdint-tests

TESTS += test-stdint
check_PROGRAMS += test-stdint

EXTRA_DIST += test-stdint.c

## end   gnulib module stdint-tests

## begin gnulib module stdio-tests

TESTS += test-stdio
check_PROGRAMS += test-stdio

EXTRA_DIST += test-stdio.c

## end   gnulib module stdio-tests

## begin gnulib module stdlib-tests

TESTS += test-stdlib
check_PROGRAMS += test-stdlib

EXTRA_DIST += test-stdlib.c

## end   gnulib module stdlib-tests

## begin gnulib module strerror-tests

TESTS += test-strerror
check_PROGRAMS += test-strerror
EXTRA_DIST += test-strerror.c

## end   gnulib module strerror-tests

## begin gnulib module striconv-tests

TESTS += test-striconv
check_PROGRAMS += test-striconv
test_striconv_LDADD = $(LDADD) @LIBICONV@

EXTRA_DIST += test-striconv.c

## end   gnulib module striconv-tests

## begin gnulib module string-tests

TESTS += test-string
check_PROGRAMS += test-string

EXTRA_DIST += test-string.c

## end   gnulib module string-tests

## begin gnulib module strtod-tests

LIBS += $(POW_LIB)
TESTS += test-strtod
check_PROGRAMS += test-strtod
EXTRA_DIST += test-strtod.c

## end   gnulib module strtod-tests

## begin gnulib module strverscmp-tests

TESTS += test-strverscmp
check_PROGRAMS += test-strverscmp
EXTRA_DIST += test-strverscmp.c

## end   gnulib module strverscmp-tests

## begin gnulib module sys_ioctl

BUILT_SOURCES += $(SYS_IOCTL_H)

# We need the following in order to create <sys/ioctl.h> when the system
# does not have a complete one.
sys/ioctl.h: sys_ioctl.in.h
	@MKDIR_P@ sys
	rm -f $@-t $@
	{ echo '/* DO NOT EDIT! GENERATED AUTOMATICALLY! */'; \
	  sed -e 's|@''HAVE_SYS_IOCTL_H''@|$(HAVE_SYS_IOCTL_H)|g' \
	      -e 's|@''INCLUDE_NEXT''@|$(INCLUDE_NEXT)|g' \
	      -e 's|@''PRAGMA_SYSTEM_HEADER''@|@PRAGMA_SYSTEM_HEADER@|g' \
	      -e 's|@''NEXT_SYS_IOCTL_H''@|$(NEXT_SYS_IOCTL_H)|g' \
	      -e 's|@''GNULIB_IOCTL''@|$(GNULIB_IOCTL)|g' \
	      -e 's|@''SYS_IOCTL_H_HAVE_WINSOCK2_H''@|$(SYS_IOCTL_H_HAVE_WINSOCK2_H)|g' \
	      -e '/definition of GL_LINK_WARNING/r $(LINK_WARNING_H)' \
	      < $(srcdir)/sys_ioctl.in.h; \
	} > $@-t
	mv $@-t $@
MOSTLYCLEANFILES += sys/ioctl.h sys/ioctl.h-t
MOSTLYCLEANDIRS += sys

EXTRA_DIST += sys_ioctl.in.h

## end   gnulib module sys_ioctl

## begin gnulib module sys_select-tests

TESTS += test-sys_select
check_PROGRAMS += test-sys_select

EXTRA_DIST += test-sys_select.c

## end   gnulib module sys_select-tests

## begin gnulib module sys_socket-tests

TESTS += test-sys_socket
check_PROGRAMS += test-sys_socket

EXTRA_DIST += test-sys_socket.c

## end   gnulib module sys_socket-tests

## begin gnulib module sys_stat-tests

TESTS += test-sys_stat
check_PROGRAMS += test-sys_stat

EXTRA_DIST += test-sys_stat.c

## end   gnulib module sys_stat-tests

## begin gnulib module sys_time-tests

TESTS += test-sys_time
check_PROGRAMS += test-sys_time

EXTRA_DIST += test-sys_time.c

## end   gnulib module sys_time-tests

## begin gnulib module time-tests

TESTS += test-time
check_PROGRAMS += test-time

EXTRA_DIST += test-time.c

## end   gnulib module time-tests

## begin gnulib module unistd-tests

TESTS += test-unistd
check_PROGRAMS += test-unistd

EXTRA_DIST += test-unistd.c

## end   gnulib module unistd-tests

## begin gnulib module uniwidth/width-tests

TESTS += test-uc_width uniwidth/test-uc_width2.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-uc_width test-uc_width2
test_uc_width_SOURCES = uniwidth/test-uc_width.c
test_uc_width2_SOURCES = uniwidth/test-uc_width2.c

EXTRA_DIST += uniwidth/test-uc_width.c uniwidth/test-uc_width2.c uniwidth/test-uc_width2.sh

## end   gnulib module uniwidth/width-tests

## begin gnulib module vasnprintf-tests

TESTS += test-vasnprintf
check_PROGRAMS += test-vasnprintf

EXTRA_DIST += test-vasnprintf.c

## end   gnulib module vasnprintf-tests

## begin gnulib module vasprintf-posix-tests

TESTS += test-vasprintf-posix
check_PROGRAMS += test-vasprintf-posix

EXTRA_DIST += test-vasprintf-posix.c nan.h

## end   gnulib module vasprintf-posix-tests

## begin gnulib module vasprintf-tests

TESTS += test-vasprintf
check_PROGRAMS += test-vasprintf

EXTRA_DIST += test-vasprintf.c

## end   gnulib module vasprintf-tests

## begin gnulib module vc-list-files-tests

TESTS += test-vc-list-files-git.sh
TESTS += test-vc-list-files-cvs.sh
TESTS_ENVIRONMENT += PATH='$(abs_aux_dir)':"$$PATH"
EXTRA_DIST += test-vc-list-files-git.sh test-vc-list-files-cvs.sh

## end   gnulib module vc-list-files-tests

## begin gnulib module vfprintf-posix-tests

TESTS += test-vfprintf-posix.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-vfprintf-posix
EXTRA_DIST += test-vfprintf-posix.sh test-vfprintf-posix.c test-fprintf-posix.h test-printf-posix.output

## end   gnulib module vfprintf-posix-tests

## begin gnulib module vprintf-posix-tests

TESTS += test-vprintf-posix.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-vprintf-posix
EXTRA_DIST += test-vprintf-posix.sh test-vprintf-posix.c test-printf-posix.h test-printf-posix.output

## end   gnulib module vprintf-posix-tests

## begin gnulib module wchar-tests

TESTS += test-wchar
check_PROGRAMS += test-wchar

EXTRA_DIST += test-wchar.c

## end   gnulib module wchar-tests

## begin gnulib module wcrtomb-tests

TESTS += test-wcrtomb.sh
TESTS_ENVIRONMENT += \
  EXEEXT='@EXEEXT@' \
  LOCALE_FR='@LOCALE_FR@' \
  LOCALE_FR_UTF8='@LOCALE_FR_UTF8@' \
  LOCALE_JA='@LOCALE_JA@' \
  LOCALE_ZH_CN='@LOCALE_ZH_CN@'
check_PROGRAMS += test-wcrtomb

EXTRA_DIST += test-wcrtomb.sh test-wcrtomb.c

## end   gnulib module wcrtomb-tests

## begin gnulib module wctob


EXTRA_DIST += wctob.c

EXTRA_libtests_a_SOURCES += wctob.c

## end   gnulib module wctob

## begin gnulib module wctype-tests

TESTS += test-wctype
check_PROGRAMS += test-wctype

EXTRA_DIST += test-wctype.c

## end   gnulib module wctype-tests

## begin gnulib module wcwidth-tests

TESTS += test-wcwidth
check_PROGRAMS += test-wcwidth

EXTRA_DIST += test-wcwidth.c

## end   gnulib module wcwidth-tests

## begin gnulib module xprintf-posix-tests

TESTS += test-xprintf-posix.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@' srcdir='$(srcdir)'
check_PROGRAMS += test-xfprintf-posix test-xprintf-posix
test_xfprintf_posix_LDADD = $(LDADD) @LIBINTL@
test_xprintf_posix_LDADD = $(LDADD) @LIBINTL@
EXTRA_DIST += test-xprintf-posix.sh test-xfprintf-posix.c test-xprintf-posix.c test-fprintf-posix.h test-printf-posix.h test-printf-posix.output

## end   gnulib module xprintf-posix-tests

## begin gnulib module xstrtoimax-tests

TESTS += test-xstrtoimax.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-xstrtoimax
test_xstrtoimax_LDADD = $(LDADD) @LIBINTL@
EXTRA_DIST += test-xstrtoimax.c test-xstrtoimax.sh

## end   gnulib module xstrtoimax-tests

## begin gnulib module xstrtol-tests

TESTS += test-xstrtol.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-xstrtol test-xstrtoul
test_xstrtol_LDADD = $(LDADD) @LIBINTL@
test_xstrtoul_LDADD = $(LDADD) @LIBINTL@
EXTRA_DIST += test-xstrtol.c test-xstrtoul.c test-xstrtol.sh

## end   gnulib module xstrtol-tests

## begin gnulib module xstrtoumax-tests

TESTS += test-xstrtoumax.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-xstrtoumax
test_xstrtoumax_LDADD = $(LDADD) @LIBINTL@
EXTRA_DIST += test-xstrtoumax.c test-xstrtoumax.sh

## end   gnulib module xstrtoumax-tests

## begin gnulib module xvasprintf-tests

TESTS += test-xvasprintf
check_PROGRAMS += test-xvasprintf
test_xvasprintf_LDADD = $(LDADD) @LIBINTL@

EXTRA_DIST += test-xvasprintf.c

## end   gnulib module xvasprintf-tests

## begin gnulib module yesno-tests

TESTS += test-yesno.sh
TESTS_ENVIRONMENT += EXEEXT='@EXEEXT@'
check_PROGRAMS += test-yesno
test_yesno_LDADD = $(LDADD) @LIBINTL@
EXTRA_DIST += test-yesno.c test-yesno.sh

## end   gnulib module yesno-tests

# Clean up after Solaris cc.
clean-local:
	rm -rf SunWS_cache

mostlyclean-local: mostlyclean-generic
	@for dir in '' $(MOSTLYCLEANDIRS); do \
	  if test -n "$$dir" && test -d $$dir; then \
	    echo "rmdir $$dir"; rmdir $$dir; \
	  fi; \
	done; \
	: