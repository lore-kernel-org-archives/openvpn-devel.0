From: "MaxF (Code Review)" <gerrit@...515...>
Date: Mon, 13 Nov 2023 16:33:05 +0000
In-Reply-To: <gerrit.1699630545000.I8e90530726b7f7ba3cee0438f2d81a1ac42e821b@...2715...>
References: <gerrit.1699630545000.I8e90530726b7f7ba3cee0438f2d81a1ac42e821b@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7bf5676c26e14cb2a3128dd01fd88fa9bb47919a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="H62zOmEphcc="; charset=UTF-8
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

--H62zOmEphcc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/402?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
6 files changed, 107 insertions(+), 21 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/402/4

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
index 4ece37e..5168484 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -173,6 +173,16 @@
 }

 #ifdef HAVE_EXPORT_KEYING_MATERIAL
+
+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+/*
+ * Key export callback for older versions of mbed TLS, to be used with
+ * mbedtls_ssl_conf_export_keys_ext_cb(). It is called with the master
+ * secret, client random and server random, and the type of PRF function
+ * to use.
+ *
+ * Mbed TLS stores this callback in the mbedtls_ssl_config struct and it
+ * is used in the mbedtls_ssl_contexts set up from that config. */
 int
 mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
                            const unsigned char *kb, size_t maclen,
@@ -193,8 +203,55 @@
     memcpy(cache->master_secret, ms, sizeof(cache->master_secret));
     cache->tls_prf_type =3D tls_prf_type;

-    return true;
+    return 0;
 }
+#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+/*
+ * Key export callback for newer versions of mbed TLS, to be used with
+ * mbedtls_ssl_set_export_keys_cb(). When used with TLS 1.2, the callback
+ * is called with the TLS 1.2 master secret, client random, server random
+ * and the type of PRF to use. With TLS 1.3, it is called with several
+ * different keys (indicated by type), but unfortunately not the exporter
+ * master secret.
+ *
+ * Unlike in older versions, the callback is not stored in the
+ * mbedtls_ssl_config. It is placed in the mbedtls_ssl_context after it
+ * has been set up. */
+void
+mbedtls_ssl_export_keys_cb(void *p_expkey,
+                           mbedtls_ssl_key_export_type type,
+                           const unsigned char *secret,
+                           size_t secret_len,
+                           const unsigned char client_random[32],
+                           const unsigned char server_random[32],
+                           mbedtls_tls_prf_types tls_prf_type)
+{
+    /* Since we can't get the TLS 1.3 exporter master secret, we ignore al=
l key
+     * types except MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET. */
+    if (type !=3D MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET)
+    {
+        return;
+    }
+
+    struct tls_session *session =3D p_expkey;
+    struct key_state_ssl *ks_ssl =3D &session->key[KS_PRIMARY].ks_ssl;
+    struct tls_key_cache *cache =3D &ks_ssl->tls_key_cache;
+
+    /* The TLS 1.2 master secret has a fixed size, so if secret_len has
+     * a different value, something is wrong with mbed TLS. */
+    if (secret_len !=3D sizeof(cache->master_secret))
+    {
+        msg(M_FATAL,
+            "ERROR: Incorrect TLS 1.2 master secret length: Got %zu, expec=
ted %zu",
+            secret_len, sizeof(cache->master_secret));
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
@@ -1205,8 +1262,8 @@
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
@@ -1216,6 +1273,11 @@
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
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newpatchset

--H62zOmEphcc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld, plaisthos. </=
p>
<p>MaxF <strong>uploaded patch set #4</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/402?usp=3Demail">View Change</a>=
</p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Enable key export with mbed TLS 3.x.y<br><br>=
Change-Id: I8e90530726b7f7ba3cee0438f2d81a1ac42e821b<br>Signed-off-by: Max =
Fillinger &lt;maximilian.fillinger@...2507...&gt;<br>---<br>M config.h.cmak=
e.in<br>M configure.ac<br>M src/openvpn/Makefile.am<br>M src/openvpn/crypto=
_mbedtls.c<br>M src/openvpn/mbedtls_compat.h<br>M src/openvpn/ssl_mbedtls.c=
<br>6 files changed, 107 insertions(+), 21 deletions(-)<br><br></pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/02/402/4</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/config.h.cmake.in b/config.h.cmake.in</span><br><span>index f2cdd39.=
.ed4978a 100644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++=
 b/config.h.cmake.in</span><br><span>@@ -387,7 +387,10 @@</span><br><span> =
#undef HAVE_VSNPRINTF</span><br><span> </span><br><span> /* we always assum=
e a recent mbed TLS version */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define HAVE_CTR_DRBG_UPDATE_RET 1</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#define HAVE_MBEDTLS_PSA_CRYPTO_H 1</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_MBEDTLS_SSL_TLS_PRF 1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_MBEDTLS=
_SSL_SET_EXPORT_KEYS_CB 1</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET 1</span><br><span> </span><b=
r><span> /* Path to ifconfig tool */</span><br><span> #define IFCONFIG_PATH=
 &quot;@IFCONFIG_PATH@&quot;</span><br><span>diff --git a/configure.ac b/co=
nfigure.ac</span><br><span>index 7e5763d..84eaad6 100644</span><br><span>--=
- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -102=
5,11 +1025,11 @@</span><br><span> 		[AC_MSG_ERROR([mbed TLS version &gt;=3D=
 2.0.0 or &gt;=3D 3.2.1 required])]</span><br><span> 	)</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    AC_CHECK_HEADER(</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        psa/crypto.h,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        [AC_DEFINE([MBED=
TLS_HAVE_PSA_CRYPTO_H], [1], [yes])],</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        [AC_DEFINE([MBEDTLS_HAVE_PSA_CRYPTO_H], [0], [no])]=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    )</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK_HEADER(</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+		psa/crypto.h,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H],=
 [1], [yes])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC=
