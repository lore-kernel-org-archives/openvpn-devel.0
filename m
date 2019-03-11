From: chipitsine@...277...
Date: Mon, 11 Mar 2019 18:36:20 +0500
Message-Id: <20190311133620.18278-4-chipitsine@...277...>
In-Reply-To: <20190311133620.18278-1-chipitsine@...277...>
References: <20190311133620.18278-1-chipitsine@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] travis-ci: update osx to xcode9.4 and
 modernize brew management
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

osx image used for builds, i.e. xcode7.3 is outdated, we
can switch to "default" xcode9.4 and use more fast brew
travis-ci plugin

Signed-off-by: Ilya Shipitsin <chipitsine@...277...>
---
 .travis.yml | 8 ++------
 1 file changed, 2 insertions(+), 6 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index bf46b14c..e61a8d38 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -50,11 +50,9 @@ matrix:
       compiler: clang
     - env: SSLLIB="openssl"
       os: osx
-      osx_image: xcode7.3
       compiler: clang
     - env: SSLLIB="mbedtls"
       os: osx
-      osx_image: xcode7.3
       compiler: clang
     - env: SSLLIB="openssl" CHOST=x86_64-w64-mingw32 OPENSSL_VERSION="1.0.1u"
       os: linux
@@ -76,6 +74,8 @@ addons:
   apt:
     update: true
     packages: [ liblzo2-dev, libpam0g-dev, liblz4-dev, linux-libc-dev, man2html, mingw-w64]
+  homebrew:
+    packages: [ lzo ]
 
 cache:
   directories:
@@ -83,10 +83,6 @@ cache:
   - ${HOME}/opt
   - ${HOME}/Library/Caches/Homebrew
 
-before_install:
-  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew update     ; fi
-  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo; fi
-
 install:
   - if [ ! -z "${CHOST}" ]; then unset CC; fi
   - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && exit 1)
-- 
2.20.1


