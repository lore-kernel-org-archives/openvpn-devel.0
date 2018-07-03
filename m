From: selva.nair@...277...
Date: Mon,  2 Jul 2018 21:24:46 -0400
Message-Id: <1530581086-7825-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Make up/down script errors not FATAL
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

Instead log only a warning.

This helps user interfaces enforce a safer script-security setting
without causing a FATAL error.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
Note: All other scripts are called with flag = 0 and will only
trigger a warning message if openvpn_execve fails.

 src/openvpn/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b748357..6673734 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -174,7 +174,7 @@ run_up_down(const char *command,
         argv_printf_cat(&argv, "%s %d %d %s %s %s", arg, tun_mtu, link_mtu,
                         ifconfig_local, ifconfig_remote, context);
         argv_msg(M_INFO, &argv);
-        openvpn_run_script(&argv, es, S_FATAL, "--up/--down");
+        openvpn_run_script(&argv, es, 0, "--up/--down");
         argv_reset(&argv);
     }
 
-- 
2.1.4


