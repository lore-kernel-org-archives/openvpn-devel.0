From: "cron2 (Code Review)" <gerrit@...515...>
Date: Fri, 19 Sep 2025 12:33:20 +0000
In-Reply-To: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
References: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., selva.nair@...277...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <e2bf21190b7c162aaa246a3d07c8a54b70bf2f4e-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="qcTe74tF9OQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: fix building of
 openvpnsrvmsg.dll from eventmsg.mc in mingw builds
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>, selvanair <selva.nair@...277...>

--qcTe74tF9OQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: stipa.

Hello flichtenheld, plaisthos, stipa,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail

to look at the new patch set (#5).

The following approvals got outdated and were removed:
Code-Review+1 by stipa, Code-Review+2 by flichtenheld


Change subject: fix building of openvpnsrvmsg.dll from eventmsg.mc in mingw=
 builds
......................................................................

fix building of openvpnsrvmsg.dll from eventmsg.mc in mingw builds

commit 06919a60ae61 introduces .mc files that need to be compiled to
.h and .bin by the windows "mc.exe" tool, and from there into a new
.dll.  This worked for MSVC builds, did nothing for cmake/mingw builds,
and broke compilation on autoconf/mingw builds.

This patch consists of two parts:

1. add building of openvpnsrvmsg.dll to autoconf/mingw builds

   Add logic to configure.ac to find the "windmc" binary in the linux or
   mingw variants, add rules to src/openvpnserv/Makefile.am so make knows
   what to do.

   Libtool is getting in the way when "openvpnsrvmsg.dll" is created as
   anything listed in ...BIN or ...LIB, so decare it as "DATA" and make
   the necessary rules explicit.

2. fix building of openvpnsrvmsg.dll on cmake/mingw builds

   Fix "find_program()" invocation to avoid using "midnight commander"
   binary (mc) on Linux (called "windmc" there).

   Change from "-Wl,--noentry" to linker invocation that works.

See also:
https://learn.microsoft.com/en-us/cpp/build/creating-a-resource-only-dll?vi=
ew=3Dmsvc-170

Change-Id: I071e8190dac28f429257b8af1c6f9e68f8896bc0
Signed-off-by: Gert Doering <gert@...1296...>
Acked-by: Frank Lichtenheld <frank@...2641...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1197
Message-Id: <20250919112424.24728-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg33=
083.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M configure.ac
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/Makefile.am
3 files changed, 21 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1197/5

diff --git a/configure.ac b/configure.ac
index 7059871..38b14a1 100644
--- a/configure.ac
+++ b/configure.ac
@@ -441,6 +441,7 @@
 AC_DEFINE_UNQUOTED([IPROUTE_PATH], ["$IPROUTE"], [Path to iproute tool])
 AC_DEFINE_UNQUOTED([ROUTE_PATH], ["$ROUTE"], [Path to route tool])
 AC_DEFINE_UNQUOTED([SYSTEMD_ASK_PASSWORD_PATH], ["$SYSTEMD_ASK_PASSWORD"],=
 [Path to systemd-ask-password tool])
+AC_CHECK_TOOLS([WINDMC], [windmc mc.exe],[no])

 #
 #  man page generation - based on python-docutils
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.txt
index 82099f1..340b904 100644
--- a/src/openvpnserv/CMakeLists.txt
+++ b/src/openvpnserv/CMakeLists.txt
@@ -41,7 +41,7 @@
 file(MAKE_DIRECTORY ${MC_GEN_DIR})
 set(MC_FILE ${CMAKE_CURRENT_SOURCE_DIR}/eventmsg.mc)

-find_program(MC_COMPILER NAMES mc mc.exe x86_64-w64-mingw32-windmc i686-w6=
4-mingw32-windmc windmc)
+find_program(MC_COMPILER NAMES mc.exe x86_64-w64-mingw32-windmc i686-w64-m=
ingw32-windmc windmc)

 if (NOT MC_COMPILER)
     message(FATAL_ERROR "No message compiler found.")
@@ -58,12 +58,17 @@
 add_custom_target(msg_mc_gen ALL DEPENDS ${MC_GEN_DIR}/eventmsg.rc ${MC_GE=
N_DIR}/eventmsg.h)

 add_library(openvpnservmsg SHARED ${MC_GEN_DIR}/eventmsg.rc)
+add_dependencies(openvpnservmsg msg_mc_gen)

 if (MSVC)
     set_target_properties(openvpnservmsg PROPERTIES LINK_FLAGS "/NOENTRY")
 else()
-    target_link_options(openvpnservmsg PRIVATE "-Wl,--no-entry")
+    set_target_properties(openvpnservmsg PROPERTIES LINKER_LANGUAGE C OUTP=
UT_NAME "openvpnservmsg")
+    target_link_options(openvpnservmsg PRIVATE
+        -Wl,--entry=3D0
+        -nostdlib
+        -nostartfiles
+    )
 endif()

-add_dependencies(openvpnservmsg msg_mc_gen)
 add_dependencies(openvpnserv msg_mc_gen)
diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index ef5f3f3..a27fbbf 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -28,6 +28,10 @@
 openvpnserv_LDADD =3D \
 	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpcrt4 \
 	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32
+noinst_DATA =3D \
+	MSG00409.bin eventmsg.h eventmsg.rc openvpnservmsg.dll
+BUILT_SOURCES =3D \
+	eventmsg.h
 endif

 openvpnserv_SOURCES =3D \
@@ -37,3 +41,11 @@
 	validate.c validate.h \
 	$(top_srcdir)/src/openvpn/wfp_block.c $(top_srcdir)/src/openvpn/wfp_block=
.h \
 	openvpnserv_resources.rc
+
+openvpnservmsg.dll: eventmsg.o
+	$(CC) -shared -Wl,--entry=3D0 -nostdlib -nostartfiles -o $@ $<
+
+eventmsg.o: eventmsg.rc
+
+eventmsg.h: eventmsg.mc
+	$(WINDMC) -U $<

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I071e8190dac28f429257b8af1c6f9e68f8896bc0
Gerrit-Change-Number: 1197
Gerrit-PatchSet: 5
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-CC: selvanair <selva.nair@...277...>
Gerrit-Attention: stipa <lstipakov@...277...>
Gerrit-MessageType: newpatchset

--qcTe74tF9OQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: stipa. </p>
<p>cron2 <strong>uploaded patch set #5</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review+1 by stipa, Code-Review+2 by flichtenheld</p><pre style=3D"font=
-family: monospace,monospace; white-space: pre-wrap;">fix building of openv=
pnsrvmsg.dll from eventmsg.mc in mingw builds<br><br>commit 06919a60ae61 in=
troduces .mc files that need to be compiled to<br>.h and .bin by the window=
s &quot;mc.exe&quot; tool, and from there into a new<br>.dll.  This worked =
for MSVC builds, did nothing for cmake/mingw builds,<br>and broke compilati=
on on autoconf/mingw builds.<br><br>This patch consists of two parts:<br><b=
r>1. add building of openvpnsrvmsg.dll to autoconf/mingw builds<br><br>   A=
dd logic to configure.ac to find the &quot;windmc&quot; binary in the linux=
 or<br>   mingw variants, add rules to src/openvpnserv/Makefile.am so make =
knows<br>   what to do.<br><br>   Libtool is getting in the way when &quot;=
openvpnsrvmsg.dll&quot; is created as<br>   anything listed in ...BIN or ..=
.LIB, so decare it as &quot;DATA&quot; and make<br>   the necessary rules e=
xplicit.<br><br>2. fix building of openvpnsrvmsg.dll on cmake/mingw builds<=
br><br>   Fix &quot;find_program()&quot; invocation to avoid using &quot;mi=
dnight commander&quot;<br>   binary (mc) on Linux (called &quot;windmc&quot=
; there).<br><br>   Change from &quot;-Wl,--noentry&quot; to linker invocat=
ion that works.<br><br>See also:<br>https://learn.microsoft.com/en-us/cpp/b=
uild/creating-a-resource-only-dll?view=3Dmsvc-170<br><br>Change-Id: I071e81=
90dac28f429257b8af1c6f9e68f8896bc0<br>Signed-off-by: Gert Doering &lt;gert@=
...1296...&gt;<br>Acked-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>G=
errit URL: https://gerrit.openvpn.net/c/openvpn/+/1197<br>Message-Id: &lt;2=
0250919112424.24728-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg33083.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M configure.ac<br>M src/openvpn=
serv/CMakeLists.txt<br>M src/openvpnserv/Makefile.am<br>3 files changed, 21=
 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: mono=
space,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:=
29418/openvpn refs/changes/97/1197/5</pre><pre style=3D"font-family: monosp=
ace,monospace; white-space: pre-wrap;"><span>diff --git a/configure.ac b/co=
nfigure.ac</span><br><span>index 7059871..38b14a1 100644</span><br><span>--=
- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -441=
,6 +441,7 @@</span><br><span> AC_DEFINE_UNQUOTED([IPROUTE_PATH], [&quot;$IP=
ROUTE&quot;], [Path to iproute tool])</span><br><span> AC_DEFINE_UNQUOTED([=
ROUTE_PATH], [&quot;$ROUTE&quot;], [Path to route tool])</span><br><span> A=
C_DEFINE_UNQUOTED([SYSTEMD_ASK_PASSWORD_PATH], [&quot;$SYSTEMD_ASK_PASSWORD=
&quot;], [Path to systemd-ask-password tool])</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+AC_CHECK_TOOLS([WINDMC], [windmc mc.exe],[no])</s=
pan><br><span> </span><br><span> #</span><br><span> #  man page generation =
- based on python-docutils</span><br><span>diff --git a/src/openvpnserv/CMa=
keLists.txt b/src/openvpnserv/CMakeLists.txt</span><br><span>index 82099f1.=
.340b904 100644</span><br><span>--- a/src/openvpnserv/CMakeLists.txt</span>=
<br><span>+++ b/src/openvpnserv/CMakeLists.txt</span><br><span>@@ -41,7 +41=
,7 @@</span><br><span> file(MAKE_DIRECTORY ${MC_GEN_DIR})</span><br><span> =
set(MC_FILE ${CMAKE_CURRENT_SOURCE_DIR}/eventmsg.mc)</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-find_program(MC_COMPILER N=
AMES mc mc.exe x86_64-w64-mingw32-windmc i686-w64-mingw32-windmc windmc)</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+find_program(MC_COMPIL=
ER NAMES mc.exe x86_64-w64-mingw32-windmc i686-w64-mingw32-windmc windmc)</=
span><br><span> </span><br><span> if (NOT MC_COMPILER)</span><br><span>    =
 message(FATAL_ERROR &quot;No message compiler found.&quot;)</span><br><spa=
n>@@ -58,12 +58,17 @@</span><br><span> add_custom_target(msg_mc_gen ALL DEP=
ENDS ${MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR}/eventmsg.h)</span><br><span> <=
/span><br><span> add_library(openvpnservmsg SHARED ${MC_GEN_DIR}/eventmsg.r=
c)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+add_dependencies(=
openvpnservmsg msg_mc_gen)</span><br><span> </span><br><span> if (MSVC)</sp=
an><br><span>     set_target_properties(openvpnservmsg PROPERTIES LINK_FLAG=
S &quot;/NOENTRY&quot;)</span><br><span> else()</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    target_link_options(openvpnservmsg PRIVATE &q=
uot;-Wl,--no-entry&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+    set_target_properties(openvpnservmsg PROPERTIES LINKER_LANGUAGE C=
 OUTPUT_NAME &quot;openvpnservmsg&quot;)</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    target_link_options(openvpnservmsg PRIVATE</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+        -Wl,--entry=3D0</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+        -nostdlib</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+        -nostartfiles</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+    )</span><br><span> =
endif()</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-add_dependencies(openvpnservmsg msg_mc_gen)</span><br><span> add_depend=
encies(openvpnserv msg_mc_gen)</span><br><span>diff --git a/src/openvpnserv=
/Makefile.am b/src/openvpnserv/Makefile.am</span><br><span>index ef5f3f3..a=
27fbbf 100644</span><br><span>--- a/src/openvpnserv/Makefile.am</span><br><=
span>+++ b/src/openvpnserv/Makefile.am</span><br><span>@@ -28,6 +28,10 @@</=
span><br><span> openvpnserv_LDADD =3D \</span><br><span> 	-ladvapi32 -luser=
env -liphlpapi -lfwpuclnt -lrpcrt4 \</span><br><span> 	-lshlwapi -lnetapi32=
 -lws2_32 -lntdll -lole32</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+noinst_DATA =3D \</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+	MSG00409.bin eventmsg.h eventmsg.rc openvpnservmsg.dll</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+BUILT_SOURCES =3D \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	eventmsg.h</span><br><span> endif<=
/span><br><span> </span><br><span> openvpnserv_SOURCES =3D \</span><br><spa=
n>@@ -37,3 +41,11 @@</span><br><span> 	validate.c validate.h \</span><br><s=
pan> 	$(top_srcdir)/src/openvpn/wfp_block.c $(top_srcdir)/src/openvpn/wfp_b=
lock.h \</span><br><span> 	openvpnserv_resources.rc</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+openvpnservmsg.dll: eventmsg.o</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+	$(CC) -shared -Wl,--entry=3D0 -nostdlib -nostart=
files -o $@ $&lt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+eventmsg.o: eventmsg.=
rc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+eventmsg.h: eventmsg.mc</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+	$(WINDMC) -U $&lt;</span><br><s=
pan></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net=
/c/openvpn/+/1197?usp=3Demail">change 1197</a>. To unsubscribe, or for help=
 writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings"=
>settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage=
"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewActi=
on"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/11=
97?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I071e8190dac28f429257b8af1c6=
f9e68f8896bc0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1197 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-CC: selvanair &lt;selva.nair@...277...&=
gt; </div>
<div style=3D"display:none"> Gerrit-Attention: stipa &lt;lstipakov@...1663...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--qcTe74tF9OQ=--

