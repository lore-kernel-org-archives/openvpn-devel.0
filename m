From: Lev Stipakov <lstipakov@...277...>
Date: Fri,  4 Nov 2022 11:02:47 +0200
Message-Id: <20221104090247.167-1-lstipakov@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] win32: detect arm64 architecture and
 emulations
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

From: Lev Stipakov <lev@...515...>

Properly detect process architecture and
machine architecture, including arm64.

Print process architecture and, if machine
architecture is different (we are running in
emulation), print that too.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/openvpn/win32.c | 123 ++++++++++++++++++++++++++++++++++++++++----
 1 file changed, 112 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 82f0c73f..cfe4dbde 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1345,18 +1345,106 @@ win32_version_info(void)
     return WIN_10;
 }
 
-bool
-win32_is_64bit(void)
+typedef enum {
+    ARCH_X86,
+    ARCH_AMD64,
+    ARCH_ARM64,
+    ARCH_NATIVE, /* means no emulation, makes sense for host arch */
+    ARCH_UNKNOWN
+} arch_t;
+
+static void
+win32_get_arch(arch_t *process_arch, arch_t *host_arch)
 {
-#if defined(_WIN64)
-    return true;  /* 64-bit programs run only on Win64 */
+    *process_arch = ARCH_UNKNOWN;
+    *host_arch = ARCH_NATIVE;
+
+    typedef BOOL (__stdcall *is_wow64_process2_t)(HANDLE, USHORT *, USHORT *);
+    is_wow64_process2_t is_wow64_process2 = (is_wow64_process2_t)
+                                            GetProcAddress(GetModuleHandle("Kernel32.dll"), "IsWow64Process2");
+
+    USHORT process_machine = 0;
+    USHORT native_machine = 0;
+    BOOL is_wow64 = FALSE;
+
+#ifdef _ARM64_
+    *process_arch = ARCH_ARM64;
+#elif defined(_WIN64)
+    *process_arch = ARCH_AMD64;
+    if (is_wow64_process2)
+    {
+        /* this could be amd64 on arm64 */
+        BOOL is_wow64 = is_wow64_process2(GetCurrentProcess(),
+                                          &process_machine, &native_machine);
+        if (is_wow64 && native_machine == IMAGE_FILE_MACHINE_ARM64)
+        {
+            *host_arch = ARCH_ARM64;
+        }
+    }
 #elif defined(_WIN32)
-    /* 32-bit programs run on both 32-bit and 64-bit Windows */
-    BOOL f64 = FALSE;
-    return IsWow64Process(GetCurrentProcess(), &f64) && f64;
-#else  /* if defined(_WIN64) */
-    return false; /* Win64 does not support Win16 */
-#endif
+    *process_arch = ARCH_X86;
+
+    if (is_wow64_process2)
+    {
+        /* check if we're running on arm64 or amd64 machine */
+        is_wow64 = is_wow64_process2(GetCurrentProcess(),
+                                     &process_machine, &native_machine);
+        if (is_wow64)
+        {
+            switch (native_machine)
+            {
+                case IMAGE_FILE_MACHINE_ARM64:
+                    *host_arch = ARCH_ARM64;
+                    break;
+
+                case IMAGE_FILE_MACHINE_AMD64:
+                    *host_arch = ARCH_AMD64;
+                    break;
+
+                default:
+                    *host_arch = ARCH_UNKNOWN;
+                    break;
+            }
+        }
+    }
+    else
+    {
+        BOOL w64 = FALSE;
+        is_wow64 = IsWow64Process(GetCurrentProcess(), &w64) && w64;
+        if (is_wow64)
+        {
+            /* we are unable to differentiate between arm64 and amd64
+             * machines here, so assume we are running on amd64 */
+            *host_arch = ARCH_AMD64;
+        }
+    }
+#endif /* _ARM64_ */
+}
+
+static void
+win32_print_arch(arch_t arch, struct buffer *out)
+{
+    switch (arch)
+    {
+        case ARCH_X86:
+            buf_printf(out, "x86");
+            break;
+
+        case ARCH_AMD64:
+            buf_printf(out, "amd64");
+            break;
+
+        case ARCH_ARM64:
+            buf_printf(out, "arm64");
+            break;
+
+        case ARCH_UNKNOWN:
+            buf_printf(out, "(unknown)");
+            break;
+
+        default:
+            break;
+    }
 }
 
 const char *
@@ -1397,7 +1485,20 @@ win32_version_string(struct gc_arena *gc, bool add_name)
             break;
     }
 
-    buf_printf(&out, win32_is_64bit() ? " 64bit" : " 32bit");
+    buf_printf(&out, ", ");
+
+    arch_t process_arch, host_arch;
+    win32_get_arch(&process_arch, &host_arch);
+    win32_print_arch(process_arch, &out);
+
+    buf_printf(&out, " executable");
+
+    if (host_arch != ARCH_NATIVE)
+    {
+        buf_printf(&out, " running on ");
+        win32_print_arch(host_arch, &out);
+        buf_printf(&out, " host");
+    }
 
     return (const char *)out.data;
 }
-- 
2.38.1.windows.1


