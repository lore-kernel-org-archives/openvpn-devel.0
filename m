From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 8 Oct 2025 16:24:26 +0000
In-Reply-To: <gerrit.1759937374000.I60df1e61ed89be52e9d032b5b49133a784f9811e@...2715...>
References: <gerrit.1759937374000.I60df1e61ed89be52e9d032b5b49133a784f9811e@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6cde8893d037f8b861bdba0076c9a16f63133a19-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8Ydj/d28Ldo="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: test_options_parse:
 Remove --wrap
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

--8Ydj/d28Ldo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
58?usp=3Demail )

Change subject: test_options_parse: Remove --wrap
......................................................................

test_options_parse: Remove --wrap

After removing --wrap from some other tests in
a previous commit I got confused here myself.
--wrap is really only needed when you have the
original function linked in. Somehow I thought
the call ordering and mocking logic needed this.

But this is wrong, so no need to use --wrap here
since we currently do not link any of those
functions.

Change-Id: I60df1e61ed89be52e9d032b5b49133a784f9811e
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1258
Message-Id: <20251008161357.5679-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59244071/
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_options_parse.c
3 files changed, 38 insertions(+), 51 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 37bfc03..9511bda 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -660,6 +660,7 @@
         "test_crypto"
         "test_misc"
         "test_ncp"
+        "test_options_parse"
         "test_packet_id"
         "test_pkt"
         "test_provider"
@@ -685,7 +686,6 @@
     # Clang-cl (which is also MSVC) is wrongly detected to support wrap
     if (NOT MSVC AND "${LD_SUPPORTS_WRAP}")
         list(APPEND unit_tests
-            "test_options_parse"
             "test_tls_crypt"
             )
     endif ()
@@ -827,19 +827,11 @@
         src/compat/compat-strsep.c
         )

-    if (TARGET test_options_parse)
-        target_link_options(test_options_parse PRIVATE
-            -Wl,--wrap=3Dadd_option
-            -Wl,--wrap=3Dremove_option
-            -Wl,--wrap=3Dupdate_option
-	    -Wl,--wrap=3Dusage
+    target_sources(test_options_parse PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        src/openvpn/options_parse.c
+        src/openvpn/options_util.c
         )
-        target_sources(test_options_parse PRIVATE
-            tests/unit_tests/openvpn/mock_get_random.c
-            src/openvpn/options_parse.c
-            src/openvpn/options_util.c
-        )
-    endif ()

     target_sources(test_packet_id PRIVATE
         tests/unit_tests/openvpn/mock_get_random.c
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 8e94665..05c0ea5 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -5,11 +5,10 @@
 AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) Unit-Tests'

 test_binaries =3D argv_testdriver buffer_testdriver crypto_testdriver pack=
et_id_testdriver auth_token_testdriver \
-	ncp_testdriver misc_testdriver pkt_testdriver ssl_testdriver \
+	ncp_testdriver misc_testdriver options_parse_testdriver pkt_testdriver ss=
l_testdriver \
 	user_pass_testdriver push_update_msg_testdriver provider_testdriver socke=
t_testdriver

 if HAVE_LD_WRAP_SUPPORT
-test_binaries +=3D options_parse_testdriver
 if !WIN32
 test_binaries +=3D tls_crypt_testdriver
 endif
@@ -192,11 +191,7 @@
 endif

 options_parse_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_s=
rcdir)/src/compat @TEST_CFLAGS@
-options_parse_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/op=
envpn \
-	-Wl,--wrap=3Dadd_option \
-	-Wl,--wrap=3Dupdate_option \
-	-Wl,--wrap=3Dremove_option \
-	-Wl,--wrap=3Dusage
+options_parse_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/op=
envpn
 options_parse_testdriver_SOURCES =3D test_options_parse.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
