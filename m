From: Steffan Karger <steffan@...1856...>
Date: Wed,  8 Jun 2016 14:20:42 +0200
Message-Id: <1465388443-15484-5-git-send-email-steffan@...1856...>
In-Reply-To: <1465388443-15484-1-git-send-email-steffan@...1856...>
References: <1465388443-15484-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 4/5] Add options to restrict cipher
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

Add --ncp-disable to completely disable cipher negotiation, and
--ncp-ciphers to specify which ciphers to accept from the server.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/init.c       | 34 ++++++++++++++++++++++++++++------
 src/openvpn/init.h       |  4 ++--
 src/openvpn/openvpn.h    |  3 +++
 src/openvpn/options.c    | 38 +++++++++++++++++++++++++++-----------
 src/openvpn/options.h    |  4 +++-
 src/openvpn/push.c       | 12 +++++++++++-
 src/openvpn/ssl.c        | 30 +++++++++++++++++++++++++++++-
 src/openvpn/ssl_common.h |  4 ++++
 8 files changed, 107 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5eded09..af61045 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1739,7 +1739,7 @@ options_hash_changed_or_zero(const struct md5_digest *a,
 }
 #endif /* P2MP */
 
-void
+bool
 do_up (struct context *c, bool pulled_options, unsigned int option_types_found)
 {
   if (!c->c2.do_up_ran)
@@ -1747,7 +1747,13 @@ do_up (struct context *c, bool pulled_options, unsigned int option_types_found)
       reset_coarse_timers (c);
 
       if (pulled_options && option_types_found)
-	do_deferred_options (c, option_types_found);
+	{
+	  if (!do_deferred_options (c, option_types_found))
+	    {
+	      msg (D_PUSH_ERRORS, "ERROR: Failed to apply push options");
+	      return false;
+	    }
+	}
 
       /* if --up-delay specified, open tun, do ifconfig, and run up script now */
       if (c->options.up_delay || PULL_DEFINED (&c->options))
@@ -1802,6 +1808,7 @@ do_up (struct context *c, bool pulled_options, unsigned int option_types_found)
 	
       c->c2.do_up_ran = true;
     }
+  return true;
 }
 
 /*
@@ -1819,7 +1826,6 @@ pull_permission_mask (const struct context *c)
     | OPT_P_SHAPER
     | OPT_P_TIMER
     | OPT_P_COMP
-    | OPT_P_CRYPTO
     | OPT_P_PERSIST
     | OPT_P_MESSAGES
     | OPT_P_EXPLICIT_NOTIFY
@@ -1830,13 +1836,16 @@ pull_permission_mask (const struct context *c)
   if (!c->options.route_nopull)
     flags |= (OPT_P_ROUTE | OPT_P_IPWIN32);
 
+  if (c->options.ncp_enabled)
+    flags |= OPT_P_NCP;
+
   return flags;
 }
 
 /*
  * Handle non-tun-related pulled options.
  */
