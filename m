From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 4 Feb 2026 13:36:43 +0000
In-Reply-To: <gerrit.1769443458000.Ia3477b8ee7a637c15aad7f285144280595cda5d5@...2715...>
References: <gerrit.1769443458000.Ia3477b8ee7a637c15aad7f285144280595cda5d5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <80d0755203e721814d882f699297f0a9bd8e23f2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bWUYAjshNQc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Add
 checked_snprintf function and use it in the code
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

--bWUYAjshNQc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1489?usp=3Demail

to look at the new patch set (#3).


Change subject: buffer: Add checked_snprintf function and use it in the code
......................................................................

buffer: Add checked_snprintf function and use it in the code

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
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/crypto_mbedtls.c
M src/openvpn/crypto_mbedtls_legacy.c
M src/openvpn/dns.c
M src/openvpn/env_set.c
M src/openvpn/platform.c
M src/openvpn/proxy.c
M src/openvpn/socks.c
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/tun.c
M src/openvpn/win32.c
M tests/unit_tests/openvpn/test_buffer.c
15 files changed, 76 insertions(+), 42 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/89/1489/3

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index dd74b38..d078d79 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -1125,6 +1125,17 @@
     }
 }

+bool
+checked_snprintf(char *str, size_t size, const char *format, ...)
+{
+    va_list arglist;
+    va_start(arglist, format);
+    ASSERT(size < INT_MAX);
+    int len =3D vsnprintf(str, size, format, arglist);
+    va_end(arglist);
+    return (len >=3D 0 && len < (ssize_t)size);
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
     return 0 =3D=3D strncmp(str, prefix, strlen(prefix));
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
index 5418df9..3bb9691 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -988,7 +988,7 @@
 {
     char prefix[256];

-    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >=3D sizeof(=
prefix))
+    if (!checked_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
     {
         return mbed_log_err(flags, errval, func);
     }
@@ -1078,11 +1078,11 @@
     char header[1000 + 1] =3D { 0 };
     char footer[1000 + 1] =3D { 0 };

-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >=
=3D sizeof(header))
+    if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----\n", =
name))
     {
         return false;
     }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >=3D =
sizeof(footer))
+    if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----\n", na=
me))
     {
         return false;
     }
@@ -1116,11 +1116,11 @@
     char header[1000 + 1] =3D { 0 };
     char footer[1000 + 1] =3D { 0 };

-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >=3D =
sizeof(header))
+    if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----", na=
me))
     {
         return false;
     }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >=3D si=
zeof(footer))
+    if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----", name=
))
     {
         return false;
     }
diff --git a/src/openvpn/crypto_mbedtls_legacy.c b/src/openvpn/crypto_mbedt=
ls_legacy.c
index a991349..7a2f6ff 100644
--- a/src/openvpn/crypto_mbedtls_legacy.c
+++ b/src/openvpn/crypto_mbedtls_legacy.c
@@ -130,7 +130,7 @@
 {
     char prefix[256];

-    if (snprintf(prefix, sizeof(prefix), "%s:%d", func, line) >=3D sizeof(=
prefix))
+    if (!checked_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
     {
         return mbed_log_err(flags, errval, func);
     }
@@ -246,11 +246,11 @@
     char header[1000 + 1] =3D { 0 };
     char footer[1000 + 1] =3D { 0 };

-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name) >=
=3D sizeof(header))
+    if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----\n", =
name))
     {
         return false;
     }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----\n", name) >=3D =
sizeof(footer))
+    if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----\n", na=
me))
     {
         return false;
     }
@@ -283,11 +283,11 @@
     char header[1000 + 1] =3D { 0 };
     char footer[1000 + 1] =3D { 0 };

-    if (snprintf(header, sizeof(header), "-----BEGIN %s-----", name) >=3D =
sizeof(header))
+    if (!checked_snprintf(header, sizeof(header), "-----BEGIN %s-----", na=
me))
     {
         return false;
     }
