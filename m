From: David Sommerseth <dazo@...384...>
Date: Thu, 21 Nov 2013 18:02:09 +0100
Message-Id: <1385053332-14533-2-git-send-email-dazo@...384...>
In-Reply-To: <1385053332-14533-1-git-send-email-dazo@...384...>
References: <1385053332-14533-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 1/4] Move over to calloc() in gc_malloc()
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

From: David Sommerseth <davids@...1347...>

Instead of using malloc(), use calloc() which will always provide a
cleared memory region.  Depending on the kernel and libc
implementation, this can in many cases give a better performance.

Another advantage of having a cleared memory is that it can in
many cases prevent buffer overruns, due to improper NULL termination.

In addition, this simplifies the gc_malloc() API by removing an
argument which is no longer needed.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/buffer.c              | 22 ++++++++++------------
 src/openvpn/buffer.h              | 16 ++++++++--------
 src/openvpn/error.c               |  4 ++--
 src/openvpn/misc.c                | 10 +++++-----
 src/openvpn/mtu.c                 |  2 +-
 src/openvpn/options.c             | 12 ++++++------
 src/openvpn/plugin.c              |  2 +-
 src/openvpn/proxy.c               |  2 +-
 src/openvpn/route.c               |  8 ++++----
 src/openvpn/ssl.c                 |  2 +-
 src/openvpn/ssl_verify_openssl.c  |  6 +++---
 src/openvpn/ssl_verify_polarssl.c |  4 ++--
 src/openvpn/tun.c                 |  8 ++++----
 src/openvpn/win32.c               |  4 ++--
 14 files changed, 50 insertions(+), 52 deletions(-)

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index fb3b52d..096d1fa 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -92,9 +92,9 @@ alloc_buf_gc (size_t size, struct gc_arena *gc)
   buf.offset = 0;
   buf.len = 0;
 #ifdef DMALLOC
-  buf.data = (uint8_t *) gc_malloc_debug (size, false, gc, file, line);
+  buf.data = (uint8_t *) gc_malloc_debug (size, gc, file, line);
 #else
-  buf.data = (uint8_t *) gc_malloc (size, false, gc);
+  buf.data = (uint8_t *) gc_malloc (size, gc);
 #endif
   if (size)
     *buf.data = 0;
@@ -321,9 +321,9 @@ buf_write_string_file (const struct buffer *buf, const char *filename, int fd)
 
 void *
 #ifdef DMALLOC
-gc_malloc_debug (size_t size, bool clear, struct gc_arena *a, const char *file, int line)
+gc_malloc_debug (size_t size, struct gc_arena *a, const char *file, int line)
 #else
-gc_malloc (size_t size, bool clear, struct gc_arena *a)
+gc_malloc (size_t size, struct gc_arena *a)
 #endif
 {
   void *ret;
@@ -332,8 +332,9 @@ gc_malloc (size_t size, bool clear, struct gc_arena *a)
       struct gc_entry *e;
 #ifdef DMALLOC
       e = (struct gc_entry *) openvpn_dmalloc (file, line, size + sizeof (struct gc_entry));
+      memset(e, 0, size + sizeof (struct gc_entry));
 #else
-      e = (struct gc_entry *) malloc (size + sizeof (struct gc_entry));
+      e = (struct gc_entry *) calloc (1, size + sizeof (struct gc_entry));
 #endif
       check_malloc_return (e);
       ret = (char *) e + sizeof (struct gc_entry);
@@ -344,15 +345,12 @@ gc_malloc (size_t size, bool clear, struct gc_arena *a)
     {
 #ifdef DMALLOC
       ret = openvpn_dmalloc (file, line, size);
+      memset(ret, 0, size + sizeof (struct gc_entry));
 #else
-      ret = malloc (size);
+      ret = calloc (1, size);
 #endif
       check_malloc_return (ret);
     }
-#ifndef ZERO_BUFFER_ON_ALLOC
-  if (clear)
-#endif
-    memset (ret, 0, size);
   return ret;
 }
 
