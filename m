From: Gert Doering <gert@...1296...>
Date: Tue, 29 Jul 2025 12:41:01 +0200
Message-ID: <20250729104110.27704-1-gert@...1296...>
In-Reply-To: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
References: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v23] PUSH_UPDATE: Added update_option()
 function.
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

From: Marco Baffo <marco@...2726...>

When the function receives an option to update, it first checks whether it has
already received an option of the same type within the same update message.
If it has already received it, it simply calls add_option(), otherwise it
deletes all the values ​​already present regarding that option.

Change-Id: Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/810
This mail reflects revision 23 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3a8ce86..f056263 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5372,6 +5372,20 @@
               struct env_set *es);
 
 static void
+update_option(struct context *c,
+              struct options *options,
+              char *p[],
+              bool is_inline,
+              const char *file,
+              int line,
+              const int level,
+              const int msglevel,
+              const unsigned int permission_mask,
+              unsigned int *option_types_found,
+              struct env_set *es,
+              unsigned int *update_options_found);
+
+static void
 read_config_file(struct options *options,
                  const char *file,
                  int level,
@@ -5557,6 +5571,7 @@
     int line_num = 0;
     const char *file = "[PUSH-OPTIONS]";
     const int msglevel = D_PUSH_ERRORS|M_OPTERR;
+    unsigned int update_options_found = 0;
 
     while (buf_parse(buf, ',', line, sizeof(line)))
     {
@@ -5602,6 +5617,11 @@
                 remove_option(c, options, p, false, file, line_num, msglevel,
                               permission_mask, option_types_found, es);
             }
+            else
+            {
+                update_option(c, options, p, false, file, line_num, 0, msglevel,
+                              permission_mask, option_types_found, es, &update_options_found);
+            }
         }
     }
     return true;
@@ -5740,6 +5760,13 @@
     return options->forward_compatible ? M_WARN : msglevel;
 }
 
