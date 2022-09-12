From: Arne Schwabe <arne@...1227...>
Date: Mon, 12 Sep 2022 13:07:45 +0200
Message-Id: <20220912110745.2332513-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add wolfSSL to github actions
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

This builds wolfSSL as part of the github actions with gcc and clang+asan
and will allow us to see how well wolfSSL is maintaining the support in
OpenVPN.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 69 ++++++++++++++++++++++++++++++++++++
 1 file changed, 69 insertions(+)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index f34f6a266..2feb7e671 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -34,6 +34,75 @@ jobs:
       - name: Set job status
         run: test ! -s uncrustify-changes.patch
         working-directory: openvpn
+  wolfssl:
+    strategy:
+      fail-fast: false
+      matrix:
+        os: [ubuntu-20.04]
+        ssllib: [wolfssl]
+        build: [normal, asan ]
+        include:
+        - build: asan
+          cflags: "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+          ldflags: -fsanitize=address
+          cc: clang
+        - build: normal
+          cflags: "-O2 -g"
+          ldflags: ""
+          configureflags: ""
+          cc: gcc
+
+    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}}"
+    runs-on: ${{matrix.os}}
+    env:
+      CFLAGS: ${{ matrix.cflags }}
+      LDFLAGS: ${{ matrix.ldflags }}
+      CC: ${{matrix.cc}}
+
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y build-essential liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev pkg-config libcap-ng-dev
+
+      - name: Cache dependencies
+        id: cache
+        uses: actions/cache@...2689...
+        with:
+          path: '/opt/wolfssl'
+          key: ${{ matrix.build }}-wolfSSL
+      - name: "wolfSSL: checkout"
+        if: steps.cache.outputs.cache-hit != 'true'
+        uses: actions/checkout@...2689...
+        with:
+          path: wolfssl
+          repository: wolfSSL/wolfssl
+      - name: "wolfSSL: autoconf"
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: autoreconf -fvi
+        working-directory: wolfssl
+      - name: "wolfSSL: configure"
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: ./configure --enable-openvpn --prefix=/opt/wolfssl
+        working-directory: wolfssl
+      - name: "wolfSSL: make all"
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: make -j3
+        working-directory: wolfssl
+      - name: "wolfSSL: make install"
+        if: steps.cache.outputs.cache-hit != 'true'
+        run: sudo make install
+        working-directory: wolfssl
+      - name: "ldconfig"
+        run: sudo ldconfig
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2689...
+      - name: autoconf
+        run: autoreconf -fvi
+      - name: configure ${{matrix.configureflag}}
+        run: PKG_CONFIG_PATH=/opt/wolfssl/lib/pkgconfig ./configure --with-crypto-library=${{matrix.ssllib}} --enable-werror
+      - name: make all
+        run: make -j3
+      - name: make check
+        run: make check
 
   mingw:
     strategy:
-- 
2.32.1 (Apple Git-133)


