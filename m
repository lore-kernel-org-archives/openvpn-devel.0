From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 10:51:21 +0000
References: <gerrit.1700477479000.I9c85ccab6d51064ebff2c391740ba8c2d044ed1a@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <b8478f4b34c727aca697ce40f4814b8c845d7872-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="DVBel8dtU1M="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--DVBel8dtU1M=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail

to review the following change.


Change subject: Remove compat versionhelpers.h and remove cmake/configure c=
heck for it
......................................................................

Remove compat versionhelpers.h and remove cmake/configure check for it

The cmake file defined that file to be never present in contrast to the
old msvc-config.h that always had it present. Also interactive.c includes
versionhelpers.h without the check, so we always assume it to be present
anyway. Remove also the comapt implementation taken from mingw

Change-Id: I9c85ccab6d51064ebff2c391740ba8c2d044ed1a
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M src/compat/Makefile.am
D src/compat/compat-versionhelpers.h
M src/openvpn/win32.c
M src/openvpnserv/interactive.c
7 files changed, 1 insertion(+), 131 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/445/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index d21c9bd..fa6d623 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -308,7 +308,6 @@
     src/compat/compat-dirname.c
     src/compat/compat-gettimeofday.c
     src/compat/compat-strsep.c
-    src/compat/compat-versionhelpers.h
     src/openvpn/argv.c
     src/openvpn/argv.h
     src/openvpn/base64.c
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 19b79bc..8edaff4 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -374,9 +374,6 @@
 /* Define to 1 if you have the <valgrind/memcheck.h> header file. */
 #undef HAVE_VALGRIND_MEMCHECK_H

-/* Define to 1 if you have the <versionhelpers.h> header file. */
-#undef HAVE_VERSIONHELPERS_H
-
 /* Define to 1 if you have the `vfork' function. */
 #undef HAVE_VFORK

diff --git a/configure.ac b/configure.ac
index 84eaad6..94c6654 100644
--- a/configure.ac
+++ b/configure.ac
@@ -455,7 +455,6 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--DVBel8dtU1M=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove compat versionhelpers.h and remove cmake/configure che=
ck for it<br><br>The cmake file defined that file to be never present in co=
ntrast to the<br>old msvc-config.h that always had it present. Also interac=
tive.c includes<br>versionhelpers.h without the check, so we always assume =
it to be present<br>anyway. Remove also the comapt implementation taken fro=
m mingw<br><br>Change-Id: I9c85ccab6d51064ebff2c391740ba8c2d044ed1a<br>---<=
br>M CMakeLists.txt<br>M config.h.cmake.in<br>M configure.ac<br>M src/compa=
t/Makefile.am<br>D src/compat/compat-versionhelpers.h<br>M src/openvpn/win3=
2.c<br>M src/openvpnserv/interactive.c<br>7 files changed, 1 insertion(+), =
131 deletions(-)<br><br></pre><pre style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn =
refs/changes/45/445/1</pre><pre style=3D"font-family: monospace,monospace; =
white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt<=
/span><br><span>index d21c9bd..fa6d623 100644</span><br><span>--- a/CMakeLi=
sts.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -308,7 +308=
,6 @@</span><br><span>     src/compat/compat-dirname.c</span><br><span>    =
 src/compat/compat-gettimeofday.c</span><br><span>     src/compat/compat-st=
rsep.c</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    src/compat/=
compat-versionhelpers.h</span><br><span>     src/openvpn/argv.c</span><br><=
span>     src/openvpn/argv.h</span><br><span>     src/openvpn/base64.c</spa=
n><br><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br><s=
pan>index 19b79bc..8edaff4 100644</span><br><span>--- a/config.h.cmake.in</=
span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -374,9 +374,6 @@<=
/span><br><span> /* Define to 1 if you have the &lt;valgrind/memcheck.h&gt;=
 header file. */</span><br><span> #undef HAVE_VALGRIND_MEMCHECK_H</span><br=
