From: Gert Doering <gert@...1296...>
Date: Sat,  8 Mar 2025 11:04:55 +0100
Message-ID: <20250308100456.32383-1-gert@...1296...>
In-Reply-To: <gerrit.1736860439000.Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919@...2715...>
References: <gerrit.1736860439000.Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] Remove various unused function parameters
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

From: Frank Lichtenheld <frank@...2641...>

Change-Id: Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/862
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 8b94469..33ca2da 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -257,11 +257,11 @@
     }
     else if (buf_string_match_head_str(buf, "INFO_PRE"))
     {
-        server_pushed_info(c, buf, 8);
+        server_pushed_info(buf, 8);
     }
     else if (buf_string_match_head_str(buf, "INFO"))
     {
-        server_pushed_info(c, buf, 4);
+        server_pushed_info(buf, 4);
     }
     else if (buf_string_match_head_str(buf, "CR_RESPONSE"))
     {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 7ab9289..96333ab 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1763,8 +1763,7 @@
 }
 
 static void
-multi_client_connect_setenv(struct multi_context *m,
-                            struct multi_instance *mi)
+multi_client_connect_setenv(struct multi_instance *mi)
 {
     struct gc_arena gc = gc_new();
 
@@ -2559,7 +2558,7 @@
     /* do --client-connect setenvs */
     multi_select_virtual_addr(m, mi);
 
-    multi_client_connect_setenv(m, mi);
+    multi_client_connect_setenv(mi);
 }
 
 /**
@@ -2652,7 +2651,7 @@
              */
             multi_select_virtual_addr(m, mi);
 
-            multi_client_connect_setenv(m, mi);
+            multi_client_connect_setenv(mi);
 
             ret = CC_RET_SUCCEEDED;
         }
