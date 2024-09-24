From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 24 Sep 2024 08:26:28 +0000
In-Reply-To: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
References: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <0aa093116aacbfde6694dbd2fc88a99681b349eb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="puHcvlsa4Cc="; charset=UTF-8
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
To: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--puHcvlsa4Cc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail

to look at the new patch set (#11).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


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
M src/openvpn/dco.c
M src/openvpn/forward.c
M src/openvpn/init.c
M src/openvpn/run_command.c
M src/openvpn/run_command.h
M src/openvpn/tun.c
M src/openvpn/tun.h
A src/openvpn/tun_afunix.c
A src/openvpn/tun_afunix.h
13 files changed, 394 insertions(+), 16 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/47/747/11

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
+        msg(msglevel, "Note: afunix tun type selected, disabling data chan=
nel"
+            "offload");
+        return false;
+    }
+
     if (o->connection_list)
     {
         const struct connection_list *l =3D o->connection_list;
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
-    c->c2.buf.len =3D read_tun(c->c1.tuntap, BPTR(&c->c2.buf), c->c2.frame=
.buf.payload_size);
+    if (c->c1.tuntap->backend_driver =3D=3D DRIVER_AFUNIX)
+    {
+        c->c2.buf.len =3D read_tun_afunix(c->c1.tuntap, BPTR(&c->c2.buf), =
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
+            size =3D write_tun_afunix(c->c1.tuntap, BPTR(&c->c2.to_tun), B=
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
+            close_tun_afunix(c->c1.tuntap);
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
+    /** using an AF_UNIX socket to pass packets from/to an external progra=
m.
+     *  This is always defined. We error out if a user tries to open this =
type
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
+    /** if the internal variables related to ifconfig-ipv6 of this struct =
have
+     * been set up. This does NOT mean ifconfig has been called */
     bool did_ifconfig_ipv6_setup;

     bool persistent_if;         /* if existed before, keep on program end =
*/
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
+    if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
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
+    if (tt->backend_driver =3D=3D DRIVER_AFUNIX)
+    {
+        return ROUTE_BEFORE_TUN;
+    }
 #if defined(TARGET_ANDROID)
     return ROUTE_BEFORE_TUN;
 #else
@@ -755,5 +784,4 @@
 {
     return tt && tt->type !=3D DEV_TYPE_UNDEF;
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
+close_tun_afunix(struct tuntap *tt)
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
+write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len)
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65099ef00822d08fd3f5480c80892f3bf86c56e7
Gerrit-Change-Number: 747
Gerrit-PatchSet: 11
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--puHcvlsa4Cc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #11</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Introduce DRIVER_AFUNIX backend for use with lwipovp=
n<br><br>lwipovpn is a using lwip TCP/IP implementation with an AF_UNIX<br>=
implementation to emulate a tun/tap device without messing with the<br>TCP/=
IP stack of the host.<br><br>For more information about lwipovpn see https:=
//github.com/OpenVPN/lwipovpn<br><br>Change-Id: I65099ef00822d08fd3f5480c80=
892f3bf86c56e7<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>--=
-<br>M CMakeLists.txt<br>M Changes.rst<br>M doc/man-sections/vpn-network-op=
tions.rst<br>M src/openvpn/Makefile.am<br>M src/openvpn/dco.c<br>M src/open=
vpn/forward.c<br>M src/openvpn/init.c<br>M src/openvpn/run_command.c<br>M s=
rc/openvpn/run_command.h<br>M src/openvpn/tun.c<br>M src/openvpn/tun.h<br>A=
 src/openvpn/tun_afunix.c<br>A src/openvpn/tun_afunix.h<br>13 files changed=
, 394 insertions(+), 16 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/47/747/11</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.=
txt b/CMakeLists.txt</span><br><span>index ad620fa..6271574 100644</span><b=
r><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br=
><span>@@ -536,6 +536,8 @@</span><br><span>     src/openvpn/tls_crypt.c</sp=
an><br><span>     src/openvpn/tun.c</span><br><span>     src/openvpn/tun.h<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/openvpn/tun_=
afunix.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src/ope=
nvpn/tun_afunix.h</span><br><span>     src/openvpn/networking_sitnl.c</span=
><br><span>     src/openvpn/networking_freebsd.c</span><br><span>     src/o=
penvpn/auth_token.c</span><br><span>diff --git a/Changes.rst b/Changes.rst<=
/span><br><span>index 439352a..7d19577 100644</span><br><span>--- a/Changes=
.rst</span><br><span>+++ b/Changes.rst</span><br><span>@@ -9,6 +9,19 @@</sp=
an><br><span>     the user experience as the client shows an error instead =
of running into</span><br><span>     a timeout when the server just stops r=
esponding completely.</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+Support for tun/tap via unix domain socket and lwipovpn=
 support</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    To allo=
w better testing and emulating a full client with a full</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    network stack OpenVPN now allows a=
 program executed to provide</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    a tun/tap device instead of opening a device.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    The co-developed lwipovpn program based on lwIP sta=
ck allows to</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sim=
ulate full IP stack and an OpenVPN client using</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ``--dev-node unix:/path/to/lwipovpn`` can e=
mulate a full client that</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    can be pinged, can serve a website and more without requiring any=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    elevated permis=
sion. This can make testing OpenVPN much easier.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    For more details see [lwipovpn on Gihtub](https://github.com/=
OpenVPN/lwipovpn).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> Deprecated features</span><br><span> -------------------</=
span><br><span> ``secret`` support has been removed by default.</span><br><=
span>diff --git a/doc/man-sections/vpn-network-options.rst b/doc/man-sectio=
ns/vpn-network-options.rst</span><br><span>index 84d4273..fc76939 100644</s=
pan><br><span>--- a/doc/man-sections/vpn-network-options.rst</span><br><spa=
n>+++ b/doc/man-sections/vpn-network-options.rst</span><br><span>@@ -117,6 =
+117,16 @@</span><br><span>   figure out whether ``node`` is a TUN or TAP d=
evice based on the name,</span><br><span>   you should also specify ``--dev=
-type tun`` or ``--dev-type tap``.</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+  If ``node`` starts with the string ``un=
ix:`` openvpn will treat the rest</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+  of the argument as a program.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+  OpenVPN will start the program and create a tem=
porary unix domain socket that</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  will be passed to the program together with the tun configurat=
ion as</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  environment=
 variables.  The temporary unix domain socket  will be be passed</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  in the environment variable =
:code:`TUNTAP_SOCKET_FD`.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  This ``unix=
:`` mode is designed mainly to use with the lwipovpn network</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+  emulator (https://github.com/Ope=
nVPN/lwipovpn).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> --dev-type device-type</span><br><span>   Which device type a=
re we using? ``device-type`` should be :code:`tun`</span><br><span>   (OSI =
Layer 3) or :code:`tap` (OSI Layer 2). Use this option only if</span><br><s=
pan>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am</span><b=
r><span>index 3784a98..ecb2bcf 100644</span><br><span>--- a/src/openvpn/Mak=
efile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><br><span>@@ -=
140,6 +140,7 @@</span><br><span> 	syshead.h \</span><br><span> 	tls_crypt.c=
 tls_crypt.h \</span><br><span> 	tun.c tun.h \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	tun_afunix.c tun_afunix.h \</span><br><span> 	v=
lan.c vlan.h \</span><br><span> 	xkey_provider.c xkey_common.h \</span><br>=
<span> 	xkey_helper.c \</span><br><span>diff --git a/src/openvpn/dco.c b/sr=
c/openvpn/dco.c</span><br><span>index 0df185e..ecef455 100644</span><br><sp=
an>--- a/src/openvpn/dco.c</span><br><span>+++ b/src/openvpn/dco.c</span><b=
r><span>@@ -41,6 +41,7 @@</span><br><span> #include &quot;ssl_common.h&quot=
;</span><br><span> #include &quot;ssl_ncp.h&quot;</span><br><span> #include=
 &quot;tun.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &quot;tun_afunix.h&quot;</span><br><span> </span><br><span> #ifdef =
HAVE_LIBCAPNG</span><br><span> #include &lt;cap-ng.h&gt;</span><br><span>@@=
 -298,6 +299,13 @@</span><br><span>         return false;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (is_tun_afunix(o-&gt;dev_node))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(msglevel, &quot;Note: afunix tun type selected, disabl=
ing data channel&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            &quot;offload&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span>     if (o-&gt;connection_list)</span><br><span>     =
{</span><br><span>         const struct connection_list *l =3D o-&gt;connec=
tion_list;</span><br><span>diff --git a/src/openvpn/forward.c b/src/openvpn=
/forward.c</span><br><span>index a88a4bb..6df01d1 100644</span><br><span>--=
- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span=
><br><span>@@ -41,6 +41,7 @@</span><br><span> #include &quot;ssl_verify.h&q=
uot;</span><br><span> #include &quot;dco.h&quot;</span><br><span> #include =
&quot;auth_token.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;tun_afunix.h&quot;</span><br><span> </span><br><span> #=
include &quot;memdbg.h&quot;</span><br><span> </span><br><span>@@ -1319,7 +=
1320,14 @@</span><br><span> #else  /* ifdef _WIN32 */</span><br><span>     =
ASSERT(buf_init(&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.headroom));</span><br=
><span>     ASSERT(buf_safe(&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.payload_s=
ize));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c2.bu=
f.len =3D read_tun(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf), c-&gt;c2.frame=
.buf.payload_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (c-&gt;c1.tuntap-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        c-&gt;c2.buf.len =3D read_tun_afunix=
(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        c-&gt;c2.buf.len =3D read_tun(c-&gt;c1.tuntap, =
BPTR(&amp;c-&gt;c2.buf), c-&gt;c2.frame.buf.payload_size);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #endif /* ifd=
ef _WIN32 */</span><br><span> </span><br><span> #ifdef PACKET_TRUNCATION_CH=
ECK</span><br><span>@@ -1926,7 +1934,14 @@</span><br><span> #ifdef _WIN32</=
span><br><span>         size =3D write_tun_buffered(c-&gt;c1.tuntap, &amp;c=
-&gt;c2.to_tun);</span><br><span> #else</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        size =3D write_tun(c-&gt;c1.tuntap, BPTR(&amp;c-&=
gt;c2.to_tun), BLEN(&amp;c-&gt;c2.to_tun));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (c-&gt;c1.tuntap-&gt;backend_driver =3D=
=3D DRIVER_AFUNIX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 size =3D write_tun_afunix(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.to_tun), BLE=
N(&amp;c-&gt;c2.to_tun));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            size =3D =
write_tun(c-&gt;c1.tuntap, BPTR(&amp;c-&gt;c2.to_tun), BLEN(&amp;c-&gt;c2.t=
o_tun));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span> #endif</span><br><span> </span><br><span>         if (size =
&gt; 0)</span><br><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.=
c</span><br><span>index 83cc670..1a14e19 100644</span><br><span>--- a/src/o=
penvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -=
54,6 +54,7 @@</span><br><span> #include &quot;mss.h&quot;</span><br><span> =
#include &quot;mudp.h&quot;</span><br><span> #include &quot;dco.h&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;tun_afun=
ix.h&quot;</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;=
</span><br><span> </span><br><span>@@ -1758,10 +1759,18 @@</span><br><span>=
                             &amp;c-&gt;net_ctx,</span><br><span>          =
                   c-&gt;c1.tuntap);</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (is_tun_afunix(c-&gt;options.dev_=
node))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Using AF_UNIX tr=
umps using DCO */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      c-&gt;c1.tuntap-&gt;backend_driver =3D DRIVER_AFUNIX;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #ifdef _WIN3=
2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    c-&gt;c1.tuntap-=
&gt;backend_driver =3D c-&gt;options.windows_driver;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        c-&gt;c1.tuntap-&gt;backend_driver =3D c-&gt;options.windo=
ws_driver;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</sp=
an><br><span> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (dco_enabled(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    else if (dco_enabled(&amp;c-&gt;options))</span><br>=
<span>     {</span><br><span>         c-&gt;c1.tuntap-&gt;backend_driver =
=3D DRIVER_DCO;</span><br><span>     }</span><br><span>@@ -1786,6 +1795,10 =
@@</span><br><span> static bool</span><br><span> can_preserve_tun(struct tu=
ntap *tt)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (tt &amp;&amp; tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> #ifdef TA=
RGET_ANDROID</span><br><span>     return false;</span><br><span> #else</spa=
n><br><span>@@ -1841,6 +1854,22 @@</span><br><span> #endif</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+open_tu=
n_backend(struct context *c)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t tuntap *tt =3D c-&gt;c1.tuntap;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        open_tun_afunix(&amp;c-&gt;option=
s, c-&gt;c2.frame.tun_mtu, tt, c-&gt;c2.es);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        open_t=
un(c-&gt;options.dev, c-&gt;options.dev_type, c-&gt;options.dev_node,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                 tt, &amp=
;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static bool</span><br><span> do_open=
_tun(struct context *c, int *error_flags)</span><br><span> {</span><br><spa=
n>@@ -1863,7 +1892,8 @@</span><br><span>         }</span><br><span> #endif<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    /* initialize (but do not open) tun/tap object */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* initialize (but do not open) t=
un/tap object, this also sets</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+         * the backend driver type */</span><br><span>         do=
_init_tun(c);</span><br><span> </span><br><span>         /* inherit the dco=
 context from the tuntap object */</span><br><span>@@ -1898,7 +1928,7 @@</s=
pan><br><span> </span><br><span>         /* do ifconfig */</span><br><span>=
         if (!c-&gt;options.ifconfig_noexec</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            &amp;&amp; ifconfig_order() =3D=3D IFCONF=
IG_BEFORE_TUN_OPEN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            &amp;&amp; ifconfig_order(c-&gt;c1.tuntap) =3D=3D IFCONFIG_BEFO=
RE_TUN_OPEN)</span><br><span>         {</span><br><span>             /* gue=
ss actual tun/tap unit number that will be returned</span><br><span>       =
       * by open_tun */</span><br><span>@@ -1911,7 +1941,7 @@</span><br><sp=
an>         }</span><br><span> </span><br><span>         /* possibly add ro=
utes */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ro=
ute_order() =3D=3D ROUTE_BEFORE_TUN)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (route_order(c-&gt;c1.tuntap) =3D=3D ROUTE_BEFO=
RE_TUN)</span><br><span>         {</span><br><span>             /* Ignore r=
oute_delay, would cause ROUTE_BEFORE_TUN to be ignored */</span><br><span> =
            bool status =3D do_route(&amp;c-&gt;options, c-&gt;c1.route_lis=
t, c-&gt;c1.route_ipv6_list,</span><br><span>@@ -1928,8 +1958,7 @@</span><b=
r><span>         }</span><br><span> </span><br><span>         /* open the t=
un device */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o=
pen_tun(c-&gt;options.dev, c-&gt;options.dev_type, c-&gt;options.dev_node,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 c-&gt=
;c1.tuntap, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        open_tun_backend(c);</span><br><span> </span><br><span=
>         /* set the hardware address */</span><br><span>         if (c-&gt=
;options.lladdr)</span><br><span>@@ -1940,7 +1969,7 @@</span><br><span> </s=
pan><br><span>         /* do ifconfig */</span><br><span>         if (!c-&g=
t;options.ifconfig_noexec</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            &amp;&amp; ifconfig_order() =3D=3D IFCONFIG_AFTER_TUN_OPEN)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&a=
mp; ifconfig_order(c-&gt;c1.tuntap) =3D=3D IFCONFIG_AFTER_TUN_OPEN)</span><=
br><span>         {</span><br><span>             do_ifconfig(c-&gt;c1.tunta=
p, c-&gt;c1.tuntap-&gt;actual_name,</span><br><span>                       =
  c-&gt;c2.frame.tun_mtu, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span=
>@@ -1966,7 +1995,7 @@</span><br><span>         add_wfp_block(c);</span><br=
><span> </span><br><span>         /* possibly add routes */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        if ((route_order() =3D=3D ROU=
TE_AFTER_TUN) &amp;&amp; (!c-&gt;options.route_delay_defined))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if ((route_order(c-&gt;c=
1.tuntap) =3D=3D ROUTE_AFTER_TUN) &amp;&amp; (!c-&gt;options.route_delay_de=
fined))</span><br><span>         {</span><br><span>             int status =
=3D do_route(&amp;c-&gt;options, c-&gt;c1.route_list, c-&gt;c1.route_ipv6_l=
ist,</span><br><span>                                   c-&gt;c1.tuntap, c-=
&gt;plugins, c-&gt;c2.es, &amp;c-&gt;net_ctx);</span><br><span>@@ -2026,7 +=
2055,14 @@</span><br><span>         {</span><br><span>             undo_ifc=
onfig(c-&gt;c1.tuntap, &amp;c-&gt;net_ctx);</span><br><span>         }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        close_tun(c-&gt;c1=
.tuntap, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (c-&gt;c1.tuntap-&gt;backend_driver =3D=3D DRIVER_AFUN=
IX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            close_tun_afun=
ix(c-&gt;c1.tuntap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e=
lse</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            close_tun(c-&g=
t;c1.tuntap, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span>         c-&gt;c1.tuntap =3D NULL;<=
/span><br><span>     }</span><br><span>     c-&gt;c1.tuntap_owned =3D false=
;</span><br><span>@@ -2466,7 +2502,7 @@</span><br><span>             c-&gt;=
c1.pulled_options_digest_save =3D c-&gt;c2.pulled_options_digest;</span><br=
><span> </span><br><span>             /* if --route-delay was specified, st=
art timer */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if ((route_order() =3D=3D ROUTE_AFTER_TUN) &amp;&amp; c-&gt;options.rout=
e_delay_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if ((route_order(c-&gt;c1.tuntap) =3D=3D ROUTE_AFTER_TUN) &amp;&am=
p; c-&gt;options.route_delay_defined)</span><br><span>             {</span>=
<br><span>                 event_timeout_init(&amp;c-&gt;c2.route_wakeup, c=
-&gt;options.route_delay, now);</span><br><span>                 event_time=
out_init(&amp;c-&gt;c2.route_wakeup_expire, c-&gt;options.route_delay + c-&=
gt;options.route_delay_window, now);</span><br><span>diff --git a/src/openv=
pn/run_command.c b/src/openvpn/run_command.c</span><br><span>index 292e81f.=
.d757823 100644</span><br><span>--- a/src/openvpn/run_command.c</span><br><=
span>+++ b/src/openvpn/run_command.c</span><br><span>@@ -155,6 +155,10 @@</=
span><br><span>             {</span><br><span>                 msg(M_ERR, &=
quot;openvpn_execve: unable to fork&quot;);</span><br><span>             }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if =
(flags &amp; S_NOWAITPID)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                ret =3D pid;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span>             else /* parent side */<=
/span><br><span>             {</span><br><span>                 if (waitpid=
(pid, &amp;ret, 0) !=3D pid)</span><br><span>@@ -204,6 +208,11 @@</span><br=
><span>             goto done;</span><br><span>         }</span><br><span> =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (f=
lags &amp; S_NOWAITPID &amp;&amp; (stat &gt; 0))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        ret =3D stat;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        goto done;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span>     else if (platform_system_ok(stat=
))</span><br><span>     {</span><br><span>         ret =3D true;</span><br>=
<span>diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h</s=
pan><br><span>index ccad307..c92edbc 100644</span><br><span>--- a/src/openv=
pn/run_command.h</span><br><span>+++ b/src/openvpn/run_command.h</span><br>=
<span>@@ -47,6 +47,9 @@</span><br><span> /** Instead of returning 1/0 for s=
uccess/fail,</span><br><span>  * return exit code when between 0 and 255 an=
d -1 otherwise */</span><br><span> #define S_EXITCODE  (1&lt;&lt;2)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/** instead of waiting for =
child process to exit and report the status,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * return the pid of the child process */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define S_NOWAITPID (1&lt;&l=
t;3)</span><br><span> </span><br><span> /* wrapper around the execve() call=
 */</span><br><span> int openvpn_popen(const struct argv *a,  const struct =
env_set *es);</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/=
tun.c</span><br><span>index 3959363..b305b64 100644</span><br><span>--- a/s=
rc/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@=
 -72,6 +72,9 @@</span><br><span>         case DRIVER_DCO:</span><br><span> =
            return &quot;ovpn-dco&quot;;</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        case DRIVER_AFUNIX:</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return &quot;uni=
x&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span>         case DRIVER_UTUN:</span><br><span>             return &quot;=
utun&quot;;</span><br><span> </span><br><span>diff --git a/src/openvpn/tun.=
h b/src/openvpn/tun.h</span><br><span>index 80f8bfa..a38aef0 100644</span><=
br><span>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</s=
pan><br><span>@@ -47,6 +47,10 @@</span><br><span>     WINDOWS_DRIVER_TAP_WI=
NDOWS6,</span><br><span>     WINDOWS_DRIVER_WINTUN,</span><br><span>     DR=
IVER_GENERIC_TUNTAP,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /** using an AF_UNIX socket to pass packets from/to an external progra=
m.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  This is a=
lways defined. We error out if a user tries to open this type</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+     *  of backend on unsupported=
 platforms. */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    D=
RIVER_AFUNIX,</span><br><span>     DRIVER_DCO,</span><br><span>     /** mac=
OS internal tun driver */</span><br><span>     DRIVER_UTUN</span><br><span>=
@@ -161,6 +165,17 @@</span><br><span> /*</span><br><span>  * Define a TUN/T=
AP dev.</span><br><span>  */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifndef WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+typedef struct afunix_context</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
id_t childprocess;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
 afunix_context_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* ifndef WIN3=
2 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef struct =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int dummy;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+} afunix_context_t;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span>=
 </span><br><span> struct tuntap</span><br><span> {</span><br><span>@@ -175=
,7 +190,12 @@</span><br><span>      */</span><br><span>     enum tun_driver=
_type backend_driver;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /** if the internal variables related to ifconfig o=
f this struct have</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    * been set up. This does NOT mean ifconfig has been called */</span><br=
><span>     bool did_ifconfig_setup;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /** if the internal variables related to ifconfig-ipv6 of this struct hav=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * been set up=
. This does NOT mean ifconfig has been called */</span><br><span>     bool =
did_ifconfig_ipv6_setup;</span><br><span> </span><br><span>     bool persis=
tent_if;         /* if existed before, keep on program end */</span><br><sp=
an>@@ -227,6 +247,7 @@</span><br><span>     unsigned int rwflags_debug;</sp=
an><br><span> </span><br><span>     dco_context_t dco;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    afunix_context_t afunix;</span><br><=
span> };</span><br><span> </span><br><span> static inline bool</span><br><s=
pan>@@ -350,8 +371,12 @@</span><br><span> #define IFCONFIG_DEFAULT         =
IFCONFIG_AFTER_TUN_OPEN</span><br><span> </span><br><span> static inline in=
t</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ifconfig_order(void)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ifconfig_order(stru=
ct tuntap *tt)</span><br><span> {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (tt-&gt;backend_driver =3D=3D DRIVER_AFUNIX)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return IFCONFIG_BEFORE_TUN_OPEN;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><spa=
n> #if defined(TARGET_LINUX)</span><br><span>     return IFCONFIG_AFTER_TUN=
_OPEN;</span><br><span> #elif defined(TARGET_SOLARIS)</span><br><span>@@ -3=
76,8 +401,12 @@</span><br><span> #define ROUTE_ORDER_DEFAULT ROUTE_AFTER_TU=
N</span><br><span> </span><br><span> static inline int</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-route_order(void)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+route_order(struct tuntap *tt)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt=
;backend_driver =3D=3D DRIVER_AFUNIX)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        return ROUTE_BEFORE_TUN;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    }</span><br><span> #if defined(TARGET_ANDROID)</span><=
br><span>     return ROUTE_BEFORE_TUN;</span><br><span> #else</span><br><sp=
an>@@ -755,5 +784,4 @@</span><br><span> {</span><br><span>     return tt &a=
mp;&amp; tt-&gt;type !=3D DEV_TYPE_UNDEF;</span><br><span> }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #endif /* TUN_H */=
</span><br><span>diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_af=
unix.c</span><br><span>new file mode 100644</span><br><span>index 0000000..=
f4ce4b7</span><br><span>--- /dev/null</span><br><span>+++ b/src/openvpn/tun=
_afunix.c</span><br><span>@@ -0,0 +1,178 @@</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a singl=
e TCP/UDP port, with support for SSL/TLS-based</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *             session authentication and key ex=
change,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet encryption, packet authentication, and</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *             packet compression.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2024 OpenVPN Inc &lt;sale=
s@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is f=
ree software; you can redistribute it and/or modify</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General=
 Public License version 2</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  as published by the Free Software Foundation.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is distributed in the hope that it will=
 be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Genera=
l Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin =
Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;config.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;tun.h&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;fdmisc.h&quot;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;run_=
command.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inc=
lude &quot;manage.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#include &quot;win32.h&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;wfp_block.h&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#include &quot;argv.h&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &quot;options.h&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifndef WIN32</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* Windows does implement some AF_UNIX functionality =
but key features</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
like socketpair() and SOCK_DGRAM are missing */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#include &lt;string.h&gt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &lt;unistd.h&gt;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;sys/wait.h&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;signal.h&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+tun_afunix_exec_child(const char *dev_node, struct tuntap *tt=
, struct env_set *env)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct argv=
 argv =3D argv_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* since we k=
now that dev-node starts with unix: we can just skip that</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * to get the program name */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *program=
 =3D dev_node + strlen(&quot;unix:&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    argv_printf(&amp;argv, &quot;%s&quot;, program);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    argv_msg(M_INFO, &amp;argv);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    tt-&gt;afunix.childprocess =3D openvpn_e=
xecve_check(&amp;argv, env, S_NOWAITPID,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                                   &qu=
ot;ERROR: failure executing &quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                                                   &quot;pro=
cess for tun&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    argv_free(&amp;argv);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+open_tun_afunix(struct options *o,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                int mtu,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                struct tu=
ntap *tt,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      struct env_set *orig_env)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
fds[2];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!(so=
cketpair(AF_UNIX, SOCK_DGRAM, 0, fds) =3D=3D 0))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        msg(M_ERR, &quot;Cannot create socket pair for AF_UN=
IX socket to external &quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            &quot;program&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Use the=
 first file descriptor for our side and avoid passing it</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * to the child */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    tt-&gt;fd =3D fds[1];</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    set_cloexec(tt-&gt;fd);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* Make a copy of the env, so we do =
not need to delete our custom</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * environment variables later */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct env_set *env =3D env_set_create(&amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    env_set_in=
herit(env, orig_env);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    setenv_int(en=
v, &quot;TUNTAP_SOCKET_FD&quot;, fds[0]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    setenv_str(env, &quot;TUNTAP_DEV_TYPE&quot;, dev_=
type_string(o-&gt;dev, o-&gt;dev_type));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    setenv_int(env, &quot;TUNTAP_MTU&quot;, mtu);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (o-&gt;route_defa=
ult_gateway)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_str(en=
v, &quot;ifconfig_gateway&quot;, o-&gt;route_default_gateway);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (o-&gt;lladdr)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        setenv_str(env, &quot;TUNTAP_LLADDR&quot;, o-&gt;l=
laddr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tun_afunix_exec_child(o-&gt;dev_node, tt,=
 env);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    close(fds[0]);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* tt-&gt;actual_name is passed to up and down s=
cripts and used as the ifconfig dev name */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    tt-&gt;actual_name =3D string_alloc(&quot;inter=
nal:af_unix&quot;, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&=
amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+close_tun_afunix(struct tuntap *tt)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    ASSERT(tt);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (tt-&gt;fd &gt;=3D 0)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        close(tt-&gt;fd);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tt-&gt;fd =3D 0;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  kill(tt-&gt;afunix.childprocess, SIGINT);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    free(tt-&gt;actual_name);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    free(tt);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+write_tun_afunix(struct tuntap *tt, uint=
8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ret;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    pid_t pidret =3D waitp=
id(tt-&gt;afunix.childprocess, &amp;ret, WNOHANG);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (pidret =3D=3D tt-&gt;afunix.childpro=
cess)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;Ch=
ild process PID %d for afunix dead? Return code: %d&quot;,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            tt-&gt;afunix.childproce=
ss, ret);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn -ENXIO;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return write(tt-&=
gt;fd, buf, len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+read_tun_afunix(struct tuntap *tt, uint8_t *buf, in=
t len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return read(tt-&gt;fd, buf,=
 len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#else  /* ifndef WIN32 */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+open_tun_afunix(const char *dev, const c=
har *dev_type, int mtu,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                struct tuntap *tt, struct env_set env)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    msg(M_ERR, &quot;AF_UNIX socket support not availa=
ble on this platform&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+close_tun_afunix(struct tuntap *tt)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* should never be called as open_tun=
_afunix always fails */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    ASSERT(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+write_tun_afunix(struct tuntap *tt, uint8_t *buf, =
int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* should never be called=
 as open_tun_afunix always fails */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    ASSERT(0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ssize_t</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+read_tun_afunix(struct tuntap *tt, uin=
t8_t *buf, int len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* should neve=
r be called as open_tun_afunix always fails */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ASSERT(0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifnde=
f WIN32 */</span><br><span>diff --git a/src/openvpn/tun_afunix.h b/src/open=
vpn/tun_afunix.h</span><br><span>new file mode 100644</span><br><span>index=
 0000000..265602f</span><br><span>--- /dev/null</span><br><span>+++ b/src/o=
penvpn/tun_afunix.h</span><br><span>@@ -0,0 +1,72 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2002-2024 OpenVPN In=
c &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This pr=
ogram is free software; you can redistribute it and/or modify</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GNU=
 General Public License version 2</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  as published by the Free Software Foundation.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope that=
 it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNE=
SS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  GNU General Public License for more details.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  You should have received a copy of the GN=
U General Public License along</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  with this program; if not, write to the Free Software Founda=
tion, Inc.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 F=
ranklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifndef AFUNIX_TUN_H</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#define AFUNIX_TUN_H</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &lt;sys/types.h&gt;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &quot;tun.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Opens an AF_UNIX based tun devic=
e. This also executes the command that</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * the user provided taking care of implementing the act=
ual tun</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * device.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+open_tun_afunix(struct options *o,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                int mtu,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                struct tuntap *t=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                s=
truct env_set *env);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * Closes the socket used for the AF_UNIX based devic=
e. Also sends a</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * S=
IGINT to the child process that was spawned to handle the tun device</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+close_tun_afunix(struct tuntap *tt);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Writes a packet to a AF_UNIX based tun device.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ssize_t</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+write_tun_afunix(struct tuntap *tt, uint8_t *buf, int len);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * Reads a packet from a AF_UNIX based tun device.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ssize_t</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+read_tun_afunix(struct tuntap *tt, uint8_t *buf, int len);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif /* AFUNIX_TUN_H */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Checks whether a --dev-node parameter specifies a AF_UNIX device</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param devnode   the s=
tring to check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn          true if the string starts with unix:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static inline bool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+is_tun_afunix(const char *devnode)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return devnode &amp;&amp; strprefix(devnode, &quot;unix=
:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/747?usp=3Demail">change 747</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
747?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65099ef00822d08fd3f5480c808=
92f3bf86c56e7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--puHcvlsa4Cc=--

