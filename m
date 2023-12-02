MIME-Version: 1.0
References: <gerrit.1700477479000.I9c85ccab6d51064ebff2c391740ba8c2d044ed1a@...2715...>
 <b8478f4b34c727aca697ce40f4814b8c845d7872-HTML@...2715...>
In-Reply-To: <b8478f4b34c727aca697ce40f4814b8c845d7872-HTML@...2715...>
From: Juan Cervantes <carloscervantes1989j@...277...>
Date: Sat, 2 Dec 2023 11:08:56 -0800
Message-ID: <CAH39tATvMSZPhdgu2vw9WtV3BLNDW95yM+gK20L1WZdtzxFsmQ@...278...>
Content-Type: multipart/alternative; boundary="000000000000841f80060b8b9e86"
Subject: Re: [Openvpn-devel] [M] Change in openvpn[master]: Remove compat
 versionhelpers.h and remove cmake/configure check for it
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net, frank@...2641...

--000000000000841f80060b8b9e86
Content-Type: text/plain; charset="UTF-8"

Make is original and don't change anything to make it affect please

On Mon, Nov 20, 2023, 2:52 AM plaisthos (Code Review) <gerrit@...515...>
wrote:

> Attention is currently required from: flichtenheld.
>
> plaisthos would like flichtenheld to *review* this change.
>
> View Change <http://gerrit.openvpn.net/c/openvpn/+/445?usp=email>
>
> Remove compat versionhelpers.h and remove cmake/configure check for it
>
> The cmake file defined that file to be never present in contrast to the
> old msvc-config.h that always had it present. Also interactive.c includes
> versionhelpers.h without the check, so we always assume it to be present
> anyway. Remove also the comapt implementation taken from mingw
>
> Change-Id: I9c85ccab6d51064ebff2c391740ba8c2d044ed1a
> ---
> M CMakeLists.txt
> M config.h.cmake.in
> M configure.ac
> M src/compat/Makefile.am
> D src/compat/compat-versionhelpers.h
> M src/openvpn/win32.c
> M src/openvpnserv/interactive.c
> 7 files changed, 1 insertion(+), 131 deletions(-)
>
> git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/45/445/1
>
> diff --git a/CMakeLists.txt b/CMakeLists.txt
> index d21c9bd..fa6d623 100644
> --- a/CMakeLists.txt
> +++ b/CMakeLists.txt
> @@ -308,7 +308,6 @@
>      src/compat/compat-dirname.c
>      src/compat/compat-gettimeofday.c
>      src/compat/compat-strsep.c
> -    src/compat/compat-versionhelpers.h
>      src/openvpn/argv.c
>      src/openvpn/argv.h
>      src/openvpn/base64.c
> diff --git a/config.h.cmake.in b/config.h.cmake.in
> index 19b79bc..8edaff4 100644
> --- a/config.h.cmake.in
> +++ b/config.h.cmake.in
> @@ -374,9 +374,6 @@
>  /* Define to 1 if you have the <valgrind/memcheck.h> header file. */
>  #undef HAVE_VALGRIND_MEMCHECK_H
>
> -/* Define to 1 if you have the <versionhelpers.h> header file. */
> -#undef HAVE_VERSIONHELPERS_H
> -
>  /* Define to 1 if you have the `vfork' function. */
>  #undef HAVE_VFORK
>
> diff --git a/configure.ac b/configure.ac
> index 84eaad6..94c6654 100644
> --- a/configure.ac
> +++ b/configure.ac
> @@ -455,7 +455,6 @@
>  	unistd.h dlfcn.h \
>  	netinet/in.h \
>  	netinet/tcp.h arpa/inet.h netdb.h \
> -	versionhelpers.h \
>  ])
>  AC_CHECK_HEADERS([ \
>  	sys/time.h sys/ioctl.h sys/stat.h \
> diff --git a/src/compat/Makefile.am b/src/compat/Makefile.am
> index f5de451..5298dd8 100644
> --- a/src/compat/Makefile.am
> +++ b/src/compat/Makefile.am
> @@ -20,5 +20,4 @@
>  	compat-basename.c \
>  	compat-gettimeofday.c \
>  	compat-daemon.c \
> -	compat-strsep.c \
> -	compat-versionhelpers.h
> +	compat-strsep.c
> \ No newline at end of file
> diff --git a/src/compat/compat-versionhelpers.h b/src/compat/compat-versionhelpers.h
> deleted file mode 100644
> index b071602..0000000
> --- a/src/compat/compat-versionhelpers.h
> +++ /dev/null
> @@ -1,116 +0,0 @@
> -/**
> - * This file is part of the mingw-w64 runtime package.
> - * No warranty is given; refer to the file DISCLAIMER within this package.
> - */
> -
> -#ifndef _INC_VERSIONHELPERS
> -#define _INC_VERSIONHELPERS
> -
> -#include <winapifamily.h>
> -
> -#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) && !defined(__WIDL__)
> -
> -#ifdef __cplusplus
> -#define VERSIONHELPERAPI inline bool
> -#else
> -#define VERSIONHELPERAPI FORCEINLINE BOOL
> -#endif
> -
> -#define _WIN32_WINNT_WINBLUE    0x0603
> -
> -#ifndef _WIN32_WINNT_WINTHRESHOLD
> -#define _WIN32_WINNT_WINTHRESHOLD    0x0A00 /* Windows 10 */
> -#endif
> -
> -VERSIONHELPERAPI
> -IsWindowsVersionOrGreater(WORD major, WORD minor, WORD servpack)
> -{
> -    OSVERSIONINFOEXW vi = {sizeof(vi), major, minor, 0, 0, {0}, servpack};
> -    return VerifyVersionInfoW(&vi, VER_MAJORVERSION|VER_MINORVERSION|VER_SERVICEPACKMAJOR,
> -                              VerSetConditionMask(VerSetConditionMask(VerSetConditionMask(0,
> -                                                                                          VER_MAJORVERSION, VER_GREATER_EQUAL),
> -                                                                      VER_MINORVERSION, VER_GREATER_EQUAL),
> -                                                  VER_SERVICEPACKMAJOR, VER_GREATER_EQUAL));
> -}
> -
> -VERSIONHELPERAPI
> -IsWindowsXPOrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 0);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindowsXPSP1OrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 1);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindowsXPSP2OrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 2);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindowsXPSP3OrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 3);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindowsVistaOrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 0);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindowsVistaSP1OrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 1);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindowsVistaSP2OrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 2);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindows7OrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 0);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindows7SP1OrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32_WINNT_WIN7), 1);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindows8OrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN8), LOBYTE(_WIN32_WINNT_WIN8), 0);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindows8Point1OrGreater(void)
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINBLUE), LOBYTE(_WIN32_WINNT_WINBLUE), 0);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindows10OrGreater()
> -{
> -    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WINTHRESHOLD), LOBYTE(_WIN32_WINNT_WINTHRESHOLD), 0);
> -}
> -
> -VERSIONHELPERAPI
> -IsWindowsServer(void)
> -{
> -    OSVERSIONINFOEXW vi = {sizeof(vi), 0, 0, 0, 0, {0}, 0, 0, 0, VER_NT_WORKSTATION};
> -    return !VerifyVersionInfoW(&vi, VER_PRODUCT_TYPE, VerSetConditionMask(0, VER_PRODUCT_TYPE, VER_EQUAL));
> -}
> -
> -#endif /* if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) && !defined(__WIDL__) */
> -#endif /* ifndef _INC_VERSIONHELPERS */
> diff --git a/src/openvpn/win32.c b/src/openvpn/win32.c
> index 47eb1fc..e998d90 100644
> --- a/src/openvpn/win32.c
> +++ b/src/openvpn/win32.c
> @@ -45,11 +45,7 @@
>
>  #include "memdbg.h"
>
> -#ifdef HAVE_VERSIONHELPERS_H
>  #include <versionhelpers.h>
> -#else
> -#include "compat-versionhelpers.h"
> -#endif
>
>  #include "block_dns.h"
>
> diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
> index a47db8a..32c8996 100644
> --- a/src/openvpnserv/interactive.c
> +++ b/src/openvpnserv/interactive.c
> @@ -34,11 +34,7 @@
>  #include <shellapi.h>
>  #include <mstcpip.h>
>
> -#ifdef HAVE_VERSIONHELPERS_H
>  #include <versionhelpers.h>
> -#else
> -#include "compat-versionhelpers.h"
> -#endif
>
>  #include "openvpn-msg.h"
>  #include "validate.h"
>
> To view, visit change 445
> <http://gerrit.openvpn.net/c/openvpn/+/445?usp=email>. To unsubscribe, or
> for help writing mail filters, visit settings
> <http://gerrit.openvpn.net/settings>.
> Gerrit-Project: openvpn
> Gerrit-Branch: master
> Gerrit-Change-Id: I9c85ccab6d51064ebff2c391740ba8c2d044ed1a
> Gerrit-Change-Number: 445
> Gerrit-PatchSet: 1
> Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
> Gerrit-Reviewer: flichtenheld <frank@...2641...>
> Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
> Gerrit-Attention: flichtenheld <frank@...2641...>
> Gerrit-MessageType: newchange
> _______________________________________________
> Openvpn-devel mailing list
> Openvpn-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/openvpn-devel
>

