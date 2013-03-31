From: Arne Schwabe <arne@...1227...>
Date: Sun, 31 Mar 2013 22:43:29 +0200
Message-Id: <1364762609-30320-1-git-send-email-arne@...1227...>
Subject: [Openvpn-devel] [PATCH] Add support of utun devices under Mac OS X
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
	<mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

Mac OS X 10.7+ natively supports tun devices (called utun). The "standard" utun.ko driver is sometimes problematic (e.g. VmWare Fusion 5 and tun.ko do not work together).

When OpenVPN is compiled with utun support it will if no dev-node is given first try to use utun and if that is not available will try the traditional tun devices

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 configure.ac      |    2 +-
 src/openvpn/tun.c |  294 ++++++++++++++++++++++++++++++++++++++++-------------
 src/openvpn/tun.h |    5 +-
 3 files changed, 231 insertions(+), 70 deletions(-)

diff --git a/configure.ac b/configure.ac
index 7b35e50..5994991 100644
--- a/configure.ac
+++ b/configure.ac
@@ -454,7 +454,7 @@ SOCKET_INCLUDES="
 "
 
 AC_CHECK_HEADERS(
-	[net/if.h netinet/ip.h netinet/if_ether.h resolv.h sys/un.h],
+	[net/if.h netinet/ip.h netinet/if_ether.h resolv.h sys/un.h net/if_utun.h sys/kern_control.h],
 	,
 	,
 	[[${SOCKET_INCLUDES}]]
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index a361233..089fe59 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -673,7 +673,7 @@ do_ifconfig (struct tuntap *tt,
     }
 #endif
 
-
+      
 #if defined(TARGET_LINUX)
 #ifdef ENABLE_IPROUTE
 	/*
@@ -1248,6 +1248,87 @@ open_null (struct tuntap *tt)
   tt->actual_name = string_alloc ("null", NULL);
 }
 
+
+#if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_NET_IF_UTUN_H)
+
+/*
+ * OpenBSD and Mac OS X when using utun
+ * have a slightly incompatible TUN device from
+ * the rest of the world, in that it prepends a
+ * uint32 to the beginning of the IP header
+ * to designate the protocol (why not just
+ * look at the version field in the IP header to
+ * determine v4 or v6?).
+ *
+ * We strip off this field on reads and
+ * put it back on writes.
+ *
+ * I have not tested TAP devices on OpenBSD,
+ * but I have conditionalized the special
+ * TUN handling code described above to
+ * go away for TAP devices.
+ */
+
+#include <netinet/ip.h>
+#include <sys/uio.h>
+
+static inline int
+header_modify_read_write_return (int len)
+{
+    if (len > 0)
+        return len > sizeof (u_int32_t) ? len - sizeof (u_int32_t) : 0;
+    else
+        return len;
+}
+
+int
+write_tun_header (struct tuntap* tt, uint8_t *buf, int len)
+{
+    if (tt->type == DEV_TYPE_TUN)
+      {
+        u_int32_t type;
+        struct iovec iv[2];
+        struct ip *iph;
+        
+        iph = (struct ip *) buf;
+        
+        if (tt->ipv6 && iph->ip_v == 6)
+            type = htonl (AF_INET6);
+        else
+            type = htonl (AF_INET);
+        
+        iv[0].iov_base = &type;
+        iv[0].iov_len = sizeof (type);
+        iv[1].iov_base = buf;
+        iv[1].iov_len = len;
+        
+        return header_modify_read_write_return (writev (tt->fd, iv, 2));
+      }
+    else
+        return write (tt->fd, buf, len);
+}
+
+int
+read_tun_header (struct tuntap* tt, uint8_t *buf, int len)
+{
+    if (tt->type == DEV_TYPE_TUN)
+      {
+        u_int32_t type;
+        struct iovec iv[2];
+        
+        iv[0].iov_base = &type;
+        iv[0].iov_len = sizeof (type);
+        iv[1].iov_base = buf;
+        iv[1].iov_len = len;
+        
+        return header_modify_read_write_return (readv (tt->fd, iv, 2));
+      }
+    else
+        return read (tt->fd, buf, len);
+}
+#endif
+
+
 #ifndef WIN32
 static void
 open_tun_generic (const char *dev, const char *dev_type, const char *dev_node,
@@ -1972,23 +2053,6 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
 
 #elif defined(TARGET_OPENBSD)
 
-/*
- * OpenBSD has a slightly incompatible TUN device from
- * the rest of the world, in that it prepends a
- * uint32 to the beginning of the IP header
- * to designate the protocol (why not just
- * look at the version field in the IP header to
- * determine v4 or v6?).
- *
- * We strip off this field on reads and
- * put it back on writes.
- *
- * I have not tested TAP devices on OpenBSD,
- * but I have conditionalized the special
- * TUN handling code described above to
- * go away for TAP devices.
- */
-
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
@@ -2055,59 +2119,16 @@ close_tun (struct tuntap* tt)
     }
 }
 
