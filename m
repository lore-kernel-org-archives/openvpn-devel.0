From: "mrbff (Code Review)" <gerrit@...515...>
Date: Tue, 20 Aug 2024 12:23:26 +0000
References: <gerrit.1724156602000.I235891212b15277349810913c9c1763da5c48587@...2715...>
Reply-To: marco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <42cc26dd37953dad1a92c6901ead7c1e483e19d1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9rmwunN+oqA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tun: removed
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

--9rmwunN+oqA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail

to review the following change.


Change subject: tun: removed unnecessary route installations
......................................................................

tun: removed unnecessary route installations

Removed superfluous calls to 'add_route_ipv6' for adding ipv6 routes after =
tun opening in OpenBSD, NetBSD and Darwin.

Change-Id: I235891212b15277349810913c9c1763da5c48587
Signed-off-by: Marco Baffo <marco@...2726...>
---
M src/openvpn/route.c
M src/openvpn/tun.c
2 files changed, 1 insertion(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/31/731/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 71b5b42..31a634a 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -2244,9 +2244,6 @@
     {
         argv_printf_cat(&argv, "-link -iface %s", device);
     }
-    /* FIX ME: in NetBSD in TUN mode, the route is already added by ifconf=
ig
-     * so add_route_ipv6 fail with 'Invalid argument' or 'File exists'
-     */

     argv_msg(D_ROUTE, &argv);
     bool ret =3D openvpn_execve_check(&argv, es, 0,
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index d878161..7bdc6c4 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1010,8 +1010,7 @@
 #endif /* ifdef _WIN32 */
 }

-#if defined(_WIN32)    \
-    || defined(TARGET_DARWIN) || defined(TARGET_NETBSD) || defined(TARGET_=
OPENBSD)
+#if defined(_WIN32)

 /* some of the platforms will auto-add a "network route" pointing
  * to the interface on "ifconfig tunX 2001:db8::1/64", others need
@@ -1203,11 +1202,6 @@
                          "FreeBSD BSD 'ifconfig inet6 -ifdisabled' failed"=
);
 #endif

-#if defined(TARGET_OPENBSD) || defined(TARGET_NETBSD) \
-    || defined(TARGET_DARWIN)
-    /* and, hooray, we explicitly need to add a route... */
-    add_route_connected_v6_net(tt, es, is_multipoint);
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
Gerrit-PatchSet: 1
Gerrit-Owner: mrbff <marco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--9rmwunN+oqA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>mrbff would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">tun: removed unnecessary route installations<br><br>Removed s=
uperfluous calls to &#39;add_route_ipv6&#39; for adding ipv6 routes after t=
un opening in OpenBSD, NetBSD and Darwin.<br><br>Change-Id: I235891212b1527=
7349810913c9c1763da5c48587<br>Signed-off-by: Marco Baffo &lt;marco@...2786...=
..&gt;<br>---<br>M src/openvpn/route.c<br>M src/openvpn/tun.c<br>2 files ch=
anged, 1 insertion(+), 10 deletions(-)<br><br></pre><pre style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/31/731/1</pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvp=
n/route.c b/src/openvpn/route.c</span><br><span>index 71b5b42..31a634a 1006=
44</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/open=
vpn/route.c</span><br><span>@@ -2244,9 +2244,6 @@</span><br><span>     {</s=
pan><br><span>         argv_printf_cat(&amp;argv, &quot;-link -iface %s&quo=
t;, device);</span><br><span>     }</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* FIX ME: in NetBSD in TUN mode, the route is already ad=
ded by ifconfig</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     *=
 so add_route_ipv6 fail with &#39;Invalid argument&#39; or &#39;File exists=
&#39;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span><b=
r><span> </span><br><span>     argv_msg(D_ROUTE, &amp;argv);</span><br><spa=
n>     bool ret =3D openvpn_execve_check(&amp;argv, es, 0,</span><br><span>=
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c</span><br><span>index d8=
78161..7bdc6c4 100644</span><br><span>--- a/src/openvpn/tun.c</span><br><sp=
an>+++ b/src/openvpn/tun.c</span><br><span>@@ -1010,8 +1010,7 @@</span><br>=
<span> #endif /* ifdef _WIN32 */</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32)    \</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    || defined(TARGET_DA=
RWIN) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#if defined(_WIN32)</span><br><span>=
 </span><br><span> /* some of the platforms will auto-add a &quot;network r=
oute&quot; pointing</span><br><span>  * to the interface on &quot;ifconfig =
tunX 2001:db8::1/64&quot;, others need</span><br><span>@@ -1203,11 +1202,6 =
@@</span><br><span>                          &quot;FreeBSD BSD &#39;ifconfi=
g inet6 -ifdisabled&#39; failed&quot;);</span><br><span> #endif</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TAR=
GET_OPENBSD) || defined(TARGET_NETBSD) \</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    || defined(TARGET_DARWIN)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    /* and, hooray, we explicitly need to add a =
route... */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    add_ro=
ute_connected_v6_net(tt, es, is_multipoint);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span> #elif defined(TARGET_AIX)</s=
pan><br><span>     argv_printf(&amp;argv, &quot;%s %s inet6 %s/%d mtu %d up=
&quot;, IFCONFIG_PATH, ifname,</span><br><span>                 ifconfig_ip=
v6_local, tt-&gt;netbits_ipv6, tun_mtu);</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/731?usp=
=3Demail">change 731</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/731?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I235891212b15277349810913c9c=
1763da5c48587 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 731 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--9rmwunN+oqA=--

