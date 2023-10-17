From: "MaxF (Code Review)" <gerrit@...515...>
Date: Tue, 17 Oct 2023 17:05:58 +0000
References: <gerrit.1697562354000.I445a93e84dc54b865b757038d22318ac427fce96@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <597e68a0e1061309eaea6d4d130be5985914da55-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hLL6RYwo6RU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add support for
 mbedtls 3.X.Y
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hLL6RYwo6RU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail

to review the following change.


Change subject: Add support for mbedtls 3.X.Y
......................................................................

Add support for mbedtls 3.X.Y

Most struct fields in mbedtls 3 are private and now need accessor
functions. Most of it was straightforward to adapt, but for two things
there were no accessor functions yet:

 * Netscape certificate type
 * key usage (you can check key usage, but not get the raw bytes)

I decided to remove Netscape certificate type checks when using OpenVPN
with mbedtls. The key usage bytes were printed in an error message, and
I removed that part from it.

Adding the random number functions to the load private key function may
look weird, but the purpose is to make side channels for elliptic curve
operations harder to exploit.

Also bumping the minimum mbed TLS version to 2.16.12. That version is
unsupported, but it's the latest long-term support release to still be
released under the GPL.

This commit breaks compatibility for mbed TLS version 2.x.y. A
compatibility header will be added in a follow-up commit.

Change-Id: I445a93e84dc54b865b757038d22318ac427fce96
Signed-off-by: Max Fillinger <max@...2606...>
---
M configure.ac
M src/openvpn/crypto_mbedtls.c
M src/openvpn/options.c
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_verify_mbedtls.c
5 files changed, 95 insertions(+), 69 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/370/1

diff --git a/configure.ac b/configure.ac
index 266b66f..2072e8c 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1016,13 +1016,13 @@
 #include <mbedtls/version.h>
 			]],
 			[[
-#if MBEDTLS_VERSION_NUMBER < 0x02000000 || MBEDTLS_VERSION_NUMBER >=3D 0x0=
3000000
+#if MBEDTLS_VERSION_NUMBER < 0x02100c00 || (MBEDTLS_VERSION_NUMBER >=3D 0x=
03000000 && MBEDTLS_VERSION_NUMBER < 0x03020100)
 #error invalid version
 #endif
 			]]
 		)],
 		[AC_MSG_RESULT([ok])],
-		[AC_MSG_ERROR([mbed TLS 2.y.z required])]
+		[AC_MSG_ERROR([mbed TLS version >=3D 2.16.12 or >=3D 3.2.1 required])]
 	)

 	AC_CHECK_FUNCS(
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index 98cac60..e85e4de 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -170,10 +170,11 @@
     while (*ciphers !=3D 0)
     {
         const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_typ=
e(*ciphers);
-        if (info && !cipher_kt_insecure(info->name)
-            && (cipher_kt_mode_aead(info->name) || cipher_kt_mode_cbc(info=
->name)))
+        const char *name =3D mbedtls_cipher_info_get_name(info);
+        if (info && name
+            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
         {
-            print_cipher(info->name);
+            print_cipher(name);
         }
         ciphers++;
     }
@@ -184,10 +185,11 @@
     while (*ciphers !=3D 0)
     {
         const mbedtls_cipher_info_t *info =3D mbedtls_cipher_info_from_typ=
e(*ciphers);
-        if (info && cipher_kt_insecure(info->name)
-            && (cipher_kt_mode_aead(info->name) || cipher_kt_mode_cbc(info=
->name)))
+        const char *name =3D mbedtls_cipher_info_get_name(info);
+        if (info && name && cipher_kt_insecure(name)
+            && (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))
         {
-            print_cipher(info->name);
+            print_cipher(name);
         }
         ciphers++;
     }
@@ -295,7 +297,9 @@
     mbedtls_pem_context ctx =3D { 0 };
     bool ret =3D mbed_ok(mbedtls_pem_read_buffer(&ctx, header, footer, BPT=
R(&input),
                                                NULL, 0, &use_len));
-    if (ret && !buf_write(dst, ctx.buf, ctx.buflen))
+    size_t buf_size =3D 0;
+    const unsigned char *buf =3D mbedtls_pem_get_buffer(&ctx, &buf_size);
+    if (ret && !buf_write(dst, buf, buf_size))
     {
         ret =3D false;
         msg(M_WARN, "PEM decode error: destination buffer too small");
@@ -416,11 +420,12 @@
         return false;
     }

-    if (cipher->key_bitlen/8 > MAX_CIPHER_KEY_LENGTH)
+    int key_bytelen =3D mbedtls_cipher_info_get_key_bitlen(cipher)/8;
+    if (key_bytelen > MAX_CIPHER_KEY_LENGTH)
     {
         msg(D_LOW, "Cipher algorithm '%s' uses a default key size (%d byte=
s) "
             "which is larger than " PACKAGE_NAME "'s current maximum key s=
ize "
-            "(%d bytes)", ciphername, cipher->key_bitlen/8, MAX_CIPHER_KEY=
_LENGTH);
+            "(%d bytes)", ciphername, key_bytelen, MAX_CIPHER_KEY_LENGTH);
         *reason =3D "disabled due to key size too large";
         return false;
     }
@@ -438,7 +443,7 @@
         return "[null-cipher]";
     }

-    return translate_cipher_name_to_openvpn(cipher_kt->name);
+    return translate_cipher_name_to_openvpn(mbedtls_cipher_info_get_name(c=
ipher_kt));
 }

 int
@@ -451,7 +456,7 @@
         return 0;
     }

-    return cipher_kt->key_bitlen/8;
+    return mbedtls_cipher_info_get_key_bitlen(cipher_kt)/8;
 }

 int
@@ -463,7 +468,7 @@
     {
         return 0;
     }
-    return cipher_kt->iv_size;
+    return mbedtls_cipher_info_get_iv_size(cipher_kt);
 }

 int
@@ -474,7 +479,7 @@
     {
         return 0;
     }
