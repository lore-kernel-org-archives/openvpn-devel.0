From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 14 Feb 2024 12:07:38 +0000
In-Reply-To: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
References: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <203a96f191f6241d42804a020aa4434b97e1fa90-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="do1i7tndHQI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: t_client.sh: Allow
 to skip tests
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

--do1i7tndHQI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail

to look at the new patch set (#2).


Change subject: t_client.sh: Allow to skip tests
......................................................................

t_client.sh: Allow to skip tests

Individual tests can define a script to run to test
whether they should be skipped.

Included in this commit is an example check which
checks whether we can do NTLM checks. This fails
e.g. on recent versions of Fedora with mbedTLS
(tested with Fedora 39) or when NTLM support is not
compiled in.

v2:
 - ntlm_support:
   - support OpenSSL 3
   - allow to build without cmocka

Change-Id: I13ea6752c8d102eabcc579e391828c05d5322899
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M src/openvpn/error.h
M tests/Makefile.am
A tests/ntlm_support.c
M tests/t_client.sh.in
M tests/unit_tests/openvpn/mock_msg.c
5 files changed, 94 insertions(+), 1 deletion(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/521/2

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 1225b13..0ef3263 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -33,6 +33,9 @@

 #if _WIN32
 #include <windows.h>
+#else
+/* for _exit() */
+#include <unistd.h>
 #endif

 /* #define ABORT_ON_ERROR */
diff --git a/tests/Makefile.am b/tests/Makefile.am
index b3b2d74..13a1013 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -19,6 +19,8 @@

 if !WIN32
 test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh
+
+check_PROGRAMS =3D ntlm_support
 if HAVE_SITNL
 test_scripts +=3D t_net.sh
 endif
@@ -36,3 +38,15 @@

 dist_noinst_DATA =3D \
 	t_client.rc-sample
+
+ntlm_support_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/c=
ompat -I$(top_srcdir)/tests/unit_tests/openvpn -DNO_CMOCKA @TEST_CFLAGS@
+ntlm_support_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn $(OPTI=
ONAL_CRYPTO_LIBS)
+ntlm_support_SOURCES =3D ntlm_support.c \
+	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c
diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c
new file mode 100644
index 0000000..8d81257
--- /dev/null
+++ b/tests/ntlm_support.c
@@ -0,0 +1,51 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ * Copyright (C) 2023 OpenVPN Inc <sales@...515...>
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
+ *  with this program; if not, write to the Free Software Foundation, Inc.,
+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
+ */
+
+#ifdef HAVE_CONFIG_H
+#include "config.h"
+#endif
+
+#include "syshead.h"
+
+#include "crypto.h"
+
+int
+main(void)
+{
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    crypto_load_provider("legacy");
+    crypto_load_provider("default");
+#endif
+#ifdef NTLM
+    if (!md_valid("MD4"))
+    {
+        msg(M_FATAL, "MD4 not supported");
+    }
+    if (!md_valid("MD5"))
+    {
+        msg(M_FATAL, "MD5 not supported");
+    }
+#else  /* ifdef NTLM */
+    msg(M_FATAL, "NTLM support not compiled in");
+#endif
+}
diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 99e6f9c..7be1c8e 100755
--- a/tests/t_client.sh.in
+++ b/tests/t_client.sh.in
@@ -291,12 +291,14 @@
 # main test loop
 # ----------------------------------------------------------
 SUMMARY_OK=3D
+SUMMARY_SKIP=3D
 SUMMARY_FAIL=3D

 for SUF in $TEST_RUN_LIST
 do
     # get config variables
     eval test_prep=3D\"\$PREPARE_$SUF\"
+    eval test_check_skip=3D\"\$SKIP_$SUF\"
     eval test_postinit=3D\"\$POSTINIT_CMD_$SUF\"
     eval test_cleanup=3D\"\$CLEANUP_$SUF\"
     eval test_run_title=3D\"\$RUN_TITLE_$SUF\"
@@ -318,6 +320,15 @@
     output_start "### test run $SUF: '$test_run_title' ###"
     fail_count=3D0

+    if [ -n "$test_check_skip" ]; then
+        output "check whether we need to skip: '$test_check_skip'"
+        eval $test_check_skip || {
+            output "skip check failed, SKIP test $SUF."
+	    SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
+	    echo -e "$outbuf" ; continue
+        }
+    fi
+
     if [ -n "$test_prep" ]; then
         output "running preparation: '$test_prep'"
         eval $test_prep
@@ -455,8 +466,10 @@
 done

 if [ -z "$SUMMARY_OK" ] ; then SUMMARY_OK=3D" none"; fi
+if [ -z "$SUMMARY_SKIP" ] ; then SUMMARY_SKIP=3D" none"; fi
 if [ -z "$SUMMARY_FAIL" ] ; then SUMMARY_FAIL=3D" none"; fi
 echo "Test sets succeeded:$SUMMARY_OK."
+echo "Test sets skipped:$SUMMARY_SKIP."
 echo "Test sets failed:$SUMMARY_FAIL."

 # remove trap handler
diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn=
/mock_msg.c
index d74efaa..a291f8f 100644
--- a/tests/unit_tests/openvpn/mock_msg.c
+++ b/tests/unit_tests/openvpn/mock_msg.c
@@ -31,8 +31,9 @@
 #include <stdlib.h>
 #include <setjmp.h>
 #include <stdint.h>
+#ifndef NO_CMOCKA
 #include <cmocka.h>
-
+#endif

 #include "errlevel.h"
 #include "error.h"
@@ -74,6 +75,8 @@
     va_end(arglist);
 }

+/* Allow to use mock_msg.c outside of UT */
+#ifndef NO_CMOCKA
 void
 assert_failed(const char *filename, int line, const char *condition)
 {
@@ -81,6 +84,15 @@
     /* Keep compiler happy.  Should not happen, mock_assert() does not ret=
urn */
     exit(1);
 }
+#else  /* ifndef NO_CMOCKA */
+void
+assert_failed(const char *filename, int line, const char *condition)
+{
+    msg(M_FATAL, "Assertion failed at %s:%d (%s)", filename, line, conditi=
on ? condition : "");
+    _exit(1);
+}
+#endif
+

 /*
  * Fail memory allocation.  Don't use msg() because it tries

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I13ea6752c8d102eabcc579e391828c05d5322899
Gerrit-Change-Number: 521
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--do1i7tndHQI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #2</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail">View Ch=
ange</a></p><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;">t_client.sh: Allow to skip tests<br><br>Individual tests can defin=
e a script to run to test<br>whether they should be skipped.<br><br>Include=
d in this commit is an example check which<br>checks whether we can do NTLM=
 checks. This fails<br>e.g. on recent versions of Fedora with mbedTLS<br>(t=
ested with Fedora 39) or when NTLM support is not<br>compiled in.<br><br>v2=
:<br> - ntlm_support:<br>   - support OpenSSL 3<br>   - allow to build with=
out cmocka<br><br>Change-Id: I13ea6752c8d102eabcc579e391828c05d5322899<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M src/op=
envpn/error.h<br>M tests/Makefile.am<br>A tests/ntlm_support.c<br>M tests/t=
_client.sh.in<br>M tests/unit_tests/openvpn/mock_msg.c<br>5 files changed, =
94 insertions(+), 1 deletion(-)<br><br></pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net=
:29418/openvpn refs/changes/21/521/2</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/src/openvpn/error=
.h b/src/openvpn/error.h</span><br><span>index 1225b13..0ef3263 100644</spa=
n><br><span>--- a/src/openvpn/error.h</span><br><span>+++ b/src/openvpn/err=
or.h</span><br><span>@@ -33,6 +33,9 @@</span><br><span> </span><br><span> #=
if _WIN32</span><br><span> #include &lt;windows.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#else</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+/* for _exit() */</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+#include &lt;unistd.h&gt;</span><br><span> #endif</span><=
br><span> </span><br><span> /* #define ABORT_ON_ERROR */</span><br><span>di=
ff --git a/tests/Makefile.am b/tests/Makefile.am</span><br><span>index b3b2=
d74..13a1013 100644</span><br><span>--- a/tests/Makefile.am</span><br><span=
>+++ b/tests/Makefile.am</span><br><span>@@ -19,6 +19,8 @@</span><br><span>=
 </span><br><span> if !WIN32</span><br><span> test_scripts =3D t_client.sh =
t_lpback.sh t_cltsrv.sh</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_PROGRAMS =
=3D ntlm_support</span><br><span> if HAVE_SITNL</span><br><span> test_scrip=
ts +=3D t_net.sh</span><br><span> endif</span><br><span>@@ -36,3 +38,15 @@<=
/span><br><span> </span><br><span> dist_noinst_DATA =3D \</span><br><span> =
	t_client.rc-sample</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ntlm_support_CFLAGS=
  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_srcdir=
)/tests/unit_tests/openvpn -DNO_CMOCKA @TEST_CFLAGS@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ntlm_support_LDFLAGS =3D @TEST_LDFLAGS@ -=
L$(top_srcdir)/src/openvpn $(OPTIONAL_CRYPTO_LIBS)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ntlm_support_SOURCES =3D ntlm_support.c \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	unit_tests/openvpn/mo=
ck_msg.c unit_tests/openvpn/mock_msg.h \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto.c =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src=
/openvpn/crypto_openssl.c \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/otime.c \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openv=
pn/packet_id.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(=
top_srcdir)/src/openvpn/platform.c</span><br><span>diff --git a/tests/ntlm_=
support.c b/tests/ntlm_support.c</span><br><span>new file mode 100644</span=
><br><span>index 0000000..8d81257</span><br><span>--- /dev/null</span><br><=
span>+++ b/tests/ntlm_support.c</span><br><span>@@ -0,0 +1,51 @@</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application to securely tunne=
l IP networks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *    =
         over a single UDP port, with support for SSL/TLS-based</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *             session authenti=
