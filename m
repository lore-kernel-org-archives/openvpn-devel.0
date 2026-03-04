From: Gert Doering <gert@...1296...>
Date: Wed,  4 Mar 2026 12:04:49 +0100
Message-ID: <20260304110455.15859-1-gert@...1296...>
In-Reply-To: <gerrit.1769443458000.Ia3477b8ee7a637c15aad7f285144280595cda5d5@...2715...>
References: <gerrit.1769443458000.Ia3477b8ee7a637c15aad7f285144280595cda5d5@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v6] buffer: Add checked_snprintf function
 and use it in the code
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

This reintroduces a function that converts the result
of snprintf to a boolean since the check is always the
same but annoyingly verbose. And it gets worse when you add
-Wsign-compare.

So in preparation of introducing -Wsign-compare wrap this
check in the function.

This somewhat reverts the removal of openvpn_snprintf.
But note that that was originally introduced to work
around the broken snprintf of Windows. So this is not
exactly the same. For this reason I also classified this
as a buffer function and not a compat function.

Change-Id: Ia3477b8ee7a637c15aad7f285144280595cda5d5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1489
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1489
This mail reflects revision 6 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 12a8ff9..8304fb7 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1134,6 +1134,17 @@
     }
 }
 
+bool
+checked_snprintf(char *str, size_t size, const char *format, ...)
+{
+    va_list arglist;
+    va_start(arglist, format);
+    ASSERT(size < INT_MAX);
+    int len = vsnprintf(str, size, format, arglist);
+    va_end(arglist);
+    return (len >= 0 && len < (ssize_t)size);
+}
+
 #ifdef VERIFY_ALIGNMENT
 void
 valign4(const struct buffer *buf, const char *file, const int line)
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 7502050..86df1a5 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -971,6 +971,29 @@
     return 0 == strncmp(str, prefix, strlen(prefix));
 }
 
