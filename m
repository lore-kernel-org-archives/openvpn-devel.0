From: Lev Stipakov <lstipakov@...277...>
Date: Wed, 21 Apr 2021 11:00:16 +0300
Message-Id: <20210421080016.110-1-lstipakov@...277...>
Subject: [Openvpn-devel] [PATCH] tapctl: support for ovpn-dco Windows driver
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

Make tapctl aware of ovpn-dco.

Signed-off-by: Lev Stipakov <lev@...515...>
---
 src/tapctl/main.c | 13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff --git a/src/tapctl/main.c b/src/tapctl/main.c
index d5bc7290..3350bf1f 100644
--- a/src/tapctl/main.c
+++ b/src/tapctl/main.c
@@ -81,9 +81,9 @@ static const TCHAR usage_message_create[] =
     TEXT("               specified, a default adapter name is chosen by Windows.         \n")
     TEXT("               Note: This name can also be specified as OpenVPN's --dev-node   \n")
     TEXT("               option.                                                         \n")
-    TEXT("--hwid <hwid>  Adapter hardware ID. Default value is root\\tap0901, which       \n")
-    TEXT("               describes tap-windows6 driver. To work with wintun driver,      \n")
-    TEXT("               specify 'wintun'.                                               \n")
+    TEXT("--hwid <hwid>  Adapter hardware ID. Default value is root\\tap0901, which      \n")
+    TEXT("               describes tap-windows6 driver. To work with wintun or ovpn-dco  \n")
+    TEXT("               driver, specify 'wintun' or 'ovpn-dco'.                         \n")
     TEXT("\n")
     TEXT("Output:\n")
     TEXT("\n")
@@ -101,8 +101,8 @@ static const TCHAR usage_message_list[] =
     TEXT("\n")
     TEXT("Options:\n")
     TEXT("\n")
-    TEXT("--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901, tap0901 and      \n")
-    TEXT("               wintun adapters are listed. Use this switch to limit the list.  \n")
+    TEXT("--hwid <hwid>  Adapter hardware ID. By default, root\\tap0901, tap0901, wintun and \n")
+    TEXT("               ovpn-dco adapters are listed. Use this switch to limit the list.\n")
     TEXT("\n")
     TEXT("Output:\n")
     TEXT("\n")
@@ -275,7 +275,8 @@ create_delete_adapter:
         TCHAR szzHwId[0x100] =
             TEXT("root\\") TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0")
             TEXT(TAP_WIN_COMPONENT_ID) TEXT("\0")
-            TEXT("Wintun\0");
+            TEXT("Wintun\0")
+            TEXT("ovpn-dco\0");
 
         /* Parse options. */
         for (int i = 2; i < argc; i++)
-- 
2.17.1


