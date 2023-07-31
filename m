From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 31 Jul 2023 11:28:31 +0000
In-Reply-To: <gerrit.1690550288000.I47c22dcb728011dcedaae47cd03a57219e9c7607@...2715...>
References: <gerrit.1690550288000.I47c22dcb728011dcedaae47cd03a57219e9c7607@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <55b78243d2cbe1bd3f8015b10363ef849719b909-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eeLvlh4NU4E="; charset=UTF-8
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
Cc: plaisthos <arne-openvpn@...1227...>, selvanair <selva.nair@...277...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eeLvlh4NU4E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos=
, selvanair.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/321?usp=3Demail )

Change subject: Set WINS servers via interactice service
......................................................................


Patch Set 3:

(4 comments)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/321/comment/6605e8bb_4222a8d1 :
PS1, Line 1089:  * @param  action      "delete" or "add"
> This says "add" but the rest of the function seems to use "set". [=E2=80=
=A6]
Right. I copypasted it from DNS version which uses add.


http://gerrit.openvpn.net/c/openvpn/+/321/comment/b9b566c1_c7e3b460 :
PS1, Line 1094:  * if action =3D "set" then "static" is added before $addr
> Why are you using "set" here? The documentation (https://learn.microsoft.=
 [=E2=80=A6]
Good point. The reason I use "set" is because I checked the logs of current=
 implementation which uses "set". Idea of multiple WINS servers slipped fro=
m my mind. I checked the code and we use "set + static" for the first serve=
r and "set" for the rest, if any. Will to the same here.


http://gerrit.openvpn.net/c/openvpn/+/321/comment/bf8912f9_5365fe44 :
PS1, Line 1406:     if (addr_len > 0 || msg->header.type =3D=3D msg_del_win=
s_cfg)
> Is there ever a case where this would be false?
Normally no, but this request comes from unprivileged userspace process, wh=
ich we probably do not want to trust.


http://gerrit.openvpn.net/c/openvpn/+/321/comment/0b1bcdb1_cc02227e :
PS1, Line 1436:     if (msg->addr_len > 0)
> Nitpick: Should be addr_len, not msg->addr_len
Should not matter here, copypaste from similar DNS function. But I can chan=
ge it.



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
Gerrit-Attention: selvanair <selva.nair@...277...>
Gerrit-Comment-Date: Mon, 31 Jul 2023 11:28:31 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--eeLvlh4NU4E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos, selvanair. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/321/comment/6605e8bb_4222a8d1">Patch Set #1, Line=
 1089:</a> <code style=3D"font-family:monospace,monospace"> * @param  actio=
n      &quot;delete&quot; or &quot;add&quot;</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This say=
s &quot;add&quot; but the rest of the function seems to use &quot;set&quot;=
. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Right. I copypasted it from DNS version which uses add.</p></=
li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/321/comment/b9b566c=
1_c7e3b460">Patch Set #1, Line 1094:</a> <code style=3D"font-family:monospa=
ce,monospace"> * if action =3D &quot;set&quot; then &quot;static&quot; is a=
dded before $addr</code></p><p><blockquote style=3D"border-left: 1px solid =
#aaa; margin: 10px 0; padding: 0 10px;">Why are you using &quot;set&quot; h=
ere? The documentation (https://learn.microsoft. [=E2=80=A6]</blockquote></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Good point. Th=
e reason I use &quot;set&quot; is because I checked the logs of current imp=
lementation which uses &quot;set&quot;. Idea of multiple WINS servers slipp=
ed from my mind. I checked the code and we use &quot;set + static&quot; for=
 the first server and &quot;set&quot; for the rest, if any. Will to the sam=
e here.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"m=
argin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/321/co=
mment/bf8912f9_5365fe44">Patch Set #1, Line 1406:</a> <code style=3D"font-f=
amily:monospace,monospace">    if (addr_len &gt; 0 || msg-&gt;header.type =
=3D=3D msg_del_wins_cfg)</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">Is there ever a case where t=
his would be false?</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Normally no, but this request comes from unprivileged u=
serspace process, which we probably do not want to trust.</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/321/comment/0b1bcdb1_cc02227e">=
Patch Set #1, Line 1436:</a> <code style=3D"font-family:monospace,monospace=
">    if (msg-&gt;addr_len &gt; 0)</code></p><p><blockquote style=3D"border=
-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Nitpick: Should be=
 addr_len, not msg-&gt;addr_len</blockquote></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">Should not matter here, copypaste from simi=
lar DNS function. But I can change it.</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail">chan=
ge 321</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/321?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: selvanair &lt;selva.nair@...493...=
277...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 31 Jul 2023 11:28:31=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--eeLvlh4NU4E=--

