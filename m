From: Gert Doering <gert@...1296...>
Date: Sat, 30 Dec 2023 15:37:33 +0100
Message-ID: <20231230143733.4426-1-gert@...1296...>
In-Reply-To: <gerrit.1699031887000.I0dcb2dac4136f194da7050a8ea8495e9faba9dd9@...2715...>
References: <gerrit.1699031887000.I0dcb2dac4136f194da7050a8ea8495e9faba9dd9@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Remove support for NTLM v1 proxy
 authentication
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

Due to the limitation of the protocol it is not
considered secure. Better to use basic auth instead
of a false sense of security. NTLM v2 remains
supported for now.

Change-Id: I0dcb2dac4136f194da7050a8ea8495e9faba9dd9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/379
This mail reflects revision 4 of this Change.
Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy-options.rst
index 465bea0..3fb1060 100644
--- a/doc/man-sections/proxy-options.rst
+++ b/doc/man-sections/proxy-options.rst
@@ -11,7 +11,7 @@
   ``--http-proxy-user-pass`` option. (See section on inline files)
 
   The last optional argument is an ``auth-method`` which should be one
-  of :code:`none`, :code:`basic`, or :code:`ntlm`.
+  of :code:`none`, :code:`basic`, or :code:`ntlm2`.
 
   HTTP Digest authentication is supported as well, but only via the
   :code:`auto` or :code:`auto-nct` flags (below).  This must replace
@@ -33,7 +33,9 @@
      http-proxy proxy.example.net 3128 authfile.txt
      http-proxy proxy.example.net 3128 stdin
      http-proxy proxy.example.net 3128 auto basic
-     http-proxy proxy.example.net 3128 auto-nct ntlm
+     http-proxy proxy.example.net 3128 auto-nct ntlm2
+
+  Note that support for NTLMv1 proxies was removed with OpenVPN 2.7.
 
 --http-proxy-option args
   Set extended HTTP proxy options. Requires an option ``type`` as argument
diff --git a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h
index 842e73e..a5371c8 100644
--- a/src/openvpn/crypto_backend.h
+++ b/src/openvpn/crypto_backend.h
@@ -157,17 +157,6 @@
  */
 int rand_bytes(uint8_t *output, int len);
 
