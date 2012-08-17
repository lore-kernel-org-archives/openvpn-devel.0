From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 17 Aug 2012 15:49:15 +0200
Message-ID: <1345211355-26513-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] add --compat-names option
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

With this option, users can basically undo the changes of the UTF-8
support commit 5e86fd93779482b90a191f929edebe414cd78a4f. It's here for
short term compatibility and should be removed again as soon as possible.

When OpenSSL is used, the subject strings will be in the proprietary
format again. Generally username, X.509 CN, and X.509 subject will again
be subject to '_' replacemant, unless the "no-remapping" flag is
also specified. That flag ensures compatibility with setups using the
--no-name-remapping option, that has been removed in 2.3.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 doc/openvpn.8                    |   22 ++++++++++++++++
 src/openvpn/misc.c               |   12 +++++++++
 src/openvpn/misc.h               |    6 +++++
 src/openvpn/options.c            |   10 +++++++
 src/openvpn/ssl_verify.c         |   53 +++++++++++++++++++++++++++++++-------
 src/openvpn/ssl_verify_openssl.c |   12 +++++++++
 6 files changed, 106 insertions(+), 9 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 56be29e..73f3bdf 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3395,6 +3395,28 @@ the authenticated username as the common name,
 rather than the common name from the client cert.
 .\"*********************************************************
 .TP
+.B \-\-compat-names [no-remapping]
+Format usernames, X.509 Common Name and Subject as versions before OpenVPN 2.3
+did.  This option will be removed again in the future and exists solely to
+ease the transition from the proprietary OpenSSL format, in which OpenVPN
+additionally replaced some octets with underscores, to the naming scheme
+complying to RFC 2253.
+
+With this option, OpenVPN will remap any character other than alphanumeric,
+underacore ('_'), dash ('-'), dot ('.'), and slash ('/') to underscore ('_').
+The X509 Subject string as returned by the
+.B tls_id
+environmental variable, can additionally contain colon (':') or equal ('=').
+
+In
+.B no-remapping
+mode the Common Name, Subject, and username strings are allowed to include
+any printable character including space, but excluding control characters
+such as tab, newline, and carriage-return. It ensures compatibility with the
+.B \-\-no-name-remapping
+option of previous versions.
+.\"*********************************************************
+.TP
 .B \-\-port-share host port [dir]
 When run in TCP server mode, share the OpenVPN port with
 another application, such as an HTTPS server.  If OpenVPN
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 7f72939..a5d98cc 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -2120,3 +2120,15 @@ sanitize_control_message(const char *src, struct gc_arena *gc)
   *dest = '\0';
   return ret;
 }
+
+bool
+compat_flag (unsigned int flag)
+{
+  static unsigned int compat_flags = 0;
+
+  if (flag & COMPAT_FLAG_SET)
+    compat_flags |= (flag >> 1);
+
+  return (compat_flags & (flag >> 1));
+
+}
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index d4c8e33..a8c93ff 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -368,4 +368,10 @@ void argv_printf_cat (struct argv *a, const char *format, ...)
 #endif
   ;
 
+#define COMPAT_FLAG_QUERY         0
+#define COMPAT_FLAG_SET           (1<<0)
+#define COMPAT_NAMES              (1<<1)
+#define COMPAT_NO_NAME_REMAPPING  (1<<2)
+bool compat_flag (unsigned int flag);
+
 #endif
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 19690e1..62a7fc6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2131,6 +2131,9 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 
       if (options->stale_routes_check_interval)
         msg (M_USAGE, "--stale-routes-check requires --mode server");
+
+      if (compat_flag (COMPAT_FLAG_QUERY | COMPAT_NO_NAME_REMAPPING))
+        msg (M_USAGE, "--compat-x509-names no-remapping requires --mode server");
     }
 #endif /* P2MP_SERVER */
 
@@ -5526,6 +5529,13 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->ssl_flags |= SSLF_AUTH_USER_PASS_OPTIONAL;
     }
+  else if (streq (p[0], "compat-names"))
+    {
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
+      if (p[1] && streq (p[1], "no-remapping"))
+        compat_flag (COMPAT_FLAG_SET | COMPAT_NO_NAME_REMAPPING);
+    }
   else if (streq (p[0], "opt-verify"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 30fb05d..203d487 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -49,6 +49,21 @@
 /** Maximum length of common name */
 #define TLS_USERNAME_LEN 64
 
+/** Legal characters in an X509 name with --compat-names */
+#define X509_NAME_CHAR_CLASS   (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_SLASH|CC_COLON|CC_EQUAL)
+
+/** Legal characters in a common name with --compat-names */
+#define COMMON_NAME_CHAR_CLASS (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_SLASH)
+
+static void
+string_mod_remap_name (char *str, const unsigned int restrictive_flags)
+{
+  if (compat_flag (COMPAT_NAMES) && !compat_flag (COMPAT_NO_NAME_REMAPPING))
+    string_mod (str, restrictive_flags, 0, '_');
+  else
+    string_mod (str, CC_PRINT, CC_CRLF, '_');
+}
+
 /*
  * Export the untrusted IP address and port to the environment
  */
@@ -591,7 +606,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     }
 
   /* enforce character class restrictions in X509 name */
-  string_mod (subject, CC_PRINT, CC_CRLF, '_');
+  string_mod_remap_name (subject, X509_NAME_CHAR_CLASS);
   string_replace_leading (subject, '-', '_');
 
   /* extract the username (default is CN) */
@@ -611,7 +626,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     }
 
   /* enforce character class restrictions in common name */
