From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 13 Mar 2026 13:21:11 +0000
References: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <ab323a458c0cbd404561cd96a1abe1dd05acb947-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wGHxf50cMBo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: [GHA] Cache built
 crypto libraries
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wGHxf50cMBo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1577?usp=3Demail )


Change subject: [GHA] Cache built crypto libraries
......................................................................

[GHA] Cache built crypto libraries

Change-Id: Ie21fdb01b843a7af09fcd469b08c775eee7e3745
---
M .github/workflows/build.yaml
1 file changed, 45 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1577/1

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index dd8e472..1203d99 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -328,29 +328,41 @@
       LDFLAGS: ${{ matrix.ldflags }}
       CC: ${{matrix.cc}}
       UBSAN_OPTIONS: print_stacktrace=3D1
+      LIBRESSL_VERSION: v4.2.1

     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore libressl from cache
+        uses: actions/cache@...3010...
+        id: libressl-cache
+        with:
+          path: /opt
+          key: ${{ matrix.os }}-libressl-${{ env.LIBRESSL_VERSION }}
       - name: "libressl: checkout"
+        if: steps.libressl-cache.outputs.cache-hit !=3D 'true'
         uses: actions/checkout@...2998... # v6.0.2
         with:
           path: libressl
           # versioning=3Dsemver-coerced
           repository: libressl/portable
-          ref: v4.2.1
+          ref: ${{ env.LIBRESSL_VERSION }}
       - name: "libressl: autogen.sh"
+        if: steps.libressl-cache.outputs.cache-hit !=3D 'true'
         env:
           LIBRESSL_GIT_OPTIONS: "--no-single-branch"
         run: ./autogen.sh
         working-directory: libressl
       - name: "libressl: configure"
-        run: ./configure
+        if: steps.libressl-cache.outputs.cache-hit !=3D 'true'
+        run: ./configure --prefix=3D/opt
         working-directory: libressl
       - name: "libressl: make all"
+        if: steps.libressl-cache.outputs.cache-hit !=3D 'true'
         run: make -j3
         working-directory: libressl
       - name: "libressl: make install"
+        if: steps.libressl-cache.outputs.cache-hit !=3D 'true'
         run: sudo make install
         working-directory: libressl
       - name: "ldconfig"
@@ -360,7 +372,11 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=3Dopenssl ${{matrix.configu=
reflags}} --enable-werror
+        run: |
+          OPENSSL_CFLAGS=3D"-I/opt/include" \
+          OPENSSL_LIBS=3D"-L/opt/lib -lssl -lcrypto" \
+          LDFLAGS=3D"-Wl,-rpath=3D/opt/lib" \
+          ./configure --with-crypto-library=3Dopenssl --enable-werror ${{m=
atrix.configureflags}}
       - name: make all
         run: make -j3
       - name: Ensure the build uses LibreSSL
@@ -396,27 +412,39 @@
       LDFLAGS: ${{ matrix.ldflags }}
       CC: ${{matrix.cc}}
       UBSAN_OPTIONS: print_stacktrace=3D1
+      PKG_CONFIG_PATH: /opt/lib/pkgconfig
+      MBEDTLS_VERSION: 4.0.0

     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
+      - name: Restore mbed TLS from cache
+        uses: actions/cache@...3010...
+        id: mbedtls-cache
+        with:
+          path: /opt/
+          key: ${{ matrix.os }}-mbedtls-${{ env.MBEDTLS_VERSION }}
       - name: "mbedtls: checkout"
+        if: steps.mbedtls-cache.outputs.cache-hit !=3D 'true'
         uses: actions/checkout@...2998... # v6.0.2
         with:
           path: mbedtls
           submodules: recursive
           # versioning=3Dsemver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v4.0.0
+          ref: v${{ env.MBEDTLS_VERSION }}
       - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "mbedtls: cmake"
-        run: cmake -B build
+        if: steps.mbedtls-cache.outputs.cache-hit !=3D 'true'
+        run: cmake -B build -DCMAKE_INSTALL_PREFIX=3D/opt
         working-directory: mbedtls
       - name: "mbedtls: cmake --build"
+        if: steps.mbedtls-cache.outputs.cache-hit !=3D 'true'
         run: cmake --build build
         working-directory: mbedtls
       - name: "mbedtls: cmake --install"
-        run: sudo cmake --install build --prefix /usr
+        if: steps.mbedtls-cache.outputs.cache-hit !=3D 'true'
+        run: sudo cmake --install build
         working-directory: mbedtls
       - name: Checkout OpenVPN
         uses: actions/checkout@...2998... # v6.0.2
@@ -426,7 +454,7 @@
         run: ./configure --with-crypto-library=3Dmbedtls --enable-werror
       - name: make all
         run: make -j3
-      - name: Ensure the build uses mbed TLS 4.x
+      - name: Ensure the build uses mbed TLS ${{ env.MBEDTLS_VERSION }}
         run: |
           ./src/openvpn/openvpn --version
           ./src/openvpn/openvpn --version | grep -q "library versions: mbe=
