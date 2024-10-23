From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Oct 2024 12:39:02 +0000
In-Reply-To: <gerrit.1727098847000.I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d@...2715...>
References: <gerrit.1727098847000.I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <46b0b4e2aa8200c7a003c5f25749ab5320b1959e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4jojG/YOnOE="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--4jojG/YOnOE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/75=
8?usp=3Demail )

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
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20241023083444.27951-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
603.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/event.h
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.h
M src/openvpn/openvpn.c
M src/openvpn/socket.c
M src/openvpn/socket.h
9 files changed, 76 insertions(+), 68 deletions(-)




diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 844ea7b..b3ba183 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -137,6 +137,7 @@
     event_arg_t type;
     union {
         struct multi_instance *mi; /* if type =3D EVENT_ARG_MULTI_INSTANCE=
 */
+        struct link_socket *sock; /* if type =3D EVENT_ARG_LINK_SOCKET */
     } u;
 };

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6df01d1..6f279ec 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -884,9 +884,9 @@
  */

 static inline void
-socks_postprocess_incoming_link(struct context *c)
+socks_postprocess_incoming_link(struct context *c, struct link_socket *soc=
k)
 {
-    if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto =
=3D=3D PROTO_UDP)
+    if (sock->socks_proxy && sock->info.proto =3D=3D PROTO_UDP)
     {
         socks_process_incoming_udp(&c->c2.buf, &c->c2.from);
     }
@@ -894,13 +894,14 @@

 static inline void
 socks_preprocess_outgoing_link(struct context *c,
+                               struct link_socket *sock,
                                struct link_socket_actual **to_addr,
                                int *size_delta)
 {
-    if (c->c2.link_socket->socks_proxy && c->c2.link_socket->info.proto =
=3D=3D PROTO_UDP)
+    if (sock->socks_proxy && sock->info.proto =3D=3D PROTO_UDP)
     {
         *size_delta +=3D socks_process_outgoing_udp(&c->c2.to_link, c->c2.=
to_link_addr);
-        *to_addr =3D &c->c2.link_socket->socks_relay;
+        *to_addr =3D &sock->socks_relay;
     }
 }

@@ -925,7 +926,7 @@
  */

 void
-read_incoming_link(struct context *c)
+read_incoming_link(struct context *c, struct link_socket *sock)
 {
     /*
      * Set up for recvfrom call to read datagram
@@ -940,17 +941,17 @@
     c->c2.buf =3D c->c2.buffers->read_link_buf;
     ASSERT(buf_init(&c->c2.buf, c->c2.frame.buf.headroom));

-    status =3D link_socket_read(c->c2.link_socket,
+    status =3D link_socket_read(sock,
                               &c->c2.buf,
                               &c->c2.from);

-    if (socket_connection_reset(c->c2.link_socket, status))
+    if (socket_connection_reset(sock, status))
     {
 #if PORT_SHARE
-        if (port_share && socket_foreign_protocol_detected(c->c2.link_sock=
et))
+        if (port_share && socket_foreign_protocol_detected(sock))
         {
-            const struct buffer *fbuf =3D socket_foreign_protocol_head(c->=
c2.link_socket);
-            const int sd =3D socket_foreign_protocol_sd(c->c2.link_socket);
+            const struct buffer *fbuf =3D socket_foreign_protocol_head(soc=
k);
+            const int sd =3D socket_foreign_protocol_sd(sock);
             port_share_redirect(port_share, fbuf, sd);
             register_signal(c->sig, SIGTERM, "port-share-redirect");
         }
@@ -977,7 +978,7 @@
     bool dco_win_timeout =3D tuntap_is_dco_win_timeout(c->c1.tuntap, statu=
s);

     /* check recvfrom status */
-    check_status(status, "read", c->c2.link_socket, NULL);
+    check_status(status, "read", sock, NULL);

     if (dco_win_timeout)
     {
@@ -985,7 +986,7 @@
     }

     /* Remove socks header if applicable */
-    socks_postprocess_incoming_link(c);
+    socks_postprocess_incoming_link(c, sock);

     perf_pop();
 }
@@ -1222,11 +1223,11 @@
 }

 static void
