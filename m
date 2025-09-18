From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 18 Sep 2025 12:23:43 +0000
References: <gerrit.1758198221000.Iaebc46f9156657128dc52c979202545be8865656@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <edd7708f0de6371c48189f69716b771864b95897-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VCmwEmLkgzI="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: GHA: collect more
 artifacts for mingw builds
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

--VCmwEmLkgzI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1200?usp=3Demail

to review the following change.


Change subject: GHA: collect more artifacts for mingw builds
......................................................................

GHA: collect more artifacts for mingw builds

Collect also binaries for openvpnserv, tapctl and openvpnmsica.

Change-Id: Iaebc46f9156657128dc52c979202545be8865656
Signed-off-by: Lev Stipakov <lev@...515...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1200/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index f7883c7..a306670 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -97,8 +97,8 @@
         with:
           name: openvpn-mingw-${{ matrix.arch }}
           path: |
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.exe
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Deb=
ug/*.dll
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
Debug/*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
Debug/*.dll
             !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/De=
bug/test_*.exe

       - uses: actions/upload-artifact@...2868... # v4.6.2

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1200?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaebc46f9156657128dc52c979202545be8865656
Gerrit-Change-Number: 1200
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--VCmwEmLkgzI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1200?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">GHA: collect more artifacts for mingw builds<br><br>Collect =
also binaries for openvpnserv, tapctl and openvpnmsica.<br><br>Change-Id: I=
aebc46f9156657128dc52c979202545be8865656<br>Signed-off-by: Lev Stipakov &lt=
;lev@...515...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file chang=
ed, 2 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/00/1200/1</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/work=
flows/build.yaml b/.github/workflows/build.yaml</span><br><span>index f7883=
c7..a306670 100644</span><br><span>--- a/.github/workflows/build.yaml</span=
><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -97,8 +97,=
8 @@</span><br><span>         with:</span><br><span>           name: openvp=
n-mingw-${{ matrix.arch }}</span><br><span>           path: |</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            ${{ github.workspace }}=
/out/build/mingw/${{ matrix.arch }}/Debug/*.exe</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            ${{ github.workspace }}/out/build/min=
gw/${{ matrix.arch }}/Debug/*.dll</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            ${{ github.workspace }}/out/build/mingw/${{ matri=
x.arch }}/**/Debug/*.exe</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}=
/**/Debug/*.dll</span><br><span>             !${{ github.workspace }}/out/b=
uild/mingw/${{ matrix.arch }}/Debug/test_*.exe</span><br><span> </span><br>=
<span>       - uses: actions/upload-artifact@...2868... # v4.6.2</span><br>=
<span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/1200?usp=3Demail">change 1200</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1200?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaebc46f9156657128dc52c97920=
2545be8865656 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1200 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--VCmwEmLkgzI=--

