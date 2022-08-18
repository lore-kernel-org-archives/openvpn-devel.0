From: Antonio Quartulli <a@...2181...>
Date: Thu, 18 Aug 2022 10:48:25 +0200
Message-Id: <20220818084825.187755-1-a@...2181...>
In-Reply-To: <20220818001905.176039-1-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] push-peer-info: rearrange function
 generating peer info
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
Cc: Antonio Quartulli <a@...2181...>

This patch is supposed to implement no function change.
The only change in behaviour that can be observed is the IV_/UV_ variables
being printed in different order compared to before applying this patch.

However, order does not matter, so we don't need to retain it.

What this change really does is rearranging the push_peer_info() function
so that it becomes much more clear which variable is printed depending on
the peer-info detail level. The original code was mixed up, and figuring
the above out required reading this function multiple times.

This rearrangement puts everything in a switch/case block with sorted
peer-info details levels appearing one after the other.

While at it, the for loop extracting the wanted env variables has been
restructured a bit to avoid uber long conditions and extreme indentation.

Signed-off-by: Antonio Quartulli <a@...2181...>
---

NOTE: I tried to move this function to ssh_util.c to make it possible to
unit-test it. However, it requires a bunch of headers which make the whole
dependency chain explode..so I gave up.

Changes from v2:
* create helper function to push variable from env-set

Changes from v1:
* add spaces before case/default labels in switch block
---
 src/openvpn/ssl.c | 219 ++++++++++++++++++++++++++--------------------
 1 file changed, 126 insertions(+), 93 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33e145b3..4ff36d40 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1910,6 +1910,44 @@ read_string_alloc(struct buffer *buf)
     return str;
 }
 
+/**
+ * Searches the environment variables set for variables starting with the
+ * specified pattern. If found, the variable string (i.e. VAR=VALUE) is
+ * copied to the out buffer provided as argument
+ *
+ * @param out       the output buffer where variables should be written to
+ * @param es        the environment variables set to search
+ * @param pattern   the pattern used to match variable names
+ */
+static void
+push_peer_info_env_var(struct buffer *out, const struct env_set *es, const char *pattern)
+{
+    for (const struct env_item *e = es->list; e; e = e->next)
+    {
+        /* ensure we have a string */
+        if (!e->string)
+        {
+            continue;
+        }
+
+        /* ensure string will fit output buffer */
+        if (!buf_safe(out, strlen(e->string) + 1))
+        {
+            continue;
+        }
+
+        /* don't accept any var except for those starting with the specified
+         * pattern
+         */
+        if (strncmp(e->string, pattern, strlen(pattern)) != 0)
+        {
+            continue;
+        }
+
+        buf_printf(out, "%s\n", e->string);
+    }
+}
+
 /**
  * Prepares the IV_ and UV_ variables that are part of the
  * exchange to signal the peer's capabilities. The amount
@@ -1932,134 +1970,129 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
     bool ret = false;
     struct buffer out = alloc_buf_gc(512 * 3, &gc);
 
-    if (session->opt->push_peer_info_detail > 1)
+    switch (session->opt->push_peer_info_detail)
     {
-        /* push version */
-        buf_printf(&out, "IV_VER=%s\n", PACKAGE_VERSION);
+        case 3:
+        {
+            /* push mac addr */
+            struct route_gateway_info rgi;
+            get_default_gateway(&rgi, session->opt->net_ctx);
+            if (rgi.flags & RGI_HWADDR_DEFINED)
+            {
+                buf_printf(&out, "IV_HWADDR=%s\n", format_hex_ex(rgi.hwaddr, 6, 0, 1, ":", &gc));
+            }
+            buf_printf(&out, "IV_SSL=%s\n", get_ssl_library_version() );
+#if defined(_WIN32)
+            buf_printf(&out, "IV_PLAT_VER=%s\n", win32_version_string(&gc, false));
+#endif
+
+            /* push env vars that begin with UV_, IV_PLAT_VER= */
+            push_peer_info_env_var(&out, session->opt->es, "UV_");
+            push_peer_info_env_var(&out, session->opt->es, "IV_PLAT_VER=");
+        }
+
+        /* fall through */
+        case 2:
+        {
+            /* push version */
+            buf_printf(&out, "IV_VER=%s\n", PACKAGE_VERSION);
 
-        /* push platform */
+            /* push platform */
 #if defined(TARGET_LINUX)
-        buf_printf(&out, "IV_PLAT=linux\n");
+            buf_printf(&out, "IV_PLAT=linux\n");
 #elif defined(TARGET_SOLARIS)
-        buf_printf(&out, "IV_PLAT=solaris\n");
+            buf_printf(&out, "IV_PLAT=solaris\n");
 #elif defined(TARGET_OPENBSD)
-        buf_printf(&out, "IV_PLAT=openbsd\n");
+            buf_printf(&out, "IV_PLAT=openbsd\n");
 #elif defined(TARGET_DARWIN)
-        buf_printf(&out, "IV_PLAT=mac\n");
+            buf_printf(&out, "IV_PLAT=mac\n");
 #elif defined(TARGET_NETBSD)
-        buf_printf(&out, "IV_PLAT=netbsd\n");
+            buf_printf(&out, "IV_PLAT=netbsd\n");
 #elif defined(TARGET_FREEBSD)
-        buf_printf(&out, "IV_PLAT=freebsd\n");
+            buf_printf(&out, "IV_PLAT=freebsd\n");
 #elif defined(TARGET_ANDROID)
-        buf_printf(&out, "IV_PLAT=android\n");
+            buf_printf(&out, "IV_PLAT=android\n");
 #elif defined(_WIN32)
-        buf_printf(&out, "IV_PLAT=win\n");
+            buf_printf(&out, "IV_PLAT=win\n");
 #endif
-        /* Announce that we do not require strict sequence numbers with
-         * TCP. (TCP non-linear) */
-        buf_printf(&out, "IV_TCPNL=1\n");
-    }
 
