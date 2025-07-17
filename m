From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 17 Jul 2025 09:43:55 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: arne-openvpn@...1227..., gianmarco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <df4dff61d6219b83285cee7f52de8682bb3e347f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9RPE3IrHrTg="; charset=UTF-8
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

--9RPE3IrHrTg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introduce asymmetric peer-id
......................................................................


Patch Set 2: Code-Review-2

(6 comments)

Patchset:

PS2:
I think there are still some things that need to be fixed. See comments


File src/openvpn/multi.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/7be28da8_ce83b435 :
PS2, Line 1816:         uint32_t peer_id =3D extract_asymmetric_peer_id(pee=
r_info);
I am somehow missing the client side/p2p that does the same and also calls =
extract_asymmetric_peer_id to figure out what peer-id the server wants to u=
se.


File src/openvpn/push.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/ad29de27_05d54fe8 :
PS2, Line 657:                         tls_multi->rx_peer_id);
This will instruct the client to use that peer-id on both send/receive. The=
 idea was to *not* push peer-id in this scenario but rather have both sides=
 see that if the other peer has ID=3D in their peerinfo then they both swit=
ch to assymmetric peer-id


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/231475b7_833b9982 :
PS2, Line 2043:         buf_printf(&out, "ID=3D%x\n", peer_id);
This need to be guarded by the actual DCO capability. We cannot announce th=
is if the DCO module/implementation then cannot actually support assymetric=
 ID support.


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/5800ddd8_05764f00 :
PS2, Line 431:         multi->tx_peer_id =3D  2033;
Why the hardcoded 2033 here? Shouldn't be also  0x76706e; /* 'v' 'p' 'n' */=
 ?


http://gerrit.openvpn.net/c/openvpn/+/1089/comment/5a725408_1afd7517 :
PS2, Line 474:                 multi->rx_peer_id =3D (peerid[0] << 16) + (p=
eerid[1] << 8) + peerid[2];
Shouldn't there be code here



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
Gerrit-Comment-Date: Thu, 17 Jul 2025 09:43:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--9RPE3IrHrTg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">V=
iew Change</a></p><p>6 comments:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1089?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">I think there are still some things that ne=
ed to be fixed. See comments</p></li></ul></li><li style=3D"margin: 0; padd=
ing: 0;"><p>File src/openvpn/multi.c:</p><ul style=3D"list-style: none; pad=
ding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment=
/7be28da8_ce83b435">Patch Set #2, Line 1816:</a> <code style=3D"font-family=
:monospace,monospace">        uint32_t peer_id =3D extract_asymmetric_peer_=
id(peer_info);</code></p><p style=3D"white-space: pre-wrap; word-wrap: brea=
k-word;">I am somehow missing the client side/p2p that does the same and al=
so calls extract_asymmetric_peer_id to figure out what peer-id the server w=
ants to use.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File=
 src/openvpn/push.c:</p><ul style=3D"list-style: none; padding: 0;"><li sty=
le=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment/ad29de27_05d54fe=
8">Patch Set #2, Line 657:</a> <code style=3D"font-family:monospace,monospa=
ce">                        tls_multi-&gt;rx_peer_id);</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">This will instruct the c=
lient to use that peer-id on both send/receive. The idea was to *not* push =
peer-id in this scenario but rather have both sides see that if the other p=
eer has ID=3D in their peerinfo then they both switch to assymmetric peer-i=
d</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvp=
n/ssl.c:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1089/comment/231475b7_833b9982">Patch Set=
 #2, Line 2043:</a> <code style=3D"font-family:monospace,monospace">       =
 buf_printf(&amp;out, &quot;ID=3D%x\n&quot;, peer_id);</code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">This need to be guarded =
by the actual DCO capability. We cannot announce this if the DCO module/imp=
lementation then cannot actually support assymetric ID support.</p></li></u=
l></li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_ncp.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1089/comment/5800ddd8_05764f00">Patch Set #2, Line=
 431:</a> <code style=3D"font-family:monospace,monospace">        multi-&gt=
;tx_peer_id =3D  2033;</code></p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Why the hardcoded 2033 here? Shouldn&#39;t be also  0x7670=
6e; /* &#39;v&#39; &#39;p&#39; &#39;n&#39; */ ?</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1089/comment/5a725408_1afd7517">Patch Set=
 #2, Line 474:</a> <code style=3D"font-family:monospace,monospace">        =
        multi-&gt;rx_peer_id =3D (peerid[0] &lt;&lt; 16) + (peerid[1] &lt;&=
lt; 8) + peerid[2];</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Shouldn&#39;t there be code here</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Dem=
ail">change 1089</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 17 Jul 2025 09:43:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--9RPE3IrHrTg=--

