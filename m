From: "d12fk (Code Review)" <gerrit@...515...>
Date: Thu, 27 Mar 2025 01:28:37 +0000
In-Reply-To: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
References: <gerrit.1733989644000.I576e74f3276362606e9cbd50bb5adbebaaf209cc@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <3ba80217c64952f64d332024121c9ed61f8d0d01-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2ZgjVo4pdNA="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[master]: win: implement
 --dns option support with NRPT
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2ZgjVo4pdNA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/837?usp=3Demail )

Change subject: win: implement --dns option support with NRPT
......................................................................


Patch Set 14:

(2 comments)

File src/openvpnserv/interactive.c:

http://gerrit.openvpn.net/c/openvpn/+/837/comment/d4afefe5_56002315 :
PS14, Line 2259:         MsgToEventLog(M_SYSERR, TEXT("IsInterfaceConnected=
: "
> Sure. In my case it is probably Hyper-V virtual adapters. [=E2=80=A6]
The code fails now without error message if ConvertInterfaceGuidToLuid() fa=
ils. However, I wonder why it fails in the first place with those interface=
s. Basically that means that for any interface, where this conversion fails=
, there will be no exclude rules ever, and not even a diagnostic message to=
 explain this. Leaves an uneasy feeling behind for me.


http://gerrit.openvpn.net/c/openvpn/+/837/comment/085ad92a_b096baa2 :
PS14, Line 2510:     for (int i =3D 0; i < _countof(data); ++i)
> But there are: https://usercontent.irccloud-cdn.com/file/eJy2zlR6/image. =
[=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I576e74f3276362606e9cbd50bb5adbebaaf209cc
Gerrit-Change-Number: 837
Gerrit-PatchSet: 14
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Thu, 27 Mar 2025 01:28:37 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: d12fk <heiko@...515...>
Comment-In-Reply-To: stipa <lstipakov@...277...>
Gerrit-MessageType: comment

--2ZgjVo4pdNA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, stipa. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/837?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpnserv/interactive.c:=
</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; pad=
ding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/837/comment/d4afefe5_56002315">Patch Set #14, Lin=
e 2259:</a> <code style=3D"font-family:monospace,monospace">        MsgToEv=
entLog(M_SYSERR, TEXT(&quot;IsInterfaceConnected: &quot;</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">Sure. In my case it is probably Hyper-V virtual adapters. [=E2=80=A6]</=
blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">T=
he code fails now without error message if ConvertInterfaceGuidToLuid() fai=
ls. However, I wonder why it fails in the first place with those interfaces=
. Basically that means that for any interface, where this conversion fails,=
 there will be no exclude rules ever, and not even a diagnostic message to =
explain this. Leaves an uneasy feeling behind for me.</p></li><li style=3D"=
margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/837/comment/085ad92a_b096baa2">Pa=
tch Set #14, Line 2510:</a> <code style=3D"font-family:monospace,monospace"=
>    for (int i =3D 0; i &lt; _countof(data); ++i)</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Bu=
t there are: https://usercontent.irccloud-cdn.com/file/eJy2zlR6/image. [=E2=
=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/837?usp=3Demail">change 837</a>. To unsubscribe=
, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.=
net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/837?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change=
"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I576e74f3276362606e9cbd50bb5=
adbebaaf209cc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 837 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 27 Mar 2025 01:28:37=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: d12fk &lt;heiko@...515...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: stipa &lt;lstipakov@...1664...=
7...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--2ZgjVo4pdNA=--

