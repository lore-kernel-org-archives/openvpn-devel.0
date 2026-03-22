From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Mar 2026 11:04:42 +0000
In-Reply-To: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
References: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <963ff2f611453ac5aae880c21eaadcc7fb2dfa0c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5hs9og17HIM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5hs9og17HIM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1577?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: GHA: Cache built crypto libraries
......................................................................

GHA: Cache built crypto libraries

Semver code changes by Frank

Change-Id: Ie21fdb01b843a7af09fcd469b08c775eee7e3745
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1577
Message-Id: <20260322103820.4717-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
238.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M renovate.json
2 files changed, 58 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1577/5

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index dd8e472..186662d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -328,29 +328,43 @@
       LDFLAGS: ${{ matrix.ldflags }}
       CC: ${{matrix.cc}}
       UBSAN_OPTIONS: print_stacktrace=3D1
+      # versioning=3Dsemver-coerced
+      LIBRESSL_REPO: libressl/portable
+      LIBRESSL_VERSION: v4.2.1
+      LIBRESSL_INSTALL: /opt/libressl

     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore libressl from cache
+        uses: actions/cache@...3010...
+        id: libressl-cache
+        with:
+          path: ${{ env.LIBRESSL_INSTALL }}
+          key: ${{ matrix.os }}-libressl-${{matrix.build }}-${{ env.LIBRES=
SL_VERSION }}
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
+        run: ./configure --prefix=3D${{ env.LIBRESSL_INSTALL }}
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
@@ -360,7 +374,11 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=3Dopenssl ${{matrix.configu=
reflags}} --enable-werror
+        run: |
+          OPENSSL_CFLAGS=3D"-I${{ env.LIBRESSL_INSTALL }}/include" \
+          OPENSSL_LIBS=3D"-L${{ env.LIBRESSL_INSTALL }}/lib -lssl -lcrypto=
" \
+          LDFLAGS=3D"-Wl,-rpath=3D${{ env.LIBRESSL_INSTALL }}/lib" \
+          ./configure --with-crypto-library=3Dopenssl --enable-werror ${{m=
atrix.configureflags}}
       - name: make all
         run: make -j3
       - name: Ensure the build uses LibreSSL
@@ -396,27 +414,41 @@
       LDFLAGS: ${{ matrix.ldflags }}
       CC: ${{matrix.cc}}
       UBSAN_OPTIONS: print_stacktrace=3D1
+      PKG_CONFIG_PATH: /opt/mbedtls4/lib/pkgconfig
+      # versioning=3Dsemver-coerced
+      MBEDTLS_REPO: Mbed-TLS/mbedtls
+      MBEDTLS_VERSION: v4.0.0
+      MBEDTLS_INSTALL: /opt/mbedtls4

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
+          path: ${{ env.MBEDTLS_INSTALL }}
+          key: ${{ matrix.os }}-mbedtls-${{matrix.build }}-${{ env.MBEDTLS=
_VERSION }}
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
+        run: cmake -B build -DCMAKE_INSTALL_PREFIX=3D${{ env.MBEDTLS_INSTA=
L }}
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
@@ -426,7 +458,7 @@
         run: ./configure --with-crypto-library=3Dmbedtls --enable-werror
       - name: make all
         run: make -j3
-      - name: Ensure the build uses mbed TLS 4.x
+      - name: Ensure the build uses mbed TLS ${{ env.MBEDTLS_VERSION }}
         run: |
           ./src/openvpn/openvpn --version
           ./src/openvpn/openvpn --version | grep -q "library versions: mbe=
d TLS 4."
@@ -463,19 +495,29 @@
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
+          key: ${{ matrix.os }}-aws-lc-${{matrix.build }}-${{ env.AWS_LC_V=
ERSION }}
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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5hs9og17HIM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1577?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">GHA: Cache built crypto libr=
aries<br><br>Semver code changes by Frank<br><br>Change-Id: Ie21fdb01b843a7=
af09fcd469b08c775eee7e3745<br>Signed-off-by: Arne Schwabe &lt;arne@...2639...=
..&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Gerrit UR=
L: https://gerrit.openvpn.net/c/openvpn/+/1577<br>Message-Id: &lt;202603221=
03820.4717-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg36238.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M .github/workflows/build.yaml<br>M reno=
vate.json<br>2 files changed, 58 insertions(+), 15 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/77/1577/5</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/wor=
kflows/build.yaml</span><br><span>index dd8e472..186662d 100644</span><br><=
span>--- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/workf=
lows/build.yaml</span><br><span>@@ -328,29 +328,43 @@</span><br><span>     =
  LDFLAGS: ${{ matrix.ldflags }}</span><br><span>       CC: ${{matrix.cc}}<=
/span><br><span>       UBSAN_OPTIONS: print_stacktrace=3D1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      # versioning=3Dsemver-coerced<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+      LIBRESSL_REPO:=
 libressl/portable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     LIBRESSL_VERSION: v4.2.1</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      LIBRESSL_INSTALL: /opt/libressl</span><br><span> </span><br=
