From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 3 Jun 2025 14:14:46 +0000
In-Reply-To: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
References: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 max@...2606...
Message-ID: <43769f39dc8e8bef71fa8cde910bdfbb750aa825-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ySZpVXnkwqo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Use
 mbedtls_ssl_export_keying_material()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: MaxF <max@...2606...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ySZpVXnkwqo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
41?usp=3Demail )

Change subject: Use mbedtls_ssl_export_keying_material()
......................................................................

Use mbedtls_ssl_export_keying_material()

Mbed TLS now has an implementation of the TLS-Exporter feature (though
not yet in a released version). Use it if it's available.

v2: Rebased, changed feature detection in configure.ac

Change-Id: I1204bc2ff85952160a86f0b9d1caae90e5065bc4
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20250603140414.10970-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
856.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
3 files changed, 33 insertions(+), 8 deletions(-)




diff --git a/configure.ac b/configure.ac
index c70892a..8bdec32 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1072,7 +1072,10 @@
 			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]
 		)
 		if test "x$ac_cv_func_mbedtls_ssl_set_export_keys_cb" !=3D xyes; then
-			AC_MSG_ERROR(This version of mbed TLS has no support for exporting key =
material.)
+			AC_CHECK_FUNC([mbedtls_ssl_export_keying_material])
+			if test "x$ac_cv_func_mbedtls_ssl_export_keying_material" !=3D xyes; th=
en
+				AC_MSG_ERROR(This version of mbed TLS has no support for exporting key=
 material.)
+			fi
 		fi
 	fi

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 5936ca3..7452c30 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -251,8 +251,8 @@
     memcpy(cache->master_secret, secret, sizeof(cache->master_secret));
     cache->tls_prf_type =3D tls_prf_type;
 }
-#else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */
-#error either mbedtls_ssl_conf_export_keys_ext_cb or mbedtls_ssl_set_expor=
t_keys_cb must be available in mbed TLS
+#elif !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+#error mbedtls_ssl_conf_export_keys_ext_cb, mbedtls_ssl_set_export_keys_cb=
 or mbedtls_ssl_export_keying_material must be available in mbed TLS
 #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */

 bool
@@ -262,6 +262,20 @@
 {
     ASSERT(strlen(label) =3D=3D label_size);

+#if defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
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
+#else  /* defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
     struct tls_key_cache *cache =3D &session->key[KS_PRIMARY].ks_ssl.tls_k=
ey_cache;

     /* If the type is NONE, we either have no cached secrets or
@@ -286,6 +300,7 @@
         secure_memzero(ekm, session->opt->ekm_size);
         return false;
     }
+#endif  /* defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
 }

 bool
@@ -1226,7 +1241,7 @@
         mbedtls_ssl_conf_max_tls_version(ks_ssl->ssl_config, version);
     }

-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB && !defined(MBEDTLS_SSL_KEYIN=
G_MATERIAL_EXPORT)
     /* Initialize keying material exporter, old style. */
     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
                                         mbedtls_ssl_export_keys_cb, sessio=
n);
@@ -1241,7 +1256,7 @@
      * verification. */
     ASSERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl->ctx, NULL)));

-#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB && !defined(MBEDTLS_SSL_KEYING_MAT=
ERIAL_EXPORT)
     /* Initialize keying material exporter, new style. */
     mbedtls_ssl_set_export_keys_cb(ks_ssl->ctx, mbedtls_ssl_export_keys_cb=
, session);
 #endif
diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h
index 3841eff..9f124cd 100644
--- a/src/openvpn/ssl_mbedtls.h
+++ b/src/openvpn/ssl_mbedtls.h
@@ -85,14 +85,21 @@
     void *sign_ctx;
 };

-/** struct to cache TLS secrets for keying material exporter (RFC 5705).
- * The constants (64 and 48) are inherent to TLS version and
- * the whole keying material export will likely change when they change */
+#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)
+/**
+ * struct to cache TLS secrets for keying material exporter (RFC 5705).
+ * Not needed if the library itself implements the keying material exporte=
r.
+ *
+ * The constants 64 and 48 are inherent to TLS 1.2. For TLS 1.3, it is not
+ * possible to obtain the exporter master secret from mbed TLS. */
 struct tls_key_cache {
     unsigned char client_server_random[64];
     mbedtls_tls_prf_types tls_prf_type;
     unsigned char master_secret[48];
 };
