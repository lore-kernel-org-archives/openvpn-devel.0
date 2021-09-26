From: Lev Stipakov <lstipakov@...277...>
Date: Sun, 26 Sep 2021 09:10:46 +0300
Message-Id: <20210926061046.212-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] GitHub Actions: remove Ubuntu 16.04
 environment
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Starting from 20th of September, GitHub has removed Ubuntu 16.04
environment from Actions. Safely remove it from our build script
where we already have Ubuntu 18.04 and 20.04.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index f97b79ee..514ae66b 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -126,7 +126,7 @@ jobs:
   ubuntu:
     strategy:
       matrix:
-        os: [ubuntu-16.04, ubuntu-18.04, ubuntu-20.04]
+        os: [ubuntu-18.04, ubuntu-20.04]
         ssllib: [mbedtls, openssl]
 
     runs-on: ${{matrix.os}}
-- 
2.17.1