><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to =
1 if you have the &lt;versionhelpers.h&gt; header file. */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_VERSIONHELPERS_H</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Define to =
1 if you have the `vfork&#39; function. */</span><br><span> #undef HAVE_VFO=
RK</span><br><span> </span><br><span>diff --git a/configure.ac b/configure.=
ac</span><br><span>index 84eaad6..94c6654 100644</span><br><span>--- a/conf=
igure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -455,7 +455,=
6 @@</span><br><span> 	unistd.h dlfcn.h \</span><br><span> 	netinet/in.h \<=
/span><br><span> 	netinet/tcp.h arpa/inet.h netdb.h \</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	versionhelpers.h \</span><br><span> ])</sp=
an><br><span> AC_CHECK_HEADERS([ \</span><br><span> 	sys/time.h sys/ioctl.h=
 sys/stat.h \</span><br><span>diff --git a/src/compat/Makefile.am b/src/com=
pat/Makefile.am</span><br><span>index f5de451..5298dd8 100644</span><br><sp=
an>--- a/src/compat/Makefile.am</span><br><span>+++ b/src/compat/Makefile.a=
m</span><br><span>@@ -20,5 +20,4 @@</span><br><span> 	compat-basename.c \</=
span><br><span> 	compat-gettimeofday.c \</span><br><span> 	compat-daemon.c =
\</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	compat-strsep.c \</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	compat-versionhelpers.=
h</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	compat-strsep.c</=
span><br><span>\ No newline at end of file</span><br><span>diff --git a/src=
/compat/compat-versionhelpers.h b/src/compat/compat-versionhelpers.h</span>=
<br><span>deleted file mode 100644</span><br><span>index b071602..0000000</=
span><br><span>--- a/src/compat/compat-versionhelpers.h</span><br><span>+++=
 /dev/null</span><br><span>@@ -1,116 +0,0 @@</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/**</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">- * This file is part of the mingw-w64 runtime package.</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">- * No warranty is given; refer to the=
 file DISCLAIMER within this package.</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef _INC_VERSIONHEL=
PERS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define _INC_VERS=
IONHELPERS</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;winapifamily.h&gt;<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITIO=
N_DESKTOP) &amp;&amp; !defined(__WIDL__)</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#i=
fdef __cplusplus</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defi=
ne VERSIONHELPERAPI inline bool</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#defin=
e VERSIONHELPERAPI FORCEINLINE BOOL</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define _WIN32_WINNT_W=
INBLUE    0x0603</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef _WIN32_WINNT_WINTH=
RESHOLD</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define _WIN32=
_WINNT_WINTHRESHOLD    0x0A00 /* Windows 10 */</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELP=
ERAPI</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsWindowsVersion=
OrGreater(WORD major, WORD minor, WORD servpack)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    OSVERSIONINFOEXW vi =3D {sizeof(vi), major, minor, 0, 0, {0}, se=
rvpack};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return Ve=
rifyVersionInfoW(&amp;vi, VER_MAJORVERSION|VER_MINORVERSION|VER_SERVICEPACK=
MAJOR,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-               =
               VerSetConditionMask(VerSetConditionMask(VerSetConditionMask(=
0,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-                   =
                                                                       VER_=
MAJORVERSION, VER_GREATER_EQUAL),</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-                                                               =
       VER_MINORVERSION, VER_GREATER_EQUAL),</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-                                                  VE=
R_SERVICEPACKMAJOR, VER_GREATER_EQUAL));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-IsWindowsXPOrGreater(void)<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-    return IsWindowsVersionOrGreater(HIBYT=
E(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 0);</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-VERSIONH=
ELPERAPI</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsWindowsXPSP=
1OrGreater(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-    return IsWindowsVersi=
onOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 1);</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-VERSIONHELPERAPI</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-IsWindowsXPSP2OrGreater(void)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WI=
NNT_WINXP), 2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-IsWindowsXPSP3OrGreater(void)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP)=
, LOBYTE(_WIN32_WINNT_WINXP), 3);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-IsWindowsVistaOrGreater(void)</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-    return IsWindowsVersionOrGreater(HIBYTE(_W=
IN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 0);</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPE=
RAPI</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsWindowsVistaSP1=
OrGreater(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-    return IsWindowsVersio=
nOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 1);</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-VERSIONHELPERAPI</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-IsWindowsVistaSP2OrGreater(void)</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    re=
turn IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WI=
NNT_VISTA), 2);</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-IsWindows7OrGreater(void)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBY=
TE(_WIN32_WINNT_WIN7), 0);</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-IsWindows7SP1OrGreater(void)</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WIN=
NT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 1);</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-IsWindows8OrGreater(void)</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-    return IsWindowsVersionOrGreater(HIBYTE=
(_WIN32_WINNT_WIN8), LOBYTE(_WIN32_WINNT_WIN8), 0);</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-VERSIONHE=
LPERAPI</span><br><span style=3D"color: hsl(0, 100%, 40%);">-IsWindows8Poin=
t1OrGreater(void)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-{</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-    return IsWindowsVers=
ionOrGreater(HIBYTE(_WIN32_WINNT_WINBLUE), LOBYTE(_WIN32_WINNT_WINBLUE), 0)=
;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-}</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-VERSIONHELPERAPI</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-IsWindows10OrGreater()</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-{</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    return=
 IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINTHRESHOLD), LOBYTE(_WIN32=
_WINNT_WINTHRESHOLD), 0);</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-VERSIONHELPERAPI</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-IsWindowsServer(void)</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-{</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-    OSVERSIONINFOEXW vi =3D {sizeof(vi), 0, 0, 0, 0, {0}, 0, 0=
, 0, VER_NT_WORKSTATION};</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-    return !VerifyVersionInfoW(&amp;vi, VER_PRODUCT_TYPE, VerSetConditi=
onMask(0, VER_PRODUCT_TYPE, VER_EQUAL));</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-}</span><br><span style=3D"color: hsl(0, 100%, 40%);">-<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* if WINAPI_FA=
MILY_PARTITION(WINAPI_PARTITION_DESKTOP) &amp;&amp; !defined(__WIDL__) */</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif /* ifndef _INC_V=
ERSIONHELPERS */</span><br><span>diff --git a/src/openvpn/win32.c b/src/ope=
nvpn/win32.c</span><br><span>index 47eb1fc..e998d90 100644</span><br><span>=
--- a/src/openvpn/win32.c</span><br><span>+++ b/src/openvpn/win32.c</span><=
br><span>@@ -45,11 +45,7 @@</span><br><span> </span><br><span> #include &qu=
ot;memdbg.h&quot;</span><br><span> </span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#ifdef HAVE_VERSIONHELPERS_H</span><br><span> #include &lt;ve=
rsionhelpers.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#el=
se</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;comp=
at-versionhelpers.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#endif</span><br><span> </span><br><span> #include &quot;block_dns.h&qu=
ot;</span><br><span> </span><br><span>diff --git a/src/openvpnserv/interact=
ive.c b/src/openvpnserv/interactive.c</span><br><span>index a47db8a..32c899=
6 100644</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><spa=
n>+++ b/src/openvpnserv/interactive.c</span><br><span>@@ -34,11 +34,7 @@</s=
pan><br><span> #include &lt;shellapi.h&gt;</span><br><span> #include &lt;ms=
tcpip.h&gt;</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifdef HAVE_VERSIONHELPERS_H</span><br><span> #include &lt;versionh=
elpers.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#else</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &quot;compat-ver=
sionhelpers.h&quot;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#e=
ndif</span><br><span> </span><br><span> #include &quot;openvpn-msg.h&quot;<=
/span><br><span> #include &quot;validate.h&quot;</span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/4=
45?usp=3Demail">change 445</a>. To unsubscribe, or for help writing mail fi=
lters, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</=
p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope=
 itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itempr=
op=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail"/>=
<meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9c85ccab6d51064ebff2c391740=
ba8c2d044ed1a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 445 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>


--DVBel8dtU1M=--

