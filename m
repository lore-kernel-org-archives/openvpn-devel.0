From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 24 Mar 2026 16:20:57 +0000
In-Reply-To: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
References: <gerrit.1770986118000.I8b0d1cad7062856abcc40c4e16ec93b45295bbd3@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <43961da5ecb0370e4bea2329d2c96e50868f1045-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mF7x1WgoGlc="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add support for user
 defined network namespace
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mF7x1WgoGlc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change by its_Giaan. ( http://gerrit.=
openvpn.net/c/openvpn/+/1521?usp=3Demail )

Change subject: Add support for user defined network namespace
......................................................................


Patch Set 7:

(5 comments)

File src/openvpn/networking.h:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/4ec40e14_ab031002?usp=3D=
email :
PS6, Line 42: /* Only the iproute2 backend implements these functions,
> This comment is outdated
Done


File src/openvpn/networking_sitnl.h:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/7944c4f7_347e1ae4?usp=3D=
email :
PS6, Line 113:  * (/var/run/netns).
> `/run/netns`
This part has been removed, so no fix longer needed.


File src/openvpn/networking_sitnl.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/c17f7f0d_724d403e?usp=3D=
email :
PS6, Line 207:             return -1;
> Note that this return value is meaningless since no code ever checks it. =
[=E2=80=A6]
Done


File src/openvpn/tun.c:

http://gerrit.openvpn.net/c/openvpn/+/1521/comment/32fdbd8e_d4ad4523?usp=3D=
email :
PS6, Line 2185:             int ret =3D net_iface_move_netns(ifr.ifr_name, =
ctx->netns);
> One interesting problem I encountered is that the usual way of auto-namin=
g tun devices doesn't reall [=E2=80=A6]
Thanks for spotting this, that was indeed an intresting problem.
We got around this by creating the interface directly into the target names=
pace, so auto-naming will continue to work as usually.


http://gerrit.openvpn.net/c/openvpn/+/1521/comment/ad76eec1_abbaa8dc?usp=3D=
email :
PS6, Line 2188:                 msg(M_WARN | M_ERRNO, "Note: Cannot move de=
v %s to network namespace %s", ifr.ifr_name, ctx->netns);
> I would go for M_ERR here. I would consider this a fatal error.
This part has been removed, so no fix longer needed.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16ec93b45295bbd3
Gerrit-Change-Number: 1521
Gerrit-PatchSet: 7
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 24 Mar 2026 16:20:57 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>

--mF7x1WgoGlc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3Demail">View =
Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/networking.h:</p>=
<ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1521/comment/4ec40e14_ab031002?usp=3Demail">Patch Set=
 #6, Line 42:</a> <code style=3D"font-family:monospace,monospace">/* Only t=
he iproute2 backend implements these functions,</code></p><p><blockquote st=
yle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This =
comment is outdated</blockquote></p><p class=3D"blocks" style=3D"white-spac=
e: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"ma=
rgin: 0; padding: 0;"><p>File src/openvpn/networking_sitnl.h:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1521/comment/7944c4f7_347e1ae4?usp=3Demail">Patch Set #6, Line=
 113:</a> <code style=3D"font-family:monospace,monospace"> * (/var/run/netn=
s).</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: =
10px 0; padding: 0 10px;">`/run/netns`</blockquote></p><p class=3D"blocks" =
style=3D"white-space: pre-wrap; word-wrap: break-word;">This part has been =
removed, so no fix longer needed.</p></li></ul></li><li style=3D"margin: 0;=
 padding: 0;"><p>File src/openvpn/networking_sitnl.c:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1521/comment/c17f7f0d_724d403e?usp=3Demail">Patch Set #6, Line 207:</a>=
 <code style=3D"font-family:monospace,monospace">            return -1;</co=
de></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0;=
 padding: 0 10px;">Note that this return value is meaningless since no code=
 ever checks it. [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><li st=
yle=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun.c:</p><ul style=3D"l=
ist-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"=
><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1521/comment/32fdbd8e_d4ad4523?usp=3Demail">Patch Set #6, Line 2185=
:</a> <code style=3D"font-family:monospace,monospace">            int ret =
=3D net_iface_move_netns(ifr.ifr_name, ctx-&gt;netns);</code></p><p><blockq=
uote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;=
">One interesting problem I encountered is that the usual way of auto-namin=
g tun devices doesn&#39;t reall [=E2=80=A6]</blockquote></p><p class=3D"blo=
cks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Thanks for spo=
tting this, that was indeed an intresting problem.<br>We got around this by=
 creating the interface directly into the target namespace, so auto-naming =
will continue to work as usually.</p></li><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1521/comment/ad76eec1_abbaa8dc?usp=3Demail">Patch Set #=
6, Line 2188:</a> <code style=3D"font-family:monospace,monospace">         =
       msg(M_WARN | M_ERRNO, &quot;Note: Cannot move dev %s to network name=
space %s&quot;, ifr.ifr_name, ctx-&gt;netns);</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I would=
 go for M_ERR here. I would consider this a fatal error.</blockquote></p><p=
 class=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">T=
his part has been removed, so no fix longer needed.</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=
=3Demail">change 1521</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1521?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b0d1cad7062856abcc40c4e16e=
c93b45295bbd3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 24 Mar 2026 16:20:57=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>

</body></html>=

--mF7x1WgoGlc=--