-    /* These are the IV variable that are sent to peers in p2p mode */
-    if (session->opt->push_peer_info_detail > 0)
-    {
-        /* support for P_DATA_V2 */
-        int iv_proto = IV_PROTO_DATA_V2;
+            /* Announce that we do not require strict sequence numbers with
+             * TCP. (TCP non-linear) */
+            buf_printf(&out, "IV_TCPNL=1\n");
 
-        /* support for the --dns option */
-        iv_proto |= IV_PROTO_DNS_OPTION;
+            /* push compression status */
+#ifdef USE_COMP
+            comp_generate_peer_info_string(&session->opt->comp_options, &out);
+#endif
 
-        /* support for receiving push_reply before sending
-         * push request, also signal that the client wants
-         * to get push-reply messages without without requiring a round
-         * trip for a push request message*/
-        if (session->opt->pull)
-        {
-            iv_proto |= IV_PROTO_REQUEST_PUSH;
-            iv_proto |= IV_PROTO_AUTH_PENDING_KW;
+            /* push env vars that begin with IV_GUI_VER= and IV_SSO= */
+            push_peer_info_env_var(&out, session->opt->es, "IV_GUI_VER=");
+            push_peer_info_env_var(&out, session->opt->es, "IV_SSO=");
         }
 
-        /* support for Negotiable Crypto Parameters */
-        if (session->opt->mode == MODE_SERVER || session->opt->pull)
+        /* fall through */
+        case 1:
         {
-            if (tls_item_in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
-                && tls_item_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ciphers))
-            {
+            /* support for P_DATA_V2 */
+            int iv_proto = IV_PROTO_DATA_V2;
+
+            /* support for the --dns option */
+            iv_proto |= IV_PROTO_DNS_OPTION;
 
-                buf_printf(&out, "IV_NCP=2\n");
+            /* support for receiving push_reply before sending
+             * push request, also signal that the client wants
+             * to get push-reply messages without without requiring a round
+             * trip for a push request message*/
+            if (session->opt->pull)
+            {
+                iv_proto |= IV_PROTO_REQUEST_PUSH;
+                iv_proto |= IV_PROTO_AUTH_PENDING_KW;
             }
-        }
-        else
-        {
-            /* We are not using pull or p2mp server, instead do P2P NCP */
-            iv_proto |= IV_PROTO_NCP_P2P;
-        }
 
-        buf_printf(&out, "IV_CIPHERS=%s\n", session->opt->config_ncp_ciphers);
+            /* support for Negotiable Crypto Parameters */
+            if (session->opt->mode == MODE_SERVER || session->opt->pull)
+            {
+                if (tls_item_in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
+                    && tls_item_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ciphers))
+                {
+
+                    buf_printf(&out, "IV_NCP=2\n");
+                }
+            }
+            else
+            {
+                /* We are not using pull or p2mp server, instead do P2P NCP */
+                iv_proto |= IV_PROTO_NCP_P2P;
+            }
 
 #ifdef HAVE_EXPORT_KEYING_MATERIAL
