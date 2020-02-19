From: selva.nair@...277...
Date: Tue, 18 Feb 2020 20:54:21 -0500
Message-Id: <1582077261-9467-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2.4 v3] Swap the order of checks for
 validating interactive service user
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

From: Selva Nair <selva.nair@...277...>

Check the config file location and command line options first
and membership in OpenVPNAdministrators group after that as
the latter could be a slow process for active directory users.

When connection to domain controllers is poor or unavailable, checking
the group membership is slow and causes timeouts in the GUI (Trac
1051). However, in cases where the config is in the global directory,
no group membership check should be required. The re-ordering here
avoids the redundant check in such cases.

In addition to this, its also proposed to improve the timeout handling
in the GUI, but this change is still useful as it should completely
eliminate the timeout issue for many users.

v3: Do not send error message to the client pipe from ValidateOptions().
Instead save the error and send it on only if user authorization also
fails. The error buffer size is increased to 512 wide chars as these
messages could get long in some cases and may get truncated otherwise.

Also see: https://github.com/OpenVPN/openvpn-gui/issues/332

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 cherry-picked from commit c6cc66a13568dd1078bfbeb763998c1b9e2a2999
 with one change:
 - openvpn_swprintf() -> swprintf() as the latter is not readily accessible
   here in 2.4

 src/openvpnserv/interactive.c | 39 ++++++++++++++++++++++-----------------
 1 file changed, 22 insertions(+), 17 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d7c9eea..a2b3b20 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -360,14 +360,13 @@ ReturnOpenvpnOutput(HANDLE pipe, HANDLE ovpn_output, DWORD count, LPHANDLE event
 /*
  * Validate options against a white list. Also check the config_file is
  * inside the config_dir. The white list is defined in validate.c
- * Returns true on success
+ * Returns true on success, false on error with reason set in errmsg.
  */
 static BOOL
-ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
+ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options, WCHAR *errmsg, DWORD capacity)
 {
     WCHAR **argv;
     int argc;
-    WCHAR buf[256];
     BOOL ret = FALSE;
     int i;
     const WCHAR *msg1 = L"You have specified a config file location (%s relative to %s)"
@@ -382,8 +381,10 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
 
     if (!argv)
     {
-        ReturnLastError(pipe, L"CommandLineToArgvW");
-        ReturnError(pipe, ERROR_STARTUP_DATA, L"Cannot validate options", 1, &exit_event);
+        swprintf(errmsg, capacity,
+	         L"Cannot validate options: CommandLineToArgvW failed with error = 0x%08x",
+	         GetLastError());
+        errmsg[capacity-1] = L'\0';
         goto out;
     }
 
@@ -403,10 +404,9 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
 
         if (!CheckOption(workdir, 2, argv_tmp, &settings))
         {
-            swprintf(buf, _countof(buf), msg1, argv[0], workdir,
+            swprintf(errmsg, capacity, msg1, argv[0], workdir,
                      settings.ovpn_admin_group);
-            buf[_countof(buf) - 1] = L'\0';
-            ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
+            errmsg[capacity-1] = L'\0';
         }
         goto out;
     }
@@ -422,18 +422,15 @@ ValidateOptions(HANDLE pipe, const WCHAR *workdir, const WCHAR *options)
         {
             if (wcscmp(L"--config", argv[i]) == 0 && argc-i > 1)
             {
-                swprintf(buf, _countof(buf), msg1, argv[i+1], workdir,
+                swprintf(errmsg, capacity, msg1, argv[i+1], workdir,
                          settings.ovpn_admin_group);
-                buf[_countof(buf) - 1] = L'\0';
-                ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
             }
             else
             {
-                swprintf(buf, _countof(buf), msg2, argv[i],
+                swprintf(errmsg, capacity, msg2, argv[i],
                          settings.ovpn_admin_group);
-                buf[_countof(buf) - 1] = L'\0';
-                ReturnError(pipe, ERROR_STARTUP_DATA, buf, 1, &exit_event);
             }
+            errmsg[capacity-1] = L'\0';
             goto out;
         }
     }
@@ -1367,6 +1364,7 @@ RunOpenvpn(LPVOID p)
     WCHAR *cmdline = NULL;
     size_t cmdline_size;
     undo_lists_t undo_lists;
+    WCHAR errmsg[512] = L"";
 
     SECURITY_ATTRIBUTES inheritable = {
         .nLength = sizeof(inheritable),
@@ -1459,10 +1457,17 @@ RunOpenvpn(LPVOID p)
         goto out;
     }
 
-    /* Check user is authorized or options are white-listed */
-    if (!IsAuthorizedUser(ovpn_user->User.Sid, imp_token, settings.ovpn_admin_group)
-        && !ValidateOptions(pipe, sud.directory, sud.options))
+    /*
+     * Only authorized users are allowed to use any command line options or
+     * have the config file in locations other than the global config directory.
+     *
+     * Check options are white-listed and config is in the global directory
+     * OR user is authorized to run any config.
+     */
+    if (!ValidateOptions(pipe, sud.directory, sud.options, errmsg, _countof(errmsg))
+        && !IsAuthorizedUser(ovpn_user->User.Sid, imp_token, settings.ovpn_admin_group))
     {
+        ReturnError(pipe, ERROR_STARTUP_DATA, errmsg, 1, &exit_event);
         goto out;
     }
 
-- 
2.1.4


