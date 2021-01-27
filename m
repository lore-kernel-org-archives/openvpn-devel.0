From: Greg Cox <gcox@...1057...>
Date: Wed, 27 Jan 2021 20:21:48 +0000
Message-Id: <1611778909-20630-1-git-send-email-gcox@...1057...>
Subject: [Openvpn-devel] [PATCH 1/2] Update openvpn_plugin_func_v2 to _v3 in
 sample-plugins/defer/simple.c
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

This isn't strictly required, but it modernizes the functions used.
This change makes _open the same parameter form as _func (for better
parallelism in function writing) and includes a check for the correct
struct version, as recommended by openvpn-plugin.h
---
 sample/sample-plugins/defer/simple.c | 23 ++++++++++++++---------
 1 file changed, 14 insertions(+), 9 deletions(-)

diff --git a/sample/sample-plugins/defer/simple.c b/sample/sample-plugins/defer/simple.c
index 22bc22765d6773d3ea2344a328faf5008b0c5d89..a2e47cfc3953ae188a5a2588a3d21e12404c75f1 100644
--- a/sample/sample-plugins/defer/simple.c
+++ b/sample/sample-plugins/defer/simple.c
@@ -423,16 +423,21 @@ tls_final(struct plugin_context *context, struct plugin_per_client_context *pcc,
 }
 
 OPENVPN_EXPORT int
-openvpn_plugin_func_v2(openvpn_plugin_handle_t handle,
-                       const int type,
-                       const char *argv[],
-                       const char *envp[],
-                       void *per_client_context,
-                       struct openvpn_plugin_string_list **return_list)
+openvpn_plugin_func_v3(const int v3structver,
+                       struct openvpn_plugin_args_func_in const *args,
+                       struct openvpn_plugin_args_func_return *ret)
 {
-    struct plugin_context *context = (struct plugin_context *) handle;
-    struct plugin_per_client_context *pcc = (struct plugin_per_client_context *) per_client_context;
-    switch (type)
+    /* Check API compatibility -- struct version 5 or higher needed */
+    if (v3structver < 5)
+    {
+        fprintf(stderr, "%s: this plugin is incompatible with the running version of OpenVPN\n", MODULE);
+        return OPENVPN_PLUGIN_FUNC_ERROR;
+    }
+    const char **argv = args->argv;
+    const char **envp = args->envp;
+    struct plugin_context *context = (struct plugin_context *) args->handle;
+    struct plugin_per_client_context *pcc = (struct plugin_per_client_context *) args->per_client_context;
+    switch (args->type)
     {
         case OPENVPN_PLUGIN_UP:
             plugin_log(PLOG_NOTE, MODULE, "OPENVPN_PLUGIN_UP");
-- 
2.7.6


