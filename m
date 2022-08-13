From: Antonio Quartulli <a@...2181...>
Date: Sat, 13 Aug 2022 23:39:20 +0200
Message-Id: <20220813213920.18959-1-a@...2181...>
In-Reply-To: <20220813204224.22576-6-a@...2181...>
References: 
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v102 6/7] dco-win: ensure the DCO API is not
 used when running on Windows
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

On Windows the high level API should still use the link_socket object to
read and write packets. For this reason, even if dco_installed is true,
we still need to rely on the classic link_socket object.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
Changes from v101:
* add defined(TARGET_FREEBSD) to the #if guard

Changes from v100:
* removed ASSERTs (moved to previous patch)
* improve comment text in forward.c
---
 src/openvpn/forward.c | 22 +++++++++++++++++++++-
 1 file changed, 21 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/forward.c b/src/openvpn/forward.c
index f6d416a3..8b95af64 100644
--- a/src/openvpn/forward.c
+++ b/src/openvpn/forward.c
@@ -1601,6 +1601,26 @@ process_ip_header(struct context *c, unsigned int flags, struct buffer *buf)
     }
 }
 
+/* Linux-like DCO implementations pass the socket to the kernel and
+ * disallow usage of it from userland, so (control) packets sent and
+ * received by OpenVPN need to go through the DCO interface.
+ *
+ * Windows DCO needs control packets to be sent via the normal
+ * Socket API.
+ *
+ * Hide that complexity (...especially if more platforms show up
+ * in future...) in a small inline function.
+ */
+static bool
+should_use_dco_socket(struct link_socket *sock)
+{
+#if defined(TARGET_LINUX) || defined(TARGET_FREEBSD)
+    return sock->info.dco_installed;
+#else
+    return false;
+#endif
+}
+
 /*
  * Input: c->c2.to_link
  */
@@ -1674,7 +1694,7 @@ process_outgoing_link(struct context *c)
                 socks_preprocess_outgoing_link(c, &to_addr, &size_delta);
 
                 /* Send packet */
-                if (c->c2.link_socket->info.dco_installed)
+                if (should_use_dco_socket(c->c2.link_socket))
                 {
                     size = dco_do_write(&c->c1.tuntap->dco,
                                         c->c2.tls_multi->peer_id,
-- 
2.35.1


