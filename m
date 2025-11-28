From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 11:26:53 +0000
In-Reply-To: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
References: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, ralf@...2726...
Message-ID: <f5dcdf45b4a82c070c95348fd07b2ce4fff617ff-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8xnWHnWLdoM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco: process
 messages immediately after read
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8xnWHnWLdoM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, ralf_lici.

cron2 has posted comments on this change by ralf_lici. ( http://gerrit.open=
vpn.net/c/openvpn/+/1403?usp=3Demail )

Change subject: dco: process messages immediately after read
......................................................................


Patch Set 13: Code-Review+2


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207db4445cd884d52
Gerrit-Change-Number: 1403
Gerrit-PatchSet: 13
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Fri, 28 Nov 2025 11:26:53 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--8xnWHnWLdoM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, ralf_lici. </p>
<p>Patch set 13:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demai=
l">change 1403</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207d=
b4445cd884d52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1403 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 28 Nov 2025 11:26:53=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--8xnWHnWLdoM=--

