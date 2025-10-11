From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 11 Oct 2025 10:32:06 +0000
In-Reply-To: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
References: <gerrit.1702052980000.Icabc8acf75638c86c8c395e9ffecba7a7226cd97@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ff101fa1dcc3129774a6a60a71e8a3d0d4ad4109-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="s9Hb+tvS0WA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--s9Hb+tvS0WA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/47=
4?usp=3Demail )

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
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/474
Message-Id: <20251010211154.2780-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59245149/
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/input/appears_empty.txt
A tests/unit_tests/openvpn/input/empty.txt
A tests/unit_tests/openvpn/input/leak_suppr.txt
M tests/unit_tests/openvpn/mock_msg.c
M tests/unit_tests/openvpn/test_user_pass.c
7 files changed, 112 insertions(+), 3 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9511bda..9e0b46e 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -729,7 +729,7 @@
             add_test(${test_name} ${test_name})
             # for compat with autotools make check
             set_tests_properties(${test_name} PROPERTIES
-                ENVIRONMENT "srcdir=3D${_UT_SOURCE_DIR}")
+                ENVIRONMENT "srcdir=3D${_UT_SOURCE_DIR};LSAN_OPTIONS=3Dsup=
pressions=3D${_UT_SOURCE_DIR}/input/leak_suppr.txt")
         endif ()
         add_executable(${test_name}
             tests/unit_tests/openvpn/${test_name}.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 05c0ea5..50f4a11 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -4,6 +4,8 @@

 AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) Unit-Tests'

+AM_TESTS_ENVIRONMENT =3D export LSAN_OPTIONS=3Dsuppressions=3D$(srcdir)/in=
put/leak_suppr.txt;
+
 test_binaries =3D argv_testdriver buffer_testdriver crypto_testdriver pack=
et_id_testdriver auth_token_testdriver \
 	ncp_testdriver misc_testdriver options_parse_testdriver pkt_testdriver ss=
l_testdriver \
 	user_pass_testdriver push_update_msg_testdriver provider_testdriver socke=
t_testdriver
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
index a2aa3f9..2cd1336 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -41,7 +41,6 @@
 msglvl_t x_debug_level =3D 0; /* Default to (almost) no debugging output */
 msglvl_t print_x_debug_level =3D 0;

-bool fatal_error_triggered =3D false;

 char mock_msg_buf[MOCK_MSG_BUF];

@@ -75,7 +74,6 @@
 {
     if (flags & M_FATAL)
     {
-        fatal_error_triggered =3D true;
         printf("FATAL ERROR:");
     }
     CLEAR(mock_msg_buf);
@@ -86,6 +84,12 @@
         printf("%s", mock_msg_buf);
         printf("\n");
     }
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
index 32ec59f..f5dddd6 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -180,6 +180,16 @@

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
@@ -212,6 +222,25 @@
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
@@ -239,8 +268,39 @@
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
@@ -260,6 +320,17 @@

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
@@ -361,6 +432,29 @@
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
@@ -371,6 +465,11 @@
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
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd97
Gerrit-Change-Number: 474
Gerrit-PatchSet: 14
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--s9Hb+tvS0WA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/474?usp=3Demail">View Change</a></p><div style=3D"white-space:pre-=
wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">test_user_pass: Check fatal errors for empty user=
name/password<br><br>Required a fix to mock_msg to make tests of M_FATAL<br=
>possible at all.<br>This also tests some cases which arguably should throw=
<br>a fatal error but do not.<br><br>v2:<br> - Suppress LeakSanitizer error=
s for fatal error tests.<br>   Due to aborting the function, the memory wil=
l not be<br>   cleaned up, but that is expected.<br>v3:<br> - Disable asser=
t tests with MSVC. Does not seem to catch<br>   the error correctly.<br> - =
Rebase on top of parallel-tests series to get<br>   AM_TESTS_ENVIRONMENT.<b=
r>v8:<br> - Update srcdir handling according to master.<br>v10:<br> - Updat=
e mock_msg.c fatal handling to be compatible<br>   with NO_CMOCKA.<br><br>C=
hange-Id: Icabc8acf75638c86c8c395e9ffecba7a7226cd97<br>Signed-off-by: Frank=
 Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1186...=
.1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/474<br>M=
essage-Id: &lt;20251010211154.2780-1-gert@...1296...&gt;<br>URL: https://so=
urceforge.net/p/openvpn/mailman/message/59245149/<br>Signed-off-by: Gert Do=
ering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M tests/unit_te=
sts/openvpn/Makefile.am<br>A tests/unit_tests/openvpn/input/appears_empty.t=
xt<br>A tests/unit_tests/openvpn/input/empty.txt<br>A tests/unit_tests/open=
vpn/input/leak_suppr.txt<br>M tests/unit_tests/openvpn/mock_msg.c<br>M test=
s/unit_tests/openvpn/test_user_pass.c<br>7 files changed, 112 insertions(+)=
, 3 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 9511b=
da..9e0b46e 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -729,7 +729,7 @@</span><br><span>     =
        add_test(${test_name} ${test_name})</span><br><span>             # =
