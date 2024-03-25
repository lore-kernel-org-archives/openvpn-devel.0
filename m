From: Gert Doering <gert@...1296...>
Date: Mon, 25 Mar 2024 08:16:08 +0100
Message-ID: <20240325071608.13075-1-gert@...1296...>
In-Reply-To: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
References: <gerrit.1711328743000.I07096977e3b562bcb5d2c6f11673a4175b8e12ac@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v1] Remove openvpn_snprintf and similar
 functions
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

From: Arne Schwabe <arne@...1227...>

Old Microsoft versions did strange behaviour but according to the
newly added unit test and
https://stackoverflow.com/questions/7706936/is-snprintf-always-null-terminating
this is now standard conforming and we can use the normal snprintf
method.

Microsoft own documentation to swprintf also says you nowadays need to
define _CRT_NON_CONFORMING_SWPRINTFS to get to non-standard behaviour.

Change-Id: I07096977e3b562bcb5d2c6f11673a4175b8e12ac
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Antonio Quartulli <a@...2181...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/547
This mail reflects revision 1 of this Change.

Signed-off-by line for the author was added as per our policy.

Acked-by according to Gerrit (reflected above):
Antonio Quartulli <a@...2181...>

        
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
-    int len = -1;
-    if (size > 0)
-    {
-        va_start(arglist, format);
-        len = vsnprintf(str, size, format, arglist);
-        va_end(arglist);
-        str[size - 1] = 0;
-    }
-    return (len >= 0 && len < size);
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
index 1a39752..c806719 100644
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
     char header[1000+1] = { 0 };
     char footer[1000+1] = { 0 };
 
-    if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name))
+    if (!snprintf(header, sizeof(header), "-----BEGIN %s-----\n", name))
     {
         return false;
     }
-    if (!openvpn_snprintf(footer, sizeof(footer), "-----END %s-----\n", name))
+    if (!snprintf(footer, sizeof(footer), "-----END %s-----\n", name))
     {
         return false;
     }
@@ -278,11 +278,11 @@
     char header[1000+1] = { 0 };
     char footer[1000+1] = { 0 };
 
-    if (!openvpn_snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
+    if (!snprintf(header, sizeof(header), "-----BEGIN %s-----", name))
     {
         return false;
     }
-    if (!openvpn_snprintf(footer, sizeof(footer), "-----END %s-----", name))
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
-        name_ok = openvpn_snprintf(name, sizeof(name), format, i);
+        name_ok = snprintf(name, sizeof(name), format, i);
     }
     else
     {
-        name_ok = openvpn_snprintf(name, sizeof(name), format, i, j);
+        name_ok = snprintf(name, sizeof(name), format, i, j);
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
     while (NULL != env_set_get(es, tmpname) && counter < 1000)
     {
-        ASSERT(openvpn_snprintf(tmpname, tmpname_len, "%s_%u", name, counter));
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
-        openvpn_snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=%d)",
-                         m1, openvpn_strerror(e, crt_error, &gc), e);
+        snprintf(m2, ERR_BUF_SIZE, "%s: %s (errno=%d)",
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
         const struct virtual_output *vo = msg_get_virtual_output();
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
index f2ce926..bce2e09 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -359,7 +359,7 @@
         char *out = malloc(len);
         check_malloc_return(out);
 
-        openvpn_snprintf(out, len, "%s,%s,%s,%s", ce->remote, ce->remote_port, proto, status);
+        snprintf(out, len, "%s,%s,%s,%s", ce->remote, ce->remote_port, proto, status);
         *remote = out;
     }
     else
diff --git a/src/openvpn/manage.c b/src/openvpn/manage.c
index 43c5507..89591ea 100644
--- a/src/openvpn/manage.c
+++ b/src/openvpn/manage.c
@@ -515,8 +515,8 @@
     char out[32];
 
     /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
-    openvpn_snprintf(in, sizeof(in), counter_format, man->persist.bytes_in + dco_read_bytes);
-    openvpn_snprintf(out, sizeof(out), counter_format, man->persist.bytes_out + dco_write_bytes);
+    snprintf(in, sizeof(in), counter_format, man->persist.bytes_in + dco_read_bytes);
+    snprintf(out, sizeof(out), counter_format, man->persist.bytes_out + dco_write_bytes);
     msg(M_CLIENT, ">BYTECOUNT:%s,%s", in, out);
 }
 
@@ -528,8 +528,8 @@
     char in[32];
     char out[32];
     /* do in a roundabout way to work around possible mingw or mingw-glibc bug */
-    openvpn_snprintf(in, sizeof(in), counter_format, *bytes_in_total);
-    openvpn_snprintf(out, sizeof(out), counter_format, *bytes_out_total);
+    snprintf(in, sizeof(in), counter_format, *bytes_in_total);
+    snprintf(out, sizeof(out), counter_format, *bytes_out_total);
     msg(M_CLIENT, ">BYTECOUNT_CLI:%lu,%s,%s", mdac->cid, in, out);
     mdac->bytecount_last_update = now;
 }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 768332d..a9a44ba 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1427,7 +1427,7 @@
     for (int i = 1; i <= opt_max; ++i)
     {
         char name[32];
-        openvpn_snprintf(name, sizeof(name), "foreign_option_%d", i);
+        snprintf(name, sizeof(name), "foreign_option_%d", i);
 
         const char *env_str = env_set_get(es, name);
         const char *value = strchr(env_str, '=') + 1;
@@ -1482,7 +1482,7 @@
     while (o->foreign_option_index < opt_max)
     {
         char name[32];
-        openvpn_snprintf(name, sizeof(name), "foreign_option_%d", opt_max--);
+        snprintf(name, sizeof(name), "foreign_option_%d", opt_max--);
         setenv_del(es, name);
     }
 }
