From: Antonio Quartulli <a@...2181...>
Date: Thu, 13 Jul 2017 11:38:48 +0800
Message-Id: <20170713033848.11902-1-a@...2181...>
Subject: [Openvpn-devel] [PATCH] fix compilation for --disable-multi
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
Cc: ValdikSS <valdikss@...277...>, Antonio Quartulli <a@...2181...>

Due to the introduction of the options.pull attribute and the
ncp logic, various parts of the code try to access members
that are not available when --disable-multi is selected.

Avoid such issue by placing several "#if P2MP" around the
faulty code.

Introduced-by: 598e03f0e7bc ("Always push basic set of peer info values to server.")
Reported-by: ValdikSS <valdikss@...277...>
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c    | 23 ++++++++++++++++++++++-
 src/openvpn/options.c |  4 +++-
 2 files changed, 25 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a54307ad..1105f081 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2150,6 +2150,7 @@ do_deferred_options(struct context *c, const unsigned int found)
     }
 
     /* process (potentially pushed) crypto options */
+#if P2MP
     if (c->options.pull)
     {
         struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
@@ -2169,6 +2170,7 @@ do_deferred_options(struct context *c, const unsigned int found)
             return false;
         }
     }
+#endif
 #endif /* ifdef ENABLE_CRYPTO */
     return true;
 }
@@ -2498,9 +2500,11 @@ do_init_crypto_tls_c1(struct context *c)
                                options->tls_crypt_inline, options->tls_server);
         }
 
+#if P2MP
         c->c1.ciphername = options->ciphername;
         c->c1.authname = options->authname;
         c->c1.keysize = options->keysize;
+#endif
 
 #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code will break restarts */
         if (options->priv_key_file_inline)
@@ -2514,10 +2518,12 @@ do_init_crypto_tls_c1(struct context *c)
     {
         msg(D_INIT_MEDIUM, "Re-using SSL/TLS context");
 
+#if P2MP
         /* Restore pre-NCP cipher options */
         c->options.ciphername = c->c1.ciphername;
         c->options.authname = c->c1.authname;
         c->options.keysize = c->c1.keysize;
+#endif
     }
 }
 
@@ -2549,6 +2555,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
     packet_id_long_form = cipher_kt_mode_ofb_cfb(c->c1.ks.key_type.cipher);
 
+#if P2MP
     /* Compute MTU parameters (postpone if we push/pull options) */
     if (c->options.pull || c->options.mode == MODE_SERVER)
     {
@@ -2556,6 +2563,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         frame_add_to_extra_frame(&c->c2.frame, crypto_max_overhead());
     }
     else
+#endif
     {
         crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
                                        options->replay, packet_id_long_form);
@@ -2584,8 +2592,10 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.replay_window = options->replay_window;
     to.replay_time = options->replay_time;
     to.tcp_mode = link_socket_proto_connection_oriented(options->ce.proto);
+#if P2MP
     to.config_ciphername = c->c1.ciphername;
     to.config_authname = c->c1.authname;
+#endif
     to.ncp_enabled = options->ncp_enabled;
     to.transition_window = options->transition_window;
     to.handshake_window = options->handshake_window;
@@ -2595,6 +2605,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
     to.renegotiate_seconds = options->renegotiate_seconds;
     to.single_session = options->single_session;
     to.mode = options->mode;
+#if P2MP
     to.pull = options->pull;
 #ifdef ENABLE_PUSH_PEER_INFO
     if (options->push_peer_info)        /* all there is */
@@ -2610,6 +2621,7 @@ do_init_crypto_tls(struct context *c, const unsigned int flags)
         to.push_peer_info_detail = 0;
     }
 #endif
+#endif
 
     /* should we not xmit any packets until we get an initial
      * response from client? */
@@ -3698,7 +3710,14 @@ management_callback_network_change(void *arg, bool samenetwork)
     }
 
     socketfd = c->c2.link_socket->sd;
-    if (!c->options.pull || c->c2.tls_multi->use_peer_id || samenetwork)
+
+    bool pull = false;
+
+#if P2MP
+    pull = c->options.pull;
+#endif
+
+    if (!pull || c->c2.tls_multi->use_peer_id || samenetwork)
     {
         return socketfd;
     }
@@ -4260,11 +4279,13 @@ inherit_context_child(struct context *dest,
     dest->c1.ks.ssl_ctx = src->c1.ks.ssl_ctx;
     dest->c1.ks.tls_wrap_key = src->c1.ks.tls_wrap_key;
     dest->c1.ks.tls_auth_key_type = src->c1.ks.tls_auth_key_type;
+#if P2MP
     /* inherit pre-NCP ciphers */
     dest->c1.ciphername = src->c1.ciphername;
     dest->c1.authname = src->c1.authname;
     dest->c1.keysize = src->c1.keysize;
 #endif
+#endif
 
     /* options */
     dest->options = src->options;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 505c5b2e..9f1eb3ff 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3006,6 +3006,7 @@ options_postprocess_mutate(struct options *o)
         }
     }
 
+#if P2MP
     /* cipher negotiation (NCP) currently assumes --pull or --mode server */
     if (o->ncp_enabled
         && !(o->pull || o->mode == MODE_SERVER) )
@@ -3015,6 +3016,7 @@ options_postprocess_mutate(struct options *o)
         o->ncp_enabled = false;
     }
 #endif
+#endif
 
 #if ENABLE_MANAGEMENT
     if (o->http_proxy_override)
@@ -3442,7 +3444,7 @@ static size_t
 calc_options_string_link_mtu(const struct options *o, const struct frame *frame)
 {
     size_t link_mtu = EXPANDED_SIZE(frame);
-#ifdef ENABLE_CRYPTO
+#if defined(ENABLE_CRYPTO) && P2MP
     if (o->pull || o->mode == MODE_SERVER)
     {
         struct frame fake_frame = *frame;
-- 
2.13.2


