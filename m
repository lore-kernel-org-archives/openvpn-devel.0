From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 23 Jul 2025 21:55:04 +0000
In-Reply-To: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
References: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
Reply-To: antonio@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <bec2f9433a9bb3ccbc100b8f0178fc33aa5db0dd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SZDyMtYU9qI="; charset=UTF-8
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

--SZDyMtYU9qI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

ordex has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1100?usp=3Demail )

Change subject: dco_linux: fix async message reception
......................................................................


Patch Set 4:

(6 comments)

File src/openvpn/dco_linux.c:

http://gerrit.openvpn.net/c/openvpn/+/1100/comment/b17821a3_854b55f6 :
PS4, Line 170:  * Send a prepared netlink message and registers cb as callb=
ack if non-null.
> this comment needs changing, though... [=E2=80=A6]
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1100/comment/6d73e782_65951dfb :
PS4, Line 903:         msg(M_WARN, "%s: no peer-id provided in reply", __fu=
nc__);
> maybe change the "reply" to "whatever this message type is", similar to t=
he other "no peer-id provid [=E2=80=A6]
the difference is that here we print the function name, so the context is o=
bvious. In the other messages we only have the "ovpn-dco" prefix (because t=
hat code was all embedded in ovpn_handle_msg() before this patch).

I think it makes sense to follow your suggestion, but I will also switch to=
 the "ovpn-dco:" prefix


http://gerrit.openvpn.net/c/openvpn/+/1100/comment/69bbc8ae_718dd631 :
PS4, Line 938:         msg(M_WARN, "%s: no peer-id provided in reply", __fu=
nc__);
> as well
Acknowledged


http://gerrit.openvpn.net/c/openvpn/+/1100/comment/c0bbb1b8_731eaf6c :
PS4, Line 951:         struct multi_instance *mi =3D dco->c->multi->instanc=
es[peer_id];
> how can we ever end here?
check_timeout() for --inactive. In that code path we sadly check each peer =
one by one and thus we call PEER_GET on each specific peer one by one.


http://gerrit.openvpn.net/c/openvpn/+/1100/comment/25f2c886_37016329 :
PS4, Line 1182:             if (nlh->nlmsg_flags & NLM_F_MULTI)
> I'm not sure I understand this. [=E2=80=A6]
hehe!
Check: https://elixir.bootlin.com/linux/v6.16-rc6/source/include/uapi/linux=
/netlink.h#L63

This flag means this message is part of a set of messages, together forming=
 the actual reply.
We get this kind of reply when we issue a PEER_GET with no specific peer-id.
Which is what the P2MP code does to fetch the stats.

P2P will never call this because it always query its one specific peer.


http://gerrit.openvpn.net/c/openvpn/+/1100/comment/131162e2_128a7d4a :
PS4, Line 1189:             }
> I do wonder if this `if()` shouldn't just look at p->mode?  Since `multi`=
 does not want to deal with [=E2=80=A6]
as mentioned above, MODE_MP may still need to call ovpn_handle_peer()



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
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 23 Jul 2025 21:55:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--SZDyMtYU9qI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail">View =
Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.c:</p><=
ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1100/comment/b17821a3_854b55f6">Patch Set #4, Line 170=
:</a> <code style=3D"font-family:monospace,monospace"> * Send a prepared ne=
tlink message and registers cb as callback if non-null.</code></p><p><block=
quote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px=
;">this comment needs changing, though... [=E2=80=A6]</blockquote></p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li>=
<li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4p=
x;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100/comment/6d73e782_=
65951dfb">Patch Set #4, Line 903:</a> <code style=3D"font-family:monospace,=
monospace">        msg(M_WARN, &quot;%s: no peer-id provided in reply&quot;=
, __func__);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">maybe change the &quot;reply&quot; to &q=
uot;whatever this message type is&quot;, similar to the other &quot;no peer=
-id provid [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">the difference is that here we print the function na=
me, so the context is obvious. In the other messages we only have the &quot=
;ovpn-dco&quot; prefix (because that code was all embedded in ovpn_handle_m=
sg() before this patch).</p><p style=3D"white-space: pre-wrap; word-wrap: b=
reak-word;">I think it makes sense to follow your suggestion, but I will al=
so switch to the &quot;ovpn-dco:&quot; prefix</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1100/comment/69bbc8ae_718dd631">Patch Set #=
4, Line 938:</a> <code style=3D"font-family:monospace,monospace">        ms=
g(M_WARN, &quot;%s: no peer-id provided in reply&quot;, __func__);</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">as well</blockquote></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Acknowledged</p></li><li style=3D"margin: 0; padding:=
 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1100/comment/c0bbb1b8_731eaf6c">Patch Set #4, Line 951=
:</a> <code style=3D"font-family:monospace,monospace">        struct multi_=
instance *mi =3D dco-&gt;c-&gt;multi-&gt;instances[peer_id];</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">how can we ever end here?</blockquote></p><p style=3D"white-space: =
pre-wrap; word-wrap: break-word;">check_timeout() for --inactive. In that c=
ode path we sadly check each peer one by one and thus we call PEER_GET on e=
ach specific peer one by one.</p></li><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1100/comment/25f2c886_37016329">Patch Set #4, Line 1182:</a=
> <code style=3D"font-family:monospace,monospace">            if (nlh-&gt;n=
lmsg_flags &amp; NLM_F_MULTI)</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I&#39;m not sure I unde=
rstand this. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">hehe!<br>Check: https://elixir.bootlin.com/linux/v=
6.16-rc6/source/include/uapi/linux/netlink.h#L63</p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">This flag means this message is part of=
 a set of messages, together forming the actual reply.<br>We get this kind =
of reply when we issue a PEER_GET with no specific peer-id.<br>Which is wha=
t the P2MP code does to fetch the stats.</p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">P2P will never call this because it always quer=
y its one specific peer.</p></li><li style=3D"margin: 0; padding: 0 0 0 16p=
x;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1100/comment/131162e2_128a7d4a">Patch Set #4, Line 1189:</a> <co=
de style=3D"font-family:monospace,monospace">            }</code></p><p><bl=
ockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 1=
0px;">I do wonder if this `if()` shouldn&#39;t just look at p-&gt;mode?  Si=
nce `multi` does not want to deal with [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">as mentioned above, MODE=
_MP may still need to call ovpn_handle_peer()</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Dema=
il">change 1100</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 23 Jul 2025 21:55:04=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--SZDyMtYU9qI=--

