From: Steffan Karger <steffan.karger@...1435...>
Date: Sun, 13 Nov 2016 15:02:31 +0100
Message-ID: <1479045751-22297-1-git-send-email-steffan.karger@...1435...>
In-Reply-To: <ebff9678-bfd1-845d-8d1c-16b9eef8be36@...2080...>
References: <ebff9678-bfd1-845d-8d1c-16b9eef8be36@...2080...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/5 v2] Move private file access checks to
	options_postprocess_filechecks()
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

From: Steffan Karger <steffan@...1856...>

This removes the dependency of crypto.c on misc.c, which makes testing
(stuff that needs) crypto.c functionality easier.  In particular, this
simplifies the --tls-crypt tests in one of the follow-up patches.

Apart from that, testing file access really belongs in
options_postprocess_filechecks(), and moving it there enables us to
perform the same check for other private files too.

v2: change indenting, remove remaining warn_if_group_others_accessible()
    calls and move function to options.c.

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto.c      |  5 +---
 src/openvpn/misc.c        | 27 ---------------------
 src/openvpn/misc.h        |  3 ---
 src/openvpn/options.c     | 61 ++++++++++++++++++++++++++++++++++++-----------
 src/openvpn/ssl_mbedtls.c |  2 --
 src/openvpn/ssl_openssl.c |  2 --
 6 files changed, 48 insertions(+), 52 deletions(-)

diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index ab43005..05622ce 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -36,7 +36,7 @@
 #include "crypto.h"
 #include "error.h"
 #include "integer.h"
-#include "misc.h"
+#include "platform.h"
 
 #include "memdbg.h"
 
@@ -1307,9 +1307,6 @@ read_key_file (struct key2 *key2, const char *file, const unsigned int flags)
   if (!(flags & RKF_INLINE))
     buf_clear (&in);
 
-  if (key2->n)
-    warn_if_group_others_accessible (error_filename);
-
 #if 0
   /* DEBUGGING */
   {
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 3d40f0b..ea0d75d 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -194,31 +194,6 @@ save_inetd_socket_descriptor (void)
 }
 
 /*
- * Warn if a given file is group/others accessible.
- */
-void
-warn_if_group_others_accessible (const char* filename)
-{
-#ifndef WIN32
-#ifdef HAVE_STAT
-  if (strcmp (filename, INLINE_FILE_TAG))
-    {
-      struct stat st;
-      if (stat (filename, &st))
-	{
-	  msg (M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", filename);
-	}
-      else
-	{
-	  if (st.st_mode & (S_IRWXG|S_IRWXO))
-	    msg (M_WARN, "WARNING: file '%s' is group or others accessible", filename);
-	}
-    }
-#endif
-#endif
-}
-
-/*
  * Print an error message based on the status code returned by system().
  */
 const char *
@@ -1115,8 +1090,6 @@ get_user_pass_cr (struct user_pass *up,
           FILE *fp;
           char password_buf[USER_PASS_LEN] = { '\0' };
 
-          warn_if_group_others_accessible (auth_file);
-
           fp = platform_fopen (auth_file, "r");
           if (!fp)
             msg (M_ERR, "Error opening '%s' auth file: %s", prefix, auth_file);
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index ceda323..cc0a474 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -71,9 +71,6 @@ void run_up_down (const char *command,
 
 void write_pid (const char *filename);
 
-/* check file protections */
-void warn_if_group_others_accessible(const char* filename);
-
 /* system flags */
 #define S_SCRIPT (1<<0)
 #define S_FATAL  (1<<1)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e9dc17e..17732ce 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2689,11 +2689,37 @@ options_postprocess_mutate (struct options *o)
  */
 #ifndef ENABLE_SMALL  /** Expect people using the stripped down version to know what they do */
 
+/*
+ * Warn if a given file is group/others accessible.
+ */
+static void
+warn_if_group_others_accessible (const char* filename)
+{
+#ifndef WIN32
+#ifdef HAVE_STAT
+  if (strcmp (filename, INLINE_FILE_TAG))
+    {
+      struct stat st;
+      if (stat (filename, &st))
+	{
+	  msg (M_WARN | M_ERRNO, "WARNING: cannot stat file '%s'", filename);
+	}
+      else
+	{
+	  if (st.st_mode & (S_IRWXG|S_IRWXO))
+	    msg (M_WARN, "WARNING: file '%s' is group or others accessible", filename);
+	}
+    }
+#endif
+#endif
+}
+
 #define CHKACC_FILE (1<<0)       /** Check for a file/directory precense */
 #define CHKACC_DIRPATH (1<<1)    /** Check for directory precense where a file should reside */
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
 #define CHKACC_INLINE (1<<3)     /** File is present if it's an inline file */
 #define CHKACC_ACPTSTDIN (1<<4)  /** If filename is stdin, it's allowed and "exists" */
+#define CHKACC_PRIVATE (1<<5)	 /** Warn if this (private) file is group/others accessible */
 
 static bool
 check_file_access(const int type, const char *file, const int mode, const char *opt)
@@ -2734,6 +2760,11 @@ check_file_access(const int type, const char *file, const int mode, const char *
     if (platform_access (file, W_OK) != 0)
       errcode = errno;
 
+  if (type & CHKACC_PRIVATE)
+    {
+      warn_if_group_others_accessible (file);
+    }
+
   /* Scream if an error is found */
   if( errcode > 0 )
     msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': %s",
@@ -2850,10 +2881,12 @@ options_postprocess_filechecks (struct options *options)
 #ifdef MANAGMENT_EXTERNAL_KEY
   if(!(options->management_flags & MF_EXTERNAL_KEY))
 #endif
-     errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->priv_key_file, R_OK,
-                             "--key");
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->pkcs12_file, R_OK,
-                             "--pkcs12");
+    {
+      errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+				 options->priv_key_file, R_OK, "--key");
+    }
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+			     options->pkcs12_file, R_OK, "--pkcs12");
 
   if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
     errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->crl_file, R_OK|X_OK,
