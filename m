From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 7 Oct 2025 20:17:42 +0000
In-Reply-To: <gerrit.1759239739000.I937105abeb5e8f796bf6bbe8432972adb60b3e2a@...2715...>
References: <gerrit.1759239739000.I937105abeb5e8f796bf6bbe8432972adb60b3e2a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <45c700056c580c0b5e36bb1b22f8b3310632401c-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="Q3avMf+QkD8="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: unit_tests: Remove
 useless wrapping for argv/buffer tests
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

--Q3avMf+QkD8=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/12=
43?usp=3Demail )

Change subject: unit_tests: Remove useless wrapping for argv/buffer tests
......................................................................

unit_tests: Remove useless wrapping for argv/buffer tests

If not using mock() or check_expected(), and
not linking the original function, then there
is no need for wrapping support.

Change-Id: I937105abeb5e8f796bf6bbe8432972adb60b3e2a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1243
Message-Id: <20251007185217.19381-1-gert@...1296...>
URL: https://sourceforge.net/p/openvpn/mailman/message/59243508/
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/openvpn/test_argv.c
3 files changed, 10 insertions(+), 14 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index be66357..aeef480 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -654,6 +654,7 @@
     endif ()

     set(unit_tests
+        "test_argv"
         "test_auth_token"
         "test_buffer"
         "test_crypto"
@@ -684,7 +685,6 @@
     # Clang-cl (which is also MSVC) is wrongly detected to support wrap
     if (NOT MSVC AND "${LD_SUPPORTS_WRAP}")
         list(APPEND unit_tests
-            "test_argv"
             "test_tls_crypt"
             )
     endif ()
@@ -887,13 +887,10 @@
         src/openvpn/list.c
         )

-    if (TARGET test_argv)
-        target_link_options(test_argv PRIVATE -Wl,--wrap=3Dparse_line)
-        target_sources(test_argv PRIVATE
-            tests/unit_tests/openvpn/mock_get_random.c
-            src/openvpn/argv.c
-            )
-    endif ()
+    target_sources(test_argv PRIVATE
+        tests/unit_tests/openvpn/mock_get_random.c
+        src/openvpn/argv.c
+        )

     if (TARGET test_cryptoapi)
         target_sources(test_cryptoapi PRIVATE
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index ec8cc69..f7b1bc8 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -4,12 +4,11 @@

 AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) Unit-Tests'

-test_binaries =3D crypto_testdriver packet_id_testdriver auth_token_testdr=
iver \
+test_binaries =3D argv_testdriver buffer_testdriver crypto_testdriver pack=
et_id_testdriver auth_token_testdriver \
 	ncp_testdriver misc_testdriver pkt_testdriver ssl_testdriver \
 	user_pass_testdriver push_update_msg_testdriver provider_testdriver socke=
t_testdriver

 if HAVE_LD_WRAP_SUPPORT
-test_binaries +=3D argv_testdriver buffer_testdriver
 if !WIN32
 test_binaries +=3D tls_crypt_testdriver
 endif
@@ -36,7 +35,7 @@
 endif

 argv_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/sr=
c/compat @TEST_CFLAGS@
-argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl=
,--wrap=3Dparse_line
+argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
 argv_testdriver_SOURCES =3D test_argv.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
@@ -46,7 +45,7 @@
 	$(top_srcdir)/src/openvpn/argv.c

 buffer_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/=
src/compat @TEST_CFLAGS@
-buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -=
Wl,--wrap=3Dparse_line
+buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn
 buffer_testdriver_SOURCES =3D test_buffer.c \
 	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
diff --git a/tests/unit_tests/openvpn/test_argv.c b/tests/unit_tests/openvp=
n/test_argv.c
index a04fabc..25c0371 100644
--- a/tests/unit_tests/openvpn/test_argv.c
+++ b/tests/unit_tests/openvpn/test_argv.c
@@ -22,8 +22,8 @@
 #define SCRIPT_CMD "\"" PATH1 PATH2 "\"" PARAM1 "\"" PARAM2 "\""

 int
