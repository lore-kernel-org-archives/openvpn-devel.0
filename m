From: Arne Schwabe <arne@...1227...>
Date: Thu, 16 Apr 2020 10:49:35 +0200
Message-Id: <20200416084935.31882-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Reformat source files with uncrustify again
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

After the last big formatting patch a number of changes have been
commited that do not conform with our style/uncrustify config. This
has lead to the problem that running uncrustify on before sending PR
some of the changes made by uncrustify need to be backed out again.

To bring everything back to the agreed upon style, run uncrustify once
more. Uncrustify version used:

	Uncrustify-0.70.1_f

I double checked the result by running uncrustify (Uncrustify-0.69.0_f)
from Ubuntu focal/20.04 which does not do any further changes and
uncrustify 0.66.1_f from Ubuntu bionic/18.04, which only produces one
small change:

-gc_addspecial(void *addr, void(free_function)(void *), struct gc_arena *a)
+gc_addspecial(void *addr, void (free_function)(void *), struct gc_arena *a)

I therefore went with the variant produced by the newer versions of
uncrustify.

The version uncrustify 0.59 produced a lot of changes, many of which
were not changed by this commit, so that version is too old.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/compat/compat-strsep.c        |  2 +-
 src/compat/compat.h               |  3 +-
 src/openvpn/buffer.c              |  2 +-
 src/openvpn/crypto.c              |  9 +++---
 src/openvpn/crypto.h              |  2 +-
 src/openvpn/cryptoapi.c           |  5 +--
 src/openvpn/forward.c             |  2 +-
 src/openvpn/forward.h             |  2 +-
 src/openvpn/manage.c              |  6 ++--
 src/openvpn/misc.c                |  2 +-
 src/openvpn/mroute.c              |  2 +-
 src/openvpn/networking.h          |  6 ++--
 src/openvpn/networking_iproute2.c | 14 ++++++++
 src/openvpn/networking_sitnl.h    |  2 +-
 src/openvpn/openvpn.h             |  2 +-
 src/openvpn/options.c             | 10 +++---
 src/openvpn/options.h             |  4 +--
 src/openvpn/proto.h               |  2 +-
 src/openvpn/push.c                | 20 ++++++------
 src/openvpn/route.c               |  2 +-
 src/openvpn/socket.h              | 54 +++++++++++++++----------------
 src/openvpn/ssl.c                 |  6 ++--
 src/openvpn/ssl.h                 |  1 +
 src/openvpn/ssl_mbedtls.c         | 21 ++++++------
 src/openvpn/ssl_openssl.c         | 28 ++++++++--------
 src/openvpn/ssl_verify.c          | 18 +++++------
 src/openvpn/ssl_verify.h          |  3 +-
 src/openvpn/vlan.c                |  4 +--
 src/openvpn/win32.h               |  2 +-
 29 files changed, 130 insertions(+), 106 deletions(-)

diff --git a/src/compat/compat-strsep.c b/src/compat/compat-strsep.c
index 42ff6414..e6518db6 100644
--- a/src/compat/compat-strsep.c
+++ b/src/compat/compat-strsep.c
@@ -58,4 +58,4 @@ strsep(char **stringp, const char *delim)
     }
     return begin;
 }
-#endif
+#endif /* ifndef HAVE_STRSEP */
diff --git a/src/compat/compat.h b/src/compat/compat.h
index 592881df..a66a4235 100644
--- a/src/compat/compat.h
+++ b/src/compat/compat.h
@@ -71,7 +71,8 @@ int inet_pton(int af, const char *src, void *dst);
 #endif
 
 #ifndef HAVE_STRSEP
-char* strsep(char **stringp, const char *delim);
+char *strsep(char **stringp, const char *delim);
+
 #endif
 
 #endif /* COMPAT_H */
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 8575e295..681d4541 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -474,7 +474,7 @@ x_gc_freespecial(struct gc_arena *a)
 }
 
 void
