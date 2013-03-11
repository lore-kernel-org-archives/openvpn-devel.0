From: Arne Schwabe <arne@...1227...>
Date: Mon, 11 Mar 2013 21:10:49 +0100
Message-Id: <1363032651-23934-2-git-send-email-arne@...1227...>
In-Reply-To: <1363032651-23934-1-git-send-email-arne@...1227...>
References: <1363032651-23934-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 2/4] Use casts when assigning void*
	variables.
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

Clang in c mode warns about these. In C++ mode these are forbidden.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/base64.c              |    2 +-
 src/openvpn/buffer.c              |    6 +++---
 src/openvpn/init.c                |    2 +-
 src/openvpn/list.c                |    2 +-
 src/openvpn/misc.c                |    4 ++--
 src/openvpn/options.c             |    8 ++++----
 src/openvpn/plugin.c              |    4 ++--
 src/openvpn/proxy.c               |    2 +-
 src/openvpn/route.c               |    4 ++--
 src/openvpn/ssl_openssl.c         |    2 +-
 src/openvpn/ssl_verify_openssl.c  |    8 ++++----
 src/openvpn/ssl_verify_polarssl.c |    4 ++--
 src/openvpn/win32.c               |    4 ++--
 13 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index bb89aae..8cdd375 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -137,7 +137,7 @@ openvpn_base64_decode(const char *str, void *data, int size)
     unsigned char *q;
     unsigned char *e = NULL;
 
-    q = data;
+    q = (unsigned char*) data;
     if (size >= 0)
       e = q + size;
     for (p = str; *p && (*p == '=' || strchr(base64_chars, *p)); p += 4) {
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 56d14b1..5b8c0cb 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -71,7 +71,7 @@ alloc_buf (size_t size)
 #ifdef DMALLOC
   buf.data = openvpn_dmalloc (file, line, size);
 #else
-  buf.data = calloc (1, size);
+  buf.data = (uint8_t*) calloc (1, size);
 #endif
   check_malloc_return(buf.data);
 
@@ -547,7 +547,7 @@ string_alloc (const char *str, struct gc_arena *gc)
         ret = openvpn_dmalloc (file, line, n);
         memset(ret, 0, n);
 #else
-        ret = calloc(1, n);
+        ret =  (char *) calloc(1, n);
 #endif
         check_malloc_return(ret);
       }
@@ -1041,7 +1041,7 @@ buffer_list_aggregate (struct buffer_list *bl, const size_t max)
 	  struct buffer_entry *e = bl->head, *f;
 
 	  ALLOC_OBJ_CLEAR (f, struct buffer_entry);
