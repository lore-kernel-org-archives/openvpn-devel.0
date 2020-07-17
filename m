From: Arne Schwabe <arne@...1227...>
Date: Fri, 17 Jul 2020 15:47:36 +0200
Message-Id: <20200717134739.21168-6-arne@...1227...>
In-Reply-To: <20200717134739.21168-1-arne@...1227...>
References: <20200717134739.21168-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 6/9] Remove ENABLE_OCC #define
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

Commit 037669f3dd already made occ being unconditionally on. This commit
only removes the #ifdefs

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/forward.c    |  8 --------
 src/openvpn/init.c       | 16 +---------------
 src/openvpn/occ.c        |  9 ---------
 src/openvpn/occ.h        |  3 ---
 src/openvpn/openvpn.h    |  7 +------
 src/openvpn/options.c    | 30 ------------------------------
 src/openvpn/options.h    |  8 --------
 src/openvpn/sig.c        |  6 ------
 src/openvpn/sig.h        |  3 ---
 src/openvpn/ssl.c        | 21 +--------------------
 src/openvpn/ssl_common.h |  4 ----
 src/openvpn/syshead.h    |  5 -----
 12 files changed, 3 insertions(+), 117 deletions(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 698451d1..3d462d0a 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -822,7 +822,6 @@ process_coarse_timers(struct context *c)
     }
 #endif
 
-#ifdef ENABLE_OCC
     /* Should we send an OCC_REQUEST message? */
     check_send_occ_req(c);
 
@@ -834,7 +833,6 @@ process_coarse_timers(struct context *c)
     {
         process_explicit_exit_notification_timer_wakeup(c);
     }
-#endif
 
     /* Should we ping the remote? */
     check_ping_send(c);
@@ -983,14 +981,12 @@ read_incoming_link(struct context *c)
             }
             else
             {
-#ifdef ENABLE_OCC
                 if (event_timeout_defined(&c->c2.explicit_exit_notification_interval))
                 {
                     msg(D_STREAM_ERRORS, "Connection reset during exit notification period, ignoring [%d]", status);
                     management_sleep(1);
                 }
                 else
-#endif
                 {
                     register_signal(c, SIGUSR1, "connection-reset"); /* SOFT-SIGUSR1 -- TCP connection reset */
                     msg(D_STREAM_ERRORS, "Connection reset, restarting [%d]", status);
@@ -1214,13 +1210,11 @@ process_incoming_link_part2(struct context *c, struct link_socket_info *lsi, con
             c->c2.buf.len = 0; /* drop packet */
         }
 
-#ifdef ENABLE_OCC
         /* Did we just receive an OCC packet? */
         if (is_occ_msg(&c->c2.buf))
         {
             process_received_occ_msg(c);
         }
-#endif
 
         buffer_turnover(orig_buf, &c->c2.to_tun, &c->c2.buf, &c->c2.buffers->read_link_buf);
 
@@ -1992,10 +1986,8 @@ pre_select(struct context *c)
     /* check for incoming configuration info on the control channel */
     check_incoming_control_channel(c);
 
-#ifdef ENABLE_OCC
     /* Should we send an OCC message? */
     check_send_occ_msg(c);
-#endif
 
 #ifdef ENABLE_FRAGMENT
     /* Should we deliver a datagram fragment to remote? */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b96d1471..1ea4735d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1419,7 +1419,6 @@ do_init_timers(struct context *c, bool deferred)
         /* initialize connection establishment timer */
         event_timeout_init(&c->c2.wait_for_connect, 1, now);
 
-#ifdef ENABLE_OCC
         /* initialize occ timers */
 
         if (c->options.occ
@@ -1433,7 +1432,6 @@ do_init_timers(struct context *c, bool deferred)
         {
             event_timeout_init(&c->c2.occ_mtu_load_test_interval, OCC_MTU_LOAD_INTERVAL_SECONDS, now);
         }
-#endif
 
         /* initialize packet_id persistence timer */
         if (c->options.packet_id_file)
@@ -2279,7 +2277,6 @@ do_deferred_options(struct context *c, const unsigned int found)
         msg(D_PUSH, "OPTIONS IMPORT: timers and/or timeouts modified");
     }
 
-#ifdef ENABLE_OCC
     if (found & OPT_P_EXPLICIT_NOTIFY)
     {
         if (!proto_is_udp(c->options.ce.proto) && c->options.ce.explicit_exit_notification)
@@ -2292,7 +2289,6 @@ do_deferred_options(struct context *c, const unsigned int found)
             msg(D_PUSH, "OPTIONS IMPORT: explicit notify parm(s) modified");
         }
     }
-#endif
 
 #ifdef USE_COMP
     if (found & OPT_P_COMP)
@@ -2901,9 +2897,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         to.xmit_hold = true;
     }
 
