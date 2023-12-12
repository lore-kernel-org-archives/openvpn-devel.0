From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 12 Dec 2023 13:55:55 +0000
In-Reply-To: <gerrit.1701876289000.I193aef06912f01426dd4ac298aadfab97dd75a35@...2715...>
References: <gerrit.1701876289000.I193aef06912f01426dd4ac298aadfab97dd75a35@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <2730989c07f5d04f52d794b0492d0a2a1a7cb78f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="QbTIR8Tg3iI="; charset=UTF-8
Subject: [Openvpn-devel] [L] Change in openvpn[master]: test_user_pass: new
 UT for get_user_pass
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

--QbTIR8Tg3iI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail

to look at the new patch set (#4).


Change subject: test_user_pass: new UT for get_user_pass
......................................................................

test_user_pass: new UT for get_user_pass

UTs for basic functionality, without management functions.

v2:
 - add CMake support
 - add GHA support for both MSVC and mingw
v3:
 - fix distcheck by adding input/ directory to dist

Change-Id: I193aef06912f01426dd4ac298aadfab97dd75a35
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M .github/workflows/build.yaml
M CMakeLists.txt
M src/openvpn/syshead.h
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/input/user_only.txt
A tests/unit_tests/openvpn/input/user_pass.txt
A tests/unit_tests/openvpn/test_user_pass.c
7 files changed, 308 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/468/4

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index 4393f5c..784a844 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -85,11 +85,13 @@
       fail-fast: false
       matrix:
         arch: [x86, x64]
-        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, pac=
ket_id, pkt, provider, tls_crypt]
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, pac=
ket_id, pkt, provider, tls_crypt, user_pass]

     runs-on: windows-latest
     name: "mingw unittest ${{ matrix.test }} - ${{ matrix.arch }} - OSSL"
     steps:
+      - name: Checkout OpenVPN
+        uses: actions/checkout@...2689...
       - name: Retrieve mingw unittest
         uses: actions/download-artifact@...2689...
         with:
@@ -97,6 +99,8 @@
           path: unittests
       - name: Run ${{ matrix.test }} unit test
         run: ./unittests/test_${{ matrix.test }}.exe
+        env:
+          srcdir: "${{ github.workspace }}/tests/unit_tests/openvpn"

   ubuntu:
     strategy:
@@ -279,6 +283,7 @@
           configurePreset: win-${{ matrix.arch }}-release
           buildPreset: win-${{ matrix.arch }}-release
           testPreset: win-${{ matrix.arch }}-release
+          testPresetAdditionalArgs: "['--output-on-failure']"

       - uses: actions/upload-artifact@...2689...
         with:
diff --git a/CMakeLists.txt b/CMakeLists.txt
index d40b213..af891a5 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -587,6 +587,7 @@
         "test_packet_id"
         "test_pkt"
         "test_provider"
+        "test_user_pass"
         )

     if (WIN32)
@@ -645,6 +646,10 @@
         # test_networking needs special environment
         if (NOT ${test_name} STREQUAL "test_networking")
             add_test(${test_name} ${test_name})
+            # for compat with autotools make check
+            set(_UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_test=
s/openvpn)
+            set_tests_properties(${test_name} PROPERTIES
+                ENVIRONMENT "srcdir=3D${_UT_SOURCE_DIR}")
         endif ()
         add_executable(${test_name}
             tests/unit_tests/openvpn/${test_name}.c
@@ -739,6 +744,15 @@
         src/openvpn/base64.c
         )

