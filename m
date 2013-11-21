From: David Sommerseth <dazo@...384...>
Date: Thu, 21 Nov 2013 18:02:10 +0100
Message-Id: <1385053332-14533-3-git-send-email-dazo@...384...>
In-Reply-To: <1385053332-14533-1-git-send-email-dazo@...384...>
References: <1385053332-14533-1-git-send-email-dazo@...384...>
Subject: [Openvpn-devel] [PATCH 2/4] Change from malloc() to calloc() where
	it can be beneficial
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

This is a continuation of the malloc() -> calloc() change started in
gc_malloc().  This is simply to to small steps to ensure memory
allocations are cleared and in a sane state.

Not all places should make use of calloc() as they can benefit
from having some randomness around itself if the complete buffer
isn't used.  This goes particular for the crypto and PRNG functions.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/base64.c             | 2 +-
 src/openvpn/buffer.c             | 6 +++---
 src/openvpn/circ_list.h          | 2 +-
 src/openvpn/console.c            | 2 +-
 src/openvpn/crypto.c             | 2 +-
 src/openvpn/manage.c             | 2 +-
 src/openvpn/misc.c               | 8 ++++----
 src/openvpn/openvpn.c            | 2 +-
 src/openvpn/ps.c                 | 6 +++---
 src/openvpn/ssl.c                | 2 +-
 src/openvpn/ssl_verify_openssl.c | 4 ++--
 src/openvpn/tun.c                | 2 +-
 src/openvpn/win32.c              | 2 +-
 13 files changed, 21 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index bb89aae..a35e36d 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -62,7 +62,7 @@ openvpn_base64_encode(const void *data, int size, char **str)
 
     if (size < 0)
 	return -1;
-    p = s = (char *) malloc(size * 4 / 3 + 4);
+    p = s = (char *) calloc(1, size * 4 / 3 + 4);
     if (p == NULL)
 	return -1;
     q = (const unsigned char *) data;
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 096d1fa..cd8d397 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -115,7 +115,7 @@ clone_buf (const struct buffer* buf)
 #ifdef DMALLOC
   ret.data = (uint8_t *) openvpn_dmalloc (file, line, buf->capacity);
 #else
-  ret.data = (uint8_t *) malloc (buf->capacity);
+  ret.data = (uint8_t *) calloc (1, buf->capacity);
 #endif
   check_malloc_return (ret.data);
   memcpy (BPTR (&ret), BPTR (buf), BLEN (buf));
@@ -1048,7 +1048,7 @@ buffer_list_aggregate (struct buffer_list *bl, const size_t max)
 	  struct buffer_entry *e = bl->head, *f;
 
 	  ALLOC_OBJ_CLEAR (f, struct buffer_entry);
-	  f->buf.data = malloc (size);
+	  f->buf.data = calloc (1, size);
 	  check_malloc_return (f->buf.data);
 	  f->buf.capacity = size;
 	  for (i = 0; e && i < count; ++i)
