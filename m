From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 2 Mar 2026 19:55:48 +0000
In-Reply-To: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
References: <gerrit.1771470576000.I788f76e6a70a9c20bca3367140d2741bd0551582@...2715...>
Reply-To: arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <95dbe72f014782d62f36a31307ba39b5318d5641-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8v/AoW0M12g="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Add an optional
 username-only flag for auth-user-pass
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8v/AoW0M12g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, selvanair.

plaisthos has posted comments on this change by selvanair. ( http://gerrit.=
openvpn.net/c/openvpn/+/1548?usp=3Demail )

Change subject: Add an optional username-only flag for auth-user-pass
......................................................................


Patch Set 5: Code-Review+2


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I788f76e6a70a9c20bca3367140d2741bd0551582
Gerrit-Change-Number: 1548
Gerrit-PatchSet: 5
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Mon, 02 Mar 2026 19:55:48 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--8v/AoW0M12g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, selvanair. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail">V=
iew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail=
">change 1548</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1548?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I788f76e6a70a9c20bca3367140d=
2741bd0551582 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1548 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: flichtenheld &lt;frank@...2641...&g=
t; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 02 Mar 2026 19:55:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--8v/AoW0M12g=--

