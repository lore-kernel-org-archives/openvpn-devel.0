From: Gert Doering <gert@...1296...>
Date: Mon, 20 Apr 2026 18:07:27 +0200
Message-ID: <20260420160732.9492-1-gert@...1296...>
In-Reply-To: <gerrit.1776685712000.I3d89016ccae297cfa596897c11a518f1ffbe3dc8@...2715...>
References: <gerrit.1776685712000.I3d89016ccae297cfa596897c11a518f1ffbe3dc8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] GHA: Factor out building SSL libs to a
 reusable workflow
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

We amassed a lot of code duplication there. Make
it easier to track the differences between the libraries.

Change-Id: I3d89016ccae297cfa596897c11a518f1ffbe3dc8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1630
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1630
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
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
-        configureflags: ["--with-openssl-engine=no"]
-        include:
-          - build: asan
-            cflags: "-fsanitize=address -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=address -fno-sanitize-recover=all
-            cc: clang
-          - build: normal
-            cflags: "-O2 -g"
-            ldflags: ""
-            cc: gcc
-
-    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}}"
-    runs-on: ${{matrix.os}}
-    env:
-      CFLAGS: ${{ matrix.cflags }}
-      LDFLAGS: ${{ matrix.ldflags }}
-      CC: ${{matrix.cc}}
-      UBSAN_OPTIONS: print_stacktrace=1
+    uses: ./.github/workflows/test-ssllib.yml
+    with:
+      libname: libressl
+      ovpnlibdesc: LibreSSL
       # versioning=semver-coerced
-      LIBRESSL_REPO: libressl/portable
-      LIBRESSL_VERSION: v4.2.1
-      LIBRESSL_INSTALL: /opt/libressl
+      ghrepo: libressl/portable
+      gitref: v4.2.1
+      libconfigure: "LIBRESSL_GIT_OPTIONS=--no-single-branch ./autogen.sh && ./configure --prefix=$LIBPREFIX"
 
-    steps:
-      - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
-      - name: Restore libressl from cache
-        uses: actions/cache@...3010...
-        id: libressl-cache
-        with:
-          path: ${{ env.LIBRESSL_INSTALL }}
-          key: ${{ matrix.os }}-libressl-${{matrix.build }}-${{ env.LIBRESSL_VERSION }}
-      - name: "libressl: checkout"
-        if: steps.libressl-cache.outputs.cache-hit != 'true'
-        uses: actions/checkout@...2998... # v6.0.2
-        with:
-          path: libressl
-          repository: ${{ env.LIBRESSL_REPO }}
-          ref: ${{ env.LIBRESSL_VERSION }}
-      - name: "libressl: autogen.sh"
-        if: steps.libressl-cache.outputs.cache-hit != 'true'
-        env:
-          LIBRESSL_GIT_OPTIONS: "--no-single-branch"
-        run: ./autogen.sh
-        working-directory: libressl
-      - name: "libressl: configure"
-        if: steps.libressl-cache.outputs.cache-hit != 'true'
-        run: ./configure --prefix=${{ env.LIBRESSL_INSTALL }}
-        working-directory: libressl
-      - name: "libressl: make all"
-        if: steps.libressl-cache.outputs.cache-hit != 'true'
-        run: make -j3
-        working-directory: libressl
-      - name: "libressl: make install"
-        if: steps.libressl-cache.outputs.cache-hit != 'true'
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
-          OPENSSL_CFLAGS="-I${{ env.LIBRESSL_INSTALL }}/include" \
-          OPENSSL_LIBS="-L${{ env.LIBRESSL_INSTALL }}/lib -lssl -lcrypto" \
-          LDFLAGS="-Wl,-rpath=${{ env.LIBRESSL_INSTALL }}/lib" \
-          ./configure --with-crypto-library=openssl --enable-werror ${{matrix.configureflags}}
-      - name: make all
-        run: make -j3
-      - name: Ensure the build uses LibreSSL
-        run: |
-          ./src/openvpn/openvpn --version
-          ./src/openvpn/openvpn --version | grep -q "library versions: LibreSSL"
-      - name: configure checks
-        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
-      - name: make check
-        run: make -j3 check VERBOSE=1
-
-  openssl:
-    strategy:
-      fail-fast: false
-      matrix:
-        os: [ubuntu-24.04]
-        ssllib: [openssl]
-        build: [ normal, asan ]
-        configureflags: ["--with-openssl-engine=no"]
-        include:
-          - build: asan
-            cflags: "-fsanitize=address -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=address -fno-sanitize-recover=all
-            cc: clang
-          - build: normal
-            cflags: "-O2 -g"
-            ldflags: ""
-            cc: gcc
-
-    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}} - 4.0"
-    runs-on: ${{matrix.os}}
-    env:
-      CFLAGS: ${{ matrix.cflags }}
-      LDFLAGS: ${{ matrix.ldflags }}
-      CC: ${{matrix.cc}}
-      UBSAN_OPTIONS: print_stacktrace=1
+  openssl4:
+    uses: ./.github/workflows/test-ssllib.yml
+    with:
+      libname: openssl
+      ovpnlibdesc: OpenSSL 4.
       # versioning=semver-coerced
