From: Arne Schwabe <arne@...1227...>
Date: Fri, 23 Oct 2020 13:32:44 +0200
Message-Id: <20201023113244.26295-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Remove --disable-def-auth configure argument
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

With scripts, plugin and management interface now all supporting
deferred auth, maintaining support of --disbale-def-auth becomes more
of a burden and the few kilobyte in potential binary size do not
outweigh this. Also the code in ssl_verify is hard to hard because
all the ifdefs.

Especially for management interface there are so many features not
directly related to deferred that depend on MANAGEMENT_DEF_AUTH
(like client-kill) that supporting management without deferred auth
is not worth it anymore. And removing this remover a high number of
ifdefs in manage.c/h

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 config-msvc.h            |  1 -
 configure.ac             |  8 -------
 src/openvpn/forward.c    |  4 ----
 src/openvpn/init.c       |  4 ++--
 src/openvpn/manage.c     | 21 -----------------
 src/openvpn/manage.h     | 17 --------------
 src/openvpn/multi.c      | 48 ++++++++++++++++++-------------------
 src/openvpn/multi.h      |  4 ++--
 src/openvpn/openvpn.h    |  2 +-
 src/openvpn/options.c    |  6 +----
 src/openvpn/options.h    |  2 +-
 src/openvpn/push.c       |  2 +-
 src/openvpn/ssl.c        |  4 ++--
 src/openvpn/ssl_common.h |  8 ++-----
 src/openvpn/ssl_verify.c | 51 ++++++++++------------------------------
 src/openvpn/ssl_verify.h |  2 +-
 src/openvpn/syshead.h    | 15 +-----------
 17 files changed, 50 insertions(+), 149 deletions(-)

diff --git a/config-msvc.h b/config-msvc.h
index f199bb2c..6126ac05 100644
--- a/config-msvc.h
+++ b/config-msvc.h
@@ -2,7 +2,6 @@
 
 #define CONFIGURE_DEFINES "N/A"
 
-#define ENABLE_DEF_AUTH 1
 #define ENABLE_PF 1
 #define ENABLE_CRYPTO_OPENSSL 1
 #define ENABLE_DEBUG 1
diff --git a/configure.ac b/configure.ac
index ebb32204..1ab8fe59 100644
--- a/configure.ac
+++ b/configure.ac
@@ -156,13 +156,6 @@ AC_ARG_ENABLE(
 	[enable_iproute2="no"]
 )
 
-AC_ARG_ENABLE(
-	[def-auth],
-	[AS_HELP_STRING([--disable-def-auth], [disable deferred authentication @<:@default=yes@:>@])],
-	,
-	[enable_def_auth="yes"]
-)
-
 AC_ARG_ENABLE(
 	[pf],
 	[AS_HELP_STRING([--disable-pf], [disable internal packet filter @<:@default=yes@:>@])],
@@ -1221,7 +1214,6 @@ test "${enable_debug}" = "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable debuggi
 test "${enable_small}" = "yes" && AC_DEFINE([ENABLE_SMALL], [1], [Enable smaller executable size])
 test "${enable_fragment}" = "yes" && AC_DEFINE([ENABLE_FRAGMENT], [1], [Enable internal fragmentation support])
 test "${enable_port_share}" = "yes" && AC_DEFINE([ENABLE_PORT_SHARE], [1], [Enable TCP Server port sharing])
-test "${enable_def_auth}" = "yes" && AC_DEFINE([ENABLE_DEF_AUTH], [1], [Enable deferred authentication])
 test "${enable_pf}" = "yes" && AC_DEFINE([ENABLE_PF], [1], [Enable internal packet filter])
 test "${enable_strict_options}" = "yes" && AC_DEFINE([ENABLE_STRICT_OPTIONS_CHECK], [1], [Enable strict options check between peers])
 
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7ed8d0d7..958246c4 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -880,9 +880,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
         if (management)
         {
             management_bytes_in(management, c->c2.buf.len);
-#ifdef MANAGEMENT_DEF_AUTH
             management_bytes_server(management, &c->c2.link_read_bytes, &c->c2.link_write_bytes, &c->c2.mda_context);
-#endif
         }
 #endif
     }
