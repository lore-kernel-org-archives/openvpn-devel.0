From: Arne Schwabe <arne@...1227...>
Date: Thu, 30 May 2013 22:26:43 +0200
Message-Id: <1369945603-17169-1-git-send-email-arne@...1227...>
In-Reply-To: <20130530195530.GT20843@...1296...>
References: <20130530195530.GT20843@...1296...>
Subject: [Openvpn-devel] [PATCH] Move settings of user script into
	set_user_script function
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

This also fixes commit 567bfc06d051b60e9cdca1f5bb468631b899682a if not all script options are available by setting options->user_script_used
---
 src/openvpn/init.c    |    7 ++----
 src/openvpn/options.c |   59 ++++++++++++++++++++++++++++---------------------
 src/openvpn/options.h |    1 +
 3 files changed, 37 insertions(+), 30 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 7488923..cf0498d 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -2542,11 +2542,8 @@ do_option_warnings (struct context *c)
     msg (M_WARN, "NOTE: --connect-timeout option is not supported on this OS");
 #endif
 
- /* Check if a script is used and print approiate warnings */
- if (o->up_script || o->ipchange || o->down_script || o->route_script
-     || o->route_predown_script || o->auth_user_pass_verify_script
-     || o->client_disconnect_script || o->client_connect_script
-     || o->learn_address_script || o->tls_verify)
+  /* If a script is used, print appropiate warnings */
+  if (o->user_script_used)
    {
      if (script_security >= SSEC_SCRIPTS)
        msg (M_WARN, "NOTE: the current --script-security setting may allow this configuration to call user-defined scripts");
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 47df4cb..bbc1018 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4026,11 +4026,17 @@ msglevel_forward_compatible (struct options *options, const int msglevel)
 }
 
 static void
-warn_multiple_script (const char *script, const char *type) {
-      if (script) {
-	msg (M_WARN, "Multiple --%s scripts defined.  "
-	     "The previously configured script is overridden.", type);
-      }
+set_user_script (struct options *options,
+		 const char **script,
+		 const char *new_script,
+		 const char *type)
+{
+  if (*script) {
+    msg (M_WARN, "Multiple --%s scripts defined.  "
+	 "The previously configured script is overridden.", type);
+  }
+  *script = new_script;
+  options->user_script_used = true;
 }
 
 
@@ -4495,8 +4501,10 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      warn_multiple_script (options->ipchange, "ipchange");
-      options->ipchange = string_substitute (p[1], ',', ' ', &options->gc);
+      set_user_script (options, 
+		       &options->ipchange, 
+		       string_substitute (p[1], ',', ' ', &options->gc),
+		       "ipchange");
     }
   else if (streq (p[0], "float"))
     {
@@ -4542,16 +4550,14 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      warn_multiple_script (options->up_script, "up");
-      options->up_script = p[1];
+      set_user_script (options, &options->up_script, p[1], "up");
     }
   else if (streq (p[0], "down") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      warn_multiple_script (options->down_script, "down");
-      options->down_script = p[1];
+      set_user_script (options, &options->down_script, p[1], "down");
     }
   else if (streq (p[0], "down-pre"))
     {
@@ -5232,16 +5238,17 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      warn_multiple_script (options->route_script, "route-up");
-      options->route_script = p[1];
+      set_user_script (options, &options->route_script, p[1], "route-up");
     }
   else if (streq (p[0], "route-pre-down") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      warn_multiple_script (options->route_predown_script, "route-pre-down");
-      options->route_predown_script = p[1];
+      set_user_script (options,
+		       &options->route_predown_script,
+		       p[1],
+		       "route-pre-down");
     }
   else if (streq (p[0], "route-noexec"))
     {
@@ -5608,32 +5615,33 @@ add_option (struct options *options,
 	  msg (msglevel, "--auth-user-pass-verify requires a second parameter ('via-env' or 'via-file')");
 	  goto err;
 	}
-      warn_multiple_script (options->auth_user_pass_verify_script, "auth-user-pass-verify");
-      options->auth_user_pass_verify_script = p[1];
+      set_user_script (options,
+		       &options->auth_user_pass_verify_script,
+		       p[1], "auth-user-pass-verify");
     }
   else if (streq (p[0], "client-connect") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      warn_multiple_script (options->client_connect_script, "client-connect");
-      options->client_connect_script = p[1];
+      set_user_script (options, &options->client_connect_script,
+		       p[1], "client-connect");
     }
   else if (streq (p[0], "client-disconnect") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      warn_multiple_script (options->client_disconnect_script, "client-disconnect");
-      options->client_disconnect_script = p[1];
+      set_user_script (options, &options->client_disconnect_script,
+		       p[1], "client-disconnect");
     }
   else if (streq (p[0], "learn-address") && p[1])
     {
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      warn_multiple_script (options->learn_address_script, "learn-address");
-      options->learn_address_script = p[1];
+      set_user_script (options, &options->learn_address_script,
+		       p[1], "learn-address");
     }
   else if (streq (p[0], "tmp-dir") && p[1])
     {
@@ -6578,8 +6586,9 @@ add_option (struct options *options,
       VERIFY_PERMISSION (OPT_P_SCRIPT);
       if (!no_more_than_n_args (msglevel, p, 2, NM_QUOTE_HINT))
 	goto err;
-      warn_multiple_script (options->tls_verify, "tls-verify");
-      options->tls_verify = string_substitute (p[1], ',', ' ', &options->gc);
+      set_user_script (options, &options->tls_verify,
+		       string_substitute (p[1], ',', ' ', &options->gc),
+		       "tls-verify");
     }
 #ifndef ENABLE_CRYPTO_POLARSSL
   else if (streq (p[0], "tls-export-cert") && p[1])
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index bdf828f..6a132a6 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -285,6 +285,7 @@ struct options
   const char *writepid;
   const char *up_script;
   const char *down_script;
+  bool user_script_used;
   bool down_pre;
   bool up_delay;
   bool up_restart;
-- 
1.7.9.5


