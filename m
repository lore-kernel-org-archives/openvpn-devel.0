From: selva.nair@...277...
Date: Mon, 11 Feb 2019 15:46:01 -0500
Message-Id: <1549917961-632-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Exit early when external scripts are
 specified with script-security < 2
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

Currently this raises a warning only. A fatal error is triggered
later with a confusing message that script failed to execute.

This helps the Windows GUI to show a relevant error message when
script-security is over-ridden as a security measure.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 3c44967..5863828 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3206,7 +3206,7 @@ do_option_warnings(struct context *c)
         }
         else
         {
-            msg(M_WARN, "NOTE: starting with " PACKAGE_NAME " 2.1, '--script-security 2' or higher is required to call user-defined scripts or executables");
+            msg(M_FATAL, "ERROR: starting with " PACKAGE_NAME " 2.1, '--script-security 2' or higher is required to call user-defined scripts or executables");
         }
     }
 }
-- 
2.1.4


