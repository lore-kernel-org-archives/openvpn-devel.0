From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Sep 2023 10:46:47 +0000
References: <gerrit.1677684971000.I7f422add22f3f01e9f47985065782dd67bca46eb@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9f260ea40477c10f6b9184163dcba573d7abdf34-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AfrG9EvXeac="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns option: remove
 support for exclude-domains
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>

--AfrG9EvXeac=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

d12fk has uploaded this change for review. ( http://gerrit.openvpn.net/c/op=
envpn/+/39?usp=3Demail )


Change subject: dns option: remove support for exclude-domains
......................................................................

dns option: remove support for exclude-domains

No DNS resolver currently supports this and it is not possible to
emulate the behavior without the chance of errors. Finding the
effective default system DNS server(s) to specify the exclude
DNS routes is not trivial and cannot be verified to be correct
without resolver internal knowledge. So, it is better to not
support this instead of supporting it, but incorrectly.

Change-Id: I7f422add22f3f01e9f47985065782dd67bca46eb
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M doc/man-sections/client-options.rst
M doc/man-sections/script-options.rst
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
5 files changed, 7 insertions(+), 45 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/39/6

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index fe9ffa6..4555534 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -169,7 +169,7 @@

      dns search-domains domain [domain ...]
      dns server n address addr[:port] [addr[:port] ...]
-     dns server n resolve-domains|exclude-domains domain [domain ...]
+     dns server n resolve-domains domain [domain ...]
      dns server n dnssec yes|optional|no
      dns server n transport DoH|DoT|plain
      dns server n sni server-name
@@ -191,14 +191,10 @@
   Optionally a port can be appended after a colon. IPv6 addresses need to
   be enclosed in brackets if a port is appended.

-  The ``resolve-domains`` and ``exclude-domains`` options take one or
-  more DNS domains which are explicitly resolved or explicitly not resolved
-  by a server. Only one of the options can be configured for a server.
-  ``resolve-domains`` is used to define a split-dns setup, where only
-  given domains are resolved by a server. ``exclude-domains`` is used to
-  define domains which will never be resolved by a server (e.g. domains
-  which can only be resolved locally). Systems which do not support fine
-  grained DNS domain configuration, will ignore these settings.
+  The ``resolve-domains`` option takes one or more DNS domains used to def=
ine
+  a split-dns or dns-routing setup, where only the given domains are resol=
ved
+  by the server. Systems which do not support fine grained DNS domain
+  configuration, will ignore this setting.

   The ``dnssec`` option is used to configure validation of DNSSEC records.
   While the exact semantics may differ for resolvers on different systems,
diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/script-=
options.rst
index d73231e..8c0be0c 100644
--- a/doc/man-sections/script-options.rst
+++ b/doc/man-sections/script-options.rst
@@ -663,7 +663,6 @@
        dns_server_{n}_address_{m}
        dns_server_{n}_port_{m}
        dns_server_{n}_resolve_domain_{m}
-       dns_server_{n}_exclude_domain_{m}
        dns_server_{n}_dnssec
        dns_server_{n}_transport
        dns_server_{n}_sni
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index b7808db..51fca2f 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -402,11 +402,9 @@

         if (s->domains)
         {
-            const char *format =3D s->domain_type =3D=3D DNS_RESOLVE_DOMAI=
NS ?
-                                 "dns_server_%d_resolve_domain_%d" : "dns_=
server_%d_exclude_domain_%d";
             for (j =3D 1, d =3D s->domains; d !=3D NULL; j++, d =3D d->nex=
t)
             {
-                setenv_dns_option(es, format, i, j, d->name);
+                setenv_dns_option(es, "dns_server_%d_resolve_domain_%d", i=
, j, d->name);
             }
         }

