From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 27 Jul 2021 01:39:20 +0300
Message-Id: <20210726223920.144-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] GitHub Actions: fix MSVC builds
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

By reasons remain unknown, MSVC GitHub Actions
started to fail after some irrelevant change.

While problem is also reproduced on my GitHub fork,
I couldn't reproduce it locally. Despiteadding
debug logging to GitHub Actions it is not clear
what went wrong:

 ##[debug]Exit code '3221225477' received from command
 '"D:\a\openvpn\openvpn\vcpkg\vcpkg.exe"'

Turns out that update to a newer vcpkg commit fixed the problem.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 5d7dd37b..b2c16449 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -211,7 +211,7 @@ jobs:
         with:
           vcpkgArguments: 'openssl lz4 lzo pkcs11-helper tap-windows6'
           vcpkgTriplet: '${{ matrix.triplet }}-windows-ovpn'
-          vcpkgGitCommitId: '7d472dd25830da92108eb76642c667aaa40512cb'
+          vcpkgGitCommitId: '261c458af6e3eed5d099144aff95d2b5035f656b'
           cleanAfterBuild: false
 
       - name: Build
-- 
2.23.0.windows.1


