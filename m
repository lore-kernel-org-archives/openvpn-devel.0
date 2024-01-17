From: "d12fk (Code Review)" <gerrit@...515...>
Date: Wed, 17 Jan 2024 03:49:59 +0000
References: <gerrit.1705463396000.Ib1a5c788269949d8de95d1da2cb0c32a65bf13f2@...2715...>
Reply-To: heiko@...515..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <9e05cfffe76aed0ef7d93db19560a28a69c9ea41-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="gVhIYovbJSI="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: cmake: symlink whole
 build dir not just .json file
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

--gVhIYovbJSI=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos, flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/501?usp=3Demail

to review the following change.


Change subject: cmake: symlink whole build dir not just .json file
......................................................................

cmake: symlink whole build dir not just .json file

It turned out that symlinking compile_commands.json from the top level
source dir has some issues:
  * file is not created on Windows and symlinking may cause an error
  * some IDEs create their own json and error out b/c a file exists

Since clangd also looks for the json in build/ directories by default,
we now symlink the whole build directory instead, not just the json file.

This approach requires for the existing build/ dir in the repo to
vanish. Luckily it only contains one automake include file, which is
moved to the top level source dir.

Lastly, make this an opt-in feature, so that the default configuration
of the buildsystem never causes a build failure because of this.

Change-Id: Ib1a5c788269949d8de95d1da2cb0c32a65bf13f2
Signed-off-by: Heiko Hund <heiko@...2662...>
---
M .gitignore
M CMakeLists.txt
M Makefile.am
M README.cmake.md
D build/Makefile.am
M configure.ac
R ltrc.inc
M src/openvpn/Makefile.am
M src/openvpnmsica/Makefile.am
M src/openvpnserv/Makefile.am
M src/tapctl/Makefile.am
11 files changed, 32 insertions(+), 25 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/501/1

diff --git a/.gitignore b/.gitignore
index 4153a3e..92d65bf 100644
--- a/.gitignore
+++ b/.gitignore
@@ -40,7 +40,7 @@
 m4/ltversion.m4
 m4/lt~obsolete.m4

-compile_commands.json
+build
 doc/openvpn-examples.5
 doc/openvpn-examples.5.html
 doc/openvpn.8
