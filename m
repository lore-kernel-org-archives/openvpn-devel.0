From: Arne Schwabe <arne@...1227...>
Date: Wed, 12 May 2021 15:15:09 +0200
Message-Id: <20210512131511.1309914-8-arne@...1227...>
In-Reply-To: <20210512131511.1309914-1-arne@...1227...>
References: <20210512131511.1309914-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 7/9] Move utility function from win32.c to
 win32-util.c
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

This done to allow to include parts win32.c when building unit tests
as win32.c itself has too many dependencies and cannot be included in
a small unit test.

Also fix a missing Windows.h include in error.h that otherwise
breaks complation when included from unit tests.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/Makefile.am             |   1 +
 src/openvpn/error.h                 |   4 +
 src/openvpn/openvpn.vcxproj         |   2 +
 src/openvpn/openvpn.vcxproj.filters |   3 +
 src/openvpn/win32-util.c            | 137 ++++++++++++++++++++++++++++
 src/openvpn/win32-util.h            |  41 +++++++++
 src/openvpn/win32.c                 |  96 +------------------
 src/openvpn/win32.h                 |   6 --
 8 files changed, 189 insertions(+), 101 deletions(-)
 create mode 100644 src/openvpn/win32-util.c
 create mode 100644 src/openvpn/win32-util.h

diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index ec84929b0..dec304a06 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -130,6 +130,7 @@ openvpn_SOURCES = \
 	tun.c tun.h \
 	vlan.c vlan.h \
 	win32.h win32.c \
+	win32-util.h win32-util.c \
 	cryptoapi.h cryptoapi.c
 openvpn_LDADD = \
 	$(top_builddir)/src/compat/libcompat.la \
diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 469afe20a..522a83e51 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -31,6 +31,10 @@
 
 #include <assert.h>
 
+#if _WIN32
+#include <windows.h>
+#endif
+
 /* #define ABORT_ON_ERROR */
 
 #ifdef ENABLE_PKCS11
diff --git a/src/openvpn/openvpn.vcxproj b/src/openvpn/openvpn.vcxproj
index 182722962..370345a1b 100644
--- a/src/openvpn/openvpn.vcxproj
+++ b/src/openvpn/openvpn.vcxproj
@@ -283,6 +283,7 @@
     <ClCompile Include="tun.c" />
     <ClCompile Include="vlan.c" />
     <ClCompile Include="win32.c" />
+    <ClCompile Include="win32-util.c" />
   </ItemGroup>
   <ItemGroup>
     <ClInclude Include="argv.h" />
@@ -374,6 +375,7 @@
     <ClInclude Include="tun.h" />
     <ClInclude Include="vlan.h" />
     <ClInclude Include="win32.h" />
+    <ClInclude Include="win32-util.h" />
   </ItemGroup>
   <ItemGroup>
     <ResourceCompile Include="openvpn_win32_resources.rc" />
diff --git a/src/openvpn/openvpn.vcxproj.filters b/src/openvpn/openvpn.vcxproj.filters
index e8aed2c58..a4dbb6cd4 100644
--- a/src/openvpn/openvpn.vcxproj.filters
+++ b/src/openvpn/openvpn.vcxproj.filters
@@ -207,6 +207,9 @@
     <ClCompile Include="win32.c">
       <Filter>Source Files</Filter>
     </ClCompile>
+    <ClCompile Include="win32-util.c">
+      <Filter>Source Files</Filter>
+    </ClCompile>
     <ClCompile Include="comp.c">
       <Filter>Source Files</Filter>
     </ClCompile>
diff --git a/src/openvpn/win32-util.c b/src/openvpn/win32-util.c
new file mode 100644
index 000000000..9e843dbdd
--- /dev/null
+++ b/src/openvpn/win32-util.c
@@ -0,0 +1,137 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+/*
+ * Win32-specific OpenVPN code, targeted at the mingw
+ * development environment.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+#ifdef _WIN32
+
+#include "buffer.h"
+#include "win32-util.h"
+
+WCHAR *
+wide_string(const char *utf8, struct gc_arena *gc)
+{
+    int n = MultiByteToWideChar(CP_UTF8, 0, utf8, -1, NULL, 0);
+    WCHAR *ucs16 = gc_malloc(n * sizeof(WCHAR), false, gc);
+    MultiByteToWideChar(CP_UTF8, 0, utf8, -1, ucs16, n);
+    return ucs16;
+}
+
+
+/*
+ * Return true if filename is safe to be used on Windows,
+ * by avoiding the following reserved names:
+ *
+ * CON, PRN, AUX, NUL, COM1, COM2, COM3, COM4, COM5, COM6, COM7, COM8, COM9,
+ * LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, LPT9, and CLOCK$
+ *
+ * See: http://msdn.microsoft.com/en-us/library/aa365247.aspx
+ *  and http://msdn.microsoft.com/en-us/library/86k9f82k(VS.80).aspx
+ */
+
+static bool
+cmp_prefix(const char *str, const bool n, const char *pre)
+{
+    size_t i = 0;
+
+    if (!str)
+    {
+        return false;
+    }
+
+    while (true)
+    {
+        const int c1 = pre[i];
+        int c2 = str[i];
+        ++i;
+        if (c1 == '\0')
+        {
+            if (n)
+            {
+                if (isdigit(c2))
+                {
+                    c2 = str[i];
+                }
+                else
+                {
+                    return false;
+                }
+            }
+            return c2 == '\0' || c2 == '.';
+        }
+        else if (c2 == '\0')
+        {
+            return false;
+        }
+        if (c1 != tolower(c2))
+        {
+            return false;
+        }
+    }
+}
+
+bool
+win_safe_filename(const char *fn)
+{
+    if (cmp_prefix(fn, false, "con"))
+    {
+        return false;
+    }
+    if (cmp_prefix(fn, false, "prn"))
+    {
+        return false;
+    }
+    if (cmp_prefix(fn, false, "aux"))
+    {
+        return false;
+    }
+    if (cmp_prefix(fn, false, "nul"))
+    {
+        return false;
+    }
+    if (cmp_prefix(fn, true, "com"))
+    {
+        return false;
+    }
+    if (cmp_prefix(fn, true, "lpt"))
+    {
+        return false;
+    }
+    if (cmp_prefix(fn, false, "clock$"))
+    {
+        return false;
+    }
+    return true;
+}
+#endif /* _WIN32 */
\ No newline at end of file
diff --git a/src/openvpn/win32-util.h b/src/openvpn/win32-util.h
new file mode 100644
index 000000000..aec123efb
--- /dev/null
+++ b/src/openvpn/win32-util.h
@@ -0,0 +1,41 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2018 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef _WIN32
+#ifndef OPENVPN_WIN32_UTIL_H
+#define OPENVPN_WIN32_UTIL_H
+
+#include <winioctl.h>
+
+#include "mtu.h"
+#include "openvpn-msg.h"
+#include "argv.h"
+
+/* Convert a string from UTF-8 to UCS-2 */
+WCHAR *wide_string(const char *utf8, struct gc_arena *gc);
+
+/* return true if filename is safe to be used on Windows */
+bool win_safe_filename(const char *fn);
+
+#endif /* OPENVPN_WIN32_UTIL_H */
+#endif /* ifdef _WIN32 */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 7e9131657..629ebbd9b 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -41,6 +41,7 @@
 #include "mtu.h"
 #include "run_command.h"
 #include "sig.h"
