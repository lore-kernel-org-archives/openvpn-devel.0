From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 25 Jul 2025 17:20:30 +0000
In-Reply-To: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
References: <gerrit.1753215725000.I23ad79e14844aefde9ece34dadef0b75ff267201@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <a6e2b356f0ce8086f38ebe2954d7d7c9c8565df5-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="19RCOgstbeE="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dco_linux: fix async
 message reception
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--19RCOgstbeE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1100?usp=3Demail )

Change subject: dco_linux: fix async message reception
......................................................................


Patch Set 5: Code-Review+2

(1 comment)

Patchset:

PS5:
Hah, gotcha

```
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_get_peer_stats_multi
Jul 25 19:18:56 ubuntu2004 tun-udp-p2p-tls-sha256[186220]: dco_do_read
Jul 25 19:18:56 ubuntu2004 tun-udp-p2p-tls-sha256[186220]: ovpn-dco: receiv=
ed netlink message type=3D31 cmd=3D11 flags=3D0000
Jul 25 19:18:56 ubuntu2004 tun-udp-p2p-tls-sha256[186220]: ovpn-dco: ignori=
ng message for foreign ifindex 982
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: ovpn-dco: received netlink=
 message type=3D31 cmd=3D11 flags=3D0000
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: ovpn-dco: received CMD_PEE=
R_FLOAT_NTF, ifindex: 982, peer-id 2, address: [AF_INET]193.149.48.173:59979
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: ovpn-dco: received netlink=
 message type=3D31 cmd=3D3 flags=3D0x0002
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: ovpn_handle_peer_multi: pa=
rsing message...
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update_peer_stat / dco=
_read_bytes(0): 615704
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update_peer_stat / dco=
_write_bytes(0): 625840
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update_peer_stat / tun=
_read_bytes(0): 562992
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update_peer_stat / tun=
_write_bytes(0): 568872
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: ovpn-dco: received netlink=
 message type=3D31 cmd=3D3 flags=3D0x0002
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: ovpn_handle_peer_multi: pa=
rsing message...
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update_peer_stat / dco=
_read_bytes(2): 11732
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update_peer_stat / dco=
_write_bytes(2): 11392
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update_peer_stat / tun=
_read_bytes(2): 9256
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update_peer_stat / tun=
_write_bytes(2): 9256
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_do_read
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_do_read: netlink repor=
ts blocking read - aborting wait
Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: peer 2 (cron2-freebsd-tc-a=
md64) floated from udp6:193.149.48.172:59979 to [AF_INET6]::ffff:193.149.48=
.173:59979
Jul 25 19:18:57 ubuntu2004 kernel: [294871.134548] tun1: peer 2 floated to =
193.149.48.173:59979
```

this is precisely the situation that makes the pre-1100 code lose the "FLOA=
T!" message, because it arrives *after* `dco_get_peer_stats_multi()` starts=
 running (or just before, but we do not look at DCO events) and before the =
actual cmd=3D3 reply comes in.

Good work!



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I23ad79e14844aefde9ece34dadef0b75ff267201
Gerrit-Change-Number: 1100
Gerrit-PatchSet: 5
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Fri, 25 Jul 2025 17:20:30 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--19RCOgstbeE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1100?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1100?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Hah, gotcha</p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">```<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p2m=
p[186147]: dco_get_peer_stats_multi<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p=
2p-tls-sha256[186220]: dco_do_read<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p2=
p-tls-sha256[186220]: ovpn-dco: received netlink message type=3D31 cmd=3D11=
 flags=3D0000<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p2p-tls-sha256[186220]:=
 ovpn-dco: ignoring message for foreign ifindex 982<br>Jul 25 19:18:56 ubun=
tu2004 tun-udp-p2mp[186147]: ovpn-dco: received netlink message type=3D31 c=
md=3D11 flags=3D0000<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: ov=
pn-dco: received CMD_PEER_FLOAT_NTF, ifindex: 982, peer-id 2, address: [AF_=
INET]193.149.48.173:59979<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147=
]: ovpn-dco: received netlink message type=3D31 cmd=3D3 flags=3D0x0002<br>J=
ul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: ovpn_handle_peer_multi: par=
sing message...<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_upd=
ate_peer_stat / dco_read_bytes(0): 615704<br>Jul 25 19:18:56 ubuntu2004 tun=
-udp-p2mp[186147]: dco_update_peer_stat / dco_write_bytes(0): 625840<br>Jul=
 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update_peer_stat / tun_re=
ad_bytes(0): 562992<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco=
_update_peer_stat / tun_write_bytes(0): 568872<br>Jul 25 19:18:56 ubuntu200=
4 tun-udp-p2mp[186147]: ovpn-dco: received netlink message type=3D31 cmd=3D=
3 flags=3D0x0002<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: ovpn_h=
andle_peer_multi: parsing message...<br>Jul 25 19:18:56 ubuntu2004 tun-udp-=
p2mp[186147]: dco_update_peer_stat / dco_read_bytes(2): 11732<br>Jul 25 19:=
18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update_peer_stat / dco_write_byt=
es(2): 11392<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_update=
_peer_stat / tun_read_bytes(2): 9256<br>Jul 25 19:18:56 ubuntu2004 tun-udp-=
p2mp[186147]: dco_update_peer_stat / tun_write_bytes(2): 9256<br>Jul 25 19:=
18:56 ubuntu2004 tun-udp-p2mp[186147]: dco_do_read<br>Jul 25 19:18:56 ubunt=
u2004 tun-udp-p2mp[186147]: dco_do_read: netlink reports blocking read - ab=
orting wait<br>Jul 25 19:18:56 ubuntu2004 tun-udp-p2mp[186147]: peer 2 (cro=
n2-freebsd-tc-amd64) floated from udp6:193.149.48.172:59979 to [AF_INET6]::=
ffff:193.149.48.173:59979<br>Jul 25 19:18:57 ubuntu2004 kernel: [294871.134=
548] tun1: peer 2 floated to 193.149.48.173:59979<br>```</p><p style=3D"whi=
te-space: pre-wrap; word-wrap: break-word;">this is precisely the situation=
 that makes the pre-1100 code lose the &quot;FLOAT!&quot; message, because =
it arrives *after* `dco_get_peer_stats_multi()` starts running (or just bef=
ore, but we do not look at DCO events) and before the actual cmd=3D3 reply =
comes in.</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">Goo=
d work!</p></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1100?usp=3Demail">change 1100</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1100?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I23ad79e14844aefde9ece34dade=
f0b75ff267201 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1100 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 25 Jul 2025 17:20:30=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--19RCOgstbeE=--

