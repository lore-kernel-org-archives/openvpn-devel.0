From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 Dec 2023 16:29:52 +0000
References: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c36ddcd3c6495a143a3f8aee876a1414868c474a-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="ydX/LS4EbGQ="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_user_pass:
 Check fatal errors for empty username/password
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

--ydX/LS4EbGQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail

to review the following change.


Change subject: test_user_pass: Check fatal errors for empty username/passw=
ord
......................................................................

test_user_pass: Check fatal errors for empty username/password

Required a fix to mock_msg to make tests of M_FATAL
possible at all.
This also tests some cases which arguably should throw
a fatal error but do not.

Change-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd97
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
A tests/unit_tests/openvpn/input/appears_empty.txt
A tests/unit_tests/openvpn/input/empty.txt
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/test_user_pass.c
4 files changed, 68 insertions(+), 2 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/474/1

diff --git a/tests/unit_tests/openvpn/input/appears_empty.txt b/tests/unit_=
tests/openvpn/input/appears_empty.txt
new file mode 100644
index 0000000..ffb749a
--- /dev/null
+++ b/tests/unit_tests/openvpn/input/appears_empty.txt
@@ -0,0 +1,3 @@
+
+
+(contains \t\n\t\n)
diff --git a/tests/unit_tests/openvpn/input/empty.txt b/tests/unit_tests/op=
envpn/input/empty.txt
new file mode 100644
index 0000000..e69de29
--- /dev/null
+++ b/tests/unit_tests/openvpn/input/empty.txt
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c
index d74efaa..2fcad9d 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -38,7 +38,6 @@
 #include "error.h"

 unsigned int x_debug_level =3D 0; /* Default to (almost) no debugging outp=
ut */
-bool fatal_error_triggered =3D false;

 void
 mock_set_debug_level(int level)
@@ -58,11 +57,14 @@
 {
     if (flags & M_FATAL)
     {
-        fatal_error_triggered =3D true;
         printf("FATAL ERROR:");
     }
     vprintf(format, arglist);
     printf("\n");
+    if (flags & M_FATAL)
+    {
+        mock_assert(false, "FATAL ERROR", __FILE__, __LINE__);
+    }
 }

 void
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index e468d3f..600ec80 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -172,6 +172,24 @@

     reset_user_pass(&up);

