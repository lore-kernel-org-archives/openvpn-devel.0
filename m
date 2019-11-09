From: Lev Stipakov <lstipakov@...277...>
Date: Sat,  9 Nov 2019 18:40:11 +0200
Message-Id: <1573317611-6462-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] travis: bump MSVC to 2019
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

Since we changed MSVC version in project files to 2019,
we have to do the same in travis script.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .travis/build-check.sh | 2 +-
 .travis/build-deps.sh  | 2 ++
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/.travis/build-check.sh b/.travis/build-check.sh
index d2d2e8a..039a7dc 100755
--- a/.travis/build-check.sh
+++ b/.travis/build-check.sh
@@ -2,7 +2,7 @@
 set -eux
 
 if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
-	PATH="/c/Program Files (x86)/Microsoft Visual Studio/2017/BuildTools/MSBuild/15.0/Bin/":$PATH
+	PATH="/c/Program Files (x86)/Microsoft Visual Studio/2019/BuildTools/MSBuild/Current/Bin/":$PATH
 	MSBuild.exe openvpn.sln //p:Platform=x64 && exit 0
 fi
 
diff --git a/.travis/build-deps.sh b/.travis/build-deps.sh
index 724ff30..4c5cb05 100755
--- a/.travis/build-deps.sh
+++ b/.travis/build-deps.sh
@@ -3,6 +3,8 @@ set -eux
 
 if [ "${TRAVIS_OS_NAME}" = "windows" ]; then
     choco install strawberryperl nasm
+    choco install visualstudio2019buildtools --package-parameters "--includeRecommended --includeOptional"
+    choco install visualstudio2019-workload-vctools
     cd ..
     git clone https://github.com/openvpn/openvpn-build.git
     cd openvpn-build
-- 
2.7.4


