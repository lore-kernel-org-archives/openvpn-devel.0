From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 16:27:55 +0000
In-Reply-To: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
References: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1aed6c6bbf8a847ab71b180bd79021d5a490f769-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ygU9VeXKb08="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ygU9VeXKb08=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#5) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1483?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld


Change subject: Change stream_buf_read_setup_dowork parameter to struct ste=
am_buf
......................................................................

Change stream_buf_read_setup_dowork parameter to struct steam_buf

This methods only ever access sock->stream_buf so make the method
simpler by just having a parameter sb.

Change-Id: I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1483
Message-Id: <20260211150747.113906-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
595.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
M src/openvpn/socket.h
2 files changed, 21 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1483/5

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index d97b770..033444e 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -2111,22 +2111,22 @@
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
+        ASSERT(buf_copy(&sb->buf, &sb->residual));
+        ASSERT(buf_init(&sb->residual, 0));
+        sb->residual_fully_formed =3D stream_buf_added(sb, 0);
         dmsg(D_STREAM_DEBUG, "STREAM: RESIDUAL FULLY FORMED [%s], len=3D%d=
",
-             sock->stream_buf.residual_fully_formed ? "YES" : "NO", sock->=
stream_buf.residual.len);
+             sb->residual_fully_formed ? "YES" : "NO", sb->residual.len);
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
index 850064d..3f46dc6 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -528,14 +528,24 @@
     }
 }

-bool stream_buf_read_setup_dowork(struct link_socket *sock);
+/**
+ * Will try to check if the buffers in stream form a
+ * full packet. Will return true if further reads are
+ * required and false otherwise. (full packet is ready)
+ *
+ * With UDP we always return true as there is no reassembly.
+ *
+ * @param sb    the stream buffer that should be worked on
+ * @return      true if more reads are required.
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3
Gerrit-Change-Number: 1483
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--ygU9VeXKb08=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #5</strong> to the change originally created by plaisthos.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1483?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Change stream_buf_read_setup=
_dowork parameter to struct steam_buf<br><br>This methods only ever access =
sock-&gt;stream_buf so make the method<br>simpler by just having a paramete=
r sb.<br><br>Change-Id: I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3<br>Signed=
-off-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Frank Li=
chtenheld &lt;frank@...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.ne=
t/c/openvpn/+/1483<br>Message-Id: &lt;20260211150747.113906-1-frank@...2746...=
...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1483...=
e.net/msg35595.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<=
br>---<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>2 files chang=
ed, 21 insertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull s=
sh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1483/5</pre><pre styl=
e=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff -=
-git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index d9=
7b770..033444e 100644</span><br><span>--- a/src/openvpn/socket.c</span><br>=
<span>+++ b/src/openvpn/socket.c</span><br><span>@@ -2111,22 +2111,22 @@</s=
pan><br><span> }</span><br><span> </span><br><span> bool</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-stream_buf_read_setup_dowork(struct link=
_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+strea=
m_buf_read_setup_dowork(struct stream_buf *sb)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;stream_buf.res=
idual.len &amp;&amp; !sock-&gt;stream_buf.residual_fully_formed)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (sb-&gt;residual.len &a=
mp;&amp; !sb-&gt;residual_fully_formed)</span><br><span>     {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_copy(&amp;sock-=
&gt;stream_buf.buf, &amp;sock-&gt;stream_buf.residual));</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_init(&amp;sock-&gt;st=
ream_buf.residual, 0));</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-        sock-&gt;stream_buf.residual_fully_formed =3D stream_buf_added(&a=
mp;sock-&gt;stream_buf, 0);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        ASSERT(buf_copy(&amp;sb-&gt;buf, &amp;sb-&gt;residual));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(buf_ini=
t(&amp;sb-&gt;residual, 0));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        sb-&gt;residual_fully_formed =3D stream_buf_added(sb, 0);<=
/span><br><span>         dmsg(D_STREAM_DEBUG, &quot;STREAM: RESIDUAL FULLY =
FORMED [%s], len=3D%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-             sock-&gt;stream_buf.residual_fully_formed ? &quot;YES&q=
uot; : &quot;NO&quot;, sock-&gt;stream_buf.residual.len);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+             sb-&gt;residual_fully_fo=
rmed ? &quot;YES&quot; : &quot;NO&quot;, sb-&gt;residual.len);</span><br><s=
pan>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    if (!sock-&gt;stream_buf.residual_fully_formed)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    if (!sb-&gt;residual_fully_forme=
d)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        stream_buf_set_next(&amp;sock-&gt;stream_buf);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        stream_buf_set_next(sb);</sp=
an><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  return !sock-&gt;stream_buf.residual_fully_formed;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    return !sb-&gt;residual_fully_formed;=
</span><br><span> }</span><br><span> </span><br><span> static bool</span><b=
r><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br>=
<span>index 850064d..3f46dc6 100644</span><br><span>--- a/src/openvpn/socke=
t.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -528,14 +=
528,24 @@</span><br><span>     }</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-bool stream_buf_read_setup_=
dowork(struct link_socket *sock);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 Will try to check if the buffers in stream form a</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * full packet. Will return true if further =
reads are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * require=
d and false otherwise. (full packet is ready)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * With UDP we always return true as there is no reassembly.</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param sb    the stream buffer that sh=
ould be worked on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @return      true if more reads are required.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+bool stream_buf_read_setup_dowork(struct stream_buf *sb);</span>=
<br><span> </span><br><span> static inline bool</span><br><span> stream_buf=
_read_setup(struct link_socket *sock)</span><br><span> {</span><br><span>  =
   if (link_socket_connection_oriented(sock))</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        return stream_buf_re=
ad_setup_dowork(sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        return stream_buf_read_setup_dowork(&amp;sock-&gt;stream_buf);</=
span><br><span>     }</span><br><span>     else</span><br><span>     {</spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1483?usp=3Demail">change 1483</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1483?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3deb7cd75db3cb280fa8d9c637c=
d3bde3881d6e3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1483 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--ygU9VeXKb08=--

