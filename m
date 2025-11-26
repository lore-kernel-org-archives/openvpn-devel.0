From: "flichtenheld (Code Review)" <gerrit@...515...>
Date: Wed, 26 Nov 2025 16:54:13 +0000
References: <gerrit.1764176048000.Ie460eec488a8781e3b1ee4f8b2ae2090729ed175@...2715...>
Reply-To: frank@...2641..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net
Message-ID: <6dbe8c0d2ba44585569273fe921eb9658fdc09e0-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="UBKo+pK74YY="; charset=UTF-8
Subject: [Openvpn-devel] [M] Change in openvpn[master]: Linux: Assume we
 have a kernel that was release in the last 15 years
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

--UBKo+pK74YY=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Attention is currently required from: plaisthos.

Hello plaisthos,

I'd like you to do a code review.
Please visit

    http://gerrit.openvpn.net/c/openvpn/+/1408?usp=3Demail

to review the following change.


Change subject: Linux: Assume we have a kernel that was release in the last=
 15 years
......................................................................

Linux: Assume we have a kernel that was release in the last 15 years

Just assume that we have all the linux headers that
were part of linux since 2.6 (or 2.4 in some cases).

Simplifies configuration.

Change-Id: Ie460eec488a8781e3b1ee4f8b2ae2090729ed175
Signed-off-by: Frank Lichtenheld <frank@...2641...>
---
M CMakeLists.txt
M config.h.cmake.in
M configure.ac
M src/openvpn/mtu.c
M src/openvpn/mtu.h
M src/openvpn/options.c
M src/openvpn/socket.c
M src/openvpn/syshead.h
M src/openvpn/tun.c
9 files changed, 14 insertions(+), 87 deletions(-)



  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1408/1

diff --git a/CMakeLists.txt b/CMakeLists.txt
index e812145..c4d50e4 100644
--- a/CMakeLists.txt
+++ b/CMakeLists.txt
@@ -145,7 +145,6 @@
     set(TARGET_ANDROID YES)
     set(ENABLE_ASYNC_PUSH YES)
     set(ENABLE_SITNL YES)
-    set(HAVE_LINUX_TYPES_H 1)
     # Wacky workaround as OpenSSL package detection is otherwise broken (h=
ttps://stackoverflow.com/questions/45958214/android-cmake-could-not-find-op=
enssl)
     list(APPEND CMAKE_FIND_ROOT_PATH ${OPENSSL_ROOT_DIR})
 elseif (${CMAKE_SYSTEM_NAME} STREQUAL "Linux")
@@ -153,9 +152,6 @@
     set(ENABLE_ASYNC_PUSH YES)
     set(ENABLE_LINUXDCO YES)
     set(ENABLE_SITNL YES)
-    set(HAVE_DECL_SO_MARK YES)
-    set(ENABLE_FEATURE_TUN_PERSIST 1)
-    set(HAVE_LINUX_TYPES_H 1)
     set(ENABLE_DCO YES)
 elseif (${CMAKE_SYSTEM_NAME} STREQUAL "FreeBSD")
     set(TARGET_FREEBSD YES)
@@ -258,8 +254,6 @@
 check_include_files(dmalloc.h HAVE_DMALLOC_H)
 check_include_files(fcntl.h HAVE_FCNTL_H)
 check_include_files(err.h HAVE_ERR_H)
-check_include_files(linux/if_tun.h HAVE_LINUX_IF_TUN_H)
-check_include_files(linux/sockios.h HAVE_LINUX_SOCKIOS_H)
 check_include_files(netdb.h HAVE_NETDB_H)
 check_include_files("${NETEXTRA};netinet/in6.h" HAVE_NETINET_IN_H)
 check_include_files(net/if.h HAVE_NET_IF_H)
diff --git a/config.h.cmake.in b/config.h.cmake.in
index 1c443ab..bf1899c 100644
--- a/config.h.cmake.in
+++ b/config.h.cmake.in
@@ -20,9 +20,6 @@
 /* Enable debugging support (needed for verb>=3D4) */
 #define ENABLE_DEBUG 1

