From: Arne Schwabe <arne@...1227...>
Date: Thu, 29 Jun 2023 23:56:07 +0200
Message-Id: <20230629215611.3292788-2-arne@...1227...>
In-Reply-To: <20230629215611.3292788-1-arne@...1227...>
References: <20230629215611.3292788-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] Do not blindly assume python3 is also
 the interpreter that runs rst2html
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

On my system python3 is the macOS system python3 while rst2html has

   #!/opt/homebrew/opt/python@...2737.../bin/python3.9

as its first line. Running that with a different python results in missing
python modules. So directly execute the rst2html script instead.

Change-Id: I7e27ae031179c91cc1bca8122caf2453d6396ec0
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 doc/CMakeLists.txt | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/doc/CMakeLists.txt b/doc/CMakeLists.txt
index d38805513..2fba80bbd 100644
--- a/doc/CMakeLists.txt
+++ b/doc/CMakeLists.txt
@@ -50,13 +50,13 @@ if (_GENERATE_HTML_DOC)
     list(APPEND ALL_DOCS openvpn.8.html openvpn-examples.5.html)
     add_custom_command(
         OUTPUT openvpn.8.html
-        COMMAND ${PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8.html
+        COMMAND ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8.html
         MAIN_DEPENDENCY openvpn.8.rst
         DEPENDS ${OPENVPN_SECTIONS}
         )
     add_custom_command(
         OUTPUT openvpn-examples.5.html
-        COMMAND ${PYTHON} ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5.html
+        COMMAND ${RST2HTML} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5.html
         MAIN_DEPENDENCY openvpn-examples.5.rst
         DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}
         )
@@ -65,13 +65,13 @@ if (_GENERATE_MAN_DOC)
     list(APPEND ALL_DOCS openvpn.8 openvpn-examples.5)
     add_custom_command(
         OUTPUT openvpn.8
-        COMMAND ${PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8
+        COMMAND ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn.8.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn.8
         MAIN_DEPENDENCY openvpn.8.rst
         DEPENDS ${OPENVPN_SECTIONS}
         )
     add_custom_command(
         OUTPUT openvpn-examples.5
-        COMMAND ${PYTHON} ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5
+        COMMAND ${RST2MAN} ${RST_FLAGS} ${CMAKE_CURRENT_SOURCE_DIR}/openvpn-examples.5.rst ${CMAKE_CURRENT_BINARY_DIR}/openvpn-examples.5
         MAIN_DEPENDENCY openvpn-examples.5.rst
         DEPENDS ${OPENVPN_EXAMPLES_SECTIONS}
         )
-- 
2.39.2 (Apple Git-143)


