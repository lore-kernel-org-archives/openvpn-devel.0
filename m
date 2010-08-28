From: David Sommerseth <dazo@...384...>
Date: Sat, 28 Aug 2010 22:31:58 +0200
Message-Id: <1283027520-26460-2-git-send-email-dazo@...384...>
In-Reply-To: <1283027520-26460-1-git-send-email-dazo@...384...>
References: <1283027520-26460-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 1/3] Clean-up: Remove pthread and mutex
	locking code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: David Sommerseth <dazo@...384...>

This code was not activated at all, and hard coded as disabled in syshead.h
with this code snippet:

   /*
    * Pthread support is currently experimental (and quite unfinished).
    */
   #if 1 /* JYFIXME -- if defined, disable pthread */
   #undef USE_PTHREAD
   #endif

So no matter if --enable-pthread when running ./configure or not, this feature
was never enabled in reality.  Further, by removing the blocker code above made
OpenVPN uncompilable in the current state.

As the threading part needs to be completely rewritten and pthreading will not be
supported in OpenVPN 2.x, removing this code seems most reasonable.

In addition, a lot of mutex locking code was also removed, as they were practically
NOP functions, due to pthreading being forcefully disabled

Signed-off-by: David Sommerseth <dazo@...384...>
---
 Makefile.am    |    1 -
 acinclude.m4   |  224 -----------------------------------------------------
 buffer.c       |    1 -
 buffer.h       |    1 -
 config-win32.h |    5 -
 configure.ac   |   38 +---------
 crypto.c       |    3 -
 error.c        |   39 ---------
 error.h        |   17 ----
 init.c         |   50 ------------
 list.c         |   13 ---
 list.h         |    8 --
 mbuf.c         |   12 ---
 mbuf.h         |    1 -
 misc.c         |   23 ------
 multi.c        |    1 -
 multi.h        |    2 -
 options.c      |   36 ---------
 options.h      |    5 -
 otime.c        |    2 -
 otime.h        |    1 -
 perf.c         |    4 -
 plugin.c       |    4 -
 pool.h         |    1 -
 schedule.c     |    4 -
 schedule.h     |    8 --
 socket.c       |    7 --
 ssl.c          |    1 -
 ssl.h          |    1 -
 syshead.h      |   18 ----
 thread.c       |  156 -------------------------------------
 thread.h       |  235 --------------------------------------------------------
 32 files changed, 1 insertions(+), 921 deletions(-)
 delete mode 100644 thread.c
 delete mode 100644 thread.h

diff --git a/Makefile.am b/Makefile.am
index 8a4c54d..c3d596f 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -135,7 +135,6 @@ openvpn_SOURCES = \
 	ssl.c ssl.h \
 	status.c status.h \
 	syshead.h \
-	thread.c thread.h \
 	tun.c tun.h \
 	win32.h win32.c \
 	cryptoapi.h cryptoapi.c
diff --git a/acinclude.m4 b/acinclude.m4
index 2d49020..f037484 100644
--- a/acinclude.m4
+++ b/acinclude.m4
@@ -129,227 +129,3 @@ AC_DEFUN([TYPE_SOCKLEN_T],
       [#include <sys/types.h>
 #include <sys/socket.h>])
 ])
