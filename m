From: Nathanael Rensen <dev@...170...>
Message-ID: <loom.20040221T101654-540@...171...>
References: <loom.20040220T055425-265@...171...> <20040220173445.GD18676@...172...>
Mime-Version: 1.0
Subject: [Openvpn-devel] Re: tap support for freebsd
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
Date: Sat Feb 21 09:38:19 2004
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
To: openvpn-devel@lists.sourceforge.net

Thomas Glanzmann <sithglan <at> stud.uni-erlangen.de> writes:

> Could you please send me a patch for this.

Sure. I'm sorry I didn't include one in the initial post.
Below is a patch against version 1.41 of tun.c. Apart from
replacing openbsd with freebsd, it is just a straight copy 
of the corresponding functions (write_tun and read_tun) for 
OpenBSD from earlier in the file.

Nathanael

--- v1.41/tun.c   Sat Feb 21 16:40:01 2004
+++ tun.c   Sat Feb 21 16:47:55 2004
@@ -1308,38 +1308,47 @@
 int
 write_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-  struct iovec iv[2];
-  u_int32_t type;
-  struct ip *iph;
-
-  iph = (struct ip *)buf;
-
-  if(tt->ipv6 && iph->ip_v == 6)
-     type = htonl(AF_INET6);
-   else
-     type = htonl(AF_INET);
-
-  iv[0].iov_base = &type;
-  iv[0].iov_len = sizeof (type);
-  iv[1].iov_base = buf;
-  iv[1].iov_len = len;
-
-  return freebsd_modify_read_write_return (writev (tt->fd, iv, 2));
+  if (tt->type == DEV_TYPE_TUN)
+    {
+      u_int32_t type;
+      struct iovec iv[2];
+      struct ip *iph;
+
+      iph = (struct ip *) buf;
+
+      if (tt->ipv6 && iph->ip_v == 6)
+        type = htonl (AF_INET6);
+      else 
+        type = htonl (AF_INET);
+
+      iv[0].iov_base = &type;
+      iv[0].iov_len = sizeof (type);
+      iv[1].iov_base = buf;
+      iv[1].iov_len = len;
+
+      return freebsd_modify_read_write_return (writev (tt->fd, iv, 2));
+    }
+  else
+    return write (tt->fd, buf, len);
 }
 
 int
 read_tun (struct tuntap* tt, uint8_t *buf, int len)
 {
-  u_int32_t type;
-  struct iovec iv[2];
-
-  iv[0].iov_base = &type;
-  iv[0].iov_len = sizeof (type);
-  iv[1].iov_base = buf;
-  iv[1].iov_len = len;
-
-
-  return freebsd_modify_read_write_return (readv (tt->fd, iv, 2));
+  if (tt->type == DEV_TYPE_TUN)
+    {
+      u_int32_t type;
+      struct iovec iv[2];
+
+      iv[0].iov_base = &type;
+      iv[0].iov_len = sizeof (type);
+      iv[1].iov_base = buf;
+      iv[1].iov_len = len;
+
+      return freebsd_modify_read_write_return (readv (tt->fd, iv, 2));
+    }
+  else
+    return read (tt->fd, buf, len);
 }
 
 #elif defined(WIN32)




