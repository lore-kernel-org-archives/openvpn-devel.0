From: Gert Doering <gert@...1296...>
Date: Fri, 14 Feb 2025 17:06:34 +0100
Message-ID: <20250214160634.6670-1-gert@...1296...>
In-Reply-To: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
References: <gerrit.1739460301000.Ieb787a040f9eaf34d9d16996af1d63d7eae94944@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Add android build to Github Actions
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

Change-Id: Ieb787a040f9eaf34d9d16996af1d63d7eae94944
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/896
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Frank Lichtenheld <frank@...2641...>

        
diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 8fd1325..b1af7ec 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -35,6 +35,37 @@
         run: test ! -s uncrustify-changes.patch
         working-directory: openvpn
 
+  android:
+    strategy:
+      fail-fast: false
+      matrix:
+        abi: [ arm64-v8a ]
+        include:
+          - abi: arm64-v8a
+            vcpkg_triplet: arm64-android
+    runs-on: ubuntu-24.04
+    name: "Android - ${{ matrix.abi }}"
+    # Github images already setup NDK with ANDROID_NDK_ROOT pointing to the root
+    # of the SDK
+    env:
+      VCPKG_DEFAULT_TRIPLET: ${{ matrix.vcpkg_triplet }}
+      VCPKG_ROOT: ${{ github.workspace }}/vcpkg
+      VCPKG_INSTALLED_DIR: ${{ github.workspace }}/vcpkg/installed
+    steps:
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2844... # v4.2.2
+      - name: Install vcpkg
+        uses: lukka/run-vcpkg@...2815... # v11.5
+        with:
+          vcpkgGitCommitId: 33e9c99208736b713cabe4490e15235f62f893d4
+      - name: Install dependencies
+        run: ${VCPKG_ROOT}/vcpkg install openssl lz4 cmocka
+      - name: configure OpenVPN with cmake
+        run: cmake -S . -B openvpn-build -DUNSUPPORTED_BUILDS=yes -DCMAKE_SYSTEM_NAME=Android -DOPENSSL_ROOT_DIR=${VCPKG_INSTALLED_DIR}/${{ matrix.vcpkg_triplet }} -DENABLE_PKCS11=false -DBUILD_TESTING=true -DCMAKE_ANDROID_ARCH_ABI=${{ matrix.abi }} -DENABLE_LZO=false -DUSE_WERROR=no
+      - name: Build OpenVPN Android binary with cmake
+        run: cmake --build openvpn-build
+
+
   mingw:
     strategy:
       fail-fast: false