d TLS 4."
@@ -463,19 +491,28 @@
       CXX: ${{matrix.cxx}}
       UBSAN_OPTIONS: print_stacktrace=3D1
       AWS_LC_INSTALL: /opt/aws-lc
+      AWS_LC_VERSION: v1.70.0

     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y gcc golang make liblzo=
2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev p=
ython3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf=
 pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore AWS-LC from cache
+        uses: actions/cache@...3010...
+        id: aws-lc-cache
+        with:
+          path: ${{ env.AWS_LC_INSTALL }}
+          key: ${{ matrix.os }}-aws-lc-${{ env.AWS_LC_VERSION }}
       - name: "AWS-LC: checkout"
+        if: steps.aws-lc-cache.outputs.cache-hit !=3D 'true'
         uses: actions/checkout@...2998... # v6.0.2
         with:
           path: aws-lc
           # versioning=3Dsemver-coerced
           repository: aws/aws-lc
-          ref: v1.70.0
+          ref: ${{ env.AWS_LC_VERSION }}
       - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "AWS-LC: build"
+        if: steps.aws-lc-cache.outputs.cache-hit !=3D 'true'
         run: |
           mkdir build
           cd build

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1577?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie21fdb01b843a7af09fcd469b08c775eee7e3745
Gerrit-Change-Number: 1577
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wGHxf50cMBo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1577?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">[GHA] Cache built crypto libraries<br><br>Change-Id: Ie21fdb01b843a7af0=
9fcd469b08c775eee7e3745<br>---<br>M .github/workflows/build.yaml<br>1 file =
changed, 45 insertions(+), 8 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1577/1</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml</spa=
n><br><span>index dd8e472..1203d99 100644</span><br><span>--- a/.github/wor=
kflows/build.yaml</span><br><span>+++ b/.github/workflows/build.yaml</span>=
<br><span>@@ -328,29 +328,41 @@</span><br><span>       LDFLAGS: ${{ matrix.=
ldflags }}</span><br><span>       CC: ${{matrix.cc}}</span><br><span>      =
 UBSAN_OPTIONS: print_stacktrace=3D1</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      LIBRESSL_VERSION: v4.2.1</span><br><span> </span><br=
><span>     steps:</span><br><span>       - name: Install dependencies</spa=
n><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y li=
blzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-d=
ev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libn=
l-genl-3-dev</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      -=
 name: Restore libressl from cache</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uses: actions/cache@...3010...</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        id: libressl-cache</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        with:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+          path: /opt</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+          key: ${{ matrix.os }}-libress=
l-${{ env.LIBRESSL_VERSION }}</span><br><span>       - name: &quot;libressl=
: checkout&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if: steps.libressl-cache.outputs.cache-hit !=3D &#39;true&#39;</span><=
br><span>         uses: actions/checkout@...2998... # v6.0.2</span><br><spa=
n>         with:</span><br><span>           path: libressl</span><br><span>=
           # versioning=3Dsemver-coerced</span><br><span>           reposit=
ory: libressl/portable</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-          ref: v4.2.1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+          ref: ${{ env.LIBRESSL_VERSION }}</span><br><span>       - name=
: &quot;libressl: autogen.sh&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if: steps.libressl-cache.outputs.cache-hit !=3D &#39=
;true&#39;</span><br><span>         env:</span><br><span>           LIBRESS=
L_GIT_OPTIONS: &quot;--no-single-branch&quot;</span><br><span>         run:=
 ./autogen.sh</span><br><span>         working-directory: libressl</span><b=
r><span>       - name: &quot;libressl: configure&quot;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        run: ./configure</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if: steps.libressl-cache.outp=
uts.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        run: ./configure --prefix=3D/opt</span><br><span>    =
     working-directory: libressl</span><br><span>       - name: &quot;libre=
ssl: make all&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if: steps.libressl-cache.outputs.cache-hit !=3D &#39;true&#39;</spa=
n><br><span>         run: make -j3</span><br><span>         working-directo=
ry: libressl</span><br><span>       - name: &quot;libressl: make install&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if: step=
s.libressl-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span>    =
     run: sudo make install</span><br><span>         working-directory: lib=
ressl</span><br><span>       - name: &quot;ldconfig&quot;</span><br><span>@=
@ -360,7 +372,11 @@</span><br><span>       - name: autoconf</span><br><span=
>         run: autoreconf -fvi</span><br><span>       - name: configure</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: ./configure =
--with-crypto-library=3Dopenssl ${{matrix.configureflags}} --enable-werror<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: |</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          OPENSSL_CFLAGS=
=3D&quot;-I/opt/include&quot; \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+          OPENSSL_LIBS=3D&quot;-L/opt/lib -lssl -lcrypto&quot; =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          LDFLAGS=
=3D&quot;-Wl,-rpath=3D/opt/lib&quot; \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+          ./configure --with-crypto-library=3Dopenssl --=
enable-werror ${{matrix.configureflags}}</span><br><span>       - name: mak=
e all</span><br><span>         run: make -j3</span><br><span>       - name:=
 Ensure the build uses LibreSSL</span><br><span>@@ -396,27 +412,39 @@</span=