@@ -5671,8 +5671,8 @@
 #ifndef ENABLE_SMALL
     {
         char script_name[100];
-        openvpn_snprintf(script_name, sizeof(script_name),
-                         "--%s script", type);
+        snprintf(script_name, sizeof(script_name),
+                 "--%s script", type);
 
         if (check_cmd_access(*script, script_name, (in_chroot ? options->chroot_dir : NULL)))
         {
diff --git a/src/openvpn/pkcs11.c b/src/openvpn/pkcs11.c
index 35a02c2..418f6bb 100644
--- a/src/openvpn/pkcs11.c
+++ b/src/openvpn/pkcs11.c
@@ -201,7 +201,7 @@
     CLEAR(token_resp);
     token_resp.defined = false;
     token_resp.nocache = true;
-    openvpn_snprintf(
+    snprintf(
         token_resp.username,
         sizeof(token_resp.username),
         "Please insert %s token",
@@ -245,7 +245,7 @@
 
     ASSERT(token!=NULL);
 
-    openvpn_snprintf(prompt, sizeof(prompt), "%s token", token->label);
+    snprintf(prompt, sizeof(prompt), "%s token", token->label);
 
     token_pass.defined = false;
     token_pass.nocache = true;
@@ -719,7 +719,7 @@
 
         id_resp.defined = false;
         id_resp.nocache = true;
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
 
-        if (!openvpn_snprintf(fname, sizeof(fname), fname_fmt, max_prefix_len,
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
 
-        openvpn_snprintf(full, sizeof(full), "%s/%s", PLUGIN_LIBDIR, p->so_pathname);
+        snprintf(full, sizeof(full), "%s/%s", PLUGIN_LIBDIR, p->so_pathname);
         p->handle = dlopen(full, RTLD_NOW);
     }
     else
@@ -409,7 +409,7 @@
 
         gc_init(&gc);
         msg_fmt = gc_malloc(ERR_BUF_SIZE, false, &gc);
-        openvpn_snprintf(msg_fmt, ERR_BUF_SIZE, "PLUGIN %s: %s", name, format);
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
         cn = NULL;
 #else
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index c904301..8fd4744 100644
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
                 host_header_sent = true;
@@ -592,8 +592,8 @@
         }
         else
         {
-            openvpn_snprintf(buf, sizeof(buf), "%s",
-                             p->options.custom_headers[i].name);
+            snprintf(buf, sizeof(buf), "%s",
+                     p->options.custom_headers[i].name);
             if (!strncasecmp(p->options.custom_headers[i].name, "Host:", 5))
             {
                 host_header_sent = true;
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
-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Authorization: Basic %s",
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
-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Connection: Keep-Alive");
+                snprintf(buf, sizeof(buf), "Proxy-Connection: Keep-Alive");
                 if (!send_line_crlf(sd, buf))
                 {
                     goto error;
                 }
 
-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Authorization: NTLM %s",
-                                 ntlm_phase_1(p, &gc));
+                snprintf(buf, sizeof(buf), "Proxy-Authorization: NTLM %s",
+                         ntlm_phase_1(p, &gc));
                 msg(D_PROXY, "Attempting NTLM Proxy-Authorization phase 1");
                 dmsg(D_SHOW_KEYS, "Send to HTTP proxy: '%s'", buf);
                 if (!send_line_crlf(sd, buf))
@@ -773,7 +773,7 @@
 
                 char get[80];
                 CLEAR(buf2);
-                openvpn_snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2) - 1);
+                snprintf(get, sizeof(get), "%%*s NTLM %%%zus", sizeof(buf2) - 1);
                 nparms = sscanf(buf, get, buf2);
 
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
-            openvpn_snprintf(buf, sizeof(buf), "Proxy-Connection: Keep-Alive");
+            snprintf(buf, sizeof(buf), "Proxy-Connection: Keep-Alive");
             if (!send_line_crlf(sd, buf))
             {
                 goto error;
@@ -829,7 +829,7 @@
                     msg(D_PROXY, "NTLM Proxy-Authorization phase 3 failed: received corrupted data from proxy server");
                     goto error;
                 }
-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Authorization: NTLM %s", np3);
+                snprintf(buf, sizeof(buf), "Proxy-Authorization: NTLM %s", np3);
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
                     const int len = strlen(opaque)+16;
                     opaque_kv = gc_malloc(len, false, &gc);
-                    openvpn_snprintf(opaque_kv, len, ", opaque=\"%s\"", opaque);
+                    snprintf(opaque_kv, len, ", opaque=\"%s\"", opaque);
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
 
@@ -948,17 +948,17 @@
                 }
 
                 /* send digest response */
-                openvpn_snprintf(buf, sizeof(buf), "Proxy-Authorization: Digest username=\"%s\", realm=\"%s\", nonce=\"%s\", uri=\"%s\", qop=%s, nc=%s, cnonce=\"%s\", response=\"%s\"%s",
-                                 username,
-                                 realm,
-                                 nonce,
-                                 uri,
-                                 qop,
-                                 nonce_count,
-                                 cnonce,
-                                 response,
-                                 opaque_kv
-                                 );
+                snprintf(buf, sizeof(buf), "Proxy-Authorization: Digest username=\"%s\", realm=\"%s\", nonce=\"%s\", uri=\"%s\", qop=%s, nc=%s, cnonce=\"%s\", response=\"%s\"%s",
+                         username,
+                         realm,
+                         nonce,
+                         uri,
+                         qop,
+                         nonce_count,
+                         cnonce,
+                         response,
+                         opaque_kv
+                         );
                 msg(D_PROXY, "Send to HTTP proxy: '%s'", buf);
                 if (!send_line_crlf(sd, buf))
                 {
diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 7d9f9b5..4ca3a12 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -354,7 +354,7 @@
         fnlen =  strlen(journal_dir) + strlen(t) + 2;
         jfn = (char *) malloc(fnlen);
         check_malloc_return(jfn);
-        openvpn_snprintf(jfn, fnlen, "%s/%s", journal_dir, t);
+        snprintf(jfn, fnlen, "%s/%s", journal_dir, t);
         dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: client origin %s -> %s", jfn, f);
         fd = platform_open(jfn, O_CREAT | O_TRUNC | O_WRONLY, S_IRUSR | S_IWUSR | S_IRGRP);
         if (fd != -1)
diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 909d6d2..68bbcfd 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -1621,11 +1621,11 @@
 
     if (rgi)
     {
-        openvpn_snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, gateway, rgi->iface);
+        snprintf(out, sizeof(out), "%s %s %s dev %s", network, netmask, gateway, rgi->iface);
     }
     else
     {
-        openvpn_snprintf(out, sizeof(out), "%s %s %s", network, netmask, gateway);
+        snprintf(out, sizeof(out), "%s %s %s", network, netmask, gateway);
     }
     bool ret = management_android_control(management, "ROUTE", out);
     status = ret ? RTA_SUCCESS : RTA_ERROR;
@@ -2000,7 +2000,7 @@
 #elif defined (TARGET_ANDROID)
     char out[64];
 
-    openvpn_snprintf(out, sizeof(out), "%s/%d %s", network, r6->netbits, device);
+    snprintf(out, sizeof(out), "%s/%d %s", network, r6->netbits, device);
 
     status = management_android_control(management, "ROUTE6", out);
 
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
index 57eaee2..817a37f 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2982,11 +2982,11 @@
         case AF_INET:
             if (flags & SA_IP_PORT)
             {
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
             }
             else
             {
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s", name_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s", name_prefix);
             }
 
             inet_ntop(AF_INET, &addr->addr.in4.sin_addr, buf, sizeof(buf));
@@ -2994,7 +2994,7 @@
 
             if ((flags & SA_IP_PORT) && addr->addr.in4.sin_port)
             {
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefix);
                 setenv_int(es, name_buf, ntohs(addr->addr.in4.sin_port));
             }
             break;
