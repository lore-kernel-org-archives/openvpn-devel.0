From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 11 Dec 2025 15:42:28 +0000
In-Reply-To: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@...2715...>
References: <gerrit.1765383841000.I1d4e0233cf1cb09725dbd2caa121acdbf62f0452@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <18c0f9df46a07ddad0241b0cc2ffe92c2b2495df-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="HO5yd6nNVyg="; charset=UTF-8
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

--HO5yd6nNVyg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1433?usp=3Demail

to look at the new patch set (#3).


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
2 files changed, 6 insertions(+), 18 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1433/3

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 40baca6..dca44d6 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -43,7 +43,7 @@
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
index 42858ec..9813237 100644
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa121acdbf62f0452
Gerrit-Change-Number: 1433
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--HO5yd6nNVyg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1433?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">mbuf: Fix conversion warnings in mbuf and relate=
d code<br><br>Mostly these were actually hidden by casts, but fix<br>them a=
s well by using more fitting types.<br><br>Change-Id: I1d4e0233cf1cb09725db=
d2caa121acdbf62f0452<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2724...=
..&gt;<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/mbuf.c<br>2 files =
changed, 6 insertions(+), 18 deletions(-)<br><br></pre><pre class=3D"blocks=
" style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pu=
ll ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1433/3</pre><pre =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>di=
ff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span>inde=
x 40baca6..dca44d6 100644</span><br><span>--- a/src/openvpn/buffer.c</span>=
<br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -43,7 +43,7 @@</spa=
n><br><span>     unsigned long long res =3D</span><br><span>         (unsig=
ned long long)m1 * (unsigned long long)m2 + (unsigned long long)extra;</spa=
n><br><span>     if (unlikely(m1 &gt; limit) || unlikely(m2 &gt; limit) || =
unlikely(extra &gt; limit)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-        || unlikely(res &gt; (unsigned long long)limit))</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        || unlikely(res &gt; limi=
t))</span><br><span>     {</span><br><span>         msg(M_FATAL, &quot;atte=
mpted allocation of excessively large array&quot;);</span><br><span>     }<=
/span><br><span>@@ -53,7 +53,7 @@</span><br><span> void</span><br><span> bu=
f_size_error(const size_t size)</span><br><span> {</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    msg(M_FATAL, &quot;fatal buffer size error=
, size=3D%lu&quot;, (unsigned long)size);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    msg(M_FATAL, &quot;fatal buffer size error, size=
=3D%zu&quot;, size);</span><br><span> }</span><br><span> </span><br><span> =
struct buffer</span><br><span>diff --git a/src/openvpn/mbuf.c b/src/openvpn=
/mbuf.c</span><br><span>index 42858ec..9813237 100644</span><br><span>--- a=
/src/openvpn/mbuf.c</span><br><span>+++ b/src/openvpn/mbuf.c</span><br><spa=
n>@@ -34,11 +34,6 @@</span><br><span> </span><br><span> #include &quot;memd=
bg.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;-Wc=
onversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> str=
uct mbuf_set *</span><br><span> mbuf_init(unsigned int size)</span><br><spa=
n> {</span><br><span>@@ -46,22 +41,17 @@</span><br><span> </span><br><span>=
     struct mbuf_set *ret;</span><br><span>     ALLOC_OBJ_CLEAR(ret, struct=
 mbuf_set);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ret-&g=
t;capacity =3D adjust_power_of_2(size);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    ret-&gt;capacity =3D (unsigned int)adjust_power_of_=
2(size);</span><br><span>     ALLOC_ARRAY(ret-&gt;array, struct mbuf_item, =
ret-&gt;capacity);</span><br><span>     return ret;</span><br><span> }</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defi=
ned(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> void</span><br><span> mbuf_free(struct mbuf_set *ms)<=
/span><br><span> {</span><br><span>     if (ms)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        int i;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-        for (i =3D 0; i &lt; (int=
)ms-&gt;len; ++i)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      for (unsigned int i =3D 0; i &lt; ms-&gt;len; ++i)</span><br><span>  =
       {</span><br><span>             struct mbuf_item *item =3D &amp;ms-&g=
t;array[MBUF_INDEX(ms-&gt;head, i, ms-&gt;capacity)];</span><br><span>     =
        mbuf_free_buf(item-&gt;buffer);</span><br><span>@@ -145,8 +135,7 @@=
</span><br><span>     struct multi_instance *ret =3D NULL;</span><br><span>=
     if (ms)</span><br><span>     {</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        for (i =3D 0; i &lt; (int)ms-&gt;len; ++i)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        for (unsigned int i =3D 0; i =
&lt; ms-&gt;len; ++i)</span><br><span>         {</span><br><span>          =
   struct mbuf_item *item =3D &amp;ms-&gt;array[MBUF_INDEX(ms-&gt;head, i, =
ms-&gt;capacity)];</span><br><span>             if (item-&gt;instance)</spa=
n><br><span>@@ -164,8 +153,7 @@</span><br><span> {</span><br><span>     if =
(ms)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        int i;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
       for (i =3D 0; i &lt; (int)ms-&gt;len; ++i)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        for (unsigned int i =3D 0; i &lt; ms-=
&gt;len; ++i)</span><br><span>         {</span><br><span>             struc=
t mbuf_item *item =3D &amp;ms-&gt;array[MBUF_INDEX(ms-&gt;head, i, ms-&gt;c=
apacity)];</span><br><span>             if (item-&gt;instance =3D=3D mi)</s=
pan><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.o=
penvpn.net/c/openvpn/+/1433?usp=3Demail">change 1433</a>. To unsubscribe, o=
r for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net=
/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1433?usp=3Demail"/><meta itemprop=3D"name" content=3D"V=
iew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I1d4e0233cf1cb09725dbd2caa12=
1acdbf62f0452 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1433 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--HO5yd6nNVyg=--

