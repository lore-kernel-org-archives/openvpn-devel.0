From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 8 Mar 2024 11:51:43 +0000
In-Reply-To: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
References: <gerrit.1707835634000.I13ea6752c8d102eabcc579e391828c05d5322899@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641..., a@...2181...
Message-ID: <8628c7b7910dce262f02b27f51576df46d66df25-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="iiOyX/Q3G1Q="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--iiOyX/Q3G1Q=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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
v3:
 - add example to t_client.rc-sample
 - t_client.sh code style
 - use syshead.h in error.h
v5:
 - rename SKIP_x to CHECK_SKIP_x

Change-Id: I13ea6752c8d102eabcc579e391828c05d5322899
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240308102818.9249-1-gert@...1296...>
URL: https://www.mail-archive.com/search?l=3Dmid&q=3D20240308102818.9249-1-=
gert@...1296...
Signed-off-by: Gert Doering <gert@...1296...>
---
M src/openvpn/error.h
M tests/Makefile.am
A tests/ntlm_support.c
M tests/t_client.rc-sample
M tests/t_client.sh.in
M tests/unit_tests/openvpn/mock_msg.c
6 files changed, 119 insertions(+), 15 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/21/521/6

diff --git a/src/openvpn/error.h b/src/openvpn/error.h
index 1225b13..be3484d 100644
--- a/src/openvpn/error.h
+++ b/src/openvpn/error.h
@@ -25,16 +25,10 @@
 #define ERROR_H

 #include "basic.h"
-
-#include <errno.h>
-#include <stdbool.h>
+#include "syshead.h"

 #include <assert.h>

-#if _WIN32
-#include <windows.h>
-#endif
-
 /* #define ABORT_ON_ERROR */

 #if defined(ENABLE_PKCS11) || defined(ENABLE_MANAGEMENT)
diff --git a/tests/Makefile.am b/tests/Makefile.am
index 6c71067..6bc02b4 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -18,6 +18,8 @@

 if !WIN32
 test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh
+
+check_PROGRAMS =3D ntlm_support
 if HAVE_SITNL
 test_scripts +=3D t_net.sh
 endif
@@ -35,3 +37,15 @@

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
index 0000000..2d7da86
--- /dev/null
+++ b/tests/ntlm_support.c
@@ -0,0 +1,52 @@
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
+#include "error.h"
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
diff --git a/tests/t_client.rc-sample b/tests/t_client.rc-sample
index 355e8bb..d61ecc4 100644
--- a/tests/t_client.rc-sample
+++ b/tests/t_client.rc-sample
@@ -27,7 +27,7 @@
 #
 # tests to run (list suffixes for config stanzas below)
 #
-TEST_RUN_LIST=3D"1 2"
+TEST_RUN_LIST=3D"1 2 2n"

 #
 # use "sudo" (etc) to give openvpn the necessary privileges
@@ -53,14 +53,24 @@
 #
 # if something is not defined here, the corresponding test is not run
 #
-# possible test options:
+# common test options:
 #
-# RUN_TITLE_x=3D"what is being tested on here" (purely informational)
-# OPENVPN_CONF_x =3D "how to call ./openvpn" [mandatory]
+# RUN_TITLE_x        =3D "what is being tested on here" (purely informatio=
nal)
+# OPENVPN_CONF_x     =3D "how to call ./openvpn" [mandatory]
 # EXPECT_IFCONFIG4_x =3D "this IPv4 address needs to show up in ifconfig"
 # EXPECT_IFCONFIG6_x =3D "this IPv6 address needs to show up in ifconfig"
-# PING4_HOSTS_x =3D "these hosts musts ping when openvpn is up (IPv4 fping=
)"
-# PING6_HOSTS_x =3D "these hosts musts ping when openvpn is up (IPv6 fping=
6)"
+# PING4_HOSTS_x      =3D "these hosts musts ping when openvpn is up (IPv4 =
fping)"
+# PING6_HOSTS_x      =3D "these hosts musts ping when openvpn is up (IPv6 =
fping6)"
+#
+# hook test options:
+#
+# CHECK_SKIP_x      =3D "commands to execute before openvpn, skip test on =
failure"
+# PREPARE_x         =3D "commands to execute before openvpn"
+# POSTINIT_CMD_x    =3D "commands to execute after openvpn but before ping"
+# CLEANUP_x         =3D "commands to execute after the test"
+#
+# Note: all hooks are "eval"ed, so run in the original shell of the t_clie=
nt.sh
+# script, not a child process.
 #
 # Test 1: UDP / p2mp tun
 #   specify IPv4+IPv6 addresses expected from server and ping targets
