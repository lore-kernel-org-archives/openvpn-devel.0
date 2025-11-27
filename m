From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Nov 2025 11:20:16 +0000
In-Reply-To: <gerrit.1764176048000.I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20@...2715...>
References: <gerrit.1764176048000.I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <73b7293a1f5a253029fbd42f9a30c1adfcd225e8-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UTa3/DXQ4IE="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>
Cc: plaisthos <arne-openvpn@...1227...>, openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UTa3/DXQ4IE=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has submitted this change. ( http://gerrit.openvpn.net/c/openvpn/+/14=
09?usp=3Demail )

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

Gerrit-MessageType: merged
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: I0da2cc8bbe9e394d1bb55cff496ea3e11584ca20
Gerrit-Change-Number: 1409
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--UTa3/DXQ4IE=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>sub=
mitted</strong> this change.</p><p><a href=3D"http://gerrit.openvpn.net/c/o=
penvpn/+/1409?usp=3Demail">View Change</a></p><div style=3D"white-space:pre=
-wrap"></div><pre class=3D"blocks" style=3D"font-family: monospace,monospac=
e; white-space: pre-wrap;">configure/CMake: Remove unused checks<br><br>Do =
not run configure checks that we do not<br>actually need.<br><br>But add on=
e missing check in CMake for strsep!<br><br>Change-Id: I0da2cc8bbe9e394d1bb=
55cff496ea3e11584ca20<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2746...=
...&gt;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: ht=
tps://gerrit.openvpn.net/c/openvpn/+/1409<br>Message-Id: &lt;20251127105343=
.30723-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-d=
evel@lists.sourceforge.net/msg34740.html<br>Signed-off-by: Gert Doering &lt=
;gert@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.cmake.in<br>M=
 configure.ac<br>3 files changed, 5 insertions(+), 31 deletions(-)<br><br><=
/pre>
<pre style=3D"font-family: monospace,monospace; white-space: pre-wrap;"><sp=
an>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index c4d50=
e4..f101a1b 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++=
 b/CMakeLists.txt</span><br><span>@@ -240,6 +240,7 @@</span><br><span> </sp=
an><br><span> check_symbol_exists(chsize io.h HAVE_CHSIZE)</span><br><span>=
 check_symbol_exists(getrlimit sys/resource.h HAVE_GETRLIMIT)</span><br><sp=
an style=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(strsep string=
.h HAVE_STRSEP)</span><br><span> </span><br><span> # Some OS (e.g. FreeBSD)=
 need some basic headers to allow</span><br><span> # including network head=
