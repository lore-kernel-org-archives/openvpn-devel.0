From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 13 Jan 2026 16:59:54 +0000
References: <gerrit.1768323591000.I701f9e0a96a7b43f278f8e6089e9156feab772c8@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <62d772e54ed3a99a613231217fe8de0f7369270a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="wCwtLC9g670="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--wCwtLC9g670=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1472?usp=3Demail

to review the following change.


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
---
M src/openvpn/forward.c
1 file changed, 5 insertions(+), 16 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/72/1472/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index d208c21..3730cd5 100644
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I701f9e0a96a7b43f278f8e6089e9156feab772c8
Gerrit-Change-Number: 1472
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--wCwtLC9g670=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1472?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">forward: Avoid conversion warning in ipv6_s=
end_icmp_unreachable<br><br>Since all values are limited by MAX_ICMPV6LEN w=
e can<br>just cast to uint16_t.<br><br>While here remove a unused gc arena =
in neighbouring<br>code.<br><br>Change-Id: I701f9e0a96a7b43f278f8e6089e9156=
feab772c8<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>-=
--<br>M src/openvpn/forward.c<br>1 file changed, 5 insertions(+), 16 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/72/1472/1</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/=
src/openvpn/forward.c</span><br><span>index d208c21..3730cd5 100644</span><=
br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forw=
ard.c</span><br><span>@@ -1352,11 +1352,6 @@</span><br><span>     check_sta=
tus(c-&gt;c2.buf.len, &quot;read from TUN/TAP&quot;, NULL, c-&gt;c1.tuntap)=
;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored=
 &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> /**</span><br><span>  * Drops UDP packets which OS decided to route =
via tun.</span><br><span>  *</span><br><span>@@ -1483,8 +1478,6 @@</span><b=
r><span> void</span><br><span> process_incoming_tun(struct context *c, stru=
ct link_socket *out_sock)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    struct gc_arena gc =3D gc_new();</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (c-&gt;c2.bu=
f.len &gt; 0)</span><br><span>     {</span><br><span>         c-&gt;c2.tun_=
read_bytes +=3D c-&gt;c2.buf.len;</span><br><span>@@ -1528,7 +1521,6 @@</sp=
an><br><span>     {</span><br><span>         buf_reset(&amp;c-&gt;c2.to_lin=
k);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br><=
span> /**</span><br><span>@@ -1593,7 +1585,7 @@</span><br><span>     icmp6o=
ut.icmp6_type =3D OPENVPN_ICMP6_DESTINATION_UNREACHABLE;</span><br><span>  =
   icmp6out.icmp6_code =3D OPENVPN_ICMP6_DU_NOROUTE;</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    int icmpheader_len =3D=
 sizeof(struct openvpn_ipv6hdr) + sizeof(struct openvpn_icmp6hdr);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    const int icmpheader_len=
 =3D sizeof(struct openvpn_ipv6hdr) + sizeof(struct openvpn_icmp6hdr);</spa=
n><br><span>     int totalheader_len =3D icmpheader_len;</span><br><span> <=
/span><br><span>     if (TUNNEL_TYPE(c-&gt;c1.tuntap) =3D=3D DEV_TYPE_TAP)<=
/span><br><span>@@ -1606,10 +1598,11 @@</span><br><span>      * frame shoul=
d be &lt;=3D 1280 and have as much as possible of the original</span><br><s=
pan>      * packet</span><br><span>      */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    int max_payload_size =3D min_int(MAX_ICMPV6LEN, c=
-&gt;c2.frame.tun_mtu - icmpheader_len);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int payload_len =3D min_int(max_payload_size, BLEN(&=
amp;inputipbuf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  const int max_payload_size =3D min_int(MAX_ICMPV6LEN, c-&gt;c2.frame.tun_=
mtu - icmpheader_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const int payload_len =3D min_int(max_payload_size, BLEN(&amp;inputi=
pbuf));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ui=
nt16_t icmp_len =3D (uint16_t)(sizeof(struct openvpn_icmp6hdr) + payload_le=
n);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    pip6out.payload_len =3D htons(sizeof(struct openvpn_icmp6hdr) + payload=
_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    pip6out.p=
ayload_len =3D htons(icmp_len);</span><br><span> </span><br><span>     /* C=
onstruct the packet as outgoing packet back to the client */</span><br><spa=
n>     struct buffer *outbuf;</span><br><span>@@ -1665,10 +1658,6 @@</span>=
<br><span> #undef MAX_ICMPV6LEN</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || def=
ined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragm=
a GCC diagnostic pop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
> void</span><br><span> process_ip_header(struct context *c, unsigned int f=
lags, struct buffer *buf,</span><br><span>                   struct link_so=
cket *sock)</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/1472?usp=3Demail">change 1472</a>. To =
unsubscribe, or for help writing mail filters, visit <a href=3D"http://gerr=
it.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1472?usp=3Demail"/><meta itemprop=3D"name=
" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I701f9e0a96a7b43f278f8e6089e=
9156feab772c8 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1472 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--wCwtLC9g670=--

