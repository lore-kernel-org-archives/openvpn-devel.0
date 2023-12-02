From: "cron2 (Code Review)" <gerrit@...515...>
Date: Sat, 2 Dec 2023 16:41:01 +0000
In-Reply-To: <gerrit.1700477479000.I9c85ccab6d51064ebff2c391740ba8c2d044ed1a@...2715...>
References: <gerrit.1700477479000.I9c85ccab6d51064ebff2c391740ba8c2d044ed1a@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <1fe3f08c92b029839898e153d8637691b63eda72-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="mOMGDy3/4Uc="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Remove compat
 versionhelpers.h and remove cmake/configure check for it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: plaisthos <arne-openvpn@...1227...>
Cc: flichtenheld <frank@...2641...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--mOMGDy3/4Uc=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/44=
5?usp=3Demail )

Change subject: Remove compat versionhelpers.h and remove cmake/configure c=
heck for it
......................................................................

Remove compat versionhelpers.h and remove cmake/configure check for it

The cmake file defined that file to be never present in contrast to the
old msvc-config.h that always had it present.
Remove also the compat implementation taken from mingw. All our current
build environments already have that header in place.

Change-Id: I9c85ccab6d51064ebff2c391740ba8c2d044ed1a
Acked-by: Frank Lichtenheld <frank@...2641...>
Signed-off-by: Arne Schwabe <arne@...1227...>
Message-Id: <20231128103950.62407-1-frank@...2641...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27=
573.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M src/compat/Makefile.am
D src/compat/compat-versionhelpers.h
M src/openvpn/win32.c
M src/openvpnserv/interactive.c
7 files changed, 1 insertion(+), 131 deletions(-)




diff --git a/CMakeLists.txt b/CMakeLists.txt
index e4de309..577bc5d 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -316,7 +316,6 @@
     src/compat/compat-dirname.c
     src/compat/compat-gettimeofday.c
     src/compat/compat-strsep.c
-    src/compat/compat-versionhelpers.h
     src/openvpn/argv.c
     src/openvpn/argv.h
     src/openvpn/base64.c
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 2af3810..baf9556 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -372,9 +372,6 @@
 /* Define to 1 if you have the <valgrind/memcheck.h> header file. */
 #undef HAVE_VALGRIND_MEMCHECK_H

-/* Define to 1 if you have the <versionhelpers.h> header file. */
-#undef HAVE_VERSIONHELPERS_H
-
 /* Define to 1 if you have the `vfork' function. */
 #undef HAVE_VFORK

diff --git a/configure.ac b/configure.ac
index 0f667dc..54f79ab 100644
--- a/configure.ac
+++ b/configure.ac
@@ -454,7 +454,6 @@
 	unistd.h dlfcn.h \
 	netinet/in.h \
 	netinet/tcp.h arpa/inet.h netdb.h \
