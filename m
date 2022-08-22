From: Arne Schwabe <arne@...1227...>
Date: Mon, 22 Aug 2022 20:41:47 +0200
Message-Id: <20220822184147.281142-2-arne@...1227...>
In-Reply-To: <20220822184147.281142-1-arne@...1227...>
References: <20220822184147.281142-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/2] Include libressl and macOS 12 to macOS
 github actions
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 24 +++++++++++++++++-------
 1 file changed, 17 insertions(+), 7 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index dfa3953f0..6c2c3ef3e 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -261,12 +261,12 @@ jobs:
         run: make check
 
   macos:
-    runs-on: macos-latest
     strategy:
       fail-fast: false
       matrix:
-        ossl: [ 1.1, 3 ]
+        ssllib: [ openssl11, openssl3, libressl]
         build: [ normal, asan ]
+        os: [macos-11, macos-12]
         include:
           - build: asan
             cflags: "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
@@ -277,22 +277,32 @@ jobs:
             cflags: "-O2 -g"
             ldflags: ""
             configureflags: ""
+          - ssllib: openssl11
+            libdir: openssl@...2560...
+            configuressllib: ""
+          - ssllib: openssl3
+            libdir: openssl@...1554...
+            configuressllib: ""
+          - ssllib: libressl
+            libdir: libressl
+            configuressllib: "--with-openssl-engine=no"
 
-    name: "macOS - OpenSSL ${{matrix.ossl}} - ${{matrix.build}}"
+    runs-on: ${{matrix.os}}
+    name: "${{matrix.os}} - ${{matrix.libdir}} - ${{matrix.build}}"
     env:
       CFLAGS: ${{ matrix.cflags }}
       LDFLAGS: ${{ matrix.ldflags }}
-      OPENSSL_CFLAGS: -I/usr/local/opt/openssl@${{matrix.ossl}}/include
-      OPENSSL_LIBS: "-L/usr/local/opt/openssl@${{matrix.ossl}}/lib -lcrypto -lssl"
+      OPENSSL_CFLAGS: "-I/usr/local/opt/${{matrix.libdir}}/include"
+      OPENSSL_LIBS: "-L/usr/local/opt/${{matrix.libdir}}/lib -lcrypto -lssl"
     steps:
       - name: Install dependencies
-        run: brew install openssl@...2560... openssl@...1554... lzo lz4 man2html cmocka libtool automake autoconf
+        run: brew install openssl@...2560... openssl@...1554... lzo lz4 man2html cmocka libtool automake autoconf libressl
       - name: Checkout OpenVPN
         uses: actions/checkout@...2689...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure ${{matrix.configureflags}}
+        run: ./configure ${{matrix.configureflags}} ${{matrix.configuressllib}}
       - name: make all
         run: make -j4
       - name: make check
-- 
2.32.1 (Apple Git-133)


