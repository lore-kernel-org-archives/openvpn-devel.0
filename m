From: Gert Doering <gert@...1296...>
Date: Wed, 18 Jun 2025 14:48:29 +0200
Message-ID: <20250618124835.24737-1-gert@...1296...>
In-Reply-To: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
References: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v24] dns: deal with --dhcp-options when
 --dns is active
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

From: Heiko Hund <heiko@...2662...>

Since --dns settings overrule DNS related --dhcp-options,
remove the latter when values were defined via --dns.

To stay as backward compatible as possible, we add foreign_options to
the script hook environment from the --dns values when a --up script
is defined. In that case the default --dns-updown is not run, even
when --dns values are present, to prevent double DNS configuration.
This way an existing --up script that deals with DNS can run, without
the immediate need to change after an openvpn upgrade and a server
pushing --dns options.

If you specify a custom --dns-updown, or force running the default
dns-updown that comes with openvpn, those compat env vars are not set
for --up scripts and the dns-updown command is run, even when there's
an --up script present.

Since Android uses the DNS values from tuntap_options, we always
override those with --dns stuff unconditionally. Also on Windows when
--ip-win32 is dynamic or adaptive, since DHCP relies on these as well.

Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Gert Doering <gert@...1296...>
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/904
This mail reflects revision 24 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 7cf1b63..939ae09 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -691,7 +691,8 @@
 static void
 run_up_down_command(bool up, struct options *o, const struct tuntap *tt, struct dns_updown_runner_info *updown_runner)
 {
-    if (!o->dns_options.updown)
+    struct dns_options *dns = &o->dns_options;
+    if (!dns->updown || (o->up_script && !dns->user_set_updown))
     {
         return;
     }
@@ -701,7 +702,7 @@
     if (!updown_runner->required)
     {
         /* Run dns updown directly */
-        status = do_run_up_down_command(up, NULL, &o->dns_options, tt);
+        status = do_run_up_down_command(up, NULL, dns, tt);
     }
     else
     {
@@ -852,6 +853,14 @@
     {
         return;
     }
+#ifdef _WIN32
+    /* Don't use iservice in DHCP mode */
+    struct tuntap_options *tto = &o->tuntap_options;
+    if (tto->ip_win32_type == IPW32_SET_DHCP_MASQ || tto->ip_win32_type == IPW32_SET_ADAPTIVE)
+    {
+        return;
+    }
+#endif
 
     /* Warn about adding servers of unsupported AF */
     const struct dns_server *s = o->dns_options.servers;
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 60f5471..688daa7 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -76,7 +76,28 @@
 #endif
 };
 
+#ifndef N_DHCP_ADDR
+#define N_DHCP_ADDR 4
+#endif
+
+#ifndef N_SEARCH_LIST_LEN
+#define N_SEARCH_LIST_LEN 10
+#endif
+
+struct dhcp_options {
+    in_addr_t dns[N_DHCP_ADDR];
+    int dns_len;
+
+    struct in6_addr dns6[N_DHCP_ADDR];
+    int dns6_len;
+
+    const char *domain;
+    const char *domain_search_list[N_SEARCH_LIST_LEN];
+    int domain_search_list_len;
+};
+
 struct dns_options {
+    struct dhcp_options from_dhcp;
     struct dns_domain *search_domains;
     struct dns_server *servers_prepull;
     struct dns_server *servers;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6ea01d4..d758a67 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1328,7 +1328,6 @@
 #endif /* ifndef ENABLE_SMALL */
 #endif /* ifdef _WIN32 */
 
-#if defined(_WIN32) || defined(TARGET_ANDROID)
 static void
 dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *len, int msglevel)
 {
@@ -1371,150 +1370,6 @@
     }
 }
 
