From: Alon Bar-Lev <alon.barlev@...277...>
Date: Sat, 28 Apr 2012 21:29:01 +0300
Message-Id: <1335637741-15721-1-git-send-email-alon.barlev@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] =?utf-8?q?=5BPATCH=5D_build=3A_windows=3A_convert?=
	=?utf-8?q?_resources_to_UTF-8?=
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net
Cc: Alon Bar-Lev <alon.barlev@...277...>

Visual Studio 2010 editor supports UTF-8 files, we can store files in
standard encoding.

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 src/openvpn/openvpn_win32_resources.rc   |    4 +++-
 src/openvpnserv/openvpnserv_resources.rc |    4 +++-
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/openvpn_win32_resources.rc b/src/openvpn/openvpn_win32_resources.rc
index e1cd959..d092e21 100644
--- a/src/openvpn/openvpn_win32_resources.rc
+++ b/src/openvpn/openvpn_win32_resources.rc
@@ -5,6 +5,8 @@
 #endif
 #include <winresrc.h>
 
+#pragma code_page(65001) /* UTF8 */
+
 LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
 
 VS_VERSION_INFO VERSIONINFO
@@ -28,7 +30,7 @@ BEGIN
             VALUE "FileDescription", "OpenVPN Daemon"
             VALUE "FileVersion", PACKAGE_VERSION ".0"
             VALUE "InternalName", "OpenVPN"
-            VALUE "LegalCopyright", "Copyright � The OpenVPN Project" 
+            VALUE "LegalCopyright", "Copyright © The OpenVPN Project" 
             VALUE "OriginalFilename", "openvpn.exe"
             VALUE "ProductName", "OpenVPN"
             VALUE "ProductVersion", PACKAGE_VERSION ".0"
diff --git a/src/openvpnserv/openvpnserv_resources.rc b/src/openvpnserv/openvpnserv_resources.rc
index 9b79cb7..7980193 100644
--- a/src/openvpnserv/openvpnserv_resources.rc
+++ b/src/openvpnserv/openvpnserv_resources.rc
@@ -5,6 +5,8 @@
 #endif
 #include <winresrc.h>
 
+#pragma code_page(65001) /* UTF8 */
+
 LANGUAGE LANG_NEUTRAL, SUBLANG_NEUTRAL
 
 VS_VERSION_INFO VERSIONINFO
@@ -28,7 +30,7 @@ BEGIN
             VALUE "FileDescription", "OpenVPN Service"
             VALUE "FileVersion", PACKAGE_VERSION ".0"
             VALUE "InternalName", "OpenVPN"
-            VALUE "LegalCopyright", "Copyright � The OpenVPN Project" 
+            VALUE "LegalCopyright", "Copyright © The OpenVPN Project" 
             VALUE "OriginalFilename", "openvpnserv.exe"
             VALUE "ProductName", "OpenVPN"
             VALUE "ProductVersion", PACKAGE_VERSION ".0"
-- 
1.7.3.4


