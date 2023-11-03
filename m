From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 3 Nov 2023 17:18:12 +0000
References: <gerrit.1699031887000.I0dcb2dac4136f194da7050a8ea8495e9faba9dd9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2011f1ff33bbe2e5e215e29db9ab1ca62d21a992-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="px+PxFA3V7M="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove support for
 NTLM v1 proxy authentication
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--px+PxFA3V7M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/379?usp=3Demail

to review the following change.


Change subject: Remove support for NTLM v1 proxy authentication
......................................................................

Remove support for NTLM v1 proxy authentication

Due to the limitation of the protocol it is not
considered secure. Better to use basic auth instead
of a false sense of security. NTLM v2 remains
supported for now.

Change-Id: I0dcb2dac4136f194da7050a8ea8495e9faba9dd9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M doc/man-sections/proxy-options.rst
M src/openvpn/crypto_backend.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_openssl.c
M src/openvpn/ntlm.c
M src/openvpn/options.c
M src/openvpn/proxy.c
M src/openvpn/proxy.h
M tests/unit_tests/openvpn/test_crypto.c
9 files changed, 95 insertions(+), 225 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/79/379/1

diff --git a/doc/man-sections/proxy-options.rst b/doc/man-sections/proxy-op=
tions.rst
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
index aaf6ef7..ea52f0c 100644
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
-    EVP_CIPHER_CTX *ctx =3D EVP_CIPHER_CTX_new();
-    if (!ctx)
-    {
-        crypto_msg(M_FATAL, "%s: EVP_CIPHER_CTX_new() failed", __func__);
-    }
-
-    unsigned char key3[DES_KEY_LENGTH*3];
-    for (int i =3D 0; i < 3; i++)
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
-     * though there is nothing to encrypt anymore, provide space for that =
to
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
-    key[0] =3D hash[0];
-    key[1] =3D ((hash[0] & 1) << 7) | (hash[1] >> 1);
-    key[2] =3D ((hash[1] & 3) << 6) | (hash[2] >> 2);
-    key[3] =3D ((hash[2] & 7) << 5) | (hash[3] >> 3);
-    key[4] =3D ((hash[3] & 15) << 4) | (hash[4] >> 4);
-    key[5] =3D ((hash[4] & 31) << 3) | (hash[5] >> 5);
-    key[6] =3D ((hash[5] & 63) << 2) | (hash[6] >> 6);
-    key[7] =3D ((hash[6] & 127) << 1);
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

-    bool ntlmv2_enabled =3D (p->auth_method =3D=3D HTTP_AUTH_NTLM2);
-
     ASSERT(strlen(p->up.username) > 0);
     ASSERT(strlen(p->up.password) > 0);

@@ -282,126 +267,102 @@
         challenge[i] =3D buf2[i+24];
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
-        gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain), md4_=
hash,
-                     ntlmv2_hash);
-
-        /* NTLMv2 Blob */
-        memset(ntlmv2_blob, 0, 128);                        /* Clear blob =
buffer */
-        ntlmv2_blob[0x00] =3D 1;                              /* Signature=
 */
-        ntlmv2_blob[0x01] =3D 1;                              /* Signature=
 */
-        ntlmv2_blob[0x04] =3D 0;                              /* Reserved =
*/
-        gen_timestamp(&ntlmv2_blob[0x08]);                  /* 64-bit Time=
stamp */
-        gen_nonce(&ntlmv2_blob[0x10]);                      /* 64-bit Clie=
nt Nonce */
-        ntlmv2_blob[0x18] =3D 0;                              /* Unknown, =
zero should work */
-
-        /* Add target information block to the blob */
-
-        /* Check for Target Information block */
-        /* The NTLM spec instructs to interpret these 4 consecutive bytes =
as a
-         * 32bit long integer. However, no endianness is specified.
-         * The code here and that found in other NTLM implementations point
-         * towards the assumption that the byte order on the wire has to
-         * match the order on the sending and receiving hosts. Probably NT=
LM has
-         * been thought to be always running on x86_64/i386 machine thus
-         * implying Little-Endian everywhere.
-         *
-         * This said, in case of future changes, we should keep in mind th=
at the
-         * byte order on the wire for the NTLM header is LE.
-         */
-        const size_t hoff =3D 0x14;
-        unsigned long flags =3D buf2[hoff] | (buf2[hoff + 1] << 8)
-                              |(buf2[hoff + 2] << 16) | (buf2[hoff + 3] <<=
 24);
