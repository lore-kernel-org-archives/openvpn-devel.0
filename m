From: Antonio Quartulli <a@...2181...>
Date: Thu, 12 Jan 2023 00:50:52 +0100
Message-Id: <20230111235052.24855-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] dco: print proper message in case of
 transport disconnection
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

Signed-off-by: Antonio Quartulli <a@...2181...>
---
--no-verify is required upon commit due to changes in ovpn_dco_linux.h

Little logging improvement for https://github.com/OpenVPN/ovpn-dco/issues/9
---
 src/openvpn/multi.c          | 4 ++++
 src/openvpn/ovpn_dco_linux.h | 5 +++--
 2 files changed, 7 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/multi.c b/src/openvpn/multi.c
index 77dcaa60..99123c39 100644
--- a/src/openvpn/multi.c
+++ b/src/openvpn/multi.c
@@ -3244,6 +3244,10 @@ process_incoming_del_peer(struct multi_context *m, struct multi_instance *mi,
             reason = "ovpn-dco: transport error";
             break;
 
+        case OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT:
+            reason = "ovpn-dco: transport disconnected";
+            break;
+
         case OVPN_DEL_PEER_REASON_USERSPACE:
             /* We assume that is ourselves. Unfortunately, sometimes these
              * events happen with enough delay that they can have an order of
diff --git a/src/openvpn/ovpn_dco_linux.h b/src/openvpn/ovpn_dco_linux.h
index beca1beb..f9a3b827 100644
--- a/src/openvpn/ovpn_dco_linux.h
+++ b/src/openvpn/ovpn_dco_linux.h
@@ -1,8 +1,8 @@
-/* SPDX-License-Identifier: GPL-2.0-only WITH Linux-syscall-note */
+/* SPDX-License-Identifier: GPL-2.0 WITH Linux-syscall-note */
 /*
  *  OpenVPN data channel accelerator
  *
- *  Copyright (C) 2019-2021 OpenVPN, Inc.
+ *  Copyright (C) 2019-2022 OpenVPN, Inc.
  *
  *  Author:	James Yonan <james@...515...>
  *		Antonio Quartulli <antonio@...515...>
@@ -85,6 +85,7 @@ enum ovpn_del_peer_reason {
 	OVPN_DEL_PEER_REASON_USERSPACE,
 	OVPN_DEL_PEER_REASON_EXPIRED,
 	OVPN_DEL_PEER_REASON_TRANSPORT_ERROR,
+	OVPN_DEL_PEER_REASON_TRANSPORT_DISCONNECT,
 	__OVPN_DEL_PEER_REASON_AFTER_LAST
 };
 
-- 
2.38.2


