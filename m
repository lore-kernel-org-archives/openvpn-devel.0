From: Arne Schwabe <arne@...1227...>
Date: Mon, 12 Nov 2018 12:56:21 +0100
Message-Id: <20181112115627.5096-8-arne@...1227...>
In-Reply-To: <20181112115627.5096-1-arne@...1227...>
References: <20181112115627.5096-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3 07/13] client-connect: Add
 CC_RET_DEFERRED and cope with deferred client-connect
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

From: Fabian Knittel <fabian.knittel@...1547...>

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

Patch V3: Use a static struct in multi_instance instead of using
          malloc/free and use two states (deffered with and without
          result) instead of one to eliminate the counter that was
          only tested for > 0.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 158 +++++++++++++++++++++++++++++++++-----------
 src/openvpn/multi.h |  18 ++++-
 2 files changed, 136 insertions(+), 40 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3dbfb63f..263525a7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -2108,28 +2108,51 @@ multi_client_connect_source_ccd(struct multi_context *m,
     return ret;
 }
 
-static inline bool
-cc_check_return(int* cc_succeeded_count,
-                enum client_connect_return ret)
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
+static enum client_connect_return
+multi_client_connect_fail (struct multi_context *m, struct multi_instance *mi,
+                           unsigned int *option_types_found)
 {
-    if (ret == CC_RET_SUCCEEDED)
+    /* Called null call-back.  This should never happen. */
+    return CC_RET_FAILED;
+}
+
+static const struct client_connect_handlers client_connect_handlers[] = {
     {
-        (*cc_succeeded_count)++;
-        return true;
-    }
-    else if (ret == CC_RET_FAILED)
+        .main = multi_client_connect_source_ccd,
+        .deferred = multi_client_connect_fail
+    },
     {
-        return false;
-    }
-    else if (ret == CC_RET_SKIPPED)
+        .main = multi_client_connect_call_plugin_v1,
+        .deferred = multi_client_connect_fail
+    },
     {
-        return true;
-    }
-    else
+        .main = multi_client_connect_call_plugin_v2,
+        .deferred = multi_client_connect_fail
+    },
+    {
+        .main = multi_client_connect_call_script,
+        .deferred = multi_client_connect_fail
+    },
     {
-        ASSERT(0);
+        .main = multi_client_connect_mda,
+        .deferred = multi_client_connect_fail
+    },
+    {
+        .main = NULL,
+        .deferred = NULL
+        /* End of list sentinel.  */
     }
-}
+};
 
 /*
  * Called as soon as the SSL/TLS connection authenticates.
@@ -2146,32 +2169,86 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
     if (tls_authentication_status(mi->context.c2.tls_multi, 0)
         == TLS_AUTHENTICATION_SUCCEEDED)
     {
-        typedef enum client_connect_return
-            (*multi_client_connect_handler)
-            (struct multi_context *m, struct multi_instance *mi,
-             unsigned int *option_types_found);
+        bool from_deferred;
 
-        multi_client_connect_handler handlers[] = {
-            multi_client_connect_source_ccd,
-            multi_client_connect_call_plugin_v1,
-            multi_client_connect_call_plugin_v2,
-            multi_client_connect_call_script,
-            multi_client_connect_mda,
-            NULL
-        };
+        enum client_connect_return ret;
 
-        unsigned int option_types_found = 0;
+        struct client_connect_defer_state* defer_state =
+            &(mi->client_connect_defer_state);
 
-        int cc_succeeded = true; /* client connect script status */
-        int cc_succeeded_count = 0;
-        enum client_connect_return ret;
+        /* We are called for the first time */
+        if (mi->client_connect_status == CC_STATUS_NOT_ESTABLISHED)
+        {
+            defer_state->cur_handler_index = 0;
+            defer_state->option_types_found = 0;
+            /* Initially we have no handler that has returned a result */
+            mi->client_connect_status = CC_STATUS_DEFERRED_NO_RESULT;
+            from_deferred = false;
+        }
+        else
+        {
+            from_deferred = true;
+        }
 
         multi_client_connect_early_setup (m, mi);
 
