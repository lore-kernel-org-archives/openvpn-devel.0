From: Heiko Hund <heiko.hund@...1489...>
Date: Sun, 12 Nov 2017 09:27:36 +0100
Message-ID: <20171112082736.15578-1-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-7-git-send-email-heiko.hund@...1489...>
References: <1477672963-5724-7-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2 6/7] argv: do fewer memory re-allocations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
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
 src/openvpn/argv.c                   | 53 ++++++++++++++++++------------------
 src/openvpn/argv.h                   |  2 +-
 src/openvpn/console_systemd.c        |  2 +-
 src/openvpn/init.c                   | 15 ++--------
 src/openvpn/lladdr.c                 |  2 +-
 src/openvpn/multi.c                  | 10 +++----
 src/openvpn/options.c                |  2 +-
 src/openvpn/plugin.c                 |  2 +-
 src/openvpn/route.c                  |  8 +++---
 src/openvpn/socket.c                 |  4 +--
 src/openvpn/ssl_verify.c             |  6 ++--
 src/openvpn/tun.c                    | 32 ++++++++++++----------
 tests/unit_tests/openvpn/test_argv.c | 41 +++++++++++++++++++---------
 13 files changed, 94 insertions(+), 85 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index afe8efff..419b1dc6 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -40,11 +40,30 @@
 #include "options.h"
 
 static void
+argv_extend(struct argv *a, const size_t newcap)
+{
+    if (newcap > a->capacity)
+    {
+        char **newargv;
+        size_t i;
+        ALLOC_ARRAY_CLEAR(newargv, char *, newcap);
+        for (i = 0; i < a->argc; ++i)
+        {
+            newargv[i] = a->argv[i];
+        }
+        free(a->argv);
+        a->argv = newargv;
+        a->capacity = newcap;
+    }
+}
+
+static void
 argv_init(struct argv *a)
 {
     a->capacity = 0;
     a->argc = 0;
     a->argv = NULL;
+    argv_extend(a, 8);
 }
 
 struct argv
@@ -56,7 +75,7 @@ argv_new(void)
 }
 
 void
-argv_reset(struct argv *a)
+argv_free(struct argv *a)
 {
     size_t i;
     for (i = 0; i < a->argc; ++i)
@@ -64,25 +83,18 @@ argv_reset(struct argv *a)
         free(a->argv[i]);
     }
     free(a->argv);
-    argv_init(a);
 }
 
 static void
-argv_extend(struct argv *a, const size_t newcap)
+argv_reset(struct argv *a)
 {
-    if (newcap > a->capacity)
+    size_t i;
+    for (i = 0; i < a->argc; ++i)
     {
-        char **newargv;
-        size_t i;
-        ALLOC_ARRAY_CLEAR(newargv, char *, newcap);
-        for (i = 0; i < a->argc; ++i)
-        {
-            newargv[i] = a->argv[i];
-        }
-        free(a->argv);
-        a->argv = newargv;
-        a->capacity = newcap;
+        free(a->argv[i]);
+        a->argv[i] = NULL;
     }
+    a->argc = 0;
 }
 
 static void
@@ -133,14 +145,7 @@ argv_insert_head(const struct argv *a, const char *head)
 const char *
 argv_str(const struct argv *a, struct gc_arena *gc, const unsigned int flags)
 {
-    if (a->argv)
-    {
-        return print_argv((const char **)a->argv, gc, flags);
-    }
-    else
-    {
-        return "";
-    }
+    return print_argv((const char **)a->argv, gc, flags);
 }
 
 void
@@ -221,8 +226,6 @@ argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
     va_list tmplist;
     int len;
 
-    argv_extend(a, 1); /* ensure trailing NULL */
-
     argc = a->argc;
     f = argv_prep_format(format, delim, &argc, &gc);
     if (f == NULL)
@@ -262,7 +265,6 @@ argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
     {
         /* Someone snuck in a \035, fail gracefully */
         argv_reset(a);
-        argv_extend(a, 1); /* ensure trailing NULL */
         goto out;
     }
 
@@ -304,7 +306,6 @@ argv_parse_cmd(struct argv *a, const char *s)
     struct gc_arena gc = gc_new();
 
     argv_reset(a);
