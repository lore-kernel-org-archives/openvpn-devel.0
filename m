From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 18:13:35 +0000
In-Reply-To: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
References: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <f58f5435b57f16431986ed8537bec76e83d394ac-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CPu+3HV88So="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: fix async
 message reception
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CPu+3HV88So=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1100?usp=3Demail )

Change subject: dco_linux: fix async message reception
......................................................................


Patch Set 4: Code-Review-1

(7 comments)

Patchset:

PS4:
more polish needed


File src/openvpn/dco_linux.c:

http://gerrit.openvpn.net/c/openvpn/+/1100/comment/24854dbd_add7b22c :
PS4, Line 170:  * Send a prepared netlink message and registers cb as callb=
ack if non-null.
this comment needs changing, though... "and registers cb"


http://gerrit.openvpn.net/c/openvpn/+/1100/comment/6281b84e_49f7ecd7 :
PS4, Line 903:         msg(M_WARN, "%s: no peer-id provided in reply", __fu=
nc__);
maybe change the "reply" to "whatever this message type is", similar to the=
 other "no peer-id provided" things?


http://gerrit.openvpn.net/c/openvpn/+/1100/comment/94873fa3_d40d8bb4 :
PS4, Line 938:         msg(M_WARN, "%s: no peer-id provided in reply", __fu=
nc__);
as well


http://gerrit.openvpn.net/c/openvpn/+/1100/comment/41388847_81aa443f :
PS4, Line 951:         struct multi_instance *mi =3D dco->c->multi->instanc=
es[peer_id];
how can we ever end here?


http://gerrit.openvpn.net/c/openvpn/+/1100/comment/5c6b04ae_b5f56bc3 :
PS4, Line 1182:             if (nlh->nlmsg_flags & NLM_F_MULTI)
I'm not sure I understand this.  p2mp peer messages are sent multicast, and=
 p2p messages not?  Or what does `NLM_F_MULTI` signal?


http://gerrit.openvpn.net/c/openvpn/+/1100/comment/a876ff1f_882629d9 :
PS4, Line 1189:             }
I do wonder if this `if()` shouldn't just look at p->mode?  Since `multi` d=
oes not want to deal with MODE_P2P, and _peer() now has extra code to deal =
with !MODE_P"P, just check beforehand?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23ad79e14844aefde9ece34dadef0b75ff267201
Gerrit-Change-Number: 1100
Gerrit-PatchSet: 4
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Wed, 23 Jul 2025 18:13:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--CPu+3HV88So=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail">V=
iew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1100?tab=3Dcomments">Patch Set #4:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">more polish needed</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.c:</p><ul styl=
e=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 =
16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1100/comment/24854dbd_add7b22c">Patch Set #4, Line 170:</a> <=
code style=3D"font-family:monospace,monospace"> * Send a prepared netlink m=
essage and registers cb as callback if non-null.</code></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">this comment needs changing, tho=
ugh... &quot;and registers cb&quot;</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1100/comment/6281b84e_49f7ecd7">Patch Set #4, Line 90=
3:</a> <code style=3D"font-family:monospace,monospace">        msg(M_WARN, =
&quot;%s: no peer-id provided in reply&quot;, __func__);</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">maybe change the &quot;r=
eply&quot; to &quot;whatever this message type is&quot;, similar to the oth=
er &quot;no peer-id provided&quot; things?</p></li><li style=3D"margin: 0; =
padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1100/comment/94873fa3_d40d8bb4">Patch Set #4, =
Line 938:</a> <code style=3D"font-family:monospace,monospace">        msg(M=
_WARN, &quot;%s: no peer-id provided in reply&quot;, __func__);</code></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">as well</p></li><=
li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px=
;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100/comment/41388847_8=
1aa443f">Patch Set #4, Line 951:</a> <code style=3D"font-family:monospace,m=
onospace">        struct multi_instance *mi =3D dco-&gt;c-&gt;multi-&gt;ins=
tances[peer_id];</code></p><p style=3D"white-space: pre-wrap; word-wrap: br=
eak-word;">how can we ever end here?</p></li><li style=3D"margin: 0; paddin=
g: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1100/comment/5c6b04ae_b5f56bc3">Patch Set #4, Line 1=
182:</a> <code style=3D"font-family:monospace,monospace">            if (nl=
h-&gt;nlmsg_flags &amp; NLM_F_MULTI)</code></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">I&#39;m not sure I understand this.  p2mp pe=
er messages are sent multicast, and p2p messages not?  Or what does `NLM_F_=
MULTI` signal?</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1100/comment/a876ff1f_882629d9">Patch Set #4, Line 1189:</a> <code style=
=3D"font-family:monospace,monospace">            }</code></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">I do wonder if this `if()` sho=
uldn&#39;t just look at p-&gt;mode?  Since `multi` does not want to deal wi=
th MODE_P2P, and _peer() now has extra code to deal with !MODE_P&quot;P, ju=
st check beforehand?</p></li></ul></li></ul><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail">change 1100</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1100?usp=3Demail"/><meta itemprop=3D"name" content=3D"=
View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23ad79e14844aefde9ece34dade=
f0b75ff267201 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1100 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Jul 2025 18:13:35=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--CPu+3HV88So=--

