From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 25 Sep 2024 07:06:33 +0000
In-Reply-To: <gerrit.1726754803000.Ice015df81543c01094479929f0cb3075ca4f3813@...2715...>
References: <gerrit.1726754803000.Ice015df81543c01094479929f0cb3075ca4f3813@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a2922a7b120b246583ad913611350fd6ab2e862c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="lcINSyMK47k="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Ensure that the
 AF_UNIX socket pair has at least 65k of buffer space
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--lcINSyMK47k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/75=
4?usp=3Demail )

Change subject: Ensure that the AF_UNIX socket pair has at least 65k of buf=
fer space
......................................................................

Ensure that the AF_UNIX socket pair has at least 65k of buffer space

Without this change, pinging a lwipovpn client with something like a
3000 byte payload on macOS often fails as the default buffer sizes on
macOS are 2048 for send and 4096 for receive.

Change-Id: Ice015df81543c01094479929f0cb3075ca4f3813
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240925063016.22532-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
413.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
M src/openvpn/socket.h
M src/openvpn/tun_afunix.c
3 files changed, 29 insertions(+), 6 deletions(-)




diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 6c790a0..7b1e603 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -890,20 +890,23 @@
 #endif
 }

-static void
-socket_set_buffers(socket_descriptor_t fd, const struct socket_buffer_size=
 *sbs)
+void
+socket_set_buffers(socket_descriptor_t fd, const struct socket_buffer_size=
 *sbs,
+                   bool reduce_size)
 {
     if (sbs)
     {
         const int sndbuf_old =3D socket_get_sndbuf(fd);
         const int rcvbuf_old =3D socket_get_rcvbuf(fd);

-        if (sbs->sndbuf)
+        if (sbs->sndbuf
+            && (reduce_size || sndbuf_old < sbs->sndbuf))
         {
             socket_set_sndbuf(fd, sbs->sndbuf);
         }

-        if (sbs->rcvbuf)
+        if (sbs->rcvbuf
+            && (reduce_size || rcvbuf_old < sbs->rcvbuf))
         {
             socket_set_rcvbuf(fd, sbs->rcvbuf);
         }
@@ -986,7 +989,7 @@
     {
         ls->socket_buffer_sizes.sndbuf =3D sndbuf;
         ls->socket_buffer_sizes.rcvbuf =3D rcvbuf;
-        socket_set_buffers(ls->sd, &ls->socket_buffer_sizes);
+        socket_set_buffers(ls->sd, &ls->socket_buffer_sizes, true);
     }
 }

@@ -1136,7 +1139,7 @@
     sock->info.af =3D addr->ai_family;

     /* set socket buffers based on --sndbuf and --rcvbuf options */
-    socket_set_buffers(sock->sd, &sock->socket_buffer_sizes);
+    socket_set_buffers(sock->sd, &sock->socket_buffer_sizes, true);

     /* set socket to --mark packets with given value */
     socket_set_mark(sock->sd, sock->mark);
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index bbdabfb..2e583af 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -157,6 +157,18 @@
     int sndbuf;
 };

