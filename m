From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 14 Jul 2025 12:25:48 +0000
In-Reply-To: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
References: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <3dc487c0f7d72dda3933ee7cbec1312f3e1ccdf9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SwnwU4x0pCo="; charset=UTF-8
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

--SwnwU4x0pCo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail

to look at the new patch set (#4).


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

Change-Id: I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/mbedtls_compat.h
M src/openvpn/ssl_mbedtls.c
4 files changed, 17 insertions(+), 36 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1081/4

diff --git a/config.h.cmake.in b/config.h.cmake.in
index 5df0ac8..0ee1a89 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -370,10 +370,9 @@
 #undef HAVE_VFORK_H

 /* Availability of different mbed TLS features and APIs */
-#cmakedefine01 HAVE_MBEDTLS_PSA_CRYPTO_H
-#define HAVE_MBEDTLS_SSL_TLS_PRF 1
-#cmakedefine01 HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
-#cmakedefine01 HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET
+#cmakedefine HAVE_MBEDTLS_PSA_CRYPTO_H
+#cmakedefine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+#cmakedefine HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET

 /* Path to ifconfig tool */
 #define IFCONFIG_PATH "@IFCONFIG_PATH@"
diff --git a/configure.ac b/configure.ac
index 02b45f8..51c20ef 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1044,31 +1044,11 @@
 		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [0], [no])]
 	)

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
 		AC_CHECK_FUNC(
-			[mbedtls_ssl_set_export_keys_cb],
-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [yes])],
-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
+			[mbedtls_ssl_set_export_keys_cb]
 		)
 		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" !=3D xyes; then
 			AC_CHECK_FUNC([mbedtls_ssl_export_keying_material])
diff --git a/src/openvpn/mbedtls_compat.h b/src/openvpn/mbedtls_compat.h
index 145a7ae..68c4cc3 100644
--- a/src/openvpn/mbedtls_compat.h
+++ b/src/openvpn/mbedtls_compat.h
@@ -48,7 +48,7 @@
 #include <mbedtls/version.h>
 #include <mbedtls/x509_crt.h>

-#if HAVE_MBEDTLS_PSA_CRYPTO_H
+#ifdef HAVE_MBEDTLS_PSA_CRYPTO_H
     #include <psa/crypto.h>
 #endif

