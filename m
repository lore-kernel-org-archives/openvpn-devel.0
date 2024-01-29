From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 29 Jan 2024 09:07:00 +0000
In-Reply-To: <gerrit.1701876289000.I193aef06912f01426dd4ac298aadfab97dd75a35@...2715...>
References: <gerrit.1701876289000.I193aef06912f01426dd4ac298aadfab97dd75a35@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dfb4347b07a85e9289dc8d27235b4e015b7651d6-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="CFhU04zTEeA="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--CFhU04zTEeA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#9) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20240127200716.10255-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
138.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M .github/workflows/build.yaml
M CMakeLists.txt
M src/openvpn/misc.h
M src/openvpn/syshead.h
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/input/user_only.txt
A tests/unit_tests/openvpn/input/user_pass.txt
A tests/unit_tests/openvpn/test_user_pass.c
8 files changed, 327 insertions(+), 2 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/468/9

diff --git a/.github/workflows/build.yaml b/.github/workflows/build.yaml
index cc98813..bc937e5 100644
--- a/.github/workflows/build.yaml
+++ b/.github/workflows/build.yaml
@@ -85,11 +85,13 @@
       fail-fast: false
       matrix:
         arch: [x86, x64]
-        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, pac=
ket_id, pkt, provider, ssl, tls_crypt]
+        test: [argv, auth_token, buffer, cryptoapi, crypto, misc, ncp, pac=
ket_id, pkt, provider, ssl, tls_crypt, user_pass]

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
index 5e07d50..be55c60 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -604,6 +604,7 @@
         "test_pkt"
         "test_provider"
         "test_ssl"
+        "test_user_pass"
         )

     if (WIN32)
@@ -662,6 +663,10 @@
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
@@ -782,6 +787,15 @@
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
diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h
index d51609d..5ae61b5 100644
--- a/src/openvpn/misc.h
+++ b/src/openvpn/misc.h
@@ -118,12 +118,31 @@

 #define GET_USER_PASS_INLINE_CREDS (1<<10)  /* indicates that auth_file is=
 actually inline creds */

+/**
+ * Retrieves the user credentials from various sources depending on the fl=
ags.
+ *
+ * @param up The user_pass structure to store the retrieved credentials.
+ * @param auth_file The path to the authentication file. Might be NULL.
+ * @param prefix The prefix to prepend to user prompts.
+ * @param flags Additional flags to control the behavior of the function.
+ * @param auth_challenge The authentication challenge string.
+ * @return true if the user credentials were successfully retrieved, false=
 otherwise.
+ */
 bool get_user_pass_cr(struct user_pass *up,
                       const char *auth_file,
                       const char *prefix,
                       const unsigned int flags,
                       const char *auth_challenge);

