From: David Sommerseth <davids@...1347...>
Date: Mon, 16 Jan 2012 11:31:41 +0100
Message-Id: <1326709901-16246-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Don't check for file presence on inline
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

Signed-off-by: David Sommerseth <davids@...1347...>
---
 options.c |   37 ++++++++++++++++++++++++++-----------
 1 files changed, 26 insertions(+), 11 deletions(-)

diff --git a/options.c b/options.c
index 562c6f6..573bde5 100644
--- a/options.c
+++ b/options.c
@@ -2653,24 +2653,39 @@ options_postprocess_filechecks (struct options *options)
 
   /* ** SSL/TLS/crypto related files ** */
 #ifdef USE_SSL
-  errs |= check_file_access (CHKACC_FILE, options->dh_file, R_OK, "--dh");
-  errs |= check_file_access (CHKACC_FILE, options->ca_file, R_OK, "--ca");
+  if( options->dh_file && !streq(options->dh_file, INLINE_FILE_TAG) )
+    errs |= check_file_access (CHKACC_FILE, options->dh_file, R_OK, "--dh");
+
   errs |= check_file_access (CHKACC_FILE, options->ca_path, R_OK, "--capath");
-  errs |= check_file_access (CHKACC_FILE, options->cert_file, R_OK, "--cert");
-  errs |= check_file_access (CHKACC_FILE, options->extra_certs_file, R_OK,
-                             "--extra-certs");
-  errs |= check_file_access (CHKACC_FILE, options->priv_key_file, R_OK,
-                             "--key");
-  errs |= check_file_access (CHKACC_FILE, options->pkcs12_file, R_OK,
-                             "--pkcs12");
+
+  if( options->ca_file && !streq(options->ca_file, INLINE_FILE_TAG) )
+    errs |= check_file_access (CHKACC_FILE, options->ca_file, R_OK, "--ca");
+
+  if( options->cert_file && !streq(options->cert_file, INLINE_FILE_TAG) )
+    errs |= check_file_access (CHKACC_FILE, options->cert_file, R_OK, "--cert");
+
+  if( options->extra_certs_file && !streq(options->extra_certs_file, INLINE_FILE_TAG) )
+    errs |= check_file_access (CHKACC_FILE, options->extra_certs_file, R_OK,
+                               "--extra-certs");
+
+  if( options->priv_key_file && !streq(options->priv_key_file, INLINE_FILE_TAG) )
+    errs |= check_file_access (CHKACC_FILE, options->priv_key_file, R_OK,
+                               "--key");
+
+  if( options->pkcs12_file && !streq(options->pkcs12_file, INLINE_FILE_TAG) )
+    errs |= check_file_access (CHKACC_FILE, options->pkcs12_file, R_OK,
+                               "--pkcs12");
+
   if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
     errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK|X_OK,
                                "--crl-verify directory");
   else
     errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK,
                                "--crl-verify");
-  errs |= check_file_access (CHKACC_FILE, options->tls_auth_file, R_OK,
-                             "--tls-auth");
+
+  if( options->tls_auth_file && !streq(options->tls_auth_file, INLINE_FILE_TAG) )
+    errs |= check_file_access (CHKACC_FILE, options->tls_auth_file, R_OK,
+                               "--tls-auth");
 #endif /* USE_SSL */
 #ifdef USE_CRYPTO
   errs |= check_file_access (CHKACC_FILE, options->shared_secret_file, R_OK,
-- 
1.7.4.4


