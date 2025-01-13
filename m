From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 13 Jan 2025 13:12:16 +0000
In-Reply-To: <gerrit.1733989644000.I3fb01ab76cf3df0874ba92e08f371d17607a8369@...2715...>
References: <gerrit.1733989644000.I3fb01ab76cf3df0874ba92e08f371d17607a8369@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a7e11016a114631f281dc7c769e55533a80728ac-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="F6Ieg5q9Gpo="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dns: don't publish
 env vars to non-dns scripts
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

--F6Ieg5q9Gpo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/840?usp=3Demail

to look at the new patch set (#7).


Change subject: dns: don't publish env vars to non-dns scripts
......................................................................

dns: don't publish env vars to non-dns scripts

With --dns-script in place we no longer need DNS related vars in the
environment for other script hooks. Code for doing that is removed and
the function to set --dns stuff made static, for internal use only.

Another thing: since --dns setting overrule DNS related --dhcp-options,
remove the latter when we got some via --dns.

Change-Id: I3fb01ab76cf3df0874ba92e08f371d17607a8369
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
3 files changed, 110 insertions(+), 257 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/840/7

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 54520a2..5a32646 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -349,93 +349,6 @@
     }
 }

-static void
-setenv_dns_option(struct env_set *es,
-                  const char *format, int i, int j,
-                  const char *value)
-{
-    char name[64];
-    bool name_ok =3D false;
-
-    if (j < 0)
-    {
-        name_ok =3D snprintf(name, sizeof(name), format, i);
-    }
-    else
-    {
-        name_ok =3D snprintf(name, sizeof(name), format, i, j);
-    }
-
-    if (!name_ok)
-    {
-        msg(M_WARN, "WARNING: dns option setenv name buffer overflow");
-    }
-
-    setenv_str(es, name, value);
-}
-
-void
-setenv_dns_options(const struct dns_options *o, struct env_set *es)
-{
-    struct gc_arena gc =3D gc_new();
-    const struct dns_server *s;
-    const struct dns_domain *d;
-    int i, j;
-
-    for (i =3D 1, d =3D o->search_domains; d !=3D NULL; i++, d =3D d->next)
-    {
-        setenv_dns_option(es, "dns_search_domain_%d", i, -1, d->name);
-    }
-
-    for (i =3D 1, s =3D o->servers; s !=3D NULL; i++, s =3D s->next)
-    {
-        for (j =3D 0; j < s->addr_count; ++j)
-        {
-            if (s->addr[j].family =3D=3D AF_INET)
-            {
-                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
-                                  print_in_addr_t(s->addr[j].in.a4.s_addr,=
 IA_NET_ORDER, &gc));
-            }
-            else
-            {
-                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
-                                  print_in6_addr(s->addr[j].in.a6, 0, &gc)=
);
-            }
-            if (s->addr[j].port)
-            {
-                setenv_dns_option(es, "dns_server_%d_port_%d", i, j + 1,
-                                  print_in_port_t(s->addr[j].port, &gc));
-            }
-        }
-
-        if (s->domains)
-        {
-            for (j =3D 1, d =3D s->domains; d !=3D NULL; j++, d =3D d->nex=
t)
-            {
-                setenv_dns_option(es, "dns_server_%d_resolve_domain_%d", i=
, j, d->name);
-            }
-        }
-
-        if (s->dnssec)
-        {
-            setenv_dns_option(es, "dns_server_%d_dnssec", i, -1,
-                              dnssec_value(s->dnssec));
-        }
-
-        if (s->transport)
-        {
-            setenv_dns_option(es, "dns_server_%d_transport", i, -1,
-                              transport_value(s->transport));
-        }
-        if (s->sni)
-        {
-            setenv_dns_option(es, "dns_server_%d_sni", i, -1, s->sni);
-        }
-    }
-
-    gc_free(&gc);
-}
-
 #ifdef _WIN32

 static void
@@ -524,6 +437,93 @@
 #else /* ifdef _WIN32 */

 static void
