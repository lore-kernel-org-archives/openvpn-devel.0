From: "mrbff (Code Review)" <gerrit@...515...>
Date: Fri, 21 Mar 2025 04:57:34 +0000
In-Reply-To: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
References: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <00eac556dac4087c94f0010ad83c7ff2c5f379c3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ftdkIf01rDw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ftdkIf01rDw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail

to look at the new patch set (#13).

The change is no longer submittable: checks~ChecksSubmitRule is unsatisfied=
 now.


Change subject: PUSH_UPDATE: Added update_option() function.
......................................................................

PUSH_UPDATE: Added update_option() function.

When the function receives an option to update, it first checks whether it =
has
already received an option of the same type within the same update message.
If it has already received it, it simply calls add_option(), otherwise it
deletes all the values =E2=80=8B=E2=80=8Balready present regarding that opt=
ion.

Change-Id: Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/options.c
1 file changed, 247 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/810/13

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b35f82b..4626747 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5560,6 +5560,13 @@
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
@@ -5614,11 +5621,7 @@
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
@@ -5629,11 +5632,7 @@
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
@@ -5752,6 +5751,238 @@
 err:
     msg(msglevel, "Error occurred trying to remove %s option", p[0]);
 }
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
+            rol_check_alloc(options);
+            if (pull_mode)
+            {
+                if (!ip_or_dns_addr_safe(p[1], options->allow_pull_fqdn) &=
& !is_special_addr(p[1])) /* FQDN -- may be DNS name */
+                {
+                    msg(msglevel, "route parameter network/IP '%s' must be=
 a valid address", p[1]);
+                    goto err;
+                }
+                if (p[2] && !ip_addr_dotted_quad_safe(p[2])) /* FQDN -- mu=
st be IP address */
+                {
+                    msg(msglevel, "route parameter netmask '%s' must be an=
 IP address", p[2]);
+                    goto err;
+                }
+                if (p[3] && !ip_or_dns_addr_safe(p[3], options->allow_pull=
_fqdn) && !is_special_addr(p[3])) /* FQDN -- may be DNS name */
+                {
+                    msg(msglevel, "route parameter gateway '%s' must be a =
valid address", p[3]);
+                    goto err;
+                }
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
+            rol6_check_alloc(options);
+            if (pull_mode)
+            {
+                if (!ipv6_addr_safe_hexplusbits(p[1]))
+                {
+                    msg(msglevel, "route-ipv6 parameter network/IP '%s' mu=
st be a valid address", p[1]);
+                    goto err;
+                }
+                if (p[2] && !ipv6_addr_safe(p[2]))
+                {
+                    msg(msglevel, "route-ipv6 parameter gateway '%s' must =
be a valid address", p[2]);
+                    goto err;
+                }
+                /* p[3] is metric, if present */
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
+            if (streq(p[1], "server") && p[2] && p[3] && p[4])
+            {
+                long priority;
+                if (!dns_server_priority_parse(&priority, p[2], pull_mode))
+                {
+                    msg(msglevel, "--dns server: invalid priority value '%=
s'", p[2]);
+                    goto err;
+                }
+
+                struct dns_server server;
+                CLEAR(server);
+                if (streq(p[3], "address") && p[4])
+                {
+                    for (int i =3D 4; p[i]; ++i)
+                    {
+                        if (!dns_server_addr_parse(&server, p[i]))
+                        {
+                            msg(msglevel, "--dns server %ld: malformed add=
ress or maximum exceeded '%s'", priority, p[i]);
+                            goto err;
+                        }
+                    }
+                }
+                else if (streq(p[3], "dnssec") && !p[5])
+                {
+                    if (!streq(p[4], "yes") && !streq(p[4], "no") && !stre=
q(p[4], "optional"))
+                    {
+                        msg(msglevel, "--dns server %ld: malformed dnssec =
value '%s'", priority, p[4]);
+                        goto err;
+                    }
+                }
+                else if (streq(p[3], "transport") && !p[5])
+                {
+                    if (!streq(p[4], "plain") && !streq(p[4], "DoH") && !s=
treq(p[4], "DoT"))
+                    {
+                        msg(msglevel, "--dns server %ld: malformed transpo=
rt value '%s'", priority, p[4]);
+                        goto err;
+                    }
+                }
+                else if (!streq(p[3], "resolve-domains")
+                         && !(streq(p[3], "sni") && !p[5]))
+                {
+                    msg(msglevel, "--dns server %ld: unknown option type '=
%s' or missing or unknown parameter", priority, p[3]);
+                    goto err;
+                }
+            }
+            else if (!(streq(p[1], "search-domains") && p[2]))
+            {
+                msg(msglevel, "--dns: unknown option type '%s' or missing =
or unknown parameter", p[1]);
+                goto err;
+            }
+
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
 bool
 apply_push_options(struct context *c,
                    struct options *options,
@@ -5765,6 +5996,7 @@
     int line_num =3D 0;
     const char *file =3D "[PUSH-OPTIONS]";
     const int msglevel =3D D_PUSH_ERRORS|M_OPTERR;
+    unsigned int update_options_found =3D 0;

     while (buf_parse(buf, ',', line, sizeof(line)))
     {
@@ -5790,6 +6022,11 @@
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

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2
Gerrit-Change-Number: 810
Gerrit-PatchSet: 13
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-MessageType: newpatchset

--ftdkIf01rDw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>mrbff <strong>uploaded patch set #13</strong> to this change.</p><p><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail">View Change</=
a></p><p>The change is no longer submittable: checks~ChecksSubmitRule is un=
satisfied now.</p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">PUSH_UPDATE: Added update_option() function.<br><br>When the=
 function receives an option to update, it first checks whether it has<br>a=
lready received an option of the same type within the same update message.<=
br>If it has already received it, it simply calls add_option(), otherwise i=
t<br>deletes all the values =E2=80=8B=E2=80=8Balready present regarding tha=
t option.<br><br>Change-Id: Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2<br>Si=
gned-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn/o=
ptions.c<br>1 file changed, 247 insertions(+), 10 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/810/13</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><spa=
n>index b35f82b..4626747 100644</span><br><span>--- a/src/openvpn/options.c=
</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -5560,6 +55=
60,13 @@</span><br><span>     return options-&gt;forward_compatible ? M_WAR=
N : msglevel;</span><br><span> }</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#define RESET_OPTION_ROUTES(option_ptr, fiel=
d) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (option_=
ptr)                        \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {                                      \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        option_ptr-&gt;field =3D NULL;  =
        \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        op=
tion_ptr-&gt;flags =3D 0;             \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> /**</span><br><span>  * @brief Resets options found=
 in the PUSH_UPDATE message that are preceded by the `-` flag.</span><br><s=
pan>  *        This function is used in push-updates to reset specified opt=
ions.</span><br><span>@@ -5614,11 +5621,7 @@</span><br><span>             d=
elete_routes_v4(c-&gt;c1.route_list, c-&gt;c1.tuntap,</span><br><span>     =
                         ROUTE_OPTION_FLAGS(&amp;c-&gt;options),</span><br>=
<span>                              es, &amp;c-&gt;net_ctx);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;routes)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                options-&gt;ro=
utes-&gt;routes =3D NULL;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                options-&gt;routes-&gt;flags =3D 0;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            RESET_OPTION_ROUTES(options-&gt;rou=
tes, routes);</span><br><span>         }</span><br><span>     }</span><br><=
span>     else if (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp; !p[1])</s=
pan><br><span>@@ -5629,11 +5632,7 @@</span><br><span>             delete_ro=
utes_v6(c-&gt;c1.route_ipv6_list, c-&gt;c1.tuntap,</span><br><span>        =
                      ROUTE_OPTION_FLAGS(&amp;c-&gt;options),</span><br><sp=
an>                              es, &amp;c-&gt;net_ctx);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            if (options-&gt;routes_ipv6=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                options-&gt;=
routes_ipv6-&gt;routes_ipv6 =3D NULL;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                options-&gt;routes_ipv6-&gt;flags =3D 0;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            RESET_OPTION_ROUTE=
S(options-&gt;routes_ipv6, routes_ipv6);</span><br><span>         }</span><=
br><span>     }</span><br><span>     else if (streq(p[0], &quot;route-gatew=
ay&quot;) &amp;&amp; !p[1])</span><br><span>@@ -5752,6 +5751,238 @@</span><=
br><span> err:</span><br><span>     msg(msglevel, &quot;Error occurred tryi=
ng to remove %s option&quot;, p[0]);</span><br><span> }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @brief Processes an option to update. It first checks whether it has al=
ready</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *        rece=
ived an option of the same type within the same update message.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *        If the option has alr=
eady been received, it calls add_option().</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *        Otherwise, it deletes all existing values =
related to that option before calling add_option().</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * @param c The context structure.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param options A pointer to the option=
s structure.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am p An array of strings containing the options and their parameters.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param is_inline A boo=
lean indicating if the option is inline.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param file The file where the function is called.<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param line The l=
ine number where the function is called.</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @param level The level of the option.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param msglevel The message le=
vel for logging.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
@param permission_mask The permission mask used by VERIFY_PERMISSION().</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param option_types_=
found A pointer to the variable where the flags corresponding to the option=
s found are stored.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 * @param es The environment set structure.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param update_options_found A pointer to the var=
iable where the flags corresponding to the update options found are stored,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *                 =
            used to check if an option of the same type has already been pr=
ocessed by update_option() within the same push-update message.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+update_option(struct context *c,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              struct options *options,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+              char *p[=
],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              boo=
l is_inline,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
       const char *file,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+              int line,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+              const int level,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+              const int msglevel,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              const unsigned int permissi=
on_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
   unsigned int *option_types_found,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+              struct env_set *es,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+              unsigned int *update_options_f=
ound)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    const bool pull_mode =3D BOO=
L_CAST(permission_mask &amp; OPT_P_PULL_MODE);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    ASSERT(MAX_PARMS &gt;=3D 7);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (streq(p[0], &quot;route&quot;) &amp;&amp; p[1]=
 &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(*=
update_options_found &amp; OPT_P_U_ROUTE))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            rol_check_alloc(options);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (pull=
_mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if =
(!ip_or_dns_addr_safe(p[1], options-&gt;allow_pull_fqdn) &amp;&amp; !is_spe=
cial_addr(p[1])) /* FQDN -- may be DNS name */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    msg(msglevel, &quot;route para=
meter network/IP &#39;%s&#39; must be a valid address&quot;, p[1]);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    goto er=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                if =
(p[2] &amp;&amp; !ip_addr_dotted_quad_safe(p[2])) /* FQDN -- must be IP add=
ress */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      msg(msglevel, &quot;route parameter netmask &#39;%s&#39; must be an I=
P address&quot;, p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    goto err;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                if (p[3] &amp;&amp; !ip_or_dns_addr_safe(p[3], =
options-&gt;allow_pull_fqdn) &amp;&amp; !is_special_addr(p[3])) /* FQDN -- =
may be DNS name */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 msg(msglevel, &quot;route parameter gateway &#39;%s&#39; m=
ust be a valid address&quot;, p[3]);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    goto err;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            if (c-&gt;c1.route_list)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                delete_routes_v4(c-&gt;c1.rou=
te_list, c-&gt;c1.tuntap,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                 ROUTE_OPTION_FLAGS(&amp;c-&gt;option=
s),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                 es, &amp;c-&gt;net_ctx);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                RESET_OPTION_ROUTES(options-&gt;route=
s, routes);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            *u=
pdate_options_found |=3D OPT_P_U_ROUTE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
else if (streq(p[0], &quot;route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; !p[=
4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (!(*update_options_=
found &amp; OPT_P_U_ROUTE6))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            rol6_check_alloc(options);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (pull_mode)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                if (!ipv6_addr_s=
afe_hexplusbits(p[1]))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    msg(msglevel, &quot;route-ipv6 parameter network/IP &#=
39;%s&#39; must be a valid address&quot;, p[1]);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    goto err;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                if (p[2] &amp;&amp; !i=
pv6_addr_safe(p[2]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   msg(msglevel, &quot;route-ipv6 parameter gateway &#39;%s=
&#39; must be a valid address&quot;, p[2]);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    goto err;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                /* p[3] is metric, if pre=
sent */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (c-=
&gt;c1.route_ipv6_list)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              delete_routes_v6(c-&gt;c1.route_ipv6_list, c-&gt;c1.tuntap,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
            ROUTE_OPTION_FLAGS(&amp;c-&gt;options),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                 es, &amp=
;c-&gt;net_ctx);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             RESET_OPTION_ROUTES(options-&gt;routes_ipv6, routes_ipv6);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            *update_options_f=
ound |=3D OPT_P_U_ROUTE6;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq=
(p[0], &quot;redirect-gateway&quot;) || streq(p[0], &quot;redirect-private&=
quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(*update_opti=
ons_found &amp; OPT_P_U_REDIR_GATEWAY))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+            VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (options-&gt;routes)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                options-&gt;rou=
tes-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       if (options-&gt;routes_ipv6)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                options-&gt;routes_ipv6-&gt;flags =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            *update_options_found =
|=3D OPT_P_U_REDIR_GATEWAY;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (str=
eq(p[0], &quot;dns&quot;) &amp;&amp; p[1])</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        if (!(*update_options_found &amp; OPT_P_U_DNS))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            VERIFY_PERMISSION(OPT_P_DHCP=
DNS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if=
 (streq(p[1], &quot;server&quot;) &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp=
; p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                lo=
ng priority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         if (!dns_server_priority_parse(&amp;priority, p[2], pull_mode))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(=
msglevel, &quot;--dns server: invalid priority value &#39;%s&#39;&quot;, p[=
2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                struct dns=
_server server;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            CLEAR(server);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                if (streq(p[3], &quot;address&quot;) &amp;&amp; p[4]=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
for (int i =3D 4; p[i]; ++i)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        if (!dns_server_addr_parse(&amp;server, =
p[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                     msg(msglevel, &quot;--dns server %ld: malformed addres=
s or maximum exceeded &#39;%s&#39;&quot;, priority, p[i]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                            goto err=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    else if (streq(p[3], &quot;dnssec&quot;) &amp;&amp; !p[5])</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    if (!streq(p[4=
], &quot;yes&quot;) &amp;&amp; !streq(p[4], &quot;no&quot;) &amp;&amp; !str=
eq(p[4], &quot;optional&quot;))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        msg(msglevel, &quot;--dns server %ld:=
 malformed dnssec value &#39;%s&#39;&quot;, priority, p[4]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        goto err;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                else=
 if (streq(p[3], &quot;transport&quot;) &amp;&amp; !p[5])</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    if (!streq(p[4], &q=
uot;plain&quot;) &amp;&amp; !streq(p[4], &quot;DoH&quot;) &amp;&amp; !streq=
(p[4], &quot;DoT&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        msg(msglevel, &quot;--dns server %ld: malfor=
med transport value &#39;%s&#39;&quot;, priority, p[4]);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        goto err;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                else if =
(!streq(p[3], &quot;resolve-domains&quot;)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                         &amp;&amp; !(streq(p[3], &q=
uot;sni&quot;) &amp;&amp; !p[5]))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    msg(msglevel, &quot;--dns server %ld: unkno=
wn option type &#39;%s&#39; or missing or unknown parameter&quot;, priority=
, p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   else if (!(streq(p[1], &quot;search-domains&quot;) &amp;&amp; p[2]))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msglevel,=
 &quot;--dns: unknown option type &#39;%s&#39; or missing or unknown parame=
ter&quot;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&=
amp;options-&gt;dns_options.gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            CLEAR(options-&gt;dns_options);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            *update_options_found |=3D=
 OPT_P_U_DNS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defined=
(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(*update_option=
s_found &amp; OPT_P_U_DHCP))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           struct tuntap_options *o =3D &amp;options-&gt;tuntap_options;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            VERIFY_PER=
MISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&=
gt;domain =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            o-&gt;netbios_scope =3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            o-&gt;netbios_node_type =3D 0;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;dns6_len =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            CLEA=
R(o-&gt;dns6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       o-&gt;dns_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            CLEAR(o-&gt;dns);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            o-&gt;wins_len =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            CLEAR(o-&gt;wins);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;ntp_len =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            CLEAR=
(o-&gt;ntp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     o-&gt;nbdd_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            CLEAR(o-&gt;nbdd);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            while (o-&gt;domain_search_list_len-- &gt; 0)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                o-&gt;dom=
ain_search_list[o-&gt;domain_search_list_len] =3D NULL;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            o-&gt;disable_nbt =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;dhcp_optio=
ns =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if define=
d(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          o-&gt;http_proxy_port =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            o-&gt;http_proxy =3D NULL;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            *update_options_found |=3D OPT_P_U_DHC=
P;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else /* if defined(_WIN32) || defined(TA=
RGET_ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] &amp;&amp; !=
p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(*update_option=
s_found &amp; OPT_P_U_DHCP))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            delete_all_dhcp_fo(options, &amp;es-&g=
t;list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 *update_options_found |=3D OPT_P_U_DHCP;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#e=
ndif /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    add_option(options, p, is_inline, =
file, line,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
       level, msglevel, permission_mask,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+               option_types_found, es);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(msglevel, &quot;Error occurred trying to update =
%s option&quot;, p[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> bool</span><br><span> apply_push_options(struct context *c,</span><br><=
span>                    struct options *options,</span><br><span>@@ -5765,=
6 +5996,7 @@</span><br><span>     int line_num =3D 0;</span><br><span>     =
const char *file =3D &quot;[PUSH-OPTIONS]&quot;;</span><br><span>     const=
 int msglevel =3D D_PUSH_ERRORS|M_OPTERR;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    unsigned int update_options_found =3D 0;</span><b=
r><span> </span><br><span>     while (buf_parse(buf, &#39;,&#39;, line, siz=
eof(line)))</span><br><span>     {</span><br><span>@@ -5790,6 +6022,11 @@</=
span><br><span>                 remove_option(c, options, p, false, file, l=
ine_num, msglevel,</span><br><span>                               permissio=
n_mask, option_types_found, es);</span><br><span>             }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                update_option(c, options=
, p, false, file, line_num, 0, msglevel,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                              permission_mask, option_=
types_found, es, &amp;update_options_found);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            }</span><br><span>         }</span><br=
><span>     }</span><br><span>     return true;</span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/81=
0?usp=3Demail">change 810</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia45c99e6df7b3ad24020c10b8a9=
b3577984ecdc2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 810 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--ftdkIf01rDw=--

