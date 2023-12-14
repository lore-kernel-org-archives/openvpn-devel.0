From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 14 Dec 2023 13:38:06 +0000
References: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5017388de23112cb9484ab9f385484112c261dcf-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XLTM/XBR/mY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun.c: don't attempt
 to delete DNS and WINS servers if they're not set
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

--XLTM/XBR/mY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail

to review the following change.


Change subject: tun.c: don't attempt to delete DNS and WINS servers if they=
're not set
......................................................................

tun.c: don't attempt to delete DNS and WINS servers if they're not set

Commits

    1c4a47f7 ("wintun: set adapter properties via interactive service")
    18826de5 ("Set WINS servers via interactice service")

added functionality of add/remove DNS/WINS via interactive
service, which is used mostly by dco-win and wintun (tap-windows6
normally uses DHCP). There is a check in code - if DNS/WINS addresses
are not pushed, nothing is added.

However, due to bug we always attempted to remove DNS/WINS,
even if nothing was added. This change fixes this by improving
check "has DNS/WINS been pushed?".

While on it, convert do_XXX_service() functions to "void" from "bool",
since we never check their return values.

Change-Id: I21a36d24f8e213c780f55acbe3e4df555c93542a
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/tun.c
1 file changed, 13 insertions(+), 23 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/482/1

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f1b8699..9104d46 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -147,17 +147,16 @@
     return ret;
 }

-static bool
+static void
 do_dns_domain_service(bool add, const struct tuntap *tt)
 {
-    bool ret =3D false;
     ack_message_t ack;
     struct gc_arena gc =3D gc_new();
     HANDLE pipe =3D tt->options.msg_channel;

     if (!tt->options.domain) /* no  domain to add or delete */
     {
-        return true;
+        goto out;
     }

     /* Use dns_cfg_msg with addr_len =3D 0 for setting only the DOMAIN */
@@ -195,17 +194,14 @@
     }

     msg(M_INFO, "DNS domain %s using service", (add ? "set" : "deleted"));
-    ret =3D true;

 out:
     gc_free(&gc);
-    return ret;
 }

-static bool
+static void
 do_dns_service(bool add, const short family, const struct tuntap *tt)
 {
-    bool ret =3D false;
     ack_message_t ack;
     struct gc_arena gc =3D gc_new();
     HANDLE pipe =3D tt->options.msg_channel;
@@ -213,9 +209,11 @@
     int addr_len =3D add ? len : 0;
     const char *ip_proto_name =3D family =3D=3D AF_INET6 ? "IPv6" : "IPv4";

-    if (addr_len =3D=3D 0 && add) /* no addresses to add */
+    if (((family =3D=3D AF_INET6) && (tt->options.dns6_len =3D=3D 0))
+        || ((family =3D=3D AF_INET) && (tt->options.dns_len =3D=3D 0)))
     {
-        return true;
+        /* nothing to do */
+        goto out;
     }

     /* Use dns_cfg_msg with domain =3D "" for setting only the DNS servers=
 */
@@ -272,26 +270,23 @@
     }

     msg(M_INFO, "%s dns servers %s using service", ip_proto_name, (add ? "=
set" : "deleted"));
-    ret =3D true;

 out:
     gc_free(&gc);
-    return ret;
 }

-static bool
+static void
 do_wins_service(bool add, const struct tuntap *tt)
 {
-    bool ret =3D false;
     ack_message_t ack;
     struct gc_arena gc =3D gc_new();
     HANDLE pipe =3D tt->options.msg_channel;
-    int len =3D tt->options.wins_len;
-    int addr_len =3D add ? len : 0;
+    int addr_len =3D add ? tt->options.wins_len : 0;

-    if (addr_len =3D=3D 0 && add) /* no addresses to add */
+    if (tt->options.wins_len =3D=3D 0)
     {
-        return true;
+        /* nothing to do */
+        goto out;
     }

     wins_cfg_message_t wins =3D {
@@ -338,11 +333,9 @@
     }

     msg(M_INFO, "WINS servers %s using service", (add ? "set" : "deleted")=
);
-    ret =3D true;

 out:
     gc_free(&gc);
-    return ret;
 }

 static bool
@@ -7019,10 +7012,7 @@
             {
                 do_dns_domain_service(false, tt);
             }
-            if (tt->options.dns6_len > 0)
-            {
-                do_dns_service(false, AF_INET6, tt);
-            }
+            do_dns_service(false, AF_INET6, tt);
             delete_route_connected_v6_net(tt);
             do_address_service(false, AF_INET6, tt);
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I21a36d24f8e213c780f55acbe3e4df555c93542a
Gerrit-Change-Number: 482
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--XLTM/XBR/mY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">tun.c: don&#39;t attempt to delete DNS and WINS servers if th=
ey&#39;re not set<br><br>Commits<br><br>    1c4a47f7 (&quot;wintun: set ada=
pter properties via interactive service&quot;)<br>    18826de5 (&quot;Set W=
INS servers via interactice service&quot;)<br><br>added functionality of ad=
d/remove DNS/WINS via interactive<br>service, which is used mostly by dco-w=
in and wintun (tap-windows6<br>normally uses DHCP). There is a check in cod=
e - if DNS/WINS addresses<br>are not pushed, nothing is added.<br><br>Howev=
er, due to bug we always attempted to remove DNS/WINS,<br>even if nothing w=
as added. This change fixes this by improving<br>check &quot;has DNS/WINS b=
een pushed?&quot;.<br><br>While on it, convert do_XXX_service() functions t=
o &quot;void&quot; from &quot;bool&quot;,<br>since we never check their ret=
urn values.<br><br>Change-Id: I21a36d24f8e213c780f55acbe3e4df555c93542a<br>=
Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/t=
un.c<br>1 file changed, 13 insertions(+), 23 deletions(-)<br><br></pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/482/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index f1b869=
9..9104d46 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+=
++ b/src/openvpn/tun.c</span><br><span>@@ -147,17 +147,16 @@</span><br><spa=
n>     return ret;</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+static void</span><br><span> do_dns_domain_servic=
e(bool add, const struct tuntap *tt)</span><br><span> {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br><span> =
    ack_message_t ack;</span><br><span>     struct gc_arena gc =3D gc_new()=
;</span><br><span>     HANDLE pipe =3D tt-&gt;options.msg_channel;</span><b=
r><span> </span><br><span>     if (!tt-&gt;options.domain) /* no  domain to=
 add or delete */</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        return true;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        goto out;</span><br><span>     }</span><br><spa=
