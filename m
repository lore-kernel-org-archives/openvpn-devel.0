Date: Mon, 5 Mar 2007 11:22:52 +0000
From: Roy Marples <uberlord@...594...>
Message-ID: <20070305112252.64e20e08@...1007...>
In-Reply-To: <45E5586D.9030507@...41...>
References: <45E5586D.9030507@...41...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary=MP_YoBjVUEkxBkwaTrjiIv.B3+
Subject: Re: [Openvpn-devel] OpenVPN 2.1_rc2 released
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--MP_YoBjVUEkxBkwaTrjiIv.B3+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wed, 28 Feb 2007 03:24:45 -0700
James Yonan <jim@...41...> wrote:

> OpenVPN 2.1_rc2 has been released which includes a number of 
> miscellaneous fixes, including better Vista support on 32-bit x86.

Attached is a patch that cleans up configure on FreeBSD for recent
autotool versions that require that all .h files have to be compiled.

Also, FreeBSD install does not support GNU long options which the
Makefile in easy-rsa/2.0 uses (not checked the others as we don't
install those on Gentoo)

Thanks

Roy Marples
--MP_YoBjVUEkxBkwaTrjiIv.B3+
Content-Type: text/x-patch; name=openvpn-freebsd.patch
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment; filename=openvpn-freebsd.patch

diff -ur openvpn-2.1_rc2.orig/configure.ac openvpn-2.1_rc2/configure.ac
--- openvpn-2.1_rc2.orig/configure.ac	2007-02-28 07:34:32 +0000
+++ openvpn-2.1_rc2/configure.ac	2007-03-05 11:17:24 +0000
@@ -284,12 +284,44 @@
 		 sys/mman.h fcntl.h sys/file.h stdlib.h stdint.h dnl
 		 stdarg.h unistd.h signal.h stdio.h string.h dnl
 		 strings.h ctype.h errno.h syslog.h pwd.h grp.h dnl
-		 net/if_tun.h net/if.h stropts.h sys/sockio.h dnl
-		 netinet/in.h netinet/in_systm.h netinet/ip.h dnl
-		 netinet/if_ether.h netinet/tcp.h resolv.h arpa/inet.h dnl
+		 net/if_tun.h stropts.h sys/sockio.h dnl
+		 netinet/in.h netinet/in_systm.h dnl
+		 netinet/tcp.h arpa/inet.h dnl
 		 netdb.h sys/uio.h linux/if_tun.h linux/sockios.h dnl
 		 linux/types.h sys/poll.h sys/epoll.h err.h dnl
 )
+AC_CHECK_HEADERS(net/if.h,,,
+		 [#ifdef HAVE_SYS_SOCKET_H 
+		  # include <sys/socket.h>
+		  #endif
+		 ])
+AC_CHECK_HEADERS(netinet/ip.h,,,
+		 [#ifdef HAVE_SYS_TYPES_H
+		  # include <sys/types.h>
+		  #endif
+		  #ifdef HAVE_NETINET_IN_H
+		  # include <netinet/in.h>
+		  #endif
+		  #ifdef HAVE_NETINET_IN_SYSTM_H
+		  # include <netinet/in_systm.h>
+		  #endif
+		 ])
+AC_CHECK_HEADERS(netinet/if_ether.h,,,
+		 [#ifdef HAVE_SYS_TYPES_H
+		  # include <sys/types.h>
+		  #endif
+		  #ifdef HAVE_SYS_SOCKET_H
+		  # include <sys/socket.h>
+		  #endif
+		  #ifdef HAVE_NETINET_IN_H
+		  # include <netinet/in.h>
+		  #endif
+		 ])
+AC_CHECK_HEADERS(resolv.h,,,
+		 [#ifdef HAVE_NETINET_IN_H 
+		  # include <netinet/in.h>
+		  #endif
+		 ])
 AC_CHECK_HEADERS(linux/errqueue.h,,,
 	[#ifdef HAVE_LINUX_TYPES_H
 	 # include <linux/types.h>
diff -ur openvpn-2.1_rc2.orig/easy-rsa/2.0/Makefile openvpn-2.1_rc2/easy-rsa/2.0/Makefile
--- openvpn-2.1_rc2.orig/easy-rsa/2.0/Makefile	2006-10-15 23:30:18 +0100
+++ openvpn-2.1_rc2/easy-rsa/2.0/Makefile	2007-03-05 11:17:29 +0000
@@ -7,7 +7,7 @@
 	echo "Run make install DESTDIR=/usr/share/somewhere"
 
 install:
-	install -c --directory "${DESTDIR}/${PREFIX}"
-	install -c --mode=0755 build-* "${DESTDIR}/${PREFIX}"
-	install -c --mode=0755 clean-all list-crl inherit-inter pkitool revoke-full sign-req whichopensslcnf "${DESTDIR}/${PREFIX}"
-	install -c --mode=0644 openssl-0.9.6.cnf openssl.cnf README vars "${DESTDIR}/${PREFIX}"
+	install -d "${DESTDIR}/${PREFIX}"
+	install -m 0755 build-* "${DESTDIR}/${PREFIX}"
+	install -m 0755 clean-all list-crl inherit-inter pkitool revoke-full sign-req whichopensslcnf "${DESTDIR}/${PREFIX}"
+	install -m 0644 openssl-0.9.6.cnf openssl.cnf README vars "${DESTDIR}/${PREFIX}"

--MP_YoBjVUEkxBkwaTrjiIv.B3+--

