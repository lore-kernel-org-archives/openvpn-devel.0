From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 17 May 2024 16:10:22 +0000
In-Reply-To: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
References: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ec87893ac47d551846fd7efccc8f48a856fc6633-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="4p910CUIloU="; charset=UTF-8
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

--4p910CUIloU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail

to look at the new patch set (#11).


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
v10:
 - Update mock_msg.c fatal handling to be compatible
   with NO_CMOCKA.

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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/474/11

diff --git a/CMakeLists.txt b/CMakeLists.txt
index f8b37a9..e32c99c 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -668,7 +668,7 @@
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
index a4e6235..22dc075 100644
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
index a291f8f..098f56b 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -39,7 +39,6 @@
 #include "error.h"

 unsigned int x_debug_level =3D 0; /* Default to (almost) no debugging outp=
ut */
-bool fatal_error_triggered =3D false;

 void
 mock_set_debug_level(int level)
@@ -59,11 +58,16 @@
 {
     if (flags & M_FATAL)
     {
-        fatal_error_triggered =3D true;
         printf("FATAL ERROR:");
     }
     vprintf(format, arglist);
     printf("\n");
+#ifndef NO_CMOCKA
+    if (flags & M_FATAL)
+    {
+        mock_assert(false, "FATAL ERROR", __FILE__, __LINE__);
+    }
+#endif
 }

 void
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index ac84654..d6e464f 100644
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
Gerrit-PatchSet: 11
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--4p910CUIloU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #11</strong> to this change.</p>=
<p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail">View C=
hange</a></p><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">test_user_pass: Check fatal errors for empty username/password<br=
><br>Required a fix to mock_msg to make tests of M_FATAL<br>possible at all=
.<br>This also tests some cases which arguably should throw<br>a fatal erro=
r but do not.<br><br>v2:<br> - Suppress LeakSanitizer errors for fatal erro=
r tests.<br>   Due to aborting the function, the memory will not be<br>   c=
leaned up, but that is expected.<br>v3:<br> - Disable assert tests with MSV=
C. Does not seem to catch<br>   the error correctly.<br> - Rebase on top of=
 parallel-tests series to get<br>   AM_TESTS_ENVIRONMENT.<br>v8:<br> - Upda=
te srcdir handling according to master.<br>v10:<br> - Update mock_msg.c fat=
al handling to be compatible<br>   with NO_CMOCKA.<br><br>Change-Id: Icabc8=
acf75638c86c8c395e9ffecba7a7226cd97<br>Signed-off-by: Frank Lichtenheld &lt=
;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M tests/unit_tests/open=
vpn/Makefile.am<br>A tests/unit_tests/openvpn/input/appears_empty.txt<br>A =
tests/unit_tests/openvpn/input/empty.txt<br>A tests/unit_tests/openvpn/inpu=
t/leak_suppr.txt<br>M tests/unit_tests/openvpn/mock_msg.c<br>M tests/unit_t=
ests/openvpn/test_user_pass.c<br>7 files changed, 112 insertions(+), 3 dele=
tions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/74/474/11</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><=
br><span>index f8b37a9..e32c99c 100644</span><br><span>--- a/CMakeLists.txt=
</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -668,7 +668,7 @@</=
span><br><span>             # for compat with autotools make check</span><b=
r><span>             set(_UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/u=
nit_tests/openvpn)</span><br><span>             set_tests_properties(${test=
_name} PROPERTIES</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
            ENVIRONMENT &quot;srcdir=3D${_UT_SOURCE_DIR}&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                ENVIRONMENT &qu=
ot;srcdir=3D${_UT_SOURCE_DIR};LSAN_OPTIONS=3Dsuppressions=3D${_UT_SOURCE_DI=
R}/input/leak_suppr.txt&quot;)</span><br><span>         endif ()</span><br>=
<span>         add_executable(${test_name}</span><br><span>             tes=
ts/unit_tests/openvpn/${test_name}.c</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><b=
r><span>index a4e6235..22dc075 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefi=
le.am</span><br><span>@@ -4,6 +4,8 @@</span><br><span> </span><br><span> AM=
_TESTSUITE_SUMMARY_HEADER =3D &#39; for $(PACKAGE_STRING) Unit-Tests&#39;</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_=
TESTS_ENVIRONMENT =3D export LSAN_OPTIONS=3Dsuppressions=3D$(srcdir)/input/=
leak_suppr.txt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span> test_binaries=3D</span><br><span> </span><br><span> if HAVE_L=
D_WRAP_SUPPORT</span><br><span>diff --git a/tests/unit_tests/openvpn/input/=
appears_empty.txt b/tests/unit_tests/openvpn/input/appears_empty.txt</span>=
<br><span>new file mode 100644</span><br><span>index 0000000..ffb749a</span=
><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/inp=
ut/appears_empty.txt</span><br><span>@@ -0,0 +1,3 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	</span><br><span style=3D"color: hsl(120, 100%, 40%);">+(c=
ontains \t\n\t\n)</span><br><span>diff --git a/tests/unit_tests/openvpn/inp=
ut/empty.txt b/tests/unit_tests/openvpn/input/empty.txt</span><br><span>new=
 file mode 100644</span><br><span>index 0000000..e69de29</span><br><span>--=
- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/input/empty.txt<=
/span><br><span>diff --git a/tests/unit_tests/openvpn/input/leak_suppr.txt =
b/tests/unit_tests/openvpn/input/leak_suppr.txt</span><br><span>new file mo=
de 100644</span><br><span>index 0000000..72ebfe0</span><br><span>--- /dev/n=
ull</span><br><span>+++ b/tests/unit_tests/openvpn/input/leak_suppr.txt</sp=
an><br><span>@@ -0,0 +1 @@</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+leak:_assertions$</span><br><span>diff --git a/tests/unit_tests/open=
vpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c</span><br><span>index =
a291f8f..098f56b 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock=
_msg.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock_msg.c</span><br>=
<span>@@ -39,7 +39,6 @@</span><br><span> #include &quot;error.h&quot;</span=
><br><span> </span><br><span> unsigned int x_debug_level =3D 0; /* Default =
to (almost) no debugging output */</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-bool fatal_error_triggered =3D false;</span><br><span> </span>=
<br><span> void</span><br><span> mock_set_debug_level(int level)</span><br>=
<span>@@ -59,11 +58,16 @@</span><br><span> {</span><br><span>     if (flags=
 &amp; M_FATAL)</span><br><span>     {</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        fatal_error_triggered =3D true;</span><br><span>  =
       printf(&quot;FATAL ERROR:&quot;);</span><br><span>     }</span><br><=
span>     vprintf(format, arglist);</span><br><span>     printf(&quot;\n&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef NO_CMO=
CKA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &a=
mp; M_FATAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mock_assert(f=
alse, &quot;FATAL ERROR&quot;, __FILE__, __LINE__);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </span><br><=
span> void</span><br><span>diff --git a/tests/unit_tests/openvpn/test_user_=
pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>index ac=
84654..d6e464f 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_u=
ser_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass.c<=
/span><br><span>@@ -165,6 +165,16 @@</span><br><span> </span><br><span>    =
 reset_user_pass(&amp;up);</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even though =
nothing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  will_return(query_user_exec_builtin, true);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /*FIXME: silently removes control characters =
but does not error out */</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;\t\n\t&quot;, &quot;U=
T&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(up.defined);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(up.username, &quot;&quot;);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.pas=
sword, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pa=
ss(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span>     expect_string(query_user_exec_builtin, query_user[i].prompt,=
 &quot;Enter UT Password:&quot;);</span><br><span>     will_return(query_us=
er_exec_builtin, &quot;cpassword&quot;);</span><br><span>     will_return(q=
uery_user_exec_builtin, true);</span><br><span>@@ -197,6 +207,25 @@</span><=
br><span>     assert_string_equal(up.password, &quot;cpassword&quot;);</spa=
n><br><span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* NOTE: expect_assert_failure does not seem to work with MSVC=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _MSC_VER=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* NOTE: leaks gc m=
emory */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_=
inline_creds_assertions(void **state)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    struct user_pass up =3D { 0 };</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    unsigned int flags =3D GET_USER_PASS_INLINE_CR=
EDS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called eve=
n though nothing queued */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    /*FIXME? username error thrown very late in stdin handling */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_=
user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    expect_assert_failure(get_user_pass_cr(&amp;up, &quot;\nipassword=
\n&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> static void</span><br><span> test_get_user_pass_authfile_stdin(void=
 **state)</span><br><span> {</span><br><span>@@ -224,8 +253,39 @@</span><br=
><span>     assert_true(up.defined);</span><br><span>     assert_string_equ=
al(up.username, &quot;user&quot;);</span><br><span>     assert_string_equal=
(up.password, &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    flags =
|=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    expect_string(query_user_exec_builtin, query_user[i].prom=
pt, &quot;Enter UT Password:&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_=
user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    /*FIXME? does not error out on empty password */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&am=
p;up, &quot;stdin&quot;, &quot;UT&quot;, flags, NULL));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.use=
rname, &quot;user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(up.password, &quot;&quot;);</span><br><span> =
}</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
/* NOTE: expect_assert_failure does not seem to work with MSVC */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _MSC_VER</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+/* NOTE: leaks gc memory */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_authfile_stdi=
n_assertions(void **state)</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct =
user_pass up =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    unsigned int flags =3D 0;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    expect_string(query_user_exec_builtin, query_user[i].prompt, &quot=
;Enter UT Username:&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    expect_string(query_user_exec_builtin, query_user[i].prompt, &q=
uot;Enter UT Password:&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    will_return(query_user_exec_builtin, &quot;&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_e=
xec_builtin, &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    expect_assert_failure(get_=
user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, flags, NULL));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> static void</span><br><span> test_ge=
t_user_pass_authfile_file(void **state)</span><br><span> {</span><br><span>=
@@ -245,6 +305,17 @@</span><br><span> </span><br><span>     reset_user_pass=
(&amp;up);</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, &quot;input/ap=
pears_empty.txt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    /*FIXME: query_user_exec() called even though nothing queued */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_u=
ser_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /*FIXME? does not error out */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, authfile, &qu=
ot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(up.defined);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_string_equal(up.username, &quot;&quot;);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up=
.password, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_use=
r_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span>     openvpn_test_get_srcdir_dir(authfile, PATH_MAX, &quot;in=
put/user_only.txt&quot;);</span><br><span>     expect_string(query_user_exe=
c_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br=
><span>     will_return(query_user_exec_builtin, &quot;cpassword&quot;);</s=
pan><br><span>@@ -324,6 +395,29 @@</span><br><span> }</span><br><span> #end=
if /* ENABLE_MANAGEMENT */</span><br><span> </span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+/* NOTE: expect_assert_failure does not seem to wo=
rk with MSVC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* NOTE=
: leaks gc memory */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_ge=
t_user_pass_authfile_file_assertions(void **state)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    struct user_pass up =3D { 0 };</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D 0;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char authfile[PATH_MAX] =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    openvpn_test_get_srcdir_dir(authfile, PATH=
_MAX, &quot;input/empty.txt&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    expect_assert_failure(get_user_pass_cr(&amp;up, authfil=
e, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D=
 GET_USER_PASS_PASSWORD_ONLY;</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, &quot;input/e=
mpty.txt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 expect_assert_failure(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;, =
flags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifndef _MSC_V=
ER */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an> const struct CMUnitTest user_pass_tests[] =3D {</span><br><span>     cm=
ocka_unit_test(test_get_user_pass_defined),</span><br><span>     cmocka_uni=
t_test(test_get_user_pass_needok),</span><br><span>@@ -334,6 +428,11 @@</sp=
an><br><span>     cmocka_unit_test(test_get_user_pass_dynamic_challenge),</=
span><br><span>     cmocka_unit_test(test_get_user_pass_static_challenge),<=
/span><br><span> #endif /* ENABLE_MANAGEMENT */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifndef _MSC_VER</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_inline_cre=
ds_assertions),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
cmocka_unit_test(test_get_user_pass_authfile_stdin_assertions),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_u=
ser_pass_authfile_file_assertions),</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span> };</span><br><span> </span><br><spa=
n> int</span><br><span></span><br></pre><p>To view, visit <a href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail">change 474</a>. To unsubsc=
ribe, or for help writing mail filters, visit <a href=3D"http://gerrit.open=
vpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema=
.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://sc=
hema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.n=
et/c/openvpn/+/474?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Ch=
ange"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffe=
cba7a7226cd97 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 474 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 11 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--4p910CUIloU=--

