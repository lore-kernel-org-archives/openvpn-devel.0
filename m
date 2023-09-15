From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 15 Sep 2023 13:08:16 +0000
In-Reply-To: <gerrit.1694783050000.I171d55da2be868d961caa1d4491e6f1ed10ebe8a@...2715...>
References: <gerrit.1694783050000.I171d55da2be868d961caa1d4491e6f1ed10ebe8a@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net,
 lstipakov@...277...
Message-ID: <845753c9e67bc698df548b9a6f137f9d2d3bc524-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8cZxWz5Ej6Q="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: CMake: fix broken
 daemonization and syslog functionality
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8cZxWz5Ej6Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/341?usp=3Demail )

Change subject: CMake: fix broken daemonization and syslog functionality
......................................................................


Patch Set 1: Code-Review+2

(1 comment)

Patchset:

PS1:
Acked-By: Frank Lichtenheld <frank@...2641...>



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/341?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I171d55da2be868d961caa1d4491e6f1ed10ebe8a
Gerrit-Change-Number: 341
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 15 Sep 2023 13:08:16 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--8cZxWz5Ej6Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: stipa. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/341?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/341?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">Acked-By: Frank Lichtenheld &lt;frank@...2724...=
..&gt;</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/341?usp=3Demail">change 341</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/341?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I171d55da2be868d961caa1d4491=
e6f1ed10ebe8a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 341 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 15 Sep 2023 13:08:16=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--8cZxWz5Ej6Q=--

