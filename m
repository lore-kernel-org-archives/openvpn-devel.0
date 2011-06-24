From: Adriaan de Jong <dejong@...1435...>
Date: Fri, 24 Jun 2011 11:54:56 +0200
Message-ID: <1308909312-17824-4-git-send-email-dejong@...1435...>
In-Reply-To: <1308909312-17824-1-git-send-email-dejong@...1435...>
References: <1308909312-17824-1-git-send-email-dejong@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 12/28] Refactored OpenSSL-specific constants
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

---
 crypto.c         |   28 ++++++++++++++--------------
 crypto.h         |    7 ++++---
 crypto_openssl.h |   18 ++++++++++++++++++
 init.c           |    4 ++--
 ssl.c            |    8 ++++----
 5 files changed, 42 insertions(+), 23 deletions(-)

diff --git a/crypto.c b/crypto.c
index 68b8564..8af5b7a 100644
--- a/crypto.c
+++ b/crypto.c
@@ -86,12 +86,12 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
       /* Do Encrypt from buf -> work */
       if (ctx->cipher)
 	{
-	  uint8_t iv_buf[EVP_MAX_IV_LENGTH];
+	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH];
 	  const int iv_size = EVP_CIPHER_CTX_iv_length (ctx->cipher);
 	  const unsigned int mode = EVP_CIPHER_CTX_mode (ctx->cipher);  
 	  int outlen;
 
-	  if (mode == EVP_CIPH_CBC_MODE)
+	  if (mode == OPENVPN_MODE_CBC)
 	    {
 	      CLEAR (iv_buf);
 
@@ -107,7 +107,7 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 		  ASSERT (packet_id_write (&pin, buf, BOOL_CAST (opt->flags & CO_PACKET_ID_LONG_FORM), true));
 		}
 	    }
