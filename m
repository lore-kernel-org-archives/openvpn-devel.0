From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 11 Dec 2024 18:44:13 +0000
In-Reply-To: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
References: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d9c2ac527cfc6b77c1713c671c9bee3330c27545-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="doo7qV0dvFo="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--doo7qV0dvFo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: forward: Fix potential unaligned access in drop_if_recursiv=
e_routing
......................................................................

forward: Fix potential unaligned access in drop_if_recursive_routing

ASAN error:
   forward.c:1433:13: runtime error: member access within misaligned
   address 0x51e00002f52e for type 'const struct in6_addr', which
   requires 4 byte alignment

replace IN6_ARE_ADDR_EQUAL() which uses 32bit compares on Linux - alignment
sensitive - with our own OPENVPN_IN6_ARE_ADDR_EQUAL() macro, which always
does memcpy() and does not care for alignment.

v2: Use memcmp instead of memcpy

Change-Id: I74a9eec4954f3f9d208792b6b34357571f76ae4c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241211171349.8892-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
074.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
M src/openvpn/proto.h
2 files changed, 11 insertions(+), 8 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/827/4

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
=20
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
index 7b94fbc..0ffeaef 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -83,6 +83,12 @@
 #define SIZE_ETH_TO_8021Q_HDR (sizeof(struct openvpn_8021qhdr) \
                                - sizeof(struct openvpn_ethhdr))

+/** Version of IN6_ARE_ADDR_EQUAL that is guaranteed to work for
+ *  unaligned access. E.g. Linux uses 32bit compares which are
+ *  not safe if the struct is unaligned. */
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
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--doo7qV0dvFo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/827?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">forward: Fix potential unaligned access in drop_if_r=
ecursive_routing<br><br>ASAN error:<br>   forward.c:1433:13: runtime error:=
 member access within misaligned<br>   address 0x51e00002f52e for type &#39=
;const struct in6_addr&#39;, which<br>   requires 4 byte alignment<br><br>r=
eplace IN6_ARE_ADDR_EQUAL() which uses 32bit compares on Linux - alignment<=
br>sensitive - with our own OPENVPN_IN6_ARE_ADDR_EQUAL() macro, which alway=
s<br>does memcpy() and does not care for alignment.<br><br>v2: Use memcmp i=
nstead of memcpy<br><br>Change-Id: I74a9eec4954f3f9d208792b6b34357571f76ae4=
c<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;20241211171349.889=
2-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg30074.html<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/proto.h<=
br>2 files changed, 11 insertions(+), 8 deletions(-)<br><br></pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh=
://gerrit.openvpn.net:29418/openvpn refs/changes/27/827/4</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index d=
50b24c..2c72001 100644</span><br><span>--- a/src/openvpn/forward.c</span><b=
r><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1390,8 +1390,6 @@</=
span><br><span> </span><br><span>     if (proto_ver =3D=3D 4)</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cons=
t struct openvpn_iphdr *pip;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span>         /* make sure we got whole IP header */</sp=
an><br><span>         if (BLEN(buf) &lt; ((int) sizeof(struct openvpn_iphdr=
) + ip_hdr_offset))</span><br><span>         {</span><br><span>@@ -1404,18 =
+1402,16 @@</span><br><span>             return;</span><br><span>         }=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     pip =3D (struct openvpn_iphdr *) (BPTR(buf) + ip_hdr_offset);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        struct openvpn_iphdr=
 *pip =3D (struct openvpn_iphdr *) (BPTR(buf) + ip_hdr_offset);</span><br><=
span> </span><br><span>         /* drop packets with same dest addr as gate=
way */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (tun=
_sa.addr.in4.sin_addr.s_addr =3D=3D pip-&gt;daddr)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        if (memcmp(&amp;tun_sa.addr.in4.sin_=
addr.s_addr, &amp;pip-&gt;daddr, sizeof(pip-&gt;daddr)) =3D=3D 0)</span><br=
><span>         {</span><br><span>             drop =3D true;</span><br><sp=
an>         }</span><br><span>     }</span><br><span>     else if (proto_ve=
r =3D=3D 6)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        const struct openvpn_ipv6hdr *pip6;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* make sure w=
e got whole IPv6 header */</span><br><span>         if (BLEN(buf) &lt; ((in=
t) sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset))</span><br><span>       =
  {</span><br><span>@@ -1428,9 +1424,10 @@</span><br><span>             ret=
urn;</span><br><span>         }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        struct openvpn_ipv6hdr *pip6 =3D (str=
uct openvpn_ipv6hdr *) (BPTR(buf) + ip_hdr_offset);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         /* drop packets=
 with same dest addr as gateway */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        pip6 =3D (struct openvpn_ipv6hdr *) (BPTR(buf) + ip_hd=
r_offset);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if =
(IN6_ARE_ADDR_EQUAL(&amp;tun_sa.addr.in6.sin6_addr, &amp;pip6-&gt;daddr))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (OPENVPN_I=
N6_ARE_ADDR_EQUAL(&amp;tun_sa.addr.in6.sin6_addr, &amp;pip6-&gt;daddr))</sp=
an><br><span>         {</span><br><span>             drop =3D true;</span><=
br><span>         }</span><br><span>diff --git a/src/openvpn/proto.h b/src/=
openvpn/proto.h</span><br><span>index 7b94fbc..0ffeaef 100644</span><br><sp=
an>--- a/src/openvpn/proto.h</span><br><span>+++ b/src/openvpn/proto.h</spa=
n><br><span>@@ -83,6 +83,12 @@</span><br><span> #define SIZE_ETH_TO_8021Q_H=
DR (sizeof(struct openvpn_8021qhdr) \</span><br><span>                     =
           - sizeof(struct openvpn_ethhdr))</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/** Version of IN6_ARE_ADDR_EQUAL=
 that is guaranteed to work for</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  unaligned access. E.g. Linux uses 32bit compares which are<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  not safe if the =
struct is unaligned. */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#define OPENVPN_IN6_ARE_ADDR_EQUAL(a, b) \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    (memcmp(a, b, sizeof(struct in6_addr)) =3D=
=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> struct openvpn_iphdr {</span><br><span> #define OPENVPN_IPH_GET_VER(v)=
 (((v) &gt;&gt; 4) &amp; 0x0F)</span><br><span> #define OPENVPN_IPH_GET_LEN=
(v) (((v) &amp; 0x0F) &lt;&lt; 2)</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail"=
>change 827</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74a9eec4954f3f9d208792b6b34=
357571f76ae4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 827 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--doo7qV0dvFo=--

