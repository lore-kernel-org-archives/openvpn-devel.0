From: Selva Nair <selva.nair@...277...>
Date: Tue,  7 Jun 2016 00:44:20 -0400
Message-Id: <1465274660-11009-2-git-send-email-selva.nair@...277...>
In-Reply-To: <1465274660-11009-1-git-send-email-selva.nair@...277...>
References: <1465274660-11009-1-git-send-email-selva.nair@...277...>
Subject: [Openvpn-devel] [PATCH 1/1] Ignore SIGUSR1/SIGHUP during exit
	notification
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

This allows exit notification to complete and finally trigger SIGTERM.
The current practice of allowing a restart in this state clears
the exit notification timer data and thus loses the SIGTERM.

Trac #687

Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpn/sig.c |   25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index f903fc0..718b786 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -376,12 +376,35 @@ process_sigterm (struct context *c)
   return ret;
 }
 
+/**
+ * If a restart signal is received during exit-notification, reset the
+ * signal and return true.
+ */
+static bool
+ignore_restart_signals (struct context *c)
+{
+  bool ret = false;
+#ifdef ENABLE_OCC
+  if ( (c->sig->signal_received == SIGUSR1 || c->sig->signal_received == SIGHUP) &&
+        event_timeout_defined(&c->c2.explicit_exit_notification_interval) )
+    {
+       msg (M_INFO, "Ignoring %s received during exit notification",
+            signal_name(c->sig->signal_received, true));
+       signal_reset (c->sig);
+       ret = true;
+    }
+#endif
+  return ret;
+}
+
 bool
 process_signal (struct context *c)
 {
   bool ret = true;
 
-  if (c->sig->signal_received == SIGTERM || c->sig->signal_received == SIGINT)
+  if (ignore_restart_signals (c))
+    ret = false;
+  else if (c->sig->signal_received == SIGTERM || c->sig->signal_received == SIGINT)
     {
       ret = process_sigterm (c);
     }
-- 
1.7.10.4


