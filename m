From: "MaxF (Code Review)" <gerrit@...515...>
Date: Tue, 27 May 2025 16:14:00 +0000
In-Reply-To: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
References: <gerrit.1747746380000.I1204bc2ff85952160a86f0b9d1caae90e5065bc4@...2715...>
Reply-To: max@...2606..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3436608c7a1de53e488b18fe4f4b97b2715af0f4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="udmqZqxKYEY="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--udmqZqxKYEY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: MaxF, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


Change subject: Use mbedtls_ssl_export_keying_material()
......................................................................

Use mbedtls_ssl_export_keying_material()

Mbed TLS now has an implementation of the TLS-Exporter feature (though
not yet in a released version). Use it if it's available.

v2: Rebased, changed feature detection in configure.ac

Change-Id: I1204bc2ff85952160a86f0b9d1caae90e5065bc4
Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
M configure.ac
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_mbedtls.h
3 files changed, 33 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/41/1041/3

diff --git a/configure.ac b/configure.ac
index 1b908e6..7fa2284 100644
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
=20
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 6474f80..0159166 100644
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
index 9ebb2ce..6354231 100644
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
Gerrit-PatchSet: 3
Gerrit-Owner: MaxF <max@...2606...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: MaxF <max@...2606...>
Gerrit-MessageType: newpatchset

--udmqZqxKYEY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: MaxF, flichtenheld, plaisthos. </=
p>
<p>MaxF <strong>uploaded patch set #3</strong> to this change.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Use mbedtls_ssl_export_keying_material()<br><br>=
Mbed TLS now has an implementation of the TLS-Exporter feature (though<br>n=
ot yet in a released version). Use it if it&#39;s available.<br><br>v2: Reb=
ased, changed feature detection in configure.ac<br><br>Change-Id: I1204bc2f=
f85952160a86f0b9d1caae90e5065bc4<br>Signed-off-by: Max Fillinger &lt;maximi=
lian.fillinger@...2507...&gt;<br>---<br>M configure.ac<br>M src/openvpn/ssl=
_mbedtls.c<br>M src/openvpn/ssl_mbedtls.h<br>3 files changed, 33 insertions=
(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/41/1041/3</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac<=
/span><br><span>index 1b908e6..7fa2284 100644</span><br><span>--- a/configu=
re.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -1072,7 +1072,1=
0 @@</span><br><span> 			[AC_DEFINE([HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB], =
[0], [no])]</span><br><span> 		)</span><br><span> 		if test &quot;x$ac_cv_f=
unc_mbedtls_ssl_set_export_keys_cb&quot; !=3D xyes; then</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-			AC_MSG_ERROR(This version of mbed TLS=
 has no support for exporting key material.)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+			AC_CHECK_FUNC([mbedtls_ssl_export_keying_materi=
al])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			if test &quo=
t;x$ac_cv_func_mbedtls_ssl_export_keying_material&quot; !=3D xyes; then</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+				AC_MSG_ERROR(This v=
ersion of mbed TLS has no support for exporting key material.)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+			fi</span><br><span> 		fi</spa=
n><br><span> 	fi</span><br><span> </span><br><span>diff --git a/src/openvpn=
/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 6474f80..0=
159166 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><br><sp=
an>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -251,8 +251,8 @@</spa=
n><br><span>     memcpy(cache-&gt;master_secret, secret, sizeof(cache-&gt;m=
aster_secret));</span><br><span>     cache-&gt;tls_prf_type =3D tls_prf_typ=
e;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#else  /* if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#error either mbedtls_ssl_conf_export_ke=
ys_ext_cb or mbedtls_ssl_set_export_keys_cb must be available in mbed TLS</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif !defined(MBEDTL=
S_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#error mbedtls_ssl_conf_export_keys_ext_cb, mbedtls_ssl_set_expor=
t_keys_cb or mbedtls_ssl_export_keying_material must be available in mbed T=
LS</span><br><span> #endif /* HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</=
span><br><span> </span><br><span> bool</span><br><span>@@ -262,6 +262,20 @@=
</span><br><span> {</span><br><span>     ASSERT(strlen(label) =3D=3D label_=
size);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#if defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Our version of mbed TLS has a buil=
t-in TLS-Exporter. */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbedtls_ssl_c=
ontext *ctx =3D session-&gt;key[KS_PRIMARY].ks_ssl.ctx;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (mbed_ok(mbedtls_ssl_export_keyi=
ng_material(ctx, ekm, ekm_size, label, label_size, NULL, 0, 0)))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        return true;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#else  /* defined(MBEDTLS_SSL_KEYING=
_MATERIAL_EXPORT) */</span><br><span>     struct tls_key_cache *cache =3D &=
amp;session-&gt;key[KS_PRIMARY].ks_ssl.tls_key_cache;</span><br><span> </sp=
an><br><span>     /* If the type is NONE, we either have no cached secrets =
or</span><br><span>@@ -286,6 +300,7 @@</span><br><span>         secure_memz=
ero(ekm, session-&gt;opt-&gt;ekm_size);</span><br><span>         return fal=
se;</span><br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif  /* defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */</span><br>=
<span> }</span><br><span> </span><br><span> bool</span><br><span>@@ -1226,7=
 +1241,7 @@</span><br><span>         mbedtls_ssl_conf_max_tls_version(ks_ss=
l-&gt;ssl_config, version);</span><br><span>     }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_SSL_CONF_EX=
PORT_KEYS_EXT_CB</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
 HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB &amp;&amp; !defined(MBEDTLS_SSL_K=
EYING_MATERIAL_EXPORT)</span><br><span>     /* Initialize keying material e=
xporter, old style. */</span><br><span>     mbedtls_ssl_conf_export_keys_ex=
t_cb(ks_ssl-&gt;ssl_config,</span><br><span>                               =
          mbedtls_ssl_export_keys_cb, session);</span><br><span>@@ -1241,7 =
