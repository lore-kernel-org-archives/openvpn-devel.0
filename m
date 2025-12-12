From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 12 Dec 2025 12:53:03 +0000
In-Reply-To: <gerrit.1765383841000.Icab68a5fd1b6288955f0073179f1ddde1468d951@...2715...>
References: <gerrit.1765383841000.Icab68a5fd1b6288955f0073179f1ddde1468d951@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <26b063e1705d511e73d52264dfe7be61dd9ec6d0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="EOoGleg+3z0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mbuf: Add unit tests
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

--EOoGleg+3z0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
32?usp=3Demail )

Change subject: mbuf: Add unit tests
......................................................................

mbuf: Add unit tests

While fixing the conversion warning I was
somewhat confused how this works, so added
UTs to verify I understood it.

v2:
 - disable assert test for MS VS
 - add define for memory-intensive UTs and
   only enable it by default for CMake builds,
   so we do not break a lot of builds out there
   due to memory allocation failures

Change-Id: Icab68a5fd1b6288955f0073179f1ddde1468d951
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1432
Message-Id: <20251212120352.17402-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
050.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M src/openvpn/mbuf.c
M src/openvpn/mbuf.h
M src/openvpn/options.c
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_buffer.c
A tests/unit_tests/openvpn/test_mbuf.c
7 files changed, 209 insertions(+), 5 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 906fa04..bdb1904 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -633,6 +633,7 @@
     endif ()
 endif ()

+option(UT_ALLOW_BIG_ALLOC "Allow unit-tests to use > 1 GB of memory" ON)

 if (BUILD_TESTING)
     find_package(cmocka CONFIG)
@@ -649,6 +650,7 @@
         "test_buffer"
         "test_crypto"
         "test_dhcp"
+        "test_mbuf"
         "test_misc"
         "test_ncp"
         "test_options_parse"
@@ -739,6 +741,9 @@
         # for compat with IDEs like Clion that ignore the tests properties
         # for the environment variable srcdir when running tests as fallba=
ck
         target_compile_definitions(${test_name} PRIVATE "UNIT_TEST_SOURCED=
IR=3D\"${_UT_SOURCE_DIR}\"")
+        if (UT_ALLOW_BIG_ALLOC)
+            target_compile_definitions(${test_name} PRIVATE UNIT_TEST_ALLO=
W_BIG_ALLOC)
+        endif ()

         if (NOT ${test_name} STREQUAL "test_buffer")
             target_sources(${test_name} PRIVATE
@@ -800,6 +805,12 @@
             src/openvpn/xkey_provider.c
     )

