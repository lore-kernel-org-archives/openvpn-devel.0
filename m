From: Arne Schwabe <arne@...1227...>
Date: Sun, 26 Jul 2020 01:48:02 +0200
Message-Id: <20200725234803.22058-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/2] Simplify calling logic of
 check_connection_established_dowork
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

The check event_timeout_defined in check_connection_established is
completely redundant as event_timeout_trigger will do the very same
check as first action. Removing this check makes the function
superfluous. To further improve the code  move the call check if the
time is expired into process_coarse_timers

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c | 77 +++++++++++++++++++------------------------
 src/openvpn/forward.h |  2 +-
 2 files changed, 34 insertions(+), 45 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 3d462d0a..30a3fd46 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -138,21 +138,6 @@ check_incoming_control_channel(struct context *c)
 #endif
 }
 
-/*
- * Options like --up-delay need to be triggered by this function which
- * checks for connection establishment.
- */
-static inline void
-check_connection_established(struct context *c)
-{
-    void check_connection_established_dowork(struct context *c);
-
-    if (event_timeout_defined(&c->c2.wait_for_connect))
-    {
-        check_connection_established_dowork(c);
-    }
-}
-
 /*
  * Should we add routes?
  */
@@ -437,43 +422,45 @@ check_push_request_dowork(struct context *c)
 
 /*
  * Things that need to happen immediately after connection initiation should go here.
+ *
+ * Options like --up-delay need to be triggered by this function which
+ * checks for connection establishment.
  */
 void
-check_connection_established_dowork(struct context *c)
+check_connection_established(struct context *c)
 {
-    if (event_timeout_trigger(&c->c2.wait_for_connect, &c->c2.timeval, ETT_DEFAULT))
+
+    if (CONNECTION_ESTABLISHED(c))
     {
-        if (CONNECTION_ESTABLISHED(c))
-        {
 #if P2MP
-            /* if --pull was specified, send a push request to server */
-            if (c->c2.tls_multi && c->options.pull)
-            {
+        /* if --pull was specified, send a push request to server */
+        if (c->c2.tls_multi && c->options.pull)
+        {
 #ifdef ENABLE_MANAGEMENT
-                if (management)
-                {
-                    management_set_state(management,
-                                         OPENVPN_STATE_GET_CONFIG,
-                                         NULL,
-                                         NULL,
-                                         NULL,
-                                         NULL,
-                                         NULL);
-                }
-#endif
-                /* fire up push request right away (already 1s delayed) */
-                event_timeout_init(&c->c2.push_request_interval, 0, now);
-                reset_coarse_timers(c);
-            }
-            else
-#endif /* if P2MP */
+            if (management)
             {
-                do_up(c, false, 0);
+                management_set_state(management,
+                                     OPENVPN_STATE_GET_CONFIG,
+                                     NULL,
+                                     NULL,
+                                     NULL,
+                                     NULL,
+                                     NULL);
             }
-
-            event_timeout_clear(&c->c2.wait_for_connect);
+#endif
+            /* fire up push request right away (already 1s delayed) */
+            event_timeout_init(&c->c2.push_request_interval, 0, now);
+            reset_coarse_timers(c);
         }
+        else
+#endif /* if P2MP */
+        {
+            do_up(c, false, 0);
+        }
+
+        event_timeout_clear(&c->c2.wait_for_connect);
     }
+
 }
 
 bool
@@ -777,8 +764,10 @@ process_coarse_timers(struct context *c)
     check_status_file(c);
 
     /* process connection establishment items */
-    check_connection_established(c);
-
+    if (event_timeout_trigger(&c->c2.wait_for_connect, &c->c2.timeval, ETT_DEFAULT))
+    {
+        check_connection_established(c);
+    }
 #if P2MP
     /* see if we should send a push_request in response to --pull */
     check_push_request(c);
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index ff898133..635e84ae 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -88,7 +88,7 @@ void check_fragment_dowork(struct context *c);
 
 #endif /* ENABLE_FRAGMENT */
 
-void check_connection_established_dowork(struct context *c);
+void check_connection_established(struct context *c);
 
 void check_add_routes_dowork(struct context *c);
 
-- 
2.26.2


