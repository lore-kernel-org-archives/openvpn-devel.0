From: Antonio Quartulli <a@...2181...>
Date: Tue, 19 Jul 2022 16:16:39 +0200
Message-Id: <20220719141639.14636-1-a@...2181...>
In-Reply-To: <20220712214642.13533-1-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v10 05/25] dco: let open_tun_generic handle
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

Changes from v9:
* rebased on top of latest master

Changes from v8:
* remove disabling DCO from within do_open_tun(). Logic has been moved
  to dco_check_option* (in a future patch).

Changes from v7:
* enclose setting 'disable_dco' field within ifdef (in do_open_tun) to
  ensure code compiles also on platforms with no DCO support at all

Changes from v6:
* do not touch tls_multi in do_open_tun as it's still NULL (caused crash)
* re-assign disable_dco field in pre_connect object, if DCO is disabled
  by open_tun() in do_open_tun()

Changes from v5:
* create TUN device when invoking --mktun with DCO enabled. Current code
  segfaults.
* fix message printing "..device created" for DCO cases
* print error string (and not just error code) when a DCO iface cannot
  be created
* when creating DCO device, if a TUN device with the same name is found,
  disable DCO and use the existing device
* don't use tunname as it contains the wrong string. Use dev or
  dynamic_name instead

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


 src/openvpn/init.c    |  24 ++++++-
 src/openvpn/init.h    |   2 +-
 src/openvpn/options.c |   7 ++
 src/openvpn/tun.c     | 144 ++++++++++++++++++++++++++++++++----------
 src/openvpn/tun.h     |   2 +-
 5 files changed, 140 insertions(+), 39 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1bfbf4eb..779fc4a5 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1054,7 +1054,7 @@ do_genkey(const struct options *options)
  * Persistent TUN/TAP device management mode?
  */
 bool
-do_persist_tuntap(const struct options *options, openvpn_net_ctx_t *ctx)
+do_persist_tuntap(struct options *options, openvpn_net_ctx_t *ctx)
 {
     if (options->persist_config)
     {
@@ -1069,6 +1069,26 @@ do_persist_tuntap(const struct options *options, openvpn_net_ctx_t *ctx)
             msg(M_FATAL|M_OPTERR,
                 "options --mktun or --rmtun should only be used together with --dev");
         }
+
+#if defined(ENABLE_DCO)
+        if (dco_enabled(options))
+        {
+            /* creating a DCO interface via --mktun is not supported as it does not
+             * make much sense. Since DCO is enabled by default, people may run into
+             * this without knowing, therefore this case should be properly handled.
+             *
+             * Disable DCO if --mktun was provided and print a message to let
+             * user know.
+             */
+            if (dev_type_enum(options->dev, options->dev_type) == DEV_TYPE_TUN)
+            {
+                msg(M_WARN, "Note: --mktun does not support DCO. Creating TUN interface.");
+            }
+
+            options->tuntap_options.disable_dco = true;
+        }
+#endif
+
 #ifdef ENABLE_FEATURE_TUN_PERSIST
         tuncfg(options->dev, options->dev_type, options->dev_node,
                options->persist_mode,
@@ -1763,7 +1783,7 @@ do_open_tun(struct context *c)
 #endif
     /* open the tun device */
     open_tun(c->options.dev, c->options.dev_type, c->options.dev_node,
-             c->c1.tuntap);
+             c->c1.tuntap, &c->net_ctx);
 
     /* set the hardware address */
     if (c->options.lladdr)
diff --git a/src/openvpn/init.h b/src/openvpn/init.h
index 2b8c2dcc..5f412a33 100644
--- a/src/openvpn/init.h
+++ b/src/openvpn/init.h
@@ -56,7 +56,7 @@ bool print_openssl_info(const struct options *options);
 
 bool do_genkey(const struct options *options);
 
-bool do_persist_tuntap(const struct options *options, openvpn_net_ctx_t *ctx);
+bool do_persist_tuntap(struct options *options, openvpn_net_ctx_t *ctx);
 
 bool possibly_become_daemon(const struct options *options);
 
diff --git a/src/openvpn/options.c b/src/openvpn/options.c
index b00acf7e..87d6fc31 100644
--- a/src/openvpn/options.c
+++ b/src/openvpn/options.c
@@ -3667,6 +3667,13 @@ options_postprocess_mutate(struct options *o, struct env_set *es)
     o->tuntap_options.disable_dco = !dco_check_option_conflict(D_DCO, o);
 #endif
 
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
index 4acccbff..108090d0 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -37,6 +37,7 @@
 
 #include "syshead.h"
 
+#include "openvpn.h"
 #include "tun.h"
 #include "fdmisc.h"
 #include "common.h"
@@ -1723,10 +1724,10 @@ tun_name_is_fixed(const char *dev)
     return has_digit(dev);
 }
 
