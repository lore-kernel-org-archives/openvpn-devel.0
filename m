From: Arne Schwabe <arne@...1227...>
Date: Sat, 10 Oct 2015 11:44:51 +0200
Message-Id: <1444470291-2980-1-git-send-email-arne@...1227...>
In-Reply-To: <1406654929-6079-1-git-send-email-jm@...1926...>
References: <1406654929-6079-1-git-send-email-jm@...1926...>
Subject: [Openvpn-devel] [[Patch V2]] Fix --mtu-disc option with IPv6
	transport
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

From: Julien Muchembled <jm@...1926...>

Socket configuration of MTU discovery was done unconditionally at IP level,
which has no effect for other protocols. This fixes the issue of OpenVPN
sending fragmented tcp6/udp6 packets even when 'mtu-disc yes' option is passed.

Patch V2 (by Arne Schwabe): Rebase to current master and have separate #ifdefs for IPv4 an IPv6

Signed-off-by: Julien Muchembled <jm@...1926...>
---
 src/openvpn/mtu.c    | 29 ++++++++++++++++++++++-------
 src/openvpn/mtu.h    |  2 +-
 src/openvpn/socket.c |  2 +-
 3 files changed, 24 insertions(+), 9 deletions(-)

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 3665a34..24531c9 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -153,17 +153,32 @@ frame_print (const struct frame *frame,
 #define MTUDISC_NOT_SUPPORTED_MSG "--mtu-disc is not supported on this OS"
 
 void
-set_mtu_discover_type (int sd, int mtu_type)
+set_mtu_discover_type (int sd, int mtu_type, sa_family_t proto_af)
 {
   if (mtu_type >= 0)
     {
-#if defined(HAVE_SETSOCKOPT) && defined(SOL_IP) && defined(IP_MTU_DISCOVER)
-      if (setsockopt (sd, SOL_IP, IP_MTU_DISCOVER, (void *) &mtu_type, sizeof (mtu_type)))
-	msg (M_ERR, "Error setting IP_MTU_DISCOVER type=%d on TCP/UDP socket",
-	     mtu_type);
-#else
-      msg (M_FATAL, MTUDISC_NOT_SUPPORTED_MSG);
+      switch (proto_af)
+	{
+#if defined(HAVE_SETSOCKOPT) && defined(IP_MTU_DISCOVER)
+	case AF_INET:
+	  if (setsockopt
+	      (sd, IPPROTO_IP, IP_MTU_DISCOVER, &mtu_type, sizeof (mtu_type)))
+	    msg (M_ERR, "Error setting IP_MTU_DISCOVER type=%d on TCP/UDP socket",
+		 mtu_type);
+	  break;
+#endif
+#if defined(HAVE_SETSOCKOPT) && defined(IPV6_MTU_DISCOVER)
+	case AF_INET6:
+	  if (setsockopt
+	      (sd, IPPROTO_IPV6, IPV6_MTU_DISCOVER, &mtu_type, sizeof (mtu_type)))
+	    msg (M_ERR, "Error setting IPV6_MTU_DISCOVER type=%d on TCP6/UDP6 socket",
+		 mtu_type);
+	  break;
 #endif
+	default:
+	  msg (M_FATAL, MTUDISC_NOT_SUPPORTED_MSG);
+	  break;
+	}
     }
 }
 
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index bccd681..f94de89 100644
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
index bd8dcb1..925665c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1676,7 +1676,7 @@ phase2_set_socket_flags (struct link_socket* sock)
     set_cloexec (sock->ctrl_sd);
 
   /* set Path MTU discovery options on the socket */
-  set_mtu_discover_type (sock->sd, sock->mtu_discover_type);
+  set_mtu_discover_type (sock->sd, sock->mtu_discover_type, sock->info.af);
 
 #if EXTENDED_SOCKET_ERROR_CAPABILITY
   /* if the OS supports it, enable extended error passing on the socket */
-- 
1.9.5 (Apple Git-50.3)


