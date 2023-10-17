From: "MaxF (Code Review)" <gerrit@...515...>
Date: Tue, 17 Oct 2023 17:05:59 +0000
References: <gerrit.1697562354000.I143ca14c27c0c378b5e6b4184e80890d2c0e225e@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6bd2af685d5f2fa8282de05ca43ebcdd81d798f5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SvPihwpKBAk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add compatibility
 functions for mbedtls 2.X.Y
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

--SvPihwpKBAk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/371?usp=3Demail

to review the following change.


Change subject: Add compatibility functions for mbedtls 2.X.Y
......................................................................

Add compatibility functions for mbedtls 2.X.Y

Change-Id: I143ca14c27c0c378b5e6b4184e80890d2c0e225e
Signed-off-by: Max Fillinger <max@...2606...>
---
M configure.ac
M src/openvpn/crypto_mbedtls.c
A src/openvpn/mbedtls_compat.h
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_verify_mbedtls.c
5 files changed, 211 insertions(+), 36 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/71/371/1

diff --git a/configure.ac b/configure.ac
index 2072e8c..6658485 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1025,6 +1025,12 @@
 		[AC_MSG_ERROR([mbed TLS version >=3D 2.16.12 or >=3D 3.2.1 required])]
 	)

+    AC_CHECK_HEADER(
+        psa/crypto.h,
+        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [1], [yes])],
+        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [0], [no])]
+    )
+
 	AC_CHECK_FUNCS(
 		[ \
 			mbedtls_cipher_write_tag \
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index e85e4de..f244863 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -41,6 +41,7 @@
 #include "integer.h"
 #include "crypto_backend.h"
 #include "otime.h"
+#include "mbedtls_compat.h"
 #include "misc.h"

 #include <mbedtls/base64.h>
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
new file mode 100644
index 0000000..eac647d
--- /dev/null
+++ b/src/openvpn/mbedtls_compat.h
@@ -0,0 +1,151 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2023 Fox Crypto B.V. <openvpn@...2507...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/**
+ * @file mbedtls compatibility stub
+ *
+ * This file provide compatibility stubs for the mbedtls libraries
+ * prior to version 3. This version made most fields in structs private
+ * and requires accessor functions to be used. For earlier versions, we
+ * implement the accessor functions here.
+ */
+
+#ifndef MBEDTLS_COMPAT_H_
+#define MBEDTLS_COMPAT_H_
+
+#include "errlevel.h"
+
+#include <mbedtls/cipher.h>
+#include <mbedtls/dhm.h>
+#include <mbedtls/md.h>
+#include <mbedtls/pem.h>
+#include <mbedtls/pk.h>
+#include <mbedtls/version.h>
+#include <mbedtls/x509_crt.h>
+
+#if MBEDTLS_HAVE_PSA_CRYPTO_H
+    #include <psa/crypto.h>
+#endif
+
+static inline void
+mbedtls_compat_psa_crypto_init(void)
+{
+#if MBEDTLS_HAVE_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C)
+    if (psa_crypto_init() !=3D PSA_SUCCESS)
+    {
+        msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
+    }
+#else
+    return;
+#endif /* MBEDTLS_HAVE_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
+}
+
+static inline int
+mbedtls_compat_pk_parse_key(mbedtls_pk_context *ctx,
+                            const unsigned char *key, size_t keylen,
+                            const unsigned char *pwd, size_t pwdlen,
+                            int (*f_rng)(void *, unsigned char *, size_t),=
 void *p_rng)
+{
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen);
+#else
+    return mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, f_rng, p_rn=
g);
+#endif
+}
+
+static inline int
+mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx,
+                                const char *path, const char *password,
+                                int (*f_rng)(void *, unsigned char *, size=
_t), void *p_rng)
+{
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+    return mbedtls_pk_parse_keyfile(ctx, path, password);
+#else
+    return mbedtls_pk_parse_keyfile(ctx, path, password, f_rng, p_rng);
+#endif
+}
+
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+static inline unsigned int
+mbedtls_cipher_info_get_block_size(const mbedtls_cipher_info_t *cipher)
+{
+    return cipher->block_size;
+}
+
+static inline unsigned int
+mbedtls_cipher_info_get_iv_size(const mbedtls_cipher_info_t *cipher)
+{
+    return cipher->iv_size;
+}
+
+static inline unsigned int
+mbedtls_cipher_info_get_key_bitlen(const mbedtls_cipher_info_t *cipher)
+{
+    return cipher->key_bitlen;
+}
+
+static inline mbedtls_cipher_mode_t
+mbedtls_cipher_info_get_mode(const mbedtls_cipher_info_t *cipher)
+{
+    return cipher->mode;
+}
+
+static inline const char *
+mbedtls_cipher_info_get_name(const mbedtls_cipher_info_t *cipher)
+{
+    return cipher->name;
+}
+
+static inline mbedtls_cipher_type_t
+mbedtls_cipher_info_get_type(const mbedtls_cipher_info_t *cipher)
+{
+    return cipher->type;
+}
+
+static inline size_t
+mbedtls_dhm_get_bitlen(const mbedtls_dhm_context *ctx)
+{
+    return 8 * ctx->len;
+}
+
+static inline const mbedtls_md_info_t *
+mbedtls_md_info_from_ctx(const mbedtls_md_context_t *ctx)
+{
+    return ctx->md_info;
+}
+
+static inline const unsigned char *
+mbedtls_pem_get_buffer(const mbedtls_pem_context *ctx, size_t *buf_size)
+{
+    *buf_size =3D ctx->buflen;
+    return ctx->buf;
+}
+
+static inline int
+mbedtls_x509_crt_has_ext_type(const mbedtls_x509_crt *ctx, int ext_type)
+{
+    return ctx->ext_types & ext_type;
+}
+#endif /* MBEDTLS_VERSION_NUMBER < 0x03020100 */
+
+#endif /* MBEDTLS_COMPAT_H_ */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index a4ed722..cdb0ebe 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -41,6 +41,7 @@
 #include "buffer.h"
 #include "misc.h"
 #include "manage.h"
