From: Arne Schwabe <arne@...1227...>
Date: Tue, 14 Dec 2021 16:09:01 +0100
Message-Id: <20211214150901.4118886-1-arne@...1227...>
In-Reply-To: <20211207170211.3275837-1-arne@...1227...>
References: <20211207170211.3275837-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 08/21] Decouple MSS fix calculation from
 frame calculation
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

This consolidates the MSS fix calculation into a single function
instead having it distributed all over the code. It also calculates
the real wire overhead without extra sizes for buffer etc.

Patch v2: improve comment

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c |  5 ++---
 src/openvpn/init.c    |  3 ++-
 src/openvpn/mss.c     | 40 ++++++++++++++++++++++++++++++++++++++++
 src/openvpn/mss.h     |  6 ++++++
 src/openvpn/mtu.c     |  9 ---------
 src/openvpn/mtu.h     | 10 ++++++----
 src/openvpn/proto.h   | 11 -----------
 src/openvpn/ssl.c     |  3 ++-
 8 files changed, 58 insertions(+), 29 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 29efcd3b9..f82386a1d 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1493,7 +1493,7 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
                 /* possibly alter the TCP MSS */
                 if (flags & PIP_MSSFIX)
                 {
-                    mss_fixup_ipv4(&ipbuf, MTU_TO_MSS(TUN_MTU_SIZE_DYNAMIC(&c->c2.frame)));
+                    mss_fixup_ipv4(&ipbuf, c->c2.frame.mss_fix);
                 }
 
                 /* possibly do NAT on packet */
@@ -1517,8 +1517,7 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
                 /* possibly alter the TCP MSS */
                 if (flags & PIP_MSSFIX)
                 {
-                    mss_fixup_ipv6(&ipbuf,
-                                   MTU_TO_MSS(TUN_MTU_SIZE_DYNAMIC(&c->c2.frame)));
+                    mss_fixup_ipv6(&ipbuf, c->c2.frame.mss_fix);
                 }
                 if (!(flags & PIP_OUTGOING) && (flags
                                                 &(PIPV6_IMCP_NOHOST_CLIENT | PIPV6_IMCP_NOHOST_SERVER)))
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index eb2678116..462edc01e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -53,6 +53,7 @@
 #include "tls_crypt.h"
 #include "forward.h"
 #include "auth_token.h"
+#include "mss.h"
 
 #include "memdbg.h"
 
@@ -4156,7 +4157,7 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
 #endif
 
     /* initialize dynamic MTU variable */
-    frame_init_mssfix(&c->c2.frame, &c->options);
+    frame_calculate_mssfix(&c->c2.frame, &c->c1.ks.key_type, &c->options);
 
     /* bind the TCP/UDP socket */
     if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index aa5b68ce9..d2842aac5 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -30,6 +30,8 @@
 #include "syshead.h"
 #include "error.h"
 #include "mss.h"
+#include "crypto.h"
+#include "ssl_common.h"
 #include "memdbg.h"
 
 /*
@@ -204,3 +206,41 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
         }
     }
 }
+
+void
+frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
+                       const struct options *options)
+{
+    if (options->ce.mssfix == 0)
+    {
+        return;
+    }
+
+    unsigned int payload_size;
+    unsigned int overhead;
+
+
+    payload_size = frame_calculate_payload_size(frame, options);
+
+    overhead = frame_calculate_protocol_header_size(kt, options,
+                                                    payload_size, false);
+
+    /* Calculate the number of bytes that the payload differs from the payload
+     * MTU. This are fragment/compression/ethernet headers */
+    unsigned payload_overhead = frame_calculate_payload_overhead(frame, options, true);
+
+    /* We are in a "liberal" position with respect to MSS,
+     * i.e. we assume that MSS can be calculated from MTU
+     * by subtracting out only the IP and TCP header sizes
+     * without options.
+     *
+     * (RFC 879, section 7). */
+
+    /* Add 20 bytes for the IPv4 header and 20 byte for the TCP header of the
+     * payload, the mssfix method will add 20 extra if payload is IPv6 */
+    overhead += 20 + 20;
+
+    /* Calculate the maximum MSS value from the max link layer size specified
+     * by ce.mssfix */
+    frame->mss_fix = options->ce.mssfix - overhead - payload_overhead;
+}
\ No newline at end of file
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 41254e2a6..856f4c4e3 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -26,6 +26,8 @@
 
 #include "proto.h"
 #include "error.h"
