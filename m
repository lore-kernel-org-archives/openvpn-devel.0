From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 22 Feb 2013 10:44:22 +0100
Message-ID: <1361526263-1740-4-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
References: <1361526263-1740-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/3] add new option for X.509 name
	verification
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

Add the option --verify-x509-name to provide the functionality
of the now deprecated --tls-remote.

The new option accepts RFC 2253 subject DNs only and compares
RDN or RDN prefix only if configured explicitly.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 doc/openvpn.8            |   78 +++++++++++++++++++++++++++++++-------
 src/openvpn/init.c       |    7 ++--
 src/openvpn/options.c    |   94 ++++++++++++++++++++++++++++++++++++++++------
 src/openvpn/options.h    |    3 +-
 src/openvpn/ssl_common.h |    3 +-
 src/openvpn/ssl_verify.c |   15 +++++---
 src/openvpn/ssl_verify.h |    6 +++
 7 files changed, 170 insertions(+), 36 deletions(-)

diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 998f7ab..637fbb4 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3431,7 +3431,7 @@ the authenticated username as the common name,
 rather than the common name from the client cert.
 .\"*********************************************************
 .TP
-.B \-\-compat\-names [no\-remapping]
+.B \-\-compat\-names [no\-remapping] (DEPRECATED)
 Until OpenVPN v2.3 the format of the X.509 Subject fields was formatted
 like this:
 .IP
@@ -3467,17 +3467,20 @@ The
 mode flag can be used with the
 .B
 \-\-compat\-names
-option to be compatible with the now deprecated \-\-no\-name\-remapping feature
-present in older OpenVPN versions. When this mode flag is used, the Common Name,
+option to be compatible with the now deprecated \-\-no\-name\-remapping option.
+It is only available at the server. When this mode flag is used, the Common Name,
 Subject, and username strings are allowed to include any printable character
 including space, but excluding control characters such as tab, newline, and
-carriage-return.
+carriage-return. no-remapping is only available on the server side.
 
 .B Please note:
-This option will not be around for a long time.  It is only implemented
+This option is immediately deprecated.  It is only implemented
 to make the transition to the new formatting less intrusive.  It will be
-removed either in OpenVPN v2.4 or v2.5.  So please make sure you start
-the process to support the new formatting as soon as possible.
+removed either in OpenVPN v2.4 or v2.5.  So please make sure you use the
+.B \-\-verify-x509-name
+option instead of
+.B \-\-tls-remote
+as soon as possible and update your scripts where necessary.
 .\"*********************************************************
 .TP
 .B \-\-no\-name\-remapping (DEPRECATED)
@@ -3485,7 +3488,7 @@ The
 .B \-\-no\-name\-remapping
 option is an alias for
 .B \-\-compat\-names\ no\-remapping.
-It ensures compatibility with configurations using the
+It ensures compatibility with server configurations using the
 .B \-\-no\-name\-remapping
 option.
 
@@ -4671,11 +4674,11 @@ is available via the peer_cert environment variable.
 Field in x509 certificate subject to be used as username (default=CN).
 .B Fieldname
 will be uppercased before matching. When this option is used, the
---tls-remote option will match against the chosen fieldname instead
-of the CN.
+.B \-\-verify-x509-username
+option will match against the chosen fieldname instead of the CN.
 .\"*********************************************************
 .TP
-.B \-\-tls-remote name
+.B \-\-tls-remote name (DEPRECATED)
 Accept connections only from a host with X509 name
 or common name equal to
 .B name.
@@ -4707,6 +4710,55 @@ option to verify the remote host, because
 works in a
 .B \-\-chroot
 environment too.
