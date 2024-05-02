From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 2 May 2024 12:57:52 +0000
In-Reply-To: <gerrit.1714552206000.Ia70f230b2e9a78939d1875395205c8f48c4944b7@...2715...>
References: <gerrit.1714552206000.Ia70f230b2e9a78939d1875395205c8f48c4944b7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <77462aba7e0fab89e6a10564141ce63445a758c0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lARhG8/hnuY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Replace macos11 with
 macos14 in github runners
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

--lARhG8/hnuY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/582?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Replace macos11 with macos14 in github runners
......................................................................

Replace macos11 with macos14 in github runners

Github's documentation states:  macos-11 label has been deprecated and
will no longer be available after 6/28/2024. Add macos14 which is nowadays
supported instead.

The github macos-14 runner is using the M1 platform with ARM, so this
requires a bit more adjustment of paths.

Change-Id: Ia70f230b2e9a78939d1875395205c8f48c4944b7
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240502122231.672-1-gert@...1296...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20240502122231.672-1-g=
ert@...1296...
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 13 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/582/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index f771f5a..d7c3ecd 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -202,8 +202,16 @@
       matrix:
         ssllib: [ openssl11, openssl3, libressl]
         build: [ normal, asan ]
-        os: [macos-11, macos-12, macos-13]
+        os: [macos-12, macos-13, macos-14]
         include:
+           # macos14 and newer runners use ARM CPUs and homebrew uses /opt=
/homebrew/
+           # on ARM instead of /usr/local/
+          - os: macos-12
+            homebrew: /usr/local/opt
+          - os: macos-13
+            homebrew: /usr/local/opt
+          - os: macos-14
+            homebrew: /opt/homebrew/opt
           - build: asan
             cflags: "-fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1"
             ldflags: -fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall
@@ -228,8 +236,10 @@
     env:
       CFLAGS: ${{ matrix.cflags }}
       LDFLAGS: ${{ matrix.ldflags }}
-      OPENSSL_CFLAGS: "-I/usr/local/opt/${{matrix.libdir}}/include"
-      OPENSSL_LIBS: "-L/usr/local/opt/${{matrix.libdir}}/lib -lcrypto -lss=
l"
+      OPENSSL_CFLAGS: "-I${{matrix.homebrew}}/${{matrix.libdir}}/include"
+      OPENSSL_LIBS: "-L${{matrix.homebrew}}/${{matrix.libdir}}/lib -lcrypt=
o -lssl"
+      LZO_CFLAGS: "-I${{matrix.homebrew}}/lzo/include"
+      LZO_LIBS: "-L${{matrix.homebrew}}/lzo/lib -llzo2"
       UBSAN_OPTIONS: print_stacktrace=3D1
     steps:
       - name: Install dependencies

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/582?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia70f230b2e9a78939d1875395205c8f48c4944b7
Gerrit-Change-Number: 582
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--lARhG8/hnuY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
582?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Replace macos11 with macos14 in github runner=
s<br><br>Github&#39;s documentation states:  macos-11 label has been deprec=
ated and<br>will no longer be available after 6/28/2024. Add macos14 which =
is nowadays<br>supported instead.<br><br>The github macos-14 runner is usin=
g the M1 platform with ARM, so this<br>requires a bit more adjustment of pa=
ths.<br><br>Change-Id: Ia70f230b2e9a78939d1875395205c8f48c4944b7<br>Signed-=
off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240502122231.672-1-gert@...1386...=
296...&gt;<br>URL: https://www.mail-archive.com/search?l=3Dmid&amp;q=3D2024=
0502122231.672-1-gert@...1296...<br>Signed-off-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 13=
 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/82/582/2</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflows/=
build.yaml b/.github/workflows/build.yaml</span><br><span>index f771f5a..d7=
c3ecd 100644</span><br><span>--- a/.github/workflows/build.yaml</span><br><=
span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -202,8 +202,16 @=
@</span><br><span>       matrix:</span><br><span>         ssllib: [ openssl=
11, openssl3, libressl]</span><br><span>         build: [ normal, asan ]</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        os: [macos-11, m=
acos-12, macos-13]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       os: [macos-12, macos-13, macos-14]</span><br><span>         include:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           # macos1=
4 and newer runners use ARM CPUs and homebrew uses /opt/homebrew/</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+           # on ARM instead o=
f /usr/local/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
    - os: macos-12</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           homebrew: /usr/local/opt</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+          - os: macos-13</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            homebrew: /usr/local/opt</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          - os: macos-14</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            homebrew: /opt/homeb=
rew/opt</span><br><span>           - build: asan</span><br><span>          =
   cflags: &quot;-fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall=
  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-=
frame-pointer -g -O1&quot;</span><br><span>             ldflags: -fsanitize=
=3Daddress,undefined -fno-sanitize-recover=3Dall</span><br><span>@@ -228,8 =
+236,10 @@</span><br><span>     env:</span><br><span>       CFLAGS: ${{ mat=
rix.cflags }}</span><br><span>       LDFLAGS: ${{ matrix.ldflags }}</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-      OPENSSL_CFLAGS: &quot;-=
I/usr/local/opt/${{matrix.libdir}}/include&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      OPENSSL_LIBS: &quot;-L/usr/local/opt/${{ma=
trix.libdir}}/lib -lcrypto -lssl&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      OPENSSL_CFLAGS: &quot;-I${{matrix.homebrew}}/${{ma=
trix.libdir}}/include&quot;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      OPENSSL_LIBS: &quot;-L${{matrix.homebrew}}/${{matrix.libdir}}=
/lib -lcrypto -lssl&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      LZO_CFLAGS: &quot;-I${{matrix.homebrew}}/lzo/include&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      LZO_LIBS: &quot;-L=
${{matrix.homebrew}}/lzo/lib -llzo2&quot;</span><br><span>       UBSAN_OPTI=
ONS: print_stacktrace=3D1</span><br><span>     steps:</span><br><span>     =
  - name: Install dependencies</span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/582?usp=3Demail">ch=
ange 582</a>. To unsubscribe, or for help writing mail filters, visit <a hr=
ef=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/582?usp=3Demail"/><meta itemprop=3D"=
name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia70f230b2e9a78939d187539520=
5c8f48c4944b7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 582 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--lARhG8/hnuY=--

