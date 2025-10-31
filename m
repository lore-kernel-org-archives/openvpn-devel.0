From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 31 Oct 2025 09:49:45 +0000
In-Reply-To: <gerrit.1761870762000.Ifea896e722635a471cc01f930bc1e5d0f2c165be@...2715...>
References: <gerrit.1761870762000.Ifea896e722635a471cc01f930bc1e5d0f2c165be@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <04652492efd75557faafe11f71115909cd079bea-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="KB5Urm2Wqbc="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Add -lpathcch for
 mingw32 builds using autotools
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: selvanair <selva.nair@...277...>
Cc: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KB5Urm2Wqbc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/13=
34?usp=3Demail )

Change subject: Add -lpathcch for mingw32 builds using autotools
......................................................................

Add -lpathcch for mingw32 builds using autotools

This was missed in commit 05a8ba8

Note: the check for PATHCCH_ENSURE_TRAILING_SLASH in
configure.ac may be omitted if we build only using latest
mingw32-w64 toolchain. Ubuntu 24.04 is not new enough.

Github: closes OpenVPN/openvpn#885

Change-Id: Ifea896e722635a471cc01f930bc1e5d0f2c165be
Signed-off-by: Selva Nair <selva.nair@...277...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1334
Message-Id: <20251031092427.19824-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
095.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
M src/openvpnserv/Makefile.am
2 files changed, 12 insertions(+), 1 deletion(-)




diff --git a/configure.ac b/configure.ac
index 8f3c01d..3117e13 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1383,6 +1383,17 @@
 	fi
 fi

+if test "${WIN32}" =3D=3D "yes"; then
+	AC_CHECK_DECLS(
+		[PATHCCH_ENSURE_TRAILING_SLASH],
+		[AC_DEFINE([HAVE_PATHCCH_ENSURE_TRAILING_SLASH], [1], [PATHCCH_ENSURE_TR=
AILING_SLASH is defined])],
+		,
+		[[
+			#include <pathcch.h>
+		]]
+	)
+fi
+
 # When testing a compiler option, we add -Werror to force
 # an error when the option is unsupported. This is not
 # required for gcc, but some compilers such as clang need it.
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index a27fbbf..f45d770 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -27,7 +27,7 @@
 	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA
 openvpnserv_LDADD =3D \
 	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
-	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32
+	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32 -lpathcch
 noinst_DATA =3D \
 	MSG00409.bin eventmsg.h eventmsg.rc openvpnservmsg.dll
 BUILT_SOURCES =3D \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1334?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifea896e722635a471cc01f930bc1e5d0f2c165be
Gerrit-Change-Number: 1334
Gerrit-PatchSet: 2
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--KB5Urm2Wqbc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1334?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">Add -lpathcch for mingw32 builds using autotools=
<br><br>This was missed in commit 05a8ba8<br><br>Note: the check for PATHCC=
H_ENSURE_TRAILING_SLASH in<br>configure.ac may be omitted if we build only =
using latest<br>mingw32-w64 toolchain. Ubuntu 24.04 is not new enough.<br><=
br>Github: closes OpenVPN/openvpn#885<br><br>Change-Id: Ifea896e722635a471c=
c01f930bc1e5d0f2c165be<br>Signed-off-by: Selva Nair &lt;selva.nair@...1663...=
.&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: http=
s://gerrit.openvpn.net/c/openvpn/+/1334<br>Message-Id: &lt;20251031092427.1=
9824-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-dev=
el@lists.sourceforge.net/msg34095.html<br>Signed-off-by: Gert Doering &lt;g=
ert@...1296...&gt;<br>---<br>M configure.ac<br>M src/openvpnserv/Makefile.a=
m<br>2 files changed, 12 insertions(+), 1 deletion(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/configure.ac b/configure.ac</span><br><span>index 8f3c01d..=
3117e13 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/con=
figure.ac</span><br><span>@@ -1383,6 +1383,17 @@</span><br><span> 	fi</span=
><br><span> fi</span><br><span> </span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+if test &quot;${WIN32}&quot; =3D=3D &quot;yes&quot;; then</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC_CHECK_DECLS(</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+		[PATHCCH_ENSURE_TRAILING_=
SLASH],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[AC_DEFINE=
([HAVE_PATHCCH_ENSURE_TRAILING_SLASH], [1], [PATHCCH_ENSURE_TRAILING_SLASH =
is defined])],</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		,</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[[</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+			#include &lt;pathcch.h&gt;</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+		]]</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+	)</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+fi</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
</span><br><span> # When testing a compiler option, we add -Werror to force=
</span><br><span> # an error when the option is unsupported. This is not</s=
pan><br><span> # required for gcc, but some compilers such as clang need it=
.</span><br><span>diff --git a/src/openvpnserv/Makefile.am b/src/openvpnser=
v/Makefile.am</span><br><span>index a27fbbf..f45d770 100644</span><br><span=
>--- a/src/openvpnserv/Makefile.am</span><br><span>+++ b/src/openvpnserv/Ma=
kefile.am</span><br><span>@@ -27,7 +27,7 @@</span><br><span> 	-D_WIN32_WINN=
T=3D_WIN32_WINNT_VISTA</span><br><span> openvpnserv_LDADD =3D \</span><br><=
span> 	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	-lshlwapi -lnetapi32 -lws2_32 -lntd=
ll -lole32</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	-lshlwap=
i -lnetapi32 -lws2_32 -lntdll -lole32 -lpathcch</span><br><span> noinst_DAT=
A =3D \</span><br><span> 	MSG00409.bin eventmsg.h eventmsg.rc openvpnservms=
g.dll</span><br><span> BUILT_SOURCES =3D \</span><br><span></span><br></pre=
><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1334?us=
p=3Demail">change 1334</a>. To unsubscribe, or for help writing mail filter=
s, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">setting=
s</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div i=
temscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><lin=
k itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1334?usp=
=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifea896e722635a471cc01f930bc=
1e5d0f2c165be </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1334 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--KB5Urm2Wqbc=--

