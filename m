From: Matthias Andree <ma+ovpnd@...31...>
Message-ID: <20050720091614.GA29389@...33...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="3MwIy2ne0vdjdPXF"
Content-Disposition: inline
Subject: [Openvpn-devel] [PATCH 1/2] 2.0.1-rc6: include linux/types.h before linux/errqueue.h
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
Date: Wed Jul 20 02:17:04 2005
To: openvpn-devel@lists.sourceforge.net

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

The attached patch includes linux/types.h before checking linux/errqueue.h, as
future autoconf versions might otherwise assume linux/errqueue.h isn't
present, fixing a huge configure warnings along the way.

-- 
Matthias Andree

--3MwIy2ne0vdjdPXF
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-2.0.1-rc6.patch1"

Index: ChangeLog
===================================================================
RCS file: /cvsroot/openvpn/openvpn/ChangeLog,v
retrieving revision 1.135
diff -u -r1.135 ChangeLog
--- ChangeLog	15 Jul 2005 18:54:00 -0000	1.135
+++ ChangeLog	20 Jul 2005 09:13:35 -0000
@@ -3,6 +3,11 @@
 
 $Id: ChangeLog,v 1.135 2005/07/15 18:54:00 jimyonan Exp $
 
+2005.XX.XX -- Version 2.0.1-rc7
+
+* Include linux/types.h before checking for linux/errqueue.h (Matthias
+  Andree).
+
 2005.07.15 -- Version 2.0.1-rc6
 
 * Commented out "user nobody" and "group nobody" in sample
@@ -26,7 +31,7 @@
 
 2005.06.15 -- Version 2.0.1-rc4
 
-* Support LZO 2.0, including changes to configure script to
+* Support LZO 2.00, including changes to configure script to
   autodetect LZO version.
 
 2005.06.12 -- Version 2.0.1-rc3
Index: configure.ac
===================================================================
RCS file: /cvsroot/openvpn/openvpn/configure.ac,v
retrieving revision 1.143
diff -u -r1.143 configure.ac
--- configure.ac	15 Jul 2005 18:54:00 -0000	1.143
+++ configure.ac	20 Jul 2005 09:13:35 -0000
@@ -264,9 +264,13 @@
 		 netinet/in.h netinet/in_systm.h netinet/ip.h dnl
 		 netinet/if_ether.h netinet/tcp.h resolv.h arpa/inet.h dnl
 		 netdb.h sys/uio.h linux/if_tun.h linux/sockios.h dnl
-		 linux/types.h linux/errqueue.h dnl
-                 sys/poll.h sys/epoll.h
+		 linux/types.h sys/poll.h sys/epoll.h dnl
 )
+AC_CHECK_HEADERS(linux/errqueue.h,,,
+	[#ifdef HAVE_LINUX_TYPES_H
+	 # include <linux/types.h>
+	 #endif
+	])
 AC_CACHE_SAVE
 
 dnl check that in_addr_t is defined

--3MwIy2ne0vdjdPXF--

