From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 6 Oct 2025 16:57:15 +0000
In-Reply-To: <gerrit.1758030602000.I88e16e15fad065cb310d38f09924053efc3a6ce5@...2715...>
References: <gerrit.1758030602000.I88e16e15fad065cb310d38f09924053efc3a6ce5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <cc3511965b2516e3ac77653ecf2c4ac4ef9e1775-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tNf8XDdDBkk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Allowing installing
 FreeBSD routes with interface instead of next-hop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tNf8XDdDBkk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
93?usp=3Demail )

Change subject: Allowing installing FreeBSD routes with interface instead o=
f next-hop
......................................................................

Allowing installing FreeBSD routes with interface instead of next-hop

This matches the Linux behaviour of the net_route add/delete commands

Change-Id: I88e16e15fad065cb310d38f09924053efc3a6ce5
Signed-off-by: Arne Schwabe <arne@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1193
Message-Id: <20251006145844.27794-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59242876/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/networking_freebsd.c
1 file changed, 40 insertions(+), 11 deletions(-)




diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_free=
bsd.c
index b47444c..04051a6 100644
--- a/src/openvpn/networking_freebsd.c
+++ b/src/openvpn/networking_freebsd.c
@@ -15,17 +15,31 @@
     char buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];
     in_addr_t _dst, _gw;
     struct argv argv =3D argv_new();
-    bool status;
+
+    ASSERT(gw || iface);

     _dst =3D ntohl(*dst);
-    _gw =3D ntohl(*gw);

-    argv_printf(&argv, "%s %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
-                inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixlen,
-                inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)), table);
+    /* if we have a gateway (GW !=3D NULL) install route to gateway IP
+     * if not, install "connected" route to interface
+     * (needed to make 'ifconfig-push IPs outside server subnet' work)
+     */
+    if (gw)
+    {
+        _gw =3D ntohl(*gw);
+        argv_printf(&argv, "%s %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
+                    inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixl=
en,
+                    inet_ntop(AF_INET, &_gw, buf2, sizeof(buf2)), table);
+    }
+    else
+    {
+        argv_printf(&argv, "%s %s -net %s/%d -iface %s -fib %d", ROUTE_PAT=
H, op,
+                    inet_ntop(AF_INET, &_dst, buf1, sizeof(buf1)), prefixl=
en,
+                    iface, table);
+    }

     argv_msg(M_INFO, &argv);
-    status =3D openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD route =
command failed");
+    bool status =3D openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD r=
oute command failed");

     argv_free(&argv);

@@ -38,14 +52,29 @@
 {
     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];
     struct argv argv =3D argv_new();
-    bool status;

-    argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
-                inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-                inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);
+    ASSERT(gw || iface);
+
+    /* if we have a gateway (GW !=3D NULL) install route to gateway IP
+     * if not, install "connected" route to interface
+     * (needed to make 'ifconfig-push IPs outside server subnet' work)
+     */
+    if (gw)
+    {
+        argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d", ROUTE_PATH, o=
p,
+                    inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixle=
n,
+                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);
+    }
+    else
+    {
+        argv_printf(&argv, "%s -6 %s -net %s/%d -iface %s -fib %d", ROUTE_=
PATH, op,
+                    inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixle=
n,
+                    iface, table);
+    }
+

     argv_msg(M_INFO, &argv);
-    status =3D openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD route =
command failed");
+    bool status =3D openvpn_execve_check(&argv, NULL, 0, "ERROR: FreeBSD r=
oute command failed");

     argv_free(&argv);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1193?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88e16e15fad065cb310d38f09924053efc3a6ce5
Gerrit-Change-Number: 1193
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tNf8XDdDBkk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1193?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Allowing installing FreeBSD routes with interfac=
e instead of next-hop<br><br>This matches the Linux behaviour of the net_ro=
ute add/delete commands<br><br>Change-Id: I88e16e15fad065cb310d38f09924053e=
fc3a6ce5<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Gerrit U=
RL: https://gerrit.openvpn.net/c/openvpn/+/1193<br>Message-Id: &lt;20251006=
145844.27794-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvp=
n/mailman/message/59242876/<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M src/openvpn/networking_freebsd.c<br>1 file changed, 40 =
insertions(+), 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_f=
reebsd.c</span><br><span>index b47444c..04051a6 100644</span><br><span>--- =
a/src/openvpn/networking_freebsd.c</span><br><span>+++ b/src/openvpn/networ=
king_freebsd.c</span><br><span>@@ -15,17 +15,31 @@</span><br><span>     cha=
r buf1[INET_ADDRSTRLEN], buf2[INET_ADDRSTRLEN];</span><br><span>     in_add=
r_t _dst, _gw;</span><br><span>     struct argv argv =3D argv_new();</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    bool status;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    ASSERT(gw || iface);</span><br><span> </span><=
br><span>     _dst =3D ntohl(*dst);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    _gw =3D ntohl(*gw);</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;argv, &quot;%s %s -n=
et %s/%d %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                inet_ntop(AF_INET, &amp;_dst, buf1, si=
zeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                inet_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)), table);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* if we have a=
 gateway (GW !=3D NULL) install route to gateway IP</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * if not, install &quot;connected&qu=
ot; route to interface</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+     * (needed to make &#39;ifconfig-push IPs outside server subnet&#39;=
 work)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (gw)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        _gw =3D ntohl(*gw);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s=
 %s -net %s/%d %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    inet_ntop(AF_INET, &amp;_d=
st, buf1, sizeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    inet_ntop(AF_INET, &amp;_gw, buf2, size=
of(buf2)), table);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s =
%s -net %s/%d -iface %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    inet_ntop(AF_INET, &=
amp;_dst, buf1, sizeof(buf1)), prefixlen,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    iface, table);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> </span><br><spa=
n>     argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    status =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot=
;ERROR: FreeBSD route command failed&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    bool status =3D openvpn_execve_check(&amp;argv=
, NULL, 0, &quot;ERROR: FreeBSD route command failed&quot;);</span><br><spa=
n> </span><br><span>     argv_free(&amp;argv);</span><br><span> </span><br>=
<span>@@ -38,14 +52,29 @@</span><br><span> {</span><br><span>     char buf1=
[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];</span><br><span>     struct arg=
v argv =3D argv_new();</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    bool status;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    argv_printf(&amp;argv, &quot;%s -6 %s -net %s/%d %s -fib =
%d&quot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-                inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                inet=
_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    ASSERT(gw || iface);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* if we have a gateway (GW !=3D NULL) install route to =
gateway IP</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * if=
 not, install &quot;connected&quot; route to interface</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+     * (needed to make &#39;ifconfig-pus=
h IPs outside server subnet&#39; work)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    if (gw)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_pr=
intf(&amp;argv, &quot;%s -6 %s -net %s/%d %s -fib %d&quot;, ROUTE_PATH, op,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    inet_ntop(AF_INET=
6, gw, buf2, sizeof(buf2)), table);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        argv_printf(&am=
p;argv, &quot;%s -6 %s -net %s/%d -iface %s -fib %d&quot;, ROUTE_PATH, op,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    iface, table);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span>  =
   argv_msg(M_INFO, &amp;argv);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    status =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERR=
OR: FreeBSD route command failed&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    bool status =3D openvpn_execve_check(&amp;argv, NU=
LL, 0, &quot;ERROR: FreeBSD route command failed&quot;);</span><br><span> <=
/span><br><span>     argv_free(&amp;argv);</span><br><span> </span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1193?usp=3Demail">change 1193</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1193?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88e16e15fad065cb310d38f0992=
4053efc3a6ce5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1193 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--tNf8XDdDBkk=--

