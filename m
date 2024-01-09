From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 9 Jan 2024 13:42:47 +0000
In-Reply-To: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
References: <gerrit.1704761332000.Ic9bf797bfc7e2d471998a84cb0f071db3e4832ba@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <31a7e3d1d3b5651bc34a7f6c57bcec0f772e37ff-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="34rVijUDtWg="; charset=UTF-8
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
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--34rVijUDtWg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/489?usp=3Demail )

Change subject: Windows: enforce 'block-local' with WFP filters
......................................................................


Patch Set 1:

(2 comments)

File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/9ab5407d_5fbd4418 :
PS1, Line 357:       Push this flag to defend against the TunnelCrack attac=
ks.
> Agree not to explain TunnelCrack in the openvpn man page, but then refere=
nces are not much of a thin [=E2=80=A6]
Most terminals handle links sensibly these days. Also we publish this as HT=
ML documentation. We already have existing http links in the document. So a=
dding a link would probably not be a bad idea. How about:

"Push this flag to protect against attacks where the attacker tries to tric=
ks the client into accessing services through a public network instead of t=
he VPN (See e.g. https://tunnelcrack.mathyvanhoef.com/)."


File src/openvpn/win32.c:

http://gerrit.openvpn.net/c/openvpn/+/489/comment/70f36809_aae74546 :
PS1, Line 1225:     if (ret =3D=3D false)
> We need to set ret as return value anyway, so doing it before the if is m=
ore readable IMHO compared  [=E2=80=A6]
Right, but you could just replace the "got out" with "return false" anyway.



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
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Tue, 09 Jan 2024 13:42:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--34rVijUDtWg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, d12fk, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/vpn-network-o=
ptions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/489/comment/9ab5407d_5fbd4418">Patch S=
et #1, Line 357:</a> <code style=3D"font-family:monospace,monospace">      =
Push this flag to defend against the TunnelCrack attacks.</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">Agree not to explain TunnelCrack in the openvpn man page, but then ref=
erences are not much of a thin [=E2=80=A6]</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Most terminals handle links sens=
ibly these days. Also we publish this as HTML documentation. We already hav=
e existing http links in the document. So adding a link would probably not =
be a bad idea. How about:</p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">&quot;Push this flag to protect against attacks where the atta=
cker tries to tricks the client into accessing services through a public ne=
twork instead of the VPN (See e.g. https://tunnelcrack.mathyvanhoef.com/).&=
quot;</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/op=
envpn/win32.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/489/comment/70f36809_aae74546">Pa=
tch Set #1, Line 1225:</a> <code style=3D"font-family:monospace,monospace">=
    if (ret =3D=3D false)</code></p><p><blockquote style=3D"border-left: 1p=
x solid #aaa; margin: 10px 0; padding: 0 10px;">We need to set ret as retur=
n value anyway, so doing it before the if is more readable IMHO compared  [=
=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">Right, but you could just replace the &quot;got out&quot; with &=
quot;return false&quot; anyway.</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail">change 489<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/489?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 09 Jan 2024 13:42:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--34rVijUDtWg=--

