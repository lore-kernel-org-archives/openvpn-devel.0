From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 18 Jun 2025 13:01:12 +0000
In-Reply-To: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
References: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <4de68b41e43fb1ac51200b07fd4a0b8f041ed39a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4jTEiyp3ric="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: deal with
 --dhcp-options when --dns is active
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4jTEiyp3ric=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/90=
4?usp=3Demail )

Change subject: dns: deal with --dhcp-options when --dns is active
......................................................................

dns: deal with --dhcp-options when --dns is active

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
Message-Id: <20250618124835.24737-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
922.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
3 files changed, 323 insertions(+), 184 deletions(-)




diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 7cf1b63..939ae09 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -691,7 +691,8 @@
 static void
 run_up_down_command(bool up, struct options *o, const struct tuntap *tt, s=
truct dns_updown_runner_info *updown_runner)
 {
-    if (!o->dns_options.updown)
+    struct dns_options *dns =3D &o->dns_options;
+    if (!dns->updown || (o->up_script && !dns->user_set_updown))
     {
         return;
     }
@@ -701,7 +702,7 @@
     if (!updown_runner->required)
     {
         /* Run dns updown directly */
-        status =3D do_run_up_down_command(up, NULL, &o->dns_options, tt);
+        status =3D do_run_up_down_command(up, NULL, dns, tt);
     }
     else
     {
@@ -852,6 +853,14 @@
     {
         return;
     }
+#ifdef _WIN32
+    /* Don't use iservice in DHCP mode */
+    struct tuntap_options *tto =3D &o->tuntap_options;
+    if (tto->ip_win32_type =3D=3D IPW32_SET_DHCP_MASQ || tto->ip_win32_typ=
e =3D=3D IPW32_SET_ADAPTIVE)
+    {
+        return;
+    }
+#endif

     /* Warn about adding servers of unsupported AF */
     const struct dns_server *s =3D o->dns_options.servers;
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
 dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *=
len, int msglevel)
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
-    struct tuntap_options *tt =3D &o->tuntap_options;
-    struct dns_options *dns =3D &o->dns_options;
-
-    if (dns->search_domains)
-    {
-        tt->domain_search_list_len =3D 0;
-        const struct dns_domain *domain =3D dns->search_domains;
-        while (domain && tt->domain_search_list_len < N_SEARCH_LIST_LEN)
-        {
-            tt->domain_search_list[tt->domain_search_list_len++] =3D domai=
n->name;
-            domain =3D domain->next;
-        }
-        if (domain)
-        {
-            msg(M_WARN, "WARNING: couldn't copy all --dns search-domains t=
o --dhcp-option");
-        }
-        tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;
-    }
-
-    if (dns->servers)
-    {
-        tt->dns_len =3D 0;
-        tt->dns6_len =3D 0;
-        bool overflow =3D false;
-        const struct dns_server *server =3D dns->servers;
-        while (server)
-        {
-            for (int i =3D 0; i < server->addr_count; ++i)
-            {
-                if (server->addr[i].family =3D=3D AF_INET)
-                {
-                    if (tt->dns_len >=3D N_DHCP_ADDR)
-                    {
-                        overflow =3D true;
-                        continue;
-                    }
-                    tt->dns[tt->dns_len++] =3D ntohl(server->addr[i].in.a4=
.s_addr);
-                }
-                else
-                {
-                    if (tt->dns6_len >=3D N_DHCP_ADDR)
-                    {
-                        overflow =3D true;
-                        continue;
-                    }
-                    tt->dns6[tt->dns6_len++] =3D server->addr[i].in.a6;
-                }
-            }
-            server =3D server->next;
-        }
-        if (overflow)
-        {
-            msg(M_WARN, "WARNING: couldn't copy all --dns server addresses=
 to --dhcp-option");
-        }
-        tt->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
-    }
-}
-#else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
-static void
-foreign_options_copy_dns(struct options *o, struct env_set *es)
-{
-    const struct dns_domain *domain =3D o->dns_options.search_domains;
-    const struct dns_server *server =3D o->dns_options.servers;
-    if (!domain && !server)
-    {
-        return;
-    }
-
-    /* reset the index since we're starting all over again */
-    int opt_max =3D o->foreign_option_index;
-    o->foreign_option_index =3D 0;
-
-    for (int i =3D 1; i <=3D opt_max; ++i)
-    {
-        char name[32];
-        snprintf(name, sizeof(name), "foreign_option_%d", i);
-
-        const char *env_str =3D env_set_get(es, name);
-        const char *value =3D strchr(env_str, '=3D') + 1;
-        if ((domain && strstr(value, "dhcp-option DOMAIN-SEARCH") =3D=3D v=
alue)
-            || (server && strstr(value, "dhcp-option DNS") =3D=3D value))
-        {
-            setenv_del(es, name);
-        }
-        else
-        {
-            setenv_foreign_option(o, &value, 1, es);
-        }
-    }
-
-    struct gc_arena gc =3D gc_new();
-
-    while (server)
-    {
-        for (size_t i =3D 0; i < server->addr_count; ++i)
-        {
-            if (server->addr[i].family =3D=3D AF_INET)
-            {
-                const char *argv[] =3D {
-                    "dhcp-option",
-                    "DNS",
-                    print_in_addr_t(server->addr[i].in.a4.s_addr, 0, &gc)
-                };
-                setenv_foreign_option(o, argv, 3, es);
-            }
-            else
-            {
-                const char *argv[] =3D {
-                    "dhcp-option",
-                    "DNS6",
-                    print_in6_addr(server->addr[i].in.a6, 0, &gc)
-                };
-                setenv_foreign_option(o, argv, 3, es);
-            }
-        }
-        server =3D server->next;
-    }
-    while (domain)
-    {
-        const char *argv[] =3D { "dhcp-option", "DOMAIN-SEARCH", domain->n=
ame };
-        setenv_foreign_option(o, argv, 3, es);
-        domain =3D domain->next;
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
+    struct dns_options *dns =3D &o->dns_options;
+    struct tuntap_options *tt =3D &o->tuntap_options;
+    if (!dns->servers)
+    {
+        /* Copy --dhcp-options to tuntap_options */
+        struct dhcp_options *dhcp =3D &dns->from_dhcp;
+        assert(sizeof(dhcp->dns) =3D=3D sizeof(tt->dns));
+        assert(sizeof(dhcp->dns6) =3D=3D sizeof(tt->dns6));
+        assert(sizeof(dhcp->domain_search_list) =3D=3D sizeof(tt->domain_s=
earch_list));
+
+        tt->domain =3D dhcp->domain;
+        tt->dns_len =3D dhcp->dns_len;
+        tt->dns6_len =3D dhcp->dns6_len;
+
+        memcpy(tt->dns, dhcp->dns, sizeof(tt->dns));
+        memcpy(tt->dns6, dhcp->dns6, sizeof(tt->dns6));
+
+        tt->domain_search_list_len =3D dhcp->domain_search_list_len;
+        for (size_t i =3D 0; i < SIZE(tt->domain_search_list); ++i)
+        {
+            tt->domain_search_list[i] =3D dhcp->domain_search_list[i];
+        }
+
+        return;
+    }
+
+#if defined(_WIN32)
+    if (tt->ip_win32_type !=3D IPW32_SET_DHCP_MASQ && tt->ip_win32_type !=
=3D IPW32_SET_ADAPTIVE)
+    {
+        return;     /* Not in DHCP mode */
+    }
+#endif /* if defined(_WIN32) */
+
+    /* Copy --dns options to tuntap_options */
+    const struct dns_domain *d =3D dns->search_domains;
+    while (d && tt->domain_search_list_len + 1 < N_SEARCH_LIST_LEN)
+    {
+        tt->domain_search_list[tt->domain_search_list_len++] =3D d->name;
+        d =3D d->next;
+    }
+    if (d)
+    {
+        msg(M_WARN, "WARNING: couldn't copy all --dns search-domains to TU=
N/TAP");
+    }
+
+    const struct dns_server *s =3D dns->servers;
+    while (s)
+    {
+        bool non_standard_server_port =3D false;
+        for (int i =3D 0; i < s->addr_count; ++i)
+        {
+            if (s->addr[i].port && s->addr[i].port !=3D 53)
+            {
+                non_standard_server_port =3D true;
+                break;
+            }
+        }
+        if ((s->transport && s->transport !=3D DNS_TRANSPORT_PLAIN)
+            || (s->dnssec && s->dnssec !=3D DNS_SECURITY_NO)
+            || non_standard_server_port)
+        {
+            /* Skip servers requiring unsupported config to be set */
+            s =3D s->next;
+        }
+        else
+        {
+            bool overflow =3D false;
+            for (int i =3D 0; i < s->addr_count; ++i)
+            {
+                if (s->addr[i].family =3D=3D AF_INET && tt->dns_len + 1 < =
N_DHCP_ADDR)
+                {
+                    tt->dns[tt->dns_len++] =3D s->addr[i].in.a4.s_addr;
+                }
+                else if (tt->dns6_len + 1 < N_DHCP_ADDR)
+                {
+                    tt->dns6[tt->dns6_len++] =3D s->addr[i].in.a6;
+                }
+                else
+                {
+                    overflow =3D true;
+                }
+            }
+            if (overflow)
+            {
+                msg(M_WARN, "WARNING: couldn't copy all --dns server addre=
sses to TUN/TAP");
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
+    struct gc_arena gc =3D gc_new();
+    struct dns_options *dns =3D &o->dns_options;
+
+    if (dns->servers || dns->user_set_updown)
+    {
+        /* Clean up env from --dhcp-option DNS config */
+        struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+        struct buffer value =3D alloc_buf_gc(OPTION_PARM_SIZE, &gc);
+
+        const int fo_count =3D o->foreign_option_index;
+        o->foreign_option_index =3D 0;
+
+        for (int i =3D 1; i <=3D fo_count; ++i)
+        {
+            buf_clear(&name);
+            buf_printf(&name, "foreign_option_%d", i);
+            const char *env_str =3D env_set_get(es, BSTR(&name));
+            const char *item_val =3D strchr(env_str, '=3D') + 1;
+            buf_clear(&value);
+            buf_printf(&value, "%s", item_val);
+
+            /* Remove foreign option item from env set */
+            env_set_del(es, BSTR(&name));
+
+            item_val =3D BSTR(&value);
+            if (strncmp(item_val, "dhcp-option ", 12) !=3D 0
+                || (strncmp(item_val + 12, "ADAPTER-DOMAIN-SUFFIX ", 22) !=
=3D 0
+                    && strncmp(item_val + 12, "DOMAIN-SEARCH ", 14) !=3D 0
+                    && strncmp(item_val + 12, "DOMAIN ", 7) !=3D 0
+                    && strncmp(item_val + 12, "DNS6 ", 5) !=3D 0
+                    && strncmp(item_val + 12, "DNS ", 4) !=3D 0))
+            {
+                /* Re-set the item with potentially updated name */
+                buf_clear(&name);
+                buf_printf(&name, "foreign_option_%d", ++o->foreign_option=
_index);
+                setenv_str(es, BSTR(&name), BSTR(&value));
+            }
+        }
+    }
+
+    if (!dns->servers)
+    {
+        /* Copy --dhcp-options to dns_options */
+        struct dhcp_options *dhcp =3D &dns->from_dhcp;
+
+        if (dhcp->dns_len || dhcp->dns6_len)
+        {
+            struct dns_domain **entry =3D &dns->search_domains;
+            ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
+            struct dns_domain *new =3D *entry;
+            new->name =3D dhcp->domain;
+            entry =3D &new->next;
+
+            for (size_t i =3D 0; i < dhcp->domain_search_list_len; ++i)
+            {
+                ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain, &dns->gc);
+                struct dns_domain *new =3D *entry;
+                new->name =3D dhcp->domain_search_list[i];
+                entry =3D &new->next;
+            }
+
+            struct dns_server *server =3D dns_server_get(&dns->servers, 0,=
 &dns->gc);
+            const size_t max_addrs =3D SIZE(server->addr);
+            for (size_t i =3D 0; i < dhcp->dns_len && server->addr_count <=
 max_addrs; ++i)
+            {
+                server->addr[server->addr_count].in.a4.s_addr =3D htonl(dh=
cp->dns[i]);
+                server->addr[server->addr_count].family =3D AF_INET;
+                server->addr_count +=3D 1;
+            }
+            for (size_t i =3D 0; i < dhcp->dns6_len && server->addr_count =
< max_addrs; ++i)
+            {
+                server->addr[server->addr_count].in.a6 =3D dhcp->dns6[i];
+                server->addr[server->addr_count].family =3D AF_INET6;
+                server->addr_count +=3D 1;
+            }
+        }
+    }
+    else if (o->up_script && !dns->user_set_updown)
+    {
+        /* Set foreign option env vars from --dns config */
+        const char *p[] =3D { "dhcp-option", NULL, NULL };
+        size_t p_len =3D sizeof(p) / sizeof(p[0]);
+
+        p[1] =3D "DOMAIN";
+        const struct dns_domain *d =3D dns->search_domains;
+        while (d)
+        {
+            p[2] =3D d->name;
+            setenv_foreign_option(o, (const char **)p, p_len, es);
+            d =3D d->next;
+        }
+
+        const struct dns_server *s =3D dns->servers;
+        while (s)
+        {
+            bool non_standard_server_port =3D false;
+            for (int i =3D 0; i < s->addr_count; ++i)
+            {
+                if (s->addr[i].port && s->addr[i].port !=3D 53)
+                {
+                    non_standard_server_port =3D true;
+                    break;
+                }
+            }
+            if ((s->transport && s->transport !=3D DNS_TRANSPORT_PLAIN)
+                || (s->dnssec && s->dnssec !=3D DNS_SECURITY_NO)
+                || non_standard_server_port)
+            {
+                /* Skip servers requiring unsupported config to be set */
+                s =3D s->next;
+            }
+            else
+            {
+                for (int i =3D 0; i < s->addr_count; ++i)
+                {
+                    if (s->addr[i].family =3D=3D AF_INET)
+                    {
+                        p[1] =3D "DNS";
+                        p[2] =3D print_in_addr_t(s->addr[i].in.a4.s_addr, =
IA_NET_ORDER, &gc);
+                    }
+                    else
+                    {
+                        p[1] =3D "DNS6";
+                        p[2] =3D print_in6_addr(s->addr[i].in.a6, 0, &gc);
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
+        struct dhcp_options *dhcp =3D &options->dns_options.from_dhcp;
+#if defined(_WIN32) || defined(TARGET_ANDROID)
         struct tuntap_options *o =3D &options->tuntap_options;
+#endif
         VERIFY_PERMISSION(OPT_P_DHCPDNS);

-        if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX"))
-            && p[2] && !p[3])
+        if ((streq(p[1], "DOMAIN") || streq(p[1], "ADAPTER_DOMAIN_SUFFIX")=
) && p[2] && !p[3])
         {
-            o->domain =3D p[2];
-            o->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
+            dhcp->domain =3D p[2];
         }
+        else if (streq(p[1], "DOMAIN-SEARCH") && p[2] && !p[3])
+        {
+            if (dhcp->domain_search_list_len < N_SEARCH_LIST_LEN)
+            {
+                dhcp->domain_search_list[dhcp->domain_search_list_len++] =
=3D p[2];
+            }
+            else
+            {
+                msg(msglevel, "--dhcp-option %s: maximum of %d search entr=
ies can be specified",
+                    p[1], N_SEARCH_LIST_LEN);
+            }
+        }
+        else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && !p=
[3]
+                 && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
+        {
+            if (strstr(p[2], ":"))
+            {
+                dhcp_option_dns6_parse(p[2], dhcp->dns6, &dhcp->dns6_len, =
msglevel);
+            }
+            else
+            {
+                dhcp_option_address_parse("DNS", p[2], dhcp->dns, &dhcp->d=
ns_len, msglevel);
+            }
+        }
+#if defined(_WIN32) || defined(TARGET_ANDROID)
         else if (streq(p[1], "NBS") && p[2] && !p[3])
         {
             o->netbios_scope =3D p[2];
@@ -8191,23 +8325,9 @@
             o->netbios_node_type =3D t;
             o->dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;
         }
-        else if ((streq(p[1], "DNS") || streq(p[1], "DNS6")) && p[2] && !p=
[3]
-                 && (!strstr(p[2], ":") || ipv6_addr_safe(p[2])))
-        {
-            if (strstr(p[2], ":"))
-            {
-                dhcp_option_dns6_parse(p[2], o->dns6, &o->dns6_len, msglev=
el);
-            }
-            else
-            {
-                dhcp_option_address_parse("DNS", p[2], o->dns, &o->dns_len=
, msglevel);
-                o->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
-            }
-        }
         else if (streq(p[1], "WINS") && p[2] && !p[3])
         {
             dhcp_option_address_parse("WINS", p[2], o->wins, &o->wins_len,=
 msglevel);
-            o->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
         }
         else if (streq(p[1], "NTP") && p[2] && !p[3])
         {
@@ -8219,19 +8339,6 @@
             dhcp_option_address_parse("NBDD", p[2], o->nbdd, &o->nbdd_len,=
 msglevel);
             o->dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;
         }
-        else if (streq(p[1], "DOMAIN-SEARCH") && p[2] && !p[3])
-        {
-            if (o->domain_search_list_len < N_SEARCH_LIST_LEN)
-            {
-                o->domain_search_list[o->domain_search_list_len++] =3D p[2=
];
-            }
-            else
-            {
-                msg(msglevel, "--dhcp-option %s: maximum of %d search entr=
ies can be specified",
-                    p[1], N_SEARCH_LIST_LEN);
-            }
-            o->dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;
-        }
         else if (streq(p[1], "DISABLE-NBT") && !p[2])
         {
             o->disable_nbt =3D 1;
@@ -8249,8 +8356,10 @@
             msg(msglevel, "--dhcp-option: unknown option type '%s' or miss=
ing or unknown parameter", p[1]);
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Gerrit-Change-Number: 904
Gerrit-PatchSet: 25
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--4jTEiyp3ric=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/904?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dns: deal with --dhcp-options when --dns is ac=
tive<br><br>Since --dns settings overrule DNS related --dhcp-options,<br>re=
move the latter when values were defined via --dns.<br><br>To stay as backw=
ard compatible as possible, we add foreign_options to<br>the script hook en=
vironment from the --dns values when a --up script<br>is defined. In that c=
ase the default --dns-updown is not run, even<br>when --dns values are pres=
ent, to prevent double DNS configuration.<br>This way an existing --up scri=
pt that deals with DNS can run, without<br>the immediate need to change aft=
er an openvpn upgrade and a server<br>pushing --dns options.<br><br>If you =
specify a custom --dns-updown, or force running the default<br>dns-updown t=
hat comes with openvpn, those compat env vars are not set<br>for --up scrip=
ts and the dns-updown command is run, even when there&#39;s<br>an --up scri=
pt present.<br><br>Since Android uses the DNS values from tuntap_options, w=
e always<br>override those with --dns stuff unconditionally. Also on Window=
s when<br>--ip-win32 is dynamic or adaptive, since DHCP relies on these as =
well.<br><br>Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a<br>Signed=
-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &lt;=
gert@...1296...&gt;<br>Message-Id: &lt;20250618124835.24737-1-gert@...1725...=
..&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...282...=
.net/msg31922.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>---<br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvpn/option=
s.c<br>3 files changed, 323 insertions(+), 184 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index=
 7cf1b63..939ae09 100644</span><br><span>--- a/src/openvpn/dns.c</span><br>=
<span>+++ b/src/openvpn/dns.c</span><br><span>@@ -691,7 +691,8 @@</span><br=
><span> static void</span><br><span> run_up_down_command(bool up, struct op=
tions *o, const struct tuntap *tt, struct dns_updown_runner_info *updown_ru=
nner)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!o-&gt;dns_options.updown)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    struct dns_options *dns =3D &amp;o-&gt;dns_options;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dns-&gt;updo=
wn || (o-&gt;up_script &amp;&amp; !dns-&gt;user_set_updown))</span><br><spa=
n>     {</span><br><span>         return;</span><br><span>     }</span><br>=
<span>@@ -701,7 +702,7 @@</span><br><span>     if (!updown_runner-&gt;requi=
red)</span><br><span>     {</span><br><span>         /* Run dns updown dire=
ctly */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        status=
 =3D do_run_up_down_command(up, NULL, &amp;o-&gt;dns_options, tt);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        status =3D do_run_up=
_down_command(up, NULL, dns, tt);</span><br><span>     }</span><br><span>  =
   else</span><br><span>     {</span><br><span>@@ -852,6 +853,14 @@</span><=
br><span>     {</span><br><span>         return;</span><br><span>     }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /* Don&#39;t use iservice=
 in DHCP mode */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct tuntap_options *tto =3D &amp;o-&gt;tuntap_options;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (tto-&gt;ip_win32_type =3D=3D=
 IPW32_SET_DHCP_MASQ || tto-&gt;ip_win32_type =3D=3D IPW32_SET_ADAPTIVE)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>     /* Warn =
about adding servers of unsupported AF */</span><br><span>     const struct=
 dns_server *s =3D o-&gt;dns_options.servers;</span><br><span>diff --git a/=
src/openvpn/dns.h b/src/openvpn/dns.h</span><br><span>index 60f5471..688daa=
7 100644</span><br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/=
openvpn/dns.h</span><br><span>@@ -76,7 +76,28 @@</span><br><span> #endif</s=
pan><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#ifndef N_DHCP_ADDR</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#define N_DHCP_ADDR 4</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef N_SEAR=
CH_LIST_LEN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define =
N_SEARCH_LIST_LEN 10</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+struct dhcp_options {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    in_addr_t dns[N_DHCP_ADDR=
];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int dns_len;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct in6_addr dns6[N_DHCP_ADDR];<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int dns6_len;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *domain;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    const char *domain_search_list[N_=
SEARCH_LIST_LEN];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  int domain_search_list_len;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> struct dns_options {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct dhcp_options from_dhcp;</span><br><span>     struct =
dns_domain *search_domains;</span><br><span>     struct dns_server *servers=
_prepull;</span><br><span>     struct dns_server *servers;</span><br><span>=
diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>=
index 6ea01d4..d758a67 100644</span><br><span>--- a/src/openvpn/options.c</=
span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -1328,7 +1328=
,6 @@</span><br><span> #endif /* ifndef ENABLE_SMALL */</span><br><span> #e=
ndif /* ifdef _WIN32 */</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#if defined(_WIN32) || defined(TARGET_ANDROID)</span><b=
r><span> static void</span><br><span> dhcp_option_dns6_parse(const char *pa=
rm, struct in6_addr *dns6_list, int *len, int msglevel)</span><br><span> {<=
/span><br><span>@@ -1371,150 +1370,6 @@</span><br><span>     }</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * If DNS option=
s are set use these for TUN/TAP options as well.</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">- * Applies to DNS, DNS6 and DOMAIN-SEARCH.</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">- * Existing options will be=
 discarded.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-tuntap_options_copy_dns(struct options=
 *o)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    struct tuntap_options *tt =3D &am=
p;o-&gt;tuntap_options;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    struct dns_options *dns =3D &amp;o-&gt;dns_options;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    if (dns-&gt;search_domains)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        tt-&gt;domain_search_list_len =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        const struct dns_domain *domain =3D=
 dns-&gt;search_domains;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        while (domain &amp;&amp; tt-&gt;domain_search_list_len &lt; N_SE=
ARCH_LIST_LEN)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            tt-&gt;=
domain_search_list[tt-&gt;domain_search_list_len++] =3D domain-&gt;name;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            domain =3D d=
omain-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (domain=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WA=
RNING: couldn&#39;t copy all --dns search-domains to --dhcp-option&quot;);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;dhcp_options |=3D D=
HCP_OPTIONS_DHCP_REQUIRED;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (dns-&gt;servers)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;dns_len =3D 0;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;dns6_len =3D 0;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        bool overflow =3D =
false;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const s=
truct dns_server *server =3D dns-&gt;servers;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        while (server)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            for (int i =3D 0; i &lt; server-&gt;addr_count; ++=
i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (server-=
&gt;addr[i].family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                    if (tt-&gt;dns_len &gt;=3D N_DHCP_ADDR)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                        over=
flow =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
                 continue;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    tt-&gt;dns[tt-&gt;dns_len++] =3D ntohl(server-&gt;=
addr[i].in.a4.s_addr);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
            if (tt-&gt;dns6_len &gt;=3D N_DHCP_ADDR)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                        overflow =3D true;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                      =
  continue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          tt-&gt;dns6[tt-&gt;dns6_len++] =3D server-&gt;addr[i].in.a6;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            server =3D server-&gt;next=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        if (overflow)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN, &quot;WARNING: coul=
dn&#39;t copy all --dns server addresses to --dhcp-option&quot;);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;dhcp_options |=3D DHCP_OPTIO=
NS_DHCP_OPTIONAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#else /* if defined(_WIN32) || defined(T=
ARGET_ANDROID) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-foreign_option=
s_copy_dns(struct options *o, struct env_set *es)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const struct dns_domain *domain =3D o-&gt;dns_options.search_do=
mains;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struc=
t dns_server *server =3D o-&gt;dns_options.servers;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (!domain &amp;&amp; !server)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* rese=
t the index since we&#39;re starting all over again */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int opt_max =3D o-&gt;foreign_option_i=
ndex;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    o-&gt;foreig=
n_option_index =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (int i =3D 1;=
 i &lt;=3D opt_max; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char =
name[32];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        snpr=
intf(name, sizeof(name), &quot;foreign_option_%d&quot;, i);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        const char *env_str =3D env_set_get(es, name);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *value=
 =3D strchr(env_str, &#39;=3D&#39;) + 1;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if ((domain &amp;&amp; strstr(value, &quot;dhcp-=
option DOMAIN-SEARCH&quot;) =3D=3D value)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            || (server &amp;&amp; strstr(value, &quot;d=
hcp-option DNS&quot;) =3D=3D value))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            setenv_del(es, name);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            setenv=
_foreign_option(o, &amp;value, 1, es);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_ne=
w();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    while (server)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        for (size_t i =3D 0; i &lt; server-&gt;addr_count=
; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (server-&gt;=
addr[i].family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                const char *argv[] =3D {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    &quot;dhcp-option&quot;,</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                    &quot;DNS&qu=
ot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                 =
   print_in_addr_t(server-&gt;addr[i].in.a4.s_addr, 0, &amp;gc)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                };</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                setenv_foreign_optio=
n(o, argv, 3, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                const ch=
ar *argv[] =3D {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               &quot;dhcp-option&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    &quot;DNS6&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                    print_in6_addr(server=
-&gt;addr[i].in.a6, 0, &amp;gc)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                };</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                setenv_foreign_option(o, argv, 3, es);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        server =3D server-&gt;next;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    while (domain)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       const char *argv[] =3D { &quot;dhcp-option&quot;, &quot;DOMAIN-SEARC=
H&quot;, domain-&gt;name };</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        setenv_foreign_option(o, argv, 3, es);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        domain =3D domain-&gt;next;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* rem=
ove old leftover entries */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    while (o-&gt;foreign_option_index &lt; opt_max)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        char name[32];</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        snprintf(name, sizeof(name), &quot;foreign_opt=
ion_%d&quot;, opt_max--);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        setenv_del(es, name);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if defined(_WI=
N32) || defined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span> #ifndef ENABLE_SMALL</span><br><span> static=
 const char *</span><br><span> print_vlan_accept(enum vlan_acceptable_frame=
s mode)</span><br><span>@@ -3603,6 +3458,260 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if defined(_WIN32) || defined(TARGET_ANDROID)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @brief Postprocess DNS related settings</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * Set TUN/TAP DNS options with values from e=
ither --dns</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * or --=
dhcp-option.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param o     pointer =
to the options struct</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_options_postpro=
cess_dns(struct options *o)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct=
 dns_options *dns =3D &amp;o-&gt;dns_options;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    struct tuntap_options *tt =3D &amp;o-&gt;tunt=
ap_options;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!dns-&gt;servers)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Copy =
--dhcp-options to tuntap_options */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        struct dhcp_options *dhcp =3D &amp;dns-&gt;from_dhc=
p;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert(si=
zeof(dhcp-&gt;dns) =3D=3D sizeof(tt-&gt;dns));</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        assert(sizeof(dhcp-&gt;dns6) =3D=3D size=
of(tt-&gt;dns6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      assert(sizeof(dhcp-&gt;domain_search_list) =3D=3D sizeof(tt-&gt;domai=
n_search_list));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;domain =
=3D dhcp-&gt;domain;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        tt-&gt;dns_len =3D dhcp-&gt;dns_len;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        tt-&gt;dns6_len =3D dhcp-&gt;dns6_len;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        memcpy(tt-&gt;dns, dhcp-&gt;dns, =
sizeof(tt-&gt;dns));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        memcpy(tt-&gt;dns6, dhcp-&gt;dns6, sizeof(tt-&gt;dns6));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        tt-&gt;domain_search_list_len =3D dhcp-&=
gt;domain_search_list_len;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        for (size_t i =3D 0; i &lt; SIZE(tt-&gt;domain_search_list);=
 ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            tt-&gt;domai=
n_search_list[i] =3D dhcp-&gt;domain_search_list[i];</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;ip_win32_type !=
=3D IPW32_SET_DHCP_MASQ &amp;&amp; tt-&gt;ip_win32_type !=3D IPW32_SET_ADAP=
TIVE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return;     /* Not i=
n DHCP mode */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if define=
d(_WIN32) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Copy --dns options =
to tuntap_options */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const struct dns_domain *d =3D dns-&gt;search_domains;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    while (d &amp;&amp; tt-&gt;doma=
in_search_list_len + 1 &lt; N_SEARCH_LIST_LEN)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        tt-&gt;domain_search_list[tt-&gt;domain_search_list_le=
n++] =3D d-&gt;name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        d =3D d-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN, &quot;WARN=
ING: couldn&#39;t copy all --dns search-domains to TUN/TAP&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    const struct dns_server *s =3D dns-&gt;servers;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    while (s)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        bool non_standard_server_port =3D false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =
=3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (s-&gt;addr[i].port &amp;&amp; s-&gt;addr[i].port !=
=3D 53)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                no=
n_standard_server_port =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                break;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if ((s-&gt;transport &amp;&amp; s-&gt;transport !=3D DNS_TRANSPORT_=
PLAIN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            |=
| (s-&gt;dnssec &amp;&amp; s-&gt;dnssec !=3D DNS_SECURITY_NO)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            || non_standard_serve=
r_port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* Skip se=
rvers requiring unsupported config to be set */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            s =3D s-&gt;next;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            bool overflow =3D false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            for (int i =3D 0; i &lt; s-&gt;addr=
_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   if (s-&gt;addr[i].family =3D=3D AF_INET &amp;&amp; tt-&gt;dns_len + 1 &l=
t; N_DHCP_ADDR)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              tt-&gt;dns[tt-&gt;dns_len++] =3D s-&gt;addr[i].in.a4.s_addr;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                else i=
f (tt-&gt;dns6_len + 1 &lt; N_DHCP_ADDR)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    tt-&gt;dns6[tt-&gt;dns6_len++] =3D s=
-&gt;addr[i].in.a6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 overflow =3D true;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            if (overflow)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                msg(M_WARN, &quot;WARNING: couldn&#39;t copy all --=
dns server addresses to TUN/TAP&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#else /* if defined(_WIN32) || defined(TARGET_A=
NDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @brief Postprocess DNS related settings</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * Discard existing --dhcp-options fro=
m the env if needed and possibly</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * replace them with values from --dns. If no --dns servers ar=
e set copy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the --=
dhcp-option values over for --dns-updown runs.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * @param o     pointer to the options struct</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * @param es    env set to modify poten=
tially</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+dhcp_options_postprocess_dns(struct o=
ptions *o, struct env_set *es)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    struct dns_options *dns =3D &amp;o-&gt;dns_options;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (dns-&gt;servers || dns-&gt;user_set_updo=
wn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* Clean up env from -=
-dhcp-option DNS config */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;g=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct b=
uffer value =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        const int fo_count =3D o-&gt;foreign_option_index=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;fore=
ign_option_index =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (in=
t i =3D 1; i &lt;=3D fo_count; ++i)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            buf_clear(&amp;name);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            buf_printf(&amp;name, &quot;foreign_option_=
%d&quot;, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      const char *env_str =3D env_set_get(es, BSTR(&amp;name));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            const char *item_va=
l =3D strchr(env_str, &#39;=3D&#39;) + 1;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            buf_clear(&amp;value);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;value, &qu=
ot;%s&quot;, item_val);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* =
Remove foreign option item from env set */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            env_set_del(es, BSTR(&amp;name));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            item_val =3D BSTR(&amp;value);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (strncm=
p(item_val, &quot;dhcp-option &quot;, 12) !=3D 0</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                || (strncmp(item_val + 12, &qu=
ot;ADAPTER-DOMAIN-SUFFIX &quot;, 22) !=3D 0</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    &amp;&amp; strncmp(item_val + 1=
2, &quot;DOMAIN-SEARCH &quot;, 14) !=3D 0</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    &amp;&amp; strncmp(item_val + 12,=
 &quot;DOMAIN &quot;, 7) !=3D 0</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    &amp;&amp; strncmp(item_val + 12, &quot;DNS=
6 &quot;, 5) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    &amp;&amp; strncmp(item_val + 12, &quot;DNS &quot;, 4) =
!=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /=
* Re-set the item with potentially updated name */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                buf_clear(&amp;name);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_printf=
(&amp;name, &quot;foreign_option_%d&quot;, ++o-&gt;foreign_option_index);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                seten=
v_str(es, BSTR(&amp;name), BSTR(&amp;value));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dns-&gt;server=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        /* Copy --dhcp-options =
to dns_options */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      struct dhcp_options *dhcp =3D &amp;dns-&gt;from_dhcp;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (dhcp-&gt;dns_len || dhcp-&gt;dns6_len)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            struct dns_domain **e=
ntry =3D &amp;dns-&gt;search_domains;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            ALLOC_OBJ_CLEAR_GC(*entry, struct dns_domain,=
 &amp;dns-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           struct dns_domain *new =3D *entry;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            new-&gt;name =3D dhcp-&gt;domain;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            entry =3D &=
amp;new-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            for (size=
_t i =3D 0; i &lt; dhcp-&gt;domain_search_list_len; ++i)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                ALLOC_OBJ_CLEAR_GC(*entry, s=
truct dns_domain, &amp;dns-&gt;gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                struct dns_domain *new =3D *entry;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                new-&gt;name=
 =3D dhcp-&gt;domain_search_list[i];</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                entry =3D &amp;new-&gt;next;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            struct dns_server *server =3D dns_server_get(&=
amp;dns-&gt;servers, 0, &amp;dns-&gt;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            const size_t max_addrs =3D SIZE(server-&g=
t;addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 for (size_t i =3D 0; i &lt; dhcp-&gt;dns_len &amp;&amp; server-&gt;addr_co=
unt &lt; max_addrs; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               server-&gt;addr[server-&gt;addr_count].in.a4.s_addr =3D hton=
l(dhcp-&gt;dns[i]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                server-&gt;addr[server-&gt;addr_count].family =3D AF_INET;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                serv=
er-&gt;addr_count +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            for (size_t i =3D 0; i &lt; dhcp-&gt;dns6_len &amp;&amp; server=
-&gt;addr_count &lt; max_addrs; ++i)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                server-&gt;addr[server-&gt;addr_count].in.a6 =3D=
 dhcp-&gt;dns6[i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               server-&gt;addr[server-&gt;addr_count].family =3D AF_INET6;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                serv=
er-&gt;addr_count +=3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (o-&gt;up_sc=
ript &amp;&amp; !dns-&gt;user_set_updown)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* Set foreign option env vars from --dns config */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const char *p[] =3D=
 { &quot;dhcp-option&quot;, NULL, NULL };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        size_t p_len =3D sizeof(p) / sizeof(p[0]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        p[1] =3D &quot;DOMAIN&quot;;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct dns=
_domain *d =3D dns-&gt;search_domains;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        while (d)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            p[2] =3D d-&gt;name;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            setenv_foreign_option(o, (const char **)p, =
p_len, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    d =3D d-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct dns_se=
rver *s =3D dns-&gt;servers;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        while (s)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         bool non_standard_server_port =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            for (int i =3D 0; i &lt; s-&gt;ad=
dr_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     if (s-&gt;addr[i].port &amp;&amp; s-&gt;addr[i].port !=3D 53)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    non_standa=
rd_server_port =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    break;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            if ((s-&gt;transport &amp;&amp; s-&gt;transport !=3D DNS_TR=
ANSPORT_PLAIN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           || (s-&gt;dnssec &amp;&amp; s-&gt;dnssec !=3D DNS_SECURITY_NO)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                || no=
n_standard_server_port)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              /* Skip servers requiring unsupported config to be set */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                s =3D s=
-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            els=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                for (int=
 i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                    if (s-&gt;addr[i].family =3D=3D AF_IN=
ET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          p[1] =3D &quot;DNS&quot;;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        p[2] =3D print_in_addr_t(s-&gt;addr=
[i].in.a4.s_addr, IA_NET_ORDER, &amp;gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                        p[1] =3D &quot;DNS6&=
quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           p[2] =3D print_in6_addr(s-&gt;addr[i].in.a6, 0, &amp;gc);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    sete=
nv_foreign_option(o, (const char **)p, p_len, es);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                break;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&am=
p;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(_WIN32) ||=
 defined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> static void</span><br><span> options_postprocess_=
mutate(struct options *o, struct env_set *es)</span><br><span> {</span><br>=
<span>@@ -3786,9 +3895,9 @@</span><br><span>     else</span><br><span>     =
{</span><br><span> #if defined(_WIN32) || defined(TARGET_ANDROID)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        tuntap_options_copy_dns=
(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tuntap_=
options_postprocess_dns(o);</span><br><span> #else</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        foreign_options_copy_dns(o, es);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        dhcp_options_post=
process_dns(o, es);</span><br><span> #endif</span><br><span>     }</span><b=
r><span>     if (o-&gt;auth_token_generate &amp;&amp; !o-&gt;auth_token_ren=
ewal)</span><br><span>@@ -4171,9 +4280,9 @@</span><br><span>     {</span><b=
r><span>         dns_options_postprocess_pull(&amp;o-&gt;dns_options);</spa=
n><br><span> #if defined(_WIN32) || defined(TARGET_ANDROID)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        tuntap_options_copy_dns(o);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tuntap_option=
s_postprocess_dns(o);</span><br><span> #else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        foreign_options_copy_dns(o, es);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        dhcp_options_postproces=
s_dns(o, es);</span><br><span> #endif</span><br><span>     }</span><br><spa=
n>     return success;</span><br><span>@@ -8162,18 +8271,43 @@</span><br><s=
pan>             goto err;</span><br><span>         }</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32) =
|| defined(TARGET_ANDROID)</span><br><span>     else if (streq(p[0], &quot;=
dhcp-option&quot;) &amp;&amp; p[1])</span><br><span>     {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        struct dhcp_options *dhcp =
=3D &amp;options-&gt;dns_options.from_dhcp;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(_WIN32) || defined(TARGET_ANDROID)</spa=
n><br><span>         struct tuntap_options *o =3D &amp;options-&gt;tuntap_o=
ptions;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((streq(p[1], =
&quot;DOMAIN&quot;) || streq(p[1], &quot;ADAPTER_DOMAIN_SUFFIX&quot;))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp;&amp; p[2=
] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if ((streq(p[1], &quot;DOMAIN&quot;) || streq(p[1], &quot;ADAPTER_D=
OMAIN_SUFFIX&quot;)) &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&=
gt;domain =3D p[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            dhcp-&gt;domain =3D p=
[2];</span><br><span>         }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        else if (streq(p[1], &quot;DOMAIN-SEARCH&quot;) &amp;&a=
mp; p[2] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (dhcp-&gt;domain_search_list_len &lt; N_SEARCH_LIST_LEN)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                dhcp-&gt;domain_=
search_list[dhcp-&gt;domain_search_list_len++] =3D p[2];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            else</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                msg(msglevel, &quot;--dhcp-option %s:=
 maximum of %d search entries can be specified&quot;,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    p[1], N_SEARCH_LIST_L=
EN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        else if ((streq(p[1], &=
quot;DNS&quot;) || streq(p[1], &quot;DNS6&quot;)) &amp;&amp; p[2] &amp;&amp=
; !p[3]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
     &amp;&amp; (!strstr(p[2], &quot;:&quot;) || ipv6_addr_safe(p[2])))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (strstr(p[2], &quo=
t;:&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  dhcp_option_dns6_parse(p[2], dhcp-&gt;dns6, &amp;dhcp-&gt;dns6_len, msgle=
vel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                dhcp_option_a=
ddress_parse(&quot;DNS&quot;, p[2], dhcp-&gt;dns, &amp;dhcp-&gt;dns_len, ms=
glevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defi=
ned(TARGET_ANDROID)</span><br><span>         else if (streq(p[1], &quot;NBS=
&quot;) &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>         {</span>=
<br><span>             o-&gt;netbios_scope =3D p[2];</span><br><span>@@ -81=
91,23 +8325,9 @@</span><br><span>             o-&gt;netbios_node_type =3D t=
;</span><br><span>             o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_RE=
QUIRED;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        else if ((streq(p[1], &quot;DNS&quot;) || streq(p[1], =
&quot;DNS6&quot;)) &amp;&amp; p[2] &amp;&amp; !p[3]</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 &amp;&amp; (!strstr(p[2], =
&quot;:&quot;) || ipv6_addr_safe(p[2])))</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            if (strstr(p[2], &quot;:&quot;))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                dhcp_option_dns6_parse(p[2], o-&gt;=
dns6, &amp;o-&gt;dns6_len, msglevel);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           dhcp_option_address_parse(&quot;DNS&quot;, p[2], o-&gt;dns, &amp=
;o-&gt;dns_len, msglevel);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>      =
   else if (streq(p[1], &quot;WINS&quot;) &amp;&amp; p[2] &amp;&amp; !p[3])=
</span><br><span>         {</span><br><span>             dhcp_option_addres=
s_parse(&quot;WINS&quot;, p[2], o-&gt;wins, &amp;o-&gt;wins_len, msglevel);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o-&gt;dhc=
p_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span>         }</span=
><br><span>         else if (streq(p[1], &quot;NTP&quot;) &amp;&amp; p[2] &=
amp;&amp; !p[3])</span><br><span>         {</span><br><span>@@ -8219,19 +83=
39,6 @@</span><br><span>             dhcp_option_address_parse(&quot;NBDD&q=
uot;, p[2], o-&gt;nbdd, &amp;o-&gt;nbdd_len, msglevel);</span><br><span>   =
          o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;</span><br><sp=
an>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
else if (streq(p[1], &quot;DOMAIN-SEARCH&quot;) &amp;&amp; p[2] &amp;&amp; =
!p[3])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (o-&gt;domai=
n_search_list_len &lt; N_SEARCH_LIST_LEN)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                o-&gt;domain_search_list[o-&gt;domain_search_li=
st_len++] =3D p[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(msg=
level, &quot;--dhcp-option %s: maximum of %d search entries can be specifie=
d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
       p[1], N_SEARCH_LIST_LEN);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span>    =
     else if (streq(p[1], &quot;DISABLE-NBT&quot;) &amp;&amp; !p[2])</span>=
<br><span>         {</span><br><span>             o-&gt;disable_nbt =3D 1;<=
/span><br><span>@@ -8249,8 +8356,10 @@</span><br><span>             msg(msg=
level, &quot;--dhcp-option: unknown option type &#39;%s&#39; or missing or =
unknown parameter&quot;, p[1]);</span><br><span>             goto err;</spa=
n><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else /* if d=
efined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        setenv_foreign_option(options, (const char=
 **)p, 3, es);</span><br><span> #endif /* if defined(_WIN32) || defined(TAR=
GET_ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span> #ifdef _WIN32</span><br><span>     else if (streq(p[0], =
&quot;show-adapters&quot;) &amp;&amp; !p[1])</span><br><span>     {</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/904?usp=3Demail">change 904</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/904?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb=
2e9cb2570cd6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 904 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 25 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--4jTEiyp3ric=--

