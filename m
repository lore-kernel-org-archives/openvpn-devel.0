From: Steffan Karger <steffan@...1856...>
Date: Sun, 21 Feb 2016 02:08:11 +0100
Message-Id: <1456016892-8671-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH 1/2] Minor AEAD patch cleanup
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

 * Remove stale function declaration.
   This slipped into the AEAD cipher modes patch, but the function is
   now implemented as a static function is ssl.c.
 * Add ASSERT() to ensure frame is not NULL.
 * Fix "ENCRYPT TO" log message in openvpn_encrypt_aead().

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c |  5 +++--
 src/openvpn/crypto.h | 11 -----------
 2 files changed, 3 insertions(+), 13 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index e8ab27a..6d9c119 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -161,10 +161,10 @@ openvpn_encrypt_aead (struct buffer *buf, struct buffer work,
   /* Write authentication tag */
   ASSERT (cipher_ctx_get_tag (ctx->cipher, mac_out, mac_len));
 
-  dmsg (D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex (BPTR (buf), BLEN (buf), 80, &gc));
-
   *buf = work;
 
+  dmsg (D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex (BPTR (buf), BLEN (buf), 80, &gc));
+
 cleanup:
   gc_free (&gc);
   return;
@@ -397,6 +397,7 @@ openvpn_decrypt_aead (struct buffer *buf, struct buffer work,
   gc_init (&gc);
 
   ASSERT (opt);
+  ASSERT (frame);
   ASSERT (buf->len > 0);
   ASSERT (ctx->cipher);
   ASSERT (cipher_kt_mode_aead (cipher_kt));
diff --git a/src/openvpn/crypto.h b/src/openvpn/crypto.h
index 14b6ab7..d3e08c1 100644
--- a/src/openvpn/crypto.h
+++ b/src/openvpn/crypto.h
@@ -311,17 +311,6 @@ void free_key_ctx (struct key_ctx *ctx);
 
 void free_key_ctx_bi (struct key_ctx_bi *ctx);
 
-/**
- * Set an implicit IV for a key context.
- *
- * @param ctx	The key context to update
- * @param iv	The implicit IV to load into ctx
- * @param len	The length (in bytes) of iv
- */
-bool key_ctx_set_implicit_iv (struct key_ctx *ctx, const uint8_t *iv,
-    size_t len);
-
-
 
 /**************************************************************************/
 /** @name Functions for performing security operations on data channel packets
-- 
2.5.0


