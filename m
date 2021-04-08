From: Arne Schwabe <arne@...1227...>
Date: Thu,  8 Apr 2021 16:02:28 +0200
Message-Id: <20210408140229.31824-4-arne@...1227...>
In-Reply-To: <20210408140229.31824-1-arne@...1227...>
References: <20210408140229.31824-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 3/3] Support NCP in pure P2P VPN setups
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

Currently P2P mode of OpenVPN is on of the few places that cannot negotiate
modern OpenVPN features. This becomes more and more problematic since P2P and
P2MP code diverge more and more and also the lack of switching to more
advanced features like Data v2 currently blocks P2P mode from working
together with the upcoming ovpn-dco support.

This NCP support is a lot simpler and works in the following way:

- P2P peer announce an extremely limited IV_ variable set
  (IV_PROTO and IV_CIPHERS)
- Both peers check if the IV_PROTO_NCP_P2P bit is present in IV_PROTO
- if yes both sides deterministically determine according to
  IV_PROTO and IV_CIPHER what options can be used and start using these

There are no poor man's NCP or other compatibility workaround like in the
normal NCP, making this NCP leanear and more deterministic.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c                  | 100 ++++++++++++++---
 src/openvpn/options.c               |   8 +-
 src/openvpn/ssl.c                   | 168 +++++++++++++++++++---------
 src/openvpn/ssl.h                   |   5 +
 src/openvpn/ssl_backend.h           |   1 +
 src/openvpn/ssl_common.h            |  10 ++
 src/openvpn/ssl_ncp.c               | 145 ++++++++++++++++++++++++
 src/openvpn/ssl_ncp.h               |  25 +++++
 tests/unit_tests/openvpn/test_ncp.c |  11 ++
 9 files changed, 403 insertions(+), 70 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4a6b84914..11ac8b776 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -68,6 +68,7 @@ static const char *saved_pid_file_name; /* GLOBAL */
 #define CF_INIT_TLS_AUTH_STANDALONE (1<<2)
 
 static void do_init_first_time(struct context *c);
+static bool do_deferred_p2p_ncp(struct context *c);
 
 void
 context_clear(struct context *c)
@@ -2151,6 +2152,14 @@ do_up(struct context *c, bool pulled_options, unsigned int option_types_found)
                 return false;
             }
         }
+        else if (c->mode == MODE_POINT_TO_POINT)
+        {
+            if (!do_deferred_p2p_ncp(c))
+            {
+                msg(D_TLS_ERRORS, "ERROR: Failed to apply P2P negotiated protocol options");
+                return false;
+            }
+        }
 
         /* if --up-delay specified, open tun, do ifconfig, and run up script now */
         if (c->options.up_delay || PULL_DEFINED(&c->options))
@@ -2237,6 +2246,72 @@ pull_permission_mask(const struct context *c)
     return flags;
 }
 