-    return cipher_kt->block_size;
+    return mbedtls_cipher_info_get_block_size(cipher_kt);
 }

 int
@@ -498,7 +503,7 @@

     return !(cipher_kt_block_size(ciphername) >=3D 128 / 8
 #ifdef MBEDTLS_CHACHAPOLY_C
-             || cipher_kt->type =3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305
+             || mbedtls_cipher_info_get_type(cipher_kt) =3D=3D MBEDTLS_CIP=
HER_CHACHA20_POLY1305
 #endif
              );
 }
@@ -507,7 +512,7 @@
 cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)
 {
     ASSERT(NULL !=3D cipher_kt);
-    return cipher_kt->mode;
+    return mbedtls_cipher_info_get_mode(cipher_kt);
 }

 bool
@@ -566,9 +571,8 @@
     CLEAR(*ctx);

     const mbedtls_cipher_info_t *kt =3D cipher_get(ciphername);
-    int key_len =3D kt->key_bitlen/8;
-
     ASSERT(kt);
+    int key_len =3D mbedtls_cipher_info_get_key_bitlen(kt)/8;

     if (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))
     {
@@ -581,7 +585,7 @@
     }

     /* make sure we used a big enough key */
-    ASSERT(ctx->key_bitlen <=3D key_len*8);
+    ASSERT(mbedtls_cipher_get_key_bitlen(ctx) <=3D key_len*8);
 }

 int
@@ -617,7 +621,7 @@
 {
     ASSERT(NULL !=3D ctx);

-    return cipher_kt_mode(ctx->cipher_info);
+    return mbedtls_cipher_get_cipher_mode(ctx);
 }

 bool
@@ -652,7 +656,7 @@
         return 0;
     }
=20
-    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, ctx->cipher_info->iv_s=
ize)))
+    if (!mbed_ok(mbedtls_cipher_set_iv(ctx, iv_buf, mbedtls_cipher_get_iv_=
size(ctx))))
     {
         return 0;
     }
@@ -714,7 +718,7 @@
 {
     size_t olen =3D 0;

-    if (MBEDTLS_DECRYPT !=3D ctx->operation)
+    if (MBEDTLS_DECRYPT !=3D mbedtls_cipher_get_operation(ctx))
     {
         return 0;
     }
@@ -866,7 +870,7 @@
     {
         return 0;
     }
-    return mbedtls_md_get_size(ctx->md_info);
+    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
 }

 void
@@ -936,7 +940,7 @@
     {
         return 0;
     }
-    return mbedtls_md_get_size(ctx->md_info);
+    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));
 }

 void
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 134bb72..7f47ba3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -644,8 +644,10 @@
     "--verify-x509-name name: Accept connections only from a host with X50=
9 subject\n"
     "                  DN name. The remote host must also pass all other t=
ests\n"
     "                  of verification.\n"
+#ifndef ENABLE_CRYPTO_MBEDTLS
     "--ns-cert-type t: (DEPRECATED) Require that peer certificate was sign=
ed with \n"
     "                  an explicit nsCertType designation t =3D 'client' |=
 'server'.\n"
+#endif
     "--x509-track x  : Save peer X509 attribute x in environment for use b=
