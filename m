From: Arne Schwabe <arne@...1227...>
Date: Thu, 21 Nov 2013 21:08:14 +0100
Message-Id: <1385064495-25877-13-git-send-email-arne@...1227...>
In-Reply-To: <1385064495-25877-1-git-send-email-arne@...1227...>
References: <1385064495-25877-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 13/14] Fix connecting to localhost on Android
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

Do not protect the link socket when connecting to localhost
---
 src/openvpn/socket.c |   21 ++++++++++++++++++---
 src/openvpn/socket.h |   17 +++++++++++++++++
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 4fd00db..c904f94 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -691,16 +691,24 @@ create_socket (struct link_socket *sock)
     /* set socket to --mark packets with given value */
     socket_set_mark (sock->sd, sock->mark);
     
+}
+
 #ifdef TARGET_ANDROID
+static void protect_fd_nonlocal (int fd, const struct sockaddr* addr)
+{
   /* pass socket FD to management interface to pass on to VPNService API
    * as "protected socket" (exempt from being routed into tunnel)
    */
+  if (addr_local (addr)) {
+    msg(M_DEBUG, "Address is local, not protecting socket fd %d", fd);
+    return;
+  }
 
-  management->connection.fdtosend = sock->sd;
+  msg(M_DEBUG, "Protecting socket fd %d", fd);
+  management->connection.fdtosend = fd;
   management_android_control (management, "PROTECTFD", __func__);
-#endif
-
 }
+#endif
 
 /*
  * Functions used for establishing a TCP stream connection.
@@ -934,6 +942,10 @@ openvpn_connect (socket_descriptor_t sd,
 {
   int status = 0;
 
+#ifdef TARGET_ANDROID
+  protect_fd_nonlocal(sd, remote);
+#endif
+
 #ifdef CONNECT_NONBLOCK
   set_nonblock (sd);
   status = connect (sd, remote, af_addr_size(remote->sa_family));
@@ -1791,6 +1803,9 @@ link_socket_init_phase2 (struct link_socket *sock,
 	  phase2_socks_client (sock, sig_info);
 #endif
 	}
+#ifdef TARGET_ANDROID
+      protect_fd_nonlocal (sock->sd, &sock->info.lsa->actual.dest.addr.sa);
+#endif
       if (sig_info && sig_info->signal_received)
 	goto done;
     }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 75f2fa5..4c18b74 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -598,6 +598,23 @@ addr_defined (const struct openvpn_sockaddr *addr)
     default: return 0;
   }
 }
+
+static inline bool
+addr_local (const struct sockaddr *addr)
+{
+    if (!addr)
+	return false;
+    switch (addr->sa_family) {
+	case AF_INET:
+	    return ((const struct sockaddr_in*)addr)->sin_addr.s_addr == htonl(INADDR_LOOPBACK);
+	case AF_INET6:
+	    return  IN6_IS_ADDR_LOOPBACK(&((const struct sockaddr_in6*)addr)->sin6_addr);
+	default:
+	    return false;
+    }
+}
+
+
 static inline bool
 addr_defined_ipi (const struct link_socket_actual *lsa)
 {
-- 
1.7.9.5