n> </span><br><span>     /* Use dns_cfg_msg with addr_len =3D 0 for setting=
 only the DOMAIN */</span><br><span>@@ -195,17 +194,14 @@</span><br><span> =
    }</span><br><span> </span><br><span>     msg(M_INFO, &quot;DNS domain %=
s using service&quot;, (add ? &quot;set&quot; : &quot;deleted&quot;));</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D true;</span><b=
r><span> </span><br><span> out:</span><br><span>     gc_free(&amp;gc);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span> do_dns_service(bool add, const short family, cons=
t struct tuntap *tt)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    bool ret =3D false;</span><br><span>     ack_message_=
t ack;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><spa=
n>     HANDLE pipe =3D tt-&gt;options.msg_channel;</span><br><span>@@ -213,=
9 +209,11 @@</span><br><span>     int addr_len =3D add ? len : 0;</span><br=
><span>     const char *ip_proto_name =3D family =3D=3D AF_INET6 ? &quot;IP=
v6&quot; : &quot;IPv4&quot;;</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (addr_len =3D=3D 0 &amp;&amp; add) /* no ad=
dresses to add */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (((family =3D=3D AF_INET6) &amp;&amp; (tt-&gt;options.dns6_len =3D=3D =
0))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        || ((fam=
ily =3D=3D AF_INET) &amp;&amp; (tt-&gt;options.dns_len =3D=3D 0)))</span><b=
r><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 return true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  /* nothing to do */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        goto out;</span><br><span>     }</span><br><span> </span><br><spa=
n>     /* Use dns_cfg_msg with domain =3D &quot;&quot; for setting only the=
 DNS servers */</span><br><span>@@ -272,26 +270,23 @@</span><br><span>     =
}</span><br><span> </span><br><span>     msg(M_INFO, &quot;%s dns servers %=
s using service&quot;, ip_proto_name, (add ? &quot;set&quot; : &quot;delete=
d&quot;));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D=
 true;</span><br><span> </span><br><span> out:</span><br><span>     gc_free=
(&amp;gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static void</span><br><span> do_wins_service(bool add, const st=
ruct tuntap *tt)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    bool ret =3D false;</span><br><span>     ack_message_t ac=
k;</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>  =
   HANDLE pipe =3D tt-&gt;options.msg_channel;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int len =3D tt-&gt;options.wins_len;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    int addr_len =3D add ? len =
: 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int addr_le=
n =3D add ? tt-&gt;options.wins_len : 0;</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    if (addr_len =3D=3D 0 &amp;&amp; a=
dd) /* no addresses to add */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (tt-&gt;options.wins_len =3D=3D 0)</span><br><span>     {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return true;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* nothing to=
 do */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto =
out;</span><br><span>     }</span><br><span> </span><br><span>     wins_cfg=
_message_t wins =3D {</span><br><span>@@ -338,11 +333,9 @@</span><br><span>=
     }</span><br><span> </span><br><span>     msg(M_INFO, &quot;WINS server=
s %s using service&quot;, (add ? &quot;set&quot; : &quot;deleted&quot;));</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D true;</span=
><br><span> </span><br><span> out:</span><br><span>     gc_free(&amp;gc);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><=
br><span> }</span><br><span> </span><br><span> static bool</span><br><span>=
@@ -7019,10 +7012,7 @@</span><br><span>             {</span><br><span>     =
            do_dns_domain_service(false, tt);</span><br><span>             =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (tt-&=
gt;options.dns6_len &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
              do_dns_service(false, AF_INET6, tt);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            do_dns_service(false, AF_INET6, tt);</sp=
an><br><span>             delete_route_connected_v6_net(tt);</span><br><spa=
n>             do_address_service(false, AF_INET6, tt);</span><br><span>   =
      }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail">change 482</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schem=
a.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://s=
chema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/482?usp=3Demail"/><meta itemprop=3D"name" content=3D"View C=
hange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I21a36d24f8e213c780f55acbe3e=
4df555c93542a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 482 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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


--XLTM/XBR/mY=--