+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    /*FIXME: silently removes control characters but does not error out */
+    assert_true(get_user_pass_cr(&up, "\t\n\t", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "");
+    assert_string_equal(up.password, "");
+
+    reset_user_pass(&up);
+
+    /* Test Assertion */
+    /*FIXME: query_user_exec() called even though nothing queued */
+    /*FIXME? username error thrown very late in stdin handling */
+    will_return(query_user_exec_builtin, true);
+    expect_assert_failure(get_user_pass_cr(&up, "\nipassword\n", "UT", fla=
gs, NULL));
+
+    reset_user_pass(&up);
+
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
     will_return(query_user_exec_builtin, "cpassword");
     will_return(query_user_exec_builtin, true);
@@ -223,6 +241,15 @@

     reset_user_pass(&up);

+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Username:");
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
+    will_return(query_user_exec_builtin, "");
+    will_return(query_user_exec_builtin, "cpassword");
+    will_return(query_user_exec_builtin, true);
+    expect_assert_failure(get_user_pass_cr(&up, "stdin", "UT", flags, NULL=
));
+
+    reset_user_pass(&up);
+
     flags |=3D GET_USER_PASS_PASSWORD_ONLY;
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
     will_return(query_user_exec_builtin, "cpassword");
@@ -231,6 +258,18 @@
     assert_true(up.defined);
     assert_string_equal(up.username, "user");
     assert_string_equal(up.password, "cpassword");
+
+    reset_user_pass(&up);
+
+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
+    will_return(query_user_exec_builtin, "");
+    will_return(query_user_exec_builtin, true);
+    /*FIXME? does not error out on empty password */
+    assert_true(get_user_pass_cr(&up, "stdin", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "user");
+    assert_string_equal(up.password, "");
 }

 static void
@@ -254,6 +293,17 @@

     reset_user_pass(&up);

+    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/appears_empty.txt=
");
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    /*FIXME? does not error out */
+    assert_true(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "");
+    assert_string_equal(up.password, "");
+
+    reset_user_pass(&up);
+
     snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_only.txt");
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
     will_return(query_user_exec_builtin, "cpassword");
@@ -266,6 +316,11 @@

     reset_user_pass(&up);

+    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/empty.txt");
+    expect_assert_failure(get_user_pass_cr(&up, authfile, "UT", flags, NUL=
L));
+
+    reset_user_pass(&up);
+
     flags |=3D GET_USER_PASS_PASSWORD_ONLY;
     snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_only.txt");
     /*FIXME: query_user_exec() called even though nothing queued */
@@ -274,6 +329,12 @@
     assert_true(up.defined);
     assert_string_equal(up.username, "user");
     assert_string_equal(up.password, "fuser");
+
+    reset_user_pass(&up);
+
+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;
+    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/empty.txt");
+    expect_assert_failure(get_user_pass_cr(&up, authfile, "UT", flags, NUL=
L));
 }

 const struct CMUnitTest user_pass_tests[] =3D {

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd97
Gerrit-Change-Number: 474
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--ydX/LS4EbGQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">test_user_pass: Check fatal errors for empty username/passwor=
d<br><br>Required a fix to mock_msg to make tests of M_FATAL<br>possible at=
 all.<br>This also tests some cases which arguably should throw<br>a fatal =
error but do not.<br><br>Change-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd=
97<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>A=
 tests/unit_tests/openvpn/input/appears_empty.txt<br>A tests/unit_tests/ope=
nvpn/input/empty.txt<br>M tests/unit_tests/openvpn/mock_msg.c<br>M tests/un=
it_tests/openvpn/test_user_pass.c<br>4 files changed, 68 insertions(+), 2 d=
eletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/=
changes/74/474/1</pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/input/appear=
s_empty.txt b/tests/unit_tests/openvpn/input/appears_empty.txt</span><br><s=
pan>new file mode 100644</span><br><span>index 0000000..ffb749a</span><br><=
span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/input/app=
ears_empty.txt</span><br><span>@@ -0,0 +1,3 @@</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(contains=
 \t\n\t\n)</span><br><span>diff --git a/tests/unit_tests/openvpn/input/empt=
y.txt b/tests/unit_tests/openvpn/input/empty.txt</span><br><span>new file m=
ode 100644</span><br><span>index 0000000..e69de29</span><br><span>--- /dev/=
null</span><br><span>+++ b/tests/unit_tests/openvpn/input/empty.txt</span><=
br><span>diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_test=
s/openvpn/mock_msg.c</span><br><span>index d74efaa..2fcad9d 100644</span><b=
r><span>--- a/tests/unit_tests/openvpn/mock_msg.c</span><br><span>+++ b/tes=
ts/unit_tests/openvpn/mock_msg.c</span><br><span>@@ -38,7 +38,6 @@</span><b=
r><span> #include &quot;error.h&quot;</span><br><span> </span><br><span> un=
signed int x_debug_level =3D 0; /* Default to (almost) no debugging output =
*/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool fatal_error_tr=
iggered =3D false;</span><br><span> </span><br><span> void</span><br><span>=
 mock_set_debug_level(int level)</span><br><span>@@ -58,11 +57,14 @@</span>=
<br><span> {</span><br><span>     if (flags &amp; M_FATAL)</span><br><span>=
     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fatal_e=
rror_triggered =3D true;</span><br><span>         printf(&quot;FATAL ERROR:=
&quot;);</span><br><span>     }</span><br><span>     vprintf(format, arglis=
t);</span><br><span>     printf(&quot;\n&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    if (flags &amp; M_FATAL)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+        mock_assert(false, &quot;FATAL ERROR&quot;,=
 __FILE__, __LINE__);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    }</span><br><span> }</span><br><span> </span><br><span> void</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit=
