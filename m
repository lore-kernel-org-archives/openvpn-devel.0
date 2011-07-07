From: Adriaan de Jong <dejong@...1435...>
Date: Thu, 7 Jul 2011 09:27:12 +0200
Message-ID: <1310023632-30830-1-git-send-email-dejong@...1435...>
In-Reply-To: <1CED409804E2164C8104F9E623B08B901269D8E721@...1436...>
References: <1CED409804E2164C8104F9E623B08B901269D8E721@...1436...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fixes for the plugin system:
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

 - Removed the dependency on an SSL library for USE_SSL when creating non-SSL plugins
 - Fixed example plugin code to include USE_SSL when needed

Signed-off-by: Adriaan de Jong <dejong@...1435...>
---
 init.c                   |    2 +-
 misc.c                   |    2 +-
 multi.c                  |    8 ++++----
 openvpn-plugin.h         |   18 +++++++++++++-----
 pf.c                     |    2 +-
 plugin.c                 |   36 ++++++++++++++++++++++++++----------
 plugin.h                 |   35 ++++++++++++++++++++++++++++-------
 plugin/examples/log_v3.c |    3 +++
 socket.c                 |    2 +-
 ssl.c                    |    2 +-
 ssl_verify.c             |    4 ++--
 11 files changed, 81 insertions(+), 33 deletions(-)

