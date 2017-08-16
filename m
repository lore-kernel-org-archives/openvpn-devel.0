From: Steffan Karger <steffan@...1856...>
Date: Wed, 16 Aug 2017 19:04:50 +0200
Message-Id: <20170816170450.10415-1-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] tls-crypt: don't leak memory for incorrect
 tls-crypt messages
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

If tls_crypt_unwrap() failed, we would jump to cleanup and forget to free
the buffer.  Instead, allocate the buffer through gc, which is free'd in
the cleanup section.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/ssl.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 2a476800..806172ea 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1534,7 +1534,7 @@ read_control_auth(struct buffer *buf,
     }
     else if (ctx->mode == TLS_WRAP_CRYPT)
     {
-        struct buffer tmp = alloc_buf(buf_forward_capacity_total(buf));
+        struct buffer tmp = alloc_buf_gc(buf_forward_capacity_total(buf), &gc);
         if (!tls_crypt_unwrap(buf, &tmp, &ctx->opt))
         {
             msg(D_TLS_ERRORS, "TLS Error: tls-crypt unwrapping failed from %s",
@@ -1543,7 +1543,7 @@ read_control_auth(struct buffer *buf,
         }
         ASSERT(buf_init(buf, buf->offset));
         ASSERT(buf_copy(buf, &tmp));
-        free_buf(&tmp);
+        buf_clear(&tmp);
     }
 
     if (ctx->mode == TLS_WRAP_NONE || ctx->mode == TLS_WRAP_AUTH)
-- 
2.11.0


