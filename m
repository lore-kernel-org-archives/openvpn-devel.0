From: Steffan Karger <steffan.karger@...1435...>
Date: Mon, 28 Nov 2016 13:13:40 +0100
Message-ID: <1480335220-14810-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Introduce and use secure_memzero() to erase
	secrets
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

As described in trac #751, and shortly after reported by Zhaomo Yang, of
the University of California, San Diego, we use memset() (often through
the CLEAR() macro) to erase secrets after use.  In some cases however, the
compiler might optimize these calls away.

This patch replaces these memset() calls on secrets by calls to a new
secure_memzero() function, that will not be optimized away.

Since we use CLEAR() a LOT of times, I'm not changing that to use
secure_memzero() to prevent performance impact.  I did annotate the macro
to point people at secure_memzero().

This patch also replaces some CLEAR() or memset() calls with a zero-
initialization using "= { 0 }" if that has the same effect, because that
better captures the intend of that code.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/basic.h   |  2 +-
 src/openvpn/buffer.c  |  8 ++++----
 src/openvpn/buffer.h  | 43 +++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/crypto.c  | 17 ++++++-----------
 src/openvpn/manage.c  |  2 +-
 src/openvpn/misc.c    |  2 +-
 src/openvpn/options.c |  6 +++---
 src/openvpn/ssl.c     | 22 +++++++++++-----------
 8 files changed, 70 insertions(+), 32 deletions(-)

diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 298cf10..48d4d9b 100644
--- a/src/openvpn/basic.h
+++ b/src/openvpn/basic.h
@@ -30,7 +30,7 @@
 /* size of an array */
 #define SIZE(x) (sizeof(x)/sizeof(x[0]))
 
-/* clear an object */
+/* clear an object (may be optimized away, use secure_memzero() to erase secrets) */
 #define CLEAR(x) memset(&(x), 0, sizeof(x))
 
 #define IPV4_NETMASK_HOST 0xffffffffU
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 52c6ab9..84d2669 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -155,7 +155,9 @@ void
 buf_clear (struct buffer *buf)
 {
   if (buf->capacity > 0)
-    memset (buf->data, 0, buf->capacity);
+    {
+      secure_memzero (buf->data, buf->capacity);
+    }
   buf->len = 0;
   buf->offset = 0;
 }
@@ -616,9 +618,7 @@ string_clear (char *str)
 {
   if (str)
     {
-      const int len = strlen (str);
-      if (len > 0)
-	memset (str, 0, len);
+      secure_memzero (str, strlen (str));
     }
 }
 
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 8070439..7747003 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -328,6 +328,49 @@ has_digit (const unsigned char* src)
   return false;
 }
 
+/**
+ * Securely zeroise memory.
+ *
+ * This code and description are based on code supplied by Zhaomo Yang, of the
+ * University of California, San Diego (which was released into the public
+ * domain).
+ *
+ * The secure_memzero function attempts to ensure that an optimizing compiler
+ * does not remove the intended operation if cleared memory is not accessed
+ * again by the program. This code has been tested under Clang 3.9.0 and GCC
+ * 6.2 with optimization flags -O, -Os, -O0, -O1, -O2, and -O3 on
+ * Ubuntu 16.04.1 LTS; under Clang 3.9.0 with optimization flags -O, -Os,
+ * -O0, -O1, -O2, and -O3 on FreeBSD 10.2-RELEASE; under Microsoft Visual Studio
+ * 2015 with optimization flags /O1, /O2 and /Ox on Windows 10.
+ *
+ * Theory of operation:
+ *
+ * 1. On Windows, use the SecureZeroMemory which ensures that data is
+ *    overwritten.
+ * 2. Under GCC or Clang, use a memory barrier, which forces the preceding
+ *    memset to be carried out. The overhead of a memory barrier is usually
+ *    negligible.
+ * 3. If none of the above are available, use the volatile pointer
+ *    technique to zero memory one byte at a time.
+ *
+ * @param data	Pointer to data to zeroise.
+ * @param len	Length of data, in bytes.
+ */
+static inline void
+secure_memzero (void *data, size_t len)
+{
+#if defined(_WIN32)
+  SecureZeroMemory (data, len);
+#elif defined(__GNUC__) || defined(__clang__)
+  memset(data, 0, len);
+  __asm__ __volatile__("" : : "r"(data) : "memory");
+#else
+  volatile char *p = (volatile char *) data;
+  while (len--)
+    *p++ = 0;
+#endif
+}
+
 /*
  * printf append to a buffer with overflow check,
  * due to usage of vsnprintf, it will leave space for
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 05622ce..708cc92 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -86,12 +86,11 @@ openvpn_encrypt_aead (struct buffer *buf, struct buffer work,
   {
     struct buffer iv_buffer;
     struct packet_id_net pin;
-    uint8_t iv[OPENVPN_MAX_IV_LENGTH];
+    uint8_t iv[OPENVPN_MAX_IV_LENGTH] = {0};
     const int iv_len = cipher_ctx_iv_length (ctx->cipher);
 
     ASSERT (iv_len >= OPENVPN_AEAD_MIN_IV_LEN && iv_len <= OPENVPN_MAX_IV_LENGTH);
 
-    memset(iv, 0, sizeof(iv));
     buf_set_write (&iv_buffer, iv, iv_len);
 
     /* IV starts with packet id to make the IV unique for packet */
