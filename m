From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 16 Oct 2024 12:18:23 +0000
In-Reply-To: <gerrit.1729079770000.Ie922ce67685228eb7043749a7f1a61a33be678d2@...2715...>
References: <gerrit.1729079770000.Ie922ce67685228eb7043749a7f1a61a33be678d2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <7648cd640c0f46a506da0604e61927ff04c394ed-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BiAWWt9KhY0="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: GHA: Simplify
 macOS builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, uddr <yura.uddr@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BiAWWt9KhY0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/782?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: GHA: Simplify macOS builds
......................................................................

GHA: Simplify macOS builds

Reduce redundant configuration.

Change-Id: Ie922ce67685228eb7043749a7f1a61a33be678d2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
(cherry picked from commit 33a700d61e5b1a724b00f17fa0ed75d694e2823a)
Message-Id: <20241016115914.28098-1-gert@...1296...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20241016115914.28098-1=
-gert@...1296...
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
1 file changed, 13 insertions(+), 26 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/782/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index e4959ba..d930197 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -192,18 +192,10 @@
     strategy:
       fail-fast: false
       matrix:
-        ssllib: [ openssl11, openssl3, libressl]
-        build: [ normal, asan ]
+        ssllib: [openssl@...2560..., openssl@...1554..., libressl]
+        build: [normal, asan]
         os: [macos-13, macos-14, macos-15]
         include:
-           # macos14 and newer runners use ARM CPUs and homebrew uses /opt=
/homebrew/
-           # on ARM instead of /usr/local/
-          - os: macos-13
-            homebrew: /usr/local/opt
-          - os: macos-14
-            homebrew: /opt/homebrew/opt
-          - os: macos-15
-            homebrew: /opt/homebrew/opt
           - build: asan
             cflags: "-fsanitize=3Daddress -fno-optimize-sibling-calls -fsa=
nitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
             ldflags: -fsanitize=3Daddress
@@ -213,35 +205,30 @@
             cflags: "-O2 -g"
             ldflags: ""
             configureflags: ""
-          - ssllib: openssl11
-            libdir: openssl@...2560...
-            configuressllib: ""
-          - ssllib: openssl3
-            libdir: openssl@...1554...
-            configuressllib: ""
-          - ssllib: libressl
-            libdir: libressl
-            configuressllib: "--with-openssl-engine=3Dno"

     runs-on: ${{matrix.os}}
-    name: "${{matrix.os}} - ${{matrix.libdir}} - ${{matrix.build}}"
+    name: "${{matrix.os}} - ${{matrix.ssllib}} - ${{matrix.build}}"
     env:
       CFLAGS: ${{ matrix.cflags }}
       LDFLAGS: ${{ matrix.ldflags }}
-      OPENSSL_CFLAGS: "-I${{matrix.homebrew}}/${{matrix.libdir}}/include"
-      OPENSSL_LIBS: "-L${{matrix.homebrew}}/${{matrix.libdir}}/lib -lcrypt=
o -lssl"
-      LZO_CFLAGS: "-I${{matrix.homebrew}}/lzo/include"
-      LZO_LIBS: "-L${{matrix.homebrew}}/lzo/lib -llzo2"
       UBSAN_OPTIONS: print_stacktrace=3D1
     steps:
       - name: Install dependencies
-        run: brew install openssl@...2560... openssl@...1554... lzo lz4 ma=
n2html cmocka libtool automake autoconf libressl
+        run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libto=
ol automake autoconf
       - name: Checkout OpenVPN
         uses: actions/checkout@...2691...