-
-dnl @synopsis ACX_PTHREAD([ACTION-IF-FOUND[, ACTION-IF-NOT-FOUND]])
-dnl
-dnl This macro figures out how to build C programs using POSIX
-dnl threads.  It sets the PTHREAD_LIBS output variable to the threads
-dnl library and linker flags, and the PTHREAD_CFLAGS output variable
-dnl to any special C compiler flags that are needed.  (The user can also
-dnl force certain compiler flags/libs to be tested by setting these
-dnl environment variables.)
-dnl
-dnl Also sets PTHREAD_CC to any special C compiler that is needed for
-dnl multi-threaded programs (defaults to the value of CC otherwise).
-dnl (This is necessary on AIX to use the special cc_r compiler alias.)
-dnl
-dnl If you are only building threads programs, you may wish to
-dnl use these variables in your default LIBS, CFLAGS, and CC:
-dnl
-dnl        LIBS="$PTHREAD_LIBS $LIBS"
-dnl        CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
-dnl        CC="$PTHREAD_CC"
-dnl
-dnl In addition, if the PTHREAD_CREATE_JOINABLE thread-attribute
-dnl constant has a nonstandard name, defines PTHREAD_CREATE_JOINABLE
-dnl to that name (e.g. PTHREAD_CREATE_UNDETACHED on AIX).
-dnl
-dnl ACTION-IF-FOUND is a list of shell commands to run if a threads
-dnl library is found, and ACTION-IF-NOT-FOUND is a list of commands
-dnl to run it if it is not found.  If ACTION-IF-FOUND is not specified,
-dnl the default action will define HAVE_PTHREAD.
-dnl
-dnl Please let the authors know if this macro fails on any platform,
-dnl or if you have any other suggestions or comments.  This macro was
-dnl based on work by SGJ on autoconf scripts for FFTW (www.fftw.org)
-dnl (with help from M. Frigo), as well as ac_pthread and hb_pthread
-dnl macros posted by AFC to the autoconf macro repository.  We are also
-dnl grateful for the helpful feedback of numerous users.
-dnl
-dnl @author Steven G. Johnson <stevenj@...46...> and Alejandro Forero Cuervo <bachue@...47...>
-
-AC_DEFUN([ACX_PTHREAD], [
-AC_REQUIRE([AC_CANONICAL_HOST])
-acx_pthread_ok=no
-
-# We used to check for pthread.h first, but this fails if pthread.h
-# requires special compiler flags (e.g. on True64 or Sequent).
-# It gets checked for in the link test anyway.
-
-# First of all, check if the user has set any of the PTHREAD_LIBS,
-# etcetera environment variables, and if threads linking works using
-# them:
-if test x"$PTHREAD_LIBS$PTHREAD_CFLAGS" != x; then
-        save_CFLAGS="$CFLAGS"
-        CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
-        save_LIBS="$LIBS"
-        LIBS="$PTHREAD_LIBS $LIBS"
-        AC_MSG_CHECKING([for pthread_join in LIBS=$PTHREAD_LIBS with CFLAGS=$PTHREAD_CFLAGS])
-        AC_TRY_LINK_FUNC(pthread_join, acx_pthread_ok=yes)
-        AC_MSG_RESULT($acx_pthread_ok)
-        if test x"$acx_pthread_ok" = xno; then
-                PTHREAD_LIBS=""
-                PTHREAD_CFLAGS=""
-        fi
-        LIBS="$save_LIBS"
-        CFLAGS="$save_CFLAGS"
-fi
-
-# We must check for the threads library under a number of different
-# names; the ordering is very important because some systems
-# (e.g. DEC) have both -lpthread and -lpthreads, where one of the
-# libraries is broken (non-POSIX).
-
-# Create a list of thread flags to try.  Items starting with a "-" are
-# C compiler flags, and other items are library names, except for "none"
-# which indicates that we try without any flags at all.
-
-acx_pthread_flags="pthreads none -Kthread -kthread lthread -pthread -pthreads -mthreads pthread --thread-safe -mt"
-
-# The ordering *is* (sometimes) important.  Some notes on the
-# individual items follow:
-
-# pthreads: AIX (must check this before -lpthread)
-# none: in case threads are in libc; should be tried before -Kthread and
-#       other compiler flags to prevent continual compiler warnings
-# -Kthread: Sequent (threads in libc, but -Kthread needed for pthread.h)
-# -kthread: FreeBSD kernel threads (preferred to -pthread since SMP-able)
-# lthread: LinuxThreads port on FreeBSD (also preferred to -pthread)
-# -pthread: Linux/gcc (kernel threads), BSD/gcc (userland threads)
-# -pthreads: Solaris/gcc
-# -mthreads: Mingw32/gcc, Lynx/gcc
-# -mt: Sun Workshop C (may only link SunOS threads [-lthread], but it
-#      doesn't hurt to check since this sometimes defines pthreads too;
-#      also defines -D_REENTRANT)
-# pthread: Linux, etcetera
-# --thread-safe: KAI C++
-
-case "$host" in
-        *-*-solaris*)
-
-        # On Solaris (at least, for some versions), libc contains stubbed
-        # (non-functional) versions of the pthreads routines, so link-based
-        # tests will erroneously succeed.  (We need to link with -pthread or
-        # -lpthread.)  (The stubs are missing pthread_cleanup_push, or rather
-        # a function called by this macro, so we could check for that, but
-        # who knows whether they'll stub that too in a future libc.)  So,
-        # we'll just look for -pthreads and -lpthread first:
-
-        acx_pthread_flags="-pthread -pthreads pthread -mt $acx_pthread_flags"
-        ;;
-esac
-
-if test x"$acx_pthread_ok" = xno; then
-for flag in $acx_pthread_flags; do
-
-        case $flag in
-                none)
-                AC_MSG_CHECKING([whether pthreads work without any flags])
-                ;;
-
-                -*)
-                AC_MSG_CHECKING([whether pthreads work with $flag])
-                PTHREAD_CFLAGS="$flag"
-                ;;
-
-                *)
-                AC_MSG_CHECKING([for the pthreads library -l$flag])
-                PTHREAD_LIBS="-l$flag"
-                ;;
-        esac
-
-        save_LIBS="$LIBS"
-        save_CFLAGS="$CFLAGS"
-        LIBS="$PTHREAD_LIBS $LIBS"
-        CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
-
-        # Check for various functions.  We must include pthread.h,
-        # since some functions may be macros.  (On the Sequent, we
-        # need a special flag -Kthread to make this header compile.)
-        # We check for pthread_join because it is in -lpthread on IRIX
-        # while pthread_create is in libc.  We check for pthread_attr_init
-        # due to DEC craziness with -lpthreads.  We check for
-        # pthread_cleanup_push because it is one of the few pthread
-        # functions on Solaris that doesn't have a non-functional libc stub.
-        # We try pthread_create on general principles.
-        AC_TRY_LINK([#include <pthread.h>],
-                    [pthread_t th; pthread_join(th, 0);
-                     pthread_attr_init(0); pthread_cleanup_push(0, 0);
-                     pthread_create(0,0,0,0); pthread_cleanup_pop(0); ],
-                    [acx_pthread_ok=yes])
-
-        LIBS="$save_LIBS"
-        CFLAGS="$save_CFLAGS"
-
-        AC_MSG_RESULT($acx_pthread_ok)
-        if test "x$acx_pthread_ok" = xyes; then
-                break;
-        fi
-
-        PTHREAD_LIBS=""
-        PTHREAD_CFLAGS=""
-done
-fi
-
-# Various other checks:
-if test "x$acx_pthread_ok" = xyes; then
-        save_LIBS="$LIBS"
-        LIBS="$PTHREAD_LIBS $LIBS"
-        save_CFLAGS="$CFLAGS"
-        CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
-
-        # Detect AIX lossage: threads are created detached by default
-        # and the JOINABLE attribute has a nonstandard name (UNDETACHED).
-        AC_MSG_CHECKING([for joinable pthread attribute])
-        AC_TRY_LINK([#include <pthread.h>],
-                    [int attr=PTHREAD_CREATE_JOINABLE;],
-                    ok=PTHREAD_CREATE_JOINABLE, ok=unknown)
-        if test x"$ok" = xunknown; then
-                AC_TRY_LINK([#include <pthread.h>],
-                            [int attr=PTHREAD_CREATE_UNDETACHED;],
-                            ok=PTHREAD_CREATE_UNDETACHED, ok=unknown)
-        fi
-        if test x"$ok" != xPTHREAD_CREATE_JOINABLE; then
-                AC_DEFINE(PTHREAD_CREATE_JOINABLE, $ok,
-                          [Define to the necessary symbol if this constant
-                           uses a non-standard name on your system.])
-        fi
-        AC_MSG_RESULT(${ok})
-        if test x"$ok" = xunknown; then
-                AC_MSG_WARN([we do not know how to create joinable pthreads])
-        fi
-
-        AC_MSG_CHECKING([if more special flags are required for pthreads])
-        flag=no
-        case "$host" in
-                *-*-aix* | *-freebsd*)               flag="-D_THREAD_SAFE";;
-                *-*-solaris* | alpha*-osf* | *linux*) flag="-D_REENTRANT";;
-        esac
-        AC_MSG_RESULT(${flag})
-        if test "x$flag" != xno; then
-                PTHREAD_CFLAGS="$flag $PTHREAD_CFLAGS"
-        fi
-
-        LIBS="$save_LIBS"
-        CFLAGS="$save_CFLAGS"
-
-        # More AIX lossage: must compile with cc_r
-        AC_CHECK_PROG(PTHREAD_CC, cc_r, cc_r, ${CC})
-else
-        PTHREAD_CC="$CC"
-fi
-
-AC_SUBST(PTHREAD_LIBS)
-AC_SUBST(PTHREAD_CFLAGS)
-AC_SUBST(PTHREAD_CC)
-
-# Finally, execute ACTION-IF-FOUND/ACTION-IF-NOT-FOUND:
-if test x"$acx_pthread_ok" = xyes; then
-        ifelse([$1],,AC_DEFINE(HAVE_PTHREAD,1,[Define if you have POSIX threads libraries and header files.]),[$1])
-        :
-else
-        acx_pthread_ok=no
-        $2
-fi
-
-])dnl ACX_PTHREAD
diff --git a/buffer.c b/buffer.c
index c7a42fb..52ae1e1 100644
--- a/buffer.c
+++ b/buffer.c
@@ -28,7 +28,6 @@
 #include "buffer.h"
 #include "error.h"
 #include "mtu.h"
-#include "thread.h"
 
 #include "memdbg.h"
 
diff --git a/buffer.h b/buffer.h
index 9351c4e..f6b0a87 100644
--- a/buffer.h
+++ b/buffer.h
@@ -26,7 +26,6 @@
 #define BUFFER_H
 
 #include "basic.h"
-#include "thread.h"
 
 #define BUF_SIZE_MAX 1000000
 
diff --git a/config-win32.h b/config-win32.h
index be0b320..05753e9 100644
--- a/config-win32.h
+++ b/config-win32.h
@@ -270,11 +270,6 @@ typedef unsigned long in_addr_t;
 /* Route command */
 #define ROUTE_PATH "route"
 
-/* Windows doesn't support PTHREAD yet */
-#ifdef USE_PTHREAD
-#error The Windows version of OpenVPN does not support PTHREAD yet
-#endif
-
 #ifdef _MSC_VER
 /* MSVC++ hacks */
 #pragma warning(disable:4244) // conversion from 'foo' to 'bar', possible loss of data
diff --git a/configure.ac b/configure.ac
index 4777108..b44a3ac 100644
--- a/configure.ac
+++ b/configure.ac
@@ -152,12 +152,6 @@ AC_ARG_ENABLE(small,
    [SMALL="no"]
 )
 
