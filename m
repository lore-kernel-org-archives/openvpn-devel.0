From: Heiko Hund <heiko.hund@...1489...>
Date: Tue, 15 Oct 2013 11:23:42 +0200
Message-ID: <1381829022-15244-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Support non-ASCII TAP adapter names on
	Windows
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

Currently the TAP adapter name is fetched as an OEM string, which
is problematic if it contains non-ASCII characters and is to used
with netsh. The logfile also contains these non UTF-8 characters.

This patch fetches the name from the registry as UCS-2 and converts
it right into UTF-8 before it's used.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/tun.c |   15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 86a43f2..9f53b23 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3141,9 +3141,9 @@ get_panel_reg (struct gc_arena *gc)
       char enum_name[256];
       char connection_string[256];
       HKEY connection_key;
-      char name_data[256];
+      WCHAR name_data[256];
       DWORD name_type;
-      const char name_string[] = "Name";
+      const WCHAR name_string[] = L"Name";
 
       len = sizeof (enum_name);
       status = RegEnumKeyEx(
@@ -3177,12 +3177,12 @@ get_panel_reg (struct gc_arena *gc)
       else
 	{
 	  len = sizeof (name_data);
-	  status = RegQueryValueEx(
+	  status = RegQueryValueExW(
 				   connection_key,
 				   name_string,
 				   NULL,
 				   &name_type,
-				   name_data,
+				   (LPBYTE) name_data,
 				   &len);
 
 	  if (status != ERROR_SUCCESS || name_type != REG_SZ)
@@ -3190,10 +3190,15 @@ get_panel_reg (struct gc_arena *gc)
 		 NETWORK_CONNECTIONS_KEY, connection_string, name_string);
 	  else
 	    {
+              int n;
+              LPSTR name;
 	      struct panel_reg *reg;
 
 	      ALLOC_OBJ_CLEAR_GC (reg, struct panel_reg, gc);
-	      reg->name = string_alloc (name_data, gc);
+              n = WideCharToMultiByte (CP_UTF8, 0, name_data, -1, NULL, 0, NULL, NULL);
+              name = gc_malloc (n, false, gc);
+              WideCharToMultiByte (CP_UTF8, 0, name_data, -1, name, n, NULL, NULL);
+              reg->name = name;
 	      reg->guid = string_alloc (enum_name, gc);
 		      
 	      /* link into return list */
-- 
1.7.9.5


