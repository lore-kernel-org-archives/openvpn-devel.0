From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 17:08:54 +0000
References: <gerrit.1764176932000.Ic55e1288b0d3160e68eef07ff4edbb070a03dd31@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <ff0374c3099ed69bed885dbbc131d09352cb39e6-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="8x6Xu9IzSHY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: configure/CMake:
 Unify Windows handling
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

--8x6Xu9IzSHY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1410?usp=3Demail

to review the following change.


Change subject: configure/CMake: Unify Windows handling
......................................................................

configure/CMake: Unify Windows handling

Some things were detected in configure.ac and just
hard-coded in CMake. Move the hard-coding to
syshead.h instead and remove the additional code
in configure.ac. These are really Windows-specific
so I think not dynamically detecting is okay.

Change-Id: Ic55e1288b0d3160e68eef07ff4edbb070a03dd31
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M config.h.cmake.in
M configure.ac
M src/openvpn/syshead.h
3 files changed, 29 insertions(+), 83 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1410/1

diff --git a/config.h.cmake.in b/config.h.cmake.in
index f68ea27..bf1388c 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -411,32 +411,3 @@
 #ifndef _GNU_SOURCE
 # define _GNU_SOURCE 1
 #endif
-
-/* if inttypes.h is included this breaks rc.exe when using the ClangCL
- * Toolchain as it pulls in a inttypes.h variant for clang that rc.exe does
- * not understand (#include_next preprocessor directive) */
-#if defined(_WIN32) && !defined(RC_INVOKED)
-#include <inttypes.h>
-typedef uint32_t in_addr_t;
-typedef uint16_t in_port_t;
-
-#define SIGHUP    1
-#define SIGINT    2
-#define SIGUSR1   10
-#define SIGUSR2   12
-#define SIGTERM   15
-#endif
-
-#if defined(_MSC_VER) && !defined(RC_INVOKED)
-#include <BaseTsd.h>
-typedef SSIZE_T ssize_t;
-#define strncasecmp strnicmp
-#define strcasecmp _stricmp
-
-#define S_IRUSR _S_IREAD
-#define S_IWUSR _S_IWRITE
-#define R_OK 4
-#define W_OK 2
-#define X_OK 1
-#define F_OK 0
-#endif
diff --git a/configure.ac b/configure.ac
index 60799e0..73b388b 100644
--- a/configure.ac
+++ b/configure.ac
@@ -527,18 +527,6 @@
 	[[${SOCKET_INCLUDES}]]
 )

-AC_CHECK_TYPES(
-	[in_addr_t],
-	,
-	[AC_DEFINE([in_addr_t], [uint32_t], [Workaround missing in_addr_t])],
-	[[${SOCKET_INCLUDES}]]
-)
-AC_CHECK_TYPES(
-	[in_port_t],
-	,
-	[AC_DEFINE([in_port_t], [uint16_t], [Workaround missing in_port_t])],
-	[[${SOCKET_INCLUDES}]]
-)
 AC_CHECK_TYPE(
 	[struct msghdr],
 	[AC_DEFINE([HAVE_MSGHDR], [1], [struct msghdr needed for extended socket =
error support])],
@@ -600,48 +588,6 @@
 )
 LDFLAGS=3D"$saved_LDFLAGS"

