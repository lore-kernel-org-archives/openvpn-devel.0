From: Steffan Karger <steffan@...1856...>
Date: Sun,  7 Feb 2016 20:47:10 +0100
Message-Id: <1454874438-5081-3-git-send-email-steffan@...1856...>
In-Reply-To: <1454874438-5081-1-git-send-email-steffan@...1856...>
References: <1454874438-5081-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 02/10] Remove reuse of key_type during init
	of data channel auth and tls-auth
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

Prepare for using AEAD cipher modes + tls-auth, as tls-auth might want to
use an HMAC, while the data channel uses e.g. GCM tags.  This separates
the two initialisations.  Also, error out (and give a clear error message)
if a user specifies tls-auth but no valid auth algorithm, which makes no
sense at all.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c  |  9 ++-------
 src/openvpn/init.c    | 25 +++++++++++++++++++------
 src/openvpn/openvpn.h |  1 +
 3 files changed, 22 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c18d88b..806a995 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -751,13 +751,8 @@ get_tls_handshake_key (const struct key_type *key_type,
   if (passphrase_file && key_type->hmac_length)
     {
       struct key2 key2;
-      struct key_type kt = *key_type;
       struct key_direction_state kds;
 
-      /* for control channel we are only authenticating, not encrypting */
-      kt.cipher_length = 0;
-      kt.cipher = NULL;
-
       if (flags & GHK_INLINE)
 	{
 	  /* key was specified inline, key text is in passphrase_file */
@@ -800,9 +795,9 @@ get_tls_handshake_key (const struct key_type *key_type,
 
       /* initialize hmac key in both directions */
 
-      init_key_ctx (&ctx->encrypt, &key2.keys[kds.out_key], &kt, OPENVPN_OP_ENCRYPT,
+      init_key_ctx (&ctx->encrypt, &key2.keys[kds.out_key], key_type, OPENVPN_OP_ENCRYPT,
 		    "Outgoing Control Channel Authentication");
-      init_key_ctx (&ctx->decrypt, &key2.keys[kds.in_key], &kt, OPENVPN_OP_DECRYPT,
+      init_key_ctx (&ctx->decrypt, &key2.keys[kds.in_key], key_type, OPENVPN_OP_DECRYPT,
 		    "Incoming Control Channel Authentication");
 
       CLEAR (key2);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index d0020b7..7e6e448 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2206,11 +2206,23 @@ do_init_crypto_tls_c1 (struct context *c)
 	      flags |= GHK_INLINE;
 	      file = options->tls_auth_file_inline;
 	    }
-	  get_tls_handshake_key (&c->c1.ks.key_type,
-				 &c->c1.ks.tls_auth_key,
-				 file,
-				 options->key_direction,
-				 flags);
+
+	  /* Initialize key_type for tls-auth with auth only */
+	  CLEAR (c->c1.ks.tls_auth_key_type);
+	  if (options->authname && options->authname_defined)
+	    {
+	      c->c1.ks.tls_auth_key_type.digest = md_kt_get (options->authname);
+	      c->c1.ks.tls_auth_key_type.hmac_length =
+		  md_kt_size (c->c1.ks.tls_auth_key_type.digest);
+	    }
+	  else
+	    {
+	      msg (M_FATAL, "ERROR: tls-auth enabled, but no valid --auth "
+		  "algorithm specified ('%s')", options->authname);
+	    }
+
+	  get_tls_handshake_key (&c->c1.ks.tls_auth_key_type,
+	      &c->c1.ks.tls_auth_key, file, options->key_direction, flags);
 	}
 
 #if 0 /* was: #if ENABLE_INLINE_FILES --  Note that enabling this code will break restarts */
@@ -2375,7 +2387,7 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
       to.tls_auth.pid_persist = &c->c1.pid_persist;
       to.tls_auth.flags |= CO_PACKET_ID_LONG_FORM;
       crypto_adjust_frame_parameters (&to.frame,
-				      &c->c1.ks.key_type,
+				      &c->c1.ks.tls_auth_key_type,
 				      false, false, true, true);
     }
 
@@ -3758,6 +3770,7 @@ inherit_context_child (struct context *dest,
   /* inherit SSL context */
   dest->c1.ks.ssl_ctx = src->c1.ks.ssl_ctx;
   dest->c1.ks.tls_auth_key = src->c1.ks.tls_auth_key;
+  dest->c1.ks.tls_auth_key_type = src->c1.ks.tls_auth_key_type;
 #endif
 
   /* options */
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 3f1df6e..71adf48 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -66,6 +66,7 @@ struct key_schedule
   struct tls_root_ctx ssl_ctx;
 
   /* optional authentication HMAC key for TLS control channel */
+  struct key_type tls_auth_key_type;
   struct key_ctx_bi tls_auth_key;
 #else				/* ENABLE_CRYPTO */
   int dummy;
-- 
2.5.0


