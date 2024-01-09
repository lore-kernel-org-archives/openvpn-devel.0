From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 14:53:24 +0000
In-Reply-To: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <ae0f8ce5c59266399e17e84bf9f6ed078961ee88-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WOdk/yEd3Qg="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WOdk/yEd3Qg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/489?usp=3Demail )

Change subject: Windows: enforce 'block-local' with WFP filters
......................................................................


Patch Set 3:

(5 comments)

File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/b1bfa846_8997b555 :
PS1, Line 357:       Push this flag to defend against the TunnelCrack attac=
ks.
> Most terminals handle links sensibly these days. Also we publish this as =
HTML documentation. [=E2=80=A6]
Done


File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/2586766b_9e2183fd :
PS1, Line 1971:         /* Fortify 'redirect-gateway block-local' with fire=
wall rules? */
> Okay there's not much to gain with respect to breaking out run_up_down, a=
s that one requires too muc [=E2=80=A6]
Done


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/2b4628b0_c3b07ee0 :
PS1, Line 78: static bool add_route(struct route_ipv4 *r, const struct tunt=
ap *tt, unsigned int flags,
> Right, failed to spot this. The build results speak for themselves. [=E2=
=80=A6]
Done


File src/openvpn/wfp_block.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/ed619643_4cbcafe1 :
PS1, Line 197:     FWPM_FILTER_CONDITION0 Condition[2];
> because the filters are zeroed right below, and than copied into [0] and/=
or [1] below as needed, so  [=E2=80=A6]
Done


File src/openvpn/win32.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/a0fa7528_684d91ad :
PS1, Line 1225:     if (ret =3D=3D false)
> Right, but you could just replace the "got out" with "return false" anywa=
y.
Yes, but no. The function has a single point of return, let's keep it that =
way. There's not enough to gain by changing this.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba
Gerrit-Change-Number: 489
Gerrit-PatchSet: 3
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 09 Jan 2024 14:53:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--WOdk/yEd3Qg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/vpn-network-o=
ptions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/489/comment/b1bfa846_8997b555">Patch S=
et #1, Line 357:</a> <code style=3D"font-family:monospace,monospace">      =
Push this flag to defend against the TunnelCrack attacks.</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Most terminals handle links sensibly these days. Also we publish this =
as HTML documentation. [=E2=80=A6]</blockquote></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"marg=
in: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul style=3D"list-style:=
 none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
89/comment/2586766b_9e2183fd">Patch Set #1, Line 1971:</a> <code style=3D"f=
ont-family:monospace,monospace">        /* Fortify &#39;redirect-gateway bl=
ock-local&#39; with firewall rules? */</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Okay there&#39=
;s not much to gain with respect to breaking out run_up_down, as that one r=
equires too muc [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; =
padding: 0;"><p>File src/openvpn/route.c:</p><ul style=3D"list-style: none;=
 padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"mar=
gin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comm=
ent/2b4628b0_c3b07ee0">Patch Set #1, Line 78:</a> <code style=3D"font-famil=
y:monospace,monospace">static bool add_route(struct route_ipv4 *r, const st=
ruct tuntap *tt, unsigned int flags,</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Right, failed to=
 spot this. The build results speak for themselves. [=E2=80=A6]</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/wfp_bl=
ock.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/489/comment/ed619643_4cbcafe1">Patch Set #1=
, Line 197:</a> <code style=3D"font-family:monospace,monospace">    FWPM_FI=
LTER_CONDITION0 Condition[2];</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">because the filters are=
 zeroed right below, and than copied into [0] and/or [1] below as needed, s=
o  [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;">=
<p>File src/openvpn/win32.c:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4=
px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/a0fa7528_=
684d91ad">Patch Set #1, Line 1225:</a> <code style=3D"font-family:monospace=
,monospace">    if (ret =3D=3D false)</code></p><p><blockquote style=3D"bor=
der-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Right, but you =
could just replace the &quot;got out&quot; with &quot;return false&quot; an=
yway.</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Yes, but no. The function has a single point of return, let&#39;s kee=
p it that way. There&#39;s not enough to gain by changing this.</p></li></u=
l></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/489?usp=3Demail">change 489</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f=
071db3e4832ba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 489 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Jan 2024 14:53:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--WOdk/yEd3Qg=--

