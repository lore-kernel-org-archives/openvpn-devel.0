From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 29 Jan 2025 10:54:35 +0000
In-Reply-To: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
References: <gerrit.1738072669000.I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <bb8f7b87c1131935ba9ad4df8b37bceea006c24d-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="E8tEQqdnl7g="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mroute/management:
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

--E8tEQqdnl7g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/880?usp=3Demail )

Change subject: mroute/management: fix uninitialized variable (UNINIT)
......................................................................


Patch Set 4:

(3 comments)

File src/openvpn/manage.c:

http://gerrit.openvpn.net/c/openvpn/+/880/comment/1917e810_8df15a58 :
PS3, Line 597:             n_killed =3D (*man->persist.callback.kill_by_cn)=
(man->persist.callback.arg, p2);
> Ah, no, not that one :-) for CN we only have p1
Done


http://gerrit.openvpn.net/c/openvpn/+/880/comment/76fd57cc_1aede7fa :
PS3, Line 600:                 msg(M_CLIENT, "SUCCESS: common name '%s' fou=
nd, %d client(s) killed", p2, n_killed);
> too enthusiastic
Done


http://gerrit.openvpn.net/c/openvpn/+/880/comment/1f0de4eb_2449a9e2 :
PS3, Line 604:                 msg(M_CLIENT, "ERROR: common name '%s' not f=
ound", p2);
> and here
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4be0ff4d308213d2ef8ba66bd3178eee1f60fff1
Gerrit-Change-Number: 880
Gerrit-PatchSet: 4
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
Gerrit-Comment-Date: Wed, 29 Jan 2025 10:54:35 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--E8tEQqdnl7g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail">View C=
hange</a></p><p>3 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/manage.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/880/comment/1917e810_8df15a58">Patch Set #3, Line 597:</a>=
 <code style=3D"font-family:monospace,monospace">            n_killed =3D (=
*man-&gt;persist.callback.kill_by_cn)(man-&gt;persist.callback.arg, p2);</c=
ode></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0=
; padding: 0 10px;">Ah, no, not that one :-) for CN we only have p1</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bott=
om: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/880/comment/76fd=
57cc_1aede7fa">Patch Set #3, Line 600:</a> <code style=3D"font-family:monos=
pace,monospace">                msg(M_CLIENT, &quot;SUCCESS: common name &#=
39;%s&#39; found, %d client(s) killed&quot;, p2, n_killed);</code></p><p><b=
lockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 =
10px;">too enthusiastic</blockquote></p><p style=3D"white-space: pre-wrap; =
word-wrap: break-word;">Done</p></li><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/880/comment/1f0de4eb_2449a9e2">Patch Set #3, Line 604:</a> <=
code style=3D"font-family:monospace,monospace">                msg(M_CLIENT=
, &quot;ERROR: common name &#39;%s&#39; not found&quot;, p2);</code></p><p>=
<blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: =
0 10px;">and here</blockquote></p><p style=3D"white-space: pre-wrap; word-w=
rap: break-word;">Done</p></li></ul></li></ul><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/880?usp=3Demail">change 880</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/880?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4be0ff4d308213d2ef8ba66bd31=
78eee1f60fff1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 880 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 29 Jan 2025 10:54:35=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--E8tEQqdnl7g=--

