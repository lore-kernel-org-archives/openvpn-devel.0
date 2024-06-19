From: "selvanair (Code Review)" <gerrit@...515...>
Date: Wed, 19 Jun 2024 01:56:33 +0000
In-Reply-To: <gerrit.1718418288000.I59a90446bfe73d8856516025a58a6f62cc98ab0d@...2715...>
References: <gerrit.1718418288000.I59a90446bfe73d8856516025a58a6f62cc98ab0d@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b8acbcb75aff9963c27289dcbd327faf8890e4d4-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pjjpspmWYz0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Static-challenge
 concatenation option
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pjjpspmWYz0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

selvanair has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/665?usp=3Demail )

Change subject: Static-challenge concatenation option
......................................................................


Patch Set 2:

(1 comment)

File doc/man-sections/client-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/665/comment/46ddef1b_f7400222 :
PS1, Line 552:   :code: `0` is the default.
> I am not a big fan of this option but I will not block it. [=E2=80=A6]
I share that sentiment, but some GUI users want something like this. It fee=
ls better to have this defined in the core than invent it in the GUI.

Changed 0/1 to scrv1/concat.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/665?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I59a90446bfe73d8856516025a58a6f62cc98ab0d
Gerrit-Change-Number: 665
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 19 Jun 2024 01:56:33 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: comment

--pjjpspmWYz0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/665?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/client-options=
.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0=
; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/665/comment/46ddef1b_f7400222">Patch Set #1,=
 Line 552:</a> <code style=3D"font-family:monospace,monospace">  :code: `0`=
 is the default.</code></p><p><blockquote style=3D"border-left: 1px solid #=
aaa; margin: 10px 0; padding: 0 10px;">I am not a big fan of this option bu=
t I will not block it. [=E2=80=A6]</blockquote></p><p style=3D"white-space:=
 pre-wrap; word-wrap: break-word;">I share that sentiment, but some GUI use=
rs want something like this. It feels better to have this defined in the co=
re than invent it in the GUI.</p><p style=3D"white-space: pre-wrap; word-wr=
ap: break-word;">Changed 0/1 to scrv1/concat.</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/665?usp=3Demai=
l">change 665</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/665?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I59a90446bfe73d8856516025a58=
a6f62cc98ab0d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 665 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 19 Jun 2024 01:56:33=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: plaisthos &lt;arne-openvp=
n@...1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--pjjpspmWYz0=--

