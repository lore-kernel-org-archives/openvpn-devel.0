From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 16:54:15 +0000
References: <gerrit.1764176048000.I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <9f4950d8214f0b8a6d826323d87f2e645f87ee9e-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="kQ4m4GnGuVk="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: configure/CMake:
 Remove unused checks
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

--kQ4m4GnGuVk=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1409?usp=3Demail

to review the following change.


Change subject: configure/CMake: Remove unused checks
......................................................................

configure/CMake: Remove unused checks

Do not run configure checks that we do not
actually need.

But add one missing check in CMake for strsep!

Change-Id: I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
3 files changed, 5 insertions(+), 31 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1409/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index c4d50e4..f101a1b 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -240,6 +240,7 @@

 check_symbol_exists(chsize io.h HAVE_CHSIZE)
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)
+check_symbol_exists(strsep string.h HAVE_STRSEP)

 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
diff --git a/config.h.cmake.in b/config.h.cmake.in
index bf1899c..f68ea27 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -281,9 +281,6 @@
 /* Define to 1 if you have the <syslog.h> header file. */
 #cmakedefine HAVE_SYSLOG_H

-/* Define to 1 if you have the `system' function. */
-#undef HAVE_SYSTEM
-
 /* Define to 1 if you have the <systemd/sd-daemon.h> header file. */
 #undef HAVE_SYSTEMD_SD_DAEMON_H

@@ -332,12 +329,6 @@
 /* Define to 1 if you have the <tap-windows.h> header file. */
 #undef HAVE_TAP_WINDOWS_H

-/* Define to 1 if you have the `time' function. */
-#define HAVE_TIME 1
-
-/* Define to 1 if you have the <time.h> header file. */
-#define HAVE_TIME_H 1
-
 /* Define to 1 if you have the <uapi.h> header file. */
 #undef HAVE_UAPI_H

@@ -347,12 +338,6 @@
 /* Define to 1 if you have the <valgrind/memcheck.h> header file. */
 #undef HAVE_VALGRIND_MEMCHECK_H

-/* Define to 1 if you have the `vfork' function. */
-#undef HAVE_VFORK
-
-/* Define to 1 if you have the <vfork.h> header file. */
-#undef HAVE_VFORK_H
-
 /* Availability of different mbed TLS features and APIs */
 #cmakedefine HAVE_PSA_CRYPTO_H
 #cmakedefine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB
diff --git a/configure.ac b/configure.ac
index 030f8de..60799e0 100644
--- a/configure.ac
+++ b/configure.ac
@@ -475,13 +475,7 @@
 )

 AC_C_INLINE
-AC_TYPE_OFF_T
-AC_TYPE_PID_T
-AC_TYPE_SIZE_T
-AC_TYPE_UID_T
 AX_TYPE_SOCKLEN_T
