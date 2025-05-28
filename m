From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 28 May 2025 11:52:07 +0000
References: <gerrit.1748433126000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ab2d78fcd3069bb2004dfd147ee8014b7678ae6d-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FWiMjV0YMsE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FWiMjV0YMsE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1033?usp=3Demail

to review the following change.


Change subject: Add missing header in unit tests Makefile.am
......................................................................

Add missing header in unit tests Makefile.am

make distcheck fails since we are not listing all headers that are
used by the unit tests.

Change-Id: I674af04e1a6449544b7def0725337c3b353ea276
---
M tests/unit_tests/openvpn/Makefile.am
1 file changed, 24 insertions(+), 12 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/33/1033/1

diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 471389b..d395bba 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -43,7 +43,8 @@

 argv_testdriver_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/sr=
c/compat @TEST_CFLAGS@
 argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl=
,--wrap=3Dparse_line
-argv_testdriver_SOURCES =3D test_argv.c mock_msg.c mock_msg.h \
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
-buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c mock_msg.h \
+buffer_testdriver_SOURCES =3D test_buffer.c \
+    mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c
@@ -61,7 +63,8 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
 crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-crypto_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h \
+crypto_testdriver_SOURCES =3D test_crypto.c \
+    mock_msg.c mock_msg.h test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -78,8 +81,10 @@
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \
 	@TEST_CFLAGS@
 ssl_testdriver_LDFLAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)
-ssl_testdriver_SOURCES =3D test_ssl.c mock_msg.c mock_msg.h \
-	mock_management.c mock_ssl_dependencies.c mock_win32_execve.c \
+ssl_testdriver_SOURCES =3D test_ssl.c \
+    mock_msg.c mock_msg.h test_common.h \
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
-packet_id_testdriver_SOURCES =3D test_packet_id.c mock_msg.c mock_msg.h \
+packet_id_testdriver_SOURCES =3D test_packet_id.c \
+    mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -156,7 +162,8 @@
 	-Wl,--wrap=3Dbuffer_write_file \
 	-Wl,--wrap=3Dparse_line \
 	-Wl,--wrap=3Drand_bytes
-tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_msg.h \
+tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c \
+    mock_msg.c mock_msg.h test_common.h \
 	mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
@@ -229,7 +236,8 @@
 	@TEST_CFLAGS@ $(OPTIONAL_CRYPTO_CFLAGS)
 pkcs11_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)
-pkcs11_testdriver_SOURCES =3D test_pkcs11.c mock_msg.c \
+pkcs11_testdriver_SOURCES =3D test_pkcs11.c \
+ 	mock_msg.c test_common.h \
 	pkey_test_utils.c cert_data.h mock_get_random.c \
 	$(top_srcdir)/src/openvpn/xkey_helper.c \
 	$(top_srcdir)/src/openvpn/xkey_provider.c \
@@ -251,7 +259,8 @@
 auth_token_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)

-auth_token_testdriver_SOURCES =3D test_auth_token.c mock_msg.c \
+auth_token_testdriver_SOURCES =3D test_auth_token.c \
+    mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_epoch.c \
@@ -269,7 +278,8 @@
 	@TEST_CFLAGS@
 user_pass_testdriver_LDFLAGS =3D @TEST_LDFLAGS@

-user_pass_testdriver_SOURCES =3D test_user_pass.c mock_msg.c \
+user_pass_testdriver_SOURCES =3D test_user_pass.c \
+ 	mock_msg.c test_common.h \
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--FWiMjV0YMsE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1033?usp=3Demail">V=
iew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">Add missing header in unit tests Makefile.am<br><br>make dis=
tcheck fails since we are not listing all headers that are<br>used by the u=
nit tests.<br><br>Change-Id: I674af04e1a6449544b7def0725337c3b353ea276<br>-=
--<br>M tests/unit_tests/openvpn/Makefile.am<br>1 file changed, 24 insertio=
ns(+), 12 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,mo=
nospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/op=
envpn refs/changes/33/1033/1</pre><pre style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;"><span>diff --git a/tests/unit_tests/openvpn/=
Makefile.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>index 47=
1389b..d395bba 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefi=
le.am</span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br>=
<span>@@ -43,7 +43,8 @@</span><br><span> </span><br><span> argv_testdriver_=
CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CF=
LAGS@</span><br><span> argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_s=
rcdir)/src/openvpn -Wl,--wrap=3Dparse_line</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-argv_testdriver_SOURCES =3D test_argv.c mock_msg.c moc=
k_msg.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+argv_testd=
river_SOURCES =3D test_argv.c \</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	mock_msg.c mock_msg.h test_common.h \</span><br><span> 	mock_g=
et_random.c \</span><br><span> 	$(top_srcdir)/src/openvpn/platform.c \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span>@@ -52,7=
 +53,8 @@</span><br><span> </span><br><span> buffer_testdriver_CFLAGS  =3D =
