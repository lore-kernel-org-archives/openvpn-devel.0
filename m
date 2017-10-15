From: selva.nair@...277...
Date: Sun, 15 Oct 2017 15:05:15 -0400
Message-Id: <1508094315-466-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Fix missing check for return value of
 malloc'd buffer
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

- Use utf8to16 from common.c for utf8 to wide conversion and
  check its return value

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 18 ++++++++++--------
 1 file changed, 10 insertions(+), 8 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 3f98217..f3be113 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -547,15 +547,17 @@ static DWORD
 InterfaceLuid(const char *iface_name, PNET_LUID luid)
 {
     NETIO_STATUS status;
-    LPWSTR wide_name;
-    int n;
-
-    n = MultiByteToWideChar(CP_UTF8, 0, iface_name, -1, NULL, 0);
-    wide_name = malloc(n * sizeof(WCHAR));
-    MultiByteToWideChar(CP_UTF8, 0, iface_name, -1, wide_name, n);
-    status = ConvertInterfaceAliasToLuid(wide_name, luid);
-    free(wide_name);
+    LPWSTR wide_name = utf8to16(iface_name);
 
+    if (wide_name)
+    {
+        status = ConvertInterfaceAliasToLuid(wide_name, luid);
+        free(wide_name);
+    }
+    else
+    {
+        status = ERROR_OUTOFMEMORY;
+    }
     return status;
 }
 
-- 
2.6.2


