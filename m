From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jan 2022 17:25:30 +0100
Message-Id: <20220101162532.2251835-13-arne@...1227...>
In-Reply-To: <20220101162532.2251835-1-arne@...1227...>
References: <20220101162532.2251835-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 12/14] Replace TUN_MTU_SIZE with
 frame->tun_mtu
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

This always uses the configured MTU size instead relying on the calculated
MTU size.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c |  2 +-
 src/openvpn/init.c    | 16 ++++++++--------
 src/openvpn/mtu.h     |  5 -----
 3 files changed, 9 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 3f362e95..5f8361d3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1379,7 +1379,7 @@ ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, bool client)
      * packet
      */
     int max_payload_size = min_int(MAX_ICMPV6LEN,
-                                   TUN_MTU_SIZE(&c->c2.frame) - icmpheader_len);
+                                   c->c2.frame.tun_mtu - icmpheader_len);
     int payload_len = min_int(max_payload_size, BLEN(&inputipbuf));
 
     pip6out.payload_len = htons(sizeof(struct openvpn_icmp6hdr) + payload_len);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index bf6369f8..4e81016b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1799,7 +1799,7 @@ do_open_tun(struct context *c)
                                              c->options.dev_type,
                                              c->options.dev_node,
                                              &gc);
-        do_ifconfig(c->c1.tuntap, guess, TUN_MTU_SIZE(&c->c2.frame), c->c2.es,
+        do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
                     &c->net_ctx);
     }
 
@@ -1830,7 +1830,7 @@ do_open_tun(struct context *c)
         && ifconfig_order() == IFCONFIG_AFTER_TUN_OPEN)
     {
         do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
-                    TUN_MTU_SIZE(&c->c2.frame), c->c2.es, &c->net_ctx);
+                    c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
     }
 
     /* run the up script */
@@ -1842,7 +1842,7 @@ do_open_tun(struct context *c)
                 c->c1.tuntap->adapter_index,
 #endif
                 dev_type_string(c->options.dev, c->options.dev_type),
-                TUN_MTU_SIZE(&c->c2.frame),
+                c->c2.frame.tun_mtu,
                 print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
                 print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                 "init",
@@ -1891,7 +1891,7 @@ else
                     c->c1.tuntap->adapter_index,
 #endif
                     dev_type_string(c->options.dev, c->options.dev_type),
-                    TUN_MTU_SIZE(&c->c2.frame),
+                    c->c2.frame.tun_mtu,
                     print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
                     print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                     "restart",
@@ -1970,7 +1970,7 @@ do_close_tun(struct context *c, bool force)
                             adapter_index,
 #endif
                             NULL,
-                            TUN_MTU_SIZE(&c->c2.frame),
+                            c->c2.frame.tun_mtu,
                             print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
                             print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                             "init",
@@ -2000,7 +2000,7 @@ do_close_tun(struct context *c, bool force)
                         adapter_index,
 #endif
                         NULL,
-                        TUN_MTU_SIZE(&c->c2.frame),
+                        c->c2.frame.tun_mtu,
                         print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
                         print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                         "init",
@@ -2038,7 +2038,7 @@ do_close_tun(struct context *c, bool force)
                             adapter_index,
 #endif
                             NULL,
-                            TUN_MTU_SIZE(&c->c2.frame),
+                            c->c2.frame.tun_mtu,
                             print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
                             print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                             "restart",
@@ -2218,7 +2218,7 @@ void adjust_mtu_peerid(struct context *c)
     {
         msg(M_WARN, "OPTIONS IMPORT: WARNING: peer-id set, but link-mtu"
                     " fixed by config - reducing tun-mtu to %d, expect"
-                    " MTU problems", TUN_MTU_SIZE(&c->c2.frame));
+                    " MTU problems", c->c2.frame.tun_mtu);
     }
 }
 
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index a87adbc4..c6eca864 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -181,11 +181,6 @@ struct options;
  */
 #define TUN_LINK_DELTA(f)        ((f)->extra_frame + (f)->extra_tun)
 
-/*
- * This is the size to "ifconfig" the tun or tap device.
- */
-#define TUN_MTU_SIZE(f)          ((f)->link_mtu - TUN_LINK_DELTA(f))
-
 /*
  * This is the maximum packet size that we need to be able to
  * read from or write to a tun or tap device.  For example,
-- 
2.33.0