@@ -1642,9 +1640,7 @@ process_outgoing_link(struct context *c)
                 if (management)
                 {
                     management_bytes_out(management, size);
-#ifdef MANAGEMENT_DEF_AUTH
                     management_bytes_server(management, &c->c2.link_read_bytes, &c->c2.link_write_bytes, &c->c2.mda_context);
-#endif
                 }
 #endif
             }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 034edba0..dd7daa49 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2943,7 +2943,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
 
     to.plugins = c->plugins;
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     to.mda_context = &c->c2.mda_context;
 #endif
 
@@ -4495,7 +4495,7 @@ close_instance(struct context *c)
         /* close TUN/TAP device */
         do_close_tun(c, false);
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
         if (management)
         {
             management_notify_client_close(management, &c->c2.mda_context, NULL);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index ac142177..17694d04 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -100,7 +100,6 @@ man_help(void)
     msg(M_CLIENT, "pkcs11-id-count        : Get number of available PKCS#11 identities.");
     msg(M_CLIENT, "pkcs11-id-get index    : Get PKCS#11 identity at index.");
 #endif
-#ifdef MANAGEMENT_DEF_AUTH
     msg(M_CLIENT, "client-auth CID KID    : Authenticate client-id/key-id CID/KID (MULTILINE)");
     msg(M_CLIENT, "client-auth-nt CID KID : Authenticate client-id/key-id CID/KID");
     msg(M_CLIENT, "client-deny CID KID R [CR] : Deny auth client-id/key-id CID/KID with log reason");
@@ -111,7 +110,6 @@ man_help(void)
     msg(M_CLIENT, "env-filter [level]     : Set env-var filter level");
 #ifdef MANAGEMENT_PF
     msg(M_CLIENT, "client-pf CID          : Define packet filter for client CID (MULTILINE)");
-#endif
 #endif
     msg(M_CLIENT, "rsa-sig                : Enter a signature in response to >RSA_SIGN challenge");
     msg(M_CLIENT, "                         Enter signature base64 on subsequent lines followed by END");
@@ -483,8 +481,6 @@ man_bytecount_output_client(struct management *man)
     man->connection.bytecount_last_update = now;
 }
 