@@ -175,7 +174,7 @@ openvpn_encrypt_v1 (struct buffer *buf, struct buffer work,
       /* Do Encrypt from buf -> work */
       if (ctx->cipher)
 	{
-	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH];
+	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] = {0};
 	  const int iv_size = cipher_ctx_iv_length (ctx->cipher);
 	  const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt (ctx->cipher);
 	  int outlen;
@@ -190,8 +189,6 @@ openvpn_encrypt_v1 (struct buffer *buf, struct buffer work,
 
 	  if (cipher_kt_mode_cbc(cipher_kt))
 	    {
-	      CLEAR (iv_buf);
-
 	      /* generate pseudo-random IV */
 	      if (opt->flags & CO_USE_IV)
 		prng_bytes (iv_buf, iv_size);
@@ -214,7 +211,6 @@ openvpn_encrypt_v1 (struct buffer *buf, struct buffer work,
 	      ASSERT (packet_id_initialized(&opt->packet_id));
 
 	      packet_id_alloc_outgoing (&opt->packet_id.send, &pin, true);
-	      memset (iv_buf, 0, iv_size);
 	      buf_set_write (&b, iv_buf, iv_size);
 	      ASSERT (packet_id_write (&pin, &b, true, false));
 	    }
@@ -550,14 +546,13 @@ openvpn_decrypt_v1 (struct buffer *buf, struct buffer work,
 	{
 	  const int iv_size = cipher_ctx_iv_length (ctx->cipher);
 	  const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt (ctx->cipher);
-	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH];
+	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] = { 0 };
 	  int outlen;
 
 	  /* initialize work buffer with FRAME_HEADROOM bytes of prepend capacity */
 	  ASSERT (buf_init (&work, FRAME_HEADROOM_ADJ (frame, FRAME_HEADROOM_MARKER_DECRYPT)));
 
 	  /* use IV if user requested it */
-	  CLEAR (iv_buf);
 	  if (opt->flags & CO_USE_IV)
 	    {
 	      if (buf->len < iv_size)
@@ -1128,7 +1123,7 @@ crypto_read_openvpn_key (const struct key_type *key_type,
   init_key_ctx (&ctx->decrypt, &key2.keys[kds.in_key], key_type,
 		OPENVPN_OP_DECRYPT, log_prefix);
 
-  CLEAR (key2);
+  secure_memzero (&key2, sizeof (key2));
 }
 
 /* header and footer for static key file */
@@ -1380,8 +1375,8 @@ write_key_file (const int nkeys, const char *filename)
       buf_printf (&out, "%s\n", fmt);
 
       /* zero memory which held key component (will be freed by GC) */
-      memset (fmt, 0, strlen(fmt));
-      CLEAR (key);
+      secure_memzero (fmt, strlen (fmt));
+      secure_memzero (&key, sizeof (key));
     }
 
   buf_printf (&out, "%s\n", static_key_foot);
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 77a8006..4918ed2 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3154,7 +3154,7 @@ management_query_user_pass (struct management *man,
 	  man->connection.up_query.nocache = up->nocache; /* preserve caller's nocache setting */
 	  *up = man->connection.up_query;
 	}
-      CLEAR (man->connection.up_query);
+      secure_memzero (&man->connection.up_query, sizeof (man->connection.up_query));
     }
 
   gc_free (&gc);
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 56d43e0..a375ab9 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1342,7 +1342,7 @@ purge_user_pass (struct user_pass *up, const bool force)
   static bool warn_shown = false;
   if (nocache || force)
     {
-      CLEAR (*up);
+      secure_memzero (up, sizeof(*up));
       up->nocache = nocache;
     }
   else if (!warn_shown)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7c2b989..42a0534 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3968,7 +3968,7 @@ read_inline_file (struct in_src *is, const char *close_tag, struct gc_arena *gc)
   ret = string_alloc (BSTR (&buf), gc);
   buf_clear (&buf);
   free_buf (&buf);
-  CLEAR (line);
+  secure_memzero (line, sizeof (line));
   return ret;
 }
 
