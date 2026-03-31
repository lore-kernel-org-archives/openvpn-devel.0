From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 31 Mar 2026 22:50:08 +0000
In-Reply-To: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
References: <gerrit.1760995553000.I31ac2a763209114267c35c4a9182a12d8d82f6fe@...2715...>
Reply-To: arne-openvpn@...1227..., davidben@...410...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d43f842b3fec0be475bb86f14fc949c963671828-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cy0I4Ue1ibk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: ssl_openssl: Fix
 some CRL mixups
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: davidben <davidben@...410...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cy0I4Ue1ibk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: davidben, flichtenheld.

plaisthos has posted comments on this change by davidben. ( http://gerrit.o=
penvpn.net/c/openvpn/+/1289?usp=3Demail )

Change subject: ssl_openssl: Fix some CRL mixups
......................................................................


Patch Set 10: Code-Review+2


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31ac2a763209114267c35c4a9182a12d8d82f6fe
Gerrit-Change-Number: 1289
Gerrit-PatchSet: 10
Gerrit-Owner: davidben <davidben@...410...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: davidben <davidben@...410...>
Gerrit-Comment-Date: Tue, 31 Mar 2026 22:50:08 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes

--cy0I4Ue1ibk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: davidben, flichtenheld. </p>
<p>Patch set 10:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail">=
View Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demai=
l">change 1289</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1289?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31ac2a763209114267c35c4a918=
2a12d8d82f6fe </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1289 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 10 </div>
<div style=3D"display:none"> Gerrit-Owner: davidben &lt;davidben@...410...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: davidben &lt;davidben@...2975...=
...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 31 Mar 2026 22:50:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--cy0I4Ue1ibk=--

