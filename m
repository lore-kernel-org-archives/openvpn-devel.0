From: Steffan Karger <steffan.karger@...1435...>
Date: Wed, 24 Oct 2018 12:12:05 +0200
Message-ID: <1540375925-6111-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Remove deprecated --compat-x509-names and
 --no-name-remapping
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

As promised, remove these options for OpenVPN 2.5.

If a user still uses these, print an error that the user should update it's
configuration. Just printing a warning would cause much more confusing
errors, somewhere in middle of a failed connection attempt because the
(non-compat) names no longer match the expected names.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 doc/openvpn.8                    | 71 ----------------------------------------
 src/openvpn/misc.c               | 23 -------------
 src/openvpn/misc.h               |  6 ----
 src/openvpn/options.c            | 43 ++++--------------------
 src/openvpn/ssl_verify.c         | 67 ++++++++-----------------------------
 src/openvpn/ssl_verify_openssl.c | 12 -------
 6 files changed, 21 insertions(+), 201 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 5f8569b..94484ab 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3801,77 +3801,6 @@ the authenticated username as the common name,
 rather than the common name from the client cert.
 .\"*********************************************************
 .TP
-.B \-\-compat\-names [no\-remapping]
-.B DEPRECATED
-This option will be removed in OpenVPN 2.5
-
-Until OpenVPN v2.3 the format of the X.509 Subject fields was formatted
-like this:
-.IP
-.B
-/C=US/L=Somewhere/CN=John Doe/emailAddress=john@...1113...
-.IP
-In addition the old behaviour was to remap any character other than
-alphanumeric, underscore ('_'), dash ('\-'), dot ('.'), and slash ('/') to
-underscore ('_').  The X.509 Subject string as returned by the
-.B tls_id
-environmental variable, could additionally contain colon (':') or equal ('=').
-.IP
-When using the
-.B \-\-compat\-names
-option, this old formatting and remapping will be re\-enabled again.  This is
-purely implemented for compatibility reasons when using older plug\-ins or
-scripts which does not handle the new formatting or UTF\-8 characters.
-.IP
-In OpenVPN 2.3 the formatting of these fields changed into a more
-standardised format.  It now looks like:
-.IP
-.B
-C=US, L=Somewhere, CN=John Doe, emailAddress=john@...1113...
-.IP
-The new default format in OpenVPN 2.3 also does not do the character remapping
-which happened earlier.  This new format enables proper support for UTF\-8
-characters in the usernames, X.509 Subject fields and Common Name variables and
-it complies to the RFC 2253, UTF\-8 String Representation of Distinguished
-Names.
-
-The
-.B no\-remapping
-mode flag can be used with the
-.B
-\-\-compat\-names
-option to be compatible with the now deprecated \-\-no\-name\-remapping option.
-It is only available at the server. When this mode flag is used, the Common Name,
-Subject, and username strings are allowed to include any printable character
-including space, but excluding control characters such as tab, newline, and
-carriage\-return. no\-remapping is only available on the server side.
-
-.B Please note:
-This option is immediately deprecated.  It is only implemented
-to make the transition to the new formatting less intrusive.  It will be
-removed in OpenVPN 2.5.  So please update your scripts/plug\-ins where necessary.
-.\"*********************************************************
-.TP
-.B \-\-no\-name\-remapping
-.B DEPRECATED
-This option will be removed in OpenVPN 2.5
-
-The
-.B \-\-no\-name\-remapping
-option is an alias for
-.B \-\-compat\-names\ no\-remapping.
-It ensures compatibility with server configurations using the
-.B \-\-no\-name\-remapping
-option.
-
-.B Please note:
-This option is now deprecated.  It will be removed in OpenVPN 2.5.
-So please make sure you support the new X.509 name formatting
-described with the
-.B \-\-compat\-names
-option as soon as possible.
-.\"*********************************************************
-.TP
 .B \-\-port\-share host port [dir]
 When run in TCP server mode, share the OpenVPN port with
 another application, such as an HTTPS server.  If OpenVPN
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index d75b768..f5a27dc 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -666,29 +666,6 @@ sanitize_control_message(const char *src, struct gc_arena *gc)
     return ret;
 }
 
