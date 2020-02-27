From: David Sommerseth <davids@...515...>
Date: Thu, 27 Feb 2020 21:54:43 +0100
Message-Id: <20200227205443.27562-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH] build: Remove --disable-server from
 ./configure
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

After some discussion among the core community developers [1,2], it was
decided to remove the possibility to build openvpn as a pure client.
This was alterted on the mailing list [3] that it was scheduled for
removal unless anyone had strong arguments why it was needed.

The general consensus was that we had not received any strong arguments
to keep this possibility after approximately 5 months, so it was fine to
remove this ./configure option.

By removing this, we remove quite some entangled sections of #ifdef
scattered all over the code base, making it more readable.

One note:
Inside the  options_postprocess_mutate_invariant() function,
the #ifdef P2MP_SERVER and #ifdef _WIN32 blocks where slightly
reworked to make the _WIN32 block more continous and avoiding having an
empty if(options->mode == MODE_SERVER) block.

Signed-off-by: David Sommerseth <davids@...515...>

[1] https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18830.html
[2] https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg19505.html
[3] https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg18829.html
---
 configure.ac                    |  8 --------
 doc/doxygen/openvpn.doxyfile.in |  2 +-
 src/openvpn/forward.c           |  5 +----
 src/openvpn/helper.c            |  8 --------
 src/openvpn/init.c              | 14 --------------
 src/openvpn/list.c              |  8 --------
 src/openvpn/list.h              |  3 ---
 src/openvpn/misc.c              |  4 ----
 src/openvpn/misc.h              |  3 ---
 src/openvpn/mroute.c            |  8 --------
 src/openvpn/mroute.h            |  3 ---
 src/openvpn/mtcp.c              |  4 ----
 src/openvpn/mtcp.h              |  3 ---
 src/openvpn/mudp.c              |  3 ---
 src/openvpn/mudp.h              |  5 +----
 src/openvpn/multi.c             |  9 ---------
 src/openvpn/multi.h             |  3 ---
 src/openvpn/openvpn.c           |  2 --
 src/openvpn/openvpn.h           |  5 -----
 src/openvpn/options.c           | 32 ++------------------------------
 src/openvpn/options.h           |  4 ----
 src/openvpn/push.c              | 14 --------------
 src/openvpn/push.h              |  2 --
 src/openvpn/pushlist.h          |  5 ++---
 src/openvpn/schedule.c          |  3 ---
 src/openvpn/schedule.h          |  3 ---
 src/openvpn/ssl.c               |  4 ----
 src/openvpn/ssl_common.h        |  4 ----
 src/openvpn/ssl_mbedtls.c       |  2 --
 src/openvpn/ssl_openssl.c       |  2 --
 src/openvpn/ssl_verify.c        |  2 --
 src/openvpn/ssl_verify.h        |  2 --
 src/openvpn/syshead.h           | 16 +++++-----------
 src/openvpn/vlan.c              |  4 ----
 src/openvpn/vlan.h              |  4 ----
 35 files changed, 12 insertions(+), 191 deletions(-)

diff --git a/configure.ac b/configure.ac
index a47ef3e7..59b1ed15 100644
--- a/configure.ac
+++ b/configure.ac
@@ -91,13 +91,6 @@ AC_ARG_ENABLE(
 	[enable_x509_alt_username="no"]
 )
 
