From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Fri, 11 Oct 2024 14:07:43 +0000
In-Reply-To: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
References: <gerrit.1727098847000.I31bbf87e4e568021445c7512ecefadfd4a69b363@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6f0cb31fe07e9f65601094aefc1fcc5790750144-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xWhg6TeD8Cw="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: Bind to multiple
 ipv4/ipv6 addresses
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

--xWhg6TeD8Cw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: its_Giaan, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail

to look at the new patch set (#4).


Change subject: Bind to multiple ipv4/ipv6 addresses
......................................................................

Bind to multiple ipv4/ipv6 addresses

Enables the binding of multiple listen sockets based
on the specified "--local" directives.

The main server loop has been updated to handle both
TCP and UDP connections.

The hash function has also been modified to include the
protocol during the creation of new client instances.

There are also a couple of refinements to make the
whole code flow management capable of handling
different kind of clients:

MULTI: properly remove TCP instances by checking the multi_instance
       protocol instead of the global one.

TLS: set the tls_option xmit_hold bool value to true only in case of
     TCP child instance to avoid checking the global protocol
     value.

INIT: initialize the c->c2.event_set in the inherit_context_top()
      by default and not only in case of UDP since we could have
      multiple different sockets.

Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M doc/man-sections/link-options.rst
M src/openvpn/forward.c
M src/openvpn/forward.h
M src/openvpn/init.c
M src/openvpn/mroute.c
M src/openvpn/mroute.h
M src/openvpn/mtcp.c
M src/openvpn/mtcp.h
M src/openvpn/mudp.c
M src/openvpn/mudp.h
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/multi_io.c
M src/openvpn/openvpn.h
M src/openvpn/options.c
M src/openvpn/options.h
16 files changed, 548 insertions(+), 320 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/764/4

diff --git a/doc/man-sections/link-options.rst b/doc/man-sections/link-opti=
ons.rst
index 05909ca..e2cf9b8 100644
--- a/doc/man-sections/link-options.rst
+++ b/doc/man-sections/link-options.rst
@@ -106,7 +106,7 @@
   is not reliable. It is recommended to set tun-mtu with enough headroom
   instead.

---local host|* [port]
+--local host|* [port] [protocol]
   Local host name or IP address and port for bind. If specified, OpenVPN w=
ill bind
   to this address. If unspecified, OpenVPN will bind to all interfaces.
   '*' can be used as hostname and means 'any host' (OpenVPN will listen on=
 what
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 04f2075..f84a512 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1775,7 +1775,7 @@
             if (c->options.shaper)
             {
                 int overhead =3D datagram_overhead(c->c2.to_link_addr->des=
t.addr.sa.sa_family,
-                                                 c->options.ce.proto);
+                                                 sock->info.proto);
                 shaper_wrote_bytes(&c->c2.shaper,
                                    BLEN(&c->c2.to_link) + overhead);
             }
@@ -2072,6 +2072,173 @@
  */

 void
+get_io_flags_dowork_udp(struct context *c, struct multi_protocol *multi_io=
, const unsigned int flags)
+{
+    unsigned int socket =3D 0;
+    unsigned int tuntap =3D 0;
+    static uintptr_t tun_shift =3D 2;
+    static uintptr_t err_shift =3D 4;
+
+    /*
+     * Calculate the flags based on the provided 'flags' argument.
+     */
+    if (flags & IOW_WAIT_SIGNAL)
+    {
+        wait_signal(multi_io->es, (void *)err_shift);
+    }
+
+    if (flags & IOW_TO_LINK)
+    {
+        if (flags & IOW_SHAPER)
+        {
+            /*
+             * If sending this packet would put us over our traffic shaping
+             * quota, don't send -- instead compute the delay we must wait
+             * until it will be OK to send the packet.
+             */
+            int delay =3D 0;
+
+            /* set traffic shaping delay in microseconds */
+            if (c->options.shaper)
+            {
+                delay =3D max_int(delay, shaper_delay(&c->c2.shaper));
+            }
+
+            if (delay < 1000)
+            {
+                socket |=3D EVENT_WRITE;
+            }
+            else
+            {
+                shaper_soonest_event(&c->c2.timeval, delay);
+            }
+        }
+        else
+        {
+            socket |=3D EVENT_WRITE;
+        }
+    }
+    else if (!((flags & IOW_FRAG) && TO_LINK_FRAG(c)))
+    {
+        if (flags & IOW_READ_TUN)
+        {
+            tuntap |=3D EVENT_READ;
+        }
+    }
+
+    /*
+     * If outgoing data (for TUN/TAP device) pending, wait for ready-to-se=
nd status
+     * from device.  Otherwise, wait for incoming data on TCP/UDP port.
+     */
+    if (flags & IOW_TO_TUN)
+    {
+        tuntap |=3D EVENT_WRITE;
+    }
+    else
+    {
+        if (flags & IOW_READ_LINK)
+        {
+            socket |=3D EVENT_READ;
+        }
+    }
+
+    /*
+     * outgoing bcast buffer waiting to be sent?
+     */
+    if (flags & IOW_MBUF)
+    {
+        socket |=3D EVENT_WRITE;
+    }
+
+    /*
+     * Force wait on TUN input, even if also waiting on TCP/UDP output
+     */
+    if (flags & IOW_READ_TUN_FORCE)
+    {
+        tuntap |=3D EVENT_READ;
+    }
+
+#ifdef _WIN32
+    if (tuntap_is_wintun(c->c1.tuntap))
+    {
+        /*
+         * With wintun we are only interested in read event. Ring buffer is
+         * always ready for write, so we don't do wait.
+         */
+        tuntap =3D EVENT_READ;
+    }
+#endif
+
+    /*
+     * Configure event wait based on socket, tuntap flags.
+     */
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
+    {
+        if (proto_is_dgram(c->c2.link_sockets[i]->info.proto))
+        {
+            socket_set(c->c2.link_sockets[i], multi_io->es, socket,
+                       &c->c2.link_sockets[i]->ev_arg, NULL);
+        }
+    }
+    tun_set(c->c1.tuntap, multi_io->es, tuntap, (void *)tun_shift, NULL);
+
+    multi_io->udp_flags =3D socket | tuntap;
+}
+
+void
+get_io_flags_udp(struct context *c, struct multi_protocol *multi_io, const=
 unsigned int flags)
+{
+    multi_io->udp_flags =3D ES_ERROR;
+    if (c->c2.fast_io && (flags & (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))
+    {
+        /* fast path -- only for TUN/TAP/UDP writes */
+        unsigned int ret =3D 0;
+        if (flags & IOW_TO_TUN)
+        {
+            ret |=3D TUN_WRITE;
+        }
+        if (flags & (IOW_TO_LINK | IOW_MBUF))
+        {
+            ret |=3D SOCKET_WRITE;
+        }
+        multi_io->udp_flags =3D ret;
+    }
+    else
+    {
+#ifdef _WIN32
+        bool skip_iowait =3D flags & IOW_TO_TUN;
+        if (flags & IOW_READ_TUN)
+        {
+            /*
+             * don't read from tun if we have pending write to link,
+             * since every tun read overwrites to_link buffer filled
+             * by previous tun read
+             */
+            skip_iowait =3D !(flags & IOW_TO_LINK);
+        }
+        if (tuntap_is_wintun(c->c1.tuntap) && skip_iowait)
+        {
+            unsigned int ret =3D 0;
+            if (flags & IOW_TO_TUN)
+            {
+                ret |=3D TUN_WRITE;
+            }
+            if (flags & IOW_READ_TUN)
+            {
+                ret |=3D TUN_READ;
+            }
+            multi_io->udp_flags =3D ret;
+        }
+        else
+#endif /* ifdef _WIN32 */
+        {
+            /* slow path - delegate to io_wait_dowork_udp to calculate fla=
gs */
+            get_io_flags_dowork_udp(c, multi_io, flags);
+        }
+    }
+}
+
+void
 io_wait_dowork(struct context *c, const unsigned int flags)
 {
     unsigned int socket =3D 0;
@@ -2313,6 +2480,7 @@
     dmsg(D_EVENT_WAIT, "I/O WAIT status=3D0x%04x", c->c2.event_set_status);
 }

+
 void
 process_io(struct context *c, struct link_socket *sock)
 {
diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h
index 0415726..fc4ff68 100644
--- a/src/openvpn/forward.h
+++ b/src/openvpn/forward.h
@@ -69,6 +69,10 @@

 extern counter_type link_write_bytes_global;

+void get_io_flags_dowork_udp(struct context *c, struct multi_protocol *mul=
ti_io, const unsigned int flags);
+
+void get_io_flags_udp(struct context *c, struct multi_protocol *multi_io, =
const unsigned int flags);
+
 void io_wait_dowork(struct context *c, const unsigned int flags);

 void pre_select(struct context *c);
diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 4eb286a..b2f772b 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -225,7 +225,7 @@
         if (streq(p[1], "HTTP"))
         {
             struct http_proxy_options *ho;
-            if (ce->proto !=3D PROTO_TCP && ce->proto !=3D PROTO_TCP_CLIEN=
T)
+            if (ce->proto !=3D PROTO_TCP && c->mode !=3D CM_CHILD_TCP)
             {
                 msg(M_WARN, "HTTP proxy support only works for TCP based c=
onnections");
                 return false;
@@ -602,7 +602,10 @@
             ce_defined =3D false;
         }

+        int proto =3D c->options.ce.proto;
         c->options.ce =3D *ce;
+        c->options.ce.proto =3D proto;
+
 #ifdef ENABLE_MANAGEMENT
         if (ce_defined && management && management_query_remote_enabled(ma=
nagement))
         {
@@ -2673,7 +2676,7 @@

     if (found & OPT_P_EXPLICIT_NOTIFY)
     {
-        if (!proto_is_udp(c->options.ce.proto) && c->options.ce.explicit_e=
xit_notification)
+        if (!proto_is_udp(c->c2.link_sockets[0]->info.proto) && c->options=
.ce.explicit_exit_notification)
         {
             msg(D_PUSH, "OPTIONS IMPORT: --explicit-exit-notify can only b=
e used with --proto udp");
             c->options.ce.explicit_exit_notification =3D 0;
@@ -2833,14 +2836,21 @@
     int sec =3D 2;
     int backoff =3D 0;

-    switch (c->options.ce.proto)
+    switch (c->mode)
     {
-        case PROTO_TCP_SERVER:
-            sec =3D 1;
+        case CM_TOP:
+            if (has_udp_in_local_list(&c->options))
+            {
+                sec =3D c->options.ce.connect_retry_seconds;
+            }
+            else
+            {
+                sec =3D 1;
+            }
             break;

-        case PROTO_UDP:
-        case PROTO_TCP_CLIENT:
+        case CM_CHILD_UDP:
+        case CM_CHILD_TCP:
             sec =3D c->options.ce.connect_retry_seconds;
             break;
     }
@@ -2858,7 +2868,7 @@
     }

     /* Slow down reconnection after 5 retries per remote -- for TCP client=
 or UDP tls-client only */
-    if (c->options.ce.proto =3D=3D PROTO_TCP_CLIENT
+    if (c->mode =3D=3D CM_CHILD_TCP
         || (c->options.ce.proto =3D=3D PROTO_UDP && c->options.tls_client))
     {
         backoff =3D (c->options.unsuccessful_attempts / c->options.connect=
ion_list->len) - 4;
@@ -3338,7 +3348,21 @@
     to.server =3D options->tls_server;
     to.replay_window =3D options->replay_window;
     to.replay_time =3D options->replay_time;
-    to.tcp_mode =3D link_socket_proto_connection_oriented(options->ce.prot=
o);
+
+    if (c->options.ce.local_list->len > 1)
+    {
+        for (int i =3D 0; i < c->options.ce.local_list->len; i++)
+        {
+            if (proto_is_dgram(c->options.ce.local_list->array[i]->proto))
+            {
+                to.tcp_mode =3D false;
+            }
+        }
+    }
+    else
+    {
+        to.tcp_mode =3D link_socket_proto_connection_oriented(c->options.c=
e.local_list->array[0]->proto);
+    }
     to.config_ciphername =3D c->options.ciphername;
     to.config_ncp_ciphers =3D c->options.ncp_ciphers;
     to.transition_window =3D options->transition_window;
@@ -3383,7 +3407,7 @@

     /* should we not xmit any packets until we get an initial
      * response from client? */
-    if (to.server && options->ce.proto =3D=3D PROTO_TCP_SERVER)
+    if (to.server && c->mode =3D=3D CM_CHILD_TCP)
     {
         to.xmit_hold =3D true;
     }
@@ -3829,6 +3853,24 @@
     unsigned int sockflags =3D c->options.sockflags;
     int i;

+    int mode =3D LS_MODE_DEFAULT;
+    /* mode allows CM_CHILD_TCP
+     * instances to inherit acceptable fds
+     * from a top-level parent */
+    if (c->options.mode =3D=3D MODE_SERVER)
+    {
+        /* initializing listening socket */
+        if (c->mode =3D=3D CM_TOP)
+        {
+            mode =3D LS_MODE_TCP_LISTEN;
+        }
+        /* initializing socket to client */
+        else if (c->mode =3D=3D CM_CHILD_TCP)
+        {
+            mode =3D LS_MODE_TCP_ACCEPT_FROM;
+        }
+    }
+
 #if PORT_SHARE
     if (c->options.port_share_host && c->options.port_share_port)
     {
@@ -3838,33 +3880,37 @@

     for (i =3D 0; i < c->c1.link_sockets_num; i++)
     {
-        int mode =3D LS_MODE_DEFAULT;
+        const char *host =3D c->options.ce.local_list->array[i]->local;
+        const char *port =3D c->options.ce.local_list->array[i]->port;
+        int proto =3D c->options.ce.local_list->array[i]->proto;
+        bool bind_local =3D c->options.ce.local_list->array[i]->bind_local;

-        /* mode allows CM_CHILD_TCP
-         * instances to inherit acceptable fds
-         * from a top-level parent */
-        if (c->options.mode =3D=3D MODE_SERVER)
+        if (c->mode =3D=3D CM_CHILD_TCP || c->mode =3D=3D CM_CHILD_UDP)
         {
-            /* initializing listening socket */
-            if (c->mode =3D=3D CM_TOP)
+            const struct link_socket *ls =3D NULL;
+            if (c->mode =3D=3D CM_CHILD_TCP)
             {
-                mode =3D LS_MODE_TCP_LISTEN;
+                ls =3D c->c2.accept_from;
             }
-            /* initializing socket to client */
-            else if (c->mode =3D=3D CM_CHILD_TCP)
+            else if (c->mode =3D=3D CM_CHILD_UDP)
             {
-                mode =3D LS_MODE_TCP_ACCEPT_FROM;
+                ls =3D c->c2.link_sockets[0];
             }
+
+            host =3D ls->local_host;
+            port =3D ls->local_port;
+            proto =3D ls->info.proto;
+            bind_local =3D ls->bind_local;
         }

         /* init each socket with its specific port */
         link_socket_init_phase1(c->c2.link_sockets[i],
-                                c->options.ce.local_list->array[i]->local,
-                                c->options.ce.local_list->array[i]->port,
+                                host,
+                                port,
                                 c->options.ce.remote,
                                 c->options.ce.remote_port,
                                 c->c1.dns_cache,
-                                c->options.ce.proto,
+                                proto,
                                 c->options.ce.af,
                                 c->options.ce.bind_ipv6_only,
                                 mode,
@@ -3874,7 +3920,7 @@
 #ifdef ENABLE_DEBUG
                                 c->options.gremlin,
 #endif
-                                c->options.ce.local_list->array[i]->bind_l=
ocal,
+                                bind_local,
                                 c->options.ce.remote_float,
                                 &c->c1.link_socket_addrs[i],
                                 c->options.ipchange,
@@ -4265,20 +4311,13 @@
 #ifdef _WIN32
         msg(M_INFO, "NOTE: --fast-io is disabled since we are running on W=
indows");
 #else
-        if (!proto_is_udp(c->options.ce.proto))
+        if (c->options.shaper)
         {
-            msg(M_INFO, "NOTE: --fast-io is disabled since we are not usin=
g UDP");
+            msg(M_INFO, "NOTE: --fast-io is disabled since we are using --=
shaper");
         }
         else
         {
-            if (c->options.shaper)
-            {
-                msg(M_INFO, "NOTE: --fast-io is disabled since we are usin=
g --shaper");
-            }
-            else
-            {
-                c->c2.fast_io =3D true;
-            }
+            c->c2.fast_io =3D true;
         }
 #endif
     }
@@ -4685,7 +4724,7 @@
     }

     /* our wait-for-i/o objects, different for posix vs. win32 */
-    if (c->mode =3D=3D CM_P2P)
+    if (c->mode =3D=3D CM_P2P || c->mode =3D=3D CM_TOP)
     {
         do_event_set_init(c, SHAPER_DEFINED(&c->options));
     }
@@ -4949,7 +4988,7 @@
     CLEAR(*dest);

     /* proto_is_dgram will ASSERT(0) if proto is invalid */
-    dest->mode =3D proto_is_dgram(src->options.ce.proto) ? CM_CHILD_UDP : =
CM_CHILD_TCP;
+    dest->mode =3D proto_is_dgram(sock->info.proto) ? CM_CHILD_UDP : CM_CH=
ILD_TCP;

     dest->gc =3D gc_new();

@@ -4975,8 +5014,11 @@

     /* options */
     dest->options =3D src->options;
+    dest->options.ce.proto =3D sock->info.proto;
     options_detach(&dest->options);

+    dest->c2.event_set =3D src->c2.event_set;
+
     if (dest->mode =3D=3D CM_CHILD_TCP)
     {
         /*
@@ -5071,10 +5113,7 @@
     dest->c2.es_owned =3D false;

     dest->c2.event_set =3D NULL;
-    if (proto_is_dgram(src->options.ce.proto))
-    {
-        do_event_set_init(dest, false);
-    }
+    do_event_set_init(dest, false);

 #ifdef USE_COMP
     dest->c2.comp_context =3D NULL;
diff --git a/src/openvpn/mroute.c b/src/openvpn/mroute.c
index 3a0224e..6f0170a 100644
--- a/src/openvpn/mroute.c
+++ b/src/openvpn/mroute.c
@@ -421,6 +421,7 @@
                 {
                     buf_printf(&out, ":%d", ntohs(maddr.v4.port));
                 }
+                buf_printf(&out, ":%d", maddr.proto);
             }
             break;

diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index 570ccaa..e844c21 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -201,6 +201,10 @@
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
@@ -222,7 +226,7 @@
 static inline uint32_t
 mroute_addr_hash_len(const struct mroute_addr *a)
 {
-    return (uint32_t) a->len + 2;
+    return (uint32_t) a->len + 3;
 }

 static inline void
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index e173b80..c1107ab 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -54,7 +54,7 @@
     struct hash *hash =3D m->hash;

     mi =3D multi_create_instance(m, NULL, sock);
-    if (mi)
+    if (mi && !proto_is_dgram(sock->info.proto))
     {
         mi->real.proto =3D sock->info.proto;
         struct hash_element *he;
@@ -153,12 +153,19 @@
 {
     if (mi)
     {
-        mi->socket_set_called =3D true;
-        socket_set(mi->context.c2.link_sockets[0],
-                   m->multi_io->es,
-                   mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
-                   &mi->ev_arg,
-                   &mi->tcp_rwflags);
+        if (proto_is_dgram(mi->context.c2.link_sockets[0]->info.proto))
+        {
+            return;
+        }
+        else
+        {
+            mi->socket_set_called =3D true;
+            socket_set(mi->context.c2.link_sockets[0],
+                       m->multi_io->es,
+                       mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRI=
TE : EVENT_READ,
+                       &mi->ev_arg,
+                       &mi->tcp_rwflags);
+        }
     }
 }

@@ -242,87 +249,3 @@
     }
     return ret;
 }
-
-/*
- * Top level event loop for single-threaded operation.
- * TCP mode.
- */
-void
-tunnel_server_tcp(struct context *top)
-{
-    struct multi_context multi;
-    int status;
-
-    top->mode =3D CM_TOP;
-    context_clear_2(top);
-
-    /* initialize top-tunnel instance */
-    init_instance_handle_signals(top, top->es, CC_HARD_USR1_TO_HUP);
-    if (IS_SIG(top))
-    {
-        return;
-    }
-
-    /* initialize global multi_context object */
-    multi_init(&multi, top, true);
-
-    /* initialize our cloned top object */
-    multi_top_init(&multi, top);
-
-    /* initialize management interface */
-    init_management_callback_multi(&multi);
-
-    /* finished with initialization */
-    initialization_sequence_completed(top, ISC_SERVER); /* --mode server -=
-proto tcp-server */
-
-#ifdef ENABLE_ASYNC_PUSH
-    multi.top.c2.inotify_fd =3D inotify_init();
-    if (multi.top.c2.inotify_fd < 0)
-    {
-        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
-    }
-#endif
-
-    /* per-packet event loop */
-    while (true)
-    {
-        perf_push(PERF_EVENT_LOOP);
-
-        /* wait on tun/socket list */
-        multi_get_timeout(&multi, &multi.top.c2.timeval);
-        status =3D multi_protocol_io_wait(&multi);
-        MULTI_CHECK_SIG(&multi);
-
-        /* check on status of coarse timers */
-        multi_process_per_second_timers(&multi);
-
-        /* timeout? */
-        if (status > 0)
-        {
-            /* process the I/O which triggered select */
-            multi_protocol_process_io(&multi);
-            MULTI_CHECK_SIG(&multi);
-        }
-        else if (status =3D=3D 0)
-        {
-            multi_protocol_action(&multi, NULL, TA_TIMEOUT, false);
-        }
-
-        perf_pop();
-    }
-
-#ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
-#endif
-
-    /* shut down management interface */
-    uninit_management_callback();
-
-    /* save ifconfig-pool */
-    multi_ifconfig_pool_persist(&multi, true);
-
-    /* tear down tunnel instance (unless --persist-tun) */
-    multi_uninit(&multi);
-    multi_top_free(&multi);
-    close_instance(top);
-}
diff --git a/src/openvpn/mtcp.h b/src/openvpn/mtcp.h
index b9f73d4..51b209b 100644
--- a/src/openvpn/mtcp.h
+++ b/src/openvpn/mtcp.h
@@ -51,17 +51,6 @@

 void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);

-
-/*************************************************************************=
*/
-/**
- * Main event loop for OpenVPN in TCP server mode.
- * @ingroup eventloop
- *
- * @param top - Top-level context structure.
- */
-void tunnel_server_tcp(struct context *top);
-
-
 void multi_tcp_delete_event(struct multi_protocol *multi_io, event_t event=
);

 #endif /* ifndef MTCP_H */
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index fee706d..3189fe9 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -194,6 +194,7 @@
     struct hash *hash =3D m->hash;
     real.proto =3D sock->info.proto;
     m->local.proto =3D real.proto;
+    m->hmac_reply_ls =3D sock;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
@@ -320,18 +321,59 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link =3D m->hmac_reply;
         m->top.c2.to_link_addr =3D m->hmac_reply_dest;
-        process_outgoing_link(&m->top, m->top.c2.link_sockets[0]);
+        process_outgoing_link(&m->top, m->hmac_reply_ls);
+        m->hmac_reply_ls =3D NULL;
         m->hmac_reply_dest =3D NULL;
     }
 }

 /*
+ * Return the io_wait() flags appropriate for
+ * a point-to-multipoint tunnel.
+ */
+unsigned int
+p2mp_iow_flags(const struct multi_context *m)
+{
+    unsigned int flags =3D IOW_WAIT_SIGNAL;
+    if (m->pending)
+    {
+        if (TUN_OUT(&m->pending->context))
+        {
+            flags |=3D IOW_TO_TUN;
+        }
+        if (LINK_OUT(&m->pending->context))
+        {
+            flags |=3D IOW_TO_LINK;
+        }
+    }
+    else if (mbuf_defined(m->mbuf))
+    {
+        flags |=3D IOW_MBUF;
+    }
+    else if (m->hmac_reply_dest)
+    {
+        flags |=3D IOW_TO_LINK;
+    }
+    else
+    {
+        flags |=3D IOW_READ;
+    }
+#ifdef _WIN32
+    if (tuntap_ring_empty(m->top.c1.tuntap))
+    {
+        flags &=3D ~IOW_READ_TUN;
+    }
+#endif
+    return flags;
+}
+
+/*
  * Process an I/O event.
  */
-static void
+void
 multi_process_io_udp(struct multi_context *m)
 {
-    const unsigned int status =3D m->top.c2.event_set_status;
+    const unsigned int status =3D m->multi_io->udp_flags;
     const unsigned int mpp_flags =3D m->top.c2.fast_io
                                    ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
                                    : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
@@ -429,123 +471,3 @@
     }
 #endif
 }
-
-/*
- * Return the io_wait() flags appropriate for
- * a point-to-multipoint tunnel.
- */
-static inline unsigned int
-p2mp_iow_flags(const struct multi_context *m)
-{
-    unsigned int flags =3D IOW_WAIT_SIGNAL;
-    if (m->pending)
-    {
-        if (TUN_OUT(&m->pending->context))
-        {
-            flags |=3D IOW_TO_TUN;
-        }
-        if (LINK_OUT(&m->pending->context))
-        {
-            flags |=3D IOW_TO_LINK;
-        }
-    }
-    else if (mbuf_defined(m->mbuf))
-    {
-        flags |=3D IOW_MBUF;
-    }
-    else if (m->hmac_reply_dest)
-    {
-        flags |=3D IOW_TO_LINK;
-    }
-    else
-    {
-        flags |=3D IOW_READ;
-    }
-#ifdef _WIN32
-    if (tuntap_ring_empty(m->top.c1.tuntap))
-    {
-        flags &=3D ~IOW_READ_TUN;
-    }
-#endif
-    return flags;
-}
-
-
-void
-tunnel_server_udp(struct context *top)
-{
-    struct multi_context multi;
-
-    top->mode =3D CM_TOP;
-    context_clear_2(top);
-
-    /* initialize top-tunnel instance */
-    init_instance_handle_signals(top, top->es, CC_HARD_USR1_TO_HUP);
-    if (IS_SIG(top))
-    {
-        return;
-    }
-
-    /* initialize global multi_context object */
-    multi_init(&multi, top, false);
-
-    /* initialize our cloned top object */
-    multi_top_init(&multi, top);
-
-    /* initialize management interface */
-    init_management_callback_multi(&multi);
-
-    /* finished with initialization */
-    initialization_sequence_completed(top, ISC_SERVER); /* --mode server -=
-proto udp */
-
-#ifdef ENABLE_ASYNC_PUSH
-    multi.top.c2.inotify_fd =3D inotify_init();
-    if (multi.top.c2.inotify_fd < 0)
-    {
-        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
-    }
-#endif
-
-    /* per-packet event loop */
-    while (true)
-    {
-        perf_push(PERF_EVENT_LOOP);
-
-        /* set up and do the io_wait() */
-        multi_get_timeout(&multi, &multi.top.c2.timeval);
-        io_wait(&multi.top, p2mp_iow_flags(&multi));
-        MULTI_CHECK_SIG(&multi);
-
-        /* check on status of coarse timers */
-        multi_process_per_second_timers(&multi);
-
-        /* timeout? */
-        if (multi.top.c2.event_set_status =3D=3D ES_TIMEOUT)
-        {
-            multi_process_timeout(&multi, MPP_PRE_SELECT|MPP_CLOSE_ON_SIGN=
AL);
-        }
-        else
-        {
-            /* process I/O */
-            multi_process_io_udp(&multi);
-            MULTI_CHECK_SIG(&multi);
-        }
-
-        perf_pop();
-    }
-
-#ifdef ENABLE_ASYNC_PUSH
-    close(top->c2.inotify_fd);
-#endif
-
-    /* shut down management interface */
-    uninit_management_callback();
-
-    /* save ifconfig-pool */
-    multi_ifconfig_pool_persist(&multi, true);
-
-    /* tear down tunnel instance (unless --persist-tun) */
-    multi_uninit(&multi);
-    multi_top_free(&multi);
-    close_instance(top);
-}
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 3107cc6..e329832 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -31,18 +31,9 @@
 struct context;
 struct multi_context;
=20
+unsigned int p2mp_iow_flags(const struct multi_context *m);

-/**
- * Main event loop for OpenVPN in UDP server mode.
- * @ingroup eventloop
- *
- * This function implements OpenVPN's main event loop for UDP server mode.
- *
- * @param top - Top-level context structure.
- */
-void tunnel_server_udp(struct context *top);
-
-
+void multi_process_io_udp(struct multi_context *m);
 /*************************************************************************=
*/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 4d7b5e6..b5efb3a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -289,7 +289,7 @@
  * Main initialization function, init multi_context object.
  */
 void
-multi_init(struct multi_context *m, struct context *t, bool tcp_mode)
+multi_init(struct multi_context *m, struct context *t)
 {
     int dev =3D DEV_TYPE_UNDEF;

@@ -435,13 +435,12 @@

     m->instances =3D calloc(m->max_clients, sizeof(struct multi_instance *=
));

+    m->top.c2.event_set =3D t->c2.event_set;
+
     /*
-     * Initialize multi-socket TCP I/O wait object
+     * Initialize multi-socket I/O wait object
      */
-    if (tcp_mode)
-    {
-        m->multi_io =3D multi_protocol_init(t->options.max_clients, &m->ma=
x_clients);
-    }
+    m->multi_io =3D multi_protocol_init(t->options.max_clients, &m->max_cl=
ients);
     m->tcp_queue_limit =3D t->options.tcp_queue_limit;

     /*
@@ -607,6 +606,7 @@

     ASSERT(!mi->halt);
     mi->halt =3D true;
+    bool is_dgram =3D proto_is_dgram(mi->context.c2.link_sockets[0]->info.=
proto);

     dmsg(D_MULTI_DEBUG, "MULTI: multi_close_instance called");

@@ -665,7 +665,7 @@
             mi->did_iroutes =3D false;
         }

-        if (m->multi_io)
+        if (!is_dgram)
         {
             multi_tcp_dereference_instance(m->multi_io, mi);
         }
@@ -776,7 +776,6 @@
         mi->real =3D *real;
         generate_prefix(mi);
     }
-
     mi->did_open_context =3D true;
     inherit_context_child(&mi->context, &m->top, sock);
     if (IS_SIG(&mi->context))
@@ -798,6 +797,7 @@
         {
             goto err;
         }
+        mi->real.proto =3D sock->info.proto;
         generate_prefix(mi);
     }

@@ -3401,7 +3401,7 @@
             /* decrypt in instance context */

             perf_push(PERF_PROC_IN_LINK);
-            lsi =3D get_link_socket_info(c);
+            lsi =3D &sock->info;
             orig_buf =3D c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
@@ -3852,7 +3852,7 @@
     while ((he =3D hash_iterator_next(&hi)))
     {
         struct multi_instance *mi =3D (struct multi_instance *) he->value;
-        if (!mi->halt)
+        if (!mi->halt && proto_is_dgram(mi->context.options.ce.proto))
         {
             send_control_channel_string(&mi->context, next_server ? "RESTA=
RT,[N]" : "RESTART", D_PUSH);
             multi_schedule_context_wakeup(m, mi);
@@ -3890,13 +3890,15 @@
         status_close(so);
         return false;
     }
-    else if (proto_is_dgram(m->top.options.ce.proto)
-             && is_exit_restart(m->top.sig->signal_received)
-             && (m->deferred_shutdown_signal.signal_received =3D=3D 0)
-             && m->top.options.ce.explicit_exit_notification !=3D 0)
+    else if (has_udp_in_local_list(&m->top.options))
     {
-        multi_push_restart_schedule_exit(m, m->top.options.ce.explicit_exi=
t_notification =3D=3D 2);
-        return false;
+        if (is_exit_restart(m->top.sig->signal_received)
+            && (m->deferred_shutdown_signal.signal_received =3D=3D 0)
+            && m->top.options.ce.explicit_exit_notification !=3D 0)
+        {
+            multi_push_restart_schedule_exit(m, m->top.options.ce.explicit=
_exit_notification =3D=3D 2);
+            return false;
+        }
     }
     return true;
 }
@@ -4169,6 +4171,98 @@
     ASSERT(mi->context.c2.tls_multi->peer_id < m->max_clients);
 }

+/*************************************************************************=
*/
+/**
+ * Main event loop for OpenVPN in multi-protocol server mode.
+ * @ingroup eventloop
+ *
+ * @param top - Top-level context structure.
+ */
+void
+tunnel_server_loop(struct multi_context *multi)
+{
+    int status;
+
+    while (true)
+    {
+        perf_push(PERF_EVENT_LOOP);
+
+        /* wait on tun/socket list */
+        multi_get_timeout(multi, &multi->top.c2.timeval);
+        status =3D multi_protocol_io_wait(multi);
+        MULTI_CHECK_SIG(multi);
+
+        /* check on status of coarse timers */
+        multi_process_per_second_timers(multi);
+
+        /* timeout? */
+        if (status > 0)
+        {
+            /* process the I/O which triggered select */
+            multi_protocol_process_io(multi);
+            MULTI_CHECK_SIG(multi);
+        }
+        else if (status =3D=3D 0)
+        {
+            multi_protocol_action(multi, NULL, TA_TIMEOUT, false);
+        }
+
+        perf_pop();
+    }
+}
+
+void
+tunnel_server_init(struct context *top)
+{
+    struct multi_context multi;
+
+    top->mode =3D CM_TOP;
+    context_clear_2(top);
+
+    /* initialize top-tunnel instance */
+    init_instance_handle_signals(top, top->es, CC_HARD_USR1_TO_HUP);
+    if (IS_SIG(top))
+    {
+        return;
+    }
+
+    /* initialize global multi_context object */
+    multi_init(&multi, top);
+
+    /* initialize our cloned top object */
+    multi_top_init(&multi, top);
+
+    /* initialize management interface */
+    init_management_callback_multi(&multi);
+
+    /* finished with initialization */
+    initialization_sequence_completed(top, ISC_SERVER); /* --mode server -=
-proto tcp-server */
+
+#ifdef ENABLE_ASYNC_PUSH
+    multi.top.c2.inotify_fd =3D inotify_init();
+    if (multi.top.c2.inotify_fd < 0)
+    {
+        msg(D_MULTI_ERRORS | M_ERRNO, "MULTI: inotify_init error");
+    }
+#endif
+
+    tunnel_server_loop(&multi);
+
+    #ifdef ENABLE_ASYNC_PUSH
+    close(top->c2.inotify_fd);
+#endif
+
+    /* shut down management interface */
+    uninit_management_callback();
+
+    /* save ifconfig-pool */
+    multi_ifconfig_pool_persist(&multi, true);
+
+    /* tear down tunnel instance (unless --persist-tun) */
+    multi_uninit(&multi);
+    multi_top_free(&multi);
+    close_instance(top);
+}

 /*
  * Top level event loop.
@@ -4178,12 +4272,6 @@
 {
     ASSERT(top->options.mode =3D=3D MODE_SERVER);

-    if (proto_is_dgram(top->options.ce.proto))
-    {
-        tunnel_server_udp(top);
-    }
-    else
-    {
-        tunnel_server_tcp(top);
-    }
+    tunnel_server_init(top);
+
 }
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 5ecb86a..c537c44 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -205,6 +205,7 @@

     struct buffer hmac_reply;
     struct link_socket_actual *hmac_reply_dest;
+    struct link_socket *hmac_reply_ls;

     /*
      * Timer object for stale route check
@@ -252,10 +253,8 @@
  * Main event loop for OpenVPN in server mode.
  * @ingroup eventloop
  *
- * This function calls the appropriate main event loop function depending
- * on the transport protocol used:
- *  - \c tunnel_server_udp()
- *  - \c tunnel_server_tcp()
+ * This function calls the main event loop function
+ * on the transport protocols:
  *
  * @param top          - Top-level context structure.
  */
@@ -268,7 +267,7 @@
  * Called by mtcp.c, mudp.c, or other (to be written) protocol drivers
  */

-void multi_init(struct multi_context *m, struct context *t, bool tcp_mode);
+void multi_init(struct multi_context *m, struct context *t);

 void multi_uninit(struct multi_context *m);

@@ -664,9 +663,12 @@
 multi_process_outgoing_tun(struct multi_context *m, const unsigned int mpp=
_flags)
 {
     struct multi_instance *mi =3D m->pending;
+    if (!mi)
+    {
+        return false;
+    }
     bool ret =3D true;

-    ASSERT(mi);
 #ifdef MULTI_DEBUG_EVENT_LOOP
     printf("%s -> TUN len=3D%d\n",
            id(mi),
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index 43fe24b..59661ed 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -142,6 +142,11 @@
                                      &m->top.c2.link_sockets[i]->ev_arg);
     }

+    if (has_udp_in_local_list(&m->top.options))
+    {
+        get_io_flags_udp(&m->top, m->multi_io, p2mp_iow_flags(m));
+    }
+
 #ifdef _WIN32
     if (tuntap_is_wintun(m->top.c1.tuntap))
     {
@@ -396,6 +401,10 @@
 multi_protocol_process_io(struct multi_context *m)
 {
     struct multi_protocol *multi_io =3D m->multi_io;
+    const unsigned int udp_status =3D multi_io->udp_flags;
+    const unsigned int mpp_flags =3D m->top.c2.fast_io
+                                   ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLO=
SE_ON_SIGNAL)
+                                   : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);
     int i;

     for (i =3D 0; i < multi_io->n_esr; ++i)
@@ -447,6 +456,39 @@
                         }
                         break;
                     }
+                    else
+                    {
+                        if (e->arg >=3D MULTI_N)
+                        {
+                            struct event_arg *ev_arg =3D (struct event_arg=
 *)e->arg;
+                            if (ev_arg->type !=3D EVENT_ARG_LINK_SOCKET)
+                            {
+                                multi_io->udp_flags =3D ES_ERROR;
+                                msg(D_LINK_ERRORS,
+                                    "MULTI PROTOCOL: io_work: non socket e=
vent delivered");
+                                break;
+                            }
+                        }
+                        else
+                        {
+                            ev_arg->pending =3D true;
+                        }
+
+                        if (udp_status & SOCKET_READ)
+                        {
+                            read_incoming_link(&m->top, ev_arg->u.sock);
+                            if (!IS_SIG(&m->top))
+                            {
+                                multi_process_incoming_link(m, NULL, mpp_f=
lags,
+                                                            ev_arg->u.sock=
);
+                            }
+                        }
+                        else
+                        {
+                            multi_process_io_udp(m);
+                        }
+                        break;
+                    }
             }
         }
         else
diff --git a/src/openvpn/openvpn.h b/src/openvpn/openvpn.h
index 77bb41d..821ac2e 100644
--- a/src/openvpn/openvpn.h
+++ b/src/openvpn/openvpn.h
@@ -220,8 +220,8 @@
  * \c SIGUSR1 restarts.
  *
  * This structure is initialized at the top of the \c
- * tunnel_point_to_point(), \c tunnel_server_udp(), and \c
- * tunnel_server_tcp() functions.  In other words, it is reset for every
+ * tunnel_point_to_point(), \c tunnel_server() \c
+ * functions.  In other words, it is reset for every
  * iteration of the \c main() function's inner \c SIGUSR1 loop.
  */
 struct context_2
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index f216456..edda0bb 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -993,10 +993,13 @@
                         const struct connection_entry *e,
                         const int i)
 {
-    setenv_str_i(es, "proto", proto2ascii(e->proto, e->af, false), i);
-    /* expected to be for single socket contexts only */
-    setenv_str_i(es, "local", e->local_list->array[0]->local, i);
-    setenv_str_i(es, "local_port", e->local_list->array[0]->port, i);
+    for (int j =3D 0; j < e->local_list->len; j++)
+    {
+        setenv_str_i(es, "proto", proto2ascii(e->local_list->array[j]->pro=
to, e->af, false), i);
+        /* expected to be for single socket contexts only */
+        setenv_str_i(es, "local", e->local_list->array[j]->local, i);
+        setenv_str_i(es, "local_port", e->local_list->array[j]->port, i);
+    }
     setenv_str_i(es, "remote", e->remote, i);
     setenv_str_i(es, "remote_port", e->remote_port, i);

@@ -2199,6 +2202,7 @@
     }

     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, gc);
+    e->proto =3D PROTO_NONE;
     l->array[l->len++] =3D e;

     return e;
@@ -2465,7 +2469,7 @@
     {
         struct local_entry *le =3D ce->local_list->array[i];

-        if (proto_is_net(ce->proto)
+        if (proto_is_net(le->proto)
             && string_defined_equal(le->local, ce->remote)
             && string_defined_equal(le->port, ce->remote_port))
         {
@@ -3170,14 +3174,30 @@
         if (ce->proto =3D=3D PROTO_TCP)
         {
             ce->proto =3D PROTO_TCP_SERVER;
+            o->ce.proto =3D ce->proto;
+        }
+        if (ce->local_list)
+        {
+            for (int i =3D 0; i < ce->local_list->len; i++)
+            {
+                if (ce->local_list->array[i]->proto =3D=3D PROTO_TCP)
+                {
+                    ce->local_list->array[i]->proto =3D PROTO_TCP_SERVER;
+                }
+                else if (ce->local_list->array[i]->proto =3D=3D PROTO_NONE)
+                {
+                    ce->local_list->array[i]->proto =3D ce->proto;
+                }
+            }
         }
     }

-    if (o->client)
+    if (o->mode !=3D MODE_SERVER)
     {
         if (ce->proto =3D=3D PROTO_TCP)
         {
             ce->proto =3D PROTO_TCP_CLIENT;
+            o->ce.proto =3D ce->proto;
         }
     }

@@ -3331,6 +3351,10 @@
     {
         le->port =3D o->ce.local_port;
     }
+    if (!le->proto)
+    {
+        le->proto =3D o->ce.proto;
+    }
 }

 #ifdef _WIN32
@@ -3807,6 +3831,12 @@
         options_postprocess_mutate_ce(o, o->connection_list->array[i]);
     }

+    if (!has_udp_in_local_list(o))
+    {
+        o->fast_io =3D false;
+        msg(M_INFO, "NOTE: --fast-io is disabled while using multi-socket"=
);
+    }
+
     if (o->ce.local_list)
     {
         for (i =3D 0; i < o->ce.local_list->len; i++)
@@ -3822,6 +3852,7 @@
         ASSERT(e);
         e->port =3D o->ce.local_port;
         e->bind_local =3D o->connection_list->array[0]->bind_local;
+        e->proto =3D o->ce.proto;
     }

     /* use the same listen list for every outgoing connection */
@@ -6232,7 +6263,7 @@
         VERIFY_PERMISSION(OPT_P_UP);
         options->ifconfig_nowarn =3D true;
     }
-    else if (streq(p[0], "local") && p[1] && !p[3])
+    else if (streq(p[0], "local") && p[1] && !p[4])
     {
         struct local_entry *e;

@@ -6253,7 +6284,12 @@
         if (p[2])
         {
             e->port =3D p[2];
-            e->bind_local =3D true;
+            /*e->bind_local =3D true; */
+        }
+
+        if (p[3])
+        {
+            e->proto =3D ascii2proto(p[3]);
         }
     }
     else if (streq(p[0], "remote-random") && !p[1])
@@ -9695,3 +9731,19 @@
 err:
     gc_free(&gc);
 }
+
+bool
+has_udp_in_local_list(const struct options *options)
+{
+    if (options->ce.local_list)
+    {
+        for (int i =3D 0; i < options->ce.local_list->len; i++)
+        {
+            if (proto_is_dgram(options->ce.local_list->array[i]->proto))
+            {
+                return true;
+            }
+        }
+    }
+    return false;
+}
diff --git a/src/openvpn/options.h b/src/openvpn/options.h
index 6942455..30bd5aa 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -99,6 +99,7 @@
     const char *local;
     const char *port;
     bool bind_local;
+    int proto;
 };

 struct connection_entry
@@ -916,6 +917,8 @@

 bool key_is_external(const struct options *options);

+bool has_udp_in_local_list(const struct options *options);
+
 /**
  * Returns whether the current configuration has dco enabled.
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I31bbf87e4e568021445c7512ecefadfd4a69b363
Gerrit-Change-Number: 764
Gerrit-PatchSet: 4
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-MessageType: newpatchset

--xWhg6TeD8Cw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: its_Giaan, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/764?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Bind to multiple ipv4/ipv6 addresses<br><br>Enables the binding of mu=
ltiple listen sockets based<br>on the specified &quot;--local&quot; directi=
ves.<br><br>The main server loop has been updated to handle both<br>TCP and=
 UDP connections.<br><br>The hash function has also been modified to includ=
e the<br>protocol during the creation of new client instances.<br><br>There=
 are also a couple of refinements to make the<br>whole code flow management=
 capable of handling<br>different kind of clients:<br><br>MULTI: properly r=
emove TCP instances by checking the multi_instance<br>       protocol inste=
ad of the global one.<br><br>TLS: set the tls_option xmit_hold bool value t=
o true only in case of<br>     TCP child instance to avoid checking the glo=
bal protocol<br>     value.<br><br>INIT: initialize the c-&gt;c2.event_set =
in the inherit_context_top()<br>      by default and not only in case of UD=
P since we could have<br>      multiple different sockets.<br><br>Change-Id=
: I31bbf87e4e568021445c7512ecefadfd4a69b363<br>Signed-off-by: Gianmarco De =
Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M doc/man-sections/link-opti=
ons.rst<br>M src/openvpn/forward.c<br>M src/openvpn/forward.h<br>M src/open=
vpn/init.c<br>M src/openvpn/mroute.c<br>M src/openvpn/mroute.h<br>M src/ope=
nvpn/mtcp.c<br>M src/openvpn/mtcp.h<br>M src/openvpn/mudp.c<br>M src/openvp=
n/mudp.h<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn=
/multi_io.c<br>M src/openvpn/openvpn.h<br>M src/openvpn/options.c<br>M src/=
openvpn/options.h<br>16 files changed, 548 insertions(+), 320 deletions(-)<=
br><br></pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/64/7=
64/4</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-=
wrap;"><span>diff --git a/doc/man-sections/link-options.rst b/doc/man-secti=
ons/link-options.rst</span><br><span>index 05909ca..e2cf9b8 100644</span><b=
r><span>--- a/doc/man-sections/link-options.rst</span><br><span>+++ b/doc/m=
an-sections/link-options.rst</span><br><span>@@ -106,7 +106,7 @@</span><br>=
<span>   is not reliable. It is recommended to set tun-mtu with enough head=
room</span><br><span>   instead.</span><br><span> </span><br><span>---local=
 host|* [port]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+--loc=
al host|* [port] [protocol]</span><br><span>   Local host name or IP addres=
s and port for bind. If specified, OpenVPN will bind</span><br><span>   to =
this address. If unspecified, OpenVPN will bind to all interfaces.</span><b=
r><span>   &#39;*&#39; can be used as hostname and means &#39;any host&#39;=
 (OpenVPN will listen on what</span><br><span>diff --git a/src/openvpn/forw=
ard.c b/src/openvpn/forward.c</span><br><span>index 04f2075..f84a512 100644=
</span><br><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/open=
vpn/forward.c</span><br><span>@@ -1775,7 +1775,7 @@</span><br><span>       =
      if (c-&gt;options.shaper)</span><br><span>             {</span><br><s=
pan>                 int overhead =3D datagram_overhead(c-&gt;c2.to_link_ad=
dr-&gt;dest.addr.sa.sa_family,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                                                 c-&gt;options.ce.=
proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                                     sock-&gt;info.proto);</span><br><span>=
                 shaper_wrote_bytes(&amp;c-&gt;c2.shaper,</span><br><span> =
                                   BLEN(&amp;c-&gt;c2.to_link) + overhead);=
</span><br><span>             }</span><br><span>@@ -2072,6 +2072,173 @@</sp=
an><br><span>  */</span><br><span> </span><br><span> void</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+get_io_flags_dowork_udp(struct contex=
t *c, struct multi_protocol *multi_io, const unsigned int flags)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    unsigned int socket =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    unsigned int tuntap =3D 0;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t tun_s=
hift =3D 2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stat=
ic uintptr_t err_shift =3D 4;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Calculate the f=
lags based on the provided &#39;flags&#39; argument.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    if (flags &amp; IOW_WAIT_SIGNAL)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        wait_signal(multi_io-&gt;es, (void *)err_s=
hift);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (flags &amp; IOW_TO_LINK)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        if (flags &amp; IOW_SHAPER)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * If sending this packet would pu=
t us over our traffic shaping</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+             * quota, don&#39;t send -- instead compute the delay=
 we must wait</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
       * until it will be OK to send the packet.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            int delay =3D 0;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            /* set traffic shaping delay in microseconds */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (c-&g=
t;options.shaper)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        delay =3D max_int(delay, shaper_delay(&amp;c-&gt;c2.shaper));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            if (delay &lt; 1000)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                socket |=3D EVENT_WRITE;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                shaper_soonest_even=
t(&amp;c-&gt;c2.timeval, delay);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            socket |=
=3D EVENT_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (!((flags &amp;=
 IOW_FRAG) &amp;&amp; TO_LINK_FRAG(c)))</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        if (flags &amp; IOW_READ_TUN)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            tuntap |=3D EVENT_READ;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+     * If outgoing data (f=
or TUN/TAP device) pending, wait for ready-to-send status</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+     * from device.  Otherwise, wait =
for incoming data on TCP/UDP port.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        tuntap |=3D EVENT_WRITE;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags &amp; I=
OW_READ_LINK)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            sock=
et |=3D EVENT_READ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /*</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * outgoing bcast buffer waiting to be sent?</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; IOW_MBUF)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        socket |=3D EVENT_WRITE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /*</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+     * Force wait on TUN input, even if also waiting on TCP/UDP output</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+     */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; IOW_READ_TUN_F=
ORCE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        tuntap |=3D EVENT_RE=
AD;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    if (tuntap_is_wintun(c-&gt;c1.tuntap))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        /*</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+         * With wintun we are only interested in read e=
vent. Ring buffer is</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+         * always ready for write, so we don&#39;t do wait.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+         */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        tuntap =3D EVENT_READ;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   /*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * Configu=
re event wait based on socket, tuntap flags.</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        if (proto_is_dgram(c-&gt;c2=
.link_sockets[i]-&gt;info.proto))</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            socket_set(c-&gt;c2.link_sockets[i], multi_io-&gt;es, socke=
t,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
      &amp;c-&gt;c2.link_sockets[i]-&gt;ev_arg, NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    tun_set(c-&gt;c1.tuntap, multi_io-&gt;es, tuntap, (void *)tu=
n_shift, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io-&gt;udp_fl=
ags =3D socket | tuntap;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+get_io_flags_udp(struct context *c, struct mult=
i_protocol *multi_io, const unsigned int flags)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    if (c-&gt;c2.fast_io &amp;&amp; (flags &=
amp; (IOW_TO_TUN | IOW_TO_LINK | IOW_MBUF)))</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        /* fast path -- only for TUN/TAP/UDP writes */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int ret =3D =
0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (flags=
 &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 ret |=3D TUN_WRITE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        i=
f (flags &amp; (IOW_TO_LINK | IOW_MBUF))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            ret |=3D SOCKET_WRITE;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        multi_io-&gt;udp_flags =3D ret;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
def _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        b=
ool skip_iowait =3D flags &amp; IOW_TO_TUN;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        if (flags &amp; IOW_READ_TUN)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            /*</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             * don&#39;t read from tun if we h=
ave pending write to link,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+             * since every tun read overwrites to_link buffer filled=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             * by p=
revious tun read</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
          */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     skip_iowait =3D !(flags &amp; IOW_TO_LINK);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        if (tuntap_is_wintun(c-&gt;c1.tuntap) &amp;&amp;=
 skip_iowait)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            unsi=
gned int ret =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
            if (flags &amp; IOW_TO_TUN)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                ret |=3D TUN_WRITE;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            if (flags &amp; IOW_READ_TUN)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                ret |=3D TUN_READ;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            multi_io-&gt;u=
dp_flags =3D ret;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifdef _WI=
N32 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            /* slow pat=
h - delegate to io_wait_dowork_udp to calculate flags */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            get_io_flags_dowork_udp(c,=
 multi_io, flags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+void</span><br><span> io_wait_dowork(struct context *c, cons=
t unsigned int flags)</span><br><span> {</span><br><span>     unsigned int =
socket =3D 0;</span><br><span>@@ -2313,6 +2480,7 @@</span><br><span>     dm=
sg(D_EVENT_WAIT, &quot;I/O WAIT status=3D0x%04x&quot;, c-&gt;c2.event_set_s=
tatus);</span><br><span> }</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> void</span><br><span> process_io=
(struct context *c, struct link_socket *sock)</span><br><span> {</span><br>=
<span>diff --git a/src/openvpn/forward.h b/src/openvpn/forward.h</span><br>=
<span>index 0415726..fc4ff68 100644</span><br><span>--- a/src/openvpn/forwa=
rd.h</span><br><span>+++ b/src/openvpn/forward.h</span><br><span>@@ -69,6 +=
69,10 @@</span><br><span> </span><br><span> extern counter_type link_write_=
bytes_global;</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+void get_io_flags_dowork_udp(struct context *c, struct multi_pr=
otocol *multi_io, const unsigned int flags);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void get_io_flags_udp(struct context *c, struct multi_protocol *multi=
_io, const unsigned int flags);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> void io_wait_dowork(struct context *c, const =
unsigned int flags);</span><br><span> </span><br><span> void pre_select(str=
uct context *c);</span><br><span>diff --git a/src/openvpn/init.c b/src/open=
vpn/init.c</span><br><span>index 4eb286a..b2f772b 100644</span><br><span>--=
- a/src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><=
span>@@ -225,7 +225,7 @@</span><br><span>         if (streq(p[1], &quot;HTT=
P&quot;))</span><br><span>         {</span><br><span>             struct ht=
tp_proxy_options *ho;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
            if (ce-&gt;proto !=3D PROTO_TCP &amp;&amp; ce-&gt;proto !=3D PR=
OTO_TCP_CLIENT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        if (ce-&gt;proto !=3D PROTO_TCP &amp;&amp; c-&gt;mode !=3D CM_CHILD=
_TCP)</span><br><span>             {</span><br><span>                 msg(M=
_WARN, &quot;HTTP proxy support only works for TCP based connections&quot;)=
;</span><br><span>                 return false;</span><br><span>@@ -602,7 =
+602,10 @@</span><br><span>             ce_defined =3D false;</span><br><sp=
an>         }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        int proto =3D c-&gt;options.ce.proto;</span><br><span> =
        c-&gt;options.ce =3D *ce;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        c-&gt;options.ce.proto =3D proto;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEM=
ENT</span><br><span>         if (ce_defined &amp;&amp; management &amp;&amp=
; management_query_remote_enabled(management))</span><br><span>         {</=
span><br><span>@@ -2673,7 +2676,7 @@</span><br><span> </span><br><span>    =
 if (found &amp; OPT_P_EXPLICIT_NOTIFY)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (!proto_is_udp(c-&gt;op=
tions.ce.proto) &amp;&amp; c-&gt;options.ce.explicit_exit_notification)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!proto_is_u=
dp(c-&gt;c2.link_sockets[0]-&gt;info.proto) &amp;&amp; c-&gt;options.ce.exp=
licit_exit_notification)</span><br><span>         {</span><br><span>       =
      msg(D_PUSH, &quot;OPTIONS IMPORT: --explicit-exit-notify can only be =
used with --proto udp&quot;);</span><br><span>             c-&gt;options.ce=
.explicit_exit_notification =3D 0;</span><br><span>@@ -2833,14 +2836,21 @@<=
/span><br><span>     int sec =3D 2;</span><br><span>     int backoff =3D 0;=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 switch (c-&gt;options.ce.proto)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    switch (c-&gt;mode)</span><br><span>     {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        case PROTO_TCP_SERVER:</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            sec =3D 1;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        case CM_TOP:</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            if (has_udp_=
in_local_list(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                sec =3D c-&gt;options.ce.connect_retry_seconds;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+                sec =3D 1;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>=
             break;</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case PROTO_UDP:</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        case PROTO_TCP_CLIENT:</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        case CM_CHILD_UDP:</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        case CM_CHILD_TCP:</span><br><s=
pan>             sec =3D c-&gt;options.ce.connect_retry_seconds;</span><br>=
<span>             break;</span><br><span>     }</span><br><span>@@ -2858,7=
 +2868,7 @@</span><br><span>     }</span><br><span> </span><br><span>     /=
* Slow down reconnection after 5 retries per remote -- for TCP client or UD=
P tls-client only */</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   if (c-&gt;options.ce.proto =3D=3D PROTO_TCP_CLIENT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_CHILD_TCP</s=
pan><br><span>         || (c-&gt;options.ce.proto =3D=3D PROTO_UDP &amp;&am=
p; c-&gt;options.tls_client))</span><br><span>     {</span><br><span>      =
   backoff =3D (c-&gt;options.unsuccessful_attempts / c-&gt;options.connect=
ion_list-&gt;len) - 4;</span><br><span>@@ -3338,7 +3348,21 @@</span><br><sp=
an>     to.server =3D options-&gt;tls_server;</span><br><span>     to.repla=
y_window =3D options-&gt;replay_window;</span><br><span>     to.replay_time=
 =3D options-&gt;replay_time;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    to.tcp_mode =3D link_socket_proto_connection_oriented(options-&=
gt;ce.proto);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;options.ce.=
local_list-&gt;len &gt; 1)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 for (int i =3D 0; i &lt; c-&gt;options.ce.local_list-&gt;len; i++)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            if (proto_is_dgram(c-&gt;=
options.ce.local_list-&gt;array[i]-&gt;proto))</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                to.tcp_mode =3D false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        to.tcp_=
mode =3D link_socket_proto_connection_oriented(c-&gt;options.ce.local_list-=
&gt;array[0]-&gt;proto);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    }</span><br><span>     to.config_ciphername =3D c-&gt;options.ciph=
ername;</span><br><span>     to.config_ncp_ciphers =3D c-&gt;options.ncp_ci=
phers;</span><br><span>     to.transition_window =3D options-&gt;transition=
_window;</span><br><span>@@ -3383,7 +3407,7 @@</span><br><span> </span><br>=
<span>     /* should we not xmit any packets until we get an initial</span>=
<br><span>      * response from client? */</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    if (to.server &amp;&amp; options-&gt;ce.proto =3D=
=3D PROTO_TCP_SERVER)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    if (to.server &amp;&amp; c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><s=
pan>     {</span><br><span>         to.xmit_hold =3D true;</span><br><span>=
     }</span><br><span>@@ -3829,6 +3853,24 @@</span><br><span>     unsigned=
 int sockflags =3D c-&gt;options.sockflags;</span><br><span>     int i;</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    i=
nt mode =3D LS_MODE_DEFAULT;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* mode allows CM_CHILD_TCP</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+     * instances to inherit acceptable fds</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+     * from a top-level parent =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;opt=
ions.mode =3D=3D MODE_SERVER)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    /* initializing listening socket */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        if (c-&gt;mode =3D=3D CM_TOP)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+            mode =3D LS_MODE_TCP_LISTEN;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        /* initializing socket to cl=
ient */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        else=
 if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            mode =3D LS_MODE_TCP_ACCEPT_FROM;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span> #if PORT_SHARE</span><br><span>     if (c-&gt;o=
ptions.port_share_host &amp;&amp; c-&gt;options.port_share_port)</span><br>=
<span>     {</span><br><span>@@ -3838,33 +3880,37 @@</span><br><span> </spa=
n><br><span>     for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    int mode =3D LS_MODE_DEFAULT;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        const char *host =3D c-&gt;options.ce.local_list-&gt;=
array[i]-&gt;local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        const char *port =3D c-&gt;options.ce.local_list-&gt;array[i]-&gt;p=
ort;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        int pro=
to =3D c-&gt;options.ce.local_list-&gt;array[i]-&gt;proto;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        bool bind_local =3D c-&gt;op=
tions.ce.local_list-&gt;array[i]-&gt;bind_local;</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        /* mode allows CM_CHIL=
D_TCP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         * insta=
nces to inherit acceptable fds</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-         * from a top-level parent */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        if (c-&gt;options.mode =3D=3D MODE_SERVER)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (c-&gt;m=
ode =3D=3D CM_CHILD_TCP || c-&gt;mode =3D=3D CM_CHILD_UDP)</span><br><span>=
         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
 /* initializing listening socket */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            if (c-&gt;mode =3D=3D CM_TOP)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            const struct link_socket *=
ls =3D NULL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span>             {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                mode =3D =
LS_MODE_TCP_LISTEN;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                ls =3D c-&gt;c2.accept_from;</span><br><span>             }=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            /* initia=
lizing socket to client */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            else if (c-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            else if (c-&gt;mode =3D=
=3D CM_CHILD_UDP)</span><br><span>             {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-                mode =3D LS_MODE_TCP_ACCEPT_FROM=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ls=
 =3D c-&gt;c2.link_sockets[0];</span><br><span>             }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+            host =3D ls-&gt;local_host;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            port =3D ls-&gt;loca=
l_port;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
proto =3D ls-&gt;info.proto;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+            bind_local =3D ls-&gt;bind_local;</span><br><span>    =
     }</span><br><span> </span><br><span>         /* init each socket with =
its specific port */</span><br><span>         link_socket_init_phase1(c-&gt=
;c2.link_sockets[i],</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                               c-&gt;options.ce.local_list-&gt;array[i]-&gt=
;local,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                  c-&gt;options.ce.local_list-&gt;array[i]-&gt;port,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
      host,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                        port,</span><br><span>                             =
    c-&gt;options.ce.remote,</span><br><span>                              =
   c-&gt;options.ce.remote_port,</span><br><span>                          =
       c-&gt;c1.dns_cache,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                                c-&gt;options.ce.proto,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                                pr=
oto,</span><br><span>                                 c-&gt;options.ce.af,<=
/span><br><span>                                 c-&gt;options.ce.bind_ipv6=
_only,</span><br><span>                                 mode,</span><br><sp=
an>@@ -3874,7 +3920,7 @@</span><br><span> #ifdef ENABLE_DEBUG</span><br><sp=
an>                                 c-&gt;options.gremlin,</span><br><span>=
 #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
                  c-&gt;options.ce.local_list-&gt;array[i]-&gt;bind_local,<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
            bind_local,</span><br><span>                                 c-=
&gt;options.ce.remote_float,</span><br><span>                              =
   &amp;c-&gt;c1.link_socket_addrs[i],</span><br><span>                    =
             c-&gt;options.ipchange,</span><br><span>@@ -4265,20 +4311,13 @=
@</span><br><span> #ifdef _WIN32</span><br><span>         msg(M_INFO, &quot=
;NOTE: --fast-io is disabled since we are running on Windows&quot;);</span>=
<br><span> #else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   if (!proto_is_udp(c-&gt;options.ce.proto))</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        if (c-&gt;options.shaper)</span><br><span=
>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  msg(M_INFO, &quot;NOTE: --fast-io is disabled since we are not using UDP&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
msg(M_INFO, &quot;NOTE: --fast-io is disabled since we are using --shaper&q=
uot;);</span><br><span>         }</span><br><span>         else</span><br><=
span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      if (c-&gt;options.shaper)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                msg(M_INFO, &quot;NOTE: --fast-io is disabled since we ar=
e using --shaper&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                c-=
&gt;c2.fast_io =3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
         c-&gt;c2.fast_io =3D true;</span><br><span>         }</span><br><s=
pan> #endif</span><br><span>     }</span><br><span>@@ -4685,7 +4724,7 @@</s=
pan><br><span>     }</span><br><span> </span><br><span>     /* our wait-for=
-i/o objects, different for posix vs. win32 */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    if (c-&gt;mode =3D=3D CM_P2P)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (c-&gt;mode =3D=3D CM_P2P || =
c-&gt;mode =3D=3D CM_TOP)</span><br><span>     {</span><br><span>         d=
o_event_set_init(c, SHAPER_DEFINED(&amp;c-&gt;options));</span><br><span>  =
   }</span><br><span>@@ -4949,7 +4988,7 @@</span><br><span>     CLEAR(*dest=
);</span><br><span> </span><br><span>     /* proto_is_dgram will ASSERT(0) =
if proto is invalid */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    dest-&gt;mode =3D proto_is_dgram(src-&gt;options.ce.proto) ? CM_CHILD_=
UDP : CM_CHILD_TCP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    dest-&gt;mode =3D proto_is_dgram(sock-&gt;info.proto) ? CM_CHILD_UDP : =
CM_CHILD_TCP;</span><br><span> </span><br><span>     dest-&gt;gc =3D gc_new=
();</span><br><span> </span><br><span>@@ -4975,8 +5014,11 @@</span><br><spa=
n> </span><br><span>     /* options */</span><br><span>     dest-&gt;option=
s =3D src-&gt;options;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    dest-&gt;options.ce.proto =3D sock-&gt;info.proto;</span><br><span> =
    options_detach(&amp;dest-&gt;options);</span><br><span> </span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;c2.event_set =3D src-=
&gt;c2.event_set;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     if (dest-&gt;mode =3D=3D CM_CHILD_TCP)</span><br><span>=
     {</span><br><span>         /*</span><br><span>@@ -5071,10 +5113,7 @@</=
span><br><span>     dest-&gt;c2.es_owned =3D false;</span><br><span> </span=
><br><span>     dest-&gt;c2.event_set =3D NULL;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (proto_is_dgram(src-&gt;options.ce.proto))=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-        do_event_set_init(dest, false=
);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    do_event_set_init(dest, false=
);</span><br><span> </span><br><span> #ifdef USE_COMP</span><br><span>     =
dest-&gt;c2.comp_context =3D NULL;</span><br><span>diff --git a/src/openvpn=
/mroute.c b/src/openvpn/mroute.c</span><br><span>index 3a0224e..6f0170a 100=
644</span><br><span>--- a/src/openvpn/mroute.c</span><br><span>+++ b/src/op=
envpn/mroute.c</span><br><span>@@ -421,6 +421,7 @@</span><br><span>        =
         {</span><br><span>                     buf_printf(&amp;out, &quot;=
:%d&quot;, ntohs(maddr.v4.port));</span><br><span>                 }</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                buf_printf=
(&amp;out, &quot;:%d&quot;, maddr.proto);</span><br><span>             }</s=
pan><br><span>             break;</span><br><span> </span><br><span>diff --=
git a/src/openvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>index 570=
ccaa..e844c21 100644</span><br><span>--- a/src/openvpn/mroute.h</span><br><=
span>+++ b/src/openvpn/mroute.h</span><br><span>@@ -201,6 +201,10 @@</span>=
<br><span>     {</span><br><span>         return false;</span><br><span>   =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (a1-&gt;p=
roto !=3D a2-&gt;proto)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        re=
turn false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</s=
pan><br><span>     if (a1-&gt;netbits !=3D a2-&gt;netbits)</span><br><span>=
     {</span><br><span>         return false;</span><br><span>@@ -222,7 +22=
6,7 @@</span><br><span> static inline uint32_t</span><br><span> mroute_addr=
_hash_len(const struct mroute_addr *a)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return (uint32_t) a-&gt;len + 2;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return (uint32_t) =
a-&gt;len + 3;</span><br><span> }</span><br><span> </span><br><span> static=
 inline void</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/=
mtcp.c</span><br><span>index e173b80..c1107ab 100644</span><br><span>--- a/=
src/openvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span=
>@@ -54,7 +54,7 @@</span><br><span>     struct hash *hash =3D m-&gt;hash;</=
span><br><span> </span><br><span>     mi =3D multi_create_instance(m, NULL,=
 sock);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (mi)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (mi &amp;&amp; =
!proto_is_dgram(sock-&gt;info.proto))</span><br><span>     {</span><br><spa=
n>         mi-&gt;real.proto =3D sock-&gt;info.proto;</span><br><span>     =
    struct hash_element *he;</span><br><span>@@ -153,12 +153,19 @@</span><b=
r><span> {</span><br><span>     if (mi)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        mi-&gt;socket_set_called =
=3D true;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        sock=
et_set(mi-&gt;context.c2.link_sockets[0],</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                   m-&gt;multi_io-&gt;es,</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-                   mbuf_defined(mi-=
&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                   &amp;mi-&gt;ev_arg,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-                   &amp;m=
i-&gt;tcp_rwflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (proto_is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto=
))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            return;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            mi-&gt;socket_set_called =3D true;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+            socket_set(mi-&=
gt;context.c2.link_sockets[0],</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                       m-&gt;multi_io-&gt;es,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                       mbuf_defined(mi=
-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                       &amp;mi-&gt;ev_a=
rg,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
       &amp;mi-&gt;tcp_rwflags);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        }</span><br><span>     }</span><br><span> }</span><br>=
<span> </span><br><span>@@ -242,87 +249,3 @@</span><br><span>     }</span><=
br><span>     return ret;</span><br><span> }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Top level even=
t loop for single-threaded operation.</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- * TCP mode.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-tunnel_server_tcp(struct con=
text *top)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct multi_context multi;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int status;</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    top-&gt;mode =3D CM_TOP;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    context_clear_2(top);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    /* initialize top-tunnel instance */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    init_instance_handle_signals(top, t=
op-&gt;es, CC_HARD_USR1_TO_HUP);</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    if (IS_SIG(top))</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  return;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    /* initialize global multi_context object */<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_init(&amp;mu=
lti, top, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* initialize our clon=
ed top object */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m=
ulti_top_init(&amp;multi, top);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* init=
ialize management interface */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    init_management_callback_multi(&amp;multi);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    /* finished with initialization */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    initialization_sequence_completed(top, =
ISC_SERVER); /* --mode server --proto tcp-server */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    multi.top.c2.inotify_fd =3D inotify_init();</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    if (multi.top.c2.inotify_fd &lt=
; 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        msg(D_MULTI_ERRORS | M_ER=
RNO, &quot;MULTI: inotify_init error&quot;);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    /* per-packet event loop =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    while (true)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        perf_push(PERF_EVENT_LOOP);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        /* wait on tun/socket list */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        multi_get_timeout(&amp;=
multi, &amp;multi.top.c2.timeval);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        status =3D multi_protocol_io_wait(&amp;multi);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        MULTI_CHECK_SIG(&amp;=
multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* check on status of coars=
e timers */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        mu=
lti_process_per_second_timers(&amp;multi);</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        /* timeout? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        if (status &gt; 0)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
      /* process the I/O which triggered select */</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-            multi_protocol_process_io(&amp;mul=
ti);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            MULTI=
_CHECK_SIG(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        el=
se if (status =3D=3D 0)</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
  multi_protocol_action(&amp;multi, NULL, TA_TIMEOUT, false);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        perf_pop();</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    close(top-&gt;c2.inotify_=
fd);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* shut down management interface */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    uninit_management_callback();<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    /* save ifconfig-pool */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    multi_ifconfig_pool_persist(&amp=
;multi, true);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    /* tear down tunnel inst=
ance (unless --persist-tun) */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    multi_uninit(&amp;multi);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    multi_top_free(&amp;multi);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    close_instance(top);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span>diff --git a/src/openvpn/=
mtcp.h b/src/openvpn/mtcp.h</span><br><span>index b9f73d4..51b209b 100644</=
span><br><span>--- a/src/openvpn/mtcp.h</span><br><span>+++ b/src/openvpn/m=
tcp.h</span><br><span>@@ -51,17 +51,6 @@</span><br><span> </span><br><span>=
 void multi_tcp_link_out_deferred(struct multi_context *m, struct multi_ins=
tance *mi);</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/************=
**************************************************************/</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * Main event loop for OpenVPN in TCP server mode.<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @ingroup eventloop<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * @param top - Top-level context structu=
re.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-void tunnel_server_tcp(struct contex=
t *top);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> void multi_tcp_d=
elete_event(struct multi_protocol *multi_io, event_t event);</span><br><spa=
n> </span><br><span> #endif /* ifndef MTCP_H */</span><br><span>diff --git =
a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>index fee706d..31=
89fe9 100644</span><br><span>--- a/src/openvpn/mudp.c</span><br><span>+++ b=
/src/openvpn/mudp.c</span><br><span>@@ -194,6 +194,7 @@</span><br><span>   =
  struct hash *hash =3D m-&gt;hash;</span><br><span>     real.proto =3D soc=
k-&gt;info.proto;</span><br><span>     m-&gt;local.proto =3D real.proto;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;hmac_reply_l=
s =3D sock;</span><br><span> </span><br><span>     if (mroute_extract_openv=
pn_sockaddr(&amp;real, &amp;m-&gt;top.c2.from.dest, true)</span><br><span> =
        &amp;&amp; m-&gt;top.c2.buf.len &gt; 0)</span><br><span>@@ -320,18 =
+321,59 @@</span><br><span>         msg_set_prefix(&quot;Connection Attempt=
&quot;);</span><br><span>         m-&gt;top.c2.to_link =3D m-&gt;hmac_reply=
;</span><br><span>         m-&gt;top.c2.to_link_addr =3D m-&gt;hmac_reply_d=
est;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        process_o=
utgoing_link(&amp;m-&gt;top, m-&gt;top.c2.link_sockets[0]);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        process_outgoing_link(&amp;=
m-&gt;top, m-&gt;hmac_reply_ls);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        m-&gt;hmac_reply_ls =3D NULL;</span><br><span>        =
 m-&gt;hmac_reply_dest =3D NULL;</span><br><span>     }</span><br><span> }<=
/span><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Return the io_wait() flags appropriate for</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * a point-to-multipoint tunnel=
.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+unsigned int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+p2mp_iow_flags(const struct multi_context=
 *m)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D IOW_WA=
IT_SIGNAL;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (m=
-&gt;pending)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (TUN_OUT(=
&amp;m-&gt;pending-&gt;context))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            flags |=3D IOW_TO_TUN;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        if (LINK_OUT(&amp;m-&gt;pending-&gt;context))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            flags |=3D IOW_TO_LINK;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (mbuf_defined(m-&gt;mbuf))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        flags |=3D IOW_MBUF;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else if (m-&gt;hmac_reply_dest)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        flags |=3D IOW_TO_LINK;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    else</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        flags |=3D IOW_READ;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifd=
ef _WIN32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (tu=
ntap_ring_empty(m-&gt;top.c1.tuntap))</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        flags &amp;=3D ~IOW_READ_TUN;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/*</span><br><span>  * Process an I/O event.=
</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</sp=
an><br><span> multi_process_io_udp(struct multi_context *m)</span><br><span=
> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const unsigned=
 int status =3D m-&gt;top.c2.event_set_status;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    const unsigned int status =3D m-&gt;multi_io=
-&gt;udp_flags;</span><br><span>     const unsigned int mpp_flags =3D m-&gt=
;top.c2.fast_io</span><br><span>                                    ? (MPP_=
CONDITIONAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)</span><br><span>             =
                       : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span><br>=
<span>@@ -429,123 +471,3 @@</span><br><span>     }</span><br><span> #endif<=
/span><br><span> }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * Return the io_wait() flags appropriate f=
or</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * a point-to-multi=
point tunnel.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline unsigned int=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-p2mp_iow_flags(const =
struct multi_context *m)</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int =
flags =3D IOW_WAIT_SIGNAL;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    if (m-&gt;pending)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if=
 (TUN_OUT(&amp;m-&gt;pending-&gt;context))</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            flags |=3D IOW_TO_TUN;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        if (LINK_OUT(&amp;m-&gt;pending-&gt;context))</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            flags |=3D IOW_TO_LINK;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    else if (mbuf_defined(m-&gt;mbuf))</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-        flags |=3D IOW_MBUF;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    else if (m-&gt;hmac_reply_dest)</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        flags |=3D IOW_TO_LINK;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        flags |=3D IOW_READ=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    if (tuntap_ring_empty(m-&gt;top.c1.tunt=
ap))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        flags &amp;=3D ~IOW_READ_=
TUN;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    return flags;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-tunnel_server_udp(struct context *top)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    struct multi_context multi;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    top-&gt;mode =3D CM_TOP;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    context_clear_2(top);</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /=
* initialize top-tunnel instance */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    init_instance_handle_signals(top, top-&gt;es, CC_HARD_USR=
1_TO_HUP);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (IS_=
SIG(top))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    /* initialize global multi_context object */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    multi_init(&amp;multi, top, false);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    /* initialize our cloned top object */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_top_init(&amp;m=
ulti, top);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    /* initialize management in=
terface */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    init_ma=
nagement_callback_multi(&amp;multi);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /*=
 finished with initialization */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    initialization_sequence_completed(top, ISC_SERVER); /* --mod=
e server --proto udp */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef ENABLE_ASYNC=
_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi.top.c2=
.inotify_fd =3D inotify_init();</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    if (multi.top.c2.inotify_fd &lt; 0)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        msg(D_MULTI_ERRORS | M_ERRNO, &quot;MULTI: inotify_init=
 error&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    /* per-packet event loop */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    while (true)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        perf_push(PERF_EVENT_LOOP);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      /* set up and do the io_wait() */</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-        multi_get_timeout(&amp;multi, &amp;multi.top.c2.t=
imeval);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        io_wa=
it(&amp;multi.top, p2mp_iow_flags(&amp;multi));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        MULTI_CHECK_SIG(&amp;multi);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        /* check on status of coarse timers */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        multi_process_per_seco=
nd_timers(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* timeout? =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (multi.t=
op.c2.event_set_status =3D=3D ES_TIMEOUT)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-            multi_process_timeout(&amp;multi, MPP_PRE_SELECT|MPP_CL=
OSE_ON_SIGNAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
  }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            /* process I/O */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            multi_process_io_ud=
p(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
     MULTI_CHECK_SIG(&amp;multi);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        perf_pop();</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    close(top-&gt;c2.inotify_fd);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
/* shut down management interface */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    uninit_management_callback();</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    /* save ifconfig-pool */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    multi_ifconfig_pool_persist(&amp;multi, true);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    /* tear down tunnel instance (unless --persist-tun=
) */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_uninit(=
&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi=
_top_free(&amp;multi);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    close_instance(top);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span>diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h<=
/span><br><span>index 3107cc6..e329832 100644</span><br><span>--- a/src/ope=
nvpn/mudp.h</span><br><span>+++ b/src/openvpn/mudp.h</span><br><span>@@ -31=
,18 +31,9 @@</span><br><span> struct context;</span><br><span> struct multi=
_context;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+unsigned int p2mp_iow_flags(const struct multi_context *m);</span><=
br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * Main event loop for OpenVP=
N in UDP server mode.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 * @ingroup eventloop</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
 *</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This function im=
plements OpenVPN&#39;s main event loop for UDP server mode.</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- *</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">- * @param top - Top-level context structure.</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-void tunnel_server_udp(struct context *top);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+void multi_process_io_udp(struct multi_context *m);</span><br><span>=
 /*************************************************************************=
*/</span><br><span> /**</span><br><span>  * Get, and if necessary create, t=
he multi_instance associated with a</span><br><span>diff --git a/src/openvp=
n/multi.c b/src/openvpn/multi.c</span><br><span>index 4d7b5e6..b5efb3a 1006=
44</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/open=
vpn/multi.c</span><br><span>@@ -289,7 +289,7 @@</span><br><span>  * Main in=
itialization function, init multi_context object.</span><br><span>  */</spa=
n><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-mult=
i_init(struct multi_context *m, struct context *t, bool tcp_mode)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+multi_init(struct multi_conte=
xt *m, struct context *t)</span><br><span> {</span><br><span>     int dev =
=3D DEV_TYPE_UNDEF;</span><br><span> </span><br><span>@@ -435,13 +435,12 @@=
</span><br><span> </span><br><span>     m-&gt;instances =3D calloc(m-&gt;ma=
x_clients, sizeof(struct multi_instance *));</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;top.c2.event_set =3D t=
-&gt;c2.event_set;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span>     /*</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-     * Initialize multi-socket TCP I/O wait object</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * Initialize multi-socket I/O wait o=
bject</span><br><span>      */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (tcp_mode)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        m-&=
gt;multi_io =3D multi_protocol_init(t-&gt;options.max_clients, &amp;m-&gt;m=
ax_clients);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    m-&gt;multi_io =3D =
multi_protocol_init(t-&gt;options.max_clients, &amp;m-&gt;max_clients);</sp=
an><br><span>     m-&gt;tcp_queue_limit =3D t-&gt;options.tcp_queue_limit;<=
/span><br><span> </span><br><span>     /*</span><br><span>@@ -607,6 +606,7 =
@@</span><br><span> </span><br><span>     ASSERT(!mi-&gt;halt);</span><br><=
span>     mi-&gt;halt =3D true;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    bool is_dgram =3D proto_is_dgram(mi-&gt;context.c2.link_soc=
kets[0]-&gt;info.proto);</span><br><span> </span><br><span>     dmsg(D_MULT=
I_DEBUG, &quot;MULTI: multi_close_instance called&quot;);</span><br><span> =
</span><br><span>@@ -665,7 +665,7 @@</span><br><span>             mi-&gt;di=
d_iroutes =3D false;</span><br><span>         }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        if (m-&gt;multi_io)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!is_dgram)<=
/span><br><span>         {</span><br><span>             multi_tcp_dereferen=
ce_instance(m-&gt;multi_io, mi);</span><br><span>         }</span><br><span=
>@@ -776,7 +776,6 @@</span><br><span>         mi-&gt;real =3D *real;</span>=
<br><span>         generate_prefix(mi);</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     mi-&gt;did_o=
pen_context =3D true;</span><br><span>     inherit_context_child(&amp;mi-&g=
t;context, &amp;m-&gt;top, sock);</span><br><span>     if (IS_SIG(&amp;mi-&=
gt;context))</span><br><span>@@ -798,6 +797,7 @@</span><br><span>         {=
</span><br><span>             goto err;</span><br><span>         }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        mi-&gt;real.proto =
=3D sock-&gt;info.proto;</span><br><span>         generate_prefix(mi);</spa=
n><br><span>     }</span><br><span> </span><br><span>@@ -3401,7 +3401,7 @@<=
/span><br><span>             /* decrypt in instance context */</span><br><s=
pan> </span><br><span>             perf_push(PERF_PROC_IN_LINK);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            lsi =3D get_link_soc=
ket_info(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     lsi =3D &amp;sock-&gt;info;</span><br><span>             orig_buf =3D =
c-&gt;c2.buf.data;</span><br><span>             if (process_incoming_link_p=
art1(c, lsi, floated))</span><br><span>             {</span><br><span>@@ -3=
852,7 +3852,7 @@</span><br><span>     while ((he =3D hash_iterator_next(&am=
p;hi)))</span><br><span>     {</span><br><span>         struct multi_instan=
ce *mi =3D (struct multi_instance *) he-&gt;value;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        if (!mi-&gt;halt)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (!mi-&gt;halt &amp;&amp; prot=
o_is_dgram(mi-&gt;context.options.ce.proto))</span><br><span>         {</sp=
an><br><span>             send_control_channel_string(&amp;mi-&gt;context, =
next_server ? &quot;RESTART,[N]&quot; : &quot;RESTART&quot;, D_PUSH);</span=
><br><span>             multi_schedule_context_wakeup(m, mi);</span><br><sp=
an>@@ -3890,13 +3890,15 @@</span><br><span>         status_close(so);</span=
><br><span>         return false;</span><br><span>     }</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    else if (proto_is_dgram(m-&gt;top.op=
tions.ce.proto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-      =
       &amp;&amp; is_exit_restart(m-&gt;top.sig-&gt;signal_received)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             &amp;&amp; (m-&=
gt;deferred_shutdown_signal.signal_received =3D=3D 0)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-             &amp;&amp; m-&gt;top.options.c=
e.explicit_exit_notification !=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    else if (has_udp_in_local_list(&amp;m-&gt;top.options)=
)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-        multi_push_restart_schedule_exit(m, m-&gt;top.options.ce.explici=
t_exit_notification =3D=3D 2);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        return false;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        if (is_exit_restart(m-&gt;top.sig-&gt;signal_received)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp=
; (m-&gt;deferred_shutdown_signal.signal_received =3D=3D 0)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; m-&gt;top.op=
tions.ce.explicit_exit_notification !=3D 0)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            multi_push_restart_schedule_exit(m, m-&gt;top.opt=
ions.ce.explicit_exit_notification =3D=3D 2);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            return false;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</span><b=
r><span>     return true;</span><br><span> }</span><br><span>@@ -4169,6 +41=
71,98 @@</span><br><span>     ASSERT(mi-&gt;context.c2.tls_multi-&gt;peer_i=
d &lt; m-&gt;max_clients);</span><br><span> }</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/******************************=
********************************************/</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ * Main event loop for OpenVPN in multi-protocol server mode.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @ingroup eventloop</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * @param top - Top-level context stru=
cture.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+tunnel_server_loop(struct multi_context *mul=
ti)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    int status;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    while (true)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+        perf_push(PERF_EVENT_LOOP);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      /* wait on tun/socket list */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        multi_get_timeout(multi, &amp;multi-&gt;top.c2.time=
val);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        status=
 =3D multi_protocol_io_wait(multi);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        MULTI_CHECK_SIG(multi);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        /* check on status of coarse timers */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        multi_process_per_second_timers=
(multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        /* timeout? */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        if (status &gt; 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            /* process the I/O=
 which triggered select */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+            multi_protocol_process_io(multi);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            MULTI_CHECK_SIG(multi);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        else if (status =3D=3D 0)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            multi_protocol_acti=
on(multi, NULL, TA_TIMEOUT, false);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        perf_=
pop();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tunn=
el_server_init(struct context *top)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct multi_context multi;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    top-&=
gt;mode =3D CM_TOP;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    context_clear_2(top);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* initia=
lize top-tunnel instance */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    init_instance_handle_signals(top, top-&gt;es, CC_HARD_USR1_TO_H=
UP);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (IS_SIG(=
top))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        return;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    /* initialize global multi_context object */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    multi_init(&amp;multi, top);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* initialize our cloned top object *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_top_init=
(&amp;multi, top);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* initialize ma=
nagement interface */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    init_management_callback_multi(&amp;multi);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /* finished with initialization */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    initialization_sequence_completed(top, IS=
C_SERVER); /* --mode server --proto tcp-server */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+#ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    multi.top.c2.inotify_fd =3D inotify_init();</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    if (multi.top.c2.inotify_fd=
 &lt; 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        msg(D_MULTI_ERROR=
S | M_ERRNO, &quot;MULTI: inotify_init error&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    tunnel_s=
erver_loop(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    #ifdef ENAB=
LE_ASYNC_PUSH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cl=
ose(top-&gt;c2.inotify_fd);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* shut down managem=
ent interface */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 uninit_management_callback();</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* s=
ave ifconfig-pool */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    multi_ifconfig_pool_persist(&amp;multi, true);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    /* tear down tunnel instance (unless --persist-tun) */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_uninit(&amp=
;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    multi_t=
op_free(&amp;multi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    close_instance(top);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+}</span><br><span> </span><br><span> /*</span><br><span>  * Top level=
 event loop.</span><br><span>@@ -4178,12 +4272,6 @@</span><br><span> {</spa=
n><br><span>     ASSERT(top-&gt;options.mode =3D=3D MODE_SERVER);</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (proto=
_is_dgram(top-&gt;options.ce.proto))</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       tunnel_server_udp(top);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    els=
e</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        tunnel_server_tcp(top);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    tunnel_server_init(top);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> }</span><br><=
span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span=
>index 5ecb86a..c537c44 100644</span><br><span>--- a/src/openvpn/multi.h</s=
pan><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -205,6 +205,7 @@=
</span><br><span> </span><br><span>     struct buffer hmac_reply;</span><br=
><span>     struct link_socket_actual *hmac_reply_dest;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct link_socket *hmac_reply_ls;<=
/span><br><span> </span><br><span>     /*</span><br><span>      * Timer obj=
ect for stale route check</span><br><span>@@ -252,10 +253,8 @@</span><br><s=
pan>  * Main event loop for OpenVPN in server mode.</span><br><span>  * @in=
group eventloop</span><br><span>  *</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * This function calls the appropriate main event loop functi=
on depending</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * on the=
 transport protocol used:</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- *  - \c tunnel_server_udp()</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- *  - \c tunnel_server_tcp()</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * This function calls the main event loop function</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * on the transport pro=
tocols:</span><br><span>  *</span><br><span>  * @param top          - Top-l=
evel context structure.</span><br><span>  */</span><br><span>@@ -268,7 +267=
,7 @@</span><br><span>  * Called by mtcp.c, mudp.c, or other (to be written=
) protocol drivers</span><br><span>  */</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-void multi_init(struct multi_context *m=
, struct context *t, bool tcp_mode);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void multi_init(struct multi_context *m, struct context *t=
);</span><br><span> </span><br><span> void multi_uninit(struct multi_contex=
t *m);</span><br><span> </span><br><span>@@ -664,9 +663,12 @@</span><br><sp=
an> multi_process_outgoing_tun(struct multi_context *m, const unsigned int =
mpp_flags)</span><br><span> {</span><br><span>     struct multi_instance *m=
i =3D m-&gt;pending;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    if (!mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return false=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><s=
pan>     bool ret =3D true;</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    ASSERT(mi);</span><br><span> #ifdef MULTI_DEBUG=
_EVENT_LOOP</span><br><span>     printf(&quot;%s -&gt; TUN len=3D%d\n&quot;=
,</span><br><span>            id(mi),</span><br><span>diff --git a/src/open=
vpn/multi_io.c b/src/openvpn/multi_io.c</span><br><span>index 43fe24b..5966=
1ed 100644</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+++=
 b/src/openvpn/multi_io.c</span><br><span>@@ -142,6 +142,11 @@</span><br><s=
pan>                                      &amp;m-&gt;top.c2.link_sockets[i]=
-&gt;ev_arg);</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    if (has_udp_in_local_list(&amp;m-&gt=
;top.options))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        get_io_flag=
s_udp(&amp;m-&gt;top, m-&gt;multi_io, p2mp_iow_flags(m));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><br><span>   =
  if (tuntap_is_wintun(m-&gt;top.c1.tuntap))</span><br><span>     {</span><=
br><span>@@ -396,6 +401,10 @@</span><br><span> multi_protocol_process_io(st=
ruct multi_context *m)</span><br><span> {</span><br><span>     struct multi=
_protocol *multi_io =3D m-&gt;multi_io;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const unsigned int udp_status =3D multi_io-&gt;udp_=
flags;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const uns=
igned int mpp_flags =3D m-&gt;top.c2.fast_io</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                                   ? (MPP_CONDITIO=
NAL_PRE_SELECT | MPP_CLOSE_ON_SIGNAL)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                                   : (MPP_PRE_SELECT | MP=
P_CLOSE_ON_SIGNAL);</span><br><span>     int i;</span><br><span> </span><br=
><span>     for (i =3D 0; i &lt; multi_io-&gt;n_esr; ++i)</span><br><span>@=
@ -447,6 +456,39 @@</span><br><span>                         }</span><br><s=
pan>                         break;</span><br><span>                     }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
           if (e-&gt;arg &gt;=3D MULTI_N)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                            struct event_arg *e=
v_arg =3D (struct event_arg *)e-&gt;arg;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                            if (ev_arg-&gt;type !=3D E=
VENT_ARG_LINK_SOCKET)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                            {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                multi_io-&gt;udp_flags =3D ES_E=
RROR;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
                  msg(D_LINK_ERRORS,</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                                    &quot;MULTI PROTOCOL: =
io_work: non socket event delivered&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                                break;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                      =
  }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                           ev_arg-&gt;pending =3D true;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        if (udp_status &amp; SOCKET_=
READ)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                    read_incoming_link(&amp;m-&gt;top, ev_arg-&gt;u.sock);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    =
        if (!IS_SIG(&amp;m-&gt;top))</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                            {</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                multi_process_in=
coming_link(m, NULL, mpp_flags,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                                                            ev_=
arg-&gt;u.sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                         }</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                        }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        else</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                            multi_process_io_ud=
p(m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                break;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                    }</span><br><span>             }</span><br><span>   =
      }</span><br><span>         else</span><br><span>diff --git a/src/open=
vpn/openvpn.h b/src/openvpn/openvpn.h</span><br><span>index 77bb41d..821ac2=
e 100644</span><br><span>--- a/src/openvpn/openvpn.h</span><br><span>+++ b/=
src/openvpn/openvpn.h</span><br><span>@@ -220,8 +220,8 @@</span><br><span> =
 * \c SIGUSR1 restarts.</span><br><span>  *</span><br><span>  * This struct=
ure is initialized at the top of the \c</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">- * tunnel_point_to_point(), \c tunnel_server_udp(), and \=
c</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * tunnel_server_tcp=
() functions.  In other words, it is reset for every</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * tunnel_point_to_point(), \c tunnel_ser=
ver() \c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * function=
s.  In other words, it is reset for every</span><br><span>  * iteration of =
the \c main() function&#39;s inner \c SIGUSR1 loop.</span><br><span>  */</s=
pan><br><span> struct context_2</span><br><span>diff --git a/src/openvpn/op=
tions.c b/src/openvpn/options.c</span><br><span>index f216456..edda0bb 1006=
44</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ b/src/op=
envpn/options.c</span><br><span>@@ -993,10 +993,13 @@</span><br><span>     =
                    const struct connection_entry *e,</span><br><span>     =
                    const int i)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;proto&quot;, pro=
to2ascii(e-&gt;proto, e-&gt;af, false), i);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    /* expected to be for single socket contexts only=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(e=
s, &quot;local&quot;, e-&gt;local_list-&gt;array[0]-&gt;local, i);</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;loc=
al_port&quot;, e-&gt;local_list-&gt;array[0]-&gt;port, i);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    for (int j =3D 0; j &lt; e-&gt;l=
ocal_list-&gt;len; j++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        se=
tenv_str_i(es, &quot;proto&quot;, proto2ascii(e-&gt;local_list-&gt;array[j]=
-&gt;proto, e-&gt;af, false), i);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        /* expected to be for single socket contexts only */<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_str_i=
(es, &quot;local&quot;, e-&gt;local_list-&gt;array[j]-&gt;local, i);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        setenv_str_i(es, &=
quot;local_port&quot;, e-&gt;local_list-&gt;array[j]-&gt;port, i);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>     s=
etenv_str_i(es, &quot;remote&quot;, e-&gt;remote, i);</span><br><span>     =
setenv_str_i(es, &quot;remote_port&quot;, e-&gt;remote_port, i);</span><br>=
<span> </span><br><span>@@ -2199,6 +2202,7 @@</span><br><span>     }</span>=
<br><span> </span><br><span>     ALLOC_OBJ_CLEAR_GC(e, struct local_entry, =
gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e-&gt;proto=
 =3D PROTO_NONE;</span><br><span>     l-&gt;array[l-&gt;len++] =3D e;</span=
><br><span> </span><br><span>     return e;</span><br><span>@@ -2465,7 +246=
9,7 @@</span><br><span>     {</span><br><span>         struct local_entry *=
le =3D ce-&gt;local_list-&gt;array[i];</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (proto_is_net(ce-&gt;proto)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (proto_is_=
net(le-&gt;proto)</span><br><span>             &amp;&amp; string_defined_eq=
ual(le-&gt;local, ce-&gt;remote)</span><br><span>             &amp;&amp; st=
ring_defined_equal(le-&gt;port, ce-&gt;remote_port))</span><br><span>      =
   {</span><br><span>@@ -3170,14 +3174,30 @@</span><br><span>         if (c=
e-&gt;proto =3D=3D PROTO_TCP)</span><br><span>         {</span><br><span>  =
           ce-&gt;proto =3D PROTO_TCP_SERVER;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+            o-&gt;ce.proto =3D ce-&gt;proto;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (ce-&gt;local_list)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            for (int i =3D 0; i &=
lt; ce-&gt;local_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                if (ce-&gt;local_list-&gt;array[i]-&gt;proto =3D=
=3D PROTO_TCP)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             ce-&gt;local_list-&gt;array[i]-&gt;proto =3D PROTO_TCP_SERVER;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                else =
if (ce-&gt;local_list-&gt;array[i]-&gt;proto =3D=3D PROTO_NONE)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    ce-&gt;local_=
list-&gt;array[i]-&gt;proto =3D ce-&gt;proto;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            }</span><br><span>         }</span><br>=
<span>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    if (o-&gt;client)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    if (o-&gt;mode !=3D MODE_SERVER)</span><br><span>     {</spa=
n><br><span>         if (ce-&gt;proto =3D=3D PROTO_TCP)</span><br><span>   =
      {</span><br><span>             ce-&gt;proto =3D PROTO_TCP_CLIENT;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+            o-&gt;ce.pr=
oto =3D ce-&gt;proto;</span><br><span>         }</span><br><span>     }</sp=
an><br><span> </span><br><span>@@ -3331,6 +3351,10 @@</span><br><span>     =
{</span><br><span>         le-&gt;port =3D o-&gt;ce.local_port;</span><br><=
span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (=
!le-&gt;proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        le-&gt;prot=
o =3D o-&gt;ce.proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span> }</span><br><span> </span><br><span> #ifdef _WIN32=
</span><br><span>@@ -3807,6 +3831,12 @@</span><br><span>         options_po=
stprocess_mutate_ce(o, o-&gt;connection_list-&gt;array[i]);</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    if (!has_udp_in_local_list(o))</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        o-&gt;fast_io =3D false;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        msg(M_INFO, &quot;NOTE: --fast-io is disabled w=
hile using multi-socket&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span>     if (o-&gt;ce.local_list)</span><br><span>     {</span><=
br><span>         for (i =3D 0; i &lt; o-&gt;ce.local_list-&gt;len; i++)</s=
pan><br><span>@@ -3822,6 +3852,7 @@</span><br><span>         ASSERT(e);</sp=
an><br><span>         e-&gt;port =3D o-&gt;ce.local_port;</span><br><span> =
        e-&gt;bind_local =3D o-&gt;connection_list-&gt;array[0]-&gt;bind_lo=
cal;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        e-&gt;p=
roto =3D o-&gt;ce.proto;</span><br><span>     }</span><br><span> </span><br=
><span>     /* use the same listen list for every outgoing connection */</s=
pan><br><span>@@ -6232,7 +6263,7 @@</span><br><span>         VERIFY_PERMISS=
ION(OPT_P_UP);</span><br><span>         options-&gt;ifconfig_nowarn =3D tru=
e;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    else if (streq(p[0], &quot;local&quot;) &amp;&amp; p[1] &amp;&amp; =
!p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (=
streq(p[0], &quot;local&quot;) &amp;&amp; p[1] &amp;&amp; !p[4])</span><br>=
<span>     {</span><br><span>         struct local_entry *e;</span><br><spa=
n> </span><br><span>@@ -6253,7 +6284,12 @@</span><br><span>         if (p[2=
])</span><br><span>         {</span><br><span>             e-&gt;port =3D p=
[2];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e-&gt=
;bind_local =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+            /*e-&gt;bind_local =3D true; */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (p[3])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e-&=
gt;proto =3D ascii2proto(p[3]);</span><br><span>         }</span><br><span>=
     }</span><br><span>     else if (streq(p[0], &quot;remote-random&quot;)=
 &amp;&amp; !p[1])</span><br><span>@@ -9695,3 +9731,19 @@</span><br><span> =
err:</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+has_udp_in_local_list(const struct options *options)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (options-&gt;ce.local_list)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; options-&gt;ce.lo=
cal_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
     if (proto_is_dgram(options-&gt;ce.local_list-&gt;array[i]-&gt;proto))<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                return tru=
e;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/option=
s.h b/src/openvpn/options.h</span><br><span>index 6942455..30bd5aa 100644</=
span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openvp=
n/options.h</span><br><span>@@ -99,6 +99,7 @@</span><br><span>     const ch=
ar *local;</span><br><span>     const char *port;</span><br><span>     bool=
 bind_local;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    int=
 proto;</span><br><span> };</span><br><span> </span><br><span> struct conne=
ction_entry</span><br><span>@@ -916,6 +917,8 @@</span><br><span> </span><br=
><span> bool key_is_external(const struct options *options);</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool has_udp_in_=
local_list(const struct options *options);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Returns wh=
ether the current configuration has dco enabled.</span><br><span>  */</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/764?usp=3Demail">change 764</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/764?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I31bbf87e4e568021445c7512ece=
fadfd4a69b363 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 764 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--xWhg6TeD8Cw=--

