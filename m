From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 10 Oct 2025 07:16:52 +0000
In-Reply-To: <gerrit.1760062834000.Ic6fd6ba676b4741da7811ffc7c9688d4673465f8@...2715...>
References: <gerrit.1760062834000.Ic6fd6ba676b4741da7811ffc7c9688d4673465f8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9e60ce4fa08db15e6c0d25d1fa28f97fe8c7c745-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/YOdiWpuuqM="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/YOdiWpuuqM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
63?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic6fd6ba676b4741da7811ffc7c9688d4673465f8
Gerrit-Change-Number: 1263
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/YOdiWpuuqM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1263?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Fix PIN cache time in test_pkcs11.c<br><br>Githu=
b: closes OpenVPN/openvpn#861<br><br>Change-Id: Ic6fd6ba676b4741da7811ffc7c=
9688d4673465f8<br>Signed-off-by: Selva Nair &lt;selva.nair@...277...&gt;<br=
>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: http=
s://gerrit.openvpn.net/c/openvpn/+/1263<br>Message-Id: &lt;20251010063934.1=
8197-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-dev=
el@lists.sourceforge.net/msg33306.html<br>Signed-off-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_pkcs11.c<br>1 =
file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/o=
penvpn/test_pkcs11.c</span><br><span>index a4ba088..01cbf96 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>@@ -320,7 +320,7 @@<=
/span><br><span>     /* set default propq as we do in ssl_openssl.c */</spa=
n><br><span>     EVP_set_default_properties(tls_libctx, &quot;?provider!=3D=
ovpn.xkey&quot;);</span><br><span> #endif</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    pkcs11_initialize(true, 0); /* protected auth enabl=
ed, pin-cache =3D 0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    pkcs11_initialize(true, 60); /* protected auth enabled, pin-cache =
=3D 60s */</span><br><span>     pkcs11_addProvider(SOFTHSM2_MODULE_PATH, fa=
lse, 0, false);</span><br><span>     return 0;</span><br><span> }</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1263?usp=3Demail">change 1263</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1263?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--/YOdiWpuuqM=--

