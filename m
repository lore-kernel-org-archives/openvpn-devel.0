From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Wed, 22 Apr 2026 08:26:55 +0000
In-Reply-To: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@...2715...>
References: <gerrit.1776783100000.I6b303805a3688b6f6363140c76853a58badecd8f@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, antonio@...2726...
Message-ID: <e17bd00f4a650fd8490ab3641f292a502170099c-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="M1fOWKbBl9U="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Multisocket: use
 event engine rwflags for UDP I/O
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--M1fOWKbBl9U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: ordex, plaisthos.

Hello ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1635?usp=3Demail

to look at the new patch set (#3).


Change subject: Multisocket: use event engine rwflags for UDP I/O
......................................................................

Multisocket: use event engine rwflags for UDP I/O

udp_flags does not guarantee correct association with the socket being
processed. Use the rwflags delivered by the event engine along with the
event to ensure proper per-socket I/O handling.

Remove udp_flags entirely.

This change is based on an investigation triggered by a report from
Joshua Rogers using ZeroPath.

Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
---
M src/openvpn/forward.c
M src/openvpn/mudp.c
M src/openvpn/mudp.h
M src/openvpn/multi_io.c
M src/openvpn/multi_io.h
5 files changed, 8 insertions(+), 28 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/35/1635/3

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 27cfd36..36597db 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2029,8 +2029,7 @@
 }

 static void
-multi_io_process_flags(struct context *c, struct event_set *es, const unsi=
gned int flags,
-                       unsigned int *out_socket, unsigned int *out_tuntap)
+multi_io_process_flags(struct context *c, struct event_set *es, const unsi=
gned int flags)
 {
     unsigned int socket =3D 0;
     unsigned int tuntap =3D 0;
@@ -2130,16 +2129,6 @@
     }

     tun_set(c->c1.tuntap, es, tuntap, (void *)tun_shift, NULL);
-
-    if (out_socket)
-    {
-        *out_socket =3D socket;
-    }
-
-    if (out_tuntap)
-    {
-        *out_tuntap =3D tuntap;
-    }
 }

 /*
@@ -2150,10 +2139,7 @@
 void
 get_io_flags_udp(struct context *c, struct multi_io *multi_io, const unsig=
ned int flags)
 {
-    unsigned int out_socket;
-
-    multi_io_process_flags(c, multi_io->es, flags, &out_socket, NULL);
-    multi_io->udp_flags =3D (out_socket << SOCKET_SHIFT);
+    multi_io_process_flags(c, multi_io->es, flags);
 }

 /*
@@ -2163,8 +2149,6 @@
 void
 io_wait(struct context *c, const unsigned int flags)
 {
-    unsigned int out_socket;
-    unsigned int out_tuntap;
     struct event_set_return esr[4];

     /* These shifts all depend on EVENT_READ and EVENT_WRITE */
@@ -2183,7 +2167,7 @@
      */
     event_reset(c->c2.event_set);

-    multi_io_process_flags(c, c->c2.event_set, flags, &out_socket, &out_tu=
ntap);
+    multi_io_process_flags(c, c->c2.event_set, flags);

 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (c->c1.tuntap)
diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp.c
index 432c79a..beec57a 100644
--- a/src/openvpn/mudp.c
+++ b/src/openvpn/mudp.c
@@ -336,18 +336,17 @@
  * Process a UDP socket event.
  */
 void
-multi_process_io_udp(struct multi_context *m, struct link_socket *sock)
+multi_process_io_udp(struct multi_context *m, struct link_socket *sock, un=
signed int rwflags)
 {
-    const unsigned int status =3D m->multi_io->udp_flags;
     const unsigned int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOSE_ON_SIGNAL=
);

     /* UDP port ready to accept write */
-    if (status & SOCKET_WRITE)
+    if (rwflags & SOCKET_WRITE)
     {
         multi_process_outgoing_link(m, mpp_flags);
     }
     /* Incoming data on UDP port */
-    else if (status & SOCKET_READ)
+    else if (rwflags & SOCKET_READ)
     {
         read_incoming_link(&m->top, sock);
         if (!IS_SIG(&m->top))
@@ -355,8 +354,6 @@
             multi_process_incoming_link(m, NULL, mpp_flags, sock);
         }
     }
