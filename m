From: Frank Lichtenheld <frank@...2641...>
Date: Mon, 30 Oct 2023 18:13:15 +0100
Message-Id: <20231030171315.68933-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add mbedtls3 GHA build
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

Change-Id: I9edb3e336bb9efe6f555fa6b323a4a0a944f683d
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .github/workflows/build.yaml | 51 ++++++++++++++++++++++++++++++++++++
 1 file changed, 51 insertions(+)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 60d3da5e..cd72f3db 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -360,3 +360,54 @@ jobs:
         run: make -j3
       - name: make check
         run: make check
+
+  mbedtls3:
+    strategy:
+      fail-fast: false
+      matrix:
+        os: [ubuntu-22.04]
+        ssllib: [mbedtls3]
+        build: [ normal, asan ]
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
+    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}}"
+    runs-on: ${{matrix.os}}
+    env:
+      CFLAGS: ${{ matrix.cflags }}
+      LDFLAGS: ${{ matrix.ldflags }}
+      CC: ${{matrix.cc}}
+      UBSAN_OPTIONS: print_stacktrace=1
+
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: "mbedtls: checkout"
+        uses: actions/checkout@...2689...
+        with:
+          path: mbedtls
+          repository: Mbed-TLS/mbedtls
+          ref: v3.5.0
+      - name: "mbedtls: make no_test"
+        run: make -j3 no_test SHARED=1
+        working-directory: mbedtls
+      - name: "mbedtls: make install"
+        run: sudo make install DESTDIR=/usr
+        working-directory: mbedtls
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2689...
+      - name: autoconf
+        run: autoreconf -fvi
+      - name: configure
+        run: ./configure --with-crypto-library=mbedtls
+      - name: make all
+        run: make -j3
+      - name: make check
+        run: make check
-- 
2.34.1