-#ifdef MANAGEMENT_DEF_AUTH
-
 void
 man_bytecount_output_server(struct management *man,
                             const counter_type *bytes_in_total,
@@ -500,8 +496,6 @@ man_bytecount_output_server(struct management *man,
     mdac->bytecount_last_update = now;
 }
 
-#endif
-
 static void
 man_kill(struct management *man, const char *victim)
 {
@@ -880,10 +874,8 @@ in_extra_reset(struct man_connection *mc, const int mode)
         if (mode != IER_NEW)
         {
             mc->in_extra_cmd = IEC_UNDEF;
-#ifdef MANAGEMENT_DEF_AUTH
             mc->in_extra_cid = 0;
             mc->in_extra_kid = 0;
-#endif
         }
         if (mc->in_extra)
         {
@@ -902,7 +894,6 @@ in_extra_dispatch(struct management *man)
 {
     switch (man->connection.in_extra_cmd)
     {
-#ifdef MANAGEMENT_DEF_AUTH
         case IEC_CLIENT_AUTH:
             if (man->persist.callback.client_auth)
             {
@@ -930,7 +921,6 @@ in_extra_dispatch(struct management *man)
             }
             break;
 
-#endif /* ifdef MANAGEMENT_DEF_AUTH */
 #ifdef MANAGEMENT_PF
         case IEC_CLIENT_PF:
             if (man->persist.callback.client_pf)
@@ -973,8 +963,6 @@ in_extra_dispatch(struct management *man)
     in_extra_reset(&man->connection, IER_RESET);
 }
 
-#ifdef MANAGEMENT_DEF_AUTH
-
 static bool
 parse_cid(const char *str, unsigned long *cid)
 {
@@ -1153,7 +1141,6 @@ man_client_pf(struct management *man, const char *cid_str)
 }
 
 #endif /* MANAGEMENT_PF */
-#endif /* MANAGEMENT_DEF_AUTH */
 
 static void
 man_pk_sig(struct management *man, const char *cmd_name)
@@ -1337,7 +1324,6 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
     {
         msg(M_CLIENT, "SUCCESS: pid=%d", platform_getpid());
     }
-#ifdef MANAGEMENT_DEF_AUTH
     else if (streq(p[0], "nclients"))
     {
         man_client_n_clients(man);
@@ -1351,7 +1337,6 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
         }
         man_env_filter(man, level);
     }
-#endif
     else if (streq(p[0], "signal"))
     {
         if (man_need(man, p, 1, 0))
@@ -1551,7 +1536,6 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
             man_bytecount(man, atoi(p[1]));
         }
     }
-#ifdef MANAGEMENT_DEF_AUTH
     else if (streq(p[0], "client-kill"))
     {
         if (man_need(man, p, 1, MN_AT_LEAST))
@@ -1596,7 +1580,6 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
         }
     }
 #endif
-#endif /* ifdef MANAGEMENT_DEF_AUTH */
     else if (streq(p[0], "rsa-sig"))
     {
         man_pk_sig(man, "rsa-sig");
@@ -2905,8 +2888,6 @@ management_notify_generic(struct management *man, const char *str)
     msg(M_CLIENT, "%s", str);
 }
 
-#ifdef MANAGEMENT_DEF_AUTH
-
 static void
 man_output_peer_info_env(struct management *man, const struct man_def_auth_context *mdac)
 {
@@ -3025,8 +3006,6 @@ management_learn_addr(struct management *management,
     gc_free(&gc);
 }
 
-#endif /* MANAGEMENT_DEF_AUTH */
-
 void
 management_echo(struct management *man, const char *string, const bool pull)
 {
diff --git a/src/openvpn/manage.h b/src/openvpn/manage.h
index 881bfb14..a3364644 100644
--- a/src/openvpn/manage.h
+++ b/src/openvpn/manage.h
@@ -40,7 +40,6 @@
 /*
  * Management-interface-based deferred authentication
  */
-#ifdef MANAGEMENT_DEF_AUTH
 struct man_def_auth_context {
     unsigned long cid;
 
@@ -53,7 +52,6 @@ struct man_def_auth_context {
 
     time_t bytecount_last_update;
 };
-#endif
 
 /*
  * Manage build-up of command line
@@ -165,7 +163,6 @@ struct management_callback
     void (*delete_event) (void *arg, event_t event);
     int (*n_clients) (void *arg);
     bool (*send_cc_message) (void *arg, const char *message, const char *parameter);
-#ifdef MANAGEMENT_DEF_AUTH
     bool (*kill_by_cid)(void *arg, const unsigned long cid, const char *kill_msg);
     bool (*client_auth) (void *arg,
                          const unsigned long cid,
@@ -178,7 +175,6 @@ struct management_callback
                                  const unsigned long cid,
                                  const char *url);
     char *(*get_peer_info) (void *arg, const unsigned long cid);
-#endif
 #ifdef MANAGEMENT_PF
     bool (*client_pf)(void *arg,
                       const unsigned long cid,
@@ -287,10 +283,8 @@ struct man_connection {
 #define IEC_PK_SIGN     5
     int in_extra_cmd;
     struct buffer_list *in_extra;
-#ifdef MANAGEMENT_DEF_AUTH
     unsigned long in_extra_cid;
     unsigned int in_extra_kid;
-#endif
 #define EKS_UNDEF   0
 #define EKS_SOLICIT 1
 #define EKS_INPUT   2
@@ -339,9 +333,7 @@ struct management *management_init(void);
 #define MF_SIGNAL            (1<<3)
 #define MF_FORGET_DISCONNECT (1<<4)
 #define MF_CONNECT_AS_CLIENT (1<<5)
-#ifdef MANAGEMENT_DEF_AUTH
 #define MF_CLIENT_AUTH       (1<<6)
-#endif
 #ifdef MANAGEMENT_PF
 #define MF_CLIENT_PF         (1<<7)
 #endif
@@ -415,7 +407,6 @@ void management_notify(struct management *man, const char *severity, const char
 
 void management_notify_generic(struct management *man, const char *str);
 
-#ifdef MANAGEMENT_DEF_AUTH
 void management_notify_client_needing_auth(struct management *management,
                                            const unsigned int auth_id,
                                            struct man_def_auth_context *mdac,
@@ -439,8 +430,6 @@ void management_notify_client_cr_response(unsigned mda_key_id,
                                           const struct env_set *es,
                                           const char *response);
 
-#endif /* ifdef MANAGEMENT_DEF_AUTH */
-
 char *management_query_pk_sig(struct management *man, const char *b64_data,
                               const char *algorithm);
 
@@ -478,13 +467,11 @@ management_enable_pf(const struct management *man)
 }
 #endif
 
-#ifdef MANAGEMENT_DEF_AUTH
 static inline bool
 management_enable_def_auth(const struct management *man)
 {
     return man && BOOL_CAST(man->settings.flags & MF_CLIENT_AUTH);
 }
-#endif
 
 /*
  * OpenVPN tells the management layer what state it's in
@@ -582,8 +569,6 @@ management_bytes_in(struct management *man, const int size)
     }
 }
 
-#ifdef MANAGEMENT_DEF_AUTH
-
 void man_bytecount_output_server(struct management *man,
                                  const counter_type *bytes_in_total,
                                  const counter_type *bytes_out_total,
@@ -603,8 +588,6 @@ management_bytes_server(struct management *man,
     }
 }
 
-#endif /* MANAGEMENT_DEF_AUTH */
-
 #endif /* ifdef ENABLE_MANAGEMENT */
 
 /**
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index a5862020..9becb2b2 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -69,7 +69,7 @@ id(struct multi_instance *mi)
 }
 #endif
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
 static void
 set_cc_config(struct multi_instance *mi, struct buffer_list *cc_config)
 {
@@ -252,7 +252,7 @@ reap_buckets_per_pass(int n_buckets)
     return constrain_int(n_buckets / REAP_DIVISOR, REAP_MIN, REAP_MAX);
 }
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
 
 static uint32_t
 cid_hash_function(const void *key, uint32_t iv)
@@ -342,7 +342,7 @@ multi_init(struct multi_context *m, struct context *t, bool tcp_mode, int thread
                         mroute_addr_hash_function,
                         mroute_addr_compare_function);
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     m->cid_hash = hash_init(t->options.real_hash_size,
                             0,
                             cid_hash_function,
@@ -592,7 +592,7 @@ multi_client_disconnect_script(struct multi_instance *mi)
         openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-disconnect");
         argv_free(&argv);
     }
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     if (management)
     {
         management_notify_client_close(management, &mi->context.c2.mda_context, mi->context.c2.es);
@@ -637,7 +637,7 @@ multi_close_instance(struct multi_context *m,
         {
             ASSERT(hash_remove(m->iter, &mi->real));
         }
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
         if (mi->did_cid_hash)
         {
             ASSERT(hash_remove(m->cid_hash, &mi->context.c2.mda_context.cid));
@@ -675,7 +675,7 @@ multi_close_instance(struct multi_context *m,
         mbuf_dereference_instance(m->mbuf, mi);
     }
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     set_cc_config(mi, NULL);
 #endif
     if (mi->context.c2.context_auth == CAS_SUCCEEDED)
@@ -731,7 +731,7 @@ multi_uninit(struct multi_context *m)
             hash_free(m->hash);
             hash_free(m->vhash);
             hash_free(m->iter);
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
             hash_free(m->cid_hash);
 #endif
             m->hash = NULL;
@@ -813,7 +813,7 @@ multi_create_instance(struct multi_context *m, const struct mroute_addr *real)
     }
     mi->did_iter = true;
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     do
     {
         mi->context.c2.mda_context.cid = m->cid_counter++;
@@ -944,7 +944,7 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
                 if (!mi->halt)
                 {
                     status_printf(so, "CLIENT_LIST%c%s%c%s%c%s%c%s%c" counter_format "%c" counter_format "%c%s%c%u%c%s%c"
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
                                   "%lu"
 #else
                                   ""
@@ -959,7 +959,7 @@ multi_print_status(struct multi_context *m, struct status_output *so, const int
                                   sep, time_string(mi->created, 0, false, &gc),
                                   sep, (unsigned int)mi->created,
                                   sep, tls_username(mi->context.c2.tls_multi, false),
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
                                   sep, mi->context.c2.mda_context.cid,
 #else
                                   sep,
@@ -1252,7 +1252,7 @@ multi_learn_in_addr_t(struct multi_context *m,
 
     {
         struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
         if (management && owner)
         {
             management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
@@ -1285,7 +1285,7 @@ multi_learn_in6_addr(struct multi_context *m,
 
     {
         struct multi_instance *owner = multi_learn_addr(m, mi, &addr, 0);
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
         if (management && owner)
         {
             management_learn_addr(management, &mi->context.c2.mda_context, &addr, primary);
@@ -1716,7 +1716,7 @@ multi_client_connect_mda(struct multi_context *m,
     /* We never return CC_RET_DEFERRED */
     ASSERT(!deferred);
     enum client_connect_return ret = CC_RET_SKIPPED;
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     if (mi->cc_config)
     {
         struct buffer_entry *be;
@@ -1742,7 +1742,7 @@ multi_client_connect_mda(struct multi_context *m,
 
         ret = CC_RET_SUCCEEDED;
     }
-#endif /* ifdef MANAGEMENT_DEF_AUTH */
+#endif /* ifdef ENABLE_MANAGEMENT */
     return ret;
 }
 
@@ -2699,7 +2699,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
     update_mstat_n_clients(m->n_clients);
     --mi->n_clients_delta;
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     if (management)
     {
         management_connection_established(management,
@@ -2922,7 +2922,7 @@ multi_schedule_context_wakeup(struct multi_context *m, struct multi_instance *mi
                        compute_wakeup_sigma(&mi->context.c2.timeval));
 }
 
-#if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
+#if defined(ENABLE_ASYNC_PUSH)
 static void
 add_inotify_file_watch(struct multi_context *m, struct multi_instance *mi,
                        int inotify_fd, const char *file)
@@ -2946,7 +2946,7 @@ add_inotify_file_watch(struct multi_context *m, struct multi_instance *mi,
         msg(M_NONFATAL | M_ERRNO, "MULTI: inotify_add_watch error");
     }
 }
-#endif /* if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH) */
+#endif /* if defined(ENABLE_ASYNC_PUSH) */
 
 /*
  * Figure instance-specific timers, convert
@@ -2962,7 +2962,7 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
 
     if (!IS_SIG(&mi->context) && ((flags & MPP_PRE_SELECT) || ((flags & MPP_CONDITIONAL_PRE_SELECT) && !ANY_OUT(&mi->context))))
     {
-#if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
+#if defined(ENABLE_ASYNC_PUSH)
         bool was_unauthenticated = true;
         struct key_state *ks = NULL;
         if (mi->context.c2.tls_multi)
@@ -2976,7 +2976,7 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
          * to_link packets (such as ping or TLS control) */
         pre_select(&mi->context);
 
-#if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
+#if defined(ENABLE_ASYNC_PUSH)
         /*
          * if we see the state transition from unauthenticated to deferred
          * and an auth_control_file, we assume it got just added and add
@@ -2999,7 +2999,7 @@ multi_process_post(struct multi_context *m, struct multi_instance *mi, const uns
             {
                 multi_connection_established(m, mi);
             }
-#if defined(ENABLE_ASYNC_PUSH) && defined(ENABLE_DEF_AUTH)
+#if defined(ENABLE_ASYNC_PUSH)
             if (is_cas_pending(mi->context.c2.context_auth)
                 && mi->client_connect_defer_state.deferred_ret_file)
             {
@@ -3111,7 +3111,7 @@ multi_process_float(struct multi_context *m, struct multi_instance *mi)
     ASSERT(hash_add(m->hash, &mi->real, mi, false));
     ASSERT(hash_add(m->iter, &mi->real, mi, false));
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     ASSERT(hash_add(m->cid_hash, &mi->context.c2.mda_context.cid, mi, true));
 #endif
 
@@ -3885,7 +3885,7 @@ management_delete_event(void *arg, event_t event)
 
 #endif /* ifdef ENABLE_MANAGEMENT */
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
 
 static struct multi_instance *
 lookup_by_cid(struct multi_context *m, const unsigned long cid)
@@ -3999,7 +3999,7 @@ management_get_peer_info(void *arg, const unsigned long cid)
     return ret;
 }
 
-#endif /* ifdef MANAGEMENT_DEF_AUTH */
+#endif /* ifdef ENABLE_MANAGEMENT */
 
 #ifdef MANAGEMENT_PF
 static bool
@@ -4040,12 +4040,10 @@ init_management_callback_multi(struct multi_context *m)
         cb.kill_by_addr = management_callback_kill_by_addr;
         cb.delete_event = management_delete_event;
         cb.n_clients = management_callback_n_clients;
-#ifdef MANAGEMENT_DEF_AUTH
         cb.kill_by_cid = management_kill_by_cid;
         cb.client_auth = management_client_auth;
         cb.client_pending_auth = management_client_pending_auth;
         cb.get_peer_info = management_get_peer_info;
-#endif
 #ifdef MANAGEMENT_PF
         cb.client_pf = management_client_pf;
 #endif
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 40e808ab..7669508c 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -123,7 +123,7 @@ struct multi_instance {
 
     bool did_real_hash;
     bool did_iter;
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     bool did_cid_hash;
     struct buffer_list *cc_config;
 #endif
@@ -185,7 +185,7 @@ struct multi_context {
     int status_file_version;
     int n_clients; /* current number of authenticated clients */
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     struct hash *cid_hash;
     unsigned long cid_counter;
 #endif
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index a7b59774..4ca89ba9 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -479,7 +479,7 @@ struct context_2
     struct pf_context pf;
 #endif
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     struct man_def_auth_context mda_context;
 #endif
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4e19d7cb..21f8d494 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -390,11 +390,9 @@ static const char usage_message[] =
     "--management-client-group g : When management interface is a unix socket, only\n"
     "                              allow connections from group g.\n"
 #endif
-#ifdef MANAGEMENT_DEF_AUTH
     "--management-client-auth : gives management interface client the responsibility\n"
     "                           to authenticate clients after their client certificate\n"
     "			      has been verified.\n"
-#endif
 #ifdef MANAGEMENT_PF
     "--management-client-pf : management interface clients must specify a packet\n"
     "                         filter file for each connecting client.\n"
@@ -5438,14 +5436,12 @@ add_option(struct options *options,
         options->management_flags |= MF_EXTERNAL_CERT;
         options->management_certificate = p[1];
     }
-#endif /* ifdef ENABLE_MANAGEMENT */
-#ifdef MANAGEMENT_DEF_AUTH
     else if (streq(p[0], "management-client-auth") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->management_flags |= MF_CLIENT_AUTH;
     }
-#endif
+#endif /* ifdef ENABLE_MANAGEMENT */
 #ifdef MANAGEMENT_PF
     else if (streq(p[0], "management-client-pf") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 5d977793..5b6d9441 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -722,7 +722,7 @@ struct options
 #define PLUGIN_OPTION_LIST(opt) (NULL)
 #endif
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
 #define MAN_CLIENT_AUTH_ENABLED(opt) ((opt)->management_flags & MF_CLIENT_AUTH)
 #else
 #define MAN_CLIENT_AUTH_ENABLED(opt) (false)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 17bba948..19004077 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -219,7 +219,7 @@ receive_cr_response(struct context *c, const struct buffer *buffer)
     {
         m = BSTR(&buf);
     }
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
     struct man_def_auth_context *mda = session->opt->mda_context;
     struct env_set *es = session->opt->es;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 87b51d96..fb1edd6e 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -937,7 +937,7 @@ key_state_init(struct tls_session *session, struct key_state *ks)
 
     ks->crypto_options.pid_persist = NULL;
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     ks->mda_key_id = session->opt->mda_context->mda_key_id_counter++;
 #endif
 }
@@ -1021,7 +1021,7 @@ tls_session_user_pass_enabled(struct tls_session *session)
 {
     return (session->opt->auth_user_pass_verify_script
             || plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY)
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
             || management_enable_def_auth(management)
 #endif
             );
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 53f74cac..810aba95 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -206,15 +206,13 @@ struct key_state
     enum ks_auth_state authenticated;
     time_t auth_deferred_expire;
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     unsigned int mda_key_id;
     unsigned int mda_status;
 #endif
-#ifdef PLUGIN_DEF_AUTH
     unsigned int auth_control_status;
     time_t acf_last_mod;
     char *auth_control_file;
-#endif
 };
 
 /** Control channel wrapping (--tls-auth/--tls-crypt) context */
@@ -353,7 +351,7 @@ struct tls_options
 #define SSLF_TLS_VERSION_MAX_MASK     0xF  /* (uses bit positions 10 to 13) */
     unsigned int ssl_flags;
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     struct man_def_auth_context *mda_context;
 #endif
 
@@ -536,10 +534,8 @@ struct tls_multi
     char *locked_username;
     struct cert_hash_set *locked_cert_hash_set;
 
-#ifdef ENABLE_DEF_AUTH
     /* Time of last call to tls_authentication_status */
     time_t tas_last;
-#endif
 
     /*
      * An error message to send to client on AUTH_FAILED
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 2d7abdde..acc788fc 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -829,14 +829,12 @@ cleanup:
 * user/password authentication.
 *************************************************************************** */
 
-#ifdef ENABLE_DEF_AUTH
 /* key_state_test_auth_control_file return values,
  * NOTE: acf_merge indexing depends on these values */
 #define ACF_UNDEFINED 0
 #define ACF_SUCCEEDED 1
 #define ACF_DISABLED  2
 #define ACF_FAILED    3
-#endif
 
 void
 auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
@@ -852,7 +850,7 @@ auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
     }
 }
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
 
 static inline unsigned int
 man_def_auth_test(const struct key_state *ks)
@@ -866,9 +864,8 @@ man_def_auth_test(const struct key_state *ks)
         return ACF_DISABLED;
     }
 }
