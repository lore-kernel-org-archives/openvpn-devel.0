From: chipitsine@...277...
Date: Mon, 11 Mar 2019 18:36:18 +0500
Message-Id: <20190311133620.18278-2-chipitsine@...277...>
In-Reply-To: <20190311133620.18278-1-chipitsine@...277...>
References: <20190311133620.18278-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] travis-ci: add "linux-ppc64le" to build
 matrix
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

From: Ilya Shipitsin <chipitsine@...277...>

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
 .travis.yml | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.travis.yml b/.travis.yml
index ede2aaa6..428131ec 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -33,6 +33,9 @@ matrix:
     - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h"
       os: linux
       compiler: gcc
+    - env: SSLLIB="openssl" OPENSSL_VERSION="1.1.0h" LABEL="linux-ppc64le"
+      os: linux-ppc64le
+      compiler: gcc
     - env: SSLLIB="openssl" CFLAGS="-fsanitize=address"
       os: linux
       compiler: clang
-- 
2.20.1


