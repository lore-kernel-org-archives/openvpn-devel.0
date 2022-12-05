From: Kristof Provost <kprovost@...2661...>
Date: Mon,  5 Dec 2022 17:41:02 +0100
Message-Id: <20221205164103.9190-4-kprovost@...2661...>
In-Reply-To: <20221205164103.9190-1-kprovost@...2661...>
References: <20221205164103.9190-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 3/4] Read the peer deletion reason from the
 kernel
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
To: openvpn-devel <openvpn-devel@lists.sourceforge.net>

From: Kristof Provost <kp@...1376...>

Recent FreeBSD kernels supply a reason for the OVPN_NOTIF_DEL_PEER
notification. Parse this from the nvlist so we can distinguish
user-requested removals from timeouts.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/dco_freebsd.c      | 13 +++++++++++++
 src/openvpn/ovpn_dco_freebsd.h |  5 +++++
 2 files changed, 18 insertions(+)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 2ae46589..8d7ceb70 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -529,6 +529,19 @@ dco_do_read(dco_context_t *dco)
     {
         dco->dco_del_peer_reason = OVPN_DEL_PEER_REASON_EXPIRED;
 
+        if (nvlist_exists_number(nvl, "del_reason"))
+        {
+            uint32_t reason = nvlist_get_number(nvl, "del_reason");
+            if (reason == OVPN_DEL_REASON_TIMEOUT)
+            {
+                dco->dco_del_peer_reason = OVPN_DEL_PEER_REASON_EXPIRED;
+            }
+            else
+            {
+                dco->dco_del_peer_reason = OVPN_DEL_PEER_REASON_USERSPACE;
+            }
+        }
+
         if (nvlist_exists_nvlist(nvl, "bytes"))
         {
             const nvlist_t *bytes = nvlist_get_nvlist(nvl, "bytes");
diff --git a/src/openvpn/ovpn_dco_freebsd.h b/src/openvpn/ovpn_dco_freebsd.h
index cc90111e..fec33835 100644
--- a/src/openvpn/ovpn_dco_freebsd.h
+++ b/src/openvpn/ovpn_dco_freebsd.h
@@ -38,6 +38,11 @@ enum ovpn_notif_type {
     OVPN_NOTIF_DEL_PEER,
 };
 
+enum ovpn_del_reason {
+    OVPN_DEL_REASON_REQUESTED       = 0,
+    OVPN_DEL_REASON_TIMEOUT         = 1
+};
+
 enum ovpn_key_slot {
     OVPN_KEY_SLOT_PRIMARY   = 0,
     OVPN_KEY_SLOT_SECONDARY = 1
-- 
2.38.1


