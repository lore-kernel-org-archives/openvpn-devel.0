From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 18 Dec 2025 11:47:44 +0000
In-Reply-To: <gerrit.1765989193000.Ifb6594700db71d219643a29c581099c778bcbbc6@...2715...>
References: <gerrit.1765989193000.Ifb6594700db71d219643a29c581099c778bcbbc6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ad7c72cc8b8e4e596b7a1dbab948b93ac121fc3a-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mIsfIG1/eWU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests/unit_tests:
 Port to cmocka 2.0.0 API
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

--mIsfIG1/eWU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1449?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: tests/unit_tests: Port to cmocka 2.0.0 API
......................................................................

tests/unit_tests: Port to cmocka 2.0.0 API

But add compat layer so that we can still build
against older versions of cmocka. Mostly this is
trivial but the custom check function changed its
prototype, so that requires some more work.

Change-Id: Ifb6594700db71d219643a29c581099c778bcbbc6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1449
Message-Id: <20251218104042.5961-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
144.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M tests/unit_tests/openvpn/test_common.h
M tests/unit_tests/openvpn/test_options_parse.c
M tests/unit_tests/openvpn/test_push_update_msg.c
M tests/unit_tests/openvpn/test_user_pass.c
7 files changed, 79 insertions(+), 46 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1449/4

diff --git a/CMakeLists.txt b/CMakeLists.txt
index bdb1904..bdad173 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -379,6 +379,18 @@
     )
 set(HAVE_CONFIG_VERSION_H YES)

+if (BUILD_TESTING)
+    find_package(cmocka CONFIG)
+    if (TARGET cmocka::cmocka)
+        set(CMOCKA_LIBRARIES cmocka::cmocka)
+    else ()
+        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
+        set(CMOCKA_LIBRARIES PkgConfig::cmocka)
+    endif ()
+    set(CMAKE_REQUIRED_LIBRARIES ${CMOCKA_LIBRARIES})
+    check_include_files(cmocka_version.h HAVE_CMOCKA_VERSION_H)
+endif ()
+
 configure_file(config.h.cmake.in config.h)
 configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
 # TODO we should remove the need for this, and always include config.h
@@ -636,14 +648,6 @@
 option(UT_ALLOW_BIG_ALLOC "Allow unit-tests to use > 1 GB of memory" ON)

 if (BUILD_TESTING)
-    find_package(cmocka CONFIG)
-    if (TARGET cmocka::cmocka)
-        set(CMOCKA_LIBRARIES cmocka::cmocka)
-    else ()
-        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)
-        set(CMOCKA_LIBRARIES PkgConfig::cmocka)
-    endif ()
-
     set(unit_tests
         "test_argv"
         "test_auth_token"
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 53c3598..01bbadc 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -86,6 +86,9 @@
 /* git version information in config-version.h */
 #cmakedefine HAVE_CONFIG_VERSION_H

+/* cmocka version information available in cmocka_version.h (>=3D 2.0.0) */
+#cmakedefine HAVE_CMOCKA_VERSION_H
+
 /* Define to 1 if you have the `daemon' function. */
 #cmakedefine HAVE_DAEMON

diff --git a/configure.ac b/configure.ac
index d5a0c70..f363e0f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1415,7 +1415,16 @@
 	[have_cmocka=3D"yes"],
 	[AC_MSG_WARN([cmocka.pc not found on the system using pkg-config ${pkg_co=
nfig_found}.  Unit tests disabled])]
 )
-AM_CONDITIONAL([ENABLE_UNITTESTS], [test "${enable_unit_tests}" =3D "yes" =
-a "${have_cmocka}" =3D "yes" ])
+AM_CONDITIONAL([ENABLE_UNITTESTS], [false])
+if test "${enable_unit_tests}" =3D "yes" -a "${have_cmocka}" =3D "yes"; th=
en
+   AM_CONDITIONAL([ENABLE_UNITTESTS], [true])
+
+   saved_CFLAGS=3D"${CFLAGS}"
+   CFLAGS=3D"${CFLAGS} ${CMOCKA_CFLAGS}"
+   # detect cmocka < 2.0.0 that had no cmocka_version.h
+   AC_CHECK_HEADERS([cmocka_version.h])
+   CFLAGS=3D"${saved_CFLAGS}"
+fi
 AC_SUBST([ENABLE_UNITTESTS])

 TEST_LDFLAGS=3D"${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS} ${O=