+#else  /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */
+struct tls_key_cache { };
+#endif

 /**
  * Structure that wraps the TLS context. Contents differ depending on the

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1204bc2ff85952160a86f0b9d1caae90e5065bc4
Gerrit-Change-Number: 1041
Gerrit-PatchSet: 4
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--ySZpVXnkwqo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1041?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Use mbedtls_ssl_export_keying_material()<br><=
br>Mbed TLS now has an implementation of the TLS-Exporter feature (though<b=
r>not yet in a released version). Use it if it&#39;s available.<br><br>v2: =
Rebased, changed feature detection in configure.ac<br><br>Change-Id: I1204b=
c2ff85952160a86f0b9d1caae90e5065bc4<br>Signed-off-by: Max Fillinger &lt;max=
imilian.fillinger@...2507...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>Message-Id: &lt;20250603140414.10970-1-gert@...1296...&gt;=
<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/m=
sg31856.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<=
br>M configure.ac<br>M src/openvpn/ssl_mbedtls.c<br>M src/openvpn/ssl_mbedt=
ls.h<br>3 files changed, 33 insertions(+), 8 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index c70892a..=
8bdec32 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -1072,7 +1072,10 @@</span><br><span> 			[AC_DE=
FINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], [0], [no])]</span><br><span> 		=
)</span><br><span> 		if test &quot;x$ac_cv_func_mbedtls_ssl_set_export_keys=
_cb&quot; !=3D xyes; then</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-			AC_MSG_ERROR(This version of mbed TLS has no support for exporting k=
ey material.)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			AC_=
CHECK_FUNC([mbedtls_ssl_export_keying_material])</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+			if test &quot;x$ac_cv_func_mbedtls_ssl_expo=
rt_keying_material&quot; !=3D xyes; then</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+				AC_MSG_ERROR(This version of mbed TLS has no suppo=
rt for exporting key material.)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+			fi</span><br><span> 		fi</span><br><span> 	fi</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ss=
l_mbedtls.c</span><br><span>index 5936ca3..7452c30 100644</span><br><span>-=
-- a/src/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtl=
s.c</span><br><span>@@ -251,8 +251,8 @@</span><br><span>     memcpy(cache-&=
gt;master_secret, secret, sizeof(cache-&gt;master_secret));</span><br><span=
>     cache-&gt;tls_prf_type =3D tls_prf_type;</span><br><span> }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#else  /* if HAVE_MBEDTLS_SSL_C=
ONF_EXPORT_KEYS_EXT_CB */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#error either mbedtls_ssl_conf_export_keys_ext_cb or mbedtls_ssl_set_ex=
port_keys_cb must be available in mbed TLS</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#elif !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#error mbedtls_ssl_co=
nf_export_keys_ext_cb, mbedtls_ssl_set_export_keys_cb or mbedtls_ssl_export=
_keying_material must be available in mbed TLS</span><br><span> #endif /* H=
AVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span> </span><br><spa=
n> bool</span><br><span>@@ -262,6 +262,20 @@</span><br><span> {</span><br><=
span>     ASSERT(strlen(label) =3D=3D label_size);</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(MBEDTLS_SSL_KE=
YING_MATERIAL_EXPORT)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    /* Our version of mbed TLS has a built-in TLS-Exporter. */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    mbedtls_ssl_context *ctx =3D session-&gt;key[=
KS_PRIMARY].ks_ssl.ctx;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (mbed_ok(mbedtls_ssl_export_keying_material(ctx, ekm, ekm_size, =
label, label_size, NULL, 0, 0)))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#else  /* defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */</span><br><sp=
an>     struct tls_key_cache *cache =3D &amp;session-&gt;key[KS_PRIMARY].ks=
_ssl.tls_key_cache;</span><br><span> </span><br><span>     /* If the type i=
s NONE, we either have no cached secrets or</span><br><span>@@ -286,6 +300,=
7 @@</span><br><span>         secure_memzero(ekm, session-&gt;opt-&gt;ekm_s=
ize);</span><br><span>         return false;</span><br><span>     }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#endif  /* defined(MBEDTLS_=
SSL_KEYING_MATERIAL_EXPORT) */</span><br><span> }</span><br><span> </span><=
br><span> bool</span><br><span>@@ -1226,7 +1241,7 @@</span><br><span>      =
   mbedtls_ssl_conf_max_tls_version(ks_ssl-&gt;ssl_config, version);</span>=
<br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS=
_EXT_CB &amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><=
span>     /* Initialize keying material exporter, old style. */</span><br><=
span>     mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl-&gt;ssl_config,</span>=
<br><span>                                         mbedtls_ssl_export_keys_=
cb, session);</span><br><span>@@ -1241,7 +1256,7 @@</span><br><span>      *=
 verification. */</span><br><span>     ASSERT(mbed_ok(mbedtls_ssl_set_hostn=
ame(ks_ssl-&gt;ctx, NULL)));</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_SET_EXPOR=
T_KEYS_CB &amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br=
><span>     /* Initialize keying material exporter, new style. */</span><br=
><span>     mbedtls_ssl_set_export_keys_cb(ks_ssl-&gt;ctx, mbedtls_ssl_expo=
rt_keys_cb, session);</span><br><span> #endif</span><br><span>diff --git a/=
src/openvpn/ssl_mbedtls.h b/src/openvpn/ssl_mbedtls.h</span><br><span>index=
 3841eff..9f124cd 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.h</s=
pan><br><span>+++ b/src/openvpn/ssl_mbedtls.h</span><br><span>@@ -85,14 +85=
,21 @@</span><br><span>     void *sign_ctx;</span><br><span> };</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/** struct to c=
ache TLS secrets for keying material exporter (RFC 5705).</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * The constants (64 and 48) are inhere=
nt to TLS version and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * the whole keying material export will likely change when they change */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if !defined(MBEDTLS=
_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * stru=
ct to cache TLS secrets for keying material exporter (RFC 5705).</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * Not needed if the library i=
tself implements the keying material exporter.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * The constants 64 and 48 are inherent to TLS 1.2. For TLS 1.3, =
it is not</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * possibl=
e to obtain the exporter master secret from mbed TLS. */</span><br><span> s=
truct tls_key_cache {</span><br><span>     unsigned char client_server_rand=
om[64];</span><br><span>     mbedtls_tls_prf_types tls_prf_type;</span><br>=
<span>     unsigned char master_secret[48];</span><br><span> };</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#else  /* !defined(MBEDTLS_SSL_=
KEYING_MATERIAL_EXPORT) */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+struct tls_key_cache { };</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span> </span><br><span> /**</span><br><span>=
  * Structure that wraps the TLS context. Contents differ depending on the<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1041?usp=3Demail">change 1041</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1041?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1204bc2ff85952160a86f0b9d1c=
aae90e5065bc4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1041 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: MaxF &lt;max@...2606...&gt; </di=
v>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--ySZpVXnkwqo=--

