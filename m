From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 18 Mar 2025 02:54:13 +0000
In-Reply-To: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
References: <gerrit.1741299308000.I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7596311e6d58826548bc9f6339f0b771ad74e665-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0zrfQulgEds="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns: clean up
 --dhcp-options when --dns is active
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

--0zrfQulgEds=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail

to look at the new patch set (#5).


Change subject: dns: clean up --dhcp-options when --dns is active
......................................................................

dns: clean up --dhcp-options when --dns is active

Since --dns settings overrule DNS related --dhcp-options,
remove the latter when we got some via --dns.

To stay as backward compatible as possible, the --dns server addresses
and search domains are added as foreign_options env vars, so that an
existing --up script can use them to set up DNS as before, without the
immediate need to change after an openvpn upgrade.

In case an --up script is defined, the --dns-script is not run to
prevent potential double DNS configuration.

Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/dns.c
M src/openvpn/options.c
2 files changed, 152 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/04/904/5

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 6ddf5c2..147509a 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -703,7 +703,7 @@
 static void
 run_up_down_script(bool up, struct options *o, const struct tuntap *tt, st=
ruct dns_script_runner_info *script_runner)
 {
-    if (!o->dns_options.script)
+    if (!o->dns_options.script || o->up_script)
     {
         return;
     }
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4c331dc..e94af84 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -4163,6 +4163,157 @@
     if (success)
     {
         dns_options_postprocess_pull(&o->dns_options);
+        if (!o->dns_options.servers)
+        {
+            return true;
+        }
+
+#if defined(_WIN32) || defined(TARGET_ANDROID)
+        /* Remove DNS related --dhcp-options */
+        struct tuntap_options *tt =3D &o->tuntap_options;
+        tt->dns_len =3D 0;
+        tt->dns6_len =3D 0;
+        tt->domain =3D NULL;
+        tt->domain_search_list_len =3D 0;
+
+        /* Set options from --dns config */
+        const struct dns_domain *d =3D o->dns_options.search_domains;
+        while (d && tt->domain_search_list_len + 1 < N_SEARCH_LIST_LEN)
+        {
+            tt->domain_search_list[tt->domain_search_list_len++] =3D d->na=
me;
+            d =3D d->next;
+        }
+
+        const struct dns_server *s =3D o->dns_options.servers;
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
+                    if (s->addr[i].family =3D=3D AF_INET && tt->dns_len + =
1 < N_DHCP_ADDR)
+                    {
+                        tt->dns[tt->dns_len++] =3D s->addr[i].in.a4.s_addr;
+                    }
+                    else if (tt->dns6_len + 1 < N_DHCP_ADDR)
+                    {
+                        tt->dns6[tt->dns6_len] =3D s->addr[i].in.a6;
+                    }
+                }
+                break;
+            }
+        }
+#else  /* if defined(_WIN32) || defined(TARGET_ANDROID) */
+
+        /* Clean up env from --dhcp-option DNS config */
+        struct gc_arena gc =3D gc_new();
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
+
+        /* Set foreign option env vars from --dns config */
+        if (!o->up_script)
+        {
+            /* No need to, when there is no --up script */
+            return true;
+        }
+        const char *p[] =3D { "dhcp-option", NULL, NULL };
+        size_t p_len =3D sizeof(p) / sizeof(p[0]);
+
+        p[1] =3D "DOMAIN";
+        const struct dns_domain *d =3D o->dns_options.search_domains;
+        while (d)
+        {
+            p[2] =3D d->name;
+            setenv_foreign_option(o, (const char **)p, p_len, es);
+            d =3D d->next;
+        }
+
+        const struct dns_server *s =3D o->dns_options.servers;
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
+        gc_free(&gc);
+#endif /* defined(_WIN32) || defined(TARGET_ANDROID) */
     }
     return success;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb2e9cb2570cd6a
