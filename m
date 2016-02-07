From: Lev Stipakov <lstipakov@...277...>
Date: Sun,  7 Feb 2016 22:21:32 +0200
Message-Id: <1454876492-6588-1-git-send-email-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] Report Windows bitness
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Trac #599

Signed-off-by: Lev Stipakov <lstipakov@...277...>
---
 src/openvpn/win32.c | 16 ++++++++++++++++
 1 file changed, 16 insertions(+)

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 6c6ac4c..5702304 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -1323,6 +1323,20 @@ win32_version_info()
     }
 }
 
+bool
+win32_is_64bit()
+{
+#if defined(_WIN64)
+    return true;  // 64-bit programs run only on Win64
+#elif defined(_WIN32)
+    // 32-bit programs run on both 32-bit and 64-bit Windows
+    BOOL f64 = FALSE;
+    return IsWow64Process(GetCurrentProcess(), &f64) && f64;
+#else
+    return false; // Win64 does not support Win16
+#endif
+}
+
 const char *
 win32_version_string(struct gc_arena *gc, bool add_name)
 {
@@ -1349,6 +1363,8 @@ win32_version_string(struct gc_arena *gc, bool add_name)
             break;
     }
 
+    buf_printf (&out, win32_is_64bit() ? " 64bit" : " 32bit");
+
     return (const char *)out.data;
 }
 
-- 
1.9.1


