From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 21 Dec 2024 15:29:44 +0000
In-Reply-To: <gerrit.1733989644000.I12b8bb26c0cb70e50b2d42b1c69018894e9f080c@...2715...>
References: <gerrit.1733989644000.I12b8bb26c0cb70e50b2d42b1c69018894e9f080c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <84ad40f5b6146a022059fe8f7c71812b786f3e17-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A04UTIjHOOM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dns: clone options
 via pointer instead of copy
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--A04UTIjHOOM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/835?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: dns: clone options via pointer instead of copy
......................................................................

dns: clone options via pointer instead of copy

Change-Id: I12b8bb26c0cb70e50b2d42b1c69018894e9f080c
Signed-off-by: Heiko Hund <heiko@...2662...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20241213164630.266045-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
112.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
3 files changed, 10 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/835/2

diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c
index 15e7322..e22ea00 100644
--- a/src/openvpn/dns.c
+++ b/src/openvpn/dns.c
@@ -248,13 +248,15 @@
 }

 struct dns_options
-clone_dns_options(const struct dns_options o, struct gc_arena *gc)
+clone_dns_options(const struct dns_options *o, struct gc_arena *gc)
 {
     struct dns_options clone;
+
     memset(&clone, 0, sizeof(clone));
-    clone.search_domains =3D clone_dns_domains(o.search_domains, gc);
-    clone.servers =3D clone_dns_servers(o.servers, gc);
-    clone.servers_prepull =3D clone_dns_servers(o.servers_prepull, gc);
+    clone.search_domains =3D clone_dns_domains(o->search_domains, gc);
+    clone.servers =3D clone_dns_servers(o->servers, gc);
+    clone.servers_prepull =3D clone_dns_servers(o->servers_prepull, gc);
+
     return clone;
 }

diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h
index a4ccb95..838ebe1 100644
--- a/src/openvpn/dns.h
+++ b/src/openvpn/dns.h
@@ -129,7 +129,8 @@
  * @param   gc          Pointer to the gc_arena to use for the clone
  * @return              The dns_options clone
  */
-struct dns_options clone_dns_options(const struct dns_options o, struct gc=
_arena *gc);
+struct dns_options clone_dns_options(const struct dns_options *o,
+                                     struct gc_arena *gc);

 /**
  * Saves and resets the server options, so that pulled ones don't mix in.
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d8dd518..b2a3a8b 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3311,7 +3311,7 @@
     o->pre_connect->route_default_gateway =3D o->route_default_gateway;
     o->pre_connect->route_ipv6_default_gateway =3D o->route_ipv6_default_g=
ateway;

-    o->pre_connect->dns_options =3D clone_dns_options(o->dns_options, &o->=
gc);
+    o->pre_connect->dns_options =3D clone_dns_options(&o->dns_options, &o-=
>gc);

     /* NCP related options that can be overwritten by a push */
     o->pre_connect->ciphername =3D o->ciphername;
@@ -3364,7 +3364,7 @@
         /* Free DNS options and reset them to pre-pull state */
         gc_free(&o->dns_options.gc);
         struct gc_arena dns_gc =3D gc_new();
-        o->dns_options =3D clone_dns_options(pp->dns_options, &dns_gc);
+        o->dns_options =3D clone_dns_options(&pp->dns_options, &dns_gc);
         o->dns_options.gc =3D dns_gc;

         if (pp->client_nat_defined)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/835?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I12b8bb26c0cb70e50b2d42b1c69018894e9f080c
