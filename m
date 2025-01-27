From: Gert Doering <gert@...1296...>
Date: Mon, 27 Jan 2025 13:25:31 +0100
Message-ID: <20250127122531.13105-1-gert@...1296...>
In-Reply-To: <gerrit.1737460984000.Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de@...2715...>
References: <gerrit.1737460984000.Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] Print warnings/errors when numerical
 parameters cannot be parsed
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

Using the atoi method is a best effort method that parses as much of the
input string as possible as integer and ignores the rest or return 0
if the string cannot be parsed. This is lead to unexpected results.

Change the behaviour by printing a warning in these cases instead. When
parsing a configuration, these warnings will error out since the msglevel
is M_USAGE in this case. Example:

    ./src/openvpn/openvpn --resolv-retry 198jj
    Options error: Cannot parse argument '198jj' as non-negative integer

Reported-By: Anqi Chen <chen.anqi3@...2855...>
Reported-By: Cristina Nita-Rotaru <c.nitarotaru@...2855...>
Change-Id: Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/873
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bd5c056..4510bea 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -60,6 +60,8 @@
 #include "platform.h"
 #include "xkey_common.h"
 #include "dco.h"
+#include "options_util.h"
+
 #include <ctype.h>
 
 #include "memdbg.h"
@@ -5014,13 +5016,6 @@
 }
 #endif
 
-static int
-positive_atoi(const char *str)
-{
-    const int i = atoi(str);
-    return i < 0 ? 0 : i;
-}
-
 #ifdef _WIN32  /* This function is only used when compiling on Windows */
 static unsigned int
 atou(const char *str)
@@ -6043,7 +6038,7 @@
         int cache;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cache = atoi(p[1]);
+        cache = atoi_warn(p[1], msglevel);
         if (cache < 1)
         {
             msg(msglevel, "--management-log-cache parameter is out of range");
@@ -6355,7 +6350,7 @@
         }
         else
         {
-            options->resolve_retry_seconds = positive_atoi(p[1]);
+            options->resolve_retry_seconds = positive_atoi(p[1], msglevel);
         }
     }
     else if ((streq(p[0], "preresolve") || streq(p[0], "ip-remote-hint")) && !p[2])
