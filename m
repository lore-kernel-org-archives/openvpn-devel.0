From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 14 Nov 2025 11:34:02 +0000
In-Reply-To: <gerrit.1763112271000.I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d@...2715...>
References: <gerrit.1763112271000.I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <5a81b0430bd5d637957e51c2ab1cc39c0db627a0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yr2+vdv4g7Q="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: recursive routing:
 fixes and clean-ups
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

--yr2+vdv4g7Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos, stipa.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1377?usp=3Demail

to look at the new patch set (#2).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: recursive routing: fixes and clean-ups
......................................................................

recursive routing: fixes and clean-ups

 - get rid of atoi() for getting the remote transport port.
 It doesn't change, so no point to do in on every packet.
 In addition, atoi() breaks when we use service names as ports.

 - ensure we correctly handle IPv4 headers with options

 - directly use buf parameter in place of c->c2.buf

GitHub: #902

Change-Id: I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d
Signed-off-by: Lev Stipakov <lev@...515...>
---
M src/openvpn/forward.c
1 file changed, 22 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1377/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index aa1f858..90e52d2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1382,15 +1382,24 @@

     struct openvpn_sockaddr *link_addr =3D &c->c2.to_link_addr->dest;
     struct link_socket_info *lsi =3D get_link_socket_info(c);
-    uint16_t link_port =3D atoi(c->c2.link_sockets[0]->remote_port);

     int ip_hdr_offset =3D 0;
-    int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), &c->c2.bu=
f, &ip_hdr_offset);
+    int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), buf, &ip_=
hdr_offset);

     if (tun_ip_ver =3D=3D 4)
     {
-        /* make sure we got whole IP header and TCP/UDP src/dst ports */
-        if (BLEN(buf) < ((int)sizeof(struct openvpn_iphdr) + ip_hdr_offset=
 + sizeof(uint16_t) * 2))
+        /* Ensure we can safely read the IPv4 header */
+        const int min_ip_header =3D ip_hdr_offset + sizeof(struct openvpn_=
iphdr);
+        if (BLEN(buf) < min_ip_header)
+        {
+            return;
+        }
+
+        struct openvpn_iphdr *pip =3D (struct openvpn_iphdr *)(BPTR(buf) +=
 ip_hdr_offset);
+        const int ip_hlen =3D OPENVPN_IPH_GET_LEN(pip->version_len);
+        /* Reject malformed or truncated headers */
+        if (ip_hlen < sizeof(struct openvpn_iphdr)
+            || BLEN(buf) < (int)(ip_hdr_offset + ip_hlen + sizeof(uint16_t=
) * 2))
         {
             return;
         }
@@ -1401,8 +1410,6 @@
             return;
         }

-        struct openvpn_iphdr *pip =3D (struct openvpn_iphdr *)(BPTR(buf) +=
 ip_hdr_offset);
-
         /* skip if tun protocol doesn't match link protocol */
         if ((lsi->proto =3D=3D PROTO_TCP && pip->protocol !=3D OPENVPN_IPP=
ROTO_TCP)
             || (lsi->proto =3D=3D PROTO_UDP && pip->protocol !=3D OPENVPN_=
IPPROTO_UDP))
@@ -1410,9 +1417,10 @@
             return;
         }

-
         /* drop packets with same dest addr and port as remote */
-        uint8_t *l4_hdr =3D (uint8_t *)pip + sizeof(struct openvpn_iphdr);
+        uint8_t *l4_hdr =3D (uint8_t *)pip + ip_hlen;
+
+        uint16_t link_port =3D ntohs(link_addr->addr.in4.sin_port);

         /* TCP and UDP ports are at the same place in the header, and othe=
r protocols
          * can not happen here due to the lsi->proto check above */
