From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 26 Sep 2023 10:37:52 +0000
In-Reply-To: <gerrit.1695213156000.If4e9c2e58441efb3fd00872cd62d1cc6c607f160@...2715...>
References: <gerrit.1695213156000.If4e9c2e58441efb3fd00872cd62d1cc6c607f160@...2715...>
Reply-To: frank@...2641..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <48f7211ffb8b787a50f7998ab04a95035e3578a0-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="c581Lp51/6s="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]:
 dev-tools/gerrit-send-mail.py: tool to send Gerrit patchsets to Patch...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: d12fk <heiko@...515...>, cron2 <gert@...1296...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--c581Lp51/6s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, d12fk.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/361?usp=3Demail )

Change subject: dev-tools/gerrit-send-mail.py: tool to send Gerrit patchset=
s to Patchwork
......................................................................


Patch Set 4:

(1 comment)

File dev-tools/gerrit-send-mail.py:

http://gerrit.openvpn.net/c/openvpn/+/361/comment/6568c48d_82c7d5d0 :
PS3, Line 47:                 ack =3D "{} <{}>".format(reviewer.get("displa=
y_name", reviewer["name"]), reviewer.get("email", reviewer["name"]))
> I would be in favor of f-string everywhere, they are just so much easier =
to read and actually faster [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/361?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If4e9c2e58441efb3fd00872cd62d1cc6c607f160
Gerrit-Change-Number: 361
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Tue, 26 Sep 2023 10:37:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: d12fk <heiko@...515...>
Gerrit-MessageType: comment

--c581Lp51/6s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, d12fk. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/361?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File dev-tools/gerrit-send-mail.py:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/361/comment/6568c48d_82c7d5d0">Patch Set #3, Line =
47:</a> <code style=3D"font-family:monospace,monospace">                ack=
 =3D &quot;{} &lt;{}&gt;&quot;.format(reviewer.get(&quot;display_name&quot;=
, reviewer[&quot;name&quot;]), reviewer.get(&quot;email&quot;, reviewer[&qu=
ot;name&quot;]))</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">I would be in favor of f-string ever=
ywhere, they are just so much easier to read and actually faster [=E2=80=A6=
]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;=
">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/361?usp=3Demail">change 361</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/361?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If4e9c2e58441efb3fd00872cd62=
d1cc6c607f160 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 361 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 26 Sep 2023 10:37:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--c581Lp51/6s=--