+      - name: Set environment
+        run: |
+          cat >>$GITHUB_ENV <<EOF;
+          OPENSSL_CFLAGS=3D-I$(brew --prefix ${{matrix.ssllib}})/include
+          OPENSSL_LIBS=3D-L$(brew --prefix ${{matrix.ssllib}})/lib -lcrypt=
o -lssl
+          LZO_CFLAGS=3D-I$(brew --prefix lzo)/include
+          LZO_LIBS=3D-L$(brew --prefix lzo)/lib -llzo2
+          EOF
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --enable-werror ${{matrix.configureflags}} ${{mat=
rix.configuressllib}}
+        run: ./configure --enable-werror ${{matrix.configureflags}}
       - name: make all
         run: make -j4
       - name: make check

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/782?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ie922ce67685228eb7043749a7f1a61a33be678d2
Gerrit-Change-Number: 782
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--BiAWWt9KhY0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/782?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">GHA: Simplify macOS builds<br><br>Reduce redundant c=
onfiguration.<br><br>Change-Id: Ie922ce67685228eb7043749a7f1a61a33be678d2<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Ar=
ne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Yuriy Darnobyt &lt;=
yura.uddr@...277...&gt;<br>Signed-off-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>(cherry picked fro=
m commit 33a700d61e5b1a724b00f17fa0ed75d694e2823a)<br>Message-Id: &lt;20241=
016115914.28098-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/=
search?l=3Dmid&amp;q=3D20241016115914.28098-1-gert@...1296...<br>Signed-off=
-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/bui=
ld.yaml<br>1 file changed, 13 insertions(+), 26 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/782/2</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</sp=
an><br><span>index e4959ba..d930197 100644</span><br><span>--- a/.github/wo=
rkflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span=
><br><span>@@ -192,18 +192,10 @@</span><br><span>     strategy:</span><br><=
span>       fail-fast: false</span><br><span>       matrix:</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        ssllib: [ openssl11, openssl3=
, libressl]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bu=
ild: [ normal, asan ]</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        ssllib: [openssl@...2560..., openssl@...1554..., libressl]</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        build: [normal, as=
an]</span><br><span>         os: [macos-13, macos-14, macos-15]</span><br><=
span>         include:</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-           # macos14 and newer runners use ARM CPUs and homebrew uses /opt=
/homebrew/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
# on ARM instead of /usr/local/</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-          - os: macos-13</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            homebrew: /usr/local/opt</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-          - os: macos-14</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            homebrew: /opt/homebrew/opt</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-          - os: macos-15<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            homebrew: =
/opt/homebrew/opt</span><br><span>           - build: asan</span><br><span>=
             cflags: &quot;-fsanitize=3Daddress -fno-optimize-sibling-calls=
 -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</s=
pan><br><span>             ldflags: -fsanitize=3Daddress</span><br><span>@@=
 -213,35 +205,30 @@</span><br><span>             cflags: &quot;-O2 -g&quot;=
</span><br><span>             ldflags: &quot;&quot;</span><br><span>       =
      configureflags: &quot;&quot;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-          - ssllib: openssl11</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            libdir: openssl@...2560...</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            configuressllib: &quot;&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          - sslli=
b: openssl3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  libdir: openssl@...1554...</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            configuressllib: &quot;&quot;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-          - ssllib: libressl</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            libdir: libressl</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            configuressllib: &quot=
;--with-openssl-engine=3Dno&quot;</span><br><span> </span><br><span>     ru=
ns-on: ${{matrix.os}}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    name: &quot;${{matrix.os}} - ${{matrix.libdir}} - ${{matrix.build}}&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    name: &quot;$=
{{matrix.os}} - ${{matrix.ssllib}} - ${{matrix.build}}&quot;</span><br><spa=
n>     env:</span><br><span>       CFLAGS: ${{ matrix.cflags }}</span><br><=
span>       LDFLAGS: ${{ matrix.ldflags }}</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      OPENSSL_CFLAGS: &quot;-I${{matrix.homebrew}}/${{=
matrix.libdir}}/include&quot;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-      OPENSSL_LIBS: &quot;-L${{matrix.homebrew}}/${{matrix.libdir}}=
/lib -lcrypto -lssl&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-      LZO_CFLAGS: &quot;-I${{matrix.homebrew}}/lzo/include&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-      LZO_LIBS: &quot;-L${{m=
atrix.homebrew}}/lzo/lib -llzo2&quot;</span><br><span>       UBSAN_OPTIONS:=
 print_stacktrace=3D1</span><br><span>     steps:</span><br><span>       - =
name: Install dependencies</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        run: brew install openssl@...2560... openssl@...1554... lzo lz=
4 man2html cmocka libtool automake autoconf libressl</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        run: brew install ${{matrix.sslli=
b}} lzo lz4 man2html cmocka libtool automake autoconf</span><br><span>     =
  - name: Checkout OpenVPN</span><br><span>         uses: actions/checkout@=
...2691...</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - n=
ame: Set environment</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        run: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+          OPENSSL_CFLAGS=3D-I$(brew --prefix ${{matr=
ix.ssllib}})/include</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+          OPENSSL_LIBS=3D-L$(brew --prefix ${{matrix.ssllib}})/lib -lcrypt=
o -lssl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          LZ=
O_CFLAGS=3D-I$(brew --prefix lzo)/include</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+          LZO_LIBS=3D-L$(brew --prefix lzo)/lib -llzo=
2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          EOF</spa=
n><br><span>       - name: autoconf</span><br><span>         run: autorecon=
f -fvi</span><br><span>       - name: configure</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        run: ./configure --enable-werror ${{matri=
x.configureflags}} ${{matrix.configuressllib}}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        run: ./configure --enable-werror ${{matr=
ix.configureflags}}</span><br><span>       - name: make all</span><br><span=
>         run: make -j4</span><br><span>       - name: make check</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/782?usp=3Demail">change 782</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/7=
82?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie922ce67685228eb7043749a7f1=
a61a33be678d2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 782 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--BiAWWt9KhY0=--

