From: Ilya Shipitsin <chipitsine@...277...>
Date: Mon, 15 Jan 2018 13:05:55 +0500
Message-Id: <20180115080555.18202-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH v2] travis-ci: modify openssl build script
 to support openssl-1.1.0
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

get rid of no-multilib, as it is not supported on openssl-1.1.0

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
v2: get rid of no-multilib instead of including it conditionally,
thanks to Steffan Karger

 .travis/build-deps.sh | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index bc538853..96a030cc 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -111,7 +111,7 @@ build_openssl_mingw () {
         fi
 
         ./Configure --cross-compile-prefix=${CHOST}- shared \
-           ${TARGET} no-multilib no-capieng --prefix="${PREFIX}" --openssldir="${PREFIX}" -static-libgcc
+           ${TARGET} no-capieng --prefix="${PREFIX}" --openssldir="${PREFIX}" -static-libgcc
         make install
     )
 }
-- 
2.14.3