_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [0], [no])]</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	)</span><br><span> </span><br><span> 	AC_CHEC=
K_FUNCS(</span><br><span> 		[ \</span><br><span>@@ -1040,16 +1040,32 @@</sp=
an><br><span> 		[AC_MSG_ERROR([mbed TLS check for AEAD support failed])]</s=
pan><br><span> 	)</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	AC_CHECK_FUNC(</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+		[mbedtls_ssl_tls_prf],</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [1], [yes])],</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE([HAVE_MBED=
TLS_SSL_TLS_PRF], [0], [no])]</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> 	have_export_keying_material=3D&quot;yes&quot;</span><br><span> =
	AC_CHECK_FUNC(</span><br><span> 		[mbedtls_ssl_conf_export_keys_ext_cb],</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-		,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-		[have_export_keying_material=3D&quot;no=
&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE=
([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_=
EXPORT_KEYS_EXT_CB], [0], [no])]</span><br><span> 	)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	if test &quot;x$ac_cv_func_mbedtls_ssl_c=
onf_export_keys_ext_cb&quot; !=3D xyes; then</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+		AC_CHECK_FUNC(</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+			[mbedtls_ssl_set_export_keys_cb],</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_=
EXPORT_KEYS_CB], [1], [yes])],</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+		if test &quot;x$ac_cv_func_mbedtl=
s_ssl_set_export_keys_cb&quot; !=3D xyes; then</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+			have_export_keying_material=3D&quot;no&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+		fi</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	fi</span><br><span> </span><br><sp=
an> 	AC_CHECK_FUNC(</span><br><span> 		[mbedtls_ctr_drbg_update_ret],</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-		AC_DEFINE([HAVE_CTR_DRBG_=
UPDATE_RET], [1],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		=
AC_DEFINE([HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET], [1],</span><br><span> 			  [U=
se mbedtls_ctr_drbg_update_ret from mbed TLS]),</span><br><span> 	)</span><=
br><span> </span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openv=
pn/Makefile.am</span><br><span>index 52deef8..b953961 100644</span><br><spa=
n>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.=
am</span><br><span>@@ -82,6 +82,7 @@</span><br><span> 	ovpn_dco_win.h \</sp=
an><br><span> 	platform.c platform.h \</span><br><span> 	console.c console.=
h console_builtin.c console_systemd.c \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	mbedtls_compat.h \</span><br><span> 	mroute.c mroute.h=
 \</span><br><span> 	mss.c mss.h \</span><br><span> 	mstats.c mstats.h \</s=
pan><br><span>diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypt=
o_mbedtls.c</span><br><span>index aaf6ef7..ad3439c 100644</span><br><span>-=
-- a/src/openvpn/crypto_mbedtls.c</span><br><span>+++ b/src/openvpn/crypto_=
mbedtls.c</span><br><span>@@ -989,8 +989,9 @@</span><br><span> </span><br><=
span>     return diff;</span><br><span> }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-/* mbedtls-2.18.0 or newer */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifdef HAVE_MBEDTLS_SSL_TLS_PRF</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/* mbedtls-2.18.0 or newer implemen=
ts tls_prf, but prf_tls1 is removed</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ * from recent versions, so we use our own implementation i=
f necessary. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
HAVE_MBEDTLS_SSL_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1)</span=
><br><span> bool</span><br><span> ssl_tls1_PRF(const uint8_t *seed, int see=
d_len, const uint8_t *secret,</span><br><span>              int secret_len,=
 uint8_t *output, int output_len)</span><br><span>@@ -999,7 +1000,7 @@</spa=
n><br><span>                                        secret_len, &quot;&quot=
;, seed, seed_len, output,</span><br><span>                                =
        output_len));</span><br><span> }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#else  /* ifdef HAVE_MBEDTLS_SSL_TLS_PRF */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#else /* HAVE_MBEDTLS_SSL_TLS_PR=
