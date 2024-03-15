From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 15 Mar 2024 14:41:08 +0000
In-Reply-To: <gerrit.1710510194000.I16d6a9fefa317d7d4a195e786618328445bdbca8@...2715...>
References: <gerrit.1710510194000.I16d6a9fefa317d7d4a195e786618328445bdbca8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, lstipakov@...277...
Message-ID: <8a08e1aff2c8229f71039fc573d5ea296054f0fb-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5d6gYFS8tQ8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Disable DCO if proxy
 is set via management
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--5d6gYFS8tQ8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos, stipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/543?usp=3Demail )

Change subject: Disable DCO if proxy is set via management
......................................................................


Patch Set 1: Code-Review+2


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/543?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I16d6a9fefa317d7d4a195e786618328445bdbca8
Gerrit-Change-Number: 543
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 15 Mar 2024 14:41:08 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--5d6gYFS8tQ8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos, stipa. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/543?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/543?usp=3Demail">=
change 543</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/543?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16d6a9fefa317d7d4a195e78661=
8328445bdbca8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 543 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 15 Mar 2024 14:41:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--5d6gYFS8tQ8=--

