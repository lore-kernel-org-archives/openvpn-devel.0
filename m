From: David Sommerseth <dazo@...384...>
Date: Fri, 10 Dec 2010 01:30:51 +0100
Message-Id: <1291941053-748-3-git-send-email-dazo@...384...>
In-Reply-To: <1291941053-748-1-git-send-email-dazo@...384...>
References: <1291941053-748-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH v2 2/4] Implement the core v3 plug-in
	function calls.
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
Cc: David Sommerseth <dazo@...384...>

Let OpenVPN call the openvpn_plugin_open_v3() and
openvpn_plugin_func_v3() plug-in functions if they exist in the plug-in.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 plugin.c |   29 +++++++++++++++++++++++++++--
 1 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/plugin.c b/plugin.c
index 92f7908..ca52087 100644
--- a/plugin.c
+++ b/plugin.c
@@ -298,7 +298,21 @@ plugin_open_item (struct plugin *p,
       /*
        * Call the plugin initialization
        */
-      if (p->open2)
+      if (p->open3) {
+        struct openvpn_plugin_args_open_in args = { .type_mask = p->plugin_type_mask,
+                                                    .argv      = o->argv,
+                                                    .envp      = envp };
+        struct openvpn_plugin_args_open_return retargs;
+
+        CLEAR(retargs);
+        if ((*p->open3)(OPENVPN_PLUGIN_VERSION, &args, &retargs) == OPENVPN_PLUGIN_FUNC_SUCCESS) {
+          p->plugin_type_mask = retargs.type_mask;
+          p->plugin_handle = retargs.handle;
+          retlist = retargs.return_list;
+        } else {
+          p->plugin_handle = NULL;
+        }
+      } else if (p->open2)
 	p->plugin_handle = (*p->open2)(&p->plugin_type_mask, o->argv, envp, retlist);
       else if (p->open1)
 	p->plugin_handle = (*p->open1)(&p->plugin_type_mask, o->argv, envp);
@@ -350,7 +364,18 @@ plugin_call_item (const struct plugin *p,
       /*
        * Call the plugin work function
        */
-      if (p->func2)
+      if (p->func3) {
+        struct openvpn_plugin_args_func_in args = { .type    = type,
+                                                    .argv    = (const char **) a.argv,
+                                                    .envp    = envp,
+                                                    .handle  = p->plugin_handle,
+                                                    .per_client_context = per_client_context };
+        struct openvpn_plugin_args_func_return retargs;
+
+        CLEAR(retargs);
+        status = (*p->func3)(OPENVPN_PLUGIN_VERSION, &args, &retargs);
+        retlist = retargs.return_list;
+      } else if (p->func2)
 	status = (*p->func2)(p->plugin_handle, type, (const char **)a.argv, envp, per_client_context, retlist);
       else if (p->func1)
 	status = (*p->func1)(p->plugin_handle, type, (const char **)a.argv, envp);
-- 
1.7.2.3


