From: "MaxF (Code Review)" <gerrit@...515...>
Date: Fri, 10 Nov 2023 15:35:50 +0000
References: <gerrit.1699630545000.I8e90530726b7f7ba3cee0438f2d81a1ac42e821b@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <daab388102c1b48e353a968c2ee91070aa73a59e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oWJX2Xht0us="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Enable key export
 with mbed TLS 3.x.y
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

--oWJX2Xht0us=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/402?usp=3Demail

to review the following change.


Change subject: Enable key export with mbed TLS 3.x.y
......................................................................

Enable key export with mbed TLS 3.x.y

Change-Id: I8e90530726b7f7ba3cee0438f2d81a1ac42e821b
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/Makefile.am
M src/openvpn/crypto_mbedtls.c
M src/openvpn/mbedtls_compat.h
M src/openvpn/ssl_mbedtls.c
6 files changed, 83 insertions(+), 21 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/402/1

diff --git a/config.h.cmake.in b/config.h.cmake.in
index f2cdd39..ed4978a 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -387,7 +387,10 @@
 #undef HAVE_VSNPRINTF

 /* we always assume a recent mbed TLS version */
-#define HAVE_CTR_DRBG_UPDATE_RET 1
+#define HAVE_MBEDTLS_PSA_CRYPTO_H 1
+#define HAVE_MBEDTLS_SSL_TLS_PRF 1
+#define HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB 1
+#define HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET 1

 /* Path to ifconfig tool */
 #define IFCONFIG_PATH "@IFCONFIG_PATH@"
diff --git a/configure.ac b/configure.ac
index 7e5763d..84eaad6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1025,11 +1025,11 @@
 		[AC_MSG_ERROR([mbed TLS version >=3D 2.0.0 or >=3D 3.2.1 required])]
 	)

-    AC_CHECK_HEADER(
-        psa/crypto.h,
-        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [1], [yes])],
-        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [0], [no])]
-    )
+	AC_CHECK_HEADER(
+		psa/crypto.h,
+		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [1], [yes])],
+		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [0], [no])]
+	)

 	AC_CHECK_FUNCS(
 		[ \
@@ -1040,16 +1040,32 @@
 		[AC_MSG_ERROR([mbed TLS check for AEAD support failed])]
 	)

+	AC_CHECK_FUNC(
+		[mbedtls_ssl_tls_prf],
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [1], [yes])],
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]
+	)
+
 	have_export_keying_material=3D"yes"
 	AC_CHECK_FUNC(
 		[mbedtls_ssl_conf_export_keys_ext_cb],
-		,
-		[have_export_keying_material=3D"no"]
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],
+		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [0], [no])]
 	)
+	if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb" !=3D xyes; then
+		AC_CHECK_FUNC(
+			[mbedtls_ssl_set_export_keys_cb],
+			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [yes])],
+			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
+		)
+		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" !=3D xyes; then
+			have_export_keying_material=3D"no"
+		fi
+	fi

 	AC_CHECK_FUNC(
 		[mbedtls_ctr_drbg_update_ret],
-		AC_DEFINE([HAVE_CTR_DRBG_UPDATE_RET], [1],
+		AC_DEFINE([HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET], [1],
 			  [Use mbedtls_ctr_drbg_update_ret from mbed TLS]),
 	)

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 52deef8..b953961 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -82,6 +82,7 @@
 	ovpn_dco_win.h \
 	platform.c platform.h \
 	console.c console.h console_builtin.c console_systemd.c \
+	mbedtls_compat.h \
 	mroute.c mroute.h \
 	mss.c mss.h \
 	mstats.c mstats.h \
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index aaf6ef7..ad3439c 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -989,8 +989,9 @@

     return diff;
 }
-/* mbedtls-2.18.0 or newer */
-#ifdef HAVE_MBEDTLS_SSL_TLS_PRF
+/* mbedtls-2.18.0 or newer implements tls_prf, but prf_tls1 is removed
+ * from recent versions, so we use our own implementation if necessary. */
+#if HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1)
 bool
 ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uint8_t *secret,
              int secret_len, uint8_t *output, int output_len)
