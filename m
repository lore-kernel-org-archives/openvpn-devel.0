From: Antonio Quartulli <a@...2181...>
Date: Sat,  3 Apr 2021 17:59:37 +0200
Message-Id: <20210403155937.32330-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] tun.c: remove unused variable
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
Cc: Antonio Quartulli <antonio@...515...>

From: Antonio Quartulli <antonio@...515...>

Signed-off-by: Antonio Quartulli <antonio@...515...>
---
 src/openvpn/tun.c | 1 -
 1 file changed, 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index 6b7c8ef1..60a3a179 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -281,7 +281,6 @@ out:
 static bool
 do_set_mtu_service(const struct tuntap *tt, const short family, const int mtu)
 {
-    DWORD len;
     bool ret = false;
     ack_message_t ack;
     struct gc_arena gc = gc_new();
-- 
2.26.3


