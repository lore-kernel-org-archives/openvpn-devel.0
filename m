From: "MaxF (Code Review)" <gerrit@...515...>
Date: Tue, 20 May 2025 13:06:24 +0000
References: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <034d2350aff4f6b4b471ee552d0d263ba0ed8dde-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t+Zbfjmgvlk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Use
 mbedtls_ssl_export_keying_material()
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

--t+Zbfjmgvlk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail

to review the following change.


Change subject: Use mbedtls_ssl_export_keying_material()
......................................................................

Use mbedtls_ssl_export_keying_material()

Mbed TLS now has an implementation of the TLS-Exporter feature (though
not yet in a released version). Use it if it's available.

Change-Id: I1204bc2ff85952160a86f0b9d1caae90e5065bc4
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
M CMakeLists.txt
M configure.ac
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
4 files changed, 48 insertions(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1041/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 40bffd4..0744eb4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -302,6 +302,7 @@
     check_symbol_exists(mbedtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAV=
E_MBEDTLS_CTR_DRBG_UPDATE_RET)
     check_symbol_exists(mbedtls_ssl_conf_export_keys_ext_cb mbedtls/ssl.h =
HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)
     check_symbol_exists(mbedtls_ssl_set_export_keys_cb mbedtls/ssl.h HAVE_=
MBEDTLS_SSL_SET_EXPORT_KEYS_CB)
+    check_symbol_exists(mbedtls_ssl_export_keying_material mbedtls/ssl.h H=
AVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL)
     check_include_files(psa/crypto.h HAVE_MBEDTLS_PSA_CRYPTO_H)
 endfunction()

diff --git a/configure.ac b/configure.ac
index 75367e8..daaf202 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1065,19 +1065,28 @@
 	)

 	have_export_keying_material=3D"yes"
+
 	AC_CHECK_FUNC(
-		[mbedtls_ssl_conf_export_keys_ext_cb],
-		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],
-		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [0], [no])]
+		[mbedtls_ssl_export_keying_material],
+		AC_DEFINE([HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL], [1],
+			[Have mbedtls_ssl_export_keying_material])
 	)
-	if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb" !=3D xyes; then
+
+	if test "x$ac_cv_func_mbedtls_ssl_export_keying_material" !=3D xyes; then
 		AC_CHECK_FUNC(
-			[mbedtls_ssl_set_export_keys_cb],
-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [yes])],
-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
+			[mbedtls_ssl_conf_export_keys_ext_cb],
+			[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],
+			[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [0], [no])]
 		)
-		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" !=3D xyes; then
-			have_export_keying_material=3D"no"
+		if test "x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb" !=3D xyes; th=
en
+			AC_CHECK_FUNC(
+				[mbedtls_ssl_set_export_keys_cb],
+				[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [yes])],
+				[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
+			)
+			if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" !=3D xyes; then
+				have_export_keying_material=3D"no"
+			fi
 		fi
 	fi

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ec3135a..ab4b20c 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -253,8 +253,8 @@
     memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
     cache->tls_prf_type =3D tls_prf_type;
 }
-#else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
-#error either HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB or HAVE_MBEDTLS_SSL=
_SET_EXPORT_KEYS_CB must be defined when HAVE_EXPORT_KEYING_MATERIAL is def=
ined
+#elif !HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL
+#error HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB, HAVE_MBEDTLS_SSL_SET_EXPO=
RT_KEYS_CB or HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL must be set when HAVE=
_EXPORT_KEYING_MATERIAL is defined
 #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */

 bool
@@ -264,6 +264,20 @@
 {
     ASSERT(strlen(label) =3D=3D label_size);

+#if HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL
+    /* Our version of mbed TLS has a built-in TLS-Exporter. */
+
+    mbedtls_ssl_context *ctx =3D session->key[KS_PRIMARY].ks_ssl.ctx;
+    if (mbed_ok(mbedtls_ssl_export_keying_material(ctx, ekm, ekm_size, lab=
el, label_size, NULL, 0, 0)))
+    {
+        return true;
+    }
+    else
+    {
+        return false;
+    }
+
+#else
     struct tls_key_cache *cache =3D &session->key[KS_PRIMARY].ks_ssl.tls_k=
ey_cache;

     /* If the type is NONE, we either have no cached secrets or
@@ -288,7 +302,9 @@
         secure_memzero(ekm, session->opt->ekm_size);
         return false;
     }
+#endif  /* HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL */
 }
