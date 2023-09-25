From: "cron2 (Code Review)" <gerrit@...515...>
Date: Mon, 25 Sep 2023 20:10:59 +0000
In-Reply-To: <gerrit.1689947729000.I8c8fe298eb30e211279f3fc010584b9d3bc14b4a@...2715...>
References: <gerrit.1689947729000.I8c8fe298eb30e211279f3fc010584b9d3bc14b4a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <3133f17ef22fe8df89fa80b3cdd7ce8f6390a0f6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="i9LaCzEmtNw="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[release/2.6]: Mock
 openvpn_exece on win32 also for test_tls_crypt
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: d12fk <heiko@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--i9LaCzEmtNw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/31=
3?usp=3Demail )

Change subject: Mock openvpn_exece on win32 also for test_tls_crypt
......................................................................

Mock openvpn_exece on win32 also for test_tls_crypt

This function is needed to commpile on win32 as run_command.c defines it
on Unix Linux but on windows it is defined in win32.c which pulls in too
many other unresolvable symbols.

Patch v2: Also add mock_win32_execve.c to automake files

Change-Id: I8c8fe298eb30e211279f3fc010584b9d3bc14b4a
Signed-off-by: Arne Schwabe <arne@...1227...>
Acked-by: Heiko Hund <heiko@...515...>
Acked-by: Frank Lichtenheld <frank@...2641...>
(cherry picked from commit ede590e57c96c2b16d9bf462c4b1dd967b37c432)
Message-Id: <20230925094409.40429-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
097.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M tests/unit_tests/openvpn/Makefile.am
A tests/unit_tests/openvpn/mock_win32_execve.c
M tests/unit_tests/openvpn/test_pkt.c
3 files changed, 39 insertions(+), 9 deletions(-)




diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 650126c..dd3985d 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -77,7 +77,7 @@
 pkt_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \
 	-I$(top_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/op=
envpn
 pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@
-pkt_testdriver_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h \
+pkt_testdriver_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h mock_win32_exe=
cve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
@@ -104,6 +104,7 @@
 	-Wl,--wrap=3Dparse_line \
 	-Wl,--wrap=3Drand_bytes
 tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_msg.h \
+	mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \
diff --git a/tests/unit_tests/openvpn/mock_win32_execve.c b/tests/unit_test=
s/openvpn/mock_win32_execve.c
new file mode 100644
index 0000000..4d37ebe
--- /dev/null
+++ b/tests/unit_tests/openvpn/mock_win32_execve.c
@@ -0,0 +1,37 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single TCP/UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ *  Copyright (C) 2023 OpenVPN Inc <sales@...515...>
+ *  Copyright (C) 2023 Arne Schwabe <arne@...1227...>
+ *
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
+#include "config.h"
+#include "syshead.h"
+
+#include "win32.h"
+
+#ifdef _WIN32
+int
+openvpn_execve(const struct argv *a, const struct env_set *es, const unsig=
ned int flags)
+{
+    ASSERT(0);
+}
+#endif
diff --git a/tests/unit_tests/openvpn/test_pkt.c b/tests/unit_tests/openvpn=
/test_pkt.c
index 736f131..eb69829 100644
--- a/tests/unit_tests/openvpn/test_pkt.c
+++ b/tests/unit_tests/openvpn/test_pkt.c
@@ -71,14 +71,6 @@
     return "dummy print_link_socket_actual from unit test";
 }

