From: Gert Doering <gert@...1296...>
Date: Mon,  5 May 2025 14:27:06 +0200
Message-ID: <20250505122712.5214-1-gert@...1296...>
In-Reply-To: <gerrit.1744981598000.I39d660ebeec76280e4d4357192b74bf2c0980615@...2715...>
References: <gerrit.1744981598000.I39d660ebeec76280e4d4357192b74bf2c0980615@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] win: refactor get_windows_version()
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

It's 2025, and almost all clients now run on Windows 10 or newer.
Instead of displaying:

  "Windows version 10.0 (Windows 10 or greater), amd64 executable"

we now show the exact build number, e.g.:

  "Windows version: 10.0.22631,amd64"

Remove "pre-Win7" checks in a few places.

Change-Id: I39d660ebeec76280e4d4357192b74bf2c0980615
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/944
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 96119c4..c523649 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4846,7 +4846,7 @@
 show_windows_version(const unsigned int flags)
 {
     struct gc_arena gc = gc_new();
-    msg(flags, "Windows version %s", win32_version_string(&gc, true));
+    msg(flags, "Windows version: %s", win32_version_string(&gc));
     gc_free(&gc);
 }
 #endif
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 23f6423..fd299ef 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2060,7 +2060,7 @@
             }
             buf_printf(&out, "IV_SSL=%s\n", get_ssl_library_version() );
 #if defined(_WIN32)
-            buf_printf(&out, "IV_PLAT_VER=%s\n", win32_version_string(&gc, false));
+            buf_printf(&out, "IV_PLAT_VER=%s\n", win32_version_string(&gc));
 #else
             struct utsname u;
             uname(&u);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 4f7de6c..5186afa 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -5428,11 +5428,8 @@
                     NETSH_PATH_SUFFIX, adapter_index,
                     print_in6_addr(addr_list[i], 0, &gc));
 
-        /* disable slow address validation on Windows 7 and higher */
-        if (win32_version_info() >= WIN_7)
-        {
-            argv_printf_cat(&argv, "%s", "validate=no");
-        }
+        /* disable slow address validation */
+        argv_printf_cat(&argv, "%s", "validate=no");
 
         /* Treat errors while adding as non-fatal as we do not check for duplicates */
         netsh_command(&argv, 1, (i==0) ? M_FATAL : M_NONFATAL);
@@ -5498,9 +5495,8 @@
                             adapter_index,
                             print_in_addr_t(addr_list[i], 0, &gc));
 
-                /* disable slow address validation on Windows 7 and higher */
-                /* only for DNS */
-                if (is_dns && win32_version_info() >= WIN_7)
+                /* disable slow address validation for DNS */
+                if (is_dns)
                 {
                     argv_printf_cat(&argv, "%s", "validate=no");
                 }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index edac71e..caa14d6 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1283,42 +1283,6 @@
     return true;
 }
 
-int
-win32_version_info(void)
-{
-    if (!IsWindowsXPOrGreater())
-    {
-        msg(M_FATAL, "Error: Windows version must be XP or greater.");
-    }
-
-    if (!IsWindowsVistaOrGreater())
-    {
-        return WIN_XP;
-    }
-
-    if (!IsWindows7OrGreater())
-    {
-        return WIN_VISTA;
-    }
-
-    if (!IsWindows8OrGreater())
-    {
-        return WIN_7;
-    }
-
-    if (!IsWindows8Point1OrGreater())
-    {
-        return WIN_8;
-    }
-
-    if (!IsWindows10OrGreater())
-    {
-        return WIN_8_1;
-    }
-
-    return WIN_10;
-}
-
 typedef enum {
     ARCH_X86,
     ARCH_AMD64,
@@ -1420,52 +1384,40 @@
     }
 }
 
+typedef LONG (WINAPI *RtlGetVersionPtr)(PRTL_OSVERSIONINFOW);
+
 const char *
-win32_version_string(struct gc_arena *gc, bool add_name)
+win32_version_string(struct gc_arena *gc)
 {
-    int version = win32_version_info();
-    struct buffer out = alloc_buf_gc(256, gc);
-
-    switch (version)
+    HMODULE hMod = GetModuleHandleW(L"ntdll.dll");
+    if (!hMod)
     {
-        case WIN_XP:
-            buf_printf(&out, "5.1%s", add_name ? " (Windows XP)" : "");
-            break;
-
-        case WIN_VISTA:
-            buf_printf(&out, "6.0%s", add_name ? " (Windows Vista)" : "");
-            break;
-
-        case WIN_7:
-            buf_printf(&out, "6.1%s", add_name ? " (Windows 7)" : "");
-            break;
-
-        case WIN_8:
-            buf_printf(&out, "6.2%s", add_name ? " (Windows 8)" : "");
-            break;
-
-        case WIN_8_1:
-            buf_printf(&out, "6.3%s", add_name ? " (Windows 8.1)" : "");
-            break;
-
-        case WIN_10:
-            buf_printf(&out, "10.0%s", add_name ? " (Windows 10 or greater)" : "");
-            break;
-
-        default:
-            msg(M_NONFATAL, "Unknown Windows version: %d", version);
-            buf_printf(&out, "0.0%s", add_name ? " (unknown)" : "");
-            break;
+        return "N/A";
     }
 
-    buf_printf(&out, ", ");
+    RtlGetVersionPtr fn = (RtlGetVersionPtr)GetProcAddress(hMod, "RtlGetVersion");
+    if (!fn)
+    {
+        return "N/A";
+    }
+
+    RTL_OSVERSIONINFOW rovi = { 0 };
+    rovi.dwOSVersionInfoSize = sizeof(rovi);
+    if (fn(&rovi) != 0)
+    {
+        return "N/A";
+    }
+
+    struct buffer out = alloc_buf_gc(256, gc);
+
+    buf_printf(&out, "%lu.%lu.%lu", rovi.dwMajorVersion, rovi.dwMinorVersion, rovi.dwBuildNumber);
+
+    buf_printf(&out, ",");
 
     arch_t process_arch, host_arch;
     win32_get_arch(&process_arch, &host_arch);
     win32_print_arch(process_arch, &out);
 
-    buf_printf(&out, " executable");
-
     if (host_arch != ARCH_NATIVE)
     {
         buf_printf(&out, " running on ");
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 081beeb..685898c 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -292,20 +292,13 @@
 
 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);
 
-#define WIN_XP    0
-#define WIN_VISTA 1
-#define WIN_7     2
-#define WIN_8     3
-#define WIN_8_1   4
-#define WIN_10    5
-
-int win32_version_info(void);
-
-/*
- * String representation of Windows version number and name, see
- * https://msdn.microsoft.com/en-us/library/windows/desktop/ms724832(v=vs.85).aspx
+/**
+ * @brief Get Windows version string with architecture info.
+ *
+ * @param gc gc arena to allocate string.
+ * @return Version string, or "N/A" on failure.
  */
-const char *win32_version_string(struct gc_arena *gc, bool add_name);
+const char *win32_version_string(struct gc_arena *gc);
 
 /*
  * Send the |size| bytes in buffer |data| to the interactive service |pipe|

