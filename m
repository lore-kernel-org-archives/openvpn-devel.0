From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Thu, 22 Jan 2026 12:40:19 +0000
In-Reply-To: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
References: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <95ef10d73d30c19c17ce4ab18c80e4745406917b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uiRG7NbA3Os="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uiRG7NbA3Os=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


Change subject: Merge stream_buf_get_next and stream_buf_set_next
......................................................................

Merge stream_buf_get_next and stream_buf_set_next

The stream_buf_set_next prepares a buffer in the stream_buf
structure that will be retrieved by stream_buf_get the next
time it is used.

This temporary copy of the buffer is unnecessary as the buffer
next can also be constructed on the fly.

This also fixes a rare crash when read buffer are not initialised and
read is still signalled as the initialisation of next will now happen whene=
ver
it is required.

This assertion happens when we do not expect a read event from the socket a=
nd
then in link_socket_read_tcp the function stream_buf_get_next can trigger
an assert on ASSERT(buf_defined(&sb->next));

To avoid this weird corner case, just always initialise the read buffer
whether or not we expect a read to occur.

This also adds documentation about the methods and field associated with
the stream_buf structure.

Reproducing this bug requires very special circumstances. The reproduction =
is
   openvpn --cert server-secp384r1.crt  --key server-secp384r1.key \
   --dev ml-tan --dev-type tap --tun-mtu 1400 --config ~/fp --topology subn=
et \
   --port 2201 --verb 3  --mode server  --tls-server --proto tcp6-server
   --ifconfig 10.0.0.1 255.255.255.0

as the server side and

  openvpn --client --proto tcp --remote poseidon --port 2201 --dev tap

The client side must be on Linux. Other platforms do not reproduce this
bug.

Note that the client will not configure any IP or IPv6 on the interface
and will also not bring up the interface. The server must also send at least
one real data packet to the client (no keepalive ping). Just having the
interface up normally produces enough traffic.

Now forcefully reset the TCP connection. E.g. by executing on the server

    sudo ss --kill sport 2201

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
---
M src/openvpn/socket.c
M src/openvpn/socket.h
2 files changed, 90 insertions(+), 40 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1477/5

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index f8c0b5c..acdc9d8 100644
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
@@ -2065,13 +2063,19 @@
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

@@ -2093,19 +2097,35 @@
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
@@ -2114,33 +2134,42 @@
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
     if (sb->residual.len && !sb->residual_fully_formed)
     {
-        ASSERT(buf_copy(sb->buf, &sock->stream_buf.residual));
+        ASSERT(buf_copy(&sb->buf, &sb->residual));
         ASSERT(buf_init(&sb->residual, 0));
         sb->residual_fully_formed =3D stream_buf_added(sb, 0);
         dmsg(D_STREAM_DEBUG, "STREAM: RESIDUAL FULLY FORMED [%s], len=3D%d=
",
-             stream_buf->residual_fully_formed ? "YES" : "NO", sb->residua=
l.len);
+             sb->residual_fully_formed ? "YES" : "NO", sb->residual.len);
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
@@ -2203,7 +2232,6 @@
     else
     {
         dmsg(D_STREAM_DEBUG, "STREAM: ADD returned FALSE (have=3D%d need=
=3D%d)", sb->buf.len, sb->len);
-        stream_buf_set_next(sb);
         return false;
     }
 }
@@ -2273,8 +2301,7 @@
         sockethandle_t sh =3D { .s =3D sock->sd };
         len =3D sockethandle_finalize(sh, &sock->reads, buf, NULL);
 #else
-        struct buffer frag;
-        stream_buf_get_next(&sock->stream_buf, &frag);
+        struct buffer frag =3D stream_buf_get_next(&sock->stream_buf);
         len =3D recv(sock->sd, BPTR(&frag), BLEN(&frag), MSG_NOSIGNAL);
 #endif

