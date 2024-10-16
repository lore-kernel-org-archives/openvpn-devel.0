From: Gert Doering <gert@...1296...>
Date: Wed, 16 Oct 2024 13:59:14 +0200
Message-ID: <20241016115914.28098-1-gert@...1296...>
In-Reply-To: <gerrit.1729079770000.Ie922ce67685228eb7043749a7f1a61a33be678d2@...2715...>
References: <gerrit.1729079770000.Ie922ce67685228eb7043749a7f1a61a33be678d2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Simplify macOS builds
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

Reduce redundant configuration.

Change-Id: Ie922ce67685228eb7043749a7f1a61a33be678d2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
(cherry picked from commit 33a700d61e5b1a724b00f17fa0ed75d694e2823a)
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to release/2.6.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/782
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index e4959ba..d930197 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -192,18 +192,10 @@
     strategy:
       fail-fast: false
       matrix:
-        ssllib: [ openssl11, openssl3, libressl]
-        build: [ normal, asan ]
+        ssllib: [openssl@...2560..., openssl@...1554..., libressl]
+        build: [normal, asan]
         os: [macos-13, macos-14, macos-15]
         include:
-           # macos14 and newer runners use ARM CPUs and homebrew uses /opt/homebrew/
-           # on ARM instead of /usr/local/
-          - os: macos-13
-            homebrew: /usr/local/opt
-          - os: macos-14
-            homebrew: /opt/homebrew/opt
-          - os: macos-15
-            homebrew: /opt/homebrew/opt
           - build: asan
             cflags: "-fsanitize=address -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
             ldflags: -fsanitize=address
@@ -213,35 +205,30 @@
             cflags: "-O2 -g"
             ldflags: ""
             configureflags: ""
-          - ssllib: openssl11
-            libdir: openssl@...2560...
-            configuressllib: ""
-          - ssllib: openssl3
-            libdir: openssl@...1554...
-            configuressllib: ""
-          - ssllib: libressl
-            libdir: libressl
-            configuressllib: "--with-openssl-engine=no"
 
     runs-on: ${{matrix.os}}
-    name: "${{matrix.os}} - ${{matrix.libdir}} - ${{matrix.build}}"
+    name: "${{matrix.os}} - ${{matrix.ssllib}} - ${{matrix.build}}"
     env:
       CFLAGS: ${{ matrix.cflags }}
       LDFLAGS: ${{ matrix.ldflags }}
-      OPENSSL_CFLAGS: "-I${{matrix.homebrew}}/${{matrix.libdir}}/include"
-      OPENSSL_LIBS: "-L${{matrix.homebrew}}/${{matrix.libdir}}/lib -lcrypto -lssl"
-      LZO_CFLAGS: "-I${{matrix.homebrew}}/lzo/include"
-      LZO_LIBS: "-L${{matrix.homebrew}}/lzo/lib -llzo2"
       UBSAN_OPTIONS: print_stacktrace=1
     steps:
       - name: Install dependencies
-        run: brew install openssl@...2560... openssl@...1554... lzo lz4 man2html cmocka libtool automake autoconf libressl
+        run: brew install ${{matrix.ssllib}} lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVPN
         uses: actions/checkout@...2691...
+      - name: Set environment
+        run: |
+          cat >>$GITHUB_ENV <<EOF;
+          OPENSSL_CFLAGS=-I$(brew --prefix ${{matrix.ssllib}})/include
+          OPENSSL_LIBS=-L$(brew --prefix ${{matrix.ssllib}})/lib -lcrypto -lssl
+          LZO_CFLAGS=-I$(brew --prefix lzo)/include
+          LZO_LIBS=-L$(brew --prefix lzo)/lib -llzo2
+          EOF
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
-        run: ./configure --enable-werror ${{matrix.configureflags}} ${{matrix.configuressllib}}
+        run: ./configure --enable-werror ${{matrix.configureflags}}
       - name: make all
         run: make -j4
       - name: make check

