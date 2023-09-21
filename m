From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 21 Sep 2023 20:45:20 +0000
In-Reply-To: <gerrit.1695123863000.I4e16767ee221e1aefdd18d13b3411c27d8dd844a@...2715...>
References: <gerrit.1695123863000.I4e16767ee221e1aefdd18d13b3411c27d8dd844a@...2715...>
Reply-To: heiko@...515..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <23d936e1b4864f16602ecd0038ef3da4555b5c86-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="S/Za2ermEpE="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: CMake: various small
 non-functional improvements
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: flichtenheld <frank@...2641...>
Cc: stipa <lstipakov@...277...>, d12fk <heiko@...515...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--S/Za2ermEpE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/34=
2?usp=3Demail )

Change subject: CMake: various small non-functional improvements
......................................................................

CMake: various small non-functional improvements

These are based on review comments for the 2.6 backport.
But since they apply to the original master implementation
as well, I address them in this separate patch.

- Add documentation to contrib/cmake/*.py
- Fix grammar in README.cmake.md
- Update a TODO in CMakeLists.txt to better reflect
  the status quo
- Fix indentation in unit_tests' Makefile.am

Change-Id: I4e16767ee221e1aefdd18d13b3411c27d8dd844a
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Lev Stipakov <lstipakov@...277...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/342
Message-Id: <20230919155635.708557-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
043.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M README.cmake.md
M contrib/cmake/git-version.py
M contrib/cmake/parse-version.m4.py
M tests/unit_tests/openvpn/Makefile.am
5 files changed, 17 insertions(+), 3 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index 9de6aba..454ef62 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -292,7 +292,7 @@

 configure_file(config.h.cmake.in config.h)
 configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)
-# TODO remove later when msvc-config.h is removed and we can always includ=
e config.h
+# TODO we should remove the need for this, and always include config.h
 add_definitions(-DHAVE_CONFIG_H)

 include_directories(${CMAKE_CURRENT_BINARY_DIR})
diff --git a/README.cmake.md b/README.cmake.md
index 599d8dc..d181b64 100644
--- a/README.cmake.md
+++ b/README.cmake.md
@@ -24,7 +24,7 @@
 -----------

 The following tools are expected to be present on the system, you
-can them install with a package manager of your choice (e.g.
+can install them with a package manager of your choice (e.g.
 chocolatey, winget) or manually:

 * CMake
diff --git a/contrib/cmake/git-version.py b/contrib/cmake/git-version.py
index c2b4452..4f78ac4 100644
--- a/contrib/cmake/git-version.py
+++ b/contrib/cmake/git-version.py
@@ -22,6 +22,14 @@
 #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #

+# Usage: ./git-version.py [directory]
+# Find a good textual representation of the git commit currently checked o=
ut.
+# Make that representation available as CONFIGURE_GIT_REVISION in
+# <directory>/config-version.h.
+# It will prefer a tag name if it is checked out exactly, otherwise will u=
se
+# the branch name. 'none' if no branch is checked out (detached HEAD).
+# This is used to enhance the output of openvpn --version with Git informa=
tion.
+
 import os
 import sys
 import subprocess
diff --git a/contrib/cmake/parse-version.m4.py b/contrib/cmake/parse-versio=
n.m4.py
index d5ff2bd..3dfb31f 100644
--- a/contrib/cmake/parse-version.m4.py
+++ b/contrib/cmake/parse-version.m4.py
@@ -22,6 +22,12 @@
 #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.
 #

+# Usage: ./parse-version.m4.py m4file [directory]
+# Read <m4file>, extract all lines looking like M4 define(), and translate
+# them into CMake style set(). Those are then written out to file
+# <directory>/version.cmake.
+# Intended to be used on top-level version.m4 file.
+
 import os
 import re
 import sys
diff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvp=
n/Makefile.am
index 6b56f84..ef45b11 100644
--- a/tests/unit_tests/openvpn/Makefile.am
+++ b/tests/unit_tests/openvpn/Makefile.am
@@ -110,7 +110,7 @@
 	-Wl,--wrap=3Dparse_line \
 	-Wl,--wrap=3Drand_bytes
 tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c mock_msg.h \
-    mock_win32_execve.c \
+	mock_win32_execve.c \
 	$(top_srcdir)/src/openvpn/argv.c \
 	$(top_srcdir)/src/openvpn/base64.c \
 	$(top_srcdir)/src/openvpn/buffer.c \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/342?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I4e16767ee221e1aefdd18d13b3411c27d8dd844a
Gerrit-Change-Number: 342
Gerrit-PatchSet: 2
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: d12fk <heiko@...515...>
Gerrit-Reviewer: stipa <lstipakov@...277...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--S/Za2ermEpE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/342?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">CMake: various small non-functional improvemen=
ts<br><br>These are based on review comments for the 2.6 backport.<br>But s=
ince they apply to the original master implementation<br>as well, I address=
 them in this separate patch.<br><br>- Add documentation to contrib/cmake/*=
.py<br>- Fix grammar in README.cmake.md<br>- Update a TODO in CMakeLists.tx=
t to better reflect<br>  the status quo<br>- Fix indentation in unit_tests&=
#39; Makefile.am<br><br>Change-Id: I4e16767ee221e1aefdd18d13b3411c27d8dd844=
a<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by:=
 Lev Stipakov &lt;lstipakov@...277...&gt;<br>Gerrit URL: https://gerrit.ope=
nvpn.net/c/openvpn/+/342<br>Message-Id: &lt;20230919155635.708557-1-frank@...220...=
..2641...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1439...=
ceforge.net/msg27043.html<br>Signed-off-by: Gert Doering &lt;gert@...2132...=
.&gt;<br>---<br>M CMakeLists.txt<br>M README.cmake.md<br>M contrib/cmake/gi=
t-version.py<br>M contrib/cmake/parse-version.m4.py<br>M tests/unit_tests/o=
penvpn/Makefile.am<br>5 files changed, 17 insertions(+), 3 deletions(-)<br>=
<br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 9de6a=
ba..454ef62 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -292,7 +292,7 @@</span><br><span> </sp=
an><br><span> configure_file(config.h.cmake.in config.h)</span><br><span> c=
onfigure_file(include/openvpn-plugin.h.in openvpn-plugin.h)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-# TODO remove later when msvc-config.=
h is removed and we can always include config.h</span><br><span style=3D"co=
lor: hsl(120, 100%, 40%);">+# TODO we should remove the need for this, and =
always include config.h</span><br><span> add_definitions(-DHAVE_CONFIG_H)</=
span><br><span> </span><br><span> include_directories(${CMAKE_CURRENT_BINAR=
Y_DIR})</span><br><span>diff --git a/README.cmake.md b/README.cmake.md</spa=
n><br><span>index 599d8dc..d181b64 100644</span><br><span>--- a/README.cmak=
e.md</span><br><span>+++ b/README.cmake.md</span><br><span>@@ -24,7 +24,7 @=
@</span><br><span> -----------</span><br><span> </span><br><span> The follo=
wing tools are expected to be present on the system, you</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-can them install with a package manager =
of your choice (e.g.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+can install them with a package manager of your choice (e.g.</span><br><sp=
an> chocolatey, winget) or manually:</span><br><span> </span><br><span> * C=
Make</span><br><span>diff --git a/contrib/cmake/git-version.py b/contrib/cm=
ake/git-version.py</span><br><span>index c2b4452..4f78ac4 100644</span><br>=
<span>--- a/contrib/cmake/git-version.py</span><br><span>+++ b/contrib/cmak=
e/git-version.py</span><br><span>@@ -22,6 +22,14 @@</span><br><span> #  51 =
Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span> #=
</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
 Usage: ./git-version.py [directory]</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# Find a good textual representation of the git commit cur=
rently checked out.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# Make that representation available as CONFIGURE_GIT_REVISION in</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# &lt;directory&gt;/config-ve=
rsion.h.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# It will p=
refer a tag name if it is checked out exactly, otherwise will use</span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# the branch name. &#39;none&=
#39; if no branch is checked out (detached HEAD).</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+# This is used to enhance the output of openv=
pn --version with Git information.</span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+</span><br><span> import os</span><br><span> import sys</spa=
n><br><span> import subprocess</span><br><span>diff --git a/contrib/cmake/p=
arse-version.m4.py b/contrib/cmake/parse-version.m4.py</span><br><span>inde=
x d5ff2bd..3dfb31f 100644</span><br><span>--- a/contrib/cmake/parse-version=
.m4.py</span><br><span>+++ b/contrib/cmake/parse-version.m4.py</span><br><s=
pan>@@ -22,6 +22,12 @@</span><br><span> #  51 Franklin Street, Fifth Floor,=
 Boston, MA 02110-1301 USA.</span><br><span> #</span><br><span> </span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# Usage: ./parse-version.m4.py=
 m4file [directory]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# Read &lt;m4file&gt;, extract all lines looking like M4 define(), and tran=
slate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# them into CM=
ake style set(). Those are then written out to file</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# &lt;directory&gt;/version.cmake.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+# Intended to be used on t=
op-level version.m4 file.</span><br><span style=3D"color: hsl(120, 100%, 40=
%);">+</span><br><span> import os</span><br><span> import re</span><br><spa=
n> import sys</span><br><span>diff --git a/tests/unit_tests/openvpn/Makefil=
e.am b/tests/unit_tests/openvpn/Makefile.am</span><br><span>index 6b56f84..=
ef45b11 100644</span><br><span>--- a/tests/unit_tests/openvpn/Makefile.am</=
span><br><span>+++ b/tests/unit_tests/openvpn/Makefile.am</span><br><span>@=
@ -110,7 +110,7 @@</span><br><span> 	-Wl,--wrap=3Dparse_line \</span><br><s=
pan> 	-Wl,--wrap=3Drand_bytes</span><br><span> tls_crypt_testdriver_SOURCES=
 =3D test_tls_crypt.c mock_msg.c mock_msg.h \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-    mock_win32_execve.c \</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	mock_win32_execve.c \</span><br><span> 	$(to=
p_srcdir)/src/openvpn/argv.c \</span><br><span> 	$(top_srcdir)/src/openvpn/=
base64.c \</span><br><span> 	$(top_srcdir)/src/openvpn/buffer.c \</span><br=
><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.=
net/c/openvpn/+/342?usp=3Demail">change 342</a>. To unsubscribe, or for hel=
p writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings=
">settings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessag=
e"><div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAct=
ion"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/3=
42?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></d=
iv>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4e16767ee221e1aefdd18d13b34=
11c27d8dd844a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 342 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: d12fk &lt;heiko@...515...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: stipa &lt;lstipakov@...277...=
&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--S/Za2ermEpE=--