-gc_addspecial(void *addr, void (free_function)(void *), struct gc_arena *a)
+gc_addspecial(void *addr, void(free_function)(void *), struct gc_arena *a)
 {
     ASSERT(a);
     struct gc_entry_special *e;
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 453cb20a..1678cba8 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -736,13 +736,14 @@ crypto_max_overhead(void)
            +max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
 }
 
-static void warn_insecure_key_type(const char* ciphername, const cipher_kt_t *cipher)
+static void
+warn_insecure_key_type(const char *ciphername, const cipher_kt_t *cipher)
 {
     if (cipher_kt_insecure(cipher))
     {
         msg(M_WARN, "WARNING: INSECURE cipher (%s) with block size less than 128"
-                    " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
-                    "using a --cipher with a larger block size (e.g. AES-256-CBC).",
+            " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
+            "using a --cipher with a larger block size (e.g. AES-256-CBC).",
             ciphername, cipher_kt_block_size(cipher)*8);
     }
 }
@@ -846,7 +847,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
         cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher_length,
                         kt->cipher, enc);
 
-        const char* ciphername = translate_cipher_name_to_openvpn(cipher_kt_name(kt->cipher));
+        const char *ciphername = translate_cipher_name_to_openvpn(cipher_kt_name(kt->cipher));
         msg(D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
             prefix,
             ciphername,
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 18a86ceb..af3b382b 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -538,7 +538,7 @@ memcmp_constant_time(const void *a, const void *b, size_t size)
 
     for (i = 0; i < size; i++)
     {
-        ret |= *a1++ ^ *b1++;
+        ret |= *a1++ ^*b1++;
     }
 
     return ret;
diff --git a/src/openvpn/cryptoapi.c b/src/openvpn/cryptoapi.c
index 30eba7b2..6c4df9e3 100644
--- a/src/openvpn/cryptoapi.c
+++ b/src/openvpn/cryptoapi.c
@@ -803,12 +803,13 @@ find_certificate_in_store(const char *cert_prop, HCERTSTORE cert_store)
         }
         blob.cbData = i;
     }
-    else {
+    else
+    {
         msg(M_WARN, "WARNING: cryptoapicert: unsupported certificate specification <%s>", cert_prop);
         goto out;
     }
 
-    while(true)
+    while (true)
     {
         int validity = 1;
         /* this frees previous rv, if not NULL */
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index ea10f0bf..2082b9ea 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1278,7 +1278,7 @@ read_incoming_tun(struct context *c)
     ASSERT(buf_init(&c->c2.buf, FRAME_HEADROOM(&c->c2.frame)));
     ASSERT(buf_safe(&c->c2.buf, MAX_RW_SIZE_TUN(&c->c2.frame)));
     c->c2.buf.len = read_tun(c->c1.tuntap, BPTR(&c->c2.buf), MAX_RW_SIZE_TUN(&c->c2.frame));
-#endif
+#endif /* ifdef _WIN32 */
 
 #ifdef PACKET_TRUNCATION_CHECK
     ipv4_packet_size_verify(BPTR(&c->c2.buf),
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index b711ff00..ff898133 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -434,7 +434,7 @@ io_wait(struct context *c, const unsigned int flags)
             c->c2.event_set_status = ret;
         }
         else
-#endif
+#endif /* ifdef _WIN32 */
         {
             /* slow path */
             io_wait_dowork(c, flags);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 49864c0a..195941ca 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3660,9 +3660,9 @@ management_query_pk_sig(struct management *man, const char *b64_data,
         buf_write(&buf_data, ",", (int) strlen(","));
         buf_write(&buf_data, algorithm, (int) strlen(algorithm));
     }
-    char* ret = management_query_multiline_flatten(man,
-            (char *)buf_bptr(&buf_data), prompt, desc,
-            &man->connection.ext_key_state, &man->connection.ext_key_input);
+    char *ret = management_query_multiline_flatten(man,
+                                                   (char *)buf_bptr(&buf_data), prompt, desc,
+                                                   &man->connection.ext_key_state, &man->connection.ext_key_input);
     free_buf(&buf_data);
     return ret;
 }
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 1c17948c..a10888ed 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -146,7 +146,7 @@ auth_user_pass_mgmt(struct user_pass *up, const char *prefix, const unsigned int
     }
     return true;
 }
-#endif
+#endif /* ifdef ENABLE_MANAGEMENT */
 
 /*
  * Get and store a username/password
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index bdb1b0c0..a7e78213 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -324,7 +324,7 @@ mroute_extract_addr_ether(struct mroute_addr *src,
                     break;
             }
         }
-#endif
+#endif /* ifdef ENABLE_PF */
     }
     return ret;
 }
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 5e6d898f..9c1d1696 100644
--- a/src/openvpn/networking.h
+++ b/src/openvpn/networking.h
@@ -31,8 +31,8 @@ struct context;
 #include "networking_iproute2.h"
 #else
 /* define mock types to ensure code builds on any platform */
