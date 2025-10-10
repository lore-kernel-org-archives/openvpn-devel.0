From: "selvanair (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 02:20:36 +0000
References: <gerrit.1760062834000.Ic6fd6ba676b4741da7811ffc7c9688d4673465f8@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9582fd3bfee02c1ba145193e4097a1211802c21e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A7RtlZreHtM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--A7RtlZreHtM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1263?usp=3Demail

to review the following change.


Change subject: Fix PIN cache time in test_pkcs11.c
......................................................................

Fix PIN cache time in test_pkcs11.c

Github: closes OpenVPN/openvpn#861

Change-Id: Ic6fd6ba676b4741da7811ffc7c9688d4673465f8
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M tests/unit_tests/openvpn/test_pkcs11.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/63/1263/1

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

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1263?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic6fd6ba676b4741da7811ffc7c9688d4673465f8
Gerrit-Change-Number: 1263
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--A7RtlZreHtM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1263?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Fix PIN cache time in test_pkcs11.c<br><br>=
Github: closes OpenVPN/openvpn#861<br><br>Change-Id: Ic6fd6ba676b4741da7811=
ffc7c9688d4673465f8<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&g=
t;<br>---<br>M tests/unit_tests/openvpn/test_pkcs11.c<br>1 file changed, 1 =
insertion(+), 1 deletion(-)<br><br></pre><pre class=3D"blocks" style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/63/1263/1</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tes=
ts/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.=
c</span><br><span>index a4ba088..01cbf96 100644</span><br><span>--- a/tests=
/unit_tests/openvpn/test_pkcs11.c</span><br><span>+++ b/tests/unit_tests/op=
envpn/test_pkcs11.c</span><br><span>@@ -320,7 +320,7 @@</span><br><span>   =
  /* set default propq as we do in ssl_openssl.c */</span><br><span>     EV=
P_set_default_properties(tls_libctx, &quot;?provider!=3Dovpn.xkey&quot;);</=
span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    pkcs11_initialize(true, 0); /* protected auth enabled, pin-cache =3D 0=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pkcs11_initi=
alize(true, 60); /* protected auth enabled, pin-cache =3D 60s */</span><br>=
<span>     pkcs11_addProvider(SOFTHSM2_MODULE_PATH, false, 0, false);</span=
><br><span>     return 0;</span><br><span> }</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1263?=
usp=3Demail">change 1263</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1263?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic6fd6ba676b4741da7811ffc7c9=
688d4673465f8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1263 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
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

</body></html>=

--A7RtlZreHtM=--

