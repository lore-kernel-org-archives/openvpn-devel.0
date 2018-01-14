From: Ilya Shipitsin <chipitsine@...277...>
Date: Sun, 14 Jan 2018 19:06:27 +0500
Message-Id: <20180114140627.25331-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] travis-ci: modify openssl build script to
 support openssl-1.1.0
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

no-multilib is only supported on openssl-1.0.X, do not use it
if OPENSSL_VERSION is 1.1.0

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
 .travis/build-deps.sh | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index bc538853..1761932e 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -110,8 +110,9 @@ build_openssl_mingw () {
             export TARGET=mingw64
         fi
 
-        ./Configure --cross-compile-prefix=${CHOST}- shared \
-           ${TARGET} no-multilib no-capieng --prefix="${PREFIX}" --openssldir="${PREFIX}" -static-libgcc
+        ./Configure --cross-compile-prefix=${CHOST}- shared ${TARGET} \
+           $([[ ${OPENSSL_VERSION} == "1.0."* ]] && echo "no-multilib") \
+           no-capieng --prefix="${PREFIX}" --openssldir="${PREFIX}" -static-libgcc
         make install
     )
 }
-- 
2.14.3


