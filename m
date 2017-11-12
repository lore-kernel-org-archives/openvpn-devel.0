From: Heiko Hund <heiko.hund@...1489...>
Date: Sun, 12 Nov 2017 09:24:35 +0100
Message-ID: <20171112082435.15447-1-heiko.hund@...1489...>
In-Reply-To: <1477672963-5724-6-git-send-email-heiko.hund@...1489...>
References: <1477672963-5724-6-git-send-email-heiko.hund@...1489...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCHv2 5/7] re-implement argv_printf_*()
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

The previous implementation had the problem that it was not fully
compatible with printf() and could only detect % format directives
following a space character (0x20).

It modifies the format string and inserts marks to separate groups
before passing it to the regular printf in libc. The marks are
later used to separate the output string into individual command
line arguments.

The choice of 035 as the argument delimiter is based on the
assumption that no "regular" string passed to argv_printf_*() will
ever have to contain that byte (and the fact that it actually is
the ASCII "group separator" control character, which fits its
purpose).

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
---
 src/openvpn/argv.c                   | 253 ++++++++++++++++-------------------
 src/openvpn/argv.h                   |   4 +-
 src/openvpn/route.c                  |   8 +-
 src/openvpn/tun.c                    |  24 ++--
 tests/unit_tests/openvpn/test_argv.c |  58 +++++++-
 5 files changed, 184 insertions(+), 163 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 95bdfeac..afe8efff 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -130,64 +130,6 @@ argv_insert_head(const struct argv *a, const char *head)
     return r;
 }
 
-static char *
-argv_term(const char **f)
-{
-    const char *p = *f;
-    const char *term = NULL;
-    size_t termlen = 0;
-
-    if (*p == '\0')
-    {
-        return NULL;
-    }
-
-    while (true)
-    {
-        const int c = *p;
-        if (c == '\0')
-        {
-            break;
-        }
-        if (term)
-        {
-            if (!isspace(c))
-            {
-                ++termlen;
-            }
-            else
-            {
-                break;
-            }
-        }
-        else
-        {
-            if (!isspace(c))
-            {
-                term = p;
-                termlen = 1;
-            }
-        }
-        ++p;
-    }
-    *f = p;
-
-    if (term)
-    {
-        char *ret;
-        ASSERT(termlen > 0);
-        ret = malloc(termlen + 1);
-        check_malloc_return(ret);
-        memcpy(ret, term, termlen);
-        ret[termlen] = '\0';
-        return ret;
-    }
-    else
-    {
-        return NULL;
-    }
-}
-
 const char *
 argv_str(const struct argv *a, struct gc_arena *gc, const unsigned int flags)
 {
@@ -217,112 +159,141 @@ argv_msg_prefix(const int msglev, const struct argv *a, const char *prefix)
     gc_free(&gc);
 }
 