+    target_sources(test_user_pass PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        tests/unit_tests/openvpn/mock_win32_execve.c
+        src/openvpn/base64.c
+        src/openvpn/console.c
+        src/openvpn/env_set.c
+        src/openvpn/run_command.c
+        )
+
     if (TARGET test_argv)
         target_link_options(test_argv PRIVATE -Wl,--wrap=3Dparse_line)
         target_sources(test_argv PRIVATE
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 7181b94..d89d2b5 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -522,4 +522,10 @@
 #define ENABLE_MEMSTATS
 #endif

+#ifdef _MSC_VER
+#ifndef PATH_MAX
+#define PATH_MAX MAX_PATH
+#endif
+#endif
+
 #endif /* ifndef SYSHEAD_H */
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index cecf4dc..342f428 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -1,5 +1,7 @@
 AUTOMAKE_OPTIONS =3D foreign

+EXTRA_DIST =3D input
+
 AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) Unit-Tests'

 test_binaries=3D
@@ -9,7 +11,7 @@
 endif

 test_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_testd=
river ncp_testdriver misc_testdriver \
-	pkt_testdriver
+	pkt_testdriver user_pass_testdriver
 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
 test_binaries +=3D tls_crypt_testdriver
@@ -216,6 +218,22 @@
 	$(top_srcdir)/src/openvpn/base64.c


+user_pass_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn
+user_pass_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+user_pass_testdriver_SOURCES =3D test_user_pass.c mock_msg.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/console.c \
+	$(top_srcdir)/src/openvpn/env_set.c \
+	mock_win32_execve.c \
+	$(top_srcdir)/src/openvpn/run_command.c \
+	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/base64.c
+
+
 ncp_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	$(OPTIONAL_CRYPTO_CFLAGS)
