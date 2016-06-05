From: Selva Nair <selva.nair@...277...>
Date: Sun,  5 Jun 2016 17:41:24 -0400
Message-Id: <1465162884-32520-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1465162884-32520-1-git-send-email-selva.nair@...277...>
References: <1464668569-6480-1-git-send-email-selva.nair@...277...>
	<1465162884-32520-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 2/2] Save exit-notify timer during a restart
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

When exit-notify is specified, SIGTERM could be lost if a SIGUSR1/SIGHUP
restart happens during the exit notification interval. This is
particularly apparent when pull-filter reject causes a repeated SIGUSR1
restart cycle.

- Save the explicit_exit_notification_interval and time_wait
  across restarts.
- Check pending SIGTERM (with exit notification) in the SIGUSR1/SIGHUP
  loop and cause an exit instead of restart.

Trac #687

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/init.c    |   16 ++++++++++++++++
 src/openvpn/openvpn.c |    8 ++++++++
 2 files changed, 24 insertions(+)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 42baf97..5a69a13 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -76,7 +76,23 @@ context_clear_1 (struct context *c)
 void
 context_clear_2 (struct context *c)
 {
+#ifdef ENABLE_OCC
+  /* If we are in the middle of an exit notification, save the timer info */
+  struct event_timeout saved_interval = {0};
+  time_t saved_time_wait = 0;
+  if (event_timeout_defined(&c->c2.explicit_exit_notification_interval))
+    {
+      saved_interval = c->c2.explicit_exit_notification_interval;
+      saved_time_wait = c->c2.explicit_exit_notification_time_wait;
+    }
+#endif
+
   CLEAR (c->c2);
+
+#ifdef ENABLE_OCC
+  c->c2.explicit_exit_notification_interval = saved_interval;
+  c->c2.explicit_exit_notification_time_wait = saved_time_wait;
+#endif
 }
 
 void
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 823c3dd..6beb224 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -281,6 +281,14 @@ openvpn_main (int argc, char *argv[])
 	      /* indicates first iteration -- has program-wide scope */
 	      c.first_time = false;
 
+# ifdef ENABLE_OCC
+              /* If we are in the middle of exit notification, exit now */
+              if (event_timeout_defined(&c.c2.explicit_exit_notification_interval))
+                {
+                  register_signal (&c, SIGTERM, "exit-with-notification");
+                }
+# endif
+
 	      /* any signals received? */
 	      if (IS_SIG (&c))
 		print_signal (c.sig, NULL, M_INFO);
-- 
1.7.10.4


