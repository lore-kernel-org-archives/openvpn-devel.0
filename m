From: "kallisti5 (Code Review)" <gerrit@...515...>
Date: Thu, 28 Nov 2024 15:14:24 +0000
In-Reply-To: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
References: <gerrit.1732634928000.I1a22724f28c5cd47f6df178b49f44087d7c2b6fd@...2715...>
Reply-To: alex@...2837..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <69873f4ef2b79d6dd8558a07ee051743ad0145d8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CAMXPAJOgsg="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Haiku: Add calls to
 manage routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CAMXPAJOgsg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

kallisti5 has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/688?usp=3Demail )

Change subject: Haiku: Add calls to manage routing table
......................................................................


Patch Set 11:

(10 comments)

Patchset:

PS10:
All complete.

I should note that the full functionality of these changes depends on https=
://review.haiku-os.org/c/haiku/+/8592

(tldr; we only accept "default" for the default gateway, while everyone els=
e seems to also accept 0.0.0.0 / ::.    Instead of hacking in "0.0.0.0 -> d=
efault" in the openvpn source code, I opted to add support for "0.0.0.0" as=
 the default gw in the route command of Haiku)

I'm planning on getting that change into the most recent stable release of =
Haiku as well to make sure openvpn works out of the box.


File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/688/comment/6ac793fe_ff5b6200 :
PS8, Line 1858:     {
> please remove this indentation level, it looks unnecessary. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/e0159a17_04786e1d :
PS8, Line 2350:     {
> same here
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/c21c4740_b10d021b :
PS8, Line 2543:     {
> same here. [=E2=80=A6]
I went ahead and added the IPv6 route addition code.

Our IPv6 stack exists, and is baseline functional, but it's not well tested=
 and has known faults (thus the priority was low)

However, our routing all should work fine... so I went ahead and implemente=
d the ipv6 route add call.


http://gerrit.openvpn.net/c/openvpn/+/688/comment/ef8e2b2d_3b195cb1 :
PS8, Line 3940:     if (sockfd < 0) {
> this is a style guide violation - normally, for first time submitters, I'=
d fix that on the fly but s [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/0e55a08d_ab176494 :
PS8, Line 3947:     if (ioctl(sockfd, SIOCGRTSIZE, &config, sizeof(struct i=
fconf)) < 0) {
> this
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/a3a35f3d_7632b680 :
PS8, Line 3954:         return;
> we require to always have braces, even if it's a single statement [=E2=80=
=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/15fc33c0_b4d9d006 :
PS8, Line 3961:     if (ioctl(sockfd, SIOCGRTTABLE, &config, sizeof(struct =
ifconf)) < 0) {
> bracket
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/eaf2eaa7_c865a3e5 :
PS8, Line 3969:     while (interface < end) {
> bracket
Done


http://gerrit.openvpn.net/c/openvpn/+/688/comment/f5cf04fe_ffc728c3 :
PS8, Line 3978:         if (route.destination !=3D NULL)
> these need braces...
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f44087d7c2b6fd
Gerrit-Change-Number: 688
Gerrit-PatchSet: 11
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Thu, 28 Nov 2024 15:14:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--CAMXPAJOgsg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail">View C=
hange</a></p><p>10 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/688?tab=3Dcomments">Patch Set #10:</a> </p><p style=3D"white-space: pre-wr=
ap; word-wrap: break-word;">All complete.</p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">I should note that the full functionality of t=
hese changes depends on https://review.haiku-os.org/c/haiku/+/8592</p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">(tldr; we only accept=
 &quot;default&quot; for the default gateway, while everyone else seems to =
also accept 0.0.0.0 / ::.    Instead of hacking in &quot;0.0.0.0 -&gt; defa=
ult&quot; in the openvpn source code, I opted to add support for &quot;0.0.=
0.0&quot; as the default gw in the route command of Haiku)</p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">I&#39;m planning on getting t=
hat change into the most recent stable release of Haiku as well to make sur=
e openvpn works out of the box.</p></li></ul></li><li style=3D"margin: 0; p=
adding: 0;"><p>File src/openvpn/route.c:</p><ul style=3D"list-style: none; =
padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688/comme=
nt/6ac793fe_ff5b6200">Patch Set #8, Line 1858:</a> <code style=3D"font-fami=
ly:monospace,monospace">    {</code></p><p><blockquote style=3D"border-left=
: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">please remove this inde=
ntation level, it looks unnecessary. [=E2=80=A6]</blockquote></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/688/comment/e0159a17_04786e1d">=
Patch Set #8, Line 2350:</a> <code style=3D"font-family:monospace,monospace=
">    {</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; marg=
in: 10px 0; padding: 0 10px;">same here</blockquote></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/688/comment/c21c4740_b10d021b">Patch Set #8,=
 Line 2543:</a> <code style=3D"font-family:monospace,monospace">    {</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">same here. [=E2=80=A6]</blockquote></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">I went ahead and added the IPv6 rou=
te addition code.</p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Our IPv6 stack exists, and is baseline functional, but it&#39;s not we=
ll tested and has known faults (thus the priority was low)</p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">However, our routing all shou=
ld work fine... so I went ahead and implemented the ipv6 route add call.</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688/comment/ef8e=
2b2d_3b195cb1">Patch Set #8, Line 3940:</a> <code style=3D"font-family:mono=
space,monospace">    if (sockfd &lt; 0) {</code></p><p><blockquote style=3D=
"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this is a s=
tyle guide violation - normally, for first time submitters, I&#39;d fix tha=
t on the fly but s [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/688/comment/0e55a08d_ab176494">Patch Set #8, Line 394=
7:</a> <code style=3D"font-family:monospace,monospace">    if (ioctl(sockfd=
, SIOCGRTSIZE, &amp;config, sizeof(struct ifconf)) &lt; 0) {</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">this</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/688/comment/a3a35f3d_7632b680">Patch Set #8, Line 3954:</a> <code style=
=3D"font-family:monospace,monospace">        return;</code></p><p><blockquo=
te style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">=
we require to always have braces, even if it&#39;s a single statement [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/6=
88/comment/15fc33c0_b4d9d006">Patch Set #8, Line 3961:</a> <code style=3D"f=
ont-family:monospace,monospace">    if (ioctl(sockfd, SIOCGRTTABLE, &amp;co=
nfig, sizeof(struct ifconf)) &lt; 0) {</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">bracket</block=
quote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</=
p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bot=
tom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688/comment/eaf=
2eaa7_c865a3e5">Patch Set #8, Line 3969:</a> <code style=3D"font-family:mon=
ospace,monospace">    while (interface &lt; end) {</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">br=
acket</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/6=
88/comment/f5cf04fe_ffc728c3">Patch Set #8, Line 3978:</a> <code style=3D"f=
ont-family:monospace,monospace">        if (route.destination !=3D NULL)</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">these need braces...</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demai=
l">change 688</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/688?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1a22724f28c5cd47f6df178b49f=
44087d7c2b6fd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 688 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 28 Nov 2024 15:14:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--CAMXPAJOgsg=--

