From: selva.nair@...277...
Date: Wed, 22 Mar 2023 11:15:50 -0400
Message-Id: <20230322151550.1596669-1-selva.nair@...277...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Make error in setting metric for IPv6
 interface non-fatal
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

From: Selva Nair <selva.nair@...277...>

- Unfortunately there are still users out there who disable IPv6
  on tun/tap/dco interfaces or even system-wide.

Fixes: Github issue #294
Signed-off-by: Selva Nair <selva.nair@...277...>
---
 src/openvpnserv/interactive.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/src/openvpnserv/interactive.c b/src/openvpnserv/interactive.c
index a3d43752..98a42b1f 100644
--- a/src/openvpnserv/interactive.c
+++ b/src/openvpnserv/interactive.c
@@ -847,8 +847,8 @@ AddBlockDNS(const block_dns_message_t *msg, undo_lists_t *lists)
                                        BLOCK_DNS_IFACE_METRIC);
             if (!err)
             {
-                err = set_interface_metric(msg->iface.index, AF_INET6,
-                                           BLOCK_DNS_IFACE_METRIC);
+                set_interface_metric(msg->iface.index, AF_INET6,
+                                     BLOCK_DNS_IFACE_METRIC);
             }
             if (err)
             {
-- 
2.34.1


