From: Thomas Glanzmann <sithglan@...162...>
Subject: Re: [Openvpn-devel] ipv6 netbsd support
Message-ID: <20040130082021.GA7679@...162...>
References: <Pine.LNX.4.31.0401281414440.15882-100000@...161...>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="FCuugMFkClbJLl1L"
Content-Disposition: inline
In-Reply-To: <Pine.LNX.4.31.0401281414440.15882-100000@...161...>
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
Date: Fri Jan 30 19:08:47 2004
To: openvpn-devel@lists.sourceforge.net

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi,

> is there an ipv6-netbsd support planed ?  Can you give me detailed
> information what must be changed so that I can try to write a patch?

I thought I had made a netbsd patch ready, but I can't find it anylonger.
But it should be quiet easy looking at the patches which were necessary
to enable ipv6 tunnels via tun device on OpenBSD and FreeBSD. You should
also have a look at the linux/ipv6 section in the openvpn code.

If you can give me access to a NetBSD system *including* root access and
kernel sources extracted I should be able to patch and test openvpn
within hours to support IPv6 via tun devices.

	Thomas

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn.openbsd-tun-ipv6.patch"

diff /tmp/openvpn-1.5-beta7/syshead.h openvpn-1.5-beta7/syshead.h
--- /tmp/openvpn-1.5-beta7/syshead.h	Thu Aug 28 06:08:14 2003
+++ openvpn-1.5-beta7/syshead.h	Mon Sep  8 13:51:17 2003
@@ -209,6 +209,14 @@
 #include <sys/uio.h>
 #endif
 
+#ifdef HAVE_NETINET_IN_SYSTM_H
+#include <netinet/in_systm.h>
+#endif
+
+#ifdef HAVE_NETINET_IP_H
+#include <netinet/ip.h>
+#endif
+
 #ifdef HAVE_NET_IF_TUN_H
 #include <net/if_tun.h>
 #endif
diff /tmp/openvpn-1.5-beta7/tun.c openvpn-1.5-beta7/tun.c
--- /tmp/openvpn-1.5-beta7/tun.c	Thu Aug 28 06:08:14 2003
+++ openvpn-1.5-beta7/tun.c	Mon Sep  8 13:52:16 2003
@@ -708,7 +708,7 @@
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, bool ipv6, int mtu, struct tuntap *tt)
 {
-  open_tun_generic (dev, dev_node, ipv6, false, true, tt);
+  open_tun_generic (dev, dev_node, ipv6, true, true, tt);
 }
 
 void
@@ -729,8 +729,16 @@
 int
 write_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-  u_int32_t type = htonl (AF_INET);
+  u_int32_t type;
   struct iovec iv[2];
+  struct ip *iph;
+
+  iph = (struct ip *)buf;
+
+  if(tt->ipv6 && iph->ip_v == 6)
+    type = htonl(AF_INET6);
+  else 
+    type = htonl(AF_INET);
 
   iv[0].iov_base = &type;
   iv[0].iov_len = sizeof (type);

--FCuugMFkClbJLl1L
Content-Type: text/plain; charset=us-ascii
Content-Disposition: attachment; filename="openvpn-freebsd-ipv6-tun.patch"

diff -ruN openvpn-1.5-beta7-orig/syshead.h openvpn-1.5-beta7/syshead.h
--- openvpn-1.5-beta7-orig/syshead.h	Thu Aug 28 06:08:14 2003
+++ openvpn-1.5-beta7/syshead.h	Tue Sep  9 12:34:20 2003
@@ -217,6 +217,14 @@
 
 #ifdef TARGET_FREEBSD
 
+#ifdef HAVE_NETINET_IN_SYSTM_H
+#include <netinet/in_systm.h>
+#endif
+
+#ifdef HAVE_NETINET_IP_H
+#include <netinet/ip.h>
+#endif
+
 #ifdef HAVE_NET_IF_TUN_H
 #include <net/if_tun.h>
 #endif
diff -ruN openvpn-1.5-beta7-orig/tun.c openvpn-1.5-beta7/tun.c
--- openvpn-1.5-beta7-orig/tun.c	Thu Aug 28 06:08:14 2003
+++ openvpn-1.5-beta7/tun.c	Tue Sep  9 12:38:46 2003
@@ -756,10 +756,19 @@
 
 #elif defined(TARGET_FREEBSD)
 
+static inline int
+freebsd_modify_read_write_return (int len)
+{
+ if (len > 0)
+    return len > sizeof (u_int32_t) ? len - sizeof (u_int32_t) : 0;
+  else
+    return len;
+}
+
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, bool ipv6, int mtu, struct tuntap *tt)
 {
-  open_tun_generic (dev, dev_node, ipv6, false, true, tt);
+  open_tun_generic (dev, dev_node, ipv6, true, true, tt);
 
   if (tt->fd >= 0)
     {
@@ -767,6 +776,7 @@
 
       /* Disable extended modes */
       ioctl (tt->fd, TUNSLMODE, &i);
+      i = 1;
       ioctl (tt->fd, TUNSIFHEAD, &i);
     }
 }
@@ -780,13 +790,38 @@
 int
 write_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-  return write (tt->fd, buf, len);
+  struct iovec iv[2];
+  u_int32_t type;
+  struct ip *iph;
+
+  iph = (struct ip *)buf;
+
+  if(tt->ipv6 && iph->ip_v == 6)
+     type = htonl(AF_INET6);
+   else
+     type = htonl(AF_INET);
+
+  iv[0].iov_base = &type;
+  iv[0].iov_len = sizeof (type);
+  iv[1].iov_base = buf;
+  iv[1].iov_len = len;
+
+  return freebsd_modify_read_write_return (writev (tt->fd, iv, 2));
 }
 
 int
 read_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-  return read (tt->fd, buf, len);
+  u_int32_t type;
+  struct iovec iv[2];
+
+  iv[0].iov_base = &type;
+  iv[0].iov_len = sizeof (type);
+  iv[1].iov_base = buf;
+  iv[1].iov_len = len;
+
+
+  return freebsd_modify_read_write_return (readv (tt->fd, iv, 2));
 }
 
 #elif defined(WIN32)

--FCuugMFkClbJLl1L--

