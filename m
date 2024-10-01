From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 1 Oct 2024 15:30:04 +0000
In-Reply-To: <gerrit.1727098847000.Ibe0614bf6ced210c136b2d13036048188196f7ef@...2715...>
References: <gerrit.1727098847000.Ibe0614bf6ced210c136b2d13036048188196f7ef@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0773292678aae06b1a7cacb78ede5364a56a78f1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="SxKq2/pXin0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Refinement to handle
 simultaneous UDP and TCP connections
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

--SxKq2/pXin0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/766?usp=3Demail

to look at the new patch set (#2).


Change subject: Refinement to handle simultaneous UDP and TCP connections
......................................................................

Refinement to handle simultaneous UDP and TCP connections

MULTI: properly remove TCP instances by checking the multi_instance
       protocol instead of the global one.

TLS: set the tls_option xmit_hold bool value to true only in case of
     TCP child instance to avoid checking the global protocol
     value.

INIT: initialize the c->c2.event_set in the inherit_context_top()
      by default and not only in case of UDP since we could have
      multiple different sockets.

Change-Id: Ibe0614bf6ced210c136b2d13036048188196f7ef
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/init.c
M src/openvpn/mtcp.c
M src/openvpn/mudp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/multi_io.c
M src/openvpn/options.c
M src/openvpn/options.h
8 files changed, 142 insertions(+), 53 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/766/2

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 5877ebb..b2f772b 100644
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
@@ -4287,20 +4311,13 @@
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
@@ -4997,6 +5014,7 @@

     /* options */
     dest->options =3D src->options;
+    dest->options.ce.proto =3D sock->info.proto;
     options_detach(&dest->options);

     dest->c2.event_set =3D src->c2.event_set;
@@ -5095,10 +5113,7 @@
     dest->c2.es_owned =3D false;

     dest->c2.event_set =3D NULL;
-    if (proto_is_dgram(src->options.ce.proto))
-    {
-        do_event_set_init(dest, false);
-    }
+    do_event_set_init(dest, false);

 #ifdef USE_COMP
     dest->c2.comp_context =3D NULL;
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 5d04c64..c1107ab 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
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

diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 50b4e21..3189fe9 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -194,6 +194,7 @@
     struct hash *hash =3D m->hash;
     real.proto =3D sock->info.proto;
     m->local.proto =3D real.proto;
+    m->hmac_reply_ls =3D sock;

     if (mroute_extract_openvpn_sockaddr(&real, &m->top.c2.from.dest, true)
         && m->top.c2.buf.len > 0)
@@ -320,15 +321,8 @@
         msg_set_prefix("Connection Attempt");
         m->top.c2.to_link =3D m->hmac_reply;
         m->top.c2.to_link_addr =3D m->hmac_reply_dest;
-        for (int i =3D 0; i < m->top.c1.link_sockets_num; i++)
-        {
-            if (!proto_is_dgram(m->top.c2.link_sockets[i]->info.proto))
-            {
-                continue;
-            }
-
-            process_outgoing_link(&m->top, m->top.c2.link_sockets[i]);
-        }
+        process_outgoing_link(&m->top, m->hmac_reply_ls);
+        m->hmac_reply_ls =3D NULL;
         m->hmac_reply_dest =3D NULL;
     }
 }
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0d2ad78..b5efb3a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -606,6 +606,7 @@

     ASSERT(!mi->halt);
     mi->halt =3D true;
+    bool is_dgram =3D proto_is_dgram(mi->context.c2.link_sockets[0]->info.=
proto);

     dmsg(D_MULTI_DEBUG, "MULTI: multi_close_instance called");

@@ -664,7 +665,7 @@
             mi->did_iroutes =3D false;
         }

-        if (m->multi_io && !proto_is_dgram(m->top.options.ce.proto))
+        if (!is_dgram)
         {
             multi_tcp_dereference_instance(m->multi_io, mi);
         }
@@ -3400,7 +3401,7 @@
             /* decrypt in instance context */

             perf_push(PERF_PROC_IN_LINK);
