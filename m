From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 18 Sep 2024 10:50:19 +0000
References: <gerrit.1726656617000.I6fe225db807626a79a160132ee05897554695597@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <35d04bb835d08fe2cb539c0cc8cd7cb3a9426413-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="BjiQt/XKfV0="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: tests: Allow to test
 for arbitrary ciphers and digests
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

--BjiQt/XKfV0=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/752?usp=3Demail

to review the following change.


Change subject: tests: Allow to test for arbitrary ciphers and digests
......................................................................

tests: Allow to test for arbitrary ciphers and digests

Add program crypto_support that is more generic than
ntlm_support. First intended usage is to test for
availability of BF-CBC in t_client.sh.

Change-Id: I6fe225db807626a79a160132ee05897554695597
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M tests/Makefile.am
A tests/crypto_support.c
2 files changed, 73 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/52/752/1

diff --git a/tests/Makefile.am b/tests/Makefile.am
index f26b3b8..7b9f38a 100644
--- a/tests/Makefile.am
+++ b/tests/Makefile.am
@@ -20,7 +20,7 @@
 if !WIN32
 test_scripts =3D t_client.sh t_lpback.sh t_cltsrv.sh t_server_null.sh

-check_PROGRAMS =3D ntlm_support
+check_PROGRAMS =3D ntlm_support crypto_support
 if HAVE_SITNL
 test_scripts +=3D t_net.sh
 endif
@@ -57,3 +57,15 @@
 	$(top_srcdir)/src/openvpn/otime.c \
 	$(top_srcdir)/src/openvpn/packet_id.c \
 	$(top_srcdir)/src/openvpn/platform.c
