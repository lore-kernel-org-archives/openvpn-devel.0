From: David Sommerseth <dazo@...384...>
Date: Mon, 25 Nov 2013 13:32:58 +0100
Message-Id: <1385382778-4723-1-git-send-email-dazo@...384...>
In-Reply-To: <CAA1AbxJZa2gMBXpHiQuXD2J+8eOZCvQp+ftzrC49fH2HDfNACg@...278...>
References: <CAA1AbxJZa2gMBXpHiQuXD2J+8eOZCvQp+ftzrC49fH2HDfNACg@...278...>
Subject: [Openvpn-devel] [PATCH] Fix file checks when --chroot is being used
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

From: David Sommerseth <davids@...1347...>

Commit 0f2bc0dd92f43c9 started to introduce some file sanity
checking before OpenVPN started to avoid harder to explain issues
due to missing files or directories later on.  But that commit
did not consider --chroot at all.  Which would basically cause
OpenVPN to complain on non-missing files, because it would not
consider that the files where inside a chroot.

This patch is based on the thoughts in a patch by Josh Cepek [1],
but trying to simplify it at bit.

[1] <http://thread.gmane.org/gmane.network.openvpn.devel/7873>,
    (Message-ID: l142b7$15v$1@...1062...)

[v2 - Simplify the changes in check_cmd_access(), let the chroot
      tackling happen only in check_file_access_chroot() only]

Trac-ticket: 330
Signed-off-by: David Sommerseth <davids@...1347...>
---
 src/openvpn/options.c | 82 ++++++++++++++++++++++++++++++++++++++-------------
 1 file changed, 61 insertions(+), 21 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e925397..247442f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5,7 +5,7 @@
  *             packet encryption, packet authentication, and
  *             packet compression.
  *
- *  Copyright (C) 2002-2010 OpenVPN Technologies, Inc. <sales@...515...>
+ *  Copyright (C) 2002-2013 OpenVPN Technologies, Inc. <sales@...515...>
  *  Copyright (C) 2008-2013 David Sommerseth <dazo@...384...>
  *
  *  This program is free software; you can redistribute it and/or modify
@@ -2626,6 +2626,44 @@ check_file_access(const int type, const char *file, const int mode, const char *
   return (errcode != 0 ? true : false);
 }
 
+/* A wrapper for check_file_access() which also takes a chroot directory.
+ * If chroot is NULL, behaviour is exactly the same as calling check_file_access() directly,
+ * otherwise it will look for the file inside the given chroot directory instead.
+ */
+static bool
+check_file_access_chroot(const char *chroot, const int type, const char *file, const int mode, const char *opt)
+{
+  bool ret = false;
+
+  /* If no file configured, no errors to look for */
+  if (!file)
+      return false;
+
+  /* If chroot is set, look for the file/directory inside the chroot */
+  if( chroot )
+    {
+      struct gc_arena gc = gc_new();
+      struct buffer chroot_file;
+      int len = 0;
+
+      /* Build up a new full path including chroot directory */
+      len = strlen(chroot) + strlen(PATH_SEPARATOR_STR) + strlen(file) + 1;
+      chroot_file = alloc_buf_gc(len, &gc);
+      buf_printf(&chroot_file, "%s%s%s", chroot, PATH_SEPARATOR_STR, file);
+      ASSERT (chroot_file.len > 0);
+
+      ret = check_file_access(type, BSTR(&chroot_file), mode, opt);
+      gc_free(&gc);
+    }
+  else
+    {
+      /* No chroot in play, just call core file check function */
+      ret = check_file_access(type, file, mode, opt);
+    }
+  return ret;
+}
+
+
 /*
  * Verifies that the path in the "command" that comes after certain script options (e.g., --up) is a
  * valid file with appropriate permissions.
@@ -2643,7 +2681,7 @@ check_file_access(const int type, const char *file, const int mode, const char *
  * check_file_access() arguments.
  */
 static bool
-check_cmd_access(const char *command, const char *opt)
+check_cmd_access(const char *command, const char *opt, const char *chroot)
 {
   struct argv argv;
   bool return_code;
@@ -2662,7 +2700,7 @@ check_cmd_access(const char *command, const char *opt)
      * only requires X_OK to function on Unix - a scenario not unlikely to
      * be seen on suid binaries.
      */
-    return_code = check_file_access(CHKACC_FILE, argv.argv[0], X_OK, opt);
+    return_code = check_file_access_chroot(chroot, CHKACC_FILE, argv.argv[0], X_OK, opt);
   else
     {
       msg (M_NOPREFIX|M_OPTERR, "%s fails with '%s': No path to executable.",
@@ -2688,7 +2726,7 @@ options_postprocess_filechecks (struct options *options)
 #ifdef ENABLE_SSL
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->dh_file, R_OK, "--dh");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->ca_file, R_OK, "--ca");
-  errs |= check_file_access (CHKACC_FILE, options->ca_path, R_OK, "--capath");
+  errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->ca_path, R_OK, "--capath");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->cert_file, R_OK, "--cert");
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->extra_certs_file, R_OK,
                              "--extra-certs");
