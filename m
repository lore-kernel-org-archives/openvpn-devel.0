From: Antonio Quartulli <a@...2181...>
Date: Wed, 19 Dec 2018 15:01:18 +1000
Message-Id: <20181219050118.6568-8-a@...2181...>
In-Reply-To: <20181219050118.6568-1-a@...2181...>
References: <20181219050118.6568-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3 7/7] travis.yml: add test for iproute2
 net implementation
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
Cc: Antonio Quartulli <a@...2181...>

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 .travis.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index ede2aaa6..b8031fd8 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -33,6 +33,9 @@ matrix:
     - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h"
       os: linux
       compiler: gcc
+    - env: SSLLIB="openssl" EXTRA_CONFIG="--enable-iproute2"
+      os: linux
+      compiler: gcc
     - env: SSLLIB="openssl" CFLAGS="-fsanitize=address"
       os: linux
       compiler: clang
-- 
2.19.2


