From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 17 Sep 2024 15:46:17 +0000
In-Reply-To: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
References: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <adc9642752403652b5b549ddf8a68c6d452a332b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ytBEappxrrc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Introduce
 DRIVER_AFUNIX backend for use with lwipovpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ytBEappxrrc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail

to look at the new patch set (#6).


Change subject: Introduce DRIVER_AFUNIX backend for use with lwipovpn
......................................................................

Introduce DRIVER_AFUNIX backend for use with lwipovpn

lwipovpn is a using lwip TCP/IP implementation with an AF_UNIX
implementation to emulate a tun/tap device without messing with the
TCP/IP stack of the host.

For more information about lwipovpn see https://github.com/OpenVPN/lwipovpn

Change-Id: I65099ef00822d08fd3f5480c80892f3bf86c56e7
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M Changes.rst
M doc/man-sections/vpn-network-options.rst
M src/openvpn/Makefile.am
M src/openvpn/forward.c
M src/openvpn/init.c
M src/openvpn/run_command.c
M src/openvpn/run_command.h
M src/openvpn/tun.c
M src/openvpn/tun.h
A src/openvpn/tun_afunix.c
A src/openvpn/tun_afunix.h
12 files changed, 390 insertions(+), 16 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/747/6

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
     the user experience as the client shows an error instead of running in=
to
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
+    For more details see [lwipovpn on Gihtub](https://github.com/OpenVPN/l=
wipovpn).
+
 Deprecated features
 -------------------
 ``secret`` support has been removed by default.
diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sections/vp=
n-network-options.rst
index 84d4273..fc76939 100644
--- a/doc/man-sections/vpn-network-options.rst
+++ b/doc/man-sections/vpn-network-options.rst
@@ -117,6 +117,16 @@
   figure out whether ``node`` is a TUN or TAP device based on the name,
   you should also specify ``--dev-type tun`` or ``--dev-type tap``.

+  If ``node`` starts with the string ``unix:`` openvpn will treat the rest
+  of the argument as a program.
+  OpenVPN will start the program and create a temporary unix domain socket=
 that
+  will be passed to the program together with the tun configuration as
+  environment variables.  The temporary unix domain socket  will be be pas=
sed
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
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7b23131..9c78adf 100644
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
-    c->c2.buf.len =3D read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame=
.buf.payload_size);
+    if (c->c1.tuntap->backend_driver =3D=3D DRIVER_AFUNIX)
+    {
+        c->c2.buf.len =3D tun_afunix_read(c->c1.tuntap, BPTR(&c->c2.buf), =
c->c2.frame.buf.payload_size);
+    }
+    else
+    {
+        c->c2.buf.len =3D read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.f=
rame.buf.payload_size);
+    }
 #endif /* ifdef _WIN32 */

 #ifdef PACKET_TRUNCATION_CHECK
@@ -1926,7 +1934,14 @@
 #ifdef _WIN32
         size =3D write_tun_buffered(c->c1.tuntap, &c->c2.to_tun);
 #else
-        size =3D write_tun(c->c1.tuntap, BPTR(&c->c2.to_tun), BLEN(&c->c2.=
to_tun));
+        if (c->c1.tuntap->backend_driver =3D=3D DRIVER_AFUNIX)
+        {
+            size =3D tun_afunix_write(c->c1.tuntap, BPTR(&c->c2.to_tun), B=
LEN(&c->c2.to_tun));
+        }
+        else
+        {
+            size =3D write_tun(c->c1.tuntap, BPTR(&c->c2.to_tun), BLEN(&c-=
>c2.to_tun));
+        }
 #endif

         if (size > 0)
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 83cc670..b516608 100644
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
+        c->c1.tuntap->backend_driver =3D DRIVER_AFUNIX;
+    }
 #ifdef _WIN32
-    c->c1.tuntap->backend_driver =3D c->options.windows_driver;
+    else
+    {
+        c->c1.tuntap->backend_driver =3D c->options.windows_driver;
+    }
 #else
-    if (dco_enabled(&c->options))
+    else if (dco_enabled(&c->options))
     {
         c->c1.tuntap->backend_driver =3D DRIVER_DCO;
     }
@@ -1786,6 +1795,10 @@
 static bool
 can_preserve_tun(struct tuntap *tt)
 {
+    if (tt && tt->backend_driver =3D=3D DRIVER_AFUNIX)
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
+    struct tuntap *tt =3D c->c1.tuntap;
+    if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
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
-            && ifconfig_order() =3D=3D IFCONFIG_BEFORE_TUN_OPEN)
+            && ifconfig_order(c->c1.tuntap) =3D=3D IFCONFIG_BEFORE_TUN_OPE=
N)
         {
             /* guess actual tun/tap unit number that will be returned
              * by open_tun */
@@ -1911,7 +1941,7 @@
         }

         /* possibly add routes */
