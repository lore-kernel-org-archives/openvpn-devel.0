From: Gert Doering <gert@...1296...>
Date: Wed, 15 May 2024 12:01:15 +0200
Message-ID: <20240515100115.11056-1-gert@...1296...>
In-Reply-To: <gerrit.1714407751000.I5bfa3630ad4dff2807705658bc877c4a429a39ce@...2715...>
References: <gerrit.1714407751000.I5bfa3630ad4dff2807705658bc877c4a429a39ce@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] Remove custom TLS 1.0 PRF implementation
 only used by LibreSSL/wolfSSL
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

After the removal of the OpenSSL 1.0.2 support, LibreSSL/wolfSSL are the
only libraries that still needs the custom implementation.

Since our LibreSSL/wolfSSL support is always best effort, we can afford to
limit LibreSSL support in this way. If they want to support this, they
should expose the functionality as well.

Change-Id: I5bfa3630ad4dff2807705658bc877c4a429a39ce
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/560
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index 0473fad..fbd38f3 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -1397,7 +1397,7 @@
 
     return ret;
 }
-#elif !defined(LIBRESSL_VERSION_NUMBER)
+#elif !defined(LIBRESSL_VERSION_NUMBER) && !defined(ENABLE_CRYPTO_WOLFSSL)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
@@ -1444,183 +1444,14 @@
     return ret;
 }
 #else  /* if defined(LIBRESSL_VERSION_NUMBER) */
-/*
- * Generate the hash required by for the \c tls1_PRF function.
- *
- * We cannot use our normal hmac_* function as they do not work
- * in a FIPS environment (no MD5 allowed, which we need). Instead
- * we need to directly use the EVP_MD_* API with the special
- * EVP_MD_CTX_FLAG_NON_FIPS_ALLOW flag.
- *
- * The function below is adapted from OpenSSL 1.0.2t
- *
- * @param md_kt         Message digest to use
- * @param sec           Secret to base the hash on
- * @param sec_len       Length of the secret
- * @param seed          Seed to hash
- * @param seed_len      Length of the seed
- * @param out           Output buffer
- * @param olen          Length of the output buffer
- */
-static
-bool
-tls1_P_hash(const EVP_MD *md, const unsigned char *sec,
-            int sec_len, const void *seed, int seed_len,
-            unsigned char *out, int olen)
-{
-    int chunk;
-    size_t j;
-    EVP_MD_CTX *ctx, *ctx_tmp, *ctx_init;
-    EVP_PKEY *mac_key;
-    unsigned char A1[EVP_MAX_MD_SIZE];
-    size_t A1_len = EVP_MAX_MD_SIZE;
-    int ret = false;
-
-    chunk = EVP_MD_size(md);
-    OPENSSL_assert(chunk >= 0);
-
-    ctx = md_ctx_new();
-    ctx_tmp = md_ctx_new();
-    ctx_init = md_ctx_new();
-    EVP_MD_CTX_set_flags(ctx_init, EVP_MD_CTX_FLAG_NON_FIPS_ALLOW);
-    mac_key = EVP_PKEY_new_mac_key(EVP_PKEY_HMAC, NULL, sec, sec_len);
-    if (!mac_key)
-    {
-        goto err;
-    }
-    if (!EVP_DigestSignInit(ctx_init, NULL, md, NULL, mac_key))
-    {
-        goto err;
-    }
-    if (!EVP_MD_CTX_copy_ex(ctx, ctx_init))
-    {
-        goto err;
-    }
-    if (!EVP_DigestSignUpdate(ctx, seed, seed_len))
-    {
-        goto err;
-    }
-    if (!EVP_DigestSignFinal(ctx, A1, &A1_len))
-    {
-        goto err;
-    }
-
-    for (;; )
-    {
-        /* Reinit mac contexts */
-        if (!EVP_MD_CTX_copy_ex(ctx, ctx_init))
-        {
-            goto err;
-        }
-        if (!EVP_DigestSignUpdate(ctx, A1, A1_len))
-        {
-            goto err;
-        }
-        if (olen > chunk && !EVP_MD_CTX_copy_ex(ctx_tmp, ctx))
-        {
-            goto err;
-        }
-        if (!EVP_DigestSignUpdate(ctx, seed, seed_len))
-        {
-            goto err;
-        }
-
-        if (olen > chunk)
-        {
-            j = olen;
-            if (!EVP_DigestSignFinal(ctx, out, &j))
-            {
-                goto err;
-            }
-            out += j;
-            olen -= j;
-            /* calc the next A1 value */
-            if (!EVP_DigestSignFinal(ctx_tmp, A1, &A1_len))
-            {
-                goto err;
-            }
-        }
-        else
-        {
-            A1_len = EVP_MAX_MD_SIZE;
-            /* last one */
-            if (!EVP_DigestSignFinal(ctx, A1, &A1_len))
-            {
-                goto err;
-            }
-            memcpy(out, A1, olen);
-            break;
-        }
-    }
-    ret = true;
-err:
-    EVP_PKEY_free(mac_key);
-    EVP_MD_CTX_free(ctx);
-    EVP_MD_CTX_free(ctx_tmp);
-    EVP_MD_CTX_free(ctx_init);
-    OPENSSL_cleanse(A1, sizeof(A1));
-    return ret;
-}
-
-/*
- * Use the TLS PRF function for generating data channel keys.
- * This code is based on the OpenSSL library.
- *
- * TLS generates keys as such:
- *
- * master_secret[48] = PRF(pre_master_secret[48], "master secret",
- *                         ClientHello.random[32] + ServerHello.random[32])
- *
- * key_block[] = PRF(SecurityParameters.master_secret[48],
- *                 "key expansion",
- *                 SecurityParameters.server_random[32] +
- *                 SecurityParameters.client_random[32]);
- *
- * Notes:
- *
- * (1) key_block contains a full set of 4 keys.
- * (2) The pre-master secret is generated by the client.
- */
+/* LibreSSL and wolfSSL do not expose a TLS 1.0/1.1 PRF via the same APIs as
+ * OpenSSL does. As result they will only be able to support
+ * peers that support TLS EKM like when running with OpenSSL 3.x FIPS */
 bool
 ssl_tls1_PRF(const uint8_t *label, int label_len, const uint8_t *sec,
              int slen, uint8_t *out1, int olen)
 {
-    bool ret = true;
-    struct gc_arena gc = gc_new();
-    /* For some reason our md_get("MD5") fails otherwise in the unit test */
-    const EVP_MD *md5 = EVP_md5();
-    const EVP_MD *sha1 = EVP_sha1();
-
-    uint8_t *out2 = (uint8_t *)gc_malloc(olen, false, &gc);
-
-    int len = slen/2;
-    const uint8_t *S1 = sec;
-    const uint8_t *S2 = &(sec[len]);
-    len += (slen&1); /* add for odd, make longer */
-
-    if (!tls1_P_hash(md5, S1, len, label, label_len, out1, olen))
-    {
-        ret = false;
-        goto done;
-    }
-
-    if (!tls1_P_hash(sha1, S2, len, label, label_len, out2, olen))
-    {
-        ret = false;
-        goto done;
-    }
-
-    for (int i = 0; i < olen; i++)
-    {
-        out1[i] ^= out2[i];
-    }
-
-    secure_memzero(out2, olen);
-
-    dmsg(D_SHOW_KEY_SOURCE, "tls1_PRF out[%d]: %s", olen, format_hex(out1, olen, 0, &gc));
-done:
-    gc_free(&gc);
-    return ret;
+    return false;
 }
 #endif /* if LIBRESSL_VERSION_NUMBER */
 #endif /* ENABLE_CRYPTO_OPENSSL */
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 01c16c9..9d3ea1a 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -137,11 +137,6 @@
 }
 
 
