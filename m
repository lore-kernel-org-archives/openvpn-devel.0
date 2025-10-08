From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 10:44:04 +0000
In-Reply-To: <gerrit.1759330832000.I3724660bf0f8336ee58c172acfb7c4f38e457393@...2715...>
References: <gerrit.1759330832000.I3724660bf0f8336ee58c172acfb7c4f38e457393@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <fca1534d4da6db887bbc2a24fbe86630a82de687-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gq4xzZXLzxE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gq4xzZXLzxE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1246?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2, Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/46/1246/2

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
=20
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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I3724660bf0f8336ee58c172acfb7c4f38e457393
Gerrit-Change-Number: 1246
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--gq4xzZXLzxE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1246?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2, Code-Review+2 by plaisthos</p><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">buffer:=
 Fix buf_parse eating input<br><br>When parsing a &quot;line&quot; that is =
longer than the<br>available line buffer, then buf_parse was<br>eating up t=
o 2 characters. It advanced past<br>them but they were not part of the outp=
ut.<br><br>This can lead to unexpected results if buf_parse<br>is used in a=
 while loop on unrestricted input,<br>like e.g. when reading configs (see i=
n_src_get()<br>used for check_inline_file_via_buf()).<br><br>Change-Id: I37=
24660bf0f8336ee58c172acfb7c4f38e457393<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<=
br>Acked-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: ht=
tps://gerrit.openvpn.net/c/openvpn/+/1246<br>Message-Id: &lt;20251008103001=
.7696-1-gert@...1296...&gt;<br>URL: https://sourceforge.net/p/openvpn/mailm=
an/message/59243829/<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M src/openvpn/buffer.c<br>M src/openvpn/buffer.h<br>M tests/unit=
_tests/openvpn/test_buffer.c<br>3 files changed, 73 insertions(+), 7 deleti=
ons(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/46/1246/2</pre><pre style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/buffer.c b/s=
rc/openvpn/buffer.c</span><br><span>index c0b85b2..28de00f 100644</span><br=
><span>--- a/src/openvpn/buffer.c</span><br><span>+++ b/src/openvpn/buffer.=
c</span><br><span>@@ -832,19 +832,24 @@</span><br><span> </span><br><span> =
    do</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-        c =3D buf_read_u8(buf);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+        c =3D buf_peek_u8(buf);</span><br><span>       =
  if (c &lt; 0)</span><br><span>         {</span><br><span>             eol=
 =3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
   line[n] =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          break;</span><br><span>         }</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        if (c &lt;=3D 0 || c =3D=3D delim)</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        if (c =3D=3D delim)</s=
pan><br><span>         {</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-            c =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+            buf_advance(buf, 1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            line[n] =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+            break;</span><br><span>         }</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        if (n &gt;=3D size)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (n &gt;=
=3D (size - 1))</span><br><span>         {</span><br><span>             bre=
ak;</span><br><span>         }</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        buf_advance(buf, 1);</span><br><span>         line[n++] =
=3D (char)c;</span><br><span>     } while (c);</span><br><span> </span><br>=
<span>diff --git a/src/openvpn/buffer.h b/src/openvpn/buffer.h</span><br><s=
pan>index 1405667..148cee0 100644</span><br><span>--- a/src/openvpn/buffer.=
h</span><br><span>+++ b/src/openvpn/buffer.h</span><br><span>@@ -771,7 +771=
,7 @@</span><br><span> }</span><br><span> </span><br><span> static inline i=
nt</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buf_read_u8(struct =
buffer *buf)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buf_pee=
k_u8(struct buffer *buf)</span><br><span> {</span><br><span>     int ret;</=
span><br><span>     if (BLEN(buf) &lt; 1)</span><br><span>@@ -779,7 +779,17=
 @@</span><br><span>         return -1;</span><br><span>     }</span><br><s=
pan>     ret =3D *BPTR(buf);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    buf_advance(buf, 1);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    return ret;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+static inline int</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+buf_read_u8(struct buffer *buf)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    int ret =3D buf_peek_u8(buf);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (ret &gt;=3D 0)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        buf_advance(buf, 1);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span>   =
  return ret;</span><br><span> }</span><br><span> </span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test=
_buffer.c</span><br><span>index c86c19e..92c4c65 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_buffer.c</span><br><span>@@ -450,6 +450,56 @@</span><br>=
<span>     gc_free(&amp;gc);</span><br><span> }</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+/* for building long texts */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define A_TIMES_256=
 &quot;AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_buff=
er_parse(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_a=
rena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct buffer buf =3D alloc_buf_gc(1024, &amp;gc);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    char line[512];</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    bool status;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char test1[] =3D A_TIMES_256 &q=
uot;EOL\n&quot; A_TIMES_256 &quot;EOF&quot;;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /* line buffer bigger than actual line */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_write(&amp;buf, =
test1, sizeof(test1)), true);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    status =3D buf_parse(&amp;buf, &#39;\n&#39;, line, sizeof(lin=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(status, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(line, A_TIMES_256 &quot;EOL&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    status =3D buf_parse(&amp;buf,=
 &#39;\n&#39;, line, sizeof(line));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(status, true);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(line, A_TIMES_256=
 &quot;EOF&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* line buffer e=
xactly same size as actual line + terminating \0 */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_reset_len(&amp;buf);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(buf_write(&=
amp;buf, test1, sizeof(test1)), true);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    status =3D buf_parse(&amp;buf, &#39;\n&#39;, line, 2=
60);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(status, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(line, A_TIMES_256 &quot;EOL&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    status =3D buf_parse(&amp;buf,=
 &#39;\n&#39;, line, 260);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(status, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(line, A_TIMES_256 &quot;EOF&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* line buffer smaller than=
 actual line */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
buf_reset_len(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_int_equal(buf_write(&amp;buf, test1, sizeof(test1)), true);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =3D buf_=
parse(&amp;buf, &#39;\n&#39;, line, 257);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_int_equal(status, true);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(line, A_TIMES=
_256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    status =
=3D buf_parse(&amp;buf, &#39;\n&#39;, line, 257);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_int_equal(status, true);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(line,=
 &quot;EOL&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   status =3D buf_parse(&amp;buf, &#39;\n&#39;, line, 257);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(status, true);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(line, A_TIMES_256);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    status =3D buf_parse(&amp;buf, &#39;\n&#39;, line, 257);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(status, =
true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(line, &quot;EOF&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
gc_free(&amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> in=
t</span><br><span> main(void)</span><br><span> {</span><br><span>@@ -478,7 =
+528,8 @@</span><br><span>         cmocka_unit_test(test_character_class),<=
/span><br><span>         cmocka_unit_test(test_character_string_mod_buf),</=
span><br><span>         cmocka_unit_test(test_snprintf),</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        cmocka_unit_test(test_buffer_cho=
mp)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_u=
nit_test(test_buffer_chomp),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_buffer_parse)</span><br><span>     }=
;</span><br><span> </span><br><span>     return cmocka_run_group_tests_name=
(&quot;buffer&quot;, tests, NULL, NULL);</span><br><span></span><br></pre><=
p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1246?usp=
=3Demail">change 1246</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1246?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--gq4xzZXLzxE=--

