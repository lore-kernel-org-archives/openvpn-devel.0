From: Gert Doering <gert@...1296...>
Date: Sun,  9 Nov 2025 16:44:31 +0100
Message-ID: <20251109154438.15464-1-gert@...1296...>
In-Reply-To: <gerrit.1761939285000.If28e66fcc3493821f78fd14d432b22b996918e8f@...2715...>
References: <gerrit.1761939285000.If28e66fcc3493821f78fd14d432b22b996918e8f@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] iservice: make sure directories have
 trailing \
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

From: Heiko Hund <heiko@...2662...>

At least in the case of the config dir this matters, since the value is
used to validate input data for the interactive service. A missing \
at the end would allow a string compare to succeed, if the last element of
the path to compare starts with the same substring. The trailing slash
ensures that the last element of a path must match completely.

Change-Id: If28e66fcc3493821f78fd14d432b22b996918e8f
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1336
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1336
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index d25d9c0..b1c89c9 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -24,6 +24,8 @@
 #include "validate.h"
 #include "eventmsg.h"
 
+#include <pathcch.h>
+
 LPCWSTR service_instance = L"";
 static wchar_t win_sys_path[MAX_PATH];
 
@@ -54,6 +56,22 @@
 }
 
 
+/**
+ * Make sure that a dir path ends with a backslash.
+ * If it doesn't, a \ is added to the end of the path, if there's room in the buffer.
+ *
+ * @param dir       pointer to the wide dir path string buffer
+ * @param size      maximum number of wide chars the dir path buffer
+ * @return BOOL to indicate success or failure
+ */
+static BOOL
+ensure_trailing_backslash(PWSTR dir, size_t size)
+{
+    HRESULT res = PathCchAddBackslash(dir, size);
+    return (res == S_OK || res == S_FALSE) ? TRUE : FALSE;
+}
+
+
 DWORD
 GetOpenvpnSettings(settings_t *s)
 {
@@ -90,16 +108,16 @@
         goto out;
     }
 
-    swprintf(default_value, _countof(default_value), L"%ls\\config", install_path);
+    swprintf(default_value, _countof(default_value), L"%ls\\config\\", install_path);
     error = GetRegString(key, L"config_dir", s->config_dir, sizeof(s->config_dir), default_value);
-    if (error != ERROR_SUCCESS)
+    if (error != ERROR_SUCCESS || !ensure_trailing_backslash(s->config_dir, _countof(s->config_dir)))
     {
         goto out;
     }
 
-    swprintf(default_value, _countof(default_value), L"%ls\\bin", install_path);
+    swprintf(default_value, _countof(default_value), L"%ls\\bin\\", install_path);
     error = GetRegString(key, L"bin_dir", s->bin_dir, sizeof(s->bin_dir), default_value);
-    if (error != ERROR_SUCCESS)
+    if (error != ERROR_SUCCESS || !ensure_trailing_backslash(s->bin_dir, _countof(s->bin_dir)))
     {
         goto out;
     }
@@ -110,9 +128,9 @@
         goto out;
     }
 
-    swprintf(default_value, _countof(default_value), L"%ls\\log", install_path);
+    swprintf(default_value, _countof(default_value), L"%ls\\log\\", install_path);
     error = GetRegString(key, L"log_dir", s->log_dir, sizeof(s->log_dir), default_value);
-    if (error != ERROR_SUCCESS)
+    if (error != ERROR_SUCCESS || !ensure_trailing_backslash(s->log_dir, _countof(s->log_dir)))
     {
         goto out;
     }

