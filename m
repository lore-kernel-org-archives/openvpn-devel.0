From: Antonio Quartulli <a@...2181...>
Date: Sun, 10 Nov 2019 20:56:22 +0100
Message-Id: <20191110195622.28177-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] travis: fix CFLAGS assignment error and add
 -Werror only when compiling on Linux for Linux
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

CFLAGS may not resolve to anything and the build-check.sh script would
just fail.

Use proper substitution so that the script won't error out when CFLAGS
is uninitialized.

At the same time ensure that such flag is set only when compiling *for*
linux (we use linux to also compile *for* windows)

Signed-off-by: Antonio Quartulli <a@...2181...>
---

Test on travis-ci with my personal openvpn repo:
https://travis-ci.org/ordex/openvpn

 .travis/build-check.sh | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/.travis/build-check.sh b/.travis/build-check.sh
index 250bb454..c2a4904c 100755
--- a/.travis/build-check.sh
+++ b/.travis/build-check.sh
@@ -8,7 +8,6 @@ fi
 
 if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
 	export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH:-}"
-	export CFLAGS="${CFLAGS} -Werror"
 fi
 
 if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then
@@ -21,7 +20,10 @@ if [ -z ${CHOST+x} ]; then
 	./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG:-} || (cat config.log && exit 1)
 	make -j$JOBS
 	src/openvpn/openvpn --version || true
-	if [ "${TRAVIS_OS_NAME}" = "linux" ]; then ldd src/openvpn/openvpn; fi
+	if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
+		ldd src/openvpn/openvpn;
+		export CFLAGS="${CFLAGS:-} -Werror"
+	fi
 	if [ "${TRAVIS_OS_NAME}" = "osx" ]; then otool -L src/openvpn/openvpn; fi
 	make check
 	${EXTRA_SCRIPT:-}
-- 
2.24.0


