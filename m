From: Arne Schwabe <arne@...1227...>
Date: Thu, 10 Feb 2022 17:26:25 +0100
Message-Id: <20220210162632.3309974-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4 1/8] Replace TUN_MTU_SIZE with
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

Patch v4: Fix a few overlooked TUN_MTU_SIZE.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c |  2 +-
 src/openvpn/init.c    | 20 ++++++++++----------
 src/openvpn/mtu.c     |  4 ++--
 src/openvpn/mtu.h     |  5 -----
 4 files changed, 13 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index af041179..dcc430d4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1381,7 +1381,7 @@ ipv6_send_icmp_unreachable(struct context *c, struct buffer *buf, bool client)
      * packet
      */
     int max_payload_size = min_int(MAX_ICMPV6LEN,
-                                   TUN_MTU_SIZE(&c->c2.frame) - icmpheader_len);
+                                   c->c2.frame.tun_mtu - icmpheader_len);
     int payload_len = min_int(max_payload_size, BLEN(&inputipbuf));
 
     pip6out.payload_len = htons(sizeof(struct openvpn_icmp6hdr) + payload_len);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 8e1e43cb..4c799f19 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1735,7 +1735,7 @@ do_open_tun(struct context *c)
                                              c->options.dev_type,
                                              c->options.dev_node,
                                              &gc);
-        do_ifconfig(c->c1.tuntap, guess, TUN_MTU_SIZE(&c->c2.frame), c->c2.es,
+        do_ifconfig(c->c1.tuntap, guess, c->c2.frame.tun_mtu, c->c2.es,
                     &c->net_ctx);
     }
 
@@ -1766,7 +1766,7 @@ do_open_tun(struct context *c)
         && ifconfig_order() == IFCONFIG_AFTER_TUN_OPEN)
     {
         do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
-                    TUN_MTU_SIZE(&c->c2.frame), c->c2.es, &c->net_ctx);
+                    c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
     }
 
     /* run the up script */
@@ -1778,7 +1778,7 @@ do_open_tun(struct context *c)
                 c->c1.tuntap->adapter_index,
 #endif
                 dev_type_string(c->options.dev, c->options.dev_type),
-                TUN_MTU_SIZE(&c->c2.frame),
+                c->c2.frame.tun_mtu,
                 print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
                 print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                 "init",
@@ -1827,7 +1827,7 @@ else
                     c->c1.tuntap->adapter_index,
 #endif
                     dev_type_string(c->options.dev, c->options.dev_type),
-                    TUN_MTU_SIZE(&c->c2.frame),
+                    c->c2.frame.tun_mtu,
                     print_in_addr_t(c->c1.tuntap->local, IA_EMPTY_IF_UNDEF, &gc),
                     print_in_addr_t(c->c1.tuntap->remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                     "restart",
@@ -1906,7 +1906,7 @@ do_close_tun(struct context *c, bool force)
                             adapter_index,
 #endif
                             NULL,
-                            TUN_MTU_SIZE(&c->c2.frame),
+                            c->c2.frame.tun_mtu,
                             print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
                             print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                             "init",
@@ -1936,7 +1936,7 @@ do_close_tun(struct context *c, bool force)
                         adapter_index,
 #endif
                         NULL,
-                        TUN_MTU_SIZE(&c->c2.frame),
+                        c->c2.frame.tun_mtu,
                         print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
                         print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                         "init",
@@ -1974,7 +1974,7 @@ do_close_tun(struct context *c, bool force)
                             adapter_index,
 #endif
                             NULL,
-                            TUN_MTU_SIZE(&c->c2.frame),
+                            c->c2.frame.tun_mtu,
                             print_in_addr_t(local, IA_EMPTY_IF_UNDEF, &gc),
                             print_in_addr_t(remote_netmask, IA_EMPTY_IF_UNDEF, &gc),
                             "restart",
@@ -2154,7 +2154,7 @@ void adjust_mtu_peerid(struct context *c)
     {
         msg(M_WARN, "OPTIONS IMPORT: WARNING: peer-id set, but link-mtu"
                     " fixed by config - reducing tun-mtu to %d, expect"
-                    " MTU problems", TUN_MTU_SIZE(&c->c2.frame));
+                    " MTU problems", c->c2.frame.tun_mtu);
     }
 }
 
@@ -3185,11 +3185,11 @@ do_init_frame(struct context *c)
 
 #ifdef ENABLE_FRAGMENT
     if ((c->options.ce.mssfix || c->options.ce.fragment)
-        && TUN_MTU_SIZE(&c->c2.frame_fragment) != ETHERNET_MTU)
+        && c->c2.frame.tun_mtu != ETHERNET_MTU)
     {
         msg(M_WARN,
             "WARNING: normally if you use --mssfix and/or --fragment, you should also set --tun-mtu %d (currently it is %d)",
-            ETHERNET_MTU, TUN_MTU_SIZE(&c->c2.frame_fragment));
+            ETHERNET_MTU, c->c2.frame.tun_mtu);
     }
 #endif
 }
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index d014d2b8..783fcc5f 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -229,9 +229,9 @@ frame_finalize(struct frame *frame,
         frame->link_mtu = link_mtu;
     }
 
-    if (TUN_MTU_SIZE(frame) < TUN_MTU_MIN)
+    if (frame->tun_mtu < TUN_MTU_MIN)
     {
-        msg(M_WARN, "TUN MTU value (%d) must be at least %d", TUN_MTU_SIZE(frame), TUN_MTU_MIN);
+        msg(M_WARN, "TUN MTU value (%d) must be at least %d", frame->tun_mtu, TUN_MTU_MIN);
         frame_print(frame, M_FATAL, "MTU is too small");
     }
 
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index ef8ac4ab..7a6cdcb4 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -184,11 +184,6 @@ struct options;
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