--000000000000841f80060b8b9e86
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<div dir=3D"auto">Make is original and don&#39;t change anything to make it=
 affect please=C2=A0</div><br><div class=3D"gmail_quote"><div dir=3D"ltr" c=
lass=3D"gmail_attr">On Mon, Nov 20, 2023, 2:52 AM plaisthos (Code Review) &=
lt;<a href=3D"mailto:gerrit@...515...">gerrit@...515...</a>&gt; wrote:<br><=
/div><blockquote class=3D"gmail_quote" style=3D"margin:0 0 0 .8ex;border-le=
ft:1px #ccc solid;padding-left:1ex"><p> Attention is currently required fro=
m: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail" ta=
rget=3D"_blank" rel=3D"noreferrer">View Change</a></p><pre style=3D"font-fa=
mily:monospace,monospace;white-space:pre-wrap">Remove compat versionhelpers=
.h and remove cmake/configure check for it<br><br>The cmake file defined th=
at file to be never present in contrast to the<br>old msvc-config.h that al=
ways had it present. Also interactive.c includes<br>versionhelpers.h withou=
t the check, so we always assume it to be present<br>anyway. Remove also th=
e comapt implementation taken from mingw<br><br>Change-Id: I9c85ccab6d51064=
ebff2c391740ba8c2d044ed1a<br>---<br>M CMakeLists.txt<br>M <a href=3D"http:/=
/config.h.cmake.in" target=3D"_blank" rel=3D"noreferrer">config.h.cmake.in<=
/a><br>M <a href=3D"http://configure.ac" target=3D"_blank" rel=3D"noreferre=
r">configure.ac</a><br>M src/compat/Makefile.am<br>D src/compat/compat-vers=
ionhelpers.h<br>M src/openvpn/win32.c<br>M src/openvpnserv/interactive.c<br=
>7 files changed, 1 insertion(+), 131 deletions(-)<br><br></pre><pre style=
=3D"font-family:monospace,monospace;white-space:pre-wrap">git pull ssh://<a=
 href=3D"http://gerrit.openvpn.net:29418/openvpn" target=3D"_blank" rel=3D"=