@@ -543,9 +541,9 @@ string_alloc (const char *str, struct gc_arena *gc)
 
       if (gc) {
 #ifdef DMALLOC
-        ret = (char *) gc_malloc_debug (n, false, gc, file, line);
+        ret = (char *) gc_malloc_debug (n, gc, file, line);
 #else
-        ret = (char *) gc_malloc (n, false, gc);
+        ret = (char *) gc_malloc (n, gc);
 #endif
       } else {
         /* If there are no garbage collector available, it's expected
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 93efb09..bbf715a 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -141,14 +141,14 @@ void buf_size_error (const size_t size);
 #define alloc_buf(size)               alloc_buf_debug (size, __FILE__, __LINE__)
 #define alloc_buf_gc(size, gc)        alloc_buf_gc_debug (size, gc, __FILE__, __LINE__);
 #define clone_buf(buf)                clone_buf_debug (buf, __FILE__, __LINE__);
-#define gc_malloc(size, clear, arena) gc_malloc_debug (size, clear, arena, __FILE__, __LINE__)
+#define gc_malloc(size, arena)        gc_malloc_debug (size, arena, __FILE__, __LINE__)
 #define string_alloc(str, gc)         string_alloc_debug (str, gc, __FILE__, __LINE__)
 #define string_alloc_buf(str, gc)     string_alloc_buf_debug (str, gc, __FILE__, __LINE__)
 
 struct buffer alloc_buf_debug (size_t size, const char *file, int line);
 struct buffer alloc_buf_gc_debug (size_t size, struct gc_arena *gc, const char *file, int line);
 struct buffer clone_buf_debug (const struct buffer* buf, const char *file, int line);
-void *gc_malloc_debug (size_t size, bool clear, struct gc_arena *a, const char *file, int line);
+void *gc_malloc_debug (size_t size, struct gc_arena *a, const char *file, int line);
 char *string_alloc_debug (const char *str, struct gc_arena *gc, const char *file, int line);
 struct buffer string_alloc_buf_debug (const char *str, struct gc_arena *gc, const char *file, int line);
 
@@ -157,7 +157,7 @@ struct buffer string_alloc_buf_debug (const char *str, struct gc_arena *gc, cons
 struct buffer alloc_buf (size_t size);
 struct buffer alloc_buf_gc (size_t size, struct gc_arena *gc); /* allocate buffer with garbage collection */
 struct buffer clone_buf (const struct buffer* buf);
-void *gc_malloc (size_t size, bool clear, struct gc_arena *a);
+void *gc_malloc (size_t size, struct gc_arena *a);
 char *string_alloc (const char *str, struct gc_arena *gc);
 struct buffer string_alloc_buf (const char *str, struct gc_arena *gc);
 
@@ -840,7 +840,7 @@ gc_reset (struct gc_arena *a)
 
 #define ALLOC_ARRAY_GC(dptr, type, n, gc) \
 { \
-  (dptr) = (type *) gc_malloc (array_mult_safe (sizeof (type), (n), 0), false, (gc)); \
+  (dptr) = (type *) gc_malloc (array_mult_safe (sizeof (type), (n), 0), (gc)); \
 }
 
 #define ALLOC_ARRAY_CLEAR(dptr, type, n) \
@@ -851,22 +851,22 @@ gc_reset (struct gc_arena *a)
 
 #define ALLOC_ARRAY_CLEAR_GC(dptr, type, n, gc) \
 { \
-  (dptr) = (type *) gc_malloc (array_mult_safe (sizeof (type), (n), 0), true, (gc)); \
+  (dptr) = (type *) gc_malloc (array_mult_safe (sizeof (type), (n), 0), (gc)); \
 }
 
 #define ALLOC_VAR_ARRAY_CLEAR_GC(dptr, type, atype, n, gc)	\
 { \
-  (dptr) = (type *) gc_malloc (array_mult_safe (sizeof (atype), (n), sizeof (type)), true, (gc)); \
+  (dptr) = (type *) gc_malloc (array_mult_safe (sizeof (atype), (n), sizeof (type)), (gc)); \
 }
 
 #define ALLOC_OBJ_GC(dptr, type, gc) \
 { \
-  (dptr) = (type *) gc_malloc (sizeof (type), false, (gc)); \
+  (dptr) = (type *) gc_malloc (sizeof (type), (gc)); \
 }
 
 #define ALLOC_OBJ_CLEAR_GC(dptr, type, gc) \
 { \
-  (dptr) = (type *) gc_malloc (sizeof (type), true, (gc)); \
+  (dptr) = (type *) gc_malloc (sizeof (type), (gc)); \
 }
 
 static inline void
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 6848425..dc9d855 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -241,8 +241,8 @@ void x_msg_va (const unsigned int flags, const char *format, va_list arglist)
 
   gc_init (&gc);
 
-  m1 = (char *) gc_malloc (ERR_BUF_SIZE, false, &gc);
-  m2 = (char *) gc_malloc (ERR_BUF_SIZE, false, &gc);
+  m1 = (char *) gc_malloc (ERR_BUF_SIZE, &gc);
+  m2 = (char *) gc_malloc (ERR_BUF_SIZE, &gc);
 
   vsnprintf (m1, ERR_BUF_SIZE, format, arglist);
   m1[ERR_BUF_SIZE - 1] = 0; /* windows vsnprintf needs this */
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 4688444..1175ff4 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1095,7 +1095,7 @@ get_user_pass_cr (struct user_pass *up,
 	      struct auth_challenge_info *ac = get_auth_challenge (auth_challenge, &gc);
 	      if (ac)
 		{
-		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
+		  char *response = (char *) gc_malloc (USER_PASS_LEN, &gc);
 		  struct buffer packed_resp;
 
 		  buf_set_write (&packed_resp, (uint8_t*)up->password, USER_PASS_LEN);
@@ -1133,7 +1133,7 @@ get_user_pass_cr (struct user_pass *up,
 #ifdef ENABLE_CLIENT_CR
 	      if (auth_challenge && (flags & GET_USER_PASS_STATIC_CHALLENGE))
 		{
-		  char *response = (char *) gc_malloc (USER_PASS_LEN, false, &gc);
+		  char *response = (char *) gc_malloc (USER_PASS_LEN, &gc);
 		  struct buffer packed_resp;
 		  char *pw64=NULL, *resp64=NULL;
 
@@ -1228,7 +1228,7 @@ get_auth_challenge (const char *auth_challenge, struct gc_arena *gc)
     {
       struct auth_challenge_info *ac;
       const int len = strlen (auth_challenge);
-      char *work = (char *) gc_malloc (len+1, false, gc);
+      char *work = (char *) gc_malloc (len+1, gc);
       char *cp;
 
       struct buffer b;
@@ -1262,7 +1262,7 @@ get_auth_challenge (const char *auth_challenge, struct gc_arena *gc)
       /* parse user name */
       if (!buf_parse(&b, ':', work, len))
 	return NULL;
-      ac->user = (char *) gc_malloc (strlen(work)+1, true, gc);
+      ac->user = (char *) gc_malloc (strlen(work)+1, gc);
       openvpn_base64_decode(work, (void*)ac->user, -1);
 
       /* parse challenge text */
@@ -1999,7 +1999,7 @@ argv_test (void)
 const char *
 sanitize_control_message(const char *src, struct gc_arena *gc)
 {
-  char *ret = gc_malloc (strlen(src)+1, false, gc);
+  char *ret = gc_malloc (strlen(src)+1, gc);
   char *dest = ret;
   bool redact = false;
   int skip = 0;
diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 13f3f6c..52854d4 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -206,7 +206,7 @@ format_extended_socket_error (int fd, int *mtu, struct gc_arena *gc)
   struct sock_extended_err *e;
   struct sockaddr_in addr;
   struct buffer out = alloc_buf_gc (256, gc);
-  char *cbuf = (char *) gc_malloc (256, false, gc);
+  char *cbuf = (char *) gc_malloc (256, gc);
 
   *mtu = 0;
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e925397..81e9a6e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1040,7 +1040,7 @@ static bool ipv6_addr_safe_hexplusbits( const char * ipv6_prefix_spec )
 static char *
 string_substitute (const char *src, int from, int to, struct gc_arena *gc)
 {
-  char *ret = (char *) gc_malloc (strlen (src) + 1, true, gc);
+  char *ret = (char *) gc_malloc (strlen (src) + 1, gc);
   char *dest = ret;
   char c;
 
@@ -1061,7 +1061,7 @@ parse_hash_fingerprint(const char *str, int nbytes, int msglevel, struct gc_aren
 {
   int i;
   const char *cp = str;
-  uint8_t *ret = (uint8_t *) gc_malloc (nbytes, true, gc);
+  uint8_t *ret = (uint8_t *) gc_malloc (nbytes, gc);
   char term = 1;
   int byte;
   char bs[3];
@@ -3089,7 +3089,7 @@ options_warning_extract_parm1 (const char *option_string,
 {
   struct gc_arena gc = gc_new ();
   struct buffer b = string_alloc_buf (option_string, &gc);
-  char *p = gc_malloc (OPTION_PARM_SIZE, false, &gc);
+  char *p = gc_malloc (OPTION_PARM_SIZE, &gc);
   const char *ret;
   
   buf_parse (&b, ' ', p, OPTION_PARM_SIZE);
@@ -3121,7 +3121,7 @@ options_warning_safe_scan2 (const int msglevel,
       struct gc_arena gc = gc_new ();
       struct buffer b2 = *b2_src;
       const char *p1_prefix = options_warning_extract_parm1 (p1, &gc);
-      char *p2 = gc_malloc (OPTION_PARM_SIZE, false, &gc);
+      char *p2 = gc_malloc (OPTION_PARM_SIZE, &gc);
 
       while (buf_parse (&b2, delim, p2, OPTION_PARM_SIZE))
 	{
@@ -3168,7 +3168,7 @@ options_warning_safe_scan1 (const int msglevel,
 {
   struct gc_arena gc = gc_new ();
   struct buffer b = *b1_src;
-  char *p = gc_malloc (OPTION_PARM_SIZE, true, &gc);
+  char *p = gc_malloc (OPTION_PARM_SIZE, &gc);
 
   while (buf_parse (&b, delim, p, OPTION_PARM_SIZE))
       options_warning_safe_scan2 (msglevel, delim, report_inconsistent, p, b2_src, b1_name, b2_name);
@@ -3566,7 +3566,7 @@ parse_line (const char *line,
 	  if (state == STATE_DONE)
 	    {
 	      /* ASSERT (parm_len > 0); */
-	      p[ret] = gc_malloc (parm_len + 1, true, gc);
+	      p[ret] = gc_malloc (parm_len + 1, gc);
 	      memcpy (p[ret], parm, parm_len);
 	      p[ret][parm_len] = '\0';
 	      state = STATE_INITIAL;
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 0948f23..71ad0b6 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -325,7 +325,7 @@ plugin_vlog (openvpn_plugin_log_flags_t flags, const char *name, const char *for
       msg_flags |= M_NOIPREFIX;
 
       gc_init (&gc);
-      msg_fmt = gc_malloc (ERR_BUF_SIZE, false, &gc);
+      msg_fmt = gc_malloc (ERR_BUF_SIZE, &gc);
       openvpn_snprintf (msg_fmt, ERR_BUF_SIZE, "PLUGIN %s: %s", name, format);
       x_msg_va (msg_flags, msg_fmt, arglist);
 
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index c3496e2..9ef1b8f 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -784,7 +784,7 @@ establish_http_proxy_passthru (struct http_proxy_info *p,
 	      if (opaque)
 		{
 		  const int len = strlen(opaque)+16;
-		  opaque_kv = gc_malloc(len, false, &gc);
+		  opaque_kv = gc_malloc(len, &gc);
 		  openvpn_snprintf (opaque_kv, len, ", opaque=\"%s\"", opaque);
 		}
 
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 19b4bfe..37ef096 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -113,7 +113,7 @@ struct route_option_list *
 clone_route_option_list (const struct route_option_list *src, struct gc_arena *a)
 {
   const size_t rl_size = array_mult_safe (sizeof(struct route_option), src->capacity, sizeof(struct route_option_list));
-  struct route_option_list *ret = gc_malloc (rl_size, false, a);
+  struct route_option_list *ret = gc_malloc (rl_size, a);
   memcpy (ret, src, rl_size);
   return ret;
 }
@@ -122,7 +122,7 @@ struct route_ipv6_option_list *
 clone_route_ipv6_option_list (const struct route_ipv6_option_list *src, struct gc_arena *a)
 {
   const size_t rl_size = array_mult_safe (sizeof(struct route_ipv6_option), src->capacity, sizeof(struct route_ipv6_option_list));
-  struct route_ipv6_option_list *ret = gc_malloc (rl_size, false, a);
+  struct route_ipv6_option_list *ret = gc_malloc (rl_size, a);
   memcpy (ret, src, rl_size);
   return ret;
 }
@@ -2080,7 +2080,7 @@ get_windows_routing_table (struct gc_arena *gc)
   status = GetIpForwardTable (NULL, &size, TRUE);
   if (status == ERROR_INSUFFICIENT_BUFFER)
     {
-      rt = (PMIB_IPFORWARDTABLE) gc_malloc (size, false, gc);
+      rt = (PMIB_IPFORWARDTABLE) gc_malloc (size, gc);
       status = GetIpForwardTable (rt, &size, TRUE);
       if (status != NO_ERROR)
 	{
@@ -2925,7 +2925,7 @@ get_default_gateway (struct route_gateway_info *rgi)
       const int bufsize = 4096;
       char *buffer;
 
-      buffer = (char *) gc_malloc (bufsize, true, &gc);
+      buffer = (char *) gc_malloc (bufsize, &gc);
       sockfd = socket(AF_INET, SOCK_DGRAM, 0);
       if (sockfd < 0)
 	{
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 4203fc5..35e5bfb 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1429,7 +1429,7 @@ tls1_PRF(uint8_t *label,
   const uint8_t *S1,*S2;
   uint8_t *out2;
 
-  out2 = (uint8_t *) gc_malloc (olen, false, &gc);
+  out2 = (uint8_t *) gc_malloc (olen, &gc);
 
   len=slen/2;
   S1=sec;
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 658f5f3..105329d 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -241,7 +241,7 @@ x509_get_serial (openvpn_x509_cert_t *cert, struct gc_arena *gc)
 unsigned char *
 x509_get_sha1_hash (X509 *cert, struct gc_arena *gc)
 {
-  char *hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
+  char *hash = gc_malloc(SHA_DIGEST_LENGTH, gc);
   memcpy(hash, cert->sha1_hash, SHA_DIGEST_LENGTH);
   return hash;
 }
@@ -260,7 +260,7 @@ x509_get_subject (X509 *cert, struct gc_arena *gc)
    */
   if (compat_flag (COMPAT_FLAG_QUERY | COMPAT_NAMES))
     {
-      subject = gc_malloc (256, false, gc);
+      subject = gc_malloc (256, gc);
       X509_NAME_oneline (X509_get_subject_name (cert), subject, 256);
       subject[255] = '\0';
       return subject;
@@ -280,7 +280,7 @@ x509_get_subject (X509 *cert, struct gc_arena *gc)
   BIO_get_mem_ptr (subject_bio, &subject_mem);
 
   maxlen = subject_mem->length + 1;
-  subject = gc_malloc (maxlen, false, gc);
+  subject = gc_malloc (maxlen, gc);
 
   memcpy (subject, subject_mem->data, maxlen);
   subject[maxlen - 1] = '\0';
diff --git a/src/openvpn/ssl_verify_polarssl.c b/src/openvpn/ssl_verify_polarssl.c
index 5db4f02..e267634 100644
--- a/src/openvpn/ssl_verify_polarssl.c
+++ b/src/openvpn/ssl_verify_polarssl.c
@@ -130,7 +130,7 @@ x509_get_serial (x509_cert *cert, struct gc_arena *gc)
   char *buf = NULL;
   size_t len = cert->serial.len * 3 + 1;
 
-  buf = gc_malloc(len, true, gc);
+  buf = gc_malloc(len, gc);
 
   if(x509parse_serial_gets(buf, len-1, &cert->serial) < 0)
     buf = NULL;
@@ -141,7 +141,7 @@ x509_get_serial (x509_cert *cert, struct gc_arena *gc)
 unsigned char *
 x509_get_sha1_hash (x509_cert *cert, struct gc_arena *gc)
 {
-  unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, false, gc);
+  unsigned char *sha1_hash = gc_malloc(SHA_DIGEST_LENGTH, gc);
   sha1(cert->tbs.p, cert->tbs.len, sha1_hash);
   return sha1_hash;
 }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 9f53b23..ea2d102 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3196,7 +3196,7 @@ get_panel_reg (struct gc_arena *gc)
 
 	      ALLOC_OBJ_CLEAR_GC (reg, struct panel_reg, gc);
               n = WideCharToMultiByte (CP_UTF8, 0, name_data, -1, NULL, 0, NULL, NULL);
-              name = gc_malloc (n, false, gc);
+              name = gc_malloc (n, gc);
               WideCharToMultiByte (CP_UTF8, 0, name_data, -1, name, n, NULL, NULL);
               reg->name = name;
 	      reg->guid = string_alloc (enum_name, gc);
@@ -3535,7 +3535,7 @@ get_adapter_info_list (struct gc_arena *gc)
     }
   else
     {
-      pi = (PIP_ADAPTER_INFO) gc_malloc (size, false, gc);
+      pi = (PIP_ADAPTER_INFO) gc_malloc (size, gc);
       if ((status = GetAdaptersInfo (pi, &size)) == NO_ERROR)
 	return pi;
       else
@@ -3565,7 +3565,7 @@ get_per_adapter_info (const DWORD index, struct gc_arena *gc)
 	}
       else
 	{
-	  pi = (PIP_PER_ADAPTER_INFO) gc_malloc (size, false, gc);
+	  pi = (PIP_PER_ADAPTER_INFO) gc_malloc (size, gc);
 	  if ((status = GetPerAdapterInfo ((ULONG)index, pi, &size)) == ERROR_SUCCESS)
 	    return pi;
 	  else
@@ -3594,7 +3594,7 @@ get_interface_info_list (struct gc_arena *gc)
     }
   else
     {
-      ii = (PIP_INTERFACE_INFO) gc_malloc (size, false, gc);
+      ii = (PIP_INTERFACE_INFO) gc_malloc (size, gc);
       if ((status = GetInterfaceInfo (ii, &size)) == NO_ERROR)
 	return ii;
       else
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 022eec5..ce23469 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -829,7 +829,7 @@ wide_cmd_line (const struct argv *a, struct gc_arena *gc)
 	maxlen = len;
     }
 
-  work = gc_malloc (maxlen + 1, false, gc);
+  work = gc_malloc (maxlen + 1, gc);
   check_malloc_return (work);
   buf = alloc_buf_gc (nchars, gc);
 
@@ -917,7 +917,7 @@ WCHAR *
 wide_string (const char* utf8, struct gc_arena *gc)
 {
   int n = MultiByteToWideChar (CP_UTF8, 0, utf8, -1, NULL, 0);
-  WCHAR *ucs16 = gc_malloc (n * sizeof (WCHAR), false, gc);
+  WCHAR *ucs16 = gc_malloc (n * sizeof (WCHAR), gc);
   MultiByteToWideChar (CP_UTF8, 0, utf8, -1, ucs16, n);
   return ucs16;
 }
-- 
1.8.3.1


