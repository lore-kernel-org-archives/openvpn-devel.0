From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 6 Sep 2024 20:13:50 +0000
In-Reply-To: <gerrit.1720619824000.I9b7a3df012e7606ddb04a944e3fa33247180e8dd@...2715...>
References: <gerrit.1720619824000.I9b7a3df012e7606ddb04a944e3fa33247180e8dd@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 yura.uddr@...277...
Message-ID: <859c3c7380a68f0bd1d8d6476be1239c27564f25-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zib/vpnUZMo="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Allow to
 detect git checkout if .git is not a directory
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>, uddr <yura.uddr@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zib/vpnUZMo=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#4) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/675?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos, Code-Review+2 by uddr


Change subject: configure: Allow to detect git checkout if .git is not a di=
rectory
......................................................................

configure: Allow to detect git checkout if .git is not a directory

E.g. if you use openvpn as a git submodule, it can be a
file that points to the parent's git directory.

The changes to Makefile.am are not strictly required, they
still work with that case, but I wanted to keep the usage
consistent.

Change-Id: I9b7a3df012e7606ddb04a944e3fa33247180e8dd
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Arne Schwabe <arne-openvpn@...1227...>
Acked-by: Yuriy Darnobyt <yura.uddr@...277...>
Message-Id: <20240906172112.87148-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg29=
092.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M Makefile.am
M configure.ac
2 files changed, 8 insertions(+), 6 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/675/4

diff --git a/Makefile.am b/Makefile.am
index 87230fe..84b7112 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -75,9 +75,9 @@
 	README.wolfssl

 config-version.h:
-	@CONFIGURE_GIT_CHFILES=3D"`GIT_DIR=3D\"$(top_srcdir)/.git\" $(GIT) diff-f=
iles --name-status -r --ignore-submodules --quiet -- || echo \"+\"`"; \
-	CONFIGURE_GIT_UNCOMMITTED=3D"`GIT_DIR=3D\"$(top_srcdir)/.git\" $(GIT) dif=
f-index --cached  --quiet --ignore-submodules HEAD || echo \"*\"`"; \
-	CONFIGURE_GIT_REVISION=3D"`GIT_DIR=3D\"$(top_srcdir)/.git\" $(GIT) rev-pa=
rse --symbolic-full-name HEAD | cut -d/ -f3-`/`GIT_DIR=3D\"$(top_srcdir)/.g=
it\" $(GIT) rev-parse --short=3D16 HEAD`"; \
+	@CONFIGURE_GIT_CHFILES=3D"`$(GIT) -C \"$(top_srcdir)\" diff-files --name-=
status -r --ignore-submodules --quiet -- || echo \"+\"`"; \
+	CONFIGURE_GIT_UNCOMMITTED=3D"`$(GIT) -C \"$(top_srcdir)\" diff-index --ca=
ched  --quiet --ignore-submodules HEAD || echo \"*\"`"; \
+	CONFIGURE_GIT_REVISION=3D"`$(GIT) -C \"$(top_srcdir)\" rev-parse --symbol=
ic-full-name HEAD | cut -d/ -f3-`/`$(GIT) -C \"$(top_srcdir)\" rev-parse --=
short=3D16 HEAD`"; \
 	echo "#define CONFIGURE_GIT_REVISION \"$${CONFIGURE_GIT_REVISION}\"" > co=
nfig-version.h.tmp; \
 	echo "#define CONFIGURE_GIT_FLAGS \"$${CONFIGURE_GIT_CHFILES}$${CONFIGURE=
_GIT_UNCOMMITTED}\"" >> config-version.h.tmp

diff --git a/configure.ac b/configure.ac
index 9ce826c..ea0da1f 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1308,9 +1308,11 @@

 AC_MSG_CHECKING([git checkout])
 GIT_CHECKOUT=3D"no"
-if test -n "${GIT}" -a -d "${srcdir}/.git"; then
-	AC_DEFINE([HAVE_CONFIG_VERSION_H], [1], [extra version available in confi=
g-version.h])
-	GIT_CHECKOUT=3D"yes"
+if test -n "${GIT}"; then
+	if ${GIT} -C "$srcdir" rev-parse --is-inside-work-tree >/dev/null 2>&1; t=
hen
+		AC_DEFINE([HAVE_CONFIG_VERSION_H], [1], [extra version available in conf=
ig-version.h])
+		GIT_CHECKOUT=3D"yes"
+	fi
 fi
 AC_MSG_RESULT([${GIT_CHECKOUT}])


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/675?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9b7a3df012e7606ddb04a944e3fa33247180e8dd
Gerrit-Change-Number: 675
Gerrit-PatchSet: 4
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: uddr <yura.uddr@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--zib/vpnUZMo=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #4</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/675?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by plaisthos, Code-Review+2 by uddr</p><pre style=3D"font-fam=
ily: monospace,monospace; white-space: pre-wrap;">configure: Allow to detec=
t git checkout if .git is not a directory<br><br>E.g. if you use openvpn as=
 a git submodule, it can be a<br>file that points to the parent&#39;s git d=
irectory.<br><br>The changes to Makefile.am are not strictly required, they=
<br>still work with that case, but I wanted to keep the usage<br>consistent=
.<br><br>Change-Id: I9b7a3df012e7606ddb04a944e3fa33247180e8dd<br>Signed-off=
-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Arne Schwabe &=
lt;arne-openvpn@...1227...&gt;<br>Acked-by: Yuriy Darnobyt &lt;yura.uddr@...1186...=
.277...&gt;<br>Message-Id: &lt;20240906172112.87148-1-frank@...2641...&gt;<=
br>URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/ms=
g29092.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<b=
r>M Makefile.am<br>M configure.ac<br>2 files changed, 8 insertions(+), 6 de=
letions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; whi=
te-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/c=
hanges/75/675/4</pre><pre style=3D"font-family: monospace,monospace; white-=
space: pre-wrap;"><span>diff --git a/Makefile.am b/Makefile.am</span><br><s=
pan>index 87230fe..84b7112 100644</span><br><span>--- a/Makefile.am</span><=
br><span>+++ b/Makefile.am</span><br><span>@@ -75,9 +75,9 @@</span><br><spa=
n> 	README.wolfssl</span><br><span> </span><br><span> config-version.h:</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	@CONFIGURE_GIT_CHFILES=
=3D&quot;`GIT_DIR=3D\&quot;$(top_srcdir)/.git\&quot; $(GIT) diff-files --na=
me-status -r --ignore-submodules --quiet -- || echo \&quot;+\&quot;`&quot;;=
 \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	CONFIGURE_GIT_UNCO=
MMITTED=3D&quot;`GIT_DIR=3D\&quot;$(top_srcdir)/.git\&quot; $(GIT) diff-ind=
ex --cached  --quiet --ignore-submodules HEAD || echo \&quot;*\&quot;`&quot=
;; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	CONFIGURE_GIT_RE=
VISION=3D&quot;`GIT_DIR=3D\&quot;$(top_srcdir)/.git\&quot; $(GIT) rev-parse=
 --symbolic-full-name HEAD | cut -d/ -f3-`/`GIT_DIR=3D\&quot;$(top_srcdir)/=
