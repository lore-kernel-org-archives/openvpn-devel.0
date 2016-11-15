From: David Sommerseth <davids@...515...>
Date: Tue, 15 Nov 2016 14:40:56 +0100
Message-Id: <1479217256-21298-1-git-send-email-davids@...515...>
Subject: [Openvpn-devel] [PATCH] options: Remove --tls-remote
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

In OpenVPN 2.3 --tls-remote got deprecated in favour of --verify-x509-name.
The new option solves the same task as --tls-remote but in a more flexible
and improved way.  This new option was introduced in commit 9f0fc745664fd0
(release/2.3: f6e12862cefd054eb1).  Removing --tls-remote will only require
a minor configuration file change.

The removal of this option has been documented in the man pages since the
release of OpenVPN v2.3, where also the deprecation of --compat-names and
--no-name-remapping was included.  However, those two will first be removed
in OpenVPN v2.5.

The reason not to remove --compat-names and --no-name-remapping now is that
such a change will require TLS verification scripts and plug-ins to be
updated to support the new X.509 subject formatting; which
--verify-x509-name already uses.

Signed-off-by: David Sommerseth <davids@...515...>
---
 Changes.rst              |  8 ++++++++
 doc/openvpn.8            | 53 +++---------------------------------------------
 src/openvpn/options.c    | 49 ++++----------------------------------------
 src/openvpn/ssl_verify.h |  2 --
 4 files changed, 15 insertions(+), 97 deletions(-)

diff --git a/Changes.rst b/Changes.rst
index 2b99a1d..d900f81 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -120,6 +120,14 @@ Deprecated features
   will then use ``--key-method 2`` by default.  Note that this requires changing
   the option in both the client and server side configs.
 
+- ``--tls-remote`` is removed in 2.4, as indicated in the 2.3 man-pages.  A similar
+  functionality is provided via ``--verify-x509-name`` which does the same job in
+  a better way.
+
+- ``--compat-names`` and ``--no-name-remapping`` was deprecated in 2.3 and will
+  be removed in 2.5.  All scripts and plug-ins depending on the old non-standard
+  X.509 subject formatting must be updated to the standardized formatting.  See
+  the man page for more information.
 
 User-visible Changes
 --------------------
diff --git a/doc/openvpn.8 b/doc/openvpn.8
index 7227d22..54d1756 100644
--- a/doc/openvpn.8
+++ b/doc/openvpn.8
@@ -3764,11 +3764,7 @@ carriage-return. no-remapping is only available on the server side.
 .B Please note:
 This option is immediately deprecated.  It is only implemented
 to make the transition to the new formatting less intrusive.  It will be
-removed either in OpenVPN v2.4 or v2.5.  So please make sure you use the
-.B \-\-verify\-x509\-name
-option instead of
-.B \-\-tls\-remote
-as soon as possible and update your scripts where necessary.
+removed in OpenVPN v2.5.  So please update your scripts/plug-ins where necessary.
 .\"*********************************************************
 .TP
 .B \-\-no\-name\-remapping (DEPRECATED)
@@ -3781,8 +3777,8 @@ It ensures compatibility with server configurations using the
 option.
 
 .B Please note:
-This option is now deprecated.  It will be removed either in OpenVPN v2.4
-or v2.5.  So please make sure you support the new X.509 name formatting
+This option is now deprecated.  It will be removed in OpenVPN v2.5.
+So please make sure you support the new X.509 name formatting
 described with the
 .B \-\-compat\-names
 option as soon as possible.
@@ -5157,49 +5153,6 @@ prefix will be left as-is.  This automatic upcasing feature
 is deprecated and will be removed in a future release.
 .\"*********************************************************
 .TP
