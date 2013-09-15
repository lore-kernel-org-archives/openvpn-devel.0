From: Josh Cepek <josh.cepek@...1085...>
Date: Sun, 15 Sep 2013 04:42:50 -0500
Message-ID: <l142b7$15v$1@...1062...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------040406000903030603000505"
Subject: [Openvpn-devel] [PATCH] Fix file access checks when using --chroot
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

This is a multi-part message in MIME format.
--------------040406000903030603000505
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

The attached patch fixes bug #330 which causes a regression from 2.2.x
where valid configs won't work in certain cases when using --chroot. A
more terse overview of the change is presented in the patch itself.

The additional error checking for files & scripts introduced for 2.3
don't take into account that the file path changes after the chroot
operation, preventing options_postprocess_filechecks() from checking the
proper paths.

The changes in this patch intelligently look at the pre-chroot path when
required by appending the "in-chroot" path after the specified chroot
dir. To bring in support for dynamic string/memory management and the
ability to see if chroot is used, some callers were also modified to
pass in pointers to the options struct. Additionally, some bitmask
#defines were included even with ENABLE_SMALL as the set_user_script()
callers in option_add() need the ability to define if the script in
question is accessed from within the chroot or not so the access checks
can be made properly.

Besides the low-impact #define changes, all the impacted code is not
built with ENABLE_SMALL, so this shouldn't be a problem for embedded
systems. I also tried to be helpful with the error messages returned
from check_file_access() by informing users if the failing path is
pre-chroot since the text won't match a direct string supplied but a
combination of two.

On a much smaller note, there seemed to be a mix of indent styles in a
few places where apparent alignment was made for tabs expanding to 8
spaces; I have aligned this patch assuming a tab is 2 spaces, leaving
the issue of whitespace cleanup for a separate patch. All new lines use
spaces only.


- --
Josh
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.20 (GNU/Linux)

iQGcBAEBAgAGBQJSNYEZAAoJENcx2Xpgb9Rjm6gL/1epNkDRCWMEjb/GGo86ECk4
092oQNmAS8fssD2y0YULJ7xKT5O6JUq+yCIsxjHMIpBpeRBmn+nwVTP33gPdFNFb
RYg1eIUb/EL0to56S7tSm+018aW80LH5fp8CyQcpTWHJd5sW1sYwxtLmk1Ho6cAb
4bKy709sOZfSIvqhBHe342izqFtPWsO0RV16NrFL7vKbr+ubc3hgGiEEB/f+U3n9
S/kbQXbrcBi5OUsjbulNAgOyR641rS3CcE7pde/dxMVo21OBmDiXkzksHFpugLlv
xhaa3JqM2KCiJb+x04N7WT9F+h7UPsvyc4P+gyccb/UVPgdE3SR2ERlwv8x2uSqy
7/sMrGaT9pwfd+P4bywBGvv+16VOeEwhItrX5sy9rGIsx1I0FiXpt7MROU2FERFB
sk/WRcEchXfB+Z9RSBZwtbeRf0w6dF7nCDOEr1NWTrLYGIX1Z+iZ4jXBzt+0qU3v
O518OD3QA7apvQqvptDl9ExY3LRu+H6y4WZWeapHwQ==
=V6Ck
-----END PGP SIGNATURE-----

--------------040406000903030603000505
Content-Type: text/x-diff;
 name="Fix-chroot-checks.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
 filename="Fix-chroot-checks.patch"

From 2b4a3b819ee2dd3d1bf1326d17b7baf8bfbf6f38 Mon Sep 17 00:00:00 2001
From: Josh Cepek <josh.cepek@...1085...>
Date: Sun, 15 Sep 2013 05:12:11 -0500
Subject: [PATCH] Fix file access checks when using --chroot

This fixes bug #330.

The additional error checking for files & scripts introduced for 2.3
don't take into account that the file path changes after the chroot
operation, preventing options_postprocess_filechecks() from checking the
proper paths.

The changes in this patch intelligently look at the pre-chroot path when
required by appending the "in-chroot" path after the specified chroot
dir. Error messages call attention to the use of the chroot and combined
path when there are access issues.

Signed-off-by: Josh Cepek <josh.cepek@...1085...>
---
 src/openvpn/options.c | 130 +++++++++++++++++++++++++++++++-------------------
 1 file changed, 81 insertions(+), 49 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4d0271f..ae32afd 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2560,16 +2560,19 @@ options_postprocess_mutate (struct options *o)
  *  Check file/directory sanity
  *
  */