+    target_sources(test_mbuf PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        src/openvpn/buffer.c
+        src/openvpn/mbuf.c
+        )
+
     target_sources(test_misc PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
         src/openvpn/options_util.c
diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c
index 448124c..42858ec 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -42,6 +42,8 @@
 struct mbuf_set *
 mbuf_init(unsigned int size)
 {
+    ASSERT(size <=3D MBUF_SIZE_MAX);
+
     struct mbuf_set *ret;
     ALLOC_OBJ_CLEAR(ret, struct mbuf_set);
     ret->capacity =3D adjust_power_of_2(size);
@@ -121,6 +123,7 @@
     bool ret =3D false;
     if (ms)
     {
+        ASSERT(item);
         while (ms->len)
         {
             *item =3D ms->array[ms->head];
diff --git a/src/openvpn/mbuf.h b/src/openvpn/mbuf.h
index 7f8c1b7..f741e21 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -36,6 +36,8 @@
 struct multi_instance;

 #define MBUF_INDEX(head, offset, size) (((head) + (offset)) & ((size) - 1))
+/* limited by adjust_power_of_2 and array_mult_safe */
+#define MBUF_SIZE_MAX                  (ALLOC_SIZE_MAX / sizeof(struct mbu=
f_item))

 struct mbuf_buffer
 {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index d01ec47..24c3e92 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -62,6 +62,7 @@
 #include "options_util.h"
 #include "tun_afunix.h"
 #include "domain_helper.h"
+#include "mbuf.h"

 #include <ctype.h>

@@ -7552,7 +7553,7 @@
     else if (streq(p[0], "bcast-buffers") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        atoi_constrained(p[1], &options->n_bcast_buf, p[0], 1, INT_MAX, ms=
glevel);
+        atoi_constrained(p[1], &options->n_bcast_buf, p[0], 1, MBUF_SIZE_M=
AX, msglevel);
     }
     else if (streq(p[0], "tcp-queue-limit") && p[1] && !p[2])
     {
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 0f13172..7aeea47 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -6,9 +6,22 @@

 AM_TESTS_ENVIRONMENT =3D export LSAN_OPTIONS=3Dsuppressions=3D$(srcdir)/in=
put/leak_suppr.txt;

-test_binaries =3D argv_testdriver buffer_testdriver crypto_testdriver dhcp=
_testdriver packet_id_testdriver auth_token_testdriver \
-	ncp_testdriver misc_testdriver options_parse_testdriver pkt_testdriver ss=
l_testdriver \
-	user_pass_testdriver push_update_msg_testdriver provider_testdriver socke=
t_testdriver
+test_binaries =3D argv_testdriver \
+	auth_token_testdriver \
+	buffer_testdriver \
+	crypto_testdriver \
+	dhcp_testdriver \
+	ncp_testdriver \
+	mbuf_testdriver \
+	misc_testdriver \
+	options_parse_testdriver \
+	packet_id_testdriver \
+	pkt_testdriver \
+	provider_testdriver \
+	push_update_msg_testdriver \
+	socket_testdriver \
+	ssl_testdriver \
+	user_pass_testdriver

 if HAVE_LD_WRAP_SUPPORT
 if !WIN32
@@ -327,6 +340,20 @@
 	$(top_srcdir)/src/compat/compat-strsep.c \
 	$(top_srcdir)/src/openvpn/ssl_util.c
=20
+mbuf_testdriver_CFLAGS  =3D \
+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
+	-DSOURCEDIR=3D\"$(top_srcdir)\" @TEST_CFLAGS@
+
+mbuf_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
+
+mbuf_testdriver_SOURCES =3D test_mbuf.c \
+	mock_msg.c test_common.h  \
+	mock_get_random.c \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/win32-util.c \
+	$(top_srcdir)/src/openvpn/platform.c \
+	$(top_srcdir)/src/openvpn/mbuf.c
+
 misc_testdriver_CFLAGS  =3D \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	-DSOURCEDIR=3D\"$(top_srcdir)\" @TEST_CFLAGS@
diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/open=
vpn/test_buffer.c
index 25a8def..8855e5b 100644
--- a/tests/unit_tests/openvpn/test_buffer.c
+++ b/tests/unit_tests/openvpn/test_buffer.c
@@ -386,7 +386,7 @@

     /* Instead of trying to trick the compiler here, disable the warnings
      * for this unit test. We know that the results will be truncated
-     * and we want to test that. Not we need the clang as clang-cl (msvc) =
does
+     * and we want to test that. Note we need the clang as clang-cl (msvc)=
 does
      * not define __GNUC__ like it does under UNIX(-like) platforms */
 #if defined(__GNUC__) || defined(__clang__)
 /* some clang version do not understand -Wformat-truncation, so ignore the
diff --git a/tests/unit_tests/openvpn/test_mbuf.c b/tests/unit_tests/openvp=
n/test_mbuf.c
new file mode 100644
index 0000000..cba4da7
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_mbuf.c
@@ -0,0 +1,160 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2025 OpenVPN Inc. <sales@...2722...>
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
+#include <setjmp.h>
+#include <cmocka.h>
+
+#include "buffer.h"
+#include "multi.h"
+#include "mbuf.h"
+#include "test_common.h"
+
+static void
+test_mbuf_init(void **state)
+{
+    struct mbuf_set *ms =3D mbuf_init(256);
+    assert_int_equal(ms->capacity, 256);
+    assert_false(mbuf_defined(ms));
+    assert_non_null(ms->array);
+    mbuf_free(ms);
+
+    ms =3D mbuf_init(257);
+    assert_int_equal(ms->capacity, 512);
+    mbuf_free(ms);
+
+#ifdef UNIT_TEST_ALLOW_BIG_ALLOC /* allocates up to 2GB of memory */
+    ms =3D mbuf_init(MBUF_SIZE_MAX);
+    assert_int_equal(ms->capacity, MBUF_SIZE_MAX);
+    mbuf_free(ms);
+
+/* NOTE: expect_assert_failure does not seem to work with MSVC */
+#ifndef _MSC_VER
+    expect_assert_failure(mbuf_init(MBUF_SIZE_MAX + 1));
+#endif
+#endif
+}
+
+static void
+test_mbuf_add_remove(void **state)
+{
+    struct mbuf_set *ms =3D mbuf_init(4);
+    assert_int_equal(ms->capacity, 4);
+    assert_false(mbuf_defined(ms));
+    assert_non_null(ms->array);
+
+    /* instances */
+    struct multi_instance mi =3D { 0 };
+    struct multi_instance mi2 =3D { 0 };
+    /* buffers */
+    struct buffer buf =3D alloc_buf(16);
+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&buf);
+    assert_int_equal(mbuf_buf->refcount, 1);
+    struct mbuf_buffer *mbuf_buf2 =3D mbuf_alloc_buf(&buf);
+    assert_int_equal(mbuf_buf2->refcount, 1);
+    free_buf(&buf);
+    /* items */
+    struct mbuf_item mb_item =3D { .buffer =3D mbuf_buf, .instance =3D &mi=
 };
+    struct mbuf_item mb_item2 =3D { .buffer =3D mbuf_buf2, .instance =3D &=
mi2 };
+
+    mbuf_add_item(ms, &mb_item);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 1);
+    assert_int_equal(mbuf_len(ms), 1);
+    assert_int_equal(mbuf_maximum_queued(ms), 1);
+    assert_int_equal(ms->head, 0);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_add_item(ms, &mb_item2);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 2);
+    assert_int_equal(mbuf_len(ms), 2);
+    assert_int_equal(mbuf_maximum_queued(ms), 2);
+    assert_int_equal(ms->head, 0);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_add_item(ms, &mb_item2);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 3);
+    assert_int_equal(mbuf_len(ms), 3);
+    assert_int_equal(mbuf_maximum_queued(ms), 3);
+    assert_int_equal(ms->head, 0);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_add_item(ms, &mb_item2);
+    mbuf_add_item(ms, &mb_item2); /* overflow, first item gets removed */
+    assert_int_equal(mbuf_buf->refcount, 1);
+    assert_int_equal(mbuf_buf2->refcount, 5);
+    assert_int_equal(mbuf_len(ms), 4);
+    assert_int_equal(mbuf_maximum_queued(ms), 4);
+    assert_int_equal(ms->head, 1);
+    assert_ptr_equal(mbuf_peek(ms), &mi2);
+
+    mbuf_add_item(ms, &mb_item);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 4);
+    assert_int_equal(mbuf_len(ms), 4);
+    assert_int_equal(mbuf_maximum_queued(ms), 4);
+    assert_int_equal(ms->head, 2);
+    assert_ptr_equal(mbuf_peek(ms), &mi2);
+
+    struct mbuf_item out_item;
+    assert_true(mbuf_extract_item(ms, &out_item));
+    assert_ptr_equal(out_item.instance, mb_item2.instance);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 4);
+    assert_int_equal(mbuf_len(ms), 3);
+    assert_int_equal(mbuf_maximum_queued(ms), 4);
+    assert_int_equal(ms->head, 3);
+    assert_ptr_equal(mbuf_peek(ms), &mi2);
+    mbuf_free_buf(out_item.buffer);
+
+    mbuf_dereference_instance(ms, &mi2);
+    assert_int_equal(mbuf_buf->refcount, 2);
+    assert_int_equal(mbuf_buf2->refcount, 1);
+    assert_int_equal(mbuf_len(ms), 3);
+    assert_int_equal(mbuf_maximum_queued(ms), 4);
+    assert_int_equal(ms->head, 3);
+    assert_ptr_equal(mbuf_peek(ms), &mi);
+
+    mbuf_free(ms);
+    assert_int_equal(mbuf_buf->refcount, 1);
+    mbuf_free_buf(mbuf_buf);
+    assert_int_equal(mbuf_buf2->refcount, 1);
+    mbuf_free_buf(mbuf_buf2);
+}
+
+int
+main(void)
+{
+    const struct CMUnitTest tests[] =3D {
+        cmocka_unit_test(test_mbuf_init),
+        cmocka_unit_test(test_mbuf_add_remove),
+    };
+
+    return cmocka_run_group_tests_name("mbuf", tests, NULL, NULL);
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1432?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icab68a5fd1b6288955f0073179f1ddde1468d951
Gerrit-Change-Number: 1432
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--EOoGleg+3z0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1432?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">mbuf: Add unit tests<br><br>While fixing the con=
version warning I was<br>somewhat confused how this works, so added<br>UTs =
to verify I understood it.<br><br>v2:<br> - disable assert test for MS VS<b=
r> - add define for memory-intensive UTs and<br>   only enable it by defaul=
t for CMake builds,<br>   so we do not break a lot of builds out there<br> =
  due to memory allocation failures<br><br>Change-Id: Icab68a5fd1b6288955f0=
073179f1ddde1468d951<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2724...=
..&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: htt=
ps://gerrit.openvpn.net/c/openvpn/+/1432<br>Message-Id: &lt;20251212120352.=
17402-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-de=
vel@lists.sourceforge.net/msg35050.html<br>Signed-off-by: Gert Doering &lt;=
gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M src/openvpn/mbuf.c<br>M=
 src/openvpn/mbuf.h<br>M src/openvpn/options.c<br>M tests/unit_tests/openvp=
n/Makefile.am<br>M tests/unit_tests/openvpn/test_buffer.c<br>A tests/unit_t=
ests/openvpn/test_mbuf.c<br>7 files changed, 209 insertions(+), 5 deletions=
(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 906fa=
04..bdb1904 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -633,6 +633,7 @@</span><br><span>     =
endif ()</span><br><span> endif ()</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+option(UT_ALLOW_BIG_ALLOC &quot;Allow uni=
t-tests to use &gt; 1 GB of memory&quot; ON)</span><br><span> </span><br><s=
pan> if (BUILD_TESTING)</span><br><span>     find_package(cmocka CONFIG)</s=
pan><br><span>@@ -649,6 +650,7 @@</span><br><span>         &quot;test_buffe=
r&quot;</span><br><span>         &quot;test_crypto&quot;</span><br><span>  =
       &quot;test_dhcp&quot;</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        &quot;test_mbuf&quot;</span><br><span>         &quot;test_=
misc&quot;</span><br><span>         &quot;test_ncp&quot;</span><br><span>  =
       &quot;test_options_parse&quot;</span><br><span>@@ -739,6 +741,9 @@</=
span><br><span>         # for compat with IDEs like Clion that ignore the t=
ests properties</span><br><span>         # for the environment variable src=
dir when running tests as fallback</span><br><span>         target_compile_=
definitions(${test_name} PRIVATE &quot;UNIT_TEST_SOURCEDIR=3D\&quot;${_UT_S=
OURCE_DIR}\&quot;&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        if (UT_ALLOW_BIG_ALLOC)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+            target_compile_definitions(${test_name} PRIVAT=
E UNIT_TEST_ALLOW_BIG_ALLOC)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        endif ()</span><br><span> </span><br><span>         if (NO=
T ${test_name} STREQUAL &quot;test_buffer&quot;)</span><br><span>          =
   target_sources(${test_name} PRIVATE</span><br><span>@@ -800,6 +805,12 @@=
</span><br><span>             src/openvpn/xkey_provider.c</span><br><span> =
    )</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    target_sources(test_mbuf PRIVATE</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        tests/unit_tests/openvpn/mock_get_random.c</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/buf=
fer.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/op=
envpn/mbuf.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 )</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>=
     target_sources(test_misc PRIVATE</span><br><span>         tests/unit_t=
ests/openvpn/mock_get_random.c</span><br><span>         src/openvpn/options=
_util.c</span><br><span>diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.=
c</span><br><span>index 448124c..42858ec 100644</span><br><span>--- a/src/o=
penvpn/mbuf.c</span><br><span>+++ b/src/openvpn/mbuf.c</span><br><span>@@ -=
42,6 +42,8 @@</span><br><span> struct mbuf_set *</span><br><span> mbuf_init=
(unsigned int size)</span><br><span> {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    ASSERT(size &lt;=3D MBUF_SIZE_MAX);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     struct mbuf_se=
t *ret;</span><br><span>     ALLOC_OBJ_CLEAR(ret, struct mbuf_set);</span><=
br><span>     ret-&gt;capacity =3D adjust_power_of_2(size);</span><br><span=
>@@ -121,6 +123,7 @@</span><br><span>     bool ret =3D false;</span><br><sp=
an>     if (ms)</span><br><span>     {</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        ASSERT(item);</span><br><span>         while (ms=
-&gt;len)</span><br><span>         {</span><br><span>             *item =3D=
 ms-&gt;array[ms-&gt;head];</span><br><span>diff --git a/src/openvpn/mbuf.h=
 b/src/openvpn/mbuf.h</span><br><span>index 7f8c1b7..f741e21 100644</span><=
br><span>--- a/src/openvpn/mbuf.h</span><br><span>+++ b/src/openvpn/mbuf.h<=
/span><br><span>@@ -36,6 +36,8 @@</span><br><span> struct multi_instance;</=
span><br><span> </span><br><span> #define MBUF_INDEX(head, offset, size) ((=
(head) + (offset)) &amp; ((size) - 1))</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+/* limited by adjust_power_of_2 and array_mult_safe */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define MBUF_SIZE_MAX=
                  (ALLOC_SIZE_MAX / sizeof(struct mbuf_item))</span><br><sp=
an> </span><br><span> struct mbuf_buffer</span><br><span> {</span><br><span=
>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</span><br><span=
>index d01ec47..24c3e92 100644</span><br><span>--- a/src/openvpn/options.c<=
/span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -62,6 +62,7 =
@@</span><br><span> #include &quot;options_util.h&quot;</span><br><span> #i=
nclude &quot;tun_afunix.h&quot;</span><br><span> #include &quot;domain_help=
er.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;mbuf.h&quot;</span><br><span> </span><br><span> #include &lt;ctype.h&=
gt;</span><br><span> </span><br><span>@@ -7552,7 +7553,7 @@</span><br><span=
>     else if (streq(p[0], &quot;bcast-buffers&quot;) &amp;&amp; p[1] &amp;=
&amp; !p[2])</span><br><span>     {</span><br><span>         VERIFY_PERMISS=
ION(OPT_P_GENERAL);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-  =
      atoi_constrained(p[1], &amp;options-&gt;n_bcast_buf, p[0], 1, INT_MAX=
, msglevel);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+       =
 atoi_constrained(p[1], &amp;options-&gt;n_bcast_buf, p[0], 1, MBUF_SIZE_MA=
X, msglevel);</span><br><span>     }</span><br><span>     else if (streq(p[=
0], &quot;tcp-queue-limit&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><b=
r><span>     {</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefi=
le.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>index 0f13172.=
.7aeea47 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am<=
/span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>=
@@ -6,9 +6,22 @@</span><br><span> </span><br><span> AM_TESTS_ENVIRONMENT =
=3D export LSAN_OPTIONS=3Dsuppressions=3D$(srcdir)/input/leak_suppr.txt;</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_b=
inaries =3D argv_testdriver buffer_testdriver crypto_testdriver dhcp_testdr=
iver packet_id_testdriver auth_token_testdriver \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	ncp_testdriver misc_testdriver options_parse_t=
estdriver pkt_testdriver ssl_testdriver \</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-	user_pass_testdriver push_update_msg_testdriver provid=
er_testdriver socket_testdriver</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+test_binaries =3D argv_testdriver \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	auth_token_testdriver \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	buffer_testdriver \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	crypto_testdriver \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+	dhcp_testdriver \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	ncp_testdriver \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mbuf_testdriver \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	misc_testdriver \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	options_parse_testdriver \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	packet_id_testdriver \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	pkt_testdriver \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	provider_testdriver \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+	push_update_msg_testdriver =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	socket_testdriver=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	ssl_testdriver \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	user_pass_testdriv=
er</span><br><span> </span><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><sp=
an> if !WIN32</span><br><span>@@ -327,6 +340,20 @@</span><br><span> 	$(top_=
srcdir)/src/compat/compat-strsep.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/ssl_util.c</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+mbuf_testdriver_CFLAGS  =3D \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compa=
t -I$(top_srcdir)/src/openvpn \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	-DSOURCEDIR=3D\&quot;$(top_srcdir)\&quot; @TEST_CFLAGS@</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+mbuf_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+mbuf_testdriver_SOURCES =3D test_mbuf.c \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_co=
mmon.h  \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_get_=
random.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_sr=
cdir)/src/openvpn/buffer.c \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/win32-util.c \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform.c \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openv=
pn/mbuf.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span> misc_testdriver_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/inc=
lude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><sp=
an> 	-DSOURCEDIR=3D\&quot;$(top_srcdir)\&quot; @TEST_CFLAGS@</span><br><spa=
n>diff --git a/tests/unit_tests/openvpn/test_buffer.c b/tests/unit_tests/op=
envpn/test_buffer.c</span><br><span>index 25a8def..8855e5b 100644</span><br=
><span>--- a/tests/unit_tests/openvpn/test_buffer.c</span><br><span>+++ b/t=
ests/unit_tests/openvpn/test_buffer.c</span><br><span>@@ -386,7 +386,7 @@</=
span><br><span> </span><br><span>     /* Instead of trying to trick the com=
piler here, disable the warnings</span><br><span>      * for this unit test=
. We know that the results will be truncated</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-     * and we want to test that. Not we need the cla=
ng as clang-cl (msvc) does</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+     * and we want to test that. Note we need the clang as clang-cl =
(msvc) does</span><br><span>      * not define __GNUC__ like it does under =
UNIX(-like) platforms */</span><br><span> #if defined(__GNUC__) || defined(=
__clang__)</span><br><span> /* some clang version do not understand -Wforma=
t-truncation, so ignore the</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_mbuf.c b/tests/unit_tests/openvpn/test_mbuf.c</span><br><span>n=
ew file mode 100644</span><br><span>index 0000000..cba4da7</span><br><span>=
--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/test_mbuf.c</s=
pan><br><span>@@ -0,0 +1,160 @@</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  O=
penVPN -- An application to securely tunnel IP networks</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, =
with support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             session authentication and key exchange,</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encryp=
tion, packet authentication, and</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *             packet compression.</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc. &lt;sales@...2722...&gt;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+ *  This program is free software; you c=
an redistribute it and/or modify</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  it under the terms of the GNU General Public License versi=
on 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as publishe=
d by the Free Software Foundation.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
  This program is distributed in the hope that it will be useful,</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY;=
 without even the implied warranty of</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE. =
 See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU Gen=
eral Public License for more details.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  You should have received a copy of the GNU General Public License alon=
g</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this prog=
ram; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#include &quot;config.h&quot;</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshe=
ad.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setjmp.h&gt;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;cmocka.h&=
gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer.h&quot;</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;multi.h&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;m=
buf.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include=
 &quot;test_common.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static void<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_mbuf_init(void =
**state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_set *ms =3D m=
buf_init(256);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    a=
ssert_int_equal(ms-&gt;capacity, 256);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_false(mbuf_defined(ms));</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(ms-&gt;array);</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(ms);</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    ms =3D mbuf_init(257);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ms-&gt;capacity, =
512);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(=
ms);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#ifdef UNIT_TEST_ALLOW_BIG_ALLOC /=
* allocates up to 2GB of memory */</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    ms =3D mbuf_init(MBUF_SIZE_MAX);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ms-&gt;capacity, MBU=
F_SIZE_MAX);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbu=
f_free(ms);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+/* NOTE: expect_assert_fail=
ure does not seem to work with MSVC */</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+#ifndef _MSC_VER</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    expect_assert_failure(mbuf_init(MBUF_SIZE_MAX + 1));</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+static voi=
d</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_mbuf_add_remo=
ve(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_set *=
ms =3D mbuf_init(4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    assert_int_equal(ms-&gt;capacity, 4);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_false(mbuf_defined(ms));</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(ms-&gt;array);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    /* instances */</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    struct multi_instance mi =3D { 0 };<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_ins=
tance mi2 =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    /* buffers */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   struct buffer buf =3D alloc_buf(16);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    struct mbuf_buffer *mbuf_buf =3D mbuf_alloc_buf(&am=
p;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(mbuf_buf-&gt;refcount, 1);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    struct mbuf_buffer *mbuf_buf2 =3D mbuf_alloc_buf(&amp;b=
uf);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(mbuf_buf2-&gt;refcount, 1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    free_buf(&amp;buf);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    /* items */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    struct mbuf_item mb_item =3D { .buffer =3D mbuf_buf, .ins=
tance =3D &amp;mi };</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+    struct mbuf_item mb_item2 =3D { .buffer =3D mbuf_buf2, .instance =3D &=
amp;mi2 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;m=
b_item);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(mbuf_buf-&gt;refcount, 2);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;refcount, 1);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len=
(ms), 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(mbuf_maximum_queued(ms), 1);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 0);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &=
amp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;mb_=
item2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(mbuf_buf-&gt;refcount, 2);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;refcount, 2);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(=
ms), 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(mbuf_maximum_queued(ms), 2);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 0);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &a=
mp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;mb_i=
tem2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_in=
t_equal(mbuf_buf-&gt;refcount, 2);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;refcount, 3);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(m=
s), 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(mbuf_maximum_queued(ms), 3);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 0);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &am=
p;mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;mb_it=
em2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_i=
tem(ms, &amp;mb_item2); /* overflow, first item gets removed */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf-&=
gt;refcount, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_int_equal(mbuf_buf2-&gt;refcount, 5);</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 4);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_maxi=
mum_queued(ms), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    assert_int_equal(ms-&gt;head, 1);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &amp;mi2);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;mb_item);</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf-&g=
t;refcount, 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_int_equal(mbuf_buf2-&gt;refcount, 4);</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 4);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_maxim=
um_queued(ms), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ =
   assert_int_equal(ms-&gt;head, 2);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &amp;mi2);</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+    struct mbuf_item out_item;</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_true(mbuf_extract_item(ms, &=
amp;out_item));</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    =
assert_ptr_equal(out_item.instance, mb_item2.instance);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf-&gt;refco=
unt, 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(mbuf_buf2-&gt;refcount, 4);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 3);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_maximum_queu=
ed(ms), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asse=
rt_int_equal(ms-&gt;head, 3);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &amp;mi2);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(out_item.buffer);</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mbuf_dereference_instance(ms, &amp;mi=
2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_e=
qual(mbuf_buf-&gt;refcount, 2);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;refcount, 1);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms),=
 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_=
equal(mbuf_maximum_queued(ms), 4);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    assert_int_equal(ms-&gt;head, 3);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &amp;=
mi);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(ms);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf-&gt;r=
efcount, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbu=
f_free_buf(mbuf_buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    assert_int_equal(mbuf_buf2-&gt;refcount, 1);</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(mbuf_buf2);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+main(void)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    const struct CMUnitTest tests[] =3D=
 {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        cmocka_un=
it_test(test_mbuf_init),</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+        cmocka_unit_test(test_mbuf_add_remove),</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+    return cmocka_run_group_tests_name(&quot;mbuf&quot;, tests, NULL, NUL=
L);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><spa=
n></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1432?usp=3Demail">change 1432</a>. To unsubscribe, or for help w=
riting mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?us=
p=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Em=
ailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.or=
g/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1432?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/=
></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icab68a5fd1b6288955f0073179f=
1ddde1468d951 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1432 </div>
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

--EOoGleg+3z0=--

