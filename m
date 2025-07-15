From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 15 Jul 2025 11:27:36 +0000
In-Reply-To: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
References: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <923170b0c8225ece5de9e7e9b7d001d46a64af10-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Hp0qHjxK1ho="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Cleanup/simplify
 mbed TLS related define from autoconf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Hp0qHjxK1ho=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail

to look at the new patch set (#9).


Change subject: Cleanup/simplify mbed TLS related define from autoconf
......................................................................

Cleanup/simplify mbed TLS related define from autoconf

Instead of a custom logic using 0/1 to be defined when the functions
are present or not, use the standard check and adjust the source code
accordingly.

Also not compile mbed key helper with MBEDTLS_SSL_KEYING_MATERIAL_EXPORT

The helper methods are only used when we don't have
MBEDTLS_SSL_KEYING_MATERIAL_EXPORT and mbedtls_ssl_export_keying_material.

Remove AEAD check that tests for presence of mbedtls_cipher_write_tag
and mbedtls_cipher_check_tag. Having an mbed TLS version that does not
support that is highly unlikely. It might have been a good check in
PolarSSL's time but is not today anymore.

This also adds some missing support for mbed 2.x related defines to
cmake based build.

Change-Id: I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M src/openvpn/crypto_mbedtls.c
M src/openvpn/mbedtls_compat.h
M src/openvpn/ssl_mbedtls.c
6 files changed, 24 insertions(+), 46 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1081/9

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 40bffd4..efb2d2d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -302,7 +302,8 @@
     check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAV=
E_MBEDTLS_CTR_DRBG_UPDATE_RET)
     check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h =
HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
     check_symbol_exists(mbedtls_ssl_set_export_keys_cb mbedtls/ssl.h HAVE_=
MBEDTLS_SSL_SET_EXPORT_KEYS_CB)
-    check_include_files(psa/crypto.h HAVE_MBEDTLS_PSA_CRYPTO_H)
+    check_symbol_exists(mbedtls_ssl_tls_prf mbedtls/ssl.h HAVE_MBEDTLS_SSL=
_TLS_PRF)
+    check_include_files(psa/crypto.h HAVE_PSA_CRYPTO_H)
 endfunction()

 if (${MBED})
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 5df0ac8..1c443ab 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -370,10 +370,11 @@
 #undef HAVE_VFORK_H

 /* Availability of different mbed TLS features and APIs */
-#cmakedefine01 HAVE_MBEDTLS_PSA_CRYPTO_H
-#define HAVE_MBEDTLS_SSL_TLS_PRF 1
-#cmakedefine01 HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
-#cmakedefine01 HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
+#cmakedefine HAVE_PSA_CRYPTO_H
+#cmakedefine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+#cmakedefine HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+#cmakedefine HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
+#cmakedefine HAVE_MBEDTLS_SSL_TLS_PRF

 /* Path to ifconfig tool */
 #define IFCONFIG_PATH "@IFCONFIG_PATH@"
diff --git a/configure.ac b/configure.ac
index 02b45f8..8fc48ba 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1038,38 +1038,12 @@
 		[AC_MSG_ERROR([mbed TLS version >=3D 2.0.0 or >=3D 3.2.1 required])]
 	)

-	AC_CHECK_HEADER(
-		psa/crypto.h,
-		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [1], [yes])],
-		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [0], [no])]
-	)
+	AC_CHECK_HEADERS(psa/crypto.h)

-	AC_CHECK_FUNCS(
-		[ \
-			mbedtls_cipher_write_tag \
-			mbedtls_cipher_check_tag \
-		],
-		,
-		[AC_MSG_ERROR([mbed TLS check for AEAD support failed])]
-	)
+	AC_CHECK_FUNCS([mbedtls_ssl_tls_prf mbedtls_ssl_conf_export_keys_ext_cb])

-	AC_CHECK_FUNC(
-		[mbedtls_ssl_tls_prf],
-		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [1], [yes])],
-		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]
-	)
-
-	AC_CHECK_FUNC(
-		[mbedtls_ssl_conf_export_keys_ext_cb],
-		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],
-		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [0], [no])]
-	)
 	if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb" !=3D xyes; then
