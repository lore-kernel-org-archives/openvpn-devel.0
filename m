From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Mon, 30 May 2022 17:49:15 +0200
Message-ID: <20220530154915.47349-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v3] Don't "undo" ifconfig on exit if it
 wasn't done
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

When running with --ifconfig-noexec, OpenVPN does not execute ifconfig,
but on exit, it still tries to "undo" the configuration it would have
done. This patch fixes it by extracting an undo_ifconfig() function from
close_tun(). The undo function is called before close_tun(), but only if
--ifconfig-noexec isn't set. This is symmetric to how open_tun() and
do_ifconfig() are used.

This change also allows us to drop the second argument from close_tun().

v2: Fix tabs-vs-spaces.
v3: Fix another style mistake.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/init.c |  6 +++++-
 src/openvpn/tun.c  | 37 +++++++++++++++++++++----------------
 src/openvpn/tun.h  | 10 +++++++++-
 3 files changed, 35 insertions(+), 18 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index b0c62a85..e52a084e 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -1858,7 +1858,11 @@ do_close_tun_simple(struct context *c)
     msg(D_CLOSE, "Closing TUN/TAP interface");
     if (c->c1.tuntap)
     {
-        close_tun(c->c1.tuntap, &c->net_ctx);
+        if (!c->options.ifconfig_noexec)
+        {
+            undo_ifconfig(c->c1.tuntap, &c->net_ctx);
+        }
+        close_tun(c->c1.tuntap);
         c->c1.tuntap = NULL;
     }
     c->c1.tuntap_owned = false;
diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index e12f0369..015bf46d 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1910,7 +1910,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -2073,7 +2073,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 void
 tuncfg(const char *dev, const char *dev_type, const char *dev_node,
        int persist_mode, const char *username, const char *groupname,
-       const struct tuntap_options *options, openvpn_net_ctx_t *ctx)
+       const struct tuntap_options *options)
 {
     struct tuntap *tt;
 
@@ -2112,7 +2112,7 @@ tuncfg(const char *dev, const char *dev_type, const char *dev_node,
             msg(M_ERR, "Cannot ioctl TUNSETGROUP(%s) %s", groupname, dev);
         }
     }
-    close_tun(tt, ctx);
+    close_tun(tt);
     msg(M_INFO, "Persist state set to: %s", (persist_mode ? "ON" : "OFF"));
 }
 
@@ -2179,10 +2179,8 @@ undo_ifconfig_ipv6(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
-    ASSERT(tt);
-
     if (tt->type != DEV_TYPE_NULL)
     {
         if (tt->did_ifconfig_setup)
@@ -2199,6 +2197,13 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
         net_ctx_reset(ctx);
     }
 
+}
+
+void
+close_tun(struct tuntap *tt)
+{
+    ASSERT(tt);
+
     close_tun_generic(tt);
     free(tt);
 }
@@ -2513,7 +2518,7 @@ solaris_close_tun(struct tuntap *tt)
  * Close TUN device.
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -2546,7 +2551,7 @@ solaris_error_close(struct tuntap *tt, const struct env_set *es,
 
     argv_msg(M_INFO, &argv);
     openvpn_execve_check(&argv, es, 0, "Solaris ifconfig unplumb failed");
-    close_tun(tt, NULL);
+    close_tun(tt);
     msg(M_FATAL, "Solaris ifconfig failed");
     argv_free(&argv);
 }
@@ -2609,7 +2614,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
  */
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -2695,7 +2700,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
  * need to be explicitly destroyed
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -2836,7 +2841,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
  * we need to call "ifconfig ... destroy" for cleanup
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -2952,7 +2957,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -3218,7 +3223,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -3366,7 +3371,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 /* tap devices need to be manually destroyed on AIX
  */
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -6704,7 +6709,7 @@ netsh_delete_address_dns(const struct tuntap *tt, bool ipv6, struct gc_arena *gc
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
@@ -6887,7 +6892,7 @@ open_tun(const char *dev, const char *dev_type, const char *dev_node, struct tun
 }
 
 void
-close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
+close_tun(struct tuntap *tt)
 {
     ASSERT(tt);
 
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 4bc35916..71c31e8d 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -247,7 +247,7 @@ tuntap_ring_empty(struct tuntap *tt)
 void open_tun(const char *dev, const char *dev_type, const char *dev_node,
               struct tuntap *tt);
 
-void close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+void close_tun(struct tuntap *tt);
 
 int write_tun(struct tuntap *tt, uint8_t *buf, int len);
 
@@ -296,6 +296,14 @@ void do_ifconfig_setenv(const struct tuntap *tt,
 void do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
                  const struct env_set *es, openvpn_net_ctx_t *ctx);
 
+/**
+ * undo_ifconfig - undo configuration of the tunnel interface
+ *
+ * @param tt    the tuntap interface context
+ * @param ctx   the networking API opaque context
+ */
+void undo_ifconfig(struct tuntap *tt, openvpn_net_ctx_t *ctx);
+
 bool is_dev_type(const char *dev, const char *dev_type, const char *match_type);
 
 int dev_type_enum(const char *dev, const char *dev_type);
-- 
2.30.2


