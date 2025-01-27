From: Shubham Mittal <smittals@...2857...>
Date: Mon, 27 Jan 2025 15:54:13 -0800
Message-ID: <20250127235413.1925-1-smittals@...2857...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Adding AWS-LC to the OpenVPN CI
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

URL: https://github.com/OpenVPN/openvpn/pull/673
Acked-by: Arne Schwabe <arne@...1227...>
Signed-off-by: Shubham Mittal <smittals@...2857...>
---
 .github/workflows/build.yaml | 61 ++++++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 90d52023..96edee32 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -424,3 +424,64 @@ jobs:
         run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
       - name: make check
         run: make -j3 check VERBOSE=1
+
+  aws-lc:
+    strategy:
+      fail-fast: false
+      matrix:
+        os: [ubuntu-24.04]
+        ssllib: [ awslc ]
+        build: [ normal, asan ]
+        include:
+          - build: asan
+            cflags: "-fsanitize=address -fno-sanitize-recover=all  -fno-optimize-sibling-calls -fsanitize-address-use-after-scope -fno-omit-frame-pointer -g -O1"
+            ldflags: -fsanitize=address -fno-sanitize-recover=all
+            cc: clang
+            cxx: clang++
+          - build: normal
+            cflags: "-O2 -g"
+            ldflags: ""
+            cc: gcc
+            cxx: c++
+
+    name: "${{matrix.cc}} ${{matrix.build}} - ${{matrix.os}} - ${{matrix.ssllib}}"
+    runs-on: ${{matrix.os}}
+    env:
+      CFLAGS: ${{ matrix.cflags }}
+      LDFLAGS: ${{ matrix.ldflags }}
+      CC: ${{matrix.cc}}
+      CXX: ${{matrix.cxx}}
+      UBSAN_OPTIONS: print_stacktrace=1
+      AWS_LC_INSTALL: ${{ github.workspace }}/aws-lc/aws-lc-install
+
+    steps:
+      - name: Install dependencies
+        run: sudo apt update && sudo apt install -y cmake gcc ninja-build golang make liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils python3-jinja2 python3-jsonschema libtool automake autoconf pkg-config libcap-ng-dev libnl-genl-3-dev
+      - name: "AWS-LC: checkout"
+        uses: actions/checkout@...2844... # v4.2.2
+        with:
+          path: aws-lc
+          repository: aws/aws-lc
+          ref: v1.42.0
+      - name: "AWS-LC: build"
+        run: |
+          mkdir build
+          cd build
+          cmake -GNinja -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX="${{ env.AWS_LC_INSTALL }}" -DBUILD_SHARED_LIBS=1 ../
+          ninja install
+        working-directory: aws-lc
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2844... # v4.2.2
+      - name: autoconf
+        run: autoreconf -fvi
+      - name: configure with AWS-LC
+        run: |
+          OPENSSL_CFLAGS="-I/${{ env.AWS_LC_INSTALL }}/include" \
+          OPENSSL_LIBS="-L/${{ env.AWS_LC_INSTALL }}/lib -lssl -lcrypto" \
+          ./configure --with-crypto-library=openssl
+      - name: make all
+        run: make -j3
+      - name: configure checks
+        run: echo 'RUN_SUDO="sudo -E"' >tests/t_server_null.rc
+      - name: make check
+        run: LD_LIBRARY_PATH="${{ env.AWS_LC_INSTALL }}/lib" make -j3 check VERBOSE=1
\ No newline at end of file
-- 
2.39.5 (Apple Git-154)


