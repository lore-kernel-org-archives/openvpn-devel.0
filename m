From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Oct 2018 09:34:13 +0200
Message-Id: <20181007073413.9778-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Add support for CHACHA20-POLY1305 in the
 data channel
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

We explicitly only supported GCM as a valid AEAD mode, change that to also
allow ChaCha20-Poly1305 as an AEAD cipher.  That works nicely with our new
(GCM) data channel format, because is has the same 96-bit IV.

Note that we need some tricks to not treat the cipher as insecure, because
we used to only look at the block size of a cipher to determine if find a
cipher insecure.  But ChaCha20-Poly1305 is a stream cipher, which essentially
has a 'block size' of 1 byte and is reported as such.  So, special-case this
cipher to be in the list of secure ciphers.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst                  | 10 ++++++++++
 src/openvpn/crypto.c         |  2 +-
 src/openvpn/crypto_backend.h |  5 +++++
 src/openvpn/crypto_mbedtls.c | 21 ++++++++++++++++++---
 src/openvpn/crypto_openssl.c | 33 ++++++++++++++++++++++++++++-----
 src/openvpn/ssl.c            |  2 +-
 6 files changed, 63 insertions(+), 10 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index a6090cf5..70ce2e10 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -1,3 +1,13 @@
+Overview of changes in 2.5
+==========================
+
+New features
+------------
+ChaCha20-Poly1305 cipher support
+    Added support for using the ChaCha20-Poly1305 cipher in the OpenVPN data
+    channel.
+
+
 Overview of changes in 2.4
 ==========================
 
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c8d95f3b..6d34acd7 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -841,7 +841,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
         dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=%d iv_size=%d",
              prefix, cipher_kt_block_size(kt->cipher),
              cipher_kt_iv_size(kt->cipher));