+#include "mtu.h"
+#include "ssl_common.h"
 
 void mss_fixup_ipv4(struct buffer *buf, int maxmss);
 
@@ -33,4 +35,8 @@ void mss_fixup_ipv6(struct buffer *buf, int maxmss);
 
 void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);
 
+/** Set the --mssfix option. */
+void frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
+                            const struct options *options);
+
 #endif
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 0da1dadfa..7e5c3c24d 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -211,15 +211,6 @@ frame_subtract_extra(struct frame *frame, const struct frame *src)
     frame->extra_tun   += src->extra_frame;
 }
 
-void
-frame_init_mssfix(struct frame *frame, const struct options *options)
-{
-    if (options->ce.mssfix)
-    {
-        frame_set_mtu_dynamic(frame, options->ce.mssfix, SET_MTU_UPPER_BOUND);
-    }
-}
-
 void
 frame_print(const struct frame *frame,
             int level,
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 5ad0931fd..ae83d3e7a 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -94,6 +94,12 @@ struct frame {
     int link_mtu;               /**< Maximum packet size to be sent over
                                  *   the external network interface. */
 
+    unsigned int mss_fix;      /**< The actual MSS value that should be
+                                 *   written to the payload packets. This
+                                 *   is the value for IPv4 TCP packets. For
+                                 *   IPv6 packets another 20 bytes must
+                                 *   be subtracted */
+
     int link_mtu_dynamic;       /**< Dynamic MTU value for the external
                                  *   network interface. */
 
@@ -152,7 +158,6 @@ struct options;
  * This is the size to "ifconfig" the tun or tap device.
  */
 #define TUN_MTU_SIZE(f)          ((f)->link_mtu - TUN_LINK_DELTA(f))
-#define TUN_MTU_SIZE_DYNAMIC(f)  ((f)->link_mtu_dynamic - TUN_LINK_DELTA(f))
 
 /*
  * This is the maximum packet size that we need to be able to
@@ -291,9 +296,6 @@ void alloc_buf_sock_tun(struct buffer *buf,
                         const struct frame *frame,
                         const bool tuntap_buffer);
 
-/** Set the --mssfix option. */
-void frame_init_mssfix(struct frame *frame, const struct options *options);
-
 /*
  * EXTENDED_SOCKET_ERROR_CAPABILITY functions -- print extra error info
  * on socket errors, such as PMTU size.  As of 2003.05.11, only works
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index f73e50c07..94010a98f 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -247,17 +247,6 @@ struct ip_tcp_udp_hdr {
         acc -= (u32) >> 16;    \
 }
 
-/*
- * We are in a "liberal" position with respect to MSS,
- * i.e. we assume that MSS can be calculated from MTU
- * by subtracting out only the IP and TCP header sizes
- * without options.
- *
- * (RFC 879, section 7).
- */
-#define MTU_TO_MSS(mtu) (mtu - sizeof(struct openvpn_iphdr) \
-                         - sizeof(struct openvpn_tcphdr))
-
 /*
  * This returns an ip protocol version of packet inside tun
  * and offset of IP header (via parameter).
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8cbb129d2..96c78199a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -62,6 +62,7 @@
 #include "ssl_ncp.h"
 #include "ssl_util.h"
 #include "auth_token.h"
+#include "mss.h"
 
 #include "memdbg.h"
 
@@ -1893,7 +1894,7 @@ tls_session_update_crypto_params_do_work(struct tls_session *session,
                                    options->replay, packet_id_long_form);
     frame_finalize(frame, options->ce.link_mtu_defined, options->ce.link_mtu,
                    options->ce.tun_mtu_defined, options->ce.tun_mtu);
-    frame_init_mssfix(frame, options);
+    frame_calculate_mssfix(frame, &session->opt->key_type, options);
     frame_print(frame, D_MTU_INFO, "Data Channel MTU parms");
 
     /*
-- 
2.33.0


