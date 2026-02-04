From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 4 Feb 2026 16:25:11 +0000
In-Reply-To: <gerrit.1770218040000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
References: <gerrit.1770218040000.I674af04e1a6449544b7def0725337c3b353ea276@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a58dfe27b827777d428d57069a3620eae8c2f099-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="pZSNXcJE+2U="; charset=UTF-8
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

--pZSNXcJE+2U=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1509?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1509/2

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I674af04e1a6449544b7def0725337c3b353ea276
Gerrit-Change-Number: 1509
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: plaisthos <arne-openvpn@...1227...>

--pZSNXcJE+2U=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1509?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by plaisthos</p><pre class=3D"blocks" style=3D"font-family: m=
onospace,monospace; white-space: pre-wrap;">Add missing header in unit test=
s Makefile.am<br><br>make distcheck fails since we are not listing all head=
ers that are<br>used by the unit tests.<br><br>Change-Id: I674af04e1a644954=
4b7def0725337c3b353ea276<br>Signed-off-by: Arne Schwabe &lt;arne-openvpn@...1186...=
.1227...&gt;<br>(cherry picked from commit c2776ee0ff03832bb2213ebd19e9a14d=
37445bed)<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Acked-by: Ar=
ne Schwabe &lt;arne-openvpn@...1227...&gt;<br>Gerrit URL: https://gerrit.op=
envpn.net/c/openvpn/+/1509<br>https://www.mail-archive.com/openvpn-devel@...1224...=
sts.sourceforge.net/msg35534.html<br>Message-Id: &lt;20260204161322.149284-=
1-frank@...2641...&gt;<br>Signed-off-by: Gert Doering &lt;gert@...1296...&g=
t;<br>---<br>M tests/unit_tests/openvpn/Makefile.am<br>1 file changed, 17 i=
nsertions(+), 9 deletions(-)<br><br></pre><pre class=3D"blocks" style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">git pull ssh://gerr=
it.openvpn.net:29418/openvpn refs/changes/09/1509/2</pre><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;"><span>diff --git a/te=
sts/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/Makefile.am</=
span><br><span>index 38a7ab4..0a0f4f0 100644</span><br><span>--- a/tests/un=
it_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_tests/openvpn=
/Makefile.am</span><br><span>@@ -32,7 +32,8 @@</span><br><span> </span><br>=
<span> argv_testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/openvp=
n -I$(top_srcdir)/src/compat</span><br><span> argv_testdriver_LDFLAGS =3D @=
TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=3Dparse_line</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-argv_testdriver_SOURCES =3D tes=
t_argv.c mock_msg.c mock_msg.h \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+argv_testdriver_SOURCES =3D test_argv.c \</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_common.h \</=
span><br><span> 	mock_get_random.c \</span><br><span> 	$(top_srcdir)/src/op=
envpn/platform.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</=
span><br><span>@@ -41,7 +42,8 @@</span><br><span> </span><br><span> buffer_=
testdriver_CFLAGS  =3D @TEST_CFLAGS@ -I$(top_srcdir)/src/openvpn -I$(top_sr=
cdir)/src/compat</span><br><span> buffer_testdriver_LDFLAGS =3D @TEST_LDFLA=
GS@ -L$(top_srcdir)/src/openvpn -Wl,--wrap=3Dparse_line</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-buffer_testdriver_SOURCES =3D test_buffer=
.c mock_msg.c mock_msg.h \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+buffer_testdriver_SOURCES =3D test_buffer.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_common.h \</s=
pan><br><span> 	mock_get_random.c \</span><br><span> 	$(top_srcdir)/src/ope=
nvpn/win32-util.c \</span><br><span> 	$(top_srcdir)/src/openvpn/platform.c<=
/span><br><span>@@ -49,7 +51,8 @@</span><br><span> crypto_testdriver_CFLAGS=
  =3D @TEST_CFLAGS@ \</span><br><span> 	-I$(top_srcdir)/include -I$(top_src=
dir)/src/compat -I$(top_srcdir)/src/openvpn</span><br><span> crypto_testdri=
ver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-crypto_testdriver_SOURCES =3D test_crypto.c mock_msg.c mock_msg.h =
\</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_testdriver_=
SOURCES =3D test_crypto.c \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	mock_msg.c mock_msg.h test_common.h \</span><br><span> 	$(top_srcd=
ir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/cryp=
to.c \</span><br><span> 	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span=
><br><span>@@ -64,7 +67,8 @@</span><br><span> packet_id_testdriver_CFLAGS  =
=3D @TEST_CFLAGS@ \</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdi=
r)/src/compat -I$(top_srcdir)/src/openvpn</span><br><span> packet_id_testdr=
iver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-packet_id_testdriver_SOURCES =3D test_packet_id.c mock_msg.c mock=
_msg.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+packet_id_t=
estdriver_SOURCES =3D test_packet_id.c \</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+	mock_msg.c mock_msg.h test_common.h \</span><br><span=
> 	mock_get_random.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c=
 \</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><span>@@=
 -77,7 +81,7 @@</span><br><span> pkt_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \=