@@ -999,7 +1000,7 @@
                                        secret_len, "", seed, seed_len, out=
put,
                                        output_len));
 }
-#else  /* ifdef HAVE_MBEDTLS_SSL_TLS_PRF */
+#else /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
 /*
  * Generate the hash required by for the \c tls1_PRF function.
  *
@@ -1128,5 +1129,5 @@
     gc_free(&gc);
     return true;
 }
-#endif /* ifdef HAVE_MBEDTLS_SSL_TLS_PRF */
+#endif /* HAVE_MBEDTLS_SSL_TLS_PRF && defined(MBEDTLS_SSL_TLS_PRF_TLS1) */
 #endif /* ENABLE_CRYPTO_MBEDTLS */
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index fe7c3f9..610215b 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -33,6 +33,8 @@
 #ifndef MBEDTLS_COMPAT_H_
 #define MBEDTLS_COMPAT_H_

+#include "syshead.h"
+
 #include "errlevel.h"

 #include <mbedtls/cipher.h>
@@ -41,24 +43,25 @@
 #include <mbedtls/md.h>
 #include <mbedtls/pem.h>
 #include <mbedtls/pk.h>
+#include <mbedtls/ssl.h>
 #include <mbedtls/version.h>
 #include <mbedtls/x509_crt.h>

-#if MBEDTLS_HAVE_PSA_CRYPTO_H
+#if HAVE_MBEDTLS_PSA_CRYPTO_H
     #include <psa/crypto.h>
 #endif

 static inline void
 mbedtls_compat_psa_crypto_init(void)
 {
-#if MBEDTLS_HAVE_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C)
+#if HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C)
     if (psa_crypto_init() !=3D PSA_SUCCESS)
     {
         msg(M_FATAL, "mbedtls: psa_crypto_init() failed");
     }
 #else
     return;
-#endif /* MBEDTLS_HAVE_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
+#endif /* HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C) */
 }

 /*
@@ -74,14 +77,14 @@
                                const unsigned char *additional,
                                size_t add_len)
 {
-#if HAVE_CTR_DRBG_UPDATE_RET
+#if HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
     return mbedtls_ctr_drbg_update_ret(ctx, additional, add_len);
 #elif MBEDTLS_VERSION_NUMBER < 0x03020100
     mbedtls_ctr_drbg_update(ctx, additional, add_len);
     return 0;
 #else
     return mbedtls_ctr_drbg_update(ctx, additional, add_len);
-#endif /* HAVE_CTR_DRBG_UPDATE_RET */
+#endif /* HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET */
 }

 static inline int
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 4ece37e..09559be 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -173,6 +173,8 @@
 }

 #ifdef HAVE_EXPORT_KEYING_MATERIAL
+
+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
 int
 mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
                            const unsigned char *kb, size_t maclen,
@@ -193,8 +195,38 @@
     memcpy(cache->master_secret, ms, sizeof(cache->master_secret));
     cache->tls_prf_type =3D tls_prf_type;

-    return true;
+    return 0;
 }
+#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+void
+mbedtls_ssl_export_keys_cb(void *p_expkey,
+                           mbedtls_ssl_key_export_type type,
+                           const unsigned char *secret,
+                           size_t secret_len,
+                           const unsigned char client_random[32],
+                           const unsigned char server_random[32],
+                           mbedtls_tls_prf_types tls_prf_type)
+{
+    if (type !=3D MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET)
+    {
+        return;
+    }
+
+    struct tls_session *session =3D p_expkey;
+    struct key_state_ssl *ks_ssl =3D &session->key[KS_PRIMARY].ks_ssl;
+    struct tls_key_cache *cache =3D &ks_ssl->tls_key_cache;
+
+    if (secret_len !=3D sizeof(cache->master_secret))
+    {
+        return;
+    }
+
+    memcpy(cache->client_server_random, client_random, 32);
+    memcpy(cache->client_server_random + 32, server_random, 32);
+    memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
+    cache->tls_prf_type =3D tls_prf_type;
+}
+#endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */

 bool
 key_state_export_keying_material(struct tls_session *session,
@@ -212,6 +244,7 @@
         return false;
     }

