From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 29 Sep 2025 09:37:04 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <2055e30e29b4776a5f310d0cf95344bba10d41f5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="r1yIkdjkiiI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: multipeer: introduce
 asymmetric peer-id
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--r1yIkdjkiiI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introduce asymmetric peer-id
......................................................................


Patch Set 3:

(3 comments)

File src/openvpn/push.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/643315b6_ec74dded :
PS2, Line 657:                         tls_multi->rx_peer_id);
> Yes, but the idea of the protocol is: [=E2=80=A6]
Done


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/4e416967_34f098a3 :
PS2, Line 431:         multi->tx_peer_id =3D  2033;
> yeah that was just for testing purposes, will fix this.
Done


http://gerrit.openvpn.net/c/openvpn/+/1089/comment/110f46aa_7a264227 :
PS2, Line 474:                 multi->rx_peer_id =3D (peerid[0] << 16) + (p=
eerid[1] << 8) + peerid[2];
> I missing the code that implements the asymmetric peer-id here completely=
 is what I am saying. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 29 Sep 2025 09:37:04 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: its_Giaan <gianmarco@...2726...>
Gerrit-MessageType: comment

--r1yIkdjkiiI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">View =
Change</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1089/comment/643315b6_ec74dded">Patch Set #2, Line 657:</a>=
 <code style=3D"font-family:monospace,monospace">                        tl=
s_multi-&gt;rx_peer_id);</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">Yes, but the idea of the pro=
tocol is: [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/ssl_ncp.c:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment=
/4e416967_34f098a3">Patch Set #2, Line 431:</a> <code style=3D"font-family:=
monospace,monospace">        multi-&gt;tx_peer_id =3D  2033;</code></p><p><=
blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0=
 10px;">yeah that was just for testing purposes, will fix this.</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment/110f46a=
a_7a264227">Patch Set #2, Line 474:</a> <code style=3D"font-family:monospac=
e,monospace">                multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; 1=
6) + (peerid[1] &lt;&lt; 8) + peerid[2];</code></p><p><blockquote style=3D"=
border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I missing th=
e code that implements the asymmetric peer-id here completely is what I am =
saying. [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">change 1089</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3ba=
b3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 29 Sep 2025 09:37:04=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: its_Giaan &lt;gianmarco@...220...=
..2726...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--r1yIkdjkiiI=--

