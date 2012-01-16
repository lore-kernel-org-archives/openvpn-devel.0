From: David Sommerseth <davids@...1347...>
Date: Mon, 16 Jan 2012 12:04:18 +0100
Message-Id: <1326711858-18337-1-git-send-email-davids@...1347...>
In-Reply-To: <1326709901-16246-1-git-send-email-davids@...1347...>
References: <1326709901-16246-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH v2] Don't check for file presence on inline
	files
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
Cc: dazo@...1345...

The configuration file supports inline files for --ca, --cert, --dh,
--extra-certs, --key, --pkcs12, --secret and --tls-auth.  When this
is used, the filename is set to [[INLINE]] (defined by INLINE_FILE_TAG).

If the filename is set to INLINE_FILE_TAG for these options, don't
call check_file_access().

[v2 Simplify the code, using a flag to check_file_access()]

Signed-off-by: David Sommerseth <davids@...1347...>
---
 options.c |   23 +++++++++++++++--------
 1 files changed, 15 insertions(+), 8 deletions(-)

diff --git a/options.c b/options.c
index 562c6f6..e7e6565 100644
--- a/options.c
+++ b/options.c
@@ -2603,6 +2603,7 @@ options_postprocess_mutate (struct options *o)
 #define CHKACC_FILE (1<<0)       /** Check for a file/directory precense */
 #define CHKACC_DIRPATH (1<<1)    /** Check for directory precense where a file should reside */
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
+#define CHKACC_INLINE (1<<3)     /** File is present if it's an inline file */
 
 static bool
 check_file_access(const int type, const char *file, const int mode, const char *opt)
@@ -2613,6 +2614,10 @@ check_file_access(const int type, const char *file, const int mode, const char *
   if (!file)
       return false;
 
+  /* If this may be an inline file, and the proper inline "filename" is set - no issues */
+  if ((type & CHKACC_INLINE) && streq(file, INLINE_FILE_TAG) )
+    return false;
+
   /* Is the directory path leading to the given file accessible? */
   if (type & CHKACC_DIRPATH)
     {
@@ -2653,27 +2658,29 @@ options_postprocess_filechecks (struct options *options)
 
   /* ** SSL/TLS/crypto related files ** */
 #ifdef USE_SSL
-  errs |= check_file_access (CHKACC_FILE, options->dh_file, R_OK, "--dh");
-  errs |= check_file_access (CHKACC_FILE, options->ca_file, R_OK, "--ca");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
   errs |= check_file_access (CHKACC_FILE, options->ca_path, R_OK, "--capath");
-  errs |= check_file_access (CHKACC_FILE, options->cert_file, R_OK, "--cert");
-  errs |= check_file_access (CHKACC_FILE, options->extra_certs_file, R_OK,
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
                              "--extra-certs");
-  errs |= check_file_access (CHKACC_FILE, options->priv_key_file, R_OK,
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->priv_key_file, R_OK,
                              "--key");
-  errs |= check_file_access (CHKACC_FILE, options->pkcs12_file, R_OK,
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->pkcs12_file, R_OK,
                              "--pkcs12");
+
   if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
     errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK|X_OK,
                                "--crl-verify directory");
   else
     errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK,
                                "--crl-verify");
-  errs |= check_file_access (CHKACC_FILE, options->tls_auth_file, R_OK,
+
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_auth_file, R_OK,
                              "--tls-auth");
 #endif /* USE_SSL */
 #ifdef USE_CRYPTO
-  errs |= check_file_access (CHKACC_FILE, options->shared_secret_file, R_OK,
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->shared_secret_file, R_OK,
                              "--secret");
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR,
                              options->packet_id_file, R_OK|W_OK, "--replay-persist");
-- 
1.7.4.4