-AC_ARG_ENABLE(
-	[server],
-	[AS_HELP_STRING([--disable-server], [disable server support only (but retain client support) @<:@default=yes@:>@])],
-	,
-	[enable_server="yes"]
-)
-
 AC_ARG_ENABLE(
 	[plugins],
 	[AS_HELP_STRING([--disable-plugins], [disable plug-in support @<:@default=yes@:>@])],
@@ -1218,7 +1211,6 @@ if test "${enable_x509_alt_username}" = "yes"; then
 fi
 
 test "${ac_cv_header_sys_uio_h}" = "yes" && AC_DEFINE([HAVE_IOVEC], [1], [struct iovec needed for IPv6 support])
-test "${enable_server}" = "no" && AC_DEFINE([ENABLE_CLIENT_ONLY], [1], [Enable client capability only])
 test "${enable_management}" = "yes" && AC_DEFINE([ENABLE_MANAGEMENT], [1], [Enable management server capability])
 test "${enable_multihome}" = "yes" && AC_DEFINE([ENABLE_MULTIHOME], [1], [Enable multi-homed UDP server capability])
 test "${enable_debug}" = "yes" && AC_DEFINE([ENABLE_DEBUG], [1], [Enable debugging support])
diff --git a/doc/doxygen/openvpn.doxyfile.in b/doc/doxygen/openvpn.doxyfile.in
index d9e9ed08..beb02d96 100644
--- a/doc/doxygen/openvpn.doxyfile.in
+++ b/doc/doxygen/openvpn.doxyfile.in
@@ -235,7 +235,7 @@ EXPAND_ONLY_PREDEF     = NO
 SEARCH_INCLUDES        = YES
 INCLUDE_PATH           =
 INCLUDE_FILE_PATTERNS  =
-PREDEFINED             = _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP P2MP_SERVER ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
+PREDEFINED             = _WIN32 NTLM USE_LZO ENABLE_FRAGMENT P2MP ENABLE_CRYPTO_OPENSSL ENABLE_PLUGIN ENABLE_MANAGEMENT ENABLE_OCC HAVE_GETTIMEOFDAY
 EXPAND_AS_DEFINED      =
 SKIP_FUNCTION_MACROS   = YES
 #---------------------------------------------------------------------------
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ea10f0bf..dd6bbc69 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -682,7 +682,6 @@ encrypt_sign(struct context *c, bool comp_frag)
     const uint8_t *orig_buf = c->c2.buf.data;
     struct crypto_options *co = NULL;
 
-#if P2MP_SERVER
     /*
      * Drop non-TLS outgoing packet if client-connect script/plugin
      * has not yet succeeded.
@@ -691,7 +690,6 @@ encrypt_sign(struct context *c, bool comp_frag)
     {
         c->c2.buf.len = 0;
     }
-#endif
 
     if (comp_frag)
     {
@@ -1111,7 +1109,7 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
         {
             co = &c->c2.crypto_options;
         }
-#if P2MP_SERVER
+
         /*
          * Drop non-TLS packet if client-connect script/plugin has not
          * yet succeeded.
@@ -1120,7 +1118,6 @@ process_incoming_link_part1(struct context *c, struct link_socket_info *lsi, boo
         {
             c->c2.buf.len = 0;
         }
-#endif
 
         /* authenticate and decrypt the incoming packet */
         decrypt_status = openvpn_decrypt(&c->c2.buf, c->c2.buffers->decrypt_buf,
diff --git a/src/openvpn/helper.c b/src/openvpn/helper.c
index ff9df506..34cfa6bd 100644
--- a/src/openvpn/helper.c
+++ b/src/openvpn/helper.c
@@ -36,7 +36,6 @@
 
 #include "memdbg.h"
 
-#if P2MP_SERVER
 
 static const char *
 print_netmask(int netbits, struct gc_arena *gc)
@@ -139,7 +138,6 @@ verify_common_subnet(const char *opt, const in_addr_t a, const in_addr_t b, cons
     gc_free(&gc);
 }
 
-#endif /* if P2MP_SERVER */
 
 /*
  * Process server, server-bridge, and client helper
@@ -152,7 +150,6 @@ helper_client_server(struct options *o)
     struct gc_arena gc = gc_new();
 
 #if P2MP
-#if P2MP_SERVER
 
 /*
  * Get tun/tap/null device type
@@ -464,7 +461,6 @@ helper_client_server(struct options *o)
         }
     }
     else
-#endif /* P2MP_SERVER */
 
     /*
      * HELPER DIRECTIVE:
@@ -541,7 +537,6 @@ helper_keepalive(struct options *o)
             o->ping_send_timeout = o->keepalive_ping;
             o->ping_rec_timeout = o->keepalive_timeout;
         }
-#if P2MP_SERVER
         else if (o->mode == MODE_SERVER)
         {
             o->ping_rec_timeout_action = PING_RESTART;
@@ -550,7 +545,6 @@ helper_keepalive(struct options *o)
             push_option(o, print_str_int("ping", o->keepalive_ping, &o->gc), M_USAGE);
             push_option(o, print_str_int("ping-restart", o->keepalive_timeout, &o->gc), M_USAGE);
         }
-#endif
         else
         {
             ASSERT(0);
@@ -573,7 +567,6 @@ helper_keepalive(struct options *o)
 void
 helper_tcp_nodelay(struct options *o)
 {
-#if P2MP_SERVER
     if (o->server_flags & SF_TCP_NODELAY_HELPER)
     {
         if (o->mode == MODE_SERVER)
@@ -586,5 +579,4 @@ helper_tcp_nodelay(struct options *o)
             o->sockflags |= SF_TCP_NODELAY;
         }
     }
-#endif
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1cfffbbe..ab3130ab 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2658,7 +2658,6 @@ do_init_tls_wrap_key(struct context *c)
 
 }
 
-#if P2MP_SERVER
 /*
  * Initialise the auth-token key context
  */
@@ -2674,7 +2673,6 @@ do_init_auth_token_key(struct context *c)
                            c->options.auth_token_secret_file,
                            c->options.auth_token_secret_file_inline);
 }
-#endif
 
 /*
  * Initialize the persistent component of OpenVPN's TLS mode,
@@ -2728,10 +2726,8 @@ do_init_crypto_tls_c1(struct context *c)
         /* initialize tls-auth/crypt/crypt-v2 key */
         do_init_tls_wrap_key(c);
 
-#if P2MP_SERVER
         /* initialise auth-token crypto support */
         do_init_auth_token_key(c);
-#endif
 
 #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code will break restarts */
         if (options->priv_key_file_inline)
@@ -2895,7 +2891,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.mda_context = &c->c2.mda_context;
 #endif
 
-#if P2MP_SERVER
     to.auth_user_pass_verify_script = options->auth_user_pass_verify_script;
     to.auth_user_pass_verify_script_via_file = options->auth_user_pass_verify_script_via_file;
     to.tmp_dir = options->tmp_dir;
@@ -2908,7 +2903,6 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.auth_token_lifetime = options->auth_token_lifetime;
     to.auth_token_call_auth = options->auth_token_call_auth;
     to.auth_token_key = c->c1.ks.auth_token_key;
