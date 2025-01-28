From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 15:07:20 +0000
In-Reply-To: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
References: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <50bebc4604e27fa7004c4e438a63964679a82fb9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S2Lr5pVj/fE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute/management:
 fix uninitialized variable (UNINIT)
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--S2Lr5pVj/fE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/880?usp=3Demail )

Change subject: mroute/management: fix uninitialized variable (UNINIT)
......................................................................


Patch Set 1:

(2 comments)

File src/openvpn/manage.c:

http://gerrit.openvpn.net/c/openvpn/+/880/comment/3db554a6_f8736f38 :
PS1, Line 573:                             port, p3);
> passing 'foo' will lead to ascii2proto() returning -1, which in turn will=
 lead to "no client found", [=E2=80=A6]
Done


File src/openvpn/mroute.c:

http://gerrit.openvpn.net/c/openvpn/+/880/comment/9c991771_22e29971 :
PS1, Line 441:                 if ((maddr.type & MR_WITH_PROTO))
> double `(())` braces...
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1
Gerrit-Change-Number: 880
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Tue, 28 Jan 2025 15:07:20 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--S2Lr5pVj/fE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/880/comment/3db554a6_f8736f38">Patch Set #1, Line 573:</a>=
 <code style=3D"font-family:monospace,monospace">                          =
  port, p3);</code></p><p><blockquote style=3D"border-left: 1px solid #aaa;=
 margin: 10px 0; padding: 0 10px;">passing &#39;foo&#39; will lead to ascii=
2proto() returning -1, which in turn will lead to &quot;no client found&quo=
t;, [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">Done</p></li></ul></li><li style=3D"margin: 0; padding: 0;"=
><p>File src/openvpn/mroute.c:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom:=
 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/880/comment/9c99177=
1_22e29971">Patch Set #1, Line 441:</a> <code style=3D"font-family:monospac=
e,monospace">                if ((maddr.type &amp; MR_WITH_PROTO))</code></=
p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padd=
ing: 0 10px;">double `(())` braces...</blockquote></p><p style=3D"white-spa=
ce: pre-wrap; word-wrap: break-word;">Done</p></li></ul></li></ul><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail">=
change 880</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4be0ff4d308213d2ef8ba66bd31=
78eee1f60fff1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 880 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Jan 2025 15:07:20=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--S2Lr5pVj/fE=--

