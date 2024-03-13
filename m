From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 13 Mar 2024 08:38:05 +0000
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d7c72dff9c2091d9ac07dddd41e975bb2ed339be-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+oR3H6+SbNQ="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+oR3H6+SbNQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

its_Giaan has posted comments on this change. ( http://gerrit.openvpn.net/c=
/openvpn/+/524?usp=3Demail )

Change subject: Route: add support for user defined routing table
......................................................................


Patch Set 3:

(7 comments)

File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/524/comment/28a9b0d7_797a7b8f :
PS3, Line 374:   a user defined routing table can be used instead.
> "an user"
Since "user" begins with a consonant sound "y" (as in "you"), "a" is the ap=
propriate article to use. You would say "a unicorn" instead of "an unicorn"=
 imho.


http://gerrit.openvpn.net/c/openvpn/+/524/comment/fc3149bd_56ee7cdc :
PS3, Line 407:         Since this option must be an entirely local choice, =
won't be pushable.
> Time seems weird to me, would change to "it isn't pushable"
Done


http://gerrit.openvpn.net/c/openvpn/+/524/comment/293941ea_2c34e0eb :
PS3, Line 408: 	      default taken from ``--route-table`` if set, otherwis=
e :code:`0`.
> please change tab to space
Done


http://gerrit.openvpn.net/c/openvpn/+/524/comment/d10bebfd_142729b1 :
PS3, Line 461:      route-ipv6 ipv6addr/bits [gateway]
> when listing all possible choices, you can leave off the "[" optional mar=
kers
Done


http://gerrit.openvpn.net/c/openvpn/+/524/comment/a4df0975_2ea65b9f :
PS3, Line 464:
> trailing whitespace
Done


http://gerrit.openvpn.net/c/openvpn/+/524/comment/1d25817b_bf7cb0e6 :
PS3, Line 475: 	      default taken from ``--route-table`` if set, otherwis=
e :code:`0`.
> same comments apply here as for --route (tab, won't->it isn't)
Done


File src/openvpn/route.h:

http://gerrit.openvpn.net/c/openvpn/+/524/comment/4897ce61_2c46962d :
PS3, Line 98:
> spurious whitespace?
Done



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
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Wed, 13 Mar 2024 08:38:05 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Comment-In-Reply-To: flichtenheld <frank@...2641...>
Gerrit-MessageType: comment

--+oR3H6+SbNQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">View C=
hange</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File doc/man-sections/vpn-network-o=
ptions.rst:</p><ul style=3D"list-style: none; padding: 0;"><li style=3D"mar=
gin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/524/comment/28a9b0d7_797a7b8f">Patch S=
et #3, Line 374:</a> <code style=3D"font-family:monospace,monospace">  a us=
er defined routing table can be used instead.</code></p><p><blockquote styl=
e=3D"border-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">&quot;a=
n user&quot;</blockquote></p><p style=3D"white-space: pre-wrap; word-wrap: =
break-word;">Since &quot;user&quot; begins with a consonant sound &quot;y&q=
uot; (as in &quot;you&quot;), &quot;a&quot; is the appropriate article to u=
se. You would say &quot;a unicorn&quot; instead of &quot;an unicorn&quot; i=
mho.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"marg=
in-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524/comme=
nt/fc3149bd_56ee7cdc">Patch Set #3, Line 407:</a> <code style=3D"font-famil=
y:monospace,monospace">        Since this option must be an entirely local =
choice, won&#39;t be pushable.</code></p><p><blockquote style=3D"border-lef=
t: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">Time seems weird to me=
, would change to &quot;it isn&#39;t pushable&quot;</blockquote></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=
=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/524/comment/293941ea_2c34e0eb">=
Patch Set #3, Line 408:</a> <code style=3D"font-family:monospace,monospace"=
>	      default taken from ``--route-table`` if set, otherwise :code:`0`.</=
code></p><p><blockquote style=3D"border-left: 1px solid #aaa; margin: 10px =
0; padding: 0 10px;">please change tab to space</blockquote></p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">Done</p></li><li style=3D"m=
argin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/524/comment/d10bebfd_142729b1">Patch=
 Set #3, Line 461:</a> <code style=3D"font-family:monospace,monospace">    =
 route-ipv6 ipv6addr/bits [gateway]</code></p><p><blockquote style=3D"borde=
r-left: 1px solid #aaa; margin: 10px 0; padding: 0 10px;">when listing all =
possible choices, you can leave off the &quot;[&quot; optional markers</blo=
ckquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done=
</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524/comment/a=
4df0975_2ea65b9f">Patch Set #3, Line 464:</a> <code style=3D"font-family:mo=
nospace,monospace">  </code></p><p><blockquote style=3D"border-left: 1px so=
lid #aaa; margin: 10px 0; padding: 0 10px;">trailing whitespace</blockquote=
></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done</p></l=
i><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: =
4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524/comment/1d25817b=
_bf7cb0e6">Patch Set #3, Line 475:</a> <code style=3D"font-family:monospace=
,monospace">	      default taken from ``--route-table`` if set, otherwise :=
code:`0`.</code></p><p><blockquote style=3D"border-left: 1px solid #aaa; ma=
rgin: 10px 0; padding: 0 10px;">same comments apply here as for --route (ta=
b, won&#39;t-&gt;it isn&#39;t)</blockquote></p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Done</p></li></ul></li><li style=3D"margin: =
0; padding: 0;"><p>File src/openvpn/route.h:</p><ul style=3D"list-style: no=
ne; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"=
margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524/c=
omment/4897ce61_2c46962d">Patch Set #3, Line 98:</a> <code style=3D"font-fa=
mily:monospace,monospace"></code></p><p><blockquote style=3D"border-left: 1=
px solid #aaa; margin: 10px 0; padding: 0 10px;">spurious whitespace?</bloc=
kquote></p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Done<=
/p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/524?usp=3Demail">change 524</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/52=
4?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Wed, 13 Mar 2024 08:38:05=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Comment-In-Reply-To: flichtenheld &lt;frank@...1186...=
.2641...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--+oR3H6+SbNQ=--