+    msg(M_INFO, "running prf");
     int ret =3D mbedtls_ssl_tls_prf(cache->tls_prf_type, cache->master_sec=
ret,
                                   sizeof(cache->master_secret),
                                   label, cache->client_server_random,
@@ -1205,8 +1238,8 @@
         mbedtls_ssl_conf_max_version(ks_ssl->ssl_config, major, minor);
     }

-#ifdef HAVE_EXPORT_KEYING_MATERIAL
-    /* Initialize keying material exporter */
+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+    /* Initialize keying material exporter, old style. */
     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
                                         mbedtls_ssl_export_keys_cb, sessio=
n);
 #endif
@@ -1216,6 +1249,11 @@
     mbedtls_ssl_init(ks_ssl->ctx);
     mbed_ok(mbedtls_ssl_setup(ks_ssl->ctx, ks_ssl->ssl_config));

+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+    /* Initialize keying material exporter, new style. */
+    mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb=
, session);
+#endif
+
     /* Initialise BIOs */
     ALLOC_OBJ_CLEAR(ks_ssl->bio_ctx, bio_ctx);
     mbedtls_ssl_set_bio(ks_ssl->ctx, ks_ssl->bio_ctx, ssl_bio_write,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/402?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8e90530726b7f7ba3cee0438f2d81a1ac42e821b
Gerrit-Change-Number: 402
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--oWJX2Xht0us=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/402?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Enable key export with mbed TLS 3.x.y<br><br>Change-Id: I8e90=
530726b7f7ba3cee0438f2d81a1ac42e821b<br>Signed-off-by: Max Fillinger &lt;ma=
ximilian.fillinger@...2507...&gt;<br>---<br>M config.h.cmake.in<br>M config=
ure.ac<br>M src/openvpn/Makefile.am<br>M src/openvpn/crypto_mbedtls.c<br>M =
src/openvpn/mbedtls_compat.h<br>M src/openvpn/ssl_mbedtls.c<br>6 files chan=
ged, 83 insertions(+), 21 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/02/402/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/config.h.c=
make.in b/config.h.cmake.in</span><br><span>index f2cdd39..ed4978a 100644</=
span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake=
.in</span><br><span>@@ -387,7 +387,10 @@</span><br><span> #undef HAVE_VSNPR=
INTF</span><br><span> </span><br><span> /* we always assume a recent mbed T=
LS version */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define =
HAVE_CTR_DRBG_UPDATE_RET 1</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define HAVE_MBEDTLS_PSA_CRYPTO_H 1</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#define HAVE_MBEDTLS_SSL_TLS_PRF 1</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define HAVE_MBEDTLS_SSL_SET_EXPORT_K=
EYS_CB 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAV=
E_MBEDTLS_CTR_DRBG_UPDATE_RET 1</span><br><span> </span><br><span> /* Path =
to ifconfig tool */</span><br><span> #define IFCONFIG_PATH &quot;@IFCONFIG_=
PATH@&quot;</span><br><span>diff --git a/configure.ac b/configure.ac</span>=
<br><span>index 7e5763d..84eaad6 100644</span><br><span>--- a/configure.ac<=
/span><br><span>+++ b/configure.ac</span><br><span>@@ -1025,11 +1025,11 @@<=
/span><br><span> 		[AC_MSG_ERROR([mbed TLS version &gt;=3D 2.0.0 or &gt;=3D=
 3.2.1 required])]</span><br><span> 	)</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    AC_CHECK_HEADER(</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        psa/crypto.h,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYP=
TO_H], [1], [yes])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [0], [no])]</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    )</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	AC_CHECK_HEADER(</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+		psa/crypto.h,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [1], [yes])],</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE([HAVE_MBE=
DTLS_PSA_CRYPTO_H], [0], [no])]</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	)</span><br><span> </span><br><span> 	AC_CHECK_FUNCS(</span><b=
r><span> 		[ \</span><br><span>@@ -1040,16 +1040,32 @@</span><br><span> 		[=
AC_MSG_ERROR([mbed TLS check for AEAD support failed])]</span><br><span> 	)=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
AC_CHECK_FUNC(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[mb=
edtls_ssl_tls_prf],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [1], [yes])],</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF],=
 [0], [no])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> 	have_=
