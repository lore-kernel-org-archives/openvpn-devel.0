From: David Sommerseth <dazo@...384...>
Date: Thu, 21 Nov 2013 18:02:12 +0100
Message-Id: <1385053332-14533-5-git-send-email-dazo@...384...>
In-Reply-To: <1385053332-14533-1-git-send-email-dazo@...384...>
References: <1385053332-14533-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 4/4] Merge the rest of ALLOC_*_CLEAR*()
	macros into ALLOC_*()
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

From: David Sommerseth <davids@...1347...>

This is the last patch in the malloc() -> calloc() move.

This patch only reduces the ALLOC_*() macro API further by removing
duplicated macros, where the version with _CLEAR would now do the
same thing as the one without _CLEAR.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/buffer.h             | 18 +-----------------
 src/openvpn/clinat.c             |  2 +-
 src/openvpn/event.c              | 12 ++++++------
 src/openvpn/init.c               |  6 +++---
 src/openvpn/manage.c             |  2 +-
 src/openvpn/misc.c               | 14 +++++++-------
 src/openvpn/options.c            |  8 ++++----
 src/openvpn/plugin.c             |  2 +-
 src/openvpn/pool.c               |  6 +++---
 src/openvpn/proxy.c              |  2 +-
 src/openvpn/push.c               |  2 +-
 src/openvpn/route.c              |  8 ++++----
 src/openvpn/ssl.c                |  6 +++---
 src/openvpn/ssl_polarssl.c       |  2 +-
 src/openvpn/ssl_verify.c         |  2 +-
 src/openvpn/ssl_verify_openssl.c |  2 +-
 src/openvpn/tun.c                |  4 ++--
 17 files changed, 41 insertions(+), 57 deletions(-)

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 81d8fea..ca599d7 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -837,18 +837,7 @@ gc_reset (struct gc_arena *a)
   (dptr) = (type *) gc_malloc (array_mult_safe (sizeof (type), (n), 0), (gc)); \
 }
 
-#define ALLOC_ARRAY_CLEAR(dptr, type, n) \
-{ \
-  ALLOC_ARRAY (dptr, type, n); \
-  memset ((dptr), 0, (array_mult_safe (sizeof(type), (n), 0)));	\
-}
-
-#define ALLOC_ARRAY_CLEAR_GC(dptr, type, n, gc) \
-{ \
-  (dptr) = (type *) gc_malloc (array_mult_safe (sizeof (type), (n), 0), (gc)); \
-}
-
-#define ALLOC_VAR_ARRAY_CLEAR_GC(dptr, type, atype, n, gc)	\
+#define ALLOC_VAR_ARRAY_GC(dptr, type, atype, n, gc)     \
 { \
   (dptr) = (type *) gc_malloc (array_mult_safe (sizeof (atype), (n), sizeof (type)), (gc)); \
 }
@@ -858,11 +847,6 @@ gc_reset (struct gc_arena *a)
   (dptr) = (type *) gc_malloc (sizeof (type), (gc)); \
 }
 
