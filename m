From: Arne Schwabe <arne@...1227...>
Date: Mon, 18 Jun 2012 20:39:07 +0200
Message-Id: <1340044749-10694-5-git-send-email-arne@...1227...>
In-Reply-To: <1340044749-10694-1-git-send-email-arne@...1227...>
References: <1340044749-10694-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 4/6] Remove ENABLE_CONNECTIONS ifdefs,
	connections were always on for a long time. Not that
	ENABLE_MAMAGEMENT_REMOTE was only depending on
	ENABLE_CONNECTIONS and is removed as well
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


Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c    |   12 ------------
 src/openvpn/manage.c  |    8 --------
 src/openvpn/manage.h  |    6 ------
 src/openvpn/options.c |   24 ------------------------
 src/openvpn/options.h |   19 -------------------
 src/openvpn/syshead.h |   16 +---------------
 6 files changed, 1 insertions(+), 84 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 292c3a8..f67745f 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -206,8 +206,6 @@ management_callback_http_proxy_fallback_cmd (void *arg, const char *server, cons
 
 #endif
 
-#if MANAGEMENT_QUERY_REMOTE
-
 static bool
 management_callback_remote_cmd (void *arg, const char **p)
 {
@@ -288,15 +286,12 @@ ce_management_query_remote (struct context *c, const char *remote_ip_hint)
   return ret;
 }
 
-#endif
-
 /*
  * Initialize and possibly randomize connection list.
  */
 static void
 init_connection_list (struct context *c)
 {
-#ifdef ENABLE_CONNECTION
   struct connection_list *l = c->options.connection_list;
   if (l)
     {
@@ -317,7 +312,6 @@ init_connection_list (struct context *c)
 	    }
 	}
     }
-#endif
 }
 
 #if 0 /* fixme -- disable for production */
@@ -350,7 +344,6 @@ show_connection_list (const struct connection_list *l)
 static void
 next_connection_entry (struct context *c)
 {
-#ifdef ENABLE_CONNECTION
   struct connection_list *l = c->options.connection_list;
   if (l)
     {
@@ -404,7 +397,6 @@ next_connection_entry (struct context *c)
 
 	c->options.ce = *ce;
 
-#if MANAGEMENT_QUERY_REMOTE
 	if (ce_defined && management && management_query_remote_enabled(management))
 	  {
 	    /* allow management interface to override connection entry details */
@@ -412,7 +404,6 @@ next_connection_entry (struct context *c)
 	    if (IS_SIG (c))
 	      break;
 	  } else
-#endif
 	if (remote_ip_hint)
 	  c->options.ce.remote = remote_ip_hint;
 
@@ -424,7 +415,6 @@ next_connection_entry (struct context *c)
 #endif
       } while (!ce_defined);
     }
-#endif
   update_options_ce_post (&c->options);
 }
 
@@ -3178,9 +3168,7 @@ init_management_callback_p2p (struct context *c)
 #if HTTP_PROXY_FALLBACK
       cb.http_proxy_fallback_cmd = management_callback_http_proxy_fallback_cmd;
 #endif
-#if MANAGEMENT_QUERY_REMOTE
       cb.remote_cmd = management_callback_remote_cmd;
-#endif
       management_set_callback (management, &cb);
     }
 #endif
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 1dddd41..ef5d32c 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -92,9 +92,7 @@ man_help ()
   msg (M_CLIENT, "                         where action is reply string.");
   msg (M_CLIENT, "net                    : (Windows only) Show network info and routing table.");
   msg (M_CLIENT, "password type p        : Enter password p for a queried OpenVPN password.");
-#if MANAGEMENT_QUERY_REMOTE
   msg (M_CLIENT, "remote type [host port] : Override remote directive, type=ACCEPT|MOD|SKIP.");
-#endif
   msg (M_CLIENT, "pid                    : Show process ID of the current OpenVPN process.");
 #ifdef ENABLE_PKCS11
   msg (M_CLIENT, "pkcs11-id-count        : Get number of available PKCS#11 identities.");