-void
+bool
 do_deferred_options (struct context *c, const unsigned int found)
 {
   if (found & OPT_P_MESSAGES)
@@ -1927,10 +1936,17 @@ do_deferred_options (struct context *c, const unsigned int found)
   /* process (potenitally pushed) crypto options */
   if (c->options.pull)
     {
-      tls_session_update_crypto_params(&c->c2.tls_multi->session[TM_ACTIVE],
-          &c->options, &c->c2.frame);
+      if (found & OPT_P_NCP)
+	msg (D_PUSH, "OPTIONS IMPORT: data channel crypto options modified");
+      if (!tls_session_update_crypto_params(
+	  &c->c2.tls_multi->session[TM_ACTIVE], &c->options, &c->c2.frame))
+	{
+	  msg (D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
+	  return false;
+	}
     }
 #endif
+  return true;
 }
 
 /*
@@ -2250,6 +2266,9 @@ do_init_crypto_tls_c1 (struct context *c)
 	      &c->c1.ks.tls_auth_key, file, options->key_direction, flags);
 	}
 
+      c->c1.ciphername = options->ciphername;
+      c->c1.authname = options->authname;
+
 #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code will break restarts */
       if (options->priv_key_file_inline)
 	{
@@ -2321,6 +2340,9 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
   to.replay_window = options->replay_window;
   to.replay_time = options->replay_time;
   to.tcp_mode = link_socket_proto_connection_oriented (options->ce.proto);
+  to.config_ciphername = c->c1.ciphername;
+  to.config_authname = c->c1.authname;
+  to.ncp_enabled = options->ncp_enabled;
   to.transition_window = options->transition_window;
   to.handshake_window = options->handshake_window;
   to.packet_timeout = options->tls_timeout;
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 73bcb74..1ad4a8e 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -81,7 +81,7 @@ bool do_test_crypto (const struct options *o);
 
 void context_gc_free (struct context *c);
 
-void do_up (struct context *c,
+bool do_up (struct context *c,
 	    bool pulled_options,
 	    unsigned int option_types_found);
 
@@ -91,7 +91,7 @@ const char *format_common_name (struct context *c, struct gc_arena *gc);
 
 void reset_coarse_timers (struct context *c);
 
-void do_deferred_options (struct context *c, const unsigned int found);
+bool do_deferred_options (struct context *c, const unsigned int found);
 
 void inherit_context_child (struct context *dest,
 			    const struct context *src);
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 3281fd7..395195f 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -210,6 +210,9 @@ struct context_1
   struct user_pass *auth_user_pass;
                                 /**< Username and password for
                                  *   authentication. */
+
+  const char *ciphername;	/**< Data channel cipher from config file */
+  const char *authname;		/**< Data channel auth from config file */
 #endif
 };
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 23f407c..87255d0 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -830,6 +830,12 @@ init_options (struct options *o, const bool init_gc)
 #ifdef ENABLE_CRYPTO
   o->ciphername = "BF-CBC";
   o->ciphername_defined = true;
+#ifdef HAVE_AEAD_CIPHER_MODES /* IV_NCP=2 requires GCM support */
+  o->ncp_enabled = true;
+#else
+  o->ncp_enabled = false;
+#endif
+  o->ncp_ciphers = "AES-256-GCM:AES-128-GCM";
   o->authname = "SHA1";
   o->authname_defined = true;
   o->prng_hash = "SHA1";
@@ -6601,7 +6607,7 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "auth") && p[1] && !p[2])
     {
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
       options->authname_defined = true;
       options->authname = p[1];
       if (streq (options->authname, "none"))
@@ -6612,12 +6618,12 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "auth") && !p[1])
     {
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
       options->authname_defined = true;
     }
   else if (streq (p[0], "cipher") && p[1] && !p[2])
     {
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_NCP);
       options->ciphername_defined = true;
       options->ciphername = p[1];
       if (streq (options->ciphername, "none"))
@@ -6628,12 +6634,22 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "cipher") && !p[1])
     {
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
       options->ciphername_defined = true;
     }
+  else if (streq (p[0], "ncp-ciphers") && p[1] && !p[2])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->ncp_ciphers = p[1];
+    }
+  else if (streq (p[0], "ncp-disable") && !p[1])
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      options->ncp_enabled = false;
+    }
   else if (streq (p[0], "prng") && p[1] && !p[3])
     {
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
       if (streq (p[1], "none"))
 	options->prng_hash = NULL;
       else
@@ -6655,12 +6671,12 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "no-replay") && !p[1])
     {
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
       options->replay = false;
     }
   else if (streq (p[0], "replay-window") && !p[3])
     {
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
       if (p[1])
 	{
 	  int replay_window;
@@ -6700,12 +6716,12 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "mute-replay-warnings") && !p[1])
     {
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
       options->mute_replay_warnings = true;
     }
   else if (streq (p[0], "no-iv") && !p[1])
     {
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
       options->use_iv = false;
     }
   else if (streq (p[0], "replay-persist") && p[1] && !p[2])
