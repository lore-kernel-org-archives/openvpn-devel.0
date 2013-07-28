From: James Yonan <james@...515...>
Date: Sun, 28 Jul 2013 16:05:35 -0600
Message-Id: <1375049135-21444-1-git-send-email-james@...515...>
Subject: [Openvpn-devel] [PATCH] MSVC fixes
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
Cc: James Yonan <james@...515...>

Fixes to allow compilation with Microsoft Visual Studio 2008

* Fixed several instances of declarations after statements.

* In socket.c, fixed issue where uninitialized value (err)
  is being passed to to gai_strerror.

* ssl.c is trying to access multi_output_peer_info_env
  function in multi.c, causing an undefined symbol warning
  at compile time.  ssl.c is strictly a client of multi.c
  (but not the other way around), therefore ssl.c does not
  include multi.h and should not depend on multi.h API.  To
  fix, moved validate_peer_info_line and multi_output_peer_info_env
  from multi.c to misc.c.

* MSVC doesn't support %z as a printf format specifier for size_t

* MSVC doesn't support a const variable being used to dimension
  an array.

* Explicitly cast the third parameter to setsockopt to
  const void *
---
 src/openvpn/init.c        |   10 ++++----
 src/openvpn/misc.c        |   56 +++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/misc.h        |    7 ++++++
 src/openvpn/multi.c       |   52 -----------------------------------------
 src/openvpn/multi.h       |    3 ---
 src/openvpn/socket.c      |    5 ++--
 src/openvpn/socket.h      |    2 +-
 src/openvpn/ssl.c         |    2 +-
 src/openvpn/ssl_openssl.c |    7 +++---
 src/openvpn/win32.c       |    6 ++---
 10 files changed, 79 insertions(+), 71 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index fb14726..031fb20 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -183,10 +183,12 @@ ce_management_query_proxy (struct context *c)
   if (management)
     {
       gc = gc_new ();
-      struct buffer out = alloc_buf_gc (256, &gc);
-      buf_printf (&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
-                  (proto_is_udp (ce->proto) ? "UDP" : "TCP"), np (ce->remote));
-      management_notify_generic (management, BSTR (&out));
+      {
+	struct buffer out = alloc_buf_gc (256, &gc);
+	buf_printf (&out, ">PROXY:%u,%s,%s", (l ? l->current : 0) + 1,
+		    (proto_is_udp (ce->proto) ? "UDP" : "TCP"), np (ce->remote));
+	management_notify_generic (management, BSTR (&out));
+      }
       ce->flags |= CE_MAN_QUERY_PROXY;
       while (ce->flags & CE_MAN_QUERY_PROXY)
         {
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 1120adc..4688444 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -2063,3 +2063,59 @@ compat_flag (unsigned int flag)
   return (compat_flags & (flag >> 1));
 
 }
+
+#if P2MP_SERVER
+
+/* helper to parse peer_info received from multi client, validate
+ * (this is untrusted data) and put into environment
+ */
+bool
+validate_peer_info_line(char *line)
+{
+  uint8_t c;
+  int state = 0;
+  while (*line)
+    {
+      c = *line;
+      switch (state)
+	{
+	case 0:
+	case 1:
+	  if (c == '=' && state == 1)
+	    state = 2;
+	  else if (isalnum(c) || c == '_')
+	    state = 1;
+	  else
+	    return false;
+	case 2:
+	  /* after the '=', replace non-printable or shell meta with '_' */
+	  if (!isprint(c) || isspace(c) ||
+	       c == '$' || c == '(' || c == '`' )
+	    *line = '_';
+	}
+      line++;
+    }
+  return (state == 2);
+}
+
+void
+output_peer_info_env (struct env_set *es, const char * peer_info)
+{
+  char line[256];
+  struct buffer buf;
+  buf_set_read (&buf, (const uint8_t *) peer_info, strlen(peer_info));
+  while (buf_parse (&buf, '\n', line, sizeof (line)))
+    {
+      chomp (line);
+      if (validate_peer_info_line(line) &&
+            (strncmp(line, "IV_", 3) == 0 || strncmp(line, "UV_", 3) == 0) )
+	{
+	  msg (M_INFO, "peer info: %s", line);
+	  env_set_add(es, line);
+	}
+      else
+	msg (M_WARN, "validation failed on peer_info line received from client");
+    }
+}
+
+#endif /* P2MP_SERVER */
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index 183898e..41748bd 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -369,4 +369,11 @@ void argv_printf_cat (struct argv *a, const char *format, ...)
 #define COMPAT_NO_NAME_REMAPPING  (1<<2)  /** compat flag: --compat-names without char remapping */
 bool compat_flag (unsigned int flag);
 
+#if P2MP_SERVER
+/* helper to parse peer_info received from multi client, validate
+ * (this is untrusted data) and put into environment */
+bool validate_peer_info_line(char *line);
+void output_peer_info_env (struct env_set *es, const char * peer_info);
+#endif /* P2MP_SERVER */
+
 #endif
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 50f398d..f016b14 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1562,58 +1562,6 @@ multi_client_connect_mda (struct multi_context *m,
 
 #endif
 
-/* helper to parse peer_info received from multi client, validate
- * (this is untrusted data) and put into environment
- */
-bool
-validate_peer_info_line(char *line)
-{
-  uint8_t c;
-  int state = 0;
-  while (*line)
-    {
-      c = *line;
-      switch (state)
-	{
-	case 0:
-	case 1:
-	  if (c == '=' && state == 1)
-	    state = 2;
-	  else if (isalnum(c) || c == '_')
-	    state = 1;
-	  else
-	    return false;
-	case 2:
-	  /* after the '=', replace non-printable or shell meta with '_' */
-	  if (!isprint(c) || isspace(c) ||
-	       c == '$' || c == '(' || c == '`' )
-	    *line = '_';
-	}
-      line++;
-    }
-  return (state == 2);
-}
-
-void
-multi_output_peer_info_env (struct env_set *es, const char * peer_info)
-{
-  char line[256];
-  struct buffer buf;
-  buf_set_read (&buf, (const uint8_t *) peer_info, strlen(peer_info));
-  while (buf_parse (&buf, '\n', line, sizeof (line)))
-    {
-      chomp (line);
-      if (validate_peer_info_line(line) &&
-            (strncmp(line, "IV_", 3) == 0 || strncmp(line, "UV_", 3) == 0) )
-	{
-	  msg (M_INFO, "peer info: %s", line);
-	  env_set_add(es, line);
-	}
-      else
-	msg (M_WARN, "validation failed on peer_info line received from client");
-    }
-}
-
 static void
 multi_client_connect_setenv (struct multi_context *m,
 			     struct multi_instance *mi)
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 7b97b0d..fc2ffb2 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -312,9 +312,6 @@ void multi_close_instance_on_signal (struct multi_context *m, struct multi_insta
 void init_management_callback_multi (struct multi_context *m);
 void uninit_management_callback_multi (struct multi_context *m);
 
-bool validate_peer_info_line(char *line);
-void multi_output_peer_info_env (struct env_set *es, const char * peer_info);
-
 /*
  * Return true if our output queue is not full
  */
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 40356a0..3c0a379 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1158,7 +1158,6 @@ resolve_bind_local (struct link_socket *sock)
 	case AF_INET6:
 	    {
 	      int status;
-	      int err;
 	      CLEAR(sock->info.lsa->local.addr.in6);
 	      if (sock->local_host)
 		{
@@ -1181,7 +1180,7 @@ resolve_bind_local (struct link_socket *sock)
 		{
 		  msg (M_FATAL, "getaddr6() failed for local \"%s\": %s",
 		       sock->local_host,
-		       gai_strerror(err));
+		       gai_strerror(status));
 		}
 	      sock->info.lsa->local.addr.in6.sin6_port = htons (sock->local_port);
 	    }
@@ -1235,6 +1234,7 @@ resolve_remote (struct link_socket *sock,
 	      unsigned int flags = sf2gaf(GETADDR_RESOLVE|GETADDR_UPDATE_MANAGEMENT_STATE, sock->sockflags);
 	      int retry = 0;
 	      int status = -1;
+	      struct addrinfo* ai;
 
 	      if (sock->connection_profiles_defined && sock->resolve_retry_seconds == RESOLV_RETRY_INFINITE)
 		{
@@ -1271,7 +1271,6 @@ resolve_remote (struct link_socket *sock,
 		  ASSERT (0);
 		}
 
-		  struct addrinfo* ai;
 		  /* Temporary fix, this need to be changed for dual stack */
 		  status = openvpn_getaddrinfo(flags, sock->remote_host, retry,
 											  signal_received, af, &ai);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 4e7e7f8..793cd9f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -1023,7 +1023,7 @@ static inline void
 link_socket_set_tos (struct link_socket *ls)
 {
   if (ls && ls->ptos_defined)
-    setsockopt (ls->sd, IPPROTO_IP, IP_TOS, &ls->ptos, sizeof (ls->ptos));
+    setsockopt (ls->sd, IPPROTO_IP, IP_TOS, (const void *)&ls->ptos, sizeof (ls->ptos));
 }
 
 #endif
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index e4b802f..69f77f3 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -2062,7 +2062,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
   free (multi->peer_info);
   multi->peer_info = read_string_alloc (buf);
   if ( multi->peer_info )
-      multi_output_peer_info_env (session->opt->es, multi->peer_info);
+      output_peer_info_env (session->opt->es, multi->peer_info);
 #endif
 
   if (verify_user_pass_enabled(session))
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 12c725d..ec76b30 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -242,8 +242,7 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 
   const tls_cipher_name_pair *cipher_pair;
 
-  const size_t openssl_ciphers_size = 4096;
-  char openssl_ciphers[openssl_ciphers_size];
+  char openssl_ciphers[4096];
   size_t openssl_ciphers_len = 0;
   openssl_ciphers[0] = '\0';
 
@@ -282,8 +281,8 @@ tls_ctx_restrict_ciphers(struct tls_root_ctx *ctx, const char *ciphers)
 	}
 
       // Make sure new cipher name fits in cipher string
-      if (((openssl_ciphers_size-1) - openssl_ciphers_len) < current_cipher_len) {
-	msg(M_SSLERR, "Failed to set restricted TLS cipher list, too long (>%zu).", openssl_ciphers_size-1);
+      if (((sizeof(openssl_ciphers)-1) - openssl_ciphers_len) < current_cipher_len) {
+	msg(M_SSLERR, "Failed to set restricted TLS cipher list, too long (>%d).", (int)sizeof(openssl_ciphers)-1);
       }
 
       // Concatenate cipher name to OpenSSL cipher string
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 178e2c3..022eec5 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -870,6 +870,9 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
           WCHAR *cl = wide_cmd_line (a, &gc);
           WCHAR *cmd = wide_string (a->argv[0], &gc);
 
+          /* this allows console programs to run, and is ignored otherwise */
+          DWORD proc_flags = CREATE_NO_WINDOW;
+
           CLEAR (start_info);
           CLEAR (proc_info);
 
@@ -879,9 +882,6 @@ openvpn_execve (const struct argv *a, const struct env_set *es, const unsigned i
           start_info.dwFlags = STARTF_USESHOWWINDOW;
           start_info.wShowWindow = SW_HIDE;
 
-          /* this allows console programs to run, and is ignored otherwise */
-          DWORD proc_flags = CREATE_NO_WINDOW;
-
           if (CreateProcessW (cmd, cl, NULL, NULL, FALSE, proc_flags, env, NULL, &start_info, &proc_info))
             {
               DWORD exit_status = 0;
-- 
1.7.9.5


