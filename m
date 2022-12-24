From: Arne Schwabe <arne@...1227...>
Date: Sat, 24 Dec 2022 20:42:50 +0100
Message-Id: <20221224194253.3202231-7-arne@...1227...>
In-Reply-To: <20221224194253.3202231-1-arne@...1227...>
References: <20221224194253.3202231-1-arne@...1227...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 6/9] Do not set nl socket buffer size
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

libnl increases the sizes we pass to 8192 anyway. Currently when we have
a lot of events queued we might run into a NLE_NOMEM message and that
terminates the server. So rather let the kernel decide the buffer sizes.

Signed-off-by: Arne Schwabe <arne@...1227...>
---
 src/openvpn/dco_linux.c | 3 ---
 1 file changed, 3 deletions(-)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 222537fc1..d4bca555d 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -348,9 +348,6 @@ ovpn_dco_init_netlink(dco_context_t *dco)
         msg(M_ERR, "Cannot create netlink socket");
     }
 
-    /* TODO: Why are we setting this buffer size? */
-    nl_socket_set_buffer_size(dco->nl_sock, 8192, 8192);
-
     int ret = genl_connect(dco->nl_sock);
     if (ret)
     {
-- 
2.37.1 (Apple Git-137.1)


