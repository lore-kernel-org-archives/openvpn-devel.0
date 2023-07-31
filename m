From: "selvanair (Code Review)" <gerrit@...515...>
Date: Mon, 31 Jul 2023 16:37:32 +0000
In-Reply-To: <gerrit.1690550288000.I47c22dcb728011dcedaae47cd03a57219e9c7607@...2715...>
References: <gerrit.1690550288000.I47c22dcb728011dcedaae47cd03a57219e9c7607@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., a@...2181...
Message-ID: <73a8a5443c4b45bdaa945fbc71d9b6af29a5a7d4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eZbNzCVfcAs="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]: Set WINS
 servers via interactice service
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eZbNzCVfcAs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos=
, stipa.

selvanair has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/321?usp=3Demail )

Change subject: Set WINS servers via interactice service
......................................................................


Patch Set 3:

(1 comment)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/321/comment/d18799fd_594b4a55 :
PS1, Line 1406:     if (addr_len > 0 || msg->header.type =3D=3D msg_del_win=
s_cfg)
> Acknowledged
Though the process is unprivileged, its started by the privileged service w=
hich ensures that the process is a trusted executable installed in a partic=
ular location etc. So messages received via the msg-channel pipe can be tru=
sted. Note that this pipe is created by the service with a single instance =
restriction and the handle passed on to openvpn.exe. Without this guarantee=
 iservice would have been far less safe and secure.

Only the client process (like the GUI) is untrusted.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I47c22dcb728011dcedaae47cd03a57219e9c7607
Gerrit-Change-Number: 321
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: selvanair <selva.nair@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Mon, 31 Jul 2023 16:37:32 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--eZbNzCVfcAs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/321/comment/d18799fd_594b4a55">Patch Set #1, Line =
1406:</a> <code style=3D"font-family:monospace,monospace">    if (addr_len =
&gt; 0 || msg-&gt;header.type =3D=3D msg_del_wins_cfg)</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">Acknowledged</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap=
: break-word;">Though the process is unprivileged, its started by the privi=
leged service which ensures that the process is a trusted executable instal=
led in a particular location etc. So messages received via the msg-channel =
pipe can be trusted. Note that this pipe is created by the service with a s=
ingle instance restriction and the handle passed on to openvpn.exe. Without=
 this guarantee iservice would have been far less safe and secure.</p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Only the client proce=
ss (like the GUI) is untrusted.</p></li></ul></li></ul><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail">change 321<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I47c22dcb728011dcedaae47cd03=
a57219e9c7607 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 321 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: selvanair &lt;selva.nair@...1665...=
77...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 31 Jul 2023 16:37:32=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--eZbNzCVfcAs=--

