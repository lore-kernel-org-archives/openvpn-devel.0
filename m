From: Arne Schwabe <arne@...1227...>
Date: Thu, 30 May 2013 23:02:17 +0200
Message-Id: <1369947737-26081-1-git-send-email-arne@...1227...>
In-Reply-To: <20130530195530.GT20843@...1296...>
References: <20130530195530.GT20843@...1296...>
Subject: [Openvpn-devel] [PATCH] Move checking of script file access into
	set_user_script
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

At the moment script are only checked if P2MP_SERVER is defined. For CLIENT_ONLY openvpn script were never checked.
---
 src/openvpn/options.c |   33 +++++++++++----------------------
 1 file changed, 11 insertions(+), 22 deletions(-)

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bbc1018..5e8bcc4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2745,28 +2745,6 @@ options_postprocess_filechecks (struct options *options)
   errs |= check_file_access (CHKACC_FILE, options->tmp_dir,
                              R_OK|W_OK|X_OK, "Temporary directory (--tmp-dir)");
 
-  /* ** Script hooks that accept an optionally quoted and/or escaped executable path, ** */
-  /* ** optionally followed by arguments ** */
-  errs |= check_cmd_access (options->auth_user_pass_verify_script,
-                            "--auth-user-pass-verify script");
-  errs |= check_cmd_access (options->client_connect_script,
-                            "--client-connect script");
-  errs |= check_cmd_access (options->client_disconnect_script,
-                            "--client-disconnect script");
-  errs |= check_cmd_access (options->tls_verify,
-                            "--tls-verify script");
-  errs |= check_cmd_access (options->up_script,
-                            "--up script");
-  errs |= check_cmd_access (options->down_script,
-                            "--down script");
-  errs |= check_cmd_access (options->ipchange,
-                            "--ipchange script");
-  errs |= check_cmd_access (options->route_script,
-                            "--route-up script");
-  errs |= check_cmd_access (options->route_predown_script,
-                            "--route-pre-down script");
-  errs |= check_cmd_access (options->learn_address_script,
-                            "--learn-address script");
 #endif /* P2MP_SERVER */
 
   if (errs)
@@ -4037,6 +4015,17 @@ set_user_script (struct options *options,
   }
   *script = new_script;
   options->user_script_used = true;
+
+#ifndef ENABLE_SMALL
+  {
+    char script_name[100];
+    openvpn_snprintf (script_name, sizeof(script_name), 
+                      "--%s script", type);
+
+    if (check_cmd_access (*script, script_name))
+      msg (M_USAGE, "Please correct this error.");
+  }
+#endif
 }
 
 
-- 
1.7.9.5


