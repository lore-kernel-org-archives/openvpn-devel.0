From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 6 May 2024 15:28:07 +0000
In-Reply-To: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
References: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <f1f70465d8bb4fe3b6fb082f65540823f4f4e0da-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hoL2x7flXcg="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Remove
 openvpn_snprintf and similar functions
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hoL2x7flXcg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/54=
7?usp=3Demail )

Change subject: Remove openvpn_snprintf and similar functions
......................................................................

Remove openvpn_snprintf and similar functions

Old Microsoft versions did strange behaviour but according to the
newly added unit test and
https://stackoverflow.com/questions/7706936/is-snprintf-always-null-termina=
ting
this is now standard conforming and we can use the normal snprintf
method.

Microsoft own documentation to swprintf also says you nowadays need to
define _CRT_NON_CONFORMING_SWPRINTFS to get to non-standard behaviour.

Change-Id: I07096977e3b562bcb5d2c6f11673a4175b8e12ac
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240506102710.8976-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
617.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/crypto.c
M src/openvpn/crypto_mbedtls.c
M src/openvpn/dns.c
M src/openvpn/env_set.c
M src/openvpn/error.c
M src/openvpn/init.c
M src/openvpn/manage.c
M src/openvpn/options.c
M src/openvpn/pkcs11.c
M src/openvpn/platform.c
M src/openvpn/plugin.c
M src/openvpn/pool.c
M src/openvpn/proxy.c
M src/openvpn/ps.c
M src/openvpn/route.c
M src/openvpn/run_command.h
M src/openvpn/socket.c
M src/openvpn/socks.c
M src/openvpn/ssl_mbedtls.c
M src/openvpn/ssl_ncp.c
M src/openvpn/ssl_openssl.c
M src/openvpn/ssl_verify.c
M src/openvpn/ssl_verify_mbedtls.c
M src/openvpn/ssl_verify_openssl.c
M src/openvpn/tls_crypt.c
M src/openvpn/tun.c
M src/openvpn/win32.c
M src/openvpn/win32.h
M src/openvpn/xkey_helper.c
M src/openvpnserv/common.c
M src/openvpnserv/interactive.c
M src/openvpnserv/service.h
M src/openvpnserv/validate.c
M tests/unit_tests/openvpn/test_buffer.c
M tests/unit_tests/openvpn/test_cryptoapi.c
M tests/unit_tests/openvpn/test_pkcs11.c
38 files changed, 291 insertions(+), 333 deletions(-)




diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 66fd63f..3a8069c 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -279,32 +279,6 @@
     return ret;
 }

-
-/*
- * This is necessary due to certain buggy implementations of snprintf,
- * that don't guarantee null termination for size > 0.
- *
- * Return false on overflow.
- *
- * This functionality is duplicated in src/openvpnserv/common.c
- * Any modifications here should be done to the other place as well.
- */
-
-bool
-openvpn_snprintf(char *str, size_t size, const char *format, ...)
-{
-    va_list arglist;
-    int len =3D -1;
-    if (size > 0)
-    {
-        va_start(arglist, format);
-        len =3D vsnprintf(str, size, format, arglist);
-        va_end(arglist);
-        str[size - 1] =3D 0;
-    }
-    return (len >=3D 0 && len < size);
-}
-
 /*
  * write a string to the end of a buffer that was
  * truncated by buf_printf
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 7c2f75a..27c3199 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -448,19 +448,6 @@
  */
 bool buf_puts(struct buffer *buf, const char *str);

-/*
- * Like snprintf but guarantees null termination for size > 0
- */
-bool openvpn_snprintf(char *str, size_t size, const char *format, ...)
-#ifdef __GNUC__
-#if __USE_MINGW_ANSI_STDIO
-__attribute__ ((format(gnu_printf, 3, 4)))
-#else
-__attribute__ ((format(__printf__, 3, 4)))
-#endif
-#endif
-;
-

 /*
  * remove/add trailing characters
diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c
index 5d05cc4..207f145 100644
--- a/src/openvpn/crypto.c
+++ b/src/openvpn/crypto.c
@@ -874,11 +874,11 @@

     key_direction_state_init(&kds, key_direction);

-    openvpn_snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
+    snprintf(log_prefix, sizeof(log_prefix), "Outgoing %s", name);
     init_key_ctx(&ctx->encrypt, &key2->keys[kds.out_key], kt,
                  OPENVPN_OP_ENCRYPT, log_prefix);

-    openvpn_snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
+    snprintf(log_prefix, sizeof(log_prefix), "Incoming %s", name);
     init_key_ctx(&ctx->decrypt, &key2->keys[kds.in_key], kt,
                  OPENVPN_OP_DECRYPT, log_prefix);

diff --git a/src/openvpn/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c
index c230292..32511f0 100644
--- a/src/openvpn/crypto_mbedtls.c
+++ b/src/openvpn/crypto_mbedtls.c
@@ -128,7 +128,7 @@
 {
     char prefix[256];

-    if (!openvpn_snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
+    if (!snprintf(prefix, sizeof(prefix), "%s:%d", func, line))
     {
         return mbed_log_err(flags, errval, func);
     }
@@ -239,11 +239,11 @@
     char header[1000+1] =3D { 0 };
     char footer[1000+1] =3D { 0 };

-    if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----\n", =
name))
+    if (!snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name))
     {
         return false;
     }
-    if (!openvpn_snprintf(footer, sizeof(footer), "-----END %s-----\n", na=
me))
+    if (!snprintf(footer, sizeof(footer), "-----END %s-----\n", name))
     {
         return false;
     }
@@ -278,11 +278,11 @@
     char header[1000+1] =3D { 0 };
     char footer[1000+1] =3D { 0 };

-    if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----", na=
me))
+    if (!snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
     {
         return false;
     }
-    if (!openvpn_snprintf(footer, sizeof(footer), "-----END %s-----", name=
))
+    if (!snprintf(footer, sizeof(footer), "-----END %s-----", name))
     {
         return false;
     }
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 7de3991..0539ca5 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -349,11 +349,11 @@

     if (j < 0)
     {
-        name_ok =3D openvpn_snprintf(name, sizeof(name), format, i);
+        name_ok =3D snprintf(name, sizeof(name), format, i);
     }
     else
     {
-        name_ok =3D openvpn_snprintf(name, sizeof(name), format, i, j);
+        name_ok =3D snprintf(name, sizeof(name), format, i, j);
     }

     if (!name_ok)
diff --git a/src/openvpn/env_set.c b/src/openvpn/env_set.c
index b13d01e..81ab59e 100644
--- a/src/openvpn/env_set.c
+++ b/src/openvpn/env_set.c
@@ -259,7 +259,7 @@
 setenv_counter(struct env_set *es, const char *name, counter_type value)
 {
     char buf[64];
-    openvpn_snprintf(buf, sizeof(buf), counter_format, value);
+    snprintf(buf, sizeof(buf), counter_format, value);
     setenv_str(es, name, buf);
 }

@@ -267,7 +267,7 @@
 setenv_int(struct env_set *es, const char *name, int value)
 {
     char buf[64];
-    openvpn_snprintf(buf, sizeof(buf), "%d", value);
+    snprintf(buf, sizeof(buf), "%d", value);
     setenv_str(es, name, buf);
 }

@@ -275,7 +275,7 @@
 setenv_long_long(struct env_set *es, const char *name, long long value)
 {
     char buf[64];
-    openvpn_snprintf(buf, sizeof(buf), "%" PRIi64, (int64_t)value);
+    snprintf(buf, sizeof(buf), "%" PRIi64, (int64_t)value);
     setenv_str(es, name, buf);
 }

@@ -310,7 +310,7 @@
     strcpy(tmpname, name);
     while (NULL !=3D env_set_get(es, tmpname) && counter < 1000)
     {
-        ASSERT(openvpn_snprintf(tmpname, tmpname_len, "%s_%u", name, count=
er));
+        ASSERT(snprintf(tmpname, tmpname_len, "%s_%u", name, counter));
         counter++;
     }
     if (counter < 1000)
diff --git a/src/openvpn/error.c b/src/openvpn/error.c
index 245a2d5..ec65d5e 100644
--- a/src/openvpn/error.c
+++ b/src/openvpn/error.c
@@ -274,14 +274,14 @@

     if ((flags & M_ERRNO) && e)
     {
-        openvpn_snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=3D%d)",
-                         m1, openvpn_strerror(e, crt_error, &gc), e);
+        snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=3D%d)",
+                 m1, openvpn_strerror(e, crt_error, &gc), e);
         SWAP;
     }

     if (flags & M_OPTERR)
     {
-        openvpn_snprintf(m2, ERR_BUF_SIZE, "Options error: %s", m1);
+        snprintf(m2, ERR_BUF_SIZE, "Options error: %s", m1);
         SWAP;
     }

@@ -321,10 +321,10 @@
         const struct virtual_output *vo =3D msg_get_virtual_output();
         if (vo)
         {
-            openvpn_snprintf(m2, ERR_BUF_SIZE, "%s%s%s",
-                             prefix,
-                             prefix_sep,
-                             m1);
+            snprintf(m2, ERR_BUF_SIZE, "%s%s%s",
+                     prefix,
+                     prefix_sep,
+                     m1);
             virtual_output_print(vo, flags, m2);
         }
     }
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index e67f10e..ec0c309 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -359,7 +359,7 @@
         char *out =3D malloc(len);
         check_malloc_return(out);

-        openvpn_snprintf(out, len, "%s,%s,%s,%s", ce->remote, ce->remote_p=
ort, proto, status);
+        snprintf(out, len, "%s,%s,%s,%s", ce->remote, ce->remote_port, pro=
to, status);
         *remote =3D out;
     }
     else
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 43c5507..89591ea 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -515,8 +515,8 @@
     char out[32];

     /* do in a roundabout way to work around possible mingw or mingw-glibc=
 bug */
-    openvpn_snprintf(in, sizeof(in), counter_format, man->persist.bytes_in=
 + dco_read_bytes);
-    openvpn_snprintf(out, sizeof(out), counter_format, man->persist.bytes_=
out + dco_write_bytes);
+    snprintf(in, sizeof(in), counter_format, man->persist.bytes_in + dco_r=
ead_bytes);
+    snprintf(out, sizeof(out), counter_format, man->persist.bytes_out + dc=
o_write_bytes);
     msg(M_CLIENT, ">BYTECOUNT:%s,%s", in, out);
 }

@@ -528,8 +528,8 @@
     char in[32];
     char out[32];
     /* do in a roundabout way to work around possible mingw or mingw-glibc=
 bug */
-    openvpn_snprintf(in, sizeof(in), counter_format, *bytes_in_total);
-    openvpn_snprintf(out, sizeof(out), counter_format, *bytes_out_total);
+    snprintf(in, sizeof(in), counter_format, *bytes_in_total);
+    snprintf(out, sizeof(out), counter_format, *bytes_out_total);
     msg(M_CLIENT, ">BYTECOUNT_CLI:%lu,%s,%s", mdac->cid, in, out);
     mdac->bytecount_last_update =3D now;
 }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 07387cd..abcde89 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1427,7 +1427,7 @@
     for (int i =3D 1; i <=3D opt_max; ++i)
     {
         char name[32];
-        openvpn_snprintf(name, sizeof(name), "foreign_option_%d", i);
+        snprintf(name, sizeof(name), "foreign_option_%d", i);

         const char *env_str =3D env_set_get(es, name);
         const char *value =3D strchr(env_str, '=3D') + 1;
@@ -1482,7 +1482,7 @@
     while (o->foreign_option_index < opt_max)
     {
         char name[32];
-        openvpn_snprintf(name, sizeof(name), "foreign_option_%d", opt_max-=
-);
+        snprintf(name, sizeof(name), "foreign_option_%d", opt_max--);
         setenv_del(es, name);
     }
 }
@@ -5674,8 +5674,8 @@
 #ifndef ENABLE_SMALL
     {
         char script_name[100];
-        openvpn_snprintf(script_name, sizeof(script_name),
-                         "--%s script", type);
+        snprintf(script_name, sizeof(script_name),
+                 "--%s script", type);

         if (check_cmd_access(*script, script_name, (in_chroot ? options->c=
hroot_dir : NULL)))
         {
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 35a02c2..418f6bb 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -201,7 +201,7 @@
     CLEAR(token_resp);
     token_resp.defined =3D false;
     token_resp.nocache =3D true;
-    openvpn_snprintf(
+    snprintf(
         token_resp.username,
         sizeof(token_resp.username),
         "Please insert %s token",
@@ -245,7 +245,7 @@

     ASSERT(token!=3DNULL);

-    openvpn_snprintf(prompt, sizeof(prompt), "%s token", token->label);
+    snprintf(prompt, sizeof(prompt), "%s token", token->label);

     token_pass.defined =3D false;
     token_pass.nocache =3D true;
@@ -719,7 +719,7 @@

         id_resp.defined =3D false;
         id_resp.nocache =3D true;
-        openvpn_snprintf(
+        snprintf(
             id_resp.username,
             sizeof(id_resp.username),
             "Please specify PKCS#11 id to use"
diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c
index 9853dac..3d9d59e 100644
--- a/src/openvpn/platform.c
+++ b/src/openvpn/platform.c
@@ -564,9 +564,9 @@
     {
         ++attempts;

-        if (!openvpn_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_=
len,
-                              prefix, (unsigned long) get_random(),
-                              (unsigned long) get_random()))
+        if (!snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len,
+                      prefix, (unsigned long) get_random(),
+                      (unsigned long) get_random()))
         {
             msg(M_WARN, "ERROR: temporary filename too long");
             return NULL;
diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c
index 2ad459c..944ce94 100644
--- a/src/openvpn/plugin.c
+++ b/src/openvpn/plugin.c
@@ -260,7 +260,7 @@
     {
         char full[PATH_MAX];

-        openvpn_snprintf(full, sizeof(full), "%s/%s", PLUGIN_LIBDIR, p->so=
_pathname);
+        snprintf(full, sizeof(full), "%s/%s", PLUGIN_LIBDIR, p->so_pathnam=
e);
         p->handle =3D dlopen(full, RTLD_NOW);
     }
     else
@@ -409,7 +409,7 @@

         gc_init(&gc);
         msg_fmt =3D gc_malloc(ERR_BUF_SIZE, false, &gc);
-        openvpn_snprintf(msg_fmt, ERR_BUF_SIZE, "PLUGIN %s: %s", name, for=
mat);
+        snprintf(msg_fmt, ERR_BUF_SIZE, "PLUGIN %s: %s", name, format);
         x_msg_va(msg_flags, msg_fmt, arglist);

         gc_free(&gc);
diff --git a/src/openvpn/pool.c b/src/openvpn/pool.c
index f706c1a..e3c3708 100644
--- a/src/openvpn/pool.c
+++ b/src/openvpn/pool.c
@@ -766,7 +766,7 @@
         ifconfig_pool_handle h;
         in_addr_t local, remote;
         char buf[256];
-        openvpn_snprintf(buf, sizeof(buf), "common-name-%d", i);
+        snprintf(buf, sizeof(buf), "common-name-%d", i);
 #ifdef DUP_CN
         cn =3D NULL;
 #else
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 5c1cdcb..ba3d87c 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -582,9 +582,9 @@
     {
         if (p->options.custom_headers[i].content)
         {
-            openvpn_snprintf(buf, sizeof(buf), "%s: %s",
-                             p->options.custom_headers[i].name,
-                             p->options.custom_headers[i].content);
+            snprintf(buf, sizeof(buf), "%s: %s",
+                     p->options.custom_headers[i].name,
+                     p->options.custom_headers[i].content);
             if (!strcasecmp(p->options.custom_headers[i].name, "Host"))
             {
                 host_header_sent =3D true;
@@ -592,8 +592,8 @@
         }
         else
         {
-            openvpn_snprintf(buf, sizeof(buf), "%s",
-                             p->options.custom_headers[i].name);
+            snprintf(buf, sizeof(buf), "%s",
+                     p->options.custom_headers[i].name);
             if (!strncasecmp(p->options.custom_headers[i].name, "Host:", 5=
))
             {
                 host_header_sent =3D true;
@@ -609,7 +609,7 @@

     if (!host_header_sent)
     {
-        openvpn_snprintf(buf, sizeof(buf), "Host: %s", host);
+        snprintf(buf, sizeof(buf), "Host: %s", host);
         msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
         if (!send_line_crlf(sd, buf))
         {
@@ -620,8 +620,8 @@
     /* send User-Agent string if provided */
     if (p->options.user_agent)
     {
-        openvpn_snprintf(buf, sizeof(buf), "User-Agent: %s",
-                         p->options.user_agent);
+        snprintf(buf, sizeof(buf), "User-Agent: %s",
+                 p->options.user_agent);
         msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
         if (!send_line_crlf(sd, buf))
         {
@@ -667,10 +667,10 @@
     else
     {
         /* format HTTP CONNECT message */
-        openvpn_snprintf(buf, sizeof(buf), "CONNECT %s:%s HTTP/%s",
-                         host,
-                         port,
-                         p->options.http_version);
+        snprintf(buf, sizeof(buf), "CONNECT %s:%s HTTP/%s",
+                 host,
+                 port,
+                 p->options.http_version);

         msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);

@@ -692,8 +692,8 @@
                 break;

             case HTTP_AUTH_BASIC:
-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Authorization: B=
asic %s",
-                                 username_password_as_base64(p, &gc));
+                snprintf(buf, sizeof(buf), "Proxy-Authorization: Basic %s",
+                         username_password_as_base64(p, &gc));
                 msg(D_PROXY, "Attempting Basic Proxy-Authorization");
                 dmsg(D_SHOW_KEYS, "Send to HTTP proxy: '%s'", buf);
                 if (!send_line_crlf(sd, buf))
@@ -705,14 +705,14 @@
 #if NTLM
             case HTTP_AUTH_NTLM2:
                 /* keep-alive connection */
-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Connection: Keep=
-Alive");
+                snprintf(buf, sizeof(buf), "Proxy-Connection: Keep-Alive");
                 if (!send_line_crlf(sd, buf))
                 {
                     goto error;
                 }

-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Authorization: N=
TLM %s",
-                                 ntlm_phase_1(p, &gc));
+                snprintf(buf, sizeof(buf), "Proxy-Authorization: NTLM %s",
+                         ntlm_phase_1(p, &gc));
                 msg(D_PROXY, "Attempting NTLM Proxy-Authorization phase 1"=
);
                 dmsg(D_SHOW_KEYS, "Send to HTTP proxy: '%s'", buf);
                 if (!send_line_crlf(sd, buf))
@@ -773,7 +773,7 @@

                 char get[80];
                 CLEAR(buf2);
-                openvpn_snprintf(get, sizeof(get), "%%*s NTLM %%%zus", siz=
eof(buf2) - 1);
+                snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2=
) - 1);
                 nparms =3D sscanf(buf, get, buf2);

                 /* check for "Proxy-Authenticate: NTLM TlRM..." */
@@ -795,10 +795,10 @@
             /* now send the phase 3 reply */

             /* format HTTP CONNECT message */
-            openvpn_snprintf(buf, sizeof(buf), "CONNECT %s:%s HTTP/%s",
-                             host,
-                             port,
-                             p->options.http_version);
+            snprintf(buf, sizeof(buf), "CONNECT %s:%s HTTP/%s",
+                     host,
+                     port,
+                     p->options.http_version);

             msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);

@@ -809,7 +809,7 @@
             }

             /* keep-alive connection */
-            openvpn_snprintf(buf, sizeof(buf), "Proxy-Connection: Keep-Ali=
ve");
+            snprintf(buf, sizeof(buf), "Proxy-Connection: Keep-Alive");
             if (!send_line_crlf(sd, buf))
             {
                 goto error;
@@ -829,7 +829,7 @@
                     msg(D_PROXY, "NTLM Proxy-Authorization phase 3 failed:=
 received corrupted data from proxy server");
                     goto error;
                 }
-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Authorization: N=
TLM %s", np3);
+                snprintf(buf, sizeof(buf), "Proxy-Authorization: NTLM %s",=
 np3);
             }

             msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
@@ -899,15 +899,15 @@


                 /* build the digest response */
-                openvpn_snprintf(uri, sizeof(uri), "%s:%s",
-                                 host,
-                                 port);
+                snprintf(uri, sizeof(uri), "%s:%s",
+                         host,
+                         port);

                 if (opaque)
                 {
                     const int len =3D strlen(opaque)+16;
                     opaque_kv =3D gc_malloc(len, false, &gc);
-                    openvpn_snprintf(opaque_kv, len, ", opaque=3D\"%s\"", =
opaque);
+                    snprintf(opaque_kv, len, ", opaque=3D\"%s\"", opaque);
                 }

                 DigestCalcHA1(algor,
@@ -928,10 +928,10 @@
                                    response);

                 /* format HTTP CONNECT message */
-                openvpn_snprintf(buf, sizeof(buf), "%s %s HTTP/%s",
-                                 http_method,
-                                 uri,
-                                 p->options.http_version);
+                snprintf(buf, sizeof(buf), "%s %s HTTP/%s",
+                         http_method,
+                         uri,
+                         p->options.http_version);

                 msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);

@@ -948,21 +948,22 @@
                 }

                 /* send digest response */
-                int sret =3D openvpn_snprintf(buf, sizeof(buf), "Proxy-Aut=
horization: Digest username=3D\"%s\", realm=3D\"%s\", nonce=3D\"%s\", uri=
=3D\"%s\", qop=3D%s, nc=3D%s, cnonce=3D\"%s\", response=3D\"%s\"%s",
-                                            username,
-                                            realm,
-                                            nonce,
-                                            uri,
-                                            qop,
-                                            nonce_count,
-                                            cnonce,
-                                            response,
-                                            opaque_kv
-                                            );
+                int sret =3D snprintf(buf, sizeof(buf), "Proxy-Authorizati=
on: Digest username=3D\"%s\", realm=3D\"%s\", nonce=3D\"%s\", uri=3D\"%s\",=
 qop=3D%s, nc=3D%s, cnonce=3D\"%s\", response=3D\"%s\"%s",
+                                    username,
+                                    realm,
+                                    nonce,
+                                    uri,
+                                    qop,
+                                    nonce_count,
+                                    cnonce,
+                                    response,
+                                    opaque_kv
+                                    );
                 if (sret >=3D sizeof(buf))
                 {
                     goto error;
                 }
+
                 msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
                 if (!send_line_crlf(sd, buf))
                 {
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 7d9f9b5..4ca3a12 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -354,7 +354,7 @@
         fnlen =3D  strlen(journal_dir) + strlen(t) + 2;
         jfn =3D (char *) malloc(fnlen);
         check_malloc_return(jfn);
-        openvpn_snprintf(jfn, fnlen, "%s/%s", journal_dir, t);
+        snprintf(jfn, fnlen, "%s/%s", journal_dir, t);
         dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: client origin %s -> %s",=
 jfn, f);
         fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | =
S_IWUSR | S_IRGRP);
         if (fd !=3D -1)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 909d6d2..68bbcfd 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1621,11 +1621,11 @@

     if (rgi)
     {
-        openvpn_snprintf(out, sizeof(out), "%s %s %s dev %s", network, net=
mask, gateway, rgi->iface);
+        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, ga=
teway, rgi->iface);
     }
     else
     {
-        openvpn_snprintf(out, sizeof(out), "%s %s %s", network, netmask, g=
ateway);
+        snprintf(out, sizeof(out), "%s %s %s", network, netmask, gateway);
     }
     bool ret =3D management_android_control(management, "ROUTE", out);
     status =3D ret ? RTA_SUCCESS : RTA_ERROR;
@@ -2000,7 +2000,7 @@
 #elif defined (TARGET_ANDROID)
     char out[64];

-    openvpn_snprintf(out, sizeof(out), "%s/%d %s", network, r6->netbits, d=
evice);
+    snprintf(out, sizeof(out), "%s/%d %s", network, r6->netbits, device);

     status =3D management_android_control(management, "ROUTE6", out);
=20
diff --git a/src/openvpn/run_command.h b/src/openvpn/run_command.h
index 52ab115..ccad307 100644
--- a/src/openvpn/run_command.h
+++ b/src/openvpn/run_command.h
@@ -66,8 +66,8 @@
 {
     char msg[256];

-    openvpn_snprintf(msg, sizeof(msg),
-                     "WARNING: Failed running command (%s)", hook);
+    snprintf(msg, sizeof(msg),
+             "WARNING: Failed running command (%s)", hook);
     return openvpn_execve_check(a, es, flags | S_SCRIPT, msg);
 }

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index d2b82d5..24d1276 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2983,11 +2983,11 @@
         case AF_INET:
             if (flags & SA_IP_PORT)
             {
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip", name=
_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
             }
             else
             {
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s", name_pr=
efix);
+                snprintf(name_buf, sizeof(name_buf), "%s", name_prefix);
             }

             inet_ntop(AF_INET, &addr->addr.in4.sin_addr, buf, sizeof(buf));
@@ -2995,7 +2995,7 @@

             if ((flags & SA_IP_PORT) && addr->addr.in4.sin_port)
             {
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s_port", na=
me_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefi=
x);
                 setenv_int(es, name_buf, ntohs(addr->addr.in4.sin_port));
             }
             break;
@@ -3006,19 +3006,19 @@
                 struct in_addr ia;
                 memcpy(&ia.s_addr, &addr->addr.in6.sin6_addr.s6_addr[12],
                        sizeof(ia.s_addr));
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip", name=
_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
                 inet_ntop(AF_INET, &ia, buf, sizeof(buf));
             }
             else
             {
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip6", nam=
e_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s_ip6", name_prefix=
);
                 inet_ntop(AF_INET6, &addr->addr.in6.sin6_addr, buf, sizeof=
(buf));
             }
             setenv_str(es, name_buf, buf);

             if ((flags & SA_IP_PORT) && addr->addr.in6.sin6_port)
             {
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s_port", na=
me_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefi=
x);
                 setenv_int(es, name_buf, ntohs(addr->addr.in6.sin6_port));
             }
             break;
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index b046910..8b8c01a 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -109,9 +109,10 @@
             "Authentication not possible.");
         goto cleanup;
     }
