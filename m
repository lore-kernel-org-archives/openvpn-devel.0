From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 15 Jan 2026 09:23:29 +0000
In-Reply-To: <gerrit.1767876064000.Ifb6594700db71d219643a29c581099c778bcbbc6@...2715...>
References: <gerrit.1767876064000.Ifb6594700db71d219643a29c581099c778bcbbc6@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <513be09303830e7fd34d4e3812c706dc50daa9ca-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="T9XF2VbhdjM="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[release/2.6]:
 tests/unit_tests: Port to cmocka 2.0.0 API
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

--T9XF2VbhdjM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
62?usp=3Demail )

Change subject: tests/unit_tests: Port to cmocka 2.0.0 API
......................................................................

tests/unit_tests: Port to cmocka 2.0.0 API

But add compat layer so that we can still build
against older versions of cmocka. Mostly this is
trivial but the custom check function changed its
prototype, so that requires some more work.

This backport commit additionally includes the fix
for test_tls_crypt from commit
6246f2113f6e1fda13bca8de863dd5cc396ab6ef since the
other test fixes from the original commit are not
relevant to release/2.6.

Change-Id: Ifb6594700db71d219643a29c581099c778bcbbc6
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1462
(cherry picked from commit 6db186e0b1d9783ea96e8a945a47fd23b45e4778)
Message-Id: <20260115082817.18618-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35=
273.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M tests/unit_tests/openvpn/test_common.h
M tests/unit_tests/openvpn/test_tls_crypt.c
5 files changed, 49 insertions(+), 12 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index f7cb5a7..6983d111 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -291,6 +291,18 @@
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
@@ -541,14 +553,6 @@


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
         "test_auth_token"
         "test_buffer"
diff --git a/config.h.cmake.in b/config.h.cmake.in
index cedc5be..bf60d39 100644
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
index e77fd47..fb8d530 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1525,7 +1525,16 @@
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

 TEST_LDFLAGS=3D"${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELPER_LIBS}"
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/open=
vpn/test_common.h
index 50e16d6..e5e4420 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -25,6 +25,27 @@
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
diff --git a/tests/unit_tests/openvpn/test_tls_crypt.c b/tests/unit_tests/o=
penvpn/test_tls_crypt.c
index 5eb864e..bf5a8ce 100644
--- a/tests/unit_tests/openvpn/test_tls_crypt.c
+++ b/tests/unit_tests/openvpn/test_tls_crypt.c
@@ -112,8 +112,8 @@
 __wrap_buffer_write_file(const char *filename, const struct buffer *buf)
 {
     const char *pem =3D BSTR(buf);
-    check_expected(filename);
-    check_expected(pem);
+    check_expected_ptr(filename);
+    check_expected_ptr(pem);

     return mock_type(bool);
 }
@@ -121,7 +121,7 @@
 struct buffer
 __wrap_buffer_read_from_file(const char *filename, struct gc_arena *gc)
 {
-    check_expected(filename);
+    check_expected_ptr(filename);

     const char *pem_str =3D mock_ptr_type(const char *);
     struct buffer ret =3D alloc_buf_gc(strlen(pem_str) + 1, gc);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1462?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: Ifb6594700db71d219643a29c581099c778bcbbc6
Gerrit-Change-Number: 1462
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--T9XF2VbhdjM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1462?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tests/unit_tests: Port to cmocka 2.0.0 API<br><b=
r>But add compat layer so that we can still build<br>against older versions=
 of cmocka. Mostly this is<br>trivial but the custom check function changed=
 its<br>prototype, so that requires some more work.<br><br>This backport co=
mmit additionally includes the fix<br>for test_tls_crypt from commit<br>624=
6f2113f6e1fda13bca8de863dd5cc396ab6ef since the<br>other test fixes from th=
e original commit are not<br>relevant to release/2.6.<br><br>Change-Id: Ifb=
6594700db71d219643a29c581099c778bcbbc6<br>Signed-off-by: Frank Lichtenheld =
&lt;frank@...2641...&gt;<br>Signed-off-by: Gert Doering &lt;gert@...1296...=
&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https=
://gerrit.openvpn.net/c/openvpn/+/1462<br>(cherry picked from commit 6db186=
e0b1d9783ea96e8a945a47fd23b45e4778)<br>Message-Id: &lt;20260115082817.18618=
-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...465...=
ists.sourceforge.net/msg35273.html<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.cmake.in<br>M confi=
gure.ac<br>M tests/unit_tests/openvpn/test_common.h<br>M tests/unit_tests/o=
penvpn/test_tls_crypt.c<br>5 files changed, 49 insertions(+), 12 deletions(=
-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index f7cb5=
a7..6983d111 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>++=
+ b/CMakeLists.txt</span><br><span>@@ -291,6 +291,18 @@</span><br><span>   =
  )</span><br><span> set(HAVE_CONFIG_VERSION_H YES)</span><br><span> </span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+if (BUILD_TESTING)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    find_package(cmocka CO=
NFIG)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (TARGET=
 cmocka::cmocka)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
     set(CMOCKA_LIBRARIES cmocka::cmocka)</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+    else ()</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+        pkg_search_module(cmocka cmocka REQUIRED IMPORTED_TAR=
GET)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        set(CMO=
CKA_LIBRARIES PkgConfig::cmocka)</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    endif ()</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    set(CMAKE_REQUIRED_LIBRARIES ${CMOCKA_LIBRARIES})</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    check_include_files(cmocka_vers=
ion.h HAVE_CMOCKA_VERSION_H)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+endif ()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span> configure_file(config.h.cmake.in config.h)</span><br><span>=
 configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)</span><br><sp=
