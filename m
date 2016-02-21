From: Steffan Karger <steffan@...1856...>
Date: Sun, 21 Feb 2016 02:08:12 +0100
Message-Id: <1456016892-8671-2-git-send-email-steffan@...1856...>
In-Reply-To: <1456016892-8671-1-git-send-email-steffan@...1856...>
References: <1456016892-8671-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 2/2] Clean up get_tls_handhake_key()
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

This function contained *much* more code than required.  This commit
cleans up the function:
 * Merge the handling of inline and non-inline code.
 * Don't double-check key.2, must_have_n_keys() already checks that
 * Remove stale references to 'passphrase' - we no longer support those

This commit should not change any behaviour except for log messages.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c | 44 ++++++++------------------------------------
 1 file changed, 8 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 6d9c119..308b886 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1080,57 +1080,29 @@ test_crypto (struct crypto_options *co, struct frame* frame)
 void
 get_tls_handshake_key (const struct key_type *key_type,
 		       struct key_ctx_bi *ctx,
-		       const char *passphrase_file,
+		       const char *key_file,
 		       const int key_direction,
 		       const unsigned int flags)
 {
-  if (passphrase_file && key_type->hmac_length)
+  if (key_file)
     {
       struct key2 key2;
       struct key_direction_state kds;
 
       if (flags & GHK_INLINE)
 	{
-	  /* key was specified inline, key text is in passphrase_file */
-	  read_key_file (&key2, passphrase_file, RKF_INLINE|RKF_MUST_SUCCEED);
-
-	  /* succeeded? */
-	  if (key2.n == 2)
-	    msg (M_INFO, "Control Channel Authentication: tls-auth using INLINE static key file");
-	  else
-	    msg (M_FATAL, "INLINE tls-auth file lacks the requisite 2 keys");
+	  read_key_file (&key2, key_file, RKF_INLINE|RKF_MUST_SUCCEED);
 	}
       else
-      {
-	/* first try to parse as an OpenVPN static key file */
-	read_key_file (&key2, passphrase_file, 0);
-
-	/* succeeded? */
-	if (key2.n == 2)
-	  {
-	    msg (M_INFO,
-		 "Control Channel Authentication: using '%s' as a " PACKAGE_NAME " static key file",
-		 passphrase_file);
-	  }
-	else
-	  {
-	    CLEAR (key2);
-
-	    /* failed, now bail out */
+	{
+	  read_key_file (&key2, key_file, RKF_MUST_SUCCEED);
+	}
 
-	    msg (M_ERR,
-		 "Control Channel Authentication: File '%s' does not have OpenVPN Static Key format. "
-		 "Using free-form passphrase file is not supported anymore",
-		 passphrase_file);
-	  }
-      }
       /* handle key direction */
-
       key_direction_state_init (&kds, key_direction);
-      must_have_n_keys (passphrase_file, "tls-auth", &key2, kds.need_keys);
-
-      /* initialize hmac key in both directions */
+      must_have_n_keys (key_file, "tls-auth", &key2, kds.need_keys);
 
+      /* initialize key in both directions */
       init_key_ctx (&ctx->encrypt, &key2.keys[kds.out_key], key_type, OPENVPN_OP_ENCRYPT,
 		    "Outgoing Control Channel Authentication");
       init_key_ctx (&ctx->decrypt, &key2.keys[kds.in_key], key_type, OPENVPN_OP_DECRYPT,
-- 
2.5.0