@@ -1098,8 +1096,6 @@ man_http_proxy_fallback (struct management *man, const char *server, const char
 
 #endif
 
-#if MANAGEMENT_QUERY_REMOTE
-
 static void
 man_remote (struct management *man, const char **p)
 {
@@ -1121,8 +1117,6 @@ man_remote (struct management *man, const char **p)
     }
 }
 
-#endif
-
 static void
 man_dispatch_command (struct management *man, struct status_output *so, const char **p, const int nparms)
 {
@@ -1352,13 +1346,11 @@ man_dispatch_command (struct management *man, struct status_output *so, const ch
       man_http_proxy_fallback (man, NULL, NULL, NULL);
     }
 #endif
-#if MANAGEMENT_QUERY_REMOTE
   else if (streq (p[0], "remote"))
     {
       if (man_need (man, p, 1, MN_AT_LEAST))
 	man_remote (man, p);
     }
-#endif
 #if 1
   else if (streq (p[0], "test"))
     {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index f681f8d..f387c74 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -174,9 +174,7 @@ struct management_callback
 #if HTTP_PROXY_FALLBACK
   bool (*http_proxy_fallback_cmd) (void *arg, const char *server, const char *port, const char *flags);
 #endif
-#if MANAGEMENT_QUERY_REMOTE
   bool (*remote_cmd) (void *arg, const char **p);
-#endif
 };
 
 /*
@@ -336,9 +334,7 @@ struct management *management_init (void);
 # define MF_EXTERNAL_KEY    (1<<9)
 #endif
 #define MF_UP_DOWN          (1<<10)
-#if MANAGEMENT_QUERY_REMOTE
 #define MF_QUERY_REMOTE     (1<<11)
-#endif
 
 bool management_open (struct management *man,
 		      const char *addr,
@@ -427,13 +423,11 @@ management_query_user_pass_enabled (const struct management *man)
   return BOOL_CAST(man->settings.flags & MF_QUERY_PASSWORDS);
 }
 
-#if MANAGEMENT_QUERY_REMOTE
 static inline bool
 management_query_remote_enabled (const struct management *man)
 {
   return BOOL_CAST(man->settings.flags & MF_QUERY_REMOTE);
 }
-#endif
 
 #ifdef MANAGEMENT_PF
 static inline bool
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4b7a976..ea60826 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -381,9 +381,7 @@ static const char usage_message[] =
   "                      ip/port rather than listen as a TCP server.\n"
   "--management-query-passwords : Query management channel for private key\n"
   "                  and auth-user-pass passwords.\n"
-#if MANAGEMENT_QUERY_REMOTE
   "--management-query-remote : Query management channel for --remote directive.\n"
-#endif
   "--management-hold : Start " PACKAGE_NAME " in a hibernating state, until a client\n"
   "                    of the management interface explicitly starts it.\n"
   "--management-signal : Issue SIGUSR1 when management disconnect event occurs.\n"
@@ -931,7 +929,6 @@ setenv_settings (struct env_set *es, const struct options *o)
   setenv_unsigned (es, "daemon_start_time", time(NULL));
   setenv_int (es, "daemon_pid", platform_getpid());
 
-#ifdef ENABLE_CONNECTION
   if (o->connection_list)
     {
       int i;
@@ -939,7 +936,6 @@ setenv_settings (struct env_set *es, const struct options *o)
 	setenv_connection_entry (es, o->connection_list->array[i], i+1);
     }
   else
-#endif
     setenv_connection_entry (es, &o->ce, 1);
 }
 
@@ -1386,7 +1382,6 @@ show_connection_entries (const struct options *o)
 {
   msg (D_SHOW_PARMS, "Connection profiles [default]:");
   show_connection_entry (&o->ce);
-#ifdef ENABLE_CONNECTION
  if (o->connection_list)
    {
      const struct connection_list *l = o->connection_list;
@@ -1397,7 +1392,6 @@ show_connection_entries (const struct options *o)
 	 show_connection_entry (l->array[i]);
        }
    }
-#endif
   msg (D_SHOW_PARMS, "Connection profiles END");
 }
 
@@ -1822,8 +1816,6 @@ options_postprocess_http_proxy_override (struct options *o)
 
 #endif
 
-#if ENABLE_CONNECTION
-
 static struct connection_list *
 alloc_connection_list_if_undef (struct options *options)
 {
@@ -1872,8 +1864,6 @@ alloc_remote_entry (struct options *options, const int msglevel)
   return e;
 }
 
-#endif
-
 void
 connection_entry_load_re (struct connection_entry *ce, const struct remote_entry *re)
 {
@@ -2112,10 +2102,8 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       if (ce->socks_proxy_server)
 	msg (M_USAGE, "--socks-proxy cannot be used with --mode server");
 #endif
-#ifdef ENABLE_CONNECTION
       if (options->connection_list)
 	msg (M_USAGE, "<connection> cannot be used with --mode server");
-#endif
 #if 0
       if (options->tun_ipv6)
 	msg (M_USAGE, "--tun-ipv6 cannot be used with --mode server");
@@ -2516,7 +2504,6 @@ options_postprocess_mutate_invariant (struct options *options)
 static void
 options_postprocess_verify (const struct options *o)
 {
-#ifdef ENABLE_CONNECTION
   if (o->connection_list)
     {
       int i;
@@ -2524,7 +2511,6 @@ options_postprocess_verify (const struct options *o)
 	options_postprocess_verify_ce (o, o->connection_list->array[i]);
     }
   else
-#endif
     options_postprocess_verify_ce (o, &o->ce);
 }
 
@@ -2541,7 +2527,6 @@ options_postprocess_mutate (struct options *o)
 
   options_postprocess_mutate_invariant (o);
 
-#ifdef ENABLE_CONNECTION
   if (o->remote_list && !o->connection_list)
     {
       /*
@@ -2588,7 +2573,6 @@ options_postprocess_mutate (struct options *o)
 #endif
     }
   else
-#endif
     options_postprocess_mutate_ce (o, &o->ce);  
 
 #if P2MP
@@ -4224,13 +4208,11 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->management_flags |= MF_QUERY_PASSWORDS;
     }
-#if MANAGEMENT_QUERY_REMOTE
   else if (streq (p[0], "management-query-remote"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->management_flags |= MF_QUERY_REMOTE;
     }
-#endif
   else if (streq (p[0], "management-hold"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -4434,7 +4416,6 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->remote_random = true;
     }
-#if ENABLE_CONNECTION
   else if (streq (p[0], "connection") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
@@ -4460,14 +4441,11 @@ add_option (struct options *options,
 	  uninit_options (&sub);
 	}
     }
-#endif
-#ifdef ENABLE_CONNECTION
   else if (streq (p[0], "remote-ip-hint") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->remote_ip_hint = p[1];
     }
-#endif
 #if HTTP_PROXY_FALLBACK
   else if (streq (p[0], "http-proxy-fallback"))
     {
@@ -4512,7 +4490,6 @@ add_option (struct options *options,
 	      re.proto = proto;
 	    }
 	}
-#ifdef ENABLE_CONNECTION
       if (permission_mask & OPT_P_GENERAL)
 	{
 	  struct remote_entry *e = alloc_remote_entry (options, msglevel);
@@ -4521,7 +4498,6 @@ add_option (struct options *options,
 	  *e = re;
 	}
       else if (permission_mask & OPT_P_CONNECTION)
-#endif
 	{
 	  connection_entry_load_re (&options->ce, &re);
 	}
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a2e043d..65ecf7f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -133,7 +133,6 @@ struct connection_entry
 # define CE_HTTP_PROXY_FALLBACK (1<<1)
   time_t ce_http_proxy_fallback_timestamp; /* time when fallback http_proxy_options was last updated */
 #endif
-#if MANAGEMENT_QUERY_REMOTE
 # define CE_MAN_QUERY_REMOTE_UNDEF  0
 # define CE_MAN_QUERY_REMOTE_QUERY  1
 # define CE_MAN_QUERY_REMOTE_ACCEPT 2
@@ -141,7 +140,6 @@ struct connection_entry
 # define CE_MAN_QUERY_REMOTE_SKIP   4
 # define CE_MAN_QUERY_REMOTE_MASK   (0x07)
 # define CE_MAN_QUERY_REMOTE_SHIFT  (2)
-#endif
   unsigned int flags;
 };
 