-        if ((flags & 0x00800000) =3D=3D 0x00800000)
-        {
-            tib_len =3D buf2[0x28];            /* Get Target Information b=
lock size */
-            if (tib_len > 96)
-            {
-                tib_len =3D 96;
-            }
-
-            {
-                uint8_t *tib_ptr;
-                uint8_t tib_pos =3D buf2[0x2c];
-                if (tib_pos + tib_len > sizeof(buf2))
-                {
-                    return NULL;
-                }
-                /* Get Target Information block pointer */
-                tib_ptr =3D buf2 + tib_pos;
-                /* Copy Target Information block into the blob */
-                memcpy(&ntlmv2_blob[0x1c], tib_ptr, tib_len);
-            }
-        }
-        else
-        {
-            tib_len =3D 0;
-        }
-
-        /* Unknown, zero works */
-        ntlmv2_blob[0x1c + tib_len] =3D 0;
-
-        /* Get blob length */
-        ntlmv2_blob_size =3D 0x20 + tib_len;
-
-        /* Add challenge from message 2 */
-        memcpy(&ntlmv2_response[8], challenge, 8);
-
-        /* hmac-md5 */
-        gen_hmac_md5(&ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_has=
h,
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
+    memset(ntlmv2_blob, 0, 128);                        /* Clear blob buff=
er */
+    ntlmv2_blob[0x00] =3D 1;                              /* Signature */
+    ntlmv2_blob[0x01] =3D 1;                              /* Signature */
+    ntlmv2_blob[0x04] =3D 0;                              /* Reserved */
+    gen_timestamp(&ntlmv2_blob[0x08]);                  /* 64-bit Timestam=
p */
+    gen_nonce(&ntlmv2_blob[0x10]);                      /* 64-bit Client N=
once */
+    ntlmv2_blob[0x18] =3D 0;                              /* Unknown, zero=
 should work */

-        create_des_keys(&md4_hash[DES_KEY_LENGTH - 1], key2);
-        cipher_des_encrypt_ecb(key2, challenge, &ntlm_response[DES_KEY_LEN=
GTH]);
+    /* Add target information block to the blob */

-        create_des_keys(&md4_hash[2 * (DES_KEY_LENGTH - 1)], key3);
-        cipher_des_encrypt_ecb(key3, challenge,
-                               &ntlm_response[DES_KEY_LENGTH * 2]);
+    /* Check for Target Information block */
+    /* The NTLM spec instructs to interpret these 4 consecutive bytes as a
+     * 32bit long integer. However, no endianness is specified.
+     * The code here and that found in other NTLM implementations point
+     * towards the assumption that the byte order on the wire has to
+     * match the order on the sending and receiving hosts. Probably NTLM h=
as
+     * been thought to be always running on x86_64/i386 machine thus
+     * implying Little-Endian everywhere.
+     *
+     * This said, in case of future changes, we should keep in mind that t=
he
+     * byte order on the wire for the NTLM header is LE.
+     */
+    const size_t hoff =3D 0x14;
+    unsigned long flags =3D buf2[hoff] | (buf2[hoff + 1] << 8)
+                          |(buf2[hoff + 2] << 16) | (buf2[hoff + 3] << 24);
+    if ((flags & 0x00800000) =3D=3D 0x00800000)
+    {
+        tib_len =3D buf2[0x28];            /* Get Target Information block=
 size */
+        if (tib_len > 96)
+        {
+            tib_len =3D 96;
+        }
+
+        {
+            uint8_t *tib_ptr;
+            uint8_t tib_pos =3D buf2[0x2c];
+            if (tib_pos + tib_len > sizeof(buf2))
+            {
+                return NULL;
+            }
+            /* Get Target Information block pointer */
+            tib_ptr =3D buf2 + tib_pos;
+            /* Copy Target Information block into the blob */
+            memcpy(&ntlmv2_blob[0x1c], tib_ptr, tib_len);
+        }
+    }
+    else
+    {
+        tib_len =3D 0;
     }

+    /* Unknown, zero works */
+    ntlmv2_blob[0x1c + tib_len] =3D 0;
+
+    /* Get blob length */
+    ntlmv2_blob_size =3D 0x20 + tib_len;
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
     phase3[8] =3D 3;     /* type 3 */

-    if (ntlmv2_enabled)      /* NTLMv2 response */
-    {
-        add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,
-                            phase3, &phase3_bufpos);
-    }
-    else       /* NTLM response */
-    {
-        add_security_buffer(0x14, ntlm_response, 24, phase3, &phase3_bufpo=
s);
-    }
+    /* NTLMv2 response */
+    add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,
+                        phase3, &phase3_bufpos);

     /* username in ascii */
     add_security_buffer(0x24, username, strlen(username), phase3,
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index fbf54ef..7aa8514 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -144,7 +144,7 @@
     "                  through an HTTP proxy at address s and port p.\n"
     "                  If proxy authentication is required,\n"
     "                  up is a file containing username/password on 2 line=
s, or\n"
-    "                  'stdin' to prompt from console.  Add auth=3D'ntlm' =
if\n"
+    "                  'stdin' to prompt from console.  Add auth=3D'ntlm2'=
 if\n"
     "                  the proxy requires NTLM authentication.\n"
     "--http-proxy s p 'auto[-nct]' : Like the above directive, but automat=
ically\n"
     "                  determine auth method and query for username/passwo=
rd\n"
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 3b6f7df..5a1b4e1 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -354,7 +354,7 @@
             {
                 msg(D_PROXY, "PROXY AUTH NTLM: '%s'", buf);
                 *data =3D NULL;
-                ret =3D HTTP_AUTH_NTLM;
+                ret =3D HTTP_AUTH_NTLM2;
             }
 #endif
         }
