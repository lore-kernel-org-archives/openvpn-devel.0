From: Steffan Karger <steffan.karger@...1435...>
Date: Tue, 8 Nov 2016 21:18:21 +0100
Message-ID: <1478636302-9678-5-git-send-email-steffan.karger@...1435...>
In-Reply-To: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
References: <1478636302-9678-1-git-send-email-steffan.karger@...1435...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/5] Move private file access checks to
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

Signed-off-by: Steffan Karger <steffan.karger@...1435...>
---
 src/openvpn/crypto.c  |  5 +----
 src/openvpn/options.c | 36 ++++++++++++++++++++++--------------
 2 files changed, 23 insertions(+), 18 deletions(-)

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
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e9dc17e..c576e6e 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2694,6 +2694,7 @@ options_postprocess_mutate (struct options *o)
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
 #define CHKACC_INLINE (1<<3)     /** File is present if it's an inline file */
 #define CHKACC_ACPTSTDIN (1<<4)  /** If filename is stdin, it's allowed and "exists" */
+#define CHKACC_PRIVATE (1<<5)	 /** Warn if this (private) file is group/others accessible */
 
 static bool
 check_file_access(const int type, const char *file, const int mode, const char *opt)
@@ -2734,6 +2735,11 @@ check_file_access(const int type, const char *file, const int mode, const char *
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
@@ -2850,10 +2856,12 @@ options_postprocess_filechecks (struct options *options)
 #ifdef MANAGMENT_EXTERNAL_KEY
   if(!(options->management_flags & MF_EXTERNAL_KEY))
 #endif
-     errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->priv_key_file, R_OK,
-                             "--key");
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->pkcs12_file, R_OK,
-                             "--pkcs12");
+    {
+      errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+	  options->priv_key_file, R_OK, "--key");
+    }
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+      options->pkcs12_file, R_OK, "--pkcs12");
 
   if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
     errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->crl_file, R_OK|X_OK,
@@ -2862,26 +2870,26 @@ options_postprocess_filechecks (struct options *options)
     errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE|CHKACC_INLINE,
                                       options->crl_file, R_OK, "--crl-verify");
 
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_auth_file, R_OK,
-                             "--tls-auth");
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_crypt_file, R_OK,
-                             "--tls-crypt");
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->shared_secret_file, R_OK,
-                             "--secret");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+      options->tls_auth_file, R_OK, "--tls-auth");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+      options->tls_crypt_file, R_OK, "--tls-crypt");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE|CHKACC_PRIVATE,
+      options->shared_secret_file, R_OK, "--secret");
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR,
-                             options->packet_id_file, R_OK|W_OK, "--replay-persist");
+      options->packet_id_file, R_OK|W_OK, "--replay-persist");
 
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
-- 
2.7.4