@@ -152,8 +150,6 @@ struct remote_entry
   int proto;
 };
 
-#ifdef ENABLE_CONNECTION
-
 #define CONNECTION_LIST_SIZE 64
 
 struct connection_list
@@ -171,8 +167,6 @@ struct remote_list
   struct remote_entry *array[CONNECTION_LIST_SIZE];
 };
 
-#endif
-
 #if HTTP_PROXY_FALLBACK
 struct hpo_store
 {
@@ -181,13 +175,11 @@ struct hpo_store
 };
 #endif
 
-#if MANAGEMENT_QUERY_REMOTE
 struct remote_host_store
 {
 # define RH_HOST_LEN 80
   char host[RH_HOST_LEN];
 };
-#endif
 
 /* Command line options */
 struct options
@@ -223,13 +215,10 @@ struct options
 
   /* Networking parms */
   struct connection_entry ce;
-
-#ifdef ENABLE_CONNECTION
   char *remote_ip_hint;
   struct connection_list *connection_list;
   struct remote_list *remote_list;
   bool force_connection_list;
-#endif
 
 #if HTTP_PROXY_FALLBACK
   bool http_proxy_fallback;
@@ -237,9 +226,7 @@ struct options
   struct hpo_store *hpo_store; /* used to store dynamic proxy info given by management interface */
 #endif
 
