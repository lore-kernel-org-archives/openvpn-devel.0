From: Kristof Provost <kprovost@...2661...>
Date: Fri, 29 Apr 2022 19:02:33 +0200
Message-Id: <20220429170236.48239-2-kprovost@...2661...>
In-Reply-To: <20220429170236.48239-1-kprovost@...2661...>
References: <20220429170236.48239-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/4] Handle (DCO) timeouts in client mode
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

Handle the DCO driver telling us that the peer went away, even if we're
not running in multi-instance mode.

Signed-off-by:	Kristof Provost <kprovost@...2661...>
---
 src/openvpn/forward.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index 9ddea439..e4215b70 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1111,6 +1111,12 @@ process_incoming_dco(struct context *c)
 
     dco_do_read(dco);
 
+    if (dco->dco_message_type == OVPN_CMD_DEL_PEER)
+    {
+        trigger_ping_timeout_signal(c);
+        return;
+    }
+
     if (dco->dco_message_type != OVPN_CMD_PACKET)
     {
         msg(D_DCO_DEBUG, "%s: received message of type %u - ignoring", __func__,
-- 
2.36.0


