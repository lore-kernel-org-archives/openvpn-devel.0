From: Arne Schwabe <arne@...1227...>
Date: Sun,  4 Apr 2021 13:06:02 +0200
Message-Id: <20210404110602.20374-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH v3] Remove conditionals compilation for P2MP,
 ENABLE_SHAPER and TIME_BACKTRACK_PROTECTION
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
Cc: Gert Doering <gert@...1296...>

Using OpenVPN without P2MP support (pull, TLS) is unrealistic and
building a binary without it is not something we realistically want
to support anyway.  Building P2MP support currently only depended
on HAVE_GETTIMEOFDAY or _WIN32, which has a compat function for it.
So we basically can assume that gettimeofday is always availabe,
either natively or through our compat function.

Remove all the #ifdef P2MP logic, simplify code and reduce maintenance
effort.

This also removes the ENABLE_SHAPER and TIME_BACKTRACK_PROTECTION
defines, which also depended only on the HAVE_GETTIMEOFDAY or _WIN32.

I kept the configure.ac check and ifdef in compat since mingw actually
provides a gettimeofday and we will use that instead of our own compat
function.

Patch V2: Remove dco parts that slipped into the patch, mention the
          other removed defines that are always enabled.

Patch V3: Also remove the TIME_BACKTRACK_PROTECTION defines from otime.h

Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20210403184626.23067-1-arne@...1227...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg22020.html
Signed-off-by: Gert Doering <gert@...1296...>
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/compat/compat-gettimeofday.c |  2 +-
 src/openvpn/forward.c            | 23 ++------------
 src/openvpn/forward.h            |  6 ----
 src/openvpn/helper.c             | 10 ++----
 src/openvpn/init.c               | 28 -----------------
 src/openvpn/manage.c             |  4 ---
 src/openvpn/mbuf.c               |  3 --
 src/openvpn/mbuf.h               |  3 --
 src/openvpn/openvpn.h            |  7 -----
 src/openvpn/options.c            | 54 ++++----------------------------
 src/openvpn/options.h            | 21 -------------
 src/openvpn/otime.c              |  4 ---
 src/openvpn/otime.h              | 34 --------------------
 src/openvpn/pool.c               |  4 ---
 src/openvpn/pool.h               |  3 --
 src/openvpn/push.c               |  3 --
 src/openvpn/push.h               |  3 --
 src/openvpn/pushlist.h           |  4 +--
 src/openvpn/route.h              |  2 --
 src/openvpn/shaper.c             |  3 --
 src/openvpn/shaper.h             |  4 ---
 src/openvpn/syshead.h            | 32 -------------------
 22 files changed, 14 insertions(+), 243 deletions(-)

diff --git a/src/compat/compat-gettimeofday.c b/src/compat/compat-gettimeofday.c
index 117aee7d7..e63c8d7f8 100644
--- a/src/compat/compat-gettimeofday.c
+++ b/src/compat/compat-gettimeofday.c
@@ -93,7 +93,7 @@ gettimeofday(struct timeval *tv, void *tz)
     {
         /* We try to dampen out backtracks of less than backtrack_hold_seconds.
          * Larger backtracks will be passed through and dealt with by the
-         * TIME_BACKTRACK_PROTECTION code (if enabled) */
+         * TIME_BACKTRACK_PROTECTION code */
         if (sec > last_sec - backtrack_hold_seconds)
         {
             sec = last_sec;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6f7a50048..29b52b8dd 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -189,8 +189,6 @@ check_tls_errors_nco(struct context *c)
     register_signal(c, c->c2.tls_exit_signal, "tls-error"); /* SOFT-SIGUSR1 -- TLS error */
 }
 
-#if P2MP
-
 /*
  * Handle incoming configuration
  * messages on the control channel.
@@ -269,8 +267,6 @@ check_push_request(struct context *c)
     event_timeout_modify_wakeup(&c->c2.push_request_interval, PUSH_REQUEST_INTERVAL);
 }
 
-#endif /* P2MP */
-
 /*
  * Things that need to happen immediately after connection initiation should go here.
  *
@@ -286,7 +282,6 @@ check_connection_established(struct context *c)
 
     if (CONNECTION_ESTABLISHED(c))
     {
-#if P2MP
         /* if --pull was specified, send a push request to server */
         if (c->c2.tls_multi && c->options.pull)
         {
@@ -313,7 +308,6 @@ check_connection_established(struct context *c)
             reset_coarse_timers(c);
         }
         else
-#endif /* if P2MP */
         {
             do_up(c, false, 0);
         }
@@ -428,7 +422,6 @@ get_server_poll_remaining_time(struct event_timeout *server_poll_timeout)
     int remaining = event_timeout_remaining(server_poll_timeout);
     return max_int(0, remaining);
 }
