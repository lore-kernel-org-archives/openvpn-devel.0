From: Gert Doering <gert@...1296...>
Date: Tue,  7 Jun 2022 11:36:19 +0200
Message-Id: <20220607093619.23066-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix error message about extended errors for
 IPv4-only sockets.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

The new code to enable IPv6 extended error reporting will cause
an error ("Protocol not available (errno=92)") if trying to enable
that setsockopt() option on an IPv4-only socket.

Fix: pass sock->info.af to set_sock_extended_error_passing(), only
apply to AF_INET6 sockets.

Add comments to make explicit that the asymmetry here (IPv4 extended
socket error reporting is enabled on all sockets) is intentional.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/mtu.c    | 13 +++++++++----
 src/openvpn/mtu.h    |  2 +-
 src/openvpn/socket.c |  2 +-
 3 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 59b91798..f60f4853 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -413,17 +413,22 @@ exit:
 }
 
 void
-set_sock_extended_error_passing(int sd)
+set_sock_extended_error_passing(int sd, sa_family_t proto_af)
 {
     int on = 1;
-    /* see "man 7 ip" (on Linux) */
+    /* see "man 7 ip" (on Linux)
+     * this works on IPv4 and IPv6(-dual-stack) sockets (v4-mapped)
+     */
     if (setsockopt(sd, SOL_IP, IP_RECVERR, (void *) &on, sizeof(on)) != 0)
     {
         msg(M_WARN | M_ERRNO,
             "Note: enable extended error passing on TCP/UDP socket failed (IP_RECVERR)");
     }
-    /* see "man 7 ipv6" (on Linux) */
-    if (setsockopt(sd, IPPROTO_IPV6, IPV6_RECVERR, (void *) &on, sizeof(on)) != 0)
+    /* see "man 7 ipv6" (on Linux)
+     * this only works on IPv6 sockets
+     */
+    if (proto_af == AF_INET6
+        && setsockopt(sd, IPPROTO_IPV6, IPV6_RECVERR, (void *) &on, sizeof(on)) != 0)
     {
         msg(M_WARN | M_ERRNO,
             "Note: enable extended error passing on TCP/UDP socket failed (IPV6_RECVERR)");
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 7f967e06..ac3268f7 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -278,7 +278,7 @@ void alloc_buf_sock_tun(struct buffer *buf,
 
 #if EXTENDED_SOCKET_ERROR_CAPABILITY
 
-void set_sock_extended_error_passing(int sd);
+void set_sock_extended_error_passing(int sd, sa_family_t proto_af);
 
 const char *format_extended_socket_error(int fd, int *mtu, struct gc_arena *gc);
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 4e4a3a2f..47f1ba27 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1949,7 +1949,7 @@ phase2_set_socket_flags(struct link_socket *sock)
 
 #if EXTENDED_SOCKET_ERROR_CAPABILITY
     /* if the OS supports it, enable extended error passing on the socket */
-    set_sock_extended_error_passing(sock->sd);
+    set_sock_extended_error_passing(sock->sd, sock->info.af);
 #endif
 }
 
-- 
2.35.1


