From: Steffan Karger <steffan@...1856...>
Date: Wed, 10 May 2017 22:56:15 +0200
Message-Id: <1494449775-22199-1-git-send-email-steffan@...1856...>
Subject: [Openvpn-devel] [PATCH (release/2.3)] Introduce and use
	secure_memzero() to erase secrets
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

This is a cherry-pick of commit 009521ac (master).

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
initialization using "= { 0 }" if that has the same effect.

Signed-off-by: Steffan Karger <steffan@...1856...>
---
 src/openvpn/basic.h   |  2 +-
 src/openvpn/buffer.c  |  8 ++++----
 src/openvpn/buffer.h  | 43 +++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/crypto.c  | 14 +++++---------
 src/openvpn/init.c    |  2 +-
 src/openvpn/manage.c  |  2 +-
 src/openvpn/misc.c    |  2 +-
 src/openvpn/options.c |  6 +++---
 src/openvpn/ssl.c     | 31 ++++++++++++++-----------------
 9 files changed, 73 insertions(+), 37 deletions(-)

diff --git a/src/openvpn/basic.h b/src/openvpn/basic.h
index 95caf76..dac6f01 100644
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
index 4d217d1..1c17b61 100644
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
@@ -579,9 +581,7 @@ string_clear (char *str)
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
index c34c4a3..3f600e7 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -307,6 +307,49 @@ has_digit (const unsigned char* src)
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
index f153367..6fc97dd 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -98,15 +98,13 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
       /* Do Encrypt from buf -> work */
       if (ctx->cipher)
 	{
-	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH];
+	  uint8_t iv_buf[OPENVPN_MAX_IV_LENGTH] = {0};
 	  const int iv_size = cipher_ctx_iv_length (ctx->cipher);
 	  const cipher_kt_t *cipher_kt = cipher_ctx_get_cipher_kt (ctx->cipher);
 	  int outlen;
 
 	  if (cipher_kt_mode_cbc(cipher_kt))
 	    {
-	      CLEAR (iv_buf);
-
 	      /* generate pseudo-random IV */
 	      if (opt->flags & CO_USE_IV)
 		prng_bytes (iv_buf, iv_size);
@@ -124,7 +122,6 @@ openvpn_encrypt (struct buffer *buf, struct buffer work,
 	      ASSERT (opt->flags & CO_USE_IV);    /* IV and packet-ID required */
 	      ASSERT (opt->packet_id); /*  for this mode. */
 
-	      memset (iv_buf, 0, iv_size);
 	      buf_set_write (&b, iv_buf, iv_size);
 	      ASSERT (packet_id_write (&opt->packet_id->send, &b, true, false));
 	    }
@@ -271,14 +268,13 @@ openvpn_decrypt (struct buffer *buf, struct buffer work,
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
@@ -828,7 +824,7 @@ get_tls_handshake_key (const struct key_type *key_type,
       init_key_ctx (&ctx->decrypt, &key2.keys[kds.in_key], &kt, OPENVPN_OP_DECRYPT,
 		    "Incoming Control Channel Authentication");
 
-      CLEAR (key2);
+      secure_memzero (&key2, sizeof (key2));
     }
   else
     {
@@ -1138,8 +1134,8 @@ write_key_file (const int nkeys, const char *filename)
       buf_printf (&out, "%s\n", fmt);
 
       /* zero memory which held key component (will be freed by GC) */
-      memset (fmt, 0, strlen(fmt));
-      CLEAR (key);
+      secure_memzero (fmt, strlen (fmt));
+      secure_memzero (&key, sizeof (key));
     }
 
   buf_printf (&out, "%s\n", static_key_foot);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 227d2c6..42380b7 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2115,7 +2115,7 @@ do_init_crypto_static (struct context *c, const unsigned int flags)
 		    &c->c1.ks.key_type, OPENVPN_OP_DECRYPT, "Static Decrypt");
 
       /* Erase the temporary copy of key */
-      CLEAR (key2);
+      secure_memzero (&key2, sizeof(key2));
     }
   else
     {
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index cf6fec1..d9471d1 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2975,7 +2975,7 @@ management_query_user_pass (struct management *man,
 	  man->connection.up_query.nocache = up->nocache; /* preserve caller's nocache setting */
 	  *up = man->connection.up_query;
 	}
-      CLEAR (man->connection.up_query);
+      secure_memzero (&man->connection.up_query, sizeof (man->connection.up_query));
     }
 
   gc_free (&gc);
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 39aa936..dc650c6 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1340,7 +1340,7 @@ purge_user_pass (struct user_pass *up, const bool force)
   static bool warn_shown = false;
   if (nocache || force)
     {
-      CLEAR (*up);
+      secure_memzero (up, sizeof(*up));
       up->nocache = nocache;
     }
   else if (!warn_shown)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3a6b4f2..79f861b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3819,7 +3819,7 @@ read_inline_file (struct in_src *is, const char *close_tag, struct gc_arena *gc)
   ret = string_alloc (BSTR (&buf), gc);
   buf_clear (&buf);
   free_buf (&buf);