-#ifdef ENABLE_OCC
     to.disable_occ = !options->occ;
-#endif
 
     to.verify_command = options->tls_verify;
     to.verify_export_cert = options->tls_export_cert;
@@ -3193,7 +3187,7 @@ do_init_frame(struct context *c)
     c->c2.frame_fragment_initial = c->c2.frame_fragment;
 #endif
 
-#if defined(ENABLE_FRAGMENT) && defined(ENABLE_OCC)
+#if defined(ENABLE_FRAGMENT)
     /*
      * MTU advisories
      */
@@ -3478,7 +3472,6 @@ do_print_data_channel_mtu_parms(struct context *c)
 #endif
 }
 
-#ifdef ENABLE_OCC
 /*
  * Get local and remote options compatibility strings.
  */
@@ -3510,7 +3503,6 @@ do_compute_occ_strings(struct context *c)
 
     gc_free(&gc);
 }
-#endif /* ifdef ENABLE_OCC */
 
 /*
  * These things can only be executed once per program instantiation.
@@ -3586,7 +3578,6 @@ do_close_tls(struct context *c)
         c->c2.tls_multi = NULL;
     }
 
-#ifdef ENABLE_OCC
     /* free options compatibility strings */
     if (c->c2.options_string_local)
     {
@@ -3597,7 +3588,6 @@ do_close_tls(struct context *c)
         free(c->c2.options_string_remote);
     }
     c->c2.options_string_local = c->c2.options_string_remote = NULL;
-#endif
 
     if (c->c2.pulled_options_state)
     {
@@ -4256,13 +4246,11 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
         do_open_ifconfig_pool_persist(c);
     }
 
-#ifdef ENABLE_OCC
     /* reset OCC state */
     if (c->mode == CM_P2P || child)
     {
         c->c2.occ_op = occ_reset_op();
     }
-#endif
 
     /* our wait-for-i/o objects, different for posix vs. win32 */
     if (c->mode == CM_P2P)
@@ -4362,13 +4350,11 @@ init_instance(struct context *c, const struct env_set *env, const unsigned int f
     /* print MTU info */
     do_print_data_channel_mtu_parms(c);
 
-#ifdef ENABLE_OCC
     /* get local and remote options compatibility strings */
     if (c->mode == CM_P2P || child)
     {
         do_compute_occ_strings(c);
     }
-#endif
 
     /* initialize output speed limiter */
     if (c->mode == CM_P2P)
diff --git a/src/openvpn/occ.c b/src/openvpn/occ.c
index 70c578fb..3ff351aa 100644
--- a/src/openvpn/occ.c
+++ b/src/openvpn/occ.c
@@ -29,8 +29,6 @@
 
 #include "syshead.h"
 
-#ifdef ENABLE_OCC
-
 #include "occ.h"
 #include "forward.h"
 #include "memdbg.h"
@@ -424,10 +422,3 @@ process_received_occ_msg(struct context *c)
     }
     c->c2.buf.len = 0; /* don't pass packet on */
 }
-
-#else  /* ifdef ENABLE_OCC */
-static void
-dummy(void)
-{
-}
-#endif /* ifdef ENABLE_OCC */
diff --git a/src/openvpn/occ.h b/src/openvpn/occ.h
index e3abd8cb..504c8c43 100644
--- a/src/openvpn/occ.h
+++ b/src/openvpn/occ.h
@@ -24,8 +24,6 @@
 #ifndef OCC_H
 #define OCC_H
 
-#ifdef ENABLE_OCC
-
 #include "forward.h"
 
 /* OCC_STRING_SIZE must be set to sizeof (occ_magic) */
@@ -155,5 +153,4 @@ check_send_occ_msg(struct context *c)
     }
 }
 
-#endif /* ifdef ENABLE_OCC */
 #endif /* ifndef OCC_H */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index ccc7f118..a4191a3b 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -325,7 +325,6 @@ struct context_2
     struct event_timeout inactivity_interval;
     int inactivity_bytes;
 
-#ifdef ENABLE_OCC
     /* the option strings must match across peers */
     char *options_string_local;
     char *options_string_remote;
