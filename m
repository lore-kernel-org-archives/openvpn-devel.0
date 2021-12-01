From: Arne Schwabe <arne@...1227...>
Date: Wed,  1 Dec 2021 19:07:20 +0100
Message-Id: <20211201180727.2496903-2-arne@...1227...>
In-Reply-To: <20211201180727.2496903-1-arne@...1227...>
References: <20211201180727.2496903-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/9] Directly use hardcoed
 OPENVPN_TAG_LENGTH instead lookup
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

We always use the same tag size for all AEAED cipher, so instead
of doing a lookup, always use the same tag size.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/crypto.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 251decdc5..270d83c56 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -69,7 +69,7 @@ openvpn_encrypt_aead(struct buffer *buf, struct buffer work,
     const struct key_ctx *ctx = &opt->key_ctx_bi.encrypt;
     uint8_t *mac_out = NULL;
     const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
-    const int mac_len = cipher_kt_tag_size(cipher_kt);
+    const int mac_len = OPENVPN_AEAD_TAG_LENGTH;
 
     /* IV, packet-ID and implicit IV required for this mode. */
     ASSERT(ctx->cipher);
@@ -362,7 +362,6 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
     const struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
     const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt(ctx->cipher);
     uint8_t *tag_ptr = NULL;
-    int tag_size = 0;
     int outlen;
     struct gc_arena gc;
 
@@ -415,7 +414,7 @@ openvpn_decrypt_aead(struct buffer *buf, struct buffer work,
     }
 
     /* keep the tag value to feed in later */
-    tag_size = cipher_kt_tag_size(cipher_kt);
+    const int tag_size = OPENVPN_AEAD_TAG_LENGTH;
     if (buf->len < tag_size)
     {
         CRYPT_ERROR("missing tag");
-- 
2.33.0