an> # TODO we should remove the need for this, and always include config.h<=
/span><br><span>@@ -541,14 +553,6 @@</span><br><span> </span><br><span> </s=
pan><br><span> if (BUILD_TESTING)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    find_package(cmocka CONFIG)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    if (TARGET cmocka::cmocka)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        set(CMOCKA_LIBRARIES cmocka::cmocka=
)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    else ()</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-        pkg_search_module(cmoc=
ka cmocka REQUIRED IMPORTED_TARGET)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-        set(CMOCKA_LIBRARIES PkgConfig::cmocka)</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-    endif ()</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span>     set(unit_tests</span>=
<br><span>         &quot;test_auth_token&quot;</span><br><span>         &qu=
ot;test_buffer&quot;</span><br><span>diff --git a/config.h.cmake.in b/confi=
g.h.cmake.in</span><br><span>index cedc5be..bf60d39 100644</span><br><span>=
--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><=
span>@@ -86,6 +86,9 @@</span><br><span> /* git version information in confi=
g-version.h */</span><br><span> #cmakedefine HAVE_CONFIG_VERSION_H</span><b=
r><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* cmocka =
version information available in cmocka_version.h (&gt;=3D 2.0.0) */</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#cmakedefine HAVE_CMOCKA_V=
ERSION_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br>=
<span> /* Define to 1 if you have the `daemon&#39; function. */</span><br><=
span> #cmakedefine HAVE_DAEMON</span><br><span> </span><br><span>diff --git=
 a/configure.ac b/configure.ac</span><br><span>index e77fd47..fb8d530 10064=
4</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</sp=
an><br><span>@@ -1525,7 +1525,16 @@</span><br><span> 	[have_cmocka=3D&quot;=
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
yle=3D"color: hsl(120, 100%, 40%);">+   CFLAGS=3D&quot;${CFLAGS} ${CMOCKA_C=
FLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   # de=
tect cmocka &lt; 2.0.0 that had no cmocka_version.h</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+   AC_CHECK_HEADERS([cmocka_version.h])</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+   CFLAGS=3D&quot;${s=
aved_CFLAGS}&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+f=
i</span><br><span> AC_SUBST([ENABLE_UNITTESTS])</span><br><span> </span><br=
><span> TEST_LDFLAGS=3D&quot;${OPTIONAL_CRYPTO_LIBS} ${OPTIONAL_PKCS11_HELP=
ER_LIBS}&quot;</span><br><span>diff --git a/tests/unit_tests/openvpn/test_c=
ommon.h b/tests/unit_tests/openvpn/test_common.h</span><br><span>index 50e1=
6d6..e5e4420 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_com=
mon.h</span><br><span>+++ b/tests/unit_tests/openvpn/test_common.h</span><b=
r><span>@@ -25,6 +25,27 @@</span><br><span> #include &lt;setjmp.h&gt;</span=
><br><span> #include &lt;cmocka.h&gt;</span><br><span> </span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+/* Do we use cmocka &lt; 2.0.0? */</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef HAVE_CMOCKA_VERS=
ION_H</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define HAVE_O=
LD_CMOCKA_API 1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/* c=
ompat with various versions of cmocka.h</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ * Older versions have LargestIntegralType. Newer</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * versions use uintmax_t=
. But LargestIntegralType</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+ * is not guaranteed to be equal to uintmax_t, so</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ * we can&#39;t use that unconditionall=
y. So we only use</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
 it if cmocka.h does not define LargestIntegralType.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#ifndef LargestIntegralType</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+#define LargestIntegralType uintmax_t</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+/* redefine 2.x API in terms of 1.x API */</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define CMockaValueDa=
ta             LargestIntegralType</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#define check_expected_uint         check_expected</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+#define expect_uint_value    =
       expect_value</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#define expect_check_data           expect_check</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+#define cast_ptr_to_cmocka_value(x) (x)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+</span><br><span> /**</span><br><span> =
 * Sets up the environment for unit tests like making both stderr and stdou=
t</span><br><span>  * non-buffered to avoid messages getting lost if the pr=
ogram exits early.</span><br><span>diff --git a/tests/unit_tests/openvpn/te=
st_tls_crypt.c b/tests/unit_tests/openvpn/test_tls_crypt.c</span><br><span>=
index 5eb864e..bf5a8ce 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/test_tls_crypt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_tls_=
crypt.c</span><br><span>@@ -112,8 +112,8 @@</span><br><span> __wrap_buffer_=
write_file(const char *filename, const struct buffer *buf)</span><br><span>=
 {</span><br><span>     const char *pem =3D BSTR(buf);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    check_expected(filename);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    check_expected(pem);</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+    check_expected_ptr(filena=
me);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    check_expec=
ted_ptr(pem);</span><br><span> </span><br><span>     return mock_type(bool)=
;</span><br><span> }</span><br><span>@@ -121,7 +121,7 @@</span><br><span> s=
truct buffer</span><br><span> __wrap_buffer_read_from_file(const char *file=
name, struct gc_arena *gc)</span><br><span> {</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    check_expected(filename);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    check_expected_ptr(filename);</span><=
br><span> </span><br><span>     const char *pem_str =3D mock_ptr_type(const=
 char *);</span><br><span>     struct buffer ret =3D alloc_buf_gc(strlen(pe=
m_str) + 1, gc);</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1462?usp=3Demail">change 1462</a>=
. To unsubscribe, or for help writing mail filters, visit <a href=3D"http:/=
/gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope i=
temtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"actio=
n" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1462?usp=3Demail"/><meta itemprop=3D=
"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifb6594700db71d219643a29c581=
099c778bcbbc6 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1462 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--T9XF2VbhdjM=--

