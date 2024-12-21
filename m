From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 21 Dec 2024 15:29:47 +0000
In-Reply-To: <gerrit.1733989644000.I12b8bb26c0cb70e50b2d42b1c69018894e9f080c@...2715...>
References: <gerrit.1733989644000.I12b8bb26c0cb70e50b2d42b1c69018894e9f080c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <84ad40f5b6146a022059fe8f7c71812b786f3e17-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a02SX4R8Uwo="; charset=UTF-8
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
To: d12fk <heiko@...515...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--a02SX4R8Uwo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/83=
5?usp=3Demail )

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
Gerrit-MessageType: merged

--a02SX4R8Uwo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/835?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">dns: clone options via pointer instead of copy=
<br><br>Change-Id: I12b8bb26c0cb70e50b2d42b1c69018894e9f080c<br>Signed-off-=
by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>Message-Id: &lt;20241213164630.266045-1-frank@...2375...=
41...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1357...=
rge.net/msg30112.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt=
;<br>---<br>M src/openvpn/dns.c<br>M src/openvpn/dns.h<br>M src/openvpn/opt=
ions.c<br>3 files changed, 10 insertions(+), 7 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</span><br><span>index=
 15e7322..e22ea00 100644</span><br><span>--- a/src/openvpn/dns.c</span><br>=
<span>+++ b/src/openvpn/dns.c</span><br><span>@@ -248,13 +248,15 @@</span><=
br><span> }</span><br><span> </span><br><span> struct dns_options</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-clone_dns_options(const struct =
dns_options o, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+clone_dns_options(const struct dns_options *o, struct gc_ar=
ena *gc)</span><br><span> {</span><br><span>     struct dns_options clone;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>   =
  memset(&amp;clone, 0, sizeof(clone));</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    clone.search_domains =3D clone_dns_domains(o.search_d=
omains, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    clone=
.servers =3D clone_dns_servers(o.servers, gc);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    clone.servers_prepull =3D clone_dns_servers(o.=
servers_prepull, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    clone.search_domains =3D clone_dns_domains(o-&gt;search_domains, gc);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    clone.servers =
=3D clone_dns_servers(o-&gt;servers, gc);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    clone.servers_prepull =3D clone_dns_servers(o-&gt=
;servers_prepull, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span>     return clone;</span><br><span> }</span><br><span> =
</span><br><span>diff --git a/src/openvpn/dns.h b/src/openvpn/dns.h</span><=
br><span>index a4ccb95..838ebe1 100644</span><br><span>--- a/src/openvpn/dn=
s.h</span><br><span>+++ b/src/openvpn/dns.h</span><br><span>@@ -129,7 +129,=
8 @@</span><br><span>  * @param   gc          Pointer to the gc_arena to us=
e for the clone</span><br><span>  * @return              The dns_options cl=
one</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-struct dns_options clone_dns_options(const struct dns_options o, struct =
gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+struc=
t dns_options clone_dns_options(const struct dns_options *o,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                  =
   struct gc_arena *gc);</span><br><span> </span><br><span> /**</span><br><=
span>  * Saves and resets the server options, so that pulled ones don&#39;t=
 mix in.</span><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/o=
ptions.c</span><br><span>index d8dd518..b2a3a8b 100644</span><br><span>--- =
a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</span><=
br><span>@@ -3311,7 +3311,7 @@</span><br><span>     o-&gt;pre_connect-&gt;r=
oute_default_gateway =3D o-&gt;route_default_gateway;</span><br><span>     =
o-&gt;pre_connect-&gt;route_ipv6_default_gateway =3D o-&gt;route_ipv6_defau=
lt_gateway;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    o-&gt;pre_connect-&gt;dns_options =3D clone_dns_options(o-&gt;d=
ns_options, &amp;o-&gt;gc);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    o-&gt;pre_connect-&gt;dns_options =3D clone_dns_options(&amp;o-=
&gt;dns_options, &amp;o-&gt;gc);</span><br><span> </span><br><span>     /* =
NCP related options that can be overwritten by a push */</span><br><span>  =
   o-&gt;pre_connect-&gt;ciphername =3D o-&gt;ciphername;</span><br><span>@=
@ -3364,7 +3364,7 @@</span><br><span>         /* Free DNS options and reset=
 them to pre-pull state */</span><br><span>         gc_free(&amp;o-&gt;dns_=
options.gc);</span><br><span>         struct gc_arena dns_gc =3D gc_new();<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        o-&gt;dns_opti=
ons =3D clone_dns_options(pp-&gt;dns_options, &amp;dns_gc);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;dns_options =3D clone=
_dns_options(&amp;pp-&gt;dns_options, &amp;dns_gc);</span><br><span>       =
  o-&gt;dns_options.gc =3D dns_gc;</span><br><span> </span><br><span>      =
   if (pp-&gt;client_nat_defined)</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/835?usp=3Demail"=
>change 835</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/835?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--a02SX4R8Uwo=--