-dnl We emulate signals in Windows
-AC_CHECK_DECLS(
-	[SIGHUP],
-	,
-	[AC_DEFINE([SIGHUP], [1], [SIGHUP replacement])],
-	[[
-		#include <signal.h>
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGINT],
-	,
-	[AC_DEFINE([SIGINT], [2], [SIGINT replacement])],
-	[[
-		#include <signal.h>
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGUSR1],
-	,
-	[AC_DEFINE([SIGUSR1], [10], [SIGUSR1 replacement])],
-	[[
-		#include <signal.h>
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGUSR2],
-	,
-	[AC_DEFINE([SIGUSR2], [12], [SIGUSR2 replacement])],
-	[[
-		#include <signal.h>
-	]]
-)
-AC_CHECK_DECLS(
-	[SIGTERM],
-	,
-	[AC_DEFINE([SIGTERM], [15], [SIGTERM replacement])],
-	[[
-		#include <signal.h>
-	]]
-)
-
 AC_FUNC_FORK

 AC_CHECK_FUNCS([ \
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 70ba1fb..724d307 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -44,6 +44,35 @@
 #define srandom  srand
 #endif

+/* if inttypes.h is included this breaks rc.exe when using the ClangCL
+ * Toolchain as it pulls in a inttypes.h variant for clang that rc.exe does
+ * not understand (#include_next preprocessor directive) */
+#if defined(_WIN32) && !defined(RC_INVOKED)
+#include <inttypes.h>
+typedef uint32_t in_addr_t;
+typedef uint16_t in_port_t;
+
+#define SIGHUP  1
+#define SIGINT  2
+#define SIGUSR1 10
+#define SIGUSR2 12
+#define SIGTERM 15
+#endif
+
+#if defined(_MSC_VER) && !defined(RC_INVOKED)
+#include <BaseTsd.h>
+typedef SSIZE_T ssize_t;
+#define strncasecmp strnicmp
+#define strcasecmp  _stricmp
+
+#define S_IRUSR _S_IREAD
+#define S_IWUSR _S_IWRITE
+#define R_OK    4
+#define W_OK    2
+#define X_OK    1
+#define F_OK    0
+#endif
+
 #if defined(_MSC_VER) && !defined(__clang__) /* Microsoft compiler */
 #define __func__ __FUNCTION__
 #define __attribute__(x)

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1410?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ic55e1288b0d3160e68eef07ff4edbb070a03dd31
Gerrit-Change-Number: 1410
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--8x6Xu9IzSHY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1410?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">configure/CMake: Unify Windows handling<br>=
<br>Some things were detected in configure.ac and just<br>hard-coded in CMa=
ke. Move the hard-coding to<br>syshead.h instead and remove the additional =
code<br>in configure.ac. These are really Windows-specific<br>so I think no=
t dynamically detecting is okay.<br><br>Change-Id: Ic55e1288b0d3160e68eef07=
ff4edbb070a03dd31<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&=
gt;<br>---<br>M config.h.cmake.in<br>M configure.ac<br>M src/openvpn/syshea=
d.h<br>3 files changed, 29 insertions(+), 83 deletions(-)<br><br></pre><pre=
 class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/10/1=
410/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pre=
-wrap;"><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br>=
<span>index f68ea27..bf1388c 100644</span><br><span>--- a/config.h.cmake.in=
</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -411,32 +411,3 =
@@</span><br><span> #ifndef _GNU_SOURCE</span><br><span> # define _GNU_SOUR=
CE 1</span><br><span> #endif</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* if inttypes=
.h is included this breaks rc.exe when using the ClangCL</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">- * Toolchain as it pulls in a inttypes.h=
 variant for clang that rc.exe does</span><br><span style=3D"color: hsl(0, =
100%, 40%);">- * not understand (#include_next preprocessor directive) */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(_WIN32) &am=
p;&amp; !defined(RC_INVOKED)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#include &lt;inttypes.h&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-typedef uint32_t in_addr_t;</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-typedef uint16_t in_port_t;</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define SIGHUP    1</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-#define SIGINT    2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define SIGUSR1   10</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
define SIGUSR2   12</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine SIGTERM   15</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#if defined(_MSC_VER) &amp;&amp; !defin=
ed(RC_INVOKED)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#includ=
e &lt;BaseTsd.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-ty=
pedef SSIZE_T ssize_t;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#define strncasecmp strnicmp</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define strcasecmp _stricmp</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 S_IRUSR _S_IREAD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#def=
ine S_IWUSR _S_IWRITE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
#define R_OK 4</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define=
 W_OK 2</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define X_OK 1=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define F_OK 0</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>diff =
--git a/configure.ac b/configure.ac</span><br><span>index 60799e0..73b388b =
100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.a=
c</span><br><span>@@ -527,18 +527,6 @@</span><br><span> 	[[${SOCKET_INCLUDE=
S}]]</span><br><span> )</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-AC_CHECK_TYPES(</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	[in_addr_t],</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC_DEFINE([=
in_addr_t], [uint32_t], [Workaround missing in_addr_t])],</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-	[[${SOCKET_INCLUDES}]]</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-)</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-AC_CHECK_TYPES(</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-	[in_port_t],</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC_DEFINE([in=
_port_t], [uint16_t], [Workaround missing in_port_t])],</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	[[${SOCKET_INCLUDES}]]</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-)</span><br><span> AC_CHECK_TYPE(</span=
><br><span> 	[struct msghdr],</span><br><span> 	[AC_DEFINE([HAVE_MSGHDR], [=
1], [struct msghdr needed for extended socket error support])],</span><br><=
span>@@ -600,48 +588,6 @@</span><br><span> )</span><br><span> LDFLAGS=3D&qu=
ot;$saved_LDFLAGS&quot;</span><br><span> </span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-dnl We emulate signals in Windows</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-AC_CHECK_DECLS(</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-	[SIGHUP],</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC=
_DEFINE([SIGHUP], [1], [SIGHUP replacement])],</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	[[</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-		#include &lt;signal.h&gt;</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	]]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-)</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_CHECK_DECLS(</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	[SIGINT],</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	[AC_DEFINE([SIGINT], [2], [SIGINT replacement])],</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	[[</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-		#include &lt;signal.h&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	]]</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_CHE=
CK_DECLS(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[SIGUSR1],<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	[AC_DEFINE([SIGUSR1], [10], [SIGUSR1 rep=
lacement])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[[</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-		#include &lt;signal.h&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	]]</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-)</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-AC_CHECK_DECLS(</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-	[SIGUSR2],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
	,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC_DEFINE([SIGUSR=
2], [12], [SIGUSR2 replacement])],</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	[[</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		#in=
clude &lt;signal.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-	]]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-)</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-AC_CHECK_DECLS(</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	[SIGTERM],</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	,</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	[AC_DEFINE([SIGTERM], [15], [SIGTERM replacement])],</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-	[[</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-		#include &lt;signal.h&gt;</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-	]]</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n> AC_FUNC_FORK</span><br><span> </span><br><span> AC_CHECK_FUNCS([ \</span=
><br><span>diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h</span=
><br><span>index 70ba1fb..724d307 100644</span><br><span>--- a/src/openvpn/=
syshead.h</span><br><span>+++ b/src/openvpn/syshead.h</span><br><span>@@ -4=
4,6 +44,35 @@</span><br><span> #define srandom  srand</span><br><span> #end=
if</span><br><span> </span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+/* if inttypes.h is included this breaks rc.exe when using the ClangCL</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+ * Toolchain as it pull=
s in a inttypes.h variant for clang that rc.exe does</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+ * not understand (#include_next preproce=
ssor directive) */</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#=
if defined(_WIN32) &amp;&amp; !defined(RC_INVOKED)</span><br><span style=3D=
"color: hsl(120, 100%, 40%);">+#include &lt;inttypes.h&gt;</span><br><span =
style=3D"color: hsl(120, 100%, 40%);">+typedef uint32_t in_addr_t;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+typedef uint16_t in_port_t;<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#define SIGHUP  1</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SIGINT  2</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SIGUSR1 10</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SIGUSR2 12</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define SIGTERM 15</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+</span><br><span style=3D"color: hsl(120, 100%, 40%);"=
>+#if defined(_MSC_VER) &amp;&amp; !defined(RC_INVOKED)</span><br><span sty=
le=3D"color: hsl(120, 100%, 40%);">+#include &lt;BaseTsd.h&gt;</span><br><s=
pan style=3D"color: hsl(120, 100%, 40%);">+typedef SSIZE_T ssize_t;</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+#define strncasecmp strnicm=
p</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define strcasecmp=
  _stricmp</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#define S_IRUSR _S_IREAD</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define S_IWUSR _S_IWRI=
TE</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define R_OK    4=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define W_OK    2</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define X_OK    1</sp=
an><br><span style=3D"color: hsl(120, 100%, 40%);">+#define F_OK    0</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span st=
yle=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #if defined(_MSC_VER=
) &amp;&amp; !defined(__clang__) /* Microsoft compiler */</span><br><span> =
#define __func__ __FUNCTION__</span><br><span> #define __attribute__(x)</sp=
an><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1410?usp=3Demail">change 1410</a>. To unsubscribe, or=
 for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/=
settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sc=
hema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:=
//schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openv=
pn.net/c/openvpn/+/1410?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vi=
ew Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ic55e1288b0d3160e68eef07ff4e=
dbb070a03dd31 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1410 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>

</body></html>=

--8x6Xu9IzSHY=--

