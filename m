From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 15 Oct 2025 12:47:24 +0000
In-Reply-To: <gerrit.1740476883000.Ic7b486ccb85df7fc1d6a573ac1315d235728822c@...2715...>
References: <gerrit.1740476883000.Ic7b486ccb85df7fc1d6a573ac1315d235728822c@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7fbb58de8bfce3fc1bf9c1acdc30d188bec96205-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ED4iVfO6O44="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: redirect-gateway:
 add route toward new remote host when using persist...
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

--ED4iVfO6O44=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

stipa has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/901?usp=3Demail )

Change subject: redirect-gateway: add route toward new remote host when usi=
ng persist-tun
......................................................................


Patch Set 3:

(1 comment)

File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/901/comment/1a8b4adf_ca79cad5?usp=3De=
mail :
PS3, Line 1230:     int current_remote_family =3D c->c1.link_socket_addrs[0=
].actual.dest.addr.sa.sa_family;
Can we factor out c->c1.link_socket_addrs[0].actual.dest.addr into its own =
variable? We use this long statement in 3 places in this function.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/901?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic7b486ccb85df7fc1d6a573ac1315d235728822c
Gerrit-Change-Number: 901
Gerrit-PatchSet: 3
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: stipa <lstipakov@...277...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Wed, 15 Oct 2025 12:47:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--ED4iVfO6O44=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/901?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.c:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/901/comment/1a8b4adf_ca79cad5?usp=3Demail">Patch Set #3, Lin=
e 1230:</a> <code style=3D"font-family:monospace,monospace">    int current=
_remote_family =3D c-&gt;c1.link_socket_addrs[0].actual.dest.addr.sa.sa_fam=
ily;</code></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Can we factor out c-&gt;c1.link_socket_addrs[0].actual.dest=
.addr into its own variable? We use this long statement in 3 places in this=
 function.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/901?usp=3Demail">change 901</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/901?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic7b486ccb85df7fc1d6a573ac13=
15d235728822c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 901 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: stipa &lt;lstipakov@...277...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 15 Oct 2025 12:47:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--ED4iVfO6O44=--

