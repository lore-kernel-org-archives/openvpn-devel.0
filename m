From: "stipa (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 08:07:08 +0000
In-Reply-To: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
References: <gerrit.1727248983000.I101bbc9f682375ec733bca10b52da82f0abfec27@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <97e992a6504f1e28dcc8ce5a5b44906e4a419727-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JEIOkP2fEw8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco: better naming
 for function parameters
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--JEIOkP2fEw8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

stipa has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/769?usp=3Demail )

Change subject: dco: better naming for function parameters
......................................................................


Patch Set 3:

(2 comments)

Commit Message:

http://gerrit.openvpn.net/c/openvpn/+/769/comment/ef01a97d_ed0135c4 :
PS2, Line 10: those are in fact VPN IPv4/v4 addresses and not
> IPv4/v6 maybe?
Acknowledged


File src/openvpn/dco_freebsd.c:

http://gerrit.openvpn.net/c/openvpn/+/769/comment/6574c7f7_14168c34 :
PS2, Line 78:              struct in_addr *vpn_in4, struct in6_addr *vpn_in=
6)
> should we go with vpn_ipv4 and vpn_ipv6? in4/in6 doesn't mean much as thi=
s is not about sockaddrs.
Acknowledged



--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I101bbc9f682375ec733bca10b52da82f0abfec27
Gerrit-Change-Number: 769
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-Comment-Date: Wed, 25 Sep 2024 08:07:08 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: ordex <a@...2181...>
Gerrit-MessageType: comment

--JEIOkP2fEw8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>Commit Message:</p><ul style=3D"lis=
t-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><=
p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/769/comment/ef01a97d_ed0135c4">Patch Set #2, Line 10:</a> <code style=
=3D"font-family:monospace,monospace">those are in fact VPN IPv4/v4 addresse=
s and not</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">IPv4/v6 maybe?</blockquote></p><p style=3D"=
white-space: pre-wrap; word-wrap: break-word;">Acknowledged</p></li></ul></=
li><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/dco_freebsd.c:<=
/p><ul style=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padd=
ing: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/769/comment/6574c7f7_14168c34">Patch Set #2, Line =
78:</a> <code style=3D"font-family:monospace,monospace">             struct=
 in_addr *vpn_in4, struct in6_addr *vpn_in6)</code></p><p><blockquote style=
=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">should w=
e go with vpn_ipv4 and vpn_ipv6? in4/in6 doesn&#39;t mean much as this is n=
ot about sockaddrs.</blockquote></p><p style=3D"white-space: pre-wrap; word=
-wrap: break-word;">Acknowledged</p></li></ul></li></ul><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail">change 769=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/769?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I101bbc9f682375ec733bca10b52=
da82f0abfec27 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 769 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 25 Sep 2024 08:07:08=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: ordex &lt;a@...2181...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--JEIOkP2fEw8=--