><span>     steps:</span><br><span>       - name: Install dependencies</spa=
n><br><span>         run: sudo apt update &amp;&amp; sudo apt install -y li=
blzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-d=
ev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libn=
l-genl-3-dev</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      -=
 name: Restore libressl from cache</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        uses: actions/cache@...3010...</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        id: libressl-cache</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        with:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+          path: ${{ env.LIBRESSL_INSTALL=
 }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          key: $=
{{ matrix.os }}-libressl-${{matrix.build }}-${{ env.LIBRESSL_VERSION }}</sp=
an><br><span>       - name: &quot;libressl: checkout&quot;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if: steps.libressl-cache.out=
puts.cache-hit !=3D &#39;true&#39;</span><br><span>         uses: actions/c=
heckout@...2998... # v6.0.2</span><br><span>         with:</span><br><span>=
           path: libressl</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-          # versioning=3Dsemver-coerced</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-          repository: libressl/portable</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-          ref: v4.2.1</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          repository: ${{ env.LIB=
RESSL_REPO }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
    ref: ${{ env.LIBRESSL_VERSION }}</span><br><span>       - name: &quot;l=
ibressl: autogen.sh&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if: steps.libressl-cache.outputs.cache-hit !=3D &#39;true&#39=
;</span><br><span>         env:</span><br><span>           LIBRESSL_GIT_OPT=
IONS: &quot;--no-single-branch&quot;</span><br><span>         run: ./autoge=
n.sh</span><br><span>         working-directory: libressl</span><br><span> =
      - name: &quot;libressl: configure&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        run: ./configure</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if: steps.libressl-cache.outputs.cache=
-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        run: ./configure --prefix=3D${{ env.LIBRESSL_INSTALL }}</span>=
<br><span>         working-directory: libressl</span><br><span>       - nam=
e: &quot;libressl: make all&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if: steps.libressl-cache.outputs.cache-hit !=3D &#39;=
true&#39;</span><br><span>         run: make -j3</span><br><span>         w=
orking-directory: libressl</span><br><span>       - name: &quot;libressl: m=
ake install&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if: steps.libressl-cache.outputs.cache-hit !=3D &#39;true&#39;</span>=
<br><span>         run: sudo make install</span><br><span>         working-=
directory: libressl</span><br><span>       - name: &quot;ldconfig&quot;</sp=
an><br><span>@@ -360,7 +374,11 @@</span><br><span>       - name: autoconf</=
span><br><span>         run: autoreconf -fvi</span><br><span>       - name:=
 configure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run=
: ./configure --with-crypto-library=3Dopenssl ${{matrix.configureflags}} --=
enable-werror</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  run: |</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          O=
PENSSL_CFLAGS=3D&quot;-I${{ env.LIBRESSL_INSTALL }}/include&quot; \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+          OPENSSL_LIBS=3D&q=
uot;-L${{ env.LIBRESSL_INSTALL }}/lib -lssl -lcrypto&quot; \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+          LDFLAGS=3D&quot;-Wl,-rpa=
th=3D${{ env.LIBRESSL_INSTALL }}/lib&quot; \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+          ./configure --with-crypto-library=3Dopen=
ssl --enable-werror ${{matrix.configureflags}}</span><br><span>       - nam=
e: make all</span><br><span>         run: make -j3</span><br><span>       -=
 name: Ensure the build uses LibreSSL</span><br><span>@@ -396,27 +414,41 @@=
</span><br><span>       LDFLAGS: ${{ matrix.ldflags }}</span><br><span>    =
   CC: ${{matrix.cc}}</span><br><span>       UBSAN_OPTIONS: print_stacktrac=
e=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      PKG_CONF=
IG_PATH: /opt/mbedtls4/lib/pkgconfig</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      # versioning=3Dsemver-coerced</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      MBEDTLS_REPO: Mbed-TLS/mbedtls</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      MBEDTLS_VERSION: v=
4.0.0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      MBEDTLS_=
INSTALL: /opt/mbedtls4</span><br><span> </span><br><span>     steps:</span>=
<br><span>       - name: Install dependencies</span><br><span>         run:=
 sudo apt update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev li=