@@ -6735,7 +6751,7 @@ add_option (struct options *options,
     {
       int keysize;
 
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_NCP);
       keysize = atoi (p[1]) / 8;
       if (keysize < 0 || keysize > MAX_CIPHER_KEY_LENGTH)
 	{
@@ -6764,7 +6780,7 @@ add_option (struct options *options,
     }
   else if (streq (p[0], "ecdh-curve") && p[1] && !p[2])
     {
-      VERIFY_PERMISSION (OPT_P_CRYPTO);
+      VERIFY_PERMISSION (OPT_P_GENERAL);
       options->ecdh_curve= p[1];
     }
   else if (streq (p[0], "tls-server") && !p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 514511b..ea63c4c 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -474,6 +474,8 @@ struct options
   int key_direction;
   bool ciphername_defined;
   const char *ciphername;
+  bool ncp_enabled;
+  const char *ncp_ciphers;
   bool authname_defined;
   const char *authname;
   int keysize;
@@ -618,7 +620,7 @@ struct options
 #define OPT_P_PERSIST_IP      (1<<9)
 #define OPT_P_COMP            (1<<10) /* TODO */
 #define OPT_P_MESSAGES        (1<<11)
-#define OPT_P_CRYPTO          (1<<12) /* TODO */
+#define OPT_P_NCP             (1<<12) /**< Negotiable crypto parameters */
 #define OPT_P_TLS_PARMS       (1<<13) /* TODO */
 #define OPT_P_MTU             (1<<14) /* TODO */
 #define OPT_P_NICE            (1<<15)
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 38ac59e..5324676 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -239,11 +239,21 @@ incoming_push_message (struct context *c, const struct buffer *buffer)
     {
       c->options.push_option_types_found |= option_types_found;
 
+      /* delay bringing tun/tap up until --push parms received from remote */
       if (status == PUSH_MSG_REPLY)
-	do_up (c, true, c->options.push_option_types_found ); /* delay bringing tun/tap up until --push parms received from remote */
+	{
+	  if (!do_up (c, true, c->options.push_option_types_found))
+	    {
+	      msg (D_PUSH_ERRORS, "Failed to open tun/tap interface");
+	      c->sig->signal_received = SIGUSR1; /* connection reset */
+	      c->sig->signal_text = "open-tuntap-failed";
+	      goto cleanup;
+	    }
+	}
       event_timeout_clear (&c->c2.push_request_interval);
     }
 
+cleanup:
   gc_free (&gc);
 }
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8a87db2..3da254d 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1636,6 +1636,24 @@ key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len) {
     }
 }
 
+static bool
+item_in_list(const char *item, const char *list)
+{
+  char *tmp_ciphers = string_alloc (list, NULL);
+  char *tmp_ciphers_orig = tmp_ciphers;
+
+  const char *token = strtok (tmp_ciphers, ":");
+  while(token)
+    {
+      if (0 == strcmp (token, item))
+	break;
+      token = strtok (NULL, ":");
+    }
+  free(tmp_ciphers_orig);
+
+  return token != NULL;
+}
+
 bool
 tls_session_update_crypto_params(struct tls_session *session,
     const struct options *options, struct frame *frame)
@@ -1646,6 +1664,15 @@ tls_session_update_crypto_params(struct tls_session *session,
   ASSERT (!session->opt->server);
   ASSERT (ks->authenticated);
 
+  if (0 != strcmp(options->ciphername, session->opt->config_ciphername) &&
+      !item_in_list(options->ciphername, options->ncp_ciphers))
+    {
+      msg (D_TLS_ERRORS, "Error: pushed cipher not allowed - %s not in %s or %s",
+	  options->ciphername, session->opt->config_ciphername,
+	  options->ncp_ciphers);
+      return false;
+    }
+
   init_key_type (&session->opt->key_type, options->ciphername,
     options->ciphername_defined, options->authname, options->authname_defined,
     options->keysize, true, true);
@@ -1925,7 +1952,8 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
       buf_printf(&out, "IV_PROTO=2\n");
 
       /* support for Negotiable Crypto Paramters */
-      buf_printf(&out, "IV_NCP=2\n");
+      if (session->opt->ncp_enabled)
+	buf_printf(&out, "IV_NCP=2\n");
 
       /* push compression status */
 #ifdef USE_COMP
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 9183dab..6bfde6b 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -273,6 +273,10 @@ struct tls_options
   int replay_time;                     /* --replay-window parm */
   bool tcp_mode;
 
+  const char *config_ciphername;
+  const char *config_authname;
+  bool ncp_enabled;
+
   /* packet authentication for TLS handshake */
   struct crypto_options tls_auth;
 
-- 
2.7.4


