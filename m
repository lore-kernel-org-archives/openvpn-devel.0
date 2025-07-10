From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 10 Jul 2025 10:24:13 +0000
In-Reply-To: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
References: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <67b0b5e4c564098de57b2cfbedeafd21fc7c13a8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8lEAn83Uogw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Do not compile mbed
 key helper with MBEDTLS_SSL_KEYING_MATERIAL_EXPORT
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

--8lEAn83Uogw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Do not compile mbed key helper with MBEDTLS_SSL_KEYING_MATE=
RIAL_EXPORT
......................................................................

Do not compile mbed key helper with MBEDTLS_SSL_KEYING_MATERIAL_EXPORT

The helper methods are only used when we don't have
MBEDTLS_SSL_KEYING_MATERIAL_EXPORT and mbedtls_ssl_export_keying_material.

Change-Id: I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/ssl_mbedtls.c
1 file changed, 6 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1081/2

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ecccc26..569421c 100644
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
+#elif HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd
Gerrit-Change-Number: 1081
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--8lEAn83Uogw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Do not compile mbed key helper with MBEDTLS_S=
SL_KEYING_MATERIAL_EXPORT<br><br>The helper methods are only used when we d=
on&#39;t have<br>MBEDTLS_SSL_KEYING_MATERIAL_EXPORT and mbedtls_ssl_export_=
keying_material.<br><br>Change-Id: I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74ef=
d<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/op=
envpn/ssl_mbedtls.c<br>1 file changed, 6 insertions(+), 4 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1081/=
2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.=
c</span><br><span>index ecccc26..569421c 100644</span><br><span>--- a/src/o=
penvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span>=
<br><span>@@ -173,8 +173,9 @@</span><br><span>     ASSERT(NULL !=3D ctx);</=
span><br><span>     return ctx-&gt;initialised;</span><br><span> }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef MBEDTLS_SSL_KEYING_=
MATERIAL_EXPORT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* m=
bedtls_ssl_export_keying_material does not need helper/callback methods */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif HAVE_MBEDTLS_S=
SL_CONF_EXPORT_KEYS_EXT_CB</span><br><span> /*</span><br><span>  * Key expo=
rt callback for older versions of mbed TLS, to be used with</span><br><span=
>  * mbedtls_ssl_conf_export_keys_ext_cb(). It is called with the master</s=
pan><br><span>@@ -205,7 +206,7 @@</span><br><span> </span><br><span>     re=
turn 0;</span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#elif defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_C=
B)</span><br><span> /*</span><br><span>  * Key export callback for newer ve=
rsions of mbed TLS, to be used with</span><br><span>  * mbedtls_ssl_set_exp=
ort_keys_cb(). When used with TLS 1.2, the callback</span><br><span>@@ -251=
,10 +252,11 @@</span><br><span>     memcpy(cache-&gt;master_secret, secret,=
 sizeof(cache-&gt;master_secret));</span><br><span>     cache-&gt;tls_prf_t=
ype =3D tls_prf_type;</span><br><span> }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#elif !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif  /* ifdef MBEDTLS_S=
SL_KEYING_MATERIAL_EXPORT */</span><br><span> #error mbedtls_ssl_conf_expor=
t_keys_ext_cb, mbedtls_ssl_set_export_keys_cb or mbedtls_ssl_export_keying_=
material must be available in mbed TLS</span><br><span> #endif /* HAVE_MBED=
TLS_SSL_CONF_EXPORT_KEYS_EXT_CB */</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> k=
ey_state_export_keying_material(struct tls_session *session,</span><br><spa=
n>                                  const char *label, size_t label_size,</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1081?usp=3Demail">change 1081</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1081?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f325800ebeb20bd5ef3ff78e5c=
5fcf0f6f74efd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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


--8lEAn83Uogw=--