-/*
- * If DNS options are set use these for TUN/TAP options as well.
- * Applies to DNS, DNS6 and DOMAIN-SEARCH.
- * Existing options will be discarded.
- */
-static void
-tuntap_options_copy_dns(struct options *o)
-{
-    struct tuntap_options *tt = &o->tuntap_options;
-    struct dns_options *dns = &o->dns_options;
-
-    if (dns->search_domains)
-    {
-        tt->domain_search_list_len = 0;
-        const struct dns_domain *domain = dns->search_domains;
-        while (domain && tt->domain_search_list_len < N_SEARCH_LIST_LEN)
-        {
-            tt->domain_search_list[tt->domain_search_list_len++] = domain->name;
-            domain = domain->next;
-        }
-        if (domain)
-        {
-            msg(M_WARN, "WARNING: couldn't copy all --dns search-domains to --dhcp-option");
-        }
-        tt->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
-    }
-
-    if (dns->servers)
-    {
-        tt->dns_len = 0;
-        tt->dns6_len = 0;
-        bool overflow = false;
-        const struct dns_server *server = dns->servers;
-        while (server)
-        {
-            for (int i = 0; i < server->addr_count; ++i)
-            {
-                if (server->addr[i].family == AF_INET)
-                {
-                    if (tt->dns_len >= N_DHCP_ADDR)
-                    {
-                        overflow = true;
-                        continue;
-                    }
-                    tt->dns[tt->dns_len++] = ntohl(server->addr[i].in.a4.s_addr);
-                }
-                else
-                {
-                    if (tt->dns6_len >= N_DHCP_ADDR)
-                    {
-                        overflow = true;
-                        continue;
-                    }
-                    tt->dns6[tt->dns6_len++] = server->addr[i].in.a6;
-                }
-            }
-            server = server->next;
-        }
-        if (overflow)
-        {
-            msg(M_WARN, "WARNING: couldn't copy all --dns server addresses to --dhcp-option");
-        }
-        tt->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
-    }
-}
-#else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
-static void
-foreign_options_copy_dns(struct options *o, struct env_set *es)
-{
-    const struct dns_domain *domain = o->dns_options.search_domains;
-    const struct dns_server *server = o->dns_options.servers;
-    if (!domain && !server)
-    {
-        return;
-    }
-
-    /* reset the index since we're starting all over again */
-    int opt_max = o->foreign_option_index;
-    o->foreign_option_index = 0;
-
-    for (int i = 1; i <= opt_max; ++i)
-    {
-        char name[32];
-        snprintf(name, sizeof(name), "foreign_option_%d", i);
-
-        const char *env_str = env_set_get(es, name);
-        const char *value = strchr(env_str, '=') + 1;
-        if ((domain && strstr(value, "dhcp-option DOMAIN-SEARCH") == value)
-            || (server && strstr(value, "dhcp-option DNS") == value))
-        {
-            setenv_del(es, name);
-        }
-        else
-        {
-            setenv_foreign_option(o, &value, 1, es);
-        }
-    }
-
-    struct gc_arena gc = gc_new();
-
-    while (server)
-    {
-        for (size_t i = 0; i < server->addr_count; ++i)
-        {
-            if (server->addr[i].family == AF_INET)
-            {
-                const char *argv[] = {
-                    "dhcp-option",
-                    "DNS",
-                    print_in_addr_t(server->addr[i].in.a4.s_addr, 0, &gc)
-                };
-                setenv_foreign_option(o, argv, 3, es);
-            }
-            else
-            {
-                const char *argv[] = {
-                    "dhcp-option",
-                    "DNS6",
-                    print_in6_addr(server->addr[i].in.a6, 0, &gc)
-                };
-                setenv_foreign_option(o, argv, 3, es);
-            }
-        }
-        server = server->next;
-    }
-    while (domain)
-    {
-        const char *argv[] = { "dhcp-option", "DOMAIN-SEARCH", domain->name };
-        setenv_foreign_option(o, argv, 3, es);
-        domain = domain->next;
-    }
-
-    gc_free(&gc);
-
-    /* remove old leftover entries */
-    while (o->foreign_option_index < opt_max)
-    {
-        char name[32];
-        snprintf(name, sizeof(name), "foreign_option_%d", opt_max--);
-        setenv_del(es, name);
-    }
-}
-#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
-
 #ifndef ENABLE_SMALL
 static const char *
 print_vlan_accept(enum vlan_acceptable_frames mode)
