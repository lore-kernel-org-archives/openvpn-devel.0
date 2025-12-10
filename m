From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 10 Dec 2025 16:24:12 +0000
References: <gerrit.1765383841000.Icab68a5fd1b6288955f0073179f1ddde1468d951@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3b2e3d9f98cc44103d2e35be4e072f3a68ec1494-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="6bDWn1DnjOM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: mbuf: Add unit tests
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

--6bDWn1DnjOM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1432?usp=3Demail

to review the following change.


Change subject: mbuf: Add unit tests
......................................................................

mbuf: Add unit tests

While fixing the conversion warning I was
somewhat confused how this works, so added
UTs to verify I understood it.

Change-Id: Icab68a5fd1b6288955f0073179f1ddde1468d951
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M src/openvpn/mbuf.c
M src/openvpn/mbuf.h
M src/openvpn/options.c
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/test_mbuf.c
6 files changed, 200 insertions(+), 4 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/32/1432/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 906fa04..4d802c3 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -649,6 +649,7 @@
         "test_buffer"
         "test_crypto"
         "test_dhcp"
+        "test_mbuf"
         "test_misc"
         "test_ncp"
         "test_options_parse"
@@ -800,6 +801,12 @@
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
index 448124c..1785d26 100644
--- a/src/openvpn/mbuf.c
+++ b/src/openvpn/mbuf.c
@@ -42,6 +42,8 @@
 struct mbuf_set *
 mbuf_init(unsigned int size)
 {
+    ASSERT(size <=3D MBUF_MAX_SIZE);
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
index 7f8c1b7..c048586 100644
--- a/src/openvpn/mbuf.h
+++ b/src/openvpn/mbuf.h
@@ -36,6 +36,9 @@
 struct multi_instance;

 #define MBUF_INDEX(head, offset, size) (((head) + (offset)) & ((size) - 1))
+/* limited by adjust_power_of_2 and array_mult_safe */
+#define MBUF_MAX_POW2                  (1u << ((sizeof(unsigned int) * 8) =
- 1))
+#define MBUF_MAX_SIZE                  (MBUF_MAX_POW2 / sizeof(struct mbuf=
_item))

 struct mbuf_buffer
 {
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 2d1f740..924c1d4 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -62,6 +62,7 @@
 #include "options_util.h"
 #include "tun_afunix.h"
 #include "domain_helper.h"
+#include "mbuf.h"

 #include <ctype.h>

@@ -7555,7 +7556,7 @@
     else if (streq(p[0], "bcast-buffers") && p[1] && !p[2])
     {
         VERIFY_PERMISSION(OPT_P_GENERAL);
-        atoi_constrained(p[1], &options->n_bcast_buf, p[0], 1, INT_MAX, ms=
glevel);
+        atoi_constrained(p[1], &options->n_bcast_buf, p[0], 1, MBUF_MAX_SI=
ZE, msglevel);
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
diff --git a/tests/unit_tests/openvpn/test_mbuf.c b/tests/unit_tests/openvp=
n/test_mbuf.c
new file mode 100644
index 0000000..8806697
--- /dev/null
+++ b/tests/unit_tests/openvpn/test_mbuf.c
@@ -0,0 +1,155 @@
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
+    ms =3D mbuf_init(MBUF_MAX_SIZE);
+    assert_int_equal(ms->capacity, MBUF_MAX_SIZE);
+    mbuf_free(ms);
+
+    expect_assert_failure(mbuf_init(MBUF_MAX_SIZE + 1));
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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Icab68a5fd1b6288955f0073179f1ddde1468d951
Gerrit-Change-Number: 1432
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--6bDWn1DnjOM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1432?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">mbuf: Add unit tests<br><br>While fixing th=
e conversion warning I was<br>somewhat confused how this works, so added<br=
>UTs to verify I understood it.<br><br>Change-Id: Icab68a5fd1b6288955f00731=
79f1ddde1468d951<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>---<br>M CMakeLists.txt<br>M src/openvpn/mbuf.c<br>M src/openvpn/mbuf=
.h<br>M src/openvpn/options.c<br>M tests/unit_tests/openvpn/Makefile.am<br>=
A tests/unit_tests/openvpn/test_mbuf.c<br>6 files changed, 200 insertions(+=
), 4 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: =
monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.=
net:29418/openvpn refs/changes/32/1432/1</pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.tx=
t b/CMakeLists.txt</span><br><span>index 906fa04..4d802c3 100644</span><br>=
<span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><=
span>@@ -649,6 +649,7 @@</span><br><span>         &quot;test_buffer&quot;</=
span><br><span>         &quot;test_crypto&quot;</span><br><span>         &q=
uot;test_dhcp&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        &quot;test_mbuf&quot;</span><br><span>         &quot;test_misc&quot=
;</span><br><span>         &quot;test_ncp&quot;</span><br><span>         &q=
uot;test_options_parse&quot;</span><br><span>@@ -800,6 +801,12 @@</span><br=
><span>             src/openvpn/xkey_provider.c</span><br><span>     )</spa=
n><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ta=
rget_sources(test_mbuf PRIVATE</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+        tests/unit_tests/openvpn/mock_get_random.c</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/buffer.c</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/mbuf=
.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>     targe=
t_sources(test_misc PRIVATE</span><br><span>         tests/unit_tests/openv=
pn/mock_get_random.c</span><br><span>         src/openvpn/options_util.c</s=
pan><br><span>diff --git a/src/openvpn/mbuf.c b/src/openvpn/mbuf.c</span><b=
r><span>index 448124c..1785d26 100644</span><br><span>--- a/src/openvpn/mbu=
f.c</span><br><span>+++ b/src/openvpn/mbuf.c</span><br><span>@@ -42,6 +42,8=
 @@</span><br><span> struct mbuf_set *</span><br><span> mbuf_init(unsigned =
int size)</span><br><span> {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    ASSERT(size &lt;=3D MBUF_MAX_SIZE);</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+</span><br><span>     struct mbuf_set *ret;</s=
pan><br><span>     ALLOC_OBJ_CLEAR(ret, struct mbuf_set);</span><br><span> =
    ret-&gt;capacity =3D adjust_power_of_2(size);</span><br><span>@@ -121,6=
 +123,7 @@</span><br><span>     bool ret =3D false;</span><br><span>     if=
 (ms)</span><br><span>     {</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+        ASSERT(item);</span><br><span>         while (ms-&gt;len)<=
/span><br><span>         {</span><br><span>             *item =3D ms-&gt;ar=
ray[ms-&gt;head];</span><br><span>diff --git a/src/openvpn/mbuf.h b/src/ope=
nvpn/mbuf.h</span><br><span>index 7f8c1b7..c048586 100644</span><br><span>-=
-- a/src/openvpn/mbuf.h</span><br><span>+++ b/src/openvpn/mbuf.h</span><br>=
<span>@@ -36,6 +36,9 @@</span><br><span> struct multi_instance;</span><br><=
span> </span><br><span> #define MBUF_INDEX(head, offset, size) (((head) + (=
offset)) &amp; ((size) - 1))</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+/* limited by adjust_power_of_2 and array_mult_safe */</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#define MBUF_MAX_POW2          =
        (1u &lt;&lt; ((sizeof(unsigned int) * 8) - 1))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#define MBUF_MAX_SIZE                  (=
MBUF_MAX_POW2 / sizeof(struct mbuf_item))</span><br><span> </span><br><span=
> struct mbuf_buffer</span><br><span> {</span><br><span>diff --git a/src/op=
envpn/options.c b/src/openvpn/options.c</span><br><span>index 2d1f740..924c=
1d4 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>+++ =
b/src/openvpn/options.c</span><br><span>@@ -62,6 +62,7 @@</span><br><span> =
#include &quot;options_util.h&quot;</span><br><span> #include &quot;tun_afu=
nix.h&quot;</span><br><span> #include &quot;domain_helper.h&quot;</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;mbuf.h&quot;</=
span><br><span> </span><br><span> #include &lt;ctype.h&gt;</span><br><span>=
 </span><br><span>@@ -7555,7 +7556,7 @@</span><br><span>     else if (streq=
(p[0], &quot;bcast-buffers&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><=
br><span>     {</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL);<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-        atoi_constrain=
ed(p[1], &amp;options-&gt;n_bcast_buf, p[0], 1, INT_MAX, msglevel);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        atoi_constrained(p[=
1], &amp;options-&gt;n_bcast_buf, p[0], 1, MBUF_MAX_SIZE, msglevel);</span>=
<br><span>     }</span><br><span>     else if (streq(p[0], &quot;tcp-queue-=
limit&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span=
><br><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_t=
ests/openvpn/Makefile.am</span><br><span>index 0f13172..7aeea47 100644</spa=
n><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ =
b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -6,9 +6,22 @@</sp=
an><br><span> </span><br><span> AM_TESTS_ENVIRONMENT =3D export LSAN_OPTION=
S=3Dsuppressions=3D$(srcdir)/input/leak_suppr.txt;</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-test_binaries =3D argv_testd=
river buffer_testdriver crypto_testdriver dhcp_testdriver packet_id_testdri=
ver auth_token_testdriver \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	ncp_testdriver misc_testdriver options_parse_testdriver pkt_testdriv=
er ssl_testdriver \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	u=
ser_pass_testdriver push_update_msg_testdriver provider_testdriver socket_t=
estdriver</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_binar=
ies =3D argv_testdriver \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+	auth_token_testdriver \</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+	buffer_testdriver \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	crypto_testdriver \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	dhcp_testdriver \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	ncp_testdriver \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	mbuf_testdriver \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	misc_testdriver \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	options_parse_testdriver \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	packet_id_testdriver \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	pkt_testdriver \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	provider_testdriver \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	push_update_msg_testdriver \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	socket_testdriver \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	ssl_testdriver \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	user_pass_testdriver</span><br><span> </=
span><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><span> if !WIN32</span><b=
r><span>@@ -327,6 +340,20 @@</span><br><span> 	$(top_srcdir)/src/compat/com=
pat-strsep.c \</span><br><span> 	$(top_srcdir)/src/openvpn/ssl_util.c</span=
><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+mbuf_te=
stdriver_CFLAGS  =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/=
openvpn \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-DSOURCED=
IR=3D\&quot;$(top_srcdir)\&quot; @TEST_CFLAGS@</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+mbuf_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+mbuf_testdriver_SOURCES =3D test_mbuf.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_common.h  \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	mock_get_random.c \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buff=
er.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir=
)/src/openvpn/win32-util.c \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	$(top_srcdir)/src/openvpn/platform.c \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/mbuf.c</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> misc_testdrive=
r_CFLAGS  =3D \</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/s=
rc/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	-DSOURCEDIR=3D\&q=
uot;$(top_srcdir)\&quot; @TEST_CFLAGS@</span><br><span>diff --git a/tests/u=
nit_tests/openvpn/test_mbuf.c b/tests/unit_tests/openvpn/test_mbuf.c</span>=
<br><span>new file mode 100644</span><br><span>index 0000000..8806697</span=
><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/tes=
t_mbuf.c</span><br><span>@@ -0,0 +1,155 @@</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ *  OpenVPN -- An application to securely tunnel IP networks</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *             over a single=
 UDP port, with support for SSL/TLS-based</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *             session authentication and key exchang=
e,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             pa=
cket encryption, packet authentication, and</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *             packet compression.</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  Copyright (C) 2025 OpenVPN Inc. &lt;sales@...2976...=
...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is free soft=
ware; you can redistribute it and/or modify</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *  it under the terms of the GNU General Public Li=
cense version 2</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
as published by the Free Software Foundation.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *  This program is distributed in the hope that it will be useful=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT AN=
Y WARRANTY; without even the implied warranty of</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULA=
R PURPOSE.  See the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
 *  GNU General Public License for more details.</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  You should have received a copy of the GNU General Public L=
icense along</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  wit=
h this program; if not, see &lt;https://www.gnu.org/licenses/&gt;.</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#include &quot;config.h&quot;</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include =
&quot;syshead.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;setj=
mp.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &l=
t;cmocka.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;buffer.h&=
quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot=
;multi.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;mbuf.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;test_common.h&quot;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+s=
tatic void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+test_mbuf=
_init(void **state)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_se=
t *ms =3D mbuf_init(256);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(ms-&gt;capacity, 256);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_false(mbuf_defined(ms));</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_null(ms-&gt;ar=
ray);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free(=
ms);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    ms =3D mbuf_init(257);</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ms-&gt=
;capacity, 512);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 mbuf_free(ms);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    ms =3D mbuf_init(MB=
UF_MAX_SIZE);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    as=
sert_int_equal(ms-&gt;capacity, MBUF_MAX_SIZE);</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+    mbuf_free(ms);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    expect_assert_failure(mbuf_init(MBUF_MAX_SIZE + 1));</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+static void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
test_mbuf_add_remove(void **state)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 struct mbuf_set *ms =3D mbuf_init(4);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(ms-&gt;capacity, 4);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    assert_false(mbuf_defined(ms))=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_non_nul=
l(ms-&gt;array);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    /* instances */</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+    struct multi_insta=
nce mi =3D { 0 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  struct multi_instance mi2 =3D { 0 };</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    /* buffers */</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    struct buffer buf =3D alloc_buf(16);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_buffer *mbuf_buf =3D =
mbuf_alloc_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    assert_int_equal(mbuf_buf-&gt;refcount, 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_buffer *mbuf_buf2 =3D mbu=
f_alloc_buf(&amp;buf);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    assert_int_equal(mbuf_buf2-&gt;refcount, 1);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    free_buf(&amp;buf);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    /* items */</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item mb_item =3D { .buffe=
r =3D mbuf_buf, .instance =3D &amp;mi };</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    struct mbuf_item mb_item2 =3D { .buffer =3D mbuf_b=
uf2, .instance =3D &amp;mi2 };</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf=
_add_item(ms, &amp;mb_item);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(mbuf_buf-&gt;refcount, 2);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;ref=
count, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    asser=
t_int_equal(mbuf_len(ms), 1);</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    assert_int_equal(mbuf_maximum_queued(ms), 1);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 0=
);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_eq=
ual(mbuf_peek(ms), &amp;mi);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_a=
dd_item(ms, &amp;mb_item2);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(mbuf_buf-&gt;refcount, 2);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;refc=
ount, 2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(mbuf_len(ms), 2);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(mbuf_maximum_queued(ms), 2);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 0)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equ=
al(mbuf_peek(ms), &amp;mi);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_ad=
d_item(ms, &amp;mb_item2);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(mbuf_buf-&gt;refcount, 2);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;refco=
unt, 3);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(mbuf_len(ms), 3);</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+    assert_int_equal(mbuf_maximum_queued(ms), 3);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 0);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equa=
l(mbuf_peek(ms), &amp;mi);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add=
_item(ms, &amp;mb_item2);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    mbuf_add_item(ms, &amp;mb_item2); /* overflow, first item gets re=
moved */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(mbuf_buf-&gt;refcount, 1);</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;refcount, 5);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len=
(ms), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert=
_int_equal(mbuf_maximum_queued(ms), 4);</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 1);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &=
amp;mi2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_add_item(ms, &amp;mb=
_item);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(mbuf_buf-&gt;refcount, 2);</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;refcount, 4);</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(=
ms), 4);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_=
int_equal(mbuf_maximum_queued(ms), 4);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 2);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &a=
mp;mi2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+    struct mbuf_item out_item;=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_true(mbu=
f_extract_item(ms, &amp;out_item));</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    assert_ptr_equal(out_item.instance, mb_item2.instance);=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equa=
l(mbuf_buf-&gt;refcount, 2);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    assert_int_equal(mbuf_buf2-&gt;refcount, 4);</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_len(ms), 3)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int_equ=
al(mbuf_maximum_queued(ms), 4);</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+    assert_int_equal(ms-&gt;head, 3);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    assert_ptr_equal(mbuf_peek(ms), &amp;mi2)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(=
out_item.buffer);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_dereference_=
instance(ms, &amp;mi2);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+    assert_int_equal(mbuf_buf-&gt;refcount, 2);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;refcou=
nt, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_i=
nt_equal(mbuf_len(ms), 3);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    assert_int_equal(mbuf_maximum_queued(ms), 4);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    assert_int_equal(ms-&gt;head, 3);<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_ptr_equal=
(mbuf_peek(ms), &amp;mi);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free=
(ms);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    assert_int=
_equal(mbuf_buf-&gt;refcount, 1);</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    mbuf_free_buf(mbuf_buf);</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+    assert_int_equal(mbuf_buf2-&gt;refcount, 1);</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    mbuf_free_buf(mbuf_=
buf2);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+}</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+main(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    const struct C=
MUnitTest tests[] =3D {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        cmocka_unit_test(test_mbuf_init),</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        cmocka_unit_test(test_mbuf_add_remove),</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    };</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    return cmocka_run_group_tests_name(&quot;mbuf&quo=
t;, tests, NULL, NULL);</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+}</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://=
gerrit.openvpn.net/c/openvpn/+/1432?usp=3Demail">change 1432</a>. To unsubs=
cribe, or for help writing mail filters, visit <a href=3D"http://gerrit.ope=
nvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"=
http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=
=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://ger=
rit.openvpn.net/c/openvpn/+/1432?usp=3Demail"/><meta itemprop=3D"name" cont=
ent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Icab68a5fd1b6288955f0073179f=
1ddde1468d951 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1432 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--6bDWn1DnjOM=--

