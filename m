From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 4 Jul 2024 13:30:06 +0000
In-Reply-To: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
References: <gerrit.1718899574000.I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <58be607f3e3b499a2cc81010f35443d588e5a19c-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="h9TqeT3s3mc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_server_null:
 multiple improvements and fixes
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mattock <samuli@...515...>
Cc: cron2 <gert@...1296...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--h9TqeT3s3mc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, mattock, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/669?usp=3Demail )

Change subject: t_server_null: multiple improvements and fixes
......................................................................


Patch Set 5: Code-Review+2


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I2cce8ad4e0d262e1404ab1eb6ff673d8590b6b3a
Gerrit-Change-Number: 669
Gerrit-PatchSet: 5
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Thu, 04 Jul 2024 13:30:06 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--h9TqeT3s3mc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, mattock, plaisthos. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail">=
change 669</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/669?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I2cce8ad4e0d262e1404ab1eb6ff=
673d8590b6b3a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 669 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 04 Jul 2024 13:30:06=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--h9TqeT3s3mc=--

