From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 Jan 2026 10:10:15 +0000
In-Reply-To: <gerrit.1768323591000.I701f9e0a96a7b43f278f8e6089e9156feab772c8@...2715...>
References: <gerrit.1768323591000.I701f9e0a96a7b43f278f8e6089e9156feab772c8@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fb645980a4e563035cf4a7060f937c9f3594ccc3-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tDB5zLQVG2w="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: forward: Avoid
 conversion warning in ipv6_send_icmp_unreachable
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

--tDB5zLQVG2w=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1472?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: forward: Avoid conversion warning in ipv6_send_icmp_unreach=
able
......................................................................

forward: Avoid conversion warning in ipv6_send_icmp_unreachable

Since all values are limited by MAX_ICMPV6LEN we can
just cast to uint16_t.

While here remove a unused gc arena in neighbouring
code.

Change-Id: I701f9e0a96a7b43f278f8e6089e9156feab772c8
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1472
Message-Id: <20260115091124.23360-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59283657/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
1 file changed, 5 insertions(+), 16 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1472/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 39ac3b3..5004e35 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1352,11 +1352,6 @@
     check_status(c->c2.buf.len, "read from TUN/TAP", NULL, c->c1.tuntap);
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /**
  * Drops UDP packets which OS decided to route via tun.
  *
@@ -1483,8 +1478,6 @@
 void
 process_incoming_tun(struct context *c, struct link_socket *out_sock)
 {
-    struct gc_arena gc =3D gc_new();
-
     if (c->c2.buf.len > 0)
     {
         c->c2.tun_read_bytes +=3D c->c2.buf.len;
@@ -1528,7 +1521,6 @@
     {
         buf_reset(&c->c2.to_link);
     }
-    gc_free(&gc);
 }

 /**
@@ -1593,7 +1585,7 @@
     icmp6out.icmp6_type =3D OPENVPN_ICMP6_DESTINATION_UNREACHABLE;
     icmp6out.icmp6_code =3D OPENVPN_ICMP6_DU_NOROUTE;

-    int icmpheader_len =3D sizeof(struct openvpn_ipv6hdr) + sizeof(struct =
openvpn_icmp6hdr);
+    const int icmpheader_len =3D sizeof(struct openvpn_ipv6hdr) + sizeof(s=
truct openvpn_icmp6hdr);
     int totalheader_len =3D icmpheader_len;

     if (TUNNEL_TYPE(c->c1.tuntap) =3D=3D DEV_TYPE_TAP)
@@ -1606,10 +1598,11 @@
      * frame should be <=3D 1280 and have as much as possible of the origi=
nal
      * packet
      */
-    int max_payload_size =3D min_int(MAX_ICMPV6LEN, c->c2.frame.tun_mtu - =
icmpheader_len);
-    int payload_len =3D min_int(max_payload_size, BLEN(&inputipbuf));
+    const int max_payload_size =3D min_int(MAX_ICMPV6LEN, c->c2.frame.tun_=
mtu - icmpheader_len);
+    const int payload_len =3D min_int(max_payload_size, BLEN(&inputipbuf));
+    const uint16_t icmp_len =3D (uint16_t)(sizeof(struct openvpn_icmp6hdr)=
 + payload_len);

-    pip6out.payload_len =3D htons(sizeof(struct openvpn_icmp6hdr) + payloa=
d_len);
+    pip6out.payload_len =3D htons(icmp_len);

     /* Construct the packet as outgoing packet back to the client */
     struct buffer *outbuf;
@@ -1665,10 +1658,6 @@
 #undef MAX_ICMPV6LEN
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 process_ip_header(struct context *c, unsigned int flags, struct buffer *bu=
f,
                   struct link_socket *sock)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1472?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I701f9e0a96a7b43f278f8e6089e9156feab772c8