-__wrap_parse_line(const char *line, char **p, const int n, const char *fil=
e, const int line_num,
-                  msglvl_t msglevel, struct gc_arena *gc)
+parse_line(const char *line, char **p, const int n, const char *file, cons=
t int line_num,
+           msglvl_t msglevel, struct gc_arena *gc)
 {
     p[0] =3D PATH1 PATH2;
     p[1] =3D PARAM1;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1243?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I937105abeb5e8f796bf6bbe8432972adb60b3e2a
Gerrit-Change-Number: 1243
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--Q3avMf+QkD8=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1243?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">unit_tests: Remove useless wrapping for argv/buf=
fer tests<br><br>If not using mock() or check_expected(), and<br>not linkin=
g the original function, then there<br>is no need for wrapping support.<br>=
<br>Change-Id: I937105abeb5e8f796bf6bbe8432972adb60b3e2a<br>Signed-off-by: =
Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;ge=
rt@...1296...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/124=
3<br>Message-Id: &lt;20251007185217.19381-1-gert@...1296...&gt;<br>URL: htt=
ps://sourceforge.net/p/openvpn/mailman/message/59243508/<br>Signed-off-by: =
Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M tests/=
unit_tests/openvpn/Makefile.am<br>M tests/unit_tests/openvpn/test_argv.c<br=
>3 files changed, 10 insertions(+), 14 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index be663=
57..aeef480 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -654,6 +654,7 @@</span><br><span>     =
endif ()</span><br><span> </span><br><span>     set(unit_tests</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+        &quot;test_argv&quot;</s=
pan><br><span>         &quot;test_auth_token&quot;</span><br><span>        =
 &quot;test_buffer&quot;</span><br><span>         &quot;test_crypto&quot;</=
span><br><span>@@ -684,7 +685,6 @@</span><br><span>     # Clang-cl (which i=
s also MSVC) is wrongly detected to support wrap</span><br><span>     if (N=
OT MSVC AND &quot;${LD_SUPPORTS_WRAP}&quot;)</span><br><span>         list(=
APPEND unit_tests</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    =
        &quot;test_argv&quot;</span><br><span>             &quot;test_tls_c=
rypt&quot;</span><br><span>             )</span><br><span>     endif ()</sp=
an><br><span>@@ -887,13 +887,10 @@</span><br><span>         src/openvpn/lis=
t.c</span><br><span>         )</span><br><span> </span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    if (TARGET test_argv)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-        target_link_options(test_argv PRIVA=
TE -Wl,--wrap=3Dparse_line)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-        target_sources(test_argv PRIVATE</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-            tests/unit_tests/openvpn/mock_get_rand=
om.c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            src/o=
penvpn/argv.c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-        =
    )</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    endif ()</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    target_sources(test=
_argv PRIVATE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+      =
  tests/unit_tests/openvpn/mock_get_random.c</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+        src/openvpn/argv.c</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span> </span><br><sp=
an>     if (TARGET test_cryptoapi)</span><br><span>         target_sources(=
test_cryptoapi PRIVATE</span><br><span>diff --git a/tests/unit_tests/openvp=
n/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>index =
ec8cc69..f7b1bc8 100644</span><br><span>--- a/tests/unit_tests/openvpn/Make=
file.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><b=
r><span>@@ -4,12 +4,11 @@</span><br><span> </span><br><span> AM_TESTSUITE_S=
UMMARY_HEADER =3D &#39; for $(PACKAGE_STRING) Unit-Tests&#39;</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-test_binaries =3D=
 crypto_testdriver packet_id_testdriver auth_token_testdriver \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+test_binaries =3D argv_testdriv=
er buffer_testdriver crypto_testdriver packet_id_testdriver auth_token_test=
driver \</span><br><span> 	ncp_testdriver misc_testdriver pkt_testdriver ss=
l_testdriver \</span><br><span> 	user_pass_testdriver push_update_msg_testd=
river provider_testdriver socket_testdriver</span><br><span> </span><br><sp=
an> if HAVE_LD_WRAP_SUPPORT</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-test_binaries +=3D argv_testdriver buffer_testdriver</span><br><span>=
 if !WIN32</span><br><span> test_binaries +=3D tls_crypt_testdriver</span><=
br><span> endif</span><br><span>@@ -36,7 +35,7 @@</span><br><span> endif</s=
pan><br><span> </span><br><span> argv_testdriver_CFLAGS  =3D -I$(top_srcdir=
)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@=
 -L$(top_srcdir)/src/openvpn -Wl,--wrap=3Dparse_line</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS=
@ -L$(top_srcdir)/src/openvpn</span><br><span> argv_testdriver_SOURCES =3D =
test_argv.c \</span><br><span> 	mock_msg.c mock_msg.h test_common.h \</span=
><br><span> 	mock_get_random.c \</span><br><span>@@ -46,7 +45,7 @@</span><b=
r><span> 	$(top_srcdir)/src/openvpn/argv.c</span><br><span> </span><br><spa=
n> buffer_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir=
)/src/compat @TEST_CFLAGS@</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openv=
pn -Wl,--wrap=3Dparse_line</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/ope=
nvpn</span><br><span> buffer_testdriver_SOURCES =3D test_buffer.c \</span><=
br><span> 	mock_msg.c mock_msg.h test_common.h \</span><br><span> 	mock_get=
_random.c \</span><br><span>diff --git a/tests/unit_tests/openvpn/test_argv=
.c b/tests/unit_tests/openvpn/test_argv.c</span><br><span>index a04fabc..25=
c0371 100644</span><br><span>--- a/tests/unit_tests/openvpn/test_argv.c</sp=
an><br><span>+++ b/tests/unit_tests/openvpn/test_argv.c</span><br><span>@@ =
-22,8 +22,8 @@</span><br><span> #define SCRIPT_CMD &quot;\&quot;&quot; PATH=
1 PATH2 &quot;\&quot;&quot; PARAM1 &quot;\&quot;&quot; PARAM2 &quot;\&quot;=
&quot;</span><br><span> </span><br><span> int</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-__wrap_parse_line(const char *line, char **p, const=
 int n, const char *file, const int line_num,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-                  msglvl_t msglevel, struct gc_aren=
a *gc)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+parse_line(co=
nst char *line, char **p, const int n, const char *file, const int line_num=
,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+           msglvl_=
t msglevel, struct gc_arena *gc)</span><br><span> {</span><br><span>     p[=
0] =3D PATH1 PATH2;</span><br><span>     p[1] =3D PARAM1;</span><br><span><=
/span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/op=
envpn/+/1243?usp=3Demail">change 1243</a>. To unsubscribe, or for help writ=
ing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=
=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Ema=
ilMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org=
/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/ope=
nvpn/+/1243?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/>=
</div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I937105abeb5e8f796bf6bbe8432=
972adb60b3e2a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1243 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--Q3avMf+QkD8=--

