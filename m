From: Gert Doering <gert@...1296...>
Date: Sat, 24 Jan 2026 19:18:07 +0100
Message-ID: <20260124181814.30331-1-gert@...1296...>
In-Reply-To: <gerrit.1768409585000.I658b1b24da304938225a8f834d7484671a63360f@...2715...>
References: <gerrit.1768409585000.I658b1b24da304938225a8f834d7484671a63360f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] GHA: Update mbedtls to v4
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

Also switch from Make to CMake for building it
because the former is not supported anymore.

Change-Id: I658b1b24da304938225a8f834d7484671a63360f
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1474
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1474
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Yuriy Darnobyt <yura.uddr@...277...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d1322c7..ef9b3f5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -366,12 +366,12 @@
       - name: make check
         run: make -j3 check VERBOSE=1
 
-  mbedtls3:
+  mbedtls4:
     strategy:
       fail-fast: false
       matrix:
         os: [ubuntu-22.04]
-        ssllib: [mbedtls3]
+        ssllib: [mbedtls4]
         build: [ normal, asan ]
         include:
           - build: asan
@@ -398,15 +398,19 @@
         uses: actions/checkout@...2977... # v6.0.1
         with:
           path: mbedtls
-          submodules: true
+          submodules: recursive
           # versioning=semver-coerced
           repository: Mbed-TLS/mbedtls
-          ref: v3.6.5
-      - name: "mbedtls: make no_test"
-        run: make -j3 no_test SHARED=1
+          ref: v4.0.0
+      - uses: lukka/get-cmake@...2927... # v4.1.1
+      - name: "mbedtls: cmake"
+        run: cmake -B build
         working-directory: mbedtls
-      - name: "mbedtls: make install"
-        run: sudo make install DESTDIR=/usr
+      - name: "mbedtls: cmake --build"
+        run: cmake --build build
+        working-directory: mbedtls
+      - name: "mbedtls: cmake --install"
+        run: sudo cmake --install build --prefix /usr
         working-directory: mbedtls
       - name: Checkout OpenVPN
         uses: actions/checkout@...2977... # v6.0.1

