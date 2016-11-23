From: Steffan Karger <steffan@...1856...>
Date: Wed, 23 Nov 2016 21:02:04 +0100
Message-Id: <1479931325-25919-1-git-send-email-steffan@...1856...>
In-Reply-To: <20161122211835.GJ28918@...1296...>
References: <20161122211835.GJ28918@...1296...>
Subject: [Openvpn-devel] [PATCH 1/2 v5] Poor man's NCP for non-NCP peers
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

Allows non-NCP peers (<= 2.3, or 2.4+ with --ncp-disable) to specify a
--cipher that is different from the one in our config, as long as the new
cipher value is allowed (i.e. in --ncp-ciphers at our side).

This works both client-to-server and server-to-client.  I.e. a 2.4 client
with "cipher BF-CBC" and "ncp-ciphers AES-256-GCM:AES-256-CBC" can connect
to both a 2.3 server with "cipher BF-CBC" as well as a server with
"cipher AES-256-CBC" in its config.  The other way around, a 2.3 client
with either "cipher BF-CBC" or "cipher AES-256-CBC" can connect to a 2.4
server with e.g. "cipher BF-CBC" and "ncp-ciphers AES-256-GCM:AES-256-CBC"
in its config.

This patch was inspired by Gert's "Poor man's NCP for 2.3 clients" patch,
but takes a different approach to avoid the need for server-side scripts
or client-side 'setenv UV_*' tricks.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2: remove unused argument from options_string_extract_option()
v3: don't do poor-man's NCP if NCP is disabled
v4: use strncmp instead of strstr to match prefix in
    options_string_extract_option, add man page text and make clear
    that this feature works both client-to-server and server-to-client.
v5: move poor-mans-ncp logic from key_method_2_read() to the place
    where we do regular NCP too.  This makes that we no longer need
    access to the struct context in key_method_2_read, and is cleaner
    in general, and makes the patch a bit smaller.

 doc/openvpn.8            | 14 ++++++++++++--
 src/openvpn/init.c       |  8 +++++++-
 src/openvpn/options.c    | 32 ++++++++++++++++++++++++++++++++
 src/openvpn/options.h    | 14 ++++++++++++++
 src/openvpn/push.c       |  6 +++++-
 src/openvpn/ssl.c        | 39 ++++++++++++++++++++++++++-------------
 src/openvpn/ssl.h        | 16 ++++++++++++++++
 src/openvpn/ssl_common.h |  2 ++
 8 files changed, 114 insertions(+), 17 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 171bd72..4356597 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -4147,9 +4147,9 @@ to disable encryption.
 As of OpenVPN 2.4, cipher negotiation (NCP) can override the cipher specified by
 .B \-\-cipher\fR.
 See
-.B \-\-ncp-ciphers
+.B \-\-ncp\-ciphers
 and
-.B \-\-ncp-disable
+.B \-\-ncp\-disable
 for more on NCP.
 
 .\"*********************************************************
@@ -4177,6 +4177,16 @@ If both peers support and do not disable NCP, the negotiated cipher will
 override the cipher specified by
 .B \-\-cipher\fR.
 
+Additionally, to allow for more smooth transition, if NCP is enabled, OpenVPN
+will inherit the cipher of the peer if that cipher is different from the local
+.B \-\-cipher
+setting, but the peer cipher is one of the ciphers specified in
+.B \-\-ncp\-ciphers\fR.
+E.g. a non-NCP client (<=2.3, or with \-\-ncp\-disabled set) connecting to a
+NCP server (2.4+) with "\-\-cipher BF-CBC" and "\-\-ncp-ciphers
+AES-256-GCM:AES-256-CBC" set can either specify "\-\-cipher BF-CBC" or
+"\-\-cipher AES-256-CBC" and both will work.
+
 .\"*********************************************************
 .TP
 .B \-\-ncp\-disable
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2ed633c..1954947 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1925,7 +1925,13 @@ do_deferred_options (struct context *c, const unsigned int found)
     {
       struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
       if (found & OPT_P_NCP)
-	msg (D_PUSH, "OPTIONS IMPORT: data channel crypto options modified");
+	{
+	  msg (D_PUSH, "OPTIONS IMPORT: data channel crypto options modified");
+	}
+      else if (c->options.ncp_enabled)
+	{
+	  tls_poor_mans_ncp(&c->options, c->c2.tls_multi->remote_ciphername);
+	}
       /* Do not regenerate keys if server sends an extra push request */
       if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized &&
 	  !tls_session_update_crypto_params(session, &c->options, &c->c2.frame))
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 102b4d0..7d042a8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1643,6 +1643,8 @@ show_settings (const struct options *o)
   SHOW_STR (shared_secret_file);
   SHOW_INT (key_direction);
   SHOW_STR (ciphername);
