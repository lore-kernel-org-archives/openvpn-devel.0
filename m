From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 12 Mar 2026 13:25:17 +0000
In-Reply-To: <gerrit.1772798203000.Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5@...2715...>
References: <gerrit.1772798203000.Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <0bae9164d3e969a68b83bce506061c6f8ac6b30a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mdemXo37tQE="; charset=UTF-8
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

--mdemXo37tQE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/1558/3

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index a42d032..c146d75 100644
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
+    if (j =3D=3D 0)
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5
Gerrit-Change-Number: 1558
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--mdemXo37tQE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dns: Change arguments to setenv_dns=
_option to avoid sign-compare warning<br><br>The change is a bit big to fix=
 just one compare warning,<br>but that is due to the highly interdependent =
code.<br><br>Change-Id: Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn=
/dns.c<br>1 file changed, 12 insertions(+), 21 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58=
/1558/3</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><b=
r><span>index a42d032..c146d75 100644</span><br><span>--- a/src/openvpn/dns=
.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -476,20 +476,=
15 @@</span><br><span>     send_msg_iservice(o-&gt;msg_channel, &amp;nrpt, =
sizeof(nrpt), &amp;ack, &quot;DNS&quot;);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else /* ifdef _WI=
N32 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__c=
lang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC di=
agnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma =
GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#else  /* ifdef _WIN32 */</span><br><span> </span><br><span>=
 static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-setenv_dn=
s_option(struct env_set *es, const char *format, int i, int j, const char *=
value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+setenv_dns_op=
tion(struct env_set *es, const char *format, size_t i, size_t j, const char=
 *value)</span><br><span> {</span><br><span>     char name[64];</span><br><=
span>     bool name_ok =3D false;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (j &lt; 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (j =3D=3D 0)</span><br><span>     {</s=
pan><br><span>         name_ok =3D checked_snprintf(name, sizeof(name), for=
mat, i);</span><br><span>     }</span><br><span>@@ -512,11 +507,11 @@</span=
><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     const=
 struct dns_server *s;</span><br><span>     const struct dns_domain *d;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i, j;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    size_t i, j;</span><br><spa=
n> </span><br><span>     for (i =3D 1, d =3D o-&gt;search_domains; d !=3D N=
ULL; i++, d =3D d-&gt;next)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        setenv_dns_option(es, &quot;dns_search=
_domain_%d&quot;, i, -1, d-&gt;name);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        setenv_dns_option(es, &quot;dns_search_domain_%zu=
&quot;, i, 0, d-&gt;name);</span><br><span>     }</span><br><span> </span><=
br><span>     for (i =3D 1, s =3D o-&gt;servers; s !=3D NULL; i++, s =3D s-=
&gt;next)</span><br><span>@@ -525,17 +520,17 @@</span><br><span>         {<=
/span><br><span>             if (s-&gt;addr[j].family =3D=3D AF_INET)</span=
><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                setenv_dns_option(es, &quot;dns_server_%d_address_%d&qu=
ot;, i, j + 1,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           setenv_dns_option(es, &quot;dns_server_%zu_address_%zu&quot;, i,=
 j + 1,</span><br><span>                                   print_in_addr_t(=
s-&gt;addr[j].in.a4.s_addr, IA_NET_ORDER, &amp;gc));</span><br><span>      =
       }</span><br><span>             else</span><br><span>             {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                setenv_=
dns_option(es, &quot;dns_server_%d_address_%d&quot;, i, j + 1,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                setenv_dns_optio=
n(es, &quot;dns_server_%zu_address_%zu&quot;, i, j + 1,</span><br><span>   =
                                print_in6_addr(s-&gt;addr[j].in.a6, 0, &amp=
;gc));</span><br><span>             }</span><br><span>             if (s-&g=
t;addr[j].port)</span><br><span>             {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-                setenv_dns_option(es, &quot;dns_se=
rver_%d_port_%d&quot;, i, j + 1,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                setenv_dns_option(es, &quot;dns_server_%zu_por=
t_%zu&quot;, i, j + 1,</span><br><span>                                   p=
rint_in_port_t(s-&gt;addr[j].port, &amp;gc));</span><br><span>             =
}</span><br><span>         }</span><br><span>@@ -544,32 +539,28 @@</span><b=
r><span>         {</span><br><span>             for (j =3D 1, d =3D s-&gt;d=
omains; d !=3D NULL; j++, d =3D d-&gt;next)</span><br><span>             {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                setenv=
_dns_option(es, &quot;dns_server_%d_resolve_domain_%d&quot;, i, j, d-&gt;na=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 setenv_dns_option(es, &quot;dns_server_%zu_resolve_domain_%d&quot;, i, j, =
d-&gt;name);</span><br><span>             }</span><br><span>         }</spa=
n><br><span> </span><br><span>         if (s-&gt;dnssec)</span><br><span>  =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            s=
etenv_dns_option(es, &quot;dns_server_%d_dnssec&quot;, i, -1, dnssec_value(=
s-&gt;dnssec));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        setenv_dns_option(es, &quot;dns_server_%zu_dnssec&quot;, i, 0, dnss=
ec_value(s-&gt;dnssec));</span><br><span>         }</span><br><span> </span=
><br><span>         if (s-&gt;transport)</span><br><span>         {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-            setenv_dns_option=
(es, &quot;dns_server_%d_transport&quot;, i, -1, transport_value(s-&gt;tran=
sport));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 setenv_dns_option(es, &quot;dns_server_%zu_transport&quot;, i, 0, transpor=
t_value(s-&gt;transport));</span><br><span>         }</span><br><span>     =
    if (s-&gt;sni)</span><br><span>         {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            setenv_dns_option(es, &quot;dns_server_=
%d_sni&quot;, i, -1, s-&gt;sni);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            setenv_dns_option(es, &quot;dns_server_%zu_sni&quo=
t;, i, 0, s-&gt;sni);</span><br><span>         }</span><br><span>     }</sp=
an><br><span> </span><br><span>     gc_free(&amp;gc);</span><br><span> }</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if de=
fined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> static void</span><br><span> updown_env_set(bool up=
, const struct dns_options *o, const struct tuntap *tt, struct env_set *es)=
</span><br><span> {</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail">change 1558<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibfcc350c772227cfc0f2244fa2b=
1625dcb7e6fb5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1558 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--mdemXo37tQE=--

