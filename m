From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 11:28:54 +0200
Message-ID: <20251008092859.875-1-gert@...1296...>
In-Reply-To: <gerrit.1758731785000.I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88@...2715...>
References: <gerrit.1758731785000.I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] crypto: Make some casts to int explicit
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

In all of these cases the cast is safe to do
since we have limits imposed in other ways.

And we want those values as int, so no
alternative to casting.

Change-Id: I3b8dd8d5671e31dba2a23a0a78f36d9dda034b88
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1217
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1217
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 6376c11..307d1ee 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -186,11 +186,6 @@
     return;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static void
 openvpn_encrypt_v1(struct buffer *buf, struct buffer work, struct crypto_options *opt)
 {
@@ -302,7 +297,7 @@
         if (ctx->hmac)
         {
             hmac_ctx_reset(ctx->hmac);
-            hmac_ctx_update(ctx->hmac, hmac_start, BEND(&work) - hmac_start);
+            hmac_ctx_update(ctx->hmac, hmac_start, (int)(BEND(&work) - hmac_start));
             hmac_ctx_final(ctx->hmac, mac_out);
             dmsg(D_PACKET_CONTENT, "ENCRYPT HMAC: %s",
                  format_hex(mac_out, hmac_ctx_size(ctx->hmac), 80, &gc));
@@ -533,7 +528,7 @@
         }
     }
 
-    const int ad_size = BPTR(buf) - ad_start;
+    const int ad_size = (int)(BPTR(buf) - ad_start);
 
     uint8_t *tag_ptr = NULL;
     int data_len = 0;
@@ -1366,8 +1361,8 @@
     int state = PARSE_INITIAL;
 
     /* constants */
-    const int hlen = strlen(static_key_head);
-    const int flen = strlen(static_key_foot);
+    const int hlen = (int)strlen(static_key_head);
+    const int flen = (int)strlen(static_key_foot);
     const int onekeylen = sizeof(key2->keys[0]);
 
     CLEAR(*key2);
@@ -1378,7 +1373,9 @@
      */
     if (flags & RKF_INLINE) /* 'file' is a string containing ascii representation of key */
     {
-        size = strlen(file) + 1;
+        size_t buf_size = strlen(file) + 1;
+        ASSERT(buf_size <= INT_MAX);
+        size = (int)buf_size;
         buf_set_read(&in, (const uint8_t *)file, size);
     }
     else /* 'file' is a filename which refers to a file containing the ascii key */
@@ -1537,10 +1534,6 @@
     gc_free(&gc);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 int
 write_key_file(const int nkeys, const char *filename)
 {

