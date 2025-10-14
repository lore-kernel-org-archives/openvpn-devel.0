From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 14 Oct 2025 09:47:00 +0000
In-Reply-To: <gerrit.1758627240000.Iaabddb6f81cd94863291b193aae9d384a8f9d871@...2715...>
References: <gerrit.1758627240000.Iaabddb6f81cd94863291b193aae9d384a8f9d871@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <18b65f4929b2d6487b376d3aef89f41b34b25ee2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="906TCl2dW5c="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Enable -Wtype-limits
 by default (via -Wextra)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--906TCl2dW5c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change by flichtenheld. ( http://gerr=
it.openvpn.net/c/openvpn/+/1207?usp=3Demail )

Change subject: Enable -Wtype-limits by default (via -Wextra)
......................................................................


Patch Set 3: Code-Review-1

(1 comment)

File src/openvpn/init.c:

http://gerrit.openvpn.net/c/openvpn/+/1207/comment/c01e41e9_729132bc?usp=3D=
email :
PS3, Line 2732:     bool datav2_enabled =3D c->options.peer_id < MAX_PEER_I=
D;
Yes that is correct from the standpoint of no sign compare but the check sh=
ould be fixed to actually do what it says. Replace the first part with c->o=
ptions.use_peer_id



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iaabddb6f81cd94863291b193aae9d384a8f9d871
Gerrit-Change-Number: 1207
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 14 Oct 2025 09:47:00 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--906TCl2dW5c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/init.c:</p><ul=
 style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0=
 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1207/comment/c01e41e9_729132bc?usp=3Demail">Patch Set #3=
, Line 2732:</a> <code style=3D"font-family:monospace,monospace">    bool d=
atav2_enabled =3D c-&gt;options.peer_id &lt; MAX_PEER_ID;</code></p><p clas=
s=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Yes th=
at is correct from the standpoint of no sign compare but the check should b=
e fixed to actually do what it says. Replace the first part with c-&gt;opti=
ons.use_peer_id</p></li></ul></li></ul><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1207?usp=3Demail">change 1207</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1207?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iaabddb6f81cd94863291b193aae=
9d384a8f9d871 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1207 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 14 Oct 2025 09:47:00=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--906TCl2dW5c=--