-/**
- * Will set or query for a global compat flag.  To modify the compat flags
- * the COMPAT_FLAG_SET must be bitwise ORed together with the flag to set.
- * If no "operator" flag is given it defaults to COMPAT_FLAG_QUERY,
- * which returns the flag state.
- *
- * @param  flag  Flag to be set/queried for bitwise ORed with the operator flag
- * @return Returns 0 if the flag is not set, otherwise the 'flag' value is returned
- */
-bool
-compat_flag(unsigned int flag)
-{
-    static unsigned int compat_flags = 0;
-
-    if (flag & COMPAT_FLAG_SET)
-    {
-        compat_flags |= (flag >> 1);
-    }
-
-    return (compat_flags & (flag >> 1));
-
-}
-
 #if P2MP_SERVER
 
 /* helper to parse peer_info received from multi client, validate
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index a54185f..009425f 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -166,12 +166,6 @@ const char *sanitize_control_message(const char *str, struct gc_arena *gc);
 extern const char *iproute_path;
 #endif
 
-#define COMPAT_FLAG_QUERY         0       /** compat_flags operator: Query for a flag */
-#define COMPAT_FLAG_SET           (1<<0)  /** compat_flags operator: Set a compat flag */
-#define COMPAT_NAMES              (1<<1)  /** compat flag: --compat-names set */
-#define COMPAT_NO_NAME_REMAPPING  (1<<2)  /** compat flag: --compat-names without char remapping */
-bool compat_flag(unsigned int flag);
-
 #if P2MP_SERVER
 /* helper to parse peer_info received from multi client, validate
  * (this is untrusted data) and put into environment */
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5c669e9..8a447aa 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2422,10 +2422,6 @@ options_postprocess_verify_ce(const struct options *options, const struct connec
         {
             msg(M_USAGE, "--stale-routes-check requires --mode server");
         }
-        if (compat_flag(COMPAT_FLAG_QUERY | COMPAT_NO_NAME_REMAPPING))
-        {
-            msg(M_USAGE, "--compat-x509-names no-remapping requires --mode server");
-        }
     }
 #endif /* P2MP_SERVER */
 
@@ -7850,49 +7846,24 @@ add_option(struct options *options,
         options->tls_export_cert = p[1];
     }
 #endif
-#if P2MP_SERVER
-    else if (streq(p[0], "compat-names") && ((p[1] && streq(p[1], "no-remapping")) || !p[1]) && !p[2])
-#else
-    else if (streq(p[0], "compat-names") && !p[1])
-#endif
+    else if (streq(p[0], "compat-names"))
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (options->verify_x509_type != VERIFY_X509_NONE)
-        {
-            msg(msglevel, "you cannot use --compat-names with --verify-x509-name");
-            goto err;
-        }
-        msg(M_WARN, "DEPRECATED OPTION: --compat-names, please update your configuration. This will be removed in OpenVPN 2.5.");
-        compat_flag(COMPAT_FLAG_SET | COMPAT_NAMES);
-#if P2MP_SERVER
-        if (p[1] && streq(p[1], "no-remapping"))
-        {
-            compat_flag(COMPAT_FLAG_SET | COMPAT_NO_NAME_REMAPPING);
-        }
+        msg(msglevel, "--compat-names was removed in OpenVPN 2.5. "
+            "Update your configuration.");
+        goto err;
     }
     else if (streq(p[0], "no-name-remapping") && !p[1])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (options->verify_x509_type != VERIFY_X509_NONE)