-#if P2MP
 
 void
 check_server_poll_timeout(struct context *c)
@@ -466,8 +459,6 @@ check_scheduled_exit(struct context *c)
     register_signal(c, c->c2.scheduled_exit_signal, "delayed-exit");
 }
 
-#endif /* if P2MP */
-
 /*
  * Should we write timer-triggered status file.
  */
@@ -635,13 +626,12 @@ process_coarse_timers(struct context *c)
     {
         check_connection_established(c);
     }
-#if P2MP
+
     /* see if we should send a push_request (option --pull) */
     if (event_timeout_trigger(&c->c2.push_request_interval, &c->c2.timeval, ETT_DEFAULT))
     {
         check_push_request(c);
     }
-#endif
 
 #ifdef PLUGIN_PF
     if (c->c2.pf.enabled
@@ -676,7 +666,6 @@ process_coarse_timers(struct context *c)
         return;
     }
 
-#if P2MP
     if (c->c2.tls_multi)
     {
         if (c->options.ce.connect_timeout
@@ -697,7 +686,6 @@ process_coarse_timers(struct context *c)
             return;
         }
     }
-#endif
 
     /* Should we send an OCC_REQUEST message? */
     check_send_occ_req(c);
@@ -1583,13 +1571,12 @@ process_outgoing_link(struct context *c)
              * Let the traffic shaper know how many bytes
              * we wrote.
              */
-#ifdef ENABLE_FEATURE_SHAPER
             if (c->options.shaper)
             {
                 shaper_wrote_bytes(&c->c2.shaper, BLEN(&c->c2.to_link)
                                    + datagram_overhead(c->options.ce.proto));
             }
-#endif
+
             /*
              * Let the pinger know that we sent a packet.
              */
@@ -1843,14 +1830,12 @@ pre_select(struct context *c)
         return;
     }
 
-#if P2MP
     /* check for incoming control messages on the control channel like
      * push request/reply, or authentication failure and 2FA messages */
     if (tls_test_payload_len(c->c2.tls_multi) > 0)
     {
         check_incoming_control_channel(c);
     }
-#endif
 
     /* Should we send an OCC message? */
     check_send_occ_msg(c);
@@ -1919,7 +1904,6 @@ io_wait_dowork(struct context *c, const unsigned int flags)
              * quota, don't send -- instead compute the delay we must wait
              * until it will be OK to send the packet.
              */
-#ifdef ENABLE_FEATURE_SHAPER
             int delay = 0;
 
             /* set traffic shaping delay in microseconds */
@@ -1936,9 +1920,6 @@ io_wait_dowork(struct context *c, const unsigned int flags)
             {
                 shaper_soonest_event(&c->c2.timeval, delay);
             }
