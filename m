From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 21 Sep 2023 20:45:17 +0000
In-Reply-To: <gerrit.1695123863000.I4e16767ee221e1aefdd18d13b3411c27d8dd844a@...2715...>
References: <gerrit.1695123863000.I4e16767ee221e1aefdd18d13b3411c27d8dd844a@...2715...>
Reply-To: heiko@...515..., openvpn-devel@lists.sourceforge.net,
 frank@...2641..., lstipakov@...277...
Message-ID: <23d936e1b4864f16602ecd0038ef3da4555b5c86-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="FKfGd66cmfg="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, d12fk <heiko@...515...>, stipa <lstipakov@...277...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--FKfGd66cmfg=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#2) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/342?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by stipa


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


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/342/2

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
Gerrit-MessageType: newpatchset

--FKfGd66cmfg=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>uploaded patch set #2</strong> to the change originally cr=
eated by flichtenheld.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn=
/+/342?usp=3Demail">View Change</a></p><p>The following approvals got outda=
ted and were removed:
Code-Review+2 by stipa</p><pre style=3D"font-family: monospace,monospace; w=
hite-space: pre-wrap;">CMake: various small non-functional improvements<br>=
<br>These are based on review comments for the 2.6 backport.<br>But since t=
hey apply to the original master implementation<br>as well, I address them =
in this separate patch.<br><br>- Add documentation to contrib/cmake/*.py<br=
>- Fix grammar in README.cmake.md<br>- Update a TODO in CMakeLists.txt to b=
etter reflect<br>  the status quo<br>- Fix indentation in unit_tests&#39; M=
akefile.am<br><br>Change-Id: I4e16767ee221e1aefdd18d13b3411c27d8dd844a<br>S=
igned-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>Acked-by: Lev S=
tipakov &lt;lstipakov@...277...&gt;<br>Gerrit URL: https://gerrit.openvpn.n=
et/c/openvpn/+/342<br>Message-Id: &lt;20230919155635.708557-1-frank@...2746...=
...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@...1483...=
e.net/msg27043.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<=
br>---<br>M CMakeLists.txt<br>M README.cmake.md<br>M contrib/cmake/git-vers=
ion.py<br>M contrib/cmake/parse-version.m4.py<br>M tests/unit_tests/openvpn=
/Makefile.am<br>5 files changed, 17 insertions(+), 3 deletions(-)<br><br></=
pre><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"=
>git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/42/342/2</pre=
><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><s=
pan>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 9de6=
aba..454ef62 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>++=
+ b/CMakeLists.txt</span><br><span>@@ -292,7 +292,7 @@</span><br><span> </s=
pan><br><span> configure_file(config.h.cmake.in config.h)</span><br><span> =
configure_file(include/openvpn-plugin.h.in openvpn-plugin.h)</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# TODO remove later when msvc-config=
.h is removed and we can always include config.h</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+# TODO we should remove the need for this, and=
 always include config.h</span><br><span> add_definitions(-DHAVE_CONFIG_H)<=
/span><br><span> </span><br><span> include_directories(${CMAKE_CURRENT_BINA=
RY_DIR})</span><br><span>diff --git a/README.cmake.md b/README.cmake.md</sp=
an><br><span>index 599d8dc..d181b64 100644</span><br><span>--- a/README.cma=
ke.md</span><br><span>+++ b/README.cmake.md</span><br><span>@@ -24,7 +24,7 =
@@</span><br><span> -----------</span><br><span> </span><br><span> The foll=
owing tools are expected to be present on the system, you</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-can them install with a package manager=
 of your choice (e.g.</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+can install them with a package manager of your choice (e.g.</span><br><s=
pan> chocolatey, winget) or manually:</span><br><span> </span><br><span> * =
CMake</span><br><span>diff --git a/contrib/cmake/git-version.py b/contrib/c=
make/git-version.py</span><br><span>index c2b4452..4f78ac4 100644</span><br=
><span>--- a/contrib/cmake/git-version.py</span><br><span>+++ b/contrib/cma=
ke/git-version.py</span><br><span>@@ -22,6 +22,14 @@</span><br><span> #  51=
 Franklin Street, Fifth Floor, Boston, MA 02110-1301 USA.</span><br><span> =
#</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
# Usage: ./git-version.py [directory]</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+# Find a good textual representation of the git commit cu=
rrently checked out.</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# Make that representation available as CONFIGURE_GIT_REVISION in</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# &lt;directory&gt;/config-v=
ersion.h.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# It will =
prefer a tag name if it is checked out exactly, otherwise will use</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+# the branch name. &#39;none=
&#39; if no branch is checked out (detached HEAD).</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+# This is used to enhance the output of open=
vpn --version with Git information.</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+</span><br><span> import os</span><br><span> import sys</sp=
an><br><span> import subprocess</span><br><span>diff --git a/contrib/cmake/=
parse-version.m4.py b/contrib/cmake/parse-version.m4.py</span><br><span>ind=
ex d5ff2bd..3dfb31f 100644</span><br><span>--- a/contrib/cmake/parse-versio=
n.m4.py</span><br><span>+++ b/contrib/cmake/parse-version.m4.py</span><br><=
span>@@ -22,6 +22,12 @@</span><br><span> #  51 Franklin Street, Fifth Floor=
, Boston, MA 02110-1301 USA.</span><br><span> #</span><br><span> </span><br=
><span style=3D"color: hsl(120, 100%, 40%);">+# Usage: ./parse-version.m4.p=
y m4file [directory]</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# Read &lt;m4file&gt;, extract all lines looking like M4 define(), and tra=
nslate</span><br><span style=3D"color: hsl(120, 100%, 40%);">+# them into C=
Make style set(). Those are then written out to file</span><br><span style=
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
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--FKfGd66cmfg=--