-AC_ARG_ENABLE(pthread,
-   [  --enable-pthread        Enable pthread support (Experimental for OpenVPN 2.0)],
-   [PTHREAD="$enableval"],
-   [PTHREAD="no"]
-)
-
 AC_ARG_ENABLE(password-save,
    [  --enable-password-save  Allow --askpass and --auth-user-pass passwords to be read from a file],
    [PASSWORD_SAVE="$enableval"],
@@ -575,32 +569,6 @@ if test "$MEMCHECK" = "valgrind"; then
 fi
 
 dnl
-dnl check for pthread library
-dnl
-
-if test "$PTHREAD" = "yes"; then
-  AC_CHECKING([for pthread support])
-  AC_MSG_RESULT([********* WARNING: pthread support is experimental for OpenVPN 2.0])
-  ACX_PTHREAD(
-        [
-	    case "$host" in
-	    *openbsd*)
-		AC_MSG_RESULT([WARNING: pthread support on OpenBSD is unstable!])
-		CFLAGS="$CFLAGS -pthread"
-		;;
-	    esac
-	    LIBS="$PTHREAD_LIBS $LIBS"
-	    CFLAGS="$CFLAGS $PTHREAD_CFLAGS"
-	    CC="$PTHREAD_CC"
-	    AC_DEFINE(USE_PTHREAD, 1, [Use pthread-based multithreading])
-	],
-	[
-	    AC_MSG_RESULT([I don't know how to build with pthread support on this platform.])
-	    AC_MSG_ERROR([try ./configure --disable-pthread])
-	])
-fi
-
-dnl
 dnl check for dmalloc library
 dnl
 
@@ -609,11 +577,7 @@ if test "$MEMCHECK" = "dmalloc"; then
    AC_CHECK_HEADER(dmalloc.h, 
         [AC_CHECK_LIB(dmalloc, malloc,
 	    [
-               if test "$PTHREAD" = "yes"; then
-                   OPENVPN_ADD_LIBS(-ldmallocth)
-               else
-                   OPENVPN_ADD_LIBS(-ldmalloc)
-               fi
+               OPENVPN_ADD_LIBS(-ldmalloc)
 	       AC_DEFINE(DMALLOC, 1, [Use dmalloc memory debugging library])
 	    ],
 	    [AC_MSG_ERROR([dmalloc library not found.])]
diff --git a/crypto.c b/crypto.c
index d5c8c13..5cfc34a 100644
--- a/crypto.c
+++ b/crypto.c
@@ -29,7 +29,6 @@
 #include "crypto.h"
 #include "error.h"
 #include "misc.h"
-#include "thread.h"
 
 #include "memdbg.h"
 
@@ -1702,7 +1701,6 @@ prng_bytes (uint8_t *output, int len)
     {
       EVP_MD_CTX ctx;
       const int md_size = EVP_MD_size (nonce_md);
-      mutex_lock_static (L_PRNG);
       while (len > 0)
 	{
 	  unsigned int outlen = 0;
@@ -1716,7 +1714,6 @@ prng_bytes (uint8_t *output, int len)
 	  output += blen;
 	  len -= blen;
 	}
-      mutex_unlock_static (L_PRNG);
     }
   else
     RAND_bytes (output, len);
diff --git a/error.c b/error.c
index ce61f6c..7f31a16 100644
--- a/error.c
+++ b/error.c
@@ -26,7 +26,6 @@
 
 #include "error.h"
 #include "buffer.h"
-#include "thread.h"
 #include "misc.h"
 #include "win32.h"
 #include "socket.h"
@@ -229,8 +228,6 @@ void x_msg (const unsigned int flags, const char *format, ...)
 
   gc_init (&gc);
 
-  mutex_lock_static (L_MSG);
-
   m1 = (char *) gc_malloc (ERR_BUF_SIZE, false, &gc);
   m2 = (char *) gc_malloc (ERR_BUF_SIZE, false, &gc);
 
@@ -330,22 +327,12 @@ void x_msg (const unsigned int flags, const char *format, ...)
 	    }
 	  else
 	    {
-#ifdef USE_PTHREAD
-	      fprintf (fp, "%s [%d] %s%s%s%s",
-		       time_string (0, 0, show_usec, &gc),
-		       (int) openvpn_thread_self (),
-		       prefix,
-		       prefix_sep,
-		       m1,
-		       (flags&M_NOLF) ? "" : "\n");
-#else
 	      fprintf (fp, "%s %s%s%s%s",
 		       time_string (0, 0, show_usec, &gc),
 		       prefix,
 		       prefix_sep,
 		       m1,
 		       (flags&M_NOLF) ? "" : "\n");
-#endif
 	    }
 	  fflush(fp);
 	  ++x_msg_line_num;
@@ -355,8 +342,6 @@ void x_msg (const unsigned int flags, const char *format, ...)
   if (flags & M_FATAL)
     msg (M_INFO, "Exiting");
 
-  mutex_unlock_static (L_MSG);
-  
   if (flags & M_FATAL)
     openvpn_exit (OPENVPN_EXIT_STATUS_ERROR); /* exit point */
 
@@ -645,10 +630,6 @@ x_check_status (int status,
  */
 const char *x_msg_prefix; /* GLOBAL */
 
-#ifdef USE_PTHREAD
-pthread_key_t x_msg_prefix_key; /* GLOBAL */
-#endif
-
 /*
  * Allow MSG to be redirected through a virtual_output object
  */
@@ -656,26 +637,6 @@ pthread_key_t x_msg_prefix_key; /* GLOBAL */
 const struct virtual_output *x_msg_virtual_output; /* GLOBAL */
 
 /*
- * Init thread-local variables
- */
-
-void
-msg_thread_init (void)
-{
-#ifdef USE_PTHREAD
-  ASSERT (!pthread_key_create (&x_msg_prefix_key, NULL));
-#endif
-}
-
-void
-msg_thread_uninit (void)
-{
-#ifdef USE_PTHREAD
-  pthread_key_delete (x_msg_prefix_key);
-#endif
-}
-
-/*
  * Exiting.
  */
 
diff --git a/error.h b/error.h
index 6a9adea..4be3268 100644
--- a/error.h
+++ b/error.h
@@ -26,7 +26,6 @@
 #define ERROR_H
 
 #include "basic.h"
-#include "thread.h"
 
 /* #define ABORT_ON_ERROR */
 
@@ -282,34 +281,18 @@ set_check_status_error_delay (unsigned int milliseconds)
 
 extern const char *x_msg_prefix;
 
-#ifdef USE_PTHREAD
-extern pthread_key_t x_msg_prefix_key;
-#endif
-
 void msg_thread_init (void);
 void msg_thread_uninit (void);
 
 static inline void
 msg_set_prefix (const char *prefix)
 {
-#ifdef USE_PTHREAD
-  if (openvpn_thread_enabled ())
-    {
-      ASSERT (!pthread_setspecific (x_msg_prefix_key, prefix));
-    }
-  else
-#endif
     x_msg_prefix = prefix;
 }
 
 static inline const char *
 msg_get_prefix (void)
 {
-#ifdef USE_PTHREAD
-  if (openvpn_thread_enabled ())
-    return (const char *) pthread_getspecific (x_msg_prefix_key);
-  else
-#endif
     return x_msg_prefix;
 }
 
diff --git a/init.c b/init.c
index 4b2a8d0..a5eb605 100644
--- a/init.c
+++ b/init.c
@@ -718,8 +718,6 @@ init_static (void)
 void
 uninit_static (void)
 {
-  openvpn_thread_cleanup ();
-
 #ifdef USE_CRYPTO
   free_ssl_lib ();
 #endif
@@ -3500,23 +3498,6 @@ close_context (struct context *c, int sig, unsigned int flags)
 
 #ifdef USE_CRYPTO
 
-static void
-test_malloc (void)
-{
-  int i, j;
-  msg (M_INFO, "Multithreaded malloc test...");
-  for (i = 0; i < 25; ++i)
-    {
-      struct gc_arena gc = gc_new ();
-      const int limit = get_random () & 0x03FF;
-      for (j = 0; j < limit; ++j)
-	{
-	  gc_malloc (get_random () & 0x03FF, false, &gc);
-	}
-      gc_free (&gc);
-    }
-}
-
 /*
  * Do a loopback test
  * on the crypto subsystem.
@@ -3526,50 +3507,19 @@ test_crypto_thread (void *arg)
 {
   struct context *c = (struct context *) arg;
   const struct options *options = &c->options;
-#if defined(USE_PTHREAD)
-  struct context *child = NULL;
-  openvpn_thread_t child_id = 0;
-#endif
 
   ASSERT (options->test_crypto);
   init_verb_mute (c, IVM_LEVEL_1);
   context_init_1 (c);
   do_init_crypto_static (c, 0);
 
-#if defined(USE_PTHREAD)
-  {
-    if (c->first_time && options->n_threads > 1)
-      {
-	if (options->n_threads > 2)
-	  msg (M_FATAL, "ERROR: --test-crypto option only works with --threads set to 1 or 2");
-	openvpn_thread_init ();
-	ALLOC_OBJ (child, struct context);
-	context_clear (child);
-	child->options = *options;
-	options_detach (&child->options);
-	child->first_time = false;
-	child_id = openvpn_thread_create (test_crypto_thread, (void *) child);
-      }
-  }
-#endif
   frame_finalize_options (c, options);
 
-#if defined(USE_PTHREAD)
-  if (options->n_threads == 2)
-    test_malloc ();
-#endif
-
   test_crypto (&c->c2.crypto_options, &c->c2.frame);
 
   key_schedule_free (&c->c1.ks, true);
   packet_id_free (&c->c2.packet_id);
 
-#if defined(USE_PTHREAD)
-  if (c->first_time && options->n_threads > 1)
-    openvpn_thread_join (child_id);
-  if (child)
-    free (child);
-#endif
   context_gc_free (c);
   return NULL;
 }
diff --git a/list.c b/list.c
index 371c510..32c2adf 100644
--- a/list.c
+++ b/list.c
@@ -52,7 +52,6 @@ hash_init (const int n_buckets,
     {
       struct hash_bucket *b = &h->buckets[i];
       b->list = NULL;
-      mutex_init (&b->mutex);
     }
   return h;
 }
@@ -66,7 +65,6 @@ hash_free (struct hash *hash)
       struct hash_bucket *b = &hash->buckets[i];
       struct hash_element *he = b->list;
 
-      mutex_destroy (&b->mutex);
       while (he)
 	{
 	  struct hash_element *next = he->next;
@@ -148,7 +146,6 @@ hash_add (struct hash *hash, const void *key, void *value, bool replace)
 
   hv = hash_value (hash, key);
   bucket = &hash->buckets[hv & hash->mask];
-  mutex_lock (&bucket->mutex);
 
   if ((he = hash_lookup_fast (hash, bucket, key, hv))) /* already exists? */
     {
@@ -164,8 +161,6 @@ hash_add (struct hash *hash, const void *key, void *value, bool replace)
       ret = true;
     }
 
-  mutex_unlock (&bucket->mutex);
-
   return ret;
 }
 
@@ -257,10 +252,6 @@ hash_iterator_init (struct hash *hash,
 static inline void
 hash_iterator_lock (struct hash_iterator *hi, struct hash_bucket *b)
 {
-  if (hi->autolock)
-    {
-      mutex_lock (&b->mutex);
-    }
   hi->bucket = b;
   hi->last = NULL;
   hi->bucket_marked = false;
@@ -276,10 +267,6 @@ hash_iterator_unlock (struct hash_iterator *hi)
 	  hash_remove_marked (hi->hash, hi->bucket);
 	  hi->bucket_marked = false;
 	}
-      if (hi->autolock)
-	{
-	  mutex_unlock (&hi->bucket->mutex);
-	}
       hi->bucket = NULL;
       hi->last = NULL;
     }
diff --git a/list.h b/list.h
index d72751b..5cf9127 100644
--- a/list.h
+++ b/list.h
@@ -40,7 +40,6 @@
 /*#define LIST_TEST*/
 
 #include "basic.h"
-#include "thread.h"
 #include "buffer.h"
 
 #define hashsize(n) ((uint32_t)1<<(n))
@@ -56,7 +55,6 @@ struct hash_element
 
 struct hash_bucket
 {
-  MUTEX_DEFINE (mutex);
   struct hash_element *list;
 };
 
@@ -152,13 +150,11 @@ hash_bucket (struct hash *hash, uint32_t hv)
 static inline void
 hash_bucket_lock (struct hash_bucket *bucket)
 {
-  mutex_lock (&bucket->mutex);
 }
 
 static inline void
 hash_bucket_unlock (struct hash_bucket *bucket)
 {
-  mutex_unlock (&bucket->mutex);
 }
 
 static inline void *
@@ -168,11 +164,9 @@ hash_lookup_lock (struct hash *hash, const void *key, uint32_t hv)
   struct hash_element *he;
   struct hash_bucket *bucket = &hash->buckets[hv & hash->mask];
 
-  mutex_lock (&bucket->mutex);
   he = hash_lookup_fast (hash, bucket, key, hv);
   if (he)
     ret = he->value;
-  mutex_unlock (&bucket->mutex);
 
   return ret;
 }
@@ -211,9 +205,7 @@ hash_remove (struct hash *hash, const void *key)
 
   hv = hash_value (hash, key);
   bucket = &hash->buckets[hv & hash->mask];
-  mutex_lock (&bucket->mutex);
   ret = hash_remove_fast (hash, bucket, key, hv);
-  mutex_unlock (&bucket->mutex);
   return ret;
 }
 
diff --git a/mbuf.c b/mbuf.c
index 7e21252..1d8f602 100644
--- a/mbuf.c
+++ b/mbuf.c
@@ -38,7 +38,6 @@ mbuf_init (unsigned int size)
 {
   struct mbuf_set *ret;
   ALLOC_OBJ_CLEAR (ret, struct mbuf_set);
-  mutex_init (&ret->mutex);
   ret->capacity = adjust_power_of_2 (size);
   ALLOC_ARRAY (ret->array, struct mbuf_item, ret->capacity);
   return ret;
@@ -56,7 +55,6 @@ mbuf_free (struct mbuf_set *ms)
 	  mbuf_free_buf (item->buffer);
 	}
       free (ms->array);
-      mutex_destroy (&ms->mutex);
       free (ms);
     }
 }
@@ -89,7 +87,6 @@ void
 mbuf_add_item (struct mbuf_set *ms, const struct mbuf_item *item)
 {
   ASSERT (ms);
-  mutex_lock (&ms->mutex);
   if (ms->len == ms->capacity)
     {
       struct mbuf_item rm;
@@ -104,7 +101,6 @@ mbuf_add_item (struct mbuf_set *ms, const struct mbuf_item *item)
   if (++ms->len > ms->max_queued)
     ms->max_queued = ms->len;
   ++item->buffer->refcount;
-  mutex_unlock (&ms->mutex);
 }
 
 bool
@@ -113,8 +109,6 @@ mbuf_extract_item (struct mbuf_set *ms, struct mbuf_item *item, const bool lock)
   bool ret = false;
   if (ms)
     {
-      if (lock)
-	mutex_lock (&ms->mutex);
       while (ms->len)
 	{
 	  *item = ms->array[ms->head];
@@ -126,8 +120,6 @@ mbuf_extract_item (struct mbuf_set *ms, struct mbuf_item *item, const bool lock)
 	      break;
 	    }
 	}
-      if (lock)
-	mutex_unlock (&ms->mutex);
     }
   return ret;
 }
