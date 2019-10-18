From: Lev Stipakov <lstipakov@...277...>
Date: Fri, 18 Oct 2019 14:00:38 +0300
Message-Id: <1571396438-22066-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] travis: add Visual Studio build
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

From: Lev Stipakov <lev@...515...>

I had to remove output redirect from build-deps.sh
to file, because building OpenSSL on Windows takes
some time, and travis aborts job if there is no output
for more than 10 minutes.

Signed-off-by: Lev Stipakov <lev@...515...>
---

Please note, that in order this to work, following patches have to be merged:

 - https://github.com/OpenVPN/openvpn-build/pull/157
 - https://patchwork.openvpn.net/patch/867/


 .travis.yml            | 9 ++++++++-
 .travis/build-check.sh | 5 +++++
 .travis/build-deps.sh  | 9 +++++++++
 3 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/.travis.yml b/.travis.yml
index 2d07cdc..398bfac 100644
--- a/.travis.yml
+++ b/.travis.yml
@@ -24,6 +24,13 @@ env:
 
 matrix:
   include:
+    - env:
+      - SSLLIB="openssl"
+      - OPENSSL_VERSION="1.1.1d"
+      - P7Z="c:\Program Files\7-Zip\7z.exe"
+      - CC="cl"
+      os: windows
+      compiler: cl
     - env: SSLLIB="openssl" RUN_COVERITY="1"
       os: linux
       compiler: gcc
@@ -89,7 +96,7 @@ cache:
 
 install:
   - if [ ! -z "${CHOST}" ]; then unset CC; fi
-  - .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && exit 1)
+  - .travis/build-deps.sh
 
 before_script:
   - .travis/coverity.sh
diff --git a/.travis/build-check.sh b/.travis/build-check.sh
index 74f3ae1..d2d2e8a 100755
--- a/.travis/build-check.sh
+++ b/.travis/build-check.sh
@@ -1,6 +1,11 @@
 #!/bin/sh
 set -eux
 
+if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
+	PATH="/c/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin/":$PATH
+	MSBuild.exe openvpn.sln //p:Platform=x64 && exit 0
+fi
+
 if [ "${TRAVIS_OS_NAME}" = "linux" ]; then
 	export LD_LIBRARY_PATH="${PREFIX}/lib:${LD_LIBRARY_PATH:-}"
 fi
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index 391b35e..724ff30 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -1,6 +1,15 @@
 #!/bin/sh
 set -eux
 
+if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
+    choco install strawberryperl nasm
+    cd ..
+    git clone https://github.com/openvpn/openvpn-build.git
+    cd openvpn-build
+    PATH="/c/Strawberry/perl/bin:":$PATH MODE=DEPS msvc/build.bat
+    exit 0
+fi
+
 # Set defaults
 PREFIX="${PREFIX:-${HOME}/opt}"
 
-- 
2.7.4


