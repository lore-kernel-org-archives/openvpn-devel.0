From: Gert Doering <gert@...1296...>
Date: Fri, 17 Apr 2026 13:09:36 +0200
Message-ID: <20260417110942.16538-1-gert@...1296...>
In-Reply-To: <gerrit.1774997396000.Ic9c993cb8dcfedfd6f99f416c286e0968eb45255@...2715...>
References: <gerrit.1774997396000.Ic9c993cb8dcfedfd6f99f416c286e0968eb45255@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] GHA: Add OpenSSL 4.0 build
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

Change-Id: Ic9c993cb8dcfedfd6f99f416c286e0968eb45255
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1601
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1601
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 186662d..365e72a 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -390,6 +390,87 @@
       - name: make check
         run: make -j3 check VERBOSE=1
 
+  openssl:
+    strategy:
+      fail-fast: false
+      matrix:
+        os: [ubuntu-24.04]
+        ssllib: [openssl]
+        build: [ normal, asan ]
+        configureflags: ["--with-openssl-engine=no"]
+        include:
+          - build: asan
+            cflags: "-fsanitize=address -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+            ldflags: -fsanitize=address -fno-sanitize-recover=all
+            cc: clang
+          - build: normal
+            cflags: "-O2 -g"
+            ldflags: ""
+            cc: gcc
+
+    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}} - 4.0"
+    runs-on: ${{matrix.os}}
+    env:
+      CFLAGS: ${{ matrix.cflags }}
+      LDFLAGS: ${{ matrix.ldflags }}
+      CC: ${{matrix.cc}}
+      UBSAN_OPTIONS: print_stacktrace=1
+      # versioning=semver-coerced
+      OPENSSL_REPO: openssl/openssl
+      OPENSSL_VERSION: openssl-4.0.0-beta1
+      OPENSSL_INSTALL: /opt/openssl
+
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: Restore OpenSSL 4.0 from cache
+        uses: actions/cache@...3010...
+        id: openssl-cache
+        with:
+          path: ${{ env.OPENSSL_INSTALL }}
+          key: ${{ matrix.os }}-openssl-${{matrix.build }}-${{ env.OPENSSL_VERSION }}
+      - name: "openssl: checkout"
+        if: steps.openssl-cache.outputs.cache-hit != 'true'
+        uses: actions/checkout@...2998... # v6.0.2
+        with:
+          path: openssl
+          repository: ${{ env.OPENSSL_REPO }}
+          ref: ${{ env.OPENSSL_VERSION }}
+      - name: "openssl: configure"
+        if: steps.openssl-cache.outputs.cache-hit != 'true'
+        run: ./Configure  --prefix=${{ env.OPENSSL_INSTALL }} --libdir=${{ env.OPENSSL_INSTALL }}/lib --openssldir=${{ env.OPENSSL_INSTALL }} -g
+        working-directory: openssl
+      - name: "openssl: make all"
+        if: steps.openssl-cache.outputs.cache-hit != 'true'
+        run: make -j3
+        working-directory: openssl
+      - name: "openssl: make install"
+        if: steps.openssl-cache.outputs.cache-hit != 'true'
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
+          OPENSSL_CFLAGS="-I${{ env.OPENSSL_INSTALL }}/include" \
+          OPENSSL_LIBS="-L${{ env.OPENSSL_INSTALL }}/lib -lssl -lcrypto" \
+          LDFLAGS="-Wl,-rpath=${{ env.OPENSSL_INSTALL }}/lib" \
+          ./configure --with-crypto-library=openssl --enable-werror ${{matrix.configureflags}}
+      - name: make all
+        run: make -j3
+      - name: Ensure the build uses Openssl
+        run: |
+          ./src/openvpn/openvpn --version
+          ./src/openvpn/openvpn --version | grep -q "library versions: OpenSSL 4.0"
+      - name: configure checks
+        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
+      - name: make check
+        run: make -j3 check VERBOSE=1
+
   mbedtls4:
     strategy:
       fail-fast: false

