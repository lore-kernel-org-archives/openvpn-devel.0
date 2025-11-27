From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Nov 2025 11:20:12 +0000
In-Reply-To: <gerrit.1764176048000.I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20@...2715...>
References: <gerrit.1764176048000.I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <73b7293a1f5a253029fbd42f9a30c1adfcd225e8-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="zNR1ypsyVMw="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zNR1ypsyVMw=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1409?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: configure/CMake: Remove unused checks
......................................................................

configure/CMake: Remove unused checks

Do not run configure checks that we do not
actually need.

But add one missing check in CMake for strsep!

Change-Id: I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1409
Message-Id: <20251127105343.30723-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
740.html
Signed-off-by: Gert Doering <gert@...1296...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
3 files changed, 5 insertions(+), 31 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/09/1409/3

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

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20
Gerrit-Change-Number: 1409
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--zNR1ypsyVMw=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1409?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">configure/CMake: Remove unused chec=
ks<br><br>Do not run configure checks that we do not<br>actually need.<br><=
br>But add one missing check in CMake for strsep!<br><br>Change-Id: I0da2cc=
8bbe9e394d1bb55cff496ea3e11584ca20<br>Signed-off-by: Frank Lichtenheld &lt;=
frank@...2641...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>G=
errit URL: https://gerrit.openvpn.net/c/openvpn/+/1409<br>Message-Id: &lt;2=
0251127105343.30723-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.=
com/openvpn-devel@lists.sourceforge.net/msg34740.html<br>Signed-off-by: Ger=
t Doering &lt;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.=
cmake.in<br>M configure.ac<br>3 files changed, 5 insertions(+), 31 deletion=
s(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/ope=
nvpn refs/changes/09/1409/3</pre><pre style=3D"font-family: monospace,monos=
pace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeList=
s.txt</span><br><span>index c4d50e4..f101a1b 100644</span><br><span>--- a/C=
MakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -240,=
6 +240,7 @@</span><br><span> </span><br><span> check_symbol_exists(chsize i=
o.h HAVE_CHSIZE)</span><br><span> check_symbol_exists(getrlimit sys/resourc=
e.h HAVE_GETRLIMIT)</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
check_symbol_exists(strsep string.h HAVE_STRSEP)</span><br><span> </span><b=
r><span> # Some OS (e.g. FreeBSD) need some basic headers to allow</span><b=
r><span> # including network headers</span><br><span>diff --git a/config.h.=
cmake.in b/config.h.cmake.in</span><br><span>index bf1899c..f68ea27 100644<=
/span><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmak=
e.in</span><br><span>@@ -281,9 +281,6 @@</span><br><span> /* Define to 1 if=
 you have the &lt;syslog.h&gt; header file. */</span><br><span> #cmakedefin=
e HAVE_SYSLOG_H</span><br><span> </span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-/* Define to 1 if you have the `system&#39; function. */</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_SYSTEM</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Define to =
1 if you have the &lt;systemd/sd-daemon.h&gt; header file. */</span><br><sp=
an> #undef HAVE_SYSTEMD_SD_DAEMON_H</span><br><span> </span><br><span>@@ -3=
32,12 +329,6 @@</span><br><span> /* Define to 1 if you have the &lt;tap-win=
dows.h&gt; header file. */</span><br><span> #undef HAVE_TAP_WINDOWS_H</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define=
 to 1 if you have the `time&#39; function. */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define HAVE_TIME 1</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-/* Define to 1 if you have the &lt;time.h&gt; header file. */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_TIME_H 1</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Define to 1 i=
f you have the &lt;uapi.h&gt; header file. */</span><br><span> #undef HAVE_=
UAPI_H</span><br><span> </span><br><span>@@ -347,12 +338,6 @@</span><br><sp=
an> /* Define to 1 if you have the &lt;valgrind/memcheck.h&gt; header file.=
 */</span><br><span> #undef HAVE_VALGRIND_MEMCHECK_H</span><br><span> </spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have=
 the `vfork&#39; function. */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#undef HAVE_VFORK</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if=
 you have the &lt;vfork.h&gt; header file. */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#undef HAVE_VFORK_H</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> /* Availability of different mbed T=
LS features and APIs */</span><br><span> #cmakedefine HAVE_PSA_CRYPTO_H</sp=
an><br><span> #cmakedefine HAVE_MBEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><s=
pan>diff --git a/configure.ac b/configure.ac</span><br><span>index 030f8de.=
.60799e0 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/co=
nfigure.ac</span><br><span>@@ -475,13 +475,7 @@</span><br><span> )</span><b=
r><span> </span><br><span> AC_C_INLINE</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-AC_TYPE_OFF_T</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-AC_TYPE_PID_T</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-AC_TYPE_SIZE_T</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_TYP=
E_UID_T</span><br><span> AX_TYPE_SOCKLEN_T</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-AC_CHECK_SIZEOF([unsigned int])</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-AC_CHECK_SIZEOF([unsigned long])</span><br>=
<span> AC_CHECK_HEADERS([ \</span><br><span> 	fcntl.h io.h \</span><br><spa=
n> 	sys/types.h sys/socket.h \</span><br><span>@@ -492,7 +486,7 @@</span><b=
r><span> AC_CHECK_HEADERS([ \</span><br><span> 	sys/time.h sys/ioctl.h sys/=
stat.h \</span><br><span> 	sys/mman.h sys/file.h sys/wait.h \</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-	unistd.h libgen.h stropts.h \</spa=
n><br><span style=3D"color: hsl(120, 100%, 40%);">+	libgen.h stropts.h \</s=
pan><br><span> 	syslog.h pwd.h grp.h termios.h \</span><br><span> 	sys/sock=
io.h sys/uio.h \</span><br><span> 	poll.h sys/epoll.h err.h \</span><br><sp=
an>@@ -546,12 +540,6 @@</span><br><span> 	[[${SOCKET_INCLUDES}]]</span><br>=
<span> )</span><br><span> AC_CHECK_TYPE(</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-	[struct iphdr],</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-	[AC_DEFINE([HAVE_IPHDR], [1], [struct iphdr needed for IPv6 =
support])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	,</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	[[${SOCKET_INCLUDES}]]</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-)</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-AC_CHECK_TYPE(</span><br><span> 	[struct msghdr=
],</span><br><span> 	[AC_DEFINE([HAVE_MSGHDR], [1], [struct msghdr needed f=
or extended socket error support])],</span><br><span> 	,</span><br><span>@@=
 -657,11 +645,11 @@</span><br><span> AC_FUNC_FORK</span><br><span> </span><=
br><span> AC_CHECK_FUNCS([ \</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-	daemon chroot getpwnam setuid nice system dup dup2 \</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+	daemon chroot getpwnam setuid nic=
e dup dup2 \</span><br><span> 	syslog openlog mlockall getrlimit getgrnam s=
etgid \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	setgroups flo=
ck time gettimeofday \</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+	setgroups flock gettimeofday \</span><br><span> 	setsid chdir \</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-	chsize ftruncate execve getp=
eereid basename dirname access \</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+	chsize ftruncate execve getpeereid basename dirname \</span><=
br><span> 	epoll_create strsep \</span><br><span> ])</span><br><span> </spa=
n><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit.ope=
nvpn.net/c/openvpn/+/1409?usp=3Demail">change 1409</a>. To unsubscribe, or =
for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.net/s=
ettings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http://sch=
ema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"http:/=
/schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.openvp=
n.net/c/openvpn/+/1409?usp=3Demail"/><meta itemprop=3D"name" content=3D"Vie=
w Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: I0da2cc8bbe9e394d1bb55cff496=
ea3e11584ca20 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1409 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 3 </div>
<div style=3D"display:none"> Gerrit-Owner: flichtenheld &lt;frank@...2723...=
.&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: cron2 &lt;gert@...1296...&gt;=
 </div>
<div style=3D"display:none"> Gerrit-Reviewer: plaisthos &lt;arne-openvpn@...1186...=
.1227...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>

</body></html>=

--zNR1ypsyVMw=--

