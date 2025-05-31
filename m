From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 31 May 2025 20:53:30 +0000
In-Reply-To: <gerrit.1748433126000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
References: <gerrit.1748433126000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <e429cd0db65a269aee9007ef98895a86d882558b-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="am88c3QlHRo="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--am88c3QlHRo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/10=
33?usp=3Demail )

Change subject: Add missing header in unit tests Makefile.am
......................................................................

Add missing header in unit tests Makefile.am

make distcheck fails since we are not listing all headers that are
used by the unit tests.

Change-Id: I674af04e1a6449544b7def0725337c3b353ea276
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20250531204720.28156-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg31=
830.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/Makefile.am
1 file changed, 24 insertions(+), 12 deletions(-)




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
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--am88c3QlHRo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/1033?usp=3Demail">View Change</a></p><div styl=
e=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">Add missing header in unit tests Makefile.am<=
br><br>make distcheck fails since we are not listing all headers that are<b=
r>used by the unit tests.<br><br>Change-Id: I674af04e1a6449544b7def0725337c=
3b353ea276<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<b=
r>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Message-Id: &lt;2025053=
1204720.28156-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/op=
envpn-devel@lists.sourceforge.net/msg31830.html<br>Signed-off-by: Gert Doer=
ing &lt;gert@...1296...&gt;<br>---<br>M tests/unit_tests/openvpn/Makefile.a=
m<br>1 file changed, 24 insertions(+), 12 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/ope=
nvpn/Makefile.am</span><br><span>index fc47287..b47b495 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/=
unit_tests/openvpn/Makefile.am</span><br><span>@@ -43,7 +43,8 @@</span><br>=
<span> </span><br><span> argv_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/op=
envpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@</span><br><span> argv_testdr=
iver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=3Dpa=
rse_line</span><br><span style=3D"color: hsl(0, 100%, 40%);">-argv_testdriv=
er_SOURCES =3D test_argv.c mock_msg.c mock_msg.h test_common.h \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+argv_testdriver_SOURCES =3D te=
st_argv.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_ms=
g.c mock_msg.h test_common.h \</span><br><span> 	mock_get_random.c \</span>=
<br><span> 	$(top_srcdir)/src/openvpn/platform.c \</span><br><span> 	$(top_=
srcdir)/src/openvpn/buffer.c \</span><br><span>@@ -52,7 +53,8 @@</span><br>=
<span> </span><br><span> buffer_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/=
openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@</span><br><span> buffer_te=
stdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=
=3Dparse_line</span><br><span style=3D"color: hsl(0, 100%, 40%);">-buffer_t=
estdriver_SOURCES =3D test_buffer.c mock_msg.c mock_msg.h test_common.h \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+buffer_testdriver_SOU=
RCES =3D test_buffer.c \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	mock_msg.c mock_msg.h test_common.h \</span><br><span> 	mock_get_rand=
om.c \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</span><br=
><span> 	$(top_srcdir)/src/openvpn/platform.c</span><br><span>@@ -61,7 +63,=
8 @@</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -=
I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><spa=
n> crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-crypto_testdriver_SOURCES =3D test_crypto.c mock_=
msg.c mock_msg.h test_common.h \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+crypto_testdriver_SOURCES =3D test_crypto.c \</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_common.h=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> =
	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/o=
penvpn/crypto_mbedtls.c \</span><br><span>@@ -78,8 +81,10 @@</span><br><spa=
n> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/=
openvpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_L=
DFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-ssl_testdriver_SOURCES =3D test_ssl.c mock_msg=
.c mock_msg.h test_common.h \</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	mock_management.c mock_ssl_dependencies.c mock_win32_execve.c \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+ssl_testdriver_SOURCES=
 =3D test_ssl.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	m=
ock_msg.c mock_msg.h test_common.h \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	mock_management.c \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	mock_ssl_dependencies.c mock_win32_execve.c \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/argv.c \</span><br><span> 	$(top_srcdir)/=
src/openvpn/base64.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c=
 \</span><br><span>@@ -114,7 +119,8 @@</span><br><span> 	-I$(top_srcdir)/in=
