From: Heiko Hund <heiko.hund@...1489...>
Date: Fri, 28 Oct 2016 18:42:42 +0200
Message-ID: <1477672963-5724-7-git-send-email-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
References: <1477672963-5724-1-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/7] argv: do fewer memory re-allocations
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

Prevent the re-allocations of memory when the internal argv grows
beyond 2 and 4 arguments by initially allocating argv to hold up to
7 (+ trailing NULL) pointers.

While at it rename argv_reset to argv_free to actually express
what's going on. Redo the argv_reset functionality so that it can
be used to actually reset the argv without re-allocation.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/argv.c                   | 45 ++++++++++++++++++++----------------
 src/openvpn/argv.h                   |  2 +-
 src/openvpn/console_systemd.c        |  2 +-
 src/openvpn/init.c                   |  2 +-
 src/openvpn/lladdr.c                 |  2 +-
 src/openvpn/misc.c                   |  4 ++--
 src/openvpn/multi.c                  | 10 ++++----
 src/openvpn/options.c                |  2 +-
 src/openvpn/plugin.c                 |  2 +-
 src/openvpn/route.c                  |  8 +++----
 src/openvpn/socket.c                 |  4 ++--
 src/openvpn/ssl_verify.c             |  6 ++---
 src/openvpn/tun.c                    | 23 ++++++++----------
 tests/unit_tests/openvpn/test_argv.c | 41 +++++++++++++++++++++-----------
 14 files changed, 85 insertions(+), 68 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index dcfbd76..664785b 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -41,11 +41,28 @@
 #include "options.h"
 
 static void
+argv_extend (struct argv *a, const size_t newcap)
+{
+  if (newcap > a->capacity)
+    {
+      char **newargv;
+      size_t i;
+      ALLOC_ARRAY_CLEAR (newargv, char *, newcap);
+      for (i = 0; i < a->argc; ++i)
+        newargv[i] = a->argv[i];
+      free (a->argv);
+      a->argv = newargv;
+      a->capacity = newcap;
+    }
+}
+
+static void
 argv_init (struct argv *a)
 {
   a->capacity = 0;
   a->argc = 0;
   a->argv = NULL;
+  argv_extend (a, 8);
 }
 
 struct argv
@@ -57,29 +74,24 @@ argv_new (void)
 }
 
 void
-argv_reset (struct argv *a)
+argv_free (struct argv *a)
 {
   size_t i;
   for (i = 0; i < a->argc; ++i)
     free (a->argv[i]);
   free (a->argv);
-  argv_init (a);
 }
 
 static void
-argv_extend (struct argv *a, const size_t newcap)
+argv_reset (struct argv *a)
 {
-  if (newcap > a->capacity)
+  size_t i;
+  for (i = 0; i < a->argc; ++i)
     {
-      char **newargv;
-      size_t i;
-      ALLOC_ARRAY_CLEAR (newargv, char *, newcap);
-      for (i = 0; i < a->argc; ++i)
-        newargv[i] = a->argv[i];
-      free (a->argv);
-      a->argv = newargv;
-      a->capacity = newcap;
+      free (a->argv[i]);
+      a->argv[i] = NULL;
     }
+  a->argc = 0;
 }
 
 static void
@@ -126,10 +138,7 @@ argv_insert_head (const struct argv *a, const char *head)
 const char *
 argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int flags)
 {
-  if (a->argv)
-    return print_argv ((const char **)a->argv, gc, flags);
-  else
-    return "";
+  return print_argv ((const char **)a->argv, gc, flags);
 }
 
 void
@@ -191,8 +200,6 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
   va_list tmplist;
   int len;
 
-  argv_extend (a, 1); /* ensure trailing NULL */
-
   argc = a->argc;
   f = argv_prep_format (format, delim[0], &argc, &gc);
   if (f == NULL)
@@ -221,7 +228,6 @@ argv_printf_arglist (struct argv *a, const char *format, va_list arglist)
     {
       /* Someone snuck in a \035, fail gracefully */
       argv_reset (a);
-      argv_extend (a, 1); /* ensure trailing NULL */
       goto out;
     }
 
