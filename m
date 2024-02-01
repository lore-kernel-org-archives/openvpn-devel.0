From: Frank Lichtenheld <frank@...2641...>
Date: Thu,  1 Feb 2024 13:30:39 +0100
Message-Id: <20240201123039.174176-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] README.cmake.md: Document minimum required
 CMake version for --preset
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

CMakePreset.json is supported since 3.19, but we have a version
3 preset file, so need at least 3.21.

Github: OpenVPN/openvpn#489
Change-Id: I44c555f6ffa08f2aee739c7f687fa3b678c86231
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 README.cmake.md | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/README.cmake.md b/README.cmake.md
index 4f41c701..89d9419d 100644
--- a/README.cmake.md
+++ b/README.cmake.md
@@ -17,6 +17,10 @@ also makes cross-building with MinGW on Linux much simpler. However,
 builds are also possible by providing the build dependencies manually,
 but that might require specifying more information to CMake.
 
+You need at least CMake version 3.21 or newer for the `CMakePreset.json`
+file to be supported. Manual builds might be possible with older CMake
+versions, see `cmake_minimum_required` in `CMakeLists.txt`.
+
 If you're looking to build the full Windows installer MSI, take a look
 at https://github.com/OpenVPN/openvpn-build.git .
 
@@ -27,7 +31,7 @@ The following tools are expected to be present on the system, you
 can install them with a package manager of your choice (e.g.
 chocolatey, winget) or manually:
 
-* CMake
+* CMake (>= 3.21)
 * Git
 * Python (3.x), plus the Python module `docutils`
 * Visual Studion 17 (2022), C/C++ Enviroment
@@ -101,6 +105,7 @@ To build the Windows executables on a Linux system:
     git clone https://github.com/OpenVPN/openvpn.git
     export VCPKG_ROOT=$PWD/vcpkg
     cd openvpn
+    # requires CMake 3.21 or newer
     cmake --preset mingw-x64
     cmake --build --preset mingw-x64
     # unit tests are built, but no testPreset is provided. You need to copy
-- 
2.34.1