+/**
+ * Like snprintf() but returns an boolean.
+ *
+ * To check the return value of snprintf() one needs to
+ * do multiple comparisons of the \p size parameter
+ * against the return value. Doesn't get prettier by
+ * them being different types with different signedness
+ * and size.
+ *
+ * So this function allows to wrap all of that into one
+ * boolean return value.
+ *
+ * @return true if snprintf() was successful and not truncated.
+ */
+bool checked_snprintf(char *str, size_t size, const char *format, ...)
+#ifdef __GNUC__
+#if __USE_MINGW_ANSI_STDIO
+    __attribute__((format(gnu_printf, 3, 4)))
+#else
+    __attribute__((format(__printf__, 3, 4)))
+#endif
+#endif
+    ;
 
 /*
  * Verify that a pointer is correctly aligned
diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index e8931d7..7aaea3d 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -1014,7 +1014,7 @@
 {
     char prefix[256];
 
-    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >= sizeof(prefix))
+    if (!checked_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
     {
         return mbed_log_err(flags, errval, func);
     }
@@ -1104,11 +1104,11 @@
     char header[1000 + 1] = { 0 };
     char footer[1000 + 1] = { 0 };
 
-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >= sizeof(header))
+    if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name))
     {
         return false;
     }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >= sizeof(footer))
+    if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----\n", name))
     {
         return false;
     }
@@ -1142,11 +1142,11 @@
     char header[1000 + 1] = { 0 };
     char footer[1000 + 1] = { 0 };
 
-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >= sizeof(header))
+    if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
     {
         return false;
     }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >= sizeof(footer))
+    if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----", name))
     {
         return false;
     }
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c
index 00fe542..237564c 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -130,7 +130,7 @@
 {
     char prefix[256];
 
-    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >= sizeof(prefix))
+    if (!checked_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
     {
         return mbed_log_err(flags, errval, func);
     }
@@ -246,11 +246,11 @@
     char header[1000 + 1] = { 0 };
     char footer[1000 + 1] = { 0 };
 
-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >= sizeof(header))
+    if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name))
     {
         return false;
     }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >= sizeof(footer))
+    if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----\n", name))
     {
         return false;
     }
@@ -283,11 +283,11 @@
     char header[1000 + 1] = { 0 };
     char footer[1000 + 1] = { 0 };
 
-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >= sizeof(header))
+    if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
     {
         return false;
     }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >= sizeof(footer))
+    if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----", name))
     {
         return false;
     }
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index f4f7779..3a294ec 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -485,13 +485,11 @@
 
     if (j < 0)
     {
-        const int ret = snprintf(name, sizeof(name), format, i);
-        name_ok = (ret > 0 && ret < sizeof(name));
+        name_ok = checked_snprintf(name, sizeof(name), format, i);
     }
     else
     {
-        const int ret = snprintf(name, sizeof(name), format, i, j);
-        name_ok = (ret > 0 && ret < sizeof(name));
+        name_ok = checked_snprintf(name, sizeof(name), format, i, j);
     }
 
     if (!name_ok)
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 99ac45c..d992097 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -334,7 +334,7 @@
     strcpy(tmpname, name);
     while (NULL != env_set_get(es, tmpname) && counter < 1000)
     {
-        ASSERT(snprintf(tmpname, tmpname_len, "%s_%u", name, counter) < tmpname_len);
+        ASSERT(checked_snprintf(tmpname, tmpname_len, "%s_%u", name, counter));
         counter++;
     }
     if (counter < 1000)
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 4f0eddf..3a6b272 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -550,9 +550,8 @@
     {
         ++attempts;
 
-        const int ret = snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,
-                                 (unsigned long)get_random(), (unsigned long)get_random());
-        if (ret < 0 || ret >= sizeof(fname))
+        if (!checked_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len, prefix,
+                              (unsigned long)get_random(), (unsigned long)get_random()))
         {
             msg(M_WARN, "ERROR: temporary filename too long");
             return NULL;
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index b355827..9f3ec93 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -771,11 +771,10 @@
                 }
 
                 /* send digest response */
-                int sret = snprintf(
-                    buf, sizeof(buf),
-                    "Proxy-Authorization: Digest username=\"%s\", realm=\"%s\", nonce=\"%s\", uri=\"%s\", qop=%s, nc=%s, cnonce=\"%s\", response=\"%s\"%s",
-                    username, realm, nonce, uri, qop, nonce_count, cnonce, response, opaque_kv);
-                if (sret >= sizeof(buf))
+                if (!checked_snprintf(
+                        buf, sizeof(buf),
+                        "Proxy-Authorization: Digest username=\"%s\", realm=\"%s\", nonce=\"%s\", uri=\"%s\", qop=%s, nc=%s, cnonce=\"%s\", response=\"%s\"%s",
+                        username, realm, nonce, uri, qop, nonce_count, cnonce, response, opaque_kv))
                 {
                     goto error;
                 }
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index 5cb5912..19f3d54 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -119,10 +119,9 @@
         goto cleanup;
     }
 
-    int sret = snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s", (int)strlen(creds.username),
-                        creds.username, (int)strlen(creds.password), creds.password);
-    ASSERT(sret >= 0 && sret <= sizeof(to_send));
-
+    ASSERT(checked_snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s",
+                            (int)strlen(creds.username), creds.username,
+                            (int)strlen(creds.password), creds.password));
     if (!proxy_send(sd, to_send, strlen(to_send)))
     {
         goto cleanup;
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 20fd2f0..686f823 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -198,7 +198,7 @@
     size_t newlen = strlen(o->ncp_ciphers) + 1 + strlen(ciphername) + 1;
     char *ncp_ciphers = gc_malloc(newlen, false, &o->gc);
 
-    ASSERT(snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers, ciphername) < newlen);
+    ASSERT(checked_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers, ciphername));
     o->ncp_ciphers = ncp_ciphers;
 }
 
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0b02a2f..9e30d25 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -548,7 +548,7 @@
         goto cleanup;
     }
 