y\n"
     "                  plugins and management interface.\n"
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
@@ -9041,6 +9043,10 @@
     }
     else if (streq(p[0], "ns-cert-type") && p[1] && !p[2])
     {
+#ifdef ENABLE_CRYPTO_MBEDTLS
+        msg(msglevel, "--ns-cert-type is not available with mbedtls.");
+        goto err;
+#endif
         VERIFY_PERMISSION(OPT_P_GENERAL);
         if (streq(p[1], "server"))
         {
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 81dd906..a4ed722 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -49,15 +49,13 @@
 #include <mbedtls/error.h>
 #include <mbedtls/version.h>

-#if MBEDTLS_VERSION_NUMBER >=3D 0x02040000
-    #include <mbedtls/net_sockets.h>
-#else
-    #include <mbedtls/net.h>
-#endif
+#include <mbedtls/net_sockets.h>

 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>

+#include <psa/crypto.h>
+
 /**
  * Compatibility: mbedtls_ctr_drbg_update was deprecated in mbedtls 2.16 a=
nd
  * replaced with mbedtls_ctr_drbg_update_ret, which returns an error code.
@@ -108,6 +106,7 @@
 void
 tls_init_lib(void)
 {
+    (void)psa_crypto_init();
 }

 void
@@ -430,7 +429,7 @@
     }

     msg(D_TLS_DEBUG_LOW, "Diffie-Hellman initialized with " counter_format=
 " bit key",
-        (counter_type) 8 * mbedtls_mpi_size(&ctx->dhm_ctx->P));
+        (counter_type) mbedtls_dhm_get_bitlen(ctx->dhm_ctx));
 }

 void
@@ -506,7 +505,9 @@
     {
         status =3D mbedtls_pk_parse_key(ctx->priv_key,
                                       (const unsigned char *) priv_key_fil=
e,
-                                      strlen(priv_key_file) + 1, NULL, 0);
+                                      strlen(priv_key_file) + 1, NULL, 0,
+                                      mbedtls_ctr_drbg_random,
+                                      rand_ctx_get());

         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
@@ -516,17 +517,26 @@
                                           (const unsigned char *) priv_key=
_file,
                                           strlen(priv_key_file) + 1,
                                           (unsigned char *) passbuf,
-                                          strlen(passbuf));
+                                          strlen(passbuf),
+                                          mbedtls_ctr_drbg_random,
+                                          rand_ctx_get());
         }
     }
     else
     {
-        status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_file, =
NULL);
+        status =3D mbedtls_pk_parse_keyfile(ctx->priv_key,
+                                          priv_key_file,
+                                          NULL,
+                                          mbedtls_ctr_drbg_random,
+                                          rand_ctx_get());
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
             char passbuf[512] =3D {0};
             pem_password_callback(passbuf, 512, 0, NULL);
-            status =3D mbedtls_pk_parse_keyfile(ctx->priv_key, priv_key_fi=
le, passbuf);
+            status =3D mbedtls_pk_parse_keyfile(ctx->priv_key,
+                                              priv_key_file, passbuf,
+                                              mbedtls_ctr_drbg_random,
+                                              rand_ctx_get());
         }
     }
     if (!mbed_ok(status))
@@ -542,7 +552,10 @@
         return 1;
     }

-    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key)=
))
+    if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk,
+                                       ctx->priv_key,
+                                       mbedtls_ctr_drbg_random,
+                                       rand_ctx_get())))
     {
         msg(M_WARN, "Private key does not match the certificate");
         return 1;
@@ -558,7 +571,6 @@
  * @param ctx_voidptr   Management external key context.
  * @param f_rng         (Unused)
  * @param p_rng         (Unused)
- * @param mode          RSA mode (should be RSA_PRIVATE).
  * @param md_alg        Message digest ('hash') algorithm type.
  * @param hashlen       Length of hash (overridden by length specified by =
md_alg
  *                      if md_alg !=3D MBEDTLS_MD_NONE).
@@ -572,7 +584,7 @@
  */
 static inline int
 external_pkcs1_sign( void *ctx_voidptr,
-                     int (*f_rng)(void *, unsigned char *, size_t), void *=
p_rng, int mode,
+                     int (*f_rng)(void *, unsigned char *, size_t), void *=
p_rng,
                      mbedtls_md_type_t md_alg, unsigned int hashlen, const=
 unsigned char *hash,
                      unsigned char *sig )
 {
@@ -587,11 +599,6 @@
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }

-    if (MBEDTLS_RSA_PRIVATE !=3D mode)
-    {
-        return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
-    }
-
     /*
      * Support a wide range of hashes. TLSv1.1 and before only need SIG_RS=
A_RAW,
      * but TLSv1.2 needs the full suite of hashes.
@@ -979,12 +986,16 @@
 int
 tls_version_max(void)
 {
-#if defined(MBEDTLS_SSL_MAJOR_VERSION_3) && defined(MBEDTLS_SSL_MINOR_VERS=
ION_3)
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
+    return TLS_VER_1_3;
+#elif defined(MBEDTLS_SSL_PROTO_TLS1_2)
     return TLS_VER_1_2;
-#elif defined(MBEDTLS_SSL_MAJOR_VERSION_3) && defined(MBEDTLS_SSL_MINOR_VE=
RSION_2)
+#elif defined(MBEDTLS_SSL_PROTO_TLS1_1)
     return TLS_VER_1_1;
-#else
+#elif defined(MBEDTLS_SSL_PROTO_TLS1)
     return TLS_VER_1_0;
+#else /* if defined(MBEDTLS_SSL_PROTO_TLS1_3) */
+    #error "mbedtls is compiled without support for any version of TLS."
 #endif
 }

@@ -1006,23 +1017,36 @@

     switch (tls_ver)
     {
+#if defined(MBEDTLS_SSL_PROTO_TLS1)
         case TLS_VER_1_0:
             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
             *minor =3D MBEDTLS_SSL_MINOR_VERSION_1;
             break;
+#endif

+#if defined(MBEDTLS_SSL_PROTO_TLS1_1)
         case TLS_VER_1_1:
             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
             *minor =3D MBEDTLS_SSL_MINOR_VERSION_2;
             break;
+#endif

+#if defined(MBEDTLS_SSL_PROTO_TLS1_2)
         case TLS_VER_1_2:
             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
             *minor =3D MBEDTLS_SSL_MINOR_VERSION_3;
             break;
+#endif
+
+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)
+        case TLS_VER_1_3:
+            *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
+            *minor =3D MBEDTLS_SSL_MINOR_VERSION_4;
+            break;
+#endif

         default:
-            msg(M_FATAL, "%s: invalid TLS version %d", __func__, tls_ver);
+            msg(M_FATAL, "%s: invalid or unsupported TLS version %d", __fu=
nc__, tls_ver);
             break;
     }
 }
@@ -1153,9 +1177,9 @@
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
             &SSLF_TLS_VERSION_MIN_MASK;

-        /* default to TLS 1.0 */
+        /* default to TLS 1.2 */
         int major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
-        int minor =3D MBEDTLS_SSL_MINOR_VERSION_1;
+        int minor =3D MBEDTLS_SSL_MINOR_VERSION_3;

         if (tls_version_min > TLS_VER_UNSPEC)
         {
@@ -1171,12 +1195,16 @@
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
             &SSLF_TLS_VERSION_MAX_MASK;

+        /* default to TLS 1.3 */
+        int major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
+        int minor =3D MBEDTLS_SSL_MINOR_VERSION_4;
+
         if (tls_version_max > TLS_VER_UNSPEC)
         {
-            int major, minor;
             tls_version_to_major_minor(tls_version_max, &major, &minor);
-            mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
         }
+
+        mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
     }

 #ifdef HAVE_EXPORT_KEYING_MATERIAL
@@ -1188,7 +1216,7 @@
     /* Initialise SSL context */
     ALLOC_OBJ_CLEAR(ks_ssl->ctx, mbedtls_ssl_context);
     mbedtls_ssl_init(ks_ssl->ctx);
-    mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config);
+    mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));

     /* Initialise BIOs */
     ALLOC_OBJ_CLEAR(ks_ssl->bio_ctx, bio_ctx);
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index a1ddf8d..33c3769 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -432,6 +432,8 @@
     }
 }

+/* Dummy function because Netscape certificate types are not supported in =
OpenVPN with mbedtls.
+ * Returns SUCCESS if usage is NS_CERT_CHECK_NONE, FAILURE otherwise. */
 result_t
 x509_verify_ns_cert_type(mbedtls_x509_crt *cert, const int usage)
 {
@@ -439,18 +441,6 @@
     {
         return SUCCESS;
     }
-    if (usage =3D=3D NS_CERT_CHECK_CLIENT)
-    {
-        return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
-                && (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_CLI=
ENT)) ?
-               SUCCESS : FAILURE;
-    }
-    if (usage =3D=3D NS_CERT_CHECK_SERVER)
-    {
-        return ((cert->ext_types & MBEDTLS_X509_EXT_NS_CERT_TYPE)
-                && (cert->ns_cert_type & MBEDTLS_X509_NS_CERT_TYPE_SSL_SER=
VER)) ?
-               SUCCESS : FAILURE;
-    }

     return FAILURE;
 }