F &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF_TLS1) */</span><br><span> /*</span=
><br><span>  * Generate the hash required by for the \c tls1_PRF function.<=
/span><br><span>  *</span><br><span>@@ -1128,5 +1129,5 @@</span><br><span> =
    gc_free(&amp;gc);</span><br><span>     return true;</span><br><span> }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifdef HAVE_M=
BEDTLS_SSL_TLS_PRF */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif /* HAVE_MBEDTLS_SSL_TLS_PRF &amp;&amp; defined(MBEDTLS_SSL_TLS_PRF=
_TLS1) */</span><br><span> #endif /* ENABLE_CRYPTO_MBEDTLS */</span><br><sp=
an>diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h=
</span><br><span>index fe7c3f9..610215b 100644</span><br><span>--- a/src/op=
envpn/mbedtls_compat.h</span><br><span>+++ b/src/openvpn/mbedtls_compat.h</=
span><br><span>@@ -33,6 +33,8 @@</span><br><span> #ifndef MBEDTLS_COMPAT_H_=
</span><br><span> #define MBEDTLS_COMPAT_H_</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #inc=
lude &quot;errlevel.h&quot;</span><br><span> </span><br><span> #include &lt=
;mbedtls/cipher.h&gt;</span><br><span>@@ -41,24 +43,25 @@</span><br><span> =
#include &lt;mbedtls/md.h&gt;</span><br><span> #include &lt;mbedtls/pem.h&g=
t;</span><br><span> #include &lt;mbedtls/pk.h&gt;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &lt;mbedtls/ssl.h&gt;</span><br><spa=
n> #include &lt;mbedtls/version.h&gt;</span><br><span> #include &lt;mbedtls=
/x509_crt.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if MBEDTLS_HAVE_PSA_CRYPTO_H</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#if HAVE_MBEDTLS_PSA_CRYPTO_H</span><br><span>     #i=
nclude &lt;psa/crypto.h&gt;</span><br><span> #endif</span><br><span> </span=
><br><span> static inline void</span><br><span> mbedtls_compat_psa_crypto_i=
nit(void)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if MBEDTLS_HAVE_PSA_CRYPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_=
C)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_=
PSA_CRYPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C)</span><br><span>     =
if (psa_crypto_init() !=3D PSA_SUCCESS)</span><br><span>     {</span><br><s=
pan>         msg(M_FATAL, &quot;mbedtls: psa_crypto_init() failed&quot;);</=
span><br><span>     }</span><br><span> #else</span><br><span>     return;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* MBEDTLS_HAVE_=
PSA_CRYPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C) */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif /* HAVE_MBEDTLS_PSA_CRYPTO_H &a=
mp;&amp; defined(MBEDTLS_PSA_CRYPTO_C) */</span><br><span> }</span><br><spa=
n> </span><br><span> /*</span><br><span>@@ -74,14 +77,14 @@</span><br><span=
>                                const unsigned char *additional,</span><br=
><span>                                size_t add_len)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if HAVE_CTR_DRBG_UPDAT=
E_RET</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDT=
LS_CTR_DRBG_UPDATE_RET</span><br><span>     return mbedtls_ctr_drbg_update_=
ret(ctx, additional, add_len);</span><br><span> #elif MBEDTLS_VERSION_NUMBE=
R &lt; 0x03020100</span><br><span>     mbedtls_ctr_drbg_update(ctx, additio=
nal, add_len);</span><br><span>     return 0;</span><br><span> #else</span>=
<br><span>     return mbedtls_ctr_drbg_update(ctx, additional, add_len);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_CTR_DRBG_=
UPDATE_RET */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
 /* HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET */</span><br><span> }</span><br><span>=
 </span><br><span> static inline int</span><br><span>diff --git a/src/openv=
pn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 4ece37e.=
.5168484 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><=
span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -173,6 +173,16 @@</=
span><br><span> }</span><br><span> </span><br><span> #ifdef HAVE_EXPORT_KEY=
ING_MATERIAL</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_CONF_=
EXPORT_KEYS_EXT_CB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Key export call=
back for older versions of mbed TLS, to be used with</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * mbedtls_ssl_conf_export_keys_ext_cb().=
 It is called with the master</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * secret, client random and server random, and the type of PRF f=
