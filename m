From: Gert Doering <gert@...1296...>
Date: Sun, 16 Nov 2025 22:54:27 +0100
Message-ID: <20251116215433.29257-1-gert@...1296...>
In-Reply-To: <gerrit.1761324750000.Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7@...2715...>
References: <gerrit.1761324750000.Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] ssl: Clean up type handling in
 parse_early_negotiation_tlvs()
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

buf_read_u16 does not return uint16_t.

Change-Id: Ie7ad637223c332f7611c09b20a8d7a3a92d97ec7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1302
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1302
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 555f483..6f15ebe 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2194,11 +2194,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Handle reading key data, peer-info, username/password, OCC
  * from the TLS control channel (cleartext).
@@ -2529,9 +2524,9 @@
             goto error;
         }
         /* read type */
-        uint16_t type = buf_read_u16(buf);
-        uint16_t len = buf_read_u16(buf);
-        if (buf_len(buf) < len)
+        int type = buf_read_u16(buf);
+        int len = buf_read_u16(buf);
+        if (type < 0 || len < 0 || buf_len(buf) < len)
         {
             goto error;
         }
@@ -2543,7 +2538,7 @@
                 {
                     goto error;
                 }
-                uint16_t flags = buf_read_u16(buf);
+                int flags = buf_read_u16(buf);
 
                 if (flags & EARLY_NEG_FLAG_RESEND_WKC)
                 {
@@ -3971,10 +3966,6 @@
     }
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 tls_prepend_opcode_v1(const struct tls_multi *multi, struct buffer *buf)
 {

