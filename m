From: Arne Schwabe <arne@...1227...>
Date: Tue, 21 Jun 2022 18:16:44 +0200
Message-Id: <20220621161649.2872985-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/6] Remove leftover frame_set_mtu_dynamic
 definitions in mtu.h
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

The frame_set_mtu_dynamic function and it defines were removed during
the buffer rework but this definitions were overlooked.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/mtu.h | 10 ----------
 1 file changed, 10 deletions(-)

diff --git a/src/openvpn/mtu.h b/src/openvpn/mtu.h
index 7f967e066..4b8feca7c 100644
--- a/src/openvpn/mtu.h
+++ b/src/openvpn/mtu.h
@@ -253,16 +253,6 @@ unsigned int
 calc_packet_id_size_dc(const struct options *options,
                        const struct key_type *kt);
 
-
-/*
- * frame_set_mtu_dynamic and flags
- */
-
-#define SET_MTU_TUN         (1<<0) /* use tun/tap rather than link sizing */
-#define SET_MTU_UPPER_BOUND (1<<1) /* only decrease dynamic MTU */
-
-void frame_set_mtu_dynamic(struct frame *frame, int mtu, unsigned int flags);
-
 /*
  * allocate a buffer for socket or tun layer
  */
-- 
2.32.1 (Apple Git-133)