cation and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+ *             packet encryption, packet authentication, and</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+ *             packet compres=
sion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ * Copyright (C) 2023 OpenVPN I=
nc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This p=
rogram is free software; you can redistribute it and/or modify</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ *  it under the terms of the GN=
U General Public License version 2</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  as published by the Free Software Foundation.</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *  This program is distributed in the hope tha=
t it will be useful,</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  but WITHOUT ANY WARRANTY; without even the implied warranty of</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERCHANTABILITY or FITN=
ESS FOR A PARTICULAR PURPOSE.  See the</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ *  GNU General Public License for more details.</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  You should have received a copy of the G=
NU General Public License along</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  with this program; if not, write to the Free Software Found=
ation, Inc.,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  51 =
Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;config.h&quot;</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;sysh=
ead.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;crypto.h&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+int</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+main(void)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if =
defined(ENABLE_CRYPTO_OPENSSL)</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+    crypto_load_provider(&quot;legacy&quot;);</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    crypto_load_provider(&quot;default=
&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifdef NTLM</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (!md_valid(&quot;MD4&quot=
;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;MD4=
 not supported&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (!md=
_valid(&quot;MD5&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        m=
sg(M_FATAL, &quot;MD5 not supported&quot;);</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+#else  /* ifdef NTLM */</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    msg(M_FATAL, &quot;NTLM support not compiled in&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span>diff --git a/tes=
ts/t_client.sh.in b/tests/t_client.sh.in</span><br><span>index 99e6f9c..7be=
1c8e 100755</span><br><span>--- a/tests/t_client.sh.in</span><br><span>+++ =
b/tests/t_client.sh.in</span><br><span>@@ -291,12 +291,14 @@</span><br><spa=
n> # main test loop</span><br><span> # ------------------------------------=
----------------------</span><br><span> SUMMARY_OK=3D</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+SUMMARY_SKIP=3D</span><br><span> SUMMARY_=
FAIL=3D</span><br><span> </span><br><span> for SUF in $TEST_RUN_LIST</span>=
<br><span> do</span><br><span>     # get config variables</span><br><span> =
    eval test_prep=3D\&quot;\$PREPARE_$SUF\&quot;</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    eval test_check_skip=3D\&quot;\$SKIP_$SUF=
\&quot;</span><br><span>     eval test_postinit=3D\&quot;\$POSTINIT_CMD_$SU=
F\&quot;</span><br><span>     eval test_cleanup=3D\&quot;\$CLEANUP_$SUF\&qu=
ot;</span><br><span>     eval test_run_title=3D\&quot;\$RUN_TITLE_$SUF\&quo=
t;</span><br><span>@@ -318,6 +320,15 @@</span><br><span>     output_start &=
quot;### test run $SUF: &#39;$test_run_title&#39; ###&quot;</span><br><span=
>     fail_count=3D0</span><br><span> </span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if [ -n &quot;$test_check_skip&quot; ]; then</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        output &quot;check =
whether we need to skip: &#39;$test_check_skip&#39;&quot;</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        eval $test_check_skip || {</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+            output &qu=
ot;skip check failed, SKIP test $SUF.&quot;</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	    SUMMARY_SKIP=3D&quot;$SUMMARY_SKIP $SUF&quot;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	    echo -e &quot;$=
outbuf&quot; ; continue</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    fi=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span>  =
   if [ -n &quot;$test_prep&quot; ]; then</span><br><span>         output &=
quot;running preparation: &#39;$test_prep&#39;&quot;</span><br><span>      =
   eval $test_prep</span><br><span>@@ -455,8 +466,10 @@</span><br><span> do=
ne</span><br><span> </span><br><span> if [ -z &quot;$SUMMARY_OK&quot; ] ; t=
hen SUMMARY_OK=3D&quot; none&quot;; fi</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+if [ -z &quot;$SUMMARY_SKIP&quot; ] ; then SUMMARY_SKIP=
=3D&quot; none&quot;; fi</span><br><span> if [ -z &quot;$SUMMARY_FAIL&quot;=
 ] ; then SUMMARY_FAIL=3D&quot; none&quot;; fi</span><br><span> echo &quot;=
Test sets succeeded:$SUMMARY_OK.&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+echo &quot;Test sets skipped:$SUMMARY_SKIP.&quot;</span>=
<br><span> echo &quot;Test sets failed:$SUMMARY_FAIL.&quot;</span><br><span=
> </span><br><span> # remove trap handler</span><br><span>diff --git a/test=
s/unit_tests/openvpn/mock_msg.c b/tests/unit_tests/openvpn/mock_msg.c</span=
><br><span>index d74efaa..a291f8f 100644</span><br><span>--- a/tests/unit_t=
ests/openvpn/mock_msg.c</span><br><span>+++ b/tests/unit_tests/openvpn/mock=
_msg.c</span><br><span>@@ -31,8 +31,9 @@</span><br><span> #include &lt;stdl=
ib.h&gt;</span><br><span> #include &lt;setjmp.h&gt;</span><br><span> #inclu=
de &lt;stdint.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
#ifndef NO_CMOCKA</span><br><span> #include &lt;cmocka.h&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#endif</span><br><span> </span><br><span> #include &quo=
t;errlevel.h&quot;</span><br><span> #include &quot;error.h&quot;</span><br>=
<span>@@ -74,6 +75,8 @@</span><br><span>     va_end(arglist);</span><br><sp=
an> }</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+/* Allow to use mock_msg.c outside of UT */</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+#ifndef NO_CMOCKA</span><br><span> void</span><=
br><span> assert_failed(const char *filename, int line, const char *conditi=
on)</span><br><span> {</span><br><span>@@ -81,6 +84,15 @@</span><br><span> =
    /* Keep compiler happy.  Should not happen, mock_assert() does not retu=
rn */</span><br><span>     exit(1);</span><br><span> }</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#else  /* ifndef NO_CMOCKA */</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+void</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+assert_failed(const char *filename, int line,=
 const char *condition)</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+{</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_FATA=
L, &quot;Assertion failed at %s:%d (%s)&quot;, filename, line, condition ? =
condition : &quot;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+    _exit(1);</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+}</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> </span><br><=
span> /*</span><br><span>  * Fail memory allocation.  Don&#39;t use msg() b=
ecause it tries</span><br><span></span><br></pre><p>To view, visit <a href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail">change 521</a>. =
To unsubscribe, or for help writing mail filters, visit <a href=3D"http://g=
errit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=3D"htt=
p://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D=
"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/521?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13ea6752c8d102eabcc579e3918=
28c05d5322899 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--do1i7tndHQI=--

