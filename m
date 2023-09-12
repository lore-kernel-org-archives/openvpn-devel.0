From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Sep 2023 10:47:12 +0000
References: <gerrit.1677715752000.I1f97d8e5ae8f049d72db5c12ce627f601d87505c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <769d164ba2866f9cd007ee3a62f801f5df6f9961-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1ooo72WNKuM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dns option: make
 server id/priority optional
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>

--1ooo72WNKuM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

d12fk has uploaded this change for review. ( http://gerrit.openvpn.net/c/op=
envpn/+/40?usp=3Demail )


Change subject: dns option: make server id/priority optional
......................................................................

dns option: make server id/priority optional

With the discovery that most of the time only one DNS server's settings
can be applied on various systems, the priority value will likely serve
no purpose most of the time.

This is to make it optional to give a --dns server priority, for cases
where you only specify one DNS server anyway. We keep the priority
because it still serves the case where you want to override pushed
server settings with local ones and when you run backends which do
support multiple server's settings like dnsmasq(8).

Change-Id: I1f97d8e5ae8f049d72db5c12ce627f601d87505c
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M doc/man-sections/client-options.rst
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
4 files changed, 37 insertions(+), 28 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/40/40/5

diff --git a/doc/man-sections/client-options.rst b/doc/man-sections/client-=
options.rst
index 4555534..df8ac43 100644
--- a/doc/man-sections/client-options.rst
+++ b/doc/man-sections/client-options.rst
@@ -168,11 +168,11 @@
   ::

      dns search-domains domain [domain ...]
-     dns server n address addr[:port] [addr[:port] ...]
-     dns server n resolve-domains domain [domain ...]
-     dns server n dnssec yes|optional|no
-     dns server n transport DoH|DoT|plain
-     dns server n sni server-name
+     dns server [n] address addr[:port] [addr[:port] ...]
+     dns server [n] resolve-domains domain [domain ...]
+     dns server [n] dnssec yes|optional|no
+     dns server [n] transport DoH|DoT|plain
+     dns server [n] sni server-name

   The ``--dns search-domains`` directive takes one or more domain names
   to be added as DNS domain suffixes. If it is repeated multiple times wit=
hin
@@ -180,6 +180,7 @@
   a server will amend locally defined ones.

   The ``--dns server`` directive is used to configure DNS server ``n``.
+  If the ``n`` parameter is omitted the directive configures DNS server ``=
0``.
   The server id ``n`` must be a value between -128 and 127. For pushed
   DNS server options it must be between 0 and 127. The server id is used
   to group options and also for ordering the list of configured DNS server=
s;
diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 51fca2f..5f5e06b 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -159,13 +159,18 @@
 }

 bool