-AC_CHECK_SIZEOF([unsigned int])
-AC_CHECK_SIZEOF([unsigned long])
 AC_CHECK_HEADERS([ \
 	fcntl.h io.h \
 	sys/types.h sys/socket.h \
@@ -492,7 +486,7 @@
 AC_CHECK_HEADERS([ \
 	sys/time.h sys/ioctl.h sys/stat.h \
 	sys/mman.h sys/file.h sys/wait.h \
-	unistd.h libgen.h stropts.h \
+	libgen.h stropts.h \
 	syslog.h pwd.h grp.h termios.h \
 	sys/sockio.h sys/uio.h \
 	poll.h sys/epoll.h err.h \
@@ -546,12 +540,6 @@
 	[[${SOCKET_INCLUDES}]]
 )
 AC_CHECK_TYPE(
-	[struct iphdr],
-	[AC_DEFINE([HAVE_IPHDR], [1], [struct iphdr needed for IPv6 support])],
-	,
-	[[${SOCKET_INCLUDES}]]
-)
-AC_CHECK_TYPE(
 	[struct msghdr],
 	[AC_DEFINE([HAVE_MSGHDR], [1], [struct msghdr needed for extended socket =
error support])],
 	,
@@ -657,11 +645,11 @@
 AC_FUNC_FORK

 AC_CHECK_FUNCS([ \
-	daemon chroot getpwnam setuid nice system dup dup2 \
+	daemon chroot getpwnam setuid nice dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setgroups flock time gettimeofday \
+	setgroups flock gettimeofday \
 	setsid chdir \
-	chsize ftruncate execve getpeereid basename dirname access \
+	chsize ftruncate execve getpeereid basename dirname \
 	epoll_create strsep \
 ])


--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1409?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20
Gerrit-Change-Number: 1409
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--kQ4m4GnGuVk=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1409?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">configure/CMake: Remove unused checks<br><b=
r>Do not run configure checks that we do not<br>actually need.<br><br>But a=
dd one missing check in CMake for strsep!<br><br>Change-Id: I0da2cc8bbe9e39=
4d1bb55cff496ea3e11584ca20<br>Signed-off-by: Frank Lichtenheld &lt;frank@...1186...=
.2641...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.cmake.in<br>M configu=
re.ac<br>3 files changed, 5 insertions(+), 31 deletions(-)<br><br></pre><pr=
e class=3D"blocks" style=3D"font-family: monospace,monospace; white-space: =
pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/=
1409/1</pre><pre style=3D"font-family: monospace,monospace; white-space: pr=
e-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span=
>index c4d50e4..f101a1b 100644</span><br><span>--- a/CMakeLists.txt</span><=
br><span>+++ b/CMakeLists.txt</span><br><span>@@ -240,6 +240,7 @@</span><br=
><span> </span><br><span> check_symbol_exists(chsize io.h HAVE_CHSIZE)</spa=
n><br><span> check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(s=
trsep string.h HAVE_STRSEP)</span><br><span> </span><br><span> # Some OS (e=
.g. FreeBSD) need some basic headers to allow</span><br><span> # including =
network headers</span><br><span>diff --git a/config.h.cmake.in b/config.h.c=
make.in</span><br><span>index bf1899c..f68ea27 100644</span><br><span>--- a=
/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>=
@@ -281,9 +281,6 @@</span><br><span> /* Define to 1 if you have the &lt;sys=
log.h&gt; header file. */</span><br><span> #cmakedefine HAVE_SYSLOG_H</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define=
 to 1 if you have the `system&#39; function. */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#undef HAVE_SYSTEM</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span> /* Define to 1 if you have the &lt=
;systemd/sd-daemon.h&gt; header file. */</span><br><span> #undef HAVE_SYSTE=
MD_SD_DAEMON_H</span><br><span> </span><br><span>@@ -332,12 +329,6 @@</span=
><br><span> /* Define to 1 if you have the &lt;tap-windows.h&gt; header fil=
e. */</span><br><span> #undef HAVE_TAP_WINDOWS_H</span><br><span> </span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the=
 `time&#39; function. */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define HAVE_TIME 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if yo=
u have the &lt;time.h&gt; header file. */</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-#define HAVE_TIME_H 1</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-</span><br><span> /* Define to 1 if you have the &lt;ua=
pi.h&gt; header file. */</span><br><span> #undef HAVE_UAPI_H</span><br><spa=
n> </span><br><span>@@ -347,12 +338,6 @@</span><br><span> /* Define to 1 if=
 you have the &lt;valgrind/memcheck.h&gt; header file. */</span><br><span> =
#undef HAVE_VALGRIND_MEMCHECK_H</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the `vfork&#39; func=
tion. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_V=
FORK</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;vfo=
rk.h&gt; header file. */</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#undef HAVE_VFORK_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-</span><br><span> /* Availability of different mbed TLS features and APIs =
*/</span><br><span> #cmakedefine HAVE_PSA_CRYPTO_H</span><br><span> #cmaked=
efine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><span>diff --git a/conf=
igure.ac b/configure.ac</span><br><span>index 030f8de..60799e0 100644</span=
><br><span>--- a/configure.ac</span><br><span>+++ b/configure.ac</span><br>=
<span>@@ -475,13 +475,7 @@</span><br><span> )</span><br><span> </span><br><=
span> AC_C_INLINE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_T=
YPE_OFF_T</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_TYPE_PID_=
T</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_TYPE_SIZE_T</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_TYPE_UID_T</span><br><sp=
an> AX_TYPE_SOCKLEN_T</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
AC_CHECK_SIZEOF([unsigned int])</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-AC_CHECK_SIZEOF([unsigned long])</span><br><span> AC_CHECK_HEADER=
S([ \</span><br><span> 	fcntl.h io.h \</span><br><span> 	sys/types.h sys/so=
cket.h \</span><br><span>@@ -492,7 +486,7 @@</span><br><span> AC_CHECK_HEAD=
ERS([ \</span><br><span> 	sys/time.h sys/ioctl.h sys/stat.h \</span><br><sp=
an> 	sys/mman.h sys/file.h sys/wait.h \</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-	unistd.h libgen.h stropts.h \</span><br><span style=3D"c=
olor: hsl(120, 100%, 40%);">+	libgen.h stropts.h \</span><br><span> 	syslog=
.h pwd.h grp.h termios.h \</span><br><span> 	sys/sockio.h sys/uio.h \</span=
><br><span> 	poll.h sys/epoll.h err.h \</span><br><span>@@ -546,12 +540,6 @=
@</span><br><span> 	[[${SOCKET_INCLUDES}]]</span><br><span> )</span><br><sp=
an> AC_CHECK_TYPE(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[s=
truct iphdr],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC_DEF=
INE([HAVE_IPHDR], [1], [struct iphdr needed for IPv6 support])],</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	[[${SOCKET_INCLUDES}]]</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-)</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-AC_CHECK_TYPE(</span><br><span> 	[struct msghdr],</span><br><span> 	[=
AC_DEFINE([HAVE_MSGHDR], [1], [struct msghdr needed for extended socket err=
or support])],</span><br><span> 	,</span><br><span>@@ -657,11 +645,11 @@</s=
pan><br><span> AC_FUNC_FORK</span><br><span> </span><br><span> AC_CHECK_FUN=
CS([ \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	daemon chroot =
getpwnam setuid nice system dup dup2 \</span><br><span style=3D"color: hsl(=
120, 100%, 40%);">+	daemon chroot getpwnam setuid nice dup dup2 \</span><br=
><span> 	syslog openlog mlockall getrlimit getgrnam setgid \</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-	setgroups flock time gettimeofday \=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	setgroups flock ge=
ttimeofday \</span><br><span> 	setsid chdir \</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	chsize ftruncate execve getpeereid basename dirnam=
e access \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	chsize f=
truncate execve getpeereid basename dirname \</span><br><span> 	epoll_creat=
e strsep \</span><br><span> ])</span><br><span> </span><br><span></span><br=
></pre><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1=
409?usp=3Demail">change 1409</a>. To unsubscribe, or for help writing mail =
filters, visit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">s=
ettings</a>.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage">=
<div itemscope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction=
"><link itemprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1409=
?usp=3Demail"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0da2cc8bbe9e394d1bb55cff496=
ea3e11584ca20 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1409 </div>
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

--kQ4m4GnGuVk=--

