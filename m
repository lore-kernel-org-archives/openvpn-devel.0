From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 10:23:42 +0000
References: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <610d62ff06b431ebf54762face240a907078fc10-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="YlZm2rxEX/c="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove unused
 defined from configure and cmake config
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

--YlZm2rxEX/c=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: flichtenheld.

Hello flichtenheld,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail

to review the following change.


Change subject: Remove unused defined from configure and cmake config
......................................................................

Remove unused defined from configure and cmake config

Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021
---
M config.h.cmake.in
M configure.ac
2 files changed, 1 insertion(+), 34 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/443/1

diff --git a/config.h.cmake.in b/config.h.cmake.in
index 19b79bc..25273ac 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -62,9 +62,6 @@
 /* Enable --x509-username-field feature */
 #cmakedefine ENABLE_X509ALTUSERNAME

-/* Compiler supports anonymous unions */
-#define HAVE_ANONYMOUS_UNION_SUPPORT
-
 /* Define to 1 if you have the <arpa/inet.h> header file. */
 #cmakedefine HAVE_ARPA_INET_H 1

@@ -139,9 +136,6 @@
 /* Define to 1 if you have the `getpwnam' function. */
 #cmakedefine HAVE_GETPWNAM

-/* Define to 1 if you have the `getrlimit' function. */
-#undef HAVE_GETRLIMIT
-
 /* Define to 1 if you have the `getsockname' function. */
 #cmakedefine HAVE_GETSOCKNAME

@@ -235,8 +229,6 @@
 /* Define to 1 if you have the <pwd.h> header file. */
 #cmakedefine HAVE_PWD_H

-/* Define to 1 if you have the `readv' function. */
-#undef HAVE_READV

 /* Define to 1 if you have the `recvmsg' function. */
 #cmakedefine HAVE_RECVMSG
@@ -383,9 +375,6 @@
 /* Define to 1 if you have the <vfork.h> header file. */
 #undef HAVE_VFORK_H

-/* Define to 1 if you have the `vsnprintf' function. */
-#undef HAVE_VSNPRINTF
-
 /* we always assume a recent mbed TLS version */
 #define HAVE_MBEDTLS_PSA_CRYPTO_H 1
 #define HAVE_MBEDTLS_SSL_TLS_PRF 1
diff --git a/configure.ac b/configure.ac
index 84eaad6..055b2a7 100644
--- a/configure.ac
+++ b/configure.ac
@@ -561,28 +561,6 @@
 	,
 	[[${SOCKET_INCLUDES}]]
 )
-AC_MSG_CHECKING([anonymous union support])
-AC_COMPILE_IFELSE(
-	[AC_LANG_PROGRAM(
-		[[
-			struct mystruct {
-			  union {
-			    int m1;
-			    char m2;
-			  };
-			};
-		]],
-		[[
-			struct mystruct s;
-			s.m1 =3D 1; s.m2 =3D 2;
-		]]
-	)],
-	[
-		AC_MSG_RESULT([yes])
-		AC_DEFINE([HAVE_ANONYMOUS_UNION_SUPPORT], [], [Compiler supports anonymo=
us unions])
-	],
-	[AC_MSG_RESULT([no])]
-)

 saved_LDFLAGS=3D"$LDFLAGS"
 LDFLAGS=3D"$LDFLAGS -Wl,--wrap=3Dexit"
@@ -655,7 +633,7 @@
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
Gerrit-PatchSet: 1
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: flichtenheld <frank@...2641...>
Gerrit-MessageType: newchange

