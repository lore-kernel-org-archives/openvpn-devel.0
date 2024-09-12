From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 12 Sep 2024 14:23:52 +0000
In-Reply-To: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
References: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <234709eaae0fda0e53ee8dd34d86f4ad16d4dd10-EmailReviewComments-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UNFQ37Ru14k="; charset=UTF-8
Subject: [Openvpn-devel] [XS] Change in openvpn[master]: tun: removed
 unnecessary route installations
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: mrbff <marco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UNFQ37Ru14k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

cron2 has posted comments on this change. ( http://gerrit.openvpn.net/c/ope=
nvpn/+/731?usp=3Demail )

Change subject: tun: removed unnecessary route installations
......................................................................


Patch Set 3: Code-Review+2

(1 comment)

Patchset:

PS3:
So, since I'm the one that wrote the original code, I went out to thoroughl=
y test this ("our buildbots succeed", is, unfortunately, not completely ind=
icative as I push an encompassing /48 route - so even if the /64 fails to g=
et installed, things would still work). Test with t_client setup + added "-=
-route-nopull" so you'll only get the connected routes, and then see if ser=
ver tun/tap IPv6 address still pings.

NetBSD: without the patch, error message on "route add", with the patch, ev=
erything works - no error messages anymore.

OpenBSD: no error message, just double connected /64 route with different f=
lags (UCn vs. UGS).  With the patch, everything works, no double routes.

MacOS (13.6.7): similar to NetBSD - without the patch, error message on "ro=
ute add", with the patch, everything works. Could not test TAP mode, as sys=
tem security gets in the way.



--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I235891212b15277349810913c9c1763da5c48587
Gerrit-Change-Number: 731
Gerrit-PatchSet: 3
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-Comment-Date: Thu, 12 Sep 2024 14:23:52 +0000
Gerrit-HasComments: Yes
Gerrit-Has-Labels: Yes
Gerrit-MessageType: comment

--UNFQ37Ru14k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>Patch set 3:<span style=3D"border-radius: 3px; display: inline-block; ma=
rgin: 0 2px; padding: 4px;background-color: #d4ffd4;">Code-Review +2</span>=
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail">Vi=
ew Change</a></p><p>1 comment:</p><ul style=3D"list-style: none; padding: 0=
;"><li style=3D"margin: 0; padding: 0;"><p>Patchset:</p><ul style=3D"list-s=
tyle: none; padding: 0;"><li style=3D"margin: 0; padding: 0 0 0 16px;"><p s=
tyle=3D"margin-bottom: 4px;"><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/731?tab=3Dcomments">Patch Set #3:</a> </p><p style=3D"white-space: pre-w=
rap; word-wrap: break-word;">So, since I&#39;m the one that wrote the origi=
nal code, I went out to thoroughly test this (&quot;our buildbots succeed&q=
uot;, is, unfortunately, not completely indicative as I push an encompassin=
g /48 route - so even if the /64 fails to get installed, things would still=
 work). Test with t_client setup + added &quot;--route-nopull&quot; so you&=
#39;ll only get the connected routes, and then see if server tun/tap IPv6 a=
ddress still pings.</p><p style=3D"white-space: pre-wrap; word-wrap: break-=
word;">NetBSD: without the patch, error message on &quot;route add&quot;, w=
ith the patch, everything works - no error messages anymore.</p><p style=3D=
"white-space: pre-wrap; word-wrap: break-word;">OpenBSD: no error message, =
just double connected /64 route with different flags (UCn vs. UGS).  With t=
he patch, everything works, no double routes.</p><p style=3D"white-space: p=
re-wrap; word-wrap: break-word;">MacOS (13.6.7): similar to NetBSD - withou=
t the patch, error message on &quot;route add&quot;, with the patch, everyt=
hing works. Could not test TAP mode, as system security gets in the way.</p=
></li></ul></li></ul><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/731?usp=3Demail">change 731</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/731?=
usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I235891212b15277349810913c9c=
1763da5c48587 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 731 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
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
<div style=3D"display:none"> Gerrit-Comment-Date: Thu, 12 Sep 2024 14:23:52=
 +0000 </div>
<div style=3D"display:none"> Gerrit-HasComments: Yes </div>
<div style=3D"display:none"> Gerrit-Has-Labels: Yes </div>
<div style=3D"display:none"> Gerrit-MessageType: comment </div>


--UNFQ37Ru14k=--

