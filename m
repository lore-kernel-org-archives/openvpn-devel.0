From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 21 Dec 2023 13:48:28 +0000
In-Reply-To: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
References: <gerrit.1702561084000.I21a36d24f8e213c780f55acbe3e4df555c93542a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <a304c853180c12e075230e85521899a9825713b0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+HrtOogUIB0="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: d12fk <heiko@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+HrtOogUIB0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/482?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/82/482/3

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
=20
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
Gerrit-MessageType: newpatchset

--+HrtOogUIB0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/482?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">tun.c: don&#39;t attempt to delete DNS and WI=
NS servers if they&#39;re not set<br><br>Commits<br><br>    1c4a47f7 (&quot=
;wintun: set adapter properties via interactive service&quot;)<br>    18826=
de5 (&quot;Set WINS servers via interactice service&quot;)<br><br>added fun=
ctionality of add/remove DNS/WINS via interactive<br>service, which is used=
 mostly by dco-win and wintun (tap-windows6<br>normally uses DHCP). There i=
s a check in code - if DNS/WINS addresses<br>are not pushed, nothing is add=
ed.<br><br>However, due to bug we always attempted to remove DNS/WINS,<br>e=
ven if nothing was added. Removing WINS, for example, could take<br>up to 3=
 seconds.<br><br>This change fixes this by improving check &quot;has DNS/WI=
NS been pushed?&quot;.<br><br>While on it, convert do_XXX_service() functio=
ns to &quot;void&quot; from &quot;bool&quot;,<br>since we never check their=
 return values.<br><br>Change-Id: I21a36d24f8e213c780f55acbe3e4df555c93542a=
<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20231220133637.60996-=
1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg27843.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M src/openvpn/tun.c<br>1 file changed, 12 insertio=
ns(+), 23 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/82/482/3</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/tun.c b/src/op=
envpn/tun.c</span><br><span>index f1b8699..8e96149 100644</span><br><span>-=
-- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><s=
pan>@@ -147,17 +147,16 @@</span><br><span>     return ret;</span><br><span>=
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-s=
tatic bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static vo=
id</span><br><span> do_dns_domain_service(bool add, const struct tuntap *tt=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   bool ret =3D false;</span><br><span>     ack_message_t ack;</span><br><s=
pan>     struct gc_arena gc =3D gc_new();</span><br><span>     HANDLE pipe =
=3D tt-&gt;options.msg_channel;</span><br><span> </span><br><span>     if (=
!tt-&gt;options.domain) /* no  domain to add or delete */</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return t=
rue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto ou=
t;</span><br><span>     }</span><br><span> </span><br><span>     /* Use dns=
_cfg_msg with addr_len =3D 0 for setting only the DOMAIN */</span><br><span=
>@@ -195,17 +194,14 @@</span><br><span>     }</span><br><span> </span><br><=
span>     msg(M_INFO, &quot;DNS domain %s using service&quot;, (add ? &quot=
;set&quot; : &quot;deleted&quot;));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ret =3D true;</span><br><span> </span><br><span> out:</sp=
an><br><span>     gc_free(&amp;gc);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    return ret;</span><br><span> }</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span> do_dns_se=
rvice(bool add, const short family, const struct tuntap *tt)</span><br><spa=
n> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool ret =3D =
false;</span><br><span>     ack_message_t ack;</span><br><span>     struct =
gc_arena gc =3D gc_new();</span><br><span>     HANDLE pipe =3D tt-&gt;optio=
ns.msg_channel;</span><br><span>@@ -213,9 +209,10 @@</span><br><span>     i=
nt addr_len =3D add ? len : 0;</span><br><span>     const char *ip_proto_na=
me =3D family =3D=3D AF_INET6 ? &quot;IPv6&quot; : &quot;IPv4&quot;;</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ad=
dr_len =3D=3D 0 &amp;&amp; add) /* no addresses to add */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (len =3D=3D 0)</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return=
 true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* no=
thing to do */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   goto out;</span><br><span>     }</span><br><span> </span><br><span>     =
/* Use dns_cfg_msg with domain =3D &quot;&quot; for setting only the DNS se=
rvers */</span><br><span>@@ -272,26 +269,23 @@</span><br><span>     }</span=
><br><span> </span><br><span>     msg(M_INFO, &quot;%s dns servers %s using=
 service&quot;, ip_proto_name, (add ? &quot;set&quot; : &quot;deleted&quot;=
));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D true;<=
/span><br><span> </span><br><span> out:</span><br><span>     gc_free(&amp;g=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</s=
pan><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-static bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span> do_wins_service(bool add, const struct tu=
ntap *tt)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    bool ret =3D false;</span><br><span>     ack_message_t ack;</spa=
n><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     HAND=
LE pipe =3D tt-&gt;options.msg_channel;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    int len =3D tt-&gt;options.wins_len;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    int addr_len =3D add ? len : 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    int addr_len =3D a=
dd ? tt-&gt;options.wins_len : 0;</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (addr_len =3D=3D 0 &amp;&amp; add) /=
* no addresses to add */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (tt-&gt;options.wins_len =3D=3D 0)</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        return true;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* nothing to do *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out;<=
/span><br><span>     }</span><br><span> </span><br><span>     wins_cfg_mess=
age_t wins =3D {</span><br><span>@@ -338,11 +332,9 @@</span><br><span>     =
}</span><br><span> </span><br><span>     msg(M_INFO, &quot;WINS servers %s =
using service&quot;, (add ? &quot;set&quot; : &quot;deleted&quot;));</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    ret =3D true;</span><br>=
<span> </span><br><span> out:</span><br><span>     gc_free(&amp;gc);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    return ret;</span><br><s=
pan> }</span><br><span> </span><br><span> static bool</span><br><span>@@ -7=
019,10 +7011,7 @@</span><br><span>             {</span><br><span>          =
       do_dns_domain_service(false, tt);</span><br><span>             }</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (tt-&gt;op=
tions.dns6_len &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
         do_dns_service(false, AF_INET6, tt);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            }</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            do_dns_service(false, AF_INET6, tt);</span><b=
r><span>             delete_route_connected_v6_net(tt);</span><br><span>   =
          do_address_service(false, AF_INET6, tt);</span><br><span>        =
 }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/482?usp=3Demail">change 482</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/482?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--+HrtOogUIB0=--