-    if (snprintf(footer, sizeof(footer), "-----END %s-----", name) >=3D si=
zeof(footer))
+    if (!checked_snprintf(footer, sizeof(footer), "-----END %s-----", name=
))
     {
         return false;
     }
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index c00d4b9..b367d87 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -485,13 +485,11 @@

     if (j < 0)
     {
-        const int ret =3D snprintf(name, sizeof(name), format, i);
-        name_ok =3D (ret > 0 && ret < sizeof(name));
+        name_ok =3D checked_snprintf(name, sizeof(name), format, i);
     }
     else
     {
-        const int ret =3D snprintf(name, sizeof(name), format, i, j);
-        name_ok =3D (ret > 0 && ret < sizeof(name));
+        name_ok =3D checked_snprintf(name, sizeof(name), format, i, j);
     }

     if (!name_ok)
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index 99ac45c..d992097 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -334,7 +334,7 @@
     strcpy(tmpname, name);
     while (NULL !=3D env_set_get(es, tmpname) && counter < 1000)
     {
-        ASSERT(snprintf(tmpname, tmpname_len, "%s_%u", name, counter) < tm=
pname_len);
+        ASSERT(checked_snprintf(tmpname, tmpname_len, "%s_%u", name, count=
er));
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

-        const int ret =3D snprintf(fname, sizeof(fname), fname_fmt, max_pr=
efix_len, prefix,
-                                 (unsigned long)get_random(), (unsigned lo=
ng)get_random());
-        if (ret < 0 || ret >=3D sizeof(fname))
+        if (!checked_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_=
len, prefix,
+                              (unsigned long)get_random(), (unsigned long)=
get_random()))
         {
             msg(M_WARN, "ERROR: temporary filename too long");
             return NULL;
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index efd4aad..7101d9f 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -926,11 +926,10 @@
                 }

                 /* send digest response */
-                int sret =3D snprintf(
-                    buf, sizeof(buf),
-                    "Proxy-Authorization: Digest username=3D\"%s\", realm=
=3D\"%s\", nonce=3D\"%s\", uri=3D\"%s\", qop=3D%s, nc=3D%s, cnonce=3D\"%s\"=
, response=3D\"%s\"%s",
-                    username, realm, nonce, uri, qop, nonce_count, cnonce,=
 response, opaque_kv);
-                if (sret >=3D sizeof(buf))
+                if (!checked_snprintf(
+                        buf, sizeof(buf),
+                        "Proxy-Authorization: Digest username=3D\"%s\", re=
alm=3D\"%s\", nonce=3D\"%s\", uri=3D\"%s\", qop=3D%s, nc=3D%s, cnonce=3D\"%=
s\", response=3D\"%s\"%s",
+                        username, realm, nonce, uri, qop, nonce_count, cno=
nce, response, opaque_kv))
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

-    int sret =3D snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s", (int)s=
trlen(creds.username),
-                        creds.username, (int)strlen(creds.password), creds=
.password);
-    ASSERT(sret >=3D 0 && sret <=3D sizeof(to_send));
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
     size_t newlen =3D strlen(o->ncp_ciphers) + 1 + strlen(ciphername) + 1;
     char *ncp_ciphers =3D gc_malloc(newlen, false, &o->gc);

-    ASSERT(snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers, cipherna=
me) < newlen);
+    ASSERT(checked_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers, =
ciphername));
     o->ncp_ciphers =3D ncp_ciphers;
 }

diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 0b02a2f..9e30d25 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -548,7 +548,7 @@
         goto cleanup;
     }

