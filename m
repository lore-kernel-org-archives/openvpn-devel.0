From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 21 Jan 2025 14:10:54 +0000
In-Reply-To: <gerrit.1737460984000.Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de@...2715...>
References: <gerrit.1737460984000.Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f9e29892ec59cfaacc14f3f49de8e1241c51328a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0QIEvoHDW6Y="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0QIEvoHDW6Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/873?usp=3Demail

to look at the new patch set (#2).


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
---
M src/openvpn/options.c
1 file changed, 109 insertions(+), 77 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/873/2

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 93b8417..f08d29f 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4926,11 +4926,43 @@
 }
 #endif

+/**
+ * Converts a str to a positive number if the string represents a postive
+ * integer number. Otherwise print a warning with msglevel and return 0
+ */
 static int
-positive_atoi(const char *str)
+positive_atoi(const char *str, int msglevel)
 {
-    const int i =3D atoi(str);
-    return i < 0 ? 0 : i;
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
+/**
+ * Converts a str to an integer if the string can be represented as an
+ * integer number. Otherwise print a warning with msglevel and return 0
+ */
+static int
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
 }

 #ifdef _WIN32  /* This function is only used when compiling on Windows */
@@ -5955,7 +5987,7 @@
         int cache;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cache =3D atoi(p[1]);
