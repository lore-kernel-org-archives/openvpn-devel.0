From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 10 May 2023 13:22:35 +0200
Message-Id: <20230510112236.248026-3-frank@...2641...>
In-Reply-To: <20230510112236.248026-1-frank@...2641...>
References: <20230510112236.248026-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] Change type of frame.mss_fix to uint16_t
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

Since in the end this always ends up as an uint16_t
anyway, just make the conversion much earlier. Cleans
up the code and removes some -Wconversion warnings.

Change-Id: Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 src/openvpn/mss.c     | 21 +++++++++++----------
 src/openvpn/mss.h     |  4 ++--
 src/openvpn/mtu.c     |  2 +-
 src/openvpn/mtu.h     |  2 +-
 src/openvpn/options.c |  1 +
 5 files changed, 16 insertions(+), 14 deletions(-)

diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index fd2d3c1d..44b316da 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -46,7 +46,7 @@
  *              if yes, hand to mss_fixup_dowork()
  */
 void
-mss_fixup_ipv4(struct buffer *buf, int maxmss)
+mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_iphdr *pip;
     int hlen;
@@ -74,7 +74,7 @@ mss_fixup_ipv4(struct buffer *buf, int maxmss)
             struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *) BPTR(&newbuf);
             if (tc->flags & OPENVPN_TCPH_SYN_MASK)
             {
-                mss_fixup_dowork(&newbuf, (uint16_t) maxmss);
+                mss_fixup_dowork(&newbuf, maxmss);
             }
         }
     }
@@ -86,7 +86,7 @@ mss_fixup_ipv4(struct buffer *buf, int maxmss)
  *              (IPv6 header structure is sufficiently different from IPv4...)
  */
 void
-mss_fixup_ipv6(struct buffer *buf, int maxmss)
+mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_ipv6hdr *pip6;
     struct buffer newbuf;
@@ -132,7 +132,7 @@ mss_fixup_ipv6(struct buffer *buf, int maxmss)
         struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *) BPTR(&newbuf);
         if (tc->flags & OPENVPN_TCPH_SYN_MASK)
         {
-            mss_fixup_dowork(&newbuf, (uint16_t) maxmss-20);
+            mss_fixup_dowork(&newbuf, maxmss-20);
         }
     }
 }
@@ -193,13 +193,14 @@ mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
                 {
                     continue;
                 }
-                mssval = (opt[2]<<8)+opt[3];
+                mssval = opt[2] << 8;
+                mssval += opt[3];
                 if (mssval > maxmss)
                 {
-                    dmsg(D_MSS, "MSS: %d -> %d", (int) mssval, (int) maxmss);
+                    dmsg(D_MSS, "MSS: %" PRIu16 " -> %" PRIu16, mssval, maxmss);
                     accumulate = htons(mssval);
-                    opt[2] = (maxmss>>8)&0xff;
-                    opt[3] = maxmss&0xff;
+                    opt[2] = (uint8_t)((maxmss>>8)&0xff);
+                    opt[3] = (uint8_t)(maxmss&0xff);
                     accumulate -= htons(maxmss);
                     ADJUST_CHECKSUM(accumulate, tc->check);
                 }
@@ -293,7 +294,7 @@ frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
     {
         /* we subtract IPv4 and TCP overhead here, mssfix method will add the
          * extra 20 for IPv6 */
-        frame->mss_fix = options->ce.mssfix - (20 + 20);
+        frame->mss_fix = (uint16_t)(options->ce.mssfix - (20 + 20));
         return;
     }
 
@@ -327,7 +328,7 @@ frame_calculate_mssfix(struct frame *frame, struct key_type *kt,
 
     /* This is the target value our payload needs to be smaller */
     unsigned int target = options->ce.mssfix - overhead;
-    frame->mss_fix = adjust_payload_max_cbc(kt, target) - payload_overhead;
+    frame->mss_fix = (uint16_t)(adjust_payload_max_cbc(kt, target) - payload_overhead);
 
 
 }
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 1c4704bd..b2a68cf7 100644
--- a/src/openvpn/mss.h
+++ b/src/openvpn/mss.h
@@ -29,9 +29,9 @@
 #include "mtu.h"
 #include "ssl_common.h"
 
-void mss_fixup_ipv4(struct buffer *buf, int maxmss);
+void mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss);
 
-void mss_fixup_ipv6(struct buffer *buf, int maxmss);
+void mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss);
 
 void mss_fixup_dowork(struct buffer *buf, uint16_t maxmss);
 
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 2925b7fe..3c8468a9 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -212,7 +212,7 @@ frame_print(const struct frame *frame,
         buf_printf(&out, "%s ", prefix);
     }
     buf_printf(&out, "[");
-    buf_printf(&out, " mss_fix:%d", frame->mss_fix);
+    buf_printf(&out, " mss_fix:%" PRIu16, frame->mss_fix);
 #ifdef ENABLE_FRAGMENT
     buf_printf(&out, " max_frag:%d", frame->max_fragment_size);
 #endif
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index b602b86b..c64398de 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -115,7 +115,7 @@ struct frame {
                                   *  decryption/encryption or compression. */
     } buf;
 
-    unsigned int mss_fix;       /**< The actual MSS value that should be
+    uint16_t mss_fix;           /**< The actual MSS value that should be
                                  *   written to the payload packets. This
                                  *   is the value for IPv4 TCP packets. For
                                  *   IPv6 packets another 20 bytes must
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fa435c1d..94859294 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7260,6 +7260,7 @@ add_option(struct options *options,
             /* value specified, assume encapsulation is not
              * included unless "mtu" follows later */
             options->ce.mssfix = positive_atoi(p[1]);
+            ASSERT(options->ce.mssfix <= UINT16_MAX);
             options->ce.mssfix_encap = false;
             options->ce.mssfix_default = false;
         }
-- 
2.34.1