_tests/openvpn/test_user_pass.c</span><br><span>index e468d3f..600ec80 1006=
44</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ =
-172,6 +172,24 @@</span><br><span> </span><br><span>     reset_user_pass(&a=
mp;up);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /*FIXME: query_user_exec() called even though nothing queued */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query=
_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /*FIXME: silently removes control characters but does not error =
out */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(get_user_pass_cr(&amp;up, &quot;\t\n\t&quot;, &quot;UT&quot;, flags, NUL=
L));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(up.username, &quot;&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    /* Test Assertion */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called ev=
en though nothing queued */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /*FIXME? username error thrown very late in stdin handling */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query=
_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    expect_assert_failure(get_user_pass_cr(&amp;up, &quot;\nipasswor=
d\n&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span>     expect_string(query_user_exec_builtin, q=
uery_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span>     =
will_return(query_user_exec_builtin, &quot;cpassword&quot;);</span><br><spa=
n>     will_return(query_user_exec_builtin, true);</span><br><span>@@ -223,=
6 +241,15 @@</span><br><span> </span><br><span>     reset_user_pass(&amp;up=
);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;Ent=
er UT Username:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;=
Enter UT Password:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    will_return(query_user_exec_builtin, &quot;&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_=
builtin, &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    expect_assert_failure(get_user=
_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, flags, NULL));</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     flags |=3D GET=
_USER_PASS_PASSWORD_ONLY;</span><br><span>     expect_string(query_user_exe=
c_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br=
><span>     will_return(query_user_exec_builtin, &quot;cpassword&quot;);</s=
pan><br><span>@@ -231,6 +258,18 @@</span><br><span>     assert_true(up.defi=
ned);</span><br><span>     assert_string_equal(up.username, &quot;user&quot=
;);</span><br><span>     assert_string_equal(up.password, &quot;cpassword&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONL=
Y;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string=
(query_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Password:&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_retur=
n(query_user_exec_builtin, &quot;&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME? does not err=
or out on empty password */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;=
UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_true(up.defined);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_string_equal(up.username, &quot;user&quot;);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(u=
p.password, &quot;&quot;);</span><br><span> }</span><br><span> </span><br><=
span> static void</span><br><span>@@ -254,6 +293,17 @@</span><br><span> </s=
pan><br><span>     reset_user_pass(&amp;up);</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    snprintf(authfile, PATH_MAX,=
 &quot;%s/%s&quot;, srcdir, &quot;input/appears_empty.txt&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec(=
) called even though nothing queued */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME? does not error =
out */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;, flags, NULL));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.define=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_strin=
g_equal(up.username, &quot;&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_string_equal(up.password, &quot;&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     snprintf(authf=
ile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/user_only.txt&quot;);=
</span><br><span>     expect_string(query_user_exec_builtin, query_user[i].=
prompt, &quot;Enter UT Password:&quot;);</span><br><span>     will_return(q=
uery_user_exec_builtin, &quot;cpassword&quot;);</span><br><span>@@ -266,6 +=
316,11 @@</span><br><span> </span><br><span>     reset_user_pass(&amp;up);<=
/span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  snprintf(authfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/empty=
.txt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    exp=
ect_assert_failure(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;, flag=
s, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> =
    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span>     snprintf(a=
uthfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/user_only.txt&quo=
t;);</span><br><span>     /*FIXME: query_user_exec() called even though not=
hing queued */</span><br><span>@@ -274,6 +329,12 @@</span><br><span>     as=
sert_true(up.defined);</span><br><span>     assert_string_equal(up.username=
, &quot;user&quot;);</span><br><span>     assert_string_equal(up.password, =
&quot;fuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass=
(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS=
_PASSWORD_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
snprintf(authfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/empty.t=
xt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expec=
t_assert_failure(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;, flags,=
 NULL));</span><br><span> }</span><br><span> </span><br><span> const struct=
 CMUnitTest user_pass_tests[] =3D {</span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demai=
l">change 474</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffe=
cba7a7226cd97 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 474 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--ydX/LS4EbGQ=--

