From: Simon Rozman <simon@...2293...>
Date: Mon, 12 Nov 2018 13:22:44 +0100
Message-Id: <20181112122246.13556-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/3] Delete TAP interface before the TAP
 driver is uninstalled
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

The previous version of MSI installer did:
- Execution Pass:       rename the TAP interface to some temporary name
- Commit/Rollback Pass: delete the TAP interface / rename the interface
                        back to original name

However, the WiX Toolset's Diffx extension to install and remove drivers
removed the TAP driver between the execution and commit passes. The TAP
driver removal makes all TAP interfaces unavailable and our custom
action couldn't find the interface to delete any more.

While the system where OpenVPN was uninstalled didn't have any TAP
interfaces any more as expected behaviour, the problem appears after
reinstalling the OpenVPN. Some residue TAP interface registry keys
remain on the system, causing the TAP interface to reappear as "Ethernet
NN" interface next time the TAP driver is installed. This causes TAP
interfaces to accumulate when cycling install-uninstall-install...

Therefore, it is better to remove the TAP interfaces before the TAP
driver is removed, and reinstall the TAP interface back should the
rollback be required. Though it won't be exactly the same interface
again.

I wonder if the WiX Diffx extension supports execute/commit/rollback
feature of MSI in the first place.
---
 src/openvpnmsica/msica_op.c | 87 ++++++++++++++-----------------------
 1 file changed, 33 insertions(+), 54 deletions(-)

diff --git a/src/openvpnmsica/msica_op.c b/src/openvpnmsica/msica_op.c
index 8e9a3832..2ce69444 100644
--- a/src/openvpnmsica/msica_op.c
+++ b/src/openvpnmsica/msica_op.c
@@ -454,62 +454,41 @@ msica_op_tap_interface_delete(
 
     DWORD dwResult;
 
-    if (session->rollback_enabled)
-    {
-        int count = 0;
-
-        do {
-            /* Rename the interface to keep it as a backup. */
-            TCHAR szNameBackup[10/*"Interface "*/ + 10/*maximum int*/ + 1/*terminator*/];
-            _stprintf_s(
-                szNameBackup, _countof(szNameBackup),
-                TEXT("Interface %i"),
-                ++count);
-            for (struct tap_interface_node *pInterfaceOther = pInterfaceList; ; pInterfaceOther = pInterfaceOther->pNext)
-            {
-                if (pInterfaceOther == NULL)
-                {
-                    /* No interface with a same name found. All clear to rename the interface. */
-                    dwResult = tap_set_interface_name(&pInterface->guid, szNameBackup);
-                    break;
-                }
-                else if (_tcsicmp(szNameBackup, pInterfaceOther->szName) == 0)
-                {
-                    /* Interface with a same name found. Duplicate interface names are not allowed. */
-                    dwResult = ERROR_ALREADY_EXISTS;
-                    break;
-                }
-            }
-        } while (dwResult == ERROR_ALREADY_EXISTS);
+    /* Delete the interface. */
+    BOOL bRebootRequired = FALSE;
+    dwResult = tap_delete_interface(NULL, &pInterface->guid, &bRebootRequired);
+    if (bRebootRequired)
+        MsiSetMode(session->hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
 
-        if (dwResult == ERROR_SUCCESS) {
-            /* Schedule rollback action to rename the interface back. */
-            msica_op_seq_add_head(
-                &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
-                msica_op_create_guid_string(
-                    msica_op_tap_interface_set_name,
-                    0,
-                    NULL,
-                    &pInterface->guid,
-                    pInterface->szName));
-
-            /* Schedule commit action to delete the interface. */
-            msica_op_seq_add_tail(
-                &session->seq_cleanup[MSICA_CLEANUP_ACTION_COMMIT],
-                msica_op_create_guid(
-                    msica_op_tap_interface_delete_by_guid,
-                    0,
-                    NULL,
-                    &pInterface->guid));
-        }
-    }
-    else
+    if (session->rollback_enabled)
     {
-        /* Delete the interface. */
-        BOOL bRebootRequired = FALSE;
-        dwResult = tap_delete_interface(NULL, &pInterface->guid, &bRebootRequired);
-        if (bRebootRequired)
-            MsiSetMode(session->hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
+        /*
+        Schedule rollback action to create the interface back. Though it won't be exactly the same interface again.
+
+        The previous version of this function did:
+        - Execution Pass:       rename the interface to some temporary name
+        - Commit/Rollback Pass: delete the interface / rename the interface back to original name
+
+        However, the WiX Toolset's Diffx extension to install and remove drivers removed the TAP driver between the
+        execution and commit passes. TAP driver removal makes all TAP interfaces unavailable and our CA couldn't find
+        the interface to delete any more.
+
+        While the system where OpenVPN was uninstalled didn't have any TAP interfaces any more as expected behaviour,
+        the problem appears after reinstalling the OpenVPN. Some residue TAP interface registry keys remain on the
+        system, causing the TAP interface to reappear as "Ethernet NN" interface next time the TAP driver is
+        installed. This causes TAP interfaces to accumulate over cyclic install-uninstall-install...
+
+        Therefore, it is better to remove the TAP interfaces before the TAP driver is removed, and reinstall the TAP
+        interface back should the rollback be required. I wonder if the WiX Diffx extension supports execute/commit/
+        rollback feature of MSI in the first place.
+        */
+        msica_op_seq_add_head(
+            &session->seq_cleanup[MSICA_CLEANUP_ACTION_ROLLBACK],
+            msica_op_create_string(
+                msica_op_tap_interface_create,
+                0,
+                NULL,
+                pInterface->szName));
     }
 
     return dwResult;
-- 
2.19.1.windows.1


