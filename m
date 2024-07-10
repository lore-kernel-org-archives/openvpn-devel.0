From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 10 Jul 2024 13:57:08 +0000
References: <gerrit.1720619824000.I9b7a3df012e7606ddb04a944e3fa33247180e8dd@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <dd79c388c2583697b461fa3b536431b47dbe1ecc-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="hEOMAIFC9AM="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--hEOMAIFC9AM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/675?usp=3Demail

to review the following change.


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
---
M Makefile.am
M configure.ac
2 files changed, 8 insertions(+), 6 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/75/675/1

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
index 3e7c0be..75c0aa9 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1284,9 +1284,11 @@

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newchange

--hEOMAIFC9AM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/675?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">configure: Allow to detect git checkout if .git is not a dire=
ctory<br><br>E.g. if you use openvpn as a git submodule, it can be a<br>fil=
e that points to the parent&#39;s git directory.<br><br>The changes to Make=
file.am are not strictly required, they<br>still work with that case, but I=
 wanted to keep the usage<br>consistent.<br><br>Change-Id: I9b7a3df012e7606=
ddb04a944e3fa33247180e8dd<br>Signed-off-by: Frank Lichtenheld &lt;frank@...493...=
2641...&gt;<br>---<br>M Makefile.am<br>M configure.ac<br>2 files changed, 8=
 insertions(+), 6 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/75/675/1</pre><pre style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;"><span>diff --git a/Makefile.am b/Make=
file.am</span><br><span>index 87230fe..84b7112 100644</span><br><span>--- a=
/Makefile.am</span><br><span>+++ b/Makefile.am</span><br><span>@@ -75,9 +75=
,9 @@</span><br><span> 	README.wolfssl</span><br><span> </span><br><span> c=
onfig-version.h:</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	@CON=
FIGURE_GIT_CHFILES=3D&quot;`GIT_DIR=3D\&quot;$(top_srcdir)/.git\&quot; $(GI=
T) diff-files --name-status -r --ignore-submodules --quiet -- || echo \&quo=
t;+\&quot;`&quot;; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
CONFIGURE_GIT_UNCOMMITTED=3D&quot;`GIT_DIR=3D\&quot;$(top_srcdir)/.git\&quo=
t; $(GIT) diff-index --cached  --quiet --ignore-submodules HEAD || echo \&q=
uot;*\&quot;`&quot;; \</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	CONFIGURE_GIT_REVISION=3D&quot;`GIT_DIR=3D\&quot;$(top_srcdir)/.git\&quot=
; $(GIT) rev-parse --symbolic-full-name HEAD | cut -d/ -f3-`/`GIT_DIR=3D\&q=
uot;$(top_srcdir)/.git\&quot; $(GIT) rev-parse --short=3D16 HEAD`&quot;; \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	@CONFIGURE_GIT_CHFI=
LES=3D&quot;`$(GIT) -C \&quot;$(top_srcdir)\&quot; diff-files --name-status=
 -r --ignore-submodules --quiet -- || echo \&quot;+\&quot;`&quot;; \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	CONFIGURE_GIT_UNCOMMITTED=
=3D&quot;`$(GIT) -C \&quot;$(top_srcdir)\&quot; diff-index --cached  --quie=
t --ignore-submodules HEAD || echo \&quot;*\&quot;`&quot;; \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	CONFIGURE_GIT_REVISION=3D&quot;`$=
(GIT) -C \&quot;$(top_srcdir)\&quot; rev-parse --symbolic-full-name HEAD | =
cut -d/ -f3-`/`$(GIT) -C \&quot;$(top_srcdir)\&quot; rev-parse --short=3D16=
 HEAD`&quot;; \</span><br><span> 	echo &quot;#define CONFIGURE_GIT_REVISION=
 \&quot;$${CONFIGURE_GIT_REVISION}\&quot;&quot; &gt; config-version.h.tmp; =
\</span><br><span> 	echo &quot;#define CONFIGURE_GIT_FLAGS \&quot;$${CONFIG=
URE_GIT_CHFILES}$${CONFIGURE_GIT_UNCOMMITTED}\&quot;&quot; &gt;&gt; config-=
version.h.tmp</span><br><span> </span><br><span>diff --git a/configure.ac b=
/configure.ac</span><br><span>index 3e7c0be..75c0aa9 100644</span><br><span=
>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -=
1284,9 +1284,11 @@</span><br><span> </span><br><span> AC_MSG_CHECKING([git =
checkout])</span><br><span> GIT_CHECKOUT=3D&quot;no&quot;</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-if test -n &quot;${GIT}&quot; -a -d &qu=
ot;${srcdir}/.git&quot;; then</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-	AC_DEFINE([HAVE_CONFIG_VERSION_H], [1], [extra version available i=
n config-version.h])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	=
GIT_CHECKOUT=3D&quot;yes&quot;</span><br><span style=3D"color: hsl(120, 100=
%, 40%);">+if test -n &quot;${GIT}&quot;; then</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+	if ${GIT} -C &quot;$srcdir&quot; rev-parse --is=
-inside-work-tree &gt;/dev/null 2&gt;&amp;1; then</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+		AC_DEFINE([HAVE_CONFIG_VERSION_H], [1], [ex=
tra version available in config-version.h])</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+		GIT_CHECKOUT=3D&quot;yes&quot;</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+	fi</span><br><span> fi</span><br><spa=
n> AC_MSG_RESULT([${GIT_CHECKOUT}])</span><br><span> </span><br><span></spa=
n><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvp=
n/+/675?usp=3Demail">change 675</a>. To unsubscribe, or for help writing ma=
il filters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</=
a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div item=
scope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link i=
temprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/675?usp=3Dema=
il"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9b7a3df012e7606ddb04a944e3f=
a33247180e8dd </div>
<div style=3D"display:none"> Gerrit-Change-Number: 675 </div>
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


--hEOMAIFC9AM=--

