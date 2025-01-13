From: Gert Doering <gert@...1296...>
Date: Mon, 13 Jan 2025 12:22:26 +0100
Message-ID: <20250113112226.17728-1-gert@...1296...>
In-Reply-To: <gerrit.1736765057000.I0391f30a1e962ee242e9bcdec4f605bf7e831cca@...2715...>
References: <gerrit.1736765057000.I0391f30a1e962ee242e9bcdec4f605bf7e831cca@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Fix "uninitialized pointer read" in
 openvpn_decrypt_aead
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

From: Frank Lichtenheld <frank@...2641...>

Coverity complains that if we error out in the first
error condition we try to free gc without initializing
it.

While here move the declaration of outlen to the first
usage.

Change-Id: I0391f30a1e962ee242e9bcdec4f605bf7e831cca
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Antonio Quartulli <a@...2181...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/858
This mail reflects revision 1 of this Change.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <a@...2181...>

        
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 84ec436..dbd95a8 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -406,17 +406,15 @@
     static const char error_prefix[] = "AEAD Decrypt error";
     struct packet_id_net pin = { 0 };
     struct key_ctx *ctx = &opt->key_ctx_bi.decrypt;
+    struct gc_arena gc;
+
+    gc_init(&gc);
 
     if (cipher_decrypt_verify_fail_exceeded(ctx))
     {
         CRYPT_DROP("Decryption failed verification limit reached.");
     }
 
-    int outlen;
-    struct gc_arena gc;
-
-    gc_init(&gc);
-
     ASSERT(opt);
     ASSERT(frame);
     ASSERT(buf->len > 0);
@@ -506,6 +504,8 @@
     dmsg(D_PACKET_CONTENT, "DECRYPT AD: %s",
          format_hex(ad_start, ad_size, 0, &gc));
 
+    int outlen;
+
     /* Decrypt and authenticate packet */
     if (!cipher_ctx_update(ctx->cipher, BPTR(&work), &outlen, BPTR(buf),
                            data_len))

