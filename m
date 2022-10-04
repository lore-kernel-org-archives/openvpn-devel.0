From: Gert Doering <gert@...1296...>
Date: Tue,  4 Oct 2022 16:51:42 +0200
Message-Id: <20221004145142.19091-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] use boolean '||' to join two bools,
 not bitwise '|'
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

FreeBSD 14 clang complains about this:

init.c:3530:13: warning: use of bitwise '|' with boolean operands [-Wbitwise-instead-of-logical]
            platform_group_get(c->options.groupname, &c0->platform_state_group)
            ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
init.c:3530:13: note: cast one or both operands to int to silence this warning
1 warning generated.

.. so do what it wants us to do.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/init.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 03416844..c88c0915 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3528,7 +3528,7 @@ do_init_first_time(struct context *c)
         /* get user and/or group that we want to setuid/setgid to */
         c0->uid_gid_specified =
             platform_group_get(c->options.groupname, &c0->platform_state_group)
-            |platform_user_get(c->options.username, &c0->platform_state_user);
+            || platform_user_get(c->options.username, &c0->platform_state_user);
 
         /* perform postponed chdir if --daemon */
         if (c->did_we_daemonize && c->options.cd_dir == NULL)
-- 
2.37.3