@@ -263,7 +269,6 @@ argv_parse_cmd (struct argv *a, const char *s)
   struct gc_arena gc = gc_new ();
 
   argv_reset (a);
-  argv_extend (a, 1); /* ensure trailing NULL */
 
   nparms = parse_line (s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &gc);
   if (nparms)
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index ff3933e..99fd7ad 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -40,7 +40,7 @@ struct argv {
 };
 
 struct argv argv_new (void);
-void argv_reset (struct argv *a);
+void argv_free (struct argv *a);
 const char *argv_str (const struct argv *a, struct gc_arena *gc, const unsigned int flags);
 struct argv argv_insert_head (const struct argv *a, const char *head);
 void argv_msg (const int msglev, const struct argv *a);
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index 8a953c9..c8edf67 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -84,7 +84,7 @@ get_console_input_systemd (const char *prompt, const bool echo, char *input, con
     }
     close (std_out);
 
-    argv_reset (&argv);
+    argv_free (&argv);
 
     return ret;
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 56140b3..ab49262 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1364,7 +1364,7 @@ do_route (const struct options *options,
       setenv_str (es, "script_type", "route-up");
       argv_parse_cmd (&argv, options->route_script);
       openvpn_run_script (&argv, es, 0, "--route-up");
-      argv_reset (&argv);
+      argv_free (&argv);
     }
 
 #ifdef WIN32
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index 57f447b..94d9f08 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -62,6 +62,6 @@ int set_lladdr(const char *ifname, const char *lladdr,
   if (r)
     msg (M_INFO, "TUN/TAP link layer address set to %s", lladdr);
 
-  argv_reset (&argv);
+  argv_free (&argv);
   return r;
 }
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index b433df6..309cc5f 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -112,7 +112,7 @@ run_up_down (const char *command,
       if (plugin_call (plugins, plugin_type, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	msg (M_FATAL, "ERROR: up/down plugin call failed");
 
-      argv_reset (&argv);
+      argv_free (&argv);
     }
 
   if (command)
@@ -125,7 +125,7 @@ run_up_down (const char *command,
                        ifconfig_local, ifconfig_remote, context);
       argv_msg (M_INFO, &argv);
       openvpn_run_script (&argv, es, S_FATAL, "--up/--down");
-      argv_reset (&argv);
+      argv_free (&argv);
     }
 
   gc_free (&gc);
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 9c75f7b..deb80f7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -119,7 +119,7 @@ learn_address_script (const struct multi_context *m,
 	  msg (M_WARN, "WARNING: learn-address plugin call failed");
 	  ret = false;
 	}
-      argv_reset (&argv);
+      argv_free (&argv);
     }
 
   if (m->top.options.learn_address_script)
@@ -132,7 +132,7 @@ learn_address_script (const struct multi_context *m,
 	argv_printf_cat (&argv, "%s", tls_common_name (mi->context.c2.tls_multi, false));
       if (!openvpn_run_script (&argv, es, 0, "--learn-address"))
 	ret = false;
-      argv_reset (&argv);
+      argv_free (&argv);
     }
 
   gc_free (&gc);
@@ -545,7 +545,7 @@ multi_client_disconnect_script (struct multi_context *m,
 	  setenv_str (mi->context.c2.es, "script_type", "client-disconnect");
 	  argv_parse_cmd (&argv, mi->context.options.client_disconnect_script);
 	  openvpn_run_script (&argv, mi->context.c2.es, 0, "--client-disconnect");
-	  argv_reset (&argv);
+	  argv_free (&argv);
 	}
 #ifdef MANAGEMENT_DEF_AUTH
       if (management)
@@ -1791,7 +1791,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 		 dc_file);
 
         script_depr_failed:
-	  argv_reset (&argv);
+	  argv_free (&argv);
 	}
 
       /* V2 callback, use a plugin_return struct for passing back return info */
@@ -1848,7 +1848,7 @@ multi_connection_established (struct multi_context *m, struct multi_instance *mi
 		 dc_file);
 
         script_failed:
