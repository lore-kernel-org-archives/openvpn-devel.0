From: Frank Lichtenheld <frank@...2641...>
Date: Tue,  4 Jul 2023 15:09:02 +0200
Message-Id: <20230704130902.105585-1-frank@...2641...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] CMake: Support doc builds on Windows
 machines that do not have .py file association
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

On Windows we might need to call python because .py files are not
directly executable. This is true e.g. for GHA runners.
For now we assume that rst2html and rst2man can be handled in the same
way and do not test both of them.

Commit e8881ec6dd63bd80ce05202573eac54ab8657fcb unconditionally
used $PYTHON, but that broke build on systems where the default
python can't be used and we need to respect the shebang.
Commit 5dbec1c019d14880ae7bf364b062d3589c7fd9e7 unconditionally
did not use $PYTHON, but that broke build on the aformentioned
GHA runners.
This commit tries to establish a solution that works for both
systems.

Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
 doc/CMakeLists.txt | 42 +++++++++++++++++++++++++++++++++++++-----
 1 file changed, 37 insertions(+), 5 deletions(-)

diff --git a/doc/CMakeLists.txt b/doc/CMakeLists.txt
index 2fba80bb..5e729efa 100644
--- a/doc/CMakeLists.txt
+++ b/doc/CMakeLists.txt
@@ -1,14 +1,46 @@
 set(_GENERATE_HTML_DOC YES)
 set(_GENERATE_MAN_DOC  YES)
+set(_MAYBE_PYTHON "")
 find_program(RST2HTML NAMES rst2html rst2html.py)
 find_program(RST2MAN  NAMES rst2man  rst2man.py)
 
 if (RST2HTML STREQUAL "RST2HTML-NOTFOUND")
     message(STATUS "rst2html not found, not generating HTML documentation")
     set(_GENERATE_HTML_DOC NO)
+else ()
+    # We only run this for RST2HTML and assume the result would be the same
+    # for RST2MAN
+    if (DEFINED CACHE{DOCUTILS_NEED_PYTHON})
+        if ($CACHE{DOCUTILS_NEED_PYTHON})
+            set(_MAYBE_PYTHON ${PYTHON})
+        endif ()
+    else ()
+        execute_process(
+            COMMAND ${RST2HTML} --version
+            OUTPUT_VARIABLE RST2HTML_VERSION_EXE
+            )
+        execute_process(
+            COMMAND ${PYTHON} ${RST2HTML} --version
+            OUTPUT_VARIABLE RST2HTML_VERSION_PY
+            )
+        set(_DOCUTILS_NEED_PYTHON OFF)
+        if(RST2HTML_VERSION_EXE STREQUAL "")
+            if(RST2HTML_VERSION_PY STREQUAL "")
+                message(STATUS "${RST2HTML} found but not working, not generating documentation")
+                set(_GENERATE_HTML_DOC NO)
+                set(_GENERATE_MAN_DOC NO)
+            else ()
+                message(STATUS "${RST2HTML} needs to be executed by ${PYTHON} to work")
+                set(_MAYBE_PYTHON ${PYTHON})
+                set(_DOCUTILS_NEED_PYTHON ON)
+            endif ()
+        endif ()
+        set(DOCUTILS_NEED_PYTHON ${_DOCUTILS_NEED_PYTHON} CACHE BOOL
+            "Whether we need to call python instead of rst2*.py directly")
+    endif (DEFINED CACHE{DOCUTILS_NEED_PYTHON})
 endif ()
 if (RST2MAN STREQUAL "RST2MAN-NOTFOUND")
-    message(STATUS "rst2man not found, not generating HTML documentation")
+    message(STATUS "rst2man not found, not generating man pages")
     set(_GENERATE_MAN_DOC NO)
 endif ()
 
@@ -50,13 +82,13 @@ if (_GENERATE_HTML_DOC)
     list(APPEND ALL_DOCS openvpn.8.html openvpn-examples.5.html)
     add_custom_command(
         OUTPUT openvpn.8.html
-        COMMAND ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8.html
+        COMMAND ${_MAYBE_PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8.html
         MAIN_DEPENDENCY openvpn.8.rst
         DEPENDS ${OPENVPN_SECTIONS}
         )
     add_custom_command(
         OUTPUT openvpn-examples.5.html
-        COMMAND ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5.html
+        COMMAND ${_MAYBE_PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5.html
         MAIN_DEPENDENCY openvpn-examples.5.rst
         DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}
         )
@@ -65,13 +97,13 @@ if (_GENERATE_MAN_DOC)
     list(APPEND ALL_DOCS openvpn.8 openvpn-examples.5)
     add_custom_command(
         OUTPUT openvpn.8
-        COMMAND ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8
+        COMMAND ${_MAYBE_PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8
         MAIN_DEPENDENCY openvpn.8.rst
         DEPENDS ${OPENVPN_SECTIONS}
         )
     add_custom_command(
         OUTPUT openvpn-examples.5
-        COMMAND ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5
+        COMMAND ${_MAYBE_PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5
         MAIN_DEPENDENCY openvpn-examples.5.rst
         DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}
         )
-- 
2.34.1