clude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><s=
pan> 	@TEST_CFLAGS@</span><br><span> packet_id_testdriver_LDFLAGS =3D @TEST=
_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_te=
stdriver_SOURCES =3D test_packet_id.c mock_msg.c mock_msg.h test_common.h \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+packet_id_testdrive=
r_SOURCES =3D test_packet_id.c \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	mock_msg.c mock_msg.h test_common.h \</span><br><span> 	mock_=
get_random.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span=
><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><span>@@ -156,7 =
+162,8 @@</span><br><span> 	-Wl,--wrap=3Dbuffer_write_file \</span><br><spa=
n> 	-Wl,--wrap=3Dparse_line \</span><br><span> 	-Wl,--wrap=3Drand_bytes</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-tls_crypt_testdriver_SOUR=
CES =3D test_tls_crypt.c mock_msg.c mock_msg.h test_common.h \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+tls_crypt_testdriver_SOURCES =3D=
 test_tls_crypt.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
	mock_msg.c mock_msg.h test_common.h \</span><br><span> 	mock_win32_execve.=
c \</span><br><span> 	$(top_srcdir)/src/openvpn/argv.c \</span><br><span> 	=
$(top_srcdir)/src/openvpn/base64.c \</span><br><span>@@ -229,7 +236,8 @@</s=
pan><br><span> 	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)</span><br><span> pk=
cs11_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \</span><br><span> 	$(OPTIONAL_C=
RYPTO_LIBS)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pkcs11_tes=
tdriver_SOURCES =3D test_pkcs11.c mock_msg.c \</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+pkcs11_testdriver_SOURCES =3D test_pkcs11.c \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_commo=
n.h \</span><br><span> 	pkey_test_utils.c cert_data.h mock_get_random.c \</=
span><br><span> 	$(top_srcdir)/src/openvpn/xkey_helper.c \</span><br><span>=
 	$(top_srcdir)/src/openvpn/xkey_provider.c \</span><br><span>@@ -251,7 +25=
9,8 @@</span><br><span> auth_token_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \<=
/span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span> </span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-auth_token_testdriver_SOURCES =3D tes=
t_auth_token.c mock_msg.c \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+auth_token_testdriver_SOURCES =3D test_auth_token.c \</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_common.h \</span=
><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/openvpn/c=
rypto_epoch.c \</span><br><span>@@ -269,7 +278,8 @@</span><br><span> 	@TEST=
_CFLAGS@</span><br><span> user_pass_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-user_=
pass_testdriver_SOURCES =3D test_user_pass.c mock_msg.c \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+user_pass_testdriver_SOURCES =3D test=
_user_pass.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock=
_msg.c test_common.h \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/console.c \</span><br><span>=
 	$(top_srcdir)/src/openvpn/env_set.c \</span><br><span>@@ -287,7 +297,8 @@=
</span><br><span> ncp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \</span><br><sp=
an> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span> </span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-ncp_testdriver_SOURCES =3D test_ncp.c mock_msg.c \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ncp_testdriver_SOUR=
CES =3D test_ncp.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+	mock_msg.c test_common.h \</span><br><span> 	$(top_srcdir)/src/openvpn/bu=
ffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><=
span> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><span>@@ -306,7=
 +317,8 @@</span><br><span> </span><br><span> misc_testdriver_LDFLAGS =3D @=
TEST_LDFLAGS@</span><br><span> </span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-misc_testdriver_SOURCES =3D test_misc.c mock_msg.c \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+misc_testdriver_SOURCES =3D test=
_misc.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.=
c test_common.h  \</span><br><span> 	mock_get_random.c \</span><br><span> 	=
$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/options_util.c \</span><br><span></span><br></pre><p>To view, visit <=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1033?usp=3Demail">change 10=
33</a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"=
http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtyp=
e=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" ite=
mtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:=
//gerrit.openvpn.net/c/openvpn/+/1033?usp=3Demail"/><meta itemprop=3D"name"=
 content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I674af04e1a6449544b7def07253=
37c3b353ea276 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1033 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--am88c3QlHRo=--

