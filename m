From: James Yonan <james@...515...>
Date: Thu,  3 Mar 2016 01:19:06 -0700
Message-Id: <1456993146-63968-10-git-send-email-james@...515...>
In-Reply-To: <1456993146-63968-1-git-send-email-james@...515...>
References: <1456993146-63968-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH 10/10] Bind to local socket before dropping
	privileges
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
Cc: James Yonan <james@...515...>

Bind the local TCP/UDP socket before UID/GID downgrade,
otherwise we cannot bind to ports < 1024.

Signed-off-by: James Yonan <james@...515...>
---
 src/openvpn/init.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index cb73a3d..9658895 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3630,16 +3630,16 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
     open_plugins (c, false, OPENVPN_PLUGIN_INIT_POST_DAEMON);
 #endif
 
+  /* finalize the TCP/UDP socket */
+  if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
+    do_init_socket_2 (c);
+
   /*
    * Actually do UID/GID downgrade, and chroot, if requested.
    * May be delayed by --client, --pull, or --up-delay.
    */
   do_uid_gid_chroot (c, c->c2.did_open_tun);
 
-  /* finalize the TCP/UDP socket */
-  if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
-    do_init_socket_2 (c);
-
   /* initialize timers */
   if (c->mode == CM_P2P || child)
     do_init_timers (c, false);
-- 
1.9.1


