From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 17 May 2025 08:19:24 +0000
In-Reply-To: <gerrit.1747427153000.I104b4adeb9f65cce3487b82f35470174acba92bc@...2715...>
References: <gerrit.1747427153000.I104b4adeb9f65cce3487b82f35470174acba92bc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <e68bc39eead9b0bfc9db11b9d3fbbd5d585272d7-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SV1/IW9YdOo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: dco_linux: fix peer
 stats parsing with new ovpn kernel module
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--SV1/IW9YdOo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/1025?usp=3Demail )

Change subject: dco_linux: fix peer stats parsing with new ovpn kernel modu=
le
......................................................................


Patch Set 2: Code-Review+2

(1 comment)

Patchset:

PS2:
Lo and behold!

```
May 17 10:18:34 ubuntu2004 tun-udp-p2mp[58643]: freebsd-14-amd64/udp6:194.9=
7.144.213:32820 peer-id=3D1 dco_update_peer_stat / dco_read_bytes: 462752
May 17 10:18:34 ubuntu2004 tun-udp-p2mp[58643]: freebsd-14-amd64/udp6:194.9=
7.144.213:32820 peer-id=3D1 dco_update_peer_stat / dco_write_bytes: 508520
May 17 10:18:34 ubuntu2004 tun-udp-p2mp[58643]: freebsd-14-amd64/udp6:194.9=
7.144.213:32820 peer-id=3D1 dco_update_peer_stat / tun_read_bytes: 432920
May 17 10:18:34 ubuntu2004 tun-udp-p2mp[58643]: freebsd-14-amd64/udp6:194.9=
7.144.213:32820 peer-id=3D1 dco_update_peer_stat / tun_write_bytes: 476336
```

counters!!



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1025?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I104b4adeb9f65cce3487b82f35470174acba92bc
Gerrit-Change-Number: 1025
Gerrit-PatchSet: 2
Gerrit-Owner: ordex <antonio@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Comment-Date: Sat, 17 May 2025 08:19:24 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--SV1/IW9YdOo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>Patch set 2:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1025?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1025?tab=3Dcomments">Patch Set #2:</a> </p><p style=3D"white-space: pre=
-wrap; word-wrap: break-word;">Lo and behold!</p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">```<br>May 17 10:18:34 ubuntu2004 tun-udp-=
p2mp[58643]: freebsd-14-amd64/udp6:194.97.144.213:32820 peer-id=3D1 dco_upd=
ate_peer_stat / dco_read_bytes: 462752<br>May 17 10:18:34 ubuntu2004 tun-ud=
p-p2mp[58643]: freebsd-14-amd64/udp6:194.97.144.213:32820 peer-id=3D1 dco_u=
pdate_peer_stat / dco_write_bytes: 508520<br>May 17 10:18:34 ubuntu2004 tun=
-udp-p2mp[58643]: freebsd-14-amd64/udp6:194.97.144.213:32820 peer-id=3D1 dc=
o_update_peer_stat / tun_read_bytes: 432920<br>May 17 10:18:34 ubuntu2004 t=
un-udp-p2mp[58643]: freebsd-14-amd64/udp6:194.97.144.213:32820 peer-id=3D1 =
dco_update_peer_stat / tun_write_bytes: 476336<br>```</p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">counters!!</p></li></ul></li></ul>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1025?usp=
=3Demail">change 1025</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1025?usp=3Demail"/><met=
a itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I104b4adeb9f65cce3487b82f354=
70174acba92bc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1025 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Sat, 17 May 2025 08:19:24=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--SV1/IW9YdOo=--

