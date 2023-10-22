From: Gert Doering <gert@...1296...>
Date: Sun, 22 Oct 2023 12:57:56 +0200
Message-ID: <20231022105756.21080-1-gert@...1296...>
In-Reply-To: <gerrit.1697649699000.I204b396dea9f22d68e8e091d181a85ffebde4c17@...2715...>
References: <gerrit.1697649699000.I204b396dea9f22d68e8e091d181a85ffebde4c17@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add undefined and abort on error to clang
 sanaitize builds
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

The -fno-sanitize-recover=all flag ensures that for all errors we actually
abort the tests in the automated testing and not just print some errors in red
that nobody sess. Also add the undefined tests to catch more bugs.

For libreSSL we do not add the udefined behaviour as we have (even with the
latest LibreSSL version) an undefined behaviour in LibreSSL itself.

Change-Id: I204b396dea9f22d68e8e091d181a85ffebde4c17
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/375
This mail reflects revision 1 of this Change.
Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 58fbc29..2a25582 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -186,7 +186,7 @@
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: CFLAGS="-fsanitize=address -fno-omit-frame-pointer -O2" CC=clang ./configure --with-crypto-library=${{matrix.ssllib}}
+        run: CFLAGS="-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-omit-frame-pointer -O2" CC=clang ./configure --with-crypto-library=${{matrix.ssllib}}
       - name: make all
         run: make -j3
       - name: make check
@@ -201,8 +201,8 @@
         os: [macos-11, macos-12, macos-13]
         include:
           - build: asan
-            cflags: "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
-            ldflags: -fsanitize=address
+            cflags: "-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+            ldflags: -fsanitize=address,undefined -fno-sanitize-recover=all 
             # Our build system ignores LDFLAGS for plugins
             configureflags: --disable-plugin-auth-pam  --disable-plugin-down-root
           - build: normal
@@ -300,8 +300,8 @@
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

