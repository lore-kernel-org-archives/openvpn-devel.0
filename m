From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 12 Jun 2024 09:23:25 +0000
In-Reply-To: <gerrit.1717758396000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
References: <gerrit.1717758396000.I1b54da258c7d15551b6c3de7522a0d19afdb66de@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227..., samuli@...515...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8887e4ff8fa4ef99f177f06550a8a5f774dc97c2-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GC+6cMYOTYE="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Add t_server_null
 test suite
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mattock <samuli@...515...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GC+6cMYOTYE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: mattock, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/663?usp=3Demail )

Change subject: Add t_server_null test suite
......................................................................


Patch Set 2: -Code-Review


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1b54da258c7d15551b6c3de7522a0d19afdb66de
Gerrit-Change-Number: 663
Gerrit-PatchSet: 2
Gerrit-Owner: mattock <samuli@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: mattock <samuli@...515...>
Gerrit-Comment-Date: Wed, 12 Jun 2024 09:23:25 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--GC+6cMYOTYE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: mattock, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ddd;">-Code-Review</span></p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail">View Ch=
ange</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail">chang=
e 663</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/663?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1b54da258c7d15551b6c3de7522=
a0d19afdb66de </div>
<div style=3D"display:none"> Gerrit-Change-Number: 663 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mattock &lt;samuli@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mattock &lt;samuli@...515...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 12 Jun 2024 09:23:25=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--GC+6cMYOTYE=--

