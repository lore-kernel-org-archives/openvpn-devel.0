From: Arne Schwabe <arne@...1227...>
Date: Tue, 19 Oct 2021 20:31:13 +0200
Message-Id: <20211019183127.614175-8-arne@...1227...>
In-Reply-To: <20211019183127.614175-1-arne@...1227...>
References: <20211019183127.614175-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 07/21] [OSSL 3.0] Remove DES key fixup
 code
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

This code mainly sets the parity bits in the DES keys. As mbed TLS and
OpenSSL already ignore these bits in the DES key and since DES is
deprecated, remove this special DES code that is not even needed by
the libraries.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c         | 46 ------------------------------------
 src/openvpn/crypto.h         |  2 --
 src/openvpn/crypto_backend.h |  9 -------
 src/openvpn/crypto_mbedtls.c | 24 -------------------
 src/openvpn/crypto_openssl.c | 27 ---------------------
 src/openvpn/ntlm.c           |  1 -
 src/openvpn/ssl.c            | 18 --------------
 7 files changed, 127 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 1dfc760f9..ce041153f 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -956,45 +956,6 @@ check_key(struct key *key, const struct key_type *kt)
     return true;
 }
 
-/*
- * Make safe mutations to key to ensure it is valid,
- * such as ensuring correct parity on DES keys.
- *
- * This routine cannot guarantee it will generate a good
- * key.  You must always call check_key after this routine
- * to make sure.
- */
-void
-fixup_key(struct key *key, const struct key_type *kt)
-{
-    struct gc_arena gc = gc_new();
-    if (kt->cipher)
-    {
-#ifdef ENABLE_DEBUG
-        const struct key orig = *key;
-#endif
-        const int ndc = key_des_num_cblocks(kt->cipher);
-
-        if (ndc)
-        {
-            key_des_fixup(key->cipher, kt->cipher_length, ndc);
-        }
-
-#ifdef ENABLE_DEBUG
-        if (check_debug_level(D_CRYPTO_DEBUG))
-        {
-            if (memcmp(orig.cipher, key->cipher, kt->cipher_length))
-            {
-                dmsg(D_CRYPTO_DEBUG, "CRYPTO INFO: fixup_key: before=%s after=%s",
-                     format_hex(orig.cipher, kt->cipher_length, 0, &gc),
-                     format_hex(key->cipher, kt->cipher_length, 0, &gc));
-            }
-        }
-#endif
-    }
-    gc_free(&gc);
-}
-
 void
 check_replay_consistency(const struct key_type *kt, bool packet_id)
 {
@@ -1043,10 +1004,6 @@ generate_key_random(struct key *key, const struct key_type *kt)
         dmsg(D_SHOW_KEY_SOURCE, "Cipher source entropy: %s", format_hex(key->cipher, cipher_len, 0, &gc));
         dmsg(D_SHOW_KEY_SOURCE, "HMAC source entropy: %s", format_hex(key->hmac, hmac_len, 0, &gc));
 
-        if (kt)
-        {
-            fixup_key(key, kt);
-        }
     } while (kt && !check_key(key, kt));
 
     gc_free(&gc);