unction</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to use.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Mbed TLS stores this callback in th=
e mbedtls_ssl_config struct and it</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * is used in the mbedtls_ssl_contexts set up from that conf=
ig. */</span><br><span> int</span><br><span> mbedtls_ssl_export_keys_cb(voi=
d *p_expkey, const unsigned char *ms,</span><br><span>                     =
       const unsigned char *kb, size_t maclen,</span><br><span>@@ -193,8 +2=
03,55 @@</span><br><span>     memcpy(cache-&gt;master_secret, ms, sizeof(ca=
che-&gt;master_secret));</span><br><span>     cache-&gt;tls_prf_type =3D tl=
s_prf_type;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    return 0;</span><br><span> }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * Key export callback for newer versions of mbed TL=
S, to be used with</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* mbedtls_ssl_set_export_keys_cb(). When used with TLS 1.2, the callback</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is called with the =
TLS 1.2 master secret, client random, server random</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * and the type of PRF to use. With TLS 1=
.3, it is called with several</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * different keys (indicated by type), but unfortunately not the =
exporter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * master s=
ecret.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Unlike in older versions, t=
he callback is not stored in the</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * mbedtls_ssl_config. It is placed in the mbedtls_ssl_context=
 after it</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * has bee=
n set up. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+mbedtls_ssl_export_key=
s_cb(void *p_expkey,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                           mbedtls_ssl_key_export_type type,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                           const =
unsigned char *secret,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                           size_t secret_len,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                           const unsigned char=
 client_random[32],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                           const unsigned char server_random[32],</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                           mb=
edtls_tls_prf_types tls_prf_type)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* Since we can&#39;t get the TLS 1.3 exporter master secret, we ignore all=
 key</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * types ex=
cept MBEDTLS_SSL_KEY_EXPORT_TLS12_MASTER_SECRET. */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (type !=3D MBEDTLS_SSL_KEY_EXPORT_=
TLS12_MASTER_SECRET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        retur=
n;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct tls_session *session =3D p_expkey;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct key_state_ssl=
 *ks_ssl =3D &amp;session-&gt;key[KS_PRIMARY].ks_ssl;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct tls_key_cache *cache =3D &amp;=
ks_ssl-&gt;tls_key_cache;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The TL=
S 1.2 master secret has a fixed size, so if secret_len has</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+     * a different value, something =
is wrong with mbed TLS. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (secret_len !=3D sizeof(cache-&gt;master_secret))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        msg(M_FATAL,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            &quot;ERROR: Incorrect TLS 1.2 m=
aster secret length: Got %zu, expected %zu&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            secret_len, sizeof(cache-&gt;mast=
er_secret));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    memcpy(cache-&gt;client_server_rando=
m, client_random, 32);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    memcpy(cache-&gt;client_server_random + 32, server_random, 32);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    memcpy(cache-&gt;mas=
ter_secret, secret, sizeof(cache-&gt;master_secret));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cache-&gt;tls_prf_type =3D tls_prf_ty=
pe;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif /* HAVE_MBEDTLS_SSL_CONF_EX=
PORT_KEYS_EXT_CB */</span><br><span> </span><br><span> bool</span><br><span=
> key_state_export_keying_material(struct tls_session *session,</span><br><=
span>@@ -1205,8 +1262,8 @@</span><br><span>         mbedtls_ssl_conf_max_ve=
rsion(ks_ssl-&gt;ssl_config, major, minor);</span><br><span>     }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_=
EXPORT_KEYING_MATERIAL</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* Initialize keying material exporter */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Initialize keyin=
g material exporter, old style. */</span><br><span>     mbedtls_ssl_conf_ex=
port_keys_ext_cb(ks_ssl-&gt;ssl_config,</span><br><span>                   =
                      mbedtls_ssl_export_keys_cb, session);</span><br><span=
> #endif</span><br><span>@@ -1216,6 +1273,11 @@</span><br><span>     mbedtl=
s_ssl_init(ks_ssl-&gt;ctx);</span><br><span>     mbed_ok(mbedtls_ssl_setup(=
ks_ssl-&gt;ctx, ks_ssl-&gt;ssl_config));</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS=
_CB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Initializ=
e keying material exporter, new style. */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    mbedtls_ssl_set_export_keys_cb(ks_ssl-&gt;ctx, mb=
edtls_ssl_export_keys_cb, session);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     /* Initialise BIOs */</span><br><span>     ALLOC_O=
BJ_CLEAR(ks_ssl-&gt;bio_ctx, bio_ctx);</span><br><span>     mbedtls_ssl_set=
_bio(ks_ssl-&gt;ctx, ks_ssl-&gt;bio_ctx, ssl_bio_write,</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/402?usp=3Demail">change 402</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/402?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8e90530726b7f7ba3cee0438f2d=
81a1ac42e821b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 402 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-Attention: MaxF &lt;max@...2606...&gt; =
</div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--H62zOmEphcc=--

