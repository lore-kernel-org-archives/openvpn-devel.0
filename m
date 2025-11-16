From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sun, 16 Nov 2025 11:21:31 +0000
In-Reply-To: <gerrit.1763112271000.I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d@...2715...>
References: <gerrit.1763112271000.I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <81d5840f473e97c885496e298496d194af1b7b3a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jMk3L6+p3gU="; charset=UTF-8
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
To: stipa <lstipakov@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jMk3L6+p3gU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 stipa. ( http://gerrit.openvpn.net/c/openvpn/+/1377?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: recursive routing: fixes and clean-ups
......................................................................

recursive routing: fixes and clean-ups

 - get rid of atoi() for getting the remote transport port.
 It doesn't change, so no point to do in on every packet.
 In addition, atoi() breaks when we use service names as ports.

 - ensure we correctly handle IPv4 headers with options

 - directly use buf parameter in place of c->c2.buf

GitHub: closes OpenVPN/openvpn#902

Change-Id: I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d
Signed-off-by: Lev Stipakov <lev@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1377
Message-Id: <20251114115029.17432-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
415.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
1 file changed, 22 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1377/3

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
Gerrit-PatchSet: 3
Gerrit-Owner: stipa <lstipakov@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jMk3L6+p3gU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by stipa.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1377?usp=3Demail">View C=
hange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">recursive routing: fixes and=
 clean-ups<br><br> - get rid of atoi() for getting the remote transport por=
t.<br> It doesn&#39;t change, so no point to do in on every packet.<br> In =
addition, atoi() breaks when we use service names as ports.<br><br> - ensur=
e we correctly handle IPv4 headers with options<br><br> - directly use buf =
parameter in place of c-&gt;c2.buf<br><br>GitHub: closes OpenVPN/openvpn#90=
2<br><br>Change-Id: I8a0a8029da02fc63adc918e8d98e9f676ff4ea0d<br>Signed-off=
-by: Lev Stipakov &lt;lev@...515...&gt;<br>Acked-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/=
1377<br>Message-Id: &lt;20251114115029.17432-1-gert@...1296...&gt;<br>URL: =
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34415.h=
tml<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/=
openvpn/forward.c<br>1 file changed, 22 insertions(+), 11 deletions(-)<br><=
br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/77/1377/3</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn=
/forward.c</span><br><span>index aa1f858..90e52d2 100644</span><br><span>--=
- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span=
><br><span>@@ -1382,15 +1382,24 @@</span><br><span> </span><br><span>     s=
truct openvpn_sockaddr *link_addr =3D &amp;c-&gt;c2.to_link_addr-&gt;dest;<=
/span><br><span>     struct link_socket_info *lsi =3D get_link_socket_info(=
c);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint16_t link_=
port =3D atoi(c-&gt;c2.link_sockets[0]-&gt;remote_port);</span><br><span> <=
/span><br><span>     int ip_hdr_offset =3D 0;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    int tun_ip_ver =3D get_tun_ip_ver(TUNNEL_TYPE(c=
-&gt;c1.tuntap), &amp;c-&gt;c2.buf, &amp;ip_hdr_offset);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int tun_ip_ver =3D get_tun_ip_ver(=
TUNNEL_TYPE(c-&gt;c1.tuntap), buf, &amp;ip_hdr_offset);</span><br><span> </=
span><br><span>     if (tun_ip_ver =3D=3D 4)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        /* make sure we got w=
hole IP header and TCP/UDP src/dst ports */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt; ((int)sizeof(struct openvp=
n_iphdr) + ip_hdr_offset + sizeof(uint16_t) * 2))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        /* Ensure we can safely read the IPv4=
 header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c=
onst int min_ip_header =3D ip_hdr_offset + sizeof(struct openvpn_iphdr);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (BLEN(buf) =
&lt; min_ip_header)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  return;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        struct openvpn_iphdr *pip =3D (=
struct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        const int ip_hlen =3D OPENVPN_IPH=
_GET_LEN(pip-&gt;version_len);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* Reject malformed or truncated headers */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        if (ip_hlen &lt; sizeof(=
struct openvpn_iphdr)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            || BLEN(buf) &lt; (int)(ip_hdr_offset + ip_hlen + sizeof(uint=
16_t) * 2))</span><br><span>         {</span><br><span>             return;=
</span><br><span>         }</span><br><span>@@ -1401,8 +1410,6 @@</span><br=
><span>             return;</span><br><span>         }</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct openvpn_i=
phdr *pip =3D (struct openvpn_iphdr *)(BPTR(buf) + ip_hdr_offset);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>         /* s=
kip if tun protocol doesn&#39;t match link protocol */</span><br><span>    =
     if ((lsi-&gt;proto =3D=3D PROTO_TCP &amp;&amp; pip-&gt;protocol !=3D O=
PENVPN_IPPROTO_TCP)</span><br><span>             || (lsi-&gt;proto =3D=3D P=
ROTO_UDP &amp;&amp; pip-&gt;protocol !=3D OPENVPN_IPPROTO_UDP))</span><br><=
span>@@ -1410,9 +1417,10 @@</span><br><span>             return;</span><br>=
<span>         }</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span>         /* drop packets with same dest addr =
and port as remote */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        uint8_t *l4_hdr =3D (uint8_t *)pip + sizeof(struct openvpn_iphdr);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        uint8_t *l4_=
hdr =3D (uint8_t *)pip + ip_hlen;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   uint16_t link_port =3D ntohs(link_addr-&gt;addr.in4.sin_port);</span><br=
><span> </span><br><span>         /* TCP and UDP ports are at the same plac=
e in the header, and other protocols</span><br><span>          * can not ha=
ppen here due to the lsi-&gt;proto check above */</span><br><span>@@ -1420,=
7 +1428,7 @@</span><br><span>         uint16_t dst_port =3D ntohs(*(uint16_=
t *)(l4_hdr + sizeof(uint16_t)));</span><br><span>         if ((memcmp(&amp=
;link_addr-&gt;addr.in4.sin_addr.s_addr, &amp;pip-&gt;daddr, sizeof(pip-&gt=
;daddr)) =3D=3D 0) &amp;&amp; (link_port =3D=3D dst_port))</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 c-&gt;c2.buf.len =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            buf-&gt;len =3D 0;</span><br><span> </span><br><span>     =
        struct gc_arena gc =3D gc_new();</span><br><span>             msg(D=
_LOW, &quot;Recursive routing detected, packet dropped %s:%&quot; PRIu16 &q=
uot; -&gt; %s&quot;,</span><br><span>@@ -1433,7 +1441,8 @@</span><br><span>=
     else if (tun_ip_ver =3D=3D 6)</span><br><span>     {</span><br><span> =
        /* make sure we got whole IPv6 header and TCP/UDP src/dst ports */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(buf) =
&lt; ((int)sizeof(struct openvpn_ipv6hdr) + ip_hdr_offset + sizeof(uint16_t=
) * 2))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cons=
t int min_ipv6 =3D ip_hdr_offset + sizeof(struct openvpn_ipv6hdr) + sizeof(=
uint16_t) * 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   if (BLEN(buf) &lt; min_ipv6)</span><br><span>         {</span><br><span>=
             return;</span><br><span>         }</span><br><span>@@ -1453,13=
 +1462,15 @@</span><br><span>             return;</span><br><span>         =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        uint16_t link_port =3D ntohs(link_addr-&gt;addr.in6.sin6_port);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>      =
   /* drop packets with same dest addr and port as remote */</span><br><spa=
n>         uint8_t *l4_hdr =3D (uint8_t *)pip6 + sizeof(struct openvpn_ipv6=
hdr);</span><br><span>         uint16_t src_port =3D ntohs(*(uint16_t *)l4_=
hdr);</span><br><span>         uint16_t dst_port =3D ntohs(*(uint16_t *)(l4=
_hdr + sizeof(uint16_t)));</span><br><span>         if ((OPENVPN_IN6_ARE_AD=
DR_EQUAL(&amp;link_addr-&gt;addr.in6.sin6_addr, &amp;pip6-&gt;daddr)) &amp;=
&amp; (link_port =3D=3D dst_port))</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            c-&gt;c2.buf.len =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            buf-&gt=
;len =3D 0;</span><br><span> </span><br><span>             struct gc_arena =
gc =3D gc_new();</span><br><span>             msg(D_LOW, &quot;Recursive ro=
uting detected, packet dropped %s:%&quot; PRIu16 &quot; -&gt; %s&quot;,</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1377?usp=3Demail">change 1377</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1377?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8a0a8029da02fc63adc918e8d98=
e9f676ff4ea0d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1377 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: stipa &lt;lstipakov@...277...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--jMk3L6+p3gU=--

