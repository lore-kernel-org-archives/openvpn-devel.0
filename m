From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 26 Oct 2016 17:47:58 +0200
Message-ID: <1477496878-17296-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH (master)] Limit --reneg-bytes to 64MB when
	using small block ciphers
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

Following the earlier warning about small block ciphers, now limit the
--reneg-bytes value when using a cipher that susceptible to SWEET32-like
attacks.  The 64 MB value has been selected with the researchers who
published the SWEET32 paper.

Note that this will not change a user-set (non-zero) --reneg-bytes value,
to allow a user to override this behaviour if really needed.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto.c |  5 +++--
 src/openvpn/ssl.c    | 24 ++++++++++++++++++++++++
 2 files changed, 27 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 45689f2..b40fc7a 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -836,8 +836,9 @@ init_key_ctx (struct key_ctx *ctx, struct key *key,
 	  cipher_kt_iv_size(kt->cipher));
       if (cipher_kt_block_size(kt->cipher) < 128/8)
 	{
-	  msg (M_WARN, "WARNING: this cipher's block size is less than 128 bit "
-	      "(%d bit).  Consider using a --cipher with a larger block size.",
+	  msg (M_WARN, "WARNING: this cipher's block size is less than 128 "
+	      "bit (%d bit).  This allows attacks like SWEET32.  Consider "
+	      "using a --cipher with a larger block size.",
 	      cipher_kt_block_size(kt->cipher)*8);
 	}
     }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index dfdc200..2c341a2 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -283,6 +283,24 @@ tls_get_cipher_name_pair (const char * cipher_name, size_t len) {
   return NULL;
 }
 
+/**
+ * Limit the reneg_bytes value when using a small-block (<128 bytes) cipher.
+ *
+ * @param cipher	The current cipher (may be NULL).
+ * @param reneg_bytes	Pointer to the current reneg_bytes, updated if needed.
+ * 			May *not* be NULL.
+ */
+static void
+tls_limit_reneg_bytes (const cipher_kt_t *cipher, int *reneg_bytes)
+{
+  if (*reneg_bytes == 0 && cipher && (cipher_kt_block_size(cipher) < 128/8))
+    {
+      msg (M_WARN, "WARNING: cipher with small block size in use, "
+	   "reducing reneg-bytes to 64MB to mitigate SWEET32 attacks.");
+      *reneg_bytes = 64 * 1024 * 1024;
+    }
+}
+
 /*
  * Max number of bytes we will add
  * for data structures common to both
@@ -1742,6 +1760,8 @@ tls_session_update_crypto_params(struct tls_session *session,
       msg (D_TLS_ERRORS, "TLS Error: server generate_key_expansion failed");
       goto cleanup;
     }
+  tls_limit_reneg_bytes (session->opt->key_type.cipher,
+			 &session->opt->renegotiate_bytes);
   ret = true;
 cleanup:
   CLEAR (*ks->key_src);
@@ -2126,6 +2146,8 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
 	}
 		      
       CLEAR (*ks->key_src);
+      tls_limit_reneg_bytes (session->opt->key_type.cipher,
+			     &session->opt->renegotiate_bytes);
     }
 
   return true;
@@ -2354,6 +2376,8 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
 	}
 
       CLEAR (*ks->key_src);
+      tls_limit_reneg_bytes (session->opt->key_type.cipher,
+			     &session->opt->renegotiate_bytes);
     }
 
   gc_free (&gc);
-- 
2.7.4