@@ -139,7 +131,6 @@ mbuf_peek_dowork (struct mbuf_set *ms)
   if (ms)
     {
       int i;
-      mutex_lock (&ms->mutex);
       for (i = 0; i < (int) ms->len; ++i)
 	{
 	  struct mbuf_item *item = &ms->array[MBUF_INDEX(ms->head, i, ms->capacity)];
@@ -149,7 +140,6 @@ mbuf_peek_dowork (struct mbuf_set *ms)
 	      break;
 	    }
 	}
-      mutex_unlock (&ms->mutex);
     }
   return ret;
 }
@@ -160,7 +150,6 @@ mbuf_dereference_instance (struct mbuf_set *ms, struct multi_instance *mi)
   if (ms)
     {
       int i;
-      mutex_lock (&ms->mutex);
       for (i = 0; i < (int) ms->len; ++i)
 	{
 	  struct mbuf_item *item = &ms->array[MBUF_INDEX(ms->head, i, ms->capacity)];
@@ -172,7 +161,6 @@ mbuf_dereference_instance (struct mbuf_set *ms, struct multi_instance *mi)
 	      msg (D_MBUF, "MBUF: dereferenced queued packet");
 	    }
 	}
-      mutex_unlock (&ms->mutex);
     }
 }
 
diff --git a/mbuf.h b/mbuf.h
index ab7cb05..bbcd69a 100644
--- a/mbuf.h
+++ b/mbuf.h
@@ -58,7 +58,6 @@ struct mbuf_item
 
 struct mbuf_set
 {
-  MUTEX_DEFINE (mutex);
   unsigned int head;
   unsigned int len;
   unsigned int capacity;
diff --git a/misc.c b/misc.c
index 1f7f616..eb8b023 100644
--- a/misc.c
+++ b/misc.c
@@ -28,7 +28,6 @@
 #include "misc.h"
 #include "tun.h"
 #include "error.h"
-#include "thread.h"
 #include "otime.h"
 #include "plugin.h"
 #include "options.h"
@@ -636,9 +635,7 @@ strerror_ts (int errnum, struct gc_arena *gc)
 #ifdef HAVE_STRERROR
   struct buffer out = alloc_buf_gc (256, gc);
 
-  mutex_lock_static (L_STRERR);
   buf_printf (&out, "%s", openvpn_strerror (errnum, gc));
-  mutex_unlock_static (L_STRERR);
   return BSTR (&out);
 #else
   return "[error string unavailable]";
@@ -776,18 +773,15 @@ struct env_set *
 env_set_create (struct gc_arena *gc)
 {
   struct env_set *es;
-  mutex_lock_static (L_ENV_SET);
   ALLOC_OBJ_CLEAR_GC (es, struct env_set, gc);
   es->list = NULL;
   es->gc = gc;
-  mutex_unlock_static (L_ENV_SET);
   return es;
 }
 
 void
 env_set_destroy (struct env_set *es)
 {
-  mutex_lock_static (L_ENV_SET);
   if (es && es->gc == NULL)
     {
       struct env_item *e = es->list;
@@ -800,7 +794,6 @@ env_set_destroy (struct env_set *es)
 	}
       free (es);
     }
-  mutex_unlock_static (L_ENV_SET);
 }
 
 bool
