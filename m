From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 17 Oct 2024 14:47:28 +0000
In-Reply-To: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
References: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <107dc2fd266bb97c571b9afa0b95834c4bdda7d5-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="3tOhxAKj5Vo="; charset=UTF-8
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

--3tOhxAKj5Vo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: event/multi: add event_arg object to make event handling mo=
re generic
......................................................................

event/multi: add event_arg object to make event handling more generic

In order to prepare the event handling code to deal with multiple
listening sockets, we have to make sure that it is possible to
distinguish which of these sockets have been poked by an incoming
connection request.

To achieve that, this patch changes the object being passed as
event handler argument, from a "partly integer-evaluated variable"
to a full struct with a proper type attribute.

This struct will allow the code to carry around the particular
listening socket where the connection is being established.

This change affects the TCP server code path only as UDP servers
use only one socket to handle all clients.

Change-Id: Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/event.h
M src/openvpn/mtcp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/socket.c
M src/openvpn/socket.h
6 files changed, 68 insertions(+), 28 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/57/757/5

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
index 96408d1..c002a38 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -54,7 +54,6 @@
 /*
  * Special tags passed to event.[ch] functions
  */
-#define MTCP_SOCKET      ((void *)1)
 #define MTCP_TUN         ((void *)2)
 #define MTCP_SIG         ((void *)3) /* Only on Windows */
 #define MTCP_MANAGEMENT ((void *)4)
@@ -253,7 +252,7 @@
         socket_set(mi->context.c2.link_socket,
                    m->mtcp->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
-                   mi,
+                   &mi->ev_arg,
                    &mi->tcp_rwflags);
     }
 }
@@ -263,8 +262,8 @@
                struct multi_tcp *mtcp)
 {
     int status;
-    unsigned int *persistent =3D &mtcp->tun_rwflags;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es, MTCP_SOCKET);
+    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
+                                 &c->c2.link_socket->ev_arg);

 #ifdef _WIN32
     if (tuntap_is_wintun(c->c1.tuntap))
@@ -280,7 +279,7 @@
         persistent =3D NULL;
     }
 #endif
-    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
+    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwfla=
gs);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
 #endif
@@ -693,20 +692,43 @@
     {
         struct event_set_return *e =3D &mtcp->esr[i];

-        /* incoming data for instance? */
+        /* incoming data for instance or listening socket? */
         if (e->arg >=3D MTCP_N)
         {
-            struct multi_instance *mi =3D (struct multi_instance *) e->arg;
-            if (mi)
+            struct event_arg *ev_arg =3D (struct event_arg *)e->arg;
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
+
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
@@ -731,18 +753,6 @@
                     multi_tcp_action(m, NULL, TA_TUN_READ, false);
                 }
             }
-            /* new incoming TCP client attempting to connect? */
-            else if (e->arg =3D=3D MTCP_SOCKET)
-            {
-                struct multi_instance *mi;
-                ASSERT(m->top.c2.link_socket);
-                socket_reset_listen_persistent(m->top.c2.link_socket);
-                mi =3D multi_create_instance_tcp(m);
-                if (mi)
-                {
-                    multi_tcp_action(m, mi, TA_INITIAL, false);
-                }
-            }
 #if defined(ENABLE_DCO) && (defined(TARGET_LINUX) || defined(TARGET_FREEBS=
D))
             /* incoming data on DCO? */
             else if (e->arg =3D=3D MTCP_DCO)
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
index 7167639..1b99ef7 100644
--- a/src/openvpn/multi.h
+++ b/src/openvpn/multi.h
@@ -102,6 +102,12 @@
     struct schedule_entry se;  /* this must be the first element of the st=
ructure,
                                 * We cast between this and schedule_entry =
so the
                                 * beginning of the struct must be identica=
l */
+
+    struct event_arg ev_arg;   /**< this struct will store a pointer to ei=
ther mi or
+                                * link_socket, depending on the event type=
, to keep
+                                * it accessible it's placed within the sam=
e struct
+                                * it points to. */
+
     struct gc_arena gc;
     bool halt;
     int refcount;
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 7b1e603..cf04090 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -1830,6 +1830,8 @@
     ALLOC_OBJ_CLEAR(sock, struct link_socket);
     sock->sd =3D SOCKET_UNDEFINED;
     sock->ctrl_sd =3D SOCKET_UNDEFINED;
+    sock->ev_arg.type =3D EVENT_ARG_LINK_SOCKET;
+
     return sock;
 }

diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 2e583af..c152ab0 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -178,6 +178,11 @@
 {
     struct link_socket_info info;

+    struct event_arg ev_arg;   /**< this struct will store a pointer to ei=
ther mi or
+                                * link_socket, depending on the event type=
, to keep
+                                * it accessible it's placed within the sam=
e struct
+                                * it points to. */
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
Gerrit-PatchSet: 5
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: ordex <a@...2181...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-Attention: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--3tOhxAKj5Vo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>its_Giaan <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">event/multi: add=
 event_arg object to make event handling more generic<br><br>In order to pr=
epare the event handling code to deal with multiple<br>listening sockets, w=
e have to make sure that it is possible to<br>distinguish which of these so=
ckets have been poked by an incoming<br>connection request.<br><br>To achie=
ve that, this patch changes the object being passed as<br>event handler arg=
ument, from a &quot;partly integer-evaluated variable&quot;<br>to a full st=
ruct with a proper type attribute.<br><br>This struct will allow the code t=
o carry around the particular<br>listening socket where the connection is b=
eing established.<br><br>This change affects the TCP server code path only =
as UDP servers<br>use only one socket to handle all clients.<br><br>Change-=
Id: Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e<br>Signed-off-by: Antonio Qua=
rtulli &lt;a@...2181...&gt;<br>Signed-off-by: Gianmarco De Gregori &lt;gian=
marco@...2726...&gt;<br>---<br>M src/openvpn/event.h<br>M src/openvpn/mtcp.=
c<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/socket=
.c<br>M src/openvpn/socket.h<br>6 files changed, 68 insertions(+), 28 delet=
ions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chan=
ges/57/757/5</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/src/openvpn/event.h b/src/openvpn/event.h=
</span><br><span>index 856551a..844ea7b 100644</span><br><span>--- a/src/op=
envpn/event.h</span><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ =
-126,6 +126,20 @@</span><br><span>     struct event_set_functions func;</sp=
an><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+typedef enum {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    EVENT_ARG_MULTI_INSTANCE =3D 0,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    EVENT_ARG_LINK_SOCKET,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+} event_arg_t;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* generic event argument object to pass to event_ctl() */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+struct event_arg</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    event_arg_t type;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    union {</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        struct multi_instance *mi; /* if type =3D EVE=
NT_ARG_MULTI_INSTANCE */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    } u;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</s=
pan><br><span>  * maxevents on input:  desired max number of event_t descri=
ptors</span><br><span>  *                      simultaneously set with even=
t_ctl</span><br><span>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c<=
/span><br><span>index 96408d1..c002a38 100644</span><br><span>--- a/src/ope=
nvpn/mtcp.c</span><br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -54=
,7 +54,6 @@</span><br><span> /*</span><br><span>  * Special tags passed to =
event.[ch] functions</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define MTCP_SOCKET      ((void *)1)</span><br><span> #=
define MTCP_TUN         ((void *)2)</span><br><span> #define MTCP_SIG      =
   ((void *)3) /* Only on Windows */</span><br><span> #define MTCP_MANAGEME=
NT ((void *)4)</span><br><span>@@ -253,7 +252,7 @@</span><br><span>        =
 socket_set(mi-&gt;context.c2.link_socket,</span><br><span>                =
    m-&gt;mtcp-&gt;es,</span><br><span>                    mbuf_defined(mi-=
&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-                   mi,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                   &amp;mi-&gt;ev_arg,<=
/span><br><span>                    &amp;mi-&gt;tcp_rwflags);</span><br><sp=
an>     }</span><br><span> }</span><br><span>@@ -263,8 +262,8 @@</span><br>=
<span>                struct multi_tcp *mtcp)</span><br><span> {</span><br>=
<span>     int status;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    unsigned int *persistent =3D &amp;mtcp-&gt;tun_rwflags;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    socket_set_listen_persistent(c-&=
gt;c2.link_socket, mtcp-&gt;es, MTCP_SOCKET);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    socket_set_listen_persistent(c-&gt;c2.link_so=
cket, mtcp-&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                                &amp;c-&gt;c2.link_socket-&gt;ev_arg);</spa=
n><br><span> </span><br><span> #ifdef _WIN32</span><br><span>     if (tunta=
p_is_wintun(c-&gt;c1.tuntap))</span><br><span>@@ -280,7 +279,7 @@</span><br=
><span>         persistent =3D NULL;</span><br><span>     }</span><br><span=
> #endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tun_set(c=
-&gt;c1.tuntap, mtcp-&gt;es, EVENT_READ, MTCP_TUN, persistent);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    tun_set(c-&gt;c1.tuntap, mt=
cp-&gt;es, EVENT_READ, MTCP_TUN, &amp;mtcp-&gt;tun_rwflags);</span><br><spa=
n> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span>   =
  dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, mtcp-&gt;es, MTCP_DCO);</span=
