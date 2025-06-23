From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 23 Jun 2025 12:08:26 +0000
In-Reply-To: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
References: <gerrit.1742993493000.I4ebe1158c36a641888131e824f59004a0f8fb4c5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., sasepp@...2783...
Message-ID: <d02ce15b3f6881ec6edc81f4a33290877198a1e8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="a0Z7IRWcG3I="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: t_server_null: add
 multi-socket testing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mattock <sasepp@...2783...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--a0Z7IRWcG3I=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mattock, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/919?usp=3Demail )

Change subject: t_server_null: add multi-socket testing
......................................................................


Patch Set 6:

(1 comment)

Patchset:

PS6:
The failures on NetBSD and OpenBSD are due to "by default there is only /de=
v/tun0 to /dev/tun3, and no dynamic device nodes".  Running "sudo /dev/MAKE=
DEV /dev/tun4" enables 1 community VPN + 4 test servers.

We should re-test when the other BBs are fixed



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4ebe1158c36a641888131e824f59004a0f8fb4c5
Gerrit-Change-Number: 919
Gerrit-PatchSet: 6
Gerrit-Owner: mattock <sasepp@...2783...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mattock <sasepp@...2783...>
Gerrit-Comment-Date: Mon, 23 Jun 2025 12:08:26 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--a0Z7IRWcG3I=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mattock, plaisthos.=
 </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/9=
19?tab=3Dcomments">Patch Set #6:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">The failures on NetBSD and OpenBSD are due to &quo=
t;by default there is only /dev/tun0 to /dev/tun3, and no dynamic device no=
des&quot;.  Running &quot;sudo /dev/MAKEDEV /dev/tun4&quot; enables 1 commu=
nity VPN + 4 test servers.</p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">We should re-test when the other BBs are fixed</p></li></ul><=
/li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/919?usp=3Demail">change 919</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/919?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4ebe1158c36a641888131e824f5=
9004a0f8fb4c5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 919 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;sasepp@...2783...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: cron2 &lt;gert@...1296...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;sasepp@...2867...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 23 Jun 2025 12:08:26=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--a0Z7IRWcG3I=--