+#include "win32-util.h"
 #include "win32.h"
 #include "openvpn-msg.h"
 
@@ -879,92 +880,6 @@ netcmd_semaphore_release(void)
     semaphore_close(&netcmd_semaphore);
 }
 
-/*
- * Return true if filename is safe to be used on Windows,
- * by avoiding the following reserved names:
- *
- * CON, PRN, AUX, NUL, COM1, COM2, COM3, COM4, COM5, COM6, COM7, COM8, COM9,
- * LPT1, LPT2, LPT3, LPT4, LPT5, LPT6, LPT7, LPT8, LPT9, and CLOCK$
- *
- * See: http://msdn.microsoft.com/en-us/library/aa365247.aspx
- *  and http://msdn.microsoft.com/en-us/library/86k9f82k(VS.80).aspx
- */
-
-static bool
-cmp_prefix(const char *str, const bool n, const char *pre)
-{
-    size_t i = 0;
-
-    if (!str)
-    {
-        return false;
-    }
-
-    while (true)
-    {
-        const int c1 = pre[i];
-        int c2 = str[i];
-        ++i;
-        if (c1 == '\0')
-        {
-            if (n)
-            {
-                if (isdigit(c2))
-                {
-                    c2 = str[i];
-                }
-                else
-                {
-                    return false;
-                }
-            }
-            return c2 == '\0' || c2 == '.';
-        }
-        else if (c2 == '\0')
-        {
-            return false;
-        }
-        if (c1 != tolower(c2))
-        {
-            return false;
-        }
-    }
-}
-
-bool
-win_safe_filename(const char *fn)
-{
-    if (cmp_prefix(fn, false, "con"))
-    {
-        return false;
-    }
-    if (cmp_prefix(fn, false, "prn"))
-    {
-        return false;
-    }
-    if (cmp_prefix(fn, false, "aux"))
-    {
-        return false;
-    }
-    if (cmp_prefix(fn, false, "nul"))
-    {
-        return false;
-    }
-    if (cmp_prefix(fn, true, "com"))
-    {
-        return false;
-    }
-    if (cmp_prefix(fn, true, "lpt"))
-    {
-        return false;
-    }
-    if (cmp_prefix(fn, false, "clock$"))
-    {
-        return false;
-    }
-    return true;
-}
-
 /*
  * Service functions for openvpn_execve
  */
@@ -1153,15 +1068,6 @@ openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned in
     return ret;
 }
 
-WCHAR *
-wide_string(const char *utf8, struct gc_arena *gc)
-{
-    int n = MultiByteToWideChar(CP_UTF8, 0, utf8, -1, NULL, 0);
-    WCHAR *ucs16 = gc_malloc(n * sizeof(WCHAR), false, gc);
-    MultiByteToWideChar(CP_UTF8, 0, utf8, -1, ucs16, n);
-    return ucs16;
-}
-
 /*
  * call ourself in another process
  */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index da85ed4d7..235738356 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -272,9 +272,6 @@ void netcmd_semaphore_release(void);
 /* Set Win32 security attributes structure to allow all access */
 bool init_security_attributes_allow_all(struct security_attributes *obj);
 
-/* return true if filename is safe to be used on Windows */
-bool win_safe_filename(const char *fn);
-
 /* add constant environmental variables needed by Windows */
 struct env_set;
 
@@ -291,9 +288,6 @@ void fork_to_self(const char *cmdline);
 /* Find temporary directory */
 const char *win_get_tempdir(void);
 
-/* Convert a string from UTF-8 to UCS-2 */
-WCHAR *wide_string(const char *utf8, struct gc_arena *gc);
-
 bool win_wfp_block_dns(const NET_IFINDEX index, const HANDLE msg_channel);
 
 bool win_wfp_uninit(const NET_IFINDEX index, const HANDLE msg_channel);
-- 
2.31.1


