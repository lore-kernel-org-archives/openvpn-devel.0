From: Arne Schwabe <arne@...1227...>
Date: Wed,  8 Sep 2021 16:27:24 +0200
Message-Id: <20210908142724.3391935-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix Ubuntu spelling and duplicate run in
 Github Actions
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

Ubuntu spelling was wrong and the matrix for operating system
does not do anything but run the same build twice.
---
 .github/workflows/build.yaml | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index eb2c4f5fe..0d55b8ae0 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -144,13 +144,13 @@ jobs:
       - name: make check
         run: make check
 
-  ubutun20-clang-asan:
+  ubuntu-clang-asan:
     strategy:
       matrix:
-        os: [ubuntu-16.04, ubuntu-18.04]
+        os: [ubuntu-20.04]
         ssllib: [mbedtls, openssl]
 
-    runs-on: ubuntu-20.04
+    runs-on: ${{matrix.os}}
     steps:
       - name: Install dependencies
         run: sudo apt update && sudo apt install -y liblzo2-dev libpam0g-dev liblz4-dev linux-libc-dev man2html clang libcmocka-dev python3-docutils libtool automake autoconf libmbedtls-dev
-- 
2.33.0