-/**
- * Encrypt the given block, using DES ECB mode
- *
- * @param key           DES key to use.
- * @param src           Buffer containing the 8-byte source.
- * @param dst           Buffer containing the 8-byte destination
- */
-void cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
-                            unsigned char src[DES_KEY_LENGTH],
-                            unsigned char dst[DES_KEY_LENGTH]);
-
 /*
  *
  * Generic cipher key type functions
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index ad3439c..f4c1cd2 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -758,17 +758,6 @@
     return 1;
 }
 
-void
-cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
-                       unsigned char src[DES_KEY_LENGTH],
-                       unsigned char dst[DES_KEY_LENGTH])
-{
-    mbedtls_des_context ctx;
-
-    ASSERT(mbed_ok(mbedtls_des_setkey_enc(&ctx, key)));
-    ASSERT(mbed_ok(mbedtls_des_crypt_ecb(&ctx, src, dst)));
-}
-
 
 
 /*
diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_openssl.c
index fe1254f..e8ddf14 100644
--- a/src/openvpn/crypto_openssl.c
+++ b/src/openvpn/crypto_openssl.c
@@ -988,50 +988,6 @@
     return cipher_ctx_final(ctx, dst, dst_len);
 }
 
-void
-cipher_des_encrypt_ecb(const unsigned char key[DES_KEY_LENGTH],
-                       unsigned char src[DES_KEY_LENGTH],
-                       unsigned char dst[DES_KEY_LENGTH])
-{
-    /* We are using 3DES here with three times the same key to cheat
-     * and emulate DES as 3DES is better supported than DES */
-    EVP_CIPHER_CTX *ctx = EVP_CIPHER_CTX_new();
-    if (!ctx)
-    {
-        crypto_msg(M_FATAL, "%s: EVP_CIPHER_CTX_new() failed", __func__);
-    }
-
-    unsigned char key3[DES_KEY_LENGTH*3];
-    for (int i = 0; i < 3; i++)
-    {
-        memcpy(key3 + (i * DES_KEY_LENGTH), key, DES_KEY_LENGTH);
-    }
-
-    if (!EVP_EncryptInit_ex(ctx, EVP_des_ede3_ecb(), NULL, key3, NULL))
-    {
-        crypto_msg(M_FATAL, "%s: EVP_EncryptInit_ex() failed", __func__);
-    }
-
-    int len;
-
-    /* The EVP_EncryptFinal method will write to the dst+len pointer even
-     * though there is nothing to encrypt anymore, provide space for that to
-     * not overflow the stack */
-    unsigned char dst2[DES_KEY_LENGTH * 2];
-    if (!EVP_EncryptUpdate(ctx, dst2, &len, src, DES_KEY_LENGTH))
-    {
-        crypto_msg(M_FATAL, "%s: EVP_EncryptUpdate() failed", __func__);
-    }
-
-    if (!EVP_EncryptFinal(ctx, dst2 + len, &len))
-    {
-        crypto_msg(M_FATAL, "%s: EVP_EncryptFinal() failed", __func__);
-    }
-
-    memcpy(dst, dst2, DES_KEY_LENGTH);
-
-    EVP_CIPHER_CTX_free(ctx);
-}
 
 /*
  *
diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c
index 2e77214..bc33f41 100644
--- a/src/openvpn/ntlm.c
+++ b/src/openvpn/ntlm.c
@@ -55,19 +55,6 @@
 
 
 static void
-create_des_keys(const unsigned char *hash, unsigned char *key)
-{
-    key[0] = hash[0];
-    key[1] = ((hash[0] & 1) << 7) | (hash[1] >> 1);
-    key[2] = ((hash[1] & 3) << 6) | (hash[2] >> 2);
-    key[3] = ((hash[2] & 7) << 5) | (hash[3] >> 3);
-    key[4] = ((hash[3] & 15) << 4) | (hash[4] >> 4);
-    key[5] = ((hash[4] & 31) << 3) | (hash[5] >> 5);
-    key[6] = ((hash[5] & 63) << 2) | (hash[6] >> 6);
-    key[7] = ((hash[6] & 127) << 1);
-}
-
-static void
 gen_md4_hash(const uint8_t *data, int data_len, uint8_t *result)
 {
     /* result is 16 byte md4 hash */
@@ -210,7 +197,7 @@
     uint8_t phase3[464];
 
     uint8_t md4_hash[MD4_DIGEST_LENGTH + 5];
-    uint8_t challenge[8], ntlm_response[24];
+    uint8_t challenge[8];
     int i, ret_val;
 
     uint8_t ntlmv2_response[144];
@@ -227,8 +214,6 @@
     char username[128];
     char *separator;
 
-    bool ntlmv2_enabled = (p->auth_method == HTTP_AUTH_NTLM2);
-
     ASSERT(strlen(p->up.username) > 0);
     ASSERT(strlen(p->up.password) > 0);
 
@@ -282,126 +267,102 @@
         challenge[i] = buf2[i+24];
     }
 
