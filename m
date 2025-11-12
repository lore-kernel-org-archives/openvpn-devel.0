From: Gert Doering <gert@...1296...>
Date: Wed, 12 Nov 2025 10:22:38 +0100
Message-ID: <20251112092244.22764-1-gert@...1296...>
In-Reply-To: <gerrit.1761516861000.I0e94068f467f2899daf133b032a785d2d7fc05e4@...2715...>
References: <gerrit.1761516861000.I0e94068f467f2899daf133b032a785d2d7fc05e4@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] iservice: validate config path better
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

Instead of just rejecting any path that contains ".." use some WIN32 API
functions to combine, canonicalize and then check if the resulting
path is located under the config directory. Makes the code prettier
and more correct.

Change-Id: I0e94068f467f2899daf133b032a785d2d7fc05e4
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1307
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1307
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index ddaa381..2dcfe1a 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -24,8 +24,8 @@
 
 #include <lmaccess.h>
 #include <shlwapi.h>
-#include <lm.h>
 #include <pathcch.h>
+#include <lm.h>
 
 #ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH
 #define PATHCCH_ENSURE_TRAILING_SLASH 0x20
@@ -58,44 +58,31 @@
 static PTOKEN_GROUPS GetTokenGroups(const HANDLE token);
 
 /*
- * Check workdir\fname is inside config_dir
- * The logic here is simple: we may reject some valid paths if ..\ is in any of the strings
+ * Check that config path is inside config_dir
+ * The logic here is simple: if the path isn't prefixed with config_dir it's rejected
  */
 static BOOL
 CheckConfigPath(const WCHAR *workdir, const WCHAR *fname, const settings_t *s)
 {
-    WCHAR tmp[MAX_PATH];
-    const WCHAR *config_file = NULL;
-    WCHAR config_dir[MAX_PATH];
+    HRESULT res;
+    WCHAR config_path[MAX_PATH];
 
     /* fname = stdin is special: do not treat it as a relative path */
     if (wcscmp(fname, L"stdin") == 0)
     {
         return FALSE;
     }
-    /* convert fname to full path */
+    /* convert fname to full canonical path */
     if (PathIsRelativeW(fname))
     {
-        swprintf(tmp, _countof(tmp), L"%ls\\%ls", workdir, fname);
-        config_file = tmp;
+        res = PathCchCombine(config_path, _countof(config_path), workdir, fname);
     }
     else
     {
-        config_file = fname;
+        res = PathCchCanonicalize(config_path, _countof(config_path), fname);
     }
 
-    /* canonicalize config_dir and add trailing slash before comparison */
-    HRESULT res = PathCchCanonicalizeEx(config_dir, _countof(config_dir), s->config_dir,
-                                        PATHCCH_ENSURE_TRAILING_SLASH);
-
-    if (res == S_OK
-        && wcsncmp(config_dir, config_file, wcslen(config_dir)) == 0
-        && wcsstr(config_file + wcslen(config_dir), L"..") == NULL)
-    {
-        return TRUE;
-    }
-
-    return FALSE;
+    return res == S_OK && wcsncmp(config_path, s->config_dir, wcslen(s->config_dir)) == 0;
 }
 
 