-#ifndef ENABLE_SMALL  /** Expect people using the stripped down version to know what they do */
-
+#define CHKACC_NOOP 0            /** No-op - used by callers to add no additional checks */
 #define CHKACC_FILE (1<<0)       /** Check for a file/directory precense */
 #define CHKACC_DIRPATH (1<<1)    /** Check for directory precense where a file should reside */
 #define CHKACC_FILEXSTWR (1<<2)  /** If file exists, is it writable? */
 #define CHKACC_INLINE (1<<3)     /** File is present if it's an inline file */
 #define CHKACC_ACPTSTDIN (1<<4)  /** If filename is stdin, it's allowed and "exists" */
+#define CHKACC_INCHROOT (1<<5)   /** When chrooting, look for this file under the chroot dir */
+
+#ifndef ENABLE_SMALL  /** Expect people using the stripped down version to know what they do */
 
 static bool
-check_file_access(const int type, const char *file, const int mode, const char *opt)
+check_file_access(const int type, const char *file, const int mode, const char *opt,
+        struct options *o)
 {
   int errcode = 0;
 
@@ -2587,10 +2590,33 @@ check_file_access(const int type, const char *file, const int mode, const char *
   if( (type & CHKACC_ACPTSTDIN) && streq(file, "stdin") )
       return false;
 
+  struct gc_arena gc = gc_new();
+
+  /* Define the real file to look at based on possible chroot usage.
+   * If this this file is in used within a chroot, look there when chroot is enabled
+   */
+  int buf_size = strlen(file) + 1;
+  if (o->chroot_dir)
+    buf_size += strlen(o->chroot_dir) + strlen(PATH_SEPARATOR_STR);
+  struct buffer buf_file = alloc_buf_gc (buf_size, &gc);
+
+  char extra_msg[50] = ""; /* Extra error message details when in chroot */
+  if ((type & CHKACC_INCHROOT) && o->chroot_dir )
+    {
+      buf_printf (&buf_file, "%s%s%s", o->chroot_dir, PATH_SEPARATOR_STR, file);
+      openvpn_snprintf (extra_msg, sizeof(extra_msg),
+                        " (pre-chroot path shown)");
+    }
+  else
+    buf_puts (&buf_file, file);
+
+  /* Probably unnecessary, but make sure buf_printf() didn't overflow and stay empty */
+  ASSERT (buf_file.len > 0); 
+
   /* Is the directory path leading to the given file accessible? */
   if (type & CHKACC_DIRPATH)
     {
-      char *fullpath = strdup(file);  /* POSIX dirname() implementaion may modify its arguments */
+      char *fullpath = strdup(BSTR(&buf_file));  /* POSIX dirname() implementaion may modify its arguments */
       char *dirpath = dirname(fullpath);
 
       if (platform_access (dirpath, mode|X_OK) != 0)
@@ -2599,18 +2625,20 @@ check_file_access(const int type, const char *file, const int mode, const char *
     }
 
   /* Is the file itself accessible? */
-  if (!errcode && (type & CHKACC_FILE) && (platform_access (file, mode) != 0) )
+  if (!errcode && (type & CHKACC_FILE) && (platform_access (BSTR(&buf_file), mode) != 0) )
       errcode = errno;
 
   /* If the file exists and is accessible, is it writable? */
-  if (!errcode && (type & CHKACC_FILEXSTWR) && (platform_access (file, F_OK) == 0) )
-    if (platform_access (file, W_OK) != 0)
+  if (!errcode && (type & CHKACC_FILEXSTWR) && (platform_access (BSTR(&buf_file), F_OK) == 0) )
+    if (platform_access (BSTR(&buf_file), W_OK) != 0)
       errcode = errno;
 
   /* Scream if an error is found */
   if( errcode > 0 )
-    msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': %s",
-         opt, file, strerror(errno));
+    msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': %s%s",
+         opt, BSTR(&buf_file), strerror(errno), extra_msg);
+
+  gc_free(&gc);
 
   /* Return true if an error occured */
   return (errcode != 0 ? true : false);
@@ -2633,7 +2661,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
  * check_file_access() arguments.
  */
 static bool
-check_cmd_access(const char *command, const char *opt)
+check_cmd_access(const char *command, const char *opt, struct options *options, int access_flags)
 {
   struct argv argv;
   bool return_code;
@@ -2652,7 +2680,7 @@ check_cmd_access(const char *command, const char *opt)
      * only requires X_OK to function on Unix - a scenario not unlikely to
      * be seen on suid binaries.
      */
-    return_code = check_file_access(CHKACC_FILE, argv.argv[0], X_OK, opt);
+    return_code = check_file_access(CHKACC_FILE|access_flags, argv.argv[0], X_OK, opt, options);
   else
     {
       msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': No path to executable.",
@@ -2676,74 +2704,74 @@ options_postprocess_filechecks (struct options *options)
 
   /* ** SSL/TLS/crypto related files ** */
 #ifdef ENABLE_SSL
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
-  errs |= check_file_access (CHKACC_FILE, options->ca_path, R_OK, "--capath");
-  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh", options);
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca", options);
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INCHROOT, options->ca_path, R_OK, "--capath", options);
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert", options);
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
-                             "--extra-certs");
+                             "--extra-certs", options);
 #ifdef MANAGMENT_EXTERNAL_KEY
   if(!(options->management_flags & MF_EXTERNAL_KEY))
 #endif
      errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->priv_key_file, R_OK,