-.B \-\-tls\-remote name (DEPRECATED)
-Accept connections only from a host with X509 name
-or common name equal to
-.B name.
-The remote host must also pass all other tests
-of verification.
-
-.B NOTE:
-Because tls\-remote may test against a common name prefix,
-only use this option when you are using OpenVPN with a custom CA
-certificate that is under your control.
-Never use this option when your client certificates are signed by
-a third party, such as a commercial web CA.
-
-Name can also be a common name prefix, for example if you
-want a client to only accept connections to "Server-1",
-"Server-2", etc., you can simply use
-.B \-\-tls\-remote Server
-
-Using a common name prefix is a useful alternative to managing
-a CRL (Certificate Revocation List) on the client, since it allows the client
-to refuse all certificates except for those associated
-with designated servers.
-
-.B \-\-tls\-remote
-is a useful replacement for the
-.B \-\-tls\-verify
-option to verify the remote host, because
-.B \-\-tls\-remote
-works in a
-.B \-\-chroot
-environment too.
-
-.B Please also note:
-This option is now deprecated.  It will be removed either in OpenVPN v2.4
-or v2.5.  So please make sure you support the new X.509 name formatting
-described with the
-.B \-\-compat\-names
-option as soon as possible by updating your configurations to use
-.B \-\-verify\-x509\-name
-instead.
-.\"*********************************************************
-.TP
 .B \-\-verify\-x509\-name name type
 Accept connections only if a host's X.509 name is equal to
 .B name.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4d31e4c..74e28c8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7062,14 +7062,12 @@ add_option (struct options *options,
 #endif
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      if (options->verify_x509_type != VERIFY_X509_NONE &&
-          options->verify_x509_type != TLS_REMOTE_SUBJECT_DN &&
-          options->verify_x509_type != TLS_REMOTE_SUBJECT_RDN_PREFIX)
+      if (options->verify_x509_type != VERIFY_X509_NONE)
         {
           msg (msglevel, "you cannot use --compat-names with --verify-x509-name");
           goto err;
         }
-      msg (M_WARN, "DEPRECATED OPTION: --compat-names, please update your configuration");
+      msg (M_WARN, "DEPRECATED OPTION: --compat-names, please update your configuration. This will be removed in OpenVPN v2.5.");
       compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
 #if P2MP_SERVER
       if (p[1] && streq (p[1], "no-remapping"))
@@ -7078,59 +7076,20 @@ add_option (struct options *options,
   else if (streq (p[0], "no-name-remapping") && !p[1])
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      if (options->verify_x509_type != VERIFY_X509_NONE &&
-          options->verify_x509_type != TLS_REMOTE_SUBJECT_DN &&
-          options->verify_x509_type != TLS_REMOTE_SUBJECT_RDN_PREFIX)
+      if (options->verify_x509_type != VERIFY_X509_NONE)
         {
           msg (msglevel, "you cannot use --no-name-remapping with --verify-x509-name");
           goto err;
         }
-      msg (M_WARN, "DEPRECATED OPTION: --no-name-remapping, please update your configuration");
+      msg (M_WARN, "DEPRECATED OPTION: --no-name-remapping, please update your configuration. This will be removed in OpenVPN v2.5.");
       compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
       compat_flag (COMPAT_FLAG_SET | COMPAT_NO_NAME_REMAPPING);
 #endif
     }
-  else if (streq (p[0], "tls-remote") && p[1] && !p[2])
-    {
-      VERIFY_PERMISSION (OPT_P_GENERAL);
-
-      if (options->verify_x509_type != VERIFY_X509_NONE &&
-          options->verify_x509_type != TLS_REMOTE_SUBJECT_DN &&
-          options->verify_x509_type != TLS_REMOTE_SUBJECT_RDN_PREFIX)
-        {
-          msg (msglevel, "you cannot use --tls-remote with --verify-x509-name");
-          goto err;
-        }
-      msg (M_WARN, "DEPRECATED OPTION: --tls-remote, please update your configuration");
-
-      if (strlen (p[1]))
-        {
-          int is_username = (!strchr (p[1], '=') || !strstr (p[1], ", "));
-          int type = TLS_REMOTE_SUBJECT_DN;
-          if (p[1][0] != '/' && is_username)
-            type = TLS_REMOTE_SUBJECT_RDN_PREFIX;
-
-          /*
-           * Enable legacy openvpn format for DNs that have not been converted
-           * yet and --x509-username-field (not containing an '=' or ', ')
-           */
-          if (p[1][0] == '/' || is_username)
-            compat_flag (COMPAT_FLAG_SET | COMPAT_NAMES);
-
-          options->verify_x509_type = type;
-          options->verify_x509_name = p[1];
-        }
-    }
   else if (streq (p[0], "verify-x509-name") && p[1] && strlen (p[1]) && !p[3])
     {
       int type = VERIFY_X509_SUBJECT_DN;
       VERIFY_PERMISSION (OPT_P_GENERAL);
-      if (options->verify_x509_type == TLS_REMOTE_SUBJECT_DN ||
-          options->verify_x509_type == TLS_REMOTE_SUBJECT_RDN_PREFIX)
-        {
-          msg (msglevel, "you cannot use --verify-x509-name with --tls-remote");
-          goto err;
-        }
       if (compat_flag (COMPAT_FLAG_QUERY | COMPAT_NAMES))
         {
           msg (msglevel, "you cannot use --verify-x509-name with "
diff --git a/src/openvpn/ssl_verify.h b/src/openvpn/ssl_verify.h
index e5b5950..98312fd 100644
--- a/src/openvpn/ssl_verify.h
+++ b/src/openvpn/ssl_verify.h
@@ -67,8 +67,6 @@ struct cert_hash_set {
 #define VERIFY_X509_SUBJECT_DN          1
 #define VERIFY_X509_SUBJECT_RDN         2
 #define VERIFY_X509_SUBJECT_RDN_PREFIX  3
-#define TLS_REMOTE_SUBJECT_DN           1 + 0x100
-#define TLS_REMOTE_SUBJECT_RDN_PREFIX   3 + 0x100
 
 #define TLS_AUTHENTICATION_SUCCEEDED  0
 #define TLS_AUTHENTICATION_FAILED     1
-- 
1.8.3.1


