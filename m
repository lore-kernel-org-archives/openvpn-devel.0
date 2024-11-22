From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Fri, 22 Nov 2024 16:22:30 +0000
References: <gerrit.1732292548000.Ia0799189d45223e0b987a5a4da5be60404388f1f@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <204cb86af4cdc460648615595a782f79db9e142a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="uXVRSpZku1k="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add small unit test
 for buf_chomp
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--uXVRSpZku1k=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/817?usp=3Demail

to review the following change.


Change subject: Add small unit test for buf_chomp
......................................................................

Add small unit test for buf_chomp

Change-Id: Ia0799189d45223e0b987a5a4da5be60404388f1f
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M tests/unit_tests/openvpn/test_buffer.c
1 file changed, 28 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/17/817/1

diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 0fb4697..d43d5c1 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -426,6 +426,32 @@
 #endif
 }

+void
+test_buffer_chomp(void **state)
+{
+    struct gc_arena gc =3D gc_new();
+    struct buffer buf =3D alloc_buf_gc(1024, &gc);
+
+    const char test1[] =3D  "There is a nice 1234 year old tree!\n\r";
+    buf_write(&buf, test1, sizeof(test1));
+    buf_chomp(&buf);
+    /* Check that our own method agrees */
+    assert_true(string_check_buf(&buf, CC_PRINT | CC_NULL, CC_CRLF));
+    assert_string_equal(BSTR(&buf), "There is a nice 1234 year old tree!");
+
+    struct buffer buf2 =3D alloc_buf_gc(1024, &gc);
+    const char test2[] =3D  "CR_RESPONSE,MTIx\x0a\x00";
+    buf_write(&buf2, test2, sizeof(test2));
+    buf_chomp(&buf2);
+
+    buf_chomp(&buf2);
+    /* Check that our own method agrees */
+    assert_true(string_check_buf(&buf2, CC_PRINT | CC_NULL, CC_CRLF));
+    assert_string_equal(BSTR(&buf2), "CR_RESPONSE,MTIx");
+
+    gc_free(&gc);
+}
+
 int
 main(void)
 {
@@ -460,7 +486,8 @@
         cmocka_unit_test(test_buffer_gc_realloc),
         cmocka_unit_test(test_character_class),
         cmocka_unit_test(test_character_string_mod_buf),
-        cmocka_unit_test(test_snprintf)
+        cmocka_unit_test(test_snprintf),
+        cmocka_unit_test(test_buffer_chomp)
     };

     return cmocka_run_group_tests_name("buffer", tests, NULL, NULL);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/817?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ia0799189d45223e0b987a5a4da5be60404388f1f
Gerrit-Change-Number: 817
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--uXVRSpZku1k=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/817?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Add small unit test for buf_chomp<br><br>Change-Id: Ia0799189=
d45223e0b987a5a4da5be60404388f1f<br>Signed-off-by: Arne Schwabe &lt;arne@...1186...=
.1227...&gt;<br>---<br>M tests/unit_tests/openvpn/test_buffer.c<br>1 file c=
hanged, 28 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/17/817/1</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/uni=
t_tests/openvpn/test_buffer.c b/tests/unit_tests/openvpn/test_buffer.c</spa=
n><br><span>index 0fb4697..d43d5c1 100644</span><br><span>--- a/tests/unit_=
tests/openvpn/test_buffer.c</span><br><span>+++ b/tests/unit_tests/openvpn/=
test_buffer.c</span><br><span>@@ -426,6 +426,32 @@</span><br><span> #endif<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_buffer_chomp(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct gc_arena gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct buffer buf =3D alloc_buf_gc(1024, &amp;gc);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    const char test1[] =3D  &quot;There is a n=
ice 1234 year old tree!\n\r&quot;;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    buf_write(&amp;buf, test1, sizeof(test1));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    buf_chomp(&amp;buf);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check that our own me=
thod agrees */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(string_check_buf(&amp;buf, CC_PRINT | CC_NULL, CC_CRLF));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(BS=
TR(&amp;buf), &quot;There is a nice 1234 year old tree!&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct buffer buf2 =3D alloc_buf_gc(1024, &amp=
;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char=
 test2[] =3D  &quot;CR_RESPONSE,MTIx\x0a\x00&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf2, test2, sizeof(te=
st2));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_chomp=
(&amp;buf2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_chomp(&amp;buf2);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Check that ou=
r own method agrees */</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_true(string_check_buf(&amp;buf2, CC_PRINT | CC_NULL, CC_CRLF)=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string=
_equal(BSTR(&amp;buf2), &quot;CR_RESPONSE,MTIx&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    gc_free(&amp;gc);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> int</span><br><span> main(void)</span><br><span> {</span>=
<br><span>@@ -460,7 +486,8 @@</span><br><span>         cmocka_unit_test(tes=
t_buffer_gc_realloc),</span><br><span>         cmocka_unit_test(test_charac=
ter_class),</span><br><span>         cmocka_unit_test(test_character_string=
_mod_buf),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        cmo=
cka_unit_test(test_snprintf)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        cmocka_unit_test(test_snprintf),</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_buffer_chomp)</=
span><br><span>     };</span><br><span> </span><br><span>     return cmocka=
_run_group_tests_name(&quot;buffer&quot;, tests, NULL, NULL);</span><br><sp=
an></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/=
c/openvpn/+/817?usp=3Demail">change 817</a>. To unsubscribe, or for help wr=
iting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings">se=
ttings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><=
div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"=
><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/817?u=
sp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia0799189d45223e0b987a5a4da5=
be60404388f1f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 817 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--uXVRSpZku1k=--

