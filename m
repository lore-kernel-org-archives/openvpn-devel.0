From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Tue, 20 Jan 2026 17:36:07 +0000
In-Reply-To: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
References: <gerrit.1768830991000.Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <84d7f9e351466d8457cc08268576ce18d8faf6c6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9F2BdizGJCQ="; charset=UTF-8
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

--9F2BdizGJCQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail

to look at the new patch set (#2).


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

The client side must be on Linux. Other platform do not reproduce this
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
So the link_socket_read_tcp will run into the assert.

Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc
---
M src/openvpn/socket.c
M src/openvpn/socket.h
2 files changed, 83 insertions(+), 39 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/1477/2

diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index f8c0b5c..0c11f6e 100644
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
+ * resets the stream buffer to be setup for the next round of
+ * reassembling a packet
+ *
+ * But still leaves the current packet in sb->buf to be potentially
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
+ * right offset into sb->buf
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
+ * Sets the parameter buf to  the current buffer of sb->buf.
+ * This function assumes that caller already checked if the packet in sb->=
buf
+ * is fully assembled.
+ *
+ * @param sb    stream buffer to operate on
+ * @param buf   buffer to point to the contents of buf
+ */
 static inline void
 stream_buf_get_final(struct stream_buf *sb, struct buffer *buf)
 {
@@ -2114,33 +2134,36 @@
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
+ * This will determine if sb->buf contains a full packet. It will also
+ * move anything in sb->buf beyond a full beyond packet to sb->residual
+ *
+ * If this is the first time the function is called with a valid buffer
+ * and port sharing is enabled the function will also determine if this
+ * is OpenVPN protocol or not and store the result in sb->port_share_state.
+ *
+ * If a packet is outside of the allowed range is detected, the error state
+ * on sb is set.
+ *
+ * @param sb the stream buffer
+ * @param length_added The length that has been added to sb->buf
+ * @return true if sb->buf contains fully reassembled packet
+ */
 static bool
 stream_buf_added(struct stream_buf *sb, int length_added)
 {
@@ -2203,7 +2226,6 @@
     else
     {
         dmsg(D_STREAM_DEBUG, "STREAM: ADD returned FALSE (have=3D%d need=
=3D%d)", sb->buf.len, sb->len);
-        stream_buf_set_next(sb);
         return false;
     }
 }
@@ -2273,8 +2295,7 @@
         sockethandle_t sh =3D { .s =3D sock->sd };
         len =3D sockethandle_finalize(sh, &sock->reads, buf, NULL);
 #else
-        struct buffer frag;
-        stream_buf_get_next(&sock->stream_buf, &frag);
+        struct buffer frag =3D stream_buf_get_next(&sock->stream_buf);
         len =3D recv(sock->sd, BPTR(&frag), BLEN(&frag), MSG_NOSIGNAL);
 #endif

diff --git a/src/openvpn/socket.h b/src/openvpn/socket.h
index 8664666f..f2bf906 100644
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
+ * required and other false. (full packet is ready)
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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--9F2BdizGJCQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demail">View Chan=
ge</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;">Merge stream_buf_get_next and stream_buf_set_next<b=
r><br>The stream_buf_set_next prepares a buffer in the stream_buf<br>struct=
ure that will be retrieved by stream_buf_get the next<br>time it is used.<b=
r><br>This temporary copy of the buffer is unnecessary as the buffer<br>nex=
t can also be constructed on the fly.<br><br>This also fixes a rare crash w=
hen read buffer are not initialised and<br>read is still signalled as the i=
nitialisation of next will now happen whenever<br>it is required.<br><br>Th=
is assertion happens when we do not expect a read event from the socket and=
<br>then in link_socket_read_tcp the function stream_buf_get_next can trigg=
er<br>an assert on ASSERT(buf_defined(&amp;sb-&gt;next));<br><br>To avoid t=
his weird corner case, just always initialise the read buffer<br>whether or=
 not we expect a read to occur.<br><br>This also adds documentation about t=
he methods and field associated with<br>the stream_buf structure.<br><br>Re=
producing this bug requires very special circumstances. The reproduction is=
<br>   openvpn --cert server-secp384r1.crt  --key server-secp384r1.key \<br=
>   --dev ml-tan --dev-type tap --tun-mtu 1400 --config ~/fp --topology sub=
net \<br>   --port 2201 --verb 3  --mode server  --tls-server --proto tcp6-=
server<br>   --ifconfig 10.0.0.1 255.255.255.0<br><br>as the server side an=
d<br><br>  openvpn --client --proto tcp --remote poseidon --port 2201 --dev=
 tap<br><br>The client side must be on Linux. Other platform do not reprodu=
ce this<br>bug.<br><br>Note that the client will not configure any IP or IP=
v6 on the interface<br>and will also not bring up the interface. The server=
 must also send at least<br>one real data packet to the client (no keepaliv=
e ping). Just having the<br>interface up normally produces enough traffic.<=
br><br>Now forcefully reset the TCP connection. E.g. by executing on the se=
rver<br><br>    sudo ss --kill sport 2201<br><br>This will now trigger the =
assertion. This happens since OpenVPN waits<br>forever to get a write back =
from the poll from the tun/tap device but<br>this never happens since the d=
evice is not up.<br><br>As long as we do not get back the tun device for wr=
iting, we also do<br>not put the socket back into the EVENT_READ state. And=
 this also means<br>that code to initialise the read buffer (stream_buf_set=
_next) is never<br>run.<br><br>But the reset on the TCP socket triggers the=
 TCP socket to be available<br>for read, even if it is just for a read of 0=
 bytes to indicate the reset.<br>So the link_socket_read_tcp will run into =
the assert.<br><br>Change-Id: Ifd3e953104a67c8bf2a225e179865e3dbd0dbfbc<br>=
---<br>M src/openvpn/socket.c<br>M src/openvpn/socket.h<br>2 files changed,=
 83 insertions(+), 39 deletions(-)<br><br></pre><pre class=3D"blocks" style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ssh:=
//gerrit.openvpn.net:29418/openvpn refs/changes/77/1477/2</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index f8c=
0b5c..0c11f6e 100644</span><br><span>--- a/src/openvpn/socket.c</span><br><=
span>+++ b/src/openvpn/socket.c</span><br><span>@@ -44,9 +44,7 @@</span><br=
><span> bool</span><br><span> sockets_read_residual(const struct context *c=
)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; c-&gt;c1=
.link_sockets_num; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    for (int i =3D 0; i &lt; c-&gt;c1.link_sockets_num; i++)</span><br>=
<span>     {</span><br><span>         if (c-&gt;c2.link_sockets[i]-&gt;stre=
am_buf.residual_fully_formed)</span><br><span>         {</span><br><span>@@=
 -2065,13 +2063,19 @@</span><br><span>  * stream connection.</span><br><spa=
n>  */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * resets t=
he stream buffer to be setup for the next round of</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * reassembling a packet</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * But still leaves the current packet in sb-&gt;buf to =
be potentially</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * re=
ad.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan> static inline void</span><br><span> stream_buf_reset(struct stream_buf=
 *sb)</span><br><span> {</span><br><span>     dmsg(D_STREAM_DEBUG, &quot;ST=
REAM: RESET&quot;);</span><br><span>     sb-&gt;residual_fully_formed =3D f=
alse;</span><br><span>     sb-&gt;buf =3D sb-&gt;buf_init;</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    buf_reset(&amp;sb-&gt;next);</span=
><br><span>     sb-&gt;len =3D -1;</span><br><span> }</span><br><span> </sp=
an><br><span>@@ -2093,19 +2097,35 @@</span><br><span>     dmsg(D_STREAM_DEB=
UG, &quot;STREAM: INIT maxlen=3D%d&quot;, sb-&gt;maxlen);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-st=
atic inline void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-strea=
m_buf_set_next(struct stream_buf *sb)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ * Return a buffer that is backed by the same backend as sb-&gt;buf that<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * determines where =
the next read should be done by also having the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * right offset into sb-&gt;buf</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @param sb the stream buffer from=
 which to construct the next buffer</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
static inline struct buffer</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+stream_buf_get_next(struct stream_buf *sb)</span><br><span> {</span=
><br><span>     /* set up &#39;next&#39; for next i/o read */</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    sb-&gt;next =3D sb-&gt;buf;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    sb-&gt;next.offset =
=3D sb-&gt;buf.offset + sb-&gt;buf.len;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    sb-&gt;next.len =3D (sb-&gt;len &gt;=3D 0 ? sb-&gt;le=
n : sb-&gt;maxlen) - sb-&gt;buf.len;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    dmsg(D_STREAM_DEBUG, &quot;STREAM: SET NEXT, buf=3D[%d,%=
d] next=3D[%d,%d] len=3D%d maxlen=3D%d&quot;,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-         sb-&gt;buf.offset, sb-&gt;buf.len, sb-&gt;=
next.offset, sb-&gt;next.len, sb-&gt;len, sb-&gt;maxlen);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    ASSERT(sb-&gt;next.len &gt; 0);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    ASSERT(buf_safe(&amp;=
sb-&gt;buf, sb-&gt;next.len));</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    struct buffer next;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    next =3D sb-&gt;buf;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    next.offset =3D sb-&gt;buf.offset + sb-&gt;buf.len;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    next.len =3D (s=
b-&gt;len &gt;=3D 0 ? sb-&gt;len : sb-&gt;maxlen) - sb-&gt;buf.len;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    dmsg(D_STREAM_DEBUG, &q=
uot;STREAM: GET NEXT, buf=3D[%d,%d] next=3D[%d,%d] len=3D%d maxlen=3D%d&quo=
t;,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         sb-&gt;=
buf.offset, sb-&gt;buf.len, next.offset, next.len, sb-&gt;len, sb-&gt;maxle=
n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(next.=
len &gt; 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ASS=
ERT(buf_safe(&amp;sb-&gt;buf, next.len));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return next;</span><br><span> }</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * Sets the parameter buf to  the c=
urrent buffer of sb-&gt;buf.</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * This function assumes that caller already checked if the packet=
 in sb-&gt;buf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is=
 fully assembled.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sb    str=
eam buffer to operate on</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * @param buf   buffer to point to the contents of buf</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline =
void</span><br><span> stream_buf_get_final(struct stream_buf *sb, struct bu=
ffer *buf)</span><br><span> {</span><br><span>@@ -2114,33 +2134,36 @@</span=
><br><span>     *buf =3D sb-&gt;buf;</span><br><span> }</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-static inline void</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-stream_buf_get_next(struct=
 stream_buf *sb, struct buffer *buf)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    d=
msg(D_STREAM_DEBUG, &quot;STREAM: GET NEXT len=3D%d&quot;, buf_defined(&amp=
;sb-&gt;next) ? sb-&gt;next.len : -1);</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-    ASSERT(buf_defined(&amp;sb-&gt;next));</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    *buf =3D sb-&gt;next;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> bool</span><br><span> stream_buf_re=
ad_setup_dowork(struct stream_buf *sb)</span><br><span> {</span><br><span> =
    if (sb-&gt;residual.len &amp;&amp; !sb-&gt;residual_fully_formed)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    ASSERT(buf_copy(sb-&gt;buf, &amp;sock-&gt;stream_buf.residual));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        ASSERT(buf_copy(&a=
mp;sb-&gt;buf, &amp;sb-&gt;residual));</span><br><span>         ASSERT(buf_=
init(&amp;sb-&gt;residual, 0));</span><br><span>         sb-&gt;residual_fu=
lly_formed =3D stream_buf_added(sb, 0);</span><br><span>         dmsg(D_STR=
EAM_DEBUG, &quot;STREAM: RESIDUAL FULLY FORMED [%s], len=3D%d&quot;,</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-             stream_buf-&gt;=
residual_fully_formed ? &quot;YES&quot; : &quot;NO&quot;, sb-&gt;residual.l=
en);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             sb=
-&gt;residual_fully_formed ? &quot;YES&quot; : &quot;NO&quot;, sb-&gt;resid=
ual.len);</span><br><span>     }</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    if (!sb-&gt;residual_fully_formed)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        stream_buf_set_next(sb);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    }</span><br><span>     retur=
n !sb-&gt;residual_fully_formed;</span><br><span> }</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * This will determine if sb-&gt;buf cont=
ains a full packet. It will also</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * move anything in sb-&gt;buf beyond a full beyond packet to =
sb-&gt;residual</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If this is the fir=
st time the function is called with a valid buffer</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * and port sharing is enabled the function =
will also determine if this</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ * is OpenVPN protocol or not and store the result in sb-&gt;port_s=
hare_state.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * If a packet is outside=
 of the allowed range is detected, the error state</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * on sb is set.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * @param sb the stream buffer</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ * @param length_added The length that has been added=
 to sb-&gt;buf</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @r=
eturn true if sb-&gt;buf contains fully reassembled packet</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static bool</sp=
an><br><span> stream_buf_added(struct stream_buf *sb, int length_added)</sp=
an><br><span> {</span><br><span>@@ -2203,7 +2226,6 @@</span><br><span>     =
else</span><br><span>     {</span><br><span>         dmsg(D_STREAM_DEBUG, &=
quot;STREAM: ADD returned FALSE (have=3D%d need=3D%d)&quot;, sb-&gt;buf.len=
, sb-&gt;len);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
 stream_buf_set_next(sb);</span><br><span>         return false;</span><br>=
<span>     }</span><br><span> }</span><br><span>@@ -2273,8 +2295,7 @@</span=
><br><span>         sockethandle_t sh =3D { .s =3D sock-&gt;sd };</span><br=
><span>         len =3D sockethandle_finalize(sh, &amp;sock-&gt;reads, buf,=
 NULL);</span><br><span> #else</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-        struct buffer frag;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-        stream_buf_get_next(&amp;sock-&gt;stream_buf, &amp;f=
rag);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        struct=
 buffer frag =3D stream_buf_get_next(&amp;sock-&gt;stream_buf);</span><br><=
span>         len =3D recv(sock-&gt;sd, BPTR(&amp;frag), BLEN(&amp;frag), M=
SG_NOSIGNAL);</span><br><span> #endif</span><br><span> </span><br><span>dif=
f --git a/src/openvpn/socket.h b/src/openvpn/socket.h</span><br><span>index=
 8664666f..f2bf906 100644</span><br><span>--- a/src/openvpn/socket.h</span>=
<br><span>+++ b/src/openvpn/socket.h</span><br><span>@@ -95,23 +95,41 @@</s=
pan><br><span>     int mtu_changed; /* Set to true when mtu value is change=
d */</span><br><span> };</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-/*</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>- * Used to extract packets encapsulated in streams into a buffer,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * in this case IP packets em=
bedded in a TCP stream.</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * struct us=
ed to extract packets encapsulated in streams into a buffer,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * in this case OpenVPN packets (d=
ata or control) embedded in a TCP stream.</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ * This struct is used to packetise the TCP stream into the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ * OpenVPN packet. Each OpenVP=
N packet has a two-byte header determining</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * the length of the packet.</span><br><span>  */</s=
pan><br><span> struct stream_buf</span><br><span> {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /* Buffer to hold the initial buffer =
that will be used to reset buf */</span><br><span>     struct buffer buf_in=
it;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /** buffer holding the excess b=
ytes that are not part of the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+     *  packet. */</span><br><span>     struct buffer residual;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /** Maximum length of a packet that =
we accept */</span><br><span>     int maxlen;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /** The buffer in buf contains a full packet without a header. A=
ny</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     * extra data=
 is in residual */</span><br><span>     bool residual_fully_formed;</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** H=
olds the data of the current packet. This might be a partial packet */</spa=
n><br><span>     struct buffer buf;</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    struct buffer next;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    int len;    /* -1 if not yet known */</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    bool error; /* if=
 true, fatal TCP error has occurred,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                 *  requiring that connection be restarted *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** -1 if not =
yet known. Otherwise holds the length of the</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+     *   packet. If &gt;=3D 0, buf is already move=
d past the initial</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
    *  size header */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    int len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /** if true, a fatal=
 TCP error has occurred,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+     *  requiring that connection be restarted */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    bool error;</span><br><span> #if POR=
T_SHARE</span><br><span> #define PS_DISABLED 0</span><br><span> #define PS_=
ENABLED  1</span><br><span>@@ -529,9 +547,14 @@</span><br><span> }</span><b=
r><span> </span><br><span> /**</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ * Will try to check if the buffers in stream form a</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * full packet. Will return tru=
e if further reads are</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ * required and other false. (full packet is ready)</span><br><span>  *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * @param sock</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * @return</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ * With UDP we always return true as t=
here is no reassembly.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param sb  =
  the stream buffer that should be worked on</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ * @return      true if more reads are required.</=
span><br><span>  */</span><br><span> bool stream_buf_read_setup_dowork(stru=
ct stream_buf *sb);</span><br><span> </span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3De=
mail">change 1477</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1477?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd3e953104a67c8bf2a225e1798=
65e3dbd0dbfbc </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1477 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--9F2BdizGJCQ=--