-static inline int
-openbsd_modify_read_write_return (int len)
-{
- if (len > 0)
-    return len > sizeof (u_int32_t) ? len - sizeof (u_int32_t) : 0;
-  else
-    return len;
-}
-
 int
-write_tun (struct tuntap* tt, uint8_t *buf, int len)
+write_tun(struct tuntap *tt, uint8_t *buf, int len)
 {
-  if (tt->type == DEV_TYPE_TUN)
-    {
-      u_int32_t type;
-      struct iovec iv[2];
-      struct ip *iph;
-
-      iph = (struct ip *) buf;
-
-      if (tt->ipv6 && iph->ip_v == 6)
-	type = htonl (AF_INET6);
-      else 
-	type = htonl (AF_INET);
-
-      iv[0].iov_base = &type;
-      iv[0].iov_len = sizeof (type);
-      iv[1].iov_base = buf;
-      iv[1].iov_len = len;
-
-      return openbsd_modify_read_write_return (writev (tt->fd, iv, 2));
-    }
-  else
-    return write (tt->fd, buf, len);
+  return write_tun_header (tt, buf, len);
 }
 
 int
-read_tun (struct tuntap* tt, uint8_t *buf, int len)
+read_tun (struct tuntap *tt, uint8_t *buf, int len)
 {
-  if (tt->type == DEV_TYPE_TUN)
-    {
-      u_int32_t type;
-      struct iovec iv[2];
-
-      iv[0].iov_base = &type;
-      iv[0].iov_len = sizeof (type);
-      iv[1].iov_base = buf;
-      iv[1].iov_len = len;
-
-      return openbsd_modify_read_write_return (readv (tt->fd, iv, 2));
-    }
-  else
-    return read (tt->fd, buf, len);
+    return read_tun_header (tt, buf, len);
 }
 
 #elif defined(TARGET_NETBSD)
@@ -2467,10 +2488,141 @@ read_tun (struct tuntap* tt, uint8_t *buf, int len)
  * pointing to lo0.  Need to unconfigure...  (observed on 10.5)
  */
 
