From: Christopher Ng <facboy@...277...>
Date: Tue,  7 Jun 2022 17:30:49 +0100
Message-Id: <20220607163049.10056-2-facboy@...277...>
In-Reply-To: <20220607163049.10056-1-facboy@...277...>
References: <20220607163049.10056-1-facboy@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH OpenVPN3 2/2] omi: add support for
 ovpn-dco-win
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

Signed-off-by: Christopher Ng <facboy@...277...>
---
 openvpn/omi/CMakeLists.txt | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/openvpn/omi/CMakeLists.txt b/openvpn/omi/CMakeLists.txt
index d773da39..cd7cb8fd 100644
--- a/openvpn/omi/CMakeLists.txt
+++ b/openvpn/omi/CMakeLists.txt
@@ -1,3 +1,5 @@
+option(CLI_OVPNDCOWIN "Build ovpncli with ovpn-dco-win driver support" OFF)
+
 add_executable(omicliagent openvpn.cpp)
 add_core_dependencies(omicliagent)
 add_json_library(omicliagent)
@@ -5,3 +7,10 @@ target_compile_definitions(omicliagent PRIVATE -DOPENVPN_COMMAND_AGENT -DOVPNAGE
 
 add_executable(omicli openvpn.cpp)
 add_core_dependencies(omicli)
+
+if (WIN32 AND ${CLI_OVPNDCOWIN})
+    target_compile_definitions(omicliagent PRIVATE ENABLE_OVPNDCOWIN)
+    target_compile_definitions(omicli PRIVATE ENABLE_OVPNDCOWIN)
+    target_link_libraries(omicliagent "bcrypt.lib")
+    target_link_libraries(omicli "bcrypt.lib")
+endif ()
-- 
2.34.1