-/* We have persist tun capability */
-#cmakedefine ENABLE_FEATURE_TUN_PERSIST
-
 /* Enable internal fragmentation support */
 #define ENABLE_FRAGMENT 1

@@ -92,10 +89,6 @@
 /* Define to 1 if you have the `daemon' function. */
 #cmakedefine HAVE_DAEMON

-/* Define to 1 if you have the declaration of `SO_MARK', and to 0 if you
-don't. */
-#cmakedefine01 HAVE_DECL_SO_MARK
-
 /* Define to 1 if you have the <direct.h> header file. */
 #cmakedefine HAVE_DIRECT_H

@@ -166,15 +159,6 @@
 /* Define to 1 if you have the <limits.h> header file. */
 #define HAVE_LIMITS_H 1

-/* Define to 1 if you have the <linux/if_tun.h> header file. */
-#cmakedefine HAVE_LINUX_IF_TUN_H
-
-/* Define to 1 if you have the <linux/sockios.h> header file. */
-#cmakedefine HAVE_LINUX_SOCKIOS_H
-
-/* Define to 1 if you have the <linux/types.h> header file. */
-#cmakedefine HAVE_LINUX_TYPES_H
-
 /* Define to 1 if you have the <lzo1x.h> header file. */
 #define HAVE_LZO1X_H 1

diff --git a/configure.ac b/configure.ac
index 44c7b65..030f8de 100644
--- a/configure.ac
+++ b/configure.ac
@@ -494,8 +494,8 @@
 	sys/mman.h sys/file.h sys/wait.h \
 	unistd.h libgen.h stropts.h \
 	syslog.h pwd.h grp.h termios.h \
-	sys/sockio.h sys/uio.h linux/sockios.h \
-	linux/types.h linux/errqueue.h poll.h sys/epoll.h err.h \
+	sys/sockio.h sys/uio.h \
+	poll.h sys/epoll.h err.h \
 ])

 SOCKET_INCLUDES=3D"
@@ -587,12 +587,6 @@
 	[AC_MSG_ERROR([struct sockaddr_in6 not found, needed for ipv6 transport s=
upport.])],
 	[[${SOCKET_INCLUDES}]]
 )
-AC_CHECK_DECLS(
-	[SO_MARK],
-	,
-	,
-	[[${SOCKET_INCLUDES}]]
-)

 saved_LDFLAGS=3D"$LDFLAGS"
 LDFLAGS=3D"$LDFLAGS -Wl,--wrap=3Dexit"
@@ -717,16 +711,6 @@
 	],
 	[have_tap_header=3D"yes"]
 )
-AC_CHECK_DECLS(
-	[TUNSETPERSIST],
-	[AC_DEFINE([ENABLE_FEATURE_TUN_PERSIST], [1], [We have persist tun capabi=
lity])],
-	,
-	[[
-		#ifdef HAVE_LINUX_IF_TUN_H
-		#include <linux/if_tun.h>
-		#endif
-	]]
-)
 CFLAGS=3D"${old_CFLAGS}"
 test "${have_tap_header}" =3D "yes" || AC_MSG_ERROR([no tap header could b=
e found])

diff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c
index 9e152df..e080ea9 100644
--- a/src/openvpn/mtu.c
+++ b/src/openvpn/mtu.c
@@ -274,6 +274,8 @@

 #if EXTENDED_SOCKET_ERROR_CAPABILITY

