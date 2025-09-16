From: "d12fk (Code Review)" <gerrit@...515...>
Date: Tue, 16 Sep 2025 12:12:28 +0000
In-Reply-To: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
References: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d9f29311edcdb98967a6af88bad4da4dd014c986-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Z+cDeT//BRE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allow
 route_ipv6_match_host to be used outside of route.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Z+cDeT//BRE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

d12fk has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1191?usp=3Demail )

Change subject: Allow route_ipv6_match_host to be used outside of route.c
......................................................................


Patch Set 1:

(2 comments)

File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/1191/comment/1b0d244a_0432b565 :
PS1, Line 719: route_ipv6_match_host(const struct in6_addr *network, unsign=
ed int bits, const struct in6_addr *host)
The name is somewhat outdated with the new signature of the function. Maybe=
 something like `ipv6_net_contains_host` would fit better now.


http://gerrit.openvpn.net/c/openvpn/+/1191/comment/b5f1c14b_74c1e681 :
PS1, Line 726:     int i =3D 0;
Don't have to initialize i as it is done in the loop.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ief1495b52ea81cac35d78e40264372d3869423f1
Gerrit-Change-Number: 1191
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Comment-Date: Tue, 16 Sep 2025 12:12:28 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--Z+cDeT//BRE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail">View =
Change</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;"=
><li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.c:</p><ul s=
tyle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0=
 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1191/comment/1b0d244a_0432b565">Patch Set #1, Line 719:</a=
> <code style=3D"font-family:monospace,monospace">route_ipv6_match_host(con=
st struct in6_addr *network, unsigned int bits, const struct in6_addr *host=
)</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">The =
name is somewhat outdated with the new signature of the function. Maybe som=
ething like `ipv6_net_contains_host` would fit better now.</p></li><li styl=
e=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1191/comment/b5f1c14b_74c1e681=
">Patch Set #1, Line 726:</a> <code style=3D"font-family:monospace,monospac=
e">    int i =3D 0;</code></p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">Don&#39;t have to initialize i as it is done in the loop.</p>=
</li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/1191?usp=3Demail">change 1191</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/119=
1?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief1495b52ea81cac35d78e40264=
372d3869423f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1191 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 16 Sep 2025 12:12:28=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Z+cDeT//BRE=--

