From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 23 Sep 2024 13:41:17 +0000
References: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <e6dfb61ed58a192b6ca1ff3a93a9a4d9e93d26c9-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gzx/80ngdwc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: event/multi: add
 event_arg object to make event handling more generic
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

--gzx/80ngdwc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail

to review the following change.


Change subject: event/multi: add event_arg object to make event handling mo=
re generic
......................................................................

event/multi: add event_arg object to make event handling more generic

In order to prepare the event handling code to deal with multiple
listening sockets, we have to make sure that it is possible to
distinguish which of these sockets have been pocked by an incoming
connection request.

To achieve that, this patch changes the object being passed as
event handler argument, from a "partly integer evaluated variable"
to a full struct with a proper type attribute.

This struct will allow the code to carry around the particular
listening socket where the connection is being established.

This change affects the TCP server code path only as UDP servers
use only one socket to handle all clients i/o.

Change-Id: Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/event.h
M src/openvpn/mtcp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/socket.c
M src/openvpn/socket.h
6 files changed, 59 insertions(+), 15 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/757/1

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 856551a..844ea7b 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -126,6 +126,20 @@
     struct event_set_functions func;
 };

+typedef enum {
+    EVENT_ARG_MULTI_INSTANCE =3D 0,
+    EVENT_ARG_LINK_SOCKET,
+} event_arg_t;
+
+/* generic event argument object to pass to event_ctl() */
+struct event_arg
+{
+    event_arg_t type;
+    union {
+        struct multi_instance *mi; /* if type =3D EVENT_ARG_MULTI_INSTANCE=
 */
+    } u;
+};
+
 /*
  * maxevents on input:  desired max number of event_t descriptors
  *                      simultaneously set with event_ctl
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 96408d1..e47712a 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -253,7 +253,7 @@
         socket_set(mi->context.c2.link_socket,
                    m->mtcp->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
-                   mi,
+                   &mi->ev_arg,
                    &mi->tcp_rwflags);
     }
 }
@@ -263,8 +263,8 @@
                struct multi_tcp *mtcp)
 {
     int status;
-    unsigned int *persistent =3D &mtcp->tun_rwflags;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es, MTCP_SOCKET);
+    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
+                                 &c->c2.link_socket->ev_arg);

 #ifdef _WIN32
     if (tuntap_is_wintun(c->c1.tuntap))
@@ -280,7 +280,7 @@
         persistent =3D NULL;
     }
 #endif
-    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
+    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwfla=
gs);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
 #endif
@@ -692,21 +692,43 @@
     for (i =3D 0; i < mtcp->n_esr; ++i)
     {
         struct event_set_return *e =3D &mtcp->esr[i];
+        struct event_arg *ev_arg =3D (struct event_arg *)e->arg;

-        /* incoming data for instance? */
+        /* incoming data for instance or listening socket? */
         if (e->arg >=3D MTCP_N)
         {
-            struct multi_instance *mi =3D (struct multi_instance *) e->arg;
-            if (mi)
+            switch (ev_arg->type)
             {
-                if (e->rwflags & EVENT_WRITE)
-                {
-                    multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, false);
-                }
-                else if (e->rwflags & EVENT_READ)
-                {
-                    multi_tcp_action(m, mi, TA_SOCKET_READ, false);
-                }
+                struct multi_instance *mi;
+
+                /* react to event on child instance */
+                case EVENT_ARG_MULTI_INSTANCE:
+                    if (!ev_arg->u.mi)
+                    {
+                        msg(D_MULTI_ERRORS, "MULTI: mtcp_proc_io: null min=
stance");
+                        break;
+                    }
+
+                    mi =3D ev_arg->u.mi;
+                    if (e->rwflags & EVENT_WRITE)
+                    {
+                        multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, fal=
se);
+                    }
+                    else if (e->rwflags & EVENT_READ)
+                    {
+                        multi_tcp_action(m, mi, TA_SOCKET_READ, false);
+                    }
+                    break;
+                /* new incoming TCP client attempting to connect? */
+                case EVENT_ARG_LINK_SOCKET:
+                    ASSERT(m->top.c2.link_socket);
+                    socket_reset_listen_persistent(m->top.c2.link_socket);
+                    mi =3D multi_create_instance_tcp(m);
+                    if (mi)
+                    {
+                        multi_tcp_action(m, mi, TA_INITIAL, false);
+                    }
+                    break;
             }
         }
         else
diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 0509911..45b3cfa 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -823,6 +823,9 @@
         goto err;
     }

+    mi->ev_arg.type =3D EVENT_ARG_MULTI_INSTANCE;
+    mi->ev_arg.u.mi =3D mi;
+
     perf_pop();
     gc_free(&gc);
     return mi;
diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h
index 7167639..e403989 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -102,6 +102,7 @@
     struct schedule_entry se;  /* this must be the first element of the st=
ructure,
                                 * We cast between this and schedule_entry =
so the
                                 * beginning of the struct must be identica=
l */
+    struct event_arg ev_arg;
     struct gc_arena gc;
     bool halt;
     int refcount;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6c790a0..924e30c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1827,6 +1827,8 @@
     ALLOC_OBJ_CLEAR(sock, struct link_socket);
     sock->sd =3D SOCKET_UNDEFINED;
     sock->ctrl_sd =3D SOCKET_UNDEFINED;
+    sock->ev_arg.type =3D EVENT_ARG_LINK_SOCKET;
+
     return sock;
 }

diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index bbdabfb..6857202 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -166,6 +166,8 @@
 {
     struct link_socket_info info;

+    struct event_arg ev_arg;
+
     socket_descriptor_t sd;
     socket_descriptor_t ctrl_sd; /* only used for UDP over Socks */


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e
Gerrit-Change-Number: 757
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

--gzx/80ngdwc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">event/multi: add event_arg object to make event handling more=
 generic<br><br>In order to prepare the event handling code to deal with mu=
ltiple<br>listening sockets, we have to make sure that it is possible to<br=
>distinguish which of these sockets have been pocked by an incoming<br>conn=
ection request.<br><br>To achieve that, this patch changes the object being=
 passed as<br>event handler argument, from a &quot;partly integer evaluated=
 variable&quot;<br>to a full struct with a proper type attribute.<br><br>Th=
is struct will allow the code to carry around the particular<br>listening s=
ocket where the connection is being established.<br><br>This change affects=
 the TCP server code path only as UDP servers<br>use only one socket to han=
dle all clients i/o.<br><br>Change-Id: Icd7f6a2ad350cdc2312b3e80fa0dbdd7e43=
11d2e<br>Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>---<br>M =
src/openvpn/event.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/multi.c<br>M s=
rc/openvpn/multi.h<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>6=
 files changed, 59 insertions(+), 15 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/57/757/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span>index 856551a.=
.844ea7b 100644</span><br><span>--- a/src/openvpn/event.h</span><br><span>+=
++ b/src/openvpn/event.h</span><br><span>@@ -126,6 +126,20 @@</span><br><sp=
an>     struct event_set_functions func;</span><br><span> };</span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+typedef enum {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVENT_ARG_MULTI_I=
NSTANCE =3D 0,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    E=
VENT_ARG_LINK_SOCKET,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+} event_arg_t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/* generic event argum=
ent object to pass to event_ctl() */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+struct event_arg</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
event_arg_t type;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  union {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        st=
ruct multi_instance *mi; /* if type =3D EVENT_ARG_MULTI_INSTANCE */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    } u;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * maxevents on i=
nput:  desired max number of event_t descriptors</span><br><span>  *       =
               simultaneously set with event_ctl</span><br><span>diff --git=
 a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 96408d1..e=
