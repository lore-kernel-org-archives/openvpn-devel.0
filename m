From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 11 Oct 2025 12:51:14 +0000
In-Reply-To: <gerrit.1741271846000.I6841e2f2a85275254a04e2d8ae3defe4420db8f6@...2715...>
References: <gerrit.1741271846000.I6841e2f2a85275254a04e2d8ae3defe4420db8f6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <85c8def9355a028b14d79b890271a10bd8b46dfe-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AgGkH7Mdl1s="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Make recursive
 routing check more fine-grained
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AgGkH7Mdl1s=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/903?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Make recursive routing check more fine-grained
......................................................................

Make recursive routing check more fine-grained

The existing recursive routing check drops TUN packets
if their address matches the remote. While this works in
most cases, a more fine-grained check is preferable for
complex routing rules.

Since we only need to drop traffic originating from OpenVPN,
all of the following values must match between the packet
and the link:

 - IP protocol
 - Transport protocol (TCP/UDP)
 - Destination address
 - Destination port

GitHub: #699

Change-Id: I6841e2f2a85275254a04e2d8ae3defe4420db8f6
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/903
Message-Id: <20251011114448.14501-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59245301/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
1 file changed, 55 insertions(+), 29 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/903/5

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f342958..79a6fc7 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1391,73 +1391,99 @@
 static void
 drop_if_recursive_routing(struct context *c, struct buffer *buf)
 {
-    bool drop =3D false;
-    struct openvpn_sockaddr tun_sa;
-    int ip_hdr_offset =3D 0;
-
     if (c->c2.to_link_addr =3D=3D NULL) /* no remote addr known */
     {
         return;
     }

-    tun_sa =3D c->c2.to_link_addr->dest;
+    struct openvpn_sockaddr *link_addr =3D &c->c2.to_link_addr->dest;
+    struct link_socket_info *lsi =3D get_link_socket_info(c);
+    uint16_t link_port =3D atoi(c->c2.link_sockets[0]->remote_port);

-    int proto_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), &c->c2.buf=
, &ip_hdr_offset);
+    int ip_hdr_offset =3D 0;
+    int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), &c->c2.bu=
f, &ip_hdr_offset);

-    if (proto_ver =3D=3D 4)
+    if (tun_ip_ver =3D=3D 4)
     {
-        /* make sure we got whole IP header */
-        if (BLEN(buf) < ((int)sizeof(struct openvpn_iphdr) + ip_hdr_offset=
))
+        /* make sure we got whole IP header and TCP/UDP src/dst ports */
+        if (BLEN(buf) < ((int)sizeof(struct openvpn_iphdr) + ip_hdr_offset=
 + sizeof(uint16_t) * 2))
         {
             return;
         }

         /* skip ipv4 packets for ipv6 tun */
-        if (tun_sa.addr.sa.sa_family !=3D AF_INET)
+        if (link_addr->addr.sa.sa_family !=3D AF_INET)
         {
             return;
         }

         struct openvpn_iphdr *pip =3D (struct openvpn_iphdr *)(BPTR(buf) +=
 ip_hdr_offset);

-        /* drop packets with same dest addr as gateway */
-        if (memcmp(&tun_sa.addr.in4.sin_addr.s_addr, &pip->daddr, sizeof(p=
ip->daddr)) =3D=3D 0)
+        /* skip if tun protocol doesn't match link protocol */
+        if ((lsi->proto =3D=3D PROTO_TCP && pip->protocol !=3D OPENVPN_IPP=
ROTO_TCP)
+            || (lsi->proto =3D=3D PROTO_UDP && pip->protocol !=3D OPENVPN_=
IPPROTO_UDP))
         {
-            drop =3D true;
+            return;
+        }
+
+
+        /* drop packets with same dest addr and port as remote */
+        uint8_t *l4_hdr =3D (uint8_t *)pip + sizeof(struct openvpn_iphdr);
+
+        /* TCP and UDP ports are at the same place in the header, and othe=
r protocols
+         * can not happen here due to the lsi->proto check above */
+        uint16_t src_port =3D ntohs(*(uint16_t *)l4_hdr);
+        uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t=
)));
+        if ((memcmp(&link_addr->addr.in4.sin_addr.s_addr, &pip->daddr, siz=
eof(pip->daddr)) =3D=3D 0) && (link_port =3D=3D dst_port))
+        {
+            c->c2.buf.len =3D 0;
+
+            struct gc_arena gc =3D gc_new();
+            msg(D_LOW, "Recursive routing detected, packet dropped %s:%" P=
RIu16 " -> %s",
+                print_in_addr_t(pip->saddr, IA_NET_ORDER, &gc),
+                src_port,
+                print_link_socket_actual(c->c2.to_link_addr, &gc));
+            gc_free(&gc);
         }
     }
