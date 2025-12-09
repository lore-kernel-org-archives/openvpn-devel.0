From: Gert Doering <gert@...1296...>
Date: Tue,  9 Dec 2025 14:30:33 +0100
Message-ID: <20251209133038.5088-1-gert@...1296...>
In-Reply-To: <gerrit.1763122662000.Ifd9384287648d1f37a625d9ed6a09733208fa56c@...2715...>
References: <gerrit.1763122662000.Ifd9384287648d1f37a625d9ed6a09733208fa56c@...2715...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v7] tun: Refactor BSD write_tun/read_tun
List-Id: <openvpn-devel.lists.sourceforge.net>
List-Unsubscribe: <https://lists.sourceforge.net/lists/options/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum_name=openvpn-devel>
List-Post: <mailto:openvpn-devel@lists.sourceforge.net>
List-Help: <mailto:openvpn-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/openvpn-devel>, 
 <mailto:openvpn-devel-request@lists.sourceforge.net?subject=subscribe>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
To: openvpn-devel@lists.sourceforge.net

From: Frank Lichtenheld <frank@...2641...>

There was a lot of duplicated code, merge it together.

Change-Id: Ifd9384287648d1f37a625d9ed6a09733208fa56c
Signed-off-by: Frank Lichtenheld <frank@...2641...>
Acked-by: Gert Doering <gert@...1296...>
Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1378
---

This change was reviewed on Gerrit and approved by at least one
developer. I request to merge it to master.

Gerrit URL: https://gerrit.openvpn.net/c/openvpn/+/1378
This mail reflects revision 7 of this Change.

Acked-by according to Gerrit (reflected above):
Gert Doering <gert@...1296...>

        
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 7c61dcf..b4e3cb4 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1685,10 +1685,10 @@
 #endif
 }
 
-#if defined(TARGET_OPENBSD) || defined(TARGET_DARWIN)
+#if defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || defined(TARGET_OPENBSD) || defined(TARGET_DARWIN)
 
 /*
- * OpenBSD and Mac OS X when using utun
+ * BSDs and Mac OS X when using utun
  * have a slightly incompatible TUN device from
  * the rest of the world, in that it prepends a
  * uint32 to the beginning of the IP header
@@ -1699,10 +1699,8 @@
  * We strip off this field on reads and
  * put it back on writes.
  *
- * I have not tested TAP devices on OpenBSD,
- * but I have conditionalized the special
- * TUN handling code described above to
- * go away for TAP devices.
+ * For TAP devices, this is not needed and must
+ * not be done.
  */
 
 #include <netinet/ip.h>
@@ -1733,11 +1731,9 @@
     {
         u_int32_t type;
         struct iovec iv[2];
-        struct openvpn_iphdr *iph;
+        struct ip *iph = (struct ip *)buf;
 
-        iph = (struct openvpn_iphdr *)buf;
-
-        if (OPENVPN_IPH_GET_VER(iph->version_len) == 6)
+        if (iph->ip_v == 6)
         {
             type = htonl(AF_INET6);
         }
@@ -1784,7 +1780,26 @@
 #pragma GCC diagnostic pop
 #endif
 
-#endif /* if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */
+/* For MacOS this extra handling is conditional on the UTUN driver.
+ * So it needs its own read_tun()/write_tun() with the necessary
+ * checks. They are located in the macOS-specific section below.
+ */
+#if !defined(TARGET_DARWIN)
+int
+write_tun(struct tuntap *tt, uint8_t *buf, int len)
+{
+    return write_tun_header(tt, buf, len);
+}
+
+int
+read_tun(struct tuntap *tt, uint8_t *buf, int len)
+{
+    return read_tun_header(tt, buf, len);
+}
+#endif
+
+
+#endif /* defined(TARGET_FREEBSD) || defined(TARGET_DRAGONFLY) || defined(TARGET_NETBSD) || if defined (TARGET_OPENBSD) || defined(TARGET_DARWIN) */
 
 bool
 tun_name_is_fixed(const char *dev)
@@ -2679,18 +2694,6 @@
     argv_free(&argv);
 }
 
