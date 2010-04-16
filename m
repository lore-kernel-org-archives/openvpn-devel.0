From: David Sommerseth <openvpn.list@...1114...>
Date: Fri, 16 Apr 2010 22:21:52 +0200
Message-Id: <1271449313-26315-3-git-send-email-openvpn.list@...1114...>
In-Reply-To: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
References: <1271449313-26315-1-git-send-email-openvpn.list@...1114...>
Subject: [Openvpn-devel] [PATCHv2 2/3] Renamed all calls to
	create_temp_filename()
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
To: Openvpn-devel@lists.sourceforge.net
Cc: James Yonan <james@...515...>, David Sommerseth <dazo@...384...>

From: David Sommerseth <dazo@...384...>

All places where create_temp_filename() was called are now calling
create_temp_file().  Extra checks on the result of create_temp_file()
is added in addition.

Signed-off-by: David Sommerseth <dazo@...384...>
---
 init.c  |    2 +-
 multi.c |   19 ++++++++++++++-----
 pf.c    |   33 +++++++++++++++++----------------
 ssl.c   |   36 +++++++++++++++++++++---------------
 4 files changed, 53 insertions(+), 37 deletions(-)

diff --git a/init.c b/init.c
index 3748c2e..e2f7729 100644
--- a/init.c
+++ b/init.c
@@ -457,7 +457,7 @@ init_static (void)
 #ifdef STATUS_PRINTF_TEST
   {
     struct gc_arena gc = gc_new ();
-    const char *tmp_file = create_temp_filename ("/tmp", "foo", &gc);
+    const char *tmp_file = create_temp_file ("/tmp", "foo", &gc);
     struct status_output *so = status_open (tmp_file, 0, -1, NULL, STATUS_OUTPUT_WRITE);
     status_printf (so, "%s", "foo");
     status_printf (so, "%s", "bar");
diff --git a/multi.c b/multi.c
index 2b04428..826a113 100644
--- a/multi.c
+++ b/multi.c
@@ -1530,7 +1530,13 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
       if (plugin_defined (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT))
 	{
 	  struct argv argv = argv_new ();
-	  const char *dc_file = create_temp_filename (mi->context.options.tmp_dir, "cc", &gc);
+	  const char *dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
+
+          if( !dc_file ) {
+            cc_succeeded = false;
+            goto script_depr_failed;
+          }
+
 	  argv_printf (&argv, "%s", dc_file);
 	  delete_file (dc_file);
 	  if (plugin_call (mi->context.plugins, OPENVPN_PLUGIN_CLIENT_CONNECT, &argv, NULL, mi->context.c2.es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
@@ -1543,6 +1549,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	      multi_client_connect_post (m, mi, dc_file, option_permissions_mask, &option_types_found);
 	      ++cc_succeeded_count;
 	    }
+        script_depr_failed:
 	  argv_reset (&argv);
 	}
 
@@ -1578,9 +1585,11 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 
 	  setenv_str (mi->context.c2.es, "script_type", "client-connect");
 
-	  dc_file = create_temp_filename (mi->context.options.tmp_dir, "cc", &gc);
-
-	  delete_file (dc_file);
+	  dc_file = create_temp_file (mi->context.options.tmp_dir, "cc", &gc);
+          if( !dc_file ) {
+            cc_succeeded = false;
+            goto script_failed;
+          }
 
 	  argv_printf (&argv, "%sc %s",
 		       mi->context.options.client_connect_script,
@@ -1593,7 +1602,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 	    }
 	  else
 	    cc_succeeded = false;
-
+        script_failed:
 	  argv_reset (&argv);
 	}
 
diff --git a/pf.c b/pf.c
index 027eb69..5075164 100644
--- a/pf.c
+++ b/pf.c
@@ -554,24 +554,25 @@ pf_init_context (struct context *c)
 #ifdef PLUGIN_PF
   if (plugin_defined (c->plugins, OPENVPN_PLUGIN_ENABLE_PF))
     {
-      const char *pf_file = create_temp_filename (c->options.tmp_dir, "pf", &gc);
-      delete_file (pf_file);
-      setenv_str (c->c2.es, "pf_file", pf_file);
-
-      if (plugin_call (c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es) == OPENVPN_PLUGIN_FUNC_SUCCESS)
-	{
-	  event_timeout_init (&c->c2.pf.reload, 1, now);
-	  c->c2.pf.filename = string_alloc (pf_file, NULL);
-	  c->c2.pf.enabled = true;
+      const char *pf_file = create_temp_file (c->options.tmp_dir, "pf", &gc);
+      if( pf_file ) {
+        setenv_str (c->c2.es, "pf_file", pf_file);
+
+        if (plugin_call (c->plugins, OPENVPN_PLUGIN_ENABLE_PF, NULL, NULL, c->c2.es) == OPENVPN_PLUGIN_FUNC_SUCCESS)
+          {
+            event_timeout_init (&c->c2.pf.reload, 1, now);
+            c->c2.pf.filename = string_alloc (pf_file, NULL);
+            c->c2.pf.enabled = true;
 #ifdef ENABLE_DEBUG
-	  if (check_debug_level (D_PF_DEBUG))
-	    pf_context_print (&c->c2.pf, "pf_init_context#1", D_PF_DEBUG);
+            if (check_debug_level (D_PF_DEBUG))
+              pf_context_print (&c->c2.pf, "pf_init_context#1", D_PF_DEBUG);
 #endif
-	}
-      else
-	{
-	  msg (M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled");
-	}
+          }
+        else
+          {
+            msg (M_WARN, "WARNING: OPENVPN_PLUGIN_ENABLE_PF disabled");
+          }
+      }
     }
 #endif
 #ifdef MANAGEMENT_PF
diff --git a/ssl.c b/ssl.c
index ddd5ee7..552bcbe 100644
--- a/ssl.c
+++ b/ssl.c
@@ -1094,10 +1094,11 @@ key_state_gen_auth_control_file (struct key_state *ks, const struct tls_options
   const char *acf;
 
   key_state_rm_auth_control_file (ks);
-  acf = create_temp_filename (opt->tmp_dir, "acf", &gc);
-  ks->auth_control_file = string_alloc (acf, NULL);
-  setenv_str (opt->es, "auth_control_file", ks->auth_control_file);
-
+  acf = create_temp_file (opt->tmp_dir, "acf", &gc);
+  if( acf ) {
+    ks->auth_control_file = string_alloc (acf, NULL);
+    setenv_str (opt->es, "auth_control_file", ks->auth_control_file);
+  } /* FIXME: Should have better error handling? */
   gc_free (&gc);					  
 }
 
@@ -3144,17 +3145,22 @@ verify_user_pass_script (struct tls_session *session, const struct user_pass *up
 	{
 	  struct status_output *so;
 
-	  tmp_file = create_temp_filename (session->opt->tmp_dir, "up", &gc);
-	  so = status_open (tmp_file, 0, -1, NULL, STATUS_OUTPUT_WRITE);
-	  status_printf (so, "%s", up->username);
-	  status_printf (so, "%s", up->password);
-	  if (!status_close (so))
-	    {
-	      msg (D_TLS_ERRORS, "TLS Auth Error: could not write username/password to file: %s",
-		   tmp_file);
-	      goto done;
-	    }
-	}
+	  tmp_file = create_temp_file (session->opt->tmp_dir, "up", &gc);
+          if( tmp_file ) {
+            so = status_open (tmp_file, 0, -1, NULL, STATUS_OUTPUT_WRITE);
+            status_printf (so, "%s", up->username);
+            status_printf (so, "%s", up->password);
+            if (!status_close (so))
+              {
+                msg (D_TLS_ERRORS, "TLS Auth Error: could not write username/password to file: %s",
+                     tmp_file);
+                goto done;
+              }
+          } else {
+            msg (D_TLS_ERRORS, "TLS Auth Error: could not create write "
+                 "username/password to temp file");
+          }
+        }
       else
 	{
 	  setenv_str (session->opt->es, "username", up->username);
-- 
1.6.6.1