-	  f->buf.data = malloc (size);
+	  f->buf.data = (uint8_t *) malloc (size);
 	  check_malloc_return (f->buf.data);
 	  f->buf.capacity = size;
 	  for (i = 0; e && i < count; ++i)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 979ba23..df750f6 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -115,7 +115,7 @@ update_options_ce_post (struct options *options)
 static bool
 management_callback_proxy_cmd (void *arg, const char **p)
 {
-  struct context *c = arg;
+  struct context *c = (struct context *) arg;
   struct connection_entry *ce = &c->options.ce;
   struct gc_arena *gc = &c->c2.gc;
   bool ret = false;
diff --git a/src/openvpn/list.c b/src/openvpn/list.c
index ea6bd74..6b97853 100644
--- a/src/openvpn/list.c
+++ b/src/openvpn/list.c
@@ -215,7 +215,7 @@ hash_remove_marked (struct hash *hash, struct hash_bucket *bucket)
 uint32_t
 void_ptr_hash_function (const void *key, uint32_t iv)
 {
-  return hash_func ((const void *)&key, sizeof (key), iv);
+  return hash_func ((const uint8_t *)&key, sizeof (key), iv);
 }
 
 bool
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index fa327f8..1ed04fd 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1746,7 +1746,7 @@ argv_term (const char **f)
     {
       char *ret;
       ASSERT (termlen > 0);
-      ret = malloc (termlen + 1);
+      ret = (char *) malloc (termlen + 1);
       check_malloc_return (ret);
       memcpy (ret, term, termlen);
       ret[termlen] = '\0';
@@ -2007,7 +2007,7 @@ argv_test (void)
 const char *
 sanitize_control_message(const char *src, struct gc_arena *gc)
 {
-  char *ret = gc_malloc (strlen(src)+1, false, gc);
+  char *ret = (char *) gc_malloc (strlen(src)+1, false, gc);
   char *dest = ret;
   bool redact = false;
   int skip = 0;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 8592955..181b139 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3083,7 +3083,7 @@ options_warning_extract_parm1 (const char *option_string,
 {
   struct gc_arena gc = gc_new ();
   struct buffer b = string_alloc_buf (option_string, &gc);
-  char *p = gc_malloc (OPTION_PARM_SIZE, false, &gc);
+  char *p = (char *) gc_malloc (OPTION_PARM_SIZE, false, &gc);
   const char *ret;
   
   buf_parse (&b, ' ', p, OPTION_PARM_SIZE);
@@ -3115,7 +3115,7 @@ options_warning_safe_scan2 (const int msglevel,
       struct gc_arena gc = gc_new ();
       struct buffer b2 = *b2_src;
       const char *p1_prefix = options_warning_extract_parm1 (p1, &gc);
-      char *p2 = gc_malloc (OPTION_PARM_SIZE, false, &gc);
+      char *p2 = (char *) gc_malloc (OPTION_PARM_SIZE, false, &gc);
 
       while (buf_parse (&b2, delim, p2, OPTION_PARM_SIZE))
 	{
@@ -3162,7 +3162,7 @@ options_warning_safe_scan1 (const int msglevel,
 {
   struct gc_arena gc = gc_new ();
   struct buffer b = *b1_src;
-  char *p = gc_malloc (OPTION_PARM_SIZE, true, &gc);
+  char *p = (char *) gc_malloc (OPTION_PARM_SIZE, true, &gc);
 
   while (buf_parse (&b, delim, p, OPTION_PARM_SIZE))
       options_warning_safe_scan2 (msglevel, delim, report_inconsistent, p, b2_src, b1_name, b2_name);
@@ -3563,7 +3563,7 @@ parse_line (const char *line,
 	  if (state == STATE_DONE)
 	    {
 	      /* ASSERT (parm_len > 0); */
-	      p[ret] = gc_malloc (parm_len + 1, true, gc);
+	      p[ret] = (char *) gc_malloc (parm_len + 1, true, gc);
 	      memcpy (p[ret], parm, parm_len);
 	      p[ret][parm_len] = '\0';
 	      state = STATE_INITIAL;
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 83f79e4..26bea03 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -230,7 +230,7 @@ plugin_init_item (struct plugin *p, const struct plugin_option *o)
   if (!p->handle)
     msg (M_ERR, "PLUGIN_INIT: could not load plugin shared object %s: %s", p->so_pathname, dlerror());
 
-# define PLUGIN_SYM(var, name, flags) libdl_resolve_symbol (p->handle, (void*)&p->var, name, p->so_pathname, flags)
+# define PLUGIN_SYM(var, name, flags) libdl_resolve_symbol (p->handle, (void**)&p->var, name, p->so_pathname, flags)
 
 #else
 
@@ -325,7 +325,7 @@ plugin_vlog (openvpn_plugin_log_flags_t flags, const char *name, const char *for
       msg_flags |= M_NOIPREFIX;
 
       gc_init (&gc);
-      msg_fmt = gc_malloc (ERR_BUF_SIZE, false, &gc);
+      msg_fmt = (char *) gc_malloc (ERR_BUF_SIZE, false, &gc);
       openvpn_snprintf (msg_fmt, ERR_BUF_SIZE, "PLUGIN %s: %s", name, format);
       x_msg_va (msg_flags, msg_fmt, arglist);
 
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 95d7153..0da32f4 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -737,7 +737,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 	      if (opaque)
 		{
 		  const int len = strlen(opaque)+16;
-		  opaque_kv = gc_malloc(len, false, &gc);
+		  opaque_kv = (char * ) gc_malloc(len, false, &gc);
 		  openvpn_snprintf (opaque_kv, len, ", opaque=\"%s\"", opaque);
 		}
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index dd69d8e..609be1b 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -113,7 +113,7 @@ struct route_option_list *
 clone_route_option_list (const struct route_option_list *src, struct gc_arena *a)
 {
   const size_t rl_size = array_mult_safe (sizeof(struct route_option), src->capacity, sizeof(struct route_option_list));
-  struct route_option_list *ret = gc_malloc (rl_size, false, a);
+  struct route_option_list *ret = (struct route_option_list *) gc_malloc (rl_size, false, a);
   memcpy (ret, src, rl_size);
   return ret;
 }
@@ -122,7 +122,7 @@ struct route_ipv6_option_list *
 clone_route_ipv6_option_list (const struct route_ipv6_option_list *src, struct gc_arena *a)
 {
   const size_t rl_size = array_mult_safe (sizeof(struct route_ipv6_option), src->capacity, sizeof(struct route_ipv6_option_list));
-  struct route_ipv6_option_list *ret = gc_malloc (rl_size, false, a);
+  struct route_ipv6_option_list *ret = (struct route_ipv6_option_list *) gc_malloc (rl_size, false, a);
   memcpy (ret, src, rl_size);
   return ret;
 }
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a727b60..cc3fb24 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -74,7 +74,7 @@ tls_init_lib()
 #endif
   OpenSSL_add_all_algorithms ();
 
-  mydata_index = SSL_get_ex_new_index(0, "struct session *", NULL, NULL, NULL);
+  mydata_index = SSL_get_ex_new_index(0, (void *) "struct session *", NULL, NULL, NULL);
   ASSERT (mydata_index >= 0);
 }
 
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 658f5f3..2c43697 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -52,7 +52,7 @@ verify_callback (int preverify_ok, X509_STORE_CTX * ctx)
   struct gc_arena gc = gc_new();
 
   /* get the tls_session pointer */
-  ssl = X509_STORE_CTX_get_ex_data (ctx, SSL_get_ex_data_X509_STORE_CTX_idx());
+  ssl = (SSL *) X509_STORE_CTX_get_ex_data (ctx, SSL_get_ex_data_X509_STORE_CTX_idx());
   ASSERT (ssl);
   session = (struct tls_session *) SSL_get_ex_data (ssl, mydata_index);
   ASSERT (session);
@@ -241,7 +241,7 @@ x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 unsigned char *
 x509_get_sha1_hash (X509 *cert, struct gc_arena *gc)
 {
-  char *hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
+  unsigned char *hash = (unsigned char *) gc_malloc(SHA_DIGEST_LENGTH, false, gc);
   memcpy(hash, cert->sha1_hash, SHA_DIGEST_LENGTH);
   return hash;
 }
@@ -260,7 +260,7 @@ x509_get_subject (X509 *cert, struct gc_arena *gc)
    */
   if (compat_flag (COMPAT_FLAG_QUERY | COMPAT_NAMES))
     {
-      subject = gc_malloc (256, false, gc);
+      subject = (char *) gc_malloc (256, false, gc);
       X509_NAME_oneline (X509_get_subject_name (cert), subject, 256);
       subject[255] = '\0';
       return subject;
@@ -280,7 +280,7 @@ x509_get_subject (X509 *cert, struct gc_arena *gc)
   BIO_get_mem_ptr (subject_bio, &subject_mem);
 
   maxlen = subject_mem->length + 1;
-  subject = gc_malloc (maxlen, false, gc);
+  subject = (char *) gc_malloc (maxlen, false, gc);
 
   memcpy (subject, subject_mem->data, maxlen);
   subject[maxlen - 1] = '\0';
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index a32db8d..32dfc36 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -133,7 +133,7 @@ x509_get_serial (x509_cert *cert, struct gc_arena *gc)
   char *buf = NULL;
   size_t len = cert->serial.len * 3 + 1;
 
-  buf = gc_malloc(len, true, gc);
+  buf = (char *) gc_malloc(len, true, gc);
 
   if(x509parse_serial_gets(buf, len-1, &cert->serial) < 0)
     buf = NULL;
@@ -144,7 +144,7 @@ x509_get_serial (x509_cert *cert, struct gc_arena *gc)
 unsigned char *
 x509_get_sha1_hash (x509_cert *cert, struct gc_arena *gc)
 {
-  unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
+  unsigned char *sha1_hash = (unsigned char *) gc_malloc(SHA_DIGEST_LENGTH, false, gc);
   sha1(cert->tbs.p, cert->tbs.len, sha1_hash);
   return sha1_hash;
 }
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 2db96a8..f8ed9b5 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -829,7 +829,7 @@ wide_cmd_line (const struct argv *a, struct gc_arena *gc)
 	maxlen = len;
     }
 
-  work = gc_malloc (maxlen + 1, false, gc);
+  work = (char *) gc_malloc (maxlen + 1, false, gc);
   check_malloc_return (work);
   buf = alloc_buf_gc (nchars, gc);
 
@@ -914,7 +914,7 @@ WCHAR *
 wide_string (const char* utf8, struct gc_arena *gc)
 {
   int n = MultiByteToWideChar (CP_UTF8, 0, utf8, -1, NULL, 0);
-  WCHAR *ucs16 = gc_malloc (n * sizeof (WCHAR), false, gc);
+  WCHAR *ucs16 = (WCHAR *) gc_malloc (n * sizeof (WCHAR), false, gc);
   MultiByteToWideChar (CP_UTF8, 0, utf8, -1, ucs16, n);
   return ucs16;
 }
-- 
1.7.9.5


