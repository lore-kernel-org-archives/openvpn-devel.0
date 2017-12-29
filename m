From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 29 Dec 2017 10:47:37 +0100
Message-ID: <1514540857-19290-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] travis: use clang's -fsanitize=address to
 catch more bugs
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

The clang address sanitizer is able to catch quite a number of
memory-related bugs, such add memory leaks and buffer under/overruns.
So, enable the address sanitizer for one openssl and one mbedtls build.

This would have caught the buffer list unittest memory leak that
<1512724338-22197-1-git-send-email-steffan@...1856...> wants to fix.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 .travis.yml | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 1f669b3..99cd5e2 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -33,7 +33,7 @@ matrix:
     - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
       os: linux
       compiler: gcc
-    - env: SSLLIB="openssl"
+    - env: SSLLIB="openssl" CFLAGS="-fsanitize=address"
       os: linux
       compiler: clang
     - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0f"
@@ -42,7 +42,7 @@ matrix:
     - env: SSLLIB="mbedtls"
       os: linux
       compiler: gcc
-    - env: SSLLIB="mbedtls"
+    - env: SSLLIB="mbedtls" CFLAGS="-fsanitize=address"
       os: linux
       compiler: clang
     - env: SSLLIB="openssl"
-- 
2.7.4