><br><span> #endif</span><br><span>@@ -693,20 +692,43 @@</span><br><span>  =
   {</span><br><span>         struct event_set_return *e =3D &amp;mtcp-&gt;=
esr[i];</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        /* incoming data for instance? */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        /* incoming data for instance or listenin=
g socket? */</span><br><span>         if (e-&gt;arg &gt;=3D MTCP_N)</span><=
br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
          struct multi_instance *mi =3D (struct multi_instance *) e-&gt;arg=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            if (mi)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            struct e=
vent_arg *ev_arg =3D (struct event_arg *)e-&gt;arg;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            switch (ev_arg-&gt;type)</spa=
n><br><span>             {</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-                if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                    multi_tcp_action(m, mi,=
 TA_SOCKET_WRITE_READY, false);</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-                    multi_tcp_action(m=
, mi, TA_SOCKET_READ, false);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                }</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                struct multi_instance *mi;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                /* react to event on child instance */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                case EVENT_ARG=
_MULTI_INSTANCE:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 if (!ev_arg-&gt;u.mi)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+                        msg(D_MULTI_ERRORS, &quot;MULT=
I: mtcp_proc_io: null minstance&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                        break;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+                    mi =3D ev_arg-&gt;u.mi;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    if (e-&gt;rwflag=
s &amp; EVENT_WRITE)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, f=
alse);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        multi_tcp_action(=
m, mi, TA_SOCKET_READ, false);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    }</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    break;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                /* new incoming TCP client attempting to connect? */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                case EVEN=
T_ARG_LINK_SOCKET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   ASSERT(m-&gt;top.c2.link_socket);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    socket_reset_listen_p=
ersistent(m-&gt;top.c2.link_socket);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+                    mi =3D multi_create_instance_tcp(m);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    i=
f (mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
       {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
             multi_tcp_action(m, mi, TA_INITIAL, false);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br=
><span>             }</span><br><span>         }</span><br><span>         e=
lse</span><br><span>@@ -731,18 +753,6 @@</span><br><span>                  =
   multi_tcp_action(m, NULL, TA_TUN_READ, false);</span><br><span>         =
        }</span><br><span>             }</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            /* new incoming TCP client attempting to con=
nect? */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            e=
lse if (e-&gt;arg =3D=3D MTCP_SOCKET)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                struct multi_instance *mi;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-                ASSERT(m-&gt;top.c2.link_socke=
t);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                so=
cket_reset_listen_persistent(m-&gt;top.c2.link_socket);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                mi =3D multi_create_insta=
nce_tcp(m);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      if (mi)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
        multi_tcp_action(m, mi, TA_INITIAL, false);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                }</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-            }</span><br><span> #if defined(ENAB=
LE_DCO) &amp;&amp; (defined(TARGET_LINUX) || defined(TARGET_FREEBSD))</span=
><br><span>             /* incoming data on DCO? */</span><br><span>       =
      else if (e-&gt;arg =3D=3D MTCP_DCO)</span><br><span>diff --git a/src/=
openvpn/multi.c b/src/openvpn/multi.c</span><br><span>index 0509911..45b3cf=
a 100644</span><br><span>--- a/src/openvpn/multi.c</span><br><span>+++ b/sr=
c/openvpn/multi.c</span><br><span>@@ -823,6 +823,9 @@</span><br><span>     =
    goto err;</span><br><span>     }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;ev_arg.type =3D EVENT_ARG_MUL=
TI_INSTANCE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi-=
&gt;ev_arg.u.mi =3D mi;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     perf_pop();</span><br><span>     gc_free(&amp;gc)=
;</span><br><span>     return mi;</span><br><span>diff --git a/src/openvpn/=
multi.h b/src/openvpn/multi.h</span><br><span>index 7167639..1b99ef7 100644=
</span><br><span>--- a/src/openvpn/multi.h</span><br><span>+++ b/src/openvp=
n/multi.h</span><br><span>@@ -102,6 +102,12 @@</span><br><span>     struct =
schedule_entry se;  /* this must be the first element of the structure,</sp=
an><br><span>                                 * We cast between this and sc=
hedule_entry so the</span><br><span>                                 * begi=
nning of the struct must be identical */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct event_arg ev_arg;   /**&lt; this struct will store a pointer t=
o either mi or</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
                           * link_socket, depending on the event type, to k=
eep</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
                * it accessible it&#39;s placed within the same struct</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                        =
        * it points to. */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span>     struct gc_arena gc;</span><br><span>     bool =
halt;</span><br><span>     int refcount;</span><br><span>diff --git a/src/o=
penvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 7b1e603..cf040=
90 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/=
src/openvpn/socket.c</span><br><span>@@ -1830,6 +1830,8 @@</span><br><span>=
     ALLOC_OBJ_CLEAR(sock, struct link_socket);</span><br><span>     sock-&=
gt;sd =3D SOCKET_UNDEFINED;</span><br><span>     sock-&gt;ctrl_sd =3D SOCKE=
T_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    soc=
k-&gt;ev_arg.type =3D EVENT_ARG_LINK_SOCKET;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     return sock;</span><br><span=
> }</span><br><span> </span><br><span>diff --git a/src/openvpn/socket.h b/s=
rc/openvpn/socket.h</span><br><span>index 2e583af..c152ab0 100644</span><br=
><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socket.=
h</span><br><span>@@ -178,6 +178,11 @@</span><br><span> {</span><br><span> =
    struct link_socket_info info;</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct event_arg ev_arg;   /**&lt; th=
is struct will store a pointer to either mi or</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                                * link_socket, d=
epending on the event type, to keep</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                                * it accessible it&#39;s pl=
aced within the same struct</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+                                * it points to. */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     socket_descrip=
tor_t sd;</span><br><span>     socket_descriptor_t ctrl_sd; /* only used fo=
r UDP over Socks */</span><br><span> </span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Dem=
ail">change 757</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icd7f6a2ad350cdc2312b3e80fa0=
dbdd7e4311d2e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 757 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
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
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;a@...2181...&gt; <=
/div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--3tOhxAKj5Vo=--

