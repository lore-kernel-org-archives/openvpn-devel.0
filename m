From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 8 Feb 2024 08:31:18 +0000
In-Reply-To: <gerrit.1702052980000.I8b5570f6314e917f92dce072279efe415d79b22a@...2715...>
References: <gerrit.1702052980000.I8b5570f6314e917f92dce072279efe415d79b22a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e3668362b6040db71f579e085422982bb0635640-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="xLN8nztd52o="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_user_pass: add
 basic tests for static/dynamic challenges
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

--xLN8nztd52o=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/47=
5?usp=3Demail )

Change subject: test_user_pass: add basic tests for static/dynamic challeng=
es
......................................................................

test_user_pass: add basic tests for static/dynamic challenges

Change-Id: I8b5570f6314e917f92dce072279efe415d79b22a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240207171239.86730-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
191.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 61 insertions(+), 0 deletions(-)




diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index bd4eb1f..5d3f9b6 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -267,12 +267,73 @@
     assert_string_equal(up.password, "fuser");
 }

+#ifdef ENABLE_MANAGEMENT
+static void
+test_get_user_pass_dynamic_challenge(void **state)
+{
+    struct user_pass up =3D { 0 };
+    reset_user_pass(&up);
+    const char *challenge =3D "CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y=
3Ix:Please enter token PIN";
+    unsigned int flags =3D GET_USER_PASS_DYNAMIC_CHALLENGE;
+
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "CHALLENG=
E: Please enter token PIN");
+    will_return(query_user_exec_builtin, "challenge_response");
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, NULL, "UT", flags, challenge));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "cr1");
+    assert_string_equal(up.password, "CRV1::Om01u7Fh4LrGBS7uh0SWmzwabUiGiW=
6l::challenge_response");
+}
+
+static void
+test_get_user_pass_static_challenge(void **state)
+{
+    struct user_pass up =3D { 0 };
+    reset_user_pass(&up);
+    const char *challenge =3D "Please enter token PIN";
+    unsigned int flags =3D GET_USER_PASS_STATIC_CHALLENGE;
+
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Username:");
+    will_return(query_user_exec_builtin, "cuser");
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
+    will_return(query_user_exec_builtin, "cpassword");
+    will_return(query_user_exec_builtin, true);
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "CHALLENG=
E: Please enter token PIN");
+    will_return(query_user_exec_builtin, "challenge_response");
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, NULL, "UT", flags, challenge));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "cuser");
+    /* SCRV1:cpassword:challenge_response but base64-encoded */
+    assert_string_equal(up.password, "SCRV1:Y3Bhc3N3b3Jk:Y2hhbGxlbmdlX3Jlc=
3BvbnNl");
+
+    reset_user_pass(&up);
+
+    flags |=3D GET_USER_PASS_INLINE_CREDS;
+
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "CHALLENG=
E: Please enter token PIN");
+    will_return(query_user_exec_builtin, "challenge_response");
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, "iuser\nipassword", "UT", flags, cha=
llenge));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "iuser");
+    /* SCRV1:ipassword:challenge_response but base64-encoded */
+    assert_string_equal(up.password, "SCRV1:aXBhc3N3b3Jk:Y2hhbGxlbmdlX3Jlc=
3BvbnNl");
+}
+#endif /* ENABLE_MANAGEMENT */
+
 const struct CMUnitTest user_pass_tests[] =3D {
     cmocka_unit_test(test_get_user_pass_defined),
     cmocka_unit_test(test_get_user_pass_needok),
     cmocka_unit_test(test_get_user_pass_inline_creds),
     cmocka_unit_test(test_get_user_pass_authfile_stdin),
     cmocka_unit_test(test_get_user_pass_authfile_file),
+#ifdef ENABLE_MANAGEMENT
+    cmocka_unit_test(test_get_user_pass_dynamic_challenge),
+    cmocka_unit_test(test_get_user_pass_static_challenge),
+#endif /* ENABLE_MANAGEMENT */
 };

 int

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/475?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I8b5570f6314e917f92dce072279efe415d79b22a
Gerrit-Change-Number: 475
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--xLN8nztd52o=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/475?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">test_user_pass: add basic tests for static/dyn=
amic challenges<br><br>Change-Id: I8b5570f6314e917f92dce072279efe415d79b22a=
<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: =
Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20240207171=
239.86730-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openv=
pn-devel@lists.sourceforge.net/msg28191.html<br>Signed-off-by: Gert Doering=
 &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_user_pas=