@@ -76,10 +86,18 @@
 OPENVPN_CONF_2=3D"$OPENVPN_BASE_P2MP --dev tun --proto tcp --remote $REMOT=
E --port 51194"
 PING4_HOSTS_2=3D"10.100.51.1 10.100.0.1"
 PING6_HOSTS_2=3D"2001:db8::1 2001:db8:a051::1"
-#
 # run command after openvpn initialization is done - here: delay 5 seconds
 POSTINIT_CMD_2=3D"sleep 5"

+# Test 2n: TCP / p2mp tun / via NTLM proxy
+RUN_TITLE_2n=3D"testing tun/tcp/ntlm-proxy"
+OPENVPN_CONF_2n=3D"$OPENVPN_BASE_P2MP --dev tun --proto tcp --remote $REMO=
TE --port 51194
+ --http-proxy 192.168.1.2 8080 $KEYBASE/t_client_auth.txt ntlm --http-prox=
y-option VERSION 1.1"
+PING4_HOSTS_2n=3D"10.100.51.1 10.100.0.1"
+PING6_HOSTS_2n=3D"2001:db8::1 2001:db8:a051::1"
+# skip test if NTLM support is not available
+CHECK_SKIP_2n=3D"${top_builddir}/tests/ntlm_support"
+
 # Test 3: UDP / p2p tun
 # ...

diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in
index 99e6f9c..f6654dd 100755
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
+    eval test_check_skip=3D\"\$CHECK_SKIP_$SUF\"
     eval test_postinit=3D\"\$POSTINIT_CMD_$SUF\"
     eval test_cleanup=3D\"\$CLEANUP_$SUF\"
     eval test_run_title=3D\"\$RUN_TITLE_$SUF\"
@@ -318,6 +320,16 @@
     output_start "### test run $SUF: '$test_run_title' ###"
     fail_count=3D0

+    if [ -n "$test_check_skip" ]; then
+        output "check whether we need to skip: '$test_check_skip'"
+        if eval $test_check_skip; then :
+        else
+            output "skip check failed, SKIP test $SUF."
+	    SUMMARY_SKIP=3D"$SUMMARY_SKIP $SUF"
+	    echo -e "$outbuf" ; continue
+        fi
+    fi
+
     if [ -n "$test_prep" ]; then
         output "running preparation: '$test_prep'"
         eval $test_prep
@@ -455,8 +467,10 @@
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
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: ordex <a@...2181...>
Gerrit-MessageType: newpatchset

--iiOyX/Q3G1Q=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #6</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/521?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">t_client.sh: Allow to skip tests<br><br>Individual t=
ests can define a script to run to test<br>whether they should be skipped.<=
br><br>Included in this commit is an example check which<br>checks whether =
we can do NTLM checks. This fails<br>e.g. on recent versions of Fedora with=
 mbedTLS<br>(tested with Fedora 39) or when NTLM support is not<br>compiled=
 in.<br><br>v2:<br> - ntlm_support:<br>   - support OpenSSL 3<br>   - allow=
 to build without cmocka<br>v3:<br> - add example to t_client.rc-sample<br>=
 - t_client.sh code style<br> - use syshead.h in error.h<br>v5:<br> - renam=
e SKIP_x to CHECK_SKIP_x<br><br>Change-Id: I13ea6752c8d102eabcc579e391828c0=
5d5322899<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>A=
cked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2024030810=
2818.9249-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/search=
?l=3Dmid&amp;q=3D20240308102818.9249-1-gert@...1296...<br>Signed-off-by: Ge=
rt Doering &lt;gert@...1296...&gt;<br>---<br>M src/openvpn/error.h<br>M tes=
ts/Makefile.am<br>A tests/ntlm_support.c<br>M tests/t_client.rc-sample<br>M=
 tests/t_client.sh.in<br>M tests/unit_tests/openvpn/mock_msg.c<br>6 files c=