+#define RESET_OPTION_ROUTES(option_ptr, field) \
+    if (option_ptr)                        \
+    {                                      \
+        option_ptr->field = NULL;          \
+        option_ptr->flags = 0;             \
+    }
+
 /**
  * @brief Resets options found in the PUSH_UPDATE message that are preceded by the `-` flag.
  *        This function is used in push-updates to reset specified options.
@@ -5794,11 +5821,7 @@
             delete_routes_v4(c->c1.route_list, c->c1.tuntap,
                              ROUTE_OPTION_FLAGS(&c->options),
                              es, &c->net_ctx);
-            if (options->routes)
-            {
-                options->routes->routes = NULL;
-                options->routes->flags = 0;
-            }
+            RESET_OPTION_ROUTES(options->routes, routes);
         }
     }
     else if (streq(p[0], "route-ipv6") && !p[1])
@@ -5809,11 +5832,7 @@
             delete_routes_v6(c->c1.route_ipv6_list, c->c1.tuntap,
                              ROUTE_OPTION_FLAGS(&c->options),
                              es, &c->net_ctx);
-            if (options->routes_ipv6)
-            {
-                options->routes_ipv6->routes_ipv6 = NULL;
-                options->routes_ipv6->flags = 0;
-            }
+            RESET_OPTION_ROUTES(options->routes_ipv6, routes_ipv6);
         }
     }
     else if (streq(p[0], "route-gateway") && !p[1])
@@ -5933,6 +5952,303 @@
     msg(msglevel, "Error occurred trying to remove %s option", p[0]);
 }
 
+
+static bool
+check_route_option(struct options *options, char *p[], const int msglevel, bool pull_mode)
+{
+    rol_check_alloc(options);
+    if (pull_mode)
+    {
+        if (!ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn) && !is_special_addr(p[1])) /* FQDN -- may be DNS name */
+        {
+            msg(msglevel, "route parameter network/IP '%s' must be a valid address", p[1]);
+            return false;
+        }
+        if (p[2] && !ip_addr_dotted_quad_safe(p[2])) /* FQDN -- must be IP address */
+        {
+            msg(msglevel, "route parameter netmask '%s' must be an IP address", p[2]);
+            return false;
+        }
+        if (p[3] && !ip_or_dns_addr_safe(p[3], options->allow_pull_fqdn) && !is_special_addr(p[3])) /* FQDN -- may be DNS name */
+        {
+            msg(msglevel, "route parameter gateway '%s' must be a valid address", p[3]);
+            return false;
+        }
+    }
+    return true;
+}
+
+
+static bool
+check_route6_option(struct options *options, char *p[], const int msglevel, bool pull_mode)
+{
+    rol6_check_alloc(options);
+    if (pull_mode)
+    {
+        if (!ipv6_addr_safe_hexplusbits(p[1]))
+        {
+            msg(msglevel, "route-ipv6 parameter network/IP '%s' must be a valid address", p[1]);
+            return false;
+        }
+        if (p[2] && !ipv6_addr_safe(p[2]))
+        {
+            msg(msglevel, "route-ipv6 parameter gateway '%s' must be a valid address", p[2]);
+            return false;
+        }
+        /* p[3] is metric, if present */
+    }
+    return true;
+}
+
+static bool
+check_dns_option(struct options *options, char *p[], const int msglevel, bool pull_mode)
+{
+    if (streq(p[1], "search-domains") && p[2])
+    {
+        dns_domain_list_append(&options->dns_options.search_domains, &p[2], &options->dns_options.gc);
+    }
+    else if (streq(p[1], "server") && p[2] && p[3] && p[4])
+    {
+        long priority;
+        if (!dns_server_priority_parse(&priority, p[2], pull_mode))
+        {
+            msg(msglevel, "--dns server: invalid priority value '%s'", p[2]);
+            return false;
+        }
+
+        struct dns_server *server = dns_server_get(&options->dns_options.servers, priority, &options->dns_options.gc);
+
+        if (streq(p[3], "address") && p[4])
+        {
+            for (int i = 4; p[i]; ++i)
+            {
+                if (!dns_server_addr_parse(server, p[i]))
+                {
+                    msg(msglevel, "--dns server %ld: malformed address or maximum exceeded '%s'", priority, p[i]);
+                    return false;
+                }
+            }
+        }
+        else if (streq(p[3], "resolve-domains"))
+        {
+            dns_domain_list_append(&server->domains, &p[4], &options->dns_options.gc);
+        }
+        else if (streq(p[3], "dnssec") && !p[5])
+        {
+            if (streq(p[4], "yes"))
+            {
+                server->dnssec = DNS_SECURITY_YES;
+            }
+            else if (streq(p[4], "no"))
+            {
+                server->dnssec = DNS_SECURITY_NO;
+            }
+            else if (streq(p[4], "optional"))
+            {
+                server->dnssec = DNS_SECURITY_OPTIONAL;
+            }
+            else
+            {
+                msg(msglevel, "--dns server %ld: malformed dnssec value '%s'", priority, p[4]);
+                return false;
+            }
+        }
+        else if (streq(p[3], "transport") && !p[5])
+        {
+            if (streq(p[4], "plain"))
+            {
+                server->transport = DNS_TRANSPORT_PLAIN;
+            }
+            else if (streq(p[4], "DoH"))
+            {
+                server->transport = DNS_TRANSPORT_HTTPS;
+            }
+            else if (streq(p[4], "DoT"))
+            {
+                server->transport = DNS_TRANSPORT_TLS;
+            }
+            else
+            {
+                msg(msglevel, "--dns server %ld: malformed transport value '%s'", priority, p[4]);
+                return false;
+            }
+        }
+        else if (streq(p[3], "sni") && !p[5])
+        {
+            server->sni = p[4];
+        }
+        else
+        {
+            msg(msglevel, "--dns server %ld: unknown option type '%s' or missing or unknown parameter", priority, p[3]);
+            return false;
+        }
+    }
+    else
+    {
+        msg(msglevel, "--dns: unknown option type '%s' or missing or unknown parameter", p[1]);
+        return false;
+    }
+    return true;
+}
+
+/**
+ * @brief Processes an option to update. It first checks whether it has already
+ *        received an option of the same type within the same update message.
+ *        If the option has already been received, it calls add_option().
+ *        Otherwise, it deletes all existing values related to that option before calling add_option().
+ *
+ * @param c The context structure.
+ * @param options A pointer to the options structure.
+ * @param p An array of strings containing the options and their parameters.
+ * @param is_inline A boolean indicating if the option is inline.
+ * @param file The file where the function is called.
+ * @param line The line number where the function is called.
+ * @param level The level of the option.
+ * @param msglevel The message level for logging.
+ * @param permission_mask The permission mask used by VERIFY_PERMISSION().
+ * @param option_types_found A pointer to the variable where the flags corresponding to the options found are stored.
+ * @param es The environment set structure.
+ * @param update_options_found A pointer to the variable where the flags corresponding to the update options found are stored,
+ *                             used to check if an option of the same type has already been processed by update_option() within the same push-update message.
+ */
+static void
+update_option(struct context *c,
+              struct options *options,
+              char *p[],
+              bool is_inline,
+              const char *file,
+              int line,
+              const int level,
+              const int msglevel,
+              const unsigned int permission_mask,
+              unsigned int *option_types_found,
+              struct env_set *es,
+              unsigned int *update_options_found)
+{
+    const bool pull_mode = BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
+    ASSERT(MAX_PARMS >= 7);
+
+    if (streq(p[0], "route") && p[1] && !p[5])
+    {
+        if (!(*update_options_found & OPT_P_U_ROUTE))
+        {
+            VERIFY_PERMISSION(OPT_P_ROUTE);
+            if (!check_route_option(options, p, msglevel, pull_mode))
+            {
+                goto err;
+            }
+            if (c->c1.route_list)
+            {
+                delete_routes_v4(c->c1.route_list, c->c1.tuntap,
+                                 ROUTE_OPTION_FLAGS(&c->options),
+                                 es, &c->net_ctx);
+                RESET_OPTION_ROUTES(options->routes, routes);
+            }
+            *update_options_found |= OPT_P_U_ROUTE;
+        }
+    }
+    else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
+    {
+        if (!(*update_options_found & OPT_P_U_ROUTE6))
+        {
+            VERIFY_PERMISSION(OPT_P_ROUTE);
+            if (!check_route6_option(options, p, msglevel, pull_mode))
+            {
+                goto err;
+            }
+            if (c->c1.route_ipv6_list)
+            {
+                delete_routes_v6(c->c1.route_ipv6_list, c->c1.tuntap,
+                                 ROUTE_OPTION_FLAGS(&c->options),
+                                 es, &c->net_ctx);
+                RESET_OPTION_ROUTES(options->routes_ipv6, routes_ipv6);
+            }
+            *update_options_found |= OPT_P_U_ROUTE6;
+        }
+    }
+    else if (streq(p[0], "redirect-gateway") || streq(p[0], "redirect-private"))
+    {
+        if (!(*update_options_found & OPT_P_U_REDIR_GATEWAY))
+        {
+            VERIFY_PERMISSION(OPT_P_ROUTE);
+            if (options->routes)
+            {
+                options->routes->flags = 0;
+            }
+            if (options->routes_ipv6)
+            {
+                options->routes_ipv6->flags = 0;
+            }
+            *update_options_found |= OPT_P_U_REDIR_GATEWAY;
+        }
+    }
+    else if (streq(p[0], "dns") && p[1])
+    {
+        if (!(*update_options_found & OPT_P_U_DNS))
+        {
+            VERIFY_PERMISSION(OPT_P_DHCPDNS);
+            if (!check_dns_option(options, p, msglevel, pull_mode))
+            {
+                goto err;
+            }
+            gc_free(&options->dns_options.gc);
+            CLEAR(options->dns_options);
+            *update_options_found |= OPT_P_U_DNS;
+        }
+    }
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+    else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
+    {
+        if (!(*update_options_found & OPT_P_U_DHCP))
+        {
+            struct tuntap_options *o = &options->tuntap_options;
+            VERIFY_PERMISSION(OPT_P_DHCPDNS);
+
+            o->domain = NULL;
+            o->netbios_scope = NULL;
+            o->netbios_node_type = 0;
+            o->dns6_len = 0;
+            CLEAR(o->dns6);
+            o->dns_len = 0;
+            CLEAR(o->dns);
+            o->wins_len = 0;
+            CLEAR(o->wins);
+            o->ntp_len = 0;
+            CLEAR(o->ntp);
+            o->nbdd_len = 0;
+            CLEAR(o->nbdd);
+            while (o->domain_search_list_len-- > 0)
+            {
+                o->domain_search_list[o->domain_search_list_len] = NULL;
+            }
+            o->disable_nbt = 0;
+            o->dhcp_options = 0;
+#if defined(TARGET_ANDROID)
+            o->http_proxy_port = 0;
+            o->http_proxy = NULL;
+#endif
+            *update_options_found |= OPT_P_U_DHCP;
+        }
+    }
+#else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+    else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
+    {
+        if (!(*update_options_found & OPT_P_U_DHCP))
+        {
+            VERIFY_PERMISSION(OPT_P_DHCPDNS);
+            delete_all_dhcp_fo(options, &es->list);
+            *update_options_found |= OPT_P_U_DHCP;
+        }
+    }
+#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+    add_option(options, p, is_inline, file, line,
+               level, msglevel, permission_mask,
+               option_types_found, es);
+    return;
+err:
+    msg(msglevel, "Error occurred trying to update %s option", p[0]);
+}
+
 static void
 set_user_script(struct options *options,
                 const char **script,
@@ -7296,45 +7612,18 @@
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        rol_check_alloc(options);
-        if (pull_mode)
+        if (!check_route_option(options, p, msglevel, pull_mode))
         {
-            if (!ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn) && !is_special_addr(p[1])) /* FQDN -- may be DNS name */
-            {
-                msg(msglevel, "route parameter network/IP '%s' must be a valid address", p[1]);
-                goto err;
-            }
-            if (p[2] && !ip_addr_dotted_quad_safe(p[2])) /* FQDN -- must be IP address */
-            {
-                msg(msglevel, "route parameter netmask '%s' must be an IP address", p[2]);
-                goto err;
-            }
-            if (p[3] && !ip_or_dns_addr_safe(p[3], options->allow_pull_fqdn) && !is_special_addr(p[3])) /* FQDN -- may be DNS name */
-            {
-                msg(msglevel, "route parameter gateway '%s' must be a valid address", p[3]);
-                goto err;
-            }
-            /* p[4] is metric, if specified */
+            goto err;
         }
         add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4], options->route_default_table_id);
     }
     else if (streq(p[0], "route-ipv6") && p[1] && !p[4])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        rol6_check_alloc(options);
