From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 8 Mar 2024 11:25:32 +0000
In-Reply-To: <gerrit.1708078156000.Id6b038c1c0095b2f22033e9dc7090e2507a373ab@...2715...>
References: <gerrit.1708078156000.Id6b038c1c0095b2f22033e9dc7090e2507a373ab@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <57076bf8363f10c93a4e9a71cd600b6a181e742a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WQaDZ7wxIaU="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]:
 check_compression_settings_valid: Do not test for LZ4 in LZO check
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WQaDZ7wxIaU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/52=
6?usp=3Demail )

Change subject: check_compression_settings_valid: Do not test for LZ4 in LZ=
O check
......................................................................

check_compression_settings_valid: Do not test for LZ4 in LZO check

Probably introduced by copy & paste since there is no
COMP_ALGV2_LZO.

Github: #500
Change-Id: Id6b038c1c0095b2f22033e9dc7090e2507a373ab
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240216123037.3670448-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
251.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/comp.c
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c
index 6e30369..311f3e9 100644
--- a/src/openvpn/comp.c
+++ b/src/openvpn/comp.c
@@ -195,7 +195,7 @@
     }
 #endif
 #ifndef ENABLE_LZO
-    if (info->alg =3D=3D COMP_ALG_LZO || info->alg =3D=3D COMP_ALG_LZ4)
+    if (info->alg =3D=3D COMP_ALG_LZO)
     {
         msg(msglevel, "OpenVPN is compiled without LZO support. Requested "
             "compression cannot be enabled.");

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/526?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id6b038c1c0095b2f22033e9dc7090e2507a373ab
Gerrit-Change-Number: 526
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--WQaDZ7wxIaU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/526?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">check_compression_settings_valid: Do not test =
for LZ4 in LZO check<br><br>Probably introduced by copy &amp; paste since t=
here is no<br>COMP_ALGV2_LZO.<br><br>Github: #500<br>Change-Id: Id6b038c1c0=
095b2f22033e9dc7090e2507a373ab<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<=
br>Message-Id: &lt;20240216123037.3670448-1-frank@...2641...&gt;<br>URL: ht=
tps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28251.htm=
l<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/op=
envpn/comp.c<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c</span><br><span>ind=
ex 6e30369..311f3e9 100644</span><br><span>--- a/src/openvpn/comp.c</span><=
br><span>+++ b/src/openvpn/comp.c</span><br><span>@@ -195,7 +195,7 @@</span=
><br><span>     }</span><br><span> #endif</span><br><span> #ifndef ENABLE_L=
ZO</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (info-&gt;al=
g =3D=3D COMP_ALG_LZO || info-&gt;alg =3D=3D COMP_ALG_LZ4)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (info-&gt;alg =3D=3D COMP_ALG=
_LZO)</span><br><span>     {</span><br><span>         msg(msglevel, &quot;O=
penVPN is compiled without LZO support. Requested &quot;</span><br><span>  =
           &quot;compression cannot be enabled.&quot;);</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/526?usp=3Demail">change 526</a>. To unsubscribe, or for help writing =
mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/526?usp=3De=
mail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id6b038c1c0095b2f22033e9dc70=
90e2507a373ab </div>
<div style=3D"display:none"> Gerrit-Change-Number: 526 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--WQaDZ7wxIaU=--

