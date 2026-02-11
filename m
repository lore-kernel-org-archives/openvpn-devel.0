From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 11 Feb 2026 11:33:51 +0000
In-Reply-To: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
References: <gerrit.1768930567000.I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <f10169dca19536ca6bff78015460c6eaacd05a1a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="1jbNyetRvUg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--1jbNyetRvUg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1483?usp=3Demail

to look at the new patch set (#4).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
2 files changed, 21 insertions(+), 11 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1483/4

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 58ccda9..c463041 100644
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
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--1jbNyetRvUg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #4</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1483?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Change stream_buf_read_setup=
_dowork parameter to struct steam_buf<br><br>This methods only ever access =
sock-&gt;stream_buf so make the method<br>simpler by just having a paramete=
r sb.<br><br>Change-Id: I3deb7cd75db3cb280fa8d9c637cd3bde3881d6e3<br>---<br=
>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>2 files changed, 21 in=
sertions(+), 11 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/83/1483/4</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/sr=
c/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index 58ccda9..c4=
63041 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><span>+++=
 b/src/openvpn/socket.c</span><br><span>@@ -2111,22 +2111,22 @@</span><br><=
span> }</span><br><span> </span><br><span> bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-stream_buf_read_setup_dowork(struct link_socket *=
sock)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+stream_buf_rea=
d_setup_dowork(struct stream_buf *sb)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (sock-&gt;stream_buf.residual.len=
 &amp;&amp; !sock-&gt;stream_buf.residual_fully_formed)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    if (sb-&gt;residual.len &amp;&amp; =
!sb-&gt;residual_fully_formed)</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_copy(&amp;sock-&gt;strea=
m_buf.buf, &amp;sock-&gt;stream_buf.residual));</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        ASSERT(buf_init(&amp;sock-&gt;stream_buf.=
residual, 0));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 sock-&gt;stream_buf.residual_fully_formed =3D stream_buf_added(&amp;sock-&=
gt;stream_buf, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
       ASSERT(buf_copy(&amp;sb-&gt;buf, &amp;sb-&gt;residual));</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(buf_init(&amp;sb=
-&gt;residual, 0));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        sb-&gt;residual_fully_formed =3D stream_buf_added(sb, 0);</span><br=
><span>         dmsg(D_STREAM_DEBUG, &quot;STREAM: RESIDUAL FULLY FORMED [%=
s], len=3D%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
           sock-&gt;stream_buf.residual_fully_formed ? &quot;YES&quot; : &q=
uot;NO&quot;, sock-&gt;stream_buf.residual.len);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+             sb-&gt;residual_fully_formed ? &q=
uot;YES&quot; : &quot;NO&quot;, sb-&gt;residual.len);</span><br><span>     =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  if (!sock-&gt;stream_buf.residual_fully_formed)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    if (!sb-&gt;residual_fully_formed)</span>=
<br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   stream_buf_set_next(&amp;sock-&gt;stream_buf);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        stream_buf_set_next(sb);</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return =
!sock-&gt;stream_buf.residual_fully_formed;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    return !sb-&gt;residual_fully_formed;</span><br=
><span> }</span><br><span> </span><br><span> static bool</span><br><span>di=
ff --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span>inde=
x 850064d..3f46dc6 100644</span><br><span>--- a/src/openvpn/socket.h</span>=
<br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -528,14 +528,24 @@<=
/span><br><span>     }</span><br><span> }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-bool stream_buf_read_setup_dowork(str=
uct link_socket *sock);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Will try =
to check if the buffers in stream form a</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * full packet. Will return true if further reads are<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * required and fals=
e otherwise. (full packet is ready)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* With UDP we always return true as there is no reassembly.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @param sb    the stream buffer that should be wor=
ked on</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @return   =
   true if more reads are required.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
bool stream_buf_read_setup_dowork(struct stream_buf *sb);</span><br><span> =
</span><br><span> static inline bool</span><br><span> stream_buf_read_setup=
(struct link_socket *sock)</span><br><span> {</span><br><span>     if (link=
_socket_connection_oriented(sock))</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        return stream_buf_read_setup_do=
work(sock);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
return stream_buf_read_setup_dowork(&amp;sock-&gt;stream_buf);</span><br><s=
pan>     }</span><br><span>     else</span><br><span>     {</span><br><span=
></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/1483?usp=3Demail">change 1483</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1483?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3deb7cd75db3cb280fa8d9c637c=
d3bde3881d6e3 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1483 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--1jbNyetRvUg=--

