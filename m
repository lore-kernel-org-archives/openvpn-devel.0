From: Steffan Karger <steffan@...1856...>
Date: Sun,  6 Mar 2016 13:09:50 +0100
Message-Id: <1457266190-27228-1-git-send-email-steffan@...1856...>
In-Reply-To: <201603060941.u269fwCY045984@...2054...>
References: <201603060941.u269fwCY045984@...2054...>
Subject: [Openvpn-devel] [PATCH] Only include aead encrypt/decrypt functions
	if AEAD modes are supported
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

This fixes the build for OpenSSL < 1.0.1 (broken by commit 3654d953),
which has no AEAD support.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 269ec4b..f15ac35 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -86,6 +86,7 @@ memcmp_constant_time (const void *a, const void *b, size_t size) {
 static void
 openvpn_encrypt_aead (struct buffer *buf, struct buffer work,
 	 struct crypto_options *opt) {
+#ifdef HAVE_AEAD_CIPHER_MODES
   struct gc_arena gc;
   int outlen = 0;
   const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
@@ -173,6 +174,9 @@ err:
   crypto_clear_error();
   buf->len = 0;
   goto cleanup;
+#else /* HAVE_AEAD_CIPHER_MODES */
+  ASSERT (0);
+#endif
 }
 
 static void
@@ -385,6 +389,7 @@ openvpn_decrypt_aead (struct buffer *buf, struct buffer work,
     struct crypto_options *opt, const struct frame* frame,
     const uint8_t *ad_start)
 {
+#ifdef HAVE_AEAD_CIPHER_MODES
   static const char error_prefix[] = "AEAD Decrypt error";
   struct packet_id_net pin = { 0 };
   const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
@@ -511,6 +516,10 @@ openvpn_decrypt_aead (struct buffer *buf, struct buffer work,
   buf->len = 0;
   gc_free (&gc);
   return false;
+#else /* HAVE_AEAD_CIPHER_MODES */
+  ASSERT (0);
+  return false;
+#endif
 }
 
 /*
-- 
2.5.0


