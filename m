From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 23 Jun 2025 13:29:43 +0000
In-Reply-To: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
References: <gerrit.1750235257000.Ie0529c2074964b3be034f01e0ef53090a6edbd35@...2715...>
Reply-To: arne-openvpn@...1227..., rein.vanbaaren@...1435...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296...
Message-ID: <5e7537b85cd4df32543f1693e08a7add95004676-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="f4WBhiY61D4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Added PQE to WolfSSL
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: comododragon <rein.vanbaaren@...1435...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--f4WBhiY61D4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: comododragon, flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/1046?usp=3Demail )

Change subject: Added PQE to WolfSSL
......................................................................


Patch Set 3:

(1 comment)

File README.wolfssl:

http://gerrit.openvpn.net/c/openvpn/+/1046/comment/ab0e57c2_c22d8064 :
PS3, Line 39: WolfSSL supports the following Quantum Safe algorithms by spe=
cifying them using the `tls-groups`
you should also mention that wolfSSL uses different names for standard grou=
ps like secp384r1 vs P-384. Probably also good to add that as a remark in t=
he man page for tls-groups



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef53090a6edbd35
Gerrit-Change-Number: 1046
Gerrit-PatchSet: 3
Gerrit-Owner: comododragon <rein.vanbaaren@...1435...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: comododragon <rein.vanbaaren@...1435...>
Gerrit-Comment-Date: Mon, 23 Jun 2025 13:29:43 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--f4WBhiY61D4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: comododragon, flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">View =
Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File README.wolfssl:</p><ul style=
=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1046/comment/ab0e57c2_c22d8064">Patch Set #3, Line 39:</a> <co=
de style=3D"font-family:monospace,monospace">WolfSSL supports the following=
 Quantum Safe algorithms by specifying them using the `tls-groups` </code><=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">you should al=
so mention that wolfSSL uses different names for standard groups like secp3=
84r1 vs P-384. Probably also good to add that as a remark in the man page f=
or tls-groups</p></li></ul></li></ul><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1046?usp=3Demail">change 1046</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1046?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie0529c2074964b3be034f01e0ef=
53090a6edbd35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1046 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: comododragon &lt;rein.vanbaa=
ren@...1435...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 23 Jun 2025 13:29:43=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--f4WBhiY61D4=--