-	versionhelpers.h \
 ])
 AC_CHECK_HEADERS([ \
 	sys/time.h sys/ioctl.h sys/stat.h \
diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
index f5de451..5298dd8 100644
--- a/src/compat/Makefile.am
+++ b/src/compat/Makefile.am
@@ -20,5 +20,4 @@
 	compat-basename.c \
 	compat-gettimeofday.c \
 	compat-daemon.c \
-	compat-strsep.c \
-	compat-versionhelpers.h
+	compat-strsep.c
\ No newline at end of file
diff --git a/src/compat/compat-versionhelpers.h b/src/compat/compat-version=
helpers.h
deleted file mode 100644
index b071602..0000000
--- a/src/compat/compat-versionhelpers.h
+++ /dev/null
@@ -1,116 +0,0 @@
-/**
- * This file is part of the mingw-w64 runtime package.
- * No warranty is given; refer to the file DISCLAIMER within this package.
- */
-
-#ifndef _INC_VERSIONHELPERS
-#define _INC_VERSIONHELPERS
-
-#include <winapifamily.h>
-
-#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) && !defined(__WIDL__)
-
-#ifdef __cplusplus
-#define VERSIONHELPERAPI inline bool
-#else
-#define VERSIONHELPERAPI FORCEINLINE BOOL
-#endif
-
-#define _WIN32_WINNT_WINBLUE    0x0603
-
-#ifndef _WIN32_WINNT_WINTHRESHOLD
-#define _WIN32_WINNT_WINTHRESHOLD    0x0A00 /* Windows 10 */
-#endif
-
-VERSIONHELPERAPI
-IsWindowsVersionOrGreater(WORD major, WORD minor, WORD servpack)
-{
-    OSVERSIONINFOEXW vi =3D {sizeof(vi), major, minor, 0, 0, {0}, servpack=
};
-    return VerifyVersionInfoW(&vi, VER_MAJORVERSION|VER_MINORVERSION|VER_S=
ERVICEPACKMAJOR,
-                              VerSetConditionMask(VerSetConditionMask(VerS=
etConditionMask(0,
-                                                                          =
                VER_MAJORVERSION, VER_GREATER_EQUAL),
-                                                                      VER_=
MINORVERSION, VER_GREATER_EQUAL),
-                                                  VER_SERVICEPACKMAJOR, VE=
R_GREATER_EQUAL));
-}
-
-VERSIONHELPERAPI
-IsWindowsXPOrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_W=
IN32_WINNT_WINXP), 0);
-}
-
-VERSIONHELPERAPI
-IsWindowsXPSP1OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_W=
IN32_WINNT_WINXP), 1);
-}
-
-VERSIONHELPERAPI
-IsWindowsXPSP2OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_W=
IN32_WINNT_WINXP), 2);
-}
-
-VERSIONHELPERAPI
-IsWindowsXPSP3OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_W=
IN32_WINNT_WINXP), 3);
-}
-
-VERSIONHELPERAPI
-IsWindowsVistaOrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_W=
IN32_WINNT_VISTA), 0);
-}
-
-VERSIONHELPERAPI
-IsWindowsVistaSP1OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_W=
IN32_WINNT_VISTA), 1);
-}
-
-VERSIONHELPERAPI
-IsWindowsVistaSP2OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_W=
IN32_WINNT_VISTA), 2);
-}
-
-VERSIONHELPERAPI
-IsWindows7OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WI=
N32_WINNT_WIN7), 0);
-}
-
-VERSIONHELPERAPI
-IsWindows7SP1OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WI=
N32_WINNT_WIN7), 1);
-}
-
-VERSIONHELPERAPI
-IsWindows8OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN8), LOBYTE(_WI=
N32_WINNT_WIN8), 0);
-}
-
-VERSIONHELPERAPI
-IsWindows8Point1OrGreater(void)
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINBLUE), LOBYTE(=
_WIN32_WINNT_WINBLUE), 0);
-}
-
-VERSIONHELPERAPI
-IsWindows10OrGreater()
-{
-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINTHRESHOLD), LO=
BYTE(_WIN32_WINNT_WINTHRESHOLD), 0);
-}
-
-VERSIONHELPERAPI
-IsWindowsServer(void)
-{
-    OSVERSIONINFOEXW vi =3D {sizeof(vi), 0, 0, 0, 0, {0}, 0, 0, 0, VER_NT_=
WORKSTATION};
-    return !VerifyVersionInfoW(&vi, VER_PRODUCT_TYPE, VerSetConditionMask(=
0, VER_PRODUCT_TYPE, VER_EQUAL));
-}
-
-#endif /* if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) && !defined=
(__WIDL__) */
-#endif /* ifndef _INC_VERSIONHELPERS */
diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
index 47eb1fc..e998d90 100644
--- a/src/openvpn/win32.c
+++ b/src/openvpn/win32.c
@@ -45,11 +45,7 @@

 #include "memdbg.h"

-#ifdef HAVE_VERSIONHELPERS_H
 #include <versionhelpers.h>
-#else
-#include "compat-versionhelpers.h"
-#endif

 #include "block_dns.h"

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a47db8a..32c8996 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -34,11 +34,7 @@
 #include <shellapi.h>
 #include <mstcpip.h>

-#ifdef HAVE_VERSIONHELPERS_H
 #include <versionhelpers.h>
-#else
-#include "compat-versionhelpers.h"
-#endif

 #include "openvpn-msg.h"
 #include "validate.h"

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I9c85ccab6d51064ebff2c391740ba8c2d044ed1a
Gerrit-Change-Number: 445
Gerrit-PatchSet: 3
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-MessageType: merged

--mOMGDy3/4Uc=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p>cron2 <strong>submitted</strong> this change.</p><p><a href=3D"http://ge=
rrit.openvpn.net/c/openvpn/+/445?usp=3Demail">View Change</a></p><div style=
=3D"white-space:pre-wrap"></div><pre style=3D"font-family: monospace,monosp=
ace; white-space: pre-wrap;">Remove compat versionhelpers.h and remove cmak=
e/configure check for it<br><br>The cmake file defined that file to be neve=
r present in contrast to the<br>old msvc-config.h that always had it presen=
t.<br>Remove also the compat implementation taken from mingw. All our curre=
nt<br>build environments already have that header in place.<br><br>Change-I=
d: I9c85ccab6d51064ebff2c391740ba8c2d044ed1a<br>Acked-by: Frank Lichtenheld=
 &lt;frank@...2641...&gt;<br>Signed-off-by: Arne Schwabe &lt;arne@...2477...=