-    argv_extend(a, 1); /* ensure trailing NULL */
 
     nparms = parse_line(s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &gc);
     if (nparms)
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index a24ba98f..2a1945e3 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -40,7 +40,7 @@ struct argv {
 
 struct argv argv_new(void);
 
-void argv_reset(struct argv *a);
+void argv_free(struct argv *a);
 
 const char *argv_str(const struct argv *a, struct gc_arena *gc, const unsigned int flags);
 
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index e7a72ae3..5b09dee4 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -84,7 +84,7 @@ get_console_input_systemd(const char *prompt, const bool echo, char *input, cons
     }
     close(std_out);
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return ret;
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1ed2c55e..25962958 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -162,7 +162,7 @@ run_up_down(const char *command,
             msg(M_FATAL, "ERROR: up/down plugin call failed");
         }
 
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     if (command)
@@ -175,7 +175,7 @@ run_up_down(const char *command,
                         ifconfig_local, ifconfig_remote, context);
         argv_msg(M_INFO, &argv);
         openvpn_run_script(&argv, es, S_FATAL, "--up/--down");
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     gc_free(&gc);
@@ -824,15 +824,6 @@ init_static(void)
     return false;
 #endif
 
-#ifdef ARGV_TEST
-    {
-        void argv_test(void);
-
-        argv_test();
-        return false;
-    }
-#endif
-
 #ifdef PRNG_TEST
     {
         struct gc_arena gc = gc_new();
@@ -1627,7 +1618,7 @@ do_route(const struct options *options,
         setenv_str(es, "script_type", "route-up");
         argv_parse_cmd(&argv, options->route_script);
         openvpn_run_script(&argv, es, 0, "--route-up");
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
 #ifdef _WIN32
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index ff71e48c..4df4151a 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -67,6 +67,6 @@ set_lladdr(const char *ifname, const char *lladdr,
         msg(M_INFO, "TUN/TAP link layer address set to %s", lladdr);
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
     return r;
 }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4545bce1..df0531e0 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -136,7 +136,7 @@ learn_address_script(const struct multi_context *m,
             msg(M_WARN, "WARNING: learn-address plugin call failed");
             ret = false;
         }
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     if (m->top.options.learn_address_script)
@@ -153,7 +153,7 @@ learn_address_script(const struct multi_context *m,
         {
             ret = false;
         }
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     gc_free(&gc);
@@ -594,7 +594,7 @@ multi_client_disconnect_script(struct multi_context *m,
             setenv_str(mi->context.c2.es, "script_type", "client-disconnect");
             argv_parse_cmd(&argv, mi->context.options.client_disconnect_script);
             openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-disconnect");
-            argv_reset(&argv);
+            argv_free(&argv);
         }
 #ifdef MANAGEMENT_DEF_AUTH
         if (management)
@@ -1908,7 +1908,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
             }
 
 script_depr_failed:
-            argv_reset(&argv);
+            argv_free(&argv);
         }
 
         /* V2 callback, use a plugin_return struct for passing back return info */
@@ -1970,7 +1970,7 @@ script_depr_failed:
             }
 
 script_failed:
-            argv_reset(&argv);
+            argv_free(&argv);
         }
 
         /*
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7aa311aa..edab9066 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3245,7 +3245,7 @@ check_cmd_access(const char *command, const char *opt, const char *chroot)
         return_code = true;
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return return_code;
 }
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 557b6bc7..65b113af 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -591,7 +591,7 @@ plugin_call_item(const struct plugin *p,
                 p->so_pathname);
         }
 
-        argv_reset(&a);
+        argv_free(&a);
         gc_free(&gc);
     }
     return status;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 02f7299f..0e4237d6 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1815,7 +1815,7 @@ done:
     {
         r->flags &= ~RT_ADDED;
     }
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
@@ -2122,7 +2122,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
     {
         r6->flags &= ~RT_ADDED;
     }
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
@@ -2314,7 +2314,7 @@ delete_route(struct route_ipv4 *r,
 
 done:
     r->flags &= ~RT_ADDED;
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
@@ -2548,7 +2548,7 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-down script");
 #endif /* if defined(TARGET_LINUX) */
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 0fc91f21..2f373116 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2334,7 +2334,7 @@ link_socket_connection_initiated(const struct buffer *buf,
         {
             msg(M_WARN, "WARNING: ipchange plugin call failed");
         }
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     /* Process --ipchange option */
@@ -2344,7 +2344,7 @@ link_socket_connection_initiated(const struct buffer *buf,
         setenv_str(es, "script_type", "ipchange");
         ipchange_fmt(true, &argv, info, &gc);
         openvpn_run_script(&argv, es, 0, "--ipchange");
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     gc_free(&gc);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 9cd36d7a..65342860 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -524,7 +524,7 @@ verify_cert_call_plugin(const struct plugin_list *plugins, struct env_set *es,
 
         ret = plugin_call_ssl(plugins, OPENVPN_PLUGIN_TLS_VERIFY, &argv, NULL, es, cert_depth, cert);
 
-        argv_reset(&argv);
+        argv_free(&argv);
 
         if (ret == OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
@@ -610,7 +610,7 @@ verify_cert_call_command(const char *verify_command, struct env_set *es,
     }
 
     gc_free(&gc);
-    argv_reset(&argv);
+    argv_free(&argv);
 
     if (ret)
     {
@@ -1153,7 +1153,7 @@ done:
         platform_unlink(tmp_file);
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
     return ret;
 }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 61d6b9eb..d0e56bf1 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1584,7 +1584,7 @@ do_ifconfig(struct tuntap *tt,
 #else  /* if defined(TARGET_LINUX) */
         msg(M_FATAL, "Sorry, but I don't know how to do 'ifconfig' commands on this operating system.  You should ifconfig your TUN/TAP device manually or use an --up script.");
 #endif /* if defined(TARGET_LINUX) */
-        argv_reset(&argv);
+        argv_free(&argv);
     }
     gc_free(&gc);
 }
@@ -2166,7 +2166,7 @@ close_tun(struct tuntap *tt)
 #endif
             }
 
-            argv_reset(&argv);
+            argv_free(&argv);
             gc_free(&gc);
         }
         close_tun_generic(tt);
@@ -2439,7 +2439,7 @@ solaris_close_tun(struct tuntap *tt)
                          IFCONFIG_PATH, tt->actual_name );
             argv_msg(M_INFO, &argv);
             openvpn_execve_check(&argv, NULL, 0, "Solaris ifconfig inet6 unplumb failed");
