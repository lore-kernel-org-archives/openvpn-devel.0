From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 1 Feb 2024 19:25:48 +0000
In-Reply-To: <gerrit.1706531144000.Ide72b81f497088dd0fd2cdcfff83cbce5b48f145@...2715...>
References: <gerrit.1706531144000.Ide72b81f497088dd0fd2cdcfff83cbce5b48f145@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <10da90b3335c45bb02ce44140d6a53d5fc256da2-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Ih7LlG6X2jg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Allow unit tests to
 fall back to hard coded location
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Ih7LlG6X2jg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/50=
9?usp=3Demail )

Change subject: Allow unit tests to fall back to hard coded location
......................................................................

Allow unit tests to fall back to hard coded location

Settings the environment variable required for running unit tests is
tiresome in my IDE (Clion). So allow unit tests to fall back to a hard
coded location in case the environment variable is not set.

Change-Id: Ide72b81f497088dd0fd2cdcfff83cbce5b48f145
Acked-by: Frank Lichtenheld <frank@...2641...>
Message-Id: <20240201144817.188884-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
161.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M tests/unit_tests/openvpn/test_common.h
M tests/unit_tests/openvpn/test_user_pass.c
3 files changed, 37 insertions(+), 6 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index be55c60..fdd2b01 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -682,6 +682,10 @@

         target_include_directories(${test_name} PRIVATE src/openvpn)

+        # for compat with IDEs like Clion that ignore the tests properties
+        # for the environment variable srcdir when running tests as fallba=
ck
+        target_compile_definitions(${test_name} PRIVATE "-DUNIT_TEST_SOURC=
EDIR=3D\"${CMAKE_SOURCE_DIR}/tests/unit_tests/openvpn\"")
+
         if (NOT ${test_name} STREQUAL "test_buffer")
             target_sources(${test_name} PRIVATE
                 src/openvpn/buffer.c
diff --git a/tests/unit_tests/openvpn/test_common.h b/tests/unit_tests/open=
vpn/test_common.h
index 50e16d6..f219e93 100644
--- a/tests/unit_tests/openvpn/test_common.h
+++ b/tests/unit_tests/openvpn/test_common.h
@@ -32,9 +32,36 @@
  * This has a openvpn prefix to avoid confusion with cmocka's unit_test_se=
tup_*
  * methods
  */
-void
+static inline void
 openvpn_unit_test_setup()
 {
     assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);
     assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);
 }
+
+/**
+ * Helper function to get a file path from the unit test directory to open=
 it
+ * or pass its path to another function. This function will first look for
+ * an environment variable or if failing that, will fall back to a hardcod=
ed
+ * value from compile time if compiled with CMake.
+ *
+ * @param buf           buffer holding the path to the file
+ * @param bufsize       size of buf
+ * @param filename      name of the filename to retrieve relative to the
+ *                      unit test source directory
+ */
+void
+openvpn_test_get_srcdir_dir(char *buf, size_t bufsize, const char *filenam=
e)
+{
+    const char *srcdir =3D getenv("srcdir");
+
+#if defined(UNIT_TEST_SOURCEDIR)
+    if (!srcdir)
+    {
+        srcdir =3D UNIT_TEST_SOURCEDIR;
+    }
+#endif
+    assert_non_null(srcdir);
+
+    snprintf(buf, bufsize, "%s/%s", srcdir, filename);
+}
diff --git a/tests/unit_tests/openvpn/test_user_pass.c b/tests/unit_tests/o=
penvpn/test_user_pass.c
index 277cb1d..bd4eb1f 100644
--- a/tests/unit_tests/openvpn/test_user_pass.c
+++ b/tests/unit_tests/openvpn/test_user_pass.c
@@ -35,6 +35,7 @@
 #include <string.h>
 #include <setjmp.h>
 #include <cmocka.h>
+#include "test_common.h"

 #include "misc.c"

@@ -232,11 +233,9 @@
     reset_user_pass(&up);
     unsigned int flags =3D 0;

-    const char *srcdir =3D getenv("srcdir");
-    assert_non_null(srcdir);
     char authfile[PATH_MAX] =3D { 0 };
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/user_pass.txt" =
);

