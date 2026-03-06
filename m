From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 6 Mar 2026 11:57:08 +0000
References: <gerrit.1772798203000.Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4eb3fdc8ac32ae0b86aa76448645f05aabff8952-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x/uqM64Huvg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dns: Change
 arguments to setenv_dns_option to avoid sign-compare warning
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--x/uqM64Huvg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail

to review the following change.


Change subject: dns: Change arguments to setenv_dns_option to avoid sign-co=
mpare warning
......................................................................

dns: Change arguments to setenv_dns_option to avoid sign-compare warning

The change is a bit big to fix just one compare warning,
but that is due to the highly interdependent code.

Change-Id: Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/dns.c
1 file changed, 12 insertions(+), 21 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/1558/1

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index a42d032..4388829 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -476,20 +476,15 @@
     send_msg_iservice(o->msg_channel, &nrpt, sizeof(nrpt), &ack, "DNS");
 }

-#else /* ifdef _WIN32 */
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
+#else  /* ifdef _WIN32 */

 static void
-setenv_dns_option(struct env_set *es, const char *format, int i, int j, co=
nst char *value)
+setenv_dns_option(struct env_set *es, const char *format, size_t i, size_t=
 j, const char *value)
 {
     char name[64];
     bool name_ok =3D false;

-    if (j < 0)
+    if (!j)
     {
         name_ok =3D checked_snprintf(name, sizeof(name), format, i);
     }
@@ -512,11 +507,11 @@
     struct gc_arena gc =3D gc_new();
     const struct dns_server *s;
     const struct dns_domain *d;
-    int i, j;
+    size_t i, j;

     for (i =3D 1, d =3D o->search_domains; d !=3D NULL; i++, d =3D d->next)
     {
-        setenv_dns_option(es, "dns_search_domain_%d", i, -1, d->name);
+        setenv_dns_option(es, "dns_search_domain_%zu", i, 0, d->name);
     }

     for (i =3D 1, s =3D o->servers; s !=3D NULL; i++, s =3D s->next)
@@ -525,17 +520,17 @@
         {
             if (s->addr[j].family =3D=3D AF_INET)
             {
-                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                setenv_dns_option(es, "dns_server_%zu_address_%zu", i, j +=
 1,
                                   print_in_addr_t(s->addr[j].in.a4.s_addr,=
 IA_NET_ORDER, &gc));
             }
             else
             {
-                setenv_dns_option(es, "dns_server_%d_address_%d", i, j + 1,
+                setenv_dns_option(es, "dns_server_%zu_address_%zu", i, j +=
 1,
                                   print_in6_addr(s->addr[j].in.a6, 0, &gc)=
);
             }
             if (s->addr[j].port)
             {
-                setenv_dns_option(es, "dns_server_%d_port_%d", i, j + 1,
+                setenv_dns_option(es, "dns_server_%zu_port_%zu", i, j + 1,
                                   print_in_port_t(s->addr[j].port, &gc));
             }
         }
@@ -544,32 +539,28 @@
         {
             for (j =3D 1, d =3D s->domains; d !=3D NULL; j++, d =3D d->nex=
t)
             {
-                setenv_dns_option(es, "dns_server_%d_resolve_domain_%d", i=
, j, d->name);
+                setenv_dns_option(es, "dns_server_%zu_resolve_domain_%d", =
i, j, d->name);
             }
         }

         if (s->dnssec)
         {
-            setenv_dns_option(es, "dns_server_%d_dnssec", i, -1, dnssec_va=
lue(s->dnssec));
+            setenv_dns_option(es, "dns_server_%zu_dnssec", i, 0, dnssec_va=
lue(s->dnssec));
         }

         if (s->transport)
         {
-            setenv_dns_option(es, "dns_server_%d_transport", i, -1, transp=
ort_value(s->transport));
+            setenv_dns_option(es, "dns_server_%zu_transport", i, 0, transp=
ort_value(s->transport));
         }
         if (s->sni)
         {
-            setenv_dns_option(es, "dns_server_%d_sni", i, -1, s->sni);
+            setenv_dns_option(es, "dns_server_%zu_sni", i, 0, s->sni);
         }
     }

     gc_free(&gc);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static void
 updown_env_set(bool up, const struct dns_options *o, const struct tuntap *=
tt, struct env_set *es)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5
Gerrit-Change-Number: 1558
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--x/uqM64Huvg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dns: Change arguments to setenv_dns_option =
to avoid sign-compare warning<br><br>The change is a bit big to fix just on=
e compare warning,<br>but that is due to the highly interdependent code.<br=
><br>Change-Id: Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5<br>Signed-off-by:=
 Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/dns.c<b=
r>1 file changed, 12 insertions(+), 21 deletions(-)<br><br></pre><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/1558/1<=
/pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;=
"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>=
index a42d032..4388829 100644</span><br><span>--- a/src/openvpn/dns.c</span=
><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -476,20 +476,15 @@</s=
pan><br><span>     send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, sizeof(n=
rpt), &amp;ack, &quot;DNS&quot;);</span><br><span> }</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* ifdef _WIN32 */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#else  /* ifdef _WIN32 */</span><br><span> </span><br><span> static=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-setenv_dns_optio=
n(struct env_set *es, const char *format, int i, int j, const char *value)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_dns_option(st=
ruct env_set *es, const char *format, size_t i, size_t j, const char *value=
)</span><br><span> {</span><br><span>     char name[64];</span><br><span>  =
   bool name_ok =3D false;</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (j &lt; 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!j)</span><br><span>     {</span><br><span>   =
      name_ok =3D checked_snprintf(name, sizeof(name), format, i);</span><b=
r><span>     }</span><br><span>@@ -512,11 +507,11 @@</span><br><span>     s=
truct gc_arena gc =3D gc_new();</span><br><span>     const struct dns_serve=
r *s;</span><br><span>     const struct dns_domain *d;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    int i, j;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    size_t i, j;</span><br><span> </span><br><sp=
an>     for (i =3D 1, d =3D o-&gt;search_domains; d !=3D NULL; i++, d =3D d=
-&gt;next)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        setenv_dns_option(es, &quot;dns_search_domain_%d&quot;,=
 i, -1, d-&gt;name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        setenv_dns_option(es, &quot;dns_search_domain_%zu&quot;, i, 0, d-&=
gt;name);</span><br><span>     }</span><br><span> </span><br><span>     for=
 (i =3D 1, s =3D o-&gt;servers; s !=3D NULL; i++, s =3D s-&gt;next)</span><=
br><span>@@ -525,17 +520,17 @@</span><br><span>         {</span><br><span> =
            if (s-&gt;addr[j].family =3D=3D AF_INET)</span><br><span>      =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   setenv_dns_option(es, &quot;dns_server_%d_address_%d&quot;, i, j + 1,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                setenv=
_dns_option(es, &quot;dns_server_%zu_address_%zu&quot;, i, j + 1,</span><br=
><span>                                   print_in_addr_t(s-&gt;addr[j].in.=
a4.s_addr, IA_NET_ORDER, &amp;gc));</span><br><span>             }</span><b=
r><span>             else</span><br><span>             {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                setenv_dns_option(es, &q=
uot;dns_server_%d_address_%d&quot;, i, j + 1,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                setenv_dns_option(es, &quot;dns_s=
erver_%zu_address_%zu&quot;, i, j + 1,</span><br><span>                    =
               print_in6_addr(s-&gt;addr[j].in.a6, 0, &amp;gc));</span><br>=
<span>             }</span><br><span>             if (s-&gt;addr[j].port)</=
span><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                setenv_dns_option(es, &quot;dns_server_%d_port_%d&q=
uot;, i, j + 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            setenv_dns_option(es, &quot;dns_server_%zu_port_%zu&quot;, i, j=
 + 1,</span><br><span>                                   print_in_port_t(s-=
&gt;addr[j].port, &amp;gc));</span><br><span>             }</span><br><span=
>         }</span><br><span>@@ -544,32 +539,28 @@</span><br><span>         =
{</span><br><span>             for (j =3D 1, d =3D s-&gt;domains; d !=3D NU=
LL; j++, d =3D d-&gt;next)</span><br><span>             {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                setenv_dns_option(es, &=
quot;dns_server_%d_resolve_domain_%d&quot;, i, j, d-&gt;name);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                setenv_dns_optio=
n(es, &quot;dns_server_%zu_resolve_domain_%d&quot;, i, j, d-&gt;name);</spa=
n><br><span>             }</span><br><span>         }</span><br><span> </sp=
an><br><span>         if (s-&gt;dnssec)</span><br><span>         {</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            setenv_dns_option(=
es, &quot;dns_server_%d_dnssec&quot;, i, -1, dnssec_value(s-&gt;dnssec));</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            setenv_dn=
s_option(es, &quot;dns_server_%zu_dnssec&quot;, i, 0, dnssec_value(s-&gt;dn=
ssec));</span><br><span>         }</span><br><span> </span><br><span>      =
   if (s-&gt;transport)</span><br><span>         {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            setenv_dns_option(es, &quot;dns_se=
rver_%d_transport&quot;, i, -1, transport_value(s-&gt;transport));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            setenv_dns_optio=
n(es, &quot;dns_server_%zu_transport&quot;, i, 0, transport_value(s-&gt;tra=
nsport));</span><br><span>         }</span><br><span>         if (s-&gt;sni=
)</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-            setenv_dns_option(es, &quot;dns_server_%d_sni&quot;, i, =
-1, s-&gt;sni);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        setenv_dns_option(es, &quot;dns_server_%zu_sni&quot;, i, 0, s-&gt;s=
ni);</span><br><span>         }</span><br><span>     }</span><br><span> </s=
pan><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> static void</span><br><span> updown_env_set(bool up, const struct dn=
s_options *o, const struct tuntap *tt, struct env_set *es)</span><br><span>=
 {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1558?usp=3Demail">change 1558</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1558?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibfcc350c772227cfc0f2244fa2b=
1625dcb7e6fb5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1558 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--x/uqM64Huvg=--