-static void
-argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
+/*
+ * argv_prep_format - prepare argv format string for further processing
+ *
+ * Individual argument must be separated by space. Ignores leading and trailing spaces.
+ * Consecutive spaces count as one. Returns prepared format string, with space replaced
+ * by delim and adds the number of arguments to the count parameter.
+ */
+static char *
+argv_prep_format(const char *format, const char delim, size_t *count, struct gc_arena *gc)
 {
-    char *term;
-    const char *f = format;
+    int i, j;
+    char *f;
+    bool in_token = false;
 
-    argv_extend(a, 1); /* ensure trailing NULL */
+    if (format == NULL)
+    {
+        return NULL;
+    }
 
-    while ((term = argv_term(&f)) != NULL)
+    f = gc_malloc(strlen(format) + 1, true, gc);
+    for (i = 0, j = 0; i < strlen(format); i++)
     {
-        if (term[0] == '%')
+        if (format[i] == ' ')
         {
-            if (!strcmp(term, "%s"))
-            {
-                char *s = va_arg(arglist, char *);
-                if (!s)
-                {
-                    s = "";
-                }
-                argv_append(a, string_alloc(s, NULL));
-            }
-            else if (!strcmp(term, "%d"))
-            {
-                char numstr[64];
-                openvpn_snprintf(numstr, sizeof(numstr), "%d", va_arg(arglist, int));
-                argv_append(a, string_alloc(numstr, NULL));
-            }
-            else if (!strcmp(term, "%u"))
-            {
-                char numstr[64];
-                openvpn_snprintf(numstr, sizeof(numstr), "%u", va_arg(arglist, unsigned int));
-                argv_append(a, string_alloc(numstr, NULL));
-            }
-            else if (!strcmp(term, "%s/%d"))
-            {
-                char numstr[64];
-                char *s = va_arg(arglist, char *);
-
-                if (!s)
-                {
-                    s = "";
-                }
-
-                openvpn_snprintf(numstr, sizeof(numstr), "%d", va_arg(arglist, int));
-
-                {
-                    const size_t len = strlen(s) + strlen(numstr) + 2;
-                    char *combined = (char *) malloc(len);
-                    check_malloc_return(combined);
-
-                    strcpy(combined, s);
-                    strcat(combined, "/");
-                    strcat(combined, numstr);
-                    argv_append(a, combined);
-                }
-            }
-            else if (!strcmp(term, "%s%sc"))
-            {
-                char *s1 = va_arg(arglist, char *);
-                char *s2 = va_arg(arglist, char *);
-                char *combined;
-
-                if (!s1)
-                {
-                    s1 = "";
-                }
-                if (!s2)
-                {
-                    s2 = "";
-                }
-                combined = (char *) malloc(strlen(s1) + strlen(s2) + 1);
-                check_malloc_return(combined);
-                strcpy(combined, s1);
-                strcat(combined, s2);
-                argv_append(a, combined);
-            }
-            else
-            {
-                ASSERT(0);
-            }
-            free(term);
+            in_token = false;
+            continue;
         }
-        else
+
+        if (!in_token)
         {
-            argv_append(a, term);
+            ++*count;
+            if (f[0]) /* not after leading spaces */
+            {
+                f[j++] = delim;
+            }
         }
+
+        f[j++] = format[i];
+        in_token = true;
     }
+
+    return f;
 }
 
-void
+/*
+ * argv_printf_arglist - create a struct argv from a format string
+ *
+ * Instead of parsing the format string ourselves place delimiters via argv_prep_format()
+ * before we let libc's printf() do the parsing. Then split the resulting string at the
+ * injected delimiters.
+ */
+static bool
+argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
+{
+    struct gc_arena gc = gc_new();
+    const char *delim = 035;
+    char *f, *buf, *end;
+    size_t argc, size;
+    bool res = false;
+    va_list tmplist;
+    int len;
+
+    argv_extend(a, 1); /* ensure trailing NULL */
+
+    argc = a->argc;
+    f = argv_prep_format(format, delim, &argc, &gc);
+    if (f == NULL)
+    {
+        goto out;
+    }
+
+    /* determine minimum buffer size */
+    va_copy(tmplist, arglist);
+    len = vsnprintf(NULL, 0, f, tmplist);
+    va_end(tmplist);
+    if (len < 0)
+    {
+        goto out;
+    }
+
+    size = adjust_power_of_2(len + 1);
+    buf = gc_malloc(size, false, &gc);
+    len = vsnprintf(buf, size, f, arglist);
+    if (len < 0 || len >= size)
+    {
+        goto out;
+    }
+
+    /* split the string at the delimiters */
+    end = strchr(buf, delim);
+    while (end)
+    {
+        *end = '\0';
+        argv_append(a, string_alloc(buf, NULL));
+        buf = end + 1;
+        end = strchr(buf, delim);
+    }
+    argv_append(a, string_alloc(buf, NULL));
+
+    if (a->argc != argc)
+    {
+        /* Someone snuck in a \035, fail gracefully */
+        argv_reset(a);
+        argv_extend(a, 1); /* ensure trailing NULL */
+        goto out;
+    }
+
+    res = true;
+
+out:
+    gc_free(&gc);
+    return res;
+}
+
+bool
 argv_printf(struct argv *a, const char *format, ...)
 {
+    bool res;
     va_list arglist;
-    argv_reset(a);
     va_start(arglist, format);
-    argv_printf_arglist(a, format, arglist);
+    argv_reset(a);
+    res = argv_printf_arglist(a, format, arglist);
     va_end(arglist);
+    return res;
 }
 
