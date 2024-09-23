From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 23 Sep 2024 13:41:15 +0000
References: <gerrit.1727098847000.I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <3d50cbad3bd2690fa9ce4171bfdabe5f39b17553-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZZU+JF2Lwy8="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: pass link_socket
 object to i/o functions
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

--ZZU+JF2Lwy8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/758?usp=3Demail

to review the following change.


Change subject: pass link_socket object to i/o functions
......................................................................

pass link_socket object to i/o functions

In order to prepare the code to work with distinct sockets,
it is essential that i/o functions do not operate on any
hard-coded socket object (i.e. c->c2.link_socket).

This patch changes all the low-level i/o functionis to work
with a socket specified as argument rather than a fixed one.

Change-Id: I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/event.h
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.h
M src/openvpn/openvpn.c
M src/openvpn/socket.c
8 files changed, 44 insertions(+), 36 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/58/758/1

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 844ea7b..57341e0 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -137,6 +137,7 @@
     event_arg_t type;
     union {
         struct multi_instance *mi; /* if type =3D EVENT_ARG_MULTI_INSTANCE=
 */
+        struct link_socket *ls; /* if type =3D EVENT_ARG_LINK_SOCKET */
     } u;
 };

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index a88a4bb..16b4497 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -883,9 +883,9 @@
  */

 static inline void
-socks_postprocess_incoming_link(struct context *c)
+socks_postprocess_incoming_link(struct context *c, struct link_socket *ls)
 {
-    if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto =
=3D=3D PROTO_UDP)
+    if (ls->socks_proxy && ls->info.proto =3D=3D PROTO_UDP)
     {
         socks_process_incoming_udp(&c->c2.buf, &c->c2.from);
     }
@@ -893,13 +893,14 @@

 static inline void
 socks_preprocess_outgoing_link(struct context *c,
+                               struct link_socket *ls,
                                struct link_socket_actual **to_addr,
                                int *size_delta)
 {
-    if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto =
=3D=3D PROTO_UDP)
+    if (ls->socks_proxy && ls->info.proto =3D=3D PROTO_UDP)
     {
         *size_delta +=3D socks_process_outgoing_udp(&c->c2.to_link, c->c2.=
to_link_addr);
-        *to_addr =3D &c->c2.link_socket->socks_relay;
+        *to_addr =3D &ls->socks_relay;
     }
 }

@@ -924,7 +925,7 @@
  */

 void
-read_incoming_link(struct context *c)
+read_incoming_link(struct context *c, struct link_socket *ls)
 {
     /*
      * Set up for recvfrom call to read datagram
@@ -939,17 +940,17 @@
     c->c2.buf =3D c->c2.buffers->read_link_buf;
     ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));

-    status =3D link_socket_read(c->c2.link_socket,
+    status =3D link_socket_read(ls,
                               &c->c2.buf,
                               &c->c2.from);

-    if (socket_connection_reset(c->c2.link_socket, status))
+    if (socket_connection_reset(ls, status))
     {
 #if PORT_SHARE
-        if (port_share && socket_foreign_protocol_detected(c->c2.link_sock=
et))
+        if (port_share && socket_foreign_protocol_detected(ls))
         {
-            const struct buffer *fbuf =3D socket_foreign_protocol_head(c->=
c2.link_socket);
-            const int sd =3D socket_foreign_protocol_sd(c->c2.link_socket);
+            const struct buffer *fbuf =3D socket_foreign_protocol_head(ls);
+            const int sd =3D socket_foreign_protocol_sd(ls);
             port_share_redirect(port_share, fbuf, sd);
             register_signal(c->sig, SIGTERM, "port-share-redirect");
         }
@@ -976,7 +977,7 @@
     bool dco_win_timeout =3D tuntap_is_dco_win_timeout(c->c1.tuntap, statu=
s);

     /* check recvfrom status */
-    check_status(status, "read", c->c2.link_socket, NULL);
+    check_status(status, "read", ls, NULL);

     if (dco_win_timeout)
     {
@@ -984,7 +985,7 @@
     }

     /* Remove socks header if applicable */
-    socks_postprocess_incoming_link(c);
+    socks_postprocess_incoming_link(c, ls);

     perf_pop();
 }