-	  argv_reset (&argv);
+	  argv_free (&argv);
 	}
 
       /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 557299a..fda51ac 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -2794,7 +2794,7 @@ check_cmd_access(const char *command, const char *opt, const char *chroot)
       return_code = true;
     }
 
-  argv_reset (&argv);
+  argv_free (&argv);
 
   return return_code;
 }
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 542e5b1..439ec00 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -500,7 +500,7 @@ plugin_call_item (const struct plugin *p,
 	     status,
 	     p->so_pathname);
 
-      argv_reset (&a);
+      argv_free (&a);
       gc_free (&gc);
     }
   return status;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index ca1e0a7..07ab2b2 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1642,7 +1642,7 @@ add_route (struct route_ipv4 *r,
     r->flags |= RT_ADDED;
   else
     r->flags &= ~RT_ADDED;
-  argv_reset (&argv);
+  argv_free (&argv);
   gc_free (&gc);
 }
 
@@ -1919,7 +1919,7 @@ add_route_ipv6 (struct route_ipv6 *r6, const struct tuntap *tt, unsigned int fla
     r6->flags |= RT_ADDED;
   else
     r6->flags &= ~RT_ADDED;
-  argv_reset (&argv);
+  argv_free (&argv);
   gc_free (&gc);
 }
 
@@ -2097,7 +2097,7 @@ delete_route (struct route_ipv4 *r,
 
  done:
   r->flags &= ~RT_ADDED;
-  argv_reset (&argv);
+  argv_free (&argv);
   gc_free (&gc);
 }
 
@@ -2307,7 +2307,7 @@ delete_route_ipv6 (const struct route_ipv6 *r6, const struct tuntap *tt, unsigne
   msg (M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-down script");
 #endif
 
-  argv_reset (&argv);
+  argv_free (&argv);
   gc_free (&gc);
 }
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index bb7cba1..c9067a5 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2063,7 +2063,7 @@ link_socket_connection_initiated (const struct buffer *buf,
       ipchange_fmt (false, &argv, info, &gc);
       if (plugin_call (info->plugins, OPENVPN_PLUGIN_IPCHANGE, &argv, NULL, es) != OPENVPN_PLUGIN_FUNC_SUCCESS)
 	msg (M_WARN, "WARNING: ipchange plugin call failed");
-      argv_reset (&argv);
+      argv_free (&argv);
     }
 
   /* Process --ipchange option */
@@ -2073,7 +2073,7 @@ link_socket_connection_initiated (const struct buffer *buf,
       setenv_str (es, "script_type", "ipchange");
       ipchange_fmt (true, &argv, info, &gc);
       openvpn_run_script (&argv, es, 0, "--ipchange");
-      argv_reset (&argv);
+      argv_free (&argv);
     }
 
   gc_free (&gc);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index be9f224..7dbf2e6 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -447,7 +447,7 @@ verify_cert_call_plugin(const struct plugin_list *plugins, struct env_set *es,
 
       ret = plugin_call_ssl (plugins, OPENVPN_PLUGIN_TLS_VERIFY, &argv, NULL, es, cert_depth, cert);
 
-      argv_reset (&argv);
+      argv_free (&argv);
 
       if (ret == OPENVPN_PLUGIN_FUNC_SUCCESS)
 	{
@@ -527,7 +527,7 @@ verify_cert_call_command(const char *verify_command, struct env_set *es,
     }
 
   gc_free(&gc);
-  argv_reset (&argv);
+  argv_free (&argv);
 
   if (ret)
     {
@@ -1001,7 +1001,7 @@ verify_user_pass_script (struct tls_session *session, const struct user_pass *up
   if (tmp_file && strlen (tmp_file) > 0)
     platform_unlink (tmp_file);
 
-  argv_reset (&argv);
+  argv_free (&argv);
   gc_free (&gc);
   return ret;
 }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 843df16..ab0c168 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1376,7 +1376,7 @@ do_ifconfig (struct tuntap *tt,
 #else
       msg (M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif
-      argv_reset (&argv);
+      argv_free (&argv);
     }
   gc_free (&gc);
 }
@@ -1903,7 +1903,7 @@ close_tun (struct tuntap *tt)
 #endif
               }
 
-	    argv_reset (&argv);
+	    argv_free (&argv);
 	    gc_free (&gc);
 	  }
       close_tun_generic (tt);
@@ -2131,7 +2131,7 @@ solaris_close_tun (struct tuntap *tt)
 		       IFCONFIG_PATH, tt->actual_name );
 	  argv_msg (M_INFO, &argv);
 	  openvpn_execve_check (&argv, NULL, 0, "Solaris ifconfig inet6 unplumb failed");
-	  argv_reset (&argv);
+	  argv_free (&argv);
 	}
 
       if (tt->ip_fd >= 0)