.git\&quot; $(GIT) rev-parse --short=3D16 HEAD`&quot;; \</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	@CONFIGURE_GIT_CHFILES=3D&quot;`$(GIT=
) -C \&quot;$(top_srcdir)\&quot; diff-files --name-status -r --ignore-submo=
dules --quiet -- || echo \&quot;+\&quot;`&quot;; \</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+	CONFIGURE_GIT_UNCOMMITTED=3D&quot;`$(GIT) -=
C \&quot;$(top_srcdir)\&quot; diff-index --cached  --quiet --ignore-submodu=
les HEAD || echo \&quot;*\&quot;`&quot;; \</span><br><span style=3D"color: =
hsl(120, 100%, 40%);">+	CONFIGURE_GIT_REVISION=3D&quot;`$(GIT) -C \&quot;$(=
top_srcdir)\&quot; rev-parse --symbolic-full-name HEAD | cut -d/ -f3-`/`$(G=
IT) -C \&quot;$(top_srcdir)\&quot; rev-parse --short=3D16 HEAD`&quot;; \</s=
pan><br><span> 	echo &quot;#define CONFIGURE_GIT_REVISION \&quot;$${CONFIGU=
RE_GIT_REVISION}\&quot;&quot; &gt; config-version.h.tmp; \</span><br><span>=
 	echo &quot;#define CONFIGURE_GIT_FLAGS \&quot;$${CONFIGURE_GIT_CHFILES}$$=
{CONFIGURE_GIT_UNCOMMITTED}\&quot;&quot; &gt;&gt; config-version.h.tmp</spa=
n><br><span> </span><br><span>diff --git a/configure.ac b/configure.ac</spa=
n><br><span>index 9ce826c..ea0da1f 100644</span><br><span>--- a/configure.a=
c</span><br><span>+++ b/configure.ac</span><br><span>@@ -1308,9 +1308,11 @@=
</span><br><span> </span><br><span> AC_MSG_CHECKING([git checkout])</span><=
br><span> GIT_CHECKOUT=3D&quot;no&quot;</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-if test -n &quot;${GIT}&quot; -a -d &quot;${srcdir}/.git&=
quot;; then</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	AC_DEFINE=
([HAVE_CONFIG_VERSION_H], [1], [extra version available in config-version.h=
])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	GIT_CHECKOUT=3D&qu=
ot;yes&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+if test=
 -n &quot;${GIT}&quot;; then</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	if ${GIT} -C &quot;$srcdir&quot; rev-parse --is-inside-work-tree =
&gt;/dev/null 2&gt;&amp;1; then</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+		AC_DEFINE([HAVE_CONFIG_VERSION_H], [1], [extra version availa=
ble in config-version.h])</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+		GIT_CHECKOUT=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	fi</span><br><span> fi</span><br><span> AC_MSG_RESULT([=
${GIT_CHECKOUT}])</span><br><span> </span><br><span></span><br></pre><p>To =
view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/675?usp=3Demai=
l">change 675</a>. To unsubscribe, or for help writing mail filters, visit =
<a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsc=
ope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"=
action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/675?usp=3Demail"/><meta itempro=
p=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b7a3df012e7606ddb04a944e3f=
a33247180e8dd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 675 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 4 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: uddr &lt;yura.uddr@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--zib/vpnUZMo=--

