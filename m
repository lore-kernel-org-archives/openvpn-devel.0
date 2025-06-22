From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 22 Jun 2025 11:02:51 +0000
In-Reply-To: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
References: <gerrit.1708008760000.I3e4ebef484d2a04a383a65ede5617ee98bf218a7@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <1afd09fb58c62477ff4fd7a6d931471c2a47df02-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7P0juNoYiiw="; charset=UTF-8
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
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--7P0juNoYiiw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/524?usp=3Demail )

Change subject: Route: add support for user defined routing table
......................................................................


Patch Set 9:

(1 comment)

Patchset:

PS9:
Tested this on gentoo, with

```... --client --route-table 77 --route 10.195.0.0 255.255.0.0 --route-tab=
le 78```

which does what I expected - 10.195.0.0/16 shows up in table 77, and all pu=
shed routes show up in table 78

```
2025-06-22 13:00:15 net_route_v4_del: 10.195.0.0/16 via 10.194.2.169 dev [N=
ULL] table 77 metric -1
2025-06-22 13:00:15 net_route_v4_del: 10.194.0.0/16 via 10.194.2.169 dev [N=
ULL] table 78 metric -1
2025-06-22 13:00:15 net_route_v4_del: 10.194.2.1/32 via 10.194.2.169 dev [N=
ULL] table 78 metric -1
```

(and "ip route list table 77 / 78" confirms that).

It claims to do the right thing for IPv6

```
2025-06-22 13:00:15 net_route_v6_del: fd00:abcd:194::/48 via :: dev tun8 ta=
ble 78 metric -1
```

but `ip route -6 list` shows no table (but the same holds for ipv6 routes a=
dded via `ip route add -6 ... table 78` so this looks more like a linux wei=
rdness than an OpenVPN/SITNL issue to me).



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede5617ee98bf218a7
Gerrit-Change-Number: 524
Gerrit-PatchSet: 9
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Sun, 22 Jun 2025 11:02:51 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--7P0juNoYiiw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail">View C=
hange</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0;"><=
li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-style=
: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=
=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/5=
24?tab=3Dcomments">Patch Set #9:</a> </p><p style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">Tested this on gentoo, with</p><p style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">```... --client --route-table 77 --=
route 10.195.0.0 255.255.0.0 --route-table 78```</p><p style=3D"white-space=
: pre-wrap; word-wrap: break-word;">which does what I expected - 10.195.0.0=
/16 shows up in table 77, and all pushed routes show up in table 78</p><p s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>2025-06-22 13=
:00:15 net_route_v4_del: 10.195.0.0/16 via 10.194.2.169 dev [NULL] table 77=
 metric -1<br>2025-06-22 13:00:15 net_route_v4_del: 10.194.0.0/16 via 10.19=
4.2.169 dev [NULL] table 78 metric -1<br>2025-06-22 13:00:15 net_route_v4_d=
el: 10.194.2.1/32 via 10.194.2.169 dev [NULL] table 78 metric -1<br>```</p>=
<p style=3D"white-space: pre-wrap; word-wrap: break-word;">(and &quot;ip ro=
ute list table 77 / 78&quot; confirms that).</p><p style=3D"white-space: pr=
e-wrap; word-wrap: break-word;">It claims to do the right thing for IPv6</p=
><p style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>2025-06-=
22 13:00:15 net_route_v6_del: fd00:abcd:194::/48 via :: dev tun8 table 78 m=
etric -1<br>```</p><p style=3D"white-space: pre-wrap; word-wrap: break-word=
;">but `ip route -6 list` shows no table (but the same holds for ipv6 route=
s added via `ip route add -6 ... table 78` so this looks more like a linux =
weirdness than an OpenVPN/SITNL issue to me).</p></li></ul></li></ul><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demai=
l">change 524</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/524?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3e4ebef484d2a04a383a65ede56=
17ee98bf218a7 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 524 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 22 Jun 2025 11:02:51=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--7P0juNoYiiw=--

