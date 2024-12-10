From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 10 Dec 2024 11:44:34 +0000
References: <gerrit.1733831072000.I74a9eec4954f3f9d208792b6b34357571f76ae4c@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <df8732f44bee2ab3bfdd408f6037d020795bd2d8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="dYMm88Tb4F0="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--dYMm88Tb4F0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail

to review the following change.


Change subject: forward: Fix potential unaligned access in drop_if_recursiv=
e_routing
......................................................................

forward: Fix potential unaligned access in drop_if_recursive_routing

ASAN error:
forward.c:1433:13: runtime error: member access within
misaligned address 0x51e00002f52e for type
'const struct in6_addr', which requires 4 byte alignment

Change-Id: I74a9eec4954f3f9d208792b6b34357571f76ae4c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/forward.c
1 file changed, 7 insertions(+), 8 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/27/827/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d50b24c..4ba7448 100644
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
@@ -1404,18 +1402,17 @@
             return;
         }

-        pip =3D (struct openvpn_iphdr *) (BPTR(buf) + ip_hdr_offset);
+        struct openvpn_iphdr pip;
+        memcpy(&pip, BPTR(buf) + ip_hdr_offset, sizeof(struct openvpn_iphd=
r));

         /* drop packets with same dest addr as gateway */
-        if (tun_sa.addr.in4.sin_addr.s_addr =3D=3D pip->daddr)
+        if (tun_sa.addr.in4.sin_addr.s_addr =3D=3D pip.daddr)
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
@@ -1428,9 +1425,11 @@
             return;
         }

+        struct openvpn_ipv6hdr pip6;
+        memcpy(&pip6, BPTR(buf) + ip_hdr_offset, sizeof(struct openvpn_ipv=
6hdr));
+
         /* drop packets with same dest addr as gateway */
-        pip6 =3D (struct openvpn_ipv6hdr *) (BPTR(buf) + ip_hdr_offset);
-        if (IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6->daddr))
+        if (IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6.daddr))
         {
             drop =3D true;
         }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I74a9eec4954f3f9d208792b6b34357571f76ae4c
Gerrit-Change-Number: 827
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--dYMm88Tb4F0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">forward: Fix potential unaligned access in drop_if_recursive_=
routing<br><br>ASAN error:<br>forward.c:1433:13: runtime error: member acce=
ss within<br>misaligned address 0x51e00002f52e for type<br>&#39;const struc=
t in6_addr&#39;, which requires 4 byte alignment<br><br>Change-Id: I74a9eec=
4954f3f9d208792b6b34357571f76ae4c<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>---<br>M src/openvpn/forward.c<br>1 file changed, 7 =
insertions(+), 8 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/27/827/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward=
.c b/src/openvpn/forward.c</span><br><span>index d50b24c..4ba7448 100644</s=
pan><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn=
/forward.c</span><br><span>@@ -1390,8 +1390,6 @@</span><br><span> </span><b=
r><span>     if (proto_ver =3D=3D 4)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        const struct openvpn_iphdr *p=
ip;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
        /* make sure we got whole IP header */</span><br><span>         if =
(BLEN(buf) &lt; ((int) sizeof(struct openvpn_iphdr) + ip_hdr_offset))</span=
><br><span>         {</span><br><span>@@ -1404,18 +1402,17 @@</span><br><sp=
an>             return;</span><br><span>         }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        pip =3D (struct open=
vpn_iphdr *) (BPTR(buf) + ip_hdr_offset);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct openvpn_iphdr pip;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;pip, BPTR(buf) + ip=
_hdr_offset, sizeof(struct openvpn_iphdr));</span><br><span> </span><br><sp=
an>         /* drop packets with same dest addr as gateway */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (tun_sa.addr.in4.sin_add=
r.s_addr =3D=3D pip-&gt;daddr)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (tun_sa.addr.in4.sin_addr.s_addr =3D=3D pip.daddr)</s=
pan><br><span>         {</span><br><span>             drop =3D true;</span>=
<br><span>         }</span><br><span>     }</span><br><span>     else if (p=
roto_ver =3D=3D 6)</span><br><span>     {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        const struct openvpn_ipv6hdr *pip6;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* make=
 sure we got whole IPv6 header */</span><br><span>         if (BLEN(buf) &l=
t; ((int) sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset))</span><br><span>=
         {</span><br><span>@@ -1428,9 +1425,11 @@</span><br><span>         =
    return;</span><br><span>         }</span><br><span> </span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        struct openvpn_ipv6hdr pip6;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        memcpy(&amp;p=
ip6, BPTR(buf) + ip_hdr_offset, sizeof(struct openvpn_ipv6hdr));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         /* d=
rop packets with same dest addr as gateway */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        pip6 =3D (struct openvpn_ipv6hdr *) (BPTR(b=
uf) + ip_hdr_offset);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        if (IN6_ARE_ADDR_EQUAL(&amp;tun_sa.addr.in6.sin6_addr, &amp;pip6-&g=
t;daddr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if=
 (IN6_ARE_ADDR_EQUAL(&amp;tun_sa.addr.in6.sin6_addr, &amp;pip6.daddr))</spa=
n><br><span>         {</span><br><span>             drop =3D true;</span><b=
r><span>         }</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/827?usp=3Demail">change 827</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/827?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I74a9eec4954f3f9d208792b6b34=
357571f76ae4c </div>
<div style=3D"display:none"> Gerrit-Change-Number: 827 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--dYMm88Tb4F0=--