--YlZm2rxEX/c=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: flichtenheld. </p>
<p>plaisthos would like flichtenheld to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail">Vi=
ew Change</a></p><pre style=3D"font-family: monospace,monospace; white-spac=
e: pre-wrap;">Remove unused defined from configure and cmake config<br><br>=
Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021<br>---<br>M config.h.c=
make.in<br>M configure.ac<br>2 files changed, 1 insertion(+), 34 deletions(=
-)<br><br></pre><pre style=3D"font-family: monospace,monospace; white-space=
: pre-wrap;">git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/4=
3/443/1</pre><pre style=3D"font-family: monospace,monospace; white-space: p=
re-wrap;"><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><b=
r><span>index 19b79bc..25273ac 100644</span><br><span>--- a/config.h.cmake.=
in</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -62,9 +62,6 @=
@</span><br><span> /* Enable --x509-username-field feature */</span><br><sp=
an> #cmakedefine ENABLE_X509ALTUSERNAME</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/* Compiler supports anonymous unions *=
/</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define HAVE_ANONYMO=
US_UNION_SUPPORT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</spa=
n><br><span> /* Define to 1 if you have the &lt;arpa/inet.h&gt; header file=
. */</span><br><span> #cmakedefine HAVE_ARPA_INET_H 1</span><br><span> </sp=
an><br><span>@@ -139,9 +136,6 @@</span><br><span> /* Define to 1 if you hav=
e the `getpwnam&#39; function. */</span><br><span> #cmakedefine HAVE_GETPWN=
AM</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/=
* Define to 1 if you have the `getrlimit&#39; function. */</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_GETRLIMIT</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Define to 1 if yo=
u have the `getsockname&#39; function. */</span><br><span> #cmakedefine HAV=
E_GETSOCKNAME</span><br><span> </span><br><span>@@ -235,8 +229,6 @@</span><=
br><span> /* Define to 1 if you have the &lt;pwd.h&gt; header file. */</spa=
n><br><span> #cmakedefine HAVE_PWD_H</span><br><span> </span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the `readv&#39;=
 function. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef H=
AVE_READV</span><br><span> </span><br><span> /* Define to 1 if you have the=
 `recvmsg&#39; function. */</span><br><span> #cmakedefine HAVE_RECVMSG</spa=
n><br><span>@@ -383,9 +375,6 @@</span><br><span> /* Define to 1 if you have=
 the &lt;vfork.h&gt; header file. */</span><br><span> #undef HAVE_VFORK_H</=
span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* De=
fine to 1 if you have the `vsnprintf&#39; function. */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_VSNPRINTF</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* we always assume a re=
cent mbed TLS version */</span><br><span> #define HAVE_MBEDTLS_PSA_CRYPTO_H=
 1</span><br><span> #define HAVE_MBEDTLS_SSL_TLS_PRF 1</span><br><span>diff=
 --git a/configure.ac b/configure.ac</span><br><span>index 84eaad6..055b2a7=
 100644</span><br><span>--- a/configure.ac</span><br><span>+++ b/configure.=
ac</span><br><span>@@ -561,28 +561,6 @@</span><br><span> 	,</span><br><span=
> 	[[${SOCKET_INCLUDES}]]</span><br><span> )</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-AC_MSG_CHECKING([anonymous union support])</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-AC_COMPILE_IFELSE(</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	[AC_LANG_PROGRAM(</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-		[[</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-			struct mystruct {</span><br><span style=3D"color: h=
sl(0, 100%, 40%);">-			  union {</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-			    int m1;</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-			    char m2;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		=
	  };</span><br><span style=3D"color: hsl(0, 100%, 40%);">-			};</span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-		]],</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-		[[</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-			struct mystruct s;</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-			s.m1 =3D 1; s.m2 =3D 2;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-		]]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	)=
],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[</span><br><span =
style=3D"color: hsl(0, 100%, 40%);">-		AC_MSG_RESULT([yes])</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-		AC_DEFINE([HAVE_ANONYMOUS_UNION_SUP=
PORT], [], [Compiler supports anonymous unions])</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-	],</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	[AC_MSG_RESULT([no])]</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-)</span><br><span> </span><br><span> saved_LDFLAGS=3D&quot;$LDFLA=
GS&quot;</span><br><span> LDFLAGS=3D&quot;$LDFLAGS -Wl,--wrap=3Dexit&quot;<=
/span><br><span>@@ -655,7 +633,7 @@</span><br><span> AC_CHECK_FUNCS([ \</sp=
an><br><span> 	daemon chroot getpwnam setuid nice system dup dup2 \</span><=
br><span> 	syslog openlog mlockall getrlimit getgrnam setgid \</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-	setgroups flock readv writev time=
 gettimeofday \</span><br><span style=3D"color: hsl(120, 100%, 40%);">+	set=
groups flock time gettimeofday \</span><br><span> 	setsid chdir \</span><br=
><span> 	chsize ftruncate execve getpeereid basename dirname access \</span=
><br><span> 	epoll_create strsep \</span><br><span></span><br></pre><p>To v=
iew, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail=
">change 443</a>. To unsubscribe, or for help writing mail filters, visit <=
a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><div itemsco=
pe itemtype=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"a=
ction" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D"url" hre=
f=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail"/><meta itemprop=
=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd0376b36d4050dc22bc93b8fcf=
7ed29faef0021 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 443 </div>
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


--YlZm2rxEX/c=--