diff --git a/init.c b/init.c
index fd18557..1633acb 100644
--- a/init.c
+++ b/init.c
@@ -1250,7 +1250,7 @@ do_route (const struct options *options,
 
   if (plugin_defined (plugins, OPENVPN_PLUGIN_ROUTE_UP))
     {
-      if (plugin_call (plugins, OPENVPN_PLUGIN_ROUTE_UP, NULL, NULL, es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plugin_call (plugins, OPENVPN_PLUGIN_ROUTE_UP, NULL, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	msg (M_WARN, "WARNING: route-up plugin call failed");
     }
 
diff --git a/misc.c b/misc.c
index 1f94c30..119ef84 100644
--- a/misc.c
+++ b/misc.c
@@ -213,7 +213,7 @@ run_up_down (const char *command,
 		   ifconfig_local, ifconfig_remote,
 		   context);
 
-      if (plugin_call (plugins, plugin_type, &argv, NULL, es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plugin_call (plugins, plugin_type, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	msg (M_FATAL, "ERROR: up/down plugin call failed");
 
       argv_reset (&argv);
diff --git a/multi.c b/multi.c
index 15bea22..d4b6a9b 100644
--- a/multi.c
+++ b/multi.c
@@ -91,7 +91,7 @@ learn_address_script (const struct multi_context *m,
 		   mroute_addr_print (addr, &gc));
       if (mi)
 	argv_printf_cat (&argv, "%s", tls_common_name (mi->context.c2.tls_multi, false));
-      if (plugin_call (plugins, OPENVPN_PLUGIN_LEARN_ADDRESS, &argv, NULL, es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plugin_call (plugins, OPENVPN_PLUGIN_LEARN_ADDRESS, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	{
 	  msg (M_WARN, "WARNING: learn-address plugin call failed");
 	  ret = false;
@@ -468,7 +468,7 @@ multi_client_disconnect_script (struct multi_context *m,
 
       if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT))
 	{
-	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT, NULL, NULL, mi->context.c2.es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_DISCONNECT, NULL, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	    msg (M_WARN, "WARNING: client-disconnect plugin call failed");
 	}
 
@@ -1633,7 +1633,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
           }
 
 	  argv_printf (&argv, "%s", dc_file);
-	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	    {
 	      msg (M_WARN, "WARNING: client-connect plugin call failed");
 	      cc_succeeded = false;
@@ -1654,7 +1654,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
 	  plugin_return_init (&pr);
 
-	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2, NULL, &pr, mi->context.c2.es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT_V2, NULL, &pr, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	    {
 	      msg (M_WARN, "WARNING: client-connect-v2 plugin call failed");
 	      cc_succeeded = false;
diff --git a/openvpn-plugin.h b/openvpn-plugin.h
index 9cce9d8..65a3ffd 100644
--- a/openvpn-plugin.h
+++ b/openvpn-plugin.h
@@ -25,12 +25,15 @@
 #ifndef OPENVPN_PLUGIN_H_
 #define OPENVPN_PLUGIN_H_
 
-#ifdef USE_OPENSSL
+#ifdef USE_SSL
+#if defined(USE_OPENSSL)
 #include "ssl_verify_openssl.h"
-#endif
-#ifdef USE_POLARSSL
+#elif defined(USE_POLARSSL)
 #include "ssl_verify_polarssl.h"
+#else
+#error "Either USE_OPENSSL or USE_POLARSSL should be defined"
 #endif
+#endif /*USE_SSL*/
 
 #define OPENVPN_PLUGIN_VERSION 3
 
@@ -267,9 +270,9 @@ struct openvpn_plugin_args_open_return
  * *per_client_context : the per-client context pointer which was returned by
  *        openvpn_plugin_client_constructor_v1, if defined.
  *
- * current_cert_depth : Certificate depth of the certificate being passed over
+ * current_cert_depth : Certificate depth of the certificate being passed over (only if compiled with USE_SSL defined)
  *
- * *current_cert : X509 Certificate object received from the client
+ * *current_cert : X509 Certificate object received from the client (only if compiled with USE_SSL defined)
  *
  */
 struct openvpn_plugin_args_func_in
@@ -279,8 +282,13 @@ struct openvpn_plugin_args_func_in
   const char ** const envp;
   openvpn_plugin_handle_t handle;
   void *per_client_context;
+#ifdef USE_SSL
   int current_cert_depth;
   x509_cert_t *current_cert;
+#else
+  int current_cert_depth; /* Unused, for compatibility purposes only */
+  void *current_cert; /* Unused, for compatibility purposes only */
+#endif
 };
 
 
diff --git a/pf.c b/pf.c
index 8aae99c..6b4cba4 100644
--- a/pf.c
+++ b/pf.c
@@ -563,7 +563,7 @@ pf_init_context (struct context *c)
       if( pf_file ) {
         setenv_str (c->c2.es, "pf_file", pf_file);
 
-        if (plugin_call (c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es, -1, NULL) == OPENVPN_PLUGIN_FUNC_SUCCESS)
+        if (plugin_call (c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es) == OPENVPN_PLUGIN_FUNC_SUCCESS)
           {
             event_timeout_init (&c->c2.pf.reload, 1, now);
             c->c2.pf.filename = string_alloc (pf_file, NULL);
diff --git a/plugin.c b/plugin.c
index 4cfdcaa..331671c 100644
--- a/plugin.c
+++ b/plugin.c
@@ -345,9 +345,12 @@ plugin_call_item (const struct plugin *p,
 		  const int type,
 		  const struct argv *av,
 		  struct openvpn_plugin_string_list **retlist,
-		  const char **envp,
-		  int certdepth,
-		  x509_cert_t *current_cert)
+		  const char **envp
+#ifdef USE_SSL
+		  , int certdepth,
+		  x509_cert_t *current_cert
+#endif
+		 )
 {
   int status = OPENVPN_PLUGIN_FUNC_SUCCESS;
 
@@ -372,8 +375,14 @@ plugin_call_item (const struct plugin *p,
                                                     .envp    = envp,
                                                     .handle  = p->plugin_handle,
 						    .per_client_context = per_client_context,
+#ifdef USE_SSL
 						    .current_cert_depth = (current_cert ? certdepth : -1),
-						    .current_cert = current_cert };
+						    .current_cert = current_cert
+#else
+						    .current_cert_depth = -1,
+						    .current_cert = NULL
+#endif
+						  };
         struct openvpn_plugin_args_func_return retargs;
 
         CLEAR(retargs);
@@ -570,13 +579,16 @@ plugin_list_open (struct plugin_list *pl,
 }
 
 int
-plugin_call (const struct plugin_list *pl,
+plugin_call_ssl (const struct plugin_list *pl,
 	     const int type,
 	     const struct argv *av,
 	     struct plugin_return *pr,
-	     struct env_set *es,
-             int certdepth,
-	     x509_cert_t *current_cert)
+	     struct env_set *es
+#ifdef USE_SSL
+             , int certdepth,
+	     x509_cert_t *current_cert
+#endif
+	    )
 {
   if (pr)
     plugin_return_init (pr);
@@ -601,8 +613,12 @@ plugin_call (const struct plugin_list *pl,
 					       type,
 					       av,
 					       pr ? &pr->list[i] : NULL,
-					       envp,
-					       certdepth, current_cert);
+					       envp
+#ifdef USE_SSL
+					       ,certdepth,
+					       current_cert
+#endif
+					      );
 	  switch (status)
 	    {
 	    case OPENVPN_PLUGIN_FUNC_SUCCESS:
diff --git a/plugin.h b/plugin.h
index 5518147..8fa4168 100644
--- a/plugin.h
+++ b/plugin.h
@@ -116,13 +116,31 @@ void plugin_list_open (struct plugin_list *pl,
 
 struct plugin_list *plugin_list_inherit (const struct plugin_list *src);
 
-int plugin_call (const struct plugin_list *pl,
+
+static inline int
+plugin_call(const struct plugin_list *pl,
+	const int type,
+	const struct argv *av,
+	struct plugin_return *pr,
+	struct env_set *es)
+{
+  return plugin_call_ssl(pl, type, av, pr, es
+#ifdef USE_SSL
+      -1, NULL
+#endif
+      );
+}
+
+int plugin_call_ssl (const struct plugin_list *pl,
 		 const int type,
 		 const struct argv *av,
 		 struct plugin_return *pr,
-		 struct env_set *es,
-		 int current_cert_depth,
-		 x509_cert_t *current_cert);
+		 struct env_set *es
+#ifdef USE_SSL
+		 , int current_cert_depth,
+		 x509_cert_t *current_cert
+#endif
+		);
 
 void plugin_list_close (struct plugin_list *pl);
 bool plugin_defined (const struct plugin_list *pl, const int type);
@@ -174,9 +192,12 @@ plugin_call (const struct plugin_list *pl,
 	     const int type,
 	     const struct argv *av,
 	     struct plugin_return *pr,
-	     struct env_set *es,
-	     int current_cert_depth,
-	     x509_cert_t *current_cert)
+	     struct env_set *es
+#ifdef USE_SSL
+	     , int current_cert_depth,
+	     x509_cert_t *current_cert
+#endif
+	    )
 {
   return 0;
 }
diff --git a/plugin/examples/log_v3.c b/plugin/examples/log_v3.c
index bf2f1dc..2dff6a6 100644
--- a/plugin/examples/log_v3.c
+++ b/plugin/examples/log_v3.c
@@ -36,6 +36,9 @@
 #include <string.h>
 #include <stdlib.h>
 
+#define USE_SSL
+#define USE_OPENSSL
+
 #include "openvpn-plugin.h"
 
 /*
diff --git a/socket.c b/socket.c
index 6b855c0..ff31684 100644
--- a/socket.c
+++ b/socket.c
@@ -2151,7 +2151,7 @@ link_socket_connection_initiated (const struct buffer *buf,
     {
       struct argv argv = argv_new ();
       ipchange_fmt (false, &argv, info, &gc);
-      if (plugin_call (info->plugins, OPENVPN_PLUGIN_IPCHANGE, &argv, NULL, es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plugin_call (info->plugins, OPENVPN_PLUGIN_IPCHANGE, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	msg (M_WARN, "WARNING: ipchange plugin call failed");
       argv_reset (&argv);
     }
diff --git a/ssl.c b/ssl.c
index 3645fb0..42262de 100644
--- a/ssl.c
+++ b/ssl.c
@@ -1920,7 +1920,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
    */
   if (ks->authenticated && plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
     {
-      if (plugin_call (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es, -1, NULL) != OPENVPN_PLUGIN_FUNC_SUCCESS)
+      if (plugin_call (session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	ks->authenticated = false;
     }
 
diff --git a/ssl_verify.c b/ssl_verify.c
index 8592942..209d7f3 100644
--- a/ssl_verify.c
+++ b/ssl_verify.c
@@ -431,7 +431,7 @@ verify_cert_call_plugin(const struct plugin_list *plugins, struct env_set *es,
 
       argv_printf (&argv, "%d %s", cert_depth, subject);
 
-      ret = plugin_call (plugins, OPENVPN_PLUGIN_TLS_VERIFY, &argv, NULL, es, cert_depth, cert);
+      ret = plugin_call_ssl (plugins, OPENVPN_PLUGIN_TLS_VERIFY, &argv, NULL, es, cert_depth, cert);
 
       argv_reset (&argv);
 
@@ -1012,7 +1012,7 @@ verify_user_pass_plugin (struct tls_session *session, const struct user_pass *up
 #endif
 
       /* call command */
-      retval = plugin_call (session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es, -1, NULL);
+      retval = plugin_call (session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
 
 #ifdef PLUGIN_DEF_AUTH
       /* purge auth control filename (and file itself) for non-deferred returns */
-- 
1.7.4.1


