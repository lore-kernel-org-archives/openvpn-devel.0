From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 13:56:32 +0000
References: <gerrit.1769435786000.If61a91b4580864fd22162c94467ba3dda2045b7b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <25f5a29febde10e94f6d900f68635bbdd0d2f6c4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1Gsn8p3ZGBo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Run openvpnserv
 UT for MinGW builds
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

--1Gsn8p3ZGBo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1487?usp=3Demail

to review the following change.


Change subject: GHA: Run openvpnserv UT for MinGW builds
......................................................................

GHA: Run openvpnserv UT for MinGW builds

Should have been added in commit
b10ee38ccde5f155d02fcd3e8f1b1ab454826ab0.

Note that test_openvpnserv.exe lives in a
separate directory, so we need to make the
code a bit more flexible.

Change-Id: If61a91b4580864fd22162c94467ba3dda2045b7b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 6 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1487/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index ef9b3f5..5f5d624 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -100,13 +100,13 @@
           path: |
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
${{ matrix.build }}/*.exe
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
${{ matrix.build }}/*.dll
-            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${=
{ matrix.build }}/test_*.exe
+            !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**=
/${{ matrix.build }}/test_*.exe

       - uses: actions/upload-artifact@...2978... # v6.0.0
         with:
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: |
-            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{=
 matrix.build }}/test_*.exe
+            ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/=
${{ matrix.build }}/test_*.exe
             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/${{=
 matrix.build }}/*.dll

   mingw-unittest:
@@ -115,7 +115,7 @@
       fail-fast: false
       matrix:
         arch: [x86, x64]
-        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_=
parse, ncp, packet_id, pkt, provider, ssl, tls_crypt, user_pass]
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, options_=
parse, ncp, openvpnserv, packet_id, pkt, provider, ssl, tls_crypt, user_pas=
s]
         build: [Release, Debug]

     runs-on: windows-2025
@@ -129,7 +129,9 @@
           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.build }}-tests
           path: unittests
       - name: Run ${{ matrix.test }} unit test
-        run: ./unittests/test_${{ matrix.test }}.exe
+        run: |
+          $test_file=3D(Get-ChildItem -Path unittests -Filter test_${{ mat=
rix.test }}.exe -Recurse).fullname
+          & $test_file
         env:
           srcdir: "${{ github.workspace }}/tests/unit_tests/openvpn"


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1487?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If61a91b4580864fd22162c94467ba3dda2045b7b
Gerrit-Change-Number: 1487
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--1Gsn8p3ZGBo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1487?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">GHA: Run openvpnserv UT for MinGW builds<br=
><br>Should have been added in commit<br>b10ee38ccde5f155d02fcd3e8f1b1ab454=
826ab0.<br><br>Note that test_openvpnserv.exe lives in a<br>separate direct=
ory, so we need to make the<br>code a bit more flexible.<br><br>Change-Id: =
If61a91b4580864fd22162c94467ba3dda2045b7b<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 f=
ile changed, 6 insertions(+), 4 deletions(-)<br><br></pre><pre class=3D"blo=
cks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git=
 pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/87/1487/1</pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span=
>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</=
span><br><span>index ef9b3f5..5f5d624 100644</span><br><span>--- a/.github/=
workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</sp=
an><br><span>@@ -100,13 +100,13 @@</span><br><span>           path: |</span=
><br><span>             ${{ github.workspace }}/out/build/mingw/${{ matrix.=
arch }}/**/${{ matrix.build }}/*.exe</span><br><span>             ${{ githu=
b.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/*.=
dll</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            !${{ g=
ithub.workspace }}/out/build/mingw/${{ matrix.arch }}/${{ matrix.build }}/t=
est_*.exe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  !${{ github.workspace }}/out/build/mingw/${{ matrix.arch }}/**/${{ matrix=
.build }}/test_*.exe</span><br><span> </span><br><span>       - uses: actio=
ns/upload-artifact@...2978... # v6.0.0</span><br><span>         with:</span=
><br><span>           name: openvpn-mingw-${{ matrix.arch }}-${{ matrix.bui=
ld }}-tests</span><br><span>           path: |</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            ${{ github.workspace }}/out/build/ming=
w/${{ matrix.arch }}/${{ matrix.build }}/test_*.exe</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            ${{ github.workspace }}/out/b=
uild/mingw/${{ matrix.arch }}/**/${{ matrix.build }}/test_*.exe</span><br><=
span>             ${{ github.workspace }}/out/build/mingw/${{ matrix.arch }=
}/${{ matrix.build }}/*.dll</span><br><span> </span><br><span>   mingw-unit=
test:</span><br><span>@@ -115,7 +115,7 @@</span><br><span>       fail-fast:=
 false</span><br><span>       matrix:</span><br><span>         arch: [x86, =
x64]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        test: [ar=
gv, auth_token, buffer, cryptoapi, crypto, misc, options_parse, ncp, packet=
_id, pkt, provider, ssl, tls_crypt, user_pass]</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        test: [argv, auth_token, buffer, cryptoa=
pi, crypto, misc, options_parse, ncp, openvpnserv, packet_id, pkt, provider=
, ssl, tls_crypt, user_pass]</span><br><span>         build: [Release, Debu=
g]</span><br><span> </span><br><span>     runs-on: windows-2025</span><br><=
span>@@ -129,7 +129,9 @@</span><br><span>           name: openvpn-mingw-${{=
 matrix.arch }}-${{ matrix.build }}-tests</span><br><span>           path: =
unittests</span><br><span>       - name: Run ${{ matrix.test }} unit test</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: ./unittest=
s/test_${{ matrix.test }}.exe</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        run: |</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+          $test_file=3D(Get-ChildItem -Path unittests -Filter test_${{=
 matrix.test }}.exe -Recurse).fullname</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+          &amp; $test_file</span><br><span>         env:=
</span><br><span>           srcdir: &quot;${{ github.workspace }}/tests/uni=
t_tests/openvpn&quot;</span><br><span> </span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1487?usp=
=3Demail">change 1487</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1487?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If61a91b4580864fd22162c94467=
ba3dda2045b7b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1487 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--1Gsn8p3ZGBo=--

