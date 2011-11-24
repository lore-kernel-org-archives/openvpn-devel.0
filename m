MIME-version: 1.0
From: David Sommerseth <davids@...1347...>
Date: Thu, 24 Nov 2011 23:10:26 +0100
Message-id: <1322172626-18434-2-git-send-email-davids@...1347...>
In-reply-to: <1322172626-18434-1-git-send-email-davids@...1347...>
References: <1322172626-18434-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Do some file/directory tests before really
	starting openvpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-type: TEXT/PLAIN; charset="utf-8"
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

OpenVPN can handle over 30 different files and directories, and it is easy
to misconfigure some of them.  In many situations OpenVPN will even start
running, even with a wrong file path or without the proper permissions, and
then it will complain much later on.  In some cases the error being seen at
this late point might even be difficult to relate to a configuration option.

This patch tries to catch as many of these files as soon as possible, kind of
to "smoke-test" the files and directories to avoid the most likely errors.

Trac-ticket: 73
Signed-off-by: David Sommerseth <davids@...1347...>
---
 options.c |  151 +++++++++++++++++++++++++++++++++++++++++++++++++++++++++++++
 1 files changed, 151 insertions(+), 0 deletions(-)

diff --git a/options.c b/options.c
index e422c0d..28296a5 100644
--- a/options.c
+++ b/options.c
@@ -52,6 +52,8 @@
 #include "configure.h"
 #include "forward.h"
 #include <ctype.h>
+#include <unistd.h>
+#include <libgen.h>
 
 #include "memdbg.h"
 
