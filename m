From: Gert Doering <gert@...1296...>
Date: Fri, 27 Dec 2024 12:22:55 +0100
Message-ID: <20241227112255.11992-1-gert@...1296...>
In-Reply-To: <gerrit.1735146911000.I350fd615ed8474d34392a057a5f8bded78173949@...2715...>
References: <gerrit.1735146911000.I350fd615ed8474d34392a057a5f8bded78173949@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Ensure that Python3 is available
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

From: Arne Schwabe <arne@...515...>

Use the more standard cmake find_package to search for Python3 and make it required. This also provides
a better error message than "version.cmake" not found when python3 is missing.

Change-Id: I350fd615ed8474d34392a057a5f8bded78173949
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/846
This mail reflects revision 2 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 61f0cc5..fc94a10 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -107,9 +107,9 @@
     endif ()
 endif ()
 
-find_program(PYTHON NAMES python3 python)
+find_package(Python3 REQUIRED COMPONENTS Interpreter)
 execute_process(
-    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/parse-version.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4
+    COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/parse-version.m4.py ${CMAKE_CURRENT_SOURCE_DIR}/version.m4
     WORKING_DIRECTORY ${CMAKE_CURRENT_BINARY_DIR}
     )
 include(${CMAKE_CURRENT_BINARY_DIR}/version.cmake)
@@ -339,7 +339,7 @@
 
 add_custom_command(
     OUTPUT always_rebuild config-version.h
-    COMMAND ${PYTHON} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/git-version.py
+    COMMAND ${Python3_EXECUTABLE} ${CMAKE_CURRENT_SOURCE_DIR}/contrib/cmake/git-version.py
     )
 set(HAVE_CONFIG_VERSION_H YES)
 

