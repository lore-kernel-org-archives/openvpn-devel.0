From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Wed, 29 Nov 2023 12:34:22 +0000
In-Reply-To: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
References: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <ab5017fb578cf6a29d4b5069f842e3a26027ba96-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="0eQUTqBKDbQ="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove
 unused/unneeded/add missing defines from configure/cmake
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

--0eQUTqBKDbQ=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,=20

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail

to look at the new patch set (#5).


Change subject: Remove unused/unneeded/add missing defines from configure/c=
make
......................................................................

Remove unused/unneeded/add missing defines from configure/cmake

Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021
Signed-off-by: Arne Schwabe <arne@...1227...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
3 files changed, 3 insertions(+), 7 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/443/5

diff --git a/CMakeLists.txt b/CMakeLists.txt
index d21c9bd..4aa9793 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -167,6 +167,7 @@
 check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)
 check_symbol_exists(getpwnam pwd.h HAVE_GETPWNAM)
 check_symbol_exists(getsockname sys/socket.h HAVE_GETSOCKNAME)
+check_symbol_exists(getrlimit "sys/time.h;sys/resource.h" HAVE_GETRLIMIT)

 # Some OS (e.g. FreeBSD) need some basic headers to allow
 # including network headers
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 19b79bc..848c505 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -140,7 +140,7 @@
 #cmakedefine HAVE_GETPWNAM

 /* Define to 1 if you have the `getrlimit' function. */
-#undef HAVE_GETRLIMIT
+#cmakedefine HAVE_GETRLIMIT

 /* Define to 1 if you have the `getsockname' function. */
 #cmakedefine HAVE_GETSOCKNAME
@@ -235,8 +235,6 @@
 /* Define to 1 if you have the <pwd.h> header file. */
 #cmakedefine HAVE_PWD_H

-/* Define to 1 if you have the `readv' function. */
-#undef HAVE_READV

 /* Define to 1 if you have the `recvmsg' function. */
 #cmakedefine HAVE_RECVMSG
@@ -383,9 +381,6 @@
 /* Define to 1 if you have the <vfork.h> header file. */
 #undef HAVE_VFORK_H

-/* Define to 1 if you have the `vsnprintf' function. */
-#undef HAVE_VSNPRINTF
-
 /* we always assume a recent mbed TLS version */
 #define HAVE_MBEDTLS_PSA_CRYPTO_H 1
 #define HAVE_MBEDTLS_SSL_TLS_PRF 1
diff --git a/configure.ac b/configure.ac
index 84eaad6..141acc6 100644
--- a/configure.ac
+++ b/configure.ac
@@ -655,7 +655,7 @@
 AC_CHECK_FUNCS([ \
 	daemon chroot getpwnam setuid nice system dup dup2 \
 	syslog openlog mlockall getrlimit getgrnam setgid \
-	setgroups flock readv writev time gettimeofday \
+	setgroups flock time gettimeofday \
 	setsid chdir \
 	chsize ftruncate execve getpeereid basename dirname access \
 	epoll_create strsep \

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021
Gerrit-Change-Number: 443
Gerrit-PatchSet: 5
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newpatchset

--0eQUTqBKDbQ=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos <strong>uploaded patch set #5</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Remove unused/unneeded/add missing defines from configure/cmake<br><b=
r>Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021<br>Signed-off-by: Ar=
ne Schwabe &lt;arne@...1227...&gt;<br>---<br>M CMakeLists.txt<br>M config.h=
.cmake.in<br>M configure.ac<br>3 files changed, 3 insertions(+), 7 deletion=
s(-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-spa=
ce: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes=
/43/443/5</pre><pre style=3D"font-family: monospace,monospace; white-space:=
 pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMakeLists.txt</span><br><s=
pan>index d21c9bd..4aa9793 100644</span><br><span>--- a/CMakeLists.txt</spa=
n><br><span>+++ b/CMakeLists.txt</span><br><span>@@ -167,6 +167,7 @@</span>=
<br><span> check_symbol_exists(getgrnam grp.h HAVE_GETGRNAM)</span><br><spa=
n> check_symbol_exists(getpwnam pwd.h HAVE_GETPWNAM)</span><br><span> check=
_symbol_exists(getsockname sys/socket.h HAVE_GETSOCKNAME)</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+check_symbol_exists(getrlimit &quot;s=
ys/time.h;sys/resource.h&quot; HAVE_GETRLIMIT)</span><br><span> </span><br>=
<span> # Some OS (e.g. FreeBSD) need some basic headers to allow</span><br>=
<span> # including network headers</span><br><span>diff --git a/config.h.cm=
ake.in b/config.h.cmake.in</span><br><span>index 19b79bc..848c505 100644</s=
pan><br><span>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.=
in</span><br><span>@@ -140,7 +140,7 @@</span><br><span> #cmakedefine HAVE_G=
ETPWNAM</span><br><span> </span><br><span> /* Define to 1 if you have the `=
getrlimit&#39; function. */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#undef HAVE_GETRLIMIT</span><br><span style=3D"color: hsl(120, 100%, =
40%);">+#cmakedefine HAVE_GETRLIMIT</span><br><span> </span><br><span> /* D=
efine to 1 if you have the `getsockname&#39; function. */</span><br><span> =
#cmakedefine HAVE_GETSOCKNAME</span><br><span>@@ -235,8 +235,6 @@</span><br=
><span> /* Define to 1 if you have the &lt;pwd.h&gt; header file. */</span>=
<br><span> #cmakedefine HAVE_PWD_H</span><br><span> </span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the `readv&#39; =
function. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef HA=
VE_READV</span><br><span> </span><br><span> /* Define to 1 if you have the =
`recvmsg&#39; function. */</span><br><span> #cmakedefine HAVE_RECVMSG</span=
><br><span>@@ -383,9 +381,6 @@</span><br><span> /* Define to 1 if you have =
the &lt;vfork.h&gt; header file. */</span><br><span> #undef HAVE_VFORK_H</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Def=
ine to 1 if you have the `vsnprintf&#39; function. */</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_VSNPRINTF</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* we always assume a rec=
ent mbed TLS version */</span><br><span> #define HAVE_MBEDTLS_PSA_CRYPTO_H =
1</span><br><span> #define HAVE_MBEDTLS_SSL_TLS_PRF 1</span><br><span>diff =
--git a/configure.ac b/configure.ac</span><br><span>index 84eaad6..141acc6 =
100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.a=
c</span><br><span>@@ -655,7 +655,7 @@</span><br><span> AC_CHECK_FUNCS([ \</=
span><br><span> 	daemon chroot getpwnam setuid nice system dup dup2 \</span=
><br><span> 	syslog openlog mlockall getrlimit getgrnam setgid \</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-	setgroups flock readv writev ti=
me gettimeofday \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	s=
etgroups flock time gettimeofday \</span><br><span> 	setsid chdir \</span><=
br><span> 	chsize ftruncate execve getpeereid basename dirname access \</sp=
an><br><span> 	epoll_create strsep \</span><br><span></span><br></pre><p>To=
 view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Dema=
il">change 443</a>. To unsubscribe, or for help writing mail filters, visit=
 <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div items=
cope itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D=
"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" h=
ref=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail"/><meta itempr=
op=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd0376b36d4050dc22bc93b8fcf=
7ed29faef0021 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 443 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 5 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: flichtenheld &lt;frank@...2375...=
41...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--0eQUTqBKDbQ=--