noreferrer">gerrit.openvpn.net:29418/openvpn</a> refs/changes/45/445/1</pre=
><pre style=3D"font-family:monospace,monospace;white-space:pre-wrap"><span>=
diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index d21c9bd.=
.fa6d623 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/=
CMakeLists.txt</span><br><span>@@ -308,7 +308,6 @@</span><br><span>     src=
/compat/compat-dirname.c</span><br><span>     src/compat/compat-gettimeofda=
y.c</span><br><span>     src/compat/compat-strsep.c</span><br><span style=
=3D"color:hsl(0,100%,40%)">-    src/compat/compat-versionhelpers.h</span><b=
r><span>     src/openvpn/argv.c</span><br><span>     src/openvpn/argv.h</sp=
an><br><span>     src/openvpn/base64.c</span><br><span>diff --git a/<a href=
=3D"http://config.h.cmake.in" target=3D"_blank" rel=3D"noreferrer">config.h=
.cmake.in</a> b/<a href=3D"http://config.h.cmake.in" target=3D"_blank" rel=
=3D"noreferrer">config.h.cmake.in</a></span><br><span>index 19b79bc..8edaff=
4 100644</span><br><span>--- a/<a href=3D"http://config.h.cmake.in" target=
=3D"_blank" rel=3D"noreferrer">config.h.cmake.in</a></span><br><span>+++ b/=
<a href=3D"http://config.h.cmake.in" target=3D"_blank" rel=3D"noreferrer">c=
onfig.h.cmake.in</a></span><br><span>@@ -374,9 +374,6 @@</span><br><span> /=
* Define to 1 if you have the &lt;valgrind/memcheck.h&gt; header file. */</=
span><br><span> #undef HAVE_VALGRIND_MEMCHECK_H</span><br><span> </span><br=
><span style=3D"color:hsl(0,100%,40%)">-/* Define to 1 if you have the &lt;=
versionhelpers.h&gt; header file. */</span><br><span style=3D"color:hsl(0,1=
00%,40%)">-#undef HAVE_VERSIONHELPERS_H</span><br><span style=3D"color:hsl(=
0,100%,40%)">-</span><br><span> /* Define to 1 if you have the `vfork&#39; =
function. */</span><br><span> #undef HAVE_VFORK</span><br><span> </span><br=
><span>diff --git a/<a href=3D"http://configure.ac" target=3D"_blank" rel=
=3D"noreferrer">configure.ac</a> b/<a href=3D"http://configure.ac" target=
=3D"_blank" rel=3D"noreferrer">configure.ac</a></span><br><span>index 84eaa=
d6..94c6654 100644</span><br><span>--- a/<a href=3D"http://configure.ac" ta=
rget=3D"_blank" rel=3D"noreferrer">configure.ac</a></span><br><span>+++ b/<=
a href=3D"http://configure.ac" target=3D"_blank" rel=3D"noreferrer">configu=
re.ac</a></span><br><span>@@ -455,7 +455,6 @@</span><br><span> 	unistd.h dl=
fcn.h \</span><br><span> 	netinet/in.h \</span><br><span> 	netinet/tcp.h ar=
pa/inet.h netdb.h \</span><br><span style=3D"color:hsl(0,100%,40%)">-	versi=
onhelpers.h \</span><br><span> ])</span><br><span> AC_CHECK_HEADERS([ \</sp=
an><br><span> 	sys/time.h sys/ioctl.h sys/stat.h \</span><br><span>diff --g=
it a/src/compat/Makefile.am b/src/compat/Makefile.am</span><br><span>index =
f5de451..5298dd8 100644</span><br><span>--- a/src/compat/Makefile.am</span>=
<br><span>+++ b/src/compat/Makefile.am</span><br><span>@@ -20,5 +20,4 @@</s=
pan><br><span> 	compat-basename.c \</span><br><span> 	compat-gettimeofday.c=
 \</span><br><span> 	compat-daemon.c \</span><br><span style=3D"color:hsl(0=
,100%,40%)">-	compat-strsep.c \</span><br><span style=3D"color:hsl(0,100%,4=
0%)">-	compat-versionhelpers.h</span><br><span style=3D"color:hsl(120,100%,=
40%)">+	compat-strsep.c</span><br><span>\ No newline at end of file</span><=
br><span>diff --git a/src/compat/compat-versionhelpers.h b/src/compat/compa=
t-versionhelpers.h</span><br><span>deleted file mode 100644</span><br><span=
>index b071602..0000000</span><br><span>--- a/src/compat/compat-versionhelp=
ers.h</span><br><span>+++ /dev/null</span><br><span>@@ -1,116 +0,0 @@</span=
><br><span style=3D"color:hsl(0,100%,40%)">-/**</span><br><span style=3D"co=
lor:hsl(0,100%,40%)">- * This file is part of the mingw-w64 runtime package=
.</span><br><span style=3D"color:hsl(0,100%,40%)">- * No warranty is given;=
 refer to the file DISCLAIMER within this package.</span><br><span style=3D=
"color:hsl(0,100%,40%)">- */</span><br><span style=3D"color:hsl(0,100%,40%)=
">-</span><br><span style=3D"color:hsl(0,100%,40%)">-#ifndef _INC_VERSIONHE=
LPERS</span><br><span style=3D"color:hsl(0,100%,40%)">-#define _INC_VERSION=
HELPERS</span><br><span style=3D"color:hsl(0,100%,40%)">-</span><br><span s=
tyle=3D"color:hsl(0,100%,40%)">-#include &lt;winapifamily.h&gt;</span><br><=
span style=3D"color:hsl(0,100%,40%)">-</span><br><span style=3D"color:hsl(0=
,100%,40%)">-#if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) &amp;&am=
p; !defined(__WIDL__)</span><br><span style=3D"color:hsl(0,100%,40%)">-</sp=
an><br><span style=3D"color:hsl(0,100%,40%)">-#ifdef __cplusplus</span><br>=
<span style=3D"color:hsl(0,100%,40%)">-#define VERSIONHELPERAPI inline bool=
</span><br><span style=3D"color:hsl(0,100%,40%)">-#else</span><br><span sty=
le=3D"color:hsl(0,100%,40%)">-#define VERSIONHELPERAPI FORCEINLINE BOOL</sp=
an><br><span style=3D"color:hsl(0,100%,40%)">-#endif</span><br><span style=
=3D"color:hsl(0,100%,40%)">-</span><br><span style=3D"color:hsl(0,100%,40%)=
">-#define _WIN32_WINNT_WINBLUE    0x0603</span><br><span style=3D"color:hs=
l(0,100%,40%)">-</span><br><span style=3D"color:hsl(0,100%,40%)">-#ifndef _=
WIN32_WINNT_WINTHRESHOLD</span><br><span style=3D"color:hsl(0,100%,40%)">-#=
define _WIN32_WINNT_WINTHRESHOLD    0x0A00 /* Windows 10 */</span><br><span=
 style=3D"color:hsl(0,100%,40%)">-#endif</span><br><span style=3D"color:hsl=