-    if (ntlmv2_enabled)      /* Generate NTLMv2 response */
+    /* Generate NTLMv2 response */
+    int tib_len;
+
+    /* NTLMv2 hash */
+    strcpy(userdomain, username);
+    my_strupr(userdomain);
+    if (strlen(username) + strlen(domain) < sizeof(userdomain))
     {
-        int tib_len;
-
-        /* NTLMv2 hash */
-        strcpy(userdomain, username);
-        my_strupr(userdomain);
-        if (strlen(username) + strlen(domain) < sizeof(userdomain))
-        {
-            strcat(userdomain, domain);
-        }
-        else
-        {
-            msg(M_INFO, "Warning: Username or domain too long");
-        }
-        unicodize(userdomain_u, userdomain);
-        gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_hash,
-                     ntlmv2_hash);
-
-        /* NTLMv2 Blob */
-        memset(ntlmv2_blob, 0, 128);                        /* Clear blob buffer */
-        ntlmv2_blob[0x00] = 1;                              /* Signature */
-        ntlmv2_blob[0x01] = 1;                              /* Signature */
-        ntlmv2_blob[0x04] = 0;                              /* Reserved */
-        gen_timestamp(&ntlmv2_blob[0x08]);                  /* 64-bit Timestamp */
-        gen_nonce(&ntlmv2_blob[0x10]);                      /* 64-bit Client Nonce */
-        ntlmv2_blob[0x18] = 0;                              /* Unknown, zero should work */
-
-        /* Add target information block to the blob */
-
-        /* Check for Target Information block */
-        /* The NTLM spec instructs to interpret these 4 consecutive bytes as a
-         * 32bit long integer. However, no endianness is specified.
-         * The code here and that found in other NTLM implementations point
-         * towards the assumption that the byte order on the wire has to
-         * match the order on the sending and receiving hosts. Probably NTLM has
-         * been thought to be always running on x86_64/i386 machine thus
-         * implying Little-Endian everywhere.
-         *
-         * This said, in case of future changes, we should keep in mind that the
-         * byte order on the wire for the NTLM header is LE.
-         */
-        const size_t hoff = 0x14;
-        unsigned long flags = buf2[hoff] | (buf2[hoff + 1] << 8)
-                              |(buf2[hoff + 2] << 16) | (buf2[hoff + 3] << 24);
-        if ((flags & 0x00800000) == 0x00800000)
-        {
-            tib_len = buf2[0x28];            /* Get Target Information block size */
-            if (tib_len > 96)
-            {
-                tib_len = 96;
-            }
-
-            {
-                uint8_t *tib_ptr;
-                uint8_t tib_pos = buf2[0x2c];
-                if (tib_pos + tib_len > sizeof(buf2))
-                {
-                    return NULL;
-                }
-                /* Get Target Information block pointer */
-                tib_ptr = buf2 + tib_pos;
-                /* Copy Target Information block into the blob */
-                memcpy(&ntlmv2_blob[0x1c], tib_ptr, tib_len);
-            }
-        }
-        else
-        {
-            tib_len = 0;
-        }
-
-        /* Unknown, zero works */
-        ntlmv2_blob[0x1c + tib_len] = 0;
-
-        /* Get blob length */
-        ntlmv2_blob_size = 0x20 + tib_len;
-
-        /* Add challenge from message 2 */
-        memcpy(&ntlmv2_response[8], challenge, 8);
-
-        /* hmac-md5 */
-        gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_hash,
-                     ntlmv2_hmacmd5);
-
-        /* Add hmac-md5 result to the blob.
-         * Note: This overwrites challenge previously written at
-         * ntlmv2_response[8..15] */
-        memcpy(ntlmv2_response, ntlmv2_hmacmd5, MD5_DIGEST_LENGTH);
+        strcat(userdomain, domain);
     }
-    else /* Generate NTLM response */
+    else
     {
-        unsigned char key1[DES_KEY_LENGTH], key2[DES_KEY_LENGTH];
-        unsigned char key3[DES_KEY_LENGTH];
+        msg(M_INFO, "Warning: Username or domain too long");
+    }
+    unicodize(userdomain_u, userdomain);
+    gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_hash,
+                 ntlmv2_hash);
 
-        create_des_keys(md4_hash, key1);
-        cipher_des_encrypt_ecb(key1, challenge, ntlm_response);
+    /* NTLMv2 Blob */
+    memset(ntlmv2_blob, 0, 128);                        /* Clear blob buffer */
+    ntlmv2_blob[0x00] = 1;                              /* Signature */
+    ntlmv2_blob[0x01] = 1;                              /* Signature */
+    ntlmv2_blob[0x04] = 0;                              /* Reserved */
+    gen_timestamp(&ntlmv2_blob[0x08]);                  /* 64-bit Timestamp */
+    gen_nonce(&ntlmv2_blob[0x10]);                      /* 64-bit Client Nonce */
+    ntlmv2_blob[0x18] = 0;                              /* Unknown, zero should work */
 
-        create_des_keys(&md4_hash[DES_KEY_LENGTH - 1], key2);
-        cipher_des_encrypt_ecb(key2, challenge, &ntlm_response[DES_KEY_LENGTH]);
+    /* Add target information block to the blob */
 
