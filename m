From: Gert Doering <gert@...1296...>
Date: Tue, 21 Oct 2025 09:08:20 +0200
Message-ID: <20251021070825.20773-1-gert@...1296...>
In-Reply-To: <gerrit.1760942237000.Ifb1c49fce75e671f699f5db5f6da7246f6e0b519@...2715...>
References: <gerrit.1760942237000.Ifb1c49fce75e671f699f5db5f6da7246f6e0b519@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] management: ensure consistent BYTECOUNT
 timing on server
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

The BYTECOUNT notification is expected to be emitted every N seconds
when a management client issues the 'bytecount N' command. However, the
server currently relies on timeouts from unrelated periodic operations,
resulting in irregular notification timing.

This issue is especially noticeable with low bytecount intervals and DCO
enabled, as openvpn handles less traffic in userspace, causing the main
loop to run less frequently.

To address this, refactor the timeout logic and pass the timeval
reference to management_check_bytecount_server so that the timeout is
correctly set and notifications adhere to the specified interval.

Change-Id: Ifb1c49fce75e671f699f5db5f6da7246f6e0b519
Signed-off-by: Ralf Lici <ralf@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1285
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Lev Stipakov <lstipakov@...277...>

        
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1cb5c63..685b137 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -4184,16 +4184,14 @@
 }
 
 void
-management_check_bytecount_server(struct multi_context *multi)
+management_check_bytecount_server(struct multi_context *multi, struct timeval *timeval)
 {
     if (!(management->persist.callback.flags & MCF_SERVER))
     {
         return;
     }
 
-    struct timeval null;
-    CLEAR(null);
-    if (event_timeout_trigger(&management->connection.bytecount_update_interval, &null, ETT_DEFAULT))
+    if (event_timeout_trigger(&management->connection.bytecount_update_interval, timeval, ETT_DEFAULT))
     {
         /* fetch counters from dco */
         if (dco_enabled(&multi->top.options))
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index a31eb06..fe460bf 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -493,7 +493,7 @@
 
 void management_check_bytecount_client(struct context *c, struct management *man, struct timeval *timeval);
 
-void management_check_bytecount_server(struct multi_context *multi);
+void management_check_bytecount_server(struct multi_context *multi, struct timeval *timeval);
 
 void man_persist_client_stats(struct management *man, struct context *c);
 
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index e907524..d512c98 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3809,13 +3809,6 @@
     {
         check_stale_routes(m);
     }
-
-#ifdef ENABLE_MANAGEMENT
-    if (management)
-    {
-        management_check_bytecount_server(m);
-    }
-#endif /* ENABLE_MANAGEMENT */
 }
 
 static void
@@ -4166,6 +4159,29 @@
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
 }
 
+/**
+ * @brief Determines the earliest wakeup interval based on periodic operations.
+ *
+ * Updates the \c timeval to reflect the next scheduled wakeup time.
+ * Also sets \c multi->earliest_wakeup to the instance with the earliest wakeup.
+ *
+ * @param multi     Pointer to the multi context
+ * @param timeval   Pointer to the timeval structure to be updated with the
+ *                  next wakeup time
+ */
+static void
+multi_get_timeout(struct multi_context *multi, struct timeval *timeval)
+{
+    multi_get_timeout_instance(multi, timeval);
+
+#ifdef ENABLE_MANAGEMENT
+    if (management)
+    {
+        management_check_bytecount_server(multi, timeval);
+    }
+#endif /* ENABLE_MANAGEMENT */
+}
+
 /**************************************************************************/
 /**
  * Main event loop for OpenVPN in point-to-multipoint server mode.
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 97bbc4a..960e0be 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -582,15 +582,16 @@
 }
 
 /*
- * Compute earliest timeout expiry from the set of
- * all instances.  Output:
+ * Updates \c dest with the earliest timeout as a delta relative to the current
+ * time and sets \c m->earliest_wakeup to the \c multi_instance with the
+ * soonest scheduled wakeup.
  *
- * m->earliest_wakeup : instance needing the earliest service.
- * dest               : earliest timeout as a delta in relation
- *                      to current time.
+ * @param m     Pointer to the multi context
+ * @param dest  Pointer to a timeval struct that will hold the earliest timeout
+ *              delta.
  */
 static inline void
-multi_get_timeout(struct multi_context *m, struct timeval *dest)
+multi_get_timeout_instance(struct multi_context *m, struct timeval *dest)
 {
     struct timeval tv, current;
 

