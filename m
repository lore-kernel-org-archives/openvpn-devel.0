From: "stipa (Code Review)" <gerrit@...515...>
Date: Fri, 14 Nov 2025 09:24:34 +0000
References: <gerrit.1763112271000.I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <110f635261b912acbd9e17138c6b65ac60ee8cd6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="/ymm99IFax4="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--/ymm99IFax4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1377?usp=3Demail

to review the following change.


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



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1377/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index aa1f858..d870d48 100644
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
+        if (BLEN(buf) < (int)min_ip_header)
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d
Gerrit-Change-Number: 1377
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--/ymm99IFax4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>stipa would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1377?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">recursive routing: fixes and clean-ups<br><=
br> - get rid of atoi() for getting the remote transport port.<br> It doesn=
&#39;t change, so no point to do in on every packet.<br> In addition, atoi(=
) breaks when we use service names as ports.<br><br> - ensure we correctly =
handle IPv4 headers with options<br><br> - directly use buf parameter in pl=
ace of c-&gt;c2.buf<br><br>GitHub: #902<br><br>Change-Id: I8a0a8029da02fc63=
adc918e8d98e9f676ff4ea0d<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&g=
t;<br>---<br>M src/openvpn/forward.c<br>1 file changed, 22 insertions(+), 1=
1 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/77/1377/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forw=
ard.c b/src/openvpn/forward.c</span><br><span>index aa1f858..d870d48 100644=
</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/open=
vpn/forward.c</span><br><span>@@ -1382,15 +1382,24 @@</span><br><span> </sp=
an><br><span>     struct openvpn_sockaddr *link_addr =3D &amp;c-&gt;c2.to_l=
ink_addr-&gt;dest;</span><br><span>     struct link_socket_info *lsi =3D ge=
t_link_socket_info(c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    uint16_t link_port =3D atoi(c-&gt;c2.link_sockets[0]-&gt;remote_port);=
</span><br><span> </span><br><span>     int ip_hdr_offset =3D 0;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int tun_ip_ver =3D get_tun_i=
p_ver(TUNNEL_TYPE(c-&gt;c1.tuntap), &amp;c-&gt;c2.buf, &amp;ip_hdr_offset);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int tun_ip_ver =
=3D get_tun_ip_ver(TUNNEL_TYPE(c-&gt;c1.tuntap), buf, &amp;ip_hdr_offset);<=
/span><br><span> </span><br><span>     if (tun_ip_ver =3D=3D 4)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /*=
 make sure we got whole IP header and TCP/UDP src/dst ports */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt; ((int)s=
izeof(struct openvpn_iphdr) + ip_hdr_offset + sizeof(uint16_t) * 2))</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Ensure we can s=
afely read the IPv4 header */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const int min_ip_header =3D ip_hdr_offset + sizeof(struct=
 openvpn_iphdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (BLEN(buf) &lt; (int)min_ip_header)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            return;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct =
openvpn_iphdr *pip =3D (struct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const int i=
p_hlen =3D OPENVPN_IPH_GET_LEN(pip-&gt;version_len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        /* Reject malformed or truncated =
headers */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (ip_hlen &lt; sizeof(struct openvpn_iphdr)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            || BLEN(buf) &lt; (int)(ip_hdr_offset =
+ ip_hlen + sizeof(uint16_t) * 2))</span><br><span>         {</span><br><sp=
an>             return;</span><br><span>         }</span><br><span>@@ -1401=
,8 +1410,6 @@</span><br><span>             return;</span><br><span>        =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       struct openvpn_iphdr *pip =3D (struct openvpn_iphdr *)(BPTR(buf) + i=
p_hdr_offset);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span>         /* skip if tun protocol doesn&#39;t match link protocol =
*/</span><br><span>         if ((lsi-&gt;proto =3D=3D PROTO_TCP &amp;&amp; =
pip-&gt;protocol !=3D OPENVPN_IPPROTO_TCP)</span><br><span>             || =
(lsi-&gt;proto =3D=3D PROTO_UDP &amp;&amp; pip-&gt;protocol !=3D OPENVPN_IP=
PROTO_UDP))</span><br><span>@@ -1410,9 +1417,10 @@</span><br><span>        =
     return;</span><br><span>         }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* drop packe=
ts with same dest addr and port as remote */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        uint8_t *l4_hdr =3D (uint8_t *)pip + sizeof(=
struct openvpn_iphdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        uint8_t *l4_hdr =3D (uint8_t *)pip + ip_hlen;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        uint16_t link_port =3D ntohs(link_addr-&gt;addr.i=
n4.sin_port);</span><br><span> </span><br><span>         /* TCP and UDP por=
ts are at the same place in the header, and other protocols</span><br><span=
>          * can not happen here due to the lsi-&gt;proto check above */</s=
pan><br><span>@@ -1420,7 +1428,7 @@</span><br><span>         uint16_t dst_p=
ort =3D ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t)));</span><br><span>  =
       if ((memcmp(&amp;link_addr-&gt;addr.in4.sin_addr.s_addr, &amp;pip-&g=
t;daddr, sizeof(pip-&gt;daddr)) =3D=3D 0) &amp;&amp; (link_port =3D=3D dst_=
port))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            c-&gt;c2.buf.len =3D 0;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            buf-&gt;len =3D 0;</span><br><span>=
 </span><br><span>             struct gc_arena gc =3D gc_new();</span><br><=
span>             msg(D_LOW, &quot;Recursive routing detected, packet dropp=
ed %s:%&quot; PRIu16 &quot; -&gt; %s&quot;,</span><br><span>@@ -1433,7 +144=
1,8 @@</span><br><span>     else if (tun_ip_ver =3D=3D 6)</span><br><span> =
    {</span><br><span>         /* make sure we got whole IPv6 header and TC=
P/UDP src/dst ports */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (BLEN(buf) &lt; ((int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_o=
ffset + sizeof(uint16_t) * 2))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        const int min_ipv6 =3D ip_hdr_offset + sizeof(struct ope=
nvpn_ipv6hdr) + sizeof(uint16_t) * 2;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        if (BLEN(buf) &lt; min_ipv6)</span><br><span>    =
     {</span><br><span>             return;</span><br><span>         }</spa=
n><br><span>@@ -1453,13 +1462,15 @@</span><br><span>             return;</s=
pan><br><span>         }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uint16_t link_port =3D ntohs(link_addr-&gt;a=
ddr.in6.sin6_port);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span>         /* drop packets with same dest addr and port as r=
emote */</span><br><span>         uint8_t *l4_hdr =3D (uint8_t *)pip6 + siz=
eof(struct openvpn_ipv6hdr);</span><br><span>         uint16_t src_port =3D=
 ntohs(*(uint16_t *)l4_hdr);</span><br><span>         uint16_t dst_port =3D=
 ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t)));</span><br><span>         =
if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&amp;link_addr-&gt;addr.in6.sin6_addr, &amp=
;pip6-&gt;daddr)) &amp;&amp; (link_port =3D=3D dst_port))</span><br><span> =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
c-&gt;c2.buf.len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            buf-&gt;len =3D 0;</span><br><span> </span><br><span>      =
       struct gc_arena gc =3D gc_new();</span><br><span>             msg(D_=
LOW, &quot;Recursive routing detected, packet dropped %s:%&quot; PRIu16 &qu=
ot; -&gt; %s&quot;,</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1377?usp=3Demail">change 1377<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1377?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a0a8029da02fc63adc918e8d98=
e9f676ff4ea0d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1377 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--/ymm99IFax4=--