@@ -4083,7 +4083,7 @@ read_config_file (struct options *options,
     {
       msg (msglevel, "In %s:%d: Maximum recursive include levels exceeded in include attempt of file %s -- probably you have a configuration file that tries to include itself.", top_file, top_line, file);
     }
-  CLEAR (line);
+  secure_memzero (line, sizeof (line));
   CLEAR (p);
 }
 
@@ -4115,7 +4115,7 @@ read_config_string (const char *prefix,
 	}
       CLEAR (p);
     }
-  CLEAR (line);
+  secure_memzero (line, sizeof (line));
 }
 
 void
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 7347a78..e0cf1c5 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1222,7 +1222,7 @@ tls_multi_free (struct tls_multi *multi, bool clear)
     tls_session_free (&multi->session[i], false);
 
   if (clear)
-    CLEAR (*multi);
+    secure_memzero (multi, sizeof (*multi));
 
   free(multi);
 }
@@ -1512,7 +1512,7 @@ tls1_P_hash(const md_kt_t *md_kt,
     }
   hmac_ctx_cleanup(&ctx);
   hmac_ctx_cleanup(&ctx_tmp);
-  CLEAR (A1);
+  secure_memzero (A1, sizeof (A1));
 
   dmsg (D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex (out_orig, olen_orig, 0, &gc));
   gc_free (&gc);
@@ -1702,8 +1702,8 @@ generate_key_expansion (struct key_ctx_bi *key,
   ret = true;
 
  exit:
-  CLEAR (master);
-  CLEAR (key2);
+  secure_memzero (&master, sizeof (master));
+  secure_memzero (&key2, sizeof (key2));
 
   return ret;
 }
@@ -1787,7 +1787,7 @@ tls_session_generate_data_channel_keys(struct tls_session *session)
 
   ret = true;
 cleanup:
-  CLEAR (*ks->key_src);
+  secure_memzero (ks->key_src, sizeof (*ks->key_src));
   return ret;
 }
 
@@ -2017,7 +2017,7 @@ key_method_1_write (struct buffer *buf, struct tls_session *session)
   init_key_ctx (&ks->crypto_options.key_ctx_bi.encrypt, &key,
 		&session->opt->key_type, OPENVPN_OP_ENCRYPT,
 		"Data Channel Encrypt");
-  CLEAR (key);
+  secure_memzero (&key, sizeof (key));
 
   /* send local options string */
   {
@@ -2202,7 +2202,7 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
 
  error:
   msg (D_TLS_ERRORS, "TLS Error: Key Method #2 write failed");
-  CLEAR (*ks->key_src);
+  secure_memzero (ks->key_src, sizeof (*ks->key_src));
   return false;
 }
 
@@ -2257,13 +2257,13 @@ key_method_1_read (struct buffer *buf, struct tls_session *session)
   init_key_ctx (&ks->crypto_options.key_ctx_bi.decrypt, &key,
 		&session->opt->key_type, OPENVPN_OP_DECRYPT,
 		"Data Channel Decrypt");
-  CLEAR (key);
+  secure_memzero (&key, sizeof (key));
   ks->authenticated = true;
   return true;
 
  error:
   buf_clear (buf);
-  CLEAR (key);
+  secure_memzero (&key, sizeof (key));
   return false;
 }
 
@@ -2377,7 +2377,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
     }
 
   /* clear username and password from memory */
-  CLEAR (*up);
+  secure_memzero (up, sizeof (*up));
 
   /* Perform final authentication checks */
   if (ks->authenticated)
@@ -2433,7 +2433,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
   return true;
 
  error:
-  CLEAR (*ks->key_src);
+  secure_memzero (ks->key_src, sizeof (*ks->key_src));
   buf_clear (buf);
   gc_free (&gc);
   return false;
-- 
2.7.4