@@ -2208,7 +2208,7 @@ solaris_error_close (struct tuntap *tt, const struct env_set *es,
   openvpn_execve_check (&argv, es, 0, "Solaris ifconfig unplumb failed");
   close_tun (tt);
   msg (M_FATAL, "Solaris ifconfig failed");
-  argv_reset (&argv);
+  argv_free (&argv);
 }
 
 int
@@ -2835,7 +2835,7 @@ close_tun (struct tuntap* tt)
 
       close_tun_generic (tt);
       free (tt);
-      argv_reset (&argv);
+      argv_free (&argv);
       gc_free (&gc);
     }
 }
@@ -4495,31 +4495,28 @@ ipconfig_register_dns (const struct env_set *es)
 	       WIN_NET_PATH_SUFFIX);
   argv_msg (D_TUNTAP_INFO, &argv);
   status = openvpn_execve_check (&argv, es, 0, err);
-  argv_reset(&argv);
 
   argv_printf (&argv, "%s%s start dnscache",
 	       get_win_sys_path(),
 	       WIN_NET_PATH_SUFFIX);
   argv_msg (D_TUNTAP_INFO, &argv);
   status = openvpn_execve_check (&argv, es, 0, err);
-  argv_reset(&argv);
 
   argv_printf (&argv, "%s%s /flushdns",
 	       get_win_sys_path(),
 	       WIN_IPCONFIG_PATH_SUFFIX);
   argv_msg (D_TUNTAP_INFO, &argv);
   status = openvpn_execve_check (&argv, es, 0, err);
-  argv_reset(&argv);
 
   argv_printf (&argv, "%s%s /registerdns",
 	       get_win_sys_path(),
 	       WIN_IPCONFIG_PATH_SUFFIX);
   argv_msg (D_TUNTAP_INFO, &argv);
   status = openvpn_execve_check (&argv, es, 0, err);
-  argv_reset(&argv);
 
   netcmd_semaphore_release ();
   msg (D_TUNTAP_INFO, "End net commands...");
+  argv_free (&argv);
 }
 
 void
@@ -4660,7 +4657,7 @@ netsh_ifconfig_options (const char *type,
       }
   }
 
-  argv_reset (&argv);
+  argv_free (&argv);
   gc_free (&gc);
 }
 
@@ -4749,7 +4746,7 @@ netsh_ifconfig (const struct tuntap_options *to,
 			      BOOL_CAST (flags & NI_TEST_FIRST));
     }
   
-  argv_reset (&argv);
+  argv_free (&argv);
   gc_free (&gc);
 }
 
