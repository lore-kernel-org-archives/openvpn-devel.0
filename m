From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 31 Jan 2025 10:56:03 +0000
In-Reply-To: <gerrit.1738070271000.I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb@...2715...>
References: <gerrit.1738070271000.I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <781a38821936ecc731e2155caed8a6de7af08be8-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lM83f8S2Zro="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: route.c: improve
 get_default_gateway() logic on Windows
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lM83f8S2Zro=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/879?usp=3Demail )

Change subject: route.c: improve get_default_gateway() logic on Windows
......................................................................


Patch Set 2:

(2 comments)

File src/openvpn/route.c:

http://gerrit.openvpn.net/c/openvpn/+/879/comment/a12cf014_08dcec58 :
PS2, Line 2812:     DWORD a_index =3D adapter_index_of_ip(adapters, rgi->ga=
teway.addr, NULL, &rgi->gateway.netmask);
This fails for `ON_LINK` targets, where `gateway.addr =3D=3D 0.0.0.0`.

The IPv6 code uses `BestRoute.InterfaceIndex`, because Windows nicely hands=
 this to us anyway.


http://gerrit.openvpn.net/c/openvpn/+/879/comment/879c7db7_bf0b726d :
PS2, Line 2827:
the IPv6 part sets the `RGI_ON_LINK` flag when the `BestRoute.Nexthop` poin=
ts to an empty IPv6 address.  Testing with v4 seems to be similar, so for a=
n onlink-prefix (same IPv4 subnet as on the LAN interface, or just `127.0.0=
.1` to trigger `on-link I=3D1`) I get "ROUTE_GATEWAY 0.0.0.0" - but no ON_L=
INK for v4, yet.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6c7e1cef637fe9fb3f3bc6ff4fb2c65599cd86fb
Gerrit-Change-Number: 879
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-Comment-Date: Fri, 31 Jan 2025 10:56:03 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: No
Gerrit-MessageType: comment

--lM83f8S2Zro=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos, stipa. <=
/p>
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Demail">View C=
hange</a></p><p>2 comments:</p><ul style=3D"list-style: none; padding: 0;">=
<li style=3D"margin: 0; padding: 0;"><p>File src/openvpn/route.c:</p><ul st=
yle=3D"list-style: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 =
0 16px;"><p style=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/879/comment/a12cf014_08dcec58">Patch Set #2, Line 2812:</a>=
 <code style=3D"font-family:monospace,monospace">    DWORD a_index =3D adap=
ter_index_of_ip(adapters, rgi-&gt;gateway.addr, NULL, &amp;rgi-&gt;gateway.=
netmask);</code></p><p style=3D"white-space: pre-wrap; word-wrap: break-wor=
d;">This fails for `ON_LINK` targets, where `gateway.addr =3D=3D 0.0.0.0`.<=
/p><p style=3D"white-space: pre-wrap; word-wrap: break-word;">The IPv6 code=
 uses `BestRoute.InterfaceIndex`, because Windows nicely hands this to us a=
nyway.</p></li><li style=3D"margin: 0; padding: 0 0 0 16px;"><p style=3D"ma=
rgin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/879/com=
ment/879c7db7_bf0b726d">Patch Set #2, Line 2827:</a> <code style=3D"font-fa=
mily:monospace,monospace"></code></p><p style=3D"white-space: pre-wrap; wor=
d-wrap: break-word;">the IPv6 part sets the `RGI_ON_LINK` flag when the `Be=
stRoute.Nexthop` points to an empty IPv6 address.  Testing with v4 seems to=
 be similar, so for an onlink-prefix (same IPv4 subnet as on the LAN interf=
ace, or just `127.0.0.1` to trigger `on-link I=3D1`) I get &quot;ROUTE_GATE=
WAY 0.0.0.0&quot; - but no ON_LINK for v4, yet.</p></li></ul></li></ul><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Dem=
ail">change 879</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/879?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6c7e1cef637fe9fb3f3bc6ff4fb=
2c65599cd86fb </div>
<div style=3D"display:none"> Gerrit-Change-Number: 879 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Comment-Date: Fri, 31 Jan 2025 10:56:03=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: No </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--lM83f8S2Zro=--