-    if (snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, serial=
) >=3D sizeof(fn))
+    if (!checked_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATO=
R, serial))
     {
         msg(D_HANDSHAKE, "VERIFY CRL: filename overflow");
         goto cleanup;
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index 32f3ecb..4c29bc8 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -93,9 +93,7 @@

         ret =3D mbedtls_x509_crt_verify_info(errstr, sizeof(errstr) - 1, "=
", *flags);
         if (ret <=3D 0
-            && snprintf(errstr, sizeof(errstr), "Could not retrieve error =
string, flags=3D%" PRIx32,
-                        *flags)
-                   >=3D sizeof(errstr))
+            && !checked_snprintf(errstr, sizeof(errstr), "Could not retrie=
ve error string, flags=3D%" PRIx32, *flags))
         {
             errstr[0] =3D '\0';
         }
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e38df3e..3c20e97 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -3558,9 +3558,7 @@
             msg(M_FATAL, "Error enumerating registry subkeys of key: %s", =
ADAPTER_KEY);
         }

-        int ret =3D snprintf(unit_string, sizeof(unit_string), "%s\\%s", A=
DAPTER_KEY, enum_name);
-
-        if (ret < 0 || ret >=3D sizeof(unit_string))
+        if (!checked_snprintf(unit_string, sizeof(unit_string), "%s\\%s", =
ADAPTER_KEY, enum_name))
         {
             msg(M_WARN, "Error constructing unit string for %s", enum_name=
);
             continue;
@@ -3673,10 +3671,9 @@
             msg(M_FATAL, "Error enumerating registry subkeys of key: %s", =
NETWORK_CONNECTIONS_KEY);
         }

-        int ret =3D snprintf(connection_string, sizeof(connection_string),=
 "%s\\%s\\Connection",
-                           NETWORK_CONNECTIONS_KEY, enum_name);
-
-        if (ret < 0 || ret >=3D sizeof(connection_string))
+        if (!checked_snprintf(connection_string, sizeof(connection_string),
+                              "%s\\%s\\Connection",
+                              NETWORK_CONNECTIONS_KEY, enum_name))
         {
             msg(M_WARN, "Error constructing connection string for %s", enu=
m_name);
             continue;
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index b938d7b..ac449fd 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -881,9 +881,8 @@
     char force_path[256];
     char *sysroot =3D get_win_sys_path();

-    if (snprintf(force_path, sizeof(force_path), "PATH=3D%s\\System32;%s;%=
s\\System32\\Wbem",
-                 sysroot, sysroot, sysroot)
-        >=3D sizeof(force_path))
+    if (!checked_snprintf(force_path, sizeof(force_path), "PATH=3D%s\\Syst=
em32;%s;%s\\System32\\Wbem",
+                          sysroot, sysroot, sysroot))
     {
         msg(M_WARN, "env_block: default path truncated to %s", force_path);
     }
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1489?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia3477b8ee7a637c15aad7f285144280595cda5d5
Gerrit-Change-Number: 1489
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--bWUYAjshNQc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1489?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">buffer: Add checked_snprintf function and use it=
 in the code<br><br>This reintroduces a function that converts the result<b=
r>of snprintf to a boolean since the check is always the<br>same but annoyi=
ngly verbose. And it gets worse when you add<br>-Wsign-compare.<br><br>So i=
n preparation of introducing -Wsign-compare wrap this<br>check in the funct=
ion.<br><br>This somewhat reverts the removal of openvpn_snprintf.<br>But n=
ote that that was originally introduced to work<br>around the broken snprin=
tf of Windows. So this is not<br>exactly the same. For this reason I also c=
lassified this<br>as a buffer function and not a compat function.<br><br>Ch=
ange-Id: Ia3477b8ee7a637c15aad7f285144280595cda5d5<br>Signed-off-by: Frank =
Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/buffer.c<br>M =
src/openvpn/buffer.h<br>M src/openvpn/crypto_mbedtls.c<br>M src/openvpn/cry=
pto_mbedtls_legacy.c<br>M src/openvpn/dns.c<br>M src/openvpn/env_set.c<br>M=
 src/openvpn/platform.c<br>M src/openvpn/proxy.c<br>M src/openvpn/socks.c<b=
r>M src/openvpn/ssl_ncp.c<br>M src/openvpn/ssl_verify.c<br>M src/openvpn/ss=
l_verify_mbedtls.c<br>M src/openvpn/tun.c<br>M src/openvpn/win32.c<br>M tes=
ts/unit_tests/openvpn/test_buffer.c<br>15 files changed, 76 insertions(+), =
42 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/89/1489/3</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buf=
fer.c b/src/openvpn/buffer.c</span><br><span>index dd74b38..d078d79 100644<=
/span><br><span>--- a/src/openvpn/buffer.c</span><br><span>+++ b/src/openvp=
n/buffer.c</span><br><span>@@ -1125,6 +1125,17 @@</span><br><span>     }</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
checked_snprintf(char *str, size_t size, const char *format, ...)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    va_list arglist;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    va_start(arglist, format);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(size &lt; INT_MAX);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    int len =3D vsnprint=
f(str, size, format, arglist);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    va_end(arglist);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return (len &gt;=3D 0 &amp;&amp; len &lt; (ssize_t)size);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef VERIFY_ALIGNME=
NT</span><br><span> void</span><br><span> valign4(const struct buffer *buf,=
 const char *file, const int line)</span><br><span>diff --git a/src/openvpn=
/buffer.h b/src/openvpn/buffer.h</span><br><span>index 7502050..86df1a5 100=
644</span><br><span>--- a/src/openvpn/buffer.h</span><br><span>+++ b/src/op=
envpn/buffer.h</span><br><span>@@ -971,6 +971,29 @@</span><br><span>     re=
turn 0 =3D=3D strncmp(str, prefix, strlen(prefix));</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Like snprintf() but=
 returns an boolean.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * To check the =
return value of snprintf() one needs to</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * do multiple comparisons of the \p size parameter</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * against the return v=
alue. Doesn&#39;t get prettier by</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+ * them being different types with different signedness</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * and size.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * So this function allows to wrap all of that in=
to one</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * boolean re=
turn value.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if snprin=
tf() was successful and not truncated.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+bool checked_snprintf(char *str, size_t size, const char *format, ...)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef __GNUC__</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if __USE_MINGW_ANSI_STDI=
O</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __attribute__(=
(format(gnu_printf, 3, 4)))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    __=
attribute__((format(__printf__, 3, 4)))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ;<=
/span><br><span> </span><br><span> /*</span><br><span>  * Verify that a poi=
nter is correctly aligned</span><br><span>diff --git a/src/openvpn/crypto_m=
bedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index 5418df9..3bb9=
691 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</span><br><sp=
an>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -988,7 +988,7 @@</=
span><br><span> {</span><br><span>     char prefix[256];</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (snprintf(prefi=
x, sizeof(prefix), &quot;%s:%d&quot;, func, line) &gt;=3D sizeof(prefix))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!checked_snpr=
intf(prefix, sizeof(prefix), &quot;%s:%d&quot;, func, line))</span><br><spa=
n>     {</span><br><span>         return mbed_log_err(flags, errval, func);=
</span><br><span>     }</span><br><span>@@ -1078,11 +1078,11 @@</span><br><=
span>     char header[1000 + 1] =3D { 0 };</span><br><span>     char footer=
[1000 + 1] =3D { 0 };</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    if (snprintf(header, sizeof(header), &quot;-----BEGIN=
 %s-----\n&quot;, name) &gt;=3D sizeof(header))</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!checked_snprintf(header, sizeof(header=
), &quot;-----BEGIN %s-----\n&quot;, name))</span><br><span>     {</span><b=
r><span>         return false;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (snprintf(footer, sizeof(footer), &q=
uot;-----END %s-----\n&quot;, name) &gt;=3D sizeof(footer))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!checked_snprintf(footer, s=
izeof(footer), &quot;-----END %s-----\n&quot;, name))</span><br><span>     =
{</span><br><span>         return false;</span><br><span>     }</span><br><=
span>@@ -1116,11 +1116,11 @@</span><br><span>     char header[1000 + 1] =3D=
 { 0 };</span><br><span>     char footer[1000 + 1] =3D { 0 };</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (snprintf(=
header, sizeof(header), &quot;-----BEGIN %s-----&quot;, name) &gt;=3D sizeo=
f(header))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!=
checked_snprintf(header, sizeof(header), &quot;-----BEGIN %s-----&quot;, na=
me))</span><br><span>     {</span><br><span>         return false;</span><b=
r><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(snprintf(footer, sizeof(footer), &quot;-----END %s-----&quot;, name) &gt;=
=3D sizeof(footer))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (!checked_snprintf(footer, sizeof(footer), &quot;-----END %s-----&qu=
ot;, name))</span><br><span>     {</span><br><span>         return false;</=
span><br><span>     }</span><br><span>diff --git a/src/openvpn/crypto_mbedt=
ls_legacy.c b/src/openvpn/crypto_mbedtls_legacy.c</span><br><span>index a99=
1349..7a2f6ff 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls_legac=
y.c</span><br><span>+++ b/src/openvpn/crypto_mbedtls_legacy.c</span><br><sp=
an>@@ -130,7 +130,7 @@</span><br><span> {</span><br><span>     char prefix[=
256];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot;, func, line) &=
gt;=3D sizeof(prefix))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!checked_snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot;, fun=
c, line))</span><br><span>     {</span><br><span>         return mbed_log_e=
rr(flags, errval, func);</span><br><span>     }</span><br><span>@@ -246,11 =
+246,11 @@</span><br><span>     char header[1000 + 1] =3D { 0 };</span><br>=
<span>     char footer[1000 + 1] =3D { 0 };</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (snprintf(header, sizeof(hea=
der), &quot;-----BEGIN %s-----\n&quot;, name) &gt;=3D sizeof(header))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!checked_snprintf=
(header, sizeof(header), &quot;-----BEGIN %s-----\n&quot;, name))</span><br=
><span>     {</span><br><span>         return false;</span><br><span>     }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (snprintf(foot=
er, sizeof(footer), &quot;-----END %s-----\n&quot;, name) &gt;=3D sizeof(fo=
oter))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!chec=
ked_snprintf(footer, sizeof(footer), &quot;-----END %s-----\n&quot;, name))=
</span><br><span>     {</span><br><span>         return false;</span><br><s=
pan>     }</span><br><span>@@ -283,11 +283,11 @@</span><br><span>     char =
header[1000 + 1] =3D { 0 };</span><br><span>     char footer[1000 + 1] =3D =
{ 0 };</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (snprintf(header, sizeof(header), &quot;-----BEGIN %s-----&quot;,=
 name) &gt;=3D sizeof(header))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (!checked_snprintf(header, sizeof(header), &quot;-----BEG=
IN %s-----&quot;, name))</span><br><span>     {</span><br><span>         re=
turn false;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (snprintf(footer, sizeof(footer), &quot;-----END %s----=
-&quot;, name) &gt;=3D sizeof(footer))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!checked_snprintf(footer, sizeof(footer), &quot;=
-----END %s-----&quot;, name))</span><br><span>     {</span><br><span>     =
    return false;</span><br><span>     }</span><br><span>diff --git a/src/o=
penvpn/dns.c b/src/openvpn/dns.c</span><br><span>index c00d4b9..b367d87 100=
644</span><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openv=
pn/dns.c</span><br><span>@@ -485,13 +485,11 @@</span><br><span> </span><br>=
<span>     if (j &lt; 0)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        const int ret =3D snprintf(name, sizeof(n=
ame), format, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    name_ok =3D (ret &gt; 0 &amp;&amp; ret &lt; sizeof(name));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        name_ok =3D checked_snpr=
intf(name, sizeof(name), format, i);</span><br><span>     }</span><br><span=
>     else</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        const int ret =3D snprintf(name, sizeof(name), format, =
i, j);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        name_ok=
 =3D (ret &gt; 0 &amp;&amp; ret &lt; sizeof(name));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        name_ok =3D checked_snprintf(name=
, sizeof(name), format, i, j);</span><br><span>     }</span><br><span> </sp=
an><br><span>     if (!name_ok)</span><br><span>diff --git a/src/openvpn/en=
v_set.c b/src/openvpn/env_set.c</span><br><span>index 99ac45c..d992097 1006=
44</span><br><span>--- a/src/openvpn/env_set.c</span><br><span>+++ b/src/op=
envpn/env_set.c</span><br><span>@@ -334,7 +334,7 @@</span><br><span>     st=
rcpy(tmpname, name);</span><br><span>     while (NULL !=3D env_set_get(es, =
tmpname) &amp;&amp; counter &lt; 1000)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(snprintf(tmpname, tm=
pname_len, &quot;%s_%u&quot;, name, counter) &lt; tmpname_len);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(checked_snprintf=
(tmpname, tmpname_len, &quot;%s_%u&quot;, name, counter));</span><br><span>=
         counter++;</span><br><span>     }</span><br><span>     if (counter=
 &lt; 1000)</span><br><span>diff --git a/src/openvpn/platform.c b/src/openv=
pn/platform.c</span><br><span>index 4f0eddf..3a6b272 100644</span><br><span=
>--- a/src/openvpn/platform.c</span><br><span>+++ b/src/openvpn/platform.c<=
/span><br><span>@@ -550,9 +550,8 @@</span><br><span>     {</span><br><span>=
         ++attempts;</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        const int ret =3D snprintf(fname, sizeof(fname), f=
name_fmt, max_prefix_len, prefix,</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                 (unsigned long)get_random(), (=
unsigned long)get_random());</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        if (ret &lt; 0 || ret &gt;=3D sizeof(fname))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (!checked_snprintf(fname=
, sizeof(fname), fname_fmt, max_prefix_len, prefix,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                              (unsigned l=
ong)get_random(), (unsigned long)get_random()))</span><br><span>         {<=
/span><br><span>             msg(M_WARN, &quot;ERROR: temporary filename to=
o long&quot;);</span><br><span>             return NULL;</span><br><span>di=
ff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>index =
efd4aad..7101d9f 100644</span><br><span>--- a/src/openvpn/proxy.c</span><br=
><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -926,11 +926,10 @@</spa=
n><br><span>                 }</span><br><span> </span><br><span>          =
       /* send digest response */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                int sret =3D snprintf(</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                    buf, sizeof(buf),</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;Prox=
y-Authorization: Digest username=3D\&quot;%s\&quot;, realm=3D\&quot;%s\&quo=
t;, nonce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%s, nc=3D%s, cn=
once=3D\&quot;%s\&quot;, response=3D\&quot;%s\&quot;%s&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                    username, realm=
, nonce, uri, qop, nonce_count, cnonce, response, opaque_kv);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                if (sret &gt;=3D si=
zeof(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       if (!checked_snprintf(</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        buf, sizeof(buf),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        &quot;Proxy-Autho=
rization: Digest username=3D\&quot;%s\&quot;, realm=3D\&quot;%s\&quot;, non=
ce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%s, nc=3D%s, cnonce=3D=
\&quot;%s\&quot;, response=3D\&quot;%s\&quot;%s&quot;,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                        username, realm,=
 nonce, uri, qop, nonce_count, cnonce, response, opaque_kv))</span><br><spa=
n>                 {</span><br><span>                     goto error;</span=
><br><span>                 }</span><br><span>diff --git a/src/openvpn/sock=
s.c b/src/openvpn/socks.c</span><br><span>index 5cb5912..19f3d54 100644</sp=
an><br><span>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openvpn/so=
cks.c</span><br><span>@@ -119,10 +119,9 @@</span><br><span>         goto cl=
eanup;</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    int sret =3D snprintf(to_send, sizeof(to_send=
), &quot;\x01%c%s%c%s&quot;, (int)strlen(creds.username),</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                        creds.username,=
 (int)strlen(creds.password), creds.password);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    ASSERT(sret &gt;=3D 0 &amp;&amp; sret &lt;=3D =
sizeof(to_send));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(checked_snpr=
intf(to_send, sizeof(to_send), &quot;\x01%c%s%c%s&quot;,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                            (int)strle=
n(creds.username), creds.username,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                            (int)strlen(creds.password), cre=
ds.password));</span><br><span>     if (!proxy_send(sd, to_send, strlen(to_=
send)))</span><br><span>     {</span><br><span>         goto cleanup;</span=
><br><span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span=
><br><span>index 20fd2f0..686f823 100644</span><br><span>--- a/src/openvpn/=
ssl_ncp.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -1=
98,7 +198,7 @@</span><br><span>     size_t newlen =3D strlen(o-&gt;ncp_ciph=
ers) + 1 + strlen(ciphername) + 1;</span><br><span>     char *ncp_ciphers =
=3D gc_malloc(newlen, false, &amp;o-&gt;gc);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(snprintf(ncp_ciphers, n=
ewlen, &quot;%s:%s&quot;, o-&gt;ncp_ciphers, ciphername) &lt; newlen);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(checked_snpri=
ntf(ncp_ciphers, newlen, &quot;%s:%s&quot;, o-&gt;ncp_ciphers, ciphername))=
;</span><br><span>     o-&gt;ncp_ciphers =3D ncp_ciphers;</span><br><span> =
}</span><br><span> </span><br><span>diff --git a/src/openvpn/ssl_verify.c b=
/src/openvpn/ssl_verify.c</span><br><span>index 0b02a2f..9e30d25 100644</sp=
an><br><span>--- a/src/openvpn/ssl_verify.c</span><br><span>+++ b/src/openv=
pn/ssl_verify.c</span><br><span>@@ -548,7 +548,7 @@</span><br><span>       =
  goto cleanup;</span><br><span>     }</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (snprintf(fn, sizeof(fn), &quot;%=
s%c%s&quot;, crl_dir, PATH_SEPARATOR, serial) &gt;=3D sizeof(fn))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    if (!checked_snprintf(fn,=
 sizeof(fn), &quot;%s%c%s&quot;, crl_dir, PATH_SEPARATOR, serial))</span><b=
r><span>     {</span><br><span>         msg(D_HANDSHAKE, &quot;VERIFY CRL: =
filename overflow&quot;);</span><br><span>         goto cleanup;</span><br>=
<span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verif=
y_mbedtls.c</span><br><span>index 32f3ecb..4c29bc8 100644</span><br><span>-=
-- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl=
_verify_mbedtls.c</span><br><span>@@ -93,9 +93,7 @@</span><br><span> </span=
><br><span>         ret =3D mbedtls_x509_crt_verify_info(errstr, sizeof(err=
str) - 1, &quot;&quot;, *flags);</span><br><span>         if (ret &lt;=3D 0=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp=
; snprintf(errstr, sizeof(errstr), &quot;Could not retrieve error string, f=
lags=3D%&quot; PRIx32,</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                        *flags)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                   &gt;=3D sizeof(errstr))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; !checked_snprintf(=
errstr, sizeof(errstr), &quot;Could not retrieve error string, flags=3D%&qu=
ot; PRIx32, *flags))</span><br><span>         {</span><br><span>           =
  errstr[0] =3D &#39;\0&#39;;</span><br><span>         }</span><br><span>di=
ff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index e38d=
f3e..3c20e97 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span=
>+++ b/src/openvpn/tun.c</span><br><span>@@ -3558,9 +3558,7 @@</span><br><s=
pan>             msg(M_FATAL, &quot;Error enumerating registry subkeys of k=
ey: %s&quot;, ADAPTER_KEY);</span><br><span>         }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        int ret =3D snpr=
intf(unit_string, sizeof(unit_string), &quot;%s\\%s&quot;, ADAPTER_KEY, enu=
m_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (ret &lt; 0 || ret &gt;=
=3D sizeof(unit_string))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (!checked_snprintf(unit_string, sizeof(unit_string), &quot;=
%s\\%s&quot;, ADAPTER_KEY, enum_name))</span><br><span>         {</span><br=
><span>             msg(M_WARN, &quot;Error constructing unit string for %s=
&quot;, enum_name);</span><br><span>             continue;</span><br><span>=
@@ -3673,10 +3671,9 @@</span><br><span>             msg(M_FATAL, &quot;Erro=
r enumerating registry subkeys of key: %s&quot;, NETWORK_CONNECTIONS_KEY);<=
/span><br><span>         }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        int ret =3D snprintf(connection_string, size=
of(connection_string), &quot;%s\\%s\\Connection&quot;,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                           NETWORK_CONNECT=
IONS_KEY, enum_name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (ret &lt; =
0 || ret &gt;=3D sizeof(connection_string))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!checked_snprintf(connection_string, si=
zeof(connection_string),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                              &quot;%s\\%s\\Connection&quot;,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
  NETWORK_CONNECTIONS_KEY, enum_name))</span><br><span>         {</span><br=
><span>             msg(M_WARN, &quot;Error constructing connection string =
for %s&quot;, enum_name);</span><br><span>             continue;</span><br>=
<span>diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><spa=
n>index b938d7b..ac449fd 100644</span><br><span>--- a/src/openvpn/win32.c</=
span><br><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -881,9 +881,8 @=
@</span><br><span>     char force_path[256];</span><br><span>     char *sys=
root =3D get_win_sys_path();</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (snprintf(force_path, sizeof(force_path), &=
quot;PATH=3D%s\\System32;%s;%s\\System32\\Wbem&quot;,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 sysroot, sysroot, sysroot)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        &gt;=3D sizeo=
f(force_path))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!checked_snprintf(force_path, sizeof(force_path), &quot;PATH=3D%s\\Syste=
m32;%s;%s\\System32\\Wbem&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                          sysroot, sysroot, sysroot))</span><b=
r><span>     {</span><br><span>         msg(M_WARN, &quot;env_block: defaul=
t path truncated to %s&quot;, force_path);</span><br><span>     }</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tes=
ts/openvpn/test_buffer.c</span><br><span>index 16949bc..d04f40a 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>@@ -424,6 +424,1=
6 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+test_checked_snprintf(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    char buf[10];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(checked_snprintf(buf, siz=
eof(buf), &quot;%s&quot;, &quot;Hello&quot;));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(checked_snprintf(buf, sizeof(buf=
), &quot;%s&quot;, &quot;Hello Foo&quot;));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_false(checked_snprintf(buf, sizeof(buf),=
 &quot;%s&quot;, &quot;Hello Foo!&quot;));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(checked_snprintf(buf, sizeof(buf), =
&quot;%s&quot;, &quot;Hello World!&quot;));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> void</span><br><span> test_buffer_chomp(void **stat=
e)</span><br><span> {</span><br><span>@@ -528,6 +538,7 @@</span><br><span> =
        cmocka_unit_test(test_character_class),</span><br><span>         cm=
ocka_unit_test(test_character_string_mod_buf),</span><br><span>         cmo=
cka_unit_test(test_snprintf),</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        cmocka_unit_test(test_checked_snprintf),</span><br><span>=
         cmocka_unit_test(test_buffer_chomp),</span><br><span>         cmoc=
ka_unit_test(test_buffer_parse)</span><br><span>     };</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1489?usp=3Demail">change 1489</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1489?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia3477b8ee7a637c15aad7f28514=
4280595cda5d5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1489 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--bWUYAjshNQc=--

