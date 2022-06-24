From: Antonio Quartulli <a@...2181...>
Date: Fri, 24 Jun 2022 10:37:49 +0200
Message-Id: <20220624083809.23487-6-a@...2181...>
In-Reply-To: <20220624083809.23487-1-a@...2181...>
References: <20220624083809.23487-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 05/25] dco: let open_tun_generic handle the
 DCO case
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
Cc: Antonio Quartulli <a@...2181...>

open_tun_generic already contains the logic required to find a device
name when not specified b the user. For this reason the DCO case can
easily leverage on function and avoid code duplication.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/init.c |   2 +-
 src/openvpn/tun.c  | 133 +++++++++++++++++++++++++++++++++------------
 src/openvpn/tun.h  |   2 +-
 3 files changed, 101 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index f586bfc7..7099eba4 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1758,7 +1758,7 @@ do_open_tun(struct context *c)
 #endif
     /* open the tun device */
     open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
-             c->c1.tuntap);
+             c->c1.tuntap, &c->net_ctx);
 
     /* set the hardware address */
     if (c->options.lladdr)
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e12f0369..5eefb0c6 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1718,10 +1718,10 @@ read_tun_header(struct tuntap *tt, uint8_t *buf, int len)
 #endif /* if defined (TARGET_OPENBSD) || (defined(TARGET_DARWIN) && HAVE_NET_IF_UTUN_H) */
 
 
-#if !(defined(_WIN32) || defined(TARGET_LINUX))
+#if !defined(_WIN32)
 static void
 open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
-                 bool dynamic, struct tuntap *tt)
+                 bool dynamic, struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     char tunname[256];
     char dynamic_name[256];
@@ -1739,6 +1739,7 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
         if (dev_node)
         {
             openvpn_snprintf(tunname, sizeof(tunname), "%s", dev_node);
+            strncpynt(dynamic_name, dev_node, sizeof(dynamic_name));
         }
         else
         {
@@ -1780,6 +1781,19 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
                                      "/dev/%s%d", dev, i);
                     openvpn_snprintf(dynamic_name, sizeof(dynamic_name),
                                      "%s%d", dev, i);
+#if defined(TARGET_LINUX)
+                    if (!tt->options.disable_dco)
+                    {
+                        if (open_tun_dco(tt, ctx, dynamic_name) == 0)
+                        {
+                            dynamic_opened = true;
+                            strncpynt(tunname, dynamic_name,
+                                      sizeof(dynamic_name));
+                            break;
+                        }
+                    }
+                    else
+#endif
                     if ((tt->fd = open(tunname, O_RDWR)) > 0)
                     {
                         dynamic_opened = true;
@@ -1798,33 +1812,57 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
             else
             {
                 openvpn_snprintf(tunname, sizeof(tunname), "/dev/%s", dev);
+                strncpynt(dynamic_name, dev, sizeof(dynamic_name));
             }
         }
 
-        if (!dynamic_opened)
+#if defined(TARGET_LINUX)
+        if (!tt->options.disable_dco)
         {
-            /* has named device existed before? if so, don't destroy at end */
-            if (if_nametoindex( dev ) > 0)
+            if (!dynamic_opened)
             {
-                msg(M_INFO, "TUN/TAP device %s exists previously, keep at program end", dev );
-                tt->persistent_if = true;
+                int ret = open_tun_dco(tt, ctx, dynamic_name);
+                if (ret == -EEXIST)
+                {
+                    msg(M_INFO, "TUN/TAP device %s exists previously, keep at program end",
+                        dynamic_name);
+                    tt->persistent_if = true;
+                }
+                else if (ret < 0)
+                {
+                    msg(M_ERR, "Cannot open TUN/TAP dev %s: %d", dynamic_name, ret);
+                }
+                dynamic_opened = true;
             }
-
-            if ((tt->fd = open(tunname, O_RDWR)) < 0)
+        }
+        else
+#endif
+        {
+            if (!dynamic_opened)
             {
-                msg(M_ERR, "Cannot open TUN/TAP dev %s", tunname);
+                /* has named device existed before? if so, don't destroy at end */
+                if (if_nametoindex( dev ) > 0)
+                {
+                    msg(M_INFO, "TUN/TAP device %s exists previously, keep at program end", dev );
+                    tt->persistent_if = true;
+                }
+
+                if ((tt->fd = open(tunname, O_RDWR)) < 0)
+                {
+                    msg(M_ERR, "Cannot open TUN/TAP dev %s", tunname);
+                }
             }
+            set_nonblock(tt->fd);
+            set_cloexec(tt->fd); /* don't pass fd to scripts */
         }
 