-        if (pull_mode)
+        if (!check_route6_option(options, p, msglevel, pull_mode))
         {
-            if (!ipv6_addr_safe_hexplusbits(p[1]))
-            {
-                msg(msglevel, "route-ipv6 parameter network/IP '%s' must be a valid address", p[1]);
-                goto err;
-            }
-            if (p[2] && !ipv6_addr_safe(p[2]))
-            {
-                msg(msglevel, "route-ipv6 parameter gateway '%s' must be a valid address", p[2]);
-                goto err;
-            }
-            /* p[3] is metric, if specified */
+            goto err;
         }
         add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[3], options->route_default_table_id);
     }
@@ -8422,90 +8711,8 @@
     else if (streq(p[0], "dns") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-
-        if (streq(p[1], "search-domains") && p[2])
+        if (!check_dns_option(options, p, msglevel, pull_mode))
         {
-            dns_domain_list_append(&options->dns_options.search_domains, &p[2], &options->dns_options.gc);
-        }
-        else if (streq(p[1], "server") && p[2] && p[3] && p[4])
-        {
-            long priority;
-            if (!dns_server_priority_parse(&priority, p[2], pull_mode))
-            {
-                msg(msglevel, "--dns server: invalid priority value '%s'", p[2]);
-                goto err;
-            }
-
-            struct dns_server *server = dns_server_get(&options->dns_options.servers, priority, &options->dns_options.gc);
-
-            if (streq(p[3], "address") && p[4])
-            {
-                for (int i = 4; p[i]; ++i)
-                {
-                    if (!dns_server_addr_parse(server, p[i]))
-                    {
-                        msg(msglevel, "--dns server %ld: malformed address or maximum exceeded '%s'", priority, p[i]);
-                        goto err;
-                    }
-                }
-            }
-            else if (streq(p[3], "resolve-domains"))
-            {
-                dns_domain_list_append(&server->domains, &p[4], &options->dns_options.gc);
-            }
-            else if (streq(p[3], "dnssec") && !p[5])
-            {
-                if (streq(p[4], "yes"))
-                {
-                    server->dnssec = DNS_SECURITY_YES;
-                }
-                else if (streq(p[4], "no"))
-                {
-                    server->dnssec = DNS_SECURITY_NO;
-                }
-                else if (streq(p[4], "optional"))
-                {
-                    server->dnssec = DNS_SECURITY_OPTIONAL;
-                }
-                else
-                {
-                    msg(msglevel, "--dns server %ld: malformed dnssec value '%s'", priority, p[4]);
-                    goto err;
-                }
-            }
-            else if (streq(p[3], "transport") && !p[5])
-            {
-                if (streq(p[4], "plain"))
-                {
-                    server->transport = DNS_TRANSPORT_PLAIN;
-                }
-                else if (streq(p[4], "DoH"))
-                {
-                    server->transport = DNS_TRANSPORT_HTTPS;
-                }
-                else if (streq(p[4], "DoT"))
-                {
-                    server->transport = DNS_TRANSPORT_TLS;
-                }
-                else
-                {
-                    msg(msglevel, "--dns server %ld: malformed transport value '%s'", priority, p[4]);
-                    goto err;
-                }
-            }
-            else if (streq(p[3], "sni") && !p[5])
-            {
-                server->sni = p[4];
-            }
-            else
-            {
-                msg(msglevel, "--dns server %ld: unknown option type '%s' or missing or unknown parameter", priority, p[3]);
-                goto err;
-            }
-        }
-        else
-        {
-            msg(msglevel, "--dns: unknown option type '%s' or missing or unknown parameter", p[1]);
             goto err;
         }
     }

