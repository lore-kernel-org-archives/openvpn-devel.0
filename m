From: Gert Doering <gert@...1296...>
Date: Tue,  2 Sep 2025 16:46:50 +0200
Message-ID: <20250902144657.11854-1-gert@...1296...>
In-Reply-To: <gerrit.1755870317000.Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7@...2715...>
References: <gerrit.1755870317000.Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5] options: Introduce atoi_constrained and
 review usages of atoi_warn
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

From: Frank Lichtenheld <frank@...2641...>

This is a more powerful version of atoi_warn that can
- check minimum and maximum values
- report error seperately from parsed value

This can be used to simplify a lot of option parsing.

Change-Id: Ibc7526d59c1de17a0f9d8ed88f75c6f070ab11e7
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1150
This mail reflects revision 5 of this Change.

Acked-by according to Gerrit (reflected above):
Arne Schwabe <arne-openvpn@...1227...>

        
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
-        cache = atoi_warn(p[1], msglevel);
-        if (cache < 1)
+        if (!atoi_constrained(p[1], &options->management_log_history_cache,
+                              p[0], 1, INT_MAX, msglevel))
         {
-            msg(msglevel, "--management-log-cache parameter is out of range");
             goto err;
         }
-        options->management_log_history_cache = cache;
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
-        version = atoi_warn(p[1], msglevel);
-        if (version < 1 || version > 3)
+        if (!atoi_constrained(p[1], &options->status_file_version, p[0], 1, 3, msglevel))
         {
-            msg(msglevel, "--status-version must be 1 to 3");
             goto err;
         }
-        options->status_file_version = version;
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
-        shaper = atoi_warn(p[1], msglevel);
-        if (shaper < SHAPER_MIN || shaper > SHAPER_MAX)
+        if (!atoi_constrained(p[1], &options->shaper, p[0], SHAPER_MIN, SHAPER_MAX, msglevel))
         {
-            msg(msglevel, "Bad shaper value, must be between %d and %d", SHAPER_MIN, SHAPER_MAX);
             goto err;
         }
