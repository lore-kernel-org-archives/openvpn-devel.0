From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Oct 2024 08:49:44 +0000
In-Reply-To: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
References: <gerrit.1727098847000.Icd7f6a2ad350cdc2312b3e80fa0dbdd7e4311d2e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <a4120c5b28f745ef22aedeaed556147b2b0fb3a0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="GZ9P210P3TI="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>
Cc: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--GZ9P210P3TI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/75=
7?usp=3Demail )

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
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20241023080853.3710-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
602.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/event.h
M src/openvpn/mtcp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/socket.c
M src/openvpn/socket.h
6 files changed, 68 insertions(+), 28 deletions(-)




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
index 3ae8be7..67e3e8e 100644
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
@@ -245,7 +244,7 @@
         socket_set(mi->context.c2.link_socket,
                    m->mtcp->es,
                    mbuf_defined(mi->tcp_link_out_deferred) ? EVENT_WRITE :=
 EVENT_READ,
-                   mi,
+                   &mi->ev_arg,
                    &mi->tcp_rwflags);
     }
 }
@@ -255,8 +254,8 @@
                struct multi_tcp *mtcp)
 {
     int status;
-    unsigned int *persistent =3D &mtcp->tun_rwflags;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es, MTCP_SOCKET);
+    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
+                                 &c->c2.link_socket->ev_arg);

 #ifdef _WIN32
     if (tuntap_is_wintun(c->c1.tuntap))
@@ -272,7 +271,7 @@
         persistent =3D NULL;
     }
 #endif
-    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, persistent);
+    tun_set(c->c1.tuntap, mtcp->es, EVENT_READ, MTCP_TUN, &mtcp->tun_rwfla=
gs);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     dco_event_set(&c->c1.tuntap->dco, mtcp->es, MTCP_DCO);
 #endif
@@ -685,20 +684,43 @@
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
@@ -723,18 +745,6 @@
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
index 04eb8a4..27caab4 100644
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
Gerrit-PatchSet: 6
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-MessageType: merged

--GZ9P210P3TI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/757?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">event/multi: add event_arg object to make even=
t handling more generic<br><br>In order to prepare the event handling code =
to deal with multiple<br>listening sockets, we have to make sure that it is=
 possible to<br>distinguish which of these sockets have been poked by an in=
coming<br>connection request.<br><br>To achieve that, this patch changes th=
e object being passed as<br>event handler argument, from a &quot;partly int=
eger-evaluated variable&quot;<br>to a full struct with a proper type attrib=
ute.<br><br>This struct will allow the code to carry around the particular<=
br>listening socket where the connection is being established.<br><br>This =
change affects the TCP server code path only as UDP servers<br>use only one=
 socket to handle all clients.<br><br>Change-Id: Icd7f6a2ad350cdc2312b3e80f=
a0dbdd7e4311d2e<br>Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br=
>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&gt;<br>Acked-=
by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;202410230=
80853.3710-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg29602.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/event.h<br>M src/openvpn/m=
tcp.c<br>M src/openvpn/multi.c<br>M src/openvpn/multi.h<br>M src/openvpn/so=
cket.c<br>M src/openvpn/socket.h<br>6 files changed, 68 insertions(+), 28 d=
eletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span>i=
ndex 856551a..844ea7b 100644</span><br><span>--- a/src/openvpn/event.h</spa=
n><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ -126,6 +126,20 @@<=
/span><br><span>     struct event_set_functions func;</span><br><span> };</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+typ=
edef enum {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    EVEN=
T_ARG_MULTI_INSTANCE =3D 0,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    EVENT_ARG_LINK_SOCKET,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+} event_arg_t;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* generi=
c event argument object to pass to event_ctl() */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+struct event_arg</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    event_arg_t type;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    union {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        struct multi_instance *mi; /* if type =3D EVENT_ARG_MULTI_INSTAN=
CE */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    } u;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /*</span><br><span>  * =
maxevents on input:  desired max number of event_t descriptors</span><br><s=
pan>  *                      simultaneously set with event_ctl</span><br><s=
pan>diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>in=
dex 3ae8be7..67e3e8e 100644</span><br><span>--- a/src/openvpn/mtcp.c</span>=
<br><span>+++ b/src/openvpn/mtcp.c</span><br><span>@@ -54,7 +54,6 @@</span>=
<br><span> /*</span><br><span>  * Special tags passed to event.[ch] functio=
ns</span><br><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define MTCP_SOCKET      ((void *)1)</span><br><span> #define MTCP_TUN   =
      ((void *)2)</span><br><span> #define MTCP_SIG         ((void *)3) /* =
Only on Windows */</span><br><span> #define MTCP_MANAGEMENT ((void *)4)</sp=
an><br><span>@@ -245,7 +244,7 @@</span><br><span>         socket_set(mi-&gt=
;context.c2.link_socket,</span><br><span>                    m-&gt;mtcp-&gt=
;es,</span><br><span>                    mbuf_defined(mi-&gt;tcp_link_out_d=
eferred) ? EVENT_WRITE : EVENT_READ,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                   mi,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                   &amp;mi-&gt;ev_arg,</span><br><span>  =
                  &amp;mi-&gt;tcp_rwflags);</span><br><span>     }</span><b=