@@ -3005,19 +3005,19 @@
                 struct in_addr ia;
                 memcpy(&ia.s_addr, &addr->addr.in6.sin6_addr.s6_addr[12],
                        sizeof(ia.s_addr));
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s_ip", name_prefix);
                 inet_ntop(AF_INET, &ia, buf, sizeof(buf));
             }
             else
             {
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s_ip6", name_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s_ip6", name_prefix);
                 inet_ntop(AF_INET6, &addr->addr.in6.sin6_addr, buf, sizeof(buf));
             }
             setenv_str(es, name_buf, buf);
 
             if ((flags & SA_IP_PORT) && addr->addr.in6.sin6_port)
             {
-                openvpn_snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefix);
+                snprintf(name_buf, sizeof(name_buf), "%s_port", name_prefix);
                 setenv_int(es, name_buf, ntohs(addr->addr.in6.sin6_port));
             }
             break;
diff --git a/src/openvpn/socks.c b/src/openvpn/socks.c
index d842666..2cbe8a4 100644
--- a/src/openvpn/socks.c
+++ b/src/openvpn/socks.c
@@ -109,8 +109,8 @@
             "Authentication not possible.");
         goto cleanup;
     }
-    openvpn_snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s", (int) strlen(creds.username),
-                     creds.username, (int) strlen(creds.password), creds.password);
+    snprintf(to_send, sizeof(to_send), "\x01%c%s%c%s", (int) strlen(creds.username),
+             creds.username, (int) strlen(creds.password), creds.password);
     size = send(sd, to_send, strlen(to_send), MSG_NOSIGNAL);
 
     if (size != strlen(to_send))
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index b44ddd5..65a865e 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -1531,16 +1531,16 @@
     char s2[256];
 
     s1[0] = s2[0] = 0;
-    openvpn_snprintf(s1, sizeof(s1), "%s %s, cipher %s",
-                     prefix,
-                     mbedtls_ssl_get_version(ks_ssl->ctx),
-                     mbedtls_ssl_get_ciphersuite(ks_ssl->ctx));
+    snprintf(s1, sizeof(s1), "%s %s, cipher %s",
+             prefix,
+             mbedtls_ssl_get_version(ks_ssl->ctx),
+             mbedtls_ssl_get_ciphersuite(ks_ssl->ctx));
 
     cert = mbedtls_ssl_get_peer_cert(ks_ssl->ctx);
     if (cert != NULL)
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
     size_t newlen = strlen(o->ncp_ciphers) + 1 + strlen(ciphername) + 1;
     char *ncp_ciphers = gc_malloc(newlen, false, &o->gc);
 
-    ASSERT(openvpn_snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
-                            ciphername));
+    ASSERT(snprintf(ncp_ciphers, newlen, "%s:%s", o->ncp_ciphers,
+                    ciphername));
     o->ncp_ciphers = ncp_ciphers;
 }
 
diff --git a/src/openvpn/ssl_openssl.c b/src/openvpn/ssl_openssl.c
index 4383e98..d0df0e8 100644
--- a/src/openvpn/ssl_openssl.c
+++ b/src/openvpn/ssl_openssl.c
@@ -1774,7 +1774,7 @@
     if (!biofp)
     {
         char fn[256];
-        openvpn_snprintf(fn, sizeof(fn), "bio/%d-%d.log", pid, biofp_toggle);
+        snprintf(fn, sizeof(fn), "bio/%d-%d.log", pid, biofp_toggle);
         biofp = fopen(fn, "w");
         ASSERT(biofp);
         biofp_last_open = time(NULL);
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
     int signature_nid = X509_get_signature_nid(cert);
     if (signature_nid != 0)
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
     char pkeybuf[128] = { 0 };
     print_pkey_details(pkey, pkeybuf, sizeof(pkeybuf));
 
-    openvpn_snprintf(buf, buflen, ", peer temporary key: %s",
-                     pkeybuf);
+    snprintf(buf, buflen, ", peer temporary key: %s",
+             pkeybuf);
 
     EVP_PKEY_free(pkey);
 }
@@ -2237,8 +2237,8 @@
         return;
     }
 
-    openvpn_snprintf(buf, buflen, ", peer signing digest/type: %s %s",
-                     peer_sig, peer_sig_type);
+    snprintf(buf, buflen, ", peer signing digest/type: %s %s",
+             peer_sig, peer_sig_type);
 }
 
 
@@ -2261,11 +2261,11 @@
 
     s1[0] = s2[0] = s3[0] = s4[0] = 0;
     ciph = SSL_get_current_cipher(ks_ssl->ssl);
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
     X509 *cert = SSL_get_peer_certificate(ks_ssl->ssl);
 
     if (cert)
diff --git a/src/openvpn/ssl_verify.c b/src/openvpn/ssl_verify.c
index c7d7799..ec7ff23 100644
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
-    openvpn_snprintf(envname, sizeof(envname), "tls_common_name_%d", cert_depth);
+    snprintf(envname, sizeof(envname), "tls_common_name_%d", cert_depth);
     setenv_str(es, envname, common_name);
 #endif
 
