From: Gert Doering <gert@...1296...>
Date: Fri, 13 Jan 2023 09:07:45 +0100
Message-Id: <20230113080745.82783-1-gert@...1296...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Fix
 OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT breakage on FreeBSD+DCO
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

commit 67c4eebdae introduces a new peer disconnect reason (transport
disconnected, aka "TCP session closed") which breaks compilation on
FreeBSD - OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT not part of the
enum in freebsd_dco.h, and no kernel support for TCP anyway.

This patch is an intermediate bandaid, making the offending code in
multi.c "linux only" while a better solution is discussed.

Signed-off-by: Gert Doering <gert@...1296...>
---
 src/openvpn/multi.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 99123c39..f2559016 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3244,9 +3244,12 @@ process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,
             reason = "ovpn-dco: transport error";
             break;
 
+#ifdef TARGET_LINUX
+        /* FIXME: this is linux-only today and breaks FreeBSD compilation */
         case OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT:
             reason = "ovpn-dco: transport disconnected";
             break;
+#endif
 
         case OVPN_DEL_PEER_REASON_USERSPACE:
             /* We assume that is ourselves. Unfortunately, sometimes these
-- 
2.38.1


