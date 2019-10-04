From: David Sommerseth <davids@...515...>
Date: Fri,  4 Oct 2019 19:12:43 +0200
Message-Id: <20191004171246.26343-2-davids@...515...>
In-Reply-To: <20191004171246.26343-1-davids@...515...>
References: <20191004171246.26343-1-davids@...515...>
Subject: [Openvpn-devel] [PATCH 1/4] re-implement argv_printf_*()
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

From: Heiko Hund <heiko.hund@...1489...>

The previous implementation had the problem that it was not fully
compatible with printf() and could only detect % format directives
following a space character (0x20).

It modifies the format string and inserts marks to separate groups
before passing it to the regular printf in libc. The marks are
later used to separate the output string into individual command
line arguments.

The choice of 0x1D as the argument delimiter is based on the
assumption that no "regular" string passed to argv_printf_*() will
ever have to contain that byte (and the fact that it actually is
the ASCII "group separator" control character, which fits its
purpose).

This commit has been updated by David Sommerseth based on Arne
Schwabe and his own feedback on the mailing list.

Signed-off-by: Heiko Hund <heiko.hund@...1489...>
Signed-off-by: David Sommerseth <davids@...515...>

---
v2 - Improved comments, to make it even clearer what is going on
   - Switched to C99 variable declaration, closer to where used
   - Swapped out adjust_power_of_2() length calculation in
     argv_printf_arglist() to len+1, which should be good enough.
---
 src/openvpn/argv.c                   | 289 +++++++++++++--------------
 src/openvpn/argv.h                   |   4 +-
 src/openvpn/route.c                  |   8 +-
 src/openvpn/tun.c                    |  24 +--
 tests/unit_tests/openvpn/test_argv.c |  58 +++++-
 5 files changed, 206 insertions(+), 177 deletions(-)

