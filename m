From: "stipa (Code Review)" <gerrit@...515...>
Date: Thu, 6 Mar 2025 14:37:29 +0000
References: <gerrit.1741271846000.I6841e2f2a85275254a04e2d8ae3defe4420db8f6@...2715...>
Reply-To: lstipakov@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <4e1b7d3ab73e978ecb22a56cec438fef03ad3146-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="2T89gShuNOo="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--2T89gShuNOo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/903?usp=3Demail

to review the following change.


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
---
M src/openvpn/forward.c
1 file changed, 63 insertions(+), 38 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/903/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index b025344..7ec3ef2 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1386,74 +1386,99 @@
 static void
 drop_if_recursive_routing(struct context *c, struct buffer *buf)
 {
-    bool drop =3D false;
-    struct openvpn_sockaddr tun_sa;
-    int ip_hdr_offset =3D 0;
+    struct gc_arena gc =3D gc_new();

     if (c->c2.to_link_addr =3D=3D NULL) /* no remote addr known */
     {
-        return;
+        goto out;
     }

-    tun_sa =3D c->c2.to_link_addr->dest;
+    struct openvpn_sockaddr *link_addr =3D &c->c2.to_link_addr->dest;
+    struct link_socket_info *lsi =3D get_link_socket_info(c);
+    uint16_t link_port =3D atoi(c->c2.link_sockets[0]->remote_port);

-    int proto_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), &c->c2.buf=
, &ip_hdr_offset);
+    uint16_t src_port =3D 0, dst_port =3D 0;

-    if (proto_ver =3D=3D 4)
+    int ip_hdr_offset =3D 0;
+    int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c->c1.tuntap), &c->c2.bu=
f, &ip_hdr_offset);
+
+    if (tun_ip_ver =3D=3D 4)
     {
-        /* make sure we got whole IP header */
-        if (BLEN(buf) < ((int) sizeof(struct openvpn_iphdr) + ip_hdr_offse=
t))
+        /* make sure we got whole IP header and TCP/UDP src/dst ports */
+        if (BLEN(buf) < ((int) sizeof(struct openvpn_iphdr) + ip_hdr_offse=
t + sizeof(uint16_t) * 2))
         {
-            return;
-        }
-
-        /* skip ipv4 packets for ipv6 tun */
-        if (tun_sa.addr.sa.sa_family !=3D AF_INET)
-        {
-            return;
+            goto out;
         }

         struct openvpn_iphdr *pip =3D (struct openvpn_iphdr *) (BPTR(buf) =
+ ip_hdr_offset);

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
+            goto out;
+        }
+
+        /* skip ipv4 packets for ipv6 tun */
+        if (link_addr->addr.sa.sa_family !=3D AF_INET)
+        {
+            goto out;
+        }
+
+        /* drop packets with same dest addr and port as remote */
+        uint8_t *l4_hdr =3D (uint8_t *)pip + sizeof(struct openvpn_iphdr);
+        uint16_t src_port =3D ntohs(*(uint16_t *)l4_hdr);
+        uint16_t dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t=
)));
+        if ((memcmp(&link_addr->addr.in4.sin_addr.s_addr, &pip->daddr, siz=
eof(pip->daddr)) =3D=3D 0) && (link_port =3D=3D dst_port))
+        {
+            c->c2.buf.len =3D 0;
+
+            msg(D_LOW, "Recursive routing detected, packet dropped %s:%" P=
RIu16 " -> %s",
+                print_in_addr_t(pip->saddr, IA_NET_ORDER, &gc),
+                src_port,
+                print_link_socket_actual(c->c2.to_link_addr, &gc));
         }
     }
-    else if (proto_ver =3D=3D 6)
+    else if (tun_ip_ver =3D=3D 6)
     {
-        /* make sure we got whole IPv6 header */
-        if (BLEN(buf) < ((int) sizeof(struct openvpn_ipv6hdr) + ip_hdr_off=
set))
+        /* make sure we got whole IPv6 header and TCP/UDP src/dst ports */
+        if (BLEN(buf) < ((int) sizeof(struct openvpn_ipv6hdr) + ip_hdr_off=
set + sizeof(uint16_t) * 2))
         {
-            return;
+            goto out;
         }

         /* skip ipv6 packets for ipv4 tun */
-        if (tun_sa.addr.sa.sa_family !=3D AF_INET6)
+        if (link_addr->addr.sa.sa_family !=3D AF_INET6)
         {
-            return;
+            goto out;
         }

         struct openvpn_ipv6hdr *pip6 =3D (struct openvpn_ipv6hdr *) (BPTR(=
buf) + ip_hdr_offset);

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
+            goto out;
+        }
+
+        /* drop packets with same dest addr and port as remote */
+        uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct openvpn_ipv6hd=
r);
+        src_port =3D ntohs(*(uint16_t *)l4_hdr);
+        dst_port =3D ntohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t)));
+        if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&link_addr->addr.in6.sin6_addr, &p=
ip6->daddr)) && (link_port =3D=3D dst_port))
+        {
+            c->c2.buf.len =3D 0;
+
+            msg(D_LOW, "Recursive routing detected, packet dropped %s:%" P=
RIu16 " -> %s",
+                print_in6_addr(pip6->saddr, IA_NET_ORDER, &gc),
+                src_port,
+                print_link_socket_actual(c->c2.to_link_addr, &gc));
         }
     }

