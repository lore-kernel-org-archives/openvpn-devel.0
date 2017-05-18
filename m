From: Gert Doering <gert@...1296...>
Date: Thu, 18 May 2017 21:13:11 +0200
Message-Id: <20170518191311.4769-1-gert@...1296...>
Subject: [Openvpn-devel] [PATCH] Remove erroneous limitation on max number
	of args for --plugin
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

Commit 3d6a4cded2 introduced a maximum limit of possible arguments
for most options, to error out on config lines with too-many args.

Commit 82acf21634 extended the limit for "--plugin" to accept "one
mandatory, one optional" argument.

Both are wrong - "--plugin" can accept an arbitrary number of arguments,
but this is not directly obvious from options.c, one needs to check
plugins.c / plugin_option_list_add() and misc.c / make_extended_arg_array()
to see that.

Thus, remove the max limit for "--plugin" completely.

(Reported by SviMik on IRC)

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/options.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f38abad..452087a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5152,7 +5152,7 @@ add_option(struct options *options,
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
 #ifdef ENABLE_PLUGIN
-    else if (streq(p[0], "plugin") && p[1] && !p[3])
+    else if (streq(p[0], "plugin") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_PLUGIN);
         if (!options->plugin_list)
-- 
2.10.2