-#else /* ENABLE_FEATURE_SHAPER */
-            socket |= EVENT_WRITE;
-#endif /* ENABLE_FEATURE_SHAPER */
         }
         else
         {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 9ce3bc1c7..2a67c1445 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -74,15 +74,12 @@ void check_tls_errors_co(struct context *c);
 
 void check_tls_errors_nco(struct context *c);
 
-#if P2MP
 void check_incoming_control_channel(struct context *c);
 
 void check_scheduled_exit(struct context *c);
 
 void check_push_request(struct context *c);
 
-#endif /* P2MP */
-
 #ifdef ENABLE_FRAGMENT
 void check_fragment(struct context *c);
 
@@ -336,11 +333,8 @@ void reschedule_multi_process(struct context *c);
 
 void process_ip_header(struct context *c, unsigned int flags, struct buffer *buf);
 
-#if P2MP
 void schedule_exit(struct context *c, const int n_seconds, const int signal);
 
-#endif
-
 static inline struct link_socket_info *
 get_link_socket_info(struct context *c)
 {
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index a1d030706..4fbbced78 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -149,11 +149,9 @@ helper_client_server(struct options *o)
 {
     struct gc_arena gc = gc_new();
 
-#if P2MP
-
-/*
- * Get tun/tap/null device type
- */
+    /*
+     * Get tun/tap/null device type
+     */
     const int dev = dev_type_enum(o->dev, o->dev_type);
     const int topology = o->topology;
 
@@ -494,8 +492,6 @@ helper_client_server(struct options *o)
         o->tls_client = true;
     }
 
-#endif /* P2MP */
-
     gc_free(&gc);
 }
 
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 04a7dcc83..28d183aa0 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -192,7 +192,6 @@ run_up_down(const char *command,
 static void
 update_options_ce_post(struct options *options)
 {
-#if P2MP
     /*
      * In pull mode, we usually import --ping/--ping-restart parameters from
      * the server.  However we should also set an initial default --ping-restart
@@ -206,7 +205,6 @@ update_options_ce_post(struct options *options)
         options->ping_rec_timeout = PRE_PULL_INITIAL_PING_RESTART;
         options->ping_rec_timeout_action = PING_RESTART;
     }
-#endif
 }
 
 #ifdef ENABLE_MANAGEMENT
@@ -592,7 +590,6 @@ init_query_passwords(const struct context *c)
         pem_password_setup(c->options.key_pass_file);
     }
 
-#if P2MP
     /* Auth user/pass input */
     if (c->options.auth_user_pass_file)
     {
@@ -602,7 +599,6 @@ init_query_passwords(const struct context *c)
         auth_user_pass_setup(c->options.auth_user_pass_file, NULL);
 #endif
     }
-#endif
 }
 
 /*
@@ -1446,14 +1442,12 @@ do_init_timers(struct context *c, bool deferred)
 static void
 do_init_traffic_shaper(struct context *c)
 {
-#ifdef ENABLE_FEATURE_SHAPER
     /* initialize traffic shaper (i.e. transmit bandwidth limiter) */
     if (c->options.shaper)
     {
         shaper_init(&c->c2.shaper, c->options.shaper);
         shaper_msg(&c->c2.shaper);
     }
-#endif
 }
 
 /*
@@ -1978,9 +1972,7 @@ do_close_tun_simple(struct context *c)
         c->c1.tuntap = NULL;
     }
     c->c1.tuntap_owned = false;
-#if P2MP
     CLEAR(c->c1.pulled_options_digest_save);
-#endif
 }
 
 static void
@@ -2131,7 +2123,6 @@ tun_abort(void)
  * Handle delayed tun/tap interface bringup due to --up-delay or --pull
  */
 
-#if P2MP
 /**
  * Helper for do_up().  Take two option hashes and return true if they are not
  * equal, or either one is all-zeroes.
@@ -2144,7 +2135,6 @@ options_hash_changed_or_zero(const struct sha256_digest *a,
     return memcmp(a, b, sizeof(struct sha256_digest))
            || !memcmp(a, &zero, sizeof(struct sha256_digest));
 }
-#endif /* P2MP */
 
 bool
 do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
@@ -2168,7 +2158,6 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
             c->c2.did_open_tun = do_open_tun(c);
             update_time();
 
-#if P2MP
             /*
              * Was tun interface object persisted from previous restart iteration,
              * and if so did pulled options string change from previous iteration?
@@ -2186,14 +2175,11 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
                 c->c2.did_open_tun = do_open_tun(c);
                 update_time();
             }
-#endif
         }
 
         if (c->c2.did_open_tun)
         {
-#if P2MP
             c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
-#endif
 
             /* if --route-delay was specified, start timer */
             if ((route_order() == ROUTE_AFTER_TUN) && c->options.route_delay_defined)
@@ -2432,12 +2418,10 @@ socket_restart_pause(struct context *c)
     }
 #endif
 
-#if P2MP
     if (auth_retry_get() == AR_NOINTERACT)
     {
         sec = 10;
     }
-#endif
 
     /* Slow down reconnection after 5 retries per remote -- for tcp only in client mode */
     if (c->options.ce.proto != PROTO_TCP_SERVER)
@@ -2721,7 +2705,6 @@ do_init_crypto_tls_c1(struct context *c)
         init_ssl(options, &(c->c1.ks.ssl_ctx));
         if (!tls_ctx_initialised(&c->c1.ks.ssl_ctx))
         {
-#if P2MP
             switch (auth_retry_get())
             {
                 case AR_NONE:
@@ -2740,9 +2723,6 @@ do_init_crypto_tls_c1(struct context *c)
             }
             c->sig->signal_text = "private-key-password-failure";
             return;
-#else  /* if P2MP */
-            msg(M_FATAL, "Error: private key password verification failed");
-#endif /* if P2MP */
         }
 
        /*
@@ -2959,11 +2939,9 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
 
     to.x509_track = options->x509_track;
 
-#if P2MP
 #ifdef ENABLE_MANAGEMENT
     to.sci = &options->sc_info;
 #endif
-#endif
 
 #ifdef USE_COMP
     to.comp_options = options->comp;
@@ -3228,7 +3206,6 @@ do_option_warnings(struct context *c)
         msg(M_WARN, "WARNING: you are using chroot without specifying user and group -- this may cause the chroot jail to be insecure");
     }
 
-#if P2MP
     if (o->pull && o->ifconfig_local && c->first_time)
     {
         msg(M_WARN, "WARNING: using --pull/--client and --ifconfig together is probably not what you want");
@@ -3254,7 +3231,6 @@ do_option_warnings(struct context *c)
             msg(M_WARN, "WARNING: --keepalive option is missing from server config");
         }
     }
-#endif /* if P2MP */
 
     if (!o->replay)
     {
@@ -3736,13 +3712,11 @@ do_setup_fast_io(struct context *c)
         }
         else
         {
-#ifdef ENABLE_FEATURE_SHAPER
             if (c->options.shaper)
             {
                 msg(M_INFO, "NOTE: --fast-io is disabled since we are using --shaper");
             }
             else
-#endif
             {
                 c->c2.fast_io = true;
             }
@@ -4106,13 +4080,11 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         platform_mlockall(true);
     }
 