@@ -2701,10 +2739,10 @@ options_postprocess_filechecks (struct options *options)
                              "--pkcs12");
 
   if (options->ssl_flags & SSLF_CRL_VERIFY_DIR)
-    errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK|X_OK,
+    errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->crl_file, R_OK|X_OK,
                                "--crl-verify directory");
   else
-    errs |= check_file_access (CHKACC_FILE, options->crl_file, R_OK,
+    errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->crl_file, R_OK,
                                "--crl-verify");
 
   errs |= check_file_access (CHKACC_FILE|CHKACC_INLINE, options->tls_auth_file, R_OK,
@@ -2746,13 +2784,13 @@ options_postprocess_filechecks (struct options *options)
 
   /* ** Config related ** */
 #ifdef ENABLE_SSL
-  errs |= check_file_access (CHKACC_FILE, options->tls_export_cert,
+  errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->tls_export_cert,
                              R_OK|W_OK|X_OK, "--tls-export-cert");
 #endif /* ENABLE_SSL */
 #if P2MP_SERVER
-  errs |= check_file_access (CHKACC_FILE, options->client_config_dir,
+  errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->client_config_dir,
                              R_OK|X_OK, "--client-config-dir");
-  errs |= check_file_access (CHKACC_FILE, options->tmp_dir,
+  errs |= check_file_access_chroot (options->chroot_dir, CHKACC_FILE, options->tmp_dir,
                              R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
 
 #endif /* P2MP_SERVER */
@@ -4017,7 +4055,8 @@ static void
 set_user_script (struct options *options,
 		 const char **script,
 		 const char *new_script,
-		 const char *type)
+		 const char *type,
+		 bool in_chroot)
 {
   if (*script) {
     msg (M_WARN, "Multiple --%s scripts defined.  "
@@ -4032,8 +4071,9 @@ set_user_script (struct options *options,
     openvpn_snprintf (script_name, sizeof(script_name),
                       "--%s script", type);
 
-    if (check_cmd_access (*script, script_name))
+    if (check_cmd_access (*script, script_name, (in_chroot ? options->chroot_dir : NULL)))
       msg (M_USAGE, "Please correct this error.");
+
   }
 #endif
 }
@@ -4551,7 +4591,7 @@ add_option (struct options *options,
       set_user_script (options,
 		       &options->ipchange,
 		       string_substitute (p[1], ',', ' ', &options->gc),
-		       "ipchange");
+		       "ipchange", true);
     }
   else if (streq (p[0], "float"))
     {
@@ -4597,14 +4637,14 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      set_user_script (options, &options->up_script, p[1], "up");
+      set_user_script (options, &options->up_script, p[1], "up", false);
     }
   else if (streq (p[0], "down") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      set_user_script (options, &options->down_script, p[1], "down");
+      set_user_script (options, &options->down_script, p[1], "down", true);
     }
   else if (streq (p[0], "down-pre"))
     {
@@ -5312,7 +5352,7 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      set_user_script (options, &options->route_script, p[1], "route-up");
+      set_user_script (options, &options->route_script, p[1], "route-up", false);
     }
   else if (streq (p[0], "route-pre-down") && p[1])
     {
@@ -5322,7 +5362,7 @@ add_option (struct options *options,
       set_user_script (options,
 		       &options->route_predown_script,
 		       p[1],
-		       "route-pre-down");
+		       "route-pre-down", true);
     }
   else if (streq (p[0], "route-noexec"))
     {
@@ -5691,7 +5731,7 @@ add_option (struct options *options,
 	}
       set_user_script (options,
 		       &options->auth_user_pass_verify_script,
-		       p[1], "auth-user-pass-verify");
+		       p[1], "auth-user-pass-verify", true);
     }
   else if (streq (p[0], "client-connect") && p[1])
     {
@@ -5699,7 +5739,7 @@ add_option (struct options *options,
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
       set_user_script (options, &options->client_connect_script,
-		       p[1], "client-connect");
+		       p[1], "client-connect", true);
     }
   else if (streq (p[0], "client-disconnect") && p[1])
     {
@@ -5707,7 +5747,7 @@ add_option (struct options *options,
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
       set_user_script (options, &options->client_disconnect_script,
-		       p[1], "client-disconnect");
+		       p[1], "client-disconnect", true);
     }
   else if (streq (p[0], "learn-address") && p[1])
     {
@@ -5715,7 +5755,7 @@ add_option (struct options *options,
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
       set_user_script (options, &options->learn_address_script,
-		       p[1], "learn-address");
+		       p[1], "learn-address", true);
     }
   else if (streq (p[0], "tmp-dir") && p[1])
     {
@@ -6675,7 +6715,7 @@ add_option (struct options *options,
 	goto err;
       set_user_script (options, &options->tls_verify,
 		       string_substitute (p[1], ',', ' ', &options->gc),
-		       "tls-verify");
+		       "tls-verify", true);
     }
 #ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "tls-export-cert") && p[1])
-- 
1.8.3.1


