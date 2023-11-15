From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 13:45:17 +0000
References: <gerrit.1700055887000.I6688362d8461c112bf425ddfe488d511a64cc37e@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d8b9a4fe6b301cbd19def7d87804bc09e2215aeb-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iH9PD1ex4p0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mroute: properly
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

--iH9PD1ex4p0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/439?usp=3Demail

to review the following change.


Change subject: mroute: properly print protocol at the end of the string
......................................................................

mroute: properly print protocol at the end of the string

mroute: substitute unused field with proto

Rather than adding a new field 'proto', take advantage of the 'unused'
field and rename it.

Hashing will now start at the 'proto' field rather than 'type'.

MULTI: ensure we've got the correct protocol with virtual addresses

MULTI: ensure we've got the same value as protocol for vaddressed

Change-Id: I6688362d8461c112bf425ddfe488d511a64cc37e
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/ssl.c
7 files changed, 45 insertions(+), 29 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/39/439/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27415ee..63a684b 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1114,13 +1114,16 @@
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
@@ -2239,6 +2242,7 @@

             if (status > 0)
             {
+                /*printf("\nstatus: %d\n", status); */
                 int i;
                 mtcp->event_set_status =3D 0;
                 for (i =3D 0; i < status; ++i)
@@ -2275,10 +2279,6 @@
                 mtcp->event_set_status =3D ES_TIMEOUT;
             }
         }
-        else
-        {
-            mtcp->event_set_status =3D SOCKET_READ;
-        }
     }

     /* 'now' should always be a reasonably up-to-date timestamp */
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 0017a48..c72fe10 100644
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
index 7c8972f..4e6d32c 100644
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
@@ -231,7 +230,7 @@
 mroute_addr_hash_ptr(const struct mroute_addr *a)
 {
     /* NOTE: depends on ordering of struct mroute_addr */
-    return (uint8_t *) &a->type;
+    return (uint8_t *) &a->proto;
 }

 static inline uint32_t
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index d4ce642..ba0905e 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -109,7 +109,7 @@
     mi =3D multi_create_instance(m, NULL, ls);
     if (mi && !proto_is_dgram(ls->info.proto))
     {
-        printf("\nTCP add\n");
+        mi->real.proto =3D ls->info.proto;
         struct hash_element *he;
         const uint32_t hv =3D hash_value(hash, &mi->real);
         struct hash_bucket *bucket =3D hash_bucket(hash, hv);
@@ -746,22 +746,26 @@
                                                             ev_arg->u.ls);
                             }
                         }
-                        multi_get_timeout(m, &m->top.c2.timeval);
-                        io_wait_udp(&m->top, m->mtcp, p2mp_iow_flags(m));
-                        MULTI_CHECK_SIG(m);

-                        multi_process_per_second_timers(m);
-
-                        if (m->mtcp->event_set_status =3D=3D ES_TIMEOUT)
+                        while (true)
                         {
-                            multi_process_timeout(m, MPP_PRE_SELECT | MPP_=
CLOSE_ON_SIGNAL);
-                        }
-                        else
-                        {
-                            multi_process_io_udp(m);
+                            multi_get_timeout(m, &m->top.c2.timeval);
+                            io_wait_udp(&m->top, m->mtcp, p2mp_iow_flags(m=
));
                             MULTI_CHECK_SIG(m);
-                        }

+                            multi_process_per_second_timers(m);
+
+                            if (m->mtcp->event_set_status =3D=3D ES_TIMEOU=
T)
+                            {
+                                multi_process_timeout(m, MPP_PRE_SELECT | =
MPP_CLOSE_ON_SIGNAL);
+                            }
+                            else
+                            {
+                                multi_process_io_udp(m);
+                                MULTI_CHECK_SIG(m);
+                                break;
+                            }
+                        }
                         break;
                     }
             }
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index e9182c8..4979751 100644
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
index 3522206..5098581 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -1157,11 +1157,12 @@
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
@@ -1247,6 +1248,7 @@
     CLEAR(remote_si);
     remote_si.addr.in4.sin_family =3D AF_INET;
     remote_si.addr.in4.sin_addr.s_addr =3D htonl(a);
+    addr.proto =3D 0;
     ASSERT(mroute_extract_openvpn_sockaddr(&addr, &remote_si, false));

     if (netbits >=3D 0)
@@ -3351,6 +3353,14 @@
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
@@ -3417,7 +3427,6 @@
                                                                0,
                                                                &c->c2.to_t=
un,
                                                                DEV_TYPE_TU=
