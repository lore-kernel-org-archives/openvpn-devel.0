From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 18 Sep 2024 12:48:18 +0000
In-Reply-To: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
References: <gerrit.1726491830000.I65099ef00822d08fd3f5480c80892f3bf86c56e7@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <70b920ff73ca9bc77b11e132d85e7a63daf28d79-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bp+D5YKw4jY="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Introduce
 DRIVER_AFUNIX backend for use with lwipovpn
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bp+D5YKw4jY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/747?usp=3Demail )

Change subject: Introduce DRIVER_AFUNIX backend for use with lwipovpn
......................................................................


Patch Set 6:

(1 comment)

File src/openvpn/tun_afunix.h:

http://gerrit.openvpn.net/c/openvpn/+/747/comment/81f89bfa_53901669 :
PS1, Line 56:  * Reads a packet from a AF_UNIX based tun devices
> "device"
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I65099ef00822d08fd3f5480c80892f3bf86c56e7
Gerrit-Change-Number: 747
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 18 Sep 2024 12:48:18 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--bp+D5YKw4jY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/tun_afunix.h:</p><u=
l style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: =
0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/747/comment/81f89bfa_53901669">Patch Set #1, Line 56:</=
a> <code style=3D"font-family:monospace,monospace"> * Reads a packet from a=
 AF_UNIX based tun devices</code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;device&quot;</blockq=
uote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/747?usp=3Demail">change 747</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/747?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I65099ef00822d08fd3f5480c808=
92f3bf86c56e7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 747 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 18 Sep 2024 12:48:18=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--bp+D5YKw4jY=--

