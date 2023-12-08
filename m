From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 Dec 2023 17:30:49 +0000
In-Reply-To: <gerrit.1702052980000.I8b5570f6314e917f92dce072279efe415d79b22a@...2715...>
References: <gerrit.1702052980000.I8b5570f6314e917f92dce072279efe415d79b22a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <f1b6e6bdfe6bf77c62b159326ecf2d793bc48527-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pgXbVI+Adnw="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pgXbVI+Adnw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/475?usp=3Demail

to look at the new patch set (#2).


Change subject: test_user_pass: add basic tests for static/dynamic challeng=
es
......................................................................

test_user_pass: add basic tests for static/dynamic challenges

Change-Id: I8b5570f6314e917f92dce072279efe415d79b22a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 61 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/475/2

diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index ed65fdb..e99bfd4 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -360,6 +360,63 @@
     expect_assert_failure(get_user_pass_cr(&up, authfile, "UT", flags, NUL=
L));
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
@@ -369,6 +426,10 @@
     cmocka_unit_test(test_get_user_pass_authfile_stdin_assertions),
     cmocka_unit_test(test_get_user_pass_authfile_file),
     cmocka_unit_test(test_get_user_pass_authfile_file_assertions),
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--pgXbVI+Adnw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/475?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">test_user_pass: add basic tests for static/dynamic challenges<br><=
br>Change-Id: I8b5570f6314e917f92dce072279efe415d79b22a<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M tests/unit_tests/open=
vpn/test_user_pass.c<br>1 file changed, 61 insertions(+), 0 deletions(-)<br=
><br></pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/475=
/2</pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wr=
ap;"><span>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/u=
nit_tests/openvpn/test_user_pass.c</span><br><span>index ed65fdb..e99bfd4 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span=
><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>=
@@ -360,6 +360,63 @@</span><br><span>     expect_assert_failure(get_user_pa=
ss_cr(&amp;up, authfile, &quot;UT&quot;, flags, NULL));</span><br><span> }<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#i=
fdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_=
get_user_pass_dynamic_challenge(void **state)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    struct user_pass up =3D { 0 };</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *challenge =3D &quot;CRV1:=
R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y3Ix:Please enter token PIN&quot;;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =
=3D GET_USER_PASS_DYNAMIC_CHALLENGE;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;CHALLE=
NGE: Please enter token PIN&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;challenge_re=
sponse&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
ill_return(query_user_exec_builtin, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, NULL, &quo=
t;UT&quot;, flags, challenge));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;cr1&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(up.password, &quot;CRV1::Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l::challenge_r=
esponse&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_get_user_pass_static_challenge(void **state)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&a=
mp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const ch=
ar *challenge =3D &quot;Please enter token PIN&quot;;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D GET_USER_PASS_=
STATIC_CHALLENGE;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(que=
ry_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Username:&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(qu=
ery_user_exec_builtin, &quot;cuser&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_use=
r[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;cp=
assword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
will_return(query_user_exec_builtin, true);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_us=
er[i].prompt, &quot;CHALLENGE: Please enter token PIN&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_b=
uiltin, &quot;challenge_response&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_p=
ass_cr(&amp;up, NULL, &quot;UT&quot;, flags, challenge));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.u=
sername, &quot;cuser&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* SCRV1:cpassword:challenge_response but base64-encoded */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(up.password, &quot;SCRV1:Y3Bhc3N3b3Jk:Y2hhbGxlbmdlX3Jlc3BvbnNl&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS_INLINE_CREDS;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even tho=
ugh nothing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    will_return(query_user_exec_builtin, true);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, qu=
ery_user[i].prompt, &quot;CHALLENGE: Please enter token PIN&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_=
exec_builtin, &quot;challenge_response&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_=
user_pass_cr(&amp;up, &quot;iuser\nipassword&quot;, &quot;UT&quot;, flags, =
challenge));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(up.username, &quot;iuser&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* SCRV1:ipassword:challenge_res=
ponse but base64-encoded */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(up.password, &quot;SCRV1:aXBhc3N3b3Jk:Y2hhb=
GxlbmdlX3Jlc3BvbnNl&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* =
ENABLE_MANAGEMENT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> const struct CMUnitTest user_pass_tests[] =3D {</span><b=
r><span>     cmocka_unit_test(test_get_user_pass_defined),</span><br><span>=
     cmocka_unit_test(test_get_user_pass_needok),</span><br><span>@@ -369,6=
 +426,10 @@</span><br><span>     cmocka_unit_test(test_get_user_pass_authfi=
le_stdin_assertions),</span><br><span>     cmocka_unit_test(test_get_user_p=
ass_authfile_file),</span><br><span>     cmocka_unit_test(test_get_user_pas=
s_authfile_file_assertions),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    cmocka_unit_test(test_get_user_pass_dynamic_challenge),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(=
test_get_user_pass_static_challenge),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><br><span> };</span>=
<br><span> </span><br><span> int</span><br><span></span><br></pre><p>To vie=
w, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/475?usp=3Demail">=
change 475</a>. To unsubscribe, or for help writing mail filters, visit <a =
href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope=
 itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"act=
ion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/475?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b5570f6314e917f92dce072279=
efe415d79b22a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 475 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--pgXbVI+Adnw=--

