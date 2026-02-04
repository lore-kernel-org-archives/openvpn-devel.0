From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Feb 2026 16:25:14 +0000
In-Reply-To: <gerrit.1770218040000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
References: <gerrit.1770218040000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a58dfe27b827777d428d57069a3620eae8c2f099-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mG4dJ8fpzvQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Add missing
 header in unit tests Makefile.am
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

--mG4dJ8fpzvQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/15=
09?usp=3Demail )

Change subject: Add missing header in unit tests Makefile.am
......................................................................

Add missing header in unit tests Makefile.am

make distcheck fails since we are not listing all headers that are
used by the unit tests.

Change-Id: I674af04e1a6449544b7def0725337c3b353ea276
Signed-off-by: Arne Schwabe <arne-openvpn@...1227...>
(cherry picked from commit c2776ee0ff03832bb2213ebd19e9a14d37445bed)
Acked-by: Gert Doering <gert@...1296...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1509
https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg35534.h=
tml
Message-Id: <20260204161322.149284-1-frank@...2641...>
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/Makefile.am
1 file changed, 17 insertions(+), 9 deletions(-)




diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 38a7ab4..0a0f4f0 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -32,7 +32,8 @@

 argv_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn -I$(=
top_srcdir)/src/compat
 argv_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl=
,--wrap=3Dparse_line
-argv_testdriver_SOURCES =3D test_argv.c mock_msg.c mock_msg.h \
+argv_testdriver_SOURCES =3D test_argv.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/platform.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -41,7 +42,8 @@

 buffer_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn -I=
$(top_srcdir)/src/compat
 buffer_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -=
Wl,--wrap=3Dparse_line
-buffer_testdriver_SOURCES =3D test_buffer.c mock_msg.c mock_msg.h \
+buffer_testdriver_SOURCES =3D test_buffer.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/win32-util.c \
 	$(top_srcdir)/src/openvpn/platform.c
@@ -49,7 +51,8 @@
 crypto_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn
 crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-crypto_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h \
+crypto_testdriver_SOURCES =3D test_crypto.c \
+	mock_msg.c mock_msg.h test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -64,7 +67,8 @@
 packet_id_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn
 packet_id_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-packet_id_testdriver_SOURCES =3D test_packet_id.c mock_msg.c mock_msg.h \
+packet_id_testdriver_SOURCES =3D test_packet_id.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/otime.c \
@@ -77,7 +81,7 @@
 pkt_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-pkt_testdriver_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h mock_win32_exe=
cve.c \
+pkt_testdriver_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h mock_win32_exe=
cve.c test_common.h \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -103,7 +107,8 @@
 	-Wl,--wrap=3Dbuffer_write_file \
 	-Wl,--wrap=3Dparse_line \
 	-Wl,--wrap=3Drand_bytes
-tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_msg.h \
+tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c \
+	mock_msg.c mock_msg.h test_common.h \
 	mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
@@ -174,7 +179,8 @@
 auth_token_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)

-auth_token_testdriver_SOURCES =3D test_auth_token.c mock_msg.c \
+auth_token_testdriver_SOURCES =3D test_auth_token.c \
+	mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -192,7 +198,8 @@
 ncp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \
 	$(OPTIONAL_CRYPTO_LIBS)

-ncp_testdriver_SOURCES =3D test_ncp.c mock_msg.c \
+ncp_testdriver_SOURCES =3D test_ncp.c \
+	mock_msg.c test_common.h \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/crypto.c \
 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
@@ -209,7 +216,8 @@

 misc_testdriver_LDFLAGS =3D @TEST_LDFLAGS@

-misc_testdriver_SOURCES =3D test_misc.c mock_msg.c \
+misc_testdriver_SOURCES =3D test_misc.c \
+	mock_msg.c test_common.h  \
 	mock_get_random.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
 	$(top_srcdir)/src/openvpn/options_util.c \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1509?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I674af04e1a6449544b7def0725337c3b353ea276
Gerrit-Change-Number: 1509
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: plaisthos <arne-openvpn@...1227...>

