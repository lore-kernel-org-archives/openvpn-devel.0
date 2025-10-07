From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 16:41:28 +0000
In-Reply-To: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
References: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 antonio@...2726...
Message-ID: <8b1670bd5543374ac6d9777e63fab4a01601f831-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xhv2UPBocvk="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, d12fk <heiko@...515...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xhv2UPBocvk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Allow route_ipv6_match_host to be used outside of route.c
......................................................................

Allow route_ipv6_match_host to be used outside of route.c

Also adjust style a bit to C99

Change-Id: Ief1495b52ea81cac35d78e40264372d3869423f1
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1191
Message-Id: <20251007160826.4614-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243387/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/route.c
M src/openvpn/route.h
2 files changed, 23 insertions(+), 14 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1191/6

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index 05a0c8f..0044794 100644
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
+    /* not the most beautiful implementation in the world, but portable and
+     * "good enough" */
     if (bits > 128)
     {
         return false;
     }

+    int i;
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
index c5006ae..54fa137 100644
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
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ief1495b52ea81cac35d78e40264372d3869423f1
Gerrit-Change-Number: 1191
Gerrit-PatchSet: 6
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xhv2UPBocvk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Allow route_ipv6_match_host to be u=
sed outside of route.c<br><br>Also adjust style a bit to C99<br><br>Change-=
Id: Ief1495b52ea81cac35d78e40264372d3869423f1<br>Signed-off-by: Arne Schwab=
e &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;=
<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1191<br>Message-Id: =
&lt;20251007160826.4614-1-gert@...1296...&gt;<br>URL: https://sourceforge.n=
et/p/openvpn/mailman/message/59243387/<br>Signed-off-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>---<br>M src/openvpn/route.c<br>M src/openvpn/route.h=
<br>2 files changed, 23 insertions(+), 14 deletions(-)<br><br></pre><pre cl=
ass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1191=
/6</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/route.c b/src/openvpn/route.c</span><br=
><span>index 05a0c8f..0044794 100644</span><br><span>--- a/src/openvpn/rout=
e.c</span><br><span>+++ b/src/openvpn/route.c</span><br><span>@@ -710,25 +7=
10,20 @@</span><br><span>     return ret;</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* check whether a=
n IPv6 host address is covered by a given route_ipv6</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * (not the most beautiful implementation i=
n the world, but portable and</span><br><span style=3D"color: hsl(0, 100%, =
40%);">- * &quot;good enough&quot;)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stat=
ic bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-route_ipv6_mat=
ch_host(const struct route_ipv6 *r6, const struct in6_addr *host)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ipv6_net_contains_host(const struct in6_addr=
 *network, unsigned int bits, const struct in6_addr *host)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int bi=
ts =3D r6-&gt;netbits;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsign=
ed int mask;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* not the most beautifu=
l implementation in the world, but portable and</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+     * &quot;good enough&quot; */</span><br><sp=
an>     if (bits &gt; 128)</span><br><span>     {</span><br><span>         =
return false;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    int i;</span><br><span>     for (i =
=3D 0; bits &gt;=3D 8; i++, bits -=3D 8)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        if (r6-&gt;network.s6_add=
r[i] !=3D host-&gt;s6_addr[i])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (network-&gt;s6_addr[i] !=3D host-&gt;s6_addr[i])</sp=
an><br><span>         {</span><br><span>             return false;</span><b=
r><span>         }</span><br><span>@@ -739,9 +734,9 @@</span><br><span>    =
     return true;</span><br><span>     }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    mask =3D 0xff &lt;&lt; (8 - bits);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int ma=
sk =3D 0xff &lt;&lt; (8 - bits);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if ((r6-&gt;network.s6_addr[i] &amp; mask)=
 =3D=3D (host-&gt;s6_addr[i] &amp; mask))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if ((network-&gt;s6_addr[i] &amp; mask) =3D=3D (h=
ost-&gt;s6_addr[i] &amp; mask))</span><br><span>     {</span><br><span>    =
     return true;</span><br><span>     }</span><br><span>@@ -830,7 +825,8 @=
@</span><br><span>                  * avoiding routing loops, so ignore thi=
s part and let</span><br><span>                  * need_remote_ipv6_route a=
lways evaluate to false</span><br><span>                  */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                if (remote_host_ipv6=
 &amp;&amp; route_ipv6_match_host(r6, remote_host_ipv6))</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                if (remote_host_ipv6</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    &=
amp;&amp; ipv6_net_contains_host(&amp;r6-&gt;network, r6-&gt;netbits, remot=
e_host_ipv6))</span><br><span>                 {</span><br><span>          =
           need_remote_ipv6_route =3D true;</span><br><span>               =
      msg(D_ROUTE,</span><br><span>diff --git a/src/openvpn/route.h b/src/o=
penvpn/route.h</span><br><span>index c5006ae..54fa137 100644</span><br><spa=
n>--- a/src/openvpn/route.h</span><br><span>+++ b/src/openvpn/route.h</span=
><br><span>@@ -426,4 +426,17 @@</span><br><span>     return rl &amp;&amp; B=
OOL_CAST(rl-&gt;iflags &amp; RL_DID_REDIRECT_DEFAULT_GATEWAY);</span><br><s=
pan> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * check whether an IPv6 host =
address is covered by a given network/bits</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param network the network address</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param bits the network mask</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param host the hos=
t address to be checked if it is contained by the network</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * @return true if the host address is covered by the =
network with the given</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *         network mask by bits</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+b=
ool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ipv6_net_contain=
s_host(const struct in6_addr *network, unsigned int bits, const struct in6_=
addr *host);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span> #endif /* ifndef ROUTE_H */</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3D=
email">change 1191</a>. To unsubscribe, or for help writing mail filters, v=
isit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief1495b52ea81cac35d78e40264=
372d3869423f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1191 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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

</body></html>=

--xhv2UPBocvk=--

