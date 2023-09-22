From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 22 Sep 2023 13:36:41 +0000
In-Reply-To: <gerrit.1677684971000.I7f422add22f3f01e9f47985065782dd67bca46eb@...2715...>
References: <gerrit.1677684971000.I7f422add22f3f01e9f47985065782dd67bca46eb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <fc038c3a7435ada8ee948983712c33d739064a05-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="b7cq/Mif6Ng="; charset=UTF-8
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
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--b7cq/Mif6Ng=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/39?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


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
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20230922104334.37619-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
008.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M doc/man-sections/client-options.rst
M doc/man-sections/script-options.rst
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
5 files changed, 7 insertions(+), 45 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/39/7

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index fe9ffa6..3616ed7 100644
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
+  configuration will ignore this setting.

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
index 530e6d5..e073d0e 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -400,11 +400,9 @@

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

@@ -482,14 +480,7 @@
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
index ab59a41..c6f9ac3 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -512,7 +512,6 @@
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
Gerrit-PatchSet: 7
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--b7cq/Mif6Ng=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/39?u=
sp=3Demail">View Change</a></p><p>The following approvals got outdated and =
were removed:
Code-Review+2 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dns option: remove support for exclude-domains<br><b=
r>No DNS resolver currently supports this and it is not possible to<br>emul=
ate the behavior without the chance of errors. Finding the<br>effective def=
ault system DNS server(s) to specify the exclude<br>DNS routes is not trivi=
al and cannot be verified to be correct<br>without resolver internal knowle=
dge. So, it is better to not<br>support this instead of supporting it, but =
incorrectly.<br><br>Change-Id: I7f422add22f3f01e9f47985065782dd67bca46eb<br=
>Signed-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Lev Stipak=
ov &lt;lstipakov@...277...&gt;<br>Message-Id: &lt;20230922104334.37619-1-fr=
ank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1697...=
.sourceforge.net/msg27008.html<br>Signed-off-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>---<br>M doc/man-sections/client-options.rst<br>M doc/man-sec=
tions/script-options.rst<br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M=
 src/openvpn/options.c<br>5 files changed, 7 insertions(+), 45 deletions(-)=
<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/=
39/7</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/doc/man-sections/client-options.rst b/doc/man-sec=
tions/client-options.rst</span><br><span>index fe9ffa6..3616ed7 100644</spa=
n><br><span>--- a/doc/man-sections/client-options.rst</span><br><span>+++ b=
/doc/man-sections/client-options.rst</span><br><span>@@ -169,7 +169,7 @@</s=
pan><br><span> </span><br><span>      dns search-domains domain [domain ...=
]</span><br><span>      dns server n address addr[:port] [addr[:port] ...]<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-     dns server n reso=
lve-domains|exclude-domains domain [domain ...]</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     dns server n resolve-domains domain [domai=
n ...]</span><br><span>      dns server n dnssec yes|optional|no</span><br>=
<span>      dns server n transport DoH|DoT|plain</span><br><span>      dns =
server n sni server-name</span><br><span>@@ -191,14 +191,10 @@</span><br><s=
pan>   Optionally a port can be appended after a colon. IPv6 addresses need=
 to</span><br><span>   be enclosed in brackets if a port is appended.</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  The ``r=
esolve-domains`` and ``exclude-domains`` options take one or</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-  more DNS domains which are explici=
tly resolved or explicitly not resolved</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-  by a server. Only one of the options can be configured =
for a server.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  ``reso=
lve-domains`` is used to define a split-dns setup, where only</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-  given domains are resolved by a s=
erver. ``exclude-domains`` is used to</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-  define domains which will never be resolved by a server (=
e.g. domains</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  which c=
an only be resolved locally). Systems which do not support fine</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-  grained DNS domain configuratio=
n, will ignore these settings.</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+  The ``resolve-domains`` option takes one or more DNS domains u=
sed to define</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  a sp=
lit-dns or dns-routing setup, where only the given domains are resolved</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+  by the server. System=
s which do not support fine grained DNS domain</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+  configuration will ignore this setting.</span>=
<br><span> </span><br><span>   The ``dnssec`` option is used to configure v=
alidation of DNSSEC records.</span><br><span>   While the exact semantics m=
ay differ for resolvers on different systems,</span><br><span>diff --git a/=
doc/man-sections/script-options.rst b/doc/man-sections/script-options.rst</=
span><br><span>index d73231e..8c0be0c 100644</span><br><span>--- a/doc/man-=
sections/script-options.rst</span><br><span>+++ b/doc/man-sections/script-o=
ptions.rst</span><br><span>@@ -663,7 +663,6 @@</span><br><span>        dns_=
server_{n}_address_{m}</span><br><span>        dns_server_{n}_port_{m}</spa=
n><br><span>        dns_server_{n}_resolve_domain_{m}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-       dns_server_{n}_exclude_domain_{m}</s=
pan><br><span>        dns_server_{n}_dnssec</span><br><span>        dns_ser=
ver_{n}_transport</span><br><span>        dns_server_{n}_sni</span><br><spa=
n>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index =
530e6d5..e073d0e 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><=
span>+++ b/src/openvpn/dns.c</span><br><span>@@ -400,11 +400,9 @@</span><br=
><span> </span><br><span>         if (s-&gt;domains)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            const=
 char *format =3D s-&gt;domain_type =3D=3D DNS_RESOLVE_DOMAINS ?</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                                =
 &quot;dns_server_%d_resolve_domain_%d&quot; : &quot;dns_server_%d_exclude_=
