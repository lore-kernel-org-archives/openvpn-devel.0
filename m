From: Sabrina Dubroca <sd@...2891...>
Date: Mon, 14 Jul 2025 16:20:02 +0200
Message-ID: <aee74fd22d63489ee9c3256bb3391edc337673bd.1752501854.git.sd@...2891...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH ovpn] net: ovpn: use correct array size to
 parse nested attributes in ovpn_nl_key_swap_doit
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
Cc: Sabrina Dubroca <sd@...2891...>, Antonio Quartulli <antonio@...515...>

In ovpn_nl_key_swap_doit, the attributes array used to parse the
OVPN_A_KEYCONF uses OVPN_A_PEER_MAX instead of
OVPN_A_KEYCONF_MAX. Note that this does not cause any bug, since
currently OVPN_A_KEYCONF_MAX < OVPN_A_PEER_MAX.

Fixes: 203e2bf55990 ("ovpn: implement key add/get/del/swap via netlink")
Signed-off-by: Sabrina Dubroca <sd@...2891...>
---
This patch is not urgent since the array ends up being too big for our
needs, so there is no bug.

 drivers/net/ovpn/netlink.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/net/ovpn/netlink.c b/drivers/net/ovpn/netlink.c
index a4ec53def46e..655f9d674d57 100644
--- a/drivers/net/ovpn/netlink.c
+++ b/drivers/net/ovpn/netlink.c
@@ -1027,7 +1027,7 @@ int ovpn_nl_key_get_doit(struct sk_buff *skb, struct genl_info *info)
 int ovpn_nl_key_swap_doit(struct sk_buff *skb, struct genl_info *info)
 {
 	struct ovpn_priv *ovpn = info->user_ptr[0];
-	struct nlattr *attrs[OVPN_A_PEER_MAX + 1];
+	struct nlattr *attrs[OVPN_A_KEYCONF_MAX + 1];
 	struct ovpn_peer *peer;
 	u32 peer_id;
 	int ret;
-- 
2.50.0


