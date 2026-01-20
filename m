From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 20 Jan 2026 17:36:11 +0000
References: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net
Message-ID: <f1c5c1510c0f2ec1458fdb7522a9fda8f9a821df-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vZQ61mbg8/Y="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Change
 stream_buf_read_setup_dowork parameter to struct steam_buf
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vZQ61mbg8/Y=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

plaisthos has uploaded this change for review. ( http://gerrit.openvpn.net/=
c/openvpn/+/1483?usp=3Demail )


Change subject: Change stream_buf_read_setup_dowork parameter to struct ste=
am_buf
......................................................................

Change stream_buf_read_setup_dowork parameter to struct steam_buf

This methods only ever access sock->stream_buf so make the method
simpler by just having a parameter sb.

Change-Id: I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3
---
M src/openvpn/socket.c
M src/openvpn/socket.h
2 files changed, 16 insertions(+), 11 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1483/1

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 331249d..f8c0b5c 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2123,22 +2123,22 @@
 }

 bool
-stream_buf_read_setup_dowork(struct link_socket *sock)
+stream_buf_read_setup_dowork(struct stream_buf *sb)
 {
-    if (sock->stream_buf.residual.len && !sock->stream_buf.residual_fully_=
formed)
+    if (sb->residual.len && !sb->residual_fully_formed)
     {
-        ASSERT(buf_copy(&sock->stream_buf.buf, &sock->stream_buf.residual)=
);
-        ASSERT(buf_init(&sock->stream_buf.residual, 0));
-        sock->stream_buf.residual_fully_formed =3D stream_buf_added(&sock-=
>stream_buf, 0);
+        ASSERT(buf_copy(sb->buf, &sock->stream_buf.residual));
+        ASSERT(buf_init(&sb->residual, 0));
+        sb->residual_fully_formed =3D stream_buf_added(sb, 0);
         dmsg(D_STREAM_DEBUG, "STREAM: RESIDUAL FULLY FORMED [%s], len=3D%d=
",
-             sock->stream_buf.residual_fully_formed ? "YES" : "NO", sock->=
stream_buf.residual.len);
+             stream_buf->residual_fully_formed ? "YES" : "NO", sb->residua=
l.len);
     }

-    if (!sock->stream_buf.residual_fully_formed)
+    if (!sb->residual_fully_formed)
     {
-        stream_buf_set_next(&sock->stream_buf);
+        stream_buf_set_next(sb);
     }
-    return !sock->stream_buf.residual_fully_formed;
+    return !sb->residual_fully_formed;
 }

 static bool
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 850064d..8664666f 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -528,14 +528,19 @@
     }
 }

-bool stream_buf_read_setup_dowork(struct link_socket *sock);
+/**
+ *
+ * @param sock
+ * @return
+ */
+bool stream_buf_read_setup_dowork(struct stream_buf *sb);

 static inline bool
 stream_buf_read_setup(struct link_socket *sock)
 {
     if (link_socket_connection_oriented(sock))
     {
-        return stream_buf_read_setup_dowork(sock);
+        return stream_buf_read_setup_dowork(&sock->stream_buf);
     }
     else
     {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1483?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3
Gerrit-Change-Number: 1483
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--vZQ61mbg8/Y=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>plaisthos has upl=
oaded this change for <strong>review</strong>.</p><p><a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1483?usp=3Demail">View Change</a></p><pre class=
=3D"blocks" style=3D"font-family: monospace,monospace; white-space: pre-wra=
p;">Change stream_buf_read_setup_dowork parameter to struct steam_buf<br><b=
r>This methods only ever access sock-&gt;stream_buf so make the method<br>s=
impler by just having a parameter sb.<br><br>Change-Id: I3deb7cd75db3cb280f=
a8d9c637cd3bde3881d6e3<br>---<br>M src/openvpn/socket.c<br>M src/openvpn/so=
cket.h<br>2 files changed, 16 insertions(+), 11 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/8=
3/1483/1</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</=
span><br><span>index 331249d..f8c0b5c 100644</span><br><span>--- a/src/open=
vpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ =
-2123,22 +2123,22 @@</span><br><span> }</span><br><span> </span><br><span> =
bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-stream_buf_read_s=
etup_dowork(struct link_socket *sock)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+stream_buf_read_setup_dowork(struct stream_buf *sb)</span=
><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (=
sock-&gt;stream_buf.residual.len &amp;&amp; !sock-&gt;stream_buf.residual_f=
ully_formed)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if =
(sb-&gt;residual.len &amp;&amp; !sb-&gt;residual_fully_formed)</span><br><s=
pan>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASS=
ERT(buf_copy(&amp;sock-&gt;stream_buf.buf, &amp;sock-&gt;stream_buf.residua=
l));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(bu=
f_init(&amp;sock-&gt;stream_buf.residual, 0));</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-        sock-&gt;stream_buf.residual_fully_formed =
=3D stream_buf_added(&amp;sock-&gt;stream_buf, 0);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        ASSERT(buf_copy(sb-&gt;buf, &amp;soc=
k-&gt;stream_buf.residual));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        ASSERT(buf_init(&amp;sb-&gt;residual, 0));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+        sb-&gt;residual_fully_forme=
d =3D stream_buf_added(sb, 0);</span><br><span>         dmsg(D_STREAM_DEBUG=
, &quot;STREAM: RESIDUAL FULLY FORMED [%s], len=3D%d&quot;,</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-             sock-&gt;stream_buf.resi=
dual_fully_formed ? &quot;YES&quot; : &quot;NO&quot;, sock-&gt;stream_buf.r=
esidual.len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
       stream_buf-&gt;residual_fully_formed ? &quot;YES&quot; : &quot;NO&qu=
ot;, sb-&gt;residual.len);</span><br><span>     }</span><br><span> </span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    if (!sock-&gt;stream_buf.=
residual_fully_formed)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (!sb-&gt;residual_fully_formed)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        stream_buf_set_next(&amp=
;sock-&gt;stream_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        stream_buf_set_next(sb);</span><br><span>     }</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return !sock-&gt;stream_buf.residu=
al_fully_formed;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 return !sb-&gt;residual_fully_formed;</span><br><span> }</span><br><span> =
</span><br><span> static bool</span><br><span>diff --git a/src/openvpn/sock=
et.h b/src/openvpn/socket.h</span><br><span>index 850064d..8664666f 100644<=
/span><br><span>--- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvp=
n/socket.h</span><br><span>@@ -528,14 +528,19 @@</span><br><span>     }</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-bool stream_buf_read_setup_dowork(struct link_socket *sock);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * @param sock</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * @return</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool strea=
m_buf_read_setup_dowork(struct stream_buf *sb);</span><br><span> </span><br=
><span> static inline bool</span><br><span> stream_buf_read_setup(struct li=
nk_socket *sock)</span><br><span> {</span><br><span>     if (link_socket_co=
nnection_oriented(sock))</span><br><span>     {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        return stream_buf_read_setup_dowork(sock)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        return str=
eam_buf_read_setup_dowork(&amp;sock-&gt;stream_buf);</span><br><span>     }=
</span><br><span>     else</span><br><span>     {</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1483?usp=3Demail">change 1483</a>. To unsubscribe, or for help writing mail=
 filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">=
settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"=
><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActio=
n"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/148=
3?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></di=
v>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3deb7cd75db3cb280fa8d9c637c=
d3bde3881d6e3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1483 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--vZQ61mbg8/Y=--