-#if P2MP
     /* get passwords if undefined */
     if (auth_retry_get() == AR_INTERACT)
     {
         init_query_passwords(c);
     }
-#endif
 
     /* initialize context level 2 --verb/--mute parms */
     init_verb_mute(c, IVM_LEVEL_2);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index df987f53c..7e61061ab 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -1416,7 +1416,6 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
     }
     else if (streq(p[0], "auth-retry"))
     {
-#if P2MP
         if (p[1])
         {
             if (auth_retry_set(M_CLIENT, p[1]))
@@ -1432,9 +1431,6 @@ man_dispatch_command(struct management *man, struct status_output *so, const cha
         {
             msg(M_CLIENT, "SUCCESS: auth-retry=%s", auth_retry_print());
         }
-#else  /* if P2MP */
-        msg(M_CLIENT, "ERROR: auth-retry feature is unavailable");
-#endif
     }
     else if (streq(p[0], "state"))
     {
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 76f478b8c..6b7db6501 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -29,8 +29,6 @@
 
 #include "syshead.h"
 
-#if P2MP
-
 #include "buffer.h"
 #include "error.h"
 #include "integer.h"
@@ -171,4 +169,3 @@ mbuf_dereference_instance(struct mbuf_set *ms, struct multi_instance *mi)
         }
     }
 }
-#endif /* P2MP */
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index f37563dff..759546c6c 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -28,8 +28,6 @@
  * Handle both multicast and broadcast functions.
  */
 
-#if P2MP
-
 /* define this to enable special test mode */
 /*#define MBUF_TEST*/
 
@@ -111,5 +109,4 @@ mbuf_peek(struct mbuf_set *ms)
     }
 }
 
-#endif /* if P2MP */
 #endif /* ifndef MBUF_H */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 0ddaeb730..22d2447f6 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -189,7 +189,6 @@ struct context_1
     struct socks_proxy_info *socks_proxy;
     bool socks_proxy_owned;
 
-#if P2MP
     /* persist --ifconfig-pool db to file */
     struct ifconfig_pool_persist *ifconfig_pool_persist;
     bool ifconfig_pool_persist_owned;
@@ -203,7 +202,6 @@ struct context_1
     struct user_pass *auth_user_pass;
     /**< Username and password for
      *   authentication. */
-#endif
 };
 
 
@@ -278,12 +276,10 @@ struct context_2
     struct frame frame_fragment_omit;
 #endif
 
-#ifdef ENABLE_FEATURE_SHAPER
     /*
      * Traffic shaper object.
      */
     struct shaper shaper;
-#endif
 
     /*
      * Statistics
@@ -435,8 +431,6 @@ struct context_2
     /* don't wait for TUN/TAP/UDP to be ready to accept write */
     bool fast_io;
 
-#if P2MP
-
     /* --ifconfig endpoints to be pushed to client */
     bool push_request_received;
     bool push_ifconfig_defined;
@@ -463,7 +457,6 @@ struct context_2
 
     struct event_timeout scheduled_exit;
     int scheduled_exit_signal;
-#endif /* if P2MP */
 
     /* packet filter */
 #ifdef ENABLE_PF
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index eccb6c2e4..9e61b1e05 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -403,7 +403,6 @@ static const char usage_message[] =
     "--vlan-tagging  : Enable 802.1Q-based VLAN tagging.\n"
     "--vlan-accept tagged|untagged|all : Set VLAN tagging mode. Default is 'all'.\n"
     "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
-#if P2MP
     "\n"
     "Multi-Client Server options (when --mode server is used):\n"
     "--server network netmask : Helper option to easily configure server mode.\n"
