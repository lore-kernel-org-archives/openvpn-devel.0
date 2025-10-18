From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 18 Oct 2025 18:03:47 +0000
In-Reply-To: <gerrit.1760698129000.I4113d14c6ce33818573b0ca5857a9ab39b35a8f4@...2715...>
References: <gerrit.1760698129000.I4113d14c6ce33818573b0ca5857a9ab39b35a8f4@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., marco@...2726...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <b49c454c9c6c6eecca55e0cd7486e33d07911c95-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Waki7E3hFNY="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: mrbff <marco@...2726...>, plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Waki7E3hFNY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2.

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
83?usp=3Demail )

Change subject: push_util: Fix conversion warnings
......................................................................

push_util: Fix conversion warnings

Mostly just use better types.

Change-Id: I4113d14c6ce33818573b0ca5857a9ab39b35a8f4
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: mrbff <marco@...2726...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1283
Message-Id: <20251018170237.21928-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59248341/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/push_util.c
1 file changed, 15 insertions(+), 24 deletions(-)




diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c
index 0eddcae..552679a 100644
--- a/src/openvpn/push_util.c
+++ b/src/openvpn/push_util.c
@@ -10,17 +10,12 @@
 #include "ssl_util.h"
 #endif

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 int
 process_push_update(struct context *c, struct options *o, unsigned int per=
mission_mask,
                     unsigned int *option_types_found, struct buffer *buf, =
bool msg_sender)
 {
     int ret =3D PUSH_MSG_ERROR;
-    const uint8_t ch =3D buf_read_u8(buf);
+    const int ch =3D buf_read_u8(buf);
     if (ch =3D=3D ',')
     {
         if (apply_push_options(c, o, buf, permission_mask, option_types_fo=
und, c->c2.es,
@@ -56,8 +51,8 @@
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
@@ -74,8 +69,8 @@
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
@@ -92,11 +87,11 @@
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
@@ -104,7 +99,7 @@
     }

     char *str =3D gc_strdup(s, gc);
-    int i =3D 0;
+    size_t i =3D 0;
     int im =3D 0;

     while (*str)
@@ -112,7 +107,7 @@
         /* + ',' - '/0' */
         if (strlen(str) > safe_cap)
         {
-            int ci =3D find_first_comma_of_next_bundle(str, safe_cap);
+            size_t ci =3D find_first_comma_of_next_bundle(str, safe_cap);
             if (!ci)
             {
                 /* if no commas were found go to fail, do not send any mes=
sage */
@@ -254,7 +249,7 @@
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
@@ -263,19 +258,19 @@
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

     msgs[msgs_num].data =3D NULL;
@@ -374,7 +369,3 @@
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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4113d14c6ce33818573b0ca5857a9ab39b35a8f4
Gerrit-Change-Number: 1283
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: mrbff <marco@...2726...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: cron2 <gert@...1296...>

--Waki7E3hFNY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: cron2. </p>
<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1283?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre class=3D"blocks" style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">push_util: Fix conversion wa=
rnings<br><br>Mostly just use better types.<br><br>Change-Id: I4113d14c6ce3=
3818573b0ca5857a9ab39b35a8f4<br>Signed-off-by: Frank Lichtenheld &lt;frank@=
...2641...&gt;<br>Acked-by: mrbff &lt;marco@...2726...&gt;<br>Gerrit URL: h=
ttps://gerrit.openvpn.net/c/openvpn/+/1283<br>Message-Id: &lt;2025101817023=
7.21928-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mai=
lman/message/59248341/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M src/openvpn/push_util.c<br>1 file changed, 15 insertions(+),=
 24 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/push_util.c b/src/openvpn/push_util.c</span><br=
><span>index 0eddcae..552679a 100644</span><br><span>--- a/src/openvpn/push=
_util.c</span><br><span>+++ b/src/openvpn/push_util.c</span><br><span>@@ -1=
0,17 +10,12 @@</span><br><span> #include &quot;ssl_util.h&quot;</span><br><=
span> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-#if defined(__GNUC__) || defined(__clang__)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic push</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnostic ignored &quot;=
-Wconversion&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
int</span><br><span> process_push_update(struct context *c, struct options =
*o, unsigned int permission_mask,</span><br><span>                     unsi=
gned int *option_types_found, struct buffer *buf, bool msg_sender)</span><b=
r><span> {</span><br><span>     int ret =3D PUSH_MSG_ERROR;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    const uint8_t ch =3D buf_read_u8(=
buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const int =
ch =3D buf_read_u8(buf);</span><br><span>     if (ch =3D=3D &#39;,&#39;)</s=
pan><br><span>     {</span><br><span>         if (apply_push_options(c, o, =
buf, permission_mask, option_types_found, c-&gt;c2.es,</span><br><span>@@ -=
56,8 +51,8 @@</span><br><span>  * Return index of last `,` or `0` if it did=
n&#39;t find any.</span><br><span>  * If there is a comma at index `0` it&#=
39;s an error anyway</span><br><span>  */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-static int</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-find_first_comma_of_next_bundle(const char *str, int ix)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static size_t</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+find_first_comma_of_next_bundle(con=
st char *str, size_t ix)</span><br><span> {</span><br><span>     while (ix =
&gt; 0)</span><br><span>     {</span><br><span>@@ -74,8 +69,8 @@</span><br>=
<span> static struct buffer</span><br><span> forge_msg(const char *src, con=
st char *continuation, struct gc_arena *gc)</span><br><span> {</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    int src_len =3D strlen(src);</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int con_len =3D con=
tinuation ? strlen(continuation) : 0;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    size_t src_len =3D strlen(src);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    size_t con_len =3D continuation ? str=
len(continuation) : 0;</span><br><span>     struct buffer buf =3D alloc_buf=
_gc(src_len + sizeof(push_update_cmd) + con_len + 2, gc);</span><br><span> =
</span><br><span>     buf_printf(&amp;buf, &quot;%s,%s%s&quot;, push_update=
_cmd, src, continuation ? continuation : &quot;&quot;);</span><br><span>@@ =
-92,11 +87,11 @@</span><br><span>     return ret;</span><br><span> }</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* It spli=
t the messagge (if necessay) and fill msgs with the message chunks.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* It split the messagge (i=
f necessary) and fill msgs with the message chunks.</span><br><span>  * Ret=
urn `false` on failure an `true` on success.</span><br><span>  */</span><br=
><span> static bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-me=
ssage_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, con=
st int safe_cap)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+mes=
sage_splitter(const char *s, struct buffer *msgs, struct gc_arena *gc, cons=
t size_t safe_cap)</span><br><span> {</span><br><span>     if (!s || !*s)</=
span><br><span>     {</span><br><span>@@ -104,7 +99,7 @@</span><br><span>  =
   }</span><br><span> </span><br><span>     char *str =3D gc_strdup(s, gc);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t i =3D 0;</spa=
n><br><span>     int im =3D 0;</span><br><span> </span><br><span>     while=
 (*str)</span><br><span>@@ -112,7 +107,7 @@</span><br><span>         /* + &=
#39;,&#39; - &#39;/0&#39; */</span><br><span>         if (strlen(str) &gt; =
safe_cap)</span><br><span>         {</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-            int ci =3D find_first_comma_of_next_bundle(str, =
safe_cap);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   size_t ci =3D find_first_comma_of_next_bundle(str, safe_cap);</span><br>=
<span>             if (!ci)</span><br><span>             {</span><br><span>=
                 /* if no commas were found go to fail, do not send any mes=
sage */</span><br><span>@@ -254,7 +249,7 @@</span><br><span>  * @return The=
 number of clients to which the message was sent. Might return &lt; 0 in ca=
se of error.</span><br><span>  */</span><br><span> static int</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-send_push_update(struct multi_conte=
xt *m, const void *target, const char *msg, const push_update_type type, co=
nst int push_bundle_size)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+send_push_update(struct multi_context *m, const void *target, const c=
har *msg, const push_update_type type, const size_t push_bundle_size)</span=
><br><span> {</span><br><span>     if (dco_enabled(&amp;m-&gt;top.options))=
</span><br><span>     {</span><br><span>@@ -263,19 +258,19 @@</span><br><sp=
an>         return 0;</span><br><span>     }</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    if (!msg || !*msg || !m</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        || (!target &amp;&am=
p; type !=3D UPT_BROADCAST))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    if (!msg || !*msg || !m || (!target &amp;&amp; type !=3D UPT_B=
ROADCAST))</span><br><span>     {</span><br><span>         return -EINVAL;<=
/span><br><span>     }</span><br><span> </span><br><span>     struct gc_are=
na gc =3D gc_new();</span><br><span>     /* extra space for possible traili=
ng ifconfig and push-continuation */</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    const int extra =3D 84 + sizeof(push_update_cmd);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    const size_t extra =3D=
 84 + sizeof(push_update_cmd);</span><br><span>     /* push_bundle_size is =
the maximum size of a message, so if the message</span><br><span>      * we=
 want to send exceeds that size we have to split it into smaller messages *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const int safe_c=
ap =3D push_bundle_size - extra;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-    int msgs_num =3D (strlen(msg) / safe_cap) + ((strlen(msg) % =
safe_cap) !=3D 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   ASSERT(push_bundle_size &gt; extra);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    const size_t safe_cap =3D push_bundle_size - extra;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    size_t msgs_num=
 =3D (strlen(msg) / safe_cap) + ((strlen(msg) % safe_cap) !=3D 0);</span><b=
r><span>     struct buffer *msgs =3D gc_malloc((msgs_num + 1) * sizeof(stru=
ct buffer), true, &amp;gc);</span><br><span> </span><br><span>     msgs[msg=
s_num].data =3D NULL;</span><br><span>@@ -374,7 +369,3 @@</span><br><span> =
    RETURN_UPDATE_STATUS(n_sent);</span><br><span> }</span><br><span> #endi=
f /* ifdef ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined=
(__GNUC__) || defined(__clang__)</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#pragma GCC diagnostic pop</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#endif</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1283?usp=3Demail">change 12=
83</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/1283?usp=3Demail"/><meta itemp=
rop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4113d14c6ce33818573b0ca5857=
a9ab39b35a8f4 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1283 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: mrbff &lt;marco@...2726...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>

</body></html>=

--Waki7E3hFNY=--