-            lsi =3D get_link_socket_info(c);
+            lsi =3D &sock->info;
             orig_buf =3D c->c2.buf.data;
             if (process_incoming_link_part1(c, lsi, floated))
             {
@@ -3851,7 +3852,7 @@
     while ((he =3D hash_iterator_next(&hi)))
     {
         struct multi_instance *mi =3D (struct multi_instance *) he->value;
-        if (!mi->halt)
+        if (!mi->halt && proto_is_dgram(mi->context.options.ce.proto))
         {
             send_control_channel_string(&mi->context, next_server ? "RESTA=
RT,[N]" : "RESTART", D_PUSH);
             multi_schedule_context_wakeup(m, mi);
@@ -3889,13 +3890,15 @@
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
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 0a15fd9..ad56416 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -205,6 +205,7 @@

     struct buffer hmac_reply;
     struct link_socket_actual *hmac_reply_dest;
+    struct link_socket *hmac_reply_ls;

     /*
      * Timer object for stale route check
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
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 6f4d5e2..edda0bb 100644
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

@@ -2466,7 +2469,7 @@
     {
         struct local_entry *le =3D ce->local_list->array[i];

-        if (proto_is_net(ce->proto)
+        if (proto_is_net(le->proto)
             && string_defined_equal(le->local, ce->remote)
             && string_defined_equal(le->port, ce->remote_port))
         {
@@ -3828,6 +3831,12 @@
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
@@ -9722,3 +9731,19 @@
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
index f3cf7e5..30bd5aa 100644
--- a/src/openvpn/options.h
+++ b/src/openvpn/options.h
@@ -917,6 +917,8 @@

 bool key_is_external(const struct options *options);

+bool has_udp_in_local_list(const struct options *options);
+
 /**
  * Returns whether the current configuration has dco enabled.
  */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/766?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ibe0614bf6ced210c136b2d13036048188196f7ef
Gerrit-Change-Number: 766
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--SxKq2/pXin0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/766?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Refinement to handle simultaneous UDP and TCP connections<br><br>MULT=
I: properly remove TCP instances by checking the multi_instance<br>       p=
rotocol instead of the global one.<br><br>TLS: set the tls_option xmit_hold=
 bool value to true only in case of<br>     TCP child instance to avoid che=
cking the global protocol<br>     value.<br><br>INIT: initialize the c-&gt;=
c2.event_set in the inherit_context_top()<br>      by default and not only =
in case of UDP since we could have<br>      multiple different sockets.<br>=
<br>Change-Id: Ibe0614bf6ced210c136b2d13036048188196f7ef<br>Signed-off-by: =
Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>---<br>M src/openvpn/i=
nit.c<br>M src/openvpn/mtcp.c<br>M src/openvpn/mudp.c<br>M src/openvpn/mult=
i.c<br>M src/openvpn/multi.h<br>M src/openvpn/multi_io.c<br>M src/openvpn/o=
ptions.c<br>M src/openvpn/options.h<br>8 files changed, 142 insertions(+), =
53 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/66/766/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/init.c b/src/openvpn/=
init.c</span><br><span>index 5877ebb..b2f772b 100644</span><br><span>--- a/=
src/openvpn/init.c</span><br><span>+++ b/src/openvpn/init.c</span><br><span=
>@@ -225,7 +225,7 @@</span><br><span>         if (streq(p[1], &quot;HTTP&qu=
ot;))</span><br><span>         {</span><br><span>             struct http_p=
roxy_options *ho;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        if (ce-&gt;proto !=3D PROTO_TCP &amp;&amp; ce-&gt;proto !=3D PROTO_=
TCP_CLIENT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    if (ce-&gt;proto !=3D PROTO_TCP &amp;&amp; c-&gt;mode !=3D CM_CHILD_TCP=
)</span><br><span>             {</span><br><span>                 msg(M_WAR=
N, &quot;HTTP proxy support only works for TCP based connections&quot;);</s=
pan><br><span>                 return false;</span><br><span>@@ -602,7 +602=
,10 @@</span><br><span>             ce_defined =3D false;</span><br><span> =
        }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        int proto =3D c-&gt;options.ce.proto;</span><br><span>     =
    c-&gt;options.ce =3D *ce;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        c-&gt;options.ce.proto =3D proto;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef ENABLE_MANAGEMEN=
T</span><br><span>         if (ce_defined &amp;&amp; management &amp;&amp; =
management_query_remote_enabled(management))</span><br><span>         {</sp=
an><br><span>@@ -2673,7 +2676,7 @@</span><br><span> </span><br><span>     i=
f (found &amp; OPT_P_EXPLICIT_NOTIFY)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        if (!proto_is_udp(c-&gt;opti=
ons.ce.proto) &amp;&amp; c-&gt;options.ce.explicit_exit_notification)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!proto_is_udp=
(c-&gt;c2.link_sockets[0]-&gt;info.proto) &amp;&amp; c-&gt;options.ce.expli=
cit_exit_notification)</span><br><span>         {</span><br><span>         =
    msg(D_PUSH, &quot;OPTIONS IMPORT: --explicit-exit-notify can only be us=
ed with --proto udp&quot;);</span><br><span>             c-&gt;options.ce.e=
xplicit_exit_notification =3D 0;</span><br><span>@@ -2833,14 +2836,21 @@</s=
pan><br><span>     int sec =3D 2;</span><br><span>     int backoff =3D 0;</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
witch (c-&gt;options.ce.proto)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    switch (c-&gt;mode)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        case PROTO_TCP_SERVER:</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-            sec =3D 1;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        case CM_TOP:</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            if (has_udp_in=
_local_list(&amp;c-&gt;options))</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                sec =3D c-&gt;options.ce.connect_retry_seconds;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+            else</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            {</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                sec =3D 1;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            }</span><br><span>  =
           break;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        case PROTO_UDP:</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-        case PROTO_TCP_CLIENT:</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+        case CM_CHILD_UDP:</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        case CM_CHILD_TCP:</span><br><spa=
n>             sec =3D c-&gt;options.ce.connect_retry_seconds;</span><br><s=
pan>             break;</span><br><span>     }</span><br><span>@@ -2858,7 +=
2868,7 @@</span><br><span>     }</span><br><span> </span><br><span>     /* =
Slow down reconnection after 5 retries per remote -- for TCP client or UDP =
tls-client only */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
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
     }</span><br><span>@@ -4287,20 +4311,13 @@</span><br><span> #ifdef _WIN=
32</span><br><span>         msg(M_INFO, &quot;NOTE: --fast-io is disabled s=
ince we are running on Windows&quot;);</span><br><span> #else</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        if (!proto_is_udp(c-&gt;opt=
ions.ce.proto))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
    if (c-&gt;options.shaper)</span><br><span>         {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            msg(M_INFO, &quot;NOTE: --fa=
st-io is disabled since we are not using UDP&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            msg(M_INFO, &quot;NOTE: --fas=
t-io is disabled since we are using --shaper&quot;);</span><br><span>      =
   }</span><br><span>         else</span><br><span>         {</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-            if (c-&gt;options.shape=
r)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-                msg(M_INFO,=
 &quot;NOTE: --fast-io is disabled since we are using --shaper&quot;);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-            else</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                c-&gt;c2.fast_io =3D true;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+            c-&gt;c2.fast_io =3D=
 true;</span><br><span>         }</span><br><span> #endif</span><br><span> =
    }</span><br><span>@@ -4997,6 +5014,7 @@</span><br><span> </span><br><sp=
an>     /* options */</span><br><span>     dest-&gt;options =3D src-&gt;opt=
ions;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dest-&gt;o=
ptions.ce.proto =3D sock-&gt;info.proto;</span><br><span>     options_detac=
h(&amp;dest-&gt;options);</span><br><span> </span><br><span>     dest-&gt;c=
2.event_set =3D src-&gt;c2.event_set;</span><br><span>@@ -5095,10 +5113,7 @=
@</span><br><span>     dest-&gt;c2.es_owned =3D false;</span><br><span> </s=
pan><br><span>     dest-&gt;c2.event_set =3D NULL;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (proto_is_dgram(src-&gt;options.ce.prot=
o))</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        do_event_set_init(dest, fa=
lse);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    do_event_set_init(dest, fa=
lse);</span><br><span> </span><br><span> #ifdef USE_COMP</span><br><span>  =
   dest-&gt;c2.comp_context =3D NULL;</span><br><span>diff --git a/src/open=
vpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 5d04c64..c1107ab 1006=
44</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openv=
pn/mtcp.c</span><br><span>@@ -153,12 +153,19 @@</span><br><span> {</span><b=
r><span>     if (mi)</span><br><span>     {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        mi-&gt;socket_set_called =3D true;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        socket_set(mi-&gt;contex=
t.c2.link_sockets[0],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                   m-&gt;multi_io-&gt;es,</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-                   mbuf_defined(mi-&gt;tcp_link_out_def=
erred) ? EVENT_WRITE : EVENT_READ,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                   &amp;mi-&gt;ev_arg,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                   &amp;mi-&gt;tcp_rwflags)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (proto_=
is_dgram(mi-&gt;context.c2.link_sockets[0]-&gt;info.proto))</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            return;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+            mi-&gt;socket_set_called =3D true;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            socket_set(mi-&gt;context.c2.link=
_sockets[0],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                m-&gt;multi_io-&gt;es,</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                       mbuf_defined(mi-&gt;tcp_link_out_=
deferred) ? EVENT_WRITE : EVENT_READ,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                       &amp;mi-&gt;ev_arg,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                       &amp;mi-&gt=
;tcp_rwflags);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   }</span><br><span>     }</span><br><span> }</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c</span><br><span>=
index 50b4e21..3189fe9 100644</span><br><span>--- a/src/openvpn/mudp.c</spa=
n><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ -194,6 +194,7 @@</s=
pan><br><span>     struct hash *hash =3D m-&gt;hash;</span><br><span>     r=
eal.proto =3D sock-&gt;info.proto;</span><br><span>     m-&gt;local.proto =
=3D real.proto;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
m-&gt;hmac_reply_ls =3D sock;</span><br><span> </span><br><span>     if (mr=
oute_extract_openvpn_sockaddr(&amp;real, &amp;m-&gt;top.c2.from.dest, true)=
</span><br><span>         &amp;&amp; m-&gt;top.c2.buf.len &gt; 0)</span><br=
><span>@@ -320,15 +321,8 @@</span><br><span>         msg_set_prefix(&quot;C=
onnection Attempt&quot;);</span><br><span>         m-&gt;top.c2.to_link =3D=
 m-&gt;hmac_reply;</span><br><span>         m-&gt;top.c2.to_link_addr =3D m=
-&gt;hmac_reply_dest;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
        for (int i =3D 0; i &lt; m-&gt;top.c1.link_sockets_num; i++)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-            if (!proto_is_dgram(m-&gt;to=
p.c2.link_sockets[i]-&gt;info.proto))</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                continue;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-            }</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            proce=
ss_outgoing_link(&amp;m-&gt;top, m-&gt;top.c2.link_sockets[i]);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        process_outgoing_link(&amp;m-&gt;=
top, m-&gt;hmac_reply_ls);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        m-&gt;hmac_reply_ls =3D NULL;</span><br><span>         m-&gt=
;hmac_reply_dest =3D NULL;</span><br><span>     }</span><br><span> }</span>=
<br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</span><br>=
<span>index 0d2ad78..b5efb3a 100644</span><br><span>--- a/src/openvpn/multi=
.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -606,6 +606=
,7 @@</span><br><span> </span><br><span>     ASSERT(!mi-&gt;halt);</span><b=
r><span>     mi-&gt;halt =3D true;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    bool is_dgram =3D proto_is_dgram(mi-&gt;context.c2.link_=
sockets[0]-&gt;info.proto);</span><br><span> </span><br><span>     dmsg(D_M=
ULTI_DEBUG, &quot;MULTI: multi_close_instance called&quot;);</span><br><spa=
n> </span><br><span>@@ -664,7 +665,7 @@</span><br><span>             mi-&gt=
;did_iroutes =3D false;</span><br><span>         }</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        if (m-&gt;multi_io &=
amp;&amp; !proto_is_dgram(m-&gt;top.options.ce.proto))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        if (!is_dgram)</span><br><span> =
        {</span><br><span>             multi_tcp_dereference_instance(m-&gt=
;multi_io, mi);</span><br><span>         }</span><br><span>@@ -3400,7 +3401=
,7 @@</span><br><span>             /* decrypt in instance context */</span>=
<br><span> </span><br><span>             perf_push(PERF_PROC_IN_LINK);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-            lsi =3D get_li=
nk_socket_info(c);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
           lsi =3D &amp;sock-&gt;info;</span><br><span>             orig_bu=