(0,100%,40%)">-</span><br><span style=3D"color:hsl(0,100%,40%)">-VERSIONHEL=
PERAPI</span><br><span style=3D"color:hsl(0,100%,40%)">-IsWindowsVersionOrG=
reater(WORD major, WORD minor, WORD servpack)</span><br><span style=3D"colo=
r:hsl(0,100%,40%)">-{</span><br><span style=3D"color:hsl(0,100%,40%)">-    =
OSVERSIONINFOEXW vi =3D {sizeof(vi), major, minor, 0, 0, {0}, servpack};</s=
pan><br><span style=3D"color:hsl(0,100%,40%)">-    return VerifyVersionInfo=
W(&amp;vi, VER_MAJORVERSION|VER_MINORVERSION|VER_SERVICEPACKMAJOR,</span><b=
r><span style=3D"color:hsl(0,100%,40%)">-                              VerS=
etConditionMask(VerSetConditionMask(VerSetConditionMask(0,</span><br><span =
style=3D"color:hsl(0,100%,40%)">-                                          =
                                                VER_MAJORVERSION, VER_GREAT=
ER_EQUAL),</span><br><span style=3D"color:hsl(0,100%,40%)">-               =
                                                       VER_MINORVERSION, VE=
R_GREATER_EQUAL),</span><br><span style=3D"color:hsl(0,100%,40%)">-        =
                                          VER_SERVICEPACKMAJOR, VER_GREATER=
_EQUAL));</span><br><span style=3D"color:hsl(0,100%,40%)">-}</span><br><spa=
n style=3D"color:hsl(0,100%,40%)">-</span><br><span style=3D"color:hsl(0,10=
0%,40%)">-VERSIONHELPERAPI</span><br><span style=3D"color:hsl(0,100%,40%)">=
-IsWindowsXPOrGreater(void)</span><br><span style=3D"color:hsl(0,100%,40%)"=
>-{</span><br><span style=3D"color:hsl(0,100%,40%)">-    return IsWindowsVe=
rsionOrGreater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 0);<=
/span><br><span style=3D"color:hsl(0,100%,40%)">-}</span><br><span style=3D=
"color:hsl(0,100%,40%)">-</span><br><span style=3D"color:hsl(0,100%,40%)">-=
VERSIONHELPERAPI</span><br><span style=3D"color:hsl(0,100%,40%)">-IsWindows=
XPSP1OrGreater(void)</span><br><span style=3D"color:hsl(0,100%,40%)">-{</sp=
an><br><span style=3D"color:hsl(0,100%,40%)">-    return IsWindowsVersionOr=
Greater(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 1);</span><=
br><span style=3D"color:hsl(0,100%,40%)">-}</span><br><span style=3D"color:=
hsl(0,100%,40%)">-</span><br><span style=3D"color:hsl(0,100%,40%)">-VERSION=
HELPERAPI</span><br><span style=3D"color:hsl(0,100%,40%)">-IsWindowsXPSP2Or=
Greater(void)</span><br><span style=3D"color:hsl(0,100%,40%)">-{</span><br>=
<span style=3D"color:hsl(0,100%,40%)">-    return IsWindowsVersionOrGreater=
(HIBYTE(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 2);</span><br><spa=
n style=3D"color:hsl(0,100%,40%)">-}</span><br><span style=3D"color:hsl(0,1=
00%,40%)">-</span><br><span style=3D"color:hsl(0,100%,40%)">-VERSIONHELPERA=
PI</span><br><span style=3D"color:hsl(0,100%,40%)">-IsWindowsXPSP3OrGreater=
(void)</span><br><span style=3D"color:hsl(0,100%,40%)">-{</span><br><span s=
tyle=3D"color:hsl(0,100%,40%)">-    return IsWindowsVersionOrGreater(HIBYTE=
(_WIN32_WINNT_WINXP), LOBYTE(_WIN32_WINNT_WINXP), 3);</span><br><span style=
=3D"color:hsl(0,100%,40%)">-}</span><br><span style=3D"color:hsl(0,100%,40%=
)">-</span><br><span style=3D"color:hsl(0,100%,40%)">-VERSIONHELPERAPI</spa=
n><br><span style=3D"color:hsl(0,100%,40%)">-IsWindowsVistaOrGreater(void)<=
/span><br><span style=3D"color:hsl(0,100%,40%)">-{</span><br><span style=3D=
"color:hsl(0,100%,40%)">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32=
_WINNT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 0);</span><br><span style=3D"col=
or:hsl(0,100%,40%)">-}</span><br><span style=3D"color:hsl(0,100%,40%)">-</s=
pan><br><span style=3D"color:hsl(0,100%,40%)">-VERSIONHELPERAPI</span><br><=
span style=3D"color:hsl(0,100%,40%)">-IsWindowsVistaSP1OrGreater(void)</spa=
n><br><span style=3D"color:hsl(0,100%,40%)">-{</span><br><span style=3D"col=
or:hsl(0,100%,40%)">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WIN=
NT_VISTA), LOBYTE(_WIN32_WINNT_VISTA), 1);</span><br><span style=3D"color:h=
sl(0,100%,40%)">-}</span><br><span style=3D"color:hsl(0,100%,40%)">-</span>=
<br><span style=3D"color:hsl(0,100%,40%)">-VERSIONHELPERAPI</span><br><span=
 style=3D"color:hsl(0,100%,40%)">-IsWindowsVistaSP2OrGreater(void)</span><b=