-        if (cipher_kt_block_size(kt->cipher) < 128/8)
+        if (cipher_kt_insecure(kt->cipher))
         {
             msg(M_WARN, "WARNING: INSECURE cipher with block size less than 128"
                 " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index f917c8d7..38b2c175 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -284,6 +284,11 @@ int cipher_kt_block_size(const cipher_kt_t *cipher_kt);
  */
 int cipher_kt_tag_size(const cipher_kt_t *cipher_kt);
 
+/**
+ * Returns true if we consider this cipher to be insecure.
+ */
+bool cipher_kt_insecure(const cipher_kt_t *cipher);
+
 /**
  * Returns the mode that the cipher runs in.
  *
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 82f4e574..a5a096b1 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -51,6 +51,7 @@
 #include <mbedtls/cipher.h>
 #include <mbedtls/havege.h>
 #include <mbedtls/pem.h>
+#include <mbedtls/version.h>
 
 #include <mbedtls/entropy.h>
 
@@ -175,7 +176,7 @@ show_available_ciphers(void)
     while (*ciphers != 0)
     {
         const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        if (info && cipher_kt_block_size(info) >= 128/8)
+        if (info && !cipher_kt_insecure(info))
         {
             print_cipher(info);
         }
@@ -188,7 +189,7 @@ show_available_ciphers(void)
     while (*ciphers != 0)
     {
         const cipher_kt_t *info = mbedtls_cipher_info_from_type(*ciphers);
-        if (info && cipher_kt_block_size(info) < 128/8)
+        if (info && cipher_kt_insecure(info))
         {
             print_cipher(info);
         }
@@ -550,6 +551,16 @@ cipher_kt_tag_size(const mbedtls_cipher_info_t *cipher_kt)
     return 0;
 }
 
+bool
+cipher_kt_insecure(const mbedtls_cipher_info_t *cipher_kt)
+{
+    return !(cipher_kt_block_size(cipher_kt) >= 128/8
+#if defined(MBEDTLS_CHACHAPOLY_C) && (MBEDTLS_VERSION_NUMBER >= 0x020C0000)
+             || cipher_kt->type == MBEDTLS_CIPHER_CHACHA20_POLY1305
+#endif
+             );
+}
+
 int
 cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
 {
@@ -573,7 +584,11 @@ cipher_kt_mode_ofb_cfb(const cipher_kt_t *cipher)
 bool
 cipher_kt_mode_aead(const cipher_kt_t *cipher)
 {
-    return cipher && cipher_kt_mode(cipher) == OPENVPN_MODE_GCM;
+    return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_GCM
+#if defined(MBEDTLS_CHACHAPOLY_C) && (MBEDTLS_VERSION_NUMBER >= 0x020C0000)
+                      || cipher_kt_mode(cipher) == MBEDTLS_MODE_CHACHAPOLY
+#endif
+                      );
 }
 
 
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 9ec2048d..0004be9e 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -245,6 +245,7 @@ const cipher_name_pair cipher_name_translation_table[] = {
     { "AES-128-GCM", "id-aes128-GCM" },
     { "AES-192-GCM", "id-aes192-GCM" },
     { "AES-256-GCM", "id-aes256-GCM" },
+    { "CHACHA20-POLY1305", "ChaCha20-Poly1305" },
 };
 const size_t cipher_name_translation_table_count =
     sizeof(cipher_name_translation_table) / sizeof(*cipher_name_translation_table);
@@ -321,7 +322,7 @@ show_available_ciphers(void)
     qsort(cipher_list, num_ciphers, sizeof(*cipher_list), cipher_name_cmp);
 
     for (i = 0; i < num_ciphers; i++) {
-        if (cipher_kt_block_size(cipher_list[i]) >= 128/8)
+        if (!cipher_kt_insecure(cipher_list[i]))
         {
             print_cipher(cipher_list[i]);
         }
@@ -330,7 +331,7 @@ show_available_ciphers(void)
     printf("\nThe following ciphers have a block size of less than 128 bits, \n"
            "and are therefore deprecated.  Do not use unless you have to.\n\n");
     for (i = 0; i < num_ciphers; i++) {
-        if (cipher_kt_block_size(cipher_list[i]) < 128/8)
+        if (cipher_kt_insecure(cipher_list[i]))
         {
             print_cipher(cipher_list[i]);
         }
@@ -686,6 +687,16 @@ cipher_kt_tag_size(const EVP_CIPHER *cipher_kt)
     }
 }
 
+bool
+cipher_kt_insecure(const EVP_CIPHER *cipher)
+{
+    return !(cipher_kt_block_size(cipher) >= 128/8
+#ifdef NID_chacha20_poly1305
+             || EVP_CIPHER_nid(cipher) == NID_chacha20_poly1305
+#endif
+            );
+}
+
 int
 cipher_kt_mode(const EVP_CIPHER *cipher_kt)
 {
@@ -720,10 +731,22 @@ bool
 cipher_kt_mode_aead(const cipher_kt_t *cipher)
 {
 #ifdef HAVE_AEAD_CIPHER_MODES
-    return cipher && (cipher_kt_mode(cipher) == OPENVPN_MODE_GCM);
-#else
-    return false;
+    if (cipher)
+    {
+        switch (EVP_CIPHER_nid(cipher))
+        {
+        case NID_aes_128_gcm:
+        case NID_aes_192_gcm:
+        case NID_aes_256_gcm:
+#ifdef NID_chacha20_poly1305
+        case NID_chacha20_poly1305:
 #endif
+            return true;
+        }
+    }
+#endif
+
+    return false;
 }
 
 /*
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4257c33d..315303b0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -294,7 +294,7 @@ tls_get_cipher_name_pair(const char *cipher_name, size_t len)
 static void
 tls_limit_reneg_bytes(const cipher_kt_t *cipher, int *reneg_bytes)
 {
-    if (cipher && (cipher_kt_block_size(cipher) < 128/8))
+    if (cipher && cipher_kt_insecure(cipher))
     {
         if (*reneg_bytes == -1) /* Not user-specified */
         {
-- 
2.17.1


