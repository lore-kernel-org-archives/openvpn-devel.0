From: David Sommerseth <davids@...515...>
Date: Thu,  6 Feb 2020 14:21:01 +0100
Message-Id: <20200206132103.15977-3-davids@...515...>
In-Reply-To: <20200206132103.15977-1-davids@...515...>
References: <20200206132103.15977-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH 2/4] argv: do fewer memory re-allocations
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

From: Heiko Hund <heiko.hund@...1489...>

Prevent the re-allocations of memory when the internal argv grows
beyond 2 and 4 arguments by initially allocating argv to hold up to
7 (+ trailing NULL) pointers.

While at it rename argv_reset to argv_free to actually express
what's going on. Redo the argv_reset functionality so that it can
be used to actually reset the argv without re-allocation.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
Signed-off-by: David Sommerseth <davids@...515...>
---
 src/openvpn/argv.c                   | 81 ++++++++++++++--------------
 src/openvpn/argv.h                   |  2 +-
 src/openvpn/console_systemd.c        |  2 +-
 src/openvpn/init.c                   | 15 ++----
 src/openvpn/lladdr.c                 |  2 +-
 src/openvpn/multi.c                  | 10 ++--
 src/openvpn/networking_iproute2.c    | 23 ++++----
 src/openvpn/options.c                |  2 +-
 src/openvpn/plugin.c                 |  2 +-
 src/openvpn/route.c                  |  8 +--
 src/openvpn/socket.c                 |  4 +-
 src/openvpn/ssl_verify.c             |  6 +--
 src/openvpn/tls_crypt.c              |  2 +-
 src/openvpn/tun.c                    | 38 ++++++-------
 tests/unit_tests/openvpn/test_argv.c | 43 ++++++++++-----
 15 files changed, 124 insertions(+), 116 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index fcf61ec5..4f7aa4e5 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -40,34 +40,6 @@
 #include "env_set.h"
 #include "options.h"
 
-static void
-argv_init(struct argv *a)
-{
-    a->capacity = 0;
-    a->argc = 0;
-    a->argv = NULL;
-}
-
-struct argv
-argv_new(void)
-{
-    struct argv ret;
-    argv_init(&ret);
-    return ret;
-}
-
-void
-argv_reset(struct argv *a)
-{
-    size_t i;
-    for (i = 0; i < a->argc; ++i)
-    {
-        free(a->argv[i]);
-    }
-    free(a->argv);
-    argv_init(a);
-}
-
 static void
 argv_extend(struct argv *a, const size_t newcap)
 {
@@ -86,6 +58,46 @@ argv_extend(struct argv *a, const size_t newcap)
     }
 }
 
+static void
+argv_init(struct argv *a)
+{
+    a->capacity = 0;
+    a->argc = 0;
+    a->argv = NULL;
+    argv_extend(a, 8);
+}
+
+struct argv
+argv_new(void)
+{
+    struct argv ret;
+    argv_init(&ret);
+    return ret;
+}
+
+void
+argv_free(struct argv *a)
+{
+    size_t i;
+    for (i = 0; i < a->argc; ++i)
+    {
+        free(a->argv[i]);
+    }
+    free(a->argv);
+}
+
+static void
+argv_reset(struct argv *a)
+{
+    size_t i;
+    for (i = 0; i < a->argc; ++i)
+    {
+        free(a->argv[i]);
+        a->argv[i] = NULL;
+    }
+    a->argc = 0;
+}
+
 static void
 argv_grow(struct argv *a, const size_t add)
 {
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
     const char delim = 0x1D;  /* ASCII Group Separator (GS) */
     bool res = false;
 
-    argv_extend(a, 1); /* ensure trailing NULL */
-
     /*
      * Prepare a format string which will be used by vsnprintf() later on.
      *
@@ -279,7 +282,6 @@ argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
     {
         /* Someone snuck in a GS (0x1D), fail gracefully */
         argv_reset(a);
-        argv_extend(a, 1); /* ensure trailing NULL */
         goto out;
     }
     res = true;
