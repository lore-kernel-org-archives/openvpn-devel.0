From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 2 Sep 2025 12:11:52 +0000
In-Reply-To: <gerrit.1755870317000.Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7@...2715...>
References: <gerrit.1755870317000.Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <535b820d15272d8e85620ad247159c616e9d393f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BjSFjbbfxgU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: options: Introduce
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

--BjSFjbbfxgU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1150?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


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
4 files changed, 137 insertions(+), 107 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/50/1150/4

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 74946a4..a268b92 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -6411,16 +6411,12 @@
     }
     else if (streq(p[0], "management-log-cache") && p[1] && !p[2])
     {
-        int cache;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cache =3D atoi_warn(p[1], msglevel);
-        if (cache < 1)
+        if (!atoi_constrained(p[1], &options->management_log_history_cache,
+                              p[0], 1, INT_MAX, msglevel))
         {
-            msg(msglevel, "--management-log-cache parameter is out of rang=
e");
             goto err;
         }
-        options->management_log_history_cache =3D cache;
     }
 #endif /* ifdef ENABLE_MANAGEMENT */
 #ifdef ENABLE_PLUGIN
@@ -6969,16 +6965,11 @@
     }
     else if (streq(p[0], "status-version") && p[1] && !p[2])
     {
-        int version;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        version =3D atoi_warn(p[1], msglevel);
-        if (version < 1 || version > 3)
+        if (!atoi_constrained(p[1], &options->status_file_version, p[0], 1=
, 3, msglevel))
         {
-            msg(msglevel, "--status-version must be 1 to 3");
             goto err;
         }
-        options->status_file_version =3D version;
     }
     else if (streq(p[0], "remap-usr1") && p[1] && !p[2])
     {
@@ -7151,16 +7142,11 @@
     }
     else if (streq(p[0], "shaper") && p[1] && !p[2])
     {
-        int shaper;
-
         VERIFY_PERMISSION(OPT_P_SHAPER);
-        shaper =3D atoi_warn(p[1], msglevel);
-        if (shaper < SHAPER_MIN || shaper > SHAPER_MAX)
+        if (!atoi_constrained(p[1], &options->shaper, p[0], SHAPER_MIN, SH=
APER_MAX, msglevel))
         {
-            msg(msglevel, "Bad shaper value, must be between %d and %d", S=
HAPER_MIN, SHAPER_MAX);
             goto err;
         }
-        options->shaper =3D shaper;
     }
     else if (streq(p[0], "port") && p[1] && !p[2])
     {
@@ -7739,7 +7725,11 @@
     else if (streq(p[0], "script-security") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        script_security_set(atoi_warn(p[1], msglevel));
+        int security;
+        if (atoi_constrained(p[1], &security, p[0], SSEC_NONE, SSEC_PW_ENV=
, msglevel))
+        {
+            script_security_set(security);
+        }
     }
     else if (streq(p[0], "mssfix") && !p[3])
     {
@@ -7959,11 +7949,9 @@
         int real, virtual;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        real =3D atoi_warn(p[1], msglevel);
-        virtual =3D atoi_warn(p[2], msglevel);
-        if (real < 1 || virtual < 1)
+        if (!atoi_constrained(p[1], &real, "hash-size real", 1, INT_MAX, m=
sglevel)
+            || !atoi_constrained(p[2], &virtual, "hash-size virtual", 1, I=
NT_MAX, msglevel))
         {
-            msg(msglevel, "--hash-size sizes must be >=3D 1 (preferably a =
power of 2)");
             goto err;
         }
         options->real_hash_size =3D real;
@@ -7974,11 +7962,9 @@
         int cf_max, cf_per;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cf_max =3D atoi_warn(p[1], msglevel);
-        cf_per =3D atoi_warn(p[2], msglevel);
-        if (cf_max < 0 || cf_per < 0)
+        if (!atoi_constrained(p[1], &cf_max, "connect-freq n", 1, INT_MAX,=
 msglevel)
+            || !atoi_constrained(p[2], &cf_per, "connect-freq seconds", 1,=
 INT_MAX, msglevel))
         {
-            msg(msglevel, "--connect-freq parms must be > 0");
             goto err;
         }
         options->cf_max =3D cf_max;
@@ -7986,15 +7972,12 @@
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
INT_MAX, msglevel)
+            || !atoi_constrained(p[2], &cf_per, "connect-freq-initial seco=
nds", 1, INT_MAX, msglevel))
         {
-            msg(msglevel, "--connect-freq-initial parameters must be integ=
ers and >=3D 0");
             goto err;
         }
         options->cf_initial_max =3D cf_max;
@@ -8002,21 +7985,11 @@
     }
     else if (streq(p[0], "max-clients") && p[1] && !p[2])
     {
-        int max_clients;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        max_clients =3D atoi_warn(p[1], msglevel);
-        if (max_clients < 0)
+        if (!atoi_constrained(p[1], &options->max_clients, p[0], 1, MAX_PE=
ER_ID, msglevel))
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
@@ -8188,27 +8161,13 @@
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
+        atoi_constrained(p[1], &options->n_bcast_buf, p[0], 1, INT_MAX, ms=
glevel);
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
+        atoi_constrained(p[1], &options->tcp_queue_limit, p[0], 1, INT_MAX=
, msglevel);
     }
 #if PORT_SHARE
     else if (streq(p[0], "port-share") && p[1] && p[2] && !p[4])
@@ -8354,21 +8313,24 @@
         int ageing_time, check_interval;

         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ageing_time =3D atoi_warn(p[1], msglevel);
+        if (!atoi_constrained(p[1], &ageing_time, "stale-routes-check age"=
, 1, INT_MAX, msglevel))
+        {
+            goto err;
+        }
+
         if (p[2])
         {
-            check_interval =3D atoi_warn(p[2], msglevel);
+            if (!atoi_constrained(p[2], &check_interval,
+                                  "stale-routes-check interval", 1, INT_MA=
X, msglevel))
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
@@ -8386,7 +8348,7 @@
     else if (streq(p[0], "push-continuation") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_PULL_MODE);
-        options->push_continuation =3D atoi_warn(p[1], msglevel);
+        atoi_constrained(p[1], &options->push_continuation, p[0], 0, 2, ms=
glevel);
     }
     else if (streq(p[0], "auth-user-pass") && !p[2])
     {
@@ -8505,33 +8467,23 @@
             {
                 if (!streq(p[2], "default"))
                 {
-                    int offset =3D atoi_warn(p[2], msglevel);
+                    int offset;

-                    if (!(offset > -256 && offset < 256))
+                    if (!atoi_constrained(p[2], &offset, "ip-win32 offset"=
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
+                    if (!atoi_constrained(p[3], &to->dhcp_lease_time,
+                                          "ip-win32 lease time", 30, INT_M=
AX, msglevel))
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
@@ -8629,8 +8581,7 @@
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
@@ -8704,15 +8655,11 @@
     }
     else if (streq(p[0], "tap-sleep") && p[1] && !p[2])
     {
-        int s;
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        s =3D atoi_warn(p[1], msglevel);
-        if (s < 0 || s >=3D 256)
+        if (!atoi_constrained(p[1], &options->tuntap_options.tap_sleep, p[=
0], 0, 255, msglevel))
         {
-            msg(msglevel, "--tap-sleep parameter must be between 0 and 255=
");
             goto err;
         }
-        options->tuntap_options.tap_sleep =3D s;
     }
     else if (streq(p[0], "dhcp-renew") && !p[1])
     {
@@ -9152,30 +9099,19 @@
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
@@ -9771,7 +9707,7 @@
         else if (!p[2])
         {
             char *endp =3D NULL;
-            int i =3D strtol(provider, &endp, 10);
+            long i =3D strtol(provider, &endp, 10);

             if (*endp =3D=3D 0)
             {
@@ -9842,7 +9778,7 @@
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->pkcs11_pin_cache_period =3D atoi_warn(p[1], msglevel);
+        options->pkcs11_pin_cache_period =3D positive_atoi(p[1], msglevel);
     }
     else if (streq(p[0], "pkcs11-id") && p[1] && !p[2])
     {
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index c3938a7..be1eefc 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -146,6 +146,37 @@
     return (int)i;
 }

+bool
+atoi_constrained(const char *str, int *value, const char *name, int min, i=
nt max, int msglevel)
+{
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
index 6f81b1e..9eca7b6 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -41,11 +41,23 @@

 /**
  * Converts a str to an integer if the string can be represented as an
- * integer number. Otherwise print a warning with msglevel and return 0
+ * integer number. Otherwise print a warning with \p msglevel and return 0
  */
 int atoi_warn(const char *str, int msglevel);

 /**
+ * Converts a str to an integer if the string can be represented as an
+ * integer number and is between \p min and \p max.
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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--BjSFjbbfxgU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1150?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">options: Introduce atoi_constrained and review u=
sages of atoi_warn<br><br>This is a more powerful version of atoi_warn that=
 can<br>- check minimum and maximum values<br>- report error seperately fro=
m parsed value<br><br>This can be used to simplify a lot of option parsing.=
<br><br>Change-Id: Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7<br>Signed-off-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/opti=
ons.c<br>M src/openvpn/options_util.c<br>M src/openvpn/options_util.h<br>M =
tests/unit_tests/openvpn/test_misc.c<br>4 files changed, 137 insertions(+),=
 107 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/50/1150/4</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/op=
envpn/options.c</span><br><span>index 74946a4..a268b92 100644</span><br><sp=
an>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c<=
/span><br><span>@@ -6411,16 +6411,12 @@</span><br><span>     }</span><br><s=
pan>     else if (streq(p[0], &quot;management-log-cache&quot;) &amp;&amp; =
p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        int cache;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span>         VERIFY_PERMISSION(OPT_P_GENE=
RAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cache =
=3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        if (cache &lt; 1)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;options-&gt;managem=
ent_log_history_cache,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                              p[0], 1, INT_MAX, msglevel))</span><br><sp=
an>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(msglevel, &quot;--management-log-cache parameter is out of range&qu=
ot;);</span><br><span>             goto err;</span><br><span>         }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;manag=
ement_log_history_cache =3D cache;</span><br><span>     }</span><br><span> =
#endif /* ifdef ENABLE_MANAGEMENT */</span><br><span> #ifdef ENABLE_PLUGIN<=
/span><br><span>@@ -6969,16 +6965,11 @@</span><br><span>     }</span><br><s=
pan>     else if (streq(p[0], &quot;status-version&quot;) &amp;&amp; p[1] &=
amp;&amp; !p[2])</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        int version;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        version =3D =
atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (version &lt; 1 || version &gt; 3)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;opt=
ions-&gt;status_file_version, p[0], 1, 3, msglevel))</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(m=
sglevel, &quot;--status-version must be 1 to 3&quot;);</span><br><span>    =
         goto err;</span><br><span>         }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        options-&gt;status_file_version =3D version=
;</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;re=
map-usr1&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</s=
pan><br><span>@@ -7151,16 +7142,11 @@</span><br><span>     }</span><br><spa=
n>     else if (streq(p[0], &quot;shaper&quot;) &amp;&amp; p[1] &amp;&amp; =
!p[2])</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        int shaper;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span>         VERIFY_PERMISSION(OPT_P_SHAPER);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        shaper =3D atoi_warn(p[1=
], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
if (shaper &lt; SHAPER_MIN || shaper &gt; SHAPER_MAX)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;=
options-&gt;shaper, p[0], SHAPER_MIN, SHAPER_MAX, msglevel))</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(msglevel, &quot;Bad shaper value, must be between %d and %d&quot;, S=
HAPER_MIN, SHAPER_MAX);</span><br><span>             goto err;</span><br><s=
pan>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 options-&gt;shaper =3D shaper;</span><br><span>     }</span><br><span>    =
 else if (streq(p[0], &quot;port&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</=
span><br><span>     {</span><br><span>@@ -7739,7 +7725,11 @@</span><br><spa=
n>     else if (streq(p[0], &quot;script-security&quot;) &amp;&amp; p[1] &a=
mp;&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERM=
ISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        script_security_set(atoi_warn(p[1], msglevel));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        int security;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        if (atoi_constrained(p[1], &=
amp;security, p[0], SSEC_NONE, SSEC_PW_ENV, msglevel))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            script_security_set(security);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span> =
    }</span><br><span>     else if (streq(p[0], &quot;mssfix&quot;) &amp;&a=
mp; !p[3])</span><br><span>     {</span><br><span>@@ -7959,11 +7949,9 @@</s=
pan><br><span>         int real, virtual;</span><br><span> </span><br><span=
>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        real =3D atoi_warn(p[1], msglevel);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        virtual =3D atoi_warn(p=
[2], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  if (real &lt; 1 || virtual &lt; 1)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;real, &quot;hash-=
size real&quot;, 1, INT_MAX, msglevel)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            || !atoi_constrained(p[2], &amp;virtual, &qu=
ot;hash-size virtual&quot;, 1, INT_MAX, msglevel))</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(msg=
level, &quot;--hash-size sizes must be &gt;=3D 1 (preferably a power of 2)&=
quot;);</span><br><span>             goto err;</span><br><span>         }</=
span><br><span>         options-&gt;real_hash_size =3D real;</span><br><spa=
n>@@ -7974,11 +7962,9 @@</span><br><span>         int cf_max, cf_per;</span=
><br><span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        cf_max =3D atoi_w=
arn(p[1], msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       cf_per =3D atoi_warn(p[2], msglevel);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        if (cf_max &lt; 0 || cf_per &lt; 0)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constraine=
d(p[1], &amp;cf_max, &quot;connect-freq n&quot;, 1, INT_MAX, msglevel)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            || !atoi_con=
strained(p[2], &amp;cf_per, &quot;connect-freq seconds&quot;, 1, INT_MAX, m=
sglevel))</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            msg(msglevel, &quot;--connect-freq parms must be=
 &gt; 0&quot;);</span><br><span>             goto err;</span><br><span>    =
     }</span><br><span>         options-&gt;cf_max =3D cf_max;</span><br><s=
pan>@@ -7986,15 +7972,12 @@</span><br><span>     }</span><br><span>     els=
e if (streq(p[0], &quot;connect-freq-initial&quot;) &amp;&amp; p[1] &amp;&a=
mp; p[2] &amp;&amp; !p[3])</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        long cf_max, cf_per;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        int cf_max, cf_per;</span><br>=
<span> </span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        char *e1, *e2;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        cf_max =3D strtol(p[1=
], &amp;e1, 10);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   cf_per =3D strtol(p[2], &amp;e2, 10);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (cf_max &lt; 0 || cf_per &lt; 0 || *e1 !=3D &=
#39;\0&#39; || *e2 !=3D &#39;\0&#39;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (!atoi_constrained(p[1], &amp;cf_max, &quot;co=
nnect-freq-initial n&quot;, 1, INT_MAX, msglevel)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            || !atoi_constrained(p[2], &amp;c=
f_per, &quot;connect-freq-initial seconds&quot;, 1, INT_MAX, msglevel))</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            msg(msglevel, &quot;--connect-freq-initial parameters must be=
 integers and &gt;=3D 0&quot;);</span><br><span>             goto err;</spa=
n><br><span>         }</span><br><span>         options-&gt;cf_initial_max =
=3D cf_max;</span><br><span>@@ -8002,21 +7985,11 @@</span><br><span>     }<=
/span><br><span>     else if (streq(p[0], &quot;max-clients&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        int max_clients;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         VERIFY_PERMISSION=
(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   max_clients =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (max_clients &lt; 0)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constrained(p[1], &am=
p;options-&gt;max_clients, p[0], 1, MAX_PEER_ID, msglevel))</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(msglevel, &quot;--max-clients must be at least 1&quot;);</span><br><s=
pan>             goto err;</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (max_clients &gt;=3D MAX_PEER_ID=
) /* max peer-id value */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    msg(msglevel, &quot;--max-clients must be less than %d&quot;, MAX_PEER_=
ID);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            goto =
err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;max_clien=
ts =3D max_clients;</span><br><span>     }</span><br><span>     else if (st=
req(p[0], &quot;max-routes-per-client&quot;) &amp;&amp; p[1] &amp;&amp; !p[=
2])</span><br><span>     {</span><br><span>@@ -8188,27 +8161,13 @@</span><b=
r><span>     }</span><br><span>     else if (streq(p[0], &quot;bcast-buffer=
s&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        int n_bcast_buf;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         VE=
RIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        n_bcast_buf =3D atoi_warn(p[1], msglevel);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (n_bcast_buf &lt; 1)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;--bcas=
t-buffers parameter must be &gt; 0&quot;);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        options-&gt;n_bcast_buf =3D n_bcast_buf;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[1], &amp;o=
ptions-&gt;n_bcast_buf, p[0], 1, INT_MAX, msglevel);</span><br><span>     }=
</span><br><span>     else if (streq(p[0], &quot;tcp-queue-limit&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span style=
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
1], &amp;options-&gt;tcp_queue_limit, p[0], 1, INT_MAX, msglevel);</span><b=
r><span>     }</span><br><span> #if PORT_SHARE</span><br><span>     else if=
 (streq(p[0], &quot;port-share&quot;) &amp;&amp; p[1] &amp;&amp; p[2] &amp;=
&amp; !p[4])</span><br><span>@@ -8354,21 +8313,24 @@</span><br><span>      =
   int ageing_time, check_interval;</span><br><span> </span><br><span>     =
    VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        ageing_time =3D atoi_warn(p[1], msglevel);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!atoi_constraine=
