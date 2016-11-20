From: Steffan Karger <steffan@...1856...>
Date: Sun, 20 Nov 2016 18:08:18 +0100
Message-Id: <1479661698-31368-1-git-send-email-steffan@...1856...>
In-Reply-To: <1479653057-14712-1-git-send-email-steffan@...1856...>
References: <1479653057-14712-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH v3] Poor man's NCP for non-NCP clients
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

Allows non-NCP clients (<= 2.3, or 2.4+ with --ncp-disable) to specify a
--cipher that is different from the one in the server config, as long as
the new cipher value is allowed (i.e. in --ncp-ciphers at the server side).

This patch was inspired by Gert's "Poor man's NCP for 2.3 clients" patch,
but takes a different approach to avoid the need for server-side scripts
or client-side 'setenv UV_*' tricks.

To achieve this cleanly, tls_session_update_crypto_parameters() had to be
split into 'update' and 'generate keys' parts.  I used the opportunity to
introduce a simpler API that works for the other places where we used
'generate_key_expansion()' too.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
v2: remove unused argument from options_string_extract_option()
v3: don't do poor-man's NCP if NCP is disabled

 src/openvpn/init.c    |  4 ++-
 src/openvpn/options.c | 32 ++++++++++++++++++
 src/openvpn/options.h | 14 ++++++++
 src/openvpn/push.c    |  7 ++--
 src/openvpn/ssl.c     | 94 ++++++++++++++++++++++++++++-----------------------
 src/openvpn/ssl.h     | 19 +++++++++--
 6 files changed, 122 insertions(+), 48 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 2ed633c..ba19ac4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1928,7 +1928,9 @@ do_deferred_options (struct context *c, const unsigned int found)
 	msg (D_PUSH, "OPTIONS IMPORT: data channel crypto options modified");
       /* Do not regenerate keys if server sends an extra push request */
       if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized &&
-	  !tls_session_update_crypto_params(session, &c->options, &c->c2.frame))
+	  (!tls_session_update_crypto_params (session, &c->options,
+	      &c->c2.frame) ||
+	   !tls_session_generate_data_channel_keys(session)))
 	{
 	  msg (D_TLS_ERRORS, "OPTIONS ERROR: failed to import crypto options");
 	  return false;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index a74de24..778fcbd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3431,6 +3431,38 @@ options_string_version (const char* s, struct gc_arena *gc)
   return BSTR (&out);
 }
 
+char *
+options_string_extract_option (const char *options_string,const char *opt_name,
+    struct gc_arena *gc)
+{
+  char *ret = NULL;
+
+  const char *p = options_string;
+  while (p)
+    {
+      if (p == strstr(p, opt_name))
+	{
+	  const size_t opt_name_len = strlen(opt_name);
+	  if (strlen(p) > opt_name_len+1 && p[opt_name_len] == ' ')
+	    {
+	      /* option found, extract value */
+	      const char *start = &p[opt_name_len+1];
+	      const char *end = strchr (p, ',');
+	      size_t val_len = end ? end - start : strlen (start);
+	      ret = gc_malloc (val_len+1, true, gc);
+	      memcpy (ret, start, val_len);
+	      break;
+	    }
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
 #endif /* ENABLE_OCC */
 
 static void
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
index b7539e6..01bc63c 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -259,10 +259,11 @@ incoming_push_message (struct context *c, const struct buffer *buffer)
 	  struct tls_session *session = &c->c2.tls_multi->session[TM_ACTIVE];
 	  /* Do not regenerate keys if client send a second push request */
 	  if (!session->key[KS_PRIMARY].crypto_options.key_ctx_bi.initialized &&
-	      !tls_session_update_crypto_params (session, &c->options,
-		  &c->c2.frame))
+	      (!tls_session_update_crypto_params (session, &c->options,
+		  &c->c2.frame) ||
+	       !tls_session_generate_data_channel_keys(session)))
 	    {
-	      msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
+	      msg (D_TLS_ERRORS, "TLS Error: initializing data channel failed");
 	      goto error;
 	    }
 	}
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 8bb3f96..ca3f45b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1725,8 +1725,8 @@ key_ctx_update_implicit_iv(struct key_ctx *ctx, uint8_t *key, size_t key_len) {
     }
 }
 
-static bool
-item_in_list(const char *item, const char *list)
+bool
+tls_item_in_cipher_list(const char *item, const char *list)
 {
   char *tmp_ciphers = string_alloc (list, NULL);
   char *tmp_ciphers_orig = tmp_ciphers;
@@ -1744,17 +1744,40 @@ item_in_list(const char *item, const char *list)
 }
 
 bool