-        if (route_order() =3D=3D ROUTE_BEFORE_TUN)
+        if (route_order(c->c1.tuntap) =3D=3D ROUTE_BEFORE_TUN)
         {
             /* Ignore route_delay, would cause ROUTE_BEFORE_TUN to be igno=
red */
             bool status =3D do_route(&c->options, c->c1.route_list, c->c1.=
route_ipv6_list,
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
-            && ifconfig_order() =3D=3D IFCONFIG_AFTER_TUN_OPEN)
+            && ifconfig_order(c->c1.tuntap) =3D=3D IFCONFIG_AFTER_TUN_OPEN)
         {
             do_ifconfig(c->c1.tuntap, c->c1.tuntap->actual_name,
                         c->c2.frame.tun_mtu, c->c2.es, &c->net_ctx);
@@ -1966,7 +1995,7 @@
         add_wfp_block(c);

         /* possibly add routes */
-        if ((route_order() =3D=3D ROUTE_AFTER_TUN) && (!c->options.route_d=
elay_defined))
+        if ((route_order(c->c1.tuntap) =3D=3D ROUTE_AFTER_TUN) && (!c->opt=
ions.route_delay_defined))
         {
             int status =3D do_route(&c->options, c->c1.route_list, c->c1.r=
oute_ipv6_list,
                                   c->c1.tuntap, c->plugins, c->c2.es, &c->=
net_ctx);
@@ -2026,7 +2055,14 @@
         {
             undo_ifconfig(c->c1.tuntap, &c->net_ctx);
         }
-        close_tun(c->c1.tuntap, &c->net_ctx);
+        if (c->c1.tuntap->backend_driver =3D=3D DRIVER_AFUNIX)
+        {
+            tun_afunix_close(c->c1.tuntap);
+        }
+        else
+        {
+            close_tun(c->c1.tuntap, &c->net_ctx);
+        }
         c->c1.tuntap =3D NULL;
     }
     c->c1.tuntap_owned =3D false;
@@ -2466,7 +2502,7 @@
             c->c1.pulled_options_digest_save =3D c->c2.pulled_options_dige=
st;

             /* if --route-delay was specified, start timer */
-            if ((route_order() =3D=3D ROUTE_AFTER_TUN) && c->options.route=
_delay_defined)
+            if ((route_order(c->c1.tuntap) =3D=3D ROUTE_AFTER_TUN) && c->o=
ptions.route_delay_defined)
             {
                 event_timeout_init(&c->c2.route_wakeup, c->options.route_d=
elay, now);
                 event_timeout_init(&c->c2.route_wakeup_expire, c->options.=
route_delay + c->options.route_delay_window, now);
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
+                ret =3D pid;
+            }
             else /* parent side */
             {
                 if (waitpid(pid, &ret, 0) !=3D pid)
@@ -204,6 +208,11 @@
             goto done;
         }
     }