r><span style=3D"color:hsl(0,100%,40%)">-{</span><br><span style=3D"color:h=
sl(0,100%,40%)">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_V=
ISTA), LOBYTE(_WIN32_WINNT_VISTA), 2);</span><br><span style=3D"color:hsl(0=
,100%,40%)">-}</span><br><span style=3D"color:hsl(0,100%,40%)">-</span><br>=
<span style=3D"color:hsl(0,100%,40%)">-VERSIONHELPERAPI</span><br><span sty=
le=3D"color:hsl(0,100%,40%)">-IsWindows7OrGreater(void)</span><br><span sty=
le=3D"color:hsl(0,100%,40%)">-{</span><br><span style=3D"color:hsl(0,100%,4=
0%)">-    return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYT=
E(_WIN32_WINNT_WIN7), 0);</span><br><span style=3D"color:hsl(0,100%,40%)">-=
}</span><br><span style=3D"color:hsl(0,100%,40%)">-</span><br><span style=
=3D"color:hsl(0,100%,40%)">-VERSIONHELPERAPI</span><br><span style=3D"color=
:hsl(0,100%,40%)">-IsWindows7SP1OrGreater(void)</span><br><span style=3D"co=
lor:hsl(0,100%,40%)">-{</span><br><span style=3D"color:hsl(0,100%,40%)">-  =
  return IsWindowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN7), LOBYTE(_WIN32=
_WINNT_WIN7), 1);</span><br><span style=3D"color:hsl(0,100%,40%)">-}</span>=
<br><span style=3D"color:hsl(0,100%,40%)">-</span><br><span style=3D"color:=
hsl(0,100%,40%)">-VERSIONHELPERAPI</span><br><span style=3D"color:hsl(0,100=
%,40%)">-IsWindows8OrGreater(void)</span><br><span style=3D"color:hsl(0,100=
%,40%)">-{</span><br><span style=3D"color:hsl(0,100%,40%)">-    return IsWi=
ndowsVersionOrGreater(HIBYTE(_WIN32_WINNT_WIN8), LOBYTE(_WIN32_WINNT_WIN8),=
 0);</span><br><span style=3D"color:hsl(0,100%,40%)">-}</span><br><span sty=
