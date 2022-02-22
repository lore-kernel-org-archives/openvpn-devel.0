From: Kristof Provost <kprovost@...2661...>
Date: Tue, 22 Feb 2022 14:16:56 +0100
Message-Id: <20220222131657.6616-3-kprovost@...2661...>
In-Reply-To: <20220222131657.6616-1-kprovost@...2661...>
References: <20220222131657.6616-1-kprovost@...2661...>
MIME-Version: 1.0
Subject: [Openvpn-devel] [PATCH 2/3] open_tun_generic(): Do not consider
 open_tun_dco() returning 0 to be an error
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

It seems clear that the intent here is to special case the EEXIST error,
not the consider anything else (i.e. 0) to also be an error.

Signed-off-by: Kristof Provost <kp@...1376...>
---
 src/openvpn/tun.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/src/openvpn/tun.c b/src/openvpn/tun.c
index f9ba3858..d8f2dea7 100644
--- a/src/openvpn/tun.c
+++ b/src/openvpn/tun.c
@@ -1841,7 +1841,7 @@ open_tun_generic(const char *dev, const char *dev_type, const char *dev_node,
                         dynamic_name);
                     tt->persistent_if = true;
                 }
-                else
+                else if (ret != 0)
                 {
                     msg(M_ERR, "Cannot open TUN/TAP dev %s: %d", dynamic_name, ret);
                 }
-- 
2.35.1