+    else if (flags & S_NOWAITPID && (stat > 0))
+    {
+        ret =3D stat;
+        goto done;
+    }
     else if (platform_system_ok(stat))
     {
         ret =3D true;
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index ccad307..c1ee25e 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -47,6 +47,9 @@
 /** Instead of returning 1/0 for success/fail,
  * return exit code when between 0 and 255 and -1 otherwise */
 #define S_EXITCODE  (1<<2)
+/** instead of waiting for child process to exit and report the status,
+ * return the pid of the child process */
+#define S_NOWAITPID   (1<<3)

 /* wrapper around the execve() call */
 int openvpn_popen(const struct argv *a,  const struct env_set *es);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index aee59a6..5032f18 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -75,6 +75,9 @@
         case DRIVER_DCO:
             return "ovpn-dco";

+        case DRIVER_AFUNIX:
+            return "unix";
+
 #ifdef HAVE_NET_IF_UTUN_H
         case DRIVER_UTUN:
             return "utun";
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index e41b616..2f7bd4a 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -50,6 +50,10 @@
 #else
     DRIVER_GENERIC_TUNTAP,
 #endif
+    /** using an AF_UNIX socket to pass packets from/to an external progra=
m.
+     *  This is always defined. We error out if a user tries to open this =
type
+     *  of backend on unsupported platforms. */
+    DRIVER_AFUNIX,
     DRIVER_DCO,
 #ifdef HAVE_NET_IF_UTUN_H
     DRIVER_UTUN
@@ -165,6 +169,17 @@
 /*
  * Define a TUN/TAP dev.
  */
+#if defined(AF_UNIX) && !defined(WIN32)
+typedef struct afunix_context
+{
+    pid_t childprocess;
+} afunix_context_t;
+
+#else /* if defined(AF_UNIX) && !defined(WIN32) */
+typedef struct {
+    int dummy;
+} afunix_context_t;
+#endif

 struct tuntap
 {
@@ -179,7 +194,12 @@
      */
     enum tun_driver_type backend_driver;

+    /** if the internal variables related to ifconfig of this struct have
+     * been set up. This does NOT mean ifconfig has been called */
     bool did_ifconfig_setup;
+
+    /** if the internal variables related to ifconfig-ipv6 of this struct =
have
+     * been set up. This does NOT mean ifconfig has been called */
     bool did_ifconfig_ipv6_setup;

     bool persistent_if;         /* if existed before, keep on program end =
*/
@@ -231,6 +251,7 @@
     unsigned int rwflags_debug;

     dco_context_t dco;
+    afunix_context_t afunix;
 };

 static inline bool
@@ -354,8 +375,14 @@
 #define IFCONFIG_DEFAULT         IFCONFIG_AFTER_TUN_OPEN

 static inline int
-ifconfig_order(void)
+ifconfig_order(struct tuntap *tt)
 {
+#if defined AF_UNIX
+    if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
+    {
+        return IFCONFIG_BEFORE_TUN_OPEN;
+    }
+#endif
 #if defined(TARGET_LINUX)
     return IFCONFIG_AFTER_TUN_OPEN;
 #elif defined(TARGET_SOLARIS)
@@ -380,8 +407,14 @@
 #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN

 static inline int
-route_order(void)
+route_order(struct tuntap *tt)
 {
+#if defined AF_UNIX
+    if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
+    {
+        return ROUTE_BEFORE_TUN;
+    }
+#endif
 #if defined(TARGET_ANDROID)
     return ROUTE_BEFORE_TUN;
 #else
@@ -759,5 +792,4 @@
 {
     return tt && tt->type !=3D DEV_TYPE_UNDEF;
 }
-
 #endif /* TUN_H */
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
new file mode 100644
index 0000000..27cdb01
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
+#if defined(AF_UNIX) && !defined(WIN32)
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
+tun_afunix_exec_child(const char *dev_node, struct tuntap *tt, struct env_=
set *env)
+{
+    struct argv argv =3D argv_new();
+
+    /* since we know that dev-node starts with unix: we can just skip that
+     * to get the program name */
+    const char *program =3D dev_node + strlen("unix:");
+
+    argv_printf(&argv, "%s", program);
+
+    argv_msg(M_INFO, &argv);
+    tt->afunix.childprocess =3D openvpn_execve_check(&argv, env, S_NOWAITP=
ID,
+                                                   "ERROR: failure executi=
ng "
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
+    struct gc_arena gc =3D gc_new();
+
+    int fds[2];
+    if (!(socketpair(AF_UNIX, SOCK_DGRAM, 0, fds) =3D=3D 0))
+    {
+        msg(M_ERR, "Cannot create socket pair for AF_UNIX socket to extern=
al "
+            "program");
+        return;
+    }
+
+    /* Use the first file descriptor for our side and avoid passing it
+     * to the child */
+    tt->fd =3D fds[1];
+    set_cloexec(tt->fd);
+
+    /* Make a copy of the env, so we do not need to delete our custom
+     * environment variables later */
+    struct env_set *env =3D env_set_create(&gc);
+    env_set_inherit(env, orig_env);
+
+    setenv_int(env, "TUNTAP_SOCKET_FD", fds[0]);
+    setenv_str(env, "TUNTAP_DEV_TYPE", dev_type_string(o->dev, o->dev_type=
));
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
+    /* tt->actual_name is passed to up and down scripts and used as the if=
config dev name */
+    tt->actual_name =3D string_alloc("internal:af_unix", NULL);
+
+    gc_free(&gc);
+}
+
+void
+tun_afunix_close(struct tuntap *tt)
+{
+    ASSERT(tt);
+    if (tt->fd >=3D 0)
+    {
+        close(tt->fd);
+        tt->fd =3D 0;
+    }
+    kill(tt->afunix.childprocess, SIGINT);
+
+    free(tt->actual_name);
+    free(tt);
+}
+
+ssize_t
+tun_afunix_write(struct tuntap *tt, uint8_t *buf, int len)
+{
+    int ret;
+    pid_t pidret =3D waitpid(tt->afunix.childprocess, &ret, WNOHANG);
+    if (pidret =3D=3D tt->afunix.childprocess)
+    {
+        msg(M_INFO, "Child process PID %d for afunix dead? Return code: %d=
",
+            tt->afunix.childprocess, ret);
+        return -ENXIO;
+    }
+    return write(tt->fd, buf, len);
+}
+
+ssize_t
+tun_afunix_read(struct tuntap *tt, uint8_t *buf, int len)
+{
+    return read(tt->fd, buf, len);
+}
+#else  /* ifdef AF_UNIX */
+void
+open_tun_afunix(const char *dev, const char *dev_type, int mtu,
+                struct tuntap *tt, struct env_set env)
+{
+    msg(M_ERR, "AF_UNIX socket support not available on this platform");
+}
+
+void
+tun_afunix_close(struct tuntap *tt)
+{
+    /* should never be called as open_tun_afunix always fails */
+    ASSERT(0);
+}
+
+ssize_t
+tun_afunix_write(struct tuntap *tt, uint8_t *buf, int len)
+{
+    /* should never be called as open_tun_afunix always fails */
+    ASSERT(0);
+}
+
+ssize_t
+tun_afunix_read(struct tuntap *tt, uint8_t *buf, int len)
+{
+    /* should never be called as open_tun_afunix always fails */
+    ASSERT(0);
+}
+
+#endif /* ifdef AF_UNIX */
diff --git a/src/openvpn/tun_afunix.h b/src/openvpn/tun_afunix.h
new file mode 100644
index 0000000..f7d0407
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
+tun_afunix_close(struct tuntap *tt);
+
+/**
+ * Writes a packet to a AF_UNIX based tun device.
+ */
+ssize_t
+tun_afunix_write(struct tuntap *tt, uint8_t *buf, int len);
+
+/**
+ * Reads a packet from a AF_UNIX based tun device.
+ */
+ssize_t
+tun_afunix_read(struct tuntap *tt, uint8_t *buf, int len);
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65099ef00822d08fd3f5480c80892f3bf86c56e7
Gerrit-Change-Number: 747
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--ytBEappxrrc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #6</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Introduce DRIVER_AFUNIX backend for use with lwipovpn<br><br>lwipovpn=
 is a using lwip TCP/IP implementation with an AF_UNIX<br>implementation to=
 emulate a tun/tap device without messing with the<br>TCP/IP stack of the h=
ost.<br><br>For more information about lwipovpn see https://github.com/Open=
VPN/lwipovpn<br><br>Change-Id: I65099ef00822d08fd3f5480c80892f3bf86c56e7<br=
>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M CMakeLists=
.txt<br>M Changes.rst<br>M doc/man-sections/vpn-network-options.rst<br>M sr=
c/openvpn/Makefile.am<br>M src/openvpn/forward.c<br>M src/openvpn/init.c<br=
>M src/openvpn/run_command.c<br>M src/openvpn/run_command.h<br>M src/openvp=
n/tun.c<br>M src/openvpn/tun.h<br>A src/openvpn/tun_afunix.c<br>A src/openv=
pn/tun_afunix.h<br>12 files changed, 390 insertions(+), 16 deletions(-)<br>=
<br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/747/=
6</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>inde=
x ad620fa..6271574 100644</span><br><span>--- a/CMakeLists.txt</span><br><s=
pan>+++ b/CMakeLists.txt</span><br><span>@@ -536,6 +536,8 @@</span><br><spa=
n>     src/openvpn/tls_crypt.c</span><br><span>     src/openvpn/tun.c</span=
><br><span>     src/openvpn/tun.h</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    src/openvpn/tun_afunix.c</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    src/openvpn/tun_afunix.h</span><br><span>     sr=
c/openvpn/networking_sitnl.c</span><br><span>     src/openvpn/networking_fr=
eebsd.c</span><br><span>     src/openvpn/auth_token.c</span><br><span>diff =
--git a/Changes.rst b/Changes.rst</span><br><span>index 439352a..7d19577 10=
0644</span><br><span>--- a/Changes.rst</span><br><span>+++ b/Changes.rst</s=
pan><br><span>@@ -9,6 +9,19 @@</span><br><span>     the user experience as =
the client shows an error instead of running into</span><br><span>     a ti=
meout when the server just stops responding completely.</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+Support for tun/tap v=
ia unix domain socket and lwipovpn support</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    To allow better testing and emulating a full cli=
ent with a full</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
network stack OpenVPN now allows a program executed to provide</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    a tun/tap device instead of =
opening a device.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    The co-developed =
lwipovpn program based on lwIP stack allows to</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    simulate full IP stack and an OpenVPN client=
 using</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ``--dev-n=
ode unix:/path/to/lwipovpn`` can emulate a full client that</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    can be pinged, can serve a webs=
ite and more without requiring any</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    elevated permission. This can make testing OpenVPN much =
easier.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    For more details see [lwipo=
vpn on Gihtub](https://github.com/OpenVPN/lwipovpn).</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> Deprecated features</sp=
an><br><span> -------------------</span><br><span> ``secret`` support has b=
een removed by default.</span><br><span>diff --git a/doc/man-sections/vpn-n=
etwork-options.rst b/doc/man-sections/vpn-network-options.rst</span><br><sp=
an>index 84d4273..fc76939 100644</span><br><span>--- a/doc/man-sections/vpn=
-network-options.rst</span><br><span>+++ b/doc/man-sections/vpn-network-opt=
ions.rst</span><br><span>@@ -117,6 +117,16 @@</span><br><span>   figure out=
 whether ``node`` is a TUN or TAP device based on the name,</span><br><span=
>   you should also specify ``--dev-type tun`` or ``--dev-type tap``.</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  If ``=
node`` starts with the string ``unix:`` openvpn will treat the rest</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+  of the argument as a prog=
ram.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  OpenVPN will =
start the program and create a temporary unix domain socket that</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  will be passed to the progra=
m together with the tun configuration as</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  environment variables.  The temporary unix domain so=
cket  will be be passed</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+  in the environment variable :code:`TUNTAP_SOCKET_FD`.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+  This ``unix:`` mode is designed mainly to use with t=
he lwipovpn network</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
  emulator (https://github.com/OpenVPN/lwipovpn).</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span> --dev-type device-type</spa=
n><br><span>   Which device type are we using? ``device-type`` should be :c=
ode:`tun`</span><br><span>   (OSI Layer 3) or :code:`tap` (OSI Layer 2). Us=
e this option only if</span><br><span>diff --git a/src/openvpn/Makefile.am =
b/src/openvpn/Makefile.am</span><br><span>index 3784a98..ecb2bcf 100644</sp=
an><br><span>--- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvp=
n/Makefile.am</span><br><span>@@ -140,6 +140,7 @@</span><br><span> 	syshead=
.h \</span><br><span> 	tls_crypt.c tls_crypt.h \</span><br><span> 	tun.c tu=
n.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	tun_afunix.c =
tun_afunix.h \</span><br><span> 	vlan.c vlan.h \</span><br><span> 	xkey_pro=
vider.c xkey_common.h \</span><br><span> 	xkey_helper.c \</span><br><span>d=
iff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>i=
ndex 7b23131..9c78adf 100644</span><br><span>--- a/src/openvpn/forward.c</s=
pan><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -41,6 +41,7 @@=
</span><br><span> #include &quot;ssl_verify.h&quot;</span><br><span> #inclu=
de &quot;dco.h&quot;</span><br><span> #include &quot;auth_token.h&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;tun_afun=
ix.h&quot;</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;=
</span><br><span> </span><br><span>@@ -1319,7 +1320,14 @@</span><br><span> =
#else  /* ifdef _WIN32 */</span><br><span>     ASSERT(buf_init(&amp;c-&gt;c=
2.buf, c-&gt;c2.frame.buf.headroom));</span><br><span>     ASSERT(buf_safe(=
&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.payload_size));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2.buf.len =3D read_tun(c-&gt;c1.=
tuntap, BPTR(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;c1.tuntap-&gt;=
backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        c-&gt;c2.buf.len =3D tun_afunix_read(c-&gt;c1.tuntap, BPTR(&amp;=
c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-=
&gt;c2.buf.len =3D read_tun(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf), c-&gt=
;c2.frame.buf.payload_size);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span> #endif /* ifdef _WIN32 */</span><br><span> =
</span><br><span> #ifdef PACKET_TRUNCATION_CHECK</span><br><span>@@ -1926,7=
 +1934,14 @@</span><br><span> #ifdef _WIN32</span><br><span>         size =
=3D write_tun_buffered(c-&gt;c1.tuntap, &amp;c-&gt;c2.to_tun);</span><br><s=
pan> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        siz=
e =3D write_tun(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&g=
t;c2.to_tun));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (c-&gt;c1.tuntap-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            size =3D tun_afunix_write(c-&=
gt;c1.tuntap, BPTR(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.to_tun));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            size =3D write_tun(c-&gt;c1.tuntap, BPT=
R(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.to_tun));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> #endif</span><=
br><span> </span><br><span>         if (size &gt; 0)</span><br><span>diff -=
-git a/src/openvpn/init.c b/src/openvpn/init.c</span><br><span>index 83cc67=
0..b516608 100644</span><br><span>--- a/src/openvpn/init.c</span><br><span>=
+++ b/src/openvpn/init.c</span><br><span>@@ -54,6 +54,7 @@</span><br><span>=
 #include &quot;mss.h&quot;</span><br><span> #include &quot;mudp.h&quot;</s=
pan><br><span> #include &quot;dco.h&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;tun_afunix.h&quot;</span><br><span> </=
span><br><span> #include &quot;memdbg.h&quot;</span><br><span> </span><br><=
span>@@ -1758,10 +1759,18 @@</span><br><span>                             &=
amp;c-&gt;net_ctx,</span><br><span>                             c-&gt;c1.tu=
ntap);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (is_tun_afunix(c-&gt;options.dev_node))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* Using AF_UNIX trumps using DCO */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c1.tuntap-&gt;ba=
ckend_driver =3D DRIVER_AFUNIX;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span> #ifdef _WIN32</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    c-&gt;c1.tuntap-&gt;backend_driver =3D c-&gt=
;options.windows_driver;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c-&gt;c1.tun=
tap-&gt;backend_driver =3D c-&gt;options.windows_driver;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (dco_enabled(&amp;c-&gt;=
options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else i=
f (dco_enabled(&amp;c-&gt;options))</span><br><span>     {</span><br><span>=
         c-&gt;c1.tuntap-&gt;backend_driver =3D DRIVER_DCO;</span><br><span=
>     }</span><br><span>@@ -1786,6 +1795,10 @@</span><br><span> static bool=
</span><br><span> can_preserve_tun(struct tuntap *tt)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt &amp;&amp; =
tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span> #ifdef TARGET_ANDROID</span><br><span>  =
   return false;</span><br><span> #else</span><br><span>@@ -1841,6 +1854,22=
 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+open_tun_backend(struct context *c)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct tuntap *tt =3D c-&gt;c1.tunta=
p;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;ba=
ckend_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        open_tun_afunix(&amp;c-&gt;options, c-&gt;c2.frame.tun_mtu, tt, c-=
&gt;c2.es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        open_tun(c-&gt;options.dev, c-&gt;optio=
ns.dev_type, c-&gt;options.dev_node,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                 tt, &amp;c-&gt;net_ctx);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> static bool</span><br><span> do_open_tun(struct context *c, int *erro=
r_flags)</span><br><span> {</span><br><span>@@ -1863,7 +1892,8 @@</span><br=
><span>         }</span><br><span> #endif</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        /* initialize (but do not ope=
n) tun/tap object */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* initialize (but do not open) tun/tap object, this also sets</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+         * the backend =
driver type */</span><br><span>         do_init_tun(c);</span><br><span> </=
span><br><span>         /* inherit the dco context from the tuntap object *=
/</span><br><span>@@ -1898,7 +1928,7 @@</span><br><span> </span><br><span> =
        /* do ifconfig */</span><br><span>         if (!c-&gt;options.ifcon=
fig_noexec</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 &amp;&amp; ifconfig_order() =3D=3D IFCONFIG_BEFORE_TUN_OPEN)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; ifconfig_o=
rder(c-&gt;c1.tuntap) =3D=3D IFCONFIG_BEFORE_TUN_OPEN)</span><br><span>    =
     {</span><br><span>             /* guess actual tun/tap unit number tha=
t will be returned</span><br><span>              * by open_tun */</span><br=
><span>@@ -1911,7 +1941,7 @@</span><br><span>         }</span><br><span> </=
span><br><span>         /* possibly add routes */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        if (route_order() =3D=3D ROUTE_BEFORE_T=
UN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (rout=
e_order(c-&gt;c1.tuntap) =3D=3D ROUTE_BEFORE_TUN)</span><br><span>         =
{</span><br><span>             /* Ignore route_delay, would cause ROUTE_BEF=
ORE_TUN to be ignored */</span><br><span>             bool status =3D do_ro=
ute(&amp;c-&gt;options, c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,</spa=
n><br><span>@@ -1928,8 +1958,7 @@</span><br><span>         }</span><br><spa=
n> </span><br><span>         /* open the tun device */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        open_tun(c-&gt;options.dev, c-&gt;=
options.dev_type, c-&gt;options.dev_node,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                 c-&gt;c1.tuntap, &amp;c-&gt;net_ctx);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        open_tun_bac=
kend(c);</span><br><span> </span><br><span>         /* set the hardware add=
ress */</span><br><span>         if (c-&gt;options.lladdr)</span><br><span>=
@@ -1940,7 +1969,7 @@</span><br><span> </span><br><span>         /* do ifco=
nfig */</span><br><span>         if (!c-&gt;options.ifconfig_noexec</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; ifconf=
ig_order() =3D=3D IFCONFIG_AFTER_TUN_OPEN)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            &amp;&amp; ifconfig_order(c-&gt;c1.tunta=
p) =3D=3D IFCONFIG_AFTER_TUN_OPEN)</span><br><span>         {</span><br><sp=
an>             do_ifconfig(c-&gt;c1.tuntap, c-&gt;c1.tuntap-&gt;actual_nam=
e,</span><br><span>                         c-&gt;c2.frame.tun_mtu, c-&gt;c=
2.es, &amp;c-&gt;net_ctx);</span><br><span>@@ -1966,7 +1995,7 @@</span><br>=
<span>         add_wfp_block(c);</span><br><span> </span><br><span>        =
 /* possibly add routes */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if ((route_order() =3D=3D ROUTE_AFTER_TUN) &amp;&amp; (!c-&gt;=
options.route_delay_defined))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if ((route_order(c-&gt;c1.tuntap) =3D=3D ROUTE_AFTER_TUN)=
 &amp;&amp; (!c-&gt;options.route_delay_defined))</span><br><span>         =
{</span><br><span>             int status =3D do_route(&amp;c-&gt;options, =
c-&gt;c1.route_list, c-&gt;c1.route_ipv6_list,</span><br><span>            =
                       c-&gt;c1.tuntap, c-&gt;plugins, c-&gt;c2.es, &amp;c-=
&gt;net_ctx);</span><br><span>@@ -2026,7 +2055,14 @@</span><br><span>      =
   {</span><br><span>             undo_ifconfig(c-&gt;c1.tuntap, &amp;c-&gt=
;net_ctx);</span><br><span>         }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        close_tun(c-&gt;c1.tuntap, &amp;c-&gt;net_ctx);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;c1.tu=
ntap-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            tun_afunix_close(c-&gt;c1.tuntap);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            close_tun(c-&gt;c1.tuntap, &amp;c-&gt;net_ctx)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span>         c-&gt;c1.tuntap =3D NULL;</span><br><span>     }</span><br=
><span>     c-&gt;c1.tuntap_owned =3D false;</span><br><span>@@ -2466,7 +25=
02,7 @@</span><br><span>             c-&gt;c1.pulled_options_digest_save =
=3D c-&gt;c2.pulled_options_digest;</span><br><span> </span><br><span>     =
        /* if --route-delay was specified, start timer */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if ((route_order() =3D=3D R=
OUTE_AFTER_TUN) &amp;&amp; c-&gt;options.route_delay_defined)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if ((route_order(c-&g=
t;c1.tuntap) =3D=3D ROUTE_AFTER_TUN) &amp;&amp; c-&gt;options.route_delay_d=
efined)</span><br><span>             {</span><br><span>                 eve=
nt_timeout_init(&amp;c-&gt;c2.route_wakeup, c-&gt;options.route_delay, now)=
;</span><br><span>                 event_timeout_init(&amp;c-&gt;c2.route_w=
akeup_expire, c-&gt;options.route_delay + c-&gt;options.route_delay_window,=
 now);</span><br><span>diff --git a/src/openvpn/run_command.c b/src/openvpn=
/run_command.c</span><br><span>index 292e81f..d757823 100644</span><br><spa=
n>--- a/src/openvpn/run_command.c</span><br><span>+++ b/src/openvpn/run_com=
mand.c</span><br><span>@@ -155,6 +155,10 @@</span><br><span>             {<=
/span><br><span>                 msg(M_ERR, &quot;openvpn_execve: unable to=
 fork&quot;);</span><br><span>             }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            else if (flags &amp; S_NOWAITPID)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                ret =3D pid;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><=
br><span>             else /* parent side */</span><br><span>             {=
</span><br><span>                 if (waitpid(pid, &amp;ret, 0) !=3D pid)</=
span><br><span>@@ -204,6 +208,11 @@</span><br><span>             goto done;=
</span><br><span>         }</span><br><span>     }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    else if (flags &amp; S_NOWAITPID &amp;&a=
mp; (stat &gt; 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ret =3D=
 stat;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
done;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span>     else if (platform_system_ok(stat))</span><br><span>     {</spa=
n><br><span>         ret =3D true;</span><br><span>diff --git a/src/openvpn=
/run_command.h b/src/openvpn/run_command.h</span><br><span>index ccad307..c=
1ee25e 100644</span><br><span>--- a/src/openvpn/run_command.h</span><br><sp=
an>+++ b/src/openvpn/run_command.h</span><br><span>@@ -47,6 +47,9 @@</span>=
<br><span> /** Instead of returning 1/0 for success/fail,</span><br><span> =
 * return exit code when between 0 and 255 and -1 otherwise */</span><br><s=
pan> #define S_EXITCODE  (1&lt;&lt;2)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/** instead of waiting for child process to exit and repo=
rt the status,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * re=
turn the pid of the child process */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#define S_NOWAITPID   (1&lt;&lt;3)</span><br><span> </span=
><br><span> /* wrapper around the execve() call */</span><br><span> int ope=
nvpn_popen(const struct argv *a,  const struct env_set *es);</span><br><spa=
n>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index =
aee59a6..5032f18 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><=
span>+++ b/src/openvpn/tun.c</span><br><span>@@ -75,6 +75,9 @@</span><br><s=
pan>         case DRIVER_DCO:</span><br><span>             return &quot;ovp=
n-dco&quot;;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        case DRIVER_AFUNIX:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            return &quot;unix&quot;;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef HAVE_NET_IF_UT=
UN_H</span><br><span>         case DRIVER_UTUN:</span><br><span>           =
  return &quot;utun&quot;;</span><br><span>diff --git a/src/openvpn/tun.h b=
/src/openvpn/tun.h</span><br><span>index e41b616..2f7bd4a 100644</span><br>=
<span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span=
><br><span>@@ -50,6 +50,10 @@</span><br><span> #else</span><br><span>     D=
RIVER_GENERIC_TUNTAP,</span><br><span> #endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /** using an AF_UNIX socket to pass packets f=
rom/to an external program.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     *  This is always defined. We error out if a user tries to ope=
n this type</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  =
of backend on unsupported platforms. */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    DRIVER_AFUNIX,</span><br><span>     DRIVER_DCO,</sp=
an><br><span> #ifdef HAVE_NET_IF_UTUN_H</span><br><span>     DRIVER_UTUN</s=
pan><br><span>@@ -165,6 +169,17 @@</span><br><span> /*</span><br><span>  * =
Define a TUN/TAP dev.</span><br><span>  */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#if defined(AF_UNIX) &amp;&amp; !defined(WIN32)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct afunix_co=
ntext</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    pid_t childprocess;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+} afunix_context_t;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#else /* if defined(AF_UNIX) &amp;&amp; !define=
d(WIN32) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef =
struct {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int dum=
my;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+} afunix_context=
_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br=
><span> </span><br><span> struct tuntap</span><br><span> {</span><br><span>=
@@ -179,7 +194,12 @@</span><br><span>      */</span><br><span>     enum tun=
_driver_type backend_driver;</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /** if the internal variables related to ifc=
onfig of this struct have</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+     * been set up. This does NOT mean ifconfig has been called */</s=
pan><br><span>     bool did_ifconfig_setup;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /** if the internal variables related to ifconfig-ipv6 of this str=
uct have</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * been=
 set up. This does NOT mean ifconfig has been called */</span><br><span>   =
  bool did_ifconfig_ipv6_setup;</span><br><span> </span><br><span>     bool=
 persistent_if;         /* if existed before, keep on program end */</span>=
<br><span>@@ -231,6 +251,7 @@</span><br><span>     unsigned int rwflags_deb=
ug;</span><br><span> </span><br><span>     dco_context_t dco;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    afunix_context_t afunix;</spa=
n><br><span> };</span><br><span> </span><br><span> static inline bool</span=
><br><span>@@ -354,8 +375,14 @@</span><br><span> #define IFCONFIG_DEFAULT  =
       IFCONFIG_AFTER_TUN_OPEN</span><br><span> </span><br><span> static in=
line int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_orde=
r(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_ord=
er(struct tuntap *tt)</span><br><span> {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined AF_UNIX</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return IFCONFIG_BEFORE_TUN_O=
PEN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> #if d=
efined(TARGET_LINUX)</span><br><span>     return IFCONFIG_AFTER_TUN_OPEN;</=
span><br><span> #elif defined(TARGET_SOLARIS)</span><br><span>@@ -380,8 +40=
7,14 @@</span><br><span> #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TUN</span>=
<br><span> </span><br><span> static inline int</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-route_order(void)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+route_order(struct tuntap *tt)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined AF_UNIX</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;backend=
_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    return ROUTE_BEFORE_TUN;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span> #if defined(TARGET_ANDROID)</span><br><span>     return =
ROUTE_BEFORE_TUN;</span><br><span> #else</span><br><span>@@ -759,5 +792,4 @=
@</span><br><span> {</span><br><span>     return tt &amp;&amp; tt-&gt;type =
!=3D DEV_TYPE_UNDEF;</span><br><span> }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> #endif /* TUN_H */</span><br><span>diff=
 --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c</span><br><spa=
n>new file mode 100644</span><br><span>index 0000000..27cdb01</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/src/openvpn/tun_afunix.c</span><br><=
span>@@ -0,0 +1,178 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN --=
 An application to securely tunnel IP networks</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             over a single TCP/UDP port, with =
support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *             session authentication and key exchange,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryption,=
 packet authentication, and</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet compression.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  Copyright (C) 2002-2024 OpenVPN Inc &lt;sales@...515...&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License versio=
n 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published=
 by the Free Software Foundation.</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 This program is distributed in the hope that it will be useful,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; =
without even the implied warranty of</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  =
See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gene=
ral Public License for more details.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  You should have received a copy of the GNU General Public License along=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this progr=
am; if not, write to the Free Software Foundation, Inc.,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, B=
oston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &quot;tun.h&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#include &quot;fdmisc.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &quot;run_command.h&quot;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;manage.h&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;w=
in32.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;wfp_block.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;argv.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+#include &quot;options.h&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#if defined(AF_UNIX) &amp;&amp; !defined(WIN32)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* Windows does implement some AF_UNIX fu=
nctionality but key features</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * like socketpair() and SOCK_DGRAM are missing */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;unistd.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;sys/wait.h&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &lt;signal.h&gt;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+tun_afunix_exec_child(const char *dev_node, stru=
ct tuntap *tt, struct env_set *env)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct argv argv =3D argv_new();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* since we know that dev-node starts with unix: we can just skip that</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to get the progra=
m name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *program =3D dev_node + strlen(&quot;unix:&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    argv_printf(&amp;argv, &quot;%s&quot;, program);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    argv_msg(M_INFO, &amp;argv);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;afunix.childprocess =
=3D openvpn_execve_check(&amp;argv, env, S_NOWAITPID,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                         =
          &quot;ERROR: failure executing &quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                               =
    &quot;process for tun&quot;);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    argv_free(&amp;argv);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+open_tun_afunix(struct options *=
o,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                i=
nt mtu,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    struct tuntap *tt,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                struct env_set *orig_env)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    int fds[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!(socketpair(AF_UNIX, SOCK_DGRAM, 0, fds) =3D=3D 0))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        msg(M_ERR, &quot;Cannot create socket p=
air for AF_UNIX socket to external &quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            &quot;program&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* Use the first file descriptor for our side and avoid passing it</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * to the child */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;fd =3D fd=
s[1];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_cloexe=
c(tt-&gt;fd);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Make a copy of the=
 env, so we do not need to delete our custom</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     * environment variables later */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct env_set *env =3D env_=
set_create(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    env_set_inherit(env, orig_env);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  setenv_int(env, &quot;TUNTAP_SOCKET_FD&quot;, fds[0]);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    setenv_str(env, &quot;TUNTAP_DEV_T=
YPE&quot;, dev_type_string(o-&gt;dev, o-&gt;dev_type));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    setenv_int(env, &quot;TUNTAP_MTU&qu=
ot;, mtu);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o=
-&gt;route_default_gateway)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  setenv_str(env, &quot;ifconfig_gateway&quot;, o-&gt;route_default_gateway=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;lladdr)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        setenv_str(env, &quot;TUNTAP_LLAD=
DR&quot;, o-&gt;lladdr);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    tun_afunix_exec_child(o-=
&gt;dev_node, tt, env);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    close(fds[0=
]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* tt-&gt;actual_name is passed=
 to up and down scripts and used as the ifconfig dev name */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;actual_name =3D string_=
alloc(&quot;internal:af_unix&quot;, NULL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+tun_afunix_close(struct tuntap *tt)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ASSERT(tt);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (tt-&gt;fd &gt;=3D 0)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        close(tt-&gt;fd);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tt-&gt;fd =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    kill(tt-&gt;afunix.childprocess, SIGINT);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    free(tt-&gt;actual_name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free(tt);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_write(stru=
ct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    int ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pid=
_t pidret =3D waitpid(tt-&gt;afunix.childprocess, &amp;ret, WNOHANG);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (pidret =3D=3D tt-=
&gt;afunix.childprocess)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_INFO, &quot;Child process PID %d for afunix dead? Return code: %d&quot=
;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tt-&g=
t;afunix.childprocess, ret);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        return -ENXIO;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return write(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_read(struct tuntap *t=
t, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return r=
ead(tt-&gt;fd, buf, len);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if=
def AF_UNIX */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+open_tun_afunix(cons=
t char *dev, const char *dev_type, int mtu,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                struct tuntap *tt, struct env_set e=
nv)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    msg(M_ERR, &quot;AF_UNIX socke=
t support not available on this platform&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_close(struct=
 tuntap *tt)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* should never be ca=
lled as open_tun_afunix always fails */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ASSERT(0);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_write(struct tuntap *tt=
, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* should=
 never be called as open_tun_afunix always fails */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_read(stru=
ct tuntap *tt, uint8_t *buf, int len)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* should never be called as open_tun_afunix always fails */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif /* ifdef AF_UNIX */</span><br><span>diff --git a/src/openvpn/tun_=
afunix.h b/src/openvpn/tun_afunix.h</span><br><span>new file mode 100644</s=
pan><br><span>index 0000000..f7d0407</span><br><span>--- /dev/null</span><b=
r><span>+++ b/src/openvpn/tun_afunix.h</span><br><span>@@ -0,0 +1,72 @@</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securel=
y tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *             over a single TCP/UDP port, with support for SSL/TLS-based<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             sessi=
on authentication and key exchange,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *             packet encryption, packet authentication, an=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pac=
ket compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 20=
02-2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is free software; you can redistribute it and/or mo=
dify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under th=
e terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distribu=
ted in the hope that it will be useful,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied =
warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mo=
re details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to the =
Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#ifndef AFUNIX_TUN_H</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define AFUNIX_TUN_H</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;sys/types.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;tun.h&quot;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Opens an A=
F_UNIX based tun device. This also executes the command that</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * the user provided taking care o=
f implementing the actual tun</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * device.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+open_tun_afunix(struct options=
 *o,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 int mtu,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      struct tuntap *tt,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                struct env_set *env);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Closes the socket used for t=
he AF_UNIX based device. Also sends a</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * SIGINT to the child process that was spawned to handle=
 the tun device</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+tun_afunix_close(struct tuntap *tt)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Writes a packet to a AF_UNIX based tun device.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+tun_afunix_write(struct tuntap *tt, uint8_t *buf, i=
nt len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * Reads a packet from a AF_UNIX based tun dev=
ice.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+tun_afunix_read(struct tuntap *tt, uint8_=
t *buf, int len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* AFUNIX_TUN_=
H */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * Checks whether a --dev-node parameter specifies=
 a AF_UNIX device</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param devnode   the string to check</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @return          true if the string starts with unix:<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+static inline bool</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+is_tun_afunix(const char *devnode)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    return devnode &amp;&amp; strprefix(=
devnode, &quot;unix:&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">change 747</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/747?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65099ef00822d08fd3f5480c808=
92f3bf86c56e7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ytBEappxrrc=--