-            argv_reset(&argv);
+            argv_free(&argv);
         }
 
         if (tt->ip_fd >= 0)
@@ -2526,7 +2526,7 @@ solaris_error_close(struct tuntap *tt, const struct env_set *es,
     openvpn_execve_check(&argv, es, 0, "Solaris ifconfig unplumb failed");
     close_tun(tt);
     msg(M_FATAL, "Solaris ifconfig failed");
-    argv_reset(&argv);
+    argv_free(&argv);
 }
 
 int
@@ -2598,7 +2598,6 @@ close_tun(struct tuntap *tt)
     }
     else if (tt)
     {
-        struct gc_arena gc = gc_new();
         struct argv argv = argv_new();
 
         /* setup command, close tun dev (clears tt->actual_name!), run command
@@ -2612,6 +2611,7 @@ close_tun(struct tuntap *tt)
         argv_msg(M_INFO, &argv);
         openvpn_execve_check(&argv, NULL, 0, "OpenBSD 'destroy tun interface' failed (non-critical)");
 
+        argv_free(&argv);
         free(tt);
     }
 }
@@ -2683,7 +2683,6 @@ close_tun(struct tuntap *tt)
     }
     else if (tt)
     {
-        struct gc_arena gc = gc_new();
         struct argv argv = argv_new();
 
         /* setup command, close tun dev (clears tt->actual_name!), run command
@@ -2697,6 +2696,7 @@ close_tun(struct tuntap *tt)
         argv_msg(M_INFO, &argv);
         openvpn_execve_check(&argv, NULL, 0, "NetBSD 'destroy tun interface' failed (non-critical)");
 
+        argv_free(&argv);
         free(tt);
     }
 }
@@ -2834,6 +2834,7 @@ close_tun(struct tuntap *tt)
         argv_msg(M_INFO, &argv);
         openvpn_execve_check(&argv, NULL, 0, "FreeBSD 'destroy tun interface' failed (non-critical)");
 
+        argv_free(&argv);
         free(tt);
     }
 }
@@ -3201,7 +3202,7 @@ close_tun(struct tuntap *tt)
 
         close_tun_generic(tt);
         free(tt);
-        argv_reset(&argv);
+        argv_free(&argv);
         gc_free(&gc);
     }
 }
@@ -3306,6 +3307,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         env_set_add( es, "ODMDIR=/etc/objrepos" );
         openvpn_execve_check(&argv, es, S_FATAL, "AIX 'create tun interface' failed");
         env_set_destroy(es);
+        argv_free(&argv);
     }
     else
     {
@@ -3331,7 +3333,6 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 close_tun(struct tuntap *tt)
 {
-    struct gc_arena gc = gc_new();
     struct argv argv = argv_new();
     struct env_set *es = env_set_create(NULL);
 
@@ -3360,6 +3361,7 @@ close_tun(struct tuntap *tt)
 
     free(tt);
     env_set_destroy(es);
+    argv_free(&argv);
 }
 
 int
@@ -5028,14 +5030,14 @@ ipconfig_register_dns(const struct env_set *es)
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
     status = openvpn_execve_check(&argv, es, 0, err);
-    argv_reset(&argv);
+    argv_free(&argv);
 
     argv_printf(&argv, "%s%s /registerdns",
                 get_win_sys_path(),
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
     status = openvpn_execve_check(&argv, es, 0, err);
-    argv_reset(&argv);
+    argv_free(&argv);
 
     netcmd_semaphore_release();
     msg(D_TUNTAP_INFO, "End ipconfig commands for register-dns...");
@@ -5160,7 +5162,7 @@ netsh_set_dns6_servers(const struct in6_addr *addr_list,
         netsh_command(&argv, 1, (i==0) ? M_FATAL : M_NONFATAL);
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
@@ -5232,7 +5234,7 @@ netsh_ifconfig_options(const char *type,
         }
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
@@ -5323,7 +5325,7 @@ netsh_ifconfig(const struct tuntap_options *to,
                                BOOL_CAST(flags & NI_TEST_FIRST));
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
@@ -5342,7 +5344,7 @@ netsh_enable_dhcp(const struct tuntap_options *to,
 
     netsh_command(&argv, 4, M_FATAL);
 
-    argv_reset(&argv);
+    argv_free(&argv);
 }
 
 /*
@@ -6215,7 +6217,7 @@ close_tun(struct tuntap *tt)
                                 tt->actual_name);
                     netsh_command(&argv, 1, M_WARN);
                 }
-                argv_reset(&argv);
+                argv_free(&argv);
             }
         }
 #if 1
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index a09e92fb..e15e2fe5 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -39,7 +39,7 @@ argv_printf__multiple_spaces_in_format__parsed_as_one(void **state)
     argv_printf(&a, "    %s     %s  %d   ", PATH1, PATH2, 42);
     assert_int_equal(a.argc, 3);
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 static void
@@ -51,7 +51,7 @@ argv_printf_cat__multiple_spaces_in_format__parsed_as_one(void **state)
     argv_printf_cat(&a, " %s  %s", PATH2, PARAM1);
     assert_int_equal(a.argc, 3);
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 static void
@@ -63,7 +63,7 @@ argv_printf__embedded_format_directive__replaced_in_output(void **state)
     assert_int_equal(a.argc, 1);
     assert_string_equal(a.argv[0], "<p1:" PATH1 ">");
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 static void
@@ -74,7 +74,7 @@ argv_printf__group_sep_in_arg__fail_no_ouput(void **state)
     assert_false(argv_printf(&a, "tool --do %s", "this\035--harmful"));
     assert_int_equal(a.argc, 0);
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 static void
@@ -91,7 +91,7 @@ argv_printf__combined_path_with_spaces__argc_correct(void **state)
     argv_printf(&a, "foo %s%s %s x y", PATH2, PATH1, "foo");
     assert_int_equal(a.argc, 5);
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 static void
@@ -125,7 +125,7 @@ argv_parse_cmd__command_string__argc_correct(void **state)
     argv_parse_cmd(&a, SCRIPT_CMD);
     assert_int_equal(a.argc, 3);
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 static void
@@ -137,7 +137,7 @@ argv_parse_cmd__command_and_extra_options__argc_correct(void **state)
     argv_printf_cat(&a, "bar baz %d %s", 42, PATH1);
     assert_int_equal(a.argc, 7);
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 static void
@@ -150,7 +150,21 @@ argv_printf_cat__used_twice__argc_correct(void **state)
     argv_printf_cat(&a, "foo");
     assert_int_equal(a.argc, 5);
 
-    argv_reset(&a);
+    argv_free(&a);
+}
+
+static void
+argv_str__empty_argv__empty_output(void **state)
+{
+    struct argv a = argv_new();
+    struct gc_arena gc = gc_new();
+    const char *output;
+
+    output = argv_str(&a, &gc, PA_BRACKET);
+    assert_string_equal(output, "");
+
+    argv_free(&a);
+    gc_free(&gc);
 }
 
 static void
@@ -166,7 +180,7 @@ argv_str__multiple_argv__correct_output(void **state)
     output = argv_str(&a, &gc, PA_BRACKET);
     assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2 "]");
 
-    argv_reset(&a);
+    argv_free(&a);
     gc_free(&gc);
 }
 
@@ -179,9 +193,9 @@ argv_insert_head__empty_argv__head_only(void **state)
     b = argv_insert_head(&a, PATH1);
     assert_int_equal(b.argc, 1);
     assert_string_equal(b.argv[0], PATH1);
-    argv_reset(&b);
+    argv_free(&b);
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 static void
@@ -204,9 +218,9 @@ argv_insert_head__non_empty_argv__head_added(void **state)
             assert_string_equal(b.argv[i], a.argv[i - 1]);
         }
     }
-    argv_reset(&b);
+    argv_free(&b);
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 int
@@ -222,6 +236,7 @@ main(void)
         cmocka_unit_test(argv_parse_cmd__command_string__argc_correct),
         cmocka_unit_test(argv_parse_cmd__command_and_extra_options__argc_correct),
         cmocka_unit_test(argv_printf_cat__used_twice__argc_correct),
+        cmocka_unit_test(argv_str__empty_argv__empty_output),
         cmocka_unit_test(argv_str__multiple_argv__correct_output),
         cmocka_unit_test(argv_insert_head__non_empty_argv__head_added),
     };
-- 
2.11.0