@@ -508,7 +507,6 @@ static const char usage_message[] =
     "                  waiting for a response before trying the next server.\n"
     "--allow-recursive-routing : When this option is set, OpenVPN will not drop\n"
     "                  incoming tun packets with same destination as host.\n"
-#endif /* if P2MP */
     "--explicit-exit-notify [n] : On exit/restart, send exit signal to\n"
     "                  server/remote. n = # of retries, default=1.\n"
     "\n"
@@ -844,9 +842,7 @@ init_options(struct options *o, const bool init_gc)
     o->max_routes_per_client = 256;
     o->stale_routes_check_interval = 0;
     o->ifconfig_pool_persist_refresh_freq = 600;
-#if P2MP
     o->scheduled_exit_interval = 5;
-#endif
     o->ncp_enabled = true;
     o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
     o->authname = "SHA1";
@@ -1289,8 +1285,6 @@ print_vlan_accept(enum vlan_acceptable_frames mode)
     return NULL;
 }
 
-#if P2MP
-
 #ifndef ENABLE_SMALL
 
 static void
@@ -1418,7 +1412,6 @@ option_iroute_ipv6(struct options *o,
     ir->next = o->iroutes_ipv6;
     o->iroutes_ipv6 = ir;
 }
-#endif /* P2MP */
 
 #ifndef ENABLE_SMALL
 static void
@@ -1612,9 +1605,7 @@ show_settings(const struct options *o)
     SHOW_INT(ifconfig_ipv6_netbits);
     SHOW_STR(ifconfig_ipv6_remote);
 
-#ifdef ENABLE_FEATURE_SHAPER
     SHOW_INT(shaper);
-#endif
     SHOW_INT(mtu_test);
 
     SHOW_BOOL(mlock);
@@ -1839,9 +1830,7 @@ show_settings(const struct options *o)
     SHOW_BOOL(pkcs11_id_management);
 #endif                  /* ENABLE_PKCS11 */
 
-#if P2MP
     show_p2mp_parms(o);
-#endif
 
 #ifdef _WIN32
     SHOW_BOOL(show_net_up);
@@ -2101,9 +2090,7 @@ options_postprocess_verify_ce(const struct options *options,
     }
 
     /* will we be pulling options from server? */
-#if P2MP
     pull = options->pull;
-#endif
 
     /*
      * Sanity check on --local, --remote, and --ifconfig
@@ -2742,10 +2729,13 @@ options_postprocess_verify_ce(const struct options *options,
 
                 if (sum == 0)
                 {
-#if P2MP
                     if (!options->auth_user_pass_file)
-#endif
-                    msg(M_USAGE, "No client-side authentication method is specified.  You must use either --cert/--key, --pkcs12, or --auth-user-pass");
+                    {
+                        msg(M_USAGE, "No client-side authentication method is "
+                                     "specified.  You must use either "
+                                     "--cert/--key, --pkcs12, or "
+                                     "--auth-user-pass");
+                    }
                 }
                 else if (sum == 2)
                 {
@@ -2833,12 +2823,10 @@ options_postprocess_verify_ce(const struct options *options,
     }
 #undef MUST_BE_UNDEF
 
-#if P2MP
     if (options->auth_user_pass_file && !options->pull)
     {
         msg(M_USAGE, "--auth-user-pass requires --pull");
     }
-#endif
 
     uninit_options(&defaults);
 }
@@ -2856,7 +2844,6 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
         }
     }
 
-#if P2MP
     if (o->client)
     {
         if (ce->proto == PROTO_TCP)
@@ -2864,7 +2851,6 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
             ce->proto = PROTO_TCP_CLIENT;
         }
     }
-#endif
 
     if (ce->proto == PROTO_TCP_CLIENT && !ce->local
         && !ce->local_port_defined && !ce->bind_defined)
@@ -3217,12 +3203,10 @@ options_postprocess_mutate(struct options *o)
         o->verify_hash_no_ca = true;
     }
 
-#if P2MP
     /*
      * Save certain parms before modifying options via --pull
      */
     pre_pull_save(o);
-#endif
 }
 
 /*
@@ -3529,12 +3513,9 @@ options_postprocess_filechecks(struct options *options)
                               options->management_user_pass, R_OK,
                               "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
-#if P2MP
     errs |= check_file_access(CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
                               options->auth_user_pass_file, R_OK,
                               "--auth-user-pass");
-#endif /* P2MP */
-
     /* ** System related ** */
     errs |= check_file_access(CHKACC_FILE, options->chroot_dir,
                               R_OK|X_OK, "--chroot directory");