ers</span><br><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</spa=
n><br><span>index bf1899c..f68ea27 100644</span><br><span>--- a/config.h.cm=
ake.in</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -281,9 +2=
81,6 @@</span><br><span> /* Define to 1 if you have the &lt;syslog.h&gt; he=
ader file. */</span><br><span> #cmakedefine HAVE_SYSLOG_H</span><br><span> =
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you=
 have the `system&#39; function. */</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-#undef HAVE_SYSTEM</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-</span><br><span> /* Define to 1 if you have the &lt;systemd/sd-=
daemon.h&gt; header file. */</span><br><span> #undef HAVE_SYSTEMD_SD_DAEMON=
_H</span><br><span> </span><br><span>@@ -332,12 +329,6 @@</span><br><span> =
/* Define to 1 if you have the &lt;tap-windows.h&gt; header file. */</span>=
<br><span> #undef HAVE_TAP_WINDOWS_H</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the `time&#39; =
function. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define H=
AVE_TIME 1</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &=
lt;time.h&gt; header file. */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define HAVE_TIME_H 1</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-</span><br><span> /* Define to 1 if you have the &lt;uapi.h&gt; hea=
der file. */</span><br><span> #undef HAVE_UAPI_H</span><br><span> </span><b=
r><span>@@ -347,12 +338,6 @@</span><br><span> /* Define to 1 if you have th=
e &lt;valgrind/memcheck.h&gt; header file. */</span><br><span> #undef HAVE_=
VALGRIND_MEMCHECK_H</span><br><span> </span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-/* Define to 1 if you have the `vfork&#39; function. */</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_VFORK</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"col=
or: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;vfork.h&gt; hea=
der file. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef HA=
VE_VFORK_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br>=
<span> /* Availability of different mbed TLS features and APIs */</span><br=
><span> #cmakedefine HAVE_PSA_CRYPTO_H</span><br><span> #cmakedefine HAVE_M=
BEDTLS_SSL_SET_EXPORT_KEYS_CB</span><br><span>diff --git a/configure.ac b/c=
onfigure.ac</span><br><span>index 030f8de..60799e0 100644</span><br><span>-=
-- a/configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -47=
5,13 +475,7 @@</span><br><span> )</span><br><span> </span><br><span> AC_C_I=
NLINE</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_TYPE_OFF_T</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_TYPE_PID_T</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-AC_TYPE_SIZE_T</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-AC_TYPE_UID_T</span><br><span> AX_TYPE_=
SOCKLEN_T</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_CHECK_SIZ=
EOF([unsigned int])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC=
_CHECK_SIZEOF([unsigned long])</span><br><span> AC_CHECK_HEADERS([ \</span>=
<br><span> 	fcntl.h io.h \</span><br><span> 	sys/types.h sys/socket.h \</sp=
an><br><span>@@ -492,7 +486,7 @@</span><br><span> AC_CHECK_HEADERS([ \</spa=
n><br><span> 	sys/time.h sys/ioctl.h sys/stat.h \</span><br><span> 	sys/mma=
n.h sys/file.h sys/wait.h \</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	unistd.h libgen.h stropts.h \</span><br><span style=3D"color: hsl(12=
0, 100%, 40%);">+	libgen.h stropts.h \</span><br><span> 	syslog.h pwd.h grp=
.h termios.h \</span><br><span> 	sys/sockio.h sys/uio.h \</span><br><span> =
	poll.h sys/epoll.h err.h \</span><br><span>@@ -546,12 +540,6 @@</span><br>=
<span> 	[[${SOCKET_INCLUDES}]]</span><br><span> )</span><br><span> AC_CHECK=
_TYPE(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[struct iphdr]=
,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC_DEFINE([HAVE_IP=
HDR], [1], [struct iphdr needed for IPv6 support])],</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	[[${SOCKET_INCLUDES}]]</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_CH=
ECK_TYPE(</span><br><span> 	[struct msghdr],</span><br><span> 	[AC_DEFINE([=
HAVE_MSGHDR], [1], [struct msghdr needed for extended socket error support]=
)],</span><br><span> 	,</span><br><span>@@ -657,11 +645,11 @@</span><br><sp=
an> AC_FUNC_FORK</span><br><span> </span><br><span> AC_CHECK_FUNCS([ \</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-	daemon chroot getpwnam se=
tuid nice system dup dup2 \</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+	daemon chroot getpwnam setuid nice dup dup2 \</span><br><span> 	sy=
slog openlog mlockall getrlimit getgrnam setgid \</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-	setgroups flock time gettimeofday \</span><br>=
<span style=3D"color: hsl(120, 100%, 40%);">+	setgroups flock gettimeofday =
\</span><br><span> 	setsid chdir \</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-	chsize ftruncate execve getpeereid basename dirname access \<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+	chsize ftruncate ex=
ecve getpeereid basename dirname \</span><br><span> 	epoll_create strsep \<=
/span><br><span> ])</span><br><span> </span><br><span></span><br></pre><p>T=
o view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1409?usp=3De=
mail">change 1409</a>. To unsubscribe, or for help writing mail filters, vi=
sit <a href=3D"http://gerrit.openvpn.net/settings?usp=3Demail">settings</a>=
.</p><div itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemsc=
ope itemprop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link ite=
mprop=3D"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/1409?usp=3Demai=
l"/><meta itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: merged </div>
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

--UTa3/DXQ4IE=--