+
+/*
+ * utun is the native Darwin tun driver present since at least 10.7
+ * Thanks goes to Jonathan Levin for providing an example how to utun
+ * (http://newosxbook.com/src.jl?tree=listings&file=17-15-utun.c)
+ */
+
+#ifdef HAVE_NET_IF_UTUN_H
+#include <sys/kern_control.h>
+#include <net/if_utun.h>
+#include <sys/sys_domain.h>
+
+static
+int utun_open_helper (struct ctl_info ctlInfo, int utunnum)
+{
+  struct sockaddr_ctl sc;
+  int fd;
+    
+  fd = socket(PF_SYSTEM, SOCK_DGRAM, SYSPROTO_CONTROL);
+    
+  if (fd == -1)
+    {
+      msg (M_ERR, "Opening utun (%s): %s", "socket(SYSPROTO_CONTROL)",
+           strerror (errno));
+      return -1;
+    }
+  if (ioctl(fd, CTLIOCGINFO, &ctlInfo) == -1)
+    {
+      close (fd);
+      msg (M_ERR, "Opening utun (%s): %s", "ioctl(CTLIOCGINFO)",
+           strerror (errno));
+      return -1;
+    }
+    
+    
+  sc.sc_id = ctlInfo.ctl_id;
+  sc.sc_len = sizeof(sc);
+  sc.sc_family = AF_SYSTEM;
+  sc.ss_sysaddr = AF_SYS_CONTROL;
+    
+  sc.sc_unit = utunnum+1;
+    
+    
+  /* If the connect is successful, a utun%d device will be created, where "%d"
+   * is (sc.sc_unit - 1) */
+    
+  if (connect (fd, (struct sockaddr *)&sc, sizeof(sc)) == -1)
+    {
+      msg (M_INFO, "Opening utun (%s): %s", "connect(AF_SYS_CONTROL)",
+           strerror (errno));
+      close(fd);
+      return -1;
+    }
+    
+  return fd;
+}
+
+void
+open_darwin_utun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+{
+  struct ctl_info ctlInfo;
+  int fd;
+  char utunname[20];
+  int utunnum =-1;
+    
+  /* dev_node is simply utun, do the normal dynamic utun
+   * otherwise try to parse the utun number */
+  if (dev_node && !strcmp ("utun", dev_node)==0)
+    {
+      if (!sscanf (dev_node, "utun%d", &utunnum)==1)
+        msg (M_FATAL, "Cannot parse 'dev-type %s' please use 'dev-type utunX'"
+             "to use a specific utun device", dev_node);
+    }
+    
+        
+    
+  memset(&ctlInfo, 0, sizeof(ctlInfo));
+  if (strlcpy(ctlInfo.ctl_name, UTUN_CONTROL_NAME, sizeof(ctlInfo.ctl_name)) >=
+      sizeof(ctlInfo.ctl_name))
+    {
+      msg (M_ERR, "Opening utun (%s): %s", "UTUN_CONTROL_NAME too long",
+           strerror (errno));
+        
+    }
+   
+  if (utunnum == -1)
+    {
+      for (utunnum=0; utunnum<255; utunnum++)
+        {
+          fd = utun_open_helper (ctlInfo, utunnum);
+          if (fd != -1)
+            break;
+        }
+    }
+  else
+    {
+      fd = utun_open_helper (ctlInfo, utunnum);
+    }
+
+  sprintf(utunname, "utun%d",utunnum);
+  tt->actual_name = strdup (utunname);
+    
+  msg (M_INFO, "Openend utun device %s", utunname);
+    
+  tt->fd = fd;
+  tt->is_utun = true;
+}
+
+#endif
+
 void
 open_tun (const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
 {
-  open_tun_generic (dev, dev_type, dev_node, true, true, tt);
+#ifdef HAVE_NET_IF_UTUN_H
+  /* If dev_node does not start start with utun assume regular tun/tap */
+  if (dev_node && !(strstr (dev_node, "utun") == dev_node))
+    return open_tun_generic (dev, dev_type, dev_node, true, true, tt);
+
+  /* Otherwise try utun first and fall back to normal tun if utun fails
+   * and dev_node is not specified */
+    
+  if (tt->type == DEV_TYPE_TUN)
+    {
+      open_darwin_utun(dev, dev_type, dev_node, tt);
+       
+      /* No explicit utun and utun failed, try the generic way) */
+      if (!dev_node && !tt->is_utun)
+        {
+          msg (M_INFO, "Failed to open utun device. Falling back to tun device");
+          open_tun_generic (dev, dev_type, dev_node, true, true, tt);
+        }
+    }
+  else
+#endif
+    open_tun_generic (dev, dev_type, dev_node, true, true, tt);
 }
 
 void
@@ -2503,13 +2655,19 @@ close_tun (struct tuntap* tt)
 int
 write_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-  return write (tt->fd, buf, len);
+  if (tt->is_utun)
+    return write_tun_header (tt, buf, len);
+  else
+    return write (tt->fd, buf, len);
 }
 
 int
 read_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-  return read (tt->fd, buf, len);
+  if (tt->is_utun)
+    return read_tun_header (tt, buf, len);
+  else
+    return read (tt->fd, buf, len);
 }
 
 #elif defined(WIN32)
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index c3fc62e..dc6429c 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -180,7 +180,10 @@ struct tuntap
 #ifdef TARGET_SOLARIS
   int ip_fd;
 #endif
-
+    
+#ifdef HAVE_NET_IF_UTUN_H
+  bool is_utun;
+#endif
   /* used for printing status info only */
   unsigned int rwflags_debug;
 
-- 
1.7.9.5


