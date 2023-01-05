From: Arne Schwabe <arne@...1227...>
Date: Thu,  5 Jan 2023 18:56:14 +0100
Message-Id: <20230105175614.405385-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add connect-freq-initial option to limit
 initial connection responses
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

This limits the nubmer of packets OpenVPN will respond to. This avoid
OpenVPN server being abused for refelection attacks in a large scale
as we gotten a lot more efficient with the cookie approach in our
initial connection approach.

The defaults of 100 attempts per 10s should work for most people,
esepcially since completed three way handshakes are not counted. So
the default will throttle connection attempts on server with high packet
loss or that are actually under a DOS.

The 100 per 10s are similar in size to the old 2.5 and earlier behaviour
where every initial connection attempt would take up a slot of the
max-clients sessions and those would only expire after the TLS timeout.
This roughly translates to 1024 connection attempts in 60s on an
empty server.

OpenVPN will announce once per period how many packets it dropped:

    Dropped 11 initial handshake packets due to --connect-freq-initial 100 10

to inform an amdin about the consequence of this feature.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 Changes.rst                         |  4 ++
 doc/man-sections/server-options.rst | 19 ++++++
 src/openvpn/Makefile.am             |  1 +
 src/openvpn/mudp.c                  | 14 +++++
 src/openvpn/multi.c                 |  4 ++
 src/openvpn/multi.h                 |  2 +
 src/openvpn/options.c               | 24 ++++++++
 src/openvpn/options.h               |  5 ++
 src/openvpn/reflect_filter.c        | 91 +++++++++++++++++++++++++++++
 src/openvpn/reflect_filter.h        | 70 ++++++++++++++++++++++
 10 files changed, 234 insertions(+)
 create mode 100644 src/openvpn/reflect_filter.c
 create mode 100644 src/openvpn/reflect_filter.h

diff --git a/Changes.rst b/Changes.rst
index 47933ae09..187d03fcf 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -92,6 +92,10 @@ Cookie based handshake for UDP server
     shake. The tls-crypt-v2 option allows controlling if older clients are
     accepted.
 
+    By default the rate of initial packet responses is limited to 100 per 10s
+    interval to avoid OpenVPN servers being abused in reflection attacks
+    (see ``--connect-freq-initial``).
+
 Data channel offloading with ovpn-dco
     2.6.0+ implements support for data-channel offloading where the data packets
     are directly processed and forwarded in kernel space thanks to the ovpn-dco
diff --git a/doc/man-sections/server-options.rst b/doc/man-sections/server-options.rst
index 99263fff3..cbb2c3c92 100644
--- a/doc/man-sections/server-options.rst
+++ b/doc/man-sections/server-options.rst
@@ -184,6 +184,25 @@ fast hardware. SSL/TLS authentication must be used in this mode.
   For the best protection against DoS attacks in server mode, use
   ``--proto udp`` and either ``--tls-auth`` or ``--tls-crypt``.
 
+--connect-freq-initial args
+  (UDP only) Allow a maximum of ``n`` initial connection packet responses
+  per ``sec`` seconds from to clients.
+
+  Valid syntax:
+  ::
+
+     connect-freq-initial n sec
+
+  OpenVPN starting at 2.6 is very efficient in responding to initial
+  connection packets. When not limiting the initial responses
+  an OpenVPN daemon can be abused in reflection attacks.
+  This option is designed to limit the rate OpenVPN will respond to initial
+  attacks.
+
+  Connection attempts that complete the initial three-way handshake
+  will not be counted against the limit. The default is to allow
+  100 initial connection per 10s.
+
 --duplicate-cn
   Allow multiple clients with the same common name to concurrently
   connect. In the absence of this option, OpenVPN will disconnect a client
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index e80a35abd..35d60a65b 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -113,6 +113,7 @@ openvpn_SOURCES = \
 	ps.c ps.h \
 	push.c push.h \
 	pushlist.h \
