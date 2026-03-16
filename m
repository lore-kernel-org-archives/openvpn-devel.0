From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 16 Mar 2026 17:22:07 +0000
In-Reply-To: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
References: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6f5dcc57f4b0e1b31aa339c2d183402d4bc83fe7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="g30nFRoZfcI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: GHA: Cache built
 crypto libraries
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

--g30nFRoZfcI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has uploaded a new patch set (#3) to the change originally cre=
ated by plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1577?usp=3Demail=
 )


Change subject: GHA: Cache built crypto libraries
......................................................................

GHA: Cache built crypto libraries

Change-Id: Ie21fdb01b843a7af09fcd469b08c775eee7e3745
---
M .github/workflows/build.yaml
M renovate.json
2 files changed, 56 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1577/3

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index dd8e472..1a4dc57 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -328,29 +328,42 @@
       LDFLAGS: ${{ matrix.ldflags }}
       CC: ${{matrix.cc}}
       UBSAN_OPTIONS: print_stacktrace=3D1
+      # versioning=3Dsemver-coerced
+      LIBRESSL_REPO: libressl/portable
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
-          # versioning=3Dsemver-coerced
-          repository: libressl/portable
-          ref: v4.2.1
+          repository: ${{ env.LIBRESSL_REPO }}
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
@@ -360,7 +373,11 @@
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
@@ -396,27 +413,40 @@
       LDFLAGS: ${{ matrix.ldflags }}
       CC: ${{matrix.cc}}
       UBSAN_OPTIONS: print_stacktrace=3D1
+      PKG_CONFIG_PATH: /opt/lib/pkgconfig
+      # versioning=3Dsemver-coerced
+      MBEDTLS_REPO: Mbed-TLS/mbedtls
+      MBEDTLS_VERSION: v4.0.0
=20
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
-          # versioning=3Dsemver-coerced
-          repository: Mbed-TLS/mbedtls
-          ref: v4.0.0
+          repository: ${{ env.MBEDTLS_REPO }}
+          ref: ${{ env.MBEDTLS_VERSION }}
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
@@ -426,7 +456,7 @@
         run: ./configure --with-crypto-library=3Dmbedtls --enable-werror
       - name: make all
         run: make -j3
-      - name: Ensure the build uses mbed TLS 4.x
+      - name: Ensure the build uses mbed TLS ${{ env.MBEDTLS_VERSION }}
         run: |
           ./src/openvpn/openvpn --version
           ./src/openvpn/openvpn --version | grep -q "library versions: mbe=
d TLS 4."
@@ -463,19 +493,29 @@
       CXX: ${{matrix.cxx}}
       UBSAN_OPTIONS: print_stacktrace=3D1
       AWS_LC_INSTALL: /opt/aws-lc
+      # versioning=3Dsemver-coerced
+      AWS_LC_REPO: aws/aws-lc
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
-          # versioning=3Dsemver-coerced
-          repository: aws/aws-lc
-          ref: v1.70.0
+          repository: ${{ env.AWS_LC_REPO }}
+          ref: ${{ env.AWS_LC_VERSION }}
       - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "AWS-LC: build"
+        if: steps.aws-lc-cache.outputs.cache-hit !=3D 'true'
         run: |
           mkdir build
           cd build
diff --git a/renovate.json b/renovate.json
index d0f319d..f9c62c4 100644
--- a/renovate.json
+++ b/renovate.json
@@ -40,9 +40,10 @@
                 "/^\\.github/workflows/.+\\.ya?ml$/"
             ],
             "matchStrings": [
-                "versioning=3D(?<versioning>.*?)\\n\\s*repository:\\s*(?<d=
epName>.*?)\\n\\s*ref:\\s*(?<currentValue>.*?)\\n"
+                "versioning=3D(?<versioning>.*?)\\n\\s*.*?_REPO:\\s*(?<dep=
Name>.*?)\\n\\s*.*?_VERSION:\\s*(?<currentValue>.*?)\\n"
             ],
             "datasourceTemplate": "github-tags"
         }
+
     ]
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1577?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie21fdb01b843a7af09fcd469b08c775eee7e3745
Gerrit-Change-Number: 1577
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--g30nFRoZfcI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>flichtenheld <str=
ong>uploaded patch set #3</strong> to the change originally created by plai=
sthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1577?usp=3Dem=
ail">View Change</a></p><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">GHA: Cache built crypto libraries<br>=
<br>Change-Id: Ie21fdb01b843a7af09fcd469b08c775eee7e3745<br>---<br>M .githu=
b/workflows/build.yaml<br>M renovate.json<br>2 files changed, 56 insertions=
(+), 15 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/77/1577/3</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/wo=
rkflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index dd8=
e472..1a4dc57 100644</span><br><span>--- a/.github/workflows/build.yaml</sp=
an><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -328,29 =
+328,42 @@</span><br><span>       LDFLAGS: ${{ matrix.ldflags }}</span><br>=
<span>       CC: ${{matrix.cc}}</span><br><span>       UBSAN_OPTIONS: print=
_stacktrace=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
  # versioning=3Dsemver-coerced</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      LIBRESSL_REPO: libressl/portable</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      LIBRESSL_VERSION: v4.2.1</span><br><sp=
