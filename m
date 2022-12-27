From: Arne Schwabe <arne@...1227...>
Date: Tue, 27 Dec 2022 15:02:48 +0100
Message-Id: <20221227140249.3524943-5-arne@...1227...>
In-Reply-To: <20221227140249.3524943-1-arne@...1227...>
References: <20221227140249.3524943-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2 3/4] Ignore
 OVPN_DEL_PEER_REASON_USERSPACE to avoid race conditions
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

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/multi.c | 17 +++++++++++++----
 1 file changed, 13 insertions(+), 4 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 6c6385c6e..50d88f19a 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3243,10 +3243,19 @@ process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,
             break;
 
         case OVPN_DEL_PEER_REASON_USERSPACE:
-            /* This very likely ourselves but might be another process, so
-             * still process it */
-            reason = "ovpn-dco: userspace request";
-            break;
+            /* We assume that is ourselves. UUnfortunately, sometimes these
+             * events happen with enough delay that they can have an order of
+             *
+             * dco_del_peer x
+             * [new client connecting]
+             * dco_new_peer x
+             * event from dco_del_peer arrives.
+             *
+             * if we do not ignore this we get desynced with the kernel
+             * since we assume the peer-id is free again. The other way would
+             * be to send a dco_del_peer again
+             */
+            return;
     }
 
     /* When kernel already deleted the peer, the socket is no longer
-- 
2.37.1 (Apple Git-137.1)


