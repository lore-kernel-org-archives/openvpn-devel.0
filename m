Message-ID: <416D2FE2.7080408@...292...>
From: "Peter 'Luna' Runestig" <peter+openvpn@...292...>
MIME-Version: 1.0
Subject: [Openvpn-devel] PATCH[1/2]: Use certificates from MS Cert Store with CryptoAPI
Sender: openvpn-devel-admin@lists.sourceforge.net
Errors-To: openvpn-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>,
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
Date: Wed Oct 13 06:45:20 2004
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Hi all!

Let me first say how impressed with the smooth functionality of this
excellent piece of software! I have evaluated some other, commercial,
SSL/TLS VPN solutions, but this is the best one, and at a much lower
price... :-)

What I really wanted to use with OpenVPN, is smart cards for user
authentication, on the Microsoft Windows platform. I have written some
code that adds the option of using certificates (and their private
keys), that resides in the Windows Certificate System Store. That makes
it possible to use any smart card, supported by Windows, but also any
kind of certificate, residing in the Cert Store, that you have access to
the private key of. I have tested this code with a couple of different
smart cards (GemSAFE, Cryptoflex and Swedish Post Office eID) on the
client side, and also an imported PKCS12 software certificate on the
server side.

The code adds a new config option: cryptoapicert
To select a certificate, based on a substring search in the
certificate's subject:

cryptoapicert "SUBJ:Peter Runestig"

To select a certificate, based on certificate's thumbprint:

cryptoapicert "THUMB:f6 49 24 41 01 b4 ..."

The thumbprint hex string can easily be copy-and-pasted from the Windows
Certificate Store GUI.

