From: Lev Stipakov <lstipakov@...277...>
Date: Tue, 11 May 2021 10:57:39 +0300
Message-Id: <20210511075739.158-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] openvpnmsica: properly schedule reboot in
 the end of installation
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

A deferred custom action can not set the reboot status via MsiSetMode.

To schedule reboot:

 - get user's temp directory in immediate custom action (EvaluateTUNTAPAdapters)
which is called in the beginning of installation and pass it to the deffered action

 - in deferred action (ProcessDeferredAction) create a special empty file in user's temp
directory if reboot is required

 - in the end of installation call immediate custom action (CheckAndScheduleReboot) which
checks the existence of special file and uses MsiSetMode() to schedule reboot

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpnmsica/openvpnmsica.c | 90 ++++++++++++++++++++++++++++++++-
 src/openvpnmsica/openvpnmsica.h | 13 +++++
 2 files changed, 101 insertions(+), 2 deletions(-)

diff --git a/src/openvpnmsica/openvpnmsica.c b/src/openvpnmsica/openvpnmsica.c
index de1cf65c..96652117 100644
--- a/src/openvpnmsica/openvpnmsica.c
+++ b/src/openvpnmsica/openvpnmsica.c
@@ -59,6 +59,7 @@
 
 #define MSICA_ADAPTER_TICK_SIZE (16*1024) /** Amount of tick space to reserve for one TAP/TUN adapter creation/deletition. */
 
+#define FILE_NEED_REBOOT        L".ovpn_need_reboot"
 
 /**
  * Joins an argument sequence and sets it to the MSI property.
@@ -956,6 +957,19 @@ cleanup_hRecord:
         }
     }
 
+    /* save path to user's temp dir to be used later by deferred actions */
+    TCHAR tmpDir[MAX_PATH];
+    GetTempPath(MAX_PATH, tmpDir);
+
+    TCHAR str[MAX_PATH + 7];
+    _stprintf_s(str, _countof(str), TEXT("tmpdir=%") TEXT(PRIsLPTSTR), tmpDir);
+    msica_arg_seq_add_tail(&seqInstall, str);
+    msica_arg_seq_add_tail(&seqInstallCommit, str);
+    msica_arg_seq_add_tail(&seqInstallRollback, str);
+    msica_arg_seq_add_tail(&seqUninstall, str);
+    msica_arg_seq_add_tail(&seqUninstallCommit, str);
+    msica_arg_seq_add_tail(&seqUninstallRollback, str);
+
     /* Store deferred custom action parameters. */
     if ((uiResult = setup_sequence(hInstall, TEXT("InstallTUNTAPAdapters"          ), &seqInstall          )) != ERROR_SUCCESS
         || (uiResult = setup_sequence(hInstall, TEXT("InstallTUNTAPAdaptersCommit"    ), &seqInstallCommit    )) != ERROR_SUCCESS
@@ -1015,6 +1029,33 @@ parse_guid(
 }
 
 
+/**
+ * Create empty file in user's temp directory. The existence of this file
+ * is checked in the end of installation by ScheduleReboot immediate custom action
+ * which schedules reboot.
+ *
+ * @param szTmpDir path to user's temp dirctory
+ *
+ */
+static void
+CreateRebootFile(_In_z_ LPCWSTR szTmpDir)
+{
+    TCHAR path[MAX_PATH];
+    swprintf_s(path, _countof(path), L"%s%s", szTmpDir, FILE_NEED_REBOOT);
+
+    msg(M_WARN, "%s: Reboot required, create reboot indication file \"%" PRIsLPTSTR "\"", __FUNCTION__, path);
+
+    HANDLE file = CreateFile(path, GENERIC_WRITE, 0, NULL, CREATE_ALWAYS, FILE_ATTRIBUTE_NORMAL, NULL);
+    if (file == INVALID_HANDLE_VALUE)
+    {
+        msg(M_NONFATAL | M_ERRNO, "%s: CreateFile(\"%" PRIsLPTSTR "\") failed", __FUNCTION__, path);
+    }
+    else
+    {
+        CloseHandle(file);
+    }
+}
+
 UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 {
@@ -1026,6 +1067,7 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
 
     UINT uiResult;
     BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+    WCHAR tmpDir[MAX_PATH] = {0};
 
     OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
 
@@ -1168,6 +1210,10 @@ ProcessDeferredAction(_In_ MSIHANDLE hInstall)
             }
             dwResult = tap_enable_adapter(NULL, &guid, FALSE, &bRebootRequired);
         }