@@ -1420,7 +1428,7 @@
         uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t=
)));
         if ((memcmp(&link_addr->addr.in4.sin_addr.s_addr, &pip->daddr, siz=
eof(pip->daddr)) =3D=3D 0) && (link_port =3D=3D dst_port))
         {
-            c->c2.buf.len =3D 0;
+            buf->len =3D 0;

             struct gc_arena gc =3D gc_new();
             msg(D_LOW, "Recursive routing detected, packet dropped %s:%" P=
RIu16 " -> %s",
@@ -1433,7 +1441,8 @@
     else if (tun_ip_ver =3D=3D 6)
     {
         /* make sure we got whole IPv6 header and TCP/UDP src/dst ports */
-        if (BLEN(buf) < ((int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_offs=
et + sizeof(uint16_t) * 2))
+        const int min_ipv6 =3D ip_hdr_offset + sizeof(struct openvpn_ipv6h=
dr) + sizeof(uint16_t) * 2;
+        if (BLEN(buf) < min_ipv6)
         {
             return;
         }
@@ -1453,13 +1462,15 @@
             return;
         }

+        uint16_t link_port =3D ntohs(link_addr->addr.in6.sin6_port);
+
         /* drop packets with same dest addr and port as remote */
         uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct openvpn_ipv6hd=
r);
         uint16_t src_port =3D ntohs(*(uint16_t *)l4_hdr);
         uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t=
)));
         if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&link_addr->addr.in6.sin6_addr, &p=
ip6->daddr)) && (link_port =3D=3D dst_port))
         {
-            c->c2.buf.len =3D 0;
+            buf->len =3D 0;

             struct gc_arena gc =3D gc_new();
             msg(D_LOW, "Recursive routing detected, packet dropped %s:%" P=
RIu16 " -> %s",

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1377?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d
Gerrit-Change-Number: 1377
Gerrit-PatchSet: 2
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: stipa <lstipakov@...277...>

--yr2+vdv4g7Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos, stipa. </p>
<p>stipa <strong>uploaded patch set #2</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1377?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre class=3D=
"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>recursive routing: fixes and clean-ups<br><br> - get rid of atoi() for get=
ting the remote transport port.<br> It doesn&#39;t change, so no point to d=
o in on every packet.<br> In addition, atoi() breaks when we use service na=
mes as ports.<br><br> - ensure we correctly handle IPv4 headers with option=
s<br><br> - directly use buf parameter in place of c-&gt;c2.buf<br><br>GitH=
ub: #902<br><br>Change-Id: I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d<br>Sig=
ned-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvpn/forw=
ard.c<br>1 file changed, 22 insertions(+), 11 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/=
1377/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</=
span><br><span>index aa1f858..90e52d2 100644</span><br><span>--- a/src/open=
vpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@=
@ -1382,15 +1382,24 @@</span><br><span> </span><br><span>     struct openvp=
n_sockaddr *link_addr =3D &amp;c-&gt;c2.to_link_addr-&gt;dest;</span><br><s=
pan>     struct link_socket_info *lsi =3D get_link_socket_info(c);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    uint16_t link_port =3D ato=
i(c-&gt;c2.link_sockets[0]-&gt;remote_port);</span><br><span> </span><br><s=
pan>     int ip_hdr_offset =3D 0;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c-&gt;c1.tunt=
ap), &amp;c-&gt;c2.buf, &amp;ip_hdr_offset);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(=
c-&gt;c1.tuntap), buf, &amp;ip_hdr_offset);</span><br><span> </span><br><sp=
an>     if (tun_ip_ver =3D=3D 4)</span><br><span>     {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-        /* make sure we got whole IP head=
er and TCP/UDP src/dst ports */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (BLEN(buf) &lt; ((int)sizeof(struct openvpn_iphdr) + i=
p_hdr_offset + sizeof(uint16_t) * 2))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        /* Ensure we can safely read the IPv4 header */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const int min=
_ip_header =3D ip_hdr_offset + sizeof(struct openvpn_iphdr);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (BLEN(buf) &lt; min_ip_=
header)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            return;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        struct openvpn_iphdr *pip =3D (struct openv=
pn_iphdr *)(BPTR(buf) + ip_hdr_offset);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        const int ip_hlen =3D OPENVPN_IPH_GET_LEN(pip-&=
gt;version_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     /* Reject malformed or truncated headers */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        if (ip_hlen &lt; sizeof(struct openvpn=
_iphdr)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
|| BLEN(buf) &lt; (int)(ip_hdr_offset + ip_hlen + sizeof(uint16_t) * 2))</s=
pan><br><span>         {</span><br><span>             return;</span><br><sp=
an>         }</span><br><span>@@ -1401,8 +1410,6 @@</span><br><span>       =
      return;</span><br><span>         }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        struct openvpn_iphdr *pip =3D =
(struct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* skip if tun pr=
otocol doesn&#39;t match link protocol */</span><br><span>         if ((lsi=
-&gt;proto =3D=3D PROTO_TCP &amp;&amp; pip-&gt;protocol !=3D OPENVPN_IPPROT=
O_TCP)</span><br><span>             || (lsi-&gt;proto =3D=3D PROTO_UDP &amp=
;&amp; pip-&gt;protocol !=3D OPENVPN_IPPROTO_UDP))</span><br><span>@@ -1410=
,9 +1417,10 @@</span><br><span>             return;</span><br><span>       =
  }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span>         /* drop packets with same dest addr and port as r=
emote */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        uint8=
_t *l4_hdr =3D (uint8_t *)pip + sizeof(struct openvpn_iphdr);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        uint8_t *l4_hdr =3D (uint=
8_t *)pip + ip_hlen;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint16_t l=
ink_port =3D ntohs(link_addr-&gt;addr.in4.sin_port);</span><br><span> </spa=
n><br><span>         /* TCP and UDP ports are at the same place in the head=
er, and other protocols</span><br><span>          * can not happen here due=
 to the lsi-&gt;proto check above */</span><br><span>@@ -1420,7 +1428,7 @@<=