><br><span>       LDFLAGS: ${{ matrix.ldflags }}</span><br><span>       CC:=
 ${{matrix.cc}}</span><br><span>       UBSAN_OPTIONS: print_stacktrace=3D1<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      PKG_CONFIG_PAT=
H: /opt/lib/pkgconfig</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      MBEDTLS_VERSION: 4.0.0</span><br><span> </span><br><span>     steps=
:</span><br><span>       - name: Install dependencies</span><br><span>     =
    run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0=
g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docuti=
ls python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config l=
ibcap-ng-dev libnl-genl-3-dev</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      - name: Restore mbed TLS from cache</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache@...3010...</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        id: mbedtls-ca=
che</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        with:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+          path: /opt/<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+          key: ${{ m=
atrix.os }}-mbedtls-${{ env.MBEDTLS_VERSION }}</span><br><span>       - nam=
e: &quot;mbedtls: checkout&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if: steps.mbedtls-cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;</span><br><span>         uses: actions/checkout@...2998... # v6.0.2=
</span><br><span>         with:</span><br><span>           path: mbedtls</s=
pan><br><span>           submodules: recursive</span><br><span>           #=
 versioning=3Dsemver-coerced</span><br><span>           repository: Mbed-TL=
S/mbedtls</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          re=
f: v4.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
ref: v${{ env.MBEDTLS_VERSION }}</span><br><span>       - uses: lukka/get-c=
make@...2999... # v4.2.3</span><br><span>       - name: &quot;mbedtls: cmak=
e&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: c=
make -B build</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if: steps.mbedtls-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        run: cmake -B build -DC=
MAKE_INSTALL_PREFIX=3D/opt</span><br><span>         working-directory: mbed=
tls</span><br><span>       - name: &quot;mbedtls: cmake --build&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if: steps.mbedtls=
-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span>         run: =
cmake --build build</span><br><span>         working-directory: mbedtls</sp=
an><br><span>       - name: &quot;mbedtls: cmake --install&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        run: sudo cmake --instal=
l build --prefix /usr</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if: steps.mbedtls-cache.outputs.cache-hit !=3D &#39;true&#39;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: sudo cmake=
 --install build</span><br><span>         working-directory: mbedtls</span>=
<br><span>       - name: Checkout OpenVPN</span><br><span>         uses: ac=
tions/checkout@...2998... # v6.0.2</span><br><span>@@ -426,7 +454,7 @@</spa=
n><br><span>         run: ./configure --with-crypto-library=3Dmbedtls --ena=
ble-werror</span><br><span>       - name: make all</span><br><span>        =
 run: make -j3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      -=
 name: Ensure the build uses mbed TLS 4.x</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+      - name: Ensure the build uses mbed TLS ${{ env.=
MBEDTLS_VERSION }}</span><br><span>         run: |</span><br><span>        =
   ./src/openvpn/openvpn --version</span><br><span>           ./src/openvpn=
/openvpn --version | grep -q &quot;library versions: mbed TLS 4.&quot;</spa=
n><br><span>@@ -463,19 +491,28 @@</span><br><span>       CXX: ${{matrix.cxx=
}}</span><br><span>       UBSAN_OPTIONS: print_stacktrace=3D1</span><br><sp=
an>       AWS_LC_INSTALL: /opt/aws-lc</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+      AWS_LC_VERSION: v1.70.0</span><br><span> </span><br=
><span>     steps:</span><br><span>       - name: Install dependencies</spa=
n><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y gc=
c golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html c=
lang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libto=
ol automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+      - name: Restore AWS-LC fro=
m cache</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses=
: actions/cache@...3010...</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        id: aws-lc-cache</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        with:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+          path: ${{ env.AWS_LC_INSTALL }}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+          key: ${{ matrix.os }}-aws-lc-${{ env.=
AWS_LC_VERSION }}</span><br><span>       - name: &quot;AWS-LC: checkout&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if: steps=
.aws-lc-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span>       =
  uses: actions/checkout@...2998... # v6.0.2</span><br><span>         with:=
</span><br><span>           path: aws-lc</span><br><span>           # versi=
oning=3Dsemver-coerced</span><br><span>           repository: aws/aws-lc</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v1.70.0</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: ${{ en=
v.AWS_LC_VERSION }}</span><br><span>       - uses: lukka/get-cmake@...3011...=
.. # v4.2.3</span><br><span>       - name: &quot;AWS-LC: build&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if: steps.aws-lc-c=
ache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span>         run: |<=
/span><br><span>           mkdir build</span><br><span>           cd build<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1577?usp=3Demail">change 1577</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1577?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie21fdb01b843a7af09fcd469b08=
c775eee7e3745 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1577 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--wGHxf50cMBo=--