Gerrit-Change-Number: 835
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--A04UTIjHOOM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/835?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">dns: clone options via pointer instead of cop=
y<br><br>Change-Id: I12b8bb26c0cb70e50b2d42b1c69018894e9f080c<br>Signed-off=
-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>Message-Id: &lt;20241213164630.266045-1-frank@...1665...=
641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1535...=
orge.net/msg30112.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvpn/op=
tions.c<br>3 files changed, 10 insertions(+), 7 deletions(-)<br><br></pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git =
pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/835/2</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index 15e=
7322..e22ea00 100644</span><br><span>--- a/src/openvpn/dns.c</span><br><spa=
n>+++ b/src/openvpn/dns.c</span><br><span>@@ -248,13 +248,15 @@</span><br><=
span> }</span><br><span> </span><br><span> struct dns_options</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-clone_dns_options(const struct dns_=
options o, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+clone_dns_options(const struct dns_options *o, struct gc_arena =
*gc)</span><br><span> {</span><br><span>     struct dns_options clone;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     me=
mset(&amp;clone, 0, sizeof(clone));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    clone.search_domains =3D clone_dns_domains(o.search_domai=
ns, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    clone.ser=
vers =3D clone_dns_servers(o.servers, gc);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    clone.servers_prepull =3D clone_dns_servers(o.serv=
ers_prepull, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  clone.search_domains =3D clone_dns_domains(o-&gt;search_domains, gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    clone.servers =3D c=
lone_dns_servers(o-&gt;servers, gc);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    clone.servers_prepull =3D clone_dns_servers(o-&gt;serv=
ers_prepull, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     return clone;</span><br><span> }</span><br><span> </spa=
n><br><span>diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h</span><br><s=
pan>index a4ccb95..838ebe1 100644</span><br><span>--- a/src/openvpn/dns.h</=
span><br><span>+++ b/src/openvpn/dns.h</span><br><span>@@ -129,7 +129,8 @@<=
/span><br><span>  * @param   gc          Pointer to the gc_arena to use for=
 the clone</span><br><span>  * @return              The dns_options clone</=
span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
ruct dns_options clone_dns_options(const struct dns_options o, struct gc_ar=
ena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struct dns=
_options clone_dns_options(const struct dns_options *o,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                     st=
ruct gc_arena *gc);</span><br><span> </span><br><span> /**</span><br><span>=
  * Saves and resets the server options, so that pulled ones don&#39;t mix =
in.</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/option=
s.c</span><br><span>index d8dd518..b2a3a8b 100644</span><br><span>--- a/src=
/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><s=
pan>@@ -3311,7 +3311,7 @@</span><br><span>     o-&gt;pre_connect-&gt;route_=
default_gateway =3D o-&gt;route_default_gateway;</span><br><span>     o-&gt=
;pre_connect-&gt;route_ipv6_default_gateway =3D o-&gt;route_ipv6_default_ga=
teway;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    o-&gt;pre_connect-&gt;dns_options =3D clone_dns_options(o-&gt;dns_op=
tions, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    o-&gt;pre_connect-&gt;dns_options =3D clone_dns_options(&amp;o-&gt;d=
ns_options, &amp;o-&gt;gc);</span><br><span> </span><br><span>     /* NCP r=
elated options that can be overwritten by a push */</span><br><span>     o-=
&gt;pre_connect-&gt;ciphername =3D o-&gt;ciphername;</span><br><span>@@ -33=
64,7 +3364,7 @@</span><br><span>         /* Free DNS options and reset them=
 to pre-pull state */</span><br><span>         gc_free(&amp;o-&gt;dns_optio=
ns.gc);</span><br><span>         struct gc_arena dns_gc =3D gc_new();</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;dns_options =
=3D clone_dns_options(pp-&gt;dns_options, &amp;dns_gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        o-&gt;dns_options =3D clone_dns=
_options(&amp;pp-&gt;dns_options, &amp;dns_gc);</span><br><span>         o-=
&gt;dns_options.gc =3D dns_gc;</span><br><span> </span><br><span>         i=
f (pp-&gt;client_nat_defined)</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/835?usp=3Demail">cha=
nge 835</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope it=
emtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action=
" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/835?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I12b8bb26c0cb70e50b2d42b1c69=
018894e9f080c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 835 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--A04UTIjHOOM=--

