From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 24 Sep 2025 15:04:24 +0000
In-Reply-To: <gerrit.1756814708000.Ica721a51b00d5314125bcaf5a586e718c5982aef@...2715...>
References: <gerrit.1756814708000.Ica721a51b00d5314125bcaf5a586e718c5982aef@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <b237d380bf5cd88adbe4563768f4c79aa059e8f9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="yVZLU1Glhpc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: proto: Clean up
 conversion warnings related to checksum macros
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

--yVZLU1Glhpc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1164?usp=3Demail

to look at the new patch set (#4).


Change subject: proto: Clean up conversion warnings related to checksum mac=
ros
......................................................................

proto: Clean up conversion warnings related to checksum macros

These should not change any behavior, they mostly clarify
the used types and silence warnings, since these casts are
deliberate.

Change-Id: Ica721a51b00d5314125bcaf5a586e718c5982aef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/clinat.c
M src/openvpn/mss.c
M src/openvpn/proto.h
3 files changed, 36 insertions(+), 51 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/1164/4

diff --git a/src/openvpn/clinat.c b/src/openvpn/clinat.c
index b49d4bb..7751a47 100644
--- a/src/openvpn/clinat.c
+++ b/src/openvpn/clinat.c
@@ -185,11 +185,7 @@
                      const int direction)
 {
     struct ip_tcp_udp_hdr *h =3D (struct ip_tcp_udp_hdr *)BPTR(ipbuf);
-    int i;
-    uint32_t addr, *addr_ptr;
-    const uint32_t *from, *to;
-    int accumulate =3D 0;
-    unsigned int amask;
+    int32_t accumulate =3D 0;
     unsigned int alog =3D 0;

     if (check_debug_level(D_CLIENT_NAT))
@@ -197,8 +193,11 @@
         print_pkt(&h->ip, "BEFORE", direction, D_CLIENT_NAT);
     }

