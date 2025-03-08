From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 8 Mar 2025 12:18:48 +0000
In-Reply-To: <gerrit.1736860439000.Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919@...2715...>
References: <gerrit.1736860439000.Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0fc78c1506ace9578c9f2acaaf20172d7b291ac1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5bfW7Cy8CY0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove various
 unused function parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5bfW7Cy8CY0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/86=
2?usp=3Demail )

Change subject: Remove various unused function parameters
......................................................................

Remove various unused function parameters

Change-Id: Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250308100456.32383-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
064.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/multi.c
M src/openvpn/options.c
M src/openvpn/proxy.c
M src/openvpn/push.c
M src/openvpn/push.h
M src/openvpn/route.c
M src/openvpn/route.h
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/socks.c
M src/openvpn/socks.h
M src/openvpn/ssl.c
M src/openvpn/ssl_verify.c
M src/openvpn/tls_crypt.c
M src/openvpn/tls_crypt.h
M src/openvpn/tun.c
M tests/unit_tests/openvpn/test_tls_crypt.c
18 files changed, 42 insertions(+), 67 deletions(-)




diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index fce7ac8..af1d008 100644
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
index 9d244be..0292e8d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1769,8 +1769,7 @@
 }

 static void
-multi_client_connect_setenv(struct multi_context *m,
-                            struct multi_instance *mi)
+multi_client_connect_setenv(struct multi_instance *mi)
 {
     struct gc_arena gc =3D gc_new();

@@ -2565,7 +2564,7 @@
     /* do --client-connect setenvs */
     multi_select_virtual_addr(m, mi);

-    multi_client_connect_setenv(m, mi);
+    multi_client_connect_setenv(mi);
 }

 /**
@@ -2658,7 +2657,7 @@
              */
             multi_select_virtual_addr(m, mi);

-            multi_client_connect_setenv(m, mi);
+            multi_client_connect_setenv(mi);

             ret =3D CC_RET_SUCCEEDED;
         }
@@ -2930,7 +2929,6 @@
 multi_bcast(struct multi_context *m,
             const struct buffer *buf,
             const struct multi_instance *sender_instance,
-            const struct mroute_addr *sender_addr,
             uint16_t vid)
 {
     struct hash_iterator hi;
@@ -3458,7 +3456,7 @@
                     if (mroute_flags & MROUTE_EXTRACT_MCAST)
                     {
                         /* for now, treat multicast as broadcast */
-                        multi_bcast(m, &c->c2.to_tun, m->pending, NULL, 0);
+                        multi_bcast(m, &c->c2.to_tun, m->pending, 0);
                     }
                     else /* possible client to client routing */
                     {
@@ -3510,8 +3508,7 @@
                         {
                             if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUT=
E_EXTRACT_MCAST))
                             {
-                                multi_bcast(m, &c->c2.to_tun, m->pending, =
NULL,
-                                            vid);
+                                multi_bcast(m, &c->c2.to_tun, m->pending, =
vid);
                             }
                             else /* try client-to-client routing */
                             {
@@ -3604,7 +3601,7 @@
             if (mroute_flags & (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))
             {
                 /* for now, treat multicast as broadcast */
-                multi_bcast(m, &m->top.c2.buf, NULL, NULL, vid);
+                multi_bcast(m, &m->top.c2.buf, NULL, vid);
             }
             else
             {
@@ -3776,7 +3773,7 @@

         for (i =3D 0; i < parm.n_packets; ++i)
         {
-            multi_bcast(m, &buf, NULL, NULL, 0);
+            multi_bcast(m, &buf, NULL, 0);
         }

         gc_free(&gc);
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 511ce05..df3ebad 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2137,7 +2137,6 @@
 parse_http_proxy_override(const char *server,
                           const char *port,
                           const char *flags,
-                          const int msglevel,
                           struct gc_arena *gc)
 {
     if (server && port)
@@ -2307,7 +2306,7 @@
 }

 static struct pull_filter *
-alloc_pull_filter(struct options *o, const int msglevel)
+alloc_pull_filter(struct options *o)
 {
     struct pull_filter_list *l =3D alloc_pull_filter_list(o);
     struct pull_filter *f;
@@ -6345,7 +6344,7 @@
     else if (streq(p[0], "http-proxy-override") && p[1] && p[2] && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->http_proxy_override =3D parse_http_proxy_override(p[1], p=
[2], p[3], msglevel, &options->gc);
+        options->http_proxy_override =3D parse_http_proxy_override(p[1], p=
[2], p[3], &options->gc);
         if (!options->http_proxy_override)
         {
             goto err;
@@ -7259,7 +7258,7 @@
     {
         struct pull_filter *f;
         VERIFY_PERMISSION(OPT_P_GENERAL)
-        f =3D alloc_pull_filter(options, msglevel);
+        f =3D alloc_pull_filter(options);

         if (strcmp("accept", p[1]) =3D=3D 0)
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
     const char *m =3D "";
     struct buffer buf =3D *buffer;
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
             ret =3D add_route_ipv6(r, tt, flags, es, ctx) && ret;
         }
@@ -1280,7 +1280,7 @@
         struct route_ipv6 *r6;
         for (r6 =3D rl6->routes_ipv6; r6; r6 =3D r6->next)
         {
-            delete_route_ipv6(r6, tt, flags, es, ctx);
+            delete_route_ipv6(r6, tt, es, ctx);
         }
         rl6->iflags &=3D ~RL_ROUTES_ADDED;
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

 bool add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, unsigne=
d int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);

-void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt=
, unsigned int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);
+void delete_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt=
, const struct env_set *es, openvpn_net_ctx_t *ctx);

 bool add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned int=
 flags,
                const struct route_gateway_info *rgi, const struct env_set =
*es,
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index d8cb9f5..6b32e30 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2168,7 +2168,6 @@

     establish_socks_proxy_udpassoc(sock->socks_proxy,
                                    sock->ctrl_sd,
-                                   sock->sd,
                                    &sock->socks_relay.dest,
                                    sock->server_poll_timeout,
                                    sig_info);
@@ -3481,7 +3480,7 @@
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
                                socket_descriptor_t ctrl_sd,  /* already op=
en to proxy */
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
                                     socket_descriptor_t ctrl_sd,  /* alrea=
dy open to proxy */
-                                    socket_descriptor_t udp_sd,
                                     struct openvpn_sockaddr *relay_addr,
                                     struct event_timeout *server_poll_time=
out,
                                     struct signal_info *sig_info);
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 439ce79..48f2a49 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1676,7 +1676,7 @@
         /* If dynamic tls-crypt has been negotiated, and we are on the
          * first session (key_id =3D 0), generate a tls-crypt key for the
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

         if (plugin_call(session->opt->plugins, OPENVPN_PLUGIN_TLS_FINAL, N=
ULL, NULL, session->opt->es) !=3D OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index e7d7ed6..1ac94fc 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -401,7 +401,7 @@
  */
 static void
 verify_cert_set_env(struct env_set *es, openvpn_x509_cert_t *peer_cert, in=
t cert_depth,
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
         struct buffer sha1 =3D x509_get_sha1_fingerprint(peer_cert, &gc);
@@ -518,7 +512,7 @@
  */
 static result_t
 verify_cert_call_command(const char *verify_command, struct env_set *es,
-                         int cert_depth, openvpn_x509_cert_t *cert, char *=
subject)
+                         int cert_depth, char *subject)
 {
     int ret;
     struct gc_arena gc =3D gc_new();
@@ -744,8 +738,7 @@
         }
     }
     /* export certificate values to the environment */
-    verify_cert_set_env(opt->es, cert, cert_depth, subject, common_name,
-                        opt->x509_track);
+    verify_cert_set_env(opt->es, cert, cert_depth, subject, opt->x509_trac=
k);

     /* export current untrusted IP */
     setenv_untrusted(session);
@@ -764,7 +757,7 @@

     /* run --tls-verify script */
     if (opt->verify_command && SUCCESS !=3D verify_cert_call_command(opt->=
verify_command,
-                                                                   opt->es=
, cert_depth, cert, subject))
+                                                                   opt->es=
, cert_depth, subject))
     {
         goto cleanup;
     }