diff --git a/tests/unit_tests/openvpn/test_options_parse.c b/tests/unit_tes=
ts/openvpn/test_options_parse.c
index 0ae37f5..59a3f6d 100644
--- a/tests/unit_tests/openvpn/test_options_parse.c
+++ b/tests/unit_tests/openvpn/test_options_parse.c
@@ -38,10 +38,10 @@
 #include "mock_msg.h"

 void
-__wrap_add_option(struct options *options, char *p[], bool is_inline, cons=
t char *file,
-                  int line, const int level, const msglvl_t msglevel,
-                  const unsigned int permission_mask, unsigned int *option=
_types_found,
-                  struct env_set *es)
+add_option(struct options *options, char *p[], bool is_inline, const char =
*file,
+           int line, const int level, const msglvl_t msglevel,
+           const unsigned int permission_mask, unsigned int *option_types_=
found,
+           struct env_set *es)
 {
     function_called();
     check_expected(p);
@@ -49,23 +49,23 @@
 }

 void
-__wrap_remove_option(struct context *c, struct options *options, char *p[]=
, bool is_inline,
-                     const char *file, int line, const msglvl_t msglevel,
-                     const unsigned int permission_mask, unsigned int *opt=
ion_types_found,
-                     struct env_set *es)
+remove_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
+              const char *file, int line, const msglvl_t msglevel,
+              const unsigned int permission_mask, unsigned int *option_typ=
es_found,
+              struct env_set *es)
 {
 }

 void
-__wrap_update_option(struct context *c, struct options *options, char *p[]=
, bool is_inline,
-                     const char *file, int line, const int level, const ms=
glvl_t msglevel,
-                     const unsigned int permission_mask, unsigned int *opt=
ion_types_found,
-                     struct env_set *es, unsigned int *update_options_foun=
d)
+update_option(struct context *c, struct options *options, char *p[], bool =
is_inline,
+              const char *file, int line, const int level, const msglvl_t =
msglevel,
+              const unsigned int permission_mask, unsigned int *option_typ=
es_found,
+              struct env_set *es, unsigned int *update_options_found)
 {
 }

 void
-__wrap_usage(void)
+usage(void)
 {
 }

