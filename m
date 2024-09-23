From: "its_Giaan (Code Review)" <gerrit@...515...>
Date: Mon, 23 Sep 2024 13:41:19 +0000
References: <gerrit.1727098847000.Ib583bf17e35b14aed78fd8217b6e71e8c2b78089@...2715...>
Reply-To: gianmarco@...2726..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <21db2574ae6d8f0857e3cfca56b85c0764a45d68-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TsoxkANZvHo="; charset=UTF-8
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

--TsoxkANZvHo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, ordex, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/759?usp=3Demail

to review the following change.


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
1 file changed, 12 insertions(+), 14 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/59/759/1

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 16b4497..1247ba3 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -2050,20 +2050,18 @@
     unsigned int tuntap =3D 0;
     struct event_set_return esr[4];

-    /* These shifts all depend on EVENT_READ (=3D1) and EVENT_WRITE (=3D2)
-     * and are added to the shift. Check openvpn.h for more details.
-     */
-    static int socket_shift =3D SOCKET_SHIFT;
-    static int tun_shift =3D TUN_SHIFT;
-    static int err_shift =3D ERR_SHIFT;
+    /* These shifts all depend on EVENT_READ and EVENT_WRITE */
+    static uintptr_t socket_shift =3D 0;   /* depends on SOCKET_READ and S=
OCKET_WRITE */
+    static uintptr_t tun_shift =3D 2;      /* depends on TUN_READ and TUN_=
WRITE */
+    static uintptr_t err_shift =3D 4;      /* depends on ES_ERROR */
 #ifdef ENABLE_MANAGEMENT
-    static int management_shift =3D MANAGEMENT_SHIFT;
+    static uintptr_t management_shift =3D 6; /* depends on MANAGEMENT_READ=
 and MANAGEMENT_WRITE */
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
@@ -2077,7 +2075,7 @@
      */
     if (flags & IOW_WAIT_SIGNAL)
     {
-        wait_signal(c->c2.event_set, (void *)&err_shift);
+        wait_signal(c->c2.event_set, (void *)err_shift);
     }

     /*
@@ -2171,7 +2169,7 @@
      * Configure event wait based on socket, tuntap flags.
      */
     socket_set(c->c2.link_socket, c->c2.event_set, socket, (void *)&socket=
_shift, NULL);
-    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)&tun_shift, NUL=
L);
+    tun_set(c->c1.tuntap, c->c2.event_set, tuntap, (void *)tun_shift, NULL=
);
 #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
     if (socket & EVENT_READ && c->c2.did_open_tun)
     {
@@ -2182,7 +2180,7 @@
 #ifdef ENABLE_MANAGEMENT
     if (management)
     {
-        management_socket_set(management, c->c2.event_set, (void *)&manage=
ment_shift, NULL);
+        management_socket_set(management, c->c2.event_set, (void *)managem=
ent_shift, NULL);
     }
 #endif

@@ -2190,7 +2188,7 @@
     /* arm inotify watcher */
     if (c->options.mode =3D=3D MODE_SERVER)
     {
-        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)&=
file_shift);
+        event_ctl(c->c2.event_set, c->c2.inotify_fd, EVENT_READ, (void *)f=
ile_shift);
     }
 #endif

@@ -2233,7 +2231,7 @@
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

--TsoxkANZvHo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, ordex, plaisthos. <=
/p>
<p>its_Giaan would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/759?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">io_work: convert shift argument to uintptr_t<br><br>Instead o=
f passing the shift argument as pointer, pass<br>directly its integer value=
. This will allow the code to<br>distinguish a shift value from a real obje=
ct pointer,<br>like we already do in multi_tcp_process_io().<br><br>This ch=
ange will allow us later to pass an event_arg<br>object as event handler ar=
gument instead of a simple<br>integer value.<br><br>Change-Id: Ib583bf17e35=
b14aed78fd8217b6e71e8c2b78089<br>Signed-off-by: Antonio Quartulli &lt;a@...493...=
2181...&gt;<br>---<br>M src/openvpn/forward.c<br>1 file changed, 12 inserti=
ons(+), 14 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/59/759/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/forward.c b/s=
rc/openvpn/forward.c</span><br><span>index 16b4497..1247ba3 100644</span><b=
r><span>--- a/src/openvpn/forward.c</span><br><span>+++ b/src/openvpn/forwa=
rd.c</span><br><span>@@ -2050,20 +2050,18 @@</span><br><span>     unsigned =
int tuntap =3D 0;</span><br><span>     struct event_set_return esr[4];</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    /* T=
hese shifts all depend on EVENT_READ (=3D1) and EVENT_WRITE (=3D2)</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-     * and are added to the sh=
ift. Check openvpn.h for more details.</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-     */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    static int socket_shift =3D SOCKET_SHIFT;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    static int tun_shift =3D TUN_SHIFT;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-    static int err_shift =3D E=
RR_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* The=
se shifts all depend on EVENT_READ and EVENT_WRITE */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t socket_shift =3D 0; =
  /* depends on SOCKET_READ and SOCKET_WRITE */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    static uintptr_t tun_shift =3D 2;      /* d=
epends on TUN_READ and TUN_WRITE */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    static uintptr_t err_shift =3D 4;      /* depends on ES=
_ERROR */</span><br><span> #ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    static int management_shift =3D MANAGEM=
ENT_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stati=
c uintptr_t management_shift =3D 6; /* depends on MANAGEMENT_READ and MANAG=
EMENT_WRITE */</span><br><span> #endif</span><br><span> #ifdef ENABLE_ASYNC=
_PUSH</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    static int f=
ile_shift =3D FILE_SHIFT;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    static uintptr_t file_shift =3D FILE_SHIFT;</span><br><span> #end=
if</span><br><span> #if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    static int dco_shift=
 =3D DCO_SHIFT;    /* Event from DCO linux kernel module */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    static uintptr_t dco_shift =3D =
