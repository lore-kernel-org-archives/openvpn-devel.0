From: Selva Nair <selva.nair@...277...>
Date: Tue, 24 May 2016 18:53:47 -0400
Message-Id: <1464130427-25002-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH] Pass echo option to systemd-ask-password
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

Do not mask input when echo is requested. Useful for username
input and sometimes for challenge response.

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/console.c |    5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index 86331a1..8a8acb4 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -167,7 +167,10 @@ get_console_input_systemd (const char *prompt, const bool echo, char *input, con
 
   argv_init (&argv);
   argv_printf (&argv, SYSTEMD_ASK_PASSWORD_PATH);
-  argv_printf_cat (&argv, "%s", prompt);
+  if (echo)
+    argv_printf_cat (&argv, "--echo %s", prompt);
+  else
+    argv_printf_cat (&argv, "%s", prompt);
 
   if ((std_out = openvpn_popen (&argv, NULL)) < 0) {
 	  return false;
-- 
1.7.10.4