-    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_pass.txt");
     /*FIXME: query_user_exec() called even though nothing queued */
     will_return(query_user_exec_builtin, true);
     assert_true(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
@@ -246,7 +245,7 @@

     reset_user_pass(&up);

-    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_only.txt");
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/user_only.txt");
     expect_string(query_user_exec_builtin, query_user[i].prompt, "Enter UT=
 Password:");
     will_return(query_user_exec_builtin, "cpassword");
     will_return(query_user_exec_builtin, true);
@@ -259,7 +258,7 @@
     reset_user_pass(&up);

     flags |=3D GET_USER_PASS_PASSWORD_ONLY;
-    snprintf(authfile, PATH_MAX, "%s/%s", srcdir, "input/user_only.txt");
+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, "input/user_only.txt");
     /*FIXME: query_user_exec() called even though nothing queued */
     will_return(query_user_exec_builtin, true);
     assert_true(get_user_pass_cr(&up, authfile, "UT", flags, NULL));
@@ -279,5 +278,6 @@
 int
 main(void)
 {
+    openvpn_unit_test_setup();
     return cmocka_run_group_tests(user_pass_tests, NULL, NULL);
 }

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/509?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ide72b81f497088dd0fd2cdcfff83cbce5b48f145
Gerrit-Change-Number: 509
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--Ih7LlG6X2jg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/509?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Allow unit tests to fall back to hard coded lo=
cation<br><br>Settings the environment variable required for running unit t=
ests is<br>tiresome in my IDE (Clion). So allow unit tests to fall back to =
a hard<br>coded location in case the environment variable is not set.<br><b=
r>Change-Id: Ide72b81f497088dd0fd2cdcfff83cbce5b48f145<br>Acked-by: Frank L=
ichtenheld &lt;frank@...2641...&gt;<br>Message-Id: &lt;20240201144817.18888=
4-1-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel=
@lists.sourceforge.net/msg28161.html<br>Signed-off-by: Gert Doering &lt;ger=
t@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M tests/unit_tests/openvpn/t=
est_common.h<br>M tests/unit_tests/openvpn/test_user_pass.c<br>3 files chan=
ged, 37 insertions(+), 6 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index be55c=
60..fdd2b01 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -682,6 +682,10 @@</span><br><span> </s=
pan><br><span>         target_include_directories(${test_name} PRIVATE src/=
openvpn)</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+        # for compat with IDEs like Clion that ignore the tests prop=
erties</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        # for=
 the environment variable srcdir when running tests as fallback</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        target_compile_definiti=
ons(${test_name} PRIVATE &quot;-DUNIT_TEST_SOURCEDIR=3D\&quot;${CMAKE_SOURC=
E_DIR}/tests/unit_tests/openvpn\&quot;&quot;)</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span>         if (NOT ${test_name} ST=
REQUAL &quot;test_buffer&quot;)</span><br><span>             target_sources=
(${test_name} PRIVATE</span><br><span>                 src/openvpn/buffer.c=
</span><br><span>diff --git a/tests/unit_tests/openvpn/test_common.h b/test=
s/unit_tests/openvpn/test_common.h</span><br><span>index 50e16d6..f219e93 1=
00644</span><br><span>--- a/tests/unit_tests/openvpn/test_common.h</span><b=
r><span>+++ b/tests/unit_tests/openvpn/test_common.h</span><br><span>@@ -32=
,9 +32,36 @@</span><br><span>  * This has a openvpn prefix to avoid confusi=
on with cmocka&#39;s unit_test_setup_*</span><br><span>  * methods</span><b=
r><span>  */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-void</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+static inline void</span=
><br><span> openvpn_unit_test_setup()</span><br><span> {</span><br><span>  =
   assert_int_equal(setvbuf(stdout, NULL, _IONBF, BUFSIZ), 0);</span><br><s=
pan>     assert_int_equal(setvbuf(stderr, NULL, _IONBF, BUFSIZ), 0);</span>=
<br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+/**</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * Helper function to get a file path fro=
m the unit test directory to open it</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ * or pass its path to another function. This function wil=
l first look for</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * =
an environment variable or if failing that, will fall back to a hardcoded</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * value from compile=
 time if compiled with CMake.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @par=
am buf           buffer holding the path to the file</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * @param bufsize       size of buf</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ * @param filename      n=
ame of the filename to retrieve relative to the</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *                      unit test source direct=
ory</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+openvpn_test_get_srcdir_dir(char *buf, size_t b=
ufsize, const char *filename)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    cons=
t char *srcdir =3D getenv(&quot;srcdir&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#if defined(UNIT_TEST_SOURCEDIR)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    if (!srcdir)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        srcdir =3D UNIT_TEST_SOURCEDIR;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 assert_non_null(srcdir);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    snprintf(=
buf, bufsize, &quot;%s/%s&quot;, srcdir, filename);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tests/unit=
_tests/openvpn/test_user_pass.c b/tests/unit_tests/openvpn/test_user_pass.c=
</span><br><span>index 277cb1d..bd4eb1f 100644</span><br><span>--- a/tests/=
unit_tests/openvpn/test_user_pass.c</span><br><span>+++ b/tests/unit_tests/=
openvpn/test_user_pass.c</span><br><span>@@ -35,6 +35,7 @@</span><br><span>=
 #include &lt;string.h&gt;</span><br><span> #include &lt;setjmp.h&gt;</span=
><br><span> #include &lt;cmocka.h&gt;</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &quot;test_common.h&quot;</span><br><span> </spa=
n><br><span> #include &quot;misc.c&quot;</span><br><span> </span><br><span>=
@@ -232,11 +233,9 @@</span><br><span>     reset_user_pass(&amp;up);</span><=
br><span>     unsigned int flags =3D 0;</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    const char *srcdir =3D getenv(&quot=
;srcdir&quot;);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    as=
sert_non_null(srcdir);</span><br><span>     char authfile[PATH_MAX] =3D { 0=
 };</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_test=
_get_srcdir_dir(authfile, PATH_MAX, &quot;input/user_pass.txt&quot; );</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    snpr=
intf(authfile, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/user_pass.t=
xt&quot;);</span><br><span>     /*FIXME: query_user_exec() called even thou=
gh nothing queued */</span><br><span>     will_return(query_user_exec_built=
in, true);</span><br><span>     assert_true(get_user_pass_cr(&amp;up, authf=
ile, &quot;UT&quot;, flags, NULL));</span><br><span>@@ -246,7 +245,7 @@</sp=
an><br><span> </span><br><span>     reset_user_pass(&amp;up);</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-    snprintf(auth=
file, PATH_MAX, &quot;%s/%s&quot;, srcdir, &quot;input/user_only.txt&quot;)=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn_test_g=
et_srcdir_dir(authfile, PATH_MAX, &quot;input/user_only.txt&quot;);</span><=
br><span>     expect_string(query_user_exec_builtin, query_user[i].prompt, =
&quot;Enter UT Password:&quot;);</span><br><span>     will_return(query_use=
r_exec_builtin, &quot;cpassword&quot;);</span><br><span>     will_return(qu=
ery_user_exec_builtin, true);</span><br><span>@@ -259,7 +258,7 @@</span><br=
><span>     reset_user_pass(&amp;up);</span><br><span> </span><br><span>   =
  flags |=3D GET_USER_PASS_PASSWORD_ONLY;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-    snprintf(authfile, PATH_MAX, &quot;%s/%s&quot;, src=
dir, &quot;input/user_only.txt&quot;);</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    openvpn_test_get_srcdir_dir(authfile, PATH_MAX, &quo=
t;input/user_only.txt&quot;);</span><br><span>     /*FIXME: query_user_exec=
() called even though nothing queued */</span><br><span>     will_return(qu=
ery_user_exec_builtin, true);</span><br><span>     assert_true(get_user_pas=
s_cr(&amp;up, authfile, &quot;UT&quot;, flags, NULL));</span><br><span>@@ -=
279,5 +278,6 @@</span><br><span> int</span><br><span> main(void)</span><br>=
<span> {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    openvpn=
_unit_test_setup();</span><br><span>     return cmocka_run_group_tests(user=
_pass_tests, NULL, NULL);</span><br><span> }</span><br><span></span><br></p=
re><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/509?u=
sp=3Demail">change 509</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><d=
iv itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope ite=
mprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/509?usp=3Demail"/><m=
eta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ide72b81f497088dd0fd2cdcfff8=
3cbce5b48f145 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 509 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--Ih7LlG6X2jg=--

