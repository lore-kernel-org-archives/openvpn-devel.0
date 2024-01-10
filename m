From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 10 Jan 2024 10:16:58 +0000
In-Reply-To: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <f81aed46b5f903cd63126192367e665e8601c8b5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="OROlATO0yKo="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--OROlATO0yKo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, flichtenheld, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/489?usp=3Demail )

Change subject: Windows: enforce 'block-local' with WFP filters
......................................................................


Patch Set 4:

(5 comments)

File include/openvpn-msg.h:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/b79b7779_628d912d :
PS4, Line 27: #include <windef.h>
why those are needed here?


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/e376b80f_a07c08de :
PS4, Line 621: do_block_local(const struct route_list *rl)
since this function doesn't really do any blocking and only check options, =
maybe rename to "is_block_local_needed()" ?


File src/openvpn/wfp_block.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/98a45da8_a4f2c958 :
PS4, Line 310:     /* Fifth filter. Permit IPv4 for the VPN interface.
Permit DNS or all IPv4 traffic for the VPN interface?


http://gerrit.openvpn.net/c/openvpn/+/489/comment/d9207c40_fa180f47 :
PS4, Line 327:     /* Sixth filter. Permit IPv6 for the VPN interface.
Same as above - Permit DNS or all IPv6 traffic for the VPN interface?


File src/openvpn/win32.h:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/55c79df7_1e0f8209 :
PS4, Line 28: #include <iphlpapi.h>
why those changes?



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
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Wed, 10 Jan 2024 10:16:58 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--OROlATO0yKo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, d12fk, flichtenheld, plais=
thos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">View C=
hange</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File include/openvpn-msg.h:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/489/comment/b79b7779_628d912d">Patch Set #4, Line 27:</a>=
 <code style=3D"font-family:monospace,monospace">#include &lt;windef.h&gt;<=
/code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">why th=
ose are needed here?</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/route.c:</p><ul style=3D"list-style: none; padding: 0;=
"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/e376b80f=
_a07c08de">Patch Set #4, Line 621:</a> <code style=3D"font-family:monospace=
,monospace">do_block_local(const struct route_list *rl)</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">since this function does=
n&#39;t really do any blocking and only check options, maybe rename to &quo=
t;is_block_local_needed()&quot; ?</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/wfp_block.c:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
89/comment/98a45da8_a4f2c958">Patch Set #4, Line 310:</a> <code style=3D"fo=
nt-family:monospace,monospace">    /* Fifth filter. Permit IPv4 for the VPN=
 interface.</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Permit DNS or all IPv4 traffic for the VPN interface?</p></li><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/d9207c40_fa180f47=
">Patch Set #4, Line 327:</a> <code style=3D"font-family:monospace,monospac=
e">    /* Sixth filter. Permit IPv6 for the VPN interface.</code></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Same as above - Permit=
 DNS or all IPv6 traffic for the VPN interface?</p></li></ul></li><li style=
=3D"margin: 0; padding: 0;"><p>File src/openvpn/win32.h:</p><ul style=3D"li=
st-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;">=
<p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/489/comment/55c79df7_1e0f8209">Patch Set #4, Line 28:</a> <code styl=
e=3D"font-family:monospace,monospace">#include &lt;iphlpapi.h&gt;</code></p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">why those chang=
es?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/489?usp=3Demail">change 489</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/489?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div>=
</div>

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
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 10 Jan 2024 10:16:58=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--OROlATO0yKo=--

