From: Gert Doering <gert@...1296...>
Date: Sat,  4 Oct 2025 08:15:38 +0200
Message-ID: <20251004061545.7277-1-gert@...1296...>
In-Reply-To: <gerrit.1758731785000.Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3@...2715...>
References: <gerrit.1758731785000.Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] crypto_epoch: Clean up type handling in
 ovpn_expand_label()
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

- Add explicit casts where we have checked the value and
  need to put it into a smaller type.
- Adapt some types to actual usage.

Change-Id: Iad717f0ff3c79ae199c8be5f93bc51bf258c68c3
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1218
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1218
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/crypto_epoch.c b/src/openvpn/crypto_epoch.c
index 7026ff8..f34dc8c 100644
--- a/src/openvpn/crypto_epoch.c
+++ b/src/openvpn/crypto_epoch.c
@@ -72,14 +72,9 @@
     hmac_ctx_free(hmac_ctx);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 bool
 ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t *label, size_t label_len,
-                  const uint8_t *context, size_t context_len, uint8_t *out, uint16_t out_len)
+                  const uint8_t *context, size_t context_len, uint8_t *out, int out_len)
 {
     if (secret_len != 32 || label_len > 250 || context_len > 255 || label_len < 1)
     {
@@ -89,22 +84,23 @@
          * need need to be in range */
         return false;
     }
+    ASSERT(out_len >= 0 && out_len <= UINT16_MAX);
 
     struct gc_arena gc = gc_new();
     /* 2 byte for the outlen encoded as uint16, 5 bytes for "ovpn ",
      * 1 byte for context len byte and 1 byte for label len byte */
     const uint8_t *label_prefix = (const uint8_t *)("ovpn ");
-    int prefix_len = 5;
+    uint8_t prefix_len = 5;
 
-    int hkdf_label_len = 2 + prefix_len + 1 + label_len + 1 + context_len;
+    size_t hkdf_label_len = 2 + prefix_len + 1 + label_len + 1 + context_len;
     struct buffer hkdf_label = alloc_buf_gc(hkdf_label_len, &gc);
 
-    buf_write_u16(&hkdf_label, out_len);
-    buf_write_u8(&hkdf_label, prefix_len + label_len);
+    buf_write_u16(&hkdf_label, (uint16_t)out_len);
+    buf_write_u8(&hkdf_label, prefix_len + (uint8_t)label_len);
     buf_write(&hkdf_label, label_prefix, prefix_len);
     buf_write(&hkdf_label, label, label_len);
 
-    buf_write_u8(&hkdf_label, context_len);
+    buf_write_u8(&hkdf_label, (uint8_t)context_len);
     if (context_len > 0)
     {
         buf_write(&hkdf_label, context, context_len);
@@ -168,10 +164,6 @@
     key->epoch = epoch_key->epoch;
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 epoch_init_send_key_ctx(struct crypto_options *co)
 {
diff --git a/src/openvpn/crypto_epoch.h b/src/openvpn/crypto_epoch.h
index 33ca741..a6fa116 100644
--- a/src/openvpn/crypto_epoch.h
+++ b/src/openvpn/crypto_epoch.h
@@ -60,7 +60,7 @@
  */
 bool ovpn_expand_label(const uint8_t *secret, size_t secret_len, const uint8_t *label,
                        size_t label_len, const uint8_t *context, size_t context_len, uint8_t *out,
-                       uint16_t out_len);
+                       int out_len);
 
 /**
  * Generate a data channel key pair from the epoch key