@@ -461,7 +451,7 @@
 {
     msg(D_HANDSHAKE, "Validating certificate key usage");

-    if (!(cert->ext_types & MBEDTLS_X509_EXT_KEY_USAGE))
+    if (!mbedtls_x509_crt_has_ext_type(cert, MBEDTLS_X509_EXT_KEY_USAGE))
     {
         msg(D_TLS_ERRORS,
             "ERROR: Certificate does not have key usage extension");
@@ -486,9 +476,7 @@

     if (fFound !=3D SUCCESS)
     {
-        msg(D_TLS_ERRORS,
-            "ERROR: Certificate has key usage %04x, expected one of:",
-            cert->key_usage);
+        msg(D_TLS_ERRORS, "ERROR: Certificate has invalid key usage, expec=
ted one of:");
         for (size_t i =3D 0; i < expected_len && expected_ku[i]; i++)
         {
             msg(D_TLS_ERRORS, " * %04x", expected_ku[i]);
@@ -503,7 +491,7 @@
 {
     result_t fFound =3D FAILURE;

-    if (!(cert->ext_types & MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))
+    if (!mbedtls_x509_crt_has_ext_type(cert, MBEDTLS_X509_EXT_EXTENDED_KEY=
_USAGE))
     {
         msg(D_HANDSHAKE, "Certificate does not have extended key usage ext=
ension");
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I445a93e84dc54b865b757038d22318ac427fce96
Gerrit-Change-Number: 370
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--hLL6RYwo6RU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/370?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add support for mbedtls 3.X.Y<br><br>Most struct fields in mb=
edtls 3 are private and now need accessor<br>functions. Most of it was stra=
ightforward to adapt, but for two things<br>there were no accessor function=
s yet:<br><br> * Netscape certificate type<br> * key usage (you can check k=
ey usage, but not get the raw bytes)<br><br>I decided to remove Netscape ce=
rtificate type checks when using OpenVPN<br>with mbedtls. The key usage byt=
es were printed in an error message, and<br>I removed that part from it.<br=
><br>Adding the random number functions to the load private key function ma=
y<br>look weird, but the purpose is to make side channels for elliptic curv=
e<br>operations harder to exploit.<br><br>Also bumping the minimum mbed TLS=
 version to 2.16.12. That version is<br>unsupported, but it&#39;s the lates=
t long-term support release to still be<br>released under the GPL.<br><br>T=
his commit breaks compatibility for mbed TLS version 2.x.y. A<br>compatibil=
ity header will be added in a follow-up commit.<br><br>Change-Id: I445a93e8=
4dc54b865b757038d22318ac427fce96<br>Signed-off-by: Max Fillinger &lt;max@...1186...=
.2606...&gt;<br>---<br>M configure.ac<br>M src/openvpn/crypto_mbedtls.c<br>=
M src/openvpn/options.c<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl=
_verify_mbedtls.c<br>5 files changed, 95 insertions(+), 69 deletions(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/70/370/=
1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/configure.ac b/configure.ac</span><br><span>index 26=
6b66f..2072e8c 100644</span><br><span>--- a/configure.ac</span><br><span>++=
+ b/configure.ac</span><br><span>@@ -1016,13 +1016,13 @@</span><br><span> #=
include &lt;mbedtls/version.h&gt;</span><br><span> 			]],</span><br><span> =
			[[</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERS=
ION_NUMBER &lt; 0x02000000 || MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUM=
BER &lt; 0x02100c00 || (MBEDTLS_VERSION_NUMBER &gt;=3D 0x03000000 &amp;&amp=
; MBEDTLS_VERSION_NUMBER &lt; 0x03020100)</span><br><span> #error invalid v=
ersion</span><br><span> #endif</span><br><span> 			]]</span><br><span> 		)]=
,</span><br><span> 		[AC_MSG_RESULT([ok])],</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-		[AC_MSG_ERROR([mbed TLS 2.y.z required])]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_MSG_ERROR([mbed TLS ver=
sion &gt;=3D 2.16.12 or &gt;=3D 3.2.1 required])]</span><br><span> 	)</span=
><br><span> </span><br><span> 	AC_CHECK_FUNCS(</span><br><span>diff --git a=
/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><spa=
n>index 98cac60..e85e4de 100644</span><br><span>--- a/src/openvpn/crypto_mb=
edtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>=
@@ -170,10 +170,11 @@</span><br><span>     while (*ciphers !=3D 0)</span><b=
r><span>     {</span><br><span>         const mbedtls_cipher_info_t *info =
=3D mbedtls_cipher_info_from_type(*ciphers);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (info &amp;&amp; !cipher_kt_insecure(info=
-&gt;name)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 &amp;&amp; (cipher_kt_mode_aead(info-&gt;name) || cipher_kt_mode_cbc(info-=
&gt;name)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
const char *name =3D mbedtls_cipher_info_get_name(info);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (info &amp;&amp; name</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (c=
ipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name)))</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            pri=
nt_cipher(info-&gt;name);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            print_cipher(name);</span><br><span>         }</span><br>=
<span>         ciphers++;</span><br><span>     }</span><br><span>@@ -184,10=
 +185,11 @@</span><br><span>     while (*ciphers !=3D 0)</span><br><span>  =
   {</span><br><span>         const mbedtls_cipher_info_t *info =3D mbedtls=
_cipher_info_from_type(*ciphers);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (info &amp;&amp; cipher_kt_insecure(info-&gt;name)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; =
(cipher_kt_mode_aead(info-&gt;name) || cipher_kt_mode_cbc(info-&gt;name)))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *=
name =3D mbedtls_cipher_info_get_name(info);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (info &amp;&amp; name &amp;&amp; cipher=
_kt_insecure(name)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           &amp;&amp; (cipher_kt_mode_aead(name) || cipher_kt_mode_cbc(name=
)))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            print_cipher(info-&gt;name);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            print_cipher(name);</span><br><sp=
an>         }</span><br><span>         ciphers++;</span><br><span>     }</s=
pan><br><span>@@ -295,7 +297,9 @@</span><br><span>     mbedtls_pem_context =
ctx =3D { 0 };</span><br><span>     bool ret =3D mbed_ok(mbedtls_pem_read_b=
uffer(&amp;ctx, header, footer, BPTR(&amp;input),</span><br><span>         =
                                       NULL, 0, &amp;use_len));</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    if (ret &amp;&amp; !buf_write=
(dst, ctx.buf, ctx.buflen))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    size_t buf_size =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const unsigned char *buf =3D mbedtls_pem_get_buffer(&amp=
;ctx, &amp;buf_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (ret &amp;&amp; !buf_write(dst, buf, buf_size))</span><br><span>  =
   {</span><br><span>         ret =3D false;</span><br><span>         msg(M=
_WARN, &quot;PEM decode error: destination buffer too small&quot;);</span><=
br><span>@@ -416,11 +420,12 @@</span><br><span>         return false;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    if (cipher-&gt;key_bitlen/8 &gt; MAX_CIPHER_KEY_LENGTH)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int key_bytelen =
=3D mbedtls_cipher_info_get_key_bitlen(cipher)/8;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (key_bytelen &gt; MAX_CIPHER_KEY_LENGT=
H)</span><br><span>     {</span><br><span>         msg(D_LOW, &quot;Cipher =
algorithm &#39;%s&#39; uses a default key size (%d bytes) &quot;</span><br>=
<span>             &quot;which is larger than &quot; PACKAGE_NAME &quot;&#3=
9;s current maximum key size &quot;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            &quot;(%d bytes)&quot;, ciphername, cipher-&gt;ke=
y_bitlen/8, MAX_CIPHER_KEY_LENGTH);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            &quot;(%d bytes)&quot;, ciphername, key_bytelen=
, MAX_CIPHER_KEY_LENGTH);</span><br><span>         *reason =3D &quot;disabl=
ed due to key size too large&quot;;</span><br><span>         return false;<=
/span><br><span>     }</span><br><span>@@ -438,7 +443,7 @@</span><br><span>=
         return &quot;[null-cipher]&quot;;</span><br><span>     }</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return tr=
anslate_cipher_name_to_openvpn(cipher_kt-&gt;name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return translate_cipher_name_to_openv=
pn(mbedtls_cipher_info_get_name(cipher_kt));</span><br><span> }</span><br><=
span> </span><br><span> int</span><br><span>@@ -451,7 +456,7 @@</span><br><=
span>         return 0;</span><br><span>     }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt-&gt;key_bit=
len/8;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return mb=
edtls_cipher_info_get_key_bitlen(cipher_kt)/8;</span><br><span> }</span><br=
><span> </span><br><span> int</span><br><span>@@ -463,7 +468,7 @@</span><br=
><span>     {</span><br><span>         return 0;</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt-&gt;=
iv_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
mbedtls_cipher_info_get_iv_size(cipher_kt);</span><br><span> }</span><br><s=
pan> </span><br><span> int</span><br><span>@@ -474,7 +479,7 @@</span><br><s=
pan>     {</span><br><span>         return 0;</span><br><span>     }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt-&gt;blo=
ck_size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
mbedtls_cipher_info_get_block_size(cipher_kt);</span><br><span> }</span><br=
><span> </span><br><span> int</span><br><span>@@ -498,7 +503,7 @@</span><br=
><span> </span><br><span>     return !(cipher_kt_block_size(ciphername) &gt=
;=3D 128 / 8</span><br><span> #ifdef MBEDTLS_CHACHAPOLY_C</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-             || cipher_kt-&gt;type =3D=
=3D MBEDTLS_CIPHER_CHACHA20_POLY1305</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+             || mbedtls_cipher_info_get_type(cipher_kt) =
=3D=3D MBEDTLS_CIPHER_CHACHA20_POLY1305</span><br><span> #endif</span><br><=
span>              );</span><br><span> }</span><br><span>@@ -507,7 +512,7 @=
@</span><br><span> cipher_kt_mode(const mbedtls_cipher_info_t *cipher_kt)</=
span><br><span> {</span><br><span>     ASSERT(NULL !=3D cipher_kt);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher_kt-&gt;mode=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls=
_cipher_info_get_mode(cipher_kt);</span><br><span> }</span><br><span> </spa=
n><br><span> bool</span><br><span>@@ -566,9 +571,8 @@</span><br><span>     =
CLEAR(*ctx);</span><br><span> </span><br><span>     const mbedtls_cipher_in=
fo_t *kt =3D cipher_get(ciphername);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    int key_len =3D kt-&gt;key_bitlen/8;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     ASSERT(kt);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    int key_len =3D mbedtls=
_cipher_info_get_key_bitlen(kt)/8;</span><br><span> </span><br><span>     i=
f (!mbed_ok(mbedtls_cipher_setup(ctx, kt)))</span><br><span>     {</span><b=
r><span>@@ -581,7 +585,7 @@</span><br><span>     }</span><br><span> </span>=
<br><span>     /* make sure we used a big enough key */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ASSERT(ctx-&gt;key_bitlen &lt;=3D key=
_len*8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(=
mbedtls_cipher_get_key_bitlen(ctx) &lt;=3D key_len*8);</span><br><span> }</=
span><br><span> </span><br><span> int</span><br><span>@@ -617,7 +621,7 @@</=
span><br><span> {</span><br><span>     ASSERT(NULL !=3D ctx);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return cipher=
_kt_mode(ctx-&gt;cipher_info);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    return mbedtls_cipher_get_cipher_mode(ctx);</span><br><span>=
 }</span><br><span> </span><br><span> bool</span><br><span>@@ -652,7 +656,7=
 @@</span><br><span>         return 0;</span><br><span>     }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!mbed_ok(=
mbedtls_cipher_set_iv(ctx, iv_buf, ctx-&gt;cipher_info-&gt;iv_size)))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_=
cipher_set_iv(ctx, iv_buf, mbedtls_cipher_get_iv_size(ctx))))</span><br><sp=
an>     {</span><br><span>         return 0;</span><br><span>     }</span><=
br><span>@@ -714,7 +718,7 @@</span><br><span> {</span><br><span>     size_t=
 olen =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (MBEDTLS_DECRYPT !=3D ctx-&gt;operation)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    if (MBEDTLS_DECRYPT !=3D mbedtls_c=
ipher_get_operation(ctx))</span><br><span>     {</span><br><span>         r=
eturn 0;</span><br><span>     }</span><br><span>@@ -866,7 +870,7 @@</span><=
br><span>     {</span><br><span>         return 0;</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return mbedtls_md_g=
et_size(ctx-&gt;md_info);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return mbedtls_md_get_size(mbedtls_md_info_from_ctx(ctx));</span>=
<br><span> }</span><br><span> </span><br><span> void</span><br><span>@@ -93=
6,7 +940,7 @@</span><br><span>     {</span><br><span>         return 0;</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return mbedtls_md_get_size(ctx-&gt;md_info);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    return mbedtls_md_get_size(mbedtls_md_info_f=
rom_ctx(ctx));</span><br><span> }</span><br><span> </span><br><span> void</=
span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</=
span><br><span>index 134bb72..7f47ba3 100644</span><br><span>--- a/src/open=
vpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@=
@ -644,8 +644,10 @@</span><br><span>     &quot;--verify-x509-name name: Acc=
ept connections only from a host with X509 subject\n&quot;</span><br><span>=
     &quot;                  DN name. The remote host must also pass all ot=
her tests\n&quot;</span><br><span>     &quot;                  of verificat=
ion.\n&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef=
 ENABLE_CRYPTO_MBEDTLS</span><br><span>     &quot;--ns-cert-type t: (DEPREC=
ATED) Require that peer certificate was signed with \n&quot;</span><br><spa=
n>     &quot;                  an explicit nsCertType designation t =3D &#3=
9;client&#39; | &#39;server&#39;.\n&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span>     &quot;--x509-track x  : S=
ave peer X509 attribute x in environment for use by\n&quot;</span><br><span=
>     &quot;                  plugins and management interface.\n&quot;</sp=
an><br><span> #ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span>@@ -9041,6=
 +9043,10 @@</span><br><span>     }</span><br><span>     else if (streq(p[0=
], &quot;ns-cert-type&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef EN=
ABLE_CRYPTO_MBEDTLS</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        msg(msglevel, &quot;--ns-cert-type is not available with mbedtls.&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><b=
r><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span>        =
 if (streq(p[1], &quot;server&quot;))</span><br><span>         {</span><br>=
<span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</s=
pan><br><span>index 81dd906..a4ed722 100644</span><br><span>--- a/src/openv=
pn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br>=
<span>@@ -49,15 +49,13 @@</span><br><span> #include &lt;mbedtls/error.h&gt;=
</span><br><span> #include &lt;mbedtls/version.h&gt;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDTLS_VERSION_NUMBER=
 &gt;=3D 0x02040000</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  #include &lt;mbedtls/net_sockets.h&gt;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    #include &lt;mbedtls/net.h&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;mbedtls/net_sockets.h&gt;</span><br><span> </span><br><span=
> #include &lt;mbedtls/oid.h&gt;</span><br><span> #include &lt;mbedtls/pem.=
h&gt;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#include &lt;psa/crypto.h&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> /**</span><br><span>  * Compatibility: mbed=
tls_ctr_drbg_update was deprecated in mbedtls 2.16 and</span><br><span>  * =
replaced with mbedtls_ctr_drbg_update_ret, which returns an error code.</sp=
an><br><span>@@ -108,6 +106,7 @@</span><br><span> void</span><br><span> tls=
_init_lib(void)</span><br><span> {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    (void)psa_crypto_init();</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span>@@ -430,7 +429,7 @@</span><br><=
span>     }</span><br><span> </span><br><span>     msg(D_TLS_DEBUG_LOW, &qu=
ot;Diffie-Hellman initialized with &quot; counter_format &quot; bit key&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        (counter_t=
ype) 8 * mbedtls_mpi_size(&amp;ctx-&gt;dhm_ctx-&gt;P));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        (counter_type) mbedtls_dhm_get_=
bitlen(ctx-&gt;dhm_ctx));</span><br><span> }</span><br><span> </span><br><s=
pan> void</span><br><span>@@ -506,7 +505,9 @@</span><br><span>     {</span>=
<br><span>         status =3D mbedtls_pk_parse_key(ctx-&gt;priv_key,</span>=
<br><span>                                       (const unsigned char *) pr=
iv_key_file,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                             strlen(priv_key_file) + 1, NULL, 0);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
         strlen(priv_key_file) + 1, NULL, 0,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                      mbedtls_ctr_=
drbg_random,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                               rand_ctx_get());</span><br><span> </span><br=
><span>         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)</span><=
br><span>         {</span><br><span>@@ -516,17 +517,26 @@</span><br><span> =
                                          (const unsigned char *) priv_key_=
file,</span><br><span>                                           strlen(pri=
v_key_file) + 1,</span><br><span>                                          =
 (unsigned char *) passbuf,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                          strlen(passbuf));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
             strlen(passbuf),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                          mbedtls_ctr_drbg_random=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                        rand_ctx_get());</span><br><span>         }</span><=
