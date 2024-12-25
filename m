From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 25 Dec 2024 21:37:47 +0000
In-Reply-To: <gerrit.1732292548000.Ia0799189d45223e0b987a5a4da5be60404388f1f@...2715...>
References: <gerrit.1732292548000.Ia0799189d45223e0b987a5a4da5be60404388f1f@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6faee9a5e9275f18372ebfe4bdd6ef148b279b24-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Aut/3gW5Etc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Aut/3gW5Etc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/81=
7?usp=3Demail )

Change subject: Add small unit test for buf_chomp
......................................................................

Add small unit test for buf_chomp

Change-Id: Ia0799189d45223e0b987a5a4da5be60404388f1f
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20241225165629.5558-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30=
206.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_buffer.c
1 file changed, 28 insertions(+), 1 deletion(-)




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
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Aut/3gW5Etc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/817?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Add small unit test for buf_chomp<br><br>Chang=
e-Id: Ia0799189d45223e0b987a5a4da5be60404388f1f<br>Signed-off-by: Arne Schw=
abe &lt;arne@...1227...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&g=
t;<br>Message-Id: &lt;20241225165629.5558-1-gert@...1296...&gt;<br>URL: htt=
ps://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg30206.html=
<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M tests/u=
nit_tests/openvpn/test_buffer.c<br>1 file changed, 28 insertions(+), 1 dele=
tion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/o=
penvpn/test_buffer.c</span><br><span>index 0fb4697..d43d5c1 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>+++ b/=
tests/unit_tests/openvpn/test_buffer.c</span><br><span>@@ -426,6 +426,32 @@=
</span><br><span> #endif</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_buffer_chomp(void **state)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct gc_arena gc =3D gc_new();</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf =3D alloc_buf_g=
c(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char test1[=
] =3D  &quot;There is a nice 1234 year old tree!\n\r&quot;;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&amp;buf, test1, size=
of(test1));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_=
chomp(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* Check that our own method agrees */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(string_check_buf(&amp;buf, CC_PRINT | C=
C_NULL, CC_CRLF));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(BSTR(&amp;buf), &quot;There is a nice 1234 year old =
tree!&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct buffer buf2 =
=3D alloc_buf_gc(1024, &amp;gc);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    const char test2[] =3D  &quot;CR_RESPONSE,MTIx\x0a\x00&quo=
t;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    buf_write(&a=
mp;buf2, test2, sizeof(test2));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    buf_chomp(&amp;buf2);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   buf_chomp(&amp;buf2);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Check that our own method agrees */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(string_check_buf(&amp;buf2, CC_=
PRINT | CC_NULL, CC_CRLF));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(BSTR(&amp;buf2), &quot;CR_RESPONSE,MTIx&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span> int</span><br><span> main(void)<=
/span><br><span> {</span><br><span>@@ -460,7 +486,8 @@</span><br><span>    =
     cmocka_unit_test(test_buffer_gc_realloc),</span><br><span>         cmo=
cka_unit_test(test_character_class),</span><br><span>         cmocka_unit_t=
est(test_character_string_mod_buf),</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        cmocka_unit_test(test_snprintf)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_snprintf),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_unit_=
test(test_buffer_chomp)</span><br><span>     };</span><br><span> </span><br=
><span>     return cmocka_run_group_tests_name(&quot;buffer&quot;, tests, N=
ULL, NULL);</span><br><span></span><br></pre><p>To view, visit <a href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/817?usp=3Demail">change 817</a>. To un=
subscribe, or for help writing mail filters, visit <a href=3D"http://gerrit=
.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://s=
chema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http=
://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/817?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ia0799189d45223e0b987a5a4da5=
be60404388f1f </div>
<div style=3D"display:none"> Gerrit-Change-Number: 817 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Aut/3gW5Etc=--

