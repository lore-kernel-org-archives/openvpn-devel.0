From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 7 Apr 2026 10:56:19 +0000
In-Reply-To: <gerrit.1773842036000.I01683153a68e1809a4d7ab455eb346f53780e219@...2715...>
References: <gerrit.1773842036000.I01683153a68e1809a4d7ab455eb346f53780e219@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <0977e46887b56189e7a5ed47bae2a1e6e6d0411e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="eAQOnwdVkW0="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eAQOnwdVkW0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1580?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: test_buffer: Add test for buf_null_terminate
......................................................................

test_buffer: Add test for buf_null_terminate

Change-Id: I01683153a68e1809a4d7ab455eb346f53780e219
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1580
Message-Id: <20260407095044.28528-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
532.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_buffer.c
1 file changed, 27 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/80/1580/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I01683153a68e1809a4d7ab455eb346f53780e219
Gerrit-Change-Number: 1580
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--eAQOnwdVkW0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1580?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">test_buffer: Add test for buf_null_=
terminate<br><br>Change-Id: I01683153a68e1809a4d7ab455eb346f53780e219<br>Si=
gned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert D=
oering &lt;gert@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/=
openvpn/+/1580<br>Message-Id: &lt;20260407095044.28528-1-gert@...1296...&gt=
;<br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/=
msg36532.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---=
<br>M tests/unit_tests/openvpn/test_buffer.c<br>1 file changed, 27 insertio=
ns(+), 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-fami=
ly: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.open=
vpn.net:29418/openvpn refs/changes/80/1580/2</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/uni=
t_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c</spa=
n><br><span>index 5f43e0d..326de40 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_buffer.c</span><br><span>+++ b/tests/unit_tests/openvpn/=
test_buffer.c</span><br><span>@@ -460,6 +460,32 @@</span><br><span>     gc_=
free(&amp;gc);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+test_buffer_null_terminate(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_gc(5, &amp;gc);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char test1[] =
=3D &quot;1234&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    const char test2[] =3D &quot;12345&quot;;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(buf_write(&amp;buf, test1, size=
of(test1)));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_string_equal(BSTR(&amp;buf), &quot;1234&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_null_terminate(&amp;buf);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BST=
R(&amp;buf), &quot;1234&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(buf_inc_len(&amp;buf, -1));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(buf_write_u8(&amp;buf, &#39;5&#39;));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_memory_equal(=
BPTR(&amp;buf), test2, strlen(test2));</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    buf_null_terminate(&amp;buf);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BSTR(&amp;buf), &=
quot;1234&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf=
2;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    CLEAR(buf2);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_null_termina=
te(&amp;buf2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /* for building long t=
exts */</span><br><span> #define A_TIMES_256 &quot;AAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAO&quot;</span><br><span> </span><br><span>@@ -540,6 +566,7 @@</span><=
br><span>         cmocka_unit_test(test_snprintf),</span><br><span>        =
 cmocka_unit_test(test_checked_snprintf),</span><br><span>         cmocka_u=
nit_test(test_buffer_chomp),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_buffer_null_terminate),</span><br><s=
pan>         cmocka_unit_test(test_buffer_parse)</span><br><span>     };</s=
pan><br><span> </span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1580?usp=3Demail">change 1580</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1580?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I01683153a68e1809a4d7ab455eb=
346f53780e219 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1580 </div>
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

--eAQOnwdVkW0=--

