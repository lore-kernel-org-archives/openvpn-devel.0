From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Tue, 19 Sep 2023 11:44:25 +0000
References: <gerrit.1695123863000.I4e16767ee221e1aefdd18d13b3411c27d8dd844a@...2715...>
Reply-To: frank@...2641..., openvpn-devel@lists.sourceforge.net
Message-ID: <a3c5d86e21f727f12ba52cea6a26144cf0b0491e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="oyTKIAjy4PE="; charset=UTF-8
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
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--oyTKIAjy4PE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

flichtenheld has uploaded this change for review. ( http://gerrit.openvpn.n=
et/c/openvpn/+/342?usp=3Demail )


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
---
M CMakeLists.txt
M README.cmake.md
M contrib/cmake/git-version.py
M contrib/cmake/parse-version.m4.py
M tests/unit_tests/openvpn/Makefile.am
5 files changed, 17 insertions(+), 3 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/342/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 7dae665..da5f883 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -291,7 +291,7 @@

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
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: newchange

--oyTKIAjy4PE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>flichtenheld has uploaded this change for <strong>review</strong>.</p><p=
><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/342?usp=3Demail">View Cha=
nge</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;">CMake: various small non-functional improvements<br><br>These are b=
ased on review comments for the 2.6 backport.<br>But since they apply to th=
e original master implementation<br>as well, I address them in this separat=
e patch.<br><br>- Add documentation to contrib/cmake/*.py<br>- Fix grammar =
in README.cmake.md<br>- Update a TODO in CMakeLists.txt to better reflect<b=
r>  the status quo<br>- Fix indentation in unit_tests&#39; Makefile.am<br><=
br>Change-Id: I4e16767ee221e1aefdd18d13b3411c27d8dd844a<br>Signed-off-by: F=
rank Lichtenheld &lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M R=
EADME.cmake.md<br>M contrib/cmake/git-version.py<br>M contrib/cmake/parse-v=
ersion.m4.py<br>M tests/unit_tests/openvpn/Makefile.am<br>5 files changed, =
17 insertions(+), 3 deletions(-)<br><br></pre><pre style=3D"font-family: mo=
nospace,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.ne=
t:29418/openvpn refs/changes/42/342/1</pre><pre style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b=
/CMakeLists.txt</span><br><span>index 7dae665..da5f883 100644</span><br><sp=
an>--- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><spa=
n>@@ -291,7 +291,7 @@</span><br><span> </span><br><span> configure_file(con=
fig.h.cmake.in config.h)</span><br><span> configure_file(include/openvpn-pl=
ugin.h.in openvpn-plugin.h)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-# TODO remove later when msvc-config.h is removed and we can always i=
nclude config.h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# TO=
DO we should remove the need for this, and always include config.h</span><b=
r><span> add_definitions(-DHAVE_CONFIG_H)</span><br><span> </span><br><span=
> include_directories(${CMAKE_CURRENT_BINARY_DIR})</span><br><span>diff --g=
it a/README.cmake.md b/README.cmake.md</span><br><span>index 599d8dc..d181b=
64 100644</span><br><span>--- a/README.cmake.md</span><br><span>+++ b/READM=
E.cmake.md</span><br><span>@@ -24,7 +24,7 @@</span><br><span> -----------</=
span><br><span> </span><br><span> The following tools are expected to be pr=
esent on the system, you</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-can them install with a package manager of your choice (e.g.</span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+can install them with a package=
 manager of your choice (e.g.</span><br><span> chocolatey, winget) or manua=
lly:</span><br><span> </span><br><span> * CMake</span><br><span>diff --git =
a/contrib/cmake/git-version.py b/contrib/cmake/git-version.py</span><br><sp=
an>index c2b4452..4f78ac4 100644</span><br><span>--- a/contrib/cmake/git-ve=
rsion.py</span><br><span>+++ b/contrib/cmake/git-version.py</span><br><span=
>@@ -22,6 +22,14 @@</span><br><span> #  51 Franklin Street, Fifth Floor, Bo=
ston, MA 02110-1301 USA.</span><br><span> #</span><br><span> </span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+# Usage: ./git-version.py [direct=
ory]</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# Find a good t=
extual representation of the git commit currently checked out.</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+# Make that representation avail=
able as CONFIGURE_GIT_REVISION in</span><br><span style=3D"color: hsl(120, =
100%, 40%);">+# &lt;directory&gt;/config-version.h.</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+# It will prefer a tag name if it is chec=
ked out exactly, otherwise will use</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+# the branch name. &#39;none&#39; if no branch is checked o=
ut (detached HEAD).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# This is used to enhance the output of openvpn --version with Git informat=
ion.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><spa=
n> import os</span><br><span> import sys</span><br><span> import subprocess=
</span><br><span>diff --git a/contrib/cmake/parse-version.m4.py b/contrib/c=
make/parse-version.m4.py</span><br><span>index d5ff2bd..3dfb31f 100644</spa=
n><br><span>--- a/contrib/cmake/parse-version.m4.py</span><br><span>+++ b/c=
ontrib/cmake/parse-version.m4.py</span><br><span>@@ -22,6 +22,12 @@</span><=
br><span> #  51 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</s=
pan><br><span> #</span><br><span> </span><br><span style=3D"color: hsl(120,=
 100%, 40%);">+# Usage: ./parse-version.m4.py m4file [directory]</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+# Read &lt;m4file&gt;, extract=
 all lines looking like M4 define(), and translate</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# them into CMake style set(). Those are the=
n written out to file</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+# &lt;directory&gt;/version.cmake.</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+# Intended to be used on top-level version.m4 file.</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> import o=
s</span><br><span> import re</span><br><span> import sys</span><br><span>di=
ff --git a/tests/unit_tests/openvpn/Makefile.am b/tests/unit_tests/openvpn/=
Makefile.am</span><br><span>index 6b56f84..ef45b11 100644</span><br><span>-=
-- a/tests/unit_tests/openvpn/Makefile.am</span><br><span>+++ b/tests/unit_=
tests/openvpn/Makefile.am</span><br><span>@@ -110,7 +110,7 @@</span><br><sp=
an> 	-Wl,--wrap=3Dparse_line \</span><br><span> 	-Wl,--wrap=3Drand_bytes</s=
pan><br><span> tls_crypt_testdriver_SOURCES =3D test_tls_crypt.c mock_msg.c=
 mock_msg.h \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    mock=
_win32_execve.c \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	m=
ock_win32_execve.c \</span><br><span> 	$(top_srcdir)/src/openvpn/argv.c \</=
span><br><span> 	$(top_srcdir)/src/openvpn/base64.c \</span><br><span> 	$(t=
op_srcdir)/src/openvpn/buffer.c \</span><br><span></span><br></pre><p>To vi=
ew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/342?usp=3Demail"=
>change 342</a>. To unsubscribe, or for help writing mail filters, visit <a=
 href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemscop=
e itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"ac=
tion" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=
=3D"http://gerrit.openvpn.net/c/openvpn/+/342?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I4e16767ee221e1aefdd18d13b34=
11c27d8dd844a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 342 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--oyTKIAjy4PE=--