br><span>     }</span><br><span>     else</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        status =3D mbedtls_pk_pa=
rse_keyfile(ctx-&gt;priv_key, priv_key_file, NULL);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        status =3D mbedtls_pk_parse_keyfi=
le(ctx-&gt;priv_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                          priv_key_file,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
     NULL,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                 mbedtls_ctr_drbg_random,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                                     =
     rand_ctx_get());</span><br><span>         if (MBEDTLS_ERR_PK_PASSWORD_=
REQUIRED =3D=3D status)</span><br><span>         {</span><br><span>        =
     char passbuf[512] =3D {0};</span><br><span>             pem_password_c=
allback(passbuf, 512, 0, NULL);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key,=
 priv_key_file, passbuf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key,</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
                       priv_key_file, passbuf,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                              mb=
edtls_ctr_drbg_random,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                              rand_ctx_get());</span><br=
><span>         }</span><br><span>     }</span><br><span>     if (!mbed_ok(=
status))</span><br><span>@@ -542,7 +552,10 @@</span><br><span>         retu=
rn 1;</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (!mbed_ok(mbedtls_pk_check_pair(&amp;ctx-&g=
t;crt_chain-&gt;pk, ctx-&gt;priv_key)))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (!mbed_ok(mbedtls_pk_check_pair(&amp;ctx-&gt;crt=
_chain-&gt;pk,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                                  ctx-&gt;priv_key,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                       mb=
edtls_ctr_drbg_random,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                       rand_ctx_get())))</span><br><span=
>     {</span><br><span>         msg(M_WARN, &quot;Private key does not mat=
ch the certificate&quot;);</span><br><span>         return 1;</span><br><sp=
an>@@ -558,7 +571,6 @@</span><br><span>  * @param ctx_voidptr   Management =
external key context.</span><br><span>  * @param f_rng         (Unused)</sp=
an><br><span>  * @param p_rng         (Unused)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * @param mode          RSA mode (should be RSA_PR=
IVATE).</span><br><span>  * @param md_alg        Message digest (&#39;hash&=
#39;) algorithm type.</span><br><span>  * @param hashlen       Length of ha=
sh (overridden by length specified by md_alg</span><br><span>  *           =
           if md_alg !=3D MBEDTLS_MD_NONE).</span><br><span>@@ -572,7 +584,=
7 @@</span><br><span>  */</span><br><span> static inline int</span><br><spa=
n> external_pkcs1_sign( void *ctx_voidptr,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                     int (*f_rng)(void *, unsigned cha=
r *, size_t), void *p_rng, int mode,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                     int (*f_rng)(void *, unsigned char *,=
 size_t), void *p_rng,</span><br><span>                      mbedtls_md_typ=
e_t md_alg, unsigned int hashlen, const unsigned char *hash,</span><br><spa=
n>                      unsigned char *sig )</span><br><span> {</span><br><=
span>@@ -587,11 +599,6 @@</span><br><span>         return MBEDTLS_ERR_RSA_B=
AD_INPUT_DATA;</span><br><span>     }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (MBEDTLS_RSA_PRIVATE !=3D mode)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        return MBEDTLS_ERR_RSA_BAD_INPUT=
_DATA;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     /*</span>=
<br><span>      * Support a wide range of hashes. TLSv1.1 and before only n=
eed SIG_RSA_RAW,</span><br><span>      * but TLSv1.2 needs the full suite o=
f hashes.</span><br><span>@@ -979,12 +986,16 @@</span><br><span> int</span>=
<br><span> tls_version_max(void)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(MBEDTLS_SSL_MAJOR_VERSION_3) &a=
mp;&amp; defined(MBEDTLS_SSL_MINOR_VERSION_3)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return TLS_VER_1_3;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(MBEDTLS_SSL_P=
ROTO_TLS1_2)</span><br><span>     return TLS_VER_1_2;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#elif defined(MBEDTLS_SSL_MAJOR_VERSION_3) =
&amp;&amp; defined(MBEDTLS_SSL_MINOR_VERSION_2)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#elif defined(MBEDTLS_SSL_PROTO_TLS1_1)</span><=
br><span>     return TLS_VER_1_1;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
lif defined(MBEDTLS_SSL_PROTO_TLS1)</span><br><span>     return TLS_VER_1_0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* if define=
d(MBEDTLS_SSL_PROTO_TLS1_3) */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    #error &quot;mbedtls is compiled without support for any ver=
sion of TLS.&quot;</span><br><span> #endif</span><br><span> }</span><br><sp=
an> </span><br><span>@@ -1006,23 +1017,36 @@</span><br><span> </span><br><s=
pan>     switch (tls_ver)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS1)</span><br>=
<span>         case TLS_VER_1_0:</span><br><span>             *major =3D MB=
EDTLS_SSL_MAJOR_VERSION_3;</span><br><span>             *minor =3D MBEDTLS_=
SSL_MINOR_VERSION_1;</span><br><span>             break;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS=
1_1)</span><br><span>         case TLS_VER_1_1:</span><br><span>           =
  *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span>             *min=