domain_%d&quot;;</span><br><span>             for (j =3D 1, d =3D s-&gt;dom=
ains; d !=3D NULL; j++, d =3D d-&gt;next)</span><br><span>             {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                setenv_d=
ns_option(es, format, i, j, d-&gt;name);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                setenv_dns_option(es, &quot;dns_server=
_%d_resolve_domain_%d&quot;, i, j, d-&gt;name);</span><br><span>           =
  }</span><br><span>         }</span><br><span> </span><br><span>@@ -482,14=
 +480,7 @@</span><br><span>         struct dns_domain *domain =3D server-&g=
t;domains;</span><br><span>         if (domain)</span><br><span>         {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (server=
-&gt;domain_type =3D=3D DNS_RESOLVE_DOMAINS)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                msg(D_SHOW_PARMS, &quot;    resolve domains:=
&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                msg(D_SHOW_PARMS, =
&quot;    exclude domains:&quot;);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            msg(D_SHOW_PARMS, &quot;    resolve domains:&quot;);</sp=
an><br><span>             while (domain)</span><br><span>             {</sp=
an><br><span>                 msg(D_SHOW_PARMS, &quot;      %s&quot;, domai=
n-&gt;name);</span><br><span>diff --git a/src/openvpn/dns.h b/src/openvpn/d=
ns.h</span><br><span>index 162dec1..e497857 100644</span><br><span>--- a/sr=
c/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</span><br><span>@@ =
-27,12 +27,6 @@</span><br><span> #include &quot;buffer.h&quot;</span><br><s=
pan> #include &quot;env_set.h&quot;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-enum dns_domain_type {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    DNS_DOMAINS_UNSET,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    DNS_RESOLVE_DOMAINS,</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    DNS_EXCLUDE_DOMAINS</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> enum dns_security {</span><br><span> =
    DNS_SECURITY_UNSET,</span><br><span>     DNS_SECURITY_NO,</span><br><sp=
an>@@ -68,7 +62,6 @@</span><br><span>     size_t addr_count;</span><br><spa=
n>     struct dns_server_addr addr[8];</span><br><span>     struct dns_doma=
in *domains;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    enum =
dns_domain_type domain_type;</span><br><span>     enum dns_security dnssec;=
</span><br><span>     enum dns_server_transport transport;</span><br><span>=
     const char *sni;</span><br><span>diff --git a/src/openvpn/options.c b/=
src/openvpn/options.c</span><br><span>index ab59a41..c6f9ac3 100644</span><=
br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/opti=
ons.c</span><br><span>@@ -512,7 +512,6 @@</span><br><span>     &quot;      =
            Valid options are :\n&quot;</span><br><span>     &quot;        =
          address &lt;addr[:port]&gt; [addr[:port] ...] : server addresses =
4/6\n&quot;</span><br><span>     &quot;                  resolve-domains &l=
t;domain&gt; [domain ...] : split domains\n&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    &quot;                  exclude-domains &lt=
;domain&gt; [domain ...] : domains not to resolve\n&quot;</span><br><span> =
    &quot;                  dnssec &lt;yes|no|optional&gt; : option to use =
DNSSEC\n&quot;</span><br><span>     &quot;                  type &lt;DoH|Do=
T&gt; : query server over HTTPS / TLS\n&quot;</span><br><span>     &quot;  =
                sni &lt;domain&gt; : DNS server name indication\n&quot;</sp=
an><br><span>@@ -8022,22 +8021,6 @@</span><br><span>             }</span><b=
r><span>             else if (streq(p[3], &quot;resolve-domains&quot;))</sp=
an><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                if (server-&gt;domain_type =3D=3D DNS_EXCLUDE_DOMAINS=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                    msg(=
msglevel, &quot;--dns server %ld: cannot use resolve-domains and exclude-do=
mains&quot;, priority);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                    goto err;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                server-&gt;domain_type =3D DNS_RESOLVE_DOMAINS;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                dns_domain_=
list_append(&amp;server-&gt;domains, &amp;p[4], &amp;options-&gt;dns_option=
s.gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            else if (st=
req(p[3], &quot;exclude-domains&quot;))</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                if (server-&gt;domain_type =3D=3D DNS_RESOLVE_DOM=
AINS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    =
msg(msglevel, &quot;--dns server %ld: cannot use exclude-domains and resolv=
e-domains&quot;, priority);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                    goto err;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                server-&gt;domain_type =3D DNS_EXCLUDE_DOMAINS;</=
span><br><span>                 dns_domain_list_append(&amp;server-&gt;doma=
ins, &amp;p[4], &amp;options-&gt;dns_options.gc);</span><br><span>         =
    }</span><br><span>             else if (streq(p[3], &quot;dnssec&quot;)=
 &amp;&amp; !p[5])</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/39?usp=3Demail">change 39</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/39?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7f422add22f3f01e9f479850657=
82dd67bca46eb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 39 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--b7cq/Mif6Ng=--