@@ -435,24 +435,24 @@
         struct buffer sha1 = x509_get_sha1_fingerprint(peer_cert, &gc);
         struct buffer sha256 = x509_get_sha256_fingerprint(peer_cert, &gc);
 
-        openvpn_snprintf(envname, sizeof(envname), "tls_digest_%d", cert_depth);
+        snprintf(envname, sizeof(envname), "tls_digest_%d", cert_depth);
         setenv_str(es, envname,
                    format_hex_ex(BPTR(&sha1), BLEN(&sha1), 0, 1, ":", &gc));
 
-        openvpn_snprintf(envname, sizeof(envname), "tls_digest_sha256_%d",
-                         cert_depth);
+        snprintf(envname, sizeof(envname), "tls_digest_sha256_%d",
+                 cert_depth);
         setenv_str(es, envname,
                    format_hex_ex(BPTR(&sha256), BLEN(&sha256), 0, 1, ":", &gc));
     }
 
     /* export serial number as environmental variable */
     serial = backend_x509_get_serial(peer_cert, &gc);
-    openvpn_snprintf(envname, sizeof(envname), "tls_serial_%d", cert_depth);
+    snprintf(envname, sizeof(envname), "tls_serial_%d", cert_depth);
     setenv_str(es, envname, serial);
 
     /* export serial number in hex as environmental variable */
     serial = backend_x509_get_serial_hex(peer_cert, &gc);
-    openvpn_snprintf(envname, sizeof(envname), "tls_serial_hex_%d", cert_depth);
+    snprintf(envname, sizeof(envname), "tls_serial_hex_%d", cert_depth);
     setenv_str(es, envname, serial);
 
     gc_free(&gc);
@@ -569,7 +569,7 @@
         goto cleanup;
     }
 
-    if (!openvpn_snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, serial))
+    if (!snprintf(fn, sizeof(fn), "%s%c%s", crl_dir, PATH_SEPARATOR, serial))
     {
         msg(D_HANDSHAKE, "VERIFY CRL: filename overflow");
         goto cleanup;
@@ -938,9 +938,9 @@
             if (!check_auth_pending_method(multi->peer_info, pending_method))
             {
                 char buf[128];
-                openvpn_snprintf(buf, sizeof(buf),
-                                 "Authentication failed, required pending auth "
-                                 "method '%s' not supported", pending_method);
+                snprintf(buf, sizeof(buf),
+                         "Authentication failed, required pending auth "
+                         "method '%s' not supported", pending_method);
                 auth_set_client_reason(multi, buf);
                 msg(M_INFO, "Client does not supported auth pending method "
                     "'%s'", pending_method);
diff --git a/src/openvpn/ssl_verify_mbedtls.c b/src/openvpn/ssl_verify_mbedtls.c
index a801cd3..ca14ceb 100644
--- a/src/openvpn/ssl_verify_mbedtls.c
+++ b/src/openvpn/ssl_verify_mbedtls.c
@@ -86,8 +86,8 @@
         char *serial = backend_x509_get_serial(cert, &gc);
 
         ret = mbedtls_x509_crt_verify_info(errstr, sizeof(errstr)-1, "", *flags);
-        if (ret <= 0 && !openvpn_snprintf(errstr, sizeof(errstr),
-                                          "Could not retrieve error string, flags=%" PRIx32, *flags))
+        if (ret <= 0 && !snprintf(errstr, sizeof(errstr),
+                                  "Could not retrieve error string, flags=%" PRIx32, *flags))
         {
             errstr[0] = '\0';
         }
@@ -307,7 +307,7 @@
     name_expand_size = 64 + strlen(name);
     name_expand = (char *) malloc(name_expand_size);
     check_malloc_return(name_expand);
-    openvpn_snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, name);
+    snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, name);
     setenv_str(es, name_expand, value);
     free(name_expand);
 }
@@ -431,13 +431,13 @@
 
         if (0 == mbedtls_oid_get_attr_short_name(&name->oid, &shortname) )
         {
-            openvpn_snprintf(name_expand, sizeof(name_expand), "X509_%d_%s",
-                             cert_depth, shortname);
+            snprintf(name_expand, sizeof(name_expand), "X509_%d_%s",
+                     cert_depth, shortname);
         }
         else
         {
-            openvpn_snprintf(name_expand, sizeof(name_expand), "X509_%d_\?\?",
-                             cert_depth);
+            snprintf(name_expand, sizeof(name_expand), "X509_%d_\?\?",
+                     cert_depth);
         }
 
         for (i = 0; i < name->val.len; i++)
diff --git a/src/openvpn/ssl_verify_openssl.c b/src/openvpn/ssl_verify_openssl.c
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
     name_expand_size = 64 + strlen(name);
     name_expand = (char *) malloc(name_expand_size);
     check_malloc_return(name_expand);
-    openvpn_snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, name);
+    snprintf(name_expand, name_expand_size, "X509_%d_%s", depth, name);
     setenv_str(es, name_expand, value);
     free(name_expand);
 }
@@ -597,8 +597,8 @@
         name_expand_size = 64 + strlen(objbuf);
         name_expand = (char *) malloc(name_expand_size);
         check_malloc_return(name_expand);
-        openvpn_snprintf(name_expand, name_expand_size, "X509_%d_%s", cert_depth,
-                         objbuf);
+        snprintf(name_expand, name_expand_size, "X509_%d_%s", cert_depth,
+                 objbuf);
         string_mod(name_expand, CC_PRINT, CC_CRLF, '_');
         string_mod((char *)buf, CC_PRINT, CC_CRLF, '_');
         setenv_str_incr(es, name_expand, (char *)buf);
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 975d31f..8948938 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -574,8 +574,8 @@
     }
 
     char metadata_type_str[4] = { 0 }; /* Max value: 255 */
