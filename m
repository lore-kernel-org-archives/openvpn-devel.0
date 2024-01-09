From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 07:03:33 +0000
In-Reply-To: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9e3d062d3c0369a59a9cd19178c67a4753505c9d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IPiMEbedYNM="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Windows: enforce
 'block-local' with WFP filters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: d12fk <heiko@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IPiMEbedYNM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/489?usp=3Demail )

Change subject: Windows: enforce 'block-local' with WFP filters
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/5b55e13a_2a09a8aa :
PS1, Line 78: static bool add_route(struct route_ipv4 *r, const struct tunt=
ap *tt, unsigned int flags,
this breaks compilation on a zillion of platforms that want to call add_rou=
te() from tun.c - please do not mix "cleanup of unrelated code" and "new fe=
atures"



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba
Gerrit-Change-Number: 489
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Tue, 09 Jan 2024 07:03:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--IPiMEbedYNM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/489/comment/5b55e13a_2a09a8aa">Patch Set #1, Line 78:</a> <c=
ode style=3D"font-family:monospace,monospace">static bool add_route(struct =
route_ipv4 *r, const struct tuntap *tt, unsigned int flags,</code></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">this breaks compilati=
on on a zillion of platforms that want to call add_route() from tun.c - ple=
ase do not mix &quot;cleanup of unrelated code&quot; and &quot;new features=
&quot;</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/489?usp=3Demail">change 489</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/489?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f=
071db3e4832ba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 489 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Jan 2024 07:03:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--IPiMEbedYNM=--