+
 #else  /* ifdef HAVE_EXPORT_KEYING_MATERIAL */
 bool
 key_state_export_keying_material(struct tls_session *session,
@@ -1238,7 +1254,7 @@
         mbedtls_ssl_conf_max_tls_version(ks_ssl->ssl_config, version);
     }

-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB && !HAVE_MBEDTLS_SSL_EXPORT_K=
EYING_MATERIAL
     /* Initialize keying material exporter, old style. */
     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
                                         mbedtls_ssl_export_keys_cb, sessio=
n);
@@ -1253,7 +1269,7 @@
      * verification. */
     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));

-#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB && !HAVE_MBEDTLS_SSL_EXPORT_KEYING=
_MATERIAL
     /* Initialize keying material exporter, new style. */
     mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb=
, session);
 #endif
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index ec30bb5..309dc7ce 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -85,16 +85,20 @@
     void *sign_ctx;
 };

-#ifdef HAVE_EXPORT_KEYING_MATERIAL
-/** struct to cache TLS secrets for keying material exporter (RFC 5705).
- * The constants (64 and 48) are inherent to TLS version and
- * the whole keying material export will likely change when they change */
+#if defined(HAVE_EXPORT_KEYING_MATERIAL) && !HAVE_MBEDTLS_SSL_EXPORT_KEYIN=
G_MATERIAL
+/**
+ * struct to cache TLS secrets for keying material exporter (RFC 5705).
+ * Not needed if the library itself implements the keying material exporte=
r,
+ * or if we can't obtain the secrets anyway.
+ *
+ * The constants 64 and 48 are inherent to TLS 1.2. For TLS 1.3, it is not
+ * possible to obtain the exporter master secret from mbed TLS. */
 struct tls_key_cache {
     unsigned char client_server_random[64];
     mbedtls_tls_prf_types tls_prf_type;
     unsigned char master_secret[48];
 };
-#else  /* ifdef HAVE_EXPORT_KEYING_MATERIAL */
+#else  /* if defined(HAVE_EXPORT_KEYING_MATERIAL) && !HAVE_MBEDTLS_SSL_EXP=
ORT_KEYING_MATERIAL */
 struct tls_key_cache { };
 #endif


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1204bc2ff85952160a86f0b9d1caae90e5065bc4
Gerrit-Change-Number: 1041
Gerrit-PatchSet: 1
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--t+Zbfjmgvlk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>MaxF would like plaisthos and flichtenheld to <strong>review</strong> th=
is change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Use mbedtls_ssl_export_keying_material()<br><br>Mbed TLS now=
 has an implementation of the TLS-Exporter feature (though<br>not yet in a =
released version). Use it if it&#39;s available.<br><br>Change-Id: I1204bc2=
ff85952160a86f0b9d1caae90e5065bc4<br>Signed-off-by: Max Fillinger &lt;maxim=
ilian.fillinger@...2507...&gt;<br>---<br>M CMakeLists.txt<br>M configure.ac=
<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_mbedtls.h<br>4 files c=
hanged, 48 insertions(+), 18 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/41/1041/1</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeL=
ists.txt b/CMakeLists.txt</span><br><span>index 40bffd4..0744eb4 100644</sp=
an><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</spa=
n><br><span>@@ -302,6 +302,7 @@</span><br><span>     check_symbol_exists(mb=
edtls_ctr_drbg_update_ret mbedtls/ctr_drbg.h HAVE_MBEDTLS_CTR_DRBG_UPDATE_R=
ET)</span><br><span>     check_symbol_exists(mbedtls_ssl_conf_export_keys_e=
xt_cb mbedtls/ssl.h HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB)</span><br><sp=
an>     check_symbol_exists(mbedtls_ssl_set_export_keys_cb mbedtls/ssl.h HA=
VE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    check_symbol_exists(mbedtls_ssl_export_keying_material m=
bedtls/ssl.h HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL)</span><br><span>     =
check_include_files(psa/crypto.h HAVE_MBEDTLS_PSA_CRYPTO_H)</span><br><span=
> endfunction()</span><br><span> </span><br><span>diff --git a/configure.ac=
 b/configure.ac</span><br><span>index 75367e8..daaf202 100644</span><br><sp=
an>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@=
 -1065,19 +1065,28 @@</span><br><span> 	)</span><br><span> </span><br><span=
