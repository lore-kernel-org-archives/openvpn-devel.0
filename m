From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Aug 2022 15:06:57 +0200
Message-Id: <20220812130657.29899-11-a@...2181...>
In-Reply-To: <20220812130657.29899-1-a@...2181...>
References: <20220812130657.29899-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v100 10/10] dco: move message to DCO debug
 level and reword a bit
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

This message is purely a debug message, so it should go to the
appropriate log level. At the same time make it more clear.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco_linux.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index 9212339e..98e10507 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -760,7 +760,8 @@ ovpn_handle_msg(struct nl_msg *msg, void *arg)
     uint32_t ifindex = nla_get_u32(attrs[OVPN_ATTR_IFINDEX]);
     if (ifindex != dco->ifindex)
     {
-        msg(D_DCO, "ovpn-dco: received message type %d with mismatched ifindex %d\n",
+        msg(D_DCO_DEBUG,
+            "ovpn-dco: ignoring message (type=%d) for foreign ifindex %d",
             gnlh->cmd, ifindex);
         return NL_SKIP;
     }
-- 
2.35.1


