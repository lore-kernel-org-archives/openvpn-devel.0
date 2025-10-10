From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 07:16:50 +0000
In-Reply-To: <gerrit.1760062834000.Ic6fd6ba676b4741da7811ffc7c9688d4673465f8@...2715...>
References: <gerrit.1760062834000.Ic6fd6ba676b4741da7811ffc7c9688d4673465f8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9e60ce4fa08db15e6c0d25d1fa28f97fe8c7c745-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="L3dXyhI/Q2U="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Fix PIN cache time
 in test_pkcs11.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L3dXyhI/Q2U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1263?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: Fix PIN cache time in test_pkcs11.c
......................................................................

Fix PIN cache time in test_pkcs11.c

Github: closes OpenVPN/openvpn#861

Change-Id: Ic6fd6ba676b4741da7811ffc7c9688d4673465f8
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1263
Message-Id: <20251010063934.18197-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
306.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_pkcs11.c
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1263/2

diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index a4ba088..01cbf96 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -320,7 +320,7 @@
     /* set default propq as we do in ssl_openssl.c */
     EVP_set_default_properties(tls_libctx, "?provider!=3Dovpn.xkey");
 #endif
-    pkcs11_initialize(true, 0); /* protected auth enabled, pin-cache =3D 0=
 */
+    pkcs11_initialize(true, 60); /* protected auth enabled, pin-cache =3D =
60s */
     pkcs11_addProvider(SOFTHSM2_MODULE_PATH, false, 0, false);
     return 0;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1263?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic6fd6ba676b4741da7811ffc7c9688d4673465f8
Gerrit-Change-Number: 1263
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--L3dXyhI/Q2U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1263?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Fix PIN cache time in test_pkcs=
11.c<br><br>Github: closes OpenVPN/openvpn#861<br><br>Change-Id: Ic6fd6ba67=
6b4741da7811ffc7c9688d4673465f8<br>Signed-off-by: Selva Nair &lt;selva.nair=
@...277...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br=
>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1263<br>Message-Id: &lt=
;20251010063934.18197-1-gert@...1296...&gt;<br>URL: https://www.mail-archiv=
e.com/openvpn-devel@lists.sourceforge.net/msg33306.html<br>Signed-off-by: G=
ert Doering &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/te=
st_pkcs11.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/6=
3/1263/2</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/test=
s/unit_tests/openvpn/test_pkcs11.c</span><br><span>index a4ba088..01cbf96 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_pkcs11.c</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>@@ -32=
0,7 +320,7 @@</span><br><span>     /* set default propq as we do in ssl_ope=
nssl.c */</span><br><span>     EVP_set_default_properties(tls_libctx, &quot=
;?provider!=3Dovpn.xkey&quot;);</span><br><span> #endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    pkcs11_initialize(true, 0); /* protec=
ted auth enabled, pin-cache =3D 0 */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    pkcs11_initialize(true, 60); /* protected auth enabled=
, pin-cache =3D 60s */</span><br><span>     pkcs11_addProvider(SOFTHSM2_MOD=
ULE_PATH, false, 0, false);</span><br><span>     return 0;</span><br><span>=
 }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1263?usp=3Demail">change 1263</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1263?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic6fd6ba676b4741da7811ffc7c9=
688d4673465f8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1263 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--L3dXyhI/Q2U=--

