From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 5 May 2025 07:22:29 +0000
In-Reply-To: <gerrit.1744809221000.I009f4e7ad38636f1c0b78d267561194c2bb4c051@...2715...>
References: <gerrit.1744809221000.I009f4e7ad38636f1c0b78d267561194c2bb4c051@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726..., gert@...1296...
Message-ID: <902983bc9406dd3f0c944f044e9994cf568a953a-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KLq05UccLpE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: dco_linux: Introduce
 new uAPIs
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KLq05UccLpE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/941?usp=3Demail )

Change subject: dco_linux: Introduce new uAPIs
......................................................................


Patch Set 5:

(4 comments)

File src/openvpn/dco_linux.c:

http://gerrit.openvpn.net/c/openvpn/+/941/comment/42a3e9d5_a3241db0 :
PS4, Line 547:     return -1;
> this change looks unneccessary?
Done


http://gerrit.openvpn.net/c/openvpn/+/941/comment/72dedff9_08f21440 :
PS4, Line 574: }
> same here... [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/941/comment/88df7038_9eb77ae3 :
PS4, Line 591:     keyconf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);
> why wrap differently, and not keep `struct nlattr * nla_nest_start()... [=
=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/941/comment/fd7c904e_d3273a61 :
PS4, Line 860:         case OVPN_CMD_KEY_SWAP_NTF:
> what is KEY_SWAP_NTF?  That's a new thing :-)
The 'NTF' prefix indicates that the message comes from the kernel module. S=
o we can distinguish between messages sent and received.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I009f4e7ad38636f1c0b78d267561194c2bb4c051
Gerrit-Change-Number: 941
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Mon, 05 May 2025 07:22:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--KLq05UccLpE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail">View C=
hange</a></p><p>4 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_linux.c:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/941/comment/42a3e9d5_a3241db0">Patch Set #4, Line 547:<=
/a> <code style=3D"font-family:monospace,monospace">    return -1;</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">this change looks unneccessary?</blockquote></p><p style=3D"w=
hite-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/941/comment/72dedff9_08f21440">Patch S=
et #4, Line 574:</a> <code style=3D"font-family:monospace,monospace">}</cod=
e></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; =
padding: 0 10px;">same here... [=E2=80=A6]</blockquote></p><p style=3D"whit=
e-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"margin=
: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/941/comment/88df7038_9eb77ae3">Patch Set =
#4, Line 591:</a> <code style=3D"font-family:monospace,monospace">    keyco=
nf =3D nla_nest_start(nl_msg, OVPN_A_KEYCONF);</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">why wr=
ap differently, and not keep `struct nlattr * nla_nest_start()... [=E2=80=
=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-wo=
rd;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D=
"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/941/=
comment/fd7c904e_d3273a61">Patch Set #4, Line 860:</a> <code style=3D"font-=
family:monospace,monospace">        case OVPN_CMD_KEY_SWAP_NTF:</code></p><=
p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding=
: 0 10px;">what is KEY_SWAP_NTF?  That&#39;s a new thing :-)</blockquote></=
p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">The &#39;NTF&#=
39; prefix indicates that the message comes from the kernel module. So we c=
an distinguish between messages sent and received.</p></li></ul></li></ul><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/941?usp=
=3Demail">change 941</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/941?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I009f4e7ad38636f1c0b78d26756=
1194c2bb4c051 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 941 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 05 May 2025 07:22:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--KLq05UccLpE=--

