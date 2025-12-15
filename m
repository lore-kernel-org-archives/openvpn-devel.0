From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 16:12:18 +0000
In-Reply-To: <gerrit.1765538409000.I123002255b37160d48ef6481f68a89d03073236b@...2715...>
References: <gerrit.1765538409000.I123002255b37160d48ef6481f68a89d03073236b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0ec42a4d5bdd319def0919cf3c684d20d09aa5e0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gLguf5ySdfk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Change
 buf_prepend and buf_advance to accept ssize_t for length
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gLguf5ySdfk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
37?usp=3Demail )

Change subject: buffer: Change buf_prepend and buf_advance to accept ssize_=
t for length
......................................................................

buffer: Change buf_prepend and buf_advance to accept ssize_t for length

We already have tests to make sure the value is sane.
Changing the argument to ssize_t allows to use it in
more places without needing to do a cast before the
checks.

Change-Id: I123002255b37160d48ef6481f68a89d03073236b
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1437
Message-Id: <20251215160541.24237-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
099.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/ps.c
3 files changed, 10 insertions(+), 10 deletions(-)




diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 40baca6..acab06b 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -789,7 +789,7 @@
 {
     if (buf_string_match_head_str(src, match))
     {
-        buf_advance(src, (int)strlen(match));
+        buf_advance(src, strlen(match));
         return true;
     }
     else
@@ -1312,7 +1312,7 @@
 }

 void
