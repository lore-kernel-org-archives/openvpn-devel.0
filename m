From: Frank Lichtenheld <frank@...2641...>
Date: Mon,  3 Jul 2023 17:39:25 +0200
Message-Id: <20230703153925.48990-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] CMake: Throw a clear error when config.h in
 top-level source directory
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

This causes weird, difficult to debug compilation errors. Usually
caused by trying to run CMake against a source that had an
in-tree autoconfig build.

Note that you're able to do out-of-tree autoconfig builds and
they can obviously mix with out-of-tree cmake builds.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 CMakeLists.txt | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/CMakeLists.txt b/CMakeLists.txt
index acebbb73..597dc907 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -26,6 +26,10 @@ if (NOT WIN32 AND NOT ${UNSUPPORTED_BUILDS})
     message(FATAL_ERROR "Note: on Unix platform the official and supported build method is using autoconfig. CMake based build should be only used for Windows and internal testing/development.")
 endif()
 
+if (EXISTS "${CMAKE_CURRENT_SOURCE_DIR}/config.h")
+    message(FATAL_ERROR "The top level source directory has a config.h file. Note that you can't mix in-tree autoconfig builds with out-of-tree cmake builds.")
+endif ()
+
 option(MBED "BUILD with mbed" OFF)
 option(WOLFSSL "BUILD with wolfSSL" OFF)
 option(ENABLE_LZ4 "BUILD with lz4" ON)
-- 
2.34.1


