From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 6 Oct 2025 13:22:11 +0000
In-Reply-To: <gerrit.1758030602000.I88e16e15fad065cb310d38f09924053efc3a6ce5@...2715...>
References: <gerrit.1758030602000.I88e16e15fad065cb310d38f09924053efc3a6ce5@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <9680e7bb0cd590ea50c5ffe817c53deb79d130da-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MdGVL8jBDAM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allowing installing
 FreeBSD routes with interface instead of next-hop
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MdGVL8jBDAM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello cron2, flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1193?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: Allowing installing FreeBSD routes with interface instead o=
f next-hop
......................................................................

Allowing installing FreeBSD routes with interface instead of next-hop

This matches the Linux behaviour of the net_route add/delete commands

Change-Id: I88e16e15fad065cb310d38f09924053efc3a6ce5
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/networking_freebsd.c
1 file changed, 35 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/93/1193/4

diff --git a/src/openvpn/networking_freebsd.c b/src/openvpn/networking_free=
bsd.c
index b47444c..b020f51 100644
--- a/src/openvpn/networking_freebsd.c
+++ b/src/openvpn/networking_freebsd.c
@@ -15,17 +15,29 @@
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
+    /* if gw is NULL we are installing a route with the interface as
+     * target instead */
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

@@ -38,14 +50,26 @@
 {
     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRSTRLEN];
     struct argv argv =3D argv_new();
-    bool status;
=20
-    argv_printf(&argv, "%s -6 %s -net %s/%d %s -fib %d", ROUTE_PATH, op,
-                inet_ntop(AF_INET6, dst, buf1, sizeof(buf1)), prefixlen,
-                inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), table);
+    ASSERT(gw || iface);
+    /* if gw is NULL, we are installing a route with the interface as targ=
et
+     * instead */
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
=20
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I88e16e15fad065cb310d38f09924053efc3a6ce5
Gerrit-Change-Number: 1193
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--MdGVL8jBDAM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1193?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Allowing installing FreeBSD routes =
with interface instead of next-hop<br><br>This matches the Linux behaviour =
of the net_route add/delete commands<br><br>Change-Id: I88e16e15fad065cb310=
d38f09924053efc3a6ce5<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt=
;<br>---<br>M src/openvpn/networking_freebsd.c<br>1 file changed, 35 insert=
ions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/93/1193/4</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/networking_freebsd.c b/src/openvpn/networking_freebsd.c</span><br><sp=
an>index b47444c..b020f51 100644</span><br><span>--- a/src/openvpn/networki=
ng_freebsd.c</span><br><span>+++ b/src/openvpn/networking_freebsd.c</span><=
br><span>@@ -15,17 +15,29 @@</span><br><span>     char buf1[INET_ADDRSTRLEN=
], buf2[INET_ADDRSTRLEN];</span><br><span>     in_addr_t _dst, _gw;</span><=
br><span>     struct argv argv =3D argv_new();</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    bool status;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    ASSERT(gw || iface);</span><br><span> </span><br><span>     _dst =3D=
 ntohl(*dst);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    _gw =
=3D ntohl(*gw);</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s -fib %d&qu=
ot;, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefixlen=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                inet=
_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)), table);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* if gw is NULL we are installing a =
route with the interface as</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+     * target instead */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    if (gw)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        _=
gw =3D ntohl(*gw);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       argv_printf(&amp;argv, &quot;%s %s -net %s/%d %s -fib %d&quot;, ROUT=
E_PATH, op,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefixlen,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    i=
net_ntop(AF_INET, &amp;_gw, buf2, sizeof(buf2)), table);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      argv_printf(&amp;argv, &quot;%s %s -net %s/%d -iface %s -fib %d&quot;=
, ROUTE_PATH, op,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                  inet_ntop(AF_INET, &amp;_dst, buf1, sizeof(buf1)), prefix=
len,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     iface, table);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span> </span><br><span>     argv_msg(M_INFO, &amp;argv);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D openvpn_=
execve_check(&amp;argv, NULL, 0, &quot;ERROR: FreeBSD route command failed&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool sta=
tus =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: FreeBSD route=
 command failed&quot;);</span><br><span> </span><br><span>     argv_free(&a=
mp;argv);</span><br><span> </span><br><span>@@ -38,14 +50,26 @@</span><br><=
span> {</span><br><span>     char buf1[INET6_ADDRSTRLEN], buf2[INET6_ADDRST=
RLEN];</span><br><span>     struct argv argv =3D argv_new();</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    bool status;</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    argv_printf(&amp;ar=
gv, &quot;%s -6 %s -net %s/%d %s -fib %d&quot;, ROUTE_PATH, op,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                inet_ntop(AF_INET=
6, dst, buf1, sizeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                inet_ntop(AF_INET6, gw, buf2, sizeof(buf2=
)), table);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSE=
RT(gw || iface);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* if gw is NULL, we are installing a route with the interface as target</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * instead */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (gw)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s -6 %s=
 -net %s/%d %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    inet_ntop(AF_INET6, dst, buf1=
, sizeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                    inet_ntop(AF_INET6, gw, buf2, sizeof(buf2)), ta=
ble);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    else</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        argv_printf(&amp;argv, &quot;%s -6 %s -net %s=
/%d -iface %s -fib %d&quot;, ROUTE_PATH, op,</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                    inet_ntop(AF_INET6, dst, buf1,=
 sizeof(buf1)), prefixlen,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                    iface, table);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> </span><br><span>     argv_msg(M_INFO, &amp;argv)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D openv=
pn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: FreeBSD route command fail=
ed&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool =
status =3D openvpn_execve_check(&amp;argv, NULL, 0, &quot;ERROR: FreeBSD ro=
ute command failed&quot;);</span><br><span> </span><br><span>     argv_free=
(&amp;argv);</span><br><span> </span><br><span></span><br></pre><p>To view,=
 visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1193?usp=3Demail">c=
hange 1193</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1193?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I88e16e15fad065cb310d38f0992=
4053efc3a6ce5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1193 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--MdGVL8jBDAM=--

