From: David Sommerseth <davids@...1347...>
Date: Wed, 14 Dec 2011 18:15:19 +0100
Message-Id: <1323882919-2145-1-git-send-email-davids@...1347...>
Subject: [Openvpn-devel] [PATCH] Fix compiling with --disable-crypto and/or
	--disable-ssl
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

The checks introduced in commit 0f2bc0dd92f43c91e33bba8a66b06b98f281efc1
didn't properly remove checks if crypto or SSL was disabled at compile time.

Signed-off-by: David Sommerseth <davids@...1347...>
---
 options.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/options.c b/options.c
index 27193ff..736495e 100644
--- a/options.c
+++ b/options.c
@@ -2691,10 +2691,11 @@ options_postprocess_filechecks (struct options *options)
   errs |= check_file_access (CHKACC_FILE, options->management_user_pass, R_OK,
                              "--management user/password file");
 #endif /* ENABLE_MANAGEMENT */
+#if P2MP
   if( options->auth_user_pass_file && strcmp(options->auth_user_pass_file, "stdin") != 0 )
     errs |= check_file_access (CHKACC_FILE, options->auth_user_pass_file, R_OK,
                                "--auth-user-pass");
-
+#endif /* P2MP */
 
   /* ** System related ** */
   errs |= check_file_access (CHKACC_FILE, options->chroot_dir,
@@ -2709,15 +2710,14 @@ options_postprocess_filechecks (struct options *options)
                              R_OK|W_OK, "--status");
 
   /* ** Config related ** */
-#ifdef USE_CRYPTO
+#ifdef USE_SSL
   errs |= check_file_access (CHKACC_FILE, options->tls_export_cert,
                              R_OK|W_OK|X_OK, "--tls-export-cert");
-#endif /* USE_CRYPTO */
+#endif /* USE_SSL */
+#if P2MP_SERVER
   errs |= check_file_access (CHKACC_FILE, options->client_config_dir,
                              R_OK|X_OK, "--client-config-dir");
-
   /* ** Script hooks ** */
-#if P2MP_SERVER
   errs |= check_file_access (CHKACC_FILE, options->client_connect_script,
                              R_OK|X_OK, "--client-connect script");
   errs |= check_file_access (CHKACC_FILE, options->client_disconnect_script,
-- 
1.7.4.4


