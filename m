From: Gert Doering <gert@...1296...>
Date: Fri, 29 Aug 2025 15:19:58 +0200
Message-ID: <20250829132006.17550-1-gert@...1296...>
In-Reply-To: <gerrit.1753449319000.Ic0035d52e0ea123398318870d2f4d21af927a602@...2715...>
References: <gerrit.1753449319000.Ic0035d52e0ea123398318870d2f4d21af927a602@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] management: resync timer on bytecount
 interval change
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

From: Ralf Lici <ralf@...2726...>

coarse_timer_wakeup tracks when the next timer-driven task will occur.
When a user issues `bytecount n` on the management interface but the
existing wakeup is more than n seconds ahead, bandwidth logging won’t
run until that original timer fires, delaying logs.

Introduce a flag to detect when the bytecount interval changes and,
when set, recalculate coarse_timer_wakeup so logging fires exactly
n seconds after the command. This guarantees bytecount adheres to the
user-specified interval.

Change-Id: Ic0035d52e0ea123398318870d2f4d21af927a602
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1113
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index dfc6708..1c9b4f8 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -838,6 +838,19 @@
 static void
 check_coarse_timers(struct context *c)
 {
+#ifdef ENABLE_MANAGEMENT
+    /* The 'bytecount' command starts a timer at runtime, but it would not be
+     * processed if coarse_timer_wakeup was previously set to a higher value.
+     * Therefore, if the command has arrived, we reset coarse_timer_wakeup in
+     * to order to update it accordingly.
+     */
+    if (management && management->connection.bytecount_interval_changed)
+    {
+        reset_coarse_timers(c);
+        management->connection.bytecount_interval_changed = false;
+    }
+#endif /* ENABLE_MANAGEMENT */
+
     if (now < c->c2.coarse_timer_wakeup)
     {
         context_reschedule_sec(c, c->c2.coarse_timer_wakeup - now);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 8836e79..0df78ee 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -503,6 +503,7 @@
         man->connection.bytecount_update_seconds = 0;
         event_timeout_clear(&man->connection.bytecount_update_interval);
     }
+    man->connection.bytecount_interval_changed = true;
     msg(M_CLIENT, "SUCCESS: bytecount interval changed");
 }
 
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index eb19a4e..00e3931 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -318,6 +318,7 @@
     bool state_realtime;
     bool log_realtime;
     bool echo_realtime;
+    bool bytecount_interval_changed;
     int bytecount_update_seconds;
     struct event_timeout bytecount_update_interval;
 

