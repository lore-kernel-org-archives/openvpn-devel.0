From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 15 Oct 2024 12:35:02 +0000
References: <gerrit.1728995699000.Ie922ce67685228eb7043749a7f1a61a33be678d2@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <1265f9221c4c2243d8f3671622f83af6500d35cc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c9Symlmoq50="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: GHA: Simplify macOS
 builds
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

--c9Symlmoq50=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/781?usp=3Demail

to review the following change.


Change subject: GHA: Simplify macOS builds
......................................................................

GHA: Simplify macOS builds

Reduce redundant configuration.

Change-Id: Ie922ce67685228eb7043749a7f1a61a33be678d2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
1 file changed, 13 insertions(+), 26 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/781/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index fdd133e..3958ef0 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -211,18 +211,10 @@
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
             cflags: "-fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1"
             ldflags: -fsanitize=3Daddress,undefined -fno-sanitize-recover=
=3Dall
@@ -232,35 +224,30 @@
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
         uses: actions/checkout@...2813... # v4
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
       - name: configure checks

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/781?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie922ce67685228eb7043749a7f1a61a33be678d2
Gerrit-Change-Number: 781
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--c9Symlmoq50=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/781?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">GHA: Simplify macOS builds<br><br>Reduce redundant configurat=
ion.<br><br>Change-Id: Ie922ce67685228eb7043749a7f1a61a33be678d2<br>Signed-=
off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M .github/work=
flows/build.yaml<br>1 file changed, 13 insertions(+), 26 deletions(-)<br><b=
r></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/81/781/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/.github/workflows/build.yaml b/.github/workflows/build=
.yaml</span><br><span>index fdd133e..3958ef0 100644</span><br><span>--- a/.=
github/workflows/build.yaml</span><br><span>+++ b/.github/workflows/build.y=
aml</span><br><span>@@ -211,18 +211,10 @@</span><br><span>     strategy:</s=
pan><br><span>       fail-fast: false</span><br><span>       matrix:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        ssllib: [ openssl11,=
 openssl3, libressl]</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       build: [ normal, asan ]</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        ssllib: [openssl@...2560..., openssl@...1554..., libress=
l]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        build: [n=
ormal, asan]</span><br><span>         os: [macos-13, macos-14, macos-15]</s=
pan><br><span>         include:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-           # macos14 and newer runners use ARM CPUs and homebrew =
uses /opt/homebrew/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
         # on ARM instead of /usr/local/</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-          - os: macos-13</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            homebrew: /usr/local/opt</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-          - os: macos-14</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            homebrew: /opt/homebrew=
/opt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          - os: m=
acos-15</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ho=
mebrew: /opt/homebrew/opt</span><br><span>           - build: asan</span><b=
r><span>             cflags: &quot;-fsanitize=3Daddress,undefined -fno-sani=
tize-recover=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-afte=
r-scope -fno-omit-frame-pointer -g -O1&quot;</span><br><span>             l=
dflags: -fsanitize=3Daddress,undefined -fno-sanitize-recover=3Dall</span><b=
r><span>@@ -232,35 +224,30 @@</span><br><span>             cflags: &quot;-O=
2 -g&quot;</span><br><span>             ldflags: &quot;&quot;</span><br><sp=
an>             configureflags: &quot;&quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-          - ssllib: openssl11</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            libdir: openssl@...2560...</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            configuresslli=
b: &quot;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
    - ssllib: openssl3</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            libdir: openssl@...1554...</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            configuressllib: &quot;&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-          - ssllib: libressl</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            libdir: libressl</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            configuress=
llib: &quot;--with-openssl-engine=3Dno&quot;</span><br><span> </span><br><s=
pan>     runs-on: ${{matrix.os}}</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    name: &quot;${{matrix.os}} - ${{matrix.libdir}} - ${{matrix.=
build}}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    na=
me: &quot;${{matrix.os}} - ${{matrix.ssllib}} - ${{matrix.build}}&quot;</sp=
an><br><span>     env:</span><br><span>       CFLAGS: ${{ matrix.cflags }}<=
/span><br><span>       LDFLAGS: ${{ matrix.ldflags }}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      OPENSSL_CFLAGS: &quot;-I${{matrix.hom=
ebrew}}/${{matrix.libdir}}/include&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-      OPENSSL_LIBS: &quot;-L${{matrix.homebrew}}/${{matr=
ix.libdir}}/lib -lcrypto -lssl&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      LZO_CFLAGS: &quot;-I${{matrix.homebrew}}/lzo/include&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      LZO_LIBS: &=
quot;-L${{matrix.homebrew}}/lzo/lib -llzo2&quot;</span><br><span>       UBS=
AN_OPTIONS: print_stacktrace=3D1</span><br><span>     steps:</span><br><spa=
n>       - name: Install dependencies</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        run: brew install openssl@...2560... openssl@...2826...=
4... lzo lz4 man2html cmocka libtool automake autoconf libressl</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        run: brew install ${{ma=
trix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf</span><br><=
span>       - name: Checkout OpenVPN</span><br><span>         uses: actions=
/checkout@...2813... # v4</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      - name: Set environment</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        run: |</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+          cat &gt;&gt;$GITHUB_ENV &lt;&lt;EOF;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+          OPENSSL_CFLAGS=3D-I$(brew -=
-prefix ${{matrix.ssllib}})/include</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+          OPENSSL_LIBS=3D-L$(brew --prefix ${{matrix.ssllib=
}})/lib -lcrypto -lssl</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+          LZO_CFLAGS=3D-I$(brew --prefix lzo)/include</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+          LZO_LIBS=3D-L$(brew --prefix=
 lzo)/lib -llzo2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
       EOF</span><br><span>       - name: autoconf</span><br><span>        =
 run: autoreconf -fvi</span><br><span>       - name: configure</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        run: ./configure --enable-=
werror ${{matrix.configureflags}} ${{matrix.configuressllib}}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        run: ./configure --enable=
-werror ${{matrix.configureflags}}</span><br><span>       - name: make all<=
/span><br><span>         run: make -j4</span><br><span>       - name: confi=
gure checks</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/781?usp=3Demail">change 781</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/781?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie922ce67685228eb7043749a7f1=
a61a33be678d2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 781 </div>
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


--c9Symlmoq50=--