-#if !(defined(_WIN32) || defined(TARGET_LINUX))
+#if !defined(_WIN32)
 static void
 open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
-                 bool dynamic, struct tuntap *tt)
+                 bool dynamic, struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     char tunname[256];
     char dynamic_name[256];
@@ -1785,6 +1786,18 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
                                      "/dev/%s%d", dev, i);
                     openvpn_snprintf(dynamic_name, sizeof(dynamic_name),
                                      "%s%d", dev, i);
+#if defined(TARGET_LINUX)
+                    if (!tt->options.disable_dco)
+                    {
+                        if (open_tun_dco(tt, ctx, dynamic_name) == 0)
+                        {
+                            dynamic_opened = true;
+                            msg(M_INFO, "DCO device %s opened", dynamic_name);
+                            break;
+                        }
+                    }
+                    else
+#endif /* if defined(TARGET_LINUX) */
                     if ((tt->fd = open(tunname, O_RDWR)) > 0)
                     {
                         dynamic_opened = true;
@@ -1806,30 +1819,66 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
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
+                 * sense in this context.
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
+                    msg(M_ERR, "Cannot open DCO device %s: %s (%d)", dev,
+                        strerror(-ret), ret);
+                }
+                else
+                {
+                    msg(M_INFO, "DCO device %s opened", dev);
+                }
             }
-
-            if ((tt->fd = open(tunname, O_RDWR)) < 0)
+        }
+        else
+#endif /* if defined(TARGET_LINUX) */
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
@@ -1847,7 +1896,8 @@ close_tun_generic(struct tuntap *tt)
 
 #if defined (TARGET_ANDROID)
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
 #define ANDROID_TUNNAME "vpnservice-tun"
     struct user_pass up;
@@ -1944,7 +1994,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #if !PEDANTIC
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     struct ifreq ifr;
 
@@ -1955,6 +2006,12 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
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
@@ -2061,7 +2118,8 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 #else  /* if !PEDANTIC */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     ASSERT(0);
 }
@@ -2086,7 +2144,8 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
     clear_tuntap(tt);
     tt->type = dev_type_enum(dev, dev_type);
     tt->options = *options;
-    open_tun(dev, dev_type, dev_node, tt);
+
+    open_tun(dev, dev_type, dev_node, tt, ctx);
     if (ioctl(tt->fd, TUNSETPERSIST, persist_mode) < 0)
     {
         msg(M_ERR, "Cannot ioctl TUNSETPERSIST(%d) %s", persist_mode, dev);
@@ -2204,6 +2263,12 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
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
@@ -2227,7 +2292,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #endif
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     int if_fd, ip_muxid, arp_muxid, arp_fd, ppa = -1;
     struct lifreq ifr;
@@ -2579,9 +2645,10 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
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
@@ -2673,9 +2740,10 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
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
@@ -2813,9 +2881,10 @@ freebsd_modify_read_write_return(int len)
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
@@ -2941,9 +3010,10 @@ dragonfly_modify_read_write_return(int len)
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
@@ -3169,7 +3239,8 @@ open_darwin_utun(const char *dev, const char *dev_type, const char *dev_node, st
 #endif /* ifdef HAVE_NET_IF_UTUN_H */
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
 #ifdef HAVE_NET_IF_UTUN_H
     /* If dev_node does not start start with utun assume regular tun/tap */
@@ -3195,7 +3266,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             {
                 /* No explicit utun and utun failed, try the generic way) */
                 msg(M_INFO, "Failed to open utun device. Falling back to /dev/tun device");
-                open_tun_generic(dev, dev_type, NULL, true, tt);
+                open_tun_generic(dev, dev_type, NULL, true, tt, ctx);
             }
             else
             {
@@ -3218,7 +3289,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
             dev_node = NULL;
         }
 
-        open_tun_generic(dev, dev_type, dev_node, true, tt);
+        open_tun_generic(dev, dev_type, dev_node, true, tt, ctx);
     }
 }
 
@@ -3276,7 +3347,8 @@ read_tun(struct tuntap *tt, uint8_t *buf, int len)
 #elif defined(TARGET_AIX)
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     char tunname[256];
     char dynamic_name[20];
@@ -6585,7 +6657,8 @@ tuntap_post_open(struct tuntap *tt, const char *device_guid)
 }
 
 void
-open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt)
+open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tuntap *tt,
+         openvpn_net_ctx_t *ctx)
 {
     const char *device_guid = NULL;
 
@@ -6886,9 +6959,10 @@ ipset2ascii_all(struct gc_arena *gc)
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
index b7786f46..8ec8f51f 100644
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


