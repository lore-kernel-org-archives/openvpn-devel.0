From: David Sommerseth <dazo@...384...>
Date: Fri, 10 Dec 2010 01:30:52 +0100
Message-Id: <1291941053-748-4-git-send-email-dazo@...384...>
In-Reply-To: <1291941053-748-1-git-send-email-dazo@...384...>
References: <1291941053-748-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH v2 3/4] Extend the v3 plug-in API to send
	over X509 certificates
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

The certificates sent to the plug-in API will only happen during the
OPENVPN_PLUGIN_TLS_VERIFY phase and will contain a pointer to the OpenSSL
X509 certificate data.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 init.c           |    2 +-
 misc.c           |    2 +-
 multi.c          |    8 ++++----
 openvpn-plugin.h |    7 +++++++
 pf.c             |    2 +-
 plugin.c         |   15 +++++++++++----
 plugin.h         |    4 +++-
 socket.c         |    2 +-
 ssl.c            |    6 +++---
 9 files changed, 32 insertions(+), 16 deletions(-)

diff --git a/init.c b/init.c
index 2049daf..f041bc6 100644
--- a/init.c
+++ b/init.c
@@ -1182,7 +1182,7 @@ do_route (const struct options *options,
 
   if (plugin_defined (plugins, OPENVPN_PLUGIN_ROUTE_UP))
     {
-      if (plugin_call (plugins, OPENVPN_PLUGIN_ROUTE_UP, NULL, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plugin_call (plugins, OPENVPN_PLUGIN_ROUTE_UP, NULL, NULL, es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	msg (M_WARN, "WARNING: route-up plugin call failed");
     }
 
diff --git a/misc.c b/misc.c
index d3e67ef..7d80c69 100644
--- a/misc.c
+++ b/misc.c
@@ -211,7 +211,7 @@ run_up_down (const char *command,
 		   ifconfig_local, ifconfig_remote,
 		   context);
 
-      if (plugin_call (plugins, plugin_type, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plugin_call (plugins, plugin_type, &argv, NULL, es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	msg (M_FATAL, "ERROR: up/down plugin call failed");
 
       argv_reset (&argv);
diff --git a/multi.c b/multi.c
index dc26a02..138aaea 100644
--- a/multi.c
+++ b/multi.c
@@ -91,7 +91,7 @@ learn_address_script (const struct multi_context *m,
 		   mroute_addr_print (addr, &gc));
       if (mi)
 	argv_printf_cat (&argv, "%s", tls_common_name (mi->context.c2.tls_multi, false));
-      if (plugin_call (plugins, OPENVPN_PLUGIN_LEARN_ADDRESS, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plugin_call (plugins, OPENVPN_PLUGIN_LEARN_ADDRESS, &argv, NULL, es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	{
 	  msg (M_WARN, "WARNING: learn-address plugin call failed");
 	  ret = false;
@@ -471,7 +471,7 @@ multi_client_disconnect_script (struct multi_context *m,
 
       if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT))
 	{
-	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT, NULL, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT, NULL, NULL, mi->context.c2.es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	    msg (M_WARN, "WARNING: client-disconnect plugin call failed");
 	}
 
@@ -1538,7 +1538,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
           }
 
 	  argv_printf (&argv, "%s", dc_file);
-	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	    {
 	      msg (M_WARN, "WARNING: client-connect plugin call failed");
 	      cc_succeeded = false;
@@ -1559,7 +1559,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
 	  plugin_return_init (&pr);
 
-	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2, NULL, &pr, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2, NULL, &pr, mi->context.c2.es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	    {
 	      msg (M_WARN, "WARNING: client-connect-v2 plugin call failed");
 	      cc_succeeded = false;
diff --git a/openvpn-plugin.h b/openvpn-plugin.h
index 43c1d3a..d08d249 100644
--- a/openvpn-plugin.h
+++ b/openvpn-plugin.h
@@ -22,6 +22,8 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
+#include <openssl/x509v3.h>
+
 #define OPENVPN_PLUGIN_VERSION 3
 
 /*
@@ -243,6 +245,9 @@ struct openvpn_plugin_args_open_return
  * per_client_context : the per-client context pointer which was returned by
  *        openvpn_plugin_client_constructor_v1, if defined.
  *
+ * current_cert_depth : Certificate depth of the certificate being passed over
+ *
+ * *current_cert : X509 Certificate object received from the client
  *
  */
 struct openvpn_plugin_args_func_in
@@ -252,6 +257,8 @@ struct openvpn_plugin_args_func_in
   const char const **envp;
   openvpn_plugin_handle_t handle;
   void *per_client_context;
+  int current_cert_depth;
+  X509 *current_cert;
 };
 
 
diff --git a/pf.c b/pf.c
index aed836e..d2c7075 100644
--- a/pf.c
+++ b/pf.c
@@ -563,7 +563,7 @@ pf_init_context (struct context *c)
       if( pf_file ) {
         setenv_str (c->c2.es, "pf_file", pf_file);
 
-        if (plugin_call (c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es) == OPENVPN_PLUGIN_FUNC_SUCCESS)
+        if (plugin_call (c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es, -1, NULL) == OPENVPN_PLUGIN_FUNC_SUCCESS)
           {
             event_timeout_init (&c->c2.pf.reload, 1, now);
             c->c2.pf.filename = string_alloc (pf_file, NULL);
diff --git a/plugin.c b/plugin.c
index ca52087..c7a69eb 100644
--- a/plugin.c
+++ b/plugin.c
@@ -345,7 +345,9 @@ plugin_call_item (const struct plugin *p,
 		  const int type,
 		  const struct argv *av,
 		  struct openvpn_plugin_string_list **retlist,
-		  const char **envp)
+		  const char **envp,
+		  int certdepth,
+		  X509 *current_cert)
 {
   int status = OPENVPN_PLUGIN_FUNC_SUCCESS;
 
@@ -369,7 +371,9 @@ plugin_call_item (const struct plugin *p,
                                                     .argv    = (const char **) a.argv,
                                                     .envp    = envp,
                                                     .handle  = p->plugin_handle,
-                                                    .per_client_context = per_client_context };
+						    .per_client_context = per_client_context,
+						    .current_cert_depth = (current_cert ? certdepth : -1),
+						    .current_cert = current_cert };
         struct openvpn_plugin_args_func_return retargs;
 
         CLEAR(retargs);
@@ -570,7 +574,9 @@ plugin_call (const struct plugin_list *pl,
 	     const int type,
 	     const struct argv *av,
 	     struct plugin_return *pr,
-	     struct env_set *es)
+	     struct env_set *es,
+             int certdepth,
+	     X509 *current_cert)
 {
   if (pr)
     plugin_return_init (pr);
@@ -597,7 +603,8 @@ plugin_call (const struct plugin_list *pl,
 					       type,
 					       av,
 					       pr ? &pr->list[i] : NULL,
-					       envp);
+					       envp,
+					       certdepth, current_cert);
 	  switch (status)
 	    {
 	    case OPENVPN_PLUGIN_FUNC_SUCCESS:
diff --git a/plugin.h b/plugin.h
index 214db2f..846973f 100644
--- a/plugin.h
+++ b/plugin.h
@@ -120,7 +120,9 @@ int plugin_call (const struct plugin_list *pl,
 		 const int type,
 		 const struct argv *av,
 		 struct plugin_return *pr,
-		 struct env_set *es);
+		 struct env_set *es,
+		 int current_cert_depth,
+		 X509 *current_cert);
 
 void plugin_list_close (struct plugin_list *pl);
 bool plugin_defined (const struct plugin_list *pl, const int type);
diff --git a/socket.c b/socket.c
index 660e2ac..6e63730 100644
--- a/socket.c
+++ b/socket.c
@@ -1684,7 +1684,7 @@ link_socket_connection_initiated (const struct buffer *buf,
     {
       struct argv argv = argv_new ();
       ipchange_fmt (false, &argv, info, &gc);
-      if (plugin_call (info->plugins, OPENVPN_PLUGIN_IPCHANGE, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plugin_call (info->plugins, OPENVPN_PLUGIN_IPCHANGE, &argv, NULL, es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	msg (M_WARN, "WARNING: ipchange plugin call failed");
       argv_reset (&argv);
     }
diff --git a/ssl.c b/ssl.c
index 7618c8f..ea4b6d5 100644
--- a/ssl.c
+++ b/ssl.c
@@ -915,7 +915,7 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
 		   ctx->error_depth,
 		   subject);
 
-      ret = plugin_call (opt->plugins, OPENVPN_PLUGIN_TLS_VERIFY, &argv, NULL, opt->es);
+      ret = plugin_call (opt->plugins, OPENVPN_PLUGIN_TLS_VERIFY, &argv, NULL, opt->es, ctx->error_depth, ctx->current_cert);
 
       if (ret == OPENVPN_PLUGIN_FUNC_SUCCESS)
 	{
@@ -3345,7 +3345,7 @@ verify_user_pass_plugin (struct tls_session *session, const struct user_pass *up
 #endif
 
       /* call command */
-      retval = plugin_call (session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
+      retval = plugin_call (session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es, -1, NULL);
 
 #ifdef PLUGIN_DEF_AUTH
       /* purge auth control filename (and file itself) for non-deferred returns */
@@ -3874,7 +3874,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
    */
   if (ks->authenticated && plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
     {
-      if (plugin_call (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plugin_call (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	ks->authenticated = false;
     }
 
-- 
1.7.2.3