-void
+bool
 argv_printf_cat(struct argv *a, const char *format, ...)
 {
+    bool res;
     va_list arglist;
     va_start(arglist, format);
-    argv_printf_arglist(a, format, arglist);
+    res = argv_printf_arglist(a, format, arglist);
     va_end(arglist);
+    return res;
 }
 
 void
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 7d0754c9..a24ba98f 100644
--- a/src/openvpn/argv.h
+++ b/src/openvpn/argv.h
@@ -52,7 +52,7 @@ void argv_msg_prefix(const int msglev, const struct argv *a, const char *prefix)
 
 void argv_parse_cmd(struct argv *a, const char *s);
 
-void argv_printf(struct argv *a, const char *format, ...)
+bool argv_printf(struct argv *a, const char *format, ...)
 #ifdef __GNUC__
 #if __USE_MINGW_ANSI_STDIO
 __attribute__ ((format(gnu_printf, 2, 3)))
@@ -62,7 +62,7 @@ __attribute__ ((format(__printf__, 2, 3)))
 #endif
 ;
 
-void argv_printf_cat(struct argv *a, const char *format, ...)
+bool argv_printf_cat(struct argv *a, const char *format, ...)
 #ifdef __GNUC__
 #if __USE_MINGW_ANSI_STDIO
 __attribute__ ((format(gnu_printf, 2, 3)))
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 8c71e6ec..02f7299f 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1614,7 +1614,7 @@ add_route(struct route_ipv4 *r,
 #elif defined (_WIN32)
     {
         DWORD ai = TUN_ADAPTER_INDEX_INVALID;
-        argv_printf(&argv, "%s%sc ADD %s MASK %s %s",
+        argv_printf(&argv, "%s%s ADD %s MASK %s %s",
                     get_win_sys_path(),
                     WIN_ROUTE_PATH_SUFFIX,
                     network,
@@ -1979,7 +1979,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt, unsigned int flag
         device = buf_bptr(&out);
 
         /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
-        argv_printf(&argv, "%s%sc interface ipv6 add route %s/%d %s",
+        argv_printf(&argv, "%s%s interface ipv6 add route %s/%d %s",
                     get_win_sys_path(),
                     NETSH_PATH_SUFFIX,
                     network,
@@ -2186,7 +2186,7 @@ delete_route(struct route_ipv4 *r,
 
 #elif defined (_WIN32)
 
-    argv_printf(&argv, "%s%sc DELETE %s MASK %s %s",
+    argv_printf(&argv, "%s%s DELETE %s MASK %s %s",
                 get_win_sys_path(),
                 WIN_ROUTE_PATH_SUFFIX,
                 network,
@@ -2426,7 +2426,7 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt, unsigned
         device = buf_bptr(&out);
 
         /* netsh interface ipv6 delete route 2001:db8::/32 MyTunDevice */
-        argv_printf(&argv, "%s%sc interface ipv6 delete route %s/%d %s",
+        argv_printf(&argv, "%s%s interface ipv6 delete route %s/%d %s",
                     get_win_sys_path(),
                     NETSH_PATH_SUFFIX,
                     network,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 25831ce3..61d6b9eb 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1565,7 +1565,7 @@ do_ifconfig(struct tuntap *tt,
                 char iface[64];
                 openvpn_snprintf(iface, sizeof(iface), "interface=%lu", tt->adapter_index );
                 argv_printf(&argv,
-                            "%s%sc interface ipv6 set address %s %s store=active",
+                            "%s%s interface ipv6 set address %s %s store=active",
                             get_win_sys_path(),
                             NETSH_PATH_SUFFIX,
                             iface,
@@ -5023,14 +5023,14 @@ ipconfig_register_dns(const struct env_set *es)
     msg(D_TUNTAP_INFO, "Start ipconfig commands for register-dns...");
     netcmd_semaphore_lock();
 
-    argv_printf(&argv, "%s%sc /flushdns",
+    argv_printf(&argv, "%s%s /flushdns",
                 get_win_sys_path(),
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
     status = openvpn_execve_check(&argv, es, 0, err);
     argv_reset(&argv);
 
-    argv_printf(&argv, "%s%sc /registerdns",
+    argv_printf(&argv, "%s%s /registerdns",
                 get_win_sys_path(),
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
@@ -5144,8 +5144,8 @@ netsh_set_dns6_servers(const struct in6_addr *addr_list,
     for (int i = 0; i < addr_len; ++i)
     {
         const char *fmt = (i == 0) ?
-                          "%s%sc interface ipv6 set dns %s static %s"
-                          : "%s%sc interface ipv6 add dns %s %s";
+                          "%s%s interface ipv6 set dns %s static %s"
+                          : "%s%s interface ipv6 add dns %s %s";
         argv_printf(&argv, fmt, get_win_sys_path(),
                     NETSH_PATH_SUFFIX, flex_name,
                     print_in6_addr(addr_list[i], 0, &gc));
@@ -5192,7 +5192,7 @@ netsh_ifconfig_options(const char *type,
     /* delete existing DNS/WINS settings from TAP interface */
     if (delete_first)
     {
-        argv_printf(&argv, "%s%sc interface ip delete %s %s all",
+        argv_printf(&argv, "%s%s interface ip delete %s %s all",
                     get_win_sys_path(),
                     NETSH_PATH_SUFFIX,
                     type,
@@ -5209,8 +5209,8 @@ netsh_ifconfig_options(const char *type,
             if (delete_first || !test_first || !ip_addr_member_of(addr_list[i], current))
             {
                 const char *fmt = count ?
-                                  "%s%sc interface ip add %s %s %s"
-                                  : "%s%sc interface ip set %s %s static %s";
+                                  "%s%s interface ip add %s %s %s"
+                                  : "%s%s interface ip set %s %s static %s";
 
                 argv_printf(&argv, fmt,
                             get_win_sys_path(),
@@ -5286,7 +5286,7 @@ netsh_ifconfig(const struct tuntap_options *to,
         else
         {
             /* example: netsh interface ip set address my-tap static 10.3.0.1 255.255.255.0 */
-            argv_printf(&argv, "%s%sc interface ip set address %s static %s %s",
+            argv_printf(&argv, "%s%s interface ip set address %s static %s %s",
                         get_win_sys_path(),
                         NETSH_PATH_SUFFIX,
                         flex_name,
@@ -5335,7 +5335,7 @@ netsh_enable_dhcp(const struct tuntap_options *to,
 
     /* example: netsh interface ip set address my-tap dhcp */
     argv_printf(&argv,
-                "%s%sc interface ip set address %s dhcp",
+                "%s%s interface ip set address %s dhcp",
                 get_win_sys_path(),
                 NETSH_PATH_SUFFIX,
                 actual_name);
@@ -6197,7 +6197,7 @@ close_tun(struct tuntap *tt)
                 /* netsh interface ipv6 delete address \"%s\" %s */
                 ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0,  &gc);
                 argv_printf(&argv,
-                            "%s%sc interface ipv6 delete address %s %s store=active",
+                            "%s%s interface ipv6 delete address %s %s store=active",
                             get_win_sys_path(),
                             NETSH_PATH_SUFFIX,
                             tt->actual_name,
@@ -6209,7 +6209,7 @@ close_tun(struct tuntap *tt)
                 if (tt->options.dns6_len > 0)
                 {
                     argv_printf(&argv,
-                                "%s%sc interface ipv6 delete dns %s all",
+                                "%s%s interface ipv6 delete dns %s all",
                                 get_win_sys_path(),
                                 NETSH_PATH_SUFFIX,
                                 tt->actual_name);
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 4a3ba559..a09e92fb 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -9,6 +9,7 @@
 #include <setjmp.h>
 #include <cmocka.h>
 #include <assert.h>
+#include <stdbool.h>
 
 #include "argv.h"
 #include "buffer.h"
@@ -54,23 +55,69 @@ argv_printf_cat__multiple_spaces_in_format__parsed_as_one(void **state)
 }
 
 static void
+argv_printf__embedded_format_directive__replaced_in_output(void **state)
+{
+    struct argv a = argv_new();
+
+    argv_printf(&a, "<p1:%s>", PATH1);
+    assert_int_equal(a.argc, 1);
+    assert_string_equal(a.argv[0], "<p1:" PATH1 ">");
+
+    argv_reset(&a);
+}
+
+static void
+argv_printf__group_sep_in_arg__fail_no_ouput(void **state)
+{
+    struct argv a = argv_new();
+
+    assert_false(argv_printf(&a, "tool --do %s", "this\035--harmful"));
+    assert_int_equal(a.argc, 0);
+
+    argv_reset(&a);
+}
+
+static void
 argv_printf__combined_path_with_spaces__argc_correct(void **state)
 {
     struct argv a = argv_new();
 
-    argv_printf(&a, "%s%sc", PATH1, PATH2);
+    argv_printf(&a, "%s%s", PATH1, PATH2);
     assert_int_equal(a.argc, 1);
 
-    argv_printf(&a, "%s%sc %d", PATH1, PATH2, 42);
+    argv_printf(&a, "%s%s %d", PATH1, PATH2, 42);
     assert_int_equal(a.argc, 2);
 
-    argv_printf(&a, "foo %s%sc %s x y", PATH2, PATH1, "foo");
+    argv_printf(&a, "foo %s%s %s x y", PATH2, PATH1, "foo");
     assert_int_equal(a.argc, 5);
 
     argv_reset(&a);
 }
 
 static void
+argv_printf__empty_parameter__argc_correct(void **state)
+{
+    struct argv a = argv_new();
+
+    argv_printf(&a, "%s", "");
+    assert_int_equal(a.argc, 1);
+
+    argv_printf(&a, "%s %s", PATH1, "");
+    assert_int_equal(a.argc, 2);
+
+    argv_printf(&a, "%s %s %s", PATH1, "", PARAM1);
+    assert_int_equal(a.argc, 3);
+
+    argv_printf(&a, "%s %s %s %s", PATH1, "", "", PARAM1);
+    assert_int_equal(a.argc, 4);
+
+    argv_printf(&a, "%s %s", "", PARAM1);
+    assert_int_equal(a.argc, 2);
+
+    argv_free(&a);
+}
+
+static void
 argv_parse_cmd__command_string__argc_correct(void **state)
 {
     struct argv a = argv_new();
@@ -113,7 +160,7 @@ argv_str__multiple_argv__correct_output(void **state)
     struct gc_arena gc = gc_new();
     const char *output;
 
-    argv_printf(&a, "%s%sc", PATH1, PATH2);
+    argv_printf(&a, "%s%s", PATH1, PATH2);
     argv_printf_cat(&a, "%s", PARAM1);
     argv_printf_cat(&a, "%s", PARAM2);
     output = argv_str(&a, &gc, PA_BRACKET);
@@ -168,7 +215,10 @@ main(void)
     const struct CMUnitTest tests[] = {
         cmocka_unit_test(argv_printf__multiple_spaces_in_format__parsed_as_one),
         cmocka_unit_test(argv_printf_cat__multiple_spaces_in_format__parsed_as_one),
+        cmocka_unit_test(argv_printf__embedded_format_directive__replaced_in_output),
+        cmocka_unit_test(argv_printf__group_sep_in_arg__fail_no_ouput),
         cmocka_unit_test(argv_printf__combined_path_with_spaces__argc_correct),
+        cmocka_unit_test(argv_printf__empty_parameter__argc_correct),
         cmocka_unit_test(argv_parse_cmd__command_string__argc_correct),
         cmocka_unit_test(argv_parse_cmd__command_and_extra_options__argc_correct),
         cmocka_unit_test(argv_printf_cat__used_twice__argc_correct),
-- 
2.11.0


