From: Alon Bar-Lev <alon.barlev@...277...>
Date: Wed, 29 Feb 2012 22:12:15 +0200
Message-Id: <1330546342-17794-46-git-send-email-alon.barlev@...277...>
In-Reply-To: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
References: <1330546342-17794-1-git-send-email-alon.barlev@...277...>
Subject: [Openvpn-devel] [PATCH 45/52] build: move gettimeofday() emulation
	to compat
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
To: 
Cc: Alon Bar-Lev <alon.barlev@...277...>

Remove all references to gettimeofday() from main project.

SIDE EFFECT: mingw will use its own internal gettimeofday().

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 config-msvc.h                    |    1 -
 configure.ac                     |    1 -
 src/compat/Makefile.am           |    3 +-
 src/compat/compat-gettimeofday.c |  131 ++++++++++++++++++++++++++++++++++++++
 src/compat/compat.h              |   13 ++++
 src/compat/compat.vcproj         |    4 +
 src/openvpn/forward.c            |    8 +-
 src/openvpn/init.c               |    4 +-
 src/openvpn/misc.c               |    5 --
 src/openvpn/openvpn.h            |    2 +-
 src/openvpn/options.c            |    8 +-
 src/openvpn/options.h            |    4 +-
 src/openvpn/otime.c              |   84 +-----------------------
 src/openvpn/otime.h              |   17 ++----
 src/openvpn/shaper.c             |    4 +-
 src/openvpn/shaper.h             |    4 +-
 src/openvpn/syshead.h            |   18 +++++-
 17 files changed, 192 insertions(+), 119 deletions(-)
 create mode 100644 src/compat/compat-gettimeofday.c

diff --git a/config-msvc.h b/config-msvc.h
index 577371f..0e42505 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -51,7 +51,6 @@
 #define HAVE_CPP_VARARG_MACRO_ISO 1
 #define HAVE_CTIME 1
 #define HAVE_EVP_CIPHER_CTX_SET_KEY_LENGTH 1
-#define HAVE_GETTIMEOFDAY 1
 #define HAVE_IN_PKTINFO 1
 #define HAVE_MEMSET 1
 #define HAVE_PUTENV 1
diff --git a/configure.ac b/configure.ac
index ff3df28..dc138ba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -541,7 +541,6 @@ m4_define(
 	[setsockopt getsockopt getsockname poll]dnl
 )
 if test "${WIN32}" = "yes"; then