Gerrit-Change-Number: 1472
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--tDB5zLQVG2w=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1472?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">forward: Avoid conversion warning i=
n ipv6_send_icmp_unreachable<br><br>Since all values are limited by MAX_ICM=
PV6LEN we can<br>just cast to uint16_t.<br><br>While here remove a unused g=
c arena in neighbouring<br>code.<br><br>Change-Id: I701f9e0a96a7b43f278f8e6=
089e9156feab772c8<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https:=
//gerrit.openvpn.net/c/openvpn/+/1472<br>Message-Id: &lt;20260115091124.233=
60-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailman/=
message/59283657/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br=
>---<br>M src/openvpn/forward.c<br>1 file changed, 5 insertions(+), 16 dele=
tions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418=
/openvpn refs/changes/72/1472/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c =
b/src/openvpn/forward.c</span><br><span>index 39ac3b3..5004e35 100644</span=
><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/fo=
rward.c</span><br><span>@@ -1352,11 +1352,6 @@</span><br><span>     check_s=
tatus(c-&gt;c2.buf.len, &quot;read from TUN/TAP&quot;, NULL, c-&gt;c1.tunta=
p);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignor=
ed &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span> /**</span><br><span>  * Drops UDP packets which OS decided to rout=
e via tun.</span><br><span>  *</span><br><span>@@ -1483,8 +1478,6 @@</span>=
<br><span> void</span><br><span> process_incoming_tun(struct context *c, st=
ruct link_socket *out_sock)</span><br><span> {</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (c-&gt;c2.=
buf.len &gt; 0)</span><br><span>     {</span><br><span>         c-&gt;c2.tu=
n_read_bytes +=3D c-&gt;c2.buf.len;</span><br><span>@@ -1528,7 +1521,6 @@</=
span><br><span>     {</span><br><span>         buf_reset(&amp;c-&gt;c2.to_l=
ink);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br=
><span> /**</span><br><span>@@ -1593,7 +1585,7 @@</span><br><span>     icmp=
6out.icmp6_type =3D OPENVPN_ICMP6_DESTINATION_UNREACHABLE;</span><br><span>=
     icmp6out.icmp6_code =3D OPENVPN_ICMP6_DU_NOROUTE;</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    int icmpheader_len =
=3D sizeof(struct openvpn_ipv6hdr) + sizeof(struct openvpn_icmp6hdr);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int icmpheader_=
len =3D sizeof(struct openvpn_ipv6hdr) + sizeof(struct openvpn_icmp6hdr);</=
span><br><span>     int totalheader_len =3D icmpheader_len;</span><br><span=
> </span><br><span>     if (TUNNEL_TYPE(c-&gt;c1.tuntap) =3D=3D DEV_TYPE_TA=
P)</span><br><span>@@ -1606,10 +1598,11 @@</span><br><span>      * frame sh=
ould be &lt;=3D 1280 and have as much as possible of the original</span><br=
><span>      * packet</span><br><span>      */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    int max_payload_size =3D min_int(MAX_ICMPV6LEN=
, c-&gt;c2.frame.tun_mtu - icmpheader_len);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int payload_len =3D min_int(max_payload_size, BLE=
N(&amp;inputipbuf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    const int max_payload_size =3D min_int(MAX_ICMPV6LEN, c-&gt;c2.frame.t=
un_mtu - icmpheader_len);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const int payload_len =3D min_int(max_payload_size, BLEN(&amp;inp=
utipbuf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const=
 uint16_t icmp_len =3D (uint16_t)(sizeof(struct openvpn_icmp6hdr) + payload=
_len);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    pip6out.payload_len =3D htons(sizeof(struct openvpn_icmp6hdr) + payl=
oad_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pip6ou=
t.payload_len =3D htons(icmp_len);</span><br><span> </span><br><span>     /=
* Construct the packet as outgoing packet back to the client */</span><br><=
span>     struct buffer *outbuf;</span><br><span>@@ -1665,10 +1658,6 @@</sp=
an><br><span> #undef MAX_ICMPV6LEN</span><br><span> }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || =
defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pr=
agma GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> void</span><br><span> process_ip_header(struct context *c, unsigned in=
t flags, struct buffer *buf,</span><br><span>                   struct link=
_socket *sock)</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1472?usp=3Demail">change 1472</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1472?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I701f9e0a96a7b43f278f8e6089e=
9156feab772c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1472 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--tDB5zLQVG2w=--