-      OPENSSL_REPO: openssl/openssl
-      OPENSSL_VERSION: openssl-4.0.0-beta1
-      OPENSSL_INSTALL: /opt/openssl
-
-    steps:
-      - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
-      - name: Restore OpenSSL 4.0 from cache
-        uses: actions/cache@...3010...
-        id: openssl-cache
-        with:
-          path: ${{ env.OPENSSL_INSTALL }}
-          key: ${{ matrix.os }}-openssl-${{matrix.build }}-${{ env.OPENSSL_VERSION }}
-      - name: "openssl: checkout"
-        if: steps.openssl-cache.outputs.cache-hit != 'true'
-        uses: actions/checkout@...2998... # v6.0.2
-        with:
-          path: openssl
-          repository: ${{ env.OPENSSL_REPO }}
-          ref: ${{ env.OPENSSL_VERSION }}
-      - name: "openssl: configure"
-        if: steps.openssl-cache.outputs.cache-hit != 'true'
-        run: ./Configure  --prefix=${{ env.OPENSSL_INSTALL }} --libdir=${{ env.OPENSSL_INSTALL }}/lib --openssldir=${{ env.OPENSSL_INSTALL }} -g
-        working-directory: openssl
-      - name: "openssl: make all"
-        if: steps.openssl-cache.outputs.cache-hit != 'true'
-        run: make -j3
-        working-directory: openssl
-      - name: "openssl: make install"
-        if: steps.openssl-cache.outputs.cache-hit != 'true'
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
-          OPENSSL_CFLAGS="-I${{ env.OPENSSL_INSTALL }}/include" \
-          OPENSSL_LIBS="-L${{ env.OPENSSL_INSTALL }}/lib -lssl -lcrypto" \
-          LDFLAGS="-Wl,-rpath=${{ env.OPENSSL_INSTALL }}/lib" \
-          ./configure --with-crypto-library=openssl --enable-werror ${{matrix.configureflags}}
-      - name: make all
-        run: make -j3
-      - name: Ensure the build uses Openssl
-        run: |
-          ./src/openvpn/openvpn --version
-          ./src/openvpn/openvpn --version | grep -q "library versions: OpenSSL 4.0"
-      - name: configure checks
-        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
-      - name: make check
-        run: make -j3 check VERBOSE=1
+      ghrepo: openssl/openssl
+      gitref: openssl-4.0.0-beta1
+      libconfigure: ./Configure --prefix=$LIBPREFIX --libdir=$LIBPREFIX/lib --openssldir=$LIBPREFIX -g
 
   mbedtls4:
-    strategy:
-      fail-fast: false
-      matrix:
-        os: [ubuntu-24.04]
-        ssllib: [mbedtls4]
-        build: [ normal, asan ]
-        include:
-          - build: asan
-            cflags: "-fsanitize=address -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=address -fno-sanitize-recover=all
-            cc: clang
-          - build: normal
-            cflags: "-O2 -g"
-            ldflags: ""
-            cc: gcc
-
-    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}}"
-    runs-on: ${{matrix.os}}
-    env:
-      CFLAGS: ${{ matrix.cflags }}
-      LDFLAGS: ${{ matrix.ldflags }}
-      CC: ${{matrix.cc}}
-      UBSAN_OPTIONS: print_stacktrace=1
-      PKG_CONFIG_PATH: /opt/mbedtls4/lib/pkgconfig
+    uses: ./.github/workflows/test-ssllib.yml
+    with:
+      libname: mbedtls
+      ovpnlibname: mbedtls
+      ovpnlibdesc: mbed TLS 4.
       # versioning=semver-coerced
