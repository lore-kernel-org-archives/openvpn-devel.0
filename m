From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 23 Oct 2024 14:19:25 +0000
In-Reply-To: <gerrit.1727098847000.Ib583bf17e35b14aed78fd8217b6e71e8c2b78089@...2715...>
References: <gerrit.1727098847000.Ib583bf17e35b14aed78fd8217b6e71e8c2b78089@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 gianmarco@...2726..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., a@...2181...
Message-ID: <f833bf5f35de98d79627d25b8c60641e49352bbd-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BPyQpJoNn4c="; charset=UTF-8
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
To: its_Giaan <gianmarco@...2726...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--BPyQpJoNn4c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#7) to the change originally created by=
 its_Giaan. ( http://gerrit.openvpn.net/c/openvpn/+/759?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


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
Signed-off-by: Gianmarco De Gregori <gianmarco@...2726...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20241023084208.12317-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
604.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/forward.c
1 file changed, 14 insertions(+), 16 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/759/7

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
=20
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
Gerrit-PatchSet: 7
Gerrit-Owner: its_Giaan <gianmarco@...2726...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--BPyQpJoNn4c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #7</strong> to the change originally cr=
eated by its_Giaan.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
759?usp=3Demail">View Change</a></p><p>The following approvals got outdated=
 and were removed:
Code-Review+2 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">io_work: convert shift argument to uintptr_t<=
br><br>Instead of passing the shift argument as pointer, pass<br>directly i=
ts integer value. This will allow the code to<br>distinguish a shift value =
from a real object pointer,<br>like we already do in multi_tcp_process_io()=
.<br><br>This change will allow us later to pass an event_arg<br>object as =
event handler argument instead of a simple<br>integer value.<br><br>Change-=
Id: Ib583bf17e35b14aed78fd8217b6e71e8c2b78089<br>Signed-off-by: Antonio Qua=
rtulli &lt;a@...2181...&gt;<br>Signed-off-by: Gianmarco De Gregori &lt;gian=
marco@...2726...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>Message-Id: &lt;20241023084208.12317-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29604.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/ope=
nvpn/forward.c<br>1 file changed, 14 insertions(+), 16 deletions(-)<br><br>=
</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap=
;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/759/7</p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
<span>diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c</span><br>=
<span>index 6f279ec..66e5be1 100644</span><br><span>--- a/src/openvpn/forwa=
rd.c</span><br><span>+++ b/src/openvpn/forward.c</span><br><span>@@ -2065,2=
0 +2065,18 @@</span><br><span>     unsigned int tuntap =3D 0;</span><br><sp=
an>     struct event_set_return esr[4];</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    /* These shifts all depend on EVENT=
_READ (=3D1) and EVENT_WRITE (=3D2)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-     * and are added to the shift. Check openvpn.h for more d=
etails.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    static int socket_shift =
=3D SOCKET_SHIFT;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
static int tun_shift =3D TUN_SHIFT;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    static int err_shift =3D ERR_SHIFT;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* These shifts all depend on EVENT_R=
EAD and EVENT_WRITE */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    static uintptr_t socket_shift =3D SOCKET_SHIFT;   /* depends on SOCK=
ET_READ and SOCKET_WRITE */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    static uintptr_t tun_shift =3D TUN_SHIFT;      /* depends on TU=
N_READ and TUN_WRITE */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    static uintptr_t err_shift =3D ERR_SHIFT;      /* depends on ES_ERR=
OR */</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    static int management_shift =3D MANAGEMENT_SH=
IFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    static uint=
ptr_t management_shift =3D MANAGEMENT_SHIFT; /* depends on MANAGEMENT_READ =
and MANAGEMENT_WRITE */</span><br><span> #endif</span><br><span> #ifdef ENA=
BLE_ASYNC_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sta=
tic int file_shift =3D FILE_SHIFT;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    static uintptr_t file_shift =3D FILE_SHIFT;</span><br><s=
pan> #endif</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FR=
EEBSD)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static int =
dco_shift =3D DCO_SHIFT;    /* Event from DCO linux kernel module */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t dco_s=
hift =3D DCO_SHIFT;    /* Event from DCO linux kernel module */</span><br><=
span> #endif</span><br><span> </span><br><span>     /*</span><br><span>@@ -=
2092,7 +2090,7 @@</span><br><span>      */</span><br><span>     if (flags &=
amp; IOW_WAIT_SIGNAL)</span><br><span>     {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-        wait_signal(c-&gt;c2.event_set, (void *)&amp=
;err_shift);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 wait_signal(c-&gt;c2.event_set, (void *)err_shift);</span><br><span>     }=
</span><br><span> </span><br><span>     /*</span><br><span>@@ -2185,19 +218=
3,19 @@</span><br><span>     /*</span><br><span>      * Configure event wai=
t based on socket, tuntap flags.</span><br><span>      */</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    socket_set(c-&gt;c2.link_socket, c-=
&gt;c2.event_set, socket, (void *)&amp;socket_shift, NULL);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    tun_set(c-&gt;c1.tuntap, c-&gt;c2=
.event_set, tuntap, (void *)&amp;tun_shift, NULL);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    socket_set(c-&gt;c2.link_socket, c-&gt;c=
2.event_set, socket, (void *)socket_shift, NULL);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    tun_set(c-&gt;c1.tuntap, c-&gt;c2.event_s=
et, tuntap, (void *)tun_shift, NULL);</span><br><span> #if defined(TARGET_L=
INUX) || defined(TARGET_FREEBSD)</span><br><span>     if (socket &amp; EVEN=
T_READ &amp;&amp; c-&gt;c2.did_open_tun)</span><br><span>     {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        dco_event_set(&amp;c-&gt;=
c1.tuntap-&gt;dco, c-&gt;c2.event_set, (void *)&amp;dco_shift);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        dco_event_set(&amp;c-&g=
t;c1.tuntap-&gt;dco, c-&gt;c2.event_set, (void *)dco_shift);</span><br><spa=
n>     }</span><br><span> #endif</span><br><span> </span><br><span> #ifdef =
ENABLE_MANAGEMENT</span><br><span>     if (management)</span><br><span>    =
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        management_=
socket_set(management, c-&gt;c2.event_set, (void *)&amp;management_shift, N=
ULL);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        manage=
ment_socket_set(management, c-&gt;c2.event_set, (void *)management_shift, N=
ULL);</span><br><span>     }</span><br><span> #endif</span><br><span> </spa=
n><br><span>@@ -2205,7 +2203,7 @@</span><br><span>     /* arm inotify watch=
er */</span><br><span>     if (c-&gt;options.mode =3D=3D MODE_SERVER)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    event_ctl(c-&gt;c2.event_set, c-&gt;c2.inotify_fd, EVENT_READ, (void *)=
&amp;file_shift);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      event_ctl(c-&gt;c2.event_set, c-&gt;c2.inotify_fd, EVENT_READ, (void =
*)file_shift);</span><br><span>     }</span><br><span> #endif</span><br><sp=
an> </span><br><span>@@ -2248,7 +2246,7 @@</span><br><span>                =
 for (i =3D 0; i &lt; status; ++i)</span><br><span>                 {</span=
><br><span>                     const struct event_set_return *e =3D &amp;e=
sr[i];</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
     c-&gt;c2.event_set_status |=3D ((e-&gt;rwflags &amp; 3) &lt;&lt; *((in=
t *)e-&gt;arg));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
                 c-&gt;c2.event_set_status |=3D ((e-&gt;rwflags &amp; 3) &l=
t;&lt; (uintptr_t)e-&gt;arg);</span><br><span>                 }</span><br>=
<span>             }</span><br><span>             else if (status =3D=3D 0)=
</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerri=
t.openvpn.net/c/openvpn/+/759?usp=3Demail">change 759</a>. To unsubscribe, =
or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.ne=
t/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/E=
mailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.o=
rg/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/759?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib583bf17e35b14aed78fd8217b6=
e71e8c2b78089 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 759 </div>
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--BPyQpJoNn4c=--