or =3D MBEDTLS_SSL_MINOR_VERSION_2;</span><br><span>             break;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTL=
S_SSL_PROTO_TLS1_2)</span><br><span>         case TLS_VER_1_2:</span><br><s=
pan>             *major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span>  =
           *minor =3D MBEDTLS_SSL_MINOR_VERSION_3;</span><br><span>        =
     break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_PROTO_TLS1_3)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        case TLS_VER_1=
_3:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *maj=
or =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            *minor =3D MBEDTLS_SSL_MINOR_VERSION_4;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            break;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span>         default:</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            msg(M_FATAL, &quot;%s: invalid TLS version %d&quot;, _=
_func__, tls_ver);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           msg(M_FATAL, &quot;%s: invalid or unsupported TLS version %d&quo=
t;, __func__, tls_ver);</span><br><span>             break;</span><br><span=
>     }</span><br><span> }</span><br><span>@@ -1153,9 +1177,9 @@</span><br>=
<span>             (session-&gt;opt-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION=
_MIN_SHIFT)</span><br><span>             &amp;SSLF_TLS_VERSION_MIN_MASK;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  /* default to TLS 1.0 */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        /* default to TLS 1.2 */</span><br><span>         int major =
=3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        int minor =3D MBEDTLS_SSL_MINOR_VERSION_1;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        int minor =3D MBEDTLS_SSL=
_MINOR_VERSION_3;</span><br><span> </span><br><span>         if (tls_versio=
n_min &gt; TLS_VER_UNSPEC)</span><br><span>         {</span><br><span>@@ -1=
171,12 +1195,16 @@</span><br><span>             (session-&gt;opt-&gt;ssl_fl=
ags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT)</span><br><span>             &amp;=
SSLF_TLS_VERSION_MAX_MASK;</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* default to TLS 1.3 */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        int major =3D MBEDTLS_SSL_MAJ=
OR_VERSION_3;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  int minor =3D MBEDTLS_SSL_MINOR_VERSION_4;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>         if (tls_version_max &gt;=
 TLS_VER_UNSPEC)</span><br><span>         {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            int major, minor;</span><br><span>       =
      tls_version_to_major_minor(tls_version_max, &amp;major, &amp;minor);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            mbedtls_ss=
l_conf_max_version(ks_ssl-&gt;ssl_config, major, minor);</span><br><span>  =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        mbedtls_ssl_conf_max_v=
ersion(ks_ssl-&gt;ssl_config, major, minor);</span><br><span>     }</span><=
br><span> </span><br><span> #ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><s=
pan>@@ -1188,7 +1216,7 @@</span><br><span>     /* Initialise SSL context */=
</span><br><span>     ALLOC_OBJ_CLEAR(ks_ssl-&gt;ctx, mbedtls_ssl_context);=
</span><br><span>     mbedtls_ssl_init(ks_ssl-&gt;ctx);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    mbedtls_ssl_setup(ks_ssl-&gt;ctx, ks_=
ssl-&gt;ssl_config);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    mbed_ok(mbedtls_ssl_setup(ks_ssl-&gt;ctx, ks_ssl-&gt;ssl_config));</sp=
an><br><span> </span><br><span>     /* Initialise BIOs */</span><br><span> =
    ALLOC_OBJ_CLEAR(ks_ssl-&gt;bio_ctx, bio_ctx);</span><br><span>diff --gi=
t a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c</sp=
an><br><span>index a1ddf8d..33c3769 100644</span><br><span>--- a/src/openvp=
n/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_verify_mbedtls=
.c</span><br><span>@@ -432,6 +432,8 @@</span><br><span>     }</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Dummy function because Netscape certificate types are not supported =
in OpenVPN with mbedtls.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Returns SUCCESS if usage is NS_CERT_CHECK_NONE, FAILURE otherwise. =
*/</span><br><span> result_t</span><br><span> x509_verify_ns_cert_type(mbed=
tls_x509_crt *cert, const int usage)</span><br><span> {</span><br><span>@@ =
-439,18 +441,6 @@</span><br><span>     {</span><br><span>         return SU=
CCESS;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (usage =3D=3D NS_CERT_CHECK_CLIENT)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        return ((cert-&gt;ext_types &amp; MBEDTLS_X509_EXT_NS_=
CERT_TYPE)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     &amp;&amp; (cert-&gt;ns_cert_type &amp; MBEDTLS_X509_NS_CERT_TYPE_SSL_=
CLIENT)) ?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
    SUCCESS : FAILURE;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (usage =
=3D=3D NS_CERT_CHECK_SERVER)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eturn ((cert-&gt;ext_types &amp; MBEDTLS_X509_EXT_NS_CERT_TYPE)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                &amp;&amp; (cert-=
&gt;ns_cert_type &amp; MBEDTLS_X509_NS_CERT_TYPE_SSL_SERVER)) ?</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-               SUCCESS : FAILURE;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span=
> </span><br><span>     return FAILURE;</span><br><span> }</span><br><span>=
@@ -461,7 +451,7 @@</span><br><span> {</span><br><span>     msg(D_HANDSHAKE=
, &quot;Validating certificate key usage&quot;);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    if (!(cert-&gt;ext_types &=
amp; MBEDTLS_X509_EXT_KEY_USAGE))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (!mbedtls_x509_crt_has_ext_type(cert, MBEDTLS_X509_EXT=
_KEY_USAGE))</span><br><span>     {</span><br><span>         msg(D_TLS_ERRO=
RS,</span><br><span>             &quot;ERROR: Certificate does not have key=
 usage extension&quot;);</span><br><span>@@ -486,9 +476,7 @@</span><br><spa=
n> </span><br><span>     if (fFound !=3D SUCCESS)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_TLS_ERRORS=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &quot;ER=
ROR: Certificate has key usage %04x, expected one of:&quot;,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            cert-&gt;key_usage);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_TLS_ERROR=
S, &quot;ERROR: Certificate has invalid key usage, expected one of:&quot;);=
</span><br><span>         for (size_t i =3D 0; i &lt; expected_len &amp;&am=
p; expected_ku[i]; i++)</span><br><span>         {</span><br><span>        =
     msg(D_TLS_ERRORS, &quot; * %04x&quot;, expected_ku[i]);</span><br><spa=
n>@@ -503,7 +491,7 @@</span><br><span> {</span><br><span>     result_t fFou=
nd =3D FAILURE;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (!(cert-&gt;ext_types &amp; MBEDTLS_X509_EXT_EXTENDED_KE=
Y_USAGE))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!m=
bedtls_x509_crt_has_ext_type(cert, MBEDTLS_X509_EXT_EXTENDED_KEY_USAGE))</s=
pan><br><span>     {</span><br><span>         msg(D_HANDSHAKE, &quot;Certif=
icate does not have extended key usage extension&quot;);</span><br><span>  =
   }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://g=
errit.openvpn.net/c/openvpn/+/370?usp=3Demail">change 370</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/370?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I445a93e84dc54b865b757038d22=
318ac427fce96 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 370 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--hLL6RYwo6RU=--

