From: Heiko Hund <heiko.hund@...1489...>
Date: Sat, 4 Feb 2012 12:56:24 +0000
Message-ID: <1328360184-15865-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] UTF-8 X.509 distinguished names
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
To: openvpn-devel@lists.sourceforge.net

The UTF-8 support that came with commit 2627335 does allow international
usernames and passwords. This patch introduces UTF-8 support for X.509 DNs.
Additionally, instead of using the legacy openssl format, DNs are now
displayed in RFC 2253 format; "/C=3Dru/L=3D\xD0\x9C\xD0\xBE\xD1\x81\xD0\xBA=
\xD0
\xB2\xD0\xB0/O=3D\xD0\x9A\xD1\x80\xD0\xB5\xD0\xBC\xD0\xBB\xD1\x8C/CN=3Dkrem=
l.ru"
becomes "C=3Dru, L=3D=D0=9C=D0=BE=D1=81=D0=BA=D0=B2=D0=B0, O=3D=D0=9A=D1=80=
=D0=B5=D0=BC=D0=BB=D1=8C, CN=3Dkreml.ru".

Since the specific character classes for X.509 names are removed, the
"no-name-remapping" configuration option has no use anymore and is removed
as well.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 openvpn.8                |   23 +----------------------
 options.c                |   12 +-----------
 pkcs11_openssl.c         |    2 +-
 sample-scripts/verify-cn |    6 +++---
 ssl_verify.c             |   45 +++++++++---------------------------------=
---
 ssl_verify_openssl.c     |   40 ++++++++++++++++++++++++++++++++++++++--
 ssl_verify_openssl.h     |    2 ++
 7 files changed, 55 insertions(+), 75 deletions(-)

diff --git a/openvpn.8 b/openvpn.8
index a6d7567..00acd01 100644
--- a/openvpn.8
+++ b/openvpn.8
@@ -3322,27 +3322,6 @@ the authenticated username as the common name,
 rather than the common name from the client cert.
 .\"*********************************************************
 .TP
-.B \-\-no-name-remapping
-Allow Common Name, X509 Subject, and username strings to include
-any printable character including space, but excluding control
-characters such as tab, newline, and carriage-return.
-
-By default, OpenVPN will remap
-any character other than alphanumeric, underbar ('_'), dash
-('-'), dot ('.'), and slash ('/') to underbar ('_').  The X509
-Subject string as returned by the
-.B tls_id
-environmental variable, can additionally contain colon (':') or
-equal ('=3D').
-
-While name remapping is performed for security reasons to reduce
-the possibility of introducing string expansion security vulnerabilities
-in user-defined authentication
-scripts, this option is provided for those cases where it is desirable to
-disable the remapping feature.  Don't use this option unless you=20
-know what you are doing!
-.\"*********************************************************
-.TP
 .B \-\-port-share host port [dir]
 When run in TCP server mode, share the OpenVPN port with
 another application, such as an HTTPS server.  If OpenVPN
@@ -4463,7 +4442,7 @@ When
 .B cmd
 is executed two arguments are appended, as follows:
=20
-.B cmd certificate_depth X509_NAME_oneline
+.B cmd certificate_depth subject
=20
 These arguments are, respectively, the current certificate depth and
 the X509 common name (cn) of the peer.
diff --git a/options.c b/options.c
index cb9738a..6b8ae22 100644
--- a/options.c
+++ b/options.c
@@ -601,7 +601,7 @@ static const char usage_message[] =3D
   "                  pending TLS connection that has otherwise passed all =
other\n"
   "                  tests of certification.  cmd should return 0 to allow=
\n"
   "                  TLS handshake to proceed, or 1 to fail.  (cmd is\n"
-  "                  executed as 'cmd certificate_depth X509_NAME_oneline'=
)\n"
+  "                  executed as 'cmd certificate_depth subject')\n"
   "--tls-export-cert [directory] : Get peer cert in PEM format and store i=
t \n"
   "                  in an openvpn temporary file in [directory]. Peer cer=
t is \n"
   "                  stored before tls-verify script execution and deleted=
 after.\n"
@@ -2164,9 +2164,6 @@ options_postprocess_verify_ce (const struct options *=
options, const struct conne
 	  if ((options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) && !ccnr)
 	    msg (M_USAGE, "--auth-user-pass-optional %s", postfix);
 	}
