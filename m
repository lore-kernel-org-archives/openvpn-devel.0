From: selva.nair@...277...
Date: Tue, 18 Apr 2023 09:40:11 -0400
Message-Id: <20230418134011.1752777-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Format Windows error message in Unicode
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

- We assume that all text passed to the management interface
  and written to log file are in Unicode (UTF-8). This is broken by
  the use of the ANSI version of FormatMessage() for Windows error
  messages. Fix by using FormatMessageW() and converting the UTF-16
  result to UTF-8.

Github: fixes OpenVPN/openvpn#319

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/error.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index a2c9aa4c..ef821fcd 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -970,19 +970,24 @@ strerror_win32(DWORD errnum, struct gc_arena *gc)
 
     /* format a windows error message */
     {
-        char message[256];
+        wchar_t wmessage[256];
+        char *message = NULL;
         struct buffer out = alloc_buf_gc(256, gc);
-        const int status =  FormatMessage(
+        const int status =  FormatMessageW(
             FORMAT_MESSAGE_IGNORE_INSERTS
             | FORMAT_MESSAGE_FROM_SYSTEM
             | FORMAT_MESSAGE_ARGUMENT_ARRAY,
             NULL,
             errnum,
             0,
-            message,
-            sizeof(message),
+            wmessage,
+            SIZE(wmessage),
             NULL);
-        if (!status)
+        if (status)
+        {
+            message = utf16to8(wmessage, gc);
+        }
+        if (!status || !message)
         {
             buf_printf(&out, "[Unknown Win32 Error]");
         }
-- 
2.34.1