-
-    m->multi_io->udp_flags =3D ES_ERROR;
 }

 /*
diff --git a/src/openvpn/mudp.h b/src/openvpn/mudp.h
index 005ee10..1417651 100644
--- a/src/openvpn/mudp.h
+++ b/src/openvpn/mudp.h
@@ -32,7 +32,7 @@

 unsigned int p2mp_iow_flags(const struct multi_context *m);

-void multi_process_io_udp(struct multi_context *m, struct link_socket *soc=
k);
+void multi_process_io_udp(struct multi_context *m, struct link_socket *soc=
k, unsigned int rwflags);
 /*************************************************************************=
*/
 /**
  * Get, and if necessary create, the multi_instance associated with a
diff --git a/src/openvpn/multi_io.c b/src/openvpn/multi_io.c
index e6f4e9c..f9af800 100644
--- a/src/openvpn/multi_io.c
+++ b/src/openvpn/multi_io.c
@@ -457,7 +457,7 @@
                     }
                     else
                     {
-                        multi_process_io_udp(m, ev_arg->u.sock);
+                        multi_process_io_udp(m, ev_arg->u.sock, e->rwflags=
);
                         mi =3D m->pending;
                     }
                     /* monitor and/or handle events that are
diff --git a/src/openvpn/multi_io.h b/src/openvpn/multi_io.h
index 6b2f59a..d6734bd 100644
--- a/src/openvpn/multi_io.h
+++ b/src/openvpn/multi_io.h
@@ -55,7 +55,6 @@
     int n_esr;
     int maxevents;
     unsigned int tun_rwflags;
-    unsigned int udp_flags;
 #ifdef ENABLE_MANAGEMENT
     unsigned int management_persist_flags;
 #endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1635?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6b303805a3688b6f6363140c76853a58badecd8f
Gerrit-Change-Number: 1635
Gerrit-PatchSet: 3
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: ordex <antonio@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: ordex <antonio@...2726...>

--M1fOWKbBl9U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: ordex, plaisthos. </p>
<p>its_Giaan <strong>uploaded patch set #3</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1635?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Multisocket: use event engine rwflags for UDP I/O<b=
r><br>udp_flags does not guarantee correct association with the socket bein=
g<br>processed. Use the rwflags delivered by the event engine along with th=
e<br>event to ensure proper per-socket I/O handling.<br><br>Remove udp_flag=
s entirely.<br><br>This change is based on an investigation triggered by a =
report from<br>Joshua Rogers using ZeroPath.<br><br>Change-Id: I6b303805a36=
88b6f6363140c76853a58badecd8f<br>Signed-off-by: Gianmarco De Gregori &lt;gi=
anmarco@...2726...&gt;<br>---<br>M src/openvpn/forward.c<br>M src/openvpn/m=
udp.c<br>M src/openvpn/mudp.h<br>M src/openvpn/multi_io.c<br>M src/openvpn/=
multi_io.h<br>5 files changed, 8 insertions(+), 28 deletions(-)<br><br></pr=
e><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-sp=
ace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/change=
s/35/1635/3</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openvpn/forwar=
d.c</span><br><span>index 27cfd36..36597db 100644</span><br><span>--- a/src=
/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><s=
pan>@@ -2029,8 +2029,7 @@</span><br><span> }</span><br><span> </span><br><s=
pan> static void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-multi=
_io_process_flags(struct context *c, struct event_set *es, const unsigned i=
nt flags,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
           unsigned int *out_socket, unsigned int *out_tuntap)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+multi_io_process_flags(struct co=
ntext *c, struct event_set *es, const unsigned int flags)</span><br><span> =
{</span><br><span>     unsigned int socket =3D 0;</span><br><span>     unsi=
gned int tuntap =3D 0;</span><br><span>@@ -2130,16 +2129,6 @@</span><br><sp=
an>     }</span><br><span> </span><br><span>     tun_set(c-&gt;c1.tuntap, e=
s, tuntap, (void *)tun_shift, NULL);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if=
 (out_socket)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-        *out_socket =3D =
socket;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    if (out_tuntap)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        *out_tuntap =3D tuntap;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    }</span><br><span> }</span><br><span> </span><br><span>=
 /*</span><br><span>@@ -2150,10 +2139,7 @@</span><br><span> void</span><br>=
<span> get_io_flags_udp(struct context *c, struct multi_io *multi_io, const=
 unsigned int flags)</span><br><span> {</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    unsigned int out_socket;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    multi_io_process_flags(c, multi_io-&gt;es, flags, &amp;out_socket, =
NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io-&g=
t;udp_flags =3D (out_socket &lt;&lt; SOCKET_SHIFT);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    multi_io_process_flags(c, multi_io-&g=
t;es, flags);</span><br><span> }</span><br><span> </span><br><span> /*</spa=
n><br><span>@@ -2163,8 +2149,6 @@</span><br><span> void</span><br><span> io=
_wait(struct context *c, const unsigned int flags)</span><br><span> {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int out_socket=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int out=
_tuntap;</span><br><span>     struct event_set_return esr[4];</span><br><sp=
an> </span><br><span>     /* These shifts all depend on EVENT_READ and EVEN=
T_WRITE */</span><br><span>@@ -2183,7 +2167,7 @@</span><br><span>      */</=
span><br><span>     event_reset(c-&gt;c2.event_set);</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    multi_io_process_flags=
(c, c-&gt;c2.event_set, flags, &amp;out_socket, &amp;out_tuntap);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    multi_io_process_flags(c,=
 c-&gt;c2.event_set, flags);</span><br><span> </span><br><span> #if defined=