@@ -809,9 +802,7 @@ env_set_del (struct env_set *es, const char *str)
   bool ret;
   ASSERT (es);
   ASSERT (str);
-  mutex_lock_static (L_ENV_SET);
   ret = env_set_del_nolock (es, str);
-  mutex_unlock_static (L_ENV_SET);
   return ret;
 }
 
@@ -820,9 +811,7 @@ env_set_add (struct env_set *es, const char *str)
 {
   ASSERT (es);
   ASSERT (str);
-  mutex_lock_static (L_ENV_SET);
   env_set_add_nolock (es, str);
-  mutex_unlock_static (L_ENV_SET);
 }
 
 void
@@ -835,7 +824,6 @@ env_set_print (int msglevel, const struct env_set *es)
 
       if (es)
 	{
-	  mutex_lock_static (L_ENV_SET);
 	  e = es->list;
 	  i = 0;
 
@@ -846,7 +834,6 @@ env_set_print (int msglevel, const struct env_set *es)
 	      ++i;
 	      e = e->next;
 	    }
-	  mutex_unlock_static (L_ENV_SET);
 	}
     }
 }
@@ -860,14 +847,12 @@ env_set_inherit (struct env_set *es, const struct env_set *src)
 
   if (src)
     {
-      mutex_lock_static (L_ENV_SET);
       e = src->list;
       while (e)
 	{
 	  env_set_add_nolock (es, e->string);
 	  e = e->next;
 	}
-      mutex_unlock_static (L_ENV_SET);
     }
 }
 
@@ -879,7 +864,6 @@ env_set_add_to_environment (const struct env_set *es)
       struct gc_arena gc = gc_new ();
       const struct env_item *e;
 
-      mutex_lock_static (L_ENV_SET);
       e = es->list;
 
       while (e)
@@ -892,7 +876,6 @@ env_set_add_to_environment (const struct env_set *es)
 
 	  e = e->next;
 	}
-      mutex_unlock_static (L_ENV_SET);
       gc_free (&gc);
     }
 }
@@ -905,7 +888,6 @@ env_set_remove_from_environment (const struct env_set *es)
       struct gc_arena gc = gc_new ();
       const struct env_item *e;
 
-      mutex_lock_static (L_ENV_SET);
       e = es->list;
 
       while (e)
@@ -918,7 +900,6 @@ env_set_remove_from_environment (const struct env_set *es)
 
 	  e = e->next;
 	}
-      mutex_unlock_static (L_ENV_SET);
       gc_free (&gc);
     }
 }
@@ -1037,12 +1018,10 @@ setenv_str_ex (struct env_set *es,
 	char *str = construct_name_value (name_tmp, val_tmp, NULL);
 	int status;
 
-	mutex_lock_static (L_PUTENV);
 	status = putenv (str);
 	/*msg (M_INFO, "PUTENV '%s'", str);*/
 	if (!status)
 	  manage_env (str);
-	mutex_unlock_static (L_PUTENV);
 	if (status)
 	  msg (M_WARN | M_ERRNO, "putenv('%s') failed", str);
       }