-    openvpn_snprintf(metadata_type_str, sizeof(metadata_type_str),
-                     "%i", metadata_type);
+    snprintf(metadata_type_str, sizeof(metadata_type_str),
+             "%i", metadata_type);
     struct env_set *es = env_set_create(NULL);
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
             top = "undef";
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
                 for (int i = 0; i < 256; ++i)
                 {
-                    openvpn_snprintf(tunname, sizeof(tunname),
-                                     "/dev/%s%d", dev, i);
-                    openvpn_snprintf(dynamic_name, sizeof(dynamic_name),
-                                     "%s%d", dev, i);
+                    snprintf(tunname, sizeof(tunname),
+                             "/dev/%s%d", dev, i);
+                    snprintf(dynamic_name, sizeof(dynamic_name),
+                             "%s%d", dev, i);
                     if ((tt->fd = open(tunname, O_RDWR)) > 0)
                     {
                         dynamic_opened = true;
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
         for (int i = 0; i < 256; ++i)
         {
-            openvpn_snprintf(dynamic_name, sizeof(dynamic_name),
-                             "%s%d", dev, i);
+            snprintf(dynamic_name, sizeof(dynamic_name),
+                     "%s%d", dev, i);
             int ret = open_tun_dco(tt, ctx, dynamic_name);
             if (ret == 0)
             {
@@ -2519,7 +2519,7 @@
     tt->actual_name = (char *) malloc(32);
     check_malloc_return(tt->actual_name);
 
-    openvpn_snprintf(tt->actual_name, 32, "%s%d", dev_tuntap_type, ppa);
+    snprintf(tt->actual_name, 32, "%s%d", dev_tuntap_type, ppa);
 
     if (tt->type == DEV_TYPE_TAP)
     {
@@ -3509,7 +3509,7 @@
         int i;
         for (i = 0; i<99; i++)
         {
-            openvpn_snprintf(tunname, sizeof(tunname), "/dev/tap%d", i);
+            snprintf(tunname, sizeof(tunname), "/dev/tap%d", i);
             if (access( tunname, F_OK ) < 0 && errno == ENOENT)
             {
                 break;
@@ -3520,7 +3520,7 @@
             msg( M_FATAL, "cannot find unused tap device" );
         }
 
-        openvpn_snprintf( dynamic_name, sizeof(dynamic_name), "tap%d", i );
+        snprintf( dynamic_name, sizeof(dynamic_name), "tap%d", i );
         dev = dynamic_name;
     }
     else                                        /* name given, sanity check */
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
 
         status = RegOpenKeyEx(
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
 
         status = RegOpenKeyEx(
             HKEY_LOCAL_MACHINE,
@@ -4984,7 +4984,7 @@
     DWORD index;
     ULONG aindex;
     wchar_t wbuf[256];
-    openvpn_swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%hs", guid);
+    swprintf(wbuf, SIZE(wbuf), L"\\DEVICE\\TCPIP_%hs", guid);
     if (GetAdapterIndex(wbuf, &aindex) != NO_ERROR)
     {
         index = TUN_ADAPTER_INDEX_INVALID;
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
 
         hand = CreateFile(
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
 
             hand = CreateFile(
                 device_path,
@@ -6607,10 +6607,10 @@
     else
     {
         /* Open TAP-Windows */
-        openvpn_snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
-                         USERMODEDEVICEDIR,
-                         device_guid,
-                         TAP_WIN_SUFFIX);
+        snprintf(tuntap_device_path, sizeof(tuntap_device_path), "%s%s%s",
+                 USERMODEDEVICEDIR,
+                 device_guid,
+                 TAP_WIN_SUFFIX);
         path = tuntap_device_path;
     }
 
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 27d82c5..98955ba 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -885,8 +885,8 @@
     char force_path[256];
     char *sysroot = get_win_sys_path();
 
-    if (!openvpn_snprintf(force_path, sizeof(force_path), "PATH=%s\\System32;%s;%s\\System32\\Wbem",
-                          sysroot, sysroot, sysroot))
+    if (!snprintf(force_path, sizeof(force_path), "PATH=%s\\System32;%s;%s\\System32\\Wbem",
+                  sysroot, sysroot, sysroot))
     {
         msg(M_WARN, "env_block: default path truncated to %s", force_path);
     }
@@ -1483,26 +1483,11 @@
 }
 
 bool
-openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...)
-{
-    va_list arglist;
-    int len = -1;
-    if (size > 0)
-    {
-        va_start(arglist, format);
-        len = vswprintf(str, size, format, arglist);
-        va_end(arglist);
-        str[size - 1] = L'\0';
-    }
-    return (len >= 0 && len < size);
-}
-
-bool
 get_openvpn_reg_value(const WCHAR *key, WCHAR *value, DWORD size)
 {
     WCHAR reg_path[256];
     HKEY hkey;
-    openvpn_swprintf(reg_path, _countof(reg_path), L"SOFTWARE\\" PACKAGE_NAME);
+    swprintf(reg_path, _countof(reg_path), L"SOFTWARE\\" PACKAGE_NAME);
 
     LONG status = RegOpenKeyExW(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &hkey);
     if (status != ERROR_SUCCESS)
@@ -1528,7 +1513,7 @@
         /* if we cannot find installation path from the registry,
          * use Windows directory as a fallback
          */
-        openvpn_swprintf(install_path, _countof(install_path), L"%ls", ssl_fallback_dir);
+        swprintf(install_path, _countof(install_path), L"%ls", ssl_fallback_dir);
     }
 
     if ((install_path[wcslen(install_path) - 1]) == L'\\')
@@ -1553,7 +1538,7 @@
         if (size == 0)
         {
             WCHAR val[MAX_PATH] = {0};
-            openvpn_swprintf(val, _countof(val), L"%ls\\ssl\\%ls", install_path, ossl_env[i].value);
+            swprintf(val, _countof(val), L"%ls\\ssl\\%ls", install_path, ossl_env[i].value);
             _wputenv_s(ossl_env[i].name, val);
         }
     }
diff --git a/src/openvpn/win32.h b/src/openvpn/win32.h
index 974fe02d..fd75992 100644
--- a/src/openvpn/win32.h
+++ b/src/openvpn/win32.h
@@ -319,14 +319,6 @@
 int
 openvpn_execve(const struct argv *a, const struct env_set *es, const unsigned int flags);
 
-/*
- * openvpn_swprintf() is currently only used by Windows code paths
- * and when enabled for all platforms it will currently break older
- * OpenBSD versions lacking vswprintf(3) support in their libc.
- */
-bool
-openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...);
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
-            openvpn_snprintf(alg_str, sizeof(alg_str), "ECDSA,hashalg=%s", alg.mdname);
+            snprintf(alg_str, sizeof(alg_str), "ECDSA,hashalg=%s", alg.mdname);
         }
     }
     else if (!strcmp(alg.keytype, "ED448") || !strcmp(alg.keytype, "ED25519"))
@@ -229,8 +229,8 @@
         /* For undigested message, add hashalg=digest parameter */
         else
         {
-            openvpn_snprintf(alg_str, sizeof(alg_str), "%s,hashalg=%s",
-                             "RSA_PKCS1_PADDING", alg.mdname);
+            snprintf(alg_str, sizeof(alg_str), "%s,hashalg=%s",
+                     "RSA_PKCS1_PADDING", alg.mdname);
         }
     }
     else if (!strcmp(alg.padmode, "none") && (flags & MF_EXTERNAL_KEY_NOPADDING)
@@ -240,8 +240,8 @@
     }
     else if (!strcmp(alg.padmode, "pss") && (flags & MF_EXTERNAL_KEY_PSSPAD))
     {
-        openvpn_snprintf(alg_str, sizeof(alg_str), "%s,hashalg=%s,saltlen=%s",
-                         "RSA_PKCS1_PSS_PADDING", alg.mdname, alg.saltlen);
+        snprintf(alg_str, sizeof(alg_str), "%s,hashalg=%s,saltlen=%s",
+                 "RSA_PKCS1_PSS_PADDING", alg.mdname, alg.saltlen);
     }
     else
     {
diff --git a/src/openvpnserv/common.c b/src/openvpnserv/common.c
index bd0a484..b6f934a 100644
--- a/src/openvpnserv/common.c
+++ b/src/openvpnserv/common.c
@@ -27,36 +27,6 @@
 LPCTSTR service_instance = TEXT("");
 static wchar_t win_sys_path[MAX_PATH];
 
-/*
- * These are necessary due to certain buggy implementations of (v)snprintf,
- * that don't guarantee null termination for size > 0.
- */
-BOOL
-openvpn_vswprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist)
-{
-    int len = -1;
-    if (size > 0)
-    {
-        len = vswprintf_s(str, size, format, arglist);
-        str[size - 1] = 0;
-    }
-    return (len >= 0 && (size_t)len < size);
-}
-
-BOOL
-openvpn_swprintf(LPTSTR str, size_t size, LPCTSTR format, ...)
-{
-    va_list arglist;
-    BOOL res = FALSE;
-    if (size > 0)
-    {
-        va_start(arglist, format);
-        res = openvpn_vswprintf(str, size, format, arglist);
-        va_end(arglist);
-    }
-    return res;
-}
-
 static DWORD
 GetRegString(HKEY key, LPCTSTR value, LPTSTR data, DWORD size, LPCTSTR default_value)
 {
@@ -66,7 +36,7 @@
     if (status == ERROR_FILE_NOT_FOUND && default_value)
     {
         size_t len = size/sizeof(data[0]);
-        if (openvpn_swprintf(data, len, default_value))
+        if (swprintf(data, len, default_value))
         {
             status = ERROR_SUCCESS;
         }
@@ -93,7 +63,7 @@
     TCHAR install_path[MAX_PATH];
     TCHAR default_value[MAX_PATH];
 
-    openvpn_swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKAGE_NAME "%ls"), service_instance);
+    swprintf(reg_path, _countof(reg_path), TEXT("SOFTWARE\\" PACKAGE_NAME "%ls"), service_instance);
 
     LONG status = RegOpenKeyEx(HKEY_LOCAL_MACHINE, reg_path, 0, KEY_READ, &key);
     if (status != ERROR_SUCCESS)
@@ -110,15 +80,15 @@
         goto out;
     }
 
-    openvpn_swprintf(default_value, _countof(default_value), TEXT("%ls\\bin\\openvpn.exe"),
-                     install_path);
+    swprintf(default_value, _countof(default_value), TEXT("%ls\\bin\\openvpn.exe"),
+             install_path);
     error = GetRegString(key, TEXT("exe_path"), s->exe_path, sizeof(s->exe_path), default_value);
     if (error != ERROR_SUCCESS)
     {
         goto out;
     }
 
-    openvpn_swprintf(default_value, _countof(default_value), TEXT("%ls\\config"), install_path);
+    swprintf(default_value, _countof(default_value), TEXT("%ls\\config"), install_path);
     error = GetRegString(key, TEXT("config_dir"), s->config_dir, sizeof(s->config_dir),
                          default_value);
     if (error != ERROR_SUCCESS)
@@ -133,7 +103,7 @@
         goto out;
     }
 