+setenv_dns_option(struct env_set *es,
+                  const char *format, int i, int j,
+                  const char *value)
+{
+    char name[64];
+    bool name_ok =3D false;
+
+    if (j < 0)
+    {
+        name_ok =3D snprintf(name, sizeof(name), format, i);
+    }
+    else
+    {
+        name_ok =3D snprintf(name, sizeof(name), format, i, j);
+    }
+
+    if (!name_ok)
+    {
+        msg(M_WARN, "WARNING: dns option setenv name buffer overflow");
+    }
+
+    setenv_str(es, name, value);
+}
+
+static void
+setenv_dns_options(const struct dns_options *o, struct env_set *es)
+{
+    struct gc_arena gc =3D gc_new();
+    const struct dns_server *s;
+    const struct dns_domain *d;
+    int i, j;
+
+    for (i =3D 1, d =3D o->search_domains; d !=3D NULL; i++, d =3D d->next)
+    {
+        setenv_dns_option(es, "dns_search_domain_%d", i, -1, d->name);
+    }
+
+    for (i =3D 1, s =3D o->servers; s !=3D NULL; i++, s =3D s->next)
+    {
+        for (j =3D 0; j < s->addr_count; ++j)
+        {
+            if (s->addr[j].family =3D=3D AF_INET)
+            {
+                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                                  print_in_addr_t(s->addr[j].in.a4.s_addr,=
 IA_NET_ORDER, &gc));
+            }
+            else
+            {
+                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                                  print_in6_addr(s->addr[j].in.a6, 0, &gc)=
);
+            }
+            if (s->addr[j].port)
+            {
+                setenv_dns_option(es, "dns_server_%d_port_%d", i, j + 1,
+                                  print_in_port_t(s->addr[j].port, &gc));
+            }
+        }
+
+        if (s->domains)
+        {
+            for (j =3D 1, d =3D s->domains; d !=3D NULL; j++, d =3D d->nex=
t)
+            {
+                setenv_dns_option(es, "dns_server_%d_resolve_domain_%d", i=
, j, d->name);
+            }
+        }
+
+        if (s->dnssec)
+        {
+            setenv_dns_option(es, "dns_server_%d_dnssec", i, -1,
+                              dnssec_value(s->dnssec));
+        }
+
+        if (s->transport)
+        {
+            setenv_dns_option(es, "dns_server_%d_transport", i, -1,
+                              transport_value(s->transport));
+        }
+        if (s->sni)
+        {
+            setenv_dns_option(es, "dns_server_%d_sni", i, -1, s->sni);
+        }
+    }
+
+    gc_free(&gc);
+}
+
+static void
 script_env_set(bool up, const struct dns_options *o, const struct tuntap *=
tt, struct env_set *es)
 {
     setenv_str(es, "dev", tt->actual_name);
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 47f7e5d..bdf49fd 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -167,14 +167,6 @@
                      struct dns_script_runner_info *dsri);

 /**
- * Puts the DNS options into an environment set.
- *
- * @param   o           Pointer to the DNS options to set
- * @param   es          Pointer to the env_set to set the options into
- */
-void setenv_dns_options(const struct dns_options *o, struct env_set *es);
-
-/**
  * Prints configured DNS options.
  *
  * @param   o           Pointer to the DNS options to print
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 9c7a9ae..aa4ef27 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -1029,11 +1029,6 @@
     {
         setenv_connection_entry(es, &o->ce, 1);
     }
-
-    if (!o->pull)
-    {
-        setenv_dns_options(&o->dns_options, es);
-    }
 }

 #ifndef _WIN32
@@ -1347,149 +1342,6 @@
         }
     }
 }
-
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
-        for (int i =3D 0; i < server->addr_count; ++i)
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
 #endif /* if defined(_WIN32) || defined(TARGET_ANDROID) */

 #ifndef ENABLE_SMALL
@@ -3796,14 +3648,6 @@
     {
         dns_options_preprocess_pull(&o->dns_options);
     }