+1256,7 @@</span><br><span>      * verification. */</span><br><span>     AS=
SERT(mbed_ok(mbedtls_ssl_set_hostname(ks_ssl-&gt;ctx, NULL)));</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS=
_SSL_SET_EXPORT_KEYS_CB</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB &amp;&amp; !defined(MBEDTLS_SSL=
_KEYING_MATERIAL_EXPORT)</span><br><span>     /* Initialize keying material=
 exporter, new style. */</span><br><span>     mbedtls_ssl_set_export_keys_c=
b(ks_ssl-&gt;ctx, mbedtls_ssl_export_keys_cb, session);</span><br><span> #e=
ndif</span><br><span>diff --git a/src/openvpn/ssl_mbedtls.h b/src/openvpn/s=
sl_mbedtls.h</span><br><span>index 9ebb2ce..6354231 100644</span><br><span>=
--- a/src/openvpn/ssl_mbedtls.h</span><br><span>+++ b/src/openvpn/ssl_mbedt=
ls.h</span><br><span>@@ -85,14 +85,21 @@</span><br><span>     void *sign_ct=
x;</span><br><span> };</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/** struct to cache TLS secrets for keying material expo=
rter (RFC 5705).</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Th=
e constants (64 and 48) are inherent to TLS version and</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * the whole keying material export will =
likely change when they change */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#if !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * struct to cache TLS secrets for keying materi=
al exporter (RFC 5705).</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * Not needed if the library itself implements the keying material expo=
rter.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * The constants 64 and 48 are =
inherent to TLS 1.2. For TLS 1.3, it is not</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * possible to obtain the exporter master secret fr=
om mbed TLS. */</span><br><span> struct tls_key_cache {</span><br><span>   =
  unsigned char client_server_random[64];</span><br><span>     mbedtls_tls_=
prf_types tls_prf_type;</span><br><span>     unsigned char master_secret[48=
];</span><br><span> };</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#else  /* !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT) */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+struct tls_key_cache { };</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </sp=
an><br><span> /**</span><br><span>  * Structure that wraps the TLS context.=
 Contents differ depending on the</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail=
">change 1041</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1041?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1204bc2ff85952160a86f0b9d1c=
aae90e5065bc4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1041 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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


--udmqZqxKYEY=--