Unfortunately, this code don't build with MinGW; e.g. the
CryptAcquireCertificatePrivateKey() isn't implemented in MinGW, so I had
to use Microsoft Visual C++ 6.0. So the patch included in this post is
actually my hack to build OpenVPN using MSVC++, which must be applied
before the actual CryptoAPI patch, which will be in my next post (I
split it in two, so the posts don't get so big).

To build this, using MSVC 6.0:

o Unpack openvpn-2.0_beta11.zip, apply the MSVC patch in this post, and
the CryptoAPI patch in my next post.

o If the OpenSSL and/or LZO libraries (built with MSVC or something else
that gives you .LIB files) isn't reachable using the INCLUDE and LIB
environment variables, edit the 'makefile.w32-vc' file to point them out.

o nmake -f makefile.w32-vc

Here is the MSVC patch:
-----8<----------8<----------8<----------8<----------8<----------8<----------8<-----
diff -uN openvpn-2.0_beta11.orig/config-win32.h openvpn-2.0_beta11.msvc/config-win32.h
--- openvpn-2.0_beta11.orig/config-win32.h	2004-08-17 17:32:44.000000000 +0200
+++ openvpn-2.0_beta11.msvc/config-win32.h	2004-10-12 15:34:12.000000000 +0200
@@ -88,7 +88,9 @@
 #define HAVE_CHDIR 1

 /* Define to 1 if your compiler supports GNU GCC-style variadic macros */
+#ifndef _MSC_VER /* Defines MSFT compiler version. Defined as 1200 for MSVC++ 6.0. */
 #define HAVE_CPP_VARARG_MACRO_GCC 1
+#endif

 /* Define to 1 if you have the <ctype.h> header file. */
 #define HAVE_CTYPE_H 1
@@ -125,7 +127,9 @@
 #define HAVE_STDARG_H 1

 /* Define to 1 if you have the <stdint.h> header file. */
+#ifndef _MSC_VER
 #define HAVE_STDINT_H 1
+#endif

 /* Define to 1 if you have the <stdio.h> header file. */
 #define HAVE_STDIO_H 1
@@ -146,13 +150,17 @@
 #define HAVE_SYSTEM 1

 /* Define to 1 if you have the <sys/file.h> header file. */
+#ifndef _MSC_VER
 #define HAVE_SYS_FILE_H 1
+#endif

 /* Define to 1 if you have the <sys/stat.h> header file. */
 #define HAVE_SYS_STAT_H 1

 /* Define to 1 if you have the <sys/time.h> header file. */
+#ifndef _MSC_VER
 #define HAVE_SYS_TIME_H 1
+#endif

 /* Define to 1 if you have the <sys/types.h> header file. */
 #define HAVE_SYS_TYPES_H 1
@@ -161,7 +169,9 @@
 #define HAVE_TIME 1

 /* Define to 1 if you have the <unistd.h> header file. */
+#ifndef _MSC_VER
 #define HAVE_UNISTD_H 1
+#endif

 /* Define to 1 if you have the `vsnprintf' function. */
 #define HAVE_VSNPRINTF 1
@@ -204,10 +214,16 @@
 #define STDC_HEADERS 1

 /* A string representing our target */
+#ifdef _MSC_VER
+#define TARGET_ALIAS "Win32-MSVC++"
+#else
 #define TARGET_ALIAS "Win32-MinGW"
+#endif

 /* Define to 1 if you can safely include both <sys/time.h> and <time.h>. */
+#ifndef _MSC_VER
 #define TIME_WITH_SYS_TIME 1
+#endif

 /* Use OpenSSL crypto library */
 #define USE_CRYPTO 1
@@ -244,3 +260,21 @@
 #ifdef USE_PTHREAD
 #error The Windows version of OpenVPN does not support PTHREAD yet
 #endif
+
+#ifdef _MSC_VER
+/* MSVC++ hacks */
+#include <io.h>
+#include <direct.h>
+#define vsnprintf _vsnprintf
+#define vsnwprintf _vsnwprintf
+#define snwprintf _snwprintf
+#define write _write
+#define open _open
+#define read _read
+#define close _close
+#define chdir _chdir
+#define S_IRUSR 0
+#define S_IWUSR 0
+typedef int intptr_t;
+#undef S_NORMAL
+#endif
diff -uN openvpn-2.0_beta11.orig/error.h openvpn-2.0_beta11.msvc/error.h
--- openvpn-2.0_beta11.orig/error.h	2004-08-15 07:28:36.000000000 +0200
+++ openvpn-2.0_beta11.msvc/error.h	2004-10-12 15:31:57.000000000 +0200
@@ -135,7 +135,9 @@
 #define HAVE_VARARG_MACROS
 #define msg(flags, args...) do { if (MSG_TEST(flags)) x_msg((flags), args); } while (false)
 #else
-#warning this compiler appears to lack vararg macros which will cause a significant degradation in efficiency (you can ignore this warning if you are using LCLINT)
+# ifndef _MSC_VER	/* MSVC++ doesn't have #warning... */
+# warning this compiler appears to lack vararg macros which will cause a significant degradation in efficiency (you can ignore this warning if you are using LCLINT)
+# endif
 #define msg x_msg
 #endif

diff -uN openvpn-2.0_beta11.orig/makefile.w32-vc openvpn-2.0_beta11.msvc/makefile.w32-vc
--- openvpn-2.0_beta11.orig/makefile.w32-vc	1970-01-01 01:00:00.000000000 +0100
+++ openvpn-2.0_beta11.msvc/makefile.w32-vc	2004-10-12 13:29:04.000000000 +0200
@@ -0,0 +1,167 @@
+# This makefile builds the user-mode component
+# of OpenVPN for WIN32 in the MSVC++ environment.
+#
+# Build Dependencies:
+#	OpenSSL		(SSL/TLS/crypto library)
+#	LZO		(real-time compression library)
+#
+# Targets:
+#	static -- link statically with OpenSSL
+#	dynamic -- link dynamically with OpenSSL
+#
+# Note that LZO is always linked statically.
+
+# Change these to point to your OpenSSL and LZO top-level
+# directories.
+
+OPENSSL = \src\openssl-0.9.7d
+OPENSSL_STATIC = libeay32s.lib ssleay32s.lib
+#OPENSSL_STATIC = libeay32sd.lib ssleay32sd.lib
+OPENSSL_DYNAMIC = libeay32.lib ssleay32.lib
+#OPENSSL_DYNAMIC = libeay32d.lib ssleay32d.lib
+
+LZO = \src\lzo-1.08.vc
+
+INCLUDE_DIRS = -I$(OPENSSL)/include -I$(LZO)/include
+
+LIBS = lzo.lib ws2_32.lib iphlpapi.lib winmm.lib gdi32.lib advapi32.lib
+
+LIB_DIRS = -LIBPATH:$(OPENSSL)\out -LIBPATH:$(LZO)
+
+EXE = openvpn.exe
+
+CPP=cl.exe
+# release:
+CPP_PROJ=/nologo /MD /W3 /G5 /O2 -DNDEBUG -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CONSOLE -D_MBCS $(INCLUDE_DIRS) /FD /c
+# debug:
+#CPP_PROJ=/nologo /MDd /W3 /G5 /Zi /Od -D_DEBUG -DWIN32 -DWIN32_LEAN_AND_MEAN -D_CONSOLE -D_MBCS $(INCLUDE_DIRS) /FD /c
+
+LINK32=link.exe
+# release:
+LINK32_FLAGS=/nologo /subsystem:console /incremental:no /out:"$(EXE)"
+# debug:
+#LINK32_FLAGS=/nologo /subsystem:console /incremental:no /debug /out:"$(EXE)"
+
+# Stuff below this point usually doesn't need to be changed
+
+HEADERS = \
+	basic.h \
+	buffer.h \
+	circ_list.h common.h \
+	tap-win32/common.h \
+        config-win32.h \
+	crypto.h \
+	errlevel.h \
+	error.h \
+	event.h \
+        fdmisc.h \
+	forward-inline.h \
+	forward.h \
+	fragment.h \
+        gremlin.h \
+	helper.h \
+	init.h \
+	integer.h \
+	interval.h \
+	list.h \
+	lzo.h \
+	mbuf.h \
+	memdbg.h \
+	misc.h \
+	mroute.h \
+	mss.h \
+	mtcp.h \
+	mtu.h \
+	mudp.h \
+	multi.h \
+	occ-inline.h \
+	occ.h \
+        openvpn.h \
+	options.h \
+	otime.h \
+	packet_id.h \
+	perf.h \
+	ping-inline.h \
+	ping.h \
+	pool.h \
+        proto.h \
+	proxy.h \
+	push.h \
+	reliable.h \
+	route.h \
+	schedule.h \
+	session_id.h \
+        shaper.h \
+	sig.h \
+	socket.h \
+	socks.h \
+	ssl.h \
+        status.h \
+	syshead.h \
+        thread.h \
+	tun.h \
+	win32.h
+
+OBJS =  buffer.obj \
+	crypto.obj \
+	error.obj \
+	event.obj \
+	fdmisc.obj \
+	forward.obj \
+        fragment.obj \
+	gremlin.obj \
+	helper.obj \
+	inet_aton.obj \
+	init.obj \
+	interval.obj \
+        list.obj \
+	lzo.obj \
+	mbuf.obj \
+	misc.obj \
+	mroute.obj \
+	mss.obj \
+	mtcp.obj \
+	mtu.obj \
+	mudp.obj \
+	multi.obj \
+	occ.obj \
+        openvpn.obj \
+	options.obj \
+	otime.obj \
+	packet_id.obj \
+	perf.obj \
+	ping.obj \
+        pool.obj \
+	proxy.obj \
+	push.obj \
+	reliable.obj \
+        route.obj \
+	schedule.obj \
+	session_id.obj \
+	shaper.obj \
+	sig.obj \
+	socket.obj \
+        socks.obj \
+	ssl.obj \
+	status.obj \
+	thread.obj \
+	tun.obj \
+	win32.obj
+
+dynamic : $(OBJS)
+	$(LINK32) @<<
+	$(LINK32_FLAGS) $(LIB_DIRS) $(LIBS) $(OPENSSL_DYNAMIC) $(OBJS)
+<<
+
+static : $(OBJS)
+	$(LINK32) @<<
+	$(LINK32_FLAGS) $(LIB_DIRS) $(LIBS) $(OPENSSL_STATIC) $(OBJS)
+<<
+
+clean :
+	del /Q $(OBJS) $(EXE) *.idb *.pdb
+
+.c.obj::
+   $(CPP) @<<
+   $(CPP_PROJ) $<
+<<
diff -uN openvpn-2.0_beta11.orig/otime.c openvpn-2.0_beta11.msvc/otime.c
--- openvpn-2.0_beta11.orig/otime.c	2004-08-15 07:28:36.000000000 +0200
+++ openvpn-2.0_beta11.msvc/otime.c	2004-10-11 12:23:35.000000000 +0200
@@ -176,7 +176,7 @@

       QueryPerformanceFrequency((LARGE_INTEGER *) &frequency);

-      counterPerMicrosecond = (double)frequency / 1000000.0f;
+      counterPerMicrosecond = (double) ((__int64) frequency) / 1000000.0f;

       time(&t);
       QueryPerformanceCounter((LARGE_INTEGER *) &counter);
@@ -191,7 +191,7 @@
     }

   tv->tv_sec = (counter / frequency) + timeSecOffset;