@@ -318,7 +320,6 @@ void
 argv_parse_cmd(struct argv *a, const char *s)
 {
     argv_reset(a);
-    argv_extend(a, 1); /* ensure trailing NULL */
 
     struct gc_arena gc = gc_new();
     char *parms[MAX_PARMS + 1] = { 0 };
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index b9105a43..989cd297 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -40,7 +40,7 @@ struct argv {
 
 struct argv argv_new(void);
 
-void argv_reset(struct argv *a);
+void argv_free(struct argv *a);
 
 const char *argv_str(const struct argv *a, struct gc_arena *gc, const unsigned int flags);
 
diff --git a/src/openvpn/console_systemd.c b/src/openvpn/console_systemd.c
index 8d9e825b..c7cf1ada 100644
--- a/src/openvpn/console_systemd.c
+++ b/src/openvpn/console_systemd.c
@@ -85,7 +85,7 @@ get_console_input_systemd(const char *prompt, const bool echo, char *input, cons
     }
     close(std_out);
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return ret;
 }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 04207b61..db7d1216 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -164,7 +164,7 @@ run_up_down(const char *command,
             msg(M_FATAL, "ERROR: up/down plugin call failed");
         }
 
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     if (command)
@@ -177,7 +177,7 @@ run_up_down(const char *command,
                         ifconfig_local, ifconfig_remote, context);
         argv_msg(M_INFO, &argv);
         openvpn_run_script(&argv, es, S_FATAL, "--up/--down");
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     gc_free(&gc);
@@ -845,15 +845,6 @@ init_static(void)
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
@@ -1696,7 +1687,7 @@ do_route(const struct options *options,
         setenv_str(es, "script_type", "route-up");
         argv_parse_cmd(&argv, options->route_script);
         openvpn_run_script(&argv, es, 0, "--route-up");
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
 #ifdef _WIN32
diff --git a/src/openvpn/lladdr.c b/src/openvpn/lladdr.c
index e6b26fc9..22857eb7 100644
--- a/src/openvpn/lladdr.c
+++ b/src/openvpn/lladdr.c
@@ -69,6 +69,6 @@ set_lladdr(const char *ifname, const char *lladdr,
         msg(M_INFO, "TUN/TAP link layer address set to %s", lladdr);
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
     return r;
 }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index d594dd25..279cab23 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -139,7 +139,7 @@ learn_address_script(const struct multi_context *m,
             msg(M_WARN, "WARNING: learn-address plugin call failed");
             ret = false;
         }
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     if (m->top.options.learn_address_script)
@@ -156,7 +156,7 @@ learn_address_script(const struct multi_context *m,
         {
             ret = false;
         }
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     gc_free(&gc);
@@ -592,7 +592,7 @@ multi_client_disconnect_script(struct multi_instance *mi)
             setenv_str(mi->context.c2.es, "script_type", "client-disconnect");
             argv_parse_cmd(&argv, mi->context.options.client_disconnect_script);
             openvpn_run_script(&argv, mi->context.c2.es, 0, "--client-disconnect");
-            argv_reset(&argv);
+            argv_free(&argv);
         }
 #ifdef MANAGEMENT_DEF_AUTH
         if (management)
@@ -1907,7 +1907,7 @@ multi_connection_established(struct multi_context *m, struct multi_instance *mi)
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
diff --git a/src/openvpn/networking_iproute2.c b/src/openvpn/networking_iproute2.c
index 1db39fc7..0f9e899a 100644
--- a/src/openvpn/networking_iproute2.c
+++ b/src/openvpn/networking_iproute2.c
@@ -28,6 +28,7 @@
 
 #include "syshead.h"
 
+#include "argv.h"
 #include "networking.h"
 #include "misc.h"
 #include "openvpn.h"
@@ -70,7 +71,7 @@ net_iface_up(openvpn_net_ctx_t *ctx, const char *iface, bool up)
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip link set failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
@@ -101,7 +102,7 @@ net_addr_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
@@ -119,7 +120,7 @@ net_addr_v6_add(openvpn_net_ctx_t *ctx, const char *iface,
     openvpn_execve_check(&argv, ctx->es, S_FATAL,
                          "Linux ip -6 addr add failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
@@ -137,7 +138,7 @@ net_addr_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux ip addr del failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
@@ -154,7 +155,7 @@ net_addr_v6_del(openvpn_net_ctx_t *ctx, const char *iface,
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux ip -6 addr del failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
@@ -172,7 +173,7 @@ net_addr_ptp_v4_add(openvpn_net_ctx_t *ctx, const char *iface,
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, S_FATAL, "Linux ip addr add failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
@@ -190,7 +191,7 @@ net_addr_ptp_v4_del(openvpn_net_ctx_t *ctx, const char *iface,
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "Linux ip addr del failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
@@ -221,7 +222,7 @@ net_route_v4_add(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route add command failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
@@ -250,7 +251,7 @@ net_route_v6_add(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 add command failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
@@ -271,7 +272,7 @@ net_route_v4_del(openvpn_net_ctx_t *ctx, const in_addr_t *dst, int prefixlen,
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route delete command failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
@@ -300,7 +301,7 @@ net_route_v6_del(openvpn_net_ctx_t *ctx, const struct in6_addr *dst,
     argv_msg(D_ROUTE, &argv);
     openvpn_execve_check(&argv, ctx->es, 0, "ERROR: Linux route -6 del command failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return 0;
 }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index c459b260..6c0e52e6 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3349,7 +3349,7 @@ check_cmd_access(const char *command, const char *opt, const char *chroot)
         return_code = true;
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
 
     return return_code;
 }
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index b9708342..dba9d335 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -586,7 +586,7 @@ plugin_call_item(const struct plugin *p,
                 p->so_pathname);
         }
 
-        argv_reset(&a);
+        argv_free(&a);
         gc_free(&gc);
     }
     return status;
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8c0cbb1d..e0f8d201 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1822,7 +1822,7 @@ done:
     {
         r->flags &= ~RT_ADDED;
     }
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
     /* release resources potentially allocated during route setup */
     net_ctx_reset(ctx);
@@ -2128,7 +2128,7 @@ done:
     {
         r6->flags &= ~RT_ADDED;
     }
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
     /* release resources potentially allocated during route setup */
     net_ctx_reset(ctx);
@@ -2322,7 +2322,7 @@ delete_route(struct route_ipv4 *r,
 
 done:
     r->flags &= ~RT_ADDED;
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
     /* release resources potentially allocated during route cleanup */
     net_ctx_reset(ctx);
@@ -2550,7 +2550,7 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
     msg(M_FATAL, "Sorry, but I don't know how to do 'route ipv6' commands on this operating system.  Try putting your routes in a --route-down script");
 #endif /* if defined(TARGET_LINUX) */
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
     /* release resources potentially allocated during route cleanup */
     net_ctx_reset(ctx);
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 983ed38a..f2fb54da 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2471,7 +2471,7 @@ link_socket_connection_initiated(const struct buffer *buf,
         {
             msg(M_WARN, "WARNING: ipchange plugin call failed");
         }
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     /* Process --ipchange option */
@@ -2481,7 +2481,7 @@ link_socket_connection_initiated(const struct buffer *buf,
         setenv_str(es, "script_type", "ipchange");
         ipchange_fmt(true, &argv, info, &gc);
         openvpn_run_script(&argv, es, 0, "--ipchange");
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     gc_free(&gc);
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 65188d23..da0966c5 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -488,7 +488,7 @@ verify_cert_call_plugin(const struct plugin_list *plugins, struct env_set *es,
 
         ret = plugin_call_ssl(plugins, OPENVPN_PLUGIN_TLS_VERIFY, &argv, NULL, es, cert_depth, cert);
 
-        argv_reset(&argv);
+        argv_free(&argv);
 
         if (ret == OPENVPN_PLUGIN_FUNC_SUCCESS)
         {
@@ -581,7 +581,7 @@ verify_cert_call_command(const char *verify_command, struct env_set *es,
 
 cleanup:
     gc_free(&gc);
-    argv_reset(&argv);
+    argv_free(&argv);
 
     if (ret)
     {
@@ -1129,7 +1129,7 @@ done:
         platform_unlink(tmp_file);
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
     return ret;
 }
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index e8889e93..37df2ce7 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -544,7 +544,7 @@ tls_crypt_v2_verify_metadata(const struct tls_wrap_ctx *ctx,
 
     ret = openvpn_run_script(&argv, es, 0, "--tls-crypt-v2-verify");
 
-    argv_reset(&argv);
+    argv_free(&argv);
     env_set_destroy(es);
 
     if (!platform_unlink(tmp_file))
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 99693016..aa131b25 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1046,7 +1046,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
 
 #if !defined(TARGET_LINUX)
     gc_free(&gc);
-    argv_reset(&argv);
+    argv_free(&argv);
 #endif
 }
 
@@ -1419,7 +1419,7 @@ do_ifconfig_ipv4(struct tuntap *tt, const char *ifname, int tun_mtu,
 
 #if !defined(TARGET_LINUX)
     gc_free(&gc);
-    argv_reset(&argv);
+    argv_free(&argv);
 #endif
 }
 
@@ -1999,7 +1999,7 @@ undo_ifconfig_ipv4(struct tuntap *tt, openvpn_net_ctx_t *ctx)
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, NULL, 0, "Generic ip addr del failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
 #endif /* ifdef TARGET_LINUX */
 }
 
@@ -2023,7 +2023,7 @@ undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, NULL, 0, "Linux ip -6 addr del failed");
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 #endif /* ifdef TARGET_LINUX */
 }
@@ -2316,7 +2316,7 @@ solaris_close_tun(struct tuntap *tt)
                      IFCONFIG_PATH, tt->actual_name );
         argv_msg(M_INFO, &argv);
         openvpn_execve_check(&argv, NULL, 0, "Solaris ifconfig inet6 unplumb failed");
-        argv_reset(&argv);
+        argv_free(&argv);
     }
 
     if (tt->ip_fd >= 0)
@@ -2401,7 +2401,7 @@ solaris_error_close(struct tuntap *tt, const struct env_set *es,
     openvpn_execve_check(&argv, es, 0, "Solaris ifconfig unplumb failed");
     close_tun(tt, NULL);
     msg(M_FATAL, "Solaris ifconfig failed");
-    argv_reset(&argv);
+    argv_free(&argv);
 }
 
 int
@@ -2489,7 +2489,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
     openvpn_execve_check(&argv, NULL, 0, "OpenBSD 'destroy tun interface' failed (non-critical)");
 
     free(tt);
-    argv_reset(&argv);
+    argv_free(&argv);
 }
 
 int
@@ -2575,7 +2575,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
     openvpn_execve_check(&argv, NULL, 0, "NetBSD 'destroy tun interface' failed (non-critical)");
 
     free(tt);
-    argv_reset(&argv);
+    argv_free(&argv);
 }
 
 static inline int
@@ -2716,7 +2716,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
                          "FreeBSD 'destroy tun interface' failed (non-critical)");
 
     free(tt);
-    argv_reset(&argv);
+    argv_free(&argv);
 }
 
 int
@@ -3081,7 +3081,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 
     close_tun_generic(tt);
     free(tt);
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
@@ -3185,7 +3185,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
         env_set_add( es, "ODMDIR=/etc/objrepos" );
         openvpn_execve_check(&argv, es, S_FATAL, "AIX 'create tun interface' failed");
         env_set_destroy(es);
-        argv_reset(&argv);
+        argv_free(&argv);
     }
     else
     {
@@ -3236,7 +3236,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 
     free(tt);
     env_set_destroy(es);
-    argv_reset(&argv);
+    argv_free(&argv);
 }
 
 int
@@ -5069,14 +5069,14 @@ ipconfig_register_dns(const struct env_set *es)
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
     openvpn_execve_check(&argv, es, 0, err);
-    argv_reset(&argv);
+    argv_free(&argv);
 
     argv_printf(&argv, "%s%s /registerdns",
                 get_win_sys_path(),
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
     openvpn_execve_check(&argv, es, 0, err);
-    argv_reset(&argv);
+    argv_free(&argv);
 
     netcmd_semaphore_release();
     msg(D_TUNTAP_INFO, "End ipconfig commands for register-dns...");
@@ -5201,7 +5201,7 @@ netsh_set_dns6_servers(const struct in6_addr *addr_list,
         netsh_command(&argv, 1, (i==0) ? M_FATAL : M_NONFATAL);
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
@@ -5273,7 +5273,7 @@ netsh_ifconfig_options(const char *type,
         }
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
@@ -5364,7 +5364,7 @@ netsh_ifconfig(const struct tuntap_options *to,
                                BOOL_CAST(flags & NI_TEST_FIRST));
     }
 
-    argv_reset(&argv);
+    argv_free(&argv);
     gc_free(&gc);
 }
 
@@ -5382,7 +5382,7 @@ netsh_enable_dhcp(const char *actual_name)
 
     netsh_command(&argv, 4, M_FATAL);
 
-    argv_reset(&argv);
+    argv_free(&argv);
 }
 
 /* Enable dhcp on tap adapter using iservice */
@@ -6481,7 +6481,7 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
                     tt->actual_name);
         netsh_command(&argv, 1, M_WARN);
     }
-    argv_reset(&argv);
+    argv_free(&argv);
 }
 
 void
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 9b72ad04..fde0ba45 100644
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
@@ -114,7 +114,7 @@ argv_printf__empty_parameter__argc_correct(void **state)
     argv_printf(&a, "%s %s", "", PARAM1);
     assert_int_equal(a.argc, 2);
 
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
@@ -170,7 +184,7 @@ argv_str__multiple_argv__correct_output(void **state)
     assert_string_equal(output, "[" PATH1 PATH2 "] [" PARAM1 "] [" PARAM2 "]"
 				" [-1] [4294967295] [1]");
 
