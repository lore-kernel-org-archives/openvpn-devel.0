From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 6 Dec 2023 15:24:54 +0000
References: <gerrit.1701876289000.I193aef06912f01426dd4ac298aadfab97dd75a35@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <c27e761163c4ea2716911b0eb6e9a3398808af85-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="XjaOkDuXqc8="; charset=UTF-8
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

--XjaOkDuXqc8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail

to review the following change.


Change subject: test_user_pass: new UT for get_user_pass
......................................................................

test_user_pass: new UT for get_user_pass

UTs for basic functionality, without management functions.

Change-Id: I193aef06912f01426dd4ac298aadfab97dd75a35
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/input/user_only.txt
A tests/unit_tests/openvpn/input/user_pass.txt
M tests/unit_tests/openvpn/mock_msg.h
A tests/unit_tests/openvpn/test_user_pass.c
5 files changed, 289 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/68/468/1

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index ef45b11..f1a81e9 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -7,7 +7,7 @@
 endif

 test_binaries +=3D crypto_testdriver packet_id_testdriver auth_token_testd=
river ncp_testdriver misc_testdriver \
-	pkt_testdriver
+	pkt_testdriver user_pass_testdriver
 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
 test_binaries +=3D tls_crypt_testdriver
@@ -214,6 +214,21 @@
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
diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tests/openvpn=
/mock_msg.h
index be5f2e5..d54c262 100644
--- a/tests/unit_tests/openvpn/mock_msg.h
+++ b/tests/unit_tests/openvpn/mock_msg.h
@@ -24,6 +24,8 @@
 #ifndef MOCK_MSG_H
 #define MOCK_MSG_H