--mG4dJ8fpzvQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1509?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Add missing header in unit tests Makefile.am<br>=
<br>make distcheck fails since we are not listing all headers that are<br>u=
sed by the unit tests.<br><br>Change-Id: I674af04e1a6449544b7def0725337c3b3=
53ea276<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...1227...&gt;<br>(=
cherry picked from commit c2776ee0ff03832bb2213ebd19e9a14d37445bed)<br>Acke=
d-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Arne Schwabe &lt;ar=
ne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.openvpn.net/c/openv=
pn/+/1509<br>https://www.mail-archive.com/openvpn-devel@...1223...=
et/msg35534.html<br>Message-Id: &lt;20260204161322.149284-1-frank@...2723...=
.&gt;<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M te=
sts/unit_tests/openvpn/Makefile.am<br>1 file changed, 17 insertions(+), 9 d=
eletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/ope=
nvpn/Makefile.am</span><br><span>index 38a7ab4..0a0f4f0 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/=
unit_tests/openvpn/Makefile.am</span><br><span>@@ -32,7 +32,8 @@</span><br>=
<span> </span><br><span> argv_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(top_=
srcdir)/src/openvpn -I$(top_srcdir)/src/compat</span><br><span> argv_testdr=
iver_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=3Dpa=
rse_line</span><br><span style=3D"color: hsl(0, 100%, 40%);">-argv_testdriv=
er_SOURCES =3D test_argv.c mock_msg.c mock_msg.h \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+argv_testdriver_SOURCES =3D test_argv.c \</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h=
 test_common.h \</span><br><span> 	mock_get_random.c \</span><br><span> 	$(=
top_srcdir)/src/openvpn/platform.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/buffer.c \</span><br><span>@@ -41,7 +42,8 @@</span><br><span> </span>=
<br><span> buffer_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/=
openvpn -I$(top_srcdir)/src/compat</span><br><span> buffer_testdriver_LDFLA=
GS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=3Dparse_line</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-buffer_testdriver_SOURC=
ES =3D test_buffer.c mock_msg.c mock_msg.h \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+buffer_testdriver_SOURCES =3D test_buffer.c \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h t=
est_common.h \</span><br><span> 	mock_get_random.c \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/win32-util.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/platform.c</span><br><span>@@ -49,7 +51,8 @@</span><br><span> crypto_=
testdriver_CFLAGS  =3D @TEST_CFLAGS@ \</span><br><span> 	-I$(top_srcdir)/in=
clude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn</span><br><spa=
n> crypto_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-crypto_testdriver_SOURCES =3D test_crypto.c mock_=
msg.c mock_msg.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+c=
rypto_testdriver_SOURCES =3D test_crypto.c \</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_common.h \</span><br><=
span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)=
/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_=
mbedtls.c \</span><br><span>@@ -64,7 +67,8 @@</span><br><span> packet_id_te=
stdriver_CFLAGS  =3D @TEST_CFLAGS@ \</span><br><span> 	-I$(top_srcdir)/incl=
ude -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn</span><br><span>=
 packet_id_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-packet_id_testdriver_SOURCES =3D test_packet_id.=
c mock_msg.c mock_msg.h \</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+packet_id_testdriver_SOURCES =3D test_packet_id.c \</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_common.h =
\</span><br><span> 	mock_get_random.c \</span><br><span> 	$(top_srcdir)/src=
/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</=
span><br><span>@@ -77,7 +81,7 @@</span><br><span> pkt_testdriver_CFLAGS  =
=3D @TEST_CFLAGS@ \</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdi=
r)/src/compat -I$(top_srcdir)/src/openvpn</span><br><span> pkt_testdriver_L=
DFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-pkt_testdriver_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h mock_win32_=
execve.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+pkt_testd=
river_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c test=
_common.h \</span><br><span> 	$(top_srcdir)/src/openvpn/argv.c \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/base64.c \</span><br><span> 	$(top_srcdir=
)/src/openvpn/buffer.c \</span><br><span>@@ -103,7 +107,8 @@</span><br><spa=
n> 	-Wl,--wrap=3Dbuffer_write_file \</span><br><span> 	-Wl,--wrap=3Dparse_l=
ine \</span><br><span> 	-Wl,--wrap=3Drand_bytes</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c=
 mock_msg.c mock_msg.h \</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_common.h \=
</span><br><span> 	mock_win32_execve.c \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/argv.c \</span><br><span> 	$(top_srcdir)/src/openvpn/base64.c \</=
span><br><span>@@ -174,7 +179,8 @@</span><br><span> auth_token_testdriver_L=
DFLAGS =3D @TEST_LDFLAGS@ \</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-auth_toke=
n_testdriver_SOURCES =3D test_auth_token.c mock_msg.c \</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+auth_token_testdriver_SOURCES =3D test_=
auth_token.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock=
_msg.c test_common.h \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span> =
	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span>@@ -192,7 +19=
8,8 @@</span><br><span> ncp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \</span><=
br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-ncp_testdriver_SOURCES =3D test_ncp.c mock_=
msg.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ncp_testdriv=
er_SOURCES =3D test_ncp.c \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	mock_msg.c test_common.h \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span>=
@@ -209,7 +216,8 @@</span><br><span> </span><br><span> misc_testdriver_LDFL=
AGS =3D @TEST_LDFLAGS@</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-misc_testdriver_SOURCES =3D test_misc.c mock_msg.c \</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+misc_testdriver_SOURCES=
 =3D test_misc.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	=
mock_msg.c test_common.h  \</span><br><span> 	mock_get_random.c \</span><br=
><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/options_util.c \</span><br><span></span><br></pre><p>To view=
, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1509?usp=3Demail">=
change 1509</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><=
div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope it=
emprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=
=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1509?usp=3Demail"/><=
meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I674af04e1a6449544b7def07253=
37c3b353ea276 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1509 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: plaisthos &lt;arne-openvpn@...2639...=
..&gt; </div>

</body></html>=

--mG4dJ8fpzvQ=--

