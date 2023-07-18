From: Frank Lichtenheld <frank@...2641...>
Date: Tue, 18 Jul 2023 12:52:33 +0200
Message-Id: <20230718105233.620193-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] GHA: refactor mingw UTs and add missing
 tls_crypt
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

I thought instead about moving this into a loop inside
powershell. But then error handling becomes annoying.
So let's GitHub handle it.

Change-Id: I9831f352c07b5c58a4e2d6a3dd5417842e0887d2
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 .github/workflows/build.yaml | 38 ++++--------------------------------
 1 file changed, 4 insertions(+), 34 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index da2a427c..2ae231ee 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -85,48 +85,18 @@ jobs:
       fail-fast: false
       matrix:
         arch: [x86, x64]
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, tls_crypt]
 
     runs-on: windows-latest
-    name: "mingw unittests - ${{ matrix.arch }} - OSSL"
+    name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
       - name: Retrieve mingw unittest
         uses: actions/download-artifact@...2689...
         with:
           name: openvpn-mingw-${{ matrix.arch }}-tests
           path: unittests
-
-      - name: List unittests directory
-        run: "dir unittests"
-
-      - name: Run argv unit test
-        run: ./unittests/test_argv.exe
-
-      - name: Run auth_token unit test
-        run: ./unittests/test_auth_token.exe
-
-      - name: Run buffer unit test
-        run: ./unittests/test_buffer.exe
-
-      - name: Run cryptoapi unit test
-        run: ./unittests/test_cryptoapi.exe
-
-      - name: Run crypto unit test
-        run: ./unittests/test_crypto.exe
-
-      - name: Run misc unit test
-        run: ./unittests/test_misc.exe
-
-      - name: Run ncp unit test
-        run: ./unittests/test_ncp.exe
-
-      - name: Run packet id unit test
-        run: ./unittests/test_packet_id.exe
-
-      - name: Run pkt unit test
-        run: ./unittests/test_pkt.exe
-
-      - name: Run provider unit test
-        run: ./unittests/test_provider.exe
+      - name: Run ${{ matrix.test }} unit test
+        run: ./unittests/test_${{ matrix.test }}.exe
 
   ubuntu:
     strategy:
-- 
2.34.1


