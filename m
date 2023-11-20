From: "plaisthos (Code Review)" <gerrit@...515...>
Date: Mon, 20 Nov 2023 11:44:17 +0000
In-Reply-To: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
References: <gerrit.1700475817000.Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021@...2715...>
Reply-To: arne-openvpn@...1227..., openvpn-devel@lists.sourceforge.net,
 frank@...2641...
Message-ID: <5f92fe32ec5f21833530ad3979ea60d0df48d20b-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="daHe86YVlxA="; charset=UTF-8
Subject: [Openvpn-devel] [S] Change in openvpn[master]: Remove
 unused/uneeded defines from configure and cmake config
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

--daHe86YVlxA=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello flichtenheld,

I'd like you to reexamine a change. Please visit

    http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail

to look at the new patch set (#2).


Change subject: Remove unused/uneeded defines from configure and cmake conf=
ig
......................................................................

Remove unused/uneeded defines from configure and cmake config

Anonymous unions/structs are technically a custom GNU C99 feature but
was already widely supported by other compilers. With C11 this feature
has become a standard feature so all compilers nowadays support it.

Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021
---
M config.h.cmake.in
M configure.ac
M src/openvpn/mroute.h
3 files changed, 2 insertions(+), 45 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/43/443/2

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
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h
index a06e872..7cfa18e 100644
--- a/src/openvpn/mroute.h
+++ b/src/openvpn/mroute.h
@@ -96,17 +96,7 @@
             uint8_t prefix[12];
             in_addr_t addr;     /* _network order_ IPv4 address */
         } v4mappedv6;
-    }
-#ifndef HAVE_ANONYMOUS_UNION_SUPPORT
-/* Wrappers to support compilers that do not grok anonymous unions */
-        mroute_union
-#define raw_addr mroute_union.raw_addr
-#define ether mroute_union.ether
-#define v4 mroute_union.v4
-#define v6 mroute_union.v6
-#define v4mappedv6 mroute_union.v4mappedv6
-#endif
-    ;
+    };
 };

 /* Double-check that struct packing works as expected */

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings

Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021
Gerrit-Change-Number: 443
Gerrit-PatchSet: 2
Gerrit-Owner: plaisthos <arne-openvpn@...1227...>
Gerrit-Reviewer: flichtenheld <frank@...2641...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>
Gerrit-MessageType: newpatchset

--daHe86YVlxA=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<p> Attention is currently required from: plaisthos. </p>
<p>plaisthos <strong>uploaded patch set #2</strong> to this change.</p><p><=
a href=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail">View Chang=
e</a></p><pre style=3D"font-family: monospace,monospace; white-space: pre-w=
rap;">Remove unused/uneeded defines from configure and cmake config<br><br>=
Anonymous unions/structs are technically a custom GNU C99 feature but<br>wa=
s already widely supported by other compilers. With C11 this feature<br>has=
 become a standard feature so all compilers nowadays support it.<br><br>Cha=
nge-Id: Ifd0376b36d4050dc22bc93b8fcf7ed29faef0021<br>---<br>M config.h.cmak=
e.in<br>M configure.ac<br>M src/openvpn/mroute.h<br>3 files changed, 2 inse=
rtions(+), 45 deletions(-)<br><br></pre><pre style=3D"font-family: monospac=
e,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:2941=
8/openvpn refs/changes/43/443/2</pre><pre style=3D"font-family: monospace,m=
onospace; white-space: pre-wrap;"><span>diff --git a/config.h.cmake.in b/co=
nfig.h.cmake.in</span><br><span>index 19b79bc..25273ac 100644</span><br><sp=
an>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</span><b=
r><span>@@ -62,9 +62,6 @@</span><br><span> /* Enable --x509-username-field =
feature */</span><br><span> #cmakedefine ENABLE_X509ALTUSERNAME</span><br><=
span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Compiler sup=
ports anonymous unions */</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-#define HAVE_ANONYMOUS_UNION_SUPPORT</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-</span><br><span> /* Define to 1 if you have the &lt;arp=
a/inet.h&gt; header file. */</span><br><span> #cmakedefine HAVE_ARPA_INET_H=
 1</span><br><span> </span><br><span>@@ -139,9 +136,6 @@</span><br><span> /=
* Define to 1 if you have the `getpwnam&#39; function. */</span><br><span> =
#cmakedefine HAVE_GETPWNAM</span><br><span> </span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-/* Define to 1 if you have the `getrlimit&#39; funct=
ion. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_GE=
TRLIMIT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an> /* Define to 1 if you have the `getsockname&#39; function. */</span><br=
><span> #cmakedefine HAVE_GETSOCKNAME</span><br><span> </span><br><span>@@ =
-235,8 +229,6 @@</span><br><span> /* Define to 1 if you have the &lt;pwd.h&=
gt; header file. */</span><br><span> #cmakedefine HAVE_PWD_H</span><br><spa=
n> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if =
you have the `readv&#39; function. */</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-#undef HAVE_READV</span><br><span> </span><br><span> /* Def=
ine to 1 if you have the `recvmsg&#39; function. */</span><br><span> #cmake=
define HAVE_RECVMSG</span><br><span>@@ -383,9 +375,6 @@</span><br><span> /*=
 Define to 1 if you have the &lt;vfork.h&gt; header file. */</span><br><spa=
