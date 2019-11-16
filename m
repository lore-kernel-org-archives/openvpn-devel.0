From: Arne Schwabe <arne@...1227...>
Date: Sat, 16 Nov 2019 11:28:35 +0100
Message-Id: <20191116102835.22883-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Reformat all source files
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

Over time some patches slipped in that were not 100% complient to uncrustify
This rerun fixes those issues

This run used Uncrustify-0.69.0_f
---
 src/openvpn/buffer.c              |  2 +-
 src/openvpn/crypto.h              |  2 +-
 src/openvpn/networking.h          |  4 +--
 src/openvpn/networking_iproute2.c | 14 ++++++++
 src/openvpn/networking_sitnl.h    |  2 +-
 src/openvpn/openvpn.h             |  2 +-
 src/openvpn/options.c             |  8 +++--
 src/openvpn/options.h             |  4 +--
 src/openvpn/proto.h               |  2 +-
 src/openvpn/push.c                | 20 ++++++------
 src/openvpn/route.c               |  2 +-
 src/openvpn/socket.h              | 54 +++++++++++++++----------------
 src/openvpn/ssl.c                 |  6 ++--
 src/openvpn/ssl.h                 |  1 +
 src/openvpn/ssl_openssl.c         | 10 +++---
 src/openvpn/ssl_verify.c          | 18 +++++------
 src/openvpn/ssl_verify.h          |  3 +-
 src/openvpn/tun.c                 | 20 ++++++------
 src/openvpn/vlan.c                |  4 +--
 19 files changed, 99 insertions(+), 79 deletions(-)

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
diff --git a/src/openvpn/networking.h b/src/openvpn/networking.h
index 5e6d898f..f18e8875 100644
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
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 1db39fc7..8d373d26 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -42,7 +42,9 @@ net_ctx_init(struct context *c, openvpn_net_ctx_t *ctx)
 {
     ctx->es = NULL;
     if (c)
+    {
         ctx->es = c->es;
+    }
     ctx->gc = gc_new();
 
     return 0;
@@ -206,10 +208,14 @@ net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
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
@@ -245,7 +251,9 @@ net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
     }
 
     if (metric > 0)
+    {
         argv_printf_cat(&argv, "metric %d", metric);
+    }
 
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 add command failed");
@@ -266,7 +274,9 @@ net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
     argv_printf(&argv, "%s route del %s/%d", iproute_path, dst_str, prefixlen);
 
     if (metric > 0)
+    {
         argv_printf_cat(&argv, "metric %d", metric);
+    }
 
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route delete command failed");
@@ -295,7 +305,9 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
     }
 
     if (metric > 0)
