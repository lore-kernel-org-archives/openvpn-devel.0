From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Mon, 9 Mar 2026 15:58:24 +0000
References: <gerrit.1773071900000.Iecc3e3d5d13cb85c1f287ad4816e1e6a7b2bcdef@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8a29e109188896d4b08a2afc00ac2bbfeaa40956-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="vem2589KZqE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: buffer: Avoid
 sign-compare warnings
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

--vem2589KZqE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1561?usp=3Demail

to review the following change.


Change subject: buffer: Avoid sign-compare warnings
......................................................................

buffer: Avoid sign-compare warnings

- Switch buffer_list size and max_size to size_t
- Guard some unavoidable size_t -> int conversions

Change-Id: Iecc3e3d5d13cb85c1f287ad4816e1e6a7b2bcdef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
2 files changed, 10 insertions(+), 18 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1561/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 75110ed..71f3769 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -53,7 +53,7 @@
 void
 buf_size_error(const size_t size)
 {
-    msg(M_FATAL, "fatal buffer size error, size=3D%lu", (unsigned long)siz=
e);
+    msg(M_FATAL, "fatal buffer size error, size=3D%zu", size);
 }

 struct buffer
@@ -280,11 +280,6 @@
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wsign-compare"
-#endif
-
 /*
  * write a string to the end of a buffer that was
  * truncated by buf_printf
@@ -295,7 +290,7 @@
     if (buf_forward_capacity(buf) <=3D 1)
     {
         size_t len =3D strlen(str) + 1;
-        if (len < buf_forward_capacity_total(buf))
+        if (buf_size_valid(len) && (int)len < buf_forward_capacity_total(b=
uf))
         {
             memcpy(buf->data + buf->capacity - len, str, len);
         }
@@ -782,7 +777,7 @@
 buf_string_match_head_str(const struct buffer *src, const char *match)
 {
     const size_t size =3D strlen(match);
-    if (size > src->len)
+    if (!buf_size_valid(size) || (int)size > src->len)
     {
         return false;
     }
@@ -1196,7 +1191,7 @@
 bool
 buffer_list_defined(const struct buffer_list *ol)
 {
-    return ol && ol->head !=3D NULL;
+    return ol && ol->head !=3D NULL && ol->size > 0;
 }

 void
@@ -1223,7 +1218,7 @@
         struct buffer_entry *e =3D buffer_list_push_data(ol, str, len + 1);
         if (e)
         {
-            e->buf.len =3D (int)len; /* Don't count trailing '\0' as part =
of length */
+            e->buf.len--; /* Don't count trailing '\0' as part of length */
         }
     }
 }
@@ -1249,6 +1244,7 @@
         }
         e->buf =3D alloc_buf(size);
         memcpy(e->buf.data, data, size);
+        /* Note: size implicitly checked by alloc_buf */
         e->buf.len =3D (int)size;
         ol->tail =3D e;
     }
@@ -1274,7 +1270,7 @@
     const size_t sep_len =3D strlen(sep);
     struct buffer_entry *more =3D bl->head;
     size_t size =3D 0;