-	  else if (mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE)
+	  else if (mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB)
 	    {
 	      struct packet_id_net pin;
 	      struct buffer b;
@@ -267,7 +267,7 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 	{
 	  const unsigned int mode = EVP_CIPHER_CTX_mode (ctx->cipher);
 	  const int iv_size = EVP_CIPHER_CTX_iv_length (ctx->cipher);
-	  uint8_t iv_buf[EVP_MAX_IV_LENGTH];
+	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH];
 	  int outlen;
 
 	  /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
@@ -313,7 +313,7 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 
 	  /* Get packet ID from plaintext buffer or IV, depending on cipher mode */
 	  {
-	    if (mode == EVP_CIPH_CBC_MODE)
+	    if (mode == OPENVPN_MODE_CBC)
 	      {
 		if (opt->packet_id)
 		  {
@@ -322,7 +322,7 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
 		    have_pin = true;
 		  }
 	      }
-	    else if (mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE)
+	    else if (mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB)
 	      {
 		struct buffer b;
 
@@ -512,9 +512,9 @@ init_key_type (struct key_type *kt, const char *ciphername,
       /* check legal cipher mode */
       {
 	const unsigned int mode = EVP_CIPHER_mode (kt->cipher);
-	if (!(mode == EVP_CIPH_CBC_MODE
+	if (!(mode == OPENVPN_MODE_CBC
 #ifdef ALLOW_NON_CBC_CIPHERS
-	      || (cfb_ofb_allowed && (mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE))
+	      || (cfb_ofb_allowed && (mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB))
 #endif
 	      ))
 #ifdef ENABLE_SMALL
@@ -775,11 +775,11 @@ check_replay_iv_consistency (const struct key_type *kt, bool packet_id, bool use
 bool
 cfb_ofb_mode (const struct key_type* kt)
 {
-  if (kt->cipher) {
     const unsigned int mode = EVP_CIPHER_mode (kt->cipher);
-    return mode == EVP_CIPH_CFB_MODE || mode == EVP_CIPH_OFB_MODE;
-  } else
-    return false;
+  if (kt && kt->cipher) {
+      return mode == OPENVPN_MODE_CFB || mode == OPENVPN_MODE_OFB;
+  }
+  return false;
 }
 
 /*
@@ -970,9 +970,9 @@ get_tls_handshake_key (const struct key_type *key_type,
 
       /* initialize hmac key in both directions */
 
-      init_key_ctx (&ctx->encrypt, &key2.keys[kds.out_key], &kt, DO_ENCRYPT,
+      init_key_ctx (&ctx->encrypt, &key2.keys[kds.out_key], &kt, OPENVPN_OP_ENCRYPT,
 		    "Outgoing Control Channel Authentication");
-      init_key_ctx (&ctx->decrypt, &key2.keys[kds.in_key], &kt, DO_DECRYPT,
+      init_key_ctx (&ctx->decrypt, &key2.keys[kds.in_key], &kt, OPENVPN_OP_DECRYPT,
 		    "Incoming Control Channel Authentication");
 
       CLEAR (key2);
diff --git a/crypto.h b/crypto.h
index 973677d..f56456d 100644
--- a/crypto.h
+++ b/crypto.h
@@ -6,6 +6,7 @@
  *             packet compression.
  *
  *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2010 Fox Crypto B.V. <openvpn@...1435...>
  *
  *  This program is free software; you can redistribute it and/or modify
  *  it under the terms of the GNU General Public License version 2
@@ -22,14 +23,13 @@
  *  59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  */
 
-
 /**
- * @file
+ * @file Data Channel Cryptography Module
  */
 
-
 #ifndef CRYPTO_H
 #define CRYPTO_H
+
 #ifdef USE_CRYPTO
 
 #define ALLOW_NON_CBC_CIPHERS
@@ -63,6 +63,7 @@
 #include <openssl/des_old.h>
 #endif
 
+#include "crypto_backend.h"
 #include "basic.h"
 #include "buffer.h"
 #include "packet_id.h"
diff --git a/crypto_openssl.h b/crypto_openssl.h
index cae00b9..ea3601e 100644
--- a/crypto_openssl.h
+++ b/crypto_openssl.h
@@ -34,4 +34,22 @@
 #include <openssl/hmac.h>
 #include <openssl/md5.h>
 
+/** Maximum length of an IV */
+#define OPENVPN_MAX_IV_LENGTH 	EVP_MAX_IV_LENGTH
+
+/** Cipher is in CBC mode */
+#define OPENVPN_MODE_CBC 	EVP_CIPH_CBC_MODE
+
+/** Cipher is in OFB mode */
+#define OPENVPN_MODE_OFB	EVP_CIPH_OFB_MODE
+
+/** Cipher is in CFB mode */
+#define OPENVPN_MODE_CFB 	EVP_CIPH_CFB_MODE
+
+/** Cipher should encrypt */
+#define OPENVPN_OP_ENCRYPT 	1
+
+/** Cipher should decrypt */
+#define OPENVPN_OP_DECRYPT 	0
+
 #endif /* CRYPTO_OPENSSL_H_ */
diff --git a/init.c b/init.c
index cb8dc42..972b093 100644
--- a/init.c
+++ b/init.c
@@ -1942,9 +1942,9 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
       must_have_n_keys (options->shared_secret_file, "secret", &key2,
 			kds.need_keys);
       init_key_ctx (&c->c1.ks.static_key.encrypt, &key2.keys[kds.out_key],
-		    &c->c1.ks.key_type, DO_ENCRYPT, "Static Encrypt");
+		    &c->c1.ks.key_type, OPENVPN_OP_ENCRYPT, "Static Encrypt");
       init_key_ctx (&c->c1.ks.static_key.decrypt, &key2.keys[kds.in_key],
-		    &c->c1.ks.key_type, DO_DECRYPT, "Static Decrypt");
+		    &c->c1.ks.key_type, OPENVPN_OP_DECRYPT, "Static Decrypt");
 
       /* Erase the temporary copy of key */
       CLEAR (key2);
diff --git a/ssl.c b/ssl.c
index 4477b54..d0fd77b 100644
--- a/ssl.c
+++ b/ssl.c
@@ -3860,13 +3860,13 @@ generate_key_expansion (struct key_ctx_bi *key,
   init_key_ctx (&key->encrypt,
 		&key2.keys[(int)server],
 		key_type,
-		DO_ENCRYPT,
+		OPENVPN_OP_ENCRYPT,
 		"Data Channel Encrypt");
 
   init_key_ctx (&key->decrypt,
 		&key2.keys[1-(int)server],
 		key_type,
-		DO_DECRYPT,
+		OPENVPN_OP_DECRYPT,
 		"Data Channel Decrypt");
 
   ret = true;
@@ -4234,7 +4234,7 @@ key_method_1_write (struct buffer *buf, struct tls_session *session)
     }
 
   init_key_ctx (&ks->key.encrypt, &key, &session->opt->key_type,
-		DO_ENCRYPT, "Data Channel Encrypt");
+      OPENVPN_OP_ENCRYPT, "Data Channel Encrypt");
   CLEAR (key);
 
   /* send local options string */
@@ -4446,7 +4446,7 @@ key_method_1_read (struct buffer *buf, struct tls_session *session)
   buf_clear (buf);
 
   init_key_ctx (&ks->key.decrypt, &key, &session->opt->key_type,
-		DO_DECRYPT, "Data Channel Decrypt");
+      OPENVPN_OP_DECRYPT, "Data Channel Decrypt");
   CLEAR (key);
   ks->authenticated = true;
   return true;
-- 
1.7.4.1