@@ -3575,8 +3556,6 @@ options_postprocess(struct options *options)
 #endif /* !ENABLE_SMALL */
 }
 
-#if P2MP
-
 /*
  * Save/Restore certain option defaults before --pull is applied.
  */
@@ -3675,7 +3654,6 @@ pre_pull_restore(struct options *o, struct gc_arena *gc)
     o->data_channel_use_ekm = false;
 }
 
-#endif /* if P2MP */
 /**
  * Calculate the link-mtu to advertise to our peer.  The actual value is not
  * relevant, because we will possibly perform data channel cipher negotiation
@@ -4301,8 +4279,6 @@ print_topology(const int topology)
     }
 }
 
-#if P2MP
-
 /*
  * Manage auth-retry variable
  */
@@ -4357,8 +4333,6 @@ auth_retry_print(void)
     }
 }
 
-#endif /* if P2MP */
-
 /*
  * Print the help message.
  */
@@ -5093,8 +5067,6 @@ options_string_import(struct options *options,
     read_config_string("[CONFIG-STRING]", options, config, msglevel, permission_mask, option_types_found, es);
 }
 
-#if P2MP
-
 #define VERIFY_PERMISSION(mask) {                                            \
         if (!verify_permission(p[0], file, line, (mask), permission_mask,        \
                                option_types_found, msglevel, options, is_inline)) \
@@ -5156,12 +5128,6 @@ verify_permission(const char *name,
     return true;
 }
 
-#else  /* if P2MP */
-
-#define VERIFY_PERMISSION(mask)
-
-#endif /* if P2MP */
-
 /*
  * Check that an option doesn't have too
  * many parameters.
@@ -6166,7 +6132,6 @@ add_option(struct options *options,
     }
     else if (streq(p[0], "shaper") && p[1] && !p[2])
     {
-#ifdef ENABLE_FEATURE_SHAPER
         int shaper;
 
         VERIFY_PERMISSION(OPT_P_SHAPER);
@@ -6178,11 +6143,6 @@ add_option(struct options *options,
             goto err;
         }
         options->shaper = shaper;
-#else /* ENABLE_FEATURE_SHAPER */
-        VERIFY_PERMISSION(OPT_P_GENERAL);
-        msg(msglevel, "--shaper requires the gettimeofday() function which is missing");
-        goto err;
-#endif /* ENABLE_FEATURE_SHAPER */
     }
     else if (streq(p[0], "port") && p[1] && !p[2])
     {
@@ -6760,7 +6720,6 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->occ = false;
     }
-#if P2MP
     else if (streq(p[0], "server") && p[1] && p[2] && !p[4])
     {
         const int lev = M_WARN;
@@ -7350,7 +7309,6 @@ add_option(struct options *options,
         }
     }
 #endif
-#endif /* if P2MP */
     else if (streq(p[0], "msg-channel") && p[1])
     {
 #ifdef _WIN32
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 0114ac3be..65e5ffccf 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -58,8 +58,6 @@
 
 extern const char title_string[];
 
-#if P2MP
-
 /* certain options are saved before --pull modifications are applied */
 struct options_pre_pull
 {
@@ -85,7 +83,6 @@ struct options_pre_pull
     int foreign_option_index;
 };
 
-#endif
 #if !defined(ENABLE_CRYPTO_OPENSSL) && !defined(ENABLE_CRYPTO_MBEDTLS)
 #error "At least one of OpenSSL or mbed TLS needs to be defined."
 #endif
@@ -271,9 +268,7 @@ struct options
     const char *ifconfig_ipv6_remote;
     bool ifconfig_noexec;
     bool ifconfig_nowarn;
-#ifdef ENABLE_FEATURE_SHAPER
     int shaper;
-#endif
 
     int proto_force;
 
@@ -409,10 +404,6 @@ struct options
     struct plugin_option_list *plugin_list;
 #endif
 
-
-
-#if P2MP
-
     /* the tmp dir is for now only used in the P2P server context */
     const char *tmp_dir;
     bool server_defined;
@@ -508,8 +499,6 @@ struct options
 #ifdef ENABLE_MANAGEMENT
     struct static_challenge_info sc_info;
 #endif
-#endif /* if P2MP */
-
     /* Cipher parms */
     const char *shared_secret_file;
     bool shared_secret_file_inline;
@@ -704,10 +693,8 @@ struct options
 
 #define OPT_P_DEFAULT   (~(OPT_P_INSTANCE|OPT_P_PULL_MODE))
 
-#if P2MP
 #define PULL_DEFINED(opt) ((opt)->pull)
 #define PUSH_DEFINED(opt) ((opt)->push_list)
-#endif
 
 #ifndef PULL_DEFINED
 #define PULL_DEFINED(opt) (false)
@@ -723,11 +710,7 @@ struct options
 #define ROUTE_OPTION_FLAGS(o) (0)
 #endif
 
-#ifdef ENABLE_FEATURE_SHAPER
 #define SHAPER_DEFINED(opt) ((opt)->shaper)
-#else
-#define SHAPER_DEFINED(opt) (false)
-#endif
 
 #ifdef ENABLE_PLUGIN
 #define PLUGIN_OPTION_LIST(opt) ((opt)->plugin_list)
@@ -846,8 +829,6 @@ const char *print_topology(const int topology);
  * Manage auth-retry variable
  */
 
-#if P2MP
-
 #define AR_NONE       0
 #define AR_INTERACT   1
 #define AR_NOINTERACT 2
@@ -858,8 +839,6 @@ bool auth_retry_set(const int msglevel, const char *option);
 
 const char *auth_retry_print(void);
 
-#endif
-
 void options_string_import(struct options *options,
                            const char *config,
                            const int msglevel,
diff --git a/src/openvpn/otime.c b/src/openvpn/otime.c
index 640168a97..a3ca3e59d 100644
--- a/src/openvpn/otime.c
+++ b/src/openvpn/otime.c
@@ -35,8 +35,6 @@
 
 time_t now = 0;            /* GLOBAL */
 
-#if TIME_BACKTRACK_PROTECTION
-
 static time_t now_adj = 0; /* GLOBAL */
 time_t now_usec = 0;       /* GLOBAL */
 
@@ -79,8 +77,6 @@ update_now_usec(struct timeval *tv)
     }
 }
 
