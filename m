From: Arne Schwabe <arne@...1227...>
Date: Thu, 12 May 2022 14:14:26 +0200
Message-Id: <20220512121429.2096164-5-arne@...1227...>
In-Reply-To: <20220512121429.2096164-1-arne@...1227...>
References: <20220512121429.2096164-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/7] Add macos OpenSSL 3.0 and ASAN builds
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
Cc: Gert Doering <gert@...1296...>

Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20211019183127.614175-21-arne@...1227...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg23018.html
Signed-off-by: Gert Doering <gert@...1296...>
---
 .github/workflows/build.yaml | 28 +++++++++++++++++++++++++---
 1 file changed, 25 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 4926c1f95..3bdf2aa9f 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -224,15 +224,37 @@ jobs:
 
   macos:
     runs-on: macos-latest
+    strategy:
+      fail-fast: false
+      matrix:
+        ossl: [ 1.1, 3 ]
+        build: [ normal, asan ]
+        include:
+          - build: asan
+            cflags: "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+            ldflags: -fsanitize=address
+            # Our build system ignores LDFLAGS for plugins
+            configureflags: --disable-plugin-auth-pam  --disable-plugin-down-root
+          - build: normal
+            cflags: "-O2 -g"
+            ldflags: ""
+            configureflags: ""
+
+    name: "macOS - OpenSSL ${{matrix.ossl}} - ${{matrix.build}}"
+    env:
+      CFLAGS: ${{ matrix.cflags }}
+      LDFLAGS: ${{ matrix.ldflags }}
+      OPENSSL_CFLAGS: -I/usr/local/opt/openssl@${{matrix.ossl}}/include
+      OPENSSL_LIBS: "-L/usr/local/opt/openssl@${{matrix.ossl}}/lib -lcrypto -lssl"
     steps:
+      - name: Install dependencies
+        run: brew install openssl@...2560... openssl@...1554... lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVPN
         uses: actions/checkout@...2620...
-      - name: Install dependencies
-        run: brew install openssl lzo lz4 man2html cmocka libtool automake autoconf
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: OPENSSL_CFLAGS=-I/usr/local/opt/openssl@...2560.../include  OPENSSL_LIBS="-L/usr/local/opt/openssl@...2560.../lib -lcrypto -lssl" ./configure
+        run: ./configure ${{matrix.configureflags}}
       - name: make all
         run: make -j4
       - name: make check
-- 
2.32.0 (Apple Git-132)


