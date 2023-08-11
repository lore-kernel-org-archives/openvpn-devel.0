From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 11 Aug 2023 15:09:52 +0000
In-Reply-To: <gerrit.1690549401000.I889de8bafb581b810a026c7359fbfee94f1b5a4e@...2715...>
References: <gerrit.1690549401000.I889de8bafb581b810a026c7359fbfee94f1b5a4e@...2715...>
Reply-To: selva.nair@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <c8c71b765d0827deaeb3babe53ebfec774d6b910-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FLD4q6ITKyY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, selvanair <selva.nair@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FLD4q6ITKyY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/317?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by selvanair


Change subject: pkcs11_openssl: Disable unused code
......................................................................

pkcs11_openssl: Disable unused code

Coverity: CID 1539183 (#1 of 1): Structurally dead code (UNREACHABLE)

Change-Id: I889de8bafb581b810a026c7359fbfee94f1b5a4e
Gerrit: http://gerrit.openvpn.net/c/openvpn/+/317
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Selva Nair <selva.nair@...277...>
Message-Id: <6b941ce86c4031a5535d6c1997e6ae06c9aec7b3-HTML@...2715...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26=
901.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/pkcs11_openssl.c
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/317/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--FLD4q6ITKyY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/317?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+1 by selvanair</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">pkcs11_openssl: Disable unused code<br><br>Cover=
ity: CID 1539183 (#1 of 1): Structurally dead code (UNREACHABLE)<br><br>Cha=
nge-Id: I889de8bafb581b810a026c7359fbfee94f1b5a4e<br>Gerrit: http://gerrit.=
openvpn.net/c/openvpn/+/317<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>Acked-by: Selva Nair &lt;selva.nair@...277...&gt;<br>Messa=
ge-Id: &lt;6b941ce86c4031a5535d6c1997e6ae06c9aec7b3-HTML@...2715...&gt;<br>=
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26=
901.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M=
 src/openvpn/pkcs11_openssl.c<br>1 file changed, 2 insertions(+), 2 deletio=
ns(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/17/317/2</pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;"><span>diff --git a/src/openvpn/pkcs11_openssl.c b/src/openvpn/=
pkcs11_openssl.c</span><br><span>index 7c07152..40080ef 100644</span><br><s=
pan>--- a/src/openvpn/pkcs11_openssl.c</span><br><span>+++ b/src/openvpn/pk=
cs11_openssl.c</span><br><span>@@ -331,8 +331,7 @@</span><br><span> </span>=
<br><span> #ifdef HAVE_XKEY_PROVIDER</span><br><span>     return (xkey_load=
_from_pkcs11h(certificate, ssl_ctx) =3D=3D 0); /* inverts the return value =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#else</span><br><span>     int ret =3D 1;</span><br><=
span> </span><br><span>     X509 *x509 =3D NULL;</span><br><span>@@ -402,6 =
+401,7 @@</span><br><span>         openssl_session =3D NULL;</span><br><spa=
n>     }</span><br><span>     return ret;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* ifdef HAVE_XKEY_PROVIDER */</span><br><span=
> }</span><br><span> </span><br><span> char *</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/317?=
usp=3Demail">change 317</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/317?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I889de8bafb581b810a026c7359f=
bfee94f1b5a4e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 317 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FLD4q6ITKyY=--