diff --git a/src/openvpn/argv.c b/src/openvpn/argv.c
index 9100a196..fcf61ec5 100644
--- a/src/openvpn/argv.c
+++ b/src/openvpn/argv.c
@@ -105,16 +105,15 @@ static struct argv
 argv_clone(const struct argv *a, const size_t headroom)
 {
     struct argv r;
-    size_t i;
-
     argv_init(&r);
-    for (i = 0; i < headroom; ++i)
+
+    for (size_t i = 0; i < headroom; ++i)
     {
         argv_append(&r, NULL);
     }
     if (a)
     {
-        for (i = 0; i < a->argc; ++i)
+        for (size_t i = 0; i < a->argc; ++i)
         {
             argv_append(&r, string_alloc(a->argv[i], NULL));
         }
@@ -131,64 +130,6 @@ argv_insert_head(const struct argv *a, const char *head)
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
@@ -218,132 +159,170 @@ argv_msg_prefix(const int msglev, const struct argv *a, const char *prefix)
     gc_free(&gc);
 }
 
-static void
+
+/*
+ * argv_prep_format - prepare argv format string for further processing
+ *
+ * Individual argument must be separated by space. Ignores leading and trailing spaces.
+ * Consecutive spaces count as one. Returns prepared format string, with space replaced
+ * by delim and adds the number of arguments to the count parameter.
+ */
+static char *
+argv_prep_format(const char *format, const char delim, size_t *count, struct gc_arena *gc)
+{
+    if (format == NULL)
+    {
+        return NULL;
+    }
+
+    bool in_token = false;
+    char *f = gc_malloc(strlen(format) + 1, true, gc);
+    for (int i = 0, j = 0; i < strlen(format); i++)
+    {
+        if (format[i] == ' ')
+        {
+            in_token = false;
+            continue;
+        }
+
+        if (!in_token)
+        {
+            (*count)++;
+
+            /*
+             * We don't add any delimiter to the output string if
+             * the string is empty; the resulting format string
+             * will never start with a delimiter.
+             */
+            if (j > 0)  /* Has anything been written to the output string? */
+            {
+                f[j++] = delim;
+            }
+        }
+
+        f[j++] = format[i];
+        in_token = true;
+    }
+
+    return f;
+}
+
+/*
+ * argv_printf_arglist - create a struct argv from a format string
+ *
+ * Instead of parsing the format string ourselves place delimiters via argv_prep_format()
+ * before we let libc's printf() do the parsing. Then split the resulting string at the
+ * injected delimiters.
+ */
+static bool
 argv_printf_arglist(struct argv *a, const char *format, va_list arglist)
 {
-    char *term;
-    const char *f = format;
+    struct gc_arena gc = gc_new();
+    const char delim = 0x1D;  /* ASCII Group Separator (GS) */
+    bool res = false;
 
     argv_extend(a, 1); /* ensure trailing NULL */
 
-    while ((term = argv_term(&f)) != NULL)
+    /*
+     * Prepare a format string which will be used by vsnprintf() later on.
+     *
+     * This means all space separators in the input format string will be
+     * replaced by the GS (0x1D), so we can split this up again after the
+     * the vsnprintf() call into individual arguments again which will be
+     * saved in the struct argv.
+     *
+     */
+    size_t argc = a->argc;
+    char *f = argv_prep_format(format, delim, &argc, &gc);
+    if (f == NULL)
     {
-        if (term[0] == '%')
-        {
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
-            else if (!strcmp(term, "%lu"))
-            {
-                char numstr[64];
-                openvpn_snprintf(numstr, sizeof(numstr), "%lu",
-                                 va_arg(arglist, unsigned long));
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
+        goto out;
+    }
 
-                openvpn_snprintf(numstr, sizeof(numstr), "%d", va_arg(arglist, int));
+    /* determine minimum buffer size */
+    va_list tmplist;
+    va_copy(tmplist, arglist);
+    int len = vsnprintf(NULL, 0, f, tmplist);
+    va_end(tmplist);
+    if (len < 0)
+    {
+        goto out;
+    }
 
-                {
-                    const size_t len = strlen(s) + strlen(numstr) + 2;
-                    char *combined = (char *) malloc(len);
-                    check_malloc_return(combined);
+    /*
+     *  Do the actual vsnprintf() operation, which expands the format
+     *  string with the provided arguments.
+     */
+    size_t size = len + 1;
+    char *buf = gc_malloc(size, false, &gc);
+    len = vsnprintf(buf, size, f, arglist);
+    if (len < 0 || len >= size)
+    {
+        goto out;
+    }
 
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
+    /*
+     * Split the string at the GS (0x1D) delimiters and put each elemen
+     * into the struct argv being returned to the caller.
+     */
+    char *end = strchr(buf, delim);
+    while (end)
+    {
+        *end = '\0';
+        argv_append(a, string_alloc(buf, NULL));
+        buf = end + 1;
+        end = strchr(buf, delim);
+    }
+    argv_append(a, string_alloc(buf, NULL));
 
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
-        }
-        else
-        {
-            argv_append(a, term);
-        }
+    if (a->argc != argc)
+    {
+        /* Someone snuck in a GS (0x1D), fail gracefully */
+        argv_reset(a);
+        argv_extend(a, 1); /* ensure trailing NULL */
+        goto out;
     }
+    res = true;
+
+out:
+    gc_free(&gc);
+    return res;
 }
 
-void
+
+
+bool
 argv_printf(struct argv *a, const char *format, ...)
 {
     va_list arglist;
-    argv_reset(a);
     va_start(arglist, format);
-    argv_printf_arglist(a, format, arglist);
+
+    argv_reset(a);
+    bool res = argv_printf_arglist(a, format, arglist);
     va_end(arglist);
+    return res;
 }
 
-void
+bool
 argv_printf_cat(struct argv *a, const char *format, ...)
 {
     va_list arglist;
     va_start(arglist, format);
-    argv_printf_arglist(a, format, arglist);
+
+    bool res = argv_printf_arglist(a, format, arglist);
     va_end(arglist);
+    return res;
 }
 
 void
 argv_parse_cmd(struct argv *a, const char *s)
 {
-    int nparms;
-    char *parms[MAX_PARMS + 1];
-    struct gc_arena gc = gc_new();
-
     argv_reset(a);
     argv_extend(a, 1); /* ensure trailing NULL */
 
-    nparms = parse_line(s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &gc);
+    struct gc_arena gc = gc_new();
+    char *parms[MAX_PARMS + 1] = { 0 };
+    int nparms = parse_line(s, parms, MAX_PARMS, "SCRIPT-ARGV", 0, D_ARGV_PARSE_CMD, &gc);
     if (nparms)
     {
         int i;
diff --git a/src/openvpn/argv.h b/src/openvpn/argv.h
index 9d9f3873..b9105a43 100644
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
index 3183fb47..fb1875cc 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1621,7 +1621,7 @@ add_route(struct route_ipv4 *r,
 #elif defined (_WIN32)
     {
         DWORD ai = TUN_ADAPTER_INDEX_INVALID;
-        argv_printf(&argv, "%s%sc ADD %s MASK %s %s",
+        argv_printf(&argv, "%s%s ADD %s MASK %s %s",
                     get_win_sys_path(),
                     WIN_ROUTE_PATH_SUFFIX,
                     network,
@@ -1984,7 +1984,7 @@ add_route_ipv6(struct route_ipv6 *r6, const struct tuntap *tt,
         device = buf_bptr(&out);
 
         /* netsh interface ipv6 add route 2001:db8::/32 MyTunDevice */
-        argv_printf(&argv, "%s%sc interface ipv6 add route %s/%d %s",
+        argv_printf(&argv, "%s%s interface ipv6 add route %s/%d %s",
                     get_win_sys_path(),
                     NETSH_PATH_SUFFIX,
                     network,
@@ -2194,7 +2194,7 @@ delete_route(struct route_ipv4 *r,
     }
 #elif defined (_WIN32)
 
-    argv_printf(&argv, "%s%sc DELETE %s MASK %s %s",
+    argv_printf(&argv, "%s%s DELETE %s MASK %s %s",
                 get_win_sys_path(),
                 WIN_ROUTE_PATH_SUFFIX,
                 network,
@@ -2428,7 +2428,7 @@ delete_route_ipv6(const struct route_ipv6 *r6, const struct tuntap *tt,
         device = buf_bptr(&out);
 
         /* netsh interface ipv6 delete route 2001:db8::/32 MyTunDevice */
-        argv_printf(&argv, "%s%sc interface ipv6 delete route %s/%d %s",
+        argv_printf(&argv, "%s%s interface ipv6 delete route %s/%d %s",
                     get_win_sys_path(),
                     NETSH_PATH_SUFFIX,
                     network,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 0591df65..6101f52b 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -995,7 +995,7 @@ do_ifconfig_ipv6(struct tuntap *tt, const char *ifname, int tun_mtu,
 
         openvpn_snprintf(iface, sizeof(iface), "interface=%lu",
                          tt->adapter_index);
-        argv_printf(&argv, "%s%sc interface ipv6 set address %s %s store=active",
+        argv_printf(&argv, "%s%s interface ipv6 set address %s %s store=active",
                     get_win_sys_path(), NETSH_PATH_SUFFIX, iface,
                     ifconfig_ipv6_local);
         netsh_command(&argv, 4, M_FATAL);
@@ -4878,14 +4878,14 @@ ipconfig_register_dns(const struct env_set *es)
     msg(D_TUNTAP_INFO, "Start ipconfig commands for register-dns...");
     netcmd_semaphore_lock();
 
-    argv_printf(&argv, "%s%sc /flushdns",
+    argv_printf(&argv, "%s%s /flushdns",
                 get_win_sys_path(),
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
     openvpn_execve_check(&argv, es, 0, err);
     argv_reset(&argv);
 
-    argv_printf(&argv, "%s%sc /registerdns",
+    argv_printf(&argv, "%s%s /registerdns",
                 get_win_sys_path(),
                 WIN_IPCONFIG_PATH_SUFFIX);
     argv_msg(D_TUNTAP_INFO, &argv);
@@ -4999,8 +4999,8 @@ netsh_set_dns6_servers(const struct in6_addr *addr_list,
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
@@ -5047,7 +5047,7 @@ netsh_ifconfig_options(const char *type,
     /* delete existing DNS/WINS settings from TAP interface */
     if (delete_first)
     {
-        argv_printf(&argv, "%s%sc interface ip delete %s %s all",
+        argv_printf(&argv, "%s%s interface ip delete %s %s all",
                     get_win_sys_path(),
                     NETSH_PATH_SUFFIX,
                     type,
@@ -5064,8 +5064,8 @@ netsh_ifconfig_options(const char *type,
             if (delete_first || !test_first || !ip_addr_member_of(addr_list[i], current))
             {
                 const char *fmt = count ?
-                                  "%s%sc interface ip add %s %s %s"
-                                  : "%s%sc interface ip set %s %s static %s";
+                                  "%s%s interface ip add %s %s %s"
+                                  : "%s%s interface ip set %s %s static %s";
 
                 argv_printf(&argv, fmt,
                             get_win_sys_path(),
@@ -5141,7 +5141,7 @@ netsh_ifconfig(const struct tuntap_options *to,
         else
         {
             /* example: netsh interface ip set address my-tap static 10.3.0.1 255.255.255.0 */
-            argv_printf(&argv, "%s%sc interface ip set address %s static %s %s",
+            argv_printf(&argv, "%s%s interface ip set address %s static %s %s",
                         get_win_sys_path(),
                         NETSH_PATH_SUFFIX,
                         flex_name,
@@ -5189,7 +5189,7 @@ netsh_enable_dhcp(const char *actual_name)
 
     /* example: netsh interface ip set address my-tap dhcp */
     argv_printf(&argv,
-                "%s%sc interface ip set address %s dhcp",
+                "%s%s interface ip set address %s dhcp",
                 get_win_sys_path(),
                 NETSH_PATH_SUFFIX,
                 actual_name);
@@ -6103,7 +6103,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
             /* netsh interface ipv6 delete address \"%s\" %s */
             ifconfig_ipv6_local = print_in6_addr(tt->local_ipv6, 0,  &gc);
             argv_printf(&argv,
-                        "%s%sc interface ipv6 delete address %s %s store=active",
+                        "%s%s interface ipv6 delete address %s %s store=active",
                         get_win_sys_path(),
                         NETSH_PATH_SUFFIX,
                         tt->actual_name,
@@ -6115,7 +6115,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
             if (tt->options.dns6_len > 0)
             {
                 argv_printf(&argv,
-                            "%s%sc interface ipv6 delete dns %s all",
+                            "%s%s interface ipv6 delete dns %s all",
                             get_win_sys_path(),
                             NETSH_PATH_SUFFIX,
                             tt->actual_name);
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvpn/test_argv.c
index 0fdd3f0a..9b72ad04 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -9,6 +9,7 @@
 #include <setjmp.h>
 #include <cmocka.h>
 #include <assert.h>
+#include <stdbool.h>
 
 #include "argv.h"
 #include "buffer.h"
@@ -53,23 +54,69 @@ argv_printf_cat__multiple_spaces_in_format__parsed_as_one(void **state)
     argv_reset(&a);
 }
 
+static void
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
 static void
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
 
+static void
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
+    argv_reset(&a);
+}
+
 static void
 argv_parse_cmd__command_string__argc_correct(void **state)
 {
@@ -113,7 +160,7 @@ argv_str__multiple_argv__correct_output(void **state)
     struct gc_arena gc = gc_new();
     const char *output;
 
-    argv_printf(&a, "%s%sc", PATH1, PATH2);
+    argv_printf(&a, "%s%s", PATH1, PATH2);
     argv_printf_cat(&a, "%s", PARAM1);
     argv_printf_cat(&a, "%s", PARAM2);
     argv_printf_cat(&a, "%d", -1);
@@ -172,7 +219,10 @@ main(void)
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
2.17.1


