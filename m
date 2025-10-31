From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 31 Oct 2025 09:49:43 +0000
In-Reply-To: <gerrit.1761870762000.Ifea896e722635a471cc01f930bc1e5d0f2c165be@...2715...>
References: <gerrit.1761870762000.Ifea896e722635a471cc01f930bc1e5d0f2c165be@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <04652492efd75557faafe11f71115909cd079bea-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="IaSkgJ8yaBM="; charset=UTF-8
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
To: selvanair <selva.nair@...277...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--IaSkgJ8yaBM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 selvanair. ( http://gerrit.openvpn.net/c/openvpn/+/1334?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/1334/2

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

Gerrit-MessageType: newpatchset
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

--IaSkgJ8yaBM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #2</strong> to the change originally created by selvanair.<=
/p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1334?usp=3Demail">Vi=
ew Change</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Add -lpathcch for mingw32 builds us=
ing autotools<br><br>This was missed in commit 05a8ba8<br><br>Note: the che=
ck for PATHCCH_ENSURE_TRAILING_SLASH in<br>configure.ac may be omitted if w=
e build only using latest<br>mingw32-w64 toolchain. Ubuntu 24.04 is not new=
 enough.<br><br>Github: closes OpenVPN/openvpn#885<br><br>Change-Id: Ifea89=
6e722635a471cc01f930bc1e5d0f2c165be<br>Signed-off-by: Selva Nair &lt;selva.=
nair@...277...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Ger=
rit URL: https://gerrit.openvpn.net/c/openvpn/+/1334<br>Message-Id: &lt;202=
51031092427.19824-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.co=
m/openvpn-devel@lists.sourceforge.net/msg34095.html<br>Signed-off-by: Gert =
Doering &lt;gert@...1296...&gt;<br>---<br>M configure.ac<br>M src/openvpnse=
rv/Makefile.am<br>2 files changed, 12 insertions(+), 1 deletion(-)<br><br><=
/pre><pre class=3D"blocks" style=3D"font-family: monospace,monospace; white=
-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/cha=
nges/34/1334/2</pre><pre style=3D"font-family: monospace,monospace; white-s=
pace: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac</span><br><=
span>index 8f3c01d..3117e13 100644</span><br><span>--- a/configure.ac</span=
><br><span>+++ b/configure.ac</span><br><span>@@ -1383,6 +1383,17 @@</span>=
<br><span> 	fi</span><br><span> fi</span><br><span> </span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if test &quot;${WIN32}&quot; =3D=3D &quot=
;yes&quot;; then</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	AC=
_CHECK_DECLS(</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		[PAT=
HCCH_ENSURE_TRAILING_SLASH],</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+		[AC_DEFINE([HAVE_PATHCCH_ENSURE_TRAILING_SLASH], [1], [PATHCCH_E=
NSURE_TRAILING_SLASH is defined])],</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+		,</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
		[[</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			#include &lt=
;pathcch.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+		]]<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span> # When testing a compiler option, we=
 add -Werror to force</span><br><span> # an error when the option is unsupp=
orted. This is not</span><br><span> # required for gcc, but some compilers =
such as clang need it.</span><br><span>diff --git a/src/openvpnserv/Makefil=
e.am b/src/openvpnserv/Makefile.am</span><br><span>index a27fbbf..f45d770 1=
00644</span><br><span>--- a/src/openvpnserv/Makefile.am</span><br><span>+++=
 b/src/openvpnserv/Makefile.am</span><br><span>@@ -27,7 +27,7 @@</span><br>=
<span> 	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span> openvpnserv_LD=
ADD =3D \</span><br><span> 	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrp=
crt4 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-lshlwapi -lne=
tapi32 -lws2_32 -lntdll -lole32</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32 -lpathcch</span>=
<br><span> noinst_DATA =3D \</span><br><span> 	MSG00409.bin eventmsg.h even=
tmsg.rc openvpnservmsg.dll</span><br><span> BUILT_SOURCES =3D \</span><br><=
span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.ne=
t/c/openvpn/+/1334?usp=3Demail">change 1334</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://schema.org=
/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema=
.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c=
/openvpn/+/1334?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Chang=
e"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
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

--IaSkgJ8yaBM=--

