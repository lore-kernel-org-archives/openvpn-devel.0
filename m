From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 13:03:20 +0000
In-Reply-To: <gerrit.1759928297000.I7d9ffdc7d109b3fcbd91543506f16d23000fb136@...2715...>
References: <gerrit.1759928297000.I7d9ffdc7d109b3fcbd91543506f16d23000fb136@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d8571b51c63fb47f568980c363704a3112a6b875-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+HXQdRaf3Q0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+HXQdRaf3Q0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1257?usp=3Demail

to look at the new patch set (#2).


Change subject: GHA: Run options_parse test for MinGW
......................................................................

GHA: Run options_parse test for MinGW

Github: #859
Change-Id: I7d9ffdc7d109b3fcbd91543506f16d23000fb136
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 1 insertion(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/1257/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7d9ffdc7d109b3fcbd91543506f16d23000fb136
Gerrit-Change-Number: 1257
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--+HXQdRaf3Q0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1257?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">GHA: Run options_parse test for MinGW<br><br>Git=
hub: #859<br>Change-Id: I7d9ffdc7d109b3fcbd91543506f16d23000fb136<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M .github/wor=
kflows/build.yaml<br>1 file changed, 1 insertion(+), 1 deletion(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/57/1257/2</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/=
workflows/build.yaml</span><br><span>index 1cef154..e068f58 100644</span><b=
r><span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/wo=
rkflows/build.yaml</span><br><span>@@ -114,7 +114,7 @@</span><br><span>    =
   fail-fast: false</span><br><span>       matrix:</span><br><span>        =
 arch: [x86, x64]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_i=
d, pkt, provider, ssl, tls_crypt, user_pass]</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        test: [argv, auth_token, buffer, cryptoapi=
, crypto, misc, options_parse, ncp, packet_id, pkt, provider, ssl, tls_cryp=
t, user_pass]</span><br><span> </span><br><span>     runs-on: windows-2025<=
/span><br><span>     name: &quot;mingw unittest ${{ matrix.test }} - ${{ ma=
trix.arch }} - OSSL&quot;</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1257?usp=3Demail">change=
 1257</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1257?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7d9ffdc7d109b3fcbd91543506f=
16d23000fb136 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1257 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--+HXQdRaf3Q0=--

