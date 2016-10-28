From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 28 Oct 2016 18:42:40 +0200
Message-ID: <1477672963-5724-5-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/7] Factor out %sc handling from
	argv_printf()
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

Move functionality to parse command strings into argv_parse_cmd().
That is a preparation for the upcoming refactoring of argv_printf().

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/argv.c                   | 47 +++++++++++++++++-------------------
 src/openvpn/argv.h                   |  1 +
 src/openvpn/errlevel.h               |  2 +-
 src/openvpn/init.c                   |  2 +-
 src/openvpn/misc.c                   | 10 +++-----
 src/openvpn/multi.c                  | 13 ++++------
 src/openvpn/options.c                |  2 +-
 src/openvpn/socket.c                 |  7 +++---
 src/openvpn/ssl_verify.c             |  6 +++--
 tests/unit_tests/openvpn/test_argv.c | 18 +++++++++++---
 10 files changed, 56 insertions(+), 52 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index a279a40..f8287b7 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -198,7 +198,6 @@ argv_msg_prefix (const int msglev, const struct argv *a, const char *prefix)
 static void
 argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
 {
-  struct gc_arena gc = gc_new ();
   char *term;
   const char *f = format;
 
@@ -215,29 +214,6 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
                 s = "";
               argv_append (a, string_alloc (s, NULL));
             }
-          else if (!strcmp (term, "%sc"))
-            {
-              char *s = va_arg (arglist, char *);
-              if (s)
-                {
-                  int nparms;
-                  char *parms[MAX_PARMS+1];
-                  int i;
-
-                  nparms = parse_line (s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &gc);
-                  if (nparms)
-                    {
-                      for (i = 0; i < nparms; ++i)
-                        argv_append (a, string_alloc (parms[i], NULL));
-                    }
-                  else
-                    argv_append (a, string_alloc (s, NULL));
-                }
-              else
-                {
-                  argv_append (a, string_alloc ("", NULL));
-                }
-            }
           else if (!strcmp (term, "%d"))
             {
               char numstr[64];
@@ -295,7 +271,6 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
           argv_append (a, term);
         }
     }
-  gc_free (&gc);
 }
 
 void
@@ -317,3 +292,25 @@ argv_printf_cat (struct argv *a, const char *format, ...)
   va_end (arglist);
 }
 
