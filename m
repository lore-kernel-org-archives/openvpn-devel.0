From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 21 Aug 2025 16:21:11 +0000
References: <gerrit.1755793268000.Id7a5b2d8dea01bd532f5bcc8abea0e52b00d1169@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8565ae6847620f6a727012c4dcd2863f731e2790-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="afEAGcuDa3k="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Clean up conversion
 warnings related to base64_{en, de}code
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

--afEAGcuDa3k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1148?usp=3Demail

to review the following change.


Change subject: Clean up conversion warnings related to base64_{en,de}code
......................................................................

Clean up conversion warnings related to base64_{en,de}code

It seems unlikely that we can change the API at this point,
especially with the integration into the plugin API.

So
 - clean up the functions internally to not throw -Wconversion
   warnings
 - clean up any warnings on the caller side

Change-Id: Id7a5b2d8dea01bd532f5bcc8abea0e52b00d1169
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/base64.c
M src/openvpn/misc.c
M src/openvpn/proxy.c
M src/openvpn/ssl_mbedtls.c
4 files changed, 31 insertions(+), 28 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/48/1148/1

diff --git a/src/openvpn/base64.c b/src/openvpn/base64.c
index 54d5b79..7af8976 100644
--- a/src/openvpn/base64.c
+++ b/src/openvpn/base64.c
@@ -50,32 +50,32 @@
 int
 openvpn_base64_encode(const void *data, int size, char **str)
 {
-    char *s, *p;
-    int i;
-    int c;
-    const unsigned char *q;
-
     if (size < 0)
     {
         return -1;
     }
-    p =3D s =3D (char *)malloc(size * 4 / 3 + 4);
+    size_t out_size =3D (size_t)size * 4 / 3 + 4;
+    if (out_size > INT_MAX)
+    {
+        return -1;
+    }
+    char *p =3D (char *)malloc(out_size);
+    char *start =3D p;
     if (p =3D=3D NULL)
     {
         return -1;
     }
-    q =3D (const unsigned char *)data;
-    i =3D 0;
-    for (i =3D 0; i < size;)
+    const unsigned char *q =3D (const unsigned char *)data;
+    for (int i =3D 0; i < size;)
     {
-        c =3D q[i++];
-        c *=3D 256;
+        unsigned int c =3D q[i++];
+        c <<=3D 8;
         if (i < size)
         {
             c +=3D q[i];
         }
         i++;
-        c *=3D 256;
+        c <<=3D 8;
         if (i < size)
         {
             c +=3D q[i];
@@ -96,19 +96,18 @@
         p +=3D 4;
     }
     *p =3D 0;
-    *str =3D s;
-    return strlen(s);
+    *str =3D start;
+    return (int)strlen(start);
 }

 static int
 pos(char c)
 {
-    char *p;
-    for (p =3D base64_chars; *p; p++)
+    for (char *p =3D base64_chars; *p; p++)
     {
         if (*p =3D=3D c)
         {
-            return p - base64_chars;
+            return (int)(p - base64_chars);
         }
     }
     return -1;
@@ -119,16 +118,15 @@
 static unsigned int
 token_decode(const char *token)
 {
-    int i;
     unsigned int val =3D 0;
-    int marker =3D 0;
+    unsigned int marker =3D 0;
     if (!token[0] || !token[1] || !token[2] || !token[3])
     {
         return DECODE_ERROR;
     }
-    for (i =3D 0; i < 4; i++)
+    for (unsigned int i =3D 0; i < 4; i++)
     {
-        val *=3D 64;
+        val <<=3D 6;
         if (token[i] =3D=3D '=3D')
         {
             marker++;
@@ -139,7 +137,12 @@
         }
         else
         {
-            val +=3D pos(token[i]);
+            int char_pos =3D pos(token[i]);
+            if (unlikely(char_pos < 0)) /* caller should check */
+            {
+                return DECODE_ERROR;
+            }
+            val +=3D (unsigned int)char_pos;
         }
     }
     if (marker > 2)
@@ -195,5 +198,5 @@
             *q++ =3D val & 0xff;
         }
     }
-    return q - (unsigned char *)data;
+    return (int)(q - (unsigned char *)data);
 }