-    int sret =3D openvpn_snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s",
-                                (int) strlen(creds.username), creds.userna=
me,
-                                (int) strlen(creds.password), creds.passwo=
rd);
+
+    int sret =3D snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s",
+                        (int) strlen(creds.username), creds.username,
+                        (int) strlen(creds.password), creds.password);
     ASSERT(sret <=3D sizeof(to_send));

     size =3D send(sd, to_send, strlen(to_send), MSG_NOSIGNAL);
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 0730d25..b0303b6 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1531,16 +1531,16 @@
     char s2[256];

     s1[0] =3D s2[0] =3D 0;
-    openvpn_snprintf(s1, sizeof(s1), "%s %s, cipher %s",
-                     prefix,
-                     mbedtls_ssl_get_version(ks_ssl->ctx),
-                     mbedtls_ssl_get_ciphersuite(ks_ssl->ctx));
+    snprintf(s1, sizeof(s1), "%s %s, cipher %s",
+             prefix,
+             mbedtls_ssl_get_version(ks_ssl->ctx),
+             mbedtls_ssl_get_ciphersuite(ks_ssl->ctx));

     cert =3D mbedtls_ssl_get_peer_cert(ks_ssl->ctx);
     if (cert !=3D NULL)
     {
-        openvpn_snprintf(s2, sizeof(s2), ", %u bit key",
-                         (unsigned int) mbedtls_pk_get_bitlen(&cert->pk));
+        snprintf(s2, sizeof(s2), ", %u bit key",
+                 (unsigned int) mbedtls_pk_get_bitlen(&cert->pk));
     }

     msg(D_HANDSHAKE, "%s%s", s1, s2);
diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c
index 73ec9f5..968858e 100644
--- a/src/openvpn/ssl_ncp.c
+++ b/src/openvpn/ssl_ncp.c
@@ -198,8 +198,8 @@
     size_t newlen =3D strlen(o->ncp_ciphers) + 1 + strlen(ciphername) + 1;
     char *ncp_ciphers =3D gc_malloc(newlen, false, &o->gc);

-    ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
-                            ciphername));
+    ASSERT(snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
+                    ciphername));
     o->ncp_ciphers =3D ncp_ciphers;
 }

diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index a158617..6efef4f 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1774,7 +1774,7 @@
     if (!biofp)
     {
         char fn[256];
-        openvpn_snprintf(fn, sizeof(fn), "bio/%d-%d.log", pid, biofp_toggl=
e);
+        snprintf(fn, sizeof(fn), "bio/%d-%d.log", pid, biofp_toggle);
         biofp =3D fopen(fn, "w");
         ASSERT(biofp);
         biofp_last_open =3D time(NULL);
@@ -2116,8 +2116,8 @@
 #endif /* if OPENSSL_VERSION_NUMBER < 0x30000000L */
     }

-    openvpn_snprintf(buf, buflen, "%d bits %s%s",
-                     EVP_PKEY_bits(pkey), type, curve);
+    snprintf(buf, buflen, "%d bits %s%s",
+             EVP_PKEY_bits(pkey), type, curve);
 }

 /**
@@ -2137,12 +2137,12 @@
     int signature_nid =3D X509_get_signature_nid(cert);
     if (signature_nid !=3D 0)
     {
-        openvpn_snprintf(sig, sizeof(sig), ", signature: %s",
-                         OBJ_nid2sn(signature_nid));
+        snprintf(sig, sizeof(sig), ", signature: %s",
+                 OBJ_nid2sn(signature_nid));
     }

-    openvpn_snprintf(buf, buflen, ", peer certificate: %s%s",
-                     pkeybuf, sig);
+    snprintf(buf, buflen, ", peer certificate: %s%s",
+             pkeybuf, sig);

     EVP_PKEY_free(pkey);
 }
@@ -2160,8 +2160,8 @@
     char pkeybuf[128] =3D { 0 };
     print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));

-    openvpn_snprintf(buf, buflen, ", peer temporary key: %s",
-                     pkeybuf);
+    snprintf(buf, buflen, ", peer temporary key: %s",
+             pkeybuf);

     EVP_PKEY_free(pkey);
 }
@@ -2238,8 +2238,8 @@
         return;
     }

-    openvpn_snprintf(buf, buflen, ", peer signing digest/type: %s %s",
-                     peer_sig, peer_sig_type);
+    snprintf(buf, buflen, ", peer signing digest/type: %s %s",
+             peer_sig, peer_sig_type);
 }


@@ -2262,11 +2262,11 @@

     s1[0] =3D s2[0] =3D s3[0] =3D s4[0] =3D 0;
     ciph =3D SSL_get_current_cipher(ks_ssl->ssl);
-    openvpn_snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
-                     prefix,
-                     SSL_get_version(ks_ssl->ssl),
-                     SSL_CIPHER_get_version(ciph),
-                     SSL_CIPHER_get_name(ciph));
+    snprintf(s1, sizeof(s1), "%s %s, cipher %s %s",
+             prefix,
+             SSL_get_version(ks_ssl->ssl),
+             SSL_CIPHER_get_version(ciph),
+             SSL_CIPHER_get_name(ciph));
     X509 *cert =3D SSL_get_peer_certificate(ks_ssl->ssl);

     if (cert)
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index 930769b..934ff8d 100644
--- a/src/openvpn/ssl_verify.c
+++ b/src/openvpn/ssl_verify.c
@@ -421,12 +421,12 @@
     }

     /* export subject name string as environmental variable */
-    openvpn_snprintf(envname, sizeof(envname), "tls_id_%d", cert_depth);
+    snprintf(envname, sizeof(envname), "tls_id_%d", cert_depth);
     setenv_str(es, envname, subject);

 #if 0
     /* export common name string as environmental variable */
-    openvpn_snprintf(envname, sizeof(envname), "tls_common_name_%d", cert_=
depth);
+    snprintf(envname, sizeof(envname), "tls_common_name_%d", cert_depth);
     setenv_str(es, envname, common_name);
 #endif

@@ -435,24 +435,24 @@
         struct buffer sha1 =3D x509_get_sha1_fingerprint(peer_cert, &gc);
         struct buffer sha256 =3D x509_get_sha256_fingerprint(peer_cert, &g=
c);

-        openvpn_snprintf(envname, sizeof(envname), "tls_digest_%d", cert_d=
epth);
+        snprintf(envname, sizeof(envname), "tls_digest_%d", cert_depth);
         setenv_str(es, envname,
                    format_hex_ex(BPTR(&sha1), BLEN(&sha1), 0, 1, ":", &gc)=
);

-        openvpn_snprintf(envname, sizeof(envname), "tls_digest_sha256_%d",
-                         cert_depth);
+        snprintf(envname, sizeof(envname), "tls_digest_sha256_%d",
+                 cert_depth);
         setenv_str(es, envname,
                    format_hex_ex(BPTR(&sha256), BLEN(&sha256), 0, 1, ":", =
&gc));
     }

     /* export serial number as environmental variable */
     serial =3D backend_x509_get_serial(peer_cert, &gc);
-    openvpn_snprintf(envname, sizeof(envname), "tls_serial_%d", cert_depth=
);
+    snprintf(envname, sizeof(envname), "tls_serial_%d", cert_depth);
     setenv_str(es, envname, serial);

     /* export serial number in hex as environmental variable */
     serial =3D backend_x509_get_serial_hex(peer_cert, &gc);
-    openvpn_snprintf(envname, sizeof(envname), "tls_serial_hex_%d", cert_d=
epth);
+    snprintf(envname, sizeof(envname), "tls_serial_hex_%d", cert_depth);
     setenv_str(es, envname, serial);

     gc_free(&gc);
@@ -569,7 +569,7 @@
         goto cleanup;
     }

-    if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATO=
R, serial))
+    if (!snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, seria=
l))
     {
         msg(D_HANDSHAKE, "VERIFY CRL: filename overflow");
         goto cleanup;
@@ -938,9 +938,9 @@
             if (!check_auth_pending_method(multi->peer_info, pending_metho=
d))
             {
                 char buf[128];
-                openvpn_snprintf(buf, sizeof(buf),
-                                 "Authentication failed, required pending =
auth "
-                                 "method '%s' not supported", pending_meth=
od);
+                snprintf(buf, sizeof(buf),
+                         "Authentication failed, required pending auth "
+                         "method '%s' not supported", pending_method);
                 auth_set_client_reason(multi, buf);
                 msg(M_INFO, "Client does not supported auth pending method=
 "
                     "'%s'", pending_method);
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbed=
tls.c
index a801cd3..ca14ceb 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -86,8 +86,8 @@
         char *serial =3D backend_x509_get_serial(cert, &gc);

         ret =3D mbedtls_x509_crt_verify_info(errstr, sizeof(errstr)-1, "",=
 *flags);
-        if (ret <=3D 0 && !openvpn_snprintf(errstr, sizeof(errstr),
-                                          "Could not retrieve error string=
, flags=3D%" PRIx32, *flags))
+        if (ret <=3D 0 && !snprintf(errstr, sizeof(errstr),
+                                  "Could not retrieve error string, flags=
=3D%" PRIx32, *flags))
         {
             errstr[0] =3D '\0';
         }
@@ -307,7 +307,7 @@
     name_expand_size =3D 64 + strlen(name);
     name_expand =3D (char *) malloc(name_expand_size);
     check_malloc_return(name_expand);
-    openvpn_snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, n=
ame);
+    snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, name);
     setenv_str(es, name_expand, value);
     free(name_expand);
 }
@@ -431,13 +431,13 @@

         if (0 =3D=3D mbedtls_oid_get_attr_short_name(&name->oid, &shortnam=
e) )
         {
-            openvpn_snprintf(name_expand, sizeof(name_expand), "X509_%d_%s=
",
-                             cert_depth, shortname);
+            snprintf(name_expand, sizeof(name_expand), "X509_%d_%s",
+                     cert_depth, shortname);
         }
         else
         {
-            openvpn_snprintf(name_expand, sizeof(name_expand), "X509_%d_\?=
\?",
-                             cert_depth);
+            snprintf(name_expand, sizeof(name_expand), "X509_%d_\?\?",
+                     cert_depth);
         }

         for (i =3D 0; i < name->val.len; i++)
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_open=
ssl.c
index ec3a7cf..7d41d4a 100644
--- a/src/openvpn/ssl_verify_openssl.c
+++ b/src/openvpn/ssl_verify_openssl.c
@@ -279,7 +279,7 @@
             gc_free(&gc);
             return FAILURE;
         }
-        openvpn_snprintf(common_name, cn_len, "0x%s", serial);
+        snprintf(common_name, cn_len, "0x%s", serial);
         gc_free(&gc);
     }
     else
@@ -454,7 +454,7 @@
     name_expand_size =3D 64 + strlen(name);
     name_expand =3D (char *) malloc(name_expand_size);
     check_malloc_return(name_expand);
-    openvpn_snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, n=
ame);
+    snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, name);
     setenv_str(es, name_expand, value);
     free(name_expand);
 }
@@ -597,8 +597,8 @@
         name_expand_size =3D 64 + strlen(objbuf);
         name_expand =3D (char *) malloc(name_expand_size);
         check_malloc_return(name_expand);
-        openvpn_snprintf(name_expand, name_expand_size, "X509_%d_%s", cert=
_depth,
-                         objbuf);
+        snprintf(name_expand, name_expand_size, "X509_%d_%s", cert_depth,
+                 objbuf);
         string_mod(name_expand, CC_PRINT, CC_CRLF, '_');
         string_mod((char *)buf, CC_PRINT, CC_CRLF, '_');
         setenv_str_incr(es, name_expand, (char *)buf);
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 6ef1c7d..90fe6e9 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -574,8 +574,8 @@
     }

     char metadata_type_str[4] =3D { 0 }; /* Max value: 255 */
-    openvpn_snprintf(metadata_type_str, sizeof(metadata_type_str),
-                     "%i", (uint8_t) metadata_type);
+    snprintf(metadata_type_str, sizeof(metadata_type_str),
+             "%i", (uint8_t) metadata_type);
     struct env_set *es =3D env_set_create(NULL);
     setenv_str(es, "script_type", "tls-crypt-v2-verify");
     setenv_str(es, "metadata_type", metadata_type_str);
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f550e9c..d01515d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1114,8 +1114,8 @@
 #elif defined(TARGET_ANDROID)
     char out6[64];

-    openvpn_snprintf(out6, sizeof(out6), "%s/%d %d",
-                     ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
+    snprintf(out6, sizeof(out6), "%s/%d %d",
+             ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);
     management_android_control(management, "IFCONFIG6", out6);
 #elif defined(TARGET_SOLARIS)
     argv_printf(&argv, "%s %s inet6 unplumb", IFCONFIG_PATH, ifname);
@@ -1362,8 +1362,8 @@
             top =3D "undef";
     }

-    openvpn_snprintf(out, sizeof(out), "%s %s %d %s", ifconfig_local,
-                     ifconfig_remote_netmask, tun_mtu, top);
+    snprintf(out, sizeof(out), "%s %s %d %s", ifconfig_local,
+             ifconfig_remote_netmask, tun_mtu, top);
     management_android_control(management, "IFCONFIG", out);

 #elif defined(TARGET_SOLARIS)