-#endif
 
     to.x509_track = options->x509_track;
 
@@ -3218,7 +3212,6 @@ do_option_warnings(struct context *c)
         msg(M_WARN, "WARNING: using --pull/--client and --ifconfig together is probably not what you want");
     }
 
-#if P2MP_SERVER
     if (o->server_bridge_defined | o->server_bridge_proxy_dhcp)
     {
         msg(M_WARN, "NOTE: when bridging your LAN adapter with the TAP adapter, note that the new bridge adapter will often take on its own IP address that is different from what the LAN adapter was previously set to");
@@ -3239,7 +3232,6 @@ do_option_warnings(struct context *c)
             msg(M_WARN, "WARNING: --keepalive option is missing from server config");
         }
     }
-#endif /* if P2MP_SERVER */
 #endif /* if P2MP */
 
     if (!o->replay)
@@ -3735,20 +3727,17 @@ do_close_status_output(struct context *c)
 static void
 do_open_ifconfig_pool_persist(struct context *c)
 {
-#if P2MP_SERVER
     if (!c->c1.ifconfig_pool_persist && c->options.ifconfig_pool_persist_filename)
     {
         c->c1.ifconfig_pool_persist = ifconfig_pool_persist_init(c->options.ifconfig_pool_persist_filename,
                                                                  c->options.ifconfig_pool_persist_refresh_freq);
         c->c1.ifconfig_pool_persist_owned = true;
     }
-#endif
 }
 
 static void
 do_close_ifconfig_pool_persist(struct context *c)
 {
-#if P2MP_SERVER
     if (!(c->sig->signal_received == SIGUSR1))
     {
         if (c->c1.ifconfig_pool_persist && c->c1.ifconfig_pool_persist_owned)
@@ -3758,7 +3747,6 @@ do_close_ifconfig_pool_persist(struct context *c)
             c->c1.ifconfig_pool_persist_owned = false;
         }
     }
-#endif
 }
 
 /*
@@ -4604,9 +4592,7 @@ inherit_context_top(struct context *dest,
     /* detach c1 ownership */
     dest->c1.tuntap_owned = false;
     dest->c1.status_output_owned = false;
-#if P2MP_SERVER
     dest->c1.ifconfig_pool_persist_owned = false;
-#endif
 
     /* detach c2 ownership */
     dest->c2.event_set_owned = false;
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index 6023ea68..549ebdf0 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -29,7 +29,6 @@
 
 #include "syshead.h"
 
-#if P2MP_SERVER
 
 #include "integer.h"
 #include "list.h"
@@ -656,10 +655,3 @@ hash_func(const uint8_t *k, uint32_t length, uint32_t initval)
     /*-------------------------------------- report the result */
     return c;
 }
-
-#else  /* if P2MP_SERVER */
-static void
-dummy(void)
-{
-}
-#endif /* P2MP_SERVER */
diff --git a/src/openvpn/list.h b/src/openvpn/list.h
index 61771577..c381acd3 100644
--- a/src/openvpn/list.h
+++ b/src/openvpn/list.h
@@ -33,8 +33,6 @@
  * client instances over various key spaces.
  */
 
-#if P2MP_SERVER
-
 /* define this to enable special list test mode */
 /*#define LIST_TEST*/
 
@@ -194,5 +192,4 @@ hash_remove(struct hash *hash, const void *key)
     return ret;
 }
 
-#endif /* P2MP_SERVER */
 #endif /* LIST */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 1931149b..3b1c971c 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -670,8 +670,6 @@ sanitize_control_message(const char *src, struct gc_arena *gc)
     return ret;
 }
 
-#if P2MP_SERVER
-
 /* helper to parse peer_info received from multi client, validate
  * (this is untrusted data) and put into environment
  */
@@ -734,5 +732,3 @@ output_peer_info_env(struct env_set *es, const char *peer_info)
         }
     }
 }
-
-#endif /* P2MP_SERVER */
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 991b7df2..0c0460f0 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -166,13 +166,10 @@ const char *sanitize_control_message(const char *str, struct gc_arena *gc);
 extern const char *iproute_path;
 #endif
 
-#if P2MP_SERVER
 /* helper to parse peer_info received from multi client, validate
  * (this is untrusted data) and put into environment */
 bool validate_peer_info_line(char *line);
 
 void output_peer_info_env(struct env_set *es, const char *peer_info);
 
-#endif /* P2MP_SERVER */
-
 #endif /* ifndef MISC_H */
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index bdb1b0c0..e862a4f8 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -29,7 +29,6 @@
 
 #include "syshead.h"
 
-#if P2MP_SERVER
 
 #include "mroute.h"
 #include "proto.h"
@@ -614,10 +613,3 @@ mroute_helper_free(struct mroute_helper *mh)
 {
     free(mh);
 }
-
-#else  /* if P2MP_SERVER */
-static void
-dummy(void)
-{
-}
-#endif /* P2MP_SERVER */
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 113aa8c5..c94b1323 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -24,8 +24,6 @@
 #ifndef MROUTE_H
 #define MROUTE_H
 
