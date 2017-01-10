From: Ilya Shipitsin <chipitsine@...277...>
Date: Tue, 10 Jan 2017 13:04:07 +0500
Message-Id: <1484035447-11838-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] Resolving several travis-ci issues:
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

* moving LD_LIBRARY_PATH as far as possible (otherwise "wget" picks it, which is not desirable)
* split LD_LIBRARY_PATH into LD_LIBRARY_PATH/DYLD_LIBRARY_PATH depending on operating system
* removed MBEDTLS_VERSION, OPENSSL_VERSION (the last depended on nonexistent OPENSSL_VERION variable)
* removed "apt: true" from caching, it never worked actually

this patch should be applied after https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg13843.html
---
 .travis.yml           | 4 ++--
 .travis/build-deps.sh | 2 --
 2 files changed, 2 insertions(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 369db97..b8ec1ac 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -18,7 +18,6 @@ env:
     - OPENSSL_VERSION="1.0.1t"
     - OPENSSL_CFLAGS="-I${PREFIX}/include"
     - OPENSSL_LIBS="-L${PREFIX}/lib -lssl -lcrypto"
-    - LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"
 
 matrix:
   include:
@@ -63,7 +62,6 @@ addons:
       - linux-libc-dev
 
 cache:
-  apt: true
   ccache: true
   directories:
   - download-cache
@@ -77,6 +75,8 @@ install:
   - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && exit 1)
 
 script:
+  - if [ "${TRAVIS_OS_NAME}" = "linux" ]; then export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"; fi
+  - if [ "${TRAVIS_OS_NAME}" = "osx"   ]; then export DYLD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"; fi
   - autoreconf -vi
   - ./configure --with-crypto-library="${SSLLIB}" ${EXTRA_CONFIG} || (cat config.log && exit 1)
   - make -j$JOBS
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index bda54ee..3ffba0b 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -2,8 +2,6 @@
 set -eux
 
 # Set defaults
-MBEDTLS_VERSION="${MBEDTLS_VERSION:-2.2.1}"
-OPENSSL_VERSION="${OPENSSL_VERION:-1.0.2h}"
 PREFIX="${PREFIX:-${HOME}/opt}"
 
 download_mbedtls () {
-- 
2.5.5