-    if (snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, serial) >= sizeof(fn))
+    if (!checked_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, serial))
     {
         msg(D_HANDSHAKE, "VERIFY CRL: filename overflow");
         goto cleanup;
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index adeaa13..ad5479c 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -93,9 +93,7 @@
 
         ret = mbedtls_x509_crt_verify_info(errstr, sizeof(errstr) - 1, "", *flags);
         if (ret <= 0
-            && snprintf(errstr, sizeof(errstr), "Could not retrieve error string, flags=%" PRIx32,
-                        *flags)
-                   >= sizeof(errstr))
+            && !checked_snprintf(errstr, sizeof(errstr), "Could not retrieve error string, flags=%" PRIx32, *flags))
         {
             errstr[0] = '\0';
         }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 3f9ee5d..ecebff7 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3558,9 +3558,7 @@
             msg(M_FATAL, "Error enumerating registry subkeys of key: %s", ADAPTER_KEY);
         }
 
-        int ret = snprintf(unit_string, sizeof(unit_string), "%s\\%s", ADAPTER_KEY, enum_name);
-
-        if (ret < 0 || ret >= sizeof(unit_string))
+        if (!checked_snprintf(unit_string, sizeof(unit_string), "%s\\%s", ADAPTER_KEY, enum_name))
         {
             msg(M_WARN, "Error constructing unit string for %s", enum_name);
             continue;
@@ -3673,10 +3671,9 @@
             msg(M_FATAL, "Error enumerating registry subkeys of key: %s", NETWORK_CONNECTIONS_KEY);
         }
 
-        int ret = snprintf(connection_string, sizeof(connection_string), "%s\\%s\\Connection",
-                           NETWORK_CONNECTIONS_KEY, enum_name);
-
-        if (ret < 0 || ret >= sizeof(connection_string))
+        if (!checked_snprintf(connection_string, sizeof(connection_string),
+                              "%s\\%s\\Connection",
+                              NETWORK_CONNECTIONS_KEY, enum_name))
         {
             msg(M_WARN, "Error constructing connection string for %s", enum_name);
             continue;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index b938d7b..ac449fd 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -881,9 +881,8 @@
     char force_path[256];
     char *sysroot = get_win_sys_path();
 
-    if (snprintf(force_path, sizeof(force_path), "PATH=%s\\System32;%s;%s\\System32\\Wbem",
-                 sysroot, sysroot, sysroot)
-        >= sizeof(force_path))
+    if (!checked_snprintf(force_path, sizeof(force_path), "PATH=%s\\System32;%s;%s\\System32\\Wbem",
+                          sysroot, sysroot, sysroot))
     {
         msg(M_WARN, "env_block: default path truncated to %s", force_path);
     }
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 16949bc..d04f40a 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -424,6 +424,16 @@
 #endif
 }
 
+static void
+test_checked_snprintf(void **state)
+{
+    char buf[10];
+    assert_true(checked_snprintf(buf, sizeof(buf), "%s", "Hello"));
+    assert_true(checked_snprintf(buf, sizeof(buf), "%s", "Hello Foo"));
+    assert_false(checked_snprintf(buf, sizeof(buf), "%s", "Hello Foo!"));
+    assert_false(checked_snprintf(buf, sizeof(buf), "%s", "Hello World!"));
+}
+
 void
 test_buffer_chomp(void **state)
 {
@@ -528,6 +538,7 @@
         cmocka_unit_test(test_character_class),
         cmocka_unit_test(test_character_string_mod_buf),
         cmocka_unit_test(test_snprintf),
+        cmocka_unit_test(test_checked_snprintf),
         cmocka_unit_test(test_buffer_chomp),
         cmocka_unit_test(test_buffer_parse)
     };