-tls_session_update_crypto_params(struct tls_session *session,
-    const struct options *options, struct frame *frame)
+tls_session_generate_data_channel_keys(struct tls_session *session)
 {
   bool ret = false;
   struct key_state *ks = &session->key[KS_PRIMARY];	/* primary key */
+  const struct session_id *client_sid = session->opt->server ?
+      &ks->session_id_remote : &session->session_id;
+  const struct session_id *server_sid = !session->opt->server ?
+      &ks->session_id_remote : &session->session_id;
 
   ASSERT (ks->authenticated);
 
+  if (!generate_key_expansion (&ks->crypto_options.key_ctx_bi,
+      &session->opt->key_type, ks->key_src, client_sid, server_sid,
+      session->opt->server))
+    {
+      msg (D_TLS_ERRORS, "TLS Error: generate_key_expansion failed");
+      goto cleanup;
+    }
+  tls_limit_reneg_bytes (session->opt->key_type.cipher,
+	&session->opt->renegotiate_bytes);
+
+  ret = true;
+cleanup:
+  CLEAR (*ks->key_src);
+  return ret;
+}
+
+bool
+tls_session_update_crypto_params(struct tls_session *session,
+    const struct options *options, struct frame *frame)
+{
   if (!session->opt->server &&
       0 != strcmp(options->ciphername, session->opt->config_ciphername) &&
-      !item_in_list(options->ciphername, options->ncp_ciphers))
+      !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
     {
       msg (D_TLS_ERRORS, "Error: pushed cipher not allowed - %s not in %s or %s",
 	  options->ciphername, session->opt->config_ciphername,
@@ -1779,23 +1802,7 @@ tls_session_update_crypto_params(struct tls_session *session,
   frame_init_mssfix(frame, options);
   frame_print (frame, D_MTU_INFO, "Data Channel MTU parms");
 
-  const struct session_id *client_sid = session->opt->server ?
-      &ks->session_id_remote : &session->session_id;
-  const struct session_id *server_sid = !session->opt->server ?
-      &ks->session_id_remote : &session->session_id;
-  if (!generate_key_expansion (&ks->crypto_options.key_ctx_bi,
-      &session->opt->key_type, ks->key_src, client_sid, server_sid,
-      session->opt->server))
-    {
-      msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
-      goto cleanup;
-    }
-  tls_limit_reneg_bytes (session->opt->key_type.cipher,
-			 &session->opt->renegotiate_bytes);
-  ret = true;
-cleanup:
-  CLEAR (*ks->key_src);
-  return ret;
+  return true;
 }
 
 static bool
@@ -2163,21 +2170,12 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
     {
       if (ks->authenticated)
 	{
-	  if (!generate_key_expansion (&ks->crypto_options.key_ctx_bi,
-				       &session->opt->key_type,
-				       ks->key_src,
-				       &ks->session_id_remote,
-				       &session->session_id,
-				       true))
+	  if (!tls_session_generate_data_channel_keys (session))
 	    {
 	      msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
 	      goto error;
 	    }
 	}
-		      
-      CLEAR (*ks->key_src);
-      tls_limit_reneg_bytes (session->opt->key_type.cipher,
-			     &session->opt->renegotiate_bytes);
     }
 
   return true;
@@ -2320,6 +2318,27 @@ key_method_2_read (struct buffer *buf, struct context *c, struct tls_session *se
       /* Peer does not support NCP */
       session->opt->ncp_enabled = false;
     }
+
+  /* "Poor man's NCP": Use client-cipher if it is an allowed (NCP) cipher.
+   * Allows non-NCP client to upgrade their cipher individually. */
+  char *remote_cipher = options_string_extract_option (options, "cipher", &gc);
+  if (c->options.ncp_enabled && !session->opt->ncp_enabled && remote_cipher &&
+      0 != strcmp(c->options.ciphername, remote_cipher))
+    {
+      if (tls_item_in_cipher_list(remote_cipher, c->options.ncp_ciphers))
+	{
+	  c->options.ciphername = string_alloc(remote_cipher, &c->options.gc);
+	  msg (D_TLS_DEBUG_LOW, "Using client cipher '%s'",
+	      c->options.ciphername);
+	  if (!tls_session_update_crypto_params (session, &c->options,
+	      &c->c2.frame))
+	    {
+	      msg (D_TLS_ERRORS, "TLS Error: failed to update crypto params");
+	      goto error;
+	    }
+	}
+    }
+
 #endif
 
   if (tls_session_user_pass_enabled(session))
@@ -2395,20 +2414,11 @@ key_method_2_read (struct buffer *buf, struct context *c, struct tls_session *se
    */
   if (!session->opt->server && (!session->opt->pull || ks->key_id > 0))
     {
-      if (!generate_key_expansion (&ks->crypto_options.key_ctx_bi,
-				   &session->opt->key_type,
-				   ks->key_src,
-				   &session->session_id,
-				   &ks->session_id_remote,
-				   false))
+      if (!tls_session_generate_data_channel_keys (session))
 	{
 	  msg (D_TLS_ERRORS, "TLS Error: client generate_key_expansion failed");
 	  goto error;
 	}
-
-      CLEAR (*ks->key_src);
-      tls_limit_reneg_bytes (session->opt->key_type.cipher,
-			     &session->opt->renegotiate_bytes);
     }
 
   gc_free (&gc);
diff --git a/src/openvpn/ssl.h b/src/openvpn/ssl.h
index 990d8da..f9bec37 100644
--- a/src/openvpn/ssl.h
+++ b/src/openvpn/ssl.h
@@ -472,8 +472,16 @@ void tls_update_remote_addr (struct tls_multi *multi,
 			     const struct link_socket_actual *addr);
 
 /**
- * Update TLS session crypto parameters (cipher and auth) and derive data
- * channel keys based on the supplied options.
+ * Generate data channel keys for the supplied TLS session.
+ *
+ * This erases the source material used to generate the data channel keys, and
+ * can thus be called only once per session.
+ */
+bool tls_session_generate_data_channel_keys(struct tls_session *session);
+
+/**
+ * Update TLS session crypto parameters (cipher and auth) and recalculate
+ * resulting frame sizes.
  *
  * @param session	The TLS session to update.
  * @param options	The options to use when updating session.
@@ -508,6 +516,13 @@ int tls_peer_info_ncp_ver(const char *peer_info);
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
-- 
2.7.4


