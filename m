From: selva.nair@...277...
Date: Sat, 18 Nov 2017 12:40:57 -0500
Message-Id: <1511026858-23281-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/2] Ensure strings read from registry are
 null-terminated
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

- Strings stored in registry are not guaranteed to be null-terminated.
  So, use RegGetValue() instead of RegQueryValueEx() as the former
  adds null termination to the returned string if missing.
  (Needs Windows Vista+)

- While at it also add a default value parameter to GetRegString()
  to process optional registry values (such as ovpn_admin_group)
  without causing an otherwise confusing error logged to the
  eventlog[*].

[*] see Trac: #892

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/common.c | 32 ++++++++++++++++++--------------
 1 file changed, 18 insertions(+), 14 deletions(-)

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index e77d7ab..bc99584 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -56,14 +56,18 @@ openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
 #define REG_KEY  TEXT("SOFTWARE\\" PACKAGE_NAME)
 
 static DWORD
-GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size)
+GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_value)
 {
-    DWORD type;
-    LONG status = RegQueryValueEx(key, value, NULL, &type, (LPBYTE) data, &size);
+    LONG status = RegGetValue(key, NULL, value, RRF_RT_REG_SZ|RRF_RT_REG_EXPAND_SZ,
+                              NULL, (LPBYTE) data, &size);
 
-    if (status == ERROR_SUCCESS && type != REG_SZ)
+    if (status == ERROR_FILE_NOT_FOUND && default_value)
     {
-        status = ERROR_DATATYPE_MISMATCH;
+        size_t len = size/sizeof(data[0]);
+        if (openvpn_sntprintf(data, len, default_value) > 0)
+        {
+            status = ERROR_SUCCESS;
+        }
     }
 
     if (status != ERROR_SUCCESS)
@@ -91,48 +95,48 @@ GetOpenvpnSettings(settings_t *s)
         return MsgToEventLog(M_SYSERR, TEXT("Could not open Registry key HKLM\\%s not found"), REG_KEY);
     }
 
-    error = GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->exe_path));
+    error = GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->exe_path), NULL);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("config_dir"), s->config_dir, sizeof(s->config_dir));
+    error = GetRegString(key, TEXT("config_dir"), s->config_dir, sizeof(s->config_dir), NULL);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("config_ext"), s->ext_string, sizeof(s->ext_string));
+    error = GetRegString(key, TEXT("config_ext"), s->ext_string, sizeof(s->ext_string), NULL);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("log_dir"), s->log_dir, sizeof(s->log_dir));
+    error = GetRegString(key, TEXT("log_dir"), s->log_dir, sizeof(s->log_dir), NULL);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("priority"), priority, sizeof(priority));
+    error = GetRegString(key, TEXT("priority"), priority, sizeof(priority), NULL);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("log_append"), append, sizeof(append));
+    error = GetRegString(key, TEXT("log_append"), append, sizeof(append), NULL);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
     /* read if present, else use default */
-    error = GetRegString(key, TEXT("ovpn_admin_group"), s->ovpn_admin_group, sizeof(s->ovpn_admin_group));
+    error = GetRegString(key, TEXT("ovpn_admin_group"), s->ovpn_admin_group,
+                         sizeof(s->ovpn_admin_group), OVPN_ADMIN_GROUP);
     if (error != ERROR_SUCCESS)
     {
-        openvpn_sntprintf(s->ovpn_admin_group, _countof(s->ovpn_admin_group), OVPN_ADMIN_GROUP);
-        error = 0; /* this error is not fatal */
+        goto out;
     }
     /* set process priority */
     if (!_tcsicmp(priority, TEXT("IDLE_PRIORITY_CLASS")))
-- 
2.1.4


