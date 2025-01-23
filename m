From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 23 Jan 2025 17:36:28 +0000
In-Reply-To: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
References: <gerrit.1727098847000.Ic66eccb5058fe9c0fae64d8e2ca88728068a92ab@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 gert@...1296..., a@...2181...
Message-ID: <81904748f257dffc31b49632148eff362ee2b830-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="JW3o+tkW4B4="; charset=UTF-8
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

--JW3o+tkW4B4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, ordex, plaisthos.

Hello cron2, flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail

to look at the new patch set (#14).


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
M src/openvpn/forward.c
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
6 files changed, 28 insertions(+), 10 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/765/14

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f3f3503..38ea9c3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1129,13 +1129,16 @@
         decrypt_status =3D openvpn_decrypt(&c->c2.buf, c->c2.buffers->decr=
ypt_buf,
                                          co, &c->c2.frame, ad_start);

-        if (!decrypt_status
-            /* on the instance context we have only one socket, so just ch=
eck the first one */
-            && link_socket_connection_oriented(c->c2.link_sockets[0]))
+        for (int i =3D 0; i < c->c1.link_sockets_num; i++)
         {
-            /* decryption errors are fatal in TCP mode */
-            register_signal(c->sig, SIGUSR1, "decryption-error"); /* SOFT-=
SIGUSR1 -- decryption error in TCP mode */
-            msg(D_STREAM_ERRORS, "Fatal decryption error (process_incoming=
_link), restarting");
+            if (!decrypt_status
+                /* on the instance context we have only one socket, so jus=
t check the first one */
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
index 8b457d4..570ccaa 100644
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
@@ -216,7 +216,7 @@
 mroute_addr_hash_ptr(const struct mroute_addr *a)
 {
     /* NOTE: depends on ordering of struct mroute_addr */
-    return (uint8_t *) &a->type;
+    return (uint8_t *) &a->proto;
 }

 static inline uint32_t
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
index 6137578..f0b5142 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -192,6 +192,8 @@
     struct mroute_addr real =3D {0};
     struct multi_instance *mi =3D NULL;
     struct hash *hash =3D m->hash;
+    real.proto =3D ls->info.proto;
+    m->local.proto =3D real.proto;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3f55dd7..2adea7f 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1153,11 +1153,12 @@
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
@@ -1243,6 +1244,7 @@
     CLEAR(remote_si);
     remote_si.addr.in4.sin_family =3D AF_INET;
     remote_si.addr.in4.sin_addr.s_addr =3D htonl(a);
+    addr.proto =3D 0;
     ASSERT(mroute_extract_openvpn_sockaddr(&addr, &remote_si, false));

     if (netbits >=3D 0)
@@ -3344,6 +3346,14 @@
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
@@ -3410,7 +3420,6 @@
                                                                0,
                                                                &c->c2.to_t=
un,
                                                                DEV_TYPE_TU=
N);
-
                 /* drop packet if extract failed */
                 if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
                 {
@@ -3548,6 +3557,8 @@
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
Gerrit-PatchSet: 14
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--JW3o+tkW4B4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, ordex, plais=
thos. </p>
<p>its_Giaan <strong>uploaded patch set #14</strong> to this change.</p><p>=
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/765?usp=3Demail">View Chan=
ge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;">mroute: adapt to new protocol handling and hashing improvements<br><=
br>Repurposing an unused field and renaming it to &#39;proto&#39;<br>instea=
d of introducing a new field. The hashing now<br>begins at the &#39;proto&#=
39; field rather than the &#39;type&#39;<br>field. Additionally, the change=
s ensure that the<br>correct protocol is consistently used with virtual<br>=
addresses ensuring alignment.<br><br>Change-Id: Ic66eccb5058fe9c0fae64d8e2c=
a88728068a92ab<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2787...=
...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/mroute.c<br>M sr=
c/openvpn/mroute.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M src=
/openvpn/multi.c<br>6 files changed, 28 insertions(+), 10 deletions(-)<br><=
br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/65/765/1=
4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span>=
<br><span>index f3f3503..38ea9c3 100644</span><br><span>--- a/src/openvpn/f=
orward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -11=
29,13 +1129,16 @@</span><br><span>         decrypt_status =3D openvpn_decry=
pt(&amp;c-&gt;c2.buf, c-&gt;c2.buffers-&gt;decrypt_buf,</span><br><span>   =
                                       co, &amp;c-&gt;c2.frame, ad_start);<=
/span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    if (!decrypt_status</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            /* on the instance context we have only one socket, so just c=
heck the first one */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            &amp;&amp; link_socket_connection_oriented(c-&gt;c2.link_socket=
s[0]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (=
int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span>       =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* dec=
ryption errors are fatal in TCP mode */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            register_signal(c-&gt;sig, SIGUSR1, &quot;dec=
ryption-error&quot;); /* SOFT-SIGUSR1 -- decryption error in TCP mode */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg(D_STREAM=
_ERRORS, &quot;Fatal decryption error (process_incoming_link), restarting&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            i=
f (!decrypt_status</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               /* on the instance context we have only one socket, so just =
check the first one */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                &amp;&amp; link_socket_connection_oriented(c-&gt;c2.link=
_sockets[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    /* decryption errors are fatal in TCP mode */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                register_signal(c-&gt;sig, SI=
GUSR1, &quot;decryption-error&quot;); /* SOFT-SIGUSR1 -- decryption error i=
n TCP mode */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
          msg(D_STREAM_ERRORS, &quot;Fatal decryption error (process_incomi=
ng_link), restarting&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            }</span><br><span>         }</span><br><span>     }</s=
pan><br><span>     else</span><br><span>diff --git a/src/openvpn/mroute.c b=
/src/openvpn/mroute.c</span><br><span>index 80e18b7..74923cf 100644</span><=
br><span>--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/openvpn/mrout=
e.c</span><br><span>@@ -454,6 +454,7 @@</span><br><span>                 bu=
f_printf(&amp;out, &quot;UNKNOWN&quot;);</span><br><span>                 b=
reak;</span><br><span>         }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        buf_printf(&amp;out, &quot;|%d&quot;, maddr.proto);</s=
pan><br><span>         return BSTR(&amp;out);</span><br><span>     }</span>=
<br><span>     else</span><br><span>diff --git a/src/openvpn/mroute.h b/src=
/openvpn/mroute.h</span><br><span>index 8b457d4..570ccaa 100644</span><br><=
span>--- a/src/openvpn/mroute.h</span><br><span>+++ b/src/openvpn/mroute.h<=
/span><br><span>@@ -74,7 +74,7 @@</span><br><span> </span><br><span> struct=
 mroute_addr {</span><br><span>     uint8_t len;    /* length of address */=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    uint8_t unused;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uint8_t proto;</s=
pan><br><span>     uint8_t type;   /* MR_ADDR/MR_WITH flags */</span><br><s=
pan>     uint8_t netbits; /* number of bits in network part of address,</sp=
an><br><span>                       * valid if MR_WITH_NETBITS is set */</s=
pan><br><span>@@ -216,7 +216,7 @@</span><br><span> mroute_addr_hash_ptr(con=
st struct mroute_addr *a)</span><br><span> {</span><br><span>     /* NOTE: =
depends on ordering of struct mroute_addr */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return (uint8_t *) &amp;a-&gt;type;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return (uint8_t *) &amp;a-&g=
t;proto;</span><br><span> }</span><br><span> </span><br><span> static inlin=
e uint32_t</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mt=
cp.c</span><br><span>index 6d1d5a0..62ed044 100644</span><br><span>--- a/sr=
c/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@=
@ -56,6 +56,7 @@</span><br><span>     mi =3D multi_create_instance(m, NULL,=
 ls);</span><br><span>     if (mi)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;real.proto =3D ls-&gt;=
info.proto;</span><br><span>         struct hash_element *he;</span><br><sp=
an>         const uint32_t hv =3D hash_value(hash, &amp;mi-&gt;real);</span=
><br><span>         struct hash_bucket *bucket =3D hash_bucket(hash, hv);</=
span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><=
br><span>index 6137578..f0b5142 100644</span><br><span>--- a/src/openvpn/mu=
dp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -192,6 +19=
2,8 @@</span><br><span>     struct mroute_addr real =3D {0};</span><br><spa=
n>     struct multi_instance *mi =3D NULL;</span><br><span>     struct hash=
 *hash =3D m-&gt;hash;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    real.proto =3D ls-&gt;info.proto;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    m-&gt;local.proto =3D real.proto;</span><br><span>=
 </span><br><span>     if (mroute_extract_openvpn_sockaddr(&amp;real, &amp;=
m-&gt;top.c2.from.dest, true)</span><br><span>         &amp;&amp; m-&gt;top=
.c2.buf.len &gt; 0)</span><br><span>diff --git a/src/openvpn/multi.c b/src/=
openvpn/multi.c</span><br><span>index 3f55dd7..2adea7f 100644</span><br><sp=
an>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</spa=
n><br><span>@@ -1153,11 +1153,12 @@</span><br><span>  */</span><br><span> s=
tatic struct multi_instance *</span><br><span> multi_get_instance_by_virtua=
l_addr(struct multi_context *m,</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                                   const struct mroute_addr *addr=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
                 struct mroute_addr *addr,</span><br><span>                =
                    bool cidr_routing)</span><br><span> {</span><br><span> =
    struct multi_route *route;</span><br><span>     struct multi_instance *=
ret =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ad=
dr-&gt;proto =3D 0;</span><br><span> </span><br><span>     /* check for loc=
al address */</span><br><span>     if (mroute_addr_equal(addr, &amp;m-&gt;l=
ocal))</span><br><span>@@ -1243,6 +1244,7 @@</span><br><span>     CLEAR(rem=
ote_si);</span><br><span>     remote_si.addr.in4.sin_family =3D AF_INET;</s=
pan><br><span>     remote_si.addr.in4.sin_addr.s_addr =3D htonl(a);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    addr.proto =3D 0;</span=
><br><span>     ASSERT(mroute_extract_openvpn_sockaddr(&amp;addr, &amp;remo=
te_si, false));</span><br><span> </span><br><span>     if (netbits &gt;=3D =
0)</span><br><span>@@ -3344,6 +3346,14 @@</span><br><span>     bool ret =3D=
 true;</span><br><span>     bool floated =3D false;</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     * Since we don&#39;t really need =
the protocol on vaddresses for internal VPN</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+     * payload packets, make sure we have the same =
value to void hashing insert</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+     * and search issues.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    src.proto =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    dest.proto =3D src.proto;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     if (m-&gt;pending)</span><br><span>    =
 {</span><br><span>         return true;</span><br><span>@@ -3410,7 +3420,6=
 @@</span><br><span>                                                       =
         0,</span><br><span>                                               =
                 &amp;c-&gt;c2.to_tun,</span><br><span>                    =
                                            DEV_TYPE_TUN);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>                 /* d=
rop packet if extract failed */</span><br><span>                 if (!(mrou=
te_flags &amp; MROUTE_EXTRACT_SUCCEEDED))</span><br><span>                 =
{</span><br><span>@@ -3548,6 +3557,8 @@</span><br><span>         const int =
dev_type =3D TUNNEL_TYPE(m-&gt;top.c1.tuntap);</span><br><span>         int=
16_t vid =3D 0;</span><br><span> </span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        src.proto =3D 0;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        dest.proto =3D src.proto;</span><br><span> </spa=
n><br><span> #ifdef MULTI_DEBUG_EVENT_LOOP</span><br><span>         printf(=
&quot;TUN -&gt; TCP/UDP [%d]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf));</span><=
br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/765?usp=3Demail">change 765</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMess=
age"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewA=
ction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+=
/765?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div><=
/div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic66eccb5058fe9c0fae64d8e2ca=
88728068a92ab </div>
<div style=3D"display:none"> Gerrit-Change-Number: 765 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
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
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--JW3o+tkW4B4=--

