From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 25 Jan 2025 09:57:49 +0000
In-Reply-To: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
References: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <73ed50f640fb4448ca0b80c29b6b6bc6c9110417-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AkNJJpd7SbY="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--AkNJJpd7SbY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#18) to the change originally created b=
y its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250124205135.18765-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
579.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
5 files changed, 21 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/765/18

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
index 8b457d4..2659695 100644
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
@@ -201,6 +210,10 @@
     {
         return false;
     }
+    if (a1->proto !=3D a2->proto)
+    {
+        return false;
+    }
     if (a1->netbits !=3D a2->netbits)
     {
         return false;
@@ -216,13 +229,13 @@
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
index 3f55dd7..9c8c014 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -794,6 +794,7 @@
         {
             goto err;
         }
+        mi->real.proto =3D ls->info.proto;
         generate_prefix(mi);
     }

@@ -1243,6 +1244,7 @@
     CLEAR(remote_si);
     remote_si.addr.in4.sin_family =3D AF_INET;
     remote_si.addr.in4.sin_addr.s_addr =3D htonl(a);
+    addr.proto =3D 0;
     ASSERT(mroute_extract_openvpn_sockaddr(&addr, &remote_si, false));

     if (netbits >=3D 0)
@@ -3548,7 +3550,6 @@
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
Gerrit-PatchSet: 18
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--AkNJJpd7SbY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #18</strong> to the change originally c=
reated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/765?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">mroute: adapt to new protocol handling and hashing i=
mprovements<br><br>Repurposing an unused field and renaming it to &#39;prot=
o&#39;<br>instead of introducing a new field. The hashing now<br>begins at =
the &#39;proto&#39; field rather than the &#39;type&#39;<br>field. Addition=
ally, the changes ensure that the<br>correct protocol is consistently used =
with virtual<br>addresses ensuring alignment.<br><br>Change-Id: Ic66eccb505=
8fe9c0fae64d8e2ca88728068a92ab<br>Signed-off-by: Gianmarco De Gregori &lt;g=
ianmarco@...2726...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<b=
r>Message-Id: &lt;20250124205135.18765-1-gert@...1296...&gt;<br>URL: https:=
//www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30579.html<br=
>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvp=
n/mroute.c<br>M src/openvpn/mroute.h<br>M src/openvpn/mtcp.c<br>M src/openv=
pn/mudp.c<br>M src/openvpn/multi.c<br>5 files changed, 21 insertions(+), 4 =
deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs=
/changes/65/765/18</pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;"><span>diff --git a/src/openvpn/mroute.c b/src/openvpn/=
mroute.c</span><br><span>index 80e18b7..74923cf 100644</span><br><span>--- =
a/src/openvpn/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c</span><br=
><span>@@ -454,6 +454,7 @@</span><br><span>                 buf_printf(&amp=
;out, &quot;UNKNOWN&quot;);</span><br><span>                 break;</span><=
br><span>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        buf_printf(&amp;out, &quot;|%d&quot;, maddr.proto);</span><br><span=
>         return BSTR(&amp;out);</span><br><span>     }</span><br><span>   =
  else</span><br><span>diff --git a/src/openvpn/mroute.h b/src/openvpn/mrou=
