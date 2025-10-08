From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 10:44:06 +0000
In-Reply-To: <gerrit.1759330832000.I3724660bf0f8336ee58c172acfb7c4f38e457393@...2715...>
References: <gerrit.1759330832000.I3724660bf0f8336ee58c172acfb7c4f38e457393@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fca1534d4da6db887bbc2a24fbe86630a82de687-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="69mFTfuwtP4="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: buffer: Fix
 buf_parse eating input
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--69mFTfuwtP4=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
46?usp=3Demail )

Change subject: buffer: Fix buf_parse eating input
......................................................................

buffer: Fix buf_parse eating input

When parsing a "line" that is longer than the
available line buffer, then buf_parse was
eating up to 2 characters. It advanced past
them but they were not part of the output.

This can lead to unexpected results if buf_parse
is used in a while loop on unrestricted input,
like e.g. when reading configs (see in_src_get()
used for check_inline_file_via_buf()).

Change-Id: I3724660bf0f8336ee58c172acfb7c4f38e457393
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1246
Message-Id: <20251008103001.7696-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243829/
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/buffer.c
M src/openvpn/buffer.h
M tests/unit_tests/openvpn/test_buffer.c
3 files changed, 73 insertions(+), 7 deletions(-)




diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c
index c0b85b2..28de00f 100644
--- a/src/openvpn/buffer.c
+++ b/src/openvpn/buffer.c
@@ -832,19 +832,24 @@

     do
     {
-        c =3D buf_read_u8(buf);
+        c =3D buf_peek_u8(buf);
         if (c < 0)
         {
             eol =3D true;
+            line[n] =3D 0;
+            break;
         }
-        if (c <=3D 0 || c =3D=3D delim)
+        if (c =3D=3D delim)
         {
-            c =3D 0;
+            buf_advance(buf, 1);
+            line[n] =3D 0;
+            break;
         }
-        if (n >=3D size)
+        if (n >=3D (size - 1))
         {
             break;
         }
+        buf_advance(buf, 1);
         line[n++] =3D (char)c;
     } while (c);

diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h
index 1405667..148cee0 100644
--- a/src/openvpn/buffer.h
+++ b/src/openvpn/buffer.h
@@ -771,7 +771,7 @@
 }

 static inline int
-buf_read_u8(struct buffer *buf)
+buf_peek_u8(struct buffer *buf)
 {
     int ret;
     if (BLEN(buf) < 1)
@@ -779,7 +779,17 @@
         return -1;
     }
     ret =3D *BPTR(buf);
-    buf_advance(buf, 1);
+    return ret;
+}
+
+static inline int
+buf_read_u8(struct buffer *buf)
+{
+    int ret =3D buf_peek_u8(buf);
+    if (ret >=3D 0)
+    {
+        buf_advance(buf, 1);
+    }
     return ret;
 }

diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index c86c19e..92c4c65 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -450,6 +450,56 @@
     gc_free(&gc);
 }

+/* for building long texts */
+#define A_TIMES_256 "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO"
+
+void
+test_buffer_parse(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(1024, &gc);
+    char line[512];
+    bool status;
+    const char test1[] =3D A_TIMES_256 "EOL\n" A_TIMES_256 "EOF";
+
+    /* line buffer bigger than actual line */
+    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    status =3D buf_parse(&buf, '\n', line, sizeof(line));
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256 "EOL");
+    status =3D buf_parse(&buf, '\n', line, sizeof(line));
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256 "EOF");
+
+    /* line buffer exactly same size as actual line + terminating \0 */
+    buf_reset_len(&buf);
+    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    status =3D buf_parse(&buf, '\n', line, 260);
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256 "EOL");
+    status =3D buf_parse(&buf, '\n', line, 260);
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256 "EOF");
+
+    /* line buffer smaller than actual line */
+    buf_reset_len(&buf);
+    assert_int_equal(buf_write(&buf, test1, sizeof(test1)), true);
+    status =3D buf_parse(&buf, '\n', line, 257);
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256);
+    status =3D buf_parse(&buf, '\n', line, 257);
+    assert_int_equal(status, true);
+    assert_string_equal(line, "EOL");
+    status =3D buf_parse(&buf, '\n', line, 257);
+    assert_int_equal(status, true);
+    assert_string_equal(line, A_TIMES_256);
+    status =3D buf_parse(&buf, '\n', line, 257);
+    assert_int_equal(status, true);
+    assert_string_equal(line, "EOF");
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -478,7 +528,8 @@
         cmocka_unit_test(test_character_class),
         cmocka_unit_test(test_character_string_mod_buf),
         cmocka_unit_test(test_snprintf),
-        cmocka_unit_test(test_buffer_chomp)
+        cmocka_unit_test(test_buffer_chomp),
+        cmocka_unit_test(test_buffer_parse)
     };

     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1246?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3724660bf0f8336ee58c172acfb7c4f38e457393
Gerrit-Change-Number: 1246
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--69mFTfuwtP4=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1246?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">buffer: Fix buf_parse eating input<br><br>When p=
arsing a &quot;line&quot; that is longer than the<br>available line buffer,=
 then buf_parse was<br>eating up to 2 characters. It advanced past<br>them =