export_keying_material=3D&quot;yes&quot;</span><br><span> 	AC_CHECK_FUNC(</=
span><br><span> 		[mbedtls_ssl_conf_export_keys_ext_cb],</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-		,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-		[have_export_keying_material=3D&quot;no&quot;]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE([HAVE_MBEDTLS_SS=
L_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_C=
B], [0], [no])]</span><br><span> 	)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	if test &quot;x$ac_cv_func_mbedtls_ssl_conf_export_keys_ex=
t_cb&quot; !=3D xyes; then</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+		AC_CHECK_FUNC(</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+			[mbedtls_ssl_set_export_keys_cb],</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [=
1], [yes])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[AC_=
DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+		)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+		if test &quot;x$ac_cv_func_mbedtls_ssl_set_export_k=
eys_cb&quot; !=3D xyes; then</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+			have_export_keying_material=3D&quot;no&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+		fi</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	fi</span><br><span> </span><br><span> 	AC_CHECK_FUNC=
(</span><br><span> 		[mbedtls_ctr_drbg_update_ret],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-		AC_DEFINE([HAVE_CTR_DRBG_UPDATE_RET], [1]=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		AC_DEFINE([HAVE_=
MBEDTLS_CTR_DRBG_UPDATE_RET], [1],</span><br><span> 			  [Use mbedtls_ctr_d=
rbg_update_ret from mbed TLS]),</span><br><span> 	)</span><br><span> </span=
><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</=
span><br><span>index 52deef8..b953961 100644</span><br><span>--- a/src/open=
vpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><sp=
an>@@ -82,6 +82,7 @@</span><br><span> 	ovpn_dco_win.h \</span><br><span> 	p=
latform.c platform.h \</span><br><span> 	console.c console.h console_builti=
n.c console_systemd.c \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	mbedtls_compat.h \</span><br><span> 	mroute.c mroute.h \</span><br><sp=
an> 	mss.c mss.h \</span><br><span> 	mstats.c mstats.h \</span><br><span>di=
ff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</spa=
n><br><span>index aaf6ef7..ad3439c 100644</span><br><span>--- a/src/openvpn=
/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span>=
<br><span>@@ -989,8 +989,9 @@</span><br><span> </span><br><span>     return=
 diff;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-/* mbedtls-2.18.0 or newer */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#ifdef HAVE_MBEDTLS_SSL_TLS_PRF</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/* mbedtls-2.18.0 or newer implements tls_prf, but =
prf_tls1 is removed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * from recent versions, so we use our own implementation if necessary. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL=
_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1)</span><br><span> bool=
</span><br><span> ssl_tls1_PRF(const uint8_t *seed, int seed_len, const uin=
t8_t *secret,</span><br><span>              int secret_len, uint8_t *output=
, int output_len)</span><br><span>@@ -999,7 +1000,7 @@</span><br><span>    =
                                    secret_len, &quot;&quot;, seed, seed_le=
