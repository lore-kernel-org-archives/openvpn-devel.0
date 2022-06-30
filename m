From: Antonio Quartulli <a@...2181...>
Date: Thu, 30 Jun 2022 16:08:04 +0200
Message-Id: <20220630140804.8277-1-a@...2181...>
In-Reply-To: <20220629124945.13448-1-a@...2181...>
References: <20220629124945.13448-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v5 05/25] dco: let open_tun_generic handle
 the DCO case
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

Changes from v4:
* in open_tun_generic() use sizeof(tunname) when copying to tunname

Changes from v3:
* explicitly mention "DCO" in message when DCO device is successfully
  opened, as per Arne's request

Changes from v2:
* do not abuse the dynamic_name variable. Rather use 'dev' when no
  dynamic name is requested
* ignore dev-node when using DCO, to avoid messing up naming logic in
  open_tun_generic. dev-node has sense when using DCO
* add comment as to why we need to fill tunname

Changes from v1:
* improved INFO message when device already exists as per Arne's request


 src/openvpn/init.c    |   2 +-
 src/openvpn/options.c |   7 +++
 src/openvpn/tun.c     | 140 ++++++++++++++++++++++++++++++++----------
 src/openvpn/tun.h     |   2 +-
 4 files changed, 115 insertions(+), 36 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 03221cbb..c9d05c31 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1763,7 +1763,7 @@ do_open_tun(struct context *c)
 #endif
     /* open the tun device */
     open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
-             c->c1.tuntap);
+             c->c1.tuntap, &c->net_ctx);
 
     /* set the hardware address */
     if (c->options.lladdr)
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index 233c02e0..705bb79a 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3528,6 +3528,13 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
         o->verify_hash_no_ca = true;
     }
 
+    if (dco_enabled(o) && o->dev_node)
+    {
+        msg(M_WARN, "Note: ignoring --dev-node as it has no effect when using "
+            "data channel offload");
+        o->dev_node = NULL;
+    }
+
     /*
      * Save certain parms before modifying options during connect, especially
      * when using --pull
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e12f0369..901cfce0 100644
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
@@ -1780,6 +1780,21 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
                                      "/dev/%s%d", dev, i);
                     openvpn_snprintf(dynamic_name, sizeof(dynamic_name),
                                      "%s%d", dev, i);
+#if defined(TARGET_LINUX)
+                    if (!tt->options.disable_dco)
+                    {
+                        if (open_tun_dco(tt, ctx, dynamic_name) == 0)
+                        {
+                            dynamic_opened = true;
+                            /* tunname is required when printing the message at
+                             * the end of the function
+                             */
+                            strncpynt(tunname, dynamic_name, sizeof(tunname));
+                            break;
+                        }
+                    }
+                    else
+#endif
                     if ((tt->fd = open(tunname, O_RDWR)) > 0)
                     {
                         dynamic_opened = true;
@@ -1801,30 +1816,63 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
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
+                /* if dynamic_opened was true, then we already created the
+                 * interface named 'dynamic_name', otherwise we have to create
+                 * now the interface 'dev'.
+                 *
+                 * The variable 'dev_node' is totally ignored in the DCO case
+                 * because it is unset by options post-processing as it makes no
+                 * sense in this scenario.
+                 */
+                int ret = open_tun_dco(tt, ctx, dev);
+                if (ret == -EEXIST)
+                {
+                    msg(M_INFO, "DCO device %s already exists, won't be destroyed at shutdown",
+                        dev);
+                    tt->persistent_if = true;
+                }
+                else if (ret < 0)
+                {
+                    msg(M_ERR, "Cannot open DCO device %s: %d", dev, ret);
+                }
             }
 
-            if ((tt->fd = open(tunname, O_RDWR)) < 0)
+            msg(M_INFO, "DCO device %s opened", tunname);
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
-        }
 
-        set_nonblock(tt->fd);
-        set_cloexec(tt->fd); /* don't pass fd to scripts */
-        msg(M_INFO, "TUN/TAP device %s opened", tunname);
+            set_nonblock(tt->fd);
+            set_cloexec(tt->fd); /* don't pass fd to scripts */
+
+            msg(M_INFO, "TUN/TAP device %s opened", tunname);
+        }
 
         /* tt->actual_name is passed to up and down scripts and used as the ifconfig dev name */
         tt->actual_name = string_alloc(dynamic_opened ? dynamic_name : dev, NULL);
     }
 }
-#endif /* !_WIN32 && !TARGET_LINUX */
+#endif /* !_WIN32 */
 
 #if !defined(_WIN32)
 static void
@@ -1842,7 +1890,8 @@ close_tun_generic(struct tuntap *tt)
 
 #if defined (TARGET_ANDROID)
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
 #define ANDROID_TUNNAME "vpnservice-tun"
     struct user_pass up;
@@ -1939,7 +1988,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #if !PEDANTIC
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     struct ifreq ifr;
 
@@ -1950,6 +2000,12 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
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
@@ -2056,7 +2112,8 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 #else  /* if !PEDANTIC */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     ASSERT(0);
 }
@@ -2081,7 +2138,7 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
     clear_tuntap(tt);
     tt->type = dev_type_enum(dev, dev_type);
     tt->options = *options;
-    open_tun(dev, dev_type, dev_node, tt);
+    open_tun(dev, dev_type, dev_node, tt, ctx);
     if (ioctl(tt->fd, TUNSETPERSIST, persist_mode) < 0)
     {
         msg(M_ERR, "Cannot ioctl TUNSETPERSIST(%d) %s", persist_mode, dev);
@@ -2199,6 +2256,12 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         net_ctx_reset(ctx);
     }
 
+#ifdef TARGET_LINUX
+    if (!tt->options.disable_dco)
+    {
+        close_tun_dco(tt, ctx);
+    }
+#endif
     close_tun_generic(tt);
     free(tt);
 }
@@ -2222,7 +2285,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #endif
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     int if_fd, ip_muxid, arp_muxid, arp_fd, ppa = -1;
     struct lifreq ifr;
@@ -2574,9 +2638,10 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
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
@@ -2668,9 +2733,10 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
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
@@ -2808,9 +2874,10 @@ freebsd_modify_read_write_return(int len)
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
@@ -2936,9 +3003,10 @@ dragonfly_modify_read_write_return(int len)
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
@@ -3164,7 +3232,8 @@ open_darwin_utun(const char *dev, const char *dev_type, const char *dev_node, st
 #endif /* ifdef HAVE_NET_IF_UTUN_H */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
 #ifdef HAVE_NET_IF_UTUN_H
     /* If dev_node does not start start with utun assume regular tun/tap */
@@ -3190,7 +3259,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             {
                 /* No explicit utun and utun failed, try the generic way) */
                 msg(M_INFO, "Failed to open utun device. Falling back to /dev/tun device");
-                open_tun_generic(dev, dev_type, NULL, true, tt);
+                open_tun_generic(dev, dev_type, NULL, true, tt, ctx);
             }
             else
             {
@@ -3213,7 +3282,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             dev_node = NULL;
         }
 
-        open_tun_generic(dev, dev_type, dev_node, true, tt);
+        open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
     }
 }
 
@@ -3271,7 +3340,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #elif defined(TARGET_AIX)
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     char tunname[256];
     char dynamic_name[20];
@@ -6580,7 +6650,8 @@ tuntap_post_open(struct tuntap *tt, const char *device_guid)
 }
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     const char *device_guid = NULL;
 
@@ -6881,9 +6952,10 @@ ipset2ascii_all(struct gc_arena *gc)
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


