From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 16 Feb 2026 16:27:58 +0000
In-Reply-To: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
References: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1aed6c6bbf8a847ab71b180bd79021d5a490f769-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="NSkuJ3L8aSg="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NSkuJ3L8aSg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
83?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3
Gerrit-Change-Number: 1483
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--NSkuJ3L8aSg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1483?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Change stream_buf_read_setup_dowork parameter to=
 struct steam_buf<br><br>This methods only ever access sock-&gt;stream_buf =
so make the method<br>simpler by just having a parameter sb.<br><br>Change-=
Id: I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3<br>Signed-off-by: Arne Schwab=
e &lt;arne-openvpn@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1483<b=
r>Message-Id: &lt;20260211150747.113906-1-frank@...2641...&gt;<br>URL: http=
s://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35595.html<=
br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/open=
vpn/socket.c<br>M src/openvpn/socket.h<br>2 files changed, 21 insertions(+)=
, 11 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index d97b770..033444e 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -2111,22 +2111=
,22 @@</span><br><span> }</span><br><span> </span><br><span> bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-stream_buf_read_setup_dowork(st=
ruct link_socket *sock)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+stream_buf_read_setup_dowork(struct stream_buf *sb)</span><br><span> {<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;strea=
m_buf.residual.len &amp;&amp; !sock-&gt;stream_buf.residual_fully_formed)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (sb-&gt;residu=
al.len &amp;&amp; !sb-&gt;residual_fully_formed)</span><br><span>     {</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_copy(&=
amp;sock-&gt;stream_buf.buf, &amp;sock-&gt;stream_buf.residual));</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_init(&amp;so=
ck-&gt;stream_buf.residual, 0));</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        sock-&gt;stream_buf.residual_fully_formed =3D stream_buf=
_added(&amp;sock-&gt;stream_buf, 0);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        ASSERT(buf_copy(&amp;sb-&gt;buf, &amp;sb-&gt;resid=
ual));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSER=
T(buf_init(&amp;sb-&gt;residual, 0));</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+        sb-&gt;residual_fully_formed =3D stream_buf_added=
(sb, 0);</span><br><span>         dmsg(D_STREAM_DEBUG, &quot;STREAM: RESIDU=
AL FULLY FORMED [%s], len=3D%d&quot;,</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-             sock-&gt;stream_buf.residual_fully_formed ? &q=
uot;YES&quot; : &quot;NO&quot;, sock-&gt;stream_buf.residual.len);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+             sb-&gt;residual=
_fully_formed ? &quot;YES&quot; : &quot;NO&quot;, sb-&gt;residual.len);</sp=
an><br><span>     }</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    if (!sock-&gt;stream_buf.residual_fully_formed)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!sb-&gt;residual_fu=
lly_formed)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        stream_buf_set_next(&amp;sock-&gt;stream_buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        stream_buf_set_next=
(sb);</span><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return !sock-&gt;stream_buf.residual_fully_formed;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    return !sb-&gt;residual_fully=
_formed;</span><br><span> }</span><br><span> </span><br><span> static bool<=
/span><br><span>diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</s=
pan><br><span>index 850064d..3f46dc6 100644</span><br><span>--- a/src/openv=
pn/socket.h</span><br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -=
528,14 +528,24 @@</span><br><span>     }</span><br><span> }</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool stream_buf_rea=
d_setup_dowork(struct link_socket *sock);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * Will try to check if the buffers in stream form a</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ * full packet. Will return true if =
further reads are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 required and false otherwise. (full packet is ready)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * With UDP we always return true as there is no reassembl=
y.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * @param sb    the stream buffer =
that should be worked on</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @return      true if more reads are required.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+bool stream_buf_read_setup_dowork(struct stream_buf *sb);=
</span><br><span> </span><br><span> static inline bool</span><br><span> str=
eam_buf_read_setup(struct link_socket *sock)</span><br><span> {</span><br><=
span>     if (link_socket_connection_oriented(sock))</span><br><span>     {=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        return stream=
_buf_read_setup_dowork(sock);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        return stream_buf_read_setup_dowork(&amp;sock-&gt;stream_=
buf);</span><br><span>     }</span><br><span>     else</span><br><span>    =
 {</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1483?usp=3Demail">change 1483</a>. To unsubscri=
be, or for help writing mail filters, visit <a href=3D"http://gerrit.openvp=
n.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1483?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--NSkuJ3L8aSg=--

