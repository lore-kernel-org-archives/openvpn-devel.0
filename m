From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Oct 2024 20:30:23 +0000
In-Reply-To: <gerrit.1727098847000.I7ebf0d4fb2a23278e16003b2e35598178155d658@...2715...>
References: <gerrit.1727098847000.I7ebf0d4fb2a23278e16003b2e35598178155d658@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <2018dd24386d85d9441cadc9ed99717e401434b8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="sUM0F7W6KOg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: io_work: pass
 event_arg object to event handler in case of socket event
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

--sUM0F7W6KOg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/76=
0?usp=3Demail )

Change subject: io_work: pass event_arg object to event handler in case of =
socket event
......................................................................

io_work: pass event_arg object to event handler in case of socket event

In order to allow the code to work with multiple listening sockets
it is essential to allow the generic multi_io event handler
to distinguish between the various socket objects.

This can be achieved by passing an event_arg object that contains
a pointer to the link_socket.

This code path is used on clients as well as UDP servers.

Change-Id: I7ebf0d4fb2a23278e16003b2e35598178155d658
Signed-off-by: Antonio Quartulli <a@...2181...>
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Message-Id: <20241023142030.731-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
625.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/event.h
M src/openvpn/forward.c
M src/openvpn/mtcp.c
3 files changed, 37 insertions(+), 4 deletions(-)




diff --git a/src/openvpn/event.h b/src/openvpn/event.h
index b3ba183..c212e07 100644
--- a/src/openvpn/event.h
+++ b/src/openvpn/event.h
@@ -82,6 +82,12 @@
 #define EVENT_METHOD_US_TIMEOUT   (1<<0)
 #define EVENT_METHOD_FAST         (1<<1)

+/*
+ * The following constant is used as boundary between integer value
+ * and real addresses when passing arguments to event handlers as (void *)
+ */
+#define MULTI_N           ((void *)16) /* upper bound on MTCP_x */
+
 #ifdef _WIN32

 typedef const struct rw_handle *event_t;
diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 66e5be1..d50b24c 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2183,7 +2183,8 @@
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)socket_=
shift, NULL);
+    socket_set(c->c2.link_socket, c->c2.event_set, socket,
+               &c->c2.link_socket->ev_arg, NULL);
     tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL=
);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
@@ -2246,7 +2247,27 @@
                 for (i =3D 0; i < status; ++i)
                 {
                     const struct event_set_return *e =3D &esr[i];
-                    c->c2.event_set_status |=3D ((e->rwflags & 3) << (uint=
ptr_t)e->arg);
+                    uintptr_t shift;
+
+                    if (e->arg >=3D MULTI_N)
+                    {
+                        struct event_arg *ev_arg =3D (struct event_arg *)e=
->arg;
+                        if (ev_arg->type !=3D EVENT_ARG_LINK_SOCKET)
+                        {
+                            c->c2.event_set_status =3D ES_ERROR;
+                            msg(D_LINK_ERRORS,
+                                "io_work: non socket event delivered");
+                            return;
+                        }
+
+                        shift =3D socket_shift;
+                    }
+                    else
+                    {
+                        shift =3D (uintptr_t)e->arg;
+                    }
+
+                    c->c2.event_set_status |=3D ((e->rwflags & 3) << shift=
);
                 }
             }
             else if (status =3D=3D 0)
diff --git a/src/openvpn/mtcp.c b/src/openvpn/mtcp.c
index 28f6e8e..a2841f0 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -60,7 +60,13 @@
 #define MTCP_FILE_CLOSE_WRITE ((void *)5)
 #define MTCP_DCO        ((void *)6)

-#define MTCP_N           ((void *)16) /* upper bound on MTCP_x */
+struct ta_iow_flags
+{
+    unsigned int flags;
+    unsigned int ret;
+    unsigned int tun;
+    unsigned int sock;
+};

 #ifdef ENABLE_DEBUG
 static const char *
@@ -686,7 +692,7 @@
         struct event_set_return *e =3D &mtcp->esr[i];

         /* incoming data for instance or listening socket? */