+    {
         argv_printf_cat(&argv, "metric %d", metric);
+    }
 
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 del command failed");
@@ -313,7 +325,9 @@ net_route_v4_best_gw(openvpn_net_ctx_t *ctx, const in_addr_t *dst,
 
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
index c282b582..14fcc017 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1239,8 +1239,10 @@ print_vlan_accept(enum vlan_acceptable_frames mode)
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
@@ -1318,7 +1320,7 @@ show_p2mp_parms(const struct options *o)
     SHOW_STR(port_share_port);
 #endif
     SHOW_BOOL(vlan_tagging);
-    msg(D_SHOW_PARMS, "  vlan_accept = %s", print_vlan_accept (o->vlan_accept));
+    msg(D_SHOW_PARMS, "  vlan_accept = %s", print_vlan_accept(o->vlan_accept));
     SHOW_INT(vlan_pvid);
 #endif /* P2MP_SERVER */
 
@@ -7662,8 +7664,8 @@ add_option(struct options *options,
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
index 7fd2c00f..ce10a7c7 100644
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
index 368b6920..b4689c03 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -71,19 +71,19 @@ receive_auth_failed(struct context *c, const struct buffer *buffer)
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
index 97e90e56..7b9dfbd3 100644
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
index 4455ebb8..016f9b7a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -464,7 +464,7 @@ ssl_set_auth_token(const char *token)
  * Cleans an auth token and checks if it was active
  */
 bool
-ssl_clean_auth_token (void)
+ssl_clean_auth_token(void)
 {
     bool wasdefined = auth_token.defined;
     purge_user_pass(&auth_token, true);
@@ -2041,7 +2041,7 @@ tls_session_update_crypto_params(struct tls_session *session,
     {
         frame_remove_from_extra_frame(frame_fragment, crypto_max_overhead());
         crypto_adjust_frame_parameters(frame_fragment, &session->opt->key_type,
-	                               options->replay, packet_id_long_form);
+                                       options->replay, packet_id_long_form);
         frame_set_mtu_dynamic(frame_fragment, options->ce.fragment, SET_MTU_UPPER_BOUND);
         frame_print(frame_fragment, D_MTU_INFO, "Fragmentation MTU parms");
     }
@@ -2431,7 +2431,9 @@ key_method_2_write(struct buffer *buf, struct tls_session *session)
          * username/password
          */
         if (auth_token.defined)
+        {
             up = &auth_token;
+        }
 
         if (!write_string(buf, up->username, -1))
         {
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index a944ca3a..054c68fd 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -637,4 +637,5 @@ void
 show_available_tls_ciphers(const char *cipher_list,
                            const char *cipher_list_tls13,
                            const char *tls_cert_profile);
+
 #endif /* ifndef OPENVPN_SSL_H */
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 07916c3c..194fcf97 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -644,7 +644,7 @@ tls_ctx_load_ecdh_params(struct tls_root_ctx *ctx, const char *curve_name
         SSL_CTX_set_ecdh_auto(ctx->ctx, 1);
         return;
 #endif
-#else
+#else  /* if OPENSSL_VERSION_NUMBER >= 0x10002000L */
         /* For older OpenSSL we have to extract the curve from key on our own */
         EC_KEY *eckey = NULL;
         const EC_GROUP *ecgrp = NULL;
@@ -1218,7 +1218,7 @@ err:
 }
 
 #if ((OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)) \
-     || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
+    || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
     && !defined(OPENSSL_NO_EC)
 
 /* called when EC_KEY is destroyed */
@@ -1374,7 +1374,7 @@ tls_ctx_use_management_external_key(struct tls_root_ctx *ctx)
         }
     }
 #if ((OPENSSL_VERSION_NUMBER > 0x10100000L && !defined(LIBRESSL_VERSION_NUMBER)) \
-     || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
+    || LIBRESSL_VERSION_NUMBER > 0x2090000fL) \
     && !defined(OPENSSL_NO_EC)
     else if (EVP_PKEY_id(pkey) == EVP_PKEY_EC)
     {
@@ -2033,8 +2033,8 @@ show_available_tls_ciphers_list(const char *cipher_list,
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
index 65188d23..7f1bb56b 100644
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
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 599fd817..18099a1d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3418,7 +3418,7 @@ tun_finalize(
 }
 
 static const struct device_instance_id_interface *
-get_device_instance_id_interface(struct gc_arena* gc)
+get_device_instance_id_interface(struct gc_arena *gc)
 {
     HDEVINFO dev_info_set;
     DWORD err;
@@ -3489,7 +3489,7 @@ get_device_instance_id_interface(struct gc_arena* gc)
         }
 
         cr = CM_Get_Device_Interface_List_Size(&dev_interface_list_size,
-                                               (LPGUID)& GUID_DEVINTERFACE_NET,
+                                               (LPGUID)&GUID_DEVINTERFACE_NET,
                                                device_instance_id,
                                                CM_GET_DEVICE_INTERFACE_LIST_PRESENT);
 
@@ -3499,7 +3499,7 @@ get_device_instance_id_interface(struct gc_arena* gc)
         }
 
         dev_interface_list = alloc_buf_gc(dev_interface_list_size, gc);
-        cr = CM_Get_Device_Interface_List((LPGUID)& GUID_DEVINTERFACE_NET, device_instance_id,
+        cr = CM_Get_Device_Interface_List((LPGUID)&GUID_DEVINTERFACE_NET, device_instance_id,
                                           BPTR(&dev_interface_list),
                                           dev_interface_list_size,
                                           CM_GET_DEVICE_INTERFACE_LIST_PRESENT);
@@ -3508,7 +3508,7 @@ get_device_instance_id_interface(struct gc_arena* gc)
             goto next;
         }
 
-        struct device_instance_id_interface* dev_if;
+        struct device_instance_id_interface *dev_if;
         ALLOC_OBJ_CLEAR_GC(dev_if, struct device_instance_id_interface, gc);
         dev_if->net_cfg_instance_id = string_alloc(net_cfg_instance_id, gc);
         dev_if->device_interface_list = string_alloc(BSTR(&dev_interface_list), gc);
@@ -3524,7 +3524,7 @@ get_device_instance_id_interface(struct gc_arena* gc)
         }
         last = dev_if;
 
-    next:
+next:
         RegCloseKey(dev_key);
     }
 
@@ -3629,9 +3629,9 @@ get_tap_reg(struct gc_arena *gc)
 
                 if (status == ERROR_SUCCESS && data_type == REG_SZ)
                 {
-                    if (!strcmp(component_id, TAP_WIN_COMPONENT_ID) ||
-                        !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID) ||
-                        !strcmp(component_id, WINTUN_COMPONENT_ID))
+                    if (!strcmp(component_id, TAP_WIN_COMPONENT_ID)
+                        || !strcmp(component_id, "root\\" TAP_WIN_COMPONENT_ID)
+                        || !strcmp(component_id, WINTUN_COMPONENT_ID))
                     {
                         struct tap_reg *reg;
                         ALLOC_OBJ_CLEAR_GC(reg, struct tap_reg, gc);
@@ -5727,7 +5727,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 
                 if (tt->wintun)
                 {
-                    const struct device_instance_id_interface* dev_if;
+                    const struct device_instance_id_interface *dev_if;
 
                     if (!is_picked_device_wintun)
                     {
@@ -5782,7 +5782,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
                     break;
                 }
 
-            next:
+next:
                 device_number++;
             }
         }
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
-- 
2.22.0


