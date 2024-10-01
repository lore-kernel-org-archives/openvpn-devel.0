From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Tue, 1 Oct 2024 15:30:04 +0000
In-Reply-To: <gerrit.1727098847000.Ib583bf17e35b14aed78fd8217b6e71e8c2b78089@...2715...>
References: <gerrit.1727098847000.Ib583bf17e35b14aed78fd8217b6e71e8c2b78089@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <f6259904dfc79105a6ed0df12f4ae91b953633e1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8Un4wlmIOho="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: io_work: convert
 shift argument to uintptr_t
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

--8Un4wlmIOho=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, its_Giaan, plaisthos.

Hello flichtenheld, ordex, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/759?usp=3Demail

to look at the new patch set (#2).


Change subject: io_work: convert shift argument to uintptr_t
......................................................................

io_work: convert shift argument to uintptr_t

Instead of passing the shift argument as pointer, pass
directly its integer value. This will allow the code to
distinguish a shift value from a real object pointer,
like we already do in multi_tcp_process_io().

This change will allow us later to pass an event_arg
object as event handler argument instead of a simple
integer value.

Change-Id: Ib583bf17e35b14aed78fd8217b6e71e8c2b78089
Signed-off-by: Antonio Quartulli <a@...2181...>
---
M src/openvpn/forward.c
1 file changed, 14 insertions(+), 16 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/759/2

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 6f279ec..66e5be1 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2065,20 +2065,18 @@
     unsigned int tuntap =3D 0;
     struct event_set_return esr[4];

-    /* These shifts all depend on EVENT_READ (=3D1) and EVENT_WRITE (=3D2)
-     * and are added to the shift. Check openvpn.h for more details.
-     */
-    static int socket_shift =3D SOCKET_SHIFT;
-    static int tun_shift =3D TUN_SHIFT;
-    static int err_shift =3D ERR_SHIFT;
+    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
+    static uintptr_t socket_shift =3D SOCKET_SHIFT;   /* depends on SOCKET=
_READ and SOCKET_WRITE */
+    static uintptr_t tun_shift =3D TUN_SHIFT;      /* depends on TUN_READ =
and TUN_WRITE */
+    static uintptr_t err_shift =3D ERR_SHIFT;      /* depends on ES_ERROR =
*/
 #ifdef ENABLE_MANAGEMENT
-    static int management_shift =3D MANAGEMENT_SHIFT;
+    static uintptr_t management_shift =3D MANAGEMENT_SHIFT; /* depends on =
MANAGEMENT_READ and MANAGEMENT_WRITE */
 #endif
 #ifdef ENABLE_ASYNC_PUSH
-    static int file_shift =3D FILE_SHIFT;
+    static uintptr_t file_shift =3D FILE_SHIFT;
 #endif
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
-    static int dco_shift =3D DCO_SHIFT;    /* Event from DCO linux kernel =
module */
+    static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from DCO linux k=
ernel module */
 #endif

     /*
@@ -2092,7 +2090,7 @@
      */
     if (flags & IOW_WAIT_SIGNAL)
     {
-        wait_signal(c->c2.event_set, (void *)&err_shift);
+        wait_signal(c->c2.event_set, (void *)err_shift);
     }

     /*
@@ -2185,19 +2183,19 @@
     /*
      * Configure event wait based on socket, tuntap flags.
      */
-    socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)&socket=
_shift, NULL);
-    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NUL=
L);
+    socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)socket_=
shift, NULL);
+    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL=
);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
     {
-        dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)&dco_sh=
ift);
+        dco_event_set(&c->c1.tuntap->dco, c->c2.event_set, (void *)dco_shi=
ft);
     }
 #endif

 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_socket_set(management, c->c2.event_set, (void *)&manage=
ment_shift, NULL);
+        management_socket_set(management, c->c2.event_set, (void *)managem=
ent_shift, NULL);
     }
 #endif

@@ -2205,7 +2203,7 @@
     /* arm inotify watcher */
     if (c->options.mode =3D=3D MODE_SERVER)
     {
-        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)&=
file_shift);
+        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)f=
ile_shift);
     }
 #endif

@@ -2248,7 +2246,7 @@
                 for (i =3D 0; i < status; ++i)
                 {
                     const struct event_set_return *e =3D &esr[i];
-                    c->c2.event_set_status |=3D ((e->rwflags & 3) << *((in=
t *)e->arg));
+                    c->c2.event_set_status |=3D ((e->rwflags & 3) << (uint=
ptr_t)e->arg);
                 }
             }
             else if (status =3D=3D 0)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/759?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib583bf17e35b14aed78fd8217b6e71e8c2b78089
