From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 11:44:55 +0000
In-Reply-To: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
References: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f52e59ef1414e90da3e62f5e50ec96f26e127abd-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BvP/1VLFVho="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove
 unused/uneeded defines from configure and cmake config
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BvP/1VLFVho=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

plaisthos has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/443?usp=3Demail )

Change subject: Remove unused/uneeded defines from configure and cmake conf=
ig
......................................................................


Patch Set 2:

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/443/comment/1929ebea_270a8e08 :
PS1, Line 7: Remove unused defined from configure and cmake config
> "defines"
Done


File configure.ac:

http://gerrit.openvpn.net/c/openvpn/+/443/comment/4c0f0d83_98a4fc60 :
PS1, Line 582: 		AC_DEFINE([HAVE_ANONYMOUS_UNION_SUPPORT], [], [Compiler su=
pports anonymous unions])
> This is used in mroute.h. Need to remove that usage.
Done



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021
Gerrit-Change-Number: 443
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 20 Nov 2023 11:44:55 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--BvP/1VLFVho=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/443/comment/1929ebea_270a8e08">Patch Set #1, Line 7:</a> <code style=
=3D"font-family:monospace,monospace">Remove unused defined from configure a=
nd cmake config</code></p><p><blockquote style=3D"border-left: 1px solid #a=
aa; margin: 10px 0; padding: 0 10px;">&quot;defines&quot;</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li><li style=3D"margin: 0; padding: 0;"><p>File configure.ac:</p><ul sty=
le=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0=
 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/443/comment/4c0f0d83_98a4fc60">Patch Set #1, Line 582:</a> <=
code style=3D"font-family:monospace,monospace">		AC_DEFINE([HAVE_ANONYMOUS_=
UNION_SUPPORT], [], [Compiler supports anonymous unions])</code></p><p><blo=
ckquote style=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10=
px;">This is used in mroute.h. Need to remove that usage.</blockquote></p><=
p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li></ul=
></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/443?usp=3Demail">change 443</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd0376b36d4050dc22bc93b8fcf=
7ed29faef0021 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 443 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 20 Nov 2023 11:44:55=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--BvP/1VLFVho=--

