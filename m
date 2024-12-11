From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 11 Dec 2024 16:57:20 +0000
In-Reply-To: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
References: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, gert@...1296...
Message-ID: <17ad0c77253e68010e584cb6bcf837f0f19bffa4-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="twlanEK2QkI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: forward: Fix
 potential unaligned access in drop_if_recursive_routing
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--twlanEK2QkI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, plaisthos.

Hello cron2, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail

to look at the new patch set (#3).


Change subject: forward: Fix potential unaligned access in drop_if_recursiv=
e_routing
......................................................................

forward: Fix potential unaligned access in drop_if_recursive_routing

ASAN error:
forward.c:1433:13: runtime error: member access within
misaligned address 0x51e00002f52e for type
'const struct in6_addr', which requires 4 byte alignment

v2: Use memcmp instead of memcpy

Change-Id: I74a9eec4954f3f9d208792b6b34357571f76ae4c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/forward.c
M src/openvpn/proto.h
2 files changed, 11 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/827/3

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d50b24c..2c72001 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1390,8 +1390,6 @@

     if (proto_ver =3D=3D 4)
     {
-        const struct openvpn_iphdr *pip;
-
         /* make sure we got whole IP header */
         if (BLEN(buf) < ((int) sizeof(struct openvpn_iphdr) + ip_hdr_offse=
t))
         {
@@ -1404,18 +1402,16 @@
             return;
         }

-        pip =3D (struct openvpn_iphdr *) (BPTR(buf) + ip_hdr_offset);
+        struct openvpn_iphdr *pip =3D (struct openvpn_iphdr *) (BPTR(buf) =
+ ip_hdr_offset);

         /* drop packets with same dest addr as gateway */
-        if (tun_sa.addr.in4.sin_addr.s_addr =3D=3D pip->daddr)
+        if (memcmp(&tun_sa.addr.in4.sin_addr.s_addr, &pip->daddr, sizeof(p=
ip->daddr)) =3D=3D 0)
         {
             drop =3D true;
         }
     }
     else if (proto_ver =3D=3D 6)
     {
-        const struct openvpn_ipv6hdr *pip6;
-
         /* make sure we got whole IPv6 header */
         if (BLEN(buf) < ((int) sizeof(struct openvpn_ipv6hdr) + ip_hdr_off=
set))
         {
@@ -1428,9 +1424,10 @@
             return;
         }

+        struct openvpn_ipv6hdr *pip6 =3D (struct openvpn_ipv6hdr *) (BPTR(=
buf) + ip_hdr_offset);
+
         /* drop packets with same dest addr as gateway */
-        pip6 =3D (struct openvpn_ipv6hdr *) (BPTR(buf) + ip_hdr_offset);
-        if (IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6->daddr))
+        if (OPENVPN_IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6->=
daddr))
         {
             drop =3D true;
         }
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 7b94fbc..ac70134 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -83,6 +83,12 @@
 #define SIZE_ETH_TO_8021Q_HDR (sizeof(struct openvpn_8021qhdr) \
                                - sizeof(struct openvpn_ethhdr))