+
+crypto_support_CFLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src=
/compat -I$(top_srcdir)/tests/unit_tests/openvpn -DNO_CMOCKA @TEST_CFLAGS@
+crypto_support_LDFLAGS =3D @TEST_LDFLAGS@ -L$(top_srcdir)/src/openvpn $(OP=
TIONAL_CRYPTO_LIBS)
+crypto_support_SOURCES =3D crypto_support.c \
+	unit_tests/openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h \
+	$(top_srcdir)/src/openvpn/buffer.c \
+	$(top_srcdir)/src/openvpn/crypto.c \
+	$(top_srcdir)/src/openvpn/crypto_openssl.c \
+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \
+	$(top_srcdir)/src/openvpn/otime.c \
+	$(top_srcdir)/src/openvpn/packet_id.c \
+	$(top_srcdir)/src/openvpn/platform.c
diff --git a/tests/crypto_support.c b/tests/crypto_support.c
new file mode 100644
index 0000000..fc4cbd1
--- /dev/null
+++ b/tests/crypto_support.c
@@ -0,0 +1,60 @@
+/*
+ *  OpenVPN -- An application to securely tunnel IP networks
+ *             over a single UDP port, with support for SSL/TLS-based
+ *             session authentication and key exchange,
+ *             packet encryption, packet authentication, and
+ *             packet compression.
+ *
+ * Copyright (C) 2023-2024 OpenVPN Inc <sales@...515...>
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
+#include <string.h>
+
+int
+main(int argc, char *argv[])
+{
+#if defined(ENABLE_CRYPTO_OPENSSL)
+    crypto_load_provider("legacy");
+    crypto_load_provider("default");
+#endif
+    if (argc <=3D 2)
+    {
+        msg(M_FATAL, "Usage: ./crypto_support (cipher|digest) <name>");
+    }
+    if (strcmp(argv[1], "digest") =3D=3D 0)
+    {
+        if (!md_valid(argv[2]))
+        {
+            msg(M_FATAL, "digest %s not supported", argv[2]);
+        }
+    }
+    else if (strcmp(argv[1], "cipher") =3D=3D 0)
+    {
+        if (!cipher_valid(argv[2]))
+        {
+            msg(M_FATAL, "cipher %s not supported", argv[2]);
+        }
+    }
+}

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/752?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I6fe225db807626a79a160132ee05897554695597
Gerrit-Change-Number: 752
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--BjiQt/XKfV0=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/752?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">tests: Allow to test for arbitrary ciphers and digests<br><br=
>Add program crypto_support that is more generic than<br>ntlm_support. Firs=
t intended usage is to test for<br>availability of BF-CBC in t_client.sh.<b=
r><br>Change-Id: I6fe225db807626a79a160132ee05897554695597<br>Signed-off-by=
: Frank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M tests/Makefile.am<=
br>A tests/crypto_support.c<br>2 files changed, 73 insertions(+), 1 deletio=
n(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/52/752/1</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/tests/Makefile.am b/tests/Makefile.am</span>=
<br><span>index f26b3b8..7b9f38a 100644</span><br><span>--- a/tests/Makefil=
e.am</span><br><span>+++ b/tests/Makefile.am</span><br><span>@@ -20,7 +20,7=
 @@</span><br><span> if !WIN32</span><br><span> test_scripts =3D t_client.s=
h t_lpback.sh t_cltsrv.sh t_server_null.sh</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-check_PROGRAMS =3D ntlm_support</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+check_PROGRAMS =3D ntlm_=
support crypto_support</span><br><span> if HAVE_SITNL</span><br><span> test=
_scripts +=3D t_net.sh</span><br><span> endif</span><br><span>@@ -57,3 +57,=
15 @@</span><br><span> 	$(top_srcdir)/src/openvpn/otime.c \</span><br><span=
> 	$(top_srcdir)/src/openvpn/packet_id.c \</span><br><span> 	$(top_srcdir)/=
src/openvpn/platform.c</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+crypto_support_C=
FLAGS  =3D -I$(top_srcdir)/src/openvpn -I$(top_srcdir)/src/compat -I$(top_s=
rcdir)/tests/unit_tests/openvpn -DNO_CMOCKA @TEST_CFLAGS@</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+crypto_support_LDFLAGS =3D @TEST_LDFL=
AGS@ -L$(top_srcdir)/src/openvpn $(OPTIONAL_CRYPTO_LIBS)</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+crypto_support_SOURCES =3D crypto_supp=
ort.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	unit_tests/=
openvpn/mock_msg.c unit_tests/openvpn/mock_msg.h \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/buffer.c \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn=
/crypto.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_s=
rcdir)/src/openvpn/crypto_openssl.c \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	$(top_srcdir)/src/openvpn/crypto_mbedtls.c \</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)/src/openvpn/otim=
e.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(top_srcdir)=
/src/openvpn/packet_id.c \</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+	$(top_srcdir)/src/openvpn/platform.c</span><br><span>diff --git a/t=
ests/crypto_support.c b/tests/crypto_support.c</span><br><span>new file mod=
e 100644</span><br><span>index 0000000..fc4cbd1</span><br><span>--- /dev/nu=
ll</span><br><span>+++ b/tests/crypto_support.c</span><br><span>@@ -0,0 +1,=
60 @@</span><br><span style=3D"color: hsl(120, 100%, 40%);">+/*</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+ *  OpenVPN -- An application t=
o securely tunnel IP networks</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+ *             over a single UDP port, with support for SSL/TLS-b=
ased</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *             =
session authentication and key exchange,</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+ *             packet encryption, packet authenticatio=
n, and</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *           =
  packet compression.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+ *</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Copyright (C=
) 2023-2024 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+ *</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+ *  This program is free software; you can redistribute it and/o=
r modify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  it unde=
r the terms of the GNU General Public License version 2</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+ *  as published by the Free Software F=
oundation.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+ *  This program is distri=
buted in the hope that it will be useful,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+ *  but WITHOUT ANY WARRANTY; without even the implie=
d warranty of</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  ME=
RCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+ *  GNU General Public License for =
more details.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ *</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ *  You should have rec=
eived a copy of the GNU General Public License along</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ *  with this program; if not, write to t=
he Free Software Foundation, Inc.,</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+ *  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 U=
SA.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ */</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+#ifdef HAVE_CONFIG_H</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#include &quot;config.h&quot;</span><br><span styl=
e=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#include &quot;syshead.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &quot;crypto.h&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+#include &quot;error.h&quot;</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#incl=
ude &lt;string.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+int</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+main(int argc, char *argv[])</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+{</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#if defined(ENABLE_CRYPTO_OPENSSL)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+    crypto_load_provider(&=
quot;legacy&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    crypto_load_provider(&quot;default&quot;);</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+    if (argc &lt;=3D 2)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+        msg(M_FATAL, &quot;Usage: ./crypto_support (cipher|digest) &lt;=
name&gt;&quot;);</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 }</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (strcmp(ar=
gv[1], &quot;digest&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+    {</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+        if (!md_valid(argv[2]))</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+        {</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+            msg(M_FATAL, &quot;digest %s not supported&quot;, argv[2])=
;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        }</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    else if (strcmp(argv[1], &quot;cipher=
&quot;) =3D=3D 0)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        if (!cip=
her_valid(argv[2]))</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
        {</span><br><span style=3D"color: hsl(120, 100%, 40%);">+          =
  msg(M_FATAL, &quot;cipher %s not supported&quot;, argv[2]);</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+        }</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+    }</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+}</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/752?usp=3Demail">change 752<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/752?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I6fe225db807626a79a160132ee0=
5897554695597 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 752 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--BjiQt/XKfV0=--

