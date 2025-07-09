From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 9 Jul 2025 11:57:25 +0000
References: <gerrit.1752062243000.I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <53f08ac208c22aad1a779a926414f31eab29c251-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8b8Nu9artd4="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Do not compile mbed
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

--8b8Nu9artd4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail

to review the following change.


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
1 file changed, 3 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1081/1

diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index ecccc26..911d4bb 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -174,7 +174,7 @@
     return ctx->initialised;
 }

-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB
+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB && !defined(MBEDTLS_SSL_KEYIN=
G_MATERIAL_EXPORT)
 /*
  * Key export callback for older versions of mbed TLS, to be used with
  * mbedtls_ssl_conf_export_keys_ext_cb(). It is called with the master
@@ -205,7 +205,7 @@

     return 0;
 }
-#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
+#elif defined(HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB) && !defined(MBEDTLS_SSL=
_KEYING_MATERIAL_EXPORT)
 /*
  * Key export callback for newer versions of mbed TLS, to be used with
  * mbedtls_ssl_set_export_keys_cb(). When used with TLS 1.2, the callback
@@ -255,6 +255,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--8b8Nu9artd4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1081?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Do not compile mbed key helper with MBEDTLS_SSL_KEYING_MATER=
IAL_EXPORT<br><br>The helper methods are only used when we don&#39;t have<b=
r>MBEDTLS_SSL_KEYING_MATERIAL_EXPORT and mbedtls_ssl_export_keying_material=
.<br><br>Change-Id: I0f325800ebeb20bd5ef3ff78e5c5fcf0f6f74efd<br>Signed-off=
-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/ssl_mbedt=
ls.c<br>1 file changed, 3 insertions(+), 2 deletions(-)<br><br></pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull =
ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/1081/1</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><sp=
an>index ecccc26..911d4bb 100644</span><br><span>--- a/src/openvpn/ssl_mbed=
tls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -1=
74,7 +174,7 @@</span><br><span>     return ctx-&gt;initialised;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if HAVE_MBEDTLS_SSL_CONF_EXPORT_KEYS_EXT_CB &=
amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATERIAL_EXPORT)</span><br><span> /*<=
/span><br><span>  * Key export callback for older versions of mbed TLS, to =
be used with</span><br><span>  * mbedtls_ssl_conf_export_keys_ext_cb(). It =
is called with the master</span><br><span>@@ -205,7 +205,7 @@</span><br><sp=
an> </span><br><span>     return 0;</span><br><span> }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#elif HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#elif defined(HAVE_M=
BEDTLS_SSL_SET_EXPORT_KEYS_CB) &amp;&amp; !defined(MBEDTLS_SSL_KEYING_MATER=
IAL_EXPORT)</span><br><span> /*</span><br><span>  * Key export callback for=
 newer versions of mbed TLS, to be used with</span><br><span>  * mbedtls_ss=
l_set_export_keys_cb(). When used with TLS 1.2, the callback</span><br><spa=
n>@@ -255,6 +255,7 @@</span><br><span> #error mbedtls_ssl_conf_export_keys_=
ext_cb, mbedtls_ssl_set_export_keys_cb or mbedtls_ssl_export_keying_materia=
l must be available in mbed TLS</span><br><span> #endif /* HAVE_MBEDTLS_SSL=
_CONF_EXPORT_KEYS_EXT_CB */</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> bool</span><br><span> key_state=
_export_keying_material(struct tls_session *session,</span><br><span>      =
                            const char *label, size_t label_size,</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1081?usp=3Demail">change 1081</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1081?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0f325800ebeb20bd5ef3ff78e5c=
5fcf0f6f74efd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1081 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--8b8Nu9artd4=--

