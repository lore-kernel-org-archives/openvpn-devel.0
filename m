From: Antonio Quartulli <a@...2181...>
Date: Thu, 18 Aug 2022 01:32:48 +0200
Message-Id: <20220817233248.137722-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] push-peer-info: rearrange function
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
 src/openvpn/ssl.c | 229 +++++++++++++++++++++++++++-------------------
 1 file changed, 134 insertions(+), 95 deletions(-)

diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 33e145b3..45e76024 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1932,134 +1932,173 @@ push_peer_info(struct buffer *buf, struct tls_session *session)
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
+            struct env_set *es = session->opt->es;
+            /* push env vars that begin with UV_, IV_PLAT_VER= */
+            for (struct env_item *e = es->list; e != NULL; e = e->next)
+            {
+                /* ensure we have a string */
+                if (!e->string)
+                {
+                    continue;
+                }
 
-        /* push platform */
+                /* ensure string will fit output buffer */
+                if (!buf_safe(&out, strlen(e->string) + 1))
+                {
+                    continue;
+                }
+
+                /* don't accept any var except for those starting with UV_ or
+                 * IV_PLAT_VER= only
+                 */
+                if ((strncmp(e->string, "UV_", sizeof("UV_") - 1) != 0)
+                    && (strncmp(e->string, "IV_PLAT_VER=", sizeof("IV_PLAT_VER=") - 1) != 0))
+                {
+                    continue;
+                }
+
+                buf_printf(&out, "%s\n", e->string);
+            }
+        }
+        /* fall through */
+        case 2:
+        {
+            /* push version */
+            buf_printf(&out, "IV_VER=%s\n", PACKAGE_VERSION);
+
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
-
-        /* support for receiving push_reply before sending
-         * push request, also signal that the client wants
-         * to get push-reply messages without without requiring a round
-         * trip for a push request message*/
-        if (session->opt->pull)
-        {
-            iv_proto |= IV_PROTO_REQUEST_PUSH;
-            iv_proto |= IV_PROTO_AUTH_PENDING_KW;
-        }
+            /* push compression status */
+#ifdef USE_COMP
+            comp_generate_peer_info_string(&session->opt->comp_options, &out);
+#endif
 
-        /* support for Negotiable Crypto Parameters */
-        if (session->opt->mode == MODE_SERVER || session->opt->pull)
-        {
-            if (tls_item_in_cipher_list("AES-128-GCM", session->opt->config_ncp_ciphers)
-                && tls_item_in_cipher_list("AES-256-GCM", session->opt->config_ncp_ciphers))
+            struct env_set *es = session->opt->es;
+            /* push env vars that begin with IV_GUI_VER= and IV_SSO= */
+            for (struct env_item *e = es->list; e != NULL; e = e->next)
             {
+                /* ensure we have a string */
+                if (!e->string)
+                {
+                    continue;
+                }
+
+                /* ensure string will fit output buffer */
+                if (!buf_safe(&out, strlen(e->string) + 1))
+                {
+                    continue;
+                }
 
-                buf_printf(&out, "IV_NCP=2\n");
+                /* don't accept any var except for those starting with
+                 * IV_GUI_VER= or IV_SSO= only
+                 */
+                if ((strncmp(e->string, "IV_GUI_VER=", sizeof("IV_GUI_VER=") - 1) != 0)
+                    && (strncmp(e->string, "IV_SSO=", sizeof("IV_SSO=") - 1) != 0))
+                {
+                    continue;
+                }
+
+                buf_printf(&out, "%s\n", e->string);
             }
         }
-        else
+        /* fall through */
+        case 1:
         {
-            /* We are not using pull or p2mp server, instead do P2P NCP */
-            iv_proto |= IV_PROTO_NCP_P2P;
-        }
+            /* support for P_DATA_V2 */
+            int iv_proto = IV_PROTO_DATA_V2;
 
-        buf_printf(&out, "IV_CIPHERS=%s\n", session->opt->config_ncp_ciphers);
+            /* support for the --dns option */
+            iv_proto |= IV_PROTO_DNS_OPTION;
+
+            /* support for receiving push_reply before sending
+             * push request, also signal that the client wants
+             * to get push-reply messages without without requiring a round
+             * trip for a push request message*/
+            if (session->opt->pull)
+            {
+                iv_proto |= IV_PROTO_REQUEST_PUSH;
+                iv_proto |= IV_PROTO_AUTH_PENDING_KW;
+            }
+
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
-
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
-
-        if (!write_string(buf, BSTR(&out), -1))
-        {
-            goto error;
-        }
-    }
-    else
-    {
-        if (!write_empty_string(buf)) /* no peer info */
-        {
+            break;
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


