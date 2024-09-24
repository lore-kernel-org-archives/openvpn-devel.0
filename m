From: Gert Doering <gert@...1296...>
Date: Tue, 24 Sep 2024 13:01:29 +0200
Message-ID: <20240924110130.3910-1-gert@...1296...>
In-Reply-To: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
References: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v11] Introduce DRIVER_AFUNIX backend for use
 with lwipovpn
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

From: Arne Schwabe <arne@...1227...>

lwipovpn is a using lwip TCP/IP implementation with an AF_UNIX
implementation to emulate a tun/tap device without messing with the
TCP/IP stack of the host.

For more information about lwipovpn see https://github.com/OpenVPN/lwipovpn

Change-Id: I65099ef00822d08fd3f5480c80892f3bf86c56e7
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/747
This mail reflects revision 11 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/CMakeLists.txt b/CMakeLists.txt
index ad620fa..6271574 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -536,6 +536,8 @@
     src/openvpn/tls_crypt.c
     src/openvpn/tun.c
     src/openvpn/tun.h
+    src/openvpn/tun_afunix.c
+    src/openvpn/tun_afunix.h
     src/openvpn/networking_sitnl.c
     src/openvpn/networking_freebsd.c
     src/openvpn/auth_token.c
diff --git a/Changes.rst b/Changes.rst
index 439352a..7d19577 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -9,6 +9,19 @@
     the user experience as the client shows an error instead of running into
     a timeout when the server just stops responding completely.
 
+Support for tun/tap via unix domain socket and lwipovpn support
+    To allow better testing and emulating a full client with a full
+    network stack OpenVPN now allows a program executed to provide
+    a tun/tap device instead of opening a device.
+
+    The co-developed lwipovpn program based on lwIP stack allows to
+    simulate full IP stack and an OpenVPN client using
+    ``--dev-node unix:/path/to/lwipovpn`` can emulate a full client that
+    can be pinged, can serve a website and more without requiring any
+    elevated permission. This can make testing OpenVPN much easier.
+
+    For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/lwipovpn).
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vpn-network-options.rst
index 84d4273..fc76939 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -117,6 +117,16 @@
   figure out whether ``node`` is a TUN or TAP device based on the name,
   you should also specify ``--dev-type tun`` or ``--dev-type tap``.
 
+  If ``node`` starts with the string ``unix:`` openvpn will treat the rest
+  of the argument as a program.
+  OpenVPN will start the program and create a temporary unix domain socket that
+  will be passed to the program together with the tun configuration as
+  environment variables.  The temporary unix domain socket  will be be passed
+  in the environment variable :code:`TUNTAP_SOCKET_FD`.
+
+  This ``unix:`` mode is designed mainly to use with the lwipovpn network
+  emulator (https://github.com/OpenVPN/lwipovpn).
+
 --dev-type device-type
   Which device type are we using? ``device-type`` should be :code:`tun`
   (OSI Layer 3) or :code:`tap` (OSI Layer 2). Use this option only if
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index 3784a98..ecb2bcf 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -140,6 +140,7 @@
 	syshead.h \
 	tls_crypt.c tls_crypt.h \
 	tun.c tun.h \
+	tun_afunix.c tun_afunix.h \
 	vlan.c vlan.h \
 	xkey_provider.c xkey_common.h \
 	xkey_helper.c \
diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 0df185e..ecef455 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -41,6 +41,7 @@
 #include "ssl_common.h"
 #include "ssl_ncp.h"
 #include "tun.h"
+#include "tun_afunix.h"
 
 #ifdef HAVE_LIBCAPNG
 #include <cap-ng.h>
@@ -298,6 +299,13 @@
         return false;
     }
 
+    if (is_tun_afunix(o->dev_node))
+    {
+        msg(msglevel, "Note: afunix tun type selected, disabling data channel"
+            "offload");
+        return false;
+    }
+
     if (o->connection_list)
     {
         const struct connection_list *l = o->connection_list;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a88a4bb..6df01d1 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -41,6 +41,7 @@
 #include "ssl_verify.h"
 #include "dco.h"
 #include "auth_token.h"
+#include "tun_afunix.h"
 
 #include "memdbg.h"
 
@@ -1319,7 +1320,14 @@
 #else  /* ifdef _WIN32 */
     ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));
     ASSERT(buf_safe(&c->c2.buf, c->c2.frame.buf.payload_size));