@@ -2592,6 +2594,152 @@ options_postprocess_mutate (struct options *o)
 }
 
 /*
+ *  Check file/directory sanity
+ *
+ */
+#ifndef ENABLE_SMALL  /** Expect people using the stripped down version to know what they do */
+
+#define CHKACC_FILE (1<<0)       /** Check for a file/directory precense */
+#define CHKACC_DIRPATH (1<<1)    /** Check for directory precense where a file should reside */
+#define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
+
+static bool
+check_file_access(const int type, const char *file, const int mode, const char *opt)
+{
+  int errcode = 0;
+
+  /* If no file configured, no errors to look for */
+  if (!file)
+      return false;
+
+  /* Is the directory path leading to the given file accessible? */
+  if (type & CHKACC_DIRPATH)
+    {
+      char *fullpath = strdup(file);  /* POSIX dirname() implementaion may modify its arguments */
+      char *dirpath = dirname(fullpath);
+
+      if (access (dirpath, mode|X_OK) != 0)
+          errcode = errno;
+      free(fullpath);
+    }
+
+  /* Is the file itself accessible? */
+  if (!errcode && (type & CHKACC_FILE) && (access (file, mode) != 0) )
+      errcode = errno;
+
+  /* If the file exists and is accessible, is it writable? */
+  if (!errcode && (type & CHKACC_FILEXSTWR) && (access (file, F_OK) == 0) )
+    if (access (file, W_OK) != 0)
+      errcode = errno;
+
+  /* Scream if an error is found */
+  if( errcode > 0 )
+    msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': %s",
+         opt, file, strerror(errno));
+
+  /* Return true if an error occured */
+  return (errcode != 0 ? true : false);
+}
+
+/*
+ * Sanity check of all file/dir options.  Checks that file/dir
+ * is accessible by OpenVPN
+ */
+static void
+options_postprocess_filechecks (struct options *options)
+{
+  bool errs = false;
+
+  /* ** SSL/TLS/crypto related files ** */
+#ifdef USE_SSL
+  errs |= check_file_access (CHKACC_FILE, options->dh_file, R_OK, "--dh");
+  errs |= check_file_access (CHKACC_FILE, options->ca_file, R_OK, "--ca");
+  errs |= check_file_access (CHKACC_FILE, options->ca_path, R_OK, "--capath");
+  errs |= check_file_access (CHKACC_FILE, options->cert_file, R_OK, "--cert");
+  errs |= check_file_access (CHKACC_FILE, options->extra_certs_file, R_OK,
+                             "--extra-certs");
+  errs |= check_file_access (CHKACC_FILE, options->priv_key_file, R_OK,
+                             "--key");
+  errs |= check_file_access (CHKACC_FILE, options->pkcs12_file, R_OK,
+                             "--pkcs12");
+  if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
+    errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK|X_OK,
+                               "--crl-verify directory");
+  else
+    errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK,
+                               "--crl-verify");
+  errs |= check_file_access (CHKACC_FILE, options->tls_auth_file, R_OK,
+                             "--tls-auth");
+#endif /* USE_SSL */
+#ifdef USE_CRYPTO
+  errs |= check_file_access (CHKACC_FILE, options->shared_secret_file, R_OK,
+                             "--secret");
+  errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR,
+                             options->packet_id_file, R_OK|W_OK, "--replay-persist");
+#endif /* USE_CRYPTO */
+
+
+  /* ** Password files ** */
+#ifdef USE_SSL
+  errs |= check_file_access (CHKACC_FILE, options->key_pass_file, R_OK,
+                             "--askpass");
+#endif /* USE_SSL */
+#ifdef ENABLE_MANAGEMENT
+  errs |= check_file_access (CHKACC_FILE, options->management_user_pass, R_OK,
+                             "--management user/password file");
+#endif /* ENABLE_MANAGEMENT */
+  errs |= check_file_access (CHKACC_FILE, options->auth_user_pass_file, R_OK,
+                             "--auth-user-pass");
+
+
+  /* ** System related ** */
+  errs |= check_file_access (CHKACC_FILE, options->chroot_dir,
+                             R_OK|X_OK, "--chroot directory");
+  errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->writepid,
+                             R_OK|W_OK, "--writepid");
+  errs |= check_file_access (CHKACC_FILE, options->tmp_dir,
+                             R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
+
+  /* ** Log related ** */
+  errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->status_file,
+                             R_OK|W_OK, "--status");
+
+  /* ** Config related ** */
+#ifdef USE_CRYPTO
+  errs |= check_file_access (CHKACC_FILE, options->tls_export_cert,
+                             R_OK|W_OK|X_OK, "--tls-export-cert");
+#endif /* USE_CRYPTO */
+  errs |= check_file_access (CHKACC_FILE, options->client_config_dir,
+                             R_OK|X_OK, "--client-config-dir");
+
+  /* ** Script hooks ** */
+#if P2MP_SERVER
+  errs |= check_file_access (CHKACC_FILE, options->client_connect_script,
+                             R_OK|X_OK, "--client-connect script");
+  errs |= check_file_access (CHKACC_FILE, options->client_disconnect_script,
+                             R_OK|X_OK, "--client-disconnect script");
+  errs |= check_file_access (CHKACC_FILE, options->auth_user_pass_verify_script,
+                             R_OK|X_OK, "--auth-user-pass-verify script");
+  errs |= check_file_access (CHKACC_FILE, options->tls_verify,
+                             R_OK|X_OK, "--tls-verify script");
+  errs |= check_file_access (CHKACC_FILE, options->up_script,
+                             R_OK|X_OK, "--up script");
+  errs |= check_file_access (CHKACC_FILE, options->down_script,
+                             R_OK|X_OK, "--down script");
+  errs |= check_file_access (CHKACC_FILE, options->ipchange,
+                             R_OK|X_OK, "--ipchange script");
+  errs |= check_file_access (CHKACC_FILE, options->route_script,
+                             R_OK|X_OK, "--route-up script");
+  errs |= check_file_access (CHKACC_FILE, options->learn_address_script,
+                             R_OK|X_OK, "--learn-address script");
+#endif /* P2MP_SERVER */
+
+  if (errs)
+    msg (M_USAGE, "Please correct these errors.");
+}
+#endif /* !ENABLE_SMALL */
+
+/*
  * Sanity check on options.
  * Also set some options based on other
  * options.
@@ -2601,6 +2749,9 @@ options_postprocess (struct options *options)
 {
   options_postprocess_mutate (options);
   options_postprocess_verify (options);
+#ifndef ENABLE_SMALL
+  options_postprocess_filechecks (options);
+#endif /* !ENABLE_SMALL */
 }
 
 #if P2MP
-- 
1.7.4.4