-process_incoming_link(struct context *c)
+process_incoming_link(struct context *c, struct link_socket *sock)
 {
     perf_push(PERF_PROC_IN_LINK);

-    struct link_socket_info *lsi =3D get_link_socket_info(c);
+    struct link_socket_info *lsi =3D &sock->info;
     const uint8_t *orig_buf =3D c->c2.buf.data;

     process_incoming_link_part1(c, lsi, false);
@@ -1732,7 +1733,7 @@
  */

 void
-process_outgoing_link(struct context *c)
+process_outgoing_link(struct context *c, struct link_socket *sock)
 {
     struct gc_arena gc =3D gc_new();
     int error_code =3D 0;
@@ -1775,7 +1776,7 @@

 #if PASSTOS_CAPABILITY
             /* Set TOS */
-            link_socket_set_tos(c->c2.link_socket);
+            link_socket_set_tos(sock);
 #endif

             /* Log packet send */
@@ -1786,7 +1787,7 @@
             }
 #endif
             msg(D_LINK_RW, "%s WRITE [%d] to %s: %s",
-                proto2ascii(c->c2.link_socket->info.proto, c->c2.link_sock=
et->info.af, true),
+                proto2ascii(sock->info.proto, sock->info.af, true),
                 BLEN(&c->c2.to_link),
                 print_link_socket_actual(c->c2.to_link_addr, &gc),
                 PROTO_DUMP(&c->c2.to_link, &gc));
@@ -1797,10 +1798,12 @@
                 int size_delta =3D 0;

                 /* If Socks5 over UDP, prepend header */
-                socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
+                socks_preprocess_outgoing_link(c, sock, &to_addr, &size_de=
lta);

                 /* Send packet */
-                size =3D (int)link_socket_write(c->c2.link_socket, &c->c2.=
to_link, to_addr);
+                size =3D (int)link_socket_write(sock,
+                                              &c->c2.to_link,
+                                              to_addr);

                 /* Undo effect of prepend */
                 link_socket_write_post_size_adjust(&size, size_delta, &c->=
c2.to_link);
@@ -1829,7 +1832,7 @@

         /* Check return status */
         error_code =3D openvpn_errno();
-        check_status(size, "write", c->c2.link_socket, NULL);
+        check_status(size, "write", sock, NULL);

         if (size > 0)
         {
@@ -2272,7 +2275,7 @@
 }

 void
-process_io(struct context *c)
+process_io(struct context *c, struct link_socket *sock)
 {
     const unsigned int status =3D c->c2.event_set_status;

@@ -2287,7 +2290,7 @@
     /* TCP/UDP port ready to accept write */
     if (status & SOCKET_WRITE)
     {
-        process_outgoing_link(c);
+        process_outgoing_link(c, sock);
     }
     /* TUN device ready to accept write */
     else if (status & TUN_WRITE)
@@ -2297,10 +2300,10 @@
     /* Incoming data on TCP/UDP port */
     else if (status & SOCKET_READ)
     {
-        read_incoming_link(c);
+        read_incoming_link(c, sock);
         if (!IS_SIG(c))
         {
-            process_incoming_link(c);
+            process_incoming_link(c, sock);
         }
     }
     /* Incoming data on TUN device */
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 422c591..8ef19b4 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -72,7 +72,8 @@

 void pre_select(struct context *c);

-void process_io(struct context *c);
+void process_io(struct context *c, struct link_socket *sock);
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
+ * @param sock   The socket where the packet can be read from.
  */
-void read_incoming_link(struct context *c);
+void read_incoming_link(struct context *c, struct link_socket *sock);

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
+ * @param sock  The socket to be used to send the packet.
  */
-void process_outgoing_link(struct context *c);
+void process_outgoing_link(struct context *c, struct link_socket *sock);


 /*************************************************************************=
*/
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 6faf45a..28f6e8e 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -476,7 +476,7 @@
             ASSERT(mi);
             ASSERT(mi->context.c2.link_socket);
             set_prefix(mi);
-            read_incoming_link(&mi->context);
+            read_incoming_link(&mi->context, mi->context.c2.link_socket);
             clear_prefix();
             if (!IS_SIG(&mi->context))
             {
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 268b430..5fbd7b0 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -317,7 +317,7 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link =3D m->hmac_reply;
         m->top.c2.to_link_addr =3D m->hmac_reply_dest;
-        process_outgoing_link(&m->top);
+        process_outgoing_link(&m->top, m->top.c2.link_socket);
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
index 1b99ef7..f386a3b 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -683,7 +683,7 @@
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
index cf04090..efd742c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -969,12 +969,12 @@
 }

 bool
-link_socket_update_flags(struct link_socket *ls, unsigned int sockflags)
+link_socket_update_flags(struct link_socket *sock, unsigned int sockflags)
 {
-    if (ls && socket_defined(ls->sd))
+    if (sock && socket_defined(sock->sd))
     {
-        ls->sockflags |=3D sockflags;
-        return socket_set_flags(ls->sd, ls->sockflags);
+        sock->sockflags |=3D sockflags;
+        return socket_set_flags(sock->sd, sock->sockflags);
     }
     else
     {
@@ -983,13 +983,13 @@
 }

 void
-link_socket_update_buffer_sizes(struct link_socket *ls, int rcvbuf, int sn=
dbuf)
+link_socket_update_buffer_sizes(struct link_socket *sock, int rcvbuf, int =
sndbuf)
 {
-    if (ls && socket_defined(ls->sd))
+    if (sock && socket_defined(sock->sd))
     {
-        ls->socket_buffer_sizes.sndbuf =3D sndbuf;
-        ls->socket_buffer_sizes.rcvbuf =3D rcvbuf;
-        socket_set_buffers(ls->sd, &ls->socket_buffer_sizes, true);
+        sock->socket_buffer_sizes.sndbuf =3D sndbuf;
+        sock->socket_buffer_sizes.rcvbuf =3D rcvbuf;
+        socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);
     }
 }

@@ -1831,6 +1831,7 @@
     sock->sd =3D SOCKET_UNDEFINED;
     sock->ctrl_sd =3D SOCKET_UNDEFINED;
     sock->ev_arg.type =3D EVENT_ARG_LINK_SOCKET;
+    sock->ev_arg.u.sock =3D sock;

     return sock;
 }
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 27caab4..465d92b 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -451,9 +451,9 @@

 void setenv_trusted(struct env_set *es, const struct link_socket_info *inf=
o);

-bool link_socket_update_flags(struct link_socket *ls, unsigned int sockfla=
gs);
+bool link_socket_update_flags(struct link_socket *sock, unsigned int sockf=
lags);

-void link_socket_update_buffer_sizes(struct link_socket *ls, int rcvbuf, i=
nt sndbuf);
+void link_socket_update_buffer_sizes(struct link_socket *sock, int rcvbuf,=
 int sndbuf);

 /*
  * Low-level functions
@@ -1199,13 +1199,13 @@
  * Extract TOS bits.  Assumes that ipbuf is a valid IPv4 packet.
  */
 static inline void
-link_socket_extract_tos(struct link_socket *ls, const struct buffer *ipbuf)
+link_socket_extract_tos(struct link_socket *sock, const struct buffer *ipb=
uf)
 {
-    if (ls && ipbuf)
+    if (sock && ipbuf)
     {
         struct openvpn_iphdr *iph =3D (struct openvpn_iphdr *) BPTR(ipbuf);
-        ls->ptos =3D iph->tos;
-        ls->ptos_defined =3D true;
+        sock->ptos =3D iph->tos;
+        sock->ptos_defined =3D true;
     }
 }

@@ -1214,11 +1214,11 @@
  * from tunnel packet.
  */
 static inline void
-link_socket_set_tos(struct link_socket *ls)
+link_socket_set_tos(struct link_socket *sock)
 {
-    if (ls && ls->ptos_defined)
+    if (sock && sock->ptos_defined)
     {
-        setsockopt(ls->sd, IPPROTO_IP, IP_TOS, (const void *)&ls->ptos, si=
zeof(ls->ptos));
+        setsockopt(sock->sd, IPPROTO_IP, IP_TOS, (const void *)&sock->ptos=
, sizeof(sock->ptos));
     }
 }

@@ -1229,50 +1229,50 @@
  */

 static inline bool
-socket_read_residual(const struct link_socket *s)
+socket_read_residual(const struct link_socket *sock)
 {
-    return s && s->stream_buf.residual_fully_formed;
+    return sock && sock->stream_buf.residual_fully_formed;
 }

 static inline event_t
-socket_event_handle(const struct link_socket *s)
+socket_event_handle(const struct link_socket *sock)
 {
 #ifdef _WIN32
-    return &s->rw_handle;
+    return &sock->rw_handle;
 #else
-    return s->sd;
+    return sock->sd;
 #endif
 }

-event_t socket_listen_event_handle(struct link_socket *s);
+event_t socket_listen_event_handle(struct link_socket *sock);

 unsigned int
-socket_set(struct link_socket *s,
+socket_set(struct link_socket *sock,
            struct event_set *es,
            unsigned int rwflags,
            void *arg,
            unsigned int *persistent);

 static inline void
-socket_set_listen_persistent(struct link_socket *s,
+socket_set_listen_persistent(struct link_socket *sock,
                              struct event_set *es,
                              void *arg)
 {
-    if (s && !s->listen_persistent_queued)
+    if (sock && !sock->listen_persistent_queued)
     {
-        event_ctl(es, socket_listen_event_handle(s), EVENT_READ, arg);
-        s->listen_persistent_queued =3D true;
+        event_ctl(es, socket_listen_event_handle(sock), EVENT_READ, arg);
+        sock->listen_persistent_queued =3D true;
     }
 }

 static inline void
-socket_reset_listen_persistent(struct link_socket *s)
+socket_reset_listen_persistent(struct link_socket *sock)
 {
 #ifdef _WIN32
-    reset_net_event_win32(&s->listen_handle, s->sd);
+    reset_net_event_win32(&sock->listen_handle, sock->sd);
 #endif
 }

-const char *socket_stat(const struct link_socket *s, unsigned int rwflags,=
 struct gc_arena *gc);
+const char *socket_stat(const struct link_socket *sock, unsigned int rwfla=
gs, struct gc_arena *gc);

 #endif /* SOCKET_H */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/758?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d
Gerrit-Change-Number: 758
Gerrit-PatchSet: 7
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-MessageType: merged

--4jojG/YOnOE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/758?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">pass link_socket object to i/o functions<br><b=
r>In order to prepare the code to work with distinct sockets,<br>it is esse=
ntial that i/o functions do not operate on any<br>hard-coded socket object =
(i.e. c-&gt;c2.link_socket).<br><br>This patch changes all the low-level i/=
o functionis to work<br>with a socket specified as argument rather than a f=
ixed one.<br><br>Change-Id: I8eae2d3356bbcc5d632eeb4fbe80de8009d9b40d<br>Si=
gned-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>Signed-off-by: Gianm=
arco De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Message-Id: &lt;20241023083444.27951-1-gert@...1186...=
.1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1011...=
eforge.net/msg29603.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>---<br>M src/openvpn/event.h<br>M src/openvpn/forward.c<br>M src/op=
envpn/forward.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M src/op=
envpn/multi.h<br>M src/openvpn/openvpn.c<br>M src/openvpn/socket.c<br>M src=
/openvpn/socket.h<br>9 files changed, 76 insertions(+), 68 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span>i=
ndex 844ea7b..b3ba183 100644</span><br><span>--- a/src/openvpn/event.h</spa=
n><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ -137,6 +137,7 @@</=
span><br><span>     event_arg_t type;</span><br><span>     union {</span><b=
r><span>         struct multi_instance *mi; /* if type =3D EVENT_ARG_MULTI_=
INSTANCE */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
struct link_socket *sock; /* if type =3D EVENT_ARG_LINK_SOCKET */</span><br=
><span>     } u;</span><br><span> };</span><br><span> </span><br><span>diff=
 --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>inde=
x 6df01d1..6f279ec 100644</span><br><span>--- a/src/openvpn/forward.c</span=
><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -884,9 +884,9 @@<=
/span><br><span>  */</span><br><span> </span><br><span> static inline void<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-socks_postprocess_inco=
ming_link(struct context *c)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+socks_postprocess_incoming_link(struct context *c, struct link_soc=
ket *sock)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    if (c-&gt;c2.link_socket-&gt;socks_proxy &amp;&amp; c-&gt;c2.li=
nk_socket-&gt;info.proto =3D=3D PROTO_UDP)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;inf=
o.proto =3D=3D PROTO_UDP)</span><br><span>     {</span><br><span>         s=
ocks_process_incoming_udp(&amp;c-&gt;c2.buf, &amp;c-&gt;c2.from);</span><br=
><span>     }</span><br><span>@@ -894,13 +894,14 @@</span><br><span> </span=
><br><span> static inline void</span><br><span> socks_preprocess_outgoing_l=
ink(struct context *c,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                               struct link_socket *sock,</span><br><span=
>                                struct link_socket_actual **to_addr,</span=
><br><span>                                int *size_delta)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (c-&gt;c2.l=
ink_socket-&gt;socks_proxy &amp;&amp; c-&gt;c2.link_socket-&gt;info.proto =
=3D=3D PROTO_UDP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  if (sock-&gt;socks_proxy &amp;&amp; sock-&gt;info.proto =3D=3D PROTO_UDP)=
</span><br><span>     {</span><br><span>         *size_delta +=3D socks_pro=
cess_outgoing_udp(&amp;c-&gt;c2.to_link, c-&gt;c2.to_link_addr);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        *to_addr =3D &amp;c-&gt;=
c2.link_socket-&gt;socks_relay;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        *to_addr =3D &amp;sock-&gt;socks_relay;</span><br><span=
>     }</span><br><span> }</span><br><span> </span><br><span>@@ -925,7 +926=
,7 @@</span><br><span>  */</span><br><span> </span><br><span> void</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-read_incoming_link(struct cont=
ext *c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+read_incomin=
g_link(struct context *c, struct link_socket *sock)</span><br><span> {</spa=
n><br><span>     /*</span><br><span>      * Set up for recvfrom call to rea=
d datagram</span><br><span>@@ -940,17 +941,17 @@</span><br><span>     c-&gt=
;c2.buf =3D c-&gt;c2.buffers-&gt;read_link_buf;</span><br><span>     ASSERT=
(buf_init(&amp;c-&gt;c2.buf, c-&gt;c2.frame.buf.headroom));</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    status =3D link=
_socket_read(c-&gt;c2.link_socket,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    status =3D link_socket_read(sock,</span><br><span>      =
                         &amp;c-&gt;c2.buf,</span><br><span>               =
                &amp;c-&gt;c2.from);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    if (socket_connection_reset(c-&gt;c2.l=
ink_socket, status))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (socket_connection_reset(sock, status))</span><br><span>     {</spa=
n><br><span> #if PORT_SHARE</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        if (port_share &amp;&amp; socket_foreign_protocol_detected(c-=
&gt;c2.link_socket))</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        if (port_share &amp;&amp; socket_foreign_protocol_detected(sock))<=
/span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            const struct buffer *fbuf =3D socket_foreign_protocol_head=
(c-&gt;c2.link_socket);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            const int sd =3D socket_foreign_protocol_sd(c-&gt;c2.link_soc=
ket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            co=
nst struct buffer *fbuf =3D socket_foreign_protocol_head(sock);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            const int sd =3D so=
cket_foreign_protocol_sd(sock);</span><br><span>             port_share_red=
irect(port_share, fbuf, sd);</span><br><span>             register_signal(c=
-&gt;sig, SIGTERM, &quot;port-share-redirect&quot;);</span><br><span>      =
   }</span><br><span>@@ -977,7 +978,7 @@</span><br><span>     bool dco_win_=
timeout =3D tuntap_is_dco_win_timeout(c-&gt;c1.tuntap, status);</span><br><=
span> </span><br><span>     /* check recvfrom status */</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    check_status(status, &quot;read&quot;=
, c-&gt;c2.link_socket, NULL);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    check_status(status, &quot;read&quot;, sock, NULL);</span><b=
r><span> </span><br><span>     if (dco_win_timeout)</span><br><span>     {<=
/span><br><span>@@ -985,7 +986,7 @@</span><br><span>     }</span><br><span>=
 </span><br><span>     /* Remove socks header if applicable */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    socks_postprocess_incoming_lin=
k(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socks_post=
process_incoming_link(c, sock);</span><br><span> </span><br><span>     perf=
_pop();</span><br><span> }</span><br><span>@@ -1222,11 +1223,11 @@</span><b=
r><span> }</span><br><span> </span><br><span> static void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-process_incoming_link(struct context *c=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_incoming_l=
ink(struct context *c, struct link_socket *sock)</span><br><span> {</span><=
br><span>     perf_push(PERF_PROC_IN_LINK);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    struct link_socket_info *lsi =
=3D get_link_socket_info(c);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct link_socket_info *lsi =3D &amp;sock-&gt;info;</span><br=
><span>     const uint8_t *orig_buf =3D c-&gt;c2.buf.data;</span><br><span>=
 </span><br><span>     process_incoming_link_part1(c, lsi, false);</span><b=
r><span>@@ -1732,7 +1733,7 @@</span><br><span>  */</span><br><span> </span>=
<br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-proces=
s_outgoing_link(struct context *c)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+process_outgoing_link(struct context *c, struct link_socket =
*sock)</span><br><span> {</span><br><span>     struct gc_arena gc =3D gc_ne=
w();</span><br><span>     int error_code =3D 0;</span><br><span>@@ -1775,7 =
+1776,7 @@</span><br><span> </span><br><span> #if PASSTOS_CAPABILITY</span>=
<br><span>             /* Set TOS */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            link_socket_set_tos(c-&gt;c2.link_socket);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            link_socket_s=
et_tos(sock);</span><br><span> #endif</span><br><span> </span><br><span>   =
          /* Log packet send */</span><br><span>@@ -1786,7 +1787,7 @@</span=
><br><span>             }</span><br><span> #endif</span><br><span>         =
    msg(D_LINK_RW, &quot;%s WRITE [%d] to %s: %s&quot;,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                proto2ascii(c-&gt;c2.link=
_socket-&gt;info.proto, c-&gt;c2.link_socket-&gt;info.af, true),</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                proto2ascii(so=
ck-&gt;info.proto, sock-&gt;info.af, true),</span><br><span>               =
  BLEN(&amp;c-&gt;c2.to_link),</span><br><span>                 print_link_=
socket_actual(c-&gt;c2.to_link_addr, &amp;gc),</span><br><span>            =
     PROTO_DUMP(&amp;c-&gt;c2.to_link, &amp;gc));</span><br><span>@@ -1797,=
10 +1798,12 @@</span><br><span>                 int size_delta =3D 0;</span=
><br><span> </span><br><span>                 /* If Socks5 over UDP, prepen=
d header */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      socks_preprocess_outgoing_link(c, &amp;to_addr, &amp;size_delta);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                socks_p=
reprocess_outgoing_link(c, sock, &amp;to_addr, &amp;size_delta);</span><br>=
<span> </span><br><span>                 /* Send packet */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                size =3D (int)link_soc=
ket_write(c-&gt;c2.link_socket, &amp;c-&gt;c2.to_link, to_addr);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                size =3D (int)=
link_socket_write(sock,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                                              &amp;c-&gt;c2.to_link,</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
                        to_addr);</span><br><span> </span><br><span>       =
          /* Undo effect of prepend */</span><br><span>                 lin=
k_socket_write_post_size_adjust(&amp;size, size_delta, &amp;c-&gt;c2.to_lin=
k);</span><br><span>@@ -1829,7 +1832,7 @@</span><br><span> </span><br><span=
>         /* Check return status */</span><br><span>         error_code =3D=
 openvpn_errno();</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    check_status(size, &quot;write&quot;, c-&gt;c2.link_socket, NULL);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        check_status(siz=
e, &quot;write&quot;, sock, NULL);</span><br><span> </span><br><span>      =
   if (size &gt; 0)</span><br><span>         {</span><br><span>@@ -2272,7 +=
2275,7 @@</span><br><span> }</span><br><span> </span><br><span> void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-process_io(struct context *c=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+process_io(struct =
context *c, struct link_socket *sock)</span><br><span> {</span><br><span>  =
   const unsigned int status =3D c-&gt;c2.event_set_status;</span><br><span=
> </span><br><span>@@ -2287,7 +2290,7 @@</span><br><span>     /* TCP/UDP po=
rt ready to accept write */</span><br><span>     if (status &amp; SOCKET_WR=
ITE)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        process_outgoing_link(c);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        process_outgoing_link(c, sock);</span><br><span=
>     }</span><br><span>     /* TUN device ready to accept write */</span><=
br><span>     else if (status &amp; TUN_WRITE)</span><br><span>@@ -2297,10 =
+2300,10 @@</span><br><span>     /* Incoming data on TCP/UDP port */</span>=
<br><span>     else if (status &amp; SOCKET_READ)</span><br><span>     {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        read_incoming_li=
nk(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        read_=
incoming_link(c, sock);</span><br><span>         if (!IS_SIG(c))</span><br>=
<span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       process_incoming_link(c);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            process_incoming_link(c, sock);</span><br><span>  =
       }</span><br><span>     }</span><br><span>     /* Incoming data on TU=
N device */</span><br><span>diff --git a/src/openvpn/forward.h b/src/openvp=
n/forward.h</span><br><span>index 422c591..8ef19b4 100644</span><br><span>-=
-- a/src/openvpn/forward.h</span><br><span>+++ b/src/openvpn/forward.h</spa=
n><br><span>@@ -72,7 +72,8 @@</span><br><span> </span><br><span> void pre_s=
elect(struct context *c);</span><br><span> </span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-void process_io(struct context *c);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+void process_io(struct context *c, st=
ruct link_socket *sock);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> </span><br><span> /*********************************=
*************************************/</span><br><span> /**</span><br><span=
>@@ -128,10 +129,11 @@</span><br><span>  * context associated with the appr=
opriate VPN tunnel for which data is</span><br><span>  * available to be re=
ad.</span><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * @param c - The context structure which contains the external</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- *     network socket from whic=
h to read incoming packets.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param c    The context structure which contains the external</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             network=
 socket from which to read incoming packets.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @param sock   The socket where the packet can b=
e read from.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-void read_incoming_link(struct context *c);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+void read_incoming_link(struct context =
*c, struct link_socket *sock);</span><br><span> </span><br><span> /**</span=
><br><span>  * Starts processing a packet read from the external network in=
terface.</span><br><span>@@ -197,10 +199,11 @@</span><br><span>  *</span><b=
r><span>  * If an error occurs, it is logged and the packet is dropped.</sp=
an><br><span>  *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @p=
aram c - The context structure of the VPN tunnel associated with the</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">- *     packet.</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param c   The context structu=
re of the VPN tunnel associated with the</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *            packet.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param sock  The socket to be used to send the pa=
cket.</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-void process_outgoing_link(struct context *c);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void process_outgoing_link(struct context=
 *c, struct link_socket *sock);</span><br><span> </span><br><span> </span><=
br><span> /****************************************************************=
**********/</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/m=
tcp.c</span><br><span>index 6faf45a..28f6e8e 100644</span><br><span>--- a/s=
rc/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>=
@@ -476,7 +476,7 @@</span><br><span>             ASSERT(mi);</span><br><spa=
n>             ASSERT(mi-&gt;context.c2.link_socket);</span><br><span>     =
        set_prefix(mi);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            read_incoming_link(&amp;mi-&gt;context);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+            read_incoming_link(&amp;mi-&=
gt;context, mi-&gt;context.c2.link_socket);</span><br><span>             cl=
ear_prefix();</span><br><span>             if (!IS_SIG(&amp;mi-&gt;context)=
)</span><br><span>             {</span><br><span>diff --git a/src/openvpn/m=
udp.c b/src/openvpn/mudp.c</span><br><span>index 268b430..5fbd7b0 100644</s=
pan><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mu=
dp.c</span><br><span>@@ -317,7 +317,7 @@</span><br><span>         msg_set_p=
refix(&quot;Connection Attempt&quot;);</span><br><span>         m-&gt;top.c=
2.to_link =3D m-&gt;hmac_reply;</span><br><span>         m-&gt;top.c2.to_li=
nk_addr =3D m-&gt;hmac_reply_dest;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        process_outgoing_link(&amp;m-&gt;top);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        process_outgoing_link(&amp;=
m-&gt;top, m-&gt;top.c2.link_socket);</span><br><span>         m-&gt;hmac_r=
eply_dest =3D NULL;</span><br><span>     }</span><br><span> }</span><br><sp=
an>@@ -380,7 +380,7 @@</span><br><span>     /* Incoming data on UDP port */=
</span><br><span>     else if (status &amp; SOCKET_READ)</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        read_inco=
ming_link(&amp;m-&gt;top);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        read_incoming_link(&amp;m-&gt;top, m-&gt;top.c2.link_socket)=
;</span><br><span>         if (!IS_SIG(&amp;m-&gt;top))</span><br><span>   =
      {</span><br><span>             multi_process_incoming_link(m, NULL, m=
pp_flags);</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/m=
ulti.h</span><br><span>index 1b99ef7..f386a3b 100644</span><br><span>--- a/=
src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><sp=
an>@@ -683,7 +683,7 @@</span><br><span> {</span><br><span>     bool ret =3D=
 true;</span><br><span>     set_prefix(mi);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    process_outgoing_link(&amp;mi-&gt;context);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    process_outgoing_link=
(&amp;mi-&gt;context, mi-&gt;context.c2.link_socket);</span><br><span>     =
ret =3D multi_process_post(m, mi, mpp_flags);</span><br><span>     clear_pr=
efix();</span><br><span>     return ret;</span><br><span>diff --git a/src/o=
penvpn/openvpn.c b/src/openvpn/openvpn.c</span><br><span>index 16147b7..1db=
5422 100644</span><br><span>--- a/src/openvpn/openvpn.c</span><br><span>+++=
 b/src/openvpn/openvpn.c</span><br><span>@@ -91,7 +91,7 @@</span><br><span>=
         }</span><br><span> </span><br><span>         /* process the I/O wh=
ich triggered select */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        process_io(c);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        process_io(c, c-&gt;c2.link_socket);</span><br><span>         =
P2P_CHECK_SIG();</span><br><span> </span><br><span>         perf_pop();</sp=
an><br><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span=
><br><span>index cf04090..efd742c 100644</span><br><span>--- a/src/openvpn/=
socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -969=
,12 +969,12 @@</span><br><span> }</span><br><span> </span><br><span> bool</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_update_flag=
s(struct link_socket *ls, unsigned int sockflags)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+link_socket_update_flags(struct link_socket *=
sock, unsigned int sockflags)</span><br><span> {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (ls &amp;&amp; socket_defined(ls-&gt;sd))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock &amp;&=
amp; socket_defined(sock-&gt;sd))</span><br><span>     {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        ls-&gt;sockflags |=3D sockflags;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return socket=
_set_flags(ls-&gt;sd, ls-&gt;sockflags);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        sock-&gt;sockflags |=3D sockflags;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        return socket_set_flags=
(sock-&gt;sd, sock-&gt;sockflags);</span><br><span>     }</span><br><span> =
    else</span><br><span>     {</span><br><span>@@ -983,13 +983,13 @@</span=
><br><span> }</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-link_socket_update_buffer_sizes(struct link=
_socket *ls, int rcvbuf, int sndbuf)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+link_socket_update_buffer_sizes(struct link_socket *sock, =
int rcvbuf, int sndbuf)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (ls &amp;&amp; socket_defined(ls-&gt;sd))</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sock &amp;&amp; s=
ocket_defined(sock-&gt;sd))</span><br><span>     {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        ls-&gt;socket_buffer_sizes.sndbuf =3D =
sndbuf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ls-&gt=
;socket_buffer_sizes.rcvbuf =3D rcvbuf;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        socket_set_buffers(ls-&gt;sd, &amp;ls-&gt;socket_=
buffer_sizes, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        sock-&gt;socket_buffer_sizes.sndbuf =3D sndbuf;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;socket_buffer_sizes.r=
cvbuf =3D rcvbuf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      socket_set_buffers(sock-&gt;sd, &amp;sock-&gt;socket_buffer_sizes, tr=
ue);</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span>@@ -1831,6 +1831,7 @@</span><br><span>     sock-&gt;sd =3D SOCKET_UND=
EFINED;</span><br><span>     sock-&gt;ctrl_sd =3D SOCKET_UNDEFINED;</span><=
br><span>     sock-&gt;ev_arg.type =3D EVENT_ARG_LINK_SOCKET;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;ev_arg.u.sock =3D so=
ck;</span><br><span> </span><br><span>     return sock;</span><br><span> }<=
/span><br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</s=
pan><br><span>index 27caab4..465d92b 100644</span><br><span>--- a/src/openv=
pn/socket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -=
451,9 +451,9 @@</span><br><span> </span><br><span> void setenv_trusted(stru=
ct env_set *es, const struct link_socket_info *info);</span><br><span> </sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-bool link_socket_update_f=
lags(struct link_socket *ls, unsigned int sockflags);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool link_socket_update_flags(struct link=
_socket *sock, unsigned int sockflags);</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void link_socket_update_buffer_sizes(st=
ruct link_socket *ls, int rcvbuf, int sndbuf);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+void link_socket_update_buffer_sizes(struct link=
_socket *sock, int rcvbuf, int sndbuf);</span><br><span> </span><br><span> =
/*</span><br><span>  * Low-level functions</span><br><span>@@ -1199,13 +119=
9,13 @@</span><br><span>  * Extract TOS bits.  Assumes that ipbuf is a vali=
d IPv4 packet.</span><br><span>  */</span><br><span> static inline void</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_extract_tos(s=
truct link_socket *ls, const struct buffer *ipbuf)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+link_socket_extract_tos(struct link_socket *=
sock, const struct buffer *ipbuf)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (ls &amp;&amp; ipbuf)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (sock &amp;&amp; ipbuf)</sp=
an><br><span>     {</span><br><span>         struct openvpn_iphdr *iph =3D =
(struct openvpn_iphdr *) BPTR(ipbuf);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        ls-&gt;ptos =3D iph-&gt;tos;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ls-&gt;ptos_defined =3D true;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;ptos =3D=
 iph-&gt;tos;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  sock-&gt;ptos_defined =3D true;</span><br><span>     }</span><br><span> }=
</span><br><span> </span><br><span>@@ -1214,11 +1214,11 @@</span><br><span>=
  * from tunnel packet.</span><br><span>  */</span><br><span> static inline=
 void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-link_socket_set_=
tos(struct link_socket *ls)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+link_socket_set_tos(struct link_socket *sock)</span><br><span> {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (ls &amp;&amp; ls=
-&gt;ptos_defined)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   if (sock &amp;&amp; sock-&gt;ptos_defined)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        setsockopt(ls-&gt;sd=
, IPPROTO_IP, IP_TOS, (const void *)&amp;ls-&gt;ptos, sizeof(ls-&gt;ptos));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        setsockopt(=
sock-&gt;sd, IPPROTO_IP, IP_TOS, (const void *)&amp;sock-&gt;ptos, sizeof(s=
ock-&gt;ptos));</span><br><span>     }</span><br><span> }</span><br><span> =
</span><br><span>@@ -1229,50 +1229,50 @@</span><br><span>  */</span><br><sp=
an> </span><br><span> static inline bool</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-socket_read_residual(const struct link_socket *s)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+socket_read_residual(const=
 struct link_socket *sock)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    return s &amp;&amp; s-&gt;stream_buf.residual_f=
ully_formed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ret=
urn sock &amp;&amp; sock-&gt;stream_buf.residual_fully_formed;</span><br><s=
pan> }</span><br><span> </span><br><span> static inline event_t</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-socket_event_handle(const struct =
link_socket *s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sock=
et_event_handle(const struct link_socket *sock)</span><br><span> {</span><b=
r><span> #ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    return &amp;s-&gt;rw_handle;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    return &amp;sock-&gt;rw_handle;</span><br><span> #else</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return s-&gt;sd;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return sock-&gt;sd;=
</span><br><span> #endif</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-event_t socket_listen_event_handle(=
struct link_socket *s);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+event_t socket_listen_event_handle(struct link_socket *sock);</span><br=
><span> </span><br><span> unsigned int</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-socket_set(struct link_socket *s,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+socket_set(struct link_socket *sock,</span><=
br><span>            struct event_set *es,</span><br><span>            unsi=
gned int rwflags,</span><br><span>            void *arg,</span><br><span>  =
          unsigned int *persistent);</span><br><span> </span><br><span> sta=
tic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-socket=
_set_listen_persistent(struct link_socket *s,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+socket_set_listen_persistent(struct link_socket *=
sock,</span><br><span>                              struct event_set *es,</=
span><br><span>                              void *arg)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (s &amp;&amp; !=
s-&gt;listen_persistent_queued)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    if (sock &amp;&amp; !sock-&gt;listen_persistent_queued)</sp=
an><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      event_ctl(es, socket_listen_event_handle(s), EVENT_READ, arg);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        s-&gt;listen_persist=
ent_queued =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        event_ctl(es, socket_listen_event_handle(sock), EVENT_READ, arg);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        sock-&gt;lis=
ten_persistent_queued =3D true;</span><br><span>     }</span><br><span> }</=
span><br><span> </span><br><span> static inline void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-socket_reset_listen_persistent(struct link_=
socket *s)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_re=
set_listen_persistent(struct link_socket *sock)</span><br><span> {</span><b=
r><span> #ifdef _WIN32</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    reset_net_event_win32(&amp;s-&gt;listen_handle, s-&gt;sd);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    reset_net_event_win32(&amp;=
sock-&gt;listen_handle, sock-&gt;sd);</span><br><span> #endif</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-const char *socket_stat(const struct link_socket *s, unsigned int rwflags=
, struct gc_arena *gc);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+const char *socket_stat(const struct link_socket *sock, unsigned int rw=
flags, struct gc_arena *gc);</span><br><span> </span><br><span> #endif /* S=
OCKET_H */</span><br><span></span><br></pre><p>To view, visit <a href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/758?usp=3Demail">change 758</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/758?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8eae2d3356bbcc5d632eeb4fbe8=
0de8009d9b40d </div>
<div style=3D"display:none"> Gerrit-Change-Number: 758 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 7 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--4jojG/YOnOE=--