-        set_nonblock(tt->fd);
-        set_cloexec(tt->fd); /* don't pass fd to scripts */
         msg(M_INFO, "TUN/TAP device %s opened", tunname);
 
         /* tt->actual_name is passed to up and down scripts and used as the ifconfig dev name */
         tt->actual_name = string_alloc(dynamic_opened ? dynamic_name : dev, NULL);
     }
 }
-#endif /* !_WIN32 && !TARGET_LINUX */
+#endif /* !_WIN32 */
 
 #if !defined(_WIN32)
 static void
@@ -1842,7 +1880,8 @@ close_tun_generic(struct tuntap *tt)
 
 #if defined (TARGET_ANDROID)
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
 #define ANDROID_TUNNAME "vpnservice-tun"
     struct user_pass up;
@@ -1939,7 +1978,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #if !PEDANTIC
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     struct ifreq ifr;
 
@@ -1950,6 +1990,12 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
     {
         open_null(tt);
     }
+#if defined(TARGET_LINUX)
+    else if (!tt->options.disable_dco)
+    {
+        open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
+    }
+#endif
     else
     {
         /*
@@ -2056,7 +2102,8 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 #else  /* if !PEDANTIC */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     ASSERT(0);
 }
@@ -2081,7 +2128,7 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
     clear_tuntap(tt);
     tt->type = dev_type_enum(dev, dev_type);
     tt->options = *options;
-    open_tun(dev, dev_type, dev_node, tt);
+    open_tun(dev, dev_type, dev_node, tt, ctx);
     if (ioctl(tt->fd, TUNSETPERSIST, persist_mode) < 0)
     {
         msg(M_ERR, "Cannot ioctl TUNSETPERSIST(%d) %s", persist_mode, dev);
@@ -2199,7 +2246,16 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         net_ctx_reset(ctx);
     }
 
-    close_tun_generic(tt);
+#ifdef TARGET_LINUX
+    if (!tt->options.disable_dco)
+    {
+        close_tun_dco(tt, ctx);
+    }
+    else
+#endif
+    {
+        close_tun_generic(tt);
+    }
     free(tt);
 }
 
@@ -2222,7 +2278,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #endif
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     int if_fd, ip_muxid, arp_muxid, arp_fd, ppa = -1;
     struct lifreq ifr;
@@ -2574,9 +2631,10 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #elif defined(TARGET_OPENBSD)
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
 
     /* Enable multicast on the interface */
     if (tt->fd >= 0)
@@ -2668,9 +2726,10 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
  */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
 
     if (tt->fd >= 0)
     {
@@ -2808,9 +2867,10 @@ freebsd_modify_read_write_return(int len)
 }
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
 
     if (tt->fd >= 0 && tt->type == DEV_TYPE_TUN)
     {
@@ -2936,9 +2996,10 @@ dragonfly_modify_read_write_return(int len)
 }
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
 
     if (tt->fd >= 0)
     {
@@ -3164,7 +3225,8 @@ open_darwin_utun(const char *dev, const char *dev_type, const char *dev_node, st
 #endif /* ifdef HAVE_NET_IF_UTUN_H */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
 #ifdef HAVE_NET_IF_UTUN_H
     /* If dev_node does not start start with utun assume regular tun/tap */
@@ -3190,7 +3252,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             {
                 /* No explicit utun and utun failed, try the generic way) */
                 msg(M_INFO, "Failed to open utun device. Falling back to /dev/tun device");
-                open_tun_generic(dev, dev_type, NULL, true, tt);
+                open_tun_generic(dev, dev_type, NULL, true, tt, ctx);
             }
             else
             {
@@ -3213,7 +3275,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             dev_node = NULL;
         }
 
-        open_tun_generic(dev, dev_type, dev_node, true, tt);
+        open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
     }
 }
 
@@ -3271,7 +3333,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #elif defined(TARGET_AIX)
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     char tunname[256];
     char dynamic_name[20];
@@ -6580,7 +6643,8 @@ tuntap_post_open(struct tuntap *tt, const char *device_guid)
 }
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     const char *device_guid = NULL;
 
@@ -6881,9 +6945,10 @@ ipset2ascii_all(struct gc_arena *gc)
 #else /* generic */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
-    open_tun_generic(dev, dev_type, dev_node, true, tt);
+    open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
 }
 
 void
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 5fcea590..cf02bf43 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -249,7 +249,7 @@ tuntap_ring_empty(struct tuntap *tt)
  */
 
 void open_tun(const char *dev, const char *dev_type, const char *dev_node,
-              struct tuntap *tt);
+              struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
 void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
 
-- 
2.35.1


