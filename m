From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 16 Feb 2024 10:09:18 +0000
References: <gerrit.1708078156000.Id6b038c1c0095b2f22033e9dc7090e2507a373ab@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <745034d45020b812fa63dcda984dd56b1e7a36c4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R1BOJN+ntwQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--R1BOJN+ntwQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/526?usp=3Demail

to review the following change.


Change subject: check_compression_settings_valid: Do not test for LZ4 in LZ=
O check
......................................................................

check_compression_settings_valid: Do not test for LZ4 in LZO check

Probably introduced by copy & paste since there is no
COMP_ALGV2_LZO.

Github: #500
Change-Id: Id6b038c1c0095b2f22033e9dc7090e2507a373ab
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/comp.c
1 file changed, 1 insertion(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/26/526/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--R1BOJN+ntwQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/526?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">check_compression_settings_valid: Do not test for LZ4 in LZO =
check<br><br>Probably introduced by copy &amp; paste since there is no<br>C=
OMP_ALGV2_LZO.<br><br>Github: #500<br>Change-Id: Id6b038c1c0095b2f22033e9dc=
7090e2507a373ab<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>---<br>M src/openvpn/comp.c<br>1 file changed, 1 insertion(+), 1 delet=
ion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/26/526/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/comp.c b/src/openvpn/comp.c</s=
pan><br><span>index 6e30369..311f3e9 100644</span><br><span>--- a/src/openv=
pn/comp.c</span><br><span>+++ b/src/openvpn/comp.c</span><br><span>@@ -195,=
7 +195,7 @@</span><br><span>     }</span><br><span> #endif</span><br><span>=
 #ifndef ENABLE_LZO</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (info-&gt;alg =3D=3D COMP_ALG_LZO || info-&gt;alg =3D=3D COMP_ALG_LZ4)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (info-&gt;al=
g =3D=3D COMP_ALG_LZO)</span><br><span>     {</span><br><span>         msg(=
msglevel, &quot;OpenVPN is compiled without LZO support. Requested &quot;</=
span><br><span>             &quot;compression cannot be enabled.&quot;);</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/526?usp=3Demail">change 526</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/526?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id6b038c1c0095b2f22033e9dc70=
90e2507a373ab </div>
<div style=3D"display:none"> Gerrit-Change-Number: 526 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--R1BOJN+ntwQ=--

