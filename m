From: David Sommerseth <davids@...515...>
Date: Thu, 25 Aug 2016 23:54:57 +0200
Message-Id: <1472162097-17855-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] Fix client connection instant timeout
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

Commit b3e975824ea9ebae8dbea5b451c8d02525c83ffe moved the finalizing of
TCP/UDP sockets before the UID/GID where dropped.  But this did not
factor that the timeout code had been revamped [1] in the mean time.

This ensures the timout initialization is done before the the socket
finalizing has been completed.

[1] commit f2134b7bea37df15756c599b94f16d4bffafbbd6

Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index ad4ebc3..5b6d246 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3696,6 +3696,9 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
     open_plugins (c, false, OPENVPN_PLUGIN_INIT_POST_DAEMON);
 #endif
 
+  /* initialise connect timeout timer */
+  do_init_server_poll_timeout(c);
+
   /* finalize the TCP/UDP socket */
   if (c->mode == CM_P2P || c->mode == CM_TOP || c->mode == CM_CHILD_TCP)
     do_init_socket_2 (c);
@@ -3706,9 +3709,6 @@ init_instance (struct context *c, const struct env_set *env, const unsigned int
    */
   do_uid_gid_chroot (c, c->c2.did_open_tun);
 
-  /* initialise connect timeout timer */
-  do_init_server_poll_timeout(c);
-
   /* initialize timers */
   if (c->mode == CM_P2P || child)
     do_init_timers (c, false);
-- 
1.8.3.1


