From: Arne Schwabe <arne@...1227...>
Date: Wed,  9 Nov 2022 12:07:49 +0100
Message-Id: <20221109110749.1245175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove unused addr_inet4or6,
 addr_guess_family and inline addr_copy_sa
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

addr_copy_sa is just a single line and putting that simple assignment
into an extra function does not really improve clarity.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/socket.h | 18 ++----------------
 1 file changed, 2 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 462afa31b..94c8b6dff 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -863,20 +863,6 @@ addr_zero_host(struct openvpn_sockaddr *addr)
     }
 }
 
-static inline void
-addr_copy_sa(struct openvpn_sockaddr *dst, const struct openvpn_sockaddr *src)
-{
-    dst->addr = src->addr;
-}
-
-static inline bool
-addr_inet4or6(struct sockaddr *addr)
-{
-    return addr->sa_family == AF_INET || addr->sa_family == AF_INET6;
-}
-
-int addr_guess_family(sa_family_t af, const char *name);
-
 static inline int
 af_addr_size(sa_family_t af)
 {
@@ -1052,7 +1038,7 @@ link_socket_read_udp_win32(struct link_socket *sock,
     sockethandle_t sh = { .s = sock->sd };
     if (sock->info.dco_installed)
     {
-        addr_copy_sa(&from->dest, &sock->info.lsa->actual.dest);
+        from->dest = sock->info.lsa->actual.dest;
         sh.is_handle = true;
     }
     return sockethandle_finalize(sh, &sock->reads, buf, from);
@@ -1089,7 +1075,7 @@ link_socket_read(struct link_socket *sock,
     else if (proto_is_tcp(sock->info.proto)) /* unified TCPv4 and TCPv6 */
     {
         /* from address was returned by accept */
-        addr_copy_sa(&from->dest, &sock->info.lsa->actual.dest);
+        from->dest = sock->info.lsa->actual.dest;
         return link_socket_read_tcp(sock, buf);
     }
     else
-- 
2.37.0 (Apple Git-136)


