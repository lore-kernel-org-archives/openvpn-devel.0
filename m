From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Sep 2015 11:23:37 +0200
Message-Id: <1442309019-7586-7-git-send-email-arne@...1227...>
In-Reply-To: <1442309019-7586-1-git-send-email-arne@...1227...>
References: <1442309019-7586-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 6/8] Extend network-change command to allow
	reprotecting on the same network (for short connection losses)
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

---
 src/openvpn/init.c   |  6 +++---
 src/openvpn/manage.c | 11 ++++++++---
 src/openvpn/manage.h |  2 +-
 3 files changed, 12 insertions(+), 7 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index beeb487..52743e7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3160,14 +3160,14 @@ management_show_net_callback (void *arg, const int msglevel)
 
 #ifdef TARGET_ANDROID
 int
-managmenet_callback_network_change (void *arg)
+managmenet_callback_network_change (void *arg, bool samenetwork)
 {
     /* Check if the client should translate the network change to a SIGUSR1 to
      reestablish the connection or just reprotect the socket
 
      At the moment just assume that, for all settings that use pull (not
      --static) and are not using peer-id reestablishing the connection is
-     required
+     required (unless the network is the same)
 
      The function returns -1 on invalid fd and -2 if the socket cannot be
      reused. On the -2 return value the man_network_change function triggers
@@ -3182,7 +3182,7 @@ managmenet_callback_network_change (void *arg)
     return -1;
 
   socketfd = c->c2.link_socket->sd;
-  if (!c->options.pull || c->c2.tls_multi->use_peer_id)
+  if (!c->options.pull || c->c2.tls_multi->use_peer_id || samenetwork)
     return socketfd;
   else
     return -2;
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index af4aa44..d02dac9 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1129,7 +1129,7 @@ man_remote (struct management *man, const char **p)
 
 #ifdef TARGET_ANDROID
 static void
-man_network_change (struct management *man)
+man_network_change (struct management *man, bool samenetwork)
 {
   /* Called to signal the OpenVPN that the network configuration has changed and
      the client should either float or reconnect.
@@ -1138,7 +1138,8 @@ man_network_change (struct management *man)
   */
   if (man->persist.callback.network_change)
     {
-      int fd = (*man->persist.callback.network_change)(man->persist.callback.arg);
+      int fd = (*man->persist.callback.network_change)
+	(man->persist.callback.arg, samenetwork);
       man->connection.fdtosend = fd;
       msg (M_CLIENT, "PROTECTFD: fd '%d' sent to be protected", fd);
       if (fd == -2)
@@ -1193,7 +1194,11 @@ man_dispatch_command (struct management *man, struct status_output *so, const ch
 #ifdef TARGET_ANDROID
   else if (streq (p[0], "network-change"))
     {
-      man_network_change(man);
+      bool samenetwork = false;
+      if (p[1] && streq(p[1], "samenetwork"))
+	samenetwork = true;
+
+      man_network_change(man, samenetwork);
     }
 #endif
   else if (streq (p[0], "load-stats"))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 7318377..a97e8a2 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -174,7 +174,7 @@ struct management_callback
   bool (*proxy_cmd) (void *arg, const char **p);
   bool (*remote_cmd) (void *arg, const char **p);
 #ifdef TARGET_ANDROID
-  int (*network_change) (void *arg);
+  int (*network_change) (void *arg, bool samenetwork);
 #endif
 };
 
-- 
2.3.2 (Apple Git-55)


