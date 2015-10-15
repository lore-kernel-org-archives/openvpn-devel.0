From: Arne Schwabe <arne@...1227...>
Date: Thu, 15 Oct 2015 16:38:38 +0200
Message-Id: <1444919918-4525-1-git-send-email-arne@...1227...>
References: <1444571266-6598-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH V2] Do not set the buffer size by default
	but rely on the operation system default.
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

Also remove SOCKET_SND_RCV_BUF_MAX since limiting the buffer to 1000k is
arbitrary and all OSes impose a maximum that can be set anyway.

closes trac ticket #461

V2: SOCKET_SND_RCV_BUF_MAX removal
---
 doc/openvpn.8         |  4 ++--
 src/openvpn/options.c |  4 ----
 src/openvpn/socket.c  | 16 +++++-----------
 src/openvpn/socket.h  |  5 -----
 4 files changed, 7 insertions(+), 22 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index b8fb2e5..f305c58 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -1418,12 +1418,12 @@ connection problems) with the following options:
 .TP
 .B \-\-sndbuf size
 Set the TCP/UDP socket send buffer size.
-Currently defaults to 65536 bytes.
+Defaults to operation system default.
 .\"*********************************************************
 .TP
 .B \-\-rcvbuf size
 Set the TCP/UDP socket receive buffer size.
-Currently defaults to 65536 bytes.
+Defaults to operation system default.
 .\"*********************************************************
 .TP
 .B \-\-mark value
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 55db81a..086dcea 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -783,10 +783,6 @@ init_options (struct options *o, const bool init_gc)
 #ifdef ENABLE_FEATURE_TUN_PERSIST
   o->persist_mode = 1;
 #endif
-#ifndef WIN32
-  o->rcvbuf = 65536;
-  o->sndbuf = 65536;
-#endif
 #ifdef TARGET_LINUX
   o->tuntap_options.txqueuelen = 100;
 #endif
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index b4032b8..dd8ea29 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -624,12 +624,9 @@ static void
 socket_set_sndbuf (int sd, int size)
 {
 #if defined(HAVE_SETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_SNDBUF)
-  if (size > 0 && size < SOCKET_SND_RCV_BUF_MAX)
+  if (setsockopt (sd, SOL_SOCKET, SO_SNDBUF, (void *) &size, sizeof (size)) != 0)
     {
-      if (setsockopt (sd, SOL_SOCKET, SO_SNDBUF, (void *) &size, sizeof (size)) != 0)
-	{
-	  msg (M_WARN, "NOTE: setsockopt SO_SNDBUF=%d failed", size);
-	}
+      msg (M_WARN, "NOTE: setsockopt SO_SNDBUF=%d failed", size);
     }
 #endif
 }
@@ -653,13 +650,10 @@ static bool
 socket_set_rcvbuf (int sd, int size)
 {
 #if defined(HAVE_SETSOCKOPT) && defined(SOL_SOCKET) && defined(SO_RCVBUF)
-  if (size > 0 && size < SOCKET_SND_RCV_BUF_MAX)
+  if (setsockopt (sd, SOL_SOCKET, SO_RCVBUF, (void *) &size, sizeof (size)) != 0)
     {
-      if (setsockopt (sd, SOL_SOCKET, SO_RCVBUF, (void *) &size, sizeof (size)) != 0)
-	{
-	  msg (M_WARN, "NOTE: setsockopt SO_RCVBUF=%d failed", size);
-	  return false;
-	}
+      msg (M_WARN, "NOTE: setsockopt SO_RCVBUF=%d failed", size);
+      return false;
     }
   return true;
 #endif
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 30b6ace..da224dd 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -42,11 +42,6 @@
 #define OPENVPN_PORT "1194"
 
 /*
- * Maximum size passed passed to setsockopt SNDBUF/RCVBUF
- */
-#define SOCKET_SND_RCV_BUF_MAX 1000000
-
-/*
  * Number of seconds that "resolv-retry infinite"
  * represents.
  */
-- 
2.3.8 (Apple Git-58)


