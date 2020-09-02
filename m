From: Lev Stipakov <lstipakov@...277...>
Date: Wed,  2 Sep 2020 15:39:38 +0300
Message-Id: <20200902123938.188-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] openvpnmsica: remove adapter renaming
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

Renaming doesn't work on some machines (https://github.com/OpenVPN/openvpn-build/issues/187)
and we couldn't find the cause. Also others do not seem to do it, so let's get rid of it.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnmsica/openvpnmsica.c | 9 ---------
 1 file changed, 9 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index 31e90bd2..10d4a1cc 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -1094,15 +1094,6 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 
             GUID guidAdapter;
             dwResult = tap_create_adapter(NULL, NULL, szHardwareId, &bRebootRequired, &guidAdapter);
-            if (dwResult == ERROR_SUCCESS)
-            {
-                /* Set adapter name. */
-                dwResult = tap_set_adapter_name(&guidAdapter, szName);
-                if (dwResult != ERROR_SUCCESS)
-                {
-                    tap_delete_adapter(NULL, &guidAdapter, &bRebootRequired);
-                }
-            }
         }
         else if (wcsncmp(szArg[i], L"deleteN=", 8) == 0)
         {
-- 
2.17.1