PTIONAL_LIBCAPNG_LIBS}"
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/open=
vpn/test_common.h
index da98531..3a0598d 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -24,6 +24,27 @@
 #include <setjmp.h>
 #include <cmocka.h>

+/* Do we use cmocka < 2.0.0? */
+#ifndef HAVE_CMOCKA_VERSION_H
+#define HAVE_OLD_CMOCKA_API 1
+/* compat with various versions of cmocka.h
+ * Older versions have LargestIntegralType. Newer
+ * versions use uintmax_t. But LargestIntegralType
+ * is not guaranteed to be equal to uintmax_t, so
+ * we can't use that unconditionally. So we only use
+ * it if cmocka.h does not define LargestIntegralType.
+ */
+#ifndef LargestIntegralType
+#define LargestIntegralType uintmax_t
+#endif
+/* redefine 2.x API in terms of 1.x API */
+#define CMockaValueData             LargestIntegralType
+#define check_expected_uint         check_expected
+#define expect_uint_value           expect_value
+#define expect_check_data           expect_check
+#define cast_ptr_to_cmocka_value(x) (x)
+#endif
+
 /**
  * Sets up the environment for unit tests like making both stderr and stdo=
ut
  * non-buffered to avoid messages getting lost if the program exits early.
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tes=
ts/openvpn/test_options_parse.c
index adf3e5b..5af84f5 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -44,8 +44,8 @@
            struct env_set *es)
 {
     function_called();
-    check_expected(p);
-    check_expected(is_inline);
+    check_expected_ptr(p);
+    check_expected_uint(is_inline);
 }

 void
@@ -198,31 +198,27 @@
                        &option_types_found, &es);
 }

-/* compat with various versions of cmocka.h
- * Older versions have LargestIntegralType. Newer
- * versions use uintmax_t. But LargestIntegralType
- * is not guaranteed to be equal to uintmax_t, so
- * we can't use that unconditionally. So we only use
- * it if cmocka.h does not define LargestIntegralType.
- */
-#ifndef LargestIntegralType
-#define LargestIntegralType uintmax_t
+#if HAVE_OLD_CMOCKA_API
+union token_parameter
+{
+    LargestIntegralType int_val;
+    void *ptr;
+};
 #endif

-union tokens_parameter
-{
-    LargestIntegralType as_int;
-    void *as_pointer;
-};
-
 static int
-check_tokens(const LargestIntegralType value, const LargestIntegralType ex=
pected)
+check_tokens(const CMockaValueData value, const CMockaValueData expected)
 {
-    union tokens_parameter temp;
-    temp.as_int =3D value;
-    const char **p =3D (const char **)temp.as_pointer;
-    temp.as_int =3D expected;
-    const char **expected_p =3D (const char **)temp.as_pointer;
+#if HAVE_OLD_CMOCKA_API
+    union token_parameter temp;
+    temp.int_val =3D value;
+    const char **p =3D (const char **)temp.ptr;
+    temp.int_val =3D expected;
+    const char **expected_p =3D (const char **)temp.ptr;
+#else
+    const char **p =3D (const char **)value.ptr;
+    const char **expected_p =3D (const char **)expected.ptr;
+#endif
     for (int i =3D 0; i < MAX_PARMS; i++)
     {
         if (!p[i] && !expected_p[i])
@@ -271,33 +267,33 @@

     /* basic test */
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_someopt);
-    expect_value(add_option, is_inline, 0);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_valu=
e(p_expect_someopt));
+    expect_uint_value(add_option, is_inline, 0);
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_otheropt);
-    expect_value(add_option, is_inline, 0);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_valu=
e(p_expect_otheropt));
+    expect_uint_value(add_option, is_inline, 0);
     read_single_config(&o, "someopt parm1 parm2\n  otheropt 1 2");

     /* -- gets stripped */
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_someopt);
-    expect_value(add_option, is_inline, 0);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_valu=
e(p_expect_someopt));
+    expect_uint_value(add_option, is_inline, 0);
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_otheropt);
-    expect_value(add_option, is_inline, 0);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_valu=
e(p_expect_otheropt));
+    expect_uint_value(add_option, is_inline, 0);
     read_single_config(&o, "someopt parm1 parm2\n\t--otheropt 1 2");

     /* inline options */
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_inlineopt);
-    expect_value(add_option, is_inline, 1);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_valu=
e(p_expect_inlineopt));
+    expect_uint_value(add_option, is_inline, 1);
     read_single_config(&o, "<inlineopt>\nsome text\nother text\n</inlineop=
t>");

     p_expect_inlineopt[0] =3D "inlineopt";
     p_expect_inlineopt[1] =3D A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_=
256 A_TIMES_256 "\n";
     expect_function_call(add_option);
-    expect_check(add_option, p, check_tokens, p_expect_inlineopt);
-    expect_value(add_option, is_inline, 1);
+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_valu=
e(p_expect_inlineopt));
+    expect_uint_value(add_option, is_inline, 1);
     read_single_config(&o, "<inlineopt>\n" A_TIMES_256 A_TIMES_256 A_TIMES=
_256 A_TIMES_256 A_TIMES_256 "\n</inlineopt>");

     gc_free(&o.gc);
