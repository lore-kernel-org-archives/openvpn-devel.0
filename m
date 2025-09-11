From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 11 Sep 2025 14:08:24 +0000
In-Reply-To: <gerrit.1757408812000.Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b@...2715...>
References: <gerrit.1757408812000.Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a277a0486d00c29ed636ba3466861d99eac70e13-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3HzMfWsYW1o="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--3HzMfWsYW1o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1174?usp=3Demail

to look at the new patch set (#2).


Change subject: Multi-socket win: avoid repeated socket_set()
......................................................................

Multi-socket win: avoid repeated socket_set()

On Windows, multi-socket support failed with
mixed protocols due to repeated socket_set()
calls, which caused accept() to be triggered
before having an event to process.
This fix skips socket_set() calls for
non-UDP sockets in MODE_SERVER inside
multi_io_process_flags().

Change-Id: Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
1 file changed, 4 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/1174/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 03b6a0c..1552d39 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2124,7 +2124,10 @@
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
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--3HzMfWsYW1o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1174?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Multi-socket win: avoid repeated socket_set()<br><br>On Windows, mul=
ti-socket support failed with<br>mixed protocols due to repeated socket_set=
()<br>calls, which caused accept() to be triggered<br>before having an even=
t to process.<br>This fix skips socket_set() calls for<br>non-UDP sockets i=
n MODE_SERVER inside<br>multi_io_process_flags().<br><br>Change-Id: Ia389fc=
ec50fb2bbc0aa5ad41a2c23c17c04e6e9b<br>Signed-off-by: Gianmarco De Gregori &=
lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>1 file cha=
nged, 4 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/74/1174/2</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/forward.c b/src/openvpn/forward.c</span><br><span>index 03b6a0c..1552d39 1=
00644</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src=
/openvpn/forward.c</span><br><span>@@ -2124,7 +2124,10 @@</span><br><span> =
     */</span><br><span>     for (int i =3D 0; i &lt; c-&gt;c1.link_sockets=
_num; i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        socket_set(c-&gt;c2.link_sockets[i], es, socket, &amp;c=
-&gt;c2.link_sockets[i]-&gt;ev_arg, NULL);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        if ((c-&gt;options.mode !=3D MODE_SERVER) ||=
 (proto_is_dgram(c-&gt;c2.link_sockets[i]-&gt;info.proto)))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            socket_set(c-&gt;c2.link_sockets[=
i], es, socket, &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg, NULL);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>    =
 }</span><br><span> </span><br><span>     tun_set(c-&gt;c1.tuntap, es, tunt=
ap, (void *)tun_shift, NULL);</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1174?usp=3Demail">ch=
ange 1174</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1174?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia389fcec50fb2bbc0aa5ad41a2c=
23c17c04e6e9b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1174 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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


--3HzMfWsYW1o=--