diff --git a/tests/unit_tests/openvpn/input/user_only.txt b/tests/unit_test=
s/openvpn/input/user_only.txt
new file mode 100644
index 0000000..3ca0db3
--- /dev/null
+++ b/tests/unit_tests/openvpn/input/user_only.txt
@@ -0,0 +1 @@
+fuser
diff --git a/tests/unit_tests/openvpn/input/user_pass.txt b/tests/unit_test=
s/openvpn/input/user_pass.txt
new file mode 100644
index 0000000..31b38ef
--- /dev/null
+++ b/tests/unit_tests/openvpn/input/user_pass.txt
@@ -0,0 +1,2 @@
+fuser
+fpassword
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
new file mode 100644
index 0000000..ab4dfe4
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -0,0 +1,260 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2023 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License as published by t=
he
+ *  Free Software Foundation, either version 2 of the License,
+ *  or (at your option) any later version.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#undef ENABLE_SYSTEMD
+
+#include "syshead.h"
+#include "manage.h"
+
+#include <stdlib.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "misc.c"
+
+struct management *management; /* global */
+
+/* mocking */
+bool
+query_user_exec_builtin(void)
+{
+    /* Loop through configured query_user slots */
+    for (int i =3D 0; i < QUERY_USER_NUMSLOTS && query_user[i].response !=
=3D NULL; i++)
+    {
+        check_expected(query_user[i].prompt);
+        strncpy(query_user[i].response, mock_ptr_type(char *), query_user[=
i].response_len);
+    }
+
+    return mock();
+}
+void
+management_auth_failure(struct management *man, const char *type, const ch=
ar *reason)
+{
+    assert_true(0);
+}
+bool
+management_query_user_pass(struct management *man,
+                           struct user_pass *up,
+                           const char *type,
+                           const unsigned int flags,
+                           const char *static_challenge)
+{
+    assert_true(0);
+    return false;
+}
+/* stubs for some unused functions instead of pulling in too many dependen=
cies */
+int
+parse_line(const char *line, char **p, const int n, const char *file,
+           const int line_num, int msglevel, struct gc_arena *gc)
+{
+    assert_true(0);
+    return 0;
+}
+
+/* tooling */
+static void
+reset_user_pass(struct user_pass *up)
+{
+    up->defined =3D false;
+    up->token_defined =3D false;
+    up->nocache =3D false;
+    strcpy(up->username, "user");
+    strcpy(up->password, "password");
+}
+
+static void
+test_get_user_pass_defined(void **state)
+{
+    struct user_pass up =3D { 0 };
+    reset_user_pass(&up);
+    up.defined =3D true;
+    assert_true(get_user_pass_cr(&up, NULL, "UT", 0, NULL));
+}
+
+static void
+test_get_user_pass_needok(void **state)
+{
+    struct user_pass up =3D { 0 };
+    reset_user_pass(&up);
+    unsigned int flags =3D GET_USER_PASS_NEED_OK;
+
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "NEED-OK|=
UT|user:");
+    will_return(query_user_exec_builtin, "");
+    will_return(query_user_exec_builtin, true);
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, NULL, "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.password, "ok");
+
+    reset_user_pass(&up);
+
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "NEED-OK|=
UT|user:");
+    will_return(query_user_exec_builtin, "cancel");
+    will_return(query_user_exec_builtin, true);
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, NULL, "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.password, "cancel");
+}
+
+static void
+test_get_user_pass_inline_creds(void **state)
+{
+    struct user_pass up =3D { 0 };
+    reset_user_pass(&up);
+    unsigned int flags =3D GET_USER_PASS_INLINE_CREDS;
+
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, "iuser\nipassword", "UT", flags, NUL=
L));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "iuser");
+    assert_string_equal(up.password, "ipassword");
+
+    reset_user_pass(&up);
+
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
+    will_return(query_user_exec_builtin, "cpassword");
+    will_return(query_user_exec_builtin, true);
+    /* will try to retrieve missing password from stdin */
+    assert_true(get_user_pass_cr(&up, "iuser", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "iuser");
+    assert_string_equal(up.password, "cpassword");
+
+    reset_user_pass(&up);
+
+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, "ipassword\n", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "user");
+    assert_string_equal(up.password, "ipassword");
+
+    reset_user_pass(&up);
+
+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
+    will_return(query_user_exec_builtin, "cpassword");
+    will_return(query_user_exec_builtin, true);
+    /* will try to retrieve missing password from stdin */
+    assert_true(get_user_pass_cr(&up, "", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "user");
+    assert_string_equal(up.password, "cpassword");
+}
+
+static void
+test_get_user_pass_authfile_stdin(void **state)
+{
+    struct user_pass up =3D { 0 };
+    reset_user_pass(&up);
+    unsigned int flags =3D 0;
+
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Username:");
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
+    will_return(query_user_exec_builtin, "cuser");
+    will_return(query_user_exec_builtin, "cpassword");
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, "stdin", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "cuser");
+    assert_string_equal(up.password, "cpassword");
+
+    reset_user_pass(&up);
+
+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
+    will_return(query_user_exec_builtin, "cpassword");
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, "stdin", "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "user");
+    assert_string_equal(up.password, "cpassword");
+}
+
+static void
+test_get_user_pass_authfile_file(void **state)
+{
+    struct user_pass up =3D { 0 };
+    reset_user_pass(&up);
+    unsigned int flags =3D 0;
+
+    const char *srcdir =3D getenv("srcdir");
+    assert_non_null(srcdir);
+    char authfile[PATH_MAX] =3D { 0 };
+
+    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_pass.txt");
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "fuser");
+    assert_string_equal(up.password, "fpassword");
+
+    reset_user_pass(&up);
+
+    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_only.txt");
+    expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
+    will_return(query_user_exec_builtin, "cpassword");
+    will_return(query_user_exec_builtin, true);
+    /* will try to retrieve missing password from stdin */
+    assert_true(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "fuser");
+    assert_string_equal(up.password, "cpassword");
+
+    reset_user_pass(&up);
+
+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;
+    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_only.txt");
+    /*FIXME: query_user_exec() called even though nothing queued */
+    will_return(query_user_exec_builtin, true);
+    assert_true(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
+    assert_true(up.defined);
+    assert_string_equal(up.username, "user");
+    assert_string_equal(up.password, "fuser");
+}
+
+const struct CMUnitTest user_pass_tests[] =3D {
+    cmocka_unit_test(test_get_user_pass_defined),
+    cmocka_unit_test(test_get_user_pass_needok),
+    cmocka_unit_test(test_get_user_pass_inline_creds),
+    cmocka_unit_test(test_get_user_pass_authfile_stdin),
+    cmocka_unit_test(test_get_user_pass_authfile_file),
+};
+
+int
+main(void)
+{
+    return cmocka_run_group_tests(user_pass_tests, NULL, NULL);
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I193aef06912f01426dd4ac298aadfab97dd75a35
Gerrit-Change-Number: 468
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--QbTIR8Tg3iI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #4</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">test_user_pass: new UT for get_user_pass<br><br>UTs for basic func=
tionality, without management functions.<br><br>v2:<br> - add CMake support=
<br> - add GHA support for both MSVC and mingw<br>v3:<br> - fix distcheck b=
y adding input/ directory to dist<br><br>Change-Id: I193aef06912f01426dd4ac=
298aadfab97dd75a35<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...=
&gt;<br>---<br>M .github/workflows/build.yaml<br>M CMakeLists.txt<br>M src/=
openvpn/syshead.h<br>M tests/unit_tests/openvpn/Makefile.am<br>A tests/unit=
_tests/openvpn/input/user_only.txt<br>A tests/unit_tests/openvpn/input/user=
_pass.txt<br>A tests/unit_tests/openvpn/test_user_pass.c<br>7 files changed=
, 308 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-family:=
 monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn=
.net:29418/openvpn refs/changes/68/468/4</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/workf=
lows/build.yaml b/.github/workflows/build.yaml</span><br><span>index 4393f5=
c..784a844 100644</span><br><span>--- a/.github/workflows/build.yaml</span>=
<br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -85,11 +85,=
13 @@</span><br><span>       fail-fast: false</span><br><span>       matrix=
:</span><br><span>         arch: [x86, x64]</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-        test: [argv, auth_token, buffer, cryptoapi, c=
rypto, misc, ncp, packet_id, pkt, provider, tls_crypt]</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        test: [argv, auth_token, buffer,=
 cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, tls_crypt, user_pa=
ss]</span><br><span> </span><br><span>     runs-on: windows-latest</span><b=
r><span>     name: &quot;mingw unittest ${{ matrix.test }} - ${{ matrix.arc=
h }} - OSSL&quot;</span><br><span>     steps:</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+      - name: Checkout OpenVPN</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+        uses: actions/checkout@...2781...=
...</span><br><span>       - name: Retrieve mingw unittest</span><br><span>=
         uses: actions/download-artifact@...2689...</span><br><span>       =
  with:</span><br><span>@@ -97,6 +99,8 @@</span><br><span>           path: =
unittests</span><br><span>       - name: Run ${{ matrix.test }} unit test</=
span><br><span>         run: ./unittests/test_${{ matrix.test }}.exe</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        env:</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+          srcdir: &quot;${{ githu=
b.workspace }}/tests/unit_tests/openvpn&quot;</span><br><span> </span><br><=
span>   ubuntu:</span><br><span>     strategy:</span><br><span>@@ -279,6 +2=
83,7 @@</span><br><span>           configurePreset: win-${{ matrix.arch }}-=
release</span><br><span>           buildPreset: win-${{ matrix.arch }}-rele=
ase</span><br><span>           testPreset: win-${{ matrix.arch }}-release</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+          testPresetA=
dditionalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</span><br><span>=
 </span><br><span>       - uses: actions/upload-artifact@...2689...</span><=
br><span>         with:</span><br><span>diff --git a/CMakeLists.txt b/CMake=
Lists.txt</span><br><span>index d40b213..af891a5 100644</span><br><span>---=
 a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -=
587,6 +587,7 @@</span><br><span>         &quot;test_packet_id&quot;</span><=
br><span>         &quot;test_pkt&quot;</span><br><span>         &quot;test_=
provider&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
   &quot;test_user_pass&quot;</span><br><span>         )</span><br><span> <=
