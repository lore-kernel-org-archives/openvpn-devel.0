From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Mar 2026 11:38:11 +0000
In-Reply-To: <gerrit.1769789455000.I2f6502da1832edcb273a0dfa9b3ef940bec2d711@...2715...>
References: <gerrit.1769789455000.I2f6502da1832edcb273a0dfa9b3ef940bec2d711@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8491bdba8be76d1ebd5d28ede7ca9efbbe7d3e8f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FsaUs1pzn+g="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: wfp_block: Avoid
 sign-compare warning with Fwpm* return types
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FsaUs1pzn+g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

cron2 has posted comments on this change by flichtenheld. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1506?usp=3Demail )

Change subject: wfp_block: Avoid sign-compare warning with Fwpm* return typ=
es
......................................................................


Patch Set 10: Code-Review+2


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2f6502da1832edcb273a0dfa9b3ef940bec2d711
Gerrit-Change-Number: 1506
Gerrit-PatchSet: 10
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 30 Mar 2026 11:38:11 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--FsaUs1pzn+g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>Patch set 10:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demai=
l">change 1506</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1506?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2f6502da1832edcb273a0dfa9b3=
ef940bec2d711 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1506 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 30 Mar 2026 11:38:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--FsaUs1pzn+g=--