-        options->shaper = shaper;
     }
     else if (streq(p[0], "port") && p[1] && !p[2])
     {
@@ -7739,7 +7725,11 @@
     else if (streq(p[0], "script-security") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        script_security_set(atoi_warn(p[1], msglevel));
+        int security;
+        if (atoi_constrained(p[1], &security, p[0], SSEC_NONE, SSEC_PW_ENV, msglevel))
+        {
+            script_security_set(security);
+        }
     }
     else if (streq(p[0], "mssfix") && !p[3])
     {
@@ -7959,11 +7949,9 @@
         int real, virtual;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        real = atoi_warn(p[1], msglevel);
-        virtual = atoi_warn(p[2], msglevel);
-        if (real < 1 || virtual < 1)
+        if (!atoi_constrained(p[1], &real, "hash-size real", 1, INT_MAX, msglevel)
+            || !atoi_constrained(p[2], &virtual, "hash-size virtual", 1, INT_MAX, msglevel))
         {
-            msg(msglevel, "--hash-size sizes must be >= 1 (preferably a power of 2)");
             goto err;
         }
         options->real_hash_size = real;
@@ -7974,11 +7962,9 @@
         int cf_max, cf_per;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        cf_max = atoi_warn(p[1], msglevel);
-        cf_per = atoi_warn(p[2], msglevel);
-        if (cf_max < 0 || cf_per < 0)
+        if (!atoi_constrained(p[1], &cf_max, "connect-freq n", 1, INT_MAX, msglevel)
+            || !atoi_constrained(p[2], &cf_per, "connect-freq seconds", 1, INT_MAX, msglevel))
         {
-            msg(msglevel, "--connect-freq parms must be > 0");
             goto err;
         }
         options->cf_max = cf_max;
@@ -7986,15 +7972,12 @@
     }
     else if (streq(p[0], "connect-freq-initial") && p[1] && p[2] && !p[3])
     {
-        long cf_max, cf_per;
+        int cf_max, cf_per;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        char *e1, *e2;
-        cf_max = strtol(p[1], &e1, 10);
-        cf_per = strtol(p[2], &e2, 10);
-        if (cf_max < 0 || cf_per < 0 || *e1 != '\0' || *e2 != '\0')
+        if (!atoi_constrained(p[1], &cf_max, "connect-freq-initial n", 1, INT_MAX, msglevel)
+            || !atoi_constrained(p[2], &cf_per, "connect-freq-initial seconds", 1, INT_MAX, msglevel))
         {
-            msg(msglevel, "--connect-freq-initial parameters must be integers and >= 0");
             goto err;
         }
         options->cf_initial_max = cf_max;
@@ -8002,21 +7985,11 @@
     }
     else if (streq(p[0], "max-clients") && p[1] && !p[2])
     {
-        int max_clients;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        max_clients = atoi_warn(p[1], msglevel);
-        if (max_clients < 0)
+        if (!atoi_constrained(p[1], &options->max_clients, p[0], 1, MAX_PEER_ID, msglevel))
         {
-            msg(msglevel, "--max-clients must be at least 1");
             goto err;
         }
-        if (max_clients >= MAX_PEER_ID) /* max peer-id value */
-        {
-            msg(msglevel, "--max-clients must be less than %d", MAX_PEER_ID);
-            goto err;
-        }
-        options->max_clients = max_clients;
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
-        n_bcast_buf = atoi_warn(p[1], msglevel);
-        if (n_bcast_buf < 1)
-        {
-            msg(msglevel, "--bcast-buffers parameter must be > 0");
-        }
-        options->n_bcast_buf = n_bcast_buf;
+        atoi_constrained(p[1], &options->n_bcast_buf, p[0], 1, INT_MAX, msglevel);
     }
     else if (streq(p[0], "tcp-queue-limit") && p[1] && !p[2])
     {
-        int tcp_queue_limit;
-
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        tcp_queue_limit = atoi_warn(p[1], msglevel);
-        if (tcp_queue_limit < 1)
-        {
-            msg(msglevel, "--tcp-queue-limit parameter must be > 0");
-        }
-        options->tcp_queue_limit = tcp_queue_limit;
+        atoi_constrained(p[1], &options->tcp_queue_limit, p[0], 1, INT_MAX, msglevel);
     }
 #if PORT_SHARE
     else if (streq(p[0], "port-share") && p[1] && p[2] && !p[4])
@@ -8354,21 +8313,24 @@
         int ageing_time, check_interval;
 
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        ageing_time = atoi_warn(p[1], msglevel);
+        if (!atoi_constrained(p[1], &ageing_time, "stale-routes-check age", 1, INT_MAX, msglevel))
+        {
+            goto err;
+        }
+
         if (p[2])
         {
-            check_interval = atoi_warn(p[2], msglevel);
+            if (!atoi_constrained(p[2], &check_interval,
+                                  "stale-routes-check interval", 1, INT_MAX, msglevel))
+            {
+                goto err;
+            }
         }
         else
         {
             check_interval = ageing_time;
         }
 
-        if (ageing_time < 1 || check_interval < 1)
-        {
-            msg(msglevel, "--stale-routes-check aging time and check interval must be >= 1");
-            goto err;
-        }
         options->stale_routes_ageing_time = ageing_time;
         options->stale_routes_check_interval = check_interval;
     }
@@ -8386,7 +8348,7 @@
     else if (streq(p[0], "push-continuation") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_PULL_MODE);
-        options->push_continuation = atoi_warn(p[1], msglevel);
+        atoi_constrained(p[1], &options->push_continuation, p[0], 0, 2, msglevel);
     }
     else if (streq(p[0], "auth-user-pass") && !p[2])
     {
@@ -8505,33 +8467,23 @@
             {
                 if (!streq(p[2], "default"))
                 {
-                    int offset = atoi_warn(p[2], msglevel);
+                    int offset;
 
-                    if (!(offset > -256 && offset < 256))
+                    if (!atoi_constrained(p[2], &offset, "ip-win32 offset", -256, 256, msglevel))
                     {
-                        msg(msglevel,
-                            "--ip-win32 dynamic [offset] [lease-time]: offset (%d) must be > -256 and < 256",
-                            offset);
                         goto err;
                     }
-
                     to->dhcp_masq_custom_offset = true;
                     to->dhcp_masq_offset = offset;
                 }
 
                 if (p[3])
                 {
-                    const int min_lease = 30;
-                    int lease_time;
-                    lease_time = atoi_warn(p[3], msglevel);
-                    if (lease_time < min_lease)
+                    if (!atoi_constrained(p[3], &to->dhcp_lease_time,
+                                          "ip-win32 lease time", 30, INT_MAX, msglevel))
                     {
-                        msg(msglevel,
-                            "--ip-win32 dynamic [offset] [lease-time]: lease time parameter (%d) must be at least %d seconds",
-                            lease_time, min_lease);
                         goto err;
                     }
-                    to->dhcp_lease_time = lease_time;
                 }
             }
         }
