From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Mar 2026 10:44:01 +0000
In-Reply-To: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
References: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0cd503f123d65986cb19bdb1b6567d11b4d74aa5-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="WtSvHgdRTRw="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Merge
 stream_buf_get_next and stream_buf_set_next
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

--WtSvHgdRTRw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
77?usp=3Demail )

Change subject: Merge stream_buf_get_next and stream_buf_set_next
......................................................................

Merge stream_buf_get_next and stream_buf_set_next

The stream_buf_set_next prepares a buffer in the stream_buf
structure that will be retrieved by stream_buf_get the next
time it is used.

This temporary copy of the buffer is unnecessary as the buffer
next can also be constructed on the fly.

This also fixes a rare crash when read buffer are not initialised and
read is still signalled as the initialisation of next will now happen
whenever it is required.

This assertion happens when we do not expect a read event from the socket
and then in link_socket_read_tcp the function stream_buf_get_next can
trigger an assert on ASSERT(buf_defined(&sb->next));

To avoid this weird corner case, just always initialise the read buffer
whether or not we expect a read to occur.

This also adds documentation about the methods and field associated with
the stream_buf structure.

Reproducing this bug requires very special circumstances.  To reproduce,
run a client with

    openvpn --client --proto tcp --dev tap --ifconfig noexec ...

The client side must be on Linux. Other platforms do not reproduce this
bug.

Note that the client will not configure any IP or IPv6 on the interface
and will also not bring up the interface. The server must also send at least
one real data packet to the client (no keepalive ping). Just having the
interface up normally produces enough traffic.

Now forcefully reset the TCP connection. E.g. by executing on the client

    sudo ss --kill dport <server port>

This will now trigger the assertion. This happens since OpenVPN waits
forever to get a write back from the poll from the tun/tap device but
this never happens since the device is not up.

As long as we do not get back the tun device for writing, we also do
not put the socket back into the EVENT_READ state. And this also means
that code to initialise the read buffer (stream_buf_set_next) is never
run.

But the reset on the TCP socket triggers the TCP socket to be available
for read, even if it is just for a read of 0 bytes to indicate the reset.
So the function link_socket_read_tcp will run into the assert.

Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1477
Message-Id: <20260216162236.22304-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
673.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/socket.c
M src/openvpn/socket.h
2 files changed, 81 insertions(+), 36 deletions(-)




diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 033444e..1df1001 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -44,9 +44,7 @@
 bool
 sockets_read_residual(const struct context *c)
 {
-    int i;
-
-    for (i =3D 0; i < c->c1.link_sockets_num; i++)
+    for (int i =3D 0; i < c->c1.link_sockets_num; i++)
     {
         if (c->c2.link_sockets[i]->stream_buf.residual_fully_formed)
         {
@@ -2053,13 +2051,19 @@
  * stream connection.
  */

+/**
+ * resets the stream buffer to be set up for the next round of
+ * reassembling a packet
+ *
+ * But still leaves the current packet in \c sb->buf to be potentially
+ * read.
+ */
 static inline void
 stream_buf_reset(struct stream_buf *sb)
 {
     dmsg(D_STREAM_DEBUG, "STREAM: RESET");
     sb->residual_fully_formed =3D false;
     sb->buf =3D sb->buf_init;
-    buf_reset(&sb->next);
     sb->len =3D -1;
 }

@@ -2081,19 +2085,35 @@
     dmsg(D_STREAM_DEBUG, "STREAM: INIT maxlen=3D%d", sb->maxlen);
 }

-static inline void
-stream_buf_set_next(struct stream_buf *sb)
+/**
+ * Return a buffer that is backed by the same backend as sb->buf that
+ * determines where the next read should be done by also having the
+ * right offset into \c sb->buf.
+ * @param sb the stream buffer from which to construct the next buffer
+ */
+static inline struct buffer
+stream_buf_get_next(struct stream_buf *sb)
 {
     /* set up 'next' for next i/o read */
-    sb->next =3D sb->buf;
-    sb->next.offset =3D sb->buf.offset + sb->buf.len;
-    sb->next.len =3D (sb->len >=3D 0 ? sb->len : sb->maxlen) - sb->buf.len;
-    dmsg(D_STREAM_DEBUG, "STREAM: SET NEXT, buf=3D[%d,%d] next=3D[%d,%d] l=
en=3D%d maxlen=3D%d",
-         sb->buf.offset, sb->buf.len, sb->next.offset, sb->next.len, sb->l=
en, sb->maxlen);
-    ASSERT(sb->next.len > 0);
-    ASSERT(buf_safe(&sb->buf, sb->next.len));
+    struct buffer next;
+    next =3D sb->buf;
+    next.offset =3D sb->buf.offset + sb->buf.len;
+    next.len =3D (sb->len >=3D 0 ? sb->len : sb->maxlen) - sb->buf.len;
+    dmsg(D_STREAM_DEBUG, "STREAM: GET NEXT, buf=3D[%d,%d] next=3D[%d,%d] l=
en=3D%d maxlen=3D%d",
+         sb->buf.offset, sb->buf.len, next.offset, next.len, sb->len, sb->=
maxlen);
+    ASSERT(next.len > 0);
+    ASSERT(buf_safe(&sb->buf, next.len));
+    return next;
 }

+/**
+ * Sets the parameter buf to the current buffer of \c sb->buf.
+ * This function assumes that caller already checked if the packet in \c s=
b->buf
+ * is fully assembled.
+ *
+ * @param sb    stream buffer to operate on
+ * @param buf   buffer to point to the contents of buf
+ */
 static inline void
 stream_buf_get_final(struct stream_buf *sb, struct buffer *buf)
 {
@@ -2102,14 +2122,6 @@
     *buf =3D sb->buf;
 }

-static inline void
-stream_buf_get_next(struct stream_buf *sb, struct buffer *buf)
-{
-    dmsg(D_STREAM_DEBUG, "STREAM: GET NEXT len=3D%d", buf_defined(&sb->nex=
t) ? sb->next.len : -1);
-    ASSERT(buf_defined(&sb->next));
-    *buf =3D sb->next;
-}
-
 bool
 stream_buf_read_setup_dowork(struct stream_buf *sb)
 {
@@ -2122,13 +2134,30 @@
              sb->residual_fully_formed ? "YES" : "NO", sb->residual.len);
     }

-    if (!sb->residual_fully_formed)
-    {
-        stream_buf_set_next(sb);
-    }
     return !sb->residual_fully_formed;
 }

+/**
+ * This will determine if \c sb->buf contains a full packet. It will also
+ * move anything in \c sb->buf beyond a full packet to \c sb->residual.
+ *
+ * The first time the function is called with a valid buffer and port shar=
ing
+ * is enabled, the function will also determine if the buffer contains
+ * OpenVPN protocol data and store the result in \c sb->port_share_state.
+ *
+ * If a packet outside the allowed range is detected, the error state
+ * on \c sb is set.
+ *
+ * Since the buffer in \c sb->buf is modified from the outside (via
+ * \c stream_buf_get_next) the parameter \p length_added needs to be set
+ * to the amount of bytes that have been written to this buffer. If the
+ * buffer was not modified but should still be analysed and potentially
+ * split to \c sb->residual, the parameter \p length_added should be 0.
+ *
+ * @param sb the stream buffer
+ * @param length_added The length that has been added to \c sb->buf
+ * @return true if \c sb->buf contains fully reassembled packet
+ */
 static bool
 stream_buf_added(struct stream_buf *sb, int length_added)
 {
@@ -2191,7 +2220,6 @@
     else
     {
         dmsg(D_STREAM_DEBUG, "STREAM: ADD returned FALSE (have=3D%d need=
=3D%d)", sb->buf.len, sb->len);
-        stream_buf_set_next(sb);
         return false;
     }
 }
