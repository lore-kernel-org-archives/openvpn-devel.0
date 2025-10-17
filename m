From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 17 Oct 2025 10:48:58 +0000
References: <gerrit.1760698129000.I4113d14c6ce33818573b0ca5857a9ab39b35a8f4@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9a0b3c397c4ba884adc64d73136efb21e1e91fe4-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UFjSotEKkPE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: push_util: Fix
 conversion warnings
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

--UFjSotEKkPE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1283?usp=3Demail

to review the following change.


Change subject: push_util: Fix conversion warnings
......................................................................

push_util: Fix conversion warnings

Mostly just use better types.

Change-Id: I4113d14c6ce33818573b0ca5857a9ab39b35a8f4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/push_util.c
1 file changed, 15 insertions(+), 24 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/83/1283/1

diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 06b4c8b..8c1a503 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -10,18 +10,13 @@
 #include "ssl_util.h"
 #endif

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 process_incoming_push_update(struct context *c, unsigned int permission_ma=
sk,
                              unsigned int *option_types_found, struct buff=
er *buf,
                              bool msg_sender)
 {
     int ret =3D PUSH_MSG_ERROR;
-    const uint8_t ch =3D buf_read_u8(buf);
+    const int ch =3D buf_read_u8(buf);
     if (ch =3D=3D ',')
     {
         if (apply_push_options(c, &c->options, buf, permission_mask, optio=
n_types_found, c->c2.es,
@@ -57,8 +52,8 @@
  * Return index of last `,` or `0` if it didn't find any.
  * If there is a comma at index `0` it's an error anyway
  */
-static int
-find_first_comma_of_next_bundle(const char *str, int ix)
+static size_t
+find_first_comma_of_next_bundle(const char *str, size_t ix)
 {
     while (ix > 0)
     {
@@ -75,8 +70,8 @@
 static struct buffer
 forge_msg(const char *src, const char *continuation, struct gc_arena *gc)
 {
-    int src_len =3D strlen(src);
-    int con_len =3D continuation ? strlen(continuation) : 0;
+    size_t src_len =3D strlen(src);
+    size_t con_len =3D continuation ? strlen(continuation) : 0;
     struct buffer buf =3D alloc_buf_gc(src_len + sizeof(push_update_cmd) +=
 con_len + 2, gc);

     buf_printf(&buf, "%s,%s%s", push_update_cmd, src, continuation ? conti=
nuation : "");
@@ -93,11 +88,11 @@
     return ret;
 }

-/* It split the messagge (if necessay) and fill msgs with the message chun=
ks.
+/* It split the messagge (if necessary) and fill msgs with the message chu=
nks.
  * Return `false` on failure an `true` on success.
  */
 static bool
-message_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, =
const int safe_cap)
+message_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, =
const size_t safe_cap)
 {
     if (!s || !*s)
     {
@@ -105,7 +100,7 @@
     }

     char *str =3D gc_strdup(s, gc);
-    int i =3D 0;
+    size_t i =3D 0;
     int im =3D 0;

     while (*str)
@@ -113,7 +108,7 @@
         /* + ',' - '/0' */
         if (strlen(str) > safe_cap)
         {
-            int ci =3D find_first_comma_of_next_bundle(str, safe_cap);
+            size_t ci =3D find_first_comma_of_next_bundle(str, safe_cap);
             if (!ci)
             {
                 /* if no commas were found go to fail, do not send any mes=
sage */
@@ -219,7 +214,7 @@
  * @return The number of clients to which the message was sent. Might retu=
rn < 0 in case of error.
  */
 static int
-send_push_update(struct multi_context *m, const void *target, const char *=
msg, const push_update_type type, const int push_bundle_size)
+send_push_update(struct multi_context *m, const void *target, const char *=
msg, const push_update_type type, const size_t push_bundle_size)
 {
     if (dco_enabled(&m->top.options))
     {
@@ -228,19 +223,19 @@
         return 0;
     }

-    if (!msg || !*msg || !m
-        || (!target && type !=3D UPT_BROADCAST))
+    if (!msg || !*msg || !m || (!target && type !=3D UPT_BROADCAST))
     {
         return -EINVAL;
     }

     struct gc_arena gc =3D gc_new();
     /* extra space for possible trailing ifconfig and push-continuation */
-    const int extra =3D 84 + sizeof(push_update_cmd);
+    const size_t extra =3D 84 + sizeof(push_update_cmd);
     /* push_bundle_size is the maximum size of a message, so if the message
      * we want to send exceeds that size we have to split it into smaller =
messages */
-    const int safe_cap =3D push_bundle_size - extra;
-    int msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) =
!=3D 0);
+    ASSERT(push_bundle_size > extra);
+    const size_t safe_cap =3D push_bundle_size - extra;
+    size_t msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_ca=
p) !=3D 0);
     struct buffer *msgs =3D gc_malloc((msgs_num + 1) * sizeof(struct buffe=
r), true, &gc);

     unsigned int option_types_found =3D 0;
@@ -354,7 +349,3 @@
     RETURN_UPDATE_STATUS(n_sent);
 }
 #endif /* ifdef ENABLE_MANAGEMENT */
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1283?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4113d14c6ce33818573b0ca5857a9ab39b35a8f4
Gerrit-Change-Number: 1283
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--UFjSotEKkPE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1283?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">push_util: Fix conversion warnings<br><br>M=
ostly just use better types.<br><br>Change-Id: I4113d14c6ce33818573b0ca5857=
a9ab39b35a8f4<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<=
br>---<br>M src/openvpn/push_util.c<br>1 file changed, 15 insertions(+), 24=
 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/83/1283/1</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/push_=
util.c b/src/openvpn/push_util.c</span><br><span>index 06b4c8b..8c1a503 100=
644</span><br><span>--- a/src/openvpn/push_util.c</span><br><span>+++ b/src=
/openvpn/push_util.c</span><br><span>@@ -10,18 +10,13 @@</span><br><span> #=
include &quot;ssl_util.h&quot;</span><br><span> #endif</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) ||=
 defined(__clang__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#p=
ragma GCC diagnostic push</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#pragma GCC diagnostic ignored &quot;-Wconversion&quot;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> int</span><br><span> process_incom=
ing_push_update(struct context *c, unsigned int permission_mask,</span><br>=
<span>                              unsigned int *option_types_found, struc=
t buffer *buf,</span><br><span>                              bool msg_sende=
r)</span><br><span> {</span><br><span>     int ret =3D PUSH_MSG_ERROR;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t ch =3D b=
uf_read_u8(buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 const int ch =3D buf_read_u8(buf);</span><br><span>     if (ch =3D=3D &#39=
;,&#39;)</span><br><span>     {</span><br><span>         if (apply_push_opt=
ions(c, &amp;c-&gt;options, buf, permission_mask, option_types_found, c-&gt=
;c2.es,</span><br><span>@@ -57,8 +52,8 @@</span><br><span>  * Return index =
of last `,` or `0` if it didn&#39;t find any.</span><br><span>  * If there =
is a comma at index `0` it&#39;s an error anyway</span><br><span>  */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-static int</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-find_first_comma_of_next_bundle(const =
char *str, int ix)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic size_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+find_fi=
rst_comma_of_next_bundle(const char *str, size_t ix)</span><br><span> {</sp=
an><br><span>     while (ix &gt; 0)</span><br><span>     {</span><br><span>=
@@ -75,8 +70,8 @@</span><br><span> static struct buffer</span><br><span> fo=
rge_msg(const char *src, const char *continuation, struct gc_arena *gc)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    in=
t src_len =3D strlen(src);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    int con_len =3D continuation ? strlen(continuation) : 0;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    size_t src_len =3D strlen=
(src);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t co=
n_len =3D continuation ? strlen(continuation) : 0;</span><br><span>     str=
uct buffer buf =3D alloc_buf_gc(src_len + sizeof(push_update_cmd) + con_len=
 + 2, gc);</span><br><span> </span><br><span>     buf_printf(&amp;buf, &quo=
t;%s,%s%s&quot;, push_update_cmd, src, continuation ? continuation : &quot;=
&quot;);</span><br><span>@@ -93,11 +88,11 @@</span><br><span>     return re=
t;</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-/* It split the messagge (if necessay) and fill msgs with=
 the message chunks.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* It split the messagge (if necessary) and fill msgs with the message chu=
nks.</span><br><span>  * Return `false` on failure an `true` on success.</s=
pan><br><span>  */</span><br><span> static bool</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-message_splitter(const char *s, struct buffer *ms=
gs, struct gc_arena *gc, const int safe_cap)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+message_splitter(const char *s, struct buffer *msg=
s, struct gc_arena *gc, const size_t safe_cap)</span><br><span> {</span><br=
><span>     if (!s || !*s)</span><br><span>     {</span><br><span>@@ -105,7=
 +100,7 @@</span><br><span>     }</span><br><span> </span><br><span>     ch=
ar *str =3D gc_strdup(s, gc);</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    int i =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    size_t i =3D 0;</span><br><span>     int im =3D 0;</span><br><span=
> </span><br><span>     while (*str)</span><br><span>@@ -113,7 +108,7 @@</s=
pan><br><span>         /* + &#39;,&#39; - &#39;/0&#39; */</span><br><span> =
        if (strlen(str) &gt; safe_cap)</span><br><span>         {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-            int ci =3D find_fir=
st_comma_of_next_bundle(str, safe_cap);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+            size_t ci =3D find_first_comma_of_next_bund=
le(str, safe_cap);</span><br><span>             if (!ci)</span><br><span>  =
           {</span><br><span>                 /* if no commas were found go=
 to fail, do not send any message */</span><br><span>@@ -219,7 +214,7 @@</s=
pan><br><span>  * @return The number of clients to which the message was se=
nt. Might return &lt; 0 in case of error.</span><br><span>  */</span><br><s=
pan> static int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-send_p=
ush_update(struct multi_context *m, const void *target, const char *msg, co=
nst push_update_type type, const int push_bundle_size)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+send_push_update(struct multi_context *m=
, const void *target, const char *msg, const push_update_type type, const s=
ize_t push_bundle_size)</span><br><span> {</span><br><span>     if (dco_ena=
bled(&amp;m-&gt;top.options))</span><br><span>     {</span><br><span>@@ -22=
8,19 +223,19 @@</span><br><span>         return 0;</span><br><span>     }</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    i=
f (!msg || !*msg || !m</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-        || (!target &amp;&amp; type !=3D UPT_BROADCAST))</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    if (!msg || !*msg || !m || (!targ=
et &amp;&amp; type !=3D UPT_BROADCAST))</span><br><span>     {</span><br><s=
pan>         return -EINVAL;</span><br><span>     }</span><br><span> </span=
><br><span>     struct gc_arena gc =3D gc_new();</span><br><span>     /* ex=
tra space for possible trailing ifconfig and push-continuation */</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    const int extra =3D 84 + si=
zeof(push_update_cmd);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    const size_t extra =3D 84 + sizeof(push_update_cmd);</span><br><span=
>     /* push_bundle_size is the maximum size of a message, so if the messa=
ge</span><br><span>      * we want to send exceeds that size we have to spl=
it it into smaller messages */</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    const int safe_cap =3D push_bundle_size - extra;</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    int msgs_num =3D (strlen(msg) /=
 safe_cap) + ((strlen(msg) % safe_cap) !=3D 0);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    ASSERT(push_bundle_size &gt; extra);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t safe_cap =
=3D push_bundle_size - extra;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    size_t msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) =
% safe_cap) !=3D 0);</span><br><span>     struct buffer *msgs =3D gc_malloc=
((msgs_num + 1) * sizeof(struct buffer), true, &amp;gc);</span><br><span> <=
/span><br><span>     unsigned int option_types_found =3D 0;</span><br><span=
>@@ -354,7 +349,3 @@</span><br><span>     RETURN_UPDATE_STATUS(n_sent);</sp=
an><br><span> }</span><br><span> #endif /* ifdef ENABLE_MANAGEMENT */</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic pop=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1283?usp=3Demail">change 1283</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1283?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4113d14c6ce33818573b0ca5857=
a9ab39b35a8f4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1283 </div>
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

--UFjSotEKkPE=--

