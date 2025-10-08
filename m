From: Gert Doering <gert@...1296...>
Date: Wed,  8 Oct 2025 12:02:16 +0200
Message-ID: <20251008100222.4610-1-gert@...1296...>
In-Reply-To: <gerrit.1759330832000.Icb91d9c560b6f78f16571ac3052cc566d94afe99@...2715...>
References: <gerrit.1759330832000.Icb91d9c560b6f78f16571ac3052cc566d94afe99@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] test_options_parse: Add test for
 read_config_string
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

The <inlineopt> test discovered the issue
fixed by commit "buffer: Fix buf_parse eating input".

Change-Id: Icb91d9c560b6f78f16571ac3052cc566d94afe99
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1247
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1247
This mail reflects revision 2 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openvpn/test_options_parse.c
index 9472c78..e552dd7 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -43,6 +43,9 @@
                   const unsigned int permission_mask, unsigned int *option_types_found,
                   struct env_set *es)
 {
+    function_called();
+    check_expected(p);
+    check_expected(is_inline);
 }
 
 void
@@ -185,11 +188,117 @@
     gc_free(&gc);
 }
 
+static void
+read_single_config(struct options *options, const char *config)
+{
+    unsigned int option_types_found = 0;
+    struct env_set es;
+    CLEAR(es);
+    read_config_string("test_options_parse", options, config, M_INFO, OPT_P_DEFAULT,
+                       &option_types_found, &es);
+}
+
+union tokens_parameter
+{
+    uintmax_t as_int;
+    void *as_pointer;
+};
+
+static int
+check_tokens(const uintmax_t value, const uintmax_t expected)
+{
+    union tokens_parameter temp;
+    temp.as_int = value;
+    const char **p = (const char **)temp.as_pointer;
+    temp.as_int = expected;
+    const char **expected_p = (const char **)temp.as_pointer;
+    for (int i = 0; i < MAX_PARMS; i++)
+    {
+        if (!p[i] && !expected_p[i])
+        {
+            return true;
+        }
+        if ((p[i] && !expected_p[i])
+            || (!p[i] && expected_p[i]))
+        {
+            fprintf(stderr, "diff at i=%d\n", i);
+            return false;
+        }
+        if (strcmp(p[i], expected_p[i]))
+        {
+            fprintf(stderr, "diff at i=%d, p=<%s> ep=<%s>\n", i, p[i], expected_p[i]);
+            return false;
+        }
+    }
+    fprintf(stderr, "fallthrough");
+    return false;
+}
+
+static void
+test_read_config(void **state)
+{
+    struct options o;
+    CLEAR(o); /* NB: avoiding init_options to limit dependencies */
+    gc_init(&o.gc);
+    gc_init(&o.dns_options.gc);
+    o.gc_owned = true;
+
+    char *p_expect_someopt[MAX_PARMS];
+    char *p_expect_otheropt[MAX_PARMS];
+    char *p_expect_inlineopt[MAX_PARMS];
+    CLEAR(p_expect_someopt);
+    CLEAR(p_expect_otheropt);
+    CLEAR(p_expect_inlineopt);
+    p_expect_someopt[0] = "someopt";
+    p_expect_someopt[1] = "parm1";
+    p_expect_someopt[2] = "parm2";
+    p_expect_otheropt[0] = "otheropt";
+    p_expect_otheropt[1] = "1";
+    p_expect_otheropt[2] = "2";
+    p_expect_inlineopt[0] = "inlineopt";
+    p_expect_inlineopt[1] = "some text\nother text\n";
+
+    /* basic test */
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_someopt);
+    expect_value(__wrap_add_option, is_inline, 0);
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_otheropt);
+    expect_value(__wrap_add_option, is_inline, 0);
+    read_single_config(&o, "someopt parm1 parm2\n  otheropt 1 2");
+
+    /* -- gets stripped */
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_someopt);
+    expect_value(__wrap_add_option, is_inline, 0);
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_otheropt);
+    expect_value(__wrap_add_option, is_inline, 0);
+    read_single_config(&o, "someopt parm1 parm2\n\t--otheropt 1 2");
+
+    /* inline options */
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_inlineopt);
+    expect_value(__wrap_add_option, is_inline, 1);
+    read_single_config(&o, "<inlineopt>\nsome text\nother text\n</inlineopt>");
+
+    p_expect_inlineopt[0] = "inlineopt";
+    p_expect_inlineopt[1] = A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 "\n";
+    expect_function_call(__wrap_add_option);
+    expect_check(__wrap_add_option, p, check_tokens, p_expect_inlineopt);
+    expect_value(__wrap_add_option, is_inline, 1);
+    read_single_config(&o, "<inlineopt>\n" A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 "\n</inlineopt>");
+
+    gc_free(&o.gc);
+    gc_free(&o.dns_options.gc);
+}
+
 int
 main(void)
 {
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(test_parse_line),
+        cmocka_unit_test(test_read_config),
     };
 
     return cmocka_run_group_tests_name("options_parse", tests, NULL, NULL);