+	reflect_filter.c reflect_filter.h \
 	reliable.c reliable.h \
 	route.c route.h \
 	run_command.c run_command.h \
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index c27c6da5b..4ef2f355b 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -82,6 +82,16 @@ do_pre_decrypt_check(struct multi_context *m,
     struct openvpn_sockaddr *from = &m->top.c2.from.dest;
     int handwindow = m->top.options.handshake_window;
 
+    if (verdict == VERDICT_VALID_RESET_V3 || verdict == VERDICT_VALID_RESET_V2)
+    {
+        /* Check if we are still below our limit for sending out
+         * responses */
+        if (!reflect_filter_rate_limit_check(m->initial_rate_limiter))
+        {
+            return false;
+        }
+    }
+
     if (verdict == VERDICT_VALID_RESET_V3)
     {
         /* Extract the packet id to check if it has the special format that
@@ -244,6 +254,10 @@ multi_get_create_instance_udp(struct multi_context *m, bool *floated)
 
                 if (frequency_limit_event_allowed(m->new_connection_limiter))
                 {
+                    /* a successful three-way handshake only counts against
+                     * connect-freq but not against connect-req-initial */
+                    reflect_filter_rate_limit_decrease(m->initial_rate_limiter);
+
                     mi = multi_create_instance(m, &real);
                     if (mi)
                     {
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0ba509fa0..1a7f278f7 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -52,6 +52,7 @@
 #include "crypto_backend.h"
 #include "ssl_util.h"
 #include "dco.h"
+#include "reflect_filter.h"
 
 /*#define MULTI_DEBUG_EVENT_LOOP*/
 
@@ -368,6 +369,8 @@ multi_init(struct multi_context *m, struct context *t, bool tcp_mode)
      */
     m->new_connection_limiter = frequency_limit_init(t->options.cf_max,
                                                      t->options.cf_per);
+    m->initial_rate_limiter = initial_rate_limit_init(t->options.cf_initial_max,
+                                                      t->options.cf_initial_per);
 
     /*
      * Allocate broadcast/multicast buffer list
@@ -729,6 +732,7 @@ multi_uninit(struct multi_context *m)
         mbuf_free(m->mbuf);
         ifconfig_pool_free(m->ifconfig_pool);
         frequency_limit_free(m->new_connection_limiter);
+        initial_rate_limit_free(m->initial_rate_limiter);
         multi_reap_free(m->reaper);
         mroute_helper_free(m->route_helper);
         multi_tcp_free(m->mtcp);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 370d795c9..713c63eee 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -39,6 +39,7 @@
 #include "mtcp.h"
 #include "perf.h"
 #include "vlan.h"
+#include "reflect_filter.h"
 
 #define MULTI_PREFIX_MAX_LENGTH 256
 
@@ -170,6 +171,7 @@ struct multi_context {
                                  *   as external transport. */
     struct ifconfig_pool *ifconfig_pool;
     struct frequency_limit *new_connection_limiter;
+    struct initial_packet_rate_limit *initial_rate_limiter;
     struct mroute_helper *route_helper;
     struct multi_reap *reaper;
     struct mroute_addr local;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index ee3783046..cf8622f46 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -480,6 +480,7 @@ static const char usage_message[] =
     "                  as well as pushes it to connecting clients.\n"
     "--learn-address cmd : Run command cmd to validate client virtual addresses.\n"
     "--connect-freq n s : Allow a maximum of n new connections per s seconds.\n"
+    "--connect-freq-initial n s : Allow a maximum of n replies for initial connections attempts per s seconds.\n"
     "--max-clients n : Allow a maximum of n simultaneously connected clients.\n"
     "--max-routes-per-client n : Allow a maximum of n internal routes per client.\n"
     "--stale-routes-check n [t] : Remove routes with a last activity timestamp\n"
@@ -864,6 +865,8 @@ init_options(struct options *o, const bool init_gc)
     o->n_bcast_buf = 256;
     o->tcp_queue_limit = 64;
     o->max_clients = 1024;
+    o->cf_initial_per = 10;
+    o->cf_initial_max = 100;
     o->max_routes_per_client = 256;
     o->stale_routes_check_interval = 0;
     o->ifconfig_pool_persist_refresh_freq = 600;
@@ -1555,6 +1558,8 @@ show_p2mp_parms(const struct options *o)
     SHOW_BOOL(duplicate_cn);
     SHOW_INT(cf_max);
     SHOW_INT(cf_per);
+    SHOW_INT(cf_initial_max);
+    SHOW_INT(cf_initial_per);
     SHOW_INT(max_clients);
     SHOW_INT(max_routes_per_client);
     SHOW_STR(auth_user_pass_verify_script);
@@ -2613,6 +2618,10 @@ options_postprocess_verify_ce(const struct options *options,
         {
             msg(M_USAGE, "--connect-freq only works with --mode server --proto udp.  Try --max-clients instead.");
         }
+        if (!proto_is_udp(ce->proto) && (options->cf_initial_max || options->cf_initial_per))
+        {
+            msg(M_USAGE, "--connect-freq only works with --mode server --proto udp.  Try --max-clients instead.");
+        }
         if (!(dev == DEV_TYPE_TAP || (dev == DEV_TYPE_TUN && options->topology == TOP_SUBNET)) && options->ifconfig_pool_netmask)
         {
             msg(M_USAGE, "The third parameter to --ifconfig-pool (netmask) is only valid in --dev tap mode");
@@ -7452,6 +7461,21 @@ add_option(struct options *options,
         options->cf_max = cf_max;
         options->cf_per = cf_per;
     }
+    else if (streq(p[0], "connect-freq-initial") && p[1] && p[2] && !p[3])
+    {
+        int cf_max, cf_per;
+
+        VERIFY_PERMISSION(OPT_P_GENERAL);
+        cf_max = atoi(p[1]);
+        cf_per = atoi(p[2]);
+        if (cf_max < 0 || cf_per < 0)
+        {
+            msg(msglevel, "--connect-freq-initial parms must be > 0");
+            goto err;
+        }
+        options->cf_initial_max = cf_max;
+        options->cf_initial_per = cf_per;
+    }
     else if (streq(p[0], "max-clients") && p[1] && !p[2])
     {
         int max_clients;
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index fec1eace5..48315b10e 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -513,8 +513,13 @@ struct options
     bool push_ifconfig_ipv6_blocked;                    /* IPv6 */
     bool enable_c2c;
     bool duplicate_cn;
+
     int cf_max;
     int cf_per;
+
+    int cf_initial_max;
+    int cf_initial_per;
+
     int max_clients;
     int max_routes_per_client;
     int stale_routes_check_interval;
diff --git a/src/openvpn/reflect_filter.c b/src/openvpn/reflect_filter.c
new file mode 100644
index 000000000..bc7587b01
--- /dev/null
+++ b/src/openvpn/reflect_filter.c
@@ -0,0 +1,91 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
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
+#elif defined(_MSC_VER)
+#include "config-msvc.h"
+#endif
+
+#include "syshead.h"
+
+
+#include <stdint.h>
+#include <stddef.h>
+#include <stdlib.h>
+#include <string.h>
+#include <stdbool.h>
+#include <memory.h>
+
+#include "crypto.h"
+#include "reflect_filter.h"
+
+
+bool
+reflect_filter_rate_limit_check(struct initial_packet_rate_limit *irl)
+{
+    if (now > irl->last_period_reset + irl->period_length)
+    {
+        int dropped = max_int(irl->curr_period_counter - irl->max_per_period, 0);
+        if (dropped > 0)
+        {
+            msg(D_TLS_DEBUG_LOW, "Dropped %d initial handshake packets due to "
+                "--connect-freq-initial %d %d",
+                dropped, irl->max_per_period, irl->period_length);
+        }
+        irl->last_period_reset = now;
+        irl->curr_period_counter = 0;
+    }
+    /* avoid overflow by capping the counter to INT_MAX -1. Still counting
+     * the number of packets during a period is still useful */
+    irl->curr_period_counter = min_int(irl->curr_period_counter + 1, INT_MAX - 1);
+
+    return irl->curr_period_counter > irl->max_per_period;
+}
+
+void
+reflect_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl)
+{
+    irl->curr_period_counter = max_int(irl->curr_period_counter - 1, 0);
+}
+
+
+struct initial_packet_rate_limit *
+initial_rate_limit_init(int max_per_period, int period_length)
+{
+    struct initial_packet_rate_limit *irl;
+
+
+    ALLOC_OBJ(irl, struct initial_packet_rate_limit);
+    irl->max_per_period = max_per_period;
+    irl->period_length = period_length;
+    irl->curr_period_counter = 0;
+
+    return irl;
+}
+
+void
+initial_rate_limit_free(struct initial_packet_rate_limit *irl)
+{
+    free(irl);
+}
diff --git a/src/openvpn/reflect_filter.h b/src/openvpn/reflect_filter.h
new file mode 100644
index 000000000..8cedf41c4
--- /dev/null
+++ b/src/openvpn/reflect_filter.h
@@ -0,0 +1,70 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2022 OpenVPN Inc <sales@...515...>
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
+#ifndef REFLECT_FILTER_H
+#define REFLECT_FILTER_H
+
+#include <limits.h>
+
+/** struct that handles all the rate limiting logic for initial
+ * responses */
+struct initial_packet_rate_limit {
+    /** This is a hard limit for packets per seconds. */
+    int max_per_period;
+
+    /** period length in seconds */
+    int period_length;
+
+    /** Number of packets in the current period */
+    int curr_period_counter;
+
+    /* Last time we reset our timer */
+    time_t last_period_reset;
+};
+
+
+/**
+ * checks if the connection is still allowed to connect under the rate
+ * limit. This also increases the internal counter at the same time
+ */
+bool
+reflect_filter_rate_limit_check(struct initial_packet_rate_limit *irl);
+
+/**
+ * decreases the counter of initial respsonses to allow connections that
+ * successfully completed the three-way handshake to not count against
+ * the counter of initial connection attempts
+ */
+void
+reflect_filter_rate_limit_decrease(struct initial_packet_rate_limit *irl);
+
+/**
+ * allocates and initial the initial packet rate limiter structure
+ */
+struct initial_packet_rate_limit *
+initial_rate_limit_init(int max_per_period, int period_length);
+
+/**
+ * free the initial rate limiter structure
+ */
+void initial_rate_limit_free(struct initial_packet_rate_limit *irl);
+#endif /* ifndef REFLECT_FILTER_H */
-- 
2.37.1 (Apple Git-137.1)


