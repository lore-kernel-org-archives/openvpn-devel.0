From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 16:24:14 +0000
References: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <aac5e1a1af6861dced6b1dbebc222c5f7f27836a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mAN9Obsc5Ec="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: mbuf: Fix conversion
 warnings in mbuf and related code
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

--mAN9Obsc5Ec=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1433?usp=3Demail

to review the following change.


Change subject: mbuf: Fix conversion warnings in mbuf and related code
......................................................................

mbuf: Fix conversion warnings in mbuf and related code

Mostly these were actually hidden by casts, but fix
them as well by using more fitting types.

Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
M src/openvpn/mbuf.c
2 files changed, 7 insertions(+), 19 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1433/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 293622f..7b9bc74 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -39,11 +39,11 @@
 size_t
 array_mult_safe(const size_t m1, const size_t m2, const size_t extra)
 {
-    const size_t limit =3D 0xFFFFFFFF;
+    const size_t limit =3D UINT32_MAX;
     unsigned long long res =3D
         (unsigned long long)m1 * (unsigned long long)m2 + (unsigned long l=
ong)extra;
     if (unlikely(m1 > limit) || unlikely(m2 > limit) || unlikely(extra > l=
imit)
-        || unlikely(res > (unsigned long long)limit))
+        || unlikely(res > limit))
     {
         msg(M_FATAL, "attempted allocation of excessively large array");
     }