-    for (i =3D 0; i < list->n; ++i)
+    for (int i =3D 0; i < list->n; ++i)
     {
+        uint32_t addr, *addr_ptr;
+        const uint32_t *from, *to;
+        unsigned int amask;
         const struct client_nat_entry *e =3D &list->entries[i]; /* current=
 NAT rule */
         if (e->type ^ direction)
         {
diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c
index e7111a8..10d61d1 100644
--- a/src/openvpn/mss.c
+++ b/src/openvpn/mss.c
@@ -130,11 +130,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 /*
  * change TCP MSS option in SYN/SYN-ACK packets, if present
  * this is generic for IPv4 and IPv6, as the TCP header is the same
@@ -143,11 +138,8 @@
 void
 mss_fixup_dowork(struct buffer *buf, uint16_t maxmss)
 {
-    int hlen, olen, optlen;
+    int olen, optlen;
     uint8_t *opt;
-    uint16_t mssval;
-    int accumulate;
-    struct openvpn_tcphdr *tc;

     if (BLEN(buf) < (int)sizeof(struct openvpn_tcphdr))
     {
@@ -155,8 +147,8 @@
     }

     verify_align_4(buf);
-    tc =3D (struct openvpn_tcphdr *)BPTR(buf);
-    hlen =3D OPENVPN_TCPH_GET_DOFF(tc->doff_res);
+    struct openvpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(buf);
+    int hlen =3D OPENVPN_TCPH_GET_DOFF(tc->doff_res);

     /* Invalid header length or header without options. */
     if (hlen <=3D (int)sizeof(struct openvpn_tcphdr) || hlen > BLEN(buf))
@@ -171,43 +163,37 @@
         {
             break;
         }
-        else if (*opt =3D=3D OPENVPN_TCPOPT_NOP)
+        if (*opt =3D=3D OPENVPN_TCPOPT_NOP)
         {
             optlen =3D 1;
+            continue;
         }
-        else
+
+        optlen =3D *(opt + 1);
+        if (optlen <=3D 0 || optlen > olen)
         {
-            optlen =3D *(opt + 1);
-            if (optlen <=3D 0 || optlen > olen)
+            break;
+        }
+        if (*opt =3D=3D OPENVPN_TCPOPT_MAXSEG)
+        {
+            if (optlen !=3D OPENVPN_TCPOLEN_MAXSEG)
             {
-                break;
+                continue;
             }
-            if (*opt =3D=3D OPENVPN_TCPOPT_MAXSEG)
+            uint16_t mssval =3D (uint16_t)(opt[2] << 8) + opt[3];
+            if (mssval > maxmss)
             {
-                if (optlen !=3D OPENVPN_TCPOLEN_MAXSEG)
-                {
-                    continue;
-                }
-                mssval =3D opt[2] << 8;
-                mssval +=3D opt[3];
-                if (mssval > maxmss)
-                {
-                    dmsg(D_MSS, "MSS: %" PRIu16 " -> %" PRIu16, mssval, ma=
xmss);
-                    accumulate =3D htons(mssval);
-                    opt[2] =3D (uint8_t)((maxmss >> 8) & 0xff);
-                    opt[3] =3D (uint8_t)(maxmss & 0xff);
-                    accumulate -=3D htons(maxmss);
-                    ADJUST_CHECKSUM(accumulate, tc->check);
-                }
+                dmsg(D_MSS, "MSS: %" PRIu16 " -> %" PRIu16, mssval, maxmss=
);
+                opt[2] =3D (uint8_t)((maxmss >> 8) & 0xff);
+                opt[3] =3D (uint8_t)(maxmss & 0xff);
+                int32_t accumulate =3D htons(mssval);
+                accumulate -=3D htons(maxmss);
+                ADJUST_CHECKSUM(accumulate, tc->check);
             }
         }
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 static inline size_t
 adjust_payload_max_cbc(const struct key_type *kt, size_t target)
 {
diff --git a/src/openvpn/proto.h b/src/openvpn/proto.h
index 62157fa..94952bd 100644
--- a/src/openvpn/proto.h
+++ b/src/openvpn/proto.h
@@ -214,7 +214,7 @@
  */
 #define ADJUST_CHECKSUM(acc, cksum)                \
     {                                              \
-        int _acc =3D acc;                            \
+        int32_t _acc =3D acc;                        \
         _acc +=3D (cksum);                           \
         if (_acc < 0)                              \
         {                                          \
@@ -231,16 +231,16 @@
         }                                          \
     }

-#define ADD_CHECKSUM_32(acc, u32) \
-    {                             \
-        acc +=3D (u32) & 0xffff;    \
-        acc +=3D (u32) >> 16;       \
+#define ADD_CHECKSUM_32(acc, u32)         \
+    {                                     \
+        acc +=3D (int32_t)((u32) & 0xffff); \
+        acc +=3D (int32_t)((u32) >> 16);    \
     }

-#define SUB_CHECKSUM_32(acc, u32) \
-    {                             \
-        acc -=3D (u32) & 0xffff;    \
-        acc -=3D (u32) >> 16;       \
+#define SUB_CHECKSUM_32(acc, u32)         \
+    {                                     \
+        acc -=3D (int32_t)((u32) & 0xffff); \
+        acc -=3D (int32_t)((u32) >> 16);    \
     }

 /*

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1164?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ica721a51b00d5314125bcaf5a586e718c5982aef
Gerrit-Change-Number: 1164
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--yVZLU1Glhpc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1164?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">proto: Clean up conversion warnings related to checksum macros<br=
><br>These should not change any behavior, they mostly clarify<br>the used =
types and silence warnings, since these casts are<br>deliberate.<br><br>Cha=
nge-Id: Ica721a51b00d5314125bcaf5a586e718c5982aef<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/clinat.c<br>M s=
rc/openvpn/mss.c<br>M src/openvpn/proto.h<br>3 files changed, 36 insertions=
(+), 51 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/64/1164/4</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/clinat.c b/src/=
openvpn/clinat.c</span><br><span>index b49d4bb..7751a47 100644</span><br><s=
pan>--- a/src/openvpn/clinat.c</span><br><span>+++ b/src/openvpn/clinat.c</=
span><br><span>@@ -185,11 +185,7 @@</span><br><span>                      c=
onst int direction)</span><br><span> {</span><br><span>     struct ip_tcp_u=
dp_hdr *h =3D (struct ip_tcp_udp_hdr *)BPTR(ipbuf);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    uint32_t addr, *addr_ptr;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    const uint32_t *from, *to;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int accumulate =3D 0;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int amask;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    int32_t accumulate =3D 0;=
</span><br><span>     unsigned int alog =3D 0;</span><br><span> </span><br>=
<span>     if (check_debug_level(D_CLIENT_NAT))</span><br><span>@@ -197,8 +=
193,11 @@</span><br><span>         print_pkt(&amp;h-&gt;ip, &quot;BEFORE&qu=
ot;, direction, D_CLIENT_NAT);</span><br><span>     }</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; =
list-&gt;n; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 for (int i =3D 0; i &lt; list-&gt;n; ++i)</span><br><span>     {</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        uint32_t addr, *addr_=
ptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        const u=
int32_t *from, *to;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        unsigned int amask;</span><br><span>         const struct client_na=
t_entry *e =3D &amp;list-&gt;entries[i]; /* current NAT rule */</span><br><=
span>         if (e-&gt;type ^ direction)</span><br><span>         {</span>=
<br><span>diff --git a/src/openvpn/mss.c b/src/openvpn/mss.c</span><br><spa=
n>index e7111a8..10d61d1 100644</span><br><span>--- a/src/openvpn/mss.c</sp=
an><br><span>+++ b/src/openvpn/mss.c</span><br><span>@@ -130,11 +130,6 @@</=
span><br><span>     }</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__cla=
ng__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diag=
nostic push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GC=
C diagnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span> /*</span><br><span>  * change TCP MSS option in =
SYN/SYN-ACK packets, if present</span><br><span>  * this is generic for IPv=
4 and IPv6, as the TCP header is the same</span><br><span>@@ -143,11 +138,8=
 @@</span><br><span> void</span><br><span> mss_fixup_dowork(struct buffer *=
buf, uint16_t maxmss)</span><br><span> {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    int hlen, olen, optlen;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    int olen, optlen;</span><br><span>     uint8=
_t *opt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint16_t =
mssval;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int accumu=
late;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    struct openv=
pn_tcphdr *tc;</span><br><span> </span><br><span>     if (BLEN(buf) &lt; (i=
nt)sizeof(struct openvpn_tcphdr))</span><br><span>     {</span><br><span>@@=
 -155,8 +147,8 @@</span><br><span>     }</span><br><span> </span><br><span>=
     verify_align_4(buf);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    tc =3D (struct openvpn_tcphdr *)BPTR(buf);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    hlen =3D OPENVPN_TCPH_GET_DOFF(tc-&gt;doff=
_res);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct op=
envpn_tcphdr *tc =3D (struct openvpn_tcphdr *)BPTR(buf);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    int hlen =3D OPENVPN_TCPH_GET_DOFF=
(tc-&gt;doff_res);</span><br><span> </span><br><span>     /* Invalid header=
 length or header without options. */</span><br><span>     if (hlen &lt;=3D=
 (int)sizeof(struct openvpn_tcphdr) || hlen &gt; BLEN(buf))</span><br><span=
>@@ -171,43 +163,37 @@</span><br><span>         {</span><br><span>         =
    break;</span><br><span>         }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        else if (*opt =3D=3D OPENVPN_TCPOPT_NOP)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (*opt =3D=3D OPENVP=
N_TCPOPT_NOP)</span><br><span>         {</span><br><span>             optle=
n =3D 1;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 continue;</span><br><span>         }</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        else</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        op=
tlen =3D *(opt + 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (optlen &lt;=3D 0 || optlen &gt; olen)</span><br><span>        =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            optlen =
=3D *(opt + 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (optlen &lt;=3D 0 || optlen &gt; olen)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            break;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (*opt =3D=3D OPENVPN_TCPOPT_MAXSEG)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            if (optlen !=3D OPENVPN_TCPOL=
EN_MAXSEG)</span><br><span>             {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                break;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                continue;</span><br><span>          =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (*=
opt =3D=3D OPENVPN_TCPOPT_MAXSEG)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            uint16_t mssval =3D (uint16_t)(opt[2] &lt;&lt; 8)=
 + opt[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   if (mssval &gt; maxmss)</span><br><span>             {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                if (optlen !=3D OPENVPN=
_TCPOLEN_MAXSEG)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
           continue;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           mssval =3D opt[2] &lt;&lt; 8;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                mssval +=3D opt[3];</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                if (mssval &gt; maxmss)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-                    dmsg(D_M=
SS, &quot;MSS: %&quot; PRIu16 &quot; -&gt; %&quot; PRIu16, mssval, maxmss);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    a=
ccumulate =3D htons(mssval);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-                    opt[2] =3D (uint8_t)((maxmss &gt;&gt; 8) &amp; 0=
xff);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                =
    opt[3] =3D (uint8_t)(maxmss &amp; 0xff);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                    accumulate -=3D htons(maxmss);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-                    ADJ=
UST_CHECKSUM(accumulate, tc-&gt;check);</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                dmsg(D_MSS, &quot;MSS: %&quot; PRIu16 &quot=
; -&gt; %&quot; PRIu16, mssval, maxmss);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                opt[2] =3D (uint8_t)((maxmss &gt;&gt; =
8) &amp; 0xff);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
            opt[3] =3D (uint8_t)(maxmss &amp; 0xff);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                int32_t accumulate =3D ht=
ons(mssval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
         accumulate -=3D htons(maxmss);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                ADJUST_CHECKSUM(accumulate, tc-&gt;chec=
k);</span><br><span>             }</span><br><span>         }</span><br><sp=
an>     }</span><br><span> }</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> static inline size_t=
</span><br><span> adjust_payload_max_cbc(const struct key_type *kt, size_t =
target)</span><br><span> {</span><br><span>diff --git a/src/openvpn/proto.h=
 b/src/openvpn/proto.h</span><br><span>index 62157fa..94952bd 100644</span>=
<br><span>--- a/src/openvpn/proto.h</span><br><span>+++ b/src/openvpn/proto=
.h</span><br><span>@@ -214,7 +214,7 @@</span><br><span>  */</span><br><span=
> #define ADJUST_CHECKSUM(acc, cksum)                \</span><br><span>    =
 {                                              \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        int _acc =3D acc;                      =
      \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int3=
2_t _acc =3D acc;                        \</span><br><span>         _acc +=
=3D (cksum);                           \</span><br><span>         if (_acc =
&lt; 0)                              \</span><br><span>         {          =
                                \</span><br><span>@@ -231,16 +231,16 @@</sp=
an><br><span>         }                                          \</span><b=
r><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#define ADD_CHECKSUM_32(acc, u32) \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    {                             \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        acc +=3D (u32) &amp; 0xffff;=
    \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        acc +=3D=
 (u32) &gt;&gt; 16;       \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#define ADD_CHECKSUM_32(acc, u32)         \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    {                                    =
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        acc +=3D =
(int32_t)((u32) &amp; 0xffff); \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        acc +=3D (int32_t)((u32) &gt;&gt; 16);    \</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#define SUB_CHECKSUM_32(acc, u32) \</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    {                             \</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        acc -=3D (u32) &amp; 0xffff;  =
  \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        acc -=3D (=
u32) &gt;&gt; 16;       \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#define SUB_CHECKSUM_32(acc, u32)         \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    {                                     \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        acc -=3D (int=
32_t)((u32) &amp; 0xffff); \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        acc -=3D (int32_t)((u32) &gt;&gt; 16);    \</span><br><spa=
n>     }</span><br><span> </span><br><span> /*</span><br><span></span><br><=
/pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/116=
4?usp=3Demail">change 1164</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1164?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ica721a51b00d5314125bcaf5a58=
6e718c5982aef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1164 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--yVZLU1Glhpc=--