+  SHOW_BOOL (ncp_enabled);
+  SHOW_STR (ncp_ciphers);
   SHOW_STR (authname);
   SHOW_STR (prng_hash);
   SHOW_INT (prng_nonce_secret_len);
@@ -3434,6 +3436,36 @@ options_string_version (const char* s, struct gc_arena *gc)
 
 #endif /* ENABLE_OCC */
 
+char *
+options_string_extract_option (const char *options_string,const char *opt_name,
+    struct gc_arena *gc)
+{
+  char *ret = NULL;
+  const size_t opt_name_len = strlen(opt_name);
+
+  const char *p = options_string;
+  while (p)
+    {
+      if (0 == strncmp(p, opt_name, opt_name_len) &&
+	  strlen(p) > (opt_name_len+1) && p[opt_name_len] == ' ')
+	{
+	  /* option found, extract value */
+	  const char *start = &p[opt_name_len+1];
+	  const char *end = strchr (p, ',');
+	  size_t val_len = end ? end - start : strlen (start);
+	  ret = gc_malloc (val_len+1, true, gc);
+	  memcpy (ret, start, val_len);
+	  break;
+	}
+      p = strchr (p, ',');
+      if (p)
+	{
+	  p++; /* skip delimiter */
+	}
+    }
+  return ret;
+}
+
 static void
 foreign_option (struct options *o, char *argv[], int len, struct env_set *es)
 {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index a028556..913bfde 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -724,6 +724,20 @@ void options_warning_safe (char *actual, const char *expected, size_t actual_n);
 bool options_cmp_equal (char *actual, const char *expected);
 void options_warning (char *actual, const char *expected);
 
+/**
+ * Given an OpenVPN options string, extract the value of an option.
+ *
+ * @param options_string	Zero-terminated, comma-separated options string
+ * @param opt_name		The name of the option to extract
+ * @param gc			The gc to allocate the return value
+ *
+ * @return gc-allocated value of option with name opt_name if option was found,
+ *         or NULL otherwise.
+ */
+char *options_string_extract_option (const char *options_string,
+    const char *opt_name, struct gc_arena *gc);
+
+
 #endif
 
 void options_postprocess (struct options *options);
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index b7539e6..9953079 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -262,7 +262,7 @@ incoming_push_message (struct context *c, const struct buffer *buffer)
 	      !tls_session_update_crypto_params (session, &c->options,
 		  &c->c2.frame))
 	    {
-	      msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
+	      msg (D_TLS_ERRORS, "TLS Error: initializing data channel failed");
 	      goto error;
 	    }
 	}
@@ -370,6 +370,10 @@ prepare_push_reply (struct context *c, struct gc_arena *gc,
 	  push_option_fmt(gc, push_list, M_USAGE, "cipher %s", o->ciphername);
 	}
     }
