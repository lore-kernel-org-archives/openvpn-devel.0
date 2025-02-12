From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 12 Feb 2025 11:53:33 +0000
References: <gerrit.1739361204000.Id4febcceecab33ee5189cd67b249a15d12b84799@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <2b2c2ce448a19249ae4eb7c7ec9674092e2908af-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ff/JslbO5VQ="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Reconnect when TCP
 is on use on network-change management command
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

--ff/JslbO5VQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/891?usp=3Demail

to review the following change.


Change subject: Reconnect when TCP is on use on network-change management c=
ommand
......................................................................

Reconnect when TCP is on use on network-change management command

On some newer Android handsets, changing to a different network
often does not trigger a TCP reset but continues using the old
connection (e.g. using mobile connection when WiFi becomes available)

Force a reconnect in these situation to have a more expected beheaviour.

Change-Id: Id4febcceecab33ee5189cd67b249a15d12b84799
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/init.c
1 file changed, 9 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/891/1

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index a7f7db4..b5eeeb8 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -4390,6 +4390,15 @@
         return -1;
     }

+    /* On some newer Android handsets, changing to a different network
+     * often does not trigger a TCP reset but continue using the old
+     * connection (e.g. using mobile connection when WiFi becomes availabl=
e */
+    struct link_socket_info *lsi =3D get_link_socket_info(c);
+    if (lsi && proto_is_tcp(lsi->proto) && !samenetwork)
+    {
+      	return -2;
+    }
+
     socketfd =3D c->c2.link_sockets[0]->sd;
     if (!c->options.pull || c->c2.tls_multi->use_peer_id || samenetwork)
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/891?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id4febcceecab33ee5189cd67b249a15d12b84799
Gerrit-Change-Number: 891
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--ff/JslbO5VQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/891?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Reconnect when TCP is on use on network-change management com=
mand<br><br>On some newer Android handsets, changing to a different network=
<br>often does not trigger a TCP reset but continues using the old<br>conne=
ction (e.g. using mobile connection when WiFi becomes available)<br><br>For=
ce a reconnect in these situation to have a more expected beheaviour.<br><b=
r>Change-Id: Id4febcceecab33ee5189cd67b249a15d12b84799<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@...1227...&gt;<br>---<br>M src/openvpn/init.c<br>1 file=
 changed, 9 insertions(+), 0 deletions(-)<br><br></pre><pre style=3D"font-f=
amily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.o=
penvpn.net:29418/openvpn refs/changes/91/891/1</pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/ope=
nvpn/init.c b/src/openvpn/init.c</span><br><span>index a7f7db4..b5eeeb8 100=
644</span><br><span>--- a/src/openvpn/init.c</span><br><span>+++ b/src/open=
vpn/init.c</span><br><span>@@ -4390,6 +4390,15 @@</span><br><span>         =
return -1;</span><br><span>     }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* On some newer Android handsets, ch=
anging to a different network</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     * often does not trigger a TCP reset but continue using the =
old</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * connectio=
n (e.g. using mobile connection when WiFi becomes available */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_info *lsi=
 =3D get_link_socket_info(c);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (lsi &amp;&amp; proto_is_tcp(lsi-&gt;proto) &amp;&amp; !sa=
menetwork)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+      	return -2;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     socketfd =3D c-&g=
t;c2.link_sockets[0]-&gt;sd;</span><br><span>     if (!c-&gt;options.pull |=
| c-&gt;c2.tls_multi-&gt;use_peer_id || samenetwork)</span><br><span>     {=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/891?usp=3Demail">change 891</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/891?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id4febcceecab33ee5189cd67b24=
9a15d12b84799 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 891 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ff/JslbO5VQ=--

