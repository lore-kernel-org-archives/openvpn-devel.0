From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 8 Feb 2024 08:31:15 +0000
In-Reply-To: <gerrit.1702052980000.I8b5570f6314e917f92dce072279efe415d79b22a@...2715...>
References: <gerrit.1702052980000.I8b5570f6314e917f92dce072279efe415d79b22a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e3668362b6040db71f579e085422982bb0635640-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pfAzTXqaZZc="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--pfAzTXqaZZc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/475?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/475/9

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
Gerrit-MessageType: newpatchset

--pfAzTXqaZZc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #9</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/475?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">test_user_pass: add basic tests for static/dynam=
ic challenges<br><br>Change-Id: I8b5570f6314e917f92dce072279efe415d79b22a<b=
r>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Ar=
ne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;2024020717123=
9.86730-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn=
-devel@lists.sourceforge.net/msg28191.html<br>Signed-off-by: Gert Doering &=
lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/test_user_pass.=
c<br>1 file changed, 61 insertions(+), 0 deletions(-)<br><br></pre><pre sty=
le=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull ss=
h://gerrit.openvpn.net:29418/openvpn refs/changes/75/475/9</pre><pre style=
=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff --=
git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/=
test_user_pass.c</span><br><span>index bd4eb1f..5d3f9b6 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -267,12 +267,73=
 @@</span><br><span>     assert_string_equal(up.password, &quot;fuser&quot;=
);</span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_get_user_pass_dynamic_challenge(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char *chal=
lenge =3D &quot;CRV1:R,E:Om01u7Fh4LrGBS7uh0SWmzwabUiGiW6l:Y3Ix:Please enter=
 token PIN&quot;;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  unsigned int flags =3D GET_USER_PASS_DYNAMIC_CHALLENGE;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_user[i]=
.prompt, &quot;CHALLENGE: Please enter token PIN&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builti=
n, &quot;challenge_response&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_c=
r(&amp;up, NULL, &quot;UT&quot;, flags, challenge));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.usern=
ame, &quot;cr1&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(up.password, &quot;CRV1::Om01u7Fh4LrGBS7uh0SWmzw=
abUiGiW6l::challenge_response&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_static_c=
hallenge(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct user=
_pass up =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    const char *challenge =3D &quot;Please enter token PIN&quot;;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int fl=
ags =3D GET_USER_PASS_STATIC_CHALLENGE;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;Ent=
er UT Username:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    will_return(query_user_exec_builtin, &quot;cuser&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_user_e=
xec_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_=
exec_builtin, &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_user_=
exec_builtin, query_user[i].prompt, &quot;CHALLENGE: Please enter token PIN=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_re=
turn(query_user_exec_builtin, &quot;challenge_response&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_=
builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(get_user_pass_cr(&amp;up, NULL, &quot;UT&quot;, flags, challeng=
e));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(up.username, &quot;cuser&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /* SCRV1:cpassword:challenge_response bu=
t base64-encoded */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(up.password, &quot;SCRV1:Y3Bhc3N3b3Jk:Y2hhbGxlbmdlX=
3Jlc3BvbnNl&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass=
(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS=
_INLINE_CREDS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_=
exec() called even though nothing queued */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(query=
_user_exec_builtin, query_user[i].prompt, &quot;CHALLENGE: Please enter tok=
en PIN&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
ill_return(query_user_exec_builtin, &quot;challenge_response&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user=
_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(get_user_pass_cr(&amp;up, &quot;iuser\nipassword&quot;, &=
quot;UT&quot;, flags, challenge));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;iuser&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* SCRV1:i=
password:challenge_response but base64-encoded */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;SC=
RV1:aXBhc3N3b3Jk:Y2hhbGxlbmdlX3Jlc3BvbnNl&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif /* ENABLE_MANAGEMENT */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span> const struct CMUnitTest user_pass_=
tests[] =3D {</span><br><span>     cmocka_unit_test(test_get_user_pass_defi=
ned),</span><br><span>     cmocka_unit_test(test_get_user_pass_needok),</sp=
an><br><span>     cmocka_unit_test(test_get_user_pass_inline_creds),</span>=
<br><span>     cmocka_unit_test(test_get_user_pass_authfile_stdin),</span><=
br><span>     cmocka_unit_test(test_get_user_pass_authfile_file),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_MANAGEMENT</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(tes=
t_get_user_pass_dynamic_challenge),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_static_challenge),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ENABLE_MAN=
AGEMENT */</span><br><span> };</span><br><span> </span><br><span> int</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/475?usp=3Demail">change 475</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/475?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--pfAzTXqaZZc=--

