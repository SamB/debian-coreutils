/* -*- buffer-read-only: t -*- vi: set ro: */
/* DO NOT EDIT! GENERATED AUTOMATICALLY! */
#line 1
/* Tests of fstatat.
   Copyright (C) 2009 Free Software Foundation, Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation; either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* Written by Eric Blake <ebb9@byu.net>, 2009.  */

#include <config.h>

#include <sys/stat.h>

#include <fcntl.h>
#include <errno.h>
#include <stdbool.h>
#include <stdio.h>
#include <stdlib.h>
#include <unistd.h>

#include "openat.h"
#include "pathmax.h"
#include "same-inode.h"

#define ASSERT(expr) \
  do                                                                         \
    {                                                                        \
      if (!(expr))                                                           \
	{                                                                    \
	  fprintf (stderr, "%s:%d: assertion failed\n", __FILE__, __LINE__);  \
	  fflush (stderr);                                                   \
	  abort ();                                                          \
	}                                                                    \
    }                                                                        \
  while (0)

#define BASE "test-fstatat.t"

#include "test-lstat.h"
#include "test-stat.h"

static int dfd = AT_FDCWD;

/* Wrapper around fstatat to test stat behavior.  */
static int
do_stat (char const *name, struct stat *st)
{
  return statat (dfd, name, st);
}

/* Wrapper around fstatat to test lstat behavior.  */
static int
do_lstat (char const *name, struct stat *st)
{
  return lstatat (dfd, name, st);
}

int
main ()
{
  int result;
  ASSERT (test_stat_func (do_stat) == 0);
  result = test_lstat_func (do_lstat, false);
  dfd = open (".", O_RDONLY);
  ASSERT (0 <= dfd);
  ASSERT (test_stat_func (do_stat) == 0);
  ASSERT (test_lstat_func (do_lstat, false) == result);
  ASSERT (close (dfd) == 0);

  /* FIXME - add additional tests of dfd not at current directory.  */

  if (result == 77)
    fputs ("skipping test: symlinks not supported on this filesystem\n",
	   stderr);
  return result;
}
