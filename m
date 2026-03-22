From: Gert Doering <gert@...1296...>
Date: Sun, 22 Mar 2026 11:38:13 +0100
Message-ID: <20260322103820.4717-1-gert@...1296...>
In-Reply-To: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
References: <gerrit.1773408066000.Ie21fdb01b843a7af09fcd469b08c775eee7e3745@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] GHA: Cache built crypto libraries
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

From: Arne Schwabe <arne@...1227...>

Semver code changes by Frank

Change-Id: Ie21fdb01b843a7af09fcd469b08c775eee7e3745
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1577
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1577
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index dd8e472..186662d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -328,29 +328,43 @@
       LDFLAGS: ${{ matrix.ldflags }}
       CC: ${{matrix.cc}}
       UBSAN_OPTIONS: print_stacktrace=1
+      # versioning=semver-coerced
+      LIBRESSL_REPO: libressl/portable
+      LIBRESSL_VERSION: v4.2.1
+      LIBRESSL_INSTALL: /opt/libressl
 
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore libressl from cache
+        uses: actions/cache@...3010...
+        id: libressl-cache
+        with:
+          path: ${{ env.LIBRESSL_INSTALL }}
+          key: ${{ matrix.os }}-libressl-${{matrix.build }}-${{ env.LIBRESSL_VERSION }}
       - name: "libressl: checkout"
+        if: steps.libressl-cache.outputs.cache-hit != 'true'
         uses: actions/checkout@...2998... # v6.0.2
         with:
           path: libressl
-          # versioning=semver-coerced
-          repository: libressl/portable
-          ref: v4.2.1
+          repository: ${{ env.LIBRESSL_REPO }}
+          ref: ${{ env.LIBRESSL_VERSION }}
       - name: "libressl: autogen.sh"
+        if: steps.libressl-cache.outputs.cache-hit != 'true'
         env:
           LIBRESSL_GIT_OPTIONS: "--no-single-branch"
         run: ./autogen.sh
         working-directory: libressl
       - name: "libressl: configure"
-        run: ./configure
+        if: steps.libressl-cache.outputs.cache-hit != 'true'
+        run: ./configure --prefix=${{ env.LIBRESSL_INSTALL }}
         working-directory: libressl
       - name: "libressl: make all"
+        if: steps.libressl-cache.outputs.cache-hit != 'true'
         run: make -j3
         working-directory: libressl
       - name: "libressl: make install"
+        if: steps.libressl-cache.outputs.cache-hit != 'true'
         run: sudo make install
         working-directory: libressl
       - name: "ldconfig"
@@ -360,7 +374,11 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --with-crypto-library=openssl ${{matrix.configureflags}} --enable-werror
+        run: |
+          OPENSSL_CFLAGS="-I${{ env.LIBRESSL_INSTALL }}/include" \
+          OPENSSL_LIBS="-L${{ env.LIBRESSL_INSTALL }}/lib -lssl -lcrypto" \
+          LDFLAGS="-Wl,-rpath=${{ env.LIBRESSL_INSTALL }}/lib" \
+          ./configure --with-crypto-library=openssl --enable-werror ${{matrix.configureflags}}
       - name: make all
         run: make -j3
       - name: Ensure the build uses LibreSSL
@@ -396,27 +414,41 @@
       LDFLAGS: ${{ matrix.ldflags }}
       CC: ${{matrix.cc}}
       UBSAN_OPTIONS: print_stacktrace=1
+      PKG_CONFIG_PATH: /opt/mbedtls4/lib/pkgconfig
+      # versioning=semver-coerced
+      MBEDTLS_REPO: Mbed-TLS/mbedtls
+      MBEDTLS_VERSION: v4.0.0
+      MBEDTLS_INSTALL: /opt/mbedtls4
 
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore mbed TLS from cache
+        uses: actions/cache@...3010...
+        id: mbedtls-cache
+        with:
+          path: ${{ env.MBEDTLS_INSTALL }}
+          key: ${{ matrix.os }}-mbedtls-${{matrix.build }}-${{ env.MBEDTLS_VERSION }}
       - name: "mbedtls: checkout"
+        if: steps.mbedtls-cache.outputs.cache-hit != 'true'
         uses: actions/checkout@...2998... # v6.0.2
         with:
           path: mbedtls
           submodules: recursive
-          # versioning=semver-coerced
-          repository: Mbed-TLS/mbedtls
-          ref: v4.0.0
+          repository: ${{ env.MBEDTLS_REPO }}
+          ref: ${{ env.MBEDTLS_VERSION }}
       - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "mbedtls: cmake"
-        run: cmake -B build
+        if: steps.mbedtls-cache.outputs.cache-hit != 'true'
+        run: cmake -B build -DCMAKE_INSTALL_PREFIX=${{ env.MBEDTLS_INSTAL }}
         working-directory: mbedtls
       - name: "mbedtls: cmake --build"
+        if: steps.mbedtls-cache.outputs.cache-hit != 'true'
         run: cmake --build build
         working-directory: mbedtls
       - name: "mbedtls: cmake --install"
-        run: sudo cmake --install build --prefix /usr
+        if: steps.mbedtls-cache.outputs.cache-hit != 'true'
+        run: sudo cmake --install build
         working-directory: mbedtls
       - name: Checkout OpenVPN
         uses: actions/checkout@...2998... # v6.0.2
@@ -426,7 +458,7 @@
         run: ./configure --with-crypto-library=mbedtls --enable-werror
       - name: make all
         run: make -j3
-      - name: Ensure the build uses mbed TLS 4.x
+      - name: Ensure the build uses mbed TLS ${{ env.MBEDTLS_VERSION }}
         run: |
           ./src/openvpn/openvpn --version
           ./src/openvpn/openvpn --version | grep -q "library versions: mbed TLS 4."
@@ -463,19 +495,29 @@
       CXX: ${{matrix.cxx}}
       UBSAN_OPTIONS: print_stacktrace=1
       AWS_LC_INSTALL: /opt/aws-lc
+      # versioning=semver-coerced
+      AWS_LC_REPO: aws/aws-lc
+      AWS_LC_VERSION: v1.70.0
 
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y gcc golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore AWS-LC from cache
+        uses: actions/cache@...3010...
+        id: aws-lc-cache
+        with:
+          path: ${{ env.AWS_LC_INSTALL }}
+          key: ${{ matrix.os }}-aws-lc-${{matrix.build }}-${{ env.AWS_LC_VERSION }}
       - name: "AWS-LC: checkout"
+        if: steps.aws-lc-cache.outputs.cache-hit != 'true'
         uses: actions/checkout@...2998... # v6.0.2
         with:
           path: aws-lc
-          # versioning=semver-coerced
-          repository: aws/aws-lc
-          ref: v1.70.0
+          repository: ${{ env.AWS_LC_REPO }}
+          ref: ${{ env.AWS_LC_VERSION }}
       - uses: lukka/get-cmake@...2999... # v4.2.3
       - name: "AWS-LC: build"
+        if: steps.aws-lc-cache.outputs.cache-hit != 'true'
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
-                "versioning=(?<versioning>.*?)\\n\\s*repository:\\s*(?<depName>.*?)\\n\\s*ref:\\s*(?<currentValue>.*?)\\n"
+                "versioning=(?<versioning>.*?)\\n\\s*.*?_REPO:\\s*(?<depName>.*?)\\n\\s*.*?_VERSION:\\s*(?<currentValue>.*?)\\n"
             ],
             "datasourceTemplate": "github-tags"
         }
+
     ]
 }

