From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 12 Sep 2025 15:24:04 +0000
In-Reply-To: <gerrit.1757408812000.Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b@...2715...>
References: <gerrit.1757408812000.Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <744a3d191f734bde7ca498f081eacd187858135d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZX0k3m9ZkXk="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ZX0k3m9ZkXk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/11=
74?usp=3Demail )

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




diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 03b6a0c..5d22fa3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2121,10 +2121,15 @@

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
Gerrit-MessageType: merged

--ZX0k3m9ZkXk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1174?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Multi-socket win: avoid repeated socket_set()=
<br><br>On Windows, multi-socket support failed with mixed protocols due<br=
>to repeated socket_set() calls, which caused accept() to be triggered<br>b=
efore having an event to process.  This fix skips socket_set()<br>calls for=
 non-UDP sockets in MODE_SERVER inside multi_io_process_flags().<br><br>Cha=
nge-Id: Ia389fcec50fb2bbc0aa5ad41a2c23c17c04e6e9b<br>Signed-off-by: Gianmar=
co De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-by: Lev Stipakov &lt;ls=
tipakov@...277...&gt;<br>Message-Id: &lt;20250912131207.42597-1-frank@...2375...=
41...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/message/5923244=
3/<br>URL: https://gerrit.openvpn.net/c/openvpn/+/1174<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/forward.c<br>1 f=
ile changed, 6 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index 03b6a0c..5d22fa3 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2121,10 +=
2121,15 @@</span><br><span> </span><br><span>     /*</span><br><span>      =
* Configure event wait based on socket, tuntap flags.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * (for TCP server sockets this happe=
ns in</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *  socket=
_set_listen_persistent()).</span><br><span>      */</span><br><span>     fo=
r (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        socket_set(=
c-&gt;c2.link_sockets[i], es, socket, &amp;c-&gt;c2.link_sockets[i]-&gt;ev_=
arg, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if ((c-&gt;options.mode !=3D MODE_SERVER) || (proto_is_dgram(c-&gt;c2.link_=
sockets[i]-&gt;info.proto)))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           socket_set(c-&gt;c2.link_sockets[i], es, socket, &amp;c-&gt;c2.l=
ink_sockets[i]-&gt;ev_arg, NULL);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span>     }</span><br><span> </span><br>=
<span>     tun_set(c-&gt;c1.tuntap, es, tuntap, (void *)tun_shift, NULL);</=
span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1174?usp=3Demail">change 1174</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1174?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

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
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--ZX0k3m9ZkXk=--