+/**
+ * Retrieves the user credentials from various sources depending on the fl=
ags.
+ *
+ * @param up The user_pass structure to store the retrieved credentials.
+ * @param auth_file The path to the authentication file. Might be NULL.
+ * @param prefix The prefix to prepend to user prompts.
+ * @param flags Additional flags to control the behavior of the function.
+ * @return true if the user credentials were successfully retrieved, false=
 otherwise.
+ */
 static inline bool
 get_user_pass(struct user_pass *up,
               const char *auth_file,
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index a021c91..d2859fe 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -524,4 +524,10 @@
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
index f81a10f..88a694d 100644
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
-	pkt_testdriver ssl_testdriver
+	pkt_testdriver ssl_testdriver user_pass_testdriver

 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
@@ -251,6 +253,22 @@
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
Gerrit-PatchSet: 9
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--CFhU04zTEeA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #9</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/468?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">test_user_pass: new UT for get_user_pass<br><br>=
UTs for basic functionality, without management functions.<br><br>v2:<br> -=
 add CMake support<br> - add GHA support for both MSVC and mingw<br>v3:<br>=
 - fix distcheck by adding input/ directory to dist<br><br>Change-Id: I193a=
ef06912f01426dd4ac298aadfab97dd75a35<br>Signed-off-by: Frank Lichtenheld &l=
t;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &lt;arne-openvpn@...2477...=
.&gt;<br>Message-Id: &lt;20240127200716.10255-1-gert@...1296...&gt;<br>URL:=
 https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28138.=
html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M .gi=
thub/workflows/build.yaml<br>M CMakeLists.txt<br>M src/openvpn/misc.h<br>M =
src/openvpn/syshead.h<br>M tests/unit_tests/openvpn/Makefile.am<br>A tests/=
unit_tests/openvpn/input/user_only.txt<br>A tests/unit_tests/openvpn/input/=
user_pass.txt<br>A tests/unit_tests/openvpn/test_user_pass.c<br>8 files cha=
nged, 327 insertions(+), 2 deletions(-)<br><br></pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.ope=
nvpn.net:29418/openvpn refs/changes/68/468/9</pre><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/.github/w=
orkflows/build.yaml b/.github/workflows/build.yaml</span><br><span>index cc=
98813..bc937e5 100644</span><br><span>--- a/.github/workflows/build.yaml</s=
pan><br><span>+++ b/.github/workflows/build.yaml</span><br><span>@@ -85,11 =
+85,13 @@</span><br><span>       fail-fast: false</span><br><span>       ma=
trix:</span><br><span>         arch: [x86, x64]</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-        test: [argv, auth_token, buffer, cryptoap=
i, crypto, misc, ncp, packet_id, pkt, provider, ssl, tls_crypt]</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        test: [argv, auth_token=
, buffer, cryptoapi, crypto, misc, ncp, packet_id, pkt, provider, ssl, tls_=
crypt, user_pass]</span><br><span> </span><br><span>     runs-on: windows-l=
atest</span><br><span>     name: &quot;mingw unittest ${{ matrix.test }} - =
${{ matrix.arch }} - OSSL&quot;</span><br><span>     steps:</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+      - name: Checkout OpenVPN</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        uses: actions/ch=
eckout@...2689...</span><br><span>       - name: Retrieve mingw unittest</s=
pan><br><span>         uses: actions/download-artifact@...2689...</span><br=
><span>         with:</span><br><span>@@ -97,6 +99,8 @@</span><br><span>   =
        path: unittests</span><br><span>       - name: Run ${{ matrix.test =
}} unit test</span><br><span>         run: ./unittests/test_${{ matrix.test=
 }}.exe</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        env:=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          srcdir: &=
quot;${{ github.workspace }}/tests/unit_tests/openvpn&quot;</span><br><span=
> </span><br><span>   ubuntu:</span><br><span>     strategy:</span><br><spa=
n>@@ -279,6 +283,7 @@</span><br><span>           configurePreset: win-${{ m=
atrix.arch }}-release</span><br><span>           buildPreset: win-${{ matri=
x.arch }}-release</span><br><span>           testPreset: win-${{ matrix.arc=
h }}-release</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
   testPresetAdditionalArgs: &quot;[&#39;--output-on-failure&#39;]&quot;</s=
pan><br><span> </span><br><span>       - uses: actions/upload-artifact@...1665...=
689...</span><br><span>         with:</span><br><span>diff --git a/CMakeLis=
ts.txt b/CMakeLists.txt</span><br><span>index 5e07d50..be55c60 100644</span=
><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span>=
<br><span>@@ -604,6 +604,7 @@</span><br><span>         &quot;test_pkt&quot;=
</span><br><span>         &quot;test_provider&quot;</span><br><span>       =
  &quot;test_ssl&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        &quot;test_user_pass&quot;</span><br><span>         )</span><br>=
<span> </span><br><span>     if (WIN32)</span><br><span>@@ -662,6 +663,10 @=
@</span><br><span>         # test_networking needs special environment</spa=
n><br><span>         if (NOT ${test_name} STREQUAL &quot;test_networking&qu=
ot;)</span><br><span>             add_test(${test_name} ${test_name})</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+            # for compat =
with autotools make check</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+            set(_UT_SOURCE_DIR ${CMAKE_CURRENT_SOURCE_DIR}/tests/unit=
_tests/openvpn)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
        set_tests_properties(${test_name} PROPERTIES</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                ENVIRONMENT &quot;srcdir=
=3D${_UT_SOURCE_DIR}&quot;)</span><br><span>         endif ()</span><br><sp=
an>         add_executable(${test_name}</span><br><span>             tests/=
unit_tests/openvpn/${test_name}.c</span><br><span>@@ -782,6 +787,15 @@</spa=
n><br><span>         src/openvpn/base64.c</span><br><span>         )</span>=
<br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    targ=
et_sources(test_user_pass PRIVATE</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        tests/unit_tests/openvpn/mock_get_random.c</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        tests/unit_tests/openv=
pn/mock_win32_execve.c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        src/openvpn/base64.c</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+        src/openvpn/console.c</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+        src/openvpn/env_set.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/run_command.c</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     if (TARGET test=
_argv)</span><br><span>         target_link_options(test_argv PRIVATE -Wl,-=
-wrap=3Dparse_line)</span><br><span>         target_sources(test_argv PRIVA=
TE</span><br><span>diff --git a/src/openvpn/misc.h b/src/openvpn/misc.h</sp=
an><br><span>index d51609d..5ae61b5 100644</span><br><span>--- a/src/openvp=
n/misc.h</span><br><span>+++ b/src/openvpn/misc.h</span><br><span>@@ -118,1=
2 +118,31 @@</span><br><span> </span><br><span> #define GET_USER_PASS_INLIN=
E_CREDS (1&lt;&lt;10)  /* indicates that auth_file is actually inline creds=
 */</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+/**</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Retrieves t=
he user credentials from various sources depending on the flags.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ * @param up The user_pass structure to store t=
he retrieved credentials.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * @param auth_file The path to the authentication file. Might be NUL=
L.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param prefix =
The prefix to prepend to user prompts.</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ * @param flags Additional flags to control the behavior=
 of the function.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 @param auth_challenge The authentication challenge string.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the user credent=
ials were successfully retrieved, false otherwise.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ */</span><br><span> bool get_user_pass_cr(s=
truct user_pass *up,</span><br><span>                       const char *aut=
h_file,</span><br><span>                       const char *prefix,</span><b=
r><span>                       const unsigned int flags,</span><br><span>  =
                     const char *auth_challenge);</span><br><span> </span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Retrieves the user credentials from va=
rious sources depending on the flags.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ * @param up The user_pass structure to store the retrieved credentials.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param auth_file T=
he path to the authentication file. Might be NULL.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ * @param prefix The prefix to prepend to us=
er prompts.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @para=
m flags Additional flags to control the behavior of the function.</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ * @return true if the user c=
redentials were successfully retrieved, false otherwise.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span> static inline boo=
l</span><br><span> get_user_pass(struct user_pass *up,</span><br><span>    =
           const char *auth_file,</span><br><span>diff --git a/src/openvpn/=
syshead.h b/src/openvpn/syshead.h</span><br><span>index a021c91..d2859fe 10=
0644</span><br><span>--- a/src/openvpn/syshead.h</span><br><span>+++ b/src/=
openvpn/syshead.h</span><br><span>@@ -524,4 +524,10 @@</span><br><span> #de=
fine ENABLE_MEMSTATS</span><br><span> #endif</span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifdef _MSC_VER</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#ifndef PATH_MAX</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define PATH_MAX MAX_PATH</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> #endif /* ifndef SYSHEAD_H */</span><br><=
span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/o=
penvpn/Makefile.am</span><br><span>index f81a10f..88a694d 100644</span><br>=
<span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/test=
s/unit_tests/openvpn/Makefile.am</span><br><span>@@ -1,5 +1,7 @@</span><br>=
<span> AUTOMAKE_OPTIONS =3D foreign</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+EXTRA_DIST =3D input</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span> AM_TESTSUITE_SUMMARY_H=
EADER =3D &#39; for $(PACKAGE_STRING) Unit-Tests&#39;</span><br><span> </sp=
an><br><span> test_binaries=3D</span><br><span>@@ -9,7 +11,7 @@</span><br><=
span> endif</span><br><span> </span><br><span> test_binaries +=3D crypto_te=
stdriver packet_id_testdriver auth_token_testdriver ncp_testdriver misc_tes=
tdriver \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	pkt_testdri=
ver ssl_testdriver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
pkt_testdriver ssl_testdriver user_pass_testdriver</span><br><span> </span>=
<br><span> if HAVE_LD_WRAP_SUPPORT</span><br><span> if !WIN32</span><br><sp=
an>@@ -251,6 +253,22 @@</span><br><span> 	$(top_srcdir)/src/openvpn/base64.=
c</span><br><span> </span><br><span> </span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+user_pass_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include -I$=
(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+user_pass_testdriver_LDFLAGS =3D @TEST_LD=
FLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+user_pass_testdriver_SOURCES =3D=
 test_user_pass.c mock_msg.c \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/console.c \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/=
env_set.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_wi=
n32_execve.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(to=
p_srcdir)/src/openvpn/run_command.c \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	mock_get_random.c \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform.c \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-uti=
l.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)=
/src/openvpn/base64.c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
 ncp_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \</span><br><span> 	-I$(top_srcdi=
r)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><=
br><span> 	$(OPTIONAL_CRYPTO_CFLAGS)</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/input/user_only.txt b/tests/unit_tests/openvpn/input/user_o=
nly.txt</span><br><span>new file mode 100644</span><br><span>index 0000000.=
.3ca0db3</span><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tes=
ts/openvpn/input/user_only.txt</span><br><span>@@ -0,0 +1 @@</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+fuser</span><br><span>diff --git a=
/tests/unit_tests/openvpn/input/user_pass.txt b/tests/unit_tests/openvpn/in=
put/user_pass.txt</span><br><span>new file mode 100644</span><br><span>inde=
x 0000000..31b38ef</span><br><span>--- /dev/null</span><br><span>+++ b/test=
s/unit_tests/openvpn/input/user_pass.txt</span><br><span>@@ -0,0 +1,2 @@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+fuser</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+fpassword</span><br><span>diff --git=
 a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/tes=
t_user_pass.c</span><br><span>new file mode 100644</span><br><span>index 00=
00000..ab4dfe4</span><br><span>--- /dev/null</span><br><span>+++ b/tests/un=
it_tests/openvpn/test_user_pass.c</span><br><span>@@ -0,0 +1,260 @@</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tu=
nnel IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
            over a single UDP port, with support for SSL/TLS-based</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             session authe=
ntication and key exchange,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *             packet encryption, packet authentication, and</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet comp=
ression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023 OpenV=
PN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Th=
is program is free software; you can redistribute it and/or modify</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of th=
e GNU General Public License as published by the</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  Free Software Foundation, either version 2=
 of the License,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
 or (at your option) any later version.</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  This program is distributed in the hope that it will be useful,</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARR=
ANTY; without even the implied warranty of</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURP=
OSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GN=
U General Public License for more details.</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  You should have received a copy of the GNU General Public License=
 along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this=
 program; if not, write to the Free Software Foundation, Inc.,</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Fl=
oor, Boston, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.=
h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#undef ENABLE_SYSTEMD</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &quot;manage.h&quot;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;misc.c&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+struct management *management; /* global */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+/* mocking */</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+query=
_user_exec_builtin(void)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* Loop t=
hrough configured query_user slots */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    for (int i =3D 0; i &lt; QUERY_USER_NUMSLOTS &amp;&am=
p; query_user[i].response !=3D NULL; i++)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        check_expected(query_user[i].prompt);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        strncpy(query_user[i].response, m=
ock_ptr_type(char *), query_user[i].response_len);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  return mock();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+management_auth_failure(struct manag=
ement *man, const char *type, const char *reason)</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_true(0);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+bool</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_query_user=
_pass(struct management *man,</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+                           struct user_pass *up,</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+                           const cha=
r *type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           =
                const unsigned int flags,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                           const char *static_challen=
ge)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+/* stubs for some unused functions instead of pulling =
in too many dependencies */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_li=
ne(const char *line, char **p, const int n, const char *file,</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+           const int line_num, in=
t msglevel, struct gc_arena *gc)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    r=
eturn 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+/* tooling */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+reset_user_pass(struct user_pass *up)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    up-&gt;defined =3D false;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    up-&gt;token_defined =3D false;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    up-&gt;nocache =3D false;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(up-&gt;username=
, &quot;user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    strcpy(up-&gt;password, &quot;password&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+sta=
tic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_us=
er_pass_defined(void **state)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    stru=
ct user_pass up =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    up.defined =3D true;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, NULL, &quot=
;UT&quot;, 0, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_needok(void **state)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp=
;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigned i=
nt flags =3D GET_USER_PASS_NEED_OK;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;NEED-OK=
|UT|user:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  will_return(query_user_exec_builtin, &quot;&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, =
true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: =
query_user_exec() called even though nothing queued */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin,=
 true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(get_user_pass_cr(&amp;up, NULL, &quot;UT&quot;, flags, NULL));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(up.password, &quot;ok&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_st=
ring(query_user_exec_builtin, query_user[i].prompt, &quot;NEED-OK|UT|user:&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_ret=
urn(query_user_exec_builtin, &quot;cancel&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, true=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: quer=
y_user_exec() called even though nothing queued */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, tru=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
get_user_pass_cr(&amp;up, NULL, &quot;UT&quot;, flags, NULL));</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal=
(up.password, &quot;cancel&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_inline_cred=
s(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct user_pass u=
p =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    res=
et_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    unsigned int flags =3D GET_USER_PASS_INLINE_CREDS;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /*FIXME: query_user_exec() called even though nothin=
g queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will=
_return(query_user_exec_builtin, true);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;iuser\n=
ipassword&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &=
quot;iuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(up.password, &quot;ipassword&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    expect_string(query_user_exec_builtin, query_user[i].prompt=
, &quot;Enter UT Password:&quot;);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;cpassword&quo=
t;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return=
(query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    /* will try to retrieve missing password from stdin */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_use=
r_pass_cr(&amp;up, &quot;iuser&quot;, &quot;UT&quot;, flags, NULL));</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string=
_equal(up.username, &quot;iuser&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;cpassword&qu=
ot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONL=
Y;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: quer=
y_user_exec() called even though nothing queued */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, tru=
e);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(=
get_user_pass_cr(&amp;up, &quot;ipassword\n&quot;, &quot;UT&quot;, flags, N=
ULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(up.username, &quot;user&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quo=
t;ipassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass=
(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS=
_PASSWORD_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;Enter UT=
 Password:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   will_return(query_user_exec_builtin, &quot;cpassword&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec=
_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* will try to retrieve missing password from stdin */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;u=
p, &quot;&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &=
quot;user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(up.password, &quot;cpassword&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_g=
et_user_pass_authfile_stdin(void **state)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    struct user_pass up =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    unsigned int flags =3D 0;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_user[i=
].prompt, &quot;Enter UT Username:&quot;);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_use=
r[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;cu=
ser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will=
_return(query_user_exec_builtin, &quot;cpassword&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builti=
n, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_true(get_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, flags, N=
ULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_tr=
ue(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(up.username, &quot;cuser&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quo=
t;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass=
(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS=
_PASSWORD_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;Enter UT=
 Password:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   will_return(query_user_exec_builtin, &quot;cpassword&quot;);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec=
_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_true(get_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, f=
lags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_string_equal(up.username, &quot;user&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password,=
 &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_authfile_file(void **=
state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_p=
ass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    un=
signed int flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const char =
*srcdir =3D getenv(&quot;srcdir&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_non_null(srcdir);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    char authfile[PATH_MAX] =3D { 0 };</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    snprintf(authfile, PATH_MAX, &quot;%s/%s&q=
uot;, srcdir, &quot;input/user_pass.txt&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even thou=
gh nothing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    will_return(query_user_exec_builtin, true);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, auth=
file, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_true(up.defined);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quot;fuser&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(up.password, &quot;fpassword&quot;);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    snprintf(authfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/us=
er_only.txt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;Ente=
r UT Password:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    will_return(query_user_exec_builtin, &quot;cpassword&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_=
exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* will try to retrieve missing password from stdin */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&a=
mp;up, authfile, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &=
quot;fuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_string_equal(up.password, &quot;cpassword&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    snprintf(authfile, PATH_MAX, &quot;=
%s/%s&quot;, srcdir, &quot;input/user_only.txt&quot;);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called ev=
en though nothing queued */</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    will_return(query_user_exec_builtin, true);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;u=
p, authfile, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quo=
t;user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(up.password, &quot;fuser&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+con=
st struct CMUnitTest user_pass_tests[] =3D {</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_defined),<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test=
(test_get_user_pass_needok),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    cmocka_unit_test(test_get_user_pass_inline_creds),</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_u=
ser_pass_authfile_stdin),</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    cmocka_unit_test(test_get_user_pass_authfile_file),</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_tests(use=
r_pass_tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail">change 468</a>. To unsub=
scribe, or for help writing mail filters, visit <a href=3D"http://gerrit.op=
envpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"http://sche=
ma.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://=
schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/468?usp=3Demail"/><meta itemprop=3D"name" content=3D"View =
Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I193aef06912f01426dd4ac298aa=
dfab97dd75a35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 468 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 9 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--CFhU04zTEeA=--