@@ -8629,8 +8581,7 @@
         }
         else if (streq(p[1], "NBT") && p[2] && !p[3])
         {
-            int t;
-            t = atoi_warn(p[2], msglevel);
+            int t = atoi_warn(p[2], msglevel);
             if (!(t == 1 || t == 2 || t == 4 || t == 8))
             {
                 msg(msglevel, "--dhcp-option NBT: parameter (%d) must be 1, 2, 4, or 8", t);
@@ -8704,15 +8655,11 @@
     }
     else if (streq(p[0], "tap-sleep") && p[1] && !p[2])
     {
-        int s;
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-        s = atoi_warn(p[1], msglevel);
-        if (s < 0 || s >= 256)
+        if (!atoi_constrained(p[1], &options->tuntap_options.tap_sleep, p[0], 0, 255, msglevel))
         {
-            msg(msglevel, "--tap-sleep parameter must be between 0 and 255");
             goto err;
         }
-        options->tuntap_options.tap_sleep = s;
     }
     else if (streq(p[0], "dhcp-renew") && !p[1])
     {
@@ -9152,30 +9099,19 @@
         VERIFY_PERMISSION(OPT_P_GENERAL);
         if (p[1])
         {
-            int replay_window;
-
-            replay_window = atoi_warn(p[1], msglevel);
-            if (!(MIN_SEQ_BACKTRACK <= replay_window && replay_window <= MAX_SEQ_BACKTRACK))
+            if (!atoi_constrained(p[1], &options->replay_window, "replay-window windows size",
+                                  MIN_SEQ_BACKTRACK, MAX_SEQ_BACKTRACK, msglevel))
             {
-                msg(msglevel, "replay-window window size parameter (%d) must be between %d and %d",
-                    replay_window, MIN_SEQ_BACKTRACK, MAX_SEQ_BACKTRACK);
                 goto err;
             }
-            options->replay_window = replay_window;
 
             if (p[2])
             {
-                int replay_time;
-
-                replay_time = atoi_warn(p[2], msglevel);
-                if (!(MIN_TIME_BACKTRACK <= replay_time && replay_time <= MAX_TIME_BACKTRACK))
+                if (!atoi_constrained(p[2], &options->replay_time, "replay-window time window",
+                                      MIN_TIME_BACKTRACK, MAX_TIME_BACKTRACK, msglevel))
                 {
-                    msg(msglevel,
-                        "replay-window time window parameter (%d) must be between %d and %d",
-                        replay_time, MIN_TIME_BACKTRACK, MAX_TIME_BACKTRACK);
                     goto err;
                 }
-                options->replay_time = replay_time;
             }
         }
         else
@@ -9771,7 +9707,7 @@
         else if (!p[2])
         {
             char *endp = NULL;
-            int i = strtol(provider, &endp, 10);
+            long i = strtol(provider, &endp, 10);
 
             if (*endp == 0)
             {
@@ -9842,7 +9778,7 @@
     else if (streq(p[0], "pkcs11-pin-cache") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        options->pkcs11_pin_cache_period = atoi_warn(p[1], msglevel);
+        options->pkcs11_pin_cache_period = positive_atoi(p[1], msglevel);
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
+atoi_constrained(const char *str, int *value, const char *name, int min, int max, int msglevel)
+{
+    ASSERT(min < max);
+
+    char *endptr;
+    long long i = strtoll(str, &endptr, 10);
+    if (i < INT_MIN || *endptr != '\0' || i > INT_MAX)
+    {
+        msg(msglevel, "%s: Cannot parse '%s' as integer", name, str);
+        return false;
+    }
+    if (i < min || i > max)
+    {
+        if (max == INT_MAX) /* nicer message for common case */
+        {
+            msg(msglevel, "%s: Must be an integer >= %d, not %lld",
+                name, min, i);
+        }
+        else
+        {
+            msg(msglevel, "%s: Must be an integer between %d and %d, not %lld",
+                name, min, max, i);
+        }
+        return false;
+    }
+
+    *value = i;
+    return true;
+}
+
 static const char *updatable_options[] = { "block-ipv6", "block-outside-dns",
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
+ * @return \c true if the integer has been parsed and stored in value, \c false otherwise
+ */
+bool atoi_constrained(const char *str, int *value, const char *name, int min, int max,
+                      int msglevel);
+
+/**
  * Filter an option line by all pull filters.
  *
  * If a match is found, the line is modified depending on
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 1857922..c3f80dc 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -351,6 +351,14 @@
     assert_int_equal(atoi_warn("0", msglevel), 0);
     assert_int_equal(atoi_warn("-1194", msglevel), -1194);
 
+    int parameter = 0;
+    assert_true(atoi_constrained("1234", &parameter, "test", 0, INT_MAX, msglevel));
+    assert_int_equal(parameter, 1234);
+    assert_true(atoi_constrained("0", &parameter, "test", -1, 0, msglevel));
+    assert_int_equal(parameter, 0);
+    assert_true(atoi_constrained("-1194", &parameter, "test", INT_MIN, INT_MAX, msglevel));
+    assert_int_equal(parameter, -1194);
+
     CLEAR(mock_msg_buf);
     assert_int_equal(positive_atoi("-1234", msglevel), 0);
     assert_string_equal(mock_msg_buf, "Cannot parse argument '-1234' as non-negative integer");
@@ -365,6 +373,12 @@
     assert_string_equal(mock_msg_buf, "Cannot parse argument '2147483653' as integer");
 
     CLEAR(mock_msg_buf);
+    parameter = -42;
+    assert_false(atoi_constrained("2147483653", &parameter, "test", 0, INT_MAX, msglevel));
+    assert_string_equal(mock_msg_buf, "test: Cannot parse '2147483653' as integer");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
     assert_int_equal(positive_atoi("foo77", msglevel), 0);
     assert_string_equal(mock_msg_buf, "Cannot parse argument 'foo77' as non-negative integer");
 
@@ -373,6 +387,18 @@
     assert_string_equal(mock_msg_buf, "Cannot parse argument '77foo' as non-negative integer");
 
     CLEAR(mock_msg_buf);
+    parameter = -42;
+    assert_false(atoi_constrained("foo77", &parameter, "test", 0, INT_MAX, msglevel));
+    assert_string_equal(mock_msg_buf, "test: Cannot parse 'foo77' as integer");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
+    parameter = -42;
+    assert_false(atoi_constrained("77foo", &parameter, "test", 0, INT_MAX, msglevel));
+    assert_string_equal(mock_msg_buf, "test: Cannot parse '77foo' as integer");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
     assert_int_equal(atoi_warn("foo77", msglevel), 0);
     assert_string_equal(mock_msg_buf, "Cannot parse argument 'foo77' as integer");
 
@@ -380,6 +406,31 @@
     assert_int_equal(atoi_warn("77foo", msglevel), 0);
     assert_string_equal(mock_msg_buf, "Cannot parse argument '77foo' as integer");
 
+    /* special tests for _constrained */
+    CLEAR(mock_msg_buf);
+    parameter = -42;
+    assert_false(atoi_constrained("77", &parameter, "test", 0, 76, msglevel));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer between 0 and 76, not 77");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
+    parameter = -42;
+    assert_false(atoi_constrained("-77", &parameter, "test", -76, 76, msglevel));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer between -76 and 76, not -77");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
+    parameter = -42;
+    assert_false(atoi_constrained("-77", &parameter, "test", 0, INT_MAX, msglevel));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer >= 0, not -77");
+    assert_int_equal(parameter, -42);
+
+    CLEAR(mock_msg_buf);
+    parameter = -42;
+    assert_false(atoi_constrained("0", &parameter, "test", 1, INT_MAX, msglevel));
+    assert_string_equal(mock_msg_buf, "test: Must be an integer >= 1, not 0");
+    assert_int_equal(parameter, -42);
+
     mock_set_debug_level(saved_log_level);
 }
 