@@ -3603,6 +3458,260 @@
     }
 }
 
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+/**
+ * @brief Postprocess DNS related settings
+ *
+ * Set TUN/TAP DNS options with values from either --dns
+ * or --dhcp-option.
+ *
+ * @param o     pointer to the options struct
+ */
+static void
+tuntap_options_postprocess_dns(struct options *o)
+{
+    struct dns_options *dns = &o->dns_options;
+    struct tuntap_options *tt = &o->tuntap_options;
+    if (!dns->servers)
+    {
+        /* Copy --dhcp-options to tuntap_options */
+        struct dhcp_options *dhcp = &dns->from_dhcp;
+        assert(sizeof(dhcp->dns) == sizeof(tt->dns));
+        assert(sizeof(dhcp->dns6) == sizeof(tt->dns6));
+        assert(sizeof(dhcp->domain_search_list) == sizeof(tt->domain_search_list));
+
+        tt->domain = dhcp->domain;
+        tt->dns_len = dhcp->dns_len;
+        tt->dns6_len = dhcp->dns6_len;
+
+        memcpy(tt->dns, dhcp->dns, sizeof(tt->dns));
+        memcpy(tt->dns6, dhcp->dns6, sizeof(tt->dns6));
+
+        tt->domain_search_list_len = dhcp->domain_search_list_len;
+        for (size_t i = 0; i < SIZE(tt->domain_search_list); ++i)
+        {
+            tt->domain_search_list[i] = dhcp->domain_search_list[i];
+        }
+
+        return;
+    }
+
+#if defined(_WIN32)
+    if (tt->ip_win32_type != IPW32_SET_DHCP_MASQ && tt->ip_win32_type != IPW32_SET_ADAPTIVE)
+    {
+        return;     /* Not in DHCP mode */
+    }
+#endif /* if defined(_WIN32) */
+
+    /* Copy --dns options to tuntap_options */
+    const struct dns_domain *d = dns->search_domains;
+    while (d && tt->domain_search_list_len + 1 < N_SEARCH_LIST_LEN)
+    {
+        tt->domain_search_list[tt->domain_search_list_len++] = d->name;
+        d = d->next;
+    }
+    if (d)
+    {
+        msg(M_WARN, "WARNING: couldn't copy all --dns search-domains to TUN/TAP");
+    }
+
+    const struct dns_server *s = dns->servers;
+    while (s)
+    {
+        bool non_standard_server_port = false;
+        for (int i = 0; i < s->addr_count; ++i)
+        {
+            if (s->addr[i].port && s->addr[i].port != 53)
+            {
+                non_standard_server_port = true;
+                break;
+            }
+        }
+        if ((s->transport && s->transport != DNS_TRANSPORT_PLAIN)
+            || (s->dnssec && s->dnssec != DNS_SECURITY_NO)
+            || non_standard_server_port)
+        {
+            /* Skip servers requiring unsupported config to be set */
+            s = s->next;
+        }
+        else
+        {
+            bool overflow = false;
+            for (int i = 0; i < s->addr_count; ++i)
+            {
+                if (s->addr[i].family == AF_INET && tt->dns_len + 1 < N_DHCP_ADDR)
+                {
+                    tt->dns[tt->dns_len++] = s->addr[i].in.a4.s_addr;
+                }
+                else if (tt->dns6_len + 1 < N_DHCP_ADDR)
+                {
+                    tt->dns6[tt->dns6_len++] = s->addr[i].in.a6;
+                }
+                else
+                {
+                    overflow = true;
+                }
+            }
+            if (overflow)
+            {
+                msg(M_WARN, "WARNING: couldn't copy all --dns server addresses to TUN/TAP");
+            }
+            return;
+        }
+    }
+}
+
+#else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+
+/**
+ * @brief Postprocess DNS related settings
+ *
+ * Discard existing --dhcp-options from the env if needed and possibly
+ * replace them with values from --dns. If no --dns servers are set copy
+ * the --dhcp-option values over for --dns-updown runs.
+ *
+ * @param o     pointer to the options struct
+ * @param es    env set to modify potentially
+ */
+static void
+dhcp_options_postprocess_dns(struct options *o, struct env_set *es)
+{
+    struct gc_arena gc = gc_new();
+    struct dns_options *dns = &o->dns_options;
+
+    if (dns->servers || dns->user_set_updown)
+    {
+        /* Clean up env from --dhcp-option DNS config */
+        struct buffer name = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+        struct buffer value = alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+
+        const int fo_count = o->foreign_option_index;
+        o->foreign_option_index = 0;
+
+        for (int i = 1; i <= fo_count; ++i)
+        {
+            buf_clear(&name);
+            buf_printf(&name, "foreign_option_%d", i);
+            const char *env_str = env_set_get(es, BSTR(&name));
+            const char *item_val = strchr(env_str, '=') + 1;
+            buf_clear(&value);
+            buf_printf(&value, "%s", item_val);
+
+            /* Remove foreign option item from env set */
+            env_set_del(es, BSTR(&name));
+
+            item_val = BSTR(&value);
+            if (strncmp(item_val, "dhcp-option ", 12) != 0
+                || (strncmp(item_val + 12, "ADAPTER-DOMAIN-SUFFIX ", 22) != 0
+                    && strncmp(item_val + 12, "DOMAIN-SEARCH ", 14) != 0
+                    && strncmp(item_val + 12, "DOMAIN ", 7) != 0
+                    && strncmp(item_val + 12, "DNS6 ", 5) != 0
+                    && strncmp(item_val + 12, "DNS ", 4) != 0))
+            {
+                /* Re-set the item with potentially updated name */
+                buf_clear(&name);
+                buf_printf(&name, "foreign_option_%d", ++o->foreign_option_index);
+                setenv_str(es, BSTR(&name), BSTR(&value));
+            }
+        }
+    }
+
+    if (!dns->servers)
+    {
+        /* Copy --dhcp-options to dns_options */
+        struct dhcp_options *dhcp = &dns->from_dhcp;
+
+        if (dhcp->dns_len || dhcp->dns6_len)
+        {
+            struct dns_domain **entry = &dns->search_domains;
+            ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
+            struct dns_domain *new = *entry;
+            new->name = dhcp->domain;
+            entry = &new->next;
+
+            for (size_t i = 0; i < dhcp->domain_search_list_len; ++i)
+            {
+                ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
+                struct dns_domain *new = *entry;
+                new->name = dhcp->domain_search_list[i];
+                entry = &new->next;
+            }
+
+            struct dns_server *server = dns_server_get(&dns->servers, 0, &dns->gc);
+            const size_t max_addrs = SIZE(server->addr);
+            for (size_t i = 0; i < dhcp->dns_len && server->addr_count < max_addrs; ++i)
+            {
+                server->addr[server->addr_count].in.a4.s_addr = htonl(dhcp->dns[i]);
+                server->addr[server->addr_count].family = AF_INET;
+                server->addr_count += 1;
+            }
+            for (size_t i = 0; i < dhcp->dns6_len && server->addr_count < max_addrs; ++i)
+            {
+                server->addr[server->addr_count].in.a6 = dhcp->dns6[i];
+                server->addr[server->addr_count].family = AF_INET6;
+                server->addr_count += 1;
+            }
+        }
+    }
+    else if (o->up_script && !dns->user_set_updown)
+    {
+        /* Set foreign option env vars from --dns config */
+        const char *p[] = { "dhcp-option", NULL, NULL };
+        size_t p_len = sizeof(p) / sizeof(p[0]);
+
+        p[1] = "DOMAIN";
+        const struct dns_domain *d = dns->search_domains;
+        while (d)
+        {
+            p[2] = d->name;
+            setenv_foreign_option(o, (const char **)p, p_len, es);
+            d = d->next;
+        }
+
+        const struct dns_server *s = dns->servers;
+        while (s)
+        {
+            bool non_standard_server_port = false;
+            for (int i = 0; i < s->addr_count; ++i)
+            {
+                if (s->addr[i].port && s->addr[i].port != 53)
+                {
+                    non_standard_server_port = true;
+                    break;
+                }
+            }
+            if ((s->transport && s->transport != DNS_TRANSPORT_PLAIN)
+                || (s->dnssec && s->dnssec != DNS_SECURITY_NO)
+                || non_standard_server_port)
+            {
+                /* Skip servers requiring unsupported config to be set */
+                s = s->next;
+            }
+            else
+            {
+                for (int i = 0; i < s->addr_count; ++i)
+                {
+                    if (s->addr[i].family == AF_INET)
+                    {
+                        p[1] = "DNS";
+                        p[2] = print_in_addr_t(s->addr[i].in.a4.s_addr, IA_NET_ORDER, &gc);
+                    }
+                    else
+                    {
+                        p[1] = "DNS6";
+                        p[2] = print_in6_addr(s->addr[i].in.a6, 0, &gc);
+                    }
+                    setenv_foreign_option(o, (const char **)p, p_len, es);
+                }
+                break;
+            }
+        }
+    }
+
+    gc_free(&gc);
+}
+#endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+
 static void
 options_postprocess_mutate(struct options *o, struct env_set *es)
 {
@@ -3786,9 +3895,9 @@
     else
     {
 #if defined(_WIN32) || defined(TARGET_ANDROID)
-        tuntap_options_copy_dns(o);
+        tuntap_options_postprocess_dns(o);
 #else
-        foreign_options_copy_dns(o, es);
+        dhcp_options_postprocess_dns(o, es);
 #endif
     }
     if (o->auth_token_generate && !o->auth_token_renewal)
@@ -4171,9 +4280,9 @@
     {
         dns_options_postprocess_pull(&o->dns_options);
 #if defined(_WIN32) || defined(TARGET_ANDROID)
-        tuntap_options_copy_dns(o);
+        tuntap_options_postprocess_dns(o);
 #else
-        foreign_options_copy_dns(o, es);
+        dhcp_options_postprocess_dns(o, es);
 #endif
     }
     return success;
@@ -8162,18 +8271,43 @@
             goto err;
         }
     }
