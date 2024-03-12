From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Mar 2024 17:11:24 +0000
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <cfee8be6851782f9ab7ef99a21c4b670303d21bb-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Lkp+RZjLb8E="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Route: add support
 for user defined routing table
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Lkp+RZjLb8E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/524?usp=3Demail )

Change subject: Route: add support for user defined routing table
......................................................................


Patch Set 3: Code-Review-1

(7 comments)

File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/524/comment/29fafc4d_019065e1 :
PS3, Line 374:   a user defined routing table can be used instead.
"an user"


http://gerrit.openvpn.net/c/openvpn/+/524/comment/cfaf208a_43bb3e07 :
PS3, Line 407:         Since this option must be an entirely local choice, =
won't be pushable.
Time seems weird to me, would change to "it isn't pushable"


http://gerrit.openvpn.net/c/openvpn/+/524/comment/c5dce9cb_c194c9e8 :
PS3, Line 408: 	      default taken from ``--route-table`` if set, otherwis=
e :code:`0`.
please change tab to space


http://gerrit.openvpn.net/c/openvpn/+/524/comment/186800fb_289c2ebc :
PS3, Line 461:      route-ipv6 ipv6addr/bits [gateway]
when listing all possible choices, you can leave off the "[" optional marke=
rs


http://gerrit.openvpn.net/c/openvpn/+/524/comment/dc32db5a_b03f8605 :
PS3, Line 464:
trailing whitespace


http://gerrit.openvpn.net/c/openvpn/+/524/comment/c7665500_392297ff :
PS3, Line 475: 	      default taken from ``--route-table`` if set, otherwis=
e :code:`0`.
same comments apply here as for --route (tab, won't->it isn't)


File src/openvpn/route.h:

http://gerrit.openvpn.net/c/openvpn/+/524/comment/f42523ea_da5a7db8 :
PS3, Line 98:
spurious whitespace?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede5617ee98bf218a7
Gerrit-Change-Number: 524
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Tue, 12 Mar 2024 17:11:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Lkp+RZjLb8E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">Vi=
ew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/vpn-netwo=
rk-options.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D=
"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/524/comment/29fafc4d_019065e1">Pa=
tch Set #3, Line 374:</a> <code style=3D"font-family:monospace,monospace"> =
 a user defined routing table can be used instead.</code></p><p style=3D"wh=
ite-space: pre-wrap; word-wrap: break-word;">&quot;an user&quot;</p></li><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524/comment/cfaf208a_43b=
b3e07">Patch Set #3, Line 407:</a> <code style=3D"font-family:monospace,mon=
ospace">        Since this option must be an entirely local choice, won&#39=
;t be pushable.</code></p><p style=3D"white-space: pre-wrap; word-wrap: bre=
ak-word;">Time seems weird to me, would change to &quot;it isn&#39;t pushab=
le&quot;</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524/c=
omment/c5dce9cb_c194c9e8">Patch Set #3, Line 408:</a> <code style=3D"font-f=
amily:monospace,monospace">	      default taken from ``--route-table`` if s=
et, otherwise :code:`0`.</code></p><p style=3D"white-space: pre-wrap; word-=
wrap: break-word;">please change tab to space</p></li><li style=3D"margin: =
0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/524/comment/186800fb_289c2ebc">Patch Set #3=
, Line 461:</a> <code style=3D"font-family:monospace,monospace">     route-=
ipv6 ipv6addr/bits [gateway]</code></p><p style=3D"white-space: pre-wrap; w=
ord-wrap: break-word;">when listing all possible choices, you can leave off=
 the &quot;[&quot; optional markers</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/524/comment/dc32db5a_b03f8605">Patch Set #3, Line 464=
:</a> <code style=3D"font-family:monospace,monospace">  </code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">trailing whitespace</p><=
/li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom=
: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524/comment/c76655=
00_392297ff">Patch Set #3, Line 475:</a> <code style=3D"font-family:monospa=
ce,monospace">	      default taken from ``--route-table`` if set, otherwise=
 :code:`0`.</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-w=
ord;">same comments apply here as for --route (tab, won&#39;t-&gt;it isn&#3=
9;t)</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File src/ope=
nvpn/route.h:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/524/comment/f42523ea_da5a7db8">Patch=
 Set #3, Line 98:</a> <code style=3D"font-family:monospace,monospace"></cod=
e></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">spurious w=
hitespace?</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/524?usp=3Demail">change 524</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/524?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede56=
17ee98bf218a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 12 Mar 2024 17:11:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Lkp+RZjLb8E=--