-    c->c2.buf.len = read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame.buf.payload_size);
+    if (c->c1.tuntap->backend_driver == DRIVER_AFUNIX)
+    {
+        c->c2.buf.len = read_tun_afunix(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame.buf.payload_size);
+    }
+    else
+    {
+        c->c2.buf.len = read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame.buf.payload_size);
+    }
 #endif /* ifdef _WIN32 */
 
 #ifdef PACKET_TRUNCATION_CHECK
@@ -1926,7 +1934,14 @@
 #ifdef _WIN32
         size = write_tun_buffered(c->c1.tuntap, &c->c2.to_tun);
 #else
-        size = write_tun(c->c1.tuntap, BPTR(&c->c2.to_tun), BLEN(&c->c2.to_tun));
+        if (c->c1.tuntap->backend_driver == DRIVER_AFUNIX)
+        {
+            size = write_tun_afunix(c->c1.tuntap, BPTR(&c->c2.to_tun), BLEN(&c->c2.to_tun));
+        }
+        else
+        {
+            size = write_tun(c->c1.tuntap, BPTR(&c->c2.to_tun), BLEN(&c->c2.to_tun));
+        }
 #endif
 
         if (size > 0)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 83cc670..1a14e19 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -54,6 +54,7 @@
 #include "mss.h"
 #include "mudp.h"
 #include "dco.h"
+#include "tun_afunix.h"
 
 #include "memdbg.h"
 
@@ -1758,10 +1759,18 @@
                             &c->net_ctx,
                             c->c1.tuntap);
 
+    if (is_tun_afunix(c->options.dev_node))
+    {
+        /* Using AF_UNIX trumps using DCO */
+        c->c1.tuntap->backend_driver = DRIVER_AFUNIX;
+    }
 #ifdef _WIN32
-    c->c1.tuntap->backend_driver = c->options.windows_driver;
+    else
+    {
+        c->c1.tuntap->backend_driver = c->options.windows_driver;
+    }
 #else
-    if (dco_enabled(&c->options))
+    else if (dco_enabled(&c->options))
     {
         c->c1.tuntap->backend_driver = DRIVER_DCO;
     }
@@ -1786,6 +1795,10 @@
 static bool
 can_preserve_tun(struct tuntap *tt)
 {
+    if (tt && tt->backend_driver == DRIVER_AFUNIX)
+    {
+        return false;
+    }
 #ifdef TARGET_ANDROID
     return false;
 #else
@@ -1841,6 +1854,22 @@
 #endif
 }
 
+static void
+open_tun_backend(struct context *c)
+{
+    struct tuntap *tt = c->c1.tuntap;
+    if (tt->backend_driver == DRIVER_AFUNIX)
+    {
+        open_tun_afunix(&c->options, c->c2.frame.tun_mtu, tt, c->c2.es);
+    }
+    else
+    {
+        open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
+                 tt, &c->net_ctx);
+    }
+}
+
+
 static bool
 do_open_tun(struct context *c, int *error_flags)
 {
@@ -1863,7 +1892,8 @@
         }
 #endif
 
-        /* initialize (but do not open) tun/tap object */
+        /* initialize (but do not open) tun/tap object, this also sets
+         * the backend driver type */
         do_init_tun(c);
 
         /* inherit the dco context from the tuntap object */
@@ -1898,7 +1928,7 @@
 
         /* do ifconfig */
         if (!c->options.ifconfig_noexec
-            && ifconfig_order() == IFCONFIG_BEFORE_TUN_OPEN)
+            && ifconfig_order(c->c1.tuntap) == IFCONFIG_BEFORE_TUN_OPEN)
         {
             /* guess actual tun/tap unit number that will be returned
              * by open_tun */
@@ -1911,7 +1941,7 @@
         }
 
         /* possibly add routes */
-        if (route_order() == ROUTE_BEFORE_TUN)
+        if (route_order(c->c1.tuntap) == ROUTE_BEFORE_TUN)
         {
             /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be ignored */
             bool status = do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
@@ -1928,8 +1958,7 @@
         }
 
         /* open the tun device */
