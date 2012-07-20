From: Arne Schwabe <arne@...1227...>
Date: Sat, 21 Jul 2012 01:02:39 +0200
Message-Id: <1342825360-28401-1-git-send-email-arne@...1227...>
In-Reply-To: <4FED9331.5080601@...1227...>
References: <4FED9331.5080601@...1227...>
Subject: [Openvpn-devel] [PATCH] If --management-external-key is used do not
	check for private key file existence
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

Fixes error:  --key fails with EXTERNAL_PRIVATE_KEY: No such file or directory if  --management-external-key is used

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/options.c |   13 ++++++++++++-
 1 file changed, 12 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index cd1cb1c..7041e94 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1930,6 +1930,15 @@ options_postprocess_verify_ce (const struct options *options, const struct conne
   if ((options->management_client_user || options->management_client_group)
       && !(options->management_flags & MF_UNIX_SOCK))
     msg (M_USAGE, "--management-client-(user|group) can only be used on unix domain sockets");
+#ifdef MANAGMENT_EXTERNAL_KEY
+  if(options->management_flags & MF_EXTERNAL_KEY) {
+	  if(options->priv_key_file)
+		  msg (M_USAGE, "--key and --management-external-key are mutually exclusive");
+	  /* set a filename for nicer output in the logs */
+	  options->priv_key_file = "EXTERNAL_PRIVATE_KEY";
+  }
+#endif
+
 #endif
 
   /*
@@ -2627,6 +2636,9 @@ options_postprocess_filechecks (struct options *options)
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
                              "--extra-certs");
+#ifdef MANAGMENT_EXTERNAL_KEY
+  if(!options->management_flags & MF_EXTERNAL_KEY)
+#endif
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->priv_key_file, R_OK,
                              "--key");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->pkcs12_file, R_OK,
@@ -4141,7 +4153,6 @@ add_option (struct options *options,
     {
       VERIFY_PERMISSION (OPT_P_GENERAL);
       options->management_flags |= MF_EXTERNAL_KEY;
-      options->priv_key_file = "EXTERNAL_PRIVATE_KEY";
     }
 #endif
 #ifdef MANAGEMENT_DEF_AUTH
-- 
1.7.9.5