-	AC_DEFINE([HAVE_GETTIMEOFDAY], [1], [We fake gettimeofday for win32 at otime.c])
 	m4_foreach(
 		[F],
 		m4_split(SOCKET_FUNCS SOCKET_OPT_FUNCS),
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index e33e5e7..5e9db5f 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -20,4 +20,5 @@ noinst_LTLIBRARIES = libcompat.la
 libcompat_la_SOURCES = \
 	compat.h \
 	compat-dirname.c \
-	compat-basename.c
+	compat-basename.c \
+	compat-gettimeofday.c
diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
new file mode 100644
index 0000000..0f32d5d
--- /dev/null
+++ b/src/compat/compat-gettimeofday.c
@@ -0,0 +1,131 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License
+ *  along with this program (see the file COPYING included with this
+ *  distribution); if not, write to the Free Software Foundation, Inc.,
+ *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#ifndef HAVE_GETTIMEOFDAY
+
+#include "compat.h"
+
+#ifdef WIN32
+/*
+ * NOTICE: mingw has much faster gettimeofday!
+ * autoconf will set HAVE_GETTIMEOFDAY
+ */
+
+#include <windows.h>
+#include <time.h>
+
+static time_t gtc_base = 0;
+static DWORD gtc_last = 0;
+static time_t last_sec = 0;
+static unsigned int last_msec = 0;
+static int bt_last = 0;
+
+static void
+gettimeofday_calibrate (void)
+{
+  const time_t t = time(NULL);
+  const DWORD gtc = GetTickCount();
+  gtc_base = t - gtc/1000;
+  gtc_last = gtc;
+}
+
+/*
+ * Rewritten by JY for OpenVPN 2.1, after I realized that
+ * QueryPerformanceCounter takes nearly 2 orders of magnitude
+ * more processor cycles than GetTickCount.
+ */
+int
+gettimeofday (struct timeval *tv, void *tz)
+{
+  const DWORD gtc = GetTickCount();
+  int bt = 0;
+  time_t sec;
+  unsigned int msec;
+  const int backtrack_hold_seconds = 10;
+
+  (void)tz;
+
+  /* recalibrate at the dreaded 49.7 day mark */
+  if (!gtc_base || gtc < gtc_last)
+    gettimeofday_calibrate ();
+  gtc_last = gtc;
+
+  sec = gtc_base + gtc / 1000;
+  msec = gtc % 1000;
+
+  if (sec == last_sec)
+    {
+      if (msec < last_msec)
+	{
+	  msec = last_msec;
+	  bt = 1;
+	}
+    }
+  else if (sec < last_sec)
+    {
+      /* We try to dampen out backtracks of less than backtrack_hold_seconds.
+	 Larger backtracks will be passed through and dealt with by the
+	 TIME_BACKTRACK_PROTECTION code (if enabled) */
+      if (sec > last_sec - backtrack_hold_seconds)
+	{
+	  sec = last_sec;
+	  msec = last_msec;
+	}
+      bt = 1;
+    }
+
+  tv->tv_sec = (long)last_sec = (long)sec;
+  tv->tv_usec = (last_msec = msec) * 1000;
+
+  if (bt && !bt_last)
+    gettimeofday_calibrate ();
+  bt_last = bt;
+
+  return 0;
+}
+
+#else
+
+#ifdef HAVE_TIME_H
+#include <time.h>
+#endif
+
+int
+gettimeofday (struct timeval *tv, void *tz)
+{
+	(void)tz;
+	tv->tv_sec = time(NULL);
+	tv->tv_usec = 0;
+	return 0;
+}
+
+#endif /* WIN32 */
+
+#endif /* HAVE_GETTIMEOFDAY */
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 57754da..3f9ac31 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -25,6 +25,15 @@
 #ifndef COMPAT_H
 #define COMPAT_H
 
+#ifdef HAVE_WINSOCK2_H
+/* timeval */
+#include <winsock2.h>
+#endif
+
+#ifdef HAVE_SYS_TIME_H
+#include <sys/time.h>
+#endif
+
 #ifndef HAVE_DIRNAME
 char * dirname(char *str);
 #endif /* HAVE_DIRNAME */
@@ -33,4 +42,8 @@ char * dirname(char *str);
 char * basename(char *str);
 #endif /* HAVE_BASENAME */
 
+#ifndef HAVE_GETTIMEOFDAY
+int gettimeofday (struct timeval *tv, void *tz);
+#endif
+
 #endif /* COMPAT_H */
diff --git a/src/compat/compat.vcproj b/src/compat/compat.vcproj
index 1ece749..235163c 100644
--- a/src/compat/compat.vcproj
+++ b/src/compat/compat.vcproj
@@ -158,6 +158,10 @@
 				RelativePath=".\compat-dirname.c"
 				>
 			</File>
+			<File
+				RelativePath=".\compat-gettimeofday.c"
+				>
+			</File>
 		</Filter>
 		<Filter
 			Name="Header Files"
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index e13b81a..57c7846 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1094,7 +1094,7 @@ process_outgoing_link (struct context *c)
 	   * Let the traffic shaper know how many bytes
 	   * we wrote.
 	   */
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
 	  if (c->options.shaper)
 	    shaper_wrote_bytes (&c->c2.shaper, BLEN (&c->c2.to_link)
 				+ datagram_overhead (c->options.ce.proto));
@@ -1383,7 +1383,7 @@ io_wait_dowork (struct context *c, const unsigned int flags)
 	   * quota, don't send -- instead compute the delay we must wait
 	   * until it will be OK to send the packet.
 	   */
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
 	  int delay = 0;
 
 	  /* set traffic shaping delay in microseconds */
@@ -1398,9 +1398,9 @@ io_wait_dowork (struct context *c, const unsigned int flags)
 	    {
 	      shaper_soonest_event (&c->c2.timeval, delay);
 	    }
-#else /* HAVE_GETTIMEOFDAY */
+#else /* ENABLE_FEATURE_SHAPER */
 	  socket |= EVENT_WRITE;
-#endif /* HAVE_GETTIMEOFDAY */
+#endif /* ENABLE_FEATURE_SHAPER */
 	}
       else
 	{
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a07f021..e7edb05 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1180,7 +1180,7 @@ do_init_timers (struct context *c, bool deferred)
 static void
 do_init_traffic_shaper (struct context *c)
 {
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
   /* initialize traffic shaper (i.e. transmit bandwidth limiter) */
   if (c->options.shaper)
     {
@@ -3056,7 +3056,7 @@ do_setup_fast_io (struct context *c)
 	msg (M_INFO, "NOTE: --fast-io is disabled since we are not using UDP");
       else
 	{
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
 	  if (c->options.shaper)
 	    msg (M_INFO, "NOTE: --fast-io is disabled since we are using --shaper");
 	  else
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index f211a1d..898a183 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -720,7 +720,6 @@ openvpn_popen (const struct argv *a,  const struct env_set *es)
 void
 init_random_seed(void)
 {
-#ifdef HAVE_GETTIMEOFDAY
   struct timeval tv;
 
   if (!gettimeofday (&tv, NULL))
@@ -728,10 +727,6 @@ init_random_seed(void)
       const unsigned int seed = (unsigned int) tv.tv_sec ^ tv.tv_usec;
       srandom (seed);
     }
-#else /* HAVE_GETTIMEOFDAY */
-  const time_t current = time (NULL);
-  srandom ((unsigned int)current);
-#endif /* HAVE_GETTIMEOFDAY */
 }
 
 /* thread-safe strerror */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index f4f877b..b314885 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -269,7 +269,7 @@ struct context_2
   struct frame frame_fragment_omit;
 #endif
 
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
   /*
    * Traffic shaper object.
    */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 842f72c..258b060 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1455,7 +1455,7 @@ show_settings (const struct options *o)
   SHOW_INT (ifconfig_ipv6_netbits);
   SHOW_STR (ifconfig_ipv6_remote);
 
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
   SHOW_INT (shaper);
 #endif
 #ifdef ENABLE_OCC
@@ -4833,7 +4833,7 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "shaper") && p[1])
     {
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
       int shaper;
 
       VERIFY_PERMISSION (OPT_P_SHAPER);
@@ -4845,11 +4845,11 @@ add_option (struct options *options,
 	  goto err;
 	}
       options->shaper = shaper;
-#else /* HAVE_GETTIMEOFDAY */
+#else /* ENABLE_FEATURE_SHAPER */
       VERIFY_PERMISSION (OPT_P_GENERAL);
       msg (msglevel, "--shaper requires the gettimeofday() function which is missing");
       goto err;
-#endif /* HAVE_GETTIMEOFDAY */
+#endif /* ENABLE_FEATURE_SHAPER */
     }
   else if (streq (p[0], "port") && p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 4e5b7a4..9e78d00 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -260,7 +260,7 @@ struct options
   const char *ifconfig_ipv6_remote;
   bool ifconfig_noexec;
   bool ifconfig_nowarn;
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
   int shaper;
 #endif
 
@@ -680,7 +680,7 @@ struct options
 #define ROUTE_OPTION_FLAGS(o) (0)
 #endif
 
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
 #define SHAPER_DEFINED(opt) ((opt)->shaper)
 #else
 #define SHAPER_DEFINED(opt) (false)
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 173573c..2c1e5b1 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -36,7 +36,7 @@
 
 time_t now = 0;            /* GLOBAL */
 
-#if TIME_BACKTRACK_PROTECTION && defined(HAVE_GETTIMEOFDAY)
+#if TIME_BACKTRACK_PROTECTION
 
 static time_t now_adj = 0; /* GLOBAL */
 time_t now_usec = 0;       /* GLOBAL */
@@ -76,7 +76,7 @@ update_now_usec (struct timeval *tv)
     now_usec = tv->tv_usec;
 }
 
-#endif /* TIME_BACKTRACK_PROTECTION && defined(HAVE_GETTIMEOFDAY) */
+#endif /* TIME_BACKTRACK_PROTECTION */
 
 /* 
  * Return a numerical string describing a struct timeval.
@@ -120,13 +120,7 @@ time_string (time_t t, int usec, bool show_usec, struct gc_arena *gc)
     }
   else
     {
-#ifdef HAVE_GETTIMEOFDAY
-      if (gettimeofday (&tv, NULL))
-#endif
-	{
-	  tv.tv_sec = time (NULL);
-	  tv.tv_usec = 0;
-	}
+      gettimeofday (&tv, NULL);
     }
 
   t = tv.tv_sec;
@@ -185,78 +179,6 @@ frequency_limit_event_allowed (struct frequency_limit *f)
     return true;
 }
 
-#ifdef WIN32
-
-static time_t gtc_base = 0;
-static DWORD gtc_last = 0;
-static time_t last_sec = 0;
-static unsigned int last_msec = 0;
-static bool bt_last = false;
-
-static void
-gettimeofday_calibrate (void)
-{
-  const time_t t = time(NULL);
-  const DWORD gtc = GetTickCount();
-  gtc_base = t - gtc/1000;
-  gtc_last = gtc;
-}
-
-/*
- * Rewritten by JY for OpenVPN 2.1, after I realized that
- * QueryPerformanceCounter takes nearly 2 orders of magnitude
- * more processor cycles than GetTickCount.
- */
-int
-gettimeofday (struct timeval *tv, void *tz)
-{
-  const DWORD gtc = GetTickCount();
-  bool bt = false;
-  time_t sec;
-  unsigned int msec;
-  const int backtrack_hold_seconds = 10;
-
-  /* recalibrate at the dreaded 49.7 day mark */
-  if (!gtc_base || gtc < gtc_last)
-    gettimeofday_calibrate ();
-  gtc_last = gtc;
-
-  sec = gtc_base + gtc / 1000;
-  msec = gtc % 1000;
-
-  if (sec == last_sec)
-    {
-      if (msec < last_msec)
-	{
-	  msec = last_msec;
-	  bt = true;
-	}
-    }
-  else if (sec < last_sec)
-    {
-      /* We try to dampen out backtracks of less than backtrack_hold_seconds.
-	 Larger backtracks will be passed through and dealt with by the
-	 TIME_BACKTRACK_PROTECTION code (if enabled) */
-      if (sec > last_sec - backtrack_hold_seconds)
-	{
-	  sec = last_sec;
-	  msec = last_msec;
-	}
-      bt = true;
-    }
-
-  tv->tv_sec = last_sec = sec;
-  tv->tv_usec = (last_msec = msec) * 1000;
-
-  if (bt && !bt_last)
-    gettimeofday_calibrate ();
-  bt_last = bt;
-
-  return 0;
-}
-
-#endif /* WIN32 */
-
 #ifdef TIME_TEST
 void
 time_test (void)
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index fd73bbd..4ca1032 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -41,10 +41,6 @@ struct frequency_limit *frequency_limit_init (int max, int per);
 void frequency_limit_free (struct frequency_limit *f);
 bool frequency_limit_event_allowed (struct frequency_limit *f);
 
-#ifdef WIN32
-int gettimeofday(struct timeval *tv, void *tz);
-#endif
-
 /* format a time_t as ascii, or use current time if 0 */
 const char* time_string (time_t t, int usec, bool show_usec, struct gc_arena *gc);
 
@@ -57,7 +53,7 @@ extern time_t now; /* updated frequently to time(NULL) */
 
 void time_test (void);
 
-#if TIME_BACKTRACK_PROTECTION && defined(HAVE_GETTIMEOFDAY)
+#if TIME_BACKTRACK_PROTECTION
 
 void update_now (const time_t system_time);
 
@@ -89,12 +85,13 @@ update_time (void)
 #endif
 }
 