an> </span><br><span>     steps:</span><br><span>       - name: Install dep=
endencies</span><br><span>         run: sudo apt update &amp;&amp; sudo apt=
 install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html cla=
ng libcmocka-dev python3-docutils libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      - name: Restore libressl from cache</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        uses: actions/cache@...3010...</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        id: libressl-cache<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        with:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+          path: /opt</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          key: ${{ matrix=
.os }}-libressl-${{ env.LIBRESSL_VERSION }}</span><br><span>       - name: =
&quot;libressl: checkout&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if: steps.libressl-cache.outputs.cache-hit !=3D &#39;tru=
e&#39;</span><br><span>         uses: actions/checkout@...2998... # v6.0.2<=
/span><br><span>         with:</span><br><span>           path: libressl</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-          # versioning=
=3Dsemver-coerced</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
      repository: libressl/portable</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-          ref: v4.2.1</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+          repository: ${{ env.LIBRESSL_REPO }}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+          ref: ${{ env.LIBRESSL_=
VERSION }}</span><br><span>       - name: &quot;libressl: autogen.sh&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if: steps.li=
bressl-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span>        =
 env:</span><br><span>           LIBRESSL_GIT_OPTIONS: &quot;--no-single-br=
anch&quot;</span><br><span>         run: ./autogen.sh</span><br><span>     =
    working-directory: libressl</span><br><span>       - name: &quot;libres=
sl: configure&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      run: ./configure</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if: steps.libressl-cache.outputs.cache-hit !=3D &#39;true&#39;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: ./config=
ure --prefix=3D/opt</span><br><span>         working-directory: libressl</s=
pan><br><span>       - name: &quot;libressl: make all&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if: steps.libressl-cache.ou=
tputs.cache-hit !=3D &#39;true&#39;</span><br><span>         run: make -j3<=
/span><br><span>         working-directory: libressl</span><br><span>      =
 - name: &quot;libressl: make install&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if: steps.libressl-cache.outputs.cache-hit =
!=3D &#39;true&#39;</span><br><span>         run: sudo make install</span><=
br><span>         working-directory: libressl</span><br><span>       - name=
: &quot;ldconfig&quot;</span><br><span>@@ -360,7 +373,11 @@</span><br><span=
>       - name: autoconf</span><br><span>         run: autoreconf -fvi</spa=
n><br><span>       - name: configure</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        run: ./configure --with-crypto-library=3Dopenssl ${{=
matrix.configureflags}} --enable-werror</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        run: |</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+          OPENSSL_CFLAGS=3D&quot;-I/opt/include&quot; \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+          OPENSSL_LIBS=
=3D&quot;-L/opt/lib -lssl -lcrypto&quot; \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+          LDFLAGS=3D&quot;-Wl,-rpath=3D/opt/lib&quot=
; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ./conf=
igure --with-crypto-library=3Dopenssl --enable-werror ${{matrix.configurefl=
ags}}</span><br><span>       - name: make all</span><br><span>         run:=
 make -j3</span><br><span>       - name: Ensure the build uses LibreSSL</sp=
an><br><span>@@ -396,27 +413,40 @@</span><br><span>       LDFLAGS: ${{ matr=
ix.ldflags }}</span><br><span>       CC: ${{matrix.cc}}</span><br><span>   =
    UBSAN_OPTIONS: print_stacktrace=3D1</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      PKG_CONFIG_PATH: /opt/lib/pkgconfig</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      # versioning=3Dsemver-coerc=
ed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      MBEDTLS_REP=
O: Mbed-TLS/mbedtls</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
      MBEDTLS_VERSION: v4.0.0</span><br><span> </span><br><span>     steps:=
</span><br><span>       - name: Install dependencies</span><br><span>      =
   run: sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g=
-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutil=
s python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config li=
bcap-ng-dev libnl-genl-3-dev</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      - name: Restore mbed TLS from cache</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        uses: actions/cache@...3010...</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        id: mbedtls-cache=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        with:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          path: /opt/</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          key: ${{ matr=
ix.os }}-mbedtls-${{ env.MBEDTLS_VERSION }}</span><br><span>       - name: =
&quot;mbedtls: checkout&quot;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if: steps.mbedtls-cache.outputs.cache-hit !=3D &#39;true&=
#39;</span><br><span>         uses: actions/checkout@...2998... # v6.0.2</s=
pan><br><span>         with:</span><br><span>           path: mbedtls</span=
><br><span>           submodules: recursive</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-          # versioning=3Dsemver-coerced</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-          repository: Mbed-TLS/mbed=
tls</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: v4.=
0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          reposi=
tory: ${{ env.MBEDTLS_REPO }}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+          ref: ${{ env.MBEDTLS_VERSION }}</span><br><span>       =
- uses: lukka/get-cmake@...2999... # v4.2.3</span><br><span>       - name: =
&quot;mbedtls: cmake&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        run: cmake -B build</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if: steps.mbedtls-cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run:=
 cmake -B build -DCMAKE_INSTALL_PREFIX=3D/opt</span><br><span>         work=
