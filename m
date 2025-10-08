From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 10:18:51 +0000
In-Reply-To: <gerrit.1759239739000.I95032d2539d994abf69fc17319ed1a429c3bb948@...2715...>
References: <gerrit.1759239739000.I95032d2539d994abf69fc17319ed1a429c3bb948@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <ae9b1cc6b2efe5cdf1f438b7cabd177edde75b62-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8rGFtK0bamU="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_options_parse:
 Start new UT for options_parse.c
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

--8rGFtK0bamU=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1244?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: test_options_parse: Start new UT for options_parse.c
......................................................................

test_options_parse: Start new UT for options_parse.c

For now contains one test case for parse_line.

Change-Id: I95032d2539d994abf69fc17319ed1a429c3bb948
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1244
Message-Id: <20251008101014.5691-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243816/
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/test_options_parse.c
3 files changed, 227 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44/1244/4

diff --git a/CMakeLists.txt b/CMakeLists.txt
index aeef480..37bfc03 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -685,6 +685,7 @@
     # Clang-cl (which is also MSVC) is wrongly detected to support wrap
     if (NOT MSVC AND "${LD_SUPPORTS_WRAP}")
         list(APPEND unit_tests
+            "test_options_parse"
             "test_tls_crypt"
             )
     endif ()
@@ -826,6 +827,20 @@
         src/compat/compat-strsep.c
         )

+    if (TARGET test_options_parse)
+        target_link_options(test_options_parse PRIVATE
+            -Wl,--wrap=3Dadd_option
+            -Wl,--wrap=3Dremove_option
+            -Wl,--wrap=3Dupdate_option
+	    -Wl,--wrap=3Dusage
+        )
+        target_sources(test_options_parse PRIVATE
+            tests/unit_tests/openvpn/mock_get_random.c
+            src/openvpn/options_parse.c
+            src/openvpn/options_util.c
+        )
+    endif ()
+
     target_sources(test_packet_id PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
         src/openvpn/otime.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index f7b1bc8..8e94665 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -9,6 +9,7 @@
 	user_pass_testdriver push_update_msg_testdriver provider_testdriver socke=
t_testdriver

 if HAVE_LD_WRAP_SUPPORT
+test_binaries +=3D options_parse_testdriver
 if !WIN32
 test_binaries +=3D tls_crypt_testdriver
 endif
@@ -190,6 +191,21 @@
 	$(top_srcdir)/src/openvpn/platform.c
 endif

+options_parse_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_s=
rcdir)/src/compat @TEST_CFLAGS@
+options_parse_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/op=
envpn \
+	-Wl,--wrap=3Dadd_option \
+	-Wl,--wrap=3Dupdate_option \
+	-Wl,--wrap=3Dremove_option \
+	-Wl,--wrap=3Dusage
+options_parse_testdriver_SOURCES =3D test_options_parse.c \
+	mock_msg.c mock_msg.h test_common.h \
+	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/options_parse.c \
+	$(top_srcdir)/src/openvpn/options_util.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/platform.c
+
 provider_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tes=