-#else /* !(TIME_BACKTRACK_PROTECTION && defined(HAVE_GETTIMEOFDAY)) */
+#else /* !TIME_BACKTRACK_PROTECTION */
 
 static inline void
 update_time (void)
 {
-#if defined(WIN32) && defined(HAVE_GETTIMEOFDAY)
+#if defined(WIN32)
+  /* on WIN32, gettimeofday is faster than time(NULL) */
   struct timeval tv;
   if (!gettimeofday (&tv, NULL))
     {
@@ -108,17 +105,13 @@ update_time (void)
 #endif
 }
 
-#ifdef HAVE_GETTIMEOFDAY
-
 static inline int
 openvpn_gettimeofday (struct timeval *tv, void *tz)
 {
   return gettimeofday (tv, tz);
 }
 
-#endif
-
-#endif /* TIME_BACKTRACK_PROTECTION && defined(HAVE_GETTIMEOFDAY) */
+#endif /* TIME_BACKTRACK_PROTECTION */
 
 static inline time_t
 openvpn_time (time_t *t)
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index 6b445e2..c8a7d38 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -32,7 +32,7 @@
 #include "shaper.h"
 #include "memdbg.h"
 
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
 
 /*
  * We want to wake up in delay microseconds.  If timeval is larger
@@ -98,4 +98,4 @@ shaper_msg (struct shaper *s)
 
 #else
 static void dummy(void) {}
-#endif /* HAVE_GETTIMEOFDAY */
+#endif /* ENABLE_FEATURE_SHAPER */
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index 4825011..afeb9c3 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -27,7 +27,7 @@
 
 /*#define SHAPER_DEBUG*/
 
-#ifdef HAVE_GETTIMEOFDAY
+#ifdef ENABLE_FEATURE_SHAPER
 
 #include "basic.h"
 #include "integer.h"
@@ -173,6 +173,6 @@ shaper_change_pct (struct shaper *s, int pct)
 }
 #endif
 