diff --git a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_t=
ests/openvpn/test_push_update_msg.c
index 5c16001..9b7978e 100644
--- a/tests/unit_tests/openvpn/test_push_update_msg.c
+++ b/tests/unit_tests/openvpn/test_push_update_msg.c
@@ -171,7 +171,7 @@
 bool
 send_control_channel_string(struct context *c, const char *str, msglvl_t m=
sglevel)
 {
-    check_expected(str);
+    check_expected_ptr(str);
     return true;
 }

diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index abe223c..a109201 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -52,7 +52,7 @@
     /* Loop through configured query_user slots */
     for (int i =3D 0; i < QUERY_USER_NUMSLOTS && query_user[i].response !=
=3D NULL; i++)
     {
-        check_expected(query_user[i].prompt);
+        check_expected_ptr(query_user[i].prompt);
         strncpy(query_user[i].response, mock_ptr_type(char *), query_user[=
i].response_len);
     }


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1449?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifb6594700db71d219643a29c581099c778bcbbc6
Gerrit-Change-Number: 1449
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mIsfIG1/eWU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1449?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">tests/unit_tests: Port to cmocka 2.=
0.0 API<br><br>But add compat layer so that we can still build<br>against o=
lder versions of cmocka. Mostly this is<br>trivial but the custom check fun=
ction changed its<br>prototype, so that requires some more work.<br><br>Cha=
nge-Id: Ifb6594700db71d219643a29c581099c778bcbbc6<br>Signed-off-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1386...=
296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1449<br>Me=
ssage-Id: &lt;20251218104042.5961-1-gert@...1296...&gt;<br>URL: https://www=
.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35144.html<br>Sign=
ed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<=
br>M config.h.cmake.in<br>M configure.ac<br>M tests/unit_tests/openvpn/test=
_common.h<br>M tests/unit_tests/openvpn/test_options_parse.c<br>M tests/uni=
t_tests/openvpn/test_push_update_msg.c<br>M tests/unit_tests/openvpn/test_u=
ser_pass.c<br>7 files changed, 79 insertions(+), 46 deletions(-)<br><br></p=
re><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/49/1449/4</pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br=
><span>index bdb1904..bdad173 100644</span><br><span>--- a/CMakeLists.txt</=
span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -379,6 +379,18 @@</s=
pan><br><span>     )</span><br><span> set(HAVE_CONFIG_VERSION_H YES)</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+if (BUIL=
D_TESTING)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    find_=
package(cmocka CONFIG)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    if (TARGET cmocka::cmocka)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        set(CMOCKA_LIBRARIES cmocka::cmocka)</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    else ()</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        pkg_search_module(cmocka cmocka REQU=
IRED IMPORTED_TARGET)</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        set(CMOCKA_LIBRARIES PkgConfig::cmocka)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    endif ()</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    set(CMAKE_REQUIRED_LIBRARIES ${CMOCKA_LIBRARIES}=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_include_=
files(cmocka_version.h HAVE_CMOCKA_VERSION_H)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+endif ()</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> configure_file(config.h.cmake.in config.h)=
</span><br><span> configure_file(include/openvpn-plugin.h.in openvpn-plugin=
.h)</span><br><span> # TODO we should remove the need for this, and always =
include config.h</span><br><span>@@ -636,14 +648,6 @@</span><br><span> opti=
on(UT_ALLOW_BIG_ALLOC &quot;Allow unit-tests to use &gt; 1 GB of memory&quo=
t; ON)</span><br><span> </span><br><span> if (BUILD_TESTING)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    find_package(cmocka CONFIG)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    if (TARGET cmocka::cmo=
cka)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        set(CMOCK=
A_LIBRARIES cmocka::cmocka)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    else ()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
    pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-        set(CMOCKA_LIBRARIES PkgCon=
fig::cmocka)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    endif=
 ()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
    set(unit_tests</span><br><span>         &quot;test_argv&quot;</span><br=
><span>         &quot;test_auth_token&quot;</span><br><span>diff --git a/co=
nfig.h.cmake.in b/config.h.cmake.in</span><br><span>index 53c3598..01bbadc =
100644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/config=
.h.cmake.in</span><br><span>@@ -86,6 +86,9 @@</span><br><span> /* git versi=
on information in config-version.h */</span><br><span> #cmakedefine HAVE_CO=
NFIG_VERSION_H</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+/* cmocka version information available in cmocka_version.h (&=
gt;=3D 2.0.0) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#cm=
akedefine HAVE_CMOCKA_VERSION_H</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span> /* Define to 1 if you have the `daemon&#39; f=
unction. */</span><br><span> #cmakedefine HAVE_DAEMON</span><br><span> </sp=
an><br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index=
 d5a0c70..f363e0f 100644</span><br><span>--- a/configure.ac</span><br><span=
>+++ b/configure.ac</span><br><span>@@ -1415,7 +1415,16 @@</span><br><span>=
 	[have_cmocka=3D&quot;yes&quot;],</span><br><span> 	[AC_MSG_WARN([cmocka.p=
c not found on the system using pkg-config ${pkg_config_found}.  Unit tests=
 disabled])]</span><br><span> )</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-AM_CONDITIONAL([ENABLE_UNITTESTS], [test &quot;${enable_unit_test=
s}&quot; =3D &quot;yes&quot; -a &quot;${have_cmocka}&quot; =3D &quot;yes&qu=
ot; ])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_CONDITIONA=
L([ENABLE_UNITTESTS], [false])</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+if test &quot;${enable_unit_tests}&quot; =3D &quot;yes&quot; -a =
&quot;${have_cmocka}&quot; =3D &quot;yes&quot;; then</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   AM_CONDITIONAL([ENABLE_UNITTESTS], [tr=
ue])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+   saved_CFLAGS=3D&quot;${CFLAGS}&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   CFLAGS=3D&q=
uot;${CFLAGS} ${CMOCKA_CFLAGS}&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+   # detect cmocka &lt; 2.0.0 that had no cmocka_version.h=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   AC_CHECK_HEADERS=
([cmocka_version.h])</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+   CFLAGS=3D&quot;${saved_CFLAGS}&quot;</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+fi</span><br><span> AC_SUBST([ENABLE_UNITTESTS])</span=
><br><span> </span><br><span> TEST_LDFLAGS=3D&quot;${OPTIONAL_CRYPTO_LIBS} =
${OPTIONAL_PKCS11_HELPER_LIBS} ${OPTIONAL_LIBCAPNG_LIBS}&quot;</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/=
openvpn/test_common.h</span><br><span>index da98531..3a0598d 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/test_common.h</span><br><span>+++ b=
/tests/unit_tests/openvpn/test_common.h</span><br><span>@@ -24,6 +24,27 @@<=
/span><br><span> #include &lt;setjmp.h&gt;</span><br><span> #include &lt;cm=
ocka.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* Do we use cmocka &lt; 2.0.0? */</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifndef HAVE_CMOCKA_VERSION_H</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define HAVE_OLD_CMOCKA_API 1</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+/* compat with various versions=
 of cmocka.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Olde=
r versions have LargestIntegralType. Newer</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ * versions use uintmax_t. But LargestIntegralType</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * is not guaranteed =
to be equal to uintmax_t, so</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * we can&#39;t use that unconditionally. So we only use</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * it if cmocka.h does not de=
fine LargestIntegralType.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef La=
rgestIntegralType</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#d=
efine LargestIntegralType uintmax_t</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+/* redefine 2.x API in terms of 1.x API */</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define CMockaValueData             LargestIntegr=
alType</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define check=
_expected_uint         check_expected</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#define expect_uint_value           expect_value</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define expect_check_data   =
        expect_check</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#define cast_ptr_to_cmocka_value(x) (x)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span> /**</span><br><span>  * Sets up the environment f=
or unit tests like making both stderr and stdout</span><br><span>  * non-bu=
ffered to avoid messages getting lost if the program exits early.</span><br=
><span>diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/u=
nit_tests/openvpn/test_options_parse.c</span><br><span>index adf3e5b..5af84=
f5 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_options_parse=
.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_options_parse.c</spa=
n><br><span>@@ -44,8 +44,8 @@</span><br><span>            struct env_set *e=
s)</span><br><span> {</span><br><span>     function_called();</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    check_expected(p);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    check_expected(is_inline);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_expected_ptr(=
p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_expect=
ed_uint(is_inline);</span><br><span> }</span><br><span> </span><br><span> v=
oid</span><br><span>@@ -198,31 +198,27 @@</span><br><span>                 =
       &amp;option_types_found, &amp;es);</span><br><span> }</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* compat with var=
