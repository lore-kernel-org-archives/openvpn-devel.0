From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Sun, 8 Oct 2023 09:47:43 +0000
In-Reply-To: <gerrit.1691675487000.I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7@...2715...>
References: <gerrit.1691675487000.I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <db0226b23d39aa8ad4aff199c18d2fd63ae08d6c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KqJQt781Qvc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add warning if a p2p
 NCP client connects to a p2mp server
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KqJQt781Qvc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/323?usp=3Demail )

Change subject: Add warning if a p2p NCP client connects to a p2mp server
......................................................................


Patch Set 2:

(2 comments)

File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/323/comment/6defb60e_c19f4781 :
PS1, Line 262:     /* For client doing the newer version of NCP (that send =
IV_CIPHER)
> Also should be "IV_CIPHERS"
Done


http://gerrit.openvpn.net/c/openvpn/+/323/comment/58e912f0_7db474a0 :
PS1, Line 270:     if (extract_iv_proto(peer_info) & IV_PROTO_NCP_P2P)
> This function is only called from multi_client_set_protocol_options which=
 already extracts proto and [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I85ae4e1167e1395b4f59d5d0ecf6c38befcaa8a7
Gerrit-Change-Number: 323
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sun, 08 Oct 2023 09:47:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--KqJQt781Qvc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_ncp.c:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/323/comment/6defb60e_c19f4781">Patch Set #1, Line 262:</a=
> <code style=3D"font-family:monospace,monospace">    /* For client doing t=
he newer version of NCP (that send IV_CIPHER)</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Also sh=
ould be &quot;IV_CIPHERS&quot;</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/323/comment/58e912f0_7db474a0">Patch Set #1, Line 270=
:</a> <code style=3D"font-family:monospace,monospace">    if (extract_iv_pr=
oto(peer_info) &amp; IV_PROTO_NCP_P2P)</code></p><p><blockquote style=3D"bo=
rder-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This function =
is only called from multi_client_set_protocol_options which already extract=
s proto and [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/323?usp=3Demail">change 323</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/323?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I85ae4e1167e1395b4f59d5d0ecf=
6c38befcaa8a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 323 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 08 Oct 2023 09:47:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--KqJQt781Qvc=--

