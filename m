From: Arne Schwabe <arne@...1227...>
Date: Thu,  2 Aug 2012 15:37:48 +0200
Message-Id: <1343914668-10696-1-git-send-email-arne@...1227...>
In-Reply-To: <1343837470-3923-2-git-send-email-arne@...1227...>
References: <1343837470-3923-2-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 1/4] Fixes error: --key fails with
	EXTERNAL_PRIVATE_KEY: No such file or directory if
	--management-external-key is used
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

Warn if both options are used at the same time.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c |   17 +++++++++++++++--
 1 file changed, 15 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9f4ddbb..39dceb8 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1581,6 +1581,12 @@ show_settings (const struct options *o)
   SHOW_STR (ca_path);
   SHOW_STR (dh_file);
   SHOW_STR (cert_file);
+
+#ifdef MANAGMENT_EXTERNAL_KEY
+  if((options->management_flags & MF_EXTERNAL_KEY))
+	SHOW_PARM ("priv_key_file","EXTERNAL_PRIVATE_KEY","%s");
+  else 
+#endif
   SHOW_STR (priv_key_file);
 #ifndef ENABLE_CRYPTO_POLARSSL
   SHOW_STR (pkcs12_file);
@@ -2181,6 +2187,11 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
       else
 #endif
 #ifdef ENABLE_CRYPTOAPI
+#ifdef MANAGMENT_EXTERNAL_KEY
+	 if((options->management_flags & MF_EXTERNAL_KEY) && options->priv_key_file)
+		msg (M_USAGE, "--key and --management-external-key are mutually exclusive");
+#endif
+
       if (options->cryptoapi_cert)
 	{
 	  if ((!(options->ca_file)) && (!(options->ca_path)))
@@ -2627,7 +2638,10 @@ options_postprocess_filechecks (struct options *options)
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
                              "--extra-certs");
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->priv_key_file, R_OK,
+#ifdef MANAGMENT_EXTERNAL_KEY
+  if(!options->management_flags & MF_EXTERNAL_KEY)
+#endif
+     errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->priv_key_file, R_OK,
                              "--key");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->pkcs12_file, R_OK,
                              "--pkcs12");
@@ -4141,7 +4155,6 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->management_flags |= MF_EXTERNAL_KEY;
-      options->priv_key_file = "EXTERNAL_PRIVATE_KEY";
     }
 #endif
 #ifdef MANAGEMENT_DEF_AUTH
-- 
1.7.9.6 (Apple Git-31.1)