-		AC_CHECK_FUNC(
-			[mbedtls_ssl_set_export_keys_cb],
-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [yes])],
-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
-		)
+		AC_CHECK_FUNCS([mbedtls_ssl_set_export_keys_cb])
 		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" !=3D xyes; then
 			AC_CHECK_FUNC([mbedtls_ssl_export_keying_material])
 			if test "x$ac_cv_func_mbedtls_ssl_export_keying_material" !=3D xyes; th=
en
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index c05902d..1f3dcba 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -981,7 +981,7 @@
 }
 /* mbedtls-2.18.0 or newer implements tls_prf, but prf_tls1 is removed
  * from recent versions, so we use our own implementation if necessary. */
-#if HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1)
+#if defined(HAVE_MBEDTLS_SSL_TLS_PRF) && defined(MBEDTLS_SSL_TLS_PRF_TLS1)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
@@ -990,7 +990,7 @@
                                        secret_len, "", seed, seed_len, out=
put,
                                        output_len));
 }
-#else /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
+#else /* defined(HAVE_MBEDTLS_SSL_TLS_PRF) && defined(MBEDTLS_SSL_TLS_PRF_=
TLS1) */
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 145a7ae..aeb0c5f 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -48,7 +48,7 @@
 #include <mbedtls/version.h>
 #include <mbedtls/x509_crt.h>

-#if HAVE_MBEDTLS_PSA_CRYPTO_H
+#ifdef HAVE_PSA_CRYPTO_H
     #include <psa/crypto.h>
 #endif

@@ -61,14 +61,14 @@
 static inline void
 mbedtls_compat_psa_crypto_init(void)
 {
-#if HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C)
+#if defined(HAVE_PSA_CRYPTO_H) && defined(MBEDTLS_PSA_CRYPTO_C)
     if (psa_crypto_init() !=3D PSA_SUCCESS)
     {
         msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
     }
 #else
     return;
-#endif /* HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
+#endif
 }

 static inline mbedtls_compat_group_id
@@ -96,7 +96,7 @@
 {
 #if MBEDTLS_VERSION_NUMBER > 0x03000000
     return mbedtls_ctr_drbg_update(ctx, additional, add_len);
-#elif HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
+#elif defined(HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)
     return mbedtls_ctr_drbg_update_ret(ctx, additional, add_len);
 #else
     mbedtls_ctr_drbg_update(ctx, additional, add_len);
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ecccc26..a4bb772 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -173,8 +173,9 @@
     ASSERT(NULL !=3D ctx);
     return ctx->initialised;
 }
-
-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+#ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT
+/* mbedtls_ssl_export_keying_material does not need helper/callback method=
s */
+#elif defined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
 /*
  * Key export callback for older versions of mbed TLS, to be used with
  * mbedtls_ssl_conf_export_keys_ext_cb(). It is called with the master
@@ -205,7 +206,7 @@

     return 0;
 }
-#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+#elif defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB)
 /*
  * Key export callback for newer versions of mbed TLS, to be used with
  * mbedtls_ssl_set_export_keys_cb(). When used with TLS 1.2, the callback
@@ -251,10 +252,11 @@
     memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
     cache->tls_prf_type =3D tls_prf_type;
 }
-#elif !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#else  /* ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT */
 #error mbedtls_ssl_conf_export_keys_ext_cb, mbedtls_ssl_set_export_keys_cb=
 or mbedtls_ssl_export_keying_material must be available in mbed TLS
 #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */

+
 bool
 key_state_export_keying_material(struct tls_session *session,
                                  const char *label, size_t label_size,
@@ -1244,7 +1246,7 @@
         mbedtls_ssl_conf_max_tls_version(ks_ssl->ssl_config, version);
     }

-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB && !defined(MBEDTLS_SSL_KEYIN=
G_MATERIAL_EXPORT)
+#if defined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB) && !defined(MBEDTLS_=
SSL_KEYING_MATERIAL_EXPORT)
     /* Initialize keying material exporter, old style. */
     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
                                         mbedtls_ssl_export_keys_cb, sessio=
n);
@@ -1259,7 +1261,7 @@
      * verification. */
     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));

