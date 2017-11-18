From: selva.nair@...277...
Date: Sat, 18 Nov 2017 12:40:58 -0500
Message-Id: <1511026858-23281-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1511026858-23281-1-git-send-email-selva.nair@...277...>
References: <1511026858-23281-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] Make most registry values optional
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

Not all installations need registry values such as log_dir and
config_dir especially if automatic service is not in use.
This patch provides reasonable defaults for registry values.

- Read the default value of HKLM\Software\PACKAGE_NAME to get the
  install path and construct defaults for exe_path, config_dir,
  log_dir from it. Use "ovpn", "0", NORMAL_PRIORITY as the defaults
  for config file extension, log-append flag and process priority.

The only remaining required registry entry is the root key (usually
HKLM\Software\OpenVPN) whose default value should be set to the
installation path.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/common.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index bc99584..759e6a0 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -87,6 +87,8 @@ GetOpenvpnSettings(settings_t *s)
     TCHAR append[2];
     DWORD error;
     HKEY key;
+    TCHAR install_path[MAX_PATH];
+    TCHAR default_value[MAX_PATH];
 
     LONG status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, REG_KEY, 0, KEY_READ, &key);
     if (status != ERROR_SUCCESS)
@@ -95,37 +97,50 @@ GetOpenvpnSettings(settings_t *s)
         return MsgToEventLog(M_SYSERR, TEXT("Could not open Registry key HKLM\\%s not found"), REG_KEY);
     }
 
-    error = GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->exe_path), NULL);
+    /* The default value of REG_KEY is the install path */
+    if (GetRegString(key, NULL, install_path, sizeof(install_path), NULL) != ERROR_SUCCESS)
+    {
+        goto out;
+    }
+
+    openvpn_sntprintf(default_value, _countof(default_value), TEXT("%s\\bin\\openvpn.exe"),
+                      install_path);
+    error = GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->exe_path), default_value);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("config_dir"), s->config_dir, sizeof(s->config_dir), NULL);
+    openvpn_sntprintf(default_value, _countof(default_value), TEXT("%s\\config"), install_path);
+    error = GetRegString(key, TEXT("config_dir"), s->config_dir, sizeof(s->config_dir),
+                         default_value);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("config_ext"), s->ext_string, sizeof(s->ext_string), NULL);
+    error = GetRegString(key, TEXT("config_ext"), s->ext_string, sizeof(s->ext_string),
+                         TEXT(".ovpn"));
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("log_dir"), s->log_dir, sizeof(s->log_dir), NULL);
+    openvpn_sntprintf(default_value, _countof(default_value), TEXT("%s\\log"), install_path);
+    error = GetRegString(key, TEXT("log_dir"), s->log_dir, sizeof(s->log_dir), default_value);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("priority"), priority, sizeof(priority), NULL);
+    error = GetRegString(key, TEXT("priority"), priority, sizeof(priority),
+                         TEXT("NORMAL_PRIORITY_CLASS"));
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    error = GetRegString(key, TEXT("log_append"), append, sizeof(append), NULL);
+    error = GetRegString(key, TEXT("log_append"), append, sizeof(append), TEXT("0"));
     if (error != ERROR_SUCCESS)
     {
         goto out;
-- 
2.1.4


