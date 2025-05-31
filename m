From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 31 May 2025 20:45:41 +0000
In-Reply-To: <gerrit.1748433126000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
References: <gerrit.1748433126000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <daab0503ea53dfb05d3ce1204a02bd105d1c696f-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="bhsOEECfGHg="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add missing header
 in unit tests Makefile.am
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--bhsOEECfGHg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

cron2 has uploaded a new patch set (#4) to the change originally created by=
 plaisthos. ( http://gerrit.openvpn.net/c/openvpn/+/1033?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Add missing header in unit tests Makefile.am
......................................................................

Add missing header in unit tests Makefile.am

make distcheck fails since we are not listing all headers that are
used by the unit tests.

Change-Id: I674af04e1a6449544b7def0725337c3b353ea276
---
M tests/unit_tests/openvpn/Makefile.am
1 file changed, 24 insertions(+), 12 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1033/4

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index fc47287..b47b495 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -43,7 +43,8 @@

 argv_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/sr=
c/compat @TEST_CFLAGS@
 argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl=
,--wrap=3Dparse_line
-argv_testdriver_SOURCES =3D test_argv.c mock_msg.c mock_msg.h test_common.=
h \
+argv_testdriver_SOURCES =3D test_argv.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -52,7 +53,8 @@

 buffer_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/=
src/compat @TEST_CFLAGS@
 buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -=
Wl,--wrap=3Dparse_line
-buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c mock_msg.h test_com=
mon.h \
+buffer_testdriver_SOURCES =3D test_buffer.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c
@@ -61,7 +63,8 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
 crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-crypto_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h test_com=
mon.h \
+crypto_testdriver_SOURCES =3D test_crypto.c \
+	mock_msg.c mock_msg.h test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -78,8 +81,10 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
-ssl_testdriver_SOURCES =3D test_ssl.c mock_msg.c mock_msg.h test_common.h \
-	mock_management.c mock_ssl_dependencies.c mock_win32_execve.c \
+ssl_testdriver_SOURCES =3D test_ssl.c \
+	mock_msg.c mock_msg.h test_common.h \
+	mock_management.c \
+	mock_ssl_dependencies.c mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -114,7 +119,8 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
 packet_id_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-packet_id_testdriver_SOURCES =3D test_packet_id.c mock_msg.c mock_msg.h te=
st_common.h \
+packet_id_testdriver_SOURCES =3D test_packet_id.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -156,7 +162,8 @@
 	-Wl,--wrap=3Dbuffer_write_file \
 	-Wl,--wrap=3Dparse_line \
 	-Wl,--wrap=3Drand_bytes
-tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_msg.h te=
st_common.h \
+tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
@@ -229,7 +236,8 @@
 	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
 pkcs11_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
-pkcs11_testdriver_SOURCES =3D test_pkcs11.c mock_msg.c \
+pkcs11_testdriver_SOURCES =3D test_pkcs11.c \
+	mock_msg.c test_common.h \
 	pkey_test_utils.c cert_data.h mock_get_random.c \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
 	$(top_srcdir)/src/openvpn/xkey_provider.c \
@@ -251,7 +259,8 @@
 auth_token_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)

-auth_token_testdriver_SOURCES =3D test_auth_token.c mock_msg.c \
+auth_token_testdriver_SOURCES =3D test_auth_token.c \
+	mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
@@ -269,7 +278,8 @@
 	@TEST_CFLAGS@
 user_pass_testdriver_LDFLAGS =3D @TEST_LDFLAGS@

-user_pass_testdriver_SOURCES =3D test_user_pass.c mock_msg.c \
+user_pass_testdriver_SOURCES =3D test_user_pass.c \
+	mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/console.c \
 	$(top_srcdir)/src/openvpn/env_set.c \
@@ -287,7 +297,8 @@
 ncp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)

-ncp_testdriver_SOURCES =3D test_ncp.c mock_msg.c \
+ncp_testdriver_SOURCES =3D test_ncp.c \
+	mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
@@ -306,7 +317,8 @@

 misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@