hanged, 119 insertions(+), 15 deletions(-)<br><br></pre><pre style=3D"font-=
family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.=
openvpn.net:29418/openvpn refs/changes/21/521/6</pre><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/src/op=
envpn/error.h b/src/openvpn/error.h</span><br><span>index 1225b13..be3484d =
100644</span><br><span>--- a/src/openvpn/error.h</span><br><span>+++ b/src/=
openvpn/error.h</span><br><span>@@ -25,16 +25,10 @@</span><br><span> #defin=
e ERROR_H</span><br><span> </span><br><span> #include &quot;basic.h&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#include &lt;errno.h&gt;</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#include &lt;stdbool.h&gt;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</s=
pan><br><span> </span><br><span> #include &lt;assert.h&gt;</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if _WIN32</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;windows.h&gt;</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* #define ABORT_ON_ERR=
OR */</span><br><span> </span><br><span> #if defined(ENABLE_PKCS11) || defi=
ned(ENABLE_MANAGEMENT)</span><br><span>diff --git a/tests/Makefile.am b/tes=
ts/Makefile.am</span><br><span>index 6c71067..6bc02b4 100644</span><br><spa=
n>--- a/tests/Makefile.am</span><br><span>+++ b/tests/Makefile.am</span><br=
><span>@@ -18,6 +18,8 @@</span><br><span> </span><br><span> if !WIN32</span=
><br><span> test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+check_PROGRAMS =3D ntlm_support</span><br><span> =
if HAVE_SITNL</span><br><span> test_scripts +=3D t_net.sh</span><br><span> =
endif</span><br><span>@@ -35,3 +37,15 @@</span><br><span> </span><br><span>=
 dist_noinst_DATA =3D \</span><br><span> 	t_client.rc-sample</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ntlm_support_CFLAGS  =3D -I$(top_srcdir)/src/openvpn =
-I$(top_srcdir)/src/compat -I$(top_srcdir)/tests/unit_tests/openvpn -DNO_CM=
OCKA @TEST_CFLAGS@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+n=
tlm_support_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn $(OPTION=
AL_CRYPTO_LIBS)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ntlm=
_support_SOURCES =3D ntlm_support.c \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_ms=
g.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)=
/src/openvpn/buffer.c \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_openssl.c \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/=
crypto_mbedtls.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
$(top_srcdir)/src/openvpn/otime.c \</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+	$(top_srcdir)/src/openvpn/packet_id.c \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/platform.c<=
/span><br><span>diff --git a/tests/ntlm_support.c b/tests/ntlm_support.c</s=
pan><br><span>new file mode 100644</span><br><span>index 0000000..2d7da86</=
span><br><span>--- /dev/null</span><br><span>+++ b/tests/ntlm_support.c</sp=
an><br><span>@@ -0,0 +1,52 @@</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Ope=
nVPN -- An application to securely tunnel IP networks</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *             over a single UDP port, wi=
th support for SSL/TLS-based</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ *             session authentication and key exchange,</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+ *             packet encrypti=
on, packet authentication, and</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *             packet compression.</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+ * Copyright (C) 2023 OpenVPN Inc &lt;sales@...515...&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+ *  This program is free software; you can re=
distribute it and/or modify</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+ *  it under the terms of the GNU General Public License version 2<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  as published by =
the Free Software Foundation.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  Thi=
s program is distributed in the hope that it will be useful,</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; with=
out even the implied warranty of</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See =
the</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General =
Public License for more details.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  =
You should have received a copy of the GNU General Public License along</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  with this program; =
if not, write to the Free Software Foundation, Inc.,</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Bost=
on, MA 02110-1301 USA.</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+ */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#include &quot;crypto.h&quot;</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;error.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+m=
ain(void)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OP=
ENSSL)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    crypto_lo=
ad_provider(&quot;legacy&quot;);</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+    crypto_load_provider(&quot;default&quot;);</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#ifdef NTLM</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+    if (!md_valid(&quot;MD4&quot;))</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+    {</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        msg(M_FATAL, &quot;MD4 not supported&quot;);</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+    if (!md_valid(&quot;MD5&quot;))=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    {</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        msg(M_FATAL, &quot;MD5 no=
t supported&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else  /* ifde=
f NTLM */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    msg(M_=
FATAL, &quot;NTLM support not compiled in&quot;);</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+}</span><br><span>diff --git a/tests/t_client.rc-sample b/=
tests/t_client.rc-sample</span><br><span>index 355e8bb..d61ecc4 100644</spa=
n><br><span>--- a/tests/t_client.rc-sample</span><br><span>+++ b/tests/t_cl=
ient.rc-sample</span><br><span>@@ -27,7 +27,7 @@</span><br><span> #</span><=
br><span> # tests to run (list suffixes for config stanzas below)</span><br=
><span> #</span><br><span style=3D"color: hsl(0, 100%, 40%);">-TEST_RUN_LIS=
T=3D&quot;1 2&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
TEST_RUN_LIST=3D&quot;1 2 2n&quot;</span><br><span> </span><br><span> #</sp=
an><br><span> # use &quot;sudo&quot; (etc) to give openvpn the necessary pr=
ivileges</span><br><span>@@ -53,14 +53,24 @@</span><br><span> #</span><br><=
span> # if something is not defined here, the corresponding test is not run=
</span><br><span> #</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# =
possible test options:</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+# common test options:</span><br><span> #</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-# RUN_TITLE_x=3D&quot;what is being tested on here&q=
uot; (purely informational)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# OPENVPN_CONF_x =3D &quot;how to call ./openvpn&quot; [mandatory]</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+# RUN_TITLE_x        =
=3D &quot;what is being tested on here&quot; (purely informational)</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# OPENVPN_CONF_x     =3D &q=
uot;how to call ./openvpn&quot; [mandatory]</span><br><span> # EXPECT_IFCON=
FIG4_x =3D &quot;this IPv4 address needs to show up in ifconfig&quot;</span=
><br><span> # EXPECT_IFCONFIG6_x =3D &quot;this IPv6 address needs to show =
up in ifconfig&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
 PING4_HOSTS_x =3D &quot;these hosts musts ping when openvpn is up (IPv4 fp=
ing)&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-# PING6_HOS=
TS_x =3D &quot;these hosts musts ping when openvpn is up (IPv6 fping6)&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# PING4_HOSTS_x   =
   =3D &quot;these hosts musts ping when openvpn is up (IPv4 fping)&quot;</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# PING6_HOSTS_x      =