-
-	if ((options->ssl_flags & SSLF_NO_NAME_REMAPPING) && script_method =3D=3D=
 SM_SYSTEM)
-	  msg (M_USAGE, "--script-security method=3D'system' cannot be combined w=
ith --no-name-remapping");
     }
   else
     {
@@ -2201,8 +2198,6 @@ options_postprocess_verify_ce (const struct options *=
options, const struct conne
 	msg (M_USAGE, "--username-as-common-name requires --mode server");
       if (options->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL)
 	msg (M_USAGE, "--auth-user-pass-optional requires --mode server");
-      if (options->ssl_flags & SSLF_NO_NAME_REMAPPING)
-	msg (M_USAGE, "--no-name-remapping requires --mode server");
       if (options->ssl_flags & SSLF_OPT_VERIFY)
 	msg (M_USAGE, "--opt-verify requires --mode server");
       if (options->server_flags & SF_TCP_NODELAY_HELPER)
@@ -5581,11 +5576,6 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->ssl_flags |=3D SSLF_AUTH_USER_PASS_OPTIONAL;
     }
-  else if (streq (p[0], "no-name-remapping"))
-    {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-      options->ssl_flags |=3D SSLF_NO_NAME_REMAPPING;
-    }
   else if (streq (p[0], "opt-verify"))
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
diff --git a/pkcs11_openssl.c b/pkcs11_openssl.c
index e3463dc..aa1eccc 100644
--- a/pkcs11_openssl.c
+++ b/pkcs11_openssl.c
@@ -129,7 +129,7 @@ pkcs11_certificate_dn (pkcs11h_certificate_t certificat=
e, char *dn,
       goto cleanup;
     }
=20
-  X509_NAME_oneline (X509_get_subject_name (x509), dn, dn_len);
+  _openssl_get_subject (x509, dn, dn_len);
=20
   ret =3D 0;
=20
diff --git a/sample-scripts/verify-cn b/sample-scripts/verify-cn
index f9fea0f..6e747ef 100755
--- a/sample-scripts/verify-cn
+++ b/sample-scripts/verify-cn
@@ -3,7 +3,7 @@
 # verify-cn -- a sample OpenVPN tls-verify script
 #
 # Return 0 if cn matches the common name component of
-# X509_NAME_oneline, 1 otherwise.
+# subject, 1 otherwise.
 #
 # For example in OpenVPN, you could use the directive:
 #
@@ -13,7 +13,7 @@
 # the client common name is listed on a line in the
 # allowed_clients file.
=20
-die "usage: verify-cn cnfile certificate_depth X509_NAME_oneline" if (@ARG=
V !=3D 3);
+die "usage: verify-cn cnfile certificate_depth subject" if (@ARGV !=3D 3);
=20
 # Parse out arguments:
 #   cnfile -- The file containing the list of common names, one per
@@ -37,7 +37,7 @@ if ($depth =3D=3D 0) {
     # If so, parse out the common name substring in
     # the X509 subject string.
=20
-    if ($x509 =3D~ /\/CN=3D([^\/]+)/) {
+    if ($x509 =3D~ / CN=3D([^,]+)/) {
         $cn =3D $1;
 	# Accept the connection if the X509 common name
 	# string matches the passed cn argument.
diff --git a/ssl_verify.c b/ssl_verify.c
index 326b005..0b2a1fb 100644
--- a/ssl_verify.c
+++ b/ssl_verify.c
@@ -40,24 +40,9 @@
 #include "ssl_verify_openssl.h"
 #endif
=20
-/** Legal characters in an X509 name */
-#define X509_NAME_CHAR_CLASS   (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|=
CC_COLON|CC_SLASH|CC_EQUAL)
-
-/** Legal characters in a common name */
-#define COMMON_NAME_CHAR_CLASS (CC_ALNUM|CC_UNDERBAR|CC_DASH|CC_DOT|CC_AT|=
CC_SLASH)
-
 /** Maximum length of common name */
 #define TLS_USERNAME_LEN 64
=20
-static void
-string_mod_sslname (char *str, const unsigned int restrictive_flags, const=
 unsigned int ssl_flags)
-{
-  if (ssl_flags & SSLF_NO_NAME_REMAPPING)
-    string_mod (str, CC_PRINT, CC_CRLF, '_');
-  else
-    string_mod (str, restrictive_flags, 0, '_');
-}
-
 /*
  * Export the untrusted IP address and port to the environment
  */
@@ -595,7 +580,7 @@ verify_cert(struct tls_session *session, x509_cert_t *c=
ert, int cert_depth)
     }
=20
   /* enforce character class restrictions in X509 name */
-  string_mod_sslname (subject, X509_NAME_CHAR_CLASS, opt->ssl_flags);
+  string_mod (subject, CC_PRINT, CC_CRLF, '_');
   string_replace_leading (subject, '-', '_');
=20
   /* extract the username (default is CN) */
@@ -615,7 +600,7 @@ verify_cert(struct tls_session *session, x509_cert_t *c=
ert, int cert_depth)
     }
