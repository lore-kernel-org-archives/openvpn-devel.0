From: Steffan Karger <steffan@...1856...>
Date: Wed,  8 Jun 2016 14:20:43 +0200
Message-Id: <1465388443-15484-6-git-send-email-steffan@...1856...>
In-Reply-To: <1465388443-15484-1-git-send-email-steffan@...1856...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 5/5] Add server-side support for cipher
	negotiation
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Pushes AES-256-GCM when a connection client advertises IV_NCP=2, and
supports serving connections to clients with different data channel
cipher configuration simultaneously.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c       |  5 +++--
 src/openvpn/push.c       | 27 +++++++++++++++++++++++----
 src/openvpn/ssl.c        | 23 +++++++++++++----------
 src/openvpn/ssl_common.h |  1 +
 4 files changed, 40 insertions(+), 16 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index af61045..ec0e69e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2310,8 +2310,8 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
   packet_id_long_form = cipher_kt_mode_ofb_cfb (c->c1.ks.key_type.cipher);
 
-  /* Compute MTU parameters (postpone if we pull options) */
-  if (!c->options.pull)
+  /* Compute MTU parameters (postpone if we push/pull options) */
+  if (!c->options.pull && c->options.mode != MODE_SERVER)
     {
       crypto_adjust_frame_parameters(&c->c2.frame, &c->c1.ks.key_type,
 	  options->ciphername_defined, options->use_iv, options->replay,
@@ -2350,6 +2350,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.renegotiate_packets = options->renegotiate_packets;
   to.renegotiate_seconds = options->renegotiate_seconds;
   to.single_session = options->single_session;
+  to.mode = options->mode;
   to.pull = options->pull;
 #ifdef ENABLE_PUSH_PEER_INFO
   if (options->push_peer_info)		/* all there is */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 5324676..dc4d691 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -245,14 +245,29 @@ incoming_push_message (struct context *c, const struct buffer *buffer)
 	  if (!do_up (c, true, c->options.push_option_types_found))
 	    {
 	      msg (D_PUSH_ERRORS, "Failed to open tun/tap interface");
-	      c->sig->signal_received = SIGUSR1; /* connection reset */
-	      c->sig->signal_text = "open-tuntap-failed";
-	      goto cleanup;
+	      goto error;
 	    }
 	}
       event_timeout_clear (&c->c2.push_request_interval);
     }
+  else if (status == PUSH_MSG_REQUEST)
+    {
+      if (c->options.mode == MODE_SERVER)
+	{
+	  struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
+	  if (!tls_session_update_crypto_params(session, &c->options,
+	      &c->c2.frame))
+	    {
+	      msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
+	      goto error;
+	    }
+	}
+    }
 
+  goto cleanup;
+error:
+  c->sig->signal_received = SIGUSR1; /* connection reset */
+  c->sig->signal_text = "process-push-msg-failed";
 cleanup:
   gc_free (&gc);
 }
@@ -304,12 +319,16 @@ prepare_push_reply (struct options *o, struct tls_multi *tls_multi)
 
   /* Push cipher if client supports Negotiable Crypto Parameters */
   optstr = peer_info ? strstr(peer_info, "IV_NCP=") : NULL;
-  if (optstr)
+  if (optstr && o->ncp_enabled)
     {
       int ncp = 0;
       int r = sscanf(optstr, "IV_NCP=%d", &ncp);
       if ((r == 1) && (ncp == 2))
 	{
+	  /* Push the first cipher from --ncp-ciphers to the client.
+	   * TODO: actual negotiation, instead of server dictatorship. */
+	  char *push_cipher = string_alloc(o->ncp_ciphers, &o->gc);
+	  o->ciphername = strtok (push_cipher, ":");
 	  push_option_fmt(o, M_USAGE, "cipher %s", o->ciphername);
 	}
     }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 3da254d..7180c3a 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1661,10 +1661,10 @@ tls_session_update_crypto_params(struct tls_session *session,
   bool ret = false;
   struct key_state *ks = &session->key[KS_PRIMARY];	/* primary key */
 
-  ASSERT (!session->opt->server);
   ASSERT (ks->authenticated);
 
-  if (0 != strcmp(options->ciphername, session->opt->config_ciphername) &&
+  if (!session->opt->server &&
+      0 != strcmp(options->ciphername, session->opt->config_ciphername) &&
       !item_in_list(options->ciphername, options->ncp_ciphers))
     {
       msg (D_TLS_ERRORS, "Error: pushed cipher not allowed - %s not in %s or %s",
@@ -1689,12 +1689,13 @@ tls_session_update_crypto_params(struct tls_session *session,
       options->ce.tun_mtu_defined, options->ce.tun_mtu);
   frame_print (frame, D_MTU_INFO, "Data Channel MTU parms");
 
+  const struct session_id *client_sid = session->opt->server ?
+      &ks->session_id_remote : &session->session_id;
+  const struct session_id *server_sid = !session->opt->server ?
+      &ks->session_id_remote : &session->session_id;
   if (!generate_key_expansion (&ks->crypto_options.key_ctx_bi,
-			       &session->opt->key_type,
-			       ks->key_src,
-			       &session->session_id,
-			       &ks->session_id_remote,
-			       false))
+      &session->opt->key_type, ks->key_src, client_sid, server_sid,
+      session->opt->server))
     {
       msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
       goto cleanup;
@@ -2055,10 +2056,12 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
   if (!push_peer_info (buf, session))
     goto error;
 
-  /*
-   * generate tunnel keys if server
+  /* Generate tunnel keys if we're a TLS server.
+   * If we're a p2mp server, the first key generation is postponed until after
+   * the pull/push, so we can process pushed cipher directives.
    */
-  if (session->opt->server)
+  if (session->opt->server &&
+      (session->opt->mode != MODE_SERVER || ks->key_id > 0))
     {
       if (ks->authenticated)
 	{
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 6bfde6b..eb2ad6f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -236,6 +236,7 @@ struct tls_options
 #ifdef ENABLE_OCC
   bool disable_occ;
 #endif
+  int mode;
   bool pull;
 #ifdef ENABLE_PUSH_PEER_INFO
   int push_peer_info_detail;
-- 
2.7.4


