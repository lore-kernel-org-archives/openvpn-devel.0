From: Timo Rothenpieler <timo@...2669...>
Date: Wed, 17 Aug 2022 15:23:02 +0200
Message-Id: <20220817132302.538-1-timo@...2669...>
In-Reply-To: <20220817130955.450-1-timo@...2669...>
References: <20220817130955.450-1-timo@...2669...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Github Actions: update used actions
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

In the case of the Microsoft action, this fixes security relevant issues according to their release notes:
https://github.com/microsoft/setup-msbuild/releases

Unfortunately they don't appear to be following the usual scheme of v1 referring to all v1.x.x, but instead v1 just points to v1.0.0.

The primary change with all the Github-Provided actions is the switch to a more up-to-date NodeJS version (16). Not all that relevant when you just use the action as is, but on top of that, the old versions are in low-maintenance mode, and basically are considered obsolete.
Github is actively migrating people to the latest ones via dependabot wherever they can.
---
 .github/workflows/build.yaml | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index c89d3c8c..49b7d6d1 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -13,7 +13,7 @@ jobs:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y uncrustify
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2620...
+        uses: actions/checkout@...2689...
         with:
           path: openvpn
       - name: Show uncrustify version
@@ -27,7 +27,7 @@ jobs:
       - name: Show changes on standard output
         run: git diff
         working-directory: openvpn
-      - uses: actions/upload-artifact@...2620...
+      - uses: actions/upload-artifact@...2689...
         with:
           name: uncrustify-changes.patch
           path: 'openvpn/uncrustify-changes.patch'
@@ -60,12 +60,12 @@ jobs:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y mingw-w64 libtool automake autoconf man2html unzip
       - name: Checkout ovpn-dco-win
-        uses: actions/checkout@...2620...
+        uses: actions/checkout@...2689...
         with:
           repository: OpenVPN/ovpn-dco-win
           path: ovpn-dco-win
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2620...
+        uses: actions/checkout@...2689...
         with:
           path: openvpn
 
@@ -75,7 +75,7 @@ jobs:
 
       - name: Cache dependencies
         id: cache
-        uses: actions/cache@...2620...
+        uses: actions/cache@...2689...
         with:
           path: '~/mingw/'
           key: ${{ matrix.target }}-mingw-${{ env.OPENSSL_VERSION }}-${{ env.LZO_VERSION }}-${{ env.PKCS11_HELPER_VERSION }}-${{ env.TAP_WINDOWS_VERSION }}
@@ -226,7 +226,7 @@ jobs:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev linux-libc-dev man2html libcmocka-dev python3-docutils libtool automake autoconf ${SSLPKG} ${NLPKG}
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2620...
+        uses: actions/checkout@...2689...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -250,7 +250,7 @@ jobs:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev libcap-ng-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2620...
+        uses: actions/checkout@...2689...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -288,7 +288,7 @@ jobs:
       - name: Install dependencies
         run: brew install openssl@...2560... openssl@...1554... lzo lz4 man2html cmocka libtool automake autoconf
       - name: Checkout OpenVPN
-        uses: actions/checkout@...2620...
+        uses: actions/checkout@...2689...
       - name: autoconf
         run: autoreconf -fvi
       - name: configure
@@ -319,13 +319,13 @@ jobs:
 
       runs-on: windows-latest
       steps:
-      - uses: actions/checkout@...2620...
+      - uses: actions/checkout@...2689...
 
       - name: Add MSBuild to PATH
-        uses: microsoft/setup-msbuild@...2621...
+        uses: microsoft/setup-msbuild@...2690...
 
       - name: Set up Python
-        uses: actions/setup-python@...2620...
+        uses: actions/setup-python@...2691...
         with:
           python-version: '3.x'
 
@@ -345,7 +345,7 @@ jobs:
             msbuild /m /p:Configuration=${{env.BUILD_CONFIGURATION}} /p:Platform="${{ matrix.plat }}" .
 
       - name: Archive artifacts
-        uses: actions/upload-artifact@...2620...
+        uses: actions/upload-artifact@...2689...
         with:
           name: artifacts-${{ matrix.plat }}
           path: |
-- 
2.34.1


