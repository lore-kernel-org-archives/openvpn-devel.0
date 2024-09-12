From: Gert Doering <gert@...1296...>
Date: Thu, 12 Sep 2024 19:49:10 +0200
Message-ID: <20240912174910.21058-1-gert@...1296...>
In-Reply-To: <gerrit.1726065220000.I86203b8f9a6d3cfc5e56d3ce9452af694fd11011@...2715...>
References: <gerrit.1726065220000.I86203b8f9a6d3cfc5e56d3ce9452af694fd11011@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] GHA: Enable t_server_null tests
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

Change-Id: I86203b8f9a6d3cfc5e56d3ce9452af694fd11011
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/743
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 8f0a7b5..361d457 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -172,8 +172,11 @@
         run: ./configure --with-crypto-library=${{matrix.ssllib}} ${{matrix.extraconf}} --enable-werror
       - name: make all
         run: make -j3
+      - name: configure checks
+        if: ${{ matrix.extraconf != '--disable-management' }}
+        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
       - name: make check
-        run: make check VERBOSE=1
+        run: make -j3 check VERBOSE=1
 
   ubuntu-clang-asan:
     strategy:
@@ -199,8 +202,10 @@
         run: CFLAGS="-fsanitize=address,undefined -fno-sanitize-recover=all  -fno-omit-frame-pointer -O2" CC=clang ./configure --with-crypto-library=${{matrix.ssllib}} --enable-werror
       - name: make all
         run: make -j3
+      - name: configure checks
+        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
       - name: make check
-        run: make check VERBOSE=1
+        run: make -j3 check VERBOSE=1
 
   macos:
     strategy:
@@ -258,8 +263,10 @@
         run: ./configure --enable-werror ${{matrix.configureflags}} ${{matrix.configuressllib}}
       - name: make all
         run: make -j4
+      - name: configure checks
+        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
       - name: make check
-        run: make check VERBOSE=1
+        run: make -j4 check VERBOSE=1
 
   msvc:
       strategy:
@@ -369,8 +376,10 @@
         run: ./configure --with-crypto-library=openssl ${{matrix.configureflags}} --enable-werror
       - name: make all
         run: make -j3
+      - name: configure checks
+        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
       - name: make check
-        run: make check VERBOSE=1
+        run: make -j3 check VERBOSE=1
 
   mbedtls3:
     strategy:
@@ -422,5 +431,7 @@
         run: ./configure --with-crypto-library=mbedtls
       - name: make all
         run: make -j3
+      - name: configure checks
+        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
       - name: make check
-        run: make check VERBOSE=1
+        run: make -j3 check VERBOSE=1

