From: Arne Schwabe <arne@...1227...>
Date: Wed, 19 Oct 2022 15:36:27 +0200
Message-Id: <20221019133627.2918110-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix regression of ignoring --user
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

Commit facb6fffb changed a call in the style of if(a() | b())
to if(a() || b()). While this looks identical, it is not. The first
statement always executes b() while the second only executes b() if
a() returns false. This lead to to the platform_state_user never to
set as side effect and thus --user being ignored. Rewrite the code
to make this more explicit.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c | 12 ++++++++----
 1 file changed, 8 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 07d43d49d..7de65a3ec 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3597,10 +3597,14 @@ do_init_first_time(struct context *c)
         ALLOC_OBJ_CLEAR_GC(c->c0, struct context_0, &c->gc);
         c0 = c->c0;
 
-        /* get user and/or group that we want to setuid/setgid to */
-        c0->uid_gid_specified =
-            platform_group_get(c->options.groupname, &c0->platform_state_group)
-            || platform_user_get(c->options.username, &c0->platform_state_user);
+        /* get user and/or group that we want to setuid/setgid to,
+         * sets also platform_x_state */
+        bool group_defined =  platform_group_get(c->options.groupname,
+                                                 &c0->platform_state_group);
+        bool user_defined = platform_user_get(c->options.username,
+                                              &c0->platform_state_user);
+
+        c0->uid_gid_specified = user_defined || group_defined;
 
         /* perform postponed chdir if --daemon */
         if (c->did_we_daemonize && c->options.cd_dir == NULL)
-- 
2.37.0 (Apple Git-136)