@@ -484,14 +482,7 @@
         struct dns_domain *domain =3D server->domains;
         if (domain)
         {
-            if (server->domain_type =3D=3D DNS_RESOLVE_DOMAINS)
-            {
-                msg(D_SHOW_PARMS, "    resolve domains:");
-            }
-            else
-            {
-                msg(D_SHOW_PARMS, "    exclude domains:");
-            }
+            msg(D_SHOW_PARMS, "    resolve domains:");
             while (domain)
             {
                 msg(D_SHOW_PARMS, "      %s", domain->name);
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index 162dec1..e497857 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -27,12 +27,6 @@
 #include "buffer.h"
 #include "env_set.h"

-enum dns_domain_type {
-    DNS_DOMAINS_UNSET,
-    DNS_RESOLVE_DOMAINS,
-    DNS_EXCLUDE_DOMAINS
-};
-
 enum dns_security {
     DNS_SECURITY_UNSET,
     DNS_SECURITY_NO,
@@ -68,7 +62,6 @@
     size_t addr_count;
     struct dns_server_addr addr[8];
     struct dns_domain *domains;
-    enum dns_domain_type domain_type;
     enum dns_security dnssec;
     enum dns_server_transport transport;
     const char *sni;
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 17ce2b0..3e0cb62 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -514,7 +514,6 @@
     "                  Valid options are :\n"
     "                  address <addr[:port]> [addr[:port] ...] : server ad=
dresses 4/6\n"
     "                  resolve-domains <domain> [domain ...] : split domai=
ns\n"
-    "                  exclude-domains <domain> [domain ...] : domains not=
 to resolve\n"
     "                  dnssec <yes|no|optional> : option to use DNSSEC\n"
     "                  type <DoH|DoT> : query server over HTTPS / TLS\n"
     "                  sni <domain> : DNS server name indication\n"
@@ -8022,22 +8021,6 @@
             }
             else if (streq(p[3], "resolve-domains"))
             {
-                if (server->domain_type =3D=3D DNS_EXCLUDE_DOMAINS)
-                {
-                    msg(msglevel, "--dns server %ld: cannot use resolve-do=
mains and exclude-domains", priority);
-                    goto err;
-                }
-                server->domain_type =3D DNS_RESOLVE_DOMAINS;
-                dns_domain_list_append(&server->domains, &p[4], &options->=
dns_options.gc);
-            }
-            else if (streq(p[3], "exclude-domains"))
-            {
-                if (server->domain_type =3D=3D DNS_RESOLVE_DOMAINS)
-                {
-                    msg(msglevel, "--dns server %ld: cannot use exclude-do=
mains and resolve-domains", priority);
-                    goto err;
-                }
-                server->domain_type =3D DNS_EXCLUDE_DOMAINS;
                 dns_domain_list_append(&server->domains, &p[4], &options->=
dns_options.gc);
             }
             else if (streq(p[3], "dnssec") && !p[5])

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/39?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7f422add22f3f01e9f47985065782dd67bca46eb
Gerrit-Change-Number: 39
Gerrit-PatchSet: 6
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--AfrG9EvXeac=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk has uploaded this change for <strong>review</strong>.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/39?usp=3Demail">View Change</a><=
/p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
dns option: remove support for exclude-domains<br><br>No DNS resolver curre=
ntly supports this and it is not possible to<br>emulate the behavior withou=
t the chance of errors. Finding the<br>effective default system DNS server(=
s) to specify the exclude<br>DNS routes is not trivial and cannot be verifi=
ed to be correct<br>without resolver internal knowledge. So, it is better t=
o not<br>support this instead of supporting it, but incorrectly.<br><br>Cha=
nge-Id: I7f422add22f3f01e9f47985065782dd67bca46eb<br>Signed-off-by: Heiko H=
und &lt;heiko@...2662...&gt;<br>---<br>M doc/man-sections/client-options.rs=
t<br>M doc/man-sections/script-options.rst<br>M src/openvpn/dns.c<br>M src/=
openvpn/dns.h<br>M src/openvpn/options.c<br>5 files changed, 7 insertions(+=
), 45 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvp=
n refs/changes/39/39/6</pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;"><span>diff --git a/doc/man-sections/client-options=
.rst b/doc/man-sections/client-options.rst</span><br><span>index fe9ffa6..4=
555534 100644</span><br><span>--- a/doc/man-sections/client-options.rst</sp=
an><br><span>+++ b/doc/man-sections/client-options.rst</span><br><span>@@ -=
169,7 +169,7 @@</span><br><span> </span><br><span>      dns search-domains =
domain [domain ...]</span><br><span>      dns server n address addr[:port] =
[addr[:port] ...]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
 dns server n resolve-domains|exclude-domains domain [domain ...]</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+     dns server n resolve-dom=
ains domain [domain ...]</span><br><span>      dns server n dnssec yes|opti=
onal|no</span><br><span>      dns server n transport DoH|DoT|plain</span><b=
r><span>      dns server n sni server-name</span><br><span>@@ -191,14 +191,=
10 @@</span><br><span>   Optionally a port can be appended after a colon. I=
Pv6 addresses need to</span><br><span>   be enclosed in brackets if a port =
is appended.</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  The ``resolve-domains`` and ``exclude-domains`` options take one=
 or</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  more DNS domains=
 which are explicitly resolved or explicitly not resolved</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-  by a server. Only one of the options =
can be configured for a server.</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-  ``resolve-domains`` is used to define a split-dns setup, where =
only</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  given domains a=
re resolved by a server. ``exclude-domains`` is used to</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-  define domains which will never be reso=
lved by a server (e.g. domains</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-  which can only be resolved locally). Systems which do not suppor=
t fine</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  grained DNS d=
omain configuration, will ignore these settings.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+  The ``resolve-domains`` option takes one or =
more DNS domains used to define</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+  a split-dns or dns-routing setup, where only the given domain=
s are resolved</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  by =
the server. Systems which do not support fine grained DNS domain</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+  configuration, will ignore t=
his setting.</span><br><span> </span><br><span>   The ``dnssec`` option is =
used to configure validation of DNSSEC records.</span><br><span>   While th=
e exact semantics may differ for resolvers on different systems,</span><br>=
<span>diff --git a/doc/man-sections/script-options.rst b/doc/man-sections/s=
cript-options.rst</span><br><span>index d73231e..8c0be0c 100644</span><br><=
span>--- a/doc/man-sections/script-options.rst</span><br><span>+++ b/doc/ma=
n-sections/script-options.rst</span><br><span>@@ -663,7 +663,6 @@</span><br=
><span>        dns_server_{n}_address_{m}</span><br><span>        dns_serve=
r_{n}_port_{m}</span><br><span>        dns_server_{n}_resolve_domain_{m}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-       dns_server_{n}_ex=
clude_domain_{m}</span><br><span>        dns_server_{n}_dnssec</span><br><s=
pan>        dns_server_{n}_transport</span><br><span>        dns_server_{n}=
_sni</span><br><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</sp=
an><br><span>index b7808db..51fca2f 100644</span><br><span>--- a/src/openvp=
n/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -402,11 =
+402,9 @@</span><br><span> </span><br><span>         if (s-&gt;domains)</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            const char *format =3D s-&gt;domain_type =3D=3D DNS_RESOLVE_D=
OMAINS ?</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
                    &quot;dns_server_%d_resolve_domain_%d&quot; : &quot;dns=
_server_%d_exclude_domain_%d&quot;;</span><br><span>             for (j =3D=
 1, d =3D s-&gt;domains; d !=3D NULL; j++, d =3D d-&gt;next)</span><br><spa=
n>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           setenv_dns_option(es, format, i, j, d-&gt;name);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                setenv_dns_option(e=
s, &quot;dns_server_%d_resolve_domain_%d&quot;, i, j, d-&gt;name);</span><b=
r><span>             }</span><br><span>         }</span><br><span> </span><=
br><span>@@ -484,14 +482,7 @@</span><br><span>         struct dns_domain *d=
omain =3D server-&gt;domains;</span><br><span>         if (domain)</span><b=
r><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
         if (server-&gt;domain_type =3D=3D DNS_RESOLVE_DOMAINS)</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                msg(D_SHOW_PARMS, &quot; =
   resolve domains:&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 msg(D_SHOW_PARMS, &quot;    exclude domains:&quot;);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            msg(D_SHOW_PARMS, &quot;    resolve d=
omains:&quot;);</span><br><span>             while (domain)</span><br><span=
>             {</span><br><span>                 msg(D_SHOW_PARMS, &quot;  =
    %s&quot;, domain-&gt;name);</span><br><span>diff --git a/src/openvpn/dn=
s.h b/src/openvpn/dns.h</span><br><span>index 162dec1..e497857 100644</span=
><br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h<=
/span><br><span>@@ -27,12 +27,6 @@</span><br><span> #include &quot;buffer.h=
&quot;</span><br><span> #include &quot;env_set.h&quot;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-enum dns_domain_type {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DNS_DOMAINS_UNSET,<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DNS_RESOLVE_DOMAIN=
S,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    DNS_EXCLUDE_DOM=
AINS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> enum dns_security =
{</span><br><span>     DNS_SECURITY_UNSET,</span><br><span>     DNS_SECURIT=
Y_NO,</span><br><span>@@ -68,7 +62,6 @@</span><br><span>     size_t addr_co=
unt;</span><br><span>     struct dns_server_addr addr[8];</span><br><span> =
    struct dns_domain *domains;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    enum dns_domain_type domain_type;</span><br><span>     enum d=
ns_security dnssec;</span><br><span>     enum dns_server_transport transpor=
t;</span><br><span>     const char *sni;</span><br><span>diff --git a/src/o=
penvpn/options.c b/src/openvpn/options.c</span><br><span>index 17ce2b0..3e0=
cb62 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++=
 b/src/openvpn/options.c</span><br><span>@@ -514,7 +514,6 @@</span><br><spa=
n>     &quot;                  Valid options are :\n&quot;</span><br><span>=
     &quot;                  address &lt;addr[:port]&gt; [addr[:port] ...] =
: server addresses 4/6\n&quot;</span><br><span>     &quot;                 =
 resolve-domains &lt;domain&gt; [domain ...] : split domains\n&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;                  =
exclude-domains &lt;domain&gt; [domain ...] : domains not to resolve\n&quot=
;</span><br><span>     &quot;                  dnssec &lt;yes|no|optional&g=
t; : option to use DNSSEC\n&quot;</span><br><span>     &quot;              =
    type &lt;DoH|DoT&gt; : query server over HTTPS / TLS\n&quot;</span><br>=
<span>     &quot;                  sni &lt;domain&gt; : DNS server name ind=
ication\n&quot;</span><br><span>@@ -8022,22 +8021,6 @@</span><br><span>    =
         }</span><br><span>             else if (streq(p[3], &quot;resolve-=
domains&quot;))</span><br><span>             {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                if (server-&gt;domain_type =3D=3D =
DNS_EXCLUDE_DOMAINS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
               msg(msglevel, &quot;--dns server %ld: cannot use resolve-dom=
ains and exclude-domains&quot;, priority);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                    goto err;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                server-&gt;domain_type =3D DNS_RES=
OLVE_DOMAINS;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        dns_domain_list_append(&amp;server-&gt;domains, &amp;p[4], &amp;opt=
ions-&gt;dns_options.gc);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        else if (streq(p[3], &quot;exclude-domains&quot;))</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                if (server-&gt;domain_type =3D=
=3D DNS_RESOLVE_DOMAINS)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-                {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                   msg(msglevel, &quot;--dns server %ld: cannot use exclude=
-domains and resolve-domains&quot;, priority);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                    goto err;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                server-&gt;domain_type =3D DNS=
_EXCLUDE_DOMAINS;</span><br><span>                 dns_domain_list_append(&=
amp;server-&gt;domains, &amp;p[4], &amp;options-&gt;dns_options.gc);</span>=
<br><span>             }</span><br><span>             else if (streq(p[3], =
&quot;dnssec&quot;) &amp;&amp; !p[5])</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/39?usp=3Dema=
il">change 39</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/39?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f422add22f3f01e9f479850657=
82dd67bca46eb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 39 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--AfrG9EvXeac=--

