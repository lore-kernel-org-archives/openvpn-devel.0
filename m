From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 17 Dec 2025 16:41:25 +0000
In-Reply-To: <gerrit.1765989193000.Ifb6594700db71d219643a29c581099c778bcbbc6@...2715...>
References: <gerrit.1765989193000.Ifb6594700db71d219643a29c581099c778bcbbc6@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <bb61cf10649886e3c92c8df3bf7ccc1edbceb2ec-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="A5XHXiArITo="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--A5XHXiArITo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1449?usp=3Demail

to look at the new patch set (#2).


Change subject: tests/unit_tests: Port to cmocka 2.0.0 API
......................................................................

tests/unit_tests: Port to cmocka 2.0.0 API

But add compat layer so that we can still build
against older versions of cmocka. Mostly this is
trivial but the custom check function changed its
prototype, so that requires some more work.

Change-Id: Ifb6594700db71d219643a29c581099c778bcbbc6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M tests/unit_tests/openvpn/test_common.h
M tests/unit_tests/openvpn/test_options_parse.c
M tests/unit_tests/openvpn/test_push_update_msg.c
M tests/unit_tests/openvpn/test_user_pass.c
7 files changed, 79 insertions(+), 46 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1449/2

diff --git a/CMakeLists.txt b/CMakeLists.txt
index bdb1904..fc5eaf1 100644
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
index d5a0c70..ef7d305 100644
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
+   CFLAGS=3D"${CFLAGS} ${LZO_CFLAGS}"
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
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--A5XHXiArITo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1449?usp=3Demail">View C=
hange</a></p><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tests/unit_tests: Port to cmocka 2.0.0 API<br><b=
r>But add compat layer so that we can still build<br>against older versions=
 of cmocka. Mostly this is<br>trivial but the custom check function changed=
 its<br>prototype, so that requires some more work.<br><br>Change-Id: Ifb65=
94700db71d219643a29c581099c778bcbbc6<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.cmake.in<br=
>M configure.ac<br>M tests/unit_tests/openvpn/test_common.h<br>M tests/unit=
_tests/openvpn/test_options_parse.c<br>M tests/unit_tests/openvpn/test_push=
_update_msg.c<br>M tests/unit_tests/openvpn/test_user_pass.c<br>7 files cha=
nged, 79 insertions(+), 46 deletions(-)<br><br></pre><pre class=3D"blocks" =
style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pull=
 ssh://gerrit.openvpn.net:29418/openvpn refs/changes/49/1449/2</pre><pre st=
yle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>diff=
 --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index bdb1904..fc5=
eaf1 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMak=
eLists.txt</span><br><span>@@ -379,6 +379,18 @@</span><br><span>     )</spa=
n><br><span> set(HAVE_CONFIG_VERSION_H YES)</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+if (BUILD_TESTING)</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    find_package(cmocka CONFIG)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (TARGET cmocka:=
:cmocka)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set=
(CMOCKA_LIBRARIES cmocka::cmocka)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    else ()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TARGET)</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        set(CMOCKA_LIBR=
ARIES PkgConfig::cmocka)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  set(CMAKE_REQUIRED_LIBRARIES ${CMOCKA_LIBRARIES}) </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    check_include_files(cmocka_version.h =
HAVE_CMOCKA_VERSION_H)</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> configure_file(config.h.cmake.in config.h)</span><br><span> confi=
gure_file(include/openvpn-plugin.h.in openvpn-plugin.h)</span><br><span> # =
TODO we should remove the need for this, and always include config.h</span>=
<br><span>@@ -636,14 +648,6 @@</span><br><span> option(UT_ALLOW_BIG_ALLOC &=
quot;Allow unit-tests to use &gt; 1 GB of memory&quot; ON)</span><br><span>=
 </span><br><span> if (BUILD_TESTING)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-    find_package(cmocka CONFIG)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    if (TARGET cmocka::cmocka)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-        set(CMOCKA_LIBRARIES cmocka::cmo=
cka)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else ()</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-        pkg_search_module(c=
mocka cmocka REQUIRED IMPORTED_TARGET)</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-        set(CMOCKA_LIBRARIES PkgConfig::cmocka)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    endif ()</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     set(unit_tests</spa=
n><br><span>         &quot;test_argv&quot;</span><br><span>         &quot;t=
est_auth_token&quot;</span><br><span>diff --git a/config.h.cmake.in b/confi=
g.h.cmake.in</span><br><span>index 53c3598..01bbadc 100644</span><br><span>=
--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><=
span>@@ -86,6 +86,9 @@</span><br><span> /* git version information in confi=
g-version.h */</span><br><span> #cmakedefine HAVE_CONFIG_VERSION_H</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* cmocka =
version information available in cmocka_version.h (&gt;=3D 2.0.0) */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_CMOCKA_V=
ERSION_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /* Define to 1 if you have the `daemon&#39; function. */</span><br><=
span> #cmakedefine HAVE_DAEMON</span><br><span> </span><br><span>diff --git=
 a/configure.ac b/configure.ac</span><br><span>index d5a0c70..ef7d305 10064=
4</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</sp=
an><br><span>@@ -1415,7 +1415,16 @@</span><br><span> 	[have_cmocka=3D&quot;=
yes&quot;],</span><br><span> 	[AC_MSG_WARN([cmocka.pc not found on the syst=
em using pkg-config ${pkg_config_found}.  Unit tests disabled])]</span><br>=
<span> )</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AM_CONDITIONA=
L([ENABLE_UNITTESTS], [test &quot;${enable_unit_tests}&quot; =3D &quot;yes&=
quot; -a &quot;${have_cmocka}&quot; =3D &quot;yes&quot; ])</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+AM_CONDITIONAL([ENABLE_UNITTESTS], [=
false])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test &quo=
t;${enable_unit_tests}&quot; =3D &quot;yes&quot; -a &quot;${have_cmocka}&qu=
ot; =3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+   AM_CONDITIONAL([ENABLE_UNITTESTS], [true])</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+   saved_CFLAGS=3D&quot;${CFLAGS}&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+   CFLAGS=3D&quot;${CFLAGS} ${LZO_CFLA=
GS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   # detec=
t cmocka &lt; 2.0.0 that had no cmocka_version.h</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+   AC_CHECK_HEADERS([cmocka_version.h])</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+   CFLAGS=3D&quot;${saved_=
CFLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</sp=
an><br><span> AC_SUBST([ENABLE_UNITTESTS])</span><br><span> </span><br><spa=
n> TEST_LDFLAGS=3D&quot;${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LI=
BS} ${OPTIONAL_LIBCAPNG_LIBS}&quot;</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_common.h b/tests/unit_tests/openvpn/test_common.h</span=
><br><span>index da98531..3a0598d 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/test_common.h</span><br><span>+++ b/tests/unit_tests/openvpn/t=
est_common.h</span><br><span>@@ -24,6 +24,27 @@</span><br><span> #include &=
lt;setjmp.h&gt;</span><br><span> #include &lt;cmocka.h&gt;</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* Do we use cmock=
a &lt; 2.0.0? */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if=
ndef HAVE_CMOCKA_VERSION_H</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+#define HAVE_OLD_CMOCKA_API 1</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+/* compat with various versions of cmocka.h</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ * Older versions have LargestInte=
gralType. Newer</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * v=
ersions use uintmax_t. But LargestIntegralType</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ * is not guaranteed to be equal to uintmax_t, s=
o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * we can&#39;t us=
e that unconditionally. So we only use</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * it if cmocka.h does not define LargestIntegralType.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifndef LargestIntegralType</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define LargestIntegralType u=
intmax_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+/* redefine 2.x API in t=
erms of 1.x API */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
define CMockaValueData             LargestIntegralType</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define check_expected_uint         chec=
k_expected</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define e=
xpect_uint_value           expect_value</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#define expect_check_data           expect_check</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#define cast_ptr_to_cmocka=
_value(x) (x)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /=
**</span><br><span>  * Sets up the environment for unit tests like making b=
oth stderr and stdout</span><br><span>  * non-buffered to avoid messages ge=
tting lost if the program exits early.</span><br><span>diff --git a/tests/u=
nit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openvpn/test_opti=
ons_parse.c</span><br><span>index adf3e5b..5af84f5 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/test_options_parse.c</span><br><span>+++ b/te=
sts/unit_tests/openvpn/test_options_parse.c</span><br><span>@@ -44,8 +44,8 =
@@</span><br><span>            struct env_set *es)</span><br><span> {</span=
><br><span>     function_called();</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    check_expected(p);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    check_expected(is_inline);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    check_expected_ptr(p);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    check_expected_uint(is_inline);</span=
><br><span> }</span><br><span> </span><br><span> void</span><br><span>@@ -1=
98,31 +198,27 @@</span><br><span>                        &amp;option_types_=
found, &amp;es);</span><br><span> }</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* compat with various versions of cmocka.h=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Older versions hav=
e LargestIntegralType. Newer</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">- * versions use uintmax_t. But LargestIntegralType</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">- * is not guaranteed to be equal to uin=
tmax_t, so</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * we can&#=
39;t use that unconditionally. So we only use</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">- * it if cmocka.h does not define LargestIntegralTy=
pe.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#ifndef LargestIntegralType</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define LargestIntegralType ui=
ntmax_t</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if HAVE_OLD=
_CMOCKA_API</span><br><span style=3D"color: hsl(120, 100%, 40%);">+union to=
ken_parameter</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    LargestIntegralType =
int_val;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    void *p=
tr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><sp=
an> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-union tokens_parameter</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    LargestI=
ntegralType as_int;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
  void *as_pointer;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-};=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> sta=
