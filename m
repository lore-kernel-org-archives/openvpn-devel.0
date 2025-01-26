From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 26 Jan 2025 17:11:13 +0000
In-Reply-To: <gerrit.1737460984000.Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de@...2715...>
References: <gerrit.1737460984000.Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <659508123caf40373a2893a8b0edeb2fda417adb-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JUOqrID2/cA="; charset=UTF-8
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

--JUOqrID2/cA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/873?usp=3Demail

to look at the new patch set (#5).


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
1 file changed, 129 insertions(+), 78 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/873/5

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index bd5c056..b0600af 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5014,11 +5014,62 @@
 }
 #endif

-static int
-positive_atoi(const char *str)
+/** Checks if the string is a valid integer by checking if it can be
+ *  converted to an integer */
+static bool
+valid_integer(const char *str, bool positive)
 {
-    const int i =3D atoi(str);
-    return i < 0 ? 0 : i;
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
+
+/**
+ * Converts a str to a positive number if the string represents a postive
+ * integer number. Otherwise print a warning with msglevel and return 0
+ */
+static int
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
@@ -6043,7 +6094,7 @@
         int cache;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cache =3D atoi(p[1]);
+        cache =3D atoi_warn(p[1], msglevel);
         if (cache < 1)
         {
             msg(msglevel, "--management-log-cache parameter is out of rang=
e");
@@ -6355,7 +6406,7 @@
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
@@ -6372,7 +6423,7 @@
     else if (streq(p[0], "connect-retry") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);
-        options->ce.connect_retry_seconds =3D positive_atoi(p[1]);
+        options->ce.connect_retry_seconds =3D positive_atoi(p[1], msglevel=
);
         /*
          * Limit the base value of retry wait interval to 16 bits to avoid
          * overflow when scaled up for exponential backoff
@@ -6387,19 +6438,19 @@
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
@@ -6422,7 +6473,7 @@
     else if (streq(p[0], "gremlin") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->gremlin =3D positive_atoi(p[1]);
+        options->gremlin =3D positive_atoi(p[1], msglevel);
     }
 #endif
     else if (streq(p[0], "chroot") && p[1] && !p[2])
@@ -6554,7 +6605,7 @@
     else if (streq(p[0], "verb") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MESSAGES);
-        options->verbosity =3D positive_atoi(p[1]);
+        options->verbosity =3D positive_atoi(p[1], msglevel);
         if (options->verbosity >=3D (D_TLS_DEBUG_MED & M_DEBUG_LEVEL))
         {
             /* We pass this flag to the SSL library to avoid
@@ -6573,7 +6624,7 @@
     else if (streq(p[0], "mute") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_MESSAGES);
-        options->mute =3D positive_atoi(p[1]);
+        options->mute =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "errors-to-stderr") && !p[1])
     {
@@ -6586,7 +6637,7 @@
         options->status_file =3D p[1];
         if (p[2])
         {
-            options->status_file_update_freq =3D positive_atoi(p[2]);
+            options->status_file_update_freq =3D positive_atoi(p[2], msgle=
vel);
         }
     }
     else if (streq(p[0], "status-version") && p[1] && !p[2])
@@ -6594,7 +6645,7 @@
         int version;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        version =3D atoi(p[1]);
+        version =3D atoi_warn(p[1], msglevel);
         if (version < 1 || version > 3)
         {
             msg(msglevel, "--status-version must be 1 to 3");
@@ -6622,17 +6673,17 @@
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
@@ -6642,7 +6693,7 @@
     else if (streq(p[0], "tun-mtu-max") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        int max_mtu =3D positive_atoi(p[1]);
+        int max_mtu =3D positive_atoi(p[1], msglevel);
         if (max_mtu < 68 || max_mtu > 65536)
         {
             msg(msglevel, "--tun-mtu-max value '%s' is invalid", p[1]);
@@ -6655,13 +6706,13 @@
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
@@ -6687,7 +6738,7 @@
     else if (streq(p[0], "fragment") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);
-        options->ce.fragment =3D positive_atoi(p[1]);
+        options->ce.fragment =3D positive_atoi(p[1], msglevel);

         if (options->ce.fragment < 68)
         {
@@ -6718,23 +6769,23 @@
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
@@ -6764,7 +6815,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
 #ifdef TARGET_LINUX
-        options->tuntap_options.txqueuelen =3D positive_atoi(p[1]);
+        options->tuntap_options.txqueuelen =3D positive_atoi(p[1], msgleve=
l);
 #else
         msg(msglevel, "--txqueuelen not supported on this OS");
         goto err;
@@ -6775,7 +6826,7 @@
         int shaper;

         VERIFY_PERMISSION(OPT_P_SHAPER);
-        shaper =3D atoi(p[1]);
+        shaper =3D atoi_warn(p[1], msglevel);
         if (shaper < SHAPER_MIN || shaper > SHAPER_MAX)
         {
             msg(msglevel, "Bad shaper value, must be between %d and %d",
@@ -6823,7 +6874,7 @@
     else if (streq(p[0], "inactive") && p[1] && !p[3])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->inactivity_timeout =3D positive_atoi(p[1]);
+        options->inactivity_timeout =3D positive_atoi(p[1], msglevel);
         if (p[2])
         {
             int64_t val =3D atoll(p[2]);
@@ -6841,7 +6892,7 @@
     else if (streq(p[0], "session-timeout") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TIMER);
-        options->session_timeout =3D positive_atoi(p[1]);
+        options->session_timeout =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "proto") && p[1] && !p[2])
     {
@@ -7008,24 +7059,24 @@
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
@@ -7038,7 +7089,7 @@
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
@@ -7158,7 +7209,7 @@
     else if (streq(p[0], "route-metric") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        options->route_default_metric =3D positive_atoi(p[1]);
+        options->route_default_metric =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "route-delay") && !p[3])
     {
@@ -7166,10 +7217,10 @@
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
@@ -7334,7 +7385,7 @@
         }
         else if (streq(p[1], "SERVER_POLL_TIMEOUT") && p[2])
         {
-            options->ce.connect_timeout =3D positive_atoi(p[2]);
+            options->ce.connect_timeout =3D positive_atoi(p[2], msglevel);
         }
         else
         {
@@ -7366,14 +7417,14 @@
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
@@ -7556,7 +7607,7 @@
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
@@ -7588,8 +7639,8 @@
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
@@ -7603,8 +7654,8 @@
         int cf_max, cf_per;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cf_max =3D atoi(p[1]);
-        cf_per =3D atoi(p[2]);
+        cf_max =3D atoi_warn(p[1], msglevel);
+        cf_per =3D atoi_warn(p[2], msglevel);
         if (cf_max < 0 || cf_per < 0)
         {
             msg(msglevel, "--connect-freq parms must be > 0");
@@ -7634,7 +7685,7 @@
         int max_clients;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        max_clients =3D atoi(p[1]);
+        max_clients =3D atoi_warn(p[1], msglevel);
         if (max_clients < 0)
         {
             msg(msglevel, "--max-clients must be at least 1");
@@ -7650,7 +7701,7 @@
     else if (streq(p[0], "max-routes-per-client") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_INHERIT);
-        options->max_routes_per_client =3D max_int(atoi(p[1]), 1);
+        options->max_routes_per_client =3D max_int(positive_atoi(p[1], msg=
level), 1);
     }
     else if (streq(p[0], "client-cert-not-required") && !p[1])
     {
@@ -7734,14 +7785,14 @@
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
@@ -7821,7 +7872,7 @@
         int n_bcast_buf;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        n_bcast_buf =3D atoi(p[1]);
+        n_bcast_buf =3D atoi_warn(p[1], msglevel);
         if (n_bcast_buf < 1)
         {
             msg(msglevel, "--bcast-buffers parameter must be > 0");
@@ -7833,7 +7884,7 @@
         int tcp_queue_limit;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        tcp_queue_limit =3D atoi(p[1]);
+        tcp_queue_limit =3D atoi_warn(p[1], msglevel);
         if (tcp_queue_limit < 1)
         {
             msg(msglevel, "--tcp-queue-limit parameter must be > 0");
@@ -7964,10 +8015,10 @@
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
@@ -7996,7 +8047,7 @@
     else if (streq(p[0], "push-continuation") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_PULL_MODE);
-        options->push_continuation =3D atoi(p[1]);
+        options->push_continuation =3D atoi_warn(p[1], msglevel);
     }
     else if (streq(p[0], "auth-user-pass") && !p[2])
     {
@@ -8021,7 +8072,7 @@
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->sc_info.challenge_text =3D p[1];
-        if (atoi(p[2]))
+        if (atoi_warn(p[2], msglevel))
         {
             options->sc_info.flags |=3D SC_ECHO;
         }
@@ -8117,7 +8168,7 @@
             {
                 if (!streq(p[2], "default"))
                 {
-                    int offset =3D atoi(p[2]);
+                    int offset =3D atoi_warn(p[2], msglevel);

                     if (!(offset > -256 && offset < 256))
                     {
@@ -8133,7 +8184,7 @@
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
@@ -8257,7 +8308,7 @@
         else if (streq(p[1], "NBT") && p[2] && !p[3])
         {
             int t;
-            t =3D atoi(p[2]);
+            t =3D atoi_warn(p[2], msglevel);
             if (!(t =3D=3D 1 || t =3D=3D 2 || t =3D=3D 4 || t =3D=3D 8))
             {
                 msg(msglevel, "--dhcp-option NBT: parameter (%d) must be 1=
, 2, 4, or 8", t);
@@ -8315,7 +8366,7 @@
 #if defined(TARGET_ANDROID)
         else if (streq(p[1], "PROXY_HTTP") && p[3] && !p[4])
         {
-            o->http_proxy_port =3D atoi(p[3]);
+            o->http_proxy_port =3D positiove_atoi(p[3], msglevel);
             o->http_proxy =3D p[2];
         }
 #endif
@@ -8349,7 +8400,7 @@
     {
         int s;
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        s =3D atoi(p[1]);
+        s =3D atoi_warn(p[1], msglevel);
         if (s < 0 || s >=3D 256)
         {
             msg(msglevel, "--tap-sleep parameter must be between 0 and 255=
");
@@ -8432,7 +8483,7 @@
         options->exit_event_name =3D p[1];
         if (p[2])
         {
-            options->exit_event_initial_state =3D (atoi(p[2]) !=3D 0);
+            options->exit_event_initial_state =3D (atoi_warn(p[2], msgleve=
l) !=3D 0);
         }
     }
     else if (streq(p[0], "allow-nonadmin") && !p[2])
@@ -8799,7 +8850,7 @@
         {
             int replay_window;

-            replay_window =3D atoi(p[1]);
+            replay_window =3D atoi_warn(p[1], msglevel);
             if (!(MIN_SEQ_BACKTRACK <=3D replay_window && replay_window <=
=3D MAX_SEQ_BACKTRACK))
             {
                 msg(msglevel, "replay-window window size parameter (%d) mu=
st be between %d and %d",
@@ -8814,7 +8865,7 @@
             {
                 int replay_time;

-                replay_time =3D atoi(p[2]);
+                replay_time =3D atoi_warn(p[2], msglevel);
                 if (!(MIN_TIME_BACKTRACK <=3D replay_time && replay_time <=
=3D MAX_TIME_BACKTRACK))
                 {
                     msg(msglevel, "replay-window time window parameter (%d=
) must be between %d and %d",
@@ -9256,7 +9307,7 @@
     else if (streq(p[0], "tls-timeout") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        options->tls_timeout =3D positive_atoi(p[1]);
+        options->tls_timeout =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
@@ -9285,21 +9336,21 @@
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
@@ -9436,7 +9487,7 @@
     else if (streq(p[0], "show-pkcs11-ids") && !p[3])
     {
         char *provider =3D  p[1];
-        bool cert_private =3D (p[2] =3D=3D NULL ? false : ( atoi(p[2]) !=
=3D 0 ));
+        bool cert_private =3D (p[2] =3D=3D NULL ? false : (atoi_warn(p[2],=
 msglevel) !=3D 0 ));

 #ifdef DEFAULT_PKCS11_MODULE
         if (!provider)
@@ -9488,7 +9539,7 @@

         for (j =3D 1; j < MAX_PARMS && p[j] !=3D NULL; ++j)
         {
-            options->pkcs11_protected_authentication[j-1] =3D atoi(p[j]) !=
=3D 0 ? 1 : 0;
+            options->pkcs11_protected_authentication[j-1] =3D atoi_warn(p[=
j], msglevel) !=3D 0 ? 1 : 0;
         }
     }
     else if (streq(p[0], "pkcs11-private-mode") && p[1])
@@ -9510,13 +9561,13 @@

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
@@ -9545,12 +9596,12 @@
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

@@ -9609,7 +9660,7 @@
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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--JUOqrID2/cA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
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
gt;<br>Change-Id: Ie1e2eb54d516b3ae87c5ca56fe8edd77ee2be4de<br>Signed-off-b=
y: Arne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/options.c<b=
r>1 file changed, 129 insertions(+), 78 deletions(-)<br><br></pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/73/873/5</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index b=
d5c056..b0600af 100644</span><br><span>--- a/src/openvpn/options.c</span><b=
r><span>+++ b/src/openvpn/options.c</span><br><span>@@ -5014,11 +5014,62 @@=
</span><br><span> }</span><br><span> #endif</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-positive_atoi(const char *str)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/** Checks if the string is a valid=
 integer by checking if it can be</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ *  converted to an integer */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+valid_integer(const char *str, bool positive)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int i=
 =3D atoi(str);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn i &lt; 0 ? 0 : i;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char *endptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    long long i =3D strtoll(str, &amp;endptr, 10);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (i &lt; INT_MIN || (positive &amp;&amp; i &lt; 0) || =
*endptr !=3D &#39;\0&#39; || i &gt; INT_MAX)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        return false;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        return true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * Converts a str to a positive numb=
er if the string represents a postive</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * integer number. Otherwise print a warning with msgleve=
l and return 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+static int</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+positive_atoi(const char *str,=
 int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *endptr;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    long long i =3D strto=
ll(str, &amp;endptr, 10);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (i &lt=
; 0 || *endptr !=3D &#39;\0&#39; || i &gt; INT_MAX)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(msglevel, &quot;Cannot parse argument &#39;=
%s&#39; as non-negative integer&quot;,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            str);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        i =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (int) i;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * Converts a str to an integer if the string can be represented as an</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * integer number. Ot=
herwise print a warning with msglevel and return 0</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+static int</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+atoi_warn(const char *str, int msglevel)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    char *endptr;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    long long i =3D strtoll(str, &amp;endptr, 10);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (i &lt; INT_MIN || *endptr !=3D &#39;\0&#39; || i=
 &gt; INT_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(msgleve=
l, &quot;Cannot parse argument &#39;%s&#39; as integer&quot;, str);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        i =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return (int) i;</span><br><span> }</span><br><span> </span>=
<br><span> #ifdef _WIN32  /* This function is only used when compiling on W=
indows */</span><br><span>@@ -6043,7 +6094,7 @@</span><br><span>         in=
t cache;</span><br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P=
_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cac=
he =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       cache =3D atoi_warn(p[1], msglevel);</span><br><span>         if (ca=
che &lt; 1)</span><br><span>         {</span><br><span>             msg(msg=
level, &quot;--management-log-cache parameter is out of range&quot;);</span=
><br><span>@@ -6355,7 +6406,7 @@</span><br><span>         }</span><br><span=
>         else</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            options-&gt;resolve_retry_seconds =3D posit=
ive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        options-&gt;resolve_retry_seconds =3D positive_atoi(p[1], msglevel)=
;</span><br><span>         }</span><br><span>     }</span><br><span>     el=
se if ((streq(p[0], &quot;preresolve&quot;) || streq(p[0], &quot;ip-remote-=
hint&quot;)) &amp;&amp; !p[2])</span><br><span>@@ -6372,7 +6423,7 @@</span>=
<br><span>     else if (streq(p[0], &quot;connect-retry&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>         VERIF=
Y_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        options-&gt;ce.connect_retry_seconds =3D po=
sitive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       options-&gt;ce.connect_retry_seconds =3D positive_atoi(p[1], msgleve=
l);</span><br><span>         /*</span><br><span>          * Limit the base =
value of retry wait interval to 16 bits to avoid</span><br><span>          =
* overflow when scaled up for exponential backoff</span><br><span>@@ -6387,=
19 +6438,19 @@</span><br><span>         if (p[2])</span><br><span>         =
{</span><br><span>             options-&gt;ce.connect_retry_seconds_max =3D=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                max_i=
nt(positive_atoi(p[2]), options-&gt;ce.connect_retry_seconds);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                max_int(positive=
_atoi(p[2], msglevel), options-&gt;ce.connect_retry_seconds);</span><br><sp=
an>         }</span><br><span>     }</span><br><span>     else if ((streq(p=
[0], &quot;connect-timeout&quot;) || streq(p[0], &quot;server-poll-timeout&=
quot;))</span><br><span>              &amp;&amp; p[1] &amp;&amp; !p[2])</sp=
an><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERA=
L|OPT_P_CONNECTION);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       options-&gt;ce.connect_timeout =3D positive_atoi(p[1]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ce.connect_t=
imeout =3D positive_atoi(p[1], msglevel);</span><br><span>     }</span><br>=
<span>     else if (streq(p[0], &quot;connect-retry-max&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIF=
Y_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        options-&gt;connect_retry_max =3D positive_=
atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
options-&gt;connect_retry_max =3D positive_atoi(p[1], msglevel);</span><br>=
<span>     }</span><br><span>     else if (streq(p[0], &quot;ipchange&quot;=
) &amp;&amp; p[1])</span><br><span>     {</span><br><span>@@ -6422,7 +6473,=
7 @@</span><br><span>     else if (streq(p[0], &quot;gremlin&quot;) &amp;&a=
mp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         =
VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        options-&gt;gremlin =3D positive_atoi(p[1]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;gremlin =
=3D positive_atoi(p[1], msglevel);</span><br><span>     }</span><br><span> =
#endif</span><br><span>     else if (streq(p[0], &quot;chroot&quot;) &amp;&=
amp; p[1] &amp;&amp; !p[2])</span><br><span>@@ -6554,7 +6605,7 @@</span><br=
><span>     else if (streq(p[0], &quot;verb&quot;) &amp;&amp; p[1] &amp;&am=
p; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION=
(OPT_P_MESSAGES);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    options-&gt;verbosity =3D positive_atoi(p[1]);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        options-&gt;verbosity =3D positive_a=
toi(p[1], msglevel);</span><br><span>         if (options-&gt;verbosity &gt=
;=3D (D_TLS_DEBUG_MED &amp; M_DEBUG_LEVEL))</span><br><span>         {</spa=
n><br><span>             /* We pass this flag to the SSL library to avoid</=
span><br><span>@@ -6573,7 +6624,7 @@</span><br><span>     else if (streq(p[=
0], &quot;mute&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>   =
  {</span><br><span>         VERIFY_PERMISSION(OPT_P_MESSAGES);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;mute =3D posi=
tive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     options-&gt;mute =3D positive_atoi(p[1], msglevel);</span><br><span>  =
   }</span><br><span>     else if (streq(p[0], &quot;errors-to-stderr&quot;=
) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -6586,7 +6637=
,7 @@</span><br><span>         options-&gt;status_file =3D p[1];</span><br>=
<span>         if (p[2])</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            options-&gt;status_file_update_=
freq =3D positive_atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            options-&gt;status_file_update_freq =3D positive_atoi=
(p[2], msglevel);</span><br><span>         }</span><br><span>     }</span><=
br><span>     else if (streq(p[0], &quot;status-version&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[2])</span><br><span>@@ -6594,7 +6645,7 @@</span><br><span=
>         int version;</span><br><span> </span><br><span>         VERIFY_PE=
RMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        version =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        version =3D atoi_warn(p[1], msglevel);</span><br><sp=
an>         if (version &lt; 1 || version &gt; 3)</span><br><span>         =
{</span><br><span>             msg(msglevel, &quot;--status-version must be=
 1 to 3&quot;);</span><br><span>@@ -6622,17 +6673,17 @@</span><br><span>   =
  else if ((streq(p[0], &quot;link-mtu&quot;) || streq(p[0], &quot;udp-mtu&=
quot;)) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br>=
<span>         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.link_mtu =3D=
 positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        options-&gt;ce.link_mtu =3D positive_atoi(p[1], msglevel);</span>=
<br><span>         options-&gt;ce.link_mtu_defined =3D true;</span><br><spa=
n>     }</span><br><span>     else if (streq(p[0], &quot;tun-mtu&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_PUSH_MTU|OPT_P_CONNECTION);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        options-&gt;ce.tun_mtu =3D positi=
ve_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   options-&gt;ce.tun_mtu =3D positive_atoi(p[1], msglevel);</span><br><spa=
n>         options-&gt;ce.tun_mtu_defined =3D true;</span><br><span>       =
  if (p[2])</span><br><span>         {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            options-&gt;ce.occ_mtu =3D positive_atoi(p[2])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            option=
s-&gt;ce.occ_mtu =3D positive_atoi(p[2], msglevel);</span><br><span>       =
  }</span><br><span>         else</span><br><span>         {</span><br><spa=
n>@@ -6642,7 +6693,7 @@</span><br><span>     else if (streq(p[0], &quot;tun=
-mtu-max&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</s=
pan><br><span>         VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        int max_mtu =3D pos=
itive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      int max_mtu =3D positive_atoi(p[1], msglevel);</span><br><span>      =
   if (max_mtu &lt; 68 || max_mtu &gt; 65536)</span><br><span>         {</s=
pan><br><span>             msg(msglevel, &quot;--tun-mtu-max value &#39;%s&=
#39; is invalid&quot;, p[1]);</span><br><span>@@ -6655,13 +6706,13 @@</span=
><br><span>     else if (streq(p[0], &quot;tun-mtu-extra&quot;) &amp;&amp; =
p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERI=
FY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        options-&gt;ce.tun_mtu_extra =3D positive_atoi=
(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opti=
ons-&gt;ce.tun_mtu_extra =3D positive_atoi(p[1], msglevel);</span><br><span=
>         options-&gt;ce.tun_mtu_extra_defined =3D true;</span><br><span>  =
   }</span><br><span>     else if (streq(p[0], &quot;max-packet-size&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        int maxmtu =3D positive_atoi(p[1])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int maxmtu=
 =3D positive_atoi(p[1], msglevel);</span><br><span>         options-&gt;ce=
.tls_mtu =3D constrain_int(maxmtu, TLS_CHANNEL_MTU_MIN, TLS_CHANNEL_BUF_SIZ=
E);</span><br><span> </span><br><span>         if (maxmtu &lt; TLS_CHANNEL_=
MTU_MIN || maxmtu &gt; TLS_CHANNEL_BUF_SIZE)</span><br><span>@@ -6687,7 +67=
38,7 @@</span><br><span>     else if (streq(p[0], &quot;fragment&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_MTU|OPT_P_CONNECTION);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        options-&gt;ce.fragment =3D positive_a=
toi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ptions-&gt;ce.fragment =3D positive_atoi(p[1], msglevel);</span><br><span> =
</span><br><span>         if (options-&gt;ce.fragment &lt; 68)</span><br><s=
pan>         {</span><br><span>@@ -6718,23 +6769,23 @@</span><br><span>    =
 else if (streq(p[0], &quot;nice&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</=
span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_NICE=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt=
;nice =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        options-&gt;nice =3D atoi_warn(p[1], msglevel);</span><br><span> =
    }</span><br><span>     else if (streq(p[0], &quot;rcvbuf&quot;) &amp;&a=
mp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         =
VERIFY_PERMISSION(OPT_P_SOCKBUF);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        options-&gt;rcvbuf =3D positive_atoi(p[1]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;rcvbuf =3D =
positive_atoi(p[1], msglevel);</span><br><span>     }</span><br><span>     =
else if (streq(p[0], &quot;sndbuf&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])<=
/span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_SOC=
KBUF);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options=
-&gt;sndbuf =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        options-&gt;sndbuf =3D positive_atoi(p[1], msgleve=
l);</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;=
mark&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span>=
<br><span> #if defined(TARGET_LINUX) &amp;&amp; HAVE_DECL_SO_MARK</span><br=
><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        options-&gt;mark =3D atoi(p[1]);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;mark =
=3D atoi_warn(p[1], msglevel);</span><br><span> #endif</span><br><span>    =
 }</span><br><span>     else if (streq(p[0], &quot;socket-flags&quot;))</sp=
an><br><span>@@ -6764,7 +6815,7 @@</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span> #ifdef TARGET_LI=
NUX</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&g=
t;tuntap_options.txqueuelen =3D positive_atoi(p[1]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        options-&gt;tuntap_options.txqueu=
elen =3D positive_atoi(p[1], msglevel);</span><br><span> #else</span><br><s=
pan>         msg(msglevel, &quot;--txqueuelen not supported on this OS&quot=
;);</span><br><span>         goto err;</span><br><span>@@ -6775,7 +6826,7 @=
@</span><br><span>         int shaper;</span><br><span> </span><br><span>  =
       VERIFY_PERMISSION(OPT_P_SHAPER);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        shaper =3D atoi(p[1]);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        shaper =3D atoi_warn(p[1], msglevel);<=
/span><br><span>         if (shaper &lt; SHAPER_MIN || shaper &gt; SHAPER_M=
AX)</span><br><span>         {</span><br><span>             msg(msglevel, &=
quot;Bad shaper value, must be between %d and %d&quot;,</span><br><span>@@ =
-6823,7 +6874,7 @@</span><br><span>     else if (streq(p[0], &quot;inactive=
&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span><br><span>     {</span><br>=
<span>         VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        options-&gt;inactivity_timeout =3D positiv=
e_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  options-&gt;inactivity_timeout =3D positive_atoi(p[1], msglevel);</span><=
br><span>         if (p[2])</span><br><span>         {</span><br><span>    =
         int64_t val =3D atoll(p[2]);</span><br><span>@@ -6841,7 +6892,7 @@=
</span><br><span>     else if (streq(p[0], &quot;session-timeout&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        options-&gt;session_timeout =3D positive_atoi(p[1]);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;=
session_timeout =3D positive_atoi(p[1], msglevel);</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;proto&quot;) &amp;&amp; p[1]=
 &amp;&amp; !p[2])</span><br><span>     {</span><br><span>@@ -7008,24 +7059=
,24 @@</span><br><span>     else if (streq(p[0], &quot;keepalive&quot;) &am=
p;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     {</span=
><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        options-&gt;keepalive_ping =3D atoi=
(p[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        option=
s-&gt;keepalive_timeout =3D atoi(p[2]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        options-&gt;keepalive_ping =3D atoi_warn(p[1], =
msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o=
ptions-&gt;keepalive_timeout =3D atoi_warn(p[2], msglevel);</span><br><span=
>     }</span><br><span>     else if (streq(p[0], &quot;ping&quot;) &amp;&a=
mp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         =
VERIFY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        options-&gt;ping_send_timeout =3D positive_atoi(p[1]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;pi=
ng_send_timeout =3D positive_atoi(p[1], msglevel);</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;ping-exit&quot;) &amp;&amp; =
p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERI=
FY_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        options-&gt;ping_rec_timeout =3D positive_atoi(p[1]);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ping_re=
c_timeout =3D positive_atoi(p[1], msglevel);</span><br><span>         optio=
ns-&gt;ping_rec_timeout_action =3D PING_EXIT;</span><br><span>     }</span>=
<br><span>     else if (streq(p[0], &quot;ping-restart&quot;) &amp;&amp; p[=
1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY=
_PERMISSION(OPT_P_TIMER);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        options-&gt;ping_rec_timeout =3D positive_atoi(p[1]);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;ping_rec_=
timeout =3D positive_atoi(p[1], msglevel);</span><br><span>         options=
-&gt;ping_rec_timeout_action =3D PING_RESTART;</span><br><span>     }</span=
><br><span>     else if (streq(p[0], &quot;ping-timer-rem&quot;) &amp;&amp;=
 !p[1])</span><br><span>@@ -7038,7 +7089,7 @@</span><br><span>         VERI=
FY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNECTION|OPT_P_EXPLICIT_NOTIFY);</span>=
<br><span>         if (p[1])</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            options-&gt;ce.explicit_exit_=
notification =3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            options-&gt;ce.explicit_exit_notification =3D=
 positive_atoi(p[1], msglevel);</span><br><span>         }</span><br><span>=
         else</span><br><span>         {</span><br><span>@@ -7158,7 +7209,7=
 @@</span><br><span>     else if (streq(p[0], &quot;route-metric&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>     =
    VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        options-&gt;route_default_metric =3D positive_atoi(p[=
1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        options=
-&gt;route_default_metric =3D positive_atoi(p[1], msglevel);</span><br><spa=
n>     }</span><br><span>     else if (streq(p[0], &quot;route-delay&quot;)=
 &amp;&amp; !p[3])</span><br><span>     {</span><br><span>@@ -7166,10 +7217=
,10 @@</span><br><span>         options-&gt;route_delay_defined =3D true;</=
span><br><span>         if (p[1])</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;route_delay =
=3D positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            options-&gt;route_delay =3D positive_atoi(p[1], msglevel);=
</span><br><span>             if (p[2])</span><br><span>             {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                options-&g=
t;route_delay_window =3D positive_atoi(p[2]);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                options-&gt;route_delay_window =
=3D positive_atoi(p[2], msglevel);</span><br><span>             }</span><br=
><span>         }</span><br><span>         else</span><br><span>@@ -7334,7 =
+7385,7 @@</span><br><span>         }</span><br><span>         else if (str=
eq(p[1], &quot;SERVER_POLL_TIMEOUT&quot;) &amp;&amp; p[2])</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 options-&gt;ce.connect_timeout =3D positive_atoi(p[2]);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            options-&gt;ce.connect_tim=
eout =3D positive_atoi(p[2], msglevel);</span><br><span>         }</span><b=
r><span>         else</span><br><span>         {</span><br><span>@@ -7366,1=
4 +7417,14 @@</span><br><span>     else if (streq(p[0], &quot;script-securi=
ty&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><b=
r><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        script_security_set(atoi(p[1]));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        script_security_s=
et(atoi_warn(p[1], msglevel));</span><br><span>     }</span><br><span>     =
else if (streq(p[0], &quot;mssfix&quot;) &amp;&amp; !p[3])</span><br><span>=
     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL|OPT_P_CONNE=
CTION);</span><br><span>         if (p[1])</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            int mssfix =3D =
positive_atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            int mssfix =3D positive_atoi(p[1], msglevel);</span><br><span>=
             /* can be 0, but otherwise it needs to be high enough so we ca=
n</span><br><span>              * substract room for headers. */</span><br>=
<span>             if (mssfix !=3D 0</span><br><span>@@ -7556,7 +7607,7 @@<=
/span><br><span>         options-&gt;ifconfig_pool_persist_filename =3D p[1=
];</span><br><span>         if (p[2])</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;ifconfig=
_pool_persist_refresh_freq =3D positive_atoi(p[2]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            options-&gt;ifconfig_pool_per=
sist_refresh_freq =3D positive_atoi(p[2], msglevel);</span><br><span>      =
   }</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot=
;ifconfig-ipv6-pool&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><spa=
n>@@ -7588,8 +7639,8 @@</span><br><span>         int real, virtual;</span><=
br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        real =3D atoi(p[1])=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        virtual =3D =
atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
real =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        virtual =3D atoi_warn(p[1], msglevel);</span><br><s=
pan>         if (real &lt; 1 || virtual &lt; 1)</span><br><span>         {<=
/span><br><span>             msg(msglevel, &quot;--hash-size sizes must be =
&gt;=3D 1 (preferably a power of 2)&quot;);</span><br><span>@@ -7603,8 +765=
4,8 @@</span><br><span>         int cf_max, cf_per;</span><br><span> </span=
><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        cf_max =3D atoi(p[1]);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        cf_per =3D atoi(p[2]);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        cf_max =3D atoi=
_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        cf_per =3D atoi_warn(p[2], msglevel);</span><br><span>         i=
f (cf_max &lt; 0 || cf_per &lt; 0)</span><br><span>         {</span><br><sp=
an>             msg(msglevel, &quot;--connect-freq parms must be &gt; 0&quo=
t;);</span><br><span>@@ -7634,7 +7685,7 @@</span><br><span>         int max=
_clients;</span><br><span> </span><br><span>         VERIFY_PERMISSION(OPT_=
P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ma=
x_clients =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        max_clients =3D atoi_warn(p[1], msglevel);</span><br><span>  =
       if (max_clients &lt; 0)</span><br><span>         {</span><br><span> =
            msg(msglevel, &quot;--max-clients must be at least 1&quot;);</s=
pan><br><span>@@ -7650,7 +7701,7 @@</span><br><span>     else if (streq(p[0=
], &quot;max-routes-per-client&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</sp=
an><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_INHERI=
T);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&g=
t;max_routes_per_client =3D max_int(atoi(p[1]), 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        options-&gt;max_routes_per_client=
 =3D max_int(positive_atoi(p[1], msglevel), 1);</span><br><span>     }</spa=
n><br><span>     else if (streq(p[0], &quot;client-cert-not-required&quot;)=
 &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -7734,14 +7785=
,14 @@</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span>         options-&gt;auth_token_generate =3D =
true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-=
&gt;auth_token_lifetime =3D p[1] ? positive_atoi(p[1]) : 0;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;auth_token_life=
time =3D p[1] ? positive_atoi(p[1], msglevel) : 0;</span><br><span> </span>=
<br><span>         for (int i =3D 2; i &lt; MAX_PARMS &amp;&amp; p[i] !=3D =
NULL; i++)</span><br><span>         {</span><br><span>             /* the s=
econd parameter can be the renewal time */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-            if (i =3D=3D 2 &amp;&amp; positive_atoi(p[=
i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(i =3D=3D 2 &amp;&amp; valid_integer(p[i], true))</span><br><span>         =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
options-&gt;auth_token_renewal =3D positive_atoi(p[i]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                options-&gt;auth_token_=
renewal =3D positive_atoi(p[i], msglevel);</span><br><span>             }</=
span><br><span>             else if (streq(p[i], &quot;external-auth&quot;)=
)</span><br><span>             {</span><br><span>@@ -7821,7 +7872,7 @@</spa=
n><br><span>         int n_bcast_buf;</span><br><span> </span><br><span>   =
      VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        n_bcast_buf =3D atoi(p[1]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        n_bcast_buf =3D atoi_warn(p[1], m=
sglevel);</span><br><span>         if (n_bcast_buf &lt; 1)</span><br><span>=
         {</span><br><span>             msg(msglevel, &quot;--bcast-buffers=
 parameter must be &gt; 0&quot;);</span><br><span>@@ -7833,7 +7884,7 @@</sp=
an><br><span>         int tcp_queue_limit;</span><br><span> </span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        tcp_queue_limit =3D atoi(p[1]);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        tcp_queue_limit =3D atoi=
_warn(p[1], msglevel);</span><br><span>         if (tcp_queue_limit &lt; 1)=
</span><br><span>         {</span><br><span>             msg(msglevel, &quo=
t;--tcp-queue-limit parameter must be &gt; 0&quot;);</span><br><span>@@ -79=
64,10 +8015,10 @@</span><br><span>         int ageing_time, check_interval;=
</span><br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ageing_time=
 =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     ageing_time =3D atoi_warn(p[1], msglevel);</span><br><span>         if=
 (p[2])</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            check_interval =3D atoi(p[2]);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            check_interval =3D atoi_war=
n(p[2], msglevel);</span><br><span>         }</span><br><span>         else=
</span><br><span>         {</span><br><span>@@ -7996,7 +8047,7 @@</span><br=
><span>     else if (streq(p[0], &quot;push-continuation&quot;) &amp;&amp; =
p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERI=
FY_PERMISSION(OPT_P_PULL_MODE);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        options-&gt;push_continuation =3D atoi(p[1]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;push_contin=
uation =3D atoi_warn(p[1], msglevel);</span><br><span>     }</span><br><spa=
n>     else if (streq(p[0], &quot;auth-user-pass&quot;) &amp;&amp; !p[2])</=
span><br><span>     {</span><br><span>@@ -8021,7 +8072,7 @@</span><br><span=
>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><b=
r><span>         options-&gt;sc_info.challenge_text =3D p[1];</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (atoi(p[2]))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (atoi_warn(p[2], msg=
level))</span><br><span>         {</span><br><span>             options-&gt=
;sc_info.flags |=3D SC_ECHO;</span><br><span>         }</span><br><span>@@ =
-8117,7 +8168,7 @@</span><br><span>             {</span><br><span>         =
        if (!streq(p[2], &quot;default&quot;))</span><br><span>            =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     int offset =3D atoi(p[2]);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    int offset =3D atoi_warn(p[2], msglevel);</=
span><br><span> </span><br><span>                     if (!(offset &gt; -25=
6 &amp;&amp; offset &lt; 256))</span><br><span>                     {</span=
><br><span>@@ -8133,7 +8184,7 @@</span><br><span>                 {</span><=
br><span>                     const int min_lease =3D 30;</span><br><span> =
                    int lease_time;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    lease_time =3D atoi(p[3]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    lease_time =3D=
 atoi_warn(p[3], msglevel);</span><br><span>                     if (lease_=
time &lt; min_lease)</span><br><span>                     {</span><br><span=
>                         msg(msglevel, &quot;--ip-win32 dynamic [offset] [=
lease-time]: lease time parameter (%d) must be at least %d seconds&quot;, l=
ease_time, min_lease);</span><br><span>@@ -8257,7 +8308,7 @@</span><br><spa=
n>         else if (streq(p[1], &quot;NBT&quot;) &amp;&amp; p[2] &amp;&amp;=
 !p[3])</span><br><span>         {</span><br><span>             int t;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            t =3D atoi(p[2=
]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            t =
=3D atoi_warn(p[2], msglevel);</span><br><span>             if (!(t =3D=3D =
1 || t =3D=3D 2 || t =3D=3D 4 || t =3D=3D 8))</span><br><span>             =
{</span><br><span>                 msg(msglevel, &quot;--dhcp-option NBT: p=
arameter (%d) must be 1, 2, 4, or 8&quot;, t);</span><br><span>@@ -8315,7 +=
8366,7 @@</span><br><span> #if defined(TARGET_ANDROID)</span><br><span>    =
     else if (streq(p[1], &quot;PROXY_HTTP&quot;) &amp;&amp; p[3] &amp;&amp=
; !p[4])</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            o-&gt;http_proxy_port =3D atoi(p[3]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;http_proxy_po=
rt =3D positiove_atoi(p[3], msglevel);</span><br><span>             o-&gt;h=
ttp_proxy =3D p[2];</span><br><span>         }</span><br><span> #endif</spa=
n><br><span>@@ -8349,7 +8400,7 @@</span><br><span>     {</span><br><span>  =
       int s;</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        s =3D atoi(p[1])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s =3D atoi=
_warn(p[1], msglevel);</span><br><span>         if (s &lt; 0 || s &gt;=3D 2=
56)</span><br><span>         {</span><br><span>             msg(msglevel, &=
quot;--tap-sleep parameter must be between 0 and 255&quot;);</span><br><spa=
n>@@ -8432,7 +8483,7 @@</span><br><span>         options-&gt;exit_event_nam=
e =3D p[1];</span><br><span>         if (p[2])</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            options-&gt=
;exit_event_initial_state =3D (atoi(p[2]) !=3D 0);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            options-&gt;exit_event_initial_s=
tate =3D (atoi_warn(p[2], msglevel) !=3D 0);</span><br><span>         }</sp=
an><br><span>     }</span><br><span>     else if (streq(p[0], &quot;allow-n=
onadmin&quot;) &amp;&amp; !p[2])</span><br><span>@@ -8799,7 +8850,7 @@</spa=
n><br><span>         {</span><br><span>             int replay_window;</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    replay_window =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            replay_window =3D atoi_warn(p[1], msglevel);</spa=
n><br><span>             if (!(MIN_SEQ_BACKTRACK &lt;=3D replay_window &amp=
;&amp; replay_window &lt;=3D MAX_SEQ_BACKTRACK))</span><br><span>          =
   {</span><br><span>                 msg(msglevel, &quot;replay-window win=
dow size parameter (%d) must be between %d and %d&quot;,</span><br><span>@@=
 -8814,7 +8865,7 @@</span><br><span>             {</span><br><span>        =
         int replay_time;</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                replay_time =3D atoi(p[2]);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                replay_time =
=3D atoi_warn(p[2], msglevel);</span><br><span>                 if (!(MIN_T=
IME_BACKTRACK &lt;=3D replay_time &amp;&amp; replay_time &lt;=3D MAX_TIME_B=
ACKTRACK))</span><br><span>                 {</span><br><span>             =
        msg(msglevel, &quot;replay-window time window parameter (%d) must b=
e between %d and %d&quot;,</span><br><span>@@ -9256,7 +9307,7 @@</span><br>=
<span>     else if (streq(p[0], &quot;tls-timeout&quot;) &amp;&amp; p[1] &a=
mp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERM=
ISSION(OPT_P_TLS_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        options-&gt;tls_timeout =3D positive_atoi(p[1]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;tls_timeout =3D=
 positive_atoi(p[1], msglevel);</span><br><span>     }</span><br><span>    =
 else if (streq(p[0], &quot;reneg-bytes&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[2])</span><br><span>     {</span><br><span>@@ -9285,21 +9336,21 @@</span>=
<br><span>     else if (streq(p[0], &quot;reneg-sec&quot;) &amp;&amp; p[1] =
&amp;&amp; !p[3])</span><br><span>     {</span><br><span>         VERIFY_PE=
RMISSION(OPT_P_TLS_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        options-&gt;renegotiate_seconds =3D positive_atoi(p[1]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        options-&gt;reneg=
otiate_seconds =3D positive_atoi(p[1], msglevel);</span><br><span>         =
if (p[2])</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            options-&gt;renegotiate_seconds_min =3D positive=
_atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     options-&gt;renegotiate_seconds_min =3D positive_atoi(p[2], msglevel);=
</span><br><span>         }</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;hand-window&quot;) &amp;&amp; p[1] &amp;&amp; !p[2]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_T=
LS_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opt=
ions-&gt;handshake_window =3D positive_atoi(p[1]);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        options-&gt;handshake_window =3D pos=
itive_atoi(p[1], msglevel);</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;tran-window&quot;) &amp;&amp; p[1] &amp;&amp; !p[2]=
)</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_T=
LS_PARMS);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        opt=
ions-&gt;transition_window =3D positive_atoi(p[1]);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        options-&gt;transition_window =3D=
 positive_atoi(p[1], msglevel);</span><br><span>     }</span><br><span>    =
 else if (streq(p[0], &quot;tls-auth&quot;) &amp;&amp; p[1] &amp;&amp; !p[3=
])</span><br><span>     {</span><br><span>@@ -9436,7 +9487,7 @@</span><br><=
span>     else if (streq(p[0], &quot;show-pkcs11-ids&quot;) &amp;&amp; !p[3=
])</span><br><span>     {</span><br><span>         char *provider =3D  p[1]=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        bool cert_pr=
ivate =3D (p[2] =3D=3D NULL ? false : ( atoi(p[2]) !=3D 0 ));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        bool cert_private =3D (p[=
2] =3D=3D NULL ? false : (atoi_warn(p[2], msglevel) !=3D 0 ));</span><br><s=
pan> </span><br><span> #ifdef DEFAULT_PKCS11_MODULE</span><br><span>       =
  if (!provider)</span><br><span>@@ -9488,7 +9539,7 @@</span><br><span> </s=
pan><br><span>         for (j =3D 1; j &lt; MAX_PARMS &amp;&amp; p[j] !=3D =
NULL; ++j)</span><br><span>         {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            options-&gt;pkcs11_protected_authentication[j-1=
] =3D atoi(p[j]) !=3D 0 ? 1 : 0;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            options-&gt;pkcs11_protected_authentication[j-1] =
=3D atoi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;</span><br><span>         }</s=
pan><br><span>     }</span><br><span>     else if (streq(p[0], &quot;pkcs11=
-private-mode&quot;) &amp;&amp; p[1])</span><br><span>@@ -9510,13 +9561,13 =
@@</span><br><span> </span><br><span>         for (j =3D 1; j &lt; MAX_PARM=
S &amp;&amp; p[j] !=3D NULL; ++j)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            options-&gt;pkcs11_cert_=
private[j-1] =3D atoi(p[j]) !=3D 0 ? 1 : 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            options-&gt;pkcs11_cert_private[j-1] =
=3D atoi_warn(p[j], msglevel) !=3D 0 ? 1 : 0;</span><br><span>         }</s=
pan><br><span>     }</span><br><span>     else if (streq(p[0], &quot;pkcs11=
-pin-cache&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {<=
/span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;pkcs11_pin_cache_p=
eriod =3D atoi(p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        options-&gt;pkcs11_pin_cache_period =3D atoi_warn(p[1], msglevel)=
;</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;pk=
cs11-id&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</sp=
an><br><span>@@ -9545,12 +9596,12 @@</span><br><span>     {</span><br><span=
>         VERIFY_PERMISSION(OPT_P_PEER_ID);</span><br><span>         option=
s-&gt;use_peer_id =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        options-&gt;peer_id =3D atoi(p[1]);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        options-&gt;peer_id =3D atoi_warn(p[1=
], msglevel);</span><br><span>     }</span><br><span> #ifdef HAVE_EXPORT_KE=
YING_MATERIAL</span><br><span>     else if (streq(p[0], &quot;keying-materi=
al-exporter&quot;) &amp;&amp; p[1] &amp;&amp; p[2])</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int ekm_length=
 =3D positive_atoi(p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        int ekm_length =3D positive_atoi(p[2], msglevel);</span><br><=
span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br=
><span> </span><br><span>@@ -9609,7 +9660,7 @@</span><br><span>     else if=
 (streq(p[0], &quot;vlan-pvid&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</spa=
n><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL=
|OPT_P_INSTANCE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    options-&gt;vlan_pvid =3D positive_atoi(p[1]);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        options-&gt;vlan_pvid =3D positive_a=
toi(p[1], msglevel);</span><br><span>         if (options-&gt;vlan_pvid &lt=
; OPENVPN_8021Q_MIN_VID</span><br><span>             || options-&gt;vlan_pv=
id &gt; OPENVPN_8021Q_MAX_VID)</span><br><span>         {</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/873?usp=3Demail">change 873</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/873?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie1e2eb54d516b3ae87c5ca56fe8=
edd77ee2be4de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 873 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--JUOqrID2/cA=--