-  CLEAR (line);
+  secure_memzero (line, sizeof (line));
   return ret;
 }
 
@@ -3934,7 +3934,7 @@ read_config_file (struct options *options,
     {
       msg (msglevel, "In %s:%d: Maximum recursive include levels exceeded in include attempt of file %s -- probably you have a configuration file that tries to include itself.", top_file, top_line, file);
     }
-  CLEAR (line);
+  secure_memzero (line, sizeof (line));
   CLEAR (p);
 }
 
@@ -3966,7 +3966,7 @@ read_config_string (const char *prefix,
 	}
       CLEAR (p);
     }
-  CLEAR (line);
+  secure_memzero (line, sizeof (line));
 }
 
 void
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 32d0b6b..c52a0e4 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1427,7 +1427,7 @@ tls1_P_hash(const md_kt_t *md_kt,
     }
   hmac_ctx_cleanup(&ctx);
   hmac_ctx_cleanup(&ctx_tmp);
-  CLEAR (A1);
+  secure_memzero (A1, sizeof (A1));
 
   dmsg (D_SHOW_KEY_SOURCE, "tls1_P_hash out: %s", format_hex (out_orig, olen_orig, 0, &gc));
   gc_free (&gc);
@@ -1537,14 +1537,11 @@ generate_key_expansion (struct key_ctx_bi *key,
 			const struct session_id *server_sid,
 			bool server)
 {
-  uint8_t master[48];
-  struct key2 key2;
+  uint8_t master[48] = { 0 };
+  struct key2 key2 = { 0 };
   bool ret = false;
   int i;
 
-  CLEAR (master);
-  CLEAR (key2);
-
   /* debugging print of source key material */
   key_source2_print (key_src);
 
@@ -1608,8 +1605,8 @@ generate_key_expansion (struct key_ctx_bi *key,
   ret = true;
 
  exit:
-  CLEAR (master);
-  CLEAR (key2);
+  secure_memzero (&master, sizeof (master));
+  secure_memzero (&key2, sizeof (key2));
 
   return ret;
 }
@@ -1806,7 +1803,7 @@ key_method_1_write (struct buffer *buf, struct tls_session *session)
 
   init_key_ctx (&ks->key.encrypt, &key, &session->opt->key_type,
 		OPENVPN_OP_ENCRYPT, "Data Channel Encrypt");
-  CLEAR (key);
+  secure_memzero (&key, sizeof (key));
 
   /* send local options string */
   {
@@ -1976,7 +1973,7 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
 	    }
 	}
 		      
-      CLEAR (*ks->key_src);
+      secure_memzero (ks->key_src, sizeof (*ks->key_src));
       tls_limit_reneg_bytes (session->opt->key_type.cipher,
 			     &session->opt->renegotiate_bytes);
     }
@@ -1985,7 +1982,7 @@ key_method_2_write (struct buffer *buf, struct tls_session *session)
 
  error:
   msg (D_TLS_ERRORS, "TLS Error: Key Method #2 write failed");
-  CLEAR (*ks->key_src);
+  secure_memzero (ks->key_src, sizeof (*ks->key_src));
   return false;
 }
 
@@ -2040,13 +2037,13 @@ key_method_1_read (struct buffer *buf, struct tls_session *session)
 
   init_key_ctx (&ks->key.decrypt, &key, &session->opt->key_type,
 		OPENVPN_OP_DECRYPT, "Data Channel Decrypt");
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
 
@@ -2111,7 +2108,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
 
       if (!username_status || !password_status)
 	{
-	  CLEAR (*up);
+	  secure_memzero (up, sizeof(*up));
 	  if (!(session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL))
 	    {
 	      msg (D_TLS_ERRORS, "TLS Error: Auth Username/Password was not provided by peer");
@@ -2126,7 +2123,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
 #endif
 
       verify_user_pass(up, multi, session);
-      CLEAR (*up);
+      secure_memzero (up, sizeof (*up));
     }
   else
     {
@@ -2188,14 +2185,14 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
 	  goto error;
 	}
 		      
-      CLEAR (*ks->key_src);
+      secure_memzero (ks->key_src, sizeof (*ks->key_src));
     }
 
   gc_free (&gc);
   return true;
 
  error:
-  CLEAR (*ks->key_src);
+  secure_memzero (ks->key_src, sizeof (*ks->key_src));
   buf_clear (buf);
   gc_free (&gc);
   return false;
-- 
2.7.4