/span><br><span>         uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr +=
 sizeof(uint16_t)));</span><br><span>         if ((memcmp(&amp;link_addr-&g=
t;addr.in4.sin_addr.s_addr, &amp;pip-&gt;daddr, sizeof(pip-&gt;daddr)) =3D=
=3D 0) &amp;&amp; (link_port =3D=3D dst_port))</span><br><span>         {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2.bu=
f.len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     buf-&gt;len =3D 0;</span><br><span> </span><br><span>             stru=
ct gc_arena gc =3D gc_new();</span><br><span>             msg(D_LOW, &quot;=
Recursive routing detected, packet dropped %s:%&quot; PRIu16 &quot; -&gt; %=
s&quot;,</span><br><span>@@ -1433,7 +1441,8 @@</span><br><span>     else if=
 (tun_ip_ver =3D=3D 6)</span><br><span>     {</span><br><span>         /* m=
ake sure we got whole IPv6 header and TCP/UDP src/dst ports */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt; ((int)s=
izeof(struct openvpn_ipv6hdr) + ip_hdr_offset + sizeof(uint16_t) * 2))</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        const int min_ip=
v6 =3D ip_hdr_offset + sizeof(struct openvpn_ipv6hdr) + sizeof(uint16_t) * =
2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (BLEN(=
buf) &lt; min_ipv6)</span><br><span>         {</span><br><span>            =
 return;</span><br><span>         }</span><br><span>@@ -1453,13 +1462,15 @@=
</span><br><span>             return;</span><br><span>         }</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint=
16_t link_port =3D ntohs(link_addr-&gt;addr.in6.sin6_port);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>         /* drop p=
ackets with same dest addr and port as remote */</span><br><span>         u=
int8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct openvpn_ipv6hdr);</span>=
<br><span>         uint16_t src_port =3D ntohs(*(uint16_t *)l4_hdr);</span>=
<br><span>         uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeo=
f(uint16_t)));</span><br><span>         if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&am=
p;link_addr-&gt;addr.in6.sin6_addr, &amp;pip6-&gt;daddr)) &amp;&amp; (link_=
port =3D=3D dst_port))</span><br><span>         {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            c-&gt;c2.buf.len =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            buf-&gt;len =3D 0;<=
/span><br><span> </span><br><span>             struct gc_arena gc =3D gc_ne=
w();</span><br><span>             msg(D_LOW, &quot;Recursive routing detect=
ed, packet dropped %s:%&quot; PRIu16 &quot; -&gt; %s&quot;,</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1377?usp=3Demail">change 1377</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1377?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a0a8029da02fc63adc918e8d98=
e9f676ff4ea0d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1377 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
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
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>

</body></html>=

--yr2+vdv4g7Q=--

