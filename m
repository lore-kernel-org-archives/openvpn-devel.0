From: "mrbff (Code Review)" <gerrit@...515...>
Date: Wed, 20 Nov 2024 17:42:39 +0000
References: <gerrit.1732124549000.Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ef88f68fd4d7c3955fade1b61f33f2c7830badbc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bqppZPh+aFM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE: Added
 update_option() function.
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bqppZPh+aFM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail

to review the following change.


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
1 file changed, 216 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/810/1

diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 5b4419d..49bd242 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -5759,6 +5759,216 @@
 err:
     msg(msglevel, "Error occurred trying to remove %s option", p[0]);
 }
+
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
+                destroy_routes_v4(c->c1.route_list, c->c1.tuntap,
+                                  ROUTE_OPTION_FLAGS(&c->options),
+                                  es, &c->net_ctx, options);
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
+                destroy_routes_v6(c->c1.route_ipv6_list, c->c1.tuntap,
+                                  ROUTE_OPTION_FLAGS(&c->options),
+                                  es, &c->net_ctx, options);
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
@@ -5772,6 +5982,7 @@
     int line_num =3D 0;
     const char *file =3D "[PUSH-OPTIONS]";
     const int msglevel =3D D_PUSH_ERRORS|M_OPTERR;
+    unsigned int update_options_found =3D 0;

     while (buf_parse(buf, ',', line, sizeof(line)))
     {
@@ -5797,6 +6008,11 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--bqppZPh+aFM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/810?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">PUSH_UPDATE: Added update_option() function.<br><br>When the =
function receives an option to update, it first checks whether it has<br>al=
ready received an option of the same type within the same update message.<b=
r>If it has already received it, it simply calls add_option(), otherwise it=
<br>deletes all the values =E2=80=8B=E2=80=8Balready present regarding that=
 option.<br><br>Change-Id: Ia45c99e6df7b3ad24020c10b8a9b3577984ecdc2<br>Sig=
ned-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn/op=
tions.c<br>1 file changed, 216 insertions(+), 0 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/810/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>i=
ndex 5b4419d..49bd242 100644</span><br><span>--- a/src/openvpn/options.c</s=
pan><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -5759,6 +5759,=
216 @@</span><br><span> err:</span><br><span>     msg(msglevel, &quot;Error=
 occurred trying to remove %s option&quot;, p[0]);</span><br><span> }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+update_option(struct context *c,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+              struct options *options,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+              char *=
p[],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              b=
ool is_inline,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
         const char *file,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+              int line,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+              const int level,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+              const int msglevel,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+              const unsigned int permis=
sion_mask,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
     unsigned int *option_types_found,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+              struct env_set *es,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              unsigned int *update_option=
s_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    const bool pull_mode =3D =
BOOL_CAST(permission_mask &amp; OPT_P_PULL_MODE);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ASSERT(MAX_PARMS &gt;=3D 7);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (streq(p[0], &quot;route&quot;) &amp;&amp; p=
[1] &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
!(*update_options_found &amp; OPT_P_U_ROUTE))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            rol_check_alloc(options=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (p=
ull_mode)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
if (!ip_or_dns_addr_safe(p[1], options-&gt;allow_pull_fqdn) &amp;&amp; !is_=
special_addr(p[1])) /* FQDN -- may be DNS name */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    msg(msglevel, &quot;route p=
arameter network/IP &#39;%s&#39; must be a valid address&quot;, p[1]);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    goto=
 err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
if (p[2] &amp;&amp; !ip_addr_dotted_quad_safe(p[2])) /* FQDN -- must be IP =
address */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         msg(msglevel, &quot;route parameter netmask &#39;%s&#39; must be a=
n IP address&quot;, p[2]);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    goto err;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                if (p[3] &amp;&amp; !ip_or_dns_addr_safe(p[3=
], options-&gt;allow_pull_fqdn) &amp;&amp; !is_special_addr(p[3])) /* FQDN =
-- may be DNS name */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    msg(msglevel, &quot;route parameter gateway &#39;%s&#39=
; must be a valid address&quot;, p[3]);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    goto err;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            if (c-&gt;c1.route_list)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                destroy_routes_v4(c-&gt;c=
1.route_list, c-&gt;c1.tuntap,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                                  ROUTE_OPTION_FLAGS(&amp;c-&gt;=
options),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
                        es, &amp;c-&gt;net_ctx, options);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            *update_options_found |=3D OP=
T_P_U_ROUTE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    else if (streq(p[0], &quot;=
route-ipv6&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (!(*update_options_found &amp; OPT_P_U_ROUTE=
6))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            VERIFY_PERMISS=
ION(OPT_P_ROUTE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          rol6_check_alloc(options);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            if (pull_mode)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                if (!ipv6_addr_safe_hexplusbits(p[1]))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(=
msglevel, &quot;route-ipv6 parameter network/IP &#39;%s&#39; must be a vali=
d address&quot;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    goto err;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                if (p[2] &amp;&amp; !ipv6_addr_safe(p[2]))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                    msg(ms=
glevel, &quot;route-ipv6 parameter gateway &#39;%s&#39; must be a valid add=
ress&quot;, p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   goto err;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                /* p[3] is metric, if present */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (c-&gt;c1.route_ipv6_list)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                destroy_route=
s_v6(c-&gt;c1.route_ipv6_list, c-&gt;c1.tuntap,</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                  ROUTE_OPTION_=
FLAGS(&amp;c-&gt;options),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                  es, &amp;c-&gt;net_ctx, options);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            *update_option=
s_found |=3D OPT_P_U_ROUTE6;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (st=
req(p[0], &quot;redirect-gateway&quot;) || streq(p[0], &quot;redirect-priva=
te&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(*update_o=
ptions_found &amp; OPT_P_U_REDIR_GATEWAY))</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            VERIFY_PERMISSION(OPT_P_ROUTE);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            if (options-&gt;routes)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                options-&gt;=
routes-&gt;flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          if (options-&gt;routes_ipv6)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                options-&gt;routes_ipv6-&gt;flags =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            *update_options_fou=
nd |=3D OPT_P_U_REDIR_GATEWAY;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (=
streq(p[0], &quot;dns&quot;) &amp;&amp; p[1])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        if (!(*update_options_found &amp; OPT_P_U_DNS))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            VERIFY_PERMISSION(OPT_P_D=
HCPDNS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 if (streq(p[1], &quot;server&quot;) &amp;&amp; p[2] &amp;&amp; p[3] &amp;&=
amp; p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 long priority;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            if (!dns_server_priority_parse(&amp;priority, p[2], pull_mode))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    m=
sg(msglevel, &quot;--dns server: invalid priority value &#39;%s&#39;&quot;,=
 p[2]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                struct =
dns_server server;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               CLEAR(server);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                if (streq(p[3], &quot;address&quot;) &amp;&amp; p=
[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   for (int i =3D 4; p[i]; ++i)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                        if (!dns_server_addr_parse(&amp;serve=
r, p[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
              {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                        msg(msglevel, &quot;--dns server %ld: malformed add=
ress or maximum exceeded &#39;%s&#39;&quot;, priority, p[i]);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                            goto =
err;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       else if (streq(p[3], &quot;dnssec&quot;) &amp;&amp; !p[5])</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    if (!streq(=
p[4], &quot;yes&quot;) &amp;&amp; !streq(p[4], &quot;no&quot;) &amp;&amp; !=
streq(p[4], &quot;optional&quot;))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    {</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        msg(msglevel, &quot;--dns server %=
ld: malformed dnssec value &#39;%s&#39;&quot;, priority, p[4]);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                        goto er=
r;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                e=
lse if (streq(p[3], &quot;transport&quot;) &amp;&amp; !p[5])</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    if (!streq(p[4],=
 &quot;plain&quot;) &amp;&amp; !streq(p[4], &quot;DoH&quot;) &amp;&amp; !st=
req(p[4], &quot;DoT&quot;))</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                        msg(msglevel, &quot;--dns server %ld: mal=
formed transport value &#39;%s&#39;&quot;, priority, p[4]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                        goto err;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                else =
if (!streq(p[3], &quot;resolve-domains&quot;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                         &amp;&amp; !(streq(p[3],=
 &quot;sni&quot;) &amp;&amp; !p[5]))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                {</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    msg(msglevel, &quot;--dns server %ld: un=
known option type &#39;%s&#39; or missing or unknown parameter&quot;, prior=
ity, p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            goto err;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      else if (!(streq(p[1], &quot;search-domains&quot;) &amp;&amp; p[2]))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(msglev=
el, &quot;--dns: unknown option type &#39;%s&#39; or missing or unknown par=
ameter&quot;, p[1]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                goto err;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            gc_fre=
e(&amp;options-&gt;dns_options.gc);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            CLEAR(options-&gt;dns_options);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            *update_options_found |=
=3D OPT_P_U_DNS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32) || defi=
ned(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] &amp;&amp=
; !p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(*update_opt=
ions_found &amp; OPT_P_U_DHCP))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            struct tuntap_options *o =3D &amp;options-&gt;tuntap_options;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            VERIFY_=
PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
o-&gt;domain =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            o-&gt;netbios_scope =3D NULL;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            o-&gt;netbios_node_type =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;dns6_len =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            C=
LEAR(o-&gt;dns6);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          o-&gt;dns_len =3D 0;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            CLEAR(o-&gt;dns);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            o-&gt;wins_len =3D 0;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            CLEAR(o-&gt;wins);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;ntp_len =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            CLEA=
R(o-&gt;ntp);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      o-&gt;nbdd_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            CLEAR(o-&gt;nbdd);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            while (o-&gt;domain_search_list_len-- &gt; 0=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                o-&gt;do=
main_search_list[o-&gt;domain_search_list_len] =3D NULL;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            o-&gt;disable_nbt =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;dhcp_opti=
ons =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defin=
ed(TARGET_ANDROID)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           o-&gt;http_proxy_port =3D 0;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            o-&gt;http_proxy =3D NULL;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            *update_options_found |=3D OPT_P_U_DH=
CP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#else /* if defined(_WIN32) || defined(T=
ARGET_ANDROID) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  else if (streq(p[0], &quot;dhcp-option&quot;) &amp;&amp; p[1] &amp;&amp; =
!p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!(*update_optio=
ns_found &amp; OPT_P_U_DHCP))</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            VERIFY_PERMISSION(OPT_P_DHCPDNS);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            delete_all_dhcp_fo(options, &amp;es-&=
gt;list);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  *update_options_found |=3D OPT_P_U_DHCP;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    add_option(options, p, is_inline,=
 file, line,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
        level, msglevel, permission_mask,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+               option_types_found, es);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+err:</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    msg(msglevel, &quot;Error occurred trying to update =
%s option&quot;, p[0]);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> bool</span><br><span> apply_push_options(struct context *c,</span><br><=
span>                    struct options *options,</span><br><span>@@ -5772,=
6 +5982,7 @@</span><br><span>     int line_num =3D 0;</span><br><span>     =
const char *file =3D &quot;[PUSH-OPTIONS]&quot;;</span><br><span>     const=
 int msglevel =3D D_PUSH_ERRORS|M_OPTERR;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    unsigned int update_options_found =3D 0;</span><b=
r><span> </span><br><span>     while (buf_parse(buf, &#39;,&#39;, line, siz=
eof(line)))</span><br><span>     {</span><br><span>@@ -5797,6 +6008,11 @@</=
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
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--bqppZPh+aFM=--

