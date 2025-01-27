From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 27 Jan 2025 12:01:41 +0000
In-Reply-To: <gerrit.1737460984000.Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de@...2715...>
References: <gerrit.1737460984000.Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <7800acb498a73820a96e49bc0b74057afcd87920-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XHJ8uaMC1mo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Print
 warnings/errors when numerical parameters cannot be parsed
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

--XHJ8uaMC1mo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/873?usp=3Demail

to look at the new patch set (#7).

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Print warnings/errors when numerical parameters cannot be p=
arsed
......................................................................

Print warnings/errors when numerical parameters cannot be parsed

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
---
M src/openvpn/options.c
M src/openvpn/options_util.c
M src/openvpn/options_util.h
3 files changed, 144 insertions(+), 82 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/873/7

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
-    const int i =3D atoi(str);
-    return i < 0 ? 0 : i;
-}
-
 #ifdef _WIN32  /* This function is only used when compiling on Windows */
 static unsigned int
 atou(const char *str)
@@ -6043,7 +6038,7 @@
         int cache;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cache =3D atoi(p[1]);
+        cache =3D atoi_warn(p[1], msglevel);
         if (cache < 1)
         {
             msg(msglevel, "--management-log-cache parameter is out of rang=
e");
@@ -6355,7 +6350,7 @@
         }
         else
         {
-            options->resolve_retry_seconds =3D positive_atoi(p[1]);
+            options->resolve_retry_seconds =3D positive_atoi(p[1], msgleve=
l);
         }
     }
     else if ((streq(p[0], "preresolve") || streq(p[0], "ip-remote-hint")) =
&& !p[2])
@@ -6372,7 +6367,7 @@
     else if (streq(p[0], "connect-retry") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->ce.connect_retry_seconds =3D positive_atoi(p[1]);
+        options->ce.connect_retry_seconds =3D positive_atoi(p[1], msglevel=
);
         /*
          * Limit the base value of retry wait interval to 16 bits to avoid
          * overflow when scaled up for exponential backoff
@@ -6387,19 +6382,19 @@
         if (p[2])
         {
             options->ce.connect_retry_seconds_max =3D
-                max_int(positive_atoi(p[2]), options->ce.connect_retry_sec=
onds);
+                max_int(positive_atoi(p[2], msglevel), options->ce.connect=
_retry_seconds);
         }
     }
     else if ((streq(p[0], "connect-timeout") || streq(p[0], "server-poll-t=
imeout"))
              && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->ce.connect_timeout =3D positive_atoi(p[1]);
+        options->ce.connect_timeout =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "connect-retry-max") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->connect_retry_max =3D positive_atoi(p[1]);
+        options->connect_retry_max =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "ipchange") && p[1])
     {
@@ -6422,7 +6417,7 @@
     else if (streq(p[0], "gremlin") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->gremlin =3D positive_atoi(p[1]);
+        options->gremlin =3D positive_atoi(p[1], msglevel);
     }
 #endif
     else if (streq(p[0], "chroot") && p[1] && !p[2])
@@ -6554,7 +6549,7 @@
     else if (streq(p[0], "verb") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MESSAGES);
-        options->verbosity =3D positive_atoi(p[1]);
+        options->verbosity =3D positive_atoi(p[1], msglevel);
         if (options->verbosity >=3D (D_TLS_DEBUG_MED & M_DEBUG_LEVEL))
         {
             /* We pass this flag to the SSL library to avoid
@@ -6573,7 +6568,7 @@
     else if (streq(p[0], "mute") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MESSAGES);
-        options->mute =3D positive_atoi(p[1]);
+        options->mute =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "errors-to-stderr") && !p[1])
     {
@@ -6586,7 +6581,7 @@
         options->status_file =3D p[1];
         if (p[2])
         {
-            options->status_file_update_freq =3D positive_atoi(p[2]);
+            options->status_file_update_freq =3D positive_atoi(p[2], msgle=
vel);
         }
     }
     else if (streq(p[0], "status-version") && p[1] && !p[2])
@@ -6594,7 +6589,7 @@
         int version;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        version =3D atoi(p[1]);
+        version =3D atoi_warn(p[1], msglevel);
         if (version < 1 || version > 3)
         {
             msg(msglevel, "--status-version must be 1 to 3");
@@ -6622,17 +6617,17 @@
     else if ((streq(p[0], "link-mtu") || streq(p[0], "udp-mtu")) && p[1] &=
& !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        options->ce.link_mtu =3D positive_atoi(p[1]);
+        options->ce.link_mtu =3D positive_atoi(p[1], msglevel);
         options->ce.link_mtu_defined =3D true;
     }
     else if (streq(p[0], "tun-mtu") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);
-        options->ce.tun_mtu =3D positive_atoi(p[1]);
+        options->ce.tun_mtu =3D positive_atoi(p[1], msglevel);
         options->ce.tun_mtu_defined =3D true;
         if (p[2])
         {
-            options->ce.occ_mtu =3D positive_atoi(p[2]);
+            options->ce.occ_mtu =3D positive_atoi(p[2], msglevel);
         }
         else
         {
@@ -6642,7 +6637,7 @@
     else if (streq(p[0], "tun-mtu-max") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        int max_mtu =3D positive_atoi(p[1]);
+        int max_mtu =3D positive_atoi(p[1], msglevel);
         if (max_mtu < 68 || max_mtu > 65536)
         {
             msg(msglevel, "--tun-mtu-max value '%s' is invalid", p[1]);
@@ -6655,13 +6650,13 @@
     else if (streq(p[0], "tun-mtu-extra") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        options->ce.tun_mtu_extra =3D positive_atoi(p[1]);
+        options->ce.tun_mtu_extra =3D positive_atoi(p[1], msglevel);
         options->ce.tun_mtu_extra_defined =3D true;
     }
     else if (streq(p[0], "max-packet-size") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        int maxmtu =3D positive_atoi(p[1]);
+        int maxmtu =3D positive_atoi(p[1], msglevel);
         options->ce.tls_mtu =3D constrain_int(maxmtu, TLS_CHANNEL_MTU_MIN,=
 TLS_CHANNEL_BUF_SIZE);

         if (maxmtu < TLS_CHANNEL_MTU_MIN || maxmtu > TLS_CHANNEL_BUF_SIZE)
@@ -6687,7 +6682,7 @@
     else if (streq(p[0], "fragment") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        options->ce.fragment =3D positive_atoi(p[1]);
+        options->ce.fragment =3D positive_atoi(p[1], msglevel);

         if (options->ce.fragment < 68)
         {
@@ -6718,23 +6713,23 @@
     else if (streq(p[0], "nice") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_NICE);
-        options->nice =3D atoi(p[1]);
+        options->nice =3D atoi_warn(p[1], msglevel);
     }
     else if (streq(p[0], "rcvbuf") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_SOCKBUF);
-        options->rcvbuf =3D positive_atoi(p[1]);
+        options->rcvbuf =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "sndbuf") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_SOCKBUF);
-        options->sndbuf =3D positive_atoi(p[1]);
+        options->sndbuf =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "mark") && p[1] && !p[2])
     {
 #if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->mark =3D atoi(p[1]);
+        options->mark =3D atoi_warn(p[1], msglevel);
 #endif
     }
     else if (streq(p[0], "socket-flags"))
@@ -6764,7 +6759,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
 #ifdef TARGET_LINUX
-        options->tuntap_options.txqueuelen =3D positive_atoi(p[1]);
+        options->tuntap_options.txqueuelen =3D positive_atoi(p[1], msgleve=
l);
 #else
         msg(msglevel, "--txqueuelen not supported on this OS");
         goto err;
@@ -6775,7 +6770,7 @@
         int shaper;

         VERIFY_PERMISSION(OPT_P_SHAPER);
-        shaper =3D atoi(p[1]);
+        shaper =3D atoi_warn(p[1], msglevel);
         if (shaper < SHAPER_MIN || shaper > SHAPER_MAX)
         {
             msg(msglevel, "Bad shaper value, must be between %d and %d",
@@ -6823,7 +6818,7 @@
     else if (streq(p[0], "inactive") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->inactivity_timeout =3D positive_atoi(p[1]);
+        options->inactivity_timeout =3D positive_atoi(p[1], msglevel);
         if (p[2])
         {
             int64_t val =3D atoll(p[2]);
@@ -6841,7 +6836,7 @@
     else if (streq(p[0], "session-timeout") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->session_timeout =3D positive_atoi(p[1]);
+        options->session_timeout =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "proto") && p[1] && !p[2])
     {
@@ -7008,24 +7003,24 @@
     else if (streq(p[0], "keepalive") && p[1] && p[2] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->keepalive_ping =3D atoi(p[1]);
-        options->keepalive_timeout =3D atoi(p[2]);
+        options->keepalive_ping =3D atoi_warn(p[1], msglevel);
+        options->keepalive_timeout =3D atoi_warn(p[2], msglevel);
     }
     else if (streq(p[0], "ping") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_send_timeout =3D positive_atoi(p[1]);
+        options->ping_send_timeout =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "ping-exit") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_rec_timeout =3D positive_atoi(p[1]);
+        options->ping_rec_timeout =3D positive_atoi(p[1], msglevel);
         options->ping_rec_timeout_action =3D PING_EXIT;
     }
     else if (streq(p[0], "ping-restart") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->ping_rec_timeout =3D positive_atoi(p[1]);
+        options->ping_rec_timeout =3D positive_atoi(p[1], msglevel);
         options->ping_rec_timeout_action =3D PING_RESTART;
     }
     else if (streq(p[0], "ping-timer-rem") && !p[1])
@@ -7038,7 +7033,7 @@
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_EXPLICIT_NO=
TIFY);
         if (p[1])
         {
-            options->ce.explicit_exit_notification =3D positive_atoi(p[1]);
+            options->ce.explicit_exit_notification =3D positive_atoi(p[1],=
 msglevel);
         }
         else
         {
@@ -7158,7 +7153,7 @@
     else if (streq(p[0], "route-metric") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        options->route_default_metric =3D positive_atoi(p[1]);
+        options->route_default_metric =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "route-delay") && !p[3])
     {
@@ -7166,10 +7161,10 @@
         options->route_delay_defined =3D true;
         if (p[1])
         {
-            options->route_delay =3D positive_atoi(p[1]);
+            options->route_delay =3D positive_atoi(p[1], msglevel);
             if (p[2])
             {
-                options->route_delay_window =3D positive_atoi(p[2]);
+                options->route_delay_window =3D positive_atoi(p[2], msglev=
el);
             }
         }
         else
@@ -7334,7 +7329,7 @@
         }
         else if (streq(p[1], "SERVER_POLL_TIMEOUT") && p[2])
         {
-            options->ce.connect_timeout =3D positive_atoi(p[2]);
+            options->ce.connect_timeout =3D positive_atoi(p[2], msglevel);
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
-            int mssfix =3D positive_atoi(p[1]);
+            int mssfix =3D positive_atoi(p[1], msglevel);
             /* can be 0, but otherwise it needs to be high enough so we can
              * substract room for headers. */
             if (mssfix !=3D 0
@@ -7556,7 +7551,7 @@
         options->ifconfig_pool_persist_filename =3D p[1];
         if (p[2])
         {
-            options->ifconfig_pool_persist_refresh_freq =3D positive_atoi(=
p[2]);
+            options->ifconfig_pool_persist_refresh_freq =3D positive_atoi(=
p[2], msglevel);
         }
     }
     else if (streq(p[0], "ifconfig-ipv6-pool") && p[1] && !p[2])
@@ -7588,8 +7583,8 @@
         int real, virtual;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        real =3D atoi(p[1]);
-        virtual =3D atoi(p[2]);
+        real =3D atoi_warn(p[1], msglevel);
+        virtual =3D atoi_warn(p[2], msglevel);
         if (real < 1 || virtual < 1)
         {
             msg(msglevel, "--hash-size sizes must be >=3D 1 (preferably a =
power of 2)");
@@ -7603,8 +7598,8 @@
         int cf_max, cf_per;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cf_max =3D atoi(p[1]);
-        cf_per =3D atoi(p[2]);
+        cf_max =3D atoi_warn(p[1], msglevel);
+        cf_per =3D atoi_warn(p[2], msglevel);
         if (cf_max < 0 || cf_per < 0)
         {
             msg(msglevel, "--connect-freq parms must be > 0");
@@ -7634,7 +7629,7 @@
         int max_clients;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        max_clients =3D atoi(p[1]);
+        max_clients =3D atoi_warn(p[1], msglevel);
         if (max_clients < 0)
         {
             msg(msglevel, "--max-clients must be at least 1");
@@ -7650,7 +7645,7 @@
     else if (streq(p[0], "max-routes-per-client") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INHERIT);
-        options->max_routes_per_client =3D max_int(atoi(p[1]), 1);
+        options->max_routes_per_client =3D max_int(positive_atoi(p[1], msg=
level), 1);
     }
     else if (streq(p[0], "client-cert-not-required") && !p[1])
     {
@@ -7734,14 +7729,14 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->auth_token_generate =3D true;
-        options->auth_token_lifetime =3D p[1] ? positive_atoi(p[1]) : 0;
+        options->auth_token_lifetime =3D p[1] ? positive_atoi(p[1], msglev=
el) : 0;

         for (int i =3D 2; i < MAX_PARMS && p[i] !=3D NULL; i++)
         {
             /* the second parameter can be the renewal time */
-            if (i =3D=3D 2 && positive_atoi(p[i]))
+            if (i =3D=3D 2 && valid_integer(p[i], true))
             {
-                options->auth_token_renewal =3D positive_atoi(p[i]);
+                options->auth_token_renewal =3D positive_atoi(p[i], msglev=
el);
             }
             else if (streq(p[i], "external-auth"))
             {
@@ -7821,7 +7816,7 @@
         int n_bcast_buf;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        n_bcast_buf =3D atoi(p[1]);
+        n_bcast_buf =3D atoi_warn(p[1], msglevel);
         if (n_bcast_buf < 1)
         {
             msg(msglevel, "--bcast-buffers parameter must be > 0");
@@ -7833,7 +7828,7 @@
         int tcp_queue_limit;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        tcp_queue_limit =3D atoi(p[1]);
+        tcp_queue_limit =3D atoi_warn(p[1], msglevel);
         if (tcp_queue_limit < 1)
         {
             msg(msglevel, "--tcp-queue-limit parameter must be > 0");
@@ -7964,10 +7959,10 @@
         int ageing_time, check_interval;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ageing_time =3D atoi(p[1]);
+        ageing_time =3D atoi_warn(p[1], msglevel);
         if (p[2])
         {
-            check_interval =3D atoi(p[2]);
+            check_interval =3D atoi_warn(p[2], msglevel);
         }
         else
         {
@@ -7996,7 +7991,7 @@
     else if (streq(p[0], "push-continuation") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_PULL_MODE);
-        options->push_continuation =3D atoi(p[1]);
+        options->push_continuation =3D atoi_warn(p[1], msglevel);
     }
     else if (streq(p[0], "auth-user-pass") && !p[2])
     {
@@ -8021,7 +8016,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sc_info.challenge_text =3D p[1];
-        if (atoi(p[2]))
+        if (atoi_warn(p[2], msglevel))
         {
             options->sc_info.flags |=3D SC_ECHO;
         }
@@ -8117,7 +8112,7 @@
             {
                 if (!streq(p[2], "default"))
                 {
-                    int offset =3D atoi(p[2]);
+                    int offset =3D atoi_warn(p[2], msglevel);

                     if (!(offset > -256 && offset < 256))
                     {
@@ -8133,7 +8128,7 @@
                 {
                     const int min_lease =3D 30;
                     int lease_time;
-                    lease_time =3D atoi(p[3]);
+                    lease_time =3D atoi_warn(p[3], msglevel);
                     if (lease_time < min_lease)
                     {
                         msg(msglevel, "--ip-win32 dynamic [offset] [lease-=
time]: lease time parameter (%d) must be at least %d seconds", lease_time, =
min_lease);
@@ -8257,7 +8252,7 @@
         else if (streq(p[1], "NBT") && p[2] && !p[3])
         {
             int t;
-            t =3D atoi(p[2]);
+            t =3D atoi_warn(p[2], msglevel);
             if (!(t =3D=3D 1 || t =3D=3D 2 || t =3D=3D 4 || t =3D=3D 8))
             {
                 msg(msglevel, "--dhcp-option NBT: parameter (%d) must be 1=
, 2, 4, or 8", t);
@@ -8315,7 +8310,7 @@
 #if defined(TARGET_ANDROID)
         else if (streq(p[1], "PROXY_HTTP") && p[3] && !p[4])
         {
-            o->http_proxy_port =3D atoi(p[3]);
+            o->http_proxy_port =3D positiove_atoi(p[3], msglevel);
             o->http_proxy =3D p[2];
         }
 #endif
@@ -8349,7 +8344,7 @@
     {
         int s;
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        s =3D atoi(p[1]);
+        s =3D atoi_warn(p[1], msglevel);
         if (s < 0 || s >=3D 256)
         {
             msg(msglevel, "--tap-sleep parameter must be between 0 and 255=
");
@@ -8432,7 +8427,7 @@
         options->exit_event_name =3D p[1];
         if (p[2])
         {
-            options->exit_event_initial_state =3D (atoi(p[2]) !=3D 0);
+            options->exit_event_initial_state =3D (atoi_warn(p[2], msgleve=
l) !=3D 0);
         }
     }
     else if (streq(p[0], "allow-nonadmin") && !p[2])
@@ -8799,7 +8794,7 @@
         {
             int replay_window;

-            replay_window =3D atoi(p[1]);
+            replay_window =3D atoi_warn(p[1], msglevel);
             if (!(MIN_SEQ_BACKTRACK <=3D replay_window && replay_window <=
=3D MAX_SEQ_BACKTRACK))
             {
                 msg(msglevel, "replay-window window size parameter (%d) mu=
st be between %d and %d",
@@ -8814,7 +8809,7 @@
             {
                 int replay_time;

-                replay_time =3D atoi(p[2]);
+                replay_time =3D atoi_warn(p[2], msglevel);
                 if (!(MIN_TIME_BACKTRACK <=3D replay_time && replay_time <=
=3D MAX_TIME_BACKTRACK))
                 {
                     msg(msglevel, "replay-window time window parameter (%d=
) must be between %d and %d",
@@ -9256,7 +9251,7 @@
     else if (streq(p[0], "tls-timeout") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->tls_timeout =3D positive_atoi(p[1]);
+        options->tls_timeout =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
@@ -9285,21 +9280,21 @@
     else if (streq(p[0], "reneg-sec") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->renegotiate_seconds =3D positive_atoi(p[1]);
+        options->renegotiate_seconds =3D positive_atoi(p[1], msglevel);
         if (p[2])
         {
-            options->renegotiate_seconds_min =3D positive_atoi(p[2]);
+            options->renegotiate_seconds_min =3D positive_atoi(p[2], msgle=
vel);
         }
     }
     else if (streq(p[0], "hand-window") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->handshake_window =3D positive_atoi(p[1]);
+        options->handshake_window =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "tran-window") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->transition_window =3D positive_atoi(p[1]);
+        options->transition_window =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "tls-auth") && p[1] && !p[3])
     {
@@ -9436,7 +9431,7 @@
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
         char *provider =3D  p[1];
-        bool cert_private =3D (p[2] =3D=3D NULL ? false : ( atoi(p[2]) !=
=3D 0 ));
+        bool cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[2],=
 msglevel) !=3D 0 ));

 #ifdef DEFAULT_PKCS11_MODULE
         if (!provider)
@@ -9488,7 +9483,7 @@

         for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
         {
-            options->pkcs11_protected_authentication[j-1] =3D atoi(p[j]) !=
=3D 0 ? 1 : 0;
+            options->pkcs11_protected_authentication[j-1] =3D atoi_warn(p[=
j], msglevel) !=3D 0 ? 1 : 0;
         }
     }
     else if (streq(p[0], "pkcs11-private-mode") && p[1])
@@ -9510,13 +9505,13 @@

         for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
         {
-            options->pkcs11_cert_private[j-1] =3D atoi(p[j]) !=3D 0 ? 1 : =
0;
+            options->pkcs11_cert_private[j-1] =3D (bool) (atoi_warn(p[j], =
msglevel));
         }
     }
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->pkcs11_pin_cache_period =3D atoi(p[1]);
+        options->pkcs11_pin_cache_period =3D atoi_warn(p[1], msglevel);
     }
     else if (streq(p[0], "pkcs11-id") && p[1] && !p[2])
     {
@@ -9545,12 +9540,12 @@
     {
         VERIFY_PERMISSION(OPT_P_PEER_ID);
         options->use_peer_id =3D true;
-        options->peer_id =3D atoi(p[1]);
+        options->peer_id =3D atoi_warn(p[1], msglevel);
     }
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
     else if (streq(p[0], "keying-material-exporter") && p[1] && p[2])
     {
-        int ekm_length =3D positive_atoi(p[2]);
+        int ekm_length =3D positive_atoi(p[2], msglevel);

         VERIFY_PERMISSION(OPT_P_GENERAL);

@@ -9609,7 +9604,7 @@
     else if (streq(p[0], "vlan-pvid") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
-        options->vlan_pvid =3D positive_atoi(p[1]);
+        options->vlan_pvid =3D positive_atoi(p[1], msglevel);
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
+    long long i =3D strtoll(str, &endptr, 10);
+
+    if (i < INT_MIN || (positive && i < 0) || *endptr !=3D '\0' || i > INT=
_MAX)
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
+    long long i =3D strtoll(str, &endptr, 10);
+
+    if (i < 0 || *endptr !=3D '\0' || i > INT_MAX)
+    {
+        msg(msglevel, "Cannot parse argument '%s' as non-negative integer",
+            str);
+        i =3D 0;
+    }
+
+    return (int) i;
+}
+
+int
+atoi_warn(const char *str, int msglevel)
+{
+    char *endptr;
+    long long i =3D strtoll(str, &endptr, 10);
+
+    if (i < INT_MIN || *endptr !=3D '\0' || i > INT_MAX)
+    {
+        msg(msglevel, "Cannot parse argument '%s' as integer", str);
+        i =3D 0;
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/873?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de
Gerrit-Change-Number: 873
Gerrit-PatchSet: 7
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: newpatchset

--XHJ8uaMC1mo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #7</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/873?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Print warnings/errors when numerical parameters cann=
ot be parsed<br><br>Using the atoi method is a best effort method that pars=
es as much of the<br>input string as possible as integer and ignores the re=
st or return 0<br>if the string cannot be parsed. This is lead to unexpecte=
d results.<br><br>Change the behaviour by printing a warning in these cases=
 instead. When<br>parsing a configuration, these warnings will error out si=
nce the msglevel<br>is M_USAGE in this case. Example:<br><br>    ./src/open=
vpn/openvpn --resolv-retry 198jj<br>    Options error: Cannot parse argumen=
t &#39;198jj&#39; as non-negative integer<br><br>Reported-By: Anqi Chen &lt=
;chen.anqi3@...2855...&gt;<br>Reported-By: Cristina Nita-Rotaru &lt;c.nitar=
otaru@...2855...&gt;<br>Change-Id: Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4d=
e<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/op=
envpn/options.c<br>M src/openvpn/options_util.c<br>M src/openvpn/options_ut=
il.h<br>3 files changed, 144 insertions(+), 82 deletions(-)<br><br></pre><p=
re style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/873/7</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>in=
dex bd5c056..4510bea 100644</span><br><span>--- a/src/openvpn/options.c</sp=
an><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -60,6 +60,8 @@<=
/span><br><span> #include &quot;platform.h&quot;</span><br><span> #include =
&quot;xkey_common.h&quot;</span><br><span> #include &quot;dco.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options_ut=
il.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span> #include &lt;ctype.h&gt;</span><br><span> </span><br><span> #inclu=
de &quot;memdbg.h&quot;</span><br><span>@@ -5014,13 +5016,6 @@</span><br><s=
pan> }</span><br><span> #endif</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-positive_atoi(const char *str)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    const int i =3D atoi(str);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return i &lt; 0 ? 0 : i;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> #ifdef _WIN32  /* This function is only used when compil=
ing on Windows */</span><br><span> static unsigned int</span><br><span> ato=
u(const char *str)</span><br><span>@@ -6043,7 +6038,7 @@</span><br><span>  =
       int cache;</span><br><span> </span><br><span>         VERIFY_PERMISS=
ION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      cache =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cache =3D atoi_warn(p[1], msglevel);</span><br><span>      =
   if (cache &lt; 1)</span><br><span>         {</span><br><span>           =
  msg(msglevel, &quot;--management-log-cache parameter is out of range&quot=
;);</span><br><span>@@ -6355,7 +6350,7 @@</span><br><span>         }</span>=
<br><span>         else</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            options-&gt;resolve_retry_seconds =
=3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            options-&gt;resolve_retry_seconds =3D positive_atoi(p[1], =
msglevel);</span><br><span>         }</span><br><span>     }</span><br><spa=
n>     else if ((streq(p[0], &quot;preresolve&quot;) || streq(p[0], &quot;i=
p-remote-hint&quot;)) &amp;&amp; !p[2])</span><br><span>@@ -6372,7 +6367,7 =
@@</span><br><span>     else if (streq(p[0], &quot;connect-retry&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.connect_retry_secon=
ds =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        options-&gt;ce.connect_retry_seconds =3D positive_atoi(p[1]=
, msglevel);</span><br><span>         /*</span><br><span>          * Limit =
the base value of retry wait interval to 16 bits to avoid</span><br><span> =
         * overflow when scaled up for exponential backoff</span><br><span>=
@@ -6387,19 +6382,19 @@</span><br><span>         if (p[2])</span><br><span>=
         {</span><br><span>             options-&gt;ce.connect_retry_second=
s_max =3D</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    max_int(positive_atoi(p[2]), options-&gt;ce.connect_retry_seconds);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                max_int=
(positive_atoi(p[2], msglevel), options-&gt;ce.connect_retry_seconds);</spa=
n><br><span>         }</span><br><span>     }</span><br><span>     else if =
((streq(p[0], &quot;connect-timeout&quot;) || streq(p[0], &quot;server-poll=
-timeout&quot;))</span><br><span>              &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT=
_P_GENERAL|OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        options-&gt;ce.connect_timeout =3D positive_atoi(p[1]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ce.=
connect_timeout =3D positive_atoi(p[1], msglevel);</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;connect-retry-max&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        options-&gt;connect_retry_max =3D =
positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        options-&gt;connect_retry_max =3D positive_atoi(p[1], msglevel);</=
span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;ipcha=
nge&quot;) &amp;&amp; p[1])</span><br><span>     {</span><br><span>@@ -6422=
,7 +6417,7 @@</span><br><span>     else if (streq(p[0], &quot;gremlin&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        options-&gt;gremlin =3D positive_atoi(p[1]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;g=
remlin =3D positive_atoi(p[1], msglevel);</span><br><span>     }</span><br>=
<span> #endif</span><br><span>     else if (streq(p[0], &quot;chroot&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>@@ -6554,7 +6549,7 @@</s=
pan><br><span>     else if (streq(p[0], &quot;verb&quot;) &amp;&amp; p[1] &=
amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PER=
MISSION(OPT_P_MESSAGES);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        options-&gt;verbosity =3D positive_atoi(p[1]);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        options-&gt;verbosity =3D pos=
itive_atoi(p[1], msglevel);</span><br><span>         if (options-&gt;verbos=
ity &gt;=3D (D_TLS_DEBUG_MED &amp; M_DEBUG_LEVEL))</span><br><span>        =
 {</span><br><span>             /* We pass this flag to the SSL library to =
avoid</span><br><span>@@ -6573,7 +6568,7 @@</span><br><span>     else if (s=
treq(p[0], &quot;mute&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><s=
pan>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_MESSAGES);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;mute =
=3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        options-&gt;mute =3D positive_atoi(p[1], msglevel);</span><br>=
<span>     }</span><br><span>     else if (streq(p[0], &quot;errors-to-stde=
rr&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -6586=
,7 +6581,7 @@</span><br><span>         options-&gt;status_file =3D p[1];</s=
pan><br><span>         if (p[2])</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;status_file_u=
pdate_freq =3D positive_atoi(p[2]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            options-&gt;status_file_update_freq =3D positiv=
e_atoi(p[2], msglevel);</span><br><span>         }</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;status-version&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[2])</span><br><span>@@ -6594,7 +6589,7 @@</span><br=
><span>         int version;</span><br><span> </span><br><span>         VER=
IFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        version =3D atoi(p[1]);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        version =3D atoi_warn(p[1], msglevel);</span><=
br><span>         if (version &lt; 1 || version &gt; 3)</span><br><span>   =
      {</span><br><span>             msg(msglevel, &quot;--status-version m=
ust be 1 to 3&quot;);</span><br><span>@@ -6622,17 +6617,17 @@</span><br><sp=
an>     else if ((streq(p[0], &quot;link-mtu&quot;) || streq(p[0], &quot;ud=
p-mtu&quot;)) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</spa=
n><br><span>         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.link_m=
tu =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        options-&gt;ce.link_mtu =3D positive_atoi(p[1], msglevel);<=
/span><br><span>         options-&gt;ce.link_mtu_defined =3D true;</span><b=
r><span>     }</span><br><span>     else if (streq(p[0], &quot;tun-mtu&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span=
>         VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.tun_mtu =3D =
positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        options-&gt;ce.tun_mtu =3D positive_atoi(p[1], msglevel);</span><b=
r><span>         options-&gt;ce.tun_mtu_defined =3D true;</span><br><span> =
        if (p[2])</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            options-&gt;ce.occ_mtu =3D positive_atoi=
(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
options-&gt;ce.occ_mtu =3D positive_atoi(p[2], msglevel);</span><br><span> =
        }</span><br><span>         else</span><br><span>         {</span><b=
r><span>@@ -6642,7 +6637,7 @@</span><br><span>     else if (streq(p[0], &qu=
ot;tun-mtu-max&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>   =
  {</span><br><span>         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int max_mtu =
=3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        int max_mtu =3D positive_atoi(p[1], msglevel);</span><br><span=
>         if (max_mtu &lt; 68 || max_mtu &gt; 65536)</span><br><span>      =
   {</span><br><span>             msg(msglevel, &quot;--tun-mtu-max value &=
#39;%s&#39; is invalid&quot;, p[1]);</span><br><span>@@ -6655,13 +6650,13 @=
@</span><br><span>     else if (streq(p[0], &quot;tun-mtu-extra&quot;) &amp=
;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>      =
   VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        options-&gt;ce.tun_mtu_extra =3D positi=
ve_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   options-&gt;ce.tun_mtu_extra =3D positive_atoi(p[1], msglevel);</span><b=
r><span>         options-&gt;ce.tun_mtu_extra_defined =3D true;</span><br><=
span>     }</span><br><span>     else if (streq(p[0], &quot;max-packet-size=
&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br>=
<span>         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        int maxmtu =3D positive_ato=
i(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int=
 maxmtu =3D positive_atoi(p[1], msglevel);</span><br><span>         options=
-&gt;ce.tls_mtu =3D constrain_int(maxmtu, TLS_CHANNEL_MTU_MIN, TLS_CHANNEL_=
BUF_SIZE);</span><br><span> </span><br><span>         if (maxmtu &lt; TLS_C=
HANNEL_MTU_MIN || maxmtu &gt; TLS_CHANNEL_BUF_SIZE)</span><br><span>@@ -668=
7,7 +6682,7 @@</span><br><span>     else if (streq(p[0], &quot;fragment&quo=
t;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.fragment =3D pos=
itive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      options-&gt;ce.fragment =3D positive_atoi(p[1], msglevel);</span><br>=
<span> </span><br><span>         if (options-&gt;ce.fragment &lt; 68)</span=
><br><span>         {</span><br><span>@@ -6718,23 +6713,23 @@</span><br><sp=
an>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT=
_P_NICE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opti=
ons-&gt;nice =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        options-&gt;nice =3D atoi_warn(p[1], msglevel);</span><br>=
<span>     }</span><br><span>     else if (streq(p[0], &quot;rcvbuf&quot;) =
&amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>  =
       VERIFY_PERMISSION(OPT_P_SOCKBUF);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        options-&gt;rcvbuf =3D positive_atoi(p[1]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;rcvb=
uf =3D positive_atoi(p[1], msglevel);</span><br><span>     }</span><br><spa=
n>     else if (streq(p[0], &quot;sndbuf&quot;) &amp;&amp; p[1] &amp;&amp; =
!p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OP=
T_P_SOCKBUF);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
options-&gt;sndbuf =3D positive_atoi(p[1]);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        options-&gt;sndbuf =3D positive_atoi(p[1], =
msglevel);</span><br><span>     }</span><br><span>     else if (streq(p[0],=
 &quot;mark&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {=
</span><br><span> #if defined(TARGET_LINUX) &amp;&amp; HAVE_DECL_SO_MARK</s=
pan><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        options-&gt;mark =3D atoi(p[1]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt=
;mark =3D atoi_warn(p[1], msglevel);</span><br><span> #endif</span><br><spa=
n>     }</span><br><span>     else if (streq(p[0], &quot;socket-flags&quot;=
))</span><br><span>@@ -6764,7 +6759,7 @@</span><br><span>     {</span><br><=
span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span> #ifdef TAR=
GET_LINUX</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opti=
ons-&gt;tuntap_options.txqueuelen =3D positive_atoi(p[1]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;tuntap_options.t=
xqueuelen =3D positive_atoi(p[1], msglevel);</span><br><span> #else</span><=
br><span>         msg(msglevel, &quot;--txqueuelen not supported on this OS=
&quot;);</span><br><span>         goto err;</span><br><span>@@ -6775,7 +677=
0,7 @@</span><br><span>         int shaper;</span><br><span> </span><br><sp=
an>         VERIFY_PERMISSION(OPT_P_SHAPER);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        shaper =3D atoi(p[1]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        shaper =3D atoi_warn(p[1], msglev=
el);</span><br><span>         if (shaper &lt; SHAPER_MIN || shaper &gt; SHA=
PER_MAX)</span><br><span>         {</span><br><span>             msg(msglev=
el, &quot;Bad shaper value, must be between %d and %d&quot;,</span><br><spa=
n>@@ -6823,7 +6818,7 @@</span><br><span>     else if (streq(p[0], &quot;ina=
ctive&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span=
><br><span>         VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;inactivity_timeout =3D =
positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        options-&gt;inactivity_timeout =3D positive_atoi(p[1], msglevel);<=
/span><br><span>         if (p[2])</span><br><span>         {</span><br><sp=
an>             int64_t val =3D atoll(p[2]);</span><br><span>@@ -6841,7 +68=
36,7 @@</span><br><span>     else if (streq(p[0], &quot;session-timeout&quo=
t;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        options-&gt;session_timeout =3D positive_atoi(=
p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        optio=
ns-&gt;session_timeout =3D positive_atoi(p[1], msglevel);</span><br><span> =
    }</span><br><span>     else if (streq(p[0], &quot;proto&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>@@ -7008,2=
4 +7003,24 @@</span><br><span>     else if (streq(p[0], &quot;keepalive&quo=
t;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     =
{</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;keepalive_ping =
=3D atoi(p[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  options-&gt;keepalive_timeout =3D atoi(p[2]);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        options-&gt;keepalive_ping =3D atoi_war=
n(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       options-&gt;keepalive_timeout =3D atoi_warn(p[2], msglevel);</span><=
br><span>     }</span><br><span>     else if (streq(p[0], &quot;ping&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        options-&gt;ping_send_timeout =3D positive_atoi(p=
[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        option=
s-&gt;ping_send_timeout =3D positive_atoi(p[1], msglevel);</span><br><span>=
     }</span><br><span>     else if (streq(p[0], &quot;ping-exit&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        options-&gt;ping_rec_timeout =3D positive_atoi(p[1]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt=
;ping_rec_timeout =3D positive_atoi(p[1], msglevel);</span><br><span>      =
   options-&gt;ping_rec_timeout_action =3D PING_EXIT;</span><br><span>     =
}</span><br><span>     else if (streq(p[0], &quot;ping-restart&quot;) &amp;=
&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>       =
  VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        options-&gt;ping_rec_timeout =3D positive_atoi(p[1]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;p=
ing_rec_timeout =3D positive_atoi(p[1], msglevel);</span><br><span>        =
 options-&gt;ping_rec_timeout_action =3D PING_RESTART;</span><br><span>    =
 }</span><br><span>     else if (streq(p[0], &quot;ping-timer-rem&quot;) &a=
mp;&amp; !p[1])</span><br><span>@@ -7038,7 +7033,7 @@</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_EXPLICIT_NOTIFY)=
;</span><br><span>         if (p[1])</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;ce.explic=
it_exit_notification =3D positive_atoi(p[1]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            options-&gt;ce.explicit_exit_notifica=
tion =3D positive_atoi(p[1], msglevel);</span><br><span>         }</span><b=
r><span>         else</span><br><span>         {</span><br><span>@@ -7158,7=
 +7153,7 @@</span><br><span>     else if (streq(p[0], &quot;route-metric&qu=
ot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><sp=
an>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        options-&gt;route_default_metric =3D positive=
_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 options-&gt;route_default_metric =3D positive_atoi(p[1], msglevel);</span>=
<br><span>     }</span><br><span>     else if (streq(p[0], &quot;route-dela=
y&quot;) &amp;&amp; !p[3])</span><br><span>     {</span><br><span>@@ -7166,=
10 +7161,10 @@</span><br><span>         options-&gt;route_delay_defined =3D=
 true;</span><br><span>         if (p[1])</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;rout=
e_delay =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            options-&gt;route_delay =3D positive_atoi(p[1], ms=
glevel);</span><br><span>             if (p[2])</span><br><span>           =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                op=
tions-&gt;route_delay_window =3D positive_atoi(p[2]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                options-&gt;route_delay_w=
indow =3D positive_atoi(p[2], msglevel);</span><br><span>             }</sp=
an><br><span>         }</span><br><span>         else</span><br><span>@@ -7=
334,7 +7329,7 @@</span><br><span>         }</span><br><span>         else i=
f (streq(p[1], &quot;SERVER_POLL_TIMEOUT&quot;) &amp;&amp; p[2])</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       options-&gt;ce.connect_timeout =3D positive_atoi(p[2]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;ce.conne=
ct_timeout =3D positive_atoi(p[2], msglevel);</span><br><span>         }</s=
pan><br><span>         else</span><br><span>         {</span><br><span>@@ -=
7366,14 +7361,14 @@</span><br><span>     else if (streq(p[0], &quot;script-=
security&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</s=
pan><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        script_security_set(atoi(p[1]));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        script_secu=
rity_set(atoi_warn(p[1], msglevel));</span><br><span>     }</span><br><span=
>     else if (streq(p[0], &quot;mssfix&quot;) &amp;&amp; !p[3])</span><br>=
<span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P=
_CONNECTION);</span><br><span>         if (p[1])</span><br><span>         {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            int mssfi=
x =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            int mssfix =3D positive_atoi(p[1], msglevel);</span><br>=
<span>             /* can be 0, but otherwise it needs to be high enough so=
 we can</span><br><span>              * substract room for headers. */</spa=
n><br><span>             if (mssfix !=3D 0</span><br><span>@@ -7556,7 +7551=
,7 @@</span><br><span>         options-&gt;ifconfig_pool_persist_filename =
=3D p[1];</span><br><span>         if (p[2])</span><br><span>         {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;i=
fconfig_pool_persist_refresh_freq =3D positive_atoi(p[2]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;ifconfig_poo=
l_persist_refresh_freq =3D positive_atoi(p[2], msglevel);</span><br><span> =
        }</span><br><span>     }</span><br><span>     else if (streq(p[0], =
&quot;ifconfig-ipv6-pool&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br=
><span>@@ -7588,8 +7583,8 @@</span><br><span>         int real, virtual;</s=
pan><br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        real =3D atoi(=
p[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        virtual=
 =3D atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     real =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        virtual =3D atoi_warn(p[2], msglevel);</span><=
br><span>         if (real &lt; 1 || virtual &lt; 1)</span><br><span>      =
   {</span><br><span>             msg(msglevel, &quot;--hash-size sizes mus=
t be &gt;=3D 1 (preferably a power of 2)&quot;);</span><br><span>@@ -7603,8=
 +7598,8 @@</span><br><span>         int cf_max, cf_per;</span><br><span> <=
/span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        cf_max =3D atoi(p[1]);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        cf_per =3D atoi(p[2])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cf_max =3D=
 atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        cf_per =3D atoi_warn(p[2], msglevel);</span><br><span>     =
    if (cf_max &lt; 0 || cf_per &lt; 0)</span><br><span>         {</span><b=
r><span>             msg(msglevel, &quot;--connect-freq parms must be &gt; =
0&quot;);</span><br><span>@@ -7634,7 +7629,7 @@</span><br><span>         in=
t max_clients;</span><br><span> </span><br><span>         VERIFY_PERMISSION=
(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   max_clients =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        max_clients =3D atoi_warn(p[1], msglevel);</span><br><sp=
an>         if (max_clients &lt; 0)</span><br><span>         {</span><br><s=
pan>             msg(msglevel, &quot;--max-clients must be at least 1&quot;=
);</span><br><span>@@ -7650,7 +7645,7 @@</span><br><span>     else if (stre=
q(p[0], &quot;max-routes-per-client&quot;) &amp;&amp; p[1] &amp;&amp; !p[2]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_I=
NHERIT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        optio=
ns-&gt;max_routes_per_client =3D max_int(atoi(p[1]), 1);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        options-&gt;max_routes_per_cli=
ent =3D max_int(positive_atoi(p[1], msglevel), 1);</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;client-cert-not-required&quo=
t;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -7734,14 +7=
729,14 @@</span><br><span>     {</span><br><span>         VERIFY_PERMISSION=
(OPT_P_GENERAL);</span><br><span>         options-&gt;auth_token_generate =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opti=
ons-&gt;auth_token_lifetime =3D p[1] ? positive_atoi(p[1]) : 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;auth_token_=
lifetime =3D p[1] ? positive_atoi(p[1], msglevel) : 0;</span><br><span> </s=
pan><br><span>         for (int i =3D 2; i &lt; MAX_PARMS &amp;&amp; p[i] !=
=3D NULL; i++)</span><br><span>         {</span><br><span>             /* t=
he second parameter can be the renewal time */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            if (i =3D=3D 2 &amp;&amp; positive_ato=
i(p[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (i =3D=3D 2 &amp;&amp; valid_integer(p[i], true))</span><br><span>     =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    options-&gt;auth_token_renewal =3D positive_atoi(p[i]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                options-&gt;auth_to=
ken_renewal =3D positive_atoi(p[i], msglevel);</span><br><span>            =
 }</span><br><span>             else if (streq(p[i], &quot;external-auth&qu=
ot;))</span><br><span>             {</span><br><span>@@ -7821,7 +7816,7 @@<=
/span><br><span>         int n_bcast_buf;</span><br><span> </span><br><span=
>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        n_bcast_buf =3D atoi(p[1]);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        n_bcast_buf =3D atoi_warn(p[1=
], msglevel);</span><br><span>         if (n_bcast_buf &lt; 1)</span><br><s=
pan>         {</span><br><span>             msg(msglevel, &quot;--bcast-buf=
fers parameter must be &gt; 0&quot;);</span><br><span>@@ -7833,7 +7828,7 @@=
</span><br><span>         int tcp_queue_limit;</span><br><span> </span><br>=
<span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        tcp_queue_limit =3D atoi(p[1]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        tcp_queue_limit =3D =
atoi_warn(p[1], msglevel);</span><br><span>         if (tcp_queue_limit &lt=
; 1)</span><br><span>         {</span><br><span>             msg(msglevel, =
&quot;--tcp-queue-limit parameter must be &gt; 0&quot;);</span><br><span>@@=
 -7964,10 +7959,10 @@</span><br><span>         int ageing_time, check_inter=
val;</span><br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GEN=
ERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ageing_=
time =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        ageing_time =3D atoi_warn(p[1], msglevel);</span><br><span>       =
  if (p[2])</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            check_interval =3D atoi(p[2]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            check_interval =3D atoi=
_warn(p[2], msglevel);</span><br><span>         }</span><br><span>         =
else</span><br><span>         {</span><br><span>@@ -7996,7 +7991,7 @@</span=
><br><span>     else if (streq(p[0], &quot;push-continuation&quot;) &amp;&a=
mp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         =
VERIFY_PERMISSION(OPT_P_PULL_MODE);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        options-&gt;push_continuation =3D atoi(p[1]);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;push_co=
ntinuation =3D atoi_warn(p[1], msglevel);</span><br><span>     }</span><br>=
<span>     else if (streq(p[0], &quot;auth-user-pass&quot;) &amp;&amp; !p[2=
])</span><br><span>     {</span><br><span>@@ -8021,7 +8016,7 @@</span><br><=
span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</spa=
n><br><span>         options-&gt;sc_info.challenge_text =3D p[1];</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (atoi(p[2]))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (atoi_warn(p[2],=
 msglevel))</span><br><span>         {</span><br><span>             options=
-&gt;sc_info.flags |=3D SC_ECHO;</span><br><span>         }</span><br><span=
>@@ -8117,7 +8112,7 @@</span><br><span>             {</span><br><span>     =
            if (!streq(p[2], &quot;default&quot;))</span><br><span>        =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         int offset =3D atoi(p[2]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    int offset =3D atoi_warn(p[2], msglevel=
);</span><br><span> </span><br><span>                     if (!(offset &gt;=
 -256 &amp;&amp; offset &lt; 256))</span><br><span>                     {</=
span><br><span>@@ -8133,7 +8128,7 @@</span><br><span>                 {</sp=
an><br><span>                     const int min_lease =3D 30;</span><br><sp=
an>                     int lease_time;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    lease_time =3D atoi(p[3]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    lease_time=
 =3D atoi_warn(p[3], msglevel);</span><br><span>                     if (le=
ase_time &lt; min_lease)</span><br><span>                     {</span><br><=
span>                         msg(msglevel, &quot;--ip-win32 dynamic [offse=
t] [lease-time]: lease time parameter (%d) must be at least %d seconds&quot=
;, lease_time, min_lease);</span><br><span>@@ -8257,7 +8252,7 @@</span><br>=
<span>         else if (streq(p[1], &quot;NBT&quot;) &amp;&amp; p[2] &amp;&=
amp; !p[3])</span><br><span>         {</span><br><span>             int t;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            t =3D atoi=
(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
t =3D atoi_warn(p[2], msglevel);</span><br><span>             if (!(t =3D=
=3D 1 || t =3D=3D 2 || t =3D=3D 4 || t =3D=3D 8))</span><br><span>         =
    {</span><br><span>                 msg(msglevel, &quot;--dhcp-option NB=
T: parameter (%d) must be 1, 2, 4, or 8&quot;, t);</span><br><span>@@ -8315=
,7 +8310,7 @@</span><br><span> #if defined(TARGET_ANDROID)</span><br><span>=
         else if (streq(p[1], &quot;PROXY_HTTP&quot;) &amp;&amp; p[3] &amp;=
&amp; !p[4])</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            o-&gt;http_proxy_port =3D atoi(p[3]);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;http_prox=
y_port =3D positiove_atoi(p[3], msglevel);</span><br><span>             o-&=
gt;http_proxy =3D p[2];</span><br><span>         }</span><br><span> #endif<=
/span><br><span>@@ -8349,7 +8344,7 @@</span><br><span>     {</span><br><spa=
n>         int s;</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        s =3D atoi(p=
[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s =3D =
atoi_warn(p[1], msglevel);</span><br><span>         if (s &lt; 0 || s &gt;=
=3D 256)</span><br><span>         {</span><br><span>             msg(msglev=
el, &quot;--tap-sleep parameter must be between 0 and 255&quot;);</span><br=
><span>@@ -8432,7 +8427,7 @@</span><br><span>         options-&gt;exit_even=
t_name =3D p[1];</span><br><span>         if (p[2])</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            option=
s-&gt;exit_event_initial_state =3D (atoi(p[2]) !=3D 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            options-&gt;exit_event_init=
ial_state =3D (atoi_warn(p[2], msglevel) !=3D 0);</span><br><span>         =
}</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;al=
low-nonadmin&quot;) &amp;&amp; !p[2])</span><br><span>@@ -8799,7 +8794,7 @@=
</span><br><span>         {</span><br><span>             int replay_window;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         replay_window =3D atoi(p[1]);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            replay_window =3D atoi_warn(p[1], msglevel);=
</span><br><span>             if (!(MIN_SEQ_BACKTRACK &lt;=3D replay_window=
 &amp;&amp; replay_window &lt;=3D MAX_SEQ_BACKTRACK))</span><br><span>     =
        {</span><br><span>                 msg(msglevel, &quot;replay-windo=
w window size parameter (%d) must be between %d and %d&quot;,</span><br><sp=
an>@@ -8814,7 +8809,7 @@</span><br><span>             {</span><br><span>   =
              int replay_time;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                replay_time =3D atoi(p[2]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                replay_t=
ime =3D atoi_warn(p[2], msglevel);</span><br><span>                 if (!(M=
IN_TIME_BACKTRACK &lt;=3D replay_time &amp;&amp; replay_time &lt;=3D MAX_TI=
ME_BACKTRACK))</span><br><span>                 {</span><br><span>         =
            msg(msglevel, &quot;replay-window time window parameter (%d) mu=
st be between %d and %d&quot;,</span><br><span>@@ -9256,7 +9251,7 @@</span>=
<br><span>     else if (streq(p[0], &quot;tls-timeout&quot;) &amp;&amp; p[1=
] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_=
PERMISSION(OPT_P_TLS_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        options-&gt;tls_timeout =3D positive_atoi(p[1]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;tls_timeout=
 =3D positive_atoi(p[1], msglevel);</span><br><span>     }</span><br><span>=
     else if (streq(p[0], &quot;reneg-bytes&quot;) &amp;&amp; p[1] &amp;&am=
p; !p[2])</span><br><span>     {</span><br><span>@@ -9285,21 +9280,21 @@</s=
pan><br><span>     else if (streq(p[0], &quot;reneg-sec&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>         VERIF=
Y_PERMISSION(OPT_P_TLS_PARMS);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        options-&gt;renegotiate_seconds =3D positive_atoi(p[1]);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;r=
enegotiate_seconds =3D positive_atoi(p[1], msglevel);</span><br><span>     =
    if (p[2])</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            options-&gt;renegotiate_seconds_min =3D posi=
tive_atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         options-&gt;renegotiate_seconds_min =3D positive_atoi(p[2], msglev=
el);</span><br><span>         }</span><br><span>     }</span><br><span>    =
 else if (streq(p[0], &quot;hand-window&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT=
_P_TLS_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 options-&gt;handshake_window =3D positive_atoi(p[1]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        options-&gt;handshake_window =3D=
 positive_atoi(p[1], msglevel);</span><br><span>     }</span><br><span>    =
 else if (streq(p[0], &quot;tran-window&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT=
_P_TLS_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 options-&gt;transition_window =3D positive_atoi(p[1]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        options-&gt;transition_window =
=3D positive_atoi(p[1], msglevel);</span><br><span>     }</span><br><span> =
    else if (streq(p[0], &quot;tls-auth&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[3])</span><br><span>     {</span><br><span>@@ -9436,7 +9431,7 @@</span><b=
r><span>     else if (streq(p[0], &quot;show-pkcs11-ids&quot;) &amp;&amp; !=
p[3])</span><br><span>     {</span><br><span>         char *provider =3D  p=
[1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bool cert=
_private =3D (p[2] =3D=3D NULL ? false : ( atoi(p[2]) !=3D 0 ));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        bool cert_private =3D =
(p[2] =3D=3D NULL ? false : (atoi_warn(p[2], msglevel) !=3D 0 ));</span><br=
><span> </span><br><span> #ifdef DEFAULT_PKCS11_MODULE</span><br><span>    =
     if (!provider)</span><br><span>@@ -9488,7 +9483,7 @@</span><br><span> =
</span><br><span>         for (j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=
=3D NULL; ++j)</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            options-&gt;pkcs11_protected_authentication=
[j-1] =3D atoi(p[j]) !=3D 0 ? 1 : 0;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            options-&gt;pkcs11_protected_authentication[j-=
1] =3D atoi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;</span><br><span>         }=
</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;pkc=
s11-private-mode&quot;) &amp;&amp; p[1])</span><br><span>@@ -9510,13 +9505,=
13 @@</span><br><span> </span><br><span>         for (j =3D 1; j &lt; MAX_P=
ARMS &amp;&amp; p[j] !=3D NULL; ++j)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;pkcs11_ce=
rt_private[j-1] =3D atoi(p[j]) !=3D 0 ? 1 : 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            options-&gt;pkcs11_cert_private[j-1]=
 =3D (bool) (atoi_warn(p[j], msglevel));</span><br><span>         }</span><=
br><span>     }</span><br><span>     else if (streq(p[0], &quot;pkcs11-pin-=
cache&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span=
><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;pkcs11_pin_cache_period=
 =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     options-&gt;pkcs11_pin_cache_period =3D atoi_warn(p[1], msglevel);</sp=
an><br><span>     }</span><br><span>     else if (streq(p[0], &quot;pkcs11-=
id&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><b=
r><span>@@ -9545,12 +9540,12 @@</span><br><span>     {</span><br><span>    =
     VERIFY_PERMISSION(OPT_P_PEER_ID);</span><br><span>         options-&gt=
;use_peer_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        options-&gt;peer_id =3D atoi(p[1]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        options-&gt;peer_id =3D atoi_warn(p[1], ms=
glevel);</span><br><span>     }</span><br><span> #ifdef HAVE_EXPORT_KEYING_=
MATERIAL</span><br><span>     else if (streq(p[0], &quot;keying-material-ex=
porter&quot;) &amp;&amp; p[1] &amp;&amp; p[2])</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        int ekm_length =3D =
positive_atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        int ekm_length =3D positive_atoi(p[2], msglevel);</span><br><span>=
 </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><spa=
n> </span><br><span>@@ -9609,7 +9604,7 @@</span><br><span>     else if (str=
eq(p[0], &quot;vlan-pvid&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br=
><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_=
P_INSTANCE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o=
ptions-&gt;vlan_pvid =3D positive_atoi(p[1]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        options-&gt;vlan_pvid =3D positive_atoi(p=
[1], msglevel);</span><br><span>         if (options-&gt;vlan_pvid &lt; OPE=
NVPN_8021Q_MIN_VID</span><br><span>             || options-&gt;vlan_pvid &g=
t; OPENVPN_8021Q_MAX_VID)</span><br><span>         {</span><br><span>diff -=
-git a/src/openvpn/options_util.c b/src/openvpn/options_util.c</span><br><s=
pan>index a9e020a..fea4c3d 100644</span><br><span>--- a/src/openvpn/options=
_util.c</span><br><span>+++ b/src/openvpn/options_util.c</span><br><span>@@=
 -98,3 +98,50 @@</span><br><span>     gc_free(&amp;gc);</span><br><span>   =
  return message;</span><br><span> }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bo=
ol</span><br><span style=3D"color: hsl(120, 100%, 40%);">+valid_integer(con=
st char *str, bool positive)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    char =
*endptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    long lo=
ng i =3D strtoll(str, &amp;endptr, 10);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (i &lt; INT_MIN || (positive &amp;&amp; i &lt; 0) || *endptr !=3D &=
#39;\0&#39; || i &gt; INT_MAX)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+positive_atoi(const char *str, =
int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *endptr;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    long long i =3D strtol=
l(str, &amp;endptr, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (i &lt;=
 0 || *endptr !=3D &#39;\0&#39; || i &gt; INT_MAX)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        msg(msglevel, &quot;Cannot parse argument &#39;%s&=
#39; as non-negative integer&quot;,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            str);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        i =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int) i;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
atoi_warn(const char *str, int msglevel)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char *endptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    long long i =3D strtoll(str, &amp;endptr, 10);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (i &lt; INT_MIN || *endptr !=3D &#39;\0&#39; || i &gt=
; INT_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &=
quot;Cannot parse argument &#39;%s&#39; as integer&quot;, str);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        i =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return (int) i;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span>diff --git a/src/openvpn/options_util.h b/src/ope=
nvpn/options_util.h</span><br><span>index 29bc9dc..f34d997 100644</span><br=
><span>--- a/src/openvpn/options_util.h</span><br><span>+++ b/src/openvpn/o=
ptions_util.h</span><br><span>@@ -30,4 +30,24 @@</span><br><span> const cha=
r *</span><br><span> parse_auth_failed_temp(struct options *o, const char *=
reason);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/** Checks if the string is=
 a valid integer by checking if it can be</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  converted to an integer */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+valid_integer(const char *str, bool positive);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Converts a str to a positive number if the string represents =
a postive</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * integer=
 number. Otherwise print a warning with msglevel and return 0</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+positive_atoi(const char *str, int msglevel);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * Converts a str to an integer if the string can be represented as an</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * integer number. Othe=
rwise print a warning with msglevel and return 0</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ato=
i_warn(const char *str, int msglevel);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#endif /* ifndef OPTIONS_UTIL_H_ */</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/873?usp=3Demai=
l">change 873</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/873?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie1e2eb54d516b3ae87c5ca56fe8=
edd77ee2be4de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 873 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--XHJ8uaMC1mo=--

