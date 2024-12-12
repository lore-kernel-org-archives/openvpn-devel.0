From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 12 Dec 2024 07:47:41 +0000
References: <gerrit.1733989644000.I12b8bb26c0cb70e50b2d42b1c69018894e9f080c@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3475f095bce1e8bb3549a7f35f6c4a45712b9ce6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="e0rU5Vx9KVk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--e0rU5Vx9KVk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/835?usp=3Demail

to review the following change.


Change subject: dns: clone options via pointer instead of copy
......................................................................

dns: clone options via pointer instead of copy

Change-Id: I12b8bb26c0cb70e50b2d42b1c69018894e9f080c
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M src/openvpn/dns.c
M src/openvpn/dns.h
M src/openvpn/options.c
3 files changed, 10 insertions(+), 7 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/835/1

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
index fa22eca..cc723ca 100644
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
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--e0rU5Vx9KVk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/835?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">dns: clone options via pointer instead of copy<br><br>Change-=
Id: I12b8bb26c0cb70e50b2d42b1c69018894e9f080c<br>Signed-off-by: Heiko Hund =
&lt;heiko@...2662...&gt;<br>---<br>M src/openvpn/dns.c<br>M src/openvpn/dns=
.h<br>M src/openvpn/options.c<br>3 files changed, 10 insertions(+), 7 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/35/835/1</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/dns.c b/src/openvpn/dns.c</sp=
an><br><span>index 15e7322..e22ea00 100644</span><br><span>--- a/src/openvp=
n/dns.c</span><br><span>+++ b/src/openvpn/dns.c</span><br><span>@@ -248,13 =
+248,15 @@</span><br><span> }</span><br><span> </span><br><span> struct dns=
_options</span><br><span style=3D"color: hsl(0, 100%, 40%);">-clone_dns_opt=
ions(const struct dns_options o, struct gc_arena *gc)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+clone_dns_options(const struct dns_option=
s *o, struct gc_arena *gc)</span><br><span> {</span><br><span>     struct d=
ns_options clone;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     memset(&amp;clone, 0, sizeof(clone));</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    clone.search_domains =3D clone_dns_=
domains(o.search_domains, gc);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    clone.servers =3D clone_dns_servers(o.servers, gc);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    clone.servers_prepull =3D cl=
one_dns_servers(o.servers_prepull, gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    clone.search_domains =3D clone_dns_domains(o-&gt;se=
arch_domains, gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   clone.servers =3D clone_dns_servers(o-&gt;servers, gc);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    clone.servers_prepull =3D clone_=
dns_servers(o-&gt;servers_prepull, gc);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     return clone;</span><br><span> }<=
/span><br><span> </span><br><span>diff --git a/src/openvpn/dns.h b/src/open=
vpn/dns.h</span><br><span>index a4ccb95..838ebe1 100644</span><br><span>---=
 a/src/openvpn/dns.h</span><br><span>+++ b/src/openvpn/dns.h</span><br><spa=
n>@@ -129,7 +129,8 @@</span><br><span>  * @param   gc          Pointer to t=
he gc_arena to use for the clone</span><br><span>  * @return              T=
he dns_options clone</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-struct dns_options clone_dns_options(const struct dns_o=
ptions o, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+struct dns_options clone_dns_options(const struct dns_options *=
o,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
                    struct gc_arena *gc);</span><br><span> </span><br><span=
> /**</span><br><span>  * Saves and resets the server options, so that pull=
ed ones don&#39;t mix in.</span><br><span>diff --git a/src/openvpn/options.=
c b/src/openvpn/options.c</span><br><span>index fa22eca..cc723ca 100644</sp=
an><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/=
options.c</span><br><span>@@ -3311,7 +3311,7 @@</span><br><span>     o-&gt;=
pre_connect-&gt;route_default_gateway =3D o-&gt;route_default_gateway;</spa=
n><br><span>     o-&gt;pre_connect-&gt;route_ipv6_default_gateway =3D o-&gt=
;route_ipv6_default_gateway;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    o-&gt;pre_connect-&gt;dns_options =3D clone_dn=
s_options(o-&gt;dns_options, &amp;o-&gt;gc);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    o-&gt;pre_connect-&gt;dns_options =3D clone_dn=
s_options(&amp;o-&gt;dns_options, &amp;o-&gt;gc);</span><br><span> </span><=
br><span>     /* NCP related options that can be overwritten by a push */</=
span><br><span>     o-&gt;pre_connect-&gt;ciphername =3D o-&gt;ciphername;<=
/span><br><span>@@ -3364,7 +3364,7 @@</span><br><span>         /* Free DNS =
options and reset them to pre-pull state */</span><br><span>         gc_fre=
e(&amp;o-&gt;dns_options.gc);</span><br><span>         struct gc_arena dns_=
gc =3D gc_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   o-&gt;dns_options =3D clone_dns_options(pp-&gt;dns_options, &amp;dns_gc)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        o-&gt;dns_=
options =3D clone_dns_options(&amp;pp-&gt;dns_options, &amp;dns_gc);</span>=
<br><span>         o-&gt;dns_options.gc =3D dns_gc;</span><br><span> </span=
><br><span>         if (pp-&gt;client_nat_defined)</span><br><span></span><=
br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/835?usp=3Demail">change 835</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/835?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I12b8bb26c0cb70e50b2d42b1c69=
018894e9f080c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 835 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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


--e0rU5Vx9KVk=--