@@ -1912,7 +1912,7 @@
          */
         if (dev_node)
         {
-            openvpn_snprintf(tunname, sizeof(tunname), "%s", dev_node);
+            snprintf(tunname, sizeof(tunname), "%s", dev_node);
         }
         else
         {
@@ -1926,10 +1926,10 @@
             {
                 for (int i =3D 0; i < 256; ++i)
                 {
-                    openvpn_snprintf(tunname, sizeof(tunname),
-                                     "/dev/%s%d", dev, i);
-                    openvpn_snprintf(dynamic_name, sizeof(dynamic_name),
-                                     "%s%d", dev, i);
+                    snprintf(tunname, sizeof(tunname),
+                             "/dev/%s%d", dev, i);
+                    snprintf(dynamic_name, sizeof(dynamic_name),
+                             "%s%d", dev, i);
                     if ((tt->fd =3D open(tunname, O_RDWR)) > 0)
                     {
                         dynamic_opened =3D true;
@@ -1947,7 +1947,7 @@
              */
             else
             {
-                openvpn_snprintf(tunname, sizeof(tunname), "/dev/%s", dev);
+                snprintf(tunname, sizeof(tunname), "/dev/%s", dev);
             }
         }

@@ -2002,8 +2002,8 @@
     {
         for (int i =3D 0; i < 256; ++i)
         {
-            openvpn_snprintf(dynamic_name, sizeof(dynamic_name),
-                             "%s%d", dev, i);
+            snprintf(dynamic_name, sizeof(dynamic_name),
+                     "%s%d", dev, i);
             int ret =3D open_tun_dco(tt, ctx, dynamic_name);
             if (ret =3D=3D 0)
             {
@@ -2519,7 +2519,7 @@
     tt->actual_name =3D (char *) malloc(32);
     check_malloc_return(tt->actual_name);

-    openvpn_snprintf(tt->actual_name, 32, "%s%d", dev_tuntap_type, ppa);
+    snprintf(tt->actual_name, 32, "%s%d", dev_tuntap_type, ppa);

     if (tt->type =3D=3D DEV_TYPE_TAP)
     {
@@ -3509,7 +3509,7 @@
         int i;
         for (i =3D 0; i<99; i++)
         {
-            openvpn_snprintf(tunname, sizeof(tunname), "/dev/tap%d", i);
+            snprintf(tunname, sizeof(tunname), "/dev/tap%d", i);
             if (access( tunname, F_OK ) < 0 && errno =3D=3D ENOENT)
             {
                 break;
@@ -3520,7 +3520,7 @@
             msg( M_FATAL, "cannot find unused tap device" );
         }

-        openvpn_snprintf( dynamic_name, sizeof(dynamic_name), "tap%d", i );
+        snprintf( dynamic_name, sizeof(dynamic_name), "tap%d", i );
         dev =3D dynamic_name;
     }
     else                                        /* name given, sanity chec=
k */
@@ -3536,7 +3536,7 @@
             msg( M_FATAL, "TAP device name must be '--dev tapNNNN'" );
         }

-        openvpn_snprintf(tunname, sizeof(tunname), "/dev/%s", dev);
+        snprintf(tunname, sizeof(tunname), "/dev/%s", dev);
     }

     /* pre-existing device?
@@ -3956,8 +3956,8 @@
                 ADAPTER_KEY);
         }

-        openvpn_snprintf(unit_string, sizeof(unit_string), "%s\\%s",
-                         ADAPTER_KEY, enum_name);
+        snprintf(unit_string, sizeof(unit_string), "%s\\%s",
+                 ADAPTER_KEY, enum_name);

         status =3D RegOpenKeyEx(
             HKEY_LOCAL_MACHINE,
@@ -4098,9 +4098,9 @@
                 NETWORK_CONNECTIONS_KEY);
         }

-        openvpn_snprintf(connection_string, sizeof(connection_string),
-                         "%s\\%s\\Connection",
-                         NETWORK_CONNECTIONS_KEY, enum_name);
+        snprintf(connection_string, sizeof(connection_string),
+                 "%s\\%s\\Connection",
+                 NETWORK_CONNECTIONS_KEY, enum_name);

         status =3D RegOpenKeyEx(
             HKEY_LOCAL_MACHINE,
@@ -4984,7 +4984,7 @@
     DWORD index;
     ULONG aindex;
     wchar_t wbuf[256];
-    openvpn_swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%hs", guid);
+    swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%hs", guid);
     if (GetAdapterIndex(wbuf, &aindex) !=3D NO_ERROR)
     {
         index =3D TUN_ADAPTER_INDEX_INVALID;
@@ -5164,10 +5164,10 @@
         }

         /* Open Windows TAP-Windows adapter */
-        openvpn_snprintf(device_path, sizeof(device_path), "%s%s%s",
-                         USERMODEDEVICEDIR,
-                         device_guid,
-                         TAP_WIN_SUFFIX);
+        snprintf(device_path, sizeof(device_path), "%s%s%s",
+                 USERMODEDEVICEDIR,
+                 device_guid,
+                 TAP_WIN_SUFFIX);

         hand =3D CreateFile(
             device_path,
@@ -5208,10 +5208,10 @@
             }

             /* Open Windows TAP-Windows adapter */
-            openvpn_snprintf(device_path, sizeof(device_path), "%s%s%s",
-                             USERMODEDEVICEDIR,
-                             device_guid,
-                             TAP_WIN_SUFFIX);
+            snprintf(device_path, sizeof(device_path), "%s%s%s",
+                     USERMODEDEVICEDIR,
+                     device_guid,
+                     TAP_WIN_SUFFIX);

             hand =3D CreateFile(
                 device_path,
@@ -6607,10 +6607,10 @@
     else
     {
         /* Open TAP-Windows */
-        openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "=
%s%s%s",
-                         USERMODEDEVICEDIR,
-                         device_guid,
-                         TAP_WIN_SUFFIX);
+        snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
+                 USERMODEDEVICEDIR,
+                 device_guid,
+                 TAP_WIN_SUFFIX);
         path =3D tuntap_device_path;
     }

diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 27d82c5..98955ba 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -885,8 +885,8 @@
     char force_path[256];
     char *sysroot =3D get_win_sys_path();

-    if (!openvpn_snprintf(force_path, sizeof(force_path), "PATH=3D%s\\Syst=
em32;%s;%s\\System32\\Wbem",
-                          sysroot, sysroot, sysroot))
+    if (!snprintf(force_path, sizeof(force_path), "PATH=3D%s\\System32;%s;=
%s\\System32\\Wbem",
+                  sysroot, sysroot, sysroot))
     {
         msg(M_WARN, "env_block: default path truncated to %s", force_path);
     }
@@ -1483,26 +1483,11 @@
 }

 bool
-openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *con=
st format, ...)
-{
-    va_list arglist;
-    int len =3D -1;
-    if (size > 0)
-    {
-        va_start(arglist, format);
-        len =3D vswprintf(str, size, format, arglist);
-        va_end(arglist);
-        str[size - 1] =3D L'\0';
-    }
-    return (len >=3D 0 && len < size);
-}
-
-bool
 get_openvpn_reg_value(const WCHAR *key, WCHAR *value, DWORD size)
 {
     WCHAR reg_path[256];
     HKEY hkey;
-    openvpn_swprintf(reg_path, _countof(reg_path), L"SOFTWARE\\" PACKAGE_N=
AME);
+    swprintf(reg_path, _countof(reg_path), L"SOFTWARE\\" PACKAGE_NAME);

     LONG status =3D RegOpenKeyExW(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_REA=
D, &hkey);
     if (status !=3D ERROR_SUCCESS)
@@ -1528,7 +1513,7 @@
         /* if we cannot find installation path from the registry,
          * use Windows directory as a fallback
          */
-        openvpn_swprintf(install_path, _countof(install_path), L"%ls", ssl=
_fallback_dir);
+        swprintf(install_path, _countof(install_path), L"%ls", ssl_fallbac=
k_dir);
     }

     if ((install_path[wcslen(install_path) - 1]) =3D=3D L'\\')
@@ -1553,7 +1538,7 @@
         if (size =3D=3D 0)
         {
             WCHAR val[MAX_PATH] =3D {0};
-            openvpn_swprintf(val, _countof(val), L"%ls\\ssl\\%ls", install=
_path, ossl_env[i].value);
+            swprintf(val, _countof(val), L"%ls\\ssl\\%ls", install_path, o=
ssl_env[i].value);
             _wputenv_s(ossl_env[i].name, val);
         }
     }
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 974fe02d..fd75992 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -319,14 +319,6 @@
 int
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsig=
ned int flags);

-/*
- * openvpn_swprintf() is currently only used by Windows code paths
- * and when enabled for all platforms it will currently break older
- * OpenBSD versions lacking vswprintf(3) support in their libc.
- */
-bool
-openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *con=
st format, ...);
-
 /* Sleep that can be interrupted by signals and exit event */
 void win32_sleep(const int n);

diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_helper.c
index c803323..283c95d 100644
--- a/src/openvpn/xkey_helper.c
+++ b/src/openvpn/xkey_helper.c
@@ -205,7 +205,7 @@
         }
         else
         {
-            openvpn_snprintf(alg_str, sizeof(alg_str), "ECDSA,hashalg=3D%s=
", alg.mdname);
+            snprintf(alg_str, sizeof(alg_str), "ECDSA,hashalg=3D%s", alg.m=
dname);
         }
     }
     else if (!strcmp(alg.keytype, "ED448") || !strcmp(alg.keytype, "ED2551=
9"))
@@ -229,8 +229,8 @@
         /* For undigested message, add hashalg=3Ddigest parameter */
         else
         {
-            openvpn_snprintf(alg_str, sizeof(alg_str), "%s,hashalg=3D%s",
-                             "RSA_PKCS1_PADDING", alg.mdname);
+            snprintf(alg_str, sizeof(alg_str), "%s,hashalg=3D%s",
+                     "RSA_PKCS1_PADDING", alg.mdname);
         }
     }
     else if (!strcmp(alg.padmode, "none") && (flags & MF_EXTERNAL_KEY_NOPA=
DDING)
@@ -240,8 +240,8 @@
     }
     else if (!strcmp(alg.padmode, "pss") && (flags & MF_EXTERNAL_KEY_PSSPA=
D))
     {
-        openvpn_snprintf(alg_str, sizeof(alg_str), "%s,hashalg=3D%s,saltle=
n=3D%s",
-                         "RSA_PKCS1_PSS_PADDING", alg.mdname, alg.saltlen);
+        snprintf(alg_str, sizeof(alg_str), "%s,hashalg=3D%s,saltlen=3D%s",
+                 "RSA_PKCS1_PSS_PADDING", alg.mdname, alg.saltlen);
     }
     else
     {
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index bd0a484..96bf800 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -27,36 +27,6 @@
 LPCTSTR service_instance =3D TEXT("");
 static wchar_t win_sys_path[MAX_PATH];

-/*
- * These are necessary due to certain buggy implementations of (v)snprintf,
- * that don't guarantee null termination for size > 0.
- */
-BOOL
-openvpn_vswprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist)
-{
-    int len =3D -1;
-    if (size > 0)
-    {
-        len =3D vswprintf_s(str, size, format, arglist);
-        str[size - 1] =3D 0;
-    }
-    return (len >=3D 0 && (size_t)len < size);
-}
-
-BOOL
-openvpn_swprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
-{
-    va_list arglist;
-    BOOL res =3D FALSE;
-    if (size > 0)
-    {
-        va_start(arglist, format);
-        res =3D openvpn_vswprintf(str, size, format, arglist);
-        va_end(arglist);
-    }
-    return res;
-}
-
 static DWORD
 GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR def=
ault_value)
 {
@@ -66,7 +36,7 @@
     if (status =3D=3D ERROR_FILE_NOT_FOUND && default_value)
     {
         size_t len =3D size/sizeof(data[0]);
-        if (openvpn_swprintf(data, len, default_value))
+        if (swprintf(data, len, default_value))
         {
             status =3D ERROR_SUCCESS;
         }
@@ -93,7 +63,7 @@
     TCHAR install_path[MAX_PATH];
     TCHAR default_value[MAX_PATH];
=20
-    openvpn_swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKA=
GE_NAME "%ls"), service_instance);
+    swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKAGE_NAME =
"%ls"), service_instance);

     LONG status =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ=
, &key);
     if (status !=3D ERROR_SUCCESS)
@@ -110,15 +80,15 @@
         goto out;
     }

-    openvpn_swprintf(default_value, _countof(default_value), TEXT("%ls\\bi=
n\\openvpn.exe"),
-                     install_path);
+    swprintf(default_value, _countof(default_value), TEXT("%ls\\bin\\openv=
pn.exe"),
+             install_path);
     error =3D GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->e=
xe_path), default_value);
     if (error !=3D ERROR_SUCCESS)
     {
         goto out;
     }

-    openvpn_swprintf(default_value, _countof(default_value), TEXT("%ls\\co=
nfig"), install_path);
+    swprintf(default_value, _countof(default_value), TEXT("%ls\\config"), =
install_path);
     error =3D GetRegString(key, TEXT("config_dir"), s->config_dir, sizeof(=
s->config_dir),
                          default_value);
     if (error !=3D ERROR_SUCCESS)
@@ -133,7 +103,7 @@
         goto out;
     }

-    openvpn_swprintf(default_value, _countof(default_value), TEXT("%ls\\lo=
g"), install_path);
+    swprintf(default_value, _countof(default_value), TEXT("%ls\\log"), ins=
tall_path);
     error =3D GetRegString(key, TEXT("log_dir"), s->log_dir, sizeof(s->log=
_dir), default_value);
     if (error !=3D ERROR_SUCCESS)
     {
@@ -229,7 +199,7 @@
     else
     {
         tmp[wcslen(tmp) - 2] =3D TEXT('\0'); /* remove CR/LF characters */
-        openvpn_swprintf(buf, _countof(buf), TEXT("%ls (0x%x)"), tmp, erro=
r);
+        swprintf(buf, _countof(buf), TEXT("%ls (0x%x)"), tmp, error);
     }

     if (tmp)
@@ -259,12 +229,12 @@
     hEventSource =3D RegisterEventSource(NULL, APPNAME);
     if (hEventSource !=3D NULL)
     {
-        openvpn_swprintf(msg[0], _countof(msg[0]),
-                         TEXT("%ls%ls%ls: %ls"), APPNAME, service_instance,
-                         (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT=
(""), err_msg);
+        swprintf(msg[0], _countof(msg[0]),
+                 TEXT("%ls%ls%ls: %ls"), APPNAME, service_instance,
+                 (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT(""), er=
r_msg);

         va_start(arglist, format);
-        openvpn_vswprintf(msg[1], _countof(msg[1]), format, arglist);
+        vswprintf(msg[1], _countof(msg[1]), format, arglist);
         va_end(arglist);

         const TCHAR *mesg[] =3D { msg[0], msg[1] };
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index d32223c..294db00 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -311,7 +311,7 @@
      * Same format as error messages (3 line string) with error =3D 0 in
      * 0x%08x format, PID on line 2 and a description "Process ID" on line=
 3
      */
-    openvpn_swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%ls", 0, pid, m=
sg);
+    swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%ls", 0, pid, msg);

     WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);
 }
@@ -385,9 +385,9 @@

     if (!argv)
     {
-        openvpn_swprintf(errmsg, capacity,
-                         L"Cannot validate options: CommandLineToArgvW fai=
led with error =3D 0x%08x",
-                         GetLastError());
+        swprintf(errmsg, capacity,
+                 L"Cannot validate options: CommandLineToArgvW failed with=
 error =3D 0x%08x",
+                 GetLastError());
         goto out;
     }

@@ -407,8 +407,8 @@

         if (!CheckOption(workdir, 2, argv_tmp, &settings))
         {
-            openvpn_swprintf(errmsg, capacity, msg1, argv[0], workdir,
-                             settings.ovpn_admin_group);
+            swprintf(errmsg, capacity, msg1, argv[0], workdir,
+                     settings.ovpn_admin_group);
         }
         goto out;
     }
@@ -424,13 +424,13 @@
         {
             if (wcscmp(L"--config", argv[i]) =3D=3D 0 && argc-i > 1)
             {
-                openvpn_swprintf(errmsg, capacity, msg1, argv[i+1], workdi=
r,
-                                 settings.ovpn_admin_group);
+                swprintf(errmsg, capacity, msg1, argv[i+1], workdir,
+                         settings.ovpn_admin_group);
             }
             else
             {
-                openvpn_swprintf(errmsg, capacity, msg2, argv[i],
-                                 settings.ovpn_admin_group);
+                swprintf(errmsg, capacity, msg2, argv[i],
+                         settings.ovpn_admin_group);
             }
             goto out;
         }
@@ -985,7 +985,7 @@

     HANDLE wait_handles[2] =3D {rdns_semaphore, exit_event};

-    openvpn_swprintf(ipcfg, MAX_PATH, L"%ls\\%ls", get_win_sys_path(), L"i=
pconfig.exe");
+    swprintf(ipcfg, MAX_PATH, L"%ls\\%ls", get_win_sys_path(), L"ipconfig.=
exe");

     if (WaitForMultipleObjects(2, wait_handles, FALSE, timeout) =3D=3D WAI=
T_OBJECT_0)
     {
@@ -1064,7 +1064,7 @@
     }

     /* Path of netsh */
-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path=
(), L"netsh.exe");
+    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"ne=
tsh.exe");

     /* cmd template:
      * netsh interface $proto $action dns $if_name $addr [validate=3Dno]
@@ -1080,7 +1080,7 @@
         goto out;
     }

-    openvpn_swprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);
+    swprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);

     if (IsWindows7OrGreater())
     {
@@ -1124,7 +1124,7 @@
     }

     /* Path of netsh */
-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path=
(), L"netsh.exe");
+    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"ne=
tsh.exe");

     /* cmd template:
      * netsh interface ip $action wins $if_name $static $addr
@@ -1141,7 +1141,7 @@
         goto out;
     }

-    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static,=
 addr);
+    swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static, addr);

     err =3D ExecCommand(argv0, cmdline, timeout);

@@ -1167,7 +1167,7 @@
     wchar_t *cmdline =3D NULL;
     int timeout =3D 10000; /* in msec */

-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path=
(), L"wbem\\wmic.exe");
+    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"wb=
em\\wmic.exe");

     const wchar_t *fmt;
     /* comma separated list must be enclosed in parenthesis */
@@ -1188,8 +1188,8 @@
         return ERROR_OUTOFMEMORY;
     }

-    openvpn_swprintf(cmdline, ncmdline, fmt, if_index, action,
-                     data ? data : L"");
+    swprintf(cmdline, ncmdline, fmt, if_index, action,
+             data ? data : L"");
     err =3D ExecCommand(argv0, cmdline, timeout);

     free(cmdline);
@@ -1453,7 +1453,7 @@
     wchar_t argv0[MAX_PATH];

     /* Path of netsh */
-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path=
(), L"netsh.exe");
+    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"ne=
tsh.exe");

     /* cmd template:
      * netsh interface ipv4 set address name=3D$if_index source=3Ddhcp
@@ -1471,7 +1471,7 @@
         return err;
     }

-    openvpn_swprintf(cmdline, ncmdline, fmt, dhcp->iface.index);
+    swprintf(cmdline, ncmdline, fmt, dhcp->iface.index);

     err =3D ExecCommand(argv0, cmdline, timeout);
=20
@@ -1970,8 +1970,8 @@
         goto out;
     }

-    openvpn_swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
-                     TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), ser=
vice_instance, GetCurrentThreadId());
+    swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
+             TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), service_ins=
tance, GetCurrentThreadId());
     ovpn_pipe =3D CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_=
INSTANCE | FILE_FLAG_OVERLAPPED,
                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE =
| PIPE_WAIT, 1, 128, 128, 0, NULL);
@@ -2003,8 +2003,11 @@
         ReturnLastError(pipe, L"malloc");
         goto out;
     }
-    openvpn_swprintf(cmdline, cmdline_size, L"openvpn %ls --msg-channel %"=
 PRIuPTR,
-                     sud.options, svc_pipe);
+    /* there seem to be no common printf specifier that works on all
+     * mingw/msvc platforms without trickery, so convert to void* and use
+     * PRIuPTR to print that as best compromise */
+    swprintf(cmdline, cmdline_size, L"openvpn %ls --msg-channel %" PRIuPTR,
+             sud.options, (uintptr_t)svc_pipe);

     if (!CreateEnvironmentBlock(&user_env, imp_token, FALSE))
     {
@@ -2079,8 +2082,8 @@
     else if (exit_code !=3D 0)
     {
         WCHAR buf[256];
-        openvpn_swprintf(buf, _countof(buf),
-                         L"OpenVPN exited with error: exit code =3D %lu", =
exit_code);
+        swprintf(buf, _countof(buf),
+                 L"OpenVPN exited with error: exit code =3D %lu", exit_cod=
e);
         ReturnError(pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
     }
     Undo(&undo_lists);
@@ -2174,7 +2177,7 @@
         initialized =3D TRUE;
     }

-    openvpn_swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" =
PACKAGE "%ls\\service"), service_instance);
+    swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE =
"%ls\\service"), service_instance);
     pipe =3D CreateNamedPipe(pipe_name, flags,
                            PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIP=
E_REJECT_REMOTE_CLIENTS,
                            PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, NULL);
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 3acf08c..6d0827d 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -81,12 +81,6 @@

 VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);

-BOOL openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list a=
rglist);
-
-BOOL openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);
-
-BOOL openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t=
 *const format, ...);
-
 DWORD GetOpenvpnSettings(settings_t *s);

 BOOL ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *st=
atus);
diff --git a/src/openvpnserv/validate.c b/src/openvpnserv/validate.c
index 5f7acd7..9563fa5 100644
--- a/src/openvpnserv/validate.c
+++ b/src/openvpnserv/validate.c
@@ -68,7 +68,7 @@
     /* convert fname to full path */
     if (PathIsRelativeW(fname) )
     {
-        openvpn_swprintf(tmp, _countof(tmp), L"%ls\\%ls", workdir, fname);
+        swprintf(tmp, _countof(tmp), L"%ls\\%ls", workdir, fname);
         config_file =3D tmp;
     }
     else
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 52ffb54..fbfb937 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -354,6 +354,56 @@
     assert_string_equal(buf, "There is a .'nice.' \"1234\" [.] year old .t=
ree!");
 }

+static void
+test_snprintf(void **state)
+{
+    /* we used to have a custom openvpn_snprintf function because some
+     * OS (the comment did not specify which) did not always put the
+     * null byte there. So we unit test this to be sure.
+     *
+     * This probably refers to the MSVC behaviour, see also
+     * https://stackoverflow.com/questions/7706936/is-snprintf-always-null=
-terminating
+     */
+
+    /* Instead of trying to trick the compiler here, disable the warnings
+     * for this unit test. We know that the results will be truncated
+     * and we want to test that */
+#if defined(__GNUC__)
+/* some clang version do not understand -Wformat-truncation, so ignore the
+ * warning to avoid warnings/errors (-Werror) about unknown pragma/option =
*/
+#if defined(__clang__)
+#pragma clang diagnostic push
+#pragma clang diagnostic ignored "-Wunknown-warning-option"
+#endif
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wformat-truncation"
+#endif
+
+    char buf[10] =3D { 'a' };
+    int ret =3D 0;
+
+    ret =3D snprintf(buf, sizeof(buf), "0123456789abcde");
+    assert_int_equal(ret, 15);
+    assert_int_equal(buf[9], '\0');
+
+    memset(buf, 'b', sizeof(buf));
+    ret =3D snprintf(buf, sizeof(buf), "- %d - %d -", 77, 88);
+    assert_int_equal(ret, 11);
+    assert_int_equal(buf[9], '\0');
+
+    memset(buf, 'c', sizeof(buf));
+    ret =3D snprintf(buf, sizeof(buf), "- %8.2f", 77.8899);
+    assert_int_equal(ret, 10);
+    assert_int_equal(buf[9], '\0');
+
+#if defined(__GNUC__)
+#pragma GCC diagnostic pop
+#if defined(__clang__)
+#pragma clang diagnostic pop
+#endif
+#endif
+}
+
 int
 main(void)
 {
@@ -387,6 +437,7 @@
         cmocka_unit_test(test_buffer_free_gc_two),
         cmocka_unit_test(test_buffer_gc_realloc),
         cmocka_unit_test(test_character_class),
+        cmocka_unit_test(test_snprintf)
     };

     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/o=