-    else if (proto_ver =3D=3D 6)
+    else if (tun_ip_ver =3D=3D 6)
     {
-        /* make sure we got whole IPv6 header */
-        if (BLEN(buf) < ((int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_offs=
et))
+        /* make sure we got whole IPv6 header and TCP/UDP src/dst ports */
+        if (BLEN(buf) < ((int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_offs=
et + sizeof(uint16_t) * 2))
         {
             return;
         }

         /* skip ipv6 packets for ipv4 tun */
-        if (tun_sa.addr.sa.sa_family !=3D AF_INET6)
+        if (link_addr->addr.sa.sa_family !=3D AF_INET6)
         {
             return;
         }

         struct openvpn_ipv6hdr *pip6 =3D (struct openvpn_ipv6hdr *)(BPTR(b=
uf) + ip_hdr_offset);

-        /* drop packets with same dest addr as gateway */
-        if (OPENVPN_IN6_ARE_ADDR_EQUAL(&tun_sa.addr.in6.sin6_addr, &pip6->=
daddr))
+        /* skip if tun protocol doesn't match link protocol */
+        if ((lsi->proto =3D=3D PROTO_TCP && pip6->nexthdr !=3D OPENVPN_IPP=
ROTO_TCP)
+            || (lsi->proto =3D=3D PROTO_UDP && pip6->nexthdr !=3D OPENVPN_=
IPPROTO_UDP))
         {
-            drop =3D true;
+            return;
         }
-    }

-    if (drop)
-    {
-        struct gc_arena gc =3D gc_new();
+        /* drop packets with same dest addr and port as remote */
+        uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct openvpn_ipv6hd=
r);
+        uint16_t src_port =3D ntohs(*(uint16_t *)l4_hdr);
+        uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t=
)));
+        if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&link_addr->addr.in6.sin6_addr, &p=
ip6->daddr)) && (link_port =3D=3D dst_port))
+        {
+            c->c2.buf.len =3D 0;

-        c->c2.buf.len =3D 0;
-
-        msg(D_LOW, "Recursive routing detected, drop tun packet to %s",
-            print_link_socket_actual(c->c2.to_link_addr, &gc));
-        gc_free(&gc);
+            struct gc_arena gc =3D gc_new();
+            msg(D_LOW, "Recursive routing detected, packet dropped %s:%" P=
RIu16 " -> %s",
+                print_in6_addr(pip6->saddr, IA_NET_ORDER, &gc),
+                src_port,
+                print_link_socket_actual(c->c2.to_link_addr, &gc));
+            gc_free(&gc);
+        }
     }
 }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/903?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6841e2f2a85275254a04e2d8ae3defe4420db8f6
Gerrit-Change-Number: 903
Gerrit-PatchSet: 5
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AgGkH7Mdl1s=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by stipa.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/903?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Make recursive routing check more f=
ine-grained<br><br>The existing recursive routing check drops TUN packets<b=
r>if their address matches the remote. While this works in<br>most cases, a=
 more fine-grained check is preferable for<br>complex routing rules.<br><br=
>Since we only need to drop traffic originating from OpenVPN,<br>all of the=
 following values must match between the packet<br>and the link:<br><br> - =
