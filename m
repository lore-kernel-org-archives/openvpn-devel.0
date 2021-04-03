From: Arne Schwabe <arne@...1227...>
Date: Sat,  3 Apr 2021 14:24:44 +0200
Message-Id: <20210403122444.17090-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Fix async push broken after auth deferred
 refactor
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

Commit c5fec838e moved the auth control file related
states into its own struct. Unfortunately I forgot
to also do the part inside #if defined(ENABLE_ASYNC_PUSH)

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 72f66c5bb..7c9500f3e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2984,11 +2984,11 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
          * and an auth_control_file, we assume it got just added and add
          * inotify watch to that file
          */
-        if (ks && ks->auth_control_file && was_unauthenticated
+        if (ks && ks->plugin_auth.auth_control_file && was_unauthenticated
             && (ks->authenticated == KS_AUTH_DEFERRED))
         {
             add_inotify_file_watch(m, mi, m->top.c2.inotify_fd,
-                                   ks->auth_control_file);
+                                   ks->plugin_auth.auth_control_file);
         }
 #endif
 
-- 
2.30.1


