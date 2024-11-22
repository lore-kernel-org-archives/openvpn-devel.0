From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 22 Nov 2024 15:36:03 +0000
In-Reply-To: <gerrit.1732212459000.I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4@...2715...>
References: <gerrit.1732212459000.I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <62ea5e82cbcda10c17d6ca9d639c07f36627de84-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2hYIB/AX+Bs="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2hYIB/AX+Bs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


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
1 file changed, 8 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/13/813/2

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 9371024..656fedf 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3940,16 +3940,16 @@
 static void
 do_close_link_socket(struct context *c)
 {
-    /* in dco-win case, link socket is a tun handle which is
-     * closed in do_close_tun(). Set it to UNDEFINED so
-     * we won't use WinSock API to close it. */
-    if (tuntap_is_dco_win(c->c1.tuntap) && c->c2.link_socket)
-    {
-        c->c2.link_socket->sd =3D SOCKET_UNDEFINED;
-    }
-
     if (c->c2.link_socket && c->c2.link_socket_owned)
     {
+        /* in dco-win case, link socket is a tun handle which is
+         * closed in do_close_tun(). Set it to UNDEFINED so
+         * we won't use WinSock API to close it. */
+        if (tuntap_is_dco_win(c->c1.tuntap))
+        {
+            c->c2.link_socket->sd =3D SOCKET_UNDEFINED;
+        }
+
         link_socket_close(c->c2.link_socket);
         c->c2.link_socket =3D NULL;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4
Gerrit-Change-Number: 813
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--2hYIB/AX+Bs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">dco-win: simplif=
y do_close_link_socket()<br><br>c-&gt;c2.link_socket_owned is true in clien=
t mode<br>and for the global context in the server mode -<br>those are exac=
tly the cases when we want to<br>set sd to undefined when using dco-win.<br=
><br>Change-Id: I3232dd8d855ca3f198b4ca3b2ef4f67cec49f3d4<br>Signed-off-by:=
 Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/init.c<br>1 fil=
e changed, 8 insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/13/813/2</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/init.c b/src/openvpn/init.c</span><br><span>index 9371024..656fedf 10=
0644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/ope=
nvpn/init.c</span><br><span>@@ -3940,16 +3940,16 @@</span><br><span> static=
 void</span><br><span> do_close_link_socket(struct context *c)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* in dco-w=
in case, link socket is a tun handle which is</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-     * closed in do_close_tun(). Set it to UNDEFINE=
D so</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     * we won&#39=
;t use WinSock API to close it. */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (tuntap_is_dco_win(c-&gt;c1.tuntap) &amp;&amp; c-&gt;c2=
.link_socket)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        c-&gt;c2.link_so=
cket-&gt;sd =3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>     if (c-&gt;c2.link_socket &amp;&amp; c-&gt;c2.link_socket_=
owned)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        /* in dco-win case, link socket is a tun handle which is<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * closed in=
 do_close_tun(). Set it to UNDEFINED so</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * we won&#39;t use WinSock API to close it. */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (tuntap_=
is_dco_win(c-&gt;c1.tuntap))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           c-&gt;c2.link_socket-&gt;sd =3D SOCKET_UNDEFINED;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span>         link_socket_close(=
c-&gt;c2.link_socket);</span><br><span>         c-&gt;c2.link_socket =3D NU=
LL;</span><br><span>     }</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail">change=
 813</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/813?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3232dd8d855ca3f198b4ca3b2ef=
4f67cec49f3d4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 813 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--2hYIB/AX+Bs=--

