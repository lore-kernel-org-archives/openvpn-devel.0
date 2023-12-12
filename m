From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Dec 2023 13:55:55 +0000
In-Reply-To: <gerrit.1702052980000.I8b5570f6314e917f92dce072279efe415d79b22a@...2715...>
References: <gerrit.1702052980000.I8b5570f6314e917f92dce072279efe415d79b22a@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <a384d30a6296d6c033a230fa667e33dfabe5175b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="LTrhDT56XQU="; charset=UTF-8
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

--LTrhDT56XQU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/475?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: test_user_pass: add basic tests for static/dynamic challeng=
es
......................................................................

test_user_pass: add basic tests for static/dynamic challenges

Change-Id: I8b5570f6314e917f92dce072279efe415d79b22a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/test_user_pass.c
1 file changed, 61 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/475/3

diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index d6e5650..743a006 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -364,6 +364,63 @@
 }
 #endif /* ifndef _MSC_VER */

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
@@ -375,6 +432,10 @@
     cmocka_unit_test(test_get_user_pass_authfile_stdin_assertions),
     cmocka_unit_test(test_get_user_pass_authfile_file_assertions),
 #endif
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--LTrhDT56XQU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/475?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">test_user_pass: add basic tests for static/dynam=
ic challenges<br><br>Change-Id: I8b5570f6314e917f92dce072279efe415d79b22a<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M tes=
ts/unit_tests/openvpn/test_user_pass.c<br>1 file changed, 61 insertions(+),=
 0 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/75/475/3</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/test_use=
r_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>index =
d6e5650..743a006 100644</span><br><span>--- a/tests/unit_tests/openvpn/test=
_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass.=
c</span><br><span>@@ -364,6 +364,63 @@</span><br><span> }</span><br><span> =
#endif /* ifndef _MSC_VER */</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+test_get_user_pass_dynamic_challenge(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&=
amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *challenge =3D &quot;CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y3Ix:Ple=
ase enter token PIN&quot;;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int flags =3D GET_USER_PASS_DYNAMIC_CHALLENGE;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, quer=
y_user[i].prompt, &quot;CHALLENGE: Please enter token PIN&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_ex=
ec_builtin, &quot;challenge_response&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_us=
er_pass_cr(&amp;up, NULL, &quot;UT&quot;, flags, challenge));</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(=
up.username, &quot;cr1&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    assert_string_equal(up.password, &quot;CRV1::Om01u7Fh4LrGBS7=
uh0SWmzwabUiGiW6l::challenge_response&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_=
static_challenge(void **state)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    str=
uct user_pass up =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    const char *challenge =3D &quot;Please enter token PI=
N&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigne=
d int flags =3D GET_USER_PASS_STATIC_CHALLENGE;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    expect_string(query_user_exec_builtin, query_user[i].prompt, &=
quot;Enter UT Username:&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    will_return(query_user_exec_builtin, &quot;cuser&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(quer=
y_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(que=
ry_user_exec_builtin, &quot;cpassword&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(que=
ry_user_exec_builtin, query_user[i].prompt, &quot;CHALLENGE: Please enter t=
oken PIN&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 will_return(query_user_exec_builtin, &quot;challenge_response&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_us=
er_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(get_user_pass_cr(&amp;up, NULL, &quot;UT&quot;, flags, =
challenge));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(up.username, &quot;cuser&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    /* SCRV1:cpassword:challenge_res=
ponse but base64-encoded */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(up.password, &quot;SCRV1:Y3Bhc3N3b3Jk:Y2hhb=
GxlbmdlX3Jlc3BvbnNl&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_u=
ser_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_U=
SER_PASS_INLINE_CREDS;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: que=
ry_user_exec() called even though nothing queued */</span><br><span style=
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
eedok),</span><br><span>@@ -375,6 +432,10 @@</span><br><span>     cmocka_un=
it_test(test_get_user_pass_authfile_stdin_assertions),</span><br><span>    =
 cmocka_unit_test(test_get_user_pass_authfile_file_assertions),</span><br><=
span> #endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
ENABLE_MANAGEMENT</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  cmocka_unit_test(test_get_user_pass_dynamic_challenge),</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_user_pa=
ss_static_challenge),</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#endif /* ENABLE_MANAGEMENT */</span><br><span> };</span><br><span> </spa=
n><br><span> int</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/475?usp=3Demail">change 475</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/475?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8b5570f6314e917f92dce072279=
efe415d79b22a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 475 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--LTrhDT56XQU=--