-#if MANAGEMENT_QUERY_REMOTE
   struct remote_host_store *rh_store;
-#endif
 
   bool remote_random;
   const char *ipchange;
@@ -801,20 +788,14 @@ bool get_ipv6_addr( const char * prefix_str, struct in6_addr *network,
 static inline bool
 connection_list_defined (const struct options *o)
 {
-#ifdef ENABLE_CONNECTION
   return o->connection_list != NULL;
-#else
-  return false;
-#endif
 }
 
 static inline void
 connection_list_set_no_advance (struct options *o)
 {
-#ifdef ENABLE_CONNECTION
   if (o->connection_list)
     o->connection_list->no_advance = true;
-#endif
 }
 
 #if HTTP_PROXY_FALLBACK
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index b1d9584..cecc91e 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -650,29 +650,15 @@ socket_defined (const socket_descriptor_t sd)
 #endif
 
 /*
- * Support "connection" directive
- */
-#define ENABLE_CONNECTION 1
-
-/*
  * Should we include http proxy fallback functionality
  */
-#if defined(ENABLE_CONNECTION) && defined(ENABLE_MANAGEMENT) && defined(ENABLE_HTTP_PROXY)
+#if defined(ENABLE_MANAGEMENT) && defined(ENABLE_HTTP_PROXY)
 #define HTTP_PROXY_FALLBACK 1
 #else
 #define HTTP_PROXY_FALLBACK 0
 #endif
 
 /*
- * Should we include --management-query-remote functionality
- */
-#if defined(ENABLE_CONNECTION) && defined(ENABLE_MANAGEMENT)
-#define MANAGEMENT_QUERY_REMOTE 1
-#else
-#define MANAGEMENT_QUERY_REMOTE 0
-#endif
-
-/*
  * Reduce sensitivity to system clock instability
  * and backtracks.
  */
-- 
1.7.7.5 (Apple Git-26)