(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span>     if (c-&gt;c1=
.tuntap)</span><br><span>diff --git a/src/openvpn/mudp.c b/src/openvpn/mudp=
.c</span><br><span>index 432c79a..beec57a 100644</span><br><span>--- a/src/=
openvpn/mudp.c</span><br><span>+++ b/src/openvpn/mudp.c</span><br><span>@@ =
-336,18 +336,17 @@</span><br><span>  * Process a UDP socket event.</span><b=
r><span>  */</span><br><span> void</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-multi_process_io_udp(struct multi_context *m, struct link_sock=
et *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+multi_proc=
ess_io_udp(struct multi_context *m, struct link_socket *sock, unsigned int =
rwflags)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    const unsigned int status =3D m-&gt;multi_io-&gt;udp_flags;</span=
><br><span>     const unsigned int mpp_flags =3D (MPP_PRE_SELECT | MPP_CLOS=
E_ON_SIGNAL);</span><br><span> </span><br><span>     /* UDP port ready to a=
ccept write */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if =
(status &amp; SOCKET_WRITE)</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (rwflags &amp; SOCKET_WRITE)</span><br><span>     {</span><b=
r><span>         multi_process_outgoing_link(m, mpp_flags);</span><br><span=
>     }</span><br><span>     /* Incoming data on UDP port */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    else if (status &amp; SOCKET_REA=
D)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    else if (rwfl=
ags &amp; SOCKET_READ)</span><br><span>     {</span><br><span>         read=
_incoming_link(&amp;m-&gt;top, sock);</span><br><span>         if (!IS_SIG(=
&amp;m-&gt;top))</span><br><span>@@ -355,8 +354,6 @@</span><br><span>      =
       multi_process_incoming_link(m, NULL, mpp_flags, sock);</span><br><sp=
an>         }</span><br><span>     }</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    m-=
&gt;multi_io-&gt;udp_flags =3D ES_ERROR;</span><br><span> }</span><br><span=
> </span><br><span> /*</span><br><span>diff --git a/src/openvpn/mudp.h b/sr=
c/openvpn/mudp.h</span><br><span>index 005ee10..1417651 100644</span><br><s=
pan>--- a/src/openvpn/mudp.h</span><br><span>+++ b/src/openvpn/mudp.h</span=
><br><span>@@ -32,7 +32,7 @@</span><br><span> </span><br><span> unsigned in=
t p2mp_iow_flags(const struct multi_context *m);</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-void multi_process_io_udp(stru=
ct multi_context *m, struct link_socket *sock);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+void multi_process_io_udp(struct multi_context =
*m, struct link_socket *sock, unsigned int rwflags);</span><br><span> /****=
**********************************************************************/</sp=
an><br><span> /**</span><br><span>  * Get, and if necessary create, the mul=
ti_instance associated with a</span><br><span>diff --git a/src/openvpn/mult=
i_io.c b/src/openvpn/multi_io.c</span><br><span>index e6f4e9c..f9af800 1006=
44</span><br><span>--- a/src/openvpn/multi_io.c</span><br><span>+++ b/src/o=
penvpn/multi_io.c</span><br><span>@@ -457,7 +457,7 @@</span><br><span>     =
                }</span><br><span>                     else</span><br><span=
>                     {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-                        multi_process_io_udp(m, ev_arg-&gt;u.sock);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                        m=
ulti_process_io_udp(m, ev_arg-&gt;u.sock, e-&gt;rwflags);</span><br><span> =
                        mi =3D m-&gt;pending;</span><br><span>             =
        }</span><br><span>                     /* monitor and/or handle eve=
nts that are</span><br><span>diff --git a/src/openvpn/multi_io.h b/src/open=
vpn/multi_io.h</span><br><span>index 6b2f59a..d6734bd 100644</span><br><spa=
n>--- a/src/openvpn/multi_io.h</span><br><span>+++ b/src/openvpn/multi_io.h=
</span><br><span>@@ -55,7 +55,6 @@</span><br><span>     int n_esr;</span><b=
r><span>     int maxevents;</span><br><span>     unsigned int tun_rwflags;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    unsigned int udp_f=
lags;</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     unsign=
ed int management_persist_flags;</span><br><span> #endif</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1635?usp=3Demail">change 1635</a>. To unsubscribe, or for help writi=
ng mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3D=
email">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailM=
essage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vi=
ewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/1635?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></d=
iv></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6b303805a3688b6f6363140c768=
53a58badecd8f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1635 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: ordex &lt;antonio@...2726...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: ordex &lt;antonio@...2726...=
&gt; </div>

</body></html>=

--M1fOWKbBl9U=--

