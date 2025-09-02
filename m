From: Gert Doering <gert@...1296...>
Date: Tue,  2 Sep 2025 18:00:44 +0200
Message-ID: <20250902160050.18640-1-gert@...1296...>
In-Reply-To: <gerrit.1753449319000.Ic0035d52e0ea123398318870d2f4d21af927a602@...2715...>
References: <gerrit.1753449319000.Ic0035d52e0ea123398318870d2f4d21af927a602@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] management: resync timer on bytecount
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
If a user issues `bytecount n` via the management interface, but the
next scheduled wakeup is more than n seconds away, bandwidth logging
will be delayed until that timer fires.

To ensure timely logging, reset the timer whenever a new `bytecount`
command is received. This guarantees that logging begins exactly n
seconds after the command, matching the user-defined interval.

Change-Id: Ic0035d52e0ea123398318870d2f4d21af927a602
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1113
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index aed04f5..53a3e4e 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -41,6 +41,7 @@
 #include "manage.h"
 #include "openvpn.h"
 #include "dco.h"
+#include "multi.h"
 
 #include "memdbg.h"
 
@@ -513,6 +514,28 @@
         man->connection.bytecount_update_seconds = 0;
         event_timeout_clear(&man->connection.bytecount_update_interval);
     }
+
+    /* The newly received bytecount interval may be sooner than the existing
+     * coarse timer wakeup. Reset the timer to ensure it fires at the correct,
+     * earlier time.
+     */
+    if (man->persist.callback.arg)
+    {
+        struct context *c;
+
+        if (man->settings.flags & MF_SERVER)
+        {
+            struct multi_context *m = man->persist.callback.arg;
+            c = &m->top;
+        }
+        else
+        {
+            c = man->persist.callback.arg;
+        }
+
+        reset_coarse_timers(c);
+    }
+
     msg(M_CLIENT, "SUCCESS: bytecount interval changed");
 }
 

