From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 24 Jan 2023 11:14:41 +0200
Message-Id: <20230124091441.397-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] openvpnmsica: remove unused declarations
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

That code has been moved to MSM by commit 640c4d82
("openvpnmsica: remove dco installer custom actions")

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnmsica/openvpnmsica.h | 26 --------------------------
 1 file changed, 26 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 64f73733..05889cc8 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -151,32 +151,6 @@ DLLEXP_DECL UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall);
 
 
-/**
- * Check what operation shall be performed on ovpn-dco driver
- * and set data value (path to inf and user temp dir) for ProcessDriver action.
- *
- * @param hInstall      Handle to the installation provided to the DLL custom action
- *
- * @return ERROR_SUCCESS on success; An error code otherwise
- *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
- */
-DLLEXP_DECL UINT __stdcall
-EvaluateDriver(_In_ MSIHANDLE hInstall);
-
-
-/**
- * Install or uninstall ovpn-dco driver, removing all adapters using that driver.
- * If reboot is required, creates reboot indication file in user's temp directory
- *
- * @param hInstall      Handle to the installation provided to the DLL custom action
- *
- * @return ERROR_SUCCESS on success; An error code otherwise
- *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
- */
-DLLEXP_DECL UINT __stdcall
-ProcessDriver(_In_ MSIHANDLE hInstall);
-
-
 /**
  * Schedule reboot after installation if reboot
  * indication file is found in user's temp directory
-- 
2.38.1.windows.1


