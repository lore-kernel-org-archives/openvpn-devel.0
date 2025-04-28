From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 28 Apr 2025 06:12:44 +0000
In-Reply-To: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
References: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <654c1f8aceaa9ac56ac5af54b3c2acd897566e0d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h4lXlTzx2sQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--h4lXlTzx2sQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail

to look at the new patch set (#15).

The following approvals got outdated and were removed:
Code-Review-1 by stipa


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
---
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
3 files changed, 315 insertions(+), 184 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/904/15

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 221e9a9..9927961 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -703,7 +703,8 @@
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
@@ -713,7 +714,7 @@
     if (!updown_runner->required)
     {
         /* Run dns updown directly */
-        status =3D do_run_up_down_command(up, NULL, &o->dns_options, tt);
+        status =3D do_run_up_down_command(up, NULL, dns, tt);
     }
     else
     {
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index c56d603..8e3556d 100644
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
index 55d31f4..61da4d9c 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1333,7 +1333,6 @@
 #endif /* ifndef ENABLE_SMALL */
 #endif /* ifdef _WIN32 */

-#if defined(_WIN32) || defined(TARGET_ANDROID)
 static void
 dhcp_option_dns6_parse(const char *parm, struct in6_addr *dns6_list, int *=
len, int msglevel)
 {
@@ -1376,150 +1375,6 @@
     }
 }
=20
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
@@ -3617,6 +3472,260 @@
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
+                    tt->dns6[tt->dns6_len] =3D s->addr[i].in.a6;
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
@@ -3802,9 +3911,9 @@
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
@@ -4187,9 +4296,9 @@
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
@@ -8210,18 +8319,43 @@
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
@@ -8239,23 +8373,9 @@
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
@@ -8267,19 +8387,6 @@
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
@@ -8297,8 +8404,10 @@
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
Gerrit-PatchSet: 15
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--h4lXlTzx2sQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p>d12fk <strong>uploaded patch set #15</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dns: deal with --dhcp-options when --dns is active<b=
r><br>Since --dns settings overrule DNS related --dhcp-options,<br>remove t=
he latter when values were defined via --dns.<br><br>To stay as backward co=
mpatible as possible, we add foreign_options to<br>the script hook environm=
ent from the --dns values when a --up script<br>is defined. In that case th=
e default --dns-updown is not run, even<br>when --dns values are present, t=
o prevent double DNS configuration.<br>This way an existing --up script tha=
t deals with DNS can run, without<br>the immediate need to change after an =
openvpn upgrade and a server<br>pushing --dns options.<br><br>If you specif=
y a custom --dns-updown, or force running the default<br>dns-updown that co=
mes with openvpn, those compat env vars are not set<br>for --up scripts and=
 the dns-updown command is run, even when there&#39;s<br>an --up script pre=
sent.<br><br>Since Android uses the DNS values from tuntap_options, we alwa=
ys<br>override those with --dns stuff unconditionally. Also on Windows when=
<br>--ip-win32 is dynamic or adaptive, since DHCP relies on these as well.<=
br><br>Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a<br>Signed-off-b=
y: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br>M src/openvpn/dns.c<br>M s=
rc/openvpn/dns.h<br>M src/openvpn/options.c<br>3 files changed, 315 inserti=
ons(+), 184 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,=
monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/=
openvpn refs/changes/04/904/15</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/dns.c b/src=
/openvpn/dns.c</span><br><span>index 221e9a9..9927961 100644</span><br><spa=
n>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br=
><span>@@ -703,7 +703,8 @@</span><br><span> static void</span><br><span> ru=
n_up_down_command(bool up, struct options *o, const struct tuntap *tt, stru=
ct dns_updown_runner_info *updown_runner)</span><br><span> {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt;dns_options.updown)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct dns_option=
s *dns =3D &amp;o-&gt;dns_options;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    if (!dns-&gt;updown || (o-&gt;up_script &amp;&amp; !dns-=
&gt;user_set_updown))</span><br><span>     {</span><br><span>         retur=
n;</span><br><span>     }</span><br><span>@@ -713,7 +714,7 @@</span><br><sp=
an>     if (!updown_runner-&gt;required)</span><br><span>     {</span><br><=
span>         /* Run dns updown directly */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        status =3D do_run_up_down_command(up, NULL, &=
amp;o-&gt;dns_options, tt);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        status =3D do_run_up_down_command(up, NULL, dns, tt);</span=
><br><span>     }</span><br><span>     else</span><br><span>     {</span><b=
r><span>diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h</span><br><span>=
index c56d603..8e3556d 100644</span><br><span>--- a/src/openvpn/dns.h</span=
><br><span>+++ b/src/openvpn/dns.h</span><br><span>@@ -76,7 +76,28 @@</span=
><br><span> #endif</span><br><span> };</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef N_DHCP_ADDR</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#define N_DHCP_ADDR 4</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#ifndef N_SEARCH_LIST_LEN</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#define N_SEARCH_LIST_LEN 10</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct dhc=
p_options {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    in_a=
ddr_t dns[N_DHCP_ADDR];</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int dns_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct in6_add=
r dns6[N_DHCP_ADDR];</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    int dns6_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *doma=
in;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *=
domain_search_list[N_SEARCH_LIST_LEN];</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    int domain_search_list_len;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span> struct dns_options {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct dhcp_options from_dhcp;</span>=
<br><span>     struct dns_domain *search_domains;</span><br><span>     stru=
ct dns_server *servers_prepull;</span><br><span>     struct dns_server *ser=
vers;</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/opti=
ons.c</span><br><span>index 55d31f4..61da4d9c 100644</span><br><span>--- a/=
src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br=
><span>@@ -1333,7 +1333,6 @@</span><br><span> #endif /* ifndef ENABLE_SMALL=
 */</span><br><span> #endif /* ifdef _WIN32 */</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32) || defined(T=
ARGET_ANDROID)</span><br><span> static void</span><br><span> dhcp_option_dn=
s6_parse(const char *parm, struct in6_addr *dns6_list, int *len, int msglev=
el)</span><br><span> {</span><br><span>@@ -1376,150 +1375,6 @@</span><br><s=
pan>     }</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * If DNS options are set use these for TUN/TAP options as well.</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">- * Applies to DNS, DNS6 a=
nd DOMAIN-SEARCH.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * E=
xisting options will be discarded.</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stati=
c void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-tuntap_options_=
copy_dns(struct options *o)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct tun=
tap_options *tt =3D &amp;o-&gt;tuntap_options;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct dns_options *dns =3D &amp;o-&gt;dns_opt=
ions;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (dns-&gt;search_domains)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;domain_search_list_len =3D 0=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const struct=
 dns_domain *domain =3D dns-&gt;search_domains;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        while (domain &amp;&amp; tt-&gt;domain_se=
arch_list_len &lt; N_SEARCH_LIST_LEN)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            tt-&gt;domain_search_list[tt-&gt;domain_search_list_len++] =
=3D domain-&gt;name;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           domain =3D domain-&gt;next;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (domain)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   msg(M_WARN, &quot;WARNING: couldn&#39;t copy all --dns search-domains to=
 --dhcp-option&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tt-=
&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (d=
ns-&gt;servers)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;dns_len=
 =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tt-&gt=
;dns6_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   bool overflow =3D false;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        const struct dns_server *server =3D dns-&gt;servers;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        while (server)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            for (int i =3D 0; i &lt; serv=
er-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          if (server-&gt;addr[i].family =3D=3D AF_INET)</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    if (tt-&gt;dns_len &gt;=
=3D N_DHCP_ADDR)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
                   overflow =3D true;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                        continue;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    tt-&gt;dns[tt-&gt;dns_len++=
] =3D ntohl(server-&gt;addr[i].in.a4.s_addr);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                    if (tt-&gt;dns6_len &gt;=3D N_DHCP_ADDR)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   overflow =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                        continue;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    tt-&gt;dns6[tt-&gt;dns6_len++] =3D server-&=
gt;addr[i].in.a6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            serv=
er =3D server-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (overflow)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(M_WARN=
, &quot;WARNING: couldn&#39;t copy all --dns server addresses to --dhcp-opt=
ion&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;dhcp_op=
tions |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* if defined=
(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-foreign_options_copy_dns(struct options *o, struct env_set *es)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const struct dns_domain *domain =3D o-&gt;=
dns_options.search_domains;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    const struct dns_server *server =3D o-&gt;dns_options.servers;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!domain &amp;&am=
p; !server)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* reset the index since we&#39;re starting all over again */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    int opt_max =3D o-&gt=
;foreign_option_index;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    o-&gt;foreign_option_index =3D 0;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
for (int i =3D 1; i &lt;=3D opt_max; ++i)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        char name[32];</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        snprintf(name, sizeof(name), &quot;foreign_option_%d&quot;, i)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        const char *env_str =3D env_set_g=
et(es, name);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
const char *value =3D strchr(env_str, &#39;=3D&#39;) + 1;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if ((domain &amp;&amp; strstr(v=
alue, &quot;dhcp-option DOMAIN-SEARCH&quot;) =3D=3D value)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            || (server &amp;&amp; strs=
tr(value, &quot;dhcp-option DNS&quot;) =3D=3D value))</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            setenv_del(es, name);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           setenv_foreign_option(o, &amp;value, 1, es);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (server)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        for (size_t i =3D 0; i &lt; serv=
er-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (server-&gt;addr[i].family =3D=3D AF_INET)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                const char *argv[] =3D {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    &quot;dhcp-option&=
quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     &quot;DNS&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                    print_in_addr_t(server-&gt;addr[i].in.a4.s_addr, 0, &am=
p;gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                set=
env_foreign_option(o, argv, 3, es);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            else</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         const char *argv[] =3D {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    &quot;dhcp-option&quot;,</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                    &quot;DNS6&quot;,</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    prin=
t_in6_addr(server-&gt;addr[i].in.a6, 0, &amp;gc)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                };</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                setenv_foreign_option(o, argv, 3, e=
s);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        server =3D server-&gt;next;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    while (domain)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        const char *argv[] =3D { &quot;dhcp-option&quot;, &=
quot;DOMAIN-SEARCH&quot;, domain-&gt;name };</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        setenv_foreign_option(o, argv, 3, es);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        domain =3D domain-&=
gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* remove old leftover entries */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    while (o-&gt;foreign_option_index &lt; opt_max)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        char name[32];</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        snprintf(name, sizeof(name), &qu=
ot;foreign_option_%d&quot;, opt_max--);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        setenv_del(es, name);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* =
if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span> #ifndef ENABLE_SMALL</span><br=
><span> static const char *</span><br><span> print_vlan_accept(enum vlan_ac=
ceptable_frames mode)</span><br><span>@@ -3617,6 +3472,260 @@</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defined(TARGET_ANDROID)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * @brief Postprocess DNS related set=
tings</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Set TUN/TAP DNS options with=
 values from either --dns</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * or --dhcp-option.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param =
o     pointer to the options struct</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tuntap_o=
ptions_postprocess_dns(struct options *o)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct dns_options *dns =3D &amp;o-&gt;dns_options;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct tuntap_options *tt =3D &=
amp;o-&gt;tuntap_options;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!dns-&gt;servers)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* Copy --dhcp-options to tuntap_options */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct dhcp_options *dhcp =3D &amp;dn=
s-&gt;from_dhcp;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     assert(sizeof(dhcp-&gt;dns) =3D=3D sizeof(tt-&gt;dns));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        assert(sizeof(dhcp-&gt;dns=
6) =3D=3D sizeof(tt-&gt;dns6));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        assert(sizeof(dhcp-&gt;domain_search_list) =3D=3D sizeo=
f(tt-&gt;domain_search_list));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
tt-&gt;domain =3D dhcp-&gt;domain;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        tt-&gt;dns_len =3D dhcp-&gt;dns_len;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;dns6_len =3D dhcp-&g=
t;dns6_len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(tt-&gt;dns, =
dhcp-&gt;dns, sizeof(tt-&gt;dns));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        memcpy(tt-&gt;dns6, dhcp-&gt;dns6, sizeof(tt-&gt;dns=
6));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;domain_search_list_=
len =3D dhcp-&gt;domain_search_list_len;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        for (size_t i =3D 0; i &lt; SIZE(tt-&gt;domain=
_search_list); ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  tt-&gt;domain_search_list[i] =3D dhcp-&gt;domain_search_list[i];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        return;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;ip_w=
in32_type !=3D IPW32_SET_DHCP_MASQ &amp;&amp; tt-&gt;ip_win32_type !=3D IPW=
32_SET_ADAPTIVE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return;  =
   /* Not in DHCP mode */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /=
* if defined(_WIN32) */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Copy --d=
ns options to tuntap_options */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    const struct dns_domain *d =3D dns-&gt;search_domains;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (d &amp;&amp; =
tt-&gt;domain_search_list_len + 1 &lt; N_SEARCH_LIST_LEN)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        tt-&gt;domain_search_list[tt-&gt;domain_sea=
rch_list_len++] =3D d-&gt;name;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        d =3D d-&gt;next;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (d)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,=
 &quot;WARNING: couldn&#39;t copy all --dns search-domains to TUN/TAP&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct dns_server *s =3D dns-&gt;servers=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    while (s)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        bool non_standard_server_port =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        f=
or (int i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (s-&gt;addr[i].port &amp;&amp; s-&gt;addr[i=
].port !=3D 53)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      non_standard_server_port =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                break;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if ((s-&gt;transport &amp;&amp; s-&gt;transport !=3D DNS_TR=
ANSPORT_PLAIN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       || (s-&gt;dnssec &amp;&amp; s-&gt;dnssec !=3D DNS_SECURITY_NO)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            || non_standa=
rd_server_port)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            /*=
 Skip servers requiring unsupported config to be set */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            s =3D s-&gt;next;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            bool overflow =3D false;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            for (int i =3D 0; i &lt; s-=
&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           if (s-&gt;addr[i].family =3D=3D AF_INET &amp;&amp; tt-&gt;dns_le=
n + 1 &lt; N_DHCP_ADDR)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    tt-&gt;dns[tt-&gt;dns_len++] =3D s-&gt;addr[i].in.a4.=
s_addr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  else if (tt-&gt;dns6_len + 1 &lt; N_DHCP_ADDR)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    tt-&gt;dns6[tt-&gt;dns6_len]=
 =3D s-&gt;addr[i].in.a6;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                else</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    overflow =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            if (overflow)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                msg(M_WARN, &quot;WARNING: couldn&#39;t copy =
all --dns server addresses to TUN/TAP&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            return;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else /* if defined(_WIN32) || defined(TA=
RGET_ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @brief Postprocess DNS related sett=
ings</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * Discard existing --dhcp-optio=
ns from the env if needed and possibly</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * replace them with values from --dns. If no --dns serv=
ers are set copy</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
the --dhcp-option values over for --dns-updown runs.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param o     pointer to the options struct</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ * @param es    env set to modif=
y potentially</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+dhcp_options_postprocess_dns(s=
truct options *o, struct env_set *es)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct dns_options *dns =3D &amp;o-&gt;dns_options;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (dns-&gt;servers || dns-&gt;user_s=
et_updown)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Clean up env=
 from --dhcp-option DNS config */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        struct buffer name =3D alloc_buf_gc(OPTION_PARM_SIZE,=
 &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
truct buffer value =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        const int fo_count =3D o-&gt;foreign_optio=
n_index;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&=
gt;foreign_option_index =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
for (int i =3D 1; i &lt;=3D fo_count; ++i)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            buf_clear(&amp;name);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            buf_printf(&amp;name, &quot;foreign_=
option_%d&quot;, i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            const char *env_str =3D env_set_get(es, BSTR(&amp;name));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            const char *=
item_val =3D strchr(env_str, &#39;=3D&#39;) + 1;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            buf_clear(&amp;value);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            buf_printf(&amp;val=
ue, &quot;%s&quot;, item_val);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    /* Remove foreign option item from env set */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            env_set_del(es, BSTR(&amp;name));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            item_val =3D BSTR(&amp;val=
ue);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if =
(strncmp(item_val, &quot;dhcp-option &quot;, 12) !=3D 0</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                || (strncmp(item_val + =
12, &quot;ADAPTER-DOMAIN-SUFFIX &quot;, 22) !=3D 0</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    &amp;&amp; strncmp(item_=
val + 12, &quot;DOMAIN-SEARCH &quot;, 14) !=3D 0</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    &amp;&amp; strncmp(item_va=
l + 12, &quot;DOMAIN &quot;, 7) !=3D 0</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    &amp;&amp; strncmp(item_val + 12, &q=
uot;DNS6 &quot;, 5) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    &amp;&amp; strncmp(item_val + 12, &quot;DNS &quo=
t;, 4) !=3D 0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      /* Re-set the item with potentially updated name */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                buf_clear(&amp;name);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                buf=
_printf(&amp;name, &quot;foreign_option_%d&quot;, ++o-&gt;foreign_option_in=
dex);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  setenv_str(es, BSTR(&amp;name), BSTR(&amp;value));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!dns-&g=
t;servers)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Copy --dhcp-=
options to dns_options */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        struct dhcp_options *dhcp =3D &amp;dns-&gt;from_dhcp;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (dhcp-&gt;dns_len || dhcp-&gt;dns6_=
len)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct dns_do=
main **entry =3D &amp;dns-&gt;search_domains;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            ALLOC_OBJ_CLEAR_GC(*entry, struct dns=
_domain, &amp;dns-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            struct dns_domain *new =3D *entry;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            new-&gt;name =3D dhcp-&gt;dom=
ain;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            ent=
ry =3D &amp;new-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            f=
or (size_t i =3D 0; i &lt; dhcp-&gt;domain_search_list_len; ++i)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                ALLOC_OBJ_CLEAR_GC(*=
entry, struct dns_domain, &amp;dns-&gt;gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                struct dns_domain *new =3D *entry;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                new-=
&gt;name =3D dhcp-&gt;domain_search_list[i];</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                entry =3D &amp;new-&gt;next;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            struct dns_server *server =3D dns_serv=
er_get(&amp;dns-&gt;servers, 0, &amp;dns-&gt;gc);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            const size_t max_addrs =3D SIZE(s=
erver-&gt;addr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         for (size_t i =3D 0; i &lt; dhcp-&gt;dns_len &amp;&amp; server-&gt=
;addr_count &lt; max_addrs; ++i)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                server-&gt;addr[server-&gt;addr_count].in.a4.s_addr =
=3D htonl(dhcp-&gt;dns[i]);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                server-&gt;addr[server-&gt;addr_count].family =3D A=
F_INET;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    server-&gt;addr_count +=3D 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            for (size_t i =3D 0; i &lt; dhcp-&gt;dns6_len &amp;&amp=
; server-&gt;addr_count &lt; max_addrs; ++i)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                server-&gt;addr[server-&gt;addr_count].i=
n.a6 =3D dhcp-&gt;dns6[i];</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                server-&gt;addr[server-&gt;addr_count].family =3D AF=
_INET6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    server-&gt;addr_count +=3D 1;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (o-&=
gt;up_script &amp;&amp; !dns-&gt;user_set_updown)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        /* Set foreign option env vars from --dns config */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const char =
*p[] =3D { &quot;dhcp-option&quot;, NULL, NULL };</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        size_t p_len =3D sizeof(p) / sizeof(p=
[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        p[1] =3D &quot;DOMAIN&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const st=
ruct dns_domain *d =3D dns-&gt;search_domains;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        while (d)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            p[2] =3D d-&gt;name;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            setenv_foreign_option(o, (const cha=
r **)p, p_len, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            d =3D d-&gt;next;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struc=
t dns_server *s =3D dns-&gt;servers;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        while (s)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            bool non_standard_server_port =3D false;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            for (int i =3D 0; i &lt; =
s-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             if (s-&gt;addr[i].port &amp;&amp; s-&gt;addr[i].port !=3D 53)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    no=
n_standard_server_port =3D true;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    break;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if ((s-&gt;transport &amp;&amp; s-&gt;transport !=
=3D DNS_TRANSPORT_PLAIN)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                || (s-&gt;dnssec &amp;&amp; s-&gt;dnssec !=3D DNS_SECU=
RITY_NO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     || non_standard_server_port)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                /* Skip servers requiring unsupported config to be =
set */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   s =3D s-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  for (int i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    if (s-&gt;addr[i].family =
=3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      p[1] =3D &quot;DNS&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        p[2] =3D print_in_addr_=
t(s-&gt;addr[i].in.a4.s_addr, IA_NET_ORDER, &amp;gc);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        p[1] =3D=
 &quot;DNS6&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                       p[2] =3D print_in6_addr(s-&gt;addr[i].in.a6, 0, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        setenv_foreign_option(o, (const char **)p, p_len, es);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                break;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    g=
c_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if defined(=
_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> static void</span><br><span> options_po=
stprocess_mutate(struct options *o, struct env_set *es)</span><br><span> {<=
/span><br><span>@@ -3802,9 +3911,9 @@</span><br><span>     else</span><br><=
span>     {</span><br><span> #if defined(_WIN32) || defined(TARGET_ANDROID)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        tuntap_option=
s_copy_dns(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   tuntap_options_postprocess_dns(o);</span><br><span> #else</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        foreign_options_copy_dns(o, =
es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dhcp_op=
tions_postprocess_dns(o, es);</span><br><span> #endif</span><br><span>     =
}</span><br><span>     if (o-&gt;auth_token_generate &amp;&amp; !o-&gt;auth=
_token_renewal)</span><br><span>@@ -4187,9 +4296,9 @@</span><br><span>     =
{</span><br><span>         dns_options_postprocess_pull(&amp;o-&gt;dns_opti=
ons);</span><br><span> #if defined(_WIN32) || defined(TARGET_ANDROID)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        tuntap_options_copy=
_dns(o);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tun=
tap_options_postprocess_dns(o);</span><br><span> #else</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        foreign_options_copy_dns(o, es);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        dhcp_options_=
postprocess_dns(o, es);</span><br><span> #endif</span><br><span>     }</spa=
n><br><span>     return success;</span><br><span>@@ -8210,18 +8319,43 @@</s=
pan><br><span>             goto err;</span><br><span>         }</span><br><=
span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(_WIN32) || defined(TARGET_ANDROID)</span><br><span>     else if (streq(p[=
0], &quot;dhcp-option&quot;) &amp;&amp; p[1])</span><br><span>     {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        struct dhcp_option=
s *dhcp =3D &amp;options-&gt;dns_options.from_dhcp;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defined(TARGET_AND=
ROID)</span><br><span>         struct tuntap_options *o =3D &amp;options-&g=
t;tuntap_options;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((st=
req(p[1], &quot;DOMAIN&quot;) || streq(p[1], &quot;ADAPTER_DOMAIN_SUFFIX&qu=
ot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &amp=
;&amp; p[2] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if ((streq(p[1], &quot;DOMAIN&quot;) || streq(p[1], &quot=
;ADAPTER_DOMAIN_SUFFIX&quot;)) &amp;&amp; p[2] &amp;&amp; !p[3])</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       o-&gt;domain =3D p[2];</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            dhcp-&gt;do=
main =3D p[2];</span><br><span>         }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        else if (streq(p[1], &quot;DOMAIN-SEARCH&quot=
;) &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            if (dhcp-&gt;domain_search_list_len &lt; N_SEARCH_LIST_L=
EN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                dhcp-&=
gt;domain_search_list[dhcp-&gt;domain_search_list_len++] =3D p[2];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--dhc=
p-option %s: maximum of %d search entries can be specified&quot;,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                    p[1], N_S=
EARCH_LIST_LEN);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if ((s=
treq(p[1], &quot;DNS&quot;) || streq(p[1], &quot;DNS6&quot;)) &amp;&amp; p[=
2] &amp;&amp; !p[3]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                 &amp;&amp; (!strstr(p[2], &quot;:&quot;) || ipv6_addr_safe=
(p[2])))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (strst=
r(p[2], &quot;:&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              dhcp_option_dns6_parse(p[2], dhcp-&gt;dns6, &amp;dhcp-&gt;dns=
6_len, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                d=
hcp_option_address_parse(&quot;DNS&quot;, p[2], dhcp-&gt;dns, &amp;dhcp-&gt=
;dns_len, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WI=
N32) || defined(TARGET_ANDROID)</span><br><span>         else if (streq(p[1=
], &quot;NBS&quot;) &amp;&amp; p[2] &amp;&amp; !p[3])</span><br><span>     =
    {</span><br><span>             o-&gt;netbios_scope =3D p[2];</span><br>=
<span>@@ -8239,23 +8373,9 @@</span><br><span>             o-&gt;netbios_nod=
e_type =3D t;</span><br><span>             o-&gt;dhcp_options |=3D DHCP_OPT=
IONS_DHCP_REQUIRED;</span><br><span>         }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        else if ((streq(p[1], &quot;DNS&quot;) || =
streq(p[1], &quot;DNS6&quot;)) &amp;&amp; p[2] &amp;&amp; !p[3]</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                 &amp;&amp; (!str=
str(p[2], &quot;:&quot;) || ipv6_addr_safe(p[2])))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-            if (strstr(p[2], &quot;:&quot;))</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                dhcp_option_dns6_parse(p[2]=
, o-&gt;dns6, &amp;o-&gt;dns6_len, msglevel);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                dhcp_option_address_parse(&quot;DNS&quot;, p[2], o-&gt;d=
ns, &amp;o-&gt;dns_len, msglevel);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTI=
ONAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><spa=
n>         else if (streq(p[1], &quot;WINS&quot;) &amp;&amp; p[2] &amp;&amp=
; !p[3])</span><br><span>         {</span><br><span>             dhcp_optio=
n_address_parse(&quot;WINS&quot;, p[2], o-&gt;wins, &amp;o-&gt;wins_len, ms=
glevel);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            o=
-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span>        =
 }</span><br><span>         else if (streq(p[1], &quot;NTP&quot;) &amp;&amp=
; p[2] &amp;&amp; !p[3])</span><br><span>         {</span><br><span>@@ -826=
7,19 +8387,6 @@</span><br><span>             dhcp_option_address_parse(&quo=
t;NBDD&quot;, p[2], o-&gt;nbdd, &amp;o-&gt;nbdd_len, msglevel);</span><br><=
span>             o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;</span=
><br><span>         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        else if (streq(p[1], &quot;DOMAIN-SEARCH&quot;) &amp;&amp; p[2] &am=
p;&amp; !p[3])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (o-&=
gt;domain_search_list_len &lt; N_SEARCH_LIST_LEN)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                o-&gt;domain_search_list[o-&gt;domain_s=
earch_list_len++] =3D p[2];</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 msg(msglevel, &quot;--dhcp-option %s: maximum of %d search entries can be =
specified&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               p[1], N_SEARCH_LIST_LEN);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-            o-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><s=
pan>         else if (streq(p[1], &quot;DISABLE-NBT&quot;) &amp;&amp; !p[2]=
)</span><br><span>         {</span><br><span>             o-&gt;disable_nbt=
 =3D 1;</span><br><span>@@ -8297,8 +8404,10 @@</span><br><span>            =
 msg(msglevel, &quot;--dhcp-option: unknown option type &#39;%s&#39; or mis=
sing or unknown parameter&quot;, p[1]);</span><br><span>             goto e=
rr;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else=
 /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        setenv_foreign_option(options, (c=
onst char **)p, 3, es);</span><br><span> #endif /* if defined(_WIN32) || de=
fined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span> #ifdef _WIN32</span><br><span>     else if (str=
eq(p[0], &quot;show-adapters&quot;) &amp;&amp; !p[1])</span><br><span>     =
{</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/904?usp=3Demail">change 904</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/904?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb=
2e9cb2570cd6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 904 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 15 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--h4lXlTzx2sQ=--