-#define ALLOC_OBJ_CLEAR_GC(dptr, type, gc) \
-{ \
-  (dptr) = (type *) gc_malloc (sizeof (type), (gc)); \
-}
-
 static inline void
 check_malloc_return (void *p)
 {
diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index af75fc9..442506d 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -80,7 +80,7 @@ struct client_nat_option_list *
 new_client_nat_list (struct gc_arena *gc)
 {
   struct client_nat_option_list *ret;
-  ALLOC_OBJ_CLEAR_GC (ret, struct client_nat_option_list, gc);
+  ALLOC_OBJ_GC (ret, struct client_nat_option_list, gc);
   return ret;
 }
 
diff --git a/src/openvpn/event.c b/src/openvpn/event.c
index e8ebbd2..933b68b 100644
--- a/src/openvpn/event.c
+++ b/src/openvpn/event.c
@@ -451,10 +451,10 @@ we_init (int *maxevents, unsigned int flags)
   *maxevents = min_int (*maxevents, WSA_MAXIMUM_WAIT_EVENTS);
 
   /* Allocate space for Win32 event handles */
-  ALLOC_ARRAY_CLEAR (wes->events, HANDLE, wes->capacity);
+  ALLOC_ARRAY (wes->events, HANDLE, wes->capacity);
 
   /* Allocate space for event_set_return objects */
-  ALLOC_ARRAY_CLEAR (wes->esr, struct event_set_return, wes->capacity);
+  ALLOC_ARRAY (wes->esr, struct event_set_return, wes->capacity);
 
   dmsg (D_EVENT_WAIT, "WE_INIT maxevents=%d capacity=%d",
        *maxevents, wes->capacity);
@@ -601,7 +601,7 @@ ep_init (int *maxevents, unsigned int flags)
   /* allocate space for epoll_wait return */
   ASSERT (*maxevents > 0);
   eps->maxevents = *maxevents;
-  ALLOC_ARRAY_CLEAR (eps->events, struct epoll_event, eps->maxevents);
+  ALLOC_ARRAY (eps->events, struct epoll_event, eps->maxevents);
 
   /* set epoll control fd */
   eps->epfd = fd;
@@ -793,10 +793,10 @@ po_init (int *maxevents, unsigned int flags)
   pos->capacity = *maxevents;
 
   /* Allocate space for pollfd structures to be passed to poll() */
-  ALLOC_ARRAY_CLEAR (pos->events, struct pollfd, pos->capacity);
+  ALLOC_ARRAY (pos->events, struct pollfd, pos->capacity);
 
   /* Allocate space for event_set_return objects */
-  ALLOC_ARRAY_CLEAR (pos->args, void *, pos->capacity);
+  ALLOC_ARRAY (pos->args, void *, pos->capacity);
 
   return (struct event_set *) pos;
 }
@@ -997,7 +997,7 @@ se_init (int *maxevents, unsigned int flags)
   ses->capacity = SELECT_MAX_FDS;
 
   /* Allocate space for event_set_return void * args */
-  ALLOC_ARRAY_CLEAR (ses->args, void *, ses->capacity);
+  ALLOC_ARRAY (ses->args, void *, ses->capacity);
 
   return (struct event_set *) ses;
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 705d50b..92519f0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -233,7 +233,7 @@ management_callback_remote_cmd (void *arg, const char **p)
 	      struct remote_host_store *rhs = c->options.rh_store;
 	      if (!rhs)
 		{
-		  ALLOC_OBJ_CLEAR_GC (rhs, struct remote_host_store, &c->options.gc);
+		  ALLOC_OBJ_GC (rhs, struct remote_host_store, &c->options.gc);
 		  c->options.rh_store = rhs;
 		}
 	      strncpynt(rhs->host, p[2], RH_HOST_LEN);
