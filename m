From: Ilya Shipitsin <chipitsine@...277...>
Date: Thu,  4 Jan 2018 17:19:56 +0500
Message-Id: <20180104121956.13358-1-chipitsine@...277...>
Subject: [Openvpn-devel] [PATCH] travis-ci: speedup osx build by enabling
 brew cache
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

1-2 minutes speedup by using brew cache, also ccache
is no more disabled for osx build (even it does not
speedup significantly, it simplifies the overall script)

---
this is a "v2" of previously issued "enable ccache for osx and mingw builds"
patch. I decided not to enable ccache for mingw builds as it does not
speedup them

 .travis.yml           | 5 +++--
 .travis/build-deps.sh | 7 ++-----
 2 files changed, 5 insertions(+), 7 deletions(-)

diff --git a/.travis.yml b/.travis.yml
index 1f669b30..34e0ac04 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -82,10 +82,11 @@ cache:
   directories:
   - download-cache
   - ${HOME}/opt
+  - ${HOME}/Library/Caches/Homebrew
 
 before_install:
-  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew update     ; fi
-  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo; fi
+  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew update            ; fi
+  - if [ "${TRAVIS_OS_NAME}" = "osx" ]; then brew install lzo ccache; fi
 
 install:
   - if [ ! -z "${CHOST}" ]; then unset CC; fi
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index e787abab..e7036b6b 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -130,11 +130,8 @@ build_openssl () {
     fi
 }
 
-# Enable ccache
-if [ "${TRAVIS_OS_NAME}" != "osx" ] && [ -z ${CHOST+x} ]; then
-    # ccache not available on osx, see:
-    # https://github.com/travis-ci/travis-ci/issues/5567
-    # also ccache not enabled for cross builds
+# Enable ccache except cross builds
+if [ -z ${CHOST+x} ]; then
     mkdir -p "${HOME}/bin"
     ln -s "$(which ccache)" "${HOME}/bin/${CC}"
     PATH="${HOME}/bin:${PATH}"
-- 
2.14.3