-#if P2MP_SERVER
-
 #include "buffer.h"
 #include "list.h"
 #include "route.h"
@@ -270,5 +268,4 @@ mroute_addr_reset(struct mroute_addr *ma)
     ma->type = MR_ADDR_NONE;
 }
 
-#endif /* P2MP_SERVER */
 #endif /* MROUTE_H */
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index ee28a710..458e6e4c 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -29,8 +29,6 @@
 
 #include "syshead.h"
 
-#if P2MP_SERVER
-
 #include "multi.h"
 #include "forward.h"
 
@@ -861,5 +859,3 @@ tunnel_server_tcp(struct context *top)
     multi_top_free(&multi);
     close_instance(top);
 }
-
-#endif /* if P2MP_SERVER */
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index bba455be..680ab102 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -28,8 +28,6 @@
 #ifndef MTCP_H
 #define MTCP_H
 
-#if P2MP_SERVER
-
 #include "event.h"
 
 /*
@@ -75,5 +73,4 @@ void tunnel_server_tcp(struct context *top);
 
 void multi_tcp_delete_event(struct multi_tcp *mtcp, event_t event);
 
-#endif /* if P2MP_SERVER */
 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 6a29ccc8..e95a7ac8 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -29,8 +29,6 @@
 
 #include "syshead.h"
 
-#if P2MP_SERVER
-
 #include "multi.h"
 #include <inttypes.h>
 #include "forward.h"
@@ -384,4 +382,3 @@ tunnel_server_udp(struct context *top)
     tunnel_server_udp_single_threaded(top);
 }
 
-#endif /* if P2MP_SERVER */
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 7e311519..460a768b 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -28,8 +28,6 @@
 #ifndef MUDP_H
 #define MUDP_H
 
-#if P2MP_SERVER
-
 struct context;
 struct multi_context;
 
@@ -66,5 +64,4 @@ void tunnel_server_udp(struct context *top);
  */
 struct multi_instance *multi_get_create_instance_udp(struct multi_context *m, bool *floated);
 
-#endif
-#endif
+#endif /* ifndef MUDP_H */
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 279cab23..697003c0 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -34,8 +34,6 @@
 
 #include "syshead.h"
 
-#if P2MP_SERVER
-
 #include "forward.h"
 #include "multi.h"
 #include "push.h"
@@ -3422,10 +3420,3 @@ tunnel_server(struct context *top)
         tunnel_server_tcp(top);
     }
 }
-
-#else  /* if P2MP_SERVER */
-static void
-dummy(void)
-{
-}
-#endif /* P2MP_SERVER */
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index cfd86bbe..3d949e30 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -28,8 +28,6 @@
 #ifndef MULTI_H
 #define MULTI_H
 
-#if P2MP_SERVER
-
 #include "init.h"
 #include "forward.h"
 #include "mroute.h"
@@ -652,5 +650,4 @@ multi_set_pending(struct multi_context *m, struct multi_instance *mi)
     m->pending = mi;
 }
 
-#endif /* P2MP_SERVER */
 #endif /* MULTI_H */
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index a58d5075..dc7001dc 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -305,12 +305,10 @@ openvpn_main(int argc, char *argv[])
                         tunnel_point_to_point(&c);
                         break;
 
-#if P2MP_SERVER
                     case MODE_SERVER:
                         tunnel_server(&c);
                         break;
 
-#endif
                     default:
                         ASSERT(0);
                 }
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 900db7e1..1088ff90 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -190,12 +190,9 @@ struct context_1
     bool socks_proxy_owned;
 
 #if P2MP
-
-#if P2MP_SERVER
     /* persist --ifconfig-pool db to file */
     struct ifconfig_pool_persist *ifconfig_pool_persist;
     bool ifconfig_pool_persist_owned;
-#endif
 
     /* if client mode, hash of option strings we pulled from server */
     struct sha256_digest pulled_options_digest_save;
@@ -434,7 +431,6 @@ struct context_2
 
 #if P2MP
 
-#if P2MP_SERVER
     /* --ifconfig endpoints to be pushed to client */
     bool push_reply_deferred;
 #ifdef ENABLE_ASYNC_PUSH
@@ -458,7 +454,6 @@ struct context_2
 #define CAS_PARTIAL   3  /* at least one client-connect script/plugin
                           * succeeded while a later one in the chain failed */
     int context_auth;
-#endif /* if P2MP_SERVER */
 
     struct event_timeout push_request_interval;
     int n_sent_push_requests;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6c0e52e6..006e582e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -409,7 +409,6 @@ static const char usage_message[] =
     "--vlan-accept tagged|untagged|all : Set VLAN tagging mode. Default is 'all'.\n"
     "--vlan-pvid v   : Sets the Port VLAN Identifier. Defaults to 1.\n"
 #if P2MP
-#if P2MP_SERVER
     "\n"
     "Multi-Client Server options (when --mode server is used):\n"
     "--server network netmask : Helper option to easily configure server mode.\n"
@@ -494,7 +493,6 @@ static const char usage_message[] =
     "                  sessions to a web server at host:port.  dir specifies an\n"
     "                  optional directory to write origin IP:port data.\n"
 #endif
-#endif /* if P2MP_SERVER */
     "\n"
     "Client options (when connecting to a multi-client server):\n"
     "--client         : Helper option to easily configure client mode.\n"