-typedef void * openvpn_net_ctx_t;
-typedef void * openvpn_net_iface_t;
+typedef void *openvpn_net_ctx_t;
+typedef void *openvpn_net_iface_t;
 
 static inline int
 net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
@@ -51,7 +51,7 @@ net_ctx_free(openvpn_net_ctx_t *ctx)
 {
     (void)ctx;
 }
-#endif
+#endif /* ifdef ENABLE_SITNL */
 
 #if defined(ENABLE_SITNL) || defined(ENABLE_IPROUTE)
 
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 0f9e899a..f3b9c614 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -43,7 +43,9 @@ net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
 {
     ctx->es = NULL;
     if (c)
+    {
         ctx->es = c->es;
+    }
     ctx->gc = gc_new();
 
     return 0;
@@ -207,10 +209,14 @@ net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
     argv_printf(&argv, "%s route add %s/%d", iproute_path, dst_str, prefixlen);
 
     if (metric > 0)
+    {
         argv_printf_cat(&argv, "metric %d", metric);
+    }
 
     if (iface)
+    {
         argv_printf_cat(&argv, "dev %s", iface);
+    }
 
     if (gw)
     {
@@ -246,7 +252,9 @@ net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
     }
 
     if (metric > 0)
+    {
         argv_printf_cat(&argv, "metric %d", metric);
+    }
 
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 add command failed");
@@ -267,7 +275,9 @@ net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
     argv_printf(&argv, "%s route del %s/%d", iproute_path, dst_str, prefixlen);
 
     if (metric > 0)
+    {
         argv_printf_cat(&argv, "metric %d", metric);
+    }
 
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route delete command failed");
@@ -296,7 +306,9 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
     }
 
     if (metric > 0)
+    {
         argv_printf_cat(&argv, "metric %d", metric);
+    }
 
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 del command failed");
@@ -314,7 +326,9 @@ net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
 
     FILE *fp = fopen("/proc/net/route", "r");
     if (!fp)
+    {
         return -1;
+    }
 
     char line[256];
     int count = 0;
diff --git a/src/openvpn/networking_sitnl.h b/src/openvpn/networking_sitnl.h
index f39d426d..6396b06e 100644
--- a/src/openvpn/networking_sitnl.h
+++ b/src/openvpn/networking_sitnl.h
@@ -23,6 +23,6 @@
 #define NETWORKING_SITNL_H_
 
 typedef char openvpn_net_iface_t;
-typedef void * openvpn_net_ctx_t;
+typedef void *openvpn_net_ctx_t;
 
 #endif /* NETWORKING_SITNL_H_ */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 900db7e1..595a9b1d 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -524,7 +524,7 @@ struct context
 
     struct env_set *es;         /**< Set of environment variables. */
 
-    openvpn_net_ctx_t net_ctx;	/**< Networking API opaque context */
+    openvpn_net_ctx_t net_ctx;  /**< Networking API opaque context */
 
     struct signal_info *sig;    /**< Internal error signaling object. */
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 49df8df1..63dc53c3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1241,8 +1241,10 @@ print_vlan_accept(enum vlan_acceptable_frames mode)
     {
         case VLAN_ONLY_TAGGED:
             return "tagged";
+
         case VLAN_ONLY_UNTAGGED_OR_PRIORITY:
             return "untagged";
+
         case VLAN_ALL:
             return "all";
     }
