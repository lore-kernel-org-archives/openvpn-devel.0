From: Selva Nair <selva.nair@...277...>
Date: Tue, 29 Nov 2016 20:48:55 -0500
Message-Id: <1480470535-6287-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH v2.3] Map restart signals from event loop to
	SIGTERM during exit-notification wait
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

Commit 63b3e000c9.. fixed SIGTERM getting lost during exit notification
by ignoring any restart signals triggered during this interval. However,
as reported in Trac 777, this could result in repeated triggering of
restart signals when the event loop cannot continue without restart due
to IO errors or timeout.

Avoid by converting soft SIGUSR1 and SIGHUP signals received during
exit-notify wait period to SIGTERM.

cherry-picked from commit f25a0217e35f53c3110ebb226e1d1f3528152cb5
with (c->sig->source == SIG_SOURCE_HARD) changed to c->sig->hard

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/sig.c | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 87f2cdb..b17e166 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -362,7 +362,8 @@ process_sigterm (struct context *c)
 
 /**
  * If a restart signal is received during exit-notification, reset the
- * signal and return true.
+ * signal and return true. If its a soft restart signal from the event loop
+ * which implies the loop cannot continue, remap to SIGTERM to exit promptly.
  */
 static bool
 ignore_restart_signals (struct context *c)
@@ -372,10 +373,20 @@ ignore_restart_signals (struct context *c)
   if ( (c->sig->signal_received == SIGUSR1 || c->sig->signal_received == SIGHUP) &&
         event_timeout_defined(&c->c2.explicit_exit_notification_interval) )
     {
-       msg (M_INFO, "Ignoring %s received during exit notification",
-            signal_name(c->sig->signal_received, true));
-       signal_reset (c->sig);
-       ret = true;
+       if (c->sig->hard)
+         {
+            msg (M_INFO, "Ignoring %s received during exit notification",
+                 signal_name(c->sig->signal_received, true));
+            signal_reset (c->sig);
+            ret = true;
+         }
+       else
+         {
+            msg (M_INFO, "Converting soft %s received during exit notification to SIGTERM",
+                 signal_name(c->sig->signal_received, true));
+            register_signal(c, SIGTERM, "exit-with-notification");
+            ret = false;
+         }
     }
 #endif
   return ret;
-- 
2.1.4