-        {
-            msg(msglevel, "you cannot use --no-name-remapping with --verify-x509-name");
-            goto err;
-        }
-        msg(M_WARN, "DEPRECATED OPTION: --no-name-remapping, please update your configuration. This will be removed in OpenVPN 2.5.");
-        compat_flag(COMPAT_FLAG_SET | COMPAT_NAMES);
-        compat_flag(COMPAT_FLAG_SET | COMPAT_NO_NAME_REMAPPING);
-#endif
+        msg(msglevel, "--no-name-remapping was removed in OpenVPN 2.5. "
+            "Update your configuration.");
+        goto err;
     }
     else if (streq(p[0], "verify-x509-name") && p[1] && strlen(p[1]) && !p[3])
     {
         int type = VERIFY_X509_SUBJECT_DN;
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        if (compat_flag(COMPAT_FLAG_QUERY | COMPAT_NAMES))
-        {
-            msg(msglevel, "you cannot use --verify-x509-name with "
-                "--compat-names or --no-name-remapping");
-            goto err;
-        }
         if (p[2])
         {
             if (streq(p[2], "subject"))
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 6187225..03c0b66 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -48,24 +48,10 @@
 /** Maximum length of common name */
 #define TLS_USERNAME_LEN 64
 
-/** Legal characters in an X509 name with --compat-names */
-#define X509_NAME_CHAR_CLASS   (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_SLASH|CC_COLON|CC_EQUAL)
-
-/** Legal characters in a common name with --compat-names */
-#define COMMON_NAME_CHAR_CLASS (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|CC_SLASH)
-
 static void
-string_mod_remap_name(char *str, const unsigned int restrictive_flags)
+string_mod_remap_name(char *str)
 {
-    if (compat_flag(COMPAT_FLAG_QUERY | COMPAT_NAMES)
-        && !compat_flag(COMPAT_FLAG_QUERY | COMPAT_NO_NAME_REMAPPING))
-    {
-        string_mod(str, restrictive_flags, 0, '_');
-    }
-    else
-    {
-        string_mod(str, CC_PRINT, CC_CRLF, '_');
-    }
+    string_mod(str, CC_PRINT, CC_CRLF, '_');
 }
 
 /*
@@ -690,7 +676,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     }
 
     /* enforce character class restrictions in X509 name */
-    string_mod_remap_name(subject, X509_NAME_CHAR_CLASS);
+    string_mod_remap_name(subject);
     string_replace_leading(subject, '-', '_');
 
     /* extract the username (default is CN) */
@@ -710,7 +696,7 @@ verify_cert(struct tls_session *session, openvpn_x509_cert_t *cert, int cert_dep
     }
 
     /* enforce character class restrictions in common name */
-    string_mod_remap_name(common_name, COMMON_NAME_CHAR_CLASS);
+    string_mod_remap_name(common_name);
 
     /* warn if cert chain is too deep */
     if (cert_depth >= MAX_CERT_DEPTH)
@@ -1168,7 +1154,7 @@ done:
  * Verify the username and password using a plugin
  */
 static int
-verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up, const char *raw_username)
+verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up)
 {
     int retval = OPENVPN_PLUGIN_FUNC_ERROR;
 #ifdef PLUGIN_DEF_AUTH
@@ -1179,7 +1165,7 @@ verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up,
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
     {
         /* set username/password in private env space */
-        setenv_str(session->opt->es, "username", (raw_username ? raw_username : up->username));
+        setenv_str(session->opt->es, "username", up->username);
         setenv_str(session->opt->es, "password", up->password);
 
         /* setenv incoming cert common name for script */
@@ -1210,10 +1196,6 @@ verify_user_pass_plugin(struct tls_session *session, const struct user_pass *up,
 #endif
 
         setenv_del(session->opt->es, "password");
-        if (raw_username)
-        {
-            setenv_str(session->opt->es, "username", up->username);
-        }
     }
     else
     {
@@ -1235,7 +1217,7 @@ cleanup:
 #define KMDA_DEF     3
 
 static int
-verify_user_pass_management(struct tls_session *session, const struct user_pass *up, const char *raw_username)
+verify_user_pass_management(struct tls_session *session, const struct user_pass *up)
 {
     int retval = KMDA_ERROR;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
@@ -1244,7 +1226,7 @@ verify_user_pass_management(struct tls_session *session, const struct user_pass
     if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen(up->username))
     {
         /* set username/password in private env space */
-        setenv_str(session->opt->es, "username", (raw_username ? raw_username : up->username));
+        setenv_str(session->opt->es, "username", up->username);
         setenv_str(session->opt->es, "password", up->password);
 
         /* setenv incoming cert common name for script */
@@ -1259,10 +1241,6 @@ verify_user_pass_management(struct tls_session *session, const struct user_pass
         }
 
         setenv_del(session->opt->es, "password");
-        if (raw_username)
-        {
-            setenv_str(session->opt->es, "username", up->username);
-        }
 
         retval = KMDA_SUCCESS;
     }
@@ -1286,9 +1264,6 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     bool s2 = true;
     struct key_state *ks = &session->key[KS_PRIMARY];      /* primary key */
 
-    struct gc_arena gc = gc_new();
-    char *raw_username = NULL;
-
 #ifdef MANAGEMENT_DEF_AUTH
     int man_def_auth = KMDA_UNDEF;
 
@@ -1298,19 +1273,8 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     }
 #endif
 
-    /*
-     * Preserve the raw username before string_mod remapping, for plugins
-     * and management clients when in --compat-names mode
-     */
-    if (compat_flag(COMPAT_FLAG_QUERY | COMPAT_NAMES))
-    {
-        ALLOC_ARRAY_CLEAR_GC(raw_username, char, USER_PASS_LEN, &gc);
-        strcpy(raw_username, up->username);
-        string_mod(raw_username, CC_PRINT, CC_CRLF, '_');
-    }
-
     /* enforce character class restrictions in username/password */
-    string_mod_remap_name(up->username, COMMON_NAME_CHAR_CLASS);
+    string_mod_remap_name(up->username);
     string_mod(up->password, CC_PRINT, CC_CRLF, '_');
 
     /* If server is configured with --auth-gen-token and we have an
@@ -1328,7 +1292,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
         {
             /* auth-token cleared in tls_lock_username() on failure */
             ks->authenticated = false;
-            goto done;
+            return;
         }
 
         /* If auth-token lifetime has been enabled,
@@ -1340,7 +1304,7 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
             msg(D_HANDSHAKE, "Auth-token for client expired\n");
             wipe_auth_token(multi);
             ks->authenticated = false;
-            goto done;
+            return;
         }
 
         /* The core authentication of the token itself */
@@ -1367,19 +1331,19 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
                 up->username,
                 (ssl_flags & SSLF_USERNAME_AS_COMMON_NAME) ? "[CN SET]" : "");
         }