@@ -1320,7 +1322,7 @@ show_p2mp_parms(const struct options *o)
     SHOW_STR(port_share_port);
 #endif
     SHOW_BOOL(vlan_tagging);
-    msg(D_SHOW_PARMS, "  vlan_accept = %s", print_vlan_accept (o->vlan_accept));
+    msg(D_SHOW_PARMS, "  vlan_accept = %s", print_vlan_accept(o->vlan_accept));
     SHOW_INT(vlan_pvid);
 #endif /* P2MP_SERVER */
 
@@ -5301,7 +5303,7 @@ add_option(struct options *options,
         options->management_flags |= MF_EXTERNAL_CERT;
         options->management_certificate = p[1];
     }
-#endif
+#endif /* ifdef ENABLE_MANAGEMENT */
 #ifdef MANAGEMENT_DEF_AUTH
     else if (streq(p[0], "management-client-auth") && !p[1])
     {
@@ -7711,8 +7713,8 @@ add_option(struct options *options,
         }
         else
         {
-            if (streq(p[1], "secret") || streq(p[1], "tls-auth") ||
-                streq(p[1], "tls-crypt"))
+            if (streq(p[1], "secret") || streq(p[1], "tls-auth")
+                || streq(p[1], "tls-crypt"))
             {
                 options->genkey_type = GENKEY_SECRET;
             }
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 2f1f6faf..4c1737e1 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -222,8 +222,8 @@ struct options
     bool show_curves;
     bool genkey;
     enum genkey_type genkey_type;
-    const char* genkey_filename;
-    const char* genkey_extra_data;
+    const char *genkey_filename;
+    const char *genkey_extra_data;
 
     /* Networking parms */
     int connect_retry_max;
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index c1ff3e14..c2517674 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -67,7 +67,7 @@ struct openvpn_ethhdr
 struct openvpn_8021qhdr
 {
     uint8_t dest[OPENVPN_ETH_ALEN];     /* destination ethernet addr */
-    uint8_t source[OPENVPN_ETH_ALEN];   /* source ethernet addr	*/
+    uint8_t source[OPENVPN_ETH_ALEN];   /* source ethernet addr */
 
     uint16_t tpid;                      /* 802.1Q Tag Protocol Identifier */
 #define OPENVPN_8021Q_MASK_PCP htons(0xE000) /* mask PCP out of pcp_cfi_vid */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index aef00d34..39a906d4 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -72,19 +72,19 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
         {
             switch (auth_retry_get())
             {
-            case AR_NONE:
-                c->sig->signal_received = SIGTERM; /* SOFT-SIGTERM -- Auth failure error */
-                break;
+                case AR_NONE:
+                    c->sig->signal_received = SIGTERM; /* SOFT-SIGTERM -- Auth failure error */
+                    break;
 
-            case AR_INTERACT:
-                ssl_purge_auth(false);
+                case AR_INTERACT:
+                    ssl_purge_auth(false);
 
-            case AR_NOINTERACT:
-                c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Auth failure error */
-                break;
+                case AR_NOINTERACT:
+                    c->sig->signal_received = SIGUSR1; /* SOFT-SIGUSR1 -- Auth failure error */
+                    break;
 
-            default:
-                ASSERT(0);
+                default:
+                    ASSERT(0);
             }
             c->sig->signal_text = "auth-failure";
         }
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index e0f8d201..51f76318 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2152,7 +2152,7 @@ delete_route(struct route_ipv4 *r,
 #if !defined(TARGET_ANDROID)
     const char *gateway;
 #endif
-#else
+#else  /* if !defined(TARGET_LINUX) */
     int metric;
 #endif
     int is_local_route;
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index e95547d1..21e4ccf8 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -298,35 +298,35 @@ int openvpn_connect(socket_descriptor_t sd,
  */
 
 void
-link_socket_init_phase1(struct link_socket *sock,
-                        const char *local_host,
-                        const char *local_port,
-                        const char *remote_host,
-                        const char *remote_port,
-                        struct cached_dns_entry *dns_cache,
-                        int proto,
-                        sa_family_t af,
-                        bool bind_ipv6_only,
-                        int mode,
-                        const struct link_socket *accept_from,
-                        struct http_proxy_info *http_proxy,
-                        struct socks_proxy_info *socks_proxy,
+    link_socket_init_phase1(struct link_socket *sock,
+                            const char *local_host,
+                            const char *local_port,
+                            const char *remote_host,
+                            const char *remote_port,
+                            struct cached_dns_entry *dns_cache,
+                            int proto,
+                            sa_family_t af,
+                            bool bind_ipv6_only,
+                            int mode,
+                            const struct link_socket *accept_from,
+                            struct http_proxy_info *http_proxy,
+                            struct socks_proxy_info *socks_proxy,
 #ifdef ENABLE_DEBUG
-                        int gremlin,
+                            int gremlin,
 #endif
-                        bool bind_local,
-                        bool remote_float,
-                        int inetd,
-                        struct link_socket_addr *lsa,
-                        const char *ipchange_command,
-                        const struct plugin_list *plugins,
-                        int resolve_retry_seconds,
-                        int mtu_discover_type,
-                        int rcvbuf,
-                        int sndbuf,
-                        int mark,
-                        struct event_timeout *server_poll_timeout,
-                        unsigned int sockflags);
+                            bool bind_local,
+                            bool remote_float,
+                            int inetd,
+                            struct link_socket_addr *lsa,
+                            const char *ipchange_command,
+                            const struct plugin_list *plugins,
+                            int resolve_retry_seconds,
+                            int mtu_discover_type,
+                            int rcvbuf,
+                            int sndbuf,
+                            int mark,
+                            struct event_timeout *server_poll_timeout,
+                            unsigned int sockflags);
 
 void link_socket_init_phase2(struct link_socket *sock,
                              const struct frame *frame,
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 56d0576a..80e0d5ac 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -466,7 +466,7 @@ ssl_set_auth_token(const char *token)
  * Cleans an auth token and checks if it was active
  */
 bool
-ssl_clean_auth_token (void)
+ssl_clean_auth_token(void)
 {
     bool wasdefined = auth_token.defined;
     purge_user_pass(&auth_token, true);
@@ -2015,7 +2015,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     {
         frame_remove_from_extra_frame(frame_fragment, crypto_max_overhead());
         crypto_adjust_frame_parameters(frame_fragment, &session->opt->key_type,
-	                               options->replay, packet_id_long_form);
+                                       options->replay, packet_id_long_form);
         frame_set_mtu_dynamic(frame_fragment, options->ce.fragment, SET_MTU_UPPER_BOUND);
         frame_print(frame_fragment, D_MTU_INFO, "Fragmentation MTU parms");
     }
@@ -2411,7 +2411,9 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
          * username/password
          */
         if (auth_token.defined)
+        {
             up = &auth_token;
+        }
 
         if (!write_string(buf, up->username, -1))
         {
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index f0a8ef54..2f6f7657 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -607,4 +607,5 @@ void
 show_available_tls_ciphers(const char *cipher_list,
                            const char *cipher_list_tls13,
                            const char *tls_cert_profile);
+
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 4f194ad7..727d295a 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -191,12 +191,13 @@ tls_ctx_initialised(struct tls_root_ctx *ctx)
 }
 
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
-int mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
-                               const unsigned char *kb, size_t maclen,
-                               size_t keylen, size_t ivlen,
-                               const unsigned char client_random[32],
-                               const unsigned char server_random[32],
-                               mbedtls_tls_prf_types tls_prf_type)
+int
+mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
+                           const unsigned char *kb, size_t maclen,
+                           size_t keylen, size_t ivlen,
+                           const unsigned char client_random[32],
+                           const unsigned char server_random[32],
+                           mbedtls_tls_prf_types tls_prf_type)
 {
     struct tls_session *session = p_expkey;
     struct key_state_ssl *ks_ssl = &session->key[KS_PRIMARY].ks_ssl;
@@ -210,9 +211,9 @@ int mbedtls_ssl_export_keys_cb(void *p_expkey, const unsigned char *ms,
 
     const size_t ms_len = sizeof(ks_ssl->ctx->session->master);
     int ret = mbedtls_ssl_tls_prf(
-            tls_prf_type, ms, ms_len, session->opt->ekm_label,
-            client_server_random, sizeof(client_server_random),
-            ks_ssl->exported_key_material, session->opt->ekm_size);
+        tls_prf_type, ms, ms_len, session->opt->ekm_label,
+        client_server_random, sizeof(client_server_random),
+        ks_ssl->exported_key_material, session->opt->ekm_size);
 
     if (!mbed_ok(ret))
     {
@@ -1126,7 +1127,7 @@ key_state_ssl_init(struct key_state_ssl *ks_ssl,
     if (session->opt->ekm_size)
     {
         mbedtls_ssl_conf_export_keys_ext_cb(ks_ssl->ssl_config,
-                mbedtls_ssl_export_keys_cb, session);
+                                            mbedtls_ssl_export_keys_cb, session);
     }
 #endif
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index d7bd6aa2..5955c6bd 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -683,7 +683,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
          * so do nothing */
 #endif
         return;
-#else
+#else  /* if OPENSSL_VERSION_NUMBER >= 0x10002000L */
         /* For older OpenSSL we have to extract the curve from key on our own */
         EC_KEY *eckey = NULL;
         const EC_GROUP *ecgrp = NULL;
@@ -1173,7 +1173,7 @@ openvpn_extkey_rsa_finish(RSA *rsa)
  * interface query
  */
 const char *
-get_rsa_padding_name (const int padding)
+get_rsa_padding_name(const int padding)
 {
     switch (padding)
     {
@@ -1190,14 +1190,14 @@ get_rsa_padding_name (const int padding)
 
 /**
  * Pass the input hash in 'dgst' to management and get the signature back.
-  *
- * @param dgst		hash to be signed
- * @param dgstlen	len of data in dgst
- * @param sig 		On successful return signature is in sig.
- * @param siglen	length of buffer sig
- * @param algorithm	padding/hashing algorithm for the signature
  *
- * @return 		signature length or -1 on error.
+ * @param dgst          hash to be signed
+ * @param dgstlen       len of data in dgst
+ * @param sig           On successful return signature is in sig.
+ * @param siglen        length of buffer sig
+ * @param algorithm     padding/hashing algorithm for the signature
+ *
+ * @return              signature length or -1 on error.
  */
 static int
 get_sig_from_man(const unsigned char *dgst, unsigned int dgstlen,
@@ -1239,7 +1239,7 @@ rsa_priv_enc(int flen, const unsigned char *from, unsigned char *to, RSA *rsa,
         return -1;
     }
 
-    ret = get_sig_from_man(from, flen, to, len, get_rsa_padding_name (padding));
+    ret = get_sig_from_man(from, flen, to, len, get_rsa_padding_name(padding));
 
     return (ret == len) ? ret : -1;
 }
@@ -1314,7 +1314,7 @@ err:
 }
 
 #if ((OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)) \
-     || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
+    || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
     && !defined(OPENSSL_NO_EC)
 
 /* called when EC_KEY is destroyed */
@@ -1475,7 +1475,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
         }
     }
 #if ((OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)) \
-     || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
+    || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
     && !defined(OPENSSL_NO_EC)
     else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
     {
@@ -2135,8 +2135,8 @@ show_available_tls_ciphers_list(const char *cipher_list,
         crypto_msg(M_FATAL, "Cannot create SSL object");
     }
 
-#if (OPENSSL_VERSION_NUMBER < 0x1010000fL) || \
-    (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER <= 0x2090000fL)
+#if (OPENSSL_VERSION_NUMBER < 0x1010000fL)    \
+    || (defined(LIBRESSL_VERSION_NUMBER) && LIBRESSL_VERSION_NUMBER <= 0x2090000fL)
     STACK_OF(SSL_CIPHER) *sk = SSL_get_ciphers(ssl);
 #else
     STACK_OF(SSL_CIPHER) *sk = SSL_get1_supported_ciphers(ssl);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index da0966c5..9362b8e9 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -804,7 +804,7 @@ cleanup:
 #endif
 
 void
-auth_set_client_reason(struct tls_multi* multi, const char* client_reason)
+auth_set_client_reason(struct tls_multi *multi, const char *client_reason)
 {
     if (multi->client_reason)
     {
@@ -1204,7 +1204,7 @@ verify_user_pass_plugin(struct tls_session *session, struct tls_multi *multi,
 
 static int
 verify_user_pass_management(struct tls_session *session,
-                            struct tls_multi* multi,
+                            struct tls_multi *multi,
                             const struct user_pass *up)
 {
     int retval = KMDA_ERROR;
@@ -1301,16 +1301,16 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
              * for equality with AUTH_TOKEN_HMAC_OK
              */
             msg(M_WARN, "TLS: Username/auth-token authentication "
-                        "succeeded for username '%s'",
+                "succeeded for username '%s'",
                 up->username);
-              skip_auth = true;
+            skip_auth = true;
         }
         else
         {
             wipe_auth_token(multi);
             ks->authenticated = false;
             msg(M_WARN, "TLS: Username/auth-token authentication "
-                        "failed for username '%s'", up->username);
+                "failed for username '%s'", up->username);
             return;
         }
     }
@@ -1335,12 +1335,12 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     }
 
     /* check sizing of username if it will become our common name */
-    if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) &&
-         strlen(up->username)>TLS_USERNAME_LEN)
+    if ((session->opt->ssl_flags & SSLF_USERNAME_AS_COMMON_NAME)
+        && strlen(up->username)>TLS_USERNAME_LEN)
     {
         msg(D_TLS_ERRORS,
-                "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters",
-                TLS_USERNAME_LEN);
+            "TLS Auth Error: --username-as-common name specified and username is longer than the maximum permitted Common Name length of %d characters",
+            TLS_USERNAME_LEN);
         s1 = OPENVPN_PLUGIN_FUNC_ERROR;
     }
     /* auth succeeded? */
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index c54b89a6..21b37a0f 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -234,7 +234,8 @@ bool tls_authenticate_key(struct tls_multi *multi, const unsigned int mda_key_id
  * @param multi             The multi tls struct
  * @param client_reason     The string to send to the client as part of AUTH_FAILED
  */
-void auth_set_client_reason(struct tls_multi* multi, const char* client_reason);
+void auth_set_client_reason(struct tls_multi *multi, const char *client_reason);
+
 #endif
 
 static inline const char *
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index a5885de2..9290179d 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -58,7 +58,7 @@ static void
 vlanhdr_set_vid(struct openvpn_8021qhdr *hdr, const uint16_t vid)
 {
     hdr->pcp_cfi_vid = (hdr->pcp_cfi_vid & ~OPENVPN_8021Q_MASK_VID)
-                        | (htons(vid) & OPENVPN_8021Q_MASK_VID);
+                       | (htons(vid) & OPENVPN_8021Q_MASK_VID);
 }
 
 /*
@@ -135,7 +135,7 @@ vlan_decapsulate(const struct context *c, struct buffer *buf)
                 goto drop;
             }
 
-            /* vid == 0 means prio-tagged packet: don't drop and fall-through */
+        /* vid == 0 means prio-tagged packet: don't drop and fall-through */
         case VLAN_ONLY_TAGGED:
         case VLAN_ALL:
             /* tagged frame can be accepted: extract vid and strip encapsulation */
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 4b508c56..79504776 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -69,7 +69,7 @@ struct security_attributes
 struct window_title
 {
     bool saved;
-    char old_window_title [256];
+    char old_window_title[256];
 };
 
 struct rw_handle {
-- 
2.26.0


