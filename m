From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 16 Feb 2024 16:35:10 +0000
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net
Message-ID: <169a4d4f2db2c99fa0efc170ef875ab048ffa719-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q74Gwmx1oqM="; charset=UTF-8
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

--Q74Gwmx1oqM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

flichtenheld has posted comments on this change. ( http://gerrit.openvpn.ne=
t/c/openvpn/+/524?usp=3Demail )

Change subject: Route: add support for user defined routing table
......................................................................


Patch Set 1: Code-Review-1

(7 comments)

Patchset:

PS1:
Functionality might be fine, but could use some polish


File doc/man-sections/vpn-network-options.rst:

http://gerrit.openvpn.net/c/openvpn/+/524/comment/22a0a3ac_de6d8584 :
PS1, Line 407: 	default taken from ``--route-table`` if set, otherwise :cod=
e:`0`.
Please change tab to spaces


http://gerrit.openvpn.net/c/openvpn/+/524/comment/f27813f8_b24586f4 :
PS1, Line 408:
Should document that table-id can't be pushed.


http://gerrit.openvpn.net/c/openvpn/+/524/comment/a3b9a424_093b4876 :
PS1, Line 464:
might be a good opportunity to make the description of --route-ipv6 more co=
nsistent with --route? Currently the descriptions are of a very different f=
ormat and verbosity even though the options are very similar


File src/openvpn/options.h:

http://gerrit.openvpn.net/c/openvpn/+/524/comment/f5eb20b0_42a87049 :
PS1, Line 745: #define OPT_P_ROUTE_TABLE     (1<<31)
it is not clear to my why you need a separate permission entry here? Should=
 maybe add a comment about this.


File src/openvpn/options.c:

http://gerrit.openvpn.net/c/openvpn/+/524/comment/ca4f68fc_2a1a10c0 :
PS1, Line 205:     "--route-table [table_id] : Specify a custom routing tab=
le for use with --route(-ipv6).\n"
table_id is not optional, so don't use brackets here


http://gerrit.openvpn.net/c/openvpn/+/524/comment/a60bb82d_c3d5db58 :
PS1, Line 6992:         msg(M_WARN, "NOTE: --route-table specified, but not=
 supported on this platform");
This warning would be confusing with a Linux build with --enable-iproute2. =
Maybe those should be two separate warnings?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede5617ee98bf218a7
Gerrit-Change-Number: 524
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Comment-Date: Fri, 16 Feb 2024 16:35:10 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--Q74Gwmx1oqM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>Patch set 1:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">Vi=
ew Change</a></p><p>7 comments:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/524?tab=3Dcomments">Patch Set #1:</a> </p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">Functionality might be fine, but could use so=
me polish</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>File do=
c/man-sections/vpn-network-options.rst:</p><ul style=3D"list-style: none; p=
adding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margi=
n-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524/commen=
t/22a0a3ac_de6d8584">Patch Set #1, Line 407:</a> <code style=3D"font-family=
:monospace,monospace">	default taken from ``--route-table`` if set, otherwi=
se :code:`0`.</code></p><p style=3D"white-space: pre-wrap; word-wrap: break=
-word;">Please change tab to spaces</p></li><li style=3D"margin: 0; padding=
: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/524/comment/f27813f8_b24586f4">Patch Set #1, Line 408=
:</a> <code style=3D"font-family:monospace,monospace"></code></p><p style=
=3D"white-space: pre-wrap; word-wrap: break-word;">Should document that tab=
le-id can&#39;t be pushed.</p></li><li style=3D"margin: 0; padding: 0 0 0 1=
6px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/524/comment/a3b9a424_093b4876">Patch Set #1, Line 464:</a> <co=
de style=3D"font-family:monospace,monospace"></code></p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">might be a good opportunity to make=
 the description of --route-ipv6 more consistent with --route? Currently th=
e descriptions are of a very different format and verbosity even though the=
 options are very similar</p></li></ul></li><li style=3D"margin: 0; padding=
: 0;"><p>File src/openvpn/options.h:</p><ul style=3D"list-style: none; padd=
ing: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-b=
ottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524/comment/f=
5eb20b0_42a87049">Patch Set #1, Line 745:</a> <code style=3D"font-family:mo=
nospace,monospace">#define OPT_P_ROUTE_TABLE     (1&lt;&lt;31)</code></p><p=
 style=3D"white-space: pre-wrap; word-wrap: break-word;">it is not clear to=
 my why you need a separate permission entry here? Should maybe add a comme=
nt about this.</p></li></ul></li><li style=3D"margin: 0; padding: 0;"><p>Fi=
le src/openvpn/options.c:</p><ul style=3D"list-style: none; padding: 0;"><l=
i style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"margin-bottom: 4px;=
"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524/comment/ca4f68fc_2a1=
a10c0">Patch Set #1, Line 205:</a> <code style=3D"font-family:monospace,mon=
ospace">    &quot;--route-table [table_id] : Specify a custom routing table=
 for use with --route(-ipv6).\n&quot;</code></p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">table_id is not optional, so don&#39;t use =
brackets here</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p styl=
e=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
524/comment/a60bb82d_c3d5db58">Patch Set #1, Line 6992:</a> <code style=3D"=
font-family:monospace,monospace">        msg(M_WARN, &quot;NOTE: --route-ta=
ble specified, but not supported on this platform&quot;);</code></p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">This warning would be c=
onfusing with a Linux build with --enable-iproute2. Maybe those should be t=
wo separate warnings?</p></li></ul></li></ul><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">change 524</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/524?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede56=
17ee98bf218a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 16 Feb 2024 16:35:10=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--Q74Gwmx1oqM=--

