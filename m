From: Antonio Quartulli <a@...2181...>
Date: Wed, 16 Aug 2023 01:15:55 +0200
Message-ID: <20230815231555.6465-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: fix crash when --multihome is used
 with --proto tcp
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

Although it's a combination of options that is not really useful,
when specifying --multihome along with --proto tcp and DCO is enabled,
OpenVPN will crash while attempting to access c2.link_socket_actual
(NULL for the TCP case) in order to retrieve the local address (in
function dco_multi_get_localaddr())

Prevent crash by running this code only if proto is UDP.
The same check is already performed in socket.c/h for the non-DCO
case.

Fixes: https://github.com/OpenVPN/openvpn/issues/390
Change-Id: I61adc26ce2ff737e020c3d980902a46758cb23e5
Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/dco.c b/src/openvpn/dco.c
index 7c7eaac4..cd3e0ad3 100644
--- a/src/openvpn/dco.c
+++ b/src/openvpn/dco.c
@@ -509,7 +509,7 @@ dco_multi_get_localaddr(struct multi_context *m, struct multi_instance *mi,
 #if ENABLE_IP_PKTINFO
     struct context *c = &mi->context;
 
-    if (!(c->options.sockflags & SF_USE_IP_PKTINFO))
+    if (!proto_is_udp(c->c2.link_socket->info.proto) || !(c->options.sockflags & SF_USE_IP_PKTINFO))
     {
         return false;
     }
-- 
2.41.0