47712a 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ =
b/src/openvpn/mtcp.c</span><br><span>@@ -253,7 +253,7 @@</span><br><span>  =
       socket_set(mi-&gt;context.c2.link_socket,</span><br><span>          =
          m-&gt;mtcp-&gt;es,</span><br><span>                    mbuf_defin=
ed(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                   mi,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                   &amp;mi-&gt;ev=
_arg,</span><br><span>                    &amp;mi-&gt;tcp_rwflags);</span><=
br><span>     }</span><br><span> }</span><br><span>@@ -263,8 +263,8 @@</spa=
n><br><span>                struct multi_tcp *mtcp)</span><br><span> {</spa=
n><br><span>     int status;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    unsigned int *persistent =3D &amp;mtcp-&gt;tun_rwflags;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    socket_set_listen_persiste=
nt(c-&gt;c2.link_socket, mtcp-&gt;es, MTCP_SOCKET);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    socket_set_listen_persistent(c-&gt;c2=
.link_socket, mtcp-&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+                                 &amp;c-&gt;c2.link_socket-&gt;ev_ar=
g);</span><br><span> </span><br><span> #ifdef _WIN32</span><br><span>     i=
f (tuntap_is_wintun(c-&gt;c1.tuntap))</span><br><span>@@ -280,7 +280,7 @@</=
span><br><span>         persistent =3D NULL;</span><br><span>     }</span><=
br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    t=
un_set(c-&gt;c1.tuntap, mtcp-&gt;es, EVENT_READ, MTCP_TUN, persistent);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    tun_set(c-&gt;c1.tu=
ntap, mtcp-&gt;es, EVENT_READ, MTCP_TUN, &amp;mtcp-&gt;tun_rwflags);</span>=
<br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><=
span>     dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, mtcp-&gt;es, MTCP_DCO=
);</span><br><span> #endif</span><br><span>@@ -692,21 +692,43 @@</span><br>=
<span>     for (i =3D 0; i &lt; mtcp-&gt;n_esr; ++i)</span><br><span>     {=
</span><br><span>         struct event_set_return *e =3D &amp;mtcp-&gt;esr[=
i];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct e=
vent_arg *ev_arg =3D (struct event_arg *)e-&gt;arg;</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* incoming data fo=
r instance? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   /* incoming data for instance or listening socket? */</span><br><span>  =
       if (e-&gt;arg &gt;=3D MTCP_N)</span><br><span>         {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-            struct multi_instance=
 *mi =3D (struct multi_instance *) e-&gt;arg;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            if (mi)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            switch (ev_arg-&gt;type)</span><br><spa=
n>             {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
           if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                    multi_tcp_action(m, mi, TA_SOCKET=
_WRITE_READY, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
                }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-                    multi_tcp_action(m, mi, TA_=
SOCKET_READ, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
               }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
             struct multi_instance *mi;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                /* react to event on child instance */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                case EVENT_ARG_MULTI_IN=
STANCE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
        if (!ev_arg-&gt;u.mi)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        msg(D_MULTI_ERRORS, &quot;MULTI: mtcp_p=
roc_io: null minstance&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                        break;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    }</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                    mi =3D ev_arg-&gt;u.mi;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                    if (e-&gt;rwflags &amp; EV=
ENT_WRITE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                 multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, false);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    }</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    e=
lse if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                        multi_tcp_action(m, mi, TA_SO=
CKET_READ, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   }</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    break;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                /* new incoming TCP client attempting to connect? *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                ca=
se EVENT_ARG_LINK_SOCKET:</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                    ASSERT(m-&gt;top.c2.link_socket);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+                    socket_reset_li=
sten_persistent(m-&gt;top.c2.link_socket);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                    mi =3D multi_create_instance_tcp=
(m);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+               =
     if (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
             {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                   multi_tcp_action(m, mi, TA_INITIAL, false);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    break;</sp=
an><br><span>             }</span><br><span>         }</span><br><span>    =
     else</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/mu=
lti.c</span><br><span>index 0509911..45b3cfa 100644</span><br><span>--- a/s=
rc/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><spa=
n>@@ -823,6 +823,9 @@</span><br><span>         goto err;</span><br><span>  =
   }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    mi-&gt;ev_arg.type =3D EVENT_ARG_MULTI_INSTANCE;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;ev_arg.u.mi =3D mi;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     perf_p=
op();</span><br><span>     gc_free(&amp;gc);</span><br><span>     return mi=
;</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</s=
pan><br><span>index 7167639..e403989 100644</span><br><span>--- a/src/openv=
pn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -10=
2,6 +102,7 @@</span><br><span>     struct schedule_entry se;  /* this must =
be the first element of the structure,</span><br><span>                    =
             * We cast between this and schedule_entry so the</span><br><sp=
an>                                 * beginning of the struct must be ident=
ical */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct e=
vent_arg ev_arg;</span><br><span>     struct gc_arena gc;</span><br><span> =
    bool halt;</span><br><span>     int refcount;</span><br><span>diff --gi=
t a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 6c790=
a0..924e30c 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><sp=
an>+++ b/src/openvpn/socket.c</span><br><span>@@ -1827,6 +1827,8 @@</span><=
br><span>     ALLOC_OBJ_CLEAR(sock, struct link_socket);</span><br><span>  =
   sock-&gt;sd =3D SOCKET_UNDEFINED;</span><br><span>     sock-&gt;ctrl_sd =
=3D SOCKET_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    sock-&gt;ev_arg.type =3D EVENT_ARG_LINK_SOCKET;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     return sock;</span>=
<br><span> }</span><br><span> </span><br><span>diff --git a/src/openvpn/soc=
ket.h b/src/openvpn/socket.h</span><br><span>index bbdabfb..6857202 100644<=
/span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvp=
n/socket.h</span><br><span>@@ -166,6 +166,8 @@</span><br><span> {</span><br=
><span>     struct link_socket_info info;</span><br><span> </span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct event_arg ev_arg;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     sock=
et_descriptor_t sd;</span><br><span>     socket_descriptor_t ctrl_sd; /* on=
ly used for UDP over Socks */</span><br><span> </span><br><span></span><br>=
</pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/75=
7?usp=3Demail">change 757</a>. To unsubscribe, or for help writing mail fil=
ters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p=
><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope =
itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempro=
p=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icd7f6a2ad350cdc2312b3e80fa0=
dbdd7e4311d2e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 757 </div>
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


--gzx/80ngdwc=--

