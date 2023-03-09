From: "ordex (Code Review)" <gerrit@...515...>
Date: Thu, 9 Mar 2023 15:00:40 +0000
In-Reply-To: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
References: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <7dd3c5960d67c7c2288d0542ebea8fee8bc02312-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5VnUDrsbJ3Q="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco: don't use
 NetLink to exchange control packets
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lstipakov@...277...>

--5VnUDrsbJ3Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail

to look at the new patch set (#5).


Change subject: dco: don't use NetLink to exchange control packets
......................................................................

dco: don't use NetLink to exchange control packets

Using NetLink has proved to be overkill and performance critical.
The amount of control traffic can also easily overrun the NetLink buffer
when a server has enough clients connected.

Stop using NetLink to send/receive control packets and just use the
transport socket as if DCO was not there at all.

Under the hood DCO will redirect control packets to the transport socket
without altering them, so that userspace can happily process them as
usual.

Change-Id: Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d
[lev@...515...: ensure win_dco flag is still exposed]
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/dco.c
M src/openvpn/dco.h
M src/openvpn/dco_freebsd.c
M src/openvpn/dco_freebsd.h
M src/openvpn/dco_linux.c
M src/openvpn/dco_linux.h
M src/openvpn/dco_win.c
M src/openvpn/forward.c
M src/openvpn/init.c
M src/openvpn/mtcp.c
M src/openvpn/multi.c
M src/openvpn/ovpn_dco_linux.h
M src/openvpn/socket.c
M src/openvpn/socket.h
14 files changed, 58 insertions(+), 297 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/28/28/5
--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d
Gerrit-Change-Number: 28
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2
Gerrit-MessageType: newpatchset

--5VnUDrsbJ3Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>ordex <strong>uploaded patch set #5</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail">View Change</a>=
</p><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>dco: don&#39;t use NetLink to exchange control packets<br><br>Using NetLin=
k has proved to be overkill and performance critical.<br>The amount of cont=
rol traffic can also easily overrun the NetLink buffer<br>when a server has=
 enough clients connected.<br><br>Stop using NetLink to send/receive contro=
l packets and just use the<br>transport socket as if DCO was not there at a=
ll.<br><br>Under the hood DCO will redirect control packets to the transpor=
t socket<br>without altering them, so that userspace can happily process th=
em as<br>usual.<br><br>Change-Id: Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d=
<br>[lev@...515...: ensure win_dco flag is still exposed]<br>Signed-off-by:=
 Antonio Quartulli &lt;a@...2181...&gt;<br>---<br>M src/openvpn/dco.c<br>M =
src/openvpn/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_freeb=
sd.h<br>M src/openvpn/dco_linux.c<br>M src/openvpn/dco_linux.h<br>M src/ope=
nvpn/dco_win.c<br>M src/openvpn/forward.c<br>M src/openvpn/init.c<br>M src/=
openvpn/mtcp.c<br>M src/openvpn/multi.c<br>M src/openvpn/ovpn_dco_linux.h<b=
r>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>14 files changed, 58 =
insertions(+), 297 deletions(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/28/28/5</pre><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail">change 28</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/28?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chan=
ge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia1297c3ae9a28b188ed21ad21ae=
96fff3d02ee4d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 28 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--5VnUDrsbJ3Q=--