+
+.B Please also note:
+This option is now deprecated.  It will be removed either in OpenVPN v2.4
+or v2.5.  So please make sure you support the new X.509 name formatting
+described with the
+.B \-\-compat-names
+option as soon as possible by updating your configurations to use
+.B \-\-verify-x509-name
+instead.
+.\"*********************************************************
+.TP
+.B \-\-verify-x509-name name type
+Accept connections only if a host's X.509 name is equal to
+.B name.
+The remote host must also pass all other tests of verification.
+
+Which X.509 name is compared to
+.B name
+depends on the setting of type.
+.B type
+can be "subject" to match the complete subject DN (default),
+"name" to match a subject RDN or "name-prefix" to match a subject RDN prefix.
+Which RDN is verified as name depends on the
+.B \-\-x509-username-field
+option. But it defaults to the common name (CN).
+
+.B \-\-verify-x509-name
+is a useful replacement for the
+.B \-\-tls-verify
+option to verify the remote host, because
+.B \-\-verify-x509-name
+works in a
+.B \-\-chroot
+environment too.
+
+If you want a client to only accept connections
+to "Server-1", "Server-2", etc., you can simply use
+.B \-\-verify-x509-name Server- name-prefix
+
+Using a name prefix is a useful alternative to managing
+a CRL (Certificate Revocation List) on the client, since it allows the client
+to refuse all certificates except for those associated
+with designated servers.
+
+.B NOTE:
+Test against a name prefix only when you are using OpenVPN with
+a custom CA certificate that is under your control.
+Never use this option with type "name-prefix" when your client certificates
+are signed by a third party, such as a commercial web CA.
 .\"*********************************************************
 .TP
 .B \-\-x509-track attribute
@@ -4744,7 +4796,7 @@ a man-in-the-middle attack where an authorized client
 attempts to connect to another client by impersonating the server.
 The attack is easily prevented by having clients verify
 the server certificate using any one of
-.B \-\-ns-cert-type, \-\-tls-remote,
+.B \-\-ns-cert-type, \-\-verify-x509-name,
 or
 .B \-\-tls-verify.
 .\"*********************************************************
@@ -4802,7 +4854,7 @@ a man-in-the-middle attack where an authorized client
 attempts to connect to another client by impersonating the server.
 The attack is easily prevented by having clients verify
 the server certificate using any one of
-.B \-\-remote-cert-tls, \-\-tls-remote,
+.B \-\-remote-cert-tls, \-\-verify-x509-name,
 or
 .B \-\-tls-verify.
 .\"*********************************************************
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 25d8225..979ba23 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2205,7 +2205,8 @@ do_init_crypto_tls (struct context *c, const unsigned int flags)
 
   to.verify_command = options->tls_verify;
   to.verify_export_cert = options->tls_export_cert;
-  to.verify_x509name = options->tls_remote;
+  to.verify_x509_type = (options->verify_x509_type & 0xff);
+  to.verify_x509_name = options->verify_x509_name;
   to.crl_file = options->crl_file;
   to.ssl_flags = options->ssl_flags;
   to.ns_cert_type = options->ns_cert_type;
@@ -2467,12 +2468,10 @@ do_option_warnings (struct context *c)
     warn_on_use_of_common_subnets ();
   if (o->tls_client
       && !o->tls_verify
-      && !o->tls_remote
+      && o->verify_x509_type == VERIFY_X509_NONE
       && !(o->ns_cert_type & NS_CERT_CHECK_SERVER)
       && !o->remote_cert_eku)
     msg (M_WARN, "WARNING: No server certificate verification method has been enabled.  See http://openvpn.net/howto.html#mitm for more info.");
-  if (o->tls_remote)
-    msg (M_WARN, "WARNING: Make sure you understand the semantics of --tls-remote before using it (see the man page).");
 #endif
 #endif
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7fda76f..8592955 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -614,8 +614,8 @@ static const char usage_message[] =
   "--tls-export-cert [directory] : Get peer cert in PEM format and store it \n"
   "                  in an openvpn temporary file in [directory]. Peer cert is \n"
   "                  stored before tls-verify script execution and deleted after.\n"
-  "--tls-remote x509name: Accept connections only from a host with X509 name\n"
-  "                  x509name. The remote host must also pass all other tests\n"
+  "--verify-x509-name name: Accept connections only from a host with X509 subject\n"
+  "                  DN name. The remote host must also pass all other tests\n"
   "                  of verification.\n"
   "--ns-cert-type t: Require that peer certificate was signed with an explicit\n"
   "                  nsCertType designation t = 'client' | 'server'.\n"
@@ -1596,7 +1596,8 @@ show_settings (const struct options *o)
   SHOW_STR (cipher_list);
   SHOW_STR (tls_verify);
   SHOW_STR (tls_export_cert);
