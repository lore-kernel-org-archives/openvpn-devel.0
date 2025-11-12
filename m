From: Gert Doering <gert@...1296...>
Date: Wed, 12 Nov 2025 12:21:27 +0100
Message-ID: <20251112112133.1325-1-gert@...1296...>
In-Reply-To: <gerrit.1762519477000.I429d768fb33ef2c58484287d4091440ad8599053@...2715...>
References: <gerrit.1762519477000.I429d768fb33ef2c58484287d4091440ad8599053@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Do not underestimate number of
 encrypted/decrypted AEAD blocks
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

From: Arne Schwabe <arne@...1227...>

Even though the current code typically counts all the encrypted/decrypted
traffic, this is only the case because of the specific implementation
of OpenSSL at the moment.

Instead of counting the length returned by one call only, count all
the encrypted/decrypted bytes.

Other implementations that use AES-GCM (like IPSec, MacSEC, TLS 1.2)
(currently) do not honour these usage limits at all. This is the reason that
I also currently do not consider the lack/improper validation in our code
to be a security vulnerability. In the current state implementations/protocol
that lack this feature altogether are not considered vulnerable.

Reported by: <stephan@...2953...>

Change-Id: I429d768fb33ef2c58484287d4091440ad8599053
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1358
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1358
This mail reflects revision 3 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 307d1ee..8049b3a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -152,15 +152,15 @@
     ASSERT(cipher_ctx_update(ctx->cipher, BEND(&work), &outlen, BPTR(buf), BLEN(buf)));
     ASSERT(buf_inc_len(&work, outlen));
 
-    /* update number of plaintext blocks encrypted. Use the (x + (n-1))/n trick
-     * to round up the result to the number of blocks used */
-    const int blocksize = AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi.encrypt.plaintext_blocks += (outlen + (blocksize - 1)) / blocksize;
-
     /* Flush the encryption buffer */
     ASSERT(cipher_ctx_final(ctx->cipher, BEND(&work), &outlen));
     ASSERT(buf_inc_len(&work, outlen));
 
+    /* update number of plaintext blocks encrypted. Use the (x + (n-1))/n trick
+     * to round up the result to the number of blocks used */
+    const int blocksize = AEAD_LIMIT_BLOCKSIZE;
+    opt->key_ctx_bi.encrypt.plaintext_blocks += (BLEN(&work) + (blocksize - 1)) / blocksize;
+
     /* if the tag is at end the end, allocate it now */
     if (use_epoch_data_format)
     {
@@ -580,11 +580,10 @@
         goto error_exit;
     }
 
-
     /* update number of plaintext blocks decrypted. Use the (x + (n-1))/n trick
      * to round up the result to the number of blocks used. */
     const int blocksize = AEAD_LIMIT_BLOCKSIZE;
-    opt->key_ctx_bi.decrypt.plaintext_blocks += (outlen + (blocksize - 1)) / blocksize;
+    opt->key_ctx_bi.decrypt.plaintext_blocks += (BLEN(&work) + (blocksize - 1)) / blocksize;
 
     *buf = work;
 