-#endif /* TIME_BACKTRACK_PROTECTION */
-
 /*
  * Return a numerical string describing a struct timeval.
  */
diff --git a/src/openvpn/otime.h b/src/openvpn/otime.h
index 78d20ba80..af69b9db3 100644
--- a/src/openvpn/otime.h
+++ b/src/openvpn/otime.h
@@ -55,8 +55,6 @@ extern time_t now; /* updated frequently to time(NULL) */
 
 void time_test(void);
 
-#if TIME_BACKTRACK_PROTECTION
-
 void update_now(const time_t system_time);
 
 extern time_t now_usec;
@@ -88,38 +86,6 @@ update_time(void)
 #endif
 }
 
-#else /* !TIME_BACKTRACK_PROTECTION */
-
-static inline void
-update_time(void)
-{
-#if defined(_WIN32)
-    /* on _WIN32, gettimeofday is faster than time(NULL) */
-    struct timeval tv;
-    if (!gettimeofday(&tv, NULL))
-    {
-        if (tv.tv_sec != now)
-        {
-            now = tv.tv_sec;
-        }
-    }
-#else  /* if defined(_WIN32) */
-    const time_t real_time = time(NULL);
-    if (real_time != now)
-    {
-        now = real_time;
-    }
-#endif
-}
-
-static inline int
-openvpn_gettimeofday(struct timeval *tv, void *tz)
-{
-    return gettimeofday(tv, tz);
-}
-
-#endif /* TIME_BACKTRACK_PROTECTION */
-
 static inline time_t
 openvpn_time(time_t *t)
 {
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index ece0784ff..4a300abbc 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -37,8 +37,6 @@
 
 #include "memdbg.h"
 
-#if P2MP
-
 static void
 ifconfig_pool_entry_free(struct ifconfig_pool_entry *ipe, bool hard)
 {
@@ -835,5 +833,3 @@ ifconfig_pool_test(in_addr_t start, in_addr_t end)
 }
 
 #endif /* ifdef IFCONFIG_POOL_TEST */
-
-#endif /* if P2MP */
diff --git a/src/openvpn/pool.h b/src/openvpn/pool.h
index b06424c95..0e3055969 100644
--- a/src/openvpn/pool.h
+++ b/src/openvpn/pool.h
@@ -24,8 +24,6 @@
 #ifndef POOL_H
 #define POOL_H
 
-#if P2MP
-
 /*#define IFCONFIG_POOL_TEST*/
 
 #include "basic.h"
@@ -102,5 +100,4 @@ void ifconfig_pool_test(in_addr_t start, in_addr_t end);
 
 #endif
 
-#endif /* if P2MP */
 #endif /* ifndef POOL_H */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 18d7c1e00..47a67e503 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -39,8 +39,6 @@
 #include "memdbg.h"
 #include "ssl_util.h"
 
-#if P2MP
-
 static char push_reply_cmd[] = "PUSH_REPLY";
 
 /*
@@ -1053,4 +1051,3 @@ remove_iroutes_from_push_route_list(struct options *o)
         gc_free(&gc);
     }
 }
-#endif /* if P2MP */
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index bb787a62a..b6388fcd7 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -24,8 +24,6 @@
 #ifndef PUSH_H
 #define PUSH_H
 
-#if P2MP
-
 #include "forward.h"
 
 #define PUSH_MSG_ERROR            0
@@ -100,5 +98,4 @@ void send_push_reply_auth_token(struct tls_multi *multi);
 void
 receive_auth_pending(struct context *c, const struct buffer *buffer);
 
-#endif /* if P2MP */
 #endif /* ifndef PUSH_H */
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index 967eda22a..6e682684d 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -21,7 +21,7 @@
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#if !defined(PUSHLIST_H) && P2MP
+#if !defined(PUSHLIST_H)
 #define PUSHLIST_H
 
 /* parameters to be pushed to peer */
@@ -37,4 +37,4 @@ struct push_list {
     struct push_entry *tail;
 };
 
-#endif /* if !defined(PUSHLIST_H) && P2MP */
+#endif /* if !defined(PUSHLIST_H) */
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 7dd960914..935e14713 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -230,7 +230,6 @@ struct route_ipv6_list {
     struct gc_arena gc;
 };
 
-#if P2MP
 /* internal OpenVPN route */
 struct iroute {
     in_addr_t network;
@@ -243,7 +242,6 @@ struct iroute_ipv6 {
     unsigned int netbits;
     struct iroute_ipv6 *next;
 };
-#endif
 
 struct route_option_list *new_route_option_list(struct gc_arena *a);
 
diff --git a/src/openvpn/shaper.c b/src/openvpn/shaper.c
index 57a242416..ef1092383 100644
--- a/src/openvpn/shaper.c
+++ b/src/openvpn/shaper.c
@@ -31,8 +31,6 @@
 #include "shaper.h"
 #include "memdbg.h"
 
-#ifdef ENABLE_FEATURE_SHAPER
-
 /*
  * We want to wake up in delay microseconds.  If timeval is larger
  * than delay, set timeval to delay.
@@ -94,4 +92,3 @@ shaper_msg(struct shaper *s)
     msg(M_INFO, "Output Traffic Shaping initialized at %d bytes per second",
         s->bytes_per_second);
 }
-#endif /* ENABLE_FEATURE_SHAPER */
diff --git a/src/openvpn/shaper.h b/src/openvpn/shaper.h
index bcdb5e365..d9b9daf57 100644
--- a/src/openvpn/shaper.h
+++ b/src/openvpn/shaper.h
@@ -26,8 +26,6 @@
 
 /*#define SHAPER_DEBUG*/
 
-#ifdef ENABLE_FEATURE_SHAPER
-
 #include "basic.h"
 #include "integer.h"
 #include "misc.h"
@@ -173,6 +171,4 @@ shaper_change_pct(struct shaper *s, int pct)
 }
 #endif
 
-#endif /* ENABLE_FEATURE_SHAPER */
-
 #endif /* ifndef SHAPER_H */
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index cf9714593..de4fbbf94 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -405,13 +405,6 @@ typedef int MIB_TCP_STATE;
 #define PASSTOS_CAPABILITY 0
 #endif
 
-/*
- * Do we have nanoseconds gettimeofday?
- */
-#if defined(HAVE_GETTIMEOFDAY) || defined(_WIN32)
-#define HAVE_GETTIMEOFDAY_NANOSECONDS 1
-#endif
-
 /*
  * Do we have the capability to report extended socket errors?
  */
@@ -509,16 +502,6 @@ socket_defined(const socket_descriptor_t sd)
 #define ENABLE_FEATURE_EXECVE
 #endif
 
-/*
- * Do we have point-to-multipoint capability?
- */
-
-#if defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
-#define P2MP 1
-#else
-#define P2MP 0
-#endif
-
 /*
  * HTTPS port sharing capability
  */
@@ -596,21 +579,6 @@ socket_defined(const socket_descriptor_t sd)
 #define EPOLL 0
 #endif
 
-/*
- * Reduce sensitivity to system clock instability
- * and backtracks.
- */
-#if defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
-#define TIME_BACKTRACK_PROTECTION 1
-#endif
-
-/*
- * Enable traffic shaper.
- */
-#if defined(HAVE_GETTIMEOFDAY_NANOSECONDS)
-#define ENABLE_FEATURE_SHAPER 1
-#endif
-
 /*
  * Is non-blocking connect() supported?
  */
-- 
2.30.1