-#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB && !defined(MBEDTLS_SSL_KEYING_MAT=
ERIAL_EXPORT)
+#if defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB) && !defined(MBEDTLS_SSL_K=
EYING_MATERIAL_EXPORT)
     /* Initialize keying material exporter, new style. */
     mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb=
, session);
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd
Gerrit-Change-Number: 1081
Gerrit-PatchSet: 9
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: newpatchset

--Hp0qHjxK1ho=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #9</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Cleanup/simplify mbed TLS related define from autoconf<br><br>Instea=
d of a custom logic using 0/1 to be defined when the functions<br>are prese=
nt or not, use the standard check and adjust the source code<br>accordingly=
.<br><br>Also not compile mbed key helper with MBEDTLS_SSL_KEYING_MATERIAL_=
EXPORT<br><br>The helper methods are only used when we don&#39;t have<br>MB=
EDTLS_SSL_KEYING_MATERIAL_EXPORT and mbedtls_ssl_export_keying_material.<br=
><br>Remove AEAD check that tests for presence of mbedtls_cipher_write_tag<=
br>and mbedtls_cipher_check_tag. Having an mbed TLS version that does not<b=
r>support that is highly unlikely. It might have been a good check in<br>Po=
larSSL&#39;s time but is not today anymore.<br><br>This also adds some miss=
ing support for mbed 2.x related defines to<br>cmake based build.<br><br>Ch=
ange-Id: I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd<br>Signed-off-by: Arne S=
chwabe &lt;arne@...1227...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.cma=
ke.in<br>M configure.ac<br>M src/openvpn/crypto_mbedtls.c<br>M src/openvpn/=
mbedtls_compat.h<br>M src/openvpn/ssl_mbedtls.c<br>6 files changed, 24 inse=
rtions(+), 46 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/81/1081/9</pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMak=
eLists.txt</span><br><span>index 40bffd4..efb2d2d 100644</span><br><span>--=
- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ =
-302,7 +302,8 @@</span><br><span>     check_symbol_exists(mbedtls_ctr_drbg_=
update_ret mbedtls/ctr_drbg.h HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)</span><br><=
span>     check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/s=
sl.h HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)</span><br><span>     check_s=
ymbol_exists(mbedtls_ssl_set_export_keys_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_=
SET_EXPORT_KEYS_CB)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  check_include_files(psa/crypto.h HAVE_MBEDTLS_PSA_CRYPTO_H)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    check_symbol_exists(mbedtls_s=
sl_tls_prf mbedtls/ssl.h HAVE_MBEDTLS_SSL_TLS_PRF)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    check_include_files(psa/crypto.h HAVE_PS=
A_CRYPTO_H)</span><br><span> endfunction()</span><br><span> </span><br><spa=
n> if (${MBED})</span><br><span>diff --git a/config.h.cmake.in b/config.h.c=
make.in</span><br><span>index 5df0ac8..1c443ab 100644</span><br><span>--- a=
/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>=
@@ -370,10 +370,11 @@</span><br><span> #undef HAVE_VFORK_H</span><br><span>=
 </span><br><span> /* Availability of different mbed TLS features and APIs =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#cmakedefine01 HAVE=
_MBEDTLS_PSA_CRYPTO_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define HAVE_MBEDTLS_SSL_TLS_PRF 1</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#cmakedefine01 HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#cmakedefine01 HAVE_MBEDTLS_CTR_D=
RBG_UPDATE_RET</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmak=
edefine HAVE_PSA_CRYPTO_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#cmakedefine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_MBEDTLS_SSL_CONF_EXPOR=
T_KEYS_EXT_CB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmake=
define HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#cmakedefine HAVE_MBEDTLS_SSL_TLS_PRF</span><br><span> =
</span><br><span> /* Path to ifconfig tool */</span><br><span> #define IFCO=
NFIG_PATH &quot;@IFCONFIG_PATH@&quot;</span><br><span>diff --git a/configur=
e.ac b/configure.ac</span><br><span>index 02b45f8..8fc48ba 100644</span><br=
><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><spa=
n>@@ -1038,38 +1038,12 @@</span><br><span> 		[AC_MSG_ERROR([mbed TLS versio=
n &gt;=3D 2.0.0 or &gt;=3D 3.2.1 required])]</span><br><span> 	)</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_HEAD=
ER(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		psa/crypto.h,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-		[AC_DEFINE([HAVE_MBEDT=
LS_PSA_CRYPTO_H], [1], [yes])],</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [0], [no])]</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-	)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	AC_CHECK_HEADERS(psa/crypto.h)</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_FUNCS(</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-		[ \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-			mbedtls_cipher_write_tag \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-			mbedtls_cipher_check_tag \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-		],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-		[AC_MSG_ERROR([mbed TLS check for AEAD support failed])]</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK_FUNCS([mbedtls_ssl_tls_prf mbed=
tls_ssl_conf_export_keys_ext_cb])</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_FUNC(</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-		[mbedtls_ssl_tls_prf],</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [1], =
[yes])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[AC_DEFINE(=
[HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_FUNC(</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-		[mbedtls_ssl_conf_export_k=
eys_ext_cb],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[AC_DEF=
INE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF=
_EXPORT_KEYS_EXT_CB], [0], [no])]</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	)</span><br><span> 	if test &quot;x$ac_cv_func_mbedtls_ssl_con=
f_export_keys_ext_cb&quot; !=3D xyes; then</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-		AC_CHECK_FUNC(</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-			[mbedtls_ssl_set_export_keys_cb],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_=
KEYS_CB], [1], [yes])],</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-		)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+		AC_CHECK_FUNCS([mbedtls_ssl_set_export_keys_=
cb])</span><br><span> 		if test &quot;x$ac_cv_func_mbedtls_ssl_set_export_k=
eys_cb&quot; !=3D xyes; then</span><br><span> 			AC_CHECK_FUNC([mbedtls_ssl=
_export_keying_material])</span><br><span> 			if test &quot;x$ac_cv_func_mb=
edtls_ssl_export_keying_material&quot; !=3D xyes; then</span><br><span>diff=
 --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span>=