-static uint8_t good_prf[32] = {0xd9, 0x8c, 0x85, 0x18, 0xc8, 0x5e, 0x94, 0x69,
-                               0x27, 0x91, 0x6a, 0xcf, 0xc2, 0xd5, 0x92, 0xfb,
-                               0xb1, 0x56, 0x7e, 0x4b, 0x4b, 0x14, 0x59, 0xe6,
-                               0xa9, 0x04, 0xac, 0x2d, 0xda, 0xb7, 0x2d, 0x67};
-
 static const char *ipsumlorem = "Lorem ipsum dolor sit amet, consectetur "
                                 "adipisici elit, sed eiusmod tempor incidunt "
                                 "ut labore et dolore magna aliqua.";
@@ -160,9 +155,19 @@
 
 
     uint8_t out[32];
-    ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(out));
+    bool ret = ssl_tls1_PRF(seed, seed_len, secret, secret_len, out, sizeof(out));
 
+#if defined(LIBRESSL_VERSION_NUMBER) || defined(ENABLE_CRYPTO_WOLFSSL)
+    /* No TLS1 PRF support in these libraries */
+    assert_false(ret);
+#else
+    assert_true(ret);
+    uint8_t good_prf[32] = {0xd9, 0x8c, 0x85, 0x18, 0xc8, 0x5e, 0x94, 0x69,
+                            0x27, 0x91, 0x6a, 0xcf, 0xc2, 0xd5, 0x92, 0xfb,
+                            0xb1, 0x56, 0x7e, 0x4b, 0x4b, 0x14, 0x59, 0xe6,
+                            0xa9, 0x04, 0xac, 0x2d, 0xda, 0xb7, 0x2d, 0x67};
     assert_memory_equal(good_prf, out, sizeof(out));
+#endif
 }
 
 static uint8_t testkey[20] = {0x0b, 0x00};