+static
+void adjust_mtu_peerid(struct context *c)
+{
+    frame_add_to_extra_frame(&c->c2.frame, +3);     /* peer-id overhead */
+    if (!c->options.ce.link_mtu_defined)
+    {
+        frame_add_to_link_mtu(&c->c2.frame, +3);
+        msg(D_PUSH, "OPTIONS IMPORT: adjusting link_mtu to %d",
+            EXPANDED_SIZE(&c->c2.frame));
+    }
+    else
+    {
+        msg(M_WARN, "OPTIONS IMPORT: WARNING: peer-id set, but link-mtu"
+                    " fixed by config - reducing tun-mtu to %d, expect"
+                    " MTU problems", TUN_MTU_SIZE(&c->c2.frame) );
+    }
+}
+
+static bool
+do_deferred_p2p_ncp(struct context *c)
+{
+
+    if (!c->c2.tls_multi)
+    {
+        return true;
+    }
+
+    if (c->c2.tls_multi->use_peer_id)
+    {
+        adjust_mtu_peerid(c);
+    }
+
+    struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+
+    const char *ncp_cipher = get_p2p_ncp_cipher(session, c->c2.tls_multi->peer_info,
+                                                &c->options.gc);
+
+    if (ncp_cipher)
+    {
+        c->options.ciphername = ncp_cipher;
+    }
+    else if (!c->options.enable_ncp_fallback)
+    {
+        msg(D_TLS_ERRORS, "ERROR: failed to negotiate cipher with peer and "
+                          "--data-ciphers-fallback not enabled. No useable "
+                          "data channel cipher");
+        return false;
+    }
+
+    struct frame *frame_fragment = NULL;
+#ifdef ENABLE_FRAGMENT
+    if (c->options.ce.fragment)
+    {
+        frame_fragment = &c->c2.frame_fragment;
+    }
+#endif
+
+    if (!tls_session_update_crypto_params(session, &c->options, &c->c2.frame,
+                                         frame_fragment))
+    {
+        msg(D_TLS_ERRORS, "ERROR: failed to set crypto cipher");
+        return false;
+    }
+    return true;
+}
+
 /*
  * Handle non-tun-related pulled options.
  */
@@ -2324,19 +2399,7 @@ do_deferred_options(struct context *c, const unsigned int found)
         msg(D_PUSH, "OPTIONS IMPORT: peer-id set");
         c->c2.tls_multi->use_peer_id = true;
         c->c2.tls_multi->peer_id = c->options.peer_id;
-        frame_add_to_extra_frame(&c->c2.frame, +3);     /* peer-id overhead */
-        if (!c->options.ce.link_mtu_defined)
-        {
-            frame_add_to_link_mtu(&c->c2.frame, +3);
-            msg(D_PUSH, "OPTIONS IMPORT: adjusting link_mtu to %d",
-                EXPANDED_SIZE(&c->c2.frame));
-        }
-        else
-        {
-            msg(M_WARN, "OPTIONS IMPORT: WARNING: peer-id set, but link-mtu"
-                " fixed by config - reducing tun-mtu to %d, expect"
-                " MTU problems", TUN_MTU_SIZE(&c->c2.frame) );
-        }
+        adjust_mtu_peerid(c);
     }
 
     /* process (potentially pushed) crypto options */
@@ -2865,16 +2928,21 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.pull = options->pull;
     if (options->push_peer_info)        /* all there is */
     {
-        to.push_peer_info_detail = 2;
+        to.push_peer_info_detail = 3;
     }
     else if (options->pull)             /* pull clients send some details */
     {
-        to.push_peer_info_detail = 1;
+        to.push_peer_info_detail = 2;
     }
-    else                                /* default: no peer-info at all */
+    else if (options->mode == MODE_SERVER) /* server: no peer info at all */
     {
         to.push_peer_info_detail = 0;
     }
+    else                  /* default: minimal info to allow NCP in P2P mode */
+    {
+        to.push_peer_info_detail = 1;
+    }
+
 
     /* should we not xmit any packets until we get an initial
      * response from client? */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e2759a1ac..26489becb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3057,10 +3057,6 @@ options_postprocess_cipher(struct options *o)
 {
     if (!o->pull && !(o->mode == MODE_SERVER))
     {
-        /* we are in the classic P2P mode */
-        msg( M_WARN, "Cipher negotiation is disabled since neither "
-             "P2MP client nor server mode is enabled");
-
         /* If the cipher is not set, use the old default of BF-CBC. We will
          * warn that this is deprecated on cipher initialisation, no need
          * to warn here as well */
@@ -3068,6 +3064,10 @@ options_postprocess_cipher(struct options *o)
         {
             o->ciphername = "BF-CBC";
         }
+        else
+        {
+            o->enable_ncp_fallback = true;
+        }
         return;
     }
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 068b66616..20acf65ea 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1836,33 +1836,18 @@ cleanup:
     return ret;
 }
 
+
 bool
