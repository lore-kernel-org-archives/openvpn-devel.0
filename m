From: Simon Rozman <simon@...2293...>
Date: Mon, 22 Mar 2021 11:39:57 +0100
Message-Id: <20210322103957.1234-1-simon@...2293...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] openvpnserv: Cache last error before it is
 overridden
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

FormatMessage() sets the last error according to its own success. This
looses the original error code leading to mismatched error message and
error number when sprintfted together resulting in confusing event log
message.

Signed-off-by: Simon Rozman <simon@...2293...>
---
 src/openvpnserv/common.c | 6 ++++--
 1 file changed, 4 insertions(+), 2 deletions(-)

diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index 48769be4..ebd08677 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -228,12 +228,14 @@ out:
 LPCTSTR
 GetLastErrorText()
 {
+    DWORD error;
     static TCHAR buf[256];
     DWORD len;
     LPTSTR tmp = NULL;
 
+    error = GetLastError();
     len = FormatMessage(FORMAT_MESSAGE_ALLOCATE_BUFFER | FORMAT_MESSAGE_FROM_SYSTEM | FORMAT_MESSAGE_ARGUMENT_ARRAY,
-                        NULL, GetLastError(), LANG_NEUTRAL, (LPTSTR)&tmp, 0, NULL);
+                        NULL, error, LANG_NEUTRAL, (LPTSTR)&tmp, 0, NULL);
 
     if (len == 0 || (long) _countof(buf) < (long) len + 14)
     {
@@ -242,7 +244,7 @@ GetLastErrorText()
     else
     {
         tmp[_tcslen(tmp) - 2] = TEXT('\0'); /* remove CR/LF characters */
-        openvpn_sntprintf(buf, _countof(buf), TEXT("%s (0x%x)"), tmp, GetLastError());
+        openvpn_sntprintf(buf, _countof(buf), TEXT("%s (0x%x)"), tmp, error);
     }
 
     if (tmp)
-- 
2.30.0.windows.2