+  else if (o->ncp_enabled)
+    {
+      tls_poor_mans_ncp (o, tls_multi->remote_ciphername);
+    }
 
   /* If server uses --auth-gen-token and we have an auth token
    * to send to the client
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 16b9cb7..4e84a71 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1216,6 +1216,8 @@ tls_multi_free (struct tls_multi *multi, bool clear)
       free (multi->auth_token);
     }
 
+  free (multi->remote_ciphername);
+
   for (i = 0; i < TM_SIZE; ++i)
     tls_session_free (&multi->session[i], false);
 
@@ -1723,8 +1725,8 @@ key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len) {
     }
 }
 
-static bool
-item_in_list(const char *item, const char *list)
+bool
+tls_item_in_cipher_list(const char *item, const char *list)
 {
   char *tmp_ciphers = string_alloc (list, NULL);
   char *tmp_ciphers_orig = tmp_ciphers;
@@ -1741,6 +1743,20 @@ item_in_list(const char *item, const char *list)
   return token != NULL;
 }
 
+void
+tls_poor_mans_ncp(struct options *o, const char *remote_ciphername)
+{
+  if (o->ncp_enabled && remote_ciphername &&
+      0 != strcmp(o->ciphername, remote_ciphername))
+    {
+      if (tls_item_in_cipher_list(remote_ciphername, o->ncp_ciphers))
+	{
+	  o->ciphername = string_alloc(remote_ciphername, &o->gc);
+	  msg (D_TLS_DEBUG_LOW, "Using peer cipher '%s'", o->ciphername);
+	}
+    }
+}
+
 bool
 tls_session_update_crypto_params(struct tls_session *session,
     const struct options *options, struct frame *frame)
@@ -1752,7 +1768,7 @@ tls_session_update_crypto_params(struct tls_session *session,
 
   if (!session->opt->server &&
       0 != strcmp(options->ciphername, session->opt->config_ciphername) &&
-      !item_in_list(options->ciphername, options->ncp_ciphers))
+      !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
     {
       msg (D_TLS_ERRORS, "Error: pushed cipher not allowed - %s not in %s or %s",
 	  options->ciphername, session->opt->config_ciphername,
@@ -2152,12 +2168,11 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
     goto error;
 
   /* Generate tunnel keys if we're a TLS server.
-   * If we're a p2mp server and IV_NCP >= 2 is negotiated, the first key
-   * generation is postponed until after the pull/push, so we can process pushed
-   * cipher directives.
+   * If we're a p2mp server, the first key generation is postponed until after
+   * the pull/push, so we can process pushed cipher directives.
    */
-  if (session->opt->server && !(session->opt->ncp_enabled &&
-	session->opt->mode == MODE_SERVER && ks->key_id <= 0))
+  if (session->opt->server &&
+      !(session->opt->mode == MODE_SERVER && ks->key_id <= 0))
     {
       if (ks->authenticated)
 	{
@@ -2312,11 +2327,9 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
   if ( multi->peer_info )
       output_peer_info_env (session->opt->es, multi->peer_info);
 
-  if (tls_peer_info_ncp_ver (multi->peer_info) < 2)
-    {
-      /* Peer does not support NCP */
-      session->opt->ncp_enabled = false;
-    }
+  free (multi->remote_ciphername);
+  multi->remote_ciphername =
+      options_string_extract_option (options, "cipher", NULL);
 #endif
 
   if (tls_session_user_pass_enabled(session))
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 777b621..047eb24 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -489,6 +489,15 @@ void tls_update_remote_addr (struct tls_multi *multi,
 bool tls_session_update_crypto_params(struct tls_session *session,
     const struct options *options, struct frame *frame);
 
+/**
+ * "Poor man's NCP": Use peer cipher if it is an allowed (NCP) cipher.
+ * Allows non-NCP peers to upgrade their cipher individually.
+ *
+ * Make sure to call tls_session_update_crypto_params() after calling this
+ * function.
+ */
+void tls_poor_mans_ncp(struct options *o, const char *remote_ciphername);
+
 #ifdef MANAGEMENT_DEF_AUTH
 static inline char *
 tls_get_peer_info(const struct tls_multi *multi)
@@ -512,6 +521,13 @@ int tls_peer_info_ncp_ver(const char *peer_info);
  */
 bool tls_check_ncp_cipher_list(const char *list);
 
+/**
+ * Return true iff item is present in the colon-separated zero-terminated
+ * cipher list.
+ */
+bool tls_item_in_cipher_list(const char *item, const char *list);
+
+
 /*
  * inline functions
  */
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index 28702af..7938f41 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -540,6 +540,8 @@ struct tls_multi
   uint32_t peer_id;
   bool use_peer_id;
 
+  char *remote_ciphername;	/**< cipher specified in peer's config file */
+
   char *auth_token;      /**< If server sends a generated auth-token,
                           *   this is the token to use for future
                           *   user/pass authentications in this session.
-- 
2.7.4


