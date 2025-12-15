From: Gert Doering <gert@...1296...>
Date: Mon, 15 Dec 2025 16:04:54 +0100
Message-ID: <20251215150500.18898-1-gert@...1296...>
In-Reply-To: <gerrit.1761570487000.I62b8263f18c4e2e7f5ecacb4616737f5ba836303@...2715...>
References: <gerrit.1761570487000.I62b8263f18c4e2e7f5ecacb4616737f5ba836303@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v9] multi: Fix wrong sigma value in
 multi_push_restart_schedule_exit
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

From: Frank Lichtenheld <frank@...2641...>

Sigma was computed based on the absolute time and
not the delta.

Note that this probably makes no actual difference in
practice. The sigma value is irrelevant on first call
and multi_push_restart_schedule_exit should not be
called multiple times since it is only called
if deferred_shutdown_signal.signal_received is not set,
yet.

Change-Id: I62b8263f18c4e2e7f5ecacb4616737f5ba836303
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1311
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1311
This mail reflects revision 9 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d2d9ba8e..d9cb3a9 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3820,7 +3820,6 @@
 {
     struct hash_iterator hi;
     struct hash_element *he;
-    struct timeval tv;
 
     /* tell all clients to restart */
     hash_iterator_init(m->iter, &hi);
@@ -3838,15 +3837,14 @@
 
     /* reschedule signal */
     ASSERT(!openvpn_gettimeofday(&m->deferred_shutdown_signal.wakeup, NULL));
-    tv.tv_sec = 2;
-    tv.tv_usec = 0;
+    struct timeval tv = { .tv_sec = 2, .tv_usec = 0 };
     tv_add(&m->deferred_shutdown_signal.wakeup, &tv);
 
     m->deferred_shutdown_signal.signal_received = m->top.sig->signal_received;
 
     schedule_add_entry(m->schedule, (struct schedule_entry *)&m->deferred_shutdown_signal,
                        &m->deferred_shutdown_signal.wakeup,
-                       compute_wakeup_sigma(&m->deferred_shutdown_signal.wakeup));
+                       compute_wakeup_sigma(&tv));
 
     signal_reset(m->top.sig, 0);
 }

