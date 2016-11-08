From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 8 Nov 2016 21:18:18 +0100
Message-ID: <1478636302-9678-2-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/5] Refactor static/tls-auth key loading
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

Remove duplicate code, in preparation for adding --tls-crypt, which
otherwise would have to duplicate this code again.

This should be equivalent to the old code, except for two things:
* The log lines for static key initialization change slightly, from
  "Static Encrypt/Decrypt" to "Incoming/Outgoing Static Key Encryption"
* We also 'check and fix highly unlikely key problems' for tls-auth
  keys (boils down to a sanity-check for an all-zero key).

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto.c | 69 +++++++++++++++++++++++++---------------------------
 src/openvpn/crypto.h |  9 +++----
 src/openvpn/init.c   | 47 +++++++----------------------------
 3 files changed, 45 insertions(+), 80 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 0212450..749b7da 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1103,48 +1103,45 @@ test_crypto (struct crypto_options *co, struct frame* frame)
 }
 
 void
-get_tls_handshake_key (const struct key_type *key_type,
-		       struct key_ctx_bi *ctx,
-		       const char *key_file,
-		       const int key_direction,
-		       const unsigned int flags)
+crypto_read_openvpn_key (const struct key_type *key_type,
+	struct key_ctx_bi *ctx, const char *key_file, const char *key_inline,
+	const int key_direction, const char *key_name, const char *opt_name)
 {
-  if (key_file)
-    {
-      struct key2 key2;
-      struct key_direction_state kds;
-
-      if (flags & GHK_INLINE)
-	{
-	  read_key_file (&key2, key_file, RKF_INLINE|RKF_MUST_SUCCEED);
-	}
-      else
-	{
-	  read_key_file (&key2, key_file, RKF_MUST_SUCCEED);
-	}
-
-	if (key2.n != 2)
-	  {
-	    msg (M_ERR, "Control Channel Authentication: File '%s' does not "
-		"have OpenVPN Static Key format.  Using free-form passphrase "
-		"file is not supported anymore.", key_file);
-	  }
-      /* handle key direction */
-      key_direction_state_init (&kds, key_direction);
-      must_have_n_keys (key_file, "tls-auth", &key2, kds.need_keys);
+  struct key2 key2;
+  struct key_direction_state kds;
+  char log_prefix[128] = { 0 };
 
-      /* initialize key in both directions */
-      init_key_ctx (&ctx->encrypt, &key2.keys[kds.out_key], key_type, OPENVPN_OP_ENCRYPT,
-		    "Outgoing Control Channel Authentication");
-      init_key_ctx (&ctx->decrypt, &key2.keys[kds.in_key], key_type, OPENVPN_OP_DECRYPT,
-		    "Incoming Control Channel Authentication");
-
-      CLEAR (key2);
+  if (key_inline)
+    {
+      read_key_file (&key2, key_inline, RKF_MUST_SUCCEED|RKF_INLINE);
     }
   else
     {
-      CLEAR (*ctx);
+      read_key_file (&key2, key_file, RKF_MUST_SUCCEED);
+    }
+
+  if (key2.n != 2)
+    {
+      msg (M_ERR, "File '%s' does not have OpenVPN Static Key format.  Using "
+	   "free-form passphrase file is not supported anymore.", key_file);
     }
+
+  /* check for and fix highly unlikely key problems */
+  verify_fix_key2 (&key2, key_type, key_file);
+
+  /* handle key direction */
+  key_direction_state_init (&kds, key_direction);
+  must_have_n_keys (key_file, opt_name, &key2, kds.need_keys);
+
+  /* initialize key in both directions */
+  openvpn_snprintf (log_prefix, sizeof (log_prefix), "Outgoing %s", key_name);
+  init_key_ctx (&ctx->encrypt, &key2.keys[kds.out_key], key_type,
+		OPENVPN_OP_ENCRYPT, log_prefix);
+  openvpn_snprintf (log_prefix, sizeof (log_prefix), "Incoming %s", key_name);
+  init_key_ctx (&ctx->decrypt, &key2.keys[kds.in_key], key_type,
+		OPENVPN_OP_DECRYPT, log_prefix);
+
+  CLEAR (key2);
 }
 
 /* header and footer for static key file */
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 4b90c67..bc9630a 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -465,12 +465,9 @@ void key2_print (const struct key2* k,
 		 const char* prefix0,
 		 const char* prefix1);
 
-#define GHK_INLINE  (1<<0)
-void get_tls_handshake_key (const struct key_type *key_type,
-			    struct key_ctx_bi *ctx,
-			    const char *passphrase_file,
-			    const int key_direction,
-			    const unsigned int flags);
+void crypto_read_openvpn_key (const struct key_type *key_type,
+	struct key_ctx_bi *ctx, const char *key_file, const char *key_inline,
+	const int key_direction, const char *key_name, const char *opt_name);
 
 /*
  * Inline functions
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 91c53f5..1a9340c 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2147,33 +2147,11 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
 		     options->keysize, options->test_crypto, true);
 
       /* Read cipher and hmac keys from shared secret file */
-      {
-	unsigned int rkf_flags = RKF_MUST_SUCCEED;
-	const char *rkf_file = options->shared_secret_file;
-
-	if (options->shared_secret_file_inline)
-	  {
-	    rkf_file = options->shared_secret_file_inline;
-	    rkf_flags |= RKF_INLINE;
-	  }
-	read_key_file (&key2, rkf_file, rkf_flags);
-      }
-
-      /* Check for and fix highly unlikely key problems */
-      verify_fix_key2 (&key2, &c->c1.ks.key_type,
-		       options->shared_secret_file);
-
-      /* Initialize OpenSSL key objects */
-      key_direction_state_init (&kds, options->key_direction);
-      must_have_n_keys (options->shared_secret_file, "secret", &key2,
-			kds.need_keys);
-      init_key_ctx (&c->c1.ks.static_key.encrypt, &key2.keys[kds.out_key],
-		    &c->c1.ks.key_type, OPENVPN_OP_ENCRYPT, "Static Encrypt");
-      init_key_ctx (&c->c1.ks.static_key.decrypt, &key2.keys[kds.in_key],
-		    &c->c1.ks.key_type, OPENVPN_OP_DECRYPT, "Static Decrypt");
-
-      /* Erase the temporary copy of key */
-      CLEAR (key2);
+      crypto_read_openvpn_key (&c->c1.ks.key_type, &c->c1.ks.static_key,
+			       options->shared_secret_file,
+			       options->shared_secret_file_inline,
+			       options->key_direction, "Static Key Encryption",
+			       "secret");
     }
   else
     {
@@ -2242,15 +2220,6 @@ do_init_crypto_tls_c1 (struct context *c)
       /* TLS handshake authentication (--tls-auth) */
       if (options->tls_auth_file)
 	{
-	  unsigned int flags = 0;
-	  const char *file = options->tls_auth_file;
-
-	  if (options->tls_auth_file_inline)
-	    {
-	      flags |= GHK_INLINE;
-	      file = options->tls_auth_file_inline;
-	    }
-
 	  /* Initialize key_type for tls-auth with auth only */
 	  CLEAR (c->c1.ks.tls_auth_key_type);
 	  if (!streq (options->authname, "none"))
@@ -2265,8 +2234,10 @@ do_init_crypto_tls_c1 (struct context *c)
 		  "algorithm specified ('%s')", options->authname);
 	    }
 
-	  get_tls_handshake_key (&c->c1.ks.tls_auth_key_type,
-	      &c->c1.ks.tls_auth_key, file, options->key_direction, flags);
+	  crypto_read_openvpn_key (&c->c1.ks.tls_auth_key_type,
+	      &c->c1.ks.tls_auth_key, options->tls_auth_file,
+	      options->tls_auth_file_inline, options->key_direction,
+	      "Control Channel Authentication", "tls-auth");
 	}
 
       c->c1.ciphername = options->ciphername;
-- 
2.7.4


