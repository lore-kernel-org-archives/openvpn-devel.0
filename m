From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 15:32:22 +0000
In-Reply-To: <gerrit.1769435786000.I87679949bdef6319d7490d561f0136633244c2b9@...2715...>
References: <gerrit.1769435786000.I87679949bdef6319d7490d561f0136633244c2b9@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <34425817bad5dd2ee7d1cf8378b02c56b8cb251f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6jb96y2ZuIU="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6jb96y2ZuIU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1486?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/1486/3

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87679949bdef6319d7490d561f0136633244c2b9
Gerrit-Change-Number: 1486
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--6jb96y2ZuIU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1486?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">socket: Remove ifdef for SO_{RCV, S=
ND}BUF<br><br>Seems all our platforms define it.<br><br>Reported-by: Marc H=
euse &lt;marc@...2953...&gt;<br>Github: Fixes OpenVPN/openvpn#965<br>Change=
-Id: I87679949bdef6319d7490d561f0136633244c2b9<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1486<br>Messa=
ge-Id: &lt;20260126145432.31249-1-gert@...1296...&gt;<br>URL: https://www.m=
ail-archive.com/openvpn-devel@lists.sourceforge.net/msg35435.html<br>Signed=
-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/socke=
t.c<br>1 file changed, 3 insertions(+), 15 deletions(-)<br><br></pre><pre c=
lass=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/148=
6/3</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span>=
<br><span>index 331249d..58ccda9 100644</span><br><span>--- a/src/openvpn/s=
ocket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -419,=
57 +419,45 @@</span><br><span> static int</span><br><span> socket_get_sndbu=
f(socket_descriptor_t sd)</span><br><span> {</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#if defined(SOL_SOCKET) &amp;&amp; defined(SO_SNDBUF=
)</span><br><span>     int val;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    socklen_t len;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    socklen_t len =3D sizeof(val);</span><br><span> </span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    len =3D sizeof(val);</span><br>=
<span>     if (getsockopt(sd, SOL_SOCKET, SO_SNDBUF, (void *)&amp;val, &amp=
;len) =3D=3D 0 &amp;&amp; len =3D=3D sizeof(val))</span><br><span>     {</s=
pan><br><span>         return val;</span><br><span>     }</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>     return 0;</=
span><br><span> }</span><br><span> </span><br><span> static void</span><br>=
<span> socket_set_sndbuf(socket_descriptor_t sd, int size)</span><br><span>=
 {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(SOL_SOC=
KET) &amp;&amp; defined(SO_SNDBUF)</span><br><span>     if (setsockopt(sd, =
SOL_SOCKET, SO_SNDBUF, (void *)&amp;size, sizeof(size)) !=3D 0)</span><br><=
span>     {</span><br><span>         msg(M_WARN, &quot;NOTE: setsockopt SO_=
SNDBUF=3D%d failed&quot;, size);</span><br><span>     }</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> }</span><br><span=
> </span><br><span> static int</span><br><span> socket_get_rcvbuf(socket_de=
scriptor_t sd)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(SOL_SOCKET) &amp;&amp; defined(SO_RCVBUF)</span><br=
><span>     int val;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   socklen_t len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  socklen_t len =3D sizeof(val);</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    len =3D sizeof(val);</span><br><span>     =
if (getsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void *)&amp;val, &amp;len) =3D=
=3D 0 &amp;&amp; len =3D=3D sizeof(val))</span><br><span>     {</span><br><=
span>         return val;</span><br><span>     }</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#endif</span><br><span>     return 0;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span> socket_set_rcvbuf(socket_descriptor_t sd, int siz=
e)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#if defined(SOL_SOCKET) &amp;&amp; defined(SO_RCVBUF)</span><br><span>     =
if (setsockopt(sd, SOL_SOCKET, SO_RCVBUF, (void *)&amp;size, sizeof(size)) =
!=3D 0)</span><br><span>     {</span><br><span>         msg(M_WARN, &quot;N=
OTE: setsockopt SO_RCVBUF=3D%d failed&quot;, size);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        return false;</span><br><span>     =
}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return true;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> }=
</span><br><span> </span><br><span> void</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1486?usp=
=3Demail">change 1486</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1486?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--6jb96y2ZuIU=--