-dns_server_priority_parse(long *priority, const char *str, bool pulled)
+dns_server_priority_parse(long *priority, size_t *subidx, const char *str,=
 bool pulled)
 {
     char *endptr;
     const long min =3D pulled ? 0 : INT8_MIN;
     const long max =3D INT8_MAX;
     long prio =3D strtol(str, &endptr, 10);
-    if (*endptr !=3D '\0' || prio < min || prio > max)
+    if (endptr =3D=3D str)
+    {
+        /* No priority found, str isn't numeric */
+        *subidx -=3D 1;
+    }
+    else if (*endptr !=3D '\0' || prio < min || prio > max)
     {
         return false;
     }
diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index e497857..d0258f7 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -78,11 +78,13 @@
  * Parses a string DNS server priority and validates it.
  *
  * @param   priority    Pointer to where the priority should be stored
+ * @param   subidx      Pointer to the sub-option index, decremented if no
+ *                      priority value could be found
  * @param   str         Priority string to parse
  * @param   pulled      Whether this was pulled from a server
  * @return              True if priority in string is valid
  */
-bool dns_server_priority_parse(long *priority, const char *str, bool pulle=
d);
+bool dns_server_priority_parse(long *priority, size_t *subidx, const char =
*str, bool pulled);

 /**
  * Find or create DNS server with priority in a linked list.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 3e0cb62..ea69ea7 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -510,7 +510,7 @@
     "                  ignore or reject causes the option to be allowed, r=
emoved or\n"
     "                  rejected with error. May be specified multiple time=
s, and\n"
     "                  each filter is applied in the order of appearance.\=
n"
-    "--dns server <n> <option> <value> [value ...] : Configure option for =
DNS server #n\n"
+    "--dns server [n] <option> <value> [value ...] : Configure option for =
DNS server #n\n"
     "                  Valid options are :\n"
     "                  address <addr[:port]> [addr[:port] ...] : server ad=
dresses 4/6\n"
     "                  resolve-domains <domain> [domain ...] : split domai=
ns\n"
@@ -7997,10 +7997,11 @@
         {
             dns_domain_list_append(&options->dns_options.search_domains, &=
p[2], &options->dns_options.gc);
         }
-        else if (streq(p[1], "server") && p[2] && p[3] && p[4])
+        else if (streq(p[1], "server") && p[2] && p[3])
         {
             long priority;
-            if (!dns_server_priority_parse(&priority, p[2], pull_mode))
+            size_t subcmd =3D 3; /* one after priority, if a priority was =
given */
+            if (!dns_server_priority_parse(&priority, &subcmd, p[2], pull_=
mode))
             {
                 msg(msglevel, "--dns server: invalid priority value '%s'",=
 p[2]);
                 goto err;
@@ -8008,9 +8009,9 @@

             struct dns_server *server =3D dns_server_get(&options->dns_opt=
ions.servers, priority, &options->dns_options.gc);

-            if (streq(p[3], "address") && p[4])
+            if (streq(p[subcmd], "address") && p[subcmd + 1])
             {
-                for (int i =3D 4; p[i]; ++i)
+                for (int i =3D subcmd + 1; p[i]; ++i)
                 {
                     if (!dns_server_addr_parse(server, p[i]))
                     {
@@ -8019,57 +8020,57 @@
                     }
                 }
             }
-            else if (streq(p[3], "resolve-domains"))
+            else if (streq(p[subcmd], "resolve-domains") && p[subcmd + 1])
             {
-                dns_domain_list_append(&server->domains, &p[4], &options->=
dns_options.gc);
+                dns_domain_list_append(&server->domains, &p[subcmd + 1], &=
options->dns_options.gc);
             }
-            else if (streq(p[3], "dnssec") && !p[5])
+            else if (streq(p[subcmd], "dnssec") && p[subcmd + 1] && !p[sub=
cmd + 2])
             {
-                if (streq(p[4], "yes"))
+                if (streq(p[subcmd + 1], "yes"))
                 {
                     server->dnssec =3D DNS_SECURITY_YES;
                 }
-                else if (streq(p[4], "no"))
+                else if (streq(p[subcmd + 1], "no"))
                 {
                     server->dnssec =3D DNS_SECURITY_NO;
                 }
-                else if (streq(p[4], "optional"))
+                else if (streq(p[subcmd + 1], "optional"))
                 {
                     server->dnssec =3D DNS_SECURITY_OPTIONAL;
                 }
                 else
                 {
-                    msg(msglevel, "--dns server %ld: malformed dnssec valu=
e '%s'", priority, p[4]);
+                    msg(msglevel, "--dns server %ld: malformed dnssec valu=
e '%s'", priority, p[subcmd + 1]);
                     goto err;
                 }
             }
-            else if (streq(p[3], "transport") && !p[5])
+            else if (streq(p[subcmd], "transport") && p[subcmd + 1] && !p[=
subcmd + 2])
             {
-                if (streq(p[4], "plain"))
+                if (streq(p[subcmd + 1], "plain"))
                 {
                     server->transport =3D DNS_TRANSPORT_PLAIN;
                 }
-                else if (streq(p[4], "DoH"))
+                else if (streq(p[subcmd + 1], "DoH"))
                 {
                     server->transport =3D DNS_TRANSPORT_HTTPS;
                 }
-                else if (streq(p[4], "DoT"))
+                else if (streq(p[subcmd + 1], "DoT"))
                 {
                     server->transport =3D DNS_TRANSPORT_TLS;
                 }
                 else
                 {
-                    msg(msglevel, "--dns server %ld: malformed transport v=
alue '%s'", priority, p[4]);
+                    msg(msglevel, "--dns server %ld: malformed transport v=
alue '%s'", priority, p[subcmd + 1]);
                     goto err;
                 }
             }
-            else if (streq(p[3], "sni") && !p[5])
+            else if (streq(p[subcmd], "sni") && p[subcmd + 1] && !p[subcmd=
 + 2])
             {
-                server->sni =3D p[4];
+                server->sni =3D p[subcmd + 1];
             }
             else
             {
-                msg(msglevel, "--dns server %ld: unknown option type '%s' =
or missing or unknown parameter", priority, p[3]);
+                msg(msglevel, "--dns server %ld: unknown option type '%s' =
or missing or unknown parameter", priority, p[subcmd]);
                 goto err;
             }
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/40?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1f97d8e5ae8f049d72db5c12ce627f601d87505c
Gerrit-Change-Number: 40
Gerrit-PatchSet: 5
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--1ooo72WNKuM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk has uploaded this change for <strong>review</strong>.</p><p><a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/40?usp=3Demail">View Change</a><=
/p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
dns option: make server id/priority optional<br><br>With the discovery that=
 most of the time only one DNS server&#39;s settings<br>can be applied on v=
arious systems, the priority value will likely serve<br>no purpose most of =
the time.<br><br>This is to make it optional to give a --dns server priorit=
y, for cases<br>where you only specify one DNS server anyway. We keep the p=
riority<br>because it still serves the case where you want to override push=
ed<br>server settings with local ones and when you run backends which do<br=
>support multiple server&#39;s settings like dnsmasq(8).<br><br>Change-Id: =
I1f97d8e5ae8f049d72db5c12ce627f601d87505c<br>Signed-off-by: Heiko Hund &lt;=
heiko@...2662...&gt;<br>---<br>M doc/man-sections/client-options.rst<br>M s=
rc/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvpn/options.c<br>4 fil=
es changed, 37 insertions(+), 28 deletions(-)<br><br></pre><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/40/40/5</pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/doc/=
man-sections/client-options.rst b/doc/man-sections/client-options.rst</span=
><br><span>index 4555534..df8ac43 100644</span><br><span>--- a/doc/man-sect=
ions/client-options.rst</span><br><span>+++ b/doc/man-sections/client-optio=
ns.rst</span><br><span>@@ -168,11 +168,11 @@</span><br><span>   ::</span><b=
r><span> </span><br><span>      dns search-domains domain [domain ...]</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-     dns server n address =
addr[:port] [addr[:port] ...]</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-     dns server n resolve-domains domain [domain ...]</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-     dns server n dnssec yes|option=
al|no</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     dns server =
n transport DoH|DoT|plain</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-     dns server n sni server-name</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+     dns server [n] address addr[:port] [addr[:port] ...]=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     dns server [n]=
 resolve-domains domain [domain ...]</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+     dns server [n] dnssec yes|optional|no</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     dns server [n] transport DoH|D=
oT|plain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     dns se=
rver [n] sni server-name</span><br><span> </span><br><span>   The ``--dns s=
earch-domains`` directive takes one or more domain names</span><br><span>  =
 to be added as DNS domain suffixes. If it is repeated multiple times withi=
n</span><br><span>@@ -180,6 +180,7 @@</span><br><span>   a server will amen=
d locally defined ones.</span><br><span> </span><br><span>   The ``--dns se=
rver`` directive is used to configure DNS server ``n``.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+  If the ``n`` parameter is omitted the=
 directive configures DNS server ``0``.</span><br><span>   The server id ``=
n`` must be a value between -128 and 127. For pushed</span><br><span>   DNS=
 server options it must be between 0 and 127. The server id is used</span><=
br><span>   to group options and also for ordering the list of configured D=
NS servers;</span><br><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dn=
s.c</span><br><span>index 51fca2f..5f5e06b 100644</span><br><span>--- a/src=
/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -=
159,13 +159,18 @@</span><br><span> }</span><br><span> </span><br><span> boo=
l</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dns_server_priority_=
parse(long *priority, const char *str, bool pulled)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+dns_server_priority_parse(long *priority,=
 size_t *subidx, const char *str, bool pulled)</span><br><span> {</span><br=
><span>     char *endptr;</span><br><span>     const long min =3D pulled ? =
0 : INT8_MIN;</span><br><span>     const long max =3D INT8_MAX;</span><br><=
span>     long prio =3D strtol(str, &amp;endptr, 10);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (*endptr !=3D &#39;\0&#39; || prio &=
lt; min || prio &gt; max)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (endptr =3D=3D str)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       /* No priority found, str isn&#39;t numeric */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        *subidx -=3D 1;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    else if (*endptr !=3D &#39;\0&#39; || prio &lt;=
 min || prio &gt; max)</span><br><span>     {</span><br><span>         retu=
rn false;</span><br><span>     }</span><br><span>diff --git a/src/openvpn/d=
ns.h b/src/openvpn/dns.h</span><br><span>index e497857..d0258f7 100644</spa=
n><br><span>--- a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h=
</span><br><span>@@ -78,11 +78,13 @@</span><br><span>  * Parses a string DN=
S server priority and validates it.</span><br><span>  *</span><br><span>  *=
 @param   priority    Pointer to where the priority should be stored</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param   subidx      Po=
inter to the sub-option index, decremented if no</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *                      priority value could b=
e found</span><br><span>  * @param   str         Priority string to parse</=
span><br><span>  * @param   pulled      Whether this was pulled from a serv=
er</span><br><span>  * @return              True if priority in string is v=
alid</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-bool dns_server_priority_parse(long *priority, const char *str, bool pu=
lled);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool dns_serv=
er_priority_parse(long *priority, size_t *subidx, const char *str, bool pul=
led);</span><br><span> </span><br><span> /**</span><br><span>  * Find or cr=
eate DNS server with priority in a linked list.</span><br><span>diff --git =
a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span>index 3e0cb=
62..ea69ea7 100644</span><br><span>--- a/src/openvpn/options.c</span><br><s=
pan>+++ b/src/openvpn/options.c</span><br><span>@@ -510,7 +510,7 @@</span><=
br><span>     &quot;                  ignore or reject causes the option to=
 be allowed, removed or\n&quot;</span><br><span>     &quot;                =
  rejected with error. May be specified multiple times, and\n&quot;</span><=
br><span>     &quot;                  each filter is applied in the order o=
f appearance.\n&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    &quot;--dns server &lt;n&gt; &lt;option&gt; &lt;value&gt; [value ...] :=
 Configure option for DNS server #n\n&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    &quot;--dns server [n] &lt;option&gt; &lt;value=
&gt; [value ...] : Configure option for DNS server #n\n&quot;</span><br><sp=
an>     &quot;                  Valid options are :\n&quot;</span><br><span=
>     &quot;                  address &lt;addr[:port]&gt; [addr[:port] ...]=
 : server addresses 4/6\n&quot;</span><br><span>     &quot;                =
  resolve-domains &lt;domain&gt; [domain ...] : split domains\n&quot;</span=
><br><span>@@ -7997,10 +7997,11 @@</span><br><span>         {</span><br><sp=
an>             dns_domain_list_append(&amp;options-&gt;dns_options.search_=
domains, &amp;p[2], &amp;options-&gt;dns_options.gc);</span><br><span>     =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else if =
(streq(p[1], &quot;server&quot;) &amp;&amp; p[2] &amp;&amp; p[3] &amp;&amp;=
 p[4])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else =
if (streq(p[1], &quot;server&quot;) &amp;&amp; p[2] &amp;&amp; p[3])</span>=
<br><span>         {</span><br><span>             long priority;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            if (!dns_server_prio=
rity_parse(&amp;priority, p[2], pull_mode))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            size_t subcmd =3D 3; /* one after prior=
ity, if a priority was given */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            if (!dns_server_priority_parse(&amp;priority, &amp;=
subcmd, p[2], pull_mode))</span><br><span>             {</span><br><span>  =
               msg(msglevel, &quot;--dns server: invalid priority value &#3=
9;%s&#39;&quot;, p[2]);</span><br><span>                 goto err;</span><b=
r><span>@@ -8008,9 +8009,9 @@</span><br><span> </span><br><span>           =
  struct dns_server *server =3D dns_server_get(&amp;options-&gt;dns_options=
.servers, priority, &amp;options-&gt;dns_options.gc);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (streq(p[3=
], &quot;address&quot;) &amp;&amp; p[4])</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (streq(p[subcmd], &quot;address&quot;) =
&amp;&amp; p[subcmd + 1])</span><br><span>             {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                for (int i =3D 4; p[i]; =
++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 for (int i =3D subcmd + 1; p[i]; ++i)</span><br><span>                 {</=
span><br><span>                     if (!dns_server_addr_parse(server, p[i]=
))</span><br><span>                     {</span><br><span>@@ -8019,57 +8020=
,57 @@</span><br><span>                     }</span><br><span>             =
    }</span><br><span>             }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            else if (streq(p[3], &quot;resolve-domains&quot;=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            else =
if (streq(p[subcmd], &quot;resolve-domains&quot;) &amp;&amp; p[subcmd + 1])=
</span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                dns_domain_list_append(&amp;server-&gt;domains, &=
amp;p[4], &amp;options-&gt;dns_options.gc);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                dns_domain_list_append(&amp;server-=
&gt;domains, &amp;p[subcmd + 1], &amp;options-&gt;dns_options.gc);</span><b=
r><span>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            else if (streq(p[3], &quot;dnssec&quot;) &amp;&amp; !p[5])</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            else if (st=
req(p[subcmd], &quot;dnssec&quot;) &amp;&amp; p[subcmd + 1] &amp;&amp; !p[s=
ubcmd + 2])</span><br><span>             {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                if (streq(p[4], &quot;yes&quot;))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                if (stre=
q(p[subcmd + 1], &quot;yes&quot;))</span><br><span>                 {</span=
><br><span>                     server-&gt;dnssec =3D DNS_SECURITY_YES;</sp=
an><br><span>                 }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                else if (streq(p[4], &quot;no&quot;))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                else if (streq(=
p[subcmd + 1], &quot;no&quot;))</span><br><span>                 {</span><b=
r><span>                     server-&gt;dnssec =3D DNS_SECURITY_NO;</span><=
br><span>                 }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                else if (streq(p[4], &quot;optional&quot;))</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+                else if (stre=
q(p[subcmd + 1], &quot;optional&quot;))</span><br><span>                 {<=
/span><br><span>                     server-&gt;dnssec =3D DNS_SECURITY_OPT=
IONAL;</span><br><span>                 }</span><br><span>                 =
else</span><br><span>                 {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    msg(msglevel, &quot;--dns server %ld:=
 malformed dnssec value &#39;%s&#39;&quot;, priority, p[4]);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                    msg(msglevel, =
&quot;--dns server %ld: malformed dnssec value &#39;%s&#39;&quot;, priority=
, p[subcmd + 1]);</span><br><span>                     goto err;</span><br>=
<span>                 }</span><br><span>             }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            else if (streq(p[3], &quot;tr=
ansport&quot;) &amp;&amp; !p[5])</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            else if (streq(p[subcmd], &quot;transport&quot;) &=
amp;&amp; p[subcmd + 1] &amp;&amp; !p[subcmd + 2])</span><br><span>        =
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
 if (streq(p[4], &quot;plain&quot;))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                if (streq(p[subcmd + 1], &quot;plain&quot;=
))</span><br><span>                 {</span><br><span>                     =
server-&gt;transport =3D DNS_TRANSPORT_PLAIN;</span><br><span>             =
    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
else if (streq(p[4], &quot;DoH&quot;))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                else if (streq(p[subcmd + 1], &quot;DoH&=
quot;))</span><br><span>                 {</span><br><span>                =
     server-&gt;transport =3D DNS_TRANSPORT_HTTPS;</span><br><span>        =
         }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     else if (streq(p[4], &quot;DoT&quot;))</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                else if (streq(p[subcmd + 1], &quot=
;DoT&quot;))</span><br><span>                 {</span><br><span>           =
          server-&gt;transport =3D DNS_TRANSPORT_TLS;</span><br><span>     =
            }</span><br><span>                 else</span><br><span>       =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
          msg(msglevel, &quot;--dns server %ld: malformed transport value &=
#39;%s&#39;&quot;, priority, p[4]);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    msg(msglevel, &quot;--dns server %ld: m=
alformed transport value &#39;%s&#39;&quot;, priority, p[subcmd + 1]);</spa=
n><br><span>                     goto err;</span><br><span>                =
 }</span><br><span>             }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            else if (streq(p[3], &quot;sni&quot;) &amp;&amp; !p=
[5])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            els=
e if (streq(p[subcmd], &quot;sni&quot;) &amp;&amp; p[subcmd + 1] &amp;&amp;=
 !p[subcmd + 2])</span><br><span>             {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                server-&gt;sni =3D p[4];</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                server-&gt;s=
ni =3D p[subcmd + 1];</span><br><span>             }</span><br><span>      =
       else</span><br><span>             {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                msg(msglevel, &quot;--dns server %ld: =
unknown option type &#39;%s&#39; or missing or unknown parameter&quot;, pri=
ority, p[3]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          msg(msglevel, &quot;--dns server %ld: unknown option type &#39;%s=
&#39; or missing or unknown parameter&quot;, priority, p[subcmd]);</span><b=
r><span>                 goto err;</span><br><span>             }</span><br=
><span>         }</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/40?usp=3Demail">change 40</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/40?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1f97d8e5ae8f049d72db5c12ce6=
27f601d87505c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 40 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--1ooo72WNKuM=--

