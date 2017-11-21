From: Ilya Shipitsin <chipitsine@...277...>
Date: Tue, 21 Nov 2017 11:36:18 +0500
Message-Id: <20171121063618.13749-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] travis-ci: enable ccache for osx and mingw
 builds
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

--
ccache was now tested by me and works for osx
and mingw builds as well
---
 .travis.yml           |  2 +-
 .travis/build-deps.sh | 14 ++++++--------
 2 files changed, 7 insertions(+), 9 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 366e6599..8efb1cbd 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -88,7 +88,7 @@ cache:
 
 before_install:
   - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew update     ; fi
-  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo; fi
+  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo ccache; fi
 
 install:
   - if [ ! -z "${CHOST}" ]; then unset CC; fi
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index e787abab..001565f3 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -130,15 +130,13 @@ build_openssl () {
     fi
 }
 
-# Enable ccache
-if [ "${TRAVIS_OS_NAME}" != "osx" ] && [ -z ${CHOST+x} ]; then
-    # ccache not available on osx, see:
-    # https://github.com/travis-ci/travis-ci/issues/5567
-    # also ccache not enabled for cross builds
-    mkdir -p "${HOME}/bin"
-    ln -s "$(which ccache)" "${HOME}/bin/${CC}"
-    PATH="${HOME}/bin:${PATH}"
+mkdir -p "${HOME}/bin"
+if [ -z ${CHOST+x} ]; then
+        ln -s "$(which ccache)" "${HOME}/bin/${CC}"
+else
+        ln -s "$(which ccache)" "${HOME}/bin/${CHOST}-cc"
 fi
+PATH="${HOME}/bin:${PATH}"
 
 if [ ! -z ${CHOST+x} ]; then
       #
-- 
2.13.3


