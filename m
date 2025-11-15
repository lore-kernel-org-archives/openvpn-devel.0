From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 15 Nov 2025 17:07:03 +0000
In-Reply-To: <gerrit.1758894427000.I16d90221d0a75193035253817ff195f6da9dc0b3@...2715...>
References: <gerrit.1758894427000.I16d90221d0a75193035253817ff195f6da9dc0b3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <173bcbbaaaee173fad6a9f1f45d028c74be659a1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="RBMt3QAbyhE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: route: handle
 default gateway (net_gateway) and nexthop towards VPN s...
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--RBMt3QAbyhE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

cron2 has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/1222?usp=3Demail )

Change subject: route: handle default gateway (net_gateway) and nexthop tow=
ards VPN server separately
......................................................................


Patch Set 2: Code-Review-1

(1 comment)

Patchset:

PS2:
This is only half-working for me.  Triggered by https://github.com/OpenVPN/=
openvpn/issues/890 I have built a testbed to reproduce this.

- ssh -R *:12345:conn-test-server.openvpn.org:51194 $linuxserver
- on the linux server, run `openvpn --client --remote 127.0.0.5 51194 tcp .=
.. --route 1.1.1.1 255.255.255.255 net_gateway`

it will do both gateway lookups, and setenv `net_gateway` accordingly

```
2025-11-15 17:57:26 net_route_v4_best_gw query: dst 0.0.0.0
2025-11-15 17:57:26 net_route_v4_best_gw result: via 194.97.140.30 dev enp0=
s18
2025-11-15 17:57:26 net_route_v4_best_gw query: dst 127.0.0.5
2025-11-15 17:57:26 net_route_v4_best_gw result: via 0.0.0.0 dev lo
2025-11-15 17:57:26 GDG6: remote_host_ipv6=3Dn/a
2025-11-15 17:57:26 net_route_v6_best_gw query: dst ::
2025-11-15 17:57:26 net_route_v6_best_gw result: via 2001:608:0:814::ffff d=
ev enp0s18
2025-11-15 17:57:26 net_route_v6_best_gw query: dst ::
2025-11-15 17:57:26 net_route_v6_best_gw result: via 2001:608:0:814::ffff d=
ev enp0s18
```

but the gateway address used for `net_gateway` is the one from the second l=
ookup

```
2025-11-15 18:03:45 net_route_v4_add: 1.1.1.1/32 via 0.0.0.0 dev [NULL] tab=
le 0 metric -1
2025-11-15 18:03:45 sitnl_send: rtnl: generic error (-19): No such device
2025-11-15 18:03:45 ERROR: Linux route add command failed
```

so we might need to store the `ngi` in the `struct route-list` as well, and=
 depending on use case use `rgi` or `ngi` - for the bypass-routes, we want =
`rgi`, for `get_special_addr()` use case, we want `ngi`...

right?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1222?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I16d90221d0a75193035253817ff195f6da9dc0b3
Gerrit-Change-Number: 1222
Gerrit-PatchSet: 2
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Sat, 15 Nov 2025 17:07:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--RBMt3QAbyhE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1222?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1222?tab=3Dcomments&amp;usp=3Demail">Patch Set #2:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">This is onl=
y half-working for me.  Triggered by https://github.com/OpenVPN/openvpn/iss=
ues/890 I have built a testbed to reproduce this.</p><ul class=3D"blocks"><=
li>ssh -R *:12345:conn-test-server.openvpn.org:51194 $linuxserver</li><li>o=
n the linux server, run `openvpn --client --remote 127.0.0.5 51194 tcp ... =
--route 1.1.1.1 255.255.255.255 net_gateway`</li></ul><p class=3D"blocks" s=
tyle=3D"white-space: pre-wrap; word-wrap: break-word;">it will do both gate=
way lookups, and setenv `net_gateway` accordingly</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>2025-11-15 17:=
57:26 net_route_v4_best_gw query: dst 0.0.0.0<br>2025-11-15 17:57:26 net_ro=
ute_v4_best_gw result: via 194.97.140.30 dev enp0s18<br>2025-11-15 17:57:26=
 net_route_v4_best_gw query: dst 127.0.0.5<br>2025-11-15 17:57:26 net_route=
_v4_best_gw result: via 0.0.0.0 dev lo<br>2025-11-15 17:57:26 GDG6: remote_=
host_ipv6=3Dn/a<br>2025-11-15 17:57:26 net_route_v6_best_gw query: dst ::<b=
r>2025-11-15 17:57:26 net_route_v6_best_gw result: via 2001:608:0:814::ffff=
 dev enp0s18<br>2025-11-15 17:57:26 net_route_v6_best_gw query: dst ::<br>2=
025-11-15 17:57:26 net_route_v6_best_gw result: via 2001:608:0:814::ffff de=
v enp0s18<br>```</p><p class=3D"blocks" style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">but the gateway address used for `net_gateway` is the =
one from the second lookup</p><p class=3D"blocks" style=3D"white-space: pre=
-wrap; word-wrap: break-word;">```<br>2025-11-15 18:03:45 net_route_v4_add:=
 1.1.1.1/32 via 0.0.0.0 dev [NULL] table 0 metric -1<br>2025-11-15 18:03:45=
 sitnl_send: rtnl: generic error (-19): No such device<br>2025-11-15 18:03:=
45 ERROR: Linux route add command failed<br>```</p><p class=3D"blocks" styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">so we might need to sto=
re the `ngi` in the `struct route-list` as well, and depending on use case =
use `rgi` or `ngi` - for the bypass-routes, we want `rgi`, for `get_special=
_addr()` use case, we want `ngi`...</p><p class=3D"blocks" style=3D"white-s=
pace: pre-wrap; word-wrap: break-word;">right?</p></li></ul></li></ul><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1222?usp=3Dem=
ail">change 1222</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1222?usp=3Demail=
"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I16d90221d0a75193035253817ff=
195f6da9dc0b3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1222 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: mrbff &lt;marco@...2726...&g=
t; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 15 Nov 2025 17:07:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--RBMt3QAbyhE=--

