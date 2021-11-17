From: Max Fillinger <maximilian.fillinger@...2507...>
Date: Wed, 17 Nov 2021 18:54:24 +0100
Message-ID: <20211117175424.17195-1-maximilian.fillinger@...2507...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Don't "undo" ifconfig when given
 --ifconfig-noexec
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

When running with --ifconfig-noexec on Linux, OpenVPN may still delete
the ip address from the tun interface on exit, because it tries to undo
the ifconfig that did not actually happen.

This commit reintroduces the did_ifconfig member to struct tuntap so
that we can check if ifconfig was actually done before trying to undo
it. It's behind an #ifdef because it's only used on Linux, and that was
the reason why it was removed before.

Signed-off-by: Max Fillinger <maximilian.fillinger@...2507...>
---
 src/openvpn/tun.c | 6 +++++-
 src/openvpn/tun.h | 3 +++
 2 files changed, 8 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 75d5eaf7..32e739fc 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1601,6 +1601,10 @@ do_ifconfig(struct tuntap *tt, const char *ifname, int tun_mtu,
         do_ifconfig_ipv6(tt, ifname, tun_mtu, es, ctx);
     }
 
+#ifdef TARGET_LINUX
+    tt->did_ifconfig = true;
+#endif
+
     /* release resources potentially allocated during interface setup */
     net_ctx_free(ctx);
 }
@@ -2190,7 +2194,7 @@ close_tun(struct tuntap *tt, openvpn_net_ctx_t *ctx)
 {
     ASSERT(tt);
 
-    if (tt->type != DEV_TYPE_NULL)
+    if (tt->type != DEV_TYPE_NULL && tt->did_ifconfig)
     {
         if (tt->did_ifconfig_setup)
         {
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index aa1e47b5..1f579e34 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -162,6 +162,9 @@ struct tuntap
 
     bool did_ifconfig_setup;
     bool did_ifconfig_ipv6_setup;
+#ifdef TARGET_LINUX
+    bool did_ifconfig;
+#endif
 
     bool persistent_if;         /* if existed before, keep on program end */
 
-- 
2.20.1


