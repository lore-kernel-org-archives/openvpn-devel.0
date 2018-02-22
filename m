From: selva.nair@...277...
Date: Wed, 21 Feb 2018 23:33:37 -0500
Message-Id: <1519274017-19921-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH for-2.4] Fix format spec errors in Windows
 builds
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

From: Selva Nair <selva.nair@...277...>

- Correct an instance of %s used for wchar_t * (should be %ls)
  and some %d for DWORD or %lu for int.
- Cast socket descriptor to (int) during i/o as its unsigned int
  or int64 in Windows but signed int in other platforms.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Unlike master, use of %lld for time variables are either absent or
already fixed in 2.4.
Also keeping changes to the minimum required as this is the release
version.

 src/openvpn/route.c  | 12 ++++++------
 src/openvpn/socket.c |  6 +++---
 src/openvpn/tun.c    |  4 ++--
 3 files changed, 11 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ef7c19c..2d6428b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1969,12 +1969,12 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
         struct buffer out = alloc_buf_gc(64, &gc);
         if (r6->adapter_index)          /* vpn server special route */
         {
-            buf_printf(&out, "interface=%d", r6->adapter_index );
+            buf_printf(&out, "interface=%lu", r6->adapter_index );
             gateway_needed = true;
         }
         else
         {
-            buf_printf(&out, "interface=%d", tt->adapter_index );
+            buf_printf(&out, "interface=%lu", tt->adapter_index );
         }
         device = buf_bptr(&out);
 
@@ -2416,12 +2416,12 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
         struct buffer out = alloc_buf_gc(64, &gc);
         if (r6->adapter_index)          /* vpn server special route */
         {
-            buf_printf(&out, "interface=%d", r6->adapter_index );
+            buf_printf(&out, "interface=%lu", r6->adapter_index );
             gateway_needed = true;
         }
         else
         {
-            buf_printf(&out, "interface=%d", tt->adapter_index );
+            buf_printf(&out, "interface=%lu", tt->adapter_index );
         }
         device = buf_bptr(&out);
 
@@ -2841,7 +2841,7 @@ get_default_gateway_ipv6(struct route_ipv6_gateway_info *rgi6,
         goto done;
     }
 
-    msg( D_ROUTE, "GDG6: II=%d DP=%s/%d NH=%s",
+    msg( D_ROUTE, "GDG6: II=%lu DP=%s/%d NH=%s",
          BestRoute.InterfaceIndex,
          print_in6_addr( BestRoute.DestinationPrefix.Prefix.Ipv6.sin6_addr, 0, &gc),
          BestRoute.DestinationPrefix.PrefixLength,
@@ -3002,7 +3002,7 @@ do_route_service(const bool add, const route_message_t *rt, const size_t size, H
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%lu]",
+        msg(M_WARN, "ROUTE: route %s failed using service: %s [status=%u if_index=%d]",
             (add ? "addition" : "deletion"), strerror_win32(ack.error_number, &gc),
             ack.error_number, rt->iface.index);
         goto out;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8445daa..211e744 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1122,7 +1122,7 @@ socket_do_accept(socket_descriptor_t sd,
 
     if (!socket_defined(new_sd))
     {
-        msg(D_LINK_ERRORS | M_ERRNO, "TCP: accept(%d) failed", sd);
+        msg(D_LINK_ERRORS | M_ERRNO, "TCP: accept(%d) failed", (int)sd);
     }
     /* only valid if we have remote_len_af!=0 */
     else if (remote_len_af && remote_len != remote_len_af)
@@ -1875,12 +1875,12 @@ phase2_inetd(struct link_socket *sock, const struct frame *frame,
                 sock->info.lsa->actual.dest.addr.sa.sa_family = local_addr.addr.sa.sa_family;
                 dmsg(D_SOCKET_DEBUG, "inetd(%s): using sa_family=%d from getsockname(%d)",
                      proto2ascii(sock->info.proto, sock->info.af, false),
-                     local_addr.addr.sa.sa_family, sock->sd);
+                     local_addr.addr.sa.sa_family, (int)sock->sd);
             }
             else
             {
                 msg(M_WARN, "inetd(%s): getsockname(%d) failed, using AF_INET",
-                    proto2ascii(sock->info.proto, sock->info.af, false), sock->sd);
+                    proto2ascii(sock->info.proto, sock->info.af, false), (int)sock->sd);
             }
         }
 #else  /* ifdef HAVE_GETSOCKNAME */
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 7945366..b071823 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -125,7 +125,7 @@ do_address_service(const bool add, const short family, const struct tuntap *tt)
 
     if (ack.error_number != NO_ERROR)
     {
-        msg(M_WARN, "TUN: %s address failed using service: %s [status=%u if_index=%lu]",
+        msg(M_WARN, "TUN: %s address failed using service: %s [status=%u if_index=%d]",
             (add ? "adding" : "deleting"), strerror_win32(ack.error_number, &gc),
             ack.error_number, addr.iface.index);
         goto out;
@@ -3792,7 +3792,7 @@ get_panel_reg(struct gc_arena *gc)
 
             if (status != ERROR_SUCCESS || name_type != REG_SZ)
             {
-                dmsg(D_REGISTRY, "Error opening registry key: %s\\%s\\%s",
+                dmsg(D_REGISTRY, "Error opening registry key: %s\\%s\\%ls",
                      NETWORK_CONNECTIONS_KEY, connection_string, name_string);
             }
             else
-- 
2.1.4


