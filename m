From: Arne Schwabe <arne@...1227...>
Date: Tue, 14 Feb 2023 14:56:58 +0100
Message-Id: <20230214135658.1034787-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH] Add missing check for nl_socket_alloc
 failure
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

This can happen if the memory alloc fails.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco_linux.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index c84f9cfe1..b1103c8d5 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -79,10 +79,14 @@ typedef int (*ovpn_nl_cb)(struct nl_msg *msg, void *arg);
 static int
 resolve_ovpn_netlink_id(int msglevel)
 {
-    int ret;
     struct nl_sock *nl_sock = nl_socket_alloc();
 
-    ret = genl_connect(nl_sock);
+    if (!nl_sock)
+    {
+        msg(msglevel, "Allocating net link socket failed");
+    }
+
+    int ret = genl_connect(nl_sock);
     if (ret)
     {
         msg(msglevel, "Cannot connect to generic netlink: %s",
-- 
2.37.1 (Apple Git-137.1)


