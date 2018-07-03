From: selva.nair@...277...
Date: Tue,  3 Jul 2018 11:58:29 -0400
Message-Id: <1530633509-4959-1-git-send-email-selva.nair@...277...>
In-Reply-To: <1530581086-7825-1-git-send-email-selva.nair@...277...>
References: <1530581086-7825-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2] Make up/down script errors not FATAL
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

Treat the error as not FATAL only if its triggered due
to script_security < SSEC_SCRIPTS.

This helps user interfaces enforce a safer script-security setting
without causing a FATAL error.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
v2 changes:
- Have script errors continue to trigger a FATAL error.
- Update the commit message to match this change.

 src/openvpn/init.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b748357..074a2d3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -168,13 +168,14 @@ run_up_down(const char *command,
     if (command)
     {
         struct argv argv = argv_new();
+        int flags = (script_security >= SSEC_SCRIPTS)? S_FATAL : 0;
         ASSERT(arg);
         setenv_str(es, "script_type", script_type);
         argv_parse_cmd(&argv, command);
         argv_printf_cat(&argv, "%s %d %d %s %s %s", arg, tun_mtu, link_mtu,
                         ifconfig_local, ifconfig_remote, context);
         argv_msg(M_INFO, &argv);
-        openvpn_run_script(&argv, es, S_FATAL, "--up/--down");
+        openvpn_run_script(&argv, es, flags, "--up/--down");
         argv_reset(&argv);
     }
 
-- 
2.1.4


