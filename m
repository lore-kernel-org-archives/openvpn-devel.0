From: "cron2 (Code Review)" <gerrit@...515...>
Date: Wed, 17 Jan 2024 14:02:45 +0000
In-Reply-To: <gerrit.1705463396000.Ib1a5c788269949d8de95d1da2cb0c32a65bf13f2@...2715...>
References: <gerrit.1705463396000.Ib1a5c788269949d8de95d1da2cb0c32a65bf13f2@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227..., heiko@...515...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...,
 lstipakov@...277...
Message-ID: <1e73ec5867b36565edac68efff68a77b346beb20-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="TUIyYMsThwY="; charset=UTF-8
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
To: d12fk <heiko@...515...>, plaisthos <arne-openvpn@...1227...>, flichtenheld <frank@...2641...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--TUIyYMsThwY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 d12fk. ( http://gerrit.openvpn.net/c/openvpn/+/501?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+1 by stipa, Code-Review+2 by cron2


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
Acked-by: Gert Doering <gert@...1296...>
Message-Id: <20240117134929.5317-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg28=
061.html
Signed-off-by: Gert Doering <gert@...1296...>
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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/01/501/2

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
index 6a1895a..5e07d50 100644
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
index 3ad9f14..14f5be4 100644
--- a/configure.ac
+++ b/configure.ac
@@ -1536,7 +1536,6 @@

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
Gerrit-PatchSet: 2
Gerrit-Owner: d12fk <heiko@...515...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newpatchset

--TUIyYMsThwY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by d12fk.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/501?=
usp=3Demail">View Change</a></p><p>The following approvals got outdated and=
 were removed:
Code-Review+1 by stipa, Code-Review+2 by cron2</p><pre style=3D"font-family=
: monospace,monospace; white-space: pre-wrap;">cmake: symlink whole build d=
ir not just .json file<br><br>It turned out that symlinking compile_command=
s.json from the top level<br>source dir has some issues:<br>  * file is not=
 created on Windows and symlinking may cause an error<br>  * some IDEs crea=
te their own json and error out b/c a file exists<br><br>Since clangd also =
looks for the json in build/ directories by default,<br>we now symlink the =
whole build directory instead, not just the json file.<br><br>This approach=
 requires for the existing build/ dir in the repo to<br>vanish. Luckily it =
only contains one automake include file, which is<br>moved to the top level=
 source dir.<br><br>Lastly, make this an opt-in feature, so that the defaul=
t configuration<br>of the buildsystem never causes a build failure because =
of this.<br><br>Change-Id: Ib1a5c788269949d8de95d1da2cb0c32a65bf13f2<br>Sig=
ned-off-by: Heiko Hund &lt;heiko@...2662...&gt;<br>Acked-by: Gert Doering &=
lt;gert@...1296...&gt;<br>Message-Id: &lt;20240117134929.5317-1-gert@...1826...=
6...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1768...=
ge.net/msg28061.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;=
<br>---<br>M .gitignore<br>M CMakeLists.txt<br>M Makefile.am<br>M README.cm=
ake.md<br>D build/Makefile.am<br>M configure.ac<br>R ltrc.inc<br>M src/open=
vpn/Makefile.am<br>M src/openvpnmsica/Makefile.am<br>M src/openvpnserv/Make=
file.am<br>M src/tapctl/Makefile.am<br>11 files changed, 32 insertions(+), =
25 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospace=
; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn r=
efs/changes/01/501/2</pre><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;"><span>diff --git a/.gitignore b/.gitignore</span><br=
><span>index 4153a3e..92d65bf 100644</span><br><span>--- a/.gitignore</span=
><br><span>+++ b/.gitignore</span><br><span>@@ -40,7 +40,7 @@</span><br><sp=
an> m4/ltversion.m4</span><br><span> m4/lt~obsolete.m4</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-compile_commands.json</s=
pan><br><span style=3D"color: hsl(120, 100%, 40%);">+build</span><br><span>=
 doc/openvpn-examples.5</span><br><span> doc/openvpn-examples.5.html</span>=
<br><span> doc/openvpn.8</span><br><span>diff --git a/CMakeLists.txt b/CMak=
eLists.txt</span><br><span>index 6a1895a..5e07d50 100644</span><br><span>--=
- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ =
-43,9 +43,17 @@</span><br><span> set(PLUGIN_DIR /usr/local/lib/openvpn/plug=
ins CACHE FILEPATH &quot;Location of the plugin directory&quot;)</span><br>=
<span> </span><br><span> # Create machine readable compile commands</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-set(CMAKE_EXPORT_COMPILE_COMM=
ANDS 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-file(CREATE_LI=
NK ${CMAKE_CURRENT_BINARY_DIR}/compile_commands.json</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                 ${CMAKE_CURRENT_SOURCE_DIR=
}/compile_commands.json SYMBOLIC)</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+option(ENABLE_COMPILE_COMMANDS &quot;Generate compile_command=
s.json and a symlink for clangd to find it&quot; OFF)</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+if (ENABLE_COMPILE_COMMANDS)</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+    if (EXISTS ${CMAKE_CURRENT_S=
OURCE_DIR}/build AND NOT IS_SYMLINK ${CMAKE_CURRENT_SOURCE_DIR}/build)</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+        message(FATAL_ER=
ROR &quot;The top level source directory contains a &#39;build&#39; file or=
 directory. Please remove or rename it. CMake creates a symlink with that n=
ame during build.&quot;)</span><br><span style=3D"color: hsl(120, 100%, 40%=
);">+    endif()</span><br><span style=3D"color: hsl(120, 100%, 40%);">+   =
 set(CMAKE_EXPORT_COMPILE_COMMANDS 1)</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    add_custom_target(</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+        symlink-build-dir ALL</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+        ${CMAKE_COMMAND} -E create_symlink $=
{CMAKE_CURRENT_BINARY_DIR} ${CMAKE_CURRENT_SOURCE_DIR}/build</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+        )</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+endif ()</span><br><span> </span><br><span> =
# AddressSanitize - use CXX=3Dclang++ CC=3Dclang cmake -DCMAKE_BUILD_TYPE=
=3Dasan to build with ASAN</span><br><span> set(CMAKE_C_FLAGS_ASAN</span><b=
r><span>diff --git a/Makefile.am b/Makefile.am</span><br><span>index 2305ab=
4..792588a 100644</span><br><span>--- a/Makefile.am</span><br><span>+++ b/M=
akefile.am</span><br><span>@@ -42,6 +42,7 @@</span><br><span> EXTRA_DIST =
=3D \</span><br><span> 	contrib \</span><br><span> 	debug \</span><br><span=
 style=3D"color: hsl(120, 100%, 40%);">+	ltrc.inc \</span><br><span> 	CMake=
Lists.txt \</span><br><span> 	CMakePresets.json \</span><br><span> 	config.=
h.cmake.in</span><br><span>@@ -53,7 +54,7 @@</span><br><span> 	config-versi=
on.h</span><br><span> endif</span><br><span> </span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-SUBDIRS =3D build distro include src sample doc tes=
ts</span><br><span style=3D"color: hsl(120, 100%, 40%);">+SUBDIRS =3D distr=
o include src sample doc tests</span><br><span> </span><br><span> dist_doc_=
DATA =3D \</span><br><span> 	README \</span><br><span>diff --git a/README.c=
make.md b/README.cmake.md</span><br><span>index d181b64..4f41c70 100644</sp=
an><br><span>--- a/README.cmake.md</span><br><span>+++ b/README.cmake.md</s=
pan><br><span>@@ -135,3 +135,17 @@</span><br><span> The `unix-native` CMake=
 preset is available for these builds. This preset does</span><br><span> no=
t require VCPKG and instead assumes all build-dependencies are provided by<=
/span><br><span> the system natively.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+G=
enerating compile_commands.json</span><br><span style=3D"color: hsl(120, 10=
0%, 40%);">+--------------------------------</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+To have the CMake buildsystem generate compile_commands.json you can =
specify</span><br><span style=3D"color: hsl(120, 100%, 40%);">+`-DENABLE_CO=
MPILE_COMMANDS=3DON` on the command line or enable the CMake option</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+another way you like. For s=
upported generators the file will then be created.</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+Additionally, the buildsystem will create a =
symlink `build/` to the --preset</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+build directory that contains the generated JSON file. This is=
 done so that</span><br><span style=3D"color: hsl(120, 100%, 40%);">+clangd=
 is able to find it.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+</span><br><span style=3D"color: hsl(120, 100%, 40%);">+Enabling this opti=
