From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 29 Jul 2025 14:52:54 +0000
In-Reply-To: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
References: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <355db39c172799570a83cbfd93df78434b3be4b2-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JNbdgxjPTdo="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE: Added
 update_option() function.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JNbdgxjPTdo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#24) to the change originally created b=
y mrbff. ( http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: PUSH_UPDATE: Added update_option() function.
......................................................................

PUSH_UPDATE: Added update_option() function.

When the function receives an option to update, it first checks whether it =
has
already received an option of the same type within the same update message.
If it has already received it, it simply calls add_option(), otherwise it
deletes all the values already present for that option first.

Change-Id: Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250729104110.27704-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg32=
408.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/options.c
1 file changed, 331 insertions(+), 124 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/810/24

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 469360d..b7328d7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5360,6 +5360,20 @@
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
@@ -5545,6 +5559,7 @@
     int line_num =3D 0;
     const char *file =3D "[PUSH-OPTIONS]";
     const int msglevel =3D D_PUSH_ERRORS|M_OPTERR;
+    unsigned int update_options_found =3D 0;

     while (buf_parse(buf, ',', line, sizeof(line)))
     {
@@ -5590,6 +5605,11 @@
                 remove_option(c, options, p, false, file, line_num, msglev=
el,
                               permission_mask, option_types_found, es);
             }
+            else
+            {
+                update_option(c, options, p, false, file, line_num, 0, msg=
level,
+                              permission_mask, option_types_found, es, &up=
date_options_found);
+            }
         }
     }
     return true;
@@ -5728,6 +5748,13 @@
     return options->forward_compatible ? M_WARN : msglevel;
 }

