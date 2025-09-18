From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 18 Sep 2025 12:49:29 +0000
In-Reply-To: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
References: <gerrit.1758178873000.I071e8190dac28f429257b8af1c6f9e68f8896bc0@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <d1183ff0390477e99796b97dafe8d7824109e865-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FRjvIk1FJVs="; charset=UTF-8
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
To: plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FRjvIk1FJVs=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: cron2, flichtenheld, plaisthos.

Hello flichtenheld, plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld


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
---
M configure.ac
M src/openvpnserv/CMakeLists.txt
M src/openvpnserv/Makefile.am
3 files changed, 22 insertions(+), 4 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1197/3

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
index 82099f1..4496bae 100644
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
-    set_target_properties(openvpnservmsg PROPERTIES LINK_FLAGS "/NOENTRY")
+    set_target_properties(openvpnservmsg PRIVATE "/NOENTRY")
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
Gerrit-PatchSet: 3
Gerrit-Owner: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: cron2 <gert@...1296...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--FRjvIk1FJVs=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: cron2, flichtenheld, plaisthos. <=
/p>
<p>cron2 <strong>uploaded patch set #3</strong> to this change.</p><p><a hr=
ef=3D"http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail">View Change</=
a></p><p>The following approvals got outdated and were removed:
Code-Review-1 by flichtenheld</p><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;">fix building of openvpnsrvmsg.dll from eventm=
sg.mc in mingw builds<br><br>commit 06919a60ae61 introduces .mc files that =
need to be compiled to<br>.h and .bin by the windows &quot;mc.exe&quot; too=
l, and from there into a new<br>.dll.  This worked for MSVC builds, did not=
hing for cmake/mingw builds,<br>and broke compilation on autoconf/mingw bui=
lds.<br><br>This patch consists of two parts:<br><br>1. add building of ope=
nvpnsrvmsg.dll to autoconf/mingw builds<br><br>   Add logic to configure.ac=
 to find the &quot;windmc&quot; binary in the linux or<br>   mingw variants=
