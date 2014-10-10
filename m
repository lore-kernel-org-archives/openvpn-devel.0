Sender: Fabian Knittel <fabian@...1547...>
From: Fabian Knittel <fabian.knittel@...1547...>
Date: Sat, 11 Oct 2014 00:09:24 +0200
Message-Id: <1412978966-15392-8-git-send-email-fabian.knittel@...1547...>
In-Reply-To: <1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
References: <5437B156.1020408@...1114...>
	<1412978966-15392-1-git-send-email-fabian.knittel@...1547...>
Subject: [Openvpn-devel] [PATCH 7/9] client-connect: Add CC_RET_DEFERRED and
	cope with deferred client-connect
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

This patch moves the state, that was previously tracked within the
multi_connection_established() function, into struct client_connect_state.  The
multi_connection_established() function can now be exited and re-entered as
many times as necessary - without losing the client-connect handling state.

The patch also adds the new return value CC_RET_DEFERRED which indicates that
the handler couldn't complete immediately, and needs to be called later.  At
that point multi_connection_established() will exit without indicating
completion.

Each client-connect handler now has an (optional) additional call-back:  The
call-back for handling the deferred case.  If the main call-back returns
CC_RET_DEFERRED, the next call to the handler will be through the deferred
call-back.

Signed-off-by: Fabian Knittel <fabian.knittel@...1547...>
---
 src/openvpn/multi.c | 255 ++++++++++++++++++++++++++++++++++------------------
 src/openvpn/multi.h |  18 ++++
 2 files changed, 185 insertions(+), 88 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 7815146..c044d67 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -47,6 +47,9 @@
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
+static void delete_client_connect_state (struct multi_instance *mi);
+
+
 #ifdef MULTI_DEBUG_EVENT_LOOP
 static const char *
 id (struct multi_instance *mi)
