From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 16:04:31 +0000
References: <gerrit.1769443458000.I68c8ebb593262116b42b4c749d4aed3078f8499b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d97b43d54d4bd327fd6e817f3f388a19765263e0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kfmw6+IgGGo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Change signedness of
 constants to avoid sign-compare issues
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

--kfmw6+IgGGo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1490?usp=3Demail

to review the following change.


Change subject: Change signedness of constants to avoid sign-compare issues
......................................................................

Change signedness of constants to avoid sign-compare issues

Improve conditionals where we want to ensure that
a signed int is greater than a unsigned constant int
by forcing the comparison to be signed (instead
of the default unsigned comparison).
This avoids the potential corner case where the
integer might falsely compare as bigger due to being
negative.

Even if we know the comparison to be safe already, we
still need the cast to suppress -Wsign-compare errors.

Change-Id: I68c8ebb593262116b42b4c749d4aed3078f8499b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/clinat.c
M src/openvpn/forward.c
M src/openvpn/networking_sitnl.c
M src/openvpn/proto.c
M src/openvpn/push.c
M src/openvpn/ssl_pkt.c
M src/openvpn/tls_crypt.c
M src/openvpn/tun.h
M src/openvpn/vlan.c
9 files changed, 22 insertions(+), 22 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1490/1

diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index f671fee..fb8e497 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -249,14 +249,14 @@

         if (h->ip.protocol =3D=3D OPENVPN_IPPROTO_TCP)
         {
-            if (BLEN(ipbuf) >=3D sizeof(struct openvpn_iphdr) + sizeof(str=
uct openvpn_tcphdr))
+            if (BLEN(ipbuf) >=3D (int)(sizeof(struct openvpn_iphdr) + size=
of(struct openvpn_tcphdr)))
             {
                 ADJUST_CHECKSUM(accumulate, h->u.tcp.check);
             }
         }
         else if (h->ip.protocol =3D=3D OPENVPN_IPPROTO_UDP)
         {
-            if (BLEN(ipbuf) >=3D sizeof(struct openvpn_iphdr) + sizeof(str=
uct openvpn_udphdr))
+            if (BLEN(ipbuf) >=3D (int)(sizeof(struct openvpn_iphdr) + size=
of(struct openvpn_udphdr)))
             {
                 ADJUST_CHECKSUM(accumulate, h->u.udp.check);
             }
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 5004e35..edb91fe 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1386,7 +1386,7 @@
         struct openvpn_iphdr *pip =3D (struct openvpn_iphdr *)(BPTR(buf) +=
 ip_hdr_offset);
         const int ip_hlen =3D OPENVPN_IPH_GET_LEN(pip->version_len);
         /* Reject malformed or truncated headers */
-        if (ip_hlen < sizeof(struct openvpn_iphdr)
+        if (ip_hlen < (int)sizeof(struct openvpn_iphdr)
             || BLEN(buf) < (int)(ip_hdr_offset + ip_hlen + sizeof(uint16_t=
) * 2))
         {
             return;
diff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c
index a5b2905..b4232f6 100644
--- a/src/openvpn/networking_sitnl.c
+++ b/src/openvpn/networking_sitnl.c
@@ -388,7 +388,7 @@
             if (h->nlmsg_type =3D=3D NLMSG_ERROR)
             {
                 err =3D (struct nlmsgerr *)NLMSG_DATA(h);
-                if (rem_len < sizeof(struct nlmsgerr))
+                if (rem_len < (int)sizeof(struct nlmsgerr))
                 {
                     msg(M_WARN, "%s: ERROR truncated", __func__);
                     ret =3D -EIO;
diff --git a/src/openvpn/proto.c b/src/openvpn/proto.c
index a55a2ae..8a01d00 100644
--- a/src/openvpn/proto.c
+++ b/src/openvpn/proto.c
@@ -45,7 +45,7 @@
     verify_align_4(buf);
     if (tunnel_type =3D=3D DEV_TYPE_TUN)
     {
-        if (BLEN(buf) < sizeof(struct openvpn_iphdr))
+        if (BLEN(buf) < (int)sizeof(struct openvpn_iphdr))
         {
             return false;
         }
@@ -54,7 +54,7 @@
     else if (tunnel_type =3D=3D DEV_TYPE_TAP)
     {
         const struct openvpn_ethhdr *eh;
-        if (BLEN(buf) < (sizeof(struct openvpn_ethhdr) + sizeof(struct ope=
nvpn_iphdr)))
+        if (BLEN(buf) < (int)(sizeof(struct openvpn_ethhdr) + sizeof(struc=
t openvpn_iphdr)))
         {
             return false;
         }
@@ -70,7 +70,7 @@
         if (proto =3D=3D htons(OPENVPN_ETH_P_8021Q))
         {
             const struct openvpn_8021qhdr *evh;
-            if (BLEN(buf) < (sizeof(struct openvpn_ethhdr) + sizeof(struct=
 openvpn_iphdr)))
+            if (BLEN(buf) < (int)(sizeof(struct openvpn_ethhdr) + sizeof(s=
truct openvpn_iphdr)))
             {
                 return false;
             }
diff --git a/src/openvpn/push.c b/src/openvpn/push.c
index 25df48d..e328d9b 100644
--- a/src/openvpn/push.c
+++ b/src/openvpn/push.c
@@ -829,7 +829,7 @@
         buf_printf(&buf, ",push-continuation 1");
     }

-    if (BLEN(&buf) > sizeof(push_reply_cmd) - 1)
+    if (BLEN(&buf) >=3D (int)sizeof(push_reply_cmd))
     {
         const bool status =3D send_control_channel_string(c, BSTR(&buf), D=
_PUSH);
         if (!status)
diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pkt.c
index 4e97ae4..90ac5ab 100644
--- a/src/openvpn/ssl_pkt.c
+++ b/src/openvpn/ssl_pkt.c
@@ -298,7 +298,7 @@
 {
     struct gc_arena gc =3D gc_new();
     /* A packet needs to have at least an opcode and session id */
-    if (buf->len < (1 + SID_SIZE))
+    if (buf->len < (int)(1 + SID_SIZE))
     {
         dmsg(D_TLS_STATE_ERRORS, "TLS State Error: Too short packet (lengt=
h  %d) received from %s",
              buf->len, print_link_socket_actual(from, &gc));
diff --git a/src/openvpn/tls_crypt.c b/src/openvpn/tls_crypt.c
index 2b00e1c..730c20d 100644
--- a/src/openvpn/tls_crypt.c
+++ b/src/openvpn/tls_crypt.c
@@ -222,7 +222,7 @@

     dmsg(D_PACKET_CONTENT, "TLS-CRYPT UNWRAP FROM: %s", format_hex(BPTR(sr=
c), BLEN(src), 80, &gc));

-    if (buf_len(src) < TLS_CRYPT_OFF_CT)
+    if (buf_len(src) < (int)TLS_CRYPT_OFF_CT)
     {
         CRYPT_ERROR("packet too short");
     }
@@ -441,7 +441,7 @@
     uint16_t net_len =3D 0;
     const uint8_t *tag =3D BPTR(&wrapped_client_key);

-    if (BLEN(&wrapped_client_key) < sizeof(net_len))
+    if (BLEN(&wrapped_client_key) < (int)sizeof(net_len))
     {
         CRYPT_ERROR("failed to read length");
     }
@@ -496,7 +496,7 @@
                              "a different tls-crypt-v2 server key)");
     }

-    if (buf_len(&plaintext) < sizeof(client_key->keys))
+    if (buf_len(&plaintext) < (int)sizeof(client_key->keys))
     {
         CRYPT_ERROR("failed to read client key");
     }
@@ -523,7 +523,7 @@
 static bool
 tls_crypt_v2_check_client_key_age(const struct tls_wrap_ctx *ctx, int max_=
days)
 {
-    if (ctx->tls_crypt_v2_metadata.len < 1 + sizeof(int64_t))
+    if (ctx->tls_crypt_v2_metadata.len < 1 + (int)sizeof(int64_t))
     {
         msg(M_WARN, "ERROR: Client key metadata is too small to contain a =
timestamp.");
         return false;
@@ -619,7 +619,7 @@
     struct buffer wrapped_client_key =3D *buf;
     uint16_t net_len =3D 0;

-    if (BLEN(&wrapped_client_key) < sizeof(net_len))
+    if (BLEN(&wrapped_client_key) < (int)sizeof(net_len))
     {
         msg(D_TLS_ERRORS, "Can not read tls-crypt-v2 client key length");
         return false;
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 34f4929..a226e37 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -510,14 +510,14 @@

     if (OPENVPN_IPH_GET_VER(ih->version_len) =3D=3D 4)
     {
-        if (BLEN(buf) < sizeof(struct openvpn_iphdr))
+        if (BLEN(buf) < (int)sizeof(struct openvpn_iphdr))
         {
             return false;
         }
     }
     else if (OPENVPN_IPH_GET_VER(ih->version_len) =3D=3D 6)
     {
-        if (BLEN(buf) < sizeof(struct openvpn_ipv6hdr))
+        if (BLEN(buf) < (int)sizeof(struct openvpn_ipv6hdr))
         {
             return false;
         }
diff --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c
index 85a54eb..3b8e4a8 100644
--- a/src/openvpn/vlan.c
+++ b/src/openvpn/vlan.c
@@ -85,7 +85,7 @@
     uint16_t vid;

     /* assume untagged frame */
-    if (BLEN(buf) < sizeof(*ethhdr))
+    if (BLEN(buf) < (int)sizeof(*ethhdr))
     {
         goto drop;
     }
@@ -109,7 +109,7 @@
     }

     /* tagged frame */
-    if (BLEN(buf) < sizeof(*vlanhdr))
+    if (BLEN(buf) < (int)sizeof(*vlanhdr))
     {
         goto drop;
     }
@@ -184,7 +184,7 @@
     const struct openvpn_ethhdr *ethhdr;
     struct openvpn_8021qhdr *vlanhdr;

-    if (BLEN(buf) < sizeof(*ethhdr))
+    if (BLEN(buf) < (int)sizeof(*ethhdr))
     {
         goto drop;
     }
@@ -197,7 +197,7 @@
          */

         /* Frame too small for header type? */
-        if (BLEN(buf) < sizeof(*vlanhdr))
+        if (BLEN(buf) < (int)sizeof(*vlanhdr))
         {
             goto drop;
         }
@@ -216,7 +216,7 @@
         /* Untagged frame. */

         /* Not enough head room for VLAN tag? */
-        if (buf_reverse_capacity(buf) < SIZE_ETH_TO_8021Q_HDR)
+        if (buf_reverse_capacity(buf) < (int)SIZE_ETH_TO_8021Q_HDR)
         {
             goto drop;
         }
@@ -263,7 +263,7 @@
     const struct openvpn_8021qhdr *vlanhdr;
     uint16_t vid;

-    if (BLEN(buf) < sizeof(struct openvpn_8021qhdr))
+    if (BLEN(buf) < (int)sizeof(struct openvpn_8021qhdr))
     {
         /* frame too small to be VLAN-tagged */
         return false;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1490?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I68c8ebb593262116b42b4c749d4aed3078f8499b
Gerrit-Change-Number: 1490
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--kfmw6+IgGGo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1490?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Change signedness of constants to avoid sig=
n-compare issues<br><br>Improve conditionals where we want to ensure that<b=
r>a signed int is greater than a unsigned constant int<br>by forcing the co=
mparison to be signed (instead<br>of the default unsigned comparison).<br>T=
his avoids the potential corner case where the<br>integer might falsely com=
pare as bigger due to being<br>negative.<br><br>Even if we know the compari=
son to be safe already, we<br>still need the cast to suppress -Wsign-compar=
e errors.<br><br>Change-Id: I68c8ebb593262116b42b4c749d4aed3078f8499b<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/ope=
nvpn/clinat.c<br>M src/openvpn/forward.c<br>M src/openvpn/networking_sitnl.=
c<br>M src/openvpn/proto.c<br>M src/openvpn/push.c<br>M src/openvpn/ssl_pkt=
.c<br>M src/openvpn/tls_crypt.c<br>M src/openvpn/tun.h<br>M src/openvpn/vla=
n.c<br>9 files changed, 22 insertions(+), 22 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/90/1=
490/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c</spa=
n><br><span>index f671fee..fb8e497 100644</span><br><span>--- a/src/openvpn=
/clinat.c</span><br><span>+++ b/src/openvpn/clinat.c</span><br><span>@@ -24=
9,14 +249,14 @@</span><br><span> </span><br><span>         if (h-&gt;ip.pro=
tocol =3D=3D OPENVPN_IPPROTO_TCP)</span><br><span>         {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(ipbuf) &gt;=3D =
sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_tcphdr))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (BLEN(ipbuf) &gt;=
=3D (int)(sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_tcphdr)))</s=
pan><br><span>             {</span><br><span>                 ADJUST_CHECKS=
UM(accumulate, h-&gt;u.tcp.check);</span><br><span>             }</span><br=
><span>         }</span><br><span>         else if (h-&gt;ip.protocol =3D=
=3D OPENVPN_IPPROTO_UDP)</span><br><span>         {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            if (BLEN(ipbuf) &gt;=3D sizeof(=
struct openvpn_iphdr) + sizeof(struct openvpn_udphdr))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            if (BLEN(ipbuf) &gt;=3D (int=
)(sizeof(struct openvpn_iphdr) + sizeof(struct openvpn_udphdr)))</span><br>=
<span>             {</span><br><span>                 ADJUST_CHECKSUM(accum=
ulate, h-&gt;u.udp.check);</span><br><span>             }</span><br><span>d=
iff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>i=
ndex 5004e35..edb91fe 100644</span><br><span>--- a/src/openvpn/forward.c</s=
pan><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1386,7 +1386,=
7 @@</span><br><span>         struct openvpn_iphdr *pip =3D (struct openvpn=
_iphdr *)(BPTR(buf) + ip_hdr_offset);</span><br><span>         const int ip=
_hlen =3D OPENVPN_IPH_GET_LEN(pip-&gt;version_len);</span><br><span>       =
  /* Reject malformed or truncated headers */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-        if (ip_hlen &lt; sizeof(struct openvpn_iphd=
r)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (ip_hl=
en &lt; (int)sizeof(struct openvpn_iphdr)</span><br><span>             || B=
LEN(buf) &lt; (int)(ip_hdr_offset + ip_hlen + sizeof(uint16_t) * 2))</span>=
<br><span>         {</span><br><span>             return;</span><br><span>d=
iff --git a/src/openvpn/networking_sitnl.c b/src/openvpn/networking_sitnl.c=
</span><br><span>index a5b2905..b4232f6 100644</span><br><span>--- a/src/op=
envpn/networking_sitnl.c</span><br><span>+++ b/src/openvpn/networking_sitnl=
.c</span><br><span>@@ -388,7 +388,7 @@</span><br><span>             if (h-&=
gt;nlmsg_type =3D=3D NLMSG_ERROR)</span><br><span>             {</span><br>=
<span>                 err =3D (struct nlmsgerr *)NLMSG_DATA(h);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-                if (rem_len &lt;=
 sizeof(struct nlmsgerr))</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                if (rem_len &lt; (int)sizeof(struct nlmsgerr))</span>=
<br><span>                 {</span><br><span>                     msg(M_WAR=
N, &quot;%s: ERROR truncated&quot;, __func__);</span><br><span>            =
         ret =3D -EIO;</span><br><span>diff --git a/src/openvpn/proto.c b/s=
rc/openvpn/proto.c</span><br><span>index a55a2ae..8a01d00 100644</span><br>=
<span>--- a/src/openvpn/proto.c</span><br><span>+++ b/src/openvpn/proto.c</=
span><br><span>@@ -45,7 +45,7 @@</span><br><span>     verify_align_4(buf);<=
/span><br><span>     if (tunnel_type =3D=3D DEV_TYPE_TUN)</span><br><span> =
    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN=
(buf) &lt; sizeof(struct openvpn_iphdr))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (BLEN(buf) &lt; (int)sizeof(struct openvpn_=
iphdr))</span><br><span>         {</span><br><span>             return fals=
e;</span><br><span>         }</span><br><span>@@ -54,7 +54,7 @@</span><br><=
span>     else if (tunnel_type =3D=3D DEV_TYPE_TAP)</span><br><span>     {<=
/span><br><span>         const struct openvpn_ethhdr *eh;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt; (sizeof(stru=
ct openvpn_ethhdr) + sizeof(struct openvpn_iphdr)))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (BLEN(buf) &lt; (int)(sizeof(s=
truct openvpn_ethhdr) + sizeof(struct openvpn_iphdr)))</span><br><span>    =
     {</span><br><span>             return false;</span><br><span>         =
}</span><br><span>@@ -70,7 +70,7 @@</span><br><span>         if (proto =3D=
=3D htons(OPENVPN_ETH_P_8021Q))</span><br><span>         {</span><br><span>=
             const struct openvpn_8021qhdr *evh;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            if (BLEN(buf) &lt; (sizeof(struct op=
envpn_ethhdr) + sizeof(struct openvpn_iphdr)))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            if (BLEN(buf) &lt; (int)(sizeof(stru=
ct openvpn_ethhdr) + sizeof(struct openvpn_iphdr)))</span><br><span>       =
      {</span><br><span>                 return false;</span><br><span>    =
         }</span><br><span>diff --git a/src/openvpn/push.c b/src/openvpn/pu=
sh.c</span><br><span>index 25df48d..e328d9b 100644</span><br><span>--- a/sr=
c/openvpn/push.c</span><br><span>+++ b/src/openvpn/push.c</span><br><span>@=
@ -829,7 +829,7 @@</span><br><span>         buf_printf(&amp;buf, &quot;,pus=
h-continuation 1&quot;);</span><br><span>     }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (BLEN(&amp;buf) &gt; siz=
eof(push_reply_cmd) - 1)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    if (BLEN(&amp;buf) &gt;=3D (int)sizeof(push_reply_cmd))</span><br>=
<span>     {</span><br><span>         const bool status =3D send_control_ch=
annel_string(c, BSTR(&amp;buf), D_PUSH);</span><br><span>         if (!stat=
us)</span><br><span>diff --git a/src/openvpn/ssl_pkt.c b/src/openvpn/ssl_pk=
t.c</span><br><span>index 4e97ae4..90ac5ab 100644</span><br><span>--- a/src=
/openvpn/ssl_pkt.c</span><br><span>+++ b/src/openvpn/ssl_pkt.c</span><br><s=
pan>@@ -298,7 +298,7 @@</span><br><span> {</span><br><span>     struct gc_a=
rena gc =3D gc_new();</span><br><span>     /* A packet needs to have at lea=
st an opcode and session id */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (buf-&gt;len &lt; (1 + SID_SIZE))</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (buf-&gt;len &lt; (int)(1 + SID_SIZE))=
</span><br><span>     {</span><br><span>         dmsg(D_TLS_STATE_ERRORS, &=
quot;TLS State Error: Too short packet (length  %d) received from %s&quot;,=
</span><br><span>              buf-&gt;len, print_link_socket_actual(from, =
&amp;gc));</span><br><span>diff --git a/src/openvpn/tls_crypt.c b/src/openv=
pn/tls_crypt.c</span><br><span>index 2b00e1c..730c20d 100644</span><br><spa=
n>--- a/src/openvpn/tls_crypt.c</span><br><span>+++ b/src/openvpn/tls_crypt=
.c</span><br><span>@@ -222,7 +222,7 @@</span><br><span> </span><br><span>  =
   dmsg(D_PACKET_CONTENT, &quot;TLS-CRYPT UNWRAP FROM: %s&quot;, format_hex=
(BPTR(src), BLEN(src), 80, &amp;gc));</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (buf_len(src) &lt; TLS_CRYPT_OFF_C=
T)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(s=
rc) &lt; (int)TLS_CRYPT_OFF_CT)</span><br><span>     {</span><br><span>    =
     CRYPT_ERROR(&quot;packet too short&quot;);</span><br><span>     }</spa=
n><br><span>@@ -441,7 +441,7 @@</span><br><span>     uint16_t net_len =3D 0=
;</span><br><span>     const uint8_t *tag =3D BPTR(&amp;wrapped_client_key)=
;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (BLEN(&amp;wrapped_client_key) &lt; sizeof(net_len))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (BLEN(&amp;wrapped_client_key)=
 &lt; (int)sizeof(net_len))</span><br><span>     {</span><br><span>        =
 CRYPT_ERROR(&quot;failed to read length&quot;);</span><br><span>     }</sp=
an><br><span>@@ -496,7 +496,7 @@</span><br><span>                          =
    &quot;a different tls-crypt-v2 server key)&quot;);</span><br><span>    =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (buf_len(&amp;plaintext) &lt; sizeof(client_key-&gt;keys))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (buf_len(&amp;plaintext=
) &lt; (int)sizeof(client_key-&gt;keys))</span><br><span>     {</span><br><=
span>         CRYPT_ERROR(&quot;failed to read client key&quot;);</span><br=
><span>     }</span><br><span>@@ -523,7 +523,7 @@</span><br><span> static b=
ool</span><br><span> tls_crypt_v2_check_client_key_age(const struct tls_wra=
p_ctx *ctx, int max_days)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    if (ctx-&gt;tls_crypt_v2_metadata.len &lt; 1 + s=
izeof(int64_t))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
if (ctx-&gt;tls_crypt_v2_metadata.len &lt; 1 + (int)sizeof(int64_t))</span>=
<br><span>     {</span><br><span>         msg(M_WARN, &quot;ERROR: Client k=
ey metadata is too small to contain a timestamp.&quot;);</span><br><span>  =
       return false;</span><br><span>@@ -619,7 +619,7 @@</span><br><span>  =
   struct buffer wrapped_client_key =3D *buf;</span><br><span>     uint16_t=
 net_len =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (BLEN(&amp;wrapped_client_key) &lt; sizeof(net_len))</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLEN(&amp;wrapp=
ed_client_key) &lt; (int)sizeof(net_len))</span><br><span>     {</span><br>=
<span>         msg(D_TLS_ERRORS, &quot;Can not read tls-crypt-v2 client key=
 length&quot;);</span><br><span>         return false;</span><br><span>diff=
 --git a/src/openvpn/tun.h b/src/openvpn/tun.h</span><br><span>index 34f492=
9..a226e37 100644</span><br><span>--- a/src/openvpn/tun.h</span><br><span>+=
++ b/src/openvpn/tun.h</span><br><span>@@ -510,14 +510,14 @@</span><br><spa=
n> </span><br><span>     if (OPENVPN_IPH_GET_VER(ih-&gt;version_len) =3D=3D=
 4)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (BLEN(buf) &lt; sizeof(struct openvpn_iphdr))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        if (BLEN(buf) &lt; (int)s=
izeof(struct openvpn_iphdr))</span><br><span>         {</span><br><span>   =
          return false;</span><br><span>         }</span><br><span>     }</=
span><br><span>     else if (OPENVPN_IPH_GET_VER(ih-&gt;version_len) =3D=3D=
 6)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        if (BLEN(buf) &lt; sizeof(struct openvpn_ipv6hdr))</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        if (BLEN(buf) &lt; (int=
)sizeof(struct openvpn_ipv6hdr))</span><br><span>         {</span><br><span=
>             return false;</span><br><span>         }</span><br><span>diff=
 --git a/src/openvpn/vlan.c b/src/openvpn/vlan.c</span><br><span>index 85a5=
4eb..3b8e4a8 100644</span><br><span>--- a/src/openvpn/vlan.c</span><br><spa=
n>+++ b/src/openvpn/vlan.c</span><br><span>@@ -85,7 +85,7 @@</span><br><spa=
n>     uint16_t vid;</span><br><span> </span><br><span>     /* assume untag=
ged frame */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (B=
LEN(buf) &lt; sizeof(*ethhdr))</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (BLEN(buf) &lt; (int)sizeof(*ethhdr))</span><br><span>   =
  {</span><br><span>         goto drop;</span><br><span>     }</span><br><s=
pan>@@ -109,7 +109,7 @@</span><br><span>     }</span><br><span> </span><br>=
<span>     /* tagged frame */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (BLEN(buf) &lt; sizeof(*vlanhdr))</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (BLEN(buf) &lt; (int)sizeof(*vlanhdr))<=
/span><br><span>     {</span><br><span>         goto drop;</span><br><span>=
     }</span><br><span>@@ -184,7 +184,7 @@</span><br><span>     const struc=
t openvpn_ethhdr *ethhdr;</span><br><span>     struct openvpn_8021qhdr *vla=
nhdr;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    if (BLEN(buf) &lt; sizeof(*ethhdr))</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (BLEN(buf) &lt; (int)sizeof(*ethhdr))</span><b=
r><span>     {</span><br><span>         goto drop;</span><br><span>     }</=
span><br><span>@@ -197,7 +197,7 @@</span><br><span>          */</span><br><=
span> </span><br><span>         /* Frame too small for header type? */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (BLEN(buf) &lt;=
 sizeof(*vlanhdr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       if (BLEN(buf) &lt; (int)sizeof(*vlanhdr))</span><br><span>         {=
</span><br><span>             goto drop;</span><br><span>         }</span><=
br><span>@@ -216,7 +216,7 @@</span><br><span>         /* Untagged frame. */=
</span><br><span> </span><br><span>         /* Not enough head room for VLA=
N tag? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (=
buf_reverse_capacity(buf) &lt; SIZE_ETH_TO_8021Q_HDR)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        if (buf_reverse_capacity(buf) &lt=
; (int)SIZE_ETH_TO_8021Q_HDR)</span><br><span>         {</span><br><span>  =
           goto drop;</span><br><span>         }</span><br><span>@@ -263,7 =
+263,7 @@</span><br><span>     const struct openvpn_8021qhdr *vlanhdr;</spa=
n><br><span>     uint16_t vid;</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (BLEN(buf) &lt; sizeof(struct openvpn_802=
1qhdr))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (BLEN=
(buf) &lt; (int)sizeof(struct openvpn_8021qhdr))</span><br><span>     {</sp=
an><br><span>         /* frame too small to be VLAN-tagged */</span><br><sp=
an>         return false;</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1490?usp=3Demail">change=
 1490</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div i=
temscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempro=
p=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"ur=
l" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1490?usp=3Demail"/><meta i=
temprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I68c8ebb593262116b42b4c749d4=
aed3078f8499b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1490 </div>
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

--kfmw6+IgGGo=--

