From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 24 Oct 2025 16:52:52 +0000
References: <gerrit.1761324750000.Id7bacec23edc6dcd94465c308ea2144c7329a0c1@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <8b8e5bfc079770453d9cadfe95c4401dd4138706-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LRB25u5axE8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: ssl: Clean up type
 handling in export_user_keying_material()
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

--LRB25u5axE8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1301?usp=3Demail

to review the following change.


Change subject: ssl: Clean up type handling in export_user_keying_material()
......................................................................

ssl: Clean up type handling in export_user_keying_material()

For this we actually change the API of the
format_hex{,_ex} functions by changing int
to size_t for length parameters. While we
call this function with int paramters in
a lot of places (usually BLEN), this will
not produce warnings under
-Wno-sign-conversion. And we're sure those
values are positive since format_hex already
uses size_t internally.

Change-Id: Id7bacec23edc6dcd94465c308ea2144c7329a0c1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M src/openvpn/ssl.c
3 files changed, 12 insertions(+), 13 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/1301/1

diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index 28de00f..293622f 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -480,18 +480,17 @@
  */

 char *
-format_hex_ex(const uint8_t *data, int size, int maxoutput, unsigned int s=
pace_break_flags,
+format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, unsigned=
 int space_break_flags,
               const char *separator, struct gc_arena *gc)
 {
     const size_t bytes_per_hexblock =3D space_break_flags & FHE_SPACE_BREA=
K_MASK;
     const size_t separator_len =3D separator ? strlen(separator) : 0;
-    static_assert(INT_MAX <=3D SIZE_MAX, "Code assumes INT_MAX <=3D SIZE_M=
AX");
     const size_t out_len =3D maxoutput > 0
                                ? maxoutput
                                : ((size * 2) + ((size / bytes_per_hexblock=
) * separator_len) + 2);

     struct buffer out =3D alloc_buf_gc(out_len, gc);
-    for (int i =3D 0; i < size; ++i)
+    for (size_t i =3D 0; i < size; ++i)
     {
         if (separator && i && !(i % bytes_per_hexblock))
         {
diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 148cee0..ab2a29d 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -496,11 +496,11 @@
  */
 #define FHE_SPACE_BREAK_MASK 0xFF  /* space_break parameter in lower 8 bit=
s */
 #define FHE_CAPS             0x100 /* output hex in caps */
-char *format_hex_ex(const uint8_t *data, int size, int maxoutput, unsigned=
 int space_break_flags,
+char *format_hex_ex(const uint8_t *data, size_t size, size_t maxoutput, un=
signed int space_break_flags,
                     const char *separator, struct gc_arena *gc);

 static inline char *
-format_hex(const uint8_t *data, int size, int maxoutput, struct gc_arena *=
gc)
+format_hex(const uint8_t *data, size_t size, size_t maxoutput, struct gc_a=
rena *gc)
 {
     return format_hex_ex(data, size, maxoutput, 4, " ", gc);
 }
diff --git a/src/openvpn/ssl.c b/src/openvpn/ssl.c
index 39abb59..819a1ef 100644
--- a/src/openvpn/ssl.c
+++ b/src/openvpn/ssl.c
@@ -1830,11 +1830,6 @@
     return len;
 }

-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
 static char *
 read_string_alloc(struct buffer *buf)
 {
@@ -2175,15 +2170,15 @@
 {
     if (session->opt->ekm_size > 0)
     {
-        unsigned int size =3D session->opt->ekm_size;
+        const size_t size =3D session->opt->ekm_size;
         struct gc_arena gc =3D gc_new();

-        unsigned char *ekm =3D gc_malloc(session->opt->ekm_size, true, &gc=
);
+        unsigned char *ekm =3D gc_malloc(size, true, &gc);
         if (key_state_export_keying_material(session, session->opt->ekm_la=
bel,
                                              session->opt->ekm_label_size,=
 ekm,
                                              session->opt->ekm_size))
         {
-            unsigned int len =3D (size * 2) + 2;
+            const size_t len =3D (size * 2) + 2;

             const char *key =3D format_hex_ex(ekm, size, len, 0, NULL, &gc=
);
             setenv_str(session->opt->es, "exported_keying_material", key);
@@ -2200,6 +2195,11 @@
     }
 }

+#if defined(__GNUC__) || defined(__clang__)
+#pragma GCC diagnostic push
+#pragma GCC diagnostic ignored "-Wconversion"
+#endif
+
 /**
  * Handle reading key data, peer-info, username/password, OCC
  * from the TLS control channel (cleartext).

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1301?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Id7bacec23edc6dcd94465c308ea2144c7329a0c1
Gerrit-Change-Number: 1301
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--LRB25u5axE8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1301?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">ssl: Clean up type handling in export_user_=
keying_material()<br><br>For this we actually change the API of the<br>form=
at_hex{,_ex} functions by changing int<br>to size_t for length parameters. =
While we<br>call this function with int paramters in<br>a lot of places (us=
ually BLEN), this will<br>not produce warnings under<br>-Wno-sign-conversio=
n. And we&#39;re sure those<br>values are positive since format_hex already=
<br>uses size_t internally.<br><br>Change-Id: Id7bacec23edc6dcd94465c308ea2=
144c7329a0c1<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<b=
r>---<br>M src/openvpn/buffer.c<br>M src/openvpn/buffer.h<br>M src/openvpn/=
ssl.c<br>3 files changed, 12 insertions(+), 13 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01=
/1301/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</s=
pan><br><span>index 28de00f..293622f 100644</span><br><span>--- a/src/openv=
pn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -=
480,18 +480,17 @@</span><br><span>  */</span><br><span> </span><br><span> c=
har *</span><br><span style=3D"color: hsl(0, 100%, 40%);">-format_hex_ex(co=
nst uint8_t *data, int size, int maxoutput, unsigned int space_break_flags,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+format_hex_ex(const=
 uint8_t *data, size_t size, size_t maxoutput, unsigned int space_break_fla=
gs,</span><br><span>               const char *separator, struct gc_arena *=
gc)</span><br><span> {</span><br><span>     const size_t bytes_per_hexblock=
 =3D space_break_flags &amp; FHE_SPACE_BREAK_MASK;</span><br><span>     con=
st size_t separator_len =3D separator ? strlen(separator) : 0;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    static_assert(INT_MAX &lt;=3D =
SIZE_MAX, &quot;Code assumes INT_MAX &lt;=3D SIZE_MAX&quot;);</span><br><sp=
an>     const size_t out_len =3D maxoutput &gt; 0</span><br><span>         =
                       ? maxoutput</span><br><span>                        =
        : ((size * 2) + ((size / bytes_per_hexblock) * separator_len) + 2);=
</span><br><span> </span><br><span>     struct buffer out =3D alloc_buf_gc(=
out_len, gc);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    for =
(int i =3D 0; i &lt; size; ++i)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    for (size_t i =3D 0; i &lt; size; ++i)</span><br><span>    =
 {</span><br><span>         if (separator &amp;&amp; i &amp;&amp; !(i % byt=
es_per_hexblock))</span><br><span>         {</span><br><span>diff --git a/s=
rc/openvpn/buffer.h b/src/openvpn/buffer.h</span><br><span>index 148cee0..a=
b2a29d 100644</span><br><span>--- a/src/openvpn/buffer.h</span><br><span>++=
+ b/src/openvpn/buffer.h</span><br><span>@@ -496,11 +496,11 @@</span><br><s=
pan>  */</span><br><span> #define FHE_SPACE_BREAK_MASK 0xFF  /* space_break=
 parameter in lower 8 bits */</span><br><span> #define FHE_CAPS            =
 0x100 /* output hex in caps */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-char *format_hex_ex(const uint8_t *data, int size, int maxoutput,=
 unsigned int space_break_flags,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+char *format_hex_ex(const uint8_t *data, size_t size, size_t m=
axoutput, unsigned int space_break_flags,</span><br><span>                 =
    const char *separator, struct gc_arena *gc);</span><br><span> </span><b=
r><span> static inline char *</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-format_hex(const uint8_t *data, int size, int maxoutput, struct gc_=
arena *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+format_he=
x(const uint8_t *data, size_t size, size_t maxoutput, struct gc_arena *gc)<=
/span><br><span> {</span><br><span>     return format_hex_ex(data, size, ma=
xoutput, 4, &quot; &quot;, gc);</span><br><span> }</span><br><span>diff --g=
it a/src/openvpn/ssl.c b/src/openvpn/ssl.c</span><br><span>index 39abb59..8=
19a1ef 100644</span><br><span>--- a/src/openvpn/ssl.c</span><br><span>+++ b=
/src/openvpn/ssl.c</span><br><span>@@ -1830,11 +1830,6 @@</span><br><span> =
    return len;</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(__GNUC__) || defined(__clang__)=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC diagnosti=
c push</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#pragma GCC dia=
gnostic ignored &quot;-Wconversion&quot;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> static char *</span><br><span> read_string_alloc(stru=
ct buffer *buf)</span><br><span> {</span><br><span>@@ -2175,15 +2170,15 @@<=
/span><br><span> {</span><br><span>     if (session-&gt;opt-&gt;ekm_size &g=
t; 0)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-        unsigned int size =3D session-&gt;opt-&gt;ekm_size;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        const size_t size =
=3D session-&gt;opt-&gt;ekm_size;</span><br><span>         struct gc_arena =
gc =3D gc_new();</span><br><span> </span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        unsigned char *ekm =3D gc_malloc(session-&gt;opt-&gt;e=
km_size, true, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        unsigned char *ekm =3D gc_malloc(size, true, &amp;gc);</span><=
br><span>         if (key_state_export_keying_material(session, session-&gt=
;opt-&gt;ekm_label,</span><br><span>                                       =
       session-&gt;opt-&gt;ekm_label_size, ekm,</span><br><span>           =
                                   session-&gt;opt-&gt;ekm_size))</span><br=
><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        unsigned int len =3D (size * 2) + 2;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+            const size_t len =3D (size * 2) + 2;</=
span><br><span> </span><br><span>             const char *key =3D format_he=
x_ex(ekm, size, len, 0, NULL, &amp;gc);</span><br><span>             setenv=
_str(session-&gt;opt-&gt;es, &quot;exported_keying_material&quot;, key);</s=
pan><br><span>@@ -2200,6 +2195,11 @@</span><br><span>     }</span><br><span=
> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(__GNUC__) || defined(__clang__)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#pragma GCC diagnostic push</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#pragma GCC diagnostic ignored &quot;-Wco=
nversion&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endi=
f</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
/**</span><br><span>  * Handle reading key data, peer-info, username/passwo=
rd, OCC</span><br><span>  * from the TLS control channel (cleartext).</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1301?usp=3Demail">change 1301</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1301?usp=3Demail"/><meta itemprop=3D"name" content=3D"View=
 Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Id7bacec23edc6dcd94465c308ea=
2144c7329a0c1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1301 </div>
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

--LRB25u5axE8=--

