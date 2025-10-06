From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 6 Oct 2025 09:17:47 +0000
In-Reply-To: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
References: <gerrit.1758706218000.Ib3458a9ed2eb38e00184c4a92659b83b97fe476c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <270f0e3113714b89fe05820bc34b2a7b816f95ca-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r1f8iS40d/I="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: redirect-gateway:
 only redirect traffic through TUN if address famili...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r1f8iS40d/I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

cron2 has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/1210?usp=3Demail )

Change subject: redirect-gateway: only redirect traffic through TUN if addr=
ess families match
......................................................................


Patch Set 3:

(1 comment)

Patchset:

PS1:
> https://github.com/OpenVPN/openvpn/issues/850 [=E2=80=A6]
please do also link to the issue in the commit message (`Github: fixes Open=
VPN/openvpn#850`)



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a92659b83b97fe476c
Gerrit-Change-Number: 1210
Gerrit-PatchSet: 3
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Mon, 06 Oct 2025 09:17:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: mrbff <marco@...2726...>

--r1f8iS40d/I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1210?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1210?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">http=
s://github.com/OpenVPN/openvpn/issues/850 [=E2=80=A6]</blockquote></p><p cl=
ass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">plea=
se do also link to the issue in the commit message (`Github: fixes OpenVPN/=
openvpn#850`)</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1210?usp=3Demail">change 1210</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1210?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib3458a9ed2eb38e00184c4a9265=
9b83b97fe476c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1210 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 06 Oct 2025 09:17:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: mrbff &lt;marco@...2804...=
.&gt; </div>

</body></html>=

--r1f8iS40d/I=--