te.h</span><br><span>index 8b457d4..2659695 100644</span><br><span>--- a/sr=
c/openvpn/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h</span><br><sp=
an>@@ -74,7 +74,7 @@</span><br><span> </span><br><span> struct mroute_addr =
{</span><br><span>     uint8_t len;    /* length of address */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    uint8_t unused;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    uint8_t proto;</span><br><span=
>     uint8_t type;   /* MR_ADDR/MR_WITH flags */</span><br><span>     uint=
8_t netbits; /* number of bits in network part of address,</span><br><span>=
                       * valid if MR_WITH_NETBITS is set */</span><br><span=
>@@ -183,6 +183,15 @@</span><br><span> {</span><br><span>     unsigned int =
ret =3D 0;</span><br><span>     verify_align_4(buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * Since we don&#39;t really need the protocol on vaddresses for inte=
rnal VPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * payl=
oad packets, make sure we have the same value to avoid hashing insert</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and search issues.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    src-&gt;proto =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;proto =3D src=
-&gt;proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span>     if (tunnel_type =3D=3D DEV_TYPE_TUN)</span><br><span>     {</=
span><br><span>         ret =3D mroute_extract_addr_ip(src, dest, buf);</sp=
an><br><span>@@ -201,6 +210,10 @@</span><br><span>     {</span><br><span>  =
       return false;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (a1-&gt;proto !=3D a2-&gt;proto)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     if (a1-&gt;net=
bits !=3D a2-&gt;netbits)</span><br><span>     {</span><br><span>         r=
eturn false;</span><br><span>@@ -216,13 +229,13 @@</span><br><span> mroute_=
addr_hash_ptr(const struct mroute_addr *a)</span><br><span> {</span><br><sp=
an>     /* NOTE: depends on ordering of struct mroute_addr */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    return (uint8_t *) &amp;a-&gt;t=
ype;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (uin=
t8_t *) &amp;a-&gt;proto;</span><br><span> }</span><br><span> </span><br><s=
pan> static inline uint32_t</span><br><span> mroute_addr_hash_len(const str=
uct mroute_addr *a)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    return (uint32_t) a-&gt;len + 2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return (uint32_t) a-&gt;len + 3;</spa=
n><br><span> }</span><br><span> </span><br><span> static inline void</span>=
<br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><s=
pan>index 6d1d5a0..62ed044 100644</span><br><span>--- a/src/openvpn/mtcp.c<=
/span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -56,6 +56,7 @@<=
/span><br><span>     mi =3D multi_create_instance(m, NULL, ls);</span><br><=
span>     if (mi)</span><br><span>     {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        mi-&gt;real.proto =3D ls-&gt;info.proto;</span=
><br><span>         struct hash_element *he;</span><br><span>         const=
 uint32_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span><br><span>      =
   struct hash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span>di=
ff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 61=
37578..4f2bbd7 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><s=
pan>+++ b/src/openvpn/mudp.c</span><br><span>@@ -192,6 +192,7 @@</span><br>=
<span>     struct mroute_addr real =3D {0};</span><br><span>     struct mul=
ti_instance *mi =3D NULL;</span><br><span>     struct hash *hash =3D m-&gt;=
hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    real.proto=
 =3D ls-&gt;info.proto;</span><br><span> </span><br><span>     if (mroute_e=
xtract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top.c2.from.dest, true)</span=
><br><span>         &amp;&amp; m-&gt;top.c2.buf.len &gt; 0)</span><br><span=
>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>ind=
ex 3f55dd7..9c8c014 100644</span><br><span>--- a/src/openvpn/multi.c</span>=
<br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -794,6 +794,7 @@</sp=
an><br><span>         {</span><br><span>             goto err;</span><br><s=
pan>         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   mi-&gt;real.proto =3D ls-&gt;info.proto;</span><br><span>         genera=
te_prefix(mi);</span><br><span>     }</span><br><span> </span><br><span>@@ =
-1243,6 +1244,7 @@</span><br><span>     CLEAR(remote_si);</span><br><span> =
    remote_si.addr.in4.sin_family =3D AF_INET;</span><br><span>     remote_=
si.addr.in4.sin_addr.s_addr =3D htonl(a);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    addr.proto =3D 0;</span><br><span>     ASSERT(mro=
ute_extract_openvpn_sockaddr(&amp;addr, &amp;remote_si, false));</span><br>=
<span> </span><br><span>     if (netbits &gt;=3D 0)</span><br><span>@@ -354=
8,7 +3550,6 @@</span><br><span>         const int dev_type =3D TUNNEL_TYPE(=
m-&gt;top.c1.tuntap);</span><br><span>         int16_t vid =3D 0;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>         printf(&quot;TU=
N -&gt; TCP/UDP [%d]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf));</span><br><span=
> #endif</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail">change 765</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/765?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic66eccb5058fe9c0fae64d8e2ca=
88728068a92ab </div>
<div style=3D"display:none"> Gerrit-Change-Number: 765 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 18 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--AkNJJpd7SbY=--

