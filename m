From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 28 Oct 2025 12:33:44 +0000
In-Reply-To: <gerrit.1761570487000.I501bf780957a9c685eed5994a15de09c28efc3f0@...2715...>
References: <gerrit.1761570487000.I501bf780957a9c685eed5994a15de09c28efc3f0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <79b9bc09f6194c8dac8159807b430fffab9f2f4e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="MzZ6GgWX+fg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MzZ6GgWX+fg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1309?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: mroute: Remove unused mask argument of mroute_get_in*
......................................................................

mroute: Remove unused mask argument of mroute_get_in*

These are obsolete since the removal of pf feature.
Avoids spurious conversion warnings.

Change-Id: I501bf780957a9c685eed5994a15de09c28efc3f0
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1309
Message-Id: <20251028122028.24628-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
939.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mroute.c
1 file changed, 9 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1309/3

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I501bf780957a9c685eed5994a15de09c28efc3f0
Gerrit-Change-Number: 1309
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--MzZ6GgWX+fg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1309?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">mroute: Remove unused mask argument=
 of mroute_get_in*<br><br>These are obsolete since the removal of pf featur=
e.<br>Avoids spurious conversion warnings.<br><br>Change-Id: I501bf780957a9=
c685eed5994a15de09c28efc3f0<br>Signed-off-by: Frank Lichtenheld &lt;frank@...220...=
..2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit U=
RL: https://gerrit.openvpn.net/c/openvpn/+/1309<br>Message-Id: &lt;20251028=
122028.24628-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/ope=
nvpn-devel@lists.sourceforge.net/msg33939.html<br>Signed-off-by: Gert Doeri=
ng &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/mroute.c<br>1 file chang=
ed, 9 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/09/1309/3</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>index 88e=
a647..b50d48f 100644</span><br><span>--- a/src/openvpn/mroute.c</span><br><=
span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -103,17 +103,12 @@</span=
><br><span>     return true;</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || define=
d(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma G=
CC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> static inline void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-mroute_get_in_addr_t(struct mroute_addr *ma=
, const in_addr_t src, unsigned int mask)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+mroute_get_in_addr_t(struct mroute_addr *ma, const in=
_addr_t src)</span><br><span> {</span><br><span>     if (ma)</span><br><spa=
n>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ma-&g=
t;type =3D MR_ADDR_IPV4 | mask;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        ma-&gt;type =3D MR_ADDR_IPV4;</span><br><span>         =
ma-&gt;netbits =3D 0;</span><br><span>         ma-&gt;len =3D 4;</span><br>=
<span>         ma-&gt;v4.addr =3D src;</span><br><span>@@ -121,11 +116,11 @=
@</span><br><span> }</span><br><span> </span><br><span> static inline void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-mroute_get_in6_addr(st=
ruct mroute_addr *ma, const struct in6_addr src, unsigned int mask)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+mroute_get_in6_addr(struct =
mroute_addr *ma, const struct in6_addr src)</span><br><span> {</span><br><s=
pan>     if (ma)</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        ma-&gt;type =3D MR_ADDR_IPV6 | mask;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        ma-&gt;type =3D MR_ADDR_=
IPV6;</span><br><span>         ma-&gt;netbits =3D 0;</span><br><span>      =
   ma-&gt;len =3D 16;</span><br><span>         ma-&gt;v6.addr =3D src;</spa=
n><br><span>@@ -161,8 +156,8 @@</span><br><span>                 {</span><b=
r><span>                     const struct openvpn_iphdr *ip =3D (const stru=
ct openvpn_iphdr *)BPTR(buf);</span><br><span> </span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                    mroute_get_in_addr_t(src, ip-=
&gt;saddr, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
             mroute_get_in_addr_t(dest, ip-&gt;daddr, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                    mroute_get_in_add=
r_t(src, ip-&gt;saddr);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                    mroute_get_in_addr_t(dest, ip-&gt;daddr);</span><br=
><span> </span><br><span>                     /* multicast packet? */</span=
><br><span>                     if (mroute_is_mcast(ip-&gt;daddr))</span><b=
r><span>@@ -192,8 +187,8 @@</span><br><span>                     gc_free(&a=
mp;gc);</span><br><span> #endif</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    mroute_get_in6_addr(src, ip=
v6-&gt;saddr, 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                mroute_get_in6_addr(dest, ipv6-&gt;daddr, 0);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    mroute_get_in=
6_addr(src, ipv6-&gt;saddr);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                    mroute_get_in6_addr(dest, ipv6-&gt;daddr);</sp=
an><br><span> </span><br><span>                     if (mroute_is_mcast_ipv=
6(ipv6-&gt;daddr))</span><br><span>                     {</span><br><span>@=
@ -342,7 +337,7 @@</span><br><span>             }</span><br><span>         =
    else</span><br><span>             {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                ma-&gt;v6.addr.s6_addr[byte--] &amp;=3D (=
IPV4_NETMASK_HOST &lt;&lt; bits_to_clear);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                ma-&gt;v6.addr.s6_addr[byte--] &amp;=
=3D (0xFF &lt;&lt; bits_to_clear);</span><br><span>                 bits_to=
_clear =3D 0;</span><br><span>             }</span><br><span>         }</sp=
an><br><span>@@ -552,10 +547,6 @@</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if=
 defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> void</span><br><span> mroute_helper_free(struct =
mroute_helper *mh)</span><br><span> {</span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1309?usp=3De=
mail">change 1309</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1309?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I501bf780957a9c685eed5994a15=
de09c28efc3f0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1309 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--MzZ6GgWX+fg=--