n, output,</span><br><span>                                        output_l=
en));</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#else  /* ifdef HAVE_MBEDTLS_SSL_TLS_PRF */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#else /* HAVE_MBEDTLS_SSL_TLS_PRF &amp;&amp; def=
ined(MBEDTLS_SSL_TLS_PRF_TLS1) */</span><br><span> /*</span><br><span>  * G=
enerate the hash required by for the \c tls1_PRF function.</span><br><span>=
  *</span><br><span>@@ -1128,5 +1129,5 @@</span><br><span>     gc_free(&amp=
;gc);</span><br><span>     return true;</span><br><span> }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef HAVE_MBEDTLS_SSL_TLS_P=
RF */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* HAVE=
_MBEDTLS_SSL_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) */</span>=
<br><span> #endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><span>diff --git a/=
src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h</span><br><span=
>index fe7c3f9..610215b 100644</span><br><span>--- a/src/openvpn/mbedtls_co=
mpat.h</span><br><span>+++ b/src/openvpn/mbedtls_compat.h</span><br><span>@=
@ -33,6 +33,8 @@</span><br><span> #ifndef MBEDTLS_COMPAT_H_</span><br><span=
> #define MBEDTLS_COMPAT_H_</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #include &quot;errle=
vel.h&quot;</span><br><span> </span><br><span> #include &lt;mbedtls/cipher.=
h&gt;</span><br><span>@@ -41,24 +43,25 @@</span><br><span> #include &lt;mbe=
dtls/md.h&gt;</span><br><span> #include &lt;mbedtls/pem.h&gt;</span><br><sp=
an> #include &lt;mbedtls/pk.h&gt;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &lt;mbedtls/ssl.h&gt;</span><br><span> #include &lt;=
mbedtls/version.h&gt;</span><br><span> #include &lt;mbedtls/x509_crt.h&gt;<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
MBEDTLS_HAVE_PSA_CRYPTO_H</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if HAVE_MBEDTLS_PSA_CRYPTO_H</span><br><span>     #include &lt;psa/c=
rypto.h&gt;</span><br><span> #endif</span><br><span> </span><br><span> stat=
ic inline void</span><br><span> mbedtls_compat_psa_crypto_init(void)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if MBEDT=
LS_HAVE_PSA_CRYPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_PSA_CRYPTO_H &am=
p;&amp; defined(MBEDTLS_PSA_CRYPTO_C)</span><br><span>     if (psa_crypto_i=
nit() !=3D PSA_SUCCESS)</span><br><span>     {</span><br><span>         msg=
(M_FATAL, &quot;mbedtls: psa_crypto_init() failed&quot;);</span><br><span> =
    }</span><br><span> #else</span><br><span>     return;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_HAVE_PSA_CRYPTO_H &am=
p;&amp; defined(MBEDTLS_PSA_CRYPTO_C) */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif /* HAVE_MBEDTLS_PSA_CRYPTO_H &amp;&amp; defined=
(MBEDTLS_PSA_CRYPTO_C) */</span><br><span> }</span><br><span> </span><br><s=
pan> /*</span><br><span>@@ -74,14 +77,14 @@</span><br><span>               =
                 const unsigned char *additional,</span><br><span>         =
                       size_t add_len)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if HAVE_CTR_DRBG_UPDATE_RET</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_CTR_DRBG_UPDA=
TE_RET</span><br><span>     return mbedtls_ctr_drbg_update_ret(ctx, additio=
nal, add_len);</span><br><span> #elif MBEDTLS_VERSION_NUMBER &lt; 0x0302010=
0</span><br><span>     mbedtls_ctr_drbg_update(ctx, additional, add_len);</=
span><br><span>     return 0;</span><br><span> #else</span><br><span>     r=
eturn mbedtls_ctr_drbg_update(ctx, additional, add_len);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_CTR_DRBG_UPDATE_RET */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* HAVE_MBEDTLS=
_CTR_DRBG_UPDATE_RET */</span><br><span> }</span><br><span> </span><br><spa=
n> static inline int</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c=
 b/src/openvpn/ssl_mbedtls.c</span><br><span>index 4ece37e..09559be 100644<=
