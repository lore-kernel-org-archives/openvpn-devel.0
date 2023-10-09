From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  9 Oct 2023 12:51:51 +0200
Message-Id: <20231009105151.34074-1-frank@...2641...>
In-Reply-To: <gerrit.1683717398000.Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26@...2715...>
References: <gerrit.1683717398000.Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Change type of frame.mss_fix to uint16_t
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
Cc: Arne Schwabe <arne-openvpn@...1227...>

Since in the end this always ends up as an uint16_t
anyway, just make the conversion much earlier. Cleans
up the code and removes some -Wconversion warnings.

v2:
 - proper error handling in options.c
v4:
 - also introduce a minimum mssfix

Change-Id: Id8321dfbb8ad8d79f4bb2a9da61f8cd6b6c6ee26
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/268
This mail reflects revision 4 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index dbd3681..d7ee4c2 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -44,7 +44,7 @@
  *              if yes, hand to mss_fixup_dowork()
  */
 void
-mss_fixup_ipv4(struct buffer *buf, int maxmss)
+mss_fixup_ipv4(struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_iphdr *pip;
     int hlen;
@@ -72,7 +72,7 @@
             struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *) BPTR(&newbuf);
             if (tc->flags & OPENVPN_TCPH_SYN_MASK)
             {
-                mss_fixup_dowork(&newbuf, (uint16_t) maxmss);
+                mss_fixup_dowork(&newbuf, maxmss);
             }
         }
     }
@@ -84,7 +84,7 @@
  *              (IPv6 header structure is sufficiently different from IPv4...)
  */
 void
-mss_fixup_ipv6(struct buffer *buf, int maxmss)
+mss_fixup_ipv6(struct buffer *buf, uint16_t maxmss)
 {
     const struct openvpn_ipv6hdr *pip6;
     struct buffer newbuf;
@@ -130,7 +130,7 @@
         struct openvpn_tcphdr *tc = (struct openvpn_tcphdr *) BPTR(&newbuf);
         if (tc->flags & OPENVPN_TCPH_SYN_MASK)
         {
-            mss_fixup_dowork(&newbuf, (uint16_t) maxmss-20);
+            mss_fixup_dowork(&newbuf, maxmss-20);
         }
     }
 }
@@ -191,13 +191,14 @@
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
@@ -291,7 +292,7 @@
     {
         /* we subtract IPv4 and TCP overhead here, mssfix method will add the
          * extra 20 for IPv6 */
-        frame->mss_fix = options->ce.mssfix - (20 + 20);
+        frame->mss_fix = (uint16_t)(options->ce.mssfix - (20 + 20));
         return;
     }
 
@@ -325,7 +326,7 @@
 
     /* This is the target value our payload needs to be smaller */
     unsigned int target = options->ce.mssfix - overhead;
-    frame->mss_fix = adjust_payload_max_cbc(kt, target) - payload_overhead;
+    frame->mss_fix = (uint16_t)(adjust_payload_max_cbc(kt, target) - payload_overhead);
 
 
 }
diff --git a/src/openvpn/mss.h b/src/openvpn/mss.h
index 1c4704b..b2a68cf 100644
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
index 56db118..81851d3 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -203,7 +203,7 @@
         buf_printf(&out, "%s ", prefix);
     }
     buf_printf(&out, "[");
-    buf_printf(&out, " mss_fix:%d", frame->mss_fix);
+    buf_printf(&out, " mss_fix:%" PRIu16, frame->mss_fix);
 #ifdef ENABLE_FRAGMENT
     buf_printf(&out, " max_frag:%d", frame->max_fragment_size);
 #endif
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index b602b86..c64398d 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -115,7 +115,7 @@
                                   *  decryption/encryption or compression. */
     } buf;
 
-    unsigned int mss_fix;       /**< The actual MSS value that should be
+    uint16_t mss_fix;           /**< The actual MSS value that should be
                                  *   written to the payload packets. This
                                  *   is the value for IPv4 TCP packets. For
                                  *   IPv6 packets another 20 bytes must
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c6f9ac3..b42aa69 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7234,9 +7234,19 @@
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
         if (p[1])
         {
+            int mssfix = positive_atoi(p[1]);
+            /* can be 0, but otherwise it needs to be high enough so we can
+             * substract room for headers. */
+            if (mssfix != 0
+                && (mssfix < TLS_CHANNEL_MTU_MIN || mssfix > UINT16_MAX))
+            {
+                msg(msglevel, "--mssfix value '%s' is invalid", p[1]);
+                goto err;
+            }
+
             /* value specified, assume encapsulation is not
              * included unless "mtu" follows later */
-            options->ce.mssfix = positive_atoi(p[1]);
+            options->ce.mssfix = mssfix;
             options->ce.mssfix_encap = false;
             options->ce.mssfix_default = false;
         }