-                             "--key");
+                             "--key", options);
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->pkcs12_file, R_OK,
-                             "--pkcs12");
+                             "--pkcs12", options);
 
   if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
-    errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK|X_OK,
-                               "--crl-verify directory");
+    errs |= check_file_access (CHKACC_FILE|CHKACC_INCHROOT, options->crl_file, R_OK|X_OK,
+                               "--crl-verify directory", options);
   else
-    errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK,
-                               "--crl-verify");
+    errs |= check_file_access (CHKACC_FILE|CHKACC_INCHROOT, options->crl_file, R_OK,
+                               "--crl-verify", options);
 
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_auth_file, R_OK,
-                             "--tls-auth");
+                             "--tls-auth", options);
 #endif /* ENABLE_SSL */
 #ifdef ENABLE_CRYPTO
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->shared_secret_file, R_OK,
-                             "--secret");
+                             "--secret", options);
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR,
-                             options->packet_id_file, R_OK|W_OK, "--replay-persist");
+                             options->packet_id_file, R_OK|W_OK, "--replay-persist", options);
 #endif /* ENABLE_CRYPTO */
 
 
   /* ** Password files ** */
 #ifdef ENABLE_SSL
   errs |= check_file_access (CHKACC_FILE, options->key_pass_file, R_OK,
-                             "--askpass");
+                             "--askpass", options);
 #endif /* ENABLE_SSL */
 #ifdef ENABLE_MANAGEMENT
   errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
                              options->management_user_pass, R_OK,
-                             "--management user/password file");
+                             "--management user/password file", options);
 #endif /* ENABLE_MANAGEMENT */
 #if P2MP
   errs |= check_file_access (CHKACC_FILE|CHKACC_ACPTSTDIN,
                              options->auth_user_pass_file, R_OK,
-                             "--auth-user-pass");
+                             "--auth-user-pass", options);
 #endif /* P2MP */
 
   /* ** System related ** */
   errs |= check_file_access (CHKACC_FILE, options->chroot_dir,
-                             R_OK|X_OK, "--chroot directory");
+                             R_OK|X_OK, "--chroot directory", options);
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->writepid,
-                             R_OK|W_OK, "--writepid");
+                             R_OK|W_OK, "--writepid", options);
 
   /* ** Log related ** */
   errs |= check_file_access (CHKACC_DIRPATH|CHKACC_FILEXSTWR, options->status_file,
-                             R_OK|W_OK, "--status");
+                             R_OK|W_OK, "--status", options);
 
   /* ** Config related ** */
 #ifdef ENABLE_SSL
-  errs |= check_file_access (CHKACC_FILE, options->tls_export_cert,
-                             R_OK|W_OK|X_OK, "--tls-export-cert");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INCHROOT, options->tls_export_cert,
+                             R_OK|W_OK|X_OK, "--tls-export-cert", options);
 #endif /* ENABLE_SSL */
 #if P2MP_SERVER
-  errs |= check_file_access (CHKACC_FILE, options->client_config_dir,
-                             R_OK|X_OK, "--client-config-dir");
-  errs |= check_file_access (CHKACC_FILE, options->tmp_dir,
-                             R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INCHROOT, options->client_config_dir,
+                             R_OK|X_OK, "--client-config-dir", options);
+  errs |= check_file_access (CHKACC_FILE|CHKACC_INCHROOT, options->tmp_dir,
+                             R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)", options);
 
 #endif /* P2MP_SERVER */
 
@@ -2758,6 +2786,7 @@ options_postprocess_filechecks (struct options *options)
  * options.
  */
 void
