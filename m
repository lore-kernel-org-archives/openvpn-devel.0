From: Sergey Korolev <sergey.korolev@...2736...>
Date: Mon, 26 Jun 2023 16:09:39 +0300
Message-Id: <20230626130939.3267280-1-sergey.korolev@...2736...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco-linux: fix counter print format
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

Avoid compilation warnings on 32 bit platforms.

dco_linux.c: In function 'dco_update_peer_stat':
dco_linux.c:830:26: error: format '%lu' expects argument of type
'long unsigned int', but argument 4 has type 'counter_type'
{aka 'long long unsigned int'} [-Werror=format=]
  830 |         msg(D_DCO_DEBUG, "%s / dco_read_bytes: %lu", __func__,
      |                          ^~~~~~~~~~~~~~~~~~~~~~~~~~
  831 |             c2->dco_read_bytes);
      |             ~~~~~~~~~~~~~~~~~~
      |               |
      |               counter_type {aka long long unsigned int}

Signed-off-by: Sergey Korolev <sergey.korolev@...2736...>
---
 src/openvpn/dco_linux.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 2bfdf980..0cf36ba7 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -827,7 +827,7 @@ dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)
     if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES])
     {
         c2->dco_read_bytes = nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LINK_RX_BYTES]);
-        msg(D_DCO_DEBUG, "%s / dco_read_bytes: %lu", __func__,
+        msg(D_DCO_DEBUG, "%s / dco_read_bytes: " counter_format, __func__,
             c2->dco_read_bytes);
     }
     else
@@ -839,7 +839,7 @@ dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)
     if (tb[OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES])
     {
         c2->dco_write_bytes = nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_LINK_TX_BYTES]);
-        msg(D_DCO_DEBUG, "%s / dco_write_bytes: %lu", __func__,
+        msg(D_DCO_DEBUG, "%s / dco_write_bytes: " counter_format, __func__,
             c2->dco_write_bytes);
     }
     else
@@ -851,7 +851,7 @@ dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)
     if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES])
     {
         c2->tun_read_bytes = nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN_RX_BYTES]);
-        msg(D_DCO_DEBUG, "%s / tun_read_bytes: %lu", __func__,
+        msg(D_DCO_DEBUG, "%s / tun_read_bytes: " counter_format, __func__,
             c2->tun_read_bytes);
     }
     else
@@ -863,7 +863,7 @@ dco_update_peer_stat(struct context_2 *c2, struct nlattr *tb[], uint32_t id)
     if (tb[OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES])
     {
         c2->tun_write_bytes = nla_get_u64(tb[OVPN_GET_PEER_RESP_ATTR_VPN_TX_BYTES]);
-        msg(D_DCO_DEBUG, "%s / tun_write_bytes: %lu", __func__,
+        msg(D_DCO_DEBUG, "%s / tun_write_bytes: " counter_format, __func__,
             c2->tun_write_bytes);
     }
     else
-- 
2.30.2