@@ -2862,26 +2895,26 @@ options_postprocess_filechecks (struct options *options)
     errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE|CHKACC_INLINE,
                                       options->crl_file, R_OK, "--crl-verify");
 
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_auth_file, R_OK,
-                             "--tls-auth");
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_crypt_file, R_OK,
-                             "--tls-crypt");
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->shared_secret_file, R_OK,
-                             "--secret");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+			     options->tls_auth_file, R_OK, "--tls-auth");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+			     options->tls_crypt_file, R_OK, "--tls-crypt");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+			     options->shared_secret_file, R_OK, "--secret");
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR,
-                             options->packet_id_file, R_OK|W_OK, "--replay-persist");
+			     options->packet_id_file, R_OK|W_OK, "--replay-persist");
 
   /* ** Password files ** */
-  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
+  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
                              options->key_pass_file, R_OK, "--askpass");
 #endif /* ENABLE_CRYPTO */
 #ifdef ENABLE_MANAGEMENT
-  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
+  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
                              options->management_user_pass, R_OK,
                              "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
 #if P2MP
-  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
+  errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN|CHKACC_PRIVATE,
                              options->auth_user_pass_file, R_OK,
                              "--auth-user-pass");
 #endif /* P2MP */
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 4414f01..ea6d4c4 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -361,8 +361,6 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
       return 1;
     }
 
-  warn_if_group_others_accessible (priv_key_file);
-
   if (!mbed_ok(mbedtls_pk_check_pair(&ctx->crt_chain->pk, ctx->priv_key)))
     {
       msg (M_WARN, "Private key does not match the certificate");
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 7002907..3064c20 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -582,7 +582,6 @@ tls_ctx_load_pkcs12(struct tls_root_ctx *ctx, const char *pkcs12_file,
   /* Load Private Key */
   if (!SSL_CTX_use_PrivateKey (ctx->ctx, pkey))
     crypto_msg (M_FATAL, "Cannot use private key");
-  warn_if_group_others_accessible (pkcs12_file);
 
   /* Check Private Key */
   if (!SSL_CTX_check_private_key (ctx->ctx))
@@ -758,7 +757,6 @@ tls_ctx_load_priv_file (struct tls_root_ctx *ctx, const char *priv_key_file,
       crypto_msg (M_WARN, "Cannot load private key file %s", priv_key_file);
       goto end;
     }
-  warn_if_group_others_accessible (priv_key_file);
 
   /* Check Private Key */
   if (!SSL_CTX_check_private_key (ssl_ctx))
-- 
2.7.4


