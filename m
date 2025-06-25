From: "comododragon (Code Review)" <gerrit@...515...>
Date: Wed, 25 Jun 2025 12:48:47 +0000
In-Reply-To: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
Reply-To: rein.vanbaaren@...1435..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <955798ae5cb060cd358eaa76a42325a8050a99d9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gA83iA1Y3es="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Added PQE to WolfSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gA83iA1Y3es=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

comododragon has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/1046?usp=3Demail )

Change subject: Added PQE to WolfSSL
......................................................................


Patch Set 5:

(1 comment)

File README.wolfssl:

http://gerrit.openvpn.net/c/openvpn/+/1046/comment/9582318b_73069ab0 :
PS3, Line 39: WolfSSL supports the following Quantum Safe algorithms by spe=
cifying them using the `tls-groups`
> you should also mention that wolfSSL uses different names for standard gr=
oups like secp384r1 vs P-38 [=E2=80=A6]
What do you mean? WolfSSL allows the definition of secp384r1 and P-384 resp=
ectively interchangeably.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
Gerrit-Change-Number: 1046
Gerrit-PatchSet: 5
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 25 Jun 2025 12:48:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: comment

--gA83iA1Y3es=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File README.wolfssl:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1046/comment/9582318b_73069ab0">Patch Set #3, Line 39:</a> <co=
de style=3D"font-family:monospace,monospace">WolfSSL supports the following=
 Quantum Safe algorithms by specifying them using the `tls-groups` </code><=
/p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; pad=
ding: 0 10px;">you should also mention that wolfSSL uses different names fo=
r standard groups like secp384r1 vs P-38 [=E2=80=A6]</blockquote></p><p sty=
le=3D"white-space: pre-wrap; word-wrap: break-word;">What do you mean? Wolf=
SSL allows the definition of secp384r1 and P-384 respectively interchangeab=
ly.</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1046?usp=3Demail">change 1046</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1046?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef=
53090a6edbd35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: comododragon &lt;rein.vanbaaren@=
...1435...&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Jun 2025 12:48:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--gA83iA1Y3es=--

