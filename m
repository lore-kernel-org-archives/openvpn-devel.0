From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 15 Dec 2025 16:12:15 +0000
In-Reply-To: <gerrit.1765538409000.I123002255b37160d48ef6481f68a89d03073236b@...2715...>
References: <gerrit.1765538409000.I123002255b37160d48ef6481f68a89d03073236b@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0ec42a4d5bdd319def0919cf3c684d20d09aa5e0-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="R5WWqcSd+mY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--R5WWqcSd+mY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1437?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2, Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/37/1437/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I123002255b37160d48ef6481f68a89d03073236b
Gerrit-Change-Number: 1437
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--R5WWqcSd+mY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1437?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2, Code-Review+2 by plaisthos</p><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">buffer:=
 Change buf_prepend and buf_advance to accept ssize_t for length<br><br>We =
already have tests to make sure the value is sane.<br>Changing the argument=
 to ssize_t allows to use it in<br>more places without needing to do a cast=
 before the<br>checks.<br><br>Change-Id: I123002255b37160d48ef6481f68a89d03=
073236b<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Ack=
ed-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.o=
penvpn.net/c/openvpn/+/1437<br>Message-Id: &lt;20251215160541.24237-1-gert@=
...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1885...=
rceforge.net/msg35099.html<br>Signed-off-by: Gert Doering &lt;gert@...1725...=
..&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/buffer.h<br>M src/=
openvpn/ps.c<br>3 files changed, 10 insertions(+), 10 deletions(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/37/1437/2</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buff=
er.c</span><br><span>index 40baca6..acab06b 100644</span><br><span>--- a/sr=
c/openvpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><sp=
an>@@ -789,7 +789,7 @@</span><br><span> {</span><br><span>     if (buf_stri=
ng_match_head_str(src, match))</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        buf_advance(src, (int)strlen(match)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_advan=
ce(src, strlen(match));</span><br><span>         return true;</span><br><sp=
an>     }</span><br><span>     else</span><br><span>@@ -1312,7 +1312,7 @@</=
span><br><span> }</span><br><span> </span><br><span> void</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-buffer_list_advance(struct buffer_list =
*ol, int n)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buffer_l=
ist_advance(struct buffer_list *ol, ssize_t n)</span><br><span> {</span><br=
><span>     if (ol-&gt;head)</span><br><span>     {</span><br><span>diff --=
git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br><span>index 1db=
e0b2..1a6358d 100644</span><br><span>--- a/src/openvpn/buffer.h</span><br><=
span>+++ b/src/openvpn/buffer.h</span><br><span>@@ -601,26 +601,26 @@</span=
><br><span>  */</span><br><span> </span><br><span> static inline uint8_t *<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_prepend(struct buf=
fer *buf, int size)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
buf_prepend(struct buffer *buf, ssize_t size)</span><br><span> {</span><br>=
<span>     if (!buf_valid(buf) || size &lt; 0 || size &gt; buf-&gt;offset)<=
/span><br><span>     {</span><br><span>         return NULL;</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf-&gt;o=
ffset -=3D size;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    b=
uf-&gt;len +=3D size;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    buf-&gt;offset -=3D (int)size;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    buf-&gt;len +=3D (int)size;</span><br><span>     retur=
n BPTR(buf);</span><br><span> }</span><br><span> </span><br><span> static i=
nline bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_advance=
(struct buffer *buf, int size)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+buf_advance(struct buffer *buf, ssize_t size)</span><br><span> {=
</span><br><span>     if (!buf_valid(buf) || size &lt; 0 || buf-&gt;len &lt=
; size)</span><br><span>     {</span><br><span>         return false;</span=
><br><span>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
buf-&gt;offset +=3D size;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    buf-&gt;len -=3D size;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    buf-&gt;offset +=3D (int)size;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    buf-&gt;len -=3D (int)size;</span><br><span> =
    return true;</span><br><span> }</span><br><span> </span><br><span>@@ -1=
187,7 +1187,7 @@</span><br><span>  */</span><br><span> struct buffer *buffe=
r_list_peek(struct buffer_list *ol);</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-void buffer_list_advance(struct buffer_lis=
t *ol, int n);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void =
buffer_list_advance(struct buffer_list *ol, ssize_t n);</span><br><span> </=
span><br><span> void buffer_list_pop(struct buffer_list *ol);</span><br><sp=
an> </span><br><span>diff --git a/src/openvpn/ps.c b/src/openvpn/ps.c</span=
><br><span>index 31e7c25..917f871 100644</span><br><span>--- a/src/openvpn/=
ps.c</span><br><span>+++ b/src/openvpn/ps.c</span><br><span>@@ -596,7 +596,=
7 @@</span><br><span>         {</span><br><span>             dmsg(D_PS_PROX=
Y_DEBUG, &quot;PORT SHARE PROXY: partial write[%d], tried=3D%d got=3D%zd&qu=
ot;, (int)sd,</span><br><span>                  pc-&gt;buf.len, status);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-            buf_advance(=
&amp;pc-&gt;buf, (int)status);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+            buf_advance(&amp;pc-&gt;buf, status);</span><br><spa=
n>             return IOSTAT_EAGAIN_ON_WRITE;</span><br><span>         }</s=
pan><br><span>         else</span><br><span></span><br></pre><p>To view, vi=
sit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1437?usp=3Demail">chan=
ge 1437</a>. To unsubscribe, or for help writing mail filters, visit <a hre=
f=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div =
itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itempr=
op=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"u=
rl" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1437?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--R5WWqcSd+mY=--

