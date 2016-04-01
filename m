From: Steffan Karger <steffan@...1856...>
Date: Fri,  1 Apr 2016 18:43:00 +0200
Message-Id: <1459528980-8304-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH] Fix potential null-pointer dereference
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

Commit a070f75b (master branch only) changed the openvpn_encrypt logic and
now prepends the contents of the work buffer to buf if no encryption is
used (which is the case for tls-auth packets).  In that case, the code
would potentially dereference a null-pointer in a memcpy(some-dest, 0, 0)
call.  Fortunately, memcpy() inplementations usually do not actually
derefence the src (or dst) pointer for zero-length copies.

And since I'm touching this code now anyway, remove a slightly confusing
jump back to a cleanup label in openvpn_encrypt_aead().

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/crypto.c | 8 +++++---
 1 file changed, 5 insertions(+), 3 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index f15ac35..5c392aa 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -166,14 +166,14 @@ openvpn_encrypt_aead (struct buffer *buf, struct buffer work,
 
   dmsg (D_PACKET_CONTENT, "ENCRYPT TO: %s", format_hex (BPTR (buf), BLEN (buf), 80, &gc));
 
-cleanup:
   gc_free (&gc);
   return;
 
 err:
   crypto_clear_error();
   buf->len = 0;
-  goto cleanup;
+  gc_free (&gc);
+  return;
 #else /* HAVE_AEAD_CIPHER_MODES */
   ASSERT (0);
 #endif
@@ -295,7 +295,9 @@ openvpn_encrypt_v1 (struct buffer *buf, struct buffer work,
 	      hmac_start = BPTR(buf);
 	      ASSERT (mac_out = buf_prepend (buf, hmac_ctx_size(ctx->hmac)));
 	    }
-	  buf_write_prepend(buf, BPTR(&work), BLEN(&work));
+	  if (BLEN(&work)) {
+	    buf_write_prepend(buf, BPTR(&work), BLEN(&work));
+	  }
 	  work = *buf;
 	}
 
-- 
2.5.0