@@ -2550,7 +2577,7 @@
         }
         else if (proto_is_tcp(sock->info.proto))
         {
-            stream_buf_get_next(&sock->stream_buf, &sock->reads.buf);
+            sock->reads.buf =3D stream_buf_get_next(&sock->stream_buf);
         }
         else
         {
diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 8664666f..ebaf776 100644
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
@@ -529,9 +547,14 @@
 }

 /**
+ * Will try to check if the buffers in stream form a
+ * full packet. Will return true if further reads are
+ * required and false otherwise. (full packet is ready)
  *
- * @param sock
- * @return
+ * With UDP we always return true as there is no reassembly.
+ *
+ * @param sb    the stream buffer that should be worked on
+ * @return      true if more reads are required.
  */
 bool stream_buf_read_setup_dowork(struct stream_buf *sb);


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc
Gerrit-Change-Number: 1477
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>

--uiRG7NbA3Os=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail">View Chan=
ge</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">Merge stream_buf_get_next an=
d stream_buf_set_next<br><br>The stream_buf_set_next prepares a buffer in t=
he stream_buf<br>structure that will be retrieved by stream_buf_get the nex=
t<br>time it is used.<br><br>This temporary copy of the buffer is unnecessa=
ry as the buffer<br>next can also be constructed on the fly.<br><br>This al=
so fixes a rare crash when read buffer are not initialised and<br>read is s=
till signalled as the initialisation of next will now happen whenever<br>it=
 is required.<br><br>This assertion happens when we do not expect a read ev=
ent from the socket and<br>then in link_socket_read_tcp the function stream=
_buf_get_next can trigger<br>an assert on ASSERT(buf_defined(&amp;sb-&gt;ne=
xt));<br><br>To avoid this weird corner case, just always initialise the re=
ad buffer<br>whether or not we expect a read to occur.<br><br>This also add=
s documentation about the methods and field associated with<br>the stream_b=
uf structure.<br><br>Reproducing this bug requires very special circumstanc=
es. The reproduction is<br>   openvpn --cert server-secp384r1.crt  --key se=
rver-secp384r1.key \<br>   --dev ml-tan --dev-type tap --tun-mtu 1400 --con=
fig ~/fp --topology subnet \<br>   --port 2201 --verb 3  --mode server  --t=
ls-server --proto tcp6-server<br>   --ifconfig 10.0.0.1 255.255.255.0<br><b=
r>as the server side and<br><br>  openvpn --client --proto tcp --remote pos=
eidon --port 2201 --dev tap<br><br>The client side must be on Linux. Other =
platforms do not reproduce this<br>bug.<br><br>Note that the client will no=
t configure any IP or IPv6 on the interface<br>and will also not bring up t=
he interface. The server must also send at least<br>one real data packet to=
 the client (no keepalive ping). Just having the<br>interface up normally p=
roduces enough traffic.<br><br>Now forcefully reset the TCP connection. E.g=
. by executing on the server<br><br>    sudo ss --kill sport 2201<br><br>Th=
is will now trigger the assertion. This happens since OpenVPN waits<br>fore=
ver to get a write back from the poll from the tun/tap device but<br>this n=
ever happens since the device is not up.<br><br>As long as we do not get ba=
ck the tun device for writing, we also do<br>not put the socket back into t=
he EVENT_READ state. And this also means<br>that code to initialise the rea=
d buffer (stream_buf_set_next) is never<br>run.<br><br>But the reset on the=
 TCP socket triggers the TCP socket to be available<br>for read, even if it=
 is just for a read of 0 bytes to indicate the reset.<br>So the function li=
