From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 23 Sep 2024 13:41:31 +0000
References: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9b77ecdf4ba9bc5d24a2113a16cd5ea24c065b62-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R8YGToc2hRo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mroute: properly
 print protocol at the end of the string
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

--R8YGToc2hRo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail

to review the following change.


Change subject: mroute: properly print protocol at the end of the string
......................................................................

mroute: properly print protocol at the end of the string

mroute: substitute unused field with proto

Rather than adding a new field 'proto', take advantage of the 'unused'
field and rename it.

Hashing will now start at the 'proto' field rather than 'type'.

MULTI: ensure we've got the correct protocol with virtual addresses

MULTI: ensure we've got the same value as protocol for vaddresses

Change-Id: Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
6 files changed, 27 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/765/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 7559a71..1357cad 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1129,13 +1129,16 @@
         decrypt_status =3D openvpn_decrypt(&c->c2.buf, c->c2.buffers->decr=
ypt_buf,
                                          co, &c->c2.frame, ad_start);

-        if (!decrypt_status
-            /* all sockets are of the same type, so just check the first o=
ne */
-            && link_socket_connection_oriented(c->c2.link_sockets[0]))
+        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
         {
-            /* decryption errors are fatal in TCP mode */
-            register_signal(c->sig, SIGUSR1, "decryption-error"); /* SOFT-=
SIGUSR1 -- decryption error in TCP mode */
-            msg(D_STREAM_ERRORS, "Fatal decryption error (process_incoming=
_link), restarting");
+            if (!decrypt_status
+                /* all sockets are of the same type, so just check the fir=
st one (not anymore!) */
+                && link_socket_connection_oriented(c->c2.link_sockets[i]))
+            {
+                /* decryption errors are fatal in TCP mode */
+                register_signal(c->sig, SIGUSR1, "decryption-error"); /* S=
OFT-SIGUSR1 -- decryption error in TCP mode */
+                msg(D_STREAM_ERRORS, "Fatal decryption error (process_inco=
ming_link), restarting");
+            }
         }
     }
     else
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 6c8e8dd..3a0224e 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -421,7 +421,6 @@
                 {
                     buf_printf(&out, ":%d", ntohs(maddr.v4.port));
                 }
-                buf_printf(&out, ":%d", maddr.proto);
             }
             break;

@@ -454,6 +453,7 @@
                 buf_printf(&out, "UNKNOWN");
                 break;
         }