=3D &quot;these hosts musts ping when openvpn is up (IPv6 fping6)&quot;</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# hook test options:</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# CHECK_SKIP_x      =3D &quot;commands to execute before o=
penvpn, skip test on failure&quot;</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# PREPARE_x         =3D &quot;commands to execute before ope=
nvpn&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# POSTINI=
T_CMD_x    =3D &quot;commands to execute after openvpn but before ping&quot=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# CLEANUP_x       =
  =3D &quot;commands to execute after the test&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# Note: all hooks are &quot;eval&quot;ed, so run in the ori=
ginal shell of the t_client.sh</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# script, not a child process.</span><br><span> #</span><br><spa=
n> # Test 1: UDP / p2mp tun</span><br><span> #   specify IPv4+IPv6 addresse=
s expected from server and ping targets</span><br><span>@@ -76,10 +86,18 @@=
</span><br><span> OPENVPN_CONF_2=3D&quot;$OPENVPN_BASE_P2MP --dev tun --pro=
to tcp --remote $REMOTE --port 51194&quot;</span><br><span> PING4_HOSTS_2=
=3D&quot;10.100.51.1 10.100.0.1&quot;</span><br><span> PING6_HOSTS_2=3D&quo=
t;2001:db8::1 2001:db8:a051::1&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#</span><br><span> # run command after openvpn initializatio=
n is done - here: delay 5 seconds</span><br><span> POSTINIT_CMD_2=3D&quot;s=
leep 5&quot;</span><br><span> </span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+# Test 2n: TCP / p2mp tun / via NTLM proxy</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+RUN_TITLE_2n=3D&quot;testing tun/tcp/ntlm=
-proxy&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+OPENVPN=
_CONF_2n=3D&quot;$OPENVPN_BASE_P2MP --dev tun --proto tcp --remote $REMOTE =
--port 51194</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ --http=
-proxy 192.168.1.2 8080 $KEYBASE/t_client_auth.txt ntlm --http-proxy-option=
 VERSION 1.1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+P=
ING4_HOSTS_2n=3D&quot;10.100.51.1 10.100.0.1&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+PING6_HOSTS_2n=3D&quot;2001:db8::1 2001:db8:=
a051::1&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# skip=
 test if NTLM support is not available</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+CHECK_SKIP_2n=3D&quot;${top_builddir}/tests/ntlm_support=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><s=
pan> # Test 3: UDP / p2p tun</span><br><span> # ...</span><br><span> </span=
><br><span>diff --git a/tests/t_client.sh.in b/tests/t_client.sh.in</span><=
br><span>index 99e6f9c..f6654dd 100755</span><br><span>--- a/tests/t_client=
.sh.in</span><br><span>+++ b/tests/t_client.sh.in</span><br><span>@@ -291,1=
2 +291,14 @@</span><br><span> # main test loop</span><br><span> # ---------=
-------------------------------------------------</span><br><span> SUMMARY_=
OK=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SUMMARY_SKIP=
=3D</span><br><span> SUMMARY_FAIL=3D</span><br><span> </span><br><span> for=
 SUF in $TEST_RUN_LIST</span><br><span> do</span><br><span>     # get confi=
