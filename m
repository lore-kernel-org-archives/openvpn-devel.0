From: Gert Doering <gert@...1296...>
Date: Wed,  7 May 2025 14:12:20 +0200
Message-ID: <20250507121226.13824-1-gert@...1296...>
In-Reply-To: <gerrit.1746615872000.I2551edfaaf5107649398a3fa1db2009ee8644671@...2715...>
References: <gerrit.1746615872000.I2551edfaaf5107649398a3fa1db2009ee8644671@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] CMake: Make sure to treat
 UNIT_TEST_SOURCEDIR as path
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

From: Frank Lichtenheld <frank@...2641...>

This makes sure that it is properly normalized, and
on Windows seems to prevent CMake from using back
slashes which would break the build due to "unknown escape
sequence" errors.

Change-Id: I2551edfaaf5107649398a3fa1db2009ee8644671
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/981
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index a8fb64b..6687b56 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -679,11 +679,11 @@
     endif ()
 
     foreach (test_name ${unit_tests})
+        cmake_path(SET _UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_tests/openvpn)
         # test_networking needs special environment
         if (NOT ${test_name} STREQUAL "test_networking")
             add_test(${test_name} ${test_name})
             # for compat with autotools make check
-            set(_UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_tests/openvpn)
             set_tests_properties(${test_name} PROPERTIES
                 ENVIRONMENT "srcdir=${_UT_SOURCE_DIR}")
         endif ()
@@ -703,7 +703,7 @@
 
         # for compat with IDEs like Clion that ignore the tests properties
         # for the environment variable srcdir when running tests as fallback
-        target_compile_definitions(${test_name} PRIVATE "-DUNIT_TEST_SOURCEDIR=\"${CMAKE_SOURCE_DIR}/tests/unit_tests/openvpn\"")
+        target_compile_definitions(${test_name} PRIVATE "UNIT_TEST_SOURCEDIR=\"${_UT_SOURCE_DIR}\"")
 
         if (NOT ${test_name} STREQUAL "test_buffer")
             target_sources(${test_name} PRIVATE