@@ -1017,7 +1010,6 @@
  */
 static char *
 key_state_check_auth_failed_message_file(const struct auth_deferred_status=
 *ads,
-                                         struct tls_multi *multi,
                                          struct gc_arena *gc)
 {
     char *ret =3D NULL;
@@ -1201,8 +1193,8 @@
     {
         struct gc_arena gc =3D gc_new();
         const struct key_state *ks =3D get_primary_key(multi);
-        const char *plugin_message =3D key_state_check_auth_failed_message=
_file(&ks->plugin_auth, multi, &gc);
-        const char *script_message =3D key_state_check_auth_failed_message=
_file(&ks->script_auth, multi, &gc);
+        const char *plugin_message =3D key_state_check_auth_failed_message=
_file(&ks->plugin_auth, &gc);
+        const char *script_message =3D key_state_check_auth_failed_message=
_file(&ks->script_auth, &gc);

         if (plugin_message)
         {
@@ -1286,7 +1278,7 @@
                         struct auth_deferred_status *status)
 {
     struct gc_arena gc =3D gc_new();
-    const char *msg =3D key_state_check_auth_failed_message_file(status, m=
ulti, &gc);
+    const char *msg =3D key_state_check_auth_failed_message_file(status, &=
gc);
     if (msg)
     {
         auth_set_client_reason(multi, msg);
@@ -1529,7 +1521,6 @@

 static int
 verify_user_pass_management(struct tls_session *session,
-                            struct tls_multi *multi,
                             const struct user_pass *up)
 {
     int retval =3D KMDA_ERROR;
@@ -1675,7 +1666,7 @@
 #ifdef ENABLE_MANAGEMENT
         if (man_def_auth =3D=3D KMDA_DEF)
         {
-            man_def_auth =3D verify_user_pass_management(session, multi, u=
p);
+            man_def_auth =3D verify_user_pass_management(session, up);
         }
 #endif
         if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER=
_PASS_VERIFY))
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
     session->tls_wrap_reneg.opt =3D session->tls_wrap.opt;
     session->tls_wrap_reneg.mode =3D TLS_WRAP_CRYPT;
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
  * Returns the maximum overhead (in bytes) added to the destination buffer=
 by
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index dbe3dfc..4817f45 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1068,7 +1068,7 @@
     r6.metric  =3D 0;                     /* connected route */
     r6.flags   =3D RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;
     route_ipv6_clear_host_bits(&r6);
-    delete_route_ipv6(&r6, tt, 0, NULL, NULL);
+    delete_route_ipv6(&r6, tt, NULL, NULL);
 }
 #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_N=
ETBSD) || defined(TARGET_OPENBSD) */

diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 94cd0ee..ee252f4 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -241,7 +241,6 @@

     struct gc_arena gc =3D gc_new();

-    struct tls_multi multi =3D { 0 };
     struct tls_session session =3D { 0 };

     struct tls_options tls_opt =3D { 0 };
@@ -250,7 +249,7 @@
     tls_opt.frame.buf.payload_size =3D 512;
     session.opt =3D &tls_opt;

-    tls_session_generate_dynamic_tls_crypt_key(&multi, &session);
+    tls_session_generate_dynamic_tls_crypt_key(&session);

     struct tls_wrap_ctx *rctx =3D &session.tls_wrap_reneg;

@@ -272,7 +271,7 @@
     memset(&session.tls_wrap.original_wrap_keydata.keys, 0x00, sizeof(sess=
ion.tls_wrap.original_wrap_keydata.keys));
     session.tls_wrap.original_wrap_keydata.n =3D 2;

-    tls_session_generate_dynamic_tls_crypt_key(&multi, &session);
+    tls_session_generate_dynamic_tls_crypt_key(&session);
     tls_crypt_wrap(&ctx->source, &rctx->work, &rctx->opt);
     assert_int_equal(buf_len(&ctx->source) + 40, buf_len(&rctx->work));

@@ -281,7 +280,7 @@

     /* XOR should not force a different key */
     memset(&session.tls_wrap.original_wrap_keydata.keys, 0x42, sizeof(sess=
ion.tls_wrap.original_wrap_keydata.keys));
-    tls_session_generate_dynamic_tls_crypt_key(&multi, &session);
+    tls_session_generate_dynamic_tls_crypt_key(&session);

     tls_crypt_wrap(&ctx->source, &rctx->work, &rctx->opt);
     assert_int_equal(buf_len(&ctx->source) + 40, buf_len(&rctx->work));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/862?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919
Gerrit-Change-Number: 862
Gerrit-PatchSet: 5
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--5bfW7Cy8CY0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/862?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove various unused function parameters<br><=
br>Change-Id: Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>Message-Id: &lt;20250308100456.32383-1-gert@...1296...&=
gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...475...=
t/msg31064.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>-=
--<br>M src/openvpn/forward.c<br>M src/openvpn/multi.c<br>M src/openvpn/opt=
ions.c<br>M src/openvpn/proxy.c<br>M src/openvpn/push.c<br>M src/openvpn/pu=
sh.h<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>M src/openvpn/soc=
ket.c<br>M src/openvpn/socket.h<br>M src/openvpn/socks.c<br>M src/openvpn/s=
ocks.h<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_verify.c<br>M src/openvp=
n/tls_crypt.c<br>M src/openvpn/tls_crypt.h<br>M src/openvpn/tun.c<br>M test=
s/unit_tests/openvpn/test_tls_crypt.c<br>18 files changed, 42 insertions(+)=
, 67 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index fce7ac8..af1d008 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -257,11 +2=
57,11 @@</span><br><span>     }</span><br><span>     else if (buf_string_ma=
tch_head_str(buf, &quot;INFO_PRE&quot;))</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_info(c, buf=
, 8);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        server=
_pushed_info(buf, 8);</span><br><span>     }</span><br><span>     else if (=
buf_string_match_head_str(buf, &quot;INFO&quot;))</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        server_pushed_in=
fo(c, buf, 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   server_pushed_info(buf, 4);</span><br><span>     }</span><br><span>     =
else if (buf_string_match_head_str(buf, &quot;CR_RESPONSE&quot;))</span><br=
><span>     {</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvp=
n/multi.c</span><br><span>index 9d244be..0292e8d 100644</span><br><span>---=
 a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br>=
<span>@@ -1769,8 +1769,7 @@</span><br><span> }</span><br><span> </span><br>=
<span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mul=
ti_client_connect_setenv(struct multi_context *m,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                            struct multi_instan=
ce *mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_client=
_connect_setenv(struct multi_instance *mi)</span><br><span> {</span><br><sp=
an>     struct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>=
@@ -2565,7 +2564,7 @@</span><br><span>     /* do --client-connect setenvs *=
/</span><br><span>     multi_select_virtual_addr(m, mi);</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_client_conne=
ct_setenv(m, mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  multi_client_connect_setenv(mi);</span><br><span> }</span><br><span> </sp=
an><br><span> /**</span><br><span>@@ -2658,7 +2657,7 @@</span><br><span>   =
           */</span><br><span>             multi_select_virtual_addr(m, mi)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          multi_client_connect_setenv(m, mi);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            multi_client_connect_setenv(mi);</spa=
n><br><span> </span><br><span>             ret =3D CC_RET_SUCCEEDED;</span>=
<br><span>         }</span><br><span>@@ -2930,7 +2929,6 @@</span><br><span>=
 multi_bcast(struct multi_context *m,</span><br><span>             const st=
ruct buffer *buf,</span><br><span>             const struct multi_instance =
*sender_instance,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        const struct mroute_addr *sender_addr,</span><br><span>            =
 uint16_t vid)</span><br><span> {</span><br><span>     struct hash_iterator=
 hi;</span><br><span>@@ -3458,7 +3456,7 @@</span><br><span>                =
     if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</span><br><span>         =
            {</span><br><span>                         /* for now, treat mu=
lticast as broadcast */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        multi_bcast(m, &amp;c-&gt;c2.to_tun, m-&gt;pendin=
g, NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 multi_bcast(m, &amp;c-&gt;c2.to_tun, m-&gt;pending, 0);</s=
pan><br><span>                     }</span><br><span>                     e=
lse /* possible client to client routing */</span><br><span>               =
      {</span><br><span>@@ -3510,8 +3508,7 @@</span><br><span>             =
            {</span><br><span>                             if (mroute_flags=
 &amp; (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))</span><br><span>       =
                      {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                                multi_bcast(m, &amp;c-&gt;c2.to_tun, m-&g=
t;pending, NULL,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                                       vid);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                multi_bcast(m, &am=
p;c-&gt;c2.to_tun, m-&gt;pending, vid);</span><br><span>                   =
          }</span><br><span>                             else /* try client=
-to-client routing */</span><br><span>                             {</span>=
<br><span>@@ -3604,7 +3601,7 @@</span><br><span>             if (mroute_fla=
gs &amp; (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))</span><br><span>     =
        {</span><br><span>                 /* for now, treat multicast as b=
roadcast */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      multi_bcast(m, &amp;m-&gt;top.c2.buf, NULL, NULL, vid);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                multi_bcast(m, &a=
mp;m-&gt;top.c2.buf, NULL, vid);</span><br><span>             }</span><br><=
span>             else</span><br><span>             {</span><br><span>@@ -3=
776,7 +3773,7 @@</span><br><span> </span><br><span>         for (i =3D 0; i=
 &lt; parm.n_packets; ++i)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            multi_bcast(m, &amp;buf, NULL, =
NULL, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  multi_bcast(m, &amp;buf, NULL, 0);</span><br><span>         }</span><br><=
span> </span><br><span>         gc_free(&amp;gc);</span><br><span>diff --gi=
t a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 511=
ce05..df3ebad 100644</span><br><span>--- a/src/openvpn/options.c</span><br>=
<span>+++ b/src/openvpn/options.c</span><br><span>@@ -2137,7 +2137,6 @@</sp=
an><br><span> parse_http_proxy_override(const char *server,</span><br><span=
>                           const char *port,</span><br><span>             =
              const char *flags,</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                          const int msglevel,</span><br><span>  =
                         struct gc_arena *gc)</span><br><span> {</span><br>=
<span>     if (server &amp;&amp; port)</span><br><span>@@ -2307,7 +2306,7 @=
@</span><br><span> }</span><br><span> </span><br><span> static struct pull_=
filter *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-alloc_pull_fi=
lter(struct options *o, const int msglevel)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+alloc_pull_filter(struct options *o)</span><br><spa=
n> {</span><br><span>     struct pull_filter_list *l =3D alloc_pull_filter_=
list(o);</span><br><span>     struct pull_filter *f;</span><br><span>@@ -63=
45,7 +6344,7 @@</span><br><span>     else if (streq(p[0], &quot;http-proxy-=
override&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[4])</span><br=
><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;http=
_proxy_override =3D parse_http_proxy_override(p[1], p[2], p[3], msglevel, &=
amp;options-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        options-&gt;http_proxy_override =3D parse_http_proxy_override(p[1]=
, p[2], p[3], &amp;options-&gt;gc);</span><br><span>         if (!options-&=
gt;http_proxy_override)</span><br><span>         {</span><br><span>        =
     goto err;</span><br><span>@@ -7259,7 +7258,7 @@</span><br><span>     {=
</span><br><span>         struct pull_filter *f;</span><br><span>         V=
ERIFY_PERMISSION(OPT_P_GENERAL)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        f =3D alloc_pull_filter(options, msglevel);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        f =3D alloc_pull_filter(o=
ptions);</span><br><span> </span><br><span>         if (strcmp(&quot;accept=
&quot;, p[1]) =3D=3D 0)</span><br><span>         {</span><br><span>diff --g=
it a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>index 404ea0=
8..560db6f 100644</span><br><span>--- a/src/openvpn/proxy.c</span><br><span=
>+++ b/src/openvpn/proxy.c</span><br><span>@@ -573,8 +573,7 @@</span><br><s=
pan> static bool</span><br><span> add_proxy_headers(struct http_proxy_info =
*p,</span><br><span>                   socket_descriptor_t sd, /* already o=
pen to proxy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
            const char *host,       /* openvpn server remote */</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                  const char *por=
t        /* openvpn server port */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                  const char *host        /* openvpn server =
remote */</span><br><span>                   )</span><br><span> {</span><br=
><span>     char buf[512];</span><br><span>@@ -694,7 +693,7 @@</span><br><s=
pan>             goto error;</span><br><span>         }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (!add_proxy_=
headers(p, sd, host, port))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!add_proxy_headers(p, sd, host))</span><br><span>      =
   {</span><br><span>             goto error;</span><br><span>         }</s=
pan><br><span>@@ -833,7 +832,7 @@</span><br><span>             }</span><br>=
<span> </span><br><span>             /* send HOST etc, */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (!add_proxy_headers(p, s=
d, host, port))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (!add_proxy_headers(p, sd, host))</span><br><span>             {=
</span><br><span>                 goto error;</span><br><span>             =
}</span><br><span>@@ -959,7 +958,7 @@</span><br><span>                 }</s=
pan><br><span> </span><br><span>                 /* send HOST etc, */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (!add_pr=
oxy_headers(p, sd, host, port))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                if (!add_proxy_headers(p, sd, host))</span><br>=
<span>                 {</span><br><span>                     goto error;</=
span><br><span>                 }</span><br><span>diff --git a/src/openvpn/=
push.c b/src/openvpn/push.c</span><br><span>index 80f9065..914f520 100644</=
span><br><span>--- a/src/openvpn/push.c</span><br><span>+++ b/src/openvpn/p=
ush.c</span><br><span>@@ -226,8 +226,7 @@</span><br><span> </span><br><span=
> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-server_pushed_info(struct context *c, const struct buffer *buffer,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                   const in=
t adv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+server_pushed=
_info(const struct buffer *buffer, const int adv)</span><br><span> {</span>=
<br><span>     const char *m =3D &quot;&quot;;</span><br><span>     struct =
buffer buf =3D *buffer;</span><br><span>@@ -259,7 +258,7 @@</span><br><span=
> </span><br><span>         gc_free(&amp;gc);</span><br><span>     }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    #endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>     msg(D_PUS=
H, &quot;Info command was pushed by server (&#39;%s&#39;)&quot;, m);</span>=
<br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/pus=
h.h b/src/openvpn/push.h</span><br><span>index 4a13327..6af0853 100644</spa=
n><br><span>--- a/src/openvpn/push.h</span><br><span>+++ b/src/openvpn/push=
.h</span><br><span>@@ -50,8 +50,7 @@</span><br><span> </span><br><span> voi=
d receive_exit_message(struct context *c);</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void server_pushed_info(struct conte=
xt *c, const struct buffer *buffer,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        const int adv);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void server_pushed_info(const struct buff=
er *buffer, const int adv);</span><br><span> </span><br><span> void receive=
_cr_response(struct context *c, const struct buffer *buffer);</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c=
</span><br><span>index bc41492..245b15b 100644</span><br><span>--- a/src/op=
envpn/route.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ =
-1243,7 +1243,7 @@</span><br><span>         {</span><br><span>             =
if (flags &amp; ROUTE_DELETE_FIRST)</span><br><span>             {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                delete_route_i=
pv6(r, tt, flags, es, ctx);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                delete_route_ipv6(r, tt, es, ctx);</span><br><span>=
             }</span><br><span>             ret =3D add_route_ipv6(r, tt, f=
lags, es, ctx) &amp;&amp; ret;</span><br><span>         }</span><br><span>@=
@ -1280,7 +1280,7 @@</span><br><span>         struct route_ipv6 *r6;</span>=
<br><span>         for (r6 =3D rl6-&gt;routes_ipv6; r6; r6 =3D r6-&gt;next)=
</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            delete_route_ipv6(r6, tt, flags, es, ctx);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            delete_route_ipv6(r6, =
tt, es, ctx);</span><br><span>         }</span><br><span>         rl6-&gt;i=
flags &amp;=3D ~RL_ROUTES_ADDED;</span><br><span>     }</span><br><span>@@ =
-2383,7 +2383,7 @@</span><br><span> </span><br><span> void</span><br><span>=
 delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                  unsign=
ed int flags, const struct env_set *es,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                  const struct env_set *es,</span><br><=
span>                   openvpn_net_ctx_t *ctx)</span><br><span> {</span><b=
r><span>     const char *network;</span><br><span>diff --git a/src/openvpn/=
route.h b/src/openvpn/route.h</span><br><span>index 98ea79e..dda210a 100644=
</span><br><span>--- a/src/openvpn/route.h</span><br><span>+++ b/src/openvp=
n/route.h</span><br><span>@@ -280,7 +280,7 @@</span><br><span> </span><br><=
span> bool add_route_ipv6(struct route_ipv6 *r, const struct tuntap *tt, un=
signed int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void delet=
e_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt, unsigned =
int flags, const struct env_set *es, openvpn_net_ctx_t *ctx);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void delete_route_ipv6(const stru=
ct route_ipv6 *r, const struct tuntap *tt, const struct env_set *es, openvp=
n_net_ctx_t *ctx);</span><br><span> </span><br><span> bool add_route(struct=
 route_ipv4 *r, const struct tuntap *tt, unsigned int flags,</span><br><spa=
n>                const struct route_gateway_info *rgi, const struct env_se=
t *es,</span><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/sock=
et.c</span><br><span>index d8cb9f5..6b32e30 100644</span><br><span>--- a/sr=
c/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><sp=
an>@@ -2168,7 +2168,6 @@</span><br><span> </span><br><span>     establish_s=
ocks_proxy_udpassoc(sock-&gt;socks_proxy,</span><br><span>                 =
                   sock-&gt;ctrl_sd,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                                   sock-&gt;sd,</span><br><s=
pan>                                    &amp;sock-&gt;socks_relay.dest,</sp=
an><br><span>                                    sock-&gt;server_poll_timeo=
ut,</span><br><span>                                    sig_info);</span><b=
r><span>@@ -3481,7 +3480,7 @@</span><br><span> #ifdef _WIN32</span><br><spa=
n>     return link_socket_write_win32(sock, buf, to);</span><br><span> #els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return link_sock=
et_write_tcp_posix(sock, buf, to);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    return link_socket_write_tcp_posix(sock, buf);</span><br=
><span> #endif</span><br><span> }</span><br><span> </span><br><span>diff --=
git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span>index 2c3=
3319..29311de 100644</span><br><span>--- a/src/openvpn/socket.h</span><br><=
span>+++ b/src/openvpn/socket.h</span><br><span>@@ -1172,8 +1172,7 @@</span=
><br><span> </span><br><span> static inline ssize_t</span><br><span> link_s=
ocket_write_tcp_posix(struct link_socket *sock,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                            struct buffer *buf,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
     struct link_socket_actual *to)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                            struct buffer *buf)</span><br><=
span> {</span><br><span>     return send(sock-&gt;sd, BPTR(buf), BLEN(buf),=
 MSG_NOSIGNAL);</span><br><span> }</span><br><span>diff --git a/src/openvpn=
/socks.c b/src/openvpn/socks.c</span><br><span>index e280453..d2105cb 10064=
4</span><br><span>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openv=
pn/socks.c</span><br><span>@@ -516,7 +516,6 @@</span><br><span> void</span>=
<br><span> establish_socks_proxy_udpassoc(struct socks_proxy_info *p,</span=
><br><span>                                socket_descriptor_t ctrl_sd,  /*=
 already open to proxy */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                               socket_descriptor_t udp_sd,</span><br><s=
pan>                                struct openvpn_sockaddr *relay_addr,</s=
pan><br><span>                                struct event_timeout *server_=
poll_timeout,</span><br><span>                                struct signal=
_info *sig_info)</span><br><span>diff --git a/src/openvpn/socks.h b/src/ope=
nvpn/socks.h</span><br><span>index 5c4b4a1..d5658ee 100644</span><br><span>=
--- a/src/openvpn/socks.h</span><br><span>+++ b/src/openvpn/socks.h</span><=
br><span>@@ -57,7 +57,6 @@</span><br><span> </span><br><span> void establis=
h_socks_proxy_udpassoc(struct socks_proxy_info *p,</span><br><span>        =
                             socket_descriptor_t ctrl_sd,  /* already open =
to proxy */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
                          socket_descriptor_t udp_sd,</span><br><span>     =
                                struct openvpn_sockaddr *relay_addr,</span>=
<br><span>                                     struct event_timeout *server=
_poll_timeout,</span><br><span>                                     struct =
signal_info *sig_info);</span><br><span>diff --git a/src/openvpn/ssl.c b/sr=
c/openvpn/ssl.c</span><br><span>index 439ce79..48f2a49 100644</span><br><sp=
an>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/openvpn/ssl.c</span><b=
r><span>@@ -1676,7 +1676,7 @@</span><br><span>         /* If dynamic tls-cr=
ypt has been negotiated, and we are on the</span><br><span>          * firs=
t session (key_id =3D 0), generate a tls-crypt key for the</span><br><span>=
          * following renegotiations */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        if (!tls_session_generate_dynamic_tls_crypt_key(m=
ulti, session))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (!tls_session_generate_dynamic_tls_crypt_key(session))</span><br><sp=
an>         {</span><br><span>             return false;</span><br><span>  =
       }</span><br><span>@@ -2241,8 +2241,7 @@</span><br><span> }</span><br=
><span> </span><br><span> static void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-export_user_keying_material(struct key_state_ssl *ssl,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
  struct tls_session *session)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+export_user_keying_material(struct tls_session *session)</span><=
br><span> {</span><br><span>     if (session-&gt;opt-&gt;ekm_size &gt; 0)</=
span><br><span>     {</span><br><span>@@ -2430,7 +2429,7 @@</span><br><span=
>     if ((ks-&gt;authenticated &gt; KS_AUTH_FALSE)</span><br><span>       =
  &amp;&amp; plugin_defined(session-&gt;opt-&gt;plugins, OPENVPN_PLUGIN_TLS=
_FINAL))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        export_user_keying_material(&amp;ks-&gt;ks_ssl, session);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        export_user=
_keying_material(session);</span><br><span> </span><br><span>         if (p=
lugin_call(session-&gt;opt-&gt;plugins, OPENVPN_PLUGIN_TLS_FINAL, NULL, NUL=
L, session-&gt;opt-&gt;es) !=3D OPENVPN_PLUGIN_FUNC_SUCCESS)</span><br><spa=
n>         {</span><br><span>diff --git a/src/openvpn/ssl_verify.c b/src/op=
envpn/ssl_verify.c</span><br><span>index e7d7ed6..1ac94fc 100644</span><br>=
<span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/openvpn/ssl_=
verify.c</span><br><span>@@ -401,7 +401,7 @@</span><br><span>  */</span><br=
><span> static void</span><br><span> verify_cert_set_env(struct env_set *es=
, openvpn_x509_cert_t *peer_cert, int cert_depth,</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    const char *subject, const =
char *common_name,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   const char *subject,</span><br><span>                   =
  const struct x509_track *x509_track)</span><br><span> {</span><br><span> =
    char envname[64];</span><br><span>@@ -422,12 +422,6 @@</span><br><span>=
     snprintf(envname, sizeof(envname), &quot;tls_id_%d&quot;, cert_depth);=
</span><br><span>     setenv_str(es, envname, subject);</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 0</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* export common name string as env=
ironmental variable */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    snprintf(envname, sizeof(envname), &quot;tls_common_name_%d&quot;, cer=
t_depth);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_s=
tr(es, envname, common_name);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span>     /* export X509 cert fingerprints */</span><br><span>     {</=
span><br><span>         struct buffer sha1 =3D x509_get_sha1_fingerprint(pe=
er_cert, &amp;gc);</span><br><span>@@ -518,7 +512,7 @@</span><br><span>  */=
</span><br><span> static result_t</span><br><span> verify_cert_call_command=
(const char *verify_command, struct env_set *es,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                         int cert_depth, openvpn=
_x509_cert_t *cert, char *subject)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                         int cert_depth, char *subject)</spa=
n><br><span> {</span><br><span>     int ret;</span><br><span>     struct gc=
_arena gc =3D gc_new();</span><br><span>@@ -744,8 +738,7 @@</span><br><span=
>         }</span><br><span>     }</span><br><span>     /* export certifica=
te values to the environment */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    verify_cert_set_env(opt-&gt;es, cert, cert_depth, subject, co=
mmon_name,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
             opt-&gt;x509_track);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    verify_cert_set_env(opt-&gt;es, cert, cert_depth, subject=
, opt-&gt;x509_track);</span><br><span> </span><br><span>     /* export cur=
rent untrusted IP */</span><br><span>     setenv_untrusted(session);</span>=
<br><span>@@ -764,7 +757,7 @@</span><br><span> </span><br><span>     /* run=
 --tls-verify script */</span><br><span>     if (opt-&gt;verify_command &am=
p;&amp; SUCCESS !=3D verify_cert_call_command(opt-&gt;verify_command,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
                                        opt-&gt;es, cert_depth, cert, subje=
ct))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
                                                    opt-&gt;es, cert_depth,=
 subject))</span><br><span>     {</span><br><span>         goto cleanup;</s=
pan><br><span>     }</span><br><span>@@ -1017,7 +1010,6 @@</span><br><span>=
  */</span><br><span> static char *</span><br><span> key_state_check_auth_f=
ailed_message_file(const struct auth_deferred_status *ads,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                                      =
   struct tls_multi *multi,</span><br><span>                               =
           struct gc_arena *gc)</span><br><span> {</span><br><span>     cha=
r *ret =3D NULL;</span><br><span>@@ -1201,8 +1193,8 @@</span><br><span>    =
 {</span><br><span>         struct gc_arena gc =3D gc_new();</span><br><spa=
n>         const struct key_state *ks =3D get_primary_key(multi);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        const char *plugin_mess=
age =3D key_state_check_auth_failed_message_file(&amp;ks-&gt;plugin_auth, m=
ulti, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  const char *script_message =3D key_state_check_auth_failed_message_file(&=
amp;ks-&gt;script_auth, multi, &amp;gc);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        const char *plugin_message =3D key_state_check=
_auth_failed_message_file(&amp;ks-&gt;plugin_auth, &amp;gc);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        const char *script_message=
 =3D key_state_check_auth_failed_message_file(&amp;ks-&gt;script_auth, &amp=
;gc);</span><br><span> </span><br><span>         if (plugin_message)</span>=
<br><span>         {</span><br><span>@@ -1286,7 +1278,7 @@</span><br><span>=
                         struct auth_deferred_status *status)</span><br><sp=
an> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    const char *msg =3D key_state_che=
ck_auth_failed_message_file(status, multi, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *msg =3D key_state_check_a=
uth_failed_message_file(status, &amp;gc);</span><br><span>     if (msg)</sp=
an><br><span>     {</span><br><span>         auth_set_client_reason(multi, =
msg);</span><br><span>@@ -1529,7 +1521,6 @@</span><br><span> </span><br><sp=
an> static int</span><br><span> verify_user_pass_management(struct tls_sess=
ion *session,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                    struct tls_multi *multi,</span><br><span>              =
               const struct user_pass *up)</span><br><span> {</span><br><sp=
an>     int retval =3D KMDA_ERROR;</span><br><span>@@ -1675,7 +1666,7 @@</s=
pan><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>         if (man_de=
f_auth =3D=3D KMDA_DEF)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            man_def_auth =3D verify_user_pass_=
management(session, multi, up);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            man_def_auth =3D verify_user_pass_management(sessio=
n, up);</span><br><span>         }</span><br><span> #endif</span><br><span>=
         if (plugin_defined(session-&gt;opt-&gt;plugins, OPENVPN_PLUGIN_AUT=
H_USER_PASS_VERIFY))</span><br><span>diff --git a/src/openvpn/tls_crypt.c b=
/src/openvpn/tls_crypt.c</span><br><span>index 2e51c1d..eb7b03d 100644</spa=
n><br><span>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn=
/tls_crypt.c</span><br><span>@@ -95,8 +95,7 @@</span><br><span> }</span><br=
><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-tls_session_generate_dynamic_tls_crypt_key(struct tls_multi *multi=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
                       struct tls_session *session)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tls_session_generate_dynamic_tls_crypt_ke=
y(struct tls_session *session)</span><br><span> {</span><br><span>     sess=
ion-&gt;tls_wrap_reneg.opt =3D session-&gt;tls_wrap.opt;</span><br><span>  =
   session-&gt;tls_wrap_reneg.mode =3D TLS_WRAP_CRYPT;</span><br><span>diff=
 --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_crypt.h</span><br><span>=
index ffb1f2a..e98aae7 100644</span><br><span>--- a/src/openvpn/tls_crypt.h=
</span><br><span>+++ b/src/openvpn/tls_crypt.h</span><br><span>@@ -122,13 +=
122,11 @@</span><br><span>  *</span><br><span>  * All renegotiations of a s=
ession use the same generated dynamic key.</span><br><span>  *</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">- * @param multi     multi session =
struct</span><br><span>  * @param session   session that will be used for t=
he TLS EKM exporter</span><br><span>  * @return          true iff generatin=
g the key was successful</span><br><span>  */</span><br><span> bool</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-tls_session_generate_dynamic_=
tls_crypt_key(struct tls_multi *multi,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                           struct tls_sess=
ion *session);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_s=
ession_generate_dynamic_tls_crypt_key(struct tls_session *session);</span><=
br><span> </span><br><span> /**</span><br><span>  * Returns the maximum ove=
rhead (in bytes) added to the destination buffer by</span><br><span>diff --=
git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index dbe3dfc..=
4817f45 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ =
b/src/openvpn/tun.c</span><br><span>@@ -1068,7 +1068,7 @@</span><br><span> =
    r6.metric  =3D 0;                     /* connected route */</span><br><=
span>     r6.flags   =3D RT_DEFINED | RT_ADDED | RT_METRIC_DEFINED;</span><=
br><span>     route_ipv6_clear_host_bits(&amp;r6);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    delete_route_ipv6(&amp;r6, tt, 0, NULL, NU=
LL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    delete_rout=
e_ipv6(&amp;r6, tt, NULL, NULL);</span><br><span> }</span><br><span> #endif=
 /* if defined(_WIN32) || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) =
|| defined(TARGET_OPENBSD) */</span><br><span> </span><br><span>diff --git =
a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/openvpn/test=
_tls_crypt.c</span><br><span>index 94cd0ee..ee252f4 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>+++ b/tests=
/unit_tests/openvpn/test_tls_crypt.c</span><br><span>@@ -241,7 +241,6 @@</s=
pan><br><span> </span><br><span>     struct gc_arena gc =3D gc_new();</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struc=
t tls_multi multi =3D { 0 };</span><br><span>     struct tls_session sessio=
n =3D { 0 };</span><br><span> </span><br><span>     struct tls_options tls_=
opt =3D { 0 };</span><br><span>@@ -250,7 +249,7 @@</span><br><span>     tls=
_opt.frame.buf.payload_size =3D 512;</span><br><span>     session.opt =3D &=
amp;tls_opt;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    tls_session_generate_dynamic_tls_crypt_key(&amp;multi, &amp;se=
ssion);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_sess=
ion_generate_dynamic_tls_crypt_key(&amp;session);</span><br><span> </span><=
br><span>     struct tls_wrap_ctx *rctx =3D &amp;session.tls_wrap_reneg;</s=
pan><br><span> </span><br><span>@@ -272,7 +271,7 @@</span><br><span>     me=
mset(&amp;session.tls_wrap.original_wrap_keydata.keys, 0x00, sizeof(session=
.tls_wrap.original_wrap_keydata.keys));</span><br><span>     session.tls_wr=
ap.original_wrap_keydata.n =3D 2;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    tls_session_generate_dynamic_tls_crypt_=
key(&amp;multi, &amp;session);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    tls_session_generate_dynamic_tls_crypt_key(&amp;session);</s=
pan><br><span>     tls_crypt_wrap(&amp;ctx-&gt;source, &amp;rctx-&gt;work, =
&amp;rctx-&gt;opt);</span><br><span>     assert_int_equal(buf_len(&amp;ctx-=
&gt;source) + 40, buf_len(&amp;rctx-&gt;work));</span><br><span> </span><br=
><span>@@ -281,7 +280,7 @@</span><br><span> </span><br><span>     /* XOR sh=
ould not force a different key */</span><br><span>     memset(&amp;session.=
tls_wrap.original_wrap_keydata.keys, 0x42, sizeof(session.tls_wrap.original=
_wrap_keydata.keys));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    tls_session_generate_dynamic_tls_crypt_key(&amp;multi, &amp;session);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tls_session_gener=
ate_dynamic_tls_crypt_key(&amp;session);</span><br><span> </span><br><span>=
     tls_crypt_wrap(&amp;ctx-&gt;source, &amp;rctx-&gt;work, &amp;rctx-&gt;=
opt);</span><br><span>     assert_int_equal(buf_len(&amp;ctx-&gt;source) + =
40, buf_len(&amp;rctx-&gt;work));</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/862?usp=3Demail"=
>change 862</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/862?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3b0f22b0049a111ce52b3c87dd=
08a843ea9a919 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 862 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--5bfW7Cy8CY0=--

