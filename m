From: Julien Muchembled <jm@...1926...>
Date: Tue, 29 Jul 2014 19:28:49 +0200
Message-Id: <1406654929-6079-1-git-send-email-jm@...1926...>
Subject: [Openvpn-devel] [PATCH] Fix --mtu-disc option with IPv6 transport
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

Socket configuration of MTU discovery was done unconditionally at IP level,
which has no effect for other protocols. This fixes the issue of OpenVPN
sending fragmented tcp6/udp6 packets even when 'mtu-disc yes' option is passed.

Signed-off-by: Julien Muchembled <jm@...1926...>
---
 src/openvpn/mtu.c    | 23 +++++++++++++++++------
 src/openvpn/mtu.h    |  2 +-
 src/openvpn/socket.c |  2 +-
 3 files changed, 19 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 13f3f6c..426c487 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -153,15 +153,26 @@ frame_print (const struct frame *frame,
 #define MTUDISC_NOT_SUPPORTED_MSG "--mtu-disc is not supported on this OS"
 
 void
-set_mtu_discover_type (int sd, int mtu_type)
+set_mtu_discover_type (int sd, int mtu_type, sa_family_t proto_af)
 {
   if (mtu_type >= 0)
     {
-#if defined(HAVE_SETSOCKOPT) && defined(SOL_IP) && defined(IP_MTU_DISCOVER)
-      if (setsockopt
-	  (sd, SOL_IP, IP_MTU_DISCOVER, &mtu_type, sizeof (mtu_type)))
-	msg (M_ERR, "Error setting IP_MTU_DISCOVER type=%d on TCP/UDP socket",
-	     mtu_type);
+#if defined(HAVE_SETSOCKOPT) && defined(IP_MTU_DISCOVER) && defined(IPV6_MTU_DISCOVER)
+      switch (proto_af)
+	{
+	case AF_INET:
+	  if (setsockopt
+	      (sd, IPPROTO_IP, IP_MTU_DISCOVER, &mtu_type, sizeof (mtu_type)))
+	    msg (M_ERR, "Error setting IP_MTU_DISCOVER type=%d on TCP/UDP socket",
+		 mtu_type);
+	  break;
+	case AF_INET6:
+	  if (setsockopt
+	      (sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER, &mtu_type, sizeof (mtu_type)))
+	    msg (M_ERR, "Error setting IPV6_MTU_DISCOVER type=%d on TCP6/UDP6 socket",
+		 mtu_type);
+	  break;
+	}
 #else
       msg (M_FATAL, MTUDISC_NOT_SUPPORTED_MSG);
 #endif
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 29ec21f..cb41dc6 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -207,7 +207,7 @@ void frame_print (const struct frame *frame,
 		  int level,
 		  const char *prefix);
 
-void set_mtu_discover_type (int sd, int mtu_type);
+void set_mtu_discover_type (int sd, int mtu_type, sa_family_t proto_af);
 int translate_mtu_discover_type_name (const char *name);
 
 /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 9e6bd10..344a9f7 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1685,7 +1685,7 @@ phase2_set_socket_flags (struct link_socket* sock)
     set_cloexec (sock->ctrl_sd);
 
   /* set Path MTU discovery options on the socket */
-  set_mtu_discover_type (sock->sd, sock->mtu_discover_type);
+  set_mtu_discover_type (sock->sd, sock->mtu_discover_type, sock->info.af);
 
 #if EXTENDED_SOCKET_ERROR_CAPABILITY
   /* if the OS supports it, enable extended error passing on the socket */
-- 
1.8.5.2.988.g9b015e5.dirty


