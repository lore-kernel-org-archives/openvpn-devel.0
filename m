From: "selvanair (Code Review)" <gerrit@...515...>
Date: Fri, 31 Oct 2025 00:32:44 +0000
References: <gerrit.1761870762000.Ifea896e722635a471cc01f930bc1e5d0f2c165be@...2715...>
Reply-To: selva.nair@...277..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <a636152cbb42e1d84549bd3ef3064a2fa674e016-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="9SHJQeMCvBc="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--9SHJQeMCvBc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1334?usp=3Demail

to review the following change.


Change subject: Add -lpathcch for mingw32 builds using autotools
......................................................................

Add -lpathcch for mingw32 builds using autotools

This was missed in commit 05a8ba8

Note: the check for PATHCCH_ENSURE_TRAILING_SLASH in
configure.ac may be omitted if we build only using latest
mingw32-w64 toolchain. Ubuntu 24.04 is not new enough.

Change-Id: Ifea896e722635a471cc01f930bc1e5d0f2c165be
Signed-off-by: Selva Nair <selva.nair@...277...>
---
M configure.ac
M src/openvpnserv/Makefile.am
2 files changed, 12 insertions(+), 1 deletion(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/34/1334/1

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

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifea896e722635a471cc01f930bc1e5d0f2c165be
Gerrit-Change-Number: 1334
Gerrit-PatchSet: 1
Gerrit-Owner: selvanair <selva.nair@...277...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>

--9SHJQeMCvBc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: flichtenheld, plaisthos. </p>
<p>selvanair would like plaisthos and flichtenheld to <strong>review</stron=
g> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1334?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Add -lpathcch for mingw32 builds using auto=
tools<br><br>This was missed in commit 05a8ba8<br><br>Note: the check for P=
ATHCCH_ENSURE_TRAILING_SLASH in<br>configure.ac may be omitted if we build =
only using latest<br>mingw32-w64 toolchain. Ubuntu 24.04 is not new enough.=
<br><br>Change-Id: Ifea896e722635a471cc01f930bc1e5d0f2c165be<br>Signed-off-=
by: Selva Nair &lt;selva.nair@...277...&gt;<br>---<br>M configure.ac<br>M s=
rc/openvpnserv/Makefile.am<br>2 files changed, 12 insertions(+), 1 deletion=
(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mono=
space; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/open=
vpn refs/changes/34/1334/1</pre><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;"><span>diff --git a/configure.ac b/configure.ac=
</span><br><span>index 8f3c01d..3117e13 100644</span><br><span>--- a/config=
ure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -1383,6 +1383,=
17 @@</span><br><span> 	fi</span><br><span> fi</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+if test &quot;${WIN32}&quot; =
=3D=3D &quot;yes&quot;; then</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	AC_CHECK_DECLS(</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+		[PATHCCH_ENSURE_TRAILING_SLASH],</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+		[AC_DEFINE([HAVE_PATHCCH_ENSURE_TRAILING_SLASH], [1]=
, [PATHCCH_ENSURE_TRAILING_SLASH is defined])],</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+		,</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+		[[</span><br><span style=3D"color: hsl(120, 100%, 40%);">+			=
#include &lt;pathcch.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 4=
0%);">+		]]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+fi</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span> # When testing a compil=
er option, we add -Werror to force</span><br><span> # an error when the opt=
ion is unsupported. This is not</span><br><span> # required for gcc, but so=
me compilers such as clang need it.</span><br><span>diff --git a/src/openvp=
nserv/Makefile.am b/src/openvpnserv/Makefile.am</span><br><span>index a27fb=
bf..f45d770 100644</span><br><span>--- a/src/openvpnserv/Makefile.am</span>=
<br><span>+++ b/src/openvpnserv/Makefile.am</span><br><span>@@ -27,7 +27,7 =
@@</span><br><span> 	-D_WIN32_WINNT=3D_WIN32_WINNT_VISTA</span><br><span> o=
penvpnserv_LDADD =3D \</span><br><span> 	-ladvapi32 -luserenv -liphlpapi -l=
fwpuclnt -lrpcrt4 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	-=
lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32 -lp=
athcch</span><br><span> noinst_DATA =3D \</span><br><span> 	MSG00409.bin ev=
entmsg.h eventmsg.rc openvpnservmsg.dll</span><br><span> BUILT_SOURCES =3D =
\</span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/1334?usp=3Demail">change 1334</a>. To unsubscrib=
e, or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn=
.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http=
://schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"=
http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.=
openvpn.net/c/openvpn/+/1334?usp=3Demail"/><meta itemprop=3D"name" content=
=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifea896e722635a471cc01f930bc=
1e5d0f2c165be </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1334 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: selvanair &lt;selva.nair@...1354...=
..&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>

</body></html>=

--9SHJQeMCvBc=--

