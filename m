From: "stipa (Code Review)" <gerrit@...515...>
Date: Tue, 31 Dec 2024 10:54:07 +0000
In-Reply-To: <gerrit.1732212459000.I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4@...2715...>
References: <gerrit.1732212459000.I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <f84fb3593d91f5629c7ce697d2f4012825060db5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/qAXKyDhQ6s="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/qAXKyDhQ6s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail

to look at the new patch set (#7).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: dco-win: simplify do_close_link_socket()
......................................................................

dco-win: simplify do_close_link_socket()

c->c2.link_socket_owned is true in client mode
and for the global context in the server mode -
those are exactly the cases when we want to
set sd to undefined when using dco-win.

Change-Id: I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/init.c
1 file changed, 8 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/813/7

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
Gerrit-PatchSet: 7
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--/qAXKyDhQ6s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p>stipa <strong>uploaded patch set #7</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">dco-win: simplify do_close_link_socket()<br><br>c-&g=
t;c2.link_socket_owned is true in client mode<br>and for the global context=
 in the server mode -<br>those are exactly the cases when we want to<br>set=
 sd to undefined when using dco-win.<br><br>Change-Id: I3232dd8d855ca3f198b=
4ca3b2ef4f67cec49f3d4<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<=
br>---<br>M src/openvpn/init.c<br>1 file changed, 8 insertions(+), 11 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/13/813/7</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/init.c</=
span><br><span>index 850cd12..2bd5518 100644</span><br><span>--- a/src/open=
vpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span>@@ -401=
8,21 +4018,18 @@</span><br><span> static void</span><br><span> do_close_lin=
k_socket(struct context *c)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    /* in dco-win case, link socket is a tun handl=
e which is</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * clos=
ed in do_close_tun(). Set it to UNDEFINED so</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * we won&#39;t use WinSock API to close it. */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (tuntap_is_dco_=
win(c-&gt;c1.tuntap) &amp;&amp; c-&gt;c2.link_sockets)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num=
; i++)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2.link_s=
ockets[i]-&gt;sd =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span>     if (c-&gt;c2.link_sockets &amp;&amp; c-&gt;c2.link_socket_owned)=
</span><br><span>     {</span><br><span>         for (int i =3D 0; i &lt; c=
-&gt;c1.link_sockets_num; i++)</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            /* in dco-win case, link =
socket is a tun handle which is</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+             * closed in do_close_tun(). Set it to UNDEFINED so=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * we w=
on&#39;t use WinSock API to close it. */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            if (tuntap_is_dco_win(c-&gt;c1.tuntap))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                c-&gt;c2.lin=
k_sockets[i]-&gt;sd =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>             link_socket_close(c-&gt;c2.li=
nk_sockets[i]);</span><br><span>         }</span><br><span>         c-&gt;c=
2.link_sockets =3D NULL;</span><br><span></span><br></pre><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail">change 8=
13</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3232dd8d855ca3f198b4ca3b2ef=
4f67cec49f3d4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 813 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--/qAXKyDhQ6s=--