but they were not part of the output.<br><br>This can lead to unexpected re=
sults if buf_parse<br>is used in a while loop on unrestricted input,<br>lik=
e e.g. when reading configs (see in_src_get()<br>used for check_inline_file=
_via_buf()).<br><br>Change-Id: I3724660bf0f8336ee58c172acfb7c4f38e457393<br=
>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvp=
n@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1246=
<br>Message-Id: &lt;20251008103001.7696-1-gert@...1296...&gt;<br>URL: https=
://sourceforge.net/p/openvpn/mailman/message/59243829/<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/buffer.c<br>M sr=
c/openvpn/buffer.h<br>M tests/unit_tests/openvpn/test_buffer.c<br>3 files c=
hanged, 73 insertions(+), 7 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/src/openvpn/buffer.c b/src/openvpn/buffer.c</span><br><span=
>index c0b85b2..28de00f 100644</span><br><span>--- a/src/openvpn/buffer.c</=
span><br><span>+++ b/src/openvpn/buffer.c</span><br><span>@@ -832,19 +832,2=
4 @@</span><br><span> </span><br><span>     do</span><br><span>     {</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        c =3D buf_read_u8(b=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        c =3D b=
uf_peek_u8(buf);</span><br><span>         if (c &lt; 0)</span><br><span>   =
      {</span><br><span>             eol =3D true;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+            line[n] =3D 0;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            break;</span><br><span>  =
       }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (c=
 &lt;=3D 0 || c =3D=3D delim)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+        if (c =3D=3D delim)</span><br><span>         {</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-            c =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+            buf_advance(buf, 1)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            line[n=
] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
 break;</span><br><span>         }</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-        if (n &gt;=3D size)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        if (n &gt;=3D (size - 1))</span><br><span>    =
     {</span><br><span>             break;</span><br><span>         }</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        buf_advance(buf, =
1);</span><br><span>         line[n++] =3D (char)c;</span><br><span>     } =
while (c);</span><br><span> </span><br><span>diff --git a/src/openvpn/buffe=
r.h b/src/openvpn/buffer.h</span><br><span>index 1405667..148cee0 100644</s=
pan><br><span>--- a/src/openvpn/buffer.h</span><br><span>+++ b/src/openvpn/=
buffer.h</span><br><span>@@ -771,7 +771,7 @@</span><br><span> }</span><br><=
span> </span><br><span> static inline int</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-buf_read_u8(struct buffer *buf)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+buf_peek_u8(struct buffer *buf)</span><br=
><span> {</span><br><span>     int ret;</span><br><span>     if (BLEN(buf) =
&lt; 1)</span><br><span>@@ -779,7 +779,17 @@</span><br><span>         retur=
n -1;</span><br><span>     }</span><br><span>     ret =3D *BPTR(buf);</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-    buf_advance(buf, 1);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    return ret;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+static inline int</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+buf_read_u8(struct buffer *buf)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    int ret =3D buf_peek_u8(buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    if (ret &gt;=3D 0)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        buf_advance(buf, 1);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    }</span><br><span>     return ret;</span><br><span> }</=
span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_buffer.c b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>index c8=
6c19e..92c4c65 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_b=
uffer.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer.c</span>=
<br><span>@@ -450,6 +450,56 @@</span><br><span>     gc_free(&amp;gc);</span=
><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/* for building long texts */</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#define A_TIMES_256 &quot;AAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAO&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_buffer_parse(void **state)</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D allo=
c_buf_gc(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    char line[512];</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    bool status;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char test1[] =3D A_TIMES_256 &quot;EOL\n&quot; A_TIMES_256 &quo=
t;EOF&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    /* line buffer bigger =
than actual line */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(buf_write(&amp;buf, test1, sizeof(test1)), true);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D buf_parse=
(&amp;buf, &#39;\n&#39;, line, sizeof(line));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(status, true);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(line, A_T=
IMES_256 &quot;EOL&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    status =3D buf_parse(&amp;buf, &#39;\n&#39;, line, sizeof(line))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(status, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(line, A_TIMES_256 &quot;EOF&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* line buffer exactly same size as actual line + te=
rminating \0 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buf_reset_len(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(buf_write(&amp;buf, test1, sizeof(test1)), true);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D buf_=
parse(&amp;buf, &#39;\n&#39;, line, 260);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(status, true);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(line, A_TIMES=
_256 &quot;EOL&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    status =3D buf_parse(&amp;buf, &#39;\n&#39;, line, 260);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(status, tr=
ue);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(line, A_TIMES_256 &quot;EOF&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* line buffer smaller than actual line */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_reset_len(&amp;buf);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_write(&=
amp;buf, test1, sizeof(test1)), true);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    status =3D buf_parse(&amp;buf, &#39;\n&#39;, line, 2=
57);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(status, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(line, A_TIMES_256);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    status =3D buf_parse(&amp;buf, &#39;\n&#39;, l=
ine, 257);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(status, true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_string_equal(line, &quot;EOL&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    status =3D buf_parse(&amp;buf, &#39;=
\n&#39;, line, 257);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(status, true);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(line, A_TIMES_256);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    status =3D buf_parse(&amp;buf,=
 &#39;\n&#39;, line, 257);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(status, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(line, &quot;EOF&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span> int</span><br><span> main(void)</span><=
br><span> {</span><br><span>@@ -478,7 +528,8 @@</span><br><span>         cm=
ocka_unit_test(test_character_class),</span><br><span>         cmocka_unit_=
test(test_character_string_mod_buf),</span><br><span>         cmocka_unit_t=
est(test_snprintf),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      cmocka_unit_test(test_buffer_chomp)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        cmocka_unit_test(test_buffer_chomp),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(tes=
t_buffer_parse)</span><br><span>     };</span><br><span> </span><br><span> =
    return cmocka_run_group_tests_name(&quot;buffer&quot;, tests, NULL, NUL=
L);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1246?usp=3Demail">change 1246</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1246?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I3724660bf0f8336ee58c172acfb=
7c4f38e457393 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1246 </div>
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

--69mFTfuwtP4=--