<br><span>index c05902d..1f3dcba 100644</span><br><span>--- a/src/openvpn/c=
rypto_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><b=
r><span>@@ -981,7 +981,7 @@</span><br><span> }</span><br><span> /* mbedtls-=
2.18.0 or newer implements tls_prf, but prf_tls1 is removed</span><br><span=
>  * from recent versions, so we use our own implementation if necessary. *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_SSL=
_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_MBEDTLS_SSL_TLS_PRF) &am=
p;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1)</span><br><span> bool</span><br><=
span> ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret=
,</span><br><span>              int secret_len, uint8_t *output, int output=
_len)</span><br><span>@@ -990,7 +990,7 @@</span><br><span>                 =
                       secret_len, &quot;&quot;, seed, seed_len, output,</s=
pan><br><span>                                        output_len));</span><=
br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* H=
AVE_MBEDTLS_SSL_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* defined(HAVE_M=
BEDTLS_SSL_TLS_PRF) &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) */</span><=
br><span> /*</span><br><span>  * Generate the hash required by for the \c t=
ls1_PRF function.</span><br><span>  *</span><br><span>diff --git a/src/open=
vpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h</span><br><span>index 1=
45a7ae..aeb0c5f 100644</span><br><span>--- a/src/openvpn/mbedtls_compat.h</=
span><br><span>+++ b/src/openvpn/mbedtls_compat.h</span><br><span>@@ -48,7 =
+48,7 @@</span><br><span> #include &lt;mbedtls/version.h&gt;</span><br><spa=
n> #include &lt;mbedtls/x509_crt.h&gt;</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_PSA_CRYPTO_H</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_PSA_CRYPTO_H</span=
><br><span>     #include &lt;psa/crypto.h&gt;</span><br><span> #endif</span=
><br><span> </span><br><span>@@ -61,14 +61,14 @@</span><br><span> static in=
line void</span><br><span> mbedtls_compat_psa_crypto_init(void)</span><br><=
span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDT=
LS_PSA_CRYPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_PSA_CRYPTO_H) &amp;&a=
mp; defined(MBEDTLS_PSA_CRYPTO_C)</span><br><span>     if (psa_crypto_init(=
) !=3D PSA_SUCCESS)</span><br><span>     {</span><br><span>         msg(M_F=
ATAL, &quot;mbedtls: psa_crypto_init() failed&quot;);</span><br><span>     =
}</span><br><span> #else</span><br><span>     return;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_MBEDTLS_PSA_CRYPTO_H &amp;&a=
mp; defined(MBEDTLS_PSA_CRYPTO_C) */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </span><br><spa=
n> static inline mbedtls_compat_group_id</span><br><span>@@ -96,7 +96,7 @@<=
/span><br><span> {</span><br><span> #if MBEDTLS_VERSION_NUMBER &gt; 0x03000=
000</span><br><span>     return mbedtls_ctr_drbg_update(ctx, additional, ad=
d_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif HAVE_MBE=
DTLS_CTR_DRBG_UPDATE_RET</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#elif defined(HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)</span><br><span>     r=
eturn mbedtls_ctr_drbg_update_ret(ctx, additional, add_len);</span><br><spa=
n> #else</span><br><span>     mbedtls_ctr_drbg_update(ctx, additional, add_=
len);</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/=
ssl_mbedtls.c</span><br><span>index ecccc26..a4bb772 100644</span><br><span=
>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbed=
tls.c</span><br><span>@@ -173,8 +173,9 @@</span><br><span>     ASSERT(NULL =
!=3D ctx);</span><br><span>     return ctx-&gt;initialised;</span><br><span=
> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_E=
XT_CB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef MBEDTLS=
_SSL_KEYING_MATERIAL_EXPORT</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+/* mbedtls_ssl_export_keying_material does not need helper/callback=
 methods */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif de=
fined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)</span><br><span> /*</span><=
br><span>  * Key export callback for older versions of mbed TLS, to be used=
 with</span><br><span>  * mbedtls_ssl_conf_export_keys_ext_cb(). It is call=
ed with the master</span><br><span>@@ -205,7 +206,7 @@</span><br><span> </s=
pan><br><span>     return 0;</span><br><span> }</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(HAVE_MBEDTLS_=
SSL_SET_EXPORT_KEYS_CB)</span><br><span> /*</span><br><span>  * Key export =
callback for newer versions of mbed TLS, to be used with</span><br><span>  =
* mbedtls_ssl_set_export_keys_cb(). When used with TLS 1.2, the callback</s=
pan><br><span>@@ -251,10 +252,11 @@</span><br><span>     memcpy(cache-&gt;m=
aster_secret, secret, sizeof(cache-&gt;master_secret));</span><br><span>   =
  cache-&gt;tls_prf_type =3D tls_prf_type;</span><br><span> }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#elif !defined(MBEDTLS_SSL_KEYING_M=
ATERIAL_EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#els=
e  /* ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT */</span><br><span> #error m=
bedtls_ssl_conf_export_keys_ext_cb, mbedtls_ssl_set_export_keys_cb or mbedt=
ls_ssl_export_keying_material must be available in mbed TLS</span><br><span=
> #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> boo=
l</span><br><span> key_state_export_keying_material(struct tls_session *ses=
sion,</span><br><span>                                  const char *label, =
size_t label_size,</span><br><span>@@ -1244,7 +1246,7 @@</span><br><span>  =
       mbedtls_ssl_conf_max_tls_version(ks_ssl-&gt;ssl_config, version);</s=
pan><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB &amp;&amp; !d=
efined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB=
) &amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span> =
    /* Initialize keying material exporter, old style. */</span><br><span> =
    mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl-&gt;ssl_config,</span><br><s=
pan>                                         mbedtls_ssl_export_keys_cb, se=
ssion);</span><br><span>@@ -1259,7 +1261,7 @@</span><br><span>      * verif=
ication. */</span><br><span>     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks=
_ssl-&gt;ctx, NULL)));</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB &amp;&amp; !defi=
ned(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB) &amp;&=
amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span>     /* I=
nitialize keying material exporter, new style. */</span><br><span>     mbed=
tls_ssl_set_export_keys_cb(ks_ssl-&gt;ctx, mbedtls_ssl_export_keys_cb, sess=
ion);</span><br><span> #endif</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail">ch=
ange 1081</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f325800ebeb20bd5ef3ff78e5c=
5fcf0f6f74efd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--Hp0qHjxK1ho=--

