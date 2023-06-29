From: Arne Schwabe <arne@...1227...>
Date: Thu, 29 Jun 2023 12:39:53 +0200
Message-Id: <20230629103953.3238575-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] [CMake] Only add -Wno-stringop-truncation
 on supported compilers
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

The -Wno-stringop-truncation flag is only supported by some GCC versions
and not by Clang (macOS, FreeBSD) at all.

Change-Id: I452bc4ee935d13f8e9095d0a31805a3bbaff0cec
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 CMakeLists.txt | 20 ++++++++++++--------
 1 file changed, 12 insertions(+), 8 deletions(-)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3cbba5a38..ec0915bb0 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -12,6 +12,14 @@ project(openvpn)
 # and OpenSSL having version 1.1.1+ and generally does not offer the same
 # configurability like autoconf
 
+find_package(PkgConfig REQUIRED)
+include(CheckSymbolExists)
+include(CheckIncludeFiles)
+include(CheckCCompilerFlag)
+include(CheckTypeSize)
+include(CheckStructHasMember)
+include(CTest)
+
 option(UNSUPPORTED_BUILDS "Allow unsupported builds" OFF)
 
 if (NOT WIN32 AND NOT ${UNSUPPORTED_BUILDS})
@@ -70,7 +78,10 @@ else ()
     set(CMAKE_CXX_FLAGS_RELEASE "-O2")
     set(CMAKE_C_FLAGS_DEBUG "-g -O1")
     set(CMAKE_CXX_FLAGS_DEBUG "-g -O1")
-    add_compile_options(-Wall -Wuninitialized -Wno-stringop-truncation)
+    check_c_compiler_flag(-Wno-stringop-truncation NoStringOpTruncation)
+    if (${NoStringOpTruncation})
+        add_compile_options(-Wall -Wuninitialized )
+    endif()
     # We are not ready for this
     #add_compile_options(-Wconversion -Wno-sign-conversion -Wsign-compare)
     if (USE_WERROR)
@@ -78,13 +89,6 @@ else ()
     endif ()
 endif ()
 
-find_package(PkgConfig REQUIRED)
-include(CheckSymbolExists)
-include(CheckIncludeFiles)
-include(CheckTypeSize)
-include(CheckStructHasMember)
-include(CTest)
-
 find_program(PYTHON NAMES python3 python)
 execute_process(
     COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/parse-version.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4
-- 
2.39.2 (Apple Git-143)


