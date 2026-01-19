From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 19 Jan 2026 22:46:51 +0000
In-Reply-To: <gerrit.1768848003000.I3d506725e69c09a9c77d6a9ba71a00e112e7abb6@...2715...>
References: <gerrit.1768848003000.I3d506725e69c09a9c77d6a9ba71a00e112e7abb6@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 ralf@...2726...
Message-ID: <63c0a582555aecf8813f623013040ebd7167fbc0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HK456wsufLE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: ignore key
 transition window logic
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: ralf_lici <ralf@...2726...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--HK456wsufLE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ralf_lici.

plaisthos has posted comments on this change by ralf_lici. ( http://gerrit.=
openvpn.net/c/openvpn/+/1479?usp=3Demail )

Change subject: dco: ignore key transition window logic
......................................................................


Patch Set 1:

(1 comment)

File src/openvpn/dco.c:

http://gerrit.openvpn.net/c/openvpn/+/1479/comment/9f0beabf_e536a1e8?usp=3D=
email :
PS1, Line 89:         ks->auth_deferred_expire =3D now;
This will instantly trigger the key to be installed as primary key, breakin=
g the normal transition method for tls renegotiation.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1479?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3d506725e69c09a9c77d6a9ba71a00e112e7abb6
Gerrit-Change-Number: 1479
Gerrit-PatchSet: 1
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Mon, 19 Jan 2026 22:46:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--HK456wsufLE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ralf_lici. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1479?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1479/comment/9f0beabf_e536a1e8?usp=3Demail">Patch Set #1, Lin=
e 89:</a> <code style=3D"font-family:monospace,monospace">        ks-&gt;au=
th_deferred_expire =3D now;</code></p><p class=3D"blocks" style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">This will instantly trigger the key =
to be installed as primary key, breaking the normal transition method for t=
ls renegotiation.</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1479?usp=3Demail">change 1479</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1479?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3d506725e69c09a9c77d6a9ba71=
a00e112e7abb6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1479 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ralf_lici &lt;ralf@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 19 Jan 2026 22:46:51=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--HK456wsufLE=--