n> #undef HAVE_VFORK_H</span><br><span> </span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-/* Define to 1 if you have the `vsnprintf&#39; function.=
 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#undef HAVE_VSNPRI=
NTF</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> =
/* we always assume a recent mbed TLS version */</span><br><span> #define H=
AVE_MBEDTLS_PSA_CRYPTO_H 1</span><br><span> #define HAVE_MBEDTLS_SSL_TLS_PR=
F 1</span><br><span>diff --git a/configure.ac b/configure.ac</span><br><spa=
n>index 84eaad6..055b2a7 100644</span><br><span>--- a/configure.ac</span><b=
r><span>+++ b/configure.ac</span><br><span>@@ -561,28 +561,6 @@</span><br><=
span> 	,</span><br><span> 	[[${SOCKET_INCLUDES}]]</span><br><span> )</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-AC_MSG_CHECKING([anonymous u=
nion support])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_COMP=
ILE_IFELSE(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC_LANG_=
PROGRAM(</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		[[</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-			struct mystruct {</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-			  union {</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-			    int m1;</span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-			    char m2;</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-			  };</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-			};</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		]],</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-		[[</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-			struct mystruct s;</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-			s.m1 =3D 1; s.m2 =3D 2;</span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-		]]</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-	)],</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	[</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		AC_MSG_RESUL=
T([yes])</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		AC_DEFINE([=
HAVE_ANONYMOUS_UNION_SUPPORT], [], [Compiler supports anonymous unions])</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-	],</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-	[AC_MSG_RESULT([no])]</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-)</span><br><span> </span><br><span> save=
d_LDFLAGS=3D&quot;$LDFLAGS&quot;</span><br><span> LDFLAGS=3D&quot;$LDFLAGS =
-Wl,--wrap=3Dexit&quot;</span><br><span>@@ -655,7 +633,7 @@</span><br><span=
> AC_CHECK_FUNCS([ \</span><br><span> 	daemon chroot getpwnam setuid nice s=
ystem dup dup2 \</span><br><span> 	syslog openlog mlockall getrlimit getgrn=
am setgid \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	setgroups=
 flock readv writev time gettimeofday \</span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+	setgroups flock time gettimeofday \</span><br><span> 	=
setsid chdir \</span><br><span> 	chsize ftruncate execve getpeereid basenam=
e dirname access \</span><br><span> 	epoll_create strsep \</span><br><span>=
diff --git a/src/openvpn/mroute.h b/src/openvpn/mroute.h</span><br><span>in=
dex a06e872..7cfa18e 100644</span><br><span>--- a/src/openvpn/mroute.h</spa=
n><br><span>+++ b/src/openvpn/mroute.h</span><br><span>@@ -96,17 +96,7 @@</=
span><br><span>             uint8_t prefix[12];</span><br><span>           =
  in_addr_t addr;     /* _network order_ IPv4 address */</span><br><span>  =
       } v4mappedv6;</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   }</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef HAVE_ANON=
YMOUS_UNION_SUPPORT</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/*=
 Wrappers to support compilers that do not grok anonymous unions */</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">-        mroute_union</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#define raw_addr mroute_union.=
raw_addr</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define ether=
 mroute_union.ether</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#d=
efine v4 mroute_union.v4</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#define v6 mroute_union.v6</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#define v4mappedv6 mroute_union.v4mappedv6</span><br><span style=3D=
"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-    ;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+=
    };</span><br><span> };</span><br><span> </span><br><span> /* Double-che=
ck that struct packing works as expected */</span><br><span></span><br></pr=
e><p>To view, visit <a href=3D"http://gerrit.openvpn.net/c/openvpn/+/443?us=
p=3Demail">change 443</a>. To unsubscribe, or for help writing mail filters=
, visit <a href=3D"http://gerrit.openvpn.net/settings">settings</a>.</p><di=
v itemscope itemtype=3D"http://schema.org/EmailMessage"><div itemscope item=
prop=3D"action" itemtype=3D"http://schema.org/ViewAction"><link itemprop=3D=
"url" href=3D"http://gerrit.openvpn.net/c/openvpn/+/443?usp=3Demail"/><meta=
 itemprop=3D"name" content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ifd0376b36d4050dc22bc93b8fcf=
7ed29faef0021 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 443 </div>
<div style=3D"display:none"> Gerrit-PatchSet: 2 </div>
<div style=3D"display:none"> Gerrit-Owner: plaisthos &lt;arne-openvpn@...1711...=
27...&gt; </div>
<div style=3D"display:none"> Gerrit-Reviewer: flichtenheld &lt;frank@...2716...=
1...&gt; </div>
<div style=3D"display:none"> Gerrit-CC: openvpn-devel &lt;openvpn-devel@...1484...=
ts.sourceforge.net&gt; </div>
<div style=3D"display:none"> Gerrit-Attention: plaisthos &lt;arne-openvpn@...220...=
..1227...&gt; </div>
<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>


--daHe86YVlxA=--

