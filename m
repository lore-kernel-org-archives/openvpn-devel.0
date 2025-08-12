From: Ilia Shipitsin <chipitsine@...277...>
Date: Tue, 12 Aug 2025 16:09:45 +0200
Message-ID: <20250812140945.439-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] GHA: introduce additional arm64 builds
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

Reference: https://github.blog/changelog/2024-09-03-github-actions-arm64-linux-and-windows-runners-are-now-generally-available/

Signed-off-by: Ilia Shipitsin <chipitsine@...277...>
---
 .github/workflows/build.yaml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index f7883c70..6429f87d 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -135,7 +135,7 @@ jobs:
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-22.04, ubuntu-24.04]
+        os: [ubuntu-22.04, ubuntu-24.04, ubuntu-24.04-arm]
         sslpkg: [libmbedtls-dev]
         ssllib: [mbedtls]
         libname: [mbed TLS]
@@ -181,7 +181,7 @@ jobs:
     strategy:
       fail-fast: false
       matrix:
-        os: [ubuntu-22.04, ubuntu-24.04]
+        os: [ubuntu-22.04, ubuntu-24.04, ubuntu-24.04-arm]
         ssllib: [mbedtls, openssl]
 
     name: "clang-asan - ${{matrix.os}} - ${{matrix.ssllib}}"
-- 
2.46.0.windows.1


