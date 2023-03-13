From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 13 Mar 2023 13:43:07 +0000
In-Reply-To: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
References: <gerrit.1677068512000.Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 lstipakov@...277..., a@...2181...
Message-ID: <13508d26ad898a1381f507e16306897d54699c00-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zM4xQpfjKSA="; charset=UTF-8
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
Cc: openvpn-devel@lists.sourceforge.net, Lev Stipakov <lstipakov@...277...>

--zM4xQpfjKSA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/=
+/28?usp=3Demail )

Change subject: dco: don't use NetLink to exchange control packets
......................................................................

dco: don't use NetLink to exchange control packets

Using NetLink for control messages did not work out as it did lead to
kernel side buffer congestion during heavy client activity.

With this patch DCO will redirect control packets directly to the
transport socket without altering them, so that userspace can
happily process them as usual.

NOTE: this is an API breaking change.  Up to this commit, the userland
requests a kernel module called "ovpn-dco" which does control messages
via netlink.  From this commit on, OpenVPN requests a kernel module named
"ovpn-dco-v2" which brings the kernel change corresponding to this commit.

If the system only has "the wrong module" available (either way), OpenVPN
will log

   ... Kernel support for ovpn-dco missing, disabling data channel offload.

and proceed without kernel support.

Change-Id: Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d
[lev@...515...: ensure win_dco flag is still exposed]
Signed-off-by: Antonio Quartulli <a@...2181...>
Acked-by: Arne Schwabe <arne@...1227...>
Message-Id: <20230309210344.5763-1-a@...2181...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg26=
384.html
Signed-off-by: Gert Doering <gert@...1296...>
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
14 files changed, 70 insertions(+), 297 deletions(-)


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia1297c3ae9a28b188ed21ad21ae96fff3d02ee4d
Gerrit-Change-Number: 28
Gerrit-PatchSet: 6
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: cron2
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-MessageType: merged

--zM4xQpfjKSA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>plaisthos <strong>submitted</strong> this change.</p><p><a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail">View Change</a></p><div st=
yle=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">dco: don&#39;t use NetLink to exchange cont=
rol packets<br><br>Using NetLink for control messages did not work out as i=
t did lead to<br>kernel side buffer congestion during heavy client activity=
.<br><br>With this patch DCO will redirect control packets directly to the<=
br>transport socket without altering them, so that userspace can<br>happily=
 process them as usual.<br><br>NOTE: this is an API breaking change.  Up to=
 this commit, the userland<br>requests a kernel module called &quot;ovpn-dc=
o&quot; which does control messages<br>via netlink.  From this commit on, O=
penVPN requests a kernel module named<br>&quot;ovpn-dco-v2&quot; which brin=
gs the kernel change corresponding to this commit.<br><br>If the system onl=
y has &quot;the wrong module&quot; available (either way), OpenVPN<br>will =
log<br><br>   ... Kernel support for ovpn-dco missing, disabling data chann=
el offload.<br><br>and proceed without kernel support.<br><br>Change-Id: Ia=
1297c3ae9a28b188ed21ad21ae96fff3d02ee4d<br>[lev@...515...: ensure win_dco f=
lag is still exposed]<br>Signed-off-by: Antonio Quartulli &lt;a@...2181...&=
gt;<br>Acked-by: Arne Schwabe &lt;arne@...1227...&gt;<br>Message-Id: &lt;20=
230309210344.5763-1-a@...2181...&gt;<br>URL: https://www.mail-archive.com/o=
penvpn-devel@lists.sourceforge.net/msg26384.html<br>Signed-off-by: Gert Doe=
ring &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/dco.c<br>M src/openvpn=
/dco.h<br>M src/openvpn/dco_freebsd.c<br>M src/openvpn/dco_freebsd.h<br>M s=
rc/openvpn/dco_linux.c<br>M src/openvpn/dco_linux.h<br>M src/openvpn/dco_wi=
n.c<br>M src/openvpn/forward.c<br>M src/openvpn/init.c<br>M src/openvpn/mtc=
p.c<br>M src/openvpn/multi.c<br>M src/openvpn/ovpn_dco_linux.h<br>M src/ope=
nvpn/socket.c<br>M src/openvpn/socket.h<br>14 files changed, 70 insertions(=
+), 297 deletions(-)<br><br></pre>
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=
=3Demail">change 28</a>. To unsubscribe, or for help writing mail filters, =
visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/28?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia1297c3ae9a28b188ed21ad21ae=
96fff3d02ee4d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 28 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--zM4xQpfjKSA=--