-tls_session_update_crypto_params(struct tls_session *session,
-                                 struct options *options, struct frame *frame,
+tls_session_update_crypto_params_do_work(struct tls_session *session,
+                                 struct options* options, struct frame *frame,
                                  struct frame *frame_fragment)
 {
     if (session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized)
     {
         /* keys already generated, nothing to do */
         return true;
-    }
-
-    bool cipher_allowed_as_fallback = options->enable_ncp_fallback
-                                      && streq(options->ciphername, session->opt->config_ciphername);
 
-    if (!session->opt->server && !cipher_allowed_as_fallback
-        && !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
-    {
-        msg(D_TLS_ERRORS, "Error: pushed cipher not allowed - %s not in %s",
-            options->ciphername, options->ncp_ciphers);
-        /* undo cipher push, abort connection setup */
-        options->ciphername = session->opt->config_ciphername;
-        return false;
     }
-
-    /* Import crypto settings that might be set by pull/push */
-    session->opt->crypto_flags |= options->data_channel_crypto_flags;
-
     if (strcmp(options->ciphername, session->opt->config_ciphername))
     {
         msg(D_HANDSHAKE, "Data Channel: using negotiated cipher '%s'",
@@ -1914,6 +1899,32 @@ tls_session_update_crypto_params(struct tls_session *session,
     return tls_session_generate_data_channel_keys(session);
 }
 
+bool
+tls_session_update_crypto_params(struct tls_session *session,
+                                 struct options *options, struct frame *frame,
+                                 struct frame *frame_fragment)
+{
+
+    bool cipher_allowed_as_fallback = options->enable_ncp_fallback
+        && streq(options->ciphername, session->opt->config_ciphername);
+
+    if (!session->opt->server && !cipher_allowed_as_fallback
+        && !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
+    {
+        msg(D_TLS_ERRORS, "Error: negotiated cipher not allowed - %s not in %s",
+            options->ciphername, options->ncp_ciphers);
+        /* undo cipher push, abort connection setup */
+        options->ciphername = session->opt->config_ciphername;
+        return false;
+    }
+
+    /* Import crypto settings that might be set by pull/push */
+    session->opt->crypto_flags |= options->data_channel_crypto_flags;
+
+    return tls_session_update_crypto_params_do_work(session, options, frame, frame_fragment);
+}
+
+
 static bool
 random_bytes_to_buf(struct buffer *buf,
                     uint8_t *out,
@@ -2107,12 +2118,10 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 {
     struct gc_arena gc = gc_new();
     bool ret = false;
+    struct buffer out = alloc_buf_gc(512 * 3, &gc);
 
-    if (session->opt->push_peer_info_detail > 0)
+    if (session->opt->push_peer_info_detail > 1)
     {
-        struct env_set *es = session->opt->es;
-        struct buffer out = alloc_buf_gc(512*3, &gc);
-
         /* push version */
         buf_printf(&out, "IV_VER=%s\n", PACKAGE_VERSION);
 
@@ -2134,7 +2143,11 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 #elif defined(_WIN32)
         buf_printf(&out, "IV_PLAT=win\n");
 #endif
+    }
 
+    /* These are the IV variable that are sent to peers in p2p mode */
+    if (session->opt->push_peer_info_detail > 0)
+    {
         /* support for P_DATA_V2 */
         int iv_proto = IV_PROTO_DATA_V2;
 
@@ -2157,19 +2170,28 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 
                 buf_printf(&out, "IV_NCP=2\n");
             }
-            buf_printf(&out, "IV_CIPHERS=%s\n", session->opt->config_ncp_ciphers);
+        }
+        else
+        {
+            /* We are not using pull or p2mp server, instead do P2P NCP */
+            iv_proto |= IV_PROTO_NCP_P2P;
+        }
+
+        buf_printf(&out, "IV_CIPHERS=%s\n", session->opt->config_ncp_ciphers);
 
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
-            iv_proto |= IV_PROTO_TLS_KEY_EXPORT;
+        iv_proto |= IV_PROTO_TLS_KEY_EXPORT;
 #endif
-        }
 
         buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
 
-        /* push compression status */
+        if (session->opt->push_peer_info_detail > 1)
+        {
+            /* push compression status */
 #ifdef USE_COMP
-        comp_generate_peer_info_string(&session->opt->comp_options, &out);
+            comp_generate_peer_info_string(&session->opt->comp_options, &out);
 #endif
+        }
 
         if (session->opt->push_peer_info_detail >= 2)
         {
@@ -2186,24 +2208,29 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
 #endif
         }
 
-        /* push env vars that begin with UV_, IV_PLAT_VER and IV_GUI_VER */
-        for (struct env_item *e = es->list; e != NULL; e = e->next)
+        if (session->opt->push_peer_info_detail > 1)
         {
-            if (e->string)
+            struct env_set *es = session->opt->es;
+            /* push env vars that begin with UV_, IV_PLAT_VER and IV_GUI_VER */
+            for (struct env_item *e = es->list; e != NULL; e = e->next)
             {
-                if ((((strncmp(e->string, "UV_", 3)==0
-                       || strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=")-1)==0)
-                      && session->opt->push_peer_info_detail >= 2)
-                     || (strncmp(e->string,"IV_GUI_VER=",sizeof("IV_GUI_VER=")-1)==0)
-                     || (strncmp(e->string,"IV_SSO=",sizeof("IV_SSO=")-1)==0)
-                     )
-                    && buf_safe(&out, strlen(e->string)+1))
+                if (e->string)
                 {
-                    buf_printf(&out, "%s\n", e->string);
+                    if ((((strncmp(e->string, "UV_", 3) == 0
+                        || strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=") - 1) == 0)
+                        && session->opt->push_peer_info_detail >= 2)
+                        || (strncmp(e->string, "IV_GUI_VER=", sizeof("IV_GUI_VER=") - 1) == 0)
+                        || (strncmp(e->string, "IV_SSO=", sizeof("IV_SSO=") - 1) == 0)
+                    )
+                        && buf_safe(&out, strlen(e->string) + 1))
+                    {
+                        buf_printf(&out, "%s\n", e->string);
+                    }
                 }
             }
         }
 
+
         if (!write_string(buf, BSTR(&out), -1))
         {
             goto error;
@@ -2342,19 +2369,47 @@ key_method_2_write(struct buffer *buf, struct tls_multi *multi, struct tls_sessi
         goto error;
     }
 
-    /* Generate tunnel keys if we're a TLS server.
+    /*
+     * Generate tunnel keys if we're a TLS server.
+     *
      * If we're a p2mp server and IV_NCP >= 2 is negotiated, the first key
      * generation is postponed until after the pull/push, so we can process pushed
      * cipher directives.
+     *
+     * Generate tunnel keys if are not using NCP as TLS server.
+     *
+     * If we're a p2mp server to allow NCP, the first key
+     * generation is postponed until after the connect script finished and the
+     * NCP options can be processed. Since that always happens at after connect
+     * script options are available the CAS_SUCCEEDED status is identical to
+     * NCP options are processed and we have no extra state for NCP finished.
+     *
+     * As P2P TLS server we also postpone the key generation just long enough
+     * until the TLS session is fully established.
      */
-    if (session->opt->server && !(session->opt->mode == MODE_SERVER && ks->key_id <= 0))
+    if (session->opt->server)
     {
-        if (ks->authenticated > KS_AUTH_FALSE)
+        if(session->opt->mode != MODE_SERVER && ks->key_id == 0)
         {
-            if (!tls_session_generate_data_channel_keys(session))
+            /* tls-server option set and not P2MP server, so we
+             * are a P2P client running in tls-server mode */
+            p2p_mode_ncp(multi, session);
+        }
+        else if ((session->opt->mode == MODE_SERVER && multi->multi_state == CAS_SUCCEEDED)
+            || ks->key_id > 0)
+        {
+            /* if key_id >= 1, is a renegotiation, so we use the already established
+             * parameters and do not need to delay anything. */
+
+            /* key-id == 0 and context_auth == CAS_SUCCEEDED is a special case of
+             * the server reusing the session of a reconnecting client. */
+            if (ks->authenticated > KS_AUTH_FALSE)
             {
-                msg(D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
-                goto error;
+                if (!tls_session_generate_data_channel_keys(session))
+                {
+                    msg(D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
+                    goto error;
+                }
             }
         }
     }
@@ -2561,15 +2616,28 @@ key_method_2_read(struct buffer *buf, struct tls_multi *multi, struct tls_sessio
 
     /*
      * Generate tunnel keys if we're a client.
-     * If --pull is enabled, the first key generation is postponed until after the
-     * pull/push, so we can process pushed cipher directives.
+     * If NCP is enabled, the first key generation is postponed until the TLS
+     * handshake has completed or even further delayed or after the pull
+     * response so we initialise the cipher after it is negotiated.
+     *
      */
-    if (!session->opt->server && (!session->opt->pull || ks->key_id > 0))
+    if (!session->opt->server)
     {
-        if (!tls_session_generate_data_channel_keys(session))
+        if (!session->opt->pull && ks->key_id == 0)
         {
-            msg(D_TLS_ERRORS, "TLS Error: client generate_key_expansion failed");
-            goto error;
+            /* We are a p2p tls-client without pull with NCP, enable common
+             * protocol options */
+            p2p_mode_ncp(multi, session);
+        }
+        else if (ks->key_id > 0)
+        {
+            /* if key_id >= 1, is a renogiation, so we use the channel
+             * paramter and do not need to delay anything */
+            if (!tls_session_generate_data_channel_keys(session))
+            {
+                msg(D_TLS_ERRORS, "TLS Error: client generate_key_expansion failed");
+                goto error;
+            }
         }
     }
 
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 300a70d35..f39d9d788 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -122,6 +122,11 @@
 /** Supports signaling keywords with AUTH_PENDING, e.g. timeout=xy */
 #define IV_PROTO_AUTH_PENDING_KW (1<<4)
 
+/** Support doing NCP in P2P mode. This mode works by both peers looking at
+ * each other's IV_ variables and deterministically deciding both on the same
+ * result. */
+#define IV_PROTO_NCP_P2P         (1<<5)
+
 /* Default field in X509 to be username */
 #define X509_USERNAME_FIELD_DEFAULT "CN"
 
diff --git a/src/openvpn/ssl_backend.h b/src/openvpn/ssl_backend.h
index c3d12e5be..d228c70d8 100644
--- a/src/openvpn/ssl_backend.h
+++ b/src/openvpn/ssl_backend.h
@@ -390,6 +390,7 @@ void backend_tls_ctx_reload_crl(struct tls_root_ctx *ssl_ctx,
                                 const char *crl_file, bool crl_inline);
 
 #define EXPORT_KEY_DATA_LABEL       "EXPORTER-OpenVPN-datakeys"
+#define EXPORT_P2P_PEERID_LABEL     "EXPORTER-OpenVPN-p2p-peerid"
 /**
  * Keying Material Exporters [RFC 5705] allows additional keying material to be
  * derived from existing TLS channel. This exported keying material can then be
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 3f8dd0178..9404be939 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -271,6 +271,16 @@ struct tls_options
     bool disable_occ;
     int mode;
     bool pull;
+    /**
+     * The detail of info we push in peer info
+     *
+     * 0 - nothing at all, P2MP server only
+     * 1 - only the most basic information to negotiate cipher and features
+     *     for P2P NCP
+     * 2 - normal setting for clients
+     * 3 - full information including "sensitive data" like IV_HWADDR
+     *     enabled by --push-peer-info
+     */
     int push_peer_info_detail;
     int transition_window;
     int handshake_window;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 722256b42..8850ba237 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -324,3 +324,148 @@ check_pull_client_ncp(struct context *c, const int found)
         return false;
     }
 }
+
+const char*
+get_p2p_ncp_cipher(struct tls_session *session, const char *peer_info,
+                   struct gc_arena *gc)
+{
+    /* we use a local gc arena to keep the temporary strings needed by strsep */
+    struct gc_arena gc_local = gc_new();
+    const char *peer_ciphers = extract_var_peer_info(peer_info, "IV_CIPHERS=", &gc_local);
+
+    if (!peer_ciphers)
+    {
+        gc_free(&gc_local);
+        return NULL;
+    }
+
+    const char* server_ciphers;
+    const char* client_ciphers;
+
+    if (session->opt->server)
+    {
+        server_ciphers = session->opt->config_ncp_ciphers;
+        client_ciphers = peer_ciphers;
+    }
+    else
+    {
+        client_ciphers = session->opt->config_ncp_ciphers;
+        server_ciphers = peer_ciphers;
+    }
+
+    /* Find the first common cipher from TLS server and TLS client. We
+     * use the preference of the server here to make it deterministic */
+    char *tmp_ciphers = string_alloc(server_ciphers, &gc_local);
+
+    const char *token;
+    while ((token = strsep(&tmp_ciphers, ":")))
+    {
+        if (tls_item_in_cipher_list(token, client_ciphers))
+        {
+            break;
+        }
+    }
+
+    const char *ret = NULL;
+    if (token != NULL)
+    {
+        const char *chosen_cipher = string_alloc(token, gc);
+        ret = chosen_cipher;
+    }
+    gc_free(&gc_local);
+
+    return ret;
+}
+
+static void
+p2p_ncp_set_options(struct tls_multi *multi, struct tls_session *session)
+{
+    /* will return 0 if peer_info is null */
+    const unsigned int iv_proto_peer = extract_iv_proto(multi->peer_info);
+
+    /* The other peer does not support P2P NCP */
+    if (!(iv_proto_peer & IV_PROTO_NCP_P2P))
+    {
+        return;
+    }
+
+    if (iv_proto_peer & IV_PROTO_DATA_V2)
+    {
+        multi->use_peer_id = true;
+        multi->peer_id = 0x76706e; // 'v' 'p' 'n'
+
+    }
+
+#if defined(HAVE_EXPORT_KEYING_MATERIAL)
+    if (iv_proto_peer & IV_PROTO_TLS_KEY_EXPORT)
+    {
+        session->opt->crypto_flags |= CO_USE_TLS_KEY_MATERIAL_EXPORT;
+
+        if (multi->use_peer_id)
+        {
+            /* Using a non hardcoded peer-id makes a tiny bit harder to
+             * fingerprint packets and also gives each connection a unique
+             * peer-id that can be useful for NAT tracking etc. */
+
+            uint8_t peerid[3];
+            if (!key_state_export_keying_material(session, EXPORT_P2P_PEERID_LABEL,
+                                                  strlen(EXPORT_P2P_PEERID_LABEL),
+                                                  &peerid, 3))
+            {
+                /* Non DCO setup might still work but also this should never
+                 * happen or very likely the TLS encryption key exporter will
+                 * also fail */
+                msg(M_NONFATAL, "TLS key export for P2P peer id failed. "
+                                "Continuing anyway, expect problems");
+            }
+            else
+            {
+                multi->peer_id = (peerid[0] << 16) + (peerid[1] << 8) + peerid[2];
+            }
+
+        }
+    }
+#endif
+}
+
+void
+p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session)
+{
+    /* Set the common options */
+    p2p_ncp_set_options(multi, session);
+
+    struct gc_arena gc = gc_new();
+
+    /* Query the common cipher here to log it as part of our message.
+     * We postpone switching the cipher to do_up */
+    const char* common_cipher = get_p2p_ncp_cipher(session, multi->peer_info, &gc);
+
+    if (!common_cipher)
+    {
+        struct buffer out = alloc_buf_gc(128, &gc);
+        struct key_state *ks = get_key_scan(multi, KS_PRIMARY);
+
+        const cipher_ctx_t *ctx = ks->crypto_options.key_ctx_bi.encrypt.cipher;
+        const cipher_kt_t *cipher = cipher_ctx_get_cipher_kt(ctx);
+        const char *fallback_name = cipher_kt_name(cipher);
+
+        if (!cipher)
+        {
+            /* at this point we do not really know if our fallback is
+             * not enabled or if we use 'none' cipher as fallback, so
+             * keep this ambiguity here and print fallback-cipher: none
+             */
+            fallback_name = "none";
+        }
+
+        buf_printf(&out, "(not negotiated, fallback-cipher: %s)", fallback_name);
+        common_cipher = BSTR(&out);
+    }
+
+    msg(D_TLS_DEBUG_LOW, "P2P mode NCP negotiation result: "
+                         "TLS_export=%d, DATA_v2=%d, peer-id %d, cipher=%s",
+                         (bool)(session->opt->crypto_flags & CO_USE_TLS_KEY_MATERIAL_EXPORT),
+                         multi->use_peer_id, multi->peer_id, common_cipher);
+
+    gc_free(&gc);
+}
\ No newline at end of file
diff --git a/src/openvpn/ssl_ncp.h b/src/openvpn/ssl_ncp.h
index 39158a568..c02be6939 100644
--- a/src/openvpn/ssl_ncp.h
+++ b/src/openvpn/ssl_ncp.h
@@ -32,6 +32,7 @@
 
 #include "buffer.h"
 #include "options.h"
+#include "ssl_common.h"
 
 /**
  * Returns whether the client supports NCP either by
@@ -115,4 +116,28 @@ bool tls_item_in_cipher_list(const char *item, const char *list);
  */
 #define MAX_NCP_CIPHERS_LENGTH 127
 
+/**
+ * Determines if there is common cipher of both peer by looking at the
+ * IV_CIPHER peer info. In contrast of the server mode NCP that tries to
+ * accomandate all kind of corner cases in P2P mode NCP only takes IV_CIPHER
+ * into account and falls back to previous behaviour if this fails.
+ */
+void p2p_mode_ncp(struct tls_multi *multi, struct tls_session *session);
+
+/**
+ * Determines the best common cipher from both peers IV_CIPHER lists. The
+ * first cipher from the tls-server that is also in the tls-client IV_CIPHER
+ * list will be returned. If no common cipher can be found, both peer
+ * will continue to use whatever cipher is their default and NULL will be
+ * returned.
+ *
+ * @param session       tls_session
+ * @param peer_info     peer info of the peer
+ * @param gc            gc arena that will be used to allocate the returned cipher
+ * @return              common cipher if one exist.
+ */
+const char *
+get_p2p_ncp_cipher(struct tls_session *session, const char *peer_info,
+                   struct gc_arena *gc);
+
 #endif /* ifndef OPENVPN_SSL_NCP_H */
diff --git a/tests/unit_tests/openvpn/test_ncp.c b/tests/unit_tests/openvpn/test_ncp.c
index 4077be5e8..9dcd6f0a7 100644
--- a/tests/unit_tests/openvpn/test_ncp.c
+++ b/tests/unit_tests/openvpn/test_ncp.c
@@ -44,6 +44,17 @@
 const char *bf_chacha = "BF-CBC:CHACHA20-POLY1305";
 const char *aes_ciphers = "AES-256-GCM:AES-128-GCM";
 
+
+/* Define this function here as dummy since including the ssl_*.c files
+ * leads to having to include even more unrelated code */
+bool
+key_state_export_keying_material(struct tls_session *session,
+                                 const char* label, size_t label_size,
+                                 void *ekm, size_t ekm_size)
+{
+    ASSERT(0);
+}
+
 static void
 test_check_ncp_ciphers_list(void **state)
 {
-- 
2.31.1