-I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat @TEST_CFLAGS@</span>=
<br><span> buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src=
/openvpn -Wl,--wrap=3Dparse_line</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c mock_msg.=
h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+buffer_testdrive=
r_SOURCES =3D test_buffer.c \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    mock_msg.c mock_msg.h test_common.h \</span><br><span> 	mock_=
get_random.c \</span><br><span> 	$(top_srcdir)/src/openvpn/win32-util.c \</=
span><br><span> 	$(top_srcdir)/src/openvpn/platform.c</span><br><span>@@ -6=
1,7 +63,8 @@</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/=
compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_CFLAGS@</span>=
<br><span> crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-crypto_testdriver_SOURCES =3D test_crypto=
.c mock_msg.c mock_msg.h \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+crypto_testdriver_SOURCES =3D test_crypto.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    mock_msg.c mock_msg.h test_common.h \=
</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$=
(top_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/crypto_mbedtls.c \</span><br><span>@@ -78,8 +81,10 @@</span><br><span>=
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn \</span><br><span> 	@TEST_CFLAGS@</span><br><span> ssl_testdriver_LDF=
LAGS =3D @TEST_LDFLAGS@  $(OPTIONAL_CRYPTO_LIBS)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-ssl_testdriver_SOURCES =3D test_ssl.c mock_msg.c=
 mock_msg.h \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	mock_ma=
nagement.c mock_ssl_dependencies.c mock_win32_execve.c \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ssl_testdriver_SOURCES =3D test_ssl.c =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mock_msg.c moc=
k_msg.h test_common.h \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	mock_management.c \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+	mock_ssl_dependencies.c mock_win32_execve.c \</span><br><span> 	$(top=
_srcdir)/src/openvpn/argv.c \</span><br><span> 	$(top_srcdir)/src/openvpn/b=
ase64.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br>=
<span>@@ -114,7 +119,8 @@</span><br><span> 	-I$(top_srcdir)/include -I$(top=
_srcdir)/src/compat -I$(top_srcdir)/src/openvpn \</span><br><span> 	@TEST_C=
FLAGS@</span><br><span> packet_id_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-packet_id_testdriver_SOUR=
CES =3D test_packet_id.c mock_msg.c mock_msg.h \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+packet_id_testdriver_SOURCES =3D test_packet_i=
d.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    mock_msg.c=
 mock_msg.h test_common.h \</span><br><span> 	mock_get_random.c \</span><br=
><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/otime.c \</span><br><span>@@ -156,7 +162,8 @@</span><br><spa=
n> 	-Wl,--wrap=3Dbuffer_write_file \</span><br><span> 	-Wl,--wrap=3Dparse_l=
ine \</span><br><span> 	-Wl,--wrap=3Drand_bytes</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c=
 mock_msg.c mock_msg.h \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+    mock_msg.c mock_msg.h test_common.=
h \</span><br><span> 	mock_win32_execve.c \</span><br><span> 	$(top_srcdir)=
/src/openvpn/argv.c \</span><br><span> 	$(top_srcdir)/src/openvpn/base64.c =
\</span><br><span>@@ -229,7 +236,8 @@</span><br><span> 	@TEST_CFLAGS@ $(OPT=
IONAL_CRYPTO_CFLAGS)</span><br><span> pkcs11_testdriver_LDFLAGS =3D @TEST_L=
DFLAGS@ \</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-pkcs11_testdriver_SOURCES =3D test_pkcs11.c=
 mock_msg.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkcs11=
_testdriver_SOURCES =3D test_pkcs11.c \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ 	mock_msg.c test_common.h \</span><br><span> 	pkey_tes=
t_utils.c cert_data.h mock_get_random.c \</span><br><span> 	$(top_srcdir)/s=
rc/openvpn/xkey_helper.c \</span><br><span> 	$(top_srcdir)/src/openvpn/xkey=
_provider.c \</span><br><span>@@ -251,7 +259,8 @@</span><br><span> auth_tok=
en_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \</span><br><span> 	$(OPTIONAL_CRY=
PTO_LIBS)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-auth_token_testdriver_SOURCES =3D test_auth_token.c mock_msg.c \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+auth_token_testdriver_SO=
URCES =3D test_auth_token.c \</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    mock_msg.c test_common.h \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \=
</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_epoch.c \</span><br><sp=
an>@@ -269,7 +278,8 @@</span><br><span> 	@TEST_CFLAGS@</span><br><span> use=
r_pass_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span> </span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-user_pass_testdriver_SOURCES =3D t=
est_user_pass.c mock_msg.c \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+user_pass_testdriver_SOURCES =3D test_user_pass.c \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ 	mock_msg.c test_common.h \</span=
><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_s=
rcdir)/src/openvpn/console.c \</span><br><span> 	$(top_srcdir)/src/openvpn/=
env_set.c \</span><br><span>@@ -287,7 +297,8 @@</span><br><span> ncp_testdr=
iver_LDFLAGS =3D @TEST_LDFLAGS@ \</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-ncp=
_testdriver_SOURCES =3D test_ncp.c mock_msg.c \</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ncp_testdriver_SOURCES =3D test_ncp.c \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_common.h \=
</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$=
(top_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/crypto_epoch.c \</span><br><span>@@ -306,7 +317,8 @@</span><br><span> =
</span><br><span> misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-misc_testdriver_SO=
URCES =3D test_misc.c mock_msg.c \</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+misc_testdriver_SOURCES =3D test_misc.c \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_common.h  \</span><br=
><span> 	mock_get_random.c \</span><br><span> 	$(top_srcdir)/src/openvpn/bu=
ffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/options_util.c \</span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/1033?usp=3Demail">change 1033</a>. To unsubscribe, or f=
or help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/se=
ttings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/Email=
Message"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/V=
iewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openv=
pn/+/1033?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></=
div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I674af04e1a6449544b7def07253=
37c3b353ea276 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1033 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--FWiMjV0YMsE=--

