From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 21 Dec 2023 13:48:30 +0000
In-Reply-To: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
References: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <a304c853180c12e075230e85521899a9825713b0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ehW2C77Nhyw="; charset=UTF-8
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
To: stipa <lstipakov@...277...>
Cc: flichtenheld <frank@...2641...>, d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ehW2C77Nhyw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/48=
2?usp=3Demail )

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
even if nothing was added. Removing WINS, for example, could take
up to 3 seconds.

This change fixes this by improving check "has DNS/WINS been pushed?".

While on it, convert do_XXX_service() functions to "void" from "bool",
since we never check their return values.

Change-Id: I21a36d24f8e213c780f55acbe3e4df555c93542a
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20231220133637.60996-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
843.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
1 file changed, 12 insertions(+), 23 deletions(-)




diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f1b8699..8e96149 100644
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
@@ -213,9 +209,10 @@
     int addr_len =3D add ? len : 0;
     const char *ip_proto_name =3D family =3D=3D AF_INET6 ? "IPv6" : "IPv4";

-    if (addr_len =3D=3D 0 && add) /* no addresses to add */
+    if (len =3D=3D 0)
     {
-        return true;
+        /* nothing to do */
+        goto out;
     }

     /* Use dns_cfg_msg with domain =3D "" for setting only the DNS servers=
 */
@@ -272,26 +269,23 @@
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
@@ -338,11 +332,9 @@
     }

     msg(M_INFO, "WINS servers %s using service", (add ? "set" : "deleted")=
);
-    ret =3D true;

 out:
     gc_free(&gc);
-    return ret;
 }

 static bool
@@ -7019,10 +7011,7 @@
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
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--ehW2C77Nhyw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/482?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">tun.c: don&#39;t attempt to delete DNS and WIN=
S servers if they&#39;re not set<br><br>Commits<br><br>    1c4a47f7 (&quot;=
wintun: set adapter properties via interactive service&quot;)<br>    18826d=
e5 (&quot;Set WINS servers via interactice service&quot;)<br><br>added func=
tionality of add/remove DNS/WINS via interactive<br>service, which is used =
mostly by dco-win and wintun (tap-windows6<br>normally uses DHCP). There is=
 a check in code - if DNS/WINS addresses<br>are not pushed, nothing is adde=
d.<br><br>However, due to bug we always attempted to remove DNS/WINS,<br>ev=
en if nothing was added. Removing WINS, for example, could take<br>up to 3 =
seconds.<br><br>This change fixes this by improving check &quot;has DNS/WIN=
S been pushed?&quot;.<br><br>While on it, convert do_XXX_service() function=
s to &quot;void&quot; from &quot;bool&quot;,<br>since we never check their =
return values.<br><br>Change-Id: I21a36d24f8e213c780f55acbe3e4df555c93542a<=
br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Frank Lic=
htenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20231220133637.60996-1=
-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg27843.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file changed, 12 insertion=
s(+), 23 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index=
 f1b8699..8e96149 100644</span><br><span>--- a/src/openvpn/tun.c</span><br>=
<span>+++ b/src/openvpn/tun.c</span><br><span>@@ -147,17 +147,16 @@</span><=
br><span>     return ret;</span><br><span> }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> do_dns_domai=
n_service(bool add, const struct tuntap *tt)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br=
><span>     ack_message_t ack;</span><br><span>     struct gc_arena gc =3D =
gc_new();</span><br><span>     HANDLE pipe =3D tt-&gt;options.msg_channel;<=
/span><br><span> </span><br><span>     if (!tt-&gt;options.domain) /* no  d=
omain to add or delete */</span><br><span>     {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        return true;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        goto out;</span><br><span>     }</span>=
<br><span> </span><br><span>     /* Use dns_cfg_msg with addr_len =3D 0 for=
 setting only the DOMAIN */</span><br><span>@@ -195,17 +194,14 @@</span><br=
><span>     }</span><br><span> </span><br><span>     msg(M_INFO, &quot;DNS =
domain %s using service&quot;, (add ? &quot;set&quot; : &quot;deleted&quot;=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D true;<=
/span><br><span> </span><br><span> out:</span><br><span>     gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span> do_dns_service(bool add, const short fami=
ly, const struct tuntap *tt)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    bool ret =3D false;</span><br><span>     ack_=
message_t ack;</span><br><span>     struct gc_arena gc =3D gc_new();</span>=
<br><span>     HANDLE pipe =3D tt-&gt;options.msg_channel;</span><br><span>=
@@ -213,9 +209,10 @@</span><br><span>     int addr_len =3D add ? len : 0;</=
span><br><span>     const char *ip_proto_name =3D family =3D=3D AF_INET6 ? =
&quot;IPv6&quot; : &quot;IPv4&quot;;</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (addr_len =3D=3D 0 &amp;&amp; add) =
/* no addresses to add */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (len =3D=3D 0)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        return true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* nothing to do */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        goto out;</span><br><span>   =
  }</span><br><span> </span><br><span>     /* Use dns_cfg_msg with domain =
=3D &quot;&quot; for setting only the DNS servers */</span><br><span>@@ -27=
2,26 +269,23 @@</span><br><span>     }</span><br><span> </span><br><span>  =
   msg(M_INFO, &quot;%s dns servers %s using service&quot;, ip_proto_name, =
(add ? &quot;set&quot; : &quot;deleted&quot;));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    ret =3D true;</span><br><span> </span><br><sp=
an> out:</span><br><span>     gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return ret;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><spa=
n> do_wins_service(bool add, const struct tuntap *tt)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D false;<=
/span><br><span>     ack_message_t ack;</span><br><span>     struct gc_aren=
a gc =3D gc_new();</span><br><span>     HANDLE pipe =3D tt-&gt;options.msg_=
channel;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int len =
=3D tt-&gt;options.wins_len;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    int addr_len =3D add ? len : 0;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    int addr_len =3D add ? tt-&gt;options.wins_len :=
 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    if (addr_len =3D=3D 0 &amp;&amp; add) /* no addresses to add */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tt-&gt;options.wins=
_len =3D=3D 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        return true;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        /* nothing to do */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        goto out;</span><br><span>     }</span><br=
><span> </span><br><span>     wins_cfg_message_t wins =3D {</span><br><span=
>@@ -338,11 +332,9 @@</span><br><span>     }</span><br><span> </span><br><s=
pan>     msg(M_INFO, &quot;WINS servers %s using service&quot;, (add ? &quo=
t;set&quot; : &quot;deleted&quot;));</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    ret =3D true;</span><br><span> </span><br><span> out:</s=
pan><br><span>     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return ret;</span><br><span> }</span><br><span> </span><=
br><span> static bool</span><br><span>@@ -7019,10 +7011,7 @@</span><br><spa=
n>             {</span><br><span>                 do_dns_domain_service(fal=
se, tt);</span><br><span>             }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            if (tt-&gt;options.dns6_len &gt; 0)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                do_dns_service(false, A=
F_INET6, tt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            do=
_dns_service(false, AF_INET6, tt);</span><br><span>             delete_rout=
e_connected_v6_net(tt);</span><br><span>             do_address_service(fal=
se, AF_INET6, tt);</span><br><span>         }</span><br><span></span><br></=
pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/482?=
usp=3Demail">change 482</a>. To unsubscribe, or for help writing mail filte=
rs, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I21a36d24f8e213c780f55acbe3e=
4df555c93542a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 482 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--ehW2C77Nhyw=--