-        open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
-                 c->c1.tuntap, &c->net_ctx);
+        open_tun_backend(c);
 
         /* set the hardware address */
         if (c->options.lladdr)
@@ -1940,7 +1969,7 @@
 
         /* do ifconfig */
         if (!c->options.ifconfig_noexec
-            && ifconfig_order() == IFCONFIG_AFTER_TUN_OPEN)
+            && ifconfig_order(c->c1.tuntap) == IFCONFIG_AFTER_TUN_OPEN)
         {
             do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
                         c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
@@ -1966,7 +1995,7 @@
         add_wfp_block(c);
 
         /* possibly add routes */
-        if ((route_order() == ROUTE_AFTER_TUN) && (!c->options.route_delay_defined))
+        if ((route_order(c->c1.tuntap) == ROUTE_AFTER_TUN) && (!c->options.route_delay_defined))
         {
             int status = do_route(&c->options, c->c1.route_list, c->c1.route_ipv6_list,
                                   c->c1.tuntap, c->plugins, c->c2.es, &c->net_ctx);
@@ -2026,7 +2055,14 @@
         {
             undo_ifconfig(c->c1.tuntap, &c->net_ctx);
         }
-        close_tun(c->c1.tuntap, &c->net_ctx);
+        if (c->c1.tuntap->backend_driver == DRIVER_AFUNIX)
+        {
+            close_tun_afunix(c->c1.tuntap);
+        }
+        else
+        {
+            close_tun(c->c1.tuntap, &c->net_ctx);
+        }
         c->c1.tuntap = NULL;
     }
     c->c1.tuntap_owned = false;
@@ -2466,7 +2502,7 @@
             c->c1.pulled_options_digest_save = c->c2.pulled_options_digest;
 
             /* if --route-delay was specified, start timer */
-            if ((route_order() == ROUTE_AFTER_TUN) && c->options.route_delay_defined)
+            if ((route_order(c->c1.tuntap) == ROUTE_AFTER_TUN) && c->options.route_delay_defined)
             {
                 event_timeout_init(&c->c2.route_wakeup, c->options.route_delay, now);
                 event_timeout_init(&c->c2.route_wakeup_expire, c->options.route_delay + c->options.route_delay_window, now);
diff --git a/src/openvpn/run_command.c b/src/openvpn/run_command.c
index 292e81f..d757823 100644
--- a/src/openvpn/run_command.c
+++ b/src/openvpn/run_command.c
@@ -155,6 +155,10 @@
             {
                 msg(M_ERR, "openvpn_execve: unable to fork");
             }
+            else if (flags & S_NOWAITPID)
+            {
+                ret = pid;
+            }
             else /* parent side */
             {
                 if (waitpid(pid, &ret, 0) != pid)
@@ -204,6 +208,11 @@
             goto done;
         }
     }
+    else if (flags & S_NOWAITPID && (stat > 0))
+    {
+        ret = stat;
+        goto done;
+    }
     else if (platform_system_ok(stat))
     {
         ret = true;
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index ccad307..c92edbc 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -47,6 +47,9 @@
 /** Instead of returning 1/0 for success/fail,
  * return exit code when between 0 and 255 and -1 otherwise */
 #define S_EXITCODE  (1<<2)
+/** instead of waiting for child process to exit and report the status,
+ * return the pid of the child process */
+#define S_NOWAITPID (1<<3)
 
 /* wrapper around the execve() call */
 int openvpn_popen(const struct argv *a,  const struct env_set *es);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3959363..b305b64 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -72,6 +72,9 @@
         case DRIVER_DCO:
             return "ovpn-dco";
 
+        case DRIVER_AFUNIX:
+            return "unix";
+
         case DRIVER_UTUN:
             return "utun";
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 80f8bfa..a38aef0 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -47,6 +47,10 @@
     WINDOWS_DRIVER_TAP_WINDOWS6,
     WINDOWS_DRIVER_WINTUN,
     DRIVER_GENERIC_TUNTAP,
+    /** using an AF_UNIX socket to pass packets from/to an external program.
+     *  This is always defined. We error out if a user tries to open this type
+     *  of backend on unsupported platforms. */
+    DRIVER_AFUNIX,
     DRIVER_DCO,
     /** macOS internal tun driver */
     DRIVER_UTUN
@@ -161,6 +165,17 @@
 /*
  * Define a TUN/TAP dev.
  */
+#ifndef WIN32
+typedef struct afunix_context
+{
+    pid_t childprocess;
+} afunix_context_t;
+
+#else /* ifndef WIN32 */
+typedef struct {
+    int dummy;
+} afunix_context_t;
+#endif
 
 struct tuntap
 {
@@ -175,7 +190,12 @@
      */
     enum tun_driver_type backend_driver;
 
+    /** if the internal variables related to ifconfig of this struct have
+     * been set up. This does NOT mean ifconfig has been called */
     bool did_ifconfig_setup;
+
+    /** if the internal variables related to ifconfig-ipv6 of this struct have
+     * been set up. This does NOT mean ifconfig has been called */
     bool did_ifconfig_ipv6_setup;
 
     bool persistent_if;         /* if existed before, keep on program end */
@@ -227,6 +247,7 @@
     unsigned int rwflags_debug;
 
     dco_context_t dco;
+    afunix_context_t afunix;
 };
 
 static inline bool
@@ -350,8 +371,12 @@
 #define IFCONFIG_DEFAULT         IFCONFIG_AFTER_TUN_OPEN
 
 static inline int
-ifconfig_order(void)
+ifconfig_order(struct tuntap *tt)
 {
+    if (tt->backend_driver == DRIVER_AFUNIX)
+    {
+        return IFCONFIG_BEFORE_TUN_OPEN;
+    }
 #if defined(TARGET_LINUX)
     return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(TARGET_SOLARIS)
@@ -376,8 +401,12 @@
 #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN
 
 static inline int
-route_order(void)
+route_order(struct tuntap *tt)
 {
+    if (tt->backend_driver == DRIVER_AFUNIX)
+    {
+        return ROUTE_BEFORE_TUN;
+    }
 #if defined(TARGET_ANDROID)
     return ROUTE_BEFORE_TUN;
 #else
@@ -755,5 +784,4 @@
 {
     return tt && tt->type != DEV_TYPE_UNDEF;
 }
-
 #endif /* TUN_H */
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
new file mode 100644
index 0000000..f4ce4b7
--- /dev/null
+++ b/src/openvpn/tun_afunix.c
@@ -0,0 +1,178 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "tun.h"
+#include "fdmisc.h"
+#include "run_command.h"
+#include "manage.h"
+#include "win32.h"
+#include "wfp_block.h"
+#include "argv.h"
+#include "options.h"
+
+#ifndef WIN32
+/* Windows does implement some AF_UNIX functionality but key features
+ * like socketpair() and SOCK_DGRAM are missing */
+
+#include <string.h>
+#include <unistd.h>
+#include <sys/wait.h>
+#include <signal.h>
+#include <stdlib.h>
+
+static void
+tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct env_set *env)
+{
+    struct argv argv = argv_new();
+
+    /* since we know that dev-node starts with unix: we can just skip that
+     * to get the program name */
+    const char *program = dev_node + strlen("unix:");
+
+    argv_printf(&argv, "%s", program);
+
+    argv_msg(M_INFO, &argv);
+    tt->afunix.childprocess = openvpn_execve_check(&argv, env, S_NOWAITPID,
+                                                   "ERROR: failure executing "
+                                                   "process for tun");
+    argv_free(&argv);
+}
+
+void
+open_tun_afunix(struct options *o,
+                int mtu,
+                struct tuntap *tt,
+                struct env_set *orig_env)
+{
+    struct gc_arena gc = gc_new();
+
+    int fds[2];
+    if (!(socketpair(AF_UNIX, SOCK_DGRAM, 0, fds) == 0))
+    {
+        msg(M_ERR, "Cannot create socket pair for AF_UNIX socket to external "
+            "program");
+        return;
+    }
+
+    /* Use the first file descriptor for our side and avoid passing it
+     * to the child */
+    tt->fd = fds[1];
+    set_cloexec(tt->fd);
+
+    /* Make a copy of the env, so we do not need to delete our custom
+     * environment variables later */
+    struct env_set *env = env_set_create(&gc);
+    env_set_inherit(env, orig_env);
+
+    setenv_int(env, "TUNTAP_SOCKET_FD", fds[0]);
+    setenv_str(env, "TUNTAP_DEV_TYPE", dev_type_string(o->dev, o->dev_type));
+    setenv_int(env, "TUNTAP_MTU", mtu);
+    if (o->route_default_gateway)
+    {
+        setenv_str(env, "ifconfig_gateway", o->route_default_gateway);
+    }
+    if (o->lladdr)
+    {
+        setenv_str(env, "TUNTAP_LLADDR", o->lladdr);
+    }
+
+    tun_afunix_exec_child(o->dev_node, tt, env);
+
+    close(fds[0]);
+
+    /* tt->actual_name is passed to up and down scripts and used as the ifconfig dev name */
+    tt->actual_name = string_alloc("internal:af_unix", NULL);
+
+    gc_free(&gc);
+}
+
+void
+close_tun_afunix(struct tuntap *tt)
+{
+    ASSERT(tt);
+    if (tt->fd >= 0)
+    {
+        close(tt->fd);
+        tt->fd = 0;
+    }
+    kill(tt->afunix.childprocess, SIGINT);
+
+    free(tt->actual_name);
+    free(tt);
+}
+
+ssize_t
+write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
+{
+    int ret;
+    pid_t pidret = waitpid(tt->afunix.childprocess, &ret, WNOHANG);
+    if (pidret == tt->afunix.childprocess)
+    {
+        msg(M_INFO, "Child process PID %d for afunix dead? Return code: %d",
+            tt->afunix.childprocess, ret);
+        return -ENXIO;
+    }
+    return write(tt->fd, buf, len);
+}
+
+ssize_t
+read_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
+{
+    return read(tt->fd, buf, len);
+}
+#else  /* ifndef WIN32 */
+void
+open_tun_afunix(const char *dev, const char *dev_type, int mtu,
+                struct tuntap *tt, struct env_set env)
+{
+    msg(M_ERR, "AF_UNIX socket support not available on this platform");
+}
+
+void
+close_tun_afunix(struct tuntap *tt)
+{
+    /* should never be called as open_tun_afunix always fails */
+    ASSERT(0);
+}
+
+ssize_t
+write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
+{
+    /* should never be called as open_tun_afunix always fails */
+    ASSERT(0);
+}
+
+ssize_t
+read_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
+{
+    /* should never be called as open_tun_afunix always fails */
+    ASSERT(0);
+}
+
+#endif /* ifndef WIN32 */
diff --git a/src/openvpn/tun_afunix.h b/src/openvpn/tun_afunix.h
new file mode 100644
index 0000000..265602f
--- /dev/null
+++ b/src/openvpn/tun_afunix.h
@@ -0,0 +1,72 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2002-2024 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifndef AFUNIX_TUN_H
+#define AFUNIX_TUN_H
+#include <sys/types.h>
+
+#include "tun.h"
+
+/**
+ * Opens an AF_UNIX based tun device. This also executes the command that
+ * the user provided taking care of implementing the actual tun
+ * device.
+ */
+void
+open_tun_afunix(struct options *o,
+                int mtu,
+                struct tuntap *tt,
+                struct env_set *env);
+
+
+/**
+ * Closes the socket used for the AF_UNIX based device. Also sends a
+ * SIGINT to the child process that was spawned to handle the tun device
+ */
+void
+close_tun_afunix(struct tuntap *tt);
+
+/**
+ * Writes a packet to a AF_UNIX based tun device.
+ */
+ssize_t
+write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len);
+
+/**
+ * Reads a packet from a AF_UNIX based tun device.
+ */
+ssize_t
+read_tun_afunix(struct tuntap *tt, uint8_t *buf, int len);
+
+#endif /* AFUNIX_TUN_H */
+
+/**
+ * Checks whether a --dev-node parameter specifies a AF_UNIX device
+ * @param devnode   the string to check
+ * @return          true if the string starts with unix:
+ */
+static inline bool
+is_tun_afunix(const char *devnode)
+{
+    return devnode && strprefix(devnode, "unix:");
+}

