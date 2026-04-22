From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 22 Apr 2026 07:46:27 +0000
In-Reply-To: <gerrit.1775421558000.I125cf63f11257d7245ead2f7feafb86b841580a5@...2715...>
References: <gerrit.1775421558000.I125cf63f11257d7245ead2f7feafb86b841580a5@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <dfc6b73b0df2eeb6cd4cd66b73474002cb44dc12-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="jLZJh47PEWk="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: dev-tools: Add
 script to run cppcheck against the code-base
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

--jLZJh47PEWk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#6) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1620?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: dev-tools: Add script to run cppcheck against the code-base
......................................................................

dev-tools: Add script to run cppcheck against the code-base

Also add a suitable suppressions-list file to
make it possible to run it without reporting
errors.

Tested with cppcheck 2.19.0 (Ubuntu 26.04).

Change-Id: I125cf63f11257d7245ead2f7feafb86b841580a5
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1620
Message-Id: <20260419134205.21459-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg36=
664.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Makefile.am
A dev-tools/cppcheck-suppression
A dev-tools/run-cppcheck.sh
3 files changed, 120 insertions(+), 0 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/20/1620/6

diff --git a/Makefile.am b/Makefile.am
index 362ae96..2df7eea 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -89,3 +89,10 @@

 doxygen:
 	$(MAKE) -C doc/doxygen doxygen