-  string_mod (common_name, CC_PRINT, CC_CRLF, '_');
+  string_mod_remap_name (common_name, COMMON_NAME_CHAR_CLASS);
 
   /* warn if cert chain is too deep */
   if (cert_depth >= MAX_CERT_DEPTH)
@@ -1003,7 +1018,7 @@ verify_user_pass_script (struct tls_session *session, const struct user_pass *up
  * Verify the username and password using a plugin
  */
 static int
-verify_user_pass_plugin (struct tls_session *session, const struct user_pass *up)
+verify_user_pass_plugin (struct tls_session *session, const struct user_pass *up, const char *raw_username)
 {
   int retval = OPENVPN_PLUGIN_FUNC_ERROR;
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
@@ -1012,7 +1027,7 @@ verify_user_pass_plugin (struct tls_session *session, const struct user_pass *up
   if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen (up->username))
     {
       /* set username/password in private env space */
-      setenv_str (session->opt->es, "username", up->username);
+      setenv_str (session->opt->es, "username", (raw_username ? raw_username : up->username));
       setenv_str (session->opt->es, "password", up->password);
 
       /* setenv incoming cert common name for script */
@@ -1036,6 +1051,8 @@ verify_user_pass_plugin (struct tls_session *session, const struct user_pass *up
 #endif
 
       setenv_del (session->opt->es, "password");
+      if (raw_username)
+        setenv_str (session->opt->es, "username", up->username);
     }
   else
     {
@@ -1056,7 +1073,7 @@ verify_user_pass_plugin (struct tls_session *session, const struct user_pass *up
 #define KMDA_DEF     3
 
 static int
-verify_user_pass_management (struct tls_session *session, const struct user_pass *up)
+verify_user_pass_management (struct tls_session *session, const struct user_pass *up, const char *raw_username)
 {
   int retval = KMDA_ERROR;
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
@@ -1065,7 +1082,7 @@ verify_user_pass_management (struct tls_session *session, const struct user_pass
   if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen (up->username))
     {
       /* set username/password in private env space */
-      setenv_str (session->opt->es, "username", up->username);
+      setenv_str (session->opt->es, "username", (raw_username ? raw_username : up->username));
       setenv_str (session->opt->es, "password", up->password);
 
       /* setenv incoming cert common name for script */
@@ -1078,6 +1095,8 @@ verify_user_pass_management (struct tls_session *session, const struct user_pass
 	management_notify_client_needing_auth (management, ks->mda_key_id, session->opt->mda_context, session->opt->es);
 
       setenv_del (session->opt->es, "password");
+      if (raw_username)
+        setenv_str (session->opt->es, "username", up->username);
 
       retval = KMDA_SUCCESS;
     }
@@ -1101,6 +1120,9 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
   bool s2 = true;
   struct key_state *ks = &session->key[KS_PRIMARY]; 	   /* primary key */
 
+  struct gc_arena gc = gc_new ();
+  char *raw_username = NULL;
+
 #ifdef MANAGEMENT_DEF_AUTH
   int man_def_auth = KMDA_UNDEF;
 
@@ -1108,17 +1130,28 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     man_def_auth = KMDA_DEF;
 #endif
 
+  /*
+   * Preserve the raw username before string_mod remapping, for plugins
+   * and management clients when in --compat-names mode
+   */
+  if (compat_flag (COMPAT_NAMES))
+    {
+      ALLOC_ARRAY_CLEAR_GC (raw_username, char, USER_PASS_LEN, &gc);
+      strcpy (raw_username, up->username);
+      string_mod (raw_username, CC_PRINT, CC_CRLF, '_');
+    }
+
   /* enforce character class restrictions in username/password */
-  string_mod (up->username, CC_PRINT, CC_CRLF, '_');
+  string_mod_remap_name (up->username, COMMON_NAME_CHAR_CLASS);
   string_mod (up->password, CC_PRINT, CC_CRLF, '_');
 
   /* call plugin(s) and/or script */
 #ifdef MANAGEMENT_DEF_AUTH
   if (man_def_auth == KMDA_DEF)
-    man_def_auth = verify_user_pass_management (session, up);
+    man_def_auth = verify_user_pass_management (session, up, raw_username);
 #endif
   if (plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
-    s1 = verify_user_pass_plugin (session, up);
+    s1 = verify_user_pass_plugin (session, up, raw_username);
   if (session->opt->auth_user_pass_verify_script)
     s2 = verify_user_pass_script (session, up);
 
@@ -1167,6 +1200,8 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     {
       msg (D_TLS_ERRORS, "TLS Auth Error: Auth Username/Password verification failed for peer");
     }
+
+  gc_free (&gc);
 }
 
 void
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index f5dce0d..30f88a1 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -254,6 +254,18 @@ x509_get_subject (X509 *cert, struct gc_arena *gc)
   char *subject = NULL;
   int maxlen = 0;
 
+  /*
+   * Generate the subject string in OpenSSL proprietary format,
+   * when in --compat-names mode
+   */
+  if (compat_flag (COMPAT_NAMES))
+    {
+      subject = gc_malloc (256, false, gc);
+      X509_NAME_oneline (X509_get_subject_name (cert), subject, 256);
+      subject[255] = '\0';
+      return subject;
+    }
+
   subject_bio = BIO_new (BIO_s_mem ());
   if (subject_bio == NULL)
     goto err;
-- 
1.7.9.5


