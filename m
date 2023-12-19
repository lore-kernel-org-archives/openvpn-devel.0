From: "cron2 (Code Review)" <gerrit@...515...>
Date: Tue, 19 Dec 2023 10:09:42 +0000
In-Reply-To: <gerrit.1702310034000.Ic7265d89142637b0963a6847c6beb06d9163bbb1@...2715...>
References: <gerrit.1702310034000.Ic7265d89142637b0963a6847c6beb06d9163bbb1@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6af3a511077fb5cf8943257a9430b50aa619ff61-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="AajJGt6n+Qw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: tests: disable
 automake serial_tests
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

--AajJGt6n+Qw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/477?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


Change subject: tests: disable automake serial_tests
......................................................................

tests: disable automake serial_tests

Serial mode is the old one and offers much less options for
running the tests. Generally our tests seem to work fine
with the newer parallel mode. The only reason we stuck with
serial_tests seems to be that we didn't like that it doesn't
output the test output by default. We could fix that with a
custom test driver. But will put that into a separate commit.

Change-Id: Ic7265d89142637b0963a6847c6beb06d9163bbb1
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Message-Id: <20231214111635.237429-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
812.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
M tests/Makefile.am
M tests/unit_tests/example_test/Makefile.am
M tests/unit_tests/openvpn/Makefile.am
M tests/unit_tests/plugins/auth-pam/Makefile.am
5 files changed, 9 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/77/477/3

diff --git a/configure.ac b/configure.ac
index 54f79ab..2823f04 100644
--- a/configure.ac
+++ b/configure.ac
@@ -41,20 +41,6 @@
 AC_CONFIG_SRCDIR([src/openvpn/syshead.h])
 AC_CONFIG_MACRO_DIR([m4])

-dnl Initialize automake.  automake < 1.12 didn't have serial-tests and
-dnl gives an error if it sees this, but for automake >=3D 1.13
-dnl serial-tests is required so we have to include it.  Solution is to
-dnl test for the version of automake (by running an external command)
-dnl and provide it if necessary.  Note we have to do this entirely using
-dnl m4 macros since automake queries this macro by running
-dnl 'autoconf --trace ...'.
-m4_define([serial_tests], [
-    m4_esyscmd([automake --version |
-                head -1 |
-                awk '{split ($NF,a,"."); if (a[1] =3D=3D 1 && a[2] >=3D 12=
) { print "serial-tests" }}'
-    ])
-])
-
 dnl Automake 1.14+ warns if sources are in sub-directories but subdir-obje=
cts
 dnl options is not enabled. However, automake before 1.15a has a bug that =
causes
 dnl variable expansion to fail in foo_SOURCES when this option is used.
@@ -69,7 +55,7 @@

 # This foreign option prevents autoreconf from overriding our COPYING and
 # INSTALL targets:
-AM_INIT_AUTOMAKE(foreign serial_tests subdir_objects 1.9) dnl NB: Do not [=
quote] this parameter.
+AM_INIT_AUTOMAKE(foreign subdir_objects 1.9) dnl NB: Do not [quote] this p=
arameter.
 AC_CANONICAL_HOST
 AC_USE_SYSTEM_EXTENSIONS

diff --git a/tests/Makefile.am b/tests/Makefile.am
index 80673d5..6c71067 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -14,6 +14,8 @@

 SUBDIRS =3D unit_tests

+AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) System Tests'
+
 if !WIN32
 test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh
 if HAVE_SITNL
diff --git a/tests/unit_tests/example_test/Makefile.am b/tests/unit_tests/e=
xample_test/Makefile.am
index 24eb0ba..1ae80c8 100644
--- a/tests/unit_tests/example_test/Makefile.am
+++ b/tests/unit_tests/example_test/Makefile.am
@@ -1,5 +1,7 @@
 AUTOMAKE_OPTIONS =3D foreign

+AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) example Unit-Tests'
+
 check_PROGRAMS =3D example_testdriver example2_testdriver

 if !CROSS_COMPILING
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index ef45b11..cecf4dc 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -1,5 +1,7 @@
 AUTOMAKE_OPTIONS =3D foreign

+AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) Unit-Tests'
+
 test_binaries=3D

 if HAVE_LD_WRAP_SUPPORT
diff --git a/tests/unit_tests/plugins/auth-pam/Makefile.am b/tests/unit_tes=
ts/plugins/auth-pam/Makefile.am
index de5e96e..ba32013 100644
--- a/tests/unit_tests/plugins/auth-pam/Makefile.am
+++ b/tests/unit_tests/plugins/auth-pam/Makefile.am
@@ -1,5 +1,7 @@
 AUTOMAKE_OPTIONS =3D foreign

+AM_TESTSUITE_SUMMARY_HEADER =3D ' for $(PACKAGE_STRING) auth_pam Plugin Un=
it-Tests'
+
 if ENABLE_PLUGIN_AUTH_PAM
 check_PROGRAMS =3D auth_pam_testdriver
 TESTS =3D $(check_PROGRAMS)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/477?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic7265d89142637b0963a6847c6beb06d9163bbb1
Gerrit-Change-Number: 477
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--AajJGt6n+Qw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #3</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/477?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos</p><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">tests: disable automake serial_tests<br><br>Seri=
al mode is the old one and offers much less options for<br>running the test=
s. Generally our tests seem to work fine<br>with the newer parallel mode. T=
he only reason we stuck with<br>serial_tests seems to be that we didn&#39;t=
 like that it doesn&#39;t<br>output the test output by default. We could fi=
x that with a<br>custom test driver. But will put that into a separate comm=
it.<br><br>Change-Id: Ic7265d89142637b0963a6847c6beb06d9163bbb1<br>Signed-o=
ff-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe=
 &lt;arne-openvpn@...1227...&gt;<br>Message-Id: &lt;20231214111635.237429-1=
-frank@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg27812.html<br>Signed-off-by: Gert Doering &lt;gert@...220...=
..1296...&gt;<br>---<br>M configure.ac<br>M tests/Makefile.am<br>M tests/un=
it_tests/example_test/Makefile.am<br>M tests/unit_tests/openvpn/Makefile.am=
<br>M tests/unit_tests/plugins/auth-pam/Makefile.am<br>5 files changed, 9 i=
nsertions(+), 15 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/77/477/3</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/configure.ac b/conf=
igure.ac</span><br><span>index 54f79ab..2823f04 100644</span><br><span>--- =
a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -41,20=
 +41,6 @@</span><br><span> AC_CONFIG_SRCDIR([src/openvpn/syshead.h])</span>=
<br><span> AC_CONFIG_MACRO_DIR([m4])</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-dnl Initialize automake.  automake &lt; 1.=
12 didn&#39;t have serial-tests and</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-dnl gives an error if it sees this, but for automake &gt;=3D =
1.13</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dnl serial-tests =
is required so we have to include it.  Solution is to</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-dnl test for the version of automake (by ru=
nning an external command)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-dnl and provide it if necessary.  Note we have to do this entirely usi=
ng</span><br><span style=3D"color: hsl(0, 100%, 40%);">-dnl m4 macros since=
 automake queries this macro by running</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-dnl &#39;autoconf --trace ...&#39;.</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-m4_define([serial_tests], [</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-    m4_esyscmd([automake --version |<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-                head -=
1 |</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                aw=
k &#39;{split ($NF,a,&quot;.&quot;); if (a[1] =3D=3D 1 &amp;&amp; a[2] &gt;=
=3D 12) { print &quot;serial-tests&quot; }}&#39;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-    ])</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span> dnl Automake 1.14+ warns if sources are in sub-directories but s=
ubdir-objects</span><br><span> dnl options is not enabled. However, automak=
e before 1.15a has a bug that causes</span><br><span> dnl variable expansio=
n to fail in foo_SOURCES when this option is used.</span><br><span>@@ -69,7=
 +55,7 @@</span><br><span> </span><br><span> # This foreign option prevents=
 autoreconf from overriding our COPYING and</span><br><span> # INSTALL targ=