@@ -573,6 +576,8 @@ multi_close_instance (struct multi_context *m,
   set_cc_config (mi, NULL);
 #endif
 
+  delete_client_connect_state (mi);
+
   multi_client_disconnect_script (m, mi);
 
   if (mi->did_open_context)
@@ -1583,94 +1588,6 @@ multi_client_connect_setenv (struct multi_context *m,
 
 static void
 multi_client_connect_early_setup (struct multi_context *m,
-				  struct multi_instance *mi);
-static void
-multi_client_connect_source_ccd (struct multi_context *m,
-				 struct multi_instance *mi,
-				 unsigned int *option_types_found);
-static void
-multi_client_connect_call_plugin_v1 (struct multi_context *m,
-				     struct multi_instance *mi,
-				     unsigned int *option_types_found,
-				     int *cc_succeeded,
-				     int *cc_succeeded_count);
-static void
-multi_client_connect_call_plugin_v2 (struct multi_context *m,
-				     struct multi_instance *mi,
-				     unsigned int *option_types_found,
-				     int *cc_succeeded,
-				     int *cc_succeeded_count);
-static void
-multi_client_connect_call_script (struct multi_context *m,
-				  struct multi_instance *mi,
-				  unsigned int *option_types_found,
-				  int *cc_succeeded,
-				  int *cc_succeeded_count);
-static void
-multi_client_connect_late_setup (struct multi_context *m,
-				 struct multi_instance *mi,
-				 const unsigned int option_types_found,
-				 int cc_succeeded,
-				 const int cc_succeeded_count);
-
-/*
- * Called as soon as the SSL/TLS connection authenticates.
- *
- * Instance-specific directives to be processed:
- *
- *   iroute start-ip end-ip
- *   ifconfig-push local remote-netmask
- *   push
- */
-static void
-multi_connection_established (struct multi_context *m, struct multi_instance *mi)
-{
-  if (tls_authentication_status (mi->context.c2.tls_multi, 0) == TLS_AUTHENTICATION_SUCCEEDED)
-    {
-      typedef enum client_connect_return_t (*multi_client_connect_handler)(struct multi_context *m, struct multi_instance *mi, unsigned int *option_types_found);
-
-      multi_client_connect_handler handlers[] = {
-	  multi_client_connect_source_ccd,
-	  multi_client_connect_call_plugin_v1,
-	  multi_client_connect_call_plugin_v2,
-	  multi_client_connect_call_script,
-	  multi_client_connect_mda,
-	  NULL
-      };
-
-      int cur_handler = 0;
-      unsigned int option_types_found = 0;
-      int cc_succeeded = true; /* client connect script status */
-      int cc_succeeded_count = 0;
-      enum client_connect_return ret;
-
-      multi_client_connect_early_setup (m, mi);
-
-      while (succeeded && handlers[cur_handler])
-	{
-	  ret = handlers[cur_handler] (m, mi, &option_types_found);
-	  if (ret == CC_RET_SUCCEEDED)
-	    ++cc_succeeded_count;
-	  else if (ret == CC_RET_FAILED)
-	    succeeded = false;
-	  ++cur_handler;
-	}
-
-      multi_client_connect_late_setup (m, mi, option_types_found, cc_succeeded,
-				       cc_succeeded_count);
-
-      /* set flag so we don't get called again */
-      mi->connection_established_flag = true;
-    }
-
-  /*
-   * Reply now to client's PUSH_REQUEST query
-   */
-  mi->context.c2.push_reply_deferred = false;
-}
-
-static void
-multi_client_connect_early_setup (struct multi_context *m,
 				  struct multi_instance *mi)
 {
   /* lock down the common name and cert hashes so they can't change during
@@ -2005,6 +1922,168 @@ multi_client_connect_late_setup (struct multi_context *m,
   gc_free (&gc);
 }
 
+static enum client_connect_return
+multi_client_connect_fail (struct multi_context *m, struct multi_instance *mi,
+			   unsigned int *option_types_found)
+{
+  /* Called null call-back.  This should never happen.  Fail loudly. */
+  return CC_RET_FAILED;
+}
+
+static void
+new_client_connect_state (struct multi_instance *mi)
+{
+  ASSERT (mi);
+  ALLOC_OBJ_CLEAR (mi->client_connect_state, struct client_connect_state);
+
+  mi->client_connect_state->succeeded = true;
+}
+
+static void
+delete_client_connect_state (struct multi_instance *mi)
+{
+  ASSERT (mi);
+  if (mi->client_connect_state)
+    {
+      free (mi->client_connect_state);
+      mi->client_connect_state = NULL;
+    }
+}
+
+typedef enum client_connect_return (*client_connect_handler)
+  (struct multi_context *m, struct multi_instance *mi,
+   unsigned int *option_types_found);
+
+struct client_connect_handlers
+{
+  client_connect_handler main;
+  client_connect_handler deferred;
+};
+
+static const struct client_connect_handlers client_connect_handlers[] = {
+  {
+    main: multi_client_connect_source_ccd,
+    deferred: multi_client_connect_fail
+  },
+  {
+    main: multi_client_connect_call_plugin_v1,
+    deferred: multi_client_connect_fail
+  },
+  {
+    main: multi_client_connect_call_plugin_v2,
+    deferred: multi_client_connect_fail
+  },
+  {
+    main: multi_client_connect_call_script,
+    deferred: multi_client_connect_fail
+  },
+  {
+    main: multi_client_connect_mda,
+    deferred: multi_client_connect_fail
+  },
+  {
+    /* End of list.  */
+  }
+};
+
+static enum client_connect_return
+multi_client_handle_single (client_connect_handler handler,
+			    struct multi_context *m,
+			    struct multi_instance *mi)
+{
+  struct client_connect_state *ccs = mi->client_connect_state;
+  enum client_connect_return ret;
+
+  ret = handler (m, mi, &ccs->option_types_found);
+  if (ret == CC_RET_SUCCEEDED)
+    ++ccs->succeeded_count;
+  else if (ret == CC_RET_FAILED)
+    ccs->succeeded = false;
+  else if (ret == CC_RET_DEFERRED)
+    {
+      /* Signal that we're deferring.  */
+      return ret;
+    }
+  return ret;
+}
+
+/*
+ * Called as soon as the SSL/TLS connection authenticates.
+ *
+ * Instance-specific directives to be processed:
+ *
+ *   iroute start-ip end-ip
+ *   ifconfig-push local remote-netmask
+ *   push
+ */
+static void
+multi_connection_established (struct multi_context *m, struct multi_instance *mi)
+{
+  if (tls_authentication_status (mi->context.c2.tls_multi, 0) == TLS_AUTHENTICATION_SUCCEEDED)
+    {
+      struct client_connect_state *ccs = mi->client_connect_state;
+      enum client_connect_return ret;
+
+      if (!ccs)
+	{
+	  /* This is the first time that we run client-connect handlers
+	     for this connection. */
+
+	  new_client_connect_state (mi);
+	  ccs = mi->client_connect_state;
+
+          multi_client_connect_early_setup (m, mi);
+	}
+      else
+	{
+	  /* We are returning from a deferred handler.  Check whether the
+	     handler has been completed yet.  */
+
+	  ASSERT (client_connect_handlers[ccs->cur_handler_idx].main);
+	  ASSERT (client_connect_handlers[ccs->cur_handler_idx].deferred);
+
+	  ret = multi_client_handle_single
+		  (client_connect_handlers[ccs->cur_handler_idx].deferred, m,
+		   mi);
+	  if (ret == CC_RET_DEFERRED)
+	    return;
+
+	  /* Proceed to next handler.  */
+	  ++ccs->cur_handler_idx;
+	}
+
+
+      /* Cycle through all (remaining) client-connect handlers until all
+	 have completed, one of them fails or one of them defers.  */
+      while (ccs->succeeded &&
+	     client_connect_handlers[ccs->cur_handler_idx].main)
+	{
+	  ret = multi_client_handle_single
+		  (client_connect_handlers[ccs->cur_handler_idx].main, m, mi);
+	  if (ret == CC_RET_DEFERRED)
+	    return;
+
+	  /* Proceed to next handler.  */
+	  ++ccs->cur_handler_idx;
+	}
+
+      /* Done with all client-connect handlers now.  */
+
+      multi_client_connect_late_setup (m, mi, ccs->option_types_found,
+				       ccs->succeeded, ccs->succeeded_count);
+
+      /* Clean-up.  */
+      delete_client_connect_state (mi);
+
+      /* set flag so we don't get called again */
+      mi->connection_established_flag = true;
+    }
+
+  /*
+   * Reply now to client's PUSH_REQUEST query
+   */
+  mi->context.c2.push_reply_deferred = false;
+}
 
 /*
  * Add a mbuf buffer to a particular
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 0adcd47..16dd99d 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -54,6 +54,22 @@ struct multi_reap
   time_t last_call;
 };
 
+/**
+ * Detached client connection state.  This is the state that is tracked while
+ * the client connect hooks are executed.
+ */
+struct client_connect_state
+{
+  /* Index of currently executed handler.  */
+  int cur_handler_idx;
+  /* Did all of the handlers succeed up to now?  */
+  bool succeeded;
+  /* How many handlers succeeded?  */
+  int succeeded_count;
+  /* Remember which option classes where processed for delayed option
+     handling. */
+  unsigned int option_types_found;
+};
 
 /**
  * Server-mode state structure for one single VPN tunnel.
@@ -103,6 +119,7 @@ struct multi_instance {
 
   struct context context;       /**< The context structure storing state
                                  *   for this VPN tunnel. */
+  struct client_connect_state *client_connect_state;
 };
 
 /**
@@ -175,6 +192,7 @@ enum client_connect_return
 {
   CC_RET_FAILED,
   CC_RET_SUCCEEDED,
+  CC_RET_DEFERRED,
   CC_RET_SKIPPED
 };
 
-- 
2.1.1