N);
-
                 /* drop packet if extract failed */
                 if (!(mroute_flags & MROUTE_EXTRACT_SUCCEEDED))
                 {
@@ -3555,6 +3564,8 @@
         const int dev_type =3D TUNNEL_TYPE(m->top.c1.tuntap);
         int16_t vid =3D 0;

+        src.proto =3D 0;
+        dest.proto =3D src.proto;

 #ifdef MULTI_DEBUG_EVENT_LOOP
         printf("TUN -> TCP/UDP [%d]\n", BLEN(&m->top.c2.buf));
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index cee4afe..73d6db0 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -3926,6 +3926,7 @@
                     {
                         msg(D_MULTI_DROPPED,
                             "Incoming control channel packet too big, drop=
ping.");
+                        printf("\nif (!buf_copy(in, buf))\n");
                         goto error;
                     }
                     reliable_mark_active_incoming(ks->rec_reliable, in, id=
, op);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/439?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6688362d8461c112bf425ddfe488d511a64cc37e
Gerrit-Change-Number: 439
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--iH9PD1ex4p0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/439?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">mroute: properly print protocol at the end of the string<br><=
br>mroute: substitute unused field with proto<br><br>Rather than adding a n=
ew field &#39;proto&#39;, take advantage of the &#39;unused&#39;<br>field a=
nd rename it.<br><br>Hashing will now start at the &#39;proto&#39; field ra=
ther than &#39;type&#39;.<br><br>MULTI: ensure we&#39;ve got the correct pr=
otocol with virtual addresses<br><br>MULTI: ensure we&#39;ve got the same v=
alue as protocol for vaddressed<br><br>Change-Id: I6688362d8461c112bf425ddf=
e488d511a64cc37e<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...1664...=
26...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/mroute.c<br>M =
src/openvpn/mroute.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M s=
rc/openvpn/multi.c<br>M src/openvpn/ssl.c<br>7 files changed, 45 insertions=
(+), 29 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/39/439/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/=
openvpn/forward.c</span><br><span>index 27415ee..63a684b 100644</span><br><=
span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.=
c</span><br><span>@@ -1114,13 +1114,16 @@</span><br><span>         decrypt_=
status =3D openvpn_decrypt(&amp;c-&gt;c2.buf, c-&gt;c2.buffers-&gt;decrypt_=
buf,</span><br><span>                                          co, &amp;c-&=
gt;c2.frame, ad_start);</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (!decrypt_status</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-            /* all sockets are of the same type, =
so just check the first one */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            &amp;&amp; link_socket_connection_oriented(c-&gt;c2.li=
nk_sockets[0]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><spa=
n>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   /* decryption errors are fatal in TCP mode */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            register_signal(c-&gt;sig, SIGUSR1, =
&quot;decryption-error&quot;); /* SOFT-SIGUSR1 -- decryption error in TCP m=
ode */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            msg=
(D_STREAM_ERRORS, &quot;Fatal decryption error (process_incoming_link), res=
tarting&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (!decrypt_status</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                /* all sockets are of the same type, so just check =
the first one (not anymore!) */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                &amp;&amp; link_socket_connection_oriented(c-&g=
t;c2.link_sockets[i]))</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             /* decryption errors are fatal in TCP mode */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                register_signal(c-&g=
t;sig, SIGUSR1, &quot;decryption-error&quot;); /* SOFT-SIGUSR1 -- decryptio=
n error in TCP mode */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                msg(D_STREAM_ERRORS, &quot;Fatal decryption error (proce=
ss_incoming_link), restarting&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            }</span><br><span>         }</span><br><span>=
     }</span><br><span>     else</span><br><span>@@ -2239,6 +2242,7 @@</spa=
n><br><span> </span><br><span>             if (status &gt; 0)</span><br><sp=
an>             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
              /*printf(&quot;\nstatus: %d\n&quot;, status); */</span><br><s=
pan>                 int i;</span><br><span>                 mtcp-&gt;event=
_set_status =3D 0;</span><br><span>                 for (i =3D 0; i &lt; st=
atus; ++i)</span><br><span>@@ -2275,10 +2279,6 @@</span><br><span>         =
        mtcp-&gt;event_set_status =3D ES_TIMEOUT;</span><br><span>         =
    }</span><br><span>         }</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        else</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  mtcp-&gt;event_set_status =3D SOCKET_READ;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        }</span><br><span>     }</span><br><span> </=