DCO_SHIFT;    /* Event from DCO linux kernel module */</span><br><span> #en=
dif</span><br><span> </span><br><span>     /*</span><br><span>@@ -2077,7 +2=
075,7 @@</span><br><span>      */</span><br><span>     if (flags &amp; IOW_=
WAIT_SIGNAL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        wait_signal(c-&gt;c2.event_set, (void *)&amp;err_shif=
t);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        wait_sig=
nal(c-&gt;c2.event_set, (void *)err_shift);</span><br><span>     }</span><b=
r><span> </span><br><span>     /*</span><br><span>@@ -2171,7 +2169,7 @@</sp=
an><br><span>      * Configure event wait based on socket, tuntap flags.</s=
pan><br><span>      */</span><br><span>     socket_set(c-&gt;c2.link_socket=
, c-&gt;c2.event_set, socket, (void *)&amp;socket_shift, NULL);</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    tun_set(c-&gt;c1.tuntap, c-&g=
t;c2.event_set, tuntap, (void *)&amp;tun_shift, NULL);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    tun_set(c-&gt;c1.tuntap, c-&gt;c2.ev=
ent_set, tuntap, (void *)tun_shift, NULL);</span><br><span> #if defined(TAR=
GET_LINUX) || defined(TARGET_FREEBSD)</span><br><span>     if (socket &amp;=
 EVENT_READ &amp;&amp; c-&gt;c2.did_open_tun)</span><br><span>     {</span>=
<br><span>@@ -2182,7 +2180,7 @@</span><br><span> #ifdef ENABLE_MANAGEMENT</=
span><br><span>     if (management)</span><br><span>     {</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-        management_socket_set(manageme=
nt, c-&gt;c2.event_set, (void *)&amp;management_shift, NULL);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        management_socket_set(man=
agement, c-&gt;c2.event_set, (void *)management_shift, NULL);</span><br><sp=
an>     }</span><br><span> #endif</span><br><span> </span><br><span>@@ -219=
0,7 +2188,7 @@</span><br><span>     /* arm inotify watcher */</span><br><sp=
an>     if (c-&gt;options.mode =3D=3D MODE_SERVER)</span><br><span>     {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-        event_ctl(c-&gt=
;c2.event_set, c-&gt;c2.inotify_fd, EVENT_READ, (void *)&amp;file_shift);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        event_ctl(c-&=
gt;c2.event_set, c-&gt;c2.inotify_fd, EVENT_READ, (void *)file_shift);</spa=
n><br><span>     }</span><br><span> #endif</span><br><span> </span><br><spa=
n>@@ -2233,7 +2231,7 @@</span><br><span>                 for (i =3D 0; i &l=
t; status; ++i)</span><br><span>                 {</span><br><span>        =
             const struct event_set_return *e =3D &amp;esr[i];</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-                    c-&gt;c2.event=
_set_status |=3D ((e-&gt;rwflags &amp; 3) &lt;&lt; *((int *)e-&gt;arg));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+                    c-=
&gt;c2.event_set_status |=3D ((e-&gt;rwflags &amp; 3) &lt;&lt; (uintptr_t)e=
-&gt;arg);</span><br><span>                 }</span><br><span>             =
}</span><br><span>             else if (status =3D=3D 0)</span><br><span></=
span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/759?usp=3Demail">change 759</a>. To unsubscribe, or for help writing=
 mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/759?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib583bf17e35b14aed78fd8217b6=
e71e8c2b78089 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 759 </div>
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


--TsoxkANZvHo=--

