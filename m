From: Kristof Provost <kprovost@...2661...>
Date: Thu, 24 Feb 2022 17:55:56 +0100
Message-Id: <20220224165557.22060-2-kprovost@...2661...>
In-Reply-To: <20220224165557.22060-1-kprovost@...2661...>
References: <20220224165557.22060-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 1/2] dco: process DCO control packets
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

If control packets come in through the DCO interface (i.e. via
dco_do_read()) we must process them through process_incoming_link().
This doesn't currently manifest, because Linux passes control packets
through the regular socket, not via the DCO netlink interface, but other
platforms will not.

Signed-off-by: Kristof Provost <kprovost@...2661...>
---
 src/openvpn/forward.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index cd956cb3..c16f32fc 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1104,8 +1104,16 @@ process_incoming_link(struct context *c)
 static void
 process_incoming_dco(struct context *c)
 {
+    struct link_socket_info *lsi = get_link_socket_info(c);
+
     msg(M_INFO, __func__);
     dco_do_read(&c->c1.tuntap->dco);
+
+    c->c2.buf = c->c1.tuntap->dco.dco_packet_in;
+    c->c2.from = lsi->lsa->actual;
+
+    process_incoming_link(c);
+    buf_init(&c->c1.tuntap->dco.dco_packet_in, 0);
 }
 
 /*
-- 
2.35.1