@@ -858,7 +856,6 @@ init_options(struct options *o, const bool init_gc)
 #endif
     o->vlan_accept = VLAN_ALL;
     o->vlan_pvid = 1;
-#if P2MP_SERVER
     o->real_hash_size = 256;
     o->virtual_hash_size = 256;
     o->n_bcast_buf = 256;
@@ -867,7 +864,6 @@ init_options(struct options *o, const bool init_gc)
     o->max_routes_per_client = 256;
     o->stale_routes_check_interval = 0;
     o->ifconfig_pool_persist_refresh_freq = 600;
-#endif
 #if P2MP
     o->scheduled_exit_interval = 5;
 #endif
@@ -905,7 +901,6 @@ init_options(struct options *o, const bool init_gc)
 #endif                  /* ENABLE_PKCS11 */
 
 /* P2MP server context features */
-#if P2MP_SERVER
     o->auth_token_generate = false;
 
     /* Set default --tmp-dir */
@@ -920,7 +915,6 @@ init_options(struct options *o, const bool init_gc)
         o->tmp_dir = "/tmp";
     }
 #endif /* _WIN32 */
-#endif /* P2MP_SERVER */
     o->allow_recursive_routing = false;
 }
 
@@ -1257,7 +1251,6 @@ show_p2mp_parms(const struct options *o)
 {
     struct gc_arena gc = gc_new();
 
-#if P2MP_SERVER
     msg(D_SHOW_PARMS, "  server_network = %s", print_in_addr_t(o->server_network, 0, &gc));
     msg(D_SHOW_PARMS, "  server_netmask = %s", print_in_addr_t(o->server_netmask, 0, &gc));
     msg(D_SHOW_PARMS, "  server_network_ipv6 = %s", print_in6_addr(o->server_network_ipv6, 0, &gc) );
@@ -1321,7 +1314,6 @@ show_p2mp_parms(const struct options *o)
     SHOW_BOOL(vlan_tagging);
     msg(D_SHOW_PARMS, "  vlan_accept = %s", print_vlan_accept (o->vlan_accept));
     SHOW_INT(vlan_pvid);
-#endif /* P2MP_SERVER */
 
     SHOW_BOOL(client);
     SHOW_BOOL(pull);
@@ -1332,8 +1324,6 @@ show_p2mp_parms(const struct options *o)
 
 #endif /* ! ENABLE_SMALL */
 
-#if P2MP_SERVER
-
 static void
 option_iroute(struct options *o,
               const char *network_str,
@@ -1381,7 +1371,6 @@ option_iroute_ipv6(struct options *o,
     ir->next = o->iroutes_ipv6;
     o->iroutes_ipv6 = ir;
 }
-#endif /* P2MP_SERVER */
 #endif /* P2MP */
 
 #ifndef ENABLE_SMALL
@@ -1419,9 +1408,7 @@ options_detach(struct options *o)
     gc_detach(&o->gc);
     o->routes = NULL;
     o->client_nat = NULL;
-#if P2MP_SERVER
     clone_push_list(o);
-#endif
 }
 
 void
@@ -2253,8 +2240,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         msg(M_USAGE, "TCP server mode allows at most one --remote address");
     }
 
-#if P2MP_SERVER
-
     /*
      * Check consistency of --mode server options.
      */
@@ -2508,7 +2493,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
             msg(M_USAGE, "--vlan-tagging requires --mode server");
         }
     }
