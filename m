From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 7 Feb 2024 14:47:03 +0000
In-Reply-To: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
References: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <d71f2aa6cc65720ee18c27e73f8b90c8b6286e09-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s5EecRjXrxs="; charset=UTF-8
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

--s5EecRjXrxs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail

to look at the new patch set (#8).

The following approvals got outdated and were removed:
Code-Review-1 by plaisthos


Change subject: test_user_pass: Check fatal errors for empty username/passw=
ord
......................................................................

test_user_pass: Check fatal errors for empty username/password

Required a fix to mock_msg to make tests of M_FATAL
possible at all.
This also tests some cases which arguably should throw
a fatal error but do not.

v2:
 - Suppress LeakSanitizer errors for fatal error tests.
   Due to aborting the function, the memory will not be
   cleaned up, but that is expected.
v3:
 - Disable assert tests with MSVC. Does not seem to catch
   the error correctly.
 - Rebase on top of parallel-tests series to get
   AM_TESTS_ENVIRONMENT.
v8:
 - Update srcdir handling according to master.

Change-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd97
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/input/appears_empty.txt
A tests/unit_tests/openvpn/input/empty.txt
A tests/unit_tests/openvpn/input/leak_suppr.txt
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/test_user_pass.c
7 files changed, 110 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/474/8

diff --git a/CMakeLists.txt b/CMakeLists.txt
index fdd2b01..a96733e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -666,7 +666,7 @@
             # for compat with autotools make check
             set(_UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_test=
s/openvpn)
             set_tests_properties(${test_name} PROPERTIES
-                ENVIRONMENT "srcdir=3D${_UT_SOURCE_DIR}")
+                ENVIRONMENT "srcdir=3D${_UT_SOURCE_DIR};LSAN_OPTIONS=3Dsup=
pressions=3D${_UT_SOURCE_DIR}/input/leak_suppr.txt")
         endif ()
         add_executable(${test_name}
             tests/unit_tests/openvpn/${test_name}.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 88a694d..7b0a086 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -4,6 +4,8 @@

 AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) Unit-Tests'

+AM_TESTS_ENVIRONMENT =3D export LSAN_OPTIONS=3Dsuppressions=3D$(srcdir)/in=
put/leak_suppr.txt;
+
 test_binaries=3D

 if HAVE_LD_WRAP_SUPPORT
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
diff --git a/tests/unit_tests/openvpn/input/leak_suppr.txt b/tests/unit_tes=
ts/openvpn/input/leak_suppr.txt
new file mode 100644
index 0000000..72ebfe0
--- /dev/null
+++ b/tests/unit_tests/openvpn/input/leak_suppr.txt
@@ -0,0 +1 @@
+leak:_assertions$
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
index 5d3f9b6..4506571 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -165,6 +165,16 @@

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
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
     will_return(query_user_exec_builtin, "cpassword");
     will_return(query_user_exec_builtin, true);
@@ -197,6 +207,25 @@
     assert_string_equal(up.password, "cpassword");
 }