-  SHOW_STR (tls_remote);
+  SHOW_INT (verify_x509_type);
+  SHOW_STR (verify_x509_name);
   SHOW_STR (crl_file);
   SHOW_INT (ns_cert_type);
   {
@@ -2130,7 +2131,6 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
 
       if (options->stale_routes_check_interval)
         msg (M_USAGE, "--stale-routes-check requires --mode server");
-
       if (compat_flag (COMPAT_FLAG_QUERY | COMPAT_NO_NAME_REMAPPING))
         msg (M_USAGE, "--compat-x509-names no-remapping requires --mode server");
     }
@@ -2302,7 +2302,7 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       MUST_BE_UNDEF (cipher_list);
       MUST_BE_UNDEF (tls_verify);
       MUST_BE_UNDEF (tls_export_cert);
-      MUST_BE_UNDEF (tls_remote);
+      MUST_BE_UNDEF (verify_x509_name);
       MUST_BE_UNDEF (tls_timeout);
       MUST_BE_UNDEF (renegotiate_bytes);
       MUST_BE_UNDEF (renegotiate_packets);
@@ -6514,27 +6514,97 @@ add_option (struct options *options,
   else if (streq (p[0], "compat-names"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (options->verify_x509_type != VERIFY_X509_NONE &&
+          options->verify_x509_type != TLS_REMOTE_SUBJECT_DN &&
+          options->verify_x509_type != TLS_REMOTE_SUBJECT_RDN_PREFIX)
+        {
+          msg (msglevel, "you cannot use --compat-names with --verify-x509-name");
+          goto err;
+        }
+      msg (M_WARN, "DEPRECATED OPTION: --compat-names, please update your configuration");
       compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
+#if P2MP_SERVER
       if (p[1] && streq (p[1], "no-remapping"))
         compat_flag (COMPAT_FLAG_SET | COMPAT_NO_NAME_REMAPPING);
     }
   else if (streq (p[0], "no-name-remapping"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (options->verify_x509_type != VERIFY_X509_NONE &&
+          options->verify_x509_type != TLS_REMOTE_SUBJECT_DN &&
+          options->verify_x509_type != TLS_REMOTE_SUBJECT_RDN_PREFIX)
+        {
+          msg (msglevel, "you cannot use --no-name-remapping with --verify-x509-name");
+          goto err;
+        }
       msg (M_WARN, "DEPRECATED OPTION: --no-name-remapping, please update your configuration");
       compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
       compat_flag (COMPAT_FLAG_SET | COMPAT_NO_NAME_REMAPPING);
+#endif
     }
   else if (streq (p[0], "tls-remote") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      /*
-       * Enable legacy openvpn format for DNs that have not been converted
-       * yet and X.509 common names (not containing an '=' or ', ')
-       */
-      if (p[1][0] == '/' || !strchr (p[1], '=') || !strstr (p[1], ", "))
-        compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
-      options->tls_remote = p[1];
+
+      if (options->verify_x509_type != VERIFY_X509_NONE &&
+          options->verify_x509_type != TLS_REMOTE_SUBJECT_DN &&
+          options->verify_x509_type != TLS_REMOTE_SUBJECT_RDN_PREFIX)
+        {
+          msg (msglevel, "you cannot use --tls-remote with --verify-x509-name");
+          goto err;
+        }
+      msg (M_WARN, "DEPRECATED OPTION: --tls-remote, please update your configuration");
+
+      if (strlen (p[1]))
+        {
+          int is_username = (!strchr (p[1], '=') || !strstr (p[1], ", "));
+          int type = TLS_REMOTE_SUBJECT_DN;
+          if (p[1][0] != '/' && is_username)
+            type = TLS_REMOTE_SUBJECT_RDN_PREFIX;
+
+          /*
+           * Enable legacy openvpn format for DNs that have not been converted
+           * yet and --x509-username-field (not containing an '=' or ', ')
+           */
+          if (p[1][0] == '/' || is_username)
+            compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
+
+          options->verify_x509_type = type;
+          options->verify_x509_name = p[1];
+        }
+    }
+  else if (streq (p[0], "verify-x509-name") && p[1] && strlen (p[1]))
+    {
+      int type = VERIFY_X509_SUBJECT_DN;
+      VERIFY_PERMISSION (OPT_P_GENERAL);
+      if (options->verify_x509_type == TLS_REMOTE_SUBJECT_DN ||
+          options->verify_x509_type == TLS_REMOTE_SUBJECT_RDN_PREFIX)
+        {
+          msg (msglevel, "you cannot use --verify-x509-name with --tls-remote");
+          goto err;
+        }
+      if (compat_flag (COMPAT_FLAG_QUERY | COMPAT_NAMES))
+        {
+          msg (msglevel, "you cannot use --verify-x509-name with "
+                         "--compat-names or --no-name-remapping");
+          goto err;
+        }
+      if (p[2])
+        {
+          if (streq (p[2], "subject"))
+            type = VERIFY_X509_SUBJECT_DN;
+          else if (streq (p[2], "name"))
+            type = VERIFY_X509_SUBJECT_RDN;
+          else if (streq (p[2], "name-prefix"))
+            type = VERIFY_X509_SUBJECT_RDN_PREFIX;
+          else
+            {
+              msg (msglevel, "unknown X.509 name type: %s", p[2]);
+              goto err;
+            }
+        }
+      options->verify_x509_type = type;
+      options->verify_x509_name = p[1];
     }
   else if (streq (p[0], "ns-cert-type") && p[1])
     {
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 306520b..d2ad94c 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -506,8 +506,9 @@ struct options
   const char *pkcs12_file;
   const char *cipher_list;
   const char *tls_verify;
+  int verify_x509_type;
+  const char *verify_x509_name;
   const char *tls_export_cert;
-  const char *tls_remote;
   const char *crl_file;
 
   const char *ca_file_inline;
diff --git a/src/openvpn/ssl_common.h b/src/openvpn/ssl_common.h
index cb259a9..c62294f 100644
--- a/src/openvpn/ssl_common.h
+++ b/src/openvpn/ssl_common.h
@@ -245,7 +245,8 @@ struct tls_options
   /* cert verification parms */
   const char *verify_command;
   const char *verify_export_cert;
-  const char *verify_x509name;
+  int verify_x509_type;
+  const char *verify_x509_name;
   const char *crl_file;
   int ns_cert_type;
   unsigned remote_cert_ku[MAX_PARMS];
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index cac46e9..e651a8e 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -369,16 +369,21 @@ verify_peer_cert(const struct tls_options *opt, openvpn_x509_cert_t *peer_cert,
 
 #endif /* OPENSSL_VERSION_NUMBER */
 
-  /* verify X509 name or common name against --tls-remote */
-  if (opt->verify_x509name && strlen (opt->verify_x509name) > 0)
+  /* verify X509 name or username against --verify-x509-[user]name */
+  if (opt->verify_x509_type != VERIFY_X509_NONE)
     {
-      if (strcmp (opt->verify_x509name, subject) == 0
-	  || strncmp (opt->verify_x509name, common_name, strlen (opt->verify_x509name)) == 0)
+      if ( (opt->verify_x509_type == VERIFY_X509_SUBJECT_DN
+            && strcmp (opt->verify_x509_name, subject) == 0)
+        || (opt->verify_x509_type == VERIFY_X509_SUBJECT_RDN
+            && strcmp (opt->verify_x509_name, common_name) == 0)
+        || (opt->verify_x509_type == VERIFY_X509_SUBJECT_RDN_PREFIX
+            && strncmp (opt->verify_x509_name, common_name,
+                        strlen (opt->verify_x509_name)) == 0) )
 	msg (D_HANDSHAKE, "VERIFY X509NAME OK: %s", subject);
       else
 	{
 	  msg (D_HANDSHAKE, "VERIFY X509NAME ERROR: %s, must be %s",
-	       subject, opt->verify_x509name);
+	       subject, opt->verify_x509_name);
 	  return FAILURE;		/* Reject connection */
 	}
     }
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index 1d20152..e0bcba4 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -62,6 +62,12 @@ struct cert_hash_set {
   struct cert_hash *ch[MAX_CERT_DEPTH]; /**< Array of certificate hashes */
 };
 
+#define VERIFY_X509_NONE                0
+#define VERIFY_X509_SUBJECT_DN          1
+#define VERIFY_X509_SUBJECT_RDN         2
+#define VERIFY_X509_SUBJECT_RDN_PREFIX  3
+#define TLS_REMOTE_SUBJECT_DN           1 + 0x100
+#define TLS_REMOTE_SUBJECT_RDN_PREFIX   3 + 0x100
 
 #define TLS_AUTHENTICATION_SUCCEEDED  0
 #define TLS_AUTHENTICATION_FAILED     1
-- 
1.7.9.5