-    else
-    {
-#if defined(_WIN32) || defined(TARGET_ANDROID)
-        tuntap_options_copy_dns(o);
-#else
-        foreign_options_copy_dns(o, es);
-#endif
-    }
     if (o->auth_token_generate && !o->auth_token_renewal)
     {
         o->auth_token_renewal =3D o->renegotiate_seconds;
@@ -4174,7 +4018,6 @@

 /*
  * Sanity check on options after more options were pulled from server.
- * Also time to modify some options based on other options.
  */
 bool
 options_postprocess_pull(struct options *o, struct env_set *es)
@@ -4183,12 +4026,30 @@
     if (success)
     {
         dns_options_postprocess_pull(&o->dns_options);
-        setenv_dns_options(&o->dns_options, es);
+
 #if defined(_WIN32) || defined(TARGET_ANDROID)
-        tuntap_options_copy_dns(o);
-#else
-        foreign_options_copy_dns(o, es);
-#endif
+        /* If there's --dns servers, remove dns related --dhcp-options */
+        if (o->dns_options.servers)
+        {
+            o->tuntap_options.dns_len =3D 0;
+            o->tuntap_options.dns6_len =3D 0;
+            o->tuntap_options.domain =3D NULL;
+            o->tuntap_options.domain_search_list_len =3D 0;
+        }
+        /* Override search domains with the ones from --dns */
+        else if (o->dns_options.search_domains)
+        {
+            int i =3D 0;
+            struct dns_domain *domain =3D o->dns_options.search_domains;
+            while (i < N_SEARCH_LIST_LEN && domain)
+            {
+                o->tuntap_options.domain_search_list[i] =3D domain->name;
+                domain =3D domain->next;
+                ++i;
+            }
+            o->tuntap_options.domain_search_list_len =3D i;
+        }
+#endif /* defined(_WIN32) || defined(TARGET_ANDROID) */
     }
     return success;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/840?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3fb01ab76cf3df0874ba92e08f371d17607a8369
Gerrit-Change-Number: 840
Gerrit-PatchSet: 7
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--F6Ieg5q9Gpo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk <strong>uploaded patch set #7</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/840?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dns: don&#39;t publish env vars to non-dns scripts<br><br>With --dns-scri=
pt in place we no longer need DNS related vars in the<br>environment for ot=
her script hooks. Code for doing that is removed and<br>the function to set=
 --dns stuff made static, for internal use only.<br><br>Another thing: sinc=
e --dns setting overrule DNS related --dhcp-options,<br>remove the latter w=
hen we got some via --dns.<br><br>Change-Id: I3fb01ab76cf3df0874ba92e08f371=
d17607a8369<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>---<br=
>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvpn/options.c<br>3=
 files changed, 110 insertions(+), 257 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/40/840/7</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index 54520a2..5a3=
2646 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/s=
rc/openvpn/dns.c</span><br><span>@@ -349,93 +349,6 @@</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-setenv_dns_option(struct env_set *es,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                  const char *format, int i, int j,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                  cons=
t char *value)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    char name[64];</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    bool name_ok =3D false;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (j &lt; 0)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        name_ok =3D snprintf(name, sizeof(name), format, i);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    else</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        name_ok =3D snprintf(name, sizeof(name), format, i, j);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (!name_ok)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m=
sg(M_WARN, &quot;WARNING: dns option setenv name buffer overflow&quot;);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    setenv_str(es, name, value);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-setenv_dns_options(const struct d=
ns_options *o, struct env_set *es)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    str=
uct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    const struct dns_server *s;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    const struct dns_domain *d;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    int i, j;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   for (i =3D 1, d =3D o-&gt;search_domains; d !=3D NULL; i++, d =3D d-&gt;=
next)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        setenv_dns_option(es, &q=
uot;dns_search_domain_%d&quot;, i, -1, d-&gt;name);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    f=
or (i =3D 1, s =3D o-&gt;servers; s !=3D NULL; i++, s =3D s-&gt;next)</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        for (j =3D 0; j &lt; s-&gt;addr_cou=
nt; ++j)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (s-&gt;add=
r[j].family =3D=3D AF_INET)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              setenv_dns_option(es, &quot;dns_server_%d_address_%d&quot;, i=
, j + 1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                     print_in_addr_t(s-&gt;addr[j].in.a4.s_addr, IA_NET_ORD=
ER, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                setenv_dns_o=
ption(es, &quot;dns_server_%d_address_%d&quot;, i, j + 1,</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                                  print=
_in6_addr(s-&gt;addr[j].in.a6, 0, &amp;gc));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if (s-&gt;addr[j].port)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                setenv_dns_option(es, &quot;dns_server=
_%d_port_%d&quot;, i, j + 1,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                                  print_in_port_t(s-&gt;addr[j].port=
, &amp;gc));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (s-&gt;domains)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            for (j =3D 1, d =3D s-&gt;domains; d !=3D N=
ULL; j++, d =3D d-&gt;next)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              setenv_dns_option(es, &quot;dns_server_%d_resolve_domain_%d&q=
uot;, i, j, d-&gt;name);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        if (s-&gt;dnssec)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            setenv_dns_option(es, &quot;dns_se=
rver_%d_dnssec&quot;, i, -1,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                              dnssec_value(s-&gt;dnssec));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        if (s-&gt;transport)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            setenv_dns_option(es, &quot;dns_server_%d_transport&quot;=
, i, -1,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                 transport_value(s-&gt;transport));</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (s-&gt;sni)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            setenv_dns_option(es, &quot;dns_server_%d_sni&quot;, i=
, -1, s-&gt;sni);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span> #ifdef _WIN32</span><br><span> </span><br><span> static=
 void</span><br><span>@@ -524,6 +437,93 @@</span><br><span> #else /* ifdef =
_WIN32 */</span><br><span> </span><br><span> static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+setenv_dns_option(struct env_set *es,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  co=
nst char *format, int i, int j,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                  const char *value)</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    char name[64];</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    bool name_ok =3D false;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (j &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        name_ok =
=3D snprintf(name, sizeof(name), format, i);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        name_o=
k =3D snprintf(name, sizeof(name), format, i, j);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 if (!name_ok)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_WARN,=
 &quot;WARNING: dns option setenv name buffer overflow&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    setenv_str(es, name, value);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_dns_options(con=
st struct dns_options *o, struct env_set *es)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    const struct dns_server *s;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const struct dns_domain *d;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    int i, j;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    for (i =3D 1, d =3D o-&gt;search_domains; d !=
=3D NULL; i++, d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       setenv_dns_option(es, &quot;dns_search_domain_%d&quot;, i, -1, d-&gt=
;name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    for (i =3D 1, s =3D o-&gt;servers; s !=3D=
 NULL; i++, s =3D s-&gt;next)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    for (j =3D 0; j &lt; s-&gt;addr_count; ++j)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            if (s-&gt;addr[j].family =3D=3D AF_INET)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                setenv_dns_opt=
ion(es, &quot;dns_server_%d_address_%d&quot;, i, j + 1,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                  print=
_in_addr_t(s-&gt;addr[j].in.a4.s_addr, IA_NET_ORDER, &amp;gc));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                setenv_dns_option(es, &quot;dn=
s_server_%d_address_%d&quot;, i, j + 1,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                                  print_in6_addr(s-&gt;=
addr[j].in.a6, 0, &amp;gc));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            if (s-&gt;addr[j].port)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                setenv_dns_option(es, &quot;dns_server_%d_port=
_%d&quot;, i, j + 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                                  print_in_port_t(s-&gt;addr[j].port, &amp=
;gc));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        if (s-&gt;domains)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            for (j =3D 1, d =3D s-&gt;domains; d !=
=3D NULL; j++, d =3D d-&gt;next)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                setenv_dns_option(es, &quot;dns_server_%d_resolve_do=
main_%d&quot;, i, j, d-&gt;name);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (s-&gt;dns=
sec)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            setenv_dns_op=
tion(es, &quot;dns_server_%d_dnssec&quot;, i, -1,</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                              dnssec_value(s-=
&gt;dnssec));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (s-&gt;transport)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            setenv_dns_option(es, &q=
uot;dns_server_%d_transport&quot;, i, -1,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                              transport_value(s-&gt;t=
ransport));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (s-&gt;=
sni)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            setenv_dns_op=
tion(es, &quot;dns_server_%d_sni&quot;, i, -1, s-&gt;sni);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> script_env=
_set(bool up, const struct dns_options *o, const struct tuntap *tt, struct =
env_set *es)</span><br><span> {</span><br><span>     setenv_str(es, &quot;d=
ev&quot;, tt-&gt;actual_name);</span><br><span>diff --git a/src/openvpn/dns=
.h b/src/openvpn/dns.h</span><br><span>index 47f7e5d..bdf49fd 100644</span>=
<br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</=
span><br><span>@@ -167,14 +167,6 @@</span><br><span>                      s=
truct dns_script_runner_info *dsri);</span><br><span> </span><br><span> /**=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Puts the DNS optio=
ns into an environment set.</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param   o=
           Pointer to the DNS options to set</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">- * @param   es          Pointer to the env_set to se=
t the options into</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void setenv_dns_optio=
ns(const struct dns_options *o, struct env_set *es);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/**</span><br><span>  * Prints configured DNS options.</span><br=
><span>  *</span><br><span>  * @param   o           Pointer to the DNS opti=
ons to print</span><br><span>diff --git a/src/openvpn/options.c b/src/openv=
pn/options.c</span><br><span>index 9c7a9ae..aa4ef27 100644</span><br><span>=
--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</sp=
an><br><span>@@ -1029,11 +1029,6 @@</span><br><span>     {</span><br><span>=
         setenv_connection_entry(es, &amp;o-&gt;ce, 1);</span><br><span>   =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt;pull)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        setenv_dns_options(&amp;o-&gt;dns_options, es);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>=
 }</span><br><span> </span><br><span> #ifndef _WIN32</span><br><span>@@ -13=
47,149 +1342,6 @@</span><br><span>         }</span><br><span>     }</span><=
br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">- * If DNS options are set use these for TUN/TAP op=
tions as well.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Appl=
ies to DNS, DNS6 and DOMAIN-SEARCH.</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * Existing options will be discarded.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-tuntap_options_copy_dns(struct options *o)</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    struct tuntap_options *tt =3D &amp;o-&gt;tuntap_options;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct dns_options *dns =3D=
 &amp;o-&gt;dns_options;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (dns-&gt;se=
arch_domains)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        tt-&gt;domain_se=
arch_list_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       const struct dns_domain *domain =3D dns-&gt;search_domains;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        while (domain &amp;&am=
p; tt-&gt;domain_search_list_len &lt; N_SEARCH_LIST_LEN)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            tt-&gt;domain_search_list[tt-&gt;domain_=
search_list_len++] =3D domain-&gt;name;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            domain =3D domain-&gt;next;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (domain)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            msg(M_WARN, &quot;WARNING: couldn&#39;t copy all --dn=
s search-domains to --dhcp-option&quot;);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        tt-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_REQUIRED;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (dns-&gt;servers)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      tt-&gt;dns_len =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        tt-&gt;dns6_len =3D 0;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        bool overflow =3D false;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        const struct dns_server *server =3D dns-&=
gt;servers;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        wh=
ile (server)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            for (int =
i =3D 0; i &lt; server-&gt;addr_count; ++i)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                if (server-&gt;addr[i].family =3D=3D AF_INET)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    if (t=
t-&gt;dns_len &gt;=3D N_DHCP_ADDR)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                        overflow =3D true;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                        continue;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    }</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                    tt-&gt;dn=
s[tt-&gt;dns_len++] =3D ntohl(server-&gt;addr[i].in.a4.s_addr);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                else</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                    if (tt-&gt;dns6_len &g=
t;=3D N_DHCP_ADDR)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
                     overflow =3D true;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                        continue;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    tt-&gt;dns6[tt-&gt;dns6=
_len++] =3D server-&gt;addr[i].in.a6;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            server =3D server-&gt;next;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (overflow)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          msg(M_WARN, &quot;WARNING: couldn&#39;t copy all --dns server add=
resses to --dhcp-option&quot;);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      tt-&gt;dhcp_options |=3D DHCP_OPTIONS_DHCP_OPTIONAL;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#else /* if defined(_WIN32) || defined(TARGET_ANDROID) */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-foreign_options_copy_dns(struct options *o, stru=
ct env_set *es)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    const struct dns_domai=
n *domain =3D o-&gt;dns_options.search_domains;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const struct dns_server *server =3D o-&gt;dns=
_options.servers;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
if (!domain &amp;&amp; !server)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* reset the index since we&#39;re starting a=
ll over again */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
nt opt_max =3D o-&gt;foreign_option_index;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    o-&gt;foreign_option_index =3D 0;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    for (int i =3D 1; i &lt;=3D opt_max; ++i)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        char name[32];</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        snprintf(name, sizeof(name), &quot;foreign=
_option_%d&quot;, i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        const char *e=
nv_str =3D env_set_get(es, name);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        const char *value =3D strchr(env_str, &#39;=3D&#39;) + =
1;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if ((domain=
 &amp;&amp; strstr(value, &quot;dhcp-option DOMAIN-SEARCH&quot;) =3D=3D val=
ue)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            || (se=
rver &amp;&amp; strstr(value, &quot;dhcp-option DNS&quot;) =3D=3D value))</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            setenv_del(es, name);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        else</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-            setenv_foreign_option(o, &amp;value, 1, es)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    while (server)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =
=3D 0; i &lt; server-&gt;addr_count; ++i)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            if (server-&gt;addr[i].family =3D=3D AF_INET)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                const char *argv[] =3D =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
&quot;dhcp-option&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                    &quot;DNS&quot;,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    print_in_addr_t(server-&gt;addr[i].in=
.a4.s_addr, 0, &amp;gc)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                };</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               setenv_foreign_option(o, argv, 3, es);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            else</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-                const char *argv[] =3D {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    &quot;dhcp-option&quot;=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
&quot;DNS6&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                print_in6_addr(server-&gt;addr[i].in.a6, 0, &amp;gc)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                };</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                setenv_foreign_=
option(o, argv, 3, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        server =3D=
 server-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (domain)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        const char *argv[] =3D { &quot;=
dhcp-option&quot;, &quot;DOMAIN-SEARCH&quot;, domain-&gt;name };</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        setenv_foreign_option(o,=
 argv, 3, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 domain =3D domain-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    gc_free(&amp;gc);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    /* remove old leftover entries */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    while (o-&gt;foreign_option_ind=
ex &lt; opt_max)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        char name[32]=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        snprintf(nam=
e, sizeof(name), &quot;foreign_option_%d&quot;, opt_max--);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        setenv_del(es, name);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span> #endif /* if defined(_WI=
N32) || defined(TARGET_ANDROID) */</span><br><span> </span><br><span> #ifnd=
ef ENABLE_SMALL</span><br><span>@@ -3796,14 +3648,6 @@</span><br><span>    =
 {</span><br><span>         dns_options_preprocess_pull(&amp;o-&gt;dns_opti=
ons);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32) ||=
 defined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        tuntap_options_copy_dns(o);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        foreign_options_copy_dns(o, es);</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span>     if (o-&gt;auth_token_generate &amp;&amp; !o=
-&gt;auth_token_renewal)</span><br><span>     {</span><br><span>         o-=
&gt;auth_token_renewal =3D o-&gt;renegotiate_seconds;</span><br><span>@@ -4=
174,7 +4018,6 @@</span><br><span> </span><br><span> /*</span><br><span>  * =
Sanity check on options after more options were pulled from server.</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * Also time to modify some o=
ptions based on other options.</span><br><span>  */</span><br><span> bool</=
span><br><span> options_postprocess_pull(struct options *o, struct env_set =
*es)</span><br><span>@@ -4183,12 +4026,30 @@</span><br><span>     if (succe=
ss)</span><br><span>     {</span><br><span>         dns_options_postprocess=
_pull(&amp;o-&gt;dns_options);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        setenv_dns_options(&amp;o-&gt;dns_options, es);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(=
_WIN32) || defined(TARGET_ANDROID)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        tuntap_options_copy_dns(o);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        foreign_options_copy_dns(o, es);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        /* If there&#39;s --dns servers, remove dns rela=
ted --dhcp-options */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        if (o-&gt;dns_options.servers)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            o-&gt;tuntap_options.dns_len =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;tuntap_options.dns=
6_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     o-&gt;tuntap_options.domain =3D NULL;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            o-&gt;tuntap_options.domain_search_list_=
len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Override=
 search domains with the ones from --dns */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        else if (o-&gt;dns_options.search_domains)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            int i =3D 0;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct dns_do=
main *domain =3D o-&gt;dns_options.search_domains;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            while (i &lt; N_SEARCH_LIST_LEN =
&amp;&amp; domain)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         o-&gt;tuntap_options.domain_search_list[i] =3D domain-&gt;name;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                domain=
 =3D domain-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                ++i;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         o-&gt;tuntap_options.domain_search_list_len =3D i;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif /* defined(_WIN32) || defined(TARGET_A=
NDROID) */</span><br><span>     }</span><br><span>     return success;</spa=
n><br><span> }</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/840?usp=3Demail">change 840</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/840?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3fb01ab76cf3df0874ba92e08f3=
71d17607a8369 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 840 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--F6Ieg5q9Gpo=--