> 	have_export_keying_material=3D&quot;yes&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span> 	AC_CHECK_FUNC(</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-		[mbedtls_ssl_conf_export_keys_ex=
t_cb],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[AC_DEFINE([H=
AVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [yes])],</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-		[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPOR=
T_KEYS_EXT_CB], [0], [no])]</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+		[mbedtls_ssl_export_keying_material],</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+		AC_DEFINE([HAVE_MBEDTLS_SSL_EXPORT_KEYING_MAT=
ERIAL], [1],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[Hav=
e mbedtls_ssl_export_keying_material])</span><br><span> 	)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-	if test &quot;x$ac_cv_func_mbedtls_ss=
l_conf_export_keys_ext_cb&quot; !=3D xyes; then</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	if test &quot;x$ac_cv_func_mbedtls_ssl_export_keying_material&quo=
t; !=3D xyes; then</span><br><span> 		AC_CHECK_FUNC(</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-			[mbedtls_ssl_set_export_keys_cb],</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-			[AC_DEFINE([HAVE_MBEDTLS_=
SSL_SET_EXPORT_KEYS_CB], [1], [yes])],</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], =
[no])]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[mbedtls_s=
sl_conf_export_keys_ext_cb],</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+			[AC_DEFINE([HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [1], [ye=
s])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			[AC_DEFINE(=
[HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB], [0], [no])]</span><br><span> 		=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		if test &quot;x$ac=
_cv_func_mbedtls_ssl_set_export_keys_cb&quot; !=3D xyes; then</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-			have_export_keying_material=3D&q=
uot;no&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		if te=
st &quot;x$ac_cv_func_mbedtls_ssl_conf_export_keys_ext_cb&quot; !=3D xyes; =
then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			AC_CHECK_FUN=
C(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				[mbedtls_ssl_=
set_export_keys_cb],</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+				[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [1], [yes])],</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+				[AC_DEFINE([HAVE_MBEDT=
LS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+			)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+			if test &quot;x$ac_cv_func_mbedtls_ssl_set_export_keys_cb&quot; !=
=3D xyes; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+				h=
ave_export_keying_material=3D&quot;no&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+			fi</span><br><span> 		fi</span><br><span> 	fi</s=
pan><br><span> </span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/sr=
c/openvpn/ssl_mbedtls.c</span><br><span>index ec3135a..ab4b20c 100644</span=
><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvp=
n/ssl_mbedtls.c</span><br><span>@@ -253,8 +253,8 @@</span><br><span>     me=
mcpy(cache-&gt;master_secret, secret, sizeof(cache-&gt;master_secret));</sp=
an><br><span>     cache-&gt;tls_prf_type =3D tls_prf_type;</span><br><span>=
 }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if HAVE_M=
BEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#error either HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB or H=
AVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB must be defined when HAVE_EXPORT_KEYING_=
MATERIAL is defined</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#elif !HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#error HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB,=
 HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB or HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATE=
RIAL must be set when HAVE_EXPORT_KEYING_MATERIAL is defined</span><br><spa=
n> #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span> <=
/span><br><span> bool</span><br><span>@@ -264,6 +264,20 @@</span><br><span>=
 {</span><br><span>     ASSERT(strlen(label) =3D=3D label_size);</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBE=
DTLS_SSL_EXPORT_KEYING_MATERIAL</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /* Our version of mbed TLS has a built-in TLS-Exporter. */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mbedtls_ssl_context *ctx =3D sessio=
n-&gt;key[KS_PRIMARY].ks_ssl.ctx;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (mbed_ok(mbedtls_ssl_export_keying_material(ctx, ekm, =
ekm_size, label, label_size, NULL, 0, 0)))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return true;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#else</span><br><span>     struct tls_key_cache *cache =3D &=
amp;session-&gt;key[KS_PRIMARY].ks_ssl.tls_key_cache;</span><br><span> </sp=
an><br><span>     /* If the type is NONE, we either have no cached secrets =
or</span><br><span>@@ -288,7 +302,9 @@</span><br><span>         secure_memz=
ero(ekm, session-&gt;opt-&gt;ekm_size);</span><br><span>         return fal=
se;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif  /* HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL */</span><br><spa=
n> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> #else  /* ifdef HAVE_EXPORT_KEYING_MATERIAL */</span><br><span> bool</sp=
an><br><span> key_state_export_keying_material(struct tls_session *session,=
</span><br><span>@@ -1238,7 +1254,7 @@</span><br><span>         mbedtls_ssl=
_conf_max_tls_version(ks_ssl-&gt;ssl_config, version);</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB &amp;&=
amp; !HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL</span><br><span>     /* Initi=
alize keying material exporter, old style. */</span><br><span>     mbedtls_=
ssl_conf_export_keys_ext_cb(ks_ssl-&gt;ssl_config,</span><br><span>        =
                                 mbedtls_ssl_export_keys_cb, session);</spa=
n><br><span>@@ -1253,7 +1269,7 @@</span><br><span>      * verification. */<=
/span><br><span>     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl-&gt;ctx=
, NULL)));</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB &amp;&am=
p; !HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL</span><br><span>     /* Initial=
ize keying material exporter, new style. */</span><br><span>     mbedtls_ss=
l_set_export_keys_cb(ks_ssl-&gt;ctx, mbedtls_ssl_export_keys_cb, session);<=
/span><br><span> #endif</span><br><span>diff --git a/src/openvpn/ssl_mbedtl=
s.h b/src/openvpn/ssl_mbedtls.h</span><br><span>index ec30bb5..309dc7ce 100=
644</span><br><span>--- a/src/openvpn/ssl_mbedtls.h</span><br><span>+++ b/s=
rc/openvpn/ssl_mbedtls.h</span><br><span>@@ -85,16 +85,20 @@</span><br><spa=
n>     void *sign_ctx;</span><br><span> };</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_EXPORT_KEYING_MATERIAL</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** struct to cache TLS=
 secrets for keying material exporter (RFC 5705).</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">- * The constants (64 and 48) are inherent to TL=
S version and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * the w=
hole keying material export will likely change when they change */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(HAVE_EXPORT_KEYI=
NG_MATERIAL) &amp;&amp; !HAVE_MBEDTLS_SSL_EXPORT_KEYING_MATERIAL</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * struct to cache TLS secrets for keying mate=
rial exporter (RFC 5705).</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Not needed if the library itself implements the keying material ex=
porter,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * or if we =
can&#39;t obtain the secrets anyway.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * The constants 64 and 48 are inherent to TLS 1.2. For TLS 1.3, it is not<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * possible to obtai=
n the exporter master secret from mbed TLS. */</span><br><span> struct tls_=
key_cache {</span><br><span>     unsigned char client_server_random[64];</s=
pan><br><span>     mbedtls_tls_prf_types tls_prf_type;</span><br><span>    =
 unsigned char master_secret[48];</span><br><span> };</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#else  /* ifdef HAVE_EXPORT_KEYING_MATERIAL=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if def=
ined(HAVE_EXPORT_KEYING_MATERIAL) &amp;&amp; !HAVE_MBEDTLS_SSL_EXPORT_KEYIN=
G_MATERIAL */</span><br><span> struct tls_key_cache { };</span><br><span> #=
endif</span><br><span> </span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail">change 1=
041</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1204bc2ff85952160a86f0b9d1c=
aae90e5065bc4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1041 </div>
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


--t+Zbfjmgvlk=--