-#endif /* HAVE_GETTIMEOFDAY */
+#endif /* ENABLE_FEATURE_SHAPER */
 
 #endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index e8da88c..e60dc44 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -383,6 +383,13 @@
 #endif
 
 /*
+ * Do we have nanoseconds gettimeofday?
+ */
+#if defined(HAVE_GETTIMEOFDAY) || defined(WIN32)
+#define HAVE_GETTIMEOFDAY_NANOSECONDS 1
+#endif
+
+/*
  * Do we have the capability to report extended socket errors?
  */
 #if defined(HAVE_LINUX_TYPES_H) && defined(HAVE_LINUX_ERRQUEUE_H) && defined(HAVE_SOCK_EXTENDED_ERR) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(IP_RECVERR) && defined(MSG_ERRQUEUE) && defined(SOL_IP) && defined(HAVE_IOVEC)
@@ -486,7 +493,7 @@ socket_defined (const socket_descriptor_t sd)
  * Do we have point-to-multipoint capability?
  */
 
-#if defined(ENABLE_CLIENT_SERVER) && defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) && defined(HAVE_GETTIMEOFDAY)
+#if defined(ENABLE_CLIENT_SERVER) && defined(ENABLE_CRYPTO) && defined(ENABLE_SSL) && defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
 #define P2MP 1
 #else
 #define P2MP 0
@@ -667,7 +674,16 @@ socket_defined (const socket_descriptor_t sd)
  * Reduce sensitivity to system clock instability
  * and backtracks.
  */
+#if defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
 #define TIME_BACKTRACK_PROTECTION 1
+#endif
+
+/*
+ * Enable traffic shaper.
+ */
+#if defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
+#define ENABLE_FEATURE_SHAPER 1
+#endif
 
 /*
  * Is non-blocking connect() supported?
-- 
1.7.3.4