+/** Version of IN6_ARE_ADDR_EQUAL that is guaranteed to work for
+    unaligned access. E.g. Linux uses 32bit compares which are
+    not safe if the struct is unaligned. */
+#define OPENVPN_IN6_ARE_ADDR_EQUAL(a, b) \
+    (memcmp(a, b, sizeof(struct in6_addr)) =3D=3D 0)
+
 struct openvpn_iphdr {
 #define OPENVPN_IPH_GET_VER(v) (((v) >> 4) & 0x0F)
 #define OPENVPN_IPH_GET_LEN(v) (((v) & 0x0F) << 2)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74a9eec4954f3f9d208792b6b34357571f76ae4c
Gerrit-Change-Number: 827
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-MessageType: newpatchset

--twlanEK2QkI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">forward: Fix potential unaligned access in drop_if_recursive_routi=
ng<br><br>ASAN error:<br>forward.c:1433:13: runtime error: member access wi=
thin<br>misaligned address 0x51e00002f52e for type<br>&#39;const struct in6=
_addr&#39;, which requires 4 byte alignment<br><br>v2: Use memcmp instead o=
f memcpy<br><br>Change-Id: I74a9eec4954f3f9d208792b6b34357571f76ae4c<br>Sig=
ned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/open=
vpn/forward.c<br>M src/openvpn/proto.h<br>2 files changed, 11 insertions(+)=
, 8 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/27/827/3</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/open=
vpn/forward.c</span><br><span>index d50b24c..2c72001 100644</span><br><span=
>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</s=
pan><br><span>@@ -1390,8 +1390,6 @@</span><br><span> </span><br><span>     =
if (proto_ver =3D=3D 4)</span><br><span>     {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        const struct openvpn_iphdr *pip;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* ma=
ke sure we got whole IP header */</span><br><span>         if (BLEN(buf) &l=
t; ((int) sizeof(struct openvpn_iphdr) + ip_hdr_offset))</span><br><span>  =
       {</span><br><span>@@ -1404,18 +1402,16 @@</span><br><span>          =
   return;</span><br><span>         }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        pip =3D (struct openvpn_iphdr *) =
(BPTR(buf) + ip_hdr_offset);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        struct openvpn_iphdr *pip =3D (struct openvpn_iphdr *) (BP=
TR(buf) + ip_hdr_offset);</span><br><span> </span><br><span>         /* dro=
p packets with same dest addr as gateway */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (tun_sa.addr.in4.sin_addr.s_addr =3D=3D pi=
p-&gt;daddr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (memcmp(&amp;tun_sa.addr.in4.sin_addr.s_addr, &amp;pip-&gt;daddr, sizeo=
f(pip-&gt;daddr)) =3D=3D 0)</span><br><span>         {</span><br><span>    =
         drop =3D true;</span><br><span>         }</span><br><span>     }</=
span><br><span>     else if (proto_ver =3D=3D 6)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        const struct open=
vpn_ipv6hdr *pip6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span>         /* make sure we got whole IPv6 header */</span><br><=
span>         if (BLEN(buf) &lt; ((int) sizeof(struct openvpn_ipv6hdr) + ip=
_hdr_offset))</span><br><span>         {</span><br><span>@@ -1428,9 +1424,1=
0 @@</span><br><span>             return;</span><br><span>         }</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct openvpn_ipv6hdr *pip6 =3D (struct openvpn_ipv6hdr *) (BPTR(buf) + ip=
_hdr_offset);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span>         /* drop packets with same dest addr as gateway */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        pip6 =3D (struct op=
envpn_ipv6hdr *) (BPTR(buf) + ip_hdr_offset);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (IN6_ARE_ADDR_EQUAL(&amp;tun_sa.addr.in6=
.sin6_addr, &amp;pip6-&gt;daddr))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if (OPENVPN_IN6_ARE_ADDR_EQUAL(&amp;tun_sa.addr.in6.s=
in6_addr, &amp;pip6-&gt;daddr))</span><br><span>         {</span><br><span>=
             drop =3D true;</span><br><span>         }</span><br><span>diff=
 --git a/src/openvpn/proto.h b/src/openvpn/proto.h</span><br><span>index 7b=
94fbc..ac70134 100644</span><br><span>--- a/src/openvpn/proto.h</span><br><=
span>+++ b/src/openvpn/proto.h</span><br><span>@@ -83,6 +83,12 @@</span><br=
><span> #define SIZE_ETH_TO_8021Q_HDR (sizeof(struct openvpn_8021qhdr) \</s=
pan><br><span>                                - sizeof(struct openvpn_ethhd=
r))</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/** Version of IN6_ARE_ADDR_EQUAL that is guaranteed to work for</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    unaligned access. E.g. L=
inux uses 32bit compares which are</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    not safe if the struct is unaligned. */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#define OPENVPN_IN6_ARE_ADDR_EQUAL(a=
, b) \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    (memcmp(a=
, b, sizeof(struct in6_addr)) =3D=3D 0)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> struct openvpn_iphdr {</span><br><spa=
n> #define OPENVPN_IPH_GET_VER(v) (((v) &gt;&gt; 4) &amp; 0x0F)</span><br><=
span> #define OPENVPN_IPH_GET_LEN(v) (((v) &amp; 0x0F) &lt;&lt; 2)</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/827?usp=3Demail">change 827</a>. To unsubscribe, or for he=
lp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setting=
s">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessa=
ge"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAc=
tion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
827?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></=
div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74a9eec4954f3f9d208792b6b34=
357571f76ae4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 827 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--twlanEK2QkI=--

