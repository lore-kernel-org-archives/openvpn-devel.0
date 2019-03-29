From: Arne Schwabe <arne@...1227...>
Date: Fri, 29 Mar 2019 13:27:24 +0100
Message-Id: <20190329122724.24169-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Warn about insecure ciphers also in
 init_key_type
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

With modern Clients and server initialising the crypto cipher later
and not when reading in the config, most users never the warning when
having selected BF-CBC in the configuration.

This patch adds the logic to print out warning to init_key_type.

Main reason for this patch is a personal experience with someone who was
strictly against putting 'cipher' into a config file because he did not
like hardcoding a cipher and "OpenVPN will do AES-GCM anyway" and thinks
that it is better to not have it in configuration even after told by me
that 15 year defaults might not be good anymore.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c | 27 +++++++++++++++++++--------
 1 file changed, 19 insertions(+), 8 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ff9dbfdc..8a92a8c1 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -736,6 +736,17 @@ crypto_max_overhead(void)
            +max_int(OPENVPN_MAX_HMAC_SIZE, OPENVPN_AEAD_TAG_LENGTH);
 }
 
+static void warn_insecure_key_type(const char* ciphername, const cipher_kt_t *cipher)
+{
+    if (cipher_kt_insecure(cipher))
+    {
+        msg(M_WARN, "WARNING: INSECURE cipher (%s) with block size less than 128"
+                    " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
+                    "using a --cipher with a larger block size (e.g. AES-256-CBC).",
+            ciphername, cipher_kt_block_size(cipher)*8);
+    }
+}
+
 /*
  * Build a struct key_type.
  */
@@ -763,6 +774,7 @@ init_key_type(struct key_type *kt, const char *ciphername,
             kt->cipher_length = keysize;
         }
 
+
         /* check legal cipher mode */
         aead_cipher = cipher_kt_mode_aead(kt->cipher);
         if (!(cipher_kt_mode_cbc(kt->cipher)
@@ -779,6 +791,10 @@ init_key_type(struct key_type *kt, const char *ciphername,
         {
             msg(M_FATAL, "Cipher '%s' not allowed: block size too big.", ciphername);
         }
+        if(warn)
+        {
+            warn_insecure_key_type(ciphername, kt->cipher);
+        }
     }
     else
     {
@@ -831,9 +847,10 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
         cipher_ctx_init(ctx->cipher, key->cipher, kt->cipher_length,
                         kt->cipher, enc);
 
+        const char* ciphername = translate_cipher_name_to_openvpn(cipher_kt_name(kt->cipher));
         msg(D_HANDSHAKE, "%s: Cipher '%s' initialized with %d bit key",
             prefix,
-            translate_cipher_name_to_openvpn(cipher_kt_name(kt->cipher)),
+            ciphername,
             kt->cipher_length *8);
 
         dmsg(D_SHOW_KEYS, "%s: CIPHER KEY: %s", prefix,
@@ -841,13 +858,7 @@ init_key_ctx(struct key_ctx *ctx, const struct key *key,
         dmsg(D_CRYPTO_DEBUG, "%s: CIPHER block_size=%d iv_size=%d",
              prefix, cipher_kt_block_size(kt->cipher),
              cipher_kt_iv_size(kt->cipher));
-        if (cipher_kt_insecure(kt->cipher))
-        {
-            msg(M_WARN, "WARNING: INSECURE cipher with block size less than 128"
-                " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
-                "using a --cipher with a larger block size (e.g. AES-256-CBC).",
-                cipher_kt_block_size(kt->cipher)*8);
-        }
+        warn_insecure_key_type(ciphername, kt->cipher);
     }
     if (kt->digest && kt->hmac_length > 0)
     {
-- 
2.21.0


