From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 12 Sep 2024 14:30:36 +0000
In-Reply-To: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
References: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ef621a2b33fee443f88406b517b1eab5b3cf8368-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CHMa6USWuPQ="; charset=UTF-8
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
To: mrbff <marco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CHMa6USWuPQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 mrbff. ( http://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: tun: removed unnecessary route installations
......................................................................

tun: removed unnecessary route installations

Removed superfluous calls to 'add_route_ipv6' for adding ipv6 routes after =
tun opening in OpenBSD, NetBSD and Darwin.

Change-Id: I235891212b15277349810913c9c1763da5c48587
Signed-off-by: Marco Baffo <marco@...2726...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240912142421.703-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
217.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/tun.c
1 file changed, 1 insertion(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/731/4

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 739e008..82c5c00 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1008,8 +1008,7 @@
 #endif /* ifdef _WIN32 */
 }

-#if defined(_WIN32)    \
-    || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_=
OPENBSD)
+#if defined(_WIN32)

 /* some of the platforms will auto-add a "network route" pointing
  * to the interface on "ifconfig tunX 2001:db8::1/64", others need
@@ -1200,11 +1199,6 @@
                          "FreeBSD BSD 'ifconfig inet6 -ifdisabled' failed"=
);
 #endif

-#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
-    || defined(TARGET_DARWIN)
-    /* and, hooray, we explicitly need to add a route... */
-    add_route_connected_v6_net(tt, es);
-#endif
 #elif defined(TARGET_AIX)
     argv_printf(&argv, "%s %s inet6 %s/%d mtu %d up", IFCONFIG_PATH, ifnam=
e,
                 ifconfig_ipv6_local, tt->netbits_ipv6, tun_mtu);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I235891212b15277349810913c9c1763da5c48587
Gerrit-Change-Number: 731
Gerrit-PatchSet: 4
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--CHMa6USWuPQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by mrbff.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/731?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">tun: removed unnecessary route installations<br><br>=
Removed superfluous calls to &#39;add_route_ipv6&#39; for adding ipv6 route=
s after tun opening in OpenBSD, NetBSD and Darwin.<br><br>Change-Id: I23589=
1212b15277349810913c9c1763da5c48587<br>Signed-off-by: Marco Baffo &lt;marco=
@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Messag=
e-Id: &lt;20240912142421.703-1-gert@...1296...&gt;<br>URL: https://www.mail=
-archive.com/openvpn-devel@lists.sourceforge.net/msg29217.html<br>Signed-of=
f-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/tun.c<br=
>1 file changed, 1 insertion(+), 7 deletions(-)<br><br></pre><pre style=3D"=
font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://ge=
rrit.openvpn.net:29418/openvpn refs/changes/31/731/4</pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/s=
rc/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 739e008..82c5c00=
 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/o=
penvpn/tun.c</span><br><span>@@ -1008,8 +1008,7 @@</span><br><span> #endif =
/* ifdef _WIN32 */</span><br><span> }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)    \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    || defined(TARGET_DARWIN) || defin=
ed(TARGET_NETBSD) || defined(TARGET_OPENBSD)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span> </span><br><s=
pan> /* some of the platforms will auto-add a &quot;network route&quot; poi=
nting</span><br><span>  * to the interface on &quot;ifconfig tunX 2001:db8:=
:1/64&quot;, others need</span><br><span>@@ -1200,11 +1199,6 @@</span><br><=
span>                          &quot;FreeBSD BSD &#39;ifconfig inet6 -ifdis=
abled&#39; failed&quot;);</span><br><span> #endif</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_OPENBSD) |=
| defined(TARGET_NETBSD) \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    || defined(TARGET_DARWIN)</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    /* and, hooray, we explicitly need to add a route... */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    add_route_connected_=
v6_net(tt, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span> #elif defined(TARGET_AIX)</span><br><span>     argv_print=
f(&amp;argv, &quot;%s %s inet6 %s/%d mtu %d up&quot;, IFCONFIG_PATH, ifname=
,</span><br><span>                 ifconfig_ipv6_local, tt-&gt;netbits_ipv6=
, tun_mtu);</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail">change 731</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/731?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I235891212b15277349810913c9c=
1763da5c48587 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 731 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--CHMa6USWuPQ=--

