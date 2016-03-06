From: Steffan Karger <steffan@...1856...>
Date: Sun,  6 Mar 2016 10:31:55 +0100
Message-Id: <1457256715-4467-1-git-send-email-steffan@...1856...>
In-Reply-To: <201602152005.u1FK527j004287@...2054...>
References: <201602152005.u1FK527j004287@...2054...>
Subject: [Openvpn-devel] [PATCH] Make AEAD modes work with OpenSSL
	1.0.1-1.0.1c
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

The 'nobody uses OpenSSL 1.0.1-1.0.1c'-gamble in commit 66407e11 (add AEAD
support) did not turn out well; apparently Ubuntu 12.04 LTS ships with a
broken OpenSSL 1.0.1.  Since this is still a popular platform, re-add the
fixup code, now with a clear version check so it's easy to remove once we
drop support for OpenSSL 1.0.1.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index bd86679..269ec4b 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -450,6 +450,13 @@ openvpn_decrypt_aead (struct buffer *buf, struct buffer work,
   tag_ptr = BPTR(buf);
   ASSERT (buf_advance (buf, tag_size));
   dmsg (D_PACKET_CONTENT, "DECRYPT MAC: %s", format_hex (tag_ptr, tag_size, 0, &gc));
+#if defined(ENABLE_CRYPTO_OPENSSL) && OPENSSL_VERSION_NUMBER < 0x10001040L
+  /* OpenSSL <= 1.0.1c bug requires set tag before processing ciphertext */
+  if (!EVP_CIPHER_CTX_ctrl (ctx->cipher, EVP_CTRL_GCM_SET_TAG, tag_size, tag_ptr))
+    {
+      CRYPT_ERROR ("setting tag failed");
+    }
+#endif
 
   if (buf->len < 1)
     {
-- 
2.5.0


