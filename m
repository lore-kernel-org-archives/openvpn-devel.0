From: Arne Schwabe <arne@...1227...>
Date: Mon, 22 Aug 2022 20:41:46 +0200
Message-Id: <20220822184147.281142-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] Github Actions: Add libreSSL actions
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

Also we don't officially support it, it is nice to know when we break it.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index f42469af6..dfa3953f0 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -366,3 +366,66 @@ jobs:
         token: ${{ secrets.OPENVPN_BUILD_REPO_DISPATCH }}
         repository: openvpn/openvpn-build
         event-type: openvpn-commit
+
+  libressl:
+    strategy:
+      fail-fast: false
+      matrix:
+        os: [ubuntu-22.04]
+        ssllib: [libressl]
+        build: [ normal, asan ]
+        configureflags: ["--with-openssl-engine=no"]
+        include:
+          - build: asan
+            cflags: "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+            ldflags: -fsanitize=address
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
+
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf pkg-config libcap-ng-dev
+      - name: "libressl: checkout"
+        uses: actions/checkout@...2689...
+        with:
+          path: libressl
+          repository: libressl-portable/portable
+          ref: v3.5.3
+      - name: "libressl: autogen.sh"
+        run: ./autogen.sh
+        working-directory: libressl
+      - name: "libressl: autoconf"
+        run: autoreconf -fvi
+        working-directory: libressl
+      - name: "libressl: configure"
+        run: ./configure --enable-openvpn
+        working-directory: libressl
+      - name: "libressl: make all"
+        run: make -j3
+        working-directory: libressl
+      - name: "libressl: make install"
+        run: sudo make install
+        working-directory: libressl
+      - name: "ldconfig"
+        run: sudo ldconfig
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2689...
+      - name: autoconf
+        run: autoreconf -fvi
+      - name: configure
+        run: ./configure --with-crypto-library=openssl ${{matrix.configureflags}}
+      - name: make all
+        run: make -j3
+      - name: make check
+        run: make check
+
-- 
2.32.1 (Apple Git-133)