@@ -4768,7 +4765,7 @@ netsh_enable_dhcp (const struct tuntap_options *to,
 
   netsh_command (&argv, 4, M_FATAL);
 
-  argv_reset (&argv);
+  argv_free (&argv);
 }
 
 /*
@@ -5542,7 +5539,7 @@ close_tun (struct tuntap *tt)
                            ifconfig_ipv6_local);
 
               netsh_command (&argv, 1, M_WARN);
-              argv_reset (&argv);
+              argv_free (&argv);
             }
 	}
 #if 1
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 0371c78..d2cd96d 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -67,7 +67,7 @@ argv_printf__multiple_spaces_in_format__parsed_as_one (void **state)
   argv_printf (&a, "    %s     %s  %d   ", PATH1, PATH2, 42);
   assert_int_equal (a.argc, 3);
 
-  argv_reset (&a);
+  argv_free (&a);
 }
 
 static void
@@ -79,7 +79,7 @@ argv_printf_cat__multiple_spaces_in_format__parsed_as_one (void **state)
   argv_printf_cat (&a, " %s  %s", PATH2, PARAM1);
   assert_int_equal (a.argc, 3);
 
-  argv_reset (&a);
+  argv_free (&a);
 }
 
 static void
@@ -91,7 +91,7 @@ argv_printf__embedded_format_directive__replaced_in_output (void **state)
   assert_int_equal (a.argc, 1);
   assert_string_equal (a.argv[0], "<p1:" PATH1 ">");
 
-  argv_reset (&a);
+  argv_free (&a);
 }
 
 static void
@@ -102,7 +102,7 @@ argv_printf__group_sep_in_arg__fail_no_ouput (void **state)
   assert_false (argv_printf (&a, "tool --do %s", "this\035--harmful"));
   assert_int_equal (a.argc, 0);
 
-  argv_reset (&a);
+  argv_free (&a);
 }
 
 static void
@@ -119,7 +119,7 @@ argv_printf__combined_path_with_spaces__argc_correct (void **state)
   argv_printf (&a, "foo %s%s %s x y", PATH2, PATH1, "foo");
   assert_int_equal (a.argc, 5);
 
-  argv_reset (&a);
+  argv_free (&a);
 }
 
 static void
@@ -130,7 +130,7 @@ argv_parse_cmd__command_string__argc_correct (void **state)
   argv_parse_cmd (&a, SCRIPT_CMD);
   assert_int_equal (a.argc, 3);
 
-  argv_reset (&a);
+  argv_free (&a);
 }
 
 static void
@@ -142,7 +142,7 @@ argv_parse_cmd__command_and_extra_options__argc_correct (void **state)
   argv_printf_cat (&a, "bar baz %d %s", 42, PATH1);
   assert_int_equal (a.argc, 7);
 
-  argv_reset (&a);
+  argv_free (&a);
 }
 
 static void
@@ -155,7 +155,21 @@ argv_printf_cat__used_twice__argc_correct (void **state)
   argv_printf_cat (&a, "foo");
   assert_int_equal (a.argc, 5);
 
-  argv_reset (&a);
+  argv_free (&a);
+}
+
+static void
+argv_str__empty_argv__empty_output (void **state)
+{
+  struct argv a = argv_new ();
+  struct gc_arena gc = gc_new ();
+  const char *output;
+
+  output = argv_str (&a, &gc, PA_BRACKET);
+  assert_string_equal (output, "");
+
+  argv_free (&a);
+  gc_free (&gc);
 }
 
 static void
@@ -171,7 +185,7 @@ argv_str__multiple_argv__correct_output (void **state)
   output = argv_str (&a, &gc, PA_BRACKET);
   assert_string_equal (output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2 "]");
 
-  argv_reset (&a);
+  argv_free (&a);
   gc_free (&gc);
 }
 
@@ -184,9 +198,9 @@ argv_insert_head__empty_argv__head_only (void **state)
   b = argv_insert_head (&a, PATH1);
   assert_int_equal (b.argc, 1);
   assert_string_equal (b.argv[0], PATH1);
-  argv_reset (&b);
+  argv_free (&b);
 
-  argv_reset (&a);
+  argv_free (&a);
 }
 
 static void
@@ -205,9 +219,9 @@ argv_insert_head__non_empty_argv__head_added (void **state)
     else
       assert_string_equal (b.argv[i], a.argv[i - 1]);
   }
-  argv_reset (&b);
+  argv_free (&b);
 
-  argv_reset (&a);
+  argv_free (&a);
 }
 
 int
@@ -222,6 +236,7 @@ main(void)
     cmocka_unit_test (argv_parse_cmd__command_string__argc_correct),
     cmocka_unit_test (argv_parse_cmd__command_and_extra_options__argc_correct),
     cmocka_unit_test (argv_printf_cat__used_twice__argc_correct),
+    cmocka_unit_test (argv_str__empty_argv__empty_output),
     cmocka_unit_test (argv_str__multiple_argv__correct_output),
     cmocka_unit_test (argv_insert_head__non_empty_argv__head_added),
   };
-- 
2.7.4


