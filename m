From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Thu, 17 Oct 2024 14:47:28 +0000
In-Reply-To: <gerrit.1727098847000.I7ebf0d4fb2a23278e16003b2e35598178155d658@...2715...>
References: <gerrit.1727098847000.I7ebf0d4fb2a23278e16003b2e35598178155d658@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <bc4bbaaae9c3fa8aafd558a87a2f515e5852d5b9-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mIONH9Q2MB8="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mIONH9Q2MB8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, ordex, plais=
thos.

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/760?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


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
---
M src/openvpn/event.h
M src/openvpn/forward.c
M src/openvpn/mtcp.c
3 files changed, 30 insertions(+), 5 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/760/5

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
index 1b956f4..e89ddba 100644
--- a/src/openvpn/mtcp.c
+++ b/src/openvpn/mtcp.c
@@ -60,8 +60,6 @@
 #define MTCP_FILE_CLOSE_WRITE ((void *)5)
 #define MTCP_DCO        ((void *)6)

-#define MTCP_N           ((void *)16) /* upper bound on MTCP_x */
-
 struct ta_iow_flags
 {
     unsigned int flags;
@@ -693,7 +691,7 @@
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

--mIONH9Q2MB8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, ordex, p=
laisthos. </p>
<p>its_Giaan <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/760?usp=3Demail">View Chang=
e</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><p>The change is no longer submittable: Co=
de-Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D=
"font-family: monospace,monospace; white-space: pre-wrap;">io_work: pass ev=
ent_arg object to event handler in case of socket event<br><br>In order to =
allow the code to work with multiple listening sockets<br>it is essential t=
o allow the generic multi_io event handler<br>to distinguish between the va=
rious socket objects.<br><br>This can be achieved by passing an event_arg o=
bject that contains<br>a pointer to the link_socket.<br><br>This code path =
is used on clients as well as UDP servers.<br><br>Change-Id: I7ebf0d4fb2a23=
278e16003b2e35598178155d658<br>Signed-off-by: Antonio Quartulli &lt;a@...2267...=
81...&gt;<br>Signed-off-by: Gianmarco De Gregori &lt;gianmarco@...2726...&g=
t;<br>---<br>M src/openvpn/event.h<br>M src/openvpn/forward.c<br>M src/open=
vpn/mtcp.c<br>3 files changed, 30 insertions(+), 5 deletions(-)<br><br></pr=
e><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/60/760/5</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/src/openvpn/event.h b/src/openvpn/event.h</span><br><span>in=
dex b3ba183..c212e07 100644</span><br><span>--- a/src/openvpn/event.h</span=
><br><span>+++ b/src/openvpn/event.h</span><br><span>@@ -82,6 +82,12 @@</sp=
an><br><span> #define EVENT_METHOD_US_TIMEOUT   (1&lt;&lt;0)</span><br><spa=
n> #define EVENT_METHOD_FAST         (1&lt;&lt;1)</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * The following constant is used as boundar=
y between integer value</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * and real addresses when passing arguments to event handlers as (void=
 *)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#define MULTI_N           ((void=
 *)16) /* upper bound on MTCP_x */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> #ifdef _WIN32</span><br><span> </span><br>=
<span> typedef const struct rw_handle *event_t;</span><br><span>diff --git =
a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br><span>index 66e5b=
e1..d50b24c 100644</span><br><span>--- a/src/openvpn/forward.c</span><br><s=
pan>+++ b/src/openvpn/forward.c</span><br><span>@@ -2183,7 +2183,8 @@</span=
><br><span>     /*</span><br><span>      * Configure event wait based on so=
cket, tuntap flags.</span><br><span>      */</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    socket_set(c-&gt;c2.link_socket, c-&gt;c2.event_=
set, socket, (void *)socket_shift, NULL);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    socket_set(c-&gt;c2.link_socket, c-&gt;c2.event_s=
et, socket,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
       &amp;c-&gt;c2.link_socket-&gt;ev_arg, NULL);</span><br><span>     tu=
n_set(c-&gt;c1.tuntap, c-&gt;c2.event_set, tuntap, (void *)tun_shift, NULL)=
;</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</sp=
an><br><span>     if (socket &amp; EVENT_READ &amp;&amp; c-&gt;c2.did_open_=
tun)</span><br><span>@@ -2246,7 +2247,27 @@</span><br><span>               =
  for (i =3D 0; i &lt; status; ++i)</span><br><span>                 {</spa=
n><br><span>                     const struct event_set_return *e =3D &amp;=
esr[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-              =
      c-&gt;c2.event_set_status |=3D ((e-&gt;rwflags &amp; 3) &lt;&lt; (uin=
tptr_t)e-&gt;arg);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                   uintptr_t shift;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 if (e-&gt;arg &gt;=3D MULTI_N)</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+                        struct event_arg *ev_=
arg =3D (struct event_arg *)e-&gt;arg;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+                        if (ev_arg-&gt;type !=3D EVENT_A=
RG_LINK_SOCKET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
                    {</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                            c-&gt;c2.event_set_status =3D ES_ERROR;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
   msg(D_LINK_ERRORS,</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+                                &quot;io_work: non socket event delivered=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                 return;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+                        }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
                shift =3D socket_shift;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                    }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    else</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+                    {</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                        shift =3D (uintptr_t)e=
-&gt;arg;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
          }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+                    c-&gt;c=
2.event_set_status |=3D ((e-&gt;rwflags &amp; 3) &lt;&lt; shift);</span><br=
><span>                 }</span><br><span>             }</span><br><span>  =
           else if (status =3D=3D 0)</span><br><span>diff --git a/src/openv=
pn/mtcp.c b/src/openvpn/mtcp.c</span><br><span>index 1b956f4..e89ddba 10064=
4</span><br><span>--- a/src/openvpn/mtcp.c</span><br><span>+++ b/src/openvp=
n/mtcp.c</span><br><span>@@ -60,8 +60,6 @@</span><br><span> #define MTCP_FI=
LE_CLOSE_WRITE ((void *)5)</span><br><span> #define MTCP_DCO        ((void =
*)6)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define MTCP_N           ((void *)16) /* upper bound on MTCP_x */</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct ta_io=
w_flags</span><br><span> {</span><br><span>     unsigned int flags;</span><=
br><span>@@ -693,7 +691,7 @@</span><br><span>         struct event_set_retu=
rn *e =3D &amp;mtcp-&gt;esr[i];</span><br><span> </span><br><span>         =
/* incoming data for instance or listening socket? */</span><br><span style=
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


--mIONH9Q2MB8=--

