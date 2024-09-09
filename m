From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 9 Sep 2024 10:45:48 +0000
In-Reply-To: <gerrit.1715339249000.Ic8538e734dba53cd43fead3961e4401c8037e079@...2715...>
References: <gerrit.1715339249000.Ic8538e734dba53cd43fead3961e4401c8037e079@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <88b2340fd8e1dd603f0dbecf600158655f033ec1-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1mFdIChCTow="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Ensures all params
 are ready before invoking dco_set_peer()
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: its_Giaan <gianmarco@...2726...>
Cc: stipa <lstipakov@...277...>, flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1mFdIChCTow=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/587?usp=3Demail )

Change subject: Ensures all params are ready before invoking dco_set_peer()
......................................................................


Patch Set 5: Code-Review-1

(1 comment)

Patchset:

PS5:
I'm not sure the patch is actually fixing the problematic behaviour ("not u=
pdating mssfix correctly on pushed values").

If I run the code with `--tun-mtu 500` on the command line (proto UDP, IPv4=
), I see

```
2024-09-09 12:36:53 us=3D890850 dco_set_peer: peer-id 0, keepalive 10/30, m=
ss 460
```

which sounds reasonable.

if I run with `--tun-mtu 1500` locally, and the server pushes `--tun-mtu 14=
00`, I get

```
2024-09-09 12:37:43 us=3D641363 net_iface_mtu_set: mtu 1400 for tun7
2024-09-09 12:37:43 us=3D642421 Data Channel MTU parms [ mss_fix:1400 max_f=
rag:0 tun_mtu:1400 tun_max_mtu:1600 headroom:136 payload:1768 tailroom:562 =
ET:0 ]
2024-09-09 12:37:43 us=3D642891 dco_set_peer: peer-id 1, keepalive 10/30, m=
ss 1400
```

which is not what I'd expect - but it is the same behaviour as "without thi=
s patch".

So, to proceed here, I need instructions for "how to demonstrate the proble=
m", which actually see a change in behaviour with the patch...



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic8538e734dba53cd43fead3961e4401c8037e079
Gerrit-Change-Number: 587
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Comment-Date: Mon, 09 Sep 2024 10:45:48 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--1mFdIChCTow=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>Patch set 5:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #ffd4d4;">Code-Review -1</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/587?tab=3Dcomments">Patch Set #5:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">I&#39;m not sure the patch is actually fixing =
the problematic behaviour (&quot;not updating mssfix correctly on pushed va=
lues&quot;).</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">=
If I run the code with `--tun-mtu 500` on the command line (proto UDP, IPv4=
), I see</p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">```<=
br>2024-09-09 12:36:53 us=3D890850 dco_set_peer: peer-id 0, keepalive 10/30=
, mss 460<br>```</p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">which sounds reasonable.</p><p style=3D"white-space: pre-wrap; word-wra=
p: break-word;">if I run with `--tun-mtu 1500` locally, and the server push=
es `--tun-mtu 1400`, I get</p><p style=3D"white-space: pre-wrap; word-wrap:=
 break-word;">```<br>2024-09-09 12:37:43 us=3D641363 net_iface_mtu_set: mtu=
 1400 for tun7<br>2024-09-09 12:37:43 us=3D642421 Data Channel MTU parms [ =
mss_fix:1400 max_frag:0 tun_mtu:1400 tun_max_mtu:1600 headroom:136 payload:=
1768 tailroom:562 ET:0 ]<br>2024-09-09 12:37:43 us=3D642891 dco_set_peer: p=
eer-id 1, keepalive 10/30, mss 1400<br>```</p><p style=3D"white-space: pre-=
wrap; word-wrap: break-word;">which is not what I&#39;d expect - but it is =
the same behaviour as &quot;without this patch&quot;.</p><p style=3D"white-=
space: pre-wrap; word-wrap: break-word;">So, to proceed here, I need instru=
ctions for &quot;how to demonstrate the problem&quot;, which actually see a=
 change in behaviour with the patch...</p></li></ul></li></ul><p>To view, v=
isit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail">chan=
ge 587</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/587?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic8538e734dba53cd43fead3961e=
4401c8037e079 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 587 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Mon, 09 Sep 2024 10:45:48=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--1mFdIChCTow=--