Gerrit-Change-Number: 759
Gerrit-PatchSet: 2
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: its_Giaan <gianmarco@...2726...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--8Un4wlmIOho=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, its_Giaan, plaistho=
s. </p>
<p>its_Giaan <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/759?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">io_work: convert shift argument to uintptr_t<br><br>Instead of passin=
g the shift argument as pointer, pass<br>directly its integer value. This w=
ill allow the code to<br>distinguish a shift value from a real object point=
er,<br>like we already do in multi_tcp_process_io().<br><br>This change wil=
l allow us later to pass an event_arg<br>object as event handler argument i=
nstead of a simple<br>integer value.<br><br>Change-Id: Ib583bf17e35b14aed78=
fd8217b6e71e8c2b78089<br>Signed-off-by: Antonio Quartulli &lt;a@...2181...&=
gt;<br>---<br>M src/openvpn/forward.c<br>1 file changed, 14 insertions(+), =
16 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/59/759/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/src/openv=
pn/forward.c</span><br><span>index 6f279ec..66e5be1 100644</span><br><span>=
--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forward.c</sp=
an><br><span>@@ -2065,20 +2065,18 @@</span><br><span>     unsigned int tunt=
ap =3D 0;</span><br><span>     struct event_set_return esr[4];</span><br><s=
pan> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* These shi=
fts all depend on EVENT_READ (=3D1) and EVENT_WRITE (=3D2)</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-     * and are added to the shift. Che=
ck openvpn.h for more details.</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
tatic int socket_shift =3D SOCKET_SHIFT;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    static int tun_shift =3D TUN_SHIFT;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    static int err_shift =3D ERR_SHIFT=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* These shift=
s all depend on EVENT_READ and EVENT_WRITE */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    static uintptr_t socket_shift =3D SOCKET_SHIF=
T;   /* depends on SOCKET_READ and SOCKET_WRITE */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    static uintptr_t tun_shift =3D TUN_SHIFT=
;      /* depends on TUN_READ and TUN_WRITE */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    static uintptr_t err_shift =3D ERR_SHIFT;   =
   /* depends on ES_ERROR */</span><br><span> #ifdef ENABLE_MANAGEMENT</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    static int management_=
shift =3D MANAGEMENT_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    static uintptr_t management_shift =3D MANAGEMENT_SHIFT; /* depe=
nds on MANAGEMENT_READ and MANAGEMENT_WRITE */</span><br><span> #endif</spa=
n><br><span> #ifdef ENABLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    static int file_shift =3D FILE_SHIFT;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t file_shift =3D F=
ILE_SHIFT;</span><br><span> #endif</span><br><span> #if defined(TARGET_LINU=
X) || defined(TARGET_FREEBSD)</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    static int dco_shift =3D DCO_SHIFT;    /* Event from DCO linux =
kernel module */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 static uintptr_t dco_shift =3D DCO_SHIFT;    /* Event from DCO linux kerne=
l module */</span><br><span> #endif</span><br><span> </span><br><span>     =
/*</span><br><span>@@ -2092,7 +2090,7 @@</span><br><span>      */</span><br=
><span>     if (flags &amp; IOW_WAIT_SIGNAL)</span><br><span>     {</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        wait_signal(c-&gt;c2.=
event_set, (void *)&amp;err_shift);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+        wait_signal(c-&gt;c2.event_set, (void *)err_shift);=
</span><br><span>     }</span><br><span> </span><br><span>     /*</span><br=
><span>@@ -2185,19 +2183,19 @@</span><br><span>     /*</span><br><span>    =
  * Configure event wait based on socket, tuntap flags.</span><br><span>   =
   */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    socket_set(c=
-&gt;c2.link_socket, c-&gt;c2.event_set, socket, (void *)&amp;socket_shift,=
 NULL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    tun_set(c-=
&gt;c1.tuntap, c-&gt;c2.event_set, tuntap, (void *)&amp;tun_shift, NULL);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_set(c-&gt;=
c2.link_socket, c-&gt;c2.event_set, socket, (void *)socket_shift, NULL);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    tun_set(c-&gt;c1.t=
untap, c-&gt;c2.event_set, tuntap, (void *)tun_shift, NULL);</span><br><spa=
n> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</span><br><span>   =
  if (socket &amp; EVENT_READ &amp;&amp; c-&gt;c2.did_open_tun)</span><br><=
span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        dc=
o_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;c2.event_set, (void *)&amp;=
dco_shift);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
dco_event_set(&amp;c-&gt;c1.tuntap-&gt;dco, c-&gt;c2.event_set, (void *)dco=
_shift);</span><br><span>     }</span><br><span> #endif</span><br><span> </=
span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span>     if (managemen=
t)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        management_socket_set(management, c-&gt;c2.event_set, (void *)&=
amp;management_shift, NULL);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        management_socket_set(management, c-&gt;c2.event_set, (voi=
d *)management_shift, NULL);</span><br><span>     }</span><br><span> #endif=
</span><br><span> </span><br><span>@@ -2205,7 +2203,7 @@</span><br><span>  =
   /* arm inotify watcher */</span><br><span>     if (c-&gt;options.mode =
=3D=3D MODE_SERVER)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        event_ctl(c-&gt;c2.event_set, c-&gt;c2.inotify=
_fd, EVENT_READ, (void *)&amp;file_shift);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+        event_ctl(c-&gt;c2.event_set, c-&gt;c2.inoti=
fy_fd, EVENT_READ, (void *)file_shift);</span><br><span>     }</span><br><s=
pan> #endif</span><br><span> </span><br><span>@@ -2248,7 +2246,7 @@</span><=
br><span>                 for (i =3D 0; i &lt; status; ++i)</span><br><span=
>                 {</span><br><span>                     const struct event=
_set_return *e =3D &amp;esr[i];</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-                    c-&gt;c2.event_set_status |=3D ((e-&gt;rwflag=
s &amp; 3) &lt;&lt; *((int *)e-&gt;arg));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                    c-&gt;c2.event_set_status |=3D ((=
e-&gt;rwflags &amp; 3) &lt;&lt; (uintptr_t)e-&gt;arg);</span><br><span>    =
             }</span><br><span>             }</span><br><span>             =
else if (status =3D=3D 0)</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/759?usp=3Demail">change =
759</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemty=
pe=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" it=
emtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/759?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib583bf17e35b14aed78fd8217b6=
e71e8c2b78089 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 759 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: its_Giaan &lt;gianmarco@...2786...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: its_Giaan &lt;gianmarco@...1665...=
726...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--8Un4wlmIOho=--

