From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 31 Dec 2024 15:31:12 +0000
In-Reply-To: <gerrit.1732212459000.I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4@...2715...>
References: <gerrit.1732212459000.I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <b5167f48081a7342f12e8eb06730b70605b15f6c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0iJBTATFrK8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco-win: simplify
 do_close_link_socket()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--0iJBTATFrK8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#8) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dco-win: simplify do_close_link_socket()
......................................................................

dco-win: simplify do_close_link_socket()

c->c2.link_socket_owned is true in client mode
and for the global context in the server mode -
those are exactly the cases when we want to
set sd to undefined when using dco-win.

Change-Id: I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241231145417.12128-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
328.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/init.c
1 file changed, 8 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/813/8

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 850cd12..2bd5518 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4018,21 +4018,18 @@
 static void
 do_close_link_socket(struct context *c)
 {
-    /* in dco-win case, link socket is a tun handle which is
-     * closed in do_close_tun(). Set it to UNDEFINED so
-     * we won't use WinSock API to close it. */
-    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_sockets)
-    {
-        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
-        {
-            c->c2.link_sockets[i]->sd =3D SOCKET_UNDEFINED;
-        }
-    }
-
     if (c->c2.link_sockets && c->c2.link_socket_owned)
     {
         for (int i =3D 0; i < c->c1.link_sockets_num; i++)
         {
+            /* in dco-win case, link socket is a tun handle which is
+             * closed in do_close_tun(). Set it to UNDEFINED so
+             * we won't use WinSock API to close it. */
+            if (tuntap_is_dco_win(c->c1.tuntap))
+            {
+                c->c2.link_sockets[i]->sd =3D SOCKET_UNDEFINED;
+            }
+
             link_socket_close(c->c2.link_sockets[i]);
         }
         c->c2.link_sockets =3D NULL;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4
Gerrit-Change-Number: 813
Gerrit-PatchSet: 8
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--0iJBTATFrK8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #8</strong> to the change originally cr=
eated by stipa.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/813?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco-win: simplify do_close_link_socket()<br><br>c-&g=
t;c2.link_socket_owned is true in client mode<br>and for the global context=
 in the server mode -<br>those are exactly the cases when we want to<br>set=
 sd to undefined when using dco-win.<br><br>Change-Id: I3232dd8d855ca3f198b=
4ca3b2ef4f67cec49f3d4<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<=
br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;202412=
31145417.12128-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/o=
penvpn-devel@lists.sourceforge.net/msg30328.html<br>Signed-off-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/init.c<br>1 file chang=
ed, 8 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/13/813/8</pre><pre style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/=
init.c b/src/openvpn/init.c</span><br><span>index 850cd12..2bd5518 100644</=
span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/i=
nit.c</span><br><span>@@ -4018,21 +4018,18 @@</span><br><span> static void<=
/span><br><span> do_close_link_socket(struct context *c)</span><br><span> {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* in dco-win cas=
e, link socket is a tun handle which is</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-     * closed in do_close_tun(). Set it to UNDEFINED so</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * we won&#39;t use=
 WinSock API to close it. */</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (tuntap_is_dco_win(c-&gt;c1.tuntap) &amp;&amp; c-&gt;c2.link_=
sockets)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        for (int i =3D 0; i &=
lt; c-&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            c-&gt;c2.link_sockets[i]-&gt;sd =3D SOCKET_UNDEFINED;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-</span><br><span>     if (c-&gt;c2.link_sockets &amp;&amp=
; c-&gt;c2.link_socket_owned)</span><br><span>     {</span><br><span>      =
   for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span=
>         {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    /* in dco-win case, link socket is a tun handle which is</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+             * closed in do_close_=
tun(). Set it to UNDEFINED so</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             * we won&#39;t use WinSock API to close it. */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (tuntap_is=
_dco_win(c-&gt;c1.tuntap))</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                c-&gt;c2.link_sockets[i]-&gt;sd =3D SOCKET_UNDEFINED;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>             =
link_socket_close(c-&gt;c2.link_sockets[i]);</span><br><span>         }</sp=
an><br><span>         c-&gt;c2.link_sockets =3D NULL;</span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/813?usp=3Demail">change 813</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/813?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3232dd8d855ca3f198b4ca3b2ef=
4f67cec49f3d4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 813 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--0iJBTATFrK8=--