/span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/o=
penvpn/ssl_mbedtls.c</span><br><span>@@ -173,6 +173,8 @@</span><br><span> }=
</span><br><span> </span><br><span> #ifdef HAVE_EXPORT_KEYING_MATERIAL</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT=
_CB</span><br><span> int</span><br><span> mbedtls_ssl_export_keys_cb(void *=
p_expkey, const unsigned char *ms,</span><br><span>                        =
    const unsigned char *kb, size_t maclen,</span><br><span>@@ -193,8 +195,=
38 @@</span><br><span>     memcpy(cache-&gt;master_secret, ms, sizeof(cache=
-&gt;master_secret));</span><br><span>     cache-&gt;tls_prf_type =3D tls_p=
rf_type;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return 0;</span><br><span> }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+mbedtls_ssl_export_keys_cb(void *p_expkey,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                           mbe=
dtls_ssl_key_export_type type,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                           const unsigned char *secret,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                           s=
ize_t secret_len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                         const unsigned char client_random[32],</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                           cons=
t unsigned char server_random[32],</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                           mbedtls_tls_prf_types tls_prf_typ=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (type !=3D MBEDTLS_SSL_KEY_E=
XPORT_TLS12_MASTER_SECRET)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct tls_session *session =3D p_expkey=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_sta=
te_ssl *ks_ssl =3D &amp;session-&gt;key[KS_PRIMARY].ks_ssl;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct tls_key_cache *cache =3D=
 &amp;ks_ssl-&gt;tls_key_cache;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(secret_len !=3D sizeof(cache-&gt;master_secret))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(cache-&gt;=
client_server_random, client_random, 32);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    memcpy(cache-&gt;client_server_random + 32, serve=
r_random, 32);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    m=
emcpy(cache-&gt;master_secret, secret, sizeof(cache-&gt;master_secret));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    cache-&gt;tls_prf_=
type =3D tls_prf_type;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* HAVE_=
MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span> </span><br><span> b=
ool</span><br><span> key_state_export_keying_material(struct tls_session *s=
ession,</span><br><span>@@ -212,6 +244,7 @@</span><br><span>         return=
 false;</span><br><span>     }</span><br><span> </span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    msg(M_INFO, &quot;running prf&quot;);</spa=
n><br><span>     int ret =3D mbedtls_ssl_tls_prf(cache-&gt;tls_prf_type, ca=
che-&gt;master_secret,</span><br><span>                                   s=
izeof(cache-&gt;master_secret),</span><br><span>                           =
        label, cache-&gt;client_server_random,</span><br><span>@@ -1205,8 +=
1238,8 @@</span><br><span>         mbedtls_ssl_conf_max_version(ks_ssl-&gt;=
ssl_config, major, minor);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MAT=
ERIAL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* Initializ=
e keying material exporter */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Initialize keying material export=
er, old style. */</span><br><span>     mbedtls_ssl_conf_export_keys_ext_cb(=
ks_ssl-&gt;ssl_config,</span><br><span>                                    =
     mbedtls_ssl_export_keys_cb, session);</span><br><span> #endif</span><b=
r><span>@@ -1216,6 +1249,11 @@</span><br><span>     mbedtls_ssl_init(ks_ssl=
-&gt;ctx);</span><br><span>     mbed_ok(mbedtls_ssl_setup(ks_ssl-&gt;ctx, k=
s_ssl-&gt;ssl_config));</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /* Initialize keying material=
 exporter, new style. */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    mbedtls_ssl_set_export_keys_cb(ks_ssl-&gt;ctx, mbedtls_ssl_export_=
keys_cb, session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an>     /* Initialise BIOs */</span><br><span>     ALLOC_OBJ_CLEAR(ks_ssl-&=
gt;bio_ctx, bio_ctx);</span><br><span>     mbedtls_ssl_set_bio(ks_ssl-&gt;c=
tx, ks_ssl-&gt;bio_ctx, ssl_bio_write,</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/402?usp=3De=
mail">change 402</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/402?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e90530726b7f7ba3cee0438f2d=
81a1ac42e821b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 402 </div>
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


--oWJX2Xht0us=--