-buffer_list_advance(struct buffer_list *ol, int n)
+buffer_list_advance(struct buffer_list *ol, ssize_t n)
 {
     if (ol->head)
     {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 1dbe0b2..1a6358d 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -601,26 +601,26 @@
  */

 static inline uint8_t *
-buf_prepend(struct buffer *buf, int size)
+buf_prepend(struct buffer *buf, ssize_t size)
 {
     if (!buf_valid(buf) || size < 0 || size > buf->offset)
     {
         return NULL;
     }
-    buf->offset -=3D size;
-    buf->len +=3D size;
+    buf->offset -=3D (int)size;
+    buf->len +=3D (int)size;
     return BPTR(buf);
 }

 static inline bool
-buf_advance(struct buffer *buf, int size)
+buf_advance(struct buffer *buf, ssize_t size)
 {
     if (!buf_valid(buf) || size < 0 || buf->len < size)
     {
         return false;
     }
-    buf->offset +=3D size;
-    buf->len -=3D size;
+    buf->offset +=3D (int)size;
+    buf->len -=3D (int)size;
     return true;
 }

@@ -1187,7 +1187,7 @@
  */
 struct buffer *buffer_list_peek(struct buffer_list *ol);

-void buffer_list_advance(struct buffer_list *ol, int n);
+void buffer_list_advance(struct buffer_list *ol, ssize_t n);

 void buffer_list_pop(struct buffer_list *ol);

diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c
index 31e7c25..917f871 100644
--- a/src/openvpn/ps.c
+++ b/src/openvpn/ps.c
@@ -596,7 +596,7 @@
         {
             dmsg(D_PS_PROXY_DEBUG, "PORT SHARE PROXY: partial write[%d], t=
ried=3D%d got=3D%zd", (int)sd,
                  pc->buf.len, status);
-            buf_advance(&pc->buf, (int)status);
+            buf_advance(&pc->buf, status);
             return IOSTAT_EAGAIN_ON_WRITE;
         }
         else

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1437?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I123002255b37160d48ef6481f68a89d03073236b
Gerrit-Change-Number: 1437
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gLguf5ySdfk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1437?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">buffer: Change buf_prepend and buf_advance to ac=
cept ssize_t for length<br><br>We already have tests to make sure the value=
 is sane.<br>Changing the argument to ssize_t allows to use it in<br>more p=
laces without needing to do a cast before the<br>checks.<br><br>Change-Id: =
I123002255b37160d48ef6481f68a89d03073236b<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&g=
t;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1437<br>Message-Id=
: &lt;20251215160541.24237-1-gert@...1296...&gt;<br>URL: https://www.mail-a=
rchive.com/openvpn-devel@lists.sourceforge.net/msg35099.html<br>Signed-off-=
by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/buffer.c<b=
r>M src/openvpn/buffer.h<br>M src/openvpn/ps.c<br>3 files changed, 10 inser=
tions(+), 10 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span=
>index 40baca6..acab06b 100644</span><br><span>--- a/src/openvpn/buffer.c</=
span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -789,7 +789,7 =
@@</span><br><span> {</span><br><span>     if (buf_string_match_head_str(sr=
c, match))</span><br><span>     {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-        buf_advance(src, (int)strlen(match));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        buf_advance(src, strlen(match=
));</span><br><span>         return true;</span><br><span>     }</span><br>=
<span>     else</span><br><span>@@ -1312,7 +1312,7 @@</span><br><span> }</s=
pan><br><span> </span><br><span> void</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-buffer_list_advance(struct buffer_list *ol, int n)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+buffer_list_advance(struct b=
uffer_list *ol, ssize_t n)</span><br><span> {</span><br><span>     if (ol-&=
gt;head)</span><br><span>     {</span><br><span>diff --git a/src/openvpn/bu=
ffer.h b/src/openvpn/buffer.h</span><br><span>index 1dbe0b2..1a6358d 100644=
</span><br><span>--- a/src/openvpn/buffer.h</span><br><span>+++ b/src/openv=
pn/buffer.h</span><br><span>@@ -601,26 +601,26 @@</span><br><span>  */</spa=
n><br><span> </span><br><span> static inline uint8_t *</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-buf_prepend(struct buffer *buf, int size)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_prepend(struct b=
uffer *buf, ssize_t size)</span><br><span> {</span><br><span>     if (!buf_=
valid(buf) || size &lt; 0 || size &gt; buf-&gt;offset)</span><br><span>    =
 {</span><br><span>         return NULL;</span><br><span>     }</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;offset -=3D size;</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;len +=3D size=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;offset=
 -=3D (int)size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 buf-&gt;len +=3D (int)size;</span><br><span>     return BPTR(buf);</span><=
br><span> }</span><br><span> </span><br><span> static inline bool</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-buf_advance(struct buffer *buf,=
 int size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_advan=
ce(struct buffer *buf, ssize_t size)</span><br><span> {</span><br><span>   =
  if (!buf_valid(buf) || size &lt; 0 || buf-&gt;len &lt; size)</span><br><s=
pan>     {</span><br><span>         return false;</span><br><span>     }</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;offset +=3D =
size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;len =
-=3D size;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf-&=
gt;offset +=3D (int)size;</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    buf-&gt;len -=3D (int)size;</span><br><span>     return true;</sp=
an><br><span> }</span><br><span> </span><br><span>@@ -1187,7 +1187,7 @@</sp=
an><br><span>  */</span><br><span> struct buffer *buffer_list_peek(struct b=
uffer_list *ol);</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-void buffer_list_advance(struct buffer_list *ol, int n);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+void buffer_list_advance(=
struct buffer_list *ol, ssize_t n);</span><br><span> </span><br><span> void=
 buffer_list_pop(struct buffer_list *ol);</span><br><span> </span><br><span=
>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span><br><span>index 31e=
7c25..917f871 100644</span><br><span>--- a/src/openvpn/ps.c</span><br><span=
>+++ b/src/openvpn/ps.c</span><br><span>@@ -596,7 +596,7 @@</span><br><span=
>         {</span><br><span>             dmsg(D_PS_PROXY_DEBUG, &quot;PORT =
SHARE PROXY: partial write[%d], tried=3D%d got=3D%zd&quot;, (int)sd,</span>=
<br><span>                  pc-&gt;buf.len, status);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-            buf_advance(&amp;pc-&gt;buf, (i=
nt)status);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
    buf_advance(&amp;pc-&gt;buf, status);</span><br><span>             retu=
rn IOSTAT_EAGAIN_ON_WRITE;</span><br><span>         }</span><br><span>     =
    else</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1437?usp=3Demail">change 1437</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1437?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I123002255b37160d48ef6481f68=
a89d03073236b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1437 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--gLguf5ySdfk=--

