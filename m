From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 10 Jan 2024 15:47:32 +0000
In-Reply-To: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., lstipakov@...277...
Message-ID: <397dd26148f180cedda65089aa0307889bbc28f0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SxdvATCE3f0="; charset=UTF-8
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
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SxdvATCE3f0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/489?usp=3Demail )

Change subject: Windows: enforce 'block-local' with WFP filters
......................................................................


Patch Set 4:

(5 comments)

File include/openvpn-msg.h:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/8bc08e9f_7c28e168 :
PS4, Line 27: #include <windef.h>
> why those are needed here?
They define some types used in the header. Not that all wouldn't compile wi=
thout them, but when looking at the single file (like clangd does) these un=
definedness.


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/25c045e0_c6d575fc :
PS4, Line 621: do_block_local(const struct route_list *rl)
> since this function doesn't really do any blocking and only check options=
, maybe rename to "is_block [=E2=80=A6]
Done


File src/openvpn/wfp_block.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/50237516_00bec708 :
PS4, Line 310:     /* Fifth filter. Permit IPv4 for the VPN interface.
> Permit DNS or all IPv4 traffic for the VPN interface?
Done


http://gerrit.openvpn.net/c/openvpn/+/489/comment/7e9bc610_f12f2c41 :
PS4, Line 327:     /* Sixth filter. Permit IPv6 for the VPN interface.
> Same as above - Permit DNS or all IPv6 traffic for the VPN interface?
Done


File src/openvpn/win32.h:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/fff56b45_305383c8 :
PS4, Line 28: #include <iphlpapi.h>
> why those changes?
They define some types used in the header. Not that all wouldn't compile wi=
thout them, but when looking at the single file (like clangd does) these un=
definedness.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba
Gerrit-Change-Number: 489
Gerrit-PatchSet: 4
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Wed, 10 Jan 2024 15:47:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--SxdvATCE3f0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File include/openvpn-msg.h:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/489/comment/8bc08e9f_7c28e168">Patch Set #4, Line 27:</a>=
 <code style=3D"font-family:monospace,monospace">#include &lt;windef.h&gt;<=
/code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px=
 0; padding: 0 10px;">why those are needed here?</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">They define some types u=
sed in the header. Not that all wouldn&#39;t compile without them, but when=
 looking at the single file (like clangd does) these undefinedness.</p></li=
></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.c=
:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pa=
dding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/489/comment/25c045e0_c6d575fc">Patch Set #4, Lin=
e 621:</a> <code style=3D"font-family:monospace,monospace">do_block_local(c=
onst struct route_list *rl)</code></p><p><blockquote style=3D"border-left: =
1px solid #aaa; margin: 10px 0; padding: 0 10px;">since this function doesn=
&#39;t really do any blocking and only check options, maybe rename to &quot=
;is_block [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/wfp_block.c:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/commen=
t/50237516_00bec708">Patch Set #4, Line 310:</a> <code style=3D"font-family=
:monospace,monospace">    /* Fifth filter. Permit IPv4 for the VPN interfac=
e.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 1=
0px 0; padding: 0 10px;">Permit DNS or all IPv4 traffic for the VPN interfa=
ce?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/c=
omment/7e9bc610_f12f2c41">Patch Set #4, Line 327:</a> <code style=3D"font-f=
amily:monospace,monospace">    /* Sixth filter. Permit IPv6 for the VPN int=
erface.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">Same as above - Permit DNS or all IPv6 traffi=
c for the VPN interface?</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; pad=
ding: 0;"><p>File src/openvpn/win32.h:</p><ul style=3D"list-style: none; pa=
dding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin=
-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment=
/fff56b45_305383c8">Patch Set #4, Line 28:</a> <code style=3D"font-family:m=
onospace,monospace">#include &lt;iphlpapi.h&gt;</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">why t=
hose changes?</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">They define some types used in the header. Not that all would=
n&#39;t compile without them, but when looking at the single file (like cla=
ngd does) these undefinedness.</p></li></ul></li></ul><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">change 489</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/489?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic9bf797bfc7e2d471998a84cb0f=
071db3e4832ba </div>
<div style=3D"display:none"> Gerrit-Change-Number: 489 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 10 Jan 2024 15:47:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--SxdvATCE3f0=--