ts/openvpn/test_options_parse.c
new file mode 100644
index 0000000..9472c78
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -0,0 +1,196 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 OpenVPN Inc <sales@...515...>
+ *
+ *  This program is free software; you can redistribute it and/or modify
+ *  it under the terms of the GNU General Public License version 2
+ *  as published by the Free Software Foundation.
+ *
+ *  This program is distributed in the hope that it will be useful,
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of
+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
+ *  GNU General Public License for more details.
+ *
+ *  You should have received a copy of the GNU General Public License along
+ *  with this program; if not, see <https://www.gnu.org/licenses/>.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include <stdio.h>
+#include <stdlib.h>
+#include <stdarg.h>
+#include <string.h>
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "options.h"
+#include "test_common.h"
+#include "mock_msg.h"
+
+void
+__wrap_add_option(struct options *options, char *p[], bool is_inline, cons=
t char *file,
+                  int line, const int level, const msglvl_t msglevel,
+                  const unsigned int permission_mask, unsigned int *option=
_types_found,
+                  struct env_set *es)
+{
+}
+
+void
+__wrap_remove_option(struct context *c, struct options *options, char *p[]=
, bool is_inline,
+                     const char *file, int line, const msglvl_t msglevel,
+                     const unsigned int permission_mask, unsigned int *opt=
ion_types_found,
+                     struct env_set *es)
+{
+}
+
+void
+__wrap_update_option(struct context *c, struct options *options, char *p[]=
, bool is_inline,
+                     const char *file, int line, const int level, const ms=
glvl_t msglevel,
+                     const unsigned int permission_mask, unsigned int *opt=
ion_types_found,
+                     struct env_set *es, unsigned int *update_options_foun=
d)
+{
+}
+
+void
+__wrap_usage(void)
+{
+}
+
+/* for building long texts */
+#define A_TIMES_256 "AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAO"
+
+static void
+test_parse_line(void **state)
+{
+    char *p[MAX_PARMS + 1] =3D { 0 };
+    struct gc_arena gc =3D gc_new();
+    int res =3D 0;
+
+#define PARSE_LINE_TST(string)                                            =
              \
+    do                                                                    =
              \
+    {                                                                     =
              \
+        CLEAR(p);                                                         =
              \
+        res =3D parse_line(string, p, SIZE(p) - 1, "test_options_parse", 1=
, M_INFO, &gc); \
+    } while (0);
+
+    /* basic example */
+    PARSE_LINE_TST("some-opt firstparm second-parm");
+    assert_int_equal(res, 3);
+    assert_string_equal(p[0], "some-opt");
+    assert_string_equal(p[1], "firstparm");
+    assert_string_equal(p[2], "second-parm");
+    assert_null(p[res]);
+
+    /* basic quoting, -- is not handled special */
+    PARSE_LINE_TST("--some-opt 'first parm' \"second' 'parm\"");
+    assert_int_equal(res, 3);
+    assert_string_equal(p[0], "--some-opt");
+    assert_string_equal(p[1], "first parm");
+    assert_string_equal(p[2], "second' 'parm");
+    assert_null(p[res]);
+
+    /* escaped quotes */
+    PARSE_LINE_TST("\"some opt\" 'first\" \"parm' \"second\\\" \\\"parm\""=
);
+    assert_int_equal(res, 3);
+    assert_string_equal(p[0], "some opt");
+    assert_string_equal(p[1], "first\" \"parm");
+    assert_string_equal(p[2], "second\" \"parm");
+    assert_null(p[res]);
+
+    /* missing closing quote */
+    PARSE_LINE_TST("--some-opt 'first parm \"second parm\"");
+    assert_int_equal(res, 0);
+
+    /* escaped backslash */
+    PARSE_LINE_TST("some\\\\opt C:\\\\directory\\\\file");
+    assert_int_equal(res, 2);
+    assert_string_equal(p[0], "some\\opt");
+    assert_string_equal(p[1], "C:\\directory\\file");
+    assert_null(p[res]);
+
+    /* comment chars are not special inside parameter */
+    PARSE_LINE_TST("some-opt firstparm; second#parm");
+    assert_int_equal(res, 3);
+    assert_string_equal(p[0], "some-opt");
+    assert_string_equal(p[1], "firstparm;");
+    assert_string_equal(p[2], "second#parm");
+    assert_null(p[res]);
+
+    /* comment */
+    PARSE_LINE_TST("some-opt firstparm # secondparm");
+    assert_int_equal(res, 2);
+    assert_string_equal(p[0], "some-opt");
+    assert_string_equal(p[1], "firstparm");
+    assert_null(p[res]);
+
+    /* parameter just long enough */
+    PARSE_LINE_TST("opt " A_TIMES_256);
+    assert_int_equal(res, 2);
+    assert_string_equal(p[0], "opt");
+    assert_string_equal(p[1], A_TIMES_256);
+    assert_null(p[res]);
+
+    /* quoting doesn't count for parameter length */
+    PARSE_LINE_TST("opt \"" A_TIMES_256 "\"");
+    assert_int_equal(res, 2);
+    assert_string_equal(p[0], "opt");
+    assert_string_equal(p[1], A_TIMES_256);
+    assert_null(p[res]);
+
+    /* very long line */
+    PARSE_LINE_TST("opt " A_TIMES_256 " " A_TIMES_256 " " A_TIMES_256 " " =
A_TIMES_256);
+    assert_int_equal(res, 5);
+    assert_string_equal(p[0], "opt");
+    assert_string_equal(p[1], A_TIMES_256);
+    assert_string_equal(p[2], A_TIMES_256);
+    assert_string_equal(p[3], A_TIMES_256);
+    assert_string_equal(p[4], A_TIMES_256);
+    assert_null(p[res]);
+
+    /* parameter too long */
+    PARSE_LINE_TST("opt " A_TIMES_256 "B");
+    assert_int_equal(res, 0);
+
+    /* max parameters */
+    PARSE_LINE_TST("0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15");
+    assert_int_equal(res, MAX_PARMS);
+    char num[3];
+    for (int i =3D 0; i < MAX_PARMS; i++)
+    {
+        assert_true(snprintf(num, 3, "%d", i) < 3);
+        assert_string_equal(p[i], num);
+    }
+    assert_null(p[res]);
+
+    /* too many parameters, overflow is ignored */
+    PARSE_LINE_TST("0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16");
+    assert_int_equal(res, MAX_PARMS);
+    for (int i =3D 0; i < MAX_PARMS; i++)
+    {
+        assert_true(snprintf(num, 3, "%d", i) < 3);
+        assert_string_equal(p[i], num);
+    }
+    assert_null(p[res]);
+
+    gc_free(&gc);
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_parse_line),
+    };
+
+    return cmocka_run_group_tests_name("options_parse", tests, NULL, NULL);
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1244?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I95032d2539d994abf69fc17319ed1a429c3bb948
Gerrit-Change-Number: 1244
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8rGFtK0bamU=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #4</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1244?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">test_options_parse: Start new UT fo=
r options_parse.c<br><br>For now contains one test case for parse_line.<br>=
<br>Change-Id: I95032d2539d994abf69fc17319ed1a429c3bb948<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/124=
4<br>Message-Id: &lt;20251008101014.5691-1-gert@...1296...&gt;<br>URL: http=
s://sourceforge.net/p/openvpn/mailman/message/59243816/<br>Signed-off-by: G=
ert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M tests/u=
nit_tests/openvpn/Makefile.am<br>A tests/unit_tests/openvpn/test_options_pa=
rse.c<br>3 files changed, 227 insertions(+), 0 deletions(-)<br><br></pre><p=
re class=3D"blocks" style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/44=
/1244/4</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><spa=
n>index aeef480..37bfc03 100644</span><br><span>--- a/CMakeLists.txt</span>=
<br><span>+++ b/CMakeLists.txt</span><br><span>@@ -685,6 +685,7 @@</span><b=
r><span>     # Clang-cl (which is also MSVC) is wrongly detected to support=
 wrap</span><br><span>     if (NOT MSVC AND &quot;${LD_SUPPORTS_WRAP}&quot;=
)</span><br><span>         list(APPEND unit_tests</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+            &quot;test_options_parse&quot;</s=
pan><br><span>             &quot;test_tls_crypt&quot;</span><br><span>     =
        )</span><br><span>     endif ()</span><br><span>@@ -826,6 +827,20 @=