+#include "mbedtls_compat.h"
 #include "pkcs11_backend.h"
 #include "ssl_common.h"

@@ -54,8 +55,6 @@
 #include <mbedtls/oid.h>
 #include <mbedtls/pem.h>

-#include <psa/crypto.h>
-
 /**
  * Compatibility: mbedtls_ctr_drbg_update was deprecated in mbedtls 2.16 a=
nd
  * replaced with mbedtls_ctr_drbg_update_ret, which returns an error code.
@@ -106,7 +105,7 @@
 void
 tls_init_lib(void)
 {
-    (void)psa_crypto_init();
+    mbedtls_compat_psa_crypto_init();
 }

 void
@@ -503,40 +502,40 @@

     if (priv_key_inline)
     {
-        status =3D mbedtls_pk_parse_key(ctx->priv_key,
-                                      (const unsigned char *) priv_key_fil=
e,
-                                      strlen(priv_key_file) + 1, NULL, 0,
-                                      mbedtls_ctr_drbg_random,
-                                      rand_ctx_get());
+        status =3D mbedtls_compat_pk_parse_key(ctx->priv_key,
+                                             (const unsigned char *) priv_=
key_file,
+                                             strlen(priv_key_file) + 1, NU=
LL, 0,
+                                             mbedtls_ctr_drbg_random,
+                                             rand_ctx_get());

         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
             char passbuf[512] =3D {0};
             pem_password_callback(passbuf, 512, 0, NULL);
-            status =3D mbedtls_pk_parse_key(ctx->priv_key,
-                                          (const unsigned char *) priv_key=
_file,
-                                          strlen(priv_key_file) + 1,
-                                          (unsigned char *) passbuf,
-                                          strlen(passbuf),
-                                          mbedtls_ctr_drbg_random,
-                                          rand_ctx_get());
+            status =3D mbedtls_compat_pk_parse_key(ctx->priv_key,
+                                                 (const unsigned char *) p=
riv_key_file,
+                                                 strlen(priv_key_file) + 1,
+                                                 (unsigned char *) passbuf,
+                                                 strlen(passbuf),
+                                                 mbedtls_ctr_drbg_random,
+                                                 rand_ctx_get());
         }
     }
     else
     {
-        status =3D mbedtls_pk_parse_keyfile(ctx->priv_key,
-                                          priv_key_file,
-                                          NULL,
-                                          mbedtls_ctr_drbg_random,
-                                          rand_ctx_get());
+        status =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key,
+                                                 priv_key_file,
+                                                 NULL,
+                                                 mbedtls_ctr_drbg_random,
+                                                 rand_ctx_get());
         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED =3D=3D status)
         {
             char passbuf[512] =3D {0};
             pem_password_callback(passbuf, 512, 0, NULL);
-            status =3D mbedtls_pk_parse_keyfile(ctx->priv_key,
-                                              priv_key_file, passbuf,
-                                              mbedtls_ctr_drbg_random,
-                                              rand_ctx_get());
+            status =3D mbedtls_compat_pk_parse_keyfile(ctx->priv_key,
+                                                     priv_key_file, passbu=
f,
+                                                     mbedtls_ctr_drbg_rand=
om,
+                                                     rand_ctx_get());
         }
     }
     if (!mbed_ok(status))
@@ -553,9 +552,12 @@
     }

     if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk,
-                                       ctx->priv_key,
-                                       mbedtls_ctr_drbg_random,
-                                       rand_ctx_get())))
+                                       ctx->priv_key
+#if MBEDTLS_VERSION_NUMBER >=3D 0x03000000
+                                       , mbedtls_ctr_drbg_random,
+                                       rand_ctx_get()
+#endif
+                                       )))
     {
         msg(M_WARN, "Private key does not match the certificate");
         return 1;
@@ -585,6 +587,9 @@
 static inline int
 external_pkcs1_sign( void *ctx_voidptr,
                      int (*f_rng)(void *, unsigned char *, size_t), void *=
p_rng,
+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+                     int mode,
+#endif
                      mbedtls_md_type_t md_alg, unsigned int hashlen, const=
 unsigned char *hash,
                      unsigned char *sig )
 {
@@ -599,6 +604,13 @@
         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;
     }

+#if MBEDTLS_VERSION_NUMBER < 0x03020100
+    if (MBEDTLS_RSA_PRIVATE !=3D mode)
+    {
+        return MBEDTLS_RSA_BAD_INPUT_DATA;
+    }
+#endif
+
     /*
      * Support a wide range of hashes. TLSv1.1 and before only need SIG_RS=
A_RAW,
      * but TLSv1.2 needs the full suite of hashes.
@@ -1173,7 +1185,7 @@

     /* Initialize minimum TLS version */
     {
-        const int tls_version_min =3D
+        const int configured_tls_version_min =3D
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MIN_SHIFT)
             &SSLF_TLS_VERSION_MIN_MASK;

