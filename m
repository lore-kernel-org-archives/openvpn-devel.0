From: Arne Schwabe <arne@...1227...>
Date: Tue, 15 Sep 2015 11:23:32 +0200
Message-Id: <1442309019-7586-2-git-send-email-arne@...1227...>
In-Reply-To: <1442309019-7586-1-git-send-email-arne@...1227...>
References: <1442309019-7586-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/8] Add support for requesting the fd again
	to rebind to the next interface.
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

This not done via android_control since calling management from management leads to an infinitive loop
---
 src/openvpn/init.c   | 34 ++++++++++++++++++++++++++++++++++
 src/openvpn/manage.c | 26 ++++++++++++++++++++++++++
 src/openvpn/manage.h |  3 +++
 3 files changed, 63 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fe00918..beeb487 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3158,6 +3158,37 @@ management_show_net_callback (void *arg, const int msglevel)
 #endif
 }
 
+#ifdef TARGET_ANDROID
+int
+managmenet_callback_network_change (void *arg)
+{
+    /* Check if the client should translate the network change to a SIGUSR1 to
+     reestablish the connection or just reprotect the socket
+
+     At the moment just assume that, for all settings that use pull (not
+     --static) and are not using peer-id reestablishing the connection is
+     required
+
+     The function returns -1 on invalid fd and -2 if the socket cannot be
+     reused. On the -2 return value the man_network_change function triggers
+     a SIGUSR1 to force a reconnect.
+    */
+
+  int socketfd=-1;
+  struct context *c = (struct context *) arg;
+  if (!c->c2.link_socket)
+    return -1;
+  if (c->c2.link_socket->sd == SOCKET_UNDEFINED)
+    return -1;
+
+  socketfd = c->c2.link_socket->sd;
+  if (!c->options.pull || c->c2.tls_multi->use_peer_id)
+    return socketfd;
+  else
+    return -2;
+}
+#endif
+
 #endif
 
 void
@@ -3173,6 +3204,9 @@ init_management_callback_p2p (struct context *c)
       cb.show_net = management_show_net_callback;
       cb.proxy_cmd = management_callback_proxy_cmd;
       cb.remote_cmd = management_callback_remote_cmd;
+#ifdef TARGET_ANDROID
+      cb.network_change = managmenet_callback_network_change;
+#endif
       management_set_callback (management, &cb);
     }
 #endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 4f0945c..af4aa44 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1127,6 +1127,26 @@ man_remote (struct management *man, const char **p)
     }
 }
 
+#ifdef TARGET_ANDROID
+static void
+man_network_change (struct management *man)
+{
+  /* Called to signal the OpenVPN that the network configuration has changed and
+     the client should either float or reconnect.
+
+     The code is currently only used by ics-openvpn
+  */
+  if (man->persist.callback.network_change)
+    {
+      int fd = (*man->persist.callback.network_change)(man->persist.callback.arg);
+      man->connection.fdtosend = fd;
+      msg (M_CLIENT, "PROTECTFD: fd '%d' sent to be protected", fd);
+      if (fd == -2)
+	man_signal (man, "SIGUSR1");
+    }
+}
+#endif
+
 static void
 man_dispatch_command (struct management *man, struct status_output *so, const char **p, const int nparms)
 {
@@ -1170,6 +1190,12 @@ man_dispatch_command (struct management *man, struct status_output *so, const ch
       if (man_need (man, p, 1, 0))
 	man_signal (man, p[1]);
     }
+#ifdef TARGET_ANDROID
+  else if (streq (p[0], "network-change"))
+    {
+      man_network_change(man);
+    }
+#endif
   else if (streq (p[0], "load-stats"))
     {
       man_load_stats (man);
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 8d6e87e..7318377 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -173,6 +173,9 @@ struct management_callback
 #endif
   bool (*proxy_cmd) (void *arg, const char **p);
   bool (*remote_cmd) (void *arg, const char **p);
+#ifdef TARGET_ANDROID
+  int (*network_change) (void *arg);
+#endif
 };
 
 /*
-- 
2.3.2 (Apple Git-55)