+
 options_postprocess (struct options *options)
 {
   options_postprocess_mutate (options);
@@ -4007,7 +4036,8 @@ static void
 set_user_script (struct options *options,
 		 const char **script,
 		 const char *new_script,
-		 const char *type)
+		 const char *type,
+     int access_flags)
 {
   if (*script) {
     msg (M_WARN, "Multiple --%s scripts defined.  "
@@ -4022,7 +4052,7 @@ set_user_script (struct options *options,
     openvpn_snprintf (script_name, sizeof(script_name),
                       "--%s script", type);
 
-    if (check_cmd_access (*script, script_name))
+    if (check_cmd_access (*script, script_name, options, access_flags))
       msg (M_USAGE, "Please correct this error.");
   }
 #endif
@@ -4541,7 +4571,8 @@ add_option (struct options *options,
       set_user_script (options,
 		       &options->ipchange,
 		       string_substitute (p[1], ',', ' ', &options->gc),
-		       "ipchange");
+		       "ipchange",
+           CHKACC_INCHROOT);
     }
   else if (streq (p[0], "float"))
     {
@@ -4587,14 +4618,14 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      set_user_script (options, &options->up_script, p[1], "up");
+      set_user_script (options, &options->up_script, p[1], "up", CHKACC_NOOP);
     }
   else if (streq (p[0], "down") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      set_user_script (options, &options->down_script, p[1], "down");
+      set_user_script (options, &options->down_script, p[1], "down", CHKACC_INCHROOT);
     }
   else if (streq (p[0], "down-pre"))
     {
@@ -5275,7 +5306,7 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      set_user_script (options, &options->route_script, p[1], "route-up");
+      set_user_script (options, &options->route_script, p[1], "route-up", CHKACC_NOOP);
     }
   else if (streq (p[0], "route-pre-down") && p[1])
     {
@@ -5285,7 +5316,8 @@ add_option (struct options *options,
       set_user_script (options,
 		       &options->route_predown_script,
 		       p[1],
-		       "route-pre-down");
+		       "route-pre-down",
+           CHKACC_INCHROOT);
     }
   else if (streq (p[0], "route-noexec"))
     {
@@ -5654,7 +5686,7 @@ add_option (struct options *options,
 	}
       set_user_script (options,
 		       &options->auth_user_pass_verify_script,
-		       p[1], "auth-user-pass-verify");
+		       p[1], "auth-user-pass-verify", CHKACC_INCHROOT);
     }
   else if (streq (p[0], "client-connect") && p[1])
     {
@@ -5662,7 +5694,7 @@ add_option (struct options *options,
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
       set_user_script (options, &options->client_connect_script,
-		       p[1], "client-connect");
+		       p[1], "client-connect", CHKACC_INCHROOT);
     }
   else if (streq (p[0], "client-disconnect") && p[1])
     {
@@ -5670,7 +5702,7 @@ add_option (struct options *options,
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
       set_user_script (options, &options->client_disconnect_script,
-		       p[1], "client-disconnect");
+		       p[1], "client-disconnect", CHKACC_INCHROOT);
     }
   else if (streq (p[0], "learn-address") && p[1])
     {
@@ -5678,7 +5710,7 @@ add_option (struct options *options,
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
       set_user_script (options, &options->learn_address_script,
-		       p[1], "learn-address");
+		       p[1], "learn-address", CHKACC_INCHROOT);
     }
   else if (streq (p[0], "tmp-dir") && p[1])
     {
@@ -6638,7 +6670,7 @@ add_option (struct options *options,
 	goto err;
       set_user_script (options, &options->tls_verify,
 		       string_substitute (p[1], ',', ' ', &options->gc),
-		       "tls-verify");
+		       "tls-verify", CHKACC_INCHROOT);
     }
 #ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "tls-export-cert") && p[1])
-- 
1.8.1.5


--------------040406000903030603000505
Content-Type: application/pgp-signature;
 name="Fix-chroot-checks.patch.sig"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="Fix-chroot-checks.patch.sig"

iQGcBAABAgAGBQJSNYEZAAoJENcx2Xpgb9RjL+4MAI5iCw06eBugj72yERe7cAST1mdsuAwB
12IF78A/UECRLzPHKg4pCrlqN32iZ16rHTf2HVWieuW1dDTFmczpuSh4o2KU7QmK7/98q/4X
BCxBIuR4fX1F+G/8ojjhvs4RgVhoAWgWZ4EqRbNmbSmboFkQefz9bySRxrLIAYKAA1ypewYG
hWwwfjZ9FHCKuCw/X4xGtBRd7UzwgvYWz9HSBnpKZKa3SE+Xo8u45fmbBXRHlEEEGTxqjH1s
0yEBhSudirRLfpFYoFvcZwu7y7V1Or/8KLWfhJBavFdThjc4b70JjhuruDvqP16Pc+LLm64X
IW5236T745LfQHCWMD6xzt4h8a1ZU7jRsqYh6/0XBkm4Jrj+ZauAspE/Sgjuo1uQfi31o3+Q
FsHaigEFbVRng1SO13iMWzdetwvn6GeCEFHXqddOEfDu62vf4mlY8b7v6MU1/VCkAmGSgD7o
ec+o3L6oTLJXznza4vYreDrcrQbug1Bzpe8wZce9gWUYVsW1cw==
--------------040406000903030603000505--


