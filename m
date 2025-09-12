From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 12 Sep 2025 15:24:02 +0000
In-Reply-To: <gerrit.1757408812000.Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b@...2715...>
References: <gerrit.1757408812000.Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <744a3d191f734bde7ca498f081eacd187858135d-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KZmpVFAiF4g="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Multi-socket win:
 avoid repeated socket_set()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KZmpVFAiF4g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/1174?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


Change subject: Multi-socket win: avoid repeated socket_set()
......................................................................

Multi-socket win: avoid repeated socket_set()

On Windows, multi-socket support failed with mixed protocols due
to repeated socket_set() calls, which caused accept() to be triggered
before having an event to process.  This fix skips socket_set()
calls for non-UDP sockets in MODE_SERVER inside multi_io_process_flags().

Change-Id: Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Message-Id: <20250912131207.42597-1-frank@...2641...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59232443/
URL: https://gerrit.openvpn.net/c/openvpn/+/1174
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
1 file changed, 6 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1174/4

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 03b6a0c..5d22fa3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2121,10 +2121,15 @@
=20
     /*
      * Configure event wait based on socket, tuntap flags.
+     * (for TCP server sockets this happens in
+     *  socket_set_listen_persistent()).
      */
     for (int i =3D 0; i < c->c1.link_sockets_num; i++)
     {
-        socket_set(c->c2.link_sockets[i], es, socket, &c->c2.link_sockets[=
i]->ev_arg, NULL);
+        if ((c->options.mode !=3D MODE_SERVER) || (proto_is_dgram(c->c2.li=
nk_sockets[i]->info.proto)))
+        {
+            socket_set(c->c2.link_sockets[i], es, socket, &c->c2.link_sock=
ets[i]->ev_arg, NULL);
+        }
     }

     tun_set(c->c1.tuntap, es, tuntap, (void *)tun_shift, NULL);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1174?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b
Gerrit-Change-Number: 1174
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--KZmpVFAiF4g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1174?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Multi-socket win: avoid repeated socket_set()<br><br=
>On Windows, multi-socket support failed with mixed protocols due<br>to rep=
eated socket_set() calls, which caused accept() to be triggered<br>before h=
aving an event to process.  This fix skips socket_set()<br>calls for non-UD=
P sockets in MODE_SERVER inside multi_io_process_flags().<br><br>Change-Id:=
 Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b<br>Signed-off-by: Gianmarco De G=
regori &lt;gianmarco@...2726...&gt;<br>Acked-by: Lev Stipakov &lt;lstipakov=
@...277...&gt;<br>Message-Id: &lt;20250912131207.42597-1-frank@...2641...&g=
t;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/59232443/<br>U=
RL: https://gerrit.openvpn.net/c/openvpn/+/1174<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/forward.c<br>1 file cha=
nged, 6 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/74/1174/4</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/forward.c b/src/openvpn/forward.c</span><br><span>index 03b6a0c..5d22fa3 1=
00644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src=
/openvpn/forward.c</span><br><span>@@ -2121,10 +2121,15 @@</span><br><span>=
 </span><br><span>     /*</span><br><span>      * Configure event wait base=
d on socket, tuntap flags.</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * (for TCP server sockets this happens in</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     *  socket_set_listen_persistent()).<=
/span><br><span>      */</span><br><span>     for (int i =3D 0; i &lt; c-&g=
t;c1.link_sockets_num; i++)</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        socket_set(c-&gt;c2.link_sockets[i], e=
s, socket, &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg, NULL);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if ((c-&gt;options.mode !=
=3D MODE_SERVER) || (proto_is_dgram(c-&gt;c2.link_sockets[i]-&gt;info.proto=
)))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            socket_set(c-&=
gt;c2.link_sockets[i], es, socket, &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg=
, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</=
span><br><span>     }</span><br><span> </span><br><span>     tun_set(c-&gt;=
c1.tuntap, es, tuntap, (void *)tun_shift, NULL);</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
174?usp=3Demail">change 1174</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1174?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia389fcec50fb2bbc0aa5ad41a2c=
23c17c04e6e9b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1174 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--KZmpVFAiF4g=--