+        else if (wcsncmp(szArg[i], L"tmpdir=", 7) == 0)
+        {
+            wcscpy_s(tmpDir, _countof(tmpDir), szArg[i] + 7);
+        }
         else
         {
             goto invalid_argument;
@@ -1194,9 +1240,9 @@ invalid_argument:
     }
 
 cleanup:
-    if (bRebootRequired)
+    if (bRebootRequired && wcslen(tmpDir) > 0)
     {
-        MsiSetMode(hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
+        CreateRebootFile(tmpDir);
     }
     MsiCloseHandle(hRecordProg);
     LocalFree(szArg);
@@ -1209,3 +1255,43 @@ cleanup_CoInitialize:
     }
     return uiResult;
 }
+
+UINT __stdcall
+CheckAndScheduleReboot(_In_ MSIHANDLE hInstall)
+{
+#ifdef _MSC_VER
+#pragma comment(linker, DLLEXP_EXPORT)
+#endif
+
+    debug_popup(TEXT(__FUNCTION__));
+
+    UINT ret = ERROR_SUCCESS;
+    BOOL bIsCoInitialized = SUCCEEDED(CoInitialize(NULL));
+
+    OPENVPNMSICA_SAVE_MSI_SESSION(hInstall);
+
+    /* get user-specific temp path, to where we create reboot indication file */
+    TCHAR tempPath[MAX_PATH];
+    GetTempPath(MAX_PATH, tempPath);
+
+    /* check if reboot file exists */
+    TCHAR path[MAX_PATH];
+    _stprintf_s(path, _countof(path), L"%s%s", tempPath, FILE_NEED_REBOOT);
+    WIN32_FIND_DATA data = { 0 };
+    HANDLE searchHandle = FindFirstFile(path, &data);
+    if (searchHandle != INVALID_HANDLE_VALUE)
+    {
+        msg(M_WARN, "%s: Reboot file exists, schedule reboot", __FUNCTION__);
+
+        FindClose(searchHandle);
+        DeleteFile(path);
+
+        MsiSetMode(hInstall, MSIRUNMODE_REBOOTATEND, TRUE);
+    }
+
+    if (bIsCoInitialized)
+    {
+        CoUninitialize();
+    }
+    return ret;
+}
diff --git a/src/openvpnmsica/openvpnmsica.h b/src/openvpnmsica/openvpnmsica.h
index 221d03ca..5af68470 100644
--- a/src/openvpnmsica/openvpnmsica.h
+++ b/src/openvpnmsica/openvpnmsica.h
@@ -146,6 +146,19 @@ EvaluateTUNTAPAdapters(_In_ MSIHANDLE hInstall);
 DLLEXP_DECL UINT __stdcall
 ProcessDeferredAction(_In_ MSIHANDLE hInstall);
 
+
+/**
+ * Schedule reboot after installation if reboot
+ * indication file is found in user's temp directory
+ *
+ * @param hInstall      Handle to the installation provided to the DLL custom action
+ *
+ * @return ERROR_SUCCESS on success; An error code otherwise
+ *         See: https://msdn.microsoft.com/en-us/library/windows/desktop/aa368072.aspx
+ */
+DLLEXP_DECL UINT __stdcall
+CheckAndScheduleReboot(_In_ MSIHANDLE hInstall);
+
 #ifdef __cplusplus
 }
 #endif
-- 
2.17.1


