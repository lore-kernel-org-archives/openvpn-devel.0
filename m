From: "ralf_lici (Code Review)" <gerrit@...515...>
Date: Fri, 28 Nov 2025 10:56:55 +0000
In-Reply-To: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
References: <gerrit.1764062094000.Iefc251cb4483c0b9fb9d6a5207db4445cd884d52@...2715...>
Reply-To: ralf@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <10a108333aebd47bff426d452486b50db7f65c52-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vZq6cRC+C/w="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vZq6cRC+C/w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

ralf_lici has posted comments on this change by ralf_lici. ( http://gerrit.=
openvpn.net/c/openvpn/+/1403?usp=3Demail )

Change subject: dco: process messages immediately after read
......................................................................


Patch Set 12:

(1 comment)

File src/openvpn/dco_linux.c:

http://gerrit.openvpn.net/c/openvpn/+/1403/comment/21014759_1e758765?usp=3D=
email :
PS11, Line 1115:             break;
> actually I think this one should stay as it was before (`return ovpn_hand=
le_peer()`) plus a comment  [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207db4445cd884d52
Gerrit-Change-Number: 1403
Gerrit-PatchSet: 12
Gerrit-Owner: ralf_lici <ralf@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Fri, 28 Nov 2025 10:56:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>

--vZq6cRC+C/w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1403/comment/21014759_1e758765?usp=3Demail">Patch Set #=
11, Line 1115:</a> <code style=3D"font-family:monospace,monospace">        =
    break;</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; m=
argin: 10px 0; padding: 0 10px;">actually I think this one should stay as i=
t was before (`return ovpn_handle_peer()`) plus a comment  [=E2=80=A6]</blo=
ckquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail">change 1403</a>. To unsu=
bscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.o=
penvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1403?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iefc251cb4483c0b9fb9d6a5207d=
b4445cd884d52 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1403 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 12 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 28 Nov 2025 10:56:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>

</body></html>=

--vZq6cRC+C/w=--

