From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 13:40:52 +0000
In-Reply-To: <gerrit.1759928297000.I7d9ffdc7d109b3fcbd91543506f16d23000fb136@...2715...>
References: <gerrit.1759928297000.I7d9ffdc7d109b3fcbd91543506f16d23000fb136@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1e84f370cb70435be83ebefe59e0aa49eb5d1ea1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MAnmPq23iXA="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: Run
 options_parse test for MinGW
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

--MAnmPq23iXA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
57?usp=3Demail )

Change subject: GHA: Run options_parse test for MinGW
......................................................................

GHA: Run options_parse test for MinGW

Github: closes OpenVPN/openvpn#859
Change-Id: I7d9ffdc7d109b3fcbd91543506f16d23000fb136
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1257
Message-Id: <20251008131101.21498-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243956/
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 1 insertion(+), 1 deletion(-)




diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 1cef154..e068f58 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -114,7 +114,7 @@
       fail-fast: false
       matrix:
         arch: [x86, x64]
-        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, pac=
ket_id, pkt, provider, ssl, tls_crypt, user_pass]
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_=
parse, ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass]

     runs-on: windows-2025
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1257?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7d9ffdc7d109b3fcbd91543506f16d23000fb136
Gerrit-Change-Number: 1257
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MAnmPq23iXA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1257?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: Run options_parse test for MinGW<br><br>Git=
hub: closes OpenVPN/openvpn#859<br>Change-Id: I7d9ffdc7d109b3fcbd91543506f1=
6d23000fb136<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://ger=
rit.openvpn.net/c/openvpn/+/1257<br>Message-Id: &lt;20251008131101.21498-1-=
gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/messa=
ge/59243956/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<=
br>M .github/workflows/build.yaml<br>1 file changed, 1 insertion(+), 1 dele=
tion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index 1cef154..e068f58 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -114,7 +114,7 @@</span><br><span>       fail-fast: false<=
/span><br><span>       matrix:</span><br><span>         arch: [x86, x64]</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        test: [argv, aut=
h_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, ss=
l, tls_crypt, user_pass]</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, opti=
ons_parse, ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass]</span>=
<br><span> </span><br><span>     runs-on: windows-2025</span><br><span>    =
 name: &quot;mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL&=
quot;</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1257?usp=3Demail">change 1257</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1257?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d9ffdc7d109b3fcbd91543506f=
16d23000fb136 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1257 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--MAnmPq23iXA=--