@@ -1179,9 +1158,7 @@ create_temp_file (const char *directory, const char *prefix, struct gc_arena *gc
       const char *rndstr;
 
       ++attempts;
-      mutex_lock_static (L_CREATE_TEMP);
       ++counter;
-      mutex_unlock_static (L_CREATE_TEMP);
 
       prng_bytes (rndbytes, sizeof rndbytes);
       rndstr = format_hex_ex (rndbytes, sizeof rndbytes, 40, 0, NULL, gc);
diff --git a/multi.c b/multi.c
index dc26a02..6b85eeb 100644
--- a/multi.c
+++ b/multi.c
@@ -633,7 +633,6 @@ multi_create_instance (struct multi_context *m, const struct mroute_addr *real)
 
   ALLOC_OBJ_CLEAR (mi, struct multi_instance);
 
-  mutex_init (&mi->mutex);
   mi->gc = gc_new ();
   multi_instance_inc_refcount (mi);
   mi->vaddr_handle = -1;
diff --git a/multi.h b/multi.h
index 99436c2..08964a2 100644
--- a/multi.h
+++ b/multi.h
@@ -56,7 +56,6 @@ struct multi_reap
 struct multi_instance {
   struct schedule_entry se;    /* this must be the first element of the structure */
   struct gc_arena gc;
-  MUTEX_DEFINE (mutex);
   bool defined;
   bool halt;
   int refcount;
@@ -274,7 +273,6 @@ multi_instance_dec_refcount (struct multi_instance *mi)
   if (--mi->refcount <= 0)
     {
       gc_free (&mi->gc);
-      mutex_destroy (&mi->mutex);
       free (mi);
     }
 }
diff --git a/options.c b/options.c
index e39a8ba..3f5c682 100644
--- a/options.c
+++ b/options.c
@@ -67,9 +67,6 @@ const char title_string[] =
 #ifdef PRODUCT_TAP_DEBUG
   " [TAPDBG]"
 #endif
-#ifdef USE_PTHREAD
-  " [PTHREAD]"
-#endif
 #ifdef ENABLE_PKCS11
   " [PKCS11]"
 #endif
@@ -287,13 +284,6 @@ static const char usage_message[] =
   "--suppress-timestamps : Don't log timestamps to stdout/stderr.\n"
   "--writepid file : Write main process ID to file.\n"
   "--nice n        : Change process priority (>0 = lower, <0 = higher).\n"
-#if 0
-#ifdef USE_PTHREAD
-  "--nice-work n   : Change thread priority of work thread.  The work\n"
-  "                  thread is used for background processing such as\n"
-  "                  RSA key number crunching.\n"
-#endif
-#endif
   "--echo [parms ...] : Echo parameters to log output.\n"
   "--verb n        : Set output verbosity to n (default=%d):\n"
   "                  (Level 3 is recommended if you want a good summary\n"
@@ -719,9 +709,6 @@ init_options (struct options *o, const bool init_gc)
   o->tuntap_options.dhcp_masq_offset = 0;       /* use network address as internal DHCP server address */
   o->route_method = ROUTE_METHOD_ADAPTIVE;
 #endif
-#ifdef USE_PTHREAD
-  o->n_threads = 1;
-#endif
 #if P2MP_SERVER
   o->real_hash_size = 256;
   o->virtual_hash_size = 256;
@@ -870,9 +857,6 @@ is_persist_option (const struct options *o)
       || o->persist_key
       || o->persist_local_ip
       || o->persist_remote_ip
-#ifdef USE_PTHREAD
-      || o->n_threads >= 2
-#endif
     ;
 }
 
@@ -4197,26 +4181,6 @@ add_option (struct options *options,
       goto err;
 #endif
     }
-#ifdef USE_PTHREAD
-  else if (streq (p[0], "nice-work") && p[1])
-    {
-      VERIFY_PERMISSION (OPT_P_NICE);
-      options->nice_work = atoi (p[1]);
-    }
-  else if (streq (p[0], "threads") && p[1])
-    {
-      int n_threads;
-
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      n_threads = positive_atoi (p[1]);
-      if (n_threads < 1)
-	{
-	  msg (msglevel, "--threads parameter must be at least 1");
-	  goto err;
-	}
-      options->n_threads = n_threads;
-    }
-#endif
   else if (streq (p[0], "shaper") && p[1])
     {
 #ifdef HAVE_GETTIMEOFDAY
diff --git a/options.h b/options.h
index 240f3bb..f40394e 100644
--- a/options.h
+++ b/options.h
@@ -352,11 +352,6 @@ struct options
   struct plugin_option_list *plugin_list;
 #endif
 
-#ifdef USE_PTHREAD
-  int n_threads;
-  int nice_work;
-#endif
-
 #if P2MP
 
 #if P2MP_SERVER
diff --git a/otime.c b/otime.c
index dae0c0c..b295646 100644
--- a/otime.c
+++ b/otime.c
@@ -123,10 +123,8 @@ time_string (time_t t, int usec, bool show_usec, struct gc_arena *gc)
 	}
     }
 
-  mutex_lock_static (L_CTIME);
   t = tv.tv_sec;
   buf_printf (&out, "%s", ctime(&t));
-  mutex_unlock_static (L_CTIME);
   buf_rmtail (&out, '\n');
 
   if (show_usec && tv.tv_usec)
diff --git a/otime.h b/otime.h
index 74597e3..fd73bbd 100644
--- a/otime.h
+++ b/otime.h
@@ -28,7 +28,6 @@
 #include "common.h"
 #include "integer.h"
 #include "buffer.h"