on may cause an error on Windows, since creating a symlink</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+is a privileged operation there. If =
you enable Developer Mode for the system,</span><br><span style=3D"color: h=
sl(120, 100%, 40%);">+symlinks can be created by regular users.</span><br><=
span>diff --git a/build/Makefile.am b/build/Makefile.am</span><br><span>del=
eted file mode 100644</span><br><span>index e7cc4d8..0000000</span><br><spa=
n>--- a/build/Makefile.am</span><br><span>+++ /dev/null</span><br><span>@@ =
-1,15 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#  OpenVPN -- An application=
 to securely tunnel IP networks</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#             over a single UDP port, with support for SSL/TLS-ba=
sed</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#             sess=
ion authentication and key exchange,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#             packet encryption, packet authentication, and<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#             packet c=
ompression.</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#  Copyright (C) 2002-2023 Ope=
nVPN Inc &lt;sales@...515...&gt;</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-MAINTAINERCLEANFILES =3D \</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	$(srcdir)/Makefile.in</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-EXTRA_DIST =3D \</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	ltrc.inc</span><br><span>diff --git a/configure=
.ac b/configure.ac</span><br><span>index 3ad9f14..14f5be4 100644</span><br>=
<span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span=
>@@ -1536,7 +1536,6 @@</span><br><span> </span><br><span> AC_CONFIG_FILES([=
</span><br><span> 	Makefile</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	build/Makefile</span><br><span> 	distro/Makefile</span><br><span> 	d=
istro/systemd/Makefile</span><br><span> 	doc/Makefile</span><br><span>diff =
--git a/build/ltrc.inc b/ltrc.inc</span><br><span>similarity index 100%</sp=
an><br><span>rename from build/ltrc.inc</span><br><span>rename to ltrc.inc<=
/span><br><span>diff --git a/src/openvpn/Makefile.am b/src/openvpn/Makefile=
.am</span><br><span>index b953961..1dc1dda 100644</span><br><span>--- a/src=
/openvpn/Makefile.am</span><br><span>+++ b/src/openvpn/Makefile.am</span><b=
r><span>@@ -9,7 +9,7 @@</span><br><span> #  Copyright (C) 2006-2012 Alon Ba=
r-Lev &lt;alon.barlev@...277...&gt;</span><br><span> #</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-include $(top_srcdir)/bu=
ild/ltrc.inc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+include=
 $(top_srcdir)/ltrc.inc</span><br><span> </span><br><span> MAINTAINERCLEANF=
ILES =3D \</span><br><span> 	$(srcdir)/Makefile.in</span><br><span>diff --g=
it a/src/openvpnmsica/Makefile.am b/src/openvpnmsica/Makefile.am</span><br>=
<span>index dc53f75..b10ce82 100644</span><br><span>--- a/src/openvpnmsica/=
Makefile.am</span><br><span>+++ b/src/openvpnmsica/Makefile.am</span><br><s=
pan>@@ -18,7 +18,7 @@</span><br><span> #  51 Franklin Street, Fifth Floor, =
Boston, MA 02110-1301 USA.</span><br><span> #</span><br><span> </span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-include $(top_srcdir)/build/ltrc.=
inc</span><br><span style=3D"color: hsl(120, 100%, 40%);">+include $(top_sr=
cdir)/ltrc.inc</span><br><span> </span><br><span> MAINTAINERCLEANFILES =3D =
$(srcdir)/Makefile.in</span><br><span> </span><br><span>diff --git a/src/op=
envpnserv/Makefile.am b/src/openvpnserv/Makefile.am</span><br><span>index d=
8ba4eb..0c64cce 100644</span><br><span>--- a/src/openvpnserv/Makefile.am</s=
pan><br><span>+++ b/src/openvpnserv/Makefile.am</span><br><span>@@ -9,7 +9,=
7 @@</span><br><span> #  Copyright (C) 2006-2012 Alon Bar-Lev &lt;alon.barl=
ev@...277...&gt;</span><br><span> #</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-include $(top_srcdir)/build/ltrc.inc</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+include $(top_srcdir)/ltrc=
.inc</span><br><span> </span><br><span> MAINTAINERCLEANFILES =3D $(srcdir)/=
Makefile.in</span><br><span> </span><br><span>diff --git a/src/tapctl/Makef=
ile.am b/src/tapctl/Makefile.am</span><br><span>index 69ea161..4c2958b 1006=
44</span><br><span>--- a/src/tapctl/Makefile.am</span><br><span>+++ b/src/t=
apctl/Makefile.am</span><br><span>@@ -18,7 +18,7 @@</span><br><span> #  51 =
Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span> #=
</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-inc=
lude $(top_srcdir)/build/ltrc.inc</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+include $(top_srcdir)/ltrc.inc</span><br><span> </span><br><s=
pan> MAINTAINERCLEANFILES =3D $(srcdir)/Makefile.in</span><br><span> </span=
><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.open=
vpn.net/c/openvpn/+/501?usp=3Demail">change 501</a>. To unsubscribe, or for=
 help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/sett=
ings">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMe=
ssage"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/Vie=
wAction"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/501?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div=
></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ib1a5c788269949d8de95d1da2cb=
0c32a65bf13f2 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 501 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: d12fk &lt;heiko@...515...&gt; </=
div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--TUIyYMsThwY=--