@@ -1102,7 +1102,7 @@ buffer_list_file (const char *fn, int max_line_len)
 
   if (fp)
     {
-      char *line = (char *) malloc (max_line_len);
+      char *line = (char *) calloc (1, max_line_len);
       if (line)
 	{
 	  bl = buffer_list_new (0);
diff --git a/src/openvpn/circ_list.h b/src/openvpn/circ_list.h
index 583701a..ba6bb9d 100644
--- a/src/openvpn/circ_list.h
+++ b/src/openvpn/circ_list.h
@@ -65,7 +65,7 @@ struct name { \
 #define CIRC_LIST_ALLOC(dest, list_type, size) \
 { \
   const int so = sizeof (list_type) + sizeof ((dest)->x_list[0]) * (size); \
-  (dest) = (list_type *) malloc (so); \
+  (dest) = (list_type *) calloc (1, so);                               \
   check_malloc_return (dest); \
   memset ((dest), 0, so); \
   (dest)->x_cap = size; \
diff --git a/src/openvpn/console.c b/src/openvpn/console.c
index afda8ca..d94dff9 100644
--- a/src/openvpn/console.c
+++ b/src/openvpn/console.c
@@ -86,7 +86,7 @@ get_console_input_win32 (const char *prompt, const bool echo, char *input, const
 
       if (is_console)
         {
-          winput = malloc (capacity * sizeof (WCHAR));
+          winput = calloc (1, capacity * sizeof (WCHAR));
           if (winput == NULL)
             return false;
 
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index c4c356d..3507b53 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -1334,7 +1334,7 @@ prng_init (const char *md_name, const int nonce_secret_len_parm)
       {
 	const int size = md_kt_size(nonce_md) + nonce_secret_len;
 	dmsg (D_CRYPTO_DEBUG, "PRNG init md=%s size=%d", md_kt_name(nonce_md), size);
-	nonce_data = (uint8_t*) malloc (size);
+	nonce_data = (uint8_t*) malloc (size);  /* Avoid using cleared memory when handling PRNG data */
 	check_malloc_return (nonce_data);
 	prng_reset_nonce();
       }
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 74de1e1..9c40fbe 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -3105,7 +3105,7 @@ management_query_rsa_sig (struct management *man,
 	  buf = buffer_list_peek (mc->ext_key_input);
 	  if (buf && BLEN(buf) > 0)
 	    {
-	      ret = (char *) malloc(BLEN(buf)+1);
+	      ret = (char *) calloc(1, BLEN(buf)+1);
 	      check_malloc_return(ret);
 	      memcpy(ret, buf->data, BLEN(buf));
 	      ret[BLEN(buf)] = '\0';
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 1175ff4..2132649 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -1619,7 +1619,7 @@ argv_system_str_append (struct argv *a, const char *str, const bool enquote)
 	l += 2; /* space for two quotes */
 
       /* build new system_str */
-      newstr = (char *) malloc (l);
+      newstr = (char *) calloc (1, l);
       newstr[0] = '\0';
       check_malloc_return (newstr);
       if (a->system_str)
@@ -1738,7 +1738,7 @@ argv_term (const char **f)
     {
       char *ret;
       ASSERT (termlen > 0);
-      ret = malloc (termlen + 1);
+      ret = calloc (1, termlen + 1);
       check_malloc_return (ret);
       memcpy (ret, term, termlen);
       ret[termlen] = '\0';
@@ -1866,7 +1866,7 @@ argv_printf_arglist (struct argv *a, const char *format, const unsigned int flag
 
 	      {
 		const size_t len = strlen(s) + strlen(numstr) + 2;
-		char *combined = (char *) malloc (len);
+		char *combined = (char *) calloc (1, len);
 		check_malloc_return (combined);
 
 		strcpy (combined, s);
@@ -1885,7 +1885,7 @@ argv_printf_arglist (struct argv *a, const char *format, const unsigned int flag
 
 	      if (!s1) s1 = "";
 	      if (!s2) s2 = "";
-	      combined = (char *) malloc (strlen(s1) + strlen(s2) + 1);
+	      combined = (char *) calloc (1, strlen(s1) + strlen(s2) + 1);
 	      check_malloc_return (combined);
 	      strcpy (combined, s1);
 	      strcat (combined, s2);
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 5125eae..60b1fb7 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -304,7 +304,7 @@ wmain (int argc, wchar_t *wargv[]) {
   for (i = 0; i < argc; i++)
     {
       int n = WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, NULL, 0, NULL, NULL);
-      argv[i] = malloc (n);
+      argv[i] = calloc (1, n);
       WideCharToMultiByte (CP_UTF8, 0, wargv[i], -1, argv[i], n, NULL, NULL);
     }
 
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 6495dc7..f6b5212 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -212,7 +212,7 @@ port_share_sendmsg (const socket_descriptor_t sd,
       mesg.msg_iov = iov;
 
       mesg.msg_controllen = cmsg_size ();
-      mesg.msg_control = (char *) malloc (mesg.msg_controllen);
+      mesg.msg_control = (char *) calloc (1, mesg.msg_controllen);
       check_malloc_return (mesg.msg_control);
       mesg.msg_flags = 0;
 
@@ -333,7 +333,7 @@ journal_add (const char *journal_dir, struct proxy_connection *pc, struct proxy_
       const char *f = print_sockaddr_ex (&from, ":", PS_SHOW_PORT, &gc);
       const char *t = print_sockaddr_ex (&to, ":", PS_SHOW_PORT, &gc);
       fnlen =  strlen(journal_dir) + strlen(t) + 2;
-      jfn = (char *) malloc(fnlen);
+      jfn = (char *) calloc(1, fnlen);
       check_malloc_return (jfn);
       openvpn_snprintf (jfn, fnlen, "%s/%s", journal_dir, t);
       dmsg (D_PS_PROXY_DEBUG, "PORT SHARE PROXY: client origin %s -> %s", jfn, f);
@@ -508,7 +508,7 @@ control_message_from_parent (const socket_descriptor_t sd_control,
   mesg.msg_iovlen = 2;
 
   mesg.msg_controllen = cmsg_size ();
-  mesg.msg_control = (char *) malloc (mesg.msg_controllen);
+  mesg.msg_control = (char *) calloc (1, mesg.msg_controllen);
   check_malloc_return (mesg.msg_control);
   mesg.msg_flags = 0;
 
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 35e5bfb..7ceb79b 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1719,7 +1719,7 @@ read_string_alloc (struct buffer *buf)
 
   if (len < 1)
     return NULL;
-  str = (char *) malloc(len);
+  str = (char *) calloc(1, len);
   check_malloc_return(str);
   if (!buf_read (buf, str, len))
     {
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index 105329d..176669f 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -326,7 +326,7 @@ do_setenv_x509 (struct env_set *es, const char *name, char *value, int depth)
   string_mod (value, CC_ANY, CC_CRLF, '?');
   msg (D_X509_ATTR, "X509 ATTRIBUTE name='%s' value='%s' depth=%d", name, value, depth);
   name_expand_size = 64 + strlen (name);
-  name_expand = (char *) malloc (name_expand_size);
+  name_expand = (char *) calloc (1, name_expand_size);
   check_malloc_return (name_expand);
   openvpn_snprintf (name_expand, name_expand_size, "X509_%d_%s", depth, name);
   setenv_str (es, name_expand, value);
@@ -432,7 +432,7 @@ x509_setenv (struct env_set *es, int cert_depth, openvpn_x509_cert_t *peer_cert)
       if (ASN1_STRING_to_UTF8 (&buf, val) <= 0)
 	continue;
       name_expand_size = 64 + strlen (objbuf);
-      name_expand = (char *) malloc (name_expand_size);
+      name_expand = (char *) calloc (1, name_expand_size);
       check_malloc_return (name_expand);
       openvpn_snprintf (name_expand, name_expand_size, "X509_%d_%s", cert_depth,
 	  objbuf);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index ea2d102..de7ccb9 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1945,7 +1945,7 @@ open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tu
     msg (M_ERR, "Can't set PPA %d", ppa);
     }
 
-  tt->actual_name = (char *) malloc (32);
+  tt->actual_name = (char *) calloc (1, 32);
   check_malloc_return (tt->actual_name);
 
   openvpn_snprintf (tt->actual_name, 32, "%s%d", dev_tuntap_type, ppa);
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index ce23469..63cf34e 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -778,7 +778,7 @@ env_block (const struct env_set *es)
 
       nchars += strlen(force_path)+1;
 
-      ret = (char *) malloc (nchars);
+      ret = (char *) calloc (1, nchars);
       check_malloc_return (ret);
 
       p = ret;
-- 
1.8.3.1


