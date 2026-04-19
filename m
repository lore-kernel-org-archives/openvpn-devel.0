From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 19 Apr 2026 16:22:32 +0000
In-Reply-To: <gerrit.1772798203000.Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5@...2715...>
References: <gerrit.1772798203000.Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7c4f73e3d55035c0e1946e7edc821a442424cb80-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TNNg8Da4nQM="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TNNg8Da4nQM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dns: Change arguments to setenv_dns_option to avoid sign-co=
mpare warning
......................................................................

dns: Change arguments to setenv_dns_option to avoid sign-compare warning

The change is a bit big to fix just one compare warning,
but that is due to the highly interdependent code.

Change-Id: Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1558
Message-Id: <20260407094643.28090-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
531.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
1 file changed, 12 insertions(+), 21 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/1558/8

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index a42d032..ce23f1f 100644
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
+                setenv_dns_option(es, "dns_server_%zu_resolve_domain_%zu",=
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
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TNNg8Da4nQM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #8</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dns: Change arguments to setenv_dns=
_option to avoid sign-compare warning<br><br>The change is a bit big to fix=
 just one compare warning,<br>but that is due to the highly interdependent =
code.<br><br>Change-Id: Ibfcc350c772227cfc0f2244fa2b1625dcb7e6fb5<br>Signed=
-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/open=
vpn/+/1558<br>Message-Id: &lt;20260407094643.28090-1-gert@...1296...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg3=
6531.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M src/openvpn/dns.c<br>1 file changed, 12 insertions(+), 21 deletions(-)<br=
><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/58/1558/8</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/d=
ns.c</span><br><span>index a42d032..ce23f1f 100644</span><br><span>--- a/sr=
c/openvpn/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ =
-476,20 +476,15 @@</span><br><span>     send_msg_iservice(o-&gt;msg_channel=
, &amp;nrpt, sizeof(nrpt), &amp;ack, &quot;DNS&quot;);</span><br><span> }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else=
 /* ifdef _WIN32 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) |=
| defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#else  /* ifdef _WIN32 */</span><br><span> </sp=
an><br><span> static void</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-setenv_dns_option(struct env_set *es, const char *format, int i, int j,=
 const char *value)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
setenv_dns_option(struct env_set *es, const char *format, size_t i, size_t =
j, const char *value)</span><br><span> {</span><br><span>     char name[64]=
;</span><br><span>     bool name_ok =3D false;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (j &lt; 0)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (j =3D=3D 0)</span><br><spa=
n>     {</span><br><span>         name_ok =3D checked_snprintf(name, sizeof=
(name), format, i);</span><br><span>     }</span><br><span>@@ -512,11 +507,=
11 @@</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span=
>     const struct dns_server *s;</span><br><span>     const struct dns_dom=
ain *d;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i, j;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t i, j;</sp=
an><br><span> </span><br><span>     for (i =3D 1, d =3D o-&gt;search_domain=
s; d !=3D NULL; i++, d =3D d-&gt;next)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        setenv_dns_option(es, &quot=
;dns_search_domain_%d&quot;, i, -1, d-&gt;name);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        setenv_dns_option(es, &quot;dns_search=
_domain_%zu&quot;, i, 0, d-&gt;name);</span><br><span>     }</span><br><spa=
n> </span><br><span>     for (i =3D 1, s =3D o-&gt;servers; s !=3D NULL; i+=
+, s =3D s-&gt;next)</span><br><span>@@ -525,17 +520,17 @@</span><br><span>=
         {</span><br><span>             if (s-&gt;addr[j].family =3D=3D AF_=
INET)</span><br><span>             {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                setenv_dns_option(es, &quot;dns_server_%d_ad=
dress_%d&quot;, i, j + 1,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                setenv_dns_option(es, &quot;dns_server_%zu_address_%z=
u&quot;, i, j + 1,</span><br><span>                                   print=
_in_addr_t(s-&gt;addr[j].in.a4.s_addr, IA_NET_ORDER, &amp;gc));</span><br><=
span>             }</span><br><span>             else</span><br><span>     =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    setenv_dns_option(es, &quot;dns_server_%d_address_%d&quot;, i, j + 1,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                seten=
v_dns_option(es, &quot;dns_server_%zu_address_%zu&quot;, i, j + 1,</span><b=
r><span>                                   print_in6_addr(s-&gt;addr[j].in.=
a6, 0, &amp;gc));</span><br><span>             }</span><br><span>          =
   if (s-&gt;addr[j].port)</span><br><span>             {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                setenv_dns_option(es, &=
quot;dns_server_%d_port_%d&quot;, i, j + 1,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                setenv_dns_option(es, &quot;dns_ser=
ver_%zu_port_%zu&quot;, i, j + 1,</span><br><span>                         =
          print_in_port_t(s-&gt;addr[j].port, &amp;gc));</span><br><span>  =
           }</span><br><span>         }</span><br><span>@@ -544,32 +539,28 =
@@</span><br><span>         {</span><br><span>             for (j =3D 1, d =
=3D s-&gt;domains; d !=3D NULL; j++, d =3D d-&gt;next)</span><br><span>    =
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     setenv_dns_option(es, &quot;dns_server_%d_resolve_domain_%d&quot;, i, =
j, d-&gt;name);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            setenv_dns_option(es, &quot;dns_server_%zu_resolve_domain_%zu&q=
uot;, i, j, d-&gt;name);</span><br><span>             }</span><br><span>   =
      }</span><br><span> </span><br><span>         if (s-&gt;dnssec)</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           setenv_dns_option(es, &quot;dns_server_%d_dnssec&quot;, i, -1, d=
nssec_value(s-&gt;dnssec));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+            setenv_dns_option(es, &quot;dns_server_%zu_dnssec&quot;=
, i, 0, dnssec_value(s-&gt;dnssec));</span><br><span>         }</span><br><=
span> </span><br><span>         if (s-&gt;transport)</span><br><span>      =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            seten=
v_dns_option(es, &quot;dns_server_%d_transport&quot;, i, -1, transport_valu=
e(s-&gt;transport));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+            setenv_dns_option(es, &quot;dns_server_%zu_transport&quot;, i,=
 0, transport_value(s-&gt;transport));</span><br><span>         }</span><br=
><span>         if (s-&gt;sni)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            setenv_dns_option(es, &quot=
;dns_server_%d_sni&quot;, i, -1, s-&gt;sni);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            setenv_dns_option(es, &quot;dns_server=
_%zu_sni&quot;, i, 0, s-&gt;sni);</span><br><span>         }</span><br><spa=
n>     }</span><br><span> </span><br><span>     gc_free(&amp;gc);</span><br=
><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span> static void</span><br><span> updown_env=
_set(bool up, const struct dns_options *o, const struct tuntap *tt, struct =
env_set *es)</span><br><span> {</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail">=
change 1558</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1558?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibfcc350c772227cfc0f2244fa2b=
1625dcb7e6fb5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1558 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--TNNg8Da4nQM=--

