From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 30 Mar 2026 14:16:15 +0000
In-Reply-To: <gerrit.1773071900000.Iecc3e3d5d13cb85c1f287ad4816e1e6a7b2bcdef@...2715...>
References: <gerrit.1773071900000.Iecc3e3d5d13cb85c1f287ad4816e1e6a7b2bcdef@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3f41d80550c1d715c15e55f3f3d68eb1f4ae59d1-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="szL3ZQ58DgU="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--szL3ZQ58DgU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1561?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: buffer: Avoid sign-compare warnings
......................................................................

buffer: Avoid sign-compare warnings

- Switch buffer_list size and max_size to size_t
- Guard some unavoidable size_t -> int conversions

Change-Id: Iecc3e3d5d13cb85c1f287ad4816e1e6a7b2bcdef
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1561
Message-Id: <20260330113648.19896-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
335.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
2 files changed, 10 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/61/1561/6

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Iecc3e3d5d13cb85c1f287ad4816e1e6a7b2bcdef
Gerrit-Change-Number: 1561
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--szL3ZQ58DgU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1561?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">buffer: Avoid sign-compare warnings=
<br><br>- Switch buffer_list size and max_size to size_t<br>- Guard some un=
avoidable size_t -&gt; int conversions<br><br>Change-Id: Iecc3e3d5d13cb85c1=
f287ad4816e1e6a7b2bcdef<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2375...=
41...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: =
https://gerrit.openvpn.net/c/openvpn/+/1561<br>Message-Id: &lt;202603301136=
48.19896-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg36335.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/bu=
ffer.h<br>2 files changed, 10 insertions(+), 18 deletions(-)<br><br></pre><=
pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/6=
1/1561/6</pre><pre style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;"><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</=
span><br><span>index 75110ed..71f3769 100644</span><br><span>--- a/src/open=
vpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ =
-53,7 +53,7 @@</span><br><span> void</span><br><span> buf_size_error(const =
size_t size)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    msg(M_FATAL, &quot;fatal buffer size error, size=3D%lu&quot;,=
 (unsigned long)size);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    msg(M_FATAL, &quot;fatal buffer size error, size=3D%zu&quot;, size);=
</span><br><span> }</span><br><span> </span><br><span> struct buffer</span>=
<br><span>@@ -280,11 +280,6 @@</span><br><span>     return ret;</span><br><=
span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wsign=
-compare&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /*</=
span><br><span>  * write a string to the end of a buffer that was</span><br=
><span>  * truncated by buf_printf</span><br><span>@@ -295,7 +290,7 @@</spa=
n><br><span>     if (buf_forward_capacity(buf) &lt;=3D 1)</span><br><span> =
    {</span><br><span>         size_t len =3D strlen(str) + 1;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        if (len &lt; buf_forward_c=
apacity_total(buf))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        if (buf_size_valid(len) &amp;&amp; (int)len &lt; buf_forward_capaci=
ty_total(buf))</span><br><span>         {</span><br><span>             memc=
py(buf-&gt;data + buf-&gt;capacity - len, str, len);</span><br><span>      =
   }</span><br><span>@@ -782,7 +777,7 @@</span><br><span> buf_string_match_=
head_str(const struct buffer *src, const char *match)</span><br><span> {</s=
pan><br><span>     const size_t size =3D strlen(match);</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (size &gt; src-&gt;len)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    if (!buf_size_valid(size) =
|| (int)size &gt; src-&gt;len)</span><br><span>     {</span><br><span>     =
    return false;</span><br><span>     }</span><br><span>@@ -1196,7 +1191,7=
 @@</span><br><span> bool</span><br><span> buffer_list_defined(const struct=
 buffer_list *ol)</span><br><span> {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    return ol &amp;&amp; ol-&gt;head !=3D NULL;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    return ol &amp;&amp; ol-&gt;=
head !=3D NULL &amp;&amp; ol-&gt;size &gt; 0;</span><br><span> }</span><br>=
<span> </span><br><span> void</span><br><span>@@ -1223,7 +1218,7 @@</span><=
br><span>         struct buffer_entry *e =3D buffer_list_push_data(ol, str,=
 len + 1);</span><br><span>         if (e)</span><br><span>         {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            e-&gt;buf.len =
=3D (int)len; /* Don&#39;t count trailing &#39;\0&#39; as part of length */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            e-&gt;b=
uf.len--; /* Don&#39;t count trailing &#39;\0&#39; as part of length */</sp=
an><br><span>         }</span><br><span>     }</span><br><span> }</span><br=
><span>@@ -1249,6 +1244,7 @@</span><br><span>         }</span><br><span>   =
      e-&gt;buf =3D alloc_buf(size);</span><br><span>         memcpy(e-&gt;=
buf.data, data, size);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        /* Note: size implicitly checked by alloc_buf */</span><br><span=
>         e-&gt;buf.len =3D (int)size;</span><br><span>         ol-&gt;tail=
 =3D e;</span><br><span>     }</span><br><span>@@ -1274,7 +1270,7 @@</span>=
<br><span>     const size_t sep_len =3D strlen(sep);</span><br><span>     s=
truct buffer_entry *more =3D bl-&gt;head;</span><br><span>     size_t size =
=3D 0;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int count =
=3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t co=
unt =3D 0;</span><br><span>     for (; more; ++count)</span><br><span>     =
{</span><br><span>         size_t extra_len =3D BLENZ(&amp;more-&gt;buf) + =
sep_len;</span><br><span>@@ -1313,10 +1309,6 @@</span><br><span>     }</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> buffer_list_=
aggregate(struct buffer_list *bl, const size_t max)</span><br><span> {</spa=
n><br><span>@@ -1326,7 +1318,7 @@</span><br><span> void</span><br><span> bu=
ffer_list_pop(struct buffer_list *ol)</span><br><span> {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    if (ol &amp;&amp; ol-&gt;head)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (buffer_list_defin=
ed(ol))</span><br><span>     {</span><br><span>         struct buffer_entry=
 *e =3D ol-&gt;head-&gt;next;</span><br><span>         free_buf(&amp;ol-&gt=
;head-&gt;buf);</span><br><span>diff --git a/src/openvpn/buffer.h b/src/ope=
nvpn/buffer.h</span><br><span>index 040f752..fcc923b 100644</span><br><span=
>--- a/src/openvpn/buffer.h</span><br><span>+++ b/src/openvpn/buffer.h</spa=
n><br><span>@@ -1149,8 +1149,8 @@</span><br><span> {</span><br><span>     s=
truct buffer_entry *head; /* next item to pop/peek */</span><br><span>     =
struct buffer_entry *tail; /* last item pushed */</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-    int size;                  /* current numbe=
r of entries */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t max_size;              /* maximum size list should grow to */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    size_t size;               =
/* current number of entries */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    size_t max_size;           /* maximum size list should grow=
 to */</span><br><span> };</span><br><span> </span><br><span> /**</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/1561?usp=3Demail">change 1561</a>. To unsubscribe, or for h=
elp writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settin=
gs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.o=
rg/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sche=
ma.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1561?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Iecc3e3d5d13cb85c1f287ad4816=
e1e6a7b2bcdef </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1561 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--szL3ZQ58DgU=--