-#if defined(_WIN32) || defined(TARGET_ANDROID)
     else if (streq(p[0], "dhcp-option") && p[1])
     {
+        struct dhcp_options *dhcp = &options->dns_options.from_dhcp;
+#if defined(_WIN32) || defined(TARGET_ANDROID)
         struct tuntap_options *o = &options->tuntap_options;
+#endif
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
 
-        if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX"))
-            && p[2] && !p[3])
+        if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX")) && p[2] && !p[3])
         {
-            o->domain = p[2];
-            o->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
+            dhcp->domain = p[2];
         }
+        else if (streq(p[1], "DOMAIN-SEARCH") && p[2] && !p[3])
+        {
+            if (dhcp->domain_search_list_len < N_SEARCH_LIST_LEN)
+            {
+                dhcp->domain_search_list[dhcp->domain_search_list_len++] = p[2];
+            }
+            else
+            {
+                msg(msglevel, "--dhcp-option %s: maximum of %d search entries can be specified",
+                    p[1], N_SEARCH_LIST_LEN);
+            }
+        }
+        else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && !p[3]
+                 && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
+        {
+            if (strstr(p[2], ":"))
+            {
+                dhcp_option_dns6_parse(p[2], dhcp->dns6, &dhcp->dns6_len, msglevel);
+            }
+            else
+            {
+                dhcp_option_address_parse("DNS", p[2], dhcp->dns, &dhcp->dns_len, msglevel);
+            }
+        }
+#if defined(_WIN32) || defined(TARGET_ANDROID)
         else if (streq(p[1], "NBS") && p[2] && !p[3])
         {
             o->netbios_scope = p[2];
@@ -8191,23 +8325,9 @@
             o->netbios_node_type = t;
             o->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
         }