@@ -2785,7 +2785,7 @@ do_init_first_time (struct context *c)
     {
       struct context_0 *c0;
 
-      ALLOC_OBJ_CLEAR_GC (c->c0, struct context_0, &c->gc);
+      ALLOC_OBJ_GC (c->c0, struct context_0, &c->gc);
       c0 = c->c0;
       
       /* get user and/or group that we want to setuid/setgid to */
@@ -3621,7 +3621,7 @@ inherit_context_child (struct context *dest,
 
   dest->gc = gc_new ();
 
-  ALLOC_OBJ_CLEAR_GC (dest->sig, struct signal_info, &dest->gc);
+  ALLOC_OBJ_GC (dest->sig, struct signal_info, &dest->gc);
 
   /* c1 init */
   packet_id_persist_init (&dest->c1.pid_persist);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 6c4070f..f1e3411 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3324,7 +3324,7 @@ log_history_obj_init (struct log_history *h, int capacity)
 {
   CLEAR (*h);
   h->capacity = capacity;
-  ALLOC_ARRAY_CLEAR (h->array, struct log_entry, capacity);
+  ALLOC_ARRAY (h->array, struct log_entry, capacity);
 }
 
 struct log_history *
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 2132649..440727e 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -570,7 +570,7 @@ struct env_set *
 env_set_create (struct gc_arena *gc)
 {
   struct env_set *es;
-  ALLOC_OBJ_CLEAR_GC (es, struct env_set, gc);
+  ALLOC_OBJ_GC (es, struct env_set, gc);
   es->list = NULL;
   es->gc = gc;
   return es;
@@ -1234,7 +1234,7 @@ get_auth_challenge (const char *auth_challenge, struct gc_arena *gc)
       struct buffer b;
       buf_set_read (&b, (const uint8_t *)auth_challenge, len);
 
-      ALLOC_OBJ_CLEAR_GC (ac, struct auth_challenge_info, gc);
+      ALLOC_OBJ_GC (ac, struct auth_challenge_info, gc);
 
       /* parse prefix */
       if (!buf_parse(&b, ':', work, len))
@@ -1397,7 +1397,7 @@ make_env_array (const struct env_set *es,
     }
 
   /* alloc return array */
-  ALLOC_ARRAY_CLEAR_GC (ret, char *, n+1, gc);
+  ALLOC_ARRAY_GC (ret, char *, n+1, gc);
 
   /* fill return array */
   if (es)
@@ -1426,7 +1426,7 @@ make_arg_array (const char *first, const char *parms, struct gc_arena *gc)
   int n = 0;
 
   /* alloc return array */
-  ALLOC_ARRAY_CLEAR_GC (ret, char *, max_parms, gc);
+  ALLOC_ARRAY_GC (ret, char *, max_parms, gc);
 
   /* process first parameter, if provided */
   if (first)
@@ -1458,7 +1458,7 @@ make_inline_array (const char *str, struct gc_arena *gc)
     ++len;
 
   /* alloc return array */
-  ALLOC_ARRAY_CLEAR_GC (ret, char *, len + 1, gc);
+  ALLOC_ARRAY_GC (ret, char *, len + 1, gc);
 
   buf_set_read (&buf, (const uint8_t *) str, strlen(str));
   while (buf_parse (&buf, '\n', line, sizeof (line)))
@@ -1482,7 +1482,7 @@ make_arg_copy (char **p, struct gc_arena *gc)
   int i;
 
   /* alloc return array */
-  ALLOC_ARRAY_CLEAR_GC (ret, char *, max_parms, gc);
+  ALLOC_ARRAY_GC (ret, char *, max_parms, gc);
 
   for (i = 0; i < len; ++i)
     ret[i] = p[i];
@@ -1580,7 +1580,7 @@ argv_extend (struct argv *a, const size_t newcap)
     {
       char **newargv;
       size_t i;
-      ALLOC_ARRAY_CLEAR (newargv, char *, newcap);
+      ALLOC_ARRAY(newargv, char *, newcap);
       for (i = 0; i < a->argc; ++i)
 	newargv[i] = a->argv[i];
       free (a->argv);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 81e9a6e..76a33e6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1713,7 +1713,7 @@ parse_http_proxy_override (const char *server,
 	  return NULL;
 	}
 
-      ALLOC_OBJ_CLEAR_GC (ho, struct http_proxy_options, gc);
+      ALLOC_OBJ_GC (ho, struct http_proxy_options, gc);
       ho->server = string_alloc(server, gc);
       ho->port = int_port;
       ho->retry = true;
@@ -1769,7 +1769,7 @@ static struct connection_list *
 alloc_connection_list_if_undef (struct options *options)
 {
   if (!options->connection_list)
-    ALLOC_OBJ_CLEAR_GC (options->connection_list, struct connection_list, &options->gc);
+    ALLOC_OBJ_GC (options->connection_list, struct connection_list, &options->gc);
   return options->connection_list;
 }
 
@@ -1793,7 +1793,7 @@ static struct remote_list *
 alloc_remote_list_if_undef (struct options *options)
 {
   if (!options->remote_list)
-    ALLOC_OBJ_CLEAR_GC (options->remote_list, struct remote_list, &options->gc);
+    ALLOC_OBJ_GC (options->remote_list, struct remote_list, &options->gc);
   return options->remote_list;
 }
 
@@ -2788,7 +2788,7 @@ pre_pull_save (struct options *o)
 {
   if (o->pull)
     {
-      ALLOC_OBJ_CLEAR_GC (o->pre_pull, struct options_pre_pull, &o->gc);
+      ALLOC_OBJ_GC (o->pre_pull, struct options_pre_pull, &o->gc);
       o->pre_pull->tuntap_options = o->tuntap_options;
       o->pre_pull->tuntap_options_defined = true;
       o->pre_pull->foreign_option_index = o->foreign_option_index;
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index cad98ac..d8b2acc 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -136,7 +136,7 @@ struct plugin_option_list *
 plugin_option_list_new (struct gc_arena *gc)
 {
   struct plugin_option_list *ret;
-  ALLOC_OBJ_CLEAR_GC (ret, struct plugin_option_list, gc);
+  ALLOC_OBJ_GC (ret, struct plugin_option_list, gc);
   return ret;
 }
 
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index 0addda7..dfba34c 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -186,7 +186,7 @@ ifconfig_pool_init (int type, in_addr_t start, in_addr_t end,
       ASSERT( pool->size < pool->size_ipv6 );
     }
 
-  ALLOC_ARRAY_CLEAR (pool->list, struct ifconfig_pool_entry, pool->size);
+  ALLOC_ARRAY (pool->list, struct ifconfig_pool_entry, pool->size);
 
   msg (D_IFCONFIG_POOL, "IFCONFIG POOL: base=%s size=%d, ipv6=%d",
        print_in_addr_t (pool->base, 0, &gc),
@@ -454,8 +454,8 @@ ifconfig_pool_read (struct ifconfig_pool_persist *persist, struct ifconfig_pool
       char *ip_buf;
       int line = 0;
 
-      ALLOC_ARRAY_CLEAR_GC (cn_buf, char, buf_size, &gc);
-      ALLOC_ARRAY_CLEAR_GC (ip_buf, char, buf_size, &gc);
+      ALLOC_ARRAY_GC (cn_buf, char, buf_size, &gc);
+      ALLOC_ARRAY_GC (ip_buf, char, buf_size, &gc);
 
       while (true)
 	{
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 58e1338..54b04af 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -52,7 +52,7 @@ init_http_proxy_options_once (struct http_proxy_options **hpo,
 {
   if (!*hpo)
     {
-      ALLOC_OBJ_CLEAR_GC (*hpo, struct http_proxy_options, gc);
+      ALLOC_OBJ_GC (*hpo, struct http_proxy_options, gc);
       /* http proxy defaults */
       (*hpo)->timeout = 5;
       (*hpo)->http_version = "1.0";
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index be50bef..882ff90 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -341,7 +341,7 @@ push_option_ex (struct options *o, const char *opt, bool enable, int msglevel)
   else
     {
       struct push_entry *e;
-      ALLOC_OBJ_CLEAR_GC (e, struct push_entry, &o->gc);
+      ALLOC_OBJ_GC (e, struct push_entry, &o->gc);
       e->enable = true;
       e->option = opt;
       if (o->push_list.head)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 37ef096..aeee883 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -95,7 +95,7 @@ struct route_option_list *
 new_route_option_list (const int max_routes, struct gc_arena *a)
 {
   struct route_option_list *ret;
-  ALLOC_VAR_ARRAY_CLEAR_GC (ret, struct route_option_list, struct route_option, max_routes, a);
+  ALLOC_VAR_ARRAY_GC (ret, struct route_option_list, struct route_option, max_routes, a);
   ret->capacity = max_routes;
   return ret;
 }
@@ -104,7 +104,7 @@ struct route_ipv6_option_list *
 new_route_ipv6_option_list (const int max_routes, struct gc_arena *a)
 {
   struct route_ipv6_option_list *ret;
-  ALLOC_VAR_ARRAY_CLEAR_GC (ret, struct route_ipv6_option_list, struct route_ipv6_option, max_routes, a);
+  ALLOC_VAR_ARRAY_GC (ret, struct route_ipv6_option_list, struct route_ipv6_option, max_routes, a);
   ret->capacity = max_routes;
   return ret;
 }
@@ -150,7 +150,7 @@ struct route_list *
 new_route_list (const int max_routes, struct gc_arena *a)
 {
   struct route_list *ret;
-  ALLOC_VAR_ARRAY_CLEAR_GC (ret, struct route_list, struct route, max_routes, a);
+  ALLOC_VAR_ARRAY_GC (ret, struct route_list, struct route, max_routes, a);
   ret->capacity = max_routes;
   return ret;
 }
@@ -159,7 +159,7 @@ struct route_ipv6_list *
 new_route_ipv6_list (const int max_routes, struct gc_arena *a)
 {
   struct route_ipv6_list *ret;
-  ALLOC_VAR_ARRAY_CLEAR_GC (ret, struct route_ipv6_list, struct route_ipv6, max_routes, a);
+  ALLOC_VAR_ARRAY_GC (ret, struct route_ipv6_list, struct route_ipv6, max_routes, a);
   ret->capacity = max_routes;
   return ret;
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 1650b27..c30969d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1070,7 +1070,7 @@ tls_auth_standalone_init (struct tls_options *tls_options,
 {
   struct tls_auth_standalone *tas;
 
-  ALLOC_OBJ_CLEAR_GC (tas, struct tls_auth_standalone, gc);
+  ALLOC_OBJ_GC (tas, struct tls_auth_standalone, gc);
 
   /* set up pointer to HMAC object for TLS packet authentication */
   tas->tls_auth_key = tls_options->tls_auth_key;
@@ -2014,7 +2014,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
   struct user_pass *up;
 
   /* allocate temporary objects */
-  ALLOC_ARRAY_CLEAR_GC (options, char, TLS_OPTIONS_LEN, &gc);
+  ALLOC_ARRAY_GC (options, char, TLS_OPTIONS_LEN, &gc);
 
   ASSERT (session->opt->key_method == 2);
 
@@ -2051,7 +2051,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
    * authenticating for it, because otherwise we can't get at the
    * peer_info data which follows behind
    */
-  ALLOC_OBJ_CLEAR_GC (up, struct user_pass, &gc);
+  ALLOC_OBJ_GC (up, struct user_pass, &gc);
   username_status = read_string (buf, up->username, USER_PASS_LEN);
   password_status = read_string (buf, up->password, USER_PASS_LEN);
 
diff --git a/src/openvpn/ssl_polarssl.c b/src/openvpn/ssl_polarssl.c
index 83d5ae2..0e086ec 100644
--- a/src/openvpn/ssl_polarssl.c
+++ b/src/openvpn/ssl_polarssl.c
@@ -179,7 +179,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
       cipher_count++;
 
   /* Allocate an array for them */
-  ALLOC_ARRAY_CLEAR(ctx->allowed_ciphers, int, cipher_count+1)
+  ALLOC_ARRAY (ctx->allowed_ciphers, int, cipher_count+1)
 
   /* Parse allowed ciphers, getting IDs */
   i = 0;
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 43579c7..28768ef 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1142,7 +1142,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
    */
   if (compat_flag (COMPAT_FLAG_QUERY | COMPAT_NAMES))
     {
-      ALLOC_ARRAY_CLEAR_GC (raw_username, char, USER_PASS_LEN, &gc);
+      ALLOC_ARRAY_GC (raw_username, char, USER_PASS_LEN, &gc);
       strcpy (raw_username, up->username);
       string_mod (raw_username, CC_PRINT, CC_CRLF, '_');
     }
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 176669f..28ac18a 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -299,7 +299,7 @@ void
 x509_track_add (const struct x509_track **ll_head, const char *name, int msglevel, struct gc_arena *gc)
 {
   struct x509_track *xt;
-  ALLOC_OBJ_CLEAR_GC (xt, struct x509_track, gc);
+  ALLOC_OBJ_GC (xt, struct x509_track, gc);
   if (*name == '+')
     {
       xt->flags |= XT_FULL_CHAIN;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index de7ccb9..ca35a01 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3095,7 +3095,7 @@ get_tap_reg (struct gc_arena *gc)
 		  if (!strcmp (component_id, TAP_WIN_COMPONENT_ID))
 		    {
 		      struct tap_reg *reg;
-		      ALLOC_OBJ_CLEAR_GC (reg, struct tap_reg, gc);
+		      ALLOC_OBJ_GC (reg, struct tap_reg, gc);
 		      reg->guid = string_alloc (net_cfg_instance_id, gc);
 		      
 		      /* link into return list */
@@ -3194,7 +3194,7 @@ get_panel_reg (struct gc_arena *gc)
               LPSTR name;
 	      struct panel_reg *reg;
 
-	      ALLOC_OBJ_CLEAR_GC (reg, struct panel_reg, gc);
+	      ALLOC_OBJ_GC (reg, struct panel_reg, gc);
               n = WideCharToMultiByte (CP_UTF8, 0, name_data, -1, NULL, 0, NULL, NULL);
               name = gc_malloc (n, gc);
               WideCharToMultiByte (CP_UTF8, 0, name_data, -1, name, n, NULL, NULL);
-- 
1.8.3.1


