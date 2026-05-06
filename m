From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 May 2026 21:21:22 +0000
References: <gerrit.1778102459000.I3ecb76d9022dcd7dae92eb5e9d62e5f018744883@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <4c41e1e0cd0bd069afb092bda40719a6d8eb3b27-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="//9d/XWzTbk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Fix some
 issues with -DVERIFY_ALIGNMENT
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

--//9d/XWzTbk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1666?usp=3Demail

to review the following change.


Change subject: buffer: Fix some issues with -DVERIFY_ALIGNMENT
......................................................................

buffer: Fix some issues with -DVERIFY_ALIGNMENT

- Fix some uninitalised fields due to BUF_INIT_TRACKING
  (found by cppcheck and the original reason for this
   change).
- Fix "unused functions" if only BUF_INIT_TRACKING is
  defined.
- Fix conversion error

Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018744883
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
1 file changed, 10 insertions(+), 5 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/66/1666/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 71f3769..1e19137 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -64,14 +64,13 @@
 #endif
 {
     struct buffer buf;
+    CLEAR(buf);

     if (!buf_size_valid(size))
     {
         buf_size_error(size);
     }
     buf.capacity =3D (int)size;
-    buf.offset =3D 0;
-    buf.len =3D 0;
 #ifdef DMALLOC
     buf.data =3D openvpn_dmalloc(file, line, size);
 #else
@@ -90,13 +89,13 @@
 #endif
 {
     struct buffer buf;
+    CLEAR(buf);
+
     if (!buf_size_valid(size))
     {
         buf_size_error(size);
     }
     buf.capacity =3D (int)size;
-    buf.offset =3D 0;
-    buf.len =3D 0;
 #ifdef DMALLOC
     buf.data =3D (uint8_t *)gc_malloc_debug(size, false, gc, file, line);
 #else
@@ -120,6 +119,10 @@
     ret.capacity =3D buf->capacity;
     ret.offset =3D buf->offset;
     ret.len =3D buf->len;
+#ifdef BUF_INIT_TRACKING
+    ret.debug_file =3D buf->debug_file;
+    ret.debug_line =3D buf->debug_line;
+#endif
 #ifdef DMALLOC
     ret.data =3D (uint8_t *)openvpn_dmalloc(file, line, buf->capacity);
 #else
@@ -140,6 +143,7 @@
     return buf_init_dowork(buf, offset);
 }

+#ifdef VERIFY_ALIGNMENT
 static inline int
 buf_debug_line(const struct buffer *buf)
 {
@@ -151,6 +155,7 @@
 {
     return buf->debug_file;
 }
+#endif

 #else /* ifdef BUF_INIT_TRACKING */

@@ -1152,7 +1157,7 @@
     if (buf && buf->len)
     {
         msglvl_t msglevel =3D D_ALIGN_DEBUG;
-        const unsigned int u =3D (unsigned int)BPTR(buf);
+        const uintptr_t u =3D (uintptr_t)BPTR(buf);

         if (u & (PAYLOAD_ALIGN - 1))
         {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1666?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018744883
Gerrit-Change-Number: 1666
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--//9d/XWzTbk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1666?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">buffer: Fix some issues with -DVERIFY_ALIGN=
MENT<br><br>- Fix some uninitalised fields due to BUF_INIT_TRACKING<br>  (f=
ound by cppcheck and the original reason for this<br>   change).<br>- Fix &=
quot;unused functions&quot; if only BUF_INIT_TRACKING is<br>  defined.<br>-=
 Fix conversion error<br><br>Change-Id: I3ecb76d9022dcd7dae92eb5e9d62e5f018=
744883<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<=
br>M src/openvpn/buffer.c<br>1 file changed, 10 insertions(+), 5 deletions(=
-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openv=
pn refs/changes/66/1666/1</pre><pre style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer.c b/src/o=
penvpn/buffer.c</span><br><span>index 71f3769..1e19137 100644</span><br><sp=
an>--- a/src/openvpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</s=
pan><br><span>@@ -64,14 +64,13 @@</span><br><span> #endif</span><br><span> =
{</span><br><span>     struct buffer buf;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    CLEAR(buf);</span><br><span> </span><br><span>   =
  if (!buf_size_valid(size))</span><br><span>     {</span><br><span>       =
  buf_size_error(size);</span><br><span>     }</span><br><span>     buf.cap=
acity =3D (int)size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   buf.offset =3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   buf.len =3D 0;</span><br><span> #ifdef DMALLOC</span><br><span>     buf.=
data =3D openvpn_dmalloc(file, line, size);</span><br><span> #else</span><b=
r><span>@@ -90,13 +89,13 @@</span><br><span> #endif</span><br><span> {</spa=
n><br><span>     struct buffer buf;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    CLEAR(buf);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span>     if (!buf_size_valid(size))</span><br><spa=
n>     {</span><br><span>         buf_size_error(size);</span><br><span>   =
  }</span><br><span>     buf.capacity =3D (int)size;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf.offset =3D 0;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf.len =3D 0;</span><br><span> #ifdef =
DMALLOC</span><br><span>     buf.data =3D (uint8_t *)gc_malloc_debug(size, =
false, gc, file, line);</span><br><span> #else</span><br><span>@@ -120,6 +1=
19,10 @@</span><br><span>     ret.capacity =3D buf-&gt;capacity;</span><br>=
<span>     ret.offset =3D buf-&gt;offset;</span><br><span>     ret.len =3D =
buf-&gt;len;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
BUF_INIT_TRACKING</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  ret.debug_file =3D buf-&gt;debug_file;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    ret.debug_line =3D buf-&gt;debug_line;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> #ifdef =
DMALLOC</span><br><span>     ret.data =3D (uint8_t *)openvpn_dmalloc(file, =
line, buf-&gt;capacity);</span><br><span> #else</span><br><span>@@ -140,6 +=
143,7 @@</span><br><span>     return buf_init_dowork(buf, offset);</span><b=
r><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifdef VERIFY_ALIGNMENT</span><br><span> static inline int</span><=
br><span> buf_debug_line(const struct buffer *buf)</span><br><span> {</span=
><br><span>@@ -151,6 +155,7 @@</span><br><span> {</span><br><span>     retu=
rn buf-&gt;debug_file;</span><br><span> }</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> #else /* if=
def BUF_INIT_TRACKING */</span><br><span> </span><br><span>@@ -1152,7 +1157=
,7 @@</span><br><span>     if (buf &amp;&amp; buf-&gt;len)</span><br><span>=
     {</span><br><span>         msglvl_t msglevel =3D D_ALIGN_DEBUG;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        const unsigned int u=
 =3D (unsigned int)BPTR(buf);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        const uintptr_t u =3D (uintptr_t)BPTR(buf);</span><br><sp=
an> </span><br><span>         if (u &amp; (PAYLOAD_ALIGN - 1))</span><br><s=
pan>         {</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1666?usp=3Demail">change 1666</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1666?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3ecb76d9022dcd7dae92eb5e9d6=
2e5f018744883 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1666 </div>
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

--//9d/XWzTbk=--

