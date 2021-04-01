From: Arne Schwabe <arne@...1227...>
Date: Thu,  1 Apr 2021 15:13:29 +0200
Message-Id: <20210401131337.3684-7-arne@...1227...>
In-Reply-To: <20210401131337.3684-1-arne@...1227...>
References: <20210401131337.3684-1-arne@...1227...>
Subject: [Openvpn-devel] [PATCH 06/14] Remove pointless
 tun_adjust_frame_parameters function
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

This functions seem to serve no purpose other than to add confusion.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/init.c |  2 +-
 src/openvpn/tun.h  | 10 ----------
 2 files changed, 1 insertion(+), 11 deletions(-)

diff --git a/src/openvpn/init.c b/src/openvpn/init.c
index 1a6015452..f0ae0b7f1 100644
--- a/src/openvpn/init.c
+++ b/src/openvpn/init.c
@@ -3101,7 +3101,7 @@ do_init_frame(struct context *c)
      */
     if (c->options.ce.tun_mtu_extra_defined)
     {
-        tun_adjust_frame_parameters(&c->c2.frame, c->options.ce.tun_mtu_extra);
+        frame_add_to_extra_tun(&c->c2.frame, c->options.ce.tun_mtu_extra);
     }
 
     /*
diff --git a/src/openvpn/tun.h b/src/openvpn/tun.h
index 902665cc6..7e8fb7647 100644
--- a/src/openvpn/tun.h
+++ b/src/openvpn/tun.h
@@ -315,16 +315,6 @@ void check_subnet_conflict(const in_addr_t ip,
 
 void warn_on_use_of_common_subnets(openvpn_net_ctx_t *ctx);
 
-/*
- * Inline functions
- */
-
-static inline void
-tun_adjust_frame_parameters(struct frame *frame, int size)
-{
-    frame_add_to_extra_tun(frame, size);
-}
-
 /*
  * Should ifconfig be called before or after
  * tun dev open?
-- 
2.30.1


