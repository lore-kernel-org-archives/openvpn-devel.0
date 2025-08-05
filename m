From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 5 Aug 2025 12:22:11 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: arne-openvpn@...1227..., gianmarco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8390654e74e78b1c6c5f074bf1b49d08a5521628-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="x04Sl0PU2lU="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--x04Sl0PU2lU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introduce asymmetric peer-id
......................................................................


Patch Set 2:

(2 comments)

File src/openvpn/push.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/098ded6f_b8a7adfd :
PS2, Line 657:                         tls_multi->rx_peer_id);
> ok but what about the mapping? we're using the current peer-id assigned b=
y the server as index to ke [=E2=80=A6]
Yes, but the idea of the protocol is:

- server pushes peer-id: client uses *same* peer-id for send and receive.
- server pushes nothing but has ID=3D in its own peer-info, client reconigs=
es that the peer is supporting assymetric peer-id and uses the peer's ID fo=
r sending packets and expecting the id the ID it send in peerinfo for incom=
ing packets.


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/d2c5201c_e34ffb2d :
PS2, Line 474:                 multi->rx_peer_id =3D (peerid[0] << 16) + (p=
eerid[1] << 8) + peerid[2];
> So you're saying we should keep the peer_id field and also the rx_peer_id=
 and tx_peer_id but use the [=E2=80=A6]
I missing the code that implements the asymmetric peer-id here completely i=
s what I am saying. Either the code to parse the ID=3Dxyz of the peer is co=
mpletely missing or I overlooked it.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 05 Aug 2025 12:22:11 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Comment-In-Reply-To: its_Giaan <gianmarco@...2726...>
Gerrit-MessageType: comment

--x04Sl0PU2lU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/push.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1089/comment/098ded6f_b8a7adfd">Patch Set #2, Line 657:</a>=
 <code style=3D"font-family:monospace,monospace">                        tl=
s_multi-&gt;rx_peer_id);</code></p><p><blockquote style=3D"border-left: 1px=
 solid #aaa; margin: 10px 0; padding: 0 10px;">ok but what about the mappin=
g? we&#39;re using the current peer-id assigned by the server as index to k=
e [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Yes, but the idea of the protocol is:</p><ul><li>server pushe=
s peer-id: client uses *same* peer-id for send and receive.</li><li>server =
pushes nothing but has ID=3D in its own peer-info, client reconigses that t=
he peer is supporting assymetric peer-id and uses the peer&#39;s ID for sen=
ding packets and expecting the id the ID it send in peerinfo for incoming p=
ackets.</li></ul></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fil=
e src/openvpn/ssl_ncp.c:</p><ul style=3D"list-style: none; padding: 0;"><li=
 style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment/d2c5201c_e34=
ffb2d">Patch Set #2, Line 474:</a> <code style=3D"font-family:monospace,mon=
ospace">                multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; 16) + =
(peerid[1] &lt;&lt; 8) + peerid[2];</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">So you&#39;re say=
ing we should keep the peer_id field and also the rx_peer_id and tx_peer_id=
 but use the [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">I missing the code that implements the asymmetric =
peer-id here completely is what I am saying. Either the code to parse the I=
D=3Dxyz of the peer is completely missing or I overlooked it.</p></li></ul>=
</li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1089?usp=3Demail">change 1089</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Dem=
ail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3ba=
b3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 05 Aug 2025 12:22:11=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: its_Giaan &lt;gianmarco@...220...=
..2726...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--x04Sl0PU2lU=--