d(p[1], &amp;ageing_time, &quot;stale-routes-check age&quot;, 1, INT_MAX, m=
sglevel))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto err=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         if=
 (p[2])</span><br><span>         {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            check_interval =3D atoi_warn(p[2], msglevel);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!atoi_co=
nstrained(p[2], &amp;check_interval,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                  &quot;stale-routes-check=
 interval&quot;, 1, INT_MAX, msglevel))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                goto err;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span>         }</span><br><spa=
n>         else</span><br><span>         {</span><br><span>             che=
ck_interval =3D ageing_time;</span><br><span>         }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ageing_time=
 &lt; 1 || check_interval &lt; 1)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            msg(msglevel, &quot;--stale-routes-check aging time and check i=
nterval must be &gt;=3D 1&quot;);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            goto err;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span>         options-&gt;stale_routes_age=
ing_time =3D ageing_time;</span><br><span>         options-&gt;stale_routes=
_check_interval =3D check_interval;</span><br><span>     }</span><br><span>=
@@ -8386,7 +8348,7 @@</span><br><span>     else if (streq(p[0], &quot;push-=
continuation&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     =
{</span><br><span>         VERIFY_PERMISSION(OPT_P_PULL_MODE);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        options-&gt;push_continuat=
ion =3D atoi_warn(p[1], msglevel);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        atoi_constrained(p[1], &amp;options-&gt;push_continu=
ation, p[0], 0, 2, msglevel);</span><br><span>     }</span><br><span>     e=
lse if (streq(p[0], &quot;auth-user-pass&quot;) &amp;&amp; !p[2])</span><br=
><span>     {</span><br><span>@@ -8505,33 +8467,23 @@</span><br><span>     =
        {</span><br><span>                 if (!streq(p[2], &quot;default&q=
uot;))</span><br><span>                 {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    int offset =3D atoi_warn(p[2], msgl=
evel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       int offset;</span><br><span> </span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    if (!(offset &gt; -256 &amp;&amp; offset=
 &lt; 256))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            if (!atoi_constrained(p[2], &amp;offset, &quot;ip-win32 offset&=
quot;, -256, 256, msglevel))</span><br><span>                     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                        msg(m=
sglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
               &quot;--ip-win32 dynamic [offset] [lease-time]: offset (%d) =
must be &gt; -256 and &lt; 256&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                            offset);</span><br><span>      =
                   goto err;</span><br><span>                     }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>            =
         to-&gt;dhcp_masq_custom_offset =3D true;</span><br><span>         =
            to-&gt;dhcp_masq_offset =3D offset;</span><br><span>           =
      }</span><br><span> </span><br><span>                 if (p[3])</span>=
<br><span>                 {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    const int min_lease =3D 30;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    int lease_time;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    lease_ti=
me =3D atoi_warn(p[3], msglevel);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    if (lease_time &lt; min_lease)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    if (!atoi_co=
nstrained(p[3], &amp;to-&gt;dhcp_lease_time,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                          &quot;ip=
-win32 lease time&quot;, 30, INT_MAX, msglevel))</span><br><span>          =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
               msg(msglevel,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                            &quot;--ip-win32 dynamic [offset] [lease=
-time]: lease time parameter (%d) must be at least %d seconds&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
lease_time, min_lease);</span><br><span>                         goto err;<=
/span><br><span>                     }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                    to-&gt;dhcp_lease_time =3D lease_time;=
</span><br><span>                 }</span><br><span>             }</span><b=
r><span>         }</span><br><span>@@ -8629,8 +8581,7 @@</span><br><span>  =
       }</span><br><span>         else if (streq(p[1], &quot;NBT&quot;) &am=
p;&amp; p[2] &amp;&amp; !p[3])</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            int t;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            t =3D atoi_warn(p[2], msglevel=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            int t=
 =3D atoi_warn(p[2], msglevel);</span><br><span>             if (!(t =3D=3D=
 1 || t =3D=3D 2 || t =3D=3D 4 || t =3D=3D 8))</span><br><span>            =
 {</span><br><span>                 msg(msglevel, &quot;--dhcp-option NBT: =
parameter (%d) must be 1, 2, 4, or 8&quot;, t);</span><br><span>@@ -8704,15=
 +8655,11 @@</span><br><span>     }</span><br><span>     else if (streq(p[0=
], &quot;tap-sleep&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        int s;=
</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        s =3D atoi_warn(p[1], msgleve=
l);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (s &lt;=
 0 || s &gt;=3D 256)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (!atoi_constrained(p[1], &amp;options-&gt;tuntap_options.tap_sl=
eep, p[0], 0, 255, msglevel))</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(msglevel, &quot;--tap-sl=
eep parameter must be between 0 and 255&quot;);</span><br><span>           =
  goto err;</span><br><span>         }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        options-&gt;tuntap_options.tap_sleep =3D s;</span>=
<br><span>     }</span><br><span>     else if (streq(p[0], &quot;dhcp-renew=
&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><br><span>@@ -9152,3=
0 +9099,19 @@</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);</s=
pan><br><span>         if (p[1])</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            int replay_window;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            replay_window =3D atoi_warn(p[1], msg=
level);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if=
 (!(MIN_SEQ_BACKTRACK &lt;=3D replay_window &amp;&amp; replay_window &lt;=
=3D MAX_SEQ_BACKTRACK))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if (!atoi_constrained(p[1], &amp;options-&gt;replay_window,=
 &quot;replay-window windows size&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                                  MIN_SEQ_BACKTRACK, M=
AX_SEQ_BACKTRACK, msglevel))</span><br><span>             {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                msg(msglevel, &quot;r=
eplay-window window size parameter (%d) must be between %d and %d&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    repl=
ay_window, MIN_SEQ_BACKTRACK, MAX_SEQ_BACKTRACK);</span><br><span>         =
        goto err;</span><br><span>             }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            options-&gt;replay_window =3D replay=
_window;</span><br><span> </span><br><span>             if (p[2])</span><br=
><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                int replay_time;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      replay_time =3D atoi_warn(p[2], msglevel);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                if (!(MIN_TIME_BACKTRACK &lt;=3D=
 replay_time &amp;&amp; replay_time &lt;=3D MAX_TIME_BACKTRACK))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                if (!atoi_cons=
trained(p[2], &amp;options-&gt;replay_time, &quot;replay-window time window=
&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                          MIN_TIME_BACKTRACK, MAX_TIME_BACKTRACK, msglevel)=
)</span><br><span>                 {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    msg(msglevel,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        &quot;replay-window time=
 window parameter (%d) must be between %d and %d&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                        replay_time, MIN_=
TIME_BACKTRACK, MAX_TIME_BACKTRACK);</span><br><span>                     g=
oto err;</span><br><span>                 }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                options-&gt;replay_time =3D replay_ti=
me;</span><br><span>             }</span><br><span>         }</span><br><sp=
an>         else</span><br><span>@@ -9771,7 +9707,7 @@</span><br><span>    =
     else if (!p[2])</span><br><span>         {</span><br><span>           =
  char *endp =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            int i =3D strtol(provider, &amp;endp, 10);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            long i =3D strtol(provider,=
 &amp;endp, 10);</span><br><span> </span><br><span>             if (*endp =
=3D=3D 0)</span><br><span>             {</span><br><span>@@ -9842,7 +9778,7=
 @@</span><br><span>     else if (streq(p[0], &quot;pkcs11-pin-cache&quot;)=
 &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span> =
        VERIFY_PERMISSION(OPT_P_GENERAL);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        options-&gt;pkcs11_pin_cache_period =3D atoi_wa=
rn(p[1], msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        options-&gt;pkcs11_pin_cache_period =3D positive_atoi(p[1], msgleve=
l);</span><br><span>     }</span><br><span>     else if (streq(p[0], &quot;=
pkcs11-id&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</=
span><br><span>diff --git a/src/openvpn/options_util.c b/src/openvpn/option=
s_util.c</span><br><span>index c3938a7..be1eefc 100644</span><br><span>--- =
a/src/openvpn/options_util.c</span><br><span>+++ b/src/openvpn/options_util=
.c</span><br><span>@@ -146,6 +146,37 @@</span><br><span>     return (int)i;=
</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+atoi_constrained(const char *str, int *value, const char *name, int min,=
 int max, int msglevel)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(min=
 &lt; max);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    char *endptr;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    long long i =3D strtoll(s=
tr, &amp;endptr, 10);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (i &lt; INT_MIN || *endptr !=3D &#39;\0&#39; || i &gt; INT_MAX)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        msg(msglevel, &quot;%s: Cann=
ot parse &#39;%s&#39; as integer&quot;, name, str);</span><br><span style=
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
nvpn/options_util.h</span><br><span>index 6f81b1e..9eca7b6 100644</span><br=
><span>--- a/src/openvpn/options_util.h</span><br><span>+++ b/src/openvpn/o=
ptions_util.h</span><br><span>@@ -41,11 +41,23 @@</span><br><span> </span><=
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
20, 100%, 40%);">+ * The integer is stored in \p value.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * On error, print a warning with \p ms=
glevel using \p name. \p value is</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * not changed on error.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * @return \c true if the integer has been parsed and stored in value, \c=
 false otherwise</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool atoi_constrain=
ed(const char *str, int *value, const char *name, int min, int max,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                      int m=
sglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span>  * Filte=
r an option line by all pull filters.</span><br><span>  *</span><br><span> =
 * If a match is found, the line is modified depending on</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn=
/test_misc.c</span><br><span>index 1857922..80a5dee 100644</span><br><span>=
--- a/tests/unit_tests/openvpn/test_misc.c</span><br><span>+++ b/tests/unit=
_tests/openvpn/test_misc.c</span><br><span>@@ -351,6 +351,14 @@</span><br><=
span>     assert_int_equal(atoi_warn(&quot;0&quot;, msglevel), 0);</span><b=
r><span>     assert_int_equal(atoi_warn(&quot;-1194&quot;, msglevel), -1194=
);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int parameter =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(atoi_constrained(&quot;1234&quot;, &amp;parameter, &q=
uot;test&quot;, 0, 0, msglevel));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_int_equal(parameter, 1234);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(atoi_constrained(&quot;0&=
quot;, &amp;parameter, &quot;test&quot;, -1, 0, msglevel));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(parameter, 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(ato=
i_constrained(&quot;-1194&quot;, &amp;parameter, &quot;test&quot;, INT_MIN,=
 INT_MAX, msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(parameter, -1194);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span>     CLEAR(mock_msg_buf);</span><br>=
<span>     assert_int_equal(positive_atoi(&quot;-1234&quot;, msglevel), 0);=
</span><br><span>     assert_string_equal(mock_msg_buf, &quot;Cannot parse =
argument &#39;-1234&#39; as non-negative integer&quot;);</span><br><span>@@=
 -365,6 +373,12 @@</span><br><span>     assert_string_equal(mock_msg_buf, &=
quot;Cannot parse argument &#39;2147483653&#39; as integer&quot;);</span><b=
r><span> </span><br><span>     CLEAR(mock_msg_buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    parameter =3D -42;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_false(atoi_constrained(&quo=
t;2147483653&quot;, &amp;parameter, &quot;test&quot;, 0, 0, msglevel));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal=
(mock_msg_buf, &quot;test: Cannot parse &#39;2147483653&#39; as integer&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(parameter, -42);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_m=
sg_buf);</span><br><span>     assert_int_equal(positive_atoi(&quot;foo77&qu=
ot;, msglevel), 0);</span><br><span>     assert_string_equal(mock_msg_buf, =
&quot;Cannot parse argument &#39;foo77&#39; as non-negative integer&quot;);=
</span><br><span> </span><br><span>@@ -373,6 +387,18 @@</span><br><span>   =
  assert_string_equal(mock_msg_buf, &quot;Cannot parse argument &#39;77foo&=
#39; as non-negative integer&quot;);</span><br><span> </span><br><span>    =
 CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    parameter =3D -42;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_false(atoi_constrained(&quot;foo77&quot;, &amp;parameter, &=
quot;test&quot;, 0, 0, msglevel));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;test: Cannot par=
se &#39;foo77&#39; as integer&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(parameter, -42);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    parameter =3D -42;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_false(atoi_constrained(&quot;77foo&quot=
;, &amp;parameter, &quot;test&quot;, 0, 0, msglevel));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &q=
uot;test: Cannot parse &#39;77foo&#39; as integer&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(parameter, -42);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><sp=
an>     assert_int_equal(atoi_warn(&quot;foo77&quot;, msglevel), 0);</span>=
<br><span>     assert_string_equal(mock_msg_buf, &quot;Cannot parse argumen=
t &#39;foo77&#39; as integer&quot;);</span><br><span> </span><br><span>@@ -=
380,6 +406,31 @@</span><br><span>     assert_int_equal(atoi_warn(&quot;77fo=
o&quot;, msglevel), 0);</span><br><span>     assert_string_equal(mock_msg_b=
uf, &quot;Cannot parse argument &#39;77foo&#39; as integer&quot;);</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* spe=
cial tests for _constrained */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    parameter =3D -42;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(atoi_constrained(&quot;77&quot;, &amp;p=
arameter, &quot;test&quot;, 0, 76, msglevel));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;test=
: Must be an integer between 0 and 76, not 77&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(parameter, -42);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(mock_msg_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    parameter =3D -42;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_false(atoi_constrained=
(&quot;-77&quot;, &amp;parameter, &quot;test&quot;, -76, 76, msglevel));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(mock_msg_buf, &quot;test: Must be an integer between -76 and 76, not -77&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(parameter, -42);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(moc=
k_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    para=
meter =3D -42;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_false(atoi_constrained(&quot;-77&quot;, &amp;parameter, &quot;test&qu=
ot;, 0, 0, msglevel));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(mock_msg_buf, &quot;test: Must be an integer &gt=
;=3D 0, not -77&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(parameter, -42);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    CLEAR(mock_msg_buf);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    parameter =3D -42;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_false(atoi_constrained(&quot;0&quot;, &amp;parameter,=
 &quot;test&quot;, 1, 0, msglevel));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(mock_msg_buf, &quot;test: Must be =
an integer &gt;=3D 1, not 0&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(parameter, -42);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     mock_set_debug_leve=
l(saved_log_level);</span><br><span> }</span><br><span> </span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1150?usp=3Demail">change 1150</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1150?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibc7526d59c1de17a0f9d8ed88f7=
5c6f070ab11e7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1150 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--BjSFjbbfxgU=--

