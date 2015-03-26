From: Steffan Karger <steffan@...1856...>
Date: Thu, 26 Mar 2015 01:01:29 +0100
Message-Id: <1427328089-886-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Remove unneeded parameter 'first_time' from
	possibility_become_daemon()
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

The static helper function possibily_become_deamon() is called only once,
by do_init_first_time(), which checks 'first_time' to be true before
calling possibily_become_daemon().  This makes the parameter useless.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b670a48..b97d2da 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -917,10 +917,10 @@ do_persist_tuntap (const struct options *options)
  * Return true if we did it.
  */
 static bool
-possibly_become_daemon (const struct options *options, const bool first_time)
+possibly_become_daemon (const struct options *options)
 {
   bool ret = false;
-  if (first_time && options->daemon)
+  if (options->daemon)
     {
       ASSERT (!options->inetd);
       if (daemon (options->cd_dir != NULL, options->log) < 0)
@@ -2771,7 +2771,7 @@ do_init_first_time (struct context *c)
       get_pid_file (c->options.writepid, &c0->pid_state);
 
       /* become a daemon if --daemon */
-      c->did_we_daemonize = possibly_become_daemon (&c->options, c->first_time);
+      c->did_we_daemonize = possibly_become_daemon (&c->options);
 
       /* should we disable paging? */
       if (c->options.mlock && c->did_we_daemonize)
-- 
2.1.0