@@ -517,9 +517,7 @@
 #if NTLM
         else if (!strcmp(o->auth_method_string, "ntlm"))
         {
-            msg(M_INFO, "NTLM v1 authentication is deprecated and will be =
removed in "
-                "OpenVPN 2.7");
-            p->auth_method =3D HTTP_AUTH_NTLM;
+            msg(M_FATAL, "ERROR: NTLM v1 support has been removed. For now=
, you can use NTLM v2 by selecting ntlm2 but it is deprecated as well.");
         }
         else if (!strcmp(o->auth_method_string, "ntlm2"))
         {
@@ -534,13 +532,13 @@
     }

     /* only basic and NTLM/NTLMv2 authentication supported so far */
-    if (p->auth_method =3D=3D HTTP_AUTH_BASIC || p->auth_method =3D=3D HTT=
P_AUTH_NTLM || p->auth_method =3D=3D HTTP_AUTH_NTLM2)
+    if (p->auth_method =3D=3D HTTP_AUTH_BASIC || p->auth_method =3D=3D HTT=
P_AUTH_NTLM2)
     {
         get_user_pass_http(p, true);
     }

 #if !NTLM
-    if (p->auth_method =3D=3D HTTP_AUTH_NTLM || p->auth_method =3D=3D HTTP=
_AUTH_NTLM2)
+    if (p->auth_method =3D=3D HTTP_AUTH_NTLM2)
     {
         msg(M_FATAL, "Sorry, this version of " PACKAGE_NAME " was built wi=
thout NTLM Proxy support.");
     }
@@ -646,8 +644,7 @@

     /* get user/pass if not previously given */
     if (p->auth_method =3D=3D HTTP_AUTH_BASIC
-        || p->auth_method =3D=3D HTTP_AUTH_DIGEST
-        || p->auth_method =3D=3D HTTP_AUTH_NTLM)
+        || p->auth_method =3D=3D HTTP_AUTH_DIGEST)
     {
         get_user_pass_http(p, false);
     }
@@ -697,7 +694,6 @@
                 break;

 #if NTLM
-            case HTTP_AUTH_NTLM:
             case HTTP_AUTH_NTLM2:
                 /* keep-alive connection */
                 openvpn_snprintf(buf, sizeof(buf), "Proxy-Connection: Keep=
-Alive");
@@ -752,7 +748,7 @@
         {
             processed =3D true;
         }
-        else if ((p->auth_method =3D=3D HTTP_AUTH_NTLM || p->auth_method =
=3D=3D HTTP_AUTH_NTLM2) && !processed) /* check for NTLM */
+        else if ((p->auth_method =3D=3D HTTP_AUTH_NTLM2) && !processed) /*=
 check for NTLM */
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

diff --git a/tests/unit_tests/openvpn/test_crypto.c b/tests/unit_tests/open=
vpn/test_crypto.c
index 5564524..3b5e451 100644
--- a/tests/unit_tests/openvpn/test_crypto.c
+++ b/tests/unit_tests/openvpn/test_crypto.c
@@ -211,29 +211,6 @@
     hmac_ctx_free(hmac);
 }

-void
-test_des_encrypt(void **state)
-{
-    /* We have a small des encrypt method that is only for NTLMv1. This un=
it
-     * test ensures that it is not accidentally broken */
-
-    const unsigned char des_key[DES_KEY_LENGTH] =3D {0x42, 0x23};
-
-    const char *src =3D "MoinWelt";
-
-    /* cipher_des_encrypt_ecb wants a non const */
-    unsigned char *src2 =3D (unsigned char *) strdup(src);
-
-    unsigned char dst[DES_KEY_LENGTH];
-    cipher_des_encrypt_ecb(des_key, src2, dst);
-
-    const unsigned char dst_good[DES_KEY_LENGTH] =3D {0xd3, 0x8f, 0x61, 0x=
f7, 0xbe, 0x27, 0xb6, 0xa2};
-
-    assert_memory_equal(dst, dst_good, DES_KEY_LENGTH);
-
-    free(src2);
-}
-
 /* This test is in test_crypto as it calls into the functions that calcula=
te
  * the crypto overhead */
 static void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/379?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0dcb2dac4136f194da7050a8ea8495e9faba9dd9
Gerrit-Change-Number: 379
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--px+PxFA3V7M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/379?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove support for NTLM v1 proxy authentication<br><br>Due to=
 the limitation of the protocol it is not<br>considered secure. Better to u=
se basic auth instead<br>of a false sense of security. NTLM v2 remains<br>s=
upported for now.<br><br>Change-Id: I0dcb2dac4136f194da7050a8ea8495e9faba9d=
d9<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M=
 doc/man-sections/proxy-options.rst<br>M src/openvpn/crypto_backend.h<br>M =
src/openvpn/crypto_mbedtls.c<br>M src/openvpn/crypto_openssl.c<br>M src/ope=
nvpn/ntlm.c<br>M src/openvpn/options.c<br>M src/openvpn/proxy.c<br>M src/op=
envpn/proxy.h<br>M tests/unit_tests/openvpn/test_crypto.c<br>9 files change=
d, 95 insertions(+), 225 deletions(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/79/379/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/man-sec=
tions/proxy-options.rst b/doc/man-sections/proxy-options.rst</span><br><spa=
n>index 465bea0..3fb1060 100644</span><br><span>--- a/doc/man-sections/prox=
y-options.rst</span><br><span>+++ b/doc/man-sections/proxy-options.rst</spa=
n><br><span>@@ -11,7 +11,7 @@</span><br><span>   ``--http-proxy-user-pass``=
 option. (See section on inline files)</span><br><span> </span><br><span>  =
 The last optional argument is an ``auth-method`` which should be one</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-  of :code:`none`, :code:`b=
asic`, or :code:`ntlm`.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  of :code:`none`, :code:`basic`, or :code:`ntlm2`.</span><br><span> </=
span><br><span>   HTTP Digest authentication is supported as well, but only=
 via the</span><br><span>   :code:`auto` or :code:`auto-nct` flags (below).=
  This must replace</span><br><span>@@ -33,7 +33,9 @@</span><br><span>     =
 http-proxy proxy.example.net 3128 authfile.txt</span><br><span>      http-=
proxy proxy.example.net 3128 stdin</span><br><span>      http-proxy proxy.e=
xample.net 3128 auto basic</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-     http-proxy proxy.example.net 3128 auto-nct ntlm</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     http-proxy proxy.example.net 312=
8 auto-nct ntlm2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+  Note that support fo=
r NTLMv1 proxies was removed with OpenVPN 2.7.</span><br><span> </span><br>=
<span> --http-proxy-option args</span><br><span>   Set extended HTTP proxy =
options. Requires an option ``type`` as argument</span><br><span>diff --git=
 a/src/openvpn/crypto_backend.h b/src/openvpn/crypto_backend.h</span><br><s=
pan>index 842e73e..a5371c8 100644</span><br><span>--- a/src/openvpn/crypto_=
backend.h</span><br><span>+++ b/src/openvpn/crypto_backend.h</span><br><spa=
n>@@ -157,17 +157,6 @@</span><br><span>  */</span><br><span> int rand_bytes=
(uint8_t *output, int len);</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * Encrypt the given block, using DES ECB mode</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @param key           DES key to use.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * @param src           Buffer containing t=
he 8-byte source.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @=
param dst           Buffer containing the 8-byte destination</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void cipher_des_encrypt_ecb(const unsigned char key[DE=
S_KEY_LENGTH],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                     unsigned char src[DES_KEY_LENGTH],</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                            unsigned char=
 dst[DES_KEY_LENGTH]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> /*</span><br><span>  *</span><br><span>  * Generic ciphe=
r key type functions</span><br><span>diff --git a/src/openvpn/crypto_mbedtl=
s.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index aaf6ef7..ea52f0c 1=
00644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><span>++=
+ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -758,17 +758,6 @@</span=
><br><span>     return 1;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-cipher_des_encrypt_ecb(const unsigned char key[DES_=
KEY_LENGTH],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
              unsigned char src[DES_KEY_LENGTH],</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                       unsigned char dst[DES_KEY=
_LENGTH])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    mbedtls_des_context ctx;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    ASSERT(mbed_ok(mbedtls_des_setkey_enc(&amp=
;ctx, key)));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSE=
RT(mbed_ok(mbedtls_des_crypt_ecb(&amp;ctx, src, dst)));</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span> </span><br><span> </span><br><span> /*</spa=
n><br><span>diff --git a/src/openvpn/crypto_openssl.c b/src/openvpn/crypto_=
openssl.c</span><br><span>index fe1254f..e8ddf14 100644</span><br><span>---=
 a/src/openvpn/crypto_openssl.c</span><br><span>+++ b/src/openvpn/crypto_op=
enssl.c</span><br><span>@@ -988,50 +988,6 @@</span><br><span>     return ci=
pher_ctx_final(ctx, dst, dst_len);</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-cipher_des_encrypt_ecb(const unsigned char=
 key[DES_KEY_LENGTH],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                       unsigned char src[DES_KEY_LENGTH],</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                       unsigned char ds=
t[DES_KEY_LENGTH])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* We are using 3DE=
S here with three times the same key to cheat</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     * and emulate DES as 3DES is better supported =
than DES */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    EVP_CI=
PHER_CTX *ctx =3D EVP_CIPHER_CTX_new();</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (!ctx)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  crypto_msg(M_FATAL, &quot;%s: EVP_CIPHER_CTX_new() failed&quot;, __func__=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    unsigned char key3[DES_KEY_LENGTH*3];</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 0; i &lt; 3; i++)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        memcpy(key3 + (i * DES_KEY_LE=
NGTH), key, DES_KEY_LENGTH);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!EVP_EncryptInit_ex(ct=
x, EVP_des_ede3_ecb(), NULL, key3, NULL))</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        crypto_msg(M_FATAL, &quot;%s: EVP_EncryptInit_ex() failed&quot;=
, __func__);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    int len;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   /* The EVP_EncryptFinal method will write to the dst+len pointer even</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-     * though there is n=
othing to encrypt anymore, provide space for that to</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-     * not overflow the stack */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    unsigned char dst2[DES_KEY_L=
ENGTH * 2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!E=
VP_EncryptUpdate(ctx, dst2, &amp;len, src, DES_KEY_LENGTH))</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        crypto_msg(M_FATAL, &quot;%s: EVP_EncryptUpda=
te() failed&quot;, __func__);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!EVP_EncryptFinal(ctx=
, dst2 + len, &amp;len))</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        crypt=
o_msg(M_FATAL, &quot;%s: EVP_EncryptFinal() failed&quot;, __func__);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    memcpy(dst, dst2, DES_KEY_LENGTH);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    EVP_CIPHER_CTX_free(ctx);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-}</span><br><span> </span><br><span> /*</span><br><span>  *<=
/span><br><span>diff --git a/src/openvpn/ntlm.c b/src/openvpn/ntlm.c</span>=
<br><span>index 2e77214..bc33f41 100644</span><br><span>--- a/src/openvpn/n=
tlm.c</span><br><span>+++ b/src/openvpn/ntlm.c</span><br><span>@@ -55,19 +5=
5,6 @@</span><br><span> </span><br><span> </span><br><span> static void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-create_des_keys(const uns=
igned char *hash, unsigned char *key)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
key[0] =3D hash[0];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  key[1] =3D ((hash[0] &amp; 1) &lt;&lt; 7) | (hash[1] &gt;&gt; 1);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    key[2] =3D ((hash[1] &amp=
; 3) &lt;&lt; 6) | (hash[2] &gt;&gt; 2);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    key[3] =3D ((hash[2] &amp; 7) &lt;&lt; 5) | (hash[3]=
 &gt;&gt; 3);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    key[=
4] =3D ((hash[3] &amp; 15) &lt;&lt; 4) | (hash[4] &gt;&gt; 4);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    key[5] =3D ((hash[4] &amp; 31)=
 &lt;&lt; 3) | (hash[5] &gt;&gt; 5);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    key[6] =3D ((hash[5] &amp; 63) &lt;&lt; 2) | (hash[6] &g=
t;&gt; 6);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    key[7] =
=3D ((hash[6] &amp; 127) &lt;&lt; 1);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><sp=
an> gen_md4_hash(const uint8_t *data, int data_len, uint8_t *result)</span>=
<br><span> {</span><br><span>     /* result is 16 byte md4 hash */</span><b=
r><span>@@ -210,7 +197,7 @@</span><br><span>     uint8_t phase3[464];</span=
><br><span> </span><br><span>     uint8_t md4_hash[MD4_DIGEST_LENGTH + 5];<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t challenge[=
8], ntlm_response[24];</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uint8_t challenge[8];</span><br><span>     int i, ret_val;</span><br=
><span> </span><br><span>     uint8_t ntlmv2_response[144];</span><br><span=
>@@ -227,8 +214,6 @@</span><br><span>     char username[128];</span><br><sp=
an>     char *separator;</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    bool ntlmv2_enabled =3D (p-&gt;auth_method =3D=3D =
HTTP_AUTH_NTLM2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     ASSERT(strlen(p-&gt;up.username) &gt; 0);</span><br><span=
>     ASSERT(strlen(p-&gt;up.password) &gt; 0);</span><br><span> </span><br=
><span>@@ -282,126 +267,102 @@</span><br><span>         challenge[i] =3D bu=
f2[i+24];</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (ntlmv2_enabled)      /* Generate NTLMv=
2 response */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*=
 Generate NTLMv2 response */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    int tib_len;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* NTLMv2=
 hash */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(=
userdomain, username);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    my_strupr(userdomain);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (strlen(username) + strlen(domain) &lt; sizeof(userdomain)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        int tib_len;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* NTLMv2 h=
ash */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        strcpy(=
userdomain, username);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        my_strupr(userdomain);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (strlen(username) + strlen(domain) &lt; sizeof(userdom=
ain))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            strcat(userdomai=
n, domain);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;Warning: User=
name or domain too long&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      unicodize(userdomain_u, userdomain);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        gen_hmac_md5((uint8_t *)userdomain_u, 2 * strl=
en(userdomain), md4_hash,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                     ntlmv2_hash);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* NTLMv2 Blob */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        memset(ntlmv2_blob, 0, 128);                        /* Clear blob b=
uffer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ntlmv=
2_blob[0x00] =3D 1;                              /* Signature */</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ntlmv2_blob[0x01] =3D 1;=
                              /* Signature */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        ntlmv2_blob[0x04] =3D 0;                   =
           /* Reserved */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        gen_timestamp(&amp;ntlmv2_blob[0x08]);                  /* 64-b=
it Timestamp */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  gen_nonce(&amp;ntlmv2_blob[0x10]);                      /* 64-bit Client =
Nonce */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ntlmv=
2_blob[0x18] =3D 0;                              /* Unknown, zero should wo=
rk */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* Add target information blo=
ck to the blob */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Check for Targ=
et Information block */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        /* The NTLM spec instructs to interpret these 4 consecutive bytes=
 as a</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * 32bit=
 long integer. However, no endianness is specified.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-         * The code here and that found in =
other NTLM implementations point</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-         * towards the assumption that the byte order on the wir=
e has to</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * ma=
tch the order on the sending and receiving hosts. Probably NTLM has</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-         * been thought to be=
 always running on x86_64/i386 machine thus</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-         * implying Little-Endian everywhere.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-         *</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-         * This said, in case of future =
changes, we should keep in mind that the</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-         * byte order on the wire for the NTLM header is=
 LE.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        const size_t hoff =
=3D 0x14;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        unsi=
gned long flags =3D buf2[hoff] | (buf2[hoff + 1] &lt;&lt; 8)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                              |(buf2=
[hoff + 2] &lt;&lt; 16) | (buf2[hoff + 3] &lt;&lt; 24);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if ((flags &amp; 0x00800000) =3D=
=3D 0x00800000)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tib_le=
n =3D buf2[0x28];            /* Get Target Information block size */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            if (tib_len &gt;=
 96)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                tib_len =
=3D 96;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                uint8_t *tib_ptr;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                uint8_t tib_pos =3D buf=
2[0x2c];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   if (tib_pos + tib_len &gt; sizeof(buf2))</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    return NULL;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                /* Get Target Information block po=
inter */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   tib_ptr =3D buf2 + tib_pos;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                /* Copy Target Information block into the blob */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                memcpy=
(&amp;ntlmv2_blob[0x1c], tib_ptr, tib_len);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tib_len=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /* Unknown, zero works */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        ntlmv2_blob[0x1c + tib_len]=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* Get blob length */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        ntlmv2_blob_size =
=3D 0x20 + tib_len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* Add challeng=
e from message 2 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      memcpy(&amp;ntlmv2_response[8], challenge, 8);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        /* hmac-md5 */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        gen_hmac_md5(&amp;ntlmv2_response[8], ntlmv2_blob_size =
+ 8, ntlmv2_hash,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                 ntlmv2_hmacmd5);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* Add hmac-md5 result to the blob.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-         * Note: This overwrites challenge previously written =
at</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * ntlmv2_r=
esponse[8..15] */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    memcpy(ntlmv2_response, ntlmv2_hmacmd5, MD5_DIGEST_LENGTH);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        strcat(userdomain, doma=
in);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else /* Generate NTLM response */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        unsigned char key1[DES_KEY_LENGTH=
], key2[DES_KEY_LENGTH];</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        unsigned char key3[DES_KEY_LENGTH];</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;Warning: Username or d=
omain too long&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unicodi=
ze(userdomain_u, userdomain);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    gen_hmac_md5((uint8_t *)userdomain_u, 2 * strlen(userdomain),=
 md4_hash,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
        ntlmv2_hash);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        create_des_keys(md4_hash, key1);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        cipher_des_encrypt_ecb(key1, c=
hallenge, ntlm_response);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* NTLMv2 Blob */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    memset(ntlmv2_blob, 0, 128);                        /* Clear bl=
ob buffer */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ntl=
mv2_blob[0x00] =3D 1;                              /* Signature */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    ntlmv2_blob[0x01] =3D 1;=
                              /* Signature */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ntlmv2_blob[0x04] =3D 0;                     =
         /* Reserved */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gen_timestamp(&amp;ntlmv2_blob[0x08]);                  /* 64-bit T=
imestamp */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gen_=
nonce(&amp;ntlmv2_blob[0x10]);                      /* 64-bit Client Nonce =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ntlmv2_blob[0=
x18] =3D 0;                              /* Unknown, zero should work */</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  create_des_keys(&amp;md4_hash[DES_KEY_LENGTH - 1], key2);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        cipher_des_encrypt_ecb(key2, =
challenge, &amp;ntlm_response[DES_KEY_LENGTH]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Add target information block to the blob=
 */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        create_des_keys(&amp;md4_hash[2 * (DES_KEY_LENGTH - 1)], key3);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        cipher_des_encryp=
t_ecb(key3, challenge,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                               &amp;ntlm_response[DES_KEY_LENGTH * 2]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check for Targe=
t Information block */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* The NTLM spec instructs to interpret these 4 consecutive bytes as=
 a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * 32bit long=
 integer. However, no endianness is specified.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+     * The code here and that found in other NTL=
M implementations point</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     * towards the assumption that the byte order on the wire has to</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * match the order=
 on the sending and receiving hosts. Probably NTLM has</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * been thought to be always running=
 on x86_64/i386 machine thus</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * implying Little-Endian everywhere.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     * This said, in case of future changes, we should ke=
ep in mind that the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
     * byte order on the wire for the NTLM header is LE.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const size_t hoff =3D 0x14;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    unsigned long flags =3D buf2[hoff]=
 | (buf2[hoff + 1] &lt;&lt; 8)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                          |(buf2[hoff + 2] &lt;&lt; 16) | (buf2[=
hoff + 3] &lt;&lt; 24);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if ((flags &amp; 0x00800000) =3D=3D 0x00800000)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        tib_len =3D buf2[0x28];            /* Get Tar=
get Information block size */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (tib_len &gt; 96)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            tib_len =3D 96;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            uint8_t *t=
ib_ptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
uint8_t tib_pos =3D buf2[0x2c];</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (tib_pos + tib_len &gt; sizeof(buf2))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                return NULL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            /* Get Target Informa=
tion block pointer */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            tib_ptr =3D buf2 + tib_pos;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            /* Copy Target Information block into the=
 blob */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 memcpy(&amp;ntlmv2_blob[0x1c], tib_ptr, tib_len);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tib_len =
=3D 0;</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Unknown, zero works */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ntlmv2_blob[0x1c + tib_len] =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* Get blob length */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ntlmv2_blob_size =3D 0x20 +=
 tib_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Add challenge from mes=
sage 2 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy=
(&amp;ntlmv2_response[8], challenge, 8);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* hmac-md5 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    gen_hmac_md5(&amp;ntlmv2_response[8], ntlmv2_blob_size + 8, ntlmv2_has=
h,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
ntlmv2_hmacmd5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Add hmac-md5 re=
sult to the blob.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
   * Note: This overwrites challenge previously written at</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * ntlmv2_response[8..15] */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(ntlmv2_respo=
nse, ntlmv2_hmacmd5, MD5_DIGEST_LENGTH);</span><br><span> </span><br><span>=
     memset(phase3, 0, sizeof(phase3));       /* clear reply */</span><br><=
span> </span><br><span>     strcpy((char *)phase3, &quot;NTLMSSP\0&quot;); =
     /* signature */</span><br><span>     phase3[8] =3D 3;     /* type 3 */=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 if (ntlmv2_enabled)      /* NTLMv2 response */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        add_security_buffer(0x14, ntlmv2_response, ntlmv2_blob_si=
ze + 16,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
               phase3, &amp;phase3_bufpos);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else       /* NTLM response */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        add_security_buffer(0x14, ntlm_response, 24, phase3, &amp;phase3=
_bufpos);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* NTLMv2 response */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    add_security_buf=
fer(0x14, ntlmv2_response, ntlmv2_blob_size + 16,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        phase3, &amp;phase3_b=
ufpos);</span><br><span> </span><br><span>     /* username in ascii */</spa=
n><br><span>     add_security_buffer(0x24, username, strlen(username), phas=
e3,</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/option=
s.c</span><br><span>index fbf54ef..7aa8514 100644</span><br><span>--- a/src=
/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><s=
pan>@@ -144,7 +144,7 @@</span><br><span>     &quot;                  throug=
h an HTTP proxy at address s and port p.\n&quot;</span><br><span>     &quot=
;                  If proxy authentication is required,\n&quot;</span><br><=
span>     &quot;                  up is a file containing username/password=
 on 2 lines, or\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    &quot;                  &#39;stdin&#39; to prompt from console.  Add =
auth=3D&#39;ntlm&#39; if\n&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    &quot;                  &#39;stdin&#39; to prompt from con=
sole.  Add auth=3D&#39;ntlm2&#39; if\n&quot;</span><br><span>     &quot;   =
               the proxy requires NTLM authentication.\n&quot;</span><br><s=
pan>     &quot;--http-proxy s p &#39;auto[-nct]&#39; : Like the above direc=
tive, but automatically\n&quot;</span><br><span>     &quot;                =
  determine auth method and query for username/password\n&quot;</span><br><=
span>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span=
>index 3b6f7df..5a1b4e1 100644</span><br><span>--- a/src/openvpn/proxy.c</s=
pan><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -354,7 +354,7 @@=
</span><br><span>             {</span><br><span>                 msg(D_PROX=
Y, &quot;PROXY AUTH NTLM: &#39;%s&#39;&quot;, buf);</span><br><span>       =
          *data =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                ret =3D HTTP_AUTH_NTLM;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                ret =3D HTTP_AUTH_NTLM2;</span><br>=
<span>             }</span><br><span> #endif</span><br><span>         }</sp=
an><br><span>@@ -517,9 +517,7 @@</span><br><span> #if NTLM</span><br><span>=
         else if (!strcmp(o-&gt;auth_method_string, &quot;ntlm&quot;))</spa=
n><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            msg(M_INFO, &quot;NTLM v1 authentication is deprecated and wil=
l be removed in &quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                &quot;OpenVPN 2.7&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            p-&gt;auth_method =3D HTTP_AUTH_NTLM;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(M_FATAL,=
 &quot;ERROR: NTLM v1 support has been removed. For now, you can use NTLM v=
2 by selecting ntlm2 but it is deprecated as well.&quot;);</span><br><span>=
         }</span><br><span>         else if (!strcmp(o-&gt;auth_method_stri=
ng, &quot;ntlm2&quot;))</span><br><span>         {</span><br><span>@@ -534,=
13 +532,13 @@</span><br><span>     }</span><br><span> </span><br><span>    =
 /* only basic and NTLM/NTLMv2 authentication supported so far */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (p-&gt;auth_method =3D=
=3D HTTP_AUTH_BASIC || p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM || p-&gt;aut=
h_method =3D=3D HTTP_AUTH_NTLM2)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (p-&gt;auth_method =3D=3D HTTP_AUTH_BASIC || p-&gt;auth=
_method =3D=3D HTTP_AUTH_NTLM2)</span><br><span>     {</span><br><span>    =
     get_user_pass_http(p, true);</span><br><span>     }</span><br><span> <=
/span><br><span> #if !NTLM</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM || p-&gt;auth_method =
=3D=3D HTTP_AUTH_NTLM2)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2)</span><br><span>     =
{</span><br><span>         msg(M_FATAL, &quot;Sorry, this version of &quot;=
 PACKAGE_NAME &quot; was built without NTLM Proxy support.&quot;);</span><b=
r><span>     }</span><br><span>@@ -646,8 +644,7 @@</span><br><span> </span>=
<br><span>     /* get user/pass if not previously given */</span><br><span>=
     if (p-&gt;auth_method =3D=3D HTTP_AUTH_BASIC</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        || p-&gt;auth_method =3D=3D HTTP_AUTH_D=
IGEST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        || p-&gt=
;auth_method =3D=3D HTTP_AUTH_NTLM)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        || p-&gt;auth_method =3D=3D HTTP_AUTH_DIGEST)</span=
><br><span>     {</span><br><span>         get_user_pass_http(p, false);</s=
pan><br><span>     }</span><br><span>@@ -697,7 +694,6 @@</span><br><span>  =
               break;</span><br><span> </span><br><span> #if NTLM</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            case HTTP_AUTH_NTLM=
:</span><br><span>             case HTTP_AUTH_NTLM2:</span><br><span>      =
           /* keep-alive connection */</span><br><span>                 ope=
nvpn_snprintf(buf, sizeof(buf), &quot;Proxy-Connection: Keep-Alive&quot;);<=
/span><br><span>@@ -752,7 +748,7 @@</span><br><span>         {</span><br><s=
pan>             processed =3D true;</span><br><span>         }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        else if ((p-&gt;auth_meth=
od =3D=3D HTTP_AUTH_NTLM || p-&gt;auth_method =3D=3D HTTP_AUTH_NTLM2) &amp;=
&amp; !processed) /* check for NTLM */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else if ((p-&gt;auth_method =3D=3D HTTP_AUTH_NTL=
M2) &amp;&amp; !processed) /* check for NTLM */</span><br><span>         {<=
/span><br><span> #if NTLM</span><br><span>             /* look for the phas=
e 2 response */</span><br><span>diff --git a/src/openvpn/proxy.h b/src/open=
vpn/proxy.h</span><br><span>index 83b799e..7900244 100644</span><br><span>-=
-- a/src/openvpn/proxy.h</span><br><span>+++ b/src/openvpn/proxy.h</span><b=
r><span>@@ -31,7 +31,7 @@</span><br><span> #define HTTP_AUTH_NONE   0</span=
><br><span> #define HTTP_AUTH_BASIC  1</span><br><span> #define HTTP_AUTH_D=
IGEST 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HTTP_A=
UTH_NTLM   3</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* #def=
ine HTTP_AUTH_NTLM   3 removed in OpenVPN 2.7 */</span><br><span> #define H=
TTP_AUTH_NTLM2  4</span><br><span> #define HTTP_AUTH_N      5 /* number of =
HTTP_AUTH methods */</span><br><span> </span><br><span>diff --git a/tests/u=
nit_tests/openvpn/test_crypto.c b/tests/unit_tests/openvpn/test_crypto.c</s=
pan><br><span>index 5564524..3b5e451 100644</span><br><span>--- a/tests/uni=
t_tests/openvpn/test_crypto.c</span><br><span>+++ b/tests/unit_tests/openvp=
n/test_crypto.c</span><br><span>@@ -211,29 +211,6 @@</span><br><span>     h=
mac_ctx_free(hmac);</span><br><span> }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-test_des_encrypt(void **state)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    /* We have a small des encrypt method that is only for NTLMv1. T=
his unit</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * test e=
nsures that it is not accidentally broken */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    const unsigned char des_key[DES_KEY_LENGTH] =3D {0x42, 0x23};</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    const char *src =3D &quot;MoinWelt&quot;;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    /* cipher_des_encrypt_ecb wants a non const=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned char =
*src2 =3D (unsigned char *) strdup(src);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  unsigned char dst[DES_KEY_LENGTH];</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    cipher_des_encrypt_ecb(des_key, src2, dst);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    const unsigned char dst_good[DES_KEY_LENGTH] =3D {0=
xd3, 0x8f, 0x61, 0xf7, 0xbe, 0x27, 0xb6, 0xa2};</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    assert_memory_equal(dst, dst_good, DES_KEY_LENGTH);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    free(src2);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> /* This test is in test_crypto as it calls into the functions tha=
t calculate</span><br><span>  * the crypto overhead */</span><br><span> sta=
tic void</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/379?usp=3Demail">change 379</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/379?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0dcb2dac4136f194da7050a8ea8=
495e9faba9dd9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 379 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--px+PxFA3V7M=--

