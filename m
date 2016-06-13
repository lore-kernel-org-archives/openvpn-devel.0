From: Steffan Karger <steffan@...1856...>
Date: Mon, 13 Jun 2016 23:17:49 +0200
Message-Id: <1465852669-7440-1-git-send-email-steffan@...1856...>
In-Reply-To: <1465411141-16560-1-git-send-email-steffan@...1856...>
References: <1465411141-16560-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCHv3 5/5] Add server-side support for cipher
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

Pushes AES-256-GCM when a connecting client advertises IV_NCP=2, and
supports serving connections to clients with different data channel
cipher configuration simultaneously.

v2:
 * Update manpage
 * Add Changes.rst entry

v3:
 * Do not regenerate keys if the client sends a second pull request
 * Don't postpone key generation if client has no IV_NCP support (to also
   support clients that do not send a push request)

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 Changes.rst              | 11 +++++++++++
 doc/openvpn.8            |  4 ++++
 src/openvpn/init.c       |  5 +++--
 src/openvpn/push.c       | 35 +++++++++++++++++++++++++----------
 src/openvpn/ssl.c        | 37 +++++++++++++++++++++++++------------
 src/openvpn/ssl_common.h |  1 +
 6 files changed, 69 insertions(+), 24 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 1ac3c2b..eb6018f 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -51,6 +51,13 @@ AEAD (GCM) data channel cipher support
     bytes per packet for AES-128-GCM instead of 36 bytes per packet for
     AES-128-CBC + HMAC-SHA1).
 
+Cipher negotiation
+    Data channel ciphers are now by default negotiated.  If a client advertises
+    support for Negotiable Crypto Parameters (NCP), the server will choose a
+    cipher (by default AES-256-GCM) for the data channel, and tell the client
+    to use that cipher.  Data channel cipher negotiation can be controlled
+    using --ncp-ciphers and --ncp-disable.
+
 
 User-visible Changes
 --------------------
@@ -106,6 +113,10 @@ User-visible Changes
 - mbed TLS builds: minimum RSA key size is now 2048 bits.  Shorter keys will
   not be accepted, both local and from the peer.
 
+- Data channel cipher negotiation (see New features section) can override
+  ciphers configured in the config file.  Use --ncp-disable if you don't want
+  that.
+
 
 Maintainer-visible changes
 --------------------------
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index e349b77..5cb2885 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4134,6 +4134,10 @@ Restrict the allowed ciphers to be negotiated to the ciphers in
 .B cipher_list
 is a colon-separated list of ciphers, and defaults to
 "AES-256-GCM:AES-128-GCM".
+
+For servers, the first cipher from
+.B cipher_list
+will be pushed to clients that support cipher negotiation.
 .\"*********************************************************
 .TP
 .B \-\-ncp\-disable
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b4efaf0..eb40e5b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2314,8 +2314,8 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   /* In short form, unique datagram identifier is 32 bits, in long form 64 bits */
   packet_id_long_form = cipher_kt_mode_ofb_cfb (c->c1.ks.key_type.cipher);
 
-  /* Compute MTU parameters (postpone if we pull options) */
-  if (c->options.pull)
+  /* Compute MTU parameters (postpone if we push/pull options) */
+  if (c->options.pull || c->options.mode == MODE_SERVER)
     {
       /* Account for worst-case crypto overhead before allocating buffers */
       frame_add_to_extra_frame (&c->c2.frame, crypto_max_overhead());
@@ -2359,6 +2359,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.renegotiate_packets = options->renegotiate_packets;
   to.renegotiate_seconds = options->renegotiate_seconds;
   to.single_session = options->single_session;
+  to.mode = options->mode;
   to.pull = options->pull;
 #ifdef ENABLE_PUSH_PEER_INFO
   if (options->push_peer_info)		/* all there is */
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 4239e3e..000c82f 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -245,13 +245,30 @@ incoming_push_message (struct context *c, const struct buffer *buffer)
 	  if (!do_up (c, true, c->options.push_option_types_found))
 	    {
 	      msg (D_PUSH_ERRORS, "Failed to open tun/tap interface");
-	      register_signal (c, SIGUSR1, "do_up-failed");
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
+	  /* Do not regenerate keys if client send a second push request */
+	  if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized &&
+	      !tls_session_update_crypto_params (session, &c->options,
+		  &c->c2.frame))
+	    {
+	      msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
+	      goto error;
+	    }
+	}
+    }
 
+  goto cleanup;
+error:
+  register_signal (c, SIGUSR1, "process-push-msg-failed");
 cleanup:
   gc_free (&gc);
 }
@@ -302,15 +319,13 @@ prepare_push_reply (struct options *o, struct tls_multi *tls_multi)
     }
 
   /* Push cipher if client supports Negotiable Crypto Parameters */
-  optstr = peer_info ? strstr(peer_info, "IV_NCP=") : NULL;
-  if (optstr)
+  if (tls_peer_info_ncp_ver (peer_info) >= 2 && o->ncp_enabled)
     {
-      int ncp = 0;
-      int r = sscanf(optstr, "IV_NCP=%d", &ncp);
-      if ((r == 1) && (ncp == 2))
-	{
-	  push_option_fmt(o, M_USAGE, "cipher %s", o->ciphername);
-	}
+      /* Push the first cipher from --ncp-ciphers to the client.
+       * TODO: actual negotiation, instead of server dictatorship. */
+      char *push_cipher = string_alloc(o->ncp_ciphers, &o->gc);
+      o->ciphername = strtok (push_cipher, ":");
+      push_option_fmt(o, M_USAGE, "cipher %s", o->ciphername);
     }
   return true;
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 124d458..baf4085 100644
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
@@ -1691,12 +1691,13 @@ tls_session_update_crypto_params(struct tls_session *session,
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
@@ -1954,8 +1955,11 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       buf_printf(&out, "IV_PROTO=2\n");
 
       /* support for Negotiable Crypto Paramters */
-      if (session->opt->ncp_enabled && session->opt->pull)
-	buf_printf(&out, "IV_NCP=2\n");
+      if (session->opt->ncp_enabled &&
+	  (session->opt->mode == MODE_SERVER || session->opt->pull))
+	{
+	  buf_printf(&out, "IV_NCP=2\n");
+	}
 
       /* push compression status */
 #ifdef USE_COMP
@@ -2057,10 +2061,13 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
   if (!push_peer_info (buf, session))
     goto error;
 
-  /*
-   * generate tunnel keys if server
+  /* Generate tunnel keys if we're a TLS server.
+   * If we're a p2mp server and IV_NCP >= 2 is negotiated, the first key
+   * generation is postponed until after the pull/push, so we can process pushed
+   * cipher directives.
    */
-  if (session->opt->server)
+  if (session->opt->server && !(session->opt->ncp_enabled &&
+	session->opt->mode == MODE_SERVER && ks->key_id <= 0))
     {
       if (ks->authenticated)
 	{
@@ -2214,6 +2221,12 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
       output_peer_info_env (session->opt->es, multi->peer_info);
 #endif
 
+  if (tls_peer_info_ncp_ver (multi->peer_info) < 2)
+    {
+      /* Peer does not support NCP */
+      session->opt->ncp_enabled = false;
+    }
+
   if (tls_session_user_pass_enabled(session))
     {
       /* Perform username/password authentication */
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