@@ -2924,7 +2923,6 @@
 multi_bcast(struct multi_context *m,
             const struct buffer *buf,
             const struct multi_instance *sender_instance,
-            const struct mroute_addr *sender_addr,
             uint16_t vid)
 {
     struct hash_iterator hi;
@@ -3452,7 +3450,7 @@
                     if (mroute_flags & MROUTE_EXTRACT_MCAST)
                     {
                         /* for now, treat multicast as broadcast */
-                        multi_bcast(m, &c->c2.to_tun, m->pending, NULL, 0);
+                        multi_bcast(m, &c->c2.to_tun, m->pending, 0);
                     }
                     else /* possible client to client routing */
                     {
@@ -3504,8 +3502,7 @@
                         {
                             if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
                             {
-                                multi_bcast(m, &c->c2.to_tun, m->pending, NULL,
-                                            vid);
+                                multi_bcast(m, &c->c2.to_tun, m->pending, vid);
                             }
                             else /* try client-to-client routing */
                             {
@@ -3598,7 +3595,7 @@
             if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
             {
                 /* for now, treat multicast as broadcast */
-                multi_bcast(m, &m->top.c2.buf, NULL, NULL, vid);
+                multi_bcast(m, &m->top.c2.buf, NULL, vid);
             }
             else
             {
@@ -3770,7 +3767,7 @@
 
         for (i = 0; i < parm.n_packets; ++i)
         {
-            multi_bcast(m, &buf, NULL, NULL, 0);
+            multi_bcast(m, &buf, NULL, 0);
         }
 
         gc_free(&gc);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6b2dfa5..dbae3a6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2118,7 +2118,6 @@
 parse_http_proxy_override(const char *server,
                           const char *port,
                           const char *flags,
-                          const int msglevel,
                           struct gc_arena *gc)
 {
     if (server && port)
@@ -2287,7 +2286,7 @@
 }
 
 static struct pull_filter *
-alloc_pull_filter(struct options *o, const int msglevel)
+alloc_pull_filter(struct options *o)
 {
     struct pull_filter_list *l = alloc_pull_filter_list(o);
     struct pull_filter *f;
@@ -6299,7 +6298,7 @@
     else if (streq(p[0], "http-proxy-override") && p[1] && p[2] && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->http_proxy_override = parse_http_proxy_override(p[1], p[2], p[3], msglevel, &options->gc);
+        options->http_proxy_override = parse_http_proxy_override(p[1], p[2], p[3], &options->gc);
         if (!options->http_proxy_override)
         {
             goto err;
@@ -7213,7 +7212,7 @@
     {
         struct pull_filter *f;
         VERIFY_PERMISSION(OPT_P_GENERAL)
-        f = alloc_pull_filter(options, msglevel);
+        f = alloc_pull_filter(options);
 
         if (strcmp("accept", p[1]) == 0)
         {
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 404ea08..560db6f 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -573,8 +573,7 @@
 static bool
 add_proxy_headers(struct http_proxy_info *p,
                   socket_descriptor_t sd, /* already open to proxy */
-                  const char *host,       /* openvpn server remote */
-                  const char *port        /* openvpn server port */
+                  const char *host        /* openvpn server remote */
                   )
 {
     char buf[512];
@@ -694,7 +693,7 @@
             goto error;
         }
 
-        if (!add_proxy_headers(p, sd, host, port))
+        if (!add_proxy_headers(p, sd, host))
         {
             goto error;
         }
@@ -833,7 +832,7 @@
             }
 
             /* send HOST etc, */
-            if (!add_proxy_headers(p, sd, host, port))
+            if (!add_proxy_headers(p, sd, host))
             {
                 goto error;
             }
@@ -959,7 +958,7 @@
                 }
 
                 /* send HOST etc, */
-                if (!add_proxy_headers(p, sd, host, port))
+                if (!add_proxy_headers(p, sd, host))
                 {
                     goto error;
                 }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 80f9065..914f520 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -226,8 +226,7 @@
 
 
 void
-server_pushed_info(struct context *c, const struct buffer *buffer,
-                   const int adv)
+server_pushed_info(const struct buffer *buffer, const int adv)
 {
     const char *m = "";
     struct buffer buf = *buffer;
@@ -259,7 +258,7 @@
 
         gc_free(&gc);
     }
-    #endif
+#endif
     msg(D_PUSH, "Info command was pushed by server ('%s')", m);
 }
 
diff --git a/src/openvpn/push.h b/src/openvpn/push.h
index 4a13327..6af0853 100644
--- a/src/openvpn/push.h
+++ b/src/openvpn/push.h
@@ -50,8 +50,7 @@
 
 void receive_exit_message(struct context *c);
 
-void server_pushed_info(struct context *c, const struct buffer *buffer,
-                        const int adv);
+void server_pushed_info(const struct buffer *buffer, const int adv);
 
 void receive_cr_response(struct context *c, const struct buffer *buffer);
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index bc41492..245b15b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1243,7 +1243,7 @@
         {
             if (flags & ROUTE_DELETE_FIRST)
             {
-                delete_route_ipv6(r, tt, flags, es, ctx);
+                delete_route_ipv6(r, tt, es, ctx);
             }
             ret = add_route_ipv6(r, tt, flags, es, ctx) && ret;
         }
@@ -1280,7 +1280,7 @@
         struct route_ipv6 *r6;
         for (r6 = rl6->routes_ipv6; r6; r6 = r6->next)
         {
-            delete_route_ipv6(r6, tt, flags, es, ctx);
+            delete_route_ipv6(r6, tt, es, ctx);
         }
         rl6->iflags &= ~RL_ROUTES_ADDED;
     }
@@ -2383,7 +2383,7 @@
 
 void
 delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
-                  unsigned int flags, const struct env_set *es,
+                  const struct env_set *es,
                   openvpn_net_ctx_t *ctx)
 {
     const char *network;
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 98ea79e..dda210a 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -280,7 +280,7 @@
 
 bool add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
 
-void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
+void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt, const struct env_set *es, openvpn_net_ctx_t *ctx);
 
 bool add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int flags,
                const struct route_gateway_info *rgi, const struct env_set *es,
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 5b32885..630ffb4 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2148,7 +2148,6 @@
 
     establish_socks_proxy_udpassoc(sock->socks_proxy,
                                    sock->ctrl_sd,
-                                   sock->sd,
                                    &sock->socks_relay.dest,
                                    sock->server_poll_timeout,
                                    sig_info);
@@ -3461,7 +3460,7 @@
 #ifdef _WIN32
     return link_socket_write_win32(sock, buf, to);
 #else
-    return link_socket_write_tcp_posix(sock, buf, to);
+    return link_socket_write_tcp_posix(sock, buf);
 #endif
 }
 
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2c33319..29311de 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1172,8 +1172,7 @@
 
 static inline ssize_t
 link_socket_write_tcp_posix(struct link_socket *sock,
-                            struct buffer *buf,
-                            struct link_socket_actual *to)
+                            struct buffer *buf)
 {
     return send(sock->sd, BPTR(buf), BLEN(buf), MSG_NOSIGNAL);
 }
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index e280453..d2105cb 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -516,7 +516,6 @@
 void
 establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
                                socket_descriptor_t ctrl_sd,  /* already open to proxy */
-                               socket_descriptor_t udp_sd,
                                struct openvpn_sockaddr *relay_addr,
                                struct event_timeout *server_poll_timeout,
                                struct signal_info *sig_info)
diff --git a/src/openvpn/socks.h b/src/openvpn/socks.h
index 5c4b4a1..d5658ee 100644
--- a/src/openvpn/socks.h
+++ b/src/openvpn/socks.h
@@ -57,7 +57,6 @@
 
 void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,
                                     socket_descriptor_t ctrl_sd,  /* already open to proxy */
-                                    socket_descriptor_t udp_sd,
                                     struct openvpn_sockaddr *relay_addr,
                                     struct event_timeout *server_poll_timeout,
                                     struct signal_info *sig_info);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 439ce79..48f2a49 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1676,7 +1676,7 @@
         /* If dynamic tls-crypt has been negotiated, and we are on the
          * first session (key_id = 0), generate a tls-crypt key for the
          * following renegotiations */
-        if (!tls_session_generate_dynamic_tls_crypt_key(multi, session))
+        if (!tls_session_generate_dynamic_tls_crypt_key(session))
         {
             return false;
         }
@@ -2241,8 +2241,7 @@
 }
 
 static void