for compat with autotools make check</span><br><span>             set_tests=
_properties(${test_name} PROPERTIES</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-                ENVIRONMENT &quot;srcdir=3D${_UT_SOURCE_DIR}&=
quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
   ENVIRONMENT &quot;srcdir=3D${_UT_SOURCE_DIR};LSAN_OPTIONS=3Dsuppressions=
=3D${_UT_SOURCE_DIR}/input/leak_suppr.txt&quot;)</span><br><span>         e=
ndif ()</span><br><span>         add_executable(${test_name}</span><br><spa=
n>             tests/unit_tests/openvpn/${test_name}.c</span><br><span>diff=
 --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Ma=
kefile.am</span><br><span>index 05c0ea5..50f4a11 100644</span><br><span>---=
 a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_te=
sts/openvpn/Makefile.am</span><br><span>@@ -4,6 +4,8 @@</span><br><span> </=
span><br><span> AM_TESTSUITE_SUMMARY_HEADER =3D &#39; for $(PACKAGE_STRING)=
 Unit-Tests&#39;</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+AM_TESTS_ENVIRONMENT =3D export LSAN_OPTIONS=3Dsuppressions=
=3D$(srcdir)/input/leak_suppr.txt;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> test_binaries =3D argv_testdriver buffer_t=
estdriver crypto_testdriver packet_id_testdriver auth_token_testdriver \</s=
pan><br><span> 	ncp_testdriver misc_testdriver options_parse_testdriver pkt=
_testdriver ssl_testdriver \</span><br><span> 	user_pass_testdriver push_up=
date_msg_testdriver provider_testdriver socket_testdriver</span><br><span>d=
iff --git a/tests/unit_tests/openvpn/input/appears_empty.txt b/tests/unit_t=
ests/openvpn/input/appears_empty.txt</span><br><span>new file mode 100644</=
span><br><span>index 0000000..ffb749a</span><br><span>--- /dev/null</span><=
br><span>+++ b/tests/unit_tests/openvpn/input/appears_empty.txt</span><br><=
span>@@ -0,0 +1,3 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+(contains \t\n\t\n)</span><br><span=
>diff --git a/tests/unit_tests/openvpn/input/empty.txt b/tests/unit_tests/o=
penvpn/input/empty.txt</span><br><span>new file mode 100644</span><br><span=
>index 0000000..e69de29</span><br><span>--- /dev/null</span><br><span>+++ b=
/tests/unit_tests/openvpn/input/empty.txt</span><br><span>diff --git a/test=
s/unit_tests/openvpn/input/leak_suppr.txt b/tests/unit_tests/openvpn/input/=
leak_suppr.txt</span><br><span>new file mode 100644</span><br><span>index 0=
000000..72ebfe0</span><br><span>--- /dev/null</span><br><span>+++ b/tests/u=
nit_tests/openvpn/input/leak_suppr.txt</span><br><span>@@ -0,0 +1 @@</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+leak:_assertions$</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests=
/openvpn/mock_msg.c</span><br><span>index a2aa3f9..2cd1336 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/mock_msg.c</span><br><span>+++ b/test=
s/unit_tests/openvpn/mock_msg.c</span><br><span>@@ -41,7 +41,6 @@</span><br=
><span> msglvl_t x_debug_level =3D 0; /* Default to (almost) no debugging o=
utput */</span><br><span> msglvl_t print_x_debug_level =3D 0;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-bool fatal_error_=
triggered =3D false;</span><br><span> </span><br><span> char mock_msg_buf[M=
OCK_MSG_BUF];</span><br><span> </span><br><span>@@ -75,7 +74,6 @@</span><br=
><span> {</span><br><span>     if (flags &amp; M_FATAL)</span><br><span>   =
  {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        fatal_erro=
r_triggered =3D true;</span><br><span>         printf(&quot;FATAL ERROR:&qu=
ot;);</span><br><span>     }</span><br><span>     CLEAR(mock_msg_buf);</spa=
n><br><span>@@ -86,6 +84,12 @@</span><br><span>         printf(&quot;%s&quo=
t;, mock_msg_buf);</span><br><span>         printf(&quot;\n&quot;);</span><=
br><span>     }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def NO_CMOCKA</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if=
 (flags &amp; M_FATAL)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        moc=
k_assert(false, &quot;FATAL ERROR&quot;, __FILE__, __LINE__);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span> }</span><br><span> </sp=
an><br><span> void</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>=
index 32ec59f..f5dddd6 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_user=
_pass.c</span><br><span>@@ -180,6 +180,16 @@</span><br><span> </span><br><s=
pan>     reset_user_pass(&amp;up);</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called eve=
n though nothing queued */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    will_return(query_user_exec_builtin, true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: silently removes control ch=
aracters but does not error out */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;\t\n\t&quot;=
, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equ=
al(up.password, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    rese=
t_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span>     expect_string(query_user_exec_builtin, query_user[i=
].prompt, &quot;Enter UT Password:&quot;);</span><br><span>     will_return=
(query_user_exec_builtin, &quot;cpassword&quot;);</span><br><span>     will=
_return(query_user_exec_builtin, true);</span><br><span>@@ -212,6 +222,25 @=
@</span><br><span>     assert_string_equal(up.password, &quot;cpassword&quo=
t;);</span><br><span> }</span><br><span> </span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+/* NOTE: expect_assert_failure does not seem to work =
with MSVC */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef=
 _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* NOTE: l=
eaks gc memory */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+st=
atic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_u=
ser_pass_inline_creds_assertions(void **state)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    struct user_pass up =3D { 0 };</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D GET_USER_PASS_=
INLINE_CREDS;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;=
up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() cal=
led even though nothing queued */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    /*FIXME? username error thrown very late in stdin handlin=
g */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return=
(query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    expect_assert_failure(get_user_pass_cr(&amp;up, &quot;\nip=
assword\n&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span> static void</span><br><span> test_get_user_pass_authfile_std=
in(void **state)</span><br><span> {</span><br><span>@@ -239,8 +268,39 @@</s=
pan><br><span>     assert_true(up.defined);</span><br><span>     assert_str=
ing_equal(up.username, &quot;user&quot;);</span><br><span>     assert_strin=
g_equal(up.password, &quot;cpassword&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_user[=
i].prompt, &quot;Enter UT Password:&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return=
(query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /*FIXME? does not error out on empty password */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass=
_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, flags, NULL));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal=
(up.username, &quot;user&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_string_equal(up.password, &quot;&quot;);</span><br>=
<span> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+/* NOTE: expect_assert_failure does not seem to work with MSVC */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef _MSC_VER</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+/* NOTE: leaks gc memory =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_authfi=
le_stdin_assertions(void **state)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
struct user_pass up =3D { 0 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    unsigned int flags =3D 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    expect_string(query_user_exec_builtin, query_user[i].prompt=
, &quot;Enter UT Username:&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    expect_string(query_user_exec_builtin, query_user[i].pro=
mpt, &quot;Enter UT Password:&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query=
_user_exec_builtin, &quot;cpassword&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_assert_failu=
re(get_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, flags, NULL=
));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span> static void</span><br><span> =
test_get_user_pass_authfile_file(void **state)</span><br><span> {</span><br=
><span>@@ -260,6 +320,17 @@</span><br><span> </span><br><span>     reset_us=
er_pass(&amp;up);</span><br><span> </span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, &quot;i=
nput/appears_empty.txt&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    /*FIXME: query_user_exec() called even though nothing queued=
 */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(=
query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    /*FIXME? does not error out */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, authfi=
le, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(up.password, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    re=
set_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span>     openvpn_test_get_srcdir_dir(authfile, PATH_MAX, &=
quot;input/user_only.txt&quot;);</span><br><span>     expect_string(query_u=
ser_exec_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);</s=
pan><br><span>     will_return(query_user_exec_builtin, &quot;cpassword&quo=
t;);</span><br><span>@@ -361,6 +432,29 @@</span><br><span> }</span><br><spa=
n> #endif /* ENABLE_MANAGEMENT */</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* NOTE: expect_assert_failure does not s=
eem to work with MSVC */</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#ifndef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/* NOTE: leaks gc memory */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+test_get_user_pass_authfile_file_assertions(void **state)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D 0=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    char authfile[PATH_MAX] =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    openvpn_test_get_srcdir_dir(authf=
ile, PATH_MAX, &quot;input/empty.txt&quot;);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    expect_assert_failure(get_user_pass_cr(&amp;up=
, authfile, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    f=
lags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, &quo=
t;input/empty.txt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    expect_assert_failure(get_user_pass_cr(&amp;up, authfile, &quot;U=
T&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif /* ifnd=
ef _MSC_VER */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> const struct CMUnitTest user_pass_tests[] =3D {</span><br><spa=
n>     cmocka_unit_test(test_get_user_pass_defined),</span><br><span>     c=
mocka_unit_test(test_get_user_pass_needok),</span><br><span>@@ -371,6 +465,=
11 @@</span><br><span>     cmocka_unit_test(test_get_user_pass_dynamic_chal=
lenge),</span><br><span>     cmocka_unit_test(test_get_user_pass_static_cha=
llenge),</span><br><span> #endif /* ENABLE_MANAGEMENT */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+#ifndef _MSC_VER</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_i=
nline_creds_assertions),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    cmocka_unit_test(test_get_user_pass_authfile_stdin_assertions),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(t=
est_get_user_pass_authfile_file_assertions),</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#endif</span><br><span> };</span><br><span> </span=
><br><span> int</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail">change 474</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope ite=
mtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action"=
 itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"h=
ttp://gerrit.openvpn.net/c/openvpn/+/474?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icabc8acf75638c86c8c395e9ffe=
cba7a7226cd97 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 474 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 14 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--s9Hb+tvS0WA=--

