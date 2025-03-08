From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 8 Mar 2025 12:18:43 +0000
In-Reply-To: <gerrit.1736860439000.Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919@...2715...>
References: <gerrit.1736860439000.Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0fc78c1506ace9578c9f2acaaf20172d7b291ac1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bS3e19FxObQ="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bS3e19FxObQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/862?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/62/862/5

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
=20
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
Gerrit-MessageType: newpatchset

--bS3e19FxObQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #5</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/862?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Remove various unused function parameters<br><br>Cha=
nge-Id: Ia3b0f22b0049a111ce52b3c87dd08a843ea9a919<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>Message-Id: &lt;20250308100456.32383-1-gert@...1296...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3=
1064.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M src/openvpn/forward.c<br>M src/openvpn/multi.c<br>M src/openvpn/options.c=
<br>M src/openvpn/proxy.c<br>M src/openvpn/push.c<br>M src/openvpn/push.h<b=
r>M src/openvpn/route.c<br>M src/openvpn/route.h<br>M src/openvpn/socket.c<=
br>M src/openvpn/socket.h<br>M src/openvpn/socks.c<br>M src/openvpn/socks.h=
<br>M src/openvpn/ssl.c<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/tls_=
crypt.c<br>M src/openvpn/tls_crypt.h<br>M src/openvpn/tun.c<br>M tests/unit=
_tests/openvpn/test_tls_crypt.c<br>18 files changed, 42 insertions(+), 67 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/62/862/5</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/f=
orward.c</span><br><span>index fce7ac8..af1d008 100644</span><br><span>--- =
a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><=
br><span>@@ -257,11 +257,11 @@</span><br><span>     }</span><br><span>     =
else if (buf_string_match_head_str(buf, &quot;INFO_PRE&quot;))</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ser=
ver_pushed_info(c, buf, 8);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        server_pushed_info(buf, 8);</span><br><span>     }</span><b=
r><span>     else if (buf_string_match_head_str(buf, &quot;INFO&quot;))</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      server_pushed_info(c, buf, 4);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        server_pushed_info(buf, 4);</span><br><span>     }=
</span><br><span>     else if (buf_string_match_head_str(buf, &quot;CR_RESP=
ONSE&quot;))</span><br><span>     {</span><br><span>diff --git a/src/openvp=
n/multi.c b/src/openvpn/multi.c</span><br><span>index 9d244be..0292e8d 1006=
44</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/open=
vpn/multi.c</span><br><span>@@ -1769,8 +1769,7 @@</span><br><span> }</span>=
<br><span> </span><br><span> static void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-multi_client_connect_setenv(struct multi_context *m,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
   struct multi_instance *mi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+multi_client_connect_setenv(struct multi_instance *mi)</span><br>=
<span> {</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><s=
pan> </span><br><span>@@ -2565,7 +2564,7 @@</span><br><span>     /* do --cl=
ient-connect setenvs */</span><br><span>     multi_select_virtual_addr(m, m=
i);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    multi_client_connect_setenv(m, mi);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    multi_client_connect_setenv(mi);</span><br><span> }=
</span><br><span> </span><br><span> /**</span><br><span>@@ -2658,7 +2657,7 =
@@</span><br><span>              */</span><br><span>             multi_sele=
ct_virtual_addr(m, mi);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            multi_client_connect_setenv(m, mi);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_client_co=
nnect_setenv(mi);</span><br><span> </span><br><span>             ret =3D CC=
_RET_SUCCEEDED;</span><br><span>         }</span><br><span>@@ -2930,7 +2929=
,6 @@</span><br><span> multi_bcast(struct multi_context *m,</span><br><span=
>             const struct buffer *buf,</span><br><span>             const =
struct multi_instance *sender_instance,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            const struct mroute_addr *sender_addr,</span>=
<br><span>             uint16_t vid)</span><br><span> {</span><br><span>   =
  struct hash_iterator hi;</span><br><span>@@ -3458,7 +3456,7 @@</span><br>=
<span>                     if (mroute_flags &amp; MROUTE_EXTRACT_MCAST)</sp=
an><br><span>                     {</span><br><span>                       =
  /* for now, treat multicast as broadcast */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                        multi_bcast(m, &amp;c-&gt;c=
2.to_tun, m-&gt;pending, NULL, 0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                        multi_bcast(m, &amp;c-&gt;c2.to_tun,=
 m-&gt;pending, 0);</span><br><span>                     }</span><br><span>=
                     else /* possible client to client routing */</span><br=
><span>                     {</span><br><span>@@ -3510,8 +3508,7 @@</span><=
br><span>                         {</span><br><span>                       =
      if (mroute_flags &amp; (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))</=
span><br><span>                             {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                                multi_bcast(m, &amp=
;c-&gt;c2.to_tun, m-&gt;pending, NULL,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                                            vid);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    multi_bcast(m, &amp;c-&gt;c2.to_tun, m-&gt;pending, vid);</span><br><sp=
an>                             }</span><br><span>                         =
    else /* try client-to-client routing */</span><br><span>               =
              {</span><br><span>@@ -3604,7 +3601,7 @@</span><br><span>     =
        if (mroute_flags &amp; (MROUTE_EXTRACT_BCAST|MROUTE_EXTRACT_MCAST))=
</span><br><span>             {</span><br><span>                 /* for now=
, treat multicast as broadcast */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                multi_bcast(m, &amp;m-&gt;top.c2.buf, NULL, NUL=
L, vid);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     multi_bcast(m, &amp;m-&gt;top.c2.buf, NULL, vid);</span><br><span>    =
         }</span><br><span>             else</span><br><span>             {=
</span><br><span>@@ -3776,7 +3773,7 @@</span><br><span> </span><br><span>  =
       for (i =3D 0; i &lt; parm.n_packets; ++i)</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            multi_bca=
st(m, &amp;buf, NULL, NULL, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            multi_bcast(m, &amp;buf, NULL, 0);</span><br><span>=
         }</span><br><span> </span><br><span>         gc_free(&amp;gc);</sp=
an><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</sp=
an><br><span>index 511ce05..df3ebad 100644</span><br><span>--- a/src/openvp=
n/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ =
-2137,7 +2137,6 @@</span><br><span> parse_http_proxy_override(const char *s=
erver,</span><br><span>                           const char *port,</span><=
br><span>                           const char *flags,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                          const int msglev=
el,</span><br><span>                           struct gc_arena *gc)</span><=
br><span> {</span><br><span>     if (server &amp;&amp; port)</span><br><spa=
n>@@ -2307,7 +2306,7 @@</span><br><span> }</span><br><span> </span><br><spa=
n> static struct pull_filter *</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-alloc_pull_filter(struct options *o, const int msglevel)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+alloc_pull_filter(struct opti=
ons *o)</span><br><span> {</span><br><span>     struct pull_filter_list *l =
=3D alloc_pull_filter_list(o);</span><br><span>     struct pull_filter *f;<=
/span><br><span>@@ -6345,7 +6344,7 @@</span><br><span>     else if (streq(p=
[0], &quot;http-proxy-override&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;=
&amp; !p[4])</span><br><span>     {</span><br><span>         VERIFY_PERMISS=
ION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      options-&gt;http_proxy_override =3D parse_http_proxy_override(p[1], p=
[2], p[3], msglevel, &amp;options-&gt;gc);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        options-&gt;http_proxy_override =3D parse_ht=
tp_proxy_override(p[1], p[2], p[3], &amp;options-&gt;gc);</span><br><span> =
        if (!options-&gt;http_proxy_override)</span><br><span>         {</s=
pan><br><span>             goto err;</span><br><span>@@ -7259,7 +7258,7 @@<=
/span><br><span>     {</span><br><span>         struct pull_filter *f;</spa=
n><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        f =3D alloc_pull_filter(options, ms=
glevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f =
=3D alloc_pull_filter(options);</span><br><span> </span><br><span>         =
if (strcmp(&quot;accept&quot;, p[1]) =3D=3D 0)</span><br><span>         {</=
span><br><span>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span=
><br><span>index 404ea08..560db6f 100644</span><br><span>--- a/src/openvpn/=
proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -573,8=
 +573,7 @@</span><br><span> static bool</span><br><span> add_proxy_headers(=
struct http_proxy_info *p,</span><br><span>                   socket_descri=
ptor_t sd, /* already open to proxy */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                  const char *host,       /* openvpn serve=
r remote */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
        const char *port        /* openvpn server port */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                  const char *host   =
     /* openvpn server remote */</span><br><span>                   )</span=
><br><span> {</span><br><span>     char buf[512];</span><br><span>@@ -694,7=
 +693,7 @@</span><br><span>             goto error;</span><br><span>       =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (!add_proxy_headers(p, sd, host, port))</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!add_proxy_headers(p, sd, host))=
</span><br><span>         {</span><br><span>             goto error;</span>=
<br><span>         }</span><br><span>@@ -833,7 +832,7 @@</span><br><span>  =
           }</span><br><span> </span><br><span>             /* send HOST et=
c, */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (=
!add_proxy_headers(p, sd, host, port))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (!add_proxy_headers(p, sd, host))</span><=
br><span>             {</span><br><span>                 goto error;</span>=
<br><span>             }</span><br><span>@@ -959,7 +958,7 @@</span><br><spa=
n>                 }</span><br><span> </span><br><span>                 /* =
send HOST etc, */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            if (!add_proxy_headers(p, sd, host, port))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                if (!add_proxy_headers(p=
, sd, host))</span><br><span>                 {</span><br><span>           =
          goto error;</span><br><span>                 }</span><br><span>di=
ff --git a/src/openvpn/push.c b/src/openvpn/push.c</span><br><span>index 80=
f9065..914f520 100644</span><br><span>--- a/src/openvpn/push.c</span><br><s=
pan>+++ b/src/openvpn/push.c</span><br><span>@@ -226,8 +226,7 @@</span><br>=
<span> </span><br><span> </span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-server_pushed_info(struct context *c, const struc=
t buffer *buffer,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
               const int adv)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+server_pushed_info(const struct buffer *buffer, const int adv)</s=
pan><br><span> {</span><br><span>     const char *m =3D &quot;&quot;;</span=
><br><span>     struct buffer buf =3D *buffer;</span><br><span>@@ -259,7 +2=
58,7 @@</span><br><span> </span><br><span>         gc_free(&amp;gc);</span>=
<br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    #=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span>     msg(D_PUSH, &quot;Info command was pushed by server (&#39;%s&=
#39;)&quot;, m);</span><br><span> }</span><br><span> </span><br><span>diff =
--git a/src/openvpn/push.h b/src/openvpn/push.h</span><br><span>index 4a133=
27..6af0853 100644</span><br><span>--- a/src/openvpn/push.h</span><br><span=
>+++ b/src/openvpn/push.h</span><br><span>@@ -50,8 +50,7 @@</span><br><span=
> </span><br><span> void receive_exit_message(struct context *c);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void server_p=
ushed_info(struct context *c, const struct buffer *buffer,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                        const int adv)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void server_pushed=
_info(const struct buffer *buffer, const int adv);</span><br><span> </span>=
<br><span> void receive_cr_response(struct context *c, const struct buffer =
*buffer);</span><br><span> </span><br><span>diff --git a/src/openvpn/route.=
c b/src/openvpn/route.c</span><br><span>index bc41492..245b15b 100644</span=
><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/rout=
e.c</span><br><span>@@ -1243,7 +1243,7 @@</span><br><span>         {</span>=
<br><span>             if (flags &amp; ROUTE_DELETE_FIRST)</span><br><span>=
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         delete_route_ipv6(r, tt, flags, es, ctx);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                delete_route_ipv6(r, tt, es,=
 ctx);</span><br><span>             }</span><br><span>             ret =3D =
add_route_ipv6(r, tt, flags, es, ctx) &amp;&amp; ret;</span><br><span>     =
    }</span><br><span>@@ -1280,7 +1280,7 @@</span><br><span>         struct=
 route_ipv6 *r6;</span><br><span>         for (r6 =3D rl6-&gt;routes_ipv6; =
r6; r6 =3D r6-&gt;next)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            delete_route_ipv6(r6, tt, flags, e=
s, ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 delete_route_ipv6(r6, tt, es, ctx);</span><br><span>         }</span><br><=
span>         rl6-&gt;iflags &amp;=3D ~RL_ROUTES_ADDED;</span><br><span>   =
  }</span><br><span>@@ -2383,7 +2383,7 @@</span><br><span> </span><br><span=
> void</span><br><span> delete_route_ipv6(const struct route_ipv6 *r6, cons=
t struct tuntap *tt,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                 unsigned int flags, const struct env_set *es,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                  const struct e=
nv_set *es,</span><br><span>                   openvpn_net_ctx_t *ctx)</spa=
n><br><span> {</span><br><span>     const char *network;</span><br><span>di=
ff --git a/src/openvpn/route.h b/src/openvpn/route.h</span><br><span>index =
98ea79e..dda210a 100644</span><br><span>--- a/src/openvpn/route.h</span><br=
><span>+++ b/src/openvpn/route.h</span><br><span>@@ -280,7 +280,7 @@</span>=
<br><span> </span><br><span> bool add_route_ipv6(struct route_ipv6 *r, cons=
t struct tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_=
net_ctx_t *ctx);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void delete_route_ipv6(const struct route_ipv6 *r, const struc=
t tuntap *tt, unsigned int flags, const struct env_set *es, openvpn_net_ctx=
_t *ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void delet=
e_route_ipv6(const struct route_ipv6 *r, const struct tuntap *tt, const str=
uct env_set *es, openvpn_net_ctx_t *ctx);</span><br><span> </span><br><span=
> bool add_route(struct route_ipv4 *r, const struct tuntap *tt, unsigned in=
t flags,</span><br><span>                const struct route_gateway_info *r=
gi, const struct env_set *es,</span><br><span>diff --git a/src/openvpn/sock=
et.c b/src/openvpn/socket.c</span><br><span>index d8cb9f5..6b32e30 100644</=
span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn=
/socket.c</span><br><span>@@ -2168,7 +2168,6 @@</span><br><span> </span><br=
><span>     establish_socks_proxy_udpassoc(sock-&gt;socks_proxy,</span><br>=
<span>                                    sock-&gt;ctrl_sd,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                   so=
ck-&gt;sd,</span><br><span>                                    &amp;sock-&g=
t;socks_relay.dest,</span><br><span>                                    soc=
k-&gt;server_poll_timeout,</span><br><span>                                =
    sig_info);</span><br><span>@@ -3481,7 +3480,7 @@</span><br><span> #ifde=
f _WIN32</span><br><span>     return link_socket_write_win32(sock, buf, to)=
;</span><br><span> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    return link_socket_write_tcp_posix(sock, buf, to);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return link_socket_write_tcp_posi=
x(sock, buf);</span><br><span> #endif</span><br><span> }</span><br><span> <=
/span><br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</s=
pan><br><span>index 2c33319..29311de 100644</span><br><span>--- a/src/openv=
pn/socket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -=
1172,8 +1172,7 @@</span><br><span> </span><br><span> static inline ssize_t<=
/span><br><span> link_socket_write_tcp_posix(struct link_socket *sock,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
  struct buffer *buf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                            struct link_socket_actual *to)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                            struct b=
uffer *buf)</span><br><span> {</span><br><span>     return send(sock-&gt;sd=
, BPTR(buf), BLEN(buf), MSG_NOSIGNAL);</span><br><span> }</span><br><span>d=
iff --git a/src/openvpn/socks.c b/src/openvpn/socks.c</span><br><span>index=
 e280453..d2105cb 100644</span><br><span>--- a/src/openvpn/socks.c</span><b=
r><span>+++ b/src/openvpn/socks.c</span><br><span>@@ -516,7 +516,6 @@</span=
><br><span> void</span><br><span> establish_socks_proxy_udpassoc(struct soc=
ks_proxy_info *p,</span><br><span>                                socket_de=
scriptor_t ctrl_sd,  /* already open to proxy */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                               socket_descriptor=
_t udp_sd,</span><br><span>                                struct openvpn_s=
ockaddr *relay_addr,</span><br><span>                                struct=
 event_timeout *server_poll_timeout,</span><br><span>                      =
          struct signal_info *sig_info)</span><br><span>diff --git a/src/op=
envpn/socks.h b/src/openvpn/socks.h</span><br><span>index 5c4b4a1..d5658ee =
100644</span><br><span>--- a/src/openvpn/socks.h</span><br><span>+++ b/src/=
openvpn/socks.h</span><br><span>@@ -57,7 +57,6 @@</span><br><span> </span><=
br><span> void establish_socks_proxy_udpassoc(struct socks_proxy_info *p,</=
span><br><span>                                     socket_descriptor_t ctr=
l_sd,  /* already open to proxy */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                                    socket_descriptor_t udp_sd=
,</span><br><span>                                     struct openvpn_socka=
ddr *relay_addr,</span><br><span>                                     struc=
t event_timeout *server_poll_timeout,</span><br><span>                     =
                struct signal_info *sig_info);</span><br><span>diff --git a=
/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 439ce79..48f2a=
49 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src=
/openvpn/ssl.c</span><br><span>@@ -1676,7 +1676,7 @@</span><br><span>      =
   /* If dynamic tls-crypt has been negotiated, and we are on the</span><br=
><span>          * first session (key_id =3D 0), generate a tls-crypt key f=
or the</span><br><span>          * following renegotiations */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (!tls_session_generate_=
dynamic_tls_crypt_key(multi, session))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (!tls_session_generate_dynamic_tls_crypt_key(=
session))</span><br><span>         {</span><br><span>             return fa=
lse;</span><br><span>         }</span><br><span>@@ -2241,8 +2241,7 @@</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-export_user_keying_material(struct k=
ey_state_ssl *ssl,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                         struct tls_session *session)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+export_user_keying_material(struct tls_se=
ssion *session)</span><br><span> {</span><br><span>     if (session-&gt;opt=
-&gt;ekm_size &gt; 0)</span><br><span>     {</span><br><span>@@ -2430,7 +24=
29,7 @@</span><br><span>     if ((ks-&gt;authenticated &gt; KS_AUTH_FALSE)<=
/span><br><span>         &amp;&amp; plugin_defined(session-&gt;opt-&gt;plug=
ins, OPENVPN_PLUGIN_TLS_FINAL))</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        export_user_keying_material(&amp;k=
s-&gt;ks_ssl, session);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        export_user_keying_material(session);</span><br><span> </span><=
br><span>         if (plugin_call(session-&gt;opt-&gt;plugins, OPENVPN_PLUG=
IN_TLS_FINAL, NULL, NULL, session-&gt;opt-&gt;es) !=3D OPENVPN_PLUGIN_FUNC_=
SUCCESS)</span><br><span>         {</span><br><span>diff --git a/src/openvp=
n/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index e7d7ed6..1a=
c94fc 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span=
>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -401,7 +401,7 @@</span><=
br><span>  */</span><br><span> static void</span><br><span> verify_cert_set=
_env(struct env_set *es, openvpn_x509_cert_t *peer_cert, int cert_depth,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    cons=
t char *subject, const char *common_name,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    const char *subject,</span><br><s=
pan>                     const struct x509_track *x509_track)</span><br><sp=
an> {</span><br><span>     char envname[64];</span><br><span>@@ -422,12 +42=
2,6 @@</span><br><span>     snprintf(envname, sizeof(envname), &quot;tls_id=
_%d&quot;, cert_depth);</span><br><span>     setenv_str(es, envname, subjec=
t);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* export co=
mmon name string as environmental variable */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    snprintf(envname, sizeof(envname), &quot;tls_co=
mmon_name_%d&quot;, cert_depth);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    setenv_str(es, envname, common_name);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>     /* export X509 cert fingerprints */<=
/span><br><span>     {</span><br><span>         struct buffer sha1 =3D x509=
_get_sha1_fingerprint(peer_cert, &amp;gc);</span><br><span>@@ -518,7 +512,7=
 @@</span><br><span>  */</span><br><span> static result_t</span><br><span> =
verify_cert_call_command(const char *verify_command, struct env_set *es,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
 int cert_depth, openvpn_x509_cert_t *cert, char *subject)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                         int cert_de=
pth, char *subject)</span><br><span> {</span><br><span>     int ret;</span>=
<br><span>     struct gc_arena gc =3D gc_new();</span><br><span>@@ -744,8 +=
738,7 @@</span><br><span>         }</span><br><span>     }</span><br><span>=
     /* export certificate values to the environment */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    verify_cert_set_env(opt-&gt;es, cert,=
 cert_depth, subject, common_name,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        opt-&gt;x509_track);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    verify_cert_set_env(opt-&gt;es, c=
ert, cert_depth, subject, opt-&gt;x509_track);</span><br><span> </span><br>=
<span>     /* export current untrusted IP */</span><br><span>     setenv_un=
trusted(session);</span><br><span>@@ -764,7 +757,7 @@</span><br><span> </sp=
an><br><span>     /* run --tls-verify script */</span><br><span>     if (op=
t-&gt;verify_command &amp;&amp; SUCCESS !=3D verify_cert_call_command(opt-&=
gt;verify_command,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                                                                opt-&gt;es,=
 cert_depth, cert, subject))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                                                                  =
 opt-&gt;es, cert_depth, subject))</span><br><span>     {</span><br><span> =
        goto cleanup;</span><br><span>     }</span><br><span>@@ -1017,7 +10=
10,6 @@</span><br><span>  */</span><br><span> static char *</span><br><span=
> key_state_check_auth_failed_message_file(const struct auth_deferred_statu=
s *ads,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                           struct tls_multi *multi,</span><br><span>       =
                                   struct gc_arena *gc)</span><br><span> {<=
/span><br><span>     char *ret =3D NULL;</span><br><span>@@ -1201,8 +1193,8=
 @@</span><br><span>     {</span><br><span>         struct gc_arena gc =3D =
gc_new();</span><br><span>         const struct key_state *ks =3D get_prima=
ry_key(multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 const char *plugin_message =3D key_state_check_auth_failed_message_file(&a=
mp;ks-&gt;plugin_auth, multi, &amp;gc);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        const char *script_message =3D key_state_check_au=
th_failed_message_file(&amp;ks-&gt;script_auth, multi, &amp;gc);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const char *plugin_mes=
sage =3D key_state_check_auth_failed_message_file(&amp;ks-&gt;plugin_auth, =
&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        co=
nst char *script_message =3D key_state_check_auth_failed_message_file(&amp;=
ks-&gt;script_auth, &amp;gc);</span><br><span> </span><br><span>         if=
 (plugin_message)</span><br><span>         {</span><br><span>@@ -1286,7 +12=
78,7 @@</span><br><span>                         struct auth_deferred_statu=
s *status)</span><br><span> {</span><br><span>     struct gc_arena gc =3D g=
c_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const cha=
r *msg =3D key_state_check_auth_failed_message_file(status, multi, &amp;gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *ms=
g =3D key_state_check_auth_failed_message_file(status, &amp;gc);</span><br>=
<span>     if (msg)</span><br><span>     {</span><br><span>         auth_se=
t_client_reason(multi, msg);</span><br><span>@@ -1529,7 +1521,6 @@</span><b=
r><span> </span><br><span> static int</span><br><span> verify_user_pass_man=
agement(struct tls_session *session,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                            struct tls_multi *multi,</span><=
br><span>                             const struct user_pass *up)</span><br=
><span> {</span><br><span>     int retval =3D KMDA_ERROR;</span><br><span>@=
@ -1675,7 +1666,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><s=
pan>         if (man_def_auth =3D=3D KMDA_DEF)</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            man_def_aut=
h =3D verify_user_pass_management(session, multi, up);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            man_def_auth =3D verify_user=
_pass_management(session, up);</span><br><span>         }</span><br><span> =
#endif</span><br><span>         if (plugin_defined(session-&gt;opt-&gt;plug=
ins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))</span><br><span>diff --git a/sr=
c/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>index 2e51c=
1d..eb7b03d 100644</span><br><span>--- a/src/openvpn/tls_crypt.c</span><br>=
<span>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -95,8 +95,7 @@</span=
><br><span> }</span><br><span> </span><br><span> bool</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-tls_session_generate_dynamic_tls_crypt_key(=
struct tls_multi *multi,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                           struct tls_session *session)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_session_generate=
_dynamic_tls_crypt_key(struct tls_session *session)</span><br><span> {</spa=
n><br><span>     session-&gt;tls_wrap_reneg.opt =3D session-&gt;tls_wrap.op=
t;</span><br><span>     session-&gt;tls_wrap_reneg.mode =3D TLS_WRAP_CRYPT;=
</span><br><span>diff --git a/src/openvpn/tls_crypt.h b/src/openvpn/tls_cry=
pt.h</span><br><span>index ffb1f2a..e98aae7 100644</span><br><span>--- a/sr=
c/openvpn/tls_crypt.h</span><br><span>+++ b/src/openvpn/tls_crypt.h</span><=
br><span>@@ -122,13 +122,11 @@</span><br><span>  *</span><br><span>  * All =
renegotiations of a session use the same generated dynamic key.</span><br><=
span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param mul=
ti     multi session struct</span><br><span>  * @param session   session th=
at will be used for the TLS EKM exporter</span><br><span>  * @return       =
   true iff generating the key was successful</span><br><span>  */</span><b=
r><span> bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_sess=
ion_generate_dynamic_tls_crypt_key(struct tls_multi *multi,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
      struct tls_session *session);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+tls_session_generate_dynamic_tls_crypt_key(struct tls_sessi=
on *session);</span><br><span> </span><br><span> /**</span><br><span>  * Re=
turns the maximum overhead (in bytes) added to the destination buffer by</s=
pan><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br>=
<span>index dbe3dfc..4817f45 100644</span><br><span>--- a/src/openvpn/tun.c=
</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -1068,7 +1068,7=
 @@</span><br><span>     r6.metric  =3D 0;                     /* connected=
 route */</span><br><span>     r6.flags   =3D RT_DEFINED | RT_ADDED | RT_ME=
TRIC_DEFINED;</span><br><span>     route_ipv6_clear_host_bits(&amp;r6);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    delete_route_ipv6(&am=
p;r6, tt, 0, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    delete_route_ipv6(&amp;r6, tt, NULL, NULL);</span><br><span> }</s=
pan><br><span> #endif /* if defined(_WIN32) || defined(TARGET_DARWIN) || de=
fined(TARGET_NETBSD) || defined(TARGET_OPENBSD) */</span><br><span> </span>=
<br><span>diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/un=
it_tests/openvpn/test_tls_crypt.c</span><br><span>index 94cd0ee..ee252f4 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/test_tls_crypt.c</span>=
<br><span>+++ b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>@=
@ -241,7 +241,6 @@</span><br><span> </span><br><span>     struct gc_arena g=
c =3D gc_new();</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    struct tls_multi multi =3D { 0 };</span><br><span>     stru=
ct tls_session session =3D { 0 };</span><br><span> </span><br><span>     st=
ruct tls_options tls_opt =3D { 0 };</span><br><span>@@ -250,7 +249,7 @@</sp=
an><br><span>     tls_opt.frame.buf.payload_size =3D 512;</span><br><span> =
    session.opt =3D &amp;tls_opt;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    tls_session_generate_dynamic_tls_crypt_=
key(&amp;multi, &amp;session);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    tls_session_generate_dynamic_tls_crypt_key(&amp;session);</s=
pan><br><span> </span><br><span>     struct tls_wrap_ctx *rctx =3D &amp;ses=
sion.tls_wrap_reneg;</span><br><span> </span><br><span>@@ -272,7 +271,7 @@<=
/span><br><span>     memset(&amp;session.tls_wrap.original_wrap_keydata.key=
s, 0x00, sizeof(session.tls_wrap.original_wrap_keydata.keys));</span><br><s=
pan>     session.tls_wrap.original_wrap_keydata.n =3D 2;</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tls_session_genera=
te_dynamic_tls_crypt_key(&amp;multi, &amp;session);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    tls_session_generate_dynamic_tls_cryp=
t_key(&amp;session);</span><br><span>     tls_crypt_wrap(&amp;ctx-&gt;sourc=
e, &amp;rctx-&gt;work, &amp;rctx-&gt;opt);</span><br><span>     assert_int_=
equal(buf_len(&amp;ctx-&gt;source) + 40, buf_len(&amp;rctx-&gt;work));</spa=
n><br><span> </span><br><span>@@ -281,7 +280,7 @@</span><br><span> </span><=
br><span>     /* XOR should not force a different key */</span><br><span>  =
   memset(&amp;session.tls_wrap.original_wrap_keydata.keys, 0x42, sizeof(se=
ssion.tls_wrap.original_wrap_keydata.keys));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    tls_session_generate_dynamic_tls_crypt_key(&amp;=
multi, &amp;session);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    tls_session_generate_dynamic_tls_crypt_key(&amp;session);</span><br><=
span> </span><br><span>     tls_crypt_wrap(&amp;ctx-&gt;source, &amp;rctx-&=
gt;work, &amp;rctx-&gt;opt);</span><br><span>     assert_int_equal(buf_len(=
&amp;ctx-&gt;source) + 40, buf_len(&amp;rctx-&gt;work));</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/862?usp=3Demail">change 862</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/862?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--bS3e19FxObQ=--