+
+.PHONY: cppcheck
+cppcheck:
+	BUILD_DIR=3D"$(abs_top_builddir)" \
+	SOURCE_DIR=3D"$(abs_top_srcdir)" \
+	INCLUDE_FLAGS=3D"$(LIBNL_GENL_CFLAGS)" \
+		"$(top_srcdir)/dev-tools/run-cppcheck.sh"
diff --git a/dev-tools/cppcheck-suppression b/dev-tools/cppcheck-suppression
new file mode 100644
index 0000000..1f31edb
--- /dev/null
+++ b/dev-tools/cppcheck-suppression
@@ -0,0 +1,87 @@
+# We start with --enable=3Dall, but then suppress some issues that have to=
o many
+# occurences right now. They still should be fixed at some point
+constParameter
+constParameterCallback
+constParameterPointer
+constVariable
+constVariablePointer
+variableScope
+# We have a lot of library includes, not all of them are really required,
+# so ignore them
+missingIncludeSystem
+# cppcheck doesn't understand about check_malloc_return, so these are
+# usually misleading
+nullPointerOutOfMemory
+nullPointerArithmeticOutOfMemory
+# These are specific false-positives (FP) or ignored (IGN) issues
+# We might want to move some of them to inline-suppression to avoid
+# the static line-numbers
+# IGN: multi code does weird things with pointers to local variables...
+autoVariables:src/openvpn/multi.c:4177
+autoVariables:src/openvpn/multi_io.c:280
+# IGN: the code header =3D 0 | (OPCODE << P_OPCODE_SHIFT) is used intentio=
nally
+badBitmaskCheck:src/openvpn/mudp.c
+badBitmaskCheck:tests/unit_tests/openvpn/test_pkt.c
+# IGN: event code uses a pointer to store integers
+intToPointerCast:src/openvpn/multi_io.c
+intToPointerCast:src/openvpn/forward.c
+# FP: crt_error is always true on Unix, but not Windows
+knownConditionTrueFalse:src/openvpn/error.h:380
+# FP: code needs to accomodate many different defines
+knownConditionTrueFalse:src/openvpn/event.c:1148
+# FP: dco_win support has "false" stubs
+knownConditionTrueFalse:src/openvpn/forward.c
+knownConditionTrueFalse:src/openvpn/init.c
+knownConditionTrueFalse:src/openvpn/multi_io.c:163
+# FP: cppcheck thinks that management_query_user_pass is always true,
+# but no idea why
+knownConditionTrueFalse:src/openvpn/misc.c:97
+# FP: cert_uri_supported is a wrapper around defines, so it's
+# always constant but differs depending on OpenSSL version
+knownConditionTrueFalse:src/openvpn/ssl_openssl.c:1258
+# FP: cppcheck doesn't understand that the function changes szErrMessage
+knownConditionTrueFalse:src/tapctl/main.c:704
+knownConditionTrueFalse:src/openvpnmsica/dllmain.c:164
+# FP: cppcheck seems to be confused since we cast the pointer to integer
+memleak:src/plugins/down-root/down-root.c:337
+# FP: eventmsg.h is not built on Unix
+missingInclude:src/openvpnserv/common.c:25
+# IGN: strlen(NULL) is not nice code, but seems to work
+nullPointerRedundantCheck:src/openvpn/init.c:299
+# IGN: We reuse the same variable name due to macro usage
+shadowVariable:src/openvpn/options.c:2580
+shadowVariable:src/openvpn/options.c:2598
+# FP: yes, t_prev is unitialized, but t_prev_len is 0, so that's handled
+uninitvar:src/openvpn/crypto_epoch.c:60
+# FP: yes, parm is unitialized, but parm_len is 0, so that's handled
+uninitvar:src/openvpn/options_parse.c:148
+# FP: uninit is fine when it is a return parameter
+ctuuninitvar:src/openvpn/crypto_mbedtls_legacy.c:698
+uninitvar:src/openvpnserv/interactive.c:1935
+uninitvar:src/tapctl/main.c:566
+# FP: cppcheck doesn't account for short-circuiting
+unreadVariable:src/openvpn/manage.c:682
+unusedFunction:src/openvpn/siphash_reference.c
+# FP: exported as DLL
+unusedFunction:src/openvpnmsica/*.c
+# FP: loaded as plugins
+unusedFunction:src/plugins/*
+unusedFunction:sample/sample-plugins/*
+# FP: wmain
+unusedFunction:src/tapctl/main.c:613
+unusedFunction:tests/unit_tests/openvpnserv/test_openvpnserv.c
+# IGN: keep mocking around for future use
+unusedFunction:tests/unit_tests/openvpn/mock_msg.c
+# FP: doesn't account for --wrap
+unusedFunction:tests/unit_tests/openvpn/test_tls_crypt.c
+unusedFunction:/usr/include/*
+# IGN: old code that is difficult to test (MSG_ERRQUEUE), ignore for now
+unusedStructMember:src/openvpn/mtu.c:281
+# FP: used implictly by NL macros
+unusedStructMember:src/openvpn/networking_sitnl.c
+# IGN: keep explanatory fields in test data
+unusedStructMember:tests/unit_tests/openvpn/test_pkcs11.c
+# IGN: nicer to assign generic "arg" early
+variableScope:src/openvpn/networking_sitnl.c:1390
+# IGN: nicer to keep the "variable" earlier
+variableScope:src/openvpnserv/interactive.c:2687
diff --git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh
new file mode 100755
index 0000000..674fc092
--- /dev/null
+++ b/dev-tools/run-cppcheck.sh
@@ -0,0 +1,26 @@
+#!/bin/bash
+
+set -eu
+
+SCRIPT_DIR=3D$(dirname $(readlink -e "${BASH_SOURCE[0]}"))
+: ${SOURCE_DIR:=3D$SCRIPT_DIR/..}
+: ${BUILD_DIR:=3D$PWD}
+: ${INCLUDE_FLAGS:=3D}
+CPPCHECK_DIR=3D"${BUILD_DIR}/cppcheck_build_dir"
+
+set -x
+
+mkdir -p "$CPPCHECK_DIR"
+cd "${SOURCE_DIR}"
+cppcheck -j$(nproc) \
+	 -DHAVE_CONFIG_H -U_WIN32 \
+         -DMBEDTLS_SSL_PROTO_TLS1_3 -DMBEDTLS_SSL_KEYING_MATERIAL_EXPORT \
+	 -I./include/ -I./tests/unit_tests/openvpn/ \
+	 -I./src/compat/ -I./src/openvpn/ -I./src/openvpnserv/ -I./src/plugins/au=
th-pam/ \
+	 -I"${BUILD_DIR}" -I"${BUILD_DIR}/include/" $INCLUDE_FLAGS \
+	 --enable=3Dall \
+	 --suppressions-list=3D"${SCRIPT_DIR}/cppcheck-suppression" \
+	 --cppcheck-build-dir=3D"${CPPCHECK_DIR}" \
+	 --check-level=3Dexhaustive \
+	 --error-exitcode=3D1 \
+	 src/ tests/ sample/

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1620?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I125cf63f11257d7245ead2f7feafb86b841580a5
Gerrit-Change-Number: 1620
Gerrit-PatchSet: 6
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--jLZJh47PEWk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #6</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1620?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">dev-tools: Add script to run cppche=
ck against the code-base<br><br>Also add a suitable suppressions-list file =
to<br>make it possible to run it without reporting<br>errors.<br><br>Tested=
 with cppcheck 2.19.0 (Ubuntu 26.04).<br><br>Change-Id: I125cf63f11257d7245=
ead2f7feafb86b841580a5<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2716...=
1...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: h=
ttps://gerrit.openvpn.net/c/openvpn/+/1620<br>Message-Id: &lt;2026041913420=
5.21459-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-=
devel@lists.sourceforge.net/msg36664.html<br>Signed-off-by: Gert Doering &l=
t;gert@...1296...&gt;<br>---<br>M Makefile.am<br>A dev-tools/cppcheck-suppr=
ession<br>A dev-tools/run-cppcheck.sh<br>3 files changed, 120 insertions(+)=
, 0 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.n=
et:29418/openvpn refs/changes/20/1620/6</pre><pre style=3D"font-family: mon=
ospace,monospace; white-space: pre-wrap;"><span>diff --git a/Makefile.am b/=
Makefile.am</span><br><span>index 362ae96..2df7eea 100644</span><br><span>-=
-- a/Makefile.am</span><br><span>+++ b/Makefile.am</span><br><span>@@ -89,3=
 +89,10 @@</span><br><span> </span><br><span> doxygen:</span><br><span> 	$(=
MAKE) -C doc/doxygen doxygen</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+.PHONY: cp=
pcheck</span><br><span style=3D"color: hsl(120, 100%, 40%);">+cppcheck:</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+	BUILD_DIR=3D&quot;$(ab=
s_top_builddir)&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	SOURCE_DIR=3D&quot;$(abs_top_srcdir)&quot; \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	INCLUDE_FLAGS=3D&quot;$(LIBNL_GENL_CFLAGS)&q=
uot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		&quot;$(top=
_srcdir)/dev-tools/run-cppcheck.sh&quot;</span><br><span>diff --git a/dev-t=
ools/cppcheck-suppression b/dev-tools/cppcheck-suppression</span><br><span>=
new file mode 100644</span><br><span>index 0000000..1f31edb</span><br><span=
>--- /dev/null</span><br><span>+++ b/dev-tools/cppcheck-suppression</span><=
br><span>@@ -0,0 +1,87 @@</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# We start with --enable=3Dall, but then suppress some issues that ha=
ve too many</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# occure=
nces right now. They still should be fixed at some point</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+constParameter</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constParameterCallback</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+constParameterPointer</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+constVariable</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+constVariablePointer</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+variableScope</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# We have a lot of library includes, not all o=
f them are really required,</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+# so ignore them</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+missingIncludeSystem</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+# cppcheck doesn&#39;t understand about check_malloc_return, so these=
 are</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# usually misle=
ading</span><br><span style=3D"color: hsl(120, 100%, 40%);">+nullPointerOut=
OfMemory</span><br><span style=3D"color: hsl(120, 100%, 40%);">+nullPointer=
ArithmeticOutOfMemory</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# These are specific false-positives (FP) or ignored (IGN) issues</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+# We might want to move som=
e of them to inline-suppression to avoid</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+# the static line-numbers</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+# IGN: multi code does weird things with pointer=
s to local variables...</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+autoVariables:src/openvpn/multi.c:4177</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+autoVariables:src/openvpn/multi_io.c:280</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# IGN: the code header =3D 0 | =
(OPCODE &lt;&lt; P_OPCODE_SHIFT) is used intentionally</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+badBitmaskCheck:src/openvpn/mudp.c</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+badBitmaskCheck:tests/uni=
t_tests/openvpn/test_pkt.c</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# IGN: event code uses a pointer to store integers</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+intToPointerCast:src/openvpn/multi_io=
.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+intToPointerCast:=
src/openvpn/forward.c</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# FP: crt_error is always true on Unix, but not Windows</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/e=
rror.h:380</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: cod=
e needs to accomodate many different defines</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/event.c:1148</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: dco_win support=
 has &quot;false&quot; stubs</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+knownConditionTrueFalse:src/openvpn/forward.c</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/init=
.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+knownConditionTru=
eFalse:src/openvpn/multi_io.c:163</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# FP: cppcheck thinks that management_query_user_pass is alwa=
ys true,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# but no id=
ea why</span><br><span style=3D"color: hsl(120, 100%, 40%);">+knownConditio=
nTrueFalse:src/openvpn/misc.c:97</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+# FP: cert_uri_supported is a wrapper around defines, so it&#3=
9;s</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# always constan=
t but differs depending on OpenSSL version</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/openvpn/ssl_openssl.c:12=
58</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: cppcheck do=
esn&#39;t understand that the function changes szErrMessage</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+knownConditionTrueFalse:src/tapctl/=
main.c:704</span><br><span style=3D"color: hsl(120, 100%, 40%);">+knownCond=
itionTrueFalse:src/openvpnmsica/dllmain.c:164</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# FP: cppcheck seems to be confused since we cast=
 the pointer to integer</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+memleak:src/plugins/down-root/down-root.c:337</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# FP: eventmsg.h is not built on Unix</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+missingInclude:src/openvpns=
erv/common.c:25</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IG=
N: strlen(NULL) is not nice code, but seems to work</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+nullPointerRedundantCheck:src/openvpn/ini=
t.c:299</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: We re=
use the same variable name due to macro usage</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+shadowVariable:src/openvpn/options.c:2580</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+shadowVariable:src/openvpn/=
options.c:2598</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP:=
 yes, t_prev is unitialized, but t_prev_len is 0, so that&#39;s handled</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+uninitvar:src/openvpn/c=
rypto_epoch.c:60</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# F=
P: yes, parm is unitialized, but parm_len is 0, so that&#39;s handled</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+uninitvar:src/openvpn/opt=
ions_parse.c:148</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# F=
P: uninit is fine when it is a return parameter</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ctuuninitvar:src/openvpn/crypto_mbedtls_legacy.=
c:698</span><br><span style=3D"color: hsl(120, 100%, 40%);">+uninitvar:src/=
openvpnserv/interactive.c:1935</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+uninitvar:src/tapctl/main.c:566</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+# FP: cppcheck doesn&#39;t account for short-circuit=
ing</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unreadVariable:s=
rc/openvpn/manage.c:682</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+unusedFunction:src/openvpn/siphash_reference.c</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# FP: exported as DLL</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+unusedFunction:src/openvpnmsica/*.c</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+# FP: loaded as plugins</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+unusedFunction:src/pl=
ugins/*</span><br><span style=3D"color: hsl(120, 100%, 40%);">+unusedFuncti=
on:sample/sample-plugins/*</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+# FP: wmain</span><br><span style=3D"color: hsl(120, 100%, 40%);">+u=
nusedFunction:src/tapctl/main.c:613</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+unusedFunction:tests/unit_tests/openvpnserv/test_openvpnser=
v.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: keep mock=
ing around for future use</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+unusedFunction:tests/unit_tests/openvpn/mock_msg.c</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+# FP: doesn&#39;t account for --wrap</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+unusedFunction:tests/=
unit_tests/openvpn/test_tls_crypt.c</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+unusedFunction:/usr/include/*</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+# IGN: old code that is difficult to test (MSG_ER=
RQUEUE), ignore for now</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+unusedStructMember:src/openvpn/mtu.c:281</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+# FP: used implictly by NL macros</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+unusedStructMember:src/openvpn/netwo=
rking_sitnl.c</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN:=
 keep explanatory fields in test data</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+unusedStructMember:tests/unit_tests/openvpn/test_pkcs11.c=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# IGN: nicer to ass=
ign generic &quot;arg&quot; early</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+variableScope:src/openvpn/networking_sitnl.c:1390</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+# IGN: nicer to keep the &quot;=
variable&quot; earlier</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+variableScope:src/openvpnserv/interactive.c:2687</span><br><span>diff --=
git a/dev-tools/run-cppcheck.sh b/dev-tools/run-cppcheck.sh</span><br><span=
>new file mode 100755</span><br><span>index 0000000..674fc092</span><br><sp=
an>--- /dev/null</span><br><span>+++ b/dev-tools/run-cppcheck.sh</span><br>=
<span>@@ -0,0 +1,26 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#!/bin/bash</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+set -eu</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+SCRIPT_DIR=3D$(dirname $(readlink -e &quot;${BASH_SOURC=
E[0]}&quot;))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+: ${SO=
URCE_DIR:=3D$SCRIPT_DIR/..}</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+: ${BUILD_DIR:=3D$PWD}</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+: ${INCLUDE_FLAGS:=3D}</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+CPPCHECK_DIR=3D&quot;${BUILD_DIR}/cppcheck_build_dir&quot;</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+set -x</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+mkdir -p &quot;$CPPCHECK_DIR&quot;</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+cd &quot;${SOURCE_DIR}&quot;</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+cppcheck -j$(nproc) \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+	 -DHAVE_CONFIG_H -U_WIN32 \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+         -DMBEDTLS_SSL_PROTO_TLS1_3 -D=
MBEDTLS_SSL_KEYING_MATERIAL_EXPORT \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	 -I./include/ -I./tests/unit_tests/openvpn/ \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	 -I./src/compat/ -I./src/openv=
pn/ -I./src/openvpnserv/ -I./src/plugins/auth-pam/ \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	 -I&quot;${BUILD_DIR}&quot; -I&quot;${BU=
ILD_DIR}/include/&quot; $INCLUDE_FLAGS \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	 --enable=3Dall \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	 --suppressions-list=3D&quot;${SCRIPT_DIR}/cppcheck-su=
ppression&quot; \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	 =
--cppcheck-build-dir=3D&quot;${CPPCHECK_DIR}&quot; \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	 --check-level=3Dexhaustive \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	 --error-exitcode=3D1 \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+	 src/ tests/ sample/</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1620?usp=3Demail">change 1620</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1620?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I125cf63f11257d7245ead2f7fea=
fb86b841580a5 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1620 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 6 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--jLZJh47PEWk=--

