From: "cron2 (Code Review)" <gerrit@...515...>
Date: Thu, 27 Nov 2025 11:14:34 +0000
In-Reply-To: <gerrit.1764176048000.Ie460eec488a8781e3b1ee4f8b2ae2090729ed175@...2715...>
References: <gerrit.1764176048000.Ie460eec488a8781e3b1ee4f8b2ae2090729ed175@...2715...>
Reply-To: gert@...1296..., arne-openvpn@...1227...,
 openvpn-devel@lists.sourceforge.net, frank@...2641...
Message-ID: <6591dbbe4f8381034b41fc379f1d7cf6c1461dea-EmailReplacePatchSet-HTML@...2715...>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Disposition: inline
Content-Type: multipart/alternative; boundary="+4C51uQEC6A="; charset=UTF-8
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
To: flichtenheld <frank@...2641...>, plaisthos <arne-openvpn@...1227...>
Cc: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+4C51uQEC6A=
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

cron2 has uploaded a new patch set (#3) to the change originally created by=
 flichtenheld. ( http://gerrit.openvpn.net/c/openvpn/+/1408?usp=3Demail )

The following approvals got outdated and were removed:
Code-Review+2 by cron2


Change subject: Linux: Assume we have a kernel that was release in the last=
 15 years
......................................................................

Linux: Assume we have a kernel that was release in the last 15 years

Just assume that we have all the linux headers that
were part of linux since 2.6 (or 2.4 in some cases).

Simplifies configuration.

Change-Id: Ie460eec488a8781e3b1ee4f8b2ae2090729ed175
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1408
Message-Id: <20251127105125.30457-1-gert@...1296...>
URL: https://www.mail-archive.com/openvpn-devel@lists.sourceforge.net/msg34=
738.html
Signed-off-by: Gert Doering <gert@...1296...>
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
M src/openvpn/tun.h
10 files changed, 19 insertions(+), 87 deletions(-)


  git pull ssh://gerrit.openvpn.net:29418/openvpn refs/changes/08/1408/3

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
index 62f84dd..5e73196 100644
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
@@ -6518,7 +6518,7 @@
     }
     else if (streq(p[0], "mark") && p[1] && !p[2])
     {
-#if defined(TARGET_LINUX) && HAVE_DECL_SO_MARK
+#if defined(TARGET_LINUX)
         VERIFY_PERMISSION(OPT_P_GENERAL);
         options->mark =3D atoi_warn(p[1], msglevel);
 #endif
diff --git a/src/openvpn/socket.c b/src/openvpn/socket.c
index 747c7a7..46bedf4 100644
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
index 90045a9..c6f2608 100644
--- a/src/openvpn/syshead.h
+++ b/src/openvpn/syshead.h
@@ -185,26 +185,19 @@

 #if defined(TARGET_LINUX) || defined(TARGET_ANDROID)

-#ifdef HAVE_LINUX_IF_TUN_H
-#include <linux/if_tun.h>
+#define EXTENDED_SOCKET_ERROR_CAPABILITY 1
+
+#ifdef TARGET_LINUX
+#define ENABLE_FEATURE_TUN_PERSIST
 #endif

+#include <linux/if_tun.h>
+#include <linux/sockios.h>
+
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
@@ -361,15 +354,6 @@
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
@@ -397,14 +381,6 @@
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
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index e13f99f..876f147 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -278,9 +278,11 @@

 int read_tun(struct tuntap *tt, uint8_t *buf, int len);

+#ifdef ENABLE_FEATURE_TUN_PERSIST
 void tuncfg(const char *dev, const char *dev_type, const char *dev_node, i=
nt persist_mode,
             const char *username, const char *groupname, const struct tunt=
ap_options *options,
             openvpn_net_ctx_t *ctx);
+#endif

 const char *guess_tuntap_dev(const char *dev, const char *dev_type, const =
char *dev_node,
                              struct gc_arena *gc);

--=20
To view, visit http://gerrit.openvpn.net/c/openvpn/+/1408?usp=3Demail
To unsubscribe, or for help writing mail filters, visit http://gerrit.openv=
pn.net/settings?usp=3Demail

Gerrit-MessageType: newpatchset
Gerrit-Project: openvpn
Gerrit-Branch: master
Gerrit-Change-Id: Ie460eec488a8781e3b1ee4f8b2ae2090729ed175
Gerrit-Change-Number: 1408
Gerrit-PatchSet: 3
Gerrit-Owner: flichtenheld <frank@...2641...>
Gerrit-Reviewer: cron2 <gert@...1296...>
Gerrit-Reviewer: plaisthos <arne-openvpn@...1227...>
Gerrit-CC: openvpn-devel <openvpn-devel@lists.sourceforge.net>

--+4C51uQEC6A=
Content-Type: text/html; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

<!DOCTYPE html><html><head><style></style></head><body><p>cron2 <strong>upl=
oaded patch set #3</strong> to the change originally created by flichtenhel=
d.</p><p><a href=3D"http://gerrit.openvpn.net/c/openvpn/+/1408?usp=3Demail"=
>View Change</a></p><p>The following approvals got outdated and were remove=
d:
Code-Review+2 by cron2</p><pre class=3D"blocks" style=3D"font-family: monos=
pace,monospace; white-space: pre-wrap;">Linux: Assume we have a kernel that=
 was release in the last 15 years<br><br>Just assume that we have all the l=
inux headers that<br>were part of linux since 2.6 (or 2.4 in some cases).<b=
r><br>Simplifies configuration.<br><br>Change-Id: Ie460eec488a8781e3b1ee4f8=
b2ae2090729ed175<br>Signed-off-by: Frank Lichtenheld &lt;frank@...2641...&g=
t;<br>Acked-by: Gert Doering &lt;gert@...1296...&gt;<br>Gerrit URL: https:/=
/gerrit.openvpn.net/c/openvpn/+/1408<br>Message-Id: &lt;20251127105125.3045=
7-1-gert@...1296...&gt;<br>URL: https://www.mail-archive.com/openvpn-devel@=
lists.sourceforge.net/msg34738.html<br>Signed-off-by: Gert Doering &lt;gert=
@...1296...&gt;<br>---<br>M CMakeLists.txt<br>M config.h.cmake.in<br>M conf=
igure.ac<br>M src/openvpn/mtu.c<br>M src/openvpn/mtu.h<br>M src/openvpn/opt=
ions.c<br>M src/openvpn/socket.c<br>M src/openvpn/syshead.h<br>M src/openvp=
n/tun.c<br>M src/openvpn/tun.h<br>10 files changed, 19 insertions(+), 87 de=
letions(-)<br><br></pre><pre class=3D"blocks" style=3D"font-family: monospa=
ce,monospace; white-space: pre-wrap;">git pull ssh://gerrit.openvpn.net:294=
18/openvpn refs/changes/08/1408/3</pre><pre style=3D"font-family: monospace=
,monospace; white-space: pre-wrap;"><span>diff --git a/CMakeLists.txt b/CMa=
keLists.txt</span><br><span>index e812145..c4d50e4 100644</span><br><span>-=
-- a/CMakeLists.txt</span><br><span>+++ b/CMakeLists.txt</span><br><span>@@=
 -145,7 +145,6 @@</span><br><span>     set(TARGET_ANDROID YES)</span><br><s=
pan>     set(ENABLE_ASYNC_PUSH YES)</span><br><span>     set(ENABLE_SITNL Y=
ES)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set(HAVE_LINUX=
_TYPES_H 1)</span><br><span>     # Wacky workaround as OpenSSL package dete=
ction is otherwise broken (https://stackoverflow.com/questions/45958214/and=
roid-cmake-could-not-find-openssl)</span><br><span>     list(APPEND CMAKE_F=
IND_ROOT_PATH ${OPENSSL_ROOT_DIR})</span><br><span> elseif (${CMAKE_SYSTEM_=
NAME} STREQUAL &quot;Linux&quot;)</span><br><span>@@ -153,9 +152,6 @@</span=
><br><span>     set(ENABLE_ASYNC_PUSH YES)</span><br><span>     set(ENABLE_=
LINUXDCO YES)</span><br><span>     set(ENABLE_SITNL YES)</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-    set(HAVE_DECL_SO_MARK YES)</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-    set(ENABLE_FEATURE_TUN_PERS=
IST 1)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-    set(HAVE_LI=
NUX_TYPES_H 1)</span><br><span>     set(ENABLE_DCO YES)</span><br><span> el=
seif (${CMAKE_SYSTEM_NAME} STREQUAL &quot;FreeBSD&quot;)</span><br><span>  =
   set(TARGET_FREEBSD YES)</span><br><span>@@ -258,8 +254,6 @@</span><br><s=
pan> check_include_files(dmalloc.h HAVE_DMALLOC_H)</span><br><span> check_i=
nclude_files(fcntl.h HAVE_FCNTL_H)</span><br><span> check_include_files(err=
.h HAVE_ERR_H)</span><br><span style=3D"color: hsl(0, 100%, 40%);">-check_i=
nclude_files(linux/if_tun.h HAVE_LINUX_IF_TUN_H)</span><br><span style=3D"c=
olor: hsl(0, 100%, 40%);">-check_include_files(linux/sockios.h HAVE_LINUX_S=
OCKIOS_H)</span><br><span> check_include_files(netdb.h HAVE_NETDB_H)</span>=
<br><span> check_include_files(&quot;${NETEXTRA};netinet/in6.h&quot; HAVE_N=
ETINET_IN_H)</span><br><span> check_include_files(net/if.h HAVE_NET_IF_H)</=
span><br><span>diff --git a/config.h.cmake.in b/config.h.cmake.in</span><br=
><span>index 1c443ab..bf1899c 100644</span><br><span>--- a/config.h.cmake.i=
n</span><br><span>+++ b/config.h.cmake.in</span><br><span>@@ -20,9 +20,6 @@=
</span><br><span> /* Enable debugging support (needed for verb&gt;=3D4) */<=
/span><br><span> #define ENABLE_DEBUG 1</span><br><span> </span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/* We have persist tun capability */</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#cmakedefine ENABLE_FEAT=
URE_TUN_PERSIST</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span=
><br><span> /* Enable internal fragmentation support */</span><br><span> #d=
efine ENABLE_FRAGMENT 1</span><br><span> </span><br><span>@@ -92,10 +89,6 @=
@</span><br><span> /* Define to 1 if you have the `daemon&#39; function. */=
</span><br><span> #cmakedefine HAVE_DAEMON</span><br><span> </span><br><spa=
n style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 if you have the decla=
ration of `SO_MARK&#39;, and to 0 if you</span><br><span style=3D"color: hs=
l(0, 100%, 40%);">-don&#39;t. */</span><br><span style=3D"color: hsl(0, 100=
%, 40%);">-#cmakedefine01 HAVE_DECL_SO_MARK</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-</span><br><span> /* Define to 1 if you have the &lt;=
direct.h&gt; header file. */</span><br><span> #cmakedefine HAVE_DIRECT_H</s=
pan><br><span> </span><br><span>@@ -166,15 +159,6 @@</span><br><span> /* De=
fine to 1 if you have the &lt;limits.h&gt; header file. */</span><br><span>=
 #define HAVE_LIMITS_H 1</span><br><span> </span><br><span style=3D"color: =
hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;linux/if_tun.h&gt; =
header file. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#cmake=
define HAVE_LINUX_IF_TUN_H</span><br><span style=3D"color: hsl(0, 100%, 40%=
);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* Define to 1 i=
f you have the &lt;linux/sockios.h&gt; header file. */</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#cmakedefine HAVE_LINUX_SOCKIOS_H</span><b=
r><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-/* Define to 1 if you have the &lt;linux/types.h&gt=
; header file. */</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#cma=
kedefine HAVE_LINUX_TYPES_H</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-</span><br><span> /* Define to 1 if you have the &lt;lzo1x.h&gt; head=
er file. */</span><br><span> #define HAVE_LZO1X_H 1</span><br><span> </span=
><br><span>diff --git a/configure.ac b/configure.ac</span><br><span>index 4=
4c7b65..030f8de 100644</span><br><span>--- a/configure.ac</span><br><span>+=
++ b/configure.ac</span><br><span>@@ -494,8 +494,8 @@</span><br><span> 	sys=
/mman.h sys/file.h sys/wait.h \</span><br><span> 	unistd.h libgen.h stropts=
.h \</span><br><span> 	syslog.h pwd.h grp.h termios.h \</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	sys/sockio.h sys/uio.h linux/sockios.h \=
</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	linux/types.h linux/=
errqueue.h poll.h sys/epoll.h err.h \</span><br><span style=3D"color: hsl(1=
20, 100%, 40%);">+	sys/sockio.h sys/uio.h \</span><br><span style=3D"color:=
 hsl(120, 100%, 40%);">+	poll.h sys/epoll.h err.h \</span><br><span> ])</sp=
an><br><span> </span><br><span> SOCKET_INCLUDES=3D&quot;</span><br><span>@@=
 -587,12 +587,6 @@</span><br><span> 	[AC_MSG_ERROR([struct sockaddr_in6 not=
 found, needed for ipv6 transport support.])],</span><br><span> 	[[${SOCKET=
_INCLUDES}]]</span><br><span> )</span><br><span style=3D"color: hsl(0, 100%=
, 40%);">-AC_CHECK_DECLS(</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-	[SO_MARK],</span><br><span style=3D"color: hsl(0, 100%, 40%);">-	,</sp=
an><br><span style=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-	[[${SOCKET_INCLUDES}]]</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-)</span><br><span> </span><br><span> save=
d_LDFLAGS=3D&quot;$LDFLAGS&quot;</span><br><span> LDFLAGS=3D&quot;$LDFLAGS =
-Wl,--wrap=3Dexit&quot;</span><br><span>@@ -717,16 +711,6 @@</span><br><spa=
n> 	],</span><br><span> 	[have_tap_header=3D&quot;yes&quot;]</span><br><spa=
n> )</span><br><span style=3D"color: hsl(0, 100%, 40%);">-AC_CHECK_DECLS(</=
span><br><span style=3D"color: hsl(0, 100%, 40%);">-	[TUNSETPERSIST],</span=
><br><span style=3D"color: hsl(0, 100%, 40%);">-	[AC_DEFINE([ENABLE_FEATURE=
_TUN_PERSIST], [1], [We have persist tun capability])],</span><br><span sty=
le=3D"color: hsl(0, 100%, 40%);">-	,</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-	[[</span><br><span style=3D"color: hsl(0, 100%, 40%);">-		#=
ifdef HAVE_LINUX_IF_TUN_H</span><br><span style=3D"color: hsl(0, 100%, 40%)=
;">-		#include &lt;linux/if_tun.h&gt;</span><br><span style=3D"color: hsl(0=
, 100%, 40%);">-		#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);=
">-	]]</span><br><span style=3D"color: hsl(0, 100%, 40%);">-)</span><br><sp=
an> CFLAGS=3D&quot;${old_CFLAGS}&quot;</span><br><span> test &quot;${have_t=
ap_header}&quot; =3D &quot;yes&quot; || AC_MSG_ERROR([no tap header could b=
e found])</span><br><span> </span><br><span>diff --git a/src/openvpn/mtu.c =
b/src/openvpn/mtu.c</span><br><span>index 9e152df..e080ea9 100644</span><br=
><span>--- a/src/openvpn/mtu.c</span><br><span>+++ b/src/openvpn/mtu.c</spa=
n><br><span>@@ -274,6 +274,8 @@</span><br><span> </span><br><span> #if EXTE=
NDED_SOCKET_ERROR_CAPABILITY</span><br><span> </span><br><span style=3D"col=
or: hsl(120, 100%, 40%);">+#include &lt;linux/errqueue.h&gt;</span><br><spa=
n style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> struct probehdr<=
/span><br><span> {</span><br><span>     uint32_t ttl;</span><br><span>diff =
--git a/src/openvpn/mtu.h b/src/openvpn/mtu.h</span><br><span>index 3bbff6f=
..b690149 100644</span><br><span>--- a/src/openvpn/mtu.h</span><br><span>++=
+ b/src/openvpn/mtu.h</span><br><span>@@ -262,8 +262,7 @@</span><br><span> =
</span><br><span> /*</span><br><span>  * EXTENDED_SOCKET_ERROR_CAPABILITY f=
unctions -- print extra error info</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">- * on socket errors, such as PMTU size.  As of 2003.05.11, onl=
y works</span><br><span style=3D"color: hsl(0, 100%, 40%);">- * on Linux 2.=
4+.</span><br><span style=3D"color: hsl(120, 100%, 40%);">+ * on socket err=
ors, such as PMTU size.</span><br><span>  */</span><br><span> </span><br><s=
pan> #if EXTENDED_SOCKET_ERROR_CAPABILITY</span><br><span>diff --git a/src/=
openvpn/options.c b/src/openvpn/options.c</span><br><span>index 62f84dd..5e=
73196 100644</span><br><span>--- a/src/openvpn/options.c</span><br><span>++=
+ b/src/openvpn/options.c</span><br><span>@@ -315,7 +315,7 @@</span><br><sp=
an>     &quot;                  or --fragment max value, whichever is lower=
.\n&quot;</span><br><span>     &quot;--sndbuf size   : Set the TCP/UDP send=
 buffer size.\n&quot;</span><br><span>     &quot;--rcvbuf size   : Set the =
TCP/UDP receive buffer size.\n&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-#if defined(TARGET_LINUX) &amp;&amp; HAVE_DECL_SO_MARK</span=
><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)=
</span><br><span>     &quot;--mark value    : Mark encrypted packets being =
sent with value. The mark value\n&quot;</span><br><span>     &quot;        =
          can be matched in policy routing and packetfilter rules.\n&quot;<=
/span><br><span>     &quot;--bind-dev dev  : Bind to the given device when =
making connection to a peer or\n&quot;</span><br><span>@@ -768,7 +768,7 @@<=
/span><br><span>     &quot;                         (for use with --tls-aut=
h or --tls-crypt).&quot;</span><br><span> #ifdef ENABLE_FEATURE_TUN_PERSIST=
</span><br><span>     &quot;\n&quot;</span><br><span style=3D"color: hsl(0,=
 100%, 40%);">-    &quot;Tun/tap config mode (available with linux 2.4+):\n=
&quot;</span><br><span style=3D"color: hsl(120, 100%, 40%);">+    &quot;Tun=
/tap config mode:\n&quot;</span><br><span>     &quot;--mktun         : Crea=
te a persistent tunnel.\n&quot;</span><br><span>     &quot;--rmtun         =
: Remove a persistent tunnel.\n&quot;</span><br><span>     &quot;--dev tunX=
|tapX : tun/tap device\n&quot;</span><br><span>@@ -1792,7 +1792,7 @@</span>=
<br><span>     SHOW_BOOL(occ);</span><br><span>     SHOW_INT(rcvbuf);</span=
><br><span>     SHOW_INT(sndbuf);</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#if defined(TARGET_LINUX) &amp;&amp; HAVE_DECL_SO_MARK</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</s=
pan><br><span>     SHOW_INT(mark);</span><br><span> #endif</span><br><span>=
     SHOW_INT(sockflags);</span><br><span>@@ -6518,7 +6518,7 @@</span><br><=
span>     }</span><br><span>     else if (streq(p[0], &quot;mark&quot;) &am=
p;&amp; p[1] &amp;&amp; !p[2])</span><br><span>     {</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#if defined(TARGET_LINUX) &amp;&amp; HAVE_D=
ECL_SO_MARK</span><br><span style=3D"color: hsl(120, 100%, 40%);">+#if defi=
ned(TARGET_LINUX)</span><br><span>         VERIFY_PERMISSION(OPT_P_GENERAL)=
;</span><br><span>         options-&gt;mark =3D atoi_warn(p[1], msglevel);<=
/span><br><span> #endif</span><br><span>diff --git a/src/openvpn/socket.c b=
/src/openvpn/socket.c</span><br><span>index 747c7a7..46bedf4 100644</span><=
br><span>--- a/src/openvpn/socket.c</span><br><span>+++ b/src/openvpn/socke=
t.c</span><br><span>@@ -524,7 +524,7 @@</span><br><span> static inline void=
</span><br><span> socket_set_mark(socket_descriptor_t sd, int mark)</span><=
br><span> {</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#if define=
d(TARGET_LINUX) &amp;&amp; HAVE_DECL_SO_MARK</span><br><span style=3D"color=
: hsl(120, 100%, 40%);">+#if defined(TARGET_LINUX)</span><br><span>     if =
(mark &amp;&amp; setsockopt(sd, SOL_SOCKET, SO_MARK, (void *)&amp;mark, siz=
eof(mark)) !=3D 0)</span><br><span>     {</span><br><span>         msg(M_WA=
RN, &quot;NOTE: setsockopt SO_MARK=3D%d failed&quot;, mark);</span><br><spa=
n>diff --git a/src/openvpn/syshead.h b/src/openvpn/syshead.h</span><br><spa=
n>index 90045a9..c6f2608 100644</span><br><span>--- a/src/openvpn/syshead.h=
</span><br><span>+++ b/src/openvpn/syshead.h</span><br><span>@@ -185,26 +18=
5,19 @@</span><br><span> </span><br><span> #if defined(TARGET_LINUX) || def=
ined(TARGET_ANDROID)</span><br><span> </span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#ifdef HAVE_LINUX_IF_TUN_H</span><br><span style=3D"color:=
 hsl(0, 100%, 40%);">-#include &lt;linux/if_tun.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#define EXTENDED_SOCKET_ERROR_CAPABILITY =
1</span><br><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#ifdef TARGET_LINUX</span><br><span s=
tyle=3D"color: hsl(120, 100%, 40%);">+#define ENABLE_FEATURE_TUN_PERSIST</s=
pan><br><span> #endif</span><br><span> </span><br><span style=3D"color: hsl=
(120, 100%, 40%);">+#include &lt;linux/if_tun.h&gt;</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#include &lt;linux/sockios.h&gt;</span><b=
r><span style=3D"color: hsl(120, 100%, 40%);">+</span><br><span> #ifdef HAV=
E_NETINET_IP_H</span><br><span> #include &lt;netinet/ip.h&gt;</span><br><sp=
an> #endif</span><br><span> </span><br><span style=3D"color: hsl(0, 100%, 4=
0%);">-#ifdef HAVE_LINUX_SOCKIOS_H</span><br><span style=3D"color: hsl(0, 1=
00%, 40%);">-#include &lt;linux/sockios.h&gt;</span><br><span style=3D"colo=
r: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(0, 100%,=
 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_=
LINUX_TYPES_H</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#include=
 &lt;linux/types.h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">=
-#endif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><sp=
an style=3D"color: hsl(0, 100%, 40%);">-#ifdef HAVE_LINUX_ERRQUEUE_H</span>=
<br><span style=3D"color: hsl(0, 100%, 40%);">-#include &lt;linux/errqueue.=
h&gt;</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br=
><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #ifdef HAVE_N=
ETINET_TCP_H</span><br><span> #include &lt;netinet/tcp.h&gt;</span><br><spa=
n> #endif</span><br><span>@@ -361,15 +354,6 @@</span><br><span> #endif</spa=
n><br><span> </span><br><span> /*</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">- * Do we have the capability to report extended socket errors?<=
/span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#if defined(HAVE_LINUX_TYPES_H) &amp;&am=
p; defined(HAVE_LINUX_ERRQUEUE_H)</span><br><span style=3D"color: hsl(0, 10=
0%, 40%);">-#define EXTENDED_SOCKET_ERROR_CAPABILITY 1</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#else</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-#define EXTENDED_SOCKET_ERROR_CAPABILITY 0</span><br><span=
 style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color=
: hsl(0, 100%, 40%);">-</span><br><span style=3D"color: hsl(0, 100%, 40%);"=
>-/*</span><br><span>  * Does this platform support linux-style IP_PKTINFO<=
/span><br><span>  * or bsd-style IP_RECVDSTADDR ?</span><br><span>  */</spa=
n><br><span>@@ -397,14 +381,6 @@</span><br><span> #endif</span><br><span> <=
/span><br><span> /*</span><br><span style=3D"color: hsl(0, 100%, 40%);">- *=
 Disable ESEC</span><br><span style=3D"color: hsl(0, 100%, 40%);">- */</spa=
n><br><span style=3D"color: hsl(0, 100%, 40%);">-#if 0</span><br><span styl=
e=3D"color: hsl(0, 100%, 40%);">-#undef EXTENDED_SOCKET_ERROR_CAPABILITY</s=
pan><br><span style=3D"color: hsl(0, 100%, 40%);">-#define EXTENDED_SOCKET_=
ERROR_CAPABILITY 0</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#en=
dif</span><br><span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span s=
tyle=3D"color: hsl(0, 100%, 40%);">-/*</span><br><span>  * Do we have a sys=
log capability?</span><br><span>  */</span><br><span> #if defined(HAVE_OPEN=
LOG) &amp;&amp; defined(HAVE_SYSLOG)</span><br><span>diff --git a/src/openv=
pn/tun.c b/src/openvpn/tun.c</span><br><span>index 06b7ae5..7c61dcf 100644<=
/span><br><span>--- a/src/openvpn/tun.c</span><br><span>+++ b/src/openvpn/t=
un.c</span><br><span>@@ -2055,10 +2055,6 @@</span><br><span> </span><br><sp=
an> #elif defined(TARGET_LINUX)</span><br><span> </span><br><span style=3D"=
color: hsl(0, 100%, 40%);">-#ifndef HAVE_LINUX_SOCKIOS_H</span><br><span st=
yle=3D"color: hsl(0, 100%, 40%);">-#error header file linux/sockios.h requi=
red</span><br><span style=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><=
span style=3D"color: hsl(0, 100%, 40%);">-</span><br><span> #if !PEDANTIC</=
span><br><span> </span><br><span> void</span><br><span>@@ -2186,11 +2182,6 =
@@</span><br><span> </span><br><span> #ifdef ENABLE_FEATURE_TUN_PERSIST</sp=
an><br><span> </span><br><span style=3D"color: hsl(0, 100%, 40%);">-/* TUNS=
ETGROUP appeared in 2.6.23 */</span><br><span style=3D"color: hsl(0, 100%, =
40%);">-#ifndef TUNSETGROUP</span><br><span style=3D"color: hsl(0, 100%, 40=
%);">-#define TUNSETGROUP _IOW(&#39;T&#39;, 206, int)</span><br><span style=
=3D"color: hsl(0, 100%, 40%);">-#endif</span><br><span style=3D"color: hsl(=
0, 100%, 40%);">-</span><br><span> void</span><br><span> tuncfg(const char =
*dev, const char *dev_type, const char *dev_node, int persist_mode,</span><=
br><span>        const char *username, const char *groupname, const struct =
tuntap_options *options,</span><br><span>diff --git a/src/openvpn/tun.h b/s=
rc/openvpn/tun.h</span><br><span>index e13f99f..876f147 100644</span><br><s=
pan>--- a/src/openvpn/tun.h</span><br><span>+++ b/src/openvpn/tun.h</span><=
br><span>@@ -278,9 +278,11 @@</span><br><span> </span><br><span> int read_t=
un(struct tuntap *tt, uint8_t *buf, int len);</span><br><span> </span><br><=
span style=3D"color: hsl(120, 100%, 40%);">+#ifdef ENABLE_FEATURE_TUN_PERSI=
ST</span><br><span> void tuncfg(const char *dev, const char *dev_type, cons=
t char *dev_node, int persist_mode,</span><br><span>             const char=
 *username, const char *groupname, const struct tuntap_options *options,</s=
pan><br><span>             openvpn_net_ctx_t *ctx);</span><br><span style=
=3D"color: hsl(120, 100%, 40%);">+#endif</span><br><span> </span><br><span>=
 const char *guess_tuntap_dev(const char *dev, const char *dev_type, const =
char *dev_node,</span><br><span>                              struct gc_are=
na *gc);</span><br><span></span><br></pre><p>To view, visit <a href=3D"http=
://gerrit.openvpn.net/c/openvpn/+/1408?usp=3Demail">change 1408</a>. To uns=
ubscribe, or for help writing mail filters, visit <a href=3D"http://gerrit.=
openvpn.net/settings?usp=3Demail">settings</a>.</p><div itemscope itemtype=
=3D"http://schema.org/EmailMessage"><div itemscope itemprop=3D"action" item=
type=3D"http://schema.org/ViewAction"><link itemprop=3D"url" href=3D"http:/=
/gerrit.openvpn.net/c/openvpn/+/1408?usp=3Demail"/><meta itemprop=3D"name" =
content=3D"View Change"/></div></div>

<div style=3D"display:none"> Gerrit-MessageType: newpatchset </div>
<div style=3D"display:none"> Gerrit-Project: openvpn </div>
<div style=3D"display:none"> Gerrit-Branch: master </div>
<div style=3D"display:none"> Gerrit-Change-Id: Ie460eec488a8781e3b1ee4f8b2a=
e2090729ed175 </div>
<div style=3D"display:none"> Gerrit-Change-Number: 1408 </div>
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

--+4C51uQEC6A=--