+/* NOTE: expect_assert_failure does not seem to work with MSVC */
+#ifndef _MSC_VER
+/* NOTE: leaks gc memory */
+static void
+test_get_user_pass_inline_creds_assertions(void **state)
+{
+    struct user_pass up =3D { 0 };
+    reset_user_pass(&up);
+    unsigned int flags =3D GET_USER_PASS_INLINE_CREDS;
+
+    reset_user_pass(&up);
+
+    /*FIXME: query_user_exec() called even though nothing queued */
+    /*FIXME? username error thrown very late in stdin handling */
+    will_return(query_user_exec_builtin, true);
+    expect_assert_failure(get_user_pass_cr(&up, "\nipassword\n", "UT", fla=
gs, NULL));
+}
+#endif
+
 static void
 test_get_user_pass_authfile_stdin(void **state)
 {
@@ -224,8 +253,39 @@
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

+/* NOTE: expect_assert_failure does not seem to work with MSVC */
+#ifndef _MSC_VER
+/* NOTE: leaks gc memory */
+static void
+test_get_user_pass_authfile_stdin_assertions(void **state)
+{
+    struct user_pass up =3D { 0 };
+    reset_user_pass(&up);
+    unsigned int flags =3D 0;
+
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Username:");
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
+    will_return(query_user_exec_builtin, "");
+    will_return(query_user_exec_builtin, "cpassword");
+    will_return(query_user_exec_builtin, true);
+    expect_assert_failure(get_user_pass_cr(&up, "stdin", "UT", flags, NULL=
));
+}
+#endif
+
 static void
 test_get_user_pass_authfile_file(void **state)
 {
@@ -245,6 +305,17 @@

     reset_user_pass(&up);

+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/appears_empty.t=
xt");
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
     openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/user_only.txt");
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
     will_return(query_user_exec_builtin, "cpassword");
@@ -324,6 +395,29 @@
 }
 #endif /* ENABLE_MANAGEMENT */

+/* NOTE: expect_assert_failure does not seem to work with MSVC */
+#ifndef _MSC_VER
+/* NOTE: leaks gc memory */
+static void
+test_get_user_pass_authfile_file_assertions(void **state)
+{
+    struct user_pass up =3D { 0 };
+    reset_user_pass(&up);
+    unsigned int flags =3D 0;
+
+    char authfile[PATH_MAX] =3D { 0 };
+
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/empty.txt");
+    expect_assert_failure(get_user_pass_cr(&up, authfile, "UT", flags, NUL=
L));
+
+    reset_user_pass(&up);
+
+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/empty.txt");
+    expect_assert_failure(get_user_pass_cr(&up, authfile, "UT", flags, NUL=
L));
+}
+#endif /* ifndef _MSC_VER */
+
 const struct CMUnitTest user_pass_tests[] =3D {
     cmocka_unit_test(test_get_user_pass_defined),
     cmocka_unit_test(test_get_user_pass_needok),
@@ -334,6 +428,11 @@
     cmocka_unit_test(test_get_user_pass_dynamic_challenge),
     cmocka_unit_test(test_get_user_pass_static_challenge),
 #endif /* ENABLE_MANAGEMENT */
+#ifndef _MSC_VER
+    cmocka_unit_test(test_get_user_pass_inline_creds_assertions),
+    cmocka_unit_test(test_get_user_pass_authfile_stdin_assertions),
+    cmocka_unit_test(test_get_user_pass_authfile_file_assertions),
+#endif
 };

 int

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd97
Gerrit-Change-Number: 474
Gerrit-PatchSet: 8
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--s5EecRjXrxs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #8</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">test_user_pass: Check fatal errors for empty use=
rname/password<br><br>Required a fix to mock_msg to make tests of M_FATAL<b=
r>possible at all.<br>This also tests some cases which arguably should thro=
w<br>a fatal error but do not.<br><br>v2:<br> - Suppress LeakSanitizer erro=
rs for fatal error tests.<br>   Due to aborting the function, the memory wi=
ll not be<br>   cleaned up, but that is expected.<br>v3:<br> - Disable asse=
rt tests with MSVC. Does not seem to catch<br>   the error correctly.<br> -=
 Rebase on top of parallel-tests series to get<br>   AM_TESTS_ENVIRONMENT.<=
br>v8:<br> - Update srcdir handling according to master.<br><br>Change-Id: =
Icabc8acf75638c86c8c395e9ffecba7a7226cd97<br>Signed-off-by: Frank Lichtenhe=
ld &lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M tests/unit_test=
s/openvpn/Makefile.am<br>A tests/unit_tests/openvpn/input/appears_empty.txt=
<br>A tests/unit_tests/openvpn/input/empty.txt<br>A tests/unit_tests/openvp=
n/input/leak_suppr.txt<br>M tests/unit_tests/openvpn/mock_msg.c<br>M tests/=
unit_tests/openvpn/test_user_pass.c<br>7 files changed, 110 insertions(+), =
3 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace;=
 white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn re=
fs/changes/74/474/8</pre><pre style=3D"font-family: monospace,monospace; wh=
ite-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</s=
pan><br><span>index fdd2b01..a96733e 100644</span><br><span>--- a/CMakeList=
s.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -666,7 +666,7=
 @@</span><br><span>             # for compat with autotools make check</sp=
an><br><span>             set(_UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/te=
sts/unit_tests/openvpn)</span><br><span>             set_tests_properties($=
{test_name} PROPERTIES</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-                ENVIRONMENT &quot;srcdir=3D${_UT_SOURCE_DIR}&quot;)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                ENVIRONMEN=
T &quot;srcdir=3D${_UT_SOURCE_DIR};LSAN_OPTIONS=3Dsuppressions=3D${_UT_SOUR=
CE_DIR}/input/leak_suppr.txt&quot;)</span><br><span>         endif ()</span=
><br><span>         add_executable(${test_name}</span><br><span>           =
  tests/unit_tests/openvpn/${test_name}.c</span><br><span>diff --git a/test=
s/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</sp=
an><br><span>index 88a694d..7b0a086 100644</span><br><span>--- a/tests/unit=
_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/M=
akefile.am</span><br><span>@@ -4,6 +4,8 @@</span><br><span> </span><br><spa=
n> AM_TESTSUITE_SUMMARY_HEADER =3D &#39; for $(PACKAGE_STRING) Unit-Tests&#=
39;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+AM_TESTS_ENVIRONMENT =3D export LSAN_OPTIONS=3Dsuppressions=3D$(srcdir)/i=
nput/leak_suppr.txt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span> test_binaries=3D</span><br><span> </span><br><span> if H=
AVE_LD_WRAP_SUPPORT</span><br><span>diff --git a/tests/unit_tests/openvpn/i=
nput/appears_empty.txt b/tests/unit_tests/openvpn/input/appears_empty.txt</=
span><br><span>new file mode 100644</span><br><span>index 0000000..ffb749a<=
/span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvp=
n/input/appears_empty.txt</span><br><span>@@ -0,0 +1,3 @@</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+(contains \t\n\t\n)</span><br><span>diff --git a/tests/unit_tests/openvpn=
/input/empty.txt b/tests/unit_tests/openvpn/input/empty.txt</span><br><span=
>new file mode 100644</span><br><span>index 0000000..e69de29</span><br><spa=
n>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/input/empty.=
txt</span><br><span>diff --git a/tests/unit_tests/openvpn/input/leak_suppr.=
txt b/tests/unit_tests/openvpn/input/leak_suppr.txt</span><br><span>new fil=
e mode 100644</span><br><span>index 0000000..72ebfe0</span><br><span>--- /d=
ev/null</span><br><span>+++ b/tests/unit_tests/openvpn/input/leak_suppr.txt=
</span><br><span>@@ -0,0 +1 @@</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+leak:_assertions$</span><br><span>diff --git a/tests/unit_tests/=
openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c</span><br><span>in=
dex d74efaa..2fcad9d 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
mock_msg.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_msg.c</span>=
<br><span>@@ -38,7 +38,6 @@</span><br><span> #include &quot;error.h&quot;</=
span><br><span> </span><br><span> unsigned int x_debug_level =3D 0; /* Defa=
ult to (almost) no debugging output */</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-bool fatal_error_triggered =3D false;</span><br><span> </s=
pan><br><span> void</span><br><span> mock_set_debug_level(int level)</span>=
<br><span>@@ -58,11 +57,14 @@</span><br><span> {</span><br><span>     if (f=
lags &amp; M_FATAL)</span><br><span>     {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-        fatal_error_triggered =3D true;</span><br><spa=
n>         printf(&quot;FATAL ERROR:&quot;);</span><br><span>     }</span><=
br><span>     vprintf(format, arglist);</span><br><span>     printf(&quot;\=
n&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (fl=
ags &amp; M_FATAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mock_as=
sert(false, &quot;FATAL ERROR&quot;, __FILE__, __LINE__);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><s=
pan> </span><br><span> void</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><=
br><span>index 5d3f9b6..4506571 100644</span><br><span>--- a/tests/unit_tes=
ts/openvpn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/=
test_user_pass.c</span><br><span>@@ -165,6 +165,16 @@</span><br><span> </sp=
an><br><span>     reset_user_pass(&amp;up);</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() ca=
lled even though nothing queued */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: silently removes co=
ntrol characters but does not error out */</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;\t\n=
\t&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(up.password, &quot;&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span>     expect_string(query_user_exec_builtin, quer=
y_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span>     wil=
l_return(query_user_exec_builtin, &quot;cpassword&quot;);</span><br><span> =
    will_return(query_user_exec_builtin, true);</span><br><span>@@ -197,6 +=
207,25 @@</span><br><span>     assert_string_equal(up.password, &quot;cpass=
word&quot;);</span><br><span> }</span><br><span> </span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+/* NOTE: expect_assert_failure does not seem =
to work with MSVC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifndef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*=
 NOTE: leaks gc memory */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+te=
st_get_user_pass_inline_creds_assertions(void **state)</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct user_pass up =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D GET_=
USER_PASS_INLINE_CREDS;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_=
pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_=
exec() called even though nothing queued */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /*FIXME? username error thrown very late in std=
in handling */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
ill_return(query_user_exec_builtin, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    expect_assert_failure(get_user_pass_cr(&amp;up, =
&quot;\nipassword\n&quot;, &quot;UT&quot;, flags, NULL));</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span> static void</span><br><span> test_get_user_pass_au=
thfile_stdin(void **state)</span><br><span> {</span><br><span>@@ -224,8 +25=
3,39 @@</span><br><span>     assert_true(up.defined);</span><br><span>     =
assert_string_equal(up.username, &quot;user&quot;);</span><br><span>     as=
sert_string_equal(up.password, &quot;cpassword&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, q=
uery_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, =
&quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    w=
ill_return(query_user_exec_builtin, true);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /*FIXME? does not error out on empty password */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get=
_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, flags, NULL));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.def=
ined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(up.username, &quot;user&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;&quot;);<=
/span><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* NOTE: expect_assert_failure does not seem to work with =
MSVC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _MSC=
_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* NOTE: leaks =
gc memory */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static =
void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_user_p=
ass_authfile_stdin_assertions(void **state)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    struct user_pass up =3D { 0 };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D 0;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_user=
[i].prompt, &quot;Enter UT Username:&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_u=
ser[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_re=
turn(query_user_exec_builtin, &quot;cpassword&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, =
true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_as=
sert_failure(get_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, f=
lags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> static void</span><=
br><span> test_get_user_pass_authfile_file(void **state)</span><br><span> {=
</span><br><span>@@ -245,6 +305,17 @@</span><br><span> </span><br><span>   =
  reset_user_pass(&amp;up);</span><br><span> </span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    openvpn_test_get_srcdir_dir(authfile, PATH_MA=
X, &quot;input/appears_empty.txt&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even though noth=
ing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    wi=
ll_return(query_user_exec_builtin, true);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    /*FIXME? does not error out */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;=
up, authfile, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quo=
t;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_string_equal(up.password, &quot;&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span>     openvpn_test_get_srcdir_dir(authfile, P=
ATH_MAX, &quot;input/user_only.txt&quot;);</span><br><span>     expect_stri=
ng(query_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Password:&=
quot;);</span><br><span>     will_return(query_user_exec_builtin, &quot;cpa=
ssword&quot;);</span><br><span>@@ -324,6 +395,29 @@</span><br><span> }</spa=
n><br><span> #endif /* ENABLE_MANAGEMENT */</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+/* NOTE: expect_assert_failure do=
es not seem to work with MSVC */</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#ifndef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/* NOTE: leaks gc memory */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+test_get_user_pass_authfile_file_assertions(void **state)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int fla=
gs =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    char authfile[PATH_MAX] =
=3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_test_get_srcdir_=
dir(authfile, PATH_MAX, &quot;input/empty.txt&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    expect_assert_failure(get_user_pass_c=
r(&amp;up, authfile, &quot;UT&quot;, flags, NULL));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    openvpn_test_get_srcdir_dir(authfile, PAT=
H_MAX, &quot;input/empty.txt&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    expect_assert_failure(get_user_pass_cr(&amp;up, authfi=
le, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#en=
dif /* ifndef _MSC_VER */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> const struct CMUnitTest user_pass_tests[] =3D {</sp=
an><br><span>     cmocka_unit_test(test_get_user_pass_defined),</span><br><=
span>     cmocka_unit_test(test_get_user_pass_needok),</span><br><span>@@ -=
334,6 +428,11 @@</span><br><span>     cmocka_unit_test(test_get_user_pass_d=
ynamic_challenge),</span><br><span>     cmocka_unit_test(test_get_user_pass=
_static_challenge),</span><br><span> #endif /* ENABLE_MANAGEMENT */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _MSC_VER</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_=
user_pass_inline_creds_assertions),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_authfile_stdin_asse=
rtions),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_=
unit_test(test_get_user_pass_authfile_file_assertions),</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> };</span><br><s=
pan> </span><br><span> int</span><br><span></span><br></pre><p>To view, vis=
it <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail">change=
 474</a>. To unsubscribe, or for help writing mail filters, visit <a href=
=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffe=
cba7a7226cd97 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 474 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 8 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--s5EecRjXrxs=--

