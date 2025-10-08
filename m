From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 16:28:41 +0200
Message-ID: <20251008142846.28486-1-gert@...1296...>
In-Reply-To: <gerrit.1756814708000.Ica721a51b00d5314125bcaf5a586e718c5982aef@...2715...>
References: <gerrit.1756814708000.Ica721a51b00d5314125bcaf5a586e718c5982aef@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] proto: Clean up conversion warnings
 related to checksum macros
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

From: Frank Lichtenheld <frank@...2641...>

These should not change any behavior, they mostly clarify
the used types and silence warnings, since these casts are
deliberate.

Change-Id: Ica721a51b00d5314125bcaf5a586e718c5982aef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1164
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1164
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index b49d4bb..7751a47 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -185,11 +185,7 @@
                      const int direction)
 {
     struct ip_tcp_udp_hdr *h = (struct ip_tcp_udp_hdr *)BPTR(ipbuf);
-    int i;
-    uint32_t addr, *addr_ptr;
-    const uint32_t *from, *to;
-    int accumulate = 0;
-    unsigned int amask;
+    int32_t accumulate = 0;
     unsigned int alog = 0;
 
     if (check_debug_level(D_CLIENT_NAT))
@@ -197,8 +193,11 @@
         print_pkt(&h->ip, "BEFORE", direction, D_CLIENT_NAT);
     }
 
-    for (i = 0; i < list->n; ++i)
+    for (int i = 0; i < list->n; ++i)
     {
+        uint32_t addr, *addr_ptr;
+        const uint32_t *from, *to;
+        unsigned int amask;
         const struct client_nat_entry *e = &list->entries[i]; /* current NAT rule */
         if (e->type ^ direction)
         {
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index e7111a8..10d61d1 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -130,11 +130,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * change TCP MSS option in SYN/SYN-ACK packets, if present
  * this is generic for IPv4 and IPv6, as the TCP header is the same
@@ -143,11 +138,8 @@
 void
 mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
 {
-    int hlen, olen, optlen;
+    int olen, optlen;
     uint8_t *opt;
-    uint16_t mssval;
-    int accumulate;
-    struct openvpn_tcphdr *tc;
 
     if (BLEN(buf) < (int)sizeof(struct openvpn_tcphdr))
     {
@@ -155,8 +147,8 @@
     }
 
     verify_align_4(buf);
-    tc = (struct openvpn_tcphdr *)BPTR(buf);
-    hlen = OPENVPN_TCPH_GET_DOFF(tc->doff_res);
+    struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *)BPTR(buf);
+    int hlen = OPENVPN_TCPH_GET_DOFF(tc->doff_res);
 
     /* Invalid header length or header without options. */
     if (hlen <= (int)sizeof(struct openvpn_tcphdr) || hlen > BLEN(buf))
@@ -171,43 +163,37 @@
         {
             break;
         }
-        else if (*opt == OPENVPN_TCPOPT_NOP)
+        if (*opt == OPENVPN_TCPOPT_NOP)
         {
             optlen = 1;
+            continue;
         }
-        else
+
+        optlen = *(opt + 1);
+        if (optlen <= 0 || optlen > olen)
         {
-            optlen = *(opt + 1);
-            if (optlen <= 0 || optlen > olen)
+            break;
+        }
+        if (*opt == OPENVPN_TCPOPT_MAXSEG)
+        {
+            if (optlen != OPENVPN_TCPOLEN_MAXSEG)
             {
-                break;
+                continue;
             }
-            if (*opt == OPENVPN_TCPOPT_MAXSEG)
+            uint16_t mssval = (uint16_t)(opt[2] << 8) + opt[3];
+            if (mssval > maxmss)
             {
-                if (optlen != OPENVPN_TCPOLEN_MAXSEG)
-                {
-                    continue;
-                }
-                mssval = opt[2] << 8;
-                mssval += opt[3];
-                if (mssval > maxmss)
-                {
-                    dmsg(D_MSS, "MSS: %" PRIu16 " -> %" PRIu16, mssval, maxmss);
-                    accumulate = htons(mssval);
-                    opt[2] = (uint8_t)((maxmss >> 8) & 0xff);
-                    opt[3] = (uint8_t)(maxmss & 0xff);
-                    accumulate -= htons(maxmss);
-                    ADJUST_CHECKSUM(accumulate, tc->check);
-                }
+                dmsg(D_MSS, "MSS: %" PRIu16 " -> %" PRIu16, mssval, maxmss);
+                opt[2] = (uint8_t)((maxmss >> 8) & 0xff);
+                opt[3] = (uint8_t)(maxmss & 0xff);
+                int32_t accumulate = htons(mssval);
+                accumulate -= htons(maxmss);
+                ADJUST_CHECKSUM(accumulate, tc->check);
             }
         }
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static inline size_t
 adjust_payload_max_cbc(const struct key_type *kt, size_t target)
 {
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 62157fa..94952bd 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -214,7 +214,7 @@
  */
 #define ADJUST_CHECKSUM(acc, cksum)                \
     {                                              \
-        int _acc = acc;                            \
+        int32_t _acc = acc;                        \
         _acc += (cksum);                           \
         if (_acc < 0)                              \
         {                                          \
@@ -231,16 +231,16 @@
         }                                          \
     }
 
-#define ADD_CHECKSUM_32(acc, u32) \
-    {                             \
-        acc += (u32) & 0xffff;    \
-        acc += (u32) >> 16;       \
+#define ADD_CHECKSUM_32(acc, u32)         \
+    {                                     \
+        acc += (int32_t)((u32) & 0xffff); \
+        acc += (int32_t)((u32) >> 16);    \
     }
 
-#define SUB_CHECKSUM_32(acc, u32) \
-    {                             \
-        acc -= (u32) & 0xffff;    \
-        acc -= (u32) >> 16;       \
+#define SUB_CHECKSUM_32(acc, u32)         \
+    {                                     \
+        acc -= (int32_t)((u32) & 0xffff); \
+        acc -= (int32_t)((u32) >> 16);    \
     }
 
 /*

