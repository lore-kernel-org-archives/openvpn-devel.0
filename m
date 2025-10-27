From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 13:47:02 +0000
In-Reply-To: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
References: <gerrit.1752743854000.I0a13ee90b6706acf20eabcee3bab3f2dff639bf9@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <2da8d2c9c39b513cbbc31f5cb192b313ae6ebdbb-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LQEzz/a1T4w="; charset=UTF-8
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

--LQEzz/a1T4w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

its_Giaan has posted comments on this change by its_Giaan. ( http://gerrit.=
openvpn.net/c/openvpn/+/1089?usp=3Demail )

Change subject: multipeer: introduce asymmetric peer-id
......................................................................


Patch Set 5:

(8 comments)

Patchset:

PS4:
> The part that picks the "peer-id" pushed and parsed options. [=E2=80=A6]
Done


File src/openvpn/ssl.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/483a5681_27b0022b?usp=3D=
email :
PS4, Line 1179:     ret->rx_peer_id =3D MAX_PEER_ID;
> Add comment here that we also use the rx peer id to identify DCO clients =
as this has become now a im [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1089/comment/d7cabc51_e6990ae0?usp=3D=
email :
PS4, Line 1982:         }
> This is still not guarded by DCO capability. [=E2=80=A6]
Done


http://gerrit.openvpn.net/c/openvpn/+/1089/comment/c0fec251_e0eada21?usp=3D=
email :
PS4, Line 2165:     if (multi->rx_peer_id =3D=3D MAX_PEER_ID && session->op=
t->mode !=3D MODE_SERVER)
> This feel be a very hacky place to set the multi rx peer id. [=E2=80=A6]
I moved this into tls_multi_init_finalize(), hope that's fine.


File src/openvpn/ssl_ncp.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/74331eed_c592a014?usp=3D=
email :
PS4, Line 425:     if (tx_peer_id)
> This also need to take DCO capability into account.
Done


http://gerrit.openvpn.net/c/openvpn/+/1089/comment/c5e954b4_8a6a0a93?usp=3D=
email :
PS4, Line 450:         if (multi->use_peer_id)
> I think this parts needs to be skipped if we are using/negotiated asymmet=
ric peer-id as it would ove [=E2=80=A6]
Done


File src/openvpn/ssl_util.h:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/be89150e_3068de2f?usp=3D=
email :
PS4, Line 56: uint32_t extract_asymmetric_peer_id(const char *peer_info);
> Add doxygen please
Done


File src/openvpn/ssl_util.c:

http://gerrit.openvpn.net/c/openvpn/+/1089/comment/c1989b67_8f07aa92?usp=3D=
email :
PS4, Line 90:     return 0;
> 0 is a valid peer id. [=E2=80=A6]
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3bab3f2dff639bf9
Gerrit-Change-Number: 1089
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 27 Oct 2025 13:47:02 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>

--LQEzz/a1T4w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2, flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089?usp=3Demail">View =
Change</a></p><p>8 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-sty=
le: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p sty=
le=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/1089?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p><blockquote =
style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">The=
 part that picks the &quot;peer-id&quot; pushed and parsed options. [=E2=80=
=A6]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; wo=
rd-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; paddin=
g: 0;"><p>File src/openvpn/ssl.c:</p><ul style=3D"list-style: none; padding=
: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment/483=
a5681_27b0022b?usp=3Demail">Patch Set #4, Line 1179:</a> <code style=3D"fon=
t-family:monospace,monospace">    ret-&gt;rx_peer_id =3D MAX_PEER_ID;</code=
></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; p=
adding: 0 10px;">Add comment here that we also use the rx peer id to identi=
fy DCO clients as this has become now a im [=E2=80=A6]</blockquote></p><p c=
lass=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Don=
e</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-=
bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment=
/d7cabc51_e6990ae0?usp=3Demail">Patch Set #4, Line 1982:</a> <code style=3D=
"font-family:monospace,monospace">        }</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This is =
still not guarded by DCO capability. [=E2=80=A6]</blockquote></p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment/c0f=
ec251_e0eada21?usp=3Demail">Patch Set #4, Line 2165:</a> <code style=3D"fon=
t-family:monospace,monospace">    if (multi-&gt;rx_peer_id =3D=3D MAX_PEER_=
ID &amp;&amp; session-&gt;opt-&gt;mode !=3D MODE_SERVER)</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">This feel be a very hacky place to set the multi rx peer id. [=E2=80=A6=
]</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-wrap; word-=
wrap: break-word;">I moved this into tls_multi_init_finalize(), hope that&#=
39;s fine.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File s=
rc/openvpn/ssl_ncp.c:</p><ul style=3D"list-style: none; padding: 0;"><li st=
yle=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment/74331eed_c592a0=
14?usp=3Demail">Patch Set #4, Line 425:</a> <code style=3D"font-family:mono=
space,monospace">    if (tx_peer_id)</code></p><p><blockquote style=3D"bord=
er-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">This also need t=
o take DCO capability into account.</blockquote></p><p class=3D"blocks" sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1089/comment/c5e954b4_8a6a0a93?=
usp=3Demail">Patch Set #4, Line 450:</a> <code style=3D"font-family:monospa=
ce,monospace">        if (multi-&gt;use_peer_id)</code></p><p><blockquote s=
tyle=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">I th=
ink this parts needs to be skipped if we are using/negotiated asymmetric pe=
er-id as it would ove [=E2=80=A6]</blockquote></p><p class=3D"blocks" style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/ssl_util.h:</p><ul =
style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 =
0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1089/comment/be89150e_3068de2f?usp=3Demail">Patch Set #4,=
 Line 56:</a> <code style=3D"font-family:monospace,monospace">uint32_t extr=
act_asymmetric_peer_id(const char *peer_info);</code></p><p><blockquote sty=
le=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Add do=
xygen please</blockquote></p><p class=3D"blocks" style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: 0=
; padding: 0;"><p>File src/openvpn/ssl_util.c:</p><ul style=3D"list-style: =
none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
089/comment/c1989b67_8f07aa92?usp=3Demail">Patch Set #4, Line 90:</a> <code=
 style=3D"font-family:monospace,monospace">    return 0;</code></p><p><bloc=
kquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10p=
x;">0 is a valid peer id. [=E2=80=A6]</blockquote></p><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul></=
li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1089?usp=3Demail">change 1089</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/108=
9?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0a13ee90b6706acf20eabcee3ba=
b3f2dff639bf9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1089 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 27 Oct 2025 13:47:02=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>

</body></html>=

--LQEzz/a1T4w=--