g variables</span><br><span>     eval test_prep=3D\&quot;\$PREPARE_$SUF\&qu=
ot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    eval test_ch=
eck_skip=3D\&quot;\$CHECK_SKIP_$SUF\&quot;</span><br><span>     eval test_p=
ostinit=3D\&quot;\$POSTINIT_CMD_$SUF\&quot;</span><br><span>     eval test_=
cleanup=3D\&quot;\$CLEANUP_$SUF\&quot;</span><br><span>     eval test_run_t=
itle=3D\&quot;\$RUN_TITLE_$SUF\&quot;</span><br><span>@@ -318,6 +320,16 @@<=
/span><br><span>     output_start &quot;### test run $SUF: &#39;$test_run_t=
itle&#39; ###&quot;</span><br><span>     fail_count=3D0</span><br><span> </=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if [ -n &quot;$te=
st_check_skip&quot; ]; then</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+        output &quot;check whether we need to skip: &#39;$test_chec=
k_skip&#39;&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
      if eval $test_check_skip; then :</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        else</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+            output &quot;skip check failed, SKIP test $SUF.&quo=
t;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	    SUMMARY_SKIP=
=3D&quot;$SUMMARY_SKIP $SUF&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+	    echo -e &quot;$outbuf&quot; ; continue</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+        fi</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+    fi</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span>     if [ -n &quot;$test_prep&quot; ]; the=
n</span><br><span>         output &quot;running preparation: &#39;$test_pre=
p&#39;&quot;</span><br><span>         eval $test_prep</span><br><span>@@ -4=
55,8 +467,10 @@</span><br><span> done</span><br><span> </span><br><span> if=
 [ -z &quot;$SUMMARY_OK&quot; ] ; then SUMMARY_OK=3D&quot; none&quot;; fi</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+if [ -z &quot;$SUMMAR=
Y_SKIP&quot; ] ; then SUMMARY_SKIP=3D&quot; none&quot;; fi</span><br><span>=
 if [ -z &quot;$SUMMARY_FAIL&quot; ] ; then SUMMARY_FAIL=3D&quot; none&quot=
;; fi</span><br><span> echo &quot;Test sets succeeded:$SUMMARY_OK.&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+echo &quot;Test sets s=
kipped:$SUMMARY_SKIP.&quot;</span><br><span> echo &quot;Test sets failed:$S=
UMMARY_FAIL.&quot;</span><br><span> </span><br><span> # remove trap handler=
</span><br><span>diff --git a/tests/unit_tests/openvpn/mock_msg.c b/tests/u=
nit_tests/openvpn/mock_msg.c</span><br><span>index d74efaa..a291f8f 100644<=
/span><br><span>--- a/tests/unit_tests/openvpn/mock_msg.c</span><br><span>+=
++ b/tests/unit_tests/openvpn/mock_msg.c</span><br><span>@@ -31,8 +31,9 @@<=
/span><br><span> #include &lt;stdlib.h&gt;</span><br><span> #include &lt;se=
tjmp.h&gt;</span><br><span> #include &lt;stdint.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#ifndef NO_CMOCKA</span><br><span> #inclu=
de &lt;cmocka.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><spa=
n> </span><br><span> #include &quot;errlevel.h&quot;</span><br><span> #incl=
ude &quot;error.h&quot;</span><br><span>@@ -74,6 +75,8 @@</span><br><span> =
    va_end(arglist);</span><br><span> }</span><br><span> </span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+/* Allow to use mock_msg.c outside of=
 UT */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#ifndef NO_CM=
OCKA</span><br><span> void</span><br><span> assert_failed(const char *filen=
ame, int line, const char *condition)</span><br><span> {</span><br><span>@@=
 -81,6 +84,15 @@</span><br><span>     /* Keep compiler happy.  Should not h=
appen, mock_assert() does not return */</span><br><span>     exit(1);</span=
><br><span> }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#else =
 /* ifndef NO_CMOCKA */</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+void</span><br><span style=3D"color: hsl(120, 100%, 40%);">+assert_fail=
ed(const char *filename, int line, const char *condition)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+    msg(M_FATAL, &quot;Assertion failed at %s:%d (%s)&q=
uot;, filename, line, condition ? condition : &quot;&quot;);</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+    _exit(1);</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+</span><br><span> </span><br><span> /*</span><br><span>  * Fail memory =
allocation.  Don&#39;t use msg() because it tries</span><br><span></span><b=
r></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
521?usp=3Demail">change 521</a>. To unsubscribe, or for help writing mail f=
ilters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.<=
/p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscop=
e itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemp=
rop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/521?usp=3Demail"/=
><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I13ea6752c8d102eabcc579e3918=
28c05d5322899 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 521 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: ordex &lt;a@...2181...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--iiOyX/Q3G1Q=--