IP protocol<br> - Transport protocol (TCP/UDP)<br> - Destination address<br=
> - Destination port<br><br>GitHub: #699<br><br>Change-Id: I6841e2f2a852752=
54a04e2d8ae3defe4420db8f6<br>Signed-off-by: Lev Stipakov &lt;lev@...515...&=
gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https:=
//gerrit.openvpn.net/c/openvpn/+/903<br>Message-Id: &lt;20251011114448.1450=
1-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/m=
essage/59245301/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>=
---<br>M src/openvpn/forward.c<br>1 file changed, 55 insertions(+), 29 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/03/903/5</pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b=
/src/openvpn/forward.c</span><br><span>index f342958..79a6fc7 100644</span>=
<br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/for=
ward.c</span><br><span>@@ -1391,73 +1391,99 @@</span><br><span> static void=
</span><br><span> drop_if_recursive_routing(struct context *c, struct buffe=
r *buf)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    bool drop =3D false;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct openvpn_sockaddr tun_sa;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int ip_hdr_offset =3D 0;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span>     if (c-&gt;c2.to_link_add=
r =3D=3D NULL) /* no remote addr known */</span><br><span>     {</span><br>=
<span>         return;</span><br><span>     }</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    tun_sa =3D c-&gt;c2.to_link_a=
ddr-&gt;dest;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct openvpn_sockaddr *link_addr =3D &amp;c-&gt;c2.to_link_addr-&gt;dest;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct link_socke=
t_info *lsi =3D get_link_socket_info(c);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    uint16_t link_port =3D atoi(c-&gt;c2.link_sockets[=
0]-&gt;remote_port);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    int proto_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c-&gt;c1.=
tuntap), &amp;c-&gt;c2.buf, &amp;ip_hdr_offset);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    int ip_hdr_offset =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int tun_ip_ver =3D get_tun_ip_ver=
(TUNNEL_TYPE(c-&gt;c1.tuntap), &amp;c-&gt;c2.buf, &amp;ip_hdr_offset);</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
proto_ver =3D=3D 4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    if (tun_ip_ver =3D=3D 4)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* make sure we got whole IP header=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(b=
uf) &lt; ((int)sizeof(struct openvpn_iphdr) + ip_hdr_offset))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* make sure we got whole=
 IP header and TCP/UDP src/dst ports */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (BLEN(buf) &lt; ((int)sizeof(struct openvpn_=
iphdr) + ip_hdr_offset + sizeof(uint16_t) * 2))</span><br><span>         {<=
/span><br><span>             return;</span><br><span>         }</span><br><=
span> </span><br><span>         /* skip ipv4 packets for ipv6 tun */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (tun_sa.addr.sa.s=
a_family !=3D AF_INET)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (link_addr-&gt;addr.sa.sa_family !=3D AF_INET)</span><br><spa=
n>         {</span><br><span>             return;</span><br><span>         =
}</span><br><span> </span><br><span>         struct openvpn_iphdr *pip =3D =
(struct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* drop packets wi=
th same dest addr as gateway */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (memcmp(&amp;tun_sa.addr.in4.sin_addr.s_addr, &amp;pip=
-&gt;daddr, sizeof(pip-&gt;daddr)) =3D=3D 0)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        /* skip if tun protocol doesn&#39;t match =
link protocol */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if ((lsi-&gt;proto =3D=3D PROTO_TCP &amp;&amp; pip-&gt;protocol !=3D O=
PENVPN_IPPROTO_TCP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            || (lsi-&gt;proto =3D=3D PROTO_UDP &amp;&amp; pip-&gt;protocol =
!=3D OPENVPN_IPPROTO_UDP))</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            drop =3D true;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            return;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* drop packets with same dest addr and port as remote */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uint8_t *l4_hdr =3D (uint8_t *=
)pip + sizeof(struct openvpn_iphdr);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* TCP and UDP ports are at the same place in the header, and other p=
rotocols</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         * =
can not happen here due to the lsi-&gt;proto check above */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        uint16_t src_port =3D ntohs=
(*(uint16_t *)l4_hdr);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16=
_t)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if ((=
memcmp(&amp;link_addr-&gt;addr.in4.sin_addr.s_addr, &amp;pip-&gt;daddr, siz=
eof(pip-&gt;daddr)) =3D=3D 0) &amp;&amp; (link_port =3D=3D dst_port))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2.buf.len =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            struct gc_arena gc =3D gc_=
new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            m=
sg(D_LOW, &quot;Recursive routing detected, packet dropped %s:%&quot; PRIu1=
6 &quot; -&gt; %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                print_in_addr_t(pip-&gt;saddr, IA_NET_ORDER, &amp;gc),=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                src=
_port,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   print_link_socket_actual(c-&gt;c2.to_link_addr, &amp;gc));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</sp=
an><br><span>         }</span><br><span>     }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    else if (proto_ver =3D=3D 6)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    else if (tun_ip_ver =3D=3D 6)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      /* make sure we got whole IPv6 header */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt; ((int)sizeof(struct ope=
nvpn_ipv6hdr) + ip_hdr_offset))</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        /* make sure we got whole IPv6 header and TCP/UDP src/d=
st ports */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
if (BLEN(buf) &lt; ((int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset + s=
izeof(uint16_t) * 2))</span><br><span>         {</span><br><span>          =
   return;</span><br><span>         }</span><br><span> </span><br><span>   =
      /* skip ipv6 packets for ipv4 tun */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        if (tun_sa.addr.sa.sa_family !=3D AF_INET6)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (link_addr-=
&gt;addr.sa.sa_family !=3D AF_INET6)</span><br><span>         {</span><br><=
span>             return;</span><br><span>         }</span><br><span> </spa=
n><br><span>         struct openvpn_ipv6hdr *pip6 =3D (struct openvpn_ipv6h=
dr *)(BPTR(buf) + ip_hdr_offset);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        /* drop packets with same dest addr=
 as gateway */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (OPENVPN_IN6_ARE_ADDR_EQUAL(&amp;tun_sa.addr.in6.sin6_addr, &amp;pip6-&=
gt;daddr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /=
* skip if tun protocol doesn&#39;t match link protocol */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        if ((lsi-&gt;proto =3D=3D PRO=
TO_TCP &amp;&amp; pip6-&gt;nexthdr !=3D OPENVPN_IPPROTO_TCP)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+            || (lsi-&gt;proto =3D=
=3D PROTO_UDP &amp;&amp; pip6-&gt;nexthdr !=3D OPENVPN_IPPROTO_UDP))</span>=
<br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
           drop =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            return;</span><br><span>         }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (drop)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        struct gc_arena gc =3D gc_new();</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        /* drop packets with same dest addr =
and port as remote */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct openvpn_ipv6h=
dr);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint16_=
t src_port =3D ntohs(*(uint16_t *)l4_hdr);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        uint16_t dst_port =3D ntohs(*(uint16_t *)(l4=
_hdr + sizeof(uint16_t)));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&amp;link_addr-&gt;addr.in6.=
sin6_addr, &amp;pip6-&gt;daddr)) &amp;&amp; (link_port =3D=3D dst_port))</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2.buf.len =3D=
 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        c-&gt;c2.buf.len =3D 0;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg=
(D_LOW, &quot;Recursive routing detected, drop tun packet to %s&quot;,</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_link_soc=
ket_actual(c-&gt;c2.to_link_addr, &amp;gc));</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+            struct gc_arena gc =3D gc_new();</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW=
, &quot;Recursive routing detected, packet dropped %s:%&quot; PRIu16 &quot;=
 -&gt; %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             print_in6_addr(pip6-&gt;saddr, IA_NET_ORDER, &amp;gc),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                src_port,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                print=
_link_socket_actual(c-&gt;c2.to_link_addr, &amp;gc));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     =
}</span><br><span> }</span><br><span> </span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/903?usp=3De=
mail">change 903</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.=
</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsco=
pe itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link item=
prop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/903?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6841e2f2a85275254a04e2d8ae3=
defe4420db8f6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 903 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--AgGkH7Mdl1s=--