-#ifdef _WIN32
-int
-openvpn_execve(const struct argv *a, const struct env_set *es, const unsig=
ned int flags)
-{
-    ASSERT(0);
-}
-#endif
-
 struct test_pkt_context {
     struct tls_auth_standalone tas_tls_auth;
     struct tls_auth_standalone tas_crypt;

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/313?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: release/2.6
Gerrit-Change-Id: I8c8fe298eb30e211279f3fc010584b9d3bc14b4a
Gerrit-Change-Number: 313
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: merged

--i9LaCzEmtNw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/313?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Mock openvpn_exece on win32 also for test_tls_=
crypt<br><br>This function is needed to commpile on win32 as run_command.c =
defines it<br>on Unix Linux but on windows it is defined in win32.c which p=
ulls in too<br>many other unresolvable symbols.<br><br>Patch v2: Also add m=
ock_win32_execve.c to automake files<br><br>Change-Id: I8c8fe298eb30e211279=
f3fc010584b9d3bc14b4a<br>Signed-off-by: Arne Schwabe &lt;arne@...1227...&gt=
;<br>Acked-by: Heiko Hund &lt;heiko@...515...&gt;<br>Acked-by: Frank Lichte=
nheld &lt;frank@...2641...&gt;<br>(cherry picked from commit ede590e57c96c2=
b16d9bf462c4b1dd967b37c432)<br>Message-Id: &lt;20230925094409.40429-1-frank=
@...2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1466...=
urceforge.net/msg27097.html<br>Signed-off-by: Gert Doering &lt;gert@...1726...=
...&gt;<br>---<br>M tests/unit_tests/openvpn/Makefile.am<br>A tests/unit_te=
sts/openvpn/mock_win32_execve.c<br>M tests/unit_tests/openvpn/test_pkt.c<br=
>3 files changed, 39 insertions(+), 9 deletions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/ope=
nvpn/Makefile.am</span><br><span>index 650126c..dd3985d 100644</span><br><s=
pan>--- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/=
unit_tests/openvpn/Makefile.am</span><br><span>@@ -77,7 +77,7 @@</span><br>=
<span> pkt_testdriver_CFLAGS  =3D @TEST_CFLAGS@ \</span><br><span> 	-I$(top=
_srcdir)/include -I$(top_srcdir)/src/compat -I$(top_srcdir)/src/openvpn</sp=
an><br><span> pkt_testdriver_LDFLAGS =3D @TEST_LDFLAGS@</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-pkt_testdriver_SOURCES =3D test_pkt.c moc=
k_msg.c mock_msg.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+pkt_testdriver_SOURCES =3D test_pkt.c mock_msg.c mock_msg.h mock_win32_exe=
cve.c \</span><br><span> 	$(top_srcdir)/src/openvpn/argv.c \</span><br><spa=
n> 	$(top_srcdir)/src/openvpn/base64.c \</span><br><span> 	$(top_srcdir)/sr=
c/openvpn/buffer.c \</span><br><span>@@ -104,6 +104,7 @@</span><br><span> 	=
-Wl,--wrap=3Dparse_line \</span><br><span> 	-Wl,--wrap=3Drand_bytes</span><=
br><span> tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock=
_msg.h \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	mock_win32=
_execve.c \</span><br><span> 	$(top_srcdir)/src/openvpn/argv.c \</span><br>=
<span> 	$(top_srcdir)/src/openvpn/base64.c \</span><br><span> 	$(top_srcdir=
)/src/openvpn/buffer.c \</span><br><span>diff --git a/tests/unit_tests/open=
vpn/mock_win32_execve.c b/tests/unit_tests/openvpn/mock_win32_execve.c</spa=
n><br><span>new file mode 100644</span><br><span>index 0000000..4d37ebe</sp=
an><br><span>--- /dev/null</span><br><span>+++ b/tests/unit_tests/openvpn/m=
ock_win32_execve.c</span><br><span>@@ -0,0 +1,37 @@</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+/*</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+ *  OpenVPN -- An application to securely tunnel IP networ=
ks</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             ov=
er a single TCP/UDP port, with support for SSL/TLS-based</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *             session authentication =
and key exchange,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *=
             packet encryption, packet authentication, and</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+ *             packet compression.</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+ *  Copyright (C) 2023 OpenVPN Inc &lt=
;sales@...515...&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+ *  Copyright (C) 2023 Arne Schwabe &lt;arne@...1227...&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+ *  This program is free software; you can redistribute it and/or mo=
dify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it under th=
e terms of the GNU General Public License version 2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software Fou=
ndation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distribu=
ted in the hope that it will be useful,</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implied =
warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  MERC=
HANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for mo=
re details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have recei=
ved a copy of the GNU General Public License along</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to the =
Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &quot;syshead.h&quot;</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+#include &quot;win32.h&quot;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+#ifdef _WIN32</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+int</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpn=
_execve(const struct argv *a, const struct env_set *es, const unsigned int =
flags)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+    ASSERT(0);</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+}</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#endif</span><br><span>diff --git a/tests/unit_tests/o=
penvpn/test_pkt.c b/tests/unit_tests/openvpn/test_pkt.c</span><br><span>ind=
ex 736f131..eb69829 100644</span><br><span>--- a/tests/unit_tests/openvpn/t=
est_pkt.c</span><br><span>+++ b/tests/unit_tests/openvpn/test_pkt.c</span><=
br><span>@@ -71,14 +71,6 @@</span><br><span>     return &quot;dummy print_l=
ink_socket_actual from unit test&quot;;</span><br><span> }</span><br><span>=
 </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef _WIN32</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-int</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-openvpn_execve(const struct argv *a, const str=
uct env_set *es, const unsigned int flags)</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-    ASSERT(0);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span> struct test_pkt_context=
 {</span><br><span>     struct tls_auth_standalone tas_tls_auth;</span><br>=
<span>     struct tls_auth_standalone tas_crypt;</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
13?usp=3Demail">change 313</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/313?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: release/2.6 </div>
<div style=3D"display:none"> Gerrit-Change-Id: I8c8fe298eb30e211279f3fc0105=
84b9d3bc14b4a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 313 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: plaisthos &lt;arne-openvpn@...2639...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--i9LaCzEmtNw=--