@@ -2261,8 +2289,7 @@
         sockethandle_t sh =3D { .s =3D sock->sd };
         len =3D sockethandle_finalize(sh, &sock->reads, buf, NULL);
 #else
-        struct buffer frag;
-        stream_buf_get_next(&sock->stream_buf, &frag);
+        struct buffer frag =3D stream_buf_get_next(&sock->stream_buf);
         len =3D recv(sock->sd, BPTR(&frag), BLEN(&frag), MSG_NOSIGNAL);
 #endif

@@ -2538,7 +2565,7 @@
         }
         else if (proto_is_tcp(sock->info.proto))
         {
-            stream_buf_get_next(&sock->stream_buf, &sock->reads.buf);
+            sock->reads.buf =3D stream_buf_get_next(&sock->stream_buf);
         }
         else
         {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 3f46dc6..ebaf776 100644
--- a/src/openvpn/socket.h
+++ b/src/openvpn/socket.h
@@ -95,23 +95,41 @@
     int mtu_changed; /* Set to true when mtu value is changed */
 };

-/*
- * Used to extract packets encapsulated in streams into a buffer,
- * in this case IP packets embedded in a TCP stream.
+/**
+ * struct used to extract packets encapsulated in streams into a buffer,
+ * in this case OpenVPN packets (data or control) embedded in a TCP stream.
+ *
+ * This struct is used to packetise the TCP stream into the
+ * OpenVPN packet. Each OpenVPN packet has a two-byte header determining
+ * the length of the packet.
  */
 struct stream_buf
 {
+    /* Buffer to hold the initial buffer that will be used to reset buf */
     struct buffer buf_init;
+
+    /** buffer holding the excess bytes that are not part of the
+     *  packet. */
     struct buffer residual;
+
+    /** Maximum length of a packet that we accept */
     int maxlen;
+
+    /** The buffer in buf contains a full packet without a header. Any
+     * extra data is in residual */
     bool residual_fully_formed;

+    /** Holds the data of the current packet. This might be a partial pack=
et */
     struct buffer buf;
-    struct buffer next;
-    int len;    /* -1 if not yet known */

-    bool error; /* if true, fatal TCP error has occurred,
-                 *  requiring that connection be restarted */
+    /** -1 if not yet known. Otherwise holds the length of the
+     *   packet. If >=3D 0, buf is already moved past the initial
+     *  size header */
+    int len;
+
+    /** if true, a fatal TCP error has occurred,
+     *  requiring that connection be restarted */
+    bool error;
 #if PORT_SHARE
 #define PS_DISABLED 0
 #define PS_ENABLED  1

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc
Gerrit-Change-Number: 1477
Gerrit-PatchSet: 8
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--WtSvHgdRTRw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1477?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Merge stream_buf_get_next and stream_buf_set_nex=
t<br><br>The stream_buf_set_next prepares a buffer in the stream_buf<br>str=
ucture that will be retrieved by stream_buf_get the next<br>time it is used=
.<br><br>This temporary copy of the buffer is unnecessary as the buffer<br>=
next can also be constructed on the fly.<br><br>This also fixes a rare cras=
h when read buffer are not initialised and<br>read is still signalled as th=
e initialisation of next will now happen<br>whenever it is required.<br><br=
>This assertion happens when we do not expect a read event from the socket<=
br>and then in link_socket_read_tcp the function stream_buf_get_next can<br=
>trigger an assert on ASSERT(buf_defined(&amp;sb-&gt;next));<br><br>To avoi=
d this weird corner case, just always initialise the read buffer<br>whether=
 or not we expect a read to occur.<br><br>This also adds documentation abou=
t the methods and field associated with<br>the stream_buf structure.<br><br=
>Reproducing this bug requires very special circumstances.  To reproduce,<b=
r>run a client with<br><br>    openvpn --client --proto tcp --dev tap --ifc=
onfig noexec ...<br><br>The client side must be on Linux. Other platforms d=
o not reproduce this<br>bug.<br><br>Note that the client will not configure=
 any IP or IPv6 on the interface<br>and will also not bring up the interfac=
e. The server must also send at least<br>one real data packet to the client=
 (no keepalive ping). Just having the<br>interface up normally produces eno=
ugh traffic.<br><br>Now forcefully reset the TCP connection. E.g. by execut=
ing on the client<br><br>    sudo ss --kill dport &lt;server port&gt;<br><b=
r>This will now trigger the assertion. This happens since OpenVPN waits<br>=
forever to get a write back from the poll from the tun/tap device but<br>th=
is never happens since the device is not up.<br><br>As long as we do not ge=
t back the tun device for writing, we also do<br>not put the socket back in=
to the EVENT_READ state. And this also means<br>that code to initialise the=
 read buffer (stream_buf_set_next) is never<br>run.<br><br>But the reset on=
 the TCP socket triggers the TCP socket to be available<br>for read, even i=
f it is just for a read of 0 bytes to indicate the reset.<br>So the functio=
n link_socket_read_tcp will run into the assert.<br><br>Change-Id: Ifd3e953=
104a67c8bf2a225e179865e3dbd0dbfbc<br>Signed-off-by: Arne Schwabe &lt;arne-o=
penvpn@...1227...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1477<br>Message-Id=
: &lt;20260216162236.22304-1-gert@...1296...&gt;<br>URL: https://www.mail-a=
rchive.com/openvpn-devel@lists.sourceforge.net/msg35673.html<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/socket.c<b=
r>M src/openvpn/socket.h<br>2 files changed, 81 insertions(+), 36 deletions=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span=
>index 033444e..1df1001 100644</span><br><span>--- a/src/openvpn/socket.c</=
span><br><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -44,9 +44,7 @@=
</span><br><span> bool</span><br><span> sockets_read_residual(const struct =
context *c)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt=
; c-&gt;c1.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)<=
/span><br><span>     {</span><br><span>         if (c-&gt;c2.link_sockets[i=
]-&gt;stream_buf.residual_fully_formed)</span><br><span>         {</span><b=
r><span>@@ -2053,13 +2051,19 @@</span><br><span>  * stream connection.</spa=
n><br><span>  */</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
* resets the stream buffer to be set up for the next round of</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * reassembling a packet</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ * But still leaves the current packet in \c =
sb-&gt;buf to be potentially</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * read.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
/</span><br><span> static inline void</span><br><span> stream_buf_reset(str=
uct stream_buf *sb)</span><br><span> {</span><br><span>     dmsg(D_STREAM_D=
EBUG, &quot;STREAM: RESET&quot;);</span><br><span>     sb-&gt;residual_full=
y_formed =3D false;</span><br><span>     sb-&gt;buf =3D sb-&gt;buf_init;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_reset(&amp;sb-&g=
t;next);</span><br><span>     sb-&gt;len =3D -1;</span><br><span> }</span><=
br><span> </span><br><span>@@ -2081,19 +2085,35 @@</span><br><span>     dms=
g(D_STREAM_DEBUG, &quot;STREAM: INIT maxlen=3D%d&quot;, sb-&gt;maxlen);</sp=
an><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-static inline void</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-stream_buf_set_next(struct stream_buf *sb)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * Return a buffer that is backed by the same backend as =
sb-&gt;buf that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * d=
etermines where the next read should be done by also having the</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * right offset into \c sb-&gt;=
buf.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sb th=
e stream buffer from which to construct the next buffer</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+static inline struct buffer</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+stream_buf_get_next(struct stream_buf *sb)</spa=
n><br><span> {</span><br><span>     /* set up &#39;next&#39; for next i/o r=
ead */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sb-&gt;next=
 =3D sb-&gt;buf;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    s=
b-&gt;next.offset =3D sb-&gt;buf.offset + sb-&gt;buf.len;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    sb-&gt;next.len =3D (sb-&gt;len &gt=
;=3D 0 ? sb-&gt;len : sb-&gt;maxlen) - sb-&gt;buf.len;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_STREAM_DEBUG, &quot;STREAM: SET=
 NEXT, buf=3D[%d,%d] next=3D[%d,%d] len=3D%d maxlen=3D%d&quot;,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-         sb-&gt;buf.offset, sb-&g=
t;buf.len, sb-&gt;next.offset, sb-&gt;next.len, sb-&gt;len, sb-&gt;maxlen);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(sb-&gt;nex=
t.len &gt; 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASS=
ERT(buf_safe(&amp;sb-&gt;buf, sb-&gt;next.len));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    struct buffer next;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    next =3D sb-&gt;buf;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    next.offset =3D sb-&gt;buf.offse=
t + sb-&gt;buf.len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    next.len =3D (sb-&gt;len &gt;=3D 0 ? sb-&gt;len : sb-&gt;maxlen) - sb-&=
gt;buf.len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg=
(D_STREAM_DEBUG, &quot;STREAM: GET NEXT, buf=3D[%d,%d] next=3D[%d,%d] len=
=3D%d maxlen=3D%d&quot;,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+         sb-&gt;buf.offset, sb-&gt;buf.len, next.offset, next.len, sb-=
&gt;len, sb-&gt;maxlen);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    ASSERT(next.len &gt; 0);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    ASSERT(buf_safe(&amp;sb-&gt;buf, next.len));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return next;</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Sets the pa=
rameter buf to the current buffer of \c sb-&gt;buf.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This function assumes that caller alre=
ady checked if the packet in \c sb-&gt;buf</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * is fully assembled.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * @param sb    stream buffer to operate on</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param buf   buffer to point to the co=
ntents of buf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</s=
pan><br><span> static inline void</span><br><span> stream_buf_get_final(str=
uct stream_buf *sb, struct buffer *buf)</span><br><span> {</span><br><span>=
@@ -2102,14 +2122,6 @@</span><br><span>     *buf =3D sb-&gt;buf;</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-static inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-stream_buf_get_next(struct stream_buf *sb, struct buffer *buf)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    dmsg(D_STREAM_DEBUG, &quot;STREAM: GET NEXT len=
=3D%d&quot;, buf_defined(&amp;sb-&gt;next) ? sb-&gt;next.len : -1);</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_defined(&amp;s=
b-&gt;next));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    *buf=
 =3D sb-&gt;next;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> bool</=
span><br><span> stream_buf_read_setup_dowork(struct stream_buf *sb)</span><=
br><span> {</span><br><span>@@ -2122,13 +2134,30 @@</span><br><span>       =
       sb-&gt;residual_fully_formed ? &quot;YES&quot; : &quot;NO&quot;, sb-=
&gt;residual.len);</span><br><span>     }</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    if (!sb-&gt;residual_fully_formed=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        stream_buf_set_next(sb);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>   =
  return !sb-&gt;residual_fully_formed;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * This will determine if \c sb-&g=
t;buf contains a full packet. It will also</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * move anything in \c sb-&gt;buf beyond a full pack=
et to \c sb-&gt;residual.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * The firs=
t time the function is called with a valid buffer and port sharing</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ * is enabled, the function =
will also determine if the buffer contains</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * OpenVPN protocol data and store the result in \c =
sb-&gt;port_share_state.</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If a pack=
et outside the allowed range is detected, the error state</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * on \c sb is set.</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ * Since the buffer in \c sb-&gt;buf is modified from =
the outside (via</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
\c stream_buf_get_next) the parameter \p length_added needs to be set</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * to the amount of bytes=
 that have been written to this buffer. If the</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * buffer was not modified but should still be a=
nalysed and potentially</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+ * split to \c sb-&gt;residual, the parameter \p length_added should be=
 0.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * @param sb the stream buffer</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param length_added=
 The length that has been added to \c sb-&gt;buf</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * @return true if \c sb-&gt;buf contains full=
y reassembled packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ */</span><br><span> static bool</span><br><span> stream_buf_added(struct =
stream_buf *sb, int length_added)</span><br><span> {</span><br><span>@@ -21=
91,7 +2220,6 @@</span><br><span>     else</span><br><span>     {</span><br>=
<span>         dmsg(D_STREAM_DEBUG, &quot;STREAM: ADD returned FALSE (have=
=3D%d need=3D%d)&quot;, sb-&gt;buf.len, sb-&gt;len);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        stream_buf_set_next(sb);</span><br>=
<span>         return false;</span><br><span>     }</span><br><span> }</spa=
n><br><span>@@ -2261,8 +2289,7 @@</span><br><span>         sockethandle_t s=
h =3D { .s =3D sock-&gt;sd };</span><br><span>         len =3D sockethandle=
_finalize(sh, &amp;sock-&gt;reads, buf, NULL);</span><br><span> #else</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        struct buffer frag;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        stream_buf_ge=
t_next(&amp;sock-&gt;stream_buf, &amp;frag);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        struct buffer frag =3D stream_buf_get_next=
(&amp;sock-&gt;stream_buf);</span><br><span>         len =3D recv(sock-&gt;=
sd, BPTR(&amp;frag), BLEN(&amp;frag), MSG_NOSIGNAL);</span><br><span> #endi=
f</span><br><span> </span><br><span>@@ -2538,7 +2565,7 @@</span><br><span> =
        }</span><br><span>         else if (proto_is_tcp(sock-&gt;info.prot=
o))</span><br><span>         {</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-            stream_buf_get_next(&amp;sock-&gt;stream_buf, &amp;soc=
k-&gt;reads.buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          sock-&gt;reads.buf =3D stream_buf_get_next(&amp;sock-&gt;stream_b=
uf);</span><br><span>         }</span><br><span>         else</span><br><sp=
an>         {</span><br><span>diff --git a/src/openvpn/socket.h b/src/openv=
pn/socket.h</span><br><span>index 3f46dc6..ebaf776 100644</span><br><span>-=
-- a/src/openvpn/socket.h</span><br><span>+++ b/src/openvpn/socket.h</span>=
<br><span>@@ -95,23 +95,41 @@</span><br><span>     int mtu_changed; /* Set =
to true when mtu value is changed */</span><br><span> };</span><br><span> <=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">- * Used to extract packets encapsulated i=
n streams into a buffer,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">- * in this case IP packets embedded in a TCP stream.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * struct used to extract packets encapsulated in strea=
ms into a buffer,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 in this case OpenVPN packets (data or control) embedded in a TCP stream.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * This struct is used to packetise th=
e TCP stream into the</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * OpenVPN packet. Each OpenVPN packet has a two-byte header determining<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * the length of the=
 packet.</span><br><span>  */</span><br><span> struct stream_buf</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Buff=
er to hold the initial buffer that will be used to reset buf */</span><br><=
span>     struct buffer buf_init;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /=
** buffer holding the excess bytes that are not part of the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+     *  packet. */</span><br><span>=
     struct buffer residual;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Ma=
ximum length of a packet that we accept */</span><br><span>     int maxlen;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    /** The buffer in buf contains a f=
ull packet without a header. Any</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+     * extra data is in residual */</span><br><span>     bool =
residual_fully_formed;</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /** Holds the data of the current packet. This mig=
ht be a partial packet */</span><br><span>     struct buffer buf;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    struct buffer next;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int len;    /* -1 if not =
yet known */</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    bool error; /* if true, fatal TCP error has occurred,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                 *  requiring =
that connection be restarted */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /** -1 if not yet known. Otherwise holds the length of the<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+     *   packet. If =
&gt;=3D 0, buf is already moved past the initial</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+     *  size header */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    int len;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /** if true, a fatal TCP error has occurred,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+     *  requiring that connection be r=
estarted */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bool=
 error;</span><br><span> #if PORT_SHARE</span><br><span> #define PS_DISABLE=
D 0</span><br><span> #define PS_ENABLED  1</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?us=
p=3Demail">change 1477</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e1798=
65e3dbd0dbfbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1477 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--WtSvHgdRTRw=--