-    if (drop)
-    {
-        struct gc_arena gc =3D gc_new();
-
-        c->c2.buf.len =3D 0;
-
-        msg(D_LOW, "Recursive routing detected, drop tun packet to %s",
-            print_link_socket_actual(c->c2.to_link_addr, &gc));
-        gc_free(&gc);
-    }
+out:
+    gc_free(&gc);
 }

 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/903?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6841e2f2a85275254a04e2d8ae3defe4420db8f6
Gerrit-Change-Number: 903
Gerrit-PatchSet: 1
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--2T89gShuNOo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>stipa would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/903?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Make recursive routing check more fine-grained<br><br>The exi=
sting recursive routing check drops TUN packets<br>if their address matches=
 the remote. While this works in<br>most cases, a more fine-grained check i=
s preferable for<br>complex routing rules.<br><br>Since we only need to dro=
p traffic originating from OpenVPN,<br>all of the following values must mat=
ch between the packet<br>and the link:<br><br> - IP protocol<br> - Transpor=
t protocol (TCP/UDP)<br> - Destination address<br> - Destination port<br><b=
r>GitHub: #699<br><br>Change-Id: I6841e2f2a85275254a04e2d8ae3defe4420db8f6<=
br>Signed-off-by: Lev Stipakov &lt;lev@...515...&gt;<br>---<br>M src/openvp=
n/forward.c<br>1 file changed, 63 insertions(+), 38 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/03/903/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><sp=
an>index b025344..7ec3ef2 100644</span><br><span>--- a/src/openvpn/forward.=
c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1386,74 +=
1386,99 @@</span><br><span> static void</span><br><span> drop_if_recursive_=
routing(struct context *c, struct buffer *buf)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    bool drop =3D false;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    struct openvpn_sockaddr =
tun_sa;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int ip_hdr=
_offset =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    s=
truct gc_arena gc =3D gc_new();</span><br><span> </span><br><span>     if (=
c-&gt;c2.to_link_addr =3D=3D NULL) /* no remote addr known */</span><br><sp=
an>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        retu=
rn;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        goto out=
;</span><br><span>     }</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    tun_sa =3D c-&gt;c2.to_link_addr-&gt;dest;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct openvpn_sockaddr=
 *link_addr =3D &amp;c-&gt;c2.to_link_addr-&gt;dest;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct link_socket_info *lsi =3D get_=