@@ -333,7 +332,6 @@ struct context_2
     int occ_op;                 /* INIT to -1 */
     int occ_n_tries;
     struct event_timeout occ_interval;
-#endif
 
     /*
      * Keep track of maximum packet size received so far
@@ -345,13 +343,12 @@ struct context_2
     int max_send_size_local;    /* max packet size sent */
     int max_send_size_remote;   /* max packet size sent by remote */
 
-#ifdef ENABLE_OCC
+
     /* remote wants us to send back a load test packet of this size */
     int occ_mtu_load_size;
 
     struct event_timeout occ_mtu_load_test_interval;
     int occ_mtu_load_n_tries;
-#endif
 
     /*
      * TLS-mode crypto objects.
@@ -438,13 +435,11 @@ struct context_2
     /* indicates that the do_up_delay function has run */
     bool do_up_ran;
 
-#ifdef ENABLE_OCC
     /* indicates that we have received a SIGTERM when
      * options->explicit_exit_notification is enabled,
      * but we have not exited yet */
     time_t explicit_exit_notification_time_wait;
     struct event_timeout explicit_exit_notification_interval;
-#endif
 
     /* environmental variables to pass to scripts */
     struct env_set *es;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 0025c526..31e33ae3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -277,9 +277,7 @@ static const char usage_message[] =
     "                  'no'    -- Never send DF (Don't Fragment) frames\n"
     "                  'maybe' -- Use per-route hints\n"
     "                  'yes'   -- Always DF (Don't Fragment)\n"
-#ifdef ENABLE_OCC
     "--mtu-test      : Empirically measure and report MTU.\n"
-#endif
 #ifdef ENABLE_FRAGMENT
     "--fragment max  : Enable internal datagram fragmentation so that no UDP\n"
     "                  datagrams are sent which are larger than max bytes.\n"
@@ -350,9 +348,7 @@ static const char usage_message[] =
     "--status file n : Write operational status to file every n seconds.\n"
     "--status-version [n] : Choose the status file format version number.\n"
     "                  Currently, n can be 1, 2, or 3 (default=1).\n"
-#ifdef ENABLE_OCC
     "--disable-occ   : Disable options consistency check between peers.\n"
-#endif
 #ifdef ENABLE_DEBUG
     "--gremlin mask  : Special stress testing mode (for debugging only).\n"
 #endif
@@ -522,10 +518,8 @@ static const char usage_message[] =
     "--allow-recursive-routing : When this option is set, OpenVPN will not drop\n"
     "                  incoming tun packets with same destination as host.\n"
 #endif /* if P2MP */
-#ifdef ENABLE_OCC
     "--explicit-exit-notify [n] : On exit/restart, send exit signal to\n"
     "                  server/remote. n = # of retries, default=1.\n"
-#endif
     "\n"
     "Data Channel Encryption Options (must be compatible between peers):\n"
     "(These options are meaningful for both Static Key & TLS-mode)\n"
@@ -832,9 +826,7 @@ init_options(struct options *o, const bool init_gc)
     o->resolve_retry_seconds = RESOLV_RETRY_INFINITE;
     o->resolve_in_advance = false;
     o->proto_force = -1;
-#ifdef ENABLE_OCC
     o->occ = true;
-#endif
 #ifdef ENABLE_MANAGEMENT
     o->management_log_history_cache = 250;
     o->management_echo_buffer_size = 100;
@@ -1483,9 +1475,7 @@ show_connection_entry(const struct connection_entry *o)
 #endif
     SHOW_INT(mssfix);
 
-#ifdef ENABLE_OCC
     SHOW_INT(explicit_exit_notification);
-#endif
 
     SHOW_STR(tls_auth_file);
     SHOW_PARM(key_direction, keydirection2ascii(o->key_direction, false, true),
@@ -1579,9 +1569,7 @@ show_settings(const struct options *o)
 #ifdef ENABLE_FEATURE_SHAPER
     SHOW_INT(shaper);
 #endif
-#ifdef ENABLE_OCC
     SHOW_INT(mtu_test);
-#endif
 
     SHOW_BOOL(mlock);
 
@@ -1633,9 +1621,7 @@ show_settings(const struct options *o)
     SHOW_INT(status_file_version);
     SHOW_INT(status_file_update_freq);
 
-#ifdef ENABLE_OCC
     SHOW_BOOL(occ);
-#endif
     SHOW_INT(rcvbuf);
     SHOW_INT(sndbuf);
 #if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
@@ -2079,12 +2065,10 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "only one of --tun-mtu or --link-mtu may be defined (note that --ifconfig implies --link-mtu %d)", LINK_MTU_DEFAULT);
     }
 