-    openvpn_swprintf(default_value, _countof(default_value), TEXT("%ls\\log"), install_path);
+    swprintf(default_value, _countof(default_value), TEXT("%ls\\log"), install_path);
     error = GetRegString(key, TEXT("log_dir"), s->log_dir, sizeof(s->log_dir), default_value);
     if (error != ERROR_SUCCESS)
     {
@@ -229,7 +199,7 @@
     else
     {
         tmp[wcslen(tmp) - 2] = TEXT('\0'); /* remove CR/LF characters */
-        openvpn_swprintf(buf, _countof(buf), TEXT("%ls (0x%x)"), tmp, error);
+        swprintf(buf, _countof(buf), TEXT("%ls (0x%x)"), tmp, error);
     }
 
     if (tmp)
@@ -259,9 +229,9 @@
     hEventSource = RegisterEventSource(NULL, APPNAME);
     if (hEventSource != NULL)
     {
-        openvpn_swprintf(msg[0], _countof(msg[0]),
-                         TEXT("%ls%ls%ls: %ls"), APPNAME, service_instance,
-                         (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT(""), err_msg);
+        swprintf(msg[0], _countof(msg[0]),
+                 TEXT("%ls%ls%ls: %ls"), APPNAME, service_instance,
+                 (flags & MSG_FLAGS_ERROR) ? TEXT(" error") : TEXT(""), err_msg);
 
         va_start(arglist, format);
         openvpn_vswprintf(msg[1], _countof(msg[1]), format, arglist);
diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index 452633c..efd3834 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -310,7 +310,7 @@
      * Same format as error messages (3 line string) with error = 0 in
      * 0x%08x format, PID on line 2 and a description "Process ID" on line 3
      */
-    openvpn_swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%ls", 0, pid, msg);
+    swprintf(buf, _countof(buf), L"0x%08x\n0x%08x\n%ls", 0, pid, msg);
 
     WritePipeAsync(pipe, buf, (DWORD)(wcslen(buf) * 2), count, events);
 }
@@ -384,9 +384,9 @@
 
     if (!argv)
     {
-        openvpn_swprintf(errmsg, capacity,
-                         L"Cannot validate options: CommandLineToArgvW failed with error = 0x%08x",
-                         GetLastError());
+        swprintf(errmsg, capacity,
+                 L"Cannot validate options: CommandLineToArgvW failed with error = 0x%08x",
+                 GetLastError());
         goto out;
     }
 
@@ -406,8 +406,8 @@
 
         if (!CheckOption(workdir, 2, argv_tmp, &settings))
         {
-            openvpn_swprintf(errmsg, capacity, msg1, argv[0], workdir,
-                             settings.ovpn_admin_group);
+            swprintf(errmsg, capacity, msg1, argv[0], workdir,
+                     settings.ovpn_admin_group);
         }
         goto out;
     }
@@ -423,13 +423,13 @@
         {
             if (wcscmp(L"--config", argv[i]) == 0 && argc-i > 1)
             {
-                openvpn_swprintf(errmsg, capacity, msg1, argv[i+1], workdir,
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
@@ -984,7 +984,7 @@
 
     HANDLE wait_handles[2] = {rdns_semaphore, exit_event};
 
-    openvpn_swprintf(ipcfg, MAX_PATH, L"%ls\\%ls", get_win_sys_path(), L"ipconfig.exe");
+    swprintf(ipcfg, MAX_PATH, L"%ls\\%ls", get_win_sys_path(), L"ipconfig.exe");
 
     if (WaitForMultipleObjects(2, wait_handles, FALSE, timeout) == WAIT_OBJECT_0)
     {
@@ -1063,7 +1063,7 @@
     }
 
     /* Path of netsh */
-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"netsh.exe");
+    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"netsh.exe");
 
     /* cmd template:
      * netsh interface $proto $action dns $if_name $addr [validate=no]
@@ -1079,7 +1079,7 @@
         goto out;
     }
 
-    openvpn_swprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);
+    swprintf(cmdline, ncmdline, fmt, proto, action, if_name, addr);
 
     if (IsWindows7OrGreater())
     {
@@ -1123,7 +1123,7 @@
     }
 
     /* Path of netsh */
-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"netsh.exe");
+    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"netsh.exe");
 
     /* cmd template:
      * netsh interface ip $action wins $if_name $static $addr
@@ -1140,7 +1140,7 @@
         goto out;
     }
 
-    openvpn_swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static, addr);
+    swprintf(cmdline, ncmdline, fmt, action, if_name, addr_static, addr);
 
     err = ExecCommand(argv0, cmdline, timeout);
 
@@ -1166,7 +1166,7 @@
     wchar_t *cmdline = NULL;
     int timeout = 10000; /* in msec */
 