-#endif /* ifdef MANAGEMENT_DEF_AUTH */
+#endif /* ifdef ENABLE_MANAGEMENT */
 
-#ifdef PLUGIN_DEF_AUTH
 
 /*
  * auth_control_file functions
@@ -931,8 +928,6 @@ key_state_test_auth_control_file(struct key_state *ks)
     return ACF_DISABLED;
 }
 
-#endif /* ifdef PLUGIN_DEF_AUTH */
-
 /*
  * Return current session authentication state.  Return
  * value is TLS_AUTHENTICATION_x.
@@ -945,7 +940,6 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
     bool success = false;
     bool active = false;
 
-#ifdef ENABLE_DEF_AUTH
     static const unsigned char acf_merge[] =
     {
         ACF_UNDEFINED, /* s1=ACF_UNDEFINED s2=ACF_UNDEFINED */
@@ -965,19 +959,16 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
         ACF_FAILED,  /* s1=ACF_FAILED    s2=ACF_DISABLED */
         ACF_FAILED   /* s1=ACF_FAILED    s2=ACF_FAILED */
     };
-#endif /* ENABLE_DEF_AUTH */
 
     if (multi)
     {
         int i;
 
-#ifdef ENABLE_DEF_AUTH
         if (latency && multi->tas_last && multi->tas_last + latency >= now)
         {
             return TLS_AUTHENTICATION_UNDEFINED;
         }
         multi->tas_last = now;
-#endif /* ENABLE_DEF_AUTH */
 
         for (i = 0; i < KEY_SCAN_SIZE; ++i)
         {
@@ -987,15 +978,12 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
                 active = true;
                 if (ks->authenticated > KS_AUTH_FALSE)
                 {
-#ifdef ENABLE_DEF_AUTH
                     unsigned int s1 = ACF_DISABLED;
                     unsigned int s2 = ACF_DISABLED;
-#ifdef PLUGIN_DEF_AUTH
                     s1 = key_state_test_auth_control_file(ks);
-#endif /* PLUGIN_DEF_AUTH */
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
                     s2 = man_def_auth_test(ks);
-#endif /* MANAGEMENT_DEF_AUTH */
+#endif
                     ASSERT(s1 < 4 && s2 < 4);
                     switch (acf_merge[(s1<<2) + s2])
                     {
@@ -1019,9 +1007,6 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
                         default:
                             ASSERT(0);
                     }
-#else /* !ENABLE_DEF_AUTH */
-                    success = true;
-#endif /* ENABLE_DEF_AUTH */
                 }
             }
         }