diff --git a/src/openvpn/misc.c b/src/openvpn/misc.c
index 17f7706..ae5a438 100644
--- a/src/openvpn/misc.c
+++ b/src/openvpn/misc.c
@@ -441,8 +441,8 @@
                     }
                     if (!(flags & GET_USER_PASS_STATIC_CHALLENGE_CONCAT))
                     {
-                        if (openvpn_base64_encode(up->password, strlen(up-=
>password), &pw64) =3D=3D -1
-                            || openvpn_base64_encode(response, strlen(resp=
onse), &resp64) =3D=3D -1)
+                        if (openvpn_base64_encode(up->password, (int)strle=
n(up->password), &pw64) =3D=3D -1
+                            || openvpn_base64_encode(response, (int)strlen=
(response), &resp64) =3D=3D -1)
                         {
                             msg(M_FATAL, "ERROR: could not base64-encode p=
assword/static_response");
                         }
diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c
index 054cc79..9d8fe75 100644
--- a/src/openvpn/proxy.c
+++ b/src/openvpn/proxy.c
@@ -229,7 +229,7 @@
 uint8_t *
 make_base64_string(const uint8_t *str, struct gc_arena *gc)
 {
-    return make_base64_string2(str, strlen((const char *)str), gc);
+    return make_base64_string2(str, (int)strlen((const char *)str), gc);
 }

 static const char *
diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtls.c
index 635b53c..23c1e78 100644
--- a/src/openvpn/ssl_mbedtls.c
+++ b/src/openvpn/ssl_mbedtls.c
@@ -754,7 +754,7 @@
     char *src_b64 =3D NULL;
     char *dst_b64 =3D NULL;

-    if (!management || (openvpn_base64_encode(src, src_len, &src_b64) <=3D=
 0))
+    if (!management || (openvpn_base64_encode(src, (int)src_len, &src_b64)=
 <=3D 0))
     {
         goto cleanup;
     }
@@ -768,7 +768,7 @@
         goto cleanup;
     }

-    if (openvpn_base64_decode(dst_b64, dst, dst_len) !=3D dst_len)
+    if (openvpn_base64_decode(dst_b64, dst, (int)dst_len) !=3D dst_len)
     {
         goto cleanup;
     }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1148?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id7a5b2d8dea01bd532f5bcc8abea0e52b00d1169
Gerrit-Change-Number: 1148
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--afEAGcuDa3k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1148?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Clean up conversion warnings related to base64_{en,de}code<b=
r><br>It seems unlikely that we can change the API at this point,<br>especi=
ally with the integration into the plugin API.<br><br>So<br> - clean up the=
 functions internally to not throw -Wconversion<br>   warnings<br> - clean =
up any warnings on the caller side<br><br>Change-Id: Id7a5b2d8dea01bd532f5b=
cc8abea0e52b00d1169<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2723...=
.&gt;<br>---<br>M src/openvpn/base64.c<br>M src/openvpn/misc.c<br>M src/ope=
nvpn/proxy.c<br>M src/openvpn/ssl_mbedtls.c<br>4 files changed, 31 insertio=
ns(+), 28 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/48/1148/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/src/openvpn/base64.c b/sr=
c/openvpn/base64.c</span><br><span>index 54d5b79..7af8976 100644</span><br>=
<span>--- a/src/openvpn/base64.c</span><br><span>+++ b/src/openvpn/base64.c=
</span><br><span>@@ -50,32 +50,32 @@</span><br><span> int</span><br><span> =
openvpn_base64_encode(const void *data, int size, char **str)</span><br><sp=
an> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *s, *p;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    int i;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    int c;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    const unsigned char *q;</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     if (size &lt; 0=
)</span><br><span>     {</span><br><span>         return -1;</span><br><spa=
n>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    p =3D s =
=3D (char *)malloc(size * 4 / 3 + 4);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    size_t out_size =3D (size_t)size * 4 / 3 + 4;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    if (out_size &gt; INT_M=
AX)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        return -1;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    char *p =3D (char *)malloc(out_size);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    char *start =3D p;<=
/span><br><span>     if (p =3D=3D NULL)</span><br><span>     {</span><br><s=
pan>         return -1;</span><br><span>     }</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    q =3D (const unsigned char *)data;</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    i =3D 0;</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    for (i =3D 0; i &lt; size;)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    const unsigned char *q =3D=
 (const unsigned char *)data;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    for (int i =3D 0; i &lt; size;)</span><br><span>     {</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        c =3D q[i++];</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        c *=3D 256;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        unsigned int c =3D q=
[i++];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c &lt=
;&lt;=3D 8;</span><br><span>         if (i &lt; size)</span><br><span>     =
    {</span><br><span>             c +=3D q[i];</span><br><span>         }<=
/span><br><span>         i++;</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        c *=3D 256;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        c &lt;&lt;=3D 8;</span><br><span>         if (i &lt; size)<=
/span><br><span>         {</span><br><span>             c +=3D q[i];</span>=
<br><span>@@ -96,19 +96,18 @@</span><br><span>         p +=3D 4;</span><br>=
<span>     }</span><br><span>     *p =3D 0;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    *str =3D s;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    return strlen(s);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    *str =3D start;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    return (int)strlen(start);</span><br><span> }</span><=
br><span> </span><br><span> static int</span><br><span> pos(char c)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    char *=
p;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (p =3D base=
64_chars; *p; p++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   for (char *p =3D base64_chars; *p; p++)</span><br><span>     {</span><br=
><span>         if (*p =3D=3D c)</span><br><span>         {</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-            return p - base64_chars;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+            return (=
int)(p - base64_chars);</span><br><span>         }</span><br><span>     }</=
span><br><span>     return -1;</span><br><span>@@ -119,16 +118,15 @@</span>=
<br><span> static unsigned int</span><br><span> token_decode(const char *to=
ken)</span><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    int i;</span><br><span>     unsigned int val =3D 0;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    int marker =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    unsigned int marker =3D 0;</span>=
<br><span>     if (!token[0] || !token[1] || !token[2] || !token[3])</span>=
<br><span>     {</span><br><span>         return DECODE_ERROR;</span><br><s=
pan>     }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for (i =
=3D 0; i &lt; 4; i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    for (unsigned int i =3D 0; i &lt; 4; i++)</span><br><span>     {</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-        val *=3D 64;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        val &lt;&lt;=3D 6=
;</span><br><span>         if (token[i] =3D=3D &#39;=3D&#39;)</span><br><sp=
an>         {</span><br><span>             marker++;</span><br><span>@@ -13=
9,7 +137,12 @@</span><br><span>         }</span><br><span>         else</sp=
an><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-            val +=3D pos(token[i]);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            int char_pos =3D pos(token[i]);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            if (unlikely(char_pos=
 &lt; 0)) /* caller should check */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+            {</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                return DECODE_ERROR;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+            }</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+            val +=3D (unsigned int)char_pos;</span><br=
><span>         }</span><br><span>     }</span><br><span>     if (marker &g=
t; 2)</span><br><span>@@ -195,5 +198,5 @@</span><br><span>             *q++=
 =3D val &amp; 0xff;</span><br><span>         }</span><br><span>     }</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return q - (unsigned c=
har *)data;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    retu=
rn (int)(q - (unsigned char *)data);</span><br><span> }</span><br><span>dif=
f --git a/src/openvpn/misc.c b/src/openvpn/misc.c</span><br><span>index 17f=
7706..ae5a438 100644</span><br><span>--- a/src/openvpn/misc.c</span><br><sp=
an>+++ b/src/openvpn/misc.c</span><br><span>@@ -441,8 +441,8 @@</span><br><=
span>                     }</span><br><span>                     if (!(flag=
s &amp; GET_USER_PASS_STATIC_CHALLENGE_CONCAT))</span><br><span>           =
          {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-          =
              if (openvpn_base64_encode(up-&gt;password, strlen(up-&gt;pass=
word), &amp;pw64) =3D=3D -1</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-                            || openvpn_base64_encode(response, strlen=
(response), &amp;resp64) =3D=3D -1)</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+                        if (openvpn_base64_encode(up-&gt;pa=
ssword, (int)strlen(up-&gt;password), &amp;pw64) =3D=3D -1</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                            || openv=
pn_base64_encode(response, (int)strlen(response), &amp;resp64) =3D=3D -1)</=
span><br><span>                         {</span><br><span>                 =
            msg(M_FATAL, &quot;ERROR: could not base64-encode password/stat=
ic_response&quot;);</span><br><span>                         }</span><br><s=
pan>diff --git a/src/openvpn/proxy.c b/src/openvpn/proxy.c</span><br><span>=
index 054cc79..9d8fe75 100644</span><br><span>--- a/src/openvpn/proxy.c</sp=
an><br><span>+++ b/src/openvpn/proxy.c</span><br><span>@@ -229,7 +229,7 @@<=
/span><br><span> uint8_t *</span><br><span> make_base64_string(const uint8_=
t *str, struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return make_base64_string2(str, strlen((const=
 char *)str), gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   return make_base64_string2(str, (int)strlen((const char *)str), gc);</sp=
an><br><span> }</span><br><span> </span><br><span> static const char *</spa=
n><br><span>diff --git a/src/openvpn/ssl_mbedtls.c b/src/openvpn/ssl_mbedtl=
s.c</span><br><span>index 635b53c..23c1e78 100644</span><br><span>--- a/src=
/openvpn/ssl_mbedtls.c</span><br><span>+++ b/src/openvpn/ssl_mbedtls.c</spa=
n><br><span>@@ -754,7 +754,7 @@</span><br><span>     char *src_b64 =3D NULL=
;</span><br><span>     char *dst_b64 =3D NULL;</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    if (!management || (openvpn_=
base64_encode(src, src_len, &amp;src_b64) &lt;=3D 0))</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    if (!management || (openvpn_base64_en=
code(src, (int)src_len, &amp;src_b64) &lt;=3D 0))</span><br><span>     {</s=
pan><br><span>         goto cleanup;</span><br><span>     }</span><br><span=
>@@ -768,7 +768,7 @@</span><br><span>         goto cleanup;</span><br><span=
>     }</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    if (openvpn_base64_decode(dst_b64, dst, dst_len) !=3D dst_len)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (openvpn_base64_d=
ecode(dst_b64, dst, (int)dst_len) !=3D dst_len)</span><br><span>     {</spa=
n><br><span>         goto cleanup;</span><br><span>     }</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1148?usp=3Demail">change 1148</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">sett=
ings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><di=
v itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><=
link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1148?us=
p=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7a5b2d8dea01bd532f5bcc8abe=
a0e52b00d1169 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1148 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--afEAGcuDa3k=--