</span><br><span> 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(t=
op_srcdir)/src/openvpn</span><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LD=
FLAGS@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-pkt_testdriver_=
SOURCES =3D test_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c \</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+pkt_testdriver_SOURCES =3D t=
est_pkt.c mock_msg.c mock_msg.h mock_win32_execve.c test_common.h \</span><=
br><span> 	$(top_srcdir)/src/openvpn/argv.c \</span><br><span> 	$(top_srcdi=
r)/src/openvpn/base64.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffe=
r.c \</span><br><span>@@ -103,7 +107,8 @@</span><br><span> 	-Wl,--wrap=3Dbu=
ffer_write_file \</span><br><span> 	-Wl,--wrap=3Dparse_line \</span><br><sp=
an> 	-Wl,--wrap=3Drand_bytes</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_ms=
g.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+tls_crypt_test=
driver_SOURCES =3D test_tls_crypt.c \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	mock_msg.c mock_msg.h test_common.h \</span><br><span> 	=
mock_win32_execve.c \</span><br><span> 	$(top_srcdir)/src/openvpn/argv.c \<=
/span><br><span> 	$(top_srcdir)/src/openvpn/base64.c \</span><br><span>@@ -=
174,7 +179,8 @@</span><br><span> auth_token_testdriver_LDFLAGS =3D @TEST_LD=
FLAGS@ \</span><br><span> 	$(OPTIONAL_CRYPTO_LIBS)</span><br><span> </span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-auth_token_testdriver_SOURCE=
S =3D test_auth_token.c mock_msg.c \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+auth_token_testdriver_SOURCES =3D test_auth_token.c \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_common.=
h \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br><span>=
 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_srcdir)/src/=
openvpn/crypto_mbedtls.c \</span><br><span>@@ -192,7 +198,8 @@</span><br><s=
pan> ncp_testdriver_LDFLAGS =3D @TEST_LDFLAGS@ \</span><br><span> 	$(OPTION=
AL_CRYPTO_LIBS)</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-ncp_testdriver_SOURCES =3D test_ncp.c mock_msg.c \</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+ncp_testdriver_SOURCES =3D test_=
ncp.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c =
test_common.h \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</spa=
n><br><span> 	$(top_srcdir)/src/openvpn/crypto.c \</span><br><span> 	$(top_=
srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><span>@@ -209,7 +216,8 @@<=
/span><br><span> </span><br><span> misc_testdriver_LDFLAGS =3D @TEST_LDFLAG=
S@</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-m=
isc_testdriver_SOURCES =3D test_misc.c mock_msg.c \</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+misc_testdriver_SOURCES =3D test_misc.c \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_msg.c test_co=
mmon.h  \</span><br><span> 	mock_get_random.c \</span><br><span> 	$(top_src=
dir)/src/openvpn/buffer.c \</span><br><span> 	$(top_srcdir)/src/openvpn/opt=
ions_util.c \</span><br><span></span><br></pre><p>To view, visit <a href=3D=
"http://gerrit.openvpn.net/c/openvpn/+/1509?usp=3Demail">change 1509</a>. T=
o unsubscribe, or for help writing mail filters, visit <a href=3D"http://ge=
rrit.openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope item=
type=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" =
itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"ht=
tp://gerrit.openvpn.net/c/openvpn/+/1509?usp=3Demail"/><meta itemprop=3D"na=
me" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--pZSNXcJE+2U=--

