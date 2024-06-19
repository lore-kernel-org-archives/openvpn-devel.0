From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 19 Jun 2024 16:44:23 +0300
Message-ID: <20240619134451.222-1-lev@...515...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] interactive.c: Improve access control for
 gui<->service pipe
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

At the moment everyone but anonymous are permitted
to create a pipe with the same name as interactive service creates,
which makes it possible for malicious process with SeImpersonatePrivilege
impersonate as local user.

This hardens the security of the pipe, making it possible only for
processes running as SYSTEM (such as interactive service) create the
pipe with the same name.

While on it, replace EXPLICIT_ACCESS structures with SDDL string.

CVE: 2024-4877

Change-Id: I35e783b79a332d247606e05a39e41b4d35d39b5d
Reported by: Zeze with TeamT5 <zeze7w@...277...>
Signed-off-by: Lev Stipakov <lev@...515...>
---
 v2:
  - ensure that sd is freed even if pipe creation failed
  - added Reported-By

 src/openvpnserv/interactive.c | 81 +++++++++++++----------------------
 1 file changed, 29 insertions(+), 52 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d32223ce..6da8ee5d 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -2137,73 +2137,50 @@ ServiceCtrlInteractive(DWORD ctrl_code, DWORD event, LPVOID data, LPVOID ctx)
 static HANDLE
 CreateClientPipeInstance(VOID)
 {
-    TCHAR pipe_name[256]; /* The entire pipe name string can be up to 256 characters long according to MSDN. */
-    HANDLE pipe = NULL;
-    PACL old_dacl, new_dacl;
-    PSECURITY_DESCRIPTOR sd;
-    static EXPLICIT_ACCESS ea[2];
-    static BOOL initialized = FALSE;
-    DWORD flags = PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_OVERLAPPED;
+    /*
+     * allow all access for local system
+     * deny FILE_CREATE_PIPE_INSTANCE for everyone
+     * allow read/write for authenticated users
+     * deny all access to anonymous
+     */
+    const TCHAR *sddlString = TEXT("D:(A;OICI;GA;;;S-1-5-18)(D;OICI;0x4;;;S-1-1-0)(A;OICI;GRGW;;;S-1-5-11)(D;;GA;;;S-1-5-7)");
 
-    if (!initialized)
+    PSECURITY_DESCRIPTOR sd = NULL;
+    if (!ConvertStringSecurityDescriptorToSecurityDescriptor(sddlString, SDDL_REVISION_1, &sd, NULL))
     {
-        PSID everyone, anonymous;
-
-        ConvertStringSidToSid(TEXT("S-1-1-0"), &everyone);
-        ConvertStringSidToSid(TEXT("S-1-5-7"), &anonymous);
+        MsgToEventLog(M_SYSERR, TEXT("ConvertStringSecurityDescriptorToSecurityDescriptor failed."));
+        return INVALID_HANDLE_VALUE;
+    }
 
-        ea[0].grfAccessPermissions = FILE_GENERIC_WRITE;
-        ea[0].grfAccessMode = GRANT_ACCESS;
-        ea[0].grfInheritance = NO_INHERITANCE;
-        ea[0].Trustee.pMultipleTrustee = NULL;
-        ea[0].Trustee.MultipleTrusteeOperation = NO_MULTIPLE_TRUSTEE;
-        ea[0].Trustee.TrusteeForm = TRUSTEE_IS_SID;
-        ea[0].Trustee.TrusteeType = TRUSTEE_IS_UNKNOWN;
-        ea[0].Trustee.ptstrName = (LPTSTR) everyone;
+    /* Set up SECURITY_ATTRIBUTES */
+    SECURITY_ATTRIBUTES sa = {0};
+    sa.nLength = sizeof(SECURITY_ATTRIBUTES);
+    sa.lpSecurityDescriptor = sd;
+    sa.bInheritHandle = FALSE;
 
-        ea[1].grfAccessPermissions = 0;
-        ea[1].grfAccessMode = REVOKE_ACCESS;
-        ea[1].grfInheritance = NO_INHERITANCE;
-        ea[1].Trustee.pMultipleTrustee = NULL;
-        ea[1].Trustee.MultipleTrusteeOperation = NO_MULTIPLE_TRUSTEE;
-        ea[1].Trustee.TrusteeForm = TRUSTEE_IS_SID;
-        ea[1].Trustee.TrusteeType = TRUSTEE_IS_UNKNOWN;
-        ea[1].Trustee.ptstrName = (LPTSTR) anonymous;
+    DWORD flags = PIPE_ACCESS_DUPLEX | WRITE_DAC | FILE_FLAG_OVERLAPPED;
 
+    static BOOL first = TRUE;
+    if (first)
+    {
         flags |= FILE_FLAG_FIRST_PIPE_INSTANCE;
-        initialized = TRUE;
+        first = FALSE;
     }
 
+    TCHAR pipe_name[256]; /* The entire pipe name string can be up to 256 characters long according to MSDN. */
     openvpn_swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service"), service_instance);
-    pipe = CreateNamedPipe(pipe_name, flags,
-                           PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,
-                           PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, NULL);
+    HANDLE pipe = CreateNamedPipe(pipe_name, flags,
+                                  PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,
+                                  PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, &sa);
+
+    LocalFree(sd);
+
     if (pipe == INVALID_HANDLE_VALUE)
     {
         MsgToEventLog(M_SYSERR, TEXT("Could not create named pipe"));
         return INVALID_HANDLE_VALUE;
     }
 
-    if (GetSecurityInfo(pipe, SE_KERNEL_OBJECT, DACL_SECURITY_INFORMATION,
-                        NULL, NULL, &old_dacl, NULL, &sd) != ERROR_SUCCESS)
-    {
-        MsgToEventLog(M_SYSERR, TEXT("Could not get pipe security info"));
-        return CloseHandleEx(&pipe);
-    }
-
-    if (SetEntriesInAcl(2, ea, old_dacl, &new_dacl) != ERROR_SUCCESS)
-    {
-        MsgToEventLog(M_SYSERR, TEXT("Could not set entries in new acl"));
-        return CloseHandleEx(&pipe);
-    }
-
-    if (SetSecurityInfo(pipe, SE_KERNEL_OBJECT, DACL_SECURITY_INFORMATION,
-                        NULL, NULL, new_dacl, NULL) != ERROR_SUCCESS)
-    {
-        MsgToEventLog(M_SYSERR, TEXT("Could not set pipe security info"));
-        return CloseHandleEx(&pipe);
-    }
-
     return pipe;
 }
 
-- 
2.42.0.windows.2


