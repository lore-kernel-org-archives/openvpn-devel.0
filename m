From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 22:50:03 +0000
References: <gerrit.1774997396000.Ic9c993cb8dcfedfd6f99f416c286e0968eb45255@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <cfca9e19eac820327697166e48a0d4bc35bae106-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2tPlCO4IWX0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Add OpenSSL 4.0
 build
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2tPlCO4IWX0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1601?usp=3Demail )


Change subject: GHA: Add OpenSSL 4.0 build
......................................................................

GHA: Add OpenSSL 4.0 build

Change-Id: Ic9c993cb8dcfedfd6f99f416c286e0968eb45255
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M .github/workflows/build.yaml
1 file changed, 82 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1601/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 186662d..0c0fb6a 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -390,6 +390,88 @@
       - name: make check
         run: make -j3 check VERBOSE=3D1

+  openssl:
+    strategy:
+      fail-fast: false
+      matrix:
+        os: [ubuntu-24.04]
+        ssllib: [openssl]
+        build: [ normal, asan ]
+        configureflags: ["--with-openssl-engine=3Dno"]
+        include:
+          - build: asan
+            cflags: "-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fn=
o-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame=
-pointer -g -O1"
+            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall
+            cc: clang
+          - build: normal
+            cflags: "-O2 -g"
+            ldflags: ""
+            cc: gcc
+
+    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.s=
sllib}} - 4.0"
+    runs-on: ${{matrix.os}}
+    env:
+      CFLAGS: ${{ matrix.cflags }}
+      LDFLAGS: ${{ matrix.ldflags }}
+      CC: ${{matrix.cc}}
+      UBSAN_OPTIONS: print_stacktrace=3D1
+      # versioning=3Dsemver-coerced
+      OPENSSL_REPO: openssl/openssl
+      OPENSSL_VERSION: openssl-4.0.0-beta1
+      OPENSSL_INSTALL: /opt/openssl
+
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore OpenSSL 4.0 from cache
+        uses: actions/cache@...3010...
+        id: openssl-cache
+        with:
+          path: ${{ env.OPENSSL_INSTALL }}
+          key: ${{ matrix.os }}-openssl-${{matrix.build }}-${{ env.OPENSSL=
_VERSION }}
+      - name: "openssl: checkout"
+        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
+        uses: actions/checkout@...2998... # v6.0.2
+        with:
+          path: openssl
+          repository: ${{ env.OPENSSL_REPO }}
+          ref: ${{ env.OPENSSL_VERSION }}
+      - name: "openssl: configure"
+        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
+        run: ./Configure  --prefix=3D${{ env.OPENSSL_INSTALL }} --libdir=
=3D${{ env.OPENSSL_INSTALL }}/lib --openssldir=3D${{ env.OPENSSL_INSTALL }}=
 -g
+        working-directory: openssl
+      - name: "openssl: make all"
+        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
+        run: make -j3
+        working-directory: openssl
+      - name: "openssl: make install"
+        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
+        run: sudo make install
+        working-directory: openssl
+      - name: "ldconfig"
+        run: sudo ldconfig
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2998... # v6.0.2
+      - name: autoconf
+        run: autoreconf -fvi
+      - name: configure
+        run: |
+          OPENSSL_CFLAGS=3D"-I${{ env.OPENSSL_INSTALL }}/include" \
+          OPENSSL_LIBS=3D"-L${{ env.OPENSSL_INSTALL }}/lib -lssl -lcrypto"=
 \