@@ -1589,9 +1546,6 @@ verify_fix_key2(struct key2 *key2, const struct key_type *kt, const char *shared
 
     for (i = 0; i < key2->n; ++i)
     {
-        /* Fix parity for DES keys and make sure not a weak key */
-        fixup_key(&key2->keys[i], kt);
-
         /* This should be a very improbable failure */
         if (!check_key(&key2->keys[i], kt))
         {
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 759da4bfb..e9ba21ab2 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -288,8 +288,6 @@ void check_replay_consistency(const struct key_type *kt, bool packet_id);
 
 bool check_key(struct key *key, const struct key_type *kt);
 
-void fixup_key(struct key *key, const struct key_type *kt);
-
 bool write_key(const struct key *key, const struct key_type *kt,
                struct buffer *buf);
 
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index e0bfdf585..cc897acf4 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -170,15 +170,6 @@ int key_des_num_cblocks(const cipher_kt_t *kt);
  */
 bool key_des_check(uint8_t *key, int key_len, int ndc);
 
-/*
- * Fix the given DES key, setting its parity to odd.
- *
- * @param key           Key to check
- * @param key_len       Length of the key, in bytes
- * @param ndc           Number of DES cblocks that the key is made up of.
- */
-void key_des_fixup(uint8_t *key, int key_len, int ndc);
-
 /**
  * Encrypt the given block, using DES ECB mode
  *
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index e2f5f4012..2f7f00d19 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -422,11 +422,6 @@ key_des_check(uint8_t *key, int key_len, int ndc)
             msg(D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: weak key detected");
             goto err;
         }
-        if (0 != mbedtls_des_key_check_key_parity(key))
-        {
-            msg(D_CRYPT_ERRORS, "CRYPTO INFO: check_key_DES: bad parity detected");
-            goto err;
-        }
     }
     return true;
 
@@ -434,25 +429,6 @@ err:
     return false;
 }
 
-void
-key_des_fixup(uint8_t *key, int key_len, int ndc)
-{
-    int i;
-    struct buffer b;
-
-    buf_set_read(&b, key, key_len);
-    for (i = 0; i < ndc; ++i)
-    {
-        unsigned char *key = buf_read_alloc(&b, MBEDTLS_DES_KEY_SIZE);
-        if (!key)
-        {
-            msg(D_CRYPT_ERRORS, "CRYPTO INFO: fixup_key_DES: insufficient key material");
-            return;
-        }
-        mbedtls_des_key_set_parity(key);
-    }
-}
-
 /*
  *
  * Generic cipher key type functions
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 8db2ddd09..93c85a836 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -546,12 +546,6 @@ key_des_check(uint8_t *key, int key_len, int ndc)
                        "CRYPTO INFO: check_key_DES: weak key detected");
             goto err;
         }
-        if (!DES_check_key_parity(dc))
-        {
-            crypto_msg(D_CRYPT_ERRORS,
-                       "CRYPTO INFO: check_key_DES: bad parity detected");
-            goto err;
-        }
     }
     return true;
 
@@ -563,27 +557,6 @@ err:
 #endif
 }
 
-void
-key_des_fixup(uint8_t *key, int key_len, int ndc)
-{
-    int i;
-    struct buffer b;
-
-    buf_set_read(&b, key, key_len);
-    for (i = 0; i < ndc; ++i)
-    {
-        DES_cblock *dc = (DES_cblock *) buf_read_alloc(&b, sizeof(DES_cblock));
-        if (!dc)
-        {
-            msg(D_CRYPT_ERRORS, "CRYPTO INFO: fixup_key_DES: insufficient key material");
-            ERR_clear_error();
-            return;
-        }
-        DES_set_odd_parity(dc);
-    }
-}
-
-
 /*
  *
  * Generic cipher key type functions
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 3abe3b7e3..28e68ded5 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -67,7 +67,6 @@ create_des_keys(const unsigned char *hash, unsigned char *key)
     key[5] = ((hash[4] & 31) << 3) | (hash[5] >> 5);
     key[6] = ((hash[5] & 63) << 2) | (hash[6] >> 6);
     key[7] = ((hash[6] & 127) << 1);
-    key_des_fixup(key, 8, 1);
 }
 
 static void
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index b2dc48be2..ee416a64c 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1739,24 +1739,6 @@ generate_key_expansion_openvpn_prf(const struct tls_session *session, struct key
     }
     secure_memzero(&master, sizeof(master));
 
-
-
-    /*
-     * fixup_key only correctly sets DES parity bits if the cipher is a
-     * DES variant.
-     *
-     * The newer OpenSSL and mbed TLS libraries (those that support EKM)
-     * ignore these bits.
-     *
-     * We keep the DES fixup here as compatibility.
-     * OpenVPN3 never did this fixup anyway. So this code is *probably* not
-     * required but we keep it for compatibility until we remove DES support
-     * since it does not hurt either.
-     */
-    for (int i = 0; i < 2; ++i)
-    {
-        fixup_key(&key2->keys[i], &session->opt->key_type);
-    }
     key2->n = 2;
 
     return true;
-- 
2.33.0