+        buf_printf(&out, "|%d", maddr.proto);
         return BSTR(&out);
     }
     else
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index fd1dbfe..e844c21 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -74,9 +74,8 @@

 struct mroute_addr {
     uint8_t len;    /* length of address */
-    uint8_t unused;
-    uint8_t type;   /* MR_ADDR/MR_WITH flags */
     uint8_t proto;
+    uint8_t type;   /* MR_ADDR/MR_WITH flags */
     uint8_t netbits; /* number of bits in network part of address,
                       * valid if MR_WITH_NETBITS is set */
     union {
@@ -221,7 +220,7 @@
 mroute_addr_hash_ptr(const struct mroute_addr *a)
 {
     /* NOTE: depends on ordering of struct mroute_addr */
-    return (uint8_t *) &a->type;
+    return (uint8_t *) &a->proto;
 }

 static inline uint32_t
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 73f6bcc..1eb28ec 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -56,6 +56,7 @@
     mi =3D multi_create_instance(m, NULL, ls);
     if (mi && !proto_is_dgram(ls->info.proto))
     {
+        mi->real.proto =3D ls->info.proto;
         struct hash_element *he;
         const uint32_t hv =3D hash_value(hash, &mi->real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index a7e6e1d..f9efcd5 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -193,6 +193,7 @@
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;
     real.proto =3D ls->info.proto;
+    m->local.proto =3D real.proto;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 2d4fbe7..4a6dd52 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1156,11 +1156,12 @@
  */
 static struct multi_instance *
 multi_get_instance_by_virtual_addr(struct multi_context *m,
-                                   const struct mroute_addr *addr,
+                                   struct mroute_addr *addr,
                                    bool cidr_routing)
 {
     struct multi_route *route;
     struct multi_instance *ret =3D NULL;
+    addr->proto =3D 0;

     /* check for local address */
     if (mroute_addr_equal(addr, &m->local))
@@ -1246,6 +1247,7 @@
     CLEAR(remote_si);
     remote_si.addr.in4.sin_family =3D AF_INET;
     remote_si.addr.in4.sin_addr.s_addr =3D htonl(a);
+    addr.proto =3D 0;
     ASSERT(mroute_extract_openvpn_sockaddr(&addr, &remote_si, false));

     if (netbits >=3D 0)
@@ -3346,6 +3348,14 @@
     bool ret =3D true;
     bool floated =3D false;

+    /*
+     * Since we don't really need the protocol on vaddresses for internal =
VPN
+     * payload packets, make sure we have the same value to void hashing i=
nsert
+     * and search issues.
+     */
+    src.proto =3D 0;
+    dest.proto =3D src.proto;
+
     if (m->pending)
     {
         return true;
@@ -3412,7 +3422,6 @@
                                                                0,
                                                                &c->c2.to_t=
un,
                                                                DEV_TYPE_TU=
N);
-
                 /* drop packet if extract failed */
                 if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
                 {
@@ -3550,6 +3559,8 @@
         const int dev_type =3D TUNNEL_TYPE(m->top.c1.tuntap);
         int16_t vid =3D 0;

+        src.proto =3D 0;
+        dest.proto =3D src.proto;

 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top.c2.buf));

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab
Gerrit-Change-Number: 765
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--R8YGToc2hRo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">mroute: properly print protocol at the end of the string<br><=
br>mroute: substitute unused field with proto<br><br>Rather than adding a n=
ew field &#39;proto&#39;, take advantage of the &#39;unused&#39;<br>field a=
nd rename it.<br><br>Hashing will now start at the &#39;proto&#39; field ra=
ther than &#39;type&#39;.<br><br>MULTI: ensure we&#39;ve got the correct pr=
otocol with virtual addresses<br><br>MULTI: ensure we&#39;ve got the same v=
alue as protocol for vaddresses<br><br>Change-Id: Ic66eccb5058fe9c0fae64d8e=
2ca88728068a92ab<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...1664...=
26...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/mroute.c<br>M =
src/openvpn/mroute.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M s=
rc/openvpn/multi.c<br>6 files changed, 27 insertions(+), 12 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/765=
/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span=
><br><span>index 7559a71..1357cad 100644</span><br><span>--- a/src/openvpn/=
forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -1=
129,13 +1129,16 @@</span><br><span>         decrypt_status =3D openvpn_decr=
ypt(&amp;c-&gt;c2.buf, c-&gt;c2.buffers-&gt;decrypt_buf,</span><br><span>  =
                                        co, &amp;c-&gt;c2.frame, ad_start);=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
     if (!decrypt_status</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            /* all sockets are of the same type, so just check the first=
 one */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &a=
mp;&amp; link_socket_connection_oriented(c-&gt;c2.link_sockets[0]))</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        for (int i =3D 0; i=
 &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            /* decryption errors=
 are fatal in TCP mode */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            register_signal(c-&gt;sig, SIGUSR1, &quot;decryption-error&=
quot;); /* SOFT-SIGUSR1 -- decryption error in TCP mode */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            msg(D_STREAM_ERRORS, &quot=
;Fatal decryption error (process_incoming_link), restarting&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            if (!decrypt_st=
atus</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
 /* all sockets are of the same type, so just check the first one (not anym=
ore!) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
     &amp;&amp; link_socket_connection_oriented(c-&gt;c2.link_sockets[i]))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                /* decrypt=
ion errors are fatal in TCP mode */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                register_signal(c-&gt;sig, SIGUSR1, &quot;d=
ecryption-error&quot;); /* SOFT-SIGUSR1 -- decryption error in TCP mode */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                msg(=
D_STREAM_ERRORS, &quot;Fatal decryption error (process_incoming_link), rest=
arting&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       }</span><br><span>         }</span><br><span>     }</span><br><span>=
     else</span><br><span>diff --git a/src/openvpn/mroute.c b/src/openvpn/m=
route.c</span><br><span>index 6c8e8dd..3a0224e 100644</span><br><span>--- a=
/src/openvpn/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c</span><br>=
<span>@@ -421,7 +421,6 @@</span><br><span>                 {</span><br><spa=
n>                     buf_printf(&amp;out, &quot;:%d&quot;, ntohs(maddr.v4=
.port));</span><br><span>                 }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;:%d&quot;,=
 maddr.proto);</span><br><span>             }</span><br><span>             =
break;</span><br><span> </span><br><span>@@ -454,6 +453,7 @@</span><br><spa=
n>                 buf_printf(&amp;out, &quot;UNKNOWN&quot;);</span><br><sp=
an>                 break;</span><br><span>         }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;|%d&qu=
ot;, maddr.proto);</span><br><span>         return BSTR(&amp;out);</span><b=
r><span>     }</span><br><span>     else</span><br><span>diff --git a/src/o=
penvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>index fd1dbfe..e844c=
21 100644</span><br><span>--- a/src/openvpn/mroute.h</span><br><span>+++ b/=
src/openvpn/mroute.h</span><br><span>@@ -74,9 +74,8 @@</span><br><span> </s=
pan><br><span> struct mroute_addr {</span><br><span>     uint8_t len;    /*=
 length of address */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    uint8_t unused;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  uint8_t type;   /* MR_ADDR/MR_WITH flags */</span><br><span>     uint8_t =
proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t t=
ype;   /* MR_ADDR/MR_WITH flags */</span><br><span>     uint8_t netbits; /*=
 number of bits in network part of address,</span><br><span>               =
        * valid if MR_WITH_NETBITS is set */</span><br><span>     union {</=
span><br><span>@@ -221,7 +220,7 @@</span><br><span> mroute_addr_hash_ptr(co=
nst struct mroute_addr *a)</span><br><span> {</span><br><span>     /* NOTE:=
 depends on ordering of struct mroute_addr */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return (uint8_t *) &amp;a-&gt;type;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    return (uint8_t *) &amp;a-&=
gt;proto;</span><br><span> }</span><br><span> </span><br><span> static inli=
ne uint32_t</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/m=
tcp.c</span><br><span>index 73f6bcc..1eb28ec 100644</span><br><span>--- a/s=
rc/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>=
@@ -56,6 +56,7 @@</span><br><span>     mi =3D multi_create_instance(m, NULL=
, ls);</span><br><span>     if (mi &amp;&amp; !proto_is_dgram(ls-&gt;info.p=
roto))</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        mi-&gt;real.proto =3D ls-&gt;info.proto;</span><br><span>=
         struct hash_element *he;</span><br><span>         const uint32_t h=
v =3D hash_value(hash, &amp;mi-&gt;real);</span><br><span>         struct h=
ash_bucket *bucket =3D hash_bucket(hash, hv);</span><br><span>diff --git a/=
src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index a7e6e1d..f9ef=
cd5 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/s=
rc/openvpn/mudp.c</span><br><span>@@ -193,6 +193,7 @@</span><br><span>     =
struct multi_instance *mi =3D NULL;</span><br><span>     struct hash *hash =
=3D m-&gt;hash;</span><br><span>     real.proto =3D ls-&gt;info.proto;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;local.proto =
=3D real.proto;</span><br><span> </span><br><span>     if (mroute_extract_o=
penvpn_sockaddr(&amp;real, &amp;m-&gt;top.c2.from.dest, true)</span><br><sp=
an>         &amp;&amp; m-&gt;top.c2.buf.len &gt; 0)</span><br><span>diff --=
git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 2d4fb=
e7..4a6dd52 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><spa=
n>+++ b/src/openvpn/multi.c</span><br><span>@@ -1156,11 +1156,12 @@</span><=
br><span>  */</span><br><span> static struct multi_instance *</span><br><sp=
an> multi_get_instance_by_virtual_addr(struct multi_context *m,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                                 =
  const struct mroute_addr *addr,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                   struct mroute_addr *addr,<=
/span><br><span>                                    bool cidr_routing)</spa=
n><br><span> {</span><br><span>     struct multi_route *route;</span><br><s=
pan>     struct multi_instance *ret =3D NULL;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    addr-&gt;proto =3D 0;</span><br><span> </span=
><br><span>     /* check for local address */</span><br><span>     if (mrou=
te_addr_equal(addr, &amp;m-&gt;local))</span><br><span>@@ -1246,6 +1247,7 @=
@</span><br><span>     CLEAR(remote_si);</span><br><span>     remote_si.add=
r.in4.sin_family =3D AF_INET;</span><br><span>     remote_si.addr.in4.sin_a=
ddr.s_addr =3D htonl(a);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    addr.proto =3D 0;</span><br><span>     ASSERT(mroute_extract_openv=
pn_sockaddr(&amp;addr, &amp;remote_si, false));</span><br><span> </span><br=
><span>     if (netbits &gt;=3D 0)</span><br><span>@@ -3346,6 +3348,14 @@</=
span><br><span>     bool ret =3D true;</span><br><span>     bool floated =
=3D false;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
 * Since we don&#39;t really need the protocol on vaddresses for internal V=
PN</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * payload pa=
ckets, make sure we have the same value to void hashing insert</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+     * and search issues.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    src.proto =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    dest.proto =3D src.proto;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (m=
-&gt;pending)</span><br><span>     {</span><br><span>         return true;<=
/span><br><span>@@ -3412,7 +3422,6 @@</span><br><span>                     =
                                           0,</span><br><span>             =
                                                   &amp;c-&gt;c2.to_tun,</s=
pan><br><span>                                                             =
   DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span>                 /* drop packet if extract failed */</span><br=
><span>                 if (!(mroute_flags &amp; MROUTE_EXTRACT_SUCCEEDED))=
</span><br><span>                 {</span><br><span>@@ -3550,6 +3559,8 @@</=
span><br><span>         const int dev_type =3D TUNNEL_TYPE(m-&gt;top.c1.tun=
tap);</span><br><span>         int16_t vid =3D 0;</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        src.proto =3D 0;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        dest.proto =3D=
 src.proto;</span><br><span> </span><br><span> #ifdef MULTI_DEBUG_EVENT_LOO=
P</span><br><span>         printf(&quot;TUN -&gt; TCP/UDP [%d]\n&quot;, BLE=
N(&amp;m-&gt;top.c2.buf));</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail">change=
 765</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic66eccb5058fe9c0fae64d8e2ca=
88728068a92ab </div>
<div style=3D"display:none"> Gerrit-Change-Number: 765 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
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


--R8YGToc2hRo=--

