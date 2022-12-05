From: Kristof Provost <kprovost@...2661...>
Date: Mon,  5 Dec 2022 17:41:03 +0100
Message-Id: <20221205164103.9190-5-kprovost@...2661...>
In-Reply-To: <20221205164103.9190-1-kprovost@...2661...>
References: <20221205164103.9190-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 4/4] dco: cleanup FreeBSD dco_do_read()
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

Remove support for reading packets through the control interface.
FreeBSD no longer does this, so there's no point in keeping the code for
it.

While here also check that we know what type of notification we're
getting. There's currently only one, but we should check anyway.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/dco_freebsd.c | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/src/openvpn/dco_freebsd.c b/src/openvpn/dco_freebsd.c
index 8d7ceb70..b6d869b0 100644
--- a/src/openvpn/dco_freebsd.c
+++ b/src/openvpn/dco_freebsd.c
@@ -489,8 +489,7 @@ dco_do_read(dco_context_t *dco)
     struct ifdrv drv;
     uint8_t buf[4096];
     nvlist_t *nvl;
-    const uint8_t *pkt;
-    size_t pktlen;
+    enum ovpn_notif_type type;
     int ret;
 
     /* Flush any pending data from the pipe. */
@@ -518,15 +517,9 @@ dco_do_read(dco_context_t *dco)
 
     dco->dco_message_peer_id = nvlist_get_number(nvl, "peerid");
 
-    if (nvlist_exists_binary(nvl, "packet"))
-    {
-        pkt = nvlist_get_binary(nvl, "packet", &pktlen);
-        memcpy(BPTR(&dco->dco_packet_in), pkt, pktlen);
-        dco->dco_packet_in.len = pktlen;
-        dco->dco_message_type = OVPN_CMD_PACKET;
-    }
-    else
-    {
+    type = nvlist_get_number(nvl, "notification");
+    switch (type) {
+    case OVPN_NOTIF_DEL_PEER:
         dco->dco_del_peer_reason = OVPN_DEL_PEER_REASON_EXPIRED;
 
         if (nvlist_exists_number(nvl, "del_reason"))
@@ -551,6 +544,10 @@ dco_do_read(dco_context_t *dco)
         }
 
         dco->dco_message_type = OVPN_CMD_DEL_PEER;
+        break;
+    default:
+        msg(M_WARN, "Unknown kernel notification %d", type);
+        break;
     }
 
     nvlist_destroy(nvl);
-- 
2.38.1


