From: "d12fk (Code Review)" <gerrit@...515...>
Date: Mon, 24 Nov 2025 11:41:45 +0000
In-Reply-To: <gerrit.1763922943000.I8aa1cf1585e2320fca9329bdd0227976606fe71e@...2715...>
References: <gerrit.1763922943000.I8aa1cf1585e2320fca9329bdd0227976606fe71e@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <c7545d99da1640703d09b8a40a226dd977d3242a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VaxEC01i9uQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Restrict access to
 the service pipe to SYSTEM and owner
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VaxEC01i9uQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, selvanair.

d12fk has posted comments on this change by selvanair. ( http://gerrit.open=
vpn.net/c/openvpn/+/1397?usp=3Demail )

Change subject: Restrict access to the service pipe to SYSTEM and owner
......................................................................


Patch Set 1:

(1 comment)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/1397/comment/db6ea1a4_80142eea?usp=3D=
email :
PS1, Line 3422:      * restrcted to the user and SYSTEM
type `restrcted`



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1397?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8aa1cf1585e2320fca9329bdd0227976606fe71e
Gerrit-Change-Number: 1397
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Mon, 24 Nov 2025 11:41:45 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No

--VaxEC01i9uQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1397?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/1397/comment/db6ea1a4_80142eea?usp=3Demail">Patch=
 Set #1, Line 3422:</a> <code style=3D"font-family:monospace,monospace">   =
  * restrcted to the user and SYSTEM</code></p><p class=3D"blocks" style=3D=
"white-space: pre-wrap; word-wrap: break-word;">type `restrcted`</p></li></=
ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1397?usp=3Demail">change 1397</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Dem=
ail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1397?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8aa1cf1585e2320fca9329bdd02=
27976606fe71e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1397 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Nov 2025 11:41:45=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>

</body></html>=

--VaxEC01i9uQ=--