-  tv->tv_usec = ((__int64)(counter / counterPerMicrosecond) % 1000000);
+  tv->tv_usec = ((__int64) (((__int64) counter) / counterPerMicrosecond) % 1000000);

   return 0;
 }
diff -uN openvpn-2.0_beta11.orig/tun.c openvpn-2.0_beta11.msvc/tun.c
--- openvpn-2.0_beta11.orig/tun.c	2004-08-15 16:59:10.000000000 +0200
+++ openvpn-2.0_beta11.msvc/tun.c	2004-10-11 12:21:48.000000000 +0200
@@ -2303,9 +2303,9 @@
 static bool
 get_adapter_ip_netmask (const IP_ADAPTER_INFO *ai, const int n, in_addr_t *ip, in_addr_t *netmask)
 {
+  bool ret = false;
   *ip = 0;
   *netmask = 0;
-  bool ret = false;

   if (ai)
     {
-----8<----------8<----------8<----------8<----------8<----------8<----------8<-----

-- 
Peter 'Luna' Runestig (fd. Altberg), Sweden <peter@...292...>
PGP Key ID: 0xD07BBE13
Fingerprint: 7B5C 1F48 2997 C061 DE4B  42EA CB99 A35C D07B BE13
AOL Instant Messenger Screen name: PRunestig
Yahoo! Messenger profile name: altberg