span><br><span>     /* &#39;now&#39; should always be a reasonably up-to-da=
te timestamp */</span><br><span>diff --git a/src/openvpn/mroute.c b/src/ope=
nvpn/mroute.c</span><br><span>index 0017a48..c72fe10 100644</span><br><span=
>--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/openvpn/mroute.c</spa=
n><br><span>@@ -421,7 +421,6 @@</span><br><span>                 {</span><b=
r><span>                     buf_printf(&amp;out, &quot;:%d&quot;, ntohs(ma=
ddr.v4.port));</span><br><span>                 }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                buf_printf(&amp;out, &quot;:%d&=
quot;, maddr.proto);</span><br><span>             }</span><br><span>       =
      break;</span><br><span> </span><br><span>@@ -454,6 +453,7 @@</span><b=
r><span>                 buf_printf(&amp;out, &quot;UNKNOWN&quot;);</span><=
br><span>                 break;</span><br><span>         }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        buf_printf(&amp;out, &quot;=
|%d&quot;, maddr.proto);</span><br><span>         return BSTR(&amp;out);</s=
pan><br><span>     }</span><br><span>     else</span><br><span>diff --git a=
/src/openvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>index 7c8972f.=
.4e6d32c 100644</span><br><span>--- a/src/openvpn/mroute.h</span><br><span>=
+++ b/src/openvpn/mroute.h</span><br><span>@@ -74,9 +74,8 @@</span><br><spa=
n> </span><br><span> struct mroute_addr {</span><br><span>     uint8_t len;=
    /* length of address */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    uint8_t unused;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    uint8_t type;   /* MR_ADDR/MR_WITH flags */</span><br><span>     ui=
nt8_t proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    uin=
t8_t type;   /* MR_ADDR/MR_WITH flags */</span><br><span>     uint8_t netbi=
ts; /* number of bits in network part of address,</span><br><span>         =
              * valid if MR_WITH_NETBITS is set */</span><br><span>     uni=
on {</span><br><span>@@ -231,7 +230,7 @@</span><br><span> mroute_addr_hash_=
ptr(const struct mroute_addr *a)</span><br><span> {</span><br><span>     /*=
 NOTE: depends on ordering of struct mroute_addr */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return (uint8_t *) &amp;a-&gt;type;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (uint8_t *) =
&amp;a-&gt;proto;</span><br><span> }</span><br><span> </span><br><span> sta=
tic inline uint32_t</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/o=
penvpn/mtcp.c</span><br><span>index d4ce642..ba0905e 100644</span><br><span=
>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><b=
r><span>@@ -109,7 +109,7 @@</span><br><span>     mi =3D multi_create_instan=
ce(m, NULL, ls);</span><br><span>     if (mi &amp;&amp; !proto_is_dgram(ls-=
&gt;info.proto))</span><br><span>     {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        printf(&quot;\nTCP add\n&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;real.proto =3D ls-&gt=
;info.proto;</span><br><span>         struct hash_element *he;</span><br><s=
pan>         const uint32_t hv =3D hash_value(hash, &amp;mi-&gt;real);</spa=
n><br><span>         struct hash_bucket *bucket =3D hash_bucket(hash, hv);<=
/span><br><span>@@ -746,22 +746,26 @@</span><br><span>                     =
                                        ev_arg-&gt;u.ls);</span><br><span> =
                            }</span><br><span>                         }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-                        =
multi_get_timeout(m, &amp;m-&gt;top.c2.timeval);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                        io_wait_udp(&amp;m-&gt;t=
op, m-&gt;mtcp, p2mp_iow_flags(m));</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                        MULTI_CHECK_SIG(m);</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                     =
   multi_process_per_second_timers(m);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
                    if (m-&gt;mtcp-&gt;event_set_status =3D=3D ES_TIMEOUT)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
    while (true)</span><br><span>                         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-                            multi_pro=
cess_timeout(m, MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                        }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                        else</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                           =
 multi_process_io_udp(m);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                            multi_get_timeout(m, &amp;m-&gt;top.c2.ti=
meval);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                io_wait_udp(&amp;m-&gt;top, m-&gt;mtcp, p2mp_iow_flags(m));=
</span><br><span>                             MULTI_CHECK_SIG(m);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                        }</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                     multi_process_per_second_timers(m);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                            if (m-&gt;mtcp-&gt;event_set_=
status =3D=3D ES_TIMEOUT)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                            {</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                multi_process_timeout(m, MP=
P_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            }</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                            else</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
       multi_process_io_udp(m);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                MULTI_CHECK_SIG(m);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                               =
 break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      }</span><br><span>                         break;</sp=
