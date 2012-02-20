From: Alon Bar-Lev <alon.barlev@...277...>
Date: Mon, 20 Feb 2012 16:45:21 +0200
Message-Id: <1329749121-24501-1-git-send-email-alon.barlev@...277...>
In-Reply-To: <CAOazyz08kLGKyq-Wcd1KTQ9akdQCAYPP9b1aMVne-b9TArMKDQ@...278...>
References: <CAOazyz08kLGKyq-Wcd1KTQ9akdQCAYPP9b1aMVne-b9TArMKDQ@...278...>
Subject: [Openvpn-devel] [PATCH] windows: do not use X_OK as it is
	unsupported
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
Cc: Alon Bar-Lev <alon.barlev@...277...>

Reported by Heiko Hund.
Reference [1].

Replaces 4ebc587eab73e03ef64d344a5707d84e7f8d875a

[1] http://msdn.microsoft.com/en-us/library/1w06ktdy%28v=vs.100%29.aspx

Signed-off-by: Alon Bar-Lev <alon.barlev@...277...>
---
 options.c       |   38 ++++++++++++++++++++++----------------
 win/config.h.in |    2 +-
 2 files changed, 23 insertions(+), 17 deletions(-)

diff --git a/options.c b/options.c
index a596ffe..3a433d4 100644
--- a/options.c
+++ b/options.c
@@ -55,6 +55,12 @@
 
 #include "memdbg.h"
 
+#ifdef WIN32
+#define PLATFORM_X_OK 0
+#else
+#define PLATFORM_X_OK X_OK
+#endif
+
 const char title_string[] =
   PACKAGE_STRING
   " " TARGET_ALIAS
@@ -2632,7 +2638,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
       char *fullpath = strdup(file);  /* POSIX dirname() implementaion may modify its arguments */
       char *dirpath = dirname(fullpath);
 
-      if (openvpn_access (dirpath, mode|X_OK) != 0)
+      if (openvpn_access (dirpath, mode|PLATFORM_X_OK) != 0)
           errcode = errno;
       free(fullpath);
     }
@@ -2678,7 +2684,7 @@ options_postprocess_filechecks (struct options *options)
                              "--pkcs12");
 
   if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
-    errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK|X_OK,
+    errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK|PLATFORM_X_OK,
                                "--crl-verify directory");
   else
     errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK,
@@ -2713,11 +2719,11 @@ options_postprocess_filechecks (struct options *options)
 
   /* ** System related ** */
   errs |= check_file_access (CHKACC_FILE, options->chroot_dir,
-                             R_OK|X_OK, "--chroot directory");
+                             R_OK|PLATFORM_X_OK, "--chroot directory");
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->writepid,
                              R_OK|W_OK, "--writepid");
   errs |= check_file_access (CHKACC_FILE, options->tmp_dir,
-                             R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
+                             R_OK|W_OK|PLATFORM_X_OK, "Temporary directory (--tmp-dir)");
 
   /* ** Log related ** */
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->status_file,
@@ -2726,32 +2732,32 @@ options_postprocess_filechecks (struct options *options)
   /* ** Config related ** */
 #ifdef USE_SSL
   errs |= check_file_access (CHKACC_FILE, options->tls_export_cert,
-                             R_OK|W_OK|X_OK, "--tls-export-cert");
+                             R_OK|W_OK|PLATFORM_X_OK, "--tls-export-cert");
 #endif /* USE_SSL */
 #if P2MP_SERVER
   errs |= check_file_access (CHKACC_FILE, options->client_config_dir,
-                             R_OK|X_OK, "--client-config-dir");
+                             R_OK|PLATFORM_X_OK, "--client-config-dir");
   /* ** Script hooks ** */
   errs |= check_file_access (CHKACC_FILE, options->client_connect_script,
-                             R_OK|X_OK, "--client-connect script");
+                             R_OK|PLATFORM_X_OK, "--client-connect script");
   errs |= check_file_access (CHKACC_FILE, options->client_disconnect_script,
-                             R_OK|X_OK, "--client-disconnect script");
+                             R_OK|PLATFORM_X_OK, "--client-disconnect script");
   errs |= check_file_access (CHKACC_FILE, options->auth_user_pass_verify_script,
-                             R_OK|X_OK, "--auth-user-pass-verify script");
+                             R_OK|PLATFORM_X_OK, "--auth-user-pass-verify script");
   errs |= check_file_access (CHKACC_FILE, options->tls_verify,
-                             R_OK|X_OK, "--tls-verify script");
+                             R_OK|PLATFORM_X_OK, "--tls-verify script");
   errs |= check_file_access (CHKACC_FILE, options->up_script,
-                             R_OK|X_OK, "--up script");
+                             R_OK|PLATFORM_X_OK, "--up script");
   errs |= check_file_access (CHKACC_FILE, options->down_script,
-                             R_OK|X_OK, "--down script");
+                             R_OK|PLATFORM_X_OK, "--down script");
   errs |= check_file_access (CHKACC_FILE, options->ipchange,
-                             R_OK|X_OK, "--ipchange script");
+                             R_OK|PLATFORM_X_OK, "--ipchange script");
   errs |= check_file_access (CHKACC_FILE, options->route_script,
-                             R_OK|X_OK, "--route-up script");
+                             R_OK|PLATFORM_X_OK, "--route-up script");
   errs |= check_file_access (CHKACC_FILE, options->route_predown_script,
-                             R_OK|X_OK, "--route-pre-down script");
+                             R_OK|PLATFORM_X_OK, "--route-pre-down script");
   errs |= check_file_access (CHKACC_FILE, options->learn_address_script,
-                             R_OK|X_OK, "--learn-address script");
+                             R_OK|PLATFORM_X_OK, "--learn-address script");
 #endif /* P2MP_SERVER */
 
   if (errs)
diff --git a/win/config.h.in b/win/config.h.in
index fcb8d6c..b5c31b8 100644
--- a/win/config.h.in
+++ b/win/config.h.in
@@ -243,7 +243,7 @@ typedef unsigned long in_addr_t;
 #endif
 
 #ifndef X_OK
-#define X_OK 0
+#define X_OK 1
 #endif
 
 #ifndef F_OK
-- 
1.7.3.4


