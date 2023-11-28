From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 28 Nov 2023 16:05:16 +0000
In-Reply-To: <gerrit.1700585996000.I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24@...2715...>
References: <gerrit.1700585996000.I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ac0247e865323743312ae8ac6ab9750d2bc52c1b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="D025M+TgLEI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Cache mbed TLS
 dependency and build latest 2.x mbed TLS as well
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

--D025M+TgLEI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail

to look at the new patch set (#2).


Change subject: Cache mbed TLS dependency and build latest 2.x mbed TLS as =
well
......................................................................

Cache mbed TLS dependency and build latest 2.x mbed TLS as well

Change-Id: I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
1 file changed, 23 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/55/455/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index cd72f3d..5628d8e 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -366,8 +366,8 @@
       fail-fast: false
       matrix:
         os: [ubuntu-22.04]
-        ssllib: [mbedtls3]
         build: [ normal, asan ]
+        mbedtlsver: [ v3.5.1, v2.28.6 ]
         include:
           - build: asan
             cflags: "-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fn=
o-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame=
-pointer -g -O1"
@@ -378,29 +378,45 @@
             ldflags: ""
             cc: gcc

-    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.s=
sllib}}"
+    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - mbed TLS ${=
{matrix.mbedtlsver}}"
     runs-on: ${{matrix.os}}
     env:
       CFLAGS: ${{ matrix.cflags }}
       LDFLAGS: ${{ matrix.ldflags }}
       CC: ${{matrix.cc}}
       UBSAN_OPTIONS: print_stacktrace=3D1
+      MBEDTLS_CFLAGS: -I/opt/mbedtls/include
+      MBEDTLS_LIBS: -L/opt/mbedtls/lib -lmbedtls -lmbedx509 -lmbedcrypto

     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
-      - name: "mbedtls: checkout"
+
+      - name: Cache mbed TLS
+        id: cache
+        uses: actions/cache@...2689...
+        with:
+          path: '/opt/mbedtls'
+          key: ${{ matrix.build }}-mbedtls-${{matrix.mbedtlsver}}-${{matri=
x.cmakebuild}}
+      - name: "Mbed TLS: checkout"
         uses: actions/checkout@...2689...
         with:
           path: mbedtls
           repository: Mbed-TLS/mbedtls
-          ref: v3.5.0
-      - name: "mbedtls: make no_test"
+          ref: ${{ matrix.mbedtlsver }}
+          if: steps.cache.outputs.cache-hit !=3D 'true'
+      - name: "Mbed TLS: make no_test"
         run: make -j3 no_test SHARED=3D1
         working-directory: mbedtls
-      - name: "mbedtls: make install"
-        run: sudo make install DESTDIR=3D/usr
+        if: steps.cache.outputs.cache-hit !=3D 'true'
+      - name: "Mbed TLS: make install"
+        run: sudo make install DESTDIR=3D/opt/mbedtls
         working-directory: mbedtls
+        if: steps.cache.outputs.cache-hit !=3D 'true'
+      - name: add /opt/mbedtls/lib to ld.so.conf.d
+        run: echo /opt/mbedtls/lib | sudo tee /etc/ld.so.conf.d/mbedtls.co=
nf
+      - name: "ldconfig"
+        run: sudo ldconfig
       - name: Checkout OpenVPN
         uses: actions/checkout@...2689...
       - name: autoconf

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24
Gerrit-Change-Number: 455
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--D025M+TgLEI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Cache mbed TLS dependency and build latest 2.x mbed TLS as well<br><b=
r>Change-Id: I39fb3f05b6245af9ae5dd666bfc53ed07e5cfb24<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@...1227...&gt;<br>---<br>M .github/workflows/build.yaml=
<br>1 file changed, 23 insertions(+), 7 deletions(-)<br><br></pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/55/455/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</span><br=
><span>index cd72f3d..5628d8e 100644</span><br><span>--- a/.github/workflow=
s/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span><br><=
span>@@ -366,8 +366,8 @@</span><br><span>       fail-fast: false</span><br>=
<span>       matrix:</span><br><span>         os: [ubuntu-22.04]</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ssllib: [mbedtls3]</span=
><br><span>         build: [ normal, asan ]</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        mbedtlsver: [ v3.5.1, v2.28.6 ]</span><br><=
span>         include:</span><br><span>           - build: asan</span><br><=
span>             cflags: &quot;-fsanitize=3Daddress -fno-sanitize-recover=
=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1&quot;</span><br><span>@@ -378,29 +378,45 @@</spa=
n><br><span>             ldflags: &quot;&quot;</span><br><span>            =
 cc: gcc</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    name: &quot;${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${=
{matrix.ssllib}}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    name: &quot;${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - mbed=
 TLS ${{matrix.mbedtlsver}}&quot;</span><br><span>     runs-on: ${{matrix.o=
s}}</span><br><span>     env:</span><br><span>       CFLAGS: ${{ matrix.cfl=
ags }}</span><br><span>       LDFLAGS: ${{ matrix.ldflags }}</span><br><spa=
n>       CC: ${{matrix.cc}}</span><br><span>       UBSAN_OPTIONS: print_sta=
cktrace=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      MB=
EDTLS_CFLAGS: -I/opt/mbedtls/include</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      MBEDTLS_LIBS: -L/opt/mbedtls/lib -lmbedtls -lmbedx50=
9 -lmbedcrypto</span><br><span> </span><br><span>     steps:</span><br><spa=
n>       - name: Install dependencies</span><br><span>         run: sudo ap=
t update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev=
 linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja=
2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev lib=
nl-genl-3-dev</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - =
name: &quot;mbedtls: checkout&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   - name: Cache mbed TLS</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        id: cache</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        uses: actions/cache@...2689...</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        with:</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+          path: &#39;/opt/mbedtls&#39;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+          key: ${{ matrix.build }}-mbed=
tls-${{matrix.mbedtlsver}}-${{matrix.cmakebuild}}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      - name: &quot;Mbed TLS: checkout&quot;<=
/span><br><span>         uses: actions/checkout@...2689...</span><br><span>=
         with:</span><br><span>           path: mbedtls</span><br><span>   =
        repository: Mbed-TLS/mbedtls</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-          ref: v3.5.0</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - name: &quot;mbedtls: make no_test&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+          ref: ${{ matrix.mbedtl=
sver }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          if=
: steps.cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - name: &quot;Mbed TLS: make no_tes=
t&quot;</span><br><span>         run: make -j3 no_test SHARED=3D1</span><br=
><span>         working-directory: mbedtls</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      - name: &quot;mbedtls: make install&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        run: sudo make insta=
ll DESTDIR=3D/usr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if: steps.cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      - name: &quot;Mbed TLS: make =
install&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  run: sudo make install DESTDIR=3D/opt/mbedtls</span><br><span>         wo=
rking-directory: mbedtls</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if: steps.cache.outputs.cache-hit !=3D &#39;true&#39;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+      - name: add /opt/mbedt=
ls/lib to ld.so.conf.d</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        run: echo /opt/mbedtls/lib | sudo tee /etc/ld.so.conf.d/mbedtls.=
conf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: &=
quot;ldconfig&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        run: sudo ldconfig</span><br><span>       - name: Checkout OpenVPN<=
/span><br><span>         uses: actions/checkout@...2689...</span><br><span>=
       - name: autoconf</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail">change 45=
5</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"h=
ttp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/455?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I39fb3f05b6245af9ae5dd666bfc=
53ed07e5cfb24 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 455 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--D025M+TgLEI=--

