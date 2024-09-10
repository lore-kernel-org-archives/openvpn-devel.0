From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 10 Sep 2024 10:21:30 +0000
In-Reply-To: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
References: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <c1ac5d5cbd30dee9d4c76c6f90febde348c16967-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="cFKHz8oo4PQ="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--cFKHz8oo4PQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, mrbff, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: tun: removed unnecessary route installations
......................................................................

tun: removed unnecessary route installations

Removed superfluous calls to 'add_route_ipv6' for adding ipv6 routes after =
tun opening in OpenBSD, NetBSD and Darwin.

Change-Id: I235891212b15277349810913c9c1763da5c48587
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/tun.c
1 file changed, 1 insertion(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/731/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: mrbff <marco@...2726...>
Gerrit-MessageType: newpatchset

--cFKHz8oo4PQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, mrbff, plaisthos. <=
/p>
<p>mrbff <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail">View Change</a=
></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">tun: removed unn=
ecessary route installations<br><br>Removed superfluous calls to &#39;add_r=
oute_ipv6&#39; for adding ipv6 routes after tun opening in OpenBSD, NetBSD =
and Darwin.<br><br>Change-Id: I235891212b15277349810913c9c1763da5c48587<br>=
Signed-off-by: Marco Baffo &lt;marco@...2726...&gt;<br>---<br>M src/openvpn=
/tun.c<br>1 file changed, 1 insertion(+), 7 deletions(-)<br><br></pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/731/3</pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff =
--git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index 739e008=
..82c5c00 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><span>++=
+ b/src/openvpn/tun.c</span><br><span>@@ -1008,8 +1008,7 @@</span><br><span=
> #endif /* ifdef _WIN32 */</span><br><span> }</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)    \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    || defined(TARGET_DARWIN)=
 || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span> </sp=
an><br><span> /* some of the platforms will auto-add a &quot;network route&=
quot; pointing</span><br><span>  * to the interface on &quot;ifconfig tunX =
2001:db8::1/64&quot;, others need</span><br><span>@@ -1200,11 +1199,6 @@</s=
pan><br><span>                          &quot;FreeBSD BSD &#39;ifconfig ine=
t6 -ifdisabled&#39; failed&quot;);</span><br><span> #endif</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_O=
PENBSD) || defined(TARGET_NETBSD) \</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    || defined(TARGET_DARWIN)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* and, hooray, we explicitly need to add a route=
... */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    add_route_c=
onnected_v6_net(tt, es);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span> #elif defined(TARGET_AIX)</span><br><span>     a=
rgv_printf(&amp;argv, &quot;%s %s inet6 %s/%d mtu %d up&quot;, IFCONFIG_PAT=
H, ifname,</span><br><span>                 ifconfig_ipv6_local, tt-&gt;net=
bits_ipv6, tun_mtu);</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail">change 731</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/731?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I235891212b15277349810913c9c=
1763da5c48587 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 731 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: mrbff &lt;marco@...2726...&gt; <=
/div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--cFKHz8oo4PQ=--