-        goto done;
+        return;
     }
 
     /* call plugin(s) and/or script */
 #ifdef MANAGEMENT_DEF_AUTH
     if (man_def_auth == KMDA_DEF)
     {
-        man_def_auth = verify_user_pass_management(session, up, raw_username);
+        man_def_auth = verify_user_pass_management(session, up);
     }
 #endif
     if (plugin_defined(session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS_VERIFY))
     {
-        s1 = verify_user_pass_plugin(session, up, raw_username);
+        s1 = verify_user_pass_plugin(session, up);
     }
     if (session->opt->auth_user_pass_verify_script)
     {
@@ -1462,9 +1426,6 @@ verify_user_pass(struct user_pass *up, struct tls_multi *multi,
     {
         msg(D_TLS_ERRORS, "TLS Auth Error: Auth Username/Password verification failed for peer");
     }
-
-done:
-    gc_free(&gc);
 }
 
 void
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
index c5a532d..10085b2 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -332,18 +332,6 @@ x509_get_subject(X509 *cert, struct gc_arena *gc)
     BUF_MEM *subject_mem;
     char *subject = NULL;
 
-    /*
-     * Generate the subject string in OpenSSL proprietary format,
-     * when in --compat-names mode
-     */
-    if (compat_flag(COMPAT_FLAG_QUERY | COMPAT_NAMES))
-    {
-        subject = gc_malloc(256, false, gc);
-        X509_NAME_oneline(X509_get_subject_name(cert), subject, 256);
-        subject[255] = '\0';
-        return subject;
-    }
-
     subject_bio = BIO_new(BIO_s_mem());
     if (subject_bio == NULL)
     {
-- 
2.7.4