-        else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && !p[3]
-                 && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
-        {
-            if (strstr(p[2], ":"))
-            {
-                dhcp_option_dns6_parse(p[2], o->dns6, &o->dns6_len, msglevel);
-            }
-            else
-            {
-                dhcp_option_address_parse("DNS", p[2], o->dns, &o->dns_len, msglevel);
-                o->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
-            }
-        }
         else if (streq(p[1], "WINS") && p[2] && !p[3])
         {
             dhcp_option_address_parse("WINS", p[2], o->wins, &o->wins_len, msglevel);
-            o->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
         }
         else if (streq(p[1], "NTP") && p[2] && !p[3])
         {
@@ -8219,19 +8339,6 @@
             dhcp_option_address_parse("NBDD", p[2], o->nbdd, &o->nbdd_len, msglevel);
             o->dhcp_options |= DHCP_OPTIONS_DHCP_REQUIRED;
         }
-        else if (streq(p[1], "DOMAIN-SEARCH") && p[2] && !p[3])
-        {
-            if (o->domain_search_list_len < N_SEARCH_LIST_LEN)
-            {
-                o->domain_search_list[o->domain_search_list_len++] = p[2];
-            }
-            else
-            {
-                msg(msglevel, "--dhcp-option %s: maximum of %d search entries can be specified",
-                    p[1], N_SEARCH_LIST_LEN);
-            }
-            o->dhcp_options |= DHCP_OPTIONS_DHCP_OPTIONAL;
-        }
         else if (streq(p[1], "DISABLE-NBT") && !p[2])
         {
             o->disable_nbt = 1;
@@ -8249,8 +8356,10 @@
             msg(msglevel, "--dhcp-option: unknown option type '%s' or missing or unknown parameter", p[1]);
             goto err;
         }
-    }
+#else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+        setenv_foreign_option(options, (const char **)p, 3, es);
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+    }
 #ifdef _WIN32
     else if (streq(p[0], "show-adapters") && !p[1])
     {

