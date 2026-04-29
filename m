From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 29 Apr 2026 12:55:14 +0000
In-Reply-To: <gerrit.1777391343000.Id514b06223cb55295c92b1fa6727f03d6e06befe@...2715...>
References: <gerrit.1777391343000.Id514b06223cb55295c92b1fa6727f03d6e06befe@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1aabf300ebc9a211b7f65cfa4d670a0d27d2d431-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SgQ9x0L1hfY="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dns: correctly
 handle dnssec settings
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: d12fk <heiko@...515...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SgQ9x0L1hfY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

selvanair has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1643?usp=3Demail )

Change subject: dns: correctly handle dnssec settings
......................................................................


Patch Set 1:

(1 comment)

File include/openvpn-msg.h:

http://gerrit.openvpn.net/c/openvpn/+/1643/comment/b6e006cc_47bdfb38?usp=3D=
email :
PS1, Line 127:     nrpt_flags_t flags;
> The enum type is now really not appropriate anymore. [=E2=80=A6]
We have always wanted to keep openvpn-msg.h as a standalone header that thi=
rd part programs may want to use, so we need to define the flag type in the=
re right? May be we could get rid of th one in dns.h and use the flags dire=
ctly to set server->dnssec, but not sure how clean that would be. Also, in =
future dns flags may learn new bit fields that are unrelated to dnssec.
Valid value for message flags is what openvpn-msg.h says, and using that co=
rrectly is not that onerous a requirement, is it?
Unless I misunderstood the comment.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1643?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id514b06223cb55295c92b1fa6727f03d6e06befe
Gerrit-Change-Number: 1643
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 29 Apr 2026 12:55:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--SgQ9x0L1hfY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1643?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File include/openvpn-msg.h:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1643/comment/b6e006cc_47bdfb38?usp=3Demail">Patch Set #1,=
 Line 127:</a> <code style=3D"font-family:monospace,monospace">    nrpt_fla=
gs_t flags;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; =
margin: 10px 0; padding: 0 10px;">The enum type is now really not appropria=
te anymore. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"white-=
space: pre-wrap; word-wrap: break-word;">We have always wanted to keep open=
vpn-msg.h as a standalone header that third part programs may want to use, =
so we need to define the flag type in there right? May be we could get rid =
of th one in dns.h and use the flags directly to set server-&gt;dnssec, but=
 not sure how clean that would be. Also, in future dns flags may learn new =
bit fields that are unrelated to dnssec.<br>Valid value for message flags i=
s what openvpn-msg.h says, and using that correctly is not that onerous a r=
equirement, is it?<br>Unless I misunderstood the comment.</p></li></ul></li=
></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/16=
43?usp=3Demail">change 1643</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1643?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id514b06223cb55295c92b1fa672=
7f03d6e06befe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1643 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 29 Apr 2026 12:55:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--SgQ9x0L1hfY=--

