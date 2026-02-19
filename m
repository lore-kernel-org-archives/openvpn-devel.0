From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 19 Feb 2026 10:22:12 +0000
In-Reply-To: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
References: <gerrit.1771437772000.I560f45fb0011180be8ca2b0e7fbc63030fa10f35@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 ralf@...2726..., antonio@...2726...
Message-ID: <45a88e6de7f3c59f5ffa591cf7e501566d4f5c41-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Gk32gVDre6U="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: DCO Linux: Fix
 setting DCO ifmode failing on big endian archs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: ralf_lici <ralf@...2726...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Gk32gVDre6U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, ralf_lici.

plaisthos has posted comments on this change by plaisthos. ( http://gerrit.=
openvpn.net/c/openvpn/+/1547?usp=3Demail )

Change subject: DCO Linux: Fix setting DCO ifmode failing on big endian arc=
hs
......................................................................


Patch Set 3:

(2 comments)

Patchset:

PS1:
> missing Signed-off-by line. [=E2=80=A6]
Done


File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1547/comment/9d502085_4e9be80e?usp=3D=
email :
PS1, Line 1342:          * other than uint8_t here causes the values to be =
0 when passed
> maybe you can mention that the enum is probably wending up being a uint16=
 or uint32? Because you are [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I560f45fb0011180be8ca2b0e7fbc63030fa10f35
Gerrit-Change-Number: 1547
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: ralf_lici <ralf@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: ralf_lici <ralf@...2726...>
Gerrit-Comment-Date: Thu, 19 Feb 2026 10:22:12 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <antonio@...2726...>

--Gk32gVDre6U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, ralf_lici. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1547?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1547?tab=3Dcomments&amp;usp=3Demail">Patch Set #1:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">mis=
sing Signed-off-by line. [=E2=80=A6]</blockquote></p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></l=
i><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking_sitnl=
.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1547/comment/9d502085_4e9be80e?usp=3Demail">Pa=
tch Set #1, Line 1342:</a> <code style=3D"font-family:monospace,monospace">=
         * other than uint8_t here causes the values to be 0 when passed</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">maybe you can mention that the enum is probably wending=
 up being a uint16 or uint32? Because you are [=E2=80=A6]</blockquote></p><=
p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">=
Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1547?usp=3Demail">change 1547</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1547?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I560f45fb0011180be8ca2b0e7fb=
c63030fa10f35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1547 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ralf_lici &lt;ralf@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ralf_lici &lt;ralf@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 19 Feb 2026 10:22:12=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;antonio@...2787...=
...&gt; </div>

</body></html>=

--Gk32gVDre6U=--

