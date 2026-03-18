From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Mar 2026 13:54:01 +0000
References: <gerrit.1773842036000.I01683153a68e1809a4d7ab455eb346f53780e219@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d630e2e5bc3486a089ac6af9006035fe4321def0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ZPbZqJEZODA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: test_buffer: Add
 test for buf_null_terminate
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

--ZPbZqJEZODA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1580?usp=3Demail

to review the following change.


Change subject: test_buffer: Add test for buf_null_terminate
......................................................................

test_buffer: Add test for buf_null_terminate

Change-Id: I01683153a68e1809a4d7ab455eb346f53780e219
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_buffer.c
1 file changed, 27 insertions(+), 0 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1580/1

diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 5f43e0d..326de40 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -460,6 +460,32 @@
     gc_free(&gc);
 }

+void
+test_buffer_null_terminate(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+
+    struct buffer buf =3D alloc_buf_gc(5, &gc);
+    const char test1[] =3D "1234";
+    const char test2[] =3D "12345";
+    assert_true(buf_write(&buf, test1, sizeof(test1)));
+    assert_string_equal(BSTR(&buf), "1234");
+    buf_null_terminate(&buf);
+    assert_string_equal(BSTR(&buf), "1234");
+
+    assert_true(buf_inc_len(&buf, -1));
+    assert_true(buf_write_u8(&buf, '5'));
+    assert_memory_equal(BPTR(&buf), test2, strlen(test2));
+    buf_null_terminate(&buf);
+    assert_string_equal(BSTR(&buf), "1234");
+
+    struct buffer buf2;
+    CLEAR(buf2);
+    buf_null_terminate(&buf2);
+
+    gc_free(&gc);
+}
+
 /* for building long texts */
 #define A_TIMES_256 "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO"

@@ -540,6 +566,7 @@
         cmocka_unit_test(test_snprintf),
         cmocka_unit_test(test_checked_snprintf),
         cmocka_unit_test(test_buffer_chomp),
+        cmocka_unit_test(test_buffer_null_terminate),
         cmocka_unit_test(test_buffer_parse)
     };


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1580?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01683153a68e1809a4d7ab455eb346f53780e219
Gerrit-Change-Number: 1580
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--ZPbZqJEZODA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1580?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">test_buffer: Add test for buf_null_terminat=
e<br><br>Change-Id: I01683153a68e1809a4d7ab455eb346f53780e219<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M tests/unit_test=
s/openvpn/test_buffer.c<br>1 file changed, 27 insertions(+), 0 deletions(-)=
<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,monospa=
ce; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn=
 refs/changes/80/1580/1</pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_=
buffer.c b/tests/unit_tests/openvpn/test_buffer.c</span><br><span>index 5f4=
3e0d..326de40 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_bu=
ffer.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_buffer.c</span><=
br><span>@@ -460,6 +460,32 @@</span><br><span>     gc_free(&amp;gc);</span>=
<br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test=
_buffer_null_terminate(void **state)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct buffer buf =3D alloc_buf_gc(5, &amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char test1[] =3D &quot;1234&quot;;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char test2[=
] =3D &quot;12345&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(buf_write(&amp;buf, test1, sizeof(test1)));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BSTR(&=
amp;buf), &quot;1234&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    buf_null_terminate(&amp;buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(BSTR(&amp;buf), &quot;1234&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(buf_inc_len(&amp=
;buf, -1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(buf_write_u8(&amp;buf, &#39;5&#39;));</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_memory_equal(BPTR(&amp;buf), test2, st=
rlen(test2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    bu=
f_null_terminate(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(BSTR(&amp;buf), &quot;1234&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    struct buffer buf2;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    CLEAR(buf2);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    buf_null_terminate(&amp;buf2);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span> /* for building long texts */</span><br><span>=
 #define A_TIMES_256 &quot;AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO&quot;</span><br>=
<span> </span><br><span>@@ -540,6 +566,7 @@</span><br><span>         cmocka=
_unit_test(test_snprintf),</span><br><span>         cmocka_unit_test(test_c=
hecked_snprintf),</span><br><span>         cmocka_unit_test(test_buffer_cho=
mp),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_=
unit_test(test_buffer_null_terminate),</span><br><span>         cmocka_unit=
_test(test_buffer_parse)</span><br><span>     };</span><br><span> </span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1580?usp=3Demail">change 1580</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1580?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I01683153a68e1809a4d7ab455eb=
346f53780e219 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1580 </div>
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

--ZPbZqJEZODA=--

