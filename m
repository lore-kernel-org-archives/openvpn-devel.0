From: Gert Doering <gert@...1296...>
Date: Thu,  2 May 2024 14:22:31 +0200
Message-ID: <20240502122231.672-1-gert@...1296...>
In-Reply-To: <gerrit.1714552206000.Ia70f230b2e9a78939d1875395205c8f48c4944b7@...2715...>
References: <gerrit.1714552206000.Ia70f230b2e9a78939d1875395205c8f48c4944b7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Replace macos11 with macos14 in github
 runners
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

Github's documentation states:  macos-11 label has been deprecated and
will no longer be available after 6/28/2024. Add macos14 which is nowadays
supported instead.

The github macos-14 runner is using the M1 platform with ARM, so this
requires a bit more adjustment of paths.

Change-Id: Ia70f230b2e9a78939d1875395205c8f48c4944b7
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/582
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index f771f5a..d7c3ecd 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -202,8 +202,16 @@
       matrix:
         ssllib: [ openssl11, openssl3, libressl]
         build: [ normal, asan ]
-        os: [macos-11, macos-12, macos-13]
+        os: [macos-12, macos-13, macos-14]
         include:
+           # macos14 and newer runners use ARM CPUs and homebrew uses /opt/homebrew/
+           # on ARM instead of /usr/local/
+          - os: macos-12
+            homebrew: /usr/local/opt
+          - os: macos-13
+            homebrew: /usr/local/opt
+          - os: macos-14
+            homebrew: /opt/homebrew/opt
           - build: asan
             cflags: "-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
             ldflags: -fsanitize=address,undefined -fno-sanitize-recover=all
@@ -228,8 +236,10 @@
     env:
       CFLAGS: ${{ matrix.cflags }}
       LDFLAGS: ${{ matrix.ldflags }}
-      OPENSSL_CFLAGS: "-I/usr/local/opt/${{matrix.libdir}}/include"
-      OPENSSL_LIBS: "-L/usr/local/opt/${{matrix.libdir}}/lib -lcrypto -lssl"
+      OPENSSL_CFLAGS: "-I${{matrix.homebrew}}/${{matrix.libdir}}/include"
+      OPENSSL_LIBS: "-L${{matrix.homebrew}}/${{matrix.libdir}}/lib -lcrypto -lssl"
+      LZO_CFLAGS: "-I${{matrix.homebrew}}/lzo/include"
+      LZO_LIBS: "-L${{matrix.homebrew}}/lzo/lib -llzo2"
       UBSAN_OPTIONS: print_stacktrace=1
     steps:
       - name: Install dependencies

