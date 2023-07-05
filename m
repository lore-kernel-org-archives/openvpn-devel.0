From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  5 Jul 2023 15:25:28 +0300
Message-Id: <20230705122528.1625-1-lstipakov@...277...>
In-Reply-To: <ZKVVvtdv4Ul88ABE@...2685...>
References: <ZKVVvtdv4Ul88ABE@...2685...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] openvpnmsica: link C runtime statically
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

By default CMake links C runtime dynamically,
which doesn't work on Windows 7, for example.

This is not an issue with other openvpn binaries,
since we bundle C runtime, but it is not yet available
during installation.

Change-Id: Ib2b014f075908e7db0d9115abaa2240e47fd27b9
Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2: fix MinGW build (apply changes to MSVC only)

 src/openvpnmsica/CMakeLists.txt | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpnmsica/CMakeLists.txt b/src/openvpnmsica/CMakeLists.txt
index 683d38e0..9126b80f 100644
--- a/src/openvpnmsica/CMakeLists.txt
+++ b/src/openvpnmsica/CMakeLists.txt
@@ -26,6 +26,14 @@ target_compile_options(openvpnmsica PRIVATE
     -UNTDDI_VERSION
     -D_WIN32_WINNT=_WIN32_WINNT_VISTA
     )
+
+if (MSVC)
+    target_compile_options(openvpnmsica PRIVATE
+        "$<$<CONFIG:Release>:/MT>"
+        "$<$<CONFIG:Debug>:/MTd>"
+        )
+endif ()
+
 target_link_libraries(openvpnmsica
     advapi32.lib ole32.lib msi.lib setupapi.lib iphlpapi.lib shell32.lib shlwapi.lib version.lib newdev.lib)
 if (MINGW)
-- 
2.38.1.windows.1