-        create_des_keys(&md4_hash[2 * (DES_KEY_LENGTH - 1)], key3);
-        cipher_des_encrypt_ecb(key3, challenge,
-                               &ntlm_response[DES_KEY_LENGTH * 2]);
+    /* Check for Target Information block */
+    /* The NTLM spec instructs to interpret these 4 consecutive bytes as a
+     * 32bit long integer. However, no endianness is specified.
+     * The code here and that found in other NTLM implementations point
+     * towards the assumption that the byte order on the wire has to
+     * match the order on the sending and receiving hosts. Probably NTLM has
+     * been thought to be always running on x86_64/i386 machine thus
+     * implying Little-Endian everywhere.
+     *
+     * This said, in case of future changes, we should keep in mind that the
+     * byte order on the wire for the NTLM header is LE.
+     */
+    const size_t hoff = 0x14;
+    unsigned long flags = buf2[hoff] | (buf2[hoff + 1] << 8)
+                          |(buf2[hoff + 2] << 16) | (buf2[hoff + 3] << 24);
+    if ((flags & 0x00800000) == 0x00800000)
+    {
+        tib_len = buf2[0x28];            /* Get Target Information block size */
+        if (tib_len > 96)
+        {
+            tib_len = 96;
+        }
+
+        {
+            uint8_t *tib_ptr;
+            uint8_t tib_pos = buf2[0x2c];
+            if (tib_pos + tib_len > sizeof(buf2))
+            {
+                return NULL;
+            }
+            /* Get Target Information block pointer */
+            tib_ptr = buf2 + tib_pos;
+            /* Copy Target Information block into the blob */
+            memcpy(&ntlmv2_blob[0x1c], tib_ptr, tib_len);
+        }
+    }
+    else
+    {
+        tib_len = 0;
     }
 
+    /* Unknown, zero works */
+    ntlmv2_blob[0x1c + tib_len] = 0;
+
+    /* Get blob length */
+    ntlmv2_blob_size = 0x20 + tib_len;
+
+    /* Add challenge from message 2 */
+    memcpy(&ntlmv2_response[8], challenge, 8);
+
+    /* hmac-md5 */
+    gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_hash,
+                 ntlmv2_hmacmd5);
+
+    /* Add hmac-md5 result to the blob.
+     * Note: This overwrites challenge previously written at
+     * ntlmv2_response[8..15] */
+    memcpy(ntlmv2_response, ntlmv2_hmacmd5, MD5_DIGEST_LENGTH);
 
     memset(phase3, 0, sizeof(phase3));       /* clear reply */
 
     strcpy((char *)phase3, "NTLMSSP\0");      /* signature */
     phase3[8] = 3;     /* type 3 */
 
-    if (ntlmv2_enabled)      /* NTLMv2 response */
-    {
-        add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,
-                            phase3, &phase3_bufpos);
-    }
-    else       /* NTLM response */
-    {
-        add_security_buffer(0x14, ntlm_response, 24, phase3, &phase3_bufpos);
-    }
+    /* NTLMv2 response */
+    add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,
+                        phase3, &phase3_bufpos);
 
     /* username in ascii */
     add_security_buffer(0x24, username, strlen(username), phase3,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f692532..c0e15e5 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -144,7 +144,7 @@
     "                  through an HTTP proxy at address s and port p.\n"
     "                  If proxy authentication is required,\n"
     "                  up is a file containing username/password on 2 lines, or\n"
-    "                  'stdin' to prompt from console.  Add auth='ntlm' if\n"
+    "                  'stdin' to prompt from console.  Add auth='ntlm2' if\n"
     "                  the proxy requires NTLM authentication.\n"
     "--http-proxy s p 'auto[-nct]' : Like the above directive, but automatically\n"
     "                  determine auth method and query for username/password\n"
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 3b6f7df..5a1b4e1 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -354,7 +354,7 @@
             {
                 msg(D_PROXY, "PROXY AUTH NTLM: '%s'", buf);
                 *data = NULL;
-                ret = HTTP_AUTH_NTLM;
+                ret = HTTP_AUTH_NTLM2;
             }
 #endif
         }
@@ -517,9 +517,7 @@
 #if NTLM
         else if (!strcmp(o->auth_method_string, "ntlm"))
         {
-            msg(M_INFO, "NTLM v1 authentication is deprecated and will be removed in "
-                "OpenVPN 2.7");
-            p->auth_method = HTTP_AUTH_NTLM;
+            msg(M_FATAL, "ERROR: NTLM v1 support has been removed. For now, you can use NTLM v2 by selecting ntlm2 but it is deprecated as well.");
         }
         else if (!strcmp(o->auth_method_string, "ntlm2"))
         {
@@ -534,13 +532,13 @@
     }
 
     /* only basic and NTLM/NTLMv2 authentication supported so far */