-        iv_proto |= IV_PROTO_TLS_KEY_EXPORT;
+            iv_proto |= IV_PROTO_TLS_KEY_EXPORT;
 #endif
 
-        buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
+            buf_printf(&out, "IV_PROTO=%d\n", iv_proto);
 
-        if (session->opt->push_peer_info_detail > 1)
-        {
-            /* push compression status */
-#ifdef USE_COMP
-            comp_generate_peer_info_string(&session->opt->comp_options, &out);
-#endif
-        }
+            buf_printf(&out, "IV_CIPHERS=%s\n", session->opt->config_ncp_ciphers);
 
-        if (session->opt->push_peer_info_detail > 2)
-        {
-            /* push mac addr */
-            struct route_gateway_info rgi;
-            get_default_gateway(&rgi, session->opt->net_ctx);
-            if (rgi.flags & RGI_HWADDR_DEFINED)
+            if (!write_string(buf, BSTR(&out), -1))
             {
-                buf_printf(&out, "IV_HWADDR=%s\n", format_hex_ex(rgi.hwaddr, 6, 0, 1, ":", &gc));
+                goto error;
             }
-            buf_printf(&out, "IV_SSL=%s\n", get_ssl_library_version() );
-#if defined(_WIN32)
-            buf_printf(&out, "IV_PLAT_VER=%s\n", win32_version_string(&gc, false));
-#endif
+            break;
         }
 
-        if (session->opt->push_peer_info_detail > 1)
-        {
-            struct env_set *es = session->opt->es;
-            /* push env vars that begin with UV_, IV_PLAT_VER and IV_GUI_VER */
-            for (struct env_item *e = es->list; e != NULL; e = e->next)
+        case 0:
+            if (!write_empty_string(buf))
             {
-                if (e->string)
-                {
-                    if ((((strncmp(e->string, "UV_", 3) == 0
-                           || strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=") - 1) == 0)
-                          && session->opt->push_peer_info_detail > 2)
-                         || (strncmp(e->string, "IV_GUI_VER=", sizeof("IV_GUI_VER=") - 1) == 0)
-                         || (strncmp(e->string, "IV_SSO=", sizeof("IV_SSO=") - 1) == 0)
-                         )
-                        && buf_safe(&out, strlen(e->string) + 1))
-                    {
-                        buf_printf(&out, "%s\n", e->string);
-                    }
-                }
+                goto error;
             }
-        }
+            break;
 
-        if (!write_string(buf, BSTR(&out), -1))
-        {
-            goto error;
-        }
-    }
-    else
-    {
-        if (!write_empty_string(buf)) /* no peer info */
-        {
+        /* invalid value configured */
+        default:
+            msg(M_WARN, "Invalid peer-info-detail level %d", session->opt->push_peer_info_detail);
             goto error;
-        }
     }
+
     ret = true;
 
 error:
-- 
2.30.2


