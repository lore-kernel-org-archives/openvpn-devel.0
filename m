From: Arne Schwabe <arne@...1227...>
Date: Sun,  7 Nov 2021 10:01:38 +0100
Message-Id: <20211107090138.3150187-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Completely remove DES checks
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

We already removed the check in d67658fee for OpenSSL 3.0. This removes the
checks entirely for all crypto libraries.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c         | 15 --------
 src/openvpn/crypto_backend.h | 28 ---------------
 src/openvpn/crypto_mbedtls.c | 56 ------------------------------
 src/openvpn/crypto_openssl.c | 66 ------------------------------------
 4 files changed, 165 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1d242ac5a..e267e7a06 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -986,21 +986,6 @@ check_key(struct key *key, const struct key_type *kt)
         {
             return false;
         }
-
-        /*
-         * Check for weak or semi-weak DES keys.
-         */
-        {
-            const int ndc = key_des_num_cblocks(kt->cipher);
-            if (ndc)
-            {
-                return key_des_check(key->cipher, kt->cipher_length, ndc);
-            }
-            else
-            {
-                return true;
-            }
-        }
     }
     return true;
 }
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 8bf6012a9..40984c559 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -156,34 +156,6 @@ bool crypto_pem_decode(const char *name, struct buffer *dst,
  */
 int rand_bytes(uint8_t *output, int len);
 
-/*
- *
- * Key functions, allow manipulation of keys.
- *
- */
-
-
-/**
- * Return number of DES cblocks (1 cblock = length of a single-DES key) for the
- * current key type or 0 if not a DES cipher.
- *
- * @param kt            Type of key
- *
- * @return              Number of DES cblocks that the key consists of, or 0.
- */
-int key_des_num_cblocks(const cipher_kt_t *kt);
-
-/*
- * Check the given DES key. Checks the given key's length, weakness and parity.
- *
- * @param key           Key to check
- * @param key_len       Length of the key, in bytes
- * @param ndc           Number of DES cblocks that the key is made up of.
- *
- * @return              \c true if the key is valid, \c false otherwise.
- */
-bool key_des_check(uint8_t *key, int key_len, int ndc);
-
 /**
  * Encrypt the given block, using DES ECB mode
  *
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index a31ff5561..781da1ca9 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -386,62 +386,6 @@ rand_bytes(uint8_t *output, int len)
     return 1;
 }
 
-/*
- *
- * Key functions, allow manipulation of keys.
- *
- */
-
-
-int
-key_des_num_cblocks(const mbedtls_cipher_info_t *kt)
-{
-    int ret = 0;
-    if (kt->type == MBEDTLS_CIPHER_DES_CBC)
-    {
-        ret = 1;
-    }
-    if (kt->type == MBEDTLS_CIPHER_DES_EDE_CBC)
-    {
-        ret = 2;
-    }
-    if (kt->type == MBEDTLS_CIPHER_DES_EDE3_CBC)
-    {
-        ret = 3;
-    }
-
-    dmsg(D_CRYPTO_DEBUG, "CRYPTO INFO: n_DES_cblocks=%d", ret);
-    return ret;
-}
-
-bool
-key_des_check(uint8_t *key, int key_len, int ndc)
-{
-    int i;
-    struct buffer b;
-
-    buf_set_read(&b, key, key_len);
-
-    for (i = 0; i < ndc; ++i)
-    {
-        unsigned char *key = buf_read_alloc(&b, MBEDTLS_DES_KEY_SIZE);
-        if (!key)
-        {
-            msg(D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: insufficient key material");
-            goto err;
-        }
-        if (0 != mbedtls_des_key_check_weak(key))
-        {
-            msg(D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected");
-            goto err;
-        }
-    }
-    return true;
-
-err:
-    return false;
-}
-
 /*
  *
  * Generic cipher key type functions
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index bbfe15143..116c99c8e 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -552,72 +552,6 @@ rand_bytes(uint8_t *output, int len)
     return 1;
 }
 
-/*
- *
- * Key functions, allow manipulation of keys.
- *
- */
-
-
-int
-key_des_num_cblocks(const EVP_CIPHER *kt)
-{
-    int ret = 0;
-    const char *name = OBJ_nid2sn(EVP_CIPHER_nid(kt));
-    if (name)
-    {
-        if (!strncmp(name, "DES-", 4))
-        {
-            ret = EVP_CIPHER_key_length(kt) / sizeof(DES_cblock);
-        }
-        else if (!strncmp(name, "DESX-", 5))
-        {
-            ret = 1;
-        }
-    }
-    dmsg(D_CRYPTO_DEBUG, "CRYPTO INFO: n_DES_cblocks=%d", ret);
-    return ret;
-}
-
-bool
-key_des_check(uint8_t *key, int key_len, int ndc)
-{
-#if OPENSSL_VERSION_NUMBER < 0x30000000L
-    int i;
-    struct buffer b;
-
-    buf_set_read(&b, key, key_len);
-
-    for (i = 0; i < ndc; ++i)
-    {
-        DES_cblock *dc = (DES_cblock *) buf_read_alloc(&b, sizeof(DES_cblock));
-        if (!dc)
-        {
-            crypto_msg(D_CRYPT_ERRORS,
-                       "CRYPTO INFO: check_key_DES: insufficient key material");
-            goto err;
-        }
-        if (DES_is_weak_key(dc))
-        {
-            crypto_msg(D_CRYPT_ERRORS,
-                       "CRYPTO INFO: check_key_DES: weak key detected");
-            goto err;
-        }
-    }
-    return true;
-
-err:
-    ERR_clear_error();
-    return false;
-#else
-    /* DES is deprecated and the method to even check the keys is deprecated
-     * in OpenSSL 3.0. Instead of checking for the 16 weak/semi-weak keys
-     * we just accept them in OpenSSL 3.0 since the risk of randomly getting
-     * these is pretty low (and "all DES keys are weak" anyway) */
-    return true;
-#endif
-}
-
 /*
  *
  * Generic cipher key type functions
-- 
2.33.0