+          LDFLAGS=3D"-Wl,-rpath=3D${{ env.OPENSSL_INSTALL }}/lib" \
+          ./configure --with-crypto-library=3Dopenssl --enable-werror ${{m=
atrix.configureflags}}
+      - name: make all
+        run: make -j3
+      - name: Ensure the build uses Openssl
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: Ope=
nSSL 4.0"
+      - name: configure checks
+        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
+      - name: make check
+        run: make -j3 check VERBOSE=3D1
+
+
   mbedtls4:
     strategy:
       fail-fast: false

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1601?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9c993cb8dcfedfd6f99f416c286e0968eb45255
Gerrit-Change-Number: 1601
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2tPlCO4IWX0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1601?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">GHA: Add OpenSSL 4.0 build<br><br>Change-Id: Ic9c993cb8dcfedfd6f99f416c=
286e0968eb45255<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>-=
--<br>M .github/workflows/build.yaml<br>1 file changed, 82 insertions(+), 0=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/01/1601/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workflows=
/build.yaml b/.github/workflows/build.yaml</span><br><span>index 186662d..0=
c0fb6a 100644</span><br><span>--- a/.github/workflows/build.yaml</span><br>=
<span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -390,6 +390,88 =
@@</span><br><span>       - name: make check</span><br><span>         run: =
make -j3 check VERBOSE=3D1</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+  openssl:</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    strategy:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      fail-fast: false</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      matrix:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        os: [ubuntu-24.04]</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        ssllib: [openssl]</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        build: [ normal, asan ]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        configureflags: [&quot;--with-ope=
nssl-engine=3Dno&quot;]</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        include:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+          - build: asan</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            cflags: &quot;-fsanitize=3Daddress -fno-sanitize-recover=
=3Dall  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno=
-omit-frame-pointer -g -O1&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            ldflags: -fsanitize=3Daddress -fno-sanitize-recove=
r=3Dall</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
cc: clang</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
- build: normal</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        cflags: &quot;-O2 -g&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            ldflags: &quot;&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            cc: gcc</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    name: &quot;${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}}=
 - ${{matrix.ssllib}} - 4.0&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    runs-on: ${{matrix.os}}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    env:</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      CFLAGS: ${{ matrix.cflags }}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      LDFLAGS: ${{ matrix.ldflags }}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      CC: ${{matrix.cc}}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+      UBSAN_OPTIONS: print_=
stacktrace=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
 # versioning=3Dsemver-coerced</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      OPENSSL_REPO: openssl/openssl</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      OPENSSL_VERSION: openssl-4.0.0-beta1</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+      OPENSSL_INSTALL: /o=
pt/openssl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    steps:</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+      - name: Install dependencies</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: sudo apt =
update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev l=
inux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automak=
e autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - name: Restore OpenSSL 4.0 from ca=
che</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: ac=
tions/cache@...3010...</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        id: openssl-cache</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        with:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+          path: ${{ env.OPENSSL_INSTALL }}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+          key: ${{ matrix.os }}-openssl-${{matrix=
.build }}-${{ env.OPENSSL_VERSION }}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      - name: &quot;openssl: checkout&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if: steps.openssl-cache.ou=
tputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        uses: actions/checkout@...2998... # v6.0.2</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        with:</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+          path: openssl</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+          repository: ${{ env.=
OPENSSL_REPO }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      ref: ${{ env.OPENSSL_VERSION }}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      - name: &quot;openssl: configure&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if: steps.openssl-cache.=
outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        run: ./Configure  --prefix=3D${{ env.OPENSSL_INST=
ALL }} --libdir=3D${{ env.OPENSSL_INSTALL }}/lib --openssldir=3D${{ env.OPE=
NSSL_INSTALL }} -g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       working-directory: openssl</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+      - name: &quot;openssl: make all&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if: steps.openssl-cache.outpu=
ts.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        run: make -j3</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        working-directory: openssl</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+      - name: &quot;openssl: make install&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if: steps=
.openssl-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        run: sudo make install</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        working-directory: ope=
nssl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: &=
quot;ldconfig&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        run: sudo ldconfig</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        uses: actions/checkout@...2998... # v6.0.2</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: autoconf</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: autoreconf=
 -fvi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: =
configure</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ru=
n: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          OPENS=
SL_CFLAGS=3D&quot;-I${{ env.OPENSSL_INSTALL }}/include&quot; \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+          OPENSSL_LIBS=3D&quot;-=
L${{ env.OPENSSL_INSTALL }}/lib -lssl -lcrypto&quot; \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+          LDFLAGS=3D&quot;-Wl,-rpath=3D$=
{{ env.OPENSSL_INSTALL }}/lib&quot; \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+          ./configure --with-crypto-library=3Dopenssl --e=
nable-werror ${{matrix.configureflags}}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      - name: make all</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        run: make -j3</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+      - name: Ensure the build uses Openssl</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        run: |</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+          ./src/openvpn/openvpn=
 --version</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
 ./src/openvpn/openvpn --version | grep -q &quot;library versions: OpenSSL =
4.0&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - na=
me: configure checks</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_ser=
ver_null.rc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - =
name: make check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     run: make -j3 check VERBOSE=3D1</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>   mbedtls4:</span><br><span>     strategy:</span><br><span>=
       fail-fast: false</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1601?usp=3Demail">change 1=
601</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1601?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9c993cb8dcfedfd6f99f416c28=
6e0968eb45255 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1601 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--2tPlCO4IWX0=--