@</span><br><span>         src/compat/compat-strsep.c</span><br><span>     =
    )</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    if (TARGET test_options_parse)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        target_link_options(test_options_parse PRIVATE</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+            -Wl,--wra=
p=3Dadd_option</span><br><span style=3D"color: hsl(120, 100%, 40%);">+     =
       -Wl,--wrap=3Dremove_option</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+            -Wl,--wrap=3Dupdate_option</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	    -Wl,--wrap=3Dusage</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+        target_sources(test_options_parse PRIVA=
TE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+            tests=
/unit_tests/openvpn/mock_get_random.c</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+            src/openvpn/options_parse.c</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+            src/openvpn/options_util.=
c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    endif ()</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     target_source=
s(test_packet_id PRIVATE</span><br><span>         tests/unit_tests/openvpn/=
mock_get_random.c</span><br><span>         src/openvpn/otime.c</span><br><s=
pan>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/op=
envpn/Makefile.am</span><br><span>index f7b1bc8..8e94665 100644</span><br><=
span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests=
/unit_tests/openvpn/Makefile.am</span><br><span>@@ -9,6 +9,7 @@</span><br><=
span> 	user_pass_testdriver push_update_msg_testdriver provider_testdriver =
socket_testdriver</span><br><span> </span><br><span> if HAVE_LD_WRAP_SUPPOR=
T</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_binaries +=3D=
 options_parse_testdriver</span><br><span> if !WIN32</span><br><span> test_=
binaries +=3D tls_crypt_testdriver</span><br><span> endif</span><br><span>@=
@ -190,6 +191,21 @@</span><br><span> 	$(top_srcdir)/src/openvpn/platform.c<=
/span><br><span> endif</span><br><span> </span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+options_parse_testdriver_CFLAGS  =3D -I$(top_srcdir)/s=
rc/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+options_parse_testdriver_LDFLAGS =3D @TES=
T_LDFLAGS@ -L$(top_srcdir)/src/openvpn \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	-Wl,--wrap=3Dadd_option \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	-Wl,--wrap=3Dupdate_option \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	-Wl,--wrap=3Dremove_option \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	-Wl,--wrap=3Dusage</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+options_parse_testdriver_SO=
URCES =3D test_options_parse.c \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	mock_msg.c mock_msg.h test_common.h \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mock_get_random.c \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/options_parse=
.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/=
src/openvpn/options_util.c \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/win32-util.c \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn=
/platform.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span> provider_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdi=
r)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><=
br><span> 	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)</span><br><span>diff --g=
it a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tests/openv=
pn/test_options_parse.c</span><br><span>new file mode 100644</span><br><spa=
n>index 0000000..9472c78</span><br><span>--- /dev/null</span><br><span>+++ =
b/tests/unit_tests/openvpn/test_options_parse.c</span><br><span>@@ -0,0 +1,=
196 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application =
to securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             over a single UDP port, with support for SSL/TLS-=
based</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *            =
 session authentication and key exchange,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             packet encryption, packet authenticati=
on, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *          =
   packet compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Copyright =
(C) 2025 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  This program is free software; you can redistribute it and/or m=
odify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under t=
he terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distribu=
ted in the hope that it will be useful,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied =
warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mo=
re details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, see &lt;https=
://www.gnu.org/licenses/&gt;.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &lt;stdio.h&gt;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#include &lt;stdlib.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;stdarg.h&gt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &lt;string.h&gt;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&g=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+#include &quot;options.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;test_commo=
n.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &=
quot;mock_msg.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+__wrap_add_option(struct options=
 *options, char *p[], bool is_inline, const char *file,</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+                  int line, const int l=
evel, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+                  const unsigned int permission_mask, unsigned i=
nt *option_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+                  struct env_set *es)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+__wrap_remove_option(struct context *c, struct o=
ptions *options, char *p[], bool is_inline,</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+                     const char *file, int line, co=
nst msglvl_t msglevel,</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+                     const unsigned int permission_mask, unsigned int *o=
ption_types_found,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
                    struct env_set *es)</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+__wrap_update_option(struct context *c, struct opt=
ions *options, char *p[], bool is_inline,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+                     const char *file, int line, cons=
t int level, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+                     const unsigned int permission_mask, =
unsigned int *option_types_found,</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+                     struct env_set *es, unsigned int *update=
_options_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+__wrap_usage(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* for building long texts */</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#define A_TIMES_256 &quot;AAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAA=
AAAAAAAAAAAO&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+test_parse_line(void **state=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    char *p[MAX_PARMS + 1] =3D { 0 }=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct gc_aren=
a gc =3D gc_new();</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   int res =3D 0;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define PARSE_LINE_TS=
T(string)                                                          \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    do                    =
                                                              \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    {                          =
                                                         \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        CLEAR(p);                   =
                                                    \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        res =3D parse_line(string, p, SIZ=
E(p) - 1, &quot;test_options_parse&quot;, 1, M_INFO, &amp;gc); \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    } while (0);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    /* basic example */</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    PARSE_LINE_TST(&quot;some-opt firstparm seco=
nd-parm&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(res, 3);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_string_equal(p[0], &quot;some-opt&quot;);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(p[1], &quot;=
firstparm&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  assert_string_equal(p[2], &quot;second-parm&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(p[res]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* basic quoting, -- is not handled special */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    PARSE_LINE_TST(&quot=
;--some-opt &#39;first parm&#39; \&quot;second&#39; &#39;parm\&quot;&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(res, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_string_equal(p[0], &quot;--some-opt&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_string_equal(p[1], &quot;first parm&q=
uot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_st=
ring_equal(p[2], &quot;second&#39; &#39;parm&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(p[res]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* escaped quotes */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    PARSE_LINE_TST(&quot;\&quot;some opt\&quot; &#=
39;first\&quot; \&quot;parm&#39; \&quot;second\\\&quot; \\\&quot;parm\&quot=
;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(res, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_string_equal(p[0], &quot;some opt&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(p[1], &quot;first=
\&quot; \&quot;parm&quot;);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_string_equal(p[2], &quot;second\&quot; \&quot;parm&quot;=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(p=
[res]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    /* missing closing quote */=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PARSE_LINE_TST(=
&quot;--some-opt &#39;first parm \&quot;second parm\&quot;&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(res, 0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* escaped backslash */</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    PARSE_LINE_TST(&quot;some=
\\\\opt C:\\\\directory\\\\file&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(res, 2);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(p[0], &quot;some\\opt=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
string_equal(p[1], &quot;C:\\directory\\file&quot;);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(p[res]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* comment chars are not special inside parameter *=
/</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PARSE_LINE_TST=
(&quot;some-opt firstparm; second#parm&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+    assert_int_equal(res, 3);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(p[0], &quot;so=
me-opt&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_string_equal(p[1], &quot;firstparm;&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(p[2], &quot;second#pa=
rm&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_null(p[res]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* comment */</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    PARSE_LINE_TST(&quot;=
some-opt firstparm # secondparm&quot;);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(res, 2);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_string_equal(p[0], &quot;some-opt&=
quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_s=
tring_equal(p[1], &quot;firstparm&quot;);</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    assert_null(p[res]);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    /* parameter just long enough */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    PARSE_LINE_TST(&quot;opt &quot; A_TIMES_256);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal=
(res, 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_string_equal(p[0], &quot;opt&quot;);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_string_equal(p[1], A_TIMES_256);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_null(p[res]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* quoting doesn&#39;t count for parameter =
length */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    PARSE_=
LINE_TST(&quot;opt \&quot;&quot; A_TIMES_256 &quot;\&quot;&quot;);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(res, 2)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_=
equal(p[0], &quot;opt&quot;);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_string_equal(p[1], A_TIMES_256);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_null(p[res]);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    /* very long line */</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    PARSE_LINE_TST(&quot;opt &quot; A_TIMES_256 &q=
uot; &quot; A_TIMES_256 &quot; &quot; A_TIMES_256 &quot; &quot; A_TIMES_256=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_eq=
ual(res, 5);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ass=
ert_string_equal(p[0], &quot;opt&quot;);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    assert_string_equal(p[1], A_TIMES_256);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_string_equal(p[2], =
A_TIMES_256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_string_equal(p[3], A_TIMES_256);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_string_equal(p[4], A_TIMES_256);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    assert_null(p[res]);</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    /* parameter too long */</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    PARSE_LINE_TST(&quot;opt &quot; A_=
TIMES_256 &quot;B&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(res, 0);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 /* max parameters */</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    PARSE_LINE_TST(&quot;0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15&quot;);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(r=
es, MAX_PARMS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
char num[3];</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    for=
 (int i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        assert_true(snprintf(num, 3, &quot;%d&quot;, i) &lt; 3);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_string_equa=
l(p[i], num);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(p[re=
s]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    /* too many parameters, overfl=
ow is ignored */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 PARSE_LINE_TST(&quot;0 1 2 3 4 5 6 7 8 9 10 11 12 13 14 15 16&quot;);</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(res=
, MAX_PARMS);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fo=
r (int i =3D 0; i &lt; MAX_PARMS; i++)</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        assert_true(snprintf(num, 3, &quot;%d&quot;, i) &lt; 3);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        assert_string_equ=
al(p[i], num);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_null(p[r=
es]);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+    gc_free(&amp;gc);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void=
)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    const struct CMUnitTest tests[] =
=3D {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka=
_unit_test(test_parse_line),</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    return cmocka_run_g=
roup_tests_name(&quot;options_parse&quot;, tests, NULL, NULL);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1244?=
usp=3Demail">change 1244</a>. To unsubscribe, or for help writing mail filt=
ers, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setti=
ngs</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div=
 itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><l=
ink itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1244?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I95032d2539d994abf69fc17319e=
d1a429c3bb948 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1244 </div>
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

--8rGFtK0bamU=--

