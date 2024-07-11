From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Thu, 11 Jul 2024 10:26:37 +0000
In-Reply-To: <gerrit.1720531952000.I72934e747d1ad68a7e3675afbeb1b63df7941186@...2715...>
References: <gerrit.1720531952000.I72934e747d1ad68a7e3675afbeb1b63df7941186@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <3137c792f24ab402a48f13b168f7ac754ffffcd7-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zScaMOs8nUM="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure: Switch to
 C11 by default
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

--zScaMOs8nUM=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld, plaisthos.

Hello plaisthos,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/673?usp=3Demail

to look at the new patch set (#3).

The following approvals got outdated and were removed:
Code-Review+2 by plaisthos

The change is no longer submittable: Code-Review and checks~ChecksSubmitRul=
e are unsatisfied now.


Change subject: configure: Switch to C11 by default
......................................................................

configure: Switch to C11 by default

Mostly so we can use anonymous structs without jumping through
hoops or relying on unofficial support.

Change-Id: I72934e747d1ad68a7e3675afbeb1b63df7941186
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M Changes.rst
M configure.ac
3 files changed, 9 insertions(+), 3 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/673/3

diff --git a/CMakeLists.txt b/CMakeLists.txt
index 096837d..ad620fa 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -119,7 +119,7 @@
 set(OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})
 set(OPENVPN_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})

-set(CMAKE_C_STANDARD 99)
+set(CMAKE_C_STANDARD 11)

 # Set the various defines for config.h.cmake.in
 if (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
diff --git a/Changes.rst b/Changes.rst
index 439352a..0a26dca 100644
--- a/Changes.rst
+++ b/Changes.rst
@@ -42,6 +42,12 @@
     ``--topology net30`` to the config should fix the problem.
     By default ``--topology`` is pushed from server to client.

+Default C standard to follow was updated to C11.
+    The work-around for compilers that do not support anonymous unions was
+    removed. All currently supported versions of our target platforms shou=
ld
+    have compilers that can handle C11. The platform that got support
+    most recently seems to be OpenBSD (default gcc).
+
 OpenSSL 1.0.2 support
     Support for building with OpenSSL 1.0.2 has been removed. The minimum
     supported OpenSSL version is now 1.1.0.
diff --git a/configure.ac b/configure.ac
index 1f03f90..dcc46e2 100644
--- a/configure.ac
+++ b/configure.ac
@@ -421,10 +421,10 @@
 AC_CHECK_PROGS([RST2HTML], [rst2html rst2html.py])
 AM_CONDITIONAL([HAVE_PYDOCUTILS], [test "${RST2MAN}" -a "${RST2HTML}"])

-# Set -std=3Dc99 unless user already specified a -std=3D
+# Set -std=3Dc11 unless user already specified a -std=3D
 case "${CFLAGS}" in
   *-std=3D*) ;;
-  *)       CFLAGS=3D"${CFLAGS} -std=3Dc99" ;;
+  *)       CFLAGS=3D"${CFLAGS} -std=3Dc11" ;;
 esac

 #

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/673?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I72934e747d1ad68a7e3675afbeb1b63df7941186
Gerrit-Change-Number: 673
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--zScaMOs8nUM=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld, plaisthos. </p>
<p>flichtenheld <strong>uploaded patch set #3</strong> to this change.</p><=
p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/673?usp=3Demail">View Ch=
ange</a></p><p>The following approvals got outdated and were removed:
Code-Review+2 by plaisthos</p><p>The change is no longer submittable: Code-=
Review and checks~ChecksSubmitRule are unsatisfied now.</p><pre style=3D"fo=
nt-family: monospace,monospace; white-space: pre-wrap;">configure: Switch t=
o C11 by default<br><br>Mostly so we can use anonymous structs without jump=
ing through<br>hoops or relying on unofficial support.<br><br>Change-Id: I7=
2934e747d1ad68a7e3675afbeb1b63df7941186<br>Signed-off-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>---<br>M CMakeLists.txt<br>M Changes.rst<br>M =
configure.ac<br>3 files changed, 9 insertions(+), 3 deletions(-)<br><br></p=
re><pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;">=
git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/73/673/3</pre>=
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index 09683=
7d..ad620fa 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -119,7 +119,7 @@</span><br><span> set(=
OPENVPN_VERSION_PATCH ${PRODUCT_VERSION_PATCH})</span><br><span> set(OPENVP=
N_VERSION_RESOURCE ${PRODUCT_VERSION_RESOURCE})</span><br><span> </span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-set(CMAKE_C_STANDARD 99)</span>=
<br><span style=3D"color: hsl(120, 100%, 40%);">+set(CMAKE_C_STANDARD 11)</=
span><br><span> </span><br><span> # Set the various defines for config.h.cm=
ake.in</span><br><span> if (${CMAKE_SYSTEM_NAME} STREQUAL &quot;Linux&quot;=
)</span><br><span>diff --git a/Changes.rst b/Changes.rst</span><br><span>in=
dex 439352a..0a26dca 100644</span><br><span>--- a/Changes.rst</span><br><sp=
an>+++ b/Changes.rst</span><br><span>@@ -42,6 +42,12 @@</span><br><span>   =
  ``--topology net30`` to the config should fix the problem.</span><br><spa=
n>     By default ``--topology`` is pushed from server to client.</span><br=
><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">+Default C s=
tandard to follow was updated to C11.</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+    The work-around for compilers that do not support ano=
nymous unions was</span><br><span style=3D"color: hsl(120, 100%, 40%);">+  =
  removed. All currently supported versions of our target platforms should<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+    have compilers t=
hat can handle C11. The platform that got support</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+    most recently seems to be OpenBSD (defaul=
t gcc).</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><=
span> OpenSSL 1.0.2 support</span><br><span>     Support for building with =
OpenSSL 1.0.2 has been removed. The minimum</span><br><span>     supported =
OpenSSL version is now 1.1.0.</span><br><span>diff --git a/configure.ac b/c=
onfigure.ac</span><br><span>index 1f03f90..dcc46e2 100644</span><br><span>-=
-- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -42=
1,10 +421,10 @@</span><br><span> AC_CHECK_PROGS([RST2HTML], [rst2html rst2h=
tml.py])</span><br><span> AM_CONDITIONAL([HAVE_PYDOCUTILS], [test &quot;${R=
ST2MAN}&quot; -a &quot;${RST2HTML}&quot;])</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-# Set -std=3Dc99 unless user already=
 specified a -std=3D</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+# Set -std=3Dc11 unless user already specified a -std=3D</span><br><span> =
case &quot;${CFLAGS}&quot; in</span><br><span>   *-std=3D*) ;;</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-  *)       CFLAGS=3D&quot;${CFLAGS=
} -std=3Dc99&quot; ;;</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+  *)       CFLAGS=3D&quot;${CFLAGS} -std=3Dc11&quot; ;;</span><br><span> =
esac</span><br><span> </span><br><span> #</span><br><span></span><br></pre>=
<p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/673?usp=
=3Demail">change 673</a>. To unsubscribe, or for help writing mail filters,=
 visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div=
 itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemp=
rop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"=
url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/673?usp=3Demail"/><meta =
itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I72934e747d1ad68a7e3675afbeb=
1b63df7941186 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 673 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--zScaMOs8nUM=--

