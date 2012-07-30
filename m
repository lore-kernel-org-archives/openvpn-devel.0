From: Heiko Hund <heiko.hund@...1489...>
Date: Mon, 30 Jul 2012 18:35:21 +0200
Message-ID: <1343666121-19765-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [RFC] give plugins a method to pass log lines to
	openvpn
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

Some plugins want to add messages to the openvpn log file.

V3 plugins can indirectly write to the log by specifying one or
more openvpn_plugin_log_list structs and returning them in the
provided openvpn_plugin_args_{open,func}_return struct.

The openvpn plugin backend will log the provided information
upon reception.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 include/openvpn-plugin.h |   39 ++++++++++++++++++++++++++++++++++++++-
 src/openvpn/plugin.c     |   37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 75 insertions(+), 1 deletion(-)

diff --git a/include/openvpn-plugin.h b/include/openvpn-plugin.h
index 1c80eec..08db7b2 100644
--- a/include/openvpn-plugin.h
+++ b/include/openvpn-plugin.h
@@ -201,8 +201,39 @@ struct openvpn_plugin_string_list
  *    1      Initial plugin v3 structures providing the same API as
  *           the v2 plugin interface + X509 certificate information.
  *
+ *    2      Add log_list to openvpn_plugin_args_{open,func}_return
+ *           structs. The log_list struct is evaluated by openvpn and
+ *           enables plugins to add information to the openvpn log
+ *           output.
+ *
+ */
+#define OPENVPN_PLUGINv3_STRUCTVER 2
+
+
+typedef enum
+{
+  PLOG_ERR       = (1 << 0),  /* Error condition message */
+  PLOG_WARN      = (1 << 1),  /* General warning message */
+  PLOG_NOTE      = (1 << 2),  /* Informational message */
+  PLOG_DEBUG     = (1 << 3),  /* Debug message, displayed if verb >= 7 */
+
+  PLOG_NOMUTE    = (1 << 8),  /* Mute setting does not apply for message */
+  PLOG_NOIPREFIX = (1 << 9)   /* No instance prefix for this message */
+
+} openvpn_plugin_log_flags_t;
+
+/**
+ * Struct to transport log lines from the plugin to openvpn.
+ * The plugin should allocate all structure instances and msg strings
+ * with malloc, since OpenVPN will free them after logging took place.
  */
-#define OPENVPN_PLUGINv3_STRUCTVER 1
+struct openvpn_plugin_log_list
+{
+  struct openvpn_plugin_log_list *next;
+  const openvpn_plugin_log_flags_t flags;
+  const char *msg;
+};
+
 
 /**
  * Arguments used to transport variables to the plug-in.
@@ -250,12 +281,15 @@ struct openvpn_plugin_args_open_in
  *
  * return_list : used to return data back to OpenVPN.
  *
+ * log_list : used to return log lines back to OpenVPN.
+ *
  */
 struct openvpn_plugin_args_open_return
 {
   int  type_mask;
   openvpn_plugin_handle_t *handle;
   struct openvpn_plugin_string_list **return_list;
+  struct openvpn_plugin_log_list *log_list;
 };
 
 /**
@@ -313,10 +347,13 @@ struct openvpn_plugin_args_func_in
  * return_list : used to return data back to OpenVPN for further processing/usage by
  *               the OpenVPN executable.
  *
+ * log_list : used to return log lines back to OpenVPN.
+ *
  */
 struct openvpn_plugin_args_func_return
 {
   struct openvpn_plugin_string_list **return_list;
+  struct openvpn_plugin_log_list *log_list;
 };
 
 /*
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 7ce2f5e..f4833df 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -286,6 +286,41 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
   gc_free (&gc);
 }
 
+
+static void
+plugin_do_log_list (struct openvpn_plugin_log_list *log_list)
+{
+  while (log_list)
+    {
+      struct openvpn_plugin_log_list *this = log_list;
+      if (log_list->msg)
+        {
+          unsigned int flags;
+
+          if (log_list->flags & PLOG_ERR)
+            flags = M_INFO | M_NONFATAL;
+          else if (log_list->flags & PLOG_WARN)
+            flags = M_INFO | M_WARN;
+          else if (log_list->flags & PLOG_NOTE)
+            flags = M_INFO;
+          else if (log_list->flags & PLOG_DEBUG)
+            flags = D_PLUGIN_DEBUG | M_DEBUG;
+
+          if (log_list->flags & PLOG_NOMUTE)
+            flags |= M_NOMUTE;
+          if (log_list->flags & PLOG_NOIPREFIX)
+            flags |= M_NOIPREFIX;
+
+          msg (flags, log_list->msg);
+          free (log_list->msg);
+        }
+
+      log_list = log_list->next;
+      free (this);
+    }
+}
+
+
 static void
 plugin_open_item (struct plugin *p,
 		  const struct plugin_option *o,
@@ -317,6 +352,7 @@ plugin_open_item (struct plugin *p,
 
         CLEAR(retargs);
         if ((*p->open3)(OPENVPN_PLUGINv3_STRUCTVER, &args, &retargs) == OPENVPN_PLUGIN_FUNC_SUCCESS) {
+          plugin_do_log_list(retargs.log_list);
           p->plugin_type_mask = retargs.type_mask;
           p->plugin_handle = retargs.handle;
           retlist = retargs.return_list;
@@ -399,6 +435,7 @@ plugin_call_item (const struct plugin *p,
 
         CLEAR(retargs);
         status = (*p->func3)(OPENVPN_PLUGINv3_STRUCTVER, &args, &retargs);
+        plugin_do_log_list(retargs.log_list);
         retlist = retargs.return_list;
       } else if (p->func2)
 	status = (*p->func2)(p->plugin_handle, type, (const char **)a.argv, envp, per_client_context, retlist);
-- 
1.7.10.4