ing-directory: mbedtls</span><br><span>       - name: &quot;mbedtls: cmake =
--build&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  if: steps.mbedtls-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><=
span>         run: cmake --build build</span><br><span>         working-dir=
ectory: mbedtls</span><br><span>       - name: &quot;mbedtls: cmake --insta=
ll&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: =
sudo cmake --install build --prefix /usr</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if: steps.mbedtls-cache.outputs.cache-hit !=3D=
 &#39;true&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    run: sudo cmake --install build</span><br><span>         working-direct=
ory: mbedtls</span><br><span>       - name: Checkout OpenVPN</span><br><spa=
n>         uses: actions/checkout@...2998... # v6.0.2</span><br><span>@@ -4=
26,7 +456,7 @@</span><br><span>         run: ./configure --with-crypto-libr=
ary=3Dmbedtls --enable-werror</span><br><span>       - name: make all</span=
><br><span>         run: make -j3</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-      - name: Ensure the build uses mbed TLS 4.x</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+      - name: Ensure the build use=
s mbed TLS ${{ env.MBEDTLS_VERSION }}</span><br><span>         run: |</span=
><br><span>           ./src/openvpn/openvpn --version</span><br><span>     =
      ./src/openvpn/openvpn --version | grep -q &quot;library versions: mbe=
d TLS 4.&quot;</span><br><span>@@ -463,19 +493,29 @@</span><br><span>      =
 CXX: ${{matrix.cxx}}</span><br><span>       UBSAN_OPTIONS: print_stacktrac=
e=3D1</span><br><span>       AWS_LC_INSTALL: /opt/aws-lc</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+      # versioning=3Dsemver-coerced</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+      AWS_LC_REPO: aws=
/aws-lc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      AWS_LC=
_VERSION: v1.70.0</span><br><span> </span><br><span>     steps:</span><br><=
span>       - name: Install dependencies</span><br><span>         run: sudo=
 apt update &amp;&amp; sudo apt install -y gcc golang make liblzo2-dev libp=
am0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-doc=
utils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-confi=
g libcap-ng-dev libnl-genl-3-dev</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      - name: Restore AWS-LC from cache</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uses: actions/cache@...3010...</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        id: aws-lc-cac=
he</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        with:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+          path: ${{ env=
.AWS_LC_INSTALL }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
         key: ${{ matrix.os }}-aws-lc-${{ env.AWS_LC_VERSION }}</span><br><=
span>       - name: &quot;AWS-LC: checkout&quot;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if: steps.aws-lc-cache.outputs.cache-h=
it !=3D &#39;true&#39;</span><br><span>         uses: actions/checkout@...1665...=
998... # v6.0.2</span><br><span>         with:</span><br><span>           p=
ath: aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
# versioning=3Dsemver-coerced</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-          repository: aws/aws-lc</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-          ref: v1.70.0</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+          repository: ${{ env.AWS_LC_REPO }}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+          ref: ${{ env.AWS_L=
C_VERSION }}</span><br><span>       - uses: lukka/get-cmake@...2999... # v4=
.2.3</span><br><span>       - name: &quot;AWS-LC: build&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if: steps.aws-lc-cache.ou=
tputs.cache-hit !=3D &#39;true&#39;</span><br><span>         run: |</span><=
br><span>           mkdir build</span><br><span>           cd build</span><=
br><span>diff --git a/renovate.json b/renovate.json</span><br><span>index d=
0f319d..f9c62c4 100644</span><br><span>--- a/renovate.json</span><br><span>=
+++ b/renovate.json</span><br><span>@@ -40,9 +40,10 @@</span><br><span>    =
             &quot;/^\\.github/workflows/.+\\.ya?ml$/&quot;</span><br><span=
>             ],</span><br><span>             &quot;matchStrings&quot;: [</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;v=
ersioning=3D(?&lt;versioning&gt;.*?)\\n\\s*repository:\\s*(?&lt;depName&gt;=
.*?)\\n\\s*ref:\\s*(?&lt;currentValue&gt;.*?)\\n&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                &quot;versioning=3D(?&lt=
;versioning&gt;.*?)\\n\\s*.*?_REPO:\\s*(?&lt;depName&gt;.*?)\\n\\s*.*?_VERS=
ION:\\s*(?&lt;currentValue&gt;.*?)\\n&quot;</span><br><span>             ],=
</span><br><span>             &quot;datasourceTemplate&quot;: &quot;github-=
tags&quot;</span><br><span>         }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span>     ]</span><br><span> }</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1577?usp=3Demail">change 1577</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1577?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie21fdb01b843a7af09fcd469b08=
c775eee7e3745 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1577 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--g30nFRoZfcI=--

