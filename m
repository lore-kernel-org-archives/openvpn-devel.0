From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 2 Jan 2024 11:35:14 +0000
In-Reply-To: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
References: <gerrit.1701971374000.Ie248d35d063bb6878f3dd42840c77ba0d6fa3381@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., gert@...1296...
Message-ID: <993b1dc159d510f5d2856540c755788b22e23584-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WRmBWhaOWDg="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add test_ssl unit
 test and test export of PEM to file
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: cron2 <gert@...1296...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WRmBWhaOWDg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/471?usp=3Demail )

Change subject: Add test_ssl unit test and test export of PEM to file
......................................................................


Patch Set 3:

(1 comment)

Patchset:

PS3:
> this fails the GHA mingw builds with [=E2=80=A6]
That is really strange. test_ssl.c includes ssl_verify_backend.h that defin=
es that function. I need to see if I can reproduce this.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie248d35d063bb6878f3dd42840c77ba0d6fa3381
Gerrit-Change-Number: 471
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Comment-Date: Tue, 02 Jan 2024 11:35:14 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: cron2 <gert@...1296...>
Gerrit-MessageType: comment

--WRmBWhaOWDg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/471?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
71?tab=3Dcomments">Patch Set #3:</a> </p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">this fails the GHA min=
gw builds with [=E2=80=A6]</blockquote></p><p style=3D"white-space: pre-wra=
p; word-wrap: break-word;">That is really strange. test_ssl.c includes ssl_=
verify_backend.h that defines that function. I need to see if I can reprodu=
ce this.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/471?usp=3Demail">change 471</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/471?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/><=
/div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie248d35d063bb6878f3dd42840c=
77ba0d6fa3381 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 471 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 02 Jan 2024 11:35:14=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: cron2 &lt;gert@...1296...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--WRmBWhaOWDg=--