-int
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    return write_tun_header(tt, buf, len);
-}
-
-int
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    return read_tun_header(tt, buf, len);
-}
-
 #elif defined(TARGET_NETBSD)
 
 /*
@@ -2792,88 +2795,8 @@
     argv_free(&argv);
 }
 
-static inline int
-netbsd_modify_read_write_return(int len)
-{
-    if (len > 0)
-    {
-        return len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;
-    }
-    else
-    {
-        return len;
-    }
-}
-
-int
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type == DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-        struct openvpn_iphdr *iph;
-
-        iph = (struct openvpn_iphdr *)buf;
-
-        if (OPENVPN_IPH_GET_VER(iph->version_len) == 6)
-        {
-            type = htonl(AF_INET6);
-        }
-        else
-        {
-            type = htonl(AF_INET);
-        }
-
-        iv[0].iov_base = (char *)&type;
-        iv[0].iov_len = sizeof(type);
-        iv[1].iov_base = buf;
-        iv[1].iov_len = len;
-
-        return netbsd_modify_read_write_return(writev(tt->fd, iv, 2));
-    }
-    else
-    {
-        return write(tt->fd, buf, len);
-    }
-}
-
-int
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type == DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-
-        iv[0].iov_base = (char *)&type;
-        iv[0].iov_len = sizeof(type);
-        iv[1].iov_base = buf;
-        iv[1].iov_len = len;
-
-        return netbsd_modify_read_write_return(readv(tt->fd, iv, 2));
-    }
-    else
-    {
-        return read(tt->fd, buf, len);
-    }
-}
-
 #elif defined(TARGET_FREEBSD)
 
-static inline int
-freebsd_modify_read_write_return(int len)
-{
-    if (len > 0)
-    {
-        return len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;
-    }
-    else
-    {
-        return len;
-    }
-}
-
 void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
@@ -2946,84 +2869,8 @@
     argv_free(&argv);
 }
 
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic push
-#pragma GCC diagnostic ignored "-Wconversion"
-#endif
-
-int
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type == DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-        struct ip *iph;
-
-        iph = (struct ip *)buf;
-
-        if (iph->ip_v == 6)
-        {
-            type = htonl(AF_INET6);
-        }
-        else
-        {
-            type = htonl(AF_INET);
-        }
-
-        iv[0].iov_base = (char *)&type;
-        iv[0].iov_len = sizeof(type);
-        iv[1].iov_base = buf;
-        iv[1].iov_len = len;
-
-        return freebsd_modify_read_write_return(writev(tt->fd, iv, 2));
-    }
-    else
-    {
-        return write(tt->fd, buf, len);
-    }
-}
-
-int
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type == DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-
-        iv[0].iov_base = (char *)&type;
-        iv[0].iov_len = sizeof(type);
-        iv[1].iov_base = buf;
-        iv[1].iov_len = len;
-
-        return freebsd_modify_read_write_return(readv(tt->fd, iv, 2));
-    }
-    else
-    {
-        return read(tt->fd, buf, len);
-    }
-}
-
-#if defined(__GNUC__) || defined(__clang__)
-#pragma GCC diagnostic pop
-#endif
-
 #elif defined(TARGET_DRAGONFLY)
 
-static inline int
-dragonfly_modify_read_write_return(int len)
-{
-    if (len > 0)
-    {
-        return len > sizeof(u_int32_t) ? len - sizeof(u_int32_t) : 0;
-    }
-    else
-    {
-        return len;
-    }
-}
-
 void
 open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
          openvpn_net_ctx_t *ctx)
@@ -3050,60 +2897,6 @@
     free(tt);
 }
 
-int
-write_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type == DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-        struct ip *iph;
-
-        iph = (struct ip *)buf;
-
-        if (iph->ip_v == 6)
-        {
-            type = htonl(AF_INET6);
-        }
-        else
-        {
-            type = htonl(AF_INET);
-        }
-
-        iv[0].iov_base = (char *)&type;
-        iv[0].iov_len = sizeof(type);
-        iv[1].iov_base = buf;
-        iv[1].iov_len = len;
-
-        return dragonfly_modify_read_write_return(writev(tt->fd, iv, 2));
-    }
-    else
-    {
-        return write(tt->fd, buf, len);
-    }
-}
-
-int
-read_tun(struct tuntap *tt, uint8_t *buf, int len)
-{
-    if (tt->type == DEV_TYPE_TUN)
-    {
-        u_int32_t type;
-        struct iovec iv[2];
-
-        iv[0].iov_base = (char *)&type;
-        iv[0].iov_len = sizeof(type);
-        iv[1].iov_base = buf;
-        iv[1].iov_len = len;
-
-        return dragonfly_modify_read_write_return(readv(tt->fd, iv, 2));
-    }
-    else
-    {
-        return read(tt->fd, buf, len);
-    }
-}
-
 #elif defined(TARGET_DARWIN)
 
 /* Darwin (MacOS X) is mostly "just use the generic stuff", but there