-#endif /* P2MP_SERVER */
 
     if (options->ncp_enabled && !tls_check_ncp_cipher_list(options->ncp_ciphers))
     {
@@ -2827,7 +2811,6 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
 {
     const int dev = dev_type_enum(o->dev, o->dev_type);
 
-#if P2MP_SERVER
     if (o->server_defined || o->server_bridge_defined || o->server_bridge_proxy_dhcp)
     {
         if (ce->proto == PROTO_TCP)
@@ -2835,7 +2818,7 @@ options_postprocess_mutate_ce(struct options *o, struct connection_entry *ce)
             ce->proto = PROTO_TCP_SERVER;
         }
     }
-#endif
+
 #if P2MP
     if (o->client)
     {
@@ -3026,15 +3009,12 @@ options_postprocess_mutate_invariant(struct options *options)
     }
 
     remap_redirect_gateway_flags(options);
-#endif /* ifdef _WIN32 */
 
-#if P2MP_SERVER
     /*
      * Check consistency of --mode server options.
      */
     if (options->mode == MODE_SERVER)
     {
-#ifdef _WIN32
         /*
          * We need to explicitly set --tap-sleep because
          * we do not schedule event timers in the top-level context.
@@ -3045,9 +3025,8 @@ options_postprocess_mutate_invariant(struct options *options)
             options->tuntap_options.tap_sleep = options->route_delay;
         }
         options->route_delay_defined = false;
-#endif
     }
-#endif
+#endif /* ifdef _WIN32 */
 
 #ifdef DEFAULT_PKCS11_MODULE
     /* If p11-kit is present on the system then load its p11-kit-proxy.so
@@ -3443,14 +3422,11 @@ options_postprocess_filechecks(struct options *options)
     /* ** Config related ** */
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tls_export_cert,
                                      R_OK|W_OK|X_OK, "--tls-export-cert");
-#if P2MP_SERVER
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->client_config_dir,
                                      R_OK|X_OK, "--client-config-dir");
     errs |= check_file_access_chroot(options->chroot_dir, CHKACC_FILE, options->tmp_dir,
                                      R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
 
-#endif /* P2MP_SERVER */
-
     if (errs)
     {
         msg(M_USAGE, "Please correct these errors.");
@@ -5341,12 +5317,10 @@ add_option(struct options *options,
         {
             options->mode = MODE_POINT_TO_POINT;
         }
-#if P2MP_SERVER
         else if (streq(p[1], "server"))
         {
             options->mode = MODE_SERVER;
         }
-#endif
         else
         {
             msg(msglevel, "Bad --mode parameter: %s", p[1]);
@@ -6607,7 +6581,6 @@ add_option(struct options *options,
     }
 #endif
 #if P2MP
-#if P2MP_SERVER
     else if (streq(p[0], "server") && p[1] && p[2] && !p[4])
     {
         const int lev = M_WARN;
@@ -7159,7 +7132,6 @@ add_option(struct options *options,
         options->stale_routes_ageing_time  = ageing_time;
         options->stale_routes_check_interval = check_interval;
     }
-#endif /* P2MP_SERVER */
 
     else if (streq(p[0], "client") && !p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2f1f6faf..cdb2e97f 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -404,7 +404,6 @@ struct options
 
 #if P2MP
 
-#if P2MP_SERVER
     /* the tmp dir is for now only used in the P2P server context */
     const char *tmp_dir;
     bool server_defined;
@@ -487,7 +486,6 @@ struct options
     char *port_share_port;
     const char *port_share_journal_dir;
 #endif
-#endif /* if P2MP_SERVER */
 
     bool client;
     bool pull; /* client pull of config options from server */
@@ -696,10 +694,8 @@ struct options
 
 #if P2MP
 #define PULL_DEFINED(opt) ((opt)->pull)
-#if P2MP_SERVER
 #define PUSH_DEFINED(opt) ((opt)->push_list)
 #endif
-#endif
 
 #ifndef PULL_DEFINED
 #define PULL_DEFINED(opt) (false)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 8b634051..ef692cba 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -39,9 +39,7 @@
 
 #if P2MP
 
-#ifdef P2MP_SERVER
 static char push_reply_cmd[] = "PUSH_REPLY";
-#endif
 
 /*
  * Auth username/password
@@ -178,7 +176,6 @@ server_pushed_signal(struct context *c, const struct buffer *buffer, const bool
     }
 }
 
-#if P2MP_SERVER
 /**
  * Add an option to the given push list by providing a format string.
  *
@@ -245,8 +242,6 @@ send_restart(struct context *c, const char *kill_msg)
     send_control_channel_string(c, kill_msg ? kill_msg : "RESTART", D_PUSH);
 }
 
-#endif /* if P2MP_SERVER */
-
 /*
  * Push/Pull
  */
@@ -332,7 +327,6 @@ send_push_request(struct context *c)
     }
 }
 
-#if P2MP_SERVER
 /**
  * Prepare push option for auth-token
  * @param tls_multi     tls multi context of VPN tunnel
@@ -717,9 +711,7 @@ push_remove_option(struct options *o, const char *p)
         }
     }
 }
-#endif /* if P2MP_SERVER */
 
-#if P2MP_SERVER
 int
 process_incoming_push_request(struct context *c)
 {
@@ -765,7 +757,6 @@ process_incoming_push_request(struct context *c)
 
     return ret;
 }
-#endif /* if P2MP_SERVER */
 
 static void
 push_update_digest(md_ctx_t *ctx, struct buffer *buf, const struct options *opt)
@@ -797,13 +788,11 @@ process_incoming_push_msg(struct context *c,
     int ret = PUSH_MSG_ERROR;
     struct buffer buf = *buffer;
 
-#if P2MP_SERVER
     if (buf_string_compare_advance(&buf, "PUSH_REQUEST"))
     {
         ret = process_incoming_push_request(c);
     }
     else
-#endif
 
     if (honor_received_options && buf_string_compare_advance(&buf, "PUSH_REPLY"))
     {
@@ -857,7 +846,6 @@ process_incoming_push_msg(struct context *c,
     return ret;
 }
 
-#if P2MP_SERVER
 
 /*
  * Remove iroutes from the push_list.
@@ -921,6 +909,4 @@ remove_iroutes_from_push_route_list(struct options *o)
     }
 }
 
-#endif /* if P2MP_SERVER */
-
 #endif /* if P2MP */
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 070782dd..dc65aa42 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -52,7 +52,6 @@ void server_pushed_signal(struct context *c, const struct buffer *buffer, const
 
 void incoming_push_message(struct context *c, const struct buffer *buffer);
 
-#if P2MP_SERVER
 void clone_push_list(struct options *o);
 
 void push_option(struct options *o, const char *opt, int msglevel);
@@ -77,6 +76,5 @@ void send_restart(struct context *c, const char *kill_msg);
  */
 void send_push_reply_auth_token(struct tls_multi *multi);
 
-#endif
 #endif /* if P2MP */
 #endif /* ifndef PUSH_H */
diff --git a/src/openvpn/pushlist.h b/src/openvpn/pushlist.h
index 23b0ee5d..967eda22 100644
--- a/src/openvpn/pushlist.h
+++ b/src/openvpn/pushlist.h
@@ -21,7 +21,7 @@
  *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
  */
 
-#if !defined(PUSHLIST_H) && P2MP && P2MP_SERVER
+#if !defined(PUSHLIST_H) && P2MP
 #define PUSHLIST_H
 
 /* parameters to be pushed to peer */
@@ -37,5 +37,4 @@ struct push_list {
     struct push_entry *tail;
 };
 
-
-#endif
+#endif /* if !defined(PUSHLIST_H) && P2MP */
diff --git a/src/openvpn/schedule.c b/src/openvpn/schedule.c
index 76cf7c3d..13be3234 100644
--- a/src/openvpn/schedule.c
+++ b/src/openvpn/schedule.c
@@ -29,8 +29,6 @@
 
 #include "syshead.h"
 
-#if P2MP_SERVER
-
 #include "buffer.h"
 #include "misc.h"
 #include "crypto.h"
@@ -723,4 +721,3 @@ schedule_test(void)
 }
 
 #endif /* ifdef SCHEDULE_TEST */
-#endif /* if P2MP_SERVER */
diff --git a/src/openvpn/schedule.h b/src/openvpn/schedule.h
index 74d37fb3..8c476fdf 100644
--- a/src/openvpn/schedule.h
+++ b/src/openvpn/schedule.h
@@ -35,8 +35,6 @@
  * a ping or scheduling a TLS renegotiation.
  */
 
-#if P2MP_SERVER
-
 /* define to enable a special test mode */
 /*#define SCHEDULE_TEST*/
 
@@ -136,5 +134,4 @@ schedule_get_earliest_wakeup(struct schedule *s,
     return ret;
 }
 
-#endif /* if P2MP_SERVER */
 #endif /* ifndef SCHEDULE_H */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 51b03c3b..64c15da3 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1349,11 +1349,9 @@ tls_multi_free(struct tls_multi *multi, bool clear)
 
     ASSERT(multi);
 
-#if P2MP_SERVER
     auth_set_client_reason(multi, NULL);
 
     free(multi->peer_info);
-#endif
 
     if (multi->locked_cn)
     {
@@ -2725,7 +2723,6 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
     username_status = read_string(buf, up->username, USER_PASS_LEN);
     password_status = read_string(buf, up->password, USER_PASS_LEN);
 
-#if P2MP_SERVER
     /* get peer info from control channel */
     free(multi->peer_info);
     multi->peer_info = read_string_alloc(buf);
@@ -2749,7 +2746,6 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
             session->opt->ncp_enabled = false;
         }
     }
-#endif /* if P2MP_SERVER */
 
     if (tls_session_user_pass_enabled(session))
     {
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 998ea3c4..3a14abcd 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -306,7 +306,6 @@ struct tls_options
     const char *tmp_dir;
     const char *auth_user_pass_file;
 
-#ifdef P2MP_SERVER
     bool auth_token_generate;   /**< Generate auth-tokens on successful
                                  * user/pass auth,seet via
                                  * options->auth_token_generate. */
@@ -314,7 +313,6 @@ struct tls_options
     unsigned int auth_token_lifetime;
 
     struct key_ctx auth_token_key;
-#endif
 
     /* use the client-config-dir as a positive authenticator */
     const char *client_config_dir_exclusive;
@@ -530,7 +528,6 @@ struct tls_multi
     time_t tas_last;
 #endif
 
-#ifdef P2MP_SERVER
     /*
      * An error message to send to client on AUTH_FAILED
      */
@@ -541,7 +538,6 @@ struct tls_multi
      * over control channel.
      */
     char *peer_info;
-#endif
     char *auth_token;    /**< If server sends a generated auth-token,
                           *   this is the token to use for future
                           *   user/pass authentications in this session.
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 0f0b035b..59b8b5f4 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1073,13 +1073,11 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
                                       ssl_ctx->priv_key));
 
     /* Initialise SSL verification */
-#if P2MP_SERVER
     if (session->opt->ssl_flags & SSLF_CLIENT_CERT_OPTIONAL)
     {
         mbedtls_ssl_conf_authmode(&ks_ssl->ssl_config, MBEDTLS_SSL_VERIFY_OPTIONAL);
     }
     else if (!(session->opt->ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED))
-#endif
     {
         mbedtls_ssl_conf_authmode(&ks_ssl->ssl_config, MBEDTLS_SSL_VERIFY_REQUIRED);
     }
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 17f7b33c..e6bce79c 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -343,7 +343,6 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
 
     /* Require peer certificate verification */
     int verify_flags = SSL_VERIFY_PEER | SSL_VERIFY_FAIL_IF_NO_PEER_CERT;
-#if P2MP_SERVER
     if (ssl_flags & SSLF_CLIENT_CERT_NOT_REQUIRED)
     {
         verify_flags = 0;
@@ -352,7 +351,6 @@ tls_ctx_set_options(struct tls_root_ctx *ctx, unsigned int ssl_flags)
     {
         verify_flags = SSL_VERIFY_PEER;
     }
-#endif
     SSL_CTX_set_verify(ctx->ctx, verify_flags, verify_callback);
 
     SSL_CTX_set_info_callback(ctx->ctx, info_callback);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index da0966c5..ac1f99c7 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -1372,7 +1372,6 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
             set_common_name(session, up->username);
         }
 
-#if P2MP_SERVER
         if ((session->opt->auth_token_generate))
         {
             /*
@@ -1411,7 +1410,6 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
              */
             send_push_reply_auth_token(multi);
         }
-#endif
 #ifdef ENABLE_DEF_AUTH
         msg(D_HANDSHAKE, "TLS: Username/Password authentication %s for username '%s' %s",
             ks->auth_deferred ? "deferred" : "succeeded",
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index c54b89a6..3c8781c3 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -226,7 +226,6 @@ bool tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id
 
 #endif
 
-#ifdef P2MP_SERVER
 /**
  * Sets the reason why authentication of a client failed. This be will send to the client
  * when the AUTH_FAILED message is sent
@@ -235,7 +234,6 @@ bool tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id
  * @param client_reason     The string to send to the client as part of AUTH_FAILED
  */
 void auth_set_client_reason(struct tls_multi* multi, const char* client_reason);
-#endif
 
 static inline const char *
 tls_client_reason(struct tls_multi *multi)
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index b031dd60..cafe4719 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -521,16 +521,10 @@ socket_defined(const socket_descriptor_t sd)
 #define P2MP 0
 #endif
 
-#if P2MP && !defined(ENABLE_CLIENT_ONLY)
-#define P2MP_SERVER 1
-#else
-#define P2MP_SERVER 0
-#endif
-
 /*
  * HTTPS port sharing capability
  */
-#if defined(ENABLE_PORT_SHARE) && P2MP_SERVER && defined(SCM_RIGHTS) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(HAVE_IOVEC) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
+#if defined(ENABLE_PORT_SHARE) && defined(SCM_RIGHTS) && defined(HAVE_MSGHDR) && defined(HAVE_CMSGHDR) && defined(HAVE_IOVEC) && defined(CMSG_FIRSTHDR) && defined(CMSG_NXTHDR) && defined(HAVE_RECVMSG) && defined(HAVE_SENDMSG)
 #define PORT_SHARE 1
 #else
 #define PORT_SHARE 0
@@ -539,10 +533,10 @@ socket_defined(const socket_descriptor_t sd)
 /*
  * Enable deferred authentication?
  */
-#if defined(ENABLE_DEF_AUTH) && P2MP_SERVER && defined(ENABLE_PLUGIN)
+#if defined(ENABLE_DEF_AUTH) && defined(ENABLE_PLUGIN)
 #define PLUGIN_DEF_AUTH
 #endif
-#if defined(ENABLE_DEF_AUTH) && P2MP_SERVER && defined(ENABLE_MANAGEMENT)
+#if defined(ENABLE_DEF_AUTH) && defined(ENABLE_MANAGEMENT)
 #define MANAGEMENT_DEF_AUTH
 #endif
 #if !defined(PLUGIN_DEF_AUTH) && !defined(MANAGEMENT_DEF_AUTH)
@@ -556,10 +550,10 @@ socket_defined(const socket_descriptor_t sd)
 /*
  * Enable packet filter?
  */
-#if defined(ENABLE_PF) && P2MP_SERVER && defined(ENABLE_PLUGIN) && defined(HAVE_STAT)
+#if defined(ENABLE_PF) && defined(ENABLE_PLUGIN) && defined(HAVE_STAT)
 #define PLUGIN_PF
 #endif
-#if defined(ENABLE_PF) && P2MP_SERVER && defined(MANAGEMENT_DEF_AUTH)
+#if defined(ENABLE_PF) && defined(MANAGEMENT_DEF_AUTH)
 #define MANAGEMENT_PF
 #endif
 #if !defined(PLUGIN_PF) && !defined(MANAGEMENT_PF)
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index a5885de2..072267f6 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -30,8 +30,6 @@
 
 #include "syshead.h"
 
-#if P2MP_SERVER
-
 #include "multi.h"
 #include "options.h"
 #include "vlan.h"
@@ -333,5 +331,3 @@ vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi)
         vlan_encapsulate(&mi->context, &mi->context.c2.to_tun);
     }
 }
-
-#endif /* P2MP_SERVER */
diff --git a/src/openvpn/vlan.h b/src/openvpn/vlan.h
index a67ad0e1..ed25c1d2 100644
--- a/src/openvpn/vlan.h
+++ b/src/openvpn/vlan.h
@@ -25,8 +25,6 @@
 #ifndef VLAN_H
 #define VLAN_H
 
-#if P2MP_SERVER
-
 #include "buffer.h"
 #include "mroute.h"
 #include "openvpn.h"
@@ -43,6 +41,4 @@ vlan_is_tagged(const struct buffer *buf);
 void
 vlan_process_outgoing_tun(struct multi_context *m, struct multi_instance *mi);
 
-#endif /* P2MP_SERVER */
-
 #endif /* VLAN_H */
-- 
2.17.1



