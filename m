From: Antonio Quartulli <a@...2181...>
Date: Mon, 13 Sep 2021 16:45:31 +0200
Message-Id: <20210913144531.8889-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] multi: remove extra brackets in
 multi_process_incoming_link()
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

After getting rid of all PF related ifdef blocks, a pair of
useless brackets has remained in multi_process_incoming_link().
These brackets do nothing at the moment and can be just removed.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/multi.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 3453d6aa..103e882e 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3250,10 +3250,8 @@ multi_process_incoming_link(struct multi_context *m, struct multi_instance *inst
                                 /* if dest addr is a known client, route to it */
                                 if (mi)
                                 {
-                                    {
-                                        multi_unicast(m, &c->c2.to_tun, mi);
-                                        register_activity(c, BLEN(&c->c2.to_tun));
-                                    }
+                                    multi_unicast(m, &c->c2.to_tun, mi);
+                                    register_activity(c, BLEN(&c->c2.to_tun));
                                     c->c2.to_tun.len = 0;
                                 }
                             }
-- 
2.32.0


