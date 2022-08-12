From: Antonio Quartulli <a@...2181...>
Date: Fri, 12 Aug 2022 15:06:55 +0200
Message-Id: <20220812130657.29899-9-a@...2181...>
In-Reply-To: <20220812130657.29899-1-a@...2181...>
References: <20220812130657.29899-1-a@...2181...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH v100 08/10] ovpn-dco: print some netlink
 messages to debug level
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

Netlink errors detected during dco availability detection are not really
required and can confuse the user.
Have them printed to the dco debug level.

Signed-off-by: Antonio Quartulli <a@...2181...>
---
 src/openvpn/dco_linux.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/dco_linux.c b/src/openvpn/dco_linux.c
index f86ea819..9212339e 100644
--- a/src/openvpn/dco_linux.c
+++ b/src/openvpn/dco_linux.c
@@ -913,7 +913,7 @@ nla_put_failure:
 bool
 dco_available(int msglevel)
 {
-    if (resolve_ovpn_netlink_id(msglevel) < 0)
+    if (resolve_ovpn_netlink_id(D_DCO_DEBUG) < 0)
     {
         msg(msglevel,
             "Note: Kernel support for ovpn-dco missing, disabling data channel offload.");
-- 
2.35.1


