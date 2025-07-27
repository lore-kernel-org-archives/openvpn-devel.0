From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 27 Jul 2025 10:39:01 +0000
In-Reply-To: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
References: <gerrit.1753488078000.I1ad5df0f6785ffe9becd9f83329a9335d1a36f24@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <9afb9ee15c18ab798246934c2ed9d6814326e17e-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jDCz0JbdkDg="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: dco: drop client
 prefix after DCO PEER_FLOAT notification
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jDCz0JbdkDg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1116?usp=3Demail )

Change subject: dco: drop client prefix after DCO PEER_FLOAT notification
......................................................................


Patch Set 2: Code-Review-1

(1 comment)

Patchset:

PS2:=20
Actually it is just fixing one particular symptom, but we can get there in =
other paths as well - here's a reconnect that happened to trigger the "quer=
y stats now!" timer

```
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 sitnl_send: checking for received messages
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 sitnl_send: rtnl: received 36 bytes
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 net_route_v6_del: fd00:abcd:220:201::/64 via fd0=
0:abcd:220:2::1006 dev tun1 table 0 metric 100
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 sitnl_send: checking for received messages
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 sitnl_send: rtnl: received 36 bytes
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 net_route_v6_del: fd00:abcd:220:200::74/128 via =
fd00:abcd:220:2::1006 dev tun1 table 0 metric 100
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 sitnl_send: checking for received messages
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 sitnl_send: rtnl: received 36 bytes
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 dco_get_peer: peer-id -1
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 ovpn-dco: received netlink message type=3D31 cmd=
=3D3 flags=3D0x0002
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 ovpn_handle_peer: parsing message for peer 0...
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 ovpn_handle_peer: received data for a non-existi=
ng peer 0
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 ovpn-dco: received netlink message type=3D31 cmd=
=3D3 flags=3D0x0002
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 ovpn_handle_peer: parsing message for peer 1...
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 dco_update_peer_stat / dco_read_bytes(1): 1064936
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 dco_update_peer_stat / dco_write_bytes(1): 10643=
60
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 dco_update_peer_stat / tun_read_bytes(1): 1040000
Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.=
97.140.3:62210 peer-id=3D2 dco_update_peer_stat / tun_write_bytes(1): 10400=
00
```

no float involved, but still we have a "peer-id=3D2" prefix for "peer 1" co=
unters.

So I would suggest to move the `clear_prefix()` call into the DCO functions=
 that deal with incoming messages, most of which will not deal with "the cl=
ient that is currently listed in the prefix".  Maybe `ovpn_handle_msg()` (w=
hich would need the quivalent patch for FreeBSD and Windows)?  Or something=
 generic in `dco.c` that deals with DCO events?



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1ad5df0f6785ffe9becd9f83329a9335d1a36f24
Gerrit-Change-Number: 1116
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Sun, 27 Jul 2025 10:39:01 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--jDCz0JbdkDg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1116?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Actually it is just fixing one particular sy=
mptom, but we can get there in other paths as well - here&#39;s a reconnect=
 that happened to trigger the &quot;query stats now!&quot; timer</p><p styl=
e=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>Jul 27 12:14:55 =
ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.97.140.3:62210 p=
eer-id=3D2 sitnl_send: checking for received messages<br>Jul 27 12:14:55 ub=
untu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.97.140.3:62210 pee=
r-id=3D2 sitnl_send: rtnl: received 36 bytes<br>Jul 27 12:14:55 ubuntu2004 =
tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.97.140.3:62210 peer-id=3D2 =
net_route_v6_del: fd00:abcd:220:201::/64 via fd00:abcd:220:2::1006 dev tun1=
 table 0 metric 100<br>Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: fre=
ebsd-74-amd64/udp6:194.97.140.3:62210 peer-id=3D2 sitnl_send: checking for =
received messages<br>Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freeb=
sd-74-amd64/udp6:194.97.140.3:62210 peer-id=3D2 sitnl_send: rtnl: received =
36 bytes<br>Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd=
64/udp6:194.97.140.3:62210 peer-id=3D2 net_route_v6_del: fd00:abcd:220:200:=
:74/128 via fd00:abcd:220:2::1006 dev tun1 table 0 metric 100<br>Jul 27 12:=
14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.97.140.3:6=
2210 peer-id=3D2 sitnl_send: checking for received messages<br>Jul 27 12:14=
:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.97.140.3:622=
10 peer-id=3D2 sitnl_send: rtnl: received 36 bytes<br>Jul 27 12:14:55 ubunt=
u2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.97.140.3:62210 peer-i=
d=3D2 dco_get_peer: peer-id -1<br>Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[2=
97683]: freebsd-74-amd64/udp6:194.97.140.3:62210 peer-id=3D2 ovpn-dco: rece=
ived netlink message type=3D31 cmd=3D3 flags=3D0x0002<br>Jul 27 12:14:55 ub=
untu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.97.140.3:62210 pee=
r-id=3D2 ovpn_handle_peer: parsing message for peer 0...<br>Jul 27 12:14:55=
 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.97.140.3:62210 =
peer-id=3D2 ovpn_handle_peer: received data for a non-existing peer 0<br>Ju=
l 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: freebsd-74-amd64/udp6:194.97=
.140.3:62210 peer-id=3D2 ovpn-dco: received netlink message type=3D31 cmd=
=3D3 flags=3D0x0002<br>Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: fre=
ebsd-74-amd64/udp6:194.97.140.3:62210 peer-id=3D2 ovpn_handle_peer: parsing=
 message for peer 1...<br>Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[297683]: =
freebsd-74-amd64/udp6:194.97.140.3:62210 peer-id=3D2 dco_update_peer_stat /=
 dco_read_bytes(1): 1064936<br>Jul 27 12:14:55 ubuntu2004 tun-udp-p2mp[2976=
83]: freebsd-74-amd64/udp6:194.97.140.3:62210 peer-id=3D2 dco_update_peer_s=
tat / dco_write_bytes(1): 1064360<br>Jul 27 12:14:55 ubuntu2004 tun-udp-p2m=
p[297683]: freebsd-74-amd64/udp6:194.97.140.3:62210 peer-id=3D2 dco_update_=
peer_stat / tun_read_bytes(1): 1040000<br>Jul 27 12:14:55 ubuntu2004 tun-ud=
p-p2mp[297683]: freebsd-74-amd64/udp6:194.97.140.3:62210 peer-id=3D2 dco_up=
date_peer_stat / tun_write_bytes(1): 1040000<br>```</p><p style=3D"white-sp=
ace: pre-wrap; word-wrap: break-word;">no float involved, but still we have=
 a &quot;peer-id=3D2&quot; prefix for &quot;peer 1&quot; counters.</p><p st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">So I would suggest to=
 move the `clear_prefix()` call into the DCO functions that deal with incom=
ing messages, most of which will not deal with &quot;the client that is cur=
rently listed in the prefix&quot;.  Maybe `ovpn_handle_msg()` (which would =
need the quivalent patch for FreeBSD and Windows)?  Or something generic in=
 `dco.c` that deals with DCO events?</p></li></ul></li></ul><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail">chang=
e 1116</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1116?usp=3Demail"/><meta itemprop=3D"n=
ame" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1ad5df0f6785ffe9becd9f83329=
a9335d1a36f24 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1116 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;antonio@...2726...&gt;=
 </div>
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
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Sun, 27 Jul 2025 10:39:01=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--jDCz0JbdkDg=--

