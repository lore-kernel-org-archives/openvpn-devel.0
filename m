From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 2 May 2024 12:57:54 +0000
In-Reply-To: <gerrit.1714552206000.Ia70f230b2e9a78939d1875395205c8f48c4944b7@...2715...>
References: <gerrit.1714552206000.Ia70f230b2e9a78939d1875395205c8f48c4944b7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <77462aba7e0fab89e6a10564141ce63445a758c0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="focu9Z1S5/4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--focu9Z1S5/4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/58=
2?usp=3Demail )

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
Gerrit-MessageType: merged

--focu9Z1S5/4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/582?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Replace macos11 with macos14 in github runners=
<br><br>Github&#39;s documentation states:  macos-11 label has been depreca=
ted and<br>will no longer be available after 6/28/2024. Add macos14 which i=
s nowadays<br>supported instead.<br><br>The github macos-14 runner is using=
 the M1 platform with ARM, so this<br>requires a bit more adjustment of pat=
hs.<br><br>Change-Id: Ia70f230b2e9a78939d1875395205c8f48c4944b7<br>Signed-o=
ff-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>Message-Id: &lt;20240502122231.672-1-gert@...1711...=
96...&gt;<br>URL: https://www.mail-archive.com/search?l=3Dmid&amp;q=3D20240=
502122231.672-1-gert@...1296...<br>Signed-off-by: Gert Doering &lt;gert@...493...=
1296...&gt;<br>---<br>M .github/workflows/build.yaml<br>1 file changed, 13 =
insertions(+), 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml=
</span><br><span>index f771f5a..d7c3ecd 100644</span><br><span>--- a/.githu=
b/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</=
span><br><span>@@ -202,8 +202,16 @@</span><br><span>       matrix:</span><b=
r><span>         ssllib: [ openssl11, openssl3, libressl]</span><br><span> =
        build: [ normal, asan ]</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        os: [macos-11, macos-12, macos-13]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        os: [macos-12, macos-13, macos-14=
]</span><br><span>         include:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+           # macos14 and newer runners use ARM CPUs and hom=
ebrew uses /opt/homebrew/</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+           # on ARM instead of /usr/local/</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+          - os: macos-12</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            homebrew: /usr/local/opt</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+          - os: macos-13=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            homebre=
w: /usr/local/opt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
        - os: macos-14</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            homebrew: /opt/homebrew/opt</span><br><span>           - bui=
ld: asan</span><br><span>             cflags: &quot;-fsanitize=3Daddress,un=
defined -fno-sanitize-recover=3Dall  -fno-optimize-sibling-calls -fsanitize=
-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</span><br><sp=
an>             ldflags: -fsanitize=3Daddress,undefined -fno-sanitize-recov=
er=3Dall</span><br><span>@@ -228,8 +236,10 @@</span><br><span>     env:</sp=
an><br><span>       CFLAGS: ${{ matrix.cflags }}</span><br><span>       LDF=
LAGS: ${{ matrix.ldflags }}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-      OPENSSL_CFLAGS: &quot;-I/usr/local/opt/${{matrix.libdir}}/inclu=
de&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      OPENSSL=
_LIBS: &quot;-L/usr/local/opt/${{matrix.libdir}}/lib -lcrypto -lssl&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+      OPENSSL_CFLAGS:=
 &quot;-I${{matrix.homebrew}}/${{matrix.libdir}}/include&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      OPENSSL_LIBS: &quot;-L${{m=
atrix.homebrew}}/${{matrix.libdir}}/lib -lcrypto -lssl&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      LZO_CFLAGS: &quot;-I${{matri=
x.homebrew}}/lzo/include&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      LZO_LIBS: &quot;-L${{matrix.homebrew}}/lzo/lib -llzo2&quot=
;</span><br><span>       UBSAN_OPTIONS: print_stacktrace=3D1</span><br><spa=
n>     steps:</span><br><span>       - name: Install dependencies</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/582?usp=3Demail">change 582</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
82?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--focu9Z1S5/4=--