-#include "thread.h"
 
 struct frequency_limit
 {
diff --git a/perf.c b/perf.c
index 475c699..ec8349b 100644
--- a/perf.c
+++ b/perf.c
@@ -33,10 +33,6 @@
 
 #include "memdbg.h"
 
-#ifdef USE_PTHREAD
-#error ENABLE_PERFORMANCE_METRICS is incompatible with USE_PTHREAD
-#endif
-
 static const char *metric_names[] = {
   "PERF_BIO_READ_PLAINTEXT",
   "PERF_BIO_WRITE_PLAINTEXT",
diff --git a/plugin.c b/plugin.c
index 769de8d..0d66611 100644
--- a/plugin.c
+++ b/plugin.c
@@ -558,8 +558,6 @@ plugin_call (const struct plugin_list *pl,
       bool error = false;
       bool deferred = false;
       
-      mutex_lock_static (L_PLUGIN);
-
       setenv_del (es, "script_type");
       envp = make_env_array (es, false, &gc);
 
@@ -588,8 +586,6 @@ plugin_call (const struct plugin_list *pl,
       if (pr)
 	pr->n = i;
 
-      mutex_unlock_static (L_PLUGIN);
-
       gc_free (&gc);
 
       if (type == OPENVPN_PLUGIN_ENABLE_PF && success)
diff --git a/pool.h b/pool.h
index b37c828..81264a9 100644
--- a/pool.h
+++ b/pool.h
@@ -31,7 +31,6 @@
 
 #include "basic.h"
 #include "status.h"
-#include "thread.h"
 
 #define IFCONFIG_POOL_MAX         65536
 #define IFCONFIG_POOL_MIN_NETBITS    16
diff --git a/schedule.c b/schedule.c
index 8a53031..f0482ab 100644
--- a/schedule.c
+++ b/schedule.c
@@ -363,24 +363,20 @@ schedule_init (void)
   struct schedule *s;
 
   ALLOC_OBJ_CLEAR (s, struct schedule);
-  mutex_init (&s->mutex);
   return s;
 }
 
 void
 schedule_free (struct schedule *s)
 {
-  mutex_destroy (&s->mutex);
   free (s);
 }
 
 void
 schedule_remove_entry (struct schedule *s, struct schedule_entry *e)
 {
-  mutex_lock (&s->mutex);
   s->earliest_wakeup = NULL; /* invalidate cache */
   schedule_remove_node (s, e);
-  mutex_unlock (&s->mutex);
 }
 
 /*
diff --git a/schedule.h b/schedule.h
index 1a6d219..71c6d8c 100644
--- a/schedule.h
+++ b/schedule.h
@@ -42,7 +42,6 @@
 /*#define SCHEDULE_TEST*/
 
 #include "otime.h"
-#include "thread.h"
 #include "error.h"
 
 struct schedule_entry
@@ -56,7 +55,6 @@ struct schedule_entry
 
 struct schedule
 {
-  MUTEX_DEFINE (mutex);
   struct schedule_entry *earliest_wakeup; /* cached earliest wakeup */
   struct schedule_entry *root;            /* the root of the treap (btree) */
 };
@@ -100,14 +98,12 @@ schedule_add_entry (struct schedule *s,
 		    const struct timeval *tv,
 		    unsigned int sigma)
 {
-  mutex_lock (&s->mutex);
   if (!IN_TREE (e) || !sigma || !tv_within_sigma (tv, &e->tv, sigma))
     {
       e->tv = *tv;
       schedule_add_modify (s, e);
       s->earliest_wakeup = NULL; /* invalidate cache */
     }
-  mutex_unlock (&s->mutex);
 }
 
 /*
@@ -122,8 +118,6 @@ schedule_get_earliest_wakeup (struct schedule *s,
 {
   struct schedule_entry *ret;
 
-  mutex_lock (&s->mutex);
-
   /* cache result */
   if (!s->earliest_wakeup)
     s->earliest_wakeup = schedule_find_least (s->root);
@@ -131,8 +125,6 @@ schedule_get_earliest_wakeup (struct schedule *s,
   if (ret)
     *wakeup = ret->tv;
 
-  mutex_unlock (&s->mutex);
-
   return ret;
 }
 
diff --git a/socket.c b/socket.c
index dbf65a1..cf8f560 100644
--- a/socket.c
+++ b/socket.c
@@ -26,7 +26,6 @@
 
 #include "socket.h"
 #include "fdmisc.h"
-#include "thread.h"
 #include "misc.h"
 #include "gremlin.h"
 #include "plugin.h"
@@ -1934,10 +1933,8 @@ print_sockaddr_ex (const struct openvpn_sockaddr *addr,
       struct buffer out = alloc_buf_gc (64, gc);
       const int port = ntohs (addr->sa.sin_port);
 
-      mutex_lock_static (L_INET_NTOA);
       if (!(flags & PS_DONT_SHOW_ADDR))
 	buf_printf (&out, "%s", (addr_defined (addr) ? inet_ntoa (addr->sa.sin_addr) : "[undef]"));
-      mutex_unlock_static (L_INET_NTOA);
 
       if (((flags & PS_SHOW_PORT) || (addr_defined (addr) && (flags & PS_SHOW_PORT_IF_DEFINED)))
 	  && port)
@@ -1999,9 +1996,7 @@ print_in_addr_t (in_addr_t addr, unsigned int flags, struct gc_arena *gc)
       CLEAR (ia);
       ia.s_addr = (flags & IA_NET_ORDER) ? addr : htonl (addr);
 
-      mutex_lock_static (L_INET_NTOA);
       buf_printf (&out, "%s", inet_ntoa (ia));
-      mutex_unlock_static (L_INET_NTOA);
     }
   return BSTR (&out);
 }
@@ -2017,9 +2012,7 @@ setenv_sockaddr (struct env_set *es, const char *name_prefix, const struct openv
   else
     openvpn_snprintf (name_buf, sizeof (name_buf), "%s", name_prefix);
 
-  mutex_lock_static (L_INET_NTOA);
   setenv_str (es, name_buf, inet_ntoa (addr->sa.sin_addr));
-  mutex_unlock_static (L_INET_NTOA);
 
   if ((flags & SA_IP_PORT) && addr->sa.sin_port)
     {
diff --git a/ssl.c b/ssl.c
index d683925..030fee9 100644
--- a/ssl.c
+++ b/ssl.c
@@ -39,7 +39,6 @@
 #include "common.h"
 #include "integer.h"
 #include "socket.h"
-#include "thread.h"
 #include "misc.h"
 #include "fdmisc.h"
 #include "interval.h"
diff --git a/ssl.h b/ssl.h
index 5eeca21..3890f0b 100644
--- a/ssl.h
+++ b/ssl.h
@@ -42,7 +42,6 @@
 #include "reliable.h"
 #include "socket.h"
 #include "mtu.h"
-#include "thread.h"
 #include "options.h"
 #include "plugin.h"
 
diff --git a/syshead.h b/syshead.h
index 7cc4dba..4894b48 100644
--- a/syshead.h
+++ b/syshead.h
@@ -542,24 +542,6 @@ socket_defined (const socket_descriptor_t sd)
 #endif
 
 /*
- * Do we have pthread capability?
- */
-#ifdef USE_PTHREAD
-#if defined(USE_CRYPTO) && defined(USE_SSL) && P2MP
-#include <pthread.h>
-#else
-#undef USE_PTHREAD
-#endif
-#endif
-
-/*
- * Pthread support is currently experimental (and quite unfinished).
- */
-#if 1 /* JYFIXME -- if defined, disable pthread */
-#undef USE_PTHREAD
-#endif
-
-/*
  * Should we include OCC (options consistency check) code?
  */
 #ifndef ENABLE_SMALL
diff --git a/thread.c b/thread.c
deleted file mode 100644
index efe911b..0000000
--- a/thread.c
+++ /dev/null
@@ -1,156 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#include "syshead.h"
-
-#ifdef USE_PTHREAD
-
-#include "thread.h"
-#include "buffer.h"
-#include "common.h"
-#include "error.h"
-#include "crypto.h"
-
-#include "memdbg.h"
-
-static struct sparse_mutex *ssl_mutex;  /* GLOBAL */
-
-static void
-ssl_pthreads_locking_callback (int mode, int type, char *file, int line)
-{
-  dmsg (D_OPENSSL_LOCK, "SSL LOCK thread=%4lu mode=%s lock=%s %s:%d",
-	   CRYPTO_thread_id (),
-	   (mode & CRYPTO_LOCK) ? "l" : "u",
-	   (type & CRYPTO_READ) ? "r" : "w", file, line);
-
-  if (mode & CRYPTO_LOCK)
-    pthread_mutex_lock (&ssl_mutex[type].mutex);
-  else
-    pthread_mutex_unlock (&ssl_mutex[type].mutex);
-}
-
-static unsigned long
-ssl_pthreads_thread_id (void)
-{
-  unsigned long ret;
-
-  ret = (unsigned long) pthread_self ();
-  return ret;
-}
-
-static void
-ssl_thread_setup (void)
-{
-  int i;
-
-#error L_MSG needs to be initialized as a recursive mutex
-
-  ssl_mutex = OPENSSL_malloc (CRYPTO_num_locks () * sizeof (struct sparse_mutex));
-  for (i = 0; i < CRYPTO_num_locks (); i++)
-    pthread_mutex_init (&ssl_mutex[i].mutex, NULL);
-
-  CRYPTO_set_id_callback ((unsigned long (*)(void)) ssl_pthreads_thread_id);
-  CRYPTO_set_locking_callback ((void (*)(int, int, const char*, int)) ssl_pthreads_locking_callback);
-}
-
-static void
-ssl_thread_cleanup (void)
-{
-  int i;
-
-  dmsg (D_OPENSSL_LOCK, "SSL LOCK cleanup");
-  CRYPTO_set_locking_callback (NULL);
-  for (i = 0; i < CRYPTO_num_locks (); i++)
-    pthread_mutex_destroy (&ssl_mutex[i].mutex);
-  OPENSSL_free (ssl_mutex);
-}
-
-struct sparse_mutex mutex_array[N_MUTEXES]; /* GLOBAL */
-bool pthread_initialized;                   /* GLOBAL */
-
-openvpn_thread_t
-openvpn_thread_create (void *(*start_routine) (void *), void* arg)
-{
-  openvpn_thread_t ret;
-  ASSERT (pthread_initialized);
-  ASSERT (!pthread_create (&ret, NULL, start_routine, arg));
-  dmsg (D_THREAD_DEBUG, "CREATE THREAD ID=%lu", (unsigned long)ret);
-  return ret;
-}
-
-void
-openvpn_thread_join (openvpn_thread_t id)
-{
-  ASSERT (pthread_initialized);
-  pthread_join (id, NULL);
-}
-
-void
-openvpn_thread_init ()
-{
-  int i;
-
-  ASSERT (!pthread_initialized);
-
-  msg (M_INFO, "PTHREAD support initialized");
-
-  /* initialize OpenSSL library locking */
-#if defined(USE_CRYPTO) && defined(USE_SSL)
-  ssl_thread_setup();
-#endif
-  
-  /* initialize static mutexes */
-  for (i = 0; i < N_MUTEXES; i++)
-    ASSERT (!pthread_mutex_init (&mutex_array[i].mutex, NULL));
-
-  msg_thread_init ();
-
-  pthread_initialized = true;
-}
-
-void
-openvpn_thread_cleanup ()
-{
-  if (pthread_initialized)
-    {
-      int i;
-
-      pthread_initialized = false;
-
-      /* cleanup OpenSSL library locking */
-#if defined(USE_CRYPTO) && defined(USE_SSL)
-      ssl_thread_cleanup();
-#endif
-
-      /* destroy static mutexes */
-      for (i = 0; i < N_MUTEXES; i++)
-	ASSERT (!pthread_mutex_destroy (&mutex_array[i].mutex));
-
-      msg_thread_uninit ();
-    }
-}
-
-#else
-static void dummy(void) {}
-#endif
diff --git a/thread.h b/thread.h
deleted file mode 100644
index 427237b..0000000
--- a/thread.h
+++ /dev/null
@@ -1,235 +0,0 @@
-/*
- *  OpenVPN -- An application to securely tunnel IP networks
- *             over a single UDP port, with support for SSL/TLS-based
- *             session authentication and key exchange,
- *             packet encryption, packet authentication, and
- *             packet compression.
- *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
- *
- *  This program is free software; you can redistribute it and/or modify
- *  it under the terms of the GNU General Public License version 2
- *  as published by the Free Software Foundation.
- *
- *  This program is distributed in the hope that it will be useful,
- *  but WITHOUT ANY WARRANTY; without even the implied warranty of
- *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
- *  GNU General Public License for more details.
- *
- *  You should have received a copy of the GNU General Public License
- *  along with this program (see the file COPYING included with this
- *  distribution); if not, write to the Free Software Foundation, Inc.,
- *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
- */
-
-#ifndef THREAD_H
-#define THREAD_H
-
-#include "basic.h"
-#include "common.h"
-
-/*
- * OpenVPN static mutex locks, by mutex type
- */
-#define L_UNUSED       0
-#define L_CTIME        1
-#define L_INET_NTOA    2
-#define L_MSG          3
-#define L_STRERR       4
-#define L_PUTENV       5
-#define L_PRNG         6
-#define L_GETTIMEOFDAY 7
-#define L_ENV_SET      8
-#define L_SYSTEM       9
-#define L_CREATE_TEMP  10
-#define L_PLUGIN       11
-#define N_MUTEXES      12
-
-#ifdef USE_PTHREAD
-
-#define MAX_THREADS     50
-
-#define CACHE_LINE_SIZE 128
-
-/*
- * Improve SMP performance by making sure that each
- * mutex resides in its own cache line.
- */
-struct sparse_mutex
-{
-  pthread_mutex_t mutex;
-  uint8_t dummy [CACHE_LINE_SIZE - sizeof (pthread_mutex_t)];
-};
-
-typedef pthread_t openvpn_thread_t;
-
-extern bool pthread_initialized;
-
-extern struct sparse_mutex mutex_array[N_MUTEXES];
-
-#define MUTEX_DEFINE(lock) pthread_mutex_t lock
-#define MUTEX_PTR_DEFINE(lock) pthread_mutex_t *lock
-
-static inline bool
-openvpn_thread_enabled (void)
-{
-  return pthread_initialized;
-}
-
-static inline openvpn_thread_t
-openvpn_thread_self (void)
-{
-  return pthread_initialized ? pthread_self() : 0;
-}
-
-static inline void
-mutex_init (pthread_mutex_t *mutex)
-{
-  if (mutex)
-    pthread_mutex_init (mutex, NULL);
-}
-
-static inline void
-mutex_destroy (pthread_mutex_t *mutex)
-{
-  if (mutex)
-    pthread_mutex_destroy (mutex);
-}
-
-static inline void
-mutex_lock (pthread_mutex_t *mutex)
-{
-  if (pthread_initialized && mutex)
-    pthread_mutex_lock (mutex);
-}
-
-static inline bool
-mutex_trylock (pthread_mutex_t *mutex)
-{
-  if (pthread_initialized && mutex)
-    return pthread_mutex_trylock (mutex) == 0;
-  else
-    return true;
-}
-
-static inline void
-mutex_unlock (pthread_mutex_t *mutex)
-{
-  if (pthread_initialized && mutex)
-    {
-      pthread_mutex_unlock (mutex);
-#if 1 /* JYFIXME: if race conditions exist, make them more likely to occur */
-      sleep (0);
-#endif
-    }
-}
-
-static inline void
-mutex_cycle (pthread_mutex_t *mutex)
-{
-  if (pthread_initialized && mutex)
-    {
-      pthread_mutex_unlock (mutex);
-      sleep (0);
-      pthread_mutex_lock (mutex);
-    }
-}
-
-static inline void
-mutex_lock_static (int type)
-{
-  mutex_lock (&mutex_array[type].mutex);
-}
-
-static inline void
-mutex_unlock_static (int type)
-{
-  mutex_unlock (&mutex_array[type].mutex);
-}
-
-static inline void
-mutex_cycle_static (int type)
-{
-  mutex_cycle (&mutex_array[type].mutex);
-}
-
-void openvpn_thread_init (void);
-void openvpn_thread_cleanup (void);
-
-openvpn_thread_t openvpn_thread_create (void *(*start_routine) (void *), void* arg);
-void openvpn_thread_join (openvpn_thread_t id);
-
-#else /* USE_PTHREAD */
-
-typedef int openvpn_thread_t;
-
-#if defined(_MSC_VER) || PEDANTIC
-
-#define MUTEX_DEFINE(lock) int eat_semicolon
-#define MUTEX_PTR_DEFINE(lock) int eat_semicolon
-
-#else
-
-#define MUTEX_DEFINE(lock)
-#define MUTEX_PTR_DEFINE(lock)
-
-#endif
-
-#define mutex_init(m)
-#define mutex_destroy(m)
-#define mutex_lock(m)
-#define mutex_trylock(m) (true)
-#define mutex_unlock(m)
-#define mutex_cycle(m)
-
-static inline bool
-openvpn_thread_enabled (void)
-{
-  return false;
-}
-
-static inline openvpn_thread_t
-openvpn_thread_self (void)
-{
-  return 0;
-}
-
-static inline void
-openvpn_thread_init (void)
-{
-}
-
-static inline void
-openvpn_thread_cleanup (void)
-{
-}
-
-static inline openvpn_thread_t
-openvpn_thread_create (void *(*start_routine) (void *), void* arg)
-{
-  return 0;
-}
-
-static inline void
-work_thread_join (openvpn_thread_t id)
-{
-}
-
-static inline void
-mutex_lock_static (int type)
-{
-}
-
-static inline void
-mutex_unlock_static (int type)
-{
-}
-
-static inline void
-mutex_cycle_static (int type)
-{
-}
-
-#endif /* USE_PTHREAD */
-
-#endif /* THREAD_H */
-- 
1.7.2.2