-        if (e->arg >=3D MTCP_N)
+        if (e->arg >=3D MULTI_N)
         {
             struct event_arg *ev_arg =3D (struct event_arg *)e->arg;
             switch (ev_arg->type)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/760?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I7ebf0d4fb2a23278e16003b2e35598178155d658
Gerrit-Change-Number: 760
Gerrit-PatchSet: 7
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-MessageType: merged

--sUM0F7W6KOg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/760?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">io_work: pass event_arg object to event handle=
r in case of socket event<br><br>In order to allow the code to work with mu=
ltiple listening sockets<br>it is essential to allow the generic multi_io e=
vent handler<br>to distinguish between the various socket objects.<br><br>T=
his can be achieved by passing an event_arg object that contains<br>a point=
er to the link_socket.<br><br>This code path is used on clients as well as =
UDP servers.<br><br>Change-Id: I7ebf0d4fb2a23278e16003b2e35598178155d658<br=
>Signed-off-by: Antonio Quartulli &lt;a@...2181...&gt;<br>Signed-off-by: Gi=
anmarco De Gregori &lt;gianmarco@...2726...&gt;<br>Message-Id: &lt;20241023=
142030.731-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg29625.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/event.h<br>M src/openvpn/f=
orward.c<br>M src/openvpn/mtcp.c<br>3 files changed, 37 insertions(+), 4 de=
letions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span>i=
ndex b3ba183..c212e07 100644</span><br><span>--- a/src/openvpn/event.h</spa=
n><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ -82,6 +82,12 @@</s=
pan><br><span> #define EVENT_METHOD_US_TIMEOUT   (1&lt;&lt;0)</span><br><sp=
an> #define EVENT_METHOD_FAST         (1&lt;&lt;1)</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * The following constant is used as boun=
dary between integer value</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * and real addresses when passing arguments to event handlers as (v=
oid *)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define MULTI_N           ((v=
oid *)16) /* upper bound on MTCP_x */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><br><span> </span><=
br><span> typedef const struct rw_handle *event_t;</span><br><span>diff --g=
it a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index 66=
e5be1..d50b24c 100644</span><br><span>--- a/src/openvpn/forward.c</span><br=
><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2183,7 +2183,8 @@</s=
pan><br><span>     /*</span><br><span>      * Configure event wait based on=
 socket, tuntap flags.</span><br><span>      */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    socket_set(c-&gt;c2.link_socket, c-&gt;c2.eve=
nt_set, socket, (void *)socket_shift, NULL);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    socket_set(c-&gt;c2.link_socket, c-&gt;c2.even=
t_set, socket,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
          &amp;c-&gt;c2.link_socket-&gt;ev_arg, NULL);</span><br><span>    =
 tun_set(c-&gt;c1.tuntap, c-&gt;c2.event_set, tuntap, (void *)tun_shift, NU=
LL);</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)<=
/span><br><span>     if (socket &amp; EVENT_READ &amp;&amp; c-&gt;c2.did_op=
en_tun)</span><br><span>@@ -2246,7 +2247,27 @@</span><br><span>            =
     for (i =3D 0; i &lt; status; ++i)</span><br><span>                 {</=
span><br><span>                     const struct event_set_return *e =3D &a=
mp;esr[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-           =
         c-&gt;c2.event_set_status |=3D ((e-&gt;rwflags &amp; 3) &lt;&lt; (=
uintptr_t)e-&gt;arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                    uintptr_t shift;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                    if (e-&gt;arg &gt;=3D MULTI_N)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        struct event_arg =
*ev_arg =3D (struct event_arg *)e-&gt;arg;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+                        if (ev_arg-&gt;type !=3D EVE=
NT_ARG_LINK_SOCKET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
                        {</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                            c-&gt;c2.event_set_status =3D ES_ERROR;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+                     =
       msg(D_LINK_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+                                &quot;io_work: non socket event deliv=
ered&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
                     return;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+                        }</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    shift =3D socket_shift;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                    }</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+                    else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+                    {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                        shift =3D (uintpt=
r_t)e-&gt;arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
               }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    c-=
&gt;c2.event_set_status |=3D ((e-&gt;rwflags &amp; 3) &lt;&lt; shift);</spa=
n><br><span>                 }</span><br><span>             }</span><br><sp=
an>             else if (status =3D=3D 0)</span><br><span>diff --git a/src/=
openvpn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 28f6e8e..a2841f0 =
100644</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/o=
penvpn/mtcp.c</span><br><span>@@ -60,7 +60,13 @@</span><br><span> #define M=
TCP_FILE_CLOSE_WRITE ((void *)5)</span><br><span> #define MTCP_DCO        (=
(void *)6)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#define MTCP_N           ((void *)16) /* upper bound on MTCP_x */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+struct ta_iow_flags</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    unsigned int ret;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    unsigned int tun;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    unsigned int sock;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span> </span><b=
r><span> #ifdef ENABLE_DEBUG</span><br><span> static const char *</span><br=
><span>@@ -686,7 +692,7 @@</span><br><span>         struct event_set_return=
 *e =3D &amp;mtcp-&gt;esr[i];</span><br><span> </span><br><span>         /*=
 incoming data for instance or listening socket? */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        if (e-&gt;arg &gt;=3D MTCP_N)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (e-&gt;arg &gt=
;=3D MULTI_N)</span><br><span>         {</span><br><span>             struc=
t event_arg *ev_arg =3D (struct event_arg *)e-&gt;arg;</span><br><span>    =
         switch (ev_arg-&gt;type)</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/760?usp=3Demail"=
>change 760</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/760?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I7ebf0d4fb2a23278e16003b2e35=
598178155d658 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 760 </div>
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


--sUM0F7W6KOg=--