+void
+argv_parse_cmd (struct argv *a, const char *s)
+{
+  int nparms;
+  char *parms[MAX_PARMS + 1];
+  struct gc_arena gc = gc_new ();
+
+  argv_reset (a);
+  argv_extend (a, 1); /* ensure trailing NULL */
+
+  nparms = parse_line (s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &gc);
+  if (nparms)
+    {
+      int i;
+      for (i = 0; i < nparms; ++i)
+        argv_append (a, string_alloc (parms[i], NULL));
+    }
+  else
+    argv_append (a, string_alloc (s, NULL));
+
+  gc_free (&gc);
+}
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index c45bec8..9aee641 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -45,6 +45,7 @@ const char *argv_str (const struct argv *a, struct gc_arena *gc, const unsigned
 struct argv argv_insert_head (const struct argv *a, const char *head);
 void argv_msg (const int msglev, const struct argv *a);
 void argv_msg_prefix (const int msglev, const struct argv *a, const char *prefix);
+void argv_parse_cmd (struct argv *a, const char *s);
 
 void argv_printf (struct argv *a, const char *format, ...)
 #ifdef __GNUC__
diff --git a/src/openvpn/errlevel.h b/src/openvpn/errlevel.h
index ae1f8f4..9d56eb4 100644
--- a/src/openvpn/errlevel.h
+++ b/src/openvpn/errlevel.h
@@ -142,7 +142,7 @@
 #define D_PS_PROXY_DEBUG     LOGLEV(7, 70, M_DEBUG)  /* port share proxy debug */
 #define D_AUTO_USERID        LOGLEV(7, 70, M_DEBUG)  /* AUTO_USERID debugging */
 #define D_TLS_KEYSELECT      LOGLEV(7, 70, M_DEBUG)  /* show information on key selection for data channel */
-#define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M_DEBUG)  /* show parse_line() errors in argv_printf %sc */
+#define D_ARGV_PARSE_CMD     LOGLEV(7, 70, M_DEBUG)  /* show parse_line() errors in argv_parse_cmd */
 #define D_CRYPTO_DEBUG       LOGLEV(7, 70, M_DEBUG)  /* show detailed info from crypto.c routines */
 #define D_PID_DEBUG          LOGLEV(7, 70, M_DEBUG)  /* show packet-id debugging info */
 #define D_PF_DROPPED_BCAST   LOGLEV(7, 71, M_DEBUG)  /* packet filter dropped a broadcast packet */
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 73f8c6d..56140b3 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1362,7 +1362,7 @@ do_route (const struct options *options,
     {
       struct argv argv = argv_new ();
       setenv_str (es, "script_type", "route-up");
-      argv_printf (&argv, "%sc", options->route_script);
+      argv_parse_cmd (&argv, options->route_script);
       openvpn_run_script (&argv, es, 0, "--route-up");
       argv_reset (&argv);
     }
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index af362e9..b433df6 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -120,13 +120,9 @@ run_up_down (const char *command,
       struct argv argv = argv_new ();
       ASSERT (arg);
       setenv_str (es, "script_type", script_type);
-      argv_printf (&argv,
-		  "%sc %s %d %d %s %s %s",
-		  command,
-		  arg,
-		  tun_mtu, link_mtu,
-		  ifconfig_local, ifconfig_remote,
-		  context);
+      argv_parse_cmd (&argv, command);
+      argv_printf_cat (&argv, "%s %d %d %s %s %s", arg, tun_mtu, link_mtu,
+                       ifconfig_local, ifconfig_remote, context);
       argv_msg (M_INFO, &argv);
       openvpn_run_script (&argv, es, S_FATAL, "--up/--down");
       argv_reset (&argv);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 93a554d..9c75f7b 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -126,10 +126,8 @@ learn_address_script (const struct multi_context *m,
     {
       struct argv argv = argv_new ();
       setenv_str (es, "script_type", "learn-address");
-      argv_printf (&argv, "%sc %s %s",
-		   m->top.options.learn_address_script,
-		   op,
-		   mroute_addr_print (addr, &gc));
+      argv_parse_cmd (&argv, m->top.options.learn_address_script);
+      argv_printf_cat (&argv, "%s %s", op, mroute_addr_print (addr, &gc));
       if (mi)
 	argv_printf_cat (&argv, "%s", tls_common_name (mi->context.c2.tls_multi, false));
       if (!openvpn_run_script (&argv, es, 0, "--learn-address"))
@@ -545,7 +543,7 @@ multi_client_disconnect_script (struct multi_context *m,
 	{
 	  struct argv argv = argv_new ();
 	  setenv_str (mi->context.c2.es, "script_type", "client-disconnect");
-	  argv_printf (&argv, "%sc", mi->context.options.client_disconnect_script);
+	  argv_parse_cmd (&argv, mi->context.options.client_disconnect_script);
 	  openvpn_run_script (&argv, mi->context.c2.es, 0, "--client-disconnect");
 	  argv_reset (&argv);
 	}
@@ -1834,9 +1832,8 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
             goto script_failed;
           }
 
-	  argv_printf (&argv, "%sc %s",
-		       mi->context.options.client_connect_script,
-		       dc_file);
+          argv_parse_cmd (&argv, mi->context.options.client_connect_script);
+          argv_printf_cat (&argv, "%s", dc_file);
 
 	  if (openvpn_run_script (&argv, mi->context.c2.es, 0, "--client-connect"))
 	    {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 996c26e..557299a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2778,7 +2778,7 @@ check_cmd_access(const char *command, const char *opt, const char *chroot)
 
   /* Extract executable path and arguments */
   argv = argv_new ();
-  argv_printf (&argv, "%sc", command);
+  argv_parse_cmd (&argv, command);
 
   /* if an executable is specified then check it; otherwise, complain */
   if (argv.argv[0])
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 184c7ad..bb7cba1 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2022,9 +2022,10 @@ ipchange_fmt (const bool include_cmd, struct argv *argv, const struct link_socke
 {
   const char *host = print_sockaddr_ex (&info->lsa->actual.dest.addr.sa, " ", PS_SHOW_PORT , gc);
   if (include_cmd)
-    argv_printf (argv, "%sc %s",
-		 info->ipchange_command,
-		 host);
+    {
+      argv_parse_cmd (argv, info->ipchange_command);
+      argv_printf_cat (argv, "%s", host);
+    }
   else
     argv_printf (argv, "%s", host);
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index d0c22b8..be9f224 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -514,7 +514,8 @@ verify_cert_call_command(const char *verify_command, struct env_set *es,
        }
     }
 
-  argv_printf (&argv, "%sc %d %s", verify_command, cert_depth, subject);
+  argv_parse_cmd (&argv, verify_command);
+  argv_printf_cat (&argv, "%d %s", cert_depth, subject);
 
   argv_msg_prefix (D_TLS_DEBUG, &argv, "TLS: executing verify command");
   ret = openvpn_run_script (&argv, es, 0, "--tls-verify script");
@@ -981,7 +982,8 @@ verify_user_pass_script (struct tls_session *session, const struct user_pass *up
       setenv_untrusted (session);
 
       /* format command line */
-      argv_printf (&argv, "%sc %s", session->opt->auth_user_pass_verify_script, tmp_file);
+      argv_parse_cmd (&argv, session->opt->auth_user_pass_verify_script);
+      argv_printf_cat (&argv, "%s", tmp_file);
 
       /* call command */
       ret = openvpn_run_script (&argv, session->opt->es, 0,
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index f07a5fb..3945634 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -99,14 +99,23 @@ argv_printf__combined_path_with_spaces__argc_correct (void **state)
 }
 
 static void
-argv_printf__script_command__argc_correct (void **state)
+argv_parse_cmd__command_string__argc_correct (void **state)
 {
   struct argv a = argv_new ();
 
-  argv_printf (&a, "%sc", SCRIPT_CMD);
+  argv_parse_cmd (&a, SCRIPT_CMD);
   assert_int_equal (a.argc, 3);
 
-  argv_printf (&a, "bar baz %sc %d %s", SCRIPT_CMD, 42, PATH1);
+  argv_reset (&a);
+}
+
+static void
+argv_parse_cmd__command_and_extra_options__argc_correct (void **state)
+{
+  struct argv a = argv_new ();
+
+  argv_parse_cmd (&a, SCRIPT_CMD);
+  argv_printf_cat (&a, "bar baz %d %s", 42, PATH1);
   assert_int_equal (a.argc, 7);
 
   argv_reset (&a);
@@ -184,7 +193,8 @@ main(void)
     cmocka_unit_test (argv_printf__multiple_spaces_in_format__parsed_as_one),
     cmocka_unit_test (argv_printf_cat__multiple_spaces_in_format__parsed_as_one),
     cmocka_unit_test (argv_printf__combined_path_with_spaces__argc_correct),
-    cmocka_unit_test (argv_printf__script_command__argc_correct),
+    cmocka_unit_test (argv_parse_cmd__command_string__argc_correct),
+    cmocka_unit_test (argv_parse_cmd__command_and_extra_options__argc_correct),
     cmocka_unit_test (argv_printf_cat__used_twice__argc_correct),
     cmocka_unit_test (argv_str__multiple_argv__correct_output),
     cmocka_unit_test (argv_insert_head__non_empty_argv__head_added),
-- 
2.7.4