link_socket_info(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    uint16_t link_port =3D atoi(c-&gt;c2.link_sockets[0]-&gt;remote_port);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 int proto_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c-&gt;c1.tuntap), &amp;c-&gt;=
c2.buf, &amp;ip_hdr_offset);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    uint16_t src_port =3D 0, dst_port =3D 0;</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto_ver =3D=3D =
4)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int ip_hdr_of=
fset =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int =
tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c-&gt;c1.tuntap), &amp;c-&gt;c2.b=
uf, &amp;ip_hdr_offset);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tun_ip=
_ver =3D=3D 4)</span><br><span>     {</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        /* make sure we got whole IP header */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt; ((int) =
sizeof(struct openvpn_iphdr) + ip_hdr_offset))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        /* make sure we got whole IP header and =
TCP/UDP src/dst ports */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (BLEN(buf) &lt; ((int) sizeof(struct openvpn_iphdr) + ip_hd=
r_offset + sizeof(uint16_t) * 2))</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            return;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        /* skip ipv4 packets for ipv6 tun */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (tun_sa.addr.sa.sa_family !=3D AF_INE=
T)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            return;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            goto out;</span><br=
><span>         }</span><br><span> </span><br><span>         struct openvpn=
_iphdr *pip =3D (struct openvpn_iphdr *) (BPTR(buf) + ip_hdr_offset);</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /=
* drop packets with same dest addr as gateway */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        if (memcmp(&amp;tun_sa.addr.in4.sin_addr=
.s_addr, &amp;pip-&gt;daddr, sizeof(pip-&gt;daddr)) =3D=3D 0)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        /* skip if tun protocol d=
oesn&#39;t match link protocol */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        if ((lsi-&gt;proto =3D=3D PROTO_TCP &amp;&amp; pip-&g=
t;protocol !=3D OPENVPN_IPPROTO_TCP)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            || (lsi-&gt;proto =3D=3D PROTO_UDP &amp;&amp; =
pip-&gt;protocol !=3D OPENVPN_IPPROTO_UDP))</span><br><span>         {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            drop =3D true;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            goto ou=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /* skip ipv4 packets for ipv6 tun */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (link_addr=
-&gt;addr.sa.sa_family !=3D AF_INET)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            goto out;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* drop pack=
ets with same dest addr and port as remote */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        uint8_t *l4_hdr =3D (uint8_t *)pip + size=
of(struct openvpn_iphdr);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        uint16_t src_port =3D ntohs(*(uint16_t *)l4_hdr);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        uint16_t dst_port =3D n=
tohs(*(uint16_t *)(l4_hdr + sizeof(uint16_t)));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if ((memcmp(&amp;link_addr-&gt;addr.in4=
.sin_addr.s_addr, &amp;pip-&gt;daddr, sizeof(pip-&gt;daddr)) =3D=3D 0) &amp=
;&amp; (link_port =3D=3D dst_port))</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            c-&gt;c2.buf.len =3D 0;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            msg(D_LOW, &quot;Recursive routing detected, packet dropped =
%s:%&quot; PRIu16 &quot; -&gt; %s&quot;,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                print_in_addr_t(pip-&gt;saddr, IA_NET_=
ORDER, &amp;gc),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             src_port,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                print_link_socket_actual(c-&gt;c2.to_link_addr, &amp;gc)=
);</span><br><span>         }</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    else if (proto_ver =3D=3D 6)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    else if (tun_ip_ver =3D=3D=
 6)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        /* make sure we got whole IPv6 header */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt; ((int) sizeof(st=
ruct openvpn_ipv6hdr) + ip_hdr_offset))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        /* make sure we got whole IPv6 header and TCP/U=
DP src/dst ports */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (BLEN(buf) &lt; ((int) sizeof(struct openvpn_ipv6hdr) + ip_hdr_o=
ffset + sizeof(uint16_t) * 2))</span><br><span>         {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            return;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            goto out;</span><br><span> =
        }</span><br><span> </span><br><span>         /* skip ipv6 packets f=
or ipv4 tun */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 if (tun_sa.addr.sa.sa_family !=3D AF_INET6)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (link_addr-&gt;addr.sa.sa_family !=3D A=
F_INET6)</span><br><span>         {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            return;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            goto out;</span><br><span>         }</span><br><s=
pan> </span><br><span>         struct openvpn_ipv6hdr *pip6 =3D (struct ope=
nvpn_ipv6hdr *) (BPTR(buf) + ip_hdr_offset);</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        /* drop packets with same =
dest addr as gateway */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        if (OPENVPN_IN6_ARE_ADDR_EQUAL(&amp;tun_sa.addr.in6.sin6_addr, &a=
mp;pip6-&gt;daddr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        /* skip if tun protocol doesn&#39;t match link protocol */</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        if ((lsi-&gt;proto =
=3D=3D PROTO_TCP &amp;&amp; pip6-&gt;nexthdr !=3D OPENVPN_IPPROTO_TCP)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            || (lsi-&gt;=
proto =3D=3D PROTO_UDP &amp;&amp; pip6-&gt;nexthdr !=3D OPENVPN_IPPROTO_UDP=
))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            drop =3D true;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            goto out;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* d=
rop packets with same dest addr and port as remote */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        uint8_t *l4_hdr =3D (uint8_t *)pi=
p6 + sizeof(struct openvpn_ipv6hdr);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        src_port =3D ntohs(*(uint16_t *)l4_hdr);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        dst_port =3D ntohs(*(=
uint16_t *)(l4_hdr + sizeof(uint16_t)));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if ((OPENVPN_IN6_ARE_ADDR_EQUAL(&amp;link_addr=
-&gt;addr.in6.sin6_addr, &amp;pip6-&gt;daddr)) &amp;&amp; (link_port =3D=3D=
 dst_port))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;=
c2.buf.len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            msg(D_LOW=
, &quot;Recursive routing detected, packet dropped %s:%&quot; PRIu16 &quot;=
 -&gt; %s&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             print_in6_addr(pip6-&gt;saddr, IA_NET_ORDER, &amp;gc),</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                src_port,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                print=
_link_socket_actual(c-&gt;c2.to_link_addr, &amp;gc));</span><br><span>     =
    }</span><br><span>     }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (drop)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       c-&gt;c2.buf.len =3D 0;</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        msg(=
D_LOW, &quot;Recursive routing detected, drop tun packet to %s&quot;,</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            print_link_sock=
et_actual(c-&gt;c2.to_link_addr, &amp;gc));</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        gc_free(&amp;gc);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+out:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span> /*=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/903?usp=3Demail">change 903</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/903?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6841e2f2a85275254a04e2d8ae3=
defe4420db8f6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 903 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--2T89gShuNOo=--