@@ -6372,7 +6367,7 @@
     else if (streq(p[0], "connect-retry") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->ce.connect_retry_seconds = positive_atoi(p[1]);
+        options->ce.connect_retry_seconds = positive_atoi(p[1], msglevel);
         /*
          * Limit the base value of retry wait interval to 16 bits to avoid
          * overflow when scaled up for exponential backoff
@@ -6387,19 +6382,19 @@
         if (p[2])
         {
             options->ce.connect_retry_seconds_max =
-                max_int(positive_atoi(p[2]), options->ce.connect_retry_seconds);
+                max_int(positive_atoi(p[2], msglevel), options->ce.connect_retry_seconds);
         }
     }
     else if ((streq(p[0], "connect-timeout") || streq(p[0], "server-poll-timeout"))
              && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->ce.connect_timeout = positive_atoi(p[1]);
+        options->ce.connect_timeout = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "connect-retry-max") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->connect_retry_max = positive_atoi(p[1]);
+        options->connect_retry_max = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "ipchange") && p[1])
     {
@@ -6422,7 +6417,7 @@
     else if (streq(p[0], "gremlin") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->gremlin = positive_atoi(p[1]);
+        options->gremlin = positive_atoi(p[1], msglevel);
     }
 #endif
     else if (streq(p[0], "chroot") && p[1] && !p[2])
@@ -6554,7 +6549,7 @@
     else if (streq(p[0], "verb") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MESSAGES);
-        options->verbosity = positive_atoi(p[1]);
+        options->verbosity = positive_atoi(p[1], msglevel);
         if (options->verbosity >= (D_TLS_DEBUG_MED & M_DEBUG_LEVEL))
         {
             /* We pass this flag to the SSL library to avoid
@@ -6573,7 +6568,7 @@
     else if (streq(p[0], "mute") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MESSAGES);
-        options->mute = positive_atoi(p[1]);
+        options->mute = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "errors-to-stderr") && !p[1])
     {
@@ -6586,7 +6581,7 @@
         options->status_file = p[1];
         if (p[2])
         {
-            options->status_file_update_freq = positive_atoi(p[2]);
+            options->status_file_update_freq = positive_atoi(p[2], msglevel);
         }
     }
     else if (streq(p[0], "status-version") && p[1] && !p[2])
@@ -6594,7 +6589,7 @@
         int version;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        version = atoi(p[1]);
+        version = atoi_warn(p[1], msglevel);
         if (version < 1 || version > 3)
         {
             msg(msglevel, "--status-version must be 1 to 3");
@@ -6622,17 +6617,17 @@
     else if ((streq(p[0], "link-mtu") || streq(p[0], "udp-mtu")) && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        options->ce.link_mtu = positive_atoi(p[1]);
+        options->ce.link_mtu = positive_atoi(p[1], msglevel);
         options->ce.link_mtu_defined = true;
     }
     else if (streq(p[0], "tun-mtu") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);
-        options->ce.tun_mtu = positive_atoi(p[1]);
+        options->ce.tun_mtu = positive_atoi(p[1], msglevel);
         options->ce.tun_mtu_defined = true;
         if (p[2])
         {
-            options->ce.occ_mtu = positive_atoi(p[2]);
+            options->ce.occ_mtu = positive_atoi(p[2], msglevel);
         }
         else
         {
@@ -6642,7 +6637,7 @@
     else if (streq(p[0], "tun-mtu-max") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        int max_mtu = positive_atoi(p[1]);
+        int max_mtu = positive_atoi(p[1], msglevel);
         if (max_mtu < 68 || max_mtu > 65536)
         {
             msg(msglevel, "--tun-mtu-max value '%s' is invalid", p[1]);
@@ -6655,13 +6650,13 @@
     else if (streq(p[0], "tun-mtu-extra") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        options->ce.tun_mtu_extra = positive_atoi(p[1]);
+        options->ce.tun_mtu_extra = positive_atoi(p[1], msglevel);
         options->ce.tun_mtu_extra_defined = true;
     }
     else if (streq(p[0], "max-packet-size") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        int maxmtu = positive_atoi(p[1]);
+        int maxmtu = positive_atoi(p[1], msglevel);
         options->ce.tls_mtu = constrain_int(maxmtu, TLS_CHANNEL_MTU_MIN, TLS_CHANNEL_BUF_SIZE);
 
         if (maxmtu < TLS_CHANNEL_MTU_MIN || maxmtu > TLS_CHANNEL_BUF_SIZE)
@@ -6687,7 +6682,7 @@
     else if (streq(p[0], "fragment") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        options->ce.fragment = positive_atoi(p[1]);
+        options->ce.fragment = positive_atoi(p[1], msglevel);
 
         if (options->ce.fragment < 68)
         {
@@ -6718,23 +6713,23 @@
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
-        options->nice = atoi(p[1]);
+        options->nice = atoi_warn(p[1], msglevel);
     }
     else if (streq(p[0], "rcvbuf") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_SOCKBUF);
-        options->rcvbuf = positive_atoi(p[1]);
+        options->rcvbuf = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "sndbuf") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_SOCKBUF);
-        options->sndbuf = positive_atoi(p[1]);
+        options->sndbuf = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "mark") && p[1] && !p[2])
     {
 #if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->mark = atoi(p[1]);
+        options->mark = atoi_warn(p[1], msglevel);
 #endif
     }
     else if (streq(p[0], "socket-flags"))
@@ -6764,7 +6759,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
 #ifdef TARGET_LINUX
-        options->tuntap_options.txqueuelen = positive_atoi(p[1]);
+        options->tuntap_options.txqueuelen = positive_atoi(p[1], msglevel);
 #else
         msg(msglevel, "--txqueuelen not supported on this OS");
         goto err;
@@ -6775,7 +6770,7 @@
         int shaper;
 
         VERIFY_PERMISSION(OPT_P_SHAPER);
-        shaper = atoi(p[1]);
+        shaper = atoi_warn(p[1], msglevel);
         if (shaper < SHAPER_MIN || shaper > SHAPER_MAX)
         {
             msg(msglevel, "Bad shaper value, must be between %d and %d",
@@ -6823,7 +6818,7 @@
     else if (streq(p[0], "inactive") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->inactivity_timeout = positive_atoi(p[1]);
+        options->inactivity_timeout = positive_atoi(p[1], msglevel);
         if (p[2])
         {
             int64_t val = atoll(p[2]);
@@ -6841,7 +6836,7 @@
     else if (streq(p[0], "session-timeout") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->session_timeout = positive_atoi(p[1]);
+        options->session_timeout = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "proto") && p[1] && !p[2])
     {
@@ -7008,24 +7003,24 @@
     else if (streq(p[0], "keepalive") && p[1] && p[2] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->keepalive_ping = atoi(p[1]);
-        options->keepalive_timeout = atoi(p[2]);
+        options->keepalive_ping = atoi_warn(p[1], msglevel);
+        options->keepalive_timeout = atoi_warn(p[2], msglevel);
     }
     else if (streq(p[0], "ping") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_send_timeout = positive_atoi(p[1]);
+        options->ping_send_timeout = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "ping-exit") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_rec_timeout = positive_atoi(p[1]);
+        options->ping_rec_timeout = positive_atoi(p[1], msglevel);
         options->ping_rec_timeout_action = PING_EXIT;
     }
     else if (streq(p[0], "ping-restart") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_rec_timeout = positive_atoi(p[1]);
+        options->ping_rec_timeout = positive_atoi(p[1], msglevel);
         options->ping_rec_timeout_action = PING_RESTART;
     }
     else if (streq(p[0], "ping-timer-rem") && !p[1])
@@ -7038,7 +7033,7 @@
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_EXPLICIT_NOTIFY);
         if (p[1])
         {
-            options->ce.explicit_exit_notification = positive_atoi(p[1]);
+            options->ce.explicit_exit_notification = positive_atoi(p[1], msglevel);
         }
         else
         {
@@ -7158,7 +7153,7 @@
     else if (streq(p[0], "route-metric") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        options->route_default_metric = positive_atoi(p[1]);
+        options->route_default_metric = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "route-delay") && !p[3])
     {
@@ -7166,10 +7161,10 @@
         options->route_delay_defined = true;
         if (p[1])
         {
-            options->route_delay = positive_atoi(p[1]);
+            options->route_delay = positive_atoi(p[1], msglevel);
             if (p[2])
             {
-                options->route_delay_window = positive_atoi(p[2]);
+                options->route_delay_window = positive_atoi(p[2], msglevel);
             }
         }
         else
@@ -7334,7 +7329,7 @@
         }
         else if (streq(p[1], "SERVER_POLL_TIMEOUT") && p[2])
         {
-            options->ce.connect_timeout = positive_atoi(p[2]);
+            options->ce.connect_timeout = positive_atoi(p[2], msglevel);
         }
         else
         {
@@ -7366,14 +7361,14 @@
     else if (streq(p[0], "script-security") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        script_security_set(atoi(p[1]));
+        script_security_set(atoi_warn(p[1], msglevel));
     }
     else if (streq(p[0], "mssfix") && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
         if (p[1])
         {
-            int mssfix = positive_atoi(p[1]);
+            int mssfix = positive_atoi(p[1], msglevel);
             /* can be 0, but otherwise it needs to be high enough so we can
              * substract room for headers. */
             if (mssfix != 0
@@ -7556,7 +7551,7 @@
         options->ifconfig_pool_persist_filename = p[1];
         if (p[2])
         {
-            options->ifconfig_pool_persist_refresh_freq = positive_atoi(p[2]);
+            options->ifconfig_pool_persist_refresh_freq = positive_atoi(p[2], msglevel);
         }
     }
     else if (streq(p[0], "ifconfig-ipv6-pool") && p[1] && !p[2])
@@ -7588,8 +7583,8 @@
         int real, virtual;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        real = atoi(p[1]);
-        virtual = atoi(p[2]);
+        real = atoi_warn(p[1], msglevel);
+        virtual = atoi_warn(p[2], msglevel);
         if (real < 1 || virtual < 1)
         {
             msg(msglevel, "--hash-size sizes must be >= 1 (preferably a power of 2)");
@@ -7603,8 +7598,8 @@
         int cf_max, cf_per;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cf_max = atoi(p[1]);
-        cf_per = atoi(p[2]);
+        cf_max = atoi_warn(p[1], msglevel);
+        cf_per = atoi_warn(p[2], msglevel);
         if (cf_max < 0 || cf_per < 0)
         {
             msg(msglevel, "--connect-freq parms must be > 0");
@@ -7634,7 +7629,7 @@
         int max_clients;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        max_clients = atoi(p[1]);
+        max_clients = atoi_warn(p[1], msglevel);
         if (max_clients < 0)
         {
             msg(msglevel, "--max-clients must be at least 1");
@@ -7650,7 +7645,7 @@
     else if (streq(p[0], "max-routes-per-client") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INHERIT);
-        options->max_routes_per_client = max_int(atoi(p[1]), 1);
+        options->max_routes_per_client = max_int(positive_atoi(p[1], msglevel), 1);
     }
     else if (streq(p[0], "client-cert-not-required") && !p[1])
     {
@@ -7734,14 +7729,14 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->auth_token_generate = true;
-        options->auth_token_lifetime = p[1] ? positive_atoi(p[1]) : 0;
+        options->auth_token_lifetime = p[1] ? positive_atoi(p[1], msglevel) : 0;
 
         for (int i = 2; i < MAX_PARMS && p[i] != NULL; i++)
         {
             /* the second parameter can be the renewal time */
-            if (i == 2 && positive_atoi(p[i]))
+            if (i == 2 && valid_integer(p[i], true))
             {
-                options->auth_token_renewal = positive_atoi(p[i]);
+                options->auth_token_renewal = positive_atoi(p[i], msglevel);
             }
             else if (streq(p[i], "external-auth"))
             {
@@ -7821,7 +7816,7 @@
         int n_bcast_buf;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        n_bcast_buf = atoi(p[1]);
+        n_bcast_buf = atoi_warn(p[1], msglevel);
         if (n_bcast_buf < 1)
         {
             msg(msglevel, "--bcast-buffers parameter must be > 0");
@@ -7833,7 +7828,7 @@
         int tcp_queue_limit;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        tcp_queue_limit = atoi(p[1]);
+        tcp_queue_limit = atoi_warn(p[1], msglevel);
         if (tcp_queue_limit < 1)
         {
             msg(msglevel, "--tcp-queue-limit parameter must be > 0");
@@ -7964,10 +7959,10 @@
         int ageing_time, check_interval;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ageing_time = atoi(p[1]);
+        ageing_time = atoi_warn(p[1], msglevel);
         if (p[2])
         {
-            check_interval = atoi(p[2]);
+            check_interval = atoi_warn(p[2], msglevel);
         }
         else
         {
@@ -7996,7 +7991,7 @@
     else if (streq(p[0], "push-continuation") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_PULL_MODE);
-        options->push_continuation = atoi(p[1]);
+        options->push_continuation = atoi_warn(p[1], msglevel);
     }
     else if (streq(p[0], "auth-user-pass") && !p[2])
     {
@@ -8021,7 +8016,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sc_info.challenge_text = p[1];
-        if (atoi(p[2]))
+        if (atoi_warn(p[2], msglevel))
         {
             options->sc_info.flags |= SC_ECHO;
         }
@@ -8117,7 +8112,7 @@
             {
                 if (!streq(p[2], "default"))
                 {
-                    int offset = atoi(p[2]);
+                    int offset = atoi_warn(p[2], msglevel);
 
                     if (!(offset > -256 && offset < 256))
                     {
@@ -8133,7 +8128,7 @@
                 {
                     const int min_lease = 30;
                     int lease_time;
-                    lease_time = atoi(p[3]);
+                    lease_time = atoi_warn(p[3], msglevel);
                     if (lease_time < min_lease)
                     {
                         msg(msglevel, "--ip-win32 dynamic [offset] [lease-time]: lease time parameter (%d) must be at least %d seconds", lease_time, min_lease);
@@ -8257,7 +8252,7 @@
         else if (streq(p[1], "NBT") && p[2] && !p[3])
         {
             int t;
-            t = atoi(p[2]);
+            t = atoi_warn(p[2], msglevel);
             if (!(t == 1 || t == 2 || t == 4 || t == 8))
             {
                 msg(msglevel, "--dhcp-option NBT: parameter (%d) must be 1, 2, 4, or 8", t);
@@ -8315,7 +8310,7 @@
 #if defined(TARGET_ANDROID)
         else if (streq(p[1], "PROXY_HTTP") && p[3] && !p[4])
         {
-            o->http_proxy_port = atoi(p[3]);
+            o->http_proxy_port = positiove_atoi(p[3], msglevel);
             o->http_proxy = p[2];
         }
 #endif
@@ -8349,7 +8344,7 @@
     {
         int s;
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        s = atoi(p[1]);
+        s = atoi_warn(p[1], msglevel);
         if (s < 0 || s >= 256)
         {
             msg(msglevel, "--tap-sleep parameter must be between 0 and 255");
@@ -8432,7 +8427,7 @@
         options->exit_event_name = p[1];
         if (p[2])
         {
-            options->exit_event_initial_state = (atoi(p[2]) != 0);
+            options->exit_event_initial_state = (atoi_warn(p[2], msglevel) != 0);
         }
     }
     else if (streq(p[0], "allow-nonadmin") && !p[2])
@@ -8799,7 +8794,7 @@
         {
             int replay_window;
 
-            replay_window = atoi(p[1]);
+            replay_window = atoi_warn(p[1], msglevel);
             if (!(MIN_SEQ_BACKTRACK <= replay_window && replay_window <= MAX_SEQ_BACKTRACK))
             {
                 msg(msglevel, "replay-window window size parameter (%d) must be between %d and %d",
@@ -8814,7 +8809,7 @@
             {
                 int replay_time;
 
-                replay_time = atoi(p[2]);
+                replay_time = atoi_warn(p[2], msglevel);
                 if (!(MIN_TIME_BACKTRACK <= replay_time && replay_time <= MAX_TIME_BACKTRACK))
                 {
                     msg(msglevel, "replay-window time window parameter (%d) must be between %d and %d",
@@ -9256,7 +9251,7 @@
     else if (streq(p[0], "tls-timeout") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->tls_timeout = positive_atoi(p[1]);
+        options->tls_timeout = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
@@ -9285,21 +9280,21 @@
     else if (streq(p[0], "reneg-sec") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->renegotiate_seconds = positive_atoi(p[1]);
+        options->renegotiate_seconds = positive_atoi(p[1], msglevel);
         if (p[2])
         {
-            options->renegotiate_seconds_min = positive_atoi(p[2]);
+            options->renegotiate_seconds_min = positive_atoi(p[2], msglevel);
         }
     }
     else if (streq(p[0], "hand-window") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->handshake_window = positive_atoi(p[1]);
+        options->handshake_window = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "tran-window") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->transition_window = positive_atoi(p[1]);
+        options->transition_window = positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "tls-auth") && p[1] && !p[3])
     {
@@ -9436,7 +9431,7 @@
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
         char *provider =  p[1];
-        bool cert_private = (p[2] == NULL ? false : ( atoi(p[2]) != 0 ));
+        bool cert_private = (p[2] == NULL ? false : (atoi_warn(p[2], msglevel) != 0 ));
 
 #ifdef DEFAULT_PKCS11_MODULE
         if (!provider)
@@ -9488,7 +9483,7 @@
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
-            options->pkcs11_protected_authentication[j-1] = atoi(p[j]) != 0 ? 1 : 0;
+            options->pkcs11_protected_authentication[j-1] = atoi_warn(p[j], msglevel) != 0 ? 1 : 0;
         }
     }
     else if (streq(p[0], "pkcs11-private-mode") && p[1])
@@ -9510,13 +9505,13 @@
 
         for (j = 1; j < MAX_PARMS && p[j] != NULL; ++j)
         {
-            options->pkcs11_cert_private[j-1] = atoi(p[j]) != 0 ? 1 : 0;
+            options->pkcs11_cert_private[j-1] = (bool) (atoi_warn(p[j], msglevel));
         }
     }
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->pkcs11_pin_cache_period = atoi(p[1]);
+        options->pkcs11_pin_cache_period = atoi_warn(p[1], msglevel);
     }
     else if (streq(p[0], "pkcs11-id") && p[1] && !p[2])
     {
@@ -9545,12 +9540,12 @@
     {
         VERIFY_PERMISSION(OPT_P_PEER_ID);
         options->use_peer_id = true;
-        options->peer_id = atoi(p[1]);
+        options->peer_id = atoi_warn(p[1], msglevel);
     }
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
-        int ekm_length = positive_atoi(p[2]);
+        int ekm_length = positive_atoi(p[2], msglevel);
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
 
@@ -9609,7 +9604,7 @@
     else if (streq(p[0], "vlan-pvid") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
-        options->vlan_pvid = positive_atoi(p[1]);
+        options->vlan_pvid = positive_atoi(p[1], msglevel);
         if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID
             || options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
         {
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index a9e020a..fea4c3d 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -98,3 +98,50 @@
     gc_free(&gc);
     return message;
 }
+
+bool
+valid_integer(const char *str, bool positive)
+{
+    char *endptr;
+    long long i = strtoll(str, &endptr, 10);
+
+    if (i < INT_MIN || (positive && i < 0) || *endptr != '\0' || i > INT_MAX)
+    {
+        return false;
+    }
+    else
+    {
+        return true;
+    }
+}
+
+int
+positive_atoi(const char *str, int msglevel)
+{
+    char *endptr;
+    long long i = strtoll(str, &endptr, 10);
+
+    if (i < 0 || *endptr != '\0' || i > INT_MAX)
+    {
+        msg(msglevel, "Cannot parse argument '%s' as non-negative integer",
+            str);
+        i = 0;
+    }
+
+    return (int) i;
+}
+
+int
+atoi_warn(const char *str, int msglevel)
+{
+    char *endptr;
+    long long i = strtoll(str, &endptr, 10);
+
+    if (i < INT_MIN || *endptr != '\0' || i > INT_MAX)
+    {
+        msg(msglevel, "Cannot parse argument '%s' as integer", str);
+        i = 0;
+    }
+
+    return (int) i;
+}
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 29bc9dc..f34d997 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -30,4 +30,24 @@
 const char *
 parse_auth_failed_temp(struct options *o, const char *reason);
 
-#endif
+
+/** Checks if the string is a valid integer by checking if it can be
+ *  converted to an integer */
+bool
+valid_integer(const char *str, bool positive);
+
+/**
+ * Converts a str to a positive number if the string represents a postive
+ * integer number. Otherwise print a warning with msglevel and return 0
+ */
+int
+positive_atoi(const char *str, int msglevel);
+
+/**
+ * Converts a str to an integer if the string can be represented as an
+ * integer number. Otherwise print a warning with msglevel and return 0
+ */
+int
+atoi_warn(const char *str, int msglevel);
+
+#endif /* ifndef OPTIONS_UTIL_H_ */

