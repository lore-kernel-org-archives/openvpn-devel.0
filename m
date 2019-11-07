From: Lev Stipakov <lstipakov@...277...>
Date: Thu,  7 Nov 2019 23:29:34 +0200
Message-Id: <1573162174-28461-1-git-send-email-lstipakov@...277...>
In-Reply-To: <CAGyAFMXrwiOo2EwuNrR2_7reOThwpHBGW6Tzk8yYvJmdbb4t7w@...278...>
References: <CAGyAFMXrwiOo2EwuNrR2_7reOThwpHBGW6Tzk8yYvJmdbb4t7w@...278...>
Subject: [Openvpn-devel] [PATCH v2] travis: add Visual Studio build
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
Cc: Lev Stipakov <lev@...515...>

From: Lev Stipakov <lev@...515...>

Signed-off-by: Lev Stipakov <lev@...515...>
---

 v2; do not unconditionally print dependencies build output for non-Windows builds

 .travis.yml               |  9 ++++++++-
 .travis/build-check.sh    |  5 +++++
 .travis/build-deps.sh     |  9 +++++++++
 .travis/run-build-deps.sh | 10 ++++++++++
 4 files changed, 32 insertions(+), 1 deletion(-)
 create mode 100755 .travis/run-build-deps.sh

diff --git a/.travis.yml b/.travis.yml
index 2d07cdc..61be17c 100644
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
+  - .travis/run-build-deps.sh
 
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
 
diff --git a/.travis/run-build-deps.sh b/.travis/run-build-deps.sh
new file mode 100755
index 0000000..b8eb41c
--- /dev/null
+++ b/.travis/run-build-deps.sh
@@ -0,0 +1,10 @@
+#!/bin/sh
+set -eux
+
+if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
+    # for windows we need to print output since openssl build
+    # might take more than 10 minutes, which causes build abort
+    .travis/build-deps.sh
+else
+    .travis/build-deps.sh > build-deps.log 2>&1 || (cat build-deps.log && exit 1)
+fi
-- 
2.7.4


