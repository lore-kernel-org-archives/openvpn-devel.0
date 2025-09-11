From: Gert Doering <gert@...1296...>
Date: Thu, 11 Sep 2025 22:15:00 +0200
Message-ID: <20250911201505.25582-1-gert@...1296...>
In-Reply-To: <gerrit.1755877911000.I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61@...2715...>
References: <gerrit.1755877911000.I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v4] options: Factor out usages of strtoll
 and atoll
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

This covers the cases where we actually want to
allow numbers > 2^31

Change-Id: I454126b3f8fa9d14501f6c4b1ed9ce7b2904be61
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: MaxF <max@...2606...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1154
This mail reflects revision 4 of this Change.

Acked-by according to Gerrit (reflected above):
MaxF <max@...2606...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 7c2b3c8..4068a9a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -7185,8 +7185,7 @@
         options->inactivity_timeout = positive_atoi(p[1], msglevel);
         if (p[2])
         {
-            int64_t val = atoll(p[2]);
-            options->inactivity_minimum_bytes = (val < 0) ? 0 : val;
+            positive_atoll(p[2], &options->inactivity_minimum_bytes, p[0], msglevel);
             if (options->inactivity_minimum_bytes > INT_MAX)
             {
                 msg(M_WARN,
@@ -9541,26 +9540,18 @@
     else if (streq(p[0], "reneg-bytes") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        char *end;
-        long long reneg_bytes = strtoll(p[1], &end, 10);
-        if (*end != '\0' || reneg_bytes < 0)
+        if (!positive_atoll(p[1], &options->renegotiate_bytes, p[0], msglevel))
         {
-            msg(msglevel, "--reneg-bytes parameter must be an integer and >= 0");
             goto err;
         }
-        options->renegotiate_bytes = reneg_bytes;
     }
     else if (streq(p[0], "reneg-pkts") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_TLS_PARMS);
-        char *end;
-        long long pkt_max = strtoll(p[1], &end, 10);
-        if (*end != '\0' || pkt_max < 0)
+        if (!positive_atoll(p[1], &options->renegotiate_packets, p[0], msglevel))
         {
-            msg(msglevel, "--reneg-pkts parameter must be an integer and >= 0");
             goto err;
         }
-        options->renegotiate_packets = pkt_max;
     }
     else if (streq(p[0], "reneg-sec") && p[1] && !p[3])
     {
diff --git a/src/openvpn/options_util.c b/src/openvpn/options_util.c
index 69d88ae..1231fd4 100644
--- a/src/openvpn/options_util.c
+++ b/src/openvpn/options_util.c
@@ -131,6 +131,22 @@
     return (int)i;
 }
 
+bool
+positive_atoll(const char *str, int64_t *value, const char *name, int msglevel)
+{
+    char *endptr;
+    long long ll = strtoll(str, &endptr, 10);
+
+    if (ll < 0 || *endptr != '\0')
+    {
+        msg(msglevel, "%s: Cannot parse '%s' as non-negative integer", name, str);
+        return false;
+    }
+
+    *value = (int64_t)ll;
+    return true;
+}
+
 int
 atoi_warn(const char *str, int msglevel)
 {
diff --git a/src/openvpn/options_util.h b/src/openvpn/options_util.h
index 0810f61..cd81bca 100644
--- a/src/openvpn/options_util.h
+++ b/src/openvpn/options_util.h
@@ -41,6 +41,17 @@
 
 /**
  * Converts a str to an integer if the string can be represented as an
+ * integer number and is >= 0.
+ * The integer is stored in \p value.
+ * On error, print a warning with \p msglevel using \p name. \p value is
+ * not changed on error.
+ *
+ * @return \c true if the integer has been parsed and stored in value, \c false otherwise
+ */
+bool positive_atoll(const char *str, int64_t *value, const char *name, int msglevel);
+
+/**
+ * Converts a str to an integer if the string can be represented as an
  * integer number. Otherwise print a warning with \p msglevel and return 0
  */
 int atoi_warn(const char *str, int msglevel);
diff --git a/tests/unit_tests/openvpn/test_misc.c b/tests/unit_tests/openvpn/test_misc.c
index 3e30dae..f515a02 100644
--- a/tests/unit_tests/openvpn/test_misc.c
+++ b/tests/unit_tests/openvpn/test_misc.c
@@ -359,6 +359,17 @@
     assert_true(atoi_constrained("-1194", &parameter, "test", INT_MIN, INT_MAX, msglevel));
     assert_int_equal(parameter, -1194);
 
+    int64_t parameter64 = 0;
+    assert_true(positive_atoll("1234", &parameter64, "test", msglevel));
+    assert_int_equal(parameter64, 1234);
+    assert_true(positive_atoll("0", &parameter64, "test", msglevel));
+    assert_int_equal(parameter64, 0);
+    assert_true(positive_atoll("2147483653", &parameter64, "test", msglevel));
+    assert_int_equal(parameter64, 2147483653);
+    /* overflow gets capped to LLONG_MAX */
+    assert_true(positive_atoll("9223372036854775810", &parameter64, "test", msglevel));
+    assert_int_equal(parameter64, 9223372036854775807);
+
     CLEAR(mock_msg_buf);
     assert_int_equal(positive_atoi("-1234", msglevel), 0);
     assert_string_equal(mock_msg_buf, "Cannot parse argument '-1234' as non-negative integer");

