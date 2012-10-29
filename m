From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 29 Oct 2012 14:38:30 +0100
Message-ID: <1351517910-11414-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] fix display of plugin hook types
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

The OPENVPN_PLUGIN_ROUTE_PREDOWN hook was missing and displayed as
"PLUGIN_???" in the log.

OPENVPN_PLUGIN_ENABLE_PF was the only one that displayed the
OPENVPN_ prefix.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/plugin.c |    4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 944d833..83f79e4 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -98,7 +98,9 @@ plugin_type_name (const int type)
     case OPENVPN_PLUGIN_TLS_FINAL:
       return "PLUGIN_TLS_FINAL";
     case OPENVPN_PLUGIN_ENABLE_PF:
-      return "OPENVPN_PLUGIN_ENABLE_PF";
+      return "PLUGIN_ENABLE_PF";
+    case OPENVPN_PLUGIN_ROUTE_PREDOWN:
+      return "PLUGIN_ROUTE_PREDOWN";
     default:
       return "PLUGIN_???";
     }
-- 
1.7.9.5


