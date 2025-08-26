From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 26 Aug 2025 15:31:15 +0000
In-Reply-To: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
References: <gerrit.1737029493000.Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277..., gert@...1296...
Message-ID: <e0b884269dd878d7509acb46fc4fd1117df44264-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hMckEdR8wio="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: PUSH_UPDATE message
 sender: enabling the server to send PUSH_UPDATE c...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hMckEdR8wio=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos, stipa.

mrbff has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/869?usp=3Demail )

Change subject: PUSH_UPDATE message sender: enabling the server to send PUS=
H_UPDATE control messages
......................................................................


Patch Set 25:

(1 comment)

Patchset:

PS23:
> About the first point, i fixed the restarting in the server but the "send=
ing a wrong message and con [=E2=80=A6]
* Regarding the second point, the odd timing it's because the message is ju=
st enqueued (by `send_control_channel_string()`) but it gets "on the wire" =
only when `tls_process()` is finally called, so you could get from less tha=
n 1 up to around 10 seconds of latency from when the command is injected th=
rough management to when the packet leave the server instance.


* Regarding 3rd point instead, yes, the `/0` was an issue, i was misusing a=
 function's parameter. For the push-update usage i think the only 'correct'=
 way of pushing an ifconfig option should be something like `ifconfig 10.20=
4.2.47 255.255.255.0` (shouldn't we use it only in subnet mode?) with the p=
ushed ip in the same subnet of the server virtual ip, in this case `10.204.=
2.45/24` for example (or do we want to update the server ip too?) . I mean,=
 this look to me the only practical use case but maybe i'm missing somethin=
g, if so please tell me.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d1a323ed8df3fc
Gerrit-Change-Number: 869
Gerrit-PatchSet: 25
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Tue, 26 Aug 2025 15:31:15 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: mrbff <marco@...2726...>
Gerrit-MessageType: comment

--hMckEdR8wio=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos, s=
tipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/8=
69?tab=3Dcomments">Patch Set #23:</a> </p><p><blockquote style=3D"border-le=
ft: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">About the first point=
, i fixed the restarting in the server but the &quot;sending a wrong messag=
e and con [=E2=80=A6]</blockquote></p><ul><li>Regarding the second point, t=
he odd timing it&#39;s because the message is just enqueued (by `send_contr=
ol_channel_string()`) but it gets &quot;on the wire&quot; only when `tls_pr=
ocess()` is finally called, so you could get from less than 1 up to around =
10 seconds of latency from when the command is injected through management =
to when the packet leave the server instance.</li></ul><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;"></p><ul><li>Regarding 3rd point inst=
ead, yes, the `/0` was an issue, i was misusing a function&#39;s parameter.=
 For the push-update usage i think the only &#39;correct&#39; way of pushin=
g an ifconfig option should be something like `ifconfig 10.204.2.47 255.255=
.255.0` (shouldn&#39;t we use it only in subnet mode?) with the pushed ip i=
n the same subnet of the server virtual ip, in this case `10.204.2.45/24` f=
or example (or do we want to update the server ip too?) . I mean, this look=
 to me the only practical use case but maybe i&#39;m missing something, if =
so please tell me.</li></ul></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/869?usp=3Demail">change 869</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/869?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie82bcc7a8e583de9156b185d71d=
1a323ed8df3fc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 869 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 25 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 26 Aug 2025 15:31:15=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: mrbff &lt;marco@...2804...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--hMckEdR8wio=--

