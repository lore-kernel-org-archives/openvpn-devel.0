From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 26 Jan 2026 13:56:31 +0000
References: <gerrit.1769435786000.I87679949bdef6319d7490d561f0136633244c2b9@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <0f33c096a81866a3a2a0b1a10519ab93d5e1a900-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="fK3aeysjojA="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--fK3aeysjojA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1486?usp=3Demail

to review the following change.


Change subject: socket: Remove ifdef for SO_{RCV,SND}BUF
......................................................................

socket: Remove ifdef for SO_{RCV,SND}BUF

Seems all our platforms define it.

Github: Fixes #965
Change-Id: I87679949bdef6319d7490d561f0136633244c2b9
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/socket.c
1 file changed, 3 insertions(+), 15 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/1486/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I87679949bdef6319d7490d561f0136633244c2b9
Gerrit-Change-Number: 1486
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--fK3aeysjojA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1486?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">socket: Remove ifdef for SO_{RCV,SND}BUF<br=
><br>Seems all our platforms define it.<br><br>Github: Fixes #965<br>Change=
-Id: I87679949bdef6319d7490d561f0136633244c2b9<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/socket.c<br>1 file=
 changed, 3 insertions(+), 15 deletions(-)<br><br></pre><pre class=3D"block=
s" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git p=
ull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/86/1486/1</pre><pre=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>d=
iff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>ind=
ex 331249d..58ccda9 100644</span><br><span>--- a/src/openvpn/socket.c</span=
><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -419,57 +419,45 @@=
</span><br><span> static int</span><br><span> socket_get_sndbuf(socket_desc=
riptor_t sd)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#if defined(SOL_SOCKET) &amp;&amp; defined(SO_SNDBUF)</span><br><=
span>     int val;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-   =
 socklen_t len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
socklen_t len =3D sizeof(val);</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    len =3D sizeof(val);</span><br><span>     if=
 (getsockopt(sd, SOL_SOCKET, SO_SNDBUF, (void *)&amp;val, &amp;len) =3D=3D =
0 &amp;&amp; len =3D=3D sizeof(val))</span><br><span>     {</span><br><span=
>         return val;</span><br><span>     }</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#endif</span><br><span>     return 0;</span><br><spa=
n> }</span><br><span> </span><br><span> static void</span><br><span> socket=
_set_sndbuf(socket_descriptor_t sd, int size)</span><br><span> {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#if defined(SOL_SOCKET) &amp;&am=
p; defined(SO_SNDBUF)</span><br><span>     if (setsockopt(sd, SOL_SOCKET, S=
O_SNDBUF, (void *)&amp;size, sizeof(size)) !=3D 0)</span><br><span>     {</=
span><br><span>         msg(M_WARN, &quot;NOTE: setsockopt SO_SNDBUF=3D%d f=
ailed&quot;, size);</span><br><span>     }</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#endif</span><br><span> }</span><br><span> </span><br>=
<span> static int</span><br><span> socket_get_rcvbuf(socket_descriptor_t sd=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
if defined(SOL_SOCKET) &amp;&amp; defined(SO_RCVBUF)</span><br><span>     i=
nt val;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    socklen_t =
len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    socklen_t l=
en =3D sizeof(val);</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    len =3D sizeof(val);</span><br><span>     if (getsockop=
t(sd, SOL_SOCKET, SO_RCVBUF, (void *)&amp;val, &amp;len) =3D=3D 0 &amp;&amp=
; len =3D=3D sizeof(val))</span><br><span>     {</span><br><span>         r=
eturn val;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#endif</span><br><span>     return 0;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-static boo=
l</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span> socket_set_rcvbuf(socket_descriptor_t sd, int size)</span><br><s=
pan> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(SOL=
_SOCKET) &amp;&amp; defined(SO_RCVBUF)</span><br><span>     if (setsockopt(=
sd, SOL_SOCKET, SO_RCVBUF, (void *)&amp;size, sizeof(size)) !=3D 0)</span><=
br><span>     {</span><br><span>         msg(M_WARN, &quot;NOTE: setsockopt=
 SO_RCVBUF=3D%d failed&quot;, size);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        return false;</span><br><span>     }</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    return true;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> }</span><br><span>=
 </span><br><span> void</span><br><span></span><br></pre><p>To view, visit =
<a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1486?usp=3Demail">change 1=
486</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D=
"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div item=
scope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1486?usp=3Demail"/><meta it=
emprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I87679949bdef6319d7490d561f0=
136633244c2b9 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1486 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--fK3aeysjojA=--

