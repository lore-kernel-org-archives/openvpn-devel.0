From: Gert Doering <gert@...1296...>
Date: Sun,  5 May 2013 14:36:13 +0200
Message-Id: <1367757373-31637-1-git-send-email-gert@...1296...>
In-Reply-To: <1366483371-5202-1-git-send-email-gert@...1296...>
References: <1366483371-5202-1-git-send-email-gert@...1296...>
Subject: [Openvpn-devel] [PATCH v3] Make push-peer-info visible in "normal"
	per-instance environment.
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

Without this patch, peer-info pushed by clients in the TLS handshake
is only visible on the management interface, and only if
--management-client-auth is enabled.

With this patch, received records are sanitized and put into the normal
"multi instance" environment, where it can be evaluated by --client-connect
or --auth-user-pass-verify scripts and plugins, etc.  Only records matching
a fairly strict "name=value" format are accepted, and only names starting
with IV_ or UV_ are exported, to avoid clients sending funny stuff and
playing havoc with script/plugin environments on the server.  In the
"value" part, spaces, non-printable characters and shell metacharacters
are replaced by '_'.

The change is somewhat invasive as reception of the peer_info string was
only done when username+password are expected from the client, but the
data is always there (if the client sends no username/password, it will
send 0-length strings, so always extracting 3 strings is safe).  Also,
the sanitation function validate_peer_info_line() and the opts->peer_info
field were only compiled in #ifdef MANGEMENT_DEF_AUTH...

Patch v3: do not call the old man_output_peer_info_env() anymore, unless
a management env-filter has been set (= ensure IV_ and UV_ stuff is sent
at most *once*, and exactly the way OpenVPN AS expects it).  Add
substituting of "bad" characters in the environment values.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/manage.c     | 30 ++--------------------------
 src/openvpn/multi.c      | 52 ++++++++++++++++++++++++++++++++++++++++++++++++
 src/openvpn/multi.h      |  3 +++
 src/openvpn/ssl.c        | 35 ++++++++++++++++++++------------
 src/openvpn/ssl_common.h |  8 +++++---
 5 files changed, 84 insertions(+), 44 deletions(-)

diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 5d2c36c..74de1e1 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -2462,33 +2462,6 @@ management_notify_generic (struct management *man, const char *str)
 
 #ifdef MANAGEMENT_DEF_AUTH
 
-static bool
-validate_peer_info_line(const char *line)
-{
-  uint8_t c;
-  int state = 0;
-  while ((c=*line++))
-    {
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
-	  if (isprint(c))
-	    ;
-	  else
-	    return false;
-	}
-    }
-  return (state == 2);
-}
-
 static void
 man_output_peer_info_env (struct management *man, struct man_def_auth_context *mdac)
 {
@@ -2527,7 +2500,8 @@ management_notify_client_needing_auth (struct management *management,
 	mode = "REAUTH";
       msg (M_CLIENT, ">CLIENT:%s,%lu,%u", mode, mdac->cid, mda_key_id);
       man_output_extra_env (management, "CLIENT");
-      man_output_peer_info_env(management, mdac);
+      if (management->connection.env_filter_level>0)
+        man_output_peer_info_env(management, mdac);
       man_output_env (es, true, management->connection.env_filter_level, "CLIENT");
       mdac->flags |= DAF_INITIAL_AUTH;
     }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index f016b14..50f398d 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1562,6 +1562,58 @@ multi_client_connect_mda (struct multi_context *m,
 
 #endif
 
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
+multi_output_peer_info_env (struct env_set *es, const char * peer_info)
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
 static void
 multi_client_connect_setenv (struct multi_context *m,
 			     struct multi_instance *mi)
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index fc2ffb2..7b97b0d 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -312,6 +312,9 @@ void multi_close_instance_on_signal (struct multi_context *m, struct multi_insta
 void init_management_callback_multi (struct multi_context *m);
 void uninit_management_callback_multi (struct multi_context *m);
 
+bool validate_peer_info_line(char *line);
+void multi_output_peer_info_env (struct env_set *es, const char * peer_info);
+
 /*
  * Return true if our output queue is not full
  */
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 09cf300..30a5116 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1106,6 +1106,8 @@ tls_multi_free (struct tls_multi *multi, bool clear)
 #ifdef MANAGEMENT_DEF_AUTH
   man_def_auth_set_client_reason(multi, NULL);  
 
+#endif
+#ifdef P2MP_SERVER
   free (multi->peer_info);
 #endif
 
@@ -1996,6 +1998,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
 
   struct gc_arena gc = gc_new ();
   char *options;
+  struct user_pass *up;
 
   /* allocate temporary objects */
   ALLOC_ARRAY_CLEAR_GC (options, char, TLS_OPTIONS_LEN, &gc);
@@ -2031,15 +2034,25 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
 
   ks->authenticated = false;
 
+  /* always extract username + password fields from buf, even if not
+   * authenticating for it, because otherwise we can't get at the
+   * peer_info data which follows behind
+   */
+  ALLOC_OBJ_CLEAR_GC (up, struct user_pass, &gc);
+  username_status = read_string (buf, up->username, USER_PASS_LEN);
+  password_status = read_string (buf, up->password, USER_PASS_LEN);
+
+#ifdef P2MP_SERVER
+  /* get peer info from control channel */
+  free (multi->peer_info);
+  multi->peer_info = read_string_alloc (buf);
+  if ( multi->peer_info )
+      multi_output_peer_info_env (session->opt->es, multi->peer_info);
+#endif
+
   if (verify_user_pass_enabled(session))
     {
       /* Perform username/password authentication */
-      struct user_pass *up;
-
-      ALLOC_OBJ_CLEAR_GC (up, struct user_pass, &gc);
-      username_status = read_string (buf, up->username, USER_PASS_LEN);
-      password_status = read_string (buf, up->password, USER_PASS_LEN);
-
       if (!username_status || !password_status)
 	{
 	  CLEAR (*up);
@@ -2050,14 +2063,7 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
 	    }
 	}
 
-#ifdef MANAGEMENT_DEF_AUTH
-      /* get peer info from control channel */
-      free (multi->peer_info);
-      multi->peer_info = read_string_alloc (buf);
-#endif
-
       verify_user_pass(up, multi, session);
-      CLEAR (*up);
     }
   else
     {
@@ -2071,6 +2077,9 @@ key_method_2_read (struct buffer *buf, struct tls_multi *multi, struct tls_sessi
       ks->authenticated = true;
     }
 
+  /* clear username and password from memory */
+  CLEAR (*up);
+
   /* Perform final authentication checks */
   if (ks->authenticated)
     {
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index c62294f..f388052 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -476,14 +476,16 @@ struct tls_multi
    */
   char *client_reason;
 
+  /* Time of last call to tls_authentication_status */
+  time_t tas_last;
+#endif
+
+#ifdef P2MP_SERVER
   /*
    * A multi-line string of general-purpose info received from peer
    * over control channel.
    */
   char *peer_info;
-
-  /* Time of last call to tls_authentication_status */
-  time_t tas_last;
 #endif
 
   /*
-- 
1.8.1.5


