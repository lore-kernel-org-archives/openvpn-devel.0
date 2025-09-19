From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 19 Sep 2025 13:05:53 +0000
In-Reply-To: <gerrit.1758198221000.Iaebc46f9156657128dc52c979202545be8865656@...2715...>
References: <gerrit.1758198221000.Iaebc46f9156657128dc52c979202545be8865656@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <99883a87ad11ae65b22eaaab09d75370006d6622-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="whVrdJa4ZZ8="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--whVrdJa4ZZ8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1200?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: GHA: collect more artifacts for mingw builds
......................................................................

GHA: collect more artifacts for mingw builds

Collect also binaries for openvpnserv, tapctl and openvpnmsica.

Change-Id: Iaebc46f9156657128dc52c979202545be8865656
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1200
Message-Id: <20250918135908.14364-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
058.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 2 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1200/2

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
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--whVrdJa4ZZ8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1200=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">GHA: collect more artifacts for mingw builds<=
br><br>Collect also binaries for openvpnserv, tapctl and openvpnmsica.<br><=
br>Change-Id: Iaebc46f9156657128dc52c979202545be8865656<br>Signed-off-by: L=
ev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1200<b=
r>Message-Id: &lt;20250918135908.14364-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33058.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/wo=
rkflows/build.yaml<br>1 file changed, 2 insertions(+), 2 deletions(-)<br><b=
r></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/00/1200/2=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;"><span>diff --git a/.github/workflows/build.yaml b/.github/workflows/buil=
d.yaml</span><br><span>index f7883c7..a306670 100644</span><br><span>--- a/=
.github/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.=
yaml</span><br><span>@@ -97,8 +97,8 @@</span><br><span>         with:</span=
><br><span>           name: openvpn-mingw-${{ matrix.arch }}</span><br><spa=
n>           path: |</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug=
/*.exe</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ${{=
 github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/*.dll</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            ${{ github.work=
space }}/out/build/mingw/${{ matrix.arch }}/**/Debug/*.exe</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            ${{ github.workspace }}/=
out/build/mingw/${{ matrix.arch }}/**/Debug/*.dll</span><br><span>         =
    !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/Debug/test_=
*.exe</span><br><span> </span><br><span>       - uses: actions/upload-artif=
act@...2868... # v4.6.2</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1200?usp=3Demail">change 1=
200</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1200?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaebc46f9156657128dc52c97920=
2545be8865656 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1200 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--whVrdJa4ZZ8=--