+/**
+ * Sets the receive and send buffer sizes of a socket descriptor.
+ *
+ * @param fd            The socket to modify
+ * @param sbs           new sizes.
+ * @param reduce_size   apply the new size even if smaller than current one
+ */
+void
+socket_set_buffers(socket_descriptor_t fd,
+                   const struct socket_buffer_size *sbs,
+                   bool reduce_size);
+
 /*
  * This is the main socket structure used by OpenVPN.  The SOCKET_
  * defines try to abstract away our implementation differences between
diff --git a/src/openvpn/tun_afunix.c b/src/openvpn/tun_afunix.c
index f4ce4b7..6b6c159 100644
--- a/src/openvpn/tun_afunix.c
+++ b/src/openvpn/tun_afunix.c
@@ -35,6 +35,7 @@
 #include "wfp_block.h"
 #include "argv.h"
 #include "options.h"
+#include "socket.h"

 #ifndef WIN32
 /* Windows does implement some AF_UNIX functionality but key features
@@ -80,6 +81,13 @@
         return;
     }

+
+    /* Ensure that the buffer sizes are decently sized. Otherwise macOS wi=
ll
+     * just have 2048 */
+    struct socket_buffer_size newsizes =3D {65536, 65536 };
+    socket_set_buffers(fds[0], &newsizes, false);
+    socket_set_buffers(fds[1], &newsizes, false);
+
     /* Use the first file descriptor for our side and avoid passing it
      * to the child */
     tt->fd =3D fds[1];

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/754?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ice015df81543c01094479929f0cb3075ca4f3813
Gerrit-Change-Number: 754
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--lcINSyMK47k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/754?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Ensure that the AF_UNIX socket pair has at lea=
st 65k of buffer space<br><br>Without this change, pinging a lwipovpn clien=
t with something like a<br>3000 byte payload on macOS often fails as the de=
fault buffer sizes on<br>macOS are 2048 for send and 4096 for receive.<br><=
br>Change-Id: Ice015df81543c01094479929f0cb3075ca4f3813<br>Signed-off-by: A=
rne Schwabe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>Message-Id: &lt;20240925063016.22532-1-gert@...1296...&gt;<br=
>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg2=
9413.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>=
M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>M src/openvpn/tun_afuni=
x.c<br>3 files changed, 29 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index 6c790a0..7b1e603 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -890,20 +890,2=
3 @@</span><br><span> #endif</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-static void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-socket_set_buffers(socket_descriptor_t fd=
, const struct socket_buffer_size *sbs)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+socket_set_buffers(socket_descriptor_t fd, const struct socket_buffer_=
size *sbs,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
          bool reduce_size)</span><br><span> {</span><br><span>     if (sbs=
)</span><br><span>     {</span><br><span>         const int sndbuf_old =3D =
socket_get_sndbuf(fd);</span><br><span>         const int rcvbuf_old =3D so=
cket_get_rcvbuf(fd);</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        if (sbs-&gt;sndbuf)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        if (sbs-&gt;sndbuf</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            &amp;&amp; (reduce_size || sn=
dbuf_old &lt; sbs-&gt;sndbuf))</span><br><span>         {</span><br><span> =
            socket_set_sndbuf(fd, sbs-&gt;sndbuf);</span><br><span>        =
 }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       if (sbs-&gt;rcvbuf)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        if (sbs-&gt;rcvbuf</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            &amp;&amp; (reduce_size || rcvbuf_old &lt; sbs-&g=
t;rcvbuf))</span><br><span>         {</span><br><span>             socket_s=
et_rcvbuf(fd, sbs-&gt;rcvbuf);</span><br><span>         }</span><br><span>@=
@ -986,7 +989,7 @@</span><br><span>     {</span><br><span>         ls-&gt;s=
ocket_buffer_sizes.sndbuf =3D sndbuf;</span><br><span>         ls-&gt;socke=
t_buffer_sizes.rcvbuf =3D rcvbuf;</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        socket_set_buffers(ls-&gt;sd, &amp;ls-&gt;socket_buffer=
_sizes);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        soc=
ket_set_buffers(ls-&gt;sd, &amp;ls-&gt;socket_buffer_sizes, true);</span><b=
r><span>     }</span><br><span> }</span><br><span> </span><br><span>@@ -113=
6,7 +1139,7 @@</span><br><span>     sock-&gt;info.af =3D addr-&gt;ai_family=
;</span><br><span> </span><br><span>     /* set socket buffers based on --s=
ndbuf and --rcvbuf options */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    socket_set_buffers(sock-&gt;sd, &amp;sock-&gt;socket_buffer_siz=
es);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socket_set_=
buffers(sock-&gt;sd, &amp;sock-&gt;socket_buffer_sizes, true);</span><br><s=
pan> </span><br><span>     /* set socket to --mark packets with given value=
 */</span><br><span>     socket_set_mark(sock-&gt;sd, sock-&gt;mark);</span=
><br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><=
br><span>index bbdabfb..2e583af 100644</span><br><span>--- a/src/openvpn/so=
cket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -157,6=
 +157,18 @@</span><br><span>     int sndbuf;</span><br><span> };</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets the receive and send=
 buffer sizes of a socket descriptor.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param fd            The socket to modify</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ * @param sbs           new sizes.</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param reduce_size   apply the =
new size even if smaller than current one</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+socket_se=
t_buffers(socket_descriptor_t fd,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                   const struct socket_buffer_size *sbs,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+                   bool =
reduce_size);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span> /*</span><br><span>  * This is the main socket structure used b=
y OpenVPN.  The SOCKET_</span><br><span>  * defines try to abstract away ou=
r implementation differences between</span><br><span>diff --git a/src/openv=
pn/tun_afunix.c b/src/openvpn/tun_afunix.c</span><br><span>index f4ce4b7..6=
b6c159 100644</span><br><span>--- a/src/openvpn/tun_afunix.c</span><br><spa=
n>+++ b/src/openvpn/tun_afunix.c</span><br><span>@@ -35,6 +35,7 @@</span><b=
r><span> #include &quot;wfp_block.h&quot;</span><br><span> #include &quot;a=
rgv.h&quot;</span><br><span> #include &quot;options.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;socket.h&quot;</span=
><br><span> </span><br><span> #ifndef WIN32</span><br><span> /* Windows doe=
s implement some AF_UNIX functionality but key features</span><br><span>@@ =
-80,6 +81,13 @@</span><br><span>         return;</span><br><span>     }</sp=
an><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Ensure that the b=
uffer sizes are decently sized. Otherwise macOS will</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+     * just have 2048 */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct socket_buffer_size newsiz=
es =3D {65536, 65536 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    socket_set_buffers(fds[0], &amp;newsizes, false);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    socket_set_buffers(fds[1], &amp;n=
ewsizes, false);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     /* Use the first file descriptor for our side and avoid =
passing it</span><br><span>      * to the child */</span><br><span>     tt-=
&gt;fd =3D fds[1];</span><br><span></span><br></pre><p>To view, visit <a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/754?usp=3Demail">change 754</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"h=
ttp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/754?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ice015df81543c01094479929f0c=
b3075ca4f3813 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 754 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--lcINSyMK47k=--

