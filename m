From: Lev Stipakov <lstipakov@...277...>
Date: Thu, 17 Mar 2022 14:23:57 +0200
Message-Id: <20220317122357.111-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] vcpkg-ports\openssl3: update to 3.0.2
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

While on it, remove deprecated vcpkg_fail_port_install().
since we don't care about UWP/Linux/OS X here.

Also bump github actions's vcpkg commit id.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 .github/workflows/build.yaml                | 2 +-
 contrib/vcpkg-ports/openssl3/portfile.cmake | 6 ++----
 contrib/vcpkg-ports/openssl3/vcpkg.json     | 2 +-
 3 files changed, 4 insertions(+), 6 deletions(-)

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 34d1dcce..fa99e12b 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -293,7 +293,7 @@ jobs:
       - name: Restore artifacts, or run vcpkg, build and cache artifacts
         uses: lukka/run-vcpkg@...2638...
         with:
-          vcpkgGitCommitId: 'a2fcb03749ff5897b5985092934dc6057680c789'
+          vcpkgGitCommitId: 'a69b65229b3956b7f45abd81671b7330114bcaad'
           vcpkgArguments: 'openssl3 lz4 lzo pkcs11-helper tap-windows6'
           vcpkgTriplet: '${{ matrix.triplet }}-windows-ovpn'
           cleanAfterBuild: false
diff --git a/contrib/vcpkg-ports/openssl3/portfile.cmake b/contrib/vcpkg-ports/openssl3/portfile.cmake
index 333ad171..40fe97b7 100644
--- a/contrib/vcpkg-ports/openssl3/portfile.cmake
+++ b/contrib/vcpkg-ports/openssl3/portfile.cmake
@@ -4,13 +4,11 @@ if(EXISTS ${CURRENT_INSTALLED_DIR}/include/openssl/ssl.h)
     message(FATAL_ERROR "Can't build '${PORT}' if another SSL library is installed. Please remove existing one and try install '${PORT}' again if you need it.")
 endif()
 
-vcpkg_fail_port_install(MESSAGE "${PORT} is only for Windows Desktop" ON_TARGET "UWP" "Linux" "OSX")
-
 vcpkg_from_github(
     OUT_SOURCE_PATH SOURCE_PATH
     REPO openssl/openssl
-    REF openssl-3.0.1
-    SHA512 7f303769a3a796b88478399d42aa2a9a70dc74f62c975bbb93e8903e3bb8e25f16ecfc436186c2d4aa7383302c73ad1dd8ac4fccaa589062bbce6059d6073f18
+    REF openssl-3.0.2
+    SHA512 d69c87b8250da813f282ead0bd005ebde663e77595ee8d99560d25f345570da2fa552b57c372956d461e3b631a19d6d60bebafe6ff89aeebbb5d34ad516b62ac
 )
 
 vcpkg_find_acquire_program(PERL)
diff --git a/contrib/vcpkg-ports/openssl3/vcpkg.json b/contrib/vcpkg-ports/openssl3/vcpkg.json
index 93db84b9..ecf7a8d0 100644
--- a/contrib/vcpkg-ports/openssl3/vcpkg.json
+++ b/contrib/vcpkg-ports/openssl3/vcpkg.json
@@ -1,6 +1,6 @@
 {
   "name": "openssl3",
-  "version-semver": "3.0.1",
+  "version-semver": "3.0.2",
   "description": "TLS/SSL and crypto library",
   "homepage": "https://www.openssl.org/",
   "license": "Apache-2.0"
-- 
2.23.0.windows.1


