From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 13:32:29 +0000
In-Reply-To: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
References: <gerrit.1757957943000.I83295e00d1a756dfa44050b0a4493095fb050fff@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <32d914dc8f9bb17757e4fe2603641fdfa0c40cf1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6btfsmZH4lk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Install host routes
 for ifconfig-push routes when DCO is enabled
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: d12fk <heiko@...515...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6btfsmZH4lk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld, ordex, plaisthos.

cron2 has posted comments on this change by plaisthos. ( http://gerrit.open=
vpn.net/c/openvpn/+/1192?usp=3Demail )

Change subject: Install host routes for ifconfig-push routes when DCO is en=
abled
......................................................................


Patch Set 13: Code-Review-2

(1 comment)

Patchset:

PS13:
We are getting there, but the journey is not over, alas.

Now installation/removal of routes "according to what we want" in general w=
orks fine, but we *always* try to remove the IPv4 host route at the end - h=
ere's for a regular pool IP:

```
Oct 28 14:25:08 fbsd14 tun-udp-p2mp[12610]: MULTI_sva: pool returned IPv4=
=3D10.114.2.3, IPv6=3Dfd00:abcd:114:2::1001
Oct 28 14:25:08 fbsd14 tun-udp-p2mp[12610]: MULTI: Learn: 10.114.2.3 -> cro=
n2-ubuntu-2004-amd64/udp6:195.30.8.84:44555 peer-id=3D1
Oct 28 14:25:08 fbsd14 tun-udp-p2mp[12610]: MULTI: primary virtual IP for c=
ron2-ubuntu-2004-amd64/udp6:195.30.8.84:44555 peer-id=3D1: 10.114.2.3
...
Oct 28 14:26:25 fbsd14 tun-udp-p2mp[12610]: /sbin/route del -net 10.114.2.3=
/32 -iface tun0 -fib 0 -weight 16777115
Oct 28 14:26:25 fbsd14 tun-udp-p2mp[12610]: ERROR: FreeBSD route command fa=
iled: external program exited with error status: 1
```

which obviously is not the way to go forward.  Need to look what changed in=
 IPv4 land here.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I83295e00d1a756dfa44050b0a4493095fb050fff
Gerrit-Change-Number: 1192
Gerrit-PatchSet: 13
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-Comment-Date: Tue, 28 Oct 2025 13:32:29 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--6btfsmZH4lk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: d12fk, flichtenheld, ordex, plaisthos. </p>
<p>Patch set 13:<span style=3D"border-radius: 3px; display: inline-block; m=
argin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -2</span=
></p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">=
View Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding:=
 0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list=
-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p=
 style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1192?tab=3Dcomments&amp;usp=3Demail">Patch Set #13:</a> </p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">We are =
getting there, but the journey is not over, alas.</p><p class=3D"blocks" st=
yle=3D"white-space: pre-wrap; word-wrap: break-word;">Now installation/remo=
val of routes &quot;according to what we want&quot; in general works fine, =
but we *always* try to remove the IPv4 host route at the end - here&#39;s f=
or a regular pool IP:</p><p class=3D"blocks" style=3D"white-space: pre-wrap=
; word-wrap: break-word;">```<br>Oct 28 14:25:08 fbsd14 tun-udp-p2mp[12610]=
: MULTI_sva: pool returned IPv4=3D10.114.2.3, IPv6=3Dfd00:abcd:114:2::1001<=
br>Oct 28 14:25:08 fbsd14 tun-udp-p2mp[12610]: MULTI: Learn: 10.114.2.3 -&g=
t; cron2-ubuntu-2004-amd64/udp6:195.30.8.84:44555 peer-id=3D1<br>Oct 28 14:=
25:08 fbsd14 tun-udp-p2mp[12610]: MULTI: primary virtual IP for cron2-ubunt=
u-2004-amd64/udp6:195.30.8.84:44555 peer-id=3D1: 10.114.2.3<br>...<br>Oct 2=
8 14:26:25 fbsd14 tun-udp-p2mp[12610]: /sbin/route del -net 10.114.2.3/32 -=
iface tun0 -fib 0 -weight 16777115<br>Oct 28 14:26:25 fbsd14 tun-udp-p2mp[1=
2610]: ERROR: FreeBSD route command failed: external program exited with er=
ror status: 1<br>```</p><p class=3D"blocks" style=3D"white-space: pre-wrap;=
 word-wrap: break-word;">which obviously is not the way to go forward.  Nee=
d to look what changed in IPv4 land here.</p></li></ul></li></ul><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail">=
change 1192</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1192?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I83295e00d1a756dfa44050b0a44=
93095fb050fff </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1192 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 13 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Tue, 28 Oct 2025 13:32:29=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--6btfsmZH4lk=--

