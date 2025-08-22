From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 22 Aug 2025 13:45:22 +0000
References: <gerrit.1755870317000.Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2716e3fbca4c8de71b2e2f017af907eae8a61d59-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tZf8cqN2dJ0="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: options: Introduce
 atoi_constrained and review usages of atoi_warn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tZf8cqN2dJ0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1150?usp=3Demail

to review the following change.


Change subject: options: Introduce atoi_constrained and review usages of at=
oi_warn
......................................................................

options: Introduce atoi_constrained and review usages of atoi_warn

This is a more powerful version of atoi_warn that can
- check minimum and maximum values
- report error seperately from parsed value

This can be used to simplify a lot of option parsing.

Change-Id: Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/options.c
M src/openvpn/options_util.c
M src/openvpn/options_util.h
M tests/unit_tests/openvpn/test_misc.c
4 files changed, 143 insertions(+), 107 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/1150/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index e9584a8..b62e22c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6405,16 +6405,12 @@
     }
     else if (streq(p[0], "management-log-cache") && p[1] && !p[2])
     {
-        int cache;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cache =3D atoi_warn(p[1], msglevel);
-        if (cache < 1)
+        if (!atoi_constrained(p[1], &options->management_log_history_cache,
+                              "management-log-cache", 1, 0, msglevel))
         {
-            msg(msglevel, "--management-log-cache parameter is out of rang=
e");
             goto err;
         }
-        options->management_log_history_cache =3D cache;
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
 #ifdef ENABLE_PLUGIN
@@ -6963,16 +6959,11 @@
     }
     else if (streq(p[0], "status-version") && p[1] && !p[2])
     {
-        int version;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        version =3D atoi_warn(p[1], msglevel);
-        if (version < 1 || version > 3)
+        if (!atoi_constrained(p[1], &options->status_file_version, "status=
-version", 1, 3, msglevel))
         {
-            msg(msglevel, "--status-version must be 1 to 3");
             goto err;
         }
-        options->status_file_version =3D version;
     }
     else if (streq(p[0], "remap-usr1") && p[1] && !p[2])
     {
@@ -7145,16 +7136,11 @@
     }
     else if (streq(p[0], "shaper") && p[1] && !p[2])
     {
-        int shaper;
-
         VERIFY_PERMISSION(OPT_P_SHAPER);
-        shaper =3D atoi_warn(p[1], msglevel);
-        if (shaper < SHAPER_MIN || shaper > SHAPER_MAX)
+        if (!atoi_constrained(p[1], &options->shaper, "shaper", SHAPER_MIN=
, SHAPER_MAX, msglevel))
         {
-            msg(msglevel, "Bad shaper value, must be between %d and %d", S=
HAPER_MIN, SHAPER_MAX);
             goto err;
         }
-        options->shaper =3D shaper;
     }
     else if (streq(p[0], "port") && p[1] && !p[2])
     {
@@ -7723,7 +7709,12 @@
     else if (streq(p[0], "script-security") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        script_security_set(atoi_warn(p[1], msglevel));
+        int security;
+        if (atoi_constrained(p[1], &security,
+                             "script-security", SSEC_NONE, SSEC_PW_ENV, ms=
glevel))
+        {
+            script_security_set(security);
+        }
     }
     else if (streq(p[0], "mssfix") && !p[3])
     {
@@ -7943,11 +7934,9 @@
         int real, virtual;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        real =3D atoi_warn(p[1], msglevel);
-        virtual =3D atoi_warn(p[2], msglevel);
-        if (real < 1 || virtual < 1)
+        if (!atoi_constrained(p[1], &real, "hash-size real", 1, 0, msgleve=
l)
+            || !atoi_constrained(p[2], &virtual, "hash-size virtual", 1, 0=
, msglevel))
         {
-            msg(msglevel, "--hash-size sizes must be >=3D 1 (preferably a =
power of 2)");
             goto err;
         }
         options->real_hash_size =3D real;
@@ -7958,11 +7947,9 @@
         int cf_max, cf_per;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cf_max =3D atoi_warn(p[1], msglevel);
-        cf_per =3D atoi_warn(p[2], msglevel);
-        if (cf_max < 0 || cf_per < 0)
+        if (!atoi_constrained(p[1], &cf_max, "connect-freq n", 1, 0, msgle=
vel)
+            || !atoi_constrained(p[2], &cf_per, "connect-freq seconds", 1,=
 0, msglevel))
         {
-            msg(msglevel, "--connect-freq parms must be > 0");
             goto err;
         }
         options->cf_max =3D cf_max;
@@ -7970,15 +7957,12 @@
     }
     else if (streq(p[0], "connect-freq-initial") && p[1] && p[2] && !p[3])
     {
-        long cf_max, cf_per;
+        int cf_max, cf_per;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        char *e1, *e2;
-        cf_max =3D strtol(p[1], &e1, 10);
-        cf_per =3D strtol(p[2], &e2, 10);
-        if (cf_max < 0 || cf_per < 0 || *e1 !=3D '\0' || *e2 !=3D '\0')
+        if (!atoi_constrained(p[1], &cf_max, "connect-freq-initial n", 1, =
0, msglevel)
+            || !atoi_constrained(p[2], &cf_per, "connect-freq-initial seco=
nds", 1, 0, msglevel))
         {
-            msg(msglevel, "--connect-freq-initial parameters must be integ=
ers and >=3D 0");
             goto err;
         }
         options->cf_initial_max =3D cf_max;
@@ -7986,21 +7970,11 @@
     }
     else if (streq(p[0], "max-clients") && p[1] && !p[2])
     {
-        int max_clients;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        max_clients =3D atoi_warn(p[1], msglevel);
-        if (max_clients < 0)
+        if (!atoi_constrained(p[1], &options->max_clients, "max-clients", =
1, MAX_PEER_ID, msglevel))
         {
-            msg(msglevel, "--max-clients must be at least 1");
             goto err;
         }
-        if (max_clients >=3D MAX_PEER_ID) /* max peer-id value */
-        {
-            msg(msglevel, "--max-clients must be less than %d", MAX_PEER_I=
D);
-            goto err;
-        }
-        options->max_clients =3D max_clients;
     }
     else if (streq(p[0], "max-routes-per-client") && p[1] && !p[2])
     {
@@ -8172,27 +8146,13 @@
     }
     else if (streq(p[0], "bcast-buffers") && p[1] && !p[2])
     {
-        int n_bcast_buf;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        n_bcast_buf =3D atoi_warn(p[1], msglevel);
-        if (n_bcast_buf < 1)
-        {
-            msg(msglevel, "--bcast-buffers parameter must be > 0");
-        }
-        options->n_bcast_buf =3D n_bcast_buf;
+        atoi_constrained(p[1], &options->n_bcast_buf, "bcast-buffers", 1, =
0, msglevel);
     }
     else if (streq(p[0], "tcp-queue-limit") && p[1] && !p[2])
     {
-        int tcp_queue_limit;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        tcp_queue_limit =3D atoi_warn(p[1], msglevel);
-        if (tcp_queue_limit < 1)
-        {
-            msg(msglevel, "--tcp-queue-limit parameter must be > 0");
-        }
-        options->tcp_queue_limit =3D tcp_queue_limit;
+        atoi_constrained(p[1], &options->tcp_queue_limit, "tcp-queue-limit=
", 1, 0, msglevel);
     }
 #if PORT_SHARE
     else if (streq(p[0], "port-share") && p[1] && p[2] && !p[4])
@@ -8338,21 +8298,24 @@
         int ageing_time, check_interval;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ageing_time =3D atoi_warn(p[1], msglevel);
+        if (!atoi_constrained(p[1], &ageing_time, "stale-routes-check age"=
, 1, 0, msglevel))
+        {
+            goto err;
+        }
+
         if (p[2])
         {
-            check_interval =3D atoi_warn(p[2], msglevel);
+            if (!atoi_constrained(p[1], &check_interval,
+                                  "stale-routes-check interval", 1, 0, msg=
level))
+            {
+                goto err;
+            }
         }
         else
         {
             check_interval =3D ageing_time;
         }

-        if (ageing_time < 1 || check_interval < 1)
-        {
-            msg(msglevel, "--stale-routes-check aging time and check inter=
val must be >=3D 1");
-            goto err;
-        }
         options->stale_routes_ageing_time =3D ageing_time;
         options->stale_routes_check_interval =3D check_interval;
     }
@@ -8370,7 +8333,7 @@
     else if (streq(p[0], "push-continuation") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_PULL_MODE);
-        options->push_continuation =3D atoi_warn(p[1], msglevel);
+        atoi_constrained(p[1], &options->push_continuation, "push-continua=
tion", 0, 2, msglevel);
     }
     else if (streq(p[0], "auth-user-pass") && !p[2])
     {
@@ -8489,33 +8452,22 @@
             {
                 if (!streq(p[2], "default"))
                 {
-                    int offset =3D atoi_warn(p[2], msglevel);
+                    int offset;

-                    if (!(offset > -256 && offset < 256))
+                    if (!atoi_constrained(p[1], &offset, "ip-win32 offset"=
, -256, 256, msglevel))
                     {
-                        msg(msglevel,
-                            "--ip-win32 dynamic [offset] [lease-time]: off=
set (%d) must be > -256 and < 256",
-                            offset);
                         goto err;
                     }
-
                     to->dhcp_masq_custom_offset =3D true;
                     to->dhcp_masq_offset =3D offset;
                 }

                 if (p[3])
                 {
-                    const int min_lease =3D 30;
-                    int lease_time;
-                    lease_time =3D atoi_warn(p[3], msglevel);
-                    if (lease_time < min_lease)
+                    if (!atoi_constrained(p[1], &to->dhcp_lease_time, "ip-=
win32 lease time", 30, 0, msglevel))
                     {
-                        msg(msglevel,
-                            "--ip-win32 dynamic [offset] [lease-time]: lea=
se time parameter (%d) must be at least %d seconds",
-                            lease_time, min_lease);
                         goto err;
                     }
-                    to->dhcp_lease_time =3D lease_time;
                 }
             }
         }
@@ -8613,8 +8565,7 @@
         }
         else if (streq(p[1], "NBT") && p[2] && !p[3])
         {
-            int t;
-            t =3D atoi_warn(p[2], msglevel);
+            int t =3D atoi_warn(p[2], msglevel);
             if (!(t =3D=3D 1 || t =3D=3D 2 || t =3D=3D 4 || t =3D=3D 8))
             {
                 msg(msglevel, "--dhcp-option NBT: parameter (%d) must be 1=
, 2, 4, or 8", t);
@@ -8688,15 +8639,12 @@
     }
     else if (streq(p[0], "tap-sleep") && p[1] && !p[2])
     {
-        int s;
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        s =3D atoi_warn(p[1], msglevel);
-        if (s < 0 || s >=3D 256)
+        if (!atoi_constrained(p[1], &options->tuntap_options.tap_sleep,
+                              "tap-sleep", 0, 255, msglevel))
         {
-            msg(msglevel, "--tap-sleep parameter must be between 0 and 255=
");
             goto err;
         }
-        options->tuntap_options.tap_sleep =3D s;
     }
     else if (streq(p[0], "dhcp-renew") && !p[1])
     {
@@ -9136,30 +9084,19 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         if (p[1])
         {
-            int replay_window;
-
-            replay_window =3D atoi_warn(p[1], msglevel);
-            if (!(MIN_SEQ_BACKTRACK <=3D replay_window && replay_window <=
=3D MAX_SEQ_BACKTRACK))
+            if (!atoi_constrained(p[1], &options->replay_window, "replay-w=
indow windows size",
+                                  MIN_SEQ_BACKTRACK, MAX_SEQ_BACKTRACK, ms=
glevel))
             {
-                msg(msglevel, "replay-window window size parameter (%d) mu=
st be between %d and %d",
-                    replay_window, MIN_SEQ_BACKTRACK, MAX_SEQ_BACKTRACK);
                 goto err;
             }
-            options->replay_window =3D replay_window;

             if (p[2])
             {
-                int replay_time;
-
-                replay_time =3D atoi_warn(p[2], msglevel);
-                if (!(MIN_TIME_BACKTRACK <=3D replay_time && replay_time <=
=3D MAX_TIME_BACKTRACK))
+                if (!atoi_constrained(p[2], &options->replay_time, "replay=
-window time window",
+                                      MIN_TIME_BACKTRACK, MAX_TIME_BACKTRA=
CK, msglevel))
                 {
-                    msg(msglevel,
-                        "replay-window time window parameter (%d) must be =
between %d and %d",
-                        replay_time, MIN_TIME_BACKTRACK, MAX_TIME_BACKTRAC=
K);
                     goto err;
                 }
-                options->replay_time =3D replay_time;
             }
         }
         else
@@ -9755,7 +9692,7 @@
         else if (!p[2])
         {
             char *endp =3D NULL;
-            int i =3D strtol(provider, &endp, 10);
+            long i =3D strtol(provider, &endp, 10);

             if (*endp =3D=3D 0)
             {
@@ -9826,7 +9763,7 @@
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->pkcs11_pin_cache_period =3D atoi_warn(p[1], msglevel);
+        options->pkcs11_pin_cache_period =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "pkcs11-id") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index c3938a7..c1f7c74 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -146,6 +146,41 @@
     return (int)i;
 }

+bool
+atoi_constrained(const char *str, int *value, const char *name, int min, i=
nt max, int msglevel)
+{
+    if (!max)
+    {
+        max =3D INT_MAX;
+    }
+    ASSERT(min < max);
+
+    char *endptr;
+    long long i =3D strtoll(str, &endptr, 10);
+    if (i < INT_MIN || *endptr !=3D '\0' || i > INT_MAX)
+    {
+        msg(msglevel, "%s: Cannot parse '%s' as integer", name, str);
+        return false;
+    }
+    if (i < min || i > max)
+    {
+        if (max =3D=3D INT_MAX) /* nicer message for common case */
+        {
+            msg(msglevel, "%s: Must be an integer >=3D %d, not %lld",
+                name, min, i);
+        }
+        else
+        {
+            msg(msglevel, "%s: Must be an integer between %d and %d, not %=
lld",
+                name, min, max, i);
+        }
+        return false;
+    }
+
+    *value =3D i;
+    return true;
+}
+
 static const char *updatable_options[] =3D { "block-ipv6", "block-outside-=
dns",
                                            "dhcp-option", "dns",
                                            "ifconfig", "ifconfig-ipv6",
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 6f81b1e..d5ae8b9 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -41,11 +41,24 @@

 /**
  * Converts a str to an integer if the string can be represented as an
- * integer number. Otherwise print a warning with msglevel and return 0
+ * integer number. Otherwise print a warning with \p msglevel and return 0
  */
 int atoi_warn(const char *str, int msglevel);

 /**
+ * Converts a str to an integer if the string can be represented as an
+ * integer number and is between \p min and \p max.
+ * If \p max is 0, \p INT_MAX is used instead.
+ * The integer is stored in \p value.
+ * On error, print a warning with \p msglevel using \p name. \p value is
+ * not changed on error.
+ *
+ * @return \c true if the integer has been parsed and stored in value, \c =
false otherwise
+ */
+bool atoi_constrained(const char *str, int *value, const char *name, int m=
in, int max,
+                      int msglevel);
+
+/**
  * Filter an option line by all pull filters.
  *
  * If a match is found, the line is modified depending on
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvp=
n/test_misc.c
index 1857922..80a5dee 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -351,6 +351,14 @@
     assert_int_equal(atoi_warn("0", msglevel), 0);
     assert_int_equal(atoi_warn("-1194", msglevel), -1194);

+    int parameter =3D 0;
+    assert_true(atoi_constrained("1234", &parameter, "test", 0, 0, msgleve=
l));
+    assert_int_equal(parameter, 1234);
+    assert_true(atoi_constrained("0", &parameter, "test", -1, 0, msglevel)=
);
+    assert_int_equal(parameter, 0);
+    assert_true(atoi_constrained("-1194", &parameter, "test", INT_MIN, INT=
_MAX, msglevel));
+    assert_int_equal(parameter, -1194);
+
     CLEAR(mock_msg_buf);
     assert_int_equal(positive_atoi("-1234", msglevel), 0);
     assert_string_equal(mock_msg_buf, "Cannot parse argument '-1234' as no=
n-negative integer");
@@ -365,6 +373,12 @@
     assert_string_equal(mock_msg_buf, "Cannot parse argument '2147483653' =
as integer");

     CLEAR(mock_msg_buf);
+    parameter =3D -42;
+    assert_false(atoi_constrained("2147483653", &parameter, "test", 0, 0, =
msglevel));
+    assert_string_equal(mock_msg_buf, "test: Cannot parse '2147483653' as =
integer");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
     assert_int_equal(positive_atoi("foo77", msglevel), 0);
     assert_string_equal(mock_msg_buf, "Cannot parse argument 'foo77' as no=
n-negative integer");

@@ -373,6 +387,18 @@
     assert_string_equal(mock_msg_buf, "Cannot parse argument '77foo' as no=
n-negative integer");

     CLEAR(mock_msg_buf);
+    parameter =3D -42;
+    assert_false(atoi_constrained("foo77", &parameter, "test", 0, 0, msgle=
vel));
+    assert_string_equal(mock_msg_buf, "test: Cannot parse 'foo77' as integ=
er");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
+    parameter =3D -42;
+    assert_false(atoi_constrained("77foo", &parameter, "test", 0, 0, msgle=
vel));
+    assert_string_equal(mock_msg_buf, "test: Cannot parse '77foo' as integ=
er");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
     assert_int_equal(atoi_warn("foo77", msglevel), 0);
     assert_string_equal(mock_msg_buf, "Cannot parse argument 'foo77' as in=
teger");

@@ -380,6 +406,31 @@
     assert_int_equal(atoi_warn("77foo", msglevel), 0);
     assert_string_equal(mock_msg_buf, "Cannot parse argument '77foo' as in=
teger");

+    /* special tests for _constrained */
+    CLEAR(mock_msg_buf);
+    parameter =3D -42;
+    assert_false(atoi_constrained("77", &parameter, "test", 0, 76, msgleve=
l));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer between 0 =
and 76, not 77");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
+    parameter =3D -42;
+    assert_false(atoi_constrained("-77", &parameter, "test", -76, 76, msgl=
evel));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer between -7=
6 and 76, not -77");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
+    parameter =3D -42;
+    assert_false(atoi_constrained("-77", &parameter, "test", 0, 0, msgleve=
l));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer >=3D 0, no=
t -77");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
+    parameter =3D -42;
+    assert_false(atoi_constrained("0", &parameter, "test", 1, 0, msglevel)=
);
+    assert_string_equal(mock_msg_buf, "test: Must be an integer >=3D 1, no=
t 0");
+    assert_int_equal(parameter, -42);
+
     mock_set_debug_level(saved_log_level);
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1150?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7
Gerrit-Change-Number: 1150
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--tZf8cqN2dJ0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1150?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">options: Introduce atoi_constrained and review usages of ato=
i_warn<br><br>This is a more powerful version of atoi_warn that can<br>- ch=
eck minimum and maximum values<br>- report error seperately from parsed val=
ue<br><br>This can be used to simplify a lot of option parsing.<br><br>Chan=
ge-Id: Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7<br>Signed-off-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/options.c<br>M s=
rc/openvpn/options_util.c<br>M src/openvpn/options_util.h<br>M tests/unit_t=
ests/openvpn/test_misc.c<br>4 files changed, 143 insertions(+), 107 deletio=
ns(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/50/1150/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/option=
s.c</span><br><span>index e9584a8..b62e22c 100644</span><br><span>--- a/src=
/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><s=
pan>@@ -6405,16 +6405,12 @@</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;management-log-cache&quot;) &amp;&amp; p[1] &amp;&a=
mp; !p[2])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        int cache;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        cache =3D atoi_warn(=
p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (cache &lt; 1)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!atoi_constrained(p[1], &amp;options-&gt;management_log_histor=
y_cache,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                   &quot;management-log-cache&quot;, 1, 0, msglevel))</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            msg(msglevel, &quot;--management-log-cache parameter is out of =
range&quot;);</span><br><span>             goto err;</span><br><span>      =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&=
gt;management_log_history_cache =3D cache;</span><br><span>     }</span><br=
><span> #endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> #ifdef ENABLE=
_PLUGIN</span><br><span>@@ -6963,16 +6959,11 @@</span><br><span>     }</spa=
n><br><span>     else if (streq(p[0], &quot;status-version&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        int version;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span>         VERIFY_PERMISSION(OPT_P_=
GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        vers=
ion =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (version &lt; 1 || version &gt; 3)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[1], =
&amp;options-&gt;status_file_version, &quot;status-version&quot;, 1, 3, msg=
level))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            msg(msglevel, &quot;--status-version must be 1 to =
3&quot;);</span><br><span>             goto err;</span><br><span>         }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;s=
tatus_file_version =3D version;</span><br><span>     }</span><br><span>    =
 else if (streq(p[0], &quot;remap-usr1&quot;) &amp;&amp; p[1] &amp;&amp; !p=
[2])</span><br><span>     {</span><br><span>@@ -7145,16 +7136,11 @@</span><=
br><span>     }</span><br><span>     else if (streq(p[0], &quot;shaper&quot=
;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        int shaper;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         VERIFY_PERMIS=
SION(OPT_P_SHAPER);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      shaper =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (shaper &lt; SHAPER_MIN || shaper &gt; SHA=
PER_MAX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!atoi_constrained(p[1], &amp;options-&gt;shaper, &quot;shaper&quot;, SHAPE=
R_MIN, SHAPER_MAX, msglevel))</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;Bad shap=
er value, must be between %d and %d&quot;, SHAPER_MIN, SHAPER_MAX);</span><=
br><span>             goto err;</span><br><span>         }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;shaper =3D shaper;=
</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;por=
t&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br=
><span>@@ -7723,7 +7709,12 @@</span><br><span>     else if (streq(p[0], &qu=
ot;script-security&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span=
>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        script_security_set(at=
oi_warn(p[1], msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        int security;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (atoi_constrained(p[1], &amp;security,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                             &quot;sc=
ript-security&quot;, SSEC_NONE, SSEC_PW_ENV, msglevel))</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            script_security_set(security);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>=
     }</span><br><span>     else if (streq(p[0], &quot;mssfix&quot;) &amp;&=
amp; !p[3])</span><br><span>     {</span><br><span>@@ -7943,11 +7934,9 @@</=
span><br><span>         int real, virtual;</span><br><span> </span><br><spa=
n>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        real =3D atoi_warn(p[1], msglevel);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        virtual =3D atoi_warn(=
p[2], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (real &lt; 1 || virtual &lt; 1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;real, &quot;hash=
-size real&quot;, 1, 0, msglevel)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            || !atoi_constrained(p[2], &amp;virtual, &quot;ha=
sh-size virtual&quot;, 1, 0, msglevel))</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quo=
t;--hash-size sizes must be &gt;=3D 1 (preferably a power of 2)&quot;);</sp=
an><br><span>             goto err;</span><br><span>         }</span><br><s=
pan>         options-&gt;real_hash_size =3D real;</span><br><span>@@ -7958,=
11 +7947,9 @@</span><br><span>         int cf_max, cf_per;</span><br><span>=
 </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        cf_max =3D atoi_warn(p[1], m=
sglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cf_p=
er =3D atoi_warn(p[2], msglevel);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        if (cf_max &lt; 0 || cf_per &lt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[1], &am=
p;cf_max, &quot;connect-freq n&quot;, 1, 0, msglevel)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            || !atoi_constrained(p[2], &a=
mp;cf_per, &quot;connect-freq seconds&quot;, 1, 0, msglevel))</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(msglevel, &quot;--connect-freq parms must be &gt; 0&quot;);</span><=
br><span>             goto err;</span><br><span>         }</span><br><span>=
         options-&gt;cf_max =3D cf_max;</span><br><span>@@ -7970,15 +7957,1=
2 @@</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot=
;connect-freq-initial&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;&amp; !p[=
3])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        long cf_max, cf_per;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        int cf_max, cf_per;</span><br><span> </span><br><span=
>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        char *e1, *e2;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        cf_max =3D strtol(p[1], &amp;e1, 10);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        cf_per =3D strtol(p[=
2], &amp;e2, 10);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (cf_max &lt; 0 || cf_per &lt; 0 || *e1 !=3D &#39;\0&#39; || *e2 !=3D=
 &#39;\0&#39;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (!atoi_constrained(p[1], &amp;cf_max, &quot;connect-freq-initial n&qu=
ot;, 1, 0, msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            || !atoi_constrained(p[2], &amp;cf_per, &quot;connect-freq-ini=
tial seconds&quot;, 1, 0, msglevel))</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;-=
-connect-freq-initial parameters must be integers and &gt;=3D 0&quot;);</sp=
an><br><span>             goto err;</span><br><span>         }</span><br><s=
pan>         options-&gt;cf_initial_max =3D cf_max;</span><br><span>@@ -798=
6,21 +7970,11 @@</span><br><span>     }</span><br><span>     else if (streq=
(p[0], &quot;max-clients&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br=
><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
int max_clients;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        max_clients =3D atoi_warn(p[1], ms=
glevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (m=
ax_clients &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (!atoi_constrained(p[1], &amp;options-&gt;max_clients, &quot;max-=
clients&quot;, 1, MAX_PEER_ID, msglevel))</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &q=
uot;--max-clients must be at least 1&quot;);</span><br><span>             g=
oto err;</span><br><span>         }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        if (max_clients &gt;=3D MAX_PEER_ID) /* max peer-id v=
alue */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, =
&quot;--max-clients must be less than %d&quot;, MAX_PEER_ID);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            goto err;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        options-&gt;max_clients =3D max_clients=
;</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;ma=
x-routes-per-client&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><spa=
n>     {</span><br><span>@@ -8172,27 +8146,13 @@</span><br><span>     }</sp=
an><br><span>     else if (streq(p[0], &quot;bcast-buffers&quot;) &amp;&amp=
; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        int n_bcast_buf;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>         VERIFY_PERMISSION(OP=
T_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
n_bcast_buf =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (n_bcast_buf &lt; 1)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            msg(msglevel, &quot;--bcast-buffers paramet=
er must be &gt; 0&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
options-&gt;n_bcast_buf =3D n_bcast_buf;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        atoi_constrained(p[1], &amp;options-&gt;n_bcas=
t_buf, &quot;bcast-buffers&quot;, 1, 0, msglevel);</span><br><span>     }</=
span><br><span>     else if (streq(p[0], &quot;tcp-queue-limit&quot;) &amp;=
&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        int tcp_queue_limit;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         VERIFY_PER=
MISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        tcp_queue_limit =3D atoi_warn(p[1], msglevel);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (tcp_queue_limit &lt; 1)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;--tcp-=
queue-limit parameter must be &gt; 0&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        options-&gt;tcp_queue_limit =3D tcp_queue_limit;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[=
1], &amp;options-&gt;tcp_queue_limit, &quot;tcp-queue-limit&quot;, 1, 0, ms=
glevel);</span><br><span>     }</span><br><span> #if PORT_SHARE</span><br><=
span>     else if (streq(p[0], &quot;port-share&quot;) &amp;&amp; p[1] &amp=
;&amp; p[2] &amp;&amp; !p[4])</span><br><span>@@ -8338,21 +8298,24 @@</span=
><br><span>         int ageing_time, check_interval;</span><br><span> </spa=
n><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        ageing_time =3D atoi_warn(p[1], ms=
glevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(!atoi_constrained(p[1], &amp;ageing_time, &quot;stale-routes-check age&quo=
t;, 1, 0, msglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
         if (p[2])</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            check_interval =3D atoi_warn(p[2], msgl=
evel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (!atoi_constrained(p[1], &amp;check_interval,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                  &quot;stale-r=
outes-check interval&quot;, 1, 0, msglevel))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                goto err;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span>         }</span><br=
><span>         else</span><br><span>         {</span><br><span>           =
  check_interval =3D ageing_time;</span><br><span>         }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ageing=
_time &lt; 1 || check_interval &lt; 1)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            msg(msglevel, &quot;--stale-routes-check aging time and ch=
eck interval must be &gt;=3D 1&quot;);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            goto err;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span>         options-&gt;stale_route=
s_ageing_time =3D ageing_time;</span><br><span>         options-&gt;stale_r=
outes_check_interval =3D check_interval;</span><br><span>     }</span><br><=
span>@@ -8370,7 +8333,7 @@</span><br><span>     else if (streq(p[0], &quot;=
push-continuation&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>=
     {</span><br><span>         VERIFY_PERMISSION(OPT_P_PULL_MODE);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;push_cont=
inuation =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        atoi_constrained(p[1], &amp;options-&gt;push_co=
ntinuation, &quot;push-continuation&quot;, 0, 2, msglevel);</span><br><span=
>     }</span><br><span>     else if (streq(p[0], &quot;auth-user-pass&quot=
;) &amp;&amp; !p[2])</span><br><span>     {</span><br><span>@@ -8489,33 +84=
52,22 @@</span><br><span>             {</span><br><span>                 if=
 (!streq(p[2], &quot;default&quot;))</span><br><span>                 {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    int o=
ffset =3D atoi_warn(p[2], msglevel);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    int offset;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    if (!(offs=
et &gt; -256 &amp;&amp; offset &lt; 256))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    if (!atoi_constrained(p[1], &amp;=
offset, &quot;ip-win32 offset&quot;, -256, 256, msglevel))</span><br><span>=
                     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                        msg(msglevel,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                            &quot;--ip-win32 dynamic [offs=
et] [lease-time]: offset (%d) must be &gt; -256 and &lt; 256&quot;,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                            o=
ffset);</span><br><span>                         goto err;</span><br><span>=
                     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span>                     to-&gt;dhcp_masq_custom_offset =3D t=
rue;</span><br><span>                     to-&gt;dhcp_masq_offset =3D offse=
t;</span><br><span>                 }</span><br><span> </span><br><span>   =
              if (p[3])</span><br><span>                 {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    const int min_leas=
e =3D 30;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        int lease_time;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    lease_time =3D atoi_warn(p[3], msglevel);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    if (lease_tim=
e &lt; min_lease)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  if (!atoi_constrained(p[1], &amp;to-&gt;dhcp_lease_time, =
&quot;ip-win32 lease time&quot;, 30, 0, msglevel))</span><br><span>        =
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                            &quot;--ip-win32 dynamic [offset] [lea=
se-time]: lease time parameter (%d) must be at least %d seconds&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
  lease_time, min_lease);</span><br><span>                         goto err=
;</span><br><span>                     }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    to-&gt;dhcp_lease_time =3D lease_tim=
e;</span><br><span>                 }</span><br><span>             }</span>=
<br><span>         }</span><br><span>@@ -8613,8 +8565,7 @@</span><br><span>=
         }</span><br><span>         else if (streq(p[1], &quot;NBT&quot;) &=
amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            int t;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            t =3D atoi_warn(p[2], msglev=
el);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int=
 t =3D atoi_warn(p[2], msglevel);</span><br><span>             if (!(t =3D=
=3D 1 || t =3D=3D 2 || t =3D=3D 4 || t =3D=3D 8))</span><br><span>         =
    {</span><br><span>                 msg(msglevel, &quot;--dhcp-option NB=
T: parameter (%d) must be 1, 2, 4, or 8&quot;, t);</span><br><span>@@ -8688=
,15 +8639,12 @@</span><br><span>     }</span><br><span>     else if (streq(=
p[0], &quot;tap-sleep&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int=
 s;</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        s =3D atoi_warn(p[1], msgl=
evel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (s &=
lt; 0 || s &gt;=3D 256)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        if (!atoi_constrained(p[1], &amp;options-&gt;tuntap_options.tap=
_sleep,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                  &quot;tap-sleep&quot;, 0, 255, msglevel))</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(msglevel, &quot;--tap-sleep parameter must be between 0 and 255&quot;=
);</span><br><span>             goto err;</span><br><span>         }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;tuntap_o=
ptions.tap_sleep =3D s;</span><br><span>     }</span><br><span>     else if=
 (streq(p[0], &quot;dhcp-renew&quot;) &amp;&amp; !p[1])</span><br><span>   =
  {</span><br><span>@@ -9136,30 +9084,19 @@</span><br><span>         VERIFY=
_PERMISSION(OPT_P_GENERAL);</span><br><span>         if (p[1])</span><br><s=
pan>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     int replay_window;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            replay_=
window =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (!(MIN_SEQ_BACKTRACK &lt;=3D replay_window &=
amp;&amp; replay_window &lt;=3D MAX_SEQ_BACKTRACK))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (!atoi_constrained(p[1], &=
amp;options-&gt;replay_window, &quot;replay-window windows size&quot;,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
          MIN_SEQ_BACKTRACK, MAX_SEQ_BACKTRACK, msglevel))</span><br><span>=
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         msg(msglevel, &quot;replay-window window size parameter (%d) must =
be between %d and %d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    replay_window, MIN_SEQ_BACKTRACK, MAX_SEQ_BACKTRA=
CK);</span><br><span>                 goto err;</span><br><span>           =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            option=
s-&gt;replay_window =3D replay_window;</span><br><span> </span><br><span>  =
           if (p[2])</span><br><span>             {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                int replay_time;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                replay_time =3D atoi_warn(p[2], msgle=
vel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
if (!(MIN_TIME_BACKTRACK &lt;=3D replay_time &amp;&amp; replay_time &lt;=3D=
 MAX_TIME_BACKTRACK))</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                if (!atoi_constrained(p[2], &amp;options-&gt;replay_time,=
 &quot;replay-window time window&quot;,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                      MIN_TIME_BACKTRAC=
K, MAX_TIME_BACKTRACK, msglevel))</span><br><span>                 {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    msg(msgl=
evel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
        &quot;replay-window time window parameter (%d) must be between %d a=
nd %d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               replay_time, MIN_TIME_BACKTRACK, MAX_TIME_BACKTRACK);</span>=
<br><span>                     goto err;</span><br><span>                 }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                optio=
ns-&gt;replay_time =3D replay_time;</span><br><span>             }</span><b=
r><span>         }</span><br><span>         else</span><br><span>@@ -9755,7=
 +9692,7 @@</span><br><span>         else if (!p[2])</span><br><span>      =
   {</span><br><span>             char *endp =3D NULL;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            int i =3D strtol(provider, &am=
p;endp, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     long i =3D strtol(provider, &amp;endp, 10);</span><br><span> </span><b=
r><span>             if (*endp =3D=3D 0)</span><br><span>             {</sp=
an><br><span>@@ -9826,7 +9763,7 @@</span><br><span>     else if (streq(p[0]=
, &quot;pkcs11-pin-cache&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br=
><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;pkcs=
11_pin_cache_period =3D atoi_warn(p[1], msglevel);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        options-&gt;pkcs11_pin_cache_period =
=3D positive_atoi(p[1], msglevel);</span><br><span>     }</span><br><span> =
    else if (streq(p[0], &quot;pkcs11-id&quot;) &amp;&amp; p[1] &amp;&amp; =
!p[2])</span><br><span>     {</span><br><span>diff --git a/src/openvpn/opti=
ons_util.c b/src/openvpn/options_util.c</span><br><span>index c3938a7..c1f7=
c74 100644</span><br><span>--- a/src/openvpn/options_util.c</span><br><span=
>+++ b/src/openvpn/options_util.c</span><br><span>@@ -146,6 +146,41 @@</spa=
n><br><span>     return (int)i;</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+atoi_constrained(const char *str, int *va=
lue, const char *name, int min, int max, int msglevel)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    if (!max)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     max =3D INT_MAX;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(m=
in &lt; max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *endptr;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    long long i =3D strtoll=
(str, &amp;endptr, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (i &lt; INT_MIN || *endptr !=3D &#39;\0&#39; || i &gt; INT_MAX)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;%s: Ca=
nnot parse &#39;%s&#39; as integer&quot;, name, str);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (i &lt; min || i &gt; max)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        if (max =3D=3D INT_MAX) /* nicer message for =
common case */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg=
(msglevel, &quot;%s: Must be an integer &gt;=3D %d, not %lld&quot;,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                name, min, =
i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;%s: Must =
be an integer between %d and %d, not %lld&quot;,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                name, min, max, i);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        return false;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    *value =3D i;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic const char *updatable_options[] =3D { &quot;block-ipv6&quot;, &quot;b=
lock-outside-dns&quot;,</span><br><span>                                   =
         &quot;dhcp-option&quot;, &quot;dns&quot;,</span><br><span>        =
                                    &quot;ifconfig&quot;, &quot;ifconfig-ip=
v6&quot;,</span><br><span>diff --git a/src/openvpn/options_util.h b/src/ope=
nvpn/options_util.h</span><br><span>index 6f81b1e..d5ae8b9 100644</span><br=
><span>--- a/src/openvpn/options_util.h</span><br><span>+++ b/src/openvpn/o=
ptions_util.h</span><br><span>@@ -41,11 +41,24 @@</span><br><span> </span><=
br><span> /**</span><br><span>  * Converts a str to an integer if the strin=
g can be represented as an</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * integer number. Otherwise print a warning with msglevel and return =
0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * integer number.=
 Otherwise print a warning with \p msglevel and return 0</span><br><span>  =
*/</span><br><span> int atoi_warn(const char *str, int msglevel);</span><br=
><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Converts a str to an integer if the string can be represented =
as an</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * integer num=
ber and is between \p min and \p max.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * If \p max is 0, \p INT_MAX is used instead.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * The integer is stored in \p=
 value.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * On error,=
 print a warning with \p msglevel using \p name. \p value is</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * not changed on error.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return \c true if the integer has been par=
sed and stored in value, \c false otherwise</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+bool atoi_constrained(const char *str, int *value, const char *name=
, int min, int max,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                      int msglevel);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span>  * Filter an option line by all pull filters.</span><br>=
<span>  *</span><br><span>  * If a match is found, the line is modified dep=
ending on</span><br><span>diff --git a/tests/unit_tests/openvpn/test_misc.c=
 b/tests/unit_tests/openvpn/test_misc.c</span><br><span>index 1857922..80a5=
dee 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_misc.c</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_misc.c</span><br><span>@@ -3=
51,6 +351,14 @@</span><br><span>     assert_int_equal(atoi_warn(&quot;0&quo=
t;, msglevel), 0);</span><br><span>     assert_int_equal(atoi_warn(&quot;-1=
194&quot;, msglevel), -1194);</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int parameter =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(atoi_constrained(&quot;12=
34&quot;, &amp;parameter, &quot;test&quot;, 0, 0, msglevel));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(parameter, 1=
234);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tru=
e(atoi_constrained(&quot;0&quot;, &amp;parameter, &quot;test&quot;, -1, 0, =
msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(parameter, 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(atoi_constrained(&quot;-1194&quot;, &amp;parameter,=
 &quot;test&quot;, INT_MIN, INT_MAX, msglevel));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_int_equal(parameter, -1194);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     CLEA=
R(mock_msg_buf);</span><br><span>     assert_int_equal(positive_atoi(&quot;=
-1234&quot;, msglevel), 0);</span><br><span>     assert_string_equal(mock_m=
sg_buf, &quot;Cannot parse argument &#39;-1234&#39; as non-negative integer=
&quot;);</span><br><span>@@ -365,6 +373,12 @@</span><br><span>     assert_s=
tring_equal(mock_msg_buf, &quot;Cannot parse argument &#39;2147483653&#39; =
as integer&quot;);</span><br><span> </span><br><span>     CLEAR(mock_msg_bu=
f);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    parameter =
=3D -42;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
false(atoi_constrained(&quot;2147483653&quot;, &amp;parameter, &quot;test&q=
uot;, 0, 0, msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_string_equal(mock_msg_buf, &quot;test: Cannot parse &#39;214=
7483653&#39; as integer&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(parameter, -42);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span>     assert_int_equal(p=
ositive_atoi(&quot;foo77&quot;, msglevel), 0);</span><br><span>     assert_=
string_equal(mock_msg_buf, &quot;Cannot parse argument &#39;foo77&#39; as n=
on-negative integer&quot;);</span><br><span> </span><br><span>@@ -373,6 +38=
7,18 @@</span><br><span>     assert_string_equal(mock_msg_buf, &quot;Cannot=
 parse argument &#39;77foo&#39; as non-negative integer&quot;);</span><br><=
span> </span><br><span>     CLEAR(mock_msg_buf);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    parameter =3D -42;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_false(atoi_constrained(&quot;f=
oo77&quot;, &amp;parameter, &quot;test&quot;, 0, 0, msglevel));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_ms=
g_buf, &quot;test: Cannot parse &#39;foo77&#39; as integer&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(paramet=
er, -42);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    parameter =3D -42;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(atoi=
_constrained(&quot;77foo&quot;, &amp;parameter, &quot;test&quot;, 0, 0, msg=
level));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(mock_msg_buf, &quot;test: Cannot parse &#39;77foo&#39; as inte=
ger&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(parameter, -42);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR=
(mock_msg_buf);</span><br><span>     assert_int_equal(atoi_warn(&quot;foo77=
&quot;, msglevel), 0);</span><br><span>     assert_string_equal(mock_msg_bu=
f, &quot;Cannot parse argument &#39;foo77&#39; as integer&quot;);</span><br=
><span> </span><br><span>@@ -380,6 +406,31 @@</span><br><span>     assert_i=
nt_equal(atoi_warn(&quot;77foo&quot;, msglevel), 0);</span><br><span>     a=
ssert_string_equal(mock_msg_buf, &quot;Cannot parse argument &#39;77foo&#39=
; as integer&quot;);</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* special tests for _constrained */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    parameter =3D -42;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_false(atoi_const=
rained(&quot;77&quot;, &amp;parameter, &quot;test&quot;, 0, 76, msglevel));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(mock_msg_buf, &quot;test: Must be an integer between 0 and 76, not 77&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(parameter, -42);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(moc=
k_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    para=
meter =3D -42;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(atoi_constrained(&quot;-77&quot;, &amp;parameter, &quot;test&qu=
ot;, -76, 76, msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(mock_msg_buf, &quot;test: Must be an integer =
between -76 and 76, not -77&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(parameter, -42);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    parameter =3D -42;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(atoi_constrained(&quot;-77&quot;, &=
amp;parameter, &quot;test&quot;, 0, 0, msglevel));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;=
test: Must be an integer &gt;=3D 0, not -77&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(parameter, -42);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    parameter =3D -42;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(atoi_constrained=
(&quot;0&quot;, &amp;parameter, &quot;test&quot;, 1, 0, msglevel));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(moc=
k_msg_buf, &quot;test: Must be an integer &gt;=3D 1, not 0&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(paramet=
er, -42);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span>     mock_set_debug_level(saved_log_level);</span><br><span> }</span=
><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/1150?usp=3Demail">change 1150</a>. To=
 unsubscribe, or for help writing mail filters, visit <a href=3D"http://ger=
rit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http:=
//schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"h=
ttp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1150?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc7526d59c1de17a0f9d8ed88f7=
5c6f070ab11e7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1150 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--tZf8cqN2dJ0=--