penvpn/test_cryptoapi.c
index 87f6208..98102ef 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -271,7 +271,7 @@

     for (struct test_cert *c =3D certs; c->cert; c++)
     {
-        openvpn_snprintf(select_string, sizeof(select_string), "THUMB:%s",=
 c->hash);
+        snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash=
);
         ctx =3D find_certificate_in_store(select_string, user_store);
         if (ctx)
         {
@@ -304,7 +304,7 @@

     for (struct test_cert *c =3D certs; c->cert; c++)
     {
-        openvpn_snprintf(select_string, sizeof(select_string), "SUBJ:%s", =
c->cname);
+        snprintf(select_string, sizeof(select_string), "SUBJ:%s", c->cname=
);
         ctx =3D find_certificate_in_store(select_string, user_store);
         /* In this case we expect a successful return as there is at least=
 one valid
          * cert that matches the common name. But the returned cert may no=
t exactly match
@@ -337,7 +337,7 @@

     for (struct test_cert *c =3D certs; c->cert; c++)
     {
-        openvpn_snprintf(select_string, sizeof(select_string), "ISSUER:%s"=
, c->issuer);
+        snprintf(select_string, sizeof(select_string), "ISSUER:%s", c->iss=
uer);
         ctx =3D find_certificate_in_store(select_string, user_store);
         /* In this case we expect a successful return as there is at least=
 one valid
          * cert that matches the issuer. But the returned cert may not exa=
ctly match
@@ -411,7 +411,7 @@
         {
             continue;
         }
-        openvpn_snprintf(select_string, sizeof(select_string), "THUMB:%s",=
 c->hash);
+        snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash=
);
         if (Load_CryptoAPI_certificate(select_string, &x509, &privkey) !=
=3D 1)
         {
             fail_msg("Load_CryptoAPI_certificate failed: <%s>", c->friendl=
y_name);
@@ -446,7 +446,7 @@
         SSL_CTX *ssl_ctx =3D SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_clien=
t_method());
         assert_non_null(ssl_ctx);
=20
-        openvpn_snprintf(select_string, sizeof(select_string), "THUMB:%s",=
 c->hash);
+        snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash=
);
         if (!SSL_CTX_use_CryptoAPI_certificate(ssl_ctx, select_string))
         {
             fail_msg("SSL_CTX_use_CryptoAPI_certificate failed: <%s>", c->=
friendly_name);
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/open=
vpn/test_pkcs11.c
index a48e404..84ebb29 100644
--- a/tests/unit_tests/openvpn/test_pkcs11.c
+++ b/tests/unit_tests/openvpn/test_pkcs11.c
@@ -161,7 +161,7 @@
     }
     else if (flags & GET_USER_PASS_PASSWORD_ONLY)
     {
-        openvpn_snprintf(up->password, sizeof(up->password), "%s", PIN);
+        snprintf(up->password, sizeof(up->password), "%s", PIN);
     }
     else
     {
@@ -204,8 +204,8 @@
     {
         fail_msg("make tmpfile using template <%s> failed (error =3D %d)",=
 softhsm2_conf_path, errno);
     }
-    openvpn_snprintf(config, sizeof(config), "directories.tokendir=3D%s/",
-                     softhsm2_tokens_path);
+    snprintf(config, sizeof(config), "directories.tokendir=3D%s/",
+             softhsm2_tokens_path);
     assert_int_equal(write(fd, config, strlen(config)), strlen(config));
     close(fd);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07096977e3b562bcb5d2c6f11673a4175b8e12ac
Gerrit-Change-Number: 547
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--hoL2x7flXcg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/547?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove openvpn_snprintf and similar functions<=
br><br>Old Microsoft versions did strange behaviour but according to the<br=
>newly added unit test and<br>https://stackoverflow.com/questions/7706936/i=
s-snprintf-always-null-terminating<br>this is now standard conforming and w=
e can use the normal snprintf<br>method.<br><br>Microsoft own documentation=
 to swprintf also says you nowadays need to<br>define _CRT_NON_CONFORMING_S=
WPRINTFS to get to non-standard behaviour.<br><br>Change-Id: I07096977e3b56=
2bcb5d2c6f11673a4175b8e12ac<br>Signed-off-by: Arne Schwabe &lt;arne@...1830...=
...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-=
Id: &lt;20240506102710.8976-1-gert@...1296...&gt;<br>URL: https://www.mail-=
archive.com/openvpn-devel@lists.sourceforge.net/msg28617.html<br>Signed-off=
-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/buffer.c<=
br>M src/openvpn/buffer.h<br>M src/openvpn/crypto.c<br>M src/openvpn/crypto=
_mbedtls.c<br>M src/openvpn/dns.c<br>M src/openvpn/env_set.c<br>M src/openv=
pn/error.c<br>M src/openvpn/init.c<br>M src/openvpn/manage.c<br>M src/openv=
pn/options.c<br>M src/openvpn/pkcs11.c<br>M src/openvpn/platform.c<br>M src=
/openvpn/plugin.c<br>M src/openvpn/pool.c<br>M src/openvpn/proxy.c<br>M src=
/openvpn/ps.c<br>M src/openvpn/route.c<br>M src/openvpn/run_command.h<br>M =
src/openvpn/socket.c<br>M src/openvpn/socks.c<br>M src/openvpn/ssl_mbedtls.=
c<br>M src/openvpn/ssl_ncp.c<br>M src/openvpn/ssl_openssl.c<br>M src/openvp=
n/ssl_verify.c<br>M src/openvpn/ssl_verify_mbedtls.c<br>M src/openvpn/ssl_v=
erify_openssl.c<br>M src/openvpn/tls_crypt.c<br>M src/openvpn/tun.c<br>M sr=
c/openvpn/win32.c<br>M src/openvpn/win32.h<br>M src/openvpn/xkey_helper.c<b=
r>M src/openvpnserv/common.c<br>M src/openvpnserv/interactive.c<br>M src/op=
envpnserv/service.h<br>M src/openvpnserv/validate.c<br>M tests/unit_tests/o=
penvpn/test_buffer.c<br>M tests/unit_tests/openvpn/test_cryptoapi.c<br>M te=
sts/unit_tests/openvpn/test_pkcs11.c<br>38 files changed, 291 insertions(+)=
, 333 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span=
>index 66fd63f..3a8069c 100644</span><br><span>--- a/src/openvpn/buffer.c</=
span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -279,32 +279,6=
 @@</span><br><span>     return ret;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * This is necessary due to certain buggy implementations of s=
nprintf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * that don&#=
39;t guarantee null termination for size &gt; 0.</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * Return false on overflow.</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * T=
his functionality is duplicated in src/openvpnserv/common.c</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * Any modifications here should be d=
one to the other place as well.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-bool</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-openvpn_snprintf(char *str, size_t size, const=
 char *format, ...)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    va_list arglist;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int len =3D -1;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (size &gt; 0)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        va_start(arglist, format);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        len =3D vsnprintf(str=
, size, format, arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        va_end(arglist);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        str[size - 1] =3D 0;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return (len &gt;=3D 0 &amp;&amp; len &lt; size);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /*</span><br><span>  * write a string to the end=
 of a buffer that was</span><br><span>  * truncated by buf_printf</span><br=
><span>diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br><=
span>index 7c2f75a..27c3199 100644</span><br><span>--- a/src/openvpn/buffer=
.h</span><br><span>+++ b/src/openvpn/buffer.h</span><br><span>@@ -448,19 +4=
48,6 @@</span><br><span>  */</span><br><span> bool buf_puts(struct buffer *=
buf, const char *str);</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * Like snprintf but guarantees null termination for size &gt; 0</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-bool openvpn_snprintf(char *str, size_t size, cons=
t char *format, ...)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
ifdef __GNUC__</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if __U=
SE_MINGW_ANSI_STDIO</span><br><span style=3D"color: hsl(0, 100%, 40%);">-__=
attribute__ ((format(gnu_printf, 3, 4)))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-__attribute__ ((format(__printf__, 3, 4)))</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> </span><=
br><span> /*</span><br><span>  * remove/add trailing characters</span><br><=
span>diff --git a/src/openvpn/crypto.c b/src/openvpn/crypto.c</span><br><sp=
an>index 5d05cc4..207f145 100644</span><br><span>--- a/src/openvpn/crypto.c=
</span><br><span>+++ b/src/openvpn/crypto.c</span><br><span>@@ -874,11 +874=
,11 @@</span><br><span> </span><br><span>     key_direction_state_init(&amp=
;kds, key_direction);</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    openvpn_snprintf(log_prefix, sizeof(log_prefix), &quo=
t;Outgoing %s&quot;, name);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    snprintf(log_prefix, sizeof(log_prefix), &quot;Outgoing %s&quot=
;, name);</span><br><span>     init_key_ctx(&amp;ctx-&gt;encrypt, &amp;key2=
-&gt;keys[kds.out_key], kt,</span><br><span>                  OPENVPN_OP_EN=
CRYPT, log_prefix);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    openvpn_snprintf(log_prefix, sizeof(log_prefix), &quot;=
Incoming %s&quot;, name);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    snprintf(log_prefix, sizeof(log_prefix), &quot;Incoming %s&quot;,=
 name);</span><br><span>     init_key_ctx(&amp;ctx-&gt;decrypt, &amp;key2-&=
gt;keys[kds.in_key], kt,</span><br><span>                  OPENVPN_OP_DECRY=
PT, log_prefix);</span><br><span> </span><br><span>diff --git a/src/openvpn=
/crypto_mbedtls.c b/src/openvpn/crypto_mbedtls.c</span><br><span>index c230=
292..32511f0 100644</span><br><span>--- a/src/openvpn/crypto_mbedtls.c</spa=
n><br><span>+++ b/src/openvpn/crypto_mbedtls.c</span><br><span>@@ -128,7 +1=
28,7 @@</span><br><span> {</span><br><span>     char prefix[256];</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!open=
vpn_snprintf(prefix, sizeof(prefix), &quot;%s:%d&quot;, func, line))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!snprintf(prefix, =
sizeof(prefix), &quot;%s:%d&quot;, func, line))</span><br><span>     {</spa=
n><br><span>         return mbed_log_err(flags, errval, func);</span><br><s=
pan>     }</span><br><span>@@ -239,11 +239,11 @@</span><br><span>     char =
header[1000+1] =3D { 0 };</span><br><span>     char footer[1000+1] =3D { 0 =
};</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (!openvpn_snprintf(header, sizeof(header), &quot;-----BEGIN %s-----\n=
&quot;, name))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (!snprintf(header, sizeof(header), &quot;-----BEGIN %s-----\n&quot;, name=
))</span><br><span>     {</span><br><span>         return false;</span><br>=
<span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!=
openvpn_snprintf(footer, sizeof(footer), &quot;-----END %s-----\n&quot;, na=
me))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!snprin=
tf(footer, sizeof(footer), &quot;-----END %s-----\n&quot;, name))</span><br=
><span>     {</span><br><span>         return false;</span><br><span>     }=
</span><br><span>@@ -278,11 +278,11 @@</span><br><span>     char header[100=
0+1] =3D { 0 };</span><br><span>     char footer[1000+1] =3D { 0 };</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!op=
envpn_snprintf(header, sizeof(header), &quot;-----BEGIN %s-----&quot;, name=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!snprintf=
(header, sizeof(header), &quot;-----BEGIN %s-----&quot;, name))</span><br><=
span>     {</span><br><span>         return false;</span><br><span>     }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!openvpn_snprin=
tf(footer, sizeof(footer), &quot;-----END %s-----&quot;, name))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (!snprintf(footer, sizeo=
f(footer), &quot;-----END %s-----&quot;, name))</span><br><span>     {</spa=
n><br><span>         return false;</span><br><span>     }</span><br><span>d=
iff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index 7de=
3991..0539ca5 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><spa=
n>+++ b/src/openvpn/dns.c</span><br><span>@@ -349,11 +349,11 @@</span><br><=
span> </span><br><span>     if (j &lt; 0)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        name_ok =3D openvpn_snpr=
intf(name, sizeof(name), format, i);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        name_ok =3D snprintf(name, sizeof(name), format, i=
);</span><br><span>     }</span><br><span>     else</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        name_ok =3D op=
envpn_snprintf(name, sizeof(name), format, i, j);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        name_ok =3D snprintf(name, sizeof(nam=
e), format, i, j);</span><br><span>     }</span><br><span> </span><br><span=
>     if (!name_ok)</span><br><span>diff --git a/src/openvpn/env_set.c b/sr=
c/openvpn/env_set.c</span><br><span>index b13d01e..81ab59e 100644</span><br=
><span>--- a/src/openvpn/env_set.c</span><br><span>+++ b/src/openvpn/env_se=
t.c</span><br><span>@@ -259,7 +259,7 @@</span><br><span> setenv_counter(str=
uct env_set *es, const char *name, counter_type value)</span><br><span> {</=
span><br><span>     char buf[64];</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    openvpn_snprintf(buf, sizeof(buf), counter_format, value);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(buf, si=
zeof(buf), counter_format, value);</span><br><span>     setenv_str(es, name=
, buf);</span><br><span> }</span><br><span> </span><br><span>@@ -267,7 +267=
,7 @@</span><br><span> setenv_int(struct env_set *es, const char *name, int=
 value)</span><br><span> {</span><br><span>     char buf[64];</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(buf, sizeof(bu=
f), &quot;%d&quot;, value);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    snprintf(buf, sizeof(buf), &quot;%d&quot;, value);</span><br><s=
pan>     setenv_str(es, name, buf);</span><br><span> }</span><br><span> </s=
pan><br><span>@@ -275,7 +275,7 @@</span><br><span> setenv_long_long(struct =
env_set *es, const char *name, long long value)</span><br><span> {</span><b=
r><span>     char buf[64];</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    openvpn_snprintf(buf, sizeof(buf), &quot;%&quot; PRIi64, (int64_t)=
value);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf=
(buf, sizeof(buf), &quot;%&quot; PRIi64, (int64_t)value);</span><br><span> =
    setenv_str(es, name, buf);</span><br><span> }</span><br><span> </span><=
br><span>@@ -310,7 +310,7 @@</span><br><span>     strcpy(tmpname, name);</s=
pan><br><span>     while (NULL !=3D env_set_get(es, tmpname) &amp;&amp; cou=
nter &lt; 1000)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        ASSERT(openvpn_snprintf(tmpname, tmpname_len, &quo=
t;%s_%u&quot;, name, counter));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ASSERT(snprintf(tmpname, tmpname_len, &quot;%s_%u&quot;=
, name, counter));</span><br><span>         counter++;</span><br><span>    =
 }</span><br><span>     if (counter &lt; 1000)</span><br><span>diff --git a=
/src/openvpn/error.c b/src/openvpn/error.c</span><br><span>index 245a2d5..e=
c65d5e 100644</span><br><span>--- a/src/openvpn/error.c</span><br><span>+++=
 b/src/openvpn/error.c</span><br><span>@@ -274,14 +274,14 @@</span><br><spa=
n> </span><br><span>     if ((flags &amp; M_ERRNO) &amp;&amp; e)</span><br>=
<span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o=
penvpn_snprintf(m2, ERR_BUF_SIZE, &quot;%s: %s (errno=3D%d)&quot;,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                         m1, o=
penvpn_strerror(e, crt_error, &amp;gc), e);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        snprintf(m2, ERR_BUF_SIZE, &quot;%s: %s (er=
rno=3D%d)&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
              m1, openvpn_strerror(e, crt_error, &amp;gc), e);</span><br><s=
pan>         SWAP;</span><br><span>     }</span><br><span> </span><br><span=
>     if (flags &amp; M_OPTERR)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(m2, ERR_BUF_SIZE,=
 &quot;Options error: %s&quot;, m1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        snprintf(m2, ERR_BUF_SIZE, &quot;Options error: %s=
&quot;, m1);</span><br><span>         SWAP;</span><br><span>     }</span><b=
r><span> </span><br><span>@@ -321,10 +321,10 @@</span><br><span>         co=
nst struct virtual_output *vo =3D msg_get_virtual_output();</span><br><span=
>         if (vo)</span><br><span>         {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            openvpn_snprintf(m2, ERR_BUF_SIZE, &quot=
;%s%s%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                      prefix,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                             prefix_sep,</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                             m1);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            snprintf(m2, ERR_BUF_S=
IZE, &quot;%s%s%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                     prefix,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                     prefix_sep,</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                     m1);</span><br><span>      =
       virtual_output_print(vo, flags, m2);</span><br><span>         }</spa=
n><br><span>     }</span><br><span>diff --git a/src/openvpn/init.c b/src/op=
envpn/init.c</span><br><span>index e67f10e..ec0c309 100644</span><br><span>=
--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br=
><span>@@ -359,7 +359,7 @@</span><br><span>         char *out =3D malloc(le=
n);</span><br><span>         check_malloc_return(out);</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf=
(out, len, &quot;%s,%s,%s,%s&quot;, ce-&gt;remote, ce-&gt;remote_port, prot=
o, status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
snprintf(out, len, &quot;%s,%s,%s,%s&quot;, ce-&gt;remote, ce-&gt;remote_po=
rt, proto, status);</span><br><span>         *remote =3D out;</span><br><sp=
an>     }</span><br><span>     else</span><br><span>diff --git a/src/openvp=
n/manage.c b/src/openvpn/manage.c</span><br><span>index 43c5507..89591ea 10=
0644</span><br><span>--- a/src/openvpn/manage.c</span><br><span>+++ b/src/o=
penvpn/manage.c</span><br><span>@@ -515,8 +515,8 @@</span><br><span>     ch=
ar out[32];</span><br><span> </span><br><span>     /* do in a roundabout wa=
y to work around possible mingw or mingw-glibc bug */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(in, sizeof(in), counte=
r_format, man-&gt;persist.bytes_in + dco_read_bytes);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(out, sizeof(out), coun=
ter_format, man-&gt;persist.bytes_out + dco_write_bytes);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    snprintf(in, sizeof(in), counter_=
format, man-&gt;persist.bytes_in + dco_read_bytes);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    snprintf(out, sizeof(out), counter_fo=
rmat, man-&gt;persist.bytes_out + dco_write_bytes);</span><br><span>     ms=
g(M_CLIENT, &quot;&gt;BYTECOUNT:%s,%s&quot;, in, out);</span><br><span> }</=
span><br><span> </span><br><span>@@ -528,8 +528,8 @@</span><br><span>     c=
har in[32];</span><br><span>     char out[32];</span><br><span>     /* do i=
n a roundabout way to work around possible mingw or mingw-glibc bug */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(in, s=
izeof(in), counter_format, *bytes_in_total);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    openvpn_snprintf(out, sizeof(out), counter_forma=
t, *bytes_out_total);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    snprintf(in, sizeof(in), counter_format, *bytes_in_total);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(out, sizeof(out),=
 counter_format, *bytes_out_total);</span><br><span>     msg(M_CLIENT, &quo=
t;&gt;BYTECOUNT_CLI:%lu,%s,%s&quot;, mdac-&gt;cid, in, out);</span><br><spa=
n>     mdac-&gt;bytecount_last_update =3D now;</span><br><span> }</span><br=
><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br=
><span>index 07387cd..abcde89 100644</span><br><span>--- a/src/openvpn/opti=
ons.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1427,=
7 +1427,7 @@</span><br><span>     for (int i =3D 1; i &lt;=3D opt_max; ++i)=
</span><br><span>     {</span><br><span>         char name[32];</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(name, si=
zeof(name), &quot;foreign_option_%d&quot;, i);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        snprintf(name, sizeof(name), &quot;forei=
gn_option_%d&quot;, i);</span><br><span> </span><br><span>         const ch=
ar *env_str =3D env_set_get(es, name);</span><br><span>         const char =
*value =3D strchr(env_str, &#39;=3D&#39;) + 1;</span><br><span>@@ -1482,7 +=
1482,7 @@</span><br><span>     while (o-&gt;foreign_option_index &lt; opt_m=
ax)</span><br><span>     {</span><br><span>         char name[32];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(name,=
 sizeof(name), &quot;foreign_option_%d&quot;, opt_max--);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        snprintf(name, sizeof(name), =
&quot;foreign_option_%d&quot;, opt_max--);</span><br><span>         setenv_=
del(es, name);</span><br><span>     }</span><br><span> }</span><br><span>@@=
 -5674,8 +5674,8 @@</span><br><span> #ifndef ENABLE_SMALL</span><br><span> =
    {</span><br><span>         char script_name[100];</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(script_name, sizeo=
f(script_name),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
                   &quot;--%s script&quot;, type);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        snprintf(script_name, sizeof(script_=
name),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
    &quot;--%s script&quot;, type);</span><br><span> </span><br><span>     =
    if (check_cmd_access(*script, script_name, (in_chroot ? options-&gt;chr=
oot_dir : NULL)))</span><br><span>         {</span><br><span>diff --git a/s=
rc/openvpn/pkcs11.c b/src/openvpn/pkcs11.c</span><br><span>index 35a02c2..4=
18f6bb 100644</span><br><span>--- a/src/openvpn/pkcs11.c</span><br><span>++=
+ b/src/openvpn/pkcs11.c</span><br><span>@@ -201,7 +201,7 @@</span><br><spa=
n>     CLEAR(token_resp);</span><br><span>     token_resp.defined =3D false=
;</span><br><span>     token_resp.nocache =3D true;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    snprintf(</span><br><span>         to=
ken_resp.username,</span><br><span>         sizeof(token_resp.username),</s=
pan><br><span>         &quot;Please insert %s token&quot;,</span><br><span>=
@@ -245,7 +245,7 @@</span><br><span> </span><br><span>     ASSERT(token!=3D=
NULL);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    openvpn_snprintf(prompt, sizeof(prompt), &quot;%s token&quot;, token=
-&gt;label);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snp=
rintf(prompt, sizeof(prompt), &quot;%s token&quot;, token-&gt;label);</span=
><br><span> </span><br><span>     token_pass.defined =3D false;</span><br><=
span>     token_pass.nocache =3D true;</span><br><span>@@ -719,7 +719,7 @@<=
/span><br><span> </span><br><span>         id_resp.defined =3D false;</span=
><br><span>         id_resp.nocache =3D true;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        openvpn_snprintf(</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        snprintf(</span><br><span>           =
  id_resp.username,</span><br><span>             sizeof(id_resp.username),<=
/span><br><span>             &quot;Please specify PKCS#11 id to use&quot;</=
span><br><span>diff --git a/src/openvpn/platform.c b/src/openvpn/platform.c=
</span><br><span>index 9853dac..3d9d59e 100644</span><br><span>--- a/src/op=
envpn/platform.c</span><br><span>+++ b/src/openvpn/platform.c</span><br><sp=
an>@@ -564,9 +564,9 @@</span><br><span>     {</span><br><span>         ++at=
tempts;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        if (!openvpn_snprintf(fname, sizeof(fname), fname_fmt, max_pref=
ix_len,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                prefix, (unsigned long) get_random(),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                              (unsigned lon=
g) get_random()))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if (!snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                      pref=
ix, (unsigned long) get_random(),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                      (unsigned long) get_random()))</span><b=
r><span>         {</span><br><span>             msg(M_WARN, &quot;ERROR: te=
mporary filename too long&quot;);</span><br><span>             return NULL;=
</span><br><span>diff --git a/src/openvpn/plugin.c b/src/openvpn/plugin.c</=
span><br><span>index 2ad459c..944ce94 100644</span><br><span>--- a/src/open=
vpn/plugin.c</span><br><span>+++ b/src/openvpn/plugin.c</span><br><span>@@ =
-260,7 +260,7 @@</span><br><span>     {</span><br><span>         char full[=
PATH_MAX];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        openvpn_snprintf(full, sizeof(full), &quot;%s/%s&quot;, PLUG=
IN_LIBDIR, p-&gt;so_pathname);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        snprintf(full, sizeof(full), &quot;%s/%s&quot;, PLUGIN_L=
IBDIR, p-&gt;so_pathname);</span><br><span>         p-&gt;handle =3D dlopen=
(full, RTLD_NOW);</span><br><span>     }</span><br><span>     else</span><b=
r><span>@@ -409,7 +409,7 @@</span><br><span> </span><br><span>         gc_i=
nit(&amp;gc);</span><br><span>         msg_fmt =3D gc_malloc(ERR_BUF_SIZE, =
false, &amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   openvpn_snprintf(msg_fmt, ERR_BUF_SIZE, &quot;PLUGIN %s: %s&quot;, name,=
 format);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sn=
printf(msg_fmt, ERR_BUF_SIZE, &quot;PLUGIN %s: %s&quot;, name, format);</sp=
an><br><span>         x_msg_va(msg_flags, msg_fmt, arglist);</span><br><spa=
n> </span><br><span>         gc_free(&amp;gc);</span><br><span>diff --git a=
/src/openvpn/pool.c b/src/openvpn/pool.c</span><br><span>index f706c1a..e3c=
3708 100644</span><br><span>--- a/src/openvpn/pool.c</span><br><span>+++ b/=
src/openvpn/pool.c</span><br><span>@@ -766,7 +766,7 @@</span><br><span>    =
     ifconfig_pool_handle h;</span><br><span>         in_addr_t local, remo=
te;</span><br><span>         char buf[256];</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        openvpn_snprintf(buf, sizeof(buf), &quot;comm=
on-name-%d&quot;, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        snprintf(buf, sizeof(buf), &quot;common-name-%d&quot;, i);</span>=
<br><span> #ifdef DUP_CN</span><br><span>         cn =3D NULL;</span><br><s=
pan> #else</span><br><span>diff --git a/src/openvpn/proxy.c b/src/openvpn/p=
roxy.c</span><br><span>index 5c1cdcb..ba3d87c 100644</span><br><span>--- a/=
src/openvpn/proxy.c</span><br><span>+++ b/src/openvpn/proxy.c</span><br><sp=
an>@@ -582,9 +582,9 @@</span><br><span>     {</span><br><span>         if (=
p-&gt;options.custom_headers[i].content)</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            openvpn_snprintf(=
buf, sizeof(buf), &quot;%s: %s&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                             p-&gt;options.custom_headers[i=
].name,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
               p-&gt;options.custom_headers[i].content);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            snprintf(buf, sizeof(buf),=
 &quot;%s: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                     p-&gt;options.custom_headers[i].name,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                     p-&gt;options.=
custom_headers[i].content);</span><br><span>             if (!strcasecmp(p-=
&gt;options.custom_headers[i].name, &quot;Host&quot;))</span><br><span>    =
         {</span><br><span>                 host_header_sent =3D true;</spa=
n><br><span>@@ -592,8 +592,8 @@</span><br><span>         }</span><br><span>=
         else</span><br><span>         {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            openvpn_snprintf(buf, sizeof(buf), &quot;%s&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
              p-&gt;options.custom_headers[i].name);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            snprintf(buf, sizeof(buf), &q=
uot;%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
               p-&gt;options.custom_headers[i].name);</span><br><span>     =
        if (!strncasecmp(p-&gt;options.custom_headers[i].name, &quot;Host:&=
quot;, 5))</span><br><span>             {</span><br><span>                 =
host_header_sent =3D true;</span><br><span>@@ -609,7 +609,7 @@</span><br><s=
pan> </span><br><span>     if (!host_header_sent)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf=
(buf, sizeof(buf), &quot;Host: %s&quot;, host);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        snprintf(buf, sizeof(buf), &quot;Host: =
%s&quot;, host);</span><br><span>         msg(D_PROXY, &quot;Send to HTTP p=
roxy: &#39;%s&#39;&quot;, buf);</span><br><span>         if (!send_line_crl=
f(sd, buf))</span><br><span>         {</span><br><span>@@ -620,8 +620,8 @@<=
/span><br><span>     /* send User-Agent string if provided */</span><br><sp=
an>     if (p-&gt;options.user_agent)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(buf, sizeof=
(buf), &quot;User-Agent: %s&quot;,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                         p-&gt;options.user_agent);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(buf, sizeof(b=
uf), &quot;User-Agent: %s&quot;,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                 p-&gt;options.user_agent);</span><br><span>  =
       msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);</sp=
an><br><span>         if (!send_line_crlf(sd, buf))</span><br><span>       =
  {</span><br><span>@@ -667,10 +667,10 @@</span><br><span>     else</span><=
br><span>     {</span><br><span>         /* format HTTP CONNECT message */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprin=
tf(buf, sizeof(buf), &quot;CONNECT %s:%s HTTP/%s&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                         host,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                         port,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
  p-&gt;options.http_version);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        snprintf(buf, sizeof(buf), &quot;CONNECT %s:%s HTTP/%s&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   host,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
      port,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
         p-&gt;options.http_version);</span><br><span> </span><br><span>   =
      msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);</spa=
n><br><span> </span><br><span>@@ -692,8 +692,8 @@</span><br><span>         =
        break;</span><br><span> </span><br><span>             case HTTP_AUT=
H_BASIC:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   openvpn_snprintf(buf, sizeof(buf), &quot;Proxy-Authorization: Basic %s&q=
uot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                 username_password_as_base64(p, &amp;gc));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                snprintf(buf, sizeof=
(buf), &quot;Proxy-Authorization: Basic %s&quot;,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                         username_password_as=
_base64(p, &amp;gc));</span><br><span>                 msg(D_PROXY, &quot;A=
ttempting Basic Proxy-Authorization&quot;);</span><br><span>               =
  dmsg(D_SHOW_KEYS, &quot;Send to HTTP proxy: &#39;%s&#39;&quot;, buf);</sp=
an><br><span>                 if (!send_line_crlf(sd, buf))</span><br><span=
>@@ -705,14 +705,14 @@</span><br><span> #if NTLM</span><br><span>          =
   case HTTP_AUTH_NTLM2:</span><br><span>                 /* keep-alive con=
nection */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     openvpn_snprintf(buf, sizeof(buf), &quot;Proxy-Connection: Keep-Alive&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    snprintf(buf, sizeof(buf), &quot;Proxy-Connection: Keep-Alive&quot;);</=
span><br><span>                 if (!send_line_crlf(sd, buf))</span><br><sp=
an>                 {</span><br><span>                     goto error;</spa=
n><br><span>                 }</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                openvpn_snprintf(buf, sizeof(buf=
), &quot;Proxy-Authorization: NTLM %s&quot;,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                 ntlm_phase_1(p, &am=
p;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    snprintf(buf, sizeof(buf), &quot;Proxy-Authorization: NTLM %s&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
   ntlm_phase_1(p, &amp;gc));</span><br><span>                 msg(D_PROXY,=
 &quot;Attempting NTLM Proxy-Authorization phase 1&quot;);</span><br><span>=
                 dmsg(D_SHOW_KEYS, &quot;Send to HTTP proxy: &#39;%s&#39;&q=
uot;, buf);</span><br><span>                 if (!send_line_crlf(sd, buf))<=
/span><br><span>@@ -773,7 +773,7 @@</span><br><span> </span><br><span>     =
            char get[80];</span><br><span>                 CLEAR(buf2);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                openvpn_s=
nprintf(get, sizeof(get), &quot;%%*s NTLM %%%zus&quot;, sizeof(buf2) - 1);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                snpr=
intf(get, sizeof(get), &quot;%%*s NTLM %%%zus&quot;, sizeof(buf2) - 1);</sp=
an><br><span>                 nparms =3D sscanf(buf, get, buf2);</span><br>=
<span> </span><br><span>                 /* check for &quot;Proxy-Authentic=
ate: NTLM TlRM...&quot; */</span><br><span>@@ -795,10 +795,10 @@</span><br>=
<span>             /* now send the phase 3 reply */</span><br><span> </span=
><br><span>             /* format HTTP CONNECT message */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            openvpn_snprintf(buf, sizeo=
f(buf), &quot;CONNECT %s:%s HTTP/%s&quot;,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                             host,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                             port,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                            =
 p-&gt;options.http_version);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            snprintf(buf, sizeof(buf), &quot;CONNECT %s:%s HTTP/%=
s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
          host,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                 port,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                     p-&gt;options.http_version);</span><br><span> </spa=
n><br><span>             msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#39=
;&quot;, buf);</span><br><span> </span><br><span>@@ -809,7 +809,7 @@</span>=
<br><span>             }</span><br><span> </span><br><span>             /* =
keep-alive connection */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            openvpn_snprintf(buf, sizeof(buf), &quot;Proxy-Connection: K=
eep-Alive&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          snprintf(buf, sizeof(buf), &quot;Proxy-Connection: Keep-Alive&quo=
t;);</span><br><span>             if (!send_line_crlf(sd, buf))</span><br><=
span>             {</span><br><span>                 goto error;</span><br>=
<span>@@ -829,7 +829,7 @@</span><br><span>                     msg(D_PROXY,=
 &quot;NTLM Proxy-Authorization phase 3 failed: received corrupted data fro=
m proxy server&quot;);</span><br><span>                     goto error;</sp=
an><br><span>                 }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                openvpn_snprintf(buf, sizeof(buf), &quot;Proxy-Au=
thorization: NTLM %s&quot;, np3);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                snprintf(buf, sizeof(buf), &quot;Proxy-Author=
ization: NTLM %s&quot;, np3);</span><br><span>             }</span><br><spa=
n> </span><br><span>             msg(D_PROXY, &quot;Send to HTTP proxy: &#3=
9;%s&#39;&quot;, buf);</span><br><span>@@ -899,15 +899,15 @@</span><br><spa=
n> </span><br><span> </span><br><span>                 /* build the digest =
response */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      openvpn_snprintf(uri, sizeof(uri), &quot;%s:%s&quot;,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                 host=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
             port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                snprintf(uri, sizeof(uri), &quot;%s:%s&quot;,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                         host,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
   port);</span><br><span> </span><br><span>                 if (opaque)</s=
pan><br><span>                 {</span><br><span>                     const=
 int len =3D strlen(opaque)+16;</span><br><span>                     opaque=
_kv =3D gc_malloc(len, false, &amp;gc);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    openvpn_snprintf(opaque_kv, len, &quo=
t;, opaque=3D\&quot;%s\&quot;&quot;, opaque);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    snprintf(opaque_kv, len, &quo=
t;, opaque=3D\&quot;%s\&quot;&quot;, opaque);</span><br><span>             =
    }</span><br><span> </span><br><span>                 DigestCalcHA1(algo=
r,</span><br><span>@@ -928,10 +928,10 @@</span><br><span>                  =
                  response);</span><br><span> </span><br><span>            =
     /* format HTTP CONNECT message */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                openvpn_snprintf(buf, sizeof(buf), &quot;%=
s %s HTTP/%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
                               http_method,</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                                 uri,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                 p-&g=
t;options.http_version);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                snprintf(buf, sizeof(buf), &quot;%s %s HTTP/%s&quot;,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
     http_method,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                       uri,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                         p-&gt;options.http_version);</span><br><sp=
an> </span><br><span>                 msg(D_PROXY, &quot;Send to HTTP proxy=
: &#39;%s&#39;&quot;, buf);</span><br><span> </span><br><span>@@ -948,21 +9=
48,22 @@</span><br><span>                 }</span><br><span> </span><br><sp=
an>                 /* send digest response */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                int sret =3D openvpn_snprintf(buf,=
 sizeof(buf), &quot;Proxy-Authorization: Digest username=3D\&quot;%s\&quot;=
, realm=3D\&quot;%s\&quot;, nonce=3D\&quot;%s\&quot;, uri=3D\&quot;%s\&quot=
;, qop=3D%s, nc=3D%s, cnonce=3D\&quot;%s\&quot;, response=3D\&quot;%s\&quot=
;%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
                                 username,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                            realm,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                         =
                   nonce,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                                            uri,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
 qop,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
                            nonce_count,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                                            cnonce,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                          =
                  response,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                                            opaque_kv</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                                     =
       );</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      int sret =3D snprintf(buf, sizeof(buf), &quot;Proxy-Authorization: Di=
gest username=3D\&quot;%s\&quot;, realm=3D\&quot;%s\&quot;, nonce=3D\&quot;=
%s\&quot;, uri=3D\&quot;%s\&quot;, qop=3D%s, nc=3D%s, cnonce=3D\&quot;%s\&q=
uot;, response=3D\&quot;%s\&quot;%s&quot;,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                                    username,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
          realm,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                                 nonce,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                    uri,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
  qop,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                       nonce_count,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                    cnonce,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                                   =
 response,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                           opaque_kv</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                    );</span><br><span>   =
              if (sret &gt;=3D sizeof(buf))</span><br><span>               =
  {</span><br><span>                     goto error;</span><br><span>      =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>                 msg(D_PROXY, &quot;Send to HTTP proxy: &#39;%s&#=
39;&quot;, buf);</span><br><span>                 if (!send_line_crlf(sd, b=
uf))</span><br><span>                 {</span><br><span>diff --git a/src/op=
envpn/ps.c b/src/openvpn/ps.c</span><br><span>index 7d9f9b5..4ca3a12 100644=
</span><br><span>--- a/src/openvpn/ps.c</span><br><span>+++ b/src/openvpn/p=
s.c</span><br><span>@@ -354,7 +354,7 @@</span><br><span>         fnlen =3D =
 strlen(journal_dir) + strlen(t) + 2;</span><br><span>         jfn =3D (cha=
r *) malloc(fnlen);</span><br><span>         check_malloc_return(jfn);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(j=
fn, fnlen, &quot;%s/%s&quot;, journal_dir, t);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        snprintf(jfn, fnlen, &quot;%s/%s&quot;, =
journal_dir, t);</span><br><span>         dmsg(D_PS_PROXY_DEBUG, &quot;PORT=
 SHARE PROXY: client origin %s -&gt; %s&quot;, jfn, f);</span><br><span>   =
      fd =3D platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_I=
WUSR | S_IRGRP);</span><br><span>         if (fd !=3D -1)</span><br><span>d=
iff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br><span>index=
 909d6d2..68bbcfd 100644</span><br><span>--- a/src/openvpn/route.c</span><b=
r><span>+++ b/src/openvpn/route.c</span><br><span>@@ -1621,11 +1621,11 @@</=
span><br><span> </span><br><span>     if (rgi)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(ou=
t, sizeof(out), &quot;%s %s %s dev %s&quot;, network, netmask, gateway, rgi=
-&gt;iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 snprintf(out, sizeof(out), &quot;%s %s %s dev %s&quot;, network, netmask, =
gateway, rgi-&gt;iface);</span><br><span>     }</span><br><span>     else</=
span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        openvpn_snprintf(out, sizeof(out), &quot;%s %s %s&quot;, network, n=
etmask, gateway);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      snprintf(out, sizeof(out), &quot;%s %s %s&quot;, network, netmask, ga=
teway);</span><br><span>     }</span><br><span>     bool ret =3D management=
_android_control(management, &quot;ROUTE&quot;, out);</span><br><span>     =
status =3D ret ? RTA_SUCCESS : RTA_ERROR;</span><br><span>@@ -2000,7 +2000,=
7 @@</span><br><span> #elif defined (TARGET_ANDROID)</span><br><span>     c=
har out[64];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    openvpn_snprintf(out, sizeof(out), &quot;%s/%d %s&quot;, netwo=
rk, r6-&gt;netbits, device);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    snprintf(out, sizeof(out), &quot;%s/%d %s&quot;, network, r6-&=
gt;netbits, device);</span><br><span> </span><br><span>     status =3D mana=
gement_android_control(management, &quot;ROUTE6&quot;, out);</span><br><spa=
n> </span><br><span>diff --git a/src/openvpn/run_command.h b/src/openvpn/ru=
n_command.h</span><br><span>index 52ab115..ccad307 100644</span><br><span>-=
-- a/src/openvpn/run_command.h</span><br><span>+++ b/src/openvpn/run_comman=
d.h</span><br><span>@@ -66,8 +66,8 @@</span><br><span> {</span><br><span>  =
   char msg[256];</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    openvpn_snprintf(msg, sizeof(msg),</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                     &quot;WARNING: Failed =
running command (%s)&quot;, hook);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    snprintf(msg, sizeof(msg),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+             &quot;WARNING: Failed running comman=
d (%s)&quot;, hook);</span><br><span>     return openvpn_execve_check(a, es=
, flags | S_SCRIPT, msg);</span><br><span> }</span><br><span> </span><br><s=
pan>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><spa=
n>index d2b82d5..24d1276 100644</span><br><span>--- a/src/openvpn/socket.c<=
/span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -2983,11 +298=
3,11 @@</span><br><span>         case AF_INET:</span><br><span>            =
 if (flags &amp; SA_IP_PORT)</span><br><span>             {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                openvpn_snprintf(name=
_buf, sizeof(name_buf), &quot;%s_ip&quot;, name_prefix);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                snprintf(name_buf, siz=
eof(name_buf), &quot;%s_ip&quot;, name_prefix);</span><br><span>           =
  }</span><br><span>             else</span><br><span>             {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                openvpn_snpr=
intf(name_buf, sizeof(name_buf), &quot;%s&quot;, name_prefix);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                snprintf(name_bu=
f, sizeof(name_buf), &quot;%s&quot;, name_prefix);</span><br><span>        =
     }</span><br><span> </span><br><span>             inet_ntop(AF_INET, &a=
mp;addr-&gt;addr.in4.sin_addr, buf, sizeof(buf));</span><br><span>@@ -2995,=
7 +2995,7 @@</span><br><span> </span><br><span>             if ((flags &amp=
; SA_IP_PORT) &amp;&amp; addr-&gt;addr.in4.sin_port)</span><br><span>      =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   openvpn_snprintf(name_buf, sizeof(name_buf), &quot;%s_port&quot;, name_p=
refix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    snprintf(name_buf, sizeof(name_buf), &quot;%s_port&quot;, name_prefix);=
</span><br><span>                 setenv_int(es, name_buf, ntohs(addr-&gt;a=
ddr.in4.sin_port));</span><br><span>             }</span><br><span>        =
     break;</span><br><span>@@ -3006,19 +3006,19 @@</span><br><span>       =
          struct in_addr ia;</span><br><span>                 memcpy(&amp;i=
a.s_addr, &amp;addr-&gt;addr.in6.sin6_addr.s6_addr[12],</span><br><span>   =
                     sizeof(ia.s_addr));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                openvpn_snprintf(name_buf, sizeof(name_b=
uf), &quot;%s_ip&quot;, name_prefix);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                snprintf(name_buf, sizeof(name_buf), &quo=
t;%s_ip&quot;, name_prefix);</span><br><span>                 inet_ntop(AF_=
INET, &amp;ia, buf, sizeof(buf));</span><br><span>             }</span><br>=
<span>             else</span><br><span>             {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                openvpn_snprintf(name_buf,=
 sizeof(name_buf), &quot;%s_ip6&quot;, name_prefix);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                snprintf(name_buf, sizeof=
(name_buf), &quot;%s_ip6&quot;, name_prefix);</span><br><span>             =
    inet_ntop(AF_INET6, &amp;addr-&gt;addr.in6.sin6_addr, buf, sizeof(buf))=
;</span><br><span>             }</span><br><span>             setenv_str(es=
, name_buf, buf);</span><br><span> </span><br><span>             if ((flags=
 &amp; SA_IP_PORT) &amp;&amp; addr-&gt;addr.in6.sin6_port)</span><br><span>=
             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         openvpn_snprintf(name_buf, sizeof(name_buf), &quot;%s_port&quot;, =
name_prefix);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          snprintf(name_buf, sizeof(name_buf), &quot;%s_port&quot;, name_pr=
efix);</span><br><span>                 setenv_int(es, name_buf, ntohs(addr=
-&gt;addr.in6.sin6_port));</span><br><span>             }</span><br><span> =
            break;</span><br><span>diff --git a/src/openvpn/socks.c b/src/o=
penvpn/socks.c</span><br><span>index b046910..8b8c01a 100644</span><br><spa=
n>--- a/src/openvpn/socks.c</span><br><span>+++ b/src/openvpn/socks.c</span=
><br><span>@@ -109,9 +109,10 @@</span><br><span>             &quot;Authenti=
cation not possible.&quot;);</span><br><span>         goto cleanup;</span><=
br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t sret =3D openvpn_snprintf(to_send, sizeof(to_send), &quot;\x01%c%s%c%s&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
               (int) strlen(creds.username), creds.username,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                                (int=
) strlen(creds.password), creds.password);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int sret =3D snprintf(to_send, sizeof(to_send), &quot;\x01%c%s%c%s&=
quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           (int) strlen(creds.username), creds.username,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        (int) strlen(c=
reds.password), creds.password);</span><br><span>     ASSERT(sret &lt;=3D s=
izeof(to_send));</span><br><span> </span><br><span>     size =3D send(sd, t=
o_send, strlen(to_send), MSG_NOSIGNAL);</span><br><span>diff --git a/src/op=
envpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c</span><br><span>index 0730d=
25..b0303b6 100644</span><br><span>--- a/src/openvpn/ssl_mbedtls.c</span><b=
r><span>+++ b/src/openvpn/ssl_mbedtls.c</span><br><span>@@ -1531,16 +1531,1=
6 @@</span><br><span>     char s2[256];</span><br><span> </span><br><span> =
    s1[0] =3D s2[0] =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    openvpn_snprintf(s1, sizeof(s1), &quot;%s %s, cipher %s&quot;,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                     pref=
ix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
   mbedtls_ssl_get_version(ks_ssl-&gt;ctx),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                     mbedtls_ssl_get_ciphersuite(ks_s=
sl-&gt;ctx));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    sn=
printf(s1, sizeof(s1), &quot;%s %s, cipher %s&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             prefix,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+             mbedtls_ssl_get_version(ks_=
ssl-&gt;ctx),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
       mbedtls_ssl_get_ciphersuite(ks_ssl-&gt;ctx));</span><br><span> </spa=
n><br><span>     cert =3D mbedtls_ssl_get_peer_cert(ks_ssl-&gt;ctx);</span>=
<br><span>     if (cert !=3D NULL)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(s2, sizeof(s2)=
, &quot;, %u bit key&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                         (unsigned int) mbedtls_pk_get_bitlen(&amp;ce=
rt-&gt;pk));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 snprintf(s2, sizeof(s2), &quot;, %u bit key&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                 (unsigned int) mbedtls_p=
k_get_bitlen(&amp;cert-&gt;pk));</span><br><span>     }</span><br><span> </=
span><br><span>     msg(D_HANDSHAKE, &quot;%s%s&quot;, s1, s2);</span><br><=
span>diff --git a/src/openvpn/ssl_ncp.c b/src/openvpn/ssl_ncp.c</span><br><=
span>index 73ec9f5..968858e 100644</span><br><span>--- a/src/openvpn/ssl_nc=
p.c</span><br><span>+++ b/src/openvpn/ssl_ncp.c</span><br><span>@@ -198,8 +=
198,8 @@</span><br><span>     size_t newlen =3D strlen(o-&gt;ncp_ciphers) +=
 1 + strlen(ciphername) + 1;</span><br><span>     char *ncp_ciphers =3D gc_=
malloc(newlen, false, &amp;o-&gt;gc);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    ASSERT(openvpn_snprintf(ncp_ciphers, =
newlen, &quot;%s:%s&quot;, o-&gt;ncp_ciphers,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                            ciphername));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(snprintf(ncp_ciphe=
rs, newlen, &quot;%s:%s&quot;, o-&gt;ncp_ciphers,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    ciphername));</span><br><=
span>     o-&gt;ncp_ciphers =3D ncp_ciphers;</span><br><span> }</span><br><=
span> </span><br><span>diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn=
/ssl_openssl.c</span><br><span>index a158617..6efef4f 100644</span><br><spa=
n>--- a/src/openvpn/ssl_openssl.c</span><br><span>+++ b/src/openvpn/ssl_ope=
nssl.c</span><br><span>@@ -1774,7 +1774,7 @@</span><br><span>     if (!biof=
p)</span><br><span>     {</span><br><span>         char fn[256];</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(fn, siz=
eof(fn), &quot;bio/%d-%d.log&quot;, pid, biofp_toggle);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        snprintf(fn, sizeof(fn), &quot;=
bio/%d-%d.log&quot;, pid, biofp_toggle);</span><br><span>         biofp =3D=
 fopen(fn, &quot;w&quot;);</span><br><span>         ASSERT(biofp);</span><b=
r><span>         biofp_last_open =3D time(NULL);</span><br><span>@@ -2116,8=
 +2116,8 @@</span><br><span> #endif /* if OPENSSL_VERSION_NUMBER &lt; 0x300=
00000L */</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(buf, buflen, &quot;%d bit=
s %s%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
             EVP_PKEY_bits(pkey), type, curve);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    snprintf(buf, buflen, &quot;%d bits %s%s&qu=
ot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             EV=
P_PKEY_bits(pkey), type, curve);</span><br><span> }</span><br><span> </span=
><br><span> /**</span><br><span>@@ -2137,12 +2137,12 @@</span><br><span>   =
  int signature_nid =3D X509_get_signature_nid(cert);</span><br><span>     =
if (signature_nid !=3D 0)</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        openvpn_snprintf(sig, sizeof(sig), &quot=
;, signature: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                         OBJ_nid2sn(signature_nid));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        snprintf(sig, sizeof(sig), &quot=
;, signature: %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 OBJ_nid2sn(signature_nid));</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ope=
nvpn_snprintf(buf, buflen, &quot;, peer certificate: %s%s&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                     pkeybuf, si=
g);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(buf=
, buflen, &quot;, peer certificate: %s%s&quot;,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+             pkeybuf, sig);</span><br><span> </=
span><br><span>     EVP_PKEY_free(pkey);</span><br><span> }</span><br><span=
>@@ -2160,8 +2160,8 @@</span><br><span>     char pkeybuf[128] =3D { 0 };</s=
pan><br><span>     print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    open=
vpn_snprintf(buf, buflen, &quot;, peer temporary key: %s&quot;,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                     pkeybuf);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(buf, bufl=
en, &quot;, peer temporary key: %s&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+             pkeybuf);</span><br><span> </span><br><s=
pan>     EVP_PKEY_free(pkey);</span><br><span> }</span><br><span>@@ -2238,8=
 +2238,8 @@</span><br><span>         return;</span><br><span>     }</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn=
_snprintf(buf, buflen, &quot;, peer signing digest/type: %s %s&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                     peer_s=
ig, peer_sig_type);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    snprintf(buf, buflen, &quot;, peer signing digest/type: %s %s&quot;,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+             peer_sig,=
 peer_sig_type);</span><br><span> }</span><br><span> </span><br><span> </sp=
an><br><span>@@ -2262,11 +2262,11 @@</span><br><span> </span><br><span>    =
 s1[0] =3D s2[0] =3D s3[0] =3D s4[0] =3D 0;</span><br><span>     ciph =3D S=
SL_get_current_cipher(ks_ssl-&gt;ssl);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    openvpn_snprintf(s1, sizeof(s1), &quot;%s %s, cipher %=
s %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
           prefix,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                  SSL_get_version(ks_ssl-&gt;ssl),</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                     SSL_CIPHER_get_version(ci=
ph),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
    SSL_CIPHER_get_name(ciph));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    snprintf(s1, sizeof(s1), &quot;%s %s, cipher %s %s&quot;,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+             prefix,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+             SSL_get=
_version(ks_ssl-&gt;ssl),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+             SSL_CIPHER_get_version(ciph),</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             SSL_CIPHER_get_name(ciph));</span=
><br><span>     X509 *cert =3D SSL_get_peer_certificate(ks_ssl-&gt;ssl);</s=
pan><br><span> </span><br><span>     if (cert)</span><br><span>diff --git a=
/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c</span><br><span>index =
930769b..934ff8d 100644</span><br><span>--- a/src/openvpn/ssl_verify.c</spa=
n><br><span>+++ b/src/openvpn/ssl_verify.c</span><br><span>@@ -421,12 +421,=
12 @@</span><br><span>     }</span><br><span> </span><br><span>     /* expo=
rt subject name string as environmental variable */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(envname, sizeof(envnam=
e), &quot;tls_id_%d&quot;, cert_depth);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    snprintf(envname, sizeof(envname), &quot;tls_id_%d&=
quot;, cert_depth);</span><br><span>     setenv_str(es, envname, subject);<=
/span><br><span> </span><br><span> #if 0</span><br><span>     /* export com=
mon name string as environmental variable */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    openvpn_snprintf(envname, sizeof(envname), &quot=
;tls_common_name_%d&quot;, cert_depth);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    snprintf(envname, sizeof(envname), &quot;tls_common=
_name_%d&quot;, cert_depth);</span><br><span>     setenv_str(es, envname, c=
ommon_name);</span><br><span> #endif</span><br><span> </span><br><span>@@ -=
435,24 +435,24 @@</span><br><span>         struct buffer sha1 =3D x509_get_=
sha1_fingerprint(peer_cert, &amp;gc);</span><br><span>         struct buffe=
r sha256 =3D x509_get_sha256_fingerprint(peer_cert, &amp;gc);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_s=
nprintf(envname, sizeof(envname), &quot;tls_digest_%d&quot;, cert_depth);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(envn=
ame, sizeof(envname), &quot;tls_digest_%d&quot;, cert_depth);</span><br><sp=
an>         setenv_str(es, envname,</span><br><span>                    for=
mat_hex_ex(BPTR(&amp;sha1), BLEN(&amp;sha1), 0, 1, &quot;:&quot;, &amp;gc))=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      openvpn_snprintf(envname, sizeof(envname), &quot;tls_digest_sha256_%d=
&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
           cert_depth);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        snprintf(envname, sizeof(envname), &quot;tls_digest_sha256_%d&q=
uot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
   cert_depth);</span><br><span>         setenv_str(es, envname,</span><br>=
<span>                    format_hex_ex(BPTR(&amp;sha256), BLEN(&amp;sha256=
), 0, 1, &quot;:&quot;, &amp;gc));</span><br><span>     }</span><br><span> =
</span><br><span>     /* export serial number as environmental variable */<=
/span><br><span>     serial =3D backend_x509_get_serial(peer_cert, &amp;gc)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf=
(envname, sizeof(envname), &quot;tls_serial_%d&quot;, cert_depth);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(envname, sizeof=
(envname), &quot;tls_serial_%d&quot;, cert_depth);</span><br><span>     set=
env_str(es, envname, serial);</span><br><span> </span><br><span>     /* exp=
ort serial number in hex as environmental variable */</span><br><span>     =
serial =3D backend_x509_get_serial_hex(peer_cert, &amp;gc);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(envname, sizeof(=
envname), &quot;tls_serial_hex_%d&quot;, cert_depth);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    snprintf(envname, sizeof(envname), &q=
uot;tls_serial_hex_%d&quot;, cert_depth);</span><br><span>     setenv_str(e=
s, envname, serial);</span><br><span> </span><br><span>     gc_free(&amp;gc=
);</span><br><span>@@ -569,7 +569,7 @@</span><br><span>         goto cleanu=
p;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (!openvpn_snprintf(fn, sizeof(fn), &quot;%s%c%=
s&quot;, crl_dir, PATH_SEPARATOR, serial))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (!snprintf(fn, sizeof(fn), &quot;%s%c%s&quot;=
, crl_dir, PATH_SEPARATOR, serial))</span><br><span>     {</span><br><span>=
         msg(D_HANDSHAKE, &quot;VERIFY CRL: filename overflow&quot;);</span=
><br><span>         goto cleanup;</span><br><span>@@ -938,9 +938,9 @@</span=
><br><span>             if (!check_auth_pending_method(multi-&gt;peer_info,=
 pending_method))</span><br><span>             {</span><br><span>          =
       char buf[128];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                openvpn_snprintf(buf, sizeof(buf),</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                                 &quot;Authent=
ication failed, required pending auth &quot;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                 &quot;method &#39;%=
s&#39; not supported&quot;, pending_method);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                snprintf(buf, sizeof(buf),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                         &q=
uot;Authentication failed, required pending auth &quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                         &quot;method &=
#39;%s&#39; not supported&quot;, pending_method);</span><br><span>         =
        auth_set_client_reason(multi, buf);</span><br><span>               =
  msg(M_INFO, &quot;Client does not supported auth pending method &quot;</s=
pan><br><span>                     &quot;&#39;%s&#39;&quot;, pending_method=
);</span><br><span>diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/open=
vpn/ssl_verify_mbedtls.c</span><br><span>index a801cd3..ca14ceb 100644</spa=
n><br><span>--- a/src/openvpn/ssl_verify_mbedtls.c</span><br><span>+++ b/sr=
c/openvpn/ssl_verify_mbedtls.c</span><br><span>@@ -86,8 +86,8 @@</span><br>=
<span>         char *serial =3D backend_x509_get_serial(cert, &amp;gc);</sp=
an><br><span> </span><br><span>         ret =3D mbedtls_x509_crt_verify_inf=
o(errstr, sizeof(errstr)-1, &quot;&quot;, *flags);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (ret &lt;=3D 0 &amp;&amp; !openvpn_=
snprintf(errstr, sizeof(errstr),</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                                          &quot;Could not retrie=
ve error string, flags=3D%&quot; PRIx32, *flags))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        if (ret &lt;=3D 0 &amp;&amp; !snprint=
f(errstr, sizeof(errstr),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                  &quot;Could not retrieve error stri=
ng, flags=3D%&quot; PRIx32, *flags))</span><br><span>         {</span><br><=
span>             errstr[0] =3D &#39;\0&#39;;</span><br><span>         }</s=
pan><br><span>@@ -307,7 +307,7 @@</span><br><span>     name_expand_size =3D=
 64 + strlen(name);</span><br><span>     name_expand =3D (char *) malloc(na=
me_expand_size);</span><br><span>     check_malloc_return(name_expand);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(name=
_expand, name_expand_size, &quot;X509_%d_%s&quot;, depth, name);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(name_expand, name=
_expand_size, &quot;X509_%d_%s&quot;, depth, name);</span><br><span>     se=
tenv_str(es, name_expand, value);</span><br><span>     free(name_expand);</=
span><br><span> }</span><br><span>@@ -431,13 +431,13 @@</span><br><span> </=
span><br><span>         if (0 =3D=3D mbedtls_oid_get_attr_short_name(&amp;n=
ame-&gt;oid, &amp;shortname) )</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            openvpn_snprintf(name_expan=
d, sizeof(name_expand), &quot;X509_%d_%s&quot;,</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                             cert_depth, shortnam=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            snpr=
intf(name_expand, sizeof(name_expand), &quot;X509_%d_%s&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                     cert_depth,=
 shortname);</span><br><span>         }</span><br><span>         else</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            openvpn_snprintf(name_expand, sizeof(name_expand), &quot;X509_%=
d_\?\?&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
                     cert_depth);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            snprintf(name_expand, sizeof(name_expand), &quot;=
X509_%d_\?\?&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                     cert_depth);</span><br><span>         }</span><br><spa=
n> </span><br><span>         for (i =3D 0; i &lt; name-&gt;val.len; i++)</s=
pan><br><span>diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/s=
sl_verify_openssl.c</span><br><span>index ec3a7cf..7d41d4a 100644</span><br=
><span>--- a/src/openvpn/ssl_verify_openssl.c</span><br><span>+++ b/src/ope=
nvpn/ssl_verify_openssl.c</span><br><span>@@ -279,7 +279,7 @@</span><br><sp=
an>             gc_free(&amp;gc);</span><br><span>             return FAILU=
RE;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        openvpn_snprintf(common_name, cn_len, &quot;0x%s&quot;, se=
rial);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snpri=
ntf(common_name, cn_len, &quot;0x%s&quot;, serial);</span><br><span>       =
  gc_free(&amp;gc);</span><br><span>     }</span><br><span>     else</span>=
<br><span>@@ -454,7 +454,7 @@</span><br><span>     name_expand_size =3D 64 =
+ strlen(name);</span><br><span>     name_expand =3D (char *) malloc(name_e=
xpand_size);</span><br><span>     check_malloc_return(name_expand);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(name_exp=
and, name_expand_size, &quot;X509_%d_%s&quot;, depth, name);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    snprintf(name_expand, name_exp=
and_size, &quot;X509_%d_%s&quot;, depth, name);</span><br><span>     setenv=
_str(es, name_expand, value);</span><br><span>     free(name_expand);</span=
><br><span> }</span><br><span>@@ -597,8 +597,8 @@</span><br><span>         =
name_expand_size =3D 64 + strlen(objbuf);</span><br><span>         name_exp=
and =3D (char *) malloc(name_expand_size);</span><br><span>         check_m=
alloc_return(name_expand);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        openvpn_snprintf(name_expand, name_expand_size, &quot;X509_%d_=
%s&quot;, cert_depth,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                         objbuf);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        snprintf(name_expand, name_expand_size, &quot;X509_%d=
_%s&quot;, cert_depth,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                 objbuf);</span><br><span>         string_mod(name_expan=
d, CC_PRINT, CC_CRLF, &#39;_&#39;);</span><br><span>         string_mod((ch=
ar *)buf, CC_PRINT, CC_CRLF, &#39;_&#39;);</span><br><span>         setenv_=
str_incr(es, name_expand, (char *)buf);</span><br><span>diff --git a/src/op=
envpn/tls_crypt.c b/src/openvpn/tls_crypt.c</span><br><span>index 6ef1c7d..=
90fe6e9 100644</span><br><span>--- a/src/openvpn/tls_crypt.c</span><br><spa=
n>+++ b/src/openvpn/tls_crypt.c</span><br><span>@@ -574,8 +574,8 @@</span><=
br><span>     }</span><br><span> </span><br><span>     char metadata_type_s=
tr[4] =3D { 0 }; /* Max value: 255 */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    openvpn_snprintf(metadata_type_str, sizeof(metadata_typ=
e_str),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
       &quot;%i&quot;, (uint8_t) metadata_type);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    snprintf(metadata_type_str, sizeof(metadat=
a_type_str),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
      &quot;%i&quot;, (uint8_t) metadata_type);</span><br><span>     struct=
 env_set *es =3D env_set_create(NULL);</span><br><span>     setenv_str(es, =
&quot;script_type&quot;, &quot;tls-crypt-v2-verify&quot;);</span><br><span>=
     setenv_str(es, &quot;metadata_type&quot;, metadata_type_str);</span><b=
r><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>=
index f550e9c..d01515d 100644</span><br><span>--- a/src/openvpn/tun.c</span=
><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -1114,8 +1114,8 @@</s=
pan><br><span> #elif defined(TARGET_ANDROID)</span><br><span>     char out6=
[64];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    openvpn_snprintf(out6, sizeof(out6), &quot;%s/%d %d&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                     ifconfig_ip=
v6_local, tt-&gt;netbits_ipv6, tun_mtu);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    snprintf(out6, sizeof(out6), &quot;%s/%d %d&quot;,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             ifconf=
ig_ipv6_local, tt-&gt;netbits_ipv6, tun_mtu);</span><br><span>     manageme=
nt_android_control(management, &quot;IFCONFIG6&quot;, out6);</span><br><spa=
n> #elif defined(TARGET_SOLARIS)</span><br><span>     argv_printf(&amp;argv=
, &quot;%s %s inet6 unplumb&quot;, IFCONFIG_PATH, ifname);</span><br><span>=
@@ -1362,8 +1362,8 @@</span><br><span>             top =3D &quot;undef&quot=
;;</span><br><span>     }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    openvpn_snprintf(out, sizeof(out), &quot;%s %s %d=
 %s&quot;, ifconfig_local,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                     ifconfig_remote_netmask, tun_mtu, top);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(out, sizeof(out)=
, &quot;%s %s %d %s&quot;, ifconfig_local,</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+             ifconfig_remote_netmask, tun_mtu, top);=
</span><br><span>     management_android_control(management, &quot;IFCONFIG=
&quot;, out);</span><br><span> </span><br><span> #elif defined(TARGET_SOLAR=
IS)</span><br><span>@@ -1912,7 +1912,7 @@</span><br><span>          */</spa=
n><br><span>         if (dev_node)</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            openvpn_snprintf(tunnam=
e, sizeof(tunname), &quot;%s&quot;, dev_node);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            snprintf(tunname, sizeof(tunname), &=
quot;%s&quot;, dev_node);</span><br><span>         }</span><br><span>      =
   else</span><br><span>         {</span><br><span>@@ -1926,10 +1926,10 @@<=
/span><br><span>             {</span><br><span>                 for (int i =
=3D 0; i &lt; 256; ++i)</span><br><span>                 {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    openvpn_snprintf(t=
unname, sizeof(tunname),</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                                     &quot;/dev/%s%d&quot;, dev, i);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    openv=
pn_snprintf(dynamic_name, sizeof(dynamic_name),</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                                     &quot;%s%d&q=
uot;, dev, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               snprintf(tunname, sizeof(tunname),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                             &quot;/dev/%s%d&=
quot;, dev, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                snprintf(dynamic_name, sizeof(dynamic_name),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                             &quot=
;%s%d&quot;, dev, i);</span><br><span>                     if ((tt-&gt;fd =
=3D open(tunname, O_RDWR)) &gt; 0)</span><br><span>                     {</=
span><br><span>                         dynamic_opened =3D true;</span><br>=
<span>@@ -1947,7 +1947,7 @@</span><br><span>              */</span><br><spa=
n>             else</span><br><span>             {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                openvpn_snprintf(tunname, size=
of(tunname), &quot;/dev/%s&quot;, dev);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                snprintf(tunname, sizeof(tunname), &quo=
t;/dev/%s&quot;, dev);</span><br><span>             }</span><br><span>     =
    }</span><br><span> </span><br><span>@@ -2002,8 +2002,8 @@</span><br><sp=
an>     {</span><br><span>         for (int i =3D 0; i &lt; 256; ++i)</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            openvpn_snprintf(dynamic_name, sizeof(dynamic_name),</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                             &qu=
ot;%s%d&quot;, dev, i);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            snprintf(dynamic_name, sizeof(dynamic_name),</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                     &quot;%s%d&qu=
ot;, dev, i);</span><br><span>             int ret =3D open_tun_dco(tt, ctx=
, dynamic_name);</span><br><span>             if (ret =3D=3D 0)</span><br><=
span>             {</span><br><span>@@ -2519,7 +2519,7 @@</span><br><span> =
    tt-&gt;actual_name =3D (char *) malloc(32);</span><br><span>     check_=
malloc_return(tt-&gt;actual_name);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_snprintf(tt-&gt;actual_name, 32=
, &quot;%s%d&quot;, dev_tuntap_type, ppa);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    snprintf(tt-&gt;actual_name, 32, &quot;%s%d&quot=
;, dev_tuntap_type, ppa);</span><br><span> </span><br><span>     if (tt-&gt=
;type =3D=3D DEV_TYPE_TAP)</span><br><span>     {</span><br><span>@@ -3509,=
7 +3509,7 @@</span><br><span>         int i;</span><br><span>         for (=
i =3D 0; i&lt;99; i++)</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            openvpn_snprintf(tunname, sizeof(tu=
nname), &quot;/dev/tap%d&quot;, i);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            snprintf(tunname, sizeof(tunname), &quot;/dev/t=
ap%d&quot;, i);</span><br><span>             if (access( tunname, F_OK ) &l=
t; 0 &amp;&amp; errno =3D=3D ENOENT)</span><br><span>             {</span><=
br><span>                 break;</span><br><span>@@ -3520,7 +3520,7 @@</spa=
n><br><span>             msg( M_FATAL, &quot;cannot find unused tap device&=
quot; );</span><br><span>         }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf( dynamic_name, siz=
eof(dynamic_name), &quot;tap%d&quot;, i );</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        snprintf( dynamic_name, sizeof(dynamic_name)=
, &quot;tap%d&quot;, i );</span><br><span>         dev =3D dynamic_name;</s=
pan><br><span>     }</span><br><span>     else                             =
           /* name given, sanity check */</span><br><span>@@ -3536,7 +3536,=
7 @@</span><br><span>             msg( M_FATAL, &quot;TAP device name must =
be &#39;--dev tapNNNN&#39;&quot; );</span><br><span>         }</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_=
snprintf(tunname, sizeof(tunname), &quot;/dev/%s&quot;, dev);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        snprintf(tunname, sizeof(=
tunname), &quot;/dev/%s&quot;, dev);</span><br><span>     }</span><br><span=
> </span><br><span>     /* pre-existing device?</span><br><span>@@ -3956,8 =
+3956,8 @@</span><br><span>                 ADAPTER_KEY);</span><br><span> =
        }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        openvpn_snprintf(unit_string, sizeof(unit_string), &quot;%s\\=
%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
             ADAPTER_KEY, enum_name);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        snprintf(unit_string, sizeof(unit_string), &quot;=
%s\\%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
           ADAPTER_KEY, enum_name);</span><br><span> </span><br><span>     =
    status =3D RegOpenKeyEx(</span><br><span>             HKEY_LOCAL_MACHIN=
E,</span><br><span>@@ -4098,9 +4098,9 @@</span><br><span>                 N=
ETWORK_CONNECTIONS_KEY);</span><br><span>         }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(co=
nnection_string, sizeof(connection_string),</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                         &quot;%s\\%s\\Connection&quo=
t;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
       NETWORK_CONNECTIONS_KEY, enum_name);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        snprintf(connection_string, sizeof(connecti=
on_string),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
         &quot;%s\\%s\\Connection&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                 NETWORK_CONNECTIONS_KEY, enum_name);<=
/span><br><span> </span><br><span>         status =3D RegOpenKeyEx(</span><=
br><span>             HKEY_LOCAL_MACHINE,</span><br><span>@@ -4984,7 +4984,=
7 @@</span><br><span>     DWORD index;</span><br><span>     ULONG aindex;</=
span><br><span>     wchar_t wbuf[256];</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    openvpn_swprintf(wbuf, SIZE(wbuf), L&quot;\\DEVICE\\TC=
PIP_%hs&quot;, guid);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    swprintf(wbuf, SIZE(wbuf), L&quot;\\DEVICE\\TCPIP_%hs&quot;, guid);</=
span><br><span>     if (GetAdapterIndex(wbuf, &amp;aindex) !=3D NO_ERROR)</=
span><br><span>     {</span><br><span>         index =3D TUN_ADAPTER_INDEX_=
INVALID;</span><br><span>@@ -5164,10 +5164,10 @@</span><br><span>         }=
</span><br><span> </span><br><span>         /* Open Windows TAP-Windows ada=
pter */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvp=
n_snprintf(device_path, sizeof(device_path), &quot;%s%s%s&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                         USERMOD=
EDEVICEDIR,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
               device_guid,</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                         TAP_WIN_SUFFIX);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        snprintf(device_path, sizeof(device_pat=
h), &quot;%s%s%s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                 USERMODEDEVICEDIR,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                 device_guid,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                 TAP_WIN_SUFFIX);</span><br><=
span> </span><br><span>         hand =3D CreateFile(</span><br><span>      =
       device_path,</span><br><span>@@ -5208,10 +5208,10 @@</span><br><span=
>             }</span><br><span> </span><br><span>             /* Open Wind=
ows TAP-Windows adapter */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            openvpn_snprintf(device_path, sizeof(device_path), &quot;%=
s%s%s&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
                    USERMODEDEVICEDIR,</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                             device_guid,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                             TAP_WIN_S=
UFFIX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
snprintf(device_path, sizeof(device_path), &quot;%s%s%s&quot;,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                     USERMODEDEV=
ICEDIR,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
         device_guid,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                     TAP_WIN_SUFFIX);</span><br><span> </span><br><span> =
            hand =3D CreateFile(</span><br><span>                 device_pa=
th,</span><br><span>@@ -6607,10 +6607,10 @@</span><br><span>     else</span=
><br><span>     {</span><br><span>         /* Open TAP-Windows */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(tuntap=
_device_path, sizeof(tuntap_device_path), &quot;%s%s%s&quot;,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                         USERMODEDE=
VICEDIR,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
            device_guid,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                         TAP_WIN_SUFFIX);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        snprintf(tuntap_device_path, sizeof(tuntap=
_device_path), &quot;%s%s%s&quot;,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                 USERMODEDEVICEDIR,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                 device_guid,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                 TAP_WIN_SUFFIX);<=
/span><br><span>         path =3D tuntap_device_path;</span><br><span>     =
}</span><br><span> </span><br><span>diff --git a/src/openvpn/win32.c b/src/=
openvpn/win32.c</span><br><span>index 27d82c5..98955ba 100644</span><br><sp=
an>--- a/src/openvpn/win32.c</span><br><span>+++ b/src/openvpn/win32.c</spa=
n><br><span>@@ -885,8 +885,8 @@</span><br><span>     char force_path[256];<=
/span><br><span>     char *sysroot =3D get_win_sys_path();</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!openvpn_snp=
rintf(force_path, sizeof(force_path), &quot;PATH=3D%s\\System32;%s;%s\\Syst=
em32\\Wbem&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                      sysroot, sysroot, sysroot))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!snprintf(force_path, sizeof(force_pa=
th), &quot;PATH=3D%s\\System32;%s;%s\\System32\\Wbem&quot;,</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                  sysroot, sysroot,=
 sysroot))</span><br><span>     {</span><br><span>         msg(M_WARN, &quo=
t;env_block: default path truncated to %s&quot;, force_path);</span><br><sp=
an>     }</span><br><span>@@ -1483,26 +1483,11 @@</span><br><span> }</span>=
<br><span> </span><br><span> bool</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-openvpn_swprintf(wchar_t *const str, const size_t size, const w=
char_t *const format, ...)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    va_list arg=
list;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int len =3D =
-1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (size &gt; =
0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        va_start(arglist, format);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        len =3D vswpri=
ntf(str, size, format, arglist);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        va_end(arglist);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        str[size - 1] =3D L&#39;\0&#39;;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return (len &gt;=3D 0 &amp;&amp; len &lt; size);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-bool</span><br><span> get_openvpn_reg_value(const WCHAR *key, WCHAR =
*value, DWORD size)</span><br><span> {</span><br><span>     WCHAR reg_path[=
256];</span><br><span>     HKEY hkey;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    openvpn_swprintf(reg_path, _countof(reg_path), L&quot;S=
OFTWARE\\&quot; PACKAGE_NAME);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    swprintf(reg_path, _countof(reg_path), L&quot;SOFTWARE\\&quo=
t; PACKAGE_NAME);</span><br><span> </span><br><span>     LONG status =3D Re=
gOpenKeyExW(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &amp;hkey);</span><b=
r><span>     if (status !=3D ERROR_SUCCESS)</span><br><span>@@ -1528,7 +151=
3,7 @@</span><br><span>         /* if we cannot find installation path from=
 the registry,</span><br><span>          * use Windows directory as a fallb=
ack</span><br><span>          */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        openvpn_swprintf(install_path, _countof(install_path), L=
&quot;%ls&quot;, ssl_fallback_dir);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        swprintf(install_path, _countof(install_path), L&qu=
ot;%ls&quot;, ssl_fallback_dir);</span><br><span>     }</span><br><span> </=
span><br><span>     if ((install_path[wcslen(install_path) - 1]) =3D=3D L&#=
39;\\&#39;)</span><br><span>@@ -1553,7 +1538,7 @@</span><br><span>         =
if (size =3D=3D 0)</span><br><span>         {</span><br><span>             =
WCHAR val[MAX_PATH] =3D {0};</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            openvpn_swprintf(val, _countof(val), L&quot;%ls\\ssl\\%l=
s&quot;, install_path, ossl_env[i].value);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            swprintf(val, _countof(val), L&quot;%ls\=
\ssl\\%ls&quot;, install_path, ossl_env[i].value);</span><br><span>        =
     _wputenv_s(ossl_env[i].name, val);</span><br><span>         }</span><b=
r><span>     }</span><br><span>diff --git a/src/openvpn/win32.h b/src/openv=
pn/win32.h</span><br><span>index 974fe02d..fd75992 100644</span><br><span>-=
-- a/src/openvpn/win32.h</span><br><span>+++ b/src/openvpn/win32.h</span><b=
r><span>@@ -319,14 +319,6 @@</span><br><span> int</span><br><span> openvpn_=
execve(const struct argv *a, const struct env_set *es, const unsigned int f=
lags);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * openvpn_swpri=
ntf() is currently only used by Windows code paths</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">- * and when enabled for all platforms it will =
currently break older</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * OpenBSD versions lacking vswprintf(3) support in their libc.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-bool</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_=
t *const format, ...);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> /* Sleep that can be interrupted by signals and exit eve=
nt */</span><br><span> void win32_sleep(const int n);</span><br><span> </sp=
an><br><span>diff --git a/src/openvpn/xkey_helper.c b/src/openvpn/xkey_help=
er.c</span><br><span>index c803323..283c95d 100644</span><br><span>--- a/sr=
c/openvpn/xkey_helper.c</span><br><span>+++ b/src/openvpn/xkey_helper.c</sp=
an><br><span>@@ -205,7 +205,7 @@</span><br><span>         }</span><br><span=
>         else</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            openvpn_snprintf(alg_str, sizeof(alg_str), =
&quot;ECDSA,hashalg=3D%s&quot;, alg.mdname);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            snprintf(alg_str, sizeof(alg_str), &qu=
ot;ECDSA,hashalg=3D%s&quot;, alg.mdname);</span><br><span>         }</span>=
<br><span>     }</span><br><span>     else if (!strcmp(alg.keytype, &quot;E=
D448&quot;) || !strcmp(alg.keytype, &quot;ED25519&quot;))</span><br><span>@=
@ -229,8 +229,8 @@</span><br><span>         /* For undigested message, add =
hashalg=3Ddigest parameter */</span><br><span>         else</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  openvpn_snprintf(alg_str, sizeof(alg_str), &quot;%s,hashalg=3D%s&quot;,</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
      &quot;RSA_PKCS1_PADDING&quot;, alg.mdname);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            snprintf(alg_str, sizeof(alg_str)=
, &quot;%s,hashalg=3D%s&quot;,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                     &quot;RSA_PKCS1_PADDING&quot;, alg.mdname);=
</span><br><span>         }</span><br><span>     }</span><br><span>     els=
e if (!strcmp(alg.padmode, &quot;none&quot;) &amp;&amp; (flags &amp; MF_EXT=
ERNAL_KEY_NOPADDING)</span><br><span>@@ -240,8 +240,8 @@</span><br><span>  =
   }</span><br><span>     else if (!strcmp(alg.padmode, &quot;pss&quot;) &a=
mp;&amp; (flags &amp; MF_EXTERNAL_KEY_PSSPAD))</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(al=
g_str, sizeof(alg_str), &quot;%s,hashalg=3D%s,saltlen=3D%s&quot;,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                         &quot;=
RSA_PKCS1_PSS_PADDING&quot;, alg.mdname, alg.saltlen);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        snprintf(alg_str, sizeof(alg_str=
), &quot;%s,hashalg=3D%s,saltlen=3D%s&quot;,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                 &quot;RSA_PKCS1_PSS_PADDING&quot;=
, alg.mdname, alg.saltlen);</span><br><span>     }</span><br><span>     els=
e</span><br><span>     {</span><br><span>diff --git a/src/openvpnserv/commo=
n.c b/src/openvpnserv/common.c</span><br><span>index bd0a484..96bf800 10064=
4</span><br><span>--- a/src/openvpnserv/common.c</span><br><span>+++ b/src/=
openvpnserv/common.c</span><br><span>@@ -27,36 +27,6 @@</span><br><span> LP=
CTSTR service_instance =3D TEXT(&quot;&quot;);</span><br><span> static wcha=
r_t win_sys_path[MAX_PATH];</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * These are necessary due to certain buggy implementations of (v)snpr=
intf,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * that don&#39;=
t guarantee null termination for size &gt; 0.</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-BOOL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-openvpn_vsw=
printf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    int len =3D -1;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (size &gt; 0)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        len =3D vswprintf_s(str, size, format, arglist);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        str[size - 1] =3D 0;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return (len &gt;=3D 0 &amp;&amp; (size_=
t)len &lt; size);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-BOOL</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-openvpn_swprintf(LPTSTR str, size_t size, LPCTSTR format, ..=
.)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    va_list arglist;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    BOOL res =3D FALSE;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (size &gt; 0)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        va_start(arglist, format);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        res =3D openvpn_vswprintf(str, siz=
e, format, arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       va_end(arglist);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return res=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static DWORD</span><br=
><span> GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCT=
STR default_value)</span><br><span> {</span><br><span>@@ -66,7 +36,7 @@</sp=
an><br><span>     if (status =3D=3D ERROR_FILE_NOT_FOUND &amp;&amp; default=
_value)</span><br><span>     {</span><br><span>         size_t len =3D size=
/sizeof(data[0]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (openvpn_swprintf(data, len, default_value))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (swprintf(data, len, default_v=
alue))</span><br><span>         {</span><br><span>             status =3D E=
RROR_SUCCESS;</span><br><span>         }</span><br><span>@@ -93,7 +63,7 @@<=
/span><br><span>     TCHAR install_path[MAX_PATH];</span><br><span>     TCH=
AR default_value[MAX_PATH];</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    openvpn_swprintf(reg_path, _countof(reg_path), =
TEXT(&quot;SOFTWARE\\&quot; PACKAGE_NAME &quot;%ls&quot;), service_instance=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(reg_=
path, _countof(reg_path), TEXT(&quot;SOFTWARE\\&quot; PACKAGE_NAME &quot;%l=
s&quot;), service_instance);</span><br><span> </span><br><span>     LONG st=
atus =3D RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &amp;key);=
</span><br><span>     if (status !=3D ERROR_SUCCESS)</span><br><span>@@ -11=
0,15 +80,15 @@</span><br><span>         goto out;</span><br><span>     }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    op=
envpn_swprintf(default_value, _countof(default_value), TEXT(&quot;%ls\\bin\=
\openvpn.exe&quot;),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                    install_path);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    swprintf(default_value, _countof(default_value), TEXT(&q=
uot;%ls\\bin\\openvpn.exe&quot;),</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+             install_path);</span><br><span>     error =3D Ge=
tRegString(key, TEXT(&quot;exe_path&quot;), s-&gt;exe_path, sizeof(s-&gt;ex=
e_path), default_value);</span><br><span>     if (error !=3D ERROR_SUCCESS)=
</span><br><span>     {</span><br><span>         goto out;</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    openvpn_swprintf(default_value, _countof(default_value), TEXT(&quot;=
%ls\\config&quot;), install_path);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    swprintf(default_value, _countof(default_value), TEXT(&q=
uot;%ls\\config&quot;), install_path);</span><br><span>     error =3D GetRe=
gString(key, TEXT(&quot;config_dir&quot;), s-&gt;config_dir, sizeof(s-&gt;c=
onfig_dir),</span><br><span>                          default_value);</span=
><br><span>     if (error !=3D ERROR_SUCCESS)</span><br><span>@@ -133,7 +10=
3,7 @@</span><br><span>         goto out;</span><br><span>     }</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_sw=
printf(default_value, _countof(default_value), TEXT(&quot;%ls\\log&quot;), =
install_path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
wprintf(default_value, _countof(default_value), TEXT(&quot;%ls\\log&quot;),=
 install_path);</span><br><span>     error =3D GetRegString(key, TEXT(&quot=
;log_dir&quot;), s-&gt;log_dir, sizeof(s-&gt;log_dir), default_value);</spa=
n><br><span>     if (error !=3D ERROR_SUCCESS)</span><br><span>     {</span=
><br><span>@@ -229,7 +199,7 @@</span><br><span>     else</span><br><span>  =
   {</span><br><span>         tmp[wcslen(tmp) - 2] =3D TEXT(&#39;\0&#39;); =
/* remove CR/LF characters */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        openvpn_swprintf(buf, _countof(buf), TEXT(&quot;%ls (0x%x)&=
quot;), tmp, error);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        swprintf(buf, _countof(buf), TEXT(&quot;%ls (0x%x)&quot;), tmp, er=
ror);</span><br><span>     }</span><br><span> </span><br><span>     if (tmp=
)</span><br><span>@@ -259,12 +229,12 @@</span><br><span>     hEventSource =
=3D RegisterEventSource(NULL, APPNAME);</span><br><span>     if (hEventSour=
ce !=3D NULL)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        openvpn_swprintf(msg[0], _countof(msg[0]),</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                         TEXT(&=
quot;%ls%ls%ls: %ls&quot;), APPNAME, service_instance,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                         (flags &amp; MSG_=
FLAGS_ERROR) ? TEXT(&quot; error&quot;) : TEXT(&quot;&quot;), err_msg);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        swprintf(msg[0]=
, _countof(msg[0]),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 TEXT(&quot;%ls%ls%ls: %ls&quot;), APPNAME, service_instanc=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
(flags &amp; MSG_FLAGS_ERROR) ? TEXT(&quot; error&quot;) : TEXT(&quot;&quot=
;), err_msg);</span><br><span> </span><br><span>         va_start(arglist, =
format);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        openv=
pn_vswprintf(msg[1], _countof(msg[1]), format, arglist);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        vswprintf(msg[1], _countof(msg=
[1]), format, arglist);</span><br><span>         va_end(arglist);</span><br=
><span> </span><br><span>         const TCHAR *mesg[] =3D { msg[0], msg[1] =
};</span><br><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpn=
serv/interactive.c</span><br><span>index d32223c..294db00 100644</span><br>=
<span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpn=
serv/interactive.c</span><br><span>@@ -311,7 +311,7 @@</span><br><span>    =
  * Same format as error messages (3 line string) with error =3D 0 in</span=
><br><span>      * 0x%08x format, PID on line 2 and a description &quot;Pro=
cess ID&quot; on line 3</span><br><span>      */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    openvpn_swprintf(buf, _countof(buf), L&quot;=
0x%08x\n0x%08x\n%ls&quot;, 0, pid, msg);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    swprintf(buf, _countof(buf), L&quot;0x%08x\n0x%08x=
\n%ls&quot;, 0, pid, msg);</span><br><span> </span><br><span>     WritePipe=
Async(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);</span><br><span>=
 }</span><br><span>@@ -385,9 +385,9 @@</span><br><span> </span><br><span>  =
   if (!argv)</span><br><span>     {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        openvpn_swprintf(errmsg, capacity,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                         L&quot;Cannot =
validate options: CommandLineToArgvW failed with error =3D 0x%08x&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
 GetLastError());</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      swprintf(errmsg, capacity,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                 L&quot;Cannot validate options: CommandLineTo=
ArgvW failed with error =3D 0x%08x&quot;,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                 GetLastError());</span><br><span>   =
      goto out;</span><br><span>     }</span><br><span> </span><br><span>@@=
 -407,8 +407,8 @@</span><br><span> </span><br><span>         if (!CheckOpti=
on(workdir, 2, argv_tmp, &amp;settings))</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            openvpn_swprintf(=
errmsg, capacity, msg1, argv[0], workdir,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                             settings.ovpn_admin_group)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            swprin=
tf(errmsg, capacity, msg1, argv[0], workdir,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                     settings.ovpn_admin_group);</=
span><br><span>         }</span><br><span>         goto out;</span><br><spa=
n>     }</span><br><span>@@ -424,13 +424,13 @@</span><br><span>         {</=
span><br><span>             if (wcscmp(L&quot;--config&quot;, argv[i]) =3D=
=3D 0 &amp;&amp; argc-i &gt; 1)</span><br><span>             {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                openvpn_swprintf(e=
rrmsg, capacity, msg1, argv[i+1], workdir,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                                 settings.ovpn_admin_g=
roup);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   swprintf(errmsg, capacity, msg1, argv[i+1], workdir,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                         settings.ovpn_=
admin_group);</span><br><span>             }</span><br><span>             e=
lse</span><br><span>             {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                openvpn_swprintf(errmsg, capacity, msg2, argv[=
i],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  =
               settings.ovpn_admin_group);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                swprintf(errmsg, capacity, msg2, arg=
v[i],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
           settings.ovpn_admin_group);</span><br><span>             }</span=
><br><span>             goto out;</span><br><span>         }</span><br><spa=
n>@@ -985,7 +985,7 @@</span><br><span> </span><br><span>     HANDLE wait_ha=
ndles[2] =3D {rdns_semaphore, exit_event};</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    openvpn_swprintf(ipcfg, MAX_PATH=
, L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;ipconfig.exe&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(ipcfg, MA=
X_PATH, L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;ipconfig.exe&quot=
;);</span><br><span> </span><br><span>     if (WaitForMultipleObjects(2, wa=
it_handles, FALSE, timeout) =3D=3D WAIT_OBJECT_0)</span><br><span>     {</s=
pan><br><span>@@ -1064,7 +1064,7 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     /* Path of netsh */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    openvpn_swprintf(argv0, _countof(argv0), L&quot;%l=
s\\%ls&quot;, get_win_sys_path(), L&quot;netsh.exe&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    swprintf(argv0, _countof(argv0),=
 L&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;netsh.exe&quot;);</span>=
<br><span> </span><br><span>     /* cmd template:</span><br><span>      * n=
etsh interface $proto $action dns $if_name $addr [validate=3Dno]</span><br>=
<span>@@ -1080,7 +1080,7 @@</span><br><span>         goto out;</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    openvpn_swprintf(cmdline, ncmdline, fmt, proto, action, if_name,=
 addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf=
(cmdline, ncmdline, fmt, proto, action, if_name, addr);</span><br><span> </=
span><br><span>     if (IsWindows7OrGreater())</span><br><span>     {</span=
><br><span>@@ -1124,7 +1124,7 @@</span><br><span>     }</span><br><span> </=
span><br><span>     /* Path of netsh */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    openvpn_swprintf(argv0, _countof(argv0), L&quot;%ls\\=
%ls&quot;, get_win_sys_path(), L&quot;netsh.exe&quot;);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    swprintf(argv0, _countof(argv0), L&=
quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;netsh.exe&quot;);</span><br=
><span> </span><br><span>     /* cmd template:</span><br><span>      * nets=
h interface ip $action wins $if_name $static $addr</span><br><span>@@ -1141=
,7 +1141,7 @@</span><br><span>         goto out;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ope=
nvpn_swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static, addr);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(cmdline=
, ncmdline, fmt, action, if_name, addr_static, addr);</span><br><span> </sp=
an><br><span>     err =3D ExecCommand(argv0, cmdline, timeout);</span><br><=
span> </span><br><span>@@ -1167,7 +1167,7 @@</span><br><span>     wchar_t *=
cmdline =3D NULL;</span><br><span>     int timeout =3D 10000; /* in msec */=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 openvpn_swprintf(argv0, _countof(argv0), L&quot;%ls\\%ls&quot;, get_win_sy=
s_path(), L&quot;wbem\\wmic.exe&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    swprintf(argv0, _countof(argv0), L&quot;%ls\\%ls&qu=
ot;, get_win_sys_path(), L&quot;wbem\\wmic.exe&quot;);</span><br><span> </s=
pan><br><span>     const wchar_t *fmt;</span><br><span>     /* comma separa=
ted list must be enclosed in parenthesis */</span><br><span>@@ -1188,8 +118=
8,8 @@</span><br><span>         return ERROR_OUTOFMEMORY;</span><br><span> =
    }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    openvpn_swprintf(cmdline, ncmdline, fmt, if_index, action,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                     data ? data=
 : L&quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   swprintf(cmdline, ncmdline, fmt, if_index, action,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             data ? data : L&quot;&quot;)=
;</span><br><span>     err =3D ExecCommand(argv0, cmdline, timeout);</span>=
<br><span> </span><br><span>     free(cmdline);</span><br><span>@@ -1453,7 =
+1453,7 @@</span><br><span>     wchar_t argv0[MAX_PATH];</span><br><span> <=
/span><br><span>     /* Path of netsh */</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    openvpn_swprintf(argv0, _countof(argv0), L&quot;%ls\=
\%ls&quot;, get_win_sys_path(), L&quot;netsh.exe&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    swprintf(argv0, _countof(argv0), L=
&quot;%ls\\%ls&quot;, get_win_sys_path(), L&quot;netsh.exe&quot;);</span><b=
r><span> </span><br><span>     /* cmd template:</span><br><span>      * net=
sh interface ipv4 set address name=3D$if_index source=3Ddhcp</span><br><spa=
n>@@ -1471,7 +1471,7 @@</span><br><span>         return err;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    openvpn_swprintf(cmdline, ncmdline, fmt, dhcp-&gt;iface.index);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    swprintf(cmdline, =
ncmdline, fmt, dhcp-&gt;iface.index);</span><br><span> </span><br><span>   =
  err =3D ExecCommand(argv0, cmdline, timeout);</span><br><span> </span><br=
><span>@@ -1970,8 +1970,8 @@</span><br><span>         goto out;</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    openvpn_swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                     TEXT(=
&quot;\\\\.\\pipe\\&quot; PACKAGE &quot;%ls\\service_%lu&quot;), service_in=
stance, GetCurrentThreadId());</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+             TEXT(&quot;\\\\.=
\\pipe\\&quot; PACKAGE &quot;%ls\\service_%lu&quot;), service_instance, Get=
CurrentThreadId());</span><br><span>     ovpn_pipe =3D CreateNamedPipe(ovpn=
_pipe_name,</span><br><span>                                 PIPE_ACCESS_DU=
PLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,</span><br><spa=
n>                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAG=
E | PIPE_WAIT, 1, 128, 128, 0, NULL);</span><br><span>@@ -2003,8 +2003,11 @=
@</span><br><span>         ReturnLastError(pipe, L&quot;malloc&quot;);</spa=
n><br><span>         goto out;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    openvpn_swprintf(cmdline, cmdline_size,=
 L&quot;openvpn %ls --msg-channel %&quot; PRIuPTR,</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                     sud.options, svc_pipe);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* there seem to =
be no common printf specifier that works on all</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * mingw/msvc platforms without trickery, s=
o convert to void* and use</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * PRIuPTR to print that as best compromise */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    swprintf(cmdline, cmdline_size, L=
&quot;openvpn %ls --msg-channel %&quot; PRIuPTR,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             sud.options, (uintptr_t)svc_pipe)=
;</span><br><span> </span><br><span>     if (!CreateEnvironmentBlock(&amp;u=
ser_env, imp_token, FALSE))</span><br><span>     {</span><br><span>@@ -2079=
,8 +2082,8 @@</span><br><span>     else if (exit_code !=3D 0)</span><br><sp=
an>     {</span><br><span>         WCHAR buf[256];</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        openvpn_swprintf(buf, _countof(buf),</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                       =
  L&quot;OpenVPN exited with error: exit code =3D %lu&quot;, exit_code);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        swprintf(buf, =
_countof(buf),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
            L&quot;OpenVPN exited with error: exit code =3D %lu&quot;, exit=
_code);</span><br><span>         ReturnError(pipe, ERROR_OPENVPN_STARTUP, b=
uf, 1, &amp;exit_event);</span><br><span>     }</span><br><span>     Undo(&=
amp;undo_lists);</span><br><span>@@ -2174,7 +2177,7 @@</span><br><span>    =
     initialized =3D TRUE;</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_swprintf(pipe_nam=
e, _countof(pipe_name), TEXT(&quot;\\\\.\\pipe\\&quot; PACKAGE &quot;%ls\\s=
ervice&quot;), service_instance);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    swprintf(pipe_name, _countof(pipe_name), TEXT(&quot;\\\\.=
\\pipe\\&quot; PACKAGE &quot;%ls\\service&quot;), service_instance);</span>=
<br><span>     pipe =3D CreateNamedPipe(pipe_name, flags,</span><br><span> =
                           PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE=
_REJECT_REMOTE_CLIENTS,</span><br><span>                            PIPE_UN=
LIMITED_INSTANCES, 1024, 1024, 0, NULL);</span><br><span>diff --git a/src/o=
penvpnserv/service.h b/src/openvpnserv/service.h</span><br><span>index 3acf=
08c..6d0827d 100644</span><br><span>--- a/src/openvpnserv/service.h</span><=
br><span>+++ b/src/openvpnserv/service.h</span><br><span>@@ -81,12 +81,6 @@=
</span><br><span> </span><br><span> VOID WINAPI ServiceStartInteractive(DWO=
RD argc, LPTSTR *argv);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-BOOL openvpn_vsntprintf(LPTSTR str, size_t size, LPCTST=
R format, va_list arglist);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-BOOL openvpn_sn=
tprintf(LPTSTR str, size_t size, LPCTSTR format, ...);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-BOOL openvpn_swprintf(wchar_t *const str, const size_t size, co=
nst wchar_t *const format, ...);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> DWORD GetOpenvpnSettings(settings_t *s);</span=
><br><span> </span><br><span> BOOL ReportStatusToSCMgr(SERVICE_STATUS_HANDL=
E service, SERVICE_STATUS *status);</span><br><span>diff --git a/src/openvp=
nserv/validate.c b/src/openvpnserv/validate.c</span><br><span>index 5f7acd7=
..9563fa5 100644</span><br><span>--- a/src/openvpnserv/validate.c</span><br=
><span>+++ b/src/openvpnserv/validate.c</span><br><span>@@ -68,7 +68,7 @@</=
span><br><span>     /* convert fname to full path */</span><br><span>     i=
f (PathIsRelativeW(fname) )</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        openvpn_swprintf(tmp, _countof(tmp), L=
&quot;%ls\\%ls&quot;, workdir, fname);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        swprintf(tmp, _countof(tmp), L&quot;%ls\\%ls&quo=
t;, workdir, fname);</span><br><span>         config_file =3D tmp;</span><b=
r><span>     }</span><br><span>     else</span><br><span>diff --git a/tests=
/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c<=
/span><br><span>index 52ffb54..fbfb937 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/test_buffer.c</span><br><span>+++ b/tests/unit_tests/open=
vpn/test_buffer.c</span><br><span>@@ -354,6 +354,56 @@</span><br><span>    =
 assert_string_equal(buf, &quot;There is a .&#39;nice.&#39; \&quot;1234\&qu=
ot; [.] year old .tree!&quot;);</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+test_snprintf(void **state)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* we used to have a custom openvpn_snpr=
intf function because some</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * OS (the comment did not specify which) did not always put the=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * null byte th=
ere. So we unit test this to be sure.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * This probably refers to the MSVC behaviour, see also</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+     * https://stackoverflow.c=
om/questions/7706936/is-snprintf-always-null-terminating</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* Instead of trying to trick the compiler here, disable the warn=
ings</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * for this=
 unit test. We know that the results will be truncated</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * and we want to test that */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(__GNUC__)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+/* some clang version d=
o not understand -Wformat-truncation, so ignore the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * warning to avoid warnings/errors (-Wer=
ror) about unknown pragma/option */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#if defined(__clang__)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#pragma clang diagnostic push</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#pragma clang diagnostic ignored &quot;-Wunkno=
wn-warning-option&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
pragma GCC diagnostic ignored &quot;-Wformat-truncation&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    char buf[10] =3D { &#39;a&#39; };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    int ret =3D 0;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    ret =3D snprintf(buf, sizeof(buf), &quot;0123456789abcde&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(ret, 15);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_int_equal(buf[9], &#39;\0&#39;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  memset(buf, &#39;b&#39;, sizeof(buf));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ret =3D snprintf(buf, sizeof(buf), &quot;- %d - %d=
 -&quot;, 77, 88);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(ret, 11);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(buf[9], &#39;\0&#39;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    memset(buf, &#39;c&#39;, sizeof(buf));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    ret =3D snprintf(buf, sizeof(buf)=
, &quot;- %8.2f&quot;, 77.8899);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_int_equal(ret, 10);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_int_equal(buf[9], &#39;\0&#39;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#if defined(__GNUC__)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic pop</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#if defined(__clang__)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#pragma clang diagnostic pop</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> int</span><br><span> main(void)</span><br><span> {<=
/span><br><span>@@ -387,6 +437,7 @@</span><br><span>         cmocka_unit_te=
st(test_buffer_free_gc_two),</span><br><span>         cmocka_unit_test(test=
_buffer_gc_realloc),</span><br><span>         cmocka_unit_test(test_charact=
er_class),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
mocka_unit_test(test_snprintf)</span><br><span>     };</span><br><span> </s=
pan><br><span>     return cmocka_run_group_tests_name(&quot;buffer&quot;, t=
ests, NULL, NULL);</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c</span><br><span>=
index 87f6208..98102ef 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_cryptoapi.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_cryp=
toapi.c</span><br><span>@@ -271,7 +271,7 @@</span><br><span> </span><br><sp=
an>     for (struct test_cert *c =3D certs; c-&gt;cert; c++)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        openv=
pn_snprintf(select_string, sizeof(select_string), &quot;THUMB:%s&quot;, c-&=
gt;hash);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sn=
printf(select_string, sizeof(select_string), &quot;THUMB:%s&quot;, c-&gt;ha=
sh);</span><br><span>         ctx =3D find_certificate_in_store(select_stri=
ng, user_store);</span><br><span>         if (ctx)</span><br><span>        =
 {</span><br><span>@@ -304,7 +304,7 @@</span><br><span> </span><br><span>  =
   for (struct test_cert *c =3D certs; c-&gt;cert; c++)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_sn=
printf(select_string, sizeof(select_string), &quot;SUBJ:%s&quot;, c-&gt;cna=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprint=
f(select_string, sizeof(select_string), &quot;SUBJ:%s&quot;, c-&gt;cname);<=
/span><br><span>         ctx =3D find_certificate_in_store(select_string, u=
ser_store);</span><br><span>         /* In this case we expect a successful=
 return as there is at least one valid</span><br><span>          * cert tha=
t matches the common name. But the returned cert may not exactly match</spa=
n><br><span>@@ -337,7 +337,7 @@</span><br><span> </span><br><span>     for =
(struct test_cert *c =3D certs; c-&gt;cert; c++)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        openvpn_snprintf(=
select_string, sizeof(select_string), &quot;ISSUER:%s&quot;, c-&gt;issuer);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        snprintf(se=
lect_string, sizeof(select_string), &quot;ISSUER:%s&quot;, c-&gt;issuer);</=
span><br><span>         ctx =3D find_certificate_in_store(select_string, us=
er_store);</span><br><span>         /* In this case we expect a successful =
return as there is at least one valid</span><br><span>          * cert that=
 matches the issuer. But the returned cert may not exactly match</span><br>=
<span>@@ -411,7 +411,7 @@</span><br><span>         {</span><br><span>      =
       continue;</span><br><span>         }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        openvpn_snprintf(select_string, sizeof(select=
_string), &quot;THUMB:%s&quot;, c-&gt;hash);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        snprintf(select_string, sizeof(select_stri=
ng), &quot;THUMB:%s&quot;, c-&gt;hash);</span><br><span>         if (Load_C=
ryptoAPI_certificate(select_string, &amp;x509, &amp;privkey) !=3D 1)</span>=
<br><span>         {</span><br><span>             fail_msg(&quot;Load_Crypt=
oAPI_certificate failed: &lt;%s&gt;&quot;, c-&gt;friendly_name);</span><br>=
<span>@@ -446,7 +446,7 @@</span><br><span>         SSL_CTX *ssl_ctx =3D SSL=
_CTX_new_ex(tls_libctx, NULL, SSLv23_client_method());</span><br><span>    =
     assert_non_null(ssl_ctx);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        openvpn_snprintf(select_string, sizeof(s=
elect_string), &quot;THUMB:%s&quot;, c-&gt;hash);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        snprintf(select_string, sizeof(select=
_string), &quot;THUMB:%s&quot;, c-&gt;hash);</span><br><span>         if (!=
SSL_CTX_use_CryptoAPI_certificate(ssl_ctx, select_string))</span><br><span>=
         {</span><br><span>             fail_msg(&quot;SSL_CTX_use_CryptoAP=
I_certificate failed: &lt;%s&gt;&quot;, c-&gt;friendly_name);</span><br><sp=
an>diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/o=
penvpn/test_pkcs11.c</span><br><span>index a48e404..84ebb29 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_pkcs11.c</span><br><span>@@ -161,7 +161,7 @@<=
/span><br><span>     }</span><br><span>     else if (flags &amp; GET_USER_P=
ASS_PASSWORD_ONLY)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        openvpn_snprintf(up-&gt;password, sizeof(up-&gt=
;password), &quot;%s&quot;, PIN);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        snprintf(up-&gt;password, sizeof(up-&gt;password), &q=
uot;%s&quot;, PIN);</span><br><span>     }</span><br><span>     else</span>=
<br><span>     {</span><br><span>@@ -204,8 +204,8 @@</span><br><span>     {=
</span><br><span>         fail_msg(&quot;make tmpfile using template &lt;%s=
&gt; failed (error =3D %d)&quot;, softhsm2_conf_path, errno);</span><br><sp=
an>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    openvpn_=
snprintf(config, sizeof(config), &quot;directories.tokendir=3D%s/&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                     sof=
thsm2_tokens_path);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    snprintf(config, sizeof(config), &quot;directories.tokendir=3D%s/&quot;=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             softh=
sm2_tokens_path);</span><br><span>     assert_int_equal(write(fd, config, s=
trlen(config)), strlen(config));</span><br><span>     close(fd);</span><br>=
<span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/547?usp=3Demail">change 547</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/547?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07096977e3b562bcb5d2c6f1167=
3a4175b8e12ac </div>
<div style=3D"display:none"> Gerrit-Change-Number: 547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--hoL2x7flXcg=--

