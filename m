From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 17 Sep 2025 13:22:06 +0000
In-Reply-To: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
References: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
Reply-To: arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <b0f58cb3ed528da40ca9899578fdd0939612add1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yRTKN5+dC+E="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allow
 route_ipv6_match_host to be used outside of route.c
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: d12fk <heiko@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--yRTKN5+dC+E=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello flichtenheld, ordex,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review+1 by ordex


Change subject: Allow route_ipv6_match_host to be used outside of route.c
......................................................................

Allow route_ipv6_match_host to be used outside of route.c

Also adjust style a bit to C99

Change-Id: Ief1495b52ea81cac35d78e40264372d3869423f1
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/route.c
M src/openvpn/route.h
2 files changed, 23 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1191/4

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index e504485..2bae681 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -710,25 +710,20 @@
     return ret;
 }

-/* check whether an IPv6 host address is covered by a given route_ipv6
- * (not the most beautiful implementation in the world, but portable and
- * "good enough")
- */
-static bool
-route_ipv6_match_host(const struct route_ipv6 *r6, const struct in6_addr *=
host)
+bool
+ipv6_net_contains_host(const struct in6_addr *network, unsigned int bits, =
const struct in6_addr *host)
 {
-    unsigned int bits =3D r6->netbits;
-    int i;
-    unsigned int mask;
-
+    /* (not the most beautiful implementation in the world, but portable a=
nd
+     * "good enough") */
     if (bits > 128)
     {
         return false;
     }

+    int i =3D 0;
     for (i =3D 0; bits >=3D 8; i++, bits -=3D 8)
     {
-        if (r6->network.s6_addr[i] !=3D host->s6_addr[i])
+        if (network->s6_addr[i] !=3D host->s6_addr[i])
         {
             return false;
         }
@@ -739,9 +734,9 @@
         return true;
     }

-    mask =3D 0xff << (8 - bits);
+    unsigned int mask =3D 0xff << (8 - bits);

-    if ((r6->network.s6_addr[i] & mask) =3D=3D (host->s6_addr[i] & mask))
+    if ((network->s6_addr[i] & mask) =3D=3D (host->s6_addr[i] & mask))
     {
         return true;
     }
@@ -830,7 +825,8 @@
                  * avoiding routing loops, so ignore this part and let
                  * need_remote_ipv6_route always evaluate to false
                  */
-                if (remote_host_ipv6 && route_ipv6_match_host(r6, remote_h=
ost_ipv6))
+                if (remote_host_ipv6
+                    && ipv6_net_contains_host(&r6->network, r6->netbits, r=
emote_host_ipv6))
                 {
                     need_remote_ipv6_route =3D true;
                     msg(D_ROUTE,
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 9b6a47e..21f37a2 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -426,4 +426,17 @@
     return rl && BOOL_CAST(rl->iflags & RL_DID_REDIRECT_DEFAULT_GATEWAY);
 }

+
+/**
+ * check whether an IPv6 host address is covered by a given network/bits
+ * @param network the network address
+ * @param bits the network mask
+ * @param host the host address to be checked if it is contained by the ne=
twork
+ *
+ * @return true if the host address is covered by the network with the giv=
en
+ *         network mask by bits
+ */
+bool
+ipv6_net_contains_host(const struct in6_addr *network, unsigned int bits, =
const struct in6_addr *host);
+
 #endif /* ifndef ROUTE_H */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ief1495b52ea81cac35d78e40264372d3869423f1
Gerrit-Change-Number: 1191
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <antonio@...2726...>
Gerrit-MessageType: newpatchset

--yRTKN5+dC+E=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by ordex</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Allow route_ipv6_match_host to be used outside of ro=
ute.c<br><br>Also adjust style a bit to C99<br><br>Change-Id: Ief1495b52ea8=
1cac35d78e40264372d3869423f1<br>Signed-off-by: Arne Schwabe &lt;arne@...2068...=
7...&gt;<br>---<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>2 file=
s changed, 23 insertions(+), 14 deletions(-)<br><br></pre><pre style=3D"fon=
t-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerri=
t.openvpn.net:29418/openvpn refs/changes/91/1191/4</pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src=
/openvpn/route.c b/src/openvpn/route.c</span><br><span>index e504485..2bae6=
81 100644</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/s=
rc/openvpn/route.c</span><br><span>@@ -710,25 +710,20 @@</span><br><span>  =
   return ret;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* check whether an IPv6 host address is co=
vered by a given route_ipv6</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">- * (not the most beautiful implementation in the world, but portable =
and</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * &quot;good enou=
gh&quot;)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-route_ipv6_match_host(const struct route=
_ipv6 *r6, const struct in6_addr *host)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ipv6_net_contains_host(const struct in6_addr *network, unsigned int bi=
ts, const struct in6_addr *host)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned int bits =3D r6-&gt;netbits;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    unsigned int mask;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* (not the most beautiful implementation in the=
 world, but portable and</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     * &quot;good enough&quot;) */</span><br><span>     if (bits &gt; =
128)</span><br><span>     {</span><br><span>         return false;</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    int i =3D 0;</span><br><span>     for (i =3D 0; bits &gt;=
=3D 8; i++, bits -=3D 8)</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        if (r6-&gt;network.s6_addr[i] !=3D host-&=
gt;s6_addr[i])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (network-&gt;s6_addr[i] !=3D host-&gt;s6_addr[i])</span><br><span>   =
      {</span><br><span>             return false;</span><br><span>        =
 }</span><br><span>@@ -739,9 +734,9 @@</span><br><span>         return true=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    mask =3D 0xff &lt;&lt; (8 - bits);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    unsigned int mask =3D 0xff &lt;=
&lt; (8 - bits);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if ((r6-&gt;network.s6_addr[i] &amp; mask) =3D=3D (host-&g=
t;s6_addr[i] &amp; mask))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if ((network-&gt;s6_addr[i] &amp; mask) =3D=3D (host-&gt;s6_addr[=
i] &amp; mask))</span><br><span>     {</span><br><span>         return true=
;</span><br><span>     }</span><br><span>@@ -830,7 +825,8 @@</span><br><spa=
n>                  * avoiding routing loops, so ignore this part and let</=
span><br><span>                  * need_remote_ipv6_route always evaluate t=
o false</span><br><span>                  */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                if (remote_host_ipv6 &amp;&amp; rout=
e_ipv6_match_host(r6, remote_host_ipv6))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                if (remote_host_ipv6</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    &amp;&amp; ipv6_n=
et_contains_host(&amp;r6-&gt;network, r6-&gt;netbits, remote_host_ipv6))</s=
pan><br><span>                 {</span><br><span>                     need_=
remote_ipv6_route =3D true;</span><br><span>                     msg(D_ROUT=
E,</span><br><span>diff --git a/src/openvpn/route.h b/src/openvpn/route.h</=
span><br><span>index 9b6a47e..21f37a2 100644</span><br><span>--- a/src/open=
vpn/route.h</span><br><span>+++ b/src/openvpn/route.h</span><br><span>@@ -4=
26,4 +426,17 @@</span><br><span>     return rl &amp;&amp; BOOL_CAST(rl-&gt;=
iflags &amp; RL_DID_REDIRECT_DEFAULT_GATEWAY);</span><br><span> }</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * check whether an IPv6 host address is cover=
ed by a given network/bits</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param network the network address</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param bits the network mask</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param host the host address to be =
checked if it is contained by the network</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return true if the host address is covered by the network with the=
 given</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *         ne=
twork mask by bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ipv6_net_contains_host(const str=
uct in6_addr *network, unsigned int bits, const struct in6_addr *host);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endi=
f /* ifndef ROUTE_H */</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail">change 11=
91</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief1495b52ea81cac35d78e40264=
372d3869423f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1191 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--yRTKN5+dC+E=--