@@ -53,7 +53,7 @@
 void
 buf_size_error(const size_t size)
 {
-    msg(M_FATAL, "fatal buffer size error, size=3D%lu", (unsigned long)siz=
e);
+    msg(M_FATAL, "fatal buffer size error, size=3D%zu", size);
 }

 struct buffer
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 1785d26..7235823 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -34,11 +34,6 @@

 #include "memdbg.h"

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 struct mbuf_set *
 mbuf_init(unsigned int size)
 {
@@ -46,22 +41,17 @@

     struct mbuf_set *ret;
     ALLOC_OBJ_CLEAR(ret, struct mbuf_set);
-    ret->capacity =3D adjust_power_of_2(size);
+    ret->capacity =3D (unsigned int)adjust_power_of_2(size);
     ALLOC_ARRAY(ret->array, struct mbuf_item, ret->capacity);
     return ret;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 void
 mbuf_free(struct mbuf_set *ms)
 {
     if (ms)
     {
-        int i;
-        for (i =3D 0; i < (int)ms->len; ++i)
+        for (unsigned int i =3D 0; i < ms->len; ++i)
         {
             struct mbuf_item *item =3D &ms->array[MBUF_INDEX(ms->head, i, =
ms->capacity)];
             mbuf_free_buf(item->buffer);
@@ -145,8 +135,7 @@
     struct multi_instance *ret =3D NULL;
     if (ms)
     {
-        int i;
-        for (i =3D 0; i < (int)ms->len; ++i)
+        for (unsigned int i =3D 0; i < ms->len; ++i)
         {
             struct mbuf_item *item =3D &ms->array[MBUF_INDEX(ms->head, i, =
ms->capacity)];
             if (item->instance)
@@ -164,8 +153,7 @@
 {
     if (ms)
     {
-        int i;
-        for (i =3D 0; i < (int)ms->len; ++i)
+        for (unsigned int i =3D 0; i < ms->len; ++i)
         {
             struct mbuf_item *item =3D &ms->array[MBUF_INDEX(ms->head, i, =
ms->capacity)];
             if (item->instance =3D=3D mi)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1433?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
Gerrit-Change-Number: 1433
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--mAN9Obsc5Ec=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1433?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">mbuf: Fix conversion warnings in mbuf and r=
elated code<br><br>Mostly these were actually hidden by casts, but fix<br>t=
hem as well by using more fitting types.<br><br>Change-Id: I1d4e0233cf1cb09=
725dbd2caa121acdbf62f0452<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/mbuf.c<br>2 f=
iles changed, 7 insertions(+), 19 deletions(-)<br><br></pre><pre class=3D"b=
locks" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">g=
it pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1433/1</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span=
>index 293622f..7b9bc74 100644</span><br><span>--- a/src/openvpn/buffer.c</=
span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -39,11 +39,11 =
@@</span><br><span> size_t</span><br><span> array_mult_safe(const size_t m1=
, const size_t m2, const size_t extra)</span><br><span> {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const size_t limit =3D 0xFFFFFFFF;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t lim=
it =3D UINT32_MAX;</span><br><span>     unsigned long long res =3D</span><b=
r><span>         (unsigned long long)m1 * (unsigned long long)m2 + (unsigne=
d long long)extra;</span><br><span>     if (unlikely(m1 &gt; limit) || unli=
kely(m2 &gt; limit) || unlikely(extra &gt; limit)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        || unlikely(res &gt; (unsigned long lon=
g)limit))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        ||=
 unlikely(res &gt; limit))</span><br><span>     {</span><br><span>         =
msg(M_FATAL, &quot;attempted allocation of excessively large array&quot;);<=
/span><br><span>     }</span><br><span>@@ -53,7 +53,7 @@</span><br><span> v=
oid</span><br><span> buf_size_error(const size_t size)</span><br><span> {</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    msg(M_FATAL, &quot;=
fatal buffer size error, size=3D%lu&quot;, (unsigned long)size);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATAL, &quot;fatal b=
uffer size error, size=3D%zu&quot;, size);</span><br><span> }</span><br><sp=
an> </span><br><span> struct buffer</span><br><span>diff --git a/src/openvp=
n/mbuf.c b/src/openvpn/mbuf.c</span><br><span>index 1785d26..7235823 100644=
</span><br><span>--- a/src/openvpn/mbuf.c</span><br><span>+++ b/src/openvpn=
/mbuf.c</span><br><span>@@ -34,11 +34,6 @@</span><br><span> </span><br><spa=
n> #include &quot;memdbg.h&quot;</span><br><span> </span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic p=
ush</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagno=
stic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> struct mbuf_set *</span><br><span> mbuf_init(unsigned in=
t size)</span><br><span> {</span><br><span>@@ -46,22 +41,17 @@</span><br><s=
pan> </span><br><span>     struct mbuf_set *ret;</span><br><span>     ALLOC=
_OBJ_CLEAR(ret, struct mbuf_set);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    ret-&gt;capacity =3D adjust_power_of_2(size);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    ret-&gt;capacity =3D (unsigne=
d int)adjust_power_of_2(size);</span><br><span>     ALLOC_ARRAY(ret-&gt;arr=
ay, struct mbuf_item, ret-&gt;capacity);</span><br><span>     return ret;</=
span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-</span><br><span> void</span><br><span> mbuf_free=
(struct mbuf_set *ms)</span><br><span> {</span><br><span>     if (ms)</span=
><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        for=
 (i =3D 0; i &lt; (int)ms-&gt;len; ++i)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        for (unsigned int i =3D 0; i &lt; ms-&gt;len; +=
+i)</span><br><span>         {</span><br><span>             struct mbuf_ite=
m *item =3D &amp;ms-&gt;array[MBUF_INDEX(ms-&gt;head, i, ms-&gt;capacity)];=
</span><br><span>             mbuf_free_buf(item-&gt;buffer);</span><br><sp=
an>@@ -145,8 +135,7 @@</span><br><span>     struct multi_instance *ret =3D =
NULL;</span><br><span>     if (ms)</span><br><span>     {</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; (int)ms-&gt;len; =
++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (un=
signed int i =3D 0; i &lt; ms-&gt;len; ++i)</span><br><span>         {</spa=
n><br><span>             struct mbuf_item *item =3D &amp;ms-&gt;array[MBUF_=
INDEX(ms-&gt;head, i, ms-&gt;capacity)];</span><br><span>             if (i=
tem-&gt;instance)</span><br><span>@@ -164,8 +153,7 @@</span><br><span> {</s=
pan><br><span>     if (ms)</span><br><span>     {</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-        int i;</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; (int)ms-&gt;len; ++i)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        for (unsigned i=
nt i =3D 0; i &lt; ms-&gt;len; ++i)</span><br><span>         {</span><br><s=
pan>             struct mbuf_item *item =3D &amp;ms-&gt;array[MBUF_INDEX(ms=
-&gt;head, i, ms-&gt;capacity)];</span><br><span>             if (item-&gt;=
instance =3D=3D mi)</span><br><span></span><br></pre><p>To view, visit <a h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1433?usp=3Demail">change 1433<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1433?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa12=
1acdbf62f0452 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1433 </div>
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

--mAN9Obsc5Ec=--

