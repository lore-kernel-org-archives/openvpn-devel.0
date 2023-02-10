From: Arne Schwabe <arne@...1227...>
Date: Fri, 10 Feb 2023 15:27:06 +0100
Message-Id: <20230210142712.572303-3-arne@...1227...>
In-Reply-To: <20230210142712.572303-1-arne@...1227...>
References: <20230210142712.572303-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] Combine extra_tun/frame parameter of
 frame_calculate_payload_overhead
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

Instead of passing a value and a bool just pass the value and 0 if
the caller does not want the value to be added. This also allows
the function to be used by a function without a frame struct.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mss.c |  2 +-
 src/openvpn/mtu.c | 14 +++++---------
 src/openvpn/mtu.h |  6 +++---
 src/openvpn/occ.c |  3 +--
 4 files changed, 10 insertions(+), 15 deletions(-)

diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index 429aa1e93..98d540688 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -303,7 +303,7 @@ frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
 
     /* Calculate the number of bytes that the payload differs from the payload
      * MTU. This are fragment/compression/ethernet headers */
-    payload_overhead = frame_calculate_payload_overhead(frame, options, kt, true);
+    payload_overhead = frame_calculate_payload_overhead(frame->extra_tun, options, kt);
 
     /* We are in a "liberal" position with respect to MSS,
      * i.e. we assume that MSS can be calculated from MTU
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 1d9ebe011..56ea67061 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -108,20 +108,16 @@ frame_calculate_protocol_header_size(const struct key_type *kt,
 
 
 size_t
-frame_calculate_payload_overhead(const struct frame *frame,
+frame_calculate_payload_overhead(size_t extra_tun,
                                  const struct options *options,
-                                 const struct key_type *kt,
-                                 bool extra_tun)
+                                 const struct key_type *kt)
 {
     size_t overhead = 0;
 
     /* This is the overhead of tap device that is not included in the MTU itself
      * i.e. Ethernet header that we still need to transmit as part of the
-     * payload */
-    if (extra_tun)
-    {
-        overhead += frame->extra_tun;
-    }
+     * payload, this is set to 0 by caller if not applicable */
+    overhead += extra_tun;
 
 #if defined(USE_COMP)
     /* v1 Compression schemes add 1 byte header. V2 only adds a header when it
@@ -158,7 +154,7 @@ frame_calculate_payload_size(const struct frame *frame,
                              const struct key_type *kt)
 {
     size_t payload_size = options->ce.tun_mtu;
-    payload_size += frame_calculate_payload_overhead(frame, options, kt, true);
+    payload_size += frame_calculate_payload_overhead(frame->extra_tun, options, kt);
     return payload_size;
 }
 
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 0ff4f7bfa..21dbcee7f 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -217,10 +217,10 @@ frame_calculate_payload_size(const struct frame *frame,
  * *  [IP][UDP][OPENVPN PROTOCOL HEADER][ **PAYLOAD incl compression header** ]
  */
 size_t
-frame_calculate_payload_overhead(const struct frame *frame,
+frame_calculate_payload_overhead(size_t extra_tun,
                                  const struct options *options,
-                                 const struct key_type *kt,
-                                 bool extra_tun);
+                                 const struct key_type *kt);
+
 
 /**
  * Calculates the size of the OpenVPN protocol header. This includes
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 0fa803cdb..94b82e0f5 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -305,8 +305,7 @@ check_send_occ_msg_dowork(struct context *c)
             const struct key_type *kt = &c->c1.ks.key_type;
 
             /* OCC message have comp/fragment headers but not ethernet headers */
-            payload_hdr = frame_calculate_payload_overhead(&c->c2.frame, &c->options,
-                                                           kt, false);
+            payload_hdr = frame_calculate_payload_overhead(0, &c->options, kt);
 
             /* Since we do not know the payload size we just pass 0 as size here */
             proto_hdr = frame_calculate_protocol_header_size(kt, &c->options, false);
-- 
2.37.1 (Apple Git-137.1)


