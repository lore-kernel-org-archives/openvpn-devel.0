From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 27 Oct 2025 13:08:14 +0000
References: <gerrit.1761570487000.I501bf780957a9c685eed5994a15de09c28efc3f0@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4e245c6f4056f31fc902970d1b7807b6b951adee-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ngyEBY0AIfM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute: Remove
 unused mask argument of mroute_get_in*
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ngyEBY0AIfM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1309?usp=3Demail

to review the following change.


Change subject: mroute: Remove unused mask argument of mroute_get_in*
......................................................................

mroute: Remove unused mask argument of mroute_get_in*

These are obsolete since the removal of pf feature.
Avoids spurious conversion warnings.

Change-Id: I501bf780957a9c685eed5994a15de09c28efc3f0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/mroute.c
1 file changed, 9 insertions(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1309/1

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 88ea647..b50d48f 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -103,17 +103,12 @@
     return true;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static inline void
-mroute_get_in_addr_t(struct mroute_addr *ma, const in_addr_t src, unsigned=
 int mask)
+mroute_get_in_addr_t(struct mroute_addr *ma, const in_addr_t src)
 {
     if (ma)
     {
-        ma->type =3D MR_ADDR_IPV4 | mask;
+        ma->type =3D MR_ADDR_IPV4;
         ma->netbits =3D 0;
         ma->len =3D 4;
         ma->v4.addr =3D src;
@@ -121,11 +116,11 @@
 }

 static inline void
-mroute_get_in6_addr(struct mroute_addr *ma, const struct in6_addr src, uns=
igned int mask)
+mroute_get_in6_addr(struct mroute_addr *ma, const struct in6_addr src)
 {
     if (ma)
     {
-        ma->type =3D MR_ADDR_IPV6 | mask;
+        ma->type =3D MR_ADDR_IPV6;
         ma->netbits =3D 0;
         ma->len =3D 16;
         ma->v6.addr =3D src;
@@ -161,8 +156,8 @@
                 {
                     const struct openvpn_iphdr *ip =3D (const struct openv=
pn_iphdr *)BPTR(buf);

-                    mroute_get_in_addr_t(src, ip->saddr, 0);
-                    mroute_get_in_addr_t(dest, ip->daddr, 0);
+                    mroute_get_in_addr_t(src, ip->saddr);
+                    mroute_get_in_addr_t(dest, ip->daddr);

                     /* multicast packet? */
                     if (mroute_is_mcast(ip->daddr))
@@ -192,8 +187,8 @@
                     gc_free(&gc);
 #endif

-                    mroute_get_in6_addr(src, ipv6->saddr, 0);
-                    mroute_get_in6_addr(dest, ipv6->daddr, 0);
+                    mroute_get_in6_addr(src, ipv6->saddr);
+                    mroute_get_in6_addr(dest, ipv6->daddr);

                     if (mroute_is_mcast_ipv6(ipv6->daddr))
                     {
@@ -342,7 +337,7 @@
             }
             else
             {
-                ma->v6.addr.s6_addr[byte--] &=3D (IPV4_NETMASK_HOST << bit=
s_to_clear);
+                ma->v6.addr.s6_addr[byte--] &=3D (0xFF << bits_to_clear);
                 bits_to_clear =3D 0;
             }
         }
@@ -552,10 +547,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 mroute_helper_free(struct mroute_helper *mh)
 {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1309?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I501bf780957a9c685eed5994a15de09c28efc3f0
Gerrit-Change-Number: 1309
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ngyEBY0AIfM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1309?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">mroute: Remove unused mask argument of mrou=
te_get_in*<br><br>These are obsolete since the removal of pf feature.<br>Av=
oids spurious conversion warnings.<br><br>Change-Id: I501bf780957a9c685eed5=
994a15de09c28efc3f0<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>---<br>M src/openvpn/mroute.c<br>1 file changed, 9 insertions(+), =
18 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/09/1309/1</pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/mro=
ute.c b/src/openvpn/mroute.c</span><br><span>index 88ea647..b50d48f 100644<=
/span><br><span>--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/openvp=
n/mroute.c</span><br><span>@@ -103,17 +103,12 @@</span><br><span>     retur=
n true;</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic i=
gnored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> static inline void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-mroute_get_in_addr_t(struct mroute_addr *ma, const in_addr_t src,=
 unsigned int mask)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
mroute_get_in_addr_t(struct mroute_addr *ma, const in_addr_t src)</span><br=
><span> {</span><br><span>     if (ma)</span><br><span>     {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        ma-&gt;type =3D MR_ADDR_IPV=
4 | mask;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ma=
-&gt;type =3D MR_ADDR_IPV4;</span><br><span>         ma-&gt;netbits =3D 0;<=
/span><br><span>         ma-&gt;len =3D 4;</span><br><span>         ma-&gt;=
v4.addr =3D src;</span><br><span>@@ -121,11 +116,11 @@</span><br><span> }</=
span><br><span> </span><br><span> static inline void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-mroute_get_in6_addr(struct mroute_addr *ma,=
 const struct in6_addr src, unsigned int mask)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+mroute_get_in6_addr(struct mroute_addr *ma, cons=
t struct in6_addr src)</span><br><span> {</span><br><span>     if (ma)</spa=
n><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     ma-&gt;type =3D MR_ADDR_IPV6 | mask;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        ma-&gt;type =3D MR_ADDR_IPV6;</span><br><span=
>         ma-&gt;netbits =3D 0;</span><br><span>         ma-&gt;len =3D 16;=
</span><br><span>         ma-&gt;v6.addr =3D src;</span><br><span>@@ -161,8=
 +156,8 @@</span><br><span>                 {</span><br><span>             =
        const struct openvpn_iphdr *ip =3D (const struct openvpn_iphdr *)BP=
TR(buf);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                    mroute_get_in_addr_t(src, ip-&gt;saddr, 0);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    mroute_g=
et_in_addr_t(dest, ip-&gt;daddr, 0);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    mroute_get_in_addr_t(src, ip-&gt;saddr=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
   mroute_get_in_addr_t(dest, ip-&gt;daddr);</span><br><span> </span><br><s=
pan>                     /* multicast packet? */</span><br><span>          =
           if (mroute_is_mcast(ip-&gt;daddr))</span><br><span>@@ -192,8 +18=
7,8 @@</span><br><span>                     gc_free(&amp;gc);</span><br><sp=
an> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    mroute_get_in6_addr(src, ipv6-&gt;saddr, 0);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                    mrout=
e_get_in6_addr(dest, ipv6-&gt;daddr, 0);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                    mroute_get_in6_addr(src, ipv6-&gt;=
saddr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        mroute_get_in6_addr(dest, ipv6-&gt;daddr);</span><br><span> </span>=
<br><span>                     if (mroute_is_mcast_ipv6(ipv6-&gt;daddr))</s=
pan><br><span>                     {</span><br><span>@@ -342,7 +337,7 @@</s=
pan><br><span>             }</span><br><span>             else</span><br><s=
pan>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
             ma-&gt;v6.addr.s6_addr[byte--] &amp;=3D (IPV4_NETMASK_HOST &lt=
;&lt; bits_to_clear);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                ma-&gt;v6.addr.s6_addr[byte--] &amp;=3D (0xFF &lt;&lt; bi=
ts_to_clear);</span><br><span>                 bits_to_clear =3D 0;</span><=
br><span>             }</span><br><span>         }</span><br><span>@@ -552,=
10 +547,6 @@</span><br><span>     }</span><br><span> }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span> void</span><br><span> mroute_helper_free(struct mroute_helper *mh)</s=
pan><br><span> {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1309?usp=3Demail">change 1309</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1309?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I501bf780957a9c685eed5994a15=
de09c28efc3f0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1309 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--ngyEBY0AIfM=--

