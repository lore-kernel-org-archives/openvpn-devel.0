From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 1 May 2024 08:30:08 +0000
References: <gerrit.1714552206000.Ia70f230b2e9a78939d1875395205c8f48c4944b7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <8d04702e1c8c0cbf6bfd880ae38373b692a72915-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rxkEZsjf6Uc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rxkEZsjf6Uc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/582?usp=3Demail

to review the following change.


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
---
M .github/workflows/build.yaml
1 file changed, 13 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/582/1

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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--rxkEZsjf6Uc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/582?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Replace macos11 with macos14 in github runners<br><br>Github&=
#39;s documentation states:  macos-11 label has been deprecated and<br>will=
 no longer be available after 6/28/2024. Add macos14 which is nowadays<br>s=
upported instead.<br><br>The github macos-14 runner is using the M1 platfor=
m with ARM, so this<br>requires a bit more adjustment of paths.<br><br>Chan=
ge-Id: Ia70f230b2e9a78939d1875395205c8f48c4944b7<br>Signed-off-by: Arne Sch=
wabe &lt;arne@...1227...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 =
file changed, 13 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"f=
ont-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ger=
rit.openvpn.net:29418/openvpn refs/changes/82/582/1</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.g=
ithub/workflows/build.yaml b/.github/workflows/build.yaml</span><br><span>i=
ndex f771f5a..d7c3ecd 100644</span><br><span>--- a/.github/workflows/build.=
yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ =
-202,8 +202,16 @@</span><br><span>       matrix:</span><br><span>         s=
sllib: [ openssl11, openssl3, libressl]</span><br><span>         build: [ n=
ormal, asan ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
os: [macos-11, macos-12, macos-13]</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        os: [macos-12, macos-13, macos-14]</span><br><span> =
        include:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
        # macos14 and newer runners use ARM CPUs and homebrew uses /opt/hom=
ebrew/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           # =
on ARM instead of /usr/local/</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+          - os: macos-12</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            homebrew: /usr/local/opt</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          - os: macos-13</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            homebrew: /usr/local/opt=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          - os: mac=
os-14</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ho=
mebrew: /opt/homebrew/opt</span><br><span>           - build: asan</span><b=
r><span>             cflags: &quot;-fsanitize=3Daddress,undefined -fno-sani=
tize-recover=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-afte=
r-scope -fno-omit-frame-pointer -g -O1&quot;</span><br><span>             l=
dflags: -fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall</span><b=
r><span>@@ -228,8 +236,10 @@</span><br><span>     env:</span><br><span>    =
   CFLAGS: ${{ matrix.cflags }}</span><br><span>       LDFLAGS: ${{ matrix.=
ldflags }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      OPENS=
SL_CFLAGS: &quot;-I/usr/local/opt/${{matrix.libdir}}/include&quot;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-      OPENSSL_LIBS: &quot;-L/u=
sr/local/opt/${{matrix.libdir}}/lib -lcrypto -lssl&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      OPENSSL_CFLAGS: &quot;-I${{matri=
x.homebrew}}/${{matrix.libdir}}/include&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      OPENSSL_LIBS: &quot;-L${{matrix.homebrew}}/=
${{matrix.libdir}}/lib -lcrypto -lssl&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      LZO_CFLAGS: &quot;-I${{matrix.homebrew}}/lzo/=
include&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
LZO_LIBS: &quot;-L${{matrix.homebrew}}/lzo/lib -llzo2&quot;</span><br><span=
>       UBSAN_OPTIONS: print_stacktrace=3D1</span><br><span>     steps:</sp=
an><br><span>       - name: Install dependencies</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
82?usp=3Demail">change 582</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/582?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia70f230b2e9a78939d187539520=
5c8f48c4944b7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 582 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--rxkEZsjf6Uc=--

