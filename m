From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 7 Apr 2026 01:00:30 +0000
In-Reply-To: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
References: <gerrit.1775475846000.I055c64ca8b23066e70eea7d7deddfb14f5354c5f@...2715...>
Reply-To: arne-openvpn@...1227..., selva.nair@...277...,
 luca.boccassi@...277..., openvpn-devel@lists.sourceforge.net
Message-ID: <cafb98103ab7761b04898f30b906b085d73e9ffe-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GO80r0X0pUA="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add new helpers to
 handle key exchange (S_SENT_KEY/S_START) with larg...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: Bluca <luca.boccassi@...277...>
Cc: selvanair <selva.nair@...277...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GO80r0X0pUA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: Bluca, selvanair.

plaisthos has posted comments on this change by Bluca. ( http://gerrit.open=
vpn.net/c/openvpn/+/1622?usp=3Demail )

Change subject: Add new helpers to handle key exchange (S_SENT_KEY/S_START)=
 with large passwords
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
> With the last combination, a large password can be used successfully.
With either an old server or old client, existing limits apply and
a clear error is shown in case one tries a password longer than the
existing limits.

The clear error message is a quite recent change https://github.com/OpenVPN=
/openvpn/commit/a7f80d402fb95df3c58a8fc5d12cdb8f39c37d3e

You get very weird errors and behaviour on OpenVPN versions older than this=
 commit. So only 2.6.13 or newer will actually give a clear error message.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I055c64ca8b23066e70eea7d7deddfb14f5354c5f
Gerrit-Change-Number: 1622
Gerrit-PatchSet: 1
Gerrit-Owner: Bluca <luca.boccassi@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: Bluca <luca.boccassi@...277...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Tue, 07 Apr 2026 01:00:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--GO80r0X0pUA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: Bluca, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-styl=
e: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1622?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><blockquote clas=
s=3D"blocks" style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding:=
 0 10px;"><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">With the last combination, a large password can be used successf=
ully.<br>With either an old server or old client, existing limits apply and=
<br>a clear error is shown in case one tries a password longer than the<br>=
existing limits.</p></blockquote><p class=3D"blocks" style=3D"white-space: =
pre-wrap; word-wrap: break-word;">The clear error message is a quite recent=
 change https://github.com/OpenVPN/openvpn/commit/a7f80d402fb95df3c58a8fc5d=
12cdb8f39c37d3e</p><p class=3D"blocks" style=3D"white-space: pre-wrap; word=
-wrap: break-word;">You get very weird errors and behaviour on OpenVPN vers=
ions older than this commit. So only 2.6.13 or newer will actually give a c=
lear error message.</p></li></ul></li></ul><p>To view, visit <a href=3D"htt=
p://gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail">change 1622</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1622?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I055c64ca8b23066e70eea7d7ded=
dfb14f5354c5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1622 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: Bluca &lt;luca.boccassi@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: Bluca &lt;luca.boccassi@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 07 Apr 2026 01:00:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--GO80r0X0pUA=--