, add rules to src/openvpnserv/Makefile.am so make knows<br>   what to do.<=
br><br>   Libtool is getting in the way when &quot;openvpnsrvmsg.dll&quot; =
is created as<br>   anything listed in ...BIN or ...LIB, so decare it as &q=
uot;DATA&quot; and make<br>   the necessary rules explicit.<br><br>2. fix b=
uilding of openvpnsrvmsg.dll on cmake/mingw builds<br><br>   Fix &quot;find=
_program()&quot; invocation to avoid using &quot;midnight commander&quot;<b=
r>   binary (mc) on Linux (called &quot;windmc&quot; there).<br><br>   Chan=
ge from &quot;-Wl,--noentry&quot; to linker invocation that works.<br><br>S=
ee also:<br>https://learn.microsoft.com/en-us/cpp/build/creating-a-resource=
-only-dll?view=3Dmsvc-170<br><br>Change-Id: I071e8190dac28f429257b8af1c6f9e=
68f8896bc0<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br=
>M configure.ac<br>M src/openvpnserv/CMakeLists.txt<br>M src/openvpnserv/Ma=
kefile.am<br>3 files changed, 22 insertions(+), 4 deletions(-)<br><br></pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">gi=
t pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/97/1197/3</pre><=
pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><spa=
n>diff --git a/configure.ac b/configure.ac</span><br><span>index 7059871..3=
8b14a1 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/conf=
igure.ac</span><br><span>@@ -441,6 +441,7 @@</span><br><span> AC_DEFINE_UNQ=
UOTED([IPROUTE_PATH], [&quot;$IPROUTE&quot;], [Path to iproute tool])</span=
><br><span> AC_DEFINE_UNQUOTED([ROUTE_PATH], [&quot;$ROUTE&quot;], [Path to=
 route tool])</span><br><span> AC_DEFINE_UNQUOTED([SYSTEMD_ASK_PASSWORD_PAT=
H], [&quot;$SYSTEMD_ASK_PASSWORD&quot;], [Path to systemd-ask-password tool=
])</span><br><span style=3D"color: hsl(120, 100%, 40%);">+AC_CHECK_TOOLS([W=
INDMC], [windmc mc.exe],[no])</span><br><span> </span><br><span> #</span><b=
r><span> #  man page generation - based on python-docutils</span><br><span>=
diff --git a/src/openvpnserv/CMakeLists.txt b/src/openvpnserv/CMakeLists.tx=
t</span><br><span>index 82099f1..4496bae 100644</span><br><span>--- a/src/o=
penvpnserv/CMakeLists.txt</span><br><span>+++ b/src/openvpnserv/CMakeLists.=
txt</span><br><span>@@ -41,7 +41,7 @@</span><br><span> file(MAKE_DIRECTORY =
${MC_GEN_DIR})</span><br><span> set(MC_FILE ${CMAKE_CURRENT_SOURCE_DIR}/eve=
ntmsg.mc)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-find_program(MC_COMPILER NAMES mc mc.exe x86_64-w64-mingw32-windmc i6=
86-w64-mingw32-windmc windmc)</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+find_program(MC_COMPILER NAMES mc.exe x86_64-w64-mingw32-windmc i=
686-w64-mingw32-windmc windmc)</span><br><span> </span><br><span> if (NOT M=
C_COMPILER)</span><br><span>     message(FATAL_ERROR &quot;No message compi=
ler found.&quot;)</span><br><span>@@ -58,12 +58,17 @@</span><br><span> add_=
custom_target(msg_mc_gen ALL DEPENDS ${MC_GEN_DIR}/eventmsg.rc ${MC_GEN_DIR=
}/eventmsg.h)</span><br><span> </span><br><span> add_library(openvpnservmsg=
 SHARED ${MC_GEN_DIR}/eventmsg.rc)</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+add_dependencies(openvpnservmsg msg_mc_gen)</span><br><span>=
 </span><br><span> if (MSVC)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    set_target_properties(openvpnservmsg PROPERTIES LINK_FLAGS &quot=
;/NOENTRY&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 set_target_properties(openvpnservmsg PRIVATE &quot;/NOENTRY&quot;)</span><=
br><span> else()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    t=
arget_link_options(openvpnservmsg PRIVATE &quot;-Wl,--no-entry&quot;)</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+    set_target_properties=
(openvpnservmsg PROPERTIES LINKER_LANGUAGE C OUTPUT_NAME &quot;openvpnservm=
sg&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    target=
_link_options(openvpnservmsg PRIVATE</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+        -Wl,--entry=3D0</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        -nostdlib</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+        -nostartfiles</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+    )</span><br><span> endif()</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-add_dependencies(openvpnser=
vmsg msg_mc_gen)</span><br><span> add_dependencies(openvpnserv msg_mc_gen)<=
/span><br><span>diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/=
Makefile.am</span><br><span>index ef5f3f3..a27fbbf 100644</span><br><span>-=
-- a/src/openvpnserv/Makefile.am</span><br><span>+++ b/src/openvpnserv/Make=
file.am</span><br><span>@@ -28,6 +28,10 @@</span><br><span> openvpnserv_LDA=
DD =3D \</span><br><span> 	-ladvapi32 -luserenv -liphlpapi -lfwpuclnt -lrpc=
rt4 \</span><br><span> 	-lshlwapi -lnetapi32 -lws2_32 -lntdll -lole32</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+noinst_DATA =3D \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	MSG00409.bin eventmsg.h ev=
entmsg.rc openvpnservmsg.dll</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+BUILT_SOURCES =3D \</span><br><span style=3D"color: hsl(120, 100%,=
 40%);">+	eventmsg.h</span><br><span> endif</span><br><span> </span><br><sp=
an> openvpnserv_SOURCES =3D \</span><br><span>@@ -37,3 +41,11 @@</span><br>=
<span> 	validate.c validate.h \</span><br><span> 	$(top_srcdir)/src/openvpn=
/wfp_block.c $(top_srcdir)/src/openvpn/wfp_block.h \</span><br><span> 	open=
vpnserv_resources.rc</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+openvpnservmsg.dll=
: eventmsg.o</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	$(CC) =
-shared -Wl,--entry=3D0 -nostdlib -nostartfiles -o $@ $&lt;</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+eventmsg.o: eventmsg.rc</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+eventmsg.h: eventmsg.mc</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+	$(WINDMC) -U $&lt;</span><br><span></span><br></pre><p>To view, =
visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail">ch=
ange 1197</a>. To unsubscribe, or for help writing mail filters, visit <a h=
ref=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope =
itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"acti=
on" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/1197?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I071e8190dac28f429257b8af1c6=
f9e68f8896bc0 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1197 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: cron2 &lt;gert@...1296...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: cron2 &lt;gert@...1296...&gt=
; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FRjvIk1FJVs=--