-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"wbem\\wmic.exe");
+    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"wbem\\wmic.exe");
 
     const wchar_t *fmt;
     /* comma separated list must be enclosed in parenthesis */
@@ -1187,8 +1187,8 @@
         return ERROR_OUTOFMEMORY;
     }
 
-    openvpn_swprintf(cmdline, ncmdline, fmt, if_index, action,
-                     data ? data : L"");
+    swprintf(cmdline, ncmdline, fmt, if_index, action,
+             data ? data : L"");
     err = ExecCommand(argv0, cmdline, timeout);
 
     free(cmdline);
@@ -1452,7 +1452,7 @@
     wchar_t argv0[MAX_PATH];
 
     /* Path of netsh */
-    openvpn_swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"netsh.exe");
+    swprintf(argv0, _countof(argv0), L"%ls\\%ls", get_win_sys_path(), L"netsh.exe");
 
     /* cmd template:
      * netsh interface ipv4 set address name=$if_index source=dhcp
@@ -1470,7 +1470,7 @@
         return err;
     }
 
-    openvpn_swprintf(cmdline, ncmdline, fmt, dhcp->iface.index);
+    swprintf(cmdline, ncmdline, fmt, dhcp->iface.index);
 
     err = ExecCommand(argv0, cmdline, timeout);
 
@@ -1969,8 +1969,8 @@
         goto out;
     }
 
-    openvpn_swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
-                     TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), service_instance, GetCurrentThreadId());
+    swprintf(ovpn_pipe_name, _countof(ovpn_pipe_name),
+             TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service_%lu"), service_instance, GetCurrentThreadId());
     ovpn_pipe = CreateNamedPipe(ovpn_pipe_name,
                                 PIPE_ACCESS_DUPLEX | FILE_FLAG_FIRST_PIPE_INSTANCE | FILE_FLAG_OVERLAPPED,
                                 PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_WAIT, 1, 128, 128, 0, NULL);
@@ -2002,8 +2002,8 @@
         ReturnLastError(pipe, L"malloc");
         goto out;
     }
-    openvpn_swprintf(cmdline, cmdline_size, L"openvpn %ls --msg-channel %lu",
-                     sud.options, svc_pipe);
+    swprintf(cmdline, cmdline_size, L"openvpn %ls --msg-channel %lu",
+             sud.options, svc_pipe);
 
     if (!CreateEnvironmentBlock(&user_env, imp_token, FALSE))
     {
@@ -2078,8 +2078,8 @@
     else if (exit_code != 0)
     {
         WCHAR buf[256];
-        openvpn_swprintf(buf, _countof(buf),
-                         L"OpenVPN exited with error: exit code = %lu", exit_code);
+        swprintf(buf, _countof(buf),
+                 L"OpenVPN exited with error: exit code = %lu", exit_code);
         ReturnError(pipe, ERROR_OPENVPN_STARTUP, buf, 1, &exit_event);
     }
     Undo(&undo_lists);
@@ -2173,7 +2173,7 @@
         initialized = TRUE;
     }
 
-    openvpn_swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service"), service_instance);
+    swprintf(pipe_name, _countof(pipe_name), TEXT("\\\\.\\pipe\\" PACKAGE "%ls\\service"), service_instance);
     pipe = CreateNamedPipe(pipe_name, flags,
                            PIPE_TYPE_MESSAGE | PIPE_READMODE_MESSAGE | PIPE_REJECT_REMOTE_CLIENTS,
                            PIPE_UNLIMITED_INSTANCES, 1024, 1024, 0, NULL);
diff --git a/src/openvpnserv/service.h b/src/openvpnserv/service.h
index 3acf08c..6d0827d 100644
--- a/src/openvpnserv/service.h
+++ b/src/openvpnserv/service.h
@@ -81,12 +81,6 @@
 
 VOID WINAPI ServiceStartInteractive(DWORD argc, LPTSTR *argv);
 
-BOOL openvpn_vsntprintf(LPTSTR str, size_t size, LPCTSTR format, va_list arglist);
-
-BOOL openvpn_sntprintf(LPTSTR str, size_t size, LPCTSTR format, ...);
-
-BOOL openvpn_swprintf(wchar_t *const str, const size_t size, const wchar_t *const format, ...);
-
 DWORD GetOpenvpnSettings(settings_t *s);
 
 BOOL ReportStatusToSCMgr(SERVICE_STATUS_HANDLE service, SERVICE_STATUS *status);
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
         config_file = tmp;
     }
     else
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c
index 52ffb54..c1d1538 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -354,6 +354,30 @@
     assert_string_equal(buf, "There is a .'nice.' \"1234\" [.] year old .tree!");
 }
 
+static void
+test_snprintf(void **state)
+{
+    /* we used to have a custom openvpn_snprintf function because some
+     * OS (the comment did not specify which) did not always put the
+     * null byte there. So we unit test this to be sure.
+     *
+     * This probably refers to the MSVC behaviour, see also
+     * https://stackoverflow.com/questions/7706936/is-snprintf-always-null-terminating
+     */
+
+    char buf[10] = { 'a' };
+    assert_int_equal(snprintf(buf, sizeof(buf), "0123456789abcde"), 15);
+    assert_int_equal(buf[9], '\0');
+
+    memset(buf, 'b', sizeof(buf));
+    assert_int_equal(snprintf(buf, sizeof(buf), "- %d - %d -", 77, 88), 11);
+    assert_int_equal(buf[9], '\0');
+
+    memset(buf, 'c', sizeof(buf));
+    assert_int_equal(snprintf(buf, sizeof(buf), "- %8.2f", 77.8899), 10);
+    assert_int_equal(buf[9], '\0');
+}
+
 int
 main(void)
 {
@@ -387,6 +411,7 @@
         cmocka_unit_test(test_buffer_free_gc_two),
         cmocka_unit_test(test_buffer_gc_realloc),
         cmocka_unit_test(test_character_class),
+        cmocka_unit_test(test_snprintf)
     };
 
     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);