blz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils pytho=
n3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng=
-dev libnl-genl-3-dev</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      - name: Restore mbed TLS from cache</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        uses: actions/cache@...3010...</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        id: mbedtls-cache</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        with:</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+          path: ${{ env.MBEDTLS_=
INSTALL }}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
 key: ${{ matrix.os }}-mbedtls-${{matrix.build }}-${{ env.MBEDTLS_VERSION }=
}</span><br><span>       - name: &quot;mbedtls: checkout&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if: steps.mbedtls-cache.=
outputs.cache-hit !=3D &#39;true&#39;</span><br><span>         uses: action=
s/checkout@...2998... # v6.0.2</span><br><span>         with:</span><br><sp=
an>           path: mbedtls</span><br><span>           submodules: recursiv=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          # versioni=
ng=3Dsemver-coerced</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
        repository: Mbed-TLS/mbedtls</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-          ref: v4.0.0</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+          repository: ${{ env.MBEDTLS_REPO }}</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+          ref: ${{ env.MBEDTLS_V=
ERSION }}</span><br><span>       - uses: lukka/get-cmake@...2999... # v4.2.=
3</span><br><span>       - name: &quot;mbedtls: cmake&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        run: cmake -B build</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if: steps.mbedtls-cac=
he.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        run: cmake -B build -DCMAKE_INSTALL_PREFIX=3D$=
{{ env.MBEDTLS_INSTAL }}</span><br><span>         working-directory: mbedtl=
s</span><br><span>       - name: &quot;mbedtls: cmake --build&quot;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if: steps.mbedtls-c=
ache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span>         run: cm=
ake --build build</span><br><span>         working-directory: mbedtls</span=
><br><span>       - name: &quot;mbedtls: cmake --install&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        run: sudo cmake --install =
build --prefix /usr</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if: steps.mbedtls-cache.outputs.cache-hit !=3D &#39;true&#39;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: sudo cmake -=
-install build</span><br><span>         working-directory: mbedtls</span><b=
r><span>       - name: Checkout OpenVPN</span><br><span>         uses: acti=
ons/checkout@...2998... # v6.0.2</span><br><span>@@ -426,7 +458,7 @@</span>=
<br><span>         run: ./configure --with-crypto-library=3Dmbedtls --enabl=
e-werror</span><br><span>       - name: make all</span><br><span>         r=
un: make -j3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - n=
ame: Ensure the build uses mbed TLS 4.x</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+      - name: Ensure the build uses mbed TLS ${{ env.MB=
EDTLS_VERSION }}</span><br><span>         run: |</span><br><span>          =
 ./src/openvpn/openvpn --version</span><br><span>           ./src/openvpn/o=
penvpn --version | grep -q &quot;library versions: mbed TLS 4.&quot;</span>=
<br><span>@@ -463,19 +495,29 @@</span><br><span>       CXX: ${{matrix.cxx}}=
</span><br><span>       UBSAN_OPTIONS: print_stacktrace=3D1</span><br><span=
>       AWS_LC_INSTALL: /opt/aws-lc</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+      # versioning=3Dsemver-coerced</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      AWS_LC_REPO: aws/aws-lc</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+      AWS_LC_VERSION: v1.70.0</=
span><br><span> </span><br><span>     steps:</span><br><span>       - name:=
 Install dependencies</span><br><span>         run: sudo apt update &amp;&a=
mp; sudo apt install -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev=
 linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja=
2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev lib=
nl-genl-3-dev</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
- name: Restore AWS-LC from cache</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        uses: actions/cache@...3010...</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        id: aws-lc-cache</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        with:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          path: ${{ env.AWS_LC_INSTALL }}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          key: ${{ =
matrix.os }}-aws-lc-${{matrix.build }}-${{ env.AWS_LC_VERSION }}</span><br>=
<span>       - name: &quot;AWS-LC: checkout&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if: steps.aws-lc-cache.outputs.cache-=
hit !=3D &#39;true&#39;</span><br><span>         uses: actions/checkout@...493...=
2998... # v6.0.2</span><br><span>         with:</span><br><span>           =
path: aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
 # versioning=3Dsemver-coerced</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-          repository: aws/aws-lc</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-          ref: v1.70.0</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+          repository: ${{ env.AWS_LC_REPO }}</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+          ref: ${{ env.AWS_=
LC_VERSION }}</span><br><span>       - uses: lukka/get-cmake@...2999... # v=
4.2.3</span><br><span>       - name: &quot;AWS-LC: build&quot;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if: steps.aws-lc-cache.o=
utputs.cache-hit !=3D &#39;true&#39;</span><br><span>         run: |</span>=
<br><span>           mkdir build</span><br><span>           cd build</span>=
<br><span>diff --git a/renovate.json b/renovate.json</span><br><span>index =
d0f319d..f9c62c4 100644</span><br><span>--- a/renovate.json</span><br><span=
>+++ b/renovate.json</span><br><span>@@ -40,9 +40,10 @@</span><br><span>   =
              &quot;/^\\.github/workflows/.+\\.ya?ml$/&quot;</span><br><spa=
n>             ],</span><br><span>             &quot;matchStrings&quot;: [<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                &quot;=
versioning=3D(?&lt;versioning&gt;.*?)\\n\\s*repository:\\s*(?&lt;depName&gt=
;.*?)\\n\\s*ref:\\s*(?&lt;currentValue&gt;.*?)\\n&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                &quot;versioning=3D(?&l=
t;versioning&gt;.*?)\\n\\s*.*?_REPO:\\s*(?&lt;depName&gt;.*?)\\n\\s*.*?_VER=
SION:\\s*(?&lt;currentValue&gt;.*?)\\n&quot;</span><br><span>             ]=
,</span><br><span>             &quot;datasourceTemplate&quot;: &quot;github=
-tags&quot;</span><br><span>         }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span>     ]</span><br><span> }</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1577?usp=3Demail">change 1577</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?u=
sp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1577?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie21fdb01b843a7af09fcd469b08=
c775eee7e3745 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1577 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--5hs9og17HIM=--