f =3D c-&gt;c2.buf.data;</span><br><span>             if (process_incoming_=
link_part1(c, lsi, floated))</span><br><span>             {</span><br><span=
>@@ -3851,7 +3852,7 @@</span><br><span>     while ((he =3D hash_iterator_ne=
xt(&amp;hi)))</span><br><span>     {</span><br><span>         struct multi_=
instance *mi =3D (struct multi_instance *) he-&gt;value;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        if (!mi-&gt;halt)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        if (!mi-&gt;halt &amp;&amp=
; proto_is_dgram(mi-&gt;context.options.ce.proto))</span><br><span>        =
 {</span><br><span>             send_control_channel_string(&amp;mi-&gt;con=
text, next_server ? &quot;RESTART,[N]&quot; : &quot;RESTART&quot;, D_PUSH);=
</span><br><span>             multi_schedule_context_wakeup(m, mi);</span><=
br><span>@@ -3889,13 +3890,15 @@</span><br><span>         status_close(so);=
</span><br><span>         return false;</span><br><span>     }</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    else if (proto_is_dgram(m-&gt;=
top.options.ce.proto)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
             &amp;&amp; is_exit_restart(m-&gt;top.sig-&gt;signal_received)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-             &amp;&amp=
; (m-&gt;deferred_shutdown_signal.signal_received =3D=3D 0)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-             &amp;&amp; m-&gt;top.opt=
ions.ce.explicit_exit_notification !=3D 0)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    else if (has_udp_in_local_list(&amp;m-&gt;top.op=
tions))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        multi_push_restart_schedule_exit(m, m-&gt;top.options.ce.e=
xplicit_exit_notification =3D=3D 2);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        return false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        if (is_exit_restart(m-&gt;top.sig-&gt;signal_recei=
ved)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            &am=
p;&amp; (m-&gt;deferred_shutdown_signal.signal_received =3D=3D 0)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; m-&gt;=
top.options.ce.explicit_exit_notification !=3D 0)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        {</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            multi_push_restart_schedule_exit(m, m-&gt;t=
op.options.ce.explicit_exit_notification =3D=3D 2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            return false;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span>     }</s=
pan><br><span>     return true;</span><br><span> }</span><br><span>diff --g=
it a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><span>index 0a15fd=
9..ad56416 100644</span><br><span>--- a/src/openvpn/multi.h</span><br><span=
>+++ b/src/openvpn/multi.h</span><br><span>@@ -205,6 +205,7 @@</span><br><s=
pan> </span><br><span>     struct buffer hmac_reply;</span><br><span>     s=
truct link_socket_actual *hmac_reply_dest;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    struct link_socket *hmac_reply_ls;</span><br><sp=
an> </span><br><span>     /*</span><br><span>      * Timer object for stale=
 route check</span><br><span>diff --git a/src/openvpn/multi_io.c b/src/open=
vpn/multi_io.c</span><br><span>index 43fe24b..59661ed 100644</span><br><spa=
n>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/openvpn/multi_io.c=
</span><br><span>@@ -142,6 +142,11 @@</span><br><span>                     =
                 &amp;m-&gt;top.c2.link_sockets[i]-&gt;ev_arg);</span><br><=
span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    if (has_udp_in_local_list(&amp;m-&gt;top.options))</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        get_io_flags_udp(&amp;m-&gt;top, m-&=
gt;multi_io, p2mp_iow_flags(m));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span> #ifdef _WIN32</span><br><span>     if (tuntap_is_wintun(m-=
&gt;top.c1.tuntap))</span><br><span>     {</span><br><span>@@ -396,6 +401,1=
0 @@</span><br><span> multi_protocol_process_io(struct multi_context *m)</s=
pan><br><span> {</span><br><span>     struct multi_protocol *multi_io =3D m=
-&gt;multi_io;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst unsigned int udp_status =3D multi_io-&gt;udp_flags;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    const unsigned int mpp_flags =3D m=
-&gt;top.c2.fast_io</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                                   ? (MPP_CONDITIONAL_PRE_SELECT | MPP_CLOS=
E_ON_SIGNAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                            : (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL);</span=
><br><span>     int i;</span><br><span> </span><br><span>     for (i =3D 0;=
 i &lt; multi_io-&gt;n_esr; ++i)</span><br><span>@@ -447,6 +456,39 @@</span=
><br><span>                         }</span><br><span>                     =
    break;</span><br><span>                     }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    else</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                        if (e-&gt;arg =
&gt;=3D MULTI_N)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                            struct event_arg *ev_arg =3D (struct event_a=
rg *)e-&gt;arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                        if (ev_arg-&gt;type !=3D EVENT_ARG_LINK_SOCKET)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                       =
     {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                   multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                msg(D_L=
INK_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                            &quot;MULTI PROTOCOL: io_work: non socket event=
 delivered&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                               break;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                            }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        else</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                        {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
  ev_arg-&gt;pending =3D true;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
                      if (udp_status &amp; SOCKET_READ)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                            read_=
incoming_link(&amp;m-&gt;top, ev_arg-&gt;u.sock);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                            if (!IS_SIG(&amp;=
m-&gt;top))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                multi_process_incoming_link(m, NULL, mpp_=
flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
                                               ev_arg-&gt;u.sock);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
            else</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                     {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                            multi_process_io_udp(m);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                        }</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                        break;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }<=
/span><br><span>             }</span><br><span>         }</span><br><span> =
        else</span><br><span>diff --git a/src/openvpn/options.c b/src/openv=
pn/options.c</span><br><span>index 6f4d5e2..edda0bb 100644</span><br><span>=
--- a/src/openvpn/options.c</span><br><span>+++ b/src/openvpn/options.c</sp=
an><br><span>@@ -993,10 +993,13 @@</span><br><span>                        =
 const struct connection_entry *e,</span><br><span>                        =
 const int i)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    setenv_str_i(es, &quot;proto&quot;, proto2ascii(e-&gt;proto,=
 e-&gt;af, false), i);</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    /* expected to be for single socket contexts only */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;local&quot;,=
 e-&gt;local_list-&gt;array[0]-&gt;local, i);</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    setenv_str_i(es, &quot;local_port&quot;, e-&gt;=
local_list-&gt;array[0]-&gt;port, i);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int j =3D 0; j &lt; e-&gt;local_list-&gt;len; j+=
+)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;=
proto&quot;, proto2ascii(e-&gt;local_list-&gt;array[j]-&gt;proto, e-&gt;af,=
 false), i);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 /* expected to be for single socket contexts only */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;local&quot=