.&gt;<br>Message-Id: &lt;20231128103950.62407-1-frank@...2641...&gt;<br>URL=
: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg27573=
.html<br>Signed-off-by: Gert Doering &lt;gert@...1296...&gt;<br>---<br>M CM=
akeLists.txt<br>M config.h.cmake.in<br>M configure.ac<br>M src/compat/Makef=
ile.am<br>D src/compat/compat-versionhelpers.h<br>M src/openvpn/win32.c<br>=
M src/openvpnserv/interactive.c<br>7 files changed, 1 insertion(+), 131 del=
etions(-)<br><br></pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index e4de3=
09..577bc5d 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -316,7 +316,6 @@</span><br><span>     =
src/compat/compat-dirname.c</span><br><span>     src/compat/compat-gettimeo=
fday.c</span><br><span>     src/compat/compat-strsep.c</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    src/compat/compat-versionhelpers.h</sp=
an><br><span>     src/openvpn/argv.c</span><br><span>     src/openvpn/argv.=
h</span><br><span>     src/openvpn/base64.c</span><br><span>diff --git a/co=
nfig.h.cmake.in b/config.h.cmake.in</span><br><span>index 2af3810..baf9556 =
100644</span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/config=
.h.cmake.in</span><br><span>@@ -372,9 +372,6 @@</span><br><span> /* Define =
to 1 if you have the &lt;valgrind/memcheck.h&gt; header file. */</span><br>=
<span> #undef HAVE_VALGRIND_MEMCHECK_H</span><br><span> </span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;versi=
onhelpers.h&gt; header file. */</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#undef HAVE_VERSIONHELPERS_H</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> /* Define to 1 if you have the `vfork&#3=
9; function. */</span><br><span> #undef HAVE_VFORK</span><br><span> </span>=
<br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index 0f=
667dc..54f79ab 100644</span><br><span>--- a/configure.ac</span><br><span>++=
+ b/configure.ac</span><br><span>@@ -454,7 +454,6 @@</span><br><span> 	unis=
td.h dlfcn.h \</span><br><span> 	netinet/in.h \</span><br><span> 	netinet/t=
cp.h arpa/inet.h netdb.h \</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	versionhelpers.h \</span><br><span> ])</span><br><span> AC_CHECK_HEAD=
ERS([ \</span><br><span> 	sys/time.h sys/ioctl.h sys/stat.h \</span><br><sp=
an>diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am</span><br><=
span>index f5de451..5298dd8 100644</span><br><span>--- a/src/compat/Makefil=
e.am</span><br><span>+++ b/src/compat/Makefile.am</span><br><span>@@ -20,5 =
+20,4 @@</span><br><span> 	compat-basename.c \</span><br><span> 	compat-get=
timeofday.c \</span><br><span> 	compat-daemon.c \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	compat-strsep.c \</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-	compat-versionhelpers.h</span><br><span style=3D"=
color: hsl(120, 100%, 40%);">+	compat-strsep.c</span><br><span>\ No newline=
 at end of file</span><br><span>diff --git a/src/compat/compat-versionhelpe=
rs.h b/src/compat/compat-versionhelpers.h</span><br><span>deleted file mode=
 100644</span><br><span>index b071602..0000000</span><br><span>--- a/src/co=
mpat/compat-versionhelpers.h</span><br><span>+++ /dev/null</span><br><span>=
@@ -1,116 +0,0 @@</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/**<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- * This file is part o=
f the mingw-w64 runtime package.</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">- * No warranty is given; refer to the file DISCLAIMER within thi=
s package.</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#ifndef _INC_VERSIONHELPERS</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#define _INC_VERSIONHELPERS</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#include &lt;winapifamily.h&gt;</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) &amp;&amp; !def=
ined(__WIDL__)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef __cplusplus</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#define VERSIONHELPERAPI inline=
 bool</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#define VERSIONHELPERAPI FORCEIN=
LINE BOOL</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-#define _WIN32_WINNT_WINBLUE    0x0603</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#ifndef _WIN32_WINNT_WINTHRESHOLD</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#define _WIN32_WINNT_WINTHRESHOLD    0x0=
A00 /* Windows 10 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#=
endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-IsWindowsVersionOrGreater(WORD major, WORD=
 minor, WORD servpack)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OSVERSIONINFOEX=
W vi =3D {sizeof(vi), major, minor, 0, 0, {0}, servpack};</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-    return VerifyVersionInfoW(&amp;vi, =
VER_MAJORVERSION|VER_MINORVERSION|VER_SERVICEPACKMAJOR,</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-                              VerSetCondi=
tionMask(VerSetConditionMask(VerSetConditionMask(0,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-                                           =
                                               VER_MAJORVERSION, VER_GREATE=
R_EQUAL),</span><br><span style=3D"color: hsl(0, 100%, 40%);">-            =
                                                          VER_MINORVERSION,=
 VER_GREATER_EQUAL),</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
                                                 VER_SERVICEPACKMAJOR, VER_=
GREATER_EQUAL));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-IsWindowsXPOrGreater(void)</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), L=
OBYTE(_WIN32_WINNT_WINXP), 0);</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-IsWindowsXPSP1OrGreater(void)</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN3=
2_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 1);</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAP=
I</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsWindowsXPSP2OrGrea=
ter(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return IsWindowsVersionOrGre=
ater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 2);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-VERSIONHELPERAPI</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsW=
indowsXPSP3OrGreater(void)</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return IsWi=
ndowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP=
), 3);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-IsWindowsVistaOrGreater(void)</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_=
WIN32_WINNT_VISTA), 0);</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-IsWindowsVistaSP1OrGreater(void)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_W=
INNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 1);</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsWindowsVistaSP2OrGrea=
ter(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-    return IsWindowsVersionOrGre=
ater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 2);</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-VERSIONHELPERAPI</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsW=
indows7OrGreater(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return IsWindow=
sVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 0);=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-VERSIONHELPERAPI</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-IsWindows7SP1OrGreater(void)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    r=
eturn IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WI=
NNT_WIN7), 1);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-IsWindows8OrGreater(void)</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN8), LOBYT=
E(_WIN32_WINNT_WIN8), 0);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-IsWindows8Point1OrGreater(void)</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_W=
INNT_WINBLUE), LOBYTE(_WIN32_WINNT_WINBLUE), 0);</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERA=
PI</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsWindows10OrGreate=
r()</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-    return IsWindowsVersionOrGreater(H=
IBYTE(_WIN32_WINNT_WINTHRESHOLD), LOBYTE(_WIN32_WINNT_WINTHRESHOLD), 0);</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-VERSIONHELPERAPI</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-IsWindowsServer(void)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    OSVERSIONI=
NFOEXW vi =3D {sizeof(vi), 0, 0, 0, 0, {0}, 0, 0, 0, VER_NT_WORKSTATION};</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return !VerifyVersi=
onInfoW(&amp;vi, VER_PRODUCT_TYPE, VerSetConditionMask(0, VER_PRODUCT_TYPE,=
 VER_EQUAL));</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#endif /* if WINAPI_FAMILY_PARTITION(WINAPI_PARTI=
TION_DESKTOP) &amp;&amp; !defined(__WIDL__) */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif /* ifndef _INC_VERSIONHELPERS */</span><br>=
<span>diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c</span><br><spa=
n>index 47eb1fc..e998d90 100644</span><br><span>--- a/src/openvpn/win32.c</=
span><br><span>+++ b/src/openvpn/win32.c</span><br><span>@@ -45,11 +45,7 @@=
</span><br><span> </span><br><span> #include &quot;memdbg.h&quot;</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_V=
ERSIONHELPERS_H</span><br><span> #include &lt;versionhelpers.h&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#include &quot;compat-versionhelpers.h&quot;</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span>=
 </span><br><span> #include &quot;block_dns.h&quot;</span><br><span> </span=
><br><span>diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/int=
eractive.c</span><br><span>index a47db8a..32c8996 100644</span><br><span>--=
- a/src/openvpnserv/interactive.c</span><br><span>+++ b/src/openvpnserv/int=
eractive.c</span><br><span>@@ -34,11 +34,7 @@</span><br><span> #include &lt=
;shellapi.h&gt;</span><br><span> #include &lt;mstcpip.h&gt;</span><br><span=
> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_VERSION=
HELPERS_H</span><br><span> #include &lt;versionhelpers.h&gt;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-#include &quot;compat-versionhelpers.h&quot;</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span> </spa=
n><br><span> #include &quot;openvpn-msg.h&quot;</span><br><span> #include &=
quot;validate.h&quot;</span><br><span></span><br></pre><p>To view, visit <a=
 href=3D"http://gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail">change 445<=
/a>. To unsubscribe, or for help writing mail filters, visit <a href=3D"htt=
p://gerrit.openvpn.net/settings">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail"/><meta itemprop=3D"name" c=
ontent=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9c85ccab6d51064ebff2c391740=
ba8c2d044ed1a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 445 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: merged </div>


--mOMGDy3/4Uc=--

