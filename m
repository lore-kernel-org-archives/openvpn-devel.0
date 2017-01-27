From: Ilya Shipitsin <chipitsine@...277...>
Date: Fri, 27 Jan 2017 18:53:13 +0500
Message-Id: <1485525193-5808-1-git-send-email-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] Resolve several travis-ci issues
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

MBEDTLS_VERSION, OPENSSL_VERSION were defined twice - in both
 .travis.yml  and .travis/build-deps.sh files, the last one
defined OPENSSL_VERSION via nonexistent OPENSSL_VERION
variable, which lead us to use openssl-1.0.1 instead of
openssl-1.0.2, I removed variable definition from build-deps.sh

"cache: [ apt: true ]" is not a travis supported option, it was
introduced by mistake, I removed it

LD_LIBRARY_PATH was defined for the entire test run, it includes
custom openssl build, which was picked by "wget", so "wget"
could not verify SSL cert at https://www.openssl.org sometimes.
We do not want wget to pick our custom LD_LIBRARY_PATH, so I moved
that variable to "script" section

LD_LIBRARY_PATH was defined for both linux and osx environments,
for the second DYLD_LIBRARY_PATH must be defined instead
---
 .travis.yml           | 3 +--
 .travis/build-deps.sh | 2 --
 2 files changed, 1 insertion(+), 4 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 369db97..f3727fa 100644
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
@@ -77,6 +75,7 @@ install:
   - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && exit 1)
 
 script:
+  - export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH}"
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


