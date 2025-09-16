From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 16 Sep 2025 14:35:42 +0000
In-Reply-To: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
References: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
Reply-To: arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <8a587c6c13fe6454dcec65c97705259e287a777f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="5/g3NlyiVbg="; charset=UTF-8
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

--5/g3NlyiVbg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: d12fk, flichtenheld.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail

to look at the new patch set (#3).


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1191/3

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index e504485..7eb7a1b 100644
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
+route_ipv6_match_host(const struct in6_addr *network, unsigned int bits, c=
onst struct in6_addr *host)
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
+                    && route_ipv6_match_host(&r6->network, r6->netbits, re=
mote_host_ipv6))
                 {
                     need_remote_ipv6_route =3D true;
                     msg(D_ROUTE,
diff --git a/src/openvpn/route.h b/src/openvpn/route.h
index 9b6a47e..54abe24 100644
--- a/src/openvpn/route.h
+++ b/src/openvpn/route.h
@@ -426,4 +426,17 @@
     return rl && BOOL_CAST(rl->iflags & RL_DID_REDIRECT_DEFAULT_GATEWAY);
 }

+
+/**
+ * check whether an IPv6 host address is covered by a given route_ipv6
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
+route_ipv6_match_host(const struct in6_addr *network, unsigned int bits, c=
onst struct in6_addr *host);
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
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: d12fk <heiko@...515...>
Gerrit-MessageType: newpatchset

--5/g3NlyiVbg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: d12fk, flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">Allow route_ipv6_match_host to be used outside of route.c<br><br>Als=
o adjust style a bit to C99<br><br>Change-Id: Ief1495b52ea81cac35d78e402643=
72d3869423f1<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;<br>---<=
br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>2 files changed, 23 in=
sertions(+), 14 deletions(-)<br><br></pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29=
418/openvpn refs/changes/91/1191/3</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/route.c=
 b/src/openvpn/route.c</span><br><span>index e504485..7eb7a1b 100644</span>=
<br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openvpn/route=
.c</span><br><span>@@ -710,25 +710,20 @@</span><br><span>     return ret;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/* check whether an IPv6 host address is covered by a given r=
oute_ipv6</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * (not the =
most beautiful implementation in the world, but portable and</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">- * &quot;good enough&quot;)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-route_ipv6_match_host(const struct route_ipv6 *r6, const s=
truct in6_addr *host)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+route_ipv6_ma=
tch_host(const struct in6_addr *network, unsigned int bits, const struct in=
6_addr *host)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    unsigned int bits =3D r6-&gt;netbits;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    unsigned int mask;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /* (not the most beautiful implementation in the world, but portable=
 and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * &quot;go=
od enough&quot;) */</span><br><span>     if (bits &gt; 128)</span><br><span=
>     {</span><br><span>         return false;</span><br><span>     }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 i =3D 0;</span><br><span>     for (i =3D 0; bits &gt;=3D 8; i++, bits -=3D=
 8)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (r6-&gt;network.s6_addr[i] !=3D host-&gt;s6_addr[i])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        if (network-&gt;s6=
_addr[i] !=3D host-&gt;s6_addr[i])</span><br><span>         {</span><br><sp=
an>             return false;</span><br><span>         }</span><br><span>@@=
 -739,9 +734,9 @@</span><br><span>         return true;</span><br><span>   =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    mask =3D 0xff &lt;&lt; (8 - bits);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    unsigned int mask =3D 0xff &lt;&lt; (8 - bits);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
(r6-&gt;network.s6_addr[i] &amp; mask) =3D=3D (host-&gt;s6_addr[i] &amp; ma=
sk))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if ((networ=
k-&gt;s6_addr[i] &amp; mask) =3D=3D (host-&gt;s6_addr[i] &amp; mask))</span=
><br><span>     {</span><br><span>         return true;</span><br><span>   =
  }</span><br><span>@@ -830,7 +825,8 @@</span><br><span>                  *=
 avoiding routing loops, so ignore this part and let</span><br><span>      =
            * need_remote_ipv6_route always evaluate to false</span><br><sp=
an>                  */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                if (remote_host_ipv6 &amp;&amp; route_ipv6_match_host(r6,=
 remote_host_ipv6))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                if (remote_host_ipv6</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    &amp;&amp; route_ipv6_match_host(&amp;=
r6-&gt;network, r6-&gt;netbits, remote_host_ipv6))</span><br><span>        =
         {</span><br><span>                     need_remote_ipv6_route =3D =
true;</span><br><span>                     msg(D_ROUTE,</span><br><span>dif=
f --git a/src/openvpn/route.h b/src/openvpn/route.h</span><br><span>index 9=
b6a47e..54abe24 100644</span><br><span>--- a/src/openvpn/route.h</span><br>=
<span>+++ b/src/openvpn/route.h</span><br><span>@@ -426,4 +426,17 @@</span>=
<br><span>     return rl &amp;&amp; BOOL_CAST(rl-&gt;iflags &amp; RL_DID_RE=
DIRECT_DEFAULT_GATEWAY);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * check whether an IPv6 host address is covered by a given route_ip=
v6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param network=
 the network address</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param bits the network mask</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * @param host the host address to be checked if it is contain=
ed by the network</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if =
the host address is covered by the network with the given</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *         network mask by bits</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+route_ipv6_match_host(const struct in6_addr *network, un=
signed int bits, const struct in6_addr *host);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef ROUTE_H */</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1191?usp=3Demail">change 1191</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1191?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief1495b52ea81cac35d78e40264=
372d3869423f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1191 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: d12fk &lt;heiko@...515...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: d12fk &lt;heiko@...515...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--5/g3NlyiVbg=--

