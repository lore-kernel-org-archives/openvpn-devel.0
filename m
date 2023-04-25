From: Arne Schwabe <arne@...1227...>
Date: Tue, 25 Apr 2023 12:20:21 +0200
Message-Id: <20230425102021.1041755-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v2] Add missing check for nl_socket_alloc
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

Patch V2: add goto error

Change-Id: Iee66caa794d267ac5f8bee584633352893047171
Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco_linux.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 41540c0f8..95fe94848 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -83,6 +83,13 @@ resolve_ovpn_netlink_id(int msglevel)
     int ret;
     struct nl_sock *nl_sock = nl_socket_alloc();
 
+    if (!nl_sock)
+    {
+        msg(msglevel, "Allocating net link socket failed");
+        ret = -1;
+        goto err_sock;
+    }
+
     ret = genl_connect(nl_sock);
     if (ret)
     {
-- 
2.37.1 (Apple Git-137.1)