ious versions of cmocka.h</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">- * Older versions have LargestIntegralType. Newer</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">- * versions use uintmax_t. But LargestInteg=
ralType</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * is not guar=
anteed to be equal to uintmax_t, so</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * we can&#39;t use that unconditionally. So we only use</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">- * it if cmocka.h does not=
 define LargestIntegralType.</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef Lar=
gestIntegralType</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne LargestIntegralType uintmax_t</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#if HAVE_OLD_CMOCKA_API</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+union token_parameter</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    LargestIntegralType int_val;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    void *ptr;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+};</span><br><span> #endif</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-union tokens_parameter</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    LargestIntegralType as_int;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    void *as_pointer;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-};</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span> static int</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-check_tokens(const LargestIntegralType value, const LargestInteg=
ralType expected)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ch=
eck_tokens(const CMockaValueData value, const CMockaValueData expected)</sp=
an><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    un=
ion tokens_parameter temp;</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-    temp.as_int =3D value;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-    const char **p =3D (const char **)temp.as_pointer;</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    temp.as_int =3D expected;</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char **expecte=
d_p =3D (const char **)temp.as_pointer;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#if HAVE_OLD_CMOCKA_API</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    union token_parameter temp;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    temp.int_val =3D value;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    const char **p =3D (const c=
har **)temp.ptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 temp.int_val =3D expected;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    const char **expected_p =3D (const char **)temp.ptr;</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    const char **p =3D (const char **)value.=
ptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
**expected_p =3D (const char **)expected.ptr;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#endif</span><br><span>     for (int i =3D 0; i &=
lt; MAX_PARMS; i++)</span><br><span>     {</span><br><span>         if (!p[=
i] &amp;&amp; !expected_p[i])</span><br><span>@@ -271,33 +267,33 @@</span><=
br><span> </span><br><span>     /* basic test */</span><br><span>     expec=
t_function_call(add_option);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    expect_check(add_option, p, check_tokens, p_expect_someopt);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_value(add_opti=
on, is_inline, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value(=
p_expect_someopt));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    expect_uint_value(add_option, is_inline, 0);</span><br><span>     expec=
t_function_call(add_option);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    expect_check(add_option, p, check_tokens, p_expect_otheropt);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_value(add_opt=
ion, is_inline, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value=
(p_expect_otheropt));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    expect_uint_value(add_option, is_inline, 0);</span><br><span>     rea=
d_single_config(&amp;o, &quot;someopt parm1 parm2\n  otheropt 1 2&quot;);</=
span><br><span> </span><br><span>     /* -- gets stripped */</span><br><spa=
n>     expect_function_call(add_option);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    expect_check(add_option, p, check_tokens, p_expect_s=
omeopt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_va=
lue(add_option, is_inline, 0);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_c=
mocka_value(p_expect_someopt));</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    expect_uint_value(add_option, is_inline, 0);</span><br><spa=
n>     expect_function_call(add_option);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-    expect_check(add_option, p, check_tokens, p_expect_o=
theropt);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_v=
alue(add_option, is_inline, 0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    expect_check_data(add_option, p, check_tokens, cast_ptr_to_=
cmocka_value(p_expect_otheropt));</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    expect_uint_value(add_option, is_inline, 0);</span><br><s=
pan>     read_single_config(&amp;o, &quot;someopt parm1 parm2\n\t--otheropt=
 1 2&quot;);</span><br><span> </span><br><span>     /* inline options */</s=
pan><br><span>     expect_function_call(add_option);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    expect_check(add_option, p, check_token=
s, p_expect_inlineopt);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    expect_value(add_option, is_inline, 1);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    expect_check_data(add_option, p, check_tokens=
, cast_ptr_to_cmocka_value(p_expect_inlineopt));</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    expect_uint_value(add_option, is_inline, 1=
);</span><br><span>     read_single_config(&amp;o, &quot;&lt;inlineopt&gt;\=
nsome text\nother text\n&lt;/inlineopt&gt;&quot;);</span><br><span> </span>=
<br><span>     p_expect_inlineopt[0] =3D &quot;inlineopt&quot;;</span><br><=
span>     p_expect_inlineopt[1] =3D A_TIMES_256 A_TIMES_256 A_TIMES_256 A_T=
IMES_256 A_TIMES_256 &quot;\n&quot;;</span><br><span>     expect_function_c=
all(add_option);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    e=
xpect_check(add_option, p, check_tokens, p_expect_inlineopt);</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    expect_value(add_option, is_inl=
ine, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_=
check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_i=
nlineopt));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expe=
ct_uint_value(add_option, is_inline, 1);</span><br><span>     read_single_c=
onfig(&amp;o, &quot;&lt;inlineopt&gt;\n&quot; A_TIMES_256 A_TIMES_256 A_TIM=
ES_256 A_TIMES_256 A_TIMES_256 &quot;\n&lt;/inlineopt&gt;&quot;);</span><br=
><span> </span><br><span>     gc_free(&amp;o.gc);</span><br><span>diff --gi=
t a/tests/unit_tests/openvpn/test_push_update_msg.c b/tests/unit_tests/open=
vpn/test_push_update_msg.c</span><br><span>index 5c16001..9b7978e 100644</s=
pan><br><span>--- a/tests/unit_tests/openvpn/test_push_update_msg.c</span><=
br><span>+++ b/tests/unit_tests/openvpn/test_push_update_msg.c</span><br><s=
pan>@@ -171,7 +171,7 @@</span><br><span> bool</span><br><span> send_control=
_channel_string(struct context *c, const char *str, msglvl_t msglevel)</spa=
n><br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    che=
ck_expected(str);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  check_expected_ptr(str);</span><br><span>     return true;</span><br><spa=
n> }</span><br><span> </span><br><span>diff --git a/tests/unit_tests/openvp=
n/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><s=
pan>index abe223c..a109201 100644</span><br><span>--- a/tests/unit_tests/op=
envpn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_=
user_pass.c</span><br><span>@@ -52,7 +52,7 @@</span><br><span>     /* Loop =
through configured query_user slots */</span><br><span>     for (int i =3D =
0; i &lt; QUERY_USER_NUMSLOTS &amp;&amp; query_user[i].response !=3D NULL; =
i++)</span><br><span>     {</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        check_expected(query_user[i].prompt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        check_expected_ptr(query_user[i].=
prompt);</span><br><span>         strncpy(query_user[i].response, mock_ptr_=
type(char *), query_user[i].response_len);</span><br><span>     }</span><br=
><span> </span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1449?usp=3Demail">change 1449</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1449?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifb6594700db71d219643a29c581=
099c778bcbbc6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1449 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--mIsfIG1/eWU=--

