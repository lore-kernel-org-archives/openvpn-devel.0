From: David Sommerseth <dazo@...384...>
Date: Thu, 26 Aug 2010 23:43:59 +0200
Message-Id: <1282859040-25837-3-git-send-email-dazo@...384...>
In-Reply-To: <1282859040-25837-1-git-send-email-dazo@...384...>
References: <1282859040-25837-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 2/3] Implement the core v3 plug-in function
	calls.
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

Let OpenVPN call the openvpn_plugin_open_v3() and
openvpn_plugin_func_v3() plug-in functions if they exist in the plug-in.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 plugin.c |   17 +++++++++++++++--
 1 files changed, 15 insertions(+), 2 deletions(-)

diff --git a/plugin.c b/plugin.c
index dcc18fb..7d02c8b 100644
--- a/plugin.c
+++ b/plugin.c
@@ -298,7 +298,13 @@ plugin_open_item (struct plugin *p,
       /*
        * Call the plugin initialization
        */
-      if (p->open2)
+      if (p->open3) {
+        struct openvpn_plugin_args_open args = { .version   = OPENVPN_PLUGIN_ARGS_APIVER,
+                                                 .type_mask = &p->plugin_type_mask,
+                                                 .argv      = o->argv,
+                                                 .envp      = envp };
+        p->plugin_handle = (*p->open3)(&args, retlist);
+      } else if (p->open2)
 	p->plugin_handle = (*p->open2)(&p->plugin_type_mask, o->argv, envp, retlist);
       else if (p->open1)
 	p->plugin_handle = (*p->open1)(&p->plugin_type_mask, o->argv, envp);
@@ -350,7 +356,14 @@ plugin_call_item (const struct plugin *p,
       /*
        * Call the plugin work function
        */
-      if (p->func2)
+      if (p->func3) {
+        struct openvpn_plugin_args_func args = { .version = OPENVPN_PLUGIN_ARGS_APIVER,
+                                                 .type    = type,
+                                                 .argv    = (const char **) a.argv,
+                                                 .envp    = envp,
+                                                 .per_client_context = per_client_context };
+        status = (*p->func3)(&args, p->plugin_handle, retlist);
+      } else if (p->func2)
 	status = (*p->func2)(p->plugin_handle, type, (const char **)a.argv, envp, per_client_context, retlist);
       else if (p->func1)
 	status = (*p->func1)(p->plugin_handle, type, (const char **)a.argv, envp);
-- 
1.7.2.2


