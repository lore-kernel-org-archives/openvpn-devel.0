From: David Sommerseth <davids@...515...>
Date: Wed, 16 Nov 2016 21:18:44 +0100
Message-Id: <1479327524-25415-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Remove unused variable in
	argv_printf_arglist()
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

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/argv.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index f8287b7..596e59c 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -252,7 +252,6 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
               char *s1 = va_arg (arglist, char *);
               char *s2 = va_arg (arglist, char *);
               char *combined;
-              char *cmd_name;
 
               if (!s1) s1 = "";
               if (!s2) s2 = "";
-- 
1.8.3.1


