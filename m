From: Arne Schwabe <arne@...1227...>
Date: Mon, 30 Jan 2023 18:29:36 +0100
Message-Id: <20230130172936.3444840-5-arne@...1227...>
In-Reply-To: <20230130172936.3444840-1-arne@...1227...>
References: <20230130172936.3444840-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 5/5] Add undefined and abort on error to
 clang sanaitize builds
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

The -fno-sanitize-recover=all flag ensures that for all errors we actually
abort the tests in the automated testing and not just print some errors in red
that nobody sess. Also add the undefined tests to catch more bugs.

For libreSSL we do not add the udefined behaviour as we have (even with the
latest LibreSSL version) an undefined behaviour in LibreSSL itself.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 .github/workflows/build.yaml | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 132624547..e98ed4544 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -254,7 +254,7 @@ jobs:
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: CFLAGS="-fsanitize=address -fno-omit-frame-pointer -O2" CC=clang ./configure --with-crypto-library=${{matrix.ssllib}}
+        run: CFLAGS="-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-omit-frame-pointer -O2" CC=clang ./configure --with-crypto-library=${{matrix.ssllib}}
       - name: make all
         run: make -j3
       - name: make check
@@ -269,8 +269,8 @@ jobs:
         os: [macos-11, macos-12]
         include:
           - build: asan
-            cflags: "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=address
+            cflags: "-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+            ldflags: -fsanitize=address,undefined -fno-sanitize-recover=all 
             # Our build system ignores LDFLAGS for plugins
             configureflags: --disable-plugin-auth-pam  --disable-plugin-down-root
           - build: normal
@@ -390,8 +390,8 @@ jobs:
         configureflags: ["--with-openssl-engine=no"]
         include:
           - build: asan
-            cflags: "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=address
+            cflags: "-fsanitize=address -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+            ldflags: -fsanitize=address -fno-sanitize-recover=all
             cc: clang
           - build: normal
             cflags: "-O2 -g"
-- 
2.37.1 (Apple Git-137.1)


