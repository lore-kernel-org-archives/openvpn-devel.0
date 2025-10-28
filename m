From: Gert Doering <gert@...1296...>
Date: Tue, 28 Oct 2025 11:16:36 +0100
Message-ID: <20251028101642.11874-1-gert@...1296...>
In-Reply-To: <gerrit.1761596820000.I8e884c00cb94f97a612056e8dca74d821a6d6386@...2715...>
References: <gerrit.1761596820000.I8e884c00cb94f97a612056e8dca74d821a6d6386@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Canonicalize config_dir before comparing
 with the config file location
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

Found by ZeroPath

Change-Id: I8e884c00cb94f97a612056e8dca74d821a6d6386
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1318
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1318
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 340b904..a92ee08 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -6,6 +6,11 @@
 
 add_executable(openvpnserv)
 
+include(CheckSymbolExists)
+
+# Some old versions of mingw does not have PATHCCH_OPTIONS enums -- add a check
+check_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PATHCCH_ENSURE_TRAILING_SLASH)
+
 set(MC_GEN_DIR ${CMAKE_CURRENT_BINARY_DIR}/mc)
 
 target_include_directories(openvpnserv PRIVATE
@@ -31,7 +36,7 @@
     )
 target_link_libraries(openvpnserv
     advapi32.lib userenv.lib iphlpapi.lib fwpuclnt.lib rpcrt4.lib
-    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib)
+    shlwapi.lib netapi32.lib ws2_32.lib ntdll.lib ole32.lib pathcch.lib)
 if (MINGW)
     target_compile_options(openvpnserv PRIVATE -municode)
     target_link_options(openvpnserv PRIVATE -municode)
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 59d5b86..2187fb5 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -25,6 +25,11 @@
 #include <lmaccess.h>
 #include <shlwapi.h>
 #include <lm.h>
+#include <pathcch.h>
+
+#ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH
+#define PATHCCH_ENSURE_TRAILING_SLASH 0x20
+#endif
 
 static const WCHAR *white_list[] = {
     L"auth-retry",
@@ -61,7 +66,7 @@
 {
     WCHAR tmp[MAX_PATH];
     const WCHAR *config_file = NULL;
-    const WCHAR *config_dir = NULL;
+    WCHAR config_dir[MAX_PATH];
 
     /* convert fname to full path */
     if (PathIsRelativeW(fname))
@@ -74,9 +79,12 @@
         config_file = fname;
     }
 
-    config_dir = s->config_dir;
+    /* canonicalize config_dir and add trailing slash before comparison */
+    HRESULT res = PathCchCanonicalizeEx(config_dir, _countof(config_dir), s->config_dir,
+                                        PATHCCH_ENSURE_TRAILING_SLASH);
 
-    if (wcsncmp(config_dir, config_file, wcslen(config_dir)) == 0
+    if (res == S_OK
+        && wcsncmp(config_dir, config_file, wcslen(config_dir)) == 0
         && wcsstr(config_file + wcslen(config_dir), L"..") == NULL)
     {
         return TRUE;

