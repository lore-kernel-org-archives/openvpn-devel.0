From: Arne Schwabe <arne@...1227...>
Date: Tue,  7 Dec 2021 18:02:02 +0100
Message-Id: <20211207170211.3275837-13-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 12/21] Fix datagram_overhead and assorted
 functions
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

This function is supposed to calculate the overhead of the protocol
header (IP/IPv6 + TCP/UDP). But at some point the index that used
to index the array proto_overhead and the associated PROTO_N went
completely out of sync. This fixed the function and related caller
to again calculate the overhead as intended.

Note that IPv6 mapped IPv4 addresses still have the wrong overhead calculated
as they treated as IPv6 addresses (0:0:0:0:0:ffff::/96)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 10 ++++++----
 src/openvpn/socket.c  | 16 +++-------------
 src/openvpn/socket.h  | 17 ++++++-----------
 3 files changed, 15 insertions(+), 28 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index c971c6bdb..6de6b4d49 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -480,10 +480,10 @@ check_fragment(struct context *c)
     struct link_socket_info *lsi = get_link_socket_info(c);
 
     /* OS MTU Hint? */
-    if (lsi->mtu_changed)
+    if (lsi->mtu_changed && lsi->lsa)
     {
         frame_adjust_path_mtu(&c->c2.frame_fragment, c->c2.link_socket->mtu,
-                              c->options.ce.proto);
+                              lsi->lsa->actual.dest.addr.sa.sa_family, lsi->proto);
         lsi->mtu_changed = false;
     }
 
@@ -1565,8 +1565,10 @@ process_outgoing_link(struct context *c)
              */
             if (c->options.shaper)
             {
-                shaper_wrote_bytes(&c->c2.shaper, BLEN(&c->c2.to_link)
-                                   + datagram_overhead(c->options.ce.proto));
+                int overhead = datagram_overhead(c->c2.to_link_addr->dest.addr.sa.sa_family,
+                                                 c->options.ce.proto);
+                shaper_wrote_bytes(&c->c2.shaper,
+                                   BLEN(&c->c2.to_link) + overhead);
             }
 
             /*
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index df7367469..93d2e61ec 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -44,17 +44,6 @@
 
 #include "memdbg.h"
 
-const int proto_overhead[] = { /* indexed by PROTO_x */
-    0,
-    IPv4_UDP_HEADER_SIZE, /* IPv4 */
-    IPv4_TCP_HEADER_SIZE,
-    IPv4_TCP_HEADER_SIZE,
-    IPv6_UDP_HEADER_SIZE, /* IPv6 */
-    IPv6_TCP_HEADER_SIZE,
-    IPv6_TCP_HEADER_SIZE,
-    IPv6_TCP_HEADER_SIZE,
-};
-
 /*
  * Convert sockflags/getaddr_flags into getaddr_flags
  */
@@ -1660,9 +1649,10 @@ socket_frame_init(const struct frame *frame, struct link_socket *sock)
  * to us by the OS.
  */
 void
-frame_adjust_path_mtu(struct frame *frame, int pmtu, int proto)
+frame_adjust_path_mtu(struct frame *frame, int pmtu, sa_family_t af, int proto)
 {
-    frame_set_mtu_dynamic(frame, pmtu - datagram_overhead(proto), SET_MTU_UPPER_BOUND);
+    frame_set_mtu_dynamic(frame, pmtu - datagram_overhead(af, proto),
+                          SET_MTU_UPPER_BOUND);
 }
 
 static void
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index cc1e0c366..936ef2623 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -300,7 +300,7 @@ void do_preresolve(struct context *c);
 
 void socket_adjust_frame_parameters(struct frame *frame, int proto);
 
-void frame_adjust_path_mtu(struct frame *frame, int pmtu, int proto);
+void frame_adjust_path_mtu(struct frame *frame, int pmtu, sa_family_t af, int proto);
 
 void link_socket_close(struct link_socket *sock);
 
@@ -579,18 +579,13 @@ const char *addr_family_name(int af);
 /*
  * Overhead added to packets by various protocols.
  */
-#define IPv4_UDP_HEADER_SIZE              28
-#define IPv4_TCP_HEADER_SIZE              40
-#define IPv6_UDP_HEADER_SIZE              48
-#define IPv6_TCP_HEADER_SIZE              60
-
-extern const int proto_overhead[];
-
 static inline int
-datagram_overhead(int proto)
+datagram_overhead(sa_family_t af, int proto)
 {
-    ASSERT(proto >= 0 && proto < PROTO_N);
-    return proto_overhead [proto];
+    int overhead = 0;
+    overhead += (proto == PROTO_UDP) ? 8 : 20;
+    overhead += (af == AF_INET) ? 20 : 40;
+    return overhead;
 }
 
 /*
-- 
2.33.0


