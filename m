From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Dec 2023 13:55:55 +0000
In-Reply-To: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
References: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <13ecb6f1bd2a3ee3b29e60eb3c69f0665a5814ce-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="tJ+TVi9RqiI="; charset=UTF-8
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

--tJ+TVi9RqiI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail

to look at the new patch set (#3).

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
7 files changed, 112 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/474/3

diff --git a/CMakeLists.txt b/CMakeLists.txt
index af891a5..bbbf683 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -649,7 +649,7 @@
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
index 342f428..5d95c7b 100644
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
index 277cb1d..d6e5650 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -164,6 +164,16 @@

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
@@ -196,6 +206,25 @@
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
@@ -223,8 +252,39 @@
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
@@ -246,6 +306,17 @@

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
@@ -268,12 +339,42 @@
     assert_string_equal(up.password, "fuser");
 }
=20
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
+    const char *srcdir =3D getenv("srcdir");
+    assert_non_null(srcdir);
+    char authfile[PATH_MAX] =3D { 0 };
+
+    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/empty.txt");
+    expect_assert_failure(get_user_pass_cr(&up, authfile, "UT", flags, NUL=
L));
+
+    reset_user_pass(&up);
+
+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;
+    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/empty.txt");
+    expect_assert_failure(get_user_pass_cr(&up, authfile, "UT", flags, NUL=
L));
+}
+#endif /* ifndef _MSC_VER */
+
 const struct CMUnitTest user_pass_tests[] =3D {
     cmocka_unit_test(test_get_user_pass_defined),
     cmocka_unit_test(test_get_user_pass_needok),
     cmocka_unit_test(test_get_user_pass_inline_creds),
     cmocka_unit_test(test_get_user_pass_authfile_stdin),
     cmocka_unit_test(test_get_user_pass_authfile_file),
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
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--tJ+TVi9RqiI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
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
br><br>Change-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd97<br>Signed-off-b=
y: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br=
>M tests/unit_tests/openvpn/Makefile.am<br>A tests/unit_tests/openvpn/input=
/appears_empty.txt<br>A tests/unit_tests/openvpn/input/empty.txt<br>A tests=
/unit_tests/openvpn/input/leak_suppr.txt<br>M tests/unit_tests/openvpn/mock=
_msg.c<br>M tests/unit_tests/openvpn/test_user_pass.c<br>7 files changed, 1=
12 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/74/474/3</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b=
/CMakeLists.txt</span><br><span>index af891a5..bbbf683 100644</span><br><sp=
an>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><spa=
n>@@ -649,7 +649,7 @@</span><br><span>             # for compat with autoto=
ols make check</span><br><span>             set(_UT_SOURCE_DIR ${CMAKE_CURR=
ENT_SOURCE_DIR}/tests/unit_tests/openvpn)</span><br><span>             set_=
tests_properties(${test_name} PROPERTIES</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-                ENVIRONMENT &quot;srcdir=3D${_UT_SOURCE_=
DIR}&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        =
        ENVIRONMENT &quot;srcdir=3D${_UT_SOURCE_DIR};LSAN_OPTIONS=3Dsuppres=
sions=3D${_UT_SOURCE_DIR}/input/leak_suppr.txt&quot;)</span><br><span>     =
    endif ()</span><br><span>         add_executable(${test_name}</span><br=
><span>             tests/unit_tests/openvpn/${test_name}.c</span><br><span=
>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openv=
pn/Makefile.am</span><br><span>index 342f428..5d95c7b 100644</span><br><spa=
n>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/un=
it_tests/openvpn/Makefile.am</span><br><span>@@ -4,6 +4,8 @@</span><br><spa=
n> </span><br><span> AM_TESTSUITE_SUMMARY_HEADER =3D &#39; for $(PACKAGE_ST=
RING) Unit-Tests&#39;</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+AM_TESTS_ENVIRONMENT =3D export LSAN_OPTIONS=3Dsuppress=
ions=3D$(srcdir)/input/leak_suppr.txt;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span> test_binaries=3D</span><br><span> </sp=
an><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><span>diff --git a/tests/un=
it_tests/openvpn/input/appears_empty.txt b/tests/unit_tests/openvpn/input/a=
ppears_empty.txt</span><br><span>new file mode 100644</span><br><span>index=
 0000000..ffb749a</span><br><span>--- /dev/null</span><br><span>+++ b/tests=
/unit_tests/openvpn/input/appears_empty.txt</span><br><span>@@ -0,0 +1,3 @@=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+(contains \t\n\t\n)</span><br><span>diff --git a/tests/=
unit_tests/openvpn/input/empty.txt b/tests/unit_tests/openvpn/input/empty.t=
xt</span><br><span>new file mode 100644</span><br><span>index 0000000..e69d=
e29</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/op=
envpn/input/empty.txt</span><br><span>diff --git a/tests/unit_tests/openvpn=
/input/leak_suppr.txt b/tests/unit_tests/openvpn/input/leak_suppr.txt</span=
><br><span>new file mode 100644</span><br><span>index 0000000..72ebfe0</spa=
n><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/in=
put/leak_suppr.txt</span><br><span>@@ -0,0 +1 @@</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+leak:_assertions$</span><br><span>diff --git a=
/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c<=
/span><br><span>index d74efaa..2fcad9d 100644</span><br><span>--- a/tests/u=
nit_tests/openvpn/mock_msg.c</span><br><span>+++ b/tests/unit_tests/openvpn=
/mock_msg.c</span><br><span>@@ -38,7 +38,6 @@</span><br><span> #include &qu=
ot;error.h&quot;</span><br><span> </span><br><span> unsigned int x_debug_le=
vel =3D 0; /* Default to (almost) no debugging output */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-bool fatal_error_triggered =3D false;</s=
pan><br><span> </span><br><span> void</span><br><span> mock_set_debug_level=
(int level)</span><br><span>@@ -58,11 +57,14 @@</span><br><span> {</span><b=
r><span>     if (flags &amp; M_FATAL)</span><br><span>     {</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-        fatal_error_triggered =3D tr=
ue;</span><br><span>         printf(&quot;FATAL ERROR:&quot;);</span><br><s=
pan>     }</span><br><span>     vprintf(format, arglist);</span><br><span> =
    printf(&quot;\n&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    if (flags &amp; M_FATAL)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        mock_assert(false, &quot;FATAL ERROR&quot;, __FILE__, __LINE__);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><sp=
an> }</span><br><span> </span><br><span> void</span><br><span>diff --git a/=
tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_u=
ser_pass.c</span><br><span>index 277cb1d..d6e5650 100644</span><br><span>--=
- a/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>+++ b/tests/u=
nit_tests/openvpn/test_user_pass.c</span><br><span>@@ -164,6 +164,16 @@</sp=
an><br><span> </span><br><span>     reset_user_pass(&amp;up);</span><br><sp=
an> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: qu=
ery_user_exec() called even though nothing queued */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, =
true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: =
silently removes control characters but does not error out */</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(=
&amp;up, &quot;\t\n\t&quot;, &quot;UT&quot;, flags, NULL));</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up=
.username, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(up.password, &quot;&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     expect_string(query_user=
_exec_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);</span=
><br><span>     will_return(query_user_exec_builtin, &quot;cpassword&quot;)=
;</span><br><span>     will_return(query_user_exec_builtin, true);</span><b=
r><span>@@ -196,6 +206,25 @@</span><br><span>     assert_string_equal(up.pa=
ssword, &quot;cpassword&quot;);</span><br><span> }</span><br><span> </span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/* NOTE: expect_assert_fai=
lure does not seem to work with MSVC */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#ifndef _MSC_VER</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* NOTE: leaks gc memory */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+test_get_user_pass_inline_creds_assertions(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp=
;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned i=
nt flags =3D GET_USER_PASS_INLINE_CREDS;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*F=
IXME: query_user_exec() called even though nothing queued */</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME? username error thrown=
 very late in stdin handling */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    expect_assert_failure(get_user_=
pass_cr(&amp;up, &quot;\nipassword\n&quot;, &quot;UT&quot;, flags, NULL));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> test=
_get_user_pass_authfile_stdin(void **state)</span><br><span> {</span><br><s=
pan>@@ -223,8 +252,39 @@</span><br><span>     assert_true(up.defined);</spa=
n><br><span>     assert_string_equal(up.username, &quot;user&quot;);</span>=
<br><span>     assert_string_equal(up.password, &quot;cpassword&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_us=
er_exec_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_u=
ser_exec_builtin, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME? does not error out on=
 empty password */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_true(get_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;,=
 flags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(up.username, &quot;user&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.passwor=
d, &quot;&quot;);</span><br><span> }</span><br><span> </span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+/* NOTE: expect_assert_failure does not =
seem to work with MSVC */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+#ifndef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* NOTE: leaks gc memory */</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_get_user_pass_authfile_stdin_assertions(void **state)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D=
 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_b=
uiltin, query_user[i].prompt, &quot;Enter UT Username:&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_user_exe=
c_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_ex=
ec_builtin, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    will_return(query_user_exec_builtin, &quot;cpassword&quot;);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_u=
ser_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    expect_assert_failure(get_user_pass_cr(&amp;up, &quot;stdin&quot;,=
 &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> s=
tatic void</span><br><span> test_get_user_pass_authfile_file(void **state)<=
/span><br><span> {</span><br><span>@@ -246,6 +306,17 @@</span><br><span> </=
span><br><span>     reset_user_pass(&amp;up);</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(authfile, PATH_MAX=
, &quot;%s/%s&quot;, srcdir, &quot;input/appears_empty.txt&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec=
() called even though nothing queued */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME? does not error=
 out */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;, flags, NULL));</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defin=
ed);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_stri=
ng_equal(up.username, &quot;&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(up.password, &quot;&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     snprintf(auth=
file, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/user_only.txt&quot;)=
;</span><br><span>     expect_string(query_user_exec_builtin, query_user[i]=
.prompt, &quot;Enter UT Password:&quot;);</span><br><span>     will_return(=
query_user_exec_builtin, &quot;cpassword&quot;);</span><br><span>@@ -268,12=
 +339,42 @@</span><br><span>     assert_string_equal(up.password, &quot;fus=
er&quot;);</span><br><span> }</span><br><span> </span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* NOTE: expect_assert_failure does not seem to=
 work with MSVC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifndef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* N=
OTE: leaks gc memory */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test=
_get_user_pass_authfile_file_assertions(void **state)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct user_pass up =3D { 0 };</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D 0;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    const char *srcdir =3D getenv(&quot;s=
rcdir&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_non_null(srcdir);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    char authfile[PATH_MAX] =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    snprintf(authfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/=
empty.txt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  expect_assert_failure(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;,=
 flags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&am=
p;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS_PAS=
SWORD_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snpr=
intf(authfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/empty.txt&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_as=
sert_failure(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;, flags, NUL=
L));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef _MSC_VER */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> const =
struct CMUnitTest user_pass_tests[] =3D {</span><br><span>     cmocka_unit_=
test(test_get_user_pass_defined),</span><br><span>     cmocka_unit_test(tes=
t_get_user_pass_needok),</span><br><span>     cmocka_unit_test(test_get_use=
r_pass_inline_creds),</span><br><span>     cmocka_unit_test(test_get_user_p=
ass_authfile_stdin),</span><br><span>     cmocka_unit_test(test_get_user_pa=
ss_authfile_file),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
ifndef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
cmocka_unit_test(test_get_user_pass_inline_creds_assertions),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_use=
r_pass_authfile_stdin_assertions),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_authfile_file_assert=
ions),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span>=
<br><span> };</span><br><span> </span><br><span> int</span><br><span></span=
><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/474?usp=3Demail">change 474</a>. To unsubscribe, or for help writing mai=
l filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a=
>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div items=
cope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link it=
emprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffe=
cba7a7226cd97 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 474 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--tJ+TVi9RqiI=--