r><span> }</span><br><span>@@ -255,8 +254,8 @@</span><br><span>            =
    struct multi_tcp *mtcp)</span><br><span> {</span><br><span>     int sta=
tus;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int =
*persistent =3D &amp;mtcp-&gt;tun_rwflags;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    socket_set_listen_persistent(c-&gt;c2.link_socket,=
 mtcp-&gt;es, MTCP_SOCKET);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    socket_set_listen_persistent(c-&gt;c2.link_socket, mtcp-&gt;es,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
              &amp;c-&gt;c2.link_socket-&gt;ev_arg);</span><br><span> </spa=
n><br><span> #ifdef _WIN32</span><br><span>     if (tuntap_is_wintun(c-&gt;=
c1.tuntap))</span><br><span>@@ -272,7 +271,7 @@</span><br><span>         pe=
rsistent =3D NULL;</span><br><span>     }</span><br><span> #endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    tun_set(c-&gt;c1.tuntap, mt=
cp-&gt;es, EVENT_READ, MTCP_TUN, persistent);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    tun_set(c-&gt;c1.tuntap, mtcp-&gt;es, EVENT_R=
EAD, MTCP_TUN, &amp;mtcp-&gt;tun_rwflags);</span><br><span> #if defined(TAR=
GET_LINUX) || defined(TARGET_FREEBSD)</span><br><span>     dco_event_set(&a=
mp;c-&gt;c1.tuntap-&gt;dco, mtcp-&gt;es, MTCP_DCO);</span><br><span> #endif=
</span><br><span>@@ -685,20 +684,43 @@</span><br><span>     {</span><br><sp=
an>         struct event_set_return *e =3D &amp;mtcp-&gt;esr[i];</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-        /* inc=
oming data for instance? */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        /* incoming data for instance or listening socket? */</span=
><br><span>         if (e-&gt;arg &gt;=3D MTCP_N)</span><br><span>         =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            struct m=
ulti_instance *mi =3D (struct multi_instance *) e-&gt;arg;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-            if (mi)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+            struct event_arg *ev_arg =
=3D (struct event_arg *)e-&gt;arg;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+            switch (ev_arg-&gt;type)</span><br><span>       =
      {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
  if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                    multi_tcp_action(m, mi, TA_SOCKET_WRITE_RE=
ADY, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                    multi_tcp_action(m, mi, TA_SOCKET_REA=
D, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   struct multi_instance *mi;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
       /* react to event on child instance */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                case EVENT_ARG_MULTI_INSTANCE:</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    if=
 (!ev_arg-&gt;u.mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        msg(D_MULTI_ERRORS, &quot;MULTI: mtcp_proc_io: nu=
ll minstance&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                        break;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                    }</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               mi =3D ev_arg-&gt;u.mi;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                    if (e-&gt;rwflags &amp; EVENT_WRITE)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                   =
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
       multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, false);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                    else if (e-=
&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                    {</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+                        multi_tcp_action(m, mi, TA_SOCKET_READ,=
 false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
         }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
           break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                /* ne=
w incoming TCP client attempting to connect? */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                case EVENT_ARG_LINK_SOCKET:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+                    ASS=
ERT(m-&gt;top.c2.link_socket);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    socket_reset_listen_persistent(m-&gt;top.c2.=
link_socket);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
              mi =3D multi_create_instance_tcp(m);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    if (mi)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+                        multi_tcp_=
action(m, mi, TA_INITIAL, false);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    }</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                    break;</span><br><span>             }</=
span><br><span>         }</span><br><span>         else</span><br><span>@@ =
-723,18 +745,6 @@</span><br><span>                     multi_tcp_action(m, =
NULL, TA_TUN_READ, false);</span><br><span>                 }</span><br><sp=
an>             }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        /* new incoming TCP client attempting to connect? */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-            else if (e-&gt;arg =3D=
=3D MTCP_SOCKET)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   struct multi_instance *mi;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-                ASSERT(m-&gt;top.c2.link_socket);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                socket_reset_listen_per=
sistent(m-&gt;top.c2.link_socket);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-                mi =3D multi_create_instance_tcp(m);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-                if (mi)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-                {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-                    multi_tcp_act=
ion(m, mi, TA_INITIAL, false);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                }</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            }</span><br><span> #if defined(ENABLE_DCO) &amp;&amp; (def=
ined(TARGET_LINUX) || defined(TARGET_FREEBSD))</span><br><span>            =
 /* incoming data on DCO? */</span><br><span>             else if (e-&gt;ar=
g =3D=3D MTCP_DCO)</span><br><span>diff --git a/src/openvpn/multi.c b/src/o=
penvpn/multi.c</span><br><span>index 0509911..45b3cfa 100644</span><br><spa=
n>--- a/src/openvpn/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span=
><br><span>@@ -823,6 +823,9 @@</span><br><span>         goto err;</span><br=
><span>     }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    mi-&gt;ev_arg.type =3D EVENT_ARG_MULTI_INSTANCE;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    mi-&gt;ev_arg.u.mi =3D mi;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   perf_pop();</span><br><span>     gc_free(&amp;gc);</span><br><span>     =
return mi;</span><br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/m=
ulti.h</span><br><span>index 7167639..1b99ef7 100644</span><br><span>--- a/=
src/openvpn/multi.h</span><br><span>+++ b/src/openvpn/multi.h</span><br><sp=
an>@@ -102,6 +102,12 @@</span><br><span>     struct schedule_entry se;  /* =
this must be the first element of the structure,</span><br><span>          =
                       * We cast between this and schedule_entry so the</sp=
an><br><span>                                 * beginning of the struct mus=
t be identical */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct event_arg =
ev_arg;   /**&lt; this struct will store a pointer to either mi or</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+                            =
    * link_socket, depending on the event type, to keep</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                                * it ac=
cessible it&#39;s placed within the same struct</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                                * it points to.=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
>     struct gc_arena gc;</span><br><span>     bool halt;</span><br><span> =
    int refcount;</span><br><span>diff --git a/src/openvpn/socket.c b/src/o=
penvpn/socket.c</span><br><span>index 7b1e603..cf04090 100644</span><br><sp=
an>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</s=
pan><br><span>@@ -1830,6 +1830,8 @@</span><br><span>     ALLOC_OBJ_CLEAR(so=
ck, struct link_socket);</span><br><span>     sock-&gt;sd =3D SOCKET_UNDEFI=
NED;</span><br><span>     sock-&gt;ctrl_sd =3D SOCKET_UNDEFINED;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    sock-&gt;ev_arg.type =3D E=
VENT_ARG_LINK_SOCKET;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     return sock;</span><br><span> }</span><br><span> </=
span><br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</sp=
an><br><span>index 04eb8a4..27caab4 100644</span><br><span>--- a/src/openvp=
n/socket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -1=
78,6 +178,11 @@</span><br><span> {</span><br><span>     struct link_socket_=
info info;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct event_arg ev_arg;   /**&lt; this struct will store a po=
inter to either mi or</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                * link_socket, depending on the event typ=
e, to keep</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
                       * it accessible it&#39;s placed within the same stru=
ct</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                 =
               * it points to. */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     socket_descriptor_t sd;</span><br><span=
>     socket_descriptor_t ctrl_sd; /* only used for UDP over Socks */</span=
><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"=
http://gerrit.openvpn.net/c/openvpn/+/757?usp=3Demail">change 757</a>. To u=
nsubscribe, or for help writing mail filters, visit <a href=3D"http://gerri=
t.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://=
schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"htt=
p://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/757?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icd7f6a2ad350cdc2312b3e80fa0=
dbdd7e4311d2e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 757 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
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


--GZ9P210P3TI=--