-#ifdef ENABLE_OCC
     if (!proto_is_udp(ce->proto) && options->mtu_test)
     {
         msg(M_USAGE, "--mtu-test only makes sense with --proto udp");
     }
-#endif
 
     /* will we be pulling options from server? */
 #if P2MP
@@ -2217,12 +2201,10 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
     }
 #endif
 
-#ifdef ENABLE_OCC
     if (!proto_is_udp(ce->proto) && ce->explicit_exit_notification)
     {
         msg(M_USAGE, "--explicit-exit-notify can only be used with --proto udp");
     }
-#endif
 
     if (!ce->remote && ce->proto == PROTO_TCP_CLIENT)
     {
@@ -3587,9 +3569,6 @@ pre_pull_restore(struct options *o, struct gc_arena *gc)
 }
 
 #endif /* if P2MP */
-
-#ifdef ENABLE_OCC
-
 /**
  * Calculate the link-mtu to advertise to our peer.  The actual value is not
  * relevant, because we will possibly perform data channel cipher negotiation
@@ -3619,7 +3598,6 @@ calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
     }
     return link_mtu;
 }
-
 /*
  * Build an options string to represent data channel encryption options.
  * This string must match exactly between peers.  The keysize is checked
@@ -4027,8 +4005,6 @@ options_string_version(const char *s, struct gc_arena *gc)
     return BSTR(&out);
 }
 
-#endif /* ENABLE_OCC */
-
 char *
 options_string_extract_option(const char *options_string,const char *opt_name,
                               struct gc_arena *gc)
@@ -6028,13 +6004,11 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
         options->ce.mtu_discover_type = translate_mtu_discover_type_name(p[1]);
     }
-#ifdef ENABLE_OCC
     else if (streq(p[0], "mtu-test") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->mtu_test = true;
     }
-#endif
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
@@ -6345,7 +6319,6 @@ add_option(struct options *options,
         VERIFY_PERMISSION(OPT_P_TIMER);
         options->ping_timer_remote = true;
     }
-#ifdef ENABLE_OCC
     else if (streq(p[0], "explicit-exit-notify") && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_EXPLICIT_NOTIFY);
@@ -6358,7 +6331,6 @@ add_option(struct options *options,
             options->ce.explicit_exit_notification = 1;
         }
     }
-#endif
     else if (streq(p[0], "persist-tun") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_PERSIST);
@@ -6682,13 +6654,11 @@ add_option(struct options *options,
         }
 
     }
-#ifdef ENABLE_OCC
     else if (streq(p[0], "disable-occ") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->occ = false;
     }
-#endif
 #if P2MP
     else if (streq(p[0], "server") && p[1] && p[2] && !p[4])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 3546bab3..c5df2d18 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -262,9 +262,7 @@ struct options
 
     int proto_force;
 
-#ifdef ENABLE_OCC
     bool mtu_test;
-#endif
 
 #ifdef ENABLE_MEMSTATS
     char *memstats_fn;
@@ -375,10 +373,8 @@ struct options
     bool allow_pull_fqdn; /* as a client, allow server to push a FQDN for certain parameters */
     struct client_nat_option_list *client_nat;
 
-#ifdef ENABLE_OCC
     /* Enable options consistency check between peers */
     bool occ;
-#endif
 
 #ifdef ENABLE_MANAGEMENT
     const char *management_addr;
@@ -756,8 +752,6 @@ void show_settings(const struct options *o);
 
 bool string_defined_equal(const char *s1, const char *s2);
 