diff --git a/tests/unit_tests/openvpn/test_cryptoapi.c b/tests/unit_tests/openvpn/test_cryptoapi.c
index 87f6208..98102ef 100644
--- a/tests/unit_tests/openvpn/test_cryptoapi.c
+++ b/tests/unit_tests/openvpn/test_cryptoapi.c
@@ -271,7 +271,7 @@
 
     for (struct test_cert *c = certs; c->cert; c++)
     {
-        openvpn_snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash);
+        snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash);
         ctx = find_certificate_in_store(select_string, user_store);
         if (ctx)
         {
@@ -304,7 +304,7 @@
 
     for (struct test_cert *c = certs; c->cert; c++)
     {
-        openvpn_snprintf(select_string, sizeof(select_string), "SUBJ:%s", c->cname);
+        snprintf(select_string, sizeof(select_string), "SUBJ:%s", c->cname);
         ctx = find_certificate_in_store(select_string, user_store);
         /* In this case we expect a successful return as there is at least one valid
          * cert that matches the common name. But the returned cert may not exactly match
@@ -337,7 +337,7 @@
 
     for (struct test_cert *c = certs; c->cert; c++)
     {
-        openvpn_snprintf(select_string, sizeof(select_string), "ISSUER:%s", c->issuer);
+        snprintf(select_string, sizeof(select_string), "ISSUER:%s", c->issuer);
         ctx = find_certificate_in_store(select_string, user_store);
         /* In this case we expect a successful return as there is at least one valid
          * cert that matches the issuer. But the returned cert may not exactly match
@@ -411,7 +411,7 @@
         {
             continue;
         }
-        openvpn_snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash);
+        snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash);
         if (Load_CryptoAPI_certificate(select_string, &x509, &privkey) != 1)
         {
             fail_msg("Load_CryptoAPI_certificate failed: <%s>", c->friendly_name);
@@ -446,7 +446,7 @@
         SSL_CTX *ssl_ctx = SSL_CTX_new_ex(tls_libctx, NULL, SSLv23_client_method());
         assert_non_null(ssl_ctx);
 
-        openvpn_snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash);
+        snprintf(select_string, sizeof(select_string), "THUMB:%s", c->hash);
         if (!SSL_CTX_use_CryptoAPI_certificate(ssl_ctx, select_string))
         {
             fail_msg("SSL_CTX_use_CryptoAPI_certificate failed: <%s>", c->friendly_name);
diff --git a/tests/unit_tests/openvpn/test_pkcs11.c b/tests/unit_tests/openvpn/test_pkcs11.c
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
         fail_msg("make tmpfile using template <%s> failed (error = %d)", softhsm2_conf_path, errno);
     }
-    openvpn_snprintf(config, sizeof(config), "directories.tokendir=%s/",
-                     softhsm2_tokens_path);
+    snprintf(config, sizeof(config), "directories.tokendir=%s/",
+             softhsm2_tokens_path);
     assert_int_equal(write(fd, config, strlen(config)), strlen(config));
     close(fd);
 

