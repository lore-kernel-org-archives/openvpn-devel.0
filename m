From: Gert Doering <gert@...1296...>
Date: Fri, 14 Nov 2025 22:29:28 +0100
Message-ID: <20251114212936.7055-1-gert@...1296...>
In-Reply-To: <gerrit.1761818969000.I5ea90594493ab5cb858f7495f773e080b379e8e8@...2715...>
References: <gerrit.1761818969000.I5ea90594493ab5cb858f7495f773e080b379e8e8@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] win32: ensure plugin dir has the
 trailing slash
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

From: Lev Stipakov <lev@...515...>

This prevents loading plugins from the directories
which share initial characters with the trusted path.

Reported-by: Joshua Rogers <contact@...2949...>
Found-by: ZeroPath (https://zeropath.com/)

Change-Id: I5ea90594493ab5cb858f7495f773e080b379e8e8
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1332
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1332
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index c9301e6..6888de3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -245,6 +245,9 @@
 check_symbol_exists(chsize io.h HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)
 
+# Some old versions of mingw does not have PATHCCH_OPTIONS enums -- add a check
+check_symbol_exists(PATHCCH_ENSURE_TRAILING_SLASH pathcch.h HAVE_PATHCCH_ENSURE_TRAILING_SLASH)
+
 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
 set(NETEXTRA sys/types.h)
@@ -338,7 +341,7 @@
         if (WIN32)
             target_link_libraries(${target} PUBLIC
                 ws2_32.lib crypt32.lib fwpuclnt.lib iphlpapi.lib
-                wininet.lib setupapi.lib rpcrt4.lib wtsapi32.lib ncrypt.lib bcrypt.lib)
+                wininet.lib setupapi.lib rpcrt4.lib wtsapi32.lib ncrypt.lib bcrypt.lib pathcch.lib)
         endif ()
 
     endif ()
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index db87dfc..a2b5e92 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -166,5 +166,5 @@
 	$(OPTIONAL_INOTIFY_LIBS)
 if WIN32
 openvpn_SOURCES += openvpn_win32_resources.rc wfp_block.c wfp_block.h
-openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt
+openvpn_LDADD += -lgdi32 -lws2_32 -lwininet -lcrypt32 -liphlpapi -lwinmm -lfwpuclnt -lrpcrt4 -lncrypt -lsetupapi -lbcrypt -lpathcch
 endif
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index df29dd7..3ed28f6 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -51,6 +51,12 @@
 
 #include "wfp_block.h"
 
+#include <pathcch.h>
+
+#ifndef HAVE_PATHCCH_ENSURE_TRAILING_SLASH
+#define PATHCCH_ENSURE_TRAILING_SLASH 0x20
+#endif
+
 /*
  * WFP handle
  */
@@ -1553,12 +1559,12 @@
         return false;
     }
 
-    WCHAR plugin_dir[MAX_PATH] = { 0 };
+    WCHAR plugin_dir_reg[MAX_PATH] = { 0 };
 
     /* Attempt to retrieve the trusted plugin directory path from the registry,
      * using installation path as a fallback */
-    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir, _countof(plugin_dir))
-        && !get_openvpn_reg_value(NULL, plugin_dir, _countof(plugin_dir)))
+    if (!get_openvpn_reg_value(L"plugin_dir", plugin_dir_reg, _countof(plugin_dir_reg))
+        && !get_openvpn_reg_value(NULL, plugin_dir_reg, _countof(plugin_dir_reg)))
     {
         msg(M_WARN, "Installation path could not be determined.");
     }
@@ -1570,26 +1576,35 @@
         msg(M_NONFATAL | M_ERRNO, "Failed to get system directory.");
     }
 
-    if ((wcslen(plugin_dir) == 0) && (wcslen(system_dir) == 0))
+    if ((wcslen(plugin_dir_reg) == 0) && (wcslen(system_dir) == 0))
     {
         return false;
     }
 
-    WCHAR normalized_plugin_dir[MAX_PATH] = { 0 };
+    WCHAR plugin_dir[MAX_PATH] = { 0 };
 
-    /* Normalize the plugin dir */
-    if (wcslen(plugin_dir) > 0)
+    /* normalize and canonicalize the plugin dir and add trailing slash */
+    if (wcslen(plugin_dir_reg) > 0)
     {
-        if (!GetFullPathNameW(plugin_dir, MAX_PATH, normalized_plugin_dir, NULL))
+        WCHAR normalized_plugin_dir[MAX_PATH] = { 0 };
+        if (!GetFullPathNameW(plugin_dir_reg, MAX_PATH, normalized_plugin_dir, NULL))
         {
             msg(M_NONFATAL | M_ERRNO, "Failed to normalize plugin dir.");
+        }
+
+        HRESULT res = PathCchCanonicalizeEx(plugin_dir, _countof(plugin_dir), normalized_plugin_dir,
+                                            PATHCCH_ENSURE_TRAILING_SLASH);
+        if (res != S_OK)
+        {
+            /* doc says we cannot rely on GetLastError() */
+            msg(M_NONFATAL, "Failed to canonicalize plugin dir.");
             return false;
         }
     }
 
     /* Check if the plugin path resides within the plugin/install directory */
-    if ((wcslen(normalized_plugin_dir) > 0)
-        && (wcsnicmp(normalized_plugin_dir, plugin_path, wcslen(normalized_plugin_dir)) == 0))
+    if ((wcslen(plugin_dir) > 0)
+        && (wcsnicmp(plugin_dir, plugin_path, wcslen(plugin_dir)) == 0))
     {
         return true;
     }