+extern bool fatal_error_triggered;
+
 /**
  * Mock debug level defaults to 0, which gives clean(-ish) test reports.  =
Call
  * this function from your test driver to increase debug output when you
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
new file mode 100644
index 0000000..edd566a
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -0,0 +1,268 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2023 Selva Nair <selva.nair@...277...>
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
+    (void) man;
+    (void) type;
+    (void) reason;
+    assert_true(0);
+}
+bool
+management_query_user_pass(struct management *man,
+                           struct user_pass *up,
+                           const char *type,
+                           const unsigned int flags,
+                           const char *static_challenge)
+{
+    (void) man;
+    (void) up;
+    (void) type;
+    (void) flags;
+    (void) static_challenge;
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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--XjaOkDuXqc8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">test_user_pass: new UT for get_user_pass<br><br>UTs for basic=
 functionality, without management functions.<br><br>Change-Id: I193aef0691=
2f01426dd4ac298aadfab97dd75a35<br>Signed-off-by: Frank Lichtenheld &lt;fran=
k@...2641...&gt;<br>---<br>M tests/unit_tests/openvpn/Makefile.am<br>A test=
s/unit_tests/openvpn/input/user_only.txt<br>A tests/unit_tests/openvpn/inpu=
t/user_pass.txt<br>M tests/unit_tests/openvpn/mock_msg.h<br>A tests/unit_te=
sts/openvpn/test_user_pass.c<br>5 files changed, 289 insertions(+), 1 delet=
ion(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/chang=
es/68/468/1</pre><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tes=
ts/unit_tests/openvpn/Makefile.am</span><br><span>index ef45b11..f1a81e9 10=
0644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><=
span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -7,7 +7,=
7 @@</span><br><span> endif</span><br><span> </span><br><span> test_binarie=
s +=3D crypto_testdriver packet_id_testdriver auth_token_testdriver ncp_tes=
tdriver misc_testdriver \</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	pkt_testdriver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	pkt_testdriver user_pass_testdriver</span><br><span> if HAVE_LD_WRAP_SUPPO=
RT</span><br><span> if !WIN32</span><br><span> test_binaries +=3D tls_crypt=
_testdriver</span><br><span>@@ -214,6 +214,21 @@</span><br><span> 	$(top_sr=
cdir)/src/openvpn/base64.c</span><br><span> </span><br><span> </span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+user_pass_testdriver_CFLAGS  =3D=
 @TEST_CFLAGS@ \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-I=
$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvp=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+user_pass_testdriv=
er_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+user_pass=
_testdriver_SOURCES =3D test_user_pass.c mock_msg.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer.c \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/open=
vpn/console.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(t=
op_srcdir)/src/openvpn/env_set.c \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+	$(top_srcdir)/src/openvpn/run_command.c \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	mock_get_random.c \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform.=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/s=
rc/openvpn/win32-util.c \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	$(top_srcdir)/src/openvpn/base64.c</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> ncp_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \</span><br><=
span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/s=
rc/openvpn \</span><br><span> 	$(OPTIONAL_CRYPTO_CFLAGS)</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/input/user_only.txt b/tests/unit_tests/=
openvpn/input/user_only.txt</span><br><span>new file mode 100644</span><br>=
<span>index 0000000..3ca0db3</span><br><span>--- /dev/null</span><br><span>=
+++ b/tests/unit_tests/openvpn/input/user_only.txt</span><br><span>@@ -0,0 =
+1 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fuser</span><b=
r><span>diff --git a/tests/unit_tests/openvpn/input/user_pass.txt b/tests/u=
nit_tests/openvpn/input/user_pass.txt</span><br><span>new file mode 100644<=
/span><br><span>index 0000000..31b38ef</span><br><span>--- /dev/null</span>=
<br><span>+++ b/tests/unit_tests/openvpn/input/user_pass.txt</span><br><spa=
n>@@ -0,0 +1,2 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fu=
ser</span><br><span style=3D"color: hsl(120, 100%, 40%);">+fpassword</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/mock_msg.h b/tests/unit_tes=
ts/openvpn/mock_msg.h</span><br><span>index be5f2e5..d54c262 100644</span><=
br><span>--- a/tests/unit_tests/openvpn/mock_msg.h</span><br><span>+++ b/te=
sts/unit_tests/openvpn/mock_msg.h</span><br><span>@@ -24,6 +24,8 @@</span><=
br><span> #ifndef MOCK_MSG_H</span><br><span> #define MOCK_MSG_H</span><br>=
<span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+extern bool =
fatal_error_triggered;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span> /**</span><br><span>  * Mock debug level defaults to 0=
, which gives clean(-ish) test reports.  Call</span><br><span>  * this func=
tion from your test driver to increase debug output when you</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests=
/openvpn/test_user_pass.c</span><br><span>new file mode 100644</span><br><s=
pan>index 0000000..edd566a</span><br><span>--- /dev/null</span><br><span>++=
+ b/tests/unit_tests/openvpn/test_user_pass.c</span><br><span>@@ -0,0 +1,26=
8 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to=
 securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             over a single UDP port, with support for SSL/TLS-ba=
sed</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             s=
ession authentication and key exchange,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *             packet encryption, packet authentication=
, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 packet compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C=
) 2023 Selva Nair &lt;selva.nair@...277...&gt;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  This program is free software; you can redistribute it and/or=
 modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under=
 the terms of the GNU General Public License as published by the</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  Free Software Foundation, =
either version 2 of the License,</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  or (at your option) any later version.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  This program is distributed in the hope that it will=
 be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but =
WITHOUT ANY WARRANTY; without even the implied warranty of</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A=
 PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *  GNU General Public License for more details.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  You should have received a copy of the GNU Genera=
l Public License along</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *  with this program; if not, write to the Free Software Foundation, In=
c.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin =
Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef =
HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#inclu=
de &quot;config.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#undef ENABLE_SYSTEMD</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &quot;manage.h&quot;</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;misc.c&quot;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+struct management *management; /* global */</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* mocking */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+bool</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+query_user_exec_builtin(void)</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    /* Loop through configured query_user slots */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    for (int i =3D 0; i &lt; QUERY_USER=
_NUMSLOTS &amp;&amp; query_user[i].response !=3D NULL; i++)</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        check_expected(query_user[i].prompt);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        strncpy(query_u=
ser[i].response, mock_ptr_type(char *), query_user[i].response_len);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    return mock();</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_auth_fa=
ilure(struct management *man, const char *type, const char *reason)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    (void) man;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    (void) type;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    (void) reason;</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_true(0);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+bool</span><br><span style=3D"color: hsl(120, 100%, 40%);">+management_=
query_user_pass(struct management *man,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+                           struct user_pass *up,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+                          =
 const char *type,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                          const unsigned int flags,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+                           const char *st=
atic_challenge)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    (void) man;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    (void) up;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    (void) type;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    (void) flags;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    (void) static_challenge;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(0);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    return false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+/* stubs for some unused functions instead of p=
ulling in too many dependencies */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+p=
arse_line(const char *line, char **p, const int n, const char *file,</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+           const int line_=
num, int msglevel, struct gc_arena *gc)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_true(0);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/* tooling */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+static void</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+reset_user_pass(struct user_pass *up)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    up-&gt;defined =3D false;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    up-&gt;token_defined =3D false;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    up-&gt;nocache =3D false;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    strcpy(up-&gt;u=
sername, &quot;user&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    strcpy(up-&gt;password, &quot;password&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_g=
et_user_pass_defined(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct user_pass up =3D { 0 };</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    up.defined =3D true;</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, NULL, =
&quot;UT&quot;, 0, NULL));</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_needok(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D { 0 };</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&=
amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    unsigne=
d int flags =3D GET_USER_PASS_NEED_OK;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;NEED=
-OK|UT|user:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    will_return(query_user_exec_builtin, &quot;&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builti=
n, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXM=
E: query_user_exec() called even though nothing queued */</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_built=
in, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_true(get_user_pass_cr(&amp;up, NULL, &quot;UT&quot;, flags, NULL));</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.define=
d);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_strin=
g_equal(up.password, &quot;ok&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect=
_string(query_user_exec_builtin, query_user[i].prompt, &quot;NEED-OK|UT|use=
r:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_=
return(query_user_exec_builtin, &quot;cancel&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, =
true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: =
query_user_exec() called even though nothing queued */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin,=
 true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_t=
rue(get_user_pass_cr(&amp;up, NULL, &quot;UT&quot;, flags, NULL));</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_e=
qual(up.password, &quot;cancel&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_inline_=
creds(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct user_pa=
ss up =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 reset_user_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    unsigned int flags =3D GET_USER_PASS_INLINE_CREDS;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called even though no=
thing queued */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
will_return(query_user_exec_builtin, true);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up, &quot;ius=
er\nipassword&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.usern=
ame, &quot;iuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    assert_string_equal(up.password, &quot;ipassword&quot;);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_user[i].=
prompt, &quot;Enter UT Password:&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &quot;cpasswo=
rd&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_=
return(query_user_exec_builtin, true);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* will try to retrieve missing password from stdin =
*/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(g=
et_user_pass_cr(&amp;up, &quot;iuser&quot;, &quot;UT&quot;, flags, NULL));<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.d=
efined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(up.username, &quot;iuser&quot;);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &quot;cpassw=
ord&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_PASS_PASSWOR=
D_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME:=
 query_user_exec() called even though nothing queued */</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin=
, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
true(get_user_pass_cr(&amp;up, &quot;ipassword\n&quot;, &quot;UT&quot;, fla=
gs, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(up.username, &quot;user&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, &=
quot;ipassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_p=
ass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_P=
ASS_PASSWORD_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;Enter=
 UT Password:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    will_return(query_user_exec_builtin, &quot;cpassword&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_e=
xec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    /* will try to retrieve missing password from stdin */</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&am=
p;up, &quot;&quot;, &quot;UT&quot;, flags, NULL));</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username=
, &quot;user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(up.password, &quot;cpassword&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tes=
t_get_user_pass_authfile_stdin(void **state)</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    struct user_pass up =3D { 0 };</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    unsigned int flags =3D 0;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, query_u=
ser[i].prompt, &quot;Enter UT Username:&quot;);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    expect_string(query_user_exec_builtin, quer=
y_user[i].prompt, &quot;Enter UT Password:&quot;);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_builtin, &qu=
ot;cuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 will_return(query_user_exec_builtin, &quot;cpassword&quot;);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_exec_b=
uiltin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_true(get_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot;, fla=
gs, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_string_equal(up.username, &quot;cuser&quot;);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.password, =
&quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_user_=
pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    flags |=3D GET_USER_=
PASS_PASSWORD_ONLY;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    expect_string(query_user_exec_builtin, query_user[i].prompt, &quot;Ente=
r UT Password:&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    will_return(query_user_exec_builtin, &quot;cpassword&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(query_user_=
exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_true(get_user_pass_cr(&amp;up, &quot;stdin&quot;, &quot;UT&quot=
;, flags, NULL));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_true(up.defined);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_string_equal(up.username, &quot;user&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.passw=
ord, &quot;cpassword&quot;);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+test_get_user_pass_authfile_file(voi=
d **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    struct user_pass up =3D=
 { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    reset_us=
er_pass(&amp;up);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  unsigned int flags =3D 0;</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const c=
har *srcdir =3D getenv(&quot;srcdir&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    assert_non_null(srcdir);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    char authfile[PATH_MAX] =3D { 0 };</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    snprintf(authfile, PATH_MAX, &quot;%s=
/%s&quot;, srcdir, &quot;input/user_pass.txt&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() called eve=
n though nothing queued */</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    will_return(query_user_exec_builtin, true);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_cr(&amp;up=
, authfile, &quot;UT&quot;, flags, NULL));</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.username, &quo=
t;fuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_string_equal(up.password, &quot;fpassword&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    snprintf(authfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;=
input/user_only.txt&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    expect_string(query_user_exec_builtin, query_user[i].prompt, &q=
uot;Enter UT Password:&quot;);</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    will_return(query_user_exec_builtin, &quot;cpassword&quot;);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    will_return(que=
ry_user_exec_builtin, true);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    /* will try to retrieve missing password from stdin */</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pa=
ss_cr(&amp;up, authfile, &quot;UT&quot;, flags, NULL));</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.use=
rname, &quot;fuser&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_string_equal(up.password, &quot;cpassword&quot;);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    reset_user_pass(&amp;up);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(authfile, PATH_MAX=
, &quot;%s/%s&quot;, srcdir, &quot;input/user_only.txt&quot;);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    /*FIXME: query_user_exec() c=
alled even though nothing queued */</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    will_return(query_user_exec_builtin, true);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(get_user_pass_c=
r(&amp;up, authfile, &quot;UT&quot;, flags, NULL));</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_true(up.defined);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(up.usern=
ame, &quot;user&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_string_equal(up.password, &quot;fuser&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+const struct CMUnitTest user_pass_tests[] =3D {</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_d=
efined),</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_=
unit_test(test_get_user_pass_needok),</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_inline_creds),</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    cmocka_unit_test(t=
est_get_user_pass_authfile_stdin),</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    cmocka_unit_test(test_get_user_pass_authfile_file),</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+};</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
ain(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_group_=
tests(user_pass_tests, NULL, NULL);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+}</span><br><span></span><br></pre><p>To view, visit <a hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/468?usp=3Demail">change 468</a>.=
 To unsubscribe, or for help writing mail filters, visit <a href=3D"http://=
gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"ht=
tp://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/468?usp=3Demail"/><meta itemprop=3D"name" conte=
nt=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I193aef06912f01426dd4ac298aa=
dfab97dd75a35 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 468 </div>
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


--XjaOkDuXqc8=--