@@ -1045,7 +1030,7 @@ tls_authentication_status(struct tls_multi *multi, const int latency)
     }
 }
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
 /*
  * For deferred auth, this is where the management interface calls (on server)
  * to indicate auth failure/success.
@@ -1070,7 +1055,7 @@ tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, con
     }
     return ret;
 }
-#endif /* ifdef MANAGEMENT_DEF_AUTH */
+#endif /* ifdef ENABLE_MANAGEMENT */
 
 
 /* ****************************************************************************
@@ -1159,14 +1144,11 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
                         const struct user_pass *up)
 {
     int retval = OPENVPN_PLUGIN_FUNC_ERROR;
-#ifdef PLUGIN_DEF_AUTH
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
-#endif
 
     /* set password in private env space */
     setenv_str(session->opt->es, "password", up->password);
 
-#ifdef PLUGIN_DEF_AUTH
     /* generate filename for deferred auth control file */
     if (!key_state_gen_auth_control_file(ks, session->opt))
     {
@@ -1174,18 +1156,15 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
             "could not create deferred auth control file", __func__);
         return retval;
     }
-#endif
 
     /* call command */
     retval = plugin_call(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY, NULL, NULL, session->opt->es);
 
-#ifdef PLUGIN_DEF_AUTH
     /* purge auth control filename (and file itself) for non-deferred returns */
     if (retval != OPENVPN_PLUGIN_FUNC_DEFERRED)
     {
         key_state_rm_auth_control_file(ks);
     }