-misc_testdriver_SOURCES =3D test_misc.c mock_msg.c \
+misc_testdriver_SOURCES =3D test_misc.c \
+	mock_msg.c test_common.h  \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/options_util.c \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1033?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I674af04e1a6449544b7def0725337c3b353ea276
Gerrit-Change-Number: 1033
Gerrit-PatchSet: 4
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--bhsOEECfGHg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by plaisthos.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/=
1033?usp=3Demail">View Change</a></p><p>The following approvals got outdate=
d and were removed:
Code-Review+2 by cron2</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">Add missing header in unit tests Makefile.am<br><br>=
make distcheck fails since we are not listing all headers that are<br>used =
by the unit tests.<br><br>Change-Id: I674af04e1a6449544b7def0725337c3b353ea=
276<br>---<br>M tests/unit_tests/openvpn/Makefile.am<br>1 file changed, 24 =
insertions(+), 12 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/33/1033/4</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/=
openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>=
index fc47287..b47b495 100644</span><br><span>--- a/tests/unit_tests/openvp=
n/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</s=
pan><br><span>@@ -43,7 +43,8 @@</span><br><span> </span><br><span> argv_tes=
tdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat =
@TEST_CFLAGS@</span><br><span> argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -=
L$(top_srcdir)/src/openvpn -Wl,--wrap=3Dparse_line</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-argv_testdriver_SOURCES =3D test_argv.c mock_m=
sg.c mock_msg.h test_common.h \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+argv_testdriver_SOURCES =3D test_argv.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_common.h \</s=
pan><br><span> 	mock_get_random.c \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/platform.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</s=
pan><br><span>@@ -52,7 +53,8 @@</span><br><span> </span><br><span> buffer_t=
estdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compa=
t @TEST_CFLAGS@</span><br><span> buffer_testdriver_LDFLAGS =3D @TEST_LDFLAG=
S@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=3Dparse_line</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-buffer_testdriver_SOURCES =3D test_buffer.=
c mock_msg.c mock_msg.h test_common.h \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+buffer_testdriver_SOURCES =3D test_buffer.c \</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_c=
ommon.h \</span><br><span> 	mock_get_random.c \</span><br><span> 	$(top_src=
dir)/src/openvpn/win32-util.c \</span><br><span> 	$(top_srcdir)/src/openvpn=
/platform.c</span><br><span>@@ -61,7 +63,8 @@</span><br><span> 	-I$(top_src=
dir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span=
><br><span> 	@TEST_CFLAGS@</span><br><span> crypto_testdriver_LDFLAGS =3D @=
TEST_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-crypto_t=
estdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h test_common.h \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_testdriver_SOU=
RCES =3D test_crypto.c \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	mock_msg.c mock_msg.h test_common.h \</span><br><span> 	$(top_srcdir)=
/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><b=
r><span>@@ -78,8 +81,10 @@</span><br><span> 	-I$(top_srcdir)/include -I$(to=
p_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_=
CFLAGS@</span><br><span> ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIO=
NAL_CRYPTO_LIBS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ssl_t=
estdriver_SOURCES =3D test_ssl.c mock_msg.c mock_msg.h test_common.h \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	mock_management.c mock_ss=
l_dependencies.c mock_win32_execve.c \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+ssl_testdriver_SOURCES =3D test_ssl.c \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_common.h=
 \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_management.=
c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_ssl_depend=
encies.c mock_win32_execve.c \</span><br><span> 	$(top_srcdir)/src/openvpn/=
argv.c \</span><br><span> 	$(top_srcdir)/src/openvpn/base64.c \</span><br><=
span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span>@@ -114,7 +119,=
8 @@</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -=
I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><spa=
n> packet_id_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-packet_id_testdriver_SOURCES =3D test_packet_i=
d.c mock_msg.c mock_msg.h test_common.h \</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+packet_id_testdriver_SOURCES =3D test_packet_id.c \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.=
h test_common.h \</span><br><span> 	mock_get_random.c \</span><br><span> 	$=
(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/otime.c \</span><br><span>@@ -156,7 +162,8 @@</span><br><span> 	-Wl,--=
wrap=3Dbuffer_write_file \</span><br><span> 	-Wl,--wrap=3Dparse_line \</spa=
n><br><span> 	-Wl,--wrap=3Drand_bytes</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.=
c mock_msg.h test_common.h \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_common=
.h \</span><br><span> 	mock_win32_execve.c \</span><br><span> 	$(top_srcdir=
)/src/openvpn/argv.c \</span><br><span> 	$(top_srcdir)/src/openvpn/base64.c=
 \</span><br><span>@@ -229,7 +236,8 @@</span><br><span> 	@TEST_CFLAGS@ $(OP=
TIONAL_CRYPTO_CFLAGS)</span><br><span> pkcs11_testdriver_LDFLAGS =3D @TEST_=
LDFLAGS@ \</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-pkcs11_testdriver_SOURCES =3D test_pkcs11.c=
 mock_msg.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkcs11=
_testdriver_SOURCES =3D test_pkcs11.c \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	mock_msg.c test_common.h \</span><br><span> 	pkey_test=
_utils.c cert_data.h mock_get_random.c \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/xkey_helper.c \</span><br><span> 	$(top_srcdir)/src/openvpn/xkey_=
provider.c \</span><br><span>@@ -251,7 +259,8 @@</span><br><span> auth_toke=
n_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \</span><br><span> 	$(OPTIONAL_CRYP=
TO_LIBS)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-auth_token_testdriver_SOURCES =3D test_auth_token.c mock_msg.c \</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_token_testdriver_SOU=
RCES =3D test_auth_token.c \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	mock_msg.c test_common.h \</span><br><span> 	$(top_srcdir)/src/op=
envpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</sp=
an><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span>@=
@ -269,7 +278,8 @@</span><br><span> 	@TEST_CFLAGS@</span><br><span> user_pa=
ss_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> </span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-user_pass_testdriver_SOURCES =3D test_=
user_pass.c mock_msg.c \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+user_pass_testdriver_SOURCES =3D test_user_pass.c \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_common.h \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir=
)/src/openvpn/console.c \</span><br><span> 	$(top_srcdir)/src/openvpn/env_s=
et.c \</span><br><span>@@ -287,7 +297,8 @@</span><br><span> ncp_testdriver_=
LDFLAGS =3D @TEST_LDFLAGS@ \</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</spa=
n><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ncp_test=
driver_SOURCES =3D test_ncp.c mock_msg.c \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+ncp_testdriver_SOURCES =3D test_ncp.c \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_common.h \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_=
srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/openvpn/=
crypto_epoch.c \</span><br><span>@@ -306,7 +317,8 @@</span><br><span> </spa=
n><br><span> misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> </=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-misc_testdriver_SOURCES=
 =3D test_misc.c mock_msg.c \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+misc_testdriver_SOURCES =3D test_misc.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_common.h  \</span><br><s=
pan> 	mock_get_random.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffe=
r.c \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util.c \</span><b=
r><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn=
.net/c/openvpn/+/1033?usp=3Demail">change 1033</a>. To unsubscribe, or for =
help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/setti=
ngs">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMes=
sage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/View=
Action"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/=
+/1033?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I674af04e1a6449544b7def07253=
37c3b353ea276 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1033 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--bhsOEECfGHg=--