-        for (int i = 0;cc_succeeded && handlers[i];i++)
+        bool cc_succeeded=true;
+
+        while (cc_succeeded &&
+               client_connect_handlers[defer_state->cur_handler_index]
+               .main != NULL)
         {
-            ret = handlers[i](m, mi, &option_types_found);
-            cc_succeeded = cc_check_return(&cc_succeeded_count, ret);
+            client_connect_handler handler;
+            if (from_deferred)
+            {
+                handler = client_connect_handlers
+                    [defer_state->cur_handler_index].deferred;
+                from_deferred = false;
+            }
+            else
+            {
+                handler = client_connect_handlers
+                    [defer_state->cur_handler_index].main;
+            }
+
+            ret = handler(m, mi, &(defer_state->option_types_found));
+            if (ret == CC_RET_SUCCEEDED)
+            {
+                /*
+                 * Remember that we already had at least one handler
+                 * returning a result should go to into defered state
+                 */
+                mi->client_connect_status = CC_STATUS_DEFERRED_RESULT;
+            }
+            else if (ret == CC_RET_SKIPPED)
+            {
+                /*
+                 * Move on with the next handler without modifying any
+                 * other state
+                 */
+            }
+            else if (ret == CC_RET_DEFERRED)
+            {
+                /*
+                 * we already set client_connect_status to DEFERRED_RESULT or
+                 * DEFERRED_NO_RESULT and increased index. We just return
+                 * from the function as having client_connect_status
+                  */
+                return;
+            }
+            else if (ret == CC_RET_FAILED)
+            {
+                 /*
+                  * One handler failed. We abort the chain and set the final
+                  * result to failed
+                  */
+                cc_succeeded = false;
+            }
+            else
+            {
+                ASSERT(0);
+            }
+            (defer_state->cur_handler_index)++;
         }
 
         /*
@@ -2183,21 +2260,24 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
             msg(D_MULTI_ERRORS, "MULTI: client has been rejected due to"
                 "'disable' directive");
             cc_succeeded = false;
-            cc_succeeded_count = 0;
         }
 
         if (cc_succeeded)
         {
-            multi_client_connect_late_setup (m, mi, option_types_found);
+            multi_client_connect_late_setup (m, mi,
+                                             mi->client_connect_defer_state.
+                                             option_types_found);
         }
         else
         {
+            bool at_least_one_cc_succeeded =
+                (mi->client_connect_status == CC_STATUS_DEFERRED_RESULT);
             /* set context-level authentication flag */
             mi->context.c2.context_auth =
-                cc_succeeded_count ? CAS_PARTIAL : CAS_FAILED;
+                at_least_one_cc_succeeded ? CAS_PARTIAL : CAS_FAILED;
         }
 
-        /* set flag so we don't get called again */
+        /* set flag so we do not get called again */
         mi->client_connect_status = CC_STATUS_ESTABLISHED;
 
         /* increment number of current authenticated clients */
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index c476a67e..ebfda357 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -63,9 +63,24 @@ struct deferred_signal_schedule_entry
     struct timeval wakeup;
 };
 
+/**
+ * Detached client connection state.  This is the state that is tracked while
+ * the client connect hooks are executed.
+ */
+struct client_connect_defer_state
+{
+    /* Index of currently executed handler.  */
+    int cur_handler_index;
+    /* Remember which option classes where processed for delayed option
+       handling. */
+    unsigned int option_types_found;
+};
+
 enum client_connect_status
 {
     CC_STATUS_NOT_ESTABLISHED,
+    CC_STATUS_DEFERRED_NO_RESULT,
+    CC_STATUS_DEFERRED_RESULT,
     CC_STATUS_ESTABLISHED
 };
 
@@ -117,7 +132,7 @@ struct multi_instance {
 
     struct context context;     /**< The context structure storing state
                                  *   for this VPN tunnel. */
-
+    struct client_connect_defer_state client_connect_defer_state;
 #ifdef ENABLE_ASYNC_PUSH
     int inotify_watch; /* watch descriptor for acf */
 #endif
@@ -204,6 +219,7 @@ enum client_connect_return
 {
   CC_RET_FAILED,
   CC_RET_SUCCEEDED,
+  CC_RET_DEFERRED,
   CC_RET_SKIPPED
 };
 
-- 
2.19.1