@@ -1181,9 +1193,9 @@
         int major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
         int minor =3D MBEDTLS_SSL_MINOR_VERSION_3;

-        if (tls_version_min > TLS_VER_UNSPEC)
+        if (configured_tls_version_min > TLS_VER_UNSPEC)
         {
-            tls_version_to_major_minor(tls_version_min, &major, &minor);
+            tls_version_to_major_minor(configured_tls_version_min, &major,=
 &minor);
         }

         mbedtls_ssl_conf_min_version(ks_ssl->ssl_config, major, minor);
@@ -1191,17 +1203,21 @@

     /* Initialize maximum TLS version */
     {
-        const int tls_version_max =3D
+        const int configured_tls_version_max =3D
             (session->opt->ssl_flags >> SSLF_TLS_VERSION_MAX_SHIFT)
             &SSLF_TLS_VERSION_MAX_MASK;

-        /* default to TLS 1.3 */
-        int major =3D MBEDTLS_SSL_MAJOR_VERSION_3;
-        int minor =3D MBEDTLS_SSL_MINOR_VERSION_4;
+        int major =3D 0;
+        int minor =3D 0;

-        if (tls_version_max > TLS_VER_UNSPEC)
+        if (configured_tls_version_max > TLS_VER_UNSPEC)
         {
-            tls_version_to_major_minor(tls_version_max, &major, &minor);
+            tls_version_to_major_minor(configured_tls_version_max, &major,=
 &minor);
+        }
+        else
+        {
+            /* Default to tls_version_max(). */
+            tls_version_to_major_minor(tls_version_max(), &major, &minor);
         }

         mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 33c3769..ce21324 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -35,6 +35,7 @@
 #if defined(ENABLE_CRYPTO_MBEDTLS)

 #include "crypto_mbedtls.h"
+#include "mbedtls_compat.h"
 #include "ssl_verify.h"
 #include <mbedtls/asn1.h>
 #include <mbedtls/error.h>

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/371?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I143ca14c27c0c378b5e6b4184e80890d2c0e225e
Gerrit-Change-Number: 371
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--SvPihwpKBAk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/371?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add compatibility functions for mbedtls 2.X.Y<br><br>Change-I=
d: I143ca14c27c0c378b5e6b4184e80890d2c0e225e<br>Signed-off-by: Max Fillinge=
r &lt;max@...2606...&gt;<br>---<br>M configure.ac<br>M src/openvpn/crypto_m=
bedtls.c<br>A src/openvpn/mbedtls_compat.h<br>M src/openvpn/ssl_mbedtls.c<b=
r>M src/openvpn/ssl_verify_mbedtls.c<br>5 files changed, 211 insertions(+),=
 36 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/71/371/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</spa=
n><br><span>index 2072e8c..6658485 100644</span><br><span>--- a/configure.a=
c</span><br><span>+++ b/configure.ac</span><br><span>@@ -1025,6 +1025,12 @@=
</span><br><span> 		[AC_MSG_ERROR([mbed TLS version &gt;=3D 2.16.12 or &gt;=
=3D 3.2.1 required])]</span><br><span> 	)</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    AC_CHECK_HEADER(</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        psa/crypto.h,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        [AC_DEFINE([MBEDTLS_HAVE=
_PSA_CRYPTO_H], [1], [yes])],</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [0], [no])]</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> 	AC_CHECK_FUNCS(</spa=
n><br><span> 		[ \</span><br><span> 			mbedtls_cipher_write_tag \</span><br=
><span>diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedt=
ls.c</span><br><span>index e85e4de..f244863 100644</span><br><span>--- a/sr=
c/openvpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls=
.c</span><br><span>@@ -41,6 +41,7 @@</span><br><span> #include &quot;intege=
r.h&quot;</span><br><span> #include &quot;crypto_backend.h&quot;</span><br>=
<span> #include &quot;otime.h&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &quot;mbedtls_compat.h&quot;</span><br><span> #inc=
lude &quot;misc.h&quot;</span><br><span> </span><br><span> #include &lt;mbe=
dtls/base64.h&gt;</span><br><span>diff --git a/src/openvpn/mbedtls_compat.h=
 b/src/openvpn/mbedtls_compat.h</span><br><span>new file mode 100644</span>=
<br><span>index 0000000..eac647d</span><br><span>--- /dev/null</span><br><s=
pan>+++ b/src/openvpn/mbedtls_compat.h</span><br><span>@@ -0,0 +1,151 @@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to secure=
ly tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *             over a single TCP/UDP port, with support for SSL/TLS-based=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sess=
ion authentication and key exchange,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *             packet encryption, packet authentication, a=
nd</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2=
023 Fox Crypto B.V. &lt;openvpn@...2507...&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  This program is free software; you can redistribute it and/or=
 modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under=
 the terms of the GNU General Public License version 2</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fo=
undation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distrib=
uted in the hope that it will be useful,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied=
 warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MER=
CHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for m=
ore details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have rece=
ived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @file mbedtls compatibility stub</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * This file provide compatibility stubs for the mbedtls libraries</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * prior to version 3=
. This version made most fields in structs private</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * and requires accessor functions to be use=
d. For earlier versions, we</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * implement the accessor functions here.</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifnd=
ef MBEDTLS_COMPAT_H_</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define MBEDTLS_COMPAT_H_</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &qu=
ot;errlevel.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtl=
s/cipher.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &lt;mbedtls/dhm.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &lt;mbedtls/md.h&gt;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#include &lt;mbedtls/pem.h&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;mbedtls/pk.h&gt;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/version.h&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/x5=
09_crt.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_HAVE_PSA_CRYPT=
O_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #include &lt=
;psa/crypto.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static inline void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+mbedtls_compat_psa_crypto_init(void=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_HAVE_PSA_CRYPTO_H &amp;&=
amp; defined(MBEDTLS_PSA_CRYPTO_C)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (psa_crypto_init() !=3D PSA_SUCCESS)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;mbedtls: psa_crypto_ini=
t() failed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif /* MBEDTLS_HAVE_PSA_CRYPTO_H &=
amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C) */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline =
int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_compat_p=
k_parse_key(mbedtls_pk_context *ctx,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            const unsigned char *key, size=
_t keylen,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                   const unsigned char *pwd, size_t pwdlen,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                            int (*f=
_rng)(void *, unsigned char *, size_t), void *p_rng)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_pk_parse_key(ctx,=
 key, keylen, pwd, pwdlen);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
turn mbedtls_pk_parse_key(ctx, key, keylen, pwd, pwdlen, f_rng, p_rng);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static inline int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
mbedtls_compat_pk_parse_keyfile(mbedtls_pk_context *ctx,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                                const =
char *path, const char *password,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                int (*f_rng)(void *, unsigned=
 char *, size_t), void *p_rng)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBE=
DTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return mbedtls_pk_parse_keyfile(ctx, path, password);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return mbedtls_pk_parse_keyfile=
(ctx, path, password, f_rng, p_rng);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0=
x03020100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inl=
ine unsigned int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbe=
dtls_cipher_info_get_block_size(const mbedtls_cipher_info_t *cipher)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    return cipher-&gt;block_size;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static inline unsigned int</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+mbedtls_cipher_info_get_iv_size(const mbedtls_cipher_info_t =
*cipher)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    return cipher-&gt;iv_size=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static inline unsigned int</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+mbedtls_cipher_info_get_key_bitlen(const mbedtls=
_cipher_info_t *cipher)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cip=
her-&gt;key_bitlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static inline mbedtls_cipher_mode_t</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_cipher_info_g=
et_mode(const mbedtls_cipher_info_t *cipher)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    return cipher-&gt;mode;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline const ch=
ar *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_cipher_=
info_get_name(const mbedtls_cipher_info_t *cipher)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    return cipher-&gt;name;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline mb=
edtls_cipher_type_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
mbedtls_cipher_info_get_type(const mbedtls_cipher_info_t *cipher)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return cipher-&gt;type;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic inline size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
mbedtls_dhm_get_bitlen(const mbedtls_dhm_context *ctx)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    return 8 * ctx-&gt;len;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static inlin=
e const mbedtls_md_info_t *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+mbedtls_md_info_from_ctx(const mbedtls_md_context_t *ctx)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return ctx-&gt;md_info;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic inline const unsigned char *</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+mbedtls_pem_get_buffer(const mbedtls_pem_context *ctx, size_=
t *buf_size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    *buf_size =3D ctx-&gt=
;buflen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
ctx-&gt;buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static inline int</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+mbedtls_x509_crt_has_ext_type(const mbedtls_x5=
09_crt *ctx, int ext_type)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
ctx-&gt;ext_types &amp; ext_type;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#end=
if /* MBEDTLS_VERSION_NUMBER &lt; 0x03020100 */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#endif /* MBEDTLS_COMPAT_H_ */</span><br><span>diff --git a/src/op=
envpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index a4ed7=
22..cdb0ebe 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><b=
r><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -41,6 +41,7 @@</=
span><br><span> #include &quot;buffer.h&quot;</span><br><span> #include &qu=
ot;misc.h&quot;</span><br><span> #include &quot;manage.h&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mbedtls_compat.h&=
quot;</span><br><span> #include &quot;pkcs11_backend.h&quot;</span><br><spa=
n> #include &quot;ssl_common.h&quot;</span><br><span> </span><br><span>@@ -=
54,8 +55,6 @@</span><br><span> #include &lt;mbedtls/oid.h&gt;</span><br><sp=
an> #include &lt;mbedtls/pem.h&gt;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &lt;psa/crypto.h&gt;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /**</span><br><sp=
an>  * Compatibility: mbedtls_ctr_drbg_update was deprecated in mbedtls 2.1=
6 and</span><br><span>  * replaced with mbedtls_ctr_drbg_update_ret, which =
returns an error code.</span><br><span>@@ -106,7 +105,7 @@</span><br><span>=
 void</span><br><span> tls_init_lib(void)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    (void)psa_crypto_init();</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_compat_psa_cryp=
to_init();</span><br><span> }</span><br><span> </span><br><span> void</span=
><br><span>@@ -503,40 +502,40 @@</span><br><span> </span><br><span>     if =
(priv_key_inline)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        status =3D mbedtls_pk_parse_key(ctx-&gt;priv_key=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                  (const unsigned char *) priv_key_file,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                                      st=
rlen(priv_key_file) + 1, NULL, 0,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                      mbedtls_ctr_drbg_random,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
                rand_ctx_get());</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        status =3D mbedtls_compat_pk_parse_key(ctx-&gt;priv_ke=
y,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                            (const unsigned char *) priv_key_file,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
                 strlen(priv_key_file) + 1, NULL, 0,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
    mbedtls_ctr_drbg_random,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                             rand_ctx_get());</spa=
n><br><span> </span><br><span>         if (MBEDTLS_ERR_PK_PASSWORD_REQUIRED=
 =3D=3D status)</span><br><span>         {</span><br><span>             cha=
r passbuf[512] =3D {0};</span><br><span>             pem_password_callback(=
passbuf, 512, 0, NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            status =3D mbedtls_pk_parse_key(ctx-&gt;priv_key,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
         (const unsigned char *) priv_key_file,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                          strlen(=
priv_key_file) + 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                                        (unsigned char *) passbuf,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                              =
            strlen(passbuf),</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                          mbedtls_ctr_drbg_random,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
                   rand_ctx_get());</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            status =3D mbedtls_compat_pk_parse_key(ctx-&gt;=
priv_key,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                                       (const unsigned char *) priv_key_fil=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                                strlen(priv_key_file) + 1,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                                    =
             (unsigned char *) passbuf,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                                 strlen=
(passbuf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                                        mbedtls_ctr_drbg_random,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
                   rand_ctx_get());</span><br><span>         }</span><br><s=
pan>     }</span><br><span>     else</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        status =3D mbedtls_pk_parse_k=
eyfile(ctx-&gt;priv_key,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                          priv_key_file,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
     NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                               mbedtls_ctr_drbg_random,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                                         =
 rand_ctx_get());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      status =3D mbedtls_compat_pk_parse_keyfile(ctx-&gt;priv_key,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
                     priv_key_file,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                                 NULL,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
                         mbedtls_ctr_drbg_random,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                                             =
    rand_ctx_get());</span><br><span>         if (MBEDTLS_ERR_PK_PASSWORD_R=
EQUIRED =3D=3D status)</span><br><span>         {</span><br><span>         =
    char passbuf[512] =3D {0};</span><br><span>             pem_password_ca=
llback(passbuf, 512, 0, NULL);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            status =3D mbedtls_pk_parse_keyfile(ctx-&gt;priv_key,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
                        priv_key_file, passbuf,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                              mbe=
dtls_ctr_drbg_random,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                                              rand_ctx_get());</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            status =3D mbedtls_c=
ompat_pk_parse_keyfile(ctx-&gt;priv_key,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                                     p=
riv_key_file, passbuf,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                                                     mbedtls_ctr_drbg_ra=
ndom,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                                       rand_ctx_get());</span><br><span>   =
      }</span><br><span>     }</span><br><span>     if (!mbed_ok(status))</=
span><br><span>@@ -553,9 +552,12 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     if (!mbed_ok(mbedtls_pk_check_pair(&amp;ctx-&gt;crt_=
chain-&gt;pk,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                               ctx-&gt;priv_key,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                                       mbedtls_c=
tr_drbg_random,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                                 rand_ctx_get())))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                                       ctx-&=
gt;priv_key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if MBED=
TLS_VERSION_NUMBER &gt;=3D 0x03000000</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                       , mbedtls_ctr_drbg=
_random,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                            rand_ctx_get()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                       )))</span><br><span>     {=
</span><br><span>         msg(M_WARN, &quot;Private key does not match the =
certificate&quot;);</span><br><span>         return 1;</span><br><span>@@ -=
585,6 +587,9 @@</span><br><span> static inline int</span><br><span> externa=
l_pkcs1_sign( void *ctx_voidptr,</span><br><span>                      int =
(*f_rng)(void *, unsigned char *, size_t), void *p_rng,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x03020=
100</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
     int mode,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span>                      mbedtls_md_type_t md_alg, unsigned =
int hashlen, const unsigned char *hash,</span><br><span>                   =
   unsigned char *sig )</span><br><span> {</span><br><span>@@ -599,6 +604,1=
3 @@</span><br><span>         return MBEDTLS_ERR_RSA_BAD_INPUT_DATA;</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#if MBEDTLS_VERSION_NUMBER &lt; 0x03020100</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (MBEDTLS_RSA_PRIVATE !=3D mode=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        return MBEDTLS_RSA_BAD_I=
NPUT_DATA;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     /*</span><br><=
span>      * Support a wide range of hashes. TLSv1.1 and before only need S=
IG_RSA_RAW,</span><br><span>      * but TLSv1.2 needs the full suite of has=
hes.</span><br><span>@@ -1173,7 +1185,7 @@</span><br><span> </span><br><spa=
n>     /* Initialize minimum TLS version */</span><br><span>     {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        const int tls_version_=
min =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t int configured_tls_version_min =3D</span><br><span>             (session-=
&gt;opt-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MIN_SHIFT)</span><br><span>=
             &amp;SSLF_TLS_VERSION_MIN_MASK;</span><br><span> </span><br><s=
pan>@@ -1181,9 +1193,9 @@</span><br><span>         int major =3D MBEDTLS_SS=
L_MAJOR_VERSION_3;</span><br><span>         int minor =3D MBEDTLS_SSL_MINOR=
_VERSION_3;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        if (tls_version_min &gt; TLS_VER_UNSPEC)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        if (configured_tls_version_min=
 &gt; TLS_VER_UNSPEC)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            tls_version_to_major_minor(tls_versi=
on_min, &amp;major, &amp;minor);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            tls_version_to_major_minor(configured_tls_version_=
min, &amp;major, &amp;minor);</span><br><span>         }</span><br><span> <=
/span><br><span>         mbedtls_ssl_conf_min_version(ks_ssl-&gt;ssl_config=
, major, minor);</span><br><span>@@ -1191,17 +1203,21 @@</span><br><span> <=
/span><br><span>     /* Initialize maximum TLS version */</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const in=
t tls_version_max =3D</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        const int configured_tls_version_max =3D</span><br><span>        =
     (session-&gt;opt-&gt;ssl_flags &gt;&gt; SSLF_TLS_VERSION_MAX_SHIFT)</s=
pan><br><span>             &amp;SSLF_TLS_VERSION_MAX_MASK;</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* default t=
o TLS 1.3 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        i=
nt major =3D MBEDTLS_SSL_MAJOR_VERSION_3;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        int minor =3D MBEDTLS_SSL_MINOR_VERSION_4;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        int major =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int minor =
=3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        if (tls_version_max &gt; TLS_VER_UNSPEC)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (configured_tls_version_max &g=
t; TLS_VER_UNSPEC)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            tls_version_to_major_minor(tls_version_=
max, &amp;major, &amp;minor);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            tls_version_to_major_minor(configured_tls_version_max=
, &amp;major, &amp;minor);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Defau=
lt to tls_version_max(). */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            tls_version_to_major_minor(tls_version_max(), &amp;majo=
r, &amp;minor);</span><br><span>         }</span><br><span> </span><br><spa=
n>         mbedtls_ssl_conf_max_version(ks_ssl-&gt;ssl_config, major, minor=
);</span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/open=
vpn/ssl_verify_mbedtls.c</span><br><span>index 33c3769..ce21324 100644</spa=
n><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/sr=
c/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -35,6 +35,7 @@</span><br>=
<span> #if defined(ENABLE_CRYPTO_MBEDTLS)</span><br><span> </span><br><span=
> #include &quot;crypto_mbedtls.h&quot;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &quot;mbedtls_compat.h&quot;</span><br><span> =
#include &quot;ssl_verify.h&quot;</span><br><span> #include &lt;mbedtls/asn=
1.h&gt;</span><br><span> #include &lt;mbedtls/error.h&gt;</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/371?usp=3Demail">change 371</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/371?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I143ca14c27c0c378b5e6b4184e8=
0890d2c0e225e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 371 </div>
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


--SvPihwpKBAk=--