-export_user_keying_material(struct key_state_ssl *ssl,
-                            struct tls_session *session)
+export_user_keying_material(struct tls_session *session)
 {
     if (session->opt->ekm_size > 0)
     {
@@ -2430,7 +2429,7 @@
     if ((ks->authenticated > KS_AUTH_FALSE)
         && plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL))
     {
-        export_user_keying_material(&ks->ks_ssl, session);
+        export_user_keying_material(session);
 
         if (plugin_call(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NULL, session->opt->es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e7d7ed6..1ac94fc 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -401,7 +401,7 @@
  */
 static void
 verify_cert_set_env(struct env_set *es, openvpn_x509_cert_t *peer_cert, int cert_depth,
-                    const char *subject, const char *common_name,
+                    const char *subject,
                     const struct x509_track *x509_track)
 {
     char envname[64];
@@ -422,12 +422,6 @@
     snprintf(envname, sizeof(envname), "tls_id_%d", cert_depth);
     setenv_str(es, envname, subject);
 
-#if 0
-    /* export common name string as environmental variable */
-    snprintf(envname, sizeof(envname), "tls_common_name_%d", cert_depth);
-    setenv_str(es, envname, common_name);
-#endif
-
     /* export X509 cert fingerprints */
     {
         struct buffer sha1 = x509_get_sha1_fingerprint(peer_cert, &gc);
@@ -518,7 +512,7 @@
  */
 static result_t
 verify_cert_call_command(const char *verify_command, struct env_set *es,
-                         int cert_depth, openvpn_x509_cert_t *cert, char *subject)
+                         int cert_depth, char *subject)
 {
     int ret;
     struct gc_arena gc = gc_new();
@@ -744,8 +738,7 @@
         }
     }
     /* export certificate values to the environment */
-    verify_cert_set_env(opt->es, cert, cert_depth, subject, common_name,
-                        opt->x509_track);
+    verify_cert_set_env(opt->es, cert, cert_depth, subject, opt->x509_track);
 
     /* export current untrusted IP */
     setenv_untrusted(session);
@@ -764,7 +757,7 @@
 
     /* run --tls-verify script */
     if (opt->verify_command && SUCCESS != verify_cert_call_command(opt->verify_command,
-                                                                   opt->es, cert_depth, cert, subject))
+                                                                   opt->es, cert_depth, subject))
     {
         goto cleanup;
     }
@@ -1017,7 +1010,6 @@
  */
 static char *
 key_state_check_auth_failed_message_file(const struct auth_deferred_status *ads,
-                                         struct tls_multi *multi,
                                          struct gc_arena *gc)
 {
     char *ret = NULL;
@@ -1201,8 +1193,8 @@
     {
         struct gc_arena gc = gc_new();
         const struct key_state *ks = get_primary_key(multi);
-        const char *plugin_message = key_state_check_auth_failed_message_file(&ks->plugin_auth, multi, &gc);
-        const char *script_message = key_state_check_auth_failed_message_file(&ks->script_auth, multi, &gc);
+        const char *plugin_message = key_state_check_auth_failed_message_file(&ks->plugin_auth, &gc);
+        const char *script_message = key_state_check_auth_failed_message_file(&ks->script_auth, &gc);
 
         if (plugin_message)
         {
@@ -1286,7 +1278,7 @@
                         struct auth_deferred_status *status)
 {
     struct gc_arena gc = gc_new();
-    const char *msg = key_state_check_auth_failed_message_file(status, multi, &gc);
+    const char *msg = key_state_check_auth_failed_message_file(status, &gc);
     if (msg)
     {
         auth_set_client_reason(multi, msg);
@@ -1529,7 +1521,6 @@
 
 static int
 verify_user_pass_management(struct tls_session *session,
-                            struct tls_multi *multi,
                             const struct user_pass *up)
 {
     int retval = KMDA_ERROR;
@@ -1675,7 +1666,7 @@
 #ifdef ENABLE_MANAGEMENT
         if (man_def_auth == KMDA_DEF)
         {
-            man_def_auth = verify_user_pass_management(session, multi, up);
+            man_def_auth = verify_user_pass_management(session, up);
         }
 #endif
         if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 2e51c1d..eb7b03d 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -95,8 +95,7 @@
 }
 
 bool
-tls_session_generate_dynamic_tls_crypt_key(struct tls_multi *multi,
-                                           struct tls_session *session)
+tls_session_generate_dynamic_tls_crypt_key(struct tls_session *session)
 {
     session->tls_wrap_reneg.opt = session->tls_wrap.opt;
     session->tls_wrap_reneg.mode = TLS_WRAP_CRYPT;
diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h
index ffb1f2a..e98aae7 100644
--- a/src/openvpn/tls_crypt.h
+++ b/src/openvpn/tls_crypt.h
@@ -122,13 +122,11 @@
  *
  * All renegotiations of a session use the same generated dynamic key.
  *
- * @param multi     multi session struct
  * @param session   session that will be used for the TLS EKM exporter
  * @return          true iff generating the key was successful
  */
 bool
-tls_session_generate_dynamic_tls_crypt_key(struct tls_multi *multi,
-                                           struct tls_session *session);
+tls_session_generate_dynamic_tls_crypt_key(struct tls_session *session);
 
 /**
  * Returns the maximum overhead (in bytes) added to the destination buffer by
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index dbe3dfc..4817f45 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1068,7 +1068,7 @@
     r6.metric  = 0;                     /* connected route */
     r6.flags   = RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;
     route_ipv6_clear_host_bits(&r6);
-    delete_route_ipv6(&r6, tt, 0, NULL, NULL);
+    delete_route_ipv6(&r6, tt, NULL, NULL);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) */
 
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c
index 94cd0ee..ee252f4 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -241,7 +241,6 @@
 
     struct gc_arena gc = gc_new();
 
-    struct tls_multi multi = { 0 };
     struct tls_session session = { 0 };
 
     struct tls_options tls_opt = { 0 };
@@ -250,7 +249,7 @@
     tls_opt.frame.buf.payload_size = 512;
     session.opt = &tls_opt;
 
-    tls_session_generate_dynamic_tls_crypt_key(&multi, &session);
+    tls_session_generate_dynamic_tls_crypt_key(&session);
 
     struct tls_wrap_ctx *rctx = &session.tls_wrap_reneg;
 
@@ -272,7 +271,7 @@
     memset(&session.tls_wrap.original_wrap_keydata.keys, 0x00, sizeof(session.tls_wrap.original_wrap_keydata.keys));
     session.tls_wrap.original_wrap_keydata.n = 2;
 
-    tls_session_generate_dynamic_tls_crypt_key(&multi, &session);
+    tls_session_generate_dynamic_tls_crypt_key(&session);
     tls_crypt_wrap(&ctx->source, &rctx->work, &rctx->opt);
     assert_int_equal(buf_len(&ctx->source) + 40, buf_len(&rctx->work));
 
@@ -281,7 +280,7 @@
 
     /* XOR should not force a different key */
     memset(&session.tls_wrap.original_wrap_keydata.keys, 0x42, sizeof(session.tls_wrap.original_wrap_keydata.keys));
-    tls_session_generate_dynamic_tls_crypt_key(&multi, &session);
+    tls_session_generate_dynamic_tls_crypt_key(&session);
 
     tls_crypt_wrap(&ctx->source, &rctx->work, &rctx->opt);
     assert_int_equal(buf_len(&ctx->source) + 40, buf_len(&rctx->work));