+#include <linux/errqueue.h>
+
 struct probehdr
 {
     uint32_t ttl;
diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 3bbff6f..b690149 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -262,8 +262,7 @@

 /*
  * EXTENDED_SOCKET_ERROR_CAPABILITY functions -- print extra error info
- * on socket errors, such as PMTU size.  As of 2003.05.11, only works
- * on Linux 2.4+.
+ * on socket errors, such as PMTU size.
  */

 #if EXTENDED_SOCKET_ERROR_CAPABILITY
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 4794315..f610256 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -315,7 +315,7 @@
     "                  or --fragment max value, whichever is lower.\n"
     "--sndbuf size   : Set the TCP/UDP send buffer size.\n"
     "--rcvbuf size   : Set the TCP/UDP receive buffer size.\n"
-#if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
+#if defined(TARGET_LINUX)
     "--mark value    : Mark encrypted packets being sent with value. The m=
ark value\n"
     "                  can be matched in policy routing and packetfilter r=
ules.\n"
     "--bind-dev dev  : Bind to the given device when making connection to =
a peer or\n"
@@ -768,7 +768,7 @@
     "                         (for use with --tls-auth or --tls-crypt)."
 #ifdef ENABLE_FEATURE_TUN_PERSIST
     "\n"
-    "Tun/tap config mode (available with linux 2.4+):\n"
+    "Tun/tap config mode:\n"
     "--mktun         : Create a persistent tunnel.\n"
     "--rmtun         : Remove a persistent tunnel.\n"
     "--dev tunX|tapX : tun/tap device\n"
@@ -1792,7 +1792,7 @@
     SHOW_BOOL(occ);
     SHOW_INT(rcvbuf);
     SHOW_INT(sndbuf);
-#if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
+#if defined(TARGET_LINUX)
     SHOW_INT(mark);
 #endif
     SHOW_INT(sockflags);
@@ -6510,7 +6510,7 @@
     }
     else if (streq(p[0], "mark") && p[1] && !p[2])
     {
-#if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
+#if defined(TARGET_LINUX)
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->mark =3D atoi_warn(p[1], msglevel);
 #endif
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 8b6e35e..5247e07 100644
--- a/src/openvpn/socket.c
+++ b/src/openvpn/socket.c
@@ -524,7 +524,7 @@
 static inline void
 socket_set_mark(socket_descriptor_t sd, int mark)
 {
-#if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
+#if defined(TARGET_LINUX)
     if (mark && setsockopt(sd, SOL_SOCKET, SO_MARK, (void *)&mark, sizeof(=
mark)) !=3D 0)
     {
         msg(M_WARN, "NOTE: setsockopt SO_MARK=3D%d failed", mark);
diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h
index 90045a9..70ba1fb 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -185,26 +185,16 @@

 #if defined(TARGET_LINUX) || defined(TARGET_ANDROID)

-#ifdef HAVE_LINUX_IF_TUN_H
+#define EXTENDED_SOCKET_ERROR_CAPABILITY 1
+#define ENABLE_FEATURE_TUN_PERSIST       1
+
 #include <linux/if_tun.h>
-#endif
+#include <linux/sockios.h>

 #ifdef HAVE_NETINET_IP_H
 #include <netinet/ip.h>
 #endif

-#ifdef HAVE_LINUX_SOCKIOS_H
-#include <linux/sockios.h>
-#endif
-
-#ifdef HAVE_LINUX_TYPES_H
-#include <linux/types.h>
-#endif
-
-#ifdef HAVE_LINUX_ERRQUEUE_H
-#include <linux/errqueue.h>
-#endif
-
 #ifdef HAVE_NETINET_TCP_H
 #include <netinet/tcp.h>
 #endif
@@ -361,15 +351,6 @@
 #endif

 /*
- * Do we have the capability to report extended socket errors?
- */
-#if defined(HAVE_LINUX_TYPES_H) && defined(HAVE_LINUX_ERRQUEUE_H)
-#define EXTENDED_SOCKET_ERROR_CAPABILITY 1
-#else
-#define EXTENDED_SOCKET_ERROR_CAPABILITY 0
-#endif
-
-/*
  * Does this platform support linux-style IP_PKTINFO
  * or bsd-style IP_RECVDSTADDR ?
  */
@@ -397,14 +378,6 @@
 #endif

 /*
- * Disable ESEC
- */
-#if 0
-#undef EXTENDED_SOCKET_ERROR_CAPABILITY
-#define EXTENDED_SOCKET_ERROR_CAPABILITY 0
-#endif
-
-/*
  * Do we have a syslog capability?
  */
 #if defined(HAVE_OPENLOG) && defined(HAVE_SYSLOG)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 06b7ae5..7c61dcf 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -2055,10 +2055,6 @@

 #elif defined(TARGET_LINUX)

-#ifndef HAVE_LINUX_SOCKIOS_H
-#error header file linux/sockios.h required
-#endif
-
 #if !PEDANTIC

 void
@@ -2186,11 +2182,6 @@

 #ifdef ENABLE_FEATURE_TUN_PERSIST

-/* TUNSETGROUP appeared in 2.6.23 */
-#ifndef TUNSETGROUP
-#define TUNSETGROUP _IOW('T', 206, int)
-#endif
-
 void
 tuncfg(const char *dev, const char *dev_type, const char *dev_node, int pe=
rsist_mode,
        const char *username, const char *groupname, const struct tuntap_op=
tions *options,

--
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1408?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newchange
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie460eec488a8781e3b1ee4f8b2ae2090729ed175
Gerrit-Change-Number: 1408
Gerrit-PatchSet: 1
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>
Gerrit-Attention: plaisthos <arne-openvpn@...1227...>

--UBKo+pK74YY=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p> Attention is cur=
rently required from: plaisthos. </p>
<p>flichtenheld would like plaisthos to <strong>review</strong> this change.
</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1408?usp=3Demail">V=
iew Change</a></p><pre class=3D"blocks" style=3D"font-family: monospace,mon=
ospace; white-space: pre-wrap;">Linux: Assume we have a kernel that was rel=
ease in the last 15 years<br><br>Just assume that we have all the linux hea=
ders that<br>were part of linux since 2.6 (or 2.4 in some cases).<br><br>Si=
mplifies configuration.<br><br>Change-Id: Ie460eec488a8781e3b1ee4f8b2ae2090=
729ed175<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&gt;<br>--=
-<br>M CMakeLists.txt<br>M config.h.cmake.in<br>M configure.ac<br>M src/ope=
nvpn/mtu.c<br>M src/openvpn/mtu.h<br>M src/openvpn/options.c<br>M src/openv=
pn/socket.c<br>M src/openvpn/syshead.h<br>M src/openvpn/tun.c<br>9 files ch=
anged, 14 insertions(+), 87 deletions(-)<br><br></pre><pre class=3D"blocks"=
 style=3D"font-family: monospace,monospace; white-space: pre-wrap;">git pul=
l ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1408/1</pre><pre s=
tyle=3D"font-family: monospace,monospace; white-space: pre-wrap;"><span>dif=
f --git a/CMakeLists.txt b/CMakeLists.txt</span><br><span>index e812145..c4=
d50e4 100644</span><br><span>--- a/CMakeLists.txt</span><br><span>+++ b/CMa=
keLists.txt</span><br><span>@@ -145,7 +145,6 @@</span><br><span>     set(TA=
RGET_ANDROID YES)</span><br><span>     set(ENABLE_ASYNC_PUSH YES)</span><br=
><span>     set(ENABLE_SITNL YES)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-    set(HAVE_LINUX_TYPES_H 1)</span><br><span>     # Wacky work=
around as OpenSSL package detection is otherwise broken (https://stackoverf=
low.com/questions/45958214/android-cmake-could-not-find-openssl)</span><br>=
<span>     list(APPEND CMAKE_FIND_ROOT_PATH ${OPENSSL_ROOT_DIR})</span><br>=
<span> elseif (${CMAKE_SYSTEM_NAME} STREQUAL &quot;Linux&quot;)</span><br><=
span>@@ -153,9 +152,6 @@</span><br><span>     set(ENABLE_ASYNC_PUSH YES)</s=
pan><br><span>     set(ENABLE_LINUXDCO YES)</span><br><span>     set(ENABLE=
_SITNL YES)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set(HA=
VE_DECL_SO_MARK YES)</span><br><span style=3D"color: hsl(0, 100%, 40%);">- =
   set(ENABLE_FEATURE_TUN_PERSIST 1)</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    set(HAVE_LINUX_TYPES_H 1)</span><br><span>     set(ENABL=
E_DCO YES)</span><br><span> elseif (${CMAKE_SYSTEM_NAME} STREQUAL &quot;Fre=
eBSD&quot;)</span><br><span>     set(TARGET_FREEBSD YES)</span><br><span>@@=
 -258,8 +254,6 @@</span><br><span> check_include_files(dmalloc.h HAVE_DMALL=
OC_H)</span><br><span> check_include_files(fcntl.h HAVE_FCNTL_H)</span><br>=
<span> check_include_files(err.h HAVE_ERR_H)</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-check_include_files(linux/if_tun.h HAVE_LINUX_IF_TUN=
_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_include_file=
s(linux/sockios.h HAVE_LINUX_SOCKIOS_H)</span><br><span> check_include_file=
s(netdb.h HAVE_NETDB_H)</span><br><span> check_include_files(&quot;${NETEXT=
RA};netinet/in6.h&quot; HAVE_NETINET_IN_H)</span><br><span> check_include_f=
iles(net/if.h HAVE_NET_IF_H)</span><br><span>diff --git a/config.h.cmake.in=
 b/config.h.cmake.in</span><br><span>index 1c443ab..bf1899c 100644</span><b=
r><span>--- a/config.h.cmake.in</span><br><span>+++ b/config.h.cmake.in</sp=
an><br><span>@@ -20,9 +20,6 @@</span><br><span> /* Enable debugging support=
 (needed for verb&gt;=3D4) */</span><br><span> #define ENABLE_DEBUG 1</span=
><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* We hav=
e persist tun capability */</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#cmakedefine ENABLE_FEATURE_TUN_PERSIST</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-</span><br><span> /* Enable internal fragmentation =
support */</span><br><span> #define ENABLE_FRAGMENT 1</span><br><span> </sp=
an><br><span>@@ -92,10 +89,6 @@</span><br><span> /* Define to 1 if you have=
 the `daemon&#39; function. */</span><br><span> #cmakedefine HAVE_DAEMON</s=
pan><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Def=
ine to 1 if you have the declaration of `SO_MARK&#39;, and to 0 if you</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-don&#39;t. */</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#cmakedefine01 HAVE_DECL_SO_MARK</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* De=
fine to 1 if you have the &lt;direct.h&gt; header file. */</span><br><span>=
 #cmakedefine HAVE_DIRECT_H</span><br><span> </span><br><span>@@ -166,15 +1=
59,6 @@</span><br><span> /* Define to 1 if you have the &lt;limits.h&gt; he=
ader file. */</span><br><span> #define HAVE_LIMITS_H 1</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you ha=
ve the &lt;linux/if_tun.h&gt; header file. */</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#cmakedefine HAVE_LINUX_IF_TUN_H</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-/* Define to 1 if you have the &lt;linux/sockios.h&gt; header=
 file. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#cmakedefine=
 HAVE_LINUX_SOCKIOS_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you=
 have the &lt;linux/types.h&gt; header file. */</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-#cmakedefine HAVE_LINUX_TYPES_H</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-</span><br><span> /* Define to 1 if you=
 have the &lt;lzo1x.h&gt; header file. */</span><br><span> #define HAVE_LZO=
1X_H 1</span><br><span> </span><br><span>diff --git a/configure.ac b/config=
ure.ac</span><br><span>index 44c7b65..030f8de 100644</span><br><span>--- a/=
configure.ac</span><br><span>+++ b/configure.ac</span><br><span>@@ -494,8 +=
494,8 @@</span><br><span> 	sys/mman.h sys/file.h sys/wait.h \</span><br><sp=
an> 	unistd.h libgen.h stropts.h \</span><br><span> 	syslog.h pwd.h grp.h t=
ermios.h \</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	sys/sockio=
.h sys/uio.h linux/sockios.h \</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-	linux/types.h linux/errqueue.h poll.h sys/epoll.h err.h \</span><=
br><span style=3D"color: hsl(120, 100%, 40%);">+	sys/sockio.h sys/uio.h \</=
span><br><span style=3D"color: hsl(120, 100%, 40%);">+	poll.h sys/epoll.h e=
rr.h \</span><br><span> ])</span><br><span> </span><br><span> SOCKET_INCLUD=
ES=3D&quot;</span><br><span>@@ -587,12 +587,6 @@</span><br><span> 	[AC_MSG_=
ERROR([struct sockaddr_in6 not found, needed for ipv6 transport support.])]=
,</span><br><span> 	[[${SOCKET_INCLUDES}]]</span><br><span> )</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-AC_CHECK_DECLS(</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	[SO_MARK],</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-	,</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-	,</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[[${SOCKET_IN=
CLUDES}]]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-)</span><br>=
<span> </span><br><span> saved_LDFLAGS=3D&quot;$LDFLAGS&quot;</span><br><sp=
an> LDFLAGS=3D&quot;$LDFLAGS -Wl,--wrap=3Dexit&quot;</span><br><span>@@ -71=
7,16 +711,6 @@</span><br><span> 	],</span><br><span> 	[have_tap_header=3D&q=
uot;yes&quot;]</span><br><span> )</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-AC_CHECK_DECLS(</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-	[TUNSETPERSIST],</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-	[AC_DEFINE([ENABLE_FEATURE_TUN_PERSIST], [1], [We have persist tun capab=
ility])],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	,</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-	[[</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">-		#ifdef HAVE_LINUX_IF_TUN_H</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-		#include &lt;linux/if_tun.h&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-		#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	]]</span><br><span style=3D"color: hsl(0, =
100%, 40%);">-)</span><br><span> CFLAGS=3D&quot;${old_CFLAGS}&quot;</span><=
br><span> test &quot;${have_tap_header}&quot; =3D &quot;yes&quot; || AC_MSG=
_ERROR([no tap header could be found])</span><br><span> </span><br><span>di=
ff --git a/src/openvpn/mtu.c b/src/openvpn/mtu.c</span><br><span>index 9e15=
2df..e080ea9 100644</span><br><span>--- a/src/openvpn/mtu.c</span><br><span=
>+++ b/src/openvpn/mtu.c</span><br><span>@@ -274,6 +274,8 @@</span><br><spa=
n> </span><br><span> #if EXTENDED_SOCKET_ERROR_CAPABILITY</span><br><span> =
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#include &lt;linux/=
errqueue.h&gt;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</spa=
n><br><span> struct probehdr</span><br><span> {</span><br><span>     uint32=
_t ttl;</span><br><span>diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h<=
/span><br><span>index 3bbff6f..b690149 100644</span><br><span>--- a/src/ope=
nvpn/mtu.h</span><br><span>+++ b/src/openvpn/mtu.h</span><br><span>@@ -262,=
8 +262,7 @@</span><br><span> </span><br><span> /*</span><br><span>  * EXTEN=
DED_SOCKET_ERROR_CAPABILITY functions -- print extra error info</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">- * on socket errors, such as PMTU=
 size.  As of 2003.05.11, only works</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">- * on Linux 2.4+.</span><br><span style=3D"color: hsl(120, 1=
00%, 40%);">+ * on socket errors, such as PMTU size.</span><br><span>  */</=
span><br><span> </span><br><span> #if EXTENDED_SOCKET_ERROR_CAPABILITY</spa=
n><br><span>diff --git a/src/openvpn/options.c b/src/openvpn/options.c</spa=
n><br><span>index 4794315..f610256 100644</span><br><span>--- a/src/openvpn=
/options.c</span><br><span>+++ b/src/openvpn/options.c</span><br><span>@@ -=
315,7 +315,7 @@</span><br><span>     &quot;                  or --fragment =
max value, whichever is lower.\n&quot;</span><br><span>     &quot;--sndbuf =
size   : Set the TCP/UDP send buffer size.\n&quot;</span><br><span>     &qu=
ot;--rcvbuf size   : Set the TCP/UDP receive buffer size.\n&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) &amp;=
&amp; HAVE_DECL_SO_MARK</span><br><span style=3D"color: hsl(120, 100%, 40%)=
;">+#if defined(TARGET_LINUX)</span><br><span>     &quot;--mark value    : =
Mark encrypted packets being sent with value. The mark value\n&quot;</span>=
<br><span>     &quot;                  can be matched in policy routing and=
 packetfilter rules.\n&quot;</span><br><span>     &quot;--bind-dev dev  : B=
ind to the given device when making connection to a peer or\n&quot;</span><=
br><span>@@ -768,7 +768,7 @@</span><br><span>     &quot;                   =
      (for use with --tls-auth or --tls-crypt).&quot;</span><br><span> #ifd=
ef ENABLE_FEATURE_TUN_PERSIST</span><br><span>     &quot;\n&quot;</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    &quot;Tun/tap config mode (=
available with linux 2.4+):\n&quot;</span><br><span style=3D"color: hsl(120=
, 100%, 40%);">+    &quot;Tun/tap config mode:\n&quot;</span><br><span>    =
 &quot;--mktun         : Create a persistent tunnel.\n&quot;</span><br><spa=
n>     &quot;--rmtun         : Remove a persistent tunnel.\n&quot;</span><b=
r><span>     &quot;--dev tunX|tapX : tun/tap device\n&quot;</span><br><span=
>@@ -1792,7 +1792,7 @@</span><br><span>     SHOW_BOOL(occ);</span><br><span=
>     SHOW_INT(rcvbuf);</span><br><span>     SHOW_INT(sndbuf);</span><br><s=
pan style=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) &amp;&am=
p; HAVE_DECL_SO_MARK</span><br><span style=3D"color: hsl(120, 100%, 40%);">=
+#if defined(TARGET_LINUX)</span><br><span>     SHOW_INT(mark);</span><br><=
span> #endif</span><br><span>     SHOW_INT(sockflags);</span><br><span>@@ -=
6510,7 +6510,7 @@</span><br><span>     }</span><br><span>     else if (stre=
q(p[0], &quot;mark&quot;) &amp;&amp; p[1] &amp;&amp; !p[2])</span><br><span=
>     {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if defined(TA=
RGET_LINUX) &amp;&amp; HAVE_DECL_SO_MARK</span><br><span style=3D"color: hs=
l(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><span>         VER=
IFY_PERMISSION(OPT_P_GENERAL);</span><br><span>         options-&gt;mark =
=3D atoi_warn(p[1], msglevel);</span><br><span> #endif</span><br><span>diff=
 --git a/src/openvpn/socket.c b/src/openvpn/socket.c</span><br><span>index =
8b6e35e..5247e07 100644</span><br><span>--- a/src/openvpn/socket.c</span><b=
r><span>+++ b/src/openvpn/socket.c</span><br><span>@@ -524,7 +524,7 @@</spa=
n><br><span> static inline void</span><br><span> socket_set_mark(socket_des=
criptor_t sd, int mark)</span><br><span> {</span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) &amp;&amp; HAVE_DECL_SO_MARK=
</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_=
LINUX)</span><br><span>     if (mark &amp;&amp; setsockopt(sd, SOL_SOCKET, =
SO_MARK, (void *)&amp;mark, sizeof(mark)) !=3D 0)</span><br><span>     {</s=
pan><br><span>         msg(M_WARN, &quot;NOTE: setsockopt SO_MARK=3D%d fail=
ed&quot;, mark);</span><br><span>diff --git a/src/openvpn/syshead.h b/src/o=
penvpn/syshead.h</span><br><span>index 90045a9..70ba1fb 100644</span><br><s=
pan>--- a/src/openvpn/syshead.h</span><br><span>+++ b/src/openvpn/syshead.h=
</span><br><span>@@ -185,26 +185,16 @@</span><br><span> </span><br><span> #=
if defined(TARGET_LINUX) || defined(TARGET_ANDROID)</span><br><span> </span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_LINUX_IF_TUN_H<=
/span><br><span style=3D"color: hsl(120, 100%, 40%);">+#define EXTENDED_SOC=
KET_ERROR_CAPABILITY 1</span><br><span style=3D"color: hsl(120, 100%, 40%);=
">+#define ENABLE_FEATURE_TUN_PERSIST       1</span><br><span style=3D"colo=
r: hsl(120, 100%, 40%);">+</span><br><span> #include &lt;linux/if_tun.h&gt;=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+#include &lt;linux/sockios.h&gt;</=
span><br><span> </span><br><span> #ifdef HAVE_NETINET_IP_H</span><br><span>=
 #include &lt;netinet/ip.h&gt;</span><br><span> #endif</span><br><span> </s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_LINUX_SOCKIO=
S_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;linux=
/sockios.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_LINUX_TYPES_H</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-#include &lt;linux/types.h&gt;</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#ifdef HAVE_LINUX_ERRQUEUE_H</span><br><span style=3D"color: hsl=
(0, 100%, 40%);">-#include &lt;linux/errqueue.h&gt;</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> #ifdef HAVE_NETINET_TCP_H</span><br><spa=
n> #include &lt;netinet/tcp.h&gt;</span><br><span> #endif</span><br><span>@=
@ -361,15 +351,6 @@</span><br><span> #endif</span><br><span> </span><br><sp=
an> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * Do we have t=
he capability to report extended socket errors?</span><br><span style=3D"co=
lor: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#if defined(HAVE_LINUX_TYPES_H) &amp;&amp; defined(HAVE_LINUX_ERRQU=
EUE_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define EXTENDE=
D_SOCKET_ERROR_CAPABILITY 1</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#else</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define EX=
TENDED_SOCKET_ERROR_CAPABILITY 0</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Do=
es this platform support linux-style IP_PKTINFO</span><br><span>  * or bsd-=
style IP_RECVDSTADDR ?</span><br><span>  */</span><br><span>@@ -397,14 +378=
,6 @@</span><br><span> #endif</span><br><span> </span><br><span> /*</span><=
br><span style=3D"color: hsl(0, 100%, 40%);">- * Disable ESEC</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#if 0</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#undef EXTENDED_SOCKET_ERROR_CAPABILITY</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#define EXTENDED_SOCKET_ERROR_CAPABILITY 0</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-/*</span><br><span>  * Do we have a syslog capability?</span><br=
><span>  */</span><br><span> #if defined(HAVE_OPENLOG) &amp;&amp; defined(H=
AVE_SYSLOG)</span><br><span>diff --git a/src/openvpn/tun.c b/src/openvpn/tu=
n.c</span><br><span>index 06b7ae5..7c61dcf 100644</span><br><span>--- a/src=
/openvpn/tun.c</span><br><span>+++ b/src/openvpn/tun.c</span><br><span>@@ -=
2055,10 +2055,6 @@</span><br><span> </span><br><span> #elif defined(TARGET_=
LINUX)</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-#ifndef HAVE_LINUX_SOCKIOS_H</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-#error header file linux/sockios.h required</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> #if !PEDANTIC</span><br><span> </span><b=
r><span> void</span><br><span>@@ -2186,11 +2182,6 @@</span><br><span> </spa=
n><br><span> #ifdef ENABLE_FEATURE_TUN_PERSIST</span><br><span> </span><br>=
<span style=3D"color: hsl(0, 100%, 40%);">-/* TUNSETGROUP appeared in 2.6.2=
3 */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifndef TUNSETGRO=
UP</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#define TUNSETGROUP=
 _IOW(&#39;T&#39;, 206, int)</span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><=
br><span> void</span><br><span> tuncfg(const char *dev, const char *dev_typ=
e, const char *dev_node, int persist_mode,</span><br><span>        const ch=
ar *username, const char *groupname, const struct tuntap_options *options,<=
/span><br><span></span><br></pre><p>To view, visit <a href=3D"http://gerrit=
.openvpn.net/c/openvpn/+/1408?usp=3Demail">change 1408</a>. To unsubscribe,=
 or for help writing mail filters, visit <a href=3D"http://gerrit.openvpn.n=
et/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=3D"http:/=
/schema.org/EmailMessage"><div itemscope itemprop=3D"action" itemtype=3D"ht=
tp://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http://gerrit.op=
envpn.net/c/openvpn/+/1408?usp=3Demail"/><meta itemprop=3D"name" content=3D=
"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newchange </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie460eec488a8781e3b1ee4f8b2a=
e2090729ed175 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1408 </div>
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

--UBKo+pK74YY=--