ets:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AM_INIT_AUTOMAKE(=
foreign serial_tests subdir_objects 1.9) dnl NB: Do not [quote] this parame=
ter.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_INIT_AUTOMAK=
E(foreign subdir_objects 1.9) dnl NB: Do not [quote] this parameter.</span>=
<br><span> AC_CANONICAL_HOST</span><br><span> AC_USE_SYSTEM_EXTENSIONS</spa=
n><br><span> </span><br><span>diff --git a/tests/Makefile.am b/tests/Makefi=
le.am</span><br><span>index 80673d5..6c71067 100644</span><br><span>--- a/t=
ests/Makefile.am</span><br><span>+++ b/tests/Makefile.am</span><br><span>@@=
 -14,6 +14,8 @@</span><br><span> </span><br><span> SUBDIRS =3D unit_tests</=
span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+AM_=
TESTSUITE_SUMMARY_HEADER =3D &#39; for $(PACKAGE_STRING) System Tests&#39;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if=
 !WIN32</span><br><span> test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.=
sh</span><br><span> if HAVE_SITNL</span><br><span>diff --git a/tests/unit_t=
ests/example_test/Makefile.am b/tests/unit_tests/example_test/Makefile.am</=
span><br><span>index 24eb0ba..1ae80c8 100644</span><br><span>--- a/tests/un=
it_tests/example_test/Makefile.am</span><br><span>+++ b/tests/unit_tests/ex=
ample_test/Makefile.am</span><br><span>@@ -1,5 +1,7 @@</span><br><span> AUT=
OMAKE_OPTIONS =3D foreign</span><br><span> </span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+AM_TESTSUITE_SUMMARY_HEADER =3D &#39; for $(PACKAGE=
_STRING) example Unit-Tests&#39;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+</span><br><span> check_PROGRAMS =3D example_testdriver exampl=
e2_testdriver</span><br><span> </span><br><span> if !CROSS_COMPILING</span>=
<br><span>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_te=
sts/openvpn/Makefile.am</span><br><span>index ef45b11..cecf4dc 100644</span=
><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b=
/tests/unit_tests/openvpn/Makefile.am</span><br><span>@@ -1,5 +1,7 @@</span=
><br><span> AUTOMAKE_OPTIONS =3D foreign</span><br><span> </span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+AM_TESTSUITE_SUMMARY_HEADER =3D &#39=
; for $(PACKAGE_STRING) Unit-Tests&#39;</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+</span><br><span> test_binaries=3D</span><br><span> </s=
pan><br><span> if HAVE_LD_WRAP_SUPPORT</span><br><span>diff --git a/tests/u=
nit_tests/plugins/auth-pam/Makefile.am b/tests/unit_tests/plugins/auth-pam/=
Makefile.am</span><br><span>index de5e96e..ba32013 100644</span><br><span>-=
-- a/tests/unit_tests/plugins/auth-pam/Makefile.am</span><br><span>+++ b/te=
sts/unit_tests/plugins/auth-pam/Makefile.am</span><br><span>@@ -1,5 +1,7 @@=
</span><br><span> AUTOMAKE_OPTIONS =3D foreign</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+AM_TESTSUITE_SUMMARY_HEADER =
=3D &#39; for $(PACKAGE_STRING) auth_pam Plugin Unit-Tests&#39;</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> if ENABLE_PLU=
GIN_AUTH_PAM</span><br><span> check_PROGRAMS =3D auth_pam_testdriver</span>=
<br><span> TESTS =3D $(check_PROGRAMS)</span><br><span></span><br></pre><p>=
To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/477?usp=3De=
mail">change 477</a>. To unsubscribe, or for help writing mail filters, vis=
it <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div ite=
mscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=
=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url=
" href=3D"http://gerrit.openvpn.net/c/openvpn/+/477?usp=3Demail"/><meta ite=
mprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic7265d89142637b0963a6847c6b=
eb06d9163bbb1 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 477 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--AajJGt6n+Qw=--

