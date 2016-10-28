From: Steffan Karger <steffan.karger@...1435...>
Date: Fri, 28 Oct 2016 14:10:07 +0200
Message-ID: <1477656607-7440-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1477496972-17424-1-git-send-email-steffan.karger@...1435...>
References: <1477496972-17424-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 (2.3)] Limit --reneg-bytes to 64MB when
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

Note that this will not change a user-set --reneg-bytes value, to allow a
user to align a gun with his feet^w^w^w^w^w^w override this behaviour if
really needed.

Furthermore, in contrast with the patch for master, this will not limit
--reneg-bytes on the client side.  This allows server administrators to
revert to the old behaviour, or increase --reneg-bytes to something they
believe is workable, without having to change client configs.  (The master
branch provides cipher negotiation as a real solution, so we can be
stricter there.)

v2: obey user-set --reneg-bytes 0 to revert to old behaviour, use more firm
    language in warning message, add URL to man page, and only limit at the
    server side.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 doc/openvpn.8         |  1 +
 src/openvpn/crypto.c  |  5 +++--
 src/openvpn/options.c |  1 +
 src/openvpn/ssl.c     | 25 ++++++++++++++++++++++++-
 4 files changed, 29 insertions(+), 3 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 70573da..7be30ec 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3913,6 +3913,7 @@ an abbreviation for Blowfish in Cipher Block Chaining mode.
 
 Using BF-CBC is no longer recommended, because of it's 64-bit block size.  This
 small block size allows attacks based on collisions, as demonstrated by SWEET32.
+See https://community.openvpn.net/openvpn/wiki/SWEET32 for details.
 
 To see other ciphers that are available with OpenVPN, use the
 .B \-\-show\-ciphers
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 552e333..ca4af27 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -496,8 +496,9 @@ init_key_ctx (struct key_ctx *ctx, struct key *key,
 	  cipher_kt_iv_size(kt->cipher));
       if (cipher_kt_block_size(kt->cipher) < 128/8)
 	{
-	  msg (M_WARN, "WARNING: this cipher's block size is less than 128 bit "
-	      "(%d bit).  Consider using a --cipher with a larger block size.",
+	  msg (M_WARN, "WARNING: INSECURE cipher with block size less than 128"
+	      " bit (%d bit).  This allows attacks like SWEET32.  Mitigate by "
+	      "using a --cipher with a larger block size (e.g. AES-256-CBC).",
 	      cipher_kt_block_size(kt->cipher)*8);
 	}
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 1ef0299..19cd815 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -849,6 +849,7 @@ init_options (struct options *o, const bool init_gc)
 #ifdef ENABLE_SSL
   o->key_method = 2;
   o->tls_timeout = 2;
+  o->renegotiate_bytes = -1;
   o->renegotiate_seconds = 3600;
   o->handshake_window = 60;
   o->transition_window = 3600;
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33fd9dd..bfad291 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -271,6 +271,27 @@ tls_get_cipher_name_pair (const char * cipher_name, size_t len) {
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
+  if (cipher && (cipher_kt_block_size(cipher) < 128/8))
+    {
+      if (*reneg_bytes == -1) /* Not user-specified */
+	{
+	  msg (M_WARN, "WARNING: cipher with small block size in use, "
+	       "reducing reneg-bytes to 64MB to mitigate SWEET32 attacks.");
+	  *reneg_bytes = 64 * 1024 * 1024;
+	}
+    }
+}
+
 /*
  * Max number of bytes we will add
  * for data structures common to both
@@ -1956,6 +1977,8 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
 	}
 		      
       CLEAR (*ks->key_src);
+      tls_limit_reneg_bytes (session->opt->key_type.cipher,
+			     &session->opt->renegotiate_bytes);
     }
 
   return true;
@@ -2222,7 +2245,7 @@ tls_process (struct tls_multi *multi,
   if (ks->state >= S_ACTIVE &&
       ((session->opt->renegotiate_seconds
 	&& now >= ks->established + session->opt->renegotiate_seconds)
-       || (session->opt->renegotiate_bytes
+       || (session->opt->renegotiate_bytes > 0
 	   && ks->n_bytes >= session->opt->renegotiate_bytes)
        || (session->opt->renegotiate_packets
 	   && ks->n_packets >= session->opt->renegotiate_packets)
-- 
2.7.4