s.c<br>1 file changed, 61 insertions(+), 0 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_test=
s/openvpn/test_user_pass.c</span><br><span>index bd4eb1f..5d3f9b6 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><br><sp=
an>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -267,=
12 +267,73 @@</span><br><span>     assert_string_equal(up.password, &quot;f=
user&quot;);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+test_get_user_pass_dynamic_challenge(void **stat=
e)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(=
&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const =
char *challenge =3D &quot;CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y3Ix:Pl=
ease enter token PIN&quot;;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    unsigned int flags =3D GET_USER_PASS_DYNAMIC_CHALLENGE;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, que=
ry_user[i].prompt, &quot;CHALLENGE: Please enter token PIN&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_e=
xec_builtin, &quot;challenge_response&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_u=
ser_pass_cr(&amp;up, NULL, &quot;UT&quot;, flags, challenge));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal=
(up.username, &quot;cr1&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_string_equal(up.password, &quot;CRV1::Om01u7Fh4LrGBS=
7uh0SWmzwabUiGiW6l::challenge_response&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass=
_static_challenge(void **state)</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    st=
ruct user_pass up =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char *challenge =3D &quot;Please enter token P=
IN&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsign=
ed int flags =3D GET_USER_PASS_STATIC_CHALLENGE;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    expect_string(query_user_exec_builtin, query_user[i].prompt, =
&quot;Enter UT Username:&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    will_return(query_user_exec_builtin, &quot;cuser&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(que=
ry_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(qu=
ery_user_exec_builtin, &quot;cpassword&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(qu=
ery_user_exec_builtin, query_user[i].prompt, &quot;CHALLENGE: Please enter =
token PIN&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  will_return(query_user_exec_builtin, &quot;challenge_response&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_u=
ser_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(get_user_pass_cr(&amp;up, NULL, &quot;UT&quot;, flags,=
 challenge));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(up.username, &quot;cuser&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    /* SCRV1:cpassword:challenge_re=
sponse but base64-encoded */</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_string_equal(up.password, &quot;SCRV1:Y3Bhc3N3b3Jk:Y2hh=
bGxlbmdlX3Jlc3BvbnNl&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_=
user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_=
USER_PASS_INLINE_CREDS;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: qu=
ery_user_exec() called even though nothing queued */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, =
true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_st=
ring(query_user_exec_builtin, query_user[i].prompt, &quot;CHALLENGE: Please=
 enter token PIN&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    will_return(query_user_exec_builtin, &quot;challenge_response&quot=
;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(=
query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;iuser\nipasswor=
d&quot;, &quot;UT&quot;, flags, challenge));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quo=
t;iuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/* SCRV1:ipassword:challenge_response but base64-encoded */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password=
, &quot;SCRV1:aXBhc3N3b3Jk:Y2hhbGxlbmdlX3Jlc3BvbnNl&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const struct CMUnitTest=
 user_pass_tests[] =3D {</span><br><span>     cmocka_unit_test(test_get_use=
r_pass_defined),</span><br><span>     cmocka_unit_test(test_get_user_pass_n=
eedok),</span><br><span>     cmocka_unit_test(test_get_user_pass_inline_cre=
ds),</span><br><span>     cmocka_unit_test(test_get_user_pass_authfile_stdi=
n),</span><br><span>     cmocka_unit_test(test_get_user_pass_authfile_file)=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANA=
GEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_un=
it_test(test_get_user_pass_dynamic_challenge),</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_static_c=
hallenge),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /*=
 ENABLE_MANAGEMENT */</span><br><span> };</span><br><span> </span><br><span=
> int</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/475?usp=3Demail">change 475</a>. To unsubscr=
ibe, or for help writing mail filters, visit <a href=3D"http://gerrit.openv=
pn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.=
org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sch=
ema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/475?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Cha=
nge"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b5570f6314e917f92dce072279=
efe415d79b22a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 475 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--xLN8nztd52o=--