@@ -61,14 +61,14 @@
 static inline void
 mbedtls_compat_psa_crypto_init(void)
 {
-#if HAVE_MBEDTLS_PSA_CRYPTO_H && defined(MBEDTLS_PSA_CRYPTO_C)
+#if defined(HAVE_MBEDTLS_PSA_CRYPTO_H) && defined(MBEDTLS_PSA_CRYPTO_C)
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
index ecccc26..2e0c7d2 100644
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
+#elif  /* ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT */
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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--SwnwU4x0pCo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
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
larSSL&#39;s time but is not today anymore.<br><br>Change-Id: I0f325800ebeb=
20bd5ef3ff78e5c5fcf0f6f74efd<br>Signed-off-by: Arne Schwabe &lt;arne@...2068...=
7...&gt;<br>---<br>M config.h.cmake.in<br>M configure.ac<br>M src/openvpn/m=
bedtls_compat.h<br>M src/openvpn/ssl_mbedtls.c<br>4 files changed, 17 inser=
tions(+), 36 deletions(-)<br><br></pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/81/1081/4</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/config.h.cmake.in b/co=
nfig.h.cmake.in</span><br><span>index 5df0ac8..0ee1a89 100644</span><br><sp=
an>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><b=
r><span>@@ -370,10 +370,9 @@</span><br><span> #undef HAVE_VFORK_H</span><br=
><span> </span><br><span> /* Availability of different mbed TLS features an=
d APIs */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#cmakedefine=
01 HAVE_MBEDTLS_PSA_CRYPTO_H</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define HAVE_MBEDTLS_SSL_TLS_PRF 1</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#cmakedefine01 HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#cmakedefine01 HAVE_MBEDTL=
S_CTR_DRBG_UPDATE_RET</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#cmakedefine HAVE_MBEDTLS_PSA_CRYPTO_H</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#cmakedefine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_MBEDTLS=
_CTR_DRBG_UPDATE_RET</span><br><span> </span><br><span> /* Path to ifconfig=
 tool */</span><br><span> #define IFCONFIG_PATH &quot;@IFCONFIG_PATH@&quot;=
</span><br><span>diff --git a/configure.ac b/configure.ac</span><br><span>i=
ndex 02b45f8..51c20ef 100644</span><br><span>--- a/configure.ac</span><br><=
span>+++ b/configure.ac</span><br><span>@@ -1044,31 +1044,11 @@</span><br><=
span> 		[AC_DEFINE([HAVE_MBEDTLS_PSA_CRYPTO_H], [0], [no])]</span><br><span=
> 	)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	AC_CHECK_FUNCS(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[ =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			mbedtls_cipher_wr=
ite_tag \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			mbedtls_c=
ipher_check_tag \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		],=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-		[AC_MSG_ERROR([mbed TLS check for AEA=
D support failed])]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK_FUNCS([mb=
edtls_ssl_tls_prf mbedtls_ssl_conf_export_keys_ext_cb])</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_CHECK_FUNC(</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-		[mbedtls_ssl_tls_prf],</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-		[AC_DEFINE([HAVE_MBEDTLS=
_SSL_TLS_PRF], [1], [yes])],</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-		[AC_DEFINE([HAVE_MBEDTLS_SSL_TLS_PRF], [0], [no])]</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-	)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	A=
C_CHECK_FUNC(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[mbedt=
ls_ssl_conf_export_keys_ext_cb],</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [y=
es])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[AC_DEFINE([H=
AVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [0], [no])]</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	)</span><br><span> 	if test &quot;x$ac_cv_=
func_mbedtls_ssl_conf_export_keys_ext_cb&quot; !=3D xyes; then</span><br><s=
pan> 		AC_CHECK_FUNC(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
			[mbedtls_ssl_set_export_keys_cb],</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [y=
es])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			[AC_DEFINE([=
HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+			[mbedtls_ssl_set_export_keys_cb]</span><br=
><span> 		)</span><br><span> 		if test &quot;x$ac_cv_func_mbedtls_ssl_set_e=
xport_keys_cb&quot; !=3D xyes; then</span><br><span> 			AC_CHECK_FUNC([mbed=
tls_ssl_export_keying_material])</span><br><span>diff --git a/src/openvpn/m=
bedtls_compat.h b/src/openvpn/mbedtls_compat.h</span><br><span>index 145a7a=
e..68c4cc3 100644</span><br><span>--- a/src/openvpn/mbedtls_compat.h</span>=
<br><span>+++ b/src/openvpn/mbedtls_compat.h</span><br><span>@@ -48,7 +48,7=
 @@</span><br><span> #include &lt;mbedtls/version.h&gt;</span><br><span> #i=
nclude &lt;mbedtls/x509_crt.h&gt;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_PSA_CRYPTO_H</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_MBEDTLS_PSA_CRYPTO_H<=
/span><br><span>     #include &lt;psa/crypto.h&gt;</span><br><span> #endif<=
/span><br><span> </span><br><span>@@ -61,14 +61,14 @@</span><br><span> stat=
ic inline void</span><br><span> mbedtls_compat_psa_crypto_init(void)</span>=
<br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if HAVE_=
MBEDTLS_PSA_CRYPTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_MBEDTLS_PSA_CRYP=
TO_H) &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C)</span><br><span>     if (psa=
_crypto_init() !=3D PSA_SUCCESS)</span><br><span>     {</span><br><span>   =
      msg(M_FATAL, &quot;mbedtls: psa_crypto_init() failed&quot;);</span><b=
r><span>     }</span><br><span> #else</span><br><span>     return;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* HAVE_MBEDTLS_PSA_CRY=
PTO_H &amp;&amp; defined(MBEDTLS_PSA_CRYPTO_C) */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </=
span><br><span> static inline mbedtls_compat_group_id</span><br><span>@@ -9=
6,7 +96,7 @@</span><br><span> {</span><br><span> #if MBEDTLS_VERSION_NUMBER=
 &gt; 0x03000000</span><br><span>     return mbedtls_ctr_drbg_update(ctx, a=
dditional, add_len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
elif HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#elif defined(HAVE_MBEDTLS_CTR_DRBG_UPDATE_RET)</span><br=
><span>     return mbedtls_ctr_drbg_update_ret(ctx, additional, add_len);</=
span><br><span> #else</span><br><span>     mbedtls_ctr_drbg_update(ctx, add=
itional, add_len);</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b=
/src/openvpn/ssl_mbedtls.c</span><br><span>index ecccc26..2e0c7d2 100644</s=
pan><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/ope=
nvpn/ssl_mbedtls.c</span><br><span>@@ -173,8 +173,9 @@</span><br><span>    =
 ASSERT(NULL !=3D ctx);</span><br><span>     return ctx-&gt;initialised;</s=
pan><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_SSL_CONF_=
EXPORT_KEYS_EXT_CB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* mbedtls_ssl_export_keying_material does not need he=
lper/callback methods */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#elif defined(HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)</span><br><spa=
n> /*</span><br><span>  * Key export callback for older versions of mbed TL=
S, to be used with</span><br><span>  * mbedtls_ssl_conf_export_keys_ext_cb(=
). It is called with the master</span><br><span>@@ -205,7 +206,7 @@</span><=
br><span> </span><br><span>     return 0;</span><br><span> }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KE=
YS_CB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(=
HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB)</span><br><span> /*</span><br><span>  =
* Key export callback for newer versions of mbed TLS, to be used with</span=
><br><span>  * mbedtls_ssl_set_export_keys_cb(). When used with TLS 1.2, th=
e callback</span><br><span>@@ -251,10 +252,11 @@</span><br><span>     memcp=
y(cache-&gt;master_secret, secret, sizeof(cache-&gt;master_secret));</span>=
<br><span>     cache-&gt;tls_prf_type =3D tls_prf_type;</span><br><span> }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#elif !defined(MBEDTLS=
_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#elif  /* ifdef MBEDTLS_SSL_KEYING_MATERIAL_EXPORT */</span><br><s=
pan> #error mbedtls_ssl_conf_export_keys_ext_cb, mbedtls_ssl_set_export_key=
s_cb or mbedtls_ssl_export_keying_material must be available in mbed TLS</s=
pan><br><span> #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> bool</span><br><span> key_state_export_keying_material(struct tls=
_session *session,</span><br><span>                                  const =
char *label, size_t label_size,</span><br><span>@@ -1244,7 +1246,7 @@</span=
><br><span>         mbedtls_ssl_conf_max_tls_version(ks_ssl-&gt;ssl_config,=
 version);</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_C=
B &amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_MBEDTLS_SSL_CONF_EXP=
ORT_KEYS_EXT_CB) &amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</s=
pan><br><span>     /* Initialize keying material exporter, old style. */</s=
pan><br><span>     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl-&gt;ssl_confi=
g,</span><br><span>                                         mbedtls_ssl_exp=
ort_keys_cb, session);</span><br><span>@@ -1259,7 +1261,7 @@</span><br><spa=
n>      * verification. */</span><br><span>     ASSERT(mbed_ok(mbedtls_ssl_=
set_hostname(ks_ssl-&gt;ctx, NULL)));</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB &=
amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_MBEDTLS_SSL_SET_EXPORT_=
KEYS_CB) &amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br>=
<span>     /* Initialize keying material exporter, new style. */</span><br>=
<span>     mbedtls_ssl_set_export_keys_cb(ks_ssl-&gt;ctx, mbedtls_ssl_expor=
t_keys_cb, session);</span><br><span> #endif</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1081?=
usp=3Demail">change 1081</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p>=
<div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope i=
temprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f325800ebeb20bd5ef3ff78e5c=
5fcf0f6f74efd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--SwnwU4x0pCo=--

