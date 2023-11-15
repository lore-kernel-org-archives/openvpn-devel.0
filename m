From: "ordex (Code Review)" <gerrit@...515...>
Date: Wed, 15 Nov 2023 13:45:05 +0000
References: <gerrit.1700055887000.If11e901c26fc5aafdcfd59a214d70c6e6a548f40@...2715...>
Reply-To: a@...2181..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <bc2908feebcce0b7ae7dfaf3b978f9d2a450cde1-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AnJrMjNWgdY="; charset=UTF-8
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

--AnJrMjNWgdY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/430?usp=3Demail

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

Change-Id: If11e901c26fc5aafdcfd59a214d70c6e6a548f40
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/event.h
M src/openvpn/mtcp.c
M src/openvpn/multi.c
M src/openvpn/multi.h
M src/openvpn/socket.c
M src/openvpn/socket.h
6 files changed, 58 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/30/430/1

diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index 6282873..23a6799 100644
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
index 62eb14b..9d383af 100644
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
@@ -264,7 +264,8 @@
 {
     int status;
     unsigned int *persistent =3D &mtcp->tun_rwflags;
-    socket_set_listen_persistent(c->c2.link_socket, mtcp->es, MTCP_SOCKET);
+    socket_set_listen_persistent(c->c2.link_socket, mtcp->es,
+                                 &c->c2.link_socket->ev_arg);

 #ifdef _WIN32
     if (tuntap_is_wintun(c->c1.tuntap))
@@ -692,21 +693,43 @@
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
index 8b490ed..af04dc8 100644
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
index 6b1c68d..7656bac 100644
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
index 903f98b..8ee14df 100644
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
index bfc1253..39e30b8 100644
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
To view, visit http://gerrit.openvpn.net/c/openvpn/+/430?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: If11e901c26fc5aafdcfd59a214d70c6e6a548f40
Gerrit-Change-Number: 430
Gerrit-PatchSet: 1
Gerrit-Owner: ordex <a@...2181...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--AnJrMjNWgdY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>ordex would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/430?usp=3Demail">Vi=
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
dle all clients i/o.<br><br>Change-Id: If11e901c26fc5aafdcfd59a214d70c6e6a5=
48f40<br>Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>---<br>M =
src/openvpn/event.h<br>M src/openvpn/mtcp.c<br>M src/openvpn/multi.c<br>M s=
rc/openvpn/multi.h<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>6=
 files changed, 58 insertions(+), 13 deletions(-)<br><br></pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/30/430/1</pre><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git=
 a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span>index 6282873.=
.23a6799 100644</span><br><span>--- a/src/openvpn/event.h</span><br><span>+=
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
 a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 62eb14b..9=
d383af 100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ =
b/src/openvpn/mtcp.c</span><br><span>@@ -253,7 +253,7 @@</span><br><span>  =
       socket_set(mi-&gt;context.c2.link_socket,</span><br><span>          =
          m-&gt;mtcp-&gt;es,</span><br><span>                    mbuf_defin=
ed(mi-&gt;tcp_link_out_deferred) ? EVENT_WRITE : EVENT_READ,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                   mi,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+                   &amp;mi-&gt;ev=
_arg,</span><br><span>                    &amp;mi-&gt;tcp_rwflags);</span><=
br><span>     }</span><br><span> }</span><br><span>@@ -264,7 +264,8 @@</spa=
n><br><span> {</span><br><span>     int status;</span><br><span>     unsign=
ed int *persistent =3D &amp;mtcp-&gt;tun_rwflags;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    socket_set_listen_persistent(c-&gt;c2.link_=
socket, mtcp-&gt;es, MTCP_SOCKET);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    socket_set_listen_persistent(c-&gt;c2.link_socket, mtcp-=
&gt;es,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
                     &amp;c-&gt;c2.link_socket-&gt;ev_arg);</span><br><span=
> </span><br><span> #ifdef _WIN32</span><br><span>     if (tuntap_is_wintun=
(c-&gt;c1.tuntap))</span><br><span>@@ -692,21 +693,43 @@</span><br><span>  =
   for (i =3D 0; i &lt; mtcp-&gt;n_esr; ++i)</span><br><span>     {</span><=
br><span>         struct event_set_return *e =3D &amp;mtcp-&gt;esr[i];</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct event_arg=
 *ev_arg =3D (struct event_arg *)e-&gt;arg;</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        /* incoming data for instan=
ce? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* in=
coming data for instance or listening socket? */</span><br><span>         i=
f (e-&gt;arg &gt;=3D MTCP_N)</span><br><span>         {</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-            struct multi_instance *mi =3D=
 (struct multi_instance *) e-&gt;arg;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-            if (mi)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            switch (ev_arg-&gt;type)</span><br><span>      =
       {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
   if (e-&gt;rwflags &amp; EVENT_WRITE)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-                {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                    multi_tcp_action(m, mi, TA_SOCKET_WRITE_R=
EADY, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
        }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
    else if (e-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                {</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                    multi_tcp_action(m, mi, TA_SOCKET_RE=
AD, false);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
      }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
    struct multi_instance *mi;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        /* react to event on child instance */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                case EVENT_ARG_MULTI_INSTANCE:</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                    i=
f (!ev_arg-&gt;u.mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                        msg(D_MULTI_ERRORS, &quot;MULTI: mtcp_proc_io: n=
ull minstance&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                        break;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                    }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                mi =3D ev_arg-&gt;u.mi;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    if (e-&gt;rwflags &amp; EVENT_WRITE=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
        multi_tcp_action(m, mi, TA_SOCKET_WRITE_READY, false);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+                    }</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+                    else if (e=
-&gt;rwflags &amp; EVENT_READ)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                    {</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+                        multi_tcp_action(m, mi, TA_SOCKET_READ=
, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
            break;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
               /* new incoming TCP client attempting to connect? */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                case EVENT_=
ARG_LINK_SOCKET:</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 ASSERT(m-&gt;top.c2.link_socket);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    socket_reset_listen_pers=
istent(m-&gt;top.c2.link_socket);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                    mi =3D multi_create_instance_tcp(m);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                    if (=
mi)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+                =
    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              =
          multi_tcp_action(m, mi, TA_INITIAL, false);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                    }</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                    break;</span><br><s=
pan>             }</span><br><span>         }</span><br><span>         else=
</span><br><span>diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c</sp=
an><br><span>index 8b490ed..af04dc8 100644</span><br><span>--- a/src/openvp=
n/multi.c</span><br><span>+++ b/src/openvpn/multi.c</span><br><span>@@ -823=
,6 +823,9 @@</span><br><span>         goto err;</span><br><span>     }</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mi=
-&gt;ev_arg.type =3D EVENT_ARG_MULTI_INSTANCE;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    mi-&gt;ev_arg.u.mi =3D mi;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     perf_pop();</sp=
an><br><span>     gc_free(&amp;gc);</span><br><span>     return mi;</span><=
br><span>diff --git a/src/openvpn/multi.h b/src/openvpn/multi.h</span><br><=
span>index 6b1c68d..7656bac 100644</span><br><span>--- a/src/openvpn/multi.=
h</span><br><span>+++ b/src/openvpn/multi.h</span><br><span>@@ -102,6 +102,=
7 @@</span><br><span>     struct schedule_entry se;  /* this must be the fi=
rst element of the structure,</span><br><span>                             =
    * We cast between this and schedule_entry so the</span><br><span>      =
                           * beginning of the struct must be identical */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct event_arg =
ev_arg;</span><br><span>     struct gc_arena gc;</span><br><span>     bool =
halt;</span><br><span>     int refcount;</span><br><span>diff --git a/src/o=
penvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 903f98b..8ee14=
df 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/=
src/openvpn/socket.c</span><br><span>@@ -1827,6 +1827,8 @@</span><br><span>=
     ALLOC_OBJ_CLEAR(sock, struct link_socket);</span><br><span>     sock-&=
gt;sd =3D SOCKET_UNDEFINED;</span><br><span>     sock-&gt;ctrl_sd =3D SOCKE=
T_UNDEFINED;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    soc=
k-&gt;ev_arg.type =3D EVENT_ARG_LINK_SOCKET;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span>     return sock;</span><br><span=
> }</span><br><span> </span><br><span>diff --git a/src/openvpn/socket.h b/s=
rc/openvpn/socket.h</span><br><span>index bfc1253..39e30b8 100644</span><br=
><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socket.=
h</span><br><span>@@ -166,6 +166,8 @@</span><br><span> {</span><br><span>  =
   struct link_socket_info info;</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    struct event_arg ev_arg;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     socket_descri=
ptor_t sd;</span><br><span>     socket_descriptor_t ctrl_sd; /* only used f=
or UDP over Socks */</span><br><span> </span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/430?usp=3De=
mail">change 430</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/430?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: If11e901c26fc5aafdcfd59a214d=
70c6e6a548f40 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 430 </div>
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


--AnJrMjNWgdY=--