-    int count =3D 0;
+    size_t count =3D 0;
     for (; more; ++count)
     {
         size_t extra_len =3D BLENZ(&more->buf) + sep_len;
@@ -1313,10 +1309,6 @@
     }
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 buffer_list_aggregate(struct buffer_list *bl, const size_t max)
 {
@@ -1326,7 +1318,7 @@
 void
 buffer_list_pop(struct buffer_list *ol)
 {
-    if (ol && ol->head)
+    if (buffer_list_defined(ol))
     {
         struct buffer_entry *e =3D ol->head->next;
         free_buf(&ol->head->buf);
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 040f752..fcc923b 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -1149,8 +1149,8 @@
 {
     struct buffer_entry *head; /* next item to pop/peek */
     struct buffer_entry *tail; /* last item pushed */
-    int size;                  /* current number of entries */
-    int max_size;              /* maximum size list should grow to */
+    size_t size;               /* current number of entries */
+    size_t max_size;           /* maximum size list should grow to */
 };

 /**

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1561?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iecc3e3d5d13cb85c1f287ad4816e1e6a7b2bcdef
Gerrit-Change-Number: 1561
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--vem2589KZqE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1561?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">buffer: Avoid sign-compare warnings<br><br>=
- Switch buffer_list size and max_size to size_t<br>- Guard some unavoidabl=
e size_t -&gt; int conversions<br><br>Change-Id: Iecc3e3d5d13cb85c1f287ad48=
16e1e6a7b2bcdef<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt=
;<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/buffer.h<br>2 files cha=
nged, 10 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1561/1</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>index =
75110ed..71f3769 100644</span><br><span>--- a/src/openvpn/buffer.c</span><b=
r><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -53,7 +53,7 @@</span>=
<br><span> void</span><br><span> buf_size_error(const size_t size)</span><b=
r><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_F=
ATAL, &quot;fatal buffer size error, size=3D%lu&quot;, (unsigned long)size)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &=
quot;fatal buffer size error, size=3D%zu&quot;, size);</span><br><span> }</=
span><br><span> </span><br><span> struct buffer</span><br><span>@@ -280,11 =
+280,6 @@</span><br><span>     return ret;</span><br><span> }</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNU=
C__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-#pragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign-compare&quot;</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</span><br><span>  * wr=
ite a string to the end of a buffer that was</span><br><span>  * truncated =
by buf_printf</span><br><span>@@ -295,7 +290,7 @@</span><br><span>     if (=
buf_forward_capacity(buf) &lt;=3D 1)</span><br><span>     {</span><br><span=
>         size_t len =3D strlen(str) + 1;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        if (len &lt; buf_forward_capacity_total(buf))</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (buf_size_=
valid(len) &amp;&amp; (int)len &lt; buf_forward_capacity_total(buf))</span>=
<br><span>         {</span><br><span>             memcpy(buf-&gt;data + buf=
-&gt;capacity - len, str, len);</span><br><span>         }</span><br><span>=
@@ -782,7 +777,7 @@</span><br><span> buf_string_match_head_str(const struct=
 buffer *src, const char *match)</span><br><span> {</span><br><span>     co=
nst size_t size =3D strlen(match);</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    if (size &gt; src-&gt;len)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    if (!buf_size_valid(size) || (int)size &gt; src=
-&gt;len)</span><br><span>     {</span><br><span>         return false;</sp=
an><br><span>     }</span><br><span>@@ -1196,7 +1191,7 @@</span><br><span> =
bool</span><br><span> buffer_list_defined(const struct buffer_list *ol)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn ol &amp;&amp; ol-&gt;head !=3D NULL;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return ol &amp;&amp; ol-&gt;head !=3D NULL &amp;&=
amp; ol-&gt;size &gt; 0;</span><br><span> }</span><br><span> </span><br><sp=
an> void</span><br><span>@@ -1223,7 +1218,7 @@</span><br><span>         str=
uct buffer_entry *e =3D buffer_list_push_data(ol, str, len + 1);</span><br>=
<span>         if (e)</span><br><span>         {</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-            e-&gt;buf.len =3D (int)len; /* Don&#=
39;t count trailing &#39;\0&#39; as part of length */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+            e-&gt;buf.len--; /* Don&#39;t=
 count trailing &#39;\0&#39; as part of length */</span><br><span>         =
}</span><br><span>     }</span><br><span> }</span><br><span>@@ -1249,6 +124=
4,7 @@</span><br><span>         }</span><br><span>         e-&gt;buf =3D al=
loc_buf(size);</span><br><span>         memcpy(e-&gt;buf.data, data, size);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        /* Note: si=
ze implicitly checked by alloc_buf */</span><br><span>         e-&gt;buf.le=
n =3D (int)size;</span><br><span>         ol-&gt;tail =3D e;</span><br><spa=
n>     }</span><br><span>@@ -1274,7 +1270,7 @@</span><br><span>     const s=
ize_t sep_len =3D strlen(sep);</span><br><span>     struct buffer_entry *mo=
re =3D bl-&gt;head;</span><br><span>     size_t size =3D 0;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    int count =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    size_t count =3D 0;</span><br><s=
pan>     for (; more; ++count)</span><br><span>     {</span><br><span>     =
    size_t extra_len =3D BLENZ(&amp;more-&gt;buf) + sep_len;</span><br><spa=
n>@@ -1313,10 +1309,6 @@</span><br><span>     }</span><br><span> }</span><b=
r><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(=
__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span> void</span><br><span> buffer_list_aggregate(struct buffer=
_list *bl, const size_t max)</span><br><span> {</span><br><span>@@ -1326,7 =
+1318,7 @@</span><br><span> void</span><br><span> buffer_list_pop(struct bu=
ffer_list *ol)</span><br><span> {</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    if (ol &amp;&amp; ol-&gt;head)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    if (buffer_list_defined(ol))</span><br><span=
>     {</span><br><span>         struct buffer_entry *e =3D ol-&gt;head-&gt=
;next;</span><br><span>         free_buf(&amp;ol-&gt;head-&gt;buf);</span><=
br><span>diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br=
><span>index 040f752..fcc923b 100644</span><br><span>--- a/src/openvpn/buff=
er.h</span><br><span>+++ b/src/openvpn/buffer.h</span><br><span>@@ -1149,8 =
+1149,8 @@</span><br><span> {</span><br><span>     struct buffer_entry *hea=
d; /* next item to pop/peek */</span><br><span>     struct buffer_entry *ta=
il; /* last item pushed */</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int size;                  /* current number of entries */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-    int max_size;            =
  /* maximum size list should grow to */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    size_t size;               /* current number of en=
tries */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t =
max_size;           /* maximum size list should grow to */</span><br><span>=
 };</span><br><span> </span><br><span> /**</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1561?us=
p=3Demail">change 1561</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1561?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iecc3e3d5d13cb85c1f287ad4816=
e1e6a7b2bcdef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1561 </div>
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

--vem2589KZqE=--