tic int</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_tokens(c=
onst LargestIntegralType value, const LargestIntegralType expected)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+check_tokens(const CMockaVa=
lueData value, const CMockaValueData expected)</span><br><span> {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    union tokens_parameter temp=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    temp.as_int =3D =
value;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    const char =
**p =3D (const char **)temp.as_pointer;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-    temp.as_int =3D expected;</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    const char **expected_p =3D (const char **)te=
mp.as_pointer;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if H=
AVE_OLD_CMOCKA_API</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   union token_parameter temp;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    temp.int_val =3D value;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    const char **p =3D (const char **)temp.ptr;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    temp.int_val =3D expecte=
d;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char **=
expected_p =3D (const char **)temp.ptr;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    const char **p =3D (const char **)value.ptr;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    const char **expected_p =3D (const c=
har **)expected.ptr;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#endif</span><br><span>     for (int i =3D 0; i &lt; MAX_PARMS; i++)</span=
><br><span>     {</span><br><span>         if (!p[i] &amp;&amp; !expected_p=
[i])</span><br><span>@@ -271,33 +267,33 @@</span><br><span> </span><br><spa=
n>     /* basic test */</span><br><span>     expect_function_call(add_optio=
n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_check(a=
dd_option, p, check_tokens, p_expect_someopt);</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-    expect_value(add_option, is_inline, 0);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_check_data(add_=
option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_someopt));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_uint_value(add=
_option, is_inline, 0);</span><br><span>     expect_function_call(add_optio=
n);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_check(a=
dd_option, p, check_tokens, p_expect_otheropt);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    expect_value(add_option, is_inline, 0);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_check_data(add=
_option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_otheropt));</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_uint_value(a=
dd_option, is_inline, 0);</span><br><span>     read_single_config(&amp;o, &=
quot;someopt parm1 parm2\n  otheropt 1 2&quot;);</span><br><span> </span><b=
r><span>     /* -- gets stripped */</span><br><span>     expect_function_ca=
ll(add_option);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ex=
pect_check(add_option, p, check_tokens, p_expect_someopt);</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    expect_value(add_option, is_inline=
, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_che=
ck_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_some=
opt));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_ui=
nt_value(add_option, is_inline, 0);</span><br><span>     expect_function_ca=
ll(add_option);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    ex=
pect_check(add_option, p, check_tokens, p_expect_otheropt);</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    expect_value(add_option, is_inlin=
e, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_ch=
eck_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value(p_expect_oth=
eropt));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_=
uint_value(add_option, is_inline, 0);</span><br><span>     read_single_conf=
ig(&amp;o, &quot;someopt parm1 parm2\n\t--otheropt 1 2&quot;);</span><br><s=
pan> </span><br><span>     /* inline options */</span><br><span>     expect=
_function_call(add_option);</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    expect_check(add_option, p, check_tokens, p_expect_inlineopt);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_value(add_opt=
ion, is_inline, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    expect_check_data(add_option, p, check_tokens, cast_ptr_to_cmocka_value=
(p_expect_inlineopt));</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    expect_uint_value(add_option, is_inline, 1);</span><br><span>     re=
ad_single_config(&amp;o, &quot;&lt;inlineopt&gt;\nsome text\nother text\n&l=
t;/inlineopt&gt;&quot;);</span><br><span> </span><br><span>     p_expect_in=
lineopt[0] =3D &quot;inlineopt&quot;;</span><br><span>     p_expect_inlineo=
pt[1] =3D A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 &quot=
;\n&quot;;</span><br><span>     expect_function_call(add_option);</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    expect_check(add_option, p,=
 check_tokens, p_expect_inlineopt);</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    expect_value(add_option, is_inline, 1);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    expect_check_data(add_option, p, =
check_tokens, cast_ptr_to_cmocka_value(p_expect_inlineopt));</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    expect_uint_value(add_option, =
is_inline, 1);</span><br><span>     read_single_config(&amp;o, &quot;&lt;in=
lineopt&gt;\n&quot; A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES=
_256 &quot;\n&lt;/inlineopt&gt;&quot;);</span><br><span> </span><br><span> =
    gc_free(&amp;o.gc);</span><br><span>diff --git a/tests/unit_tests/openv=
pn/test_push_update_msg.c b/tests/unit_tests/openvpn/test_push_update_msg.c=
</span><br><span>index 5c16001..9b7978e 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_push_update_msg.c</span><br><span>+++ b/tests/unit_=
tests/openvpn/test_push_update_msg.c</span><br><span>@@ -171,7 +171,7 @@</s=
pan><br><span> bool</span><br><span> send_control_channel_string(struct con=
text *c, const char *str, msglvl_t msglevel)</span><br><span> {</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-    check_expected(str);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    check_expected_ptr(str);=
</span><br><span>     return true;</span><br><span> }</span><br><span> </sp=
an><br><span>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests=
/unit_tests/openvpn/test_user_pass.c</span><br><span>index abe223c..a109201=
 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_user_pass.c</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><spa=
n>@@ -52,7 +52,7 @@</span><br><span>     /* Loop through configured query_u=
ser slots */</span><br><span>     for (int i =3D 0; i &lt; QUERY_USER_NUMSL=
OTS &amp;&amp; query_user[i].response !=3D NULL; i++)</span><br><span>     =
{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        check_expect=
ed(query_user[i].prompt);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+        check_expected_ptr(query_user[i].prompt);</span><br><span>   =
      strncpy(query_user[i].response, mock_ptr_type(char *), query_user[i].=
response_len);</span><br><span>     }</span><br><span> </span><br><span></s=
pan><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/open=
vpn/+/1449?usp=3Demail">change 1449</a>. To unsubscribe, or for help writin=
g mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3De=
mail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/1449?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></di=
v></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifb6594700db71d219643a29c581=
099c778bcbbc6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1449 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--A5XHXiArITo=--