-#ifdef ENABLE_OCC
-
 const char *options_string_version(const char *s, struct gc_arena *gc);
 
 char *options_string(const struct options *o,
@@ -775,8 +769,6 @@ bool options_cmp_equal(char *actual, const char *expected);
 
 void options_warning(char *actual, const char *expected);
 
-#endif
-
 /**
  * Given an OpenVPN options string, extract the value of an option.
  *
diff --git a/src/openvpn/sig.c b/src/openvpn/sig.c
index 6e3379fe..24a2878f 100644
--- a/src/openvpn/sig.c
+++ b/src/openvpn/sig.c
@@ -330,7 +330,6 @@ print_status(const struct context *c, struct status_output *so)
     gc_free(&gc);
 }
 
-#ifdef ENABLE_OCC
 /*
  * Handle the triggering and time-wait of explicit
  * exit notification.
@@ -367,7 +366,6 @@ process_explicit_exit_notification_timer_wakeup(struct context *c)
         }
     }
 }
-#endif /* ifdef ENABLE_OCC */
 
 /*
  * Process signals
@@ -395,14 +393,12 @@ static bool
 process_sigterm(struct context *c)
 {
     bool ret = true;
-#ifdef ENABLE_OCC
     if (c->options.ce.explicit_exit_notification
         && !c->c2.explicit_exit_notification_time_wait)
     {
         process_explicit_exit_notification_init(c);
         ret = false;
     }
-#endif
     return ret;
 }
 
@@ -415,7 +411,6 @@ static bool
 ignore_restart_signals(struct context *c)
 {
     bool ret = false;
-#ifdef ENABLE_OCC
     if ( (c->sig->signal_received == SIGUSR1 || c->sig->signal_received == SIGHUP)
          && event_timeout_defined(&c->c2.explicit_exit_notification_interval) )
     {
@@ -434,7 +429,6 @@ ignore_restart_signals(struct context *c)
             ret = false;
         }
     }
-#endif
     return ret;
 }
 
diff --git a/src/openvpn/sig.h b/src/openvpn/sig.h
index 887d8332..59f30fd0 100644
--- a/src/openvpn/sig.h
+++ b/src/openvpn/sig.h
@@ -81,11 +81,8 @@ bool process_signal(struct context *c);
 
 void register_signal(struct context *c, int sig, const char *text);
 
-#ifdef ENABLE_OCC
 void process_explicit_exit_notification_timer_wakeup(struct context *c);
 
-#endif
-
 #ifdef _WIN32
 
 static inline void
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4144217d..cb18121a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -64,21 +64,6 @@
 
 #include "memdbg.h"
 
-#ifndef ENABLE_OCC
-static const char ssl_default_options_string[] = "V0 UNDEF";
-#endif
-
-
-static inline const char *
-local_options_string(const struct tls_session *session)
-{
-#ifdef ENABLE_OCC
-    return session->opt->local_options;
-#else
-    return ssl_default_options_string;
-#endif
-}
-
 #ifdef MEASURE_TLS_HANDSHAKE_STATS
 
 static int tls_handshake_success; /* GLOBAL */
@@ -1319,11 +1304,9 @@ tls_multi_init_set_options(struct tls_multi *multi,
                            const char *local,
                            const char *remote)
 {
-#ifdef ENABLE_OCC
     /* initialize options string */
     multi->opt.local_options = local;
     multi->opt.remote_options = remote;
-#endif
 }
 
 /*
@@ -2350,7 +2333,7 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
 
     /* write options string */
     {
-        if (!write_string(buf, local_options_string(session), TLS_OPTIONS_LEN))
+        if (!write_string(buf, session->opt->local_options, TLS_OPTIONS_LEN))
         {
             goto error;
         }
@@ -2543,7 +2526,6 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
         verify_final_auth_checks(multi, session);
     }
 
-#ifdef ENABLE_OCC
     /* check options consistency */
     if (!session->opt->disable_occ
         && !options_cmp_equal(options, session->opt->remote_options))
@@ -2555,7 +2537,6 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
             ks->authenticated = KS_AUTH_FALSE;
         }
     }
-#endif
 
     buf_clear(buf);
 
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index d904c31f..9f777750 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -254,19 +254,15 @@ struct tls_options
     /* if true, don't xmit until first packet from peer is received */
     bool xmit_hold;
 
-#ifdef ENABLE_OCC
     /* local and remote options strings
      * that must match between client and server */
     const char *local_options;
     const char *remote_options;
-#endif
 
     /* from command line */
     bool replay;
     bool single_session;
-#ifdef ENABLE_OCC
     bool disable_occ;
-#endif
     int mode;
     bool pull;
     int push_peer_info_detail;
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index cafe4719..8342eae0 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -569,11 +569,6 @@ socket_defined(const socket_descriptor_t sd)
 #define UNIX_SOCK_SUPPORT 0
 #endif
 
-/*
- * Should we include OCC (options consistency check) code?
- */
-#define ENABLE_OCC
-
 /*
  * Should we include NTLM proxy functionality
  */
-- 
2.26.2