/span><br><span>     if (WIN32)</span><br><span>@@ -645,6 +646,10 @@</span>=
<br><span>         # test_networking needs special environment</span><br><s=
pan>         if (NOT ${test_name} STREQUAL &quot;test_networking&quot;)</sp=
an><br><span>             add_test(${test_name} ${test_name})</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+            # for compat with aut=
otools make check</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
          set(_UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit_tests/o=
penvpn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            =
set_tests_properties(${test_name} PROPERTIES</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+                ENVIRONMENT &quot;srcdir=3D${_UT_S=
OURCE_DIR}&quot;)</span><br><span>         endif ()</span><br><span>       =
  add_executable(${test_name}</span><br><span>             tests/unit_tests=
/openvpn/${test_name}.c</span><br><span>@@ -739,6 +744,15 @@</span><br><spa=
n>         src/openvpn/base64.c</span><br><span>         )</span><br><span>=
 </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_sources=
(test_user_pass PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        tests/unit_tests/openvpn/mock_get_random.c</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_wi=
n32_execve.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 src/openvpn/base64.c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+        src/openvpn/console.c</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        src/openvpn/env_set.c</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/run_command.c</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>     if (TARGET test_argv)</span=
><br><span>         target_link_options(test_argv PRIVATE -Wl,--wrap=3Dpars=
e_line)</span><br><span>         target_sources(test_argv PRIVATE</span><br=
><span>diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h</span><br=
><span>index 7181b94..d89d2b5 100644</span><br><span>--- a/src/openvpn/sysh=
ead.h</span><br><span>+++ b/src/openvpn/syshead.h</span><br><span>@@ -522,4=
 +522,10 @@</span><br><span> #define ENABLE_MEMSTATS</span><br><span> #endi=
f</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifdef _MSC_VER</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifn=
def PATH_MAX</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define=
 PATH_MAX MAX_PATH</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #endif /*=
 ifndef SYSHEAD_H */</span><br><span>diff --git a/tests/unit_tests/openvpn/=
Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>index ce=
cf4dc..342f428 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefi=
le.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br>=
<span>@@ -1,5 +1,7 @@</span><br><span> AUTOMAKE_OPTIONS =3D foreign</span><=
br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+EXTRA_DIS=
T =3D input</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> AM_TESTSUITE_SUMMARY_HEADER =3D &#39; for $(PACKAGE_STRING) Unit-=
Tests&#39;</span><br><span> </span><br><span> test_binaries=3D</span><br><s=
pan>@@ -9,7 +11,7 @@</span><br><span> endif</span><br><span> </span><br><sp=
an> test_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_te=
stdriver ncp_testdriver misc_testdriver \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	pkt_testdriver</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	pkt_testdriver user_pass_testdriver</span><br><span> if HA=
VE_LD_WRAP_SUPPORT</span><br><span> if !WIN32</span><br><span> test_binarie=
s +=3D tls_crypt_testdriver</span><br><span>@@ -216,6 +218,22 @@</span><br>=
<span> 	$(top_srcdir)/src/openvpn/base64.c</span><br><span> </span><br><spa=
n> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+user_pass_testdr=
iver_CFLAGS  =3D @TEST_CFLAGS@ \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_sr=
cdir)/src/openvpn</span><br><span style=3D"color: hsl(120, 100%, 40%);">+us=
er_pass_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+user_pass_testdriver_SOURCES =3D test_user_pass.c mock_msg.c \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvp=
n/buffer.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_=
srcdir)/src/openvpn/console.c \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	$(top_srcdir)/src/openvpn/env_set.c \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	mock_win32_execve.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/run_command.c =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get_random.c=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/sr=
c/openvpn/platform.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/base64.c</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span> ncp_testdriver_CFLAGS  =3D @TEST_CF=
LAGS@ \</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compa=
t -I$(top_srcdir)/src/openvpn \</span><br><span> 	$(OPTIONAL_CRYPTO_CFLAGS)=
</span><br><span>diff --git a/tests/unit_tests/openvpn/input/user_only.txt =
b/tests/unit_tests/openvpn/input/user_only.txt</span><br><span>new file mod=
e 100644</span><br><span>index 0000000..3ca0db3</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/tests/unit_tests/openvpn/input/user_only.txt</span=
><br><span>@@ -0,0 +1 @@</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+fuser</span><br><span>diff --git a/tests/unit_tests/openvpn/input/user=
_pass.txt b/tests/unit_tests/openvpn/input/user_pass.txt</span><br><span>ne=
w file mode 100644</span><br><span>index 0000000..31b38ef</span><br><span>-=
-- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/input/user_pass=
.txt</span><br><span>@@ -0,0 +1,2 @@</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+fuser</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+fpassword</span><br><span>diff --git a/tests/unit_tests/openvpn/test_use=
r_pass.c b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>new fi=
le mode 100644</span><br><span>index 0000000..ab4dfe4</span><br><span>--- /=
dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_user_pass.c</s=
pan><br><span>@@ -0,0 +1,260 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  O=
penVPN -- An application to securely tunnel IP networks</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, =
with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             session authentication and key exchange,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryp=
tion, packet authentication, and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             packet compression.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2023 OpenVPN Inc &lt;sales@...515...&gt;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you ca=
n redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  it under the terms of the GNU General Public License as pub=
lished by the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Fr=
ee Software Foundation, either version 2 of the License,</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  or (at your option) any later vers=
ion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distributed =
in the hope that it will be useful,</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied warr=
anty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANT=
ABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for more d=
etails.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have received =
a copy of the GNU General Public License along</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *  with this program; if not, write to the Free=
 Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#und=
ef ENABLE_SYSTEMD</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshea=
d.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;manage.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib=
.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;=
string.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#includ=
e &lt;setjmp.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
include &lt;cmocka.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;misc.c&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+struct management *manage=
ment; /* global */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* mocking */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+query_user_exec_builtin(void)</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    /* Loop through configured query_user slots *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D=
 0; i &lt; QUERY_USER_NUMSLOTS &amp;&amp; query_user[i].response !=3D NULL;=
 i++)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+        check_expected(query=
_user[i].prompt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      strncpy(query_user[i].response, mock_ptr_type(char *), query_user[i].=
response_len);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return mock();</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+management_auth_failure(struct management *man, const char *type, const =
char *reason)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+management_query_user_pass(struct management *man,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+                         =
  struct user_pass *up,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                           const char *type,</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+                           const unsigned int =
flags,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+             =
              const char *static_challenge)</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    return false;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* stubs for s=
ome unused functions instead of pulling in too many dependencies */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+parse_line(const char *line, char **p, co=
nst int n, const char *file,</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+           const int line_num, int msglevel, struct gc_arena *gc)<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    return 0;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* too=
ling */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+reset_user_pass(stru=
ct user_pass *up)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    up-&gt;defined =
=3D false;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    up-&g=
t;token_defined =3D false;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    up-&gt;nocache =3D false;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    strcpy(up-&gt;username, &quot;user&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(up-&gt;password, &qu=
ot;password&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+test_get_user_pass_defined(void **state)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;u=
p);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    up.defined =
=3D true;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(get_user_pass_cr(&amp;up, NULL, &quot;UT&quot;, 0, NULL));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_get_user_pass_needok(void **state)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    struct user_pass up =3D { 0 };</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    unsigned int flags =3D GET_USER_PASS_NEED_OK=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_bui=
ltin, query_user[i].prompt, &quot;NEED-OK|UT|user:&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_buil=
tin, &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    will_return(query_user_exec_builtin, true);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even thou=
gh nothing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    will_return(query_user_exec_builtin, true);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, NULL=
, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;ok&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, quer=
y_user[i].prompt, &quot;NEED-OK|UT|user:&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot=
;cancel&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
will_return(query_user_exec_builtin, true);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even though n=
othing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 will_return(query_user_exec_builtin, true);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, NULL, &q=
uot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_true(up.defined);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_string_equal(up.password, &quot;cancel&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+test_get_user_pass_inline_creds(void **state)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    struct user_pass up =3D { 0 };</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D GET_=
USER_PASS_INLINE_CREDS;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: qu=
ery_user_exec() called even though nothing queued */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, =
true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(get_user_pass_cr(&amp;up, &quot;iuser\nipassword&quot;, &quot;UT&quot;, =
flags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_string_equal(up.username, &quot;iuser&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.passwor=
d, &quot;ipassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_us=
er_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_string(que=
ry_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(qu=
ery_user_exec_builtin, &quot;cpassword&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* will try to r=
etrieve missing password from stdin */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;iuser&qu=
ot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;iuser&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(up.password, &quot;cpassword&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even though n=
othing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 will_return(query_user_exec_builtin, true);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;ip=
assword\n&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &=
quot;user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(up.password, &quot;ipassword&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builti=
n, query_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_built=
in, &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    will_return(query_user_exec_builtin, true);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    /* will try to retrieve missing pas=
sword from stdin */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_true(get_user_pass_cr(&amp;up, &quot;&quot;, &quot;UT&quot;, fla=
gs, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(up.username, &quot;user&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &=
quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_authfile_stdin(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_p=
ass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    un=
signed int flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_stri=
ng(query_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Username:&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_s=
tring(query_user_exec_builtin, query_user[i].prompt, &quot;Enter UT Passwor=
d:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_=
return(query_user_exec_builtin, &quot;cuser&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, =
&quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    will_return(query_user_exec_builtin, true);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up,=
 &quot;stdin&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username=
, &quot;cuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_string_equal(up.password, &quot;cpassword&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_bu=
iltin, query_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_b=
uiltin, &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&a=
mp;up, &quot;stdin&quot;, &quot;UT&quot;, flags, NULL));</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.us=
ername, &quot;user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_string_equal(up.password, &quot;cpassword&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+test_get_user_pass_authfile_file(void **state)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    struct user_pass up =3D { 0 };</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D 0;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    const char *srcdir =3D getenv(&quot;srcdir&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_n=
on_null(srcdir);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 char authfile[PATH_MAX] =3D { 0 };</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 snprintf(authfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/user_p=
ass.txt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
/*FIXME: query_user_exec() called even though nothing queued */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec=
_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;, flags, NUL=
L));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true=
(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(up.username, &quot;fuser&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;f=
password&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&a=
mp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(authfile, PATH_MAX=
, &quot;%s/%s&quot;, srcdir, &quot;input/user_only.txt&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    expect_string(query_user_exe=
c_builtin, query_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_ex=
ec_builtin, &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* will try to retrieve mis=
sing password from stdin */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_true(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;,=
 flags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(up.username, &quot;fuser&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.passwo=
rd, &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_u=
ser_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_U=
SER_PASS_PASSWORD_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    snprintf(authfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input=
/user_only.txt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    /*FIXME: query_user_exec() called even though nothing queued */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_us=
er_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_true(get_user_pass_cr(&amp;up, authfile, &quot;UT&quot;, fla=
gs, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(up.username, &quot;user&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &=
quot;fuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+const struct CMUnitTest user_pass_test=
s[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka=
_unit_test(test_get_user_pass_defined),</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_needok),</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_=
get_user_pass_inline_creds),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    cmocka_unit_test(test_get_user_pass_authfile_stdin),</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get=
_user_pass_authfile_file),</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+};</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    return cmocka_run_group_tests(user_pass_tests, NULL, NULL);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
68?usp=3Demail">change 468</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I193aef06912f01426dd4ac298aa=
dfab97dd75a35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 468 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--QbTIR8Tg3iI=--

