From: Ilya Shipitsin <chipitsine@...277...>
Date: Fri,  5 Jan 2018 00:37:10 +0500
Message-Id: <20180104193710.23778-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH v3] travis-ci: add brew cache, remove ccache
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

1-2 minutes speedup osx builds by using brew cache.
Also, ccache was removed for a while (builds fail
after travis-ci upgraded clang to version 5.0.0)
---
v2: this is a "v2" of previously issued "enable ccache for osx and mingw builds"
patch. I decided not to enable ccache for mingw builds as it does not
speedup them

v3: removed ccache at all, because it fails on clang-5.0.0

 .travis.yml           |  2 +-
 .travis/build-deps.sh | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 1f669b30..43217b59 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -78,10 +78,10 @@ addons:
       - man2html
 
 cache:
-  ccache: true
   directories:
   - download-cache
   - ${HOME}/opt
+  - ${HOME}/Library/Caches/Homebrew
 
 before_install:
   - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew update     ; fi
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index e787abab..bc538853 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -130,16 +130,6 @@ build_openssl () {
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
-fi
-
 if [ ! -z ${CHOST+x} ]; then
       #
       # openvpn requires at least mingw-gcc-4.9, which is available at xenial repo
-- 
2.14.3