Gerrit-Change-Number: 904
Gerrit-PatchSet: 5
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--0zrfQulgEds=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p>d12fk <strong>uploaded patch set #5</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail">View Change</a=
></p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
">dns: clean up --dhcp-options when --dns is active<br><br>Since --dns sett=
ings overrule DNS related --dhcp-options,<br>remove the latter when we got =
some via --dns.<br><br>To stay as backward compatible as possible, the --dn=
s server addresses<br>and search domains are added as foreign_options env v=
ars, so that an<br>existing --up script can use them to set up DNS as befor=
e, without the<br>immediate need to change after an openvpn upgrade.<br><br=
>In case an --up script is defined, the --dns-script is not run to<br>preve=
nt potential double DNS configuration.<br><br>Change-Id: I635c4018fb43b5976=
a39b6a90cb2e9cb2570cd6a<br>Signed-off-by: Heiko Hund &lt;heiko@...2662...&g=
t;<br>---<br>M src/openvpn/dns.c<br>M src/openvpn/options.c<br>2 files chan=
ged, 152 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-famil=
y: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openv=
pn.net:29418/openvpn refs/changes/04/904/5</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/dns.c b/src/openvpn/dns.c</span><br><span>index 6ddf5c2..147509a 100644</s=
pan><br><span>--- a/src/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns=
.c</span><br><span>@@ -703,7 +703,7 @@</span><br><span> static void</span><=
br><span> run_up_down_script(bool up, struct options *o, const struct tunta=
p *tt, struct dns_script_runner_info *script_runner)</span><br><span> {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!o-&gt;dns_option=
s.script)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!o=
-&gt;dns_options.script || o-&gt;up_script)</span><br><span>     {</span><b=
r><span>         return;</span><br><span>     }</span><br><span>diff --git =
a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 4c331=
dc..e94af84 100644</span><br><span>--- a/src/openvpn/options.c</span><br><s=
pan>+++ b/src/openvpn/options.c</span><br><span>@@ -4163,6 +4163,157 @@</sp=
an><br><span>     if (success)</span><br><span>     {</span><br><span>     =
    dns_options_postprocess_pull(&amp;o-&gt;dns_options);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if (!o-&gt;dns_options.server=
s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return true;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#if defined(_WIN32) || defined(TARGET_ANDROID)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Remove DNS re=
lated --dhcp-options */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        struct tuntap_options *tt =3D &amp;o-&gt;tuntap_options;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;dns_len =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        tt-&gt;d=
ns6_len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   tt-&gt;domain =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        tt-&gt;domain_search_list_len =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        /* Set options from --dns config */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        const struct dns_domain *d =
=3D o-&gt;dns_options.search_domains;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        while (d &amp;&amp; tt-&gt;domain_search_list_len=
 + 1 &lt; N_SEARCH_LIST_LEN)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           tt-&gt;domain_search_list[tt-&gt;domain_search_list_len++] =3D d=
-&gt;name;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   d =3D d-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const struct dns_ser=
ver *s =3D o-&gt;dns_options.servers;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        while (s)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            bool non_standard_server_port =3D false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            for (int i =3D 0; i &lt;=
 s-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              if (s-&gt;addr[i].port &amp;&amp; s-&gt;addr[i].port !=3D 53)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    n=
on_standard_server_port =3D true;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    break;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            if ((s-&gt;transport &amp;&amp; s-&gt;transport !=
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
=3D=3D AF_INET &amp;&amp; tt-&gt;dns_len + 1 &lt; N_DHCP_ADDR)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                        tt-&gt=
;dns[tt-&gt;dns_len++] =3D s-&gt;addr[i].in.a4.s_addr;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    else if (tt-&gt;dn=
s6_len + 1 &lt; N_DHCP_ADDR)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        tt-&gt;dns6[tt-&gt;dns6_len] =3D s-&gt;a=
ddr[i].in.a6;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* if define=
d(_WIN32) || defined(TARGET_ANDROID) */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        /* Clean up env from --dhcp-option DNS config */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        struct gc_arena gc =3D gc_new=
();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct b=
uffer name =3D alloc_buf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct buffer value =3D alloc_b=
uf_gc(OPTION_PARM_SIZE, &amp;gc);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   const int fo_count =3D o-&gt;foreign_option_index;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        o-&gt;foreign_option_index =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 1; i &lt;=3D fo=
_count; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf_c=
lear(&amp;name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         buf_printf(&amp;name, &quot;foreign_option_%d&quot;, i);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            const char *env_s=
tr =3D env_set_get(es, BSTR(&amp;name));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            const char *item_val =3D strchr(env_str, &=
#39;=3D&#39;) + 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           buf_clear(&amp;value);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            buf_printf(&amp;value, &quot;%s&quot;, item_val);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            /* Remove foreign option i=
tem from env set */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            env_set_del(es, BSTR(&amp;name));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            item_val =3D BSTR(&amp;value);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            if (strncmp(item_val, &quot;dhcp-=
option &quot;, 12) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                || (strncmp(item_val + 12, &quot;ADAPTER-DOMAIN-SUFFI=
X &quot;, 22) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    &amp;&amp; strncmp(item_val + 12, &quot;DOMAIN-SEARCH =
&quot;, 14) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   &amp;&amp; strncmp(item_val + 12, &quot;DOMAIN &quot;, 7=
) !=3D 0</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         &amp;&amp; strncmp(item_val + 12, &quot;DNS6 &quot;, 5) !=3D 0</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &am=
p;&amp; strncmp(item_val + 12, &quot;DNS &quot;, 4) !=3D 0))</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                /* Re-set the item with =
potentially updated name */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                buf_clear(&amp;name);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                buf_printf(&amp;name, &quot;forei=
gn_option_%d&quot;, ++o-&gt;foreign_option_index);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                setenv_str(es, BSTR(&amp;nam=
e), BSTR(&amp;value));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        /* Set foreign option en=
v vars from --dns config */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (!o-&gt;up_script)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            /* No need to, when there is no --up script */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            return true;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        const char *p[] =3D { &qu=
ot;dhcp-option&quot;, NULL, NULL };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        size_t p_len =3D sizeof(p) / sizeof(p[0]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        p[1] =3D &quot;DOMAIN&quot;;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        const struct dns_domai=
n *d =3D o-&gt;dns_options.search_domains;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        while (d)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            p[2] =3D d-&gt;name;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            setenv_foreign_option(o, (const char **=
)p, p_len, es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        d =3D d-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        const struct dn=
s_server *s =3D o-&gt;dns_options.servers;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        while (s)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            bool non_standard_server_port =3D false;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            for (int i =3D 0; i=
 &lt; s-&gt;addr_count; ++i)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                if (s-&gt;addr[i].port &amp;&amp; s-&gt;addr[i].port !=
=3D 53)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
      non_standard_server_port =3D true;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    break;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            if ((s-&gt;transport &amp;&amp; s-&gt;trans=
port !=3D DNS_TRANSPORT_PLAIN)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                || (s-&gt;dnssec &amp;&amp; s-&gt;dnssec !=3D DN=
S_SECURITY_NO)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           || non_standard_server_port)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                /* Skip servers requiring unsupported config =
to be set */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         s =3D s-&gt;next;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        for (int i =3D 0; i &lt; s-&gt;addr_count; ++i)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    if (s-&gt;addr[i].fam=
ily =3D=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        p[1] =3D &quot;DNS&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        p[2] =3D print_in=
_addr_t(s-&gt;addr[i].in.a4.s_addr, IA_NET_ORDER, &amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    else</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                        p[=
1] =3D &quot;DNS6&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        p[2] =3D print_in6_addr(s-&gt;addr[i].in.a6, 0=
, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              setenv_foreign_option(o, (const char **)p, p_len, es);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                break;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        gc_free(&amp;gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif /* defined(_WIN32) || define=
d(TARGET_ANDROID) */</span><br><span>     }</span><br><span>     return suc=
cess;</span><br><span> }</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail">change 9=
04</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/904?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I635c4018fb43b5976a39b6a90cb=
2e9cb2570cd6a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 904 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--0zrfQulgEds=--