+        cache =3D atoi_warn(p[1], msglevel);
         if (cache < 1)
         {
             msg(msglevel, "--management-log-cache parameter is out of rang=
e");
@@ -6250,7 +6282,7 @@
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
@@ -6267,7 +6299,7 @@
     else if (streq(p[0], "connect-retry") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->ce.connect_retry_seconds =3D positive_atoi(p[1]);
+        options->ce.connect_retry_seconds =3D positive_atoi(p[1], msglevel=
);
         /*
          * Limit the base value of retry wait interval to 16 bits to avoid
          * overflow when scaled up for exponential backoff
@@ -6282,19 +6314,19 @@
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
@@ -6317,7 +6349,7 @@
     else if (streq(p[0], "gremlin") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->gremlin =3D positive_atoi(p[1]);
+        options->gremlin =3D positive_atoi(p[1], msglevel);
     }
 #endif
     else if (streq(p[0], "chroot") && p[1] && !p[2])
@@ -6449,7 +6481,7 @@
     else if (streq(p[0], "verb") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MESSAGES);
-        options->verbosity =3D positive_atoi(p[1]);
+        options->verbosity =3D positive_atoi(p[1], msglevel);
         if (options->verbosity >=3D (D_TLS_DEBUG_MED & M_DEBUG_LEVEL))
         {
             /* We pass this flag to the SSL library to avoid
@@ -6468,7 +6500,7 @@
     else if (streq(p[0], "mute") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MESSAGES);
-        options->mute =3D positive_atoi(p[1]);
+        options->mute =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "errors-to-stderr") && !p[1])
     {
@@ -6481,7 +6513,7 @@
         options->status_file =3D p[1];
         if (p[2])
         {
-            options->status_file_update_freq =3D positive_atoi(p[2]);
+            options->status_file_update_freq =3D positive_atoi(p[2], msgle=
vel);
         }
     }
     else if (streq(p[0], "status-version") && p[1] && !p[2])
@@ -6489,7 +6521,7 @@
         int version;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        version =3D atoi(p[1]);
+        version =3D atoi_warn(p[1], msglevel);
         if (version < 1 || version > 3)
         {
             msg(msglevel, "--status-version must be 1 to 3");
@@ -6517,17 +6549,17 @@
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
@@ -6537,7 +6569,7 @@
     else if (streq(p[0], "tun-mtu-max") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        int max_mtu =3D positive_atoi(p[1]);
+        int max_mtu =3D positive_atoi(p[1], msglevel);
         if (max_mtu < 68 || max_mtu > 65536)
         {
             msg(msglevel, "--tun-mtu-max value '%s' is invalid", p[1]);
@@ -6550,13 +6582,13 @@
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
@@ -6582,7 +6614,7 @@
     else if (streq(p[0], "fragment") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        options->ce.fragment =3D positive_atoi(p[1]);
+        options->ce.fragment =3D positive_atoi(p[1], msglevel);

         if (options->ce.fragment < 68)
         {
@@ -6613,23 +6645,23 @@
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
@@ -6659,7 +6691,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
 #ifdef TARGET_LINUX
-        options->tuntap_options.txqueuelen =3D positive_atoi(p[1]);
+        options->tuntap_options.txqueuelen =3D positive_atoi(p[1], msgleve=
l);
 #else
         msg(msglevel, "--txqueuelen not supported on this OS");
         goto err;
@@ -6670,7 +6702,7 @@
         int shaper;

         VERIFY_PERMISSION(OPT_P_SHAPER);
-        shaper =3D atoi(p[1]);
+        shaper =3D atoi_warn(p[1], msglevel);
         if (shaper < SHAPER_MIN || shaper > SHAPER_MAX)
         {
             msg(msglevel, "Bad shaper value, must be between %d and %d",
@@ -6718,7 +6750,7 @@
     else if (streq(p[0], "inactive") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->inactivity_timeout =3D positive_atoi(p[1]);
+        options->inactivity_timeout =3D positive_atoi(p[1], msglevel);
         if (p[2])
         {
             int64_t val =3D atoll(p[2]);
@@ -6736,7 +6768,7 @@
     else if (streq(p[0], "session-timeout") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->session_timeout =3D positive_atoi(p[1]);
+        options->session_timeout =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "proto") && p[1] && !p[2])
     {
@@ -6903,24 +6935,24 @@
     else if (streq(p[0], "keepalive") && p[1] && p[2] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->keepalive_ping =3D atoi(p[1]);
-        options->keepalive_timeout =3D atoi(p[2]);
+        options->keepalive_ping =3D atoi_warn(p[1], msglevel);
+        options->keepalive_timeout =3D atoi_warn(p[1], msglevel);
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
@@ -6933,7 +6965,7 @@
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
@@ -7053,7 +7085,7 @@
     else if (streq(p[0], "route-metric") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        options->route_default_metric =3D positive_atoi(p[1]);
+        options->route_default_metric =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "route-delay") && !p[3])
     {
@@ -7061,10 +7093,10 @@
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
@@ -7229,7 +7261,7 @@
         }
         else if (streq(p[1], "SERVER_POLL_TIMEOUT") && p[2])
         {
-            options->ce.connect_timeout =3D positive_atoi(p[2]);
+            options->ce.connect_timeout =3D positive_atoi(p[2], msglevel);
         }
         else
         {
@@ -7261,14 +7293,14 @@
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
@@ -7451,7 +7483,7 @@
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
@@ -7483,8 +7515,8 @@
         int real, virtual;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        real =3D atoi(p[1]);
-        virtual =3D atoi(p[2]);
+        real =3D atoi_warn(p[1], msglevel);
+        virtual =3D atoi_warn(p[1], msglevel);
         if (real < 1 || virtual < 1)
         {
             msg(msglevel, "--hash-size sizes must be >=3D 1 (preferably a =
power of 2)");
@@ -7498,8 +7530,8 @@
         int cf_max, cf_per;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cf_max =3D atoi(p[1]);
-        cf_per =3D atoi(p[2]);
+        cf_max =3D atoi_warn(p[1], msglevel);
+        cf_per =3D atoi_warn(p[1], msglevel);
         if (cf_max < 0 || cf_per < 0)
         {
             msg(msglevel, "--connect-freq parms must be > 0");
@@ -7529,7 +7561,7 @@
         int max_clients;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        max_clients =3D atoi(p[1]);
+        max_clients =3D atoi_warn(p[1], msglevel);
         if (max_clients < 0)
         {
             msg(msglevel, "--max-clients must be at least 1");
@@ -7545,7 +7577,7 @@
     else if (streq(p[0], "max-routes-per-client") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INHERIT);
-        options->max_routes_per_client =3D max_int(atoi(p[1]), 1);
+        options->max_routes_per_client =3D max_int(positive_atoi(p[1], msg=
level), 1);
     }
     else if (streq(p[0], "client-cert-not-required") && !p[1])
     {
@@ -7629,14 +7661,14 @@
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
+            if (i =3D=3D 2 && positive_atoi(p[i], msglevel))
             {
-                options->auth_token_renewal =3D positive_atoi(p[i]);
+                options->auth_token_renewal =3D positive_atoi(p[i], msglev=
el);
             }
             else if (streq(p[i], "external-auth"))
             {
@@ -7716,7 +7748,7 @@
         int n_bcast_buf;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        n_bcast_buf =3D atoi(p[1]);
+        n_bcast_buf =3D atoi_warn(p[1], msglevel);
         if (n_bcast_buf < 1)
         {
             msg(msglevel, "--bcast-buffers parameter must be > 0");
@@ -7728,7 +7760,7 @@
         int tcp_queue_limit;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        tcp_queue_limit =3D atoi(p[1]);
+        tcp_queue_limit =3D atoi_warn(p[1], msglevel);
         if (tcp_queue_limit < 1)
         {
             msg(msglevel, "--tcp-queue-limit parameter must be > 0");
@@ -7876,10 +7908,10 @@
         int ageing_time, check_interval;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ageing_time =3D atoi(p[1]);
+        ageing_time =3D atoi_warn(p[1], msglevel);
         if (p[2])
         {
-            check_interval =3D atoi(p[2]);
+            check_interval =3D atoi_warn(p[1], msglevel);
         }
         else
         {
@@ -7908,7 +7940,7 @@
     else if (streq(p[0], "push-continuation") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_PULL_MODE);
-        options->push_continuation =3D atoi(p[1]);
+        options->push_continuation =3D atoi_warn(p[1], msglevel);
     }
     else if (streq(p[0], "auth-user-pass") && !p[2])
     {
@@ -7933,7 +7965,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sc_info.challenge_text =3D p[1];
-        if (atoi(p[2]))
+        if (atoi_warn(p[1], msglevel))
         {
             options->sc_info.flags |=3D SC_ECHO;
         }
@@ -8029,7 +8061,7 @@
             {
                 if (!streq(p[2], "default"))
                 {
-                    int offset =3D atoi(p[2]);
+                    int offset =3D options_atoi(p[1], msglevel);

                     if (!(offset > -256 && offset < 256))
                     {
@@ -8045,7 +8077,7 @@
                 {
                     const int min_lease =3D 30;
                     int lease_time;
-                    lease_time =3D atoi(p[3]);
+                    lease_time =3D options_atoi(p[1], msglevel);
                     if (lease_time < min_lease)
                     {
                         msg(msglevel, "--ip-win32 dynamic [offset] [lease-=
time]: lease time parameter (%d) must be at least %d seconds", lease_time, =
min_lease);
@@ -8169,7 +8201,7 @@
         else if (streq(p[1], "NBT") && p[2] && !p[3])
         {
             int t;
-            t =3D atoi(p[2]);
+            t =3D options_atoi(p[1], msglevel);
             if (!(t =3D=3D 1 || t =3D=3D 2 || t =3D=3D 4 || t =3D=3D 8))
             {
                 msg(msglevel, "--dhcp-option NBT: parameter (%d) must be 1=
, 2, 4, or 8", t);
@@ -8227,7 +8259,7 @@
 #if defined(TARGET_ANDROID)
         else if (streq(p[1], "PROXY_HTTP") && p[3] && !p[4])
         {
-            o->http_proxy_port =3D atoi(p[3]);
+            o->http_proxy_port =3D options_atoi(p[1], msglevel);
             o->http_proxy =3D p[2];
         }
 #endif
@@ -8261,7 +8293,7 @@
     {
         int s;
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        s =3D atoi(p[1]);
+        s =3D options_atoi(p[1], msglevel);
         if (s < 0 || s >=3D 256)
         {
             msg(msglevel, "--tap-sleep parameter must be between 0 and 255=
");
@@ -8344,7 +8376,7 @@
         options->exit_event_name =3D p[1];
         if (p[2])
         {
-            options->exit_event_initial_state =3D (atoi(p[2]) !=3D 0);
+            options->exit_event_initial_state =3D (options_atoi(p[1], msgl=
evel) !=3D 0);
         }
     }
     else if (streq(p[0], "allow-nonadmin") && !p[2])
@@ -8711,7 +8743,7 @@
         {
             int replay_window;

-            replay_window =3D atoi(p[1]);
+            replay_window =3D atoi_warn(p[1], msglevel);
             if (!(MIN_SEQ_BACKTRACK <=3D replay_window && replay_window <=
=3D MAX_SEQ_BACKTRACK))
             {
                 msg(msglevel, "replay-window window size parameter (%d) mu=
st be between %d and %d",
@@ -8726,7 +8758,7 @@
             {
                 int replay_time;

-                replay_time =3D atoi(p[2]);
+                replay_time =3D atoi_warn(p[1], msglevel);
                 if (!(MIN_TIME_BACKTRACK <=3D replay_time && replay_time <=
=3D MAX_TIME_BACKTRACK))
                 {
                     msg(msglevel, "replay-window time window parameter (%d=
) must be between %d and %d",
@@ -9168,7 +9200,7 @@
     else if (streq(p[0], "tls-timeout") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->tls_timeout =3D positive_atoi(p[1]);
+        options->tls_timeout =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
@@ -9197,21 +9229,21 @@
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
@@ -9348,7 +9380,7 @@
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
         char *provider =3D  p[1];
-        bool cert_private =3D (p[2] =3D=3D NULL ? false : ( atoi(p[2]) !=
=3D 0 ));
+        bool cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[1],=
 msglevel) !=3D 0 ));

 #ifdef DEFAULT_PKCS11_MODULE
         if (!provider)
@@ -9400,7 +9432,7 @@

         for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
         {
-            options->pkcs11_protected_authentication[j-1] =3D atoi(p[j]) !=
=3D 0 ? 1 : 0;
+            options->pkcs11_protected_authentication[j-1] =3D atoi_warn(p[=
j], msglevel) !=3D 0 ? 1 : 0;
         }
     }
     else if (streq(p[0], "pkcs11-private-mode") && p[1])
@@ -9422,13 +9454,13 @@

         for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
         {
-            options->pkcs11_cert_private[j-1] =3D atoi(p[j]) !=3D 0 ? 1 : =
0;
+            options->pkcs11_cert_private[j-1] =3D atoi_warn(p[j], msglevel=
) !=3D 0 ? 1 : 0;
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
@@ -9457,12 +9489,12 @@
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

@@ -9521,7 +9553,7 @@
     else if (streq(p[0], "vlan-pvid") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);
-        options->vlan_pvid =3D positive_atoi(p[1]);
+        options->vlan_pvid =3D positive_atoi(p[1], msglevel);
         if (options->vlan_pvid < OPENVPN_8021Q_MIN_VID
             || options->vlan_pvid > OPENVPN_8021Q_MAX_VID)
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/873?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de
Gerrit-Change-Number: 873
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--0QIEvoHDW6Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/873?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Print warnings/errors when numerical parameters cannot be parsed<br><=
br>Using the atoi method is a best effort method that parses as much of the=
<br>input string as possible as integer and ignores the rest or return 0<br=
>if the string cannot be parsed. This is lead to unexpected results.<br><br=
>Change the behaviour by printing a warning in these cases instead. When<br=
>parsing a configuration, these warnings will error out since the msglevel<=
br>is M_USAGE in this case. Example:<br><br>    ./src/openvpn/openvpn --res=
olv-retry 198jj<br>    Options error: Cannot parse argument &#39;198jj&#39;=
 as non-negative integer<br><br>Reported-By: Anqi Chen &lt;chen.anqi3@...2825...=
55...&gt;<br>Reported-By: Cristina Nita-Rotaru &lt;c.nitarotaru@...2855...&=
gt;<br>Change-Id: Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de<br>---<br>M src=
/openvpn/options.c<br>1 file changed, 109 insertions(+), 77 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/873=
/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span=
><br><span>index 93b8417..f08d29f 100644</span><br><span>--- a/src/openvpn/=
options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -4=
926,11 +4926,43 @@</span><br><span> }</span><br><span> #endif</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Converts a str to a positive=
 number if the string represents a postive</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * integer number. Otherwise print a warning with ms=
glevel and return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 */</span><br><span> static int</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-positive_atoi(const char *str)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+positive_atoi(const char *str, int msglevel)</span><br=
><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const in=
t i =3D atoi(str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 return i &lt; 0 ? 0 : i;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    char *endptr;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    long long i =3D strtoll(str, &amp;endptr, 10);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    if (i &lt; 0 || *endptr !=3D &#39;\0&#39; || i &gt; INT=
_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;=
Cannot parse argument &#39;%s&#39; as non-negative integer&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            str);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        i =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    return (int) i;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Converts a str to an integer if the string=
 can be represented as an</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * integer number. Otherwise print a warning with msglevel and return=
 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+atoi_warn(const char *str, int msglevel)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char *endptr;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    long long i =3D strtoll(str, &amp;en=
dptr, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    if (i &lt; INT_MIN || *e=
ndptr !=3D &#39;\0&#39; || i &gt; INT_MAX)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        msg(msglevel, &quot;Cannot parse argument &#39;%s&#39; as =
integer&quot;, str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    return (int) i;</span><br><span=
> }</span><br><span> </span><br><span> #ifdef _WIN32  /* This function is o=
nly used when compiling on Windows */</span><br><span>@@ -5955,7 +5987,7 @@=
</span><br><span>         int cache;</span><br><span> </span><br><span>    =
     VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        cache =3D atoi(p[1]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        cache =3D atoi_warn(p[1], msglevel);</sp=
an><br><span>         if (cache &lt; 1)</span><br><span>         {</span><b=
r><span>             msg(msglevel, &quot;--management-log-cache parameter i=
s out of range&quot;);</span><br><span>@@ -6250,7 +6282,7 @@</span><br><spa=
n>         }</span><br><span>         else</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;res=
olve_retry_seconds =3D positive_atoi(p[1]);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            options-&gt;resolve_retry_seconds =3D p=
ositive_atoi(p[1], msglevel);</span><br><span>         }</span><br><span>  =
   }</span><br><span>     else if ((streq(p[0], &quot;preresolve&quot;) || =
streq(p[0], &quot;ip-remote-hint&quot;)) &amp;&amp; !p[2])</span><br><span>=
@@ -6267,7 +6299,7 @@</span><br><span>     else if (streq(p[0], &quot;conne=
ct-retry&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</s=
pan><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.=
connect_retry_seconds =3D positive_atoi(p[1]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        options-&gt;ce.connect_retry_seconds =3D=
 positive_atoi(p[1], msglevel);</span><br><span>         /*</span><br><span=
>          * Limit the base value of retry wait interval to 16 bits to avoi=
d</span><br><span>          * overflow when scaled up for exponential backo=
ff</span><br><span>@@ -6282,19 +6314,19 @@</span><br><span>         if (p[2=
])</span><br><span>         {</span><br><span>             options-&gt;ce.c=
onnect_retry_seconds_max =3D</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                max_int(positive_atoi(p[2]), options-&gt;ce.connect_=
retry_seconds);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            max_int(positive_atoi(p[2], msglevel), options-&gt;ce.connect_r=
etry_seconds);</span><br><span>         }</span><br><span>     }</span><br>=
<span>     else if ((streq(p[0], &quot;connect-timeout&quot;) || streq(p[0]=
, &quot;server-poll-timeout&quot;))</span><br><span>              &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        options-&gt;ce.connect_timeout =3D posit=
ive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    options-&gt;ce.connect_timeout =3D positive_atoi(p[1], msglevel);</span=
><br><span>     }</span><br><span>     else if (streq(p[0], &quot;connect-r=
etry-max&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</s=
pan><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;con=
nect_retry_max =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        options-&gt;connect_retry_max =3D positive_atoi=
(p[1], msglevel);</span><br><span>     }</span><br><span>     else if (stre=
q(p[0], &quot;ipchange&quot;) &amp;&amp; p[1])</span><br><span>     {</span=
><br><span>@@ -6317,7 +6349,7 @@</span><br><span>     else if (streq(p[0], =
&quot;gremlin&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>    =
 {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;gremlin =3D pos=
itive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      options-&gt;gremlin =3D positive_atoi(p[1], msglevel);</span><br><spa=
n>     }</span><br><span> #endif</span><br><span>     else if (streq(p[0], =
&quot;chroot&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>@@ -6=
449,7 +6481,7 @@</span><br><span>     else if (streq(p[0], &quot;verb&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_MESSAGES);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        options-&gt;verbosity =3D positive_atoi(p[1])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&g=
t;verbosity =3D positive_atoi(p[1], msglevel);</span><br><span>         if =
(options-&gt;verbosity &gt;=3D (D_TLS_DEBUG_MED &amp; M_DEBUG_LEVEL))</span=
><br><span>         {</span><br><span>             /* We pass this flag to =
the SSL library to avoid</span><br><span>@@ -6468,7 +6500,7 @@</span><br><s=
pan>     else if (streq(p[0], &quot;mute&quot;) &amp;&amp; p[1] &amp;&amp; =
!p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OP=
T_P_MESSAGES);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 options-&gt;mute =3D positive_atoi(p[1]);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        options-&gt;mute =3D positive_atoi(p[1], msg=
level);</span><br><span>     }</span><br><span>     else if (streq(p[0], &q=
uot;errors-to-stderr&quot;) &amp;&amp; !p[1])</span><br><span>     {</span>=
<br><span>@@ -6481,7 +6513,7 @@</span><br><span>         options-&gt;status=
_file =3D p[1];</span><br><span>         if (p[2])</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            options=
-&gt;status_file_update_freq =3D positive_atoi(p[2]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            options-&gt;status_file_updat=
e_freq =3D positive_atoi(p[2], msglevel);</span><br><span>         }</span>=
<br><span>     }</span><br><span>     else if (streq(p[0], &quot;status-ver=
sion&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>@@ -6489,7 +6=
521,7 @@</span><br><span>         int version;</span><br><span> </span><br>=
<span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        version =3D atoi(p[1]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        version =3D atoi_warn(p[1], =
msglevel);</span><br><span>         if (version &lt; 1 || version &gt; 3)</=
span><br><span>         {</span><br><span>             msg(msglevel, &quot;=
--status-version must be 1 to 3&quot;);</span><br><span>@@ -6517,17 +6549,1=
7 @@</span><br><span>     else if ((streq(p[0], &quot;link-mtu&quot;) || st=
req(p[0], &quot;udp-mtu&quot;)) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br=
><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CO=
NNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opt=
ions-&gt;ce.link_mtu =3D positive_atoi(p[1]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        options-&gt;ce.link_mtu =3D positive_atoi=
(p[1], msglevel);</span><br><span>         options-&gt;ce.link_mtu_defined =
=3D true;</span><br><span>     }</span><br><span>     else if (streq(p[0], =
&quot;tun-mtu&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>    =
 {</span><br><span>         VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTI=
ON);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&=
gt;ce.tun_mtu =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        options-&gt;ce.tun_mtu =3D positive_atoi(p[1], m=
sglevel);</span><br><span>         options-&gt;ce.tun_mtu_defined =3D true;=
</span><br><span>         if (p[2])</span><br><span>         {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;ce.occ_mtu=
 =3D positive_atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            options-&gt;ce.occ_mtu =3D positive_atoi(p[2], msglevel);=
</span><br><span>         }</span><br><span>         else</span><br><span> =
        {</span><br><span>@@ -6537,7 +6569,7 @@</span><br><span>     else i=
f (streq(p[0], &quot;tun-mtu-max&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</=
span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_MTU|=
OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     int max_mtu =3D positive_atoi(p[1]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        int max_mtu =3D positive_atoi(p[1], msglevel)=
;</span><br><span>         if (max_mtu &lt; 68 || max_mtu &gt; 65536)</span=
><br><span>         {</span><br><span>             msg(msglevel, &quot;--tu=
n-mtu-max value &#39;%s&#39; is invalid&quot;, p[1]);</span><br><span>@@ -6=
550,13 +6582,13 @@</span><br><span>     else if (streq(p[0], &quot;tun-mtu-=
extra&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span=
><br><span>         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.tun_mtu=
_extra =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        options-&gt;ce.tun_mtu_extra =3D positive_atoi(p[1], ms=
glevel);</span><br><span>         options-&gt;ce.tun_mtu_extra_defined =3D =
true;</span><br><span>     }</span><br><span>     else if (streq(p[0], &quo=
t;max-packet-size&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>=
     {</span><br><span>         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTIO=
N);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int maxmtu=
 =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        int maxmtu =3D positive_atoi(p[1], msglevel);</span><br><span=
>         options-&gt;ce.tls_mtu =3D constrain_int(maxmtu, TLS_CHANNEL_MTU_=
MIN, TLS_CHANNEL_BUF_SIZE);</span><br><span> </span><br><span>         if (=
maxmtu &lt; TLS_CHANNEL_MTU_MIN || maxmtu &gt; TLS_CHANNEL_BUF_SIZE)</span>=
<br><span>@@ -6582,7 +6614,7 @@</span><br><span>     else if (streq(p[0], &=
quot;fragment&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>    =
 {</span><br><span>         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce=
.fragment =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        options-&gt;ce.fragment =3D positive_atoi(p[1], msgl=
evel);</span><br><span> </span><br><span>         if (options-&gt;ce.fragme=
nt &lt; 68)</span><br><span>         {</span><br><span>@@ -6613,23 +6645,23=
 @@</span><br><span>     else if (streq(p[0], &quot;nice&quot;) &amp;&amp; =
p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERI=
FY_PERMISSION(OPT_P_NICE);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        options-&gt;nice =3D atoi(p[1]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        options-&gt;nice =3D atoi_warn(p[1], msgl=
evel);</span><br><span>     }</span><br><span>     else if (streq(p[0], &qu=
ot;rcvbuf&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</=
span><br><span>         VERIFY_PERMISSION(OPT_P_SOCKBUF);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        options-&gt;rcvbuf =3D positive=
_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 options-&gt;rcvbuf =3D positive_atoi(p[1], msglevel);</span><br><span>    =
 }</span><br><span>     else if (streq(p[0], &quot;sndbuf&quot;) &amp;&amp;=
 p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VER=
IFY_PERMISSION(OPT_P_SOCKBUF);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        options-&gt;sndbuf =3D positive_atoi(p[1]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;sndbuf =3D pos=
itive_atoi(p[1], msglevel);</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;mark&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span=
><br><span>     {</span><br><span> #if defined(TARGET_LINUX) &amp;&amp; HAV=
E_DECL_SO_MARK</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;mar=
k =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      options-&gt;mark =3D atoi_warn(p[1], msglevel);</span><br><span> #end=
if</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;s=
ocket-flags&quot;))</span><br><span>@@ -6659,7 +6691,7 @@</span><br><span> =
    {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br>=
<span> #ifdef TARGET_LINUX</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        options-&gt;tuntap_options.txqueuelen =3D positive_atoi(p[1]);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt=
;tuntap_options.txqueuelen =3D positive_atoi(p[1], msglevel);</span><br><sp=
an> #else</span><br><span>         msg(msglevel, &quot;--txqueuelen not sup=
ported on this OS&quot;);</span><br><span>         goto err;</span><br><spa=
n>@@ -6670,7 +6702,7 @@</span><br><span>         int shaper;</span><br><spa=
n> </span><br><span>         VERIFY_PERMISSION(OPT_P_SHAPER);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        shaper =3D atoi(p[1]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        shaper =3D atoi_=
warn(p[1], msglevel);</span><br><span>         if (shaper &lt; SHAPER_MIN |=
| shaper &gt; SHAPER_MAX)</span><br><span>         {</span><br><span>      =
       msg(msglevel, &quot;Bad shaper value, must be between %d and %d&quot=
;,</span><br><span>@@ -6718,7 +6750,7 @@</span><br><span>     else if (stre=
q(p[0], &quot;inactive&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><=
span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_TIMER);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;inactivi=
ty_timeout =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        options-&gt;inactivity_timeout =3D positive_atoi(p[=
1], msglevel);</span><br><span>         if (p[2])</span><br><span>         =
{</span><br><span>             int64_t val =3D atoll(p[2]);</span><br><span=
>@@ -6736,7 +6768,7 @@</span><br><span>     else if (streq(p[0], &quot;sess=
ion-timeout&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {=
</span><br><span>         VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        options-&gt;session_timeout =3D=
 positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        options-&gt;session_timeout =3D positive_atoi(p[1], msglevel);</s=
pan><br><span>     }</span><br><span>     else if (streq(p[0], &quot;proto&=
quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><=
span>@@ -6903,24 +6935,24 @@</span><br><span>     else if (streq(p[0], &quo=
t;keepalive&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span>=
<br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;k=
eepalive_ping =3D atoi(p[1]);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        options-&gt;keepalive_timeout =3D atoi(p[2]);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;keepalive_pin=
g =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        options-&gt;keepalive_timeout =3D atoi_warn(p[1], msgl=
evel);</span><br><span>     }</span><br><span>     else if (streq(p[0], &qu=
ot;ping&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</sp=
an><br><span>         VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ping_send_timeout =3D p=
ositive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        options-&gt;ping_send_timeout =3D positive_atoi(p[1], msglevel);</s=
pan><br><span>     }</span><br><span>     else if (streq(p[0], &quot;ping-e=
xit&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><=
br><span>         VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        options-&gt;ping_rec_timeout =3D positi=
ve_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   options-&gt;ping_rec_timeout =3D positive_atoi(p[1], msglevel);</span><b=
r><span>         options-&gt;ping_rec_timeout_action =3D PING_EXIT;</span><=
br><span>     }</span><br><span>     else if (streq(p[0], &quot;ping-restar=
t&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br=
><span>         VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        options-&gt;ping_rec_timeout =3D positive=
_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 options-&gt;ping_rec_timeout =3D positive_atoi(p[1], msglevel);</span><br>=
<span>         options-&gt;ping_rec_timeout_action =3D PING_RESTART;</span>=
<br><span>     }</span><br><span>     else if (streq(p[0], &quot;ping-timer=
-rem&quot;) &amp;&amp; !p[1])</span><br><span>@@ -6933,7 +6965,7 @@</span><=
br><span>         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_EX=
PLICIT_NOTIFY);</span><br><span>         if (p[1])</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            options=
-&gt;ce.explicit_exit_notification =3D positive_atoi(p[1]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;ce.explicit=
_exit_notification =3D positive_atoi(p[1], msglevel);</span><br><span>     =
    }</span><br><span>         else</span><br><span>         {</span><br><s=
pan>@@ -7053,7 +7085,7 @@</span><br><span>     else if (streq(p[0], &quot;r=
oute-metric&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {=
</span><br><span>         VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        options-&gt;route_default_metri=
c =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        options-&gt;route_default_metric =3D positive_atoi(p[1], msg=
level);</span><br><span>     }</span><br><span>     else if (streq(p[0], &q=
uot;route-delay&quot;) &amp;&amp; !p[3])</span><br><span>     {</span><br><=
span>@@ -7061,10 +7093,10 @@</span><br><span>         options-&gt;route_del=
ay_defined =3D true;</span><br><span>         if (p[1])</span><br><span>   =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            op=
tions-&gt;route_delay =3D positive_atoi(p[1]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            options-&gt;route_delay =3D positive=
_atoi(p[1], msglevel);</span><br><span>             if (p[2])</span><br><sp=
an>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            options-&gt;route_delay_window =3D positive_atoi(p[2]);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                options-&gt=
;route_delay_window =3D positive_atoi(p[2], msglevel);</span><br><span>    =
         }</span><br><span>         }</span><br><span>         else</span><=
br><span>@@ -7229,7 +7261,7 @@</span><br><span>         }</span><br><span> =
        else if (streq(p[1], &quot;SERVER_POLL_TIMEOUT&quot;) &amp;&amp; p[=
2])</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            options-&gt;ce.connect_timeout =3D positive_atoi(p[2])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            option=
s-&gt;ce.connect_timeout =3D positive_atoi(p[2], msglevel);</span><br><span=
>         }</span><br><span>         else</span><br><span>         {</span>=
<br><span>@@ -7261,14 +7293,14 @@</span><br><span>     else if (streq(p[0],=
 &quot;script-security&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><=
span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        script_security_se=
t(atoi(p[1]));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   script_security_set(atoi_warn(p[1], msglevel));</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;mssfix&quot;) &amp;&amp; !p[=
3])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P=
_GENERAL|OPT_P_CONNECTION);</span><br><span>         if (p[1])</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     int mssfix =3D positive_atoi(p[1]);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            int mssfix =3D positive_atoi(p[1], msgleve=
l);</span><br><span>             /* can be 0, but otherwise it needs to be =
high enough so we can</span><br><span>              * substract room for he=
aders. */</span><br><span>             if (mssfix !=3D 0</span><br><span>@@=
 -7451,7 +7483,7 @@</span><br><span>         options-&gt;ifconfig_pool_pers=
ist_filename =3D p[1];</span><br><span>         if (p[2])</span><br><span> =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
options-&gt;ifconfig_pool_persist_refresh_freq =3D positive_atoi(p[2]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt=
;ifconfig_pool_persist_refresh_freq =3D positive_atoi(p[2], msglevel);</spa=
n><br><span>         }</span><br><span>     }</span><br><span>     else if =
(streq(p[0], &quot;ifconfig-ipv6-pool&quot;) &amp;&amp; p[1] &amp;&amp; !p[=
2])</span><br><span>@@ -7483,8 +7515,8 @@</span><br><span>         int real=
, virtual;</span><br><span> </span><br><span>         VERIFY_PERMISSION(OPT=
_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        r=
eal =3D atoi(p[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      virtual =3D atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        real =3D atoi_warn(p[1], msglevel);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        virtual =3D atoi_warn(p[1], msgle=
vel);</span><br><span>         if (real &lt; 1 || virtual &lt; 1)</span><br=
><span>         {</span><br><span>             msg(msglevel, &quot;--hash-s=
ize sizes must be &gt;=3D 1 (preferably a power of 2)&quot;);</span><br><sp=
an>@@ -7498,8 +7530,8 @@</span><br><span>         int cf_max, cf_per;</span=
><br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        cf_max =3D atoi(p=
[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cf_per =
=3D atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    cf_max =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cf_per =3D atoi_warn(p[1], msglevel);</span><=
br><span>         if (cf_max &lt; 0 || cf_per &lt; 0)</span><br><span>     =
    {</span><br><span>             msg(msglevel, &quot;--connect-freq parms=
 must be &gt; 0&quot;);</span><br><span>@@ -7529,7 +7561,7 @@</span><br><sp=
an>         int max_clients;</span><br><span> </span><br><span>         VER=
IFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        max_clients =3D atoi(p[1]);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        max_clients =3D atoi_warn(p[1], msglevel);=
</span><br><span>         if (max_clients &lt; 0)</span><br><span>         =
{</span><br><span>             msg(msglevel, &quot;--max-clients must be at=
 least 1&quot;);</span><br><span>@@ -7545,7 +7577,7 @@</span><br><span>    =
 else if (streq(p[0], &quot;max-routes-per-client&quot;) &amp;&amp; p[1] &a=
mp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERM=
ISSION(OPT_P_INHERIT);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        options-&gt;max_routes_per_client =3D max_int(atoi(p[1]), 1);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;max_=
routes_per_client =3D max_int(positive_atoi(p[1], msglevel), 1);</span><br>=
<span>     }</span><br><span>     else if (streq(p[0], &quot;client-cert-no=
t-required&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>=
@@ -7629,14 +7661,14 @@</span><br><span>     {</span><br><span>         VER=
IFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;auth_to=
ken_generate =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        options-&gt;auth_token_lifetime =3D p[1] ? positive_atoi(p[1]) : 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&g=
t;auth_token_lifetime =3D p[1] ? positive_atoi(p[1], msglevel) : 0;</span><=
br><span> </span><br><span>         for (int i =3D 2; i &lt; MAX_PARMS &amp=
;&amp; p[i] !=3D NULL; i++)</span><br><span>         {</span><br><span>    =
         /* the second parameter can be the renewal time */</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            if (i =3D=3D 2 &amp;&amp;=
 positive_atoi(p[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            if (i =3D=3D 2 &amp;&amp; positive_atoi(p[i], msglevel))</spa=
n><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                options-&gt;auth_token_renewal =3D positive_atoi(p[i])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                op=
tions-&gt;auth_token_renewal =3D positive_atoi(p[i], msglevel);</span><br><=
span>             }</span><br><span>             else if (streq(p[i], &quot=
;external-auth&quot;))</span><br><span>             {</span><br><span>@@ -7=
716,7 +7748,7 @@</span><br><span>         int n_bcast_buf;</span><br><span>=
 </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        n_bcast_buf =3D atoi(p[1]);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        n_bcast_buf =
=3D atoi_warn(p[1], msglevel);</span><br><span>         if (n_bcast_buf &lt=
; 1)</span><br><span>         {</span><br><span>             msg(msglevel, =
&quot;--bcast-buffers parameter must be &gt; 0&quot;);</span><br><span>@@ -=
7728,7 +7760,7 @@</span><br><span>         int tcp_queue_limit;</span><br><=
span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        tcp_queue_limit =3D ato=
i(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tcp=
_queue_limit =3D atoi_warn(p[1], msglevel);</span><br><span>         if (tc=
p_queue_limit &lt; 1)</span><br><span>         {</span><br><span>          =
   msg(msglevel, &quot;--tcp-queue-limit parameter must be &gt; 0&quot;);</=
span><br><span>@@ -7876,10 +7908,10 @@</span><br><span>         int ageing_=
time, check_interval;</span><br><span> </span><br><span>         VERIFY_PER=
MISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        ageing_time =3D atoi(p[1]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        ageing_time =3D atoi_warn(p[1], msglevel);</span>=
<br><span>         if (p[2])</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            check_interval =3D atoi(p[2])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            check_=
interval =3D atoi_warn(p[1], msglevel);</span><br><span>         }</span><b=
r><span>         else</span><br><span>         {</span><br><span>@@ -7908,7=
 +7940,7 @@</span><br><span>     else if (streq(p[0], &quot;push-continuati=
on&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><b=
r><span>         VERIFY_PERMISSION(OPT_P_PULL_MODE);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;push_continuation =3D a=
toi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ptions-&gt;push_continuation =3D atoi_warn(p[1], msglevel);</span><br><span=
>     }</span><br><span>     else if (streq(p[0], &quot;auth-user-pass&quot=
;) &amp;&amp; !p[2])</span><br><span>     {</span><br><span>@@ -7933,7 +796=
5,7 @@</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span>         options-&gt;sc_info.challenge_text =
=3D p[1];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
atoi(p[2]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (atoi_warn(p[1], msglevel))</span><br><span>         {</span><br><span> =
            options-&gt;sc_info.flags |=3D SC_ECHO;</span><br><span>       =
  }</span><br><span>@@ -8029,7 +8061,7 @@</span><br><span>             {</s=
pan><br><span>                 if (!streq(p[2], &quot;default&quot;))</span=
><br><span>                 {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                    int offset =3D atoi(p[2]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    int offset =3D optio=
ns_atoi(p[1], msglevel);</span><br><span> </span><br><span>                =
     if (!(offset &gt; -256 &amp;&amp; offset &lt; 256))</span><br><span>  =
                   {</span><br><span>@@ -8045,7 +8077,7 @@</span><br><span>=
                 {</span><br><span>                     const int min_lease=
 =3D 30;</span><br><span>                     int lease_time;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    lease_time =3D =
atoi(p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            lease_time =3D options_atoi(p[1], msglevel);</span><br><span>  =
                   if (lease_time &lt; min_lease)</span><br><span>         =
            {</span><br><span>                         msg(msglevel, &quot;=
--ip-win32 dynamic [offset] [lease-time]: lease time parameter (%d) must be=
 at least %d seconds&quot;, lease_time, min_lease);</span><br><span>@@ -816=
9,7 +8201,7 @@</span><br><span>         else if (streq(p[1], &quot;NBT&quot=
;) &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>         {</span><br><=
span>             int t;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            t =3D atoi(p[2]);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            t =3D options_atoi(p[1], msglevel);</span><br><spa=
n>             if (!(t =3D=3D 1 || t =3D=3D 2 || t =3D=3D 4 || t =3D=3D 8))=
</span><br><span>             {</span><br><span>                 msg(msglev=
el, &quot;--dhcp-option NBT: parameter (%d) must be 1, 2, 4, or 8&quot;, t)=
;</span><br><span>@@ -8227,7 +8259,7 @@</span><br><span> #if defined(TARGET=
_ANDROID)</span><br><span>         else if (streq(p[1], &quot;PROXY_HTTP&qu=
ot;) &amp;&amp; p[3] &amp;&amp; !p[4])</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;http_proxy_po=
rt =3D atoi(p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           o-&gt;http_proxy_port =3D options_atoi(p[1], msglevel);</span><b=
r><span>             o-&gt;http_proxy =3D p[2];</span><br><span>         }<=
/span><br><span> #endif</span><br><span>@@ -8261,7 +8293,7 @@</span><br><sp=
an>     {</span><br><span>         int s;</span><br><span>         VERIFY_P=
ERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        s =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        s =3D options_atoi(p[1], msglevel);</span><br><span>     =
    if (s &lt; 0 || s &gt;=3D 256)</span><br><span>         {</span><br><sp=
an>             msg(msglevel, &quot;--tap-sleep parameter must be between 0=
 and 255&quot;);</span><br><span>@@ -8344,7 +8376,7 @@</span><br><span>    =
     options-&gt;exit_event_name =3D p[1];</span><br><span>         if (p[2=
])</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            options-&gt;exit_event_initial_state =3D (atoi(p[2]) !=
=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
options-&gt;exit_event_initial_state =3D (options_atoi(p[1], msglevel) !=3D=
 0);</span><br><span>         }</span><br><span>     }</span><br><span>    =
 else if (streq(p[0], &quot;allow-nonadmin&quot;) &amp;&amp; !p[2])</span><=
br><span>@@ -8711,7 +8743,7 @@</span><br><span>         {</span><br><span> =
            int replay_window;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            replay_window =3D atoi(p[1]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            replay_window =
=3D atoi_warn(p[1], msglevel);</span><br><span>             if (!(MIN_SEQ_B=
ACKTRACK &lt;=3D replay_window &amp;&amp; replay_window &lt;=3D MAX_SEQ_BAC=
KTRACK))</span><br><span>             {</span><br><span>                 ms=
g(msglevel, &quot;replay-window window size parameter (%d) must be between =
%d and %d&quot;,</span><br><span>@@ -8726,7 +8758,7 @@</span><br><span>    =
         {</span><br><span>                 int replay_time;</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-                re=
play_time =3D atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                replay_time =3D atoi_warn(p[1], msglevel);</span><br>=
<span>                 if (!(MIN_TIME_BACKTRACK &lt;=3D replay_time &amp;&a=
mp; replay_time &lt;=3D MAX_TIME_BACKTRACK))</span><br><span>              =
   {</span><br><span>                     msg(msglevel, &quot;replay-window=
 time window parameter (%d) must be between %d and %d&quot;,</span><br><spa=
n>@@ -9168,7 +9200,7 @@</span><br><span>     else if (streq(p[0], &quot;tls=
-timeout&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</s=
pan><br><span>         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;tls_timeout =3D po=
sitive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       options-&gt;tls_timeout =3D positive_atoi(p[1], msglevel);</span><br=
><span>     }</span><br><span>     else if (streq(p[0], &quot;reneg-bytes&q=
uot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><s=
pan>@@ -9197,21 +9229,21 @@</span><br><span>     else if (streq(p[0], &quot=
;reneg-sec&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {<=
/span><br><span>         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;renegotiate_seco=
nds =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        options-&gt;renegotiate_seconds =3D positive_atoi(p[1], ms=
glevel);</span><br><span>         if (p[2])</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;re=
negotiate_seconds_min =3D positive_atoi(p[2]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            options-&gt;renegotiate_seconds_min =
=3D positive_atoi(p[2], msglevel);</span><br><span>         }</span><br><sp=
an>     }</span><br><span>     else if (streq(p[0], &quot;hand-window&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        options-&gt;handshake_window =3D positive_at=
oi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        op=
tions-&gt;handshake_window =3D positive_atoi(p[1], msglevel);</span><br><sp=
an>     }</span><br><span>     else if (streq(p[0], &quot;tran-window&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>=
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        options-&gt;transition_window =3D positive_a=
toi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ptions-&gt;transition_window =3D positive_atoi(p[1], msglevel);</span><br><=
span>     }</span><br><span>     else if (streq(p[0], &quot;tls-auth&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>@=
@ -9348,7 +9380,7 @@</span><br><span>     else if (streq(p[0], &quot;show-p=
kcs11-ids&quot;) &amp;&amp; !p[3])</span><br><span>     {</span><br><span> =
        char *provider =3D  p[1];</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        bool cert_private =3D (p[2] =3D=3D NULL ? false : ( ato=
i(p[2]) !=3D 0 ));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       bool cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[1], m=
sglevel) !=3D 0 ));</span><br><span> </span><br><span> #ifdef DEFAULT_PKCS1=
1_MODULE</span><br><span>         if (!provider)</span><br><span>@@ -9400,7=
 +9432,7 @@</span><br><span> </span><br><span>         for (j =3D 1; j &lt;=
 MAX_PARMS &amp;&amp; p[j] !=3D NULL; ++j)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;pkc=
s11_protected_authentication[j-1] =3D atoi(p[j]) !=3D 0 ? 1 : 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            options-&gt;pkcs11=
_protected_authentication[j-1] =3D atoi_warn(p[j], msglevel) !=3D 0 ? 1 : 0=
;</span><br><span>         }</span><br><span>     }</span><br><span>     el=
se if (streq(p[0], &quot;pkcs11-private-mode&quot;) &amp;&amp; p[1])</span>=
<br><span>@@ -9422,13 +9454,13 @@</span><br><span> </span><br><span>       =
  for (j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=3D NULL; ++j)</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       options-&gt;pkcs11_cert_private[j-1] =3D atoi(p[j]) !=3D 0 ? 1 : 0;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            options-=
&gt;pkcs11_cert_private[j-1] =3D atoi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;<=
/span><br><span>         }</span><br><span>     }</span><br><span>     else=
 if (streq(p[0], &quot;pkcs11-pin-cache&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT=
_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o=
ptions-&gt;pkcs11_pin_cache_period =3D atoi(p[1]);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        options-&gt;pkcs11_pin_cache_period =
=3D atoi_warn(p[1], msglevel);</span><br><span>     }</span><br><span>     =
else if (streq(p[0], &quot;pkcs11-id&quot;) &amp;&amp; p[1] &amp;&amp; !p[2=
])</span><br><span>     {</span><br><span>@@ -9457,12 +9489,12 @@</span><br=
><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_PEER_ID);</s=
pan><br><span>         options-&gt;use_peer_id =3D true;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        options-&gt;peer_id =3D atoi(p[1=
]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-=
&gt;peer_id =3D atoi_warn(p[1], msglevel);</span><br><span>     }</span><br=
><span> #ifdef HAVE_EXPORT_KEYING_MATERIAL</span><br><span>     else if (st=
req(p[0], &quot;keying-material-exporter&quot;) &amp;&amp; p[1] &amp;&amp; =
p[2])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        int ekm_length =3D positive_atoi(p[2]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        int ekm_length =3D positive_atoi=
(p[2], msglevel);</span><br><span> </span><br><span>         VERIFY_PERMISS=
ION(OPT_P_GENERAL);</span><br><span> </span><br><span>@@ -9521,7 +9553,7 @@=
</span><br><span>     else if (streq(p[0], &quot;vlan-pvid&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_GENERAL|OPT_P_INSTANCE);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        options-&gt;vlan_pvid =3D positive_atoi(p[=
1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options=
-&gt;vlan_pvid =3D positive_atoi(p[1], msglevel);</span><br><span>         =
if (options-&gt;vlan_pvid &lt; OPENVPN_8021Q_MIN_VID</span><br><span>      =
       || options-&gt;vlan_pvid &gt; OPENVPN_8021Q_MAX_VID)</span><br><span=
>         {</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/873?usp=3Demail">change 873</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/873?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie1e2eb54d516b3ae87c5ca56fe8=
edd77ee2be4de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 873 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--0QIEvoHDW6Y=--