;, e-&gt;local_list-&gt;array[j]-&gt;local, i);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        setenv_str_i(es, &quot;local_port&quot;=
, e-&gt;local_list-&gt;array[j]-&gt;port, i);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    }</span><br><span>     setenv_str_i(es, &quot=
;remote&quot;, e-&gt;remote, i);</span><br><span>     setenv_str_i(es, &quo=
t;remote_port&quot;, e-&gt;remote_port, i);</span><br><span> </span><br><sp=
an>@@ -2466,7 +2469,7 @@</span><br><span>     {</span><br><span>         st=
ruct local_entry *le =3D ce-&gt;local_list-&gt;array[i];</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (proto_is_n=
et(ce-&gt;proto)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     if (proto_is_net(le-&gt;proto)</span><br><span>             &amp;&amp;=
 string_defined_equal(le-&gt;local, ce-&gt;remote)</span><br><span>        =
     &amp;&amp; string_defined_equal(le-&gt;port, ce-&gt;remote_port))</spa=
n><br><span>         {</span><br><span>@@ -3828,6 +3831,12 @@</span><br><sp=
an>         options_postprocess_mutate_ce(o, o-&gt;connection_list-&gt;arra=
y[i]);</span><br><span>     }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    if (!has_udp_in_local_list(o))</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+        o-&gt;fast_io =3D false;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(M_INFO, &quot;NOTE: -=
-fast-io is disabled while using multi-socket&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span>     if (o-&gt;ce.local_list)</span><b=
r><span>     {</span><br><span>         for (i =3D 0; i &lt; o-&gt;ce.local=
_list-&gt;len; i++)</span><br><span>@@ -9722,3 +9731,19 @@</span><br><span>=
 err:</span><br><span>     gc_free(&amp;gc);</span><br><span> }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+has_udp_in_local_list(const struct options *options)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    if (options-&gt;ce.local_list)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        for (int i =3D 0; i &lt; options-&gt;ce.l=
ocal_list-&gt;len; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
      if (proto_is_dgram(options-&gt;ce.local_list-&gt;array[i]-&gt;proto))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            {</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                return tr=
ue;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            }</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    return false;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/src/openvpn/optio=
ns.h b/src/openvpn/options.h</span><br><span>index f3cf7e5..30bd5aa 100644<=
/span><br><span>--- a/src/openvpn/options.h</span><br><span>+++ b/src/openv=
pn/options.h</span><br><span>@@ -917,6 +917,8 @@</span><br><span> </span><b=
r><span> bool key_is_external(const struct options *options);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool has_udp_in=
_local_list(const struct options *options);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span>  * Returns w=
hether the current configuration has dco enabled.</span><br><span>  */</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/766?usp=3Demail">change 766</a>. To unsubscribe, or fo=
r help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/set=
tings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/766?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ibe0614bf6ced210c136b2d13036=
048188196f7ef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 766 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--SxKq2/pXin0=--

