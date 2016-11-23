From: Steffan Karger <steffan@...1856...>
Date: Wed, 23 Nov 2016 21:02:05 +0100
Message-Id: <1479931325-25919-2-git-send-email-steffan@...1856...>
In-Reply-To: <1479931325-25919-1-git-send-email-steffan@...1856...>
References: <20161122211835.GJ28918@...1296...>
	<1479931325-25919-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] Refactor data channel key generation API
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

Originally for "poor man's NPC", I introduced a simpler API for generating
data channel keys.  That refactoring is no longer needed for that patch,
but I believe still worth a patch on it's own.

This patch should not change any functionality.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c | 75 ++++++++++++++++++++++++++-----------------------------
 1 file changed, 35 insertions(+), 40 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4e84a71..7eed231 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1757,15 +1757,44 @@ tls_poor_mans_ncp(struct options *o, const char *remote_ciphername)
     }
 }
 
-bool
-tls_session_update_crypto_params(struct tls_session *session,
-    const struct options *options, struct frame *frame)
+/**
+ * Generate data channel keys for the supplied TLS session.
+ *
+ * This erases the source material used to generate the data channel keys, and
+ * can thus be called only once per session.
+ */
+static bool
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
+			 &session->opt->renegotiate_bytes);
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
       !tls_item_in_cipher_list(options->ciphername, options->ncp_ciphers))
@@ -1793,23 +1822,7 @@ tls_session_update_crypto_params(struct tls_session *session,
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
+  return tls_session_generate_data_channel_keys (session);
 }
 
 static bool
@@ -2176,21 +2189,12 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
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
@@ -2405,20 +2409,11 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
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
-- 
2.7.4


