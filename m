Date: Mon, 18 Jun 2007 21:41:17 +0000
From: "Johnny C. Lam" <jlam@...601...>
Message-ID: <20070618214117.GA12194@...438...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="2fHTh5uZTiUOsy+g"
Content-Disposition: inline
Subject: [Openvpn-devel] OpenVPN 2.1_rc4 fixes for NetBSD
Reply-To: "Johnny C. Lam" <jlam@...601...>
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
To: openvpn-devel@lists.sourceforge.net

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

I've attached diff that includes the following changes for NetBSD:

(1) Teach OpenVPN about NetBSD's tap(4) driver.
	(syshead.h, tun.c, config.h.in)

(2) Fix header detection for <net/if.h> and <net/if_ether.h> in the
    aftermath of the FreeBSD autoconf changes.  These changes should
    be neutral for FreeBSD but are necessary for NetBSD.
	(configure.ac)

I hope that these changes will make it into the OpenVPN 2.1 release.

	Cheers,

	-- Johnny Lam <jlam@...601...>

--2fHTh5uZTiUOsy+g
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn.diff"

--- syshead.h.orig	2007-04-25 17:38:46.000000000 -0400
+++ syshead.h
@@ -262,6 +262,10 @@
 
 #ifdef TARGET_NETBSD
 
+#ifdef HAVE_NET_IF_TAP_H
+#include <net/if_tap.h>
+#endif
+
 #ifdef HAVE_NET_IF_TUN_H
 #include <net/if_tun.h>
 #endif
--- tun.c.orig	2006-10-15 23:30:20.000000000 +0100
+++ tun.c	2007-02-12 10:52:42.000000000 +0000
@@ -945,7 +945,37 @@
 	  if (dynamic && !has_digit((unsigned char *)dev))
 	    {
 	      int i;
-	      for (i = 0; i < 256; ++i)
+#if defined(TAPGIFNAME)
+	      /*
+	       * Perhaps we have a cloning device.  Try opening
+	       * the device without any appended digits,
+	       * and use ioctl(,TAPGIFNAME,) to get the resulting
+	       * interface name.
+	       */
+	      openvpn_snprintf (tunname, sizeof (tunname), "/dev/%s", dev);
+	      if ((tt->fd = open (tunname, O_RDWR)) > 0)
+		{
+		  struct ifreq ifr;
+ 		  if (ioctl (tt->fd, TAPGIFNAME, (void*)&ifr) < 0)
+		    {
+		      msg (D_READ_WRITE | M_ERRNO,
+			   "ioctl(,TAPGIFNAME,) failed for %s", tunname);
+		      close(tt->fd);
+		    }
+		  else
+		    {
+		      strlcpy (dynamic_name, ifr.ifr_name,
+			       sizeof (dynamic_name));
+		      dynamic_opened = true;
+		      msg (M_INFO, "TUN/TAP dynamic interface %s opened",
+			   dynamic_name);
+		    }
+		}
+	      if (!dynamic_opened)
+ 		msg (D_READ_WRITE | M_ERRNO, "Tried opening %s (failed)",
+		     tunname);
+#endif /* TAPGIFNAME */
+	      for (i = 0; i < 256 && !dynamic_opened; ++i)
 		{
 		  openvpn_snprintf (tunname, sizeof (tunname),
 				    "/dev/%s%d", dev, i);
--- config.h.in.orig	2007-04-25 19:54:40.000000000 -0400
+++ config.h.in
@@ -216,6 +216,9 @@
 /* Define to 1 if you have the <net/if.h> header file. */
 #undef HAVE_NET_IF_H
 
+/* Define to 1 if you have the <net/if_tap.h> header file. */
+#undef HAVE_NET_IF_TAP_H
+
 /* Define to 1 if you have the <net/if_tun.h> header file. */
 #undef HAVE_NET_IF_TUN_H
 
--- configure.ac.orig	2007-04-25 17:38:46.000000000 -0400
+++ configure.ac
@@ -285,14 +285,17 @@ AC_CHECK_HEADERS(sys/time.h sys/socket.h
 		 sys/mman.h fcntl.h sys/file.h stdlib.h stdint.h dnl
 		 stdarg.h unistd.h signal.h stdio.h string.h dnl
 		 strings.h ctype.h errno.h syslog.h pwd.h grp.h dnl
-		 net/if_tun.h stropts.h sys/sockio.h dnl
+		 net/if_tap.h net/if_tun.h stropts.h sys/sockio.h dnl
 		 netinet/in.h netinet/in_systm.h dnl
 		 netinet/tcp.h arpa/inet.h dnl
 		 netdb.h sys/uio.h linux/if_tun.h linux/sockios.h dnl
 		 linux/types.h sys/poll.h sys/epoll.h err.h dnl
 )
 AC_CHECK_HEADERS(net/if.h,,,
-		 [#ifdef HAVE_SYS_SOCKET_H 
+		 [#ifdef HAVE_SYS_TYPES_H 
+		  # include <sys/types.h>
+		  #endif
+		  #ifdef HAVE_SYS_SOCKET_H 
 		  # include <sys/socket.h>
 		  #endif
 		 ])
@@ -314,6 +317,9 @@ AC_CHECK_HEADERS(netinet/if_ether.h,,,
 		  #ifdef HAVE_SYS_SOCKET_H
 		  # include <sys/socket.h>
 		  #endif
+		  #ifdef HAVE_NET_IF_H
+		  # include <net/if.h>
+		  #endif
 		  #ifdef HAVE_NETINET_IN_H
 		  # include <netinet/in.h>
 		  #endif

--2fHTh5uZTiUOsy+g--

