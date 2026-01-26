From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 15:32:25 +0000
In-Reply-To: <gerrit.1769435786000.I87679949bdef6319d7490d561f0136633244c2b9@...2715...>
References: <gerrit.1769435786000.I87679949bdef6319d7490d561f0136633244c2b9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <34425817bad5dd2ee7d1cf8378b02c56b8cb251f-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xQO7RhWhhJI="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: socket: Remove ifdef
 for SO_{RCV, SND}BUF
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xQO7RhWhhJI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
86?usp=3Demail )

Change subject: socket: Remove ifdef for SO_{RCV, SND}BUF
......................................................................

socket: Remove ifdef for SO_{RCV, SND}BUF

Seems all our platforms define it.

Reported-by: Marc Heuse <marc@...2953...>
Github: Fixes OpenVPN/openvpn#965
Change-Id: I87679949bdef6319d7490d561f0136633244c2b9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1486
Message-Id: <20260126145432.31249-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
435.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
1 file changed, 3 insertions(+), 15 deletions(-)




diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 331249d..58ccda9 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -419,57 +419,45 @@
 static int
 socket_get_sndbuf(socket_descriptor_t sd)
 {
-#if defined(SOL_SOCKET) && defined(SO_SNDBUF)
     int val;
-    socklen_t len;
+    socklen_t len =3D sizeof(val);

-    len =3D sizeof(val);
     if (getsockopt(sd, SOL_SOCKET, SO_SNDBUF, (void *)&val, &len) =3D=3D 0=
 && len =3D=3D sizeof(val))
     {
         return val;
     }
-#endif
     return 0;
 }

 static void
 socket_set_sndbuf(socket_descriptor_t sd, int size)
 {
-#if defined(SOL_SOCKET) && defined(SO_SNDBUF)
     if (setsockopt(sd, SOL_SOCKET, SO_SNDBUF, (void *)&size, sizeof(size))=
 !=3D 0)
     {
         msg(M_WARN, "NOTE: setsockopt SO_SNDBUF=3D%d failed", size);
     }
-#endif
 }

 static int
 socket_get_rcvbuf(socket_descriptor_t sd)
 {
-#if defined(SOL_SOCKET) && defined(SO_RCVBUF)
     int val;
-    socklen_t len;
+    socklen_t len =3D sizeof(val);

-    len =3D sizeof(val);
     if (getsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void *)&val, &len) =3D=3D 0=
 && len =3D=3D sizeof(val))
     {
         return val;
     }
-#endif
     return 0;
 }

-static bool
+static void
 socket_set_rcvbuf(socket_descriptor_t sd, int size)
 {
-#if defined(SOL_SOCKET) && defined(SO_RCVBUF)
     if (setsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void *)&size, sizeof(size))=
 !=3D 0)
     {
         msg(M_WARN, "NOTE: setsockopt SO_RCVBUF=3D%d failed", size);
-        return false;
     }
-    return true;
-#endif
 }

 void

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1486?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87679949bdef6319d7490d561f0136633244c2b9
Gerrit-Change-Number: 1486
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--xQO7RhWhhJI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1486?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">socket: Remove ifdef for SO_{RCV, SND}BUF<br><br=
>Seems all our platforms define it.<br><br>Reported-by: Marc Heuse &lt;marc=
@...2953...&gt;<br>Github: Fixes OpenVPN/openvpn#965<br>Change-Id: I8767994=
9bdef6319d7490d561f0136633244c2b9<br>Signed-off-by: Frank Lichtenheld &lt;f=
rank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Ge=
rrit URL: https://gerrit.openvpn.net/c/openvpn/+/1486<br>Message-Id: &lt;20=
260126145432.31249-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.c=
om/openvpn-devel@lists.sourceforge.net/msg35435.html<br>Signed-off-by: Gert=
 Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file=
 changed, 3 insertions(+), 15 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index 331249d..58ccda9 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -419,57 +419,4=
5 @@</span><br><span> static int</span><br><span> socket_get_sndbuf(socket_=
descriptor_t sd)</span><br><span> {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(SOL_SOCKET) &amp;&amp; defined(SO_SNDBUF)</span><=
br><span>     int val;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    socklen_t len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    socklen_t len =3D sizeof(val);</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    len =3D sizeof(val);</span><br><span>  =
   if (getsockopt(sd, SOL_SOCKET, SO_SNDBUF, (void *)&amp;val, &amp;len) =
=3D=3D 0 &amp;&amp; len =3D=3D sizeof(val))</span><br><span>     {</span><b=
r><span>         return val;</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     return 0;</span=
><br><span> }</span><br><span> </span><br><span> static void</span><br><spa=
n> socket_set_sndbuf(socket_descriptor_t sd, int size)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(SOL_SOCKET)=
 &amp;&amp; defined(SO_SNDBUF)</span><br><span>     if (setsockopt(sd, SOL_=
SOCKET, SO_SNDBUF, (void *)&amp;size, sizeof(size)) !=3D 0)</span><br><span=
>     {</span><br><span>         msg(M_WARN, &quot;NOTE: setsockopt SO_SNDB=
UF=3D%d failed&quot;, size);</span><br><span>     }</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> }</span><br><span> =
</span><br><span> static int</span><br><span> socket_get_rcvbuf(socket_desc=
riptor_t sd)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(SOL_SOCKET) &amp;&amp; defined(SO_RCVBUF)</span><br><=
span>     int val;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 socklen_t len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
socklen_t len =3D sizeof(val);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    len =3D sizeof(val);</span><br><span>     if=
 (getsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void *)&amp;val, &amp;len) =3D=3D =
0 &amp;&amp; len =3D=3D sizeof(val))</span><br><span>     {</span><br><span=
>         return val;</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span>     return 0;</span><br><spa=
n> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span> socket_set_rcvbuf(socket_descriptor_t sd, int size)</=
span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if =
defined(SOL_SOCKET) &amp;&amp; defined(SO_RCVBUF)</span><br><span>     if (=
setsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void *)&amp;size, sizeof(size)) !=3D=
 0)</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;NOTE:=
 setsockopt SO_RCVBUF=3D%d failed&quot;, size);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return false;</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> }</span=
><br><span> </span><br><span> void</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1486?usp=3Demai=
l">change 1486</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1486?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87679949bdef6319d7490d561f0=
136633244c2b9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1486 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--xQO7RhWhhJI=--

