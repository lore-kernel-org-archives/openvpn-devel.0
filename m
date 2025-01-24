From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 24 Jan 2025 14:08:37 +0000
In-Reply-To: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
References: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <a213abe7935d0190f646a35d01fdb23df576e4d9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="t4Dzt2BJEs8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute: adapt to new
 protocol handling and hashing improvements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, cron2 <gert@...1296...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--t4Dzt2BJEs8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, its_Giaan, ordex=
, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail

to look at the new patch set (#16).

The following approvals got outdated and were removed:
Code-Review-1 by cron2


Change subject: mroute: adapt to new protocol handling and hashing improvem=
ents
......................................................................

mroute: adapt to new protocol handling and hashing improvements

Repurposing an unused field and renaming it to 'proto'
instead of introducing a new field. The hashing now
begins at the 'proto' field rather than the 'type'
field. Additionally, the changes ensure that the
correct protocol is consistently used with virtual
addresses ensuring alignment.

Change-Id: Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
5 files changed, 16 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/765/16

diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 80e18b7..74923cf 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -454,6 +454,7 @@
                 buf_printf(&out, "UNKNOWN");
                 break;
         }
+        buf_printf(&out, "|%d", maddr.proto);
         return BSTR(&out);
     }
     else
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 8b457d4..1c44b35 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -74,7 +74,7 @@

 struct mroute_addr {
     uint8_t len;    /* length of address */
-    uint8_t unused;
+    uint8_t proto;
     uint8_t type;   /* MR_ADDR/MR_WITH flags */
     uint8_t netbits; /* number of bits in network part of address,
                       * valid if MR_WITH_NETBITS is set */
@@ -183,6 +183,15 @@
 {
     unsigned int ret =3D 0;
     verify_align_4(buf);
+
+    /*
+     * Since we don't really need the protocol on vaddresses for internal =
VPN
+     * payload packets, make sure we have the same value to avoid hashing =
insert
+     * and search issues.
+     */
+    src->proto =3D 0;
+    dest->proto =3D src->proto;
+
     if (tunnel_type =3D=3D DEV_TYPE_TUN)
     {
         ret =3D mroute_extract_addr_ip(src, dest, buf);
@@ -216,13 +225,13 @@
 mroute_addr_hash_ptr(const struct mroute_addr *a)
 {
     /* NOTE: depends on ordering of struct mroute_addr */
-    return (uint8_t *) &a->type;
+    return (uint8_t *) &a->proto;
 }

 static inline uint32_t
 mroute_addr_hash_len(const struct mroute_addr *a)
 {
-    return (uint32_t) a->len + 2;
+    return (uint32_t) a->len + 3;
 }

 static inline void
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 6d1d5a0..62ed044 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -56,6 +56,7 @@
     mi =3D multi_create_instance(m, NULL, ls);
     if (mi)
     {
+        mi->real.proto =3D ls->info.proto;
         struct hash_element *he;
         const uint32_t hv =3D hash_value(hash, &mi->real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 6137578..4f2bbd7 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -192,6 +192,7 @@
     struct mroute_addr real =3D {0};
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;
+    real.proto =3D ls->info.proto;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3f55dd7..273aa05 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1243,6 +1243,7 @@
     CLEAR(remote_si);
     remote_si.addr.in4.sin_family =3D AF_INET;
     remote_si.addr.in4.sin_addr.s_addr =3D htonl(a);
+    addr.proto =3D 0;
     ASSERT(mroute_extract_openvpn_sockaddr(&addr, &remote_si, false));

     if (netbits >=3D 0)
@@ -3548,7 +3549,6 @@
         const int dev_type =3D TUNNEL_TYPE(m->top.c1.tuntap);
         int16_t vid =3D 0;

-
 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top.c2.buf));
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab
Gerrit-Change-Number: 765
Gerrit-PatchSet: 16
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--t4Dzt2BJEs8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, its_Giaan, o=
rdex, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #16</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">mroute: adapt to new protocol handling and hashing i=
mprovements<br><br>Repurposing an unused field and renaming it to &#39;prot=
o&#39;<br>instead of introducing a new field. The hashing now<br>begins at =
the &#39;proto&#39; field rather than the &#39;type&#39;<br>field. Addition=
ally, the changes ensure that the<br>correct protocol is consistently used =
with virtual<br>addresses ensuring alignment.<br><br>Change-Id: Ic66eccb505=
8fe9c0fae64d8e2ca88728068a92ab<br>Signed-off-by: Gianmarco De Gregori &lt;g=
ianmarco@...2726...&gt;<br>---<br>M src/openvpn/mroute.c<br>M src/openvpn/m=
route.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M src/openvpn/mu=
lti.c<br>5 files changed, 16 insertions(+), 4 deletions(-)<br><br></pre><pr=
e style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/765/16</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c</span><br><span>inde=
x 80e18b7..74923cf 100644</span><br><span>--- a/src/openvpn/mroute.c</span>=
<br><span>+++ b/src/openvpn/mroute.c</span><br><span>@@ -454,6 +454,7 @@</s=
pan><br><span>                 buf_printf(&amp;out, &quot;UNKNOWN&quot;);</=
span><br><span>                 break;</span><br><span>         }</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, =
&quot;|%d&quot;, maddr.proto);</span><br><span>         return BSTR(&amp;ou=
t);</span><br><span>     }</span><br><span>     else</span><br><span>diff -=
-git a/src/openvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>index 8b=
457d4..1c44b35 100644</span><br><span>--- a/src/openvpn/mroute.h</span><br>=
<span>+++ b/src/openvpn/mroute.h</span><br><span>@@ -74,7 +74,7 @@</span><b=
r><span> </span><br><span> struct mroute_addr {</span><br><span>     uint8_=
t len;    /* length of address */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    uint8_t unused;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    uint8_t proto;</span><br><span>     uint8_t type;   /* MR_A=
DDR/MR_WITH flags */</span><br><span>     uint8_t netbits; /* number of bit=
s in network part of address,</span><br><span>                       * vali=
d if MR_WITH_NETBITS is set */</span><br><span>@@ -183,6 +183,15 @@</span><=
br><span> {</span><br><span>     unsigned int ret =3D 0;</span><br><span>  =
   verify_align_4(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+     * Since we don&#39;t re=
ally need the protocol on vaddresses for internal VPN</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * payload packets, make sure we have=
 the same value to avoid hashing insert</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+     * and search issues.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    src-&gt;proto =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    dest-&gt;proto =3D src-&gt;proto;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (tunnel_type =
=3D=3D DEV_TYPE_TUN)</span><br><span>     {</span><br><span>         ret =
=3D mroute_extract_addr_ip(src, dest, buf);</span><br><span>@@ -216,13 +225=
,13 @@</span><br><span> mroute_addr_hash_ptr(const struct mroute_addr *a)</=
span><br><span> {</span><br><span>     /* NOTE: depends on ordering of stru=
ct mroute_addr */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
return (uint8_t *) &amp;a-&gt;type;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return (uint8_t *) &amp;a-&gt;proto;</span><br><span> }=
</span><br><span> </span><br><span> static inline uint32_t</span><br><span>=
 mroute_addr_hash_len(const struct mroute_addr *a)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    return (uint32_t) a-&gt=
;len + 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return=
 (uint32_t) a-&gt;len + 3;</span><br><span> }</span><br><span> </span><br><=
span> static inline void</span><br><span>diff --git a/src/openvpn/mtcp.c b/=
src/openvpn/mtcp.c</span><br><span>index 6d1d5a0..62ed044 100644</span><br>=
<span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</sp=
an><br><span>@@ -56,6 +56,7 @@</span><br><span>     mi =3D multi_create_ins=
tance(m, NULL, ls);</span><br><span>     if (mi)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;real.pro=
to =3D ls-&gt;info.proto;</span><br><span>         struct hash_element *he;=
</span><br><span>         const uint32_t hv =3D hash_value(hash, &amp;mi-&g=
t;real);</span><br><span>         struct hash_bucket *bucket =3D hash_bucke=
t(hash, hv);</span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/=
mudp.c</span><br><span>index 6137578..4f2bbd7 100644</span><br><span>--- a/=
src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span=
>@@ -192,6 +192,7 @@</span><br><span>     struct mroute_addr real =3D {0};<=
/span><br><span>     struct multi_instance *mi =3D NULL;</span><br><span>  =
   struct hash *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    real.proto =3D ls-&gt;info.proto;</span><br><span> </s=
pan><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&g=
t;top.c2.from.dest, true)</span><br><span>         &amp;&amp; m-&gt;top.c2.=
buf.len &gt; 0)</span><br><span>diff --git a/src/openvpn/multi.c b/src/open=
vpn/multi.c</span><br><span>index 3f55dd7..273aa05 100644</span><br><span>-=
-- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><b=
r><span>@@ -1243,6 +1243,7 @@</span><br><span>     CLEAR(remote_si);</span>=
<br><span>     remote_si.addr.in4.sin_family =3D AF_INET;</span><br><span> =
    remote_si.addr.in4.sin_addr.s_addr =3D htonl(a);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    addr.proto =3D 0;</span><br><span>   =
  ASSERT(mroute_extract_openvpn_sockaddr(&amp;addr, &amp;remote_si, false))=
;</span><br><span> </span><br><span>     if (netbits &gt;=3D 0)</span><br><=
span>@@ -3548,7 +3549,6 @@</span><br><span>         const int dev_type =3D =
TUNNEL_TYPE(m-&gt;top.c1.tuntap);</span><br><span>         int16_t vid =3D =
0;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>         pri=
ntf(&quot;TUN -&gt; TCP/UDP [%d]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf));</sp=
an><br><span> #endif</span><br><span></span><br></pre><p>To view, visit <a =
href=3D"http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail">change 765</=
a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"http=
://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D=
"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtyp=
e=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/765?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic66eccb5058fe9c0fae64d8e2ca=
88728068a92ab </div>
<div style=3D"display:none"> Gerrit-Change-Number: 765 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 16 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--t4Dzt2BJEs8=--