+#define RESET_OPTION_ROUTES(option_ptr, field) \
+    if (option_ptr)                        \
+    {                                      \
+        option_ptr->field =3D NULL;          \
+        option_ptr->flags =3D 0;             \
+    }
+
 /**
  * @brief Resets options found in the PUSH_UPDATE message that are precede=
d by the `-` flag.
  *        This function is used in push-updates to reset specified options.
@@ -5782,11 +5809,7 @@
             delete_routes_v4(c->c1.route_list, c->c1.tuntap,
                              ROUTE_OPTION_FLAGS(&c->options),
                              es, &c->net_ctx);
-            if (options->routes)
-            {
-                options->routes->routes =3D NULL;
-                options->routes->flags =3D 0;
-            }
+            RESET_OPTION_ROUTES(options->routes, routes);
         }
     }
     else if (streq(p[0], "route-ipv6") && !p[1])
@@ -5797,11 +5820,7 @@
             delete_routes_v6(c->c1.route_ipv6_list, c->c1.tuntap,
                              ROUTE_OPTION_FLAGS(&c->options),
                              es, &c->net_ctx);
-            if (options->routes_ipv6)
-            {
-                options->routes_ipv6->routes_ipv6 =3D NULL;
-                options->routes_ipv6->flags =3D 0;
-            }
+            RESET_OPTION_ROUTES(options->routes_ipv6, routes_ipv6);
         }
     }
     else if (streq(p[0], "route-gateway") && !p[1])
@@ -5921,6 +5940,303 @@
     msg(msglevel, "Error occurred trying to remove %s option", p[0]);
 }

+
+static bool
+check_route_option(struct options *options, char *p[], const int msglevel,=
 bool pull_mode)
+{
+    rol_check_alloc(options);
+    if (pull_mode)
+    {
+        if (!ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn) && !is_sp=
ecial_addr(p[1])) /* FQDN -- may be DNS name */
+        {
+            msg(msglevel, "route parameter network/IP '%s' must be a valid=
 address", p[1]);
+            return false;
+        }
+        if (p[2] && !ip_addr_dotted_quad_safe(p[2])) /* FQDN -- must be IP=
 address */
+        {
+            msg(msglevel, "route parameter netmask '%s' must be an IP addr=
ess", p[2]);
+            return false;
+        }
+        if (p[3] && !ip_or_dns_addr_safe(p[3], options->allow_pull_fqdn) &=
& !is_special_addr(p[3])) /* FQDN -- may be DNS name */
+        {
+            msg(msglevel, "route parameter gateway '%s' must be a valid ad=
dress", p[3]);
+            return false;
+        }
+    }
+    return true;
+}
+
+
+static bool
+check_route6_option(struct options *options, char *p[], const int msglevel=
, bool pull_mode)
+{
+    rol6_check_alloc(options);
+    if (pull_mode)
+    {
+        if (!ipv6_addr_safe_hexplusbits(p[1]))
+        {
+            msg(msglevel, "route-ipv6 parameter network/IP '%s' must be a =
valid address", p[1]);
+            return false;
+        }
+        if (p[2] && !ipv6_addr_safe(p[2]))
+        {
+            msg(msglevel, "route-ipv6 parameter gateway '%s' must be a val=
id address", p[2]);
+            return false;
+        }
+        /* p[3] is metric, if present */
+    }
+    return true;
+}
+
+static bool
+check_dns_option(struct options *options, char *p[], const int msglevel, b=
ool pull_mode)
+{
+    if (streq(p[1], "search-domains") && p[2])
+    {
+        dns_domain_list_append(&options->dns_options.search_domains, &p[2]=
, &options->dns_options.gc);
+    }
+    else if (streq(p[1], "server") && p[2] && p[3] && p[4])
+    {
+        long priority;
+        if (!dns_server_priority_parse(&priority, p[2], pull_mode))
+        {
+            msg(msglevel, "--dns server: invalid priority value '%s'", p[2=
]);
+            return false;
+        }
+
+        struct dns_server *server =3D dns_server_get(&options->dns_options=
.servers, priority, &options->dns_options.gc);
+
+        if (streq(p[3], "address") && p[4])
+        {
+            for (int i =3D 4; p[i]; ++i)
+            {
+                if (!dns_server_addr_parse(server, p[i]))
+                {
+                    msg(msglevel, "--dns server %ld: malformed address or =
maximum exceeded '%s'", priority, p[i]);
+                    return false;
+                }
+            }
+        }
+        else if (streq(p[3], "resolve-domains"))
+        {
+            dns_domain_list_append(&server->domains, &p[4], &options->dns_=
options.gc);
+        }
+        else if (streq(p[3], "dnssec") && !p[5])
+        {
+            if (streq(p[4], "yes"))
+            {
+                server->dnssec =3D DNS_SECURITY_YES;
+            }
+            else if (streq(p[4], "no"))
+            {
+                server->dnssec =3D DNS_SECURITY_NO;
+            }
+            else if (streq(p[4], "optional"))
+            {
+                server->dnssec =3D DNS_SECURITY_OPTIONAL;
+            }
+            else
+            {
+                msg(msglevel, "--dns server %ld: malformed dnssec value '%=
s'", priority, p[4]);
+                return false;
+            }
+        }
+        else if (streq(p[3], "transport") && !p[5])
+        {
+            if (streq(p[4], "plain"))
+            {
+                server->transport =3D DNS_TRANSPORT_PLAIN;
+            }
+            else if (streq(p[4], "DoH"))
+            {
+                server->transport =3D DNS_TRANSPORT_HTTPS;
+            }
+            else if (streq(p[4], "DoT"))
+            {
+                server->transport =3D DNS_TRANSPORT_TLS;
+            }
+            else
+            {
+                msg(msglevel, "--dns server %ld: malformed transport value=
 '%s'", priority, p[4]);
+                return false;
+            }
+        }
+        else if (streq(p[3], "sni") && !p[5])
+        {
+            server->sni =3D p[4];
+        }
+        else
+        {
+            msg(msglevel, "--dns server %ld: unknown option type '%s' or m=
issing or unknown parameter", priority, p[3]);
+            return false;
+        }
+    }
+    else
+    {
+        msg(msglevel, "--dns: unknown option type '%s' or missing or unkno=
wn parameter", p[1]);
+        return false;
+    }
+    return true;
+}
+
+/**
+ * @brief Processes an option to update. It first checks whether it has al=
ready
+ *        received an option of the same type within the same update messa=
ge.
+ *        If the option has already been received, it calls add_option().
+ *        Otherwise, it deletes all existing values related to that option=
 before calling add_option().
+ *
+ * @param c The context structure.
+ * @param options A pointer to the options structure.
+ * @param p An array of strings containing the options and their parameter=
s.
+ * @param is_inline A boolean indicating if the option is inline.
+ * @param file The file where the function is called.
+ * @param line The line number where the function is called.
+ * @param level The level of the option.
+ * @param msglevel The message level for logging.
+ * @param permission_mask The permission mask used by VERIFY_PERMISSION().
+ * @param option_types_found A pointer to the variable where the flags cor=
responding to the options found are stored.
+ * @param es The environment set structure.
+ * @param update_options_found A pointer to the variable where the flags c=
orresponding to the update options found are stored,
+ *                             used to check if an option of the same type=
 has already been processed by update_option() within the same push-update =
message.
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
+    const bool pull_mode =3D BOOL_CAST(permission_mask & OPT_P_PULL_MODE);
+    ASSERT(MAX_PARMS >=3D 7);
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
+            *update_options_found |=3D OPT_P_U_ROUTE;
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
+            *update_options_found |=3D OPT_P_U_ROUTE6;
+        }
+    }
+    else if (streq(p[0], "redirect-gateway") || streq(p[0], "redirect-priv=
ate"))
+    {
+        if (!(*update_options_found & OPT_P_U_REDIR_GATEWAY))
+        {
+            VERIFY_PERMISSION(OPT_P_ROUTE);
+            if (options->routes)
+            {
+                options->routes->flags =3D 0;
+            }
+            if (options->routes_ipv6)
+            {
+                options->routes_ipv6->flags =3D 0;
+            }
+            *update_options_found |=3D OPT_P_U_REDIR_GATEWAY;
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
+            *update_options_found |=3D OPT_P_U_DNS;
+        }
+    }
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+    else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
+    {
+        if (!(*update_options_found & OPT_P_U_DHCP))
+        {
+            struct tuntap_options *o =3D &options->tuntap_options;
+            VERIFY_PERMISSION(OPT_P_DHCPDNS);
+
+            o->domain =3D NULL;
+            o->netbios_scope =3D NULL;
+            o->netbios_node_type =3D 0;
+            o->dns6_len =3D 0;
+            CLEAR(o->dns6);
+            o->dns_len =3D 0;
+            CLEAR(o->dns);
+            o->wins_len =3D 0;
+            CLEAR(o->wins);
+            o->ntp_len =3D 0;
+            CLEAR(o->ntp);
+            o->nbdd_len =3D 0;
+            CLEAR(o->nbdd);
+            while (o->domain_search_list_len-- > 0)
+            {
+                o->domain_search_list[o->domain_search_list_len] =3D NULL;
+            }
+            o->disable_nbt =3D 0;
+            o->dhcp_options =3D 0;
+#if defined(TARGET_ANDROID)
+            o->http_proxy_port =3D 0;
+            o->http_proxy =3D NULL;
+#endif
+            *update_options_found |=3D OPT_P_U_DHCP;
+        }
+    }
+#else /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+    else if (streq(p[0], "dhcp-option") && p[1] && !p[3])
+    {
+        if (!(*update_options_found & OPT_P_U_DHCP))
+        {
+            VERIFY_PERMISSION(OPT_P_DHCPDNS);
+            delete_all_dhcp_fo(options, &es->list);
+            *update_options_found |=3D OPT_P_U_DHCP;
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
@@ -7284,45 +7600,18 @@
     else if (streq(p[0], "route") && p[1] && !p[5])
     {
         VERIFY_PERMISSION(OPT_P_ROUTE);
-        rol_check_alloc(options);
-        if (pull_mode)
+        if (!check_route_option(options, p, msglevel, pull_mode))
         {
-            if (!ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn) && !i=
s_special_addr(p[1])) /* FQDN -- may be DNS name */
-            {
-                msg(msglevel, "route parameter network/IP '%s' must be a v=
alid address", p[1]);
-                goto err;
-            }
-            if (p[2] && !ip_addr_dotted_quad_safe(p[2])) /* FQDN -- must b=
e IP address */
-            {
-                msg(msglevel, "route parameter netmask '%s' must be an IP =
address", p[2]);
-                goto err;
-            }
-            if (p[3] && !ip_or_dns_addr_safe(p[3], options->allow_pull_fqd=
n) && !is_special_addr(p[3])) /* FQDN -- may be DNS name */
-            {
-                msg(msglevel, "route parameter gateway '%s' must be a vali=
d address", p[3]);
-                goto err;
-            }
-            /* p[4] is metric, if specified */
+            goto err;
         }
         add_route_to_option_list(options->routes, p[1], p[2], p[3], p[4], =
options->route_default_table_id);
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
-                msg(msglevel, "route-ipv6 parameter network/IP '%s' must b=
e a valid address", p[1]);
-                goto err;
-            }
-            if (p[2] && !ipv6_addr_safe(p[2]))
-            {
-                msg(msglevel, "route-ipv6 parameter gateway '%s' must be a=
 valid address", p[2]);
-                goto err;
-            }
-            /* p[3] is metric, if specified */
+            goto err;
         }
         add_route_ipv6_to_option_list(options->routes_ipv6, p[1], p[2], p[=
3], options->route_default_table_id);
     }
@@ -8410,90 +8699,8 @@
     else if (streq(p[0], "dns") && p[1])
     {
         VERIFY_PERMISSION(OPT_P_DHCPDNS);
-
-        if (streq(p[1], "search-domains") && p[2])
+        if (!check_dns_option(options, p, msglevel, pull_mode))
         {
-            dns_domain_list_append(&options->dns_options.search_domains, &=
p[2], &options->dns_options.gc);
-        }
-        else if (streq(p[1], "server") && p[2] && p[3] && p[4])
-        {
-            long priority;
-            if (!dns_server_priority_parse(&priority, p[2], pull_mode))
-            {
-                msg(msglevel, "--dns server: invalid priority value '%s'",=
 p[2]);
-                goto err;
-            }
-
-            struct dns_server *server =3D dns_server_get(&options->dns_opt=
ions.servers, priority, &options->dns_options.gc);
-
-            if (streq(p[3], "address") && p[4])
-            {
-                for (int i =3D 4; p[i]; ++i)
-                {
-                    if (!dns_server_addr_parse(server, p[i]))
-                    {
-                        msg(msglevel, "--dns server %ld: malformed address=
 or maximum exceeded '%s'", priority, p[i]);
-                        goto err;
-                    }
-                }
-            }
-            else if (streq(p[3], "resolve-domains"))
-            {
-                dns_domain_list_append(&server->domains, &p[4], &options->=
dns_options.gc);
-            }
-            else if (streq(p[3], "dnssec") && !p[5])
-            {
-                if (streq(p[4], "yes"))
-                {
-                    server->dnssec =3D DNS_SECURITY_YES;
-                }
-                else if (streq(p[4], "no"))
-                {
-                    server->dnssec =3D DNS_SECURITY_NO;
-                }
-                else if (streq(p[4], "optional"))
-                {
-                    server->dnssec =3D DNS_SECURITY_OPTIONAL;
-                }
-                else
-                {
-                    msg(msglevel, "--dns server %ld: malformed dnssec valu=
e '%s'", priority, p[4]);
-                    goto err;
-                }
-            }
-            else if (streq(p[3], "transport") && !p[5])
-            {
-                if (streq(p[4], "plain"))
-                {
-                    server->transport =3D DNS_TRANSPORT_PLAIN;
-                }
-                else if (streq(p[4], "DoH"))
-                {
-                    server->transport =3D DNS_TRANSPORT_HTTPS;
-                }
-                else if (streq(p[4], "DoT"))
-                {
-                    server->transport =3D DNS_TRANSPORT_TLS;
-                }
-                else
-                {
-                    msg(msglevel, "--dns server %ld: malformed transport v=
alue '%s'", priority, p[4]);
-                    goto err;
-                }
-            }
-            else if (streq(p[3], "sni") && !p[5])
-            {
-                server->sni =3D p[4];
-            }
-            else
-            {
-                msg(msglevel, "--dns server %ld: unknown option type '%s' =
or missing or unknown parameter", priority, p[3]);
-                goto err;
-            }
-        }
-        else
-        {
-            msg(msglevel, "--dns: unknown option type '%s' or missing or u=
nknown parameter", p[1]);
             goto err;
         }
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2
Gerrit-Change-Number: 810
Gerrit-PatchSet: 24
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--JNbdgxjPTdo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #24</strong> to the change originally c=
reated by mrbff.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/810=
?usp=3Demail">View Change</a></p><p>The following approvals got outdated an=
d were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">PUSH_UPDATE: Added update_option() function.<br><br>=
When the function receives an option to update, it first checks whether it =
has<br>already received an option of the same type within the same update m=
essage.<br>If it has already received it, it simply calls add_option(), oth=
erwise it<br>deletes all the values already present for that option first.<=
br><br>Change-Id: Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2<br>Signed-off-b=
y: Marco Baffo &lt;marco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@=
...1296...&gt;<br>Message-Id: &lt;20250729104110.27704-1-gert@...1296...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg32408.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M src/openvpn/options.c<br>1 file changed, 331 insertions(+), 124 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/10/810/24</pre><pre style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;"><span>diff --git a/src/openvpn/options.c b/src/openvpn/opti=
ons.c</span><br><span>index 469360d..b7328d7 100644</span><br><span>--- a/s=
rc/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br>=
<span>@@ -5360,6 +5360,20 @@</span><br><span>               struct env_set =
*es);</span><br><span> </span><br><span> static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+update_option(struct context *c,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+              struct options=
 *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
     char *p[],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
          bool is_inline,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+              const char *file,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+              int line,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+              const int level,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              const int msglevel,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+              const unsigne=
d int permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+              unsigned int *option_types_found,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+              struct env_set *es,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+              unsigned int *up=
date_options_found);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span> read_config_file(struct options *options,</span><br><span>      =
            const char *file,</span><br><span>                  int level,<=
/span><br><span>@@ -5545,6 +5559,7 @@</span><br><span>     int line_num =3D=
 0;</span><br><span>     const char *file =3D &quot;[PUSH-OPTIONS]&quot;;</=
span><br><span>     const int msglevel =3D D_PUSH_ERRORS|M_OPTERR;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int update_opti=
ons_found =3D 0;</span><br><span> </span><br><span>     while (buf_parse(bu=
f, &#39;,&#39;, line, sizeof(line)))</span><br><span>     {</span><br><span=
>@@ -5590,6 +5605,11 @@</span><br><span>                 remove_option(c, o=
ptions, p, false, file, line_num, msglevel,</span><br><span>               =
                permission_mask, option_types_found, es);</span><br><span> =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 update_option(c, options, p, false, file, line_num, 0, msglevel,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                             =
 permission_mask, option_types_found, es, &amp;update_options_found);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span>         }</span><br><span>     }</span><br><span>     return true;</s=
pan><br><span>@@ -5728,6 +5748,13 @@</span><br><span>     return options-&g=
t;forward_compatible ? M_WARN : msglevel;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define RESET_OP=
TION_ROUTES(option_ptr, field) \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (option_ptr)                        \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {                                =
      \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        opti=
on_ptr-&gt;field =3D NULL;          \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        option_ptr-&gt;flags =3D 0;             \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  *=
 @brief Resets options found in the PUSH_UPDATE message that are preceded b=
y the `-` flag.</span><br><span>  *        This function is used in push-up=
dates to reset specified options.</span><br><span>@@ -5782,11 +5809,7 @@</s=
pan><br><span>             delete_routes_v4(c-&gt;c1.route_list, c-&gt;c1.t=
untap,</span><br><span>                              ROUTE_OPTION_FLAGS(&am=
p;c-&gt;options),</span><br><span>                              es, &amp;c-=
&gt;net_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    if (options-&gt;routes)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              options-&gt;routes-&gt;routes =3D NULL;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                options-&gt;routes-&gt;flag=
s =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            RESET_O=
PTION_ROUTES(options-&gt;routes, routes);</span><br><span>         }</span>=
<br><span>     }</span><br><span>     else if (streq(p[0], &quot;route-ipv6=
&quot;) &amp;&amp; !p[1])</span><br><span>@@ -5797,11 +5820,7 @@</span><br>=
<span>             delete_routes_v6(c-&gt;c1.route_ipv6_list, c-&gt;c1.tunt=
ap,</span><br><span>                              ROUTE_OPTION_FLAGS(&amp;c=
-&gt;options),</span><br><span>                              es, &amp;c-&gt=
;net_ctx);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 if (options-&gt;routes_ipv6)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                options-&gt;routes_ipv6-&gt;routes_ipv6 =3D NULL;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                options-&gt;rou=
tes_ipv6-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          RESET_OPTION_ROUTES(options-&gt;routes_ipv6, routes_ipv6);</span>=
<br><span>         }</span><br><span>     }</span><br><span>     else if (s=
treq(p[0], &quot;route-gateway&quot;) &amp;&amp; !p[1])</span><br><span>@@ =
-5921,6 +5940,303 @@</span><br><span>     msg(msglevel, &quot;Error occurre=
d trying to remove %s option&quot;, p[0]);</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+check_route_option(struct options *option=
s, char *p[], const int msglevel, bool pull_mode)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    rol_check_alloc(options);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (pull_mode)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (!ip_or_dns_addr_safe(p[1], options-&gt;allow_pull_fqdn) =
&amp;&amp; !is_special_addr(p[1])) /* FQDN -- may be DNS name */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;route pa=
rameter network/IP &#39;%s&#39; must be a valid address&quot;, p[1]);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            return false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        if (p[2] &amp;&amp; !=
ip_addr_dotted_quad_safe(p[2])) /* FQDN -- must be IP address */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;route pa=
rameter netmask &#39;%s&#39; must be an IP address&quot;, p[2]);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            return false;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (p[3] &amp;&amp; !ip_or=
_dns_addr_safe(p[3], options-&gt;allow_pull_fqdn) &amp;&amp; !is_special_ad=
dr(p[3])) /* FQDN -- may be DNS name */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            msg(msglevel, &quot;route parameter gateway &#39;%s&#=
39; must be a valid address&quot;, p[3]);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            return false;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+check_route6_option(struct options *options, char *p[], const i=
nt msglevel, bool pull_mode)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rol6_=
check_alloc(options);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (pull_mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
ipv6_addr_safe_hexplusbits(p[1]))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            msg(msglevel, &quot;route-ipv6 parameter network/IP &#39;%s=
&#39; must be a valid address&quot;, p[1]);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            return false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (p[2] &amp;&amp; !ipv6_addr_safe(p[2]))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            msg(msglevel, &quot;ro=
ute-ipv6 parameter gateway &#39;%s&#39; must be a valid address&quot;, p[2]=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            retur=
n false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* p[3] is me=
tric, if present */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+check_dns_option(struct options *options, char *p[], const int=
 msglevel, bool pull_mode)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (str=
eq(p[1], &quot;search-domains&quot;) &amp;&amp; p[2])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        dns_domain_list_append(&amp;options-&gt;dns_opt=
ions.search_domains, &amp;p[2], &amp;options-&gt;dns_options.gc);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[1], &quot;server&quo=
t;) &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp; p[4])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        long priority;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if (!dns_server_priority_parse(&amp;priority=
, p[2], pull_mode))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(msglevel, &quot;--dns server: invalid priority value &#39;%s&#39;&quo=
t;, p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   return false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        struct dns_server *serve=
r =3D dns_server_get(&amp;options-&gt;dns_options.servers, priority, &amp;o=
ptions-&gt;dns_options.gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if =
(streq(p[3], &quot;address&quot;) &amp;&amp; p[4])</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            for (int i =3D 4; p[i]; ++i)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                if (!dns_server_addr_pa=
rse(server, p[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 msg(msglevel, &quot;--dns server %ld: malformed address or=
 maximum exceeded &#39;%s&#39;&quot;, priority, p[i]);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    return false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        else if (streq(p[3], &quot;resolve-d=
omains&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            dns=
_domain_list_append(&amp;server-&gt;domains, &amp;p[4], &amp;options-&gt;dn=
s_options.gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else if=
 (streq(p[3], &quot;dnssec&quot;) &amp;&amp; !p[5])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (streq(p[4], &quot;yes&quot;))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                server-&gt;dnss=
ec =3D DNS_SECURITY_YES;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           else if (streq(p[4], &quot;no&quot;))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                server-&gt;dnssec =3D DNS_SECURITY_N=
O;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (st=
req(p[4], &quot;optional&quot;))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                server-&gt;dnssec =3D DNS_SECURITY_OPTIONAL;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--dns=
 server %ld: malformed dnssec value &#39;%s&#39;&quot;, priority, p[4]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        else if (streq(p[3],=
 &quot;transport&quot;) &amp;&amp; !p[5])</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (streq(p[4], &quot;plain&quot;))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                server-&gt;transport =3D =
DNS_TRANSPORT_PLAIN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       else if (streq(p[4], &quot;DoH&quot;))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                server-&gt;transport =3D DNS_TRANSPORT_=
HTTPS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if=
 (streq(p[4], &quot;DoT&quot;))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                server-&gt;transport =3D DNS_TRANSPORT_TLS;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                msg(msglevel, &quot;--dns se=
rver %ld: malformed transport value &#39;%s&#39;&quot;, priority, p[4]);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                return=
 false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        else if (streq(p[3],=
 &quot;sni&quot;) &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            server-&gt;sni =3D p[4];</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        msg(msglevel, &quot;--dns server %ld: unknown option type &#39;%s&#=
39; or missing or unknown parameter&quot;, priority, p[3]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     msg(msglevel, &quot;--dns: unknown option type &#39;%s&#39; or missing=
 or unknown parameter&quot;, p[1]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        return false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @brief Processes an option to update. It first ch=
ecks whether it has already</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *        received an option of the same type within the same updat=
e message.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *       =
 If the option has already been received, it calls add_option().</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *        Otherwise, it delete=
s all existing values related to that option before calling add_option().</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param c The context structure.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param options A poi=
nter to the options structure.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param p An array of strings containing the options and their=
 parameters.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am is_inline A boolean indicating if the option is inline.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param file The file where the fu=
nction is called.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param line The line number where the function is called.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * @param level The level of the opt=
ion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param msgle=
vel The message level for logging.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @param permission_mask The permission mask used by VERIFY=
_PERMISSION().</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @p=
aram option_types_found A pointer to the variable where the flags correspon=
ding to the options found are stored.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param es The environment set structure.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param update_options_found A =
pointer to the variable where the flags corresponding to the update options=
 found are stored,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*                             used to check if an option of the same type h=
as already been processed by update_option() within the same push-update me=
ssage.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+update_option(struct context *c,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+              struct opt=
ions *options,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
         char *p[],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
              bool is_inline,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+              const char *file,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+              int line,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+              const int level,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+              const int msglevel,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+              const unsi=
gned int permission_mask,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+              unsigned int *option_types_found,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              struct env_set *es,</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+              unsigned int =
*update_options_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const bool =
pull_mode =3D BOOL_CAST(permission_mask &amp; OPT_P_PULL_MODE);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(MAX_PARMS &gt;=3D 7)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (streq(p[0], &quot;route&quot;=
) &amp;&amp; p[1] &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (!(*update_options_found &amp; OPT_P_U_ROUTE))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            VERIFY_PERMISSION(OPT_P_ROUTE);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!chec=
k_route_option(options, p, msglevel, pull_mode))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                goto err;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            if (c-&gt;c1.route_list)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                delete_routes_v4(c-&gt;c1=
.route_list, c-&gt;c1.tuntap,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                                 ROUTE_OPTION_FLAGS(&amp;c-&gt;op=
tions),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                     es, &amp;c-&gt;net_ctx);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                RESET_OPTION_ROUTES(options-&gt;r=
outes, routes);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  *update_options_found |=3D OPT_P_U_ROUTE;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp;=
 !p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(*update_opti=
ons_found &amp; OPT_P_U_ROUTE6))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (!check_route6_option(options, p,=
 msglevel, pull_mode))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         if (c-&gt;c1.route_ipv6_list)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                delete_routes_v6(c-&gt;c1.route_ipv6_list, c-&=
gt;c1.tuntap,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
                           ROUTE_OPTION_FLAGS(&amp;c-&gt;options),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
     es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                RESET_OPTION_ROUTES(options-&gt;routes_ipv6, rout=
es_ipv6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *upd=
ate_options_found |=3D OPT_P_U_ROUTE6;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
lse if (streq(p[0], &quot;redirect-gateway&quot;) || streq(p[0], &quot;redi=
rect-private&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!=
(*update_options_found &amp; OPT_P_U_REDIR_GATEWAY))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            VERIFY_PERMISSION(OPT_P_ROUTE);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (options-&gt=
;routes)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                o=
ptions-&gt;routes-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            if (options-&gt;routes_ipv6)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                options-&gt;routes_ipv6-&gt;flags =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *update=
_options_found |=3D OPT_P_U_REDIR_GATEWAY;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   else if (streq(p[0], &quot;dns&quot;) &amp;&amp; p[1])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!(*update_options_found &amp; OPT_P_U_D=
NS))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            VERIFY_PERMIS=
SION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            if (!check_dns_option(options, p, msglevel, pull_mode))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                goto err;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;options=
-&gt;dns_options.gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            CLEAR(options-&gt;dns_options);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            *update_options_found |=3D OPT_P_U_DN=
S;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defined(TARGET_AND=
ROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!(*update_options_found &am=
p; OPT_P_U_DHCP))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
struct tuntap_options *o =3D &amp;options-&gt;tuntap_options;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            VERIFY_PERMISSION(OPT=
_P_DHCPDNS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;domain =
=3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  o-&gt;netbios_scope =3D NULL;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            o-&gt;netbios_node_type =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            o-&gt;dns6_len =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            CLEAR(o-&gt;dn=
s6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&=
gt;dns_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          CLEAR(o-&gt;dns);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            o-&gt;wins_len =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            CLEAR(o-&gt;wins);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            o-&gt;ntp_len =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            CLEAR(o-&gt;ntp)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;=
nbdd_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        CLEAR(o-&gt;nbdd);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            while (o-&gt;domain_search_list_len-- &gt; 0)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                o-&gt;domain_search_=
list[o-&gt;domain_search_list_len] =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            o-&gt;disable_nbt =3D 0;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            o-&gt;dhcp_options =3D 0;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_AN=
DROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o=
-&gt;http_proxy_port =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            o-&gt;http_proxy =3D NULL;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            *update_options_found |=3D OPT_P_U_DHCP;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#else /* if defined(_WIN32) || defined(TARGET_ANDROI=
D) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (s=
treq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] &amp;&amp; !p[3])</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        if (!(*update_options_found &am=
p; OPT_P_U_DHCP))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            delete_all_dhcp_fo(options, &amp;es-&gt;list);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            *update_op=
tions_found |=3D OPT_P_U_DHCP;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* if =
defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    add_option(options, p, is_inline, file, line,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               leve=
l, msglevel, permission_mask,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+               option_types_found, es);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    return;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    msg(msglevel, &quot;Error occurred trying to update %s option&qu=
ot;, p[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static v=
oid</span><br><span> set_user_script(struct options *options,</span><br><sp=
an>                 const char **script,</span><br><span>@@ -7284,45 +7600,=
18 @@</span><br><span>     else if (streq(p[0], &quot;route&quot;) &amp;&am=
p; p[1] &amp;&amp; !p[5])</span><br><span>     {</span><br><span>         V=
ERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        rol_check_alloc(options);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (pull_mode)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (!check_route_option(options, p, msgleve=
l, pull_mode))</span><br><span>         {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            if (!ip_or_dns_addr_safe(p[1], options-&gt;=
allow_pull_fqdn) &amp;&amp; !is_special_addr(p[1])) /* FQDN -- may be DNS n=
ame */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(msg=
level, &quot;route parameter network/IP &#39;%s&#39; must be a valid addres=
s&quot;, p[1]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
          goto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  if (p[2] &amp;&amp; !ip_addr_dotted_quad_safe(p[2])) /* FQDN -- must be I=
P address */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                m=
sg(msglevel, &quot;route parameter netmask &#39;%s&#39; must be an IP addre=
ss&quot;, p[2]);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           goto err;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   if (p[3] &amp;&amp; !ip_or_dns_addr_safe(p[3], options-&gt;allow_pull_fq=
dn) &amp;&amp; !is_special_addr(p[3])) /* FQDN -- may be DNS name */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                msg(msglevel, &quot;=
route parameter gateway &#39;%s&#39; must be a valid address&quot;, p[3]);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto e=
rr;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* p[4] is met=
ric, if specified */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            goto err;</span><br><span>         }</span><br><span>         =
add_route_to_option_list(options-&gt;routes, p[1], p[2], p[3], p[4], option=
s-&gt;route_default_table_id);</span><br><span>     }</span><br><span>     =
else if (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; !p[=
4])</span><br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P=
_ROUTE);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        rol6_=
check_alloc(options);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (pull_mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!check_route6_option(options, p, msglevel, pull_mode))</span=
><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (!ipv6_addr_safe_hexplusbits(p[1]))</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                msg(msglevel, &quot;route-ipv6 paramet=
er network/IP &#39;%s&#39; must be a valid address&quot;, p[1]);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                goto err;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (p[2] &amp;&amp; !ipv=
6_addr_safe(p[2]))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     msg(msglevel, &quot;route-ipv6 parameter gateway &#39;%s&#39; must be =
a valid address&quot;, p[2]);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                goto err;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            /* p[3] is metric, if specified */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            goto err;</span><br><span>      =
   }</span><br><span>         add_route_ipv6_to_option_list(options-&gt;rou=
tes_ipv6, p[1], p[2], p[3], options-&gt;route_default_table_id);</span><br>=
<span>     }</span><br><span>@@ -8410,90 +8699,8 @@</span><br><span>     el=
se if (streq(p[0], &quot;dns&quot;) &amp;&amp; p[1])</span><br><span>     {=
</span><br><span>         VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (streq(p[1], &quot;search-domains&quot;) &amp;&=
amp; p[2])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (!check_dns_option(options, p, msglevel, pull_mode))</span><br><span>    =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            dns=
_domain_list_append(&amp;options-&gt;dns_options.search_domains, &amp;p[2],=
 &amp;options-&gt;dns_options.gc);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        else if (streq(p[1], &quot;server&quot;) &amp;&amp; p[2] &amp;&amp=
; p[3] &amp;&amp; p[4])</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  long priority;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       if (!dns_server_priority_parse(&amp;priority, p[2], pull_mode))</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                msg(msglevel, &quo=
t;--dns server: invalid priority value &#39;%s&#39;&quot;, p[2]);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                goto err;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            struct dns_server *server =3D dns_server_get=
(&amp;options-&gt;dns_options.servers, priority, &amp;options-&gt;dns_optio=
ns.gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (streq(p[3], &quot;a=
ddress&quot;) &amp;&amp; p[4])</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                for (int i =3D 4; p[i]; ++i)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                    if (!dns_server_addr_parse(server, =
p[i]))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
         msg(msglevel, &quot;--dns server %ld: malformed address or maximum=
 exceeded &#39;%s&#39;&quot;, priority, p[i]);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                        goto err;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            else if (streq(p[3], &quot;resolve-dom=
ains&quot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                d=
ns_domain_list_append(&amp;server-&gt;domains, &amp;p[4], &amp;options-&gt;=
dns_options.gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e=
lse if (streq(p[3], &quot;dnssec&quot;) &amp;&amp; !p[5])</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                if (streq(p[4], &quot;yes&quot;=
))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ser=
ver-&gt;dnssec =3D DNS_SECURITY_YES;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                else if (streq(p[4], &quot;no&quot;))</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                    server-&gt;dnsse=
c =3D DNS_SECURITY_NO;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             else if (streq(p[4], &quot;optional&quot;))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    server-&gt;dnssec =3D D=
NS_SECURITY_OPTIONAL;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           msg(msglevel, &quot;--dns server %ld: malformed dnssec value &#3=
9;%s&#39;&quot;, priority, p[4]);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                    goto err;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            else if (streq(p[3], &quot;transport&quot;) &amp;&amp; =
!p[5])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                if (str=
eq(p[4], &quot;plain&quot;))</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    server-&gt;transport =3D DNS_TRANSPORT_PLAIN;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                else if (streq(p=
[4], &quot;DoH&quot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 server-&gt;transport =3D DNS_TRANSPORT_HTTPS;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                else if (streq(p[4], &=
quot;DoT&quot;))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           server-&gt;transport =3D DNS_TRANSPORT_TLS;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                else</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                    msg(msglevel, &quot;--dns serve=
r %ld: malformed transport value &#39;%s&#39;&quot;, priority, p[4]);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                    goto er=
r;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            else if (streq(p[3]=
, &quot;sni&quot;) &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                server-&gt;sni =3D p[4];</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            else</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                msg(msglevel, &quot;--dns server %ld: unknown option t=
ype &#39;%s&#39; or missing or unknown parameter&quot;, priority, p[3]);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                goto err=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            msg(msglevel, &quot;--dns: unknown option type &#=
39;%s&#39; or missing or unknown parameter&quot;, p[1]);</span><br><span>  =
           goto err;</span><br><span>         }</span><br><span>     }</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/810?usp=3Demail">change 810</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/810?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia45c99e6df7b3ad24020c10b8a9=
b3577984ecdc2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 810 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 24 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--JNbdgxjPTdo=--

