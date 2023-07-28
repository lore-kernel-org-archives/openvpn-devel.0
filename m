From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 28 Jul 2023 13:03:29 +0000
References: <gerrit.1690549401000.I889de8bafb581b810a026c7359fbfee94f1b5a4e@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net
Message-ID: <6b941ce86c4031a5535d6c1997e6ae06c9aec7b3-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lnjQMxHwVrE="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: pkcs11_openssl:
 Disable unused code
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lnjQMxHwVrE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/317?usp=3Demail )


Change subject: pkcs11_openssl: Disable unused code
......................................................................

pkcs11_openssl: Disable unused code

Coverity: CID 1539183 (#1 of 1): Structurally dead code (UNREACHABLE)

Change-Id: I889de8bafb581b810a026c7359fbfee94f1b5a4e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/pkcs11_openssl.c
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/317/1

diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/pkcs11_openssl.c
index 7c07152..40080ef 100644
--- a/src/openvpn/pkcs11_openssl.c
+++ b/src/openvpn/pkcs11_openssl.c
@@ -331,8 +331,7 @@

 #ifdef HAVE_XKEY_PROVIDER
     return (xkey_load_from_pkcs11h(certificate, ssl_ctx) =3D=3D 0); /* inv=
erts the return value */
-#endif
-
+#else
     int ret =3D 1;

     X509 *x509 =3D NULL;
@@ -402,6 +401,7 @@
         openssl_session =3D NULL;
     }
     return ret;
+#endif /* ifdef HAVE_XKEY_PROVIDER */
 }

 char *

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/317?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I889de8bafb581b810a026c7359fbfee94f1b5a4e
Gerrit-Change-Number: 317
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newchange

--lnjQMxHwVrE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/317?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">pkcs11_openssl: Disable unused code<br><br>Coverity: CID 1539183 (#=
1 of 1): Structurally dead code (UNREACHABLE)<br><br>Change-Id: I889de8bafb=
581b810a026c7359fbfee94f1b5a4e<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M src/openvpn/pkcs11_openssl.c<br>1 file changed=
, 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/17/317/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/pkc=
s11_openssl.c b/src/openvpn/pkcs11_openssl.c</span><br><span>index 7c07152.=
.40080ef 100644</span><br><span>--- a/src/openvpn/pkcs11_openssl.c</span><b=
r><span>+++ b/src/openvpn/pkcs11_openssl.c</span><br><span>@@ -331,8 +331,7=
 @@</span><br><span> </span><br><span> #ifdef HAVE_XKEY_PROVIDER</span><br>=
<span>     return (xkey_load_from_pkcs11h(certificate, ssl_ctx) =3D=3D 0); =
/* inverts the return value */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span>   =
  int ret =3D 1;</span><br><span> </span><br><span>     X509 *x509 =3D NULL=
;</span><br><span>@@ -402,6 +401,7 @@</span><br><span>         openssl_sess=
ion =3D NULL;</span><br><span>     }</span><br><span>     return ret;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef HAVE_XKEY=
_PROVIDER */</span><br><span> }</span><br><span> </span><br><span> char *</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/317?usp=3Demail">change 317</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/317?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I889de8bafb581b810a026c7359f=
bfee94f1b5a4e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 317 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--lnjQMxHwVrE=--