-    argv_reset(&a);
+    argv_free(&a);
     gc_free(&gc);
 }
 
@@ -183,9 +197,9 @@ argv_insert_head__empty_argv__head_only(void **state)
     b = argv_insert_head(&a, PATH1);
     assert_int_equal(b.argc, 1);
     assert_string_equal(b.argv[0], PATH1);
-    argv_reset(&b);
+    argv_free(&b);
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 static void
@@ -208,9 +222,9 @@ argv_insert_head__non_empty_argv__head_added(void **state)
             assert_string_equal(b.argv[i], a.argv[i - 1]);
         }
     }
-    argv_reset(&b);
+    argv_free(&b);
 
-    argv_reset(&a);
+    argv_free(&a);
 }
 
 int
@@ -226,6 +240,7 @@ main(void)
         cmocka_unit_test(argv_parse_cmd__command_string__argc_correct),
         cmocka_unit_test(argv_parse_cmd__command_and_extra_options__argc_correct),
         cmocka_unit_test(argv_printf_cat__used_twice__argc_correct),
+        cmocka_unit_test(argv_str__empty_argv__empty_output),
         cmocka_unit_test(argv_str__multiple_argv__correct_output),
         cmocka_unit_test(argv_insert_head__non_empty_argv__head_added),
     };
-- 
2.17.1