-      MBEDTLS_REPO: Mbed-TLS/mbedtls
-      MBEDTLS_VERSION: v4.0.0
-      MBEDTLS_INSTALL: /opt/mbedtls4
-
-    steps:
-      - name: Install dependencies
-        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
-      - name: Restore mbed TLS from cache
-        uses: actions/cache@...3010...
-        id: mbedtls-cache
-        with:
-          path: ${{ env.MBEDTLS_INSTALL }}
-          key: ${{ matrix.os }}-mbedtls-${{matrix.build }}-${{ env.MBEDTLS_VERSION }}
-      - name: "mbedtls: checkout"
-        if: steps.mbedtls-cache.outputs.cache-hit != 'true'
-        uses: actions/checkout@...2998... # v6.0.2
-        with:
-          path: mbedtls
-          submodules: recursive
-          repository: ${{ env.MBEDTLS_REPO }}
-          ref: ${{ env.MBEDTLS_VERSION }}
-      - uses: lukka/get-cmake@...2999... # v4.2.3
-      - name: "mbedtls: cmake"
-        if: steps.mbedtls-cache.outputs.cache-hit != 'true'
-        run: cmake -B build -DCMAKE_INSTALL_PREFIX=${{ env.MBEDTLS_INSTAL }}
-        working-directory: mbedtls
-      - name: "mbedtls: cmake --build"
-        if: steps.mbedtls-cache.outputs.cache-hit != 'true'
-        run: cmake --build build
-        working-directory: mbedtls
-      - name: "mbedtls: cmake --install"
-        if: steps.mbedtls-cache.outputs.cache-hit != 'true'
-        run: sudo cmake --install build
-        working-directory: mbedtls
-      - name: Checkout OpenVPN
-        uses: actions/checkout@...2998... # v6.0.2
-      - name: autoconf
-        run: autoreconf -fvi
-      - name: configure
-        run: ./configure --with-crypto-library=mbedtls --enable-werror
-      - name: make all
-        run: make -j3
-      - name: Ensure the build uses mbed TLS ${{ env.MBEDTLS_VERSION }}
-        run: |
-          ./src/openvpn/openvpn --version
-          ./src/openvpn/openvpn --version | grep -q "library versions: mbed TLS 4."
-      - name: configure checks
-        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
-      - name: make check
-        run: make -j3 check VERBOSE=1
+      ghrepo: Mbed-TLS/mbedtls
+      gitref: v4.0.0
+      libconfigure: cmake -B build -DCMAKE_INSTALL_PREFIX=$LIBPREFIX
+      libmake: cmake --build build
+      libinstall: sudo cmake --install build
+      ovpnconfigureenv: PKG_CONFIG_PATH=$LIBPREFIX/lib/pkgconfig
 
   aws-lc:
-    strategy:
-      fail-fast: false
-      matrix:
-        os: [ubuntu-24.04]
-        ssllib: [ awslc ]
-        build: [ normal, asan ]
-        include:
-          - build: asan
-            cflags: "-fsanitize=address -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=address -fno-sanitize-recover=all
-            cc: clang
-            cxx: clang++
-          - build: normal
-            cflags: "-O2 -g"
-            ldflags: ""
-            cc: gcc
-            cxx: c++
-
-    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}}"
-    runs-on: ${{matrix.os}}
-    env:
-      CFLAGS: ${{ matrix.cflags }}
-      LDFLAGS: ${{ matrix.ldflags }}
-      CC: ${{matrix.cc}}
-      CXX: ${{matrix.cxx}}
-      UBSAN_OPTIONS: print_stacktrace=1
-      AWS_LC_INSTALL: /opt/aws-lc
+    uses: ./.github/workflows/test-ssllib.yml
+    with:
+      libname: aws-lc
+      ovpnlibdesc: AWS-LC
       # versioning=semver-coerced
