From: Frank Lichtenheld <frank@...2641...>
Date: Wed, 14 Feb 2024 14:27:19 +0100
Message-Id: <20240214132719.3031492-1-frank@...2641...>
In-Reply-To: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
References: <gerrit.1706186293000.I00821d75342daf3f813b829812d648fe298bea81@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Implement support for AEAD tag at the end
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

From: Arne Schwabe <arne@...1227...>

Using the AEAD tag at the end is the standard way of doing AEAD. Several
APIs even only support the tag at the end (e.g. mbed TLS). Having the tag at
the front or end makes no difference for security but allows streaming HW
implementations like NICs to be much more efficient as they do not need to
buffer a whole packet content and encrypt it to finally write the tag but
instead just add the calculated tag at the end of processing.

Change-Id: I00821d75342daf3f813b829812d648fe298bea81
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/506
This mail reflects revision 3 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 2fca131..9988ebe 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -104,14 +104,10 @@
         ASSERT(cipher_ctx_reset(ctx->cipher, iv));
     }
 
-    /* Reserve space for authentication tag */
-    mac_out = buf_write_alloc(&work, mac_len);
-    ASSERT(mac_out);
-
     dmsg(D_PACKET_CONTENT, "ENCRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 80, &gc));
 
     /* Buffer overflow check */
-    if (!buf_safe(&work, buf->len + cipher_ctx_block_size(ctx->cipher)))
+    if (!buf_safe(&work, buf->len + mac_len + cipher_ctx_block_size(ctx->cipher)))
     {
         msg(D_CRYPT_ERRORS,
             "ENCRYPT: buffer size error, bc=%d bo=%d bl=%d wc=%d wo=%d wl=%d",
@@ -121,9 +117,16 @@
     }
 
     /* For AEAD ciphers, authenticate Additional Data, including opcode */
-    ASSERT(cipher_ctx_update_ad(ctx->cipher, BPTR(&work), BLEN(&work) - mac_len));
+    ASSERT(cipher_ctx_update_ad(ctx->cipher, BPTR(&work), BLEN(&work)));
     dmsg(D_PACKET_CONTENT, "ENCRYPT AD: %s",
-         format_hex(BPTR(&work), BLEN(&work) - mac_len, 0, &gc));
+         format_hex(BPTR(&work), BLEN(&work), 0, &gc));
+
+    if (!(opt->flags & CO_AEAD_TAG_AT_THE_END))
+    {
+        /* Reserve space for authentication tag */
+        mac_out = buf_write_alloc(&work, mac_len);
+        ASSERT(mac_out);
+    }
 
     /* Encrypt packet ID, payload */
     ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf), BLEN(buf)));
@@ -133,6 +136,14 @@
     ASSERT(cipher_ctx_final(ctx->cipher, BEND(&work), &outlen));
     ASSERT(buf_inc_len(&work, outlen));
 
+    /* if the tag is at end the end, allocate it now */
+    if (opt->flags & CO_AEAD_TAG_AT_THE_END)
+    {
+        /* Reserve space for authentication tag */
+        mac_out = buf_write_alloc(&work, mac_len);
+        ASSERT(mac_out);
+    }
+
     /* Write authentication tag */
     ASSERT(cipher_ctx_get_tag(ctx->cipher, mac_out, mac_len));
 
@@ -353,7 +364,6 @@
     static const char error_prefix[] = "AEAD Decrypt error";
     struct packet_id_net pin = { 0 };
     const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
-    uint8_t *tag_ptr = NULL;
     int outlen;
     struct gc_arena gc;
 
@@ -406,19 +416,29 @@
 
     /* keep the tag value to feed in later */
     const int tag_size = OPENVPN_AEAD_TAG_LENGTH;
-    if (buf->len < tag_size)
+    if (buf->len < tag_size + 1)
     {
-        CRYPT_ERROR("missing tag");
+        CRYPT_ERROR("missing tag or no payload");
     }
-    tag_ptr = BPTR(buf);
-    ASSERT(buf_advance(buf, tag_size));
+
+    const int ad_size = BPTR(buf) - ad_start;
+
+    uint8_t *tag_ptr = NULL;
+    int data_len = 0;
+
+    if (opt->flags & CO_AEAD_TAG_AT_THE_END)
+    {
+        data_len = BLEN(buf) - tag_size;
+        tag_ptr = BPTR(buf) + data_len;
+    }
+    else
+    {
+        tag_ptr = BPTR(buf);
+        ASSERT(buf_advance(buf, tag_size));
+        data_len = BLEN(buf);
+    }
+
     dmsg(D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex(tag_ptr, tag_size, 0, &gc));
-
-    if (buf->len < 1)
-    {
-        CRYPT_ERROR("missing payload");
-    }
-
     dmsg(D_PACKET_CONTENT, "DECRYPT FROM: %s", format_hex(BPTR(buf), BLEN(buf), 0, &gc));
 
     /* Buffer overflow check (should never fail) */
