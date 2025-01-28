From: "kallisti5 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Jan 2025 01:51:47 +0000
In-Reply-To: <gerrit.1738029022000.I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d@...2715...>
References: <gerrit.1738029022000.I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d@...2715...>
Reply-To: alex@...2837..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <380b3454e2626f2138f2b55e99523a49747218e9-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="45ZcTpHq/cY="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: Haiku: Fix short
 interface path length
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--45ZcTpHq/cY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

kallisti5 has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/689?usp=3Demail )

Change subject: Haiku: Fix short interface path length
......................................................................


Patch Set 1:

(1 comment)

Patchset:

PS1:
This got missed in the last round of Haiku patches.  Our device names are f=
ull paths, so need PATH_MAX



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/689?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6de60ed5c03ea45e1d7a3f7777bfc8ed5075e84d
Gerrit-Change-Number: 689
Gerrit-PatchSet: 1
Gerrit-Owner: kallisti5 <alex@...2837...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Tue, 28 Jan 2025 01:51:47 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--45ZcTpHq/cY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/689?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/6=
89?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">This got missed in the last round of Haiku patches=
.  Our device names are full paths, so need PATH_MAX</p></li></ul></li></ul=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/689?usp=
=3Demail">change 689</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/689?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6de60ed5c03ea45e1d7a3f7777b=
fc8ed5075e84d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 689 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: kallisti5 &lt;alex@...2837...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Jan 2025 01:51:47=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--45ZcTpHq/cY=--