-      AWS_LC_REPO: aws/aws-lc
-      AWS_LC_VERSION: v1.70.0
-
-    steps:
-      - name: Install dependencies
-        run: sudo apt update && sudo apt install -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
-      - name: Restore AWS-LC from cache
-        uses: actions/cache@...3010...
-        id: aws-lc-cache
-        with:
-          path: ${{ env.AWS_LC_INSTALL }}
-          key: ${{ matrix.os }}-aws-lc-${{matrix.build }}-${{ env.AWS_LC_VERSION }}
-      - name: "AWS-LC: checkout"
-        if: steps.aws-lc-cache.outputs.cache-hit != 'true'
-        uses: actions/checkout@...2998... # v6.0.2
-        with:
-          path: aws-lc
-          repository: ${{ env.AWS_LC_REPO }}
-          ref: ${{ env.AWS_LC_VERSION }}
-      - uses: lukka/get-cmake@...2999... # v4.2.3
-      - name: "AWS-LC: build"
-        if: steps.aws-lc-cache.outputs.cache-hit != 'true'
-        run: |
-          mkdir build
-          cd build
-          cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="${{ env.AWS_LC_INSTALL }}" -DBUILD_SHARED_LIBS=1 ../
-          ninja install
-        working-directory: aws-lc
-      - name: Checkout OpenVPN
-        uses: actions/checkout@...2998... # v6.0.2
-      - name: autoconf
-        run: autoreconf -fvi
-      - name: configure with AWS-LC
-        run: |
-          OPENSSL_CFLAGS="-I${{ env.AWS_LC_INSTALL }}/include" \
-          OPENSSL_LIBS="-L${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto" \
-          LDFLAGS="-Wl,-rpath=${{ env.AWS_LC_INSTALL }}/lib" \
-          ./configure --with-crypto-library=openssl
-      - name: make all
-        run: make -j3
-      - name: Ensure the build uses AWS-LC
-        run: |
-          ./src/openvpn/openvpn --version
-          ./src/openvpn/openvpn --version | grep -q "library versions: AWS-LC"
-      - name: configure checks
-        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
-      - name: make check
-        run: make -j3 check VERBOSE=1
+      ghrepo: aws/aws-lc
+      gitref: v1.70.0
+      libconfigure: cmake -B build -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="$LIBPREFIX" -DBUILD_SHARED_LIBS=1
+      libmake: cmake --build build
+      libinstall: sudo cmake --install build
+      # not ready for --enable-werror
+      ovpnconfigureflags:
diff --git a/.github/workflows/test-ssllib.yml b/.github/workflows/test-ssllib.yml
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
+          OPENSSL_CFLAGS="-I$LIBPREFIX/include"
+          OPENSSL_LIBS="-L$LIBPREFIX/lib -lssl -lcrypto"
+          LDFLAGS="-Wl,-rpath=$LIBPREFIX/lib"
+      ovpnconfigureflags:
+        type: string
+        default: --enable-werror --with-openssl-engine=no
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
+            cflags: "-fsanitize=address -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+            ldflags: -fsanitize=address -fno-sanitize-recover=all
+            cc: clang
+            cxx: clang++
+          - build: normal
+            cflags: "-O2 -g"
+            ldflags: ""
+            cc: gcc
+            cxx: g++
+
+    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{inputs.libname}}"
+    runs-on: ${{matrix.os}}
+    env:
+      CFLAGS: ${{matrix.cflags}}
+      LDFLAGS: ${{matrix.ldflags}}
+      CC: ${{matrix.cc}}
+      CXX: ${{matrix.cxx}}
+      UBSAN_OPTIONS: print_stacktrace=1
+      LIBPREFIX: /opt/${{inputs.libname}}
+
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore ${{inputs.libname}} from cache
+        uses: actions/cache@...3024... # v5.0.5
+        id: ssllib-cache
+        with:
+          path: ${{env.LIBPREFIX}}
+          key: ${{matrix.os}}-${{inputs.libname}}-${{matrix.build }}-${{inputs.gitref}}
+      - name: "${{inputs.libname}}: checkout"
+        if: steps.ssllib-cache.outputs.cache-hit != 'true'
+        uses: actions/checkout@...2998... # v6.0.2
+        with:
+          submodules: recursive
+          path: ${{inputs.libname}}
+          repository: ${{inputs.ghrepo}}
+          ref: ${{inputs.gitref}}
+      - name: "${{inputs.libname}}: configure"
+        if: steps.ssllib-cache.outputs.cache-hit != 'true'
+        run: ${{inputs.libconfigure}}
+        working-directory: ${{inputs.libname}}
+      - name: "${{inputs.libname}}: build"
+        if: steps.ssllib-cache.outputs.cache-hit != 'true'
+        run: ${{inputs.libmake}}
+        working-directory: ${{inputs.libname}}
+      - name: "${{inputs.libname}}: install"
+        if: steps.ssllib-cache.outputs.cache-hit != 'true'
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
+          ./configure --with-crypto-library=${{inputs.ovpnlibname}} ${{inputs.ovpnconfigureflags}}
+      - name: "OpenVPN: build"
+        run: make -j3
+      - name: Ensure the build uses ${{inputs.libname}}
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: ${{inputs.ovpnlibdesc}}"
+      - name: "OpenVPN: configure checks"
+        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
+      - name: "OpenVPN: make check"
+        run: make -j3 check VERBOSE=1
diff --git a/renovate.json b/renovate.json
index f9c62c4..809ac3f 100644
--- a/renovate.json
+++ b/renovate.json
@@ -40,7 +40,7 @@
                 "/^\\.github/workflows/.+\\.ya?ml$/"
             ],
             "matchStrings": [
-                "versioning=(?<versioning>.*?)\\n\\s*.*?_REPO:\\s*(?<depName>.*?)\\n\\s*.*?_VERSION:\\s*(?<currentValue>.*?)\\n"
+                "versioning=(?<versioning>.*?)\\n\\s*ghrepo:\\s*(?<depName>.*?)\\n\\s*gitrepo:\\s*(?<currentValue>.*?)\\n"
             ],
             "datasourceTemplate": "github-tags"
         }

