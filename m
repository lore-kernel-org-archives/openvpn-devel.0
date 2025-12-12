From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 12 Dec 2025 11:20:14 +0000
References: <gerrit.1765538409000.I123002255b37160d48ef6481f68a89d03073236b@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <51dae4d014cb93a72099144af43b7286940ed6c7-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="VaF80S7vx8g="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--VaF80S7vx8g=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1437?usp=3Demail

to review the following change.


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
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/ps.c
3 files changed, 10 insertions(+), 10 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/1437/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 293622f..aae4104 100644
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
index ab2a29d..5444dfd 100644
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

@@ -1175,7 +1175,7 @@
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I123002255b37160d48ef6481f68a89d03073236b
Gerrit-Change-Number: 1437
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--VaF80S7vx8g=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1437?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">buffer: Change buf_prepend and buf_advance =
to accept ssize_t for length<br><br>We already have tests to make sure the =
value is sane.<br>Changing the argument to ssize_t allows to use it in<br>m=
ore places without needing to do a cast before the<br>checks.<br><br>Change=
-Id: I123002255b37160d48ef6481f68a89d03073236b<br>Signed-off-by: Frank Lich=
tenheld &lt;frank@...2641...&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/=
openvpn/buffer.h<br>M src/openvpn/ps.c<br>3 files changed, 10 insertions(+)=
, 10 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/37/1437/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/b=
uffer.c b/src/openvpn/buffer.c</span><br><span>index 293622f..aae4104 10064=
4</span><br><span>--- a/src/openvpn/buffer.c</span><br><span>+++ b/src/open=
vpn/buffer.c</span><br><span>@@ -789,7 +789,7 @@</span><br><span> {</span><=
br><span>     if (buf_string_match_head_str(src, match))</span><br><span>  =
   {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        buf_advan=
ce(src, (int)strlen(match));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        buf_advance(src, strlen(match));</span><br><span>         =
return true;</span><br><span>     }</span><br><span>     else</span><br><sp=
an>@@ -1312,7 +1312,7 @@</span><br><span> }</span><br><span> </span><br><sp=
an> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buffer_list_a=
dvance(struct buffer_list *ol, int n)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+buffer_list_advance(struct buffer_list *ol, ssize_t n)</s=
pan><br><span> {</span><br><span>     if (ol-&gt;head)</span><br><span>    =
 {</span><br><span>diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h=
</span><br><span>index ab2a29d..5444dfd 100644</span><br><span>--- a/src/op=
envpn/buffer.h</span><br><span>+++ b/src/openvpn/buffer.h</span><br><span>@=
@ -601,26 +601,26 @@</span><br><span>  */</span><br><span> </span><br><span=
> static inline uint8_t *</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-buf_prepend(struct buffer *buf, int size)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+buf_prepend(struct buffer *buf, ssize_t size)</sp=
an><br><span> {</span><br><span>     if (!buf_valid(buf) || size &lt; 0 || =
size &gt; buf-&gt;offset)</span><br><span>     {</span><br><span>         r=
eturn NULL;</span><br><span>     }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    buf-&gt;offset -=3D size;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    buf-&gt;len +=3D size;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    buf-&gt;offset -=3D (int)size;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;len +=3D (int)size;<=
/span><br><span>     return BPTR(buf);</span><br><span> }</span><br><span> =
</span><br><span> static inline bool</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-buf_advance(struct buffer *buf, int size)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+buf_advance(struct buffer *buf, ssize_=
t size)</span><br><span> {</span><br><span>     if (!buf_valid(buf) || size=
 &lt; 0 || buf-&gt;len &lt; size)</span><br><span>     {</span><br><span>  =
       return false;</span><br><span>     }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    buf-&gt;offset +=3D size;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;len -=3D size;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;offset +=3D (int)size;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf-&gt;len -=3D =
(int)size;</span><br><span>     return true;</span><br><span> }</span><br><=
span> </span><br><span>@@ -1175,7 +1175,7 @@</span><br><span>  */</span><br=
><span> struct buffer *buffer_list_peek(struct buffer_list *ol);</span><br>=
<span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-void buffer_li=
st_advance(struct buffer_list *ol, int n);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+void buffer_list_advance(struct buffer_list *ol, ssi=
ze_t n);</span><br><span> </span><br><span> void buffer_list_pop(struct buf=
fer_list *ol);</span><br><span> </span><br><span>diff --git a/src/openvpn/p=
s.c b/src/openvpn/ps.c</span><br><span>index 31e7c25..917f871 100644</span>=
<br><span>--- a/src/openvpn/ps.c</span><br><span>+++ b/src/openvpn/ps.c</sp=
an><br><span>@@ -596,7 +596,7 @@</span><br><span>         {</span><br><span=
>             dmsg(D_PS_PROXY_DEBUG, &quot;PORT SHARE PROXY: partial write[=
%d], tried=3D%d got=3D%zd&quot;, (int)sd,</span><br><span>                 =
 pc-&gt;buf.len, status);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-            buf_advance(&amp;pc-&gt;buf, (int)status);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+            buf_advance(&amp;pc-&gt;=
buf, status);</span><br><span>             return IOSTAT_EAGAIN_ON_WRITE;</=
span><br><span>         }</span><br><span>         else</span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1437?usp=3Demail">change 1437</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1437?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I123002255b37160d48ef6481f68=
a89d03073236b </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1437 </div>
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

--VaF80S7vx8g=--