@@ -1221,11 +1222,11 @@
 }

 static void
-process_incoming_link(struct context *c)
+process_incoming_link(struct context *c, struct link_socket *ls)
 {
     perf_push(PERF_PROC_IN_LINK);

-    struct link_socket_info *lsi =3D get_link_socket_info(c);
+    struct link_socket_info *lsi =3D &ls->info;
     const uint8_t *orig_buf =3D c->c2.buf.data;

     process_incoming_link_part1(c, lsi, false);
@@ -1724,7 +1725,7 @@
  */

 void
-process_outgoing_link(struct context *c)
+process_outgoing_link(struct context *c, struct link_socket *ls)
 {
     struct gc_arena gc =3D gc_new();
     int error_code =3D 0;
@@ -1767,7 +1768,7 @@

 #if PASSTOS_CAPABILITY
             /* Set TOS */
-            link_socket_set_tos(c->c2.link_socket);
+            link_socket_set_tos(ls);
 #endif

             /* Log packet send */
@@ -1778,7 +1779,7 @@
             }
 #endif
             msg(D_LINK_RW, "%s WRITE [%d] to %s: %s",
-                proto2ascii(c->c2.link_socket->info.proto, c->c2.link_sock=
et->info.af, true),
+                proto2ascii(ls->info.proto, ls->info.af, true),
                 BLEN(&c->c2.to_link),
                 print_link_socket_actual(c->c2.to_link_addr, &gc),
                 PROTO_DUMP(&c->c2.to_link, &gc));
@@ -1789,10 +1790,12 @@
                 int size_delta =3D 0;

                 /* If Socks5 over UDP, prepend header */
-                socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
+                socks_preprocess_outgoing_link(c, ls, &to_addr, &size_delt=
a);

                 /* Send packet */
-                size =3D (int)link_socket_write(c->c2.link_socket, &c->c2.=
to_link, to_addr);
+                size =3D (int)link_socket_write(ls,
+                                         &c->c2.to_link,
+                                         to_addr);

                 /* Undo effect of prepend */
                 link_socket_write_post_size_adjust(&size, size_delta, &c->=
c2.to_link);
@@ -1821,7 +1824,7 @@

         /* Check return status */
         error_code =3D openvpn_errno();
-        check_status(size, "write", c->c2.link_socket, NULL);
+        check_status(size, "write", ls, NULL);

         if (size > 0)
         {
@@ -2257,7 +2260,7 @@
 }

 void
-process_io(struct context *c)
+process_io(struct context *c, struct link_socket *ls)
 {
     const unsigned int status =3D c->c2.event_set_status;

@@ -2272,7 +2275,7 @@
     /* TCP/UDP port ready to accept write */
     if (status & SOCKET_WRITE)
     {
-        process_outgoing_link(c);
+        process_outgoing_link(c, ls);
     }
     /* TUN device ready to accept write */
     else if (status & TUN_WRITE)
@@ -2282,10 +2285,10 @@
     /* Incoming data on TCP/UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(c);
+        read_incoming_link(c, ls);
         if (!IS_SIG(c))
         {
-            process_incoming_link(c);
+            process_incoming_link(c, ls);
         }
     }
     /* Incoming data on TUN device */
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 422c591..f656634 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -72,7 +72,8 @@

 void pre_select(struct context *c);

-void process_io(struct context *c);
+void process_io(struct context *ci, struct link_socket *ls);
+

 /**********************************************************************/
 /**
@@ -128,10 +129,11 @@
  * context associated with the appropriate VPN tunnel for which data is
  * available to be read.
  *
- * @param c - The context structure which contains the external
- *     network socket from which to read incoming packets.
+ * @param c    The context structure which contains the external
+ *             network socket from which to read incoming packets.
+ * @param ls   The socket where the packet can be read from.
  */
-void read_incoming_link(struct context *c);
+void read_incoming_link(struct context *c, struct link_socket *ls);

 /**
  * Starts processing a packet read from the external network interface.
@@ -197,10 +199,11 @@
  *
  * If an error occurs, it is logged and the packet is dropped.
  *
- * @param c - The context structure of the VPN tunnel associated with the
- *     packet.
+ * @param c   The context structure of the VPN tunnel associated with the
+ *            packet.
+ * @param ls  The socket to be used to send the packet.
  */
-void process_outgoing_link(struct context *c);
+void process_outgoing_link(struct context *c, struct link_socket *ls);


 /*************************************************************************=
*/
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index e47712a..c699e6e 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -484,7 +484,7 @@
             ASSERT(mi);
             ASSERT(mi->context.c2.link_socket);
             set_prefix(mi);
-            read_incoming_link(&mi->context);
+            read_incoming_link(&mi->context, mi->context.c2.link_socket);
             clear_prefix();
             if (!IS_SIG(&mi->context))
             {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 268b430..e09111f 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -317,7 +317,7 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link =3D m->hmac_reply;
         m->top.c2.to_link_addr =3D m->hmac_reply_dest;
-        process_outgoing_link(&m->top);
+        process_outgoing_link(&m->top, &m->top.c2.link_socket[0]);
         m->hmac_reply_dest =3D NULL;
     }
 }
@@ -380,7 +380,7 @@
     /* Incoming data on UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(&m->top);
+        read_incoming_link(&m->top, m->top.c2.link_socket);
         if (!IS_SIG(&m->top))
         {
             multi_process_incoming_link(m, NULL, mpp_flags);
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index e403989..8e961ea 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -678,7 +678,7 @@
 {
     bool ret =3D true;
     set_prefix(mi);
-    process_outgoing_link(&mi->context);
+    process_outgoing_link(&mi->context, mi->context.c2.link_socket);
     ret =3D multi_process_post(m, mi, mpp_flags);
     clear_prefix();
     return ret;
diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c
index 16147b7..1db5422 100644
--- a/src/openvpn/openvpn.c
+++ b/src/openvpn/openvpn.c
@@ -91,7 +91,7 @@
         }

         /* process the I/O which triggered select */
-        process_io(c);
+        process_io(c, c->c2.link_socket);
         P2P_CHECK_SIG();

         perf_pop();
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 924e30c..302b106 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1828,6 +1828,7 @@
     sock->sd =3D SOCKET_UNDEFINED;
     sock->ctrl_sd =3D SOCKET_UNDEFINED;
     sock->ev_arg.type =3D EVENT_ARG_LINK_SOCKET;
+    sock->ev_arg.u.ls =3D sock;

     return sock;
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/758?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d
Gerrit-Change-Number: 758
Gerrit-PatchSet: 1
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newchange

--ZZU+JF2Lwy8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/758?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">pass link_socket object to i/o functions<br><br>In order to p=
repare the code to work with distinct sockets,<br>it is essential that i/o =
functions do not operate on any<br>hard-coded socket object (i.e. c-&gt;c2.=
link_socket).<br><br>This patch changes all the low-level i/o functionis to=
 work<br>with a socket specified as argument rather than a fixed one.<br><b=
r>Change-Id: I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d<br>Signed-off-by: An=
tonio Quartulli &lt;a@...2181...&gt;<br>---<br>M src/openvpn/event.h<br>M s=
rc/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/openvpn/mtcp.c<br>=
M src/openvpn/mudp.c<br>M src/openvpn/multi.h<br>M src/openvpn/openvpn.c<br=
>M src/openvpn/socket.c<br>8 files changed, 44 insertions(+), 36 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/5=
8/758/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/event.h b/src/openvpn/event.h</spa=
n><br><span>index 844ea7b..57341e0 100644</span><br><span>--- a/src/openvpn=
/event.h</span><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ -137,=
6 +137,7 @@</span><br><span>     event_arg_t type;</span><br><span>     uni=
on {</span><br><span>         struct multi_instance *mi; /* if type =3D EVE=
NT_ARG_MULTI_INSTANCE */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        struct link_socket *ls; /* if type =3D EVENT_ARG_LINK_SOCKET *=
/</span><br><span>     } u;</span><br><span> };</span><br><span> </span><br=
><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br=
><span>index a88a4bb..16b4497 100644</span><br><span>--- a/src/openvpn/forw=
ard.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -883,9=
 +883,9 @@</span><br><span>  */</span><br><span> </span><br><span> static i=
nline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_postp=
rocess_incoming_link(struct context *c)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+socks_postprocess_incoming_link(struct context *c, stru=
ct link_socket *ls)</span><br><span> {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    if (c-&gt;c2.link_socket-&gt;socks_proxy &amp;&amp; c-=
&gt;c2.link_socket-&gt;info.proto =3D=3D PROTO_UDP)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (ls-&gt;socks_proxy &amp;&amp; ls-=
&gt;info.proto =3D=3D PROTO_UDP)</span><br><span>     {</span><br><span>   =
      socks_process_incoming_udp(&amp;c-&gt;c2.buf, &amp;c-&gt;c2.from);</s=
pan><br><span>     }</span><br><span>@@ -893,13 +893,14 @@</span><br><span>=
 </span><br><span> static inline void</span><br><span> socks_preprocess_out=
going_link(struct context *c,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                               struct link_socket *ls,</span><br>=
<span>                                struct link_socket_actual **to_addr,<=
/span><br><span>                                int *size_delta)</span><br>=
<span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt=
;c2.link_socket-&gt;socks_proxy &amp;&amp; c-&gt;c2.link_socket-&gt;info.pr=
oto =3D=3D PROTO_UDP)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (ls-&gt;socks_proxy &amp;&amp; ls-&gt;info.proto =3D=3D PROTO_UDP)=
</span><br><span>     {</span><br><span>         *size_delta +=3D socks_pro=
cess_outgoing_udp(&amp;c-&gt;c2.to_link, c-&gt;c2.to_link_addr);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        *to_addr =3D &amp;c-&gt;=
c2.link_socket-&gt;socks_relay;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        *to_addr =3D &amp;ls-&gt;socks_relay;</span><br><span> =
    }</span><br><span> }</span><br><span> </span><br><span>@@ -924,7 +925,7=
 @@</span><br><span>  */</span><br><span> </span><br><span> void</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-read_incoming_link(struct contex=
t *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_incoming_=
link(struct context *c, struct link_socket *ls)</span><br><span> {</span><b=
r><span>     /*</span><br><span>      * Set up for recvfrom call to read da=
tagram</span><br><span>@@ -939,17 +940,17 @@</span><br><span>     c-&gt;c2.=
buf =3D c-&gt;c2.buffers-&gt;read_link_buf;</span><br><span>     ASSERT(buf=
_init(&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.headroom));</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D link_soc=
ket_read(c-&gt;c2.link_socket,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    status =3D link_socket_read(ls,</span><br><span>            =
                   &amp;c-&gt;c2.buf,</span><br><span>                     =
          &amp;c-&gt;c2.from);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (socket_connection_reset(c-&gt;c2.link_so=
cket, status))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
f (socket_connection_reset(ls, status))</span><br><span>     {</span><br><s=
pan> #if PORT_SHARE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      if (port_share &amp;&amp; socket_foreign_protocol_detected(c-&gt;c2.l=
ink_socket))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 if (port_share &amp;&amp; socket_foreign_protocol_detected(ls))</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       const struct buffer *fbuf =3D socket_foreign_protocol_head(c-&gt;c2.=
link_socket);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    const int sd =3D socket_foreign_protocol_sd(c-&gt;c2.link_socket);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            const struct=
 buffer *fbuf =3D socket_foreign_protocol_head(ls);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            const int sd =3D socket_forei=
gn_protocol_sd(ls);</span><br><span>             port_share_redirect(port_s=
hare, fbuf, sd);</span><br><span>             register_signal(c-&gt;sig, SI=
GTERM, &quot;port-share-redirect&quot;);</span><br><span>         }</span><=
br><span>@@ -976,7 +977,7 @@</span><br><span>     bool dco_win_timeout =3D =
tuntap_is_dco_win_timeout(c-&gt;c1.tuntap, status);</span><br><span> </span=
><br><span>     /* check recvfrom status */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    check_status(status, &quot;read&quot;, c-&gt;c2.l=
ink_socket, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   check_status(status, &quot;read&quot;, ls, NULL);</span><br><span> </spa=
n><br><span>     if (dco_win_timeout)</span><br><span>     {</span><br><spa=
n>@@ -984,7 +985,7 @@</span><br><span>     }</span><br><span> </span><br><s=
pan>     /* Remove socks header if applicable */</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    socks_postprocess_incoming_link(c);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    socks_postprocess_incomi=
ng_link(c, ls);</span><br><span> </span><br><span>     perf_pop();</span><b=
r><span> }</span><br><span>@@ -1221,11 +1222,11 @@</span><br><span> }</span=
><br><span> </span><br><span> static void</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-process_incoming_link(struct context *c)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+process_incoming_link(struct conte=
xt *c, struct link_socket *ls)</span><br><span> {</span><br><span>     perf=
_push(PERF_PROC_IN_LINK);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    struct link_socket_info *lsi =3D get_link_socket_=
info(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
link_socket_info *lsi =3D &amp;ls-&gt;info;</span><br><span>     const uint=
8_t *orig_buf =3D c-&gt;c2.buf.data;</span><br><span> </span><br><span>    =
 process_incoming_link_part1(c, lsi, false);</span><br><span>@@ -1724,7 +17=
25,7 @@</span><br><span>  */</span><br><span> </span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-process_outgoing_link(struct=
 context *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process=
_outgoing_link(struct context *c, struct link_socket *ls)</span><br><span> =
{</span><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>   =
  int error_code =3D 0;</span><br><span>@@ -1767,7 +1768,7 @@</span><br><sp=
an> </span><br><span> #if PASSTOS_CAPABILITY</span><br><span>             /=
* Set TOS */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
   link_socket_set_tos(c-&gt;c2.link_socket);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            link_socket_set_tos(ls);</span><br><s=
pan> #endif</span><br><span> </span><br><span>             /* Log packet se=
nd */</span><br><span>@@ -1778,7 +1779,7 @@</span><br><span>             }<=
/span><br><span> #endif</span><br><span>             msg(D_LINK_RW, &quot;%=
s WRITE [%d] to %s: %s&quot;,</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                proto2ascii(c-&gt;c2.link_socket-&gt;info.proto, c-=
&gt;c2.link_socket-&gt;info.af, true),</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                proto2ascii(ls-&gt;info.proto, ls-&gt;in=
fo.af, true),</span><br><span>                 BLEN(&amp;c-&gt;c2.to_link),=
</span><br><span>                 print_link_socket_actual(c-&gt;c2.to_link=
_addr, &amp;gc),</span><br><span>                 PROTO_DUMP(&amp;c-&gt;c2.=
to_link, &amp;gc));</span><br><span>@@ -1789,10 +1790,12 @@</span><br><span=
>                 int size_delta =3D 0;</span><br><span> </span><br><span> =
                /* If Socks5 over UDP, prepend header */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-                socks_preprocess_outgoin=
g_link(c, &amp;to_addr, &amp;size_delta);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                socks_preprocess_outgoing_link(c, ls,=
 &amp;to_addr, &amp;size_delta);</span><br><span> </span><br><span>        =
         /* Send packet */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                size =3D (int)link_socket_write(c-&gt;c2.link_socket, =
&amp;c-&gt;c2.to_link, to_addr);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                size =3D (int)link_socket_write(ls,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                              =
           &amp;c-&gt;c2.to_link,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                                         to_addr);</span><br>=
<span> </span><br><span>                 /* Undo effect of prepend */</span=
><br><span>                 link_socket_write_post_size_adjust(&amp;size, s=
ize_delta, &amp;c-&gt;c2.to_link);</span><br><span>@@ -1821,7 +1824,7 @@</s=
pan><br><span> </span><br><span>         /* Check return status */</span><b=
r><span>         error_code =3D openvpn_errno();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-        check_status(size, &quot;write&quot;, c-=
&gt;c2.link_socket, NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        check_status(size, &quot;write&quot;, ls, NULL);</span><br><=
span> </span><br><span>         if (size &gt; 0)</span><br><span>         {=
</span><br><span>@@ -2257,7 +2260,7 @@</span><br><span> }</span><br><span> =
</span><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-process_io(struct context *c)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+process_io(struct context *c, struct link_socket *ls)</span><br>=
<span> {</span><br><span>     const unsigned int status =3D c-&gt;c2.event_=
set_status;</span><br><span> </span><br><span>@@ -2272,7 +2275,7 @@</span><=
br><span>     /* TCP/UDP port ready to accept write */</span><br><span>    =
 if (status &amp; SOCKET_WRITE)</span><br><span>     {</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-        process_outgoing_link(c);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        process_outgoing_lin=
k(c, ls);</span><br><span>     }</span><br><span>     /* TUN device ready t=
o accept write */</span><br><span>     else if (status &amp; TUN_WRITE)</sp=
an><br><span>@@ -2282,10 +2285,10 @@</span><br><span>     /* Incoming data =
on TCP/UDP port */</span><br><span>     else if (status &amp; SOCKET_READ)<=
/span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        read_incoming_link(c);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        read_incoming_link(c, ls);</span><br><span>         if =
(!IS_SIG(c))</span><br><span>         {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-            process_incoming_link(c);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            process_incoming_link(c, ls=
);</span><br><span>         }</span><br><span>     }</span><br><span>     /=
* Incoming data on TUN device */</span><br><span>diff --git a/src/openvpn/f=
orward.h b/src/openvpn/forward.h</span><br><span>index 422c591..f656634 100=
644</span><br><span>--- a/src/openvpn/forward.h</span><br><span>+++ b/src/o=
penvpn/forward.h</span><br><span>@@ -72,7 +72,8 @@</span><br><span> </span>=
<br><span> void pre_select(struct context *c);</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-void process_io(struct context *=
c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void process_io(=
struct context *ci, struct link_socket *ls);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> </span><br><span> /*************=
*********************************************************/</span><br><span>=
 /**</span><br><span>@@ -128,10 +129,11 @@</span><br><span>  * context asso=
ciated with the appropriate VPN tunnel for which data is</span><br><span>  =
* available to be read.</span><br><span>  *</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">- * @param c - The context structure which contains th=
e external</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *     netw=
ork socket from which to read incoming packets.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param c    The context structure which cont=
ains the external</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             network socket from which to read incoming packets.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * @param ls   The socket wher=
e the packet can be read from.</span><br><span>  */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-void read_incoming_link(struct context *c);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void read_incoming_=
link(struct context *c, struct link_socket *ls);</span><br><span> </span><b=
r><span> /**</span><br><span>  * Starts processing a packet read from the e=
xternal network interface.</span><br><span>@@ -197,10 +199,11 @@</span><br>=
<span>  *</span><br><span>  * If an error occurs, it is logged and the pack=
et is dropped.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * @param c - The context structure of the VPN tunnel associat=
ed with the</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *     pac=
ket.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param c   T=
he context structure of the VPN tunnel associated with the</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *            packet.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param ls  The socket to be use=
d to send the packet.</span><br><span>  */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-void process_outgoing_link(struct context *c);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+void process_outgoing_link(=
struct context *c, struct link_socket *ls);</span><br><span> </span><br><sp=
an> </span><br><span> /****************************************************=
**********************/</span><br><span>diff --git a/src/openvpn/mtcp.c b/s=
rc/openvpn/mtcp.c</span><br><span>index e47712a..c699e6e 100644</span><br><=
span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</spa=
n><br><span>@@ -484,7 +484,7 @@</span><br><span>             ASSERT(mi);</s=
pan><br><span>             ASSERT(mi-&gt;context.c2.link_socket);</span><br=
><span>             set_prefix(mi);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-            read_incoming_link(&amp;mi-&gt;context);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            read_incoming_li=
nk(&amp;mi-&gt;context, mi-&gt;context.c2.link_socket);</span><br><span>   =
          clear_prefix();</span><br><span>             if (!IS_SIG(&amp;mi-=
&gt;context))</span><br><span>             {</span><br><span>diff --git a/s=
rc/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index 268b430..e0911=
1f 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/sr=
c/openvpn/mudp.c</span><br><span>@@ -317,7 +317,7 @@</span><br><span>      =
   msg_set_prefix(&quot;Connection Attempt&quot;);</span><br><span>        =
 m-&gt;top.c2.to_link =3D m-&gt;hmac_reply;</span><br><span>         m-&gt;=
top.c2.to_link_addr =3D m-&gt;hmac_reply_dest;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        process_outgoing_link(&amp;m-&gt;top);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        process_outgoin=
g_link(&amp;m-&gt;top, &amp;m-&gt;top.c2.link_socket[0]);</span><br><span> =
        m-&gt;hmac_reply_dest =3D NULL;</span><br><span>     }</span><br><s=
pan> }</span><br><span>@@ -380,7 +380,7 @@</span><br><span>     /* Incoming=
 data on UDP port */</span><br><span>     else if (status &amp; SOCKET_READ=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        read_incoming_link(&amp;m-&gt;top);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        read_incoming_link(&amp;m-&gt;top, m-&gt=
;top.c2.link_socket);</span><br><span>         if (!IS_SIG(&amp;m-&gt;top))=
</span><br><span>         {</span><br><span>             multi_process_inco=
ming_link(m, NULL, mpp_flags);</span><br><span>diff --git a/src/openvpn/mul=
ti.h b/src/openvpn/multi.h</span><br><span>index e403989..8e961ea 100644</s=
pan><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/m=
ulti.h</span><br><span>@@ -678,7 +678,7 @@</span><br><span> {</span><br><sp=
an>     bool ret =3D true;</span><br><span>     set_prefix(mi);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    process_outgoing_link(&amp;mi=
-&gt;context);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    p=
rocess_outgoing_link(&amp;mi-&gt;context, mi-&gt;context.c2.link_socket);</=
span><br><span>     ret =3D multi_process_post(m, mi, mpp_flags);</span><br=
><span>     clear_prefix();</span><br><span>     return ret;</span><br><spa=
n>diff --git a/src/openvpn/openvpn.c b/src/openvpn/openvpn.c</span><br><spa=
n>index 16147b7..1db5422 100644</span><br><span>--- a/src/openvpn/openvpn.c=
</span><br><span>+++ b/src/openvpn/openvpn.c</span><br><span>@@ -91,7 +91,7=
 @@</span><br><span>         }</span><br><span> </span><br><span>         /=
* process the I/O which triggered select */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        process_io(c);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        process_io(c, c-&gt;c2.link_socket);</span=
><br><span>         P2P_CHECK_SIG();</span><br><span> </span><br><span>    =
     perf_pop();</span><br><span>diff --git a/src/openvpn/socket.c b/src/op=
envpn/socket.c</span><br><span>index 924e30c..302b106 100644</span><br><spa=
n>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</sp=
an><br><span>@@ -1828,6 +1828,7 @@</span><br><span>     sock-&gt;sd =3D SOC=
KET_UNDEFINED;</span><br><span>     sock-&gt;ctrl_sd =3D SOCKET_UNDEFINED;<=
/span><br><span>     sock-&gt;ev_arg.type =3D EVENT_ARG_LINK_SOCKET;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;ev_arg.u.ls =
=3D sock;</span><br><span> </span><br><span>     return sock;</span><br><sp=
an> }</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/758?usp=3Demail">change 758</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/758?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8eae2d3356bbcc5d632eeb4fbe8=
0de8009d9b40d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 758 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;a@...2181...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ZZU+JF2Lwy8=--

