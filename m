From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 5 Aug 2025 07:56:28 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fb2a91f5448bca36d7a956fd0c96c3bd455c7e57-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bHABOEz2lFE="; charset=UTF-8
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

--bHABOEz2lFE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introduce asymmetric peer-id
......................................................................


Patch Set 2:

(5 comments)

File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/d20f4c46_6ddf1dff :
PS2, Line 1816:         uint32_t peer_id =3D extract_asymmetric_peer_id(pee=
r_info);
> I am somehow missing the client side/p2p that does the same and also call=
s extract_asymmetric_peer_i [=E2=80=A6]
Acknowledged


File src/openvpn/push.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/dfe60a3c_ec0e72ed :
PS2, Line 657:                         tls_multi->rx_peer_id);
> This will instruct the client to use that peer-id on both send/receive. [=
=E2=80=A6]
ok but what about the mapping? we're using the current peer-id assigned by =
the server as index to keep track of the instances, should we implement a d=
ifferent kind of mapping? Of curse on server side I will prepend to the buf=
fer the tx_peer_id (if supported) along with the opcode but yeah the client=
 will keep prepending the old one.


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/7a3b0954_5bc84265 :
PS2, Line 2043:         buf_printf(&out, "ID=3D%x\n", peer_id);
> This need to be guarded by the actual DCO capability. [=E2=80=A6]
Acknowledged


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/1f01bfff_92f0595e :
PS2, Line 431:         multi->tx_peer_id =3D  2033;
> Why the hardcoded 2033 here? Shouldn't be also  0x76706e; /* 'v' 'p' 'n' =
*/ ?
yeah that was just for testing purposes, will fix this.


http://gerrit.openvpn.net/c/openvpn/+/1089/comment/32efaf15_5871df14 :
PS2, Line 474:                 multi->rx_peer_id =3D (peerid[0] << 16) + (p=
eerid[1] << 8) + peerid[2];
> Shouldn't there be code here
So you're saying we should keep the peer_id field and also the rx_peer_id a=
nd tx_peer_id but use them only if supported?



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
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 05 Aug 2025 07:56:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: comment

--bHABOEz2lFE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">View =
Change</a></p><p>5 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/multi.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1089/comment/d20f4c46_6ddf1dff">Patch Set #2, Line 1816:</=
a> <code style=3D"font-family:monospace,monospace">        uint32_t peer_id=
 =3D extract_asymmetric_peer_id(peer_info);</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I am som=
ehow missing the client side/p2p that does the same and also calls extract_=
asymmetric_peer_i [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Acknowledged</p></li></ul></li><li style=3D"m=
argin: 0; padding: 0;"><p>File src/openvpn/push.c:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1089/comment/dfe60a3c_ec0e72ed">Patch Set #2, Line 657:</a> <code style=3D=
"font-family:monospace,monospace">                        tls_multi-&gt;rx_=
peer_id);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">This will instruct the client to use that p=
eer-id on both send/receive. [=E2=80=A6]</blockquote></p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">ok but what about the mapping? we&=
#39;re using the current peer-id assigned by the server as index to keep tr=
ack of the instances, should we implement a different kind of mapping? Of c=
urse on server side I will prepend to the buffer the tx_peer_id (if support=
ed) along with the opcode but yeah the client will keep prepending the old =
one.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1089/comment/7a3b0954_5bc84265">Patch =
Set #2, Line 2043:</a> <code style=3D"font-family:monospace,monospace">    =
    buf_printf(&amp;out, &quot;ID=3D%x\n&quot;, peer_id);</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">This need to be guarded by the actual DCO capability. [=E2=80=A6]</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Ackn=
owledged</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src=
/openvpn/ssl_ncp.c:</p><ul style=3D"list-style: none; padding: 0;"><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment/1f01bfff_92f0595e=
">Patch Set #2, Line 431:</a> <code style=3D"font-family:monospace,monospac=
e">        multi-&gt;tx_peer_id =3D  2033;</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Why the =
hardcoded 2033 here? Shouldn&#39;t be also  0x76706e; /* &#39;v&#39; &#39;p=
&#39; &#39;n&#39; */ ?</blockquote></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">yeah that was just for testing purposes, will fix th=
is.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comme=
nt/32efaf15_5871df14">Patch Set #2, Line 474:</a> <code style=3D"font-famil=
y:monospace,monospace">                multi-&gt;rx_peer_id =3D (peerid[0] =
&lt;&lt; 16) + (peerid[1] &lt;&lt; 8) + peerid[2];</code></p><p><blockquote=
 style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Sh=
ouldn&#39;t there be code here</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">So you&#39;re saying we should keep the peer=
_id field and also the rx_peer_id and tx_peer_id but use them only if suppo=
rted?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1089?usp=3Demail">change 1089</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Emai=
lMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/=
ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1089?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

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
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 05 Aug 2025 07:56:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--bHABOEz2lFE=--