-#endif
 
     setenv_del(session->opt->es, "password");
 
@@ -1193,9 +1172,9 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
 }
 
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
 /*
- * MANAGEMENT_DEF_AUTH internal ssl_verify.c status codes
+ * management deferred internal ssl_verify.c status codes
  */
 #define KMDA_ERROR   0
 #define KMDA_SUCCESS 1
@@ -1224,7 +1203,7 @@ verify_user_pass_management(struct tls_session *session,
 
     return retval;
 }
-#endif /* ifdef MANAGEMENT_DEF_AUTH */
+#endif /* ifdef ENABLE_MANAGEMENT */
 
 static bool
 set_verify_user_pass_env(struct user_pass *up, struct tls_multi *multi,
@@ -1269,7 +1248,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     bool s2 = true;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
     int man_def_auth = KMDA_UNDEF;
 
     if (management_enable_def_auth(management))
@@ -1336,7 +1315,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     /* call plugin(s) and/or script */
     if (!skip_auth)
     {
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
         if (man_def_auth==KMDA_DEF)
         {
             man_def_auth = verify_user_pass_management(session, multi, up);
@@ -1364,23 +1343,19 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     }
     /* auth succeeded? */
     if ((s1 == OPENVPN_PLUGIN_FUNC_SUCCESS
-#ifdef PLUGIN_DEF_AUTH
          || s1 == OPENVPN_PLUGIN_FUNC_DEFERRED
-#endif
          ) && s2
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
         && man_def_auth != KMDA_ERROR
 #endif
         && tls_lock_username(multi, up->username))
     {
         ks->authenticated = KS_AUTH_TRUE;
-#ifdef PLUGIN_DEF_AUTH
         if (s1 == OPENVPN_PLUGIN_FUNC_DEFERRED)
         {
             ks->authenticated = KS_AUTH_DEFERRED;
         }
-#endif
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
         if (man_def_auth != KMDA_UNDEF)
         {
             ks->authenticated = KS_AUTH_DEFERRED;
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index b1ced956..d913f102 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -221,7 +221,7 @@ struct x509_track
 /*
  * TODO: document
  */
-#ifdef MANAGEMENT_DEF_AUTH
+#ifdef ENABLE_MANAGEMENT
 bool tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id, const bool auth, const char *client_reason);
 
 #endif
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 8342eae0..2ad5afc2 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -530,19 +530,6 @@ socket_defined(const socket_descriptor_t sd)
 #define PORT_SHARE 0
 #endif
 
-/*
- * Enable deferred authentication?
- */
-#if defined(ENABLE_DEF_AUTH) && defined(ENABLE_PLUGIN)
-#define PLUGIN_DEF_AUTH
-#endif
-#if defined(ENABLE_DEF_AUTH) && defined(ENABLE_MANAGEMENT)
-#define MANAGEMENT_DEF_AUTH
-#endif
-#if !defined(PLUGIN_DEF_AUTH) && !defined(MANAGEMENT_DEF_AUTH)
-#undef ENABLE_DEF_AUTH
-#endif
-
 #ifdef ENABLE_CRYPTO_MBEDTLS
 #define ENABLE_PREDICTION_RESISTANCE
 #endif /* ENABLE_CRYPTO_MBEDTLS */
@@ -553,7 +540,7 @@ socket_defined(const socket_descriptor_t sd)
 #if defined(ENABLE_PF) && defined(ENABLE_PLUGIN) && defined(HAVE_STAT)
 #define PLUGIN_PF
 #endif
-#if defined(ENABLE_PF) && defined(MANAGEMENT_DEF_AUTH)
+#if defined(ENABLE_PF) && defined(ENABLE_MANAGEMENT)
 #define MANAGEMENT_PF
 #endif
 #if !defined(PLUGIN_PF) && !defined(MANAGEMENT_PF)
-- 
2.26.2