-    if (p->auth_method == HTTP_AUTH_BASIC || p->auth_method == HTTP_AUTH_NTLM || p->auth_method == HTTP_AUTH_NTLM2)
+    if (p->auth_method == HTTP_AUTH_BASIC || p->auth_method == HTTP_AUTH_NTLM2)
     {
         get_user_pass_http(p, true);
     }
 
 #if !NTLM
-    if (p->auth_method == HTTP_AUTH_NTLM || p->auth_method == HTTP_AUTH_NTLM2)
+    if (p->auth_method == HTTP_AUTH_NTLM2)
     {
         msg(M_FATAL, "Sorry, this version of " PACKAGE_NAME " was built without NTLM Proxy support.");
     }
@@ -646,8 +644,7 @@
 
     /* get user/pass if not previously given */
     if (p->auth_method == HTTP_AUTH_BASIC
-        || p->auth_method == HTTP_AUTH_DIGEST
-        || p->auth_method == HTTP_AUTH_NTLM)
+        || p->auth_method == HTTP_AUTH_DIGEST)
     {
         get_user_pass_http(p, false);
     }
@@ -697,7 +694,6 @@
                 break;
 
 #if NTLM
-            case HTTP_AUTH_NTLM:
             case HTTP_AUTH_NTLM2:
                 /* keep-alive connection */
                 openvpn_snprintf(buf, sizeof(buf), "Proxy-Connection: Keep-Alive");
@@ -752,7 +748,7 @@
         {
             processed = true;
         }
-        else if ((p->auth_method == HTTP_AUTH_NTLM || p->auth_method == HTTP_AUTH_NTLM2) && !processed) /* check for NTLM */
+        else if ((p->auth_method == HTTP_AUTH_NTLM2) && !processed) /* check for NTLM */
         {
 #if NTLM
             /* look for the phase 2 response */
diff --git a/src/openvpn/proxy.h b/src/openvpn/proxy.h
index 83b799e..7900244 100644
--- a/src/openvpn/proxy.h
+++ b/src/openvpn/proxy.h
@@ -31,7 +31,7 @@
 #define HTTP_AUTH_NONE   0
 #define HTTP_AUTH_BASIC  1
 #define HTTP_AUTH_DIGEST 2
-#define HTTP_AUTH_NTLM   3
+/* #define HTTP_AUTH_NTLM   3 removed in OpenVPN 2.7 */
 #define HTTP_AUTH_NTLM2  4
 #define HTTP_AUTH_N      5 /* number of HTTP_AUTH methods */
 
diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c
index 5564524..edca861 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -211,29 +211,6 @@
     hmac_ctx_free(hmac);
 }
 
-void
-test_des_encrypt(void **state)
-{
-    /* We have a small des encrypt method that is only for NTLMv1. This unit
-     * test ensures that it is not accidentally broken */
-
-    const unsigned char des_key[DES_KEY_LENGTH] = {0x42, 0x23};
-
-    const char *src = "MoinWelt";
-
-    /* cipher_des_encrypt_ecb wants a non const */
-    unsigned char *src2 = (unsigned char *) strdup(src);
-
-    unsigned char dst[DES_KEY_LENGTH];
-    cipher_des_encrypt_ecb(des_key, src2, dst);
-
-    const unsigned char dst_good[DES_KEY_LENGTH] = {0xd3, 0x8f, 0x61, 0xf7, 0xbe, 0x27, 0xb6, 0xa2};
-
-    assert_memory_equal(dst, dst_good, DES_KEY_LENGTH);
-
-    free(src2);
-}
-
 /* This test is in test_crypto as it calls into the functions that calculate
  * the crypto overhead */
 static void
@@ -474,7 +451,6 @@
         cmocka_unit_test(crypto_translate_cipher_names),
         cmocka_unit_test(crypto_test_tls_prf),
         cmocka_unit_test(crypto_test_hmac),
-        cmocka_unit_test(test_des_encrypt),
         cmocka_unit_test(test_occ_mtu_calculation),
         cmocka_unit_test(test_mssfix_mtu_calculation)
     };