@@ -270,34 +270,34 @@
     p_expect_inlineopt[1] =3D "some text\nother text\n";

     /* basic test */
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_someopt);
-    expect_value(__wrap_add_option, is_inline, 0);
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_otheropt);
-    expect_value(__wrap_add_option, is_inline, 0);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_someopt);
+    expect_value(add_option, is_inline, 0);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_otheropt);
+    expect_value(add_option, is_inline, 0);
     read_single_config(&o, "someopt parm1 parm2\n  otheropt 1 2");

     /* -- gets stripped */
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_someopt);
-    expect_value(__wrap_add_option, is_inline, 0);
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_otheropt);
-    expect_value(__wrap_add_option, is_inline, 0);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_someopt);
+    expect_value(add_option, is_inline, 0);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_otheropt);
+    expect_value(add_option, is_inline, 0);
     read_single_config(&o, "someopt parm1 parm2\n\t--otheropt 1 2");

     /* inline options */
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_inlineopt);
-    expect_value(__wrap_add_option, is_inline, 1);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_inlineopt);
+    expect_value(add_option, is_inline, 1);
     read_single_config(&o, "<inlineopt>\nsome text\nother text\n</inlineop=
t>");

     p_expect_inlineopt[0] =3D "inlineopt";
     p_expect_inlineopt[1] =3D A_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_=
256 A_TIMES_256 "\n";
-    expect_function_call(__wrap_add_option);
-    expect_check(__wrap_add_option, p, check_tokens, p_expect_inlineopt);
-    expect_value(__wrap_add_option, is_inline, 1);
+    expect_function_call(add_option);
+    expect_check(add_option, p, check_tokens, p_expect_inlineopt);
+    expect_value(add_option, is_inline, 1);
     read_single_config(&o, "<inlineopt>\n" A_TIMES_256 A_TIMES_256 A_TIMES=
_256 A_TIMES_256 A_TIMES_256 "\n</inlineopt>");

     gc_free(&o.gc);

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1258?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I60df1e61ed89be52e9d032b5b49133a784f9811e
Gerrit-Change-Number: 1258
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--8Ydj/d28Ldo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1258?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">test_options_parse: Remove --wrap<br><br>After r=
emoving --wrap from some other tests in<br>a previous commit I got confused=
 here myself.<br>--wrap is really only needed when you have the<br>original=
 function linked in. Somehow I thought<br>the call ordering and mocking log=
ic needed this.<br><br>But this is wrong, so no need to use --wrap here<br>=
since we currently do not link any of those<br>functions.<br><br>Change-Id:=
 I60df1e61ed89be52e9d032b5b49133a784f9811e<br>Signed-off-by: Frank Lichtenh=
eld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&=
gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1258<br>Message-I=
d: &lt;20251008161357.5679-1-gert@...1296...&gt;<br>URL: https://sourceforg=
e.net/p/openvpn/mailman/message/59244071/<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M tests/unit_tests/open=
vpn/Makefile.am<br>M tests/unit_tests/openvpn/test_options_parse.c<br>3 fil=
es changed, 38 insertions(+), 51 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 37bfc=
03..9511bda 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -660,6 +660,7 @@</span><br><span>     =
    &quot;test_crypto&quot;</span><br><span>         &quot;test_misc&quot;<=
/span><br><span>         &quot;test_ncp&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+        &quot;test_options_parse&quot;</span><br>=
<span>         &quot;test_packet_id&quot;</span><br><span>         &quot;te=
st_pkt&quot;</span><br><span>         &quot;test_provider&quot;</span><br><=
span>@@ -685,7 +686,6 @@</span><br><span>     # Clang-cl (which is also MSV=
C) is wrongly detected to support wrap</span><br><span>     if (NOT MSVC AN=
D &quot;${LD_SUPPORTS_WRAP}&quot;)</span><br><span>         list(APPEND uni=
t_tests</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            &q=
uot;test_options_parse&quot;</span><br><span>             &quot;test_tls_cr=
ypt&quot;</span><br><span>             )</span><br><span>     endif ()</spa=
n><br><span>@@ -827,19 +827,11 @@</span><br><span>         src/compat/compa=
t-strsep.c</span><br><span>         )</span><br><span> </span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-    if (TARGET test_options_parse)</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-        target_link_options(=
test_options_parse PRIVATE</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-            -Wl,--wrap=3Dadd_option</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-            -Wl,--wrap=3Dremove_option</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-            -Wl,--wrap=3Dupdate_option<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	    -Wl,--wrap=3Dusag=
e</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_sources=
(test_options_parse PRIVATE</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        tests/unit_tests/openvpn/mock_get_random.c</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/options_parse.c<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+        src/openvpn/=
options_util.c</span><br><span>         )</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-        target_sources(test_options_parse PRIVATE</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-            tests/unit_test=
s/openvpn/mock_get_random.c</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-            src/openvpn/options_parse.c</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-            src/openvpn/options_util.c</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-        )</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    endif ()</span><br><span> </span><br><span=
>     target_sources(test_packet_id PRIVATE</span><br><span>         tests/=
unit_tests/openvpn/mock_get_random.c</span><br><span>diff --git a/tests/uni=
t_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><b=
r><span>index 8e94665..05c0ea5 100644</span><br><span>--- a/tests/unit_test=
s/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefi=
le.am</span><br><span>@@ -5,11 +5,10 @@</span><br><span> AM_TESTSUITE_SUMMA=
RY_HEADER =3D &#39; for $(PACKAGE_STRING) Unit-Tests&#39;</span><br><span> =
</span><br><span> test_binaries =3D argv_testdriver buffer_testdriver crypt=
o_testdriver packet_id_testdriver auth_token_testdriver \</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	ncp_testdriver misc_testdriver pkt_tes=
tdriver ssl_testdriver \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	ncp_testdriver misc_testdriver options_parse_testdriver pkt_testdrive=
r ssl_testdriver \</span><br><span> 	user_pass_testdriver push_update_msg_t=
estdriver provider_testdriver socket_testdriver</span><br><span> </span><br=
><span> if HAVE_LD_WRAP_SUPPORT</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-test_binaries +=3D options_parse_testdriver</span><br><span> if !=
WIN32</span><br><span> test_binaries +=3D tls_crypt_testdriver</span><br><s=
pan> endif</span><br><span>@@ -192,11 +191,7 @@</span><br><span> endif</spa=
n><br><span> </span><br><span> options_parse_testdriver_CFLAGS  =3D -I$(top=
_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-options_parse_testdriver_LDFLAGS =
=3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn \</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	-Wl,--wrap=3Dadd_option \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	-Wl,--wrap=3Dupdate_option \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	-Wl,--wrap=3Dremove_option \</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	-Wl,--wrap=3Dusage</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+options_parse_testdriver_LD=
FLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn</span><br><span> optio=
ns_parse_testdriver_SOURCES =3D test_options_parse.c \</span><br><span> 	mo=
ck_msg.c mock_msg.h test_common.h \</span><br><span> 	mock_get_random.c \</=
span><br><span>diff --git a/tests/unit_tests/openvpn/test_options_parse.c b=
/tests/unit_tests/openvpn/test_options_parse.c</span><br><span>index 0ae37f=
5..59a3f6d 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_optio=
ns_parse.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_options_pars=
e.c</span><br><span>@@ -38,10 +38,10 @@</span><br><span> #include &quot;moc=
k_msg.h&quot;</span><br><span> </span><br><span> void</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-__wrap_add_option(struct options *options, =
char *p[], bool is_inline, const char *file,</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                  int line, const int level, const m=
sglvl_t msglevel,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
              const unsigned int permission_mask, unsigned int *option_type=
s_found,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-             =
     struct env_set *es)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+add_option(struct options *options, char *p[], bool is_inline, const c=
har *file,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+         =
  int line, const int level, const msglvl_t msglevel,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+           const unsigned int permission_=
mask, unsigned int *option_types_found,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+           struct env_set *es)</span><br><span> {</span=
><br><span>     function_called();</span><br><span>     check_expected(p);<=
/span><br><span>@@ -49,23 +49,23 @@</span><br><span> }</span><br><span> </s=
pan><br><span> void</span><br><span style=3D"color: hsl(0, 100%, 40%);">-__=
wrap_remove_option(struct context *c, struct options *options, char *p[], b=
ool is_inline,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-       =
              const char *file, int line, const msglvl_t msglevel,</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                     const uns=
igned int permission_mask, unsigned int *option_types_found,</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-                     struct env_set =
*es)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+remove_option(s=
truct context *c, struct options *options, char *p[], bool is_inline,</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+              const char =
*file, int line, const msglvl_t msglevel,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+              const unsigned int permission_mask, uns=
igned int *option_types_found,</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+              struct env_set *es)</span><br><span> {</span><br><=
span> }</span><br><span> </span><br><span> void</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-__wrap_update_option(struct context *c, struct op=
tions *options, char *p[], bool is_inline,</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-                     const char *file, int line, const=
 int level, const msglvl_t msglevel,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-                     const unsigned int permission_mask, uns=
igned int *option_types_found,</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-                     struct env_set *es, unsigned int *update_opti=
ons_found)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+update_op=
tion(struct context *c, struct options *options, char *p[], bool is_inline,=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+              const=
 char *file, int line, const int level, const msglvl_t msglevel,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+              const unsigned i=
nt permission_mask, unsigned int *option_types_found,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+              struct env_set *es, unsigne=
d int *update_options_found)</span><br><span> {</span><br><span> }</span><b=
r><span> </span><br><span> void</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-__wrap_usage(void)</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+usage(void)</span><br><span> {</span><br><span> }</span><br><span>=
 </span><br><span>@@ -270,34 +270,34 @@</span><br><span>     p_expect_inlin=
eopt[1] =3D &quot;some text\nother text\n&quot;;</span><br><span> </span><b=
r><span>     /* basic test */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-    expect_function_call(__wrap_add_option);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    expect_check(__wrap_add_option, p, chec=
k_tokens, p_expect_someopt);</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    expect_value(__wrap_add_option, is_inline, 0);</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    expect_function_call(__wrap_add_opt=
ion);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_check=
(__wrap_add_option, p, check_tokens, p_expect_otheropt);</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    expect_value(__wrap_add_option, is_i=
nline, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expec=
t_function_call(add_option);</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+    expect_check(add_option, p, check_tokens, p_expect_someopt);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_value(add_=
option, is_inline, 0);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    expect_function_call(add_option);</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    expect_check(add_option, p, check_tokens, p_expect=
_otheropt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expe=
ct_value(add_option, is_inline, 0);</span><br><span>     read_single_config=
(&amp;o, &quot;someopt parm1 parm2\n  otheropt 1 2&quot;);</span><br><span>=
 </span><br><span>     /* -- gets stripped */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    expect_function_call(__wrap_add_option);</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_check(__wrap_add_=
option, p, check_tokens, p_expect_someopt);</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-    expect_value(__wrap_add_option, is_inline, 0);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_function_call=
(__wrap_add_option);</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   expect_check(__wrap_add_option, p, check_tokens, p_expect_otheropt);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_value(__wrap_a=
dd_option, is_inline, 0);</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    expect_function_call(add_option);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    expect_check(add_option, p, check_tokens, p_exp=
ect_someopt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    ex=
pect_value(add_option, is_inline, 0);</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    expect_function_call(add_option);</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+    expect_check(add_option, p, check_t=
okens, p_expect_otheropt);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    expect_value(add_option, is_inline, 0);</span><br><span>     rea=
d_single_config(&amp;o, &quot;someopt parm1 parm2\n\t--otheropt 1 2&quot;);=
</span><br><span> </span><br><span>     /* inline options */</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    expect_function_call(__wrap_add_=
option);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_ch=
eck(__wrap_add_option, p, check_tokens, p_expect_inlineopt);</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-    expect_value(__wrap_add_option, =
is_inline, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    e=
xpect_function_call(add_option);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    expect_check(add_option, p, check_tokens, p_expect_inlineo=
pt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_valu=
e(add_option, is_inline, 1);</span><br><span>     read_single_config(&amp;o=
, &quot;&lt;inlineopt&gt;\nsome text\nother text\n&lt;/inlineopt&gt;&quot;)=
;</span><br><span> </span><br><span>     p_expect_inlineopt[0] =3D &quot;in=
lineopt&quot;;</span><br><span>     p_expect_inlineopt[1] =3D A_TIMES_256 A=
_TIMES_256 A_TIMES_256 A_TIMES_256 A_TIMES_256 &quot;\n&quot;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    expect_function_call(__wrap_ad=
d_option);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    expect_=
check(__wrap_add_option, p, check_tokens, p_expect_inlineopt);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-    expect_value(__wrap_add_option=
, is_inline, 1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 expect_function_call(add_option);</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+    expect_check(add_option, p, check_tokens, p_expect_inlin=
eopt);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    expect_va=
lue(add_option, is_inline, 1);</span><br><span>     read_single_config(&amp=
;o, &quot;&lt;inlineopt&gt;\n&quot; A_TIMES_256 A_TIMES_256 A_TIMES_256 A_T=
IMES_256 A_TIMES_256 &quot;\n&lt;/inlineopt&gt;&quot;);</span><br><span> </=
span><br><span>     gc_free(&amp;o.gc);</span><br><span></span><br></pre><p=
>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1258?usp=
=3Demail">change 1258</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings=
</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div it=
emscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link=
 itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1258?usp=3D=
email"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I60df1e61ed89be52e9d032b5b49=
133a784f9811e </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1258 </div>
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

--8Ydj/d28Ldo=--

