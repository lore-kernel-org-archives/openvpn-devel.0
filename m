From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Fri, 8 Dec 2023 17:30:49 +0000
In-Reply-To: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
References: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <609706ccaf71fe5629d64c1a81585860c997bbac-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="7id6BMoqJjE="; charset=UTF-8
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

--7id6BMoqJjE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail

to look at the new patch set (#2).


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

Change-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd97
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M CMakeLists.txt
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/input/appears_empty.txt
A tests/unit_tests/openvpn/input/empty.txt
A tests/unit_tests/openvpn/input/leak_suppr.txt
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/test_user_pass.c
8 files changed, 100 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/74/474/2

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index d7cc01c..784a844 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -283,6 +283,7 @@
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release
           testPreset: win-${{ matrix.arch }}-release
+          testPresetAdditionalArgs: "['--output-on-failure']"

       - uses: actions/upload-artifact@...2689...
         with:
diff --git a/CMakeLists.txt b/CMakeLists.txt
index 3f96354..142bde4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -621,8 +621,9 @@
         if (NOT ${test_name} STREQUAL "test_networking")
             add_test(${test_name} ${test_name})
             # for compat with autotools make check
+            set(_UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_test=
s/openvpn)
             set_tests_properties(${test_name} PROPERTIES
-                ENVIRONMENT "srcdir=3D${CMAKE_CURRENT_SOURCE_DIR}/tests/un=
it_tests/openvpn")
+                ENVIRONMENT "srcdir=3D${_UT_SOURCE_DIR};LSAN_OPTIONS=3Dsup=
pressions=3D${_UT_SOURCE_DIR}/input/leak_suppr.txt")
         endif ()
         add_executable(${test_name}
             tests/unit_tests/openvpn/${test_name}.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 6199b4a..ac85aca 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -2,6 +2,8 @@

 EXTRA_DIST =3D input

+export LSAN_OPTIONS=3Dsuppressions=3D$(srcdir)/input/leak_suppr.txt
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
index e468d3f..ed65fdb 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -172,6 +172,16 @@

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
@@ -205,6 +215,21 @@
 }

 static void
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
+
+static void
 test_get_user_pass_authfile_stdin(void **state)
 {
     struct user_pass up =3D { 0 };
@@ -231,6 +256,33 @@
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
+}
+
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
 }

 static void
@@ -254,6 +306,17 @@

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
@@ -276,12 +339,36 @@
     assert_string_equal(up.password, "fuser");
 }

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
+
 const struct CMUnitTest user_pass_tests[] =3D {
     cmocka_unit_test(test_get_user_pass_defined),
     cmocka_unit_test(test_get_user_pass_needok),
     cmocka_unit_test(test_get_user_pass_inline_creds),
+    cmocka_unit_test(test_get_user_pass_inline_creds_assertions),
     cmocka_unit_test(test_get_user_pass_authfile_stdin),
+    cmocka_unit_test(test_get_user_pass_authfile_stdin_assertions),
     cmocka_unit_test(test_get_user_pass_authfile_file),
+    cmocka_unit_test(test_get_user_pass_authfile_file_assertions),
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--7id6BMoqJjE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">test_user_pass: Check fatal errors for empty username/password<br>=
<br>Required a fix to mock_msg to make tests of M_FATAL<br>possible at all.=
<br>This also tests some cases which arguably should throw<br>a fatal error=
 but do not.<br><br>v2:<br> - Suppress LeakSanitizer errors for fatal error=
 tests.<br>   Due to aborting the function, the memory will not be<br>   cl=
eaned up, but that is expected.<br><br>Change-Id: Icabc8acf75638c86c8c395e9=
ffecba7a7226cd97<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>---<br>M .github/workflows/build.yaml<br>M CMakeLists.txt<br>M tests/=
unit_tests/openvpn/Makefile.am<br>A tests/unit_tests/openvpn/input/appears_=
empty.txt<br>A tests/unit_tests/openvpn/input/empty.txt<br>A tests/unit_tes=
ts/openvpn/input/leak_suppr.txt<br>M tests/unit_tests/openvpn/mock_msg.c<br=
>M tests/unit_tests/openvpn/test_user_pass.c<br>8 files changed, 100 insert=
ions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/o=
penvpn refs/changes/74/474/2</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/.github/workflows/build.y=
aml b/.github/workflows/build.yaml</span><br><span>index d7cc01c..784a844 1=
00644</span><br><span>--- a/.github/workflows/build.yaml</span><br><span>++=
+ b/.github/workflows/build.yaml</span><br><span>@@ -283,6 +283,7 @@</span>=
<br><span>           configurePreset: win-${{ matrix.arch }}-release</span>=
<br><span>           buildPreset: win-${{ matrix.arch }}-release</span><br>=
<span>           testPreset: win-${{ matrix.arch }}-release</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+          testPresetAdditionalArgs:=
 &quot;[&#39;--output-on-failure&#39;]&quot;</span><br><span> </span><br><s=
pan>       - uses: actions/upload-artifact@...2689...</span><br><span>     =
    with:</span><br><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</spa=
n><br><span>index 3f96354..142bde4 100644</span><br><span>--- a/CMakeLists.=
txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -621,8 +621,9 @=
@</span><br><span>         if (NOT ${test_name} STREQUAL &quot;test_network=
ing&quot;)</span><br><span>             add_test(${test_name} ${test_name})=
</span><br><span>             # for compat with autotools make check</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+            set(_UT_SOURCE=
_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_tests/openvpn)</span><br><span>=
             set_tests_properties(${test_name} PROPERTIES</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-                ENVIRONMENT &quot;srcdi=
r=3D${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_tests/openvpn&quot;)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+                ENVIRONMENT &qu=
ot;srcdir=3D${_UT_SOURCE_DIR};LSAN_OPTIONS=3Dsuppressions=3D${_UT_SOURCE_DI=
R}/input/leak_suppr.txt&quot;)</span><br><span>         endif ()</span><br>=
<span>         add_executable(${test_name}</span><br><span>             tes=
ts/unit_tests/openvpn/${test_name}.c</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><b=
r><span>index 6199b4a..ac85aca 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefi=
le.am</span><br><span>@@ -2,6 +2,8 @@</span><br><span> </span><br><span> EX=
TRA_DIST =3D input</span><br><span> </span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+export LSAN_OPTIONS=3Dsuppressions=3D$(srcdir)/input/leak_=
suppr.txt</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> test_binaries=3D</span><br><span> </span><br><span> if HAVE_LD_WRAP=
_SUPPORT</span><br><span>diff --git a/tests/unit_tests/openvpn/input/appear=
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
br><span>diff --git a/tests/unit_tests/openvpn/input/leak_suppr.txt b/tests=
/unit_tests/openvpn/input/leak_suppr.txt</span><br><span>new file mode 1006=
44</span><br><span>index 0000000..72ebfe0</span><br><span>--- /dev/null</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/input/leak_suppr.txt</span><br>=
<span>@@ -0,0 +1 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
leak:_assertions$</span><br><span>diff --git a/tests/unit_tests/openvpn/moc=
k_msg.c b/tests/unit_tests/openvpn/mock_msg.c</span><br><span>index d74efaa=
..2fcad9d 100644</span><br><span>--- a/tests/unit_tests/openvpn/mock_msg.c<=
/span><br><span>+++ b/tests/unit_tests/openvpn/mock_msg.c</span><br><span>@=
@ -38,7 +38,6 @@</span><br><span> #include &quot;error.h&quot;</span><br><s=
pan> </span><br><span> unsigned int x_debug_level =3D 0; /* Default to (alm=
ost) no debugging output */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-bool fatal_error_triggered =3D false;</span><br><span> </span><br><sp=
an> void</span><br><span> mock_set_debug_level(int level)</span><br><span>@=
@ -58,11 +57,14 @@</span><br><span> {</span><br><span>     if (flags &amp; =
M_FATAL)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-        fatal_error_triggered =3D true;</span><br><span>         =
printf(&quot;FATAL ERROR:&quot;);</span><br><span>     }</span><br><span>  =
   vprintf(format, arglist);</span><br><span>     printf(&quot;\n&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (flags &amp; M=
_FATAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        mock_assert(false,=
 &quot;FATAL ERROR&quot;, __FILE__, __LINE__);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    }</span><br><span> }</span><br><span> </span=
><br><span> void</span><br><span>diff --git a/tests/unit_tests/openvpn/test=
_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>in=
dex e468d3f..ed65fdb 100644</span><br><span>--- a/tests/unit_tests/openvpn/=
test_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_p=
ass.c</span><br><span>@@ -172,6 +172,16 @@</span><br><span> </span><br><spa=
n>     reset_user_pass(&amp;up);</span><br><span> </span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even t=
hough nothing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    will_return(query_user_exec_builtin, true);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: silently removes control cha=
racters but does not error out */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;\t\n\t&quot;,=
 &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equa=
l(up.password, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset=
_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span>     expect_string(query_user_exec_builtin, query_user[i]=
.prompt, &quot;Enter UT Password:&quot;);</span><br><span>     will_return(=
query_user_exec_builtin, &quot;cpassword&quot;);</span><br><span>     will_=
return(query_user_exec_builtin, true);</span><br><span>@@ -205,6 +215,21 @@=
</span><br><span> }</span><br><span> </span><br><span> static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_inline_cr=
eds_assertions(void **state)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struc=
t user_pass up =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    unsigned int flags =3D GET_USER_PASS_INLINE_CREDS;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even though =
nothing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  /*FIXME? username error thrown very late in stdin handling */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec=
_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 expect_assert_failure(get_user_pass_cr(&amp;up, &quot;\nipassword\n&quot;,=
 &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><sp=
an> test_get_user_pass_authfile_stdin(void **state)</span><br><span> {</spa=
n><br><span>     struct user_pass up =3D { 0 };</span><br><span>@@ -231,6 +=
256,33 @@</span><br><span>     assert_true(up.defined);</span><br><span>   =
  assert_string_equal(up.username, &quot;user&quot;);</span><br><span>     =
assert_string_equal(up.password, &quot;cpassword&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin=
, query_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builti=
n, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  will_return(query_user_exec_builtin, true);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /*FIXME? does not error out on empty password=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
get_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, flags, NULL));=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.=
defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_string_equal(up.username, &quot;user&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+test_get_user_pass_authfile_stdin_assertions(void **state)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;u=
p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int=
 flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_u=
ser_exec_builtin, query_user[i].prompt, &quot;Enter UT Username:&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(quer=
y_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(que=
ry_user_exec_builtin, &quot;&quot;);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;cpassword&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_retu=
rn(query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    expect_assert_failure(get_user_pass_cr(&amp;up, &quot;st=
din&quot;, &quot;UT&quot;, flags, NULL));</span><br><span> }</span><br><spa=
n> </span><br><span> static void</span><br><span>@@ -254,6 +306,17 @@</span=
><br><span> </span><br><span>     reset_user_pass(&amp;up);</span><br><span=
> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(auth=
file, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/appears_empty.txt&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: q=
uery_user_exec() called even though nothing queued */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, =
true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME? =
does not error out */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;, flags=
, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(up.username, &quot;&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>    =
 snprintf(authfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/user_o=
nly.txt&quot;);</span><br><span>     expect_string(query_user_exec_builtin,=
 query_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span>   =
  will_return(query_user_exec_builtin, &quot;cpassword&quot;);</span><br><s=
pan>@@ -276,12 +339,36 @@</span><br><span>     assert_string_equal(up.passw=
ord, &quot;fuser&quot;);</span><br><span> }</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_authfile_file_assertio=
ns(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct user_pass =
up =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
set_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    unsigned int flags =3D 0;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    c=
onst char *srcdir =3D getenv(&quot;srcdir&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_non_null(srcdir);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char authfile[PATH_MAX] =3D { 0 =
};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    snprintf(authfile, PATH_MAX, &qu=
ot;%s/%s&quot;, srcdir, &quot;input/empty.txt&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    expect_assert_failure(get_user_pass_c=
r(&amp;up, authfile, &quot;UT&quot;, flags, NULL));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    snprintf(authfile, PATH_MAX, &quot;%s/%s&=
quot;, srcdir, &quot;input/empty.txt&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    expect_assert_failure(get_user_pass_cr(&amp;up=
, authfile, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span> const struct CMUnitTest user_pass_tests[] =3D {</spa=
n><br><span>     cmocka_unit_test(test_get_user_pass_defined),</span><br><s=
pan>     cmocka_unit_test(test_get_user_pass_needok),</span><br><span>     =
cmocka_unit_test(test_get_user_pass_inline_creds),</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_inli=
ne_creds_assertions),</span><br><span>     cmocka_unit_test(test_get_user_p=
ass_authfile_stdin),</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    cmocka_unit_test(test_get_user_pass_authfile_stdin_assertions),</span>=
<br><span>     cmocka_unit_test(test_get_user_pass_authfile_file),</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_ge=
t_user_pass_authfile_file_assertions),</span><br><span> };</span><br><span>=
 </span><br><span> int</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail">change 474=
</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"ht=
tp://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffe=
cba7a7226cd97 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 474 </div>
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


--7id6BMoqJjE=--

