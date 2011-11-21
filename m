MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Mon, 21 Nov 2011 16:20:49 +0100
Message-id: <1321888849-7902-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Fix compilation errors on Linux platforms
	without SO_MARK
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

When trying to compile OpenVPN on RHEL5/CentOS5, it would fail
due to missing declaration of SO_MARK.  SO_MARK is a feature which
first arrived in 2.6.26, and was never backported to RHEL5's 2.6.18
kernel base.

This patch adds a check at configure time, to see if SO_MARK is
available or not.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 configure.ac |    3 +++
 options.c    |    6 +++---
 socket.c     |    4 ++--
 3 files changed, 8 insertions(+), 5 deletions(-)

diff --git a/configure.ac b/configure.ac
index a4d68e6..02382a8 100644
--- a/configure.ac
+++ b/configure.ac
@@ -437,6 +437,9 @@ if test "${WIN32}" != "yes"; then
 	 # include <linux/types.h>
 	 #endif
 	])
+
+   dnl Check if SO_MARK is available
+   AC_TRY_COMPILE([#include <sys/socket.h>], [if( SO_MARK > 0) return 1;], [AC_DEFINE(HAVE_SO_MARK,[],[Is SO_MARK available?])])
 fi
 
 AC_CACHE_SAVE
diff --git a/options.c b/options.c
index 0d86cd0..df97c66 100644
--- a/options.c
+++ b/options.c
@@ -292,7 +292,7 @@ static const char usage_message[] =
   "                  or --fragment max value, whichever is lower.\n"
   "--sndbuf size   : Set the TCP/UDP send buffer size.\n"
   "--rcvbuf size   : Set the TCP/UDP receive buffer size.\n"
-#ifdef TARGET_LINUX
+#if defined(TARGET_LINUX) && defined(HAVE_SO_MARK)
   "--mark value    : Mark encrypted packets being sent with value. The mark value\n"
   "                  can be matched in policy routing and packetfilter rules.\n"
 #endif
@@ -1501,7 +1501,7 @@ show_settings (const struct options *o)
 #endif
   SHOW_INT (rcvbuf);
   SHOW_INT (sndbuf);
-#ifdef TARGET_LINUX
+#if defined(TARGET_LINUX) && defined(HAVE_SO_MARK)
   SHOW_INT (mark);
 #endif
   SHOW_INT (sockflags);
@@ -4572,7 +4572,7 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "mark") && p[1])
     {
-#ifdef TARGET_LINUX
+#if defined(TARGET_LINUX) && defined(HAVE_SO_MARK)
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->mark = atoi(p[1]);
 #endif
diff --git a/socket.c b/socket.c
index 5302eca..07a0e1f 100644
--- a/socket.c
+++ b/socket.c
@@ -779,10 +779,10 @@ socket_set_tcp_nodelay (int sd, int state)
 #endif
 }
 
-static void
+static inline void
 socket_set_mark (int sd, int mark)
 {
-#ifdef TARGET_LINUX
+#if defined(TARGET_LINUX) && defined(HAVE_SO_MARK)
   if (mark && setsockopt (sd, SOL_SOCKET, SO_MARK, &mark, sizeof (mark)) != 0)
     msg (M_WARN, "NOTE: setsockopt SO_MARK=%d failed", mark);
 #endif
-- 
1.7.4.4