@@ -427,20 +447,19 @@
         CRYPT_ERROR("potential buffer overflow");
     }
 
-    {
-        /* feed in tag and the authenticated data */
-        const int ad_size = BPTR(buf) - ad_start - tag_size;
-        ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start, ad_size));
-        dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s",
-             format_hex(BPTR(buf) - ad_size - tag_size, ad_size, 0, &gc));
-    }
+
+    /* feed in tag and the authenticated data */
+    ASSERT(cipher_ctx_update_ad(ctx->cipher, ad_start, ad_size));
+    dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s",
+         format_hex(ad_start, ad_size, 0, &gc));
 
     /* Decrypt and authenticate packet */
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf),
-                           BLEN(buf)))
+                           data_len))
     {
         CRYPT_ERROR("cipher update failed");
     }
+
     ASSERT(buf_inc_len(&work, outlen));
     if (!cipher_ctx_final_check_tag(ctx->cipher, BPTR(&work) + outlen,
                                     &outlen, tag_ptr, tag_size))
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 4201524..95a5b31 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -279,6 +279,10 @@
     /**< Bit-flag indicating that renegotiations are using tls-crypt
      *   with a TLS-EKM derived key.
      */
+#define CO_AEAD_TAG_AT_THE_END  (1<<8)
+    /**< Bit-flag indicating that the AEAD tag is at the end of the
+     *   packet.
+     */
 
     unsigned int flags;         /**< Bit-flags determining behavior of
                                  *   security operation functions. */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index c5cc154..cd37b36 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2323,6 +2323,10 @@
         {
             buf_printf(&out, " dyn-tls-crypt");
         }
+        if (o->imported_protocol_flags & CO_AEAD_TAG_AT_THE_END)
+        {
+            buf_printf(&out, " aead-tag-end");
+        }
     }
 
     if (buf_len(&out) > strlen(header))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2c79a1e..39f00c0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -8686,6 +8686,10 @@
                 options->imported_protocol_flags |= CO_USE_DYNAMIC_TLS_CRYPT;
             }
 #endif
+            else if (streq(p[j], "aead-tag-end"))
+            {
+                options->imported_protocol_flags |= CO_AEAD_TAG_AT_THE_END;
+            }
             else
             {
                 msg(msglevel, "Unknown protocol-flags flag: %s", p[j]);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 2249434..e4c122c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -29,6 +29,7 @@
 
 #include "push.h"
 #include "options.h"
+#include "crypto.h"
 #include "ssl.h"
 #include "ssl_verify.h"
 #include "ssl_ncp.h"
@@ -686,6 +687,11 @@
         buf_printf(&proto_flags, " dyn-tls-crypt");
     }
 
+    if (o->imported_protocol_flags & CO_AEAD_TAG_AT_THE_END)
+    {
+        buf_printf(&proto_flags, " aead-tag-end");
+    }
+
     if (buf_len(&proto_flags) > 0)
     {
         push_option_fmt(gc, push_list, M_USAGE, "protocol-flags%s", buf_str(&proto_flags));
diff --git a/tests/unit_tests/openvpn/test_ssl.c b/tests/unit_tests/openvpn/test_ssl.c
index 8c1fb5b..2ccfa45 100644
--- a/tests/unit_tests/openvpn/test_ssl.c
+++ b/tests/unit_tests/openvpn/test_ssl.c
@@ -265,6 +265,17 @@
 
 }
 
+/* This adds a few more methods than strictly necessary but this allows
+ * us to see which exact test was run from the backtrace of the test
+ * when it fails */
+static void
+run_data_channel_with_cipher_end(const char *cipher)
+{
+    struct crypto_options co = init_crypto_options(cipher, "none");
+    co.flags |= CO_AEAD_TAG_AT_THE_END;
+    do_data_channel_round_trip(&co);
+    uninit_crypto_options(&co);
+}
 
 static void
 run_data_channel_with_cipher(const char *cipher, const char *auth)
@@ -274,21 +285,25 @@
     uninit_crypto_options(&co);
 }
 
+
 static void
 test_data_channel_roundtrip_aes_128_gcm(void **state)
 {
+    run_data_channel_with_cipher_end("AES-128-GCM");
     run_data_channel_with_cipher("AES-128-GCM", "none");
 }
 
 static void
 test_data_channel_roundtrip_aes_192_gcm(void **state)
 {
+    run_data_channel_with_cipher_end("AES-192-GCM");
     run_data_channel_with_cipher("AES-192-GCM", "none");
 }
 
 static void
 test_data_channel_roundtrip_aes_256_gcm(void **state)
 {
+    run_data_channel_with_cipher_end("AES-256-GCM");
     run_data_channel_with_cipher("AES-256-GCM", "none");
 }
 
@@ -318,6 +333,8 @@
         skip();
         return;
     }
+
+    run_data_channel_with_cipher_end("ChaCha20-Poly1305");
     run_data_channel_with_cipher("ChaCha20-Poly1305", "none");
 }
 

