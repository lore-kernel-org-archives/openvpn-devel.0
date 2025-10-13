From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 13 Oct 2025 10:42:09 +0000
In-Reply-To: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
References: <gerrit.1759855064000.I07a8ddd9026eef64b6f5abde98702a9801616a5f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <7dfe87d83129a1168c51f1fa9a3c258227b7dedf-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="nrUIKVsAals="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: PUSH_UPDATE server:
 remove old IP(s) from vhash after sending a messa...
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

--nrUIKVsAals=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

cron2 has posted comments on this change by mrbff. ( http://gerrit.openvpn.=
net/c/openvpn/+/1253?usp=3Demail )

The change is no longer submittable: Code-Review is unsatisfied now.

Change subject: PUSH_UPDATE server: remove old IP(s) from vhash after sendi=
ng a message containing ifconfig(-ipv6)
......................................................................


Patch Set 4: Code-Review-1

(1 comment)

Patchset:

PS4:
Aaaah, partly there.

So, the *first* "PUSH_UPDATE,ifconfig..." works as expected
 - new IP address is pinging
 - old IP address is logged as "unlearn_addr()"
 - packets for new IP are sent to the client, packets for old IP are no lon=
ger sent  (verified with tcpdump on the client tun)

This works for both IPv4 and IPv6.

Then, another "PUSH_UPDATE,ifconfig..." and it correctly learns the "new ne=
w" IP address, but does not unlearn the second address, and tcpdump shows p=
ackets for 2 IPs arrive (.99 is the "first PUSH_UPDATE", .146 is the "secon=
d PUSH_UPDATE")

```
12:39:48.791099 IP 10.204.2.1 > 10.204.2.99: ICMP echo request, id 50521, s=
eq 90, length 64
12:39:48.791109 IP 10.204.2.1 > 10.204.2.99: ICMP echo request, id 50521, s=
eq 90, length 64
12:39:48.791122 IP 10.204.2.1 > 10.204.2.146: ICMP echo request, id 64784, =
seq 90, length 64
```

packets are logged twice because the client has routing enabled and just se=
nds the packet back (the server will then log `MULTI: bad source address fr=
om client [10.204.2.1], packet dropped`).



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: comment
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde98702a9801616a5f
Gerrit-Change-Number: 1253
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Mon, 13 Oct 2025 10:42:09 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes

--nrUIKVsAals=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, mrbff, plaisthos. </p>
<p>Patch set 4:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p>The change is no longer submittable: Code-Review is unsatisfied now.=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">V=
iew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: =
0;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-=
style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p =
style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1253?tab=3Dcomments&amp;usp=3Demail">Patch Set #4:</a> </p><p class=3D"=
blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">Aaaah, part=
ly there.</p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">So, the *first* &quot;PUSH_UPDATE,ifconfig...&qu=
ot; works as expected<br> - new IP address is pinging<br> - old IP address =
is logged as &quot;unlearn_addr()&quot;<br> - packets for new IP are sent t=
o the client, packets for old IP are no longer sent  (verified with tcpdump=
 on the client tun)<br> <br>This works for both IPv4 and IPv6.<br> <br>Then=
, another &quot;PUSH_UPDATE,ifconfig...&quot; and it correctly learns the &=
quot;new new&quot; IP address, but does not unlearn the second address, and=
 tcpdump shows packets for 2 IPs arrive (.99 is the &quot;first PUSH_UPDATE=
&quot;, .146 is the &quot;second PUSH_UPDATE&quot;)</pre><p class=3D"blocks=
" style=3D"white-space: pre-wrap; word-wrap: break-word;">```<br>12:39:48.7=
91099 IP 10.204.2.1 &gt; 10.204.2.99: ICMP echo request, id 50521, seq 90, =
length 64<br>12:39:48.791109 IP 10.204.2.1 &gt; 10.204.2.99: ICMP echo requ=
est, id 50521, seq 90, length 64<br>12:39:48.791122 IP 10.204.2.1 &gt; 10.2=
04.2.146: ICMP echo request, id 64784, seq 90, length 64<br>```</p><p class=
=3D"blocks" style=3D"white-space: pre-wrap; word-wrap: break-word;">packets=
 are logged twice because the client has routing enabled and just sends the=
 packet back (the server will then log `MULTI: bad source address from clie=
nt [10.204.2.1], packet dropped`).</p></li></ul></li></ul><p>To view, visit=
 <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail">change =
1253</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1253?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: comment </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I07a8ddd9026eef64b6f5abde987=
02a9801616a5f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1253 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 13 Oct 2025 10:42:09=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>

</body></html>=

--nrUIKVsAals=--

