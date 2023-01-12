From: Arne Schwabe <arne@...1227...>
Date: Thu, 12 Jan 2023 17:37:37 +0100
Message-Id: <20230112163737.1240059-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Workaround: make ovpn-dco more reliable
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

This workaround avoids the kernel trigger ENOBUFS when the kernel
internal queue is overrun with events of disconnectingh clients or
similar. This is a workaround until we come up with a more permanent
solution.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco_linux.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 5524cdbcd..c84f9cfe1 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -375,6 +375,11 @@ ovpn_dco_init_netlink(dco_context_t *dco)
      * wrong sequence numbers (NLE_SEQ_MISMATCH), so disable libnl's sequence
      * number check */
     nl_socket_disable_seq_check(dco->nl_sock);
+
+    /* nl library sets the buffer size to 32k/32k by default which is sometimes
+     * overrun with very fast connecting/disconnecting clients.
+     * TODO: fix this in a better and more reliable way */
+    ASSERT(!nl_socket_set_buffer_size(dco->nl_sock, 1024*1024, 1024*1024));
 }
 
 bool
-- 
2.37.1 (Apple Git-137.1)