diff --git a/CMakeLists.txt b/CMakeLists.txt
index bc46c27..4e5c8fa 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -43,9 +43,17 @@
 set(PLUGIN_DIR /usr/local/lib/openvpn/plugins CACHE FILEPATH "Location of =
the plugin directory")

 # Create machine readable compile commands
-set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
-file(CREATE_LINK ${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json
-                 ${CMAKE_CURRENT_SOURCE_DIR}/compile_commands.json SYMBOLI=
C)
+option(ENABLE_COMPILE_COMMANDS "Generate compile_commands.json and a symli=
nk for clangd to find it" OFF)
+if (ENABLE_COMPILE_COMMANDS)
+    if (EXISTS ${CMAKE_CURRENT_SOURCE_DIR}/build AND NOT IS_SYMLINK ${CMAK=
E_CURRENT_SOURCE_DIR}/build)
+        message(FATAL_ERROR "The top level source directory contains a 'bu=
ild' file or directory. Please remove or rename it. CMake creates a symlink=
 with that name during build.")
+    endif()
+    set(CMAKE_EXPORT_COMPILE_COMMANDS 1)
+    add_custom_target(
+        symlink-build-dir ALL
+        ${CMAKE_COMMAND} -E create_symlink ${CMAKE_CURRENT_BINARY_DIR} ${C=
MAKE_CURRENT_SOURCE_DIR}/build
+        )
+endif ()

 # AddressSanitize - use CXX=3Dclang++ CC=3Dclang cmake -DCMAKE_BUILD_TYPE=
=3Dasan to build with ASAN
 set(CMAKE_C_FLAGS_ASAN
diff --git a/Makefile.am b/Makefile.am
index 2305ab4..792588a 100644
--- a/Makefile.am
+++ b/Makefile.am
@@ -42,6 +42,7 @@
 EXTRA_DIST =3D \
 	contrib \
 	debug \
+	ltrc.inc \
 	CMakeLists.txt \
 	CMakePresets.json \
 	config.h.cmake.in
@@ -53,7 +54,7 @@
 	config-version.h
 endif

-SUBDIRS =3D build distro include src sample doc tests
+SUBDIRS =3D distro include src sample doc tests

 dist_doc_DATA =3D \
 	README \
diff --git a/README.cmake.md b/README.cmake.md
index d181b64..4f41c70 100644
--- a/README.cmake.md
+++ b/README.cmake.md
@@ -135,3 +135,17 @@
 The `unix-native` CMake preset is available for these builds. This preset =
does
 not require VCPKG and instead assumes all build-dependencies are provided =
by
 the system natively.
+
+Generating compile_commands.json
+--------------------------------
+
+To have the CMake buildsystem generate compile_commands.json you can speci=
fy
+`-DENABLE_COMPILE_COMMANDS=3DON` on the command line or enable the CMake o=
ption
+another way you like. For supported generators the file will then be creat=
ed.
+Additionally, the buildsystem will create a symlink `build/` to the --pres=
et
+build directory that contains the generated JSON file. This is done so that
+clangd is able to find it.
+
+Enabling this option may cause an error on Windows, since creating a symli=
nk
+is a privileged operation there. If you enable Developer Mode for the syst=
em,
+symlinks can be created by regular users.
diff --git a/build/Makefile.am b/build/Makefile.am
deleted file mode 100644
index e7cc4d8..0000000
--- a/build/Makefile.am
+++ /dev/null
@@ -1,15 +0,0 @@
-#
-#  OpenVPN -- An application to securely tunnel IP networks
-#             over a single UDP port, with support for SSL/TLS-based
-#             session authentication and key exchange,
-#             packet encryption, packet authentication, and
-#             packet compression.
-#
-#  Copyright (C) 2002-2023 OpenVPN Inc <sales@...515...>
-#
-
-MAINTAINERCLEANFILES =3D \
-	$(srcdir)/Makefile.in
-
-EXTRA_DIST =3D \
-	ltrc.inc
diff --git a/configure.ac b/configure.ac
index 2823f04..0710f71 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1515,7 +1515,6 @@

 AC_CONFIG_FILES([
 	Makefile
-	build/Makefile
 	distro/Makefile
 	distro/systemd/Makefile
 	doc/Makefile
diff --git a/build/ltrc.inc b/ltrc.inc
similarity index 100%
rename from build/ltrc.inc
rename to ltrc.inc
diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile.am
index b953961..1dc1dda 100644
--- a/src/openvpn/Makefile.am
+++ b/src/openvpn/Makefile.am
@@ -9,7 +9,7 @@
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #

-include $(top_srcdir)/build/ltrc.inc
+include $(top_srcdir)/ltrc.inc

 MAINTAINERCLEANFILES =3D \
 	$(srcdir)/Makefile.in
diff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am
index dc53f75..b10ce82 100644
--- a/src/openvpnmsica/Makefile.am
+++ b/src/openvpnmsica/Makefile.am
@@ -18,7 +18,7 @@
 #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #

-include $(top_srcdir)/build/ltrc.inc
+include $(top_srcdir)/ltrc.inc

 MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in

diff --git a/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am
index d8ba4eb..0c64cce 100644
--- a/src/openvpnserv/Makefile.am
+++ b/src/openvpnserv/Makefile.am
@@ -9,7 +9,7 @@
 #  Copyright (C) 2006-2012 Alon Bar-Lev <alon.barlev@...277...>
 #

-include $(top_srcdir)/build/ltrc.inc
+include $(top_srcdir)/ltrc.inc

 MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in

diff --git a/src/tapctl/Makefile.am b/src/tapctl/Makefile.am
index 69ea161..4c2958b 100644
--- a/src/tapctl/Makefile.am
+++ b/src/tapctl/Makefile.am
@@ -18,7 +18,7 @@
 #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #

-include $(top_srcdir)/build/ltrc.inc
+include $(top_srcdir)/ltrc.inc

 MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/501?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ib1a5c788269949d8de95d1da2cb0c32a65bf13f2
Gerrit-Change-Number: 501
Gerrit-PatchSet: 1
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--gVhIYovbJSI=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>d12fk would like plaisthos and flichtenheld to <strong>review</strong> t=
his change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/501?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">cmake: symlink whole build dir not just .json file<br><br>It =
turned out that symlinking compile_commands.json from the top level<br>sour=
ce dir has some issues:<br>  * file is not created on Windows and symlinkin=
g may cause an error<br>  * some IDEs create their own json and error out b=
/c a file exists<br><br>Since clangd also looks for the json in build/ dire=
ctories by default,<br>we now symlink the whole build directory instead, no=
t just the json file.<br><br>This approach requires for the existing build/=
 dir in the repo to<br>vanish. Luckily it only contains one automake includ=
e file, which is<br>moved to the top level source dir.<br><br>Lastly, make =
this an opt-in feature, so that the default configuration<br>of the buildsy=
stem never causes a build failure because of this.<br><br>Change-Id: Ib1a5c=
788269949d8de95d1da2cb0c32a65bf13f2<br>Signed-off-by: Heiko Hund &lt;heiko@=
...2662...&gt;<br>---<br>M .gitignore<br>M CMakeLists.txt<br>M Makefile.am<=
br>M README.cmake.md<br>D build/Makefile.am<br>M configure.ac<br>R ltrc.inc=
<br>M src/openvpn/Makefile.am<br>M src/openvpnmsica/Makefile.am<br>M src/op=
envpnserv/Makefile.am<br>M src/tapctl/Makefile.am<br>11 files changed, 32 i=
nsertions(+), 25 deletions(-)<br><br></pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2=
9418/openvpn refs/changes/01/501/1</pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;"><span>diff --git a/.gitignore b/.gitig=
nore</span><br><span>index 4153a3e..92d65bf 100644</span><br><span>--- a/.g=
itignore</span><br><span>+++ b/.gitignore</span><br><span>@@ -40,7 +40,7 @@=
</span><br><span> m4/ltversion.m4</span><br><span> m4/lt~obsolete.m4</span>=
<br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-compile_co=
mmands.json</span><br><span style=3D"color: hsl(120, 100%, 40%);">+build</s=
pan><br><span> doc/openvpn-examples.5</span><br><span> doc/openvpn-examples=
.5.html</span><br><span> doc/openvpn.8</span><br><span>diff --git a/CMakeLi=
sts.txt b/CMakeLists.txt</span><br><span>index bc46c27..4e5c8fa 100644</spa=
n><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span=
><br><span>@@ -43,9 +43,17 @@</span><br><span> set(PLUGIN_DIR /usr/local/li=
b/openvpn/plugins CACHE FILEPATH &quot;Location of the plugin directory&quo=
t;)</span><br><span> </span><br><span> # Create machine readable compile co=
mmands</span><br><span style=3D"color: hsl(0, 100%, 40%);">-set(CMAKE_EXPOR=
T_COMPILE_COMMANDS 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
file(CREATE_LINK ${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-                 ${CMAKE_CURRE=
NT_SOURCE_DIR}/compile_commands.json SYMBOLIC)</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+option(ENABLE_COMPILE_COMMANDS &quot;Generate co=
mpile_commands.json and a symlink for clangd to find it&quot; OFF)</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+if (ENABLE_COMPILE_COMMANDS)=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    if (EXISTS ${CM=
AKE_CURRENT_SOURCE_DIR}/build AND NOT IS_SYMLINK ${CMAKE_CURRENT_SOURCE_DIR=
}/build)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+        mes=
sage(FATAL_ERROR &quot;The top level source directory contains a &#39;build=
&#39; file or directory. Please remove or rename it. CMake creates a symlin=
k with that name during build.&quot;)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    endif()</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+    set(CMAKE_EXPORT_COMPILE_COMMANDS 1)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+    add_custom_target(</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+        symlink-build-dir ALL</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+        ${CMAKE_COMMAND} -E cre=
ate_symlink ${CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/build</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+endif ()</span><br><span> </spa=
n><br><span> # AddressSanitize - use CXX=3Dclang++ CC=3Dclang cmake -DCMAKE=
_BUILD_TYPE=3Dasan to build with ASAN</span><br><span> set(CMAKE_C_FLAGS_AS=
AN</span><br><span>diff --git a/Makefile.am b/Makefile.am</span><br><span>i=
ndex 2305ab4..792588a 100644</span><br><span>--- a/Makefile.am</span><br><s=
pan>+++ b/Makefile.am</span><br><span>@@ -42,6 +42,7 @@</span><br><span> EX=
TRA_DIST =3D \</span><br><span> 	contrib \</span><br><span> 	debug \</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+	ltrc.inc \</span><br><spa=
n> 	CMakeLists.txt \</span><br><span> 	CMakePresets.json \</span><br><span>=
 	config.h.cmake.in</span><br><span>@@ -53,7 +54,7 @@</span><br><span> 	con=
fig-version.h</span><br><span> endif</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-SUBDIRS =3D build distro include src sampl=
e doc tests</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SUBDIRS =
=3D distro include src sample doc tests</span><br><span> </span><br><span> =
dist_doc_DATA =3D \</span><br><span> 	README \</span><br><span>diff --git a=
/README.cmake.md b/README.cmake.md</span><br><span>index d181b64..4f41c70 1=
00644</span><br><span>--- a/README.cmake.md</span><br><span>+++ b/README.cm=
ake.md</span><br><span>@@ -135,3 +135,17 @@</span><br><span> The `unix-nati=
ve` CMake preset is available for these builds. This preset does</span><br>=
<span> not require VCPKG and instead assumes all build-dependencies are pro=
vided by</span><br><span> the system natively.</span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+Generating compile_commands.json</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+--------------------------------</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+To have the CMake buildsystem generate compile_commands.json=
 you can specify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`-D=
ENABLE_COMPILE_COMMANDS=3DON` on the command line or enable the CMake optio=
n</span><br><span style=3D"color: hsl(120, 100%, 40%);">+another way you li=
ke. For supported generators the file will then be created.</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+Additionally, the buildsystem will =
create a symlink `build/` to the --preset</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+build directory that contains the generated JSON file=
. This is done so that</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+clangd is able to find it.</span><br><span style=3D"color: hsl(120, 100%=
, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Enabling =
this option may cause an error on Windows, since creating a symlink</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+is a privileged operation t=
here. If you enable Developer Mode for the system,</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+symlinks can be created by regular users.</s=
pan><br><span>diff --git a/build/Makefile.am b/build/Makefile.am</span><br>=
<span>deleted file mode 100644</span><br><span>index e7cc4d8..0000000</span=
><br><span>--- a/build/Makefile.am</span><br><span>+++ /dev/null</span><br>=
<span>@@ -1,15 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  OpenVPN -- An ap=
plication to securely tunnel IP networks</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-#             over a single UDP port, with support for S=
SL/TLS-based</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#        =
     session authentication and key exchange,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#             packet encryption, packet authenticat=
ion, and</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#            =
 packet compression.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#  Copyright (C) 2002=
-2023 OpenVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-MAINTAINERCLEANFILES =
=3D \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(srcdir)/Makef=
ile.in</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-EXTRA_DIST =3D \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	ltrc.inc</span><br><span>diff --git a/co=
nfigure.ac b/configure.ac</span><br><span>index 2823f04..0710f71 100644</sp=
an><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><b=
r><span>@@ -1515,7 +1515,6 @@</span><br><span> </span><br><span> AC_CONFIG_=
FILES([</span><br><span> 	Makefile</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	build/Makefile</span><br><span> 	distro/Makefile</span><br><s=
pan> 	distro/systemd/Makefile</span><br><span> 	doc/Makefile</span><br><spa=
n>diff --git a/build/ltrc.inc b/ltrc.inc</span><br><span>similarity index 1=
00%</span><br><span>rename from build/ltrc.inc</span><br><span>rename to lt=
rc.inc</span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/M=
akefile.am</span><br><span>index b953961..1dc1dda 100644</span><br><span>--=
- a/src/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</=
span><br><span>@@ -9,7 +9,7 @@</span><br><span> #  Copyright (C) 2006-2012 =
Alon Bar-Lev &lt;alon.barlev@...277...&gt;</span><br><span> #</span><br><sp=
an> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-include $(top_src=
dir)/build/ltrc.inc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
include $(top_srcdir)/ltrc.inc</span><br><span> </span><br><span> MAINTAINE=
RCLEANFILES =3D \</span><br><span> 	$(srcdir)/Makefile.in</span><br><span>d=
iff --git a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am</sp=
an><br><span>index dc53f75..b10ce82 100644</span><br><span>--- a/src/openvp=
nmsica/Makefile.am</span><br><span>+++ b/src/openvpnmsica/Makefile.am</span=
><br><span>@@ -18,7 +18,7 @@</span><br><span> #  51 Franklin Street, Fifth =
Floor, Boston, MA 02110-1301 USA.</span><br><span> #</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-include $(top_srcdir)/buil=
d/ltrc.inc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+include $=
(top_srcdir)/ltrc.inc</span><br><span> </span><br><span> MAINTAINERCLEANFIL=
ES =3D $(srcdir)/Makefile.in</span><br><span> </span><br><span>diff --git a=
/src/openvpnserv/Makefile.am b/src/openvpnserv/Makefile.am</span><br><span>=
index d8ba4eb..0c64cce 100644</span><br><span>--- a/src/openvpnserv/Makefil=
e.am</span><br><span>+++ b/src/openvpnserv/Makefile.am</span><br><span>@@ -=
9,7 +9,7 @@</span><br><span> #  Copyright (C) 2006-2012 Alon Bar-Lev &lt;al=
on.barlev@...277...&gt;</span><br><span> #</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-include $(top_srcdir)/build/ltrc.inc=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+include $(top_srcdi=
r)/ltrc.inc</span><br><span> </span><br><span> MAINTAINERCLEANFILES =3D $(s=
rcdir)/Makefile.in</span><br><span> </span><br><span>diff --git a/src/tapct=
l/Makefile.am b/src/tapctl/Makefile.am</span><br><span>index 69ea161..4c295=
8b 100644</span><br><span>--- a/src/tapctl/Makefile.am</span><br><span>+++ =
b/src/tapctl/Makefile.am</span><br><span>@@ -18,7 +18,7 @@</span><br><span>=
 #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><=
span> #</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-include $(top_srcdir)/build/ltrc.inc</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+include $(top_srcdir)/ltrc.inc</span><br><span> </span=
><br><span> MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in</span><br><span>=
 </span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerr=
it.openvpn.net/c/openvpn/+/501?usp=3Demail">change 501</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/=
EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.=
org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/=
openvpn/+/501?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"=
/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib1a5c788269949d8de95d1da2cb=
0c32a65bf13f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 501 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
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
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--gVhIYovbJSI=--

