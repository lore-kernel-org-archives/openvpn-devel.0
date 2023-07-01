From: Arne Schwabe <arne@...1227...>
Date: Sat,  1 Jul 2023 22:24:52 +0200
Message-Id: <20230701202453.3517822-1-arne@...1227...>
In-Reply-To: <20230629215611.3292788-1-arne@...1227...>
References: <20230629215611.3292788-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 3/4] Check if the -wrap argument is
 actually supported by the platform's ld
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

This avoids build errors on macOS. Also the test_tls_crypt command works
just fine on FreeBSD with its linkers, so do not make that test Linux only.

Patch v2: allow running with old cmake version (cmake 3 on RHEL7 with EPEL
          is only 3.17)

Change-Id: Id26676bdc576c7d3d6726afa43fe6c7a397c579b
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 CMakeLists.txt | 15 +++++++++++----
 1 file changed, 11 insertions(+), 4 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index acebbb73c..a982c478a 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -16,6 +16,7 @@ find_package(PkgConfig REQUIRED)
 include(CheckSymbolExists)
 include(CheckIncludeFiles)
 include(CheckCCompilerFlag)
+include(CheckLinkerFlag)
 include(CheckTypeSize)
 include(CheckStructHasMember)
 include(CTest)
@@ -560,18 +561,24 @@ if (BUILD_TESTING)
             )
     endif ()
 
-    if (NOT MSVC)
-        # MSVC does not support --wrap
+    # MSVC and Apple's LLVM ld do not support --wrap
+    # This test requires cmake >= 1.17, so check if check_linker_flag is
+    # available
+    if (COMMAND check_linker_flag)
+        check_linker_flag(C -Wl,--wrap=parse_line LD_SUPPORTS_WRAP)
+    endif()
+
+    if (${LD_SUPPORTS_WRAP})
         list(APPEND unit_tests
             "test_argv"
+            "test_tls_crypt"
             )
     endif ()
 
-    # These tests work on only on Linux since they depend on special linker features
+    # These tests work on only on Linux since they depend on special Linux features
     if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
         list(APPEND unit_tests
             "test_networking"
-            "test_tls_crypt"
             )
     endif ()
 
-- 
2.39.2 (Apple Git-143)


