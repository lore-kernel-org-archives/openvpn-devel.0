From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 20 Apr 2026 17:31:46 +0000
In-Reply-To: <gerrit.1776685712000.I3d89016ccae297cfa596897c11a518f1ffbe3dc8@...2715...>
References: <gerrit.1776685712000.I3d89016ccae297cfa596897c11a518f1ffbe3dc8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <04bf960dc2fccdf797588c157be71d5469ae71cb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="rSInf1T+uDg="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: GHA: Factor out
 building SSL libs to a reusable workflow
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rSInf1T+uDg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1630?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by uddr


Change subject: GHA: Factor out building SSL libs to a reusable workflow
......................................................................

GHA: Factor out building SSL libs to a reusable workflow

We amassed a lot of code duplication there. Make
it easier to track the differences between the libraries.

Change-Id: I3d89016ccae297cfa596897c11a518f1ffbe3dc8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1630
Message-Id: <20260420160732.9492-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
686.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
A .github/workflows/test-ssllib.yml
M renovate.json
3 files changed, 155 insertions(+), 313 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/1630/4

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 365e72a..e4cb799 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -304,324 +304,49 @@
             !${{ github.workspace }}/out/**/vcpkg_installed/**

   libressl:
-    strategy:
-      fail-fast: false
-      matrix:
-        os: [ubuntu-24.04]
-        ssllib: [libressl]
-        build: [ normal, asan ]
-        configureflags: ["--with-openssl-engine=3Dno"]
-        include:
-          - build: asan
-            cflags: "-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fn=
o-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame=
-pointer -g -O1"
-            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall
-            cc: clang
-          - build: normal
-            cflags: "-O2 -g"
-            ldflags: ""
-            cc: gcc
-
-    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.s=
sllib}}"
-    runs-on: ${{matrix.os}}
-    env:
-      CFLAGS: ${{ matrix.cflags }}
-      LDFLAGS: ${{ matrix.ldflags }}
-      CC: ${{matrix.cc}}
-      UBSAN_OPTIONS: print_stacktrace=3D1
+    uses: ./.github/workflows/test-ssllib.yml
+    with:
+      libname: libressl
+      ovpnlibdesc: LibreSSL
       # versioning=3Dsemver-coerced
-      LIBRESSL_REPO: libressl/portable
-      LIBRESSL_VERSION: v4.2.1
-      LIBRESSL_INSTALL: /opt/libressl
+      ghrepo: libressl/portable
+      gitref: v4.2.1
+      libconfigure: "LIBRESSL_GIT_OPTIONS=3D--no-single-branch ./autogen.s=
h && ./configure --prefix=3D$LIBPREFIX"

-    steps:
-      - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
-      - name: Restore libressl from cache
-        uses: actions/cache@...3010...
-        id: libressl-cache
-        with:
-          path: ${{ env.LIBRESSL_INSTALL }}
-          key: ${{ matrix.os }}-libressl-${{matrix.build }}-${{ env.LIBRES=
SL_VERSION }}
-      - name: "libressl: checkout"
-        if: steps.libressl-cache.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2998... # v6.0.2
-        with:
-          path: libressl
-          repository: ${{ env.LIBRESSL_REPO }}
-          ref: ${{ env.LIBRESSL_VERSION }}
-      - name: "libressl: autogen.sh"
-        if: steps.libressl-cache.outputs.cache-hit !=3D 'true'
-        env:
-          LIBRESSL_GIT_OPTIONS: "--no-single-branch"
-        run: ./autogen.sh
-        working-directory: libressl
-      - name: "libressl: configure"
-        if: steps.libressl-cache.outputs.cache-hit !=3D 'true'
-        run: ./configure --prefix=3D${{ env.LIBRESSL_INSTALL }}
-        working-directory: libressl
-      - name: "libressl: make all"
-        if: steps.libressl-cache.outputs.cache-hit !=3D 'true'
-        run: make -j3
-        working-directory: libressl
-      - name: "libressl: make install"
-        if: steps.libressl-cache.outputs.cache-hit !=3D 'true'
-        run: sudo make install
-        working-directory: libressl
-      - name: "ldconfig"
-        run: sudo ldconfig
-      - name: Checkout OpenVPN
-        uses: actions/checkout@...2998... # v6.0.2
-      - name: autoconf
-        run: autoreconf -fvi
-      - name: configure
-        run: |
-          OPENSSL_CFLAGS=3D"-I${{ env.LIBRESSL_INSTALL }}/include" \
-          OPENSSL_LIBS=3D"-L${{ env.LIBRESSL_INSTALL }}/lib -lssl -lcrypto=
" \
-          LDFLAGS=3D"-Wl,-rpath=3D${{ env.LIBRESSL_INSTALL }}/lib" \
-          ./configure --with-crypto-library=3Dopenssl --enable-werror ${{m=
atrix.configureflags}}
-      - name: make all
-        run: make -j3
-      - name: Ensure the build uses LibreSSL
-        run: |
-          ./src/openvpn/openvpn --version
-          ./src/openvpn/openvpn --version | grep -q "library versions: Lib=
reSSL"
-      - name: configure checks
-        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
-      - name: make check
-        run: make -j3 check VERBOSE=3D1
-
-  openssl:
-    strategy:
-      fail-fast: false
-      matrix:
-        os: [ubuntu-24.04]
-        ssllib: [openssl]
-        build: [ normal, asan ]
-        configureflags: ["--with-openssl-engine=3Dno"]
-        include:
-          - build: asan
-            cflags: "-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fn=
o-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame=
-pointer -g -O1"
-            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall
-            cc: clang
-          - build: normal
-            cflags: "-O2 -g"
-            ldflags: ""
-            cc: gcc
-
-    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.s=
sllib}} - 4.0"
-    runs-on: ${{matrix.os}}
-    env:
-      CFLAGS: ${{ matrix.cflags }}
-      LDFLAGS: ${{ matrix.ldflags }}
-      CC: ${{matrix.cc}}
-      UBSAN_OPTIONS: print_stacktrace=3D1
+  openssl4:
+    uses: ./.github/workflows/test-ssllib.yml
+    with:
+      libname: openssl
+      ovpnlibdesc: OpenSSL 4.
       # versioning=3Dsemver-coerced
-      OPENSSL_REPO: openssl/openssl
-      OPENSSL_VERSION: openssl-4.0.0-beta1
-      OPENSSL_INSTALL: /opt/openssl
-
-    steps:
-      - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
-      - name: Restore OpenSSL 4.0 from cache
-        uses: actions/cache@...3010...
-        id: openssl-cache
-        with:
-          path: ${{ env.OPENSSL_INSTALL }}
-          key: ${{ matrix.os }}-openssl-${{matrix.build }}-${{ env.OPENSSL=
_VERSION }}
-      - name: "openssl: checkout"
-        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2998... # v6.0.2
-        with:
-          path: openssl
-          repository: ${{ env.OPENSSL_REPO }}
-          ref: ${{ env.OPENSSL_VERSION }}
-      - name: "openssl: configure"
-        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
-        run: ./Configure  --prefix=3D${{ env.OPENSSL_INSTALL }} --libdir=
=3D${{ env.OPENSSL_INSTALL }}/lib --openssldir=3D${{ env.OPENSSL_INSTALL }}=
 -g
-        working-directory: openssl
-      - name: "openssl: make all"
-        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
-        run: make -j3
-        working-directory: openssl
-      - name: "openssl: make install"
-        if: steps.openssl-cache.outputs.cache-hit !=3D 'true'
-        run: sudo make install
-        working-directory: openssl
-      - name: "ldconfig"
-        run: sudo ldconfig
-      - name: Checkout OpenVPN
-        uses: actions/checkout@...2998... # v6.0.2
-      - name: autoconf
-        run: autoreconf -fvi
-      - name: configure
-        run: |
-          OPENSSL_CFLAGS=3D"-I${{ env.OPENSSL_INSTALL }}/include" \
-          OPENSSL_LIBS=3D"-L${{ env.OPENSSL_INSTALL }}/lib -lssl -lcrypto"=
 \
-          LDFLAGS=3D"-Wl,-rpath=3D${{ env.OPENSSL_INSTALL }}/lib" \
-          ./configure --with-crypto-library=3Dopenssl --enable-werror ${{m=
atrix.configureflags}}
-      - name: make all
-        run: make -j3
-      - name: Ensure the build uses Openssl
-        run: |
-          ./src/openvpn/openvpn --version
-          ./src/openvpn/openvpn --version | grep -q "library versions: Ope=
nSSL 4.0"
-      - name: configure checks
-        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
-      - name: make check
-        run: make -j3 check VERBOSE=3D1
+      ghrepo: openssl/openssl
+      gitref: openssl-4.0.0-beta1
+      libconfigure: ./Configure --prefix=3D$LIBPREFIX --libdir=3D$LIBPREFI=
X/lib --openssldir=3D$LIBPREFIX -g

   mbedtls4:
-    strategy:
-      fail-fast: false
-      matrix:
-        os: [ubuntu-24.04]
-        ssllib: [mbedtls4]
-        build: [ normal, asan ]
-        include:
-          - build: asan
-            cflags: "-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fn=
o-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame=
-pointer -g -O1"
-            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall
-            cc: clang
-          - build: normal
-            cflags: "-O2 -g"
-            ldflags: ""
-            cc: gcc
-
-    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.s=
sllib}}"
-    runs-on: ${{matrix.os}}
-    env:
-      CFLAGS: ${{ matrix.cflags }}
-      LDFLAGS: ${{ matrix.ldflags }}
-      CC: ${{matrix.cc}}
-      UBSAN_OPTIONS: print_stacktrace=3D1
-      PKG_CONFIG_PATH: /opt/mbedtls4/lib/pkgconfig
+    uses: ./.github/workflows/test-ssllib.yml
+    with:
+      libname: mbedtls
+      ovpnlibname: mbedtls
+      ovpnlibdesc: mbed TLS 4.
       # versioning=3Dsemver-coerced
-      MBEDTLS_REPO: Mbed-TLS/mbedtls
-      MBEDTLS_VERSION: v4.0.0
-      MBEDTLS_INSTALL: /opt/mbedtls4
-
-    steps:
-      - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libc=
ap-ng-dev libnl-genl-3-dev
-      - name: Restore mbed TLS from cache
-        uses: actions/cache@...3010...
-        id: mbedtls-cache
-        with:
-          path: ${{ env.MBEDTLS_INSTALL }}
-          key: ${{ matrix.os }}-mbedtls-${{matrix.build }}-${{ env.MBEDTLS=
_VERSION }}
-      - name: "mbedtls: checkout"
-        if: steps.mbedtls-cache.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2998... # v6.0.2
-        with:
-          path: mbedtls
-          submodules: recursive
-          repository: ${{ env.MBEDTLS_REPO }}
-          ref: ${{ env.MBEDTLS_VERSION }}
-      - uses: lukka/get-cmake@...2999... # v4.2.3
-      - name: "mbedtls: cmake"
-        if: steps.mbedtls-cache.outputs.cache-hit !=3D 'true'
-        run: cmake -B build -DCMAKE_INSTALL_PREFIX=3D${{ env.MBEDTLS_INSTA=
L }}
-        working-directory: mbedtls
-      - name: "mbedtls: cmake --build"
-        if: steps.mbedtls-cache.outputs.cache-hit !=3D 'true'
-        run: cmake --build build
-        working-directory: mbedtls
-      - name: "mbedtls: cmake --install"
-        if: steps.mbedtls-cache.outputs.cache-hit !=3D 'true'
-        run: sudo cmake --install build
-        working-directory: mbedtls
-      - name: Checkout OpenVPN
-        uses: actions/checkout@...2998... # v6.0.2
-      - name: autoconf
-        run: autoreconf -fvi
-      - name: configure
-        run: ./configure --with-crypto-library=3Dmbedtls --enable-werror
-      - name: make all
-        run: make -j3
-      - name: Ensure the build uses mbed TLS ${{ env.MBEDTLS_VERSION }}
-        run: |
-          ./src/openvpn/openvpn --version
-          ./src/openvpn/openvpn --version | grep -q "library versions: mbe=
d TLS 4."
-      - name: configure checks
-        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
-      - name: make check
-        run: make -j3 check VERBOSE=3D1
+      ghrepo: Mbed-TLS/mbedtls
+      gitref: v4.0.0
+      libconfigure: cmake -B build -DCMAKE_INSTALL_PREFIX=3D$LIBPREFIX
+      libmake: cmake --build build
+      libinstall: sudo cmake --install build
+      ovpnconfigureenv: PKG_CONFIG_PATH=3D$LIBPREFIX/lib/pkgconfig

   aws-lc:
-    strategy:
-      fail-fast: false
-      matrix:
-        os: [ubuntu-24.04]
-        ssllib: [ awslc ]
-        build: [ normal, asan ]
-        include:
-          - build: asan
-            cflags: "-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fn=
o-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame=
-pointer -g -O1"
-            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall
-            cc: clang
-            cxx: clang++
-          - build: normal
-            cflags: "-O2 -g"
-            ldflags: ""
-            cc: gcc
-            cxx: c++
-
-    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.s=
sllib}}"
-    runs-on: ${{matrix.os}}
-    env:
-      CFLAGS: ${{ matrix.cflags }}
-      LDFLAGS: ${{ matrix.ldflags }}
-      CC: ${{matrix.cc}}
-      CXX: ${{matrix.cxx}}
-      UBSAN_OPTIONS: print_stacktrace=3D1
-      AWS_LC_INSTALL: /opt/aws-lc
+    uses: ./.github/workflows/test-ssllib.yml
+    with:
+      libname: aws-lc
+      ovpnlibdesc: AWS-LC
       # versioning=3Dsemver-coerced
-      AWS_LC_REPO: aws/aws-lc
-      AWS_LC_VERSION: v1.70.0
-
-    steps:
-      - name: Install dependencies
-        run: sudo apt update && sudo apt install -y gcc golang make liblzo=
2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev p=
ython3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf=
 pkg-config libcap-ng-dev libnl-genl-3-dev
-      - name: Restore AWS-LC from cache
-        uses: actions/cache@...3010...
-        id: aws-lc-cache
-        with:
-          path: ${{ env.AWS_LC_INSTALL }}
-          key: ${{ matrix.os }}-aws-lc-${{matrix.build }}-${{ env.AWS_LC_V=
ERSION }}
-      - name: "AWS-LC: checkout"
-        if: steps.aws-lc-cache.outputs.cache-hit !=3D 'true'
-        uses: actions/checkout@...2998... # v6.0.2
-        with:
-          path: aws-lc
-          repository: ${{ env.AWS_LC_REPO }}
-          ref: ${{ env.AWS_LC_VERSION }}
-      - uses: lukka/get-cmake@...2999... # v4.2.3
-      - name: "AWS-LC: build"
-        if: steps.aws-lc-cache.outputs.cache-hit !=3D 'true'
-        run: |
-          mkdir build
-          cd build
-          cmake -GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMAKE_INSTALL_PREFI=
X=3D"${{ env.AWS_LC_INSTALL }}" -DBUILD_SHARED_LIBS=3D1 ../
-          ninja install
-        working-directory: aws-lc
-      - name: Checkout OpenVPN
-        uses: actions/checkout@...2998... # v6.0.2
-      - name: autoconf
-        run: autoreconf -fvi
-      - name: configure with AWS-LC
-        run: |
-          OPENSSL_CFLAGS=3D"-I${{ env.AWS_LC_INSTALL }}/include" \
-          OPENSSL_LIBS=3D"-L${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto" \
-          LDFLAGS=3D"-Wl,-rpath=3D${{ env.AWS_LC_INSTALL }}/lib" \
-          ./configure --with-crypto-library=3Dopenssl
-      - name: make all
-        run: make -j3
-      - name: Ensure the build uses AWS-LC
-        run: |
-          ./src/openvpn/openvpn --version
-          ./src/openvpn/openvpn --version | grep -q "library versions: AWS=
-LC"
-      - name: configure checks
-        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
-      - name: make check
-        run: make -j3 check VERBOSE=3D1
+      ghrepo: aws/aws-lc
+      gitref: v1.70.0
+      libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=3DRelease -D=
CMAKE_INSTALL_PREFIX=3D"$LIBPREFIX" -DBUILD_SHARED_LIBS=3D1
+      libmake: cmake --build build
+      libinstall: sudo cmake --install build
+      # not ready for --enable-werror
+      ovpnconfigureflags:
diff --git a/.github/workflows/test-ssllib.yml b/.github/workflows/test-ssl=
lib.yml
new file mode 100644
index 0000000..c6a2e44
--- /dev/null
+++ b/.github/workflows/test-ssllib.yml
@@ -0,0 +1,117 @@
+name: test_ssllib
+
+on:
+  workflow_call:
+    inputs:
+      libname:
+        required: true
+        type: string
+      ovpnlibname:
+        type: string
+        default: openssl
+      ovpnlibdesc:
+        required: true
+        type: string
+      ghrepo:
+        required: true
+        type: string
+      gitref:
+        required: true
+        type: string
+      libconfigure:
+        required: true
+        type: string
+      libmake:
+        type: string
+        default: "make -j3"
+      libinstall:
+        type: string
+        default: "sudo make install"
+      ovpnconfigureenv:
+        type: string
+        default: >-
+          OPENSSL_CFLAGS=3D"-I$LIBPREFIX/include"
+          OPENSSL_LIBS=3D"-L$LIBPREFIX/lib -lssl -lcrypto"
+          LDFLAGS=3D"-Wl,-rpath=3D$LIBPREFIX/lib"
+      ovpnconfigureflags:
+        type: string
+        default: --enable-werror --with-openssl-engine=3Dno
+
+jobs:
+  test_ssllib:
+    strategy:
+      fail-fast: false
+      matrix:
+        os: [ubuntu-24.04]
+        build: [normal, asan]
+        include:
+          - build: asan
+            cflags: "-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fn=
o-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame=
-pointer -g -O1"
+            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall
+            cc: clang
+            cxx: clang++
+          - build: normal
+            cflags: "-O2 -g"
+            ldflags: ""
+            cc: gcc
+            cxx: g++
+
+    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{inputs.l=
ibname}}"
+    runs-on: ${{matrix.os}}
+    env:
+      CFLAGS: ${{matrix.cflags}}
+      LDFLAGS: ${{matrix.ldflags}}
+      CC: ${{matrix.cc}}
+      CXX: ${{matrix.cxx}}
+      UBSAN_OPTIONS: print_stacktrace=3D1
+      LIBPREFIX: /opt/${{inputs.libname}}
+
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-d=
ev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils =
libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore ${{inputs.libname}} from cache
+        uses: actions/cache@...3024... # v5.0.5
+        id: ssllib-cache
+        with:
+          path: ${{env.LIBPREFIX}}
+          key: ${{matrix.os}}-${{inputs.libname}}-${{matrix.build }}-${{in=
puts.gitref}}
+      - name: "${{inputs.libname}}: checkout"
+        if: steps.ssllib-cache.outputs.cache-hit !=3D 'true'
+        uses: actions/checkout@...2998... # v6.0.2
+        with:
+          submodules: recursive
+          path: ${{inputs.libname}}
+          repository: ${{inputs.ghrepo}}
+          ref: ${{inputs.gitref}}
+      - name: "${{inputs.libname}}: configure"
+        if: steps.ssllib-cache.outputs.cache-hit !=3D 'true'
+        run: ${{inputs.libconfigure}}
+        working-directory: ${{inputs.libname}}
+      - name: "${{inputs.libname}}: build"
+        if: steps.ssllib-cache.outputs.cache-hit !=3D 'true'
+        run: ${{inputs.libmake}}
+        working-directory: ${{inputs.libname}}
+      - name: "${{inputs.libname}}: install"
+        if: steps.ssllib-cache.outputs.cache-hit !=3D 'true'
+        run: ${{inputs.libinstall}}
+        working-directory: ${{inputs.libname}}
+      - name: Run ldconfig
+        run: sudo ldconfig
+      - name: "OpenVPN: checkout"
+        uses: actions/checkout@...2998... # v6.0.2
+      - name: "OpenVPN: autoreconf"
+        run: autoreconf -fvi
+      - name: "OpenVPN: configure"
+        run: |
+          ${{inputs.ovpnconfigureenv}} \
+          ./configure --with-crypto-library=3D${{inputs.ovpnlibname}} ${{i=
nputs.ovpnconfigureflags}}
+      - name: "OpenVPN: build"
+        run: make -j3
+      - name: Ensure the build uses ${{inputs.libname}}
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: ${{=
inputs.ovpnlibdesc}}"
+      - name: "OpenVPN: configure checks"
+        run: echo 'RUN_SUDO=3D"sudo -E"' >tests/t_server_null.rc
+      - name: "OpenVPN: make check"
+        run: make -j3 check VERBOSE=3D1
diff --git a/renovate.json b/renovate.json
index f9c62c4..809ac3f 100644
--- a/renovate.json
+++ b/renovate.json
@@ -40,7 +40,7 @@
                 "/^\\.github/workflows/.+\\.ya?ml$/"
             ],
             "matchStrings": [
-                "versioning=3D(?<versioning>.*?)\\n\\s*.*?_REPO:\\s*(?<dep=
Name>.*?)\\n\\s*.*?_VERSION:\\s*(?<currentValue>.*?)\\n"
+                "versioning=3D(?<versioning>.*?)\\n\\s*ghrepo:\\s*(?<depNa=
me>.*?)\\n\\s*gitrepo:\\s*(?<currentValue>.*?)\\n"
             ],
             "datasourceTemplate": "github-tags"
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1630?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d89016ccae297cfa596897c11a518f1ffbe3dc8
Gerrit-Change-Number: 1630
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--rSInf1T+uDg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1630?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by uddr</p><pre class=3D"blocks" style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">GHA: Factor out building SSL libs to=
 a reusable workflow<br><br>We amassed a lot of code duplication there. Mak=
e<br>it easier to track the differences between the libraries.<br><br>Chang=
e-Id: I3d89016ccae297cfa596897c11a518f1ffbe3dc8<br>Signed-off-by: Frank Lic=
htenheld &lt;frank@...2641...&gt;<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr=
@...277...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1630<b=
r>Message-Id: &lt;20260420160732.9492-1-gert@...1296...&gt;<br>URL: https:/=
/www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36686.html<br>=
Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .github/wor=
kflows/build.yaml<br>A .github/workflows/test-ssllib.yml<br>M renovate.json=
<br>3 files changed, 155 insertions(+), 313 deletions(-)<br><br></pre><pre =
class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/16=
30/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/.github/workflows/build.yaml b/.github/workflows/=
build.yaml</span><br><span>index 365e72a..e4cb799 100644</span><br><span>--=
- a/.github/workflows/build.yaml</span><br><span>+++ b/.github/workflows/bu=
ild.yaml</span><br><span>@@ -304,324 +304,49 @@</span><br><span>           =
  !${{ github.workspace }}/out/**/vcpkg_installed/**</span><br><span> </spa=
n><br><span>   libressl:</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    strategy:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 fail-fast: false</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  matrix:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        os: =
[ubuntu-24.04]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 ssllib: [libressl]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      build: [ normal, asan ]</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        configureflags: [&quot;--with-openssl-engine=3Dno&quot;]</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        include:</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-          - build: asan</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            cflags: &quot;-=
fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fno-optimize-sibling-call=
s -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ldflags: -f=
sanitize=3Daddress -fno-sanitize-recover=3Dall</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            cc: clang</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-          - build: normal</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            cflags: &quot;-O2 -g&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            ldflags: &quot;&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            cc: g=
cc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    name: &quot;${{matrix.cc}} ${{matrix=
.build}} - ${{matrix.os}} - ${{matrix.ssllib}}&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    runs-on: ${{matrix.os}}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    env:</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-      CFLAGS: ${{ matrix.cflags }}</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      LDFLAGS: ${{ matrix.ldflags }}<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-      CC: ${{matrix.cc=
}}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      UBSAN_OPTIONS=
: print_stacktrace=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    uses: ./.github/workflows/test-ssllib.yml</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    with:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+      libname: libressl</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      ovpnlibdesc: LibreSSL</span><br><span>       #=
 versioning=3Dsemver-coerced</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      LIBRESSL_REPO: libressl/portable</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      LIBRESSL_VERSION: v4.2.1</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-      LIBRESSL_INSTALL: /opt/libressl</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      ghrepo: libressl/p=
ortable</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      gitref=
: v4.2.1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      libco=
nfigure: &quot;LIBRESSL_GIT_OPTIONS=3D--no-single-branch ./autogen.sh &amp;=
&amp; ./configure --prefix=3D$LIBPREFIX&quot;</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    steps:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - name: Install dependencies</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        run: sudo apt update &=
amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-lib=
c-dev man2html clang libcmocka-dev python3-docutils libtool automake autoco=
nf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      - name: Restore libressl from cache</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache@...3017...=
010...</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        id: lib=
ressl-cache</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        wi=
th:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          path: ${=
{ env.LIBRESSL_INSTALL }}</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-          key: ${{ matrix.os }}-libressl-${{matrix.build }}-${{ env.LIB=
RESSL_VERSION }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 - name: &quot;libressl: checkout&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if: steps.libressl-cache.outputs.cache-hit !=3D &=
#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
uses: actions/checkout@...2998... # v6.0.2</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        with:</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-          path: libressl</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-          repository: ${{ env.LIBRESSL_REPO }}</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-          ref: ${{ env.LIBRESSL_VE=
RSION }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name:=
 &quot;libressl: autogen.sh&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if: steps.libressl-cache.outputs.cache-hit !=3D &#39;tr=
ue&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        env:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-          LIBRESSL_GIT_=
OPTIONS: &quot;--no-single-branch&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        run: ./autogen.sh</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        working-directory: libressl</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      - name: &quot;libressl: configure=
&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: ste=
ps.libressl-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        run: ./configure --prefix=3D${{ e=
nv.LIBRESSL_INSTALL }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        working-directory: libressl</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - name: &quot;libressl: make all&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if: steps.libressl-cache.outp=
uts.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        run: make -j3</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        working-directory: libressl</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-      - name: &quot;libressl: make install&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: steps.libr=
essl-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        run: sudo make install</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        working-directory: libressl</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: &quot;ldcon=
fig&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run:=
 sudo ldconfig</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      -=
 name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        uses: actions/checkout@...2998... # v6.0.2</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - name: autoconf</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        run: autoreconf -fvi</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      - name: configure</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        run: |</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-          OPENSSL_CFLAGS=3D&quot;-I${{ e=
nv.LIBRESSL_INSTALL }}/include&quot; \</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-          OPENSSL_LIBS=3D&quot;-L${{ env.LIBRESSL_INSTALL =
}}/lib -lssl -lcrypto&quot; \</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-          LDFLAGS=3D&quot;-Wl,-rpath=3D${{ env.LIBRESSL_INSTALL }}/=
lib&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
./configure --with-crypto-library=3Dopenssl --enable-werror ${{matrix.confi=
gureflags}}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - na=
me: make all</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
un: make -j3</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - n=
ame: Ensure the build uses LibreSSL</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        run: |</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-          ./src/openvpn/openvpn --version</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-          ./src/openvpn/openvpn --version | grep=
 -q &quot;library versions: LibreSSL&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      - name: configure checks</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        run: echo &#39;RUN_SUDO=3D&quot;sud=
o -E&quot;&#39; &gt;tests/t_server_null.rc</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-      - name: make check</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        run: make -j3 check VERBOSE=3D1</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-  openssl:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    strategy:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-      fail-fast: false</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      matrix:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   os: [ubuntu-24.04]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        ssllib: [openssl]</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        build: [ normal, asan ]</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        configureflags: [&quot;--with-openssl-engine=3Dno&quo=
t;]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        include:</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-          - build: asan=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            cflags: &=
quot;-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fno-optimize-siblin=
g-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&q=
uot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ldfla=
gs: -fsanitize=3Daddress -fno-sanitize-recover=3Dall</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            cc: clang</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-          - build: normal</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            cflags: &quot;-O2 -g&quot;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            ldflags: &=
quot;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  cc: gcc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    name: &quot;${{matrix.cc}} ${=
{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}} - 4.0&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ${{matrix.os}}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    env:</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      CFLAGS: ${{ matrix.cflags }}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      LDFLAGS: ${{ matrix=
.ldflags }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      CC: =
${{matrix.cc}}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      U=
BSAN_OPTIONS: print_stacktrace=3D1</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+  openssl4:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    uses: ./.github/workflows/test-ssllib.yml</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    with:</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      libname: openssl</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+      ovpnlibdesc: OpenSSL 4.</span><br><span>  =
     # versioning=3Dsemver-coerced</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-      OPENSSL_REPO: openssl/openssl</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      OPENSSL_VERSION: openssl-4.0.0-beta1</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      OPENSSL_INSTALL: /opt=
/openssl</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    steps:</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - name: Install dependencies</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        run: sudo apt update &=
amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-lib=
c-dev man2html clang libcmocka-dev python3-docutils libtool automake autoco=
nf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-      - name: Restore OpenSSL 4.0 from cache</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache@...220...=
..3010...</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        id: =
openssl-cache</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          path: =
${{ env.OPENSSL_INSTALL }}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-          key: ${{ matrix.os }}-openssl-${{matrix.build }}-${{ env.OPE=
NSSL_VERSION }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
- name: &quot;openssl: checkout&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        if: steps.openssl-cache.outputs.cache-hit !=3D &#39=
;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        use=
s: actions/checkout@...2998... # v6.0.2</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        with:</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-          path: openssl</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-          repository: ${{ env.OPENSSL_REPO }}</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-          ref: ${{ env.OPENSSL_VERSION =
}}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: &quot=
;openssl: configure&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if: steps.openssl-cache.outputs.cache-hit !=3D &#39;true&#39;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: ./Configur=
e  --prefix=3D${{ env.OPENSSL_INSTALL }} --libdir=3D${{ env.OPENSSL_INSTALL=
 }}/lib --openssldir=3D${{ env.OPENSSL_INSTALL }} -g</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        working-directory: openssl</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-      - name: &quot;openssl: m=
ake all&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if: steps.openssl-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        run: make -j3</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        working-directory: openssl<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: &quot;op=
enssl: make install&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if: steps.openssl-cache.outputs.cache-hit !=3D &#39;true&#39;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: sudo make =
install</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        workin=
g-directory: openssl</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
     - name: &quot;ldconfig&quot;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        run: sudo ldconfig</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-      - name: Checkout OpenVPN</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        uses: actions/checkout@...2998... # v6.0.=
2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: autoco=
nf</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: autore=
conf -fvi</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name=
: configure</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ru=
n: |</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          OPENSSL=
_CFLAGS=3D&quot;-I${{ env.OPENSSL_INSTALL }}/include&quot; \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-          OPENSSL_LIBS=3D&quot;-L${{=
 env.OPENSSL_INSTALL }}/lib -lssl -lcrypto&quot; \</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-          LDFLAGS=3D&quot;-Wl,-rpath=3D${{ env=
.OPENSSL_INSTALL }}/lib&quot; \</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-          ./configure --with-crypto-library=3Dopenssl --enable-we=
rror ${{matrix.configureflags}}</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-      - name: make all</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        run: make -j3</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      - name: Ensure the build uses Openssl</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        run: |</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-          ./src/openvpn/openvpn --version</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-          ./src/openvpn/openv=
pn --version | grep -q &quot;library versions: OpenSSL 4.0&quot;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-      - name: configure checks</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: echo &#39;=
RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server_null.rc</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-      - name: make check</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        run: make -j3 check VER=
BOSE=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      ghrep=
o: openssl/openssl</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
     gitref: openssl-4.0.0-beta1</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+      libconfigure: ./Configure --prefix=3D$LIBPREFIX --libdir=
=3D$LIBPREFIX/lib --openssldir=3D$LIBPREFIX -g</span><br><span> </span><br>=
<span>   mbedtls4:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 strategy:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      fail-=
fast: false</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      matr=
ix:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        os: [ubunt=
u-24.04]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sslli=
b: [mbedtls4]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
build: [ normal, asan ]</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        include:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
       - build: asan</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           cflags: &quot;-fsanitize=3Daddress -fno-sanitize-recover=3Dall  =
-fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-fr=
ame-pointer -g -O1&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            cc: clang</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-          - build: norma=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            cflags: =
&quot;-O2 -g&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         ldflags: &quot;&quot;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            cc: gcc</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    name: &quo=
t;${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}}&qu=
ot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ${{ma=
trix.os}}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    env:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-      CFLAGS: ${{ matrix.=
cflags }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      LDFLAG=
S: ${{ matrix.ldflags }}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      CC: ${{matrix.cc}}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-      UBSAN_OPTIONS: print_stacktrace=3D1</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-      PKG_CONFIG_PATH: /opt/mbedtls4/lib/pkgconfi=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uses: ./.githu=
b/workflows/test-ssllib.yml</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    libname: mbedtls</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      ovpnlibname: mbedtls</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+      ovpnlibdesc: mbed TLS 4.</span><br><span>       # versioning=
=3Dsemver-coerced</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
  MBEDTLS_REPO: Mbed-TLS/mbedtls</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-      MBEDTLS_VERSION: v4.0.0</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-      MBEDTLS_INSTALL: /opt/mbedtls4</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    steps:</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-      - name: Install dependencies</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        run: sudo apt update &amp;&amp; sudo apt install -y =
liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka=
-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake au=
toconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      - name: Restore mbed TLS from cache</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        uses: actions/cache@=
...3010...</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        id:=
 mbedtls-cache</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 with:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          path:=
 ${{ env.MBEDTLS_INSTALL }}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-          key: ${{ matrix.os }}-mbedtls-${{matrix.build }}-${{ env.MB=
EDTLS_VERSION }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
 - name: &quot;mbedtls: checkout&quot;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if: steps.mbedtls-cache.outputs.cache-hit !=3D &#3=
9;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        us=
es: actions/checkout@...2998... # v6.0.2</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        with:</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-          path: mbedtls</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-          submodules: recursive</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-          repository: ${{ env.MBEDTLS_REPO }}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-          ref: ${{ env.MBEDT=
LS_VERSION }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - =
uses: lukka/get-cmake@...2999... # v4.2.3</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-      - name: &quot;mbedtls: cmake&quot;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if: steps.mbedtls-cache.outp=
uts.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        run: cmake -B build -DCMAKE_INSTALL_PREFIX=3D${{ env.MB=
EDTLS_INSTAL }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  working-directory: mbedtls</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-      - name: &quot;mbedtls: cmake --build&quot;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        if: steps.mbedtls-cache.outputs.c=
ache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        run: cmake --build build</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        working-directory: mbedtls</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-      - name: &quot;mbedtls: cmake --instal=
l&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: st=
eps.mbedtls-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        run: sudo cmake --install build</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        working-directo=
ry: mbedtls</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - na=
me: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       uses: actions/checkout@...2998... # v6.0.2</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-      - name: autoconf</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        run: autoreconf -fvi</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-      - name: configure</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        run: ./configure --with-crypt=
o-library=3Dmbedtls --enable-werror</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-      - name: make all</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        run: make -j3</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-      - name: Ensure the build uses mbed TLS ${{ env.MBEDTLS=
_VERSION }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ru=
n: |</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ./src/o=
penvpn/openvpn --version</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-          ./src/openvpn/openvpn --version | grep -q &quot;library versio=
ns: mbed TLS 4.&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
      - name: configure checks</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tes=
ts/t_server_null.rc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
    - name: make check</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        run: make -j3 check VERBOSE=3D1</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      ghrepo: Mbed-TLS/mbedtls</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      gitref: v4.0.0</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      libconfigure: cmake -B build -DCMA=
KE_INSTALL_PREFIX=3D$LIBPREFIX</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+      libmake: cmake --build build</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      libinstall: sudo cmake --install build</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      ovpnconfigureenv: =
PKG_CONFIG_PATH=3D$LIBPREFIX/lib/pkgconfig</span><br><span> </span><br><spa=
n>   aws-lc:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    strat=
egy:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      fail-fast: =
false</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      matrix:</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        os: [ubuntu-24.0=
4]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ssllib: [ a=
wslc ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        build: =
[ normal, asan ]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   include:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
- build: asan</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    cflags: &quot;-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fno-op=
timize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-poi=
nter -g -O1&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        ldflags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            cc: clang</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            cxx: clang++</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-          - build: normal</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            cflags: &quo=
t;-O2 -g&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     ldflags: &quot;&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            cc: gcc</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            cxx: c++</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    name: &quot;${{=
matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}}&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    runs-on: ${{matrix.=
os}}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    env:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-      CFLAGS: ${{ matrix.cflag=
s }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      LDFLAGS: ${=
{ matrix.ldflags }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
    CC: ${{matrix.cc}}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-      CXX: ${{matrix.cxx}}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-      UBSAN_OPTIONS: print_stacktrace=3D1</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-      AWS_LC_INSTALL: /opt/aws-lc</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    uses: ./.github/workflows/test-=
ssllib.yml</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    with:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      libname: aws-=
lc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      ovpnlibdesc=
: AWS-LC</span><br><span>       # versioning=3Dsemver-coerced</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-      AWS_LC_REPO: aws/aws-lc</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-      AWS_LC_VERSION: v1.70=
.0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    steps:</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-      - name: Install dependencies</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        run: sudo apt update &amp;&amp=
; sudo apt install -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev l=
inux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 =
python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl=
-genl-3-dev</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - na=
me: Restore AWS-LC from cache</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        uses: actions/cache@...3010...</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        id: aws-lc-cache</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        with:</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-          path: ${{ env.AWS_LC_INSTALL }}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-          key: ${{ matrix.os }}-aws=
-lc-${{matrix.build }}-${{ env.AWS_LC_VERSION }}</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-      - name: &quot;AWS-LC: checkout&quot;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: steps.aws-lc-ca=
che.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        uses: actions/checkout@...2998... # v6.0.2</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        with:</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-          path: aws-lc</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-          repository: ${{ env.AWS=
_LC_REPO }}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
ref: ${{ env.AWS_LC_VERSION }}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-      - uses: lukka/get-cmake@...2999... # v4.2.3</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      - name: &quot;AWS-LC: build&quot=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if: steps.aw=
s-lc-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        run: |</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-          mkdir build</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-          cd build</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-          cmake -GNinja -DCMAKE_BUILD_TYPE=3DRelease -DCMA=
KE_INSTALL_PREFIX=3D&quot;${{ env.AWS_LC_INSTALL }}&quot; -DBUILD_SHARED_LI=
BS=3D1 ../</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          n=
inja install</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        w=
orking-directory: aws-lc</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-      - name: Checkout OpenVPN</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        uses: actions/checkout@...2998... # v6.0.2</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-      - name: autoconf</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        run: autoreconf -fvi</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name: configure wi=
th AWS-LC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run:=
 |</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          OPENSSL_C=
FLAGS=3D&quot;-I${{ env.AWS_LC_INSTALL }}/include&quot; \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-          OPENSSL_LIBS=3D&quot;-L${{ en=
v.AWS_LC_INSTALL }}/lib -lssl -lcrypto&quot; \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-          LDFLAGS=3D&quot;-Wl,-rpath=3D${{ env.AWS=
_LC_INSTALL }}/lib&quot; \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-          ./configure --with-crypto-library=3Dopenssl</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-      - name: make all</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        run: make -j3</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-      - name: Ensure the build uses A=
WS-LC</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        run: |</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-          ./src/openvpn=
/openvpn --version</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
       ./src/openvpn/openvpn --version | grep -q &quot;library versions: AW=
S-LC&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - nam=
e: configure checks</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      run: echo &#39;RUN_SUDO=3D&quot;sudo -E&quot;&#39; &gt;tests/t_server=
_null.rc</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      - name:=
 make check</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ru=
n: make -j3 check VERBOSE=3D1</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+      ghrepo: aws/aws-lc</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+      gitref: v1.70.0</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_T=
YPE=3DRelease -DCMAKE_INSTALL_PREFIX=3D&quot;$LIBPREFIX&quot; -DBUILD_SHARE=
D_LIBS=3D1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      lib=
make: cmake --build build</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      libinstall: sudo cmake --install build</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+      # not ready for --enable-werror</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      ovpnconfigureflags:<=
/span><br><span>diff --git a/.github/workflows/test-ssllib.yml b/.github/wo=
rkflows/test-ssllib.yml</span><br><span>new file mode 100644</span><br><spa=
n>index 0000000..c6a2e44</span><br><span>--- /dev/null</span><br><span>+++ =
b/.github/workflows/test-ssllib.yml</span><br><span>@@ -0,0 +1,117 @@</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+name: test_ssllib</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+on:</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+  workflow_call:</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    inputs:</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+      libname:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     required: true</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        type: string</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+      ovpnlibname:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        type: string</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        default: openssl</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      ovpnlibdesc:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        required: true</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        type: string</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      ghrepo:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        required: true</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        type: string</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+      gitref:</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        required: true</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        type: string</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+      libconfigure:</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        required: true</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        type: string</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      libmake:</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        type: string</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        default: &quot;make -j3&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+      libinstall:</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        type: string</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        default: &quot;sudo make install&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+      ovpnconfigureenv:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        type: string</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        default: &gt;=
-</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          OPENSSL_=
CFLAGS=3D&quot;-I$LIBPREFIX/include&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+          OPENSSL_LIBS=3D&quot;-L$LIBPREFIX/lib -lssl=
 -lcrypto&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
      LDFLAGS=3D&quot;-Wl,-rpath=3D$LIBPREFIX/lib&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+      ovpnconfigureflags:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        type: string</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        default: --enable-werror=
 --with-openssl-engine=3Dno</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+jobs:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+  test_ssllib:</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    strategy:</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+      fail-fast: false</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+      matrix:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        os: [ubuntu-24.04]</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        build: [normal, asan]</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        include:</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+          - build: asan</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            cflags: &=
quot;-fsanitize=3Daddress -fno-sanitize-recover=3Dall  -fno-optimize-siblin=
g-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1&q=
uot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ldf=
lags: -fsanitize=3Daddress -fno-sanitize-recover=3Dall</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            cc: clang</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            cxx: clang++</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          - build: normal</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            cflags: &quot;-=
O2 -g&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    ldflags: &quot;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            cc: gcc</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            cxx: g++</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    name: &q=
uot;${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{inputs.libname}}=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    runs-on: =
${{matrix.os}}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
nv:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      CFLAGS: ${=
{matrix.cflags}}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   LDFLAGS: ${{matrix.ldflags}}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      CC: ${{matrix.cc}}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+      CXX: ${{matrix.cxx}}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+      UBSAN_OPTIONS: print_stacktrace=3D1</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+      LIBPREFIX: /opt/${{inpu=
ts.libname}}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    steps:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      - name: Install dependencies<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: sudo ap=
t update &amp;&amp; sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev=
 linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool autom=
ake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+      - name: Restore ${{inputs.libname}=
} from cache</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 uses: actions/cache@...3024... # v5.0.5</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        id: ssllib-cache</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        with:</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+          path: ${{env.LIBPREFIX}}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+          key: ${{matrix.os}}-${{inputs.=
libname}}-${{matrix.build }}-${{inputs.gitref}}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+      - name: &quot;${{inputs.libname}}: checko=
ut&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if:=
 steps.ssllib-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...3007...=
8... # v6.0.2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  with:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          su=
bmodules: recursive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
          path: ${{inputs.libname}}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+          repository: ${{inputs.ghrepo}}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+          ref: ${{inputs.gitref}}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: &quot;${{i=
nputs.libname}}: configure&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        if: steps.ssllib-cache.outputs.cache-hit !=3D &#39;tru=
e&#39;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        run: =
${{inputs.libconfigure}}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        working-directory: ${{inputs.libname}}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+      - name: &quot;${{inputs.libname}}: =
build&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if: steps.ssllib-cache.outputs.cache-hit !=3D &#39;true&#39;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        run: ${{inputs.libmake}}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        working-direc=
tory: ${{inputs.libname}}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+      - name: &quot;${{inputs.libname}}: install&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if: steps.ssllib-cache.out=
puts.cache-hit !=3D &#39;true&#39;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        run: ${{inputs.libinstall}}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        working-directory: ${{inputs.libname=
}}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: Run=
 ldconfig</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ru=
n: sudo ldconfig</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
   - name: &quot;OpenVPN: checkout&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        uses: actions/checkout@...2998... # v6.0.2</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: &quot;Ope=
nVPN: autoreconf&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        run: autoreconf -fvi</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+      - name: &quot;OpenVPN: configure&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        run: |</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+          ${{inputs.ovpnconfigureenv}} \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ./configur=
e --with-crypto-library=3D${{inputs.ovpnlibname}} ${{inputs.ovpnconfigurefl=
ags}}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      - name: =
&quot;OpenVPN: build&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        run: make -j3</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+      - name: Ensure the build uses ${{inputs.libname}}</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        run: |</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+          ./src/openvpn/openvpn --v=
ersion</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          ./s=
rc/openvpn/openvpn --version | grep -q &quot;library versions: ${{inputs.ov=
pnlibdesc}}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
    - name: &quot;OpenVPN: configure checks&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        run: echo &#39;RUN_SUDO=3D&quot;sudo =
-E&quot;&#39; &gt;tests/t_server_null.rc</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+      - name: &quot;OpenVPN: make check&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        run: make -j3 check =
VERBOSE=3D1</span><br><span>diff --git a/renovate.json b/renovate.json</spa=
n><br><span>index f9c62c4..809ac3f 100644</span><br><span>--- a/renovate.js=
on</span><br><span>+++ b/renovate.json</span><br><span>@@ -40,7 +40,7 @@</s=
pan><br><span>                 &quot;/^\\.github/workflows/.+\\.ya?ml$/&quo=
t;</span><br><span>             ],</span><br><span>             &quot;match=
Strings&quot;: [</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           &quot;versioning=3D(?&lt;versioning&gt;.*?)\\n\\s*.*?_REPO:\\s*(=
?&lt;depName&gt;.*?)\\n\\s*.*?_VERSION:\\s*(?&lt;currentValue&gt;.*?)\\n&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
&quot;versioning=3D(?&lt;versioning&gt;.*?)\\n\\s*ghrepo:\\s*(?&lt;depName&=
gt;.*?)\\n\\s*gitrepo:\\s*(?&lt;currentValue&gt;.*?)\\n&quot;</span><br><sp=
an>             ],</span><br><span>             &quot;datasourceTemplate&qu=
ot;: &quot;github-tags&quot;</span><br><span>         }</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1630?usp=3Demail">change 1630</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1630?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d89016ccae297cfa596897c11a=
518f1ffbe3dc8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1630 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--rSInf1T+uDg=--