an><br><span>                     }</span><br><span>             }</span><b=
r><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><spa=
n>index e9182c8..4979751 100644</span><br><span>--- a/src/openvpn/mudp.c</s=
pan><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -193,6 +193,7 @@<=
/span><br><span>     struct multi_instance *mi =3D NULL;</span><br><span>  =
   struct hash *hash =3D m-&gt;hash;</span><br><span>     real.proto =3D ls=
-&gt;info.proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 m-&gt;local.proto =3D real.proto;</span><br><span> </span><br><span>     i=
f (mroute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top.c2.from.dest, =
true)</span><br><span>         &amp;&amp; m-&gt;top.c2.buf.len &gt; 0)</spa=
n><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><b=
r><span>index 3522206..5098581 100644</span><br><span>--- a/src/openvpn/mul=
ti.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -1157,11 =
+1157,12 @@</span><br><span>  */</span><br><span> static struct multi_insta=
nce *</span><br><span> multi_get_instance_by_virtual_addr(struct multi_cont=
ext *m,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                     const struct mroute_addr *addr,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                                   struct=
 mroute_addr *addr,</span><br><span>                                    boo=
l cidr_routing)</span><br><span> {</span><br><span>     struct multi_route =
*route;</span><br><span>     struct multi_instance *ret =3D NULL;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    addr-&gt;proto =3D 0;</sp=
an><br><span> </span><br><span>     /* check for local address */</span><br=
><span>     if (mroute_addr_equal(addr, &amp;m-&gt;local))</span><br><span>=
@@ -1247,6 +1248,7 @@</span><br><span>     CLEAR(remote_si);</span><br><spa=
n>     remote_si.addr.in4.sin_family =3D AF_INET;</span><br><span>     remo=
te_si.addr.in4.sin_addr.s_addr =3D htonl(a);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    addr.proto =3D 0;</span><br><span>     ASSERT(=
mroute_extract_openvpn_sockaddr(&amp;addr, &amp;remote_si, false));</span><=
br><span> </span><br><span>     if (netbits &gt;=3D 0)</span><br><span>@@ -=
3351,6 +3353,14 @@</span><br><span>     bool ret =3D true;</span><br><span>=
     bool floated =3D false;</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+     * Since we don&#39;t really need the protocol on vaddres=
ses for internal VPN</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+     * payload packets, make sure we have the same value to void hashing i=
nsert</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * and sea=
rch issues.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    src.proto =3D 0;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dest.proto =3D =
src.proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span>     if (m-&gt;pending)</span><br><span>     {</span><br><span>    =
     return true;</span><br><span>@@ -3417,7 +3427,6 @@</span><br><span>   =
                                                             0,</span><br><=
span>                                                                &amp;c=
-&gt;c2.to_tun,</span><br><span>                                           =
                     DEV_TYPE_TUN);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span>                 /* drop packet if extract f=
ailed */</span><br><span>                 if (!(mroute_flags &amp; MROUTE_E=
XTRACT_SUCCEEDED))</span><br><span>                 {</span><br><span>@@ -3=
555,6 +3564,8 @@</span><br><span>         const int dev_type =3D TUNNEL_TYP=
E(m-&gt;top.c1.tuntap);</span><br><span>         int16_t vid =3D 0;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+        s=
rc.proto =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    dest.proto =3D src.proto;</span><br><span> </span><br><span> #ifdef MUL=
TI_DEBUG_EVENT_LOOP</span><br><span>         printf(&quot;TUN -&gt; TCP/UDP=
 [%d]\n&quot;, BLEN(&amp;m-&gt;top.c2.buf));</span><br><span>diff --git a/s=
rc/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index cee4afe..73d6db0=
 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b/src/o=
penvpn/ssl.c</span><br><span>@@ -3926,6 +3926,7 @@</span><br><span>        =
             {</span><br><span>                         msg(D_MULTI_DROPPED=
,</span><br><span>                             &quot;Incoming control chann=
el packet too big, dropping.&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                        printf(&quot;\nif (!buf_copy(in, b=
uf))\n&quot;);</span><br><span>                         goto error;</span><=
br><span>                     }</span><br><span>                     reliab=
le_mark_active_incoming(ks-&gt;rec_reliable, in, id, op);</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/439?usp=3Demail">change 439</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settin=
gs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div =
itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><li=
nk itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/439?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6688362d8461c112bf425ddfe48=
8d511a64cc37e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 439 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: ordex &lt;a@...2181...&gt; </div>
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


--iH9PD1ex4p0=--

