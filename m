From: "stipa (Code Review)" <gerrit@...515...>
Date: Mon, 24 Jul 2023 12:52:49 +0000
In-Reply-To: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
References: <gerrit.1689947729000.I6de18261d5dc7f8561612184059656c73f33a5f2@...2715...>
Reply-To: lstipakov@...277..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ae43d9b32fc25fb0030885dfddf9ae1e2393e57f-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="aQtalJlgUTI="; charset=UTF-8
Subject: [Openvpn-devel] [XL] Change in openvpn[release/2.6]: CMake:
 backport CMake buildsystem from master to release/2.6
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--aQtalJlgUTI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/315?usp=3Demail )

Change subject: CMake: backport CMake buildsystem from master to release/2.6
......................................................................


Patch Set 1: Code-Review+2


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I6de18261d5dc7f8561612184059656c73f33a5f2
Gerrit-Change-Number: 315
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 24 Jul 2023 12:52:49 +0000
Gerrit-HasComments: No
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--aQtalJlgUTI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail">Vi=
ew Change</a></p><ul style=3D"list-style: none; padding: 0;"></ul><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail">=
change 315</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/315?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6de18261d5dc7f8561612184059=
656c73f33a5f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 315 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 24 Jul 2023 12:52:49=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: No </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--aQtalJlgUTI=--