le=3D"color:hsl(0,100%,40%)">-</span><br><span style=3D"color:hsl(0,100%,40=
%)">-VERSIONHELPERAPI</span><br><span style=3D"color:hsl(0,100%,40%)">-IsWi=
ndows8Point1OrGreater(void)</span><br><span style=3D"color:hsl(0,100%,40%)"=
>-{</span><br><span style=3D"color:hsl(0,100%,40%)">-    return IsWindowsVe=
rsionOrGreater(HIBYTE(_WIN32_WINNT_WINBLUE), LOBYTE(_WIN32_WINNT_WINBLUE), =
0);</span><br><span style=3D"color:hsl(0,100%,40%)">-}</span><br><span styl=
e=3D"color:hsl(0,100%,40%)">-</span><br><span style=3D"color:hsl(0,100%,40%=
)">-VERSIONHELPERAPI</span><br><span style=3D"color:hsl(0,100%,40%)">-IsWin=
dows10OrGreater()</span><br><span style=3D"color:hsl(0,100%,40%)">-{</span>=
<br><span style=3D"color:hsl(0,100%,40%)">-    return IsWindowsVersionOrGre=
ater(HIBYTE(_WIN32_WINNT_WINTHRESHOLD), LOBYTE(_WIN32_WINNT_WINTHRESHOLD), =
0);</span><br><span style=3D"color:hsl(0,100%,40%)">-}</span><br><span styl=
e=3D"color:hsl(0,100%,40%)">-</span><br><span style=3D"color:hsl(0,100%,40%=
)">-VERSIONHELPERAPI</span><br><span style=3D"color:hsl(0,100%,40%)">-IsWin=
dowsServer(void)</span><br><span style=3D"color:hsl(0,100%,40%)">-{</span><=
br><span style=3D"color:hsl(0,100%,40%)">-    OSVERSIONINFOEXW vi =3D {size=
of(vi), 0, 0, 0, 0, {0}, 0, 0, 0, VER_NT_WORKSTATION};</span><br><span styl=
e=3D"color:hsl(0,100%,40%)">-    return !VerifyVersionInfoW(&amp;vi, VER_PR=
ODUCT_TYPE, VerSetConditionMask(0, VER_PRODUCT_TYPE, VER_EQUAL));</span><br=
><span style=3D"color:hsl(0,100%,40%)">-}</span><br><span style=3D"color:hs=
l(0,100%,40%)">-</span><br><span style=3D"color:hsl(0,100%,40%)">-#endif /*=
 if WINAPI_FAMILY_PARTITION(WINAPI_PARTITION_DESKTOP) &amp;&amp; !defined(_=
_WIDL__) */</span><br><span style=3D"color:hsl(0,100%,40%)">-#endif /* ifnd=
ef _INC_VERSIONHELPERS */</span><br><span>diff --git a/src/openvpn/win32.c =
b/src/openvpn/win32.c</span><br><span>index 47eb1fc..e998d90 100644</span><=
br><span>--- a/src/openvpn/win32.c</span><br><span>+++ b/src/openvpn/win32.=
c</span><br><span>@@ -45,11 +45,7 @@</span><br><span> </span><br><span> #in=
clude &quot;memdbg.h&quot;</span><br><span> </span><br><span style=3D"color=
:hsl(0,100%,40%)">-#ifdef HAVE_VERSIONHELPERS_H</span><br><span> #include &=
lt;versionhelpers.h&gt;</span><br><span style=3D"color:hsl(0,100%,40%)">-#e=
lse</span><br><span style=3D"color:hsl(0,100%,40%)">-#include &quot;compat-=
versionhelpers.h&quot;</span><br><span style=3D"color:hsl(0,100%,40%)">-#en=
dif</span><br><span> </span><br><span> #include &quot;block_dns.h&quot;</sp=
an><br><span> </span><br><span>diff --git a/src/openvpnserv/interactive.c b=
/src/openvpnserv/interactive.c</span><br><span>index a47db8a..32c8996 10064=
4</span><br><span>--- a/src/openvpnserv/interactive.c</span><br><span>+++ b=
/src/openvpnserv/interactive.c</span><br><span>@@ -34,11 +34,7 @@</span><br=
><span> #include &lt;shellapi.h&gt;</span><br><span> #include &lt;mstcpip.h=
&gt;</span><br><span> </span><br><span style=3D"color:hsl(0,100%,40%)">-#if=
def HAVE_VERSIONHELPERS_H</span><br><span> #include &lt;versionhelpers.h&gt=
;</span><br><span style=3D"color:hsl(0,100%,40%)">-#else</span><br><span st=
yle=3D"color:hsl(0,100%,40%)">-#include &quot;compat-versionhelpers.h&quot;=
</span><br><span style=3D"color:hsl(0,100%,40%)">-#endif</span><br><span> <=
/span><br><span> #include &quot;openvpn-msg.h&quot;</span><br><span> #inclu=
de &quot;validate.h&quot;</span><br><span></span><br></pre><p>To view, visi=
t <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/445?usp=3Demail" target=
=3D"_blank" rel=3D"noreferrer">change 445</a>. To unsubscribe, or for help =
writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/settings" =
target=3D"_blank" rel=3D"noreferrer">settings</a>.</p><div><div></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I9c85ccab6d51064ebff2c391740=
ba8c2d044ed1a </div>
<div style=3D"display:none"> Gerrit-Change-Number: 445 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 1 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;<a href=3D"mailto:=
arne-openvpn@...1227..." target=3D"_blank" rel=3D"noreferrer">arne-openvpn@=
...1227...</a>&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;<a href=3D"m=
ailto:frank@...2641..." target=3D"_blank" rel=3D"noreferrer">frank@...2724...=
..</a>&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;<a href=3D"mailto=
:openvpn-devel@lists.sourceforge.net" target=3D"_blank" rel=3D"noreferrer">=
openvpn-devel@lists.sourceforge.net</a>&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;<a href=3D"=
mailto:frank@...2641..." target=3D"_blank" rel=3D"noreferrer">frank@...2746...=
...</a>&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newchange </div>

_______________________________________________<br>
Openvpn-devel mailing list<br>
<a href=3D"mailto:Openvpn-devel@lists.sourceforge.net" target=3D"_blank" re=
l=3D"noreferrer">Openvpn-devel@lists.sourceforge.net</a><br>
<a href=3D"https://lists.sourceforge.net/lists/listinfo/openvpn-devel" rel=
=3D"noreferrer noreferrer" target=3D"_blank">https://lists.sourceforge.net/=
lists/listinfo/openvpn-devel</a><br>
</blockquote></div>

--000000000000841f80060b8b9e86--

