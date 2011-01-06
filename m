From: David Sommerseth <dazo@...384...>
Date: Thu,  6 Jan 2011 23:46:57 +0100
Message-Id: <1294354017-18716-1-git-send-email-dazo@...384...>
In-Reply-To: <1291941053-748-1-git-send-email-dazo@...384...>
References: <1291941053-748-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH v2 5/4] Separate the general plug-in version
	constant and v3 plug-in structs version
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
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>

After a review of the second round of the the v3 plug-in implementation, it
was decided to use a separate constant defining the version of the structs
used for argument and return value passing, instead of OPENVPN_PLUGIN_VERSION.

To not make it too complex, this patch uses a shared version constant for all
the v3 structures.  It is not expected that these strucutures will change too
much and too often.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 openvpn-plugin.h         |   14 ++++++++++++++
 plugin.c                 |    4 ++--
 plugin/examples/log_v3.c |    4 ++--
 3 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/openvpn-plugin.h b/openvpn-plugin.h
index d08d249..7f7ee96 100644
--- a/openvpn-plugin.h
+++ b/openvpn-plugin.h
@@ -168,6 +168,20 @@ struct openvpn_plugin_string_list
 
 /* openvpn_plugin_{open,func}_v3() related structs */
 
+/* Defines version of the v3 plugin argument structs
+ *
+ * Whenever one or more of these structs are modified, this constant
+ * must be updated.  A changelog should be appended in this comment
+ * as well, to make it easier to see what information is available
+ * in the different versions.
+ *
+ * Version   Comment
+ *    1      Initial plugin v3 structures providing the same API as
+ *           the v2 plugin interface + X509 certificate information.
+ *
+ */
+#define OPENVPN_PLUGINv3_STRUCTVER 1
+
 /**
  * Arguments used to transport variables to the plug-in.
  * The struct openvpn_plugin_args_open_in is only used
diff --git a/plugin.c b/plugin.c
index c7a69eb..aba5b79 100644
--- a/plugin.c
+++ b/plugin.c
@@ -305,7 +305,7 @@ plugin_open_item (struct plugin *p,
         struct openvpn_plugin_args_open_return retargs;
 
         CLEAR(retargs);
-        if ((*p->open3)(OPENVPN_PLUGIN_VERSION, &args, &retargs) == OPENVPN_PLUGIN_FUNC_SUCCESS) {
+        if ((*p->open3)(OPENVPN_PLUGINv3_STRUCTVER, &args, &retargs) == OPENVPN_PLUGIN_FUNC_SUCCESS) {
           p->plugin_type_mask = retargs.type_mask;
           p->plugin_handle = retargs.handle;
           retlist = retargs.return_list;
@@ -377,7 +377,7 @@ plugin_call_item (const struct plugin *p,
         struct openvpn_plugin_args_func_return retargs;
 
         CLEAR(retargs);
-        status = (*p->func3)(OPENVPN_PLUGIN_VERSION, &args, &retargs);
+        status = (*p->func3)(OPENVPN_PLUGINv3_STRUCTVER, &args, &retargs);
         retlist = retargs.return_list;
       } else if (p->func2)
 	status = (*p->func2)(p->plugin_handle, type, (const char **)a.argv, envp, per_client_context, retlist);
diff --git a/plugin/examples/log_v3.c b/plugin/examples/log_v3.c
index 4974ef2..bf2f1dc 100644
--- a/plugin/examples/log_v3.c
+++ b/plugin/examples/log_v3.c
@@ -72,14 +72,14 @@ get_env (const char *name, const char *envp[])
 }
 
 OPENVPN_EXPORT int
-openvpn_plugin_open_v3 (const int apiver,
+openvpn_plugin_open_v3 (const int v3structver,
                         struct openvpn_plugin_args_open_in const *args,
                         struct openvpn_plugin_args_open_return *ret)
 {
   struct plugin_context *context = NULL;
 
   /* Check that we are API compatible */
-  if( apiver != OPENVPN_PLUGIN_VERSION ) {
+  if( v3structver != OPENVPN_PLUGINv3_STRUCTVER ) {
     return OPENVPN_PLUGIN_FUNC_ERROR;
   }
 
-- 
1.7.2.3