nk_socket_read_tcp will run into the assert.<br><br>Change-Id: Ifd3e953104a=
67c8bf2a225e179865e3dbd0dbfbc<br>---<br>M src/openvpn/socket.c<br>M src/ope=
nvpn/socket.h<br>2 files changed, 90 insertions(+), 40 deletions(-)<br><br>=
</pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; whit=
e-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/ch=
anges/77/1477/5</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/src/openvpn/socket.c b/src/openvpn/soc=
ket.c</span><br><span>index f8c0b5c..acdc9d8 100644</span><br><span>--- a/s=
rc/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socket.c</span><br><s=
pan>@@ -44,9 +44,7 @@</span><br><span> bool</span><br><span> sockets_read_r=
esidual(const struct context *c)</span><br><span> {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
    for (i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; c-&gt;c1.=
link_sockets_num; i++)</span><br><span>     {</span><br><span>         if (=
c-&gt;c2.link_sockets[i]-&gt;stream_buf.residual_fully_formed)</span><br><s=
pan>         {</span><br><span>@@ -2065,13 +2063,19 @@</span><br><span>  * =
stream connection.</span><br><span>  */</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * resets the stream buffer to be set up for the next=
 round of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * reassem=
bling a packet</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * But still leaves th=
e current packet in \c sb-&gt;buf to be potentially</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * read.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ */</span><br><span> static inline void</span><br><s=
pan> stream_buf_reset(struct stream_buf *sb)</span><br><span> {</span><br><=
span>     dmsg(D_STREAM_DEBUG, &quot;STREAM: RESET&quot;);</span><br><span>=
     sb-&gt;residual_fully_formed =3D false;</span><br><span>     sb-&gt;bu=
f =3D sb-&gt;buf_init;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    buf_reset(&amp;sb-&gt;next);</span><br><span>     sb-&gt;len =3D -1;</=
span><br><span> }</span><br><span> </span><br><span>@@ -2093,19 +2097,35 @@=
</span><br><span>     dmsg(D_STREAM_DEBUG, &quot;STREAM: INIT maxlen=3D%d&q=
uot;, sb-&gt;maxlen);</span><br><span> }</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-static inline void</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-stream_buf_set_next(struct stream_buf *sb=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Return a buffer that is backed =
by the same backend as sb-&gt;buf that</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * determines where the next read should be done by also=
 having the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * right=
 offset into \c sb-&gt;buf.</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * @param sb the stream buffer from which to construct the next buf=
fer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static inline struct buffer</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+stream_buf_get_next(stru=
ct stream_buf *sb)</span><br><span> {</span><br><span>     /* set up &#39;n=
ext&#39; for next i/o read */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    sb-&gt;next =3D sb-&gt;buf;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    sb-&gt;next.offset =3D sb-&gt;buf.offset + sb-&gt;buf=
.len;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    sb-&gt;next.=
len =3D (sb-&gt;len &gt;=3D 0 ? sb-&gt;len : sb-&gt;maxlen) - sb-&gt;buf.le=
n;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_STREAM_D=
EBUG, &quot;STREAM: SET NEXT, buf=3D[%d,%d] next=3D[%d,%d] len=3D%d maxlen=
=3D%d&quot;,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-         =
sb-&gt;buf.offset, sb-&gt;buf.len, sb-&gt;next.offset, sb-&gt;next.len, sb-=
&gt;len, sb-&gt;maxlen);</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    ASSERT(sb-&gt;next.len &gt; 0);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ASSERT(buf_safe(&amp;sb-&gt;buf, sb-&gt;next.len));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer next=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    next =3D sb-&g=
t;buf;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    next.offs=
et =3D sb-&gt;buf.offset + sb-&gt;buf.len;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    next.len =3D (sb-&gt;len &gt;=3D 0 ? sb-&gt;len =
: sb-&gt;maxlen) - sb-&gt;buf.len;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    dmsg(D_STREAM_DEBUG, &quot;STREAM: GET NEXT, buf=3D[%d,%=
d] next=3D[%d,%d] len=3D%d maxlen=3D%d&quot;,</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+         sb-&gt;buf.offset, sb-&gt;buf.len, next.=
offset, next.len, sb-&gt;len, sb-&gt;maxlen);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    ASSERT(next.len &gt; 0);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    ASSERT(buf_safe(&amp;sb-&gt;buf, nex=
t.len));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    return =
next;</span><br><span> }</span><br><span> </span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * Sets the parameter buf to the current buffer of \c sb-&gt;buf.</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ * This function assum=
es that caller already checked if the packet in \c sb-&gt;buf</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+ * is fully assembled.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param sb    stream buffer to operate on</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param buf   buffer =
to point to the contents of buf</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span> static inline void</span><br><span> stream=
_buf_get_final(struct stream_buf *sb, struct buffer *buf)</span><br><span> =
{</span><br><span>@@ -2114,33 +2134,42 @@</span><br><span>     *buf =3D sb-=
&gt;buf;</span><br><span> }</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-static inline void</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-stream_buf_get_next(struct stream_buf *sb, struct buff=
er *buf)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    dmsg(D_STREAM_DEBUG, &quot;ST=
REAM: GET NEXT len=3D%d&quot;, buf_defined(&amp;sb-&gt;next) ? sb-&gt;next.=
len : -1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(=
buf_defined(&amp;sb-&gt;next));</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    *buf =3D sb-&gt;next;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> bool</span><br><span> stream_buf_read_setup_dowork(struct strea=
m_buf *sb)</span><br><span> {</span><br><span>     if (sb-&gt;residual.len =
&amp;&amp; !sb-&gt;residual_fully_formed)</span><br><span>     {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-        ASSERT(buf_copy(sb-&gt;b=
uf, &amp;sock-&gt;stream_buf.residual));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        ASSERT(buf_copy(&amp;sb-&gt;buf, &amp;sb-&gt;r=
esidual));</span><br><span>         ASSERT(buf_init(&amp;sb-&gt;residual, 0=
));</span><br><span>         sb-&gt;residual_fully_formed =3D stream_buf_ad=
ded(sb, 0);</span><br><span>         dmsg(D_STREAM_DEBUG, &quot;STREAM: RES=
IDUAL FULLY FORMED [%s], len=3D%d&quot;,</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-             stream_buf-&gt;residual_fully_formed ? &quo=
t;YES&quot; : &quot;NO&quot;, sb-&gt;residual.len);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+             sb-&gt;residual_fully_formed=
 ? &quot;YES&quot; : &quot;NO&quot;, sb-&gt;residual.len);</span><br><span>=
     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-    if (!sb-&gt;residual_fully_formed)</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    {</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-        stream_buf_set_next(sb);</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    }</span><br><span>     return !sb-&gt;residual_fully_for=
med;</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * This will determine if \c sb-&gt;buf contains a full packet. It wi=
ll also</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * move anyt=
hing in \c sb-&gt;buf beyond a full packet to \c sb-&gt;residual.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ * The first time the function is called with =
a valid buffer and port sharing</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ * is enabled, the function will also determine if the buffer c=
ontains</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * OpenVPN p=
rotocol data and store the result in \c sb-&gt;port_share_state.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * If a packet outside the allowed range is det=
ected, the error state</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * on \c sb is set.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Since the b=
uffer in \c sb-&gt;buf is modified from the outside (via</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * \c stream_buf_get_next) the paramet=
er \p length_added needs to be set</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ * to the amount of bytes that have been written to this buf=
fer. If the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * buffe=
r was not modified but should still be analysed and potentially</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * split to \c sb-&gt;residual,=
 the parameter \p length_added should be 0.</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ * @param sb the stream buffer</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ * @param length_added The length that has been added to =
\c sb-&gt;buf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @re=
turn true if \c sb-&gt;buf contains fully reassembled packet</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static bool</=
span><br><span> stream_buf_added(struct stream_buf *sb, int length_added)</=
span><br><span> {</span><br><span>@@ -2203,7 +2232,6 @@</span><br><span>   =
  else</span><br><span>     {</span><br><span>         dmsg(D_STREAM_DEBUG,=
 &quot;STREAM: ADD returned FALSE (have=3D%d need=3D%d)&quot;, sb-&gt;buf.l=
en, sb-&gt;len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-     =
   stream_buf_set_next(sb);</span><br><span>         return false;</span><b=
r><span>     }</span><br><span> }</span><br><span>@@ -2273,8 +2301,7 @@</sp=
an><br><span>         sockethandle_t sh =3D { .s =3D sock-&gt;sd };</span><=
br><span>         len =3D sockethandle_finalize(sh, &amp;sock-&gt;reads, bu=
f, NULL);</span><br><span> #else</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-        struct buffer frag;</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        stream_buf_get_next(&amp;sock-&gt;stream_buf, &amp=
;frag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        stru=
ct buffer frag =3D stream_buf_get_next(&amp;sock-&gt;stream_buf);</span><br=
><span>         len =3D recv(sock-&gt;sd, BPTR(&amp;frag), BLEN(&amp;frag),=
 MSG_NOSIGNAL);</span><br><span> #endif</span><br><span> </span><br><span>@=
@ -2550,7 +2577,7 @@</span><br><span>         }</span><br><span>         el=
se if (proto_is_tcp(sock-&gt;info.proto))</span><br><span>         {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-            stream_buf_get_n=
ext(&amp;sock-&gt;stream_buf, &amp;sock-&gt;reads.buf);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+            sock-&gt;reads.buf =3D stre=
am_buf_get_next(&amp;sock-&gt;stream_buf);</span><br><span>         }</span=
><br><span>         else</span><br><span>         {</span><br><span>diff --=
git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span>index 866=
4666f..ebaf776 100644</span><br><span>--- a/src/openvpn/socket.h</span><br>=
<span>+++ b/src/openvpn/socket.h</span><br><span>@@ -95,23 +95,41 @@</span>=
<br><span>     int mtu_changed; /* Set to true when mtu value is changed */=
</span><br><span> };</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Used to extract packets encapsulated in streams into a buffer,</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * in this case IP packets embedd=
ed in a TCP stream.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * struct used t=
o extract packets encapsulated in streams into a buffer,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * in this case OpenVPN packets (data =
or control) embedded in a TCP stream.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * This struct is used to packetise the TCP stream into the</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * OpenVPN packet. Each OpenVPN pa=
cket has a two-byte header determining</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * the length of the packet.</span><br><span>  */</span>=
<br><span> struct stream_buf</span><br><span> {</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* Buffer to hold the initial buffer that w=
ill be used to reset buf */</span><br><span>     struct buffer buf_init;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /** buffer holding the excess bytes t=
hat are not part of the</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+     *  packet. */</span><br><span>     struct buffer residual;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /** Maximum length of a packet that we acc=
ept */</span><br><span>     int maxlen;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /** The buffer in buf contains a full packet without a header. Any</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+     * extra data is in=
 residual */</span><br><span>     bool residual_fully_formed;</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** Holds t=
he data of the current packet. This might be a partial packet */</span><br>=
<span>     struct buffer buf;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    struct buffer next;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    int len;    /* -1 if not yet known */</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool error; /* if true,=
 fatal TCP error has occurred,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                 *  requiring that connection be restarted */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** -1 if not yet kn=
own. Otherwise holds the length of the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+     *   packet. If &gt;=3D 0, buf is already moved past=
 the initial</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * =
 size header */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
int len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    /** if true, a fatal TCP e=
rror has occurred,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    *  requiring that connection be restarted */</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    bool error;</span><br><span> #if PORT_SHAR=
E</span><br><span> #define PS_DISABLED 0</span><br><span> #define PS_ENABLE=
D  1</span><br><span>@@ -529,9 +547,14 @@</span><br><span> }</span><br><spa=
n> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * Will try to check if the buffers in stream form a</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ * full packet. Will return true if f=
urther reads are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
required and false otherwise. (full packet is ready)</span><br><span>  *</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param sock</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">- * @return</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ * With UDP we always return true as the=
re is no reassembly.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sb    =
the stream buffer that should be worked on</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * @return      true if more reads are required.</sp=
an><br><span>  */</span><br><span> bool stream_buf_read_setup_dowork(struct=
 stream_buf *sb);</span><br><span> </span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Dema=
il">change 1477</a>. To unsubscribe, or for help writing mail filters, visi=
t <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail"=
/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e1798=
65e3dbd0dbfbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1477 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--uiRG7NbA3Os=--

