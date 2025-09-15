From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 15 Sep 2025 17:39:07 +0000
References: <gerrit.1757957943000.Ief1495b52ea81cac35d78e40264372d3869423f1@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <e91b746265ec1d7484988178db6118fc7df66614-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8K9RfWI7ovg="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8K9RfWI7ovg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail

to review the following change.


Change subject: Allow route_ipv6_match_host to be used outside of route.c
......................................................................

Allow route_ipv6_match_host to be used outside of route.c

Also adjust style a bit to C99

Change-Id: Ief1495b52ea81cac35d78e40264372d3869423f1
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M src/openvpn/route.c
M src/openvpn/route.h
2 files changed, 23 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/91/1191/1

diff --git a/src/openvpn/route.c b/src/openvpn/route.c
index e504485..8be3f65 100644
--- a/src/openvpn/route.c
+++ b/src/openvpn/route.c
@@ -710,25 +710,23 @@
     return ret;
 }

-/* check whether an IPv6 host address is covered by a given route_ipv6
+/**
+ * check whether an IPv6 host address is covered by a given route_ipv6
  * (not the most beautiful implementation in the world, but portable and
  * "good enough")
  */
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
@@ -739,9 +737,9 @@
         return true;
     }

-    mask =3D 0xff << (8 - bits);
+    unsigned mask =3D 0xff << (8 - bits);

-    if ((r6->network.s6_addr[i] & mask) =3D=3D (host->s6_addr[i] & mask))
+    if ((network->s6_addr[i] & mask) =3D=3D (host->s6_addr[i] & mask))
     {
         return true;
     }
@@ -830,7 +828,8 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--8K9RfWI7ovg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Allow route_ipv6_match_host to be used outside of route.c<br=
><br>Also adjust style a bit to C99<br><br>Change-Id: Ief1495b52ea81cac35d7=
8e40264372d3869423f1<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt;=
<br>---<br>M src/openvpn/route.c<br>M src/openvpn/route.h<br>2 files change=
d, 23 insertions(+), 11 deletions(-)<br><br></pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvp=
n.net:29418/openvpn refs/changes/91/1191/1</pre><pre style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn=
/route.c b/src/openvpn/route.c</span><br><span>index e504485..8be3f65 10064=
4</span><br><span>--- a/src/openvpn/route.c</span><br><span>+++ b/src/openv=
pn/route.c</span><br><span>@@ -710,25 +710,23 @@</span><br><span>     retur=
n ret;</span><br><span> }</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-/* check whether an IPv6 host address is covered by a=
 given route_ipv6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * check whether a=
n IPv6 host address is covered by a given route_ipv6</span><br><span>  * (n=
ot the most beautiful implementation in the world, but portable and</span><=
br><span>  * &quot;good enough&quot;)</span><br><span>  */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static bool</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-route_ipv6_match_host(const struct route_ipv6 *r=
6, const struct in6_addr *host)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+rou=
te_ipv6_match_host(const struct in6_addr *network, unsigned int bits, const=
 struct in6_addr *host)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    unsigned int bits =3D r6-&gt;netbits;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    unsigned int mask;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (bits &gt; 128)</=
span><br><span>     {</span><br><span>         return false;</span><br><spa=
n>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    int i =3D 0;</span><br><span>     for (i =3D 0; bits &gt;=3D 8; =
i++, bits -=3D 8)</span><br><span>     {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        if (r6-&gt;network.s6_addr[i] !=3D host-&gt;s6_a=
ddr[i])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (=
network-&gt;s6_addr[i] !=3D host-&gt;s6_addr[i])</span><br><span>         {=
</span><br><span>             return false;</span><br><span>         }</spa=
n><br><span>@@ -739,9 +737,9 @@</span><br><span>         return true;</span=
><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    mask =3D 0xff &lt;&lt; (8 - bits);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned mask =3D 0xff &lt;&lt; (8 - =
bits);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if ((r6-&gt;network.s6_addr[i] &amp; mask) =3D=3D (host-&gt;s6_addr[=
i] &amp; mask))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if ((network-&gt;s6_addr[i] &amp; mask) =3D=3D (host-&gt;s6_addr[i] &amp; m=
ask))</span><br><span>     {</span><br><span>         return true;</span><b=
r><span>     }</span><br><span>@@ -830,7 +828,8 @@</span><br><span>        =
          * avoiding routing loops, so ignore this part and let</span><br><=
span>                  * need_remote_ipv6_route always evaluate to false</s=
pan><br><span>                  */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                if (remote_host_ipv6 &amp;&amp; route_ipv6_mat=
ch_host(r6, remote_host_ipv6))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                if (remote_host_ipv6</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    &amp;&amp; route_ipv6_match=
_host(&amp;r6-&gt;network, r6-&gt;netbits, remote_host_ipv6))</span><br><sp=
an>                 {</span><br><span>                     need_remote_ipv6=
_route =3D true;</span><br><span>                     msg(D_ROUTE,</span><b=
r><span>diff --git a/src/openvpn/route.h b/src/openvpn/route.h</span><br><s=
pan>index 9b6a47e..54abe24 100644</span><br><span>--- a/src/openvpn/route.h=
</span><br><span>+++ b/src/openvpn/route.h</span><br><span>@@ -426,4 +426,1=
7 @@</span><br><span>     return rl &amp;&amp; BOOL_CAST(rl-&gt;iflags &amp=
; RL_DID_REDIRECT_DEFAULT_GATEWAY);</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * check whether an IPv6 host address is covered by a giv=
en route_ipv6</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @pa=
ram network the network address</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * @param bits the network mask</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ * @param host the host address to be checked if it=
 is contained by the network</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @retu=
rn true if the host address is covered by the network with the given</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *         network mask by=
 bits</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+route_ipv6_match_host(const struct in6_addr *=
network, unsigned int bits, const struct in6_addr *host);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /* ifndef RO=
UTE_H */</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1191?usp=3Demail">change 1191</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1191?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ief1495b52ea81cac35d78e40264=
372d3869423f1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1191 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--8K9RfWI7ovg=--