=20
   /* enforce character class restrictions in common name */
-  string_mod_sslname (common_name, COMMON_NAME_CHAR_CLASS, opt->ssl_flags);
+  string_mod (common_name, CC_PRINT, CC_CRLF, '_');
=20
   /* warn if cert chain is too deep */
   if (cert_depth >=3D MAX_CERT_DEPTH)
@@ -1005,7 +990,7 @@ verify_user_pass_script (struct tls_session *session, =
const struct user_pass *up
  * Verify the username and password using a plugin
  */
 static int
-verify_user_pass_plugin (struct tls_session *session, const struct user_pa=
ss *up, const char *raw_username)
+verify_user_pass_plugin (struct tls_session *session, const struct user_pa=
ss *up)
 {
   int retval =3D OPENVPN_PLUGIN_FUNC_ERROR;
   struct key_state *ks =3D &session->key[KS_PRIMARY]; 	   /* primary key */
@@ -1014,7 +999,7 @@ verify_user_pass_plugin (struct tls_session *session, =
const struct user_pass *up
   if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen (=
up->username))
     {
       /* set username/password in private env space */
-      setenv_str (session->opt->es, "username", raw_username);
+      setenv_str (session->opt->es, "username", up->username);
       setenv_str (session->opt->es, "password", up->password);
=20
       /* setenv incoming cert common name for script */
@@ -1038,7 +1023,6 @@ verify_user_pass_plugin (struct tls_session *session,=
 const struct user_pass *up
 #endif
=20
       setenv_del (session->opt->es, "password");
-      setenv_str (session->opt->es, "username", up->username);
     }
   else
     {
@@ -1059,7 +1043,7 @@ verify_user_pass_plugin (struct tls_session *session,=
 const struct user_pass *up
 #define KMDA_DEF     3
=20
 static int
-verify_user_pass_management (struct tls_session *session, const struct use=
r_pass *up, const char *raw_username)
+verify_user_pass_management (struct tls_session *session, const struct use=
r_pass *up)
 {
   int retval =3D KMDA_ERROR;
   struct key_state *ks =3D &session->key[KS_PRIMARY]; 	   /* primary key */
@@ -1068,7 +1052,7 @@ verify_user_pass_management (struct tls_session *sess=
ion, const struct user_pass
   if ((session->opt->ssl_flags & SSLF_AUTH_USER_PASS_OPTIONAL) || strlen (=
up->username))
     {
       /* set username/password in private env space */
-      setenv_str (session->opt->es, "username", raw_username);
+      setenv_str (session->opt->es, "username", up->username);
       setenv_str (session->opt->es, "password", up->password);
=20
       /* setenv incoming cert common name for script */
@@ -1081,7 +1065,6 @@ verify_user_pass_management (struct tls_session *sess=
ion, const struct user_pass
 	management_notify_client_needing_auth (management, ks->mda_key_id, sessio=
n->opt->mda_context, session->opt->es);
=20
       setenv_del (session->opt->es, "password");
-      setenv_str (session->opt->es, "username", up->username);
=20
       retval =3D KMDA_SUCCESS;
     }
@@ -1105,9 +1088,6 @@ verify_user_pass(struct user_pass *up, struct tls_mul=
ti *multi,
   bool s2 =3D true;
   struct key_state *ks =3D &session->key[KS_PRIMARY]; 	   /* primary key */
=20
-  struct gc_arena gc =3D gc_new ();
-  char *raw_username;
-
 #ifdef MANAGEMENT_DEF_AUTH
   int man_def_auth =3D KMDA_UNDEF;
=20
@@ -1115,22 +1095,17 @@ verify_user_pass(struct user_pass *up, struct tls_m=
ulti *multi,
     man_def_auth =3D KMDA_DEF;
 #endif
=20
-  /* preserve raw username before string_mod remapping, for plugins */
-  ALLOC_ARRAY_CLEAR_GC (raw_username, char, USER_PASS_LEN, &gc);
-  strcpy (raw_username, up->username);
-  string_mod (raw_username, CC_PRINT, CC_CRLF, '_');
-
   /* enforce character class restrictions in username/password */
-  string_mod_sslname (up->username, COMMON_NAME_CHAR_CLASS, session->opt->=
ssl_flags);
+  string_mod (up->username, CC_PRINT, CC_CRLF, '_');
   string_mod (up->password, CC_PRINT, CC_CRLF, '_');
=20
   /* call plugin(s) and/or script */
 #ifdef MANAGEMENT_DEF_AUTH
   if (man_def_auth =3D=3D KMDA_DEF)
-    man_def_auth =3D verify_user_pass_management (session, up, raw_usernam=
e);
+    man_def_auth =3D verify_user_pass_management (session, up);
 #endif
   if (plugin_defined (session->opt->plugins, OPENVPN_PLUGIN_AUTH_USER_PASS=
_VERIFY))
-    s1 =3D verify_user_pass_plugin (session, up, raw_username);
+    s1 =3D verify_user_pass_plugin (session, up);
   if (session->opt->auth_user_pass_verify_script)
     s2 =3D verify_user_pass_script (session, up);
=20
@@ -1179,8 +1154,6 @@ verify_user_pass(struct user_pass *up, struct tls_mul=
ti *multi,
     {
       msg (D_TLS_ERRORS, "TLS Auth Error: Auth Username/Password verificat=
ion failed for peer");
     }
-
-  gc_free (&gc);
 }
=20
 void
diff --git a/ssl_verify_openssl.c b/ssl_verify_openssl.c
index e82f6f9..e3f2d13 100644
--- a/ssl_verify_openssl.c
+++ b/ssl_verify_openssl.c
@@ -247,16 +247,52 @@ x509_free_sha1_hash (unsigned char *hash)
 }
=20
 char *
+_openssl_get_subject (X509 *cert, char *buf, int size)
+{
+  BIO *subject_bio;
+  BUF_MEM *subject_mem;
+  char *subject =3D buf;
+  int maxlen =3D size;
+
+  subject_bio =3D BIO_new (BIO_s_mem ());
+  if (subject_bio =3D=3D NULL)
+    goto out;
+
+  X509_NAME_print_ex (subject_bio, X509_get_subject_name (cert),
+                      0, XN_FLAG_SEP_CPLUS_SPC | XN_FLAG_FN_SN |
+                      ASN1_STRFLGS_UTF8_CONVERT | ASN1_STRFLGS_ESC_CTRL);
+
+  if (BIO_eof (subject_bio))
+    goto out_free;
+
+  BIO_get_mem_ptr (subject_bio, &subject_mem);
+  if (subject =3D=3D NULL)
+    {
+      maxlen =3D subject_mem->length + 1;
+      subject =3D malloc (maxlen);
+      check_malloc_return (subject);
+    }
+
+  memcpy (subject, subject_mem->data, maxlen);
+  subject[maxlen - 1] =3D '\0';
+
+out_free:
+  BIO_free (subject_bio);
+out:
+  return subject;
+}
+
+char *
 x509_get_subject (X509 *cert)
 {
-  return X509_NAME_oneline (X509_get_subject_name (cert), NULL, 0);
+  return _openssl_get_subject (cert, NULL, 0);
 }
=20
 void
 x509_free_subject (char *subject)
 {
   if (subject)
-    OPENSSL_free(subject);
+    free(subject);
 }
=20
=20
diff --git a/ssl_verify_openssl.h b/ssl_verify_openssl.h
index 4814d30..9c76d34 100644
--- a/ssl_verify_openssl.h
+++ b/ssl_verify_openssl.h
@@ -69,4 +69,6 @@ int verify_callback (int preverify_ok, X509_STORE_CTX * c=
tx);
=20
 /** @} name Function for authenticating a new connection from a remote Ope=
nVPN peer */
=20
+char *_openssl_get_subject (X509 *cert, char *buf, int size);
+
 #endif /* SSL_VERIFY_OPENSSL_H_ */
--=20
1.7.8.3


